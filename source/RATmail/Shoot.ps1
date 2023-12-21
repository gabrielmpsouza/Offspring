#####################################
# Software "OffSpring", versão 4.58 #
# OffSpring é uma ferramenta educa- #        
# cional projetada para conduzir    #
# testes simulados de penetração em #
# ambientes Windows exclusivamente. #
#####################################
# Este software destina-se única e  #
# exclusivamente a fins educacionais#
# e de pesquisa em segurança ciber- #
# nética. O autor não encoraja nem  #
# apoia a utilização deste software #
# para atividades ilegais ou malici-#
# osas.                             #
#####################################
# O autor declina qualquer respon-  #
# sabilidade por quaisquer conse-   #
# quências derivadas do uso deste   #
# software para fins não educacion- #
# ais ou não autorizados.           #
#####################################
#Param(
#[Parameter(Mandatory = $true)][string]$Path
#)
$OutPath = "$env:USERPROFILE\Documents\ScreenShot"
if (-not (Test-Path $OutPath))
        {
            New-Item $OutPath -ItemType Directory -Force
        }
$FileName = "$env:COMPUTERNAME - $(get-date -f yyyy-MM-dd_HHmmss).png"
#$File = "$OutPath\$FileName"
$File = Join-Path $OutPath $fileName
Add-Type -AssemblyName System.Windows.Forms
Add-type -AssemblyName System.Drawing
# Gather Screen resolution information
$Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen
$Width = $Screen.Width
$Height = $Screen.Height
$Left = $Screen.Left
$Top = $Screen.Top
# Create bitmap using the top-left and bottom-right bounds
$bitmap = New-Object System.Drawing.Bitmap $Width, $Height
# Create Graphics object
$graphic = [System.Drawing.Graphics]::FromImage($bitmap)
# Capture screen
$graphic.CopyFromScreen($Left, $Top, 0, 0, $bitmap.Size)
# Save to file
$bitmap.Save($File) 
#Write-Output "Screenshot saved to:"
Write-Output $File
#############################################################################
