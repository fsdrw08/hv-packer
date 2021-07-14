#Verify the pre-request
@"
packer
dos2unix
mkisofs
"@ -split "`r`n" | ForEach-Object {
  if (!(Get-Command $_)) {
    [bool]$Ready = $false
  }
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

  # Build images
    
  # Get Start Time
  $startDTM = (Get-Date)
    
  # Variables
  $template_file="./templates/hv_almalinux8_g2_vagrant.pkr.hcl"
  $var_file="./variables/variables_almalinux84.pkvars.hcl"
  $vbox_file="./vbox/packer-almalinux84-g2.box"
  $machine="AlmaLinux 8.4"
  $packer_log=0
    
  if ((Test-Path -Path "$template_file") -and (Test-Path -Path "$var_file")) {
    Write-Output "Template and var file found"
    Write-Output "Building: $machine"
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
      if ($?) {
        Write-Output "Calculating checksums"
        Get-FileHash -Algorithm SHA256 -Path "$vbox_file"|Out-File "$vbox_file.sha256" -Verbose
      }
    }
    catch {
      Write-Output "Packer build failed, exiting."
      exit (-1)
    }
  }
  else {
    Write-Output "Template or Var file not found - exiting"
    exit (-1)
  }
  
  $endDTM = (Get-Date)
  Write-Host "[INFO]  - Elapsed Time: $(($endDTM-$startDTM).totalseconds) seconds" -ForegroundColor Yellow
}