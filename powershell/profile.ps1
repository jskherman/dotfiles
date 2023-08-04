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
. E:\OneDrive\Documents\Workspace\dotfiles\powershell\deta.ps1
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

### Custom Aliases ###
New-Alias flyctl "$env:USERPROFILE\.fly\bin\flyctl.exe"
New-Alias fly "$env:USERPROFILE\.fly\bin\flyctl.exe"
New-Alias lvim "$env:USERPROFILE\.local\bin\lvim.ps1"
New-Alias pnpm "$env:USERPROFILE\AppData\Local\Microsoft\WinGet\Packages\pnpm.pnpm_Microsoft.Winget.Source_8wekyb3d8bbwe\pnpm-win-x64.exe"

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
    yt-dlp --format "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" --sub-format "srt/best" --sub-lang en --write-sub --embed-subs --add-metadata --geo-bypass --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36" --output "E:\OneDrive\Documents\Archive\apps\youtube-dl\Downloads\%(title)s.%(ext)s" --downloader aria2c $args #--cookies "E:\OneDrive\Documents\Archive\apps\youtube-dl\cookies.txt"
  } elseif ($Format -eq "audio") {
    yt-dlp --format "ba" --extract-audio --audio-format mp3 --output "E:\OneDrive\Documents\Archive\apps\youtube-dl\Downloads\%(title)s.%(ext)s" --add-metadata --geo-bypass --user-agent "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36" --downloader aria2c $args #--cookies "E:\OneDrive\Documents\Archive\apps\youtube-dl\cookies.txt"
  } else {
    Write-Error "Invalid format specified. Please specify either 'video' or 'audio'."
  }
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
        [ValidateSet('MP4', 'GIF', 'WEBM', 'MKV', 'MP3')]
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
    switch ($format.ToUpper()) {
        'GIF' { $ffmpegArgs = @("-i", "$in", "-vf", "scale=-2:$res", "-r", "$fps", "-f", "gif", "-y", "$out") }
        'MKV' { $ffmpegArgs = @("-i", "$in", "-c:v", "libx265", "-preset", "faster", "-crf", "28", "-threads", "2", "-vf", "scale=-2:$res", "-c:a", "aac", "-b:a", "128k", "-bufsize", "8M", "-x265-params", "ref=5", "-y", "$out") }
        'MP3' { $ffmpegArgs = @("-i", "$in", "-vn", "-b:a", "128k", "-bufsize", "8M", "-y", "$out") }
        'WEBM' { $ffmpegArgs = @("-i", "$in", "-c:v", "libvpx-vp9", "-b:v", "2M", "-vf", "scale=-2:$res", "-c:a", "libopus", "-b:a", "128k", "-bufsize", "8M", "-y", "$out") }
        default { $ffmpegArgs = @("-i", "$in", "-c:v", "libx265", "-preset", "faster", "-crf", "28", "-threads", "2", "-vf", "scale=-2:$res", "-c:a", "aac", "-b:a", "128k", "-bufsize", "8M", "-x265-params", "ref=5", "-y", "$out") }
    }

    try {
        & ffmpeg.exe $ffmpegArgs
    } catch {
        Write-Error "Failed to convert video: $_"
    }
}
