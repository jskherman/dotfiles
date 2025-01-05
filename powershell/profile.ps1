# Remember to set environment variable `JSKHOME` to your root workspace directory

# ==== Powershell Theme ==== #
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\clean-detailed.omp.json" | Invoke-Expression
# half-life, cert, emodipt-extend, clean-detailed, free-ukraine, hul10, takuya, material, slim

# ==== Import the Chocolatey Profile ==== #
# This contains the necessary code to enable tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function. See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# ==== Enable autocomplete commands ==== #
# . "$PSScriptRoot\deta.ps1"
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# ==== Custom Aliases ==== #
Set-Alias -Name touch -Value New-Item
Set-Alias -Name which -Value Get-Command
Set-Alias flyctl "$env:USERPROFILE\.fly\bin\flyctl.exe"
Set-Alias fly "$env:USERPROFILE\.fly\bin\flyctl.exe"
# Set-Alias pnpm "$env:USERPROFILE\AppData\Local\Microsoft\WinGet\Packages\pnpm.pnpm_Microsoft.Winget.Source_8wekyb3d8bbwe\pnpm-win-x64.exe"
# Set-Alias chrome "$env:LOCALAPPDATA\Chromium\Application\chrome.exe"
Set-Alias ripgrep "rg"

# function inkscape {
#     wsl /usr/bin/inkscape $args
# }

#### Neovim ####
function vim { $env:NVIM_APPNAME = 'nvim'; neovide $args }

# $env:NVIM_APPNAME = 'nvim'
# function vt { $env:NVIM_APPNAME = 'nvim'; nvim $args }
# function vg { $env:NVIM_APPNAME = 'nvim'; neovide $args }

# ==== Custom Functions ==== #
function Check-Admin {
    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    if ($currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
        # The user is an administrator, continue with the rest of the function
        return $true
    } else {
        # The user is not an administrator, print a message and exit
        Write-Host "`nError: this function requires admin privileges.`nPlease run PowerShell as an administrator and try again."
        return $false
    }
}

# Git add, commit, push
function gitacp { git add .; git commit -m "$args"; git push}

# Deface image with solid color, deface at https://github.com/ORB-HD/deface
function censorf { deface "$args" --boxes --replacewith solid -o "$args"}

# Rich text preview with emoji support, mostly for markdown files
function rview { rich "$args" --emoji -y -w 90}

# Python pip freeze to file in UTF8 encoding
function pipf { python -m pip freeze | Out-File -Encoding UTF8 "$args"}

function winutil {
  irm "https://christitus.com/win" | iex
}

function 1dmount {
    param (
        [string]$Path = ''
    )

    if ($Path -ne '') {
        $remotePath = "onedrive:$Path"
    } else {
        $remotePath = "onedrive:"
    }

    rclone mount --vfs-cache-mode full --onedrive-delta --network-mode $remotePath "O:"
}

function gdmount {
    param (
        [string]$Path = ''
    )

    if ($Path -eq '1') {
      $remotePath = "gd:Board Review/ARC／Reg-M2024 [IN-PERSON]"
    } elseif ($Path -ne '') {
      $remotePath = "gd:$Path"
    } else {
      $remotePath = "gd:"
    }

    rclone mount --vfs-cache-mode full --network-mode $remotePath "G:"
}

