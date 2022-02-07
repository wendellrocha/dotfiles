# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

function getModules() {
    if (-not(Get-Module -name Terminal-Icons)) {
        Import-Module -name Terminal-Icons
    }

    if (-not(Get-Module -name PSFzf)) {
        Import-Module -name PSFzf
    }

    if (-not(Get-Module -name posh-git)) {
        Import-Module -name posh-git
    }
}

getModules

$env:POSH_GIT_ENABLED = $true
$env:AZ_ENABLED = $false

function Get-ScriptDirectory { Split-Path $MyInvocation.ScriptName }
$PROMPT_CONFIG = Join-Path (Get-ScriptDirectory) 'jandedobbeleer.omp.json'

Set-PSReadLineOption -PredictionSource History

Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

$Env:BAT_CONFIG_PATH = Join-Path (Get-ScriptDirectory) 'bat.conf'

Set-Alias grep findstr
Set-Alias cat bat
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

oh-my-posh --init --shell pwsh --config $PROMPT_CONFIG | Invoke-Expression
Enable-PoshTooltips

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

# Dracula readline configuration. Requires version 2.0, if you have 1.2 convert to `Set-PSReadlineOption -TokenType`
Set-PSReadlineOption -Color @{
    "Command"   = [ConsoleColor]::Green
    "Parameter" = [ConsoleColor]::Gray
    "Operator"  = [ConsoleColor]::Magenta
    "Variable"  = [ConsoleColor]::White
    "String"    = [ConsoleColor]::Yellow
    "Number"    = [ConsoleColor]::Blue
    "Type"      = [ConsoleColor]::Cyan
    "Comment"   = [ConsoleColor]::DarkCyan
}
# Dracula Prompt Configuration
$GitPromptSettings.DefaultPromptPrefix.Text = "$([char]0x2192) " # arrow unicode symbol
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Green
$GitPromptSettings.DefaultPromptPath.ForegroundColor = [ConsoleColor]::Cyan
$GitPromptSettings.DefaultPromptSuffix.Text = "$([char]0x203A) " # chevron unicode symbol
$GitPromptSettings.DefaultPromptSuffix.ForegroundColor = [ConsoleColor]::Magenta
# Dracula Git Status Configuration
$GitPromptSettings.BeforeStatus.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.BranchColor.ForegroundColor = [ConsoleColor]::Blue
$GitPromptSettings.AfterStatus.ForegroundColor = [ConsoleColor]::Blue

# Utilities
function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

function touch ($command) {
    New-Item $command -type file
}

function flca ($command) {
    Get-ChildItem . |
    ForEach-Object {
        if (!(Test-Path -Path "$_\pubspec.yaml" -PathType Leaf)) {
            Write-Host "Pubspec not found in $_, skipping..." -ForegroundColor Red
            continue
        }

        if (Test-Path -Path "$_\build") {
            Write-Host "Running flutter clean in $_" -ForegroundColor Yellow
            Remove-Item -Path $_\.fvm\flutter_sdk -Recurse -Force
            Set-Location $_ && flutter clean && Set-Location ..
        }
        else {
            Write-Host "Nothing to do, skipping" -ForegroundColor Blue
        }
    }
}

function export($name, $value) {
    Set-Item -Force -Path "Env:$name" -Value $value;
}

function unzip ($file) {
    $dirname = (Get-Item $file).Basename
    Write-Host "Extracting $file to $dirname" -ForegroundColor Green
    New-Item -Force -ItemType directory -Path $dirname
    Expand-Archive -Path $file -DestinationPath $dirname
}

function update-profile {
    & $profile
}