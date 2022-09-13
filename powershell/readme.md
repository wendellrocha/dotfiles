Install-Module -Name Terminal-Icons -Repository PSGallery
choco install fzf
Install-Module -Name PSFzf
Install-Module posh-git -Scope CurrentUser -Force
choco install jq
choco install bat
scoop install sudo
winget install Git.Git
winget install JanDeDobbeleer.OhMyPosh -s winget

install font
sudo oh-my-posh font install

create profile
New-Item -Path $PROFILE -Type File -Force

New-Item -ItemType HardLink -Path "C:\Users\wende\Documents\PowerShell\spaceship.omp.json" -Target "C:\Users\wende\dotfiles\powershell\spaceship.omp.json"
New-Item -ItemType HardLink -Path "C:\Users\wende\Documents\PowerShell\bat.conf" -Target "C:\Users\wende\dotfiles\powershell\bat.conf"
New-Item -ItemType HardLink -Path "C:\Users\wende\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Target "C:\Users\wende\dotfiles\powershell\user_profile.ps1"