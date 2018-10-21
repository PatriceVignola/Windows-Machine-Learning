<#
.SYNOPSIS
    Run WinMLRunner's tests via VSTest (Visual Studio 2017 or later is required)
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

Write-Host "Running WinMLRunner tests with Configuration=$Configuration and Architecture=$Architecture..."

$MyPath = $MyInvocation.MyCommand.Path
$MyDirectory = Split-Path $MyPath
$TestDllPath = "$MyDirectory\..\$Architecture\$Configuration\WinMLRunnerTest.dll"

if (-not (Test-Path $TestDllPath))
{
    throw "Test DLL not found at $TestDllPath. Please build the solution for $Architecture-$Configuration before running the tests."
}

$MyPath = $MyInvocation.MyCommand.Path
$MyDirectory = Split-Path $MyPath
$VsTestPath = & "$MyDirectory\FindVSTest.ps1"

& $VsTestPath $TestDllPath