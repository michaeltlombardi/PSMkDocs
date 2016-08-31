If((Get-Command -Name "mkdocs").Count -lt 1){
    Throw "MkDocs not found in PATH; Make sure MkDocs is installed and in the PATH environmental variable!"
}

Get-ChildItem -Path $PSScriptRoot\Functions | 
    Where-Object -FilterScript {$_.Name -notmatch "\.Tests\."} |
        ForEach-Object -Process {
            . $_.FullName
        }

Export-ModuleMember -Function * -Variable * -Alias *