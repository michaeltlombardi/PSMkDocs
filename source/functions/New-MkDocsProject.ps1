function New-MkDocsProject {
    <#
        .SYNOPSIS
            Build a new MkDocs project at one or more paths.

        .DESCRIPTION
            Builds the scaffolding for a new MkDocs project at one or more paths.
            The command will place a file, mkdocs.yml at the specified path (or in
            the current directory if no path is specified).
            The command will create the path to the directory if needed.
            The command will also create a new folder, docs, in the specified patha
         and place a file, index.md in that folder.

        .PARAMETER Path
            One or more paths to a directory in which to place a new MkDocs project.
            Paths can be relative or absolute but may not contain wildcards.
            If a MkDocs project already exists at the path it will _not_ overwrite the existing project.

        .INPUTS
            System.String
            You can pipe in one or more paths to New-MkDocsProject. 

        .OUTPUTS
            System.Object
            New-MkDocsProject returns an array of objects representing the created files and folders.

        .EXAMPLE
            New-MkDocsProject

            This creates the scaffolding for a new mkdocs project in the current directory.

        .EXAMPLE
            New-MkDocsProject -Path C:\MyProject

            This creates the scaffolding for a new MkDocs project in C:\MyProject.
            If this folder does not exist, the command will create it.

        .EXAMPLE
            New-MkDocsProject -Path .\MyProject

            This creates the scaffolding for a new MkDocs project in the MyProject folder in the current directory.
            If this folder does not exist, the command will create it.
        
        .LINK
            about_MkDocs_Projects
    #>

    [cmdletbinding()]
    Param (
        # Specifies a path to one or more locations.
        [Parameter(Mandatory=$false,
                   Position=0,
                   ParameterSetName="Path",
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true)]
        [Alias("PSPath")]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Path
    )

    Begin {
        [scriptblock]$NewSite = {
            [cmdletbinding()]
            Param (
                $Path
            )
            # The error output of MkDocs needs to be redirected to a file and then parsed for verbose/error messages.
            # This is because Python logs info and error messages both to the error stream.
            $Log = "$env:temp\mkdocs-new-$((new-Guid | Select-Object -ExpandProperty guid).trim()).log"
            $Process = Start-Process -FilePath mkdocs -ArgumentList "new $Path" -NoNewWindow -PassThru -Wait -RedirectStandardError $Log
            
            # For Some reason, the script doesn't actually wait for the process to conclude.
            Start-Sleep -Seconds 2
            $ExitCode = $Process | Select-Object -ExpandProperty ExitCode 
            
            ForEach($Message in (Get-Content $Log)){
                If($Message -match "^INFO"){
                    Write-Verbose ($Message.Split('-')[1].Trim())
                } ElseIf (! [string]::IsNullOrWhiteSpace($Message)){
                    Write-Error $Message
                }
            }
            Remove-Item -Path $Log -Force
            
            If($ExitCode -eq 0){
                Get-Item $Path\mkdocs.yml,$Path\docs\index.md
            }
        }
    }

    Process {
        ForEach($SpecificPath in $Path){
            Invoke-Command -ScriptBlock $NewSite -ArgumentList $SpecificPath
        }
        # If no path is specified, MkDocs will build in the current directory.
        If ([string]::IsNullOrEmpty($Path)) {
            Invoke-Command -ScriptBlock $NewSite -ArgumentList .
        }
    }
}

Set-Alias -Name nmkdp -Value New-MkDocsProject