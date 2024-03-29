Param (
	[Parameter(Mandatory = $false, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName=$true)] 
	[string]$ShowFolder,
	[Parameter(Mandatory = $false, Position = 2, ValueFromPipeline = $true, ValueFromPipelineByPropertyName=$true)] 
	[string]$LogLevel
	)

# Created By: Kevin Saucier
# Last Modified Date: 2022-09-21
#
# This script contains logic used for the xLights Companion

#---------------------------------------------
# General GUI Settings - Customize as Required
#---------------------------------------------
$script:strFormTitle = "xlights Companion" # The title of the window
$script:strFormHeader = "Your Show Name" # The name of your show (or whatever text you want to see on the window)
$strDefaultShowFolderPath = "$PSScriptRoot\Test Layout1" # Specify the default show folder to open in Companion. ex: 'C:\MyShow'  If not specified, you can choose one within Companion.
$boolShowShowLogo = $true # or $false - Whether to show your show logo or not.  The logo is stored as a PNG file in the script directory - Image-ShowLogo.PNG
$boolUpdatePowerShellEveryFriday = $true # or $false - Whether or not to run the code to check for and install the latest version of PowerShell 7


#---------------------------------------------------------
# Script Options - You probably don't need to change these
#---------------------------------------------------------
$script:strLogLevel = "INFO" # Specify the logging level ERROR/WARNING/INFO/VERBOSE/DEBUG - Excess logging slows down the process.  This can be overridden by providing the -LogLevel parameter on the command line
$strxLightsCompanionXMLPath = $PSScriptRoot # Specify where to find/store the Companion XML file
$strxLightsRGBEffectsFileName = "xlights_rgbeffects.xml" # Specify the name of the xLights RGBEffects XML file.  This should not be changed.
$strxLightsNetworksFileName = "xlights_networks.xml" # Specify the name of the xLights Networks XML file.  This should not be changed.
$strFileBackupSuffix = ".xLightsCompanion.bkp" # Specify the extension to add to files backed up by Companion
$intNumberofxLightsRBGEffectsBackupsToKeep = 10 # Specify the number of RGBEffects file backups to keep
$intNumberofxLightsCompanionBackupsToKeep = 10 # Specify the number of Companion XML file backups to keep
$strxLightsPath = "C:\Program Files\xLights\xLights.exe" # Specify the path to xLights.  If the specified path is blank or doesn't exist, Companion will search for xLights.exe.
$script:strPowerShellProcessPath = (Get-Process -Id $PID).Path # The path to pwsh.exe - this shouldn't need changing
$script:strFormIconPath = $strPowerShellProcessPath # The icon to use for the PowerShell window
$script:strxLightsCompanionRegRoot = "HKCU:SOFTWARE\xLights Companion\Settings" # Define the registry key in which to save settings (not yet implemented)

# Set the form default size - You may need to lower this if your resolution is HUGE
$script:intDefaultFormWidth = 1500
$script:intDefaultFormHeight = 700

# Specify the minimum size of the form, based on the content and what looks good.  This will override the default minimums.
$script:intFormMinimumWidth = 800
$script:intFormMinimumHeight = 400



# Log Level Override
If ($LogLevel -in "ERROR","WARNING","INFO","VERBOSE","DEBUG") 
	{
		Write-host "Log Level set to ""$LogLevel"" by command line parameter" -ForegroundColor Cyan
		$script:strLogLevel = "$LogLevel"
	}


##############################################################
# Main script starts here.  No Changes Should Be Necessary
##############################################################

Write-Host "[$(Get-Date -Format G)] Initializing xLights Companion..."

# If specified and, if this is a Friday or if PowerShell 7 hasn't yet been installed, check for updates and try to install PowerShell 7
If ($boolUpdatePowerShellEveryFriday)
	{
		If ((Get-Date).DayOfWeek -eq "Friday" -or (Test-Path "C:\Program Files\PowerShell\7\pwsh.exe") -eq $false)
			{
				Write-Host "`nChecking for PowerShell 7 Updates.....`n"
				$objPowerShellRelease = Invoke-WebRequest -Uri 'https://aka.ms/pwsh-buildinfo-lts'

				$objPowerShellLatestVersion = [System.Version]::Parse(($objPowerShellRelease.Content | ConvertFrom-Json).ReleaseTag -replace "v")

				# If the current version is older than the latest version, install the latest version
				If ($PSVersionTable.PSVersion -lt $objPowerShellLatestVersion)
					{
						Write-Host "`tTrying to install/update PowerShell 7 from version $($PSVersionTable.PSVersion.ToString()) to version $($objPowerShellLatestVersion.ToString())....`n" -ForegroundColor Cyan
						Try 
							{
								Invoke-Expression "& { $(Invoke-RestMethod https://aka.ms/install-powershell.ps1) } -UseMSI -Quiet"
								Write-Host "`n`tInstallation of PowerShell version $($objPowerShellLatestVersion.ToString()) was successful!`n" -ForegroundColor Green
							} Catch {Write-Host "`n`tInstallation of PowerShell version $($objPowerShellLatestVersion.ToString()) failed!`n" -ForegroundColor Magenta}
					}
					Else
						{
							Write-Host "`tThe latest PowerShell version ($($PSVersionTable.PSVersion.ToString())) is already installed.`n" -ForegroundColor Green
						}
			}
	}

# PowerShell 7 is required for this script.  If it's installed, relaunch the script using PowerShell 7.  If not, exit.
If (!($PSVersionTable.PSVersion.Major -eq 7))
	{
		If (Test-Path "C:\Program Files\PowerShell\7\pwsh.exe")
			{
				Write-Host "`n`n`nPowerShell 7 is required for this script to function correctly.  Restarting script in PowerShell 7....."
				
				# Define the arguments for the script
				$strArgumentList = "-File ""$($MyInvocation.MyCommand.Name)"""
				$strArgumentList += If ($ShowFolder) {" -ShowFolder ""$ShowFolder"""}
				
				# Start the script using PowerShell 7 with the specified arguments and let the old window sleep for 5 seconds before closing.
				Start-Process -FilePath "C:\Program Files\PowerShell\7\pwsh.exe" -ArgumentList $strArgumentList -WindowStyle Minimized
				Start-Sleep 5
				Exit
			}
			Else
				{
					Write-Warning "`n`n`nPowerShell 7 is required for this script to function correctly.  Please install PowerShell 7 and try again.`n`n`n"
					Start-Sleep 30
					Exit
				}
	}






##############################################################
# Include Script Files
##############################################################
. "$PSScriptRoot\xLights-BaseFunctions.ps1"
. "$PSScriptRoot\xLights-BaseFormFunctions.ps1"
. "$PSScriptRoot\xLights-Functions.ps1"



##############################################################
# Functions
##############################################################
Function CheckForUnsavedChanges ($boolCheckOnly)
	{
		# Check to see if the layout has been modified and prompt to save, if so.
		If ($boolLayoutModelsChanged -eq $true -or $boolLayoutModelGroupsChanged -eq $true -or $boolLayoutViewsChanged -eq $true)
			{
				If ($boolCheckOnly) {Return $true}

				LogWrite "INFO" "Changes have been made to the layout.  Notify to Save or Cancel."
				
				$strSaveChangesToLayout = [System.Windows.Forms.MessageBox]::Show("'$($lbxLayouts.SelectedItem)' has been modified. `n`nClick Yes to Save Changes `nClick No to Continue without saving", "Save Layout Changes?", "YesNo", "Exclamation")

				If ($strSaveChangesToLayout -eq "Yes")
					{
						SaveLayout
					}

			}
		
		# Check to see if the XML has been modified and prompt to save, if so.
		If ($boolxLightsCompanionXMLIsChanged -eq $true)
			{
				If ($boolCheckOnly) {Return $true}

				LogWrite "INFO" "Changes have been made to the xLights Companion XML.  Prompt to save the XML."
						
				$script:strSaveChangesToxLightsCompanionXML = [System.Windows.Forms.MessageBox]::Show("xLights Companion has been updated.  Save Changes?", "Save Changes?" , "YesNo", "Exclamation")

				If ($strSaveChangesToxLightsCompanionXML -eq "Yes")
					{
						SaveCompanionXML						
					}
			}
	}



##############################################################
# Draw the main form and run functions to add required options
##############################################################

# Create the base window and customer the behavior
DrawBaseForm -boolShowControlBox $false
$objForm.Add_Load({
		
		# Initialize all the necessary variables/settings for the script
		LogWrite "INFO" "Starting xLights Companion"
		
		# AddSettings
		
		# Record the start time
		$script:dtQAOverallStartTime = Get-Date
		
	})
$objForm.Add_Shown({
		
		LogWrite "INFO" "Show the Window" $false

		# Set what should happen the first time the form is shown
		$btnSelectShowFolder.Select()
		$objForm.WindowState = "Normal"
		
		# Bring the form to the front
		ShowObjForm

		# If the xlights directory was specified on the command line and is valid, use it
		If ($ShowFolder)
			{
				If (Test-Path "$ShowFolder\xlights_rgbeffects.xml")
					{
						$script:strSelectedShowFolderFile = "$ShowFolder\xlights_rgbeffects.xml"
						$script:strSelectedShowFolder = (Get-Item $strSelectedShowFolderFile -ErrorAction SilentlyContinue).DirectoryName
	
						SetShowFolder $strSelectedShowFolder
					}
					Else
						{
							LogWrite "WARNING" "Specified Show Folder ""$ShowFolder"" is invalid.  Please choose a valid show folder."
						}
			}
			ElseIf (Test-Path $strDefaultShowFolderPath)
				{
					# If a default show folder has been specified, try to use it
					If (Test-Path "$ShowFolder\xlights_rgbeffects.xml")
						{
							$script:strSelectedShowFolderFile = "$ShowFolder\xlights_rgbeffects.xml"
							$script:strSelectedShowFolder = (Get-Item $strSelectedShowFolderFile -ErrorAction SilentlyContinue).DirectoryName

							SetShowFolder -strFolderPath $strDefaultShowFolderPath -strButtonText "Default Show Folder"
						}
						Else
							{
								LogWrite "WARNING" "Default Show Folder ""$ShowFolder"" is invalid.  Please choose a valid show folder."
							}
				}
	})
$objForm.Add_Closed({
		
		
	})


# Add the main GUI panels and controls
DrawBasePanels
PopulateHeaderPanel
PopulateContentPanelHeader "This script is a Companion Script used to extend functionality provided by xLights"
#ShowComputerInfoInFooter


# Add the footer labels to display/control the refresh timer
AddFooterTitles "" ""
#	$lblFooterTitle.Add_Click({ })
#	$lblFooterSubTitle.Add_Click({ })

# Add the save to file button and the commands to run when it is clicked
AddSaveToFileButton
$btnSaveToFile.Text = "Save"
$btnSaveToFile.Visible = $false
	$btnSaveToFile.Add_Click({
			
			LogWrite "INFO" "Changes have been made to the xLights Companion XML.  Prompt to save the XML."
			
			$script:strSaveChangesToxLightsCompanionXML = [System.Windows.Forms.MessageBox]::Show("xLights Companion has been updated.  `n`nClick Yes to Save Changes `nClick No to Continue Without Saving", "Save Changes?" , "YesNo", "Exclamation")

			If ($strSaveChangesToxLightsCompanionXML -eq "Yes")
				{
					SaveCompanionXML
				}
				Else
					{
						Return
					}
		})

# Add the Cancel Button
AddFormSubmitButton "Close" $false
	$btnFormSubmit.Add_Click({

		If ((CheckForUnsavedChanges -boolCheckOnly $true) -eq $true)
			{
				$script:strExitWithoutSaving = [System.Windows.Forms.MessageBox]::Show("xLights Companion has unsaved changes  `n`nClick OK to exit without saving `nClick Cancel to go back", "Save Changes Before Exiting?" , "OKCancel", "Exclamation")

				If ($script:strExitWithoutSaving -eq "OK")
					{
						$objForm.Close()
					}
			}
			Else
				{
					$objForm.Close()
				}
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

			# Show the dialog to select a folder
			$objSelectShowFolder = New-Object System.Windows.Forms.OpenFileDialog
			$objSelectShowFolder.Filter = "xLights RGB Effects File | $strxLightsRGBEffectsFileName"
		    $objSelectShowFolder.InitialDirectory = $PSScriptRoot

			$objSelectShowFolderResult = $objSelectShowFolder.ShowDialog()

			# If the OK button is clicked, use the folder of the file selected and load the xLights data
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
PopulateContent2 "Manage Layouts"
	$pnlContentPanel2.Top = 5
	$pnlContentPanel2.Width = $pnlContent.Width
	$pnlContentPanel2.Height = $pnlContent.Height - $pnlContentPanel2.Top
$btnNavigationButton2.Visible = $false
$btnNavigationButton2.Add_Click({
			
		})
	
PopulateContent6 "Settings" "Configure script settings.  Values below are persisted in the registry."
	$pnlContentPanel6.Top = 5
	$pnlContentPanel6.Width = $pnlContent.Width
	$pnlContentPanel6.Height = $pnlContent.Height - $pnlContentPanel6.Top
$btnNavigationButton6.Visible = $false

# Press Control+Z to cycle the log levels
$objForm.Add_KeyDown({

		# Press CTRL-Z on the main window to toggle the log level
		If ($_.KeyCode -eq "Z" -and $_.Modifiers -eq "Control")
			{
				Switch ($strLogLevel)
					{
						"ERROR" {$script:strLogLevel = "WARNING" ; $btnSelectShowFolder.BackColor = "Orange"}
						"WARNING" {$script:strLogLevel = "INFO" ; $btnSelectShowFolder.BackColor = "Blue"}
						"INFO" {$script:strLogLevel = "VERBOSE" ; $btnSelectShowFolder.BackColor = "LightBlue"}
						"VERBOSE" {$script:strLogLevel = "DEBUG" ; $btnSelectShowFolder.BackColor = "Magenta"}
						"DEBUG" {$script:strLogLevel = "ERROR" ; $btnSelectShowFolder.BackColor = "Red"}
						default {$script:strLogLevel = "INFO" ; $btnSelectShowFolder.BackColor = "Blue"}
					}
				
				LogWrite "INFO" "Log Level changed to $strLogLevel"
			}
	})

# Show the form
[void] $objForm.ShowDialog()