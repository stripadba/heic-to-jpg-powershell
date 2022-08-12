<#
Script: convert-heic-to-jpg.ps1 
Author: Som Dutt Tripathi
Purpose: Converts a directory with heic files to jpg using magick. 
#>
param 
(
    [String]$SourceDirectory,   #--Name of source directory
    [String]$TargetDirectory    #--Optional. If not provided, SourceDirectory is TargetDirectory
)

function initialize()
{
    #--(1) Validate magick.exe 
    $Script:magick_exe=$(get-command "magick").Source 
    if ( "[${Script:magick_exe}]" -eq "[]")
    {
        echo "magick.exe installation found [FAILED]"           
        Write-host "ERROR: Script depends on magick.exe. Magick CLI can be downloaded from https://imagemagick.org/script/convert.php" -ForegroundColor Red 
    }
    else 
    {
        Write-host "magick.exe installation found [SUCCESS]" -ForegroundColor Green       
    }

    #--(2) Validate SourceDirectory
    if ( Test-Path $Script:SourceDirectory )
    {
        Write-host "SourceDirectory found [SUCCESS]" -ForegroundColor Green   
        
        if ( "$Script:TargetDirectory" -ne "[]" )
        {
            $Script:TargetDirectory=$Script:SourceDirectory
        }
    }
    else 
    {
        echo "SourceDirectory found [FAILED]"   
        Write-host "ERROR: SoureDirectory not found. Please provide a valid location." -ForegroundColor red       
    }
    
    #--(3) Validate TargetDirectory
    if ( Test-Path $Script:TargetDirectory )
    {
        Write-host "TargetDirectory found [SUCCESS]" -ForegroundColor Green   
    }
    else 
    {
        echo "TargetDirectory found [FAILED]"   
        Write-host "ERROR: TargetDirectory not found. Please provide a valid location." -ForegroundColor red       
    }
}
function main()
{
    $ErrorActionPreference="Stop"
    try 
    {
        ls ${Script:SourceDirectory}\*.heic | foreach { magick  $_.fullname $_.fullname.replace(".heic", ".jpg") }
        Write-Host "Conversion completed successfully."
    }
    catch   
    {
        echo "Converting files to jpg [FAILED]"
    }
}

initialize
main