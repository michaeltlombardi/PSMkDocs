---
external help file: MkDocs-help.xml
online version: 
schema: 2.0.0
---

# New-MkDocsProject
## SYNOPSIS
Build a new MkDocs project at one or more paths.

## SYNTAX

```
New-MkDocsProject [[-Path] <String[]>]
```

## DESCRIPTION
Builds the scaffolding for a new MkDocs project at one or more paths.
The command will place a file, mkdocs.yml at the specified path (or in
the current directory if no path is specified).
The command will create the path to the directory if needed.
The command will also create a new folder, docs, in the specified patha
and place a file, index.md in that folder.

## EXAMPLES

### ----------- EXAMPLE 1 -----------
```powershell
New-MkDocsProject
```

This creates the scaffolding for a new mkdocs project in the current directory.

### ----------- EXAMPLE 2 -----------
```powershell
New-MkDocsProject -Path C:\MyProject
```

This creates the scaffolding for a new MkDocs project in C:\MyProject.
If this folder does not exist, the command will create it.

### ----------- EXAMPLE 3 -----------
```powershell
New-MkDocsProject -Path .\MyProject
```

This creates the scaffolding for a new MkDocs project in the MyProject folder in the current directory.
If this folder does not exist, the command will create it.

## PARAMETERS

### -Path
One or more paths to a directory in which to place a new MkDocs project.
Paths can be relative or absolute but may not contain wildcards.
If a MkDocs project already exists at the path it will _not_ overwrite the existing project.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: PSPath

Required: False
Position: 1
Default value: 
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

## INPUTS

### System.String
You can pipe in one or more paths to New-MkDocsProject.

## OUTPUTS

### System.Object
New-MkDocsProject returns an array of objects representing the created files and folders.

## NOTES

## RELATED LINKS

[about_MkDocs_Projects](../../../concepts/MkDocs_Projects)