# change directory Alias
function Set-LocationKeyword {
    param (
        [string]$Keyword
    )

    switch ($Keyword) {
        "~" { Set-Location "$ENV:JSKHOME" }
        "home" { Set-Location "$ENV:JSKHOME" }
        "dev" { Set-Location "$ENV:JSKHOME\dev" }
        "dotf" { Set-Location "$ENV:JSKHOME\dev\dotfiles" }
        "dotfiles" { Set-Location "$ENV:JSKHOME\dev\dotfiles" }
        "dl"   { Set-Location "$ENV:USERPROFILE\Downloads" }
        "desk" { Set-Location "$ENV:USERPROFILE\Desktop" }
        "desktop" { Set-Location "$ENV:USERPROFILE\Desktop" }
        "pics" { Set-Location "$ENV:USERPROFILE\Pictures" }
        "docs" { Set-Location "$ENV:USERPROFILE\Documents" }
        "vids" { Set-Location "$ENV:USERPROFILE\Videos" }
        "archive" { Set-Location "$env:JSKHOME\_archive" }
        "brain2" { Set-Location "$ENV:JSKHOME\brain2" }
        "notes" { Set-Location "$ENV:JSKHOME\brain2" }
        "history" { Set-Location "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\" }
        default { Set-Location $Keyword }
    }
}

# Create an alias for 'cd' to use our custom function
Set-Alias -Name nav -Value Set-LocationKeyword -Option AllScope

function notify {
  param (
    [string]$Message
  )

  $creds = "$($env:NTFY_USERNAME):$($env:NTFY_PASSWORD)"
  $headers = @{
    Authorization = 'Basic ' + [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes($creds))
  }

  try {
    $response = Invoke-RestMethod -Uri 'https://ntfy.jskherman.com/000-alerts' -Method Post -Headers $headers -Body $Message -ErrorAction Stop
    if ($response -ne $null) {
      Write-Output '200 OK'
    }
  } catch {
    $statusCode = $_.Exception.Response.StatusCode.Value__
    $statusDescription = $_.Exception.Response.StatusDescription
    $responseBody = $_.Exception.Response.Content
    Write-Output "Error: $statusCode $statusDescription`n$responseBody"
  }
}

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



# # Convert videos to various formats
# function convert-vid {
#     [CmdletBinding()]
#     param (
#         [Parameter(Mandatory = $true)]
#         [string]$in,
#         [ValidateSet('MP4', 'GIF', 'WEBM', 'MKV', 'MP3')]
#         [string]$format = 'MP4',
#         [int]$res = 720
#     )

#     # Set the output file name and extension based on the input file name
#     $out = [System.IO.Path]::ChangeExtension($in, ".$format")

#     if (-not (Test-Path $in)) {
#         Write-Error "Input file '$in' not found."
#         return
#     }

#     # Choose the appropriate codec based on the output format
#     switch ($format.ToUpper()) {
#         'GIF' { $codec = 'gif' }
#         'MKV' { $codec = 'libx265' }
#         'MP3' { $codec = 'libmp3lame' }
#         'WEBM' { $codec = 'libvpx-vp9' }
#         default { $codec = 'libx265' }
#     }

#     $ffmpegArgs = @("-i", "$in", "-c:v", $codec, "-preset", "faster", "-crf", "28", "-threads", "2", "-vf", "scale=-2:$res", "-y", "$out")

#     try {
#         & ffmpeg.exe $ffmpegArgs
#     } catch {
#         Write-Error "Failed to convert video: $_"
#     }
# }

# Convert videos to various formats
function convert-vid {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$in,
        [string]$out = $null,
        [ValidateSet('mp4', 'gif', 'webm', 'mkv', 'mp3')]
        [string]$format = 'MP4',
        [int]$res = 720,
        [int]$fps = 15
    )

    # Example Usage
    # convert-vid -in "E:\OneDrive\Videos\video.webm" -format GIF -res 720 -fps 15

    if (-not (Test-Path $in)) {
        Write-Error "Input file '$in' not found."
        return
    }

    if (!$out) {
        $out = [System.IO.Path]::ChangeExtension($in, ".$format")
    }

    # Define the output file extension based on the specified format
    switch ($format.ToLower()) {
        'gif' { $ffmpegArgs = @("-i", "$in", "-vf", "scale=-2:$res", "-r", "$fps", "-f", "gif", "-y", "$out") }
        'mkv' { $ffmpegArgs = @("-i", "$in", "-c:v", "libx265", "-preset", "faster", "-crf", "28", "-threads", "2", "-vf", "scale=-2:$res", "-c:a", "aac", "-b:a", "128k", "-bufsize", "8M", "-x265-params", "ref=5", "-y", "$out") }
        'mp3' { $ffmpegArgs = @("-i", "$in", "-vn", "-b:a", "128k", "-bufsize", "8M", "-y", "$out") }
        'webm' { $ffmpegArgs = @("-i", "$in", "-c:v", "libvpx-vp9", "-b:v", "2M", "-vf", "scale=-2:$res", "-c:a", "libopus", "-b:a", "128k", "-bufsize", "8M", "-y", "$out") }
        default { $ffmpegArgs = @("-i", "$in", "-c:v", "libx265", "-preset", "faster", "-crf", "28", "-threads", "2", "-vf", "scale=-2:$res", "-c:a", "aac", "-b:a", "128k", "-bufsize", "8M", "-x265-params", "ref=5", "-y", "$out") }
    }

    try {
        & ffmpeg $ffmpegArgs
    } catch {
        Write-Error "Failed to convert video: $_"
    }
}
