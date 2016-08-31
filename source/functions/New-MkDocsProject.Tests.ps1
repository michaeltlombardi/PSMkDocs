$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "New-MkDocsProject" {
    Mock Invoke-Command {return $ArgumentList}
    It "Calls MkDocs once per specified path" {
        New-MkDocsProject -Path "One","Two","Three"
        Assert-MockCalled Invoke-Command -Exactly 3 -Scope It
    }
}
