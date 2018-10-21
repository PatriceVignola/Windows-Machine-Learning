<#
.SYNOPSIS
    Finds the path to MSBuild.exe (Visual Studio 2017 or later is required)
.PARAMETER Verbose
    Show the intermediate messages for debug purposes
.OUTPUTS
    Absolute path to MSBuild.exe
#>
param
(
    # Writes all intermediate messages
    [switch]$Verbose
)

Write-Host 'Running FindMSBuild.ps1'
Write-Host 'Looking for MSBuild.exe...'

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

$InstallPath = & $VsWherePath '-latest' '-requires' 'Microsoft.Component.MSBuild' '-property' 'installationPath'

if (-not (Test-Path $InstallPath))
{
    throw 'Could not find MSBuild from any Visual Studio installation. Please make sure that it is installed.'
}

Write-Verbose "Found Visual Studio installation: $InstallPath"
Write-Verbose 'Looking for MSBuild...'

$MsBuildPath = "$InstallPath\MSBuild\15.0\Bin\MSBuild.exe"

if (-not (Test-Path $MsBuildPath))
{
    throw 'Could not find MSBuild.exe. Please make sure that Visual Studio 2017 is installed.'
}

Write-Host "Found MSBuild: $MsBuildPath"
Write-Output $MsBuildPath