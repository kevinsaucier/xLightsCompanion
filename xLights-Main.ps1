# Created By: Kevin Saucier
# Last Modified Date: 2021-09-24
#
# This script contains logic used for xLights Companion Script

Write-Host "[$(Get-Date -Format G)] Initializing Functions..."

# Define the variables
$strDefaultShowFolderPath = "C:\Users\Kevin\OneDrive\- Profile\DownloadsDesktop\- Temp\xLightsCompanion"
$strxLightsRGBEffectsFileName = "xlights_rgbeffects.xml"
$strxLightsNetworksFileName = "xlights_networks.xml"
$strFileBackupSuffix = ".xLightsCompanion.bkp"

# Define the registry key for the OSDBranding values
$global:strxLightsCompanionRegRoot = "HKCU:SOFTWARE\xLights\Companion\Settings"

#---------------------------------------------
# General GUI Settings
#---------------------------------------------
$global:strFormTitle = "xlights Companion Script" # The title of the window
$global:strFormHeader = "Lights On Lynn" # The header of the window
$global:strFormIconPath = $PSHOME + "\powershell.exe" # The icon to use for the PowerShell window
$boolShowShowLogo = $true

# Set the form default size
$global:intDefaultFormWidth = 1500
$global:intDefaultFormHeight = 700

# Specify the minimum size of the form, based on the content and what looks good.  This will override the default minimums.
$global:intFormMinimumWidth = 800
$global:intFormMinimumHeight = 400



##############################################################
# Include Script Files
##############################################################
. "$PSScriptRoot\xLights-BaseFunctions.ps1"
. "$PSScriptRoot\xLights-BaseFormFunctions.ps1"
. "$PSScriptRoot\xLights-Functions.ps1"



##############################################################
# Main script starts here.  
##############################################################






##############################################################
# Draw the main form and run functions to add required options
##############################################################

# Create the base window and customer the behavior
DrawBaseForm -boolShowControlBox $true
$objForm.Add_Load({
		
		# Initialize all the necessary variables/settings for the script
		LogWrite "INFO" "Starting xLights Companion"
		
		AddSettings
		
		# Record the start time
		$global:dtQAOverallStartTime = Get-Date
		
	})
$objForm.Add_Shown({
		
		LogWrite "INFO" "Show the Window" $false

		# Set what should happen the first time the form is shown
		$btnSelectShowFolder.Select()
		$objForm.WindowState = "Normal"
		
		# If a default show folder has been specified, try to use it
		If (Test-Path $strDefaultShowFolderPath)
			{
				SetShowFolder -strFolderPath $strDefaultShowFolderPath -strButtonText "Default Show Folder"
			}
		
		# Bring the form to the front
		ShowObjForm
	})
$objForm.Add_Closed({

	})

# Add the main GUI panels and controls
DrawBasePanels
PopulateHeaderPanel
PopulateContentPanelHeader "This script is used to view and modify items in the xLights XML files"
#ShowComputerInfoInFooter


# Add the footer labels to display/control the refresh timer
AddFooterTitles "" ""
#	$lblFooterTitle.Add_Click({ })
#	$lblFooterSubTitle.Add_Click({})

# Add the submittal button and the commands to run when it is clicked
AddFormSubmitButton "Close" $true
	$btnFormSubmit.Add_Click({
			LogWrite "INFO" "Close the xLights Companion"
			$objForm.Close
		})

# Add 'Select Show Folder' button and customize the SubHeader label for use
$btnSelectShowFolder = New-Object Windows.Forms.Button
$btnSelectShowFolder.Left = 10# $pbxTopLeftHeaderLogo.Right + 30
$btnSelectShowFolder.Top = 10 #$lblHeader.Bottom
$btnSelectShowFolder.Text = "Select xLights File"
$btnSelectShowFolder.Width = $pnlNavigation.Width - 20
$btnSelectShowFolder.TextAlign = "MiddleCenter"
$btnSelectShowFolder.Cursor = "Hand"
$btnSelectShowFolder.ForeColor = "White"
$btnSelectShowFolder.BackColor = "Green"
$btnSelectShowFolder.Anchor = "Top,Left"
$btnSelectShowFolder.Add_Click({

			$objSelectShowFolder = New-Object System.Windows.Forms.OpenFileDialog
			$objSelectShowFolder.Filter = "xLights RGB Effects File | $strxLightsRGBEffectsFileName"
		    $objSelectShowFolder.InitialDirectory = $PSScriptRoot

			$objSelectShowFolderResult = $objSelectShowFolder.ShowDialog()

			If ($objSelectShowFolderResult -eq "OK")
				{
					$script:strSelectedShowFolderFile = $objSelectShowFolder.FileName
					$script:strSelectedShowFolder = (Get-Item $strSelectedShowFolderFile -ErrorAction SilentlyContinue).DirectoryName
	
					SetShowFolder $strSelectedShowFolder
				}
				
		})
$pnlNavigation.Controls.Add($btnSelectShowFolder)


$lblSubHeader.ForeColor = "Blue"
$lblSubHeader.Font = New-Object System.Drawing.Font("Arial",10)
$lblSubHeader.Add_DoubleClick({
				
			If ($lblSubHeader.Text -and (Test-Path $lblSubHeader.Text))
				{
					Start-Process -FilePath explorer.exe -ArgumentList $lblSubHeader.Text -WindowStyle Normal
				}
		})

# Add the content panels
$pnlContentHeaderOutline.Visible = $false	
PopulateContent2 "Load Models"
	$pnlContentPanel2.Top = 5
	$pnlContentPanel2.Width = $pnlContent.Width
	$pnlContentPanel2.Height = $pnlContent.Height - $pnlContentPanel2.Top
$btnNavigationButton2.Visible = $false
$btnNavigationButton2.Add_Click({
			LoadModels
		})
	
PopulateContent6 "Settings" "Configure script settings.  Values below are persisted in the registry."
	$pnlContentPanel6.Top = 5
	$pnlContentPanel6.Width = $pnlContent.Width
	$pnlContentPanel6.Height = $pnlContent.Height - $pnlContentPanel6.Top
$btnNavigationButton6.Visible = $false


# Show the form
[void] $objForm.ShowDialog()