# MkDocs_Projects

## about_MkDocs_Projects

# SHORT DESCRIPTION
This topic explains the use of MkDocs Projects generally and MkDocs projects for PowerShell Modules specifically.

# LONG DESCRIPTION
MkDocs allows you to keep and write your documentation in source control and deploy that documentation as a static site for your users and developers to consume.

A MkDocs project consists of a YAML configuration file, `mkdocs.yml`, and a folder of documents written in Markdown.
The documents folder (`docs` by default) must contain at least one file, `index.md`, and may contain many files and subfolders.

## MkDocs Configuration
Every MkDocs project requires a minimal configuration which is created when you invoke the `New-MkDocsProject` command.

```yaml
site_name: My Docs
```

You should rename the site to match the project or module you are documenting.

```yaml
site_name: MkDocs PowerShell Module
```

The only other requirement for your project is to include a configuration for the pages you want the project to include:

```yaml
site_name: MkDocs PowerShell Module
pages:
    - About:                        index.md
    - Tutorials:
        - Getting Started:          tutorials/getting-started.md
    - Concepts:
        - about_MkDocs_Projects:    concepts/MkDocs_Projects.md
    - Reference:
        - Functions:
            - New-MkDocsProject:    reference/functions/New-MkDocsProject.md
            - Update-MkDocsProject: reference/functions/New-MkDocsProject.md
```

The example configuration above would build a documentation site with a default About page, a Tutorials topic with the Getting Started page, a Concepts topic with the about\_MkDocs\_Projects page, and a Reference topic with the Functions subtopic and the New-MkDocsProject and Update-MkDocsProject pages.

In practice, it is best to avoid going more than three levels deep in your layout:

```yaml
pages:
    - Topic:
        - Subtopic:
            - Tertiary_Topic:
                - Page:         topic/subtopic/tertiary_topic/page.md
```

For additional configuration options, see the [MkDocs documentation](https://www.mkdocs.org/user-guide/configuration/) on the subject.

## MkDocs Documentation Pages
Pages of documentation in MkDocs are always written in [markdown](http://daringfireball.net/projects/markdown/).
If you're generating reference documentation for PowerShell modules it is best to use the [PlatyPS](https://github.com/PowerShell/platyPS) project to convert your comment-based-help into markdown documents in your MkDocs project. 

If you find that the page for a particular topic of documentation is growing too long and detailed to place in a single page, consider breaking it up into chapters with each chapter as a separate page.

## Suggested Folder Structure for PowerShell Modules Documentation
For PowerShell projects it seems best to cover the three main types of documentation people will want to find:

1. Tutorials - Walkthroughs and real-world examples designed to get a user up and running with your module or to help a developer begin debugging or contributing to the module.
2. Concepts - Short whitepapers on topics related to your module, why design decisions were made, and the about_Topic documents that will be included with your module.
3. Reference - Documentation of the commands, classes, methods, etc which are included in your module.
It's easiest to generate this documentation via PlatyPS rather than to write it all manually.

The folder structure for this module, for example, looks like this:

```
.
├── docs/
|   ├── concepts/
|   |   └── MkDocs_Projects.md
|   ├── reference/
|   |   ├── New-MkDocsProject.md
|   |   └── Update-MkDocsProject.md
|   ├── tutorials/
|   |   └── Getting-Started.md
|   └── index.md
└── mkdocs.yml
```

# EXAMPLES
TODO

# SEE ALSO
- MkDocs
- Markdown
- Python Markdown

# KEYWORDS
- MkDocs
- Documentation

