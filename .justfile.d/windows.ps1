#!/usr/bin/env -S pwsh -noprofile
# ^~~ Callable from MSYS2

function Set-RegistryValue {
  param (
    [Parameter(Mandatory=$true)] [string]$Path,
    [Parameter(Mandatory=$true)] [string]$Name,
    [Parameter(Mandatory=$true)] $Value,
    [Parameter(Mandatory=$false)] [string]$Type = "DWord"
  )
  if (-not (Test-Path $Path)) {
    New-Item -Path $Path -Force | Out-Null
    Write-Host "Created Registry Key $Path." -ForegroundColor Yellow
  }

  $CurrentValue = (Get-ItemProperty -Path $Path -Name $Name -ErrorAction SilentlyContinue).$Name

  if ($null -eq $CurrentValue) {
    New-ItemProperty -Force -Path $Path -Name $Name -Value $Value -PropertyType $Type
    Write-Host "Created Registry: $Name -> $Value" -ForegroundColor Yellow
  } else {
    if($CurrentValue -ne $Value) {
      Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type
      Write-Host "Updated Registry: $Name from $CurrentValue -> $Value" -ForegroundColor Cyan
    } else {
      Write-Host "Skipping Registry: $Name (Value already set)" -ForegroundColor DarkGray
    }
  }
}

#================
# Ensure Scoop
#================
if (-not (Get-Command scoop -ErrorAction SilentlyContinue) ) {
  Write-Host "Scoop not found. Installing scoop."
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
  Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
}

#================
# Env Vars
#================
$EnvVars = [ordered]@{
  # Sensible XDG Specifications
  # "HOME" = "$env:USERPROFILE"
  # "XDG_CONFIG_HOME" = "$env:HOME\.config"
  # "XDG_CACHE_HOME" = "$env:HOME\.cache"
  # "XDG_BIN_HOME" = "$env:HOME\.local\bin"
  # "XDG_DATA_HOME" = "$env:HOME\.local\share"
  # "XDG_STATE_HOME" = "$env:HOME\.local\state"
  # Config Dirs using XDG
  # "KOMOREBI_CONFIG_HOME" = "$env:XDG_CONFIG_HOME\komorebi"
  # "BAT_CONFIG_DIR" = "$env:XDG_CONFIG_HOME\bat"
  # # Declutter Home
  # "DOTNET_CLI_HOME" = "$env:XDG_DATA_HOME\dotnet"
  # "NUGET_PACKAGES" = "$env:XDG_DATA_HOME\nuget\packages"
  # "RUSTUP_HOME" = "$env:XDG_DATA_HOME\rustup"
  # "CARGO_HOME" = "$env:XDG_DATA_HOME\cargo"
  # "ANDROID_USER_HOME" = "$env:XDG_DATA_HOME\android"
  # Fuck Microsoft
  "DOTNET_CLI_TELEMETRY_OPTOUT" = "1"
  "POWERSHELL_TELEMETRY_OPTOUT" = "1"
}
foreach ($EnvVar in $EnvVars.GetEnumerator()) {
  $Key = $EnvVar.Key
  $Value = $EnvVar.Value.Replace('/', '\')
  if ([System.Environment]::GetEnvironmentVariable($Key, "User") -ne $Value) {
    [System.Environment]::SetEnvironmentVariable($Key, $Value, "User")
    Write-Host "Updating $Key to $Value..." -ForegroundColor Cyan
  } else {
    Write-Host "Skipping $Key (Already set)" -ForegroundColor DarkGray
  }
  if ((Get-ChildItem "env:\$Key").Value -ne $Value) {
    Set-Item -Path "env:\$Key" -Value $Value
  }
}

#================
# Fonts
#================
Write-Host "Installing Fonts"
$UserFontDir = "$env:LOCALAPPDATA\Microsoft\Windows\Fonts"
New-Item $UserFontDir -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

$ACL = Get-Acl $UserFontDir
$SIDs = @("S-1-15-2-1", "S-1-15-2-2") # All App Packages & All Restricted App Packages
foreach($SidString in $SIDs) {
  try {
    $Identifier = New-Object System.Security.Principal.SecurityIdentifier($SidString)
    $Rule = New-Object System.Security.AccessControl.FileSystemAccessRule(
      $Identifier,
      "ReadAndExecute",
      "ContainerInherit,ObjectInherit",
      "None",
      "Allow"
    )
    $ACL.SetAccessRule($Rule)
  } catch {
    Write-Host "Warning: Could not resolve SID $SidString. Skipping ACL entry." -ForegroundColor Yellow
  }
}
Set-Acl $UserFontDir $ACL

$FontsDir = Join-Path -Path $PWD.Path -ChildPath "fonts"
$FontTypes = ( "*.ttf", "*.otf" )
$FontFiles = Get-ChildItem -Path $FontsDir -Include $FontTypes -File -Recurse

$FontsRegistryKey = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"

foreach ($Font in $FontFiles) {
  $Destination = Join-Path -Path $UserFontDir -ChildPath $Font.Name
  Copy-Item -Path $Font.FullName -Destination $UserFontDir -Force -ErrorAction Stop
  Write-Host "Symlinked Font: $($Font.Name) into User's Fonts directory. $($Destination)" -ForegroundColor Green
  Set-RegistryValue `
    -Path $FontsRegistryKey `
    -Name $Font.BaseName `
    -Value $Destination `
    -Type "String"
}

#================
# Tweaks
#================
# 1. Disable Win+L (Current User)
Set-RegistryValue `
  -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System" `
  -Name "DisableLockWorkstation" `
  -Value 1 `
  -Type "DWord"

# 2. Enable Long Path Support (Local Machine)
# Set-RegistryValue `
#     -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" `
#     -Name "LongPathsEnabled" `
#     -Value 1
