[CmdletBinding()]

param($Task = 'Default')

Write-Host 'Starting build...'
Write-Host 'Installing PSDepend module if not already installed...'

# Installing PSDepend for dependency management
if (-not (Get-Module -Name PSDepend -ListAvailable)) {
    Install-Module PSDepend -Force
}
Import-Module PSDepend

Write-Host 'Installing dependencies if not already installed...'
# Installing dependencies
Invoke-PSDepend -Force

Set-BuildEnvironment

Get-ChildItem Env:BH*

Write-Host "Invoking build action [$Task]..."

Invoke-Build $Task -Result 'Result'
if ($Result.Error) {
    $Error[-1].ScriptStackTrace | Out-String
    exit 1
}

exit 0