Param (
	[Parameter(Mandatory = $false, Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName=$true)] 
	[string]$ShowFolder
	)

# Created By: Kevin Saucier
# Last Modified Date: 2022-09-20
#
# This script contains logic used for the xLights Companion

# If this is a Friday or if PowerShell 7 hasn't yet been installed, check for updates and try to install PowerShell 7
If ((Get-Date).DayOfWeek -eq "Friday" -or (Test-Path "C:\Program Files\PowerShell\7\pwsh.exe") -eq $false)
    {
		Write-Host "`nHappy Friday!  Checking for PowerShell 7 Updates.....`n"
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

# PowerShell 7 is required for this script.  If it's installed, relaunch the script using PowerShell 7.  If not, exit.
If (!($PSVersionTable.PSVersion.Major -eq 7))
	{
		If (Test-Path "C:\Program Files\PowerShell\7\pwsh.exe")
			{
				Write-Host "`n`n`nPowerShell 7 is required for this script to function correctly.  Restarting script in PowerShell 7"
				Start-Process -FilePath "C:\Program Files\PowerShell\7\pwsh.exe" -ArgumentList "-File $($MyInvocation.MyCommand.Name) $(If ($ShowFolder) {"-ShowFolder $ShowFolder"})"
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


Write-Host "[$(Get-Date -Format G)] Initializing xLights Companion..."

# Define the variables
$strLogLevel = "VERBOSE" # Specify the logging level
$strDefaultShowFolderPath = "$PSScriptRoot\Test Layout" # Specify the default show folder to open in Companion.  If not specified, you can choose one within Companion.
$strxLightsCompanionXMLPath = $PSScriptRoot # Specify where to find/store the Companion XML file
$strxLightsRGBEffectsFileName = "xlights_rgbeffects.xml" # Specify the name of the xLights RGBEffects XML file.  This should not be changed.
$strxLightsNetworksFileName = "xlights_networks.xml" # Specify the name of the xLights Networks XML file.  This should not be changed.
$strFileBackupSuffix = ".xLightsCompanion.bkp" # Specify the extension to add to files backed up by Companion
$intNumberofxLightsRBGEffectsBackupsToKeep = 10 # Specify the number of RGBEffects file backups to keep
$intNumberofxLightsCompanionBackupsToKeep = 10 # Specify the number of Companion XML file backups to keep
$strxLightsPath = "C:\Program Files\xLights\xLights.exe" # Specify the path to xLights.  If the specified path is blank or doesn't exist, Companion will search for xLights.exe.

# Define the registry key in which to save settings
$global:strxLightsCompanionRegRoot = "HKCU:SOFTWARE\xLights Companion\Settings"

#---------------------------------------------
# General GUI Settings - Customize as Required
#---------------------------------------------
$global:strFormTitle = "xlights Companion" # The title of the window
$global:strFormHeader = "Lights On Lynn" # The header of the window
$global:strPowerShellProcessPath = (Get-Process -Id $PID).Path
$global:strFormIconPath = $strPowerShellProcessPath # The icon to use for the PowerShell window
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
# Main script starts here.  No Changes Should Be NEcessary
##############################################################






##############################################################
# Draw the main form and run functions to add required options
##############################################################

# Create the base window and customer the behavior
DrawBaseForm -boolShowControlBox $true
$objForm.Add_Load({
		
		# Initialize all the necessary variables/settings for the script
		LogWrite "INFO" "Starting xLights Companion"
		
		# AddSettings
		
		# Record the start time
		$global:dtQAOverallStartTime = Get-Date
		
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
		
		# If the window is closed without the changes being saved, prompt
		If ($boolLayoutModelsChanged -eq $true -or $boolLayoutModelGroupsChanged -eq $true -or $boolLayoutViewsChanged -eq $true)
			{
				LogWrite "INFO" "Changes have been made to the layout.  Notify to Save or Cancel."
				
				$strSaveChangesToLayout = [System.Windows.Forms.MessageBox]::Show("'$($lbxLayouts.SelectedItem)' has been modified. `n`nSave Changes.", "Layout Modified!", "YesNo", "Exclamation")

				If ($strSaveChangesToLayout -eq "Yes")
					{
						LogWrite "VERBOSE" "Saving Layout Changes for ""$($lbxLayouts.SelectedItem)"""

						# Save the layout models
						UpdateLayoutResource -strTargetLayout $lbxLayouts.SelectedItem -strNodeType "Model"
						UpdateLayoutResource -strTargetLayout $lbxLayouts.SelectedItem -strNodeType "ModelGroup"
						UpdateLayoutResource -strTargetLayout $lbxLayouts.SelectedItem -strNodeType "View"

						$lbxLayouts.Enabled = $true
						$btnFormSubmit.Enabled = $true
						If ($boolxLightsCompanionXMLIsChanged) {$btnFormSubmit.BackColor = "Green"}
						$btnSaveLayout.Visible = $false
						$btnCancelReloadLayout.Visible = $false
						
						$global:boolLayoutModelsChanged = $false
						$global:boolLayoutModelGroupsChanged = $false
						$global:boolLayoutViewsChanged = $false

						ModifyPanels "Enable" "SyncFrom"
						$btnSyncFromxLights.Enabled = $true
						$cbxSyncToMaster.Enabled = $true
						ModifyPanels "Enable" "CommitToxLights"

						# Set the global Change Made flag
						xLightsCompanionUpdates $true

					}

			}
		
		If ($boolxLightsCompanionXMLIsChanged -eq $true)
			{
				LogWrite "INFO" "Changes have been made to the xLights Companion XML.  Prompt to save the XML."
						
				$global:strSaveChangesToxLightsCompanionXML = [System.Windows.Forms.MessageBox]::Show("xLights Companion has been updated.  Save Changes?", "Save Changes?" , "YesNo", "Exclamation")

				If ($strSaveChangesToxLightsCompanionXML -eq "Yes")
					{
						LogWrite "INFO" "Saving changes to xLights Companion XML......"

						$intSaveAttempts = 0
						While ($boolxLightsCompanionXMLIsChanged -ne $false -and $intSaveAttempts -lt 5)
							{
								Try 
									{
										$intSaveAttempts++

										$objxLightsCompanionXML.Save($strxLightsCompanionXML)
										
										$global:boolxLightsCompanionXMLIsChanged = $false
										$btnFormSubmit.Text = "Close"
										$btnFormSubmit.Forecolor = "Black"
										$btnFormSubmit.BackColor = "WhiteSmoke"
										
										LogWrite "INFO" "Changes have been saved."
									}
									Catch 
										{
											[System.Windows.Forms.MessageBox]::Show("An Error Occurred trying to save xLights Companion Configuration. `n`nClick OK to retry.", "OK", "Exclamation")
											Continue
										}
							}
						
						If ($intSaveAttempts -ge 5)
							{
								[System.Windows.Forms.MessageBox]::Show("xLights Companion could not be saved after $intSaveAttempts attempts. `n`nUnfortunately, you're out of luck.  :(", "Saving Failed", "OK", "Exclamation")
							}
						
					}
			}
	})

# Add the main GUI panels and controls
DrawBasePanels
PopulateHeaderPanel
PopulateContentPanelHeader "This script is a Companion Script used to extend functionality provided by xLights"
#ShowComputerInfoInFooter


# Add the footer labels to display/control the refresh timer
AddFooterTitles "" ""
#	$lblFooterTitle.Add_Click({ })
#	$lblFooterSubTitle.Add_Click({})

# Add the submittal button and the commands to run when it is clicked
AddFormSubmitButton "Close" $false
	$btnFormSubmit.Add_Click({
			
			If ($boolxLightsCompanionXMLIsChanged -ne $true -and $boolLayoutModelsChanged -ne $true -and $boolLayoutModelGroupsChanged -ne $true -and $boolLayoutViewsChanged -ne $true)
				{
					LogWrite "INFO" "No need to save as no changes have been made to the xLights Companion XML."

					$objForm.Close()
				}
				Else
					{
						LogWrite "INFO" "Changes have been made to the xLights Companion XML.  Prompt to save the XML."
						
						$global:strSaveChangesToxLightsCompanionXML = [System.Windows.Forms.MessageBox]::Show("xLights Companion has been updated.  Save Changes?", "Save Changes?" , "YesNo", "Exclamation")

						If ($strSaveChangesToxLightsCompanionXML -eq "Yes")
							{
								$intSaveAttempts = 0
								While ($boolxLightsCompanionXMLIsChanged -ne $false -and $intSaveAttempts -lt 5)
									{
										Try 
											{
												$intSaveAttempts++

												$objxLightsCompanionXML.Save($strxLightsCompanionXML)
												
												$global:boolxLightsCompanionXMLIsChanged = $false
												$btnFormSubmit.Text = "Close"
												$btnFormSubmit.Forecolor = "Black"
												$btnFormSubmit.BackColor = "WhiteSmoke"
												Return
											}
											Catch 
												{
													[System.Windows.Forms.MessageBox]::Show("An Error Occurred trying to save xLights Companion Configuration. `n`nClick OK to retry.", "OK", "Exclamation")
													Continue
												}
									}
								
								[System.Windows.Forms.MessageBox]::Show("xLights Companion could not be saved after $intSaveAttempts attempts. `n`nPlease try again.", "OK", "Exclamation")
								Return
							}
							Else
								{
									Return
								}

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
$btnNavigationButton2.Visible = $true
$btnNavigationButton2.Add_Click({
			
		})
	
PopulateContent6 "Settings" "Configure script settings.  Values below are persisted in the registry."
	$pnlContentPanel6.Top = 5
	$pnlContentPanel6.Width = $pnlContent.Width
	$pnlContentPanel6.Height = $pnlContent.Height - $pnlContentPanel6.Top
$btnNavigationButton6.Visible = $false


# Show the form
[void] $objForm.ShowDialog()