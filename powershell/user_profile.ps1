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
$PROMPT_CONFIG = Join-Path (Get-ScriptDirectory) 'spaceship.omp.json'

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
            return
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

function flget {
    if (!(Test-Path -Path ".fvm")) {
        Write-Host "FVM not found, using flutter global" -ForegroundColor Yellow
        flutter pub get
    }
    else {
        $version = (cat .\.fvm\fvm_config.json | grep flutterSdkVersion | % { "$($_.Split(":")[1])" } | % { "$($_ -replace '"', '')" } | % { "$($_ -replace ',', '')" })
        Write-Host "FVM found, using flutter local (version: $version)" -ForegroundColor Yellow
        fvm flutter pub get
    }
}

function flc {
    if (!(Test-Path -Path ".fvm")) {
        Write-Host "FVM not found, using flutter global" -ForegroundColor Yellow
        flutter clean
    }
    else {
        $version = (cat .\.fvm\fvm_config.json | grep flutterSdkVersion | % { "$($_.Split(":")[1])" } | % { "$($_ -replace '"', '')" } | % { "$($_ -replace ',', '')" })
        Write-Host "FVM found, using flutter local (version: $version)" -ForegroundColor Yellow
        fvm flutter clean
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

function emulator {
    Clear-Host
    Write-Host "Select an emulator to launch" -ForegroundColor Green
    $Menu = @{}

    (D:\Android\Sdk\emulator\emulator -list-avds | cat -n) | ForEach-Object -Begin { $i = 1 } {
        Write-Host "($i`): $_" -ForegroundColor Blue
        $Menu.add("$i", $_)
        $i++
    }

    Write-Host "Q: Press 'Q' to quit." -ForegroundColor Yellow

    $Selection = Read-Host "Please make a selection"
    if ($Selection -eq 'Q') { Return } Else { 
        Write-Host "Selected $($Menu.$Selection)" -ForegroundColor Green
        Start-Process D:\Android\Sdk\emulator\emulator -ArgumentList '-avd', "$($Menu.$Selection)", '-no-audio' 2>&1>$null
    }
}