<#
.SYNOPSIS
    Build WinMLRunner.vcxproj via MSBuild (Visual Studio 2017 or later is required)
.PARAMETER Verbose
    Show the intermediate messages for debug purposes
#>
param
(
    # Build architecture.
    [ValidateSet('x64', 'x86', 'ARM', 'ARM64')][string]$Architecture = 'x64',

    # Build configuration.
    [ValidateSet('Debug', 'Release')][string]$Configuration = 'Debug',

    # Writes all intermediate messages
    [switch]$Verbose
)

if ($Verbose)
{
    $VerbosePreference = 'Continue'
    Write-Verbose 'Verbose mode activated'
}

Write-Host "Building WinMLRunner solution with Configuration=$Configuration and Architecture=$Architecture"

$MyPath = $MyInvocation.MyCommand.Path
$MyDirectory = Split-Path $MyPath
$MsBuildPath = & "$MyDirectory\FindMSBuild.ps1"

& $MsBuildPath "$MyDirectory\..\WinMLRunner.sln" "/p:Configuration=$Configuration" "/p:Platform=$Architecture"