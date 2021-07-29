#Verify the pre-request
@"
packer
dos2unix
"@ -split "`r`n" | ForEach-Object {
  if (!(Get-Command $_)) {
    [bool]$Ready = $false
  }
  $Ready
}

# Build images
if ($Ready -ne $false) {
  # Convert dos format to unix format
  "dos2unix"
  Get-ChildItem -Path $PSScriptRoot -Recurse -Filter "*.sh" `
    | Select-Object -ExpandProperty VersionInfo `
    | Select-Object -ExpandProperty filename `
    | ForEach-Object {
      #[io.file]::WriteAllText($_, ((Get-Content -Raw  $_) -replace "`r`n","`n"))
      dos2unix $_
    }

  # Get Start Time
  $startDTM = (Get-Date)
  
  # Variables
  $template_file="$PSScriptRoot\templates\hv_ubuntu2004_g2_vagrant.pkr.hcl"
  $var_file="$PSScriptRoot\variables\variables_ubuntu2004.pkvars.hcl"
  $machine="Ubuntu 20.04"
  $packer_log=0
  
  if ((Test-Path -Path "$template_file") -and (Test-Path -Path "$var_file")) {
    Write-Output "Template and var file found"
    Write-Output "Building: $machine"
    $currentLocation = (Get-Location).Path
    Set-Location $PSScriptRoot
    try {
      $env:PACKER_LOG=$packer_log
      packer validate -var-file="$var_file" "$template_file"
    }
    catch {
      Write-Output "Packer validation failed, exiting."
      exit (-1)
    }
    try {
      $env:PACKER_LOG=$packer_log
      packer version
      packer build --force -var-file="$var_file" "$template_file"
    }
    catch {
      Write-Output "Packer build failed, exiting."
      exit (-1)
    }
    Set-Location $currentLocation
  }
  else {
    Write-Output "Template or var file not found - exiting"
    exit (-1)
  }
}

$endDTM = (Get-Date)
Write-Host "[INFO]  - Elapsed Time: $(($endDTM-$startDTM).totalseconds) seconds" -ForegroundColor Yellow
