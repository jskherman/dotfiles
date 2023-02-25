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

# Custom Aliases
New-Alias flyctl "$env:USERPROFILE\.fly\bin\flyctl.exe"
New-Alias fly "$env:USERPROFILE\.fly\bin\flyctl.exe"
New-Alias lvim "$env:USERPROFILE\.local\bin\lvim.ps1"

# Custom Functions
function gitacp { git add .; git commit -m "$args"; git push}
function censorf { deface "$args" --boxes --replacewith solid -o "$args"}
function rview { rich "$args" --emoji -y -w 90}
function pipf { python -m pip freeze | Out-File -Encoding UTF8 "$args"}
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




