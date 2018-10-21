<#
.SYNOPSIS
    Finds the path to vstest.console.exe (Visual Studio 2017 or later is required)
.PARAMETER Verbose
    Show the intermediate messages for debug purposes
.OUTPUTS
    Absolute path to vstest.console.exe
#>
param
(
    # Writes all intermediate messages
    [switch]$Verbose
)

Write-Host 'Running FindVSTest.ps1'
Write-Host 'Looking for vstest.console.exe...'

if ($Verbose)
{
    $VerbosePreference = 'Continue'
    Write-Verbose 'Verbose mode activated'
}

Write-Verbose 'Looking for vswhere...'

$VsWherePath = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"

if (-not (Test-Path $VsWherePath))
{
    throw 'Could not find vswhere.exe. Please make sure that Visual Studio 2017 is installed.'
}

Write-Verbose "Found vswhere: $VsWherePath"
Write-Verbose 'Looking for a viable Visual Studio Installation...'

$InstallPath = & $VsWherePath '-latest' '-requires' 'Microsoft.VisualStudio.PackageGroup.TestTools.Core' '-property' 'installationPath'

if (-not (Test-Path $InstallPath))
{
    throw 'Could not find VSTest from any Visual Studio installation. Please make sure that it is installed.'
}

Write-Verbose "Found Visual Studio installation: $InstallPath"
Write-Verbose 'Looking for vstest.console.exe...'

$VSTestPath = "$InstallPath\Common7\IDE\CommonExtensions\Microsoft\TestWindow\vstest.console.exe"

if (-not (Test-Path $VSTestPath))
{
    throw 'Could not find vstest.console.exe. Please make sure that Visual Studio 2017 is installed.'
}

Write-Host "Found VSTest: $VSTestPath"
Write-Output $VSTestPath