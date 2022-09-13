### Install Chocolatey

```pwsh
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

### Install Scoop

```pwsh
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
irm get.scoop.sh | iex
```

### Install packages

```pwsh
choco install fzf
choco install jq
choco install bat
scoop install sudo
winget install Git.Git
winget install JanDeDobbeleer.OhMyPosh -s winget
Install-Module -Name Terminal-Icons -Repository PSGallery
Install-Module -Name PSFzf
Install-Module posh-git -Scope CurrentUser -Force
```

### Install font

```pwsh
sudo oh-my-posh font install
```

### Create profile

```pwsh
New-Item -Path $PROFILE -Type File -Force
```

```pwsh
New-Item -ItemType HardLink -Path "C:\Users\wende\Documents\PowerShell\spaceship.omp.json" -Target "C:\Users\wende\dotfiles\powershell\spaceship.omp.json"
New-Item -ItemType HardLink -Path "C:\Users\wende\Documents\PowerShell\bat.conf" -Target "C:\Users\wende\dotfiles\powershell\bat.conf"
New-Item -ItemType HardLink -Path "C:\Users\wende\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Target "C:\Users\wende\dotfiles\powershell\user_profile.ps1"
```
