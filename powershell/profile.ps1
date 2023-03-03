### Powershell Theme ###
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\takuya.omp.json" | Invoke-Expression

### Import the Chocolatey Profile ###
# This contains the necessary code to enable tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function. See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

### Enable autocomplete commands ###
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

### Custom Aliases ###
New-Alias flyctl "$env:USERPROFILE\.fly\bin\flyctl.exe"
New-Alias fly "$env:USERPROFILE\.fly\bin\flyctl.exe"
New-Alias lvim "$env:USERPROFILE\.local\bin\lvim.ps1"

### Custom Functions ###
# Git add, commit, push
function gitacp { git add .; git commit -m "$args"; git push}

# Deface image with solid color, deface at https://github.com/ORB-HD/deface
function censorf { deface "$args" --boxes --replacewith solid -o "$args"}

# Rich text preview with emoji support, mostly for markdown files
function rview { rich "$args" --emoji -y -w 90}

# Python pip freeze to file in UTF8 encoding
function pipf { python -m pip freeze | Out-File -Encoding UTF8 "$args"}

# Find files from OneDrive sync conflicts
function findconflicts {
  param (
    [string[]]$IgnoreDirs = @() # An optional array of directories to exclude from the search
  )

  $baseDir = Get-Location # Get the current working directory
  $excludedPaths = $IgnoreDirs | ForEach-Object { Join-Path $baseDir $_ } # Create an array of excluded directories with their full paths

  # Get all files under the base directory recursively, and filter out files that don't match the filename pattern and files in the excluded directories
  Get-ChildItem -Recurse -File | Where-Object { $_.Name -match '(conflict \d{4}(?:-\d{2}){5})|(DESKTOP-LRMDILT)' -and ($excludedPaths | ForEach-Object { $_.ToString() }) -notcontains $_.DirectoryName }
    | Resolve-Path | Select-Object -ExpandProperty ProviderPath | ForEach-Object { $_.Substring($baseDir.ToString().Length + 1) }
}

# Function to download YouTube videos with yt-dlp
function dlyt {
  param (
    [string]$Format = "video" # The format to download the video in, either "video" or "audio"
  )

  if ($Format -eq "video") {
    yt-dlp --format "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" --sub-format "srt/best" --sub-lang en --write-sub --embed-subs --add-metadata --geo-bypass --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36" --output "E:\OneDrive\Documents\Archive\apps\youtube-dl\Downloads\%(title)s.%(ext)s" --downloader aria2c $args
  } elseif ($Format -eq "audio") {
    yt-dlp --format "bestaudio[ext=m4a]" --extract-audio --audio-format mp3 --output "E:\OneDrive\Documents\Archive\apps\youtube-dl\Downloads\%(title)s.%(ext)s" --add-metadata --geo-bypass --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36" --downloader aria2c $args
  } else {
    Write-Error "Invalid format specified. Please specify either 'video' or 'audio'."
  }
}
