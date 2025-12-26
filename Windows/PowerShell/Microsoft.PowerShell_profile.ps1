#================
# Autosuggestion
#================
if (-not (Get-Module -Name PSReadLine -ListAvailable)) {
  Install-PSResource -Name PSReadLine -Scope CurrentUser -TrustRepository
}
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# powershell 7 exclusive modules
if ($PSVersionTable.PSVersion.Major -ge 7) {
  if (-not (Get-Module -Name CompletionPredictor -ListAvailable)) {
    Install-PSResource -Name CompletionPredictor -Scope CurrentUser -TrustRepository
  }
  Import-Module -Name CompletionPredictor

  if (-not (Get-Module -Name PowerType -ListAvailable)) {
    Install-PSResource -Name PowerType -Scope CurrentUser -TrustRepository
  }
  Import-Module -Name PowerType
  Enable-PowerType
}

# carapace
if (Get-Command -Name "carapace" -ErrorAction SilentlyContinue) {
  $env:CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
  Set-PSReadLineOption -Colors @{ "Selection" = "`e[7m" }
  carapace _carapace powershell | Out-String | Invoke-Expression
}
#================

#================
# Tools
#================
if (Get-Command -Name "eza" -ErrorAction SilentlyContinue) {
  $env:EZA_CONFIG_DIR = "$env:USERPROFILE\.config\eza"
  function def_eza {
    eza -lAh --group-directories-first --header --icons -- @args
  }
  Set-Alias -Name ls -Value def_eza -Force -Option AllScope
}
if (Get-Command -Name "zoxide" -ErrorAction SilentlyContinue) {
  Invoke-Expression (& { (zoxide init powershell | Out-String) })
  Set-Alias -Name cd -Value z -Force -Option AllScope
}
if (Get-Command -Name "starship" -ErrorAction SilentlyContinue) {
  Invoke-Expression (&starship init powershell)
}
if (Get-Command -Name "bat" -ErrorAction SilentlyContinue) {
  Set-Alias -Name cat -Value bat -Force -Option AllScope
  Set-Alias -Name rcat -Value Get-Content -Force -Option AllScope
}
if (Get-Command -Name "direnv" -ErrorAction SilentlyContinue) {
  Invoke-Expression "$(direnv hook pwsh)"
}
#================

#================
# UNIX aliases
#================
Set-Alias -Name which -Value where.exe -Option AllScope
Set-Alias -Name touch -Value New-Item -Option AllScope
if (Get-Command -Name "btop4win" -ErrorAction SilentlyContinue) {
  Set-Alias -Name btop -Value btop4win -Force -Option AllScope
}
#================

#================
# Start Up Scripts
#================
# $StartUpScripts = Get-ChildItem -Path "$PSScriptRoot/StartUp" -Filter "*.ps1" -File
# foreach ($StartUpScript in $StartUpScripts) {
#   & $StartUpScript
# }
#
# fastfetch
if (Get-Module -Name PSReadLine -ListAvailable) {
  Set-PSReadLineOption -EditMode vi
  Set-PSReadLineOption -ViModeIndicator Cursor
}

