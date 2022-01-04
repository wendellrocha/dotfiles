# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

function getModules() {
    if (-not(Get-Module -name Terminal-Icons)) {
        Import-Module -name Terminal-Icons
    }

    if (-not(Get-Module -name PSFzf)) {
        Import-Module -name PSFzf
    }

    if (-not(Get-Module -name  posh-git)) {
        Import-Module -name posh-git
    }
}

getModules

$env:POSH_GIT_ENABLED = $true

function Get-ScriptDirectory { Split-Path $MyInvocation.ScriptName }
$PROMPT_CONFIG = Join-Path (Get-ScriptDirectory) 'jandedobbeleer.omp.json'

Set-PSReadLineOption -PredictionSource History

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

$Env:BAT_CONFIG_PATH = Join-Path (Get-ScriptDirectory) 'bat.conf'

Set-Alias grep findstr
Set-Alias cat bat
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

oh-my-posh --init --shell pwsh --config $PROMPT_CONFIG | Invoke-Expression

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

# Utilities
function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}