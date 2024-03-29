# Created By: Kevin Saucier
# Last Modified Date: 2022-11-12
#
# This script contains settings and functions used by the xlights Companion application

# Set the X/Y to use for the first set of fields added to the panel
$script:intPanelContent2LeftBoundary = ($pnlContentPanel2.Width / 2)# - 125
$script:intPanelContent2TopBoundary = 5

# Set the default sizes to use for fields
$script:intPanel2ContentLabelWidth = 150
$script:intPanel2ContentLabelHeight = 20
$script:intPanel2ContentDataWidth = 300
$script:intPanel2ContentDataHeight = 30
$script:intPanel6ContentLabelWidth = 400
$script:intPanel6ContentLabelHeight = 20
$script:intPanel6ContentDataWidth = 275
$script:intPanel6ContentDataHeight = 30






Function PlaySound ($strSound)
	{
		# Create the sound object
		If (!($objSoundToPlay)) {$script:objSoundToPlay = New-Object System.Media.SoundPlayer}
		
		If ($strSound -eq "SUCCESS")
			{$script:objSoundToPlay.SoundLocation = "C:\Windows\Media\Windows Notify System Generic.wav"}
			Else
				{$script:objSoundToPlay.SoundLocation = "C:\Windows\Media\Windows Exclamation.wav"}

		$objSoundToPlay.Play()
	
	}


Function SetShowFolder ($strFolderPath, $strButtonText)
	{
		If (Test-Path "$strFolderPath\$strxLightsRGBEffectsFileName")
			{
				LogWrite "DEBUG" "A Valid Show Folder Was Selected ($strFolderPath)"
				
				$lblSubHeader.Text = $strFolderPath
				$lblSubHeader.ForeColor = If ($PSScriptRoot -like "*\- Development*") {"Red"} Else {"Blue"}
				$script:strxLightsRGBEffectsFilePath = "$strFolderPath\$strxLightsRGBEffectsFileName"
				$script:strxLightsNetworksFilePath = "$strFolderPath\$strxLightsNetworksFileName"

				$btnNavigationButton2.Visible = $false # Hide this button until it's needed
				$btnNavigationButton6.Visible = $false # Hide this button until it's needed
				$btnSelectShowFolder.Forecolor = "White"
				$btnSelectShowFolder.BackColor = "Blue"
				
				If ($strButtonText) {$btnSelectShowFolder.Text = $strButtonText} Else {$btnSelectShowFolder.Text = "Show Folder Selected"}
			}
			Else
				{
					LogWrite "WARNING" "Selected File Path does not appear to be a valid show folder.  Please try again"
					
					If ((Test-Path "$($lblSubHeader.Text)\$strxLightsRGBEffectsFileName") -eq $false)
						{
							$btnNavigationButton2.Visible = $false
							$pnlContentPanel2.Visible = $false
							$btnNavigationButton6.Visible = $false
							$pnlContentPanel6.Visible = $false
							$btnSelectShowFolder.Forecolor = "White"
							$btnSelectShowFolder.BackColor = "Green"
							$btnSelectShowFolder.Text = "Select xLights File"
						}

					[System.Windows.Forms.MessageBox]::Show("Selected File Path does not appear to be a valid show folder.`n`n- $strxLightsRGBEffectsFileName does not exist `n`nPlease try again","Invalid Show Folder Selected" , "OK", "Exclamation")
				}

		# Create the Layout Management panel
		PopulateContentPanel2

		# Load the xLights RGB Effects File
		LoadRGBEffects

		# Load the xLights Companion File
		CreateLoadxLightsCompanionXML

		# Assign xLights Companion IDs to the elements in the xLights RGB Effects and, if IDs are added, save the file.  Note this needs to run after both XML files are loaded.
		$intNewIDs = AssignCompanionIDs
		If ($intNewIDs -gt 0) {$objxLightsEffects.Save($strxlightsRGBEffectsFilePath)}

	}


# Call this function to indicate whether xLights Companion has pending updates that require ($true/$false) a save.
Function LayoutUpdatesPending ($boolLayoutUpdatesPending)
	{
		If ($boolLayoutUpdatesPending -eq $true)
			{
				# Set the flag, lock the listbox, disable the form submit button and enable the layout buttons
				# $script:boolLayoutModelsChanged = $true
				$lbxLayouts.Enabled = $false
				$btnAddLayout.Enabled = $false
				$btnRemoveLayout.Enabled = $false
				$btnDuplicateLayout.Enabled = $false

				$btnSaveToFile.Enabled = $false
				$btnSaveToFile.Visible = $false
				$btnSaveToFile.BackColor = "WhiteSmoke"
				$btnFormSubmit.Enabled = $false
				$btnFormSubmit.BackColor = "WhiteSmoke"

				$btnSaveLayout.Visible = $true
				If ($btnSaveLayout.Enabled -eq $true)
					{
						$btnSaveLayout.Forecolor = "White"
						$btnSaveLayout.BackColor = "Green"
					}
				
				$btnCancelReloadLayout.Visible = $true
				If ($btnCancelReloadLayout.Enabled -eq $true)
					{
						$btnCancelReloadLayout.Forecolor = "White"
						$btnCancelReloadLayout.BackColor = "Red"
					}
				

				ModifyPanels "Disable" "SyncFrom"
				$cbxSyncToRepository.Enabled = $false
				ModifyPanels "Disable" "CommitToxLights"
			}
			Else
				{

				}
	}
	
Function MoveModelsToFromLayout ($strAddRemove, $strModelName)
	{
		If ($strModelName -and $lbxLayouts.SelectedItem)
			{
				If ($strAddRemove -eq "ADD")
					{
						# $lbxRepositoryModels.BeginUpdate()
						$lbxLayoutModels.BeginUpdate()
							
							$lbxLayoutModels.Items.Add($strModelName)
							# $lbxRepositoryModels.Items.Remove($strModelName)
					
						# $lbxRepositoryModels.EndUpdate()
						$lbxLayoutModels.EndUpdate()

						LayoutUpdatesPending $true

						# Set the flag, lock the listbox, disable the form submit button and enable the layout buttons
						$script:boolLayoutModelsChanged = $true
						# $lbxLayouts.Enabled = $false

						# $btnSaveToFile.Enabled = $false
						# $btnSaveToFile.Visible = $false
						# $btnSaveToFile.BackColor = "WhiteSmoke"
						# $btnFormSubmit.Enabled = $false
						# $btnFormSubmit.BackColor = "WhiteSmoke"

						# $btnSaveLayout.Visible = $true
						# If ($btnSaveLayout.Enabled -eq $true)
						# 	{
						# 		$btnSaveLayout.Forecolor = "White"
						# 		$btnSaveLayout.BackColor = "Green"
						# 	}
						
						# $btnCancelReloadLayout.Visible = $true
						# If ($btnCancelReloadLayout.Enabled -eq $true)
						# 	{
						# 		$btnCancelReloadLayout.Forecolor = "White"
						# 		$btnCancelReloadLayout.BackColor = "Red"
						# 	}
						

						# ModifyPanels "Disable" "SyncFrom"
						# $cbxSyncToRepository.Enabled = $false
						# ModifyPanels "Disable" "CommitToxLights"

					}
					ElseIf ($strAddRemove -eq "REMOVE")
						{
							# $lbxRepositoryModels.BeginUpdate()
							$lbxLayoutModels.BeginUpdate()
						
								# $lbxRepositoryModels.Items.Add($strModelName)
								$lbxLayoutModels.Items.Remove($strModelName)
							
							# $lbxRepositoryModels.EndUpdate()
							$lbxLayoutModels.EndUpdate()
							
							LayoutUpdatesPending $true

							# Set the flag, lock the listbox, disable the form submit button and enable the layout buttons
							$script:boolLayoutModelsChanged = $true
							# $lbxLayouts.Enabled = $false

							# $btnSaveToFile.Enabled = $false
							# $btnSaveToFile.Visible = $false
							# $btnSaveToFile.BackColor = "WhiteSmoke"
							# $btnFormSubmit.Enabled = $false
							# $btnFormSubmit.BackColor = "WhiteSmoke"
							
							# $btnSaveLayout.Visible = $true
							# If ($btnSaveLayout.Enabled -eq $true)
							# 	{
							# 		$btnSaveLayout.Forecolor = "White"
							# 		$btnSaveLayout.BackColor = "Green"
							# 	}
							
							# $btnCancelReloadLayout.Visible = $true
							# If ($btnCancelReloadLayout.Enabled -eq $true)
							# 	{
							# 		$btnCancelReloadLayout.Forecolor = "White"
							# 		$btnCancelReloadLayout.BackColor = "Red"
							# 	}

							# ModifyPanels "Disable" "SyncFrom"
							# $cbxSyncToRepository.Enabled = $false
							# ModifyPanels "Disable" "CommitToxLights"
						}
						Else
							{
								LogWrite "WARNING" "Modify Layout Models called with invalid parameter ($strAddRemove)"
							}
			}
	
	}


Function MoveModelGroupsToFromLayout ($strAddRemove, $strModelGroupName)
	{
		If ($strModelGroupName -and $lbxLayouts.SelectedItem)
			{
				If ($strAddRemove -eq "ADD")
					{
						$lbxRepositoryModelGroups.BeginUpdate()
						$lbxLayoutModelGroups.BeginUpdate()
							
							$lbxLayoutModelGroups.Items.Add($strModelGroupName)
							$lbxRepositoryModelGroups.Items.Remove($strModelGroupName)
					
						$lbxRepositoryModelGroups.EndUpdate()
						$lbxLayoutModelGroups.EndUpdate()

						LayoutUpdatesPending $true

						# Set the flag, lock the listbox, disable the form submit button and enable the layout buttons
						$script:boolLayoutModelGroupsChanged = $true
						# $lbxLayouts.Enabled = $false

						# $btnSaveToFile.Enabled = $false
						# $btnSaveToFile.Visible = $false
						# $btnSaveToFile.BackColor = "WhiteSmoke"
						# $btnFormSubmit.Enabled = $false
						# $btnFormSubmit.BackColor = "WhiteSmoke"
						
						# $btnSaveLayout.Visible = $true
						# $btnCancelReloadLayout.Visible = $true

					}
					ElseIf ($strAddRemove -eq "REMOVE")
						{
							$lbxRepositoryModelGroups.BeginUpdate()
							$lbxLayoutModelGroups.BeginUpdate()
						
								$lbxRepositoryModelGroups.Items.Add($strModelGroupName)
								$lbxLayoutModelGroups.Items.Remove($strModelGroupName)
							
							$lbxRepositoryModelGroups.EndUpdate()
							$lbxLayoutModelGroups.EndUpdate()
							
							LayoutUpdatesPending $true

							# Set the flag, lock the listbox, disable the form submit button and enable the layout buttons
							$script:boolLayoutModelGroupsChanged = $true
							# $lbxLayouts.Enabled = $false

							# $btnSaveToFile.Enabled = $false
							# $btnSaveToFile.Visible = $false
							# $btnSaveToFile.BackColor = "WhiteSmoke"
							# $btnFormSubmit.Enabled = $false
							# $btnFormSubmit.BackColor = "WhiteSmoke"
							
							# $btnSaveLayout.Visible = $true
							# $btnCancelReloadLayout.Visible = $true

						}
						Else
							{
								LogWrite "WARNING" "Modify Layout Model Groups called with invalid parameter ($strAddRemove)"
							}
			}
	
	}



Function MoveViewsToFromLayout ($strAddRemove, $strViewName)
	{
		If ($strViewName -and $lbxLayouts.SelectedItem)
			{
				If ($strAddRemove -eq "ADD")
					{
						$lbxRepositoryViews.BeginUpdate()
						$lbxLayoutViews.BeginUpdate()
							
							$lbxLayoutViews.Items.Add($strViewName)
							$lbxRepositoryViews.Items.Remove($strViewName)
					
						$lbxRepositoryViews.EndUpdate()
						$lbxLayoutViews.EndUpdate()

						LayoutUpdatesPending $true

						# Set the flag, lock the listbox, disable the form submit button and enable the layout buttons
						$script:boolLayoutViewsChanged = $true
						# $lbxLayouts.Enabled = $false
						
						# $btnSaveToFile.Enabled = $false
						# $btnSaveToFile.Visible = $false
						# $btnSaveToFile.BackColor = "WhiteSmoke"
						# $btnFormSubmit.Enabled = $false
						# $btnFormSubmit.BackColor = "WhiteSmoke"
						
						# $btnSaveLayout.Visible = $true
						# $btnCancelReloadLayout.Visible = $true

					}
					ElseIf ($strAddRemove -eq "REMOVE")
						{
							$lbxRepositoryViews.BeginUpdate()
							$lbxLayoutViews.BeginUpdate()
						
								$lbxRepositoryViews.Items.Add($strViewName)
								$lbxLayoutViews.Items.Remove($strViewName)
							
							$lbxRepositoryViews.EndUpdate()
							$lbxLayoutViews.EndUpdate()
							
							LayoutUpdatesPending $true

							# Set the flag, lock the listbox, disable the form submit button and enable the layout buttons
							$script:boolLayoutViewsChanged = $true
							# $lbxLayouts.Enabled = $false
							
							# $btnSaveToFile.Enabled = $false
							# $btnSaveToFile.Visible = $false
							# $btnSaveToFile.BackColor = "WhiteSmoke"
							# $btnFormSubmit.Enabled = $false
							# $btnFormSubmit.BackColor = "WhiteSmoke"

							# $btnSaveLayout.Visible = $true
							# $btnCancelReloadLayout.Visible = $true

						}
						Else
							{
								LogWrite "WARNING" "Modify Layout Model Groups called with invalid parameter ($strAddRemove)"
							}
			}
	
	}


# Initialize the Copy/Move/Delete functions
Function InitializeCopyMoveDelete ($strPanel, $strTask)
	{
		LogWrite "VERBOSE" "Initialize Copy/Move/Delete Functions - $strPanel - $strTask"

		Switch ($strPanel)
			{
				"Models"
					{
						Switch ($strTask)
							{
								"Prep"
									{
										# Enable the group box
										$grpCopyMoveModelsToLayout.Enabled = $true

										# Clear the drop down
										$cboCopyMoveModelsToLayoutList.Items.Clear()
										$cboCopyMoveModelsToLayoutList.Items.Add("")
										$cboCopyMoveModelsToLayoutList.Enabled = $false

										# Reset the Copy Button
										$btnCopyModelsToLayout.Enabled = $false
										$btnCopyModelsToLayout.Text = "Copy Model"
										$btnCopyModelsToLayout.Forecolor = "Gray"
										$btnCopyModelsToLayout.BackColor = "LightGray"

										# Reset the Move Button
										$btnMoveModelsToLayout.Enabled = $false
										$btnMoveModelsToLayout.Text = "Move Model"
										$btnMoveModelsToLayout.Forecolor = "Gray"
										$btnMoveModelsToLayout.BackColor = "LightGray"

										# Set the Delete Button
										$btnDeleteModelsFromLayout.Enabled = $false
										$btnDeleteModelsFromLayout.Text = "Delete Model From Layout"
										$btnDeleteModelsFromLayout.Forecolor = "Gray"
										$btnDeleteModelsFromLayout.BackColor = "LightGray"
									}

								"NoModelSelected"
									{
										# Enable the group box
										$grpCopyMoveModelsToLayout.Enabled = $true

										# Set the drop down
										$cboCopyMoveModelsToLayoutList.SelectedItem = ""
										$cboCopyMoveModelsToLayoutList.Enabled = $false

										# Reset the Copy Button
										$btnCopyModelsToLayout.Enabled = $false
										$btnCopyModelsToLayout.Text = "Copy Model"
										$btnCopyModelsToLayout.Forecolor = "Gray"
										$btnCopyModelsToLayout.BackColor = "LightGray"

										# Reset the Move Button
										$btnMoveModelsToLayout.Enabled = $false
										$btnMoveModelsToLayout.Text = "Move Model"
										$btnMoveModelsToLayout.Forecolor = "Gray"
										$btnMoveModelsToLayout.BackColor = "LightGray"

										# Set the Delete Button
										$btnDeleteModelsFromLayout.Enabled = $false
										$btnDeleteModelsFromLayout.Text = "Delete Model From Layout"
										$btnDeleteModelsFromLayout.Forecolor = "Gray"
										$btnDeleteModelsFromLayout.BackColor = "LightGray"
										
									}
								
								"ModelSelected"
									{
										# Enable the group box
										$grpCopyMoveModelsToLayout.Enabled = $true

										# Set the drop down
										$cboCopyMoveModelsToLayoutList.Enabled = $true

										# If no target layout is selected, disable the Copy/Move buttons
										If ($cboCopyMoveModelsToLayoutList.SelectedItem -eq "")
											{
												# Reset the Copy Button
												$btnCopyModelsToLayout.Enabled = $false
												# $btnCopyModelsToLayout.Text = "Copy Model"
												$btnCopyModelsToLayout.Forecolor = "Gray"
												$btnCopyModelsToLayout.BackColor = "LightGray"

												# Reset the Move Button
												$btnMoveModelsToLayout.Enabled = $false
												# $btnMoveModelsToLayout.Text = "Move Model"
												$btnMoveModelsToLayout.Forecolor = "Gray"
												$btnMoveModelsToLayout.BackColor = "LightGray"
											}

										# Set the Delete Button
										$btnDeleteModelsFromLayout.Enabled = $true
										$btnDeleteModelsFromLayout.Text = "Delete Model From Layout"
										$btnDeleteModelsFromLayout.Forecolor = "White"
										$btnDeleteModelsFromLayout.BackColor = "Red"
										
									}

								"TargetSelected"
									{
										# Enable the group box
										$grpCopyMoveModelsToLayout.Enabled = $true

										# Set the drop down
										$cboCopyMoveModelsToLayoutList.Enabled = $true

										# Set the Copy Button
										$btnCopyModelsToLayout.Enabled = $true
										# $btnCopyModelsToLayout.Text = "Copy Model"
										$btnCopyModelsToLayout.Forecolor = "Green"
										$btnCopyModelsToLayout.BackColor = "MintCream"

										# Set the Move Button
										$btnMoveModelsToLayout.Enabled = $true
										# $btnMoveModelsToLayout.Text = "Move Model"
										$btnMoveModelsToLayout.Forecolor = "Blue"
										$btnMoveModelsToLayout.BackColor = "Azure"

										# Set the Delete Button
										$btnDeleteModelsFromLayout.Enabled = $true
										$btnDeleteModelsFromLayout.Text = "Delete Model From Layout"
										$btnDeleteModelsFromLayout.Forecolor = "White"
										$btnDeleteModelsFromLayout.BackColor = "Red"
										
									}
								"Disable"
									{
										# Disable the group box
										$grpCopyMoveModelsToLayout.Enabled = $false

										# Clear the drop down
										$cboCopyMoveModelsToLayoutList.SelectedItem = ""
										$cboCopyMoveModelsToLayoutList.Enabled = $false

										# Reset the Copy Button
										$btnCopyModelsToLayout.Enabled = $false
										$btnCopyModelsToLayout.Text = "Copy Model"
										$btnCopyModelsToLayout.Forecolor = "Gray"
										$btnCopyModelsToLayout.BackColor = "LightGray"

										# Reset the Move Button
										$btnMoveModelsToLayout.Enabled = $false
										$btnMoveModelsToLayout.Text = "Move Model"
										$btnMoveModelsToLayout.Forecolor = "Gray"
										$btnMoveModelsToLayout.BackColor = "LightGray"

										# Reset the Delete Button
										$btnDeleteModelsFromLayout.Enabled = $false
										$btnDeleteModelsFromLayout.Text = "Delete Model From Layout"
										$btnDeleteModelsFromLayout.Forecolor = "Gray"
										$btnDeleteModelsFromLayout.BackColor = "LightGray"
									}

							}
					}

				"ModelGroups"
					{
						Switch ($strTask)
						{
							"Prep"
								{
									# Enable the group box
									$grpCopyMoveModelGroupsToLayout.Enabled = $true

									# Clear the drop down
									$cboCopyMoveModelGroupsToLayoutList.Items.Clear()
									$cboCopyMoveModelGroupsToLayoutList.Items.Add("")
									$cboCopyMoveModelGroupsToLayoutList.Enabled = $false

									# Reset the Copy Button
									$btnCopyModelGroupsToLayout.Enabled = $false
									$btnCopyModelGroupsToLayout.Text = "Copy Model Group"
									$btnCopyModelGroupsToLayout.Forecolor = "Gray"
									$btnCopyModelGroupsToLayout.BackColor = "LightGray"

									# Reset the Move Button
									$btnMoveModelGroupsToLayout.Enabled = $false
									$btnMoveModelGroupsToLayout.Text = "Move Model Group"
									$btnMoveModelGroupsToLayout.Forecolor = "Gray"
									$btnMoveModelGroupsToLayout.BackColor = "LightGray"

									# Set the Delete Button
									$btnDeleteModelGroupsFromLayout.Enabled = $false
									$btnDeleteModelGroupsFromLayout.Text = "Delete Model Group From Layout"
									$btnDeleteModelGroupsFromLayout.Forecolor = "Gray"
									$btnDeleteModelGroupsFromLayout.BackColor = "LightGray"
								}

							"NoModelGroupSelected"
								{
									# Enable the group box
									$grpCopyMoveModelGroupsToLayout.Enabled = $true

									# Set the drop down
									$cboCopyMoveModelGroupsToLayoutList.SelectedItem = ""
									$cboCopyMoveModelGroupsToLayoutList.Enabled = $false

									# Reset the Copy Button
									$btnCopyModelGroupsToLayout.Enabled = $false
									$btnCopyModelGroupsToLayout.Text = "Copy Model Group"
									$btnCopyModelGroupsToLayout.Forecolor = "Gray"
									$btnCopyModelGroupsToLayout.BackColor = "LightGray"

									# Reset the Move Button
									$btnMoveModelGroupsToLayout.Enabled = $false
									$btnMoveModelGroupsToLayout.Text = "Move Model Group"
									$btnMoveModelGroupsToLayout.Forecolor = "Gray"
									$btnMoveModelGroupsToLayout.BackColor = "LightGray"

									# Set the Delete Button
									$btnDeleteModelGroupsFromLayout.Enabled = $false
									$btnDeleteModelGroupsFromLayout.Text = "Delete Model Group From Layout"
									$btnDeleteModelGroupsFromLayout.Forecolor = "Gray"
									$btnDeleteModelGroupsFromLayout.BackColor = "LightGray"
									
								}
							
							"ModelGroupSelected"
								{
									# Enable the group box
									$grpCopyMoveModelGroupsToLayout.Enabled = $true

									# Set the drop down
									$cboCopyMoveModelGroupsToLayoutList.Enabled = $true

									# If no target layout is selected, disable the Copy/Move buttons
									If ($cboCopyMoveModelGroupsToLayoutList.SelectedItem -eq "")
										{
											# Reset the Copy Button
											$btnCopyModelGroupsToLayout.Enabled = $false
											# $btnCopyModelGroupsToLayout.Text = "Copy Model Group"
											$btnCopyModelGroupsToLayout.Forecolor = "Gray"
											$btnCopyModelGroupsToLayout.BackColor = "LightGray"

											# Reset the Move Button
											$btnMoveModelGroupsToLayout.Enabled = $false
											# $btnMoveModelGroupsToLayout.Text = "Move Model Group"
											$btnMoveModelGroupsToLayout.Forecolor = "Gray"
											$btnMoveModelGroupsToLayout.BackColor = "LightGray"
										}

									# Set the Delete Button
									$btnDeleteModelGroupsFromLayout.Enabled = $true
									$btnDeleteModelGroupsFromLayout.Text = "Delete Model Group From Layout"
									$btnDeleteModelGroupsFromLayout.Forecolor = "White"
									$btnDeleteModelGroupsFromLayout.BackColor = "Red"
									
								}

							"TargetSelected"
								{
									# Enable the group box
									$grpCopyMoveModelGroupsToLayout.Enabled = $true

									# Set the drop down
									$cboCopyMoveModelGroupsToLayoutList.Enabled = $true

									# Set the Copy Button
									$btnCopyModelGroupsToLayout.Enabled = $true
									# $btnCopyModelGroupsToLayout.Text = "Copy Model Group"
									$btnCopyModelGroupsToLayout.Forecolor = "Green"
									$btnCopyModelGroupsToLayout.BackColor = "MintCream"

									# Set the Move Button
									$btnMoveModelGroupsToLayout.Enabled = $true
									# $btnMoveModelGroupsToLayout.Text = "Move Model Group"
									$btnMoveModelGroupsToLayout.Forecolor = "Blue"
									$btnMoveModelGroupsToLayout.BackColor = "Azure"

									# Set the Delete Button
									$btnDeleteModelGroupsFromLayout.Enabled = $true
									$btnDeleteModelGroupsFromLayout.Text = "Delete Model Group From Layout"
									$btnDeleteModelGroupsFromLayout.Forecolor = "White"
									$btnDeleteModelGroupsFromLayout.BackColor = "Red"
									
								}
							"Disable"
								{
									# Disable the group box
									$grpCopyMoveModelGroupsToLayout.Enabled = $false

									# Clear the drop down
									$cboCopyMoveModelGroupsToLayoutList.SelectedItem = ""
									$cboCopyMoveModelGroupsToLayoutList.Enabled = $false

									# Reset the Copy Button
									$btnCopyModelGroupsToLayout.Enabled = $false
									$btnCopyModelGroupsToLayout.Text = "Copy ModelGroup"
									$btnCopyModelGroupsToLayout.Forecolor = "Gray"
									$btnCopyModelGroupsToLayout.BackColor = "LightGray"

									# Reset the Move Button
									$btnMoveModelGroupsToLayout.Enabled = $false
									$btnMoveModelGroupsToLayout.Text = "Move ModelGroup"
									$btnMoveModelGroupsToLayout.Forecolor = "Gray"
									$btnMoveModelGroupsToLayout.BackColor = "LightGray"

									# Reset the Delete Button
									$btnDeleteModelGroupsFromLayout.Enabled = $false
									$btnDeleteModelGroupsFromLayout.Text = "Delete Model Group From Layout"
									$btnDeleteModelGroupsFromLayout.Forecolor = "Gray"
									$btnDeleteModelGroupsFromLayout.BackColor = "LightGray"
								}

						}
					}


				"Views"
					{
						Switch ($strTask)
						{
							"Prep"
								{
									# Enable the group box
									$grpCopyMoveViewsToLayout.Enabled = $true

									# Clear the drop down
									$cboCopyMoveViewsToLayoutList.Items.Clear()
									$cboCopyMoveViewsToLayoutList.Items.Add("")
									$cboCopyMoveViewsToLayoutList.Enabled = $false

									# Reset the Copy Button
									$btnCopyViewsToLayout.Enabled = $false
									$btnCopyViewsToLayout.Text = "Copy View"
									$btnCopyViewsToLayout.Forecolor = "Gray"
									$btnCopyViewsToLayout.BackColor = "LightGray"

									# Reset the Move Button
									$btnMoveViewsToLayout.Enabled = $false
									$btnMoveViewsToLayout.Text = "Move View"
									$btnMoveViewsToLayout.Forecolor = "Gray"
									$btnMoveViewsToLayout.BackColor = "LightGray"

									# Set the Delete Button
									$btnDeleteViewsFromLayout.Enabled = $false
									$btnDeleteViewsFromLayout.Text = "Delete View From Layout"
									$btnDeleteViewsFromLayout.Forecolor = "Gray"
									$btnDeleteViewsFromLayout.BackColor = "LightGray"
								}

							"NoViewSelected"
								{
									# Enable the group box
									$grpCopyMoveViewsToLayout.Enabled = $true

									# Set the drop down
									$cboCopyMoveViewsToLayoutList.SelectedItem = ""
									$cboCopyMoveViewsToLayoutList.Enabled = $false

									# Reset the Copy Button
									$btnCopyViewsToLayout.Enabled = $false
									$btnCopyViewsToLayout.Text = "Copy View"
									$btnCopyViewsToLayout.Forecolor = "Gray"
									$btnCopyViewsToLayout.BackColor = "LightGray"

									# Reset the Move Button
									$btnMoveViewsToLayout.Enabled = $false
									$btnMoveViewsToLayout.Text = "Move View"
									$btnMoveViewsToLayout.Forecolor = "Gray"
									$btnMoveViewsToLayout.BackColor = "LightGray"

									# Set the Delete Button
									$btnDeleteViewsFromLayout.Enabled = $false
									$btnDeleteViewsFromLayout.Text = "Delete View From Layout"
									$btnDeleteViewsFromLayout.Forecolor = "Gray"
									$btnDeleteViewsFromLayout.BackColor = "LightGray"
									
								}
							
							"ViewSelected"
								{
									# Enable the group box
									$grpCopyMoveViewsToLayout.Enabled = $true

									# Set the drop down
									$cboCopyMoveViewsToLayoutList.Enabled = $true

									# If no target layout is selected, disable the Copy/Move buttons
									If ($cboCopyMoveViewsToLayoutList.SelectedItem -eq "")
										{
											# Reset the Copy Button
											$btnCopyViewsToLayout.Enabled = $false
											# $btnCopyViewsToLayout.Text = "Copy View"
											$btnCopyViewsToLayout.Forecolor = "Gray"
											$btnCopyViewsToLayout.BackColor = "LightGray"

											# Reset the Move Button
											$btnMoveViewsToLayout.Enabled = $false
											# $btnMoveViewsToLayout.Text = "Move View"
											$btnMoveViewsToLayout.Forecolor = "Gray"
											$btnMoveViewsToLayout.BackColor = "LightGray"
										}

									# Set the Delete Button
									$btnDeleteViewsFromLayout.Enabled = $true
									$btnDeleteViewsFromLayout.Text = "Delete View From Layout"
									$btnDeleteViewsFromLayout.Forecolor = "White"
									$btnDeleteViewsFromLayout.BackColor = "Red"
									
								}

							"TargetSelected"
								{
									# Enable the group box
									$grpCopyMoveViewsToLayout.Enabled = $true

									# Set the drop down
									$cboCopyMoveViewsToLayoutList.Enabled = $true

									# Set the Copy Button
									$btnCopyViewsToLayout.Enabled = $true
									# $btnCopyViewsToLayout.Text = "Copy View"
									$btnCopyViewsToLayout.Forecolor = "Green"
									$btnCopyViewsToLayout.BackColor = "MintCream"

									# Set the Move Button
									$btnMoveViewsToLayout.Enabled = $true
									# $btnMoveViewsToLayout.Text = "Move View"
									$btnMoveViewsToLayout.Forecolor = "Blue"
									$btnMoveViewsToLayout.BackColor = "Azure"

									# Set the Delete Button
									$btnDeleteViewsFromLayout.Enabled = $true
									$btnDeleteViewsFromLayout.Text = "Delete View From Layout"
									$btnDeleteViewsFromLayout.Forecolor = "White"
									$btnDeleteViewsFromLayout.BackColor = "Red"
									
								}
							"Disable"
								{
									# Disable the group box
									$grpCopyMoveViewsToLayout.Enabled = $false

									# Clear the drop down
									$cboCopyMoveViewsToLayoutList.SelectedItem = ""
									$cboCopyMoveViewsToLayoutList.Enabled = $false

									# Reset the Copy Button
									$btnCopyViewsToLayout.Enabled = $false
									$btnCopyViewsToLayout.Text = "Copy View"
									$btnCopyViewsToLayout.Forecolor = "Gray"
									$btnCopyViewsToLayout.BackColor = "LightGray"

									# Reset the Move Button
									$btnMoveViewsToLayout.Enabled = $false
									$btnMoveViewsToLayout.Text = "Move View"
									$btnMoveViewsToLayout.Forecolor = "Gray"
									$btnMoveViewsToLayout.BackColor = "LightGray"

									# Reset the Delete Button
									$btnDeleteViewsFromLayout.Enabled = $false
									$btnDeleteViewsFromLayout.Text = "Delete View From Layout"
									$btnDeleteViewsFromLayout.Forecolor = "Gray"
									$btnDeleteViewsFromLayout.BackColor = "LightGray"
								}

						}
					}
			}
	}



# Create the Models panel
Function PopulateContentPanel2
	{
		# Add the list boxes and buttons to manage model work

		# Set the background color
		$pnlContentPanel2.BackColor = "LightBlue"


		
		####################################
		# Sync from xLights 
		####################################

		# Sync From Panel
		If (!($pnlSyncFrom)) 
			{
				$script:pnlSyncFrom = New-Object System.Windows.Forms.Panel
				$pnlSyncFrom.Name = "SyncFromPanel"
				$pnlSyncFrom.Left = 10
				$pnlSyncFrom.Top = 10
				$pnlSyncFrom.Width = ($intCurrentFormClientWidth *.3) + 10 - 44 # +10 to allow a little panel on the right / -44 to allow 10 from the edges and between panels
				$pnlSyncFrom.Height = $pnlContentPanel6.Height * .2 + 20
				$pnlSyncFrom.BackColor = "MintCream"
				$pnlSyncFrom.Anchor = "Top,Left,Right"
				$pnlContentPanel2.Controls.Add($pnlSyncFrom)
			}

		# Add the Sync From xLights Button
		If (!($btnSyncFromxLights)) 
			{
				$script:btnSyncFromxLights = New-Object Windows.Forms.Button
				$btnSyncFromxLights.Left = 10
				$btnSyncFromxLights.Top = 10
				$btnSyncFromxLights.Text = "Sync From xLights"
				$btnSyncFromxLights.Width = 160
				$btnSyncFromxLights.TextAlign = "MiddleCenter"
				$btnSyncFromxLights.Cursor = "Hand"
				$btnSyncFromxLights.ForeColor = "Black"
				$btnSyncFromxLights.BackColor = "WhiteSmoke"
				$btnSyncFromxLights.Anchor = "Left,Top"
				$btnSyncFromxLights.Add_Click({

						If ($rdoUpdateExistingResources.Checked -eq $true)
							{
								$boolSyncAllNodes = [System.Windows.Forms.MessageBox]::Show("Are you sure you want to update all existing resources in $(If ($cbxSyncToRepository.Checked -eq $true) {"- Repository (Recovery) -"} Else {$lbxLayouts.SelectedItem})?" , "Update All Existing?", "YesNo", "Exclamation")

								If ($boolSyncAllNodes -eq "Yes")
									{
										$dtStartSync = Get-Date

										# Disable the controls
										$btnSyncFromxLights.Text = "Updating...."
										$btnSyncFromxLights.Forecolor = "Blue"
														
										# Call the functions to sync the models, model groups, and views.  If Sync to Repository is checked, sync to the Repository layout
										SyncxLightsToLayout -strLayoutName $(If ($cbxSyncToRepository.Checked -eq $true) {"- Repository (Recovery) -"} Else {$lbxLayouts.SelectedItem}) -strNodeType "Model" -boolOnlySyncExisting $true -boolExcludeCommonLayoutResources $cbxExcludeCommonLayoutResources.Checked -boolOverridePrompts $true
										SyncxLightsToLayout -strLayoutName $(If ($cbxSyncToRepository.Checked -eq $true) {"- Repository (Recovery) -"} Else {$lbxLayouts.SelectedItem}) -strNodeType "ModelGroup" -boolOnlySyncExisting $true -boolExcludeCommonLayoutResources $cbxExcludeCommonLayoutResources.Checked -boolOverridePrompts $true
										SyncxLightsToLayout -strLayoutName $(If ($cbxSyncToRepository.Checked -eq $true) {"- Repository (Recovery) -"} Else {$lbxLayouts.SelectedItem}) -strNodeType "View" -boolOnlySyncExisting $true -boolExcludeCommonLayoutResources $cbxExcludeCommonLayoutResources.Checked -boolOverridePrompts $true

										# # If Sync to Repository, reload the Repository list boxes - Removed as it's not really necessary to show these resources until a layout is selected.
										# If ($cbxSyncToRepository.Checked -eq $true)
										# 	{
										# 		LoadRepositoryResourcesFromCompanionXML -strNodeType "Model" -boolLoadListboxes $true -boolCheckForUpdates $false
										# 		LoadRepositoryResourcesFromCompanionXML -strNodeType "ModelGroup" -boolLoadListboxes $true -boolCheckForUpdates $false
										# 		LoadRepositoryResourcesFromCompanionXML -strNodeType "View" -boolLoadListboxes $true -boolCheckForUpdates $false
										# 	}

										# If a layout is selected, reload the models
										If ($lbxLayouts.SelectedItem)
										{
											LoadLayoutResourcesFromCompanionXML -strLayoutName $lbxLayouts.SelectedItem -strNodeType "Model"
											LoadLayoutResourcesFromCompanionXML -strLayoutName $lbxLayouts.SelectedItem -strNodeType "ModelGroup"
											LoadLayoutResourcesFromCompanionXML -strLayoutName $lbxLayouts.SelectedItem -strNodeType "View"
										}

										# Disable Sync From
										ModifyPanels "Disable" "SyncFrom"
														
										$cbxSyncToRepository.ForeColor = "Black"

										$intSyncDuration = New-TimeSpan -Start $dtStartSync -End $(Get-Date)
										
										$btnSyncFromxLights.Text = "Sync Complete in $([math]::Round($intSyncDuration.TotalSeconds))s"
									}
							}
							ElseIf ($rdoSyncSelectedResources.Checked -eq $true)
								{
									ShowSyncSelectedForm -strLayoutName $(If ($cbxSyncToRepository.Checked -eq $true) {"- Repository (Recovery) -"} Else {$lbxLayouts.SelectedItem}) -boolOverridePrompts $cbxPromptToOverwriteResources.Checked -boolPromptOnNewModels $cbxPromptToCreateNewInCompanion.Checked
								}
								ElseIf ($rdoSyncAllResources.Checked -eq $true)
									{
										$boolSyncAllNodes = [System.Windows.Forms.MessageBox]::Show("Are you sure you want to Sync All to $(If ($cbxSyncToRepository.Checked -eq $true) {"- Repository (Recovery) -"} Else {$lbxLayouts.SelectedItem})?" , "Sync All?", "YesNo", "Exclamation")

										If ($boolSyncAllNodes -eq "Yes")
											{
												$dtStartSync = Get-Date

												# Disable the controls
												$btnSyncFromxLights.Text = "Processing...."
												$btnSyncFromxLights.Forecolor = "Blue"
												
												# Call the functions to sync the models, model groups, and views.  If Sync to Repository is checked, sync to the Repository layout
												SyncxLightsToLayout -strLayoutName $(If ($cbxSyncToRepository.Checked -eq $true) {"- Repository (Recovery) -"} Else {$lbxLayouts.SelectedItem}) -strNodeType "Model" -boolOnlySyncExisting $false -boolExcludeCommonLayoutResources $cbxExcludeCommonLayoutResources.Checked -boolOverridePrompts $true
												SyncxLightsToLayout -strLayoutName $(If ($cbxSyncToRepository.Checked -eq $true) {"- Repository (Recovery) -"} Else {$lbxLayouts.SelectedItem}) -strNodeType "ModelGroup" -boolOnlySyncExisting $false -boolExcludeCommonLayoutResources $cbxExcludeCommonLayoutResources.Checked -boolOverridePrompts $true
												SyncxLightsToLayout -strLayoutName $(If ($cbxSyncToRepository.Checked -eq $true) {"- Repository (Recovery) -"} Else {$lbxLayouts.SelectedItem}) -strNodeType "View" -boolOnlySyncExisting $false -boolExcludeCommonLayoutResources $cbxExcludeCommonLayoutResources.Checked -boolOverridePrompts $true

												# # If Sync to Repository, reload the Repository list boxes - Removed as it's not really necessary to show these resources until a layout is selected.
												# If ($cbxSyncToRepository.Checked -eq $true)
												# 	{
												# 		LoadRepositoryResourcesFromCompanionXML -strNodeType "Model" -boolLoadListboxes $true -boolCheckForUpdates $false
												# 		LoadRepositoryResourcesFromCompanionXML -strNodeType "ModelGroup" -boolLoadListboxes $true -boolCheckForUpdates $false
												# 		LoadRepositoryResourcesFromCompanionXML -strNodeType "View" -boolLoadListboxes $true -boolCheckForUpdates $false
												# 	}

												# If a layout is selected, reload the models
												If ($lbxLayouts.SelectedItem)
													{
														LoadLayoutResourcesFromCompanionXML -strLayoutName $lbxLayouts.SelectedItem -strNodeType "Model"
														LoadLayoutResourcesFromCompanionXML -strLayoutName $lbxLayouts.SelectedItem -strNodeType "ModelGroup"
														LoadLayoutResourcesFromCompanionXML -strLayoutName $lbxLayouts.SelectedItem -strNodeType "View"
													}

												# The panel shouldn't be reloaded or enabled until the Save Layout process has run.
												# # Load the Companion layouts
												# LoadLayoutsFromCompanionXML

												# # Enable the Layouts panel
												# ModifyPanels "Enable" "Layouts" 

												# Disable Sync From
												ModifyPanels "Disable" "SyncFrom"
												
												$cbxSyncToRepository.ForeColor = "Black"

												$intSyncDuration = New-TimeSpan -Start $dtStartSync -End $(Get-Date)
												
												$btnSyncFromxLights.Text = "Sync Complete in $([math]::Round($intSyncDuration.TotalSeconds))s"
											}
									}

						

					})
					
				$pnlSyncFrom.Controls.Add($btnSyncFromxLights)
			}

		
		# Create the Sync To Layout label
		If (!($lblSyncToLayout)) 
			{
				$script:lblSyncToLayout = New-Object System.Windows.Forms.Label
				$lblSyncToLayout.Width = $pnlSyncFrom.Width - $btnSyncFromxLights.Right - 20
				$lblSyncToLayout.Height = 20
				$lblSyncToLayout.Left = $btnSyncFromxLights.Right + 10
				$lblSyncToLayout.Top = $btnSyncFromxLights.Top + 2
				$lblSyncToLayout.TextAlign = "MiddleLeft"
				$lblSyncToLayout.ForeColor = "Blue"
				$lblSyncToLayout.Backcolor = "Transparent"
				$lblSyncToLayout.Text = ""
				$lblSyncToLayout.Anchor = "Left,Top"
		#		$lblSyncToLayout.Cursor = "Hand"
				# $lblSyncToLayout.Add_Click({
				# })
				$pnlSyncFrom.Controls.Add($lblSyncToLayout)
			}


		# Add the All/Selected Radio Button Panel
		If (!($pnlSyncAllSelected)) 
		{
			$script:pnlSyncAllSelected = New-Object System.Windows.Forms.Panel
			$pnlSyncAllSelected.Name = "SyncAllSelectedPanel"
			$pnlSyncAllSelected.Left = $btnSyncFromxLights.Left + 10
			$pnlSyncAllSelected.Top = $btnSyncFromxLights.Bottom +5
			$pnlSyncAllSelected.Width = $pnlSyncFrom.Width - 20
			$pnlSyncAllSelected.Height = 22
			$pnlSyncAllSelected.BackColor = "Transparent"
			$pnlSyncAllSelected.Anchor = "Top,Left,Right"
			$pnlSyncFrom.Controls.Add($pnlSyncAllSelected)
		}


		# Add the Update Existing Radio Button
		If (!($rdoUpdateExistingResources)) 
		{
			$script:rdoUpdateExistingResources = New-Object Windows.Forms.RadioButton
			$rdoUpdateExistingResources.Left = 0
			$rdoUpdateExistingResources.Top = 0
			$rdoUpdateExistingResources.Text = "Update Existing"
			$rdoUpdateExistingResources.Width = $pnlSyncAllSelected.Width / 3
			$rdoUpdateExistingResources.TextAlign = "MiddleLeft"
			$rdoUpdateExistingResources.Cursor = "Hand"
			$rdoUpdateExistingResources.ForeColor = "Black"
			$rdoUpdateExistingResources.BackColor = "Transparent"
			$rdoUpdateExistingResources.Checked = $true
			$rdoUpdateExistingResources.Anchor = "Left,Top"
			$rdoUpdateExistingResources.Add_Click({

					If ($rdoSyncAllResources.Checked) 
						{
							$btnSyncFromxLights.Text = "Sync All From xLights"
							$lblSyncToLayout.Text = "... $(If ($rdoUpdateExistingResources.Checked -eq $true) {"in"} Else {"to"}) '$($lbxLayouts.SelectedItem)' Layout"
							$cbxExcludeCommonLayoutResources.Visible = $true
							$cbxPromptToOverwriteResources.Visible = $true
						}
						ElseIf ($rdoSyncSelectedResources.Checked)
							{
								$btnSyncFromxLights.Text = "Select Resources to Sync"
								$lblSyncToLayout.Text = "... $(If ($rdoUpdateExistingResources.Checked -eq $true) {"in"} Else {"to"}) '$($lbxLayouts.SelectedItem)' Layout"
								$cbxExcludeCommonLayoutResources.Visible = $false
								$cbxPromptToOverwriteResources.Visible = $false
							}
							ElseIf ($rdoUpdateExistingResources.Checked)
								{
									$btnSyncFromxLights.Text = "Update Existing Resources"
									$lblSyncToLayout.Text = "... $(If ($rdoUpdateExistingResources.Checked -eq $true) {"in"} Else {"to"}) '$($lbxLayouts.SelectedItem)' Layout"
									$cbxExcludeCommonLayoutResources.Visible = $true
									$cbxPromptToOverwriteResources.Visible = $true
								}
			})
			$pnlSyncAllSelected.Controls.Add($rdoUpdateExistingResources)
		}
		
		# Add the Sync Selected Radio Button
		If (!($rdoSyncSelectedResources)) 
			{
				$script:rdoSyncSelectedResources = New-Object Windows.Forms.RadioButton
				$rdoSyncSelectedResources.Left = $rdoUpdateExistingResources.Right
				$rdoSyncSelectedResources.Top = 0
				$rdoSyncSelectedResources.Text = "Sync Selected"
				$rdoSyncSelectedResources.Width = $pnlSyncAllSelected.Width / 3
				$rdoSyncSelectedResources.TextAlign = "MiddleLeft"
				$rdoSyncSelectedResources.Cursor = "Hand"
				$rdoSyncSelectedResources.ForeColor = "Black"
				$rdoSyncSelectedResources.BackColor = "Transparent"
				$rdoSyncSelectedResources.Checked = $false
				$rdoSyncSelectedResources.Anchor = "Left,Top"
				$rdoSyncSelectedResources.Add_Click({
						
					If ($rdoSyncAllResources.Checked) 
						{
							$btnSyncFromxLights.Text = "Sync All From xLights"
							$lblSyncToLayout.Text = "... $(If ($rdoUpdateExistingResources.Checked -eq $true) {"in"} Else {"to"}) '$($lbxLayouts.SelectedItem)' Layout"
							$cbxExcludeCommonLayoutResources.Visible = $true
							$cbxPromptToOverwriteResources.Visible = $true
						}
						ElseIf ($rdoSyncSelectedResources.Checked)
							{
								$btnSyncFromxLights.Text = "Select Resources to Sync"
								$lblSyncToLayout.Text = "... $(If ($rdoUpdateExistingResources.Checked -eq $true) {"in"} Else {"to"}) '$($lbxLayouts.SelectedItem)' Layout"
								$cbxExcludeCommonLayoutResources.Visible = $false
								$cbxPromptToOverwriteResources.Visible = $false
							}
							ElseIf ($rdoUpdateExistingResources.Checked)
								{
									$btnSyncFromxLights.Text = "Updated Existing Resources"
									$lblSyncToLayout.Text = "... $(If ($rdoUpdateExistingResources.Checked -eq $true) {"in"} Else {"to"}) '$($lbxLayouts.SelectedItem)' Layout"
									$cbxExcludeCommonLayoutResources.Visible = $true
									$cbxPromptToOverwriteResources.Visible = $true
								}
				})
				$pnlSyncAllSelected.Controls.Add($rdoSyncSelectedResources)
			}

			# Add the Sync All Radio Button
			If (!($rdoSyncAllResources)) 
			{
				$script:rdoSyncAllResources = New-Object Windows.Forms.RadioButton
				$rdoSyncAllResources.Left = $rdoSyncSelectedResources.Right
				$rdoSyncAllResources.Top = 0
				$rdoSyncAllResources.Text = "Sync All"
				$rdoSyncAllResources.Width = $pnlSyncAllSelected.Width / 3
				$rdoSyncAllResources.TextAlign = "MiddleLeft"
				$rdoSyncAllResources.Cursor = "Hand"
				$rdoSyncAllResources.ForeColor = "Black"
				$rdoSyncAllResources.BackColor = "Transparent"
				$rdoSyncAllResources.Checked = $false
				$rdoSyncAllResources.Anchor = "Left,Top"
				$rdoSyncAllResources.Add_Click({
						
					If ($rdoSyncAllResources.Checked) 
						{
							$btnSyncFromxLights.Text = "Sync All From xLights"
							$lblSyncToLayout.Text = "... $(If ($rdoUpdateExistingResources.Checked -eq $true) {"in"} Else {"to"}) '$($lbxLayouts.SelectedItem)' Layout"
							$cbxExcludeCommonLayoutResources.Visible = $true
							$cbxPromptToOverwriteResources.Visible = $true
						}
						ElseIf ($rdoSyncSelectedResources.Checked)
							{
								$btnSyncFromxLights.Text = "Select Resources to Sync"
								$lblSyncToLayout.Text = "... $(If ($rdoUpdateExistingResources.Checked -eq $true) {"in"} Else {"to"}) '$($lbxLayouts.SelectedItem)' Layout"
								$cbxExcludeCommonLayoutResources.Visible = $false
								$cbxPromptToOverwriteResources.Visible = $false
							}
							ElseIf ($rdoUpdateExistingResources.Checked)
								{
									$btnSyncFromxLights.Text = "Updated Existing Resources"
									$lblSyncToLayout.Text = "... $(If ($rdoUpdateExistingResources.Checked -eq $true) {"in"} Else {"to"}) '$($lbxLayouts.SelectedItem)' Layout"
									$cbxExcludeCommonLayoutResources.Visible = $true
									$cbxPromptToOverwriteResources.Visible = $true
								}
					})
				$pnlSyncAllSelected.Controls.Add($rdoSyncAllResources)
			}



		# Add the Exclude Common Layout Items checkbox
		If (!($cbxExcludeCommonLayoutResources)) 
			{
				$script:cbxExcludeCommonLayoutResources = New-Object Windows.Forms.CheckBox
				$cbxExcludeCommonLayoutResources.Left = $pnlSyncAllSelected.Left
				$cbxExcludeCommonLayoutResources.Top = $pnlSyncAllSelected.Bottom + 5
				$cbxExcludeCommonLayoutResources.Text = "Exclude Resources Assigned to '- Common -'"
				$cbxExcludeCommonLayoutResources.Width = 300
				$cbxExcludeCommonLayoutResources.TextAlign = "MiddleLeft"
				$cbxExcludeCommonLayoutResources.Cursor = "Hand"
				$cbxExcludeCommonLayoutResources.ForeColor = "Black"
				$cbxExcludeCommonLayoutResources.BackColor = "Transparent"
				$cbxExcludeCommonLayoutResources.Checked = $true
				$cbxExcludeCommonLayoutResources.Visible = $true
				$cbxExcludeCommonLayoutResources.Anchor = "Left,Top"
				$cbxExcludeCommonLayoutResources.Add_Click({

					})
				$pnlSyncFrom.Controls.Add($cbxExcludeCommonLayoutResources)
			}


		# Add the Sync to Repository checkbox
		If (!($cbxSyncToRepository)) 
			{
				$script:cbxSyncToRepository = New-Object Windows.Forms.CheckBox
				$cbxSyncToRepository.Left = $pnlSyncAllSelected.Left
				$cbxSyncToRepository.Top = $pnlSyncAllSelected.Bottom + 5
				$cbxSyncToRepository.Text = "Sync to Repository"
				$cbxSyncToRepository.Width = 300
				$cbxSyncToRepository.TextAlign = "MiddleLeft"
				$cbxSyncToRepository.Cursor = "Hand"
				$cbxSyncToRepository.ForeColor = "Black"
				$cbxSyncToRepository.BackColor = "Transparent"
				$cbxSyncToRepository.Checked = $false
				$cbxSyncToRepository.Visible = $false
				$cbxSyncToRepository.Anchor = "Left,Top"
				$cbxSyncToRepository.Add_Click({
					If ($cbxSyncToRepository.Checked -eq $true)
						{
							$cbxSyncToRepository.ForeColor = "Green"

							$lbxLayouts.ClearSelected()

							ModifyPanels "Enable" "SyncFrom"
							ModifyPanels "Disable" "CommitToxLights"
							ModifyPanels "Disable" "Layouts"
							ModifyPanels "Disable" "Models"
							ModifyPanels "Disable" "ModelGroups"
							ModifyPanels "Disable" "Views"
							
							# $btnSyncFromxLights.Enabled = $true
							$btnSyncFromxLights.Text = If ($rdoSyncAllResources.Checked) {"Sync All From xLights"} ElseIf ($rdoUpdateExistingResources.Checked) {"Update Existing Resources"} Else {"Select Resources to Sync"}
							$lblSyncToLayout.Text = "...to Repository"
						}
						Else
							{
								If ($lbxLayouts.SelectedItem)
									{
										$cbxSyncToRepository.Forecolor = "Black"

										$lbxLayouts.ClearSelected()

										ModifyPanels "Disable" "SyncFrom"
										ModifyPanels "Enable" "Layouts"
										ModifyPanels "Enable" "CommitToxLights"

										# $btnSyncFromxLights.Enabled = $true
										$btnSyncFromxLights.Text = If ($rdoSyncAllResources.Checked) {"Sync All From xLights"} ElseIf ($rdoUpdateExistingResources.Checked) {"Update Existing Resources"} Else {"Select Resources to Sync"}
										$lblSyncToLayout.Text = "... $(If ($rdoUpdateExistingResources.Checked -eq $true) {"in"} Else {"to"}) '$($lbxLayouts.SelectedItem)' Layout"
									}
									Else
										{
											$cbxSyncToRepository.Forecolor = "Black"

											ModifyPanels "Disable" "SyncFrom"
											ModifyPanels "Enable" "Layouts"
											ModifyPanels "Disable" "CommitToxLights"

											# $btnSyncFromxLights.Enabled = $false
											$btnSyncFromxLights.Text = If ($rdoSyncAllResources.Checked) {"Sync All From xLights"} ElseIf ($rdoUpdateExistingResources.Checked) {"Update Existing Resources"} Else {"Select Resources to Sync"}
											$lblSyncToLayout.Text = ""
										}
							}
				})
				$pnlSyncFrom.Controls.Add($cbxSyncToRepository)
			}

		# Add the Prompt To Overwrite Resources checkbox
		If (!($cbxPromptToOverwriteResources)) 
			{
				$script:cbxPromptToOverwriteResources = New-Object Windows.Forms.CheckBox
				$cbxPromptToOverwriteResources.Left = $cbxExcludeCommonLayoutResources.Left
				$cbxPromptToOverwriteResources.Top = $cbxExcludeCommonLayoutResources.Bottom
				$cbxPromptToOverwriteResources.Text = "Overwrite Existing Resources Without Prompting"
				$cbxPromptToOverwriteResources.Width = 300
				$cbxPromptToOverwriteResources.TextAlign = "MiddleLeft"
				$cbxPromptToOverwriteResources.Cursor = "Hand"
				$cbxPromptToOverwriteResources.ForeColor = "Black"
				$cbxPromptToOverwriteResources.BackColor = "Transparent"
				$cbxPromptToOverwriteResources.Checked = $true
				$cbxPromptToOverwriteResources.Anchor = "Left,Top"
				$pnlSyncFrom.Controls.Add($cbxPromptToOverwriteResources)
			}



		
		# Add the Prompt To Overwrite Resource checkbox
		If (!($cbxPromptToCreateNewInCompanion)) 
			{
				$script:cbxPromptToCreateNewInCompanion = New-Object Windows.Forms.CheckBox
				$cbxPromptToCreateNewInCompanion.Left = $cbxPromptToOverwriteResources.Left
				$cbxPromptToCreateNewInCompanion.Top = $cbxPromptToOverwriteResources.Bottom
				$cbxPromptToCreateNewInCompanion.Text = "Prompt on New or Replacement Resources"
				$cbxPromptToCreateNewInCompanion.Width = $cbxPromptToOverwriteResources.Width
				$cbxPromptToCreateNewInCompanion.TextAlign = "MiddleLeft"
				$cbxPromptToCreateNewInCompanion.Cursor = "Hand"
				$cbxPromptToCreateNewInCompanion.ForeColor = "Black"
				$cbxPromptToCreateNewInCompanion.BackColor = "Transparent"
				$cbxPromptToCreateNewInCompanion.Checked = $false
				$cbxPromptToCreateNewInCompanion.Visible = $false # This box isn't used at the moment
				$cbxPromptToCreateNewInCompanion.Anchor = "Left,Top"
				$pnlSyncFrom.Controls.Add($cbxPromptToCreateNewInCompanion)
			}


		####################################
		# Layouts
		####################################

		# Layouts Panel
		If (!($pnlLayouts)) 
			{
				$script:pnlLayouts = New-Object System.Windows.Forms.Panel
				$pnlLayouts.Name = "LayoutsPanel"
				$pnlLayouts.Left = $pnlSyncFrom.Right + 10
				$pnlLayouts.Top = 10
				$pnlLayouts.Width = ($intCurrentFormClientWidth *.3) + 10 - 44 # +10 to allow a little panel on the right / -44 to allow 10 from the edges and between panels
				$pnlLayouts.Height = $pnlContentPanel6.Height * .2 + 20
				$pnlLayouts.BackColor = "WhiteSmoke"
				$pnlLayouts.Anchor = "Top,Left,Right"
				$pnlContentPanel2.Controls.Add($pnlLayouts)
			}

		# Create the Layouts label
		If (!($lblLayouts)) 
			{
				$script:lblLayouts = New-Object System.Windows.Forms.Label
				$lblLayouts.Width = $pnlLayouts.Width * .3
				$lblLayouts.Height = 20
				$lblLayouts.Left = 10
				$lblLayouts.Top = 3
				$lblLayouts.TextAlign = "MiddleLeft"
				$lblLayouts.ForeColor = "Blue"
				$lblLayouts.Backcolor = "Transparent"
				$lblLayouts.Text = "Manage Layout:"
				$lblLayouts.Anchor = "Left,Top"
		#		$lblLayouts.Cursor = "Hand"
				# $lblLayouts.Add_Click({
				# })
				$pnlLayouts.Controls.Add($lblLayouts)
			}
		
		# Create the Layouts Listbox
		If (!($lbxLayouts)) 
			{
				$script:lbxLayouts = New-Object System.Windows.Forms.ListBox
				$lbxLayouts.Left = $lblLayouts.Left
				$lbxLayouts.Top = $lblLayouts.Bottom + 5
				$lbxLayouts.Width = $pnlLayouts.Width - 20 - 40 # -40 for the add/remove buttons and -20 to allow space from the edges and between
				$lbxLayouts.Height = $pnlLayouts.Height - $lblLayouts.Bottom - 5
				$lbxLayouts.SelectionMode = "One"
				$lbxLayouts.Sorted = $true
				$lbxLayouts.Visible = $true
				$lbxLayouts.Anchor = "Left,Right,Top"
				$lbxLayouts.Add_SelectedValueChanged({
						
							If ($lbxLayouts.SelectedItem)
								{
									# Disable the content panels
									ModifyPanels "Disable" "Models" 
									ModifyPanels "Disable" "ModelGroups" 
									ModifyPanels "Disable" "Views" 
									
									# Load the layout resource list boxes
									LoadLayoutResourcesFromCompanionXML -strLayoutName $lbxLayouts.SelectedItem -strNodeType "Model"
									LoadLayoutResourcesFromCompanionXML -strLayoutName $lbxLayouts.SelectedItem -strNodeType "ModelGroup"
									LoadLayoutResourcesFromCompanionXML -strLayoutName $lbxLayouts.SelectedItem -strNodeType "View"
									
									# Load the Repository resouce list boxes
									LoadRepositoryResourcesFromCompanionXML -strNodeType "Model" -boolLoadListboxes $true -boolCheckForUpdates $false
									LoadRepositoryResourcesFromCompanionXML -strNodeType "ModelGroup" -boolLoadListboxes $true -boolCheckForUpdates $false
									LoadRepositoryResourcesFromCompanionXML -strNodeType "View" -boolLoadListboxes $true -boolCheckForUpdates $false

									# Enable the content panels
									ModifyPanels "Enable" "Models" 
									ModifyPanels "Enable" "ModelGroups" 
									ModifyPanels "Enable" "Views" 
									ModifyPanels "Enable" "SyncFrom"
									ModifyPanels "Enable" "CommitToxLights"

									# Select the Update/SyncSelected/SyncAll button, depending on the layouts current contents
									$intCurrentLayoutsModels = ($objxLightsCompanionXML.xlc.layouts.Layout | Where-Object {$_.Name -eq $lbxLayouts.SelectedItem}).models.Model.Count
									$intCurrentLayoutsModelGroups = ($objxLightsCompanionXML.xlc.layouts.Layout | Where-Object {$_.Name -eq $lbxLayouts.SelectedItem}).modelGroups.ModelGroup.Count
									$intCurrentLayoutsViews = ($objxLightsCompanionXML.xlc.layouts.Layout | Where-Object {$_.Name -eq $lbxLayouts.SelectedItem}).views.View.Count

									If ($intCurrentLayoutsModels -eq 0 -and $intCurrentLayoutsModelGroups -eq 0 -and $intCurrentLayoutsViews -eq 0)
										{
											# The selected layout doesn't contain any resources so set up the Sync All options
											$rdoSyncAllResources.PerformClick()
										}
										ElseIf ($intCurrentLayoutsModels -gt 0 -or $intCurrentLayoutsModelGroups -gt 0 -or $intCurrentLayoutsViews -gt 0)
											{
												# The selected layout contains one or more resources so set up the Update Existing options
												$rdoUpdateExistingResources.PerformClick()
											}


									# Prep the Copy/Move/Delete functions
									InitializeCopyMoveDelete -strPanel "Models" -strTask "Prep"
									InitializeCopyMoveDelete -strPanel "ModelGroups" -strTask "Prep"
									InitializeCopyMoveDelete -strPanel "Views" -strTask "Prep"

									# Repopulate the Copy/Move Layout Drop Downs
									$lbxLayouts.Items | ForEach-Object {
										
											# If the Layout Name doesn't match the currently selected layout, add it to the drop downs
											If ($_ -ne $lbxLayouts.SelectedItem)
												{
													$cboCopyMoveModelsToLayoutList.Items.Add($_)
													$cboCopyMoveModelGroupsToLayoutList.Items.Add($_)
													$cboCopyMoveViewsToLayoutList.Items.Add($_)
												}
										}

									# Enable the Add/Remove/Duplicate Layout buttons
									$btnAddLayout.Enabled = $true
									If ($lbxLayouts.SelectedItem -ne "- Common -") {$btnRemoveLayout.Enabled = $true} Else {$btnRemoveLayout.Enabled = $false}
									$btnDuplicateLayout.Enabled = $true

									# Enable/Disable the Include Common and Exclude Common checkboxes
									If ($lbxLayouts.SelectedItem -eq "- Common -")
										{
											$cbxExcludeCommonLayoutResources.Enabled = $false
											$cbxExcludeCommonLayoutResources.Checked = $false
											$cbxAlsoLoadCommonLayout.Checked = $true
											$cbxAlsoLoadCommonLayout.Enabled = $false
										}
										Else
											{
												$cbxExcludeCommonLayoutResources.Enabled = $true
												$cbxExcludeCommonLayoutResources.Checked = $true
												$cbxAlsoLoadCommonLayout.Checked = $true
												$cbxAlsoLoadCommonLayout.Enabled = $true
											}

									# $btnSyncFromxLights.Enabled = $true
									$btnSyncFromxLights.Text = If ($rdoSyncAllResources.Checked) {"Sync All From xLights"} ElseIf ($rdoUpdateExistingResources.Checked) {"Update Existing Resources"} Else {"Select Resources to Sync"}
									$lblSyncToLayout.Text = "... $(If ($rdoUpdateExistingResources.Checked -eq $true) {"in"} Else {"to"}) '$($lbxLayouts.SelectedItem)' Layout"

									# Reset the text on the Commit button
									$btnCommitLayoutToxLights.Text = "Commit Layout to xLights"

								}
								Else
									{
										# Disable the content panels
										ModifyPanels "Disable" "Models" 
										ModifyPanels "Disable" "ModelGroups" 
										ModifyPanels "Disable" "Views"
										ModifyPanels "Disable" "SyncFrom"
										ModifyPanels "Disable" "CommitToxLights"

										# Disable the Add/Remove/Duplicate Layout buttons
										$btnAddLayout.Enabled = $false
										$btnRemoveLayout.Enabled = $false
										$btnDuplicateLayout.Enabled = $false

										# Clear the list boxes
										$lbxLayoutModels.Items.Clear()
										$lbxLayoutModelGroups.Items.Clear()
										$lbxLayoutViews.Items.Clear()

										# $btnSyncFromxLights.Enabled = $false
										$btnSyncFromxLights.Text = If ($rdoSyncAllResources.Checked) {"Sync All From xLights"} ElseIf ($rdoUpdateExistingResources.Checked) {"Update Existing Resources"} Else {"Select Resources to Sync"}
										$lblSyncToLayout.Text = ""
									}
						
					})
				$pnlLayouts.Controls.Add($lbxLayouts)
			}


		####################################
		# Add/Remove/Copy Layout Buttons
		####################################

		# Add the Add Layout Button
		If (!($btnAddLayout)) 
			{
				$script:btnAddLayout = New-Object Windows.Forms.Button
				$btnAddLayout.Left = $lbxLayouts.Right + 10
				$btnAddLayout.Top = $lbxLayouts.Top
				$btnAddLayout.Text = "+"
				$btnAddLayout.Width = 30
				$btnAddLayout.TextAlign = "MiddleCenter"
				$btnAddLayout.Cursor = "Hand"
				$btnAddLayout.ForeColor = "Black"
				$btnAddLayout.BackColor = "WhiteSmoke"
				$btnAddLayout.Enabled = $false
				$btnAddLayout.Anchor = "Left,Top"
				$btnAddLayout.Add_Click({
				
						# Prompt for the layout name
						$strNewLayoutName = [Microsoft.VisualBasic.Interaction]::InputBox("Enter a name for the new layout", "New Layout Name")

						# Add code here to validate/sanitize the entered name

						AddLayout -strLayoutName $strNewLayoutName

						LoadLayoutsFromCompanionXML

						$lbxLayouts.SelectedItem = $strNewLayoutName
					})
				$pnlLayouts.Controls.Add($btnAddLayout)
			}


		# Add the Remove Layout Button
		If (!($btnRemoveLayout)) 
			{
				$script:btnRemoveLayout = New-Object Windows.Forms.Button
				$btnRemoveLayout.Left = $btnAddLayout.Left
				$btnRemoveLayout.Top = $btnAddLayout.Bottom + 10
				$btnRemoveLayout.Text = "-"
				$btnRemoveLayout.Width = 30
				$btnRemoveLayout.TextAlign = "MiddleCenter"
				$btnRemoveLayout.Cursor = "Hand"
				$btnRemoveLayout.ForeColor = "Black"
				$btnRemoveLayout.BackColor = "WhiteSmoke"
				$btnRemoveLayout.Enabled = $false
				$btnRemoveLayout.Anchor = "Top,Left"
				$btnRemoveLayout.Add_Click({
				
						# Remove the selected layout
						If ($lbxLayouts.SelectedItem)
							{
								If ($lbxLayouts.SelectedItem -notin ("- Common -", "- Repository (Recovery) -"))
									{
										$boolRemoveLayout = [System.Windows.Forms.MessageBox]::Show("Are you sure you want to remove $($lbxLayouts.SelectedItem)?","Remove Layout?" , "YesNo", "Exclamation")

										If ($boolRemoveLayout -eq "Yes")
											{
												RemoveLayout $lbxLayouts.SelectedItem
										
												LoadLayoutsFromCompanionXML

												# Disable the content panels
												ModifyPanels "Disable" "Models" 
												ModifyPanels "Disable" "ModelGroups" 
												ModifyPanels "Disable" "Views"
												ModifyPanels "Disable" "SyncFrom"
												ModifyPanels "Disable" "CommitToxLights"

												# Disable the Add/Remove/Duplicate Layout buttons
												$btnAddLayout.Enabled = $false
												$btnRemoveLayout.Enabled = $false
												$btnDuplicateLayout.Enabled = $false

												# Clear the list boxes
												$lbxLayoutModels.Items.Clear()
												$lbxLayoutModelGroups.Items.Clear()
												$lbxLayoutViews.Items.Clear()

												# $btnSyncFromxLights.Enabled = $false
												$btnSyncFromxLights.Text = If ($rdoSyncAllResources.Checked) {"Sync All From xLights"} ElseIf ($rdoUpdateExistingResources.Checked) {"Update Existing Resources"} Else {"Select Resources to Sync"}
												$lblSyncToLayout.Text = ""
											}
									}
									Else
										{
											LogWrite "WARNING" "The ""$($lbxLayouts.SelectedItem)"" layout cannot be removed."
											[System.Windows.Forms.MessageBox]::Show("The $($lbxLayouts.SelectedItem) layout cannot be removed.","System Layout" , "OK", "Exclamation")
										}
							}
					})
				$pnlLayouts.Controls.Add($btnRemoveLayout)
			}


		# Add the Duplicate Layout Button
		If (!($btnDuplicateLayout)) 
			{
				$script:btnDuplicateLayout = New-Object Windows.Forms.Button
				$btnDuplicateLayout.Left = $btnAddLayout.Left
				$btnDuplicateLayout.Top = $lbxLayouts.Bottom - $btnDuplicateLayout.Height
				$btnDuplicateLayout.Text = "++"
				$btnDuplicateLayout.Width = 30
				$btnDuplicateLayout.TextAlign = "MiddleCenter"
				$btnDuplicateLayout.Cursor = "Hand"
				$btnDuplicateLayout.ForeColor = "Black"
				$btnDuplicateLayout.BackColor = "WhiteSmoke"
				$btnDuplicateLayout.Enabled = $false
				$btnDuplicateLayout.Anchor = "Top,Left"
				$btnDuplicateLayout.Add_Click({
				
						# Prompt for the layout name
						$strNewLayoutName = [Microsoft.VisualBasic.Interaction]::InputBox("Copying $($lbxLayouts.SelectedItem) to a new layout.... `n`nEnter a name for the new layout", "Duplicate Layout Name")

						# Add code here to validate/sanitize the entered name

						AddLayout -strLayoutName $strNewLayoutName -strLayoutToDuplicate $lbxLayouts.SelectedItem

						LoadLayoutsFromCompanionXML

						$lbxLayouts.SelectedItem = $strNewLayoutName
					})
				$pnlLayouts.Controls.Add($btnDuplicateLayout)
			}


		####################################
		# Save/Reload Layout Buttons
		####################################
		
		# Add the Cancel/Reload Layout Button
		If (!($btnCancelReloadLayout)) 
			{
				$script:btnCancelReloadLayout = New-Object Windows.Forms.Button
				$btnCancelReloadLayout.Width = 100
				$btnCancelReloadLayout.Left = $lbxLayouts.Right - $btnCancelReloadLayout.Width
				$btnCancelReloadLayout.Top = $lblLayouts.Top
				$btnCancelReloadLayout.TextAlign = "MiddleCenter"
				$btnCancelReloadLayout.Text = "Cancel"
				$btnCancelReloadLayout.Cursor = "Hand"
				$btnCancelReloadLayout.ForeColor = "White"
				$btnCancelReloadLayout.BackColor = "Red"
				$btnCancelReloadLayout.Visible = $false
				$btnCancelReloadLayout.Anchor = "Top,Left"
				$btnCancelReloadLayout.Add_Click({
				
					If ($boolLayoutModelsChanged -eq $true -or $boolLayoutModelGroupsChanged -eq $true -or $boolLayoutViewsChanged -eq $true)
							{
								$boolReloadModels = [System.Windows.Forms.MessageBox]::Show("Changes have been made to ""$($lbxLayouts.SelectedItem)"" `n`nClick OK to continue without saving `nClick Cancel to go back" , "Discard Changes?", "OKCancel", "Exclamation")

								If ($boolReloadModels -eq "OK")
									{
										LogWrite "VERBOSE" "Discarding Layout changes for ""$($lbxLayouts.SelectedItem)"""

										# Clear the list boxes
										$lbxLayoutModels.BeginUpdate()
											$lbxLayoutModels.Items.Clear()
										$lbxLayoutModels.EndUpdate()

										$lbxLayoutModelGroups.BeginUpdate()
											$lbxLayoutModelGroups.Items.Clear()
										$lbxLayoutModelGroups.EndUpdate()

										$lbxLayoutViews.BeginUpdate()
											$lbxLayoutViews.Items.Clear()
										$lbxLayoutViews.EndUpdate()

										$lbxRepositoryModels.BeginUpdate()
											$lbxRepositoryModels.Items.Clear()
										$lbxRepositoryModels.EndUpdate()

										$lbxRepositoryModelGroups.BeginUpdate()
											$lbxRepositoryModelGroups.Items.Clear()
										$lbxRepositoryModelGroups.EndUpdate()

										$lbxRepositoryViews.BeginUpdate()
											$lbxRepositoryViews.Items.Clear()
										$lbxRepositoryViews.EndUpdate()

										# Clear the layout models
										$lbxLayouts.ClearSelected()
										ModifyPanels "Enable" "Layouts"
										
										If ($boolxLightsCompanionXMLIsChanged) 
											{
												$btnSaveToFile.Enabled = $true
												$btnSaveToFile.Visible = $true
												$btnSaveToFile.Forecolor = "White"
												$btnSaveToFile.BackColor = "Green"
												
												$btnFormSubmit.Enabled = $true
												$btnFormSubmit.Text = "Cancel"
												$btnFormSubmit.Forecolor = "White"
												$btnFormSubmit.BackColor = "Red"
											}
											Else
												{
													$btnSaveToFile.Enabled = $false
													$btnSaveToFile.Visible = $false
													$btnSaveToFile.Forecolor = "Gray"
													$btnSaveToFile.BackColor = "LightGray"
													
													$btnFormSubmit.Enabled = $true
													$btnFormSubmit.Text = "Close"
													$btnFormSubmit.Forecolor = "Black"
													$btnFormSubmit.BackColor = "WhiteSmoke"	
												}
												
										$btnSaveLayout.Visible = $false
										$btnCancelReloadLayout.Visible = $false
										
										$script:boolLayoutModelsChanged = $false
										$script:boolLayoutModelGroupsChanged = $false
										$script:boolLayoutViewsChanged = $false

										# Removed as it's not necessary to load the Repository resources until after a layout is selected
										# LoadRepositoryResourcesFromCompanionXML -strNodeType "Model" -boolLoadListBoxes $true -boolCheckForUpdates $false
										# LoadRepositoryResourcesFromCompanionXML -strNodeType "ModelGroup" -boolLoadListBoxes $true -boolCheckForUpdates $false
										# LoadRepositoryResourcesFromCompanionXML -strNodeType "View"	-boolLoadListBoxes $true -boolCheckForUpdates $false

										ModifyPanels "Disable" "SyncFrom"
										ModifyPanels "Disable" "Models"
										ModifyPanels "Disable" "ModelGroups"
										ModifyPanels "Disable" "Views"
										ModifyPanels "Disable" "CommitToxLights"
									}
							}
									
					})
				$pnlLayouts.Controls.Add($btnCancelReloadLayout)
			}
			

			# Add the Save Layout Button
			If (!($btnSaveLayout)) 
			{
				$script:btnSaveLayout = New-Object Windows.Forms.Button
				$btnSaveLayout.Width = 100
				$btnSaveLayout.Left = $btnCancelReloadLayout.Left - $btnSaveLayout.Width - 10
				$btnSaveLayout.Top = $btnCancelReloadLayout.Top
				$btnSaveLayout.TextAlign = "MiddleCenter"
				$btnSaveLayout.Text = "Save"
				$btnSaveLayout.Cursor = "Hand"
				$btnSaveLayout.ForeColor = "White"
				$btnSaveLayout.BackColor = "Green"
				$btnSaveLayout.Visible = $false
				$btnSaveLayout.Anchor = "Top,Left"
				$btnSaveLayout.Add_Click({
				
						If ($boolLayoutModelsChanged -eq $true -or $boolLayoutModelGroupsChanged -eq $true -or $boolLayoutViewsChanged -eq $true)
							{
								$boolSaveLayout = [System.Windows.Forms.MessageBox]::Show("Are you sure you want to save the changes to ""$($lbxLayouts.SelectedItem)""?" , "Save Changes?", "YesNo", "Exclamation")

								If ($boolSaveLayout -eq "Yes")
									{
										SaveLayout

									}
							}
									
					})
				$pnlLayouts.Controls.Add($btnSaveLayout)
			}


		####################################
		# Commmit Layout to xLights 
		####################################

		# CommitLayout Panel
		If (!($pnlCommitxLights)) 
			{
				$script:pnlCommitxLights = New-Object System.Windows.Forms.Panel
				$pnlCommitxLights.Name = "CommitLayoutPanel"
				$pnlCommitxLights.Left = $pnlLayouts.Right + 10
				$pnlCommitxLights.Top = 10
				$pnlCommitxLights.Width = ($intCurrentFormClientWidth *.3) + 10 - 44 # +10 to allow a little panel on the right / -44 to allow 10 from the edges and between panels
				$pnlCommitxLights.Height = $pnlContentPanel6.Height * .2 + 20
				$pnlCommitxLights.BackColor = "WhiteSmoke"
				$pnlCommitxLights.Anchor = "Top,Left,Right"
				$pnlContentPanel2.Controls.Add($pnlCommitxLights)
			}

		# Add the Commit Layout to xLights Button
		If (!($btnCommitLayoutToxLights)) 
			{
				$script:btnCommitLayoutToxLights = New-Object Windows.Forms.Button
				$btnCommitLayoutToxLights.Left = 10
				$btnCommitLayoutToxLights.Top = 10
				$btnCommitLayoutToxLights.Width = 200
				$btnCommitLayoutToxLights.Text = "Commit Layout to xLights"
				$btnCommitLayoutToxLights.TextAlign = "MiddleCenter"
				$btnCommitLayoutToxLights.Cursor = "Hand"
				$btnCommitLayoutToxLights.Enabled = $false
				$btnCommitLayoutToxLights.ForeColor = "Gray"
				$btnCommitLayoutToxLights.BackColor = "LightGray"
				$btnCommitLayoutToxLights.Anchor = "Left,Top"
				$btnCommitLayoutToxLights.Add_Click({

						$dtStartCommit = Get-Date

						# Disable the controls
						$btnCommitLayoutToxLights.Text = "Processing...."
						$btnCommitLayoutToxLights.Forecolor = "Blue"
						
						# Disable the Layouts panel
						ModifyPanels "Disable" "Layouts" 
						
						CommitLayoutToxLights $lbxLayouts.SelectedItem

						# Enable the Layouts panel
						ModifyPanels "Enable" "Layouts" 


						$intCommitDuration = New-TimeSpan -Start $dtStartCommit -End $(Get-Date)
						
						$btnCommitLayoutToxLights.Text = "Commit Complete in $([math]::Round($intCommitDuration.TotalSeconds))s"

					})
				$pnlCommitxLights.Controls.Add($btnCommitLayoutToxLights)
			}


		# Add the 'Also Load Common Layout' Checkbox
		If (!($cbxAlsoLoadCommonLayout)) 
			{
				$script:cbxAlsoLoadCommonLayout = New-Object Windows.Forms.CheckBox
				$cbxAlsoLoadCommonLayout.Left = $btnCommitLayoutToxLights.Left + 10
				$cbxAlsoLoadCommonLayout.Top = $btnCommitLayoutToxLights.Bottom + 5
				$cbxAlsoLoadCommonLayout.Text = "Include '- Common -' Layout Resources"
				$cbxAlsoLoadCommonLayout.Width = $pnlCommitxLights.Width - 20
				$cbxAlsoLoadCommonLayout.TextAlign = "MiddleLeft"
				$cbxAlsoLoadCommonLayout.Cursor = "Hand"
				$cbxAlsoLoadCommonLayout.ForeColor = "Black"
				$cbxAlsoLoadCommonLayout.BackColor = "Transparent"
				$cbxAlsoLoadCommonLayout.Enabled = $false
				$cbxAlsoLoadCommonLayout.Checked = $true
				$cbxAlsoLoadCommonLayout.Anchor = "Left,Top"
				$pnlCommitxLights.Controls.Add($cbxAlsoLoadCommonLayout)
			}


		# Add the 'Overwrite Existing Resources' checkbox
		If (!($cbxOverwriteExistingResources)) 
			{
				$script:cbxOverwriteExistingResources = New-Object Windows.Forms.CheckBox
				$cbxOverwriteExistingResources.Left = $cbxAlsoLoadCommonLayout.Left
				$cbxOverwriteExistingResources.Top = $cbxAlsoLoadCommonLayout.Bottom
				$cbxOverwriteExistingResources.Text = "Overwrite Existing Resources"
				$cbxOverwriteExistingResources.Width = 185 #$cbxAlsoLoadCommonLayout.Width
				$cbxOverwriteExistingResources.TextAlign = "MiddleLeft"
				$cbxOverwriteExistingResources.Cursor = "Hand"
				$cbxOverwriteExistingResources.ForeColor = "Black"
				$cbxOverwriteExistingResources.BackColor = "Transparent"
				$cbxOverwriteExistingResources.Enabled = $false
				$cbxOverwriteExistingResources.Checked = $true
				$cbxOverwriteExistingResources.Anchor = "Left,Top"
				$pnlCommitxLights.Controls.Add($cbxOverwriteExistingResources)
			}


		# Add the 'Mark All Models Active' checkbox
		If (!($cbxMarkAllModelsActive)) 
			{
				$script:cbxMarkAllModelsActive = New-Object Windows.Forms.CheckBox
				$cbxMarkAllModelsActive.Left = $cbxOverwriteExistingResources.Right
				$cbxMarkAllModelsActive.Top = $cbxOverwriteExistingResources.Top
				$cbxMarkAllModelsActive.Text = "Activate All xLights Models"
				$cbxMarkAllModelsActive.Width = 220 #$cbxAlsoLoadCommonLayout.Width
				$cbxMarkAllModelsActive.TextAlign = "MiddleLeft"
				$cbxMarkAllModelsActive.Cursor = "Hand"
				$cbxMarkAllModelsActive.ForeColor = "Black"
				$cbxMarkAllModelsActive.BackColor = "Transparent"
				$cbxMarkAllModelsActive.Enabled = $false
				$cbxMarkAllModelsActive.Checked = $true
				$cbxMarkAllModelsActive.Anchor = "Left,Top"
				$pnlCommitxLights.Controls.Add($cbxMarkAllModelsActive)
			}

		# Add the 'Remove Extra Resources' checkbox
		If (!($cbxRemoveExtraResources)) 
			{
				$script:cbxRemoveExtraResources = New-Object Windows.Forms.CheckBox
				$cbxRemoveExtraResources.Left = $cbxAlsoLoadCommonLayout.Left
				$cbxRemoveExtraResources.Top = $cbxMarkAllModelsActive.Bottom
				$cbxRemoveExtraResources.Text = "Remove Non-Committed Resources from xLights"
				$cbxRemoveExtraResources.Width = $cbxAlsoLoadCommonLayout.Width
				$cbxRemoveExtraResources.TextAlign = "MiddleLeft"
				$cbxRemoveExtraResources.Cursor = "Hand"
				$cbxRemoveExtraResources.ForeColor = "Black"
				$cbxRemoveExtraResources.BackColor = "Transparent"
				$cbxRemoveExtraResources.Enabled = $false
				$cbxRemoveExtraResources.Checked = $true
				$cbxRemoveExtraResources.Anchor = "Left,Top"
				$pnlCommitxLights.Controls.Add($cbxRemoveExtraResources)
			}


			# Create the Open xLights link
			If (!($lblOpenLayoutInxLights)) 
				{
					$script:lblOpenLayoutInxLights = New-Object System.Windows.Forms.Label
					$lblOpenLayoutInxLights.Width = $pnlCommitxLights.Width - 6
					$lblOpenLayoutInxLights.Height = 20
					$lblOpenLayoutInxLights.Left = 3
					$lblOpenLayoutInxLights.Top = $pnlCommitxLights.Height - $lblOpenLayoutInxLights.Height - 3
					$lblOpenLayoutInxLights.TextAlign = "MiddleCenter"
					$lblOpenLayoutInxLights.ForeColor = "Blue"
					$lblOpenLayoutInxLights.Backcolor = "Transparent"
					$lblOpenLayoutInxLights.Text = ""
					$lblOpenLayoutInxLights.Anchor = "Left,Top"
					$lblOpenLayoutInxLights.Cursor = "Hand"
					# $lblOpenLayoutInxLights.Add_Click({
					# })
					$pnlCommitxLights.Controls.Add($lblOpenLayoutInxLights)
				}





		####################################
		# Models
		####################################

		# Model Panel
		If (!($pnlModels)) 
			{
				$script:pnlModels = New-Object System.Windows.Forms.Panel
				$pnlModels.Name = "ModelsPanel"
				$pnlModels.Left = 10
				$pnlModels.Top = $pnlSyncFrom.Bottom + 10
				$pnlModels.Width = ($intCurrentFormClientWidth *.3) + 10 - 44 # +10 to allow a little panel on the right / -44 to allow 10 from the edges and between panels
				$pnlModels.Height = $pnlContentPanel2.Height - $pnlModels.Top - 10
				$pnlModels.BackColor = "WhiteSmoke"
				$pnlModels.Anchor = "Top,Left,Right"
				$pnlContentPanel2.Controls.Add($pnlModels)
			}

	
		####################################
		# Layout Models
		####################################


		# Create the Delete Model button
		If (!($btnDeleteModelsFromLayout)) 
			{
				$script:btnDeleteModelsFromLayout = New-Object Windows.Forms.Button
				$btnDeleteModelsFromLayout.Width = $pnlModels.Width * .66
				$btnDeleteModelsFromLayout.Left = ($pnlModels.Width / 2) - ($btnDeleteModelsFromLayout.Width / 2)
				$btnDeleteModelsFromLayout.Top = $pnlModels.Height - $btnDeleteModelsFromLayout.Height - 5
				$btnDeleteModelsFromLayout.Text = "Delete Model From Layout"
				$btnDeleteModelsFromLayout.TextAlign = "MiddleCenter"
				$btnDeleteModelsFromLayout.Cursor = "Hand"
				$btnDeleteModelsFromLayout.ForeColor = "Gray"
				$btnDeleteModelsFromLayout.BackColor = "LightGray"
				$btnDeleteModelsFromLayout.Enabled = $true
				$btnDeleteModelsFromLayout.Anchor = "Top,Left,Right"
				$btnDeleteModelsFromLayout.Add_Click({

						$intNodesDeleted = 0

						# If the number of selected models is greater than 0 and the target layout has been selected, proceed
						If ($lbxLayoutModels.SelectedItems.Count -gt 0)
							{
								[array]$arrSelectedModels = $lbxLayoutModels.SelectedItems
								$intSelectedModelsCount = $arrSelectedModels.Count
								$boolDeleteModels = [System.Windows.Forms.MessageBox]::Show("Are you sure you want to delete $intSelectedModelsCount $(If ($intSelectedModelsCount -eq 1) {"model"} Else {"models"})`n`nFrom: $($lbxLayouts.SelectedItem)","Delete $(If ($intSelectedModelsCount -eq 1) {"Model"} Else {"Models"})?" , "YesNo", "Exclamation")

								If ($boolDeleteModels -eq "Yes")
									{
										# Iterate through the selected items, delete each from the list box, and increment the counter.
										$arrSelectedModels | ForEach-Object {
									
												LogWrite "INFO" "Deleting ""$_"" from ""$($lbxLayouts.SelectedItem)"""

												# Remove the node from the list box
												MoveModelsToFromLayout -strAddRemove "Remove" -strModelName $_

												$intNodesDeleted++
											}

										# Reset the listbox
										InitializeCopyMoveDelete -strPanel "Models" -strTask "NoModelSelected"

										# If nodes were deleted, update the button to reflect the update
										If ($intNodesDeleted -gt 0)
											{
												$btnDeleteModelsFromLayout.Text = "Deleted $intNodesDeleted / $intSelectedModelsCount $(If ($intSelectedModelsCount -gt 1) {"Models"} Else {"Model"}) From Layout"
												$btnDeleteModelsFromLayout.Forecolor = If ($intNodesDeleted -eq $intSelectedModelsCount) {"Green"} Else {"Orange"}
												$btnDeleteModelsFromLayout.Backcolor = If ($intNodesDeleted -eq $intSelectedModelsCount) {"MintCream"} Else {"PapayaWhip"}
											}
									}

							}

					})
				$pnlModels.Controls.Add($btnDeleteModelsFromLayout)
			}
						

		# Copy/Move Models to layout group box
		If (!($grpCopyMoveModelsToLayout)) 
			{
				$script:grpCopyMoveModelsToLayout = New-Object Windows.Forms.GroupBox
				$grpCopyMoveModelsToLayout.Width = $pnlModels.Width - 20
				$grpCopyMoveModelsToLayout.Height = $pnlModels.Height * .20
				$grpCopyMoveModelsToLayout.Left = 10
				$grpCopyMoveModelsToLayout.Top =  $btnDeleteModelsFromLayout.Top - $grpCopyMoveModelsToLayout.Height - 20
				$grpCopyMoveModelsToLayout.Enabled = $false
				$grpCopyMoveModelsToLayout.Anchor = "Top,Left,Right"
				$grpCopyMoveModelsToLayout.Text = "Copy / Move Model to....."
				$pnlModels.Controls.Add($grpCopyMoveModelsToLayout)
			}


		# Copy/Move Models to Layout Drop Down
		If (!($cboCopyMoveModelsToLayoutList)) 
			{
				$script:cboCopyMoveModelsToLayoutList = New-Object System.Windows.Forms.ComboBox
				$cboCopyMoveModelsToLayoutList.Width = $grpCopyMoveModelsToLayout.Width * .50
				$cboCopyMoveModelsToLayoutList.Left = 10
				$cboCopyMoveModelsToLayoutList.Top = ($grpCopyMoveModelsToLayout.Height / 2) - ($cboCopyMoveModelsToLayoutList.Height / 2)
				$cboCopyMoveModelsToLayoutList.Height = 20
				$cboCopyMoveModelsToLayoutList.ForeColor = "Black"
				$cboCopyMoveModelsToLayoutList.Backcolor = "White"
				$cboCopyMoveModelsToLayoutList.Font = New-Object System.Drawing.Font("Arial",10)
				$cboCopyMoveModelsToLayoutList.Anchor = "Top,Left,Right"
				$cboCopyMoveModelsToLayoutList.Add_SelectedValueChanged({

						# If the selected value is not blank, enable the Copy/Move buttons
						If ($cboCopyMoveModelsToLayoutList.SelectedItem -ne "")
							{
								# Enable the Copy/Move and Delete functions
								InitializeCopyMoveDelete -strPanel "Models" -strTask "TargetSelected"
							}
							Else
								{
									# If the list box selection is not null, update the CopyMoveDelete functions
									If ($null -ne $lbxLayoutModels.SelectedItem)
										{
											InitializeCopyMoveDelete -strPanel "Models" -strTask "ModelSelected"
										}

								}
					})

				$grpCopyMoveModelsToLayout.Controls.Add($cboCopyMoveModelsToLayoutList)
			}

		# Copy models to layout button
		If (!($btnCopyModelsToLayout)) 
			{
				$script:btnCopyModelsToLayout = New-Object Windows.Forms.Button
				$btnCopyModelsToLayout.Width = ($grpCopyMoveModelsToLayout.Width *.4)
				$btnCopyModelsToLayout.Left = $grpCopyMoveModelsToLayout.Width - $btnCopyModelsToLayout.Width - 5
				$btnCopyModelsToLayout.Top = ($grpCopyMoveModelsToLayout.Height * .33) - ($btnCopyModelsToLayout.Height / 2)
				$btnCopyModelsToLayout.Text = "Copy Model"
				$btnCopyModelsToLayout.TextAlign = "MiddleCenter"
				$btnCopyModelsToLayout.Cursor = "Hand"
				$btnCopyModelsToLayout.ForeColor = "Gray"
				$btnCopyModelsToLayout.BackColor = "LightGray"
				$btnCopyModelsToLayout.Anchor = "Top,Right"
				$btnCopyModelsToLayout.Add_Click({

						$intNodesCopied = 0

						# If the number of selected models is greater than 0 and the target layout has been selected, proceed
						If ($lbxLayoutModels.SelectedItems.Count -gt 0 -and $cboCopyMoveModelsToLayoutList.SelectedItem -ne "")
							{
								[array]$arrSelectedModels = $lbxLayoutModels.SelectedItems
								$intSelectedModelsCount = $arrSelectedModels.Count
								$boolCopyModels = [System.Windows.Forms.MessageBox]::Show("Are you sure you want to copy $intSelectedModelsCount $(If ($intSelectedModelsCount -eq 1) {"model"} Else {"models"})`n`nTo: $($cboCopyMoveModelsToLayoutList.SelectedItem)`n`n`nNote: The target layout is automatically saved after copying.","Copy $(If ($intSelectedModelsCount -eq 1) {"Model"} Else {"Models"})?" , "YesNo", "Exclamation")

								If ($boolCopyModels -eq "Yes")
									{
										# Iterate through the selected items and copy each
										$arrSelectedModels | ForEach-Object {
											
												LogWrite "VERBOSE" "Copying ""$_"" to $($cboCopyMoveModelsToLayoutList.SelectedItem)"
												$intNodesProcessed = CopyXMLNode -strSource "Companion" -strTarget "Companion" -strSourceLayoutName $lbxLayouts.SelectedItem -strTargetLayoutName $cboCopyMoveModelsToLayoutList.SelectedItem -strNodeType "Model" -strNodeName $_ -boolOverwriteNode "Yes"

												# If the number of nodes copied is 1, increment the counter, flag the script to require a save, and reset the flag
												If ($intNodesProcessed -eq 1)
													{
														$intNodesCopied++

														xLightsCompanionUpdates $true

														# Reset the copied nodes counter
														$intNodesProcessed = 0
													}
											}
										
										# Refresh the panel/listbox from the XML
										ModifyPanels -strTask "Disable" -strPanel "Models"
										LoadLayoutResourcesFromCompanionXML -strLayoutName $lbxLayouts.SelectedItem -strNodeType "Model"
										InitializeCopyMoveDelete -strPanel "Models" -strTask "NoModelSelected"
										ModifyPanels -strTask "Enable" -strPanel "Models"

										# If nodes were copied, update the button to reflect the update
										If ($intNodesCopied -gt 0)
											{
												$btnCopyModelsToLayout.Text = "Copied $intNodesCopied / $intSelectedModelsCount $(If ($intSelectedModelsCount -gt 1) {"Models"} Else {"Model"})"
												$btnCopyModelsToLayout.Forecolor = If ($intNodesCopied -eq $intSelectedModelsCount) {"Green"} Else {"Orange"}
												$btnCopyModelsToLayout.Backcolor = If ($intNodesCopied -eq $intSelectedModelsCount) {"MintCream"} Else {"PapayaWhip"}
											}
									}
							}
					})
				$grpCopyMoveModelsToLayout.Controls.Add($btnCopyModelsToLayout)
			}

		# Move models to layout button
		If (!($btnMoveModelsToLayout)) 
			{
				$script:btnMoveModelsToLayout = New-Object Windows.Forms.Button
				$btnMoveModelsToLayout.Width = $btnCopyModelsToLayout.Width
				$btnMoveModelsToLayout.Left = $btnCopyModelsToLayout.Left
				$btnMoveModelsToLayout.Top =  ($grpCopyMoveModelsToLayout.Height * .66) - ($btnMoveModelsToLayout.Height / 2) + 5
				$btnMoveModelsToLayout.Text = "Move Model"
				$btnMoveModelsToLayout.TextAlign = "MiddleCenter"
				$btnMoveModelsToLayout.Cursor = "Hand"
				$btnMoveModelsToLayout.ForeColor = "Gray"
				$btnMoveModelsToLayout.BackColor = "LightGray"
				$btnMoveModelsToLayout.Anchor = "Top,Right"
				$btnMoveModelsToLayout.Add_Click({

						$intNodesMoved = 0

						# If the number of selected models is greater than 0 and the target layout has been selected, proceed
						If ($lbxLayoutModels.SelectedItems.Count -gt 0 -and $cboCopyMoveModelsToLayoutList.SelectedItem -ne "")
							{
								[array]$arrSelectedModels = $lbxLayoutModels.SelectedItems
								$intSelectedModelsCount = $arrSelectedModels.Count
								$boolMoveModels = [System.Windows.Forms.MessageBox]::Show("Are you sure you want to move $intSelectedModelsCount $(If ($intSelectedModelsCount -eq 1) {"model"} Else {"models"})`n`nFrom: $($lbxLayouts.SelectedItem) `nTo: $($cboCopyMoveModelsToLayoutList.SelectedItem)`n`n`nNote: The target layout is automatically saved after moving.","Move $(If ($intSelectedModelsCount -eq 1) {"Model"} Else {"Models"})?" , "YesNo", "Exclamation")

								If ($boolMoveModels -eq "Yes")
									{
										# Iterate through the selected items and attempt to move each
										$arrSelectedModels | ForEach-Object {
											
												LogWrite "VERBOSE" "Copying/Moving ""$_"" to ""$($cboCopyMoveModelsToLayoutList.SelectedItem)"""
												$intCopiedNodes = CopyXMLNode -strSource "Companion" -strTarget "Companion" -strSourceLayoutName $lbxLayouts.SelectedItem -strTargetLayoutName $cboCopyMoveModelsToLayoutList.SelectedItem -strNodeType "Model" -strNodeName $_ -boolOverwriteNode "Yes"
												
												# If the node was copied successfully to the target, remove it from the source
												If ($intCopiedNodes -eq 1) 
													{
														LogWrite "INFO" "Removing ""$_"" from ""$($lbxLayouts.SelectedItem)"" after copying to ""$($cboCopyMoveModelsToLayoutList.SelectedItem)"""
														# $boolRemovedNode = RemoveXMLNode -strTarget "Companion" -strLayoutName $lbxLayouts.SelectedItem -strNodeType "Model" -strNodeName $_ -boolOverridePrompts $true

														# Remove the node from the list box
														MoveModelsToFromLayout -strAddRemove "Remove" -strModelName $_

														$intNodesMoved++
													}
													Else
														{
															LogWrite "WARNING" "The copy of ""$_"" to ""$($cboCopyMoveModelsToLayoutList.SelectedItem)"" failed so it will not be removed from ""$($lbxLayouts.SelectedItem)"".  Please try again."
															$lbxLayoutModels.ClearSelected()
														}

											}

										# Reset the listbox
										InitializeCopyMoveDelete -strPanel "Models" -strTask "NoModelSelected"

										# If nodes were moved, update the button to reflect the update
										If ($intNodesMoved -gt 0)
											{
												$btnMoveModelsToLayout.Text = "Moved $intNodesMoved / $intSelectedModelsCount $(If ($intSelectedModelsCount -gt 1) {"Models"} Else {"Model"})"
												$btnMoveModelsToLayout.Forecolor = If ($intNodesMoved -eq $intSelectedModelsCount) {"Green"} Else {"Orange"}
												$btnMoveModelsToLayout.Backcolor = If ($intNodesMoved -eq $intSelectedModelsCount) {"MintCream"} Else {"PapayaWhip"}
											}
									}
							}
					})
				$grpCopyMoveModelsToLayout.Controls.Add($btnMoveModelsToLayout)
			}


		# Create the Layout Models Label
		If (!($lblLayoutModels)) 
			{
				$script:lblLayoutModels = New-Object System.Windows.Forms.Label
				$lblLayoutModels.Width = $pnlModels.Width * .66
				$lblLayoutModels.Height = 20
				$lblLayoutModels.Left = $grpCopyMoveModelsToLayout.Left
				$lblLayoutModels.Top = 10
				$lblLayoutModels.TextAlign = "MiddleLeft"
				$lblLayoutModels.ForeColor = "Blue"
				$lblLayoutModels.Backcolor = "Transparent"
				$lblLayoutModels.Text = "Models in Layout"
				
		#		$lblLayoutModels.Cursor = "Hand"
		#		$lblLayoutModels.Add_Click({
		#							})
				$pnlModels.Controls.Add($lblLayoutModels)
			}
		
		# Create the Layout Models listbox
		If (!($lbxLayoutModels)) 
			{
				$script:lbxLayoutModels = New-Object System.Windows.Forms.ListBox
				$lbxLayoutModels.Left = $lblLayoutModels.Left
				$lbxLayoutModels.Top = $lblLayoutModels.Bottom + 5
				$lbxLayoutModels.Width = $grpCopyMoveModelsToLayout.Width
				$lbxLayoutModels.Height = ($grpCopyMoveModelsToLayout.Top - 5) - ($lblLayoutModels.Bottom + 5)
				$lbxLayoutModels.SelectionMode = "MultiExtended"
				$lbxLayoutModels.Sorted = $true
				$lbxLayoutModels.Visible = $true
				$lbxLayoutModels.Enabled = $false
				$lbxLayoutModels.Anchor = "Left,Right,Top"
				$lbxLayoutModels.Add_MouseUp({
				
					# Enable the Copy/Move and Delete functions
					InitializeCopyMoveDelete -strPanel "Models" -strTask "ModelSelected"
					
					# Modify the text of buttons and labels depending on how many items were selected in the list box
					If ($lbxLayoutModels.SelectedItems.Count -ge 2)
						{
							$grpCopyMoveModelsToLayout.Text = "Copy / Move Models to....."
							$btnCopyModelsToLayout.Text = "Copy Models"
							$btnMoveModelsToLayout.Text = "Move Models"
							$btnDeleteModelsFromLayout.Text = "Delete Models From Layout"
						}
						Else
							{
								$grpCopyMoveModelsToLayout.Text = "Copy / Move Model to....."
								$btnCopyModelsToLayout.Text = "Copy Model"
								$btnMoveModelsToLayout.Text = "Move Model"
								$btnDeleteModelsFromLayout.Text = "Delete Model From Layout"
							}
					
				})
				$lbxLayoutModels.Add_DoubleClick({
				
						# # If the Repository List is not currently being filtered (nothing has been searched for), modify the list
						# If ($txtFilterRepositoryModels.Text -eq $strDefaultFilterText)
						# 	{
						# 		# Remove the selected item from the listbox
						# 		MoveModelsToFromLayout "REMOVE" $lbxLayoutModels.SelectedItem
						# 	}
						
				})
				$pnlModels.Controls.Add($lbxLayoutModels)
			}



		####################################
		# Repository Models
		####################################

		# Create the Repository Models label
		If (!($lblRepositoryModels)) 
			{
				$script:lblRepositoryModels = New-Object System.Windows.Forms.Label
				$lblRepositoryModels.Width = $lblLayoutModels.Width
				$lblRepositoryModels.Height = $lblLayoutModels.Height
				$lblRepositoryModels.Left = $lblLayoutModels.Left
				$lblRepositoryModels.Top = $lbxLayoutModels.Bottom + 50
				$lblRepositoryModels.TextAlign = "MiddleLeft"
				$lblRepositoryModels.ForeColor = "Green"
				$lblRepositoryModels.Backcolor = "Transparent"
				$lblRepositoryModels.Text = "Models in Repository"
				$lblRepositoryModels.Visible = $false
				$lblRepositoryModels.Anchor = "Right,Top"
		#		$lblRepositoryModels.Cursor = "Hand"
		#		$lblRepositoryModels.Add_Click({
		#							})
				$pnlModels.Controls.Add($lblRepositoryModels)
			}
		
		# Create the Repository Models Listbox
		If (!($lbxRepositoryModels)) 
			{
				$script:lbxRepositoryModels = New-Object System.Windows.Forms.ListBox
				$lbxRepositoryModels.Left = $lblRepositoryModels.Left
				$lbxRepositoryModels.Top = $lblRepositoryModels.Bottom + 5
				$lbxRepositoryModels.Width = $lbxLayoutModels.Width
				$lbxRepositoryModels.Height = $lbxLayoutModels.Height
				$lbxRepositoryModels.SelectionMode = "MultiExtended"
				$lbxRepositoryModels.Sorted = $true
				$lbxRepositoryModels.Visible = $false # $true
				$lbxRepositoryModels.Enabled = $false
				$lbxRepositoryModels.Anchor = "Right,Top"
				$lbxRepositoryModels.Add_DoubleClick({
						
						# If the layout models list is not currently being filtered, modify the list
						If ($txtFilterLayoutModels.Text -eq $strDefaultFilterText)
							{
								MoveModelsToFromLayout "ADD" $lbxRepositoryModels.SelectedItem
							}
						
					})
				$pnlModels.Controls.Add($lbxRepositoryModels)
			}
	
		
		

		####################################
		# Layout Model Filters
		####################################

		# Set the default text to appear in the filter boxes
		$script:strDefaultFilterText = "Filter..."

		# Filter Layout Models
		If (!($txtFilterLayoutModels)) 
			{
				$script:txtFilterLayoutModels = New-Object System.Windows.Forms.TextBox
				$txtFilterLayoutModels.Left = $lblLayoutModels.Right
				$txtFilterLayoutModels.Top = $lblLayoutModels.Top
				$txtFilterLayoutModels.Width = $lbxLayoutModels.Width - $lblLayoutModels.Width
				$txtFilterLayoutModels.Height = 30
				$txtFilterLayoutModels.Font = New-Object System.Drawing.Font("Arial",10)
				$txtFilterLayoutModels.ForeColor = "Gray"
				$txtFilterLayoutModels.BackColor = "LightGray"
				$txtFilterLayoutModels.Text = $strDefaultFilterText
				$txtFilterLayoutModels.Anchor = "Top,Right"
				$pnlModels.Controls.Add($txtFilterLayoutModels)
				
				# Add Enter Event
				$txtFilterLayoutModels.Add_Enter({
				
						If ($txtFilterLayoutModels.Text -eq $strDefaultFilterText)
							{
								$txtFilterLayoutModels.Text = ""
							}
						$txtFilterLayoutModels.SelectAll()
						$txtFilterLayoutModels.ForeColor = "Black"
						$txtFilterLayoutModels.BackColor = "White"

						If (!($arrCurrentListOfActiveModels)) {[array]$script:arrCurrentListOfActiveModels = $lbxLayoutModels.Items}

					})
					
				# Add Leave Event
				$txtFilterLayoutModels.Add_Leave({
				
						If ($txtFilterLayoutModels.Text -eq "") 
							{
								ClearListBoxFilter -strTarget "Layout" -strType "Model"
							}
					})
					
				# Add KeyUp Event
				$txtFilterLayoutModels.Add_KeyUp({
						
						# If ($arrCurrentListOfRepositoryModels.Length -gt 0)
						If ($arrCurrentListOfActiveModels.Length -gt 0)
							{
								# If the filter text box is currently hiding the filter reset button, resize the text box to show the button
								If ($txtFilterLayoutModels.Right -eq $btnResetFilterLayoutModels.Right) {$txtFilterLayoutModels.Width = $txtFilterLayoutModels.Width - $btnResetFilterLayoutModels.Width - 2}
								
								# Disable the Save/Cancel Layout Buttons
								$btnSaveLayout.Enabled = $false
								$btnSaveLayout.Forecolor = "Gray"
								$btnSaveLayout.BackColor = "LightGray"
								$btnCancelReloadLayout.Enabled = $false
								$btnCancelReloadLayout.Forecolor = "Gray"
								$btnCancelReloadLayout.BackColor = "LightGray"
								
								# Add the "Filtered" notation to the label
								If ($lblLayoutModels.Text -notlike "* (Filtered)") {$lblLayoutModels.Text += " (Filtered)"}

								# Disable buttons allowing movement 'into' Layout Models while the filter is applied
								$btnMoveAllModelsUp.Enabled = $false
								$btnMoveModelUp.Enabled = $false
						
								$lbxLayoutModels.BeginUpdate()
									$lbxLayoutModels.Items.Clear()
									$arrCurrentListOfActiveModels | Where-Object {$_ -like "*$($txtFilterLayoutModels.Text)*"} | ForEach-Object {If ($_) {$lbxLayoutModels.Items.Add($_)}}
								$lbxLayoutModels.EndUpdate()
							}
					})
				
			}
		
		# Add the Reset Filter Layout Models button
		If (!($btnResetFilterLayoutModels)) 
			{
				$script:btnResetFilterLayoutModels = New-Object Windows.Forms.Button
				$btnResetFilterLayoutModels.Width = 20
				$btnResetFilterLayoutModels.Height = 25
				$btnResetFilterLayoutModels.Left = $txtFilterLayoutModels.Right - $btnResetFilterLayoutModels.Width
				$btnResetFilterLayoutModels.Top = $lblLayoutModels.Top - 1
				$btnResetFilterLayoutModels.Text = "X"
				$btnResetFilterLayoutModels.TextAlign = "MiddleCenter"
				$btnResetFilterLayoutModels.Cursor = "Hand"
				$btnResetFilterLayoutModels.ForeColor = "Black"
				$btnResetFilterLayoutModels.BackColor = "WhiteSmoke"
				$btnResetFilterLayoutModels.Anchor = "Top,Right"
				$btnResetFilterLayoutModels.Add_Click({
				
						ClearListBoxFilter -strTarget "Layout" -strType "Model"
					})
				$pnlModels.Controls.Add($btnResetFilterLayoutModels)
			}
		
		
		####################################
		# Repository Model Filters
		####################################

		# Filter Repository Models
		If (!($txtFilterRepositoryModels)) 
			{
				$script:txtFilterRepositoryModels = New-Object System.Windows.Forms.TextBox
				$txtFilterRepositoryModels.Left = $lblRepositoryModels.Right
				$txtFilterRepositoryModels.Top = $lblRepositoryModels.Top
				$txtFilterRepositoryModels.Width = $lbxRepositoryModels.Width - $lblRepositoryModels.Width
				$txtFilterRepositoryModels.Height = 30
				$txtFilterRepositoryModels.Font = New-Object System.Drawing.Font("Arial",10)
				$txtFilterRepositoryModels.ForeColor = "Gray"
				$txtFilterRepositoryModels.BackColor = "LightGray"
				$txtFilterRepositoryModels.Text = $strDefaultFilterText
				$txtFilterRepositoryModels.Visible = $false
				$txtFilterRepositoryModels.Anchor = "Top,Right"
				$pnlModels.Controls.Add($txtFilterRepositoryModels)
				
				# Add Enter Event
				$txtFilterRepositoryModels.Add_Enter({
						If ($txtFilterRepositoryModels.Text -eq $strDefaultFilterText)
							{
								$txtFilterRepositoryModels.Text = ""
							}
						$txtFilterRepositoryModels.SelectAll()
						$txtFilterRepositoryModels.ForeColor = "Black"
						$txtFilterRepositoryModels.BackColor = "White"
						
						If (!($arrCurrentListOfRepositoryModels)) {[array]$script:arrCurrentListOfRepositoryModels = $lbxRepositoryModels.Items}
					})
					
				# Add Leave Event
				$txtFilterRepositoryModels.Add_Leave({
						If ($txtFilterRepositoryModels.Text -eq "") 
							{
								ClearListBoxFilter -strTarget "Repository" -strType "Model"
							}
					})
					
				# Add KeyUp Event
				$txtFilterRepositoryModels.Add_KeyUp({
						
						If ($txtFilterRepositoryModels.Right -eq $btnResetFilterRepositoryModels.Right) {$txtFilterRepositoryModels.Width = $txtFilterRepositoryModels.Width - $btnResetFilterRepositoryModels.Width - 2}
						
						# Disable the Save/Cancel Layout Buttons
						$btnSaveLayout.Enabled = $false
						$btnSaveLayout.Forecolor = "Gray"
						$btnSaveLayout.BackColor = "LightGray"
						$btnCancelReloadLayout.Enabled = $false
						$btnCancelReloadLayout.Forecolor = "Gray"
						$btnCancelReloadLayout.BackColor = "LightGray"
						
						# Add the "Filtered" notation to the label
						If ($lblRepositoryModels.Text -notlike "* (Filtered)") {$lblRepositoryModels.Text += " (Filtered)"}

						# Disable buttons allowing movement 'into' Repository Models while the filter is applied
						$btnMoveAllModelsDown.Enabled = $false
						$btnMoveModelDown.Enabled = $false
				
						$lbxRepositoryModels.BeginUpdate()
							$lbxRepositoryModels.Items.Clear()
							$arrCurrentListOfRepositoryModels | Where-Object {$_ -like "*$($txtFilterRepositoryModels.Text)*"} | ForEach-Object {If ($_) {$lbxRepositoryModels.Items.Add($_)}}
						$lbxRepositoryModels.EndUpdate()
						
					})
			}
		
		# Add the Reset Filter Repository Models button
		If (!($btnResetFilterRepositoryModels)) 
			{
				$script:btnResetFilterRepositoryModels = New-Object Windows.Forms.Button
				$btnResetFilterRepositoryModels.Width = 20
				$btnResetFilterRepositoryModels.Height = 25
				$btnResetFilterRepositoryModels.Left = $lbxRepositoryModels.Right - $btnResetFilterRepositoryModels.Width
				$btnResetFilterRepositoryModels.Top = $lblRepositoryModels.Top - 1
				$btnResetFilterRepositoryModels.Text = "X"
				$btnResetFilterRepositoryModels.TextAlign = "MiddleCenter"
				$btnResetFilterRepositoryModels.Cursor = "Hand"
				$btnResetFilterRepositoryModels.ForeColor = "Black"
				$btnResetFilterRepositoryModels.BackColor = "WhiteSmoke"
				$btnResetFilterRepositoryModels.Visible = $false
				$btnResetFilterRepositoryModels.Anchor = "Top,Right"
				$btnResetFilterRepositoryModels.Add_Click({
						
						ClearListBoxFilter -strTarget "Repository" -strType "Model"
						
					})
				$pnlModels.Controls.Add($btnResetFilterRepositoryModels)
			}
		
		
		####################################
		# Create the model movement buttons
		####################################
		
		
		# Move selected models Up
		If (!($btnMoveModelUp)) 
			{
				$script:btnMoveModelUp = New-Object Windows.Forms.Button
				$btnMoveModelUp.Width = 30
				$btnMoveModelUp.Left = $lbxLayoutModels.Left + ($lbxLayoutModels.Width / 2) - 5 - $btnMoveModelUp.Width
				$btnMoveModelUp.Top = $lbxLayoutModels.Bottom + 25 - ($btnMoveModelUp.Height / 2)
				$btnMoveModelUp.Text = "↑"
				$btnMoveModelUp.TextAlign = "MiddleCenter"
				$btnMoveModelUp.Cursor = "Hand"
				$btnMoveModelUp.ForeColor = "Black"
				$btnMoveModelUp.BackColor = "WhiteSmoke"
				$btnMoveModelUp.Visible = $false
				$btnMoveModelUp.Anchor = "Top,Right"
				$btnMoveModelUp.Add_Click({

						[array]$arrItemsToMoveUp = $lbxRepositoryModels.SelectedItems

						ForEach ($objItemToMoveUp in $arrItemsToMoveUp)
							{
								MoveModelsToFromLayout "ADD" $objItemToMoveUp
							}
						
						$lbxRepositoryModels.ClearSelected()
						$lbxLayoutModels.ClearSelected()
				
						Remove-Variable objItemToMoveUp -ErrorAction SilentlyContinue
						Remove-Variable arrItemsToMoveUp -ErrorAction SilentlyContinue
					})
				$pnlModels.Controls.Add($btnMoveModelUp)
			}
	
	
		# Move all models Up
		If (!($btnMoveAllModelsUp)) 
			{
				$script:btnMoveAllModelsUp = New-Object Windows.Forms.Button
				$btnMoveAllModelsUp.Width = $btnMoveModelUp.Width
				$btnMoveAllModelsUp.Left = $btnMoveModelUp.Left - 5 - $btnMoveAllModelsUp.Width
				$btnMoveAllModelsUp.Top = $btnMoveModelUp.Top
				$btnMoveAllModelsUp.Text = "↑↑"
				$btnMoveAllModelsUp.TextAlign = "MiddleCenter"
				$btnMoveAllModelsUp.Cursor = "Hand"
				$btnMoveAllModelsUp.ForeColor = "Black"
				$btnMoveAllModelsUp.BackColor = "WhiteSmoke"
				$btnMoveAllModelsUp.Visible = $false
				$btnMoveAllModelsUp.Anchor = "Top,Right"
				$btnMoveAllModelsUp.Add_Click({
				
						[array]$arrItemsToMoveUp = $lbxRepositoryModels.Items

						ForEach ($objItemToMoveUp in $arrItemsToMoveUp)
							{
								MoveModelsToFromLayout "ADD" $objItemToMoveUp
							}

						$lbxRepositoryModels.ClearSelected()
						$lbxLayoutModels.ClearSelected()
				
						Remove-Variable objItemToMoveUp -ErrorAction SilentlyContinue
						Remove-Variable arrItemsToMoveUp -ErrorAction SilentlyContinue
					})
				$pnlModels.Controls.Add($btnMoveAllModelsUp)
			}

			

		# Move selected models Down
		If (!($btnMoveModelDown)) 
			{
				$script:btnMoveModelDown = New-Object Windows.Forms.Button
				$btnMoveModelDown.Width = $btnMoveModelUp.Width
				$btnMoveModelDown.Left = $lbxLayoutModels.Left + ($lbxLayoutModels.Width / 2) + 5
				$btnMoveModelDown.Top = $btnMoveModelUp.Top
				$btnMoveModelDown.Text = "↓"
				$btnMoveModelDown.TextAlign = "MiddleCenter"
				$btnMoveModelDown.Cursor = "Hand"
				$btnMoveModelDown.ForeColor = "Black"
				$btnMoveModelDown.BackColor = "WhiteSmoke"
				$btnMoveModelDown.Visible = $false
				$btnMoveModelDown.Anchor = "Top,Right"
				$btnMoveModelDown.Add_Click({
				
						[array]$arrItemsToMoveDown = $lbxLayoutModels.SelectedItems

						ForEach ($objItemToMoveDown in $arrItemsToMoveDown)
							{
								MoveModelsToFromLayout "REMOVE" $objItemToMoveDown
							}
						
						$lbxRepositoryModels.ClearSelected()
						$lbxLayoutModels.ClearSelected()
				
						Remove-Variable objItemToMoveRight -ErrorAction SilentlyContinue
						Remove-Variable arrItemsToMoveRight -ErrorAction SilentlyContinue
					})
				$pnlModels.Controls.Add($btnMoveModelDown)
			}

		# Move all models Down
		If (!($btnMoveAllModelsDown)) 
			{
				$script:btnMoveAllModelsDown = New-Object Windows.Forms.Button
				$btnMoveAllModelsDown.Width = $btnMoveModelUp.Width
				$btnMoveAllModelsDown.Left = $btnMoveModelDown.Right + 5
				$btnMoveAllModelsDown.Top =  $btnMoveModelUp.Top
				$btnMoveAllModelsDown.Text = "↓↓"
				$btnMoveAllModelsDown.TextAlign = "MiddleCenter"
				$btnMoveAllModelsDown.Cursor = "Hand"
				$btnMoveAllModelsDown.ForeColor = "Black"
				$btnMoveAllModelsDown.BackColor = "WhiteSmoke"
				$btnMoveAllModelsDown.Visible = $false
				$btnMoveAllModelsDown.Anchor = "Top,Right"
				$btnMoveAllModelsDown.Add_Click({
				
						[array]$arrItemsToMoveDown = $lbxLayoutModels.Items

						ForEach ($objItemToMoveDown in $arrItemsToMoveDown)
							{
								#Write-Host "Move $objItemToMoveDown"
								MoveModelsToFromLayout "REMOVE" $objItemToMoveDown
							}

						$lbxRepositoryModels.ClearSelected()
						$lbxLayoutModels.ClearSelected()
				
						Remove-Variable objItemToMoveDown -ErrorAction SilentlyContinue
						Remove-Variable arrItemsToMoveDown -ErrorAction SilentlyContinue
					})
				$pnlModels.Controls.Add($btnMoveAllModelsDown)
			}
	
	

		####################################
		# Layout Model Groups
		####################################

		# Model Groups Panel
		If (!($pnlModelGroups)) 
			{
				$script:pnlModelGroups = New-Object System.Windows.Forms.Panel
				$pnlModelGroups.Name = "ModelGroupsPanel"
				$pnlModelGroups.Left = $pnlModels.Right + 10
				$pnlModelGroups.Top = $pnlModels.Top
				$pnlModelGroups.Width = $pnlModels.Width
				$pnlModelGroups.Height = $pnlModels.Height
				$pnlModelGroups.BackColor = "WhiteSmoke"
				$pnlModelGroups.Anchor = "Top,Left,Right"
				$pnlContentPanel2.Controls.Add($pnlModelGroups)
			}

		# Create the Delete Model Groups button
		If (!($btnDeleteModelGroupsFromLayout)) 
			{
				$script:btnDeleteModelGroupsFromLayout = New-Object Windows.Forms.Button
				$btnDeleteModelGroupsFromLayout.Width = $pnlModelGroups.Width * .66
				$btnDeleteModelGroupsFromLayout.Left = ($pnlModelGroups.Width / 2) - ($btnDeleteModelGroupsFromLayout.Width / 2)
				$btnDeleteModelGroupsFromLayout.Top = $pnlModelGroups.Height - $btnDeleteModelGroupsFromLayout.Height - 5
				$btnDeleteModelGroupsFromLayout.Text = "Delete Model Group From Layout"
				$btnDeleteModelGroupsFromLayout.TextAlign = "MiddleCenter"
				$btnDeleteModelGroupsFromLayout.Cursor = "Hand"
				$btnDeleteModelGroupsFromLayout.ForeColor = "Gray"
				$btnDeleteModelGroupsFromLayout.BackColor = "LightGray"
				$btnDeleteModelGroupsFromLayout.Enabled = $true
				$btnDeleteModelGroupsFromLayout.Anchor = "Top,Left,Right"
				$btnDeleteModelGroupsFromLayout.Add_Click({

						$intNodesDeleted = 0

						# If the number of selected model groups is greater than 0 and the target layout has been selected, proceed
						If ($lbxLayoutModelGroups.SelectedItems.Count -gt 0)
							{
								[array]$arrSelectedModelGroups = $lbxLayoutModelGroups.SelectedItems
								$intSelectedModelGroupsCount = $arrSelectedModelGroups.Count
								$boolDeleteModelGroups = [System.Windows.Forms.MessageBox]::Show("Are you sure you want to delete $intSelectedModelGroupsCount $(If ($intSelectedModelGroupsCount -eq 1) {"model group"} Else {"model groups"})`n`nFrom: $($lbxLayouts.SelectedItem)","Delete $(If ($intSelectedModelGroupsCount -eq 1) {"Model Group"} Else {"Model Groups"})?" , "YesNo", "Exclamation")

								If ($boolDeleteModelGroups -eq "Yes")
									{
										# Iterate through the selected items and copy each
										$arrSelectedModelGroups | ForEach-Object {
											
												LogWrite "INFO" "Deleting ""$_"" from ""$($lbxLayouts.SelectedItem)"""
												# $boolRemovedNode = RemoveXMLNode -strTarget "Companion" -strLayoutName $lbxLayouts.SelectedItem -strNodeType "ModelGroup" -strNodeName $_ -boolOverridePrompts $true

												# Remove the node from the list box
												MoveModelGroupsToFromLayout -strAddRemove "Remove" -strModelGroupName $_

												$intNodesDeleted++
											}

										# Refresh the panel/listbox from the XML
										InitializeCopyMoveDelete -strPanel "ModelGroups" -strTask "NoModelGroupSelected"

										# If nodes were deleted, update the button to reflect the update
										If ($intNodesDeleted -gt 0)
											{
												$btnDeleteModelGroupsFromLayout.Text = "Deleted $intNodesDeleted / $intSelectedModelGroupsCount $(If ($intSelectedModelGroupsCount -gt 1) {"Model Groups"} Else {"Model Group"}) From Layout"
												$btnDeleteModelGroupsFromLayout.Forecolor = If ($intNodesDeleted -eq $intSelectedModelGroupsCount) {"Green"} Else {"Orange"}
												$btnDeleteModelGroupsFromLayout.Backcolor = If ($intNodesDeleted -eq $intSelectedModelGroupsCount) {"MintCream"} Else {"PapayaWhip"}
											}
									}

							}

					})
				$pnlModelGroups.Controls.Add($btnDeleteModelGroupsFromLayout)
			}
						

		# Copy/Move Model Groups to layout group box
		If (!($grpCopyMoveModelGroupsToLayout)) 
			{
				$script:grpCopyMoveModelGroupsToLayout = New-Object Windows.Forms.GroupBox
				$grpCopyMoveModelGroupsToLayout.Width = $pnlModelGroups.Width - 20
				$grpCopyMoveModelGroupsToLayout.Height = $pnlModelGroups.Height * .20
				$grpCopyMoveModelGroupsToLayout.Left = 10
				$grpCopyMoveModelGroupsToLayout.Top =  $btnDeleteModelGroupsFromLayout.Top - $grpCopyMoveModelGroupsToLayout.Height - 20
				$grpCopyMoveModelGroupsToLayout.Enabled = $false
				$grpCopyMoveModelGroupsToLayout.Anchor = "Top,Left,Right"
				$grpCopyMoveModelGroupsToLayout.Text = "Copy / Move Model Group to....."
				$pnlModelGroups.Controls.Add($grpCopyMoveModelGroupsToLayout)
			}


		# Copy/Move Model Groups to Layout Drop Down
		If (!($cboCopyMoveModelGroupsToLayoutList)) 
			{
				$script:cboCopyMoveModelGroupsToLayoutList = New-Object System.Windows.Forms.ComboBox
				$cboCopyMoveModelGroupsToLayoutList.Width = $grpCopyMoveModelGroupsToLayout.Width * .50
				$cboCopyMoveModelGroupsToLayoutList.Left = 10
				$cboCopyMoveModelGroupsToLayoutList.Top = ($grpCopyMoveModelGroupsToLayout.Height / 2) - ($cboCopyMoveModelGroupsToLayoutList.Height / 2)
				$cboCopyMoveModelGroupsToLayoutList.Height = 20
				$cboCopyMoveModelGroupsToLayoutList.ForeColor = "Black"
				$cboCopyMoveModelGroupsToLayoutList.Backcolor = "White"
				$cboCopyMoveModelGroupsToLayoutList.Font = New-Object System.Drawing.Font("Arial",10)
				$cboCopyMoveModelGroupsToLayoutList.Anchor = "Top,Left,Right"
				$cboCopyMoveModelGroupsToLayoutList.Add_SelectedValueChanged({

						# If the selected value is not blank, enable the Copy/Move buttons
						If ($cboCopyMoveModelGroupsToLayoutList.SelectedItem -ne "")
							{
								# Enable the Copy/Move and Delete functions
								InitializeCopyMoveDelete -strPanel "ModelGroups" -strTask "TargetSelected"
							}
							Else
								{
									# If the list box selection is not null, update the CopyMoveDelete functions
									If ($null -ne $lbxLayoutModelGroups.SelectedItem)
										{
											InitializeCopyMoveDelete -strPanel "ModelGroups" -strTask "ModelGroupSelected"
										}
								}
					})

				$grpCopyMoveModelGroupsToLayout.Controls.Add($cboCopyMoveModelGroupsToLayoutList)
			}
		
		# Copy model groups to layout button
		If (!($btnCopyModelGroupsToLayout)) 
			{
				$script:btnCopyModelGroupsToLayout = New-Object Windows.Forms.Button
				$btnCopyModelGroupsToLayout.Width = $btnCopyModelsToLayout.Width
				$btnCopyModelGroupsToLayout.Left = $grpCopyMoveModelGroupsToLayout.Width - $btnCopyModelGroupsToLayout.Width - 5
				$btnCopyModelGroupsToLayout.Top = ($grpCopyMoveModelGroupsToLayout.Height * .33) - ($btnCopyModelGroupsToLayout.Height / 2)
				$btnCopyModelGroupsToLayout.Text = "Copy Model Group"
				$btnCopyModelGroupsToLayout.TextAlign = "MiddleCenter"
				$btnCopyModelGroupsToLayout.Cursor = "Hand"
				$btnCopyModelGroupsToLayout.ForeColor = "Gray"
				$btnCopyModelGroupsToLayout.BackColor = "LightGray"
				$btnCopyModelGroupsToLayout.Anchor = "Top,Right"
				$btnCopyModelGroupsToLayout.Add_Click({

						$intNodesCopied = 0

						# If the number of selected model groups is greater than 0 and the target layout has been selected, proceed
						If ($lbxLayoutModelGroups.SelectedItems.Count -gt 0 -and $cboCopyMoveModelGroupsToLayoutList.SelectedItem -ne "")
							{
								[array]$arrSelectedModelGroups = $lbxLayoutModelGroups.SelectedItems
								$intSelectedModelGroupsCount = $arrSelectedModelGroups.Count
								$boolCopyModelGroups = [System.Windows.Forms.MessageBox]::Show("Are you sure you want to copy $intSelectedModelGroupsCount $(If ($intSelectedModelGroupsCount -eq 1) {"model group"} Else {"model groups"})`n`nTo: $($cboCopyMoveModelGroupsToLayoutList.SelectedItem)`n`n`nNote: The target layout is automatically saved after copying.","Copy $(If ($intSelectedModelGroupsCount -eq 1) {"Model Group"} Else {"Model Groups"})?" , "YesNo", "Exclamation")

								If ($boolCopyModelGroups -eq "Yes")
									{
										# Iterate through the selected items and copy each
										$arrSelectedModelGroups | ForEach-Object {
											
												LogWrite "VERBOSE" "Copying ""$_"" to $($cboCopyMoveModelGroupsToLayoutList.SelectedItem)"
												$intNodesProcessed = CopyXMLNode -strSource "Companion" -strTarget "Companion" -strSourceLayoutName $lbxLayouts.SelectedItem -strTargetLayoutName $cboCopyMoveModelGroupsToLayoutList.SelectedItem -strNodeType "ModelGroup" -strNodeName $_ -boolOverwriteNode "Yes"

												# If the number of nodes copied is 1, increment the counter, flag the script to require a save, and reset the flag
												If ($intNodesProcessed -eq 1)
													{
														$intNodesCopied++

														xLightsCompanionUpdates $true

														# Reset the copied nodes counter
														$intNodesProcessed = 0
													}
											}
										
										# Refresh the panel/listbox from the XML
										ModifyPanels -strTask "Disable" -strPanel "ModelGroups"
										LoadLayoutResourcesFromCompanionXML -strLayoutName $lbxLayouts.SelectedItem -strNodeType "ModelGroup"
										InitializeCopyMoveDelete -strPanel "ModelGroups" -strTask "NoModelGroupSelected"
										ModifyPanels -strTask "Enable" -strPanel "ModelGroups"

										# If nodes were copied, update the button to reflect the update
										If ($intNodesCopied -gt 0)
											{
												$btnCopyModelGroupsToLayout.Text = "Copied $intNodesCopied / $intSelectedModelGroupsCount $(If ($intSelectedModelGroupsCount -gt 1) {"Model Groups"} Else {"Model Group"})"
												$btnCopyModelGroupsToLayout.Forecolor = If ($intNodesCopied -eq $intSelectedModelGroupsCount) {"Green"} Else {"Orange"}
												$btnCopyModelGroupsToLayout.Backcolor = If ($intNodesCopied -eq $intSelectedModelGroupsCount) {"MintCream"} Else {"PapayaWhip"}
											}
									}
							}
					})
				$grpCopyMoveModelGroupsToLayout.Controls.Add($btnCopyModelGroupsToLayout)
			}
		
		# Move model groups to layout button
		If (!($btnMoveModelGroupsToLayout)) 
			{
				$script:btnMoveModelGroupsToLayout = New-Object Windows.Forms.Button
				$btnMoveModelGroupsToLayout.Width = $btnCopyModelGroupsToLayout.Width
				$btnMoveModelGroupsToLayout.Left = $btnCopyModelGroupsToLayout.Left
				$btnMoveModelGroupsToLayout.Top =  ($grpCopyMoveModelGroupsToLayout.Height * .66) - ($btnMoveModelGroupsToLayout.Height / 2) + 5
				$btnMoveModelGroupsToLayout.Text = "Move Model Group"
				$btnMoveModelGroupsToLayout.TextAlign = "MiddleCenter"
				$btnMoveModelGroupsToLayout.Cursor = "Hand"
				$btnMoveModelGroupsToLayout.ForeColor = "Gray"
				$btnMoveModelGroupsToLayout.BackColor = "LightGray"
				$btnMoveModelGroupsToLayout.Anchor = "Top,Right"
				$btnMoveModelGroupsToLayout.Add_Click({

						$intNodesMoved = 0

						# If the number of selected model groups is greater than 0 and the target layout has been selected, proceed
						If ($lbxLayoutModelGroups.SelectedItems.Count -gt 0 -and $cboCopyMoveModelGroupsToLayoutList.SelectedItem -ne "")
							{
								[array]$arrSelectedModelGroups = $lbxLayoutModelGroups.SelectedItems
								$intSelectedModelGroupsCount = $arrSelectedModelGroups.Count
								$boolMoveModelGroups = [System.Windows.Forms.MessageBox]::Show("Are you sure you want to move $intSelectedModelGroupsCount $(If ($intSelectedModelGroupsCount -eq 1) {"model group"} Else {"model groups"})`n`nFrom: $($lbxLayouts.SelectedItem) `nTo: $($cboCopyMoveModelGroupsToLayoutList.SelectedItem)`n`n`nNote: The target layout is automatically saved after moving.","Move $(If ($intSelectedModelGroupsCount -eq 1) {"Model Group"} Else {"Model Groups"})?" , "YesNo", "Exclamation")

								If ($boolMoveModelGroups -eq "Yes")
									{
										# Iterate through the selected items and attempt to move each
										$arrSelectedModelGroups | ForEach-Object {
											
												LogWrite "VERBOSE" "Moving ""$_"" to ""$($cboCopyMoveModelGroupsToLayoutList.SelectedItem)"""
												$intCopiedNodes = CopyXMLNode -strSource "Companion" -strTarget "Companion" -strSourceLayoutName $lbxLayouts.SelectedItem -strTargetLayoutName $cboCopyMoveModelGroupsToLayoutList.SelectedItem -strNodeType "ModelGroup" -strNodeName $_ -boolOverwriteNode "Yes"
												
												# If the node was copied successfully to the target, remove it from the source
												If ($intCopiedNodes -eq 1) 
													{
														LogWrite "INFO" "Removing ""$_"" from ""$($lbxLayouts.SelectedItem)"" after copying to ""$($cboCopyMoveModelGroupsToLayoutList.SelectedItem)"""
														# $boolRemovedNode = RemoveXMLNode -strTarget "Companion" -strLayoutName $lbxLayouts.SelectedItem -strNodeType "ModelGroup" -strNodeName $_ -boolOverridePrompts $true

														# Remove the node from the list box
														MoveModelGroupsToFromLayout -strAddRemove "Remove" -strModelGroupName $_

														$intNodesMoved++
													}
													Else
														{
															LogWrite "WARNING" "The copy of ""$_"" to ""$($cboCopyMoveModelGroupsToLayoutList.SelectedItem)"" failed so it will not be removed from ""$($lbxLayouts.SelectedItem)"".  Please try again."
															$lbxLayoutModelGroups.ClearSelected()
														}

											}

										# Reset the listbox
										InitializeCopyMoveDelete -strPanel "ModelGroups" -strTask "NoModelGroupSelected"

										# If nodes were moved, update the button to reflect the update
										If ($intNodesMoved -gt 0)
											{
												$btnMoveModelGroupsToLayout.Text = "Moved $intNodesMoved / $intSelectedModelGroupsCount $(If ($intSelectedModelGroupsCount -gt 1) {"Model Groups"} Else {"Model Group"})"
												$btnMoveModelGroupsToLayout.Forecolor = If ($intNodesMoved -eq $intSelectedModelGroupsCount) {"Green"} Else {"Orange"}
												$btnMoveModelGroupsToLayout.Backcolor = If ($intNodesMoved -eq $intSelectedModelGroupsCount) {"MintCream"} Else {"PapayaWhip"}
											}
									}
							}
					})
				$grpCopyMoveModelGroupsToLayout.Controls.Add($btnMoveModelGroupsToLayout)
			}




		# Create the Layout Model Groups Label
		If (!($lblLayoutModelGroups)) 
			{
				$script:lblLayoutModelGroups = New-Object System.Windows.Forms.Label
				$lblLayoutModelGroups.Width = $lblLayoutModels.Width
				$lblLayoutModelGroups.Height = $lblLayouts.Height
				$lblLayoutModelGroups.Left = 10
				$lblLayoutModelGroups.Top = 10
				$lblLayoutModelGroups.TextAlign = "MiddleLeft"
				$lblLayoutModelGroups.ForeColor = "Blue"
				$lblLayoutModelGroups.Backcolor = "Transparent"
				$lblLayoutModelGroups.Text = "Model Groups in Layout"
				
		#		$lblLayoutModelGroups.Cursor = "Hand"
		#		$lblLayoutModelGroups.Add_Click({
		#							})
				$pnlModelGroups.Controls.Add($lblLayoutModelGroups)
			}
		
		# Create the Layout Model Groups listbox
		If (!($lbxLayoutModelGroups)) 
			{
				$script:lbxLayoutModelGroups = New-Object System.Windows.Forms.ListBox
				$lbxLayoutModelGroups.Left = $lblLayoutModelGroups.Left
				$lbxLayoutModelGroups.Top = $lblLayoutModelGroups.Bottom + 5
				$lbxLayoutModelGroups.Width = $lbxLayoutModels.Width
				$lbxLayoutModelGroups.Height = $lbxLayoutModels.Height
				$lbxLayoutModelGroups.SelectionMode = "MultiExtended"
				$lbxLayoutModelGroups.Sorted = $true
				$lbxLayoutModelGroups.Visible = $true
				$lbxLayoutModelGroups.Enabled = $false
				$lbxLayoutModelGroups.Anchor = "Left,Right,Top"
				$lbxLayoutModelGroups.Add_MouseUp({
				
					# Enable the Copy/Move and Delete functions
					InitializeCopyMoveDelete -strPanel "ModelGroups" -strTask "ModelGroupSelected"
					
					# Modify the text of buttons and labels depending on how many items were selected in the list box
					If ($lbxLayoutModelGroups.SelectedItems.Count -ge 2)
						{
							$grpCopyMoveModelGroupsToLayout.Text = "Copy / Move Model Groups to....."
							$btnCopyModelGroupsToLayout.Text = "Copy Model Groups"
							$btnMoveModelGroupsToLayout.Text = "Move Model Groups"
							$btnDeleteModelGroupsFromLayout.Text = "Delete Model Groups From Layout"
						}
						Else
							{
								$grpCopyMoveModelGroupsToLayout.Text = "Copy / Move Model Group to....."
								$btnCopyModelGroupsToLayout.Text = "Copy Model Group"
								$btnMoveModelGroupsToLayout.Text = "Move Model Group"
								$btnDeleteModelGroupsFromLayout.Text = "Delete Model Group From Layout"
							}
					
				})
				$lbxLayoutModelGroups.Add_DoubleClick({
				
						# If the Repository model groups list is not currently being filtered, modify the list
						If ($txtFilterRepositoryModelGroups.Text -eq $strDefaultFilterText)
							{
								# Remove the selected item from the listbox
								MoveModelGroupsToFromLayout "REMOVE" $lbxLayoutModelGroups.SelectedItem
							}
						
				})
				$pnlModelGroups.Controls.Add($lbxLayoutModelGroups)
			}


				
			
		####################################
		# Repository Model Groups
		####################################

		# Create the Repository Model Groups label
		If (!($lblRepositoryModelGroups)) 
			{
				$script:lblRepositoryModelGroups = New-Object System.Windows.Forms.Label
				$lblRepositoryModelGroups.Width = $lblLayoutModels.Width
				$lblRepositoryModelGroups.Height = $lblLayoutModelGroups.Height
				$lblRepositoryModelGroups.Left = $lblLayoutModelGroups.Left
				$lblRepositoryModelGroups.Top = $lblRepositoryModels.Top
				$lblRepositoryModelGroups.TextAlign = "MiddleLeft"
				$lblRepositoryModelGroups.ForeColor = "Green"
				$lblRepositoryModelGroups.Backcolor = "Transparent"
				$lblRepositoryModelGroups.Text = "Model Groups in Repository"
				$lblRepositoryModelGroups.Visible = $false
				$lblRepositoryModelGroups.Anchor = "Right,Top"
		#		$lblRepositoryModelGroups.Cursor = "Hand"
		#		$lblRepositoryModelGroups.Add_Click({
		#							})
				$pnlModelGroups.Controls.Add($lblRepositoryModelGroups)
			}
		
		# Create the Repository Model Groups Listbox
		If (!($lbxRepositoryModelGroups)) 
			{
				$script:lbxRepositoryModelGroups = New-Object System.Windows.Forms.ListBox
				$lbxRepositoryModelGroups.Left = $lblRepositoryModelGroups.Left
				$lbxRepositoryModelGroups.Top = $lblRepositoryModels.Bottom + 5
				$lbxRepositoryModelGroups.Width = $lbxLayoutModelGroups.Width
				$lbxRepositoryModelGroups.Height = $lbxLayoutModelGroups.Height
				$lbxRepositoryModelGroups.SelectionMode = "MultiExtended"
				$lbxRepositoryModelGroups.Sorted = $true
				$lbxRepositoryModelGroups.Visible = $false # $true
				$lbxRepositoryModelGroups.Enabled = $false
				$lbxRepositoryModelGroups.Visible = $false
				$lbxRepositoryModelGroups.Anchor = "Right,Top"
				$lbxRepositoryModelGroups.Add_Click({
				
					# If an item is selected, populate the details labels with the properties of that item from the xLights XML file
					If ($lbxRepositoryModelGroups.SelectedItem)
						{
							
							
						}
				})
				$lbxRepositoryModelGroups.Add_DoubleClick({
						
						# If the layout model groups list is not currently being filtered, modify the list
						If ($txtFilterLayoutModelGroups.Text -eq $strDefaultFilterText)
							{
								MoveModelGroupsToFromLayout "ADD" $lbxRepositoryModelGroups.SelectedItem
							}
						
					})
				$pnlModelGroups.Controls.Add($lbxRepositoryModelGroups)
			}
	

			
		####################################
		# Layout Model Group Filters
		####################################

		# Filter Layout Model Groups
		If (!($txtFilterLayoutModelGroups)) 
			{
				$script:txtFilterLayoutModelGroups = New-Object System.Windows.Forms.TextBox
				$txtFilterLayoutModelGroups.Left = $lblLayoutModelGroups.Right
				$txtFilterLayoutModelGroups.Top = $lblLayoutModelGroups.Top
				$txtFilterLayoutModelGroups.Width = $lbxLayoutModelGroups.Width - $lblLayoutModelGroups.Width
				$txtFilterLayoutModelGroups.Height = 30
				$txtFilterLayoutModelGroups.Font = New-Object System.Drawing.Font("Arial",10)
				$txtFilterLayoutModelGroups.ForeColor = "Gray"
				$txtFilterLayoutModelGroups.BackColor = "LightGray"
				$txtFilterLayoutModelGroups.Text = $strDefaultFilterText
				$txtFilterLayoutModelGroups.Anchor = "Top,Right"
				$pnlModelGroups.Controls.Add($txtFilterLayoutModelGroups)
				
				# Add Enter Event
				$txtFilterLayoutModelGroups.Add_Enter({
				
						If ($txtFilterLayoutModelGroups.Text -eq $strDefaultFilterText)
							{
								$txtFilterLayoutModelGroups.Text = ""
							}
						$txtFilterLayoutModelGroups.SelectAll()
						$txtFilterLayoutModelGroups.ForeColor = "Black"
						$txtFilterLayoutModelGroups.BackColor = "White"

						If (!($arrCurrentListOfActiveModelGroups)) {[array]$script:arrCurrentListOfActiveModelGroups = $lbxLayoutModelGroups.Items}

					})
					
				# Add Leave Event
				$txtFilterLayoutModelGroups.Add_Leave({
				
						If ($txtFilterLayoutModelGroups.Text -eq "") 
							{
								ClearListBoxFilter -strTarget "Layout" -strType "ModelGroup"
							}

					})
					
				# Add KeyUp Event
				$txtFilterLayoutModelGroups.Add_KeyUp({
						
						If ($arrCurrentListOfActiveModelGroups.Length -gt 0)
							{
					
								If ($txtFilterLayoutModelGroups.Right -eq $btnResetFilterLayoutModelGroups.Right) {$txtFilterLayoutModelGroups.Width = $txtFilterLayoutModelGroups.Width - $btnResetFilterLayoutModelGroups.Width - 2}
								
								# Disable the Save/Cancel Layout Buttons
								$btnSaveLayout.Enabled = $false
								$btnSaveLayout.Forecolor = "Gray"
								$btnSaveLayout.BackColor = "LightGray"
								$btnCancelReloadLayout.Enabled = $false
								$btnCancelReloadLayout.Forecolor = "Gray"
								$btnCancelReloadLayout.BackColor = "LightGray"
								
								# Add the "Filtered" notation to the label
								If ($lblLayoutModelGroups.Text -notlike "* (Filtered)") {$lblLayoutModelGroups.Text += " (Filtered)"}

								# Disable buttons allowing movement 'into' Layout Model Groups while the filter is applied
								$btnMoveAllModelGroupsUp.Enabled = $false
								$btnMoveModelGroupUp.Enabled = $false
						
								$lbxLayoutModelGroups.BeginUpdate()
									$lbxLayoutModelGroups.Items.Clear()
									$arrCurrentListOfActiveModelGroups | Where-Object {$_ -like "*$($txtFilterLayoutModelGroups.Text)*"} | ForEach-Object {If ($_) {$lbxLayoutModelGroups.Items.Add($_)}}
								$lbxLayoutModelGroups.EndUpdate()
							}
					})
				
			}
		
		# Add the Reset Filter Layout Model Groups button
		If (!($btnResetFilterLayoutModelGroups)) 
			{
				$script:btnResetFilterLayoutModelGroups = New-Object Windows.Forms.Button
				$btnResetFilterLayoutModelGroups.Width = 20
				$btnResetFilterLayoutModelGroups.Height = 25
				$btnResetFilterLayoutModelGroups.Left = $txtFilterLayoutModelGroups.Right - $btnResetFilterLayoutModelGroups.Width
				$btnResetFilterLayoutModelGroups.Top = $lblLayoutModelGroups.Top - 1
				$btnResetFilterLayoutModelGroups.Text = "X"
				$btnResetFilterLayoutModelGroups.TextAlign = "MiddleCenter"
				$btnResetFilterLayoutModelGroups.Cursor = "Hand"
				$btnResetFilterLayoutModelGroups.ForeColor = "Black"
				$btnResetFilterLayoutModelGroups.BackColor = "WhiteSmoke"
				$btnResetFilterLayoutModelGroups.Anchor = "Top,Right"
				$btnResetFilterLayoutModelGroups.Add_Click({
						
						ClearListBoxFilter -strTarget "Layout" -strType "ModelGroup"
						
					})
				$pnlModelGroups.Controls.Add($btnResetFilterLayoutModelGroups)
			}
		

		####################################
		# Filter Repository Model Groups
		####################################

		# Filter Repository Model Groups
		If (!($txtFilterRepositoryModelGroups)) 
			{
				$script:txtFilterRepositoryModelGroups = New-Object System.Windows.Forms.TextBox
				$txtFilterRepositoryModelGroups.Left = $lblRepositoryModelGroups.Right
				$txtFilterRepositoryModelGroups.Top = $lblRepositoryModelGroups.Top
				$txtFilterRepositoryModelGroups.Width = $lbxRepositoryModelGroups.Width - $lblRepositoryModelGroups.Width
				$txtFilterRepositoryModelGroups.Height = 30
				$txtFilterRepositoryModelGroups.Font = New-Object System.Drawing.Font("Arial",10)
				$txtFilterRepositoryModelGroups.ForeColor = "Gray"
				$txtFilterRepositoryModelGroups.BackColor = "LightGray"
				$txtFilterRepositoryModelGroups.Text = $strDefaultFilterText
				$txtFilterRepositoryModelGroups.Visible = $false
				$txtFilterRepositoryModelGroups.Anchor = "Top,Right"
				$pnlModelGroups.Controls.Add($txtFilterRepositoryModelGroups)
				
				# Add Enter Event
				$txtFilterRepositoryModelGroups.Add_Enter({
						If ($txtFilterRepositoryModelGroups.Text -eq $strDefaultFilterText)
							{
								$txtFilterRepositoryModelGroups.Text = ""
							}
						$txtFilterRepositoryModelGroups.SelectAll()
						$txtFilterRepositoryModelGroups.ForeColor = "Black"
						$txtFilterRepositoryModelGroups.BackColor = "White"
						
						If (!($arrCurrentListOfRepositoryModelGroups)) {[array]$script:arrCurrentListOfRepositoryModelGroups = $lbxRepositoryModelGroups.Items}
					})
					
				# Add Leave Event
				$txtFilterRepositoryModelGroups.Add_Leave({
						If ($txtFilterRepositoryModelGroups.Text -eq "") 
							{
								ClearListBoxFilter -strTarget "Repository" -strType "ModelGroup"
							}

					})
					
				# Add KeyUp Event
				$txtFilterRepositoryModelGroups.Add_KeyUp({
						
						If ($txtFilterRepositoryModelGroups.Right -eq $btnResetFilterRepositoryModelGroups.Right) {$txtFilterRepositoryModelGroups.Width = $txtFilterRepositoryModelGroups.Width - $btnResetFilterRepositoryModelGroups.Width - 2}
						
						# Disable the Save/Cancel Layout Buttons
						$btnSaveLayout.Enabled = $false
						$btnSaveLayout.Forecolor = "Gray"
						$btnSaveLayout.BackColor = "LightGray"
						$btnCancelReloadLayout.Enabled = $false
						$btnCancelReloadLayout.Forecolor = "Gray"
						$btnCancelReloadLayout.BackColor = "LightGray"
						
						# Add the "Filtered" notation to the label
						If ($lblRepositoryModelGroups.Text -notlike "* (Filtered)") {$lblRepositoryModelGroups.Text += " (Filtered)"}
						
						# Disable buttons allowing movement 'into' Repository Model Groups while the filter is applied
						$btnMoveAllModelGroupsDown.Enabled = $false
						$btnMoveModelGroupDown.Enabled = $false
				
						$lbxRepositoryModelGroups.BeginUpdate()
							$lbxRepositoryModelGroups.Items.Clear()
							$arrCurrentListOfRepositoryModelGroups | Where-Object {$_ -like "*$($txtFilterRepositoryModelGroups.Text)*"} | ForEach-Object {If ($_) {$lbxRepositoryModelGroups.Items.Add($_)}}
						$lbxRepositoryModelGroups.EndUpdate()
												
					})
			}
		
		# Add the Reset Filter Repository Model Groups button
		If (!($btnResetFilterRepositoryModelGroups)) 
			{
				$script:btnResetFilterRepositoryModelGroups = New-Object Windows.Forms.Button
				$btnResetFilterRepositoryModelGroups.Width = 20
				$btnResetFilterRepositoryModelGroups.Height = 25
				$btnResetFilterRepositoryModelGroups.Left = $lbxRepositoryModelGroups.Right - $btnResetFilterRepositoryModelGroups.Width
				$btnResetFilterRepositoryModelGroups.Top = $lblRepositoryModelGroups.Top - 1
				$btnResetFilterRepositoryModelGroups.Text = "X"
				$btnResetFilterRepositoryModelGroups.TextAlign = "MiddleCenter"
				$btnResetFilterRepositoryModelGroups.Cursor = "Hand"
				$btnResetFilterRepositoryModelGroups.ForeColor = "Black"
				$btnResetFilterRepositoryModelGroups.BackColor = "WhiteSmoke"
				$btnResetFilterRepositoryModelGroups.Visible = $false
				$btnResetFilterRepositoryModelGroups.Anchor = "Top,Right"
				$btnResetFilterRepositoryModelGroups.Add_Click({
						
						ClearListBoxFilter -strTarget "Repository" -strType "ModelGroup"

					})
				$pnlModelGroups.Controls.Add($btnResetFilterRepositoryModelGroups)
			}


		####################################
		# Create the model group movement buttons
		####################################

		
		# Move selected Model Groups Up
		If (!($btnMoveModelGroupUp)) 
			{
				$script:btnMoveModelGroupUp = New-Object Windows.Forms.Button
				$btnMoveModelGroupUp.Width = 30
				$btnMoveModelGroupUp.Left = $lbxLayoutModelGroups.Left + ($lbxLayoutModelGroups.Width / 2) - 5 - $btnMoveModelGroupUp.Width
				$btnMoveModelGroupUp.Top = $lbxLayoutModelGroups.Bottom + 25 - ($btnMoveModelGroupUp.Height / 2)
				$btnMoveModelGroupUp.Text = "↑"
				$btnMoveModelGroupUp.TextAlign = "MiddleCenter"
				$btnMoveModelGroupUp.Cursor = "Hand"
				$btnMoveModelGroupUp.ForeColor = "Black"
				$btnMoveModelGroupUp.BackColor = "WhiteSmoke"
				$btnMoveModelGroupUp.Visible = $false
				$btnMoveModelGroupUp.Anchor = "Top,Right"
				$btnMoveModelGroupUp.Add_Click({

						[array]$arrItemsToMoveUp = $lbxRepositoryModelGroups.SelectedItems

						ForEach ($objItemToMoveUp in $arrItemsToMoveUp)
							{
								MoveModelGroupsToFromLayout "ADD" $objItemToMoveUp
							}
						
						$lbxRepositoryModelGroups.ClearSelected()
						$lbxLayoutModelGroups.ClearSelected()
				
						Remove-Variable objItemToMoveUp -ErrorAction SilentlyContinue
						Remove-Variable arrItemsToMoveUp -ErrorAction SilentlyContinue
					})
				$pnlModelGroups.Controls.Add($btnMoveModelGroupUp)
			}


		# Move all Model Groups Up
		If (!($btnMoveAllModelGroupsUp)) 
			{
				$script:btnMoveAllModelGroupsUp = New-Object Windows.Forms.Button
				$btnMoveAllModelGroupsUp.Width = $btnMoveModelGroupUp.Width
				$btnMoveAllModelGroupsUp.Left = $btnMoveModelGroupUp.Left - 5 - $btnMoveModelGroupUp.Width
				$btnMoveAllModelGroupsUp.Top = $btnMoveModelGroupUp.Top
				$btnMoveAllModelGroupsUp.Text = "↑↑"
				$btnMoveAllModelGroupsUp.TextAlign = "MiddleCenter"
				$btnMoveAllModelGroupsUp.Cursor = "Hand"
				$btnMoveAllModelGroupsUp.ForeColor = "Black"
				$btnMoveAllModelGroupsUp.BackColor = "WhiteSmoke"
				$btnMoveAllModelGroupsUp.Visible = $false
				$btnMoveAllModelGroupsUp.Anchor = "Top,Right"
				$btnMoveAllModelGroupsUp.Add_Click({
				
						[array]$arrItemsToMoveUp = $lbxRepositoryModelGroups.Items

						ForEach ($objItemToMoveUp in $arrItemsToMoveUp)
							{
								MoveModelGroupsToFromLayout "ADD" $objItemToMoveUp
							}

						$lbxRepositoryModelGroups.ClearSelected()
						$lbxLayoutModelGroups.ClearSelected()
				
						Remove-Variable objItemToMoveUp -ErrorAction SilentlyContinue
						Remove-Variable arrItemsToMoveUp -ErrorAction SilentlyContinue
					})
				$pnlModelGroups.Controls.Add($btnMoveAllModelGroupsUp)
			}


		# Move selected Model Groups Down
		If (!($btnMoveModelGroupDown)) 
			{
				$script:btnMoveModelGroupDown = New-Object Windows.Forms.Button
				$btnMoveModelGroupDown.Width = $btnMoveAllModelGroupsUp.Width
				$btnMoveModelGroupDown.Left = $lbxLayoutModelGroups.Left + ($lbxLayoutModelGroups.Width / 2) + 5
				$btnMoveModelGroupDown.Top = $btnMoveModelGroupUp.Top
				$btnMoveModelGroupDown.Text = "↓"
				$btnMoveModelGroupDown.TextAlign = "MiddleCenter"
				$btnMoveModelGroupDown.Cursor = "Hand"
				$btnMoveModelGroupDown.ForeColor = "Black"
				$btnMoveModelGroupDown.BackColor = "WhiteSmoke"
				$btnMoveModelGroupDown.Visible = $false
				$btnMoveModelGroupDown.Anchor = "Top,Right"
				$btnMoveModelGroupDown.Add_Click({
				
						[array]$arrItemsToMoveDown = $lbxLayoutModelGroups.SelectedItems

						ForEach ($objItemToMoveDown in $arrItemsToMoveDown)
							{
								MoveModelGroupsToFromLayout "REMOVE" $objItemToMoveDown
							}
						
						$lbxRepositoryModelGroups.ClearSelected()
						$lbxLayoutModelGroups.ClearSelected()
				
						Remove-Variable objItemToMoveDown -ErrorAction SilentlyContinue
						Remove-Variable arrItemsToMoveDown -ErrorAction SilentlyContinue
					})
				$pnlModelGroups.Controls.Add($btnMoveModelGroupDown)
			}
	
		# Move all Model Groups Down
		If (!($btnMoveAllModelGroupsDown)) 
			{
				$script:btnMoveAllModelGroupsDown = New-Object Windows.Forms.Button
				$btnMoveAllModelGroupsDown.Width = $btnMoveModelGroupUp.Width
				$btnMoveAllModelGroupsDown.Left = $btnMoveModelGroupDown.Right + 5
				$btnMoveAllModelGroupsDown.Top = $btnMoveModelGroupUp.Top
				$btnMoveAllModelGroupsDown.Text = "↓↓"
				$btnMoveAllModelGroupsDown.TextAlign = "MiddleCenter"
				$btnMoveAllModelGroupsDown.Cursor = "Hand"
				$btnMoveAllModelGroupsDown.ForeColor = "Black"
				$btnMoveAllModelGroupsDown.BackColor = "WhiteSmoke"
				$btnMoveAllModelGroupsDown.Visible = $false
				$btnMoveAllModelGroupsDown.Anchor = "Top,Right"
				$btnMoveAllModelGroupsDown.Add_Click({
				
						[array]$arrItemsToMoveDown = $lbxLayoutModelGroups.Items

						ForEach ($objItemToMoveDown in $arrItemsToMoveDown)
							{
								#Write-Host "Move $objItemToMoveDown"
								MoveModelGroupsToFromLayout "REMOVE" $objItemToMoveDown
							}

						$lbxRepositoryModelGroups.ClearSelected()
						$lbxLayoutModelGroups.ClearSelected()
				
						Remove-Variable objItemToMoveDown -ErrorAction SilentlyContinue
						Remove-Variable arrItemsToMoveDown -ErrorAction SilentlyContinue
					})
				$pnlModelGroups.Controls.Add($btnMoveAllModelGroupsDown)
			}
	
		

		####################################
		# Views
		####################################

		# Layout Views Panel
		If (!($pnlViews)) 
		{
			$script:pnlViews = New-Object System.Windows.Forms.Panel
			$pnlViews.Name = "ViewsPanel"
			$pnlViews.Left = $pnlModelGroups.Right + 10
			$pnlViews.Top = $pnlModels.Top
			$pnlViews.Width = $pnlModels.Width
			$pnlViews.Height = $pnlModels.Height
			$pnlViews.BackColor = "WhiteSmoke"
			$pnlViews.Anchor = "Top,Left,Right"
			$pnlContentPanel2.Controls.Add($pnlViews)
		}

	
		####################################
		# Layout Views
		####################################


		# Create the Delete View button
		If (!($btnDeleteViewsFromLayout)) 
			{
				$script:btnDeleteViewsFromLayout = New-Object Windows.Forms.Button
				$btnDeleteViewsFromLayout.Width = $pnlViews.Width * .66
				$btnDeleteViewsFromLayout.Left = ($pnlViews.Width / 2) - ($btnDeleteViewsFromLayout.Width / 2)
				$btnDeleteViewsFromLayout.Top = $pnlViews.Height - $btnDeleteViewsFromLayout.Height - 5
				$btnDeleteViewsFromLayout.Text = "Delete View From Layout"
				$btnDeleteViewsFromLayout.TextAlign = "MiddleCenter"
				$btnDeleteViewsFromLayout.Cursor = "Hand"
				$btnDeleteViewsFromLayout.ForeColor = "Gray"
				$btnDeleteViewsFromLayout.BackColor = "LightGray"
				$btnDeleteViewsFromLayout.Enabled = $true
				$btnDeleteViewsFromLayout.Anchor = "Top,Left,Right"
				$btnDeleteViewsFromLayout.Add_Click({

						$intNodesDeleted = 0

						# If the number of selected Views is greater than 0 and the target layout has been selected, proceed
						If ($lbxLayoutViews.SelectedItems.Count -gt 0)
							{
								[array]$arrSelectedViews = $lbxLayoutViews.SelectedItems
								$intSelectedViewsCount = $arrSelectedViews.Count
								$boolDeleteViews = [System.Windows.Forms.MessageBox]::Show("Are you sure you want to delete $intSelectedViewsCount $(If ($intSelectedViewsCount -eq 1) {"view"} Else {"views"})`n`nFrom: $($lbxLayouts.SelectedItem)","Delete $(If ($intSelectedViewsCount -eq 1) {"View"} Else {"Views"})?" , "YesNo", "Exclamation")

								If ($boolDeleteViews -eq "Yes")
									{
										# Iterate through the selected items and copy each
										$lbxLayoutViews.SelectedItems | ForEach-Object {
											
												LogWrite "INFO" "Deleting ""$_"" from ""$($lbxLayouts.SelectedItem)"""
												# $boolRemovedNode = RemoveXMLNode -strTarget "Companion" -strLayoutName $lbxLayouts.SelectedItem -strNodeType "View" -strNodeName $_ -boolOverridePrompts $true

												# Remove the node from the list box
												MoveViewsToFromLayout -strAddRemove "Remove" -strViewName $_

												$intNodesDeleted++
											}

										# Reset the listbox
										InitializeCopyMoveDelete -strPanel "Views" -strTask "NoViewSelected"

										# If nodes were deleted, update the button to reflect the update
										If ($intNodesDeleted -gt 0)
											{
												$btnDeleteViewsFromLayout.Text = "Deleted $intNodesDeleted / $intSelectedViewsCount $(If ($intSelectedViewsCount -gt 1) {"Views"} Else {"View"}) From Layout"
												$btnDeleteViewsFromLayout.Forecolor = If ($intNodesDeleted -eq $intSelectedViewsCount) {"Green"} Else {"Orange"}
												$btnDeleteViewsFromLayout.Backcolor = If ($intNodesDeleted -eq $intSelectedViewsCount) {"MintCream"} Else {"PapayaWhip"}
											}
									}
							}

					})
				$pnlViews.Controls.Add($btnDeleteViewsFromLayout)
			}
						

		# Copy/Move Views to layout group box
		If (!($grpCopyMoveViewsToLayout)) 
			{
				$script:grpCopyMoveViewsToLayout = New-Object Windows.Forms.GroupBox
				$grpCopyMoveViewsToLayout.Width = $pnlViews.Width - 20
				$grpCopyMoveViewsToLayout.Height = $pnlViews.Height * .20
				$grpCopyMoveViewsToLayout.Left = 10
				$grpCopyMoveViewsToLayout.Top =  $btnDeleteViewsFromLayout.Top - $grpCopyMoveViewsToLayout.Height - 20
				$grpCopyMoveViewsToLayout.Enabled = $false
				$grpCopyMoveViewsToLayout.Anchor = "Top,Left,Right"
				$grpCopyMoveViewsToLayout.Text = "Copy / Move View to....."
				$pnlViews.Controls.Add($grpCopyMoveViewsToLayout)
			}


		# Copy/Move Views to Layout Drop Down
		If (!($cboCopyMoveViewsToLayoutList)) 
			{
				$script:cboCopyMoveViewsToLayoutList = New-Object System.Windows.Forms.ComboBox
				$cboCopyMoveViewsToLayoutList.Width = $grpCopyMoveViewsToLayout.Width * .50
				$cboCopyMoveViewsToLayoutList.Left = 10
				$cboCopyMoveViewsToLayoutList.Top = ($grpCopyMoveViewsToLayout.Height / 2) - ($cboCopyMoveViewsToLayoutList.Height / 2)
				$cboCopyMoveViewsToLayoutList.Height = 20
				$cboCopyMoveViewsToLayoutList.ForeColor = "Black"
				$cboCopyMoveViewsToLayoutList.Backcolor = "White"
				$cboCopyMoveViewsToLayoutList.Font = New-Object System.Drawing.Font("Arial",10)
				$cboCopyMoveViewsToLayoutList.Anchor = "Top,Left,Right"
				$cboCopyMoveViewsToLayoutList.Add_SelectedValueChanged({

						# If the selected value is not blank, enable the Copy/Move buttons
						If ($cboCopyMoveViewsToLayoutList.SelectedItem -ne "")
							{
								# Enable the Copy/Move and Delete functions
								InitializeCopyMoveDelete -strPanel "Views" -strTask "TargetSelected"
							}
							Else
								{
									# If the list box selection is not null, update the CopyMoveDelete functions
									If ($null -ne $lbxLayoutViews.SelectedItem)
										{
											InitializeCopyMoveDelete -strPanel "Views" -strTask "ViewSelected"
										}

								}
					})

				$grpCopyMoveViewsToLayout.Controls.Add($cboCopyMoveViewsToLayoutList)
			}

		# Copy Views to layout button
		If (!($btnCopyViewsToLayout)) 
			{
				$script:btnCopyViewsToLayout = New-Object Windows.Forms.Button
				$btnCopyViewsToLayout.Width = $btnCopyModelsToLayout.Width
				$btnCopyViewsToLayout.Left = $grpCopyMoveViewsToLayout.Width - $btnCopyViewsToLayout.Width - 5
				$btnCopyViewsToLayout.Top = ($grpCopyMoveViewsToLayout.Height * .33) - ($btnCopyViewsToLayout.Height / 2)
				$btnCopyViewsToLayout.Text = "Copy View"
				$btnCopyViewsToLayout.TextAlign = "MiddleCenter"
				$btnCopyViewsToLayout.Cursor = "Hand"
				$btnCopyViewsToLayout.ForeColor = "Gray"
				$btnCopyViewsToLayout.BackColor = "LightGray"
				$btnCopyViewsToLayout.Anchor = "Top,Right"
				$btnCopyViewsToLayout.Add_Click({

						$intNodesCopied = 0

						# If the number of selected Views is greater than 0 and the target layout has been selected, proceed
						If ($lbxLayoutViews.SelectedItems.Count -gt 0 -and $cboCopyMoveViewsToLayoutList.SelectedItem -ne "")
							{
								[array]$arrSelectedViews = $lbxLayoutViews.SelectedItems
								$intSelectedViewsCount = $arrSelectedViews.Count
								$boolCopyViews = [System.Windows.Forms.MessageBox]::Show("Are you sure you want to copy $intSelectedViewsCount $(If ($intSelectedViewsCount -eq 1) {"view"} Else {"views"})`n`nTo: $($cboCopyMoveViewsToLayoutList.SelectedItem)`n`n`nNote: The target layout is automatically saved after copying.","Copy $(If ($intSelectedViewsCount -eq 1) {"View"} Else {"Views"})?" , "YesNo", "Exclamation")

								If ($boolCopyViews -eq "Yes")
									{
										# Iterate through the selected items and copy each
										$arrSelectedViews | ForEach-Object {
											
												LogWrite "VERBOSE" "Copying ""$_"" to $($cboCopyMoveViewsToLayoutList.SelectedItem)"
												$intNodesProcessed = CopyXMLNode -strSource "Companion" -strTarget "Companion" -strSourceLayoutName $lbxLayouts.SelectedItem -strTargetLayoutName $cboCopyMoveViewsToLayoutList.SelectedItem -strNodeType "View" -strNodeName $_ -boolOverwriteNode "Yes"

												# If the number of nodes copied is 1, increment the counter, flag the script to require a save, and reset the flag
												If ($intNodesProcessed -eq 1)
													{
														$intNodesCopied++

														xLightsCompanionUpdates $true

														# Reset the copied nodes counter
														$intNodesProcessed = 0
													}
											}
										
										# Refresh the panel/listbox from the XML
										ModifyPanels -strTask "Disable" -strPanel "Views"
										LoadLayoutResourcesFromCompanionXML -strLayoutName $lbxLayouts.SelectedItem -strNodeType "View"
										InitializeCopyMoveDelete -strPanel "Views" -strTask "NoViewSelected"
										ModifyPanels -strTask "Enable" -strPanel "Views"

										# If nodes were copied, update the button to reflect the update
										If ($intNodesCopied -gt 0)
											{
												$btnCopyViewsToLayout.Text = "Copied $intNodesCopied / $intSelectedViewsCount $(If ($intSelectedViewsCount -gt 1) {"Views"} Else {"View"})"
												$btnCopyViewsToLayout.Forecolor = If ($intNodesCopied -eq $intSelectedViewsCount) {"Green"} Else {"Orange"}
												$btnCopyViewsToLayout.Backcolor = If ($intNodesCopied -eq $intSelectedViewsCount) {"MintCream"} Else {"PapayaWhip"}
											}
									}
							}
					})
				$grpCopyMoveViewsToLayout.Controls.Add($btnCopyViewsToLayout)
			}

		# Move Views to layout button
		If (!($btnMoveViewsToLayout)) 
			{
				$script:btnMoveViewsToLayout = New-Object Windows.Forms.Button
				$btnMoveViewsToLayout.Width = $btnCopyViewsToLayout.Width
				$btnMoveViewsToLayout.Left = $btnCopyViewsToLayout.Left
				$btnMoveViewsToLayout.Top =  ($grpCopyMoveViewsToLayout.Height * .66) - ($btnMoveViewsToLayout.Height / 2) + 5
				$btnMoveViewsToLayout.Text = "Move View"
				$btnMoveViewsToLayout.TextAlign = "MiddleCenter"
				$btnMoveViewsToLayout.Cursor = "Hand"
				$btnMoveViewsToLayout.ForeColor = "Gray"
				$btnMoveViewsToLayout.BackColor = "LightGray"
				$btnMoveViewsToLayout.Anchor = "Top,Right"
				$btnMoveViewsToLayout.Add_Click({

						$intNodesMoved = 0

						# If the number of selected Views is greater than 0 and the target layout has been selected, proceed
						If ($lbxLayoutViews.SelectedItems.Count -gt 0 -and $cboCopyMoveViewsToLayoutList.SelectedItem -ne "")
							{
								[array]$arrSelectedViews = $lbxLayoutViews.SelectedItems
								$intSelectedViewsCount = $arrSelectedViews.Count
								$boolMoveViews = [System.Windows.Forms.MessageBox]::Show("Are you sure you want to move $intSelectedViewsCount $(If ($intSelectedViewsCount -eq 1) {"view"} Else {"views"})`n`nFrom: $($lbxLayouts.SelectedItem) `nTo: $($cboCopyMoveViewsToLayoutList.SelectedItem)`n`n`nNote: The target layout is automatically saved after copying.","Move $(If ($intSelectedViewsCount -eq 1) {"View"} Else {"Views"})?" , "YesNo", "Exclamation")

								If ($boolMoveViews -eq "Yes")
									{
										# Iterate through the selected items and attempt to move each
										$arrSelectedViews | ForEach-Object {
											
												LogWrite "VERBOSE" "Moving ""$_"" to ""$($cboCopyMoveViewsToLayoutList.SelectedItem)"""
												$intCopiedNodes = CopyXMLNode -strSource "Companion" -strTarget "Companion" -strSourceLayoutName $lbxLayouts.SelectedItem -strTargetLayoutName $cboCopyMoveViewsToLayoutList.SelectedItem -strNodeType "View" -strNodeName $_ -boolOverwriteNode "Yes"
												
												# If the node was copied successfully to the target, remove it from the source
												If ($intCopiedNodes -eq 1) 
													{
														LogWrite "INFO" "Removing ""$_"" from ""$($lbxLayouts.SelectedItem)"" after copying to ""$($cboCopyMoveViewsToLayoutList.SelectedItem)"""
														# $boolRemovedNode = RemoveXMLNode -strTarget "Companion" -strLayoutName $lbxLayouts.SelectedItem -strNodeType "View" -strNodeName $_ -boolOverridePrompts $true

														# Remove the node from the list box
														MoveViewsToFromLayout -strAddRemove "Remove" -strViewName $_

														$intNodesMoved++
													}
													Else
														{
															LogWrite "WARNING" "The copy of ""$_"" to ""$($cboCopyMoveViewsToLayoutList.SelectedItem)"" failed so it will not be removed from ""$($lbxLayouts.SelectedItem)"".  Please try again."
															$lbxLayoutViews.ClearSelected()
														}

											}

										# Reset the listbox
										InitializeCopyMoveDelete -strPanel "Views" -strTask "NoViewSelected"

										# If nodes were moved, update the button to reflect the update
										If ($intNodesMoved -gt 0)
											{
												$btnMoveViewsToLayout.Text = "Moved $intNodesMoved / $intSelectedViewsCount $(If ($intSelectedViewsCount -gt 1) {"Views"} Else {"View"})"
												$btnMoveViewsToLayout.Forecolor = If ($intNodesMoved -eq $intSelectedViewsCount) {"Green"} Else {"Orange"}
												$btnMoveViewsToLayout.Backcolor = If ($intNodesMoved -eq $intSelectedViewsCount) {"MintCream"} Else {"PapayaWhip"}
											}
									}
							}
					})
				$grpCopyMoveViewsToLayout.Controls.Add($btnMoveViewsToLayout)
			}


		# Create the Layout Views Label
		If (!($lblLayoutViews)) 
			{
				$script:lblLayoutViews = New-Object System.Windows.Forms.Label
				$lblLayoutViews.Width = $pnlContentPanel2.Width * .20
				$lblLayoutViews.Height = 20
				$lblLayoutViews.Left = 10
				$lblLayoutViews.Top = 10
				$lblLayoutViews.TextAlign = "MiddleLeft"
				$lblLayoutViews.ForeColor = "Blue"
				$lblLayoutViews.Backcolor = "Transparent"
				$lblLayoutViews.Text = "Views in Layout"
				
		#		$lblLayoutViews.Cursor = "Hand"
		#		$lblLayoutViews.Add_Click({
		#							})
				$pnlViews.Controls.Add($lblLayoutViews)
			}
		
		# Create the Layout Views listbox
		If (!($lbxLayoutViews)) 
			{
				$script:lbxLayoutViews = New-Object System.Windows.Forms.ListBox
				$lbxLayoutViews.Left = $lblLayoutViews.Left
				$lbxLayoutViews.Top = $lblLayoutViews.Bottom + 5
				$lbxLayoutViews.Width = $pnlViews.Width - 20
				$lbxLayoutViews.Height = $lbxLayoutModels.Height # ($pnlViews.Height - 130) / 2
				$lbxLayoutViews.SelectionMode = "MultiExtended"
				$lbxLayoutViews.Sorted = $true
				$lbxLayoutViews.Visible = $true
				$lbxLayoutViews.Enabled = $false
				$lbxLayoutViews.Anchor = "Left,Right,Top"
				$lbxLayoutViews.Add_MouseUp({
				
					# Enable the Copy/Move and Delete functions
					InitializeCopyMoveDelete -strPanel "Views" -strTask "ViewSelected"
					
					# Modify the text of buttons and labels depending on how many items were selected in the list box
					If ($lbxLayoutViews.SelectedItems.Count -ge 2)
						{
							$grpCopyMoveViewsToLayout.Text = "Copy / Move Views to....."
							$btnCopyViewsToLayout.Text = "Copy Views"
							$btnMoveViewsToLayout.Text = "Move Views"
							$btnDeleteViewsFromLayout.Text = "Delete Views From Layout"
						}
						Else
							{
								$grpCopyMoveViewsToLayout.Text = "Copy / Move View to....."
								$btnCopyViewsToLayout.Text = "Copy View"
								$btnMoveViewsToLayout.Text = "Move View"
								$btnDeleteViewsFromLayout.Text = "Delete View From Layout"
							}
					
				})
				$lbxLayoutViews.Add_DoubleClick({
				
						# If the layout views list is not currently being filtered, modify the list
						If ($txtFilterRepositoryViews.Text -eq $strDefaultFilterText)
							{
								# Remove the selected item from the listbox
								MoveViewsToFromLayout "REMOVE" $lbxLayoutViews.SelectedItem
							}
						
				})
				$pnlViews.Controls.Add($lbxLayoutViews)
			}
			

			


		####################################
		# Repository Views
		####################################

		# Create the Repository Views label
		If (!($lblRepositoryViews)) 
			{
				$script:lblRepositoryViews = New-Object System.Windows.Forms.Label
				$lblRepositoryViews.Width = $lblLayoutViews.Width
				$lblRepositoryViews.Height = $lblLayoutViews.Height
				$lblRepositoryViews.Left = $lblLayoutViews.Left
				$lblRepositoryViews.Top = $lbxLayoutViews.Bottom + 50
				$lblRepositoryViews.TextAlign = "MiddleLeft"
				$lblRepositoryViews.ForeColor = "Green"
				$lblRepositoryViews.Backcolor = "Transparent"
				$lblRepositoryViews.Text = "Views in Repository"
				$lblRepositoryViews.Visible = $false
				$lblRepositoryViews.Anchor = "Right,Top"
		#		$lblRepositoryViews.Cursor = "Hand"
		#		$lblRepositoryViews.Add_Click({
		#							})
				$pnlViews.Controls.Add($lblRepositoryViews)
			}
		
		# Create the Repository Views Listbox
		If (!($lbxRepositoryViews)) 
			{
				$script:lbxRepositoryViews = New-Object System.Windows.Forms.ListBox
				$lbxRepositoryViews.Left = $lblRepositoryViews.Left
				$lbxRepositoryViews.Top = $lblRepositoryViews.Bottom + 5
				$lbxRepositoryViews.Width = $lbxLayoutViews.Width
				$lbxRepositoryViews.Height = $lbxLayoutViews.Height
				$lbxRepositoryViews.SelectionMode = "MultiExtended"
				$lbxRepositoryViews.Sorted = $true
				$lbxRepositoryViews.Enabled = $false
				$lbxRepositoryViews.Visible = $false
				$lbxRepositoryViews.Anchor = "Right,Top"
				$lbxRepositoryViews.Add_Click({
				
					# If an item is selected, populate the details labels with the properties of that item from the xLights XML file
					If ($lbxRepositoryViews.SelectedItem)
						{
							
							
						}
				})
				$lbxRepositoryViews.Add_DoubleClick({
						
						# If the Repository views list is not currently being filtered, modify the list
						If ($txtFilterLayoutViews.Text -eq $strDefaultFilterText)
							{
								MoveViewsToFromLayout "ADD" $lbxRepositoryViews.SelectedItem
							}
						
					})
				$pnlViews.Controls.Add($lbxRepositoryViews)
			}

			
		####################################
		# Layout View Filters
		####################################

		# Set the default text to appear in the filter boxes
		$script:strDefaultFilterText = "Filter..."
		

		# Filter Layout Views
		If (!($txtFilterLayoutViews)) 
			{
				$script:txtFilterLayoutViews = New-Object System.Windows.Forms.TextBox
				$txtFilterLayoutViews.Left = $lblLayoutViews.Right
				$txtFilterLayoutViews.Top = $lblLayoutViews.Top
				$txtFilterLayoutViews.Width = $lbxLayoutViews.Width - $lblLayoutViews.Width
				$txtFilterLayoutViews.Height = 30
				$txtFilterLayoutViews.Font = New-Object System.Drawing.Font("Arial",10)
				$txtFilterLayoutViews.ForeColor = "Gray"
				$txtFilterLayoutViews.BackColor = "LightGray"
				$txtFilterLayoutViews.Text = $strDefaultFilterText
				$txtFilterLayoutViews.Anchor = "Top,Right"
				$pnlViews.Controls.Add($txtFilterLayoutViews)
				
				# Add Enter Event
				$txtFilterLayoutViews.Add_Enter({
				
						If ($txtFilterLayoutViews.Text -eq $strDefaultFilterText)
							{
								$txtFilterLayoutViews.Text = ""
							}
						$txtFilterLayoutViews.SelectAll()
						$txtFilterLayoutViews.ForeColor = "Black"
						$txtFilterLayoutViews.BackColor = "White"

						If (!($arrCurrentListOfActiveViews)) {[array]$script:arrCurrentListOfActiveViews = $lbxLayoutViews.Items}

					})
					
				# Add Leave Event
				$txtFilterLayoutViews.Add_Leave({
				
						If ($txtFilterLayoutViews.Text -eq "") 
							{
								ClearListBoxFilter -strTarget "Layout" -strType "View"
							}

					})
					
				# Add KeyUp Event
				$txtFilterLayoutViews.Add_KeyUp({
						
						If ($arrCurrentListOfActiveViews.Length -gt 0)
							{
								If ($txtFilterLayoutViews.Right -eq $btnResetFilterLayoutViews.Right) {$txtFilterLayoutViews.Width = $txtFilterLayoutViews.Width - $btnResetFilterLayoutViews.Width - 2}
								
								# Disable the Save/Cancel Layout Buttons
								$btnSaveLayout.Enabled = $false
								$btnSaveLayout.Forecolor = "Gray"
								$btnSaveLayout.BackColor = "LightGray"
								$btnCancelReloadLayout.Enabled = $false
								$btnCancelReloadLayout.Forecolor = "Gray"
								$btnCancelReloadLayout.BackColor = "LightGray"
								
								# Add the "Filtered" notation to the label
								If ($lblLayoutViews.Text -notlike "* (Filtered)") {$lblLayoutViews.Text += " (Filtered)"}

								# Disable buttons allowing movement 'into' Layout Views while the filter is applied
								$btnMoveAllViewsUp.Enabled = $false
								$btnMoveViewUp.Enabled = $false
						
								$lbxLayoutViews.BeginUpdate()
									$lbxLayoutViews.Items.Clear()
									$arrCurrentListOfActiveViews | Where-Object {$_ -like "*$($txtFilterLayoutViews.Text)*"} | ForEach-Object {If ($_) {$lbxLayoutViews.Items.Add($_)}}
								$lbxLayoutViews.EndUpdate()
							}
					})
				
			}
		
		# Add the Reset Filter Layout Views button
		If (!($btnResetFilterLayoutViews)) 
			{
				$script:btnResetFilterLayoutViews = New-Object Windows.Forms.Button
				$btnResetFilterLayoutViews.Width = 20
				$btnResetFilterLayoutViews.Height = 25
				$btnResetFilterLayoutViews.Left = $txtFilterLayoutViews.Right - $btnResetFilterLayoutViews.Width
				$btnResetFilterLayoutViews.Top = $lblLayoutViews.Top - 1
				$btnResetFilterLayoutViews.Text = "X"
				$btnResetFilterLayoutViews.TextAlign = "MiddleCenter"
				$btnResetFilterLayoutViews.Cursor = "Hand"
				$btnResetFilterLayoutViews.ForeColor = "Black"
				$btnResetFilterLayoutViews.BackColor = "WhiteSmoke"
				$btnResetFilterLayoutViews.Anchor = "Top,Right"
				$btnResetFilterLayoutViews.Add_Click({
				
						ClearListBoxFilter -strTarget "Layout" -strType "View"
						
					})
				$pnlViews.Controls.Add($btnResetFilterLayoutViews)
			}
		
		
		####################################
		# Repository View Filters
		####################################

		# Filter Repository Views
		If (!($txtFilterRepositoryViews)) 
			{
				$script:txtFilterRepositoryViews = New-Object System.Windows.Forms.TextBox
				$txtFilterRepositoryViews.Left = $lblRepositoryViews.Right
				$txtFilterRepositoryViews.Top = $lblRepositoryViews.Top
				$txtFilterRepositoryViews.Width = $lbxRepositoryViews.Width - $lblRepositoryViews.Width
				$txtFilterRepositoryViews.Height = 30
				$txtFilterRepositoryViews.Font = New-Object System.Drawing.Font("Arial",10)
				$txtFilterRepositoryViews.ForeColor = "Gray"
				$txtFilterRepositoryViews.BackColor = "LightGray"
				$txtFilterRepositoryViews.Text = $strDefaultFilterText
				$txtFilterRepositoryViews.Visible = $false
				$txtFilterRepositoryViews.Anchor = "Top,Right"
				$pnlViews.Controls.Add($txtFilterRepositoryViews)
				
				# Add Enter Event
				$txtFilterRepositoryViews.Add_Enter({
						If ($txtFilterRepositoryViews.Text -eq $strDefaultFilterText)
							{
								$txtFilterRepositoryViews.Text = ""
							}
						$txtFilterRepositoryViews.SelectAll()
						$txtFilterRepositoryViews.ForeColor = "Black"
						$txtFilterRepositoryViews.BackColor = "White"
						
						If (!($arrCurrentListOfRepositoryViews)) {[array]$script:arrCurrentListOfRepositoryViews = $lbxRepositoryViews.Items}
					})
					
				# Add Leave Event
				$txtFilterRepositoryViews.Add_Leave({
						If ($txtFilterRepositoryViews.Text -eq "") 
							{
								ClearListBoxFilter -strTarget "Repository" -strType "View"
							}

					})
					
				# Add KeyUp Event
				$txtFilterRepositoryViews.Add_KeyUp({
						
						If ($txtFilterRepositoryViews.Right -eq $btnResetFilterRepositoryViews.Right) {$txtFilterRepositoryViews.Width = $txtFilterRepositoryViews.Width - $btnResetFilterRepositoryViews.Width - 2}
						
						# Disable the Save/Cancel Layout Buttons
						$btnSaveLayout.Enabled = $false
						$btnSaveLayout.Forecolor = "Gray"
						$btnSaveLayout.BackColor = "LightGray"
						$btnCancelReloadLayout.Enabled = $false
						$btnCancelReloadLayout.Forecolor = "Gray"
						$btnCancelReloadLayout.BackColor = "LightGray"
						
						# Add the "Filtered" notation to the label
						If ($lblRepositoryViews.Text -notlike "* (Filtered)") {$lblRepositoryViews.Text += " (Filtered)"}
						
						# Disable buttons allowing movement 'into' Repository Views while the filter is applied
						$btnMoveAllViewsDown.Enabled = $false
						$btnMoveViewDown.Enabled = $false
				
						$lbxRepositoryViews.BeginUpdate()
							$lbxRepositoryViews.Items.Clear()
							$arrCurrentListOfRepositoryViews | Where-Object {$_ -like "*$($txtFilterRepositoryViews.Text)*"} | ForEach-Object {If ($_) {$lbxRepositoryViews.Items.Add($_)}}
						$lbxRepositoryViews.EndUpdate()

					})
			}
		
		# Add the Reset Filter Repository Views button
		If (!($btnResetFilterRepositoryViews)) 
			{
				$script:btnResetFilterRepositoryViews = New-Object Windows.Forms.Button
				$btnResetFilterRepositoryViews.Width = 20
				$btnResetFilterRepositoryViews.Height = 25
				$btnResetFilterRepositoryViews.Left = $lbxRepositoryViews.Right - $btnResetFilterRepositoryViews.Width
				$btnResetFilterRepositoryViews.Top = $lblRepositoryViews.Top - 1
				$btnResetFilterRepositoryViews.Text = "X"
				$btnResetFilterRepositoryViews.TextAlign = "MiddleCenter"
				$btnResetFilterRepositoryViews.Cursor = "Hand"
				$btnResetFilterRepositoryViews.ForeColor = "Black"
				$btnResetFilterRepositoryViews.BackColor = "WhiteSmoke"
				$btnResetFilterRepositoryViews.Visible = $false
				$btnResetFilterRepositoryViews.Anchor = "Top,Right"
				$btnResetFilterRepositoryViews.Add_Click({
						
						ClearListBoxFilter -strTarget "Repository" -strType "View"
						
					})
				$pnlViews.Controls.Add($btnResetFilterRepositoryViews)
			}



	
		####################################
		# Create the view movement buttons
		####################################

		
		# Move selected Views Up
		If (!($btnMoveViewUp)) 
			{
				$script:btnMoveViewUp = New-Object Windows.Forms.Button
				$btnMoveViewUp.Width = 30
				$btnMoveViewUp.Left = $lbxLayoutViews.Left + ($lbxLayoutViews.Width / 2) - 5 - $btnMoveViewUp.Width
				$btnMoveViewUp.Top = $lbxLayoutViews.Bottom + 25 - ($btnMoveViewUp.Height / 2)
				$btnMoveViewUp.Text = "↑"
				$btnMoveViewUp.TextAlign = "MiddleCenter"
				$btnMoveViewUp.Cursor = "Hand"
				$btnMoveViewUp.ForeColor = "Black"
				$btnMoveViewUp.BackColor = "WhiteSmoke"
				$btnMoveViewUp.Visible = $false
				$btnMoveViewUp.Anchor = "Top,Right"
				$btnMoveViewUp.Add_Click({

						[array]$arrItemsToMoveUp = $lbxRepositoryViews.SelectedItems

						ForEach ($objItemToMoveUp in $arrItemsToMoveUp)
							{
								MoveViewsToFromLayout "ADD" $objItemToMoveUp
							}
						
						$lbxRepositoryViews.ClearSelected()
						$lbxLayoutViews.ClearSelected()
				
						Remove-Variable objItemToMoveUp -ErrorAction SilentlyContinue
						Remove-Variable arrItemsToMoveUp -ErrorAction SilentlyContinue
					})
				$pnlViews.Controls.Add($btnMoveViewUp)
			}


		# Move all Views Up
		If (!($btnMoveAllViewsUp)) 
			{
				$script:btnMoveAllViewsUp = New-Object Windows.Forms.Button
				$btnMoveAllViewsUp.Width = $btnMoveViewUp.Width
				$btnMoveAllViewsUp.Left = $btnMoveViewUp.Left - 5 - $btnMoveViewUp.Width
				$btnMoveAllViewsUp.Top = $btnMoveViewUp.Top
				$btnMoveAllViewsUp.Text = "↑↑"
				$btnMoveAllViewsUp.TextAlign = "MiddleCenter"
				$btnMoveAllViewsUp.Cursor = "Hand"
				$btnMoveAllViewsUp.ForeColor = "Black"
				$btnMoveAllViewsUp.BackColor = "WhiteSmoke"
				$btnMoveAllViewsUp.Visible = $false
				$btnMoveAllViewsUp.Anchor = "Top,Right"
				$btnMoveAllViewsUp.Add_Click({
				
						[array]$arrItemsToMoveUp = $lbxRepositoryViews.Items

						ForEach ($objItemToMoveUp in $arrItemsToMoveUp)
							{
								MoveViewsToFromLayout "ADD" $objItemToMoveUp
							}

						$lbxRepositoryViews.ClearSelected()
						$lbxLayoutViews.ClearSelected()
				
						Remove-Variable objItemToMoveUp -ErrorAction SilentlyContinue
						Remove-Variable arrItemsToMoveUp -ErrorAction SilentlyContinue
					})
				$pnlViews.Controls.Add($btnMoveAllViewsUp)
			}


		# Move selected Views Down
		If (!($btnMoveViewDown)) 
			{
				$script:btnMoveViewDown = New-Object Windows.Forms.Button
				$btnMoveViewDown.Width = $btnMoveAllViewsUp.Width
				$btnMoveViewDown.Left = $lbxLayoutViews.Left + ($lbxLayoutViews.Width / 2) + 5
				$btnMoveViewDown.Top = $btnMoveViewUp.Top
				$btnMoveViewDown.Text = "↓"
				$btnMoveViewDown.TextAlign = "MiddleCenter"
				$btnMoveViewDown.Cursor = "Hand"
				$btnMoveViewDown.ForeColor = "Black"
				$btnMoveViewDown.BackColor = "WhiteSmoke"
				$btnMoveViewDown.Visible = $false
				$btnMoveViewDown.Anchor = "Top,Right"
				$btnMoveViewDown.Add_Click({
				
						[array]$arrItemsToMoveDown = $lbxLayoutViews.SelectedItems

						ForEach ($objItemToMoveDown in $arrItemsToMoveDown)
							{
								MoveViewsToFromLayout "REMOVE" $objItemToMoveDown
							}
						
						$lbxRepositoryViews.ClearSelected()
						$lbxLayoutViews.ClearSelected()
				
						Remove-Variable objItemToMoveDown -ErrorAction SilentlyContinue
						Remove-Variable arrItemsToMoveDown -ErrorAction SilentlyContinue
					})
				$pnlViews.Controls.Add($btnMoveViewDown)
			}
	
		# Move all Views Down
		If (!($btnMoveAllViewsDown)) 
			{
				$script:btnMoveAllViewsDown = New-Object Windows.Forms.Button
				$btnMoveAllViewsDown.Width = $btnMoveViewUp.Width
				$btnMoveAllViewsDown.Left = $btnMoveViewDown.Right + 5
				$btnMoveAllViewsDown.Top = $btnMoveViewUp.Top
				$btnMoveAllViewsDown.Text = "↓↓"
				$btnMoveAllViewsDown.TextAlign = "MiddleCenter"
				$btnMoveAllViewsDown.Cursor = "Hand"
				$btnMoveAllViewsDown.ForeColor = "Black"
				$btnMoveAllViewsDown.BackColor = "WhiteSmoke"
				$btnMoveAllViewsDown.Visible = $false
				$btnMoveAllViewsDown.Anchor = "Top,Right"
				$btnMoveAllViewsDown.Add_Click({
				
						[array]$arrItemsToMoveDown = $lbxLayoutViews.Items

						ForEach ($objItemToMoveDown in $arrItemsToMoveDown)
							{
								#Write-Host "Move $objItemToMoveDown"
								MoveViewsToFromLayout "REMOVE" $objItemToMoveDown
							}

						$lbxRepositoryViews.ClearSelected()
						$lbxLayoutViews.ClearSelected()
				
						Remove-Variable objItemToMoveDown -ErrorAction SilentlyContinue
						Remove-Variable arrItemsToMoveDown -ErrorAction SilentlyContinue
					})
				$pnlViews.Controls.Add($btnMoveAllViewsDown)
			}

	}
	

Function ClearListBoxFilter ($strTarget, $strType)
	{
		Switch ($strTarget)
			{
				"Repository"
					{
						Switch ($strType)
							{
								"Model"
									{
										# Reset the filter box
										$txtFilterRepositoryModels.Text = $strDefaultFilterText
										$txtFilterRepositoryModels.ForeColor = "Gray"
										$txtFilterRepositoryModels.BackColor = "LightGray"
										
										# Clear the filter config
										$lbxRepositoryModels.Items.Clear()
										$arrCurrentListOfRepositoryModels | ForEach-Object {$lbxRepositoryModels.Items.Add($_)}
										Remove-Variable -Name arrCurrentListOfRepositoryModels -Scope Script -Force -ErrorAction SilentlyContinue

										# Resize the filter box to cover the reset button
										If ($txtFilterRepositoryModels.Right -lt $btnResetFilterRepositoryModels.Right) {$txtFilterRepositoryModels.Width = $txtFilterRepositoryModels.Width + $btnResetFilterRepositoryModels.Width + 2}
										
										$lblRepositoryModels.Text = $lblRepositoryModels.Text -replace " \(Filtered\)"

										# Reset the listbox controls
										$btnMoveAllModelsDown.Enabled = $true
										$btnMoveModelDown.Enabled = $true
										
										# Resync the boxes
										[array]$lbxLayoutModels.Items | ForEach-Object {$lbxRepositoryModels.Items.Remove($_)}
									}

								"ModelGroup"
									{
										# Reset the filter box
										$txtFilterRepositoryModelGroups.Text = $strDefaultFilterText
										$txtFilterRepositoryModelGroups.ForeColor = "Gray"
										$txtFilterRepositoryModelGroups.BackColor = "LightGray"
										
										# Clear the filter config
										$lbxRepositoryModelGroups.Items.Clear()
										$arrCurrentListOfRepositoryModelGroups | ForEach-Object {$lbxRepositoryModelGroups.Items.Add($_)}
										Remove-Variable -Name arrCurrentListOfRepositoryModelGroups -Scope Script -Force -ErrorAction SilentlyContinue

										# Resize the filter box to cover the reset button
										If ($txtFilterRepositoryModelGroups.Right -lt $btnResetFilterRepositoryModelGroups.Right) {$txtFilterRepositoryModelGroups.Width = $txtFilterRepositoryModelGroups.Width + $btnResetFilterRepositoryModelGroups.Width + 2}
										
										$lblRepositoryModelGroups.Text = $lblRepositoryModelGroups.Text -replace " \(Filtered\)"

										# Reset the listbox controls
										$btnMoveAllModelGroupsDown.Enabled = $true
										$btnMoveModelGroupDown.Enabled = $true
										
										# Resync the boxes
										[array]$lbxLayoutModelGroups.Items | ForEach-Object {$lbxRepositoryModelGroups.Items.Remove($_)}
									}

								"View"
									{
										# Reset the filter box
										$txtFilterRepositoryViews.Text = $strDefaultFilterText
										$txtFilterRepositoryViews.ForeColor = "Gray"
										$txtFilterRepositoryViews.BackColor = "LightGray"

										# Clear the filter config
										$lbxRepositoryViews.Items.Clear()
										$arrCurrentListOfRepositoryViews | ForEach-Object {$lbxRepositoryViews.Items.Add($_)}
										Remove-Variable -Name arrCurrentListOfRepositoryViews -Scope Script -Force -ErrorAction SilentlyContinue

										# Resize the filter box to cover the reset button
										If ($txtFilterRepositoryViews.Right -lt $btnResetFilterRepositoryViews.Right) {$txtFilterRepositoryViews.Width = $txtFilterRepositoryViews.Width + $btnResetFilterRepositoryViews.Width + 2}

										$lblRepositoryViews.Text = $lblRepositoryViews.Text -replace " \(Filtered\)"

										# Reset the listbox controls
										$btnMoveAllViewsDown.Enabled = $true
										$btnMoveViewDown.Enabled = $true

										# Resync the boxes
										[array]$lbxLayoutViews.Items | ForEach-Object {$lbxRepositoryViews.Items.Remove($_)}
									}

								default
									{
										LogWrite "WARNING" "Clear List Box Filter called with an invalid type ($strType)"
										Return
									}

							}
					}

				"Layout"
					{
						Switch ($strType)
							{
								"Model"
									{
										# Reset the filter box
										$txtFilterLayoutModels.Text = $strDefaultFilterText
										$txtFilterLayoutModels.ForeColor = "Gray"
										$txtFilterLayoutModels.BackColor = "LightGray"
										
										# Clear the filter config
										$lbxLayoutModels.Items.Clear()
										$arrCurrentListOfActiveModels | ForEach-Object {$lbxLayoutModels.Items.Add($_)}
										Remove-Variable -Name arrCurrentListOfActiveModels -Scope Script -ErrorAction SilentlyContinue
										
										# Resize the filter box to cover the reset button
										If ($txtFilterLayoutModels.Right -lt $btnResetFilterLayoutModels.Right) {$txtFilterLayoutModels.Width = $txtFilterLayoutModels.Width + $btnResetFilterLayoutModels.Width + 2}
							
										$lblLayoutModels.Text = $lblLayoutModels.Text -replace " \(Filtered\)"

										# Reset the listbox controls
										$btnMoveAllModelsUp.Enabled = $true
										$btnMoveModelUp.Enabled = $true
										
										# Resync the boxes
										[array]$lbxRepositoryModels.Items | ForEach-Object {$lbxLayoutModels.Items.Remove($_)}
									}

								"ModelGroup"
									{
										# Reset the filter box
										$txtFilterLayoutModelGroups.Text = $strDefaultFilterText
										$txtFilterLayoutModelGroups.ForeColor = "Gray"
										$txtFilterLayoutModelGroups.BackColor = "LightGray"
										
										# Clear the filter config
										$lbxLayoutModelGroups.Items.Clear()
										$arrCurrentListOfActiveModelGroups | ForEach-Object {$lbxLayoutModelGroups.Items.Add($_)}
										Remove-Variable -Name arrCurrentListOfActiveModelGroups -Scope Script -ErrorAction SilentlyContinue
										
										# Resize the filter box to cover the reset button
										If ($txtFilterLayoutModelGroups.Right -lt $btnResetFilterLayoutModelGroups.Right) {$txtFilterLayoutModelGroups.Width = $txtFilterLayoutModelGroups.Width + $btnResetFilterLayoutModelGroups.Width + 2}
										
										$lblLayoutModelGroups.Text = $lblLayoutModelGroups.Text -replace " \(Filtered\)"

										# Reset the listbox controls
										$btnMoveAllModelGroupsUp.Enabled = $true
										$btnMoveModelGroupUp.Enabled = $true
										
										# Resync the boxes
										[array]$lbxRepositoryModelGroups.Items | ForEach-Object {$lbxLayoutModelGroups.Items.Remove($_)}
									}

								"View"
									{
										# Reset the filter box
										$txtFilterLayoutViews.Text = $strDefaultFilterText
										$txtFilterLayoutViews.ForeColor = "Gray"
										$txtFilterLayoutViews.BackColor = "LightGray"

										# Clear the filter config
										$lbxLayoutViews.Items.Clear()
										$arrCurrentListOfActiveViews | ForEach-Object {$lbxLayoutViews.Items.Add($_)}
										Remove-Variable -Name arrCurrentListOfActiveViews -Scope Script -ErrorAction SilentlyContinue

										# Resize the filter box to cover the reset button
										If ($txtFilterLayoutViews.Right -lt $btnResetFilterLayoutViews.Right) {$txtFilterLayoutViews.Width = $txtFilterLayoutViews.Width + $btnResetFilterLayoutViews.Width + 2}

										$lblLayoutViews.Text = $lblLayoutViews.Text -replace " \(Filtered\)"

										# Reset the listbox controls
										$btnMoveAllViewsUp.Enabled = $true
										$btnMoveViewUp.Enabled = $true

										# Resync the boxes
										[array]$lbxRepositoryViews.Items | ForEach-Object {$lbxLayoutViews.Items.Remove($_)}
									}

								default
									{
										LogWrite "WARNING" "Clear List Box Filter called with an invalid type ($strType)"
										Return
									}

							}
					}

				default 
					{
						LogWrite "WARNING" "Clear List Box Filter called with an invalid target ($strTarget)"
						Return
					}
			}


		# If all filter boxes are set to the default text, reenable the Save/Cancel Layout buttons
		If 
			(
				$txtFilterLayoutModels.Text -eq $strDefaultFilterText -and
				$txtFilterLayoutModelGroups.Text -eq $strDefaultFilterText -and
				$txtFilterLayoutViews.Text -eq $strDefaultFilterText -and
				$txtFilterRepositoryModels.Text -eq $strDefaultFilterText -and
				$txtFilterRepositoryModelGroups.Text -eq $strDefaultFilterText -and
				$txtFilterRepositoryViews.Text -eq $strDefaultFilterText
			)
				{
					$btnSaveLayout.Enabled = $true
					$btnCancelReloadLayout.Enabled = $true
					
					If ($boolLayoutModelsChanged -eq $true -or $boolLayoutModelGroupsChanged -eq $true -or $boolLayoutViewsChanged -eq $true)
						{
							$btnSaveLayout.Forecolor = "White"
							$btnSaveLayout.BackColor = "Green"
							$btnCancelReloadLayout.Forecolor = "White"
							$btnCancelReloadLayout.BackColor = "Red"
						}
				}
	}


	
Function ListModelDetails ($boolActiveInactiveBoth)
	{
		LogWrite "DEBUG" "List Model Details"
		
		LoadRGBEffects
		
		# List Active Models
		#$objxLightsEffects.xrgb.models.ChildNodes | Where-Object {$_.Active -eq 1} | Select Name | Sort Name

		# List Models with Node Count
		$objActiveModels = $objxLightsEffects.xrgb.models.ChildNodes | Sort-Object Name #| Where-Object {$_.Active -eq 1} 
		$script:intTotalNodesInUse = 0
		ForEach ($objChildNode in $objActiveModels)
			{
				$strModelName = $objChildNode.Name
				If ($objChildNode.Active -eq 0) {$strModelActive = $false} Else {$strModelActive = $true}
				If ($objChildNode.ControllerConnection.Brightness) {$strModelBrightness = $objChildNode.ControllerConnection.Brightness} Else {$strModelBrightness = 100}
				If ($objChildNode.PixelCount)
					{$intModelNodeCount = $objChildNode.PixelCount}
					ElseIf ($objChildNode.CustomModel)
						{
							$intModelNodeCount = $objChildNode.CustomModel -split {$_ -eq "," -or $_ -eq ";"} | Measure-Object -Maximum | Select-Object -ExpandProperty Maximum
						}
						Else
							{
								$intModelNodeCount = ([int]$objChildNode.parm1 * [int]$objChildNode.parm2)
							}
				
				$script:intTotalNodesInUse += $intModelNodeCount
				
				Write-Host "`nModel: $strModelName" -ForegroundColor $(If ($strModelActive) {"Green"} Else {"Red"})
				Write-Host "`t- Brightness: $strModelBrightness" -ForegroundColor $(If ($strModelBrightness -le 20) {"Cyan"} ElseIf ($strModelBrightness -le 30) {"Green"} ElseIf ($strModelBrightness -le 60) {"Yellow"} Else {"Red"})
				Write-Host "`t- Node Count: $intModelNodeCount"
				
				Remove-Variable strModelName
				Remove-Variable strModelActive
				Remove-Variable intModelNodeCount
				Remove-Variable strModelBrightness
			}

		Write-Host "`n`n"
		Write-Host "Total Active Models: " -NoNewline
		Write-Host $objActiveModels.Count -ForegroundColor Green
		Write-Host "Total Nodes In Use: " -NoNewline
		Write-Host "$intTotalNodesInUse" -ForegroundColor Green
		Write-Host "`n`n`n"
	}
	
	
Function ModifyPanels ($strTask, $strPanel)
	{
		LogWrite "DEBUG" "Modify Panel ""$strPanel"" / ""$strTask"""

		Switch ($strPanel)
			{
				"SyncFrom"
					{
						If ($strTask -eq "Enable")
							{
								$btnSyncFromxLights.Forecolor = "Blue"
								$btnSyncFromxLights.BackColor = "WhiteSmoke"
								$btnSyncFromxLights.Enabled = $true
								$rdoSyncAllResources.Enabled = $true
								$rdoSyncSelectedResources.Enabled = $true
								$rdoUpdateExistingResources.Enabled = $true
								$cbxExcludeCommonLayoutResources.Enabled = $true
								$cbxSyncToRepository.Enabled = $true
								$cbxPromptToCreateNewInCompanion.Enabled = $true
								$cbxPromptToOverwriteResources.Enabled = $true

								$btnSyncFromxLights.Text = If ($rdoSyncAllResources.Checked) {"Sync All From xLights"} ElseIf ($rdoUpdateExistingResources.Checked) {"Update Existing Resources"} Else {"Select Resources to Sync"}
								$lblSyncToLayout.Text = "... $(If ($rdoUpdateExistingResources.Checked -eq $true) {"in"} Else {"to"}) '$($lbxLayouts.SelectedItem)' Layout"

								$pnlSyncFrom.BackColor = "MintCream"
							}
							ElseIf ($strTask -eq "Disable")
								{
									$btnSyncFromxLights.Forecolor = "Black"
									$btnSyncFromxLights.BackColor = "WhiteSmoke"
									$btnSyncFromxLights.Enabled = $false
									$lblSyncToLayout.Text = ""
									$cbxSyncToRepository.Enabled = $true
									$rdoSyncAllResources.Enabled = $false
									$rdoSyncSelectedResources.Enabled = $false
									$rdoUpdateExistingResources.Enabled = $false
									$cbxExcludeCommonLayoutResources.Enabled = $false
									$cbxSyncToRepository.Checked = $false
									$cbxPromptToCreateNewInCompanion.Enabled = $false
									$cbxPromptToOverwriteResources.Enabled = $false

									$pnlSyncFrom.BackColor = "WhiteSmoke"
								}
								Else
									{
										LogWrite "DEBUG" "An invalid task was specified so ""$strPanel"" was not modified" "Yellow"
									}
					}

				"CommitToxLights"
					{
						If ($strTask -eq "Enable")
							{
								$btnCommitLayoutToxLights.Forecolor = "Black"
								$btnCommitLayoutToxLights.BackColor = "WhiteSmoke"
								$btnCommitLayoutToxLights.Enabled = $true

								$cbxAlsoLoadCommonLayout.Enabled = $true
								$cbxOverwriteExistingResources.Enabled = $true
								$cbxRemoveExtraResources.Enabled = $true
								$cbxMarkAllModelsActive.Enabled = $true
								
								$pnlCommitxLights.BackColor = "MintCream"
							}
							ElseIf ($strTask -eq "Disable")
								{
									$btnCommitLayoutToxLights.Forecolor = "Gray"
									$btnCommitLayoutToxLights.BackColor = "LightGray"
									$btnCommitLayoutToxLights.Enabled = $false

									$cbxAlsoLoadCommonLayout.Enabled = $false
									$cbxOverwriteExistingResources.Enabled = $false
									$cbxRemoveExtraResources.Enabled = $false
									$cbxMarkAllModelsActive.Enabled = $false
									
									$pnlCommitxLights.BackColor = "WhiteSmoke"
								}
								Else
									{
										LogWrite "DEBUG" "An invalid task was specified so ""$strPanel"" was not modified" "Yellow"
									}
					}

				"Layouts"
					{
						If ($strTask -eq "Enable")
							{
								$lblLayouts.ForeColor = "Blue"
								$lbxLayouts.Enabled = $true
								$btnAddLayout.Enabled = $true
								
								If ($null -ne $lbxLayouts.SelectedItem)
									{
										$btnRemoveLayout.Enabled = $true
										$btnDuplicateLayout.Enabled = $true
									}

								$pnlLayouts.BackColor = "Azure"
							}
							ElseIf ($strTask -eq "Disable")
								{
									$lblLayouts.ForeColor = "Gray"
									$lbxLayouts.Enabled = $false
									$btnAddLayout.Enabled = $false
									$btnRemoveLayout.Enabled = $false
									$btnDuplicateLayout.Enabled = $false

									$pnlLayouts.BackColor ="WhiteSmoke"
								}
								Else
									{
										LogWrite "DEBUG" "An invalid task was specified so ""$strPanel"" was not modified" "Yellow"
									}
					}

				"Models"
					{
						If ($strTask -eq "Enable")
							{
								$lblLayoutModels.ForeColor = "Blue"
								$txtFilterLayoutModels.Enabled = $true
								$lbxLayoutModels.Enabled = $true
								$btnMoveAllModelsUp.Enabled = $true
								$btnMoveModelUp.Enabled = $true
								$btnMoveModelDown.Enabled = $true
								$btnMoveAllModelsDown.Enabled = $true
								$lblRepositoryModels.ForeColor = "Green"
								$txtFilterRepositoryModels.Enabled = $true
								$lbxRepositoryModels.Enabled = $true

								# $cboCopyMoveModelsToLayoutList.SelectedItem = ""

								$pnlModels.BackColor = "Azure"
							}
							ElseIf ($strTask -eq "Disable")
								{
									$lblLayoutModels.ForeColor = "Gray"
									$txtFilterLayoutModels.Enabled = $false
									$lbxLayoutModels.Enabled = $false
									$btnMoveAllModelsUp.Enabled = $false
									$btnMoveModelUp.Enabled = $false
									$btnMoveModelDown.Enabled = $false
									$btnMoveAllModelsDown.Enabled = $false
									$lblRepositoryModels.ForeColor = "Gray"
									$txtFilterRepositoryModels.Enabled = $false
									$lbxRepositoryModels.Enabled = $false

									InitializeCopyMoveDelete -strPanel "Models" -strTask "Disable"

									# $grpCopyMoveModelsToLayout.Enabled = $false
									# $btnCopyModelsToLayout.Text = "Copy Model"
									# $btnCopyModelsToLayout.Forecolor = "Gray"
									# $btnCopyModelsToLayout.Backcolor = "LightGray"
									# $btnMoveModelsToLayout.Text = "Move Model"
									# $btnMoveModelsToLayout.Forecolor = "Gray"
									# $btnMoveModelsToLayout.Backcolor = "LightGray"
									# $btnDeleteModelsFromLayout.Enabled = $false
									# $btnDeleteModelsFromLayout.Text = "Delete Model From Layout"
									# $btnDeleteModelsFromLayout.Forecolor = "Gray"
									# $btnDeleteModelsFromLayout.Backcolor = "LightGray"

									$pnlModels.BackColor = "WhiteSmoke"
								}
								Else
									{
										LogWrite "DEBUG" "An invalid task was specified so ""$strPanel"" was not modified" "Yellow"
									}
					}

				"ModelGroups"
					{
						If ($strTask -eq "Enable")
							{
								$lblLayoutModelGroups.ForeColor = "Blue"
								$txtFilterLayoutModelGroups.Enabled = $true
								$lbxLayoutModelGroups.Enabled = $true
								$btnMoveAllModelGroupsUp.Enabled = $true
								$btnMoveModelGroupUp.Enabled = $true
								$btnMoveModelGroupDown.Enabled = $true
								$btnMoveAllModelGroupsDown.Enabled = $true
								$lblRepositoryModelGroups.ForeColor = "Green"
								$txtFilterRepositoryModelGroups.Enabled = $true
								$lbxRepositoryModelGroups.Enabled = $true

								# $cboCopyMoveModelGroupsToLayoutList.SelectedItem = ""

								$pnlModelGroups.BackColor = "Azure"
							}
							ElseIf ($strTask -eq "Disable")
								{
									$lblLayoutModelGroups.ForeColor = "Gray"
									$txtFilterLayoutModelGroups.Enabled = $false
									$lbxLayoutModelGroups.Enabled = $false
									$btnMoveAllModelGroupsUp.Enabled = $false
									$btnMoveModelGroupUp.Enabled = $false
									$btnMoveModelGroupDown.Enabled = $false
									$btnMoveAllModelGroupsDown.Enabled = $false
									$lblRepositoryModelGroups.ForeColor = "Gray"
									$txtFilterRepositoryModelGroups.Enabled = $false
									$lbxRepositoryModelGroups.Enabled = $false

									InitializeCopyMoveDelete -strPanel "ModelGroups" -strTask "Disable"
									
									$pnlModelGroups.BackColor = "WhiteSmoke"
								}
								Else
									{
										LogWrite "DEBUG" "An invalid task was specified so ""$strPanel"" was not modified" "Yellow"
									}
					}

				"Views"
					{
						If ($strTask -eq "Enable")
							{
								$lblLayoutViews.ForeColor = "Blue"
								$txtFilterLayoutViews.Enabled = $true
								$lbxLayoutViews.Enabled = $true
								$btnMoveAllViewsUp.Enabled = $true
								$btnMoveViewUp.Enabled = $true
								$btnMoveViewDown.Enabled = $true
								$btnMoveAllViewsDown.Enabled = $true
								$lblRepositoryViews.ForeColor = "Green"
								$txtFilterRepositoryViews.Enabled = $true
								$lbxRepositoryViews.Enabled = $true

								# $cboCopyMoveViewToLayoutList.SelectedItem = ""

								$pnlViews.BackColor = "Azure"
							}
							ElseIf ($strTask -eq "Disable")
								{
									$lblLayoutViews.ForeColor = "Gray"
									$txtFilterLayoutViews.Enabled = $false
									$lbxLayoutViews.Enabled = $false
									$btnMoveAllViewsUp.Enabled = $false
									$btnMoveViewUp.Enabled = $false
									$btnMoveViewDown.Enabled = $false
									$btnMoveAllViewsDown.Enabled = $false
									$lblRepositoryViews.ForeColor = "Gray"
									$txtFilterRepositoryViews.Enabled = $false
									$lbxRepositoryViews.Enabled = $false

									InitializeCopyMoveDelete -strPanel "Views" -strTask "Disable"
									
									$pnlViews.BackColor = "WhiteSmoke"
								}
								Else
									{
										LogWrite "DEBUG" "An invalid task was specified so ""$strPanel"" was not modified" "Yellow"
									}
					}
				
				default
					{
						LogWrite "DEBUG" "An invalid layout was specified so no layouts were modified" "Yellow"
					}
			}
	}




# Load the RBG Effects file into memory
Function LoadRGBEffects
	{
		LogWrite "VERBOSE" "Load RGBEffects File"
		
		BackupxLightsFiles
	
		# Read the RGBEffects File into Memory
		[xml]$script:objxLightsEffects = Get-Content -raw $strxlightsRGBEffectsFilePath

	}


Function BackupxLightsFiles
	{
		LogWrite "INFO" "Backing up the xLights Files"
	
		# Define the backup path and file name
		$strxLightsBackupRootFolder = "$PSScriptRoot\Backups\xLights"
		$strxLightsCurrentBackupFolder = "$strxLightsBackupRootFolder\$((Get-Date).ToString('yyyy_MM_dd_HH_mm'))"
		$strxLightsRGBEffectsFileBackupPath = "$strxLightsCurrentBackupFolder\$((Get-Item $strxlightsRGBEffectsFilePath).Name)" -replace ".xml",$strFileBackupSuffix

		# Create the folder if it doesn't exist
		If (!(Test-Path $strxLightsCurrentBackupFolder)) {New-Item -Path $strxLightsCurrentBackupFolder -ItemType Directory -Force | Out-Null}
		
		# Copy the file
		Copy-Item -Path $strxlightsRGBEffectsFilePath -Destination $strxLightsRGBEffectsFileBackupPath -Force
			
		# Report the status of the backup
		If ((Get-FileHash $strxlightsRGBEffectsFilePath).Hash -eq (Get-FileHash $strxLightsRGBEffectsFileBackupPath).Hash)
			{
				LogWrite "INFO" "xLights_RGBEffects File Successfully backed up" "Green"
				LogWrite "VERBOSE" "Backed up to ""$strxLightsRGBEffectsFileBackupPath"""
			
				$objPreExistingBackups = $null
				$objPreExistingBackups = Get-ChildItem -Path $strxLightsBackupRootFolder -Directory | Sort-Object LastWriteTime

				If ($objPreExistingBackups.Count -gt $intNumberofxLightsRBGEffectsBackupsToKeep)
					{
						LogWrite "DEBUG" "`The Number of xLights backups ($($objPreExistingBackups.Count)) is greater than the number to keep ($intNumberofxLightsRBGEffectsBackupsToKeep) so perform cleanup...." "Yellow"
						
						$objBackupsToDelete = $objPreExistingBackups | Select-Object -First $($objPreExistingBackups.Count - $intNumberofxLightsRBGEffectsBackupsToKeep)
						ForEach ($objBackupToDelete in $objBackupsToDelete)
							{
								LogWrite "DEBUG" "Removing $($objBackupToDelete.FullName)...." "Magenta"
								Remove-Item -Path $objBackupToDelete.FullName -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
							}
					}
					Else
						{
							LogWrite "DEBUG" "The Number of local backups ($($objPreExistingBackups.Count)) is less than or equal to the number to keep ($intNumberofxLightsRBGEffectsBackupsToKeep) so no cleanup is necessary...." "Green"
						}
			}
			Else {LogWrite "WARNING" "xLights_RGBEffects File was NOT successfully backed up"}
	}



Function CreateLoadxLightsCompanionXML
	{
		LogWrite "VERBOSE" "Loading the xLights Companion XML File"

		$script:strxLightsCompanionXML = "$strxLightsCompanionXMLPath\xLightsCompanion.xml"

		If (!(Test-Path $script:strxLightsCompanionXML))
			{
				LogWrite "DEBUG" "Creating xLightsCompanion.xml at ""$strxLightsCompanionXML"""

				New-Item -Path $strxLightsCompanionXML -ItemType File | Out-Null

				# Build the file structure
				'<?xml version="1.0" encoding="UTF-8"?>' | Out-File $strxLightsCompanionXML
				'<!DOCTYPE html>' | Out-File $strxLightsCompanionXML -Append
				"<xlc>" | Out-File $strxLightsCompanionXML -Append
				"`t<layouts>" | Out-File $strxLightsCompanionXML -Append
				"`t</layouts>" | Out-File $strxLightsCompanionXML -Append
				"</xlc>" | Out-File $strxLightsCompanionXML -Append

			}
			Else
				{
					BackupxLightsCompanionFiles
				}

		[xml]$script:objxLightsCompanionXML = Get-Content -raw $strxLightsCompanionXML

		# If the layouts are currently empty, populate them
		If (($objxLightsCompanionXML.xlc.layouts.layout).Count -eq 0)
			{
				# Prepopulate the layouts with US Holidays
				AddLayout -strLayoutName "- Repository (Recovery) -"
				AddLayout -strLayoutName "- Common -"
				AddLayout -strLayoutName "Christmas"
				AddLayout -strLayoutName "Easter"
				AddLayout -strLayoutName "Halloween"
				AddLayout -strLayoutName "Independence Day"
				AddLayout -strLayoutName "Memorial Day"
				AddLayout -strLayoutName "Thanksgiving"
				AddLayout -strLayoutName "Valentines Day"
				AddLayout -strLayoutName "Veterans Day"

				# Save the file and reset the button
				$objxLightsCompanionXML.Save($strxLightsCompanionXML)
				$script:boolxLightsCompanionXMLIsChanged = $false

				$btnSaveToFile.Enabled = $false
				$btnSaveToFile.Visible = $false
				$btnSaveToFile.Forecolor = "Gray"
				$btnSaveToFile.BackColor = "LightGray"
				
				$btnFormSubmit.Enabled = $true
				$btnFormSubmit.Text = "Close"
				$btnFormSubmit.Forecolor = "Black"
				$btnFormSubmit.BackColor = "WhiteSmoke"	
								
			}

		
		# Check to see if the count of models, model groups, and views are the same between RGB Effects and Companion.  
		# If not, trigger a sync.  If so, loop through to see if a sync is required


		# Removed as there is no need to check the Repository list against xLights every time
		# # Load the data and check for updates to the models
		# LoadRepositoryResourcesFromCompanionXML -strNodeType "Model" -boolLoadListBoxes $false -boolCheckForUpdates $true
		# LoadRepositoryResourcesFromCompanionXML -strNodeType "ModelGroup" -boolLoadListBoxes $false -boolCheckForUpdates $true
		# LoadRepositoryResourcesFromCompanionXML -strNodeType "View" -boolLoadListBoxes $false -boolCheckForUpdates $true


		# # Check to see if any models already exist in the repository.  If not, this is probably the first run of Companion so a sync needs to be performed.
		# If ($objxlightscompanionxml.xlc.layouts.layout[0].Models.model.Count -lt 1)
		# 	{
		# 		# There are no models available in the Repository Models layout XML so a sync is required
		# 		LogWrite "INFO" "No Repository Models are available so a sync from xLights is required"

		# 		# Disable all of the content panels
		# 		ModifyPanels "Disable" "Layouts"
		# 		ModifyPanels "Disable" "Models" 
		# 		ModifyPanels "Disable" "ModelGroups" 
		# 		ModifyPanels "Disable" "Views" 

		# 		# Highlight the Sync button
		# 		$btnSyncFromxLights.Forecolor = "White"
		# 		$btnSyncFromxLights.BackColor = "Green"
		# 		$btnSyncFromxLights.Enabled = $true
		# 		$cbxSyncToRepository.Checked = $true
		# 		$cbxPromptToOverwriteResources.Enabled = $true
		# 		$cbxPromptToCreateNewInCompanion.Enabled = $true
				
		# 	}
		# 	Else
		# 		{
					# Load the list boxes
					LoadLayoutsFromCompanionXML
					LoadRepositoryResourcesFromCompanionXML -strNodeType "Model" -boolLoadListBoxes $true -boolCheckForUpdates $false
					LoadRepositoryResourcesFromCompanionXML -strNodeType "ModelGroup" -boolLoadListBoxes $true -boolCheckForUpdates $false
					LoadRepositoryResourcesFromCompanionXML -strNodeType "View" -boolLoadListBoxes $true -boolCheckForUpdates $false

					# Enable the Layouts panel
					ModifyPanels "Enable" "Layouts" 

					# Disable the content panels
					ModifyPanels "Disable" "Models" 
					ModifyPanels "Disable" "ModelGroups" 
					ModifyPanels "Disable" "Views" 

					# # Disable the Sync From Panel
					ModifyPanels "Disable" "SyncFrom"

					$btnSyncFromxLights.Text = "No Sync Required"
	# 			}

	}
	

	
Function BackupxLightsCompanionFiles
	{
		LogWrite "INFO" "Back up the xLights Companion Files"
	
		# Define the backup path and file name
		$strxLightsCompanionBackupRootFolder = "$PSScriptRoot\Backups\xLightsCompanion"
		$strxLightsCompanionCurrentBackupFolder = "$strxLightsCompanionBackupRootFolder\$((Get-Date).ToString('yyyy_MM_dd_HH_mm'))"
		$strxLightsCompanionXMLFileBackupPath = "$strxLightsCompanionCurrentBackupFolder\$((Get-Item $strxLightsCompanionXML).Name)" -replace ".xml",$strFileBackupSuffix

		# Create the folder if it doesn't exist
		If (!(Test-Path $strxLightsCompanionCurrentBackupFolder)) {New-Item -Path $strxLightsCompanionCurrentBackupFolder -ItemType Directory -Force | Out-Null}
		
		# Copy the file
		Copy-Item -Path $strxLightsCompanionXML -Destination $strxLightsCompanionXMLFileBackupPath -Force
			
		# Report the status of the backup
		If ((Get-FileHash $strxLightsCompanionXML).Hash -eq (Get-FileHash $strxLightsCompanionXMLFileBackupPath).Hash)
			{
				LogWrite "INFO" "xLights Companion File Successfully backed up" "Green"
				LOGWRITE "VERBOSE" "Backed up to ""$strxLightsCompanionXMLFileBackupPath"""
			
				$objPreExistingBackups = $null
				$objPreExistingBackups = Get-ChildItem -Path $strxLightsCompanionBackupRootFolder -Directory | Sort-Object LastWriteTime

				If ($objPreExistingBackups.Count -gt $intNumberofxLightsCompanionBackupsToKeep)
					{
						LogWrite "DEBUG" "`The Number of xLights Companion backups ($($objPreExistingBackups.Count)) is greater than the number to keep ($intNumberofxLightsCompanionBackupsToKeep) so perform cleanup...." "Yellow"
						
						$objBackupsToDelete = $objPreExistingBackups | Select-Object -First $($objPreExistingBackups.Count - $intNumberofxLightsCompanionBackupsToKeep)
						ForEach ($objBackupToDelete in $objBackupsToDelete)
							{
								LogWrite "DEBUG" "Removing $($objBackupToDelete.FullName)...." "Magenta"
								Remove-Item -Path $objBackupToDelete.FullName -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
							}
					}
					Else
						{
							LogWrite "DEBUG" "The Number of local backups ($($objPreExistingBackups.Count)) is less than or equal to the number to keep ($intNumberofxLightsCompanionBackupsToKeep) so no cleanup is necessary...." "Green"
						}
			}
			Else {LogWrite "WARNING" "xLights Companion File was NOT successfully backed up"}
	}



# Call this function to indicate whether xLights Companion has pending updates that require ($true/$false) a save.
Function xLightsCompanionUpdates ($boolCompanionXMLUpdated)
	{
		If ($boolCompanionXMLUpdated -eq $true)
			{
				LogWrite "VERBOSE" "Updates have been made to xLights Companion XML so setting the Save Required flag"

				$script:boolxLightsCompanionXMLIsChanged = $true

				$btnSaveToFile.Enabled = $true
				$btnSaveToFile.Visible = $true
				$btnSaveToFile.Forecolor = "White"
				$btnSaveToFile.BackColor = "Green"
				
				$btnFormSubmit.Enabled = $true
				$btnFormSubmit.Text = "Cancel"
				$btnFormSubmit.Forecolor = "White"
				$btnFormSubmit.BackColor = "Red"
					
			}
	}


Function SaveLayout
	{
		LogWrite "VERBOSE" "Saving Layout Changes for ""$($lbxLayouts.SelectedItem)"""

		# Save the layout resources
		UpdateLayoutResource -strTargetLayout $lbxLayouts.SelectedItem -strNodeType "Model"
		UpdateLayoutResource -strTargetLayout $lbxLayouts.SelectedItem -strNodeType "ModelGroup"
		UpdateLayoutResource -strTargetLayout $lbxLayouts.SelectedItem -strNodeType "View"

		ModifyPanels "Enable" "Layouts"
		# $lbxLayouts.Enabled = $true
		# $btnAddLayout.Enabled = $true
		
		If ($boolxLightsCompanionXMLIsChanged) 
			{
				$btnSaveToFile.Enabled = $true
				$btnSaveToFile.Visible = $true
				$btnSaveToFile.Forecolor = "White"
				$btnSaveToFile.BackColor = "Green"
				
				$btnFormSubmit.Enabled = $true
				$btnFormSubmit.Text = "Cancel"
				$btnFormSubmit.Forecolor = "White"
				$btnFormSubmit.BackColor = "Red"
			}
			Else
				{
					$btnSaveToFile.Enabled = $false
					$btnSaveToFile.Visible = $false
					$btnSaveToFile.Forecolor = "Gray"
					$btnSaveToFile.BackColor = "LightGray"
					
					$btnFormSubmit.Enabled = $true
					$btnFormSubmit.Text = "Close"
					$btnFormSubmit.Forecolor = "Black"
					$btnFormSubmit.BackColor = "WhiteSmoke"	
				}

		$btnSaveLayout.Visible = $false
		$btnCancelReloadLayout.Visible = $false
		
		$script:boolLayoutModelsChanged = $false
		$script:boolLayoutModelGroupsChanged = $false
		$script:boolLayoutViewsChanged = $false

		ModifyPanels "Enable" "SyncFrom"
		$btnSyncFromxLights.Enabled = $true
		$cbxSyncToRepository.Enabled = $true
		ModifyPanels "Enable" "CommitToxLights"

		# Set the global Change Made flag
		xLightsCompanionUpdates $true
	}


Function SaveCompanionXML
	{
		LogWrite "INFO" "Saving changes to xLights Companion XML......"

		$intSaveAttempts = 0
		While ($boolxLightsCompanionXMLIsChanged -ne $false -and $intSaveAttempts -lt 5)
			{
				Try 
					{
						$intSaveAttempts++

						$objxLightsCompanionXML.Save($strxLightsCompanionXML)
						
						$script:boolxLightsCompanionXMLIsChanged = $false
						
						$btnSaveToFile.Enabled = $false
						$btnSaveToFile.Visible = $false
						$btnSaveToFile.Forecolor = "Gray"
						$btnSaveToFile.BackColor = "LightGray"
						
						$btnFormSubmit.Enabled = $true
						$btnFormSubmit.Text = "Close"
						$btnFormSubmit.Forecolor = "Black"
						$btnFormSubmit.BackColor = "WhiteSmoke"	
				
						
						LogWrite "INFO" "Changes have been saved." "Green"
						Return $true
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
				Return $false
			}
	}


Function SyncxLightsToLayout ($strLayoutName, $strNodeType, $arrNodeNames, $boolOnlySyncExisting, $boolExcludeCommonLayoutResources, $boolOverridePrompts)
	{
		LogWrite "INFO" "Sync $strNodeType(s) from xLights to Companion ($strLayoutName) $(If ($boolOverridePrompts -eq $true) {"without"} Else {"with"}) Override Prompts"

		# If the specified layout exists, continue.  If not, exit.
		If (($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.name -eq $strLayoutName}).Count -ne 1)
			{
				LogWrite "WARNING" "Sync xLights to Layout was called with an invalid layout ($strLayoutName)"
				Return
			}

		$intNodesSynced = 0

		# Check for a valid node type
		Switch ($strNodeType)
			{
				"Model"
					{
						# If a list of names wasn't passed, get all names from xLights
						If (!($arrNodeNames)) {$arrNodeNames = $objxLightsEffects.xrgb.models.model.name}

						# If the Exclude Common switch is true, get a list of Common Models
						If ($boolExcludeCommonLayoutResources -eq $true) 
							{
								LogWrite "Verbose" "Models assignd to '- Common -' have been excluded" "Magenta"
								[array]$arrModelsInCommonLayout = ($objxLightsCompanionXML.xlc.layouts.Layout | Where-Object {$_.Name -eq "- Common -"}).models.Model.Name
							}

						# If Only Update Existing is true, get a list of names from the list box
						If ($boolOnlySyncExisting -eq $true) {[array]$arrCurrentListOfModels = $lbxLayoutModels.Items}

						ForEach ($strNodeName in $arrNodeNames)
							{
								If ($boolExcludeCommonLayoutResources -eq $true -and $strNodeName -in $arrModelsInCommonLayout) 
									{
										LogWrite "Verbose" """$strNodeName"" is assigned to '- Common -' so skipping sync."
										Continue
									}
									Else
										{
											# If the Only Update Existing flag is set, check to see if the current model already exists
											If ($boolOnlySyncExisting -eq $true)
												{
													If ($strNodeName -in $arrCurrentListOfModels)
														{
															# Current model exists so flag to copy
															$boolCopyNode = $true
														}
														Else
															{
																# Current model does not exist so flag to skip copy
																LogWrite "Debug" "$strNodeName does not currently exist in $strLayoutName so it will be skipped"
																$boolCopyNode = $false
															}
												}
												Else
													{
														# Only Update Existing is false so default to flag to copy
														$boolCopyNode = $true
													}

											# If the flag to copy is true, attempt to copy the node
											If ($boolCopyNode -eq $true)
												{
													LogWrite "VERBOSE" "Copying ""$strNodeName"""
								
													$intNodesCopied = CopyXMLNode -strSource "xLights" -strTarget "Companion" -strTargetLayoutName $strLayoutName -strNodeType $strNodeType -strNodeName $strNodeName -boolOverridePrompts $boolOverridePrompts

													If ($intNodesCopied -eq 1)
														{
															$intNodesSynced++

															$script:boolLayoutModelsChanged = $true
														}
														
													Remove-Variable intNodesCopied -ErrorAction SilentlyContinue
												}
										}
								
							}
					}

				"ModelGroup"
					{
						# If a list of names wasn't passed, get all names from xLights
						If (!($arrNodeNames)) {$arrNodeNames = $objxLightsEffects.xrgb.modelGroups.modelGroup.name}

						# If the Exclude Common checkbox was checked, get a list of Common Model Groups
						If ($boolExcludeCommonLayoutResources -eq $true) 
							{
								LogWrite "Verbose" "Model Groups assignd to '- Common -' have been excluded" "Magenta"
								[array]$arrModelGroupsInCommonLayout = ($objxLightsCompanionXML.xlc.layouts.Layout | Where-Object {$_.Name -eq "- Common -"}).modelGroups.ModelGroup.Name
							}

						# If Only Update Existing is true, get a list of names from the list box
						If ($boolOnlySyncExisting -eq $true) {[array]$arrCurrentListOfModelGroups = $lbxLayoutModelGroups.Items}

						ForEach ($strNodeName in $arrNodeNames)
							{
								If ($boolExcludeCommonLayoutResources -eq $true -and $strNodeName -in $arrModelGroupsInCommonLayout) 
									{
										LogWrite "Verbose" """$strNodeName"" is assigned to '- Common -' so skipping sync."
										Continue
									}
									Else
										{
											# If the Only Update Existing flag is set, check to see if the current model group already exists
											If ($boolOnlySyncExisting -eq $true)
												{
													If ($strNodeName -in $arrCurrentListOfModelGroups)
														{
															# Current model exists so flag to copy
															$boolCopyNode = $true
														}
														Else
															{
																# Current model does not exist so flag to skip copy
																LogWrite "Debug" "$strNodeName does not currently exist in $strLayoutName so it will be skipped"
																$boolCopyNode = $false
															}
												}
												Else
													{
														# Only Update Existing is false so default to flag to copy
														$boolCopyNode = $true
													}

											# If the flag to copy is true, attempt to copy the node
											If ($boolCopyNode -eq $true)
												{
													LogWrite "VERBOSE" "Copying ""$strNodeName"""
						
													$intNodesCopied = CopyXMLNode -strSource "xLights" -strTarget "Companion" -strTargetLayoutName $strLayoutName -strNodeType $strNodeType -strNodeName $strNodeName -boolOverridePrompts $boolOverridePrompts

													If ($intNodesCopied -eq 1)
														{
															$intNodesSynced++

															$script:boolLayoutModelGroupsChanged = $true
														}

													Remove-Variable intNodesCopied -ErrorAction SilentlyContinue
												}
										}
							}
					}

				"View"
					{
						# If a list of names wasn't passed, get all names from xLights
						If (!($arrNodeNames)) {$arrNodeNames = $objxLightsEffects.xrgb.views.view.name}

						# If the Exclude Common checkbox was checked, get a list of Common Views
						If ($boolExcludeCommonLayoutResources -eq $true) 
							{
								LogWrite "Verbose" "Views assignd to '- Common -' have been excluded" "Magenta"
								[array]$arrViewsInCommonLayout = ($objxLightsCompanionXML.xlc.layouts.Layout | Where-Object {$_.Name -eq "- Common -"}).views.View.Name
							}

						# If Only Update Existing is true, get a list of names from the list box
						If ($boolOnlySyncExisting -eq $true) {[array]$arrCurrentListOfViews = $lbxLayoutViews.Items}

						ForEach ($strNodeName in $arrNodeNames)
							{
								If ($boolExcludeCommonLayoutResources -eq $true -and $strNodeName -in $arrViewsInCommonLayout) 
									{
										LogWrite "Verbose" """$strNodeName"" is assigned to '- Common -' so skipping sync."
										Continue
									}
									Else
										{
											# If the Only Update Existing flag is set, check to see if the current view already exists
											If ($boolOnlySyncExisting -eq $true)
												{
													If ($strNodeName -in $arrCurrentListOfViews)
														{
															# Current model exists so flag to copy
															$boolCopyNode = $true
														}
														Else
															{
																# Current model does not exist so flag to skip copy
																LogWrite "Debug" "$strNodeName does not currently exist in $strLayoutName so it will be skipped"
																$boolCopyNode = $false
															}
												}
												Else
													{
														# Only Update Existing is false so default to flag to copy
														$boolCopyNode = $true
													}

											# If the flag to copy is true, attempt to copy the node
											If ($boolCopyNode -eq $true)
												{
													LogWrite "VERBOSE" "Copying ""$strNodeName"""
						
													$intNodesCopied = CopyXMLNode -strSource "xLights" -strTarget "Companion" -strTargetLayoutName $strLayoutName -strNodeType $strNodeType -strNodeName $strNodeName -boolOverridePrompts $boolOverridePrompts

													If ($intNodesCopied -eq 1)
														{
															$intNodesSynced++

															$script:boolLayoutViewsChanged = $true
														}
														
													Remove-Variable intNodesCopied -ErrorAction SilentlyContinue
												}
										}
							}
					}
				
				default
					{
						LogWrite "WARNING" "Sync xLights to Layout was called with an invalid node type ($strNodeType)"
						Return
					}
			}

		# If updates were made, trigger the LayoutUpdatesPending
		If ($intNodesSynced -ge 1) {LayoutUpdatesPending $true}

		LogWrite "VERBOSE" "Synced $intNodesSynced $strNodeType(s) to $strLayoutName" "Green"
	}
	



Function CompareXMLNodes ($strSource, $strTarget, $strSourceLayoutName, $strTargetLayoutName, $strNodeType, $strNodeName)
	{
		LogWrite "DEBUG" "Comparing ""$strNodeName"" between $strSource and $strTarget"

		Remove-Variable boolNodesMatch -ErrorAction SilentlyContinue

		# Get an array of all layouts from Companion
		$arrListOfLayouts = $objxLightsCompanionXML.xlc.layouts.layout

		# Get the index of the layouts (then add 1, as the XML is a 1,2,3 Index)
		If ($strSource -eq "Companion") {$intIndexOfSourceLayout = [array]::IndexOf($arrListOfLayouts.Name, $strSourceLayoutName)}
		If ($strTarget -eq "Companion") {$intIndexOfTargetLayout = [array]::IndexOf($arrListOfLayouts.Name, $strTargetLayoutName)}

		# Set the source and target XML structures based on the parameters
		If ($strSource -eq "xLights" -and $strTarget -eq "Companion")
			{
				$objSourceXML = $objxLightsEffects.xrgb
				$objTargetXML = $objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfTargetLayout]
			}
			ElseIf ($strSource -eq "Companion" -and $strTarget -eq "xLights")
				{
					$objSourceXML = $objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfSourceLayout]
					$objTargetXML = $objxLightsEffects.xrgb
				}
			ElseIf ($strSource -eq "Companion" -and $strTarget -eq "Companion")
				{
					$objSourceXML = $objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfSourceLayout]
					$objTargetXML = $objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfTargetLayout]
				}
				Else
					{
						LogWrite "WARNING" "Copy XML Node failed because Source ($strSource) and/or Target ($strTarget) are invalid."
						Return
					}

		# Update the XML structures with the node type
		Switch ($strNodeType)
			{
				"Model" 
					{
						$objSourceXML = $objSourceXML.models.model
						$objTargetXML = $objTargetXML.Models.Model
					}
				"ModelGroup" 
					{
						$objSourceXML = $objSourceXML.modelGroups.modelGroup
						$objTargetXML = $objTargetXML.ModelGroups.ModelGroup
					}
				"View" 
					{
						$objSourceXML = $objSourceXML.views.view
						$objTargetXML = $objTargetXML.Views.View
					}
				default
					{
						LogWrite "WARNING" "Compare XML Node failed because Node Type ($strNodeType) is invalid."
						Return	
					}
			}

		
		# Per attribute comparison - New
		$objSourceNode = ($objSourceXML | Where-Object {$_.name -eq $strNodeName})
		$objTargetNode = ($objTargetXML | Where-Object {$_.name -eq $strNodeName})

		# If the source and target nodes returned a value, continue.  Otherwise, return false
		If ($objSourceNode.Count -ge 1 -and $objTargetNode.Count -ge 1)
			{
				# Get an array of property name
				[array]$arrSourceNodeAttributeNames = $objSourceNode.Attributes | Select-Object Name
				[array]$arrTargetNodeAttributeNames = $objTargetNode.Attributes | Select-Object Name

				# If the list of names matches, go through the attributes of the source and target and compare them
				If ((($arrSourceNodeAttributeNames | Sort-Object Name).Name -join ",") -eq (($arrTargetNodeAttributeNames | Sort-Object Name).Name -join ","))
					{
						# Go through the list of attributes in the source and compare them to the attributes in the target
						ForEach ($strSourceNodeAttributeName in $arrSourceNodeAttributeNames.Name)
							{
								LogWrite "DEBUG" "Comparing ""$strSourceNodeAttributeName"" from $strSource to $strTarget"

								If (!($objSourceNode.GetAttribute($strSourceNodeAttributeName) -eq ($objTargetNode.GetAttribute($strSourceNodeAttributeName))))
									{
										LogWrite "DEBUG" "Mismatch on ""$strSourceNodeAttributeName"" betwween ""$($objSourceNode.GetAttribute($strSourceNodeAttributeName))"" and ""$($objTargetNode.GetAttribute($strSourceNodeAttributeName))""" "Red"

										$boolCompareXMLNodes = $false
									}
							}

						# If the source attributes didn't fail, go through the list of attributes in the target and compare them to the attributes in the source
						If ($boolCompareXMLNodes -ne $false)
							{
								ForEach ($strTargetNodeAttributeName in $arrTargetNodeAttributeNames.Name)
									{
										LogWrite "DEBUG" "Comparing ""$strTargetNodeAttributeName"" from $strSource to $strTarget"
						
										If (!($objTargetNode.GetAttribute($strTargetNodeAttributeName)) -eq ($objSourceNode.GetAttribute($strTargetNodeAttributeName)))
											{
												LogWrite "DEBUG" "Mismatch on ""$strTargetNodeAttributeName"" betwween $($objSourceNode.GetAttribute($strTargetNodeAttributeName)) and $($objTargetNode.GetAttribute($strTargetNodeAttributeName))"
						
												$boolCompareXMLNodes = $false
											}
									}
							}

						# If no mismatch was found, the nodes match
						If ($boolCompareXMLNodes -ne $false)
							{
								$boolCompareXMLNodes = $true
							}
					}
					Else
						{
							LogWrite "DEBUG" "The list of attribute names doesn't match so the node doesn't match."
							$boolCompareXMLNodes = $false
						}
			}
			Else
				{
					LogWrite "DEBUG" "$strNodeName does not exist in $strSource and/or $strTarget so no comparison could be made"
					$boolCompareXMLNodes = $false
				}



		# # Old Way
		# $strSourceModelToCompare = ($objSourceXML | Where-Object {$_.name -eq $strNodeName}).OuterXML
		# $strTargetModelToCompare = ($objTargetXML | Where-Object {$_.name -eq $strNodeName}).OuterXML

		# If ($strSourceModelToCompare -eq $strTargetModelToCompare)
		# 	{
		# 		LogWrite "DEBUG" "Comparison completed with True"
		# 		$boolCompareXMLNodes = $true
		# 	}
		# 	Else
		# 		{
		# 			LogWrite "DEBUG" "Comparison completed with False"
		# 			$boolCompareXMLNodes = $false
		# 		}

		# Return the result
		Return $boolCompareXMLNodes

	}


Function AssignCompanionIDs
	{
		LogWrite "INFO" "Assigning xLights Companion IDs to xLights RGB Effects Elements without a current ID"

		# If it exists, clear the array
		If ($arrxLightsCompanionIDsInUse) {[array]$arrxLightsCompanionIDsInUse.Clear()}

		$intNewIDsAssigned = 0

		# Get the list of current xLightsCompanionIDs
		[array]$arrModelxLightsCompanionIDs = ($objxLightsEffects.xrgb.models.model | Where-Object {($_.xLightsCompanionID).length -gt 0}).xLightsCompanionID
		[array]$arrModelGroupxLightsCompanionIDs = ($objxLightsEffects.xrgb.modelGroups.modelGroup | Where-Object {($_.xLightsCompanionID).length -gt 0}).xLightsCompanionID
		[array]$arrViewxLightsCompanionIDs = ($objxLightsEffects.xrgb.views.view | Where-Object {($_.xLightsCompanionID).length -gt 0}).xLightsCompanionID

		# Check the lists of xLightsCompanionIDs for duplicates
		If ($arrModelxLightsCompanionIDs) {[array]$arrDuplicatedModelxLightsCompanionIDs = Get-Duplicates $arrModelxLightsCompanionIDs}
		If ($arrModelGroupxLightsCompanionIDs) {[array]$arrDuplicatedModelGroupxLightsCompanionIDs = Get-Duplicates $arrModelGroupxLightsCompanionIDs}
		If ($arrViewxLightsCompanionIDs) {[array]$arrDuplicatedViewxLightsCompanionIDs = Get-Duplicates $arrViewxLightsCompanionIDs}

		# For any duplicate models, call the Resolve Duplicate Form
		If ($arrDuplicatedModelxLightsCompanionIDs.Count -ge 1)
			{
				LogWrite "ERROR" "xLights contains $($arrDuplicatedModelxLightsCompanionIDs.Count) duplicated xLightsCompanion Model ID(s)"

				ForEach ($strDuplicateModelID in $arrDuplicatedModelxLightsCompanionIDs)
					{		
						LogWrite "WARNING" "Duplicated models: $(($objxLightsEffects.xrgb.models.model | Where-Object {$_.xLightsCompanionID -eq $strDuplicateModelID}).Name -join ", ")"
						ShowDuplicateIDForm -strNodeType "Model" -strNodeID $strDuplicateModelID
					}
			}

		# For any duplicate model groups, call the Resolve Duplicate Form
		If ($arrDuplicatedModelGroupxLightsCompanionIDs.Count -ge 1)
			{
				LogWrite "ERROR" "xLights contains $($arrDuplicatedModelGroupxLightsCompanionIDs.Count) duplicated xLightsCompanion Model Group ID(s)"

				ForEach ($strDuplicateModelGroupID in $arrDuplicatedModelGroupxLightsCompanionIDs)
					{		
						LogWrite "WARNING" "Duplicated model groups: $(($objxLightsEffects.xrgb.modelGroups.modelGroup | Where-Object {$_.xLightsCompanionID -eq $strDuplicateModelGroupID}).Name -join ", ")"
						ShowDuplicateIDForm -strNodeType "ModelGroup" -strNodeID $strDuplicateModelGroupID
					}
			}

		# For any duplicate views, call the Resolve Duplicate Form
		If ($arrDuplicatedViewxLightsCompanionIDs.Count -ge 1)
			{
				LogWrite "ERROR" "xLights contains $($arrDuplicatedViewxLightsCompanionIDs.Count) duplicated xLightsCompanion View ID(s)"

				ForEach ($strDuplicateViewID in $arrDuplicatedViewxLightsCompanionIDs)
					{		
						LogWrite "WARNING" "Duplicated views: $(($objxLightsEffects.xrgb.views.view | Where-Object {$_.xLightsCompanionID -eq $strDuplicateViewID}).Name -join ", ")"
						ShowDuplicateIDForm -strNodeType "View" -strNodeID $strDuplicateViewID
					}
			}

		# Build the lists of existing ID's
		$objxLightsEffects.xrgb.models.model | Where-Object {($_.xLightsCompanionID).length -gt 0}  | ForEach-Object {[array]$script:arrxLightsCompanionIDsInUse += $_.xLightsCompanionID}
		$objxLightsEffects.xrgb.modelGroups.modelGroup | Where-Object {($_.xLightsCompanionID).length -gt 0}  | ForEach-Object {[array]$script:arrxLightsCompanionIDsInUse += $_.xLightsCompanionID}
		$objxLightsEffects.xrgb.views.view | Where-Object {($_.xLightsCompanionID).length -gt 0}  | ForEach-Object {[array]$script:arrxLightsCompanionIDsInUse += $_.xLightsCompanionID}

		# Go through the models that don't yet have an xLightsCompanionID and ensure each model has a unique xLightsCompanionID
		$objxLightsEffects.xrgb.models.model  | Where-Object {!($_.xLightsCompanionID) -or ($_.xLightsCompanionID).length -eq 0} | ForEach-Object {
				
				If ($_.name)
					{
						# Get a random ID and loop until it doesn't exist in the array
						$strRandomID = "model-$(Get-Random)"
						While ($strRandomID -in $arrxLightsCompanionIDsInUse) {$strRandomID = "model-$(Get-Random)"}

						# Set the ID on the model
						$_.SetAttribute("xLightsCompanionID", "$strRandomID")

						$intNewIDsAssigned++

						Remove-Variable strRandomID -ErrorAction SilentlyContinue
					}
			}

		# Go through the model groups that don't yet have an xLightsCompanionID and ensure each model group has a unique xLightsCompanionID
		$objxLightsEffects.xrgb.modelgroups.modelgroup  | Where-Object {!($_.xLightsCompanionID) -or ($_.xLightsCompanionID).length -eq 0} | ForEach-Object {
		
			If ($_.name)
				{
					# Get a random ID and loop until it doesn't exist in the array
					$strRandomID = "modelgroup-$(Get-Random)"
					While ($strRandomID -in $arrxLightsCompanionIDsInUse) {$strRandomID = "modelgroup-$(Get-Random)"}

					# Set the ID on the model group
					$_.SetAttribute("xLightsCompanionID", "$strRandomID")

					$intNewIDsAssigned++

					Remove-Variable strRandomID -ErrorAction SilentlyContinue
				}
		}

		# Go through the views that don't yet have an xLightsCompanionID and ensure each view has a unique xLightsCompanionID
		$objxLightsEffects.xrgb.views.view  | Where-Object {!($_.xLightsCompanionID) -or ($_.xLightsCompanionID).length -eq 0} | ForEach-Object {
				
			If ($_.name)
				{
					# Get a random ID and loop until it doesn't exist in the array
					$strRandomID = "view-$(Get-Random)"
					While ($strRandomID -in $arrxLightsCompanionIDsInUse) {$strRandomID = "view-$(Get-Random)"}

					# Set the ID on the view
					$_.SetAttribute("xLightsCompanionID", "$strRandomID")

					$intNewIDsAssigned++

					Remove-Variable strRandomID -ErrorAction SilentlyContinue
				}
		}

		LogWrite "INFO" "$intNewIDsAssigned New xLights Companion IDs assigned"

		Return $intNewIDsAssigned

	}


Function AddLayout ($strLayoutName, $strLayoutToDuplicate, $boolOverridePrompts)
	{
		# If a layout with the name already exists in xLights Companion, exit.
		If (($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.name -eq $strLayoutName}).Count -ge 1)
			{
				LogWrite "WARNING" "A layout named ""$strLayoutName"" already exists in xLights Companion"
				Return
			}
			Else
				{
					# If a layout was specified to duplicate, do it.  If not, create a new layout from scratch.
					If ($null -ne $strLayoutToDuplicate)
						{
							LogWrite "VERBOSE" "Duplicating ""$strLayoutToDuplicate"" into new layout ""$strLayoutName"" in xLights Companion Layouts"

							# Intitialize the variable
							$intNewNodeCount = 0

							# Get an array of all layouts from Companion
							$arrListOfLayouts = $objxLightsCompanionXML.xlc.layouts.layout

							# Get the index of the layout (then add 1, as the XML is a 1,2,3 Index)
							$intIndexOfSourceLayout = [array]::IndexOf($arrListOfLayouts.Name, $strLayoutToDuplicate)

							# Set the source and target XML structures based on the parameters
							$objSourceXML = $objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfSourceLayout]

							# Get the XML node of the model to copy
							$objSourceNode = $objSourceXML | Where-Object {$_.name -eq $strLayoutToDuplicate}

							# Import the source node to duplicate							
							$objNodeToImport = $objxLightsCompanionXML.ImportNode($objSourceNode,$true)
							
							# Set the target path
							$objxLightsCompanionXMLTarget = $objxLightsCompanionXML.SelectSingleNode("//layouts")

							# Inject the imported node to the target path
							$objxLightsCompanionXMLTarget.AppendChild($objNodeToImport) | Out-Null

							# Update the name and description of the imported node to the new target name
							($objxLightsCompanionXML.xlc.layouts.layout[$($arrListOfLayouts.Count)]).Name = $strLayoutName
							($objxLightsCompanionXML.xlc.layouts.layout[$($arrListOfLayouts.Count)]).Description = ""

							# Check to see if the new layout was created
							$intNewNodeCount = (($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.name -eq $strLayoutName} | Measure-Object).Count -eq 1)

							# if the duplication succeeded, mark the Companion Updates = true
							If ($intNewNodeCount -eq 1)
								{
									LogWrite "VERBOSE" "Duplication Succeeded" "Green"
									
									# Set the flag to require a save
									xLightsCompanionUpdates $true
								}
								Else
									{
										LogWrite "WARNING" "Duplicating ""$strLayoutToDuplicate"" failed"
									}

							Remove-Variable strSourceXML -ErrorAction SilentlyContinue

						}
						Else
							{
								LogWrite "VERBOSE" "Creating new layout ""$strLayoutName"" in xLights Companion Layouts"

								# Connect to the Layouts Node and define the layout
								$objxLightsCompanionXMLLayouts = $objxLightsCompanionXML.SelectSingleNode('//layouts')
								$objNewLayout = $objxLightsCompanionXML.CreateElement("layout")

								# Define attributes to assign to the elements
								$objNewLayoutName = $objxLightsCompanionXML.CreateAttribute("Name")
								$objNewLayoutDescription = $objxLightsCompanionXML.CreateAttribute("Description")
								# $objNewLayoutModelGroups = $objxLightsCompanionXML.CreateAttribute("ModelGroups")
								# $objNewLayoutViews = $objxLightsCompanionXML.CreateAttribute("Views")
								$objNewLayoutFutureAttribute1 = $objxLightsCompanionXML.CreateAttribute("FutureAttribute1")
								$objNewLayoutFutureAttribute2 = $objxLightsCompanionXML.CreateAttribute("FutureAttribute2")
								$objNewLayoutFutureAttribute3 = $objxLightsCompanionXML.CreateAttribute("FutureAttribute3")
								$objNewLayoutFutureAttribute4 = $objxLightsCompanionXML.CreateAttribute("FutureAttribute4")
								$objNewLayoutFutureAttribute5 = $objxLightsCompanionXML.CreateAttribute("FutureAttribute5")
								
								# Define values for the new attributes
								$objNewLayoutName.Value = $strLayoutName
								$objNewLayoutDescription.Value = If ($strLayoutName -eq "- Repository (Recovery) -") {"THIS LAYOUT IS USED AS A RESOURCE REPOSITORY AND AS A RECOVERY LAYOUT.  DO NOT MODIFY"} ElseIf ($strLayoutName -eq "- Common -") {"This layout is used as a Common item repository and should not be modified."} Else {""}
								# $objNewLayoutModelGroups.Value = ""
								# $objNewLayoutViews.Value = ""
								$objNewLayoutFutureAttribute1.Value = ""
								$objNewLayoutFutureAttribute2.Value = ""
								$objNewLayoutFutureAttribute3.Value = ""
								$objNewLayoutFutureAttribute4.Value = ""
								$objNewLayoutFutureAttribute5.Value = ""

								# Append the attributes to the new layout element
								$objNewLayout.Attributes.Append($objNewLayoutName) | Out-Null
								$objNewLayout.Attributes.Append($objNewLayoutDescription) | Out-Null
								# $objNewLayout.Attributes.Append($objNewLayoutModelGroups) | Out-Null
								# $objNewLayout.Attributes.Append($objNewLayoutViews) | Out-Null
								$objNewLayout.Attributes.Append($objNewLayoutFutureAttribute1) | Out-Null
								$objNewLayout.Attributes.Append($objNewLayoutFutureAttribute2) | Out-Null
								$objNewLayout.Attributes.Append($objNewLayoutFutureAttribute3) | Out-Null
								$objNewLayout.Attributes.Append($objNewLayoutFutureAttribute4) | Out-Null
								$objNewLayout.Attributes.Append($objNewLayoutFutureAttribute5) | Out-Null
								
								# Append the new layout element to the Layouts node
								$objxLightsCompanionXMLLayouts.AppendChild($objNewLayout) | Out-Null

								# # Get an array of all layouts
								# $arrListOfLayouts = $objxLightsCompanionXML.xlc.layouts.layout

								# # Get the index of the new layout (then add 1, as the XML is a 1,2,3 Index)
								# $intIndexPlusOneOfNewLayout = [array]::IndexOf($arrListOfLayouts.Name, $strLayoutName) + 1
								
								# Connect to the new Layout node
								$objxLightsCompanionXMLNewLayout = $objxLightsCompanionXML.SelectSingleNode("//layouts/layout[@Name='$strLayoutName']")
								
								# Define the Models element and the values for the attributes, append the attribute, then append the element to the layout
								$objAddModelsXML = $objxLightsCompanionXML.CreateElement("Models")
								$objModelsDescription = $objxLightsCompanionXML.CreateAttribute("Description")
								$objModelsDescription.Value = "Models for $strLayoutName"
								$objAddModelsXML.Attributes.Append($objModelsDescription)
								$objxLightsCompanionXMLNewLayout.AppendChild($objAddModelsXML) | Out-Null
								
								# Define the Model Groups element and the values for the attributes, append the attribute, then append the element to the layout
								$objAddModelGroupsXML = $objxLightsCompanionXML.CreateElement("ModelGroups")
								$objModelGroupsDescription = $objxLightsCompanionXML.CreateAttribute("Description")
								$objModelGroupsDescription.Value = "Model Groups for $strLayoutName"
								$objAddModelGroupsXML.Attributes.Append($objModelGroupsDescription)
								$objxLightsCompanionXMLNewLayout.AppendChild($objAddModelGroupsXML) | Out-Null
								
								# Define the Views element and the values for the attributes, append the attribute, then append the element to the layout
								$objAddViewsXML = $objxLightsCompanionXML.CreateElement("Views")
								$objViewsDescription = $objxLightsCompanionXML.CreateAttribute("Description")
								$objViewsDescription.Value = "Views for $strLayoutName"
								$objAddViewsXML.Attributes.Append($objViewsDescription)
								$objxLightsCompanionXMLNewLayout.AppendChild($objAddViewsXML) | Out-Null

								# Check to ensure the new layout was added
								If (($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq $strLayoutName} | Measure-Object).Count -eq 1)
								{
									LogWrite "VERBOSE" "Layout creation succeeded"

									xLightsCompanionUpdates $true

									Return $true
								}
								Else
									{
										LogWrite "WARNING" "Layout creation failed"
										Return $false
									}
							}
				}
	}


Function RemoveLayout ($strLayoutName, $boolOverridePrompts)
	{
		LogWrite "INFO" "Attempting to remove ""$strLayoutName"" from xLights Companion"

		# If a layout with the name exists in xLights Companion, proceed.  If not, exit.
		If (($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.name -eq $strLayoutName}).Count -ge 1)
			{
				# Get the XML node of the model to remove
				$objSourceNode = $objxLightsCompanionXML.xlc.layouts.layout  | Where-Object {$_.name -eq $strLayoutName}

				LogWrite "VERBOSE" "Removing ""$($objSourceNode.Name)"" from xLights Companion"
				$objxLightsCompanionXML.xlc.layouts.RemoveChild($objSourceNode) | Out-Null

				# Verify the layout was removed
				If (($objxLightsCompanionXML.xlc.layouts | Where-Object {$_.name -eq $objSourceNode.Name} | Measure-Object).Count -eq 0)
					{
						LogWrite "VERBOSE" "Removal succeeded"

						xLightsCompanionUpdates $true

						Return $true
					}
					Else
						{
							LogWrite "WARNING" "Removal failed"
							Return $false
						}
			}
			Else
				{
					LogWrite "WARNING" "Layout ""$strLayoutName"" not found in xLights Companion"
					Return
				}
		
	}


Function LoadLayoutsFromCompanionXML
	{
		LogWrite "VERBOSE" "Load Layouts into List Box"

		$lbxLayouts.BeginUpdate()
			$lbxLayouts.Items.Clear()
		$lbxLayouts.EndUpdate()

		$lbxLayouts.BeginUpdate()
			ForEach ($objLayout in $objxLightsCompanionXML.xlc.layouts.ChildNodes) 
				{
					If ($objLayout.Name -ne '- Repository (Recovery) -')
						{$lbxLayouts.Items.Add($objLayout.Name)}
				}
		$lbxLayouts.EndUpdate()
	}




Function LoadRepositoryResourcesFromCompanionXML ($strNodeType, $boolLoadListboxes, $boolCheckForUpdates)
	{
		LogWrite "VERBOSE" "Load Repository $strNodeType(s) $(if ($boolLoadListboxes) {"into List Box "})$(If ($boolCheckForUpdates) {"with"} Else {"without"}) update check" 
		
		Switch ($strNodeType)
			{
				"Model"
					{
						$lbxRepositoryModels.BeginUpdate()
							$lbxRepositoryModels.Items.Clear()
						$lbxRepositoryModels.EndUpdate()

						[array]$arrRepositoryLayoutResources = ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq "- Repository (Recovery) -"}).models.ChildNodes
						
						# If the Repository Repository resources array has a length and the first entry is not blank, add each array item to the list box.
						If ($arrRepositoryLayoutResources.Length -and $arrRepositoryLayoutResources[0] -ne "")
							{
								# Load the list box
								$lbxRepositoryModels.BeginUpdate()

									# For each of the Repository Repository resources.......
									$arrRepositoryLayoutResources | ForEach-Object {
										
										# If the model doesn't already exist in the Repository resources List Box.......
										If ($_.Name -notin $lbxRepositoryModels.Items)
											{
												# If not $false, add the resource to the list box
												If ($boolLoadListboxes -ne $false) {$lbxRepositoryModels.Items.Add($_.Name)}

												# # If specified, check the resource against xLights to see if it's different - This needs to be rewritten/double checked as a lot has changed
												# If ($boolCheckForUpdates -ne $false)
												# 	{
												# 		# If an updated resource hasn't already been found and Check for updates has been specified, run the the update check
												# 		If ($boolUpdatedModelsExistInImport -ne $true -and $boolModelSyncFromxLightsComplete -ne $true)
												# 			{
												# 				# If the model has been updated in xLights, set the flag
												# 				If ((ComparexLightsToCompanion "Model" $_.Name) -eq $false)
												# 					{
												# 						LogWrite "VERBOSE" "A model ($($_.Name)) in xLights Companion (Repository Layout) has been updated in xLights"

												# 						$script:boolUpdatedModelsExistInImport = $true

												# 						Return
												# 					}
												# 			}
												# 	}
											}
										}

								$lbxRepositoryModels.EndUpdate()
								
								# Go through the list of resources in the selected layout and remove them from the list of Repository resources
								$lbxLayoutModels.Items | ForEach-Object {$lbxRepositoryModels.Items.Remove($_)}

								# # Go through the list of resources in the -Common- layout and remove them from the list of Repository resources - Disabled at this time
								# ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.name -eq "- Common -"}).models.model.name -split "," | ForEach-Object {$lbxRepositoryModels.Items.Remove($_)}

								$lbxRepositoryModels.Enabled = $true
							}
						
					}

				"ModelGroup"
					{
						$lbxRepositoryModelGroups.BeginUpdate()
							$lbxRepositoryModelGroups.Items.Clear()
						$lbxRepositoryModelGroups.EndUpdate()

						[array]$arrRepositoryLayoutResources = ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq "- Repository (Recovery) -"}).modelGroups.ChildNodes
						
						# If the Repository Repository resources array has a length and the first entry is not blank, add each array item to the list box.
						If ($arrRepositoryLayoutResources.Length -and $arrRepositoryLayoutResources[0] -ne "")
							{
								# Load the list box
								$lbxRepositoryModelGroups.BeginUpdate()

									# For each of the Repository Repository resources.......
									$arrRepositoryLayoutResources | ForEach-Object {
										
										# If the model doesn't already exist in the Repository resources List Box.......
										If ($_.Name -notin $lbxRepositoryModelGroups.Items)
											{
												# If not $false, add the resource to the list box
												If ($boolLoadListboxes -ne $false) {$lbxRepositoryModelGroups.Items.Add($_.Name)}

												# # If specified, check the resource against xLights to see if it's different - This needs to be rewritten/double checked as a lot has changed
												# If ($boolCheckForUpdates -ne $false)
												# 	{
												# 		# If an updated resource hasn't already been found and Check for updates has been specified, run the the update check
												# 		If ($boolUpdatedModelGroupsExistInImport -ne $true -and $boolModelGroupSyncFromxLightsComplete -ne $true)
												# 			{
												# 				# If the resouce has been updated in xLights, set the flag
												# 				If ((ComparexLightsToCompanion "ModelGroup" $_.Name) -eq $false)
												# 					{
												# 						LogWrite "VERBOSE" "A model group ($($_.Name)) in xLights Companion (Repository Layout) has been updated in xLights"

												# 						$script:boolUpdatedModelGroupsExistInImport = $true

												# 						Return
												# 					}
												# 			}
												# 	}
											}
										}

								$lbxRepositoryModelGroups.EndUpdate()
								
								# Go through the list of resources in the selected layout and remove them from the list of Repository resources
								$lbxLayoutModelGroups.Items | ForEach-Object {$lbxRepositoryModelGroups.Items.Remove($_)}

								# # Go through the list of resources in the -Common- layout and remove them from the list of Repository resources
								# ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.name -eq "- Common -"}).modelGroups.modelGroup.name -split "," | ForEach-Object {$lbxRepositoryModelGroups.Items.Remove($_)}

								$lbxRepositoryModelGroups.Enabled = $true
							}
					}

				"View"
					{
						$lbxRepositoryViews.BeginUpdate()
							$lbxRepositoryViews.Items.Clear()
						$lbxRepositoryViews.EndUpdate()

						[array]$arrRepositoryLayoutResources = ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq "- Repository (Recovery) -"}).views.ChildNodes
						
						# If the Repository Repository resources array has a length and the first entry is not blank, add each array item to the list box.
						If ($arrRepositoryLayoutResources.Length -and $arrRepositoryLayoutResources[0] -ne "")
							{
								# Load the list box
								$lbxRepositoryViews.BeginUpdate()

									# For each of the Repository Repository resources.......
									$arrRepositoryLayoutResources | ForEach-Object {
										
										# If the model doesn't already exist in the Repository resources List Box.......
										If ($_.Name -notin $lbxRepositoryViews.Items)
											{
												# If not $false, add the resource to the list box
												If ($boolLoadListboxes -ne $false) {$lbxRepositoryViews.Items.Add($_.Name)}

												# # If specified, check the resource against xLights to see if it's different - This needs to be rewritten/double checked as a lot has changed
												# If ($boolCheckForUpdates -ne $false)
												# 	{
												# 		# If an updated resource hasn't already been found and Check for updates has been specified, run the the update check
												# 		If ($boolUpdatedViewsExistInImport -ne $true -and $boolViewSyncFromxLightsComplete -ne $true)
												# 			{
												# 				# If the resource has been updated in xLights, set the flag
												# 				If ((ComparexLightsToCompanion "View" $_.Name) -eq $false)
												# 					{
												# 						LogWrite "VERBOSE" "A view ($($_.Name)) in xLights Companion (Repository Layout) has been updated in xLights"

												# 						$script:boolUpdatedViewsExistInImport = $true

												# 						Return
												# 					}
												# 			}
												# 	}
											}
										}

								$lbxRepositoryViews.EndUpdate()
								
								# Go through the list of resources in the selected layout and remove them from the list of Repository resources
								$lbxLayoutViews.Items | ForEach-Object {$lbxRepositoryViews.Items.Remove($_)}

								# # Go through the list of resources in the -Common- layout and remove them from the list of Repository resources
								# ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.name -eq "- Common -"}).views.view.name -split "," | ForEach-Object {$lbxRepositoryViews.Items.Remove($_)}

								$lbxRepositoryViews.Enabled = $true
							}
					}
			}
						

	}



Function LoadLayoutResourcesFromCompanionXML ($strLayoutName, $strNodeType)
	{
		LogWrite "VERBOSE" "Load $strNodeType(s) for Layout ""$strLayoutName"" into List Box"

		Switch ($strNodeType)
			{
				"Model"
					{
						# Clear the list box
						$lbxLayoutModels.BeginUpdate()
							$lbxLayoutModels.Items.Clear()
						$lbxLayoutModels.EndUpdate()

						[array]$arrLayoutResourceNodes = ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq $strLayoutName}).models.ChildNodes
						[array]$arrLayoutResources = ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq $strLayoutName}).models.model.name -split ","

						If ($arrLayoutResourceNodes.Length -and $arrLayoutResourceNodes[0] -ne "")
							{	
								If ($arrLayoutResources[0] -ne "")
									{		
										# Load the list box
										$lbxLayoutModels.BeginUpdate()
											$arrLayoutResources | ForEach-Object {
													$lbxLayoutModels.Items.Add($_)
												}
										$lbxLayoutModels.EndUpdate()
									}
									Else
										{
											LogWrite "VERBOSE" "No $strNodeType(s) are assigned to ""$strLayoutName"""
										}
							}
						
						# Reset the Copy/Move/Delete functions
						

						# # Go through the list of models in the layout and remove them from the list of Repository models
						# $lbxLayoutModels.Items | ForEach-Object {$lbxRepositoryModels.Items.Remove($_)}
					}

				"ModelGroup"
					{
						# Clear the list box
						$lbxLayoutModelGroups.BeginUpdate()
							$lbxLayoutModelGroups.Items.Clear()
						$lbxLayoutModelGroups.EndUpdate()

						[array]$arrLayoutResourceNodes = ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq $strLayoutName}).modelGroups.ChildNodes
						[array]$arrLayoutResources = ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq $strLayoutName}).modelGroups.modelGroup.name -split ","

						If ($arrLayoutResourceNodes.Length -and $arrLayoutResourceNodes[0] -ne "")
							{	
								If ($arrLayoutResources[0] -ne "")
									{		
										# Load the list box
										$lbxLayoutModelGroups.BeginUpdate()
											$arrLayoutResources | ForEach-Object {
													$lbxLayoutModelGroups.Items.Add($_)
												}
										$lbxLayoutModelGroups.EndUpdate()
									}
									Else
										{
											LogWrite "VERBOSE" "No $strNodeType(s) are assigned to ""$strLayoutName"""
										}
							}

						# Go through the list of model groups in the layout and remove them from the list of Repository model groups
						$lbxLayoutModelGroups.Items | ForEach-Object {$lbxRepositoryModelGroups.Items.Remove($_)}
					}

				"View"
					{
						# Clear the list box
						$lbxLayoutViews.BeginUpdate()
							$lbxLayoutViews.Items.Clear()
						$lbxLayoutViews.EndUpdate()

						[array]$arrLayoutResourceNodes = ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq $strLayoutName}).views.ChildNodes
						[array]$arrLayoutResources = ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq $strLayoutName}).views.view.name -split ","

						If ($arrLayoutResourceNodes.Length -and $arrLayoutResourceNodes[0] -ne "")
							{	
								If ($arrLayoutResources[0] -ne "")
									{		
										# Load the list box
										$lbxLayoutViews.BeginUpdate()
											$arrLayoutResources | ForEach-Object {
													$lbxLayoutViews.Items.Add($_)
												}
										$lbxLayoutViews.EndUpdate()
									}
									Else
										{
											LogWrite "VERBOSE" "No $strNodeType(s) are assigned to ""$strLayoutName"""
										}
							}
						
							# Go through the list of views in the layout and remove them from the list of Repository views
							$lbxLayoutViews.Items | ForEach-Object {$lbxRepositoryViews.Items.Remove($_)}
					}
			}

		# Go through the list of models in the layout and remove them from the list of Repository models
		$lbxLayoutModels.Items | ForEach-Object {$lbxRepositoryModels.Items.Remove($_)}

	}



Function UpdateLayoutResource ($strTargetLayout, $strSourceLayout, $strNodeType)
	{
		LogWrite "VERBOSE" "Save the $strNodeType(s) for Layout $strTargetLayout"

		# If the Source Layout wasn't specified, assume the source is the Repository layout
		If (!($strSourceLayout)) {$strSourceLayout = "- Repository (Recovery) -"}

		Switch ($strNodeType)
			{
				"Model"
					{
						# Get the list of models in the Layout Models list box
						[array]$arrLayoutModelListToSave = $lbxLayoutModels.Items

						# Get a list of models already in the Layout Models XML
						[array]$arrModelsAlreadyInLayoutModels = ($objxLightsCompanionXML.SelectNodes("//layouts/layout[@Name='$strTargetLayout']/Models/model")).Name

						# Go through the list of models in the Layout Model list box.  If the model already exists in the Layout Models XML, skip it. If not, copy it over.
						ForEach ($strLayoutModelToSave in $arrLayoutModelListToSave)
							{
								If ($strLayoutModelToSave -notin $arrModelsAlreadyInLayoutModels)
									{
										# Get the XML for the current model
										$objModelToImport = ($objxLightsCompanionXML.SelectSingleNode("//layouts/layout[@Name='$strSourceLayout']/Models/model[@name='$strLayoutModelToSave']")).CloneNode($true)

										# Connect to the layout models node
										$objLayoutModelsXML = $objxLightsCompanionXML.SelectSingleNode("//layouts/layout[@Name='$strTargetLayout']/Models")

										# Import the source node into the target node
										$objLayoutModelsXML.AppendChild($objModelToImport) | Out-Null

										Remove-Variable objModelToImport -ErrorAction SilentlyContinue
										Remove-Variable objLayoutModelsXML -ErrorAction SilentlyContinue
									}
							}

						# Go through the list of models in the Layout Models XML.  If the model doesn't exist in the list box, remove it from the XML
						ForEach ($strModelInXML in $arrModelsAlreadyInLayoutModels)
							{
								If ($strModelInXML -notin $arrLayoutModelListToSave)
									{
										RemoveXMLNode -strTarget "Companion" -strLayoutName $strTargetLayout -strNodeType "Model" -strNodeName $strModelInXML -boolOverridePrompts $true
									}
							}
					}

				"ModelGroup"
					{
						# Get the list of model groups in the Layout Model Groups list box
						[array]$arrLayoutModelGroupListToSave = $lbxLayoutModelGroups.Items

						# Go through the list of model groups in the Layout Model Group list box.  If the model group already exists in the Layout Model Groups XML, skip it. If not, copy it over.
						ForEach ($strLayoutModelGroupToSave in $arrLayoutModelGroupListToSave)
							{
								# Get a list of model groups already in the Layout Model Groups XML
								[array]$arrModelGroupsAlreadyInLayoutModelGroups = ($objxLightsCompanionXML.SelectNodes("//layouts/layout[@Name='$strTargetLayout']/ModelGroups/modelGroup")).Name

								If ($strLayoutModelGroupToSave -notin $arrModelGroupsAlreadyInLayoutModelGroups)
									{
										# Get the XML for the current model group
										$objModelGroupToImport = ($objxLightsCompanionXML.SelectSingleNode("//layouts/layout[@Name='$strSourceLayout']/ModelGroups/modelGroup[@name='$strLayoutModelGroupToSave']")).CloneNode($true)

										# Connect to the layout model groups node
										$objLayoutModelGroupsXML = $objxLightsCompanionXML.SelectSingleNode("//layouts/layout[@Name='$strTargetLayout']/ModelGroups")

										# Import the source node into the target node
										$objLayoutModelGroupsXML.AppendChild($objModelGroupToImport) | Out-Null

										Remove-Variable objModelGroupToImport -ErrorAction SilentlyContinue
										Remove-Variable objLayoutModelGroupsXML -ErrorAction SilentlyContinue
									}
							}

						# Go through the list of model groups in the Layout Model Groups XML.  If the model group doesn't exist in the list box, remove it from the XML
						ForEach ($strModelGroupInXML in $arrModelGroupsAlreadyInLayoutModelGroups)
							{
								If ($strModelGroupInXML -notin $arrLayoutModelGroupListToSave)
									{
										RemoveXMLNode -strTarget "Companion" -strLayoutName $strTargetLayout -strNodeType "ModelGroup" -strNodeName $strModelGroupInXML -boolOverridePrompts $true
									}
							}
					}
				
				"View"
					{
						# Get the list of views in the Layout Views list box
						[array]$arrLayoutViewListToSave = $lbxLayoutViews.Items

						# Go through the list of views in the Layout View list box.  If the view already exists in the Layout Views XML, skip it. If not, copy it over.
						ForEach ($strLayoutViewToSave in $arrLayoutViewListToSave)
							{
								# Get a list of views already in the Layout Views XML
								[array]$arrViewsAlreadyInLayoutviews = ($objxLightsCompanionXML.SelectNodes("//layouts/layout[@Name='$strTargetLayout']/Views/view")).Name

								If ($strLayoutViewToSave -notin $arrviewsAlreadyInLayoutViews)
									{
										# Get the XML for the current view
										$objViewToImport = ($objxLightsCompanionXML.SelectSingleNode("//layouts/layout[@Name='$strSourceLayout']/Views/view[@name='$strLayoutViewToSave']")).CloneNode($true)

										# Connect to the layout views node
										$objLayoutViewsXML = $objxLightsCompanionXML.SelectSingleNode("//layouts/layout[@Name='$strTargetLayout']/Views")

										# Import the source node into the target node
										$objLayoutViewsXML.AppendChild($objViewToImport) | Out-Null

										Remove-Variable objViewToImport -ErrorAction SilentlyContinue
										Remove-Variable objLayoutViewsXML -ErrorAction SilentlyContinue
									}
							}

						# Go through the list of views in the Layout Views XML.  If the view doesn't exist in the list box, remove it from the XML
						ForEach ($strViewInXML in $arrViewsAlreadyInLayoutviews)
							{
								If ($strViewInXML -notin $arrLayoutViewListToSave)
									{
										RemoveXMLNode -strTarget "Companion" -strLayoutName $strTargetLayout -strNodeType "View" -strNodeName $strViewInXML -boolOverridePrompts $true
									}
							}
					}



			}


	}


Function CopyXMLNode ($strSource, $strTarget, $strSourceLayoutName, $strTargetLayoutName, $strNodeType, $strNodeName, $boolOverridePrompts, $boolOverwriteNode)
	{
		LogWrite "VERBOSE" "Attempting to copy $strNodeType ""$strNodeName"" from ""$(If ($strSource -ne "xLights") {$strSourceLayoutName} Else {"xLights"})"" to ""$(If ($strTarget -ne "xLights") {$strTargetLayoutName} Else {"xLights"})"""

		# Intitialize the variable
		$intNewNodeCount = 0

		# Get an array of all layouts from Companion
		$arrListOfLayouts = $objxLightsCompanionXML.xlc.layouts.layout

		# Get the index of the layouts (then add 1, as the XML is a 1,2,3 Index)
		If ($strSource -eq "Companion") {$intIndexOfSourceLayout = [array]::IndexOf($arrListOfLayouts.Name, $strSourceLayoutName)}
		If ($strTarget -eq "Companion") {$intIndexOfTargetLayout = [array]::IndexOf($arrListOfLayouts.Name, $strTargetLayoutName)}

		# Set the source and target XML structures based on the parameters
		If ($strSource -eq "xLights" -and $strTarget -eq "Companion")
			{
				$objSourceXML = $objxLightsEffects.xrgb
				$objTargetXML = $objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfTargetLayout]
			}
			ElseIf ($strSource -eq "Companion" -and $strTarget -eq "xLights")
				{
					$objSourceXML = $objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfSourceLayout]
					$objTargetXML = $objxLightsEffects.xrgb
				}
			ElseIf ($strSource -eq "Companion" -and $strTarget -eq "Companion")
				{
					$objSourceXML = $objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfSourceLayout]
					$objTargetXML = $objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfTargetLayout]
				}
				Else
					{
						LogWrite "WARNING" "Copy XML Node failed because Source ($strSource) and/or Target ($strTarget) are invalid."
						Return
					}

		# Update the XML structures with the node type
		Switch ($strNodeType)
			{
				"Model" 
					{
						$objSourceXML = $objSourceXML.models.model
						$objTargetXML = $objTargetXML.Models.Model
					}
				"ModelGroup" 
					{
						$objSourceXML = $objSourceXML.modelGroups.modelGroup
						$objTargetXML = $objTargetXML.ModelGroups.ModelGroup
					}
				"View" 
					{
						$objSourceXML = $objSourceXML.views.view
						$objTargetXML = $objTargetXML.Views.View
					}
				default
					{
						LogWrite "WARNING" "Copy XML Node failed because Node Type ($strNodeType) is invalid."
						Return	
					}
			}

		# If a node with the name exists in the source, proceed.  If not, exit.
		If (($objSourceXML | Where-Object {$_.name -eq $strNodeName}).Count -eq 1)
			{
				# If a node with the same name already exists in the target, check to see if the ID is the same.  If so, prompt to overwrite.  If not, if specified, prompt whether to create a new node.  If not specified, just copy it.
				If (($objTargetXML | Where-Object {$_.name -eq $strNodeName}).Count -ge 1)
					{
						LogWrite "VERBOSE" "$strNodeType already exists.  Checking xLightsCompanionID's..."

						# Named node already exists. Check the ID to see if it's the same node
						$strxLightsCompanionIDFromSource = ($objSourceXML | Where-Object {$_.name -eq $strNodeName}).xLightsCompanionID
						$strxLightsCompanionIDFromTarget = ($objTargetXML | Where-Object {$_.name -eq $strNodeName}).xLightsCompanionID
						
						# Compare the ID to see if it's the same node.  If so, compare the properties of the node and flag if it's been updated.
						If ($strxLightsCompanionIDFromSource -eq $strxLightsCompanionIDFromTarget)
							{
								LogWrite "VERBOSE" "xLightsCompanionID's ($strxLightsCompanionIDFromSource) match.  Comparing the source to the target to see if it's been updated."
								
								# The ID's match so compare the properties of the nodes to see if they're different
								If ((CompareXMLNodes -strSource $strSource -strTarget $strTarget -strSourceLayoutName $strSourceLayoutName -strTargetLayoutName $strTargetLayoutName -strNodeType $strNodeType -strNodeName $strNodeName) -eq $false)
									{
										# The nodes have different properties.  If not overridden, show the comparison window
										If ($boolOverridePrompts -ne $true)
											{
												# Show the Comparison window
												ShowComparisonForm -strNodeType $strNodeType -strNodeName $strNodeName -strSource $strSource -strTarget $strTarget -objSourceNodeXML ($objSourceXML | Where-Object {$_.name -eq $strNodeName}) -objTargetNodeXML ($objTargetXML | Where-Object {$_.name -eq $strNodeName}) -boolOverridePrompts $boolOverridePrompts

												# If keeping the Source version, set the overwrite variable to Yes
												If ($strVersionToKeep -eq $strSource)
													{
														LogWrite "VERBOSE" "The source version will be kept.  Removing the target version"
														$boolOverwriteNode = "Yes"
														$strNodeNameToRemove = $strNodeName
													}
													Else
														{
															LogWrite "VERBOSE" "The target version will be kept so copying is not required."
															$boolCopyNode = $false
														}

												# # Add Code to use the return from the Show Comparison to set the Overwrite variable
												# $boolOverwriteNode = [System.Windows.Forms.MessageBox]::Show("A $strNodeType named ""$strNodeName"" already exists in $strTarget but the $strSource $strNodeType is different.  `n`nThis is likely due to the $strNodeType being updated in xLights and not sync'd to Companion.  `n`nWould you like to replace the $strTarget version?","$strNodeType Already Exists" , "YesNo", "Exclamation")
												
												# If ($boolOverwriteNode -eq "Yes") 
												# 	{$strNodeNameToRemove = $strNodeName}
											}
											Else
												{
													LogWrite "VERBOSE" "The source does not match the target and overwrite has been specified.  Removing the target node to allow the source to be copied."
													$boolOverwriteNode = "Yes"
													$strNodeNameToRemove = $strNodeName
												}
									}
									Else
										{
											LogWrite "VERBOSE" "The source matches the target so copying is not required."
											$boolCopyNode = $false
										}
						
								
							}
							Else
								{
									# The named node already exists on both sides but the xLightsCompanionID of the node is different between RGB Effects and Companion XML.  This is likely because the node was renamed to a name previously in use or because xLights regenerated the XML and a new xLightsCompanionID was assigned
									LogWrite "VERBOSE" "xLightsCompanionID of source ($strxLightsCompanionIDFromSource) does not match target ($strxLightsCompanionIDFromTarget).  Show the Comparison windows."
									$boolCopyNode = $false

									# Show the Comparison window
									ShowComparisonForm -strNodeType $strNodeType -strNodeName $strNodeName -strSource $strSource -strTarget $strTarget -objSourceNodeXML ($objSourceXML | Where-Object {$_.name -eq $strNodeName}) -objTargetNodeXML ($objTargetXML | Where-Object {$_.name -eq $strNodeName}) -boolOverridePrompts $boolOverridePrompts

									# If keeping the Source version, set the overwrite variable to Yes
									If ($strVersionToKeep -eq $strSource)
										{
											LogWrite "VERBOSE" "The source version will be kept.  Removing the target version"
											$boolOverwriteNode = "Yes"
											$strNodeNameToRemove = $strNodeName
										}
										Else
											{
												LogWrite "VERBOSE" "The target version will be kept so copying is not required."
												$boolCopyNode = $false
											}
								}
					}
					ElseIf (($objSourceXML | Where-Object {$_.name -eq $strNodeName}).xLightsCompanionID -in ($objTargetXML | Select-Object xLightsCompanionID).xLightsCompanionID)
						{
							LogWrite "VERBOSE" "A node with the same xLightsCompanionID already exists"

							$strMatchingCompanionID = ($objSourceXML | Where-Object {$_.name -eq $strNodeName}).xLightsCompanionID
							$strNodeNameFromTarget = ($objTargetXML | Where-Object {$_.xLightsCompanionID -eq $strMatchingCompanionID}).Name

							# Differently named nodes have the same ID.  The node was probably renamed in xLights.  Prompt the user to overwrite the target node or open the Comparison window.
							$boolRenameExistingNode = [System.Windows.Forms.MessageBox]::Show("$strNodeType ""$strNodeName"" does not exist in $strTarget but ""$strNodeNameFromTarget"" does exist and has the same ID.  This is likely due to the $strNodeType being renamed in $strSource and not sync'd to $strTarget.  `n`nClick Yes to Replace the $strTarget version `nClick No to open the Comparison Window","Replace $strNodeType?" , "YesNo", "Exclamation")
							
							If ($boolRenameExistingNode -eq "Yes") 
								{
									$boolOverwriteNode = "Yes"
									$strNodeNameToRemove = $strNodeNameFromTarget
								}
								Else
									{
										# Show the Comparison window
										ShowComparisonForm -strNodeType $strNodeType -strNodeName $strNodeName -strSource $strSource -strTarget $strTarget -objSourceNodeXML ($objSourceXML | Where-Object {$_.name -eq $strNodeName}) -objTargetNodeXML ($objTargetXML | Where-Object {$_.name -eq $strNodeNameFromTarget}) -boolOverridePrompts $boolOverridePrompts

										# If keeping the Source version, set the overwrite variable to Yes
										If ($strVersionToKeep -eq $strSource)
											{
												LogWrite "VERBOSE" "The source version will be kept.  Removing the target version"
												$boolOverwriteNode = "Yes"
												$strNodeNameToRemove = $strNodeNameFromTarget
											}
											Else
												{
													LogWrite "VERBOSE" "The target version will be kept so copying is not required."
													$boolCopyNode = $false
												}
									}
						}
						Else
							{
								LogWrite "VERBOSE" "The node does not already exist so set CopyNode to true and OverwriteNode to false"
								$boolCopyNode = $true
								$boolOverwriteNode = $false
							}
					# Else # The model does not already exist in the Target.  This should no longer be required with the xLightsCompanionID added but I want to double check
					# 	{
					# 		If ($strTarget -eq "Companion" -and $cbxPromptToCreateNewInCompanion.Checked)
					# 			{
					# 				LogWrite "VERBOSE" "$strNodeType ""$strNodeName"" does not exist in $strTarget.  Prompt to see if it's a new $strNodeType or a replacement for an existing $strNodeType"

					# 				$boolReplacementModel = [System.Windows.Forms.MessageBox]::Show("A $strNodeType named ""$strNodeName"" does not exist in $strTarget.  `n`n`tClick Yes to copy the $strNodeType to $strTarget? `n`tClick No if this is a new name for an existing $strNodeType", "$strNodeType Does Not Exist" , "YesNo", "Exclamation")

					# 				# If this is a replacement node, prompt for which node it is replacing
					# 				If ($boolReplacementModel -eq "No")
					# 					{
					# 						LogWrite "VERBOSE" "Prompt for the replacement $strNodeType"
					# 						Start-Sleep 3

					# 						# Add code here later to prompt for the old model name and find/replace it in the XML

					# 						# Set the flag to require a save
					# 						xLightsCompanionUpdates $true

					# 						Return
					# 					}
					# 			}
								
					#	}

				# Check to see if overwrite is authorized. If so, remove the existing node.
				If ($boolOverwriteNode -eq "Yes")
					{
						LogWrite "INFO" "Removing ""$strNodeNameToRemove"" from $strTarget and replacing with the latest version"

						$boolProcessRemove = RemoveXMLNode -strTarget $strTarget -strLayoutName $strTargetLayoutName -strNodeType $strNodeType -strNodeName $strNodeNameToRemove -boolOverridePrompts $true

						# Switch ($strNodeType)
						# 	{
						# 		"Model"	{$boolProcessRemove = RemoveXMLNode -strTarget $strTarget -strLayoutName $strLayoutName -strNodeType "Model" -strNodeName $strNodeName -boolOverridePrompts $true } 
						# 		"ModelGroup" {$boolProcessRemove = RemoveXMLNode -strTarget $strTarget -strLayoutName $strLayoutName -strNodeType "ModelGroup" -strNodeName $strNodeName -boolOverridePrompts $true} 
						# 		"View" {$boolProcessRemove = RemoveXMLNode -strTarget $strTarget -strLayoutName $strLayoutName -strNodeType "View" -strNodeName $strNodeName -boolOverridePrompts $true} 
						# 		default	{$boolProcessRemove = $false}
						# 	}

						# If ($strTarget -eq "xLights")
						# 	{
						# 		Switch ($strNodeType)
						# 			{
						# 				"Model" {$boolProcessRemove = RemoveXMLNode -strTarget "xLights" -strNodeType "Model" -strNodeName $strNodeName -boolOverridePrompts $true} #RemoveModelFromxLights $strModelName}
						# 				"ModelGroup" {$boolProcessRemove = RemoveXMLNode -strTarget "xLights" -strNodeType "ModelGroup" -strNodeName $strNodeName -boolOverridePrompts $true} #RemoveModelGroupFromxLights $strModelName}
						# 				"View" {$boolProcessRemove = RemoveXMLNode -strTarget "xLights" -strNodeType "View" -strNodeName $strNodeName -boolOverridePrompts $true} #RemoveViewFromxLights $strModelName}
						# 				default	{$boolProcessRemove = $false}
						# 			}
						# 	}
						# 	Else
						# 		{
						# 			Switch ($strNodeType)
						# 				{
						# 					"Model"	{$boolProcessRemove = RemoveXMLNode -strTarget "Companion" -strLayoutName $strLayoutName -strNodeType "Model" -strNodeName $strNodeName -boolOverridePrompts $true } #RemoveModelFromxLightsCompanion $strModelName}
						# 					"ModelGroup" {$boolProcessRemove = RemoveXMLNode -strTarget "Companion" -strLayoutName $strLayoutName -strNodeType "ModelGroup" -strNodeName $strNodeName -boolOverridePrompts $true} #RemoveModelGroupFromxLightsCompanion $strModelName}
						# 					"View" {$boolProcessRemove = RemoveXMLNode -strTarget "Companion" -strLayoutName $strLayoutName -strNodeType "View" -strNodeName $strNodeName -boolOverridePrompts $true} #RemoveViewFromxLightsCompanion $strModelName}
						# 					default	{$boolProcessRemove = $false}
						# 				}
						# 		}
						
						If ($boolProcessRemove -ne $true)
							{
								LogWrite "WARNING" "Remove from $strTarget failed so overwrite is being aborted"
								$boolCopyNode = $false
							}
							Else
								{
									# The RemoveNode succeeded so set the CopyNode to true
									$boolCopyNode = $true
								}
					}



				# If the variable has been set to true, continue copying the node
				If ($boolCopyNode -eq $true)
					{
						# Get the XML node of the model to copy
						$objSourceNode = $objSourceXML | Where-Object {$_.name -eq $strNodeName}

						LogWrite "VERBOSE" "Copying ""$strNodeName"" to $strTarget"
						If ($strTarget -eq "xLights")
							{
								$objNodeToImport = $objxLightsEffects.ImportNode($objSourceNode,$true)
								
								Switch ($strNodeType)
									{
										"Model"	{$objxLightsXMLTarget = $objxLightsEffects.SelectSingleNode('//models')}
										"ModelGroup" {$objxLightsXMLTarget = $objxLightsEffects.SelectSingleNode('//modelGroups')}
										"View" {$objxLightsXMLTarget = $objxLightsEffects.SelectSingleNode('//views')}
										default	{}
									}
								
								$objxLightsXMLTarget.AppendChild($objNodeToImport) | Out-Null

								Switch ($strNodeType)
										{
											"Model"	{$intNewNodeCount = (($objxLightsEffects.xrgb.models.model | Where-Object {$_.name -eq $strNodeName} | Measure-Object).Count -eq 1)}
											"ModelGroup" {$intNewNodeCount = (($objxLightsEffects.xrgb.modelGroups.modelGroup | Where-Object {$_.name -eq $strNodeName} | Measure-Object).Count -eq 1)}
											"View" {$intNewNodeCount = (($objxLightsEffects.xrgb.views.view | Where-Object {$_.name -eq $strNodeName} | Measure-Object).Count -eq 1)}
											default	{}
										}
							}
							Else
								{
									$objNodeToImport = $objxLightsCompanionXML.ImportNode($objSourceNode,$true)
									
									# Get an array of all layouts
									$arrListOfLayouts = $objxLightsCompanionXML.xlc.layouts.layout

									# Get the index of the target layout (then add 1, as the XML is a 1,2,3 Index)
									$intIndexPlusOneOfNewLayout = [array]::IndexOf($arrListOfLayouts.Name, $strTargetLayoutName) + 1
							
									Switch ($strNodeType)
										{
											"Model"	{$objxLightsCompanionXMLTarget = $objxLightsCompanionXML.SelectSingleNode("//layout[$intIndexPlusOneOfNewLayout]/Models")}
											"ModelGroup" {$objxLightsCompanionXMLTarget = $objxLightsCompanionXML.SelectSingleNode("//layout[$intIndexPlusOneOfNewLayout]/ModelGroups")}
											"View" {$objxLightsCompanionXMLTarget = $objxLightsCompanionXML.SelectSingleNode("//layout[$intIndexPlusOneOfNewLayout]/Views")}
											default	{}
										}
									
									$objxLightsCompanionXMLTarget.AppendChild($objNodeToImport) | Out-Null

									Switch ($strNodeType)
										{
											"Model"	{$intNewNodeCount = (($objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfTargetLayout].Models.model | Where-Object {$_.name -eq $strNodeName} | Measure-Object).Count -eq 1)}
											"ModelGroup" {$intNewNodeCount = (($objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfTargetLayout].ModelGroups.modelGroup | Where-Object {$_.name -eq $strNodeName} | Measure-Object).Count -eq 1)}
											"View" {$intNewNodeCount = (($objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfTargetLayout].Views.view | Where-Object {$_.name -eq $strNodeName} | Measure-Object).Count -eq 1)}
											default	{}
										}
								}

						If ($intNewNodeCount -eq 1)
							{
								LogWrite "VERBOSE" "Copy succeeded" "Green"
								
								# If the target was Companion, check to see if the source was also Companion
								If ($strTarget -eq "Companion")
									{
										If ($strSource -eq "Companion")
											{
												# Both the source and target were Companion, which means a duplicate CompanionID now exists so generate a new ID

												Switch ($strNodeType)
													{
														"Model"	
															{
																# Build the lists of existing ID's
																$objxLightsEffects.xrgb.models.model | Where-Object {($_.xLightsCompanionID).length -gt 0}  | ForEach-Object {[array]$script:arrxLightsCompanionIDsInUse += $_.xLightsCompanionID}

																# Get a random ID and loop until it doesn't exist in the array
																$strRandomID = "model-$(Get-Random)"
																While ($strRandomID -in $arrxLightsCompanionIDsInUse) {$strRandomID = "model-$(Get-Random)"}

																# Assign the new ID to the node
																($objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfTargetLayout].Models.model | Where-Object {$_.name -eq $strNodeName}).xLightsCompanionID = $strRandomID
															}

														"ModelGroup" 
															{
																# Build the lists of existing ID's
																$objxLightsEffects.xrgb.modelGroups.modelGroup | Where-Object {($_.xLightsCompanionID).length -gt 0}  | ForEach-Object {[array]$script:arrxLightsCompanionIDsInUse += $_.xLightsCompanionID}

																# Get a random ID and loop until it doesn't exist in the array
																$strRandomID = "modelgroup-$(Get-Random)"
																While ($strRandomID -in $arrxLightsCompanionIDsInUse) {$strRandomID = "modelgroup-$(Get-Random)"}

																# Assign the new ID to the node
																($objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfTargetLayout].ModelGroups.modelGroup | Where-Object {$_.name -eq $strNodeName}).xLightsCompanionID = $strRandomID
															}

														"View" 
															{
																# Build the lists of existing ID's
																$objxLightsEffects.xrgb.views.view | Where-Object {($_.xLightsCompanionID).length -gt 0}  | ForEach-Object {[array]$script:arrxLightsCompanionIDsInUse += $_.xLightsCompanionID}

																# Get a random ID and loop until it doesn't exist in the array
																$strRandomID = "view-$(Get-Random)"
																While ($strRandomID -in $arrxLightsCompanionIDsInUse) {$strRandomID = "view-$(Get-Random)"}

																# Assign the new ID to the node
																($objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfTargetLayout].Views.view | Where-Object {$_.name -eq $strNodeName}).xLightsCompanionID = $strRandomID
															}
													}

												LogWrite "Verbose" "New Node $strNodeName assigned CompanionID of ""$strRandomID"""

											}
									}
							}
							Else
								{
									LogWrite "WARNING" "Copying $strNodeType ""$strNodeName"" failed"
								}
					}

			}
			Else
				{
					LogWrite "WARNING" "$strNodeType ""$strNodeName"" not found in $strSource"
					Return $false
				}

		Remove-Variable strSourceXML -ErrorAction SilentlyContinue
		Remove-Variable strTargetXML -ErrorAction SilentlyContinue

		Return $intNewNodeCount
	}



Function RemoveXMLNode ($strTarget, $strLayoutName, $strNodeType, $strNodeName, $boolOverridePrompts)
	{
		LogWrite "VERBOSE" "Attempting to remove $strNodeType ""$strNodeName"" from ""$strTarget"""

		# Get an array of all layouts from Companion
		$arrListOfLayouts = $objxLightsCompanionXML.xlc.layouts.layout

		# Get the index of the target layout (then add 1, as the XML is a 1,2,3 Index)
		$intIndexOfLayout = [array]::IndexOf($arrListOfLayouts.Name, $strLayoutName)

		# Set the target XML structure based on the parameter
		If ($strTarget -eq "xLights")
			{
				#$objTargetXML = $objxLightsEffects.xrgb
				Switch ($strNodeType)
					{
						"Model" 
							{
								$objTargetXML = $objxLightsEffects.xrgb.models.model
							}
						"ModelGroup" 
							{
								$objTargetXML = $objxLightsEffects.xrgb.modelGroups.modelGroup
							}
						"View" 
							{
								$objTargetXML = $objxLightsEffects.xrgb.views.view
							}
						default
							{
								LogWrite "WARNING" "Remove XML Node failed because Node Type ($strNodeType) is invalid."
								Return	
							}
					}
			}
			ElseIf ($strTarget -eq "Companion")
				{
				#	$objTargetXML = $objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfLayout]
					Switch ($strNodeType)
						{
							"Model" 
								{
									$objTargetXML = $objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfLayout].Models.model
								}
							"ModelGroup" 
								{
									$objTargetXML = $objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfLayout].ModelGroups.modelGroup
								}
							"View" 
								{
									$objTargetXML = $objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfLayout].Views.view
								}
							default
								{
									LogWrite "WARNING" "Remove XML Node failed because Node Type ($strNodeType) is invalid."
									Return	
								}
						}
				}
				Else
					{
						LogWrite "WARNING" "Remove XML Node failed because Target ($strTarget) is invalid."
						Return
					}

		# If a node with the name exists in the target, proceed.  If not, exit.
		If (($objTargetXML | Where-Object {$_.name -eq $strNodeName}).Count -eq 1)
			{
				# Get the XML node of the node to remove
				$objSourceNode = $objTargetXML | Where-Object {$_.name -eq $strNodeName}

				LogWrite "VERBOSE" "Removing ""$($objSourceNode.Name)"" from $strTarget"

				If ($strTarget -eq "xLights")
					{
						# Remove the node from the parent node specified by the parameter
						Switch ($strNodeType)
						{
							"Model"	{$objxLightsEffects.xrgb.models.RemoveChild($objSourceNode) | Out-Null}
							"ModelGroup" {$objxLightsEffects.xrgb.modelGroups.RemoveChild($objSourceNode) | Out-Null}
							"View" {$objxLightsEffects.xrgb.views.RemoveChild($objSourceNode) | Out-Null}
							default	{}
						}

						# Get a count of how many nodes remain with the name from the parameter (should be zero remaining)
						Switch ($strNodeType)
							{
								"Model"	{$intRemainingNodeCount = ($objxLightsEffects.xrgb.models.model | Where-Object {$_.name -eq $objSourceNode.Name} | Measure-Object).Count}
								"ModelGroup" {$intRemainingNodeCount = ($objxLightsEffects.xrgb.modelGroups.modelGroup | Where-Object {$_.name -eq $objSourceNode.Name} | Measure-Object).Count}
								"View" {$intRemainingNodeCount = ($objxLightsEffects.xrgb.views.view | Where-Object {$_.name -eq $objSourceNode.Name} | Measure-Object).Count}
								default	{}
							}
					}
					Else
						{
							# Remove the node from the parent node specified by the parameter
							
							Switch ($strNodeType)
								{
									"Model"	{$objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfLayout].Models.RemoveChild($objSourceNode) | Out-Null}
									"ModelGroup" {$objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfLayout].ModelGroups.RemoveChild($objSourceNode) | Out-Null}
									"View" {$objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfLayout].Views.RemoveChild($objSourceNode) | Out-Null}
									default	{}
								}

							# Get a count of how many nodes remain with the name from the parameter (should be zero remaining)
							Switch ($strNodeType)
								{
									"Model"	{$intRemainingNodeCount = ($objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfLayout].Models.Model | Where-Object {$_.name -eq $objSourceNode.Name} | Measure-Object).Count}
									"ModelGroup" {$intRemainingNodeCount = ($objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfLayout].ModelGroups.ModelGroup | Where-Object {$_.name -eq $objSourceNode.Name} | Measure-Object).Count}
									"View" {$intRemainingNodeCount = ($objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfLayout].Views.View | Where-Object {$_.name -eq $objSourceNode.Name} | Measure-Object).Count}
									default	{}
								}
						}

				If ($intRemainingNodeCount -eq 0)
					{
						LogWrite "DEBUG" "Removal succeeded"
						Return $true
					}
					Else
						{
							LogWrite "WARNING" "Removal failed"
							Return $false
						}
			}
			Else
				{
					LogWrite "WARNING" """$strNodeName"" not found in $strTarget"
					Return
				}
		
	}



Function CommitLayoutToxLights ($strLayoutName)
	{
		LogWrite "INFO" "Commiting ""$strLayoutName"" to xLights"

		$boolCommitLayoutToxLights = [System.Windows.Forms.MessageBox]::Show("Are you sure you want to commit $strLayoutName to xLights?","Commit $strLayoutName to xLights?" , "YesNo", "Exclamation")

		If ($boolCommitLayoutToxLights -ne "Yes")
			{
				LogWrite "INFO" "Commmitting ""$strLayoutName"" to xLights was aborted by user."
				Return
			}

		# If xLights is currently running, it should be closed.  Prompt the user
			If ((Get-Process xLights).Count -ge 1)
				{
					$boolClosexLightsBeforeContinuing = [System.Windows.Forms.MessageBox]::Show("xLights is currently running.  You should manually save and close xLights before continuing. `n`nClick Yes to force close xLights `nClick No to continue without closing xLights","xLights is Running (You better catch it!)" , "YesNo", "Exclamation")
					
					If ($boolClosexLightsBeforeContinuing -eq "Yes")
						{
							Try
								{
									Stop-Process -Name xLights -Force -ErrorAction SilentlyContinue
								}
								Catch {}
						}
				}

		Try
			{
				# *****************************
				# ********** Models ***********
				# *****************************

				# Get the list of models currently in xLights RGB Effects
				$arrModelsCurrentlyInxLights = ($objxLightsEffects.xrgb.models.model).Name

				# Get the lists of models in "- Common -" and the specified layout
				[array]$arrCommonModelsToCommit = ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq "- Common -"}).Models.model.name -split ","
				[array]$arrLayoutModelsToCommit = ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq $strLayoutName}).Models.model.name -split ","
				
				
				# If the box is checked, iterate through the list of models in xLights RGB Effects and, if the model does not exist in the to-commit list, remove it from xLights
				If ($cbxRemoveExtraResources.Checked -eq $true)
					{
						If (($arrModelsCurrentlyInxLights | Select-Object -First 1).Length -ge 1)
							{
								ForEach ($strModelCurrentlyInxLights in $arrModelsCurrentlyInxLights)
									{
										# Check to see if the model is in the list of Layout Models
										If ($strModelCurrentlyInxLights -notin $arrLayoutModelsToCommit)
											{
												If ($cbxAlsoLoadCommonLayout.Checked -eq $false)
													{
														# It's not and Common Layout is excluded so remove the model
														RemoveXMLNode -strTarget "xLights" -strNodeType "Model" -strNodeName $strModelCurrentlyInxLights -boolOverridePrompts $true
													}
													ElseIf ($cbxAlsoLoadCommonLayout.Checked -and $strModelCurrentlyInxLights -notin $arrCommonModelsToCommit)
														{
															# Common Layout is included but the model is not in Common either.  Remove it.
															RemoveXMLNode -strTarget "xLights" -strNodeType "Model" -strNodeName $strModelCurrentlyInxLights -boolOverridePrompts $true
														}
														Else
															{
																# Common is included and the model was found in Common so no action is necessary
															}
											}
									}
							}
					}

				# If the box is checked, iterate through the list of common models to be committed and add/overwrite them.  If the box is checked, prompt before overwriting.
				If ($cbxAlsoLoadCommonLayout.Checked -eq $true)
					{
						If (($arrCommonModelsToCommit | Select-Object -First 1).Length -ge 1)
							{
								ForEach ($strCommonModelToCommit in $arrCommonModelsToCommit)
									{
										$intModelsCopied = CopyXMLNode -strSource "Companion" -strTarget "xlights" -strSourceLayoutName "- Common -" -strNodeType "Model" -strNodeName $strCommonModelToCommit -boolOverridePrompts $cbxOverwriteExistingResources.Checked

										If ($intModelsCopied -ne 1)
											{
												LogWrite "WARNING" "Committing model ""$strCommonModelToCommit"" to xLights failed"
											}

										Remove-Variable intModelsCopied -ErrorAction SilentlyContinue
									}
							}
					}

				# If the selected layout is not '- Common -', iterate through the list of layout models to be committed and add/overwrite them.  If the box is checked, prompt before overwriting.
				If ($strLayoutName -ne "- Common -")
					{
						If (($arrLayoutModelsToCommit | Select-Object -First 1).Length -ge 1)
							{
								ForEach ($strLayoutModelToCommit in $arrLayoutModelsToCommit)
									{
										$intModelsCopied = CopyXMLNode -strSource "Companion" -strTarget "xlights" -strSourceLayoutName $strLayoutName -strNodeType "Model" -strNodeName $strLayoutModelToCommit -boolOverridePrompts $cbxOverwriteExistingResources.Checked

										If ($intModelsCopied -ne 1)
											{
												LogWrite "WARNING" "Committing model ""$strCommonModelToCommit"" to xLights failed"
											}

										Remove-Variable intModelsCopied -ErrorAction SilentlyContinue
									}
							}
					}

				# If the box is checked, activate all models in xLights
				If ($cbxMarkAllModelsActive.Checked -eq $true)
					{
						# Get the latest list of models currently in xLights RGB Effects
						$arrInactiveModelsInxLights = $objxLightsEffects.xrgb.models.model | Where-Object {$_.Active -eq "0"}

						# If the count isn't 0, iterate through the list of models and set the Active Attribute to 1
						If ($arrInactiveModelsInxLights.Count -ge 1)
							{
								ForEach ($strInactiveModelInxLights in $arrInactiveModelsInxLights)
									{
										# Set the Active Attribute to 1
										$strInactiveModelInxLights.Active = "1"
									}
							}
					}

				

				# *****************************
				# ******* Model Groups ********
				# *****************************

				# Get the list of model groups currently in xLights RGB Effects
				$arrModelGroupsCurrentlyInxLights = ($objxLightsEffects.xrgb.modelGroups.modelGroup).Name

				# Get the lists of model groups in "- Common -" and the specified layout
				[array]$arrCommonModelGroupsToCommit = ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq "- Common -"}).ModelGroups.modelGroup.name -split ","
				[array]$arrLayoutModelGroupsToCommit = ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq $strLayoutName}).ModelGroups.modelGroup.name -split ","


				# If the box is checked, iterate through the list of model groups in xLights RGB Effects and, if the model group does not exist in the to-commit list, remove it from xLights
				If ($cbxRemoveExtraResources.Checked -eq $true)
					{
						If (($arrModelGroupsCurrentlyInxLights | Select-Object -First 1).Length -ge 1)
							{
								ForEach ($strModelGroupCurrentlyInxLights in $arrModelGroupsCurrentlyInxLights)
									{
										# Check to see if the model group is in the list of Layout Model Groups
										If ($strModelGroupCurrentlyInxLights -notin $arrLayoutModelGroupsToCommit)
											{
												If ($cbxAlsoLoadCommonLayout.Checked -eq $false)
													{
														# It's not and Common Layout is excluded so remove the model group
														RemoveXMLNode -strTarget "xLights" -strNodeType "ModelGroup" -strNodeName $strModelGroupCurrentlyInxLights -boolOverridePrompts $true
													}
													ElseIf ($cbxAlsoLoadCommonLayout.Checked -and $strModelGroupCurrentlyInxLights -notin $arrCommonModelGroupsToCommit)
														{
															# Common Layout is included but the model group is not in Common either.  Remove it.
															RemoveXMLNode -strTarget "xLights" -strNodeType "ModelGroup" -strNodeName $strModelGroupCurrentlyInxLights -boolOverridePrompts $true
														}
														Else
															{
																# Common is included and the model group was found in Common so no action is necessary
															}
											}
									}
							}
					}

				# If the box is checked, iterate through the list of Common Model Groups to be committed and add/overwrite them.  If the box is checked, prompt before overwriting.
				If ($cbxAlsoLoadCommonLayout.Checked -eq $true)
					{
						If (($arrCommonModelGroupsToCommit | Select-Object -First 1).Length -ge 1)
							{
								ForEach ($strCommonModelGroupToCommit in $arrCommonModelGroupsToCommit)
									{
										$intModelGroupsCopied = CopyXMLNode -strSource "Companion" -strTarget "xlights" -strSourceLayoutName "- Common -" -strNodeType "ModelGroup" -strNodeName $strCommonModelGroupToCommit -boolOverridePrompts $cbxOverwriteExistingResources.Checked

										If ($intModelGroupsCopied -ne 1)
											{
												LogWrite "WARNING" "Committing Model Group ""$strCommonModelToCommit"" to xLights failed"
											}

										Remove-Variable intModelGroupsCopied -ErrorAction SilentlyContinue
									}
							}
					}

				# If the selected layout is not '- Common -', iterate through the list of Layout Model Groups to be committed and add/overwrite them.  If the box is checked, prompt before overwriting.
				If ($strLayoutName -ne "- Common -")
					{
						If (($arrLayoutModelGroupsToCommit | Select-Object -First 1).Length -ge 1)
							{
								ForEach ($strLayoutModelGroupToCommit in $arrLayoutModelGroupsToCommit)
									{
										$intModelGroupsCopied = CopyXMLNode -strSource "Companion" -strTarget "xlights" -strSourceLayoutName $strLayoutName -strNodeType "ModelGroup" -strNodeName $strLayoutModelGroupToCommit -boolOverridePrompts $cbxOverwriteExistingResources.Checked

										If ($intModelGroupsCopied -ne 1)
											{
												LogWrite "WARNING" "Committing Model Group ""$strCommonModelToCommit"" to xLights failed"
											}

										Remove-Variable intModelGroupsCopied -ErrorAction SilentlyContinue
									}
							}
					}


				
				# *****************************
				# ********** Views ************
				# *****************************

				# Get the list of views currently in xLights RGB Effects
				$arrViewsCurrentlyInxLights = ($objxLightsEffects.xrgb.views.view).Name

				# Get the lists of views in "- Common -" and the specified layout
				[array]$arrCommonViewsToCommit = ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq "- Common -"}).Views.view.name -split ","
				[array]$arrLayoutViewsToCommit = ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq $strLayoutName}).Views.view.name -split ","
			
					
				# If the box is checked, iterate through the list of view in xLights RGB Effects and, if the view does not exist in the to-commit list, remove it from xLights
				If ($cbxRemoveExtraResources.Checked -eq $true)
					{
						If (($arrViewsCurrentlyInxLights | Select-Object -First 1).Length -ge 1)
							{
								ForEach ($strViewCurrentlyInxLights in $arrViewsCurrentlyInxLights)
									{
										# Check to see if the view is in the list of Layout Views
										If ($strViewCurrentlyInxLights -notin $arrLayoutViewsToCommit)
											{
												If ($cbxAlsoLoadCommonLayout.Checked -eq $false)
													{
														# It's not and Common Layout is excluded so remove the view
														RemoveXMLNode -strTarget "xLights" -strNodeType "View" -strNodeName $strViewCurrentlyInxLights -boolOverridePrompts $true
													}
													ElseIf ($cbxAlsoLoadCommonLayout.Checked -and $strViewCurrentlyInxLights -notin $arrCommonViewsToCommit)
														{
															# Common Layout is included but the view is not in Common either.  Remove it.
															RemoveXMLNode -strTarget "xLights" -strNodeType "View" -strNodeName $strViewCurrentlyInxLights -boolOverridePrompts $true
														}
														Else
															{
																# Common is included and the view was found in Common so no action is necessary
															}
											}
									}
							}
					}

				# If the box is checked, iterate through the list of Common Views to be committed and add/overwrite them.  If the box is checked, prompt before overwriting.
				If ($cbxAlsoLoadCommonLayout.Checked -eq $true)
					{
						If (($arrCommonViewsToCommit | Select-Object -First 1).Length -ge 1)
							{
								ForEach ($strCommonViewToCommit in $arrCommonViewsToCommit)
									{
										$intViewsCopied = CopyXMLNode -strSource "Companion" -strTarget "xlights" -strSourceLayoutName "- Common -" -strNodeType "View" -strNodeName $strCommonViewToCommit -boolOverridePrompts $cbxOverwriteExistingResources.Checked
										
										If ($intViewsCopied -ne 1)
											{
												LogWrite "WARNING" "Committing View ""$strCommonModelToCommit"" to xLights failed"
											}

										Remove-Variable intViewsCopied -ErrorAction SilentlyContinue
									}
							}
					}

				# If the selected layout is not '- Common -', iterate through the list of Layout Views to be committed and add/overwrite them.  If the box is checked, prompt before overwriting.
				If ($strLayoutName -ne "- Common -")
					{
						If (($arrLayoutViewsToCommit | Select-Object -First 1).Length -ge 1)
							{
								ForEach ($strLayoutViewToCommit in $arrLayoutViewsToCommit)
									{
										$intViewsCopied = CopyXMLNode -strSource "Companion" -strTarget "xlights" -strSourceLayoutName $strLayoutName -strNodeType "View" -strNodeName $strLayoutViewToCommit -boolOverridePrompts $cbxOverwriteExistingResources.Checked
										
										If ($intViewsCopied -ne 1)
											{
												LogWrite "WARNING" "Committing View ""$strCommonModelToCommit"" to xLights failed"
											}

										Remove-Variable intViewsCopied -ErrorAction SilentlyContinue
									}
							}
					}



				# Save the xLights file
				$objxLightsEffects.Save($strxlightsRGBEffectsFilePath)

				LogWrite "INFO" "Committing to xLights completed successfully" "Green"

				If (!($strxLightsPath) -or !(Test-Path $strxLightsPath))
					{
						LogWrite "VERBOSE" "Searching for xlights.exe........"
						$strxLightsPath = (Get-ChildItem -Path $env:ProgramFiles -filter xlights.exe -Recurse -ErrorAction SilentlyContinue).FullName
					}

				If (Test-Path $strxLightsPath)
					{
						If ($lblOpenLayoutInxLights) {Remove-Variable $lblOpenLayoutInxLights -ErrorAction SilentlyContinue -Force}

						$lblOpenLayoutInxLights.Text = "- Open $strLayoutName in xLights -"
						$lblOpenLayoutInxLights.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::Underline)
						$lblOpenLayoutInxLights.Add_Click({
								
								LogWrite "VERBOSE" "Opening ""$strxlightsRGBEffectsFilePath"" in xLights"
								Start-Process -FilePath $strxLightsPath -ArgumentList "--show ""$((Get-Item $strxlightsRGBEffectsFilePath).DirectoryName)""" -WindowStyle Normal
							})
					}
					
				
			}
			Catch
				{
					LogWrite "WARNING" "An error occurred committing the layout to xLights: $_"
				}
	}



Function FilterSyncSelectedResources ($strNodeType, $strHideType)
	{
		LogWrite "DEBUG" "Hiding $strHideType from $strNodeType List"

		Switch ($strHideType)
			{
				"Unchanged"
					{
						Switch ($strNodeType)
							{
								"Model"
									{
										LogWrite "Verbose" "Removing Unchanged Models From The List"

										$intUnchangedModelsRemoved = 0

										# Get the list of all items (minus the Select All item)
										$arrCurrentListOfModels = $clbxSelectedModels.Items | Where-Object {$_ -ne "- Select All -"}

										# Go through the list and compare to each item in the layout
										ForEach ($strModelInList in $arrCurrentListOfModels)
											{
												LogWrite "DEBUG" "Checking $strModelInList to see if it matches"

												$boolModelsMatch = CompareXMLNodes -strSource "xLights" -strTarget "Companion" -strTargetLayoutName $strLayoutName -strNodeType "Model" -strNodeName $strModelInList

												If ($boolModelsMatch -eq $true) 
													{
														LogWrite "DEBUG" """$strModelInList"" matches - Remove it from the list box" "Yellow"
														$clbxSelectedModels.Items.Remove($strModelInList)

														$intUnchangedModelsRemoved++
													}

												Remove-Variable boolModelsMatch -ErrorAction SilentlyContinue
											}
										
										LogWrite "Verbose" "Removed $intUnchangedModelsRemoved Unchanged Models From The List"
									}

								"ModelGroup"
									{
										LogWrite "Verbose" "Removing Unchanged Model Groups From The List"

										$intUnchangedModelGroupsRemoved = 0

										# Get the list of all items (minus the Select All item)
										$arrCurrentListOfModelGroups = $clbxSelectedModelGroups.Items | Where-Object {$_ -ne "- Select All -"}

										# Go through the list and compare to each item in the layout
										ForEach ($strModelGroupInList in $arrCurrentListOfModelGroups)
											{
												LogWrite "DEBUG" "Checking $strModelGroupInList to see if it matches"

												$boolModelGroupsMatch = CompareXMLNodes -strSource "xLights" -strTarget "Companion" -strTargetLayoutName $strLayoutName -strNodeType "ModelGroup" -strNodeName $strModelGroupInList

												If ($boolModelGroupsMatch -eq $true) 
													{
														LogWrite "DEBUG" """$strModelGroupInList"" matches - Remove it from the list box" "Yellow"
														$clbxSelectedModelGroups.Items.Remove($strModelGroupInList)

														$intUnchangedModelGroupsRemoved++
													}

												Remove-Variable boolModelGroupsMatch -ErrorAction SilentlyContinue
											}
										
										LogWrite "Verbose" "Removed $intUnchangedModelGroupsRemoved Unchanged Model Groups From The List"
									}

								"View"
									{
										LogWrite "Verbose" "Removing Unchanged Views From The List"

										$intUnchangedViewsRemoved = 0

										# Get the list of all items (minus the Select All item)
										$arrCurrentListOfViews = $clbxSelectedViews.Items | Where-Object {$_ -ne "- Select All -"}

										# Go through the list and compare to each item in the layout
										ForEach ($strViewInList in $arrCurrentListOfViews)
											{
												LogWrite "DEBUG" "Checking $strViewInList to see if it matches"

												$boolViewsMatch = CompareXMLNodes -strSource "xLights" -strTarget "Companion" -strTargetLayoutName $strLayoutName -strNodeType "View" -strNodeName $strViewInList

												If ($boolViewsMatch -eq $true) 
													{
														LogWrite "DEBUG" """$strViewInList"" matches - Remove it from the list box" "Yellow"
														$clbxSelectedViews.Items.Remove($strViewInList)

														$intUnchangedViewsRemoved++
													}

												Remove-Variable boolViewsMatch -ErrorAction SilentlyContinue
											}

										LogWrite "Verbose" "Removed $intUnchangedViewsRemoved Unchanged Views From The List"
									}
							}
					}

				"Common"
					{
						Switch ($strNodeType)
							{
								"Model"
									{
										LogWrite "Verbose" "Removing Common Layout Models From The List"

										$intCommonLayoutModelsRemoved = 0

										# Get the list of all items (minus the Select All item)
										$arrCurrentListOfModels = $clbxSelectedModels.Items | Where-Object {$_ -ne "- Select All -"}

										# Get the list of all models in the Common Layout
										[array]$arrModelsInCommonLayout = ($objxLightsCompanionXML.xlc.layouts.Layout | Where-Object {$_.Name -eq "- Common -"}).models.Model.Name

										# Go through the list and compare to the list of Common Layout items
										ForEach ($strModelInList in $arrCurrentListOfModels)
											{
												LogWrite "DEBUG" "Checking $strModelInList to see if it's in the Common Layout"

												If ($strModelInList -in $arrModelsInCommonLayout)
													{
														LogWrite "DEBUG" """$strModelInList"" matches - Remove it from the list box" "Yellow"
														$clbxSelectedModels.Items.Remove($strModelInList)

														$intCommonLayoutModelsRemoved++
													}

											}

										LogWrite "Verbose" "Removed $intCommonLayoutModelsRemoved Common Layout Models From The List"
									}

								"ModelGroup"
									{
										LogWrite "Verbose" "Removing Common Layout Model Groups From The List"

										$intCommonLayoutModelGroupsRemoved = 0

										# Get the list of all items (minus the Select All item)
										$arrCurrentListOfModelGroups = $clbxSelectedModelGroups.Items | Where-Object {$_ -ne "- Select All -"}

										# Get the list of all model groups in the Common Layout
										[array]$arrModelGroupsInCommonLayout = ($objxLightsCompanionXML.xlc.layouts.Layout | Where-Object {$_.Name -eq "- Common -"}).modelGroups.ModelGroup.Name

										# Go through the list and compare to the list of Common Layout items
										ForEach ($strModelGroupInList in $arrCurrentListOfModelGroups)
											{
												LogWrite "DEBUG" "Checking $strModelInList to see if it's in the Common Layout"

												If ($strModelGroupInList -in $arrModelGroupsInCommonLayout)
													{
														LogWrite "DEBUG" """$strModelGroupInList"" matches - Remove it from the list box" "Yellow"
														$clbxSelectedModelGroups.Items.Remove($strModelGroupInList)

														$intCommonLayoutModelGroupsRemoved++
													}

											}

										LogWrite "Verbose" "Removed $intCommonLayoutModelGroupsRemoved Common Layout Model Groups From The List"
									}

								"View"
									{
										LogWrite "Verbose" "Removing Common Layout Views From The List"

										$intCommonLayoutViewsRemoved = 0

										# Get the list of all items (minus the Select All item)
										$arrCurrentListOfViews = $clbxSelectedViews.Items | Where-Object {$_ -ne "- Select All -"}

										# Get the list of all views in the Common Layout
										[array]$arrViewsInCommonLayout = ($objxLightsCompanionXML.xlc.layouts.Layout | Where-Object {$_.Name -eq "- Common -"}).views.View.Name

										# Go through the list and compare to the list of Common Layout items
										ForEach ($strViewInList in $arrCurrentListOfViews)
											{
												LogWrite "DEBUG" "Checking $strViewInList to see if it's in the Common Layout"

												If ($strViewInList -in $arrViewsInCommonLayout)
													{
														LogWrite "DEBUG" """$strViewInList"" matches - Remove it from the list box" "Yellow"
														$clbxSelectedViews.Items.Remove($strViewInList)

														$intCommonLayoutViewsRemoved++
													}

											}

										LogWrite "Verbose" "Removed $intCommonLayoutViewsRemoved Common Layout Views From The List"
									}
							}
					}

				"Reset"
					{
						Switch ($strNodeType)
							{
								"Model"
									{
										# Load each model into the list box
										LogWrite "VERBOSE" "Found $(($objxLightsEffects.xrgb.models.model.Count)) Models to Load"
										
										# Reload the list box with all available models
										$clbxSelectedModels.Items.Clear()
										
										If ($objxLightsModels.Count -ge 1)
											{
												$clbxSelectedModels.Items.Add($strSelectAllText)

												$objxLightsModels | ForEach-Object {
														
													If ($_.name)
														{
															LogWrite "DEBUG" "Loading ""$($_.name)"""
														
															$clbxSelectedModels.Items.Add($_.name)
														}
													}
											}
											Else
												{
													$clbxSelectedModels.Items.Add("- No Models Are Available in xLights -")
													$clbxSelectedModels.Enabled = $false
												}
									}

								"ModelGroup"
									{
										# Load each model group into the list box
										LogWrite "VERBOSE" "Found $(($objxLightsEffects.xrgb.modelGroups.modelGroup.Count)) Model Groups to Load"

										# Reload the list box with all available model groups
										$clbxSelectedModelGroups.Items.Clear()

										If ($objxLightsModelGroups.Count -ge 1)
											{
												$clbxSelectedModelGroups.Items.Add($strSelectAllText)
												
												$objxLightsModelGroups | ForEach-Object {
														
														If ($_.name)
															{
																LogWrite "DEBUG" "Loading ""$($_.name)"""
																
																$clbxSelectedModelGroups.Items.Add($_.name)
															}
													}
											}
											Else
												{
													$clbxSelectedModelGroups.Items.Add("- No Model Groups Are Available in xLights -")
													$clbxSelectedModelGroups.Enabled = $false
												}
									}

								"View"
									{
										# Load each view into the list box
										LogWrite "VERBOSE" "Found $(($objxLightsEffects.xrgb.views.view.Count)) Views to Load"

										# Reload the list box with all available views
										$clbxSelectedViews.Items.Clear()
										
										If ($objxLightsViews.Count -ge 1)
											{
												$clbxSelectedViews.Items.Add($strSelectAllText)
												
												$objxLightsViews | ForEach-Object {
														
														If ($_.name)
															{
																LogWrite "DEBUG" "Loading ""$($_.name)"""
														
																$clbxSelectedViews.Items.Add($_.name)
															}
													}
											}
											Else
												{
													$clbxSelectedViews.Items.Add("- No Views Are Available in xLights -")
													$clbxSelectedViews.Enabled = $false
												}
									}
							}
					}
			}


	}


Function ShowSyncSelectedForm ($strLayoutName, $boolOverridePrompts, $boolPromptOnNewModels)
	{
		LogWrite "DEBUG" "Show the Sync Selected Form"
	
		$strSelectAllText = "- Select All -"

		# Draw the form
		If (!($frmSyncSelected)) 
			{
				$frmSyncSelected = New-Object System.Windows.Forms.Form
				$frmSyncSelected.BackColor = "Azure"
				$frmSyncSelected.Text = "Choose Resources to Sync"
				$frmSyncSelected.Width = $objForm.Width * .8
				$frmSyncSelected.Height = $objForm.Height * .8
				$frmSyncSelected.StartPosition = "CenterScreen" # CenterScreen, Manual, WindowsDefaultLocation, WindowsDefaultBounds, CenterParent
				$frmSyncSelected.ControlBox = $false # Show/hide the Min/Max/X buttons in the rop right corner of the window. If this is $false, the Minimize and Maximize buttons will be hidden, regardless of the settings below
				$frmSyncSelected.MinimizeBox = $false
				$frmSyncSelected.MaximizeBox = $false
				#$frmSyncSelected.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::DPI
				$frmSyncSelected.FormBorderStyle = "Fixed3D" # None, Fixed3D, FixedSingle
				$frmSyncSelected.Topmost = $true  
				$objIcon = [system.drawing.icon]::ExtractAssociatedIcon($strFormIconPath)
				$frmSyncSelected.Icon = $objIcon
				$frmSyncSelected.KeyPreview = $true
				$frmSyncSelected.Add_Shown({
						# Set what should happen the first time the form is shown
						$frmSyncSelected.Activate()
					})
				$frmSyncSelected.Add_Closed({
						# Try to close the On Screen Keyboard
						Try 
							{
							} Catch {}
					})
			}

		# Add description label
		If (!($lblDescription)) 
			{
				$lblDescription = New-Object System.Windows.Forms.Label
				$lblDescription.Left = 5
				$lblDescription.Top = 10
				$lblDescription.Width = $frmSyncSelected.Width - 25
				$lblDescription.Height = 20
				$lblDescription.TextAlign = "TopCenter"
				$lblDescription.Text = "Select the Resources to Sync to $(If ($strLayoutName -eq "- Repository (Recovery) -") {"Repository"} Else {$lbxLayouts.SelectedItem})"
				$lblDescription.ForeColor = "Blue"
				$lblDescription.BackColor = "Transparent"
				$lblDescription.Font = New-Object System.Drawing.Font("Arial",12)
				$lblDescription.Anchor = "Top,Left,Right"
				$frmSyncSelected.Controls.Add($lblDescription)
			}
	

		# Sync Options Group Box
		If (!($grpSelectedSyncOptions)) 
			{
				$grpSelectedSyncOptions = New-Object Windows.Forms.GroupBox
				$grpSelectedSyncOptions.Left = $lblDescription.Left + 10
				$grpSelectedSyncOptions.Top =  $lblDescription.Bottom + 20
				$grpSelectedSyncOptions.Width = $lblDescription.Width - 20
				$grpSelectedSyncOptions.Height = $frmSyncSelected.Height * .2
				$grpSelectedSyncOptions.Enabled = $true
				$grpSelectedSyncOptions.Anchor = "Top,Left,Right"
				$grpSelectedSyncOptions.Text = "Sync Options....."
				$frmSyncSelected.Controls.Add($grpSelectedSyncOptions)
			}

		# Add the Hide Unchanged Models checkbox
		If (!($cbxHideUnchangedModels)) 
			{
				$cbxHideUnchangedModels = New-Object Windows.Forms.CheckBox
				$cbxHideUnchangedModels.Width = (($frmSyncSelected.Width - 55) * .33 ) - 10
				$cbxHideUnchangedModels.Left = 15
				$cbxHideUnchangedModels.Top = 20
				$cbxHideUnchangedModels.Text = "Hide Models That Have Not Been Changed"
				$cbxHideUnchangedModels.TextAlign = "MiddleLeft"
				$cbxHideUnchangedModels.Cursor = "Hand"
				$cbxHideUnchangedModels.ForeColor = "Black"
				$cbxHideUnchangedModels.BackColor = "Transparent"
				$cbxHideUnchangedModels.Checked = $false
				$cbxHideUnchangedModels.Visible = $true
				$cbxHideUnchangedModels.Anchor = "Left,Top"
				$cbxHideUnchangedModels.Add_Click({
					
						If ($cbxHideUnchangedModels.Checked -eq $true)
							{
								FilterSyncSelectedResources -strNodeType "Model" -strHideType "Unchanged"
								# # Get the list of all items (minus the Select All item)
								# $arrSelectedModels = $clbxSelectedModels.Items | Where-Object {$_ -ne "- Select All -"}

								# # Go through the list and compare to each item in the layout
								# ForEach ($strSelectedModel in $arrSelectedModels)
								# 	{
								# 		LogWrite "DEBUG" "Checking $strSelectedModel to see if it matches"

								# 		$boolModelsMatch = CompareXMLNodes -strSource "xLights" -strTarget "Companion" -strTargetLayoutName $strLayoutName -strNodeType "Model" -strNodeName $strSelectedModel

								# 		If ($boolModelsMatch -eq $true) 
								# 			{
								# 				LogWrite "DEBUG" """$strSelectedModel"" matches - Remove it from the list box" "Yellow"
								# 				$clbxSelectedModels.Items.Remove($strSelectedModel)
								# 			}

								# 		Remove-Variable boolModelsMatch -ErrorAction SilentlyContinue
								# 	}
							}
							Else
								{
									FilterSyncSelectedResources -strNodeType "Model" -strHideType "Reset"
									If ($cbxHideCommonLayoutModels.Checked -eq $true) {FilterSyncSelectedResources -strNodeType "Model" -strHideType "Common"}

									# # Load each model into the list box
									# LogWrite "VERBOSE" "Found $(($objxLightsEffects.xrgb.models.model.Count)) Models to Load"
									
									# # Reload the list box with all available models
									# $clbxSelectedModels.Items.Clear()
									
									# If ($objxLightsModels.Count -ge 1)
									# 	{
									# 		$clbxSelectedModels.Items.Add($strSelectAllText)

									# 		$objxLightsModels | ForEach-Object {
													
									# 			If ($_.name)
									# 				{
									# 					LogWrite "DEBUG" "Loading ""$($_.name)"""
													
									# 					$clbxSelectedModels.Items.Add($_.name)
									# 				}
									# 			}
									# 	}
									# 	Else
									# 		{
									# 			$clbxSelectedModels.Items.Add("- No Models Are Available in xLights -")
									# 			$clbxSelectedModels.Enabled = $false
									# 		}
								}
					})
				$grpSelectedSyncOptions.Controls.Add($cbxHideUnchangedModels)
			}

		# Add the Hide Common Layout Models checkbox
		If (!($cbxHideCommonLayoutModels)) 
			{
				$cbxHideCommonLayoutModels = New-Object Windows.Forms.CheckBox
				$cbxHideCommonLayoutModels.Left = $cbxHideUnchangedModels.Left
				$cbxHideCommonLayoutModels.Top = $cbxHideUnchangedModels.Bottom + 5
				$cbxHideCommonLayoutModels.Width = $cbxHideUnchangedModels.Width
				$cbxHideCommonLayoutModels.Text = "Hide Models Assigned to '- Common -'"
				$cbxHideCommonLayoutModels.TextAlign = "MiddleLeft"
				$cbxHideCommonLayoutModels.Cursor = "Hand"
				$cbxHideCommonLayoutModels.ForeColor = "Black"
				$cbxHideCommonLayoutModels.BackColor = "Transparent"
				$cbxHideCommonLayoutModels.Checked = $false
				$cbxHideCommonLayoutModels.Enabled = If ($strLayoutName -eq "- Common -") {$false} Else {$true}
				$cbxHideCommonLayoutModels.Anchor = "Left,Top"
				$cbxHideCommonLayoutModels.Add_Click({

						If ($cbxHideCommonLayoutModels.Checked -eq $true)
							{
								FilterSyncSelectedResources -strNodeType "Model" -strHideType "Common"
							}
							Else
								{
									FilterSyncSelectedResources -strNodeType "Model" -strHideType "Reset"
									If ($cbxHideUnchangedModels.Checked -eq $true) {FilterSyncSelectedResources -strNodeType "Model" -strHideType "Unchanged"}
								}

					})
				$grpSelectedSyncOptions.Controls.Add($cbxHideCommonLayoutModels)
			}

		# Add the Prompt To Overwrite Models checkbox
		If (!($cbxPromptToOverwriteModels)) 
			{
				$cbxPromptToOverwriteModels = New-Object Windows.Forms.CheckBox
				$cbxPromptToOverwriteModels.Left = $cbxHideUnchangedModels.Left
				$cbxPromptToOverwriteModels.Top = $cbxHideCommonLayoutModels.Bottom + 5
				$cbxPromptToOverwriteModels.Width = $cbxHideCommonLayoutModels.Width
				$cbxPromptToOverwriteModels.Text = "Overwrite Existing Models Without Prompting"
				$cbxPromptToOverwriteModels.TextAlign = "MiddleLeft"
				$cbxPromptToOverwriteModels.Cursor = "Hand"
				$cbxPromptToOverwriteModels.ForeColor = "Black"
				$cbxPromptToOverwriteModels.BackColor = "Transparent"
				$cbxPromptToOverwriteModels.Checked = $true
				$cbxPromptToOverwriteModels.Anchor = "Left,Top"
				$grpSelectedSyncOptions.Controls.Add($cbxPromptToOverwriteModels)
			}

			
		# Add the Hide Unchanged Model Groups checkbox
		If (!($cbxHideUnchangedModelGroups)) 
			{
				$cbxHideUnchangedModelGroups = New-Object Windows.Forms.CheckBox
				$cbxHideUnchangedModelGroups.Width = $cbxHideUnchangedModels.Width
				$cbxHideUnchangedModelGroups.Left = $cbxHideUnchangedModels.Right + 20
				$cbxHideUnchangedModelGroups.Top = $cbxHideUnchangedModels.Top
				$cbxHideUnchangedModelGroups.Text = "Hide Model Groups That Have Not Been Changed"
				$cbxHideUnchangedModelGroups.TextAlign = "MiddleLeft"
				$cbxHideUnchangedModelGroups.Cursor = "Hand"
				$cbxHideUnchangedModelGroups.ForeColor = "Black"
				$cbxHideUnchangedModelGroups.BackColor = "Transparent"
				$cbxHideUnchangedModelGroups.Checked = $false
				$cbxHideUnchangedModelGroups.Padding = 0
				$cbxHideUnchangedModelGroups.Visible = $true
				$cbxHideUnchangedModelGroups.Anchor = "Left,Top"
				$cbxHideUnchangedModelGroups.Add_Click({
					
						If ($cbxHideUnchangedModelGroups.Checked -eq $true)
							{
								FilterSyncSelectedResources -strNodeType "ModelGroup" -strHideType "Unchanged"
								# $arrSelectedModelGroups = $clbxSelectedModelGroups.Items | Where-Object {$_ -ne "- Select All -"}

								# # Go through the list and compare to each item in the layout
								# ForEach ($strSelectedModelGroup in $arrSelectedModelGroups)
								# 	{
								# 		LogWrite "DEBUG" "Checking $strSelectedModelGroup to see if it matches"

								# 		$boolModelGroupsMatch = CompareXMLNodes -strSource "xLights" -strTarget "Companion" -strTargetLayoutName $strLayoutName -strNodeType "ModelGroup" -strNodeName $strSelectedModelGroup

								# 		If ($boolModelGroupsMatch -eq $true) 
								# 			{
								# 				LogWrite "DEBUG" """$strSelectedModelGroup"" matches - Remove it from the list box" "Yellow"
								# 				$clbxSelectedModelGroups.Items.Remove($strSelectedModelGroup)
								# 			}

								# 		Remove-Variable boolModelGroupsMatch -ErrorAction SilentlyContinue
								# 	}
							}
							Else
								{
									FilterSyncSelectedResources -strNodeType "ModelGroup" -strHideType "Reset"
									If ($cbxHideCommonLayoutModelGroups.Checked -eq $true) {FilterSyncSelectedResources -strNodeType "ModelGroup" -strHideType "Common"}
									# # Load each model group into the list box
									# LogWrite "VERBOSE" "Found $(($objxLightsEffects.xrgb.modelGroups.modelGroup.Count)) Model Groups to Load"

									# # Reload the list box with all available model groups
									# $clbxSelectedModelGroups.Items.Clear()

									# If ($objxLightsModelGroups.Count -ge 1)
									# 	{
									# 		$clbxSelectedModelGroups.Items.Add($strSelectAllText)
											
									# 		$objxLightsModelGroups | ForEach-Object {
													
									# 				If ($_.name)
									# 					{
									# 						LogWrite "DEBUG" "Loading ""$($_.name)"""
															
									# 						$clbxSelectedModelGroups.Items.Add($_.name)
									# 					}
									# 			}
									# 	}
									# 	Else
									# 		{
									# 			$clbxSelectedModelGroups.Items.Add("- No Model Groups Are Available in xLights -")
									# 			$clbxSelectedModelGroups.Enabled = $false
									# 		}
								}
					})
				$grpSelectedSyncOptions.Controls.Add($cbxHideUnchangedModelGroups)
			}


		# Add the Hide Common Layout Model Groups checkbox
		If (!($cbxHideCommonLayoutModelGroups)) 
			{
				$cbxHideCommonLayoutModelGroups = New-Object Windows.Forms.CheckBox
				$cbxHideCommonLayoutModelGroups.Left = $cbxHideUnchangedModelGroups.Left
				$cbxHideCommonLayoutModelGroups.Top = $cbxHideCommonLayoutModels.Top
				$cbxHideCommonLayoutModelGroups.Width = $cbxHideUnchangedModelGroups.Width
				$cbxHideCommonLayoutModelGroups.Text = "Hide Model Groups Assigned to '- Common -'"
				$cbxHideCommonLayoutModelGroups.TextAlign = "MiddleLeft"
				$cbxHideCommonLayoutModelGroups.Cursor = "Hand"
				$cbxHideCommonLayoutModelGroups.ForeColor = "Black"
				$cbxHideCommonLayoutModelGroups.BackColor = "Transparent"
				$cbxHideCommonLayoutModelGroups.Checked = $false
				$cbxHideCommonLayoutModelGroups.Enabled = If ($strLayoutName -eq "- Common -") {$false} Else {$true}
				$cbxHideCommonLayoutModelGroups.Anchor = "Left,Top"
				$cbxHideCommonLayoutModelGroups.Add_Click({

					If ($cbxHideCommonLayoutModelGroups.Checked -eq $true)
						{
							FilterSyncSelectedResources -strNodeType "ModelGroup" -strHideType "Common"
						}
						Else
							{
								FilterSyncSelectedResources -strNodeType "ModelGroup" -strHideType "Reset"
								If ($cbxHideUnchangedModelGroups.Checked -eq $true) {FilterSyncSelectedResources -strNodeType "ModelGroup" -strHideType "Unchanged"}
							}

				})
				$grpSelectedSyncOptions.Controls.Add($cbxHideCommonLayoutModelGroups)
			}

		# Add the Prompt To Overwrite Model Groups checkbox
		If (!($cbxPromptToOverwriteModelGroups)) 
			{
				$cbxPromptToOverwriteModelGroups = New-Object Windows.Forms.CheckBox
				$cbxPromptToOverwriteModelGroups.Left = $cbxHideUnchangedModelGroups.Left
				$cbxPromptToOverwriteModelGroups.Top = $cbxPromptToOverwriteModels.Top
				$cbxPromptToOverwriteModelGroups.Width = $cbxHideUnchangedModelGroups.Width
				$cbxPromptToOverwriteModelGroups.Text = "Overwrite Existing Model Groups Without Prompting"
				$cbxPromptToOverwriteModelGroups.TextAlign = "MiddleLeft"
				$cbxPromptToOverwriteModelGroups.Cursor = "Hand"
				$cbxPromptToOverwriteModelGroups.ForeColor = "Black"
				$cbxPromptToOverwriteModelGroups.BackColor = "Transparent"
				$cbxPromptToOverwriteModelGroups.Checked = $true
				$cbxPromptToOverwriteModelGroups.Anchor = "Left,Top"
				$grpSelectedSyncOptions.Controls.Add($cbxPromptToOverwriteModelGroups)
			}


			
		# Add the Hide Unchanged Views checkbox
		If (!($cbxHideUnchangedViews)) 
			{
				$cbxHideUnchangedViews = New-Object Windows.Forms.CheckBox
				$cbxHideUnchangedViews.Width = $cbxHideUnchangedModels.Width
				$cbxHideUnchangedViews.Left = $cbxHideUnchangedModelGroups.Right + 20
				$cbxHideUnchangedViews.Top = $cbxHideUnchangedModelGroups.Top
				$cbxHideUnchangedViews.Text = "Hide Views That Have Not Been Changed"
				$cbxHideUnchangedViews.TextAlign = "MiddleLeft"
				$cbxHideUnchangedViews.Cursor = "Hand"
				$cbxHideUnchangedViews.ForeColor = "Black"
				$cbxHideUnchangedViews.BackColor = "Transparent"
				$cbxHideUnchangedViews.Checked = $false
				$cbxHideUnchangedViews.Padding = 0
				$cbxHideUnchangedViews.Visible = $true
				$cbxHideUnchangedViews.Anchor = "Left,Top"
				$cbxHideUnchangedViews.Add_Click({
					
						If ($cbxHideUnchangedViews.Checked -eq $true)
							{
								FilterSyncSelectedResources -strNodeType "View" -strHideType "Unchanged"
								# # Get the list of all items (minus the Select All item)
								# $arrSelectedViews = $clbxSelectedViews.Items | Where-Object {$_ -ne "- Select All -"}

								# # Go through the list and compare to each item in the layout
								# ForEach ($strSelectedView in $arrSelectedViews)
								# 	{
								# 		LogWrite "DEBUG" "Checking $strSelectedView to see if it matches"

								# 		$boolViewsMatch = CompareXMLNodes -strSource "xLights" -strTarget "Companion" -strTargetLayoutName $strLayoutName -strNodeType "View" -strNodeName $strSelectedView

								# 		If ($boolViewsMatch -eq $true) 
								# 			{
								# 				LogWrite "DEBUG" """$strSelectedView"" matches - Remove it from the list box" "Yellow"
								# 				$clbxSelectedViews.Items.Remove($strSelectedView)
								# 			}

								# 		Remove-Variable boolViewsMatch -ErrorAction SilentlyContinue
								# 	}
							}
							Else
								{
									FilterSyncSelectedResources -strNodeType "View" -strHideType "Reset"
									If ($cbxHideCommonLayoutViews.Checked -eq $true) {FilterSyncSelectedResources -strNodeType "View" -strHideType "Common"}
									# # Load each view into the list box
									# LogWrite "VERBOSE" "Found $(($objxLightsEffects.xrgb.views.view.Count)) Views to Load"

									# # Reload the list box with all available views
									# $clbxSelectedViews.Items.Clear()
									
									# If ($objxLightsViews.Count -ge 1)
									# 	{
									# 		$clbxSelectedViews.Items.Add($strSelectAllText)
											
									# 		$objxLightsViews | ForEach-Object {
													
									# 				If ($_.name)
									# 					{
									# 						LogWrite "DEBUG" "Loading ""$($_.name)"""
													
									# 						$clbxSelectedViews.Items.Add($_.name)
									# 					}
									# 			}
									# 	}
									# 	Else
									# 		{
									# 			$clbxSelectedViews.Items.Add("- No Views Are Available in xLights -")
									# 			$clbxSelectedViews.Enabled = $false
									# 		}

								}
					})
				$grpSelectedSyncOptions.Controls.Add($cbxHideUnchangedViews)
			}


		# Add the Hide Common Layout Views checkbox
		If (!($cbxHideCommonLayoutViews)) 
			{
				$cbxHideCommonLayoutViews = New-Object Windows.Forms.CheckBox
				$cbxHideCommonLayoutViews.Left = $cbxHideUnchangedViews.Left
				$cbxHideCommonLayoutViews.Top = $cbxHideCommonLayoutModels.Top
				$cbxHideCommonLayoutViews.Width = $cbxHideUnchangedViews.Width
				$cbxHideCommonLayoutViews.Text = "Hide Views Assigned to '- Common -'"
				$cbxHideCommonLayoutViews.TextAlign = "MiddleLeft"
				$cbxHideCommonLayoutViews.Cursor = "Hand"
				$cbxHideCommonLayoutViews.ForeColor = "Black"
				$cbxHideCommonLayoutViews.BackColor = "Transparent"
				$cbxHideCommonLayoutViews.Checked = $false
				$cbxHideCommonLayoutViews.Enabled = If ($strLayoutName -eq "- Common -") {$false} Else {$true}
				$cbxHideCommonLayoutViews.Anchor = "Left,Top"
				$cbxHideCommonLayoutViews.Add_Click({

					If ($cbxHideCommonLayoutViews.Checked -eq $true)
						{
							FilterSyncSelectedResources -strNodeType "View" -strHideType "Common"
						}
						Else
							{
								FilterSyncSelectedResources -strNodeType "View" -strHideType "Reset"
								If ($cbxHideUnchangedViews.Checked -eq $true) {FilterSyncSelectedResources -strNodeType "View" -strHideType "Unchanged"}
							}

				})				
				$grpSelectedSyncOptions.Controls.Add($cbxHideCommonLayoutViews)
			}

		# Add the Prompt To Overwrite Views checkbox
		If (!($cbxPromptToOverwriteViews)) 
			{
				$cbxPromptToOverwriteViews = New-Object Windows.Forms.CheckBox
				$cbxPromptToOverwriteViews.Left = $cbxHideUnchangedViews.Left
				$cbxPromptToOverwriteViews.Top = $cbxPromptToOverwriteModels.Top
				$cbxPromptToOverwriteViews.Width = $cbxHideUnchangedViews.Width
				$cbxPromptToOverwriteViews.Text = "Overwrite Existing Views Without Prompting"
				$cbxPromptToOverwriteViews.TextAlign = "MiddleLeft"
				$cbxPromptToOverwriteViews.Cursor = "Hand"
				$cbxPromptToOverwriteViews.ForeColor = "Black"
				$cbxPromptToOverwriteViews.BackColor = "Transparent"
				$cbxPromptToOverwriteViews.Checked = $true
				$cbxPromptToOverwriteViews.Anchor = "Left,Top"
				$grpSelectedSyncOptions.Controls.Add($cbxPromptToOverwriteViews)
			}


		# Add the Selected Models label
		If (!($lblSelectedModels)) 
			{
				$lblSelectedModels = New-Object System.Windows.Forms.Label
				$lblSelectedModels.Left = $grpSelectedSyncOptions.Left
				$lblSelectedModels.Top = $grpSelectedSyncOptions.Bottom + 20
				$lblSelectedModels.Width = 200
				$lblSelectedModels.TextAlign = "MiddleLeft"
				$lblSelectedModels.Text = "Models to Sync"
				$lblSelectedModels.ForeColor = "Blue"
				# $lblSelectedModels.Font = New-Object System.Drawing.Font("Arial",10)
				$lblSelectedModels.Anchor = "Top,Left,Right"
				$frmSyncSelected.Controls.Add($lblSelectedModels)
			}


		# Add the Selected Models CheckedListBox
		If (!($clbxSelectedModels)) 
			{
				$clbxSelectedModels = New-Object System.Windows.Forms.CheckedListBox
				$clbxSelectedModels.Left = $lblSelectedModels.Left
				$clbxSelectedModels.Top = $lblSelectedModels.Bottom
				$clbxSelectedModels.Width = ($frmSyncSelected.Width - 55) * .33
				$clbxSelectedModels.Height = 280
				$clbxSelectedModels.ForeColor = "Black"
				$clbxSelectedModels.CheckOnClick = $true
				$clbxSelectedModels.Sorted = $true
				# $clbxSelectedModels.Font = New-Object System.Drawing.Font("Arial",10)
				$clbxSelectedModels.Anchor = "Top,Left,Right"
				$clbxSelectedModels.Add_SelectedValueChanged({

					# If the last selected item was the 'Select All' box, check/uncheck as directed
					If ($clbxSelectedModels.SelectedItem -eq $strSelectAllText)
						{
							# Get a list of checked and all items
							[array]$arrCurrentlyCheckedModels = $clbxSelectedModels.CheckedItems
							[array]$arrAllListedModels = $clbxSelectedModels.Items

							# If the 'Select All' text is in the list of Checked Item, check all items
							If ($strSelectAllText -in $arrCurrentlyCheckedModels)
								{
									# Select All was checked so check all items
									ForEach ($objModel in $arrAllListedModels)
										{
											$clbxSelectedModels.SetItemChecked($clbxSelectedModels.Items.IndexOf($objModel), $true)
										}
								}
								Else
									{
										# Select All was unchecked so uncheck all items
										ForEach ($objModel in $arrAllListedModels)
											{
												$clbxSelectedModels.SetItemChecked($clbxSelectedModels.Items.IndexOf($objModel), $false)
											}
									}

							Remove-Variable objModel -ErrorAction SilentlyContinue
						}
						Else
							{
								# If the number of checked items is greater than or equal to the total number of items minus 1 (to account for 'Select All' being unchecked) and 'Select All' is not already checked, check the 'Select All' box.  If not, uncheck the 'Select All Box
								If ($clbxSelectedModels.CheckedItems.Count -ge $clbxSelectedModels.Items.Count - 1 -and $strSelectAllText -notin $clbxSelectedModels.CheckedItems)
									{
										$clbxSelectedModels.SetItemChecked($clbxSelectedModels.Items.IndexOf($strSelectAllText), $true)
									}
									Else
										{
											$clbxSelectedModels.SetItemChecked($clbxSelectedModels.Items.IndexOf($strSelectAllText), $false)
										}
							}
				})
				$frmSyncSelected.Controls.Add($clbxSelectedModels)
			}
	

		# Add the Selected Model Groups label
		If (!($lblSelectedModelGroups)) 
			{
				$lblSelectedModelGroups = New-Object System.Windows.Forms.Label
				$lblSelectedModelGroups.Left = $clbxSelectedModels.Right + 10
				$lblSelectedModelGroups.Top = $lblSelectedModels.Top
				$lblSelectedModelGroups.Width = $lblSelectedModels.Width
				$lblSelectedModelGroups.TextAlign = "MiddleLeft"
				$lblSelectedModelGroups.Text = "Model Groups to Sync"
				$lblSelectedModelGroups.ForeColor = "Blue"
				# $lblSelectedModelGroups.Font = New-Object System.Drawing.Font("Arial",10)
				$lblSelectedModelGroups.Anchor = "Top,Left,Right"
				$frmSyncSelected.Controls.Add($lblSelectedModelGroups)
			}
			
		# Add the Selected Model Groups CheckedListBox
		If (!($clbxSelectedModelGroups)) 
			{
				$clbxSelectedModelGroups = New-Object System.Windows.Forms.CheckedListBox
				$clbxSelectedModelGroups.Left = $lblSelectedModelGroups.Left
				$clbxSelectedModelGroups.Top = $lblSelectedModelGroups.Bottom
				$clbxSelectedModelGroups.Width = $clbxSelectedModels.Width
				$clbxSelectedModelGroups.Height = $clbxSelectedModels.Height
				$clbxSelectedModelGroups.ForeColor = "Black"
				$clbxSelectedModelGroups.CheckOnClick = $true
				$clbxSelectedModelGroups.Sorted = $true
				# $clbxSelectedModelGroups.Font = New-Object System.Drawing.Font("Arial",10)
				$clbxSelectedModelGroups.Anchor = "Top,Left,Right"
				$clbxSelectedModelGroups.Add_SelectedValueChanged({

					# If the last selected item was the 'Select All' box, check/uncheck as directed
					If ($clbxSelectedModelGroups.SelectedItem -eq $strSelectAllText)
						{
							# Get a list of checked and all items
							[array]$arrCurrentlyCheckedModelGroups = $clbxSelectedModelGroups.CheckedItems
							[array]$arrAllListedModelGroups = $clbxSelectedModelGroups.Items

							# If the 'Select All' text is in the list of Checked Item, check all items
							If ($strSelectAllText -in $arrCurrentlyCheckedModelGroups)
								{
									# Select All was checked so check all items
									ForEach ($objModelGroup in $arrAllListedModelGroups)
										{
											$clbxSelectedModelGroups.SetItemChecked($clbxSelectedModelGroups.Items.IndexOf($objModelGroup), $true)
										}
								}
								Else
									{
										# Select All was unchecked so uncheck all items
										ForEach ($objModelGroup in $arrAllListedModelGroups)
											{
												$clbxSelectedModelGroups.SetItemChecked($clbxSelectedModelGroups.Items.IndexOf($objModelGroup), $false)
											}
									}

							Remove-Variable objModelGroup -ErrorAction SilentlyContinue
						}
						Else
							{
								# If the number of checked items is greater than or equal to the total number of items minus 1 (to account for 'Select All' being unchecked) and 'Select All' is not already checked, check the 'Select All' box.  If not, uncheck the 'Select All Box
								If ($clbxSelectedModelGroups.CheckedItems.Count -ge $clbxSelectedModelGroups.Items.Count - 1 -and $strSelectAllText -notin $clbxSelectedModelGroups.CheckedItems)
									{
										$clbxSelectedModelGroups.SetItemChecked($clbxSelectedModelGroups.Items.IndexOf($strSelectAllText), $true)
									}
									Else
										{
											$clbxSelectedModelGroups.SetItemChecked($clbxSelectedModelGroups.Items.IndexOf($strSelectAllText), $false)
										}
							}
				})
				$frmSyncSelected.Controls.Add($clbxSelectedModelGroups)
			}


		# Add the Selected View label
		If (!($lblSelectedViews)) 
			{
				$lblSelectedViews = New-Object System.Windows.Forms.Label
				$lblSelectedViews.Left = $clbxSelectedModelGroups.Right + 10
				$lblSelectedViews.Top = $lblSelectedModels.Top
				$lblSelectedViews.Width = $lblSelectedModels.Width
				$lblSelectedViews.TextAlign = "MiddleLeft"
				$lblSelectedViews.Text = "Views To Sync"
				$lblSelectedViews.ForeColor = "Blue"
				# $lblSelectedViews.Font = New-Object System.Drawing.Font("Arial",10)
				$lblSelectedViews.Anchor = "Top,Left,Right"
				$frmSyncSelected.Controls.Add($lblSelectedViews)
			}

		# Add the Selected Views CheckedListBox
		If (!($clbxSelectedViews)) 
			{
				$clbxSelectedViews = New-Object System.Windows.Forms.CheckedListBox
				$clbxSelectedViews.Left = $lblSelectedViews.Left
				$clbxSelectedViews.Top = $lblSelectedViews.Bottom
				$clbxSelectedViews.Width = $clbxSelectedModels.Width
				$clbxSelectedViews.Height = $clbxSelectedModels.Height
				$clbxSelectedViews.ForeColor = "Black"
				$clbxSelectedViews.Sorted = $true
				$clbxSelectedViews.CheckOnClick = $true
				# $clbxSelectedViews.Font = New-Object System.Drawing.Font("Arial",10)
				$clbxSelectedViews.Anchor = "Top,Left,Right"
				$clbxSelectedViews.Add_SelectedValueChanged({

						# If the last selected item was the 'Select All' box, check/uncheck as directed
						If ($clbxSelectedViews.SelectedItem -eq $strSelectAllText)
							{
								# Get a list of checked and all items
								[array]$arrCurrentlyCheckedViews = $clbxSelectedViews.CheckedItems
								[array]$arrAllListedViews = $clbxSelectedViews.Items

								# If the 'Select All' text is in the list of Checked Item, check all items
								If ($strSelectAllText -in $arrCurrentlyCheckedViews)
									{
										# Select All was checked so check all items
										ForEach ($objView in $arrAllListedViews)
											{
												$clbxSelectedViews.SetItemChecked($clbxSelectedViews.Items.IndexOf($objView), $true)
											}
									}
									Else
										{
											# Select All was unchecked so uncheck all items
											ForEach ($objView in $arrAllListedViews)
												{
													$clbxSelectedViews.SetItemChecked($clbxSelectedViews.Items.IndexOf($objView), $false)
												}
										}

								Remove-Variable objView -ErrorAction SilentlyContinue
							}
							Else
								{
									# If the number of checked items is greater than or equal to the total number of items minus 1 (to account for 'Select All' being unchecked) and 'Select All' is not already checked, check the 'Select All' box.  If not, uncheck the 'Select All Box
									If ($clbxSelectedViews.CheckedItems.Count -ge $clbxSelectedViews.Items.Count - 1 -and $strSelectAllText -notin $clbxSelectedViews.CheckedItems)
										{
											$clbxSelectedViews.SetItemChecked($clbxSelectedViews.Items.IndexOf($strSelectAllText), $true)
										}
										Else
											{
												$clbxSelectedViews.SetItemChecked($clbxSelectedViews.Items.IndexOf($strSelectAllText), $false)
											}
								}
					})
				$frmSyncSelected.Controls.Add($clbxSelectedViews)
			}		


		# Clear the List Boxes
		$clbxSelectedModels.Items.Clear()
		$clbxSelectedModelGroups.Items.Clear()
		$clbxSelectedViews.Items.Clear()
		

		# Load the list boxes
		LogWrite "VERBOSE" "Load xLights Models into Selected Models"

		# Get the list of models from xLights
		If ($strActiveInactiveAll -eq "Active") {$objxLightsModels = $objxLightsEffects.xrgb.models.ChildNodes | Where-Object {$_.Active -ne "0"}}
			ElseIf ($strActiveInactiveAll -eq "Inactive") {$objxLightsModels = $objxLightsEffects.xrgb.models.ChildNodes | Where-Object {$_.Active -eq "0"}}
				Else {$objxLightsModels = $objxLightsEffects.xrgb.models.ChildNodes}
		
		# Load each model into the list box
		LogWrite "VERBOSE" "Found $(($objxLightsEffects.xrgb.models.model.Count)) Models to Load"
		
		If ($objxLightsModels.Count -ge 1)
			{
				$clbxSelectedModels.Items.Add($strSelectAllText)

				$objxLightsModels | ForEach-Object {
						
					If ($_.name)
						{
							LogWrite "DEBUG" "Loading ""$($_.name)"""
						
							$clbxSelectedModels.Items.Add($_.name)
						}
					}
			}
			Else
				{
					$clbxSelectedModels.Items.Add("- No Models Are Available in xLights -")
					$clbxSelectedModels.Enabled = $false
				}


		LogWrite "VERBOSE" "Load xLights Model Groups into Selected Model Groups"

		# Get the list of model groups from xLights
		If ($strActiveInactiveAll -eq "Active") {$objxLightsModelGroups = $objxLightsEffects.xrgb.modelGroups.ChildNodes}
			ElseIf ($strActiveInactiveAll -eq "Inactive") {$objxLightsModelGroups = $objxLightsEffects.xrgb.modelGroups.ChildNodes}
				Else {$objxLightsModelGroups = $objxLightsEffects.xrgb.modelGroups.ChildNodes}
		
		# Load each model group into the list box
		LogWrite "VERBOSE" "Found $(($objxLightsEffects.xrgb.modelGroups.modelGroup.Count)) Model Groups to Load"

		If ($objxLightsModelGroups.Count -ge 1)
			{
				$clbxSelectedModelGroups.Items.Add($strSelectAllText)
				
				$objxLightsModelGroups | ForEach-Object {
						
						If ($_.name)
							{
								LogWrite "DEBUG" "Loading ""$($_.name)"""
								
								$clbxSelectedModelGroups.Items.Add($_.name)
							}
					}
			}
			Else
				{
					$clbxSelectedModelGroups.Items.Add("- No Model Groups Are Available in xLights -")
					$clbxSelectedModelGroups.Enabled = $false
				}


		LogWrite "VERBOSE" "Load xLights Views into Selected Views"

		# Get the list of views from xLights
		If ($strActiveInactiveAll -eq "Active") {$objxLightsViews = $objxLightsEffects.xrgb.views.ChildNodes}
			ElseIf ($strActiveInactiveAll -eq "Inactive") {$objxLightsViews = $objxLightsEffects.xrgb.views.ChildNodes}
				Else {$objxLightsViews = $objxLightsEffects.xrgb.views.ChildNodes}
		
		# Load each view into the list box
		LogWrite "VERBOSE" "Found $(($objxLightsEffects.xrgb.views.view.Count)) Views to Load"

		If ($objxLightsViews.Count -ge 1)
			{
				$clbxSelectedViews.Items.Add($strSelectAllText)
				
				$objxLightsViews | ForEach-Object {
						
						If ($_.name)
							{
								LogWrite "DEBUG" "Loading ""$($_.name)"""
						
								$clbxSelectedViews.Items.Add($_.name)
							}
					}
			}
			Else
				{
					$clbxSelectedViews.Items.Add("- No Views Are Available in xLights -")
					$clbxSelectedViews.Enabled = $false
				}
		

		
		# Add the Sync button
		If (!($btnSyncSelected)) 
			{
				$btnSyncSelected = New-Object System.Windows.Forms.Button
				$btnSyncSelected.Width = $frmSyncSelected.Width * .1
				$btnSyncSelected.Left = $frmSyncSelected.Width - ($btnSyncSelected.Width * 2) - 50
				$btnSyncSelected.Top = $frmSyncSelected.Height - $btnSyncSelected.Height - 50
				$btnSyncSelected.Forecolor = "White"
				$btnSyncSelected.BackColor = "Green"
				$btnSyncSelected.Text = "Start Sync"
				$btnSyncSelected.Anchor = "Bottom,Right"
				$btnSyncSelected.Cursor = "Hand"
				$btnSyncSelected.Add_Click({
				
						# Get the list of checked items (minus the Select All item)
						$arrSelectedModels = $clbxSelectedModels.CheckedItems | Where-Object {$_ -ne "- Select All -"}
						$arrSelectedModelGroups = $clbxSelectedModelGroups.CheckedItems | Where-Object {$_ -ne "- Select All -"}
						$arrSelectedViews = $clbxSelectedViews.CheckedItems | Where-Object {$_ -ne "- Select All -"}

						# Run the Sync routine against each list
						If ($arrSelectedModels.Count -ge 1) {SyncxLightsToLayout -strLayoutName $strLayoutName -strNodeType "Model" -arrNodeNames $arrSelectedModels -boolOnlySyncExisting $false -boolOverridePrompts $cbxPromptToOverwriteModels.Checked} Else {LogWrite "VERBOSE" "No Models Selected For Sync"}
						If ($arrSelectedModelGroups.Count -ge 1) {SyncxLightsToLayout -strLayoutName $strLayoutName -strNodeType "ModelGroup" -arrNodeNames $arrSelectedModelGroups -boolOnlySyncExisting $false -boolOverridePrompts $cbxPromptToOverwriteModelGroups.Checked} Else {LogWrite "VERBOSE" "No Model Groups Selected For Sync"}
						If ($arrSelectedViews.Count -ge 1) {SyncxLightsToLayout -strLayoutName $strLayoutName -strNodeType "View" -arrNodeNames $arrSelectedViews -boolOnlySyncExisting $false -boolOverridePrompts $cbxPromptToOverwriteViews.Checked} Else {LogWrite "VERBOSE" "No Views Selected For Sync"}

						# Close the Sync Selected form
						$frmSyncSelected.Close()

						# If Sync to Repository, reload the Repository list boxes
						If ($cbxSyncToRepository.Checked -eq $true)
						{
							LoadRepositoryResourcesFromCompanionXML -strNodeType "Model" -boolLoadListboxes $true -boolCheckForUpdates $false
							LoadRepositoryResourcesFromCompanionXML -strNodeType "ModelGroup" -boolLoadListboxes $true -boolCheckForUpdates $false
							LoadRepositoryResourcesFromCompanionXML -strNodeType "View" -boolLoadListboxes $true -boolCheckForUpdates $false
						}

						# If a layout is selected, reload the models
						If ($lbxLayouts.SelectedItem)
							{
								LoadLayoutResourcesFromCompanionXML -strLayoutName $lbxLayouts.SelectedItem -strNodeType "Model"
								LoadLayoutResourcesFromCompanionXML -strLayoutName $lbxLayouts.SelectedItem -strNodeType "ModelGroup"
								LoadLayoutResourcesFromCompanionXML -strLayoutName $lbxLayouts.SelectedItem -strNodeType "View"
							}

						# The layouts shouldn't be reloaded or enabled until the Save Layout process has run
						# # Load the Companion layouts
						# LoadLayoutsFromCompanionXML

						# Enable the Layouts panel
						# ModifyPanels "Enable" "Layouts" 

						# # Disable Sync From
						# ModifyPanels "Disable" "SyncFrom"
						
						$cbxSyncToRepository.ForeColor = "Black"
													
					})
				$frmSyncSelected.Controls.Add($btnSyncSelected)
			}
				
		# Add the Cancel button
		If (!($btnCancelSyncSelected)) 
			{
				$btnCancelSyncSelected = New-Object Windows.Forms.Button
				$btnCancelSyncSelected.Width = $btnSyncSelected.Width
				$btnCancelSyncSelected.Left = $btnSyncSelected.Right + 10
				$btnCancelSyncSelected.Top = $btnSyncSelected.Top
				$btnCancelSyncSelected.Text = "Cancel"
				$btnCancelSyncSelected.TextAlign = "MiddleCenter"
				$btnCancelSyncSelected.Cursor = "Hand"
				$btnCancelSyncSelected.ForeColor = "White"
				$btnCancelSyncSelected.BackColor = "Red"
				$btnCancelSyncSelected.Anchor = "Bottom,Right"
				$btnCancelSyncSelected.Add_Click({
						
						# Prompt to close
						$frmSyncSelected.Close()
					})
				$frmSyncSelected.Controls.Add($btnCancelSyncSelected)
			}
		
		# Show the form
		$frmSyncSelected.ShowDialog()
	
	}


Function ShowComparisonForm ($strNodeType, $strNodeName, $strSource, $strTarget, $objSourceNodeXML, $objTargetNodeXML, $boolOverridePrompts, $boolPromptOnNewModels)
	{
		LogWrite "DEBUG" "Show the $strNodeType Comparison Form"

		Switch ($strNodeType)
			{
				"Model" {}
				"ModelGroup" {}
				"View" {}
				default
					{
						LogWrite "WARNING" "$strNodeType is not a valid node type so no comparison can be made"
						$frmComparison.Close()
					}
			}
	
		# Draw the form
		If (!($frmComparison)) 
			{
				$frmComparison = New-Object System.Windows.Forms.Form
				$frmComparison.BackColor = "LightBlue"
				$frmComparison.Text = "$(If ($strNodeType -eq "ModelGroup") {"Model Group"} Else {$strNodeType}) Comparison"
				$frmComparison.Width = $objForm.Width * .7
				$frmComparison.Height = $objForm.Height * .7
				$frmComparison.StartPosition = "CenterScreen" # CenterScreen, Manual, WindowsDefaultLocation, WindowsDefaultBounds, CenterParent
				$frmComparison.ControlBox = $false # Show/hide the Min/Max/X buttons in the rop right corner of the window. If this is $false, the Minimize and Maximize buttons will be hidden, regardless of the settings below
				$frmComparison.MinimizeBox = $false
				$frmComparison.MaximizeBox = $false
				#$frmComparison.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::DPI
				$frmComparison.FormBorderStyle = "Fixed3D" # None, Fixed3D, FixedSingle
				$frmComparison.Topmost = $true  
				$objIcon = [system.drawing.icon]::ExtractAssociatedIcon($strFormIconPath)
				$frmComparison.Icon = $objIcon
				$frmComparison.Add_Shown({
						# Set what should happen the first time the form is shown
						$frmComparison.Activate()
						$lblComparisonFormHeader.Select()
					})
				$frmComparison.Add_Closed({
						# Try to close the On Screen Keyboard
						Try 
							{
							} Catch {}
					})
			}


		# Add Header label
		If (!($lblComparisonFormHeader)) 
			{
				$lblComparisonFormHeader = New-Object System.Windows.Forms.Label
				$lblComparisonFormHeader.Left = 5
				$lblComparisonFormHeader.Top = 5
				$lblComparisonFormHeader.Width = $frmComparison.Width - 10
				$lblComparisonFormHeader.Height = 25
				$lblComparisonFormHeader.TextAlign = "TopCenter"
				$lblComparisonFormHeader.Text = "- Select the $(If ($strNodeType -eq "ModelGroup") {"Model Group"} Else {$strNodeType}) to Save in $strTarget -"
				$lblComparisonFormHeader.ForeColor = "Blue"
				$lblComparisonFormHeader.Font = New-Object System.Drawing.Font("Arial",16)
				$lblComparisonFormHeader.Anchor = "Top,Left,Right"
				$frmComparison.Controls.Add($lblComparisonFormHeader)
			}

		
		# Add Sub Header label
		If (!($lblComparisonFormSubHeader)) 
			{
				$lblComparisonFormSubHeader = New-Object System.Windows.Forms.Label
				$lblComparisonFormSubHeader.Left = 5
				$lblComparisonFormSubHeader.Top = $lblComparisonFormHeader.Bottom + 3
				$lblComparisonFormSubHeader.Width = $frmComparison.Width - 10
				$lblComparisonFormSubHeader.Height = 25
				$lblComparisonFormSubHeader.TextAlign = "TopCenter"
				$lblComparisonFormSubHeader.Text = "Note: xLights sometimes recreates a node, which causes a mismatch, so no actual changes may be visible. In this case, saving the xLights version is recommended."
				$lblComparisonFormSubHeader.ForeColor = "Blue"
				$lblComparisonFormSubHeader.Font = New-Object System.Drawing.Font("Arial",10)
				$lblComparisonFormSubHeader.Anchor = "Top,Left,Right"
				$frmComparison.Controls.Add($lblComparisonFormSubHeader)
			}


		# Add Footer label
		If (!($lblComparisonFormFooter)) 
			{
				$lblComparisonFormFooter = New-Object System.Windows.Forms.Label
				$lblComparisonFormFooter.Left = 10
				$lblComparisonFormFooter.Top = $frmComparison.Height - $lblComparisonFormFooter.Height - 50
				$lblComparisonFormFooter.Width = $frmComparison.Width - 10
				$lblComparisonFormFooter.Height = 25
				$lblComparisonFormFooter.TextAlign = "MiddleLeft"
				$lblComparisonFormFooter.Text = "Note: This form shows common properties but other properties may be mismatched"
				$lblComparisonFormFooter.ForeColor = "DarkRed"
				$lblComparisonFormFooter.Font = New-Object System.Drawing.Font("Arial",10)
				$lblComparisonFormFooter.Anchor = "Top,Left,Right"
				$frmComparison.Controls.Add($lblComparisonFormFooter)
			}

			


		##############################
		# Source Node Details
		##############################


		# Source Node Panel
		If (!($pnlComparisonSourceNode)) 
		{
			$pnlComparisonSourceNode = New-Object System.Windows.Forms.Panel
			$pnlComparisonSourceNode.Name = "ComparisonSourcePanel"
			$pnlComparisonSourceNode.Width = $frmComparison.Width * .45
			$pnlComparisonSourceNode.Left = ($frmComparison.Right * .25) - ($pnlComparisonSourceNode.Width / 2)
			$pnlComparisonSourceNode.Top = $lblComparisonFormSubHeader.Bottom + 30
			$pnlComparisonSourceNode.Height = $frmComparison.Height * .65
			$pnlComparisonSourceNode.BackColor = "Azure"
			$pnlComparisonSourceNode.Anchor = "Top,Left,Right"
			$frmComparison.Controls.Add($pnlComparisonSourceNode)
		}

		# Add Source Node Name label
		If (!($lblSourceNodeName)) 
			{
				$lblSourceNodeName = New-Object System.Windows.Forms.Label
				$lblSourceNodeName.Left = 0
				$lblSourceNodeName.Top = 0
				$lblSourceNodeName.Width = $pnlComparisonSourceNode.Width
				$lblSourceNodeName.Height = 20
				$lblSourceNodeName.TextAlign = "TopCenter"
				$lblSourceNodeName.Text = $objSourceNodeXML.Name
				$lblSourceNodeName.ForeColor = "Blue"
				$lblSourceNodeName.Backcolor = "WhiteSmoke"
				$lblSourceNodeName.Font = New-Object System.Drawing.Font("Arial",12)
				$lblSourceNodeName.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($lblSourceNodeName)
			}
	

		# Add Source Node Attribute 1 Name TextBox
		If (!($txtSourceNodeAttribute1Name)) 
			{
				$txtSourceNodeAttribute1Name = New-Object System.Windows.Forms.TextBox
				$txtSourceNodeAttribute1Name.Left = 5
				$txtSourceNodeAttribute1Name.Top = $lblSourceNodeName.Bottom + 10
				$txtSourceNodeAttribute1Name.Width = $pnlComparisonSourceNode.Width * .45
				$txtSourceNodeAttribute1Name.Height = 20
				$txtSourceNodeAttribute1Name.BorderStyle = "None"
				$txtSourceNodeAttribute1Name.ReadOnly = $true
				$txtSourceNodeAttribute1Name.ReadOnly = $true
				$txtSourceNodeAttribute1Name.BackColor = $pnlComparisonSourceNode.BackColor
				$txtSourceNodeAttribute1Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtSourceNodeAttribute1Name.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($txtSourceNodeAttribute1Name)
			}

		# Add Source Node Attribute 1 Value TextBox
		If (!($txtSourceNodeAttribute1Value)) 
			{
				$txtSourceNodeAttribute1Value = New-Object System.Windows.Forms.TextBox
				$txtSourceNodeAttribute1Value.Left = $txtSourceNodeAttribute1Name.Right + 10
				$txtSourceNodeAttribute1Value.Top = $txtSourceNodeAttribute1Name.Top
				$txtSourceNodeAttribute1Value.Width = $pnlComparisonSourceNode.Width - $txtSourceNodeAttribute1Name.Right - 15
				$txtSourceNodeAttribute1Value.Height = 20
				$txtSourceNodeAttribute1Value.BorderStyle = "None"
				$txtSourceNodeAttribute1Value.ReadOnly = $true
				$txtSourceNodeAttribute1Value.BackColor = $pnlComparisonSourceNode.BackColor
				$txtSourceNodeAttribute1Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtSourceNodeAttribute1Value.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($txtSourceNodeAttribute1Value)
			}

		# Add Source Node Attribute 2 Name TextBox
		If (!($txtSourceNodeAttribute2Name)) 
			{
				$txtSourceNodeAttribute2Name = New-Object System.Windows.Forms.TextBox
				$txtSourceNodeAttribute2Name.Left = $txtSourceNodeAttribute1Name.Left
				$txtSourceNodeAttribute2Name.Top = $txtSourceNodeAttribute1Name.Bottom + 5
				$txtSourceNodeAttribute2Name.Width = $txtSourceNodeAttribute1Name.Width
				$txtSourceNodeAttribute2Name.Height = 20
				$txtSourceNodeAttribute2Name.BorderStyle = "None"
				$txtSourceNodeAttribute2Name.ReadOnly = $true
				$txtSourceNodeAttribute2Name.BackColor = $pnlComparisonSourceNode.BackColor
				$txtSourceNodeAttribute2Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtSourceNodeAttribute2Name.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($txtSourceNodeAttribute2Name)
			}

		# Add Source Node Attribute 2 Value TextBox
		If (!($txtSourceNodeAttribute2Value)) 
			{
				$txtSourceNodeAttribute2Value = New-Object System.Windows.Forms.TextBox
				$txtSourceNodeAttribute2Value.Left = $txtSourceNodeAttribute2Name.Right + 10
				$txtSourceNodeAttribute2Value.Top = $txtSourceNodeAttribute2Name.Top
				$txtSourceNodeAttribute2Value.Width = $txtSourceNodeAttribute1Value.Width
				$txtSourceNodeAttribute2Value.Height = 20
				$txtSourceNodeAttribute2Value.BorderStyle = "None"
				$txtSourceNodeAttribute2Value.ReadOnly = $true
				$txtSourceNodeAttribute2Value.BackColor = $pnlComparisonSourceNode.BackColor
				$txtSourceNodeAttribute2Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtSourceNodeAttribute2Value.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($txtSourceNodeAttribute2Value)
			}

		# Add Source Node Attribute 3 Name TextBox
		If (!($txtSourceNodeAttribute3Name)) 
			{
				$txtSourceNodeAttribute3Name = New-Object System.Windows.Forms.TextBox
				$txtSourceNodeAttribute3Name.Left = $txtSourceNodeAttribute1Name.Left
				$txtSourceNodeAttribute3Name.Top = $txtSourceNodeAttribute2Name.Bottom + 5
				$txtSourceNodeAttribute3Name.Width = $txtSourceNodeAttribute1Name.Width
				$txtSourceNodeAttribute3Name.Height = 20
				$txtSourceNodeAttribute3Name.BorderStyle = "None"
				$txtSourceNodeAttribute3Name.ReadOnly = $true
				$txtSourceNodeAttribute3Name.BackColor = $pnlComparisonSourceNode.BackColor
				$txtSourceNodeAttribute3Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtSourceNodeAttribute3Name.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($txtSourceNodeAttribute3Name)
			}
		
		
		# Add Source Node Attribute 3 Value TextBox
		If (!($txtSourceNodeAttribute3Value)) 
			{
				$txtSourceNodeAttribute3Value = New-Object System.Windows.Forms.TextBox
				$txtSourceNodeAttribute3Value.Left = $txtSourceNodeAttribute3Name.Right + 10
				$txtSourceNodeAttribute3Value.Top = $txtSourceNodeAttribute3Name.Top
				$txtSourceNodeAttribute3Value.Width = $txtSourceNodeAttribute1Value.Width
				$txtSourceNodeAttribute3Value.Height = 20
				$txtSourceNodeAttribute3Value.BorderStyle = "None"
				$txtSourceNodeAttribute3Value.ReadOnly = $true
				$txtSourceNodeAttribute3Value.BackColor = $pnlComparisonSourceNode.BackColor
				$txtSourceNodeAttribute3Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtSourceNodeAttribute3Value.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($txtSourceNodeAttribute3Value)
			}

		# Add Source Node Attribute 4 Name TextBox
		If (!($txtSourceNodeAttribute4Name)) 
			{
				$txtSourceNodeAttribute4Name = New-Object System.Windows.Forms.TextBox
				$txtSourceNodeAttribute4Name.Left = $txtSourceNodeAttribute1Name.Left
				$txtSourceNodeAttribute4Name.Top = $txtSourceNodeAttribute3Name.Bottom + 5
				$txtSourceNodeAttribute4Name.Width = $txtSourceNodeAttribute1Name.Width
				$txtSourceNodeAttribute4Name.Height = 20
				$txtSourceNodeAttribute4Name.BorderStyle = "None"
				$txtSourceNodeAttribute4Name.ReadOnly = $true
				$txtSourceNodeAttribute4Name.BackColor = $pnlComparisonSourceNode.BackColor
				$txtSourceNodeAttribute4Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtSourceNodeAttribute4Name.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($txtSourceNodeAttribute4Name)
			}
		
		
		# Add Source Node Attribute 4 Value TextBox
		If (!($txtSourceNodeAttribute4Value)) 
			{
				$txtSourceNodeAttribute4Value = New-Object System.Windows.Forms.TextBox
				$txtSourceNodeAttribute4Value.Left = $txtSourceNodeAttribute4Name.Right + 10
				$txtSourceNodeAttribute4Value.Top = $txtSourceNodeAttribute4Name.Top
				$txtSourceNodeAttribute4Value.Width = $txtSourceNodeAttribute1Value.Width
				$txtSourceNodeAttribute4Value.Height = 20
				$txtSourceNodeAttribute4Value.BorderStyle = "None"
				$txtSourceNodeAttribute4Value.ReadOnly = $true
				$txtSourceNodeAttribute4Value.BackColor = $pnlComparisonSourceNode.BackColor
				$txtSourceNodeAttribute4Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtSourceNodeAttribute4Value.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($txtSourceNodeAttribute4Value)
			}

		# Add Source Node Attribute 5 Name TextBox
		If (!($txtSourceNodeAttribute5Name)) 
			{
				$txtSourceNodeAttribute5Name = New-Object System.Windows.Forms.TextBox
				$txtSourceNodeAttribute5Name.Left = $txtSourceNodeAttribute1Name.Left
				$txtSourceNodeAttribute5Name.Top = $txtSourceNodeAttribute4Name.Bottom + 5
				$txtSourceNodeAttribute5Name.Width = $txtSourceNodeAttribute1Name.Width
				$txtSourceNodeAttribute5Name.Height = 20
				$txtSourceNodeAttribute5Name.BorderStyle = "None"
				$txtSourceNodeAttribute5Name.ReadOnly = $true
				$txtSourceNodeAttribute5Name.BackColor = $pnlComparisonSourceNode.BackColor
				$txtSourceNodeAttribute5Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtSourceNodeAttribute5Name.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($txtSourceNodeAttribute5Name)
			}
		
		
		# Add Source Node Attribute 5 Value TextBox
		If (!($txtSourceNodeAttribute5Value)) 
			{
				$txtSourceNodeAttribute5Value = New-Object System.Windows.Forms.TextBox
				$txtSourceNodeAttribute5Value.Left = $txtSourceNodeAttribute5Name.Right + 10
				$txtSourceNodeAttribute5Value.Top = $txtSourceNodeAttribute5Name.Top
				$txtSourceNodeAttribute5Value.Width = $txtSourceNodeAttribute1Value.Width
				$txtSourceNodeAttribute5Value.Height = 20
				$txtSourceNodeAttribute5Value.BorderStyle = "None"
				$txtSourceNodeAttribute5Value.ReadOnly = $true
				$txtSourceNodeAttribute5Value.BackColor = $pnlComparisonSourceNode.BackColor
				$txtSourceNodeAttribute5Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtSourceNodeAttribute5Value.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($txtSourceNodeAttribute5Value)
			}

		# Add Source Node Attribute 6 Name TextBox
		If (!($txtSourceNodeAttribute6Name)) 
			{
				$txtSourceNodeAttribute6Name = New-Object System.Windows.Forms.TextBox
				$txtSourceNodeAttribute6Name.Left = $txtSourceNodeAttribute1Name.Left
				$txtSourceNodeAttribute6Name.Top = $txtSourceNodeAttribute5Name.Bottom + 5
				$txtSourceNodeAttribute6Name.Width = $txtSourceNodeAttribute1Name.Width
				$txtSourceNodeAttribute6Name.Height = 20
				$txtSourceNodeAttribute6Name.BorderStyle = "None"
				$txtSourceNodeAttribute6Name.ReadOnly = $true
				$txtSourceNodeAttribute6Name.BackColor = $pnlComparisonSourceNode.BackColor
				$txtSourceNodeAttribute6Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtSourceNodeAttribute6Name.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($txtSourceNodeAttribute6Name)
			}
		
		
		# Add Source Node Attribute 6 Value TextBox
		If (!($txtSourceNodeAttribute6Value)) 
			{
				$txtSourceNodeAttribute6Value = New-Object System.Windows.Forms.TextBox
				$txtSourceNodeAttribute6Value.Left = $txtSourceNodeAttribute6Name.Right + 10
				$txtSourceNodeAttribute6Value.Top = $txtSourceNodeAttribute6Name.Top
				$txtSourceNodeAttribute6Value.Width = $txtSourceNodeAttribute1Value.Width
				$txtSourceNodeAttribute6Value.Height = 20
				$txtSourceNodeAttribute6Value.BorderStyle = "None"
				$txtSourceNodeAttribute6Value.ReadOnly = $true
				$txtSourceNodeAttribute6Value.BackColor = $pnlComparisonSourceNode.BackColor
				$txtSourceNodeAttribute6Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtSourceNodeAttribute6Value.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($txtSourceNodeAttribute6Value)
			}

		# Add Source Node Attribute 7 Name TextBox
		If (!($txtSourceNodeAttribute7Name)) 
			{
				$txtSourceNodeAttribute7Name = New-Object System.Windows.Forms.TextBox
				$txtSourceNodeAttribute7Name.Left = $txtSourceNodeAttribute1Name.Left
				$txtSourceNodeAttribute7Name.Top = $txtSourceNodeAttribute6Name.Bottom + 5
				$txtSourceNodeAttribute7Name.Width = $txtSourceNodeAttribute1Name.Width
				$txtSourceNodeAttribute7Name.Height = 20
				$txtSourceNodeAttribute7Name.BorderStyle = "None"
				$txtSourceNodeAttribute7Name.ReadOnly = $true
				$txtSourceNodeAttribute7Name.BackColor = $pnlComparisonSourceNode.BackColor
				$txtSourceNodeAttribute7Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtSourceNodeAttribute7Name.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($txtSourceNodeAttribute7Name)
			}
		
		
		# Add Source Node Attribute 7 Value TextBox
		If (!($txtSourceNodeAttribute7Value)) 
			{
				$txtSourceNodeAttribute7Value = New-Object System.Windows.Forms.TextBox
				$txtSourceNodeAttribute7Value.Left = $txtSourceNodeAttribute7Name.Right + 10
				$txtSourceNodeAttribute7Value.Top = $txtSourceNodeAttribute7Name.Top
				$txtSourceNodeAttribute7Value.Width = $txtSourceNodeAttribute1Value.Width
				$txtSourceNodeAttribute7Value.Height = 20
				$txtSourceNodeAttribute7Value.BorderStyle = "None"
				$txtSourceNodeAttribute7Value.ReadOnly = $true
				$txtSourceNodeAttribute7Value.BackColor = $pnlComparisonSourceNode.BackColor
				$txtSourceNodeAttribute7Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtSourceNodeAttribute7Value.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($txtSourceNodeAttribute7Value)
			}

		# Add Source Node Attribute 8 Name TextBox
		If (!($txtSourceNodeAttribute8Name)) 
			{
				$txtSourceNodeAttribute8Name = New-Object System.Windows.Forms.TextBox
				$txtSourceNodeAttribute8Name.Left = $txtSourceNodeAttribute1Name.Left
				$txtSourceNodeAttribute8Name.Top = $txtSourceNodeAttribute7Name.Bottom + 5
				$txtSourceNodeAttribute8Name.Width = $txtSourceNodeAttribute1Name.Width
				$txtSourceNodeAttribute8Name.Height = 20
				$txtSourceNodeAttribute8Name.BorderStyle = "None"
				$txtSourceNodeAttribute8Name.ReadOnly = $true
				$txtSourceNodeAttribute8Name.BackColor = $pnlComparisonSourceNode.BackColor
				$txtSourceNodeAttribute8Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtSourceNodeAttribute8Name.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($txtSourceNodeAttribute8Name)
			}
		
		
		# Add Source Node Attribute 8 Value TextBox
		If (!($txtSourceNodeAttribute8Value)) 
			{
				$txtSourceNodeAttribute8Value = New-Object System.Windows.Forms.TextBox
				$txtSourceNodeAttribute8Value.Left = $txtSourceNodeAttribute8Name.Right + 10
				$txtSourceNodeAttribute8Value.Top = $txtSourceNodeAttribute8Name.Top
				$txtSourceNodeAttribute8Value.Width = $txtSourceNodeAttribute1Value.Width
				$txtSourceNodeAttribute8Value.Height = 20
				$txtSourceNodeAttribute8Value.BorderStyle = "None"
				$txtSourceNodeAttribute8Value.ReadOnly = $true
				$txtSourceNodeAttribute8Value.BackColor = $pnlComparisonSourceNode.BackColor
				$txtSourceNodeAttribute8Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtSourceNodeAttribute8Value.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($txtSourceNodeAttribute8Value)
			}

		# Add Source Node Attribute 9 Name TextBox
		If (!($txtSourceNodeAttribute9Name)) 
			{
				$txtSourceNodeAttribute9Name = New-Object System.Windows.Forms.TextBox
				$txtSourceNodeAttribute9Name.Left = $txtSourceNodeAttribute1Name.Left
				$txtSourceNodeAttribute9Name.Top = $txtSourceNodeAttribute8Name.Bottom + 5
				$txtSourceNodeAttribute9Name.Width = $txtSourceNodeAttribute1Name.Width
				$txtSourceNodeAttribute9Name.Height = 20
				$txtSourceNodeAttribute9Name.BorderStyle = "None"
				$txtSourceNodeAttribute9Name.ReadOnly = $true
				$txtSourceNodeAttribute9Name.BackColor = $pnlComparisonSourceNode.BackColor
				$txtSourceNodeAttribute9Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtSourceNodeAttribute9Name.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($txtSourceNodeAttribute9Name)
			}
		
		
		# Add Source Node Attribute 9 Value TextBox
		If (!($txtSourceNodeAttribute9Value)) 
			{
				$txtSourceNodeAttribute9Value = New-Object System.Windows.Forms.TextBox
				$txtSourceNodeAttribute9Value.Left = $txtSourceNodeAttribute9Name.Right + 10
				$txtSourceNodeAttribute9Value.Top = $txtSourceNodeAttribute9Name.Top
				$txtSourceNodeAttribute9Value.Width = $txtSourceNodeAttribute1Value.Width
				$txtSourceNodeAttribute9Value.Height = 20
				$txtSourceNodeAttribute9Value.BorderStyle = "None"
				$txtSourceNodeAttribute9Value.ReadOnly = $true
				$txtSourceNodeAttribute9Value.BackColor = $pnlComparisonSourceNode.BackColor
				$txtSourceNodeAttribute9Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtSourceNodeAttribute9Value.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($txtSourceNodeAttribute9Value)
			}

		# Add Source Node Attribute 10 Name TextBox
		If (!($txtSourceNodeAttribute10Name)) 
			{
				$txtSourceNodeAttribute10Name = New-Object System.Windows.Forms.TextBox
				$txtSourceNodeAttribute10Name.Left = $txtSourceNodeAttribute1Name.Left
				$txtSourceNodeAttribute10Name.Top = $txtSourceNodeAttribute9Name.Bottom + 5
				$txtSourceNodeAttribute10Name.Width = $txtSourceNodeAttribute1Name.Width
				$txtSourceNodeAttribute10Name.Height = 20
				$txtSourceNodeAttribute10Name.BorderStyle = "None"
				$txtSourceNodeAttribute10Name.ReadOnly = $true
				$txtSourceNodeAttribute10Name.BackColor = $pnlComparisonSourceNode.BackColor
				$txtSourceNodeAttribute10Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtSourceNodeAttribute10Name.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($txtSourceNodeAttribute10Name)
			}
		
		# Add Source Node Attribute 10 Value TextBox
		If (!($txtSourceNodeAttribute10Value)) 
			{
				$txtSourceNodeAttribute10Value = New-Object System.Windows.Forms.TextBox
				$txtSourceNodeAttribute10Value.Left = $txtSourceNodeAttribute10Name.Right + 10
				$txtSourceNodeAttribute10Value.Top = $txtSourceNodeAttribute10Name.Top
				$txtSourceNodeAttribute10Value.Width = $txtSourceNodeAttribute1Value.Width
				$txtSourceNodeAttribute10Value.Height = 20
				$txtSourceNodeAttribute10Value.BorderStyle = "None"
				$txtSourceNodeAttribute10Value.ReadOnly = $true
				$txtSourceNodeAttribute10Value.BackColor = $pnlComparisonSourceNode.BackColor
				$txtSourceNodeAttribute10Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtSourceNodeAttribute10Value.Anchor = "Top,Left,Right"
				$pnlComparisonSourceNode.Controls.Add($txtSourceNodeAttribute10Value)
			}

		
		##############################
		# Target Node Details
		##############################


		# Target Node Panel
		If (!($pnlComparisonTargetNode)) 
		{
			$pnlComparisonTargetNode = New-Object System.Windows.Forms.Panel
			$pnlComparisonTargetNode.Name = "ComparisonSourceNodePanel"
			$pnlComparisonTargetNode.Width = $pnlComparisonSourceNode.Width
			$pnlComparisonTargetNode.Left = ($frmComparison.Right *.75) - ($pnlComparisonTargetNode.Width / 2) - 10
			$pnlComparisonTargetNode.Top = $pnlComparisonSourceNode.Top
			$pnlComparisonTargetNode.Height = $pnlComparisonSourceNode.Height
			$pnlComparisonTargetNode.BackColor = "Azure"
			$pnlComparisonTargetNode.Anchor = "Top,Left,Right"
			$frmComparison.Controls.Add($pnlComparisonTargetNode)
		}


		# Add Target Node Name label
		If (!($lblTargetNodeName)) 
			{
				$lblTargetNodeName = New-Object System.Windows.Forms.Label
				$lblTargetNodeName.Width = $lblSourceNodeName.Width
				$lblTargetNodeName.Left = $lblSourceNodeName.Left
				$lblTargetNodeName.Top = 0
				$lblTargetNodeName.Height = 20
				$lblTargetNodeName.TextAlign = $lblSourceNodeName.TextAlign
				$lblTargetNodeName.Text = $objTargetNodeXML.Name
				$lblTargetNodeName.ForeColor = "Blue"
				$lblTargetNodeName.BackColor = $lblSourceNodeName.BackColor
				$lblTargetNodeName.Font = New-Object System.Drawing.Font("Arial",12)
				$lblTargetNodeName.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($lblTargetNodeName)
			}
			

		# Add Target Node Attribute 1 Name TextBox
		If (!($txtTargetNodeAttribute1Name)) 
			{
				$txtTargetNodeAttribute1Name = New-Object System.Windows.Forms.TextBox
				$txtTargetNodeAttribute1Name.Width = $pnlComparisonTargetNode.Width * .45
				$txtTargetNodeAttribute1Name.Left = $txtSourceNodeAttribute1Name.Left
				$txtTargetNodeAttribute1Name.Top = $lblTargetNodeName.Bottom + 10
				$txtTargetNodeAttribute1Name.Height = 20
				$txtTargetNodeAttribute1Name.BorderStyle = "None"
				$txtTargetNodeAttribute1Name.ReadOnly = $true
				$txtTargetNodeAttribute1Name.BackColor = $pnlComparisonTargetNode.BackColor
				$txtTargetNodeAttribute1Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtTargetNodeAttribute1Name.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($txtTargetNodeAttribute1Name)
			}
			
		# Add Target Node Attribute 1 Value TextBox
		If (!($txtTargetNodeAttribute1Value)) 
			{
				$txtTargetNodeAttribute1Value = New-Object System.Windows.Forms.TextBox
				$txtTargetNodeAttribute1Value.Left = $txtTargetNodeAttribute1Name.Right + 10
				$txtTargetNodeAttribute1Value.Top = $txtTargetNodeAttribute1Name.Top
				$txtTargetNodeAttribute1Value.Width = $txtTargetNodeAttribute1Name.Width
				$txtTargetNodeAttribute1Value.Height = 20
				$txtTargetNodeAttribute1Value.BorderStyle = "None"
				$txtTargetNodeAttribute1Value.ReadOnly = $true
				$txtTargetNodeAttribute1Value.BackColor = $pnlComparisonTargetNode.BackColor
				$txtTargetNodeAttribute1Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtTargetNodeAttribute1Value.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($txtTargetNodeAttribute1Value)
			}

		# Add Target Node Attribute 2 Name TextBox
		If (!($txtTargetNodeAttribute2Name)) 
			{
				$txtTargetNodeAttribute2Name = New-Object System.Windows.Forms.Textbox
				$txtTargetNodeAttribute2Name.Left = $txtTargetNodeAttribute1Name.Left
				$txtTargetNodeAttribute2Name.Top = $txtTargetNodeAttribute1Name.Bottom + 5
				$txtTargetNodeAttribute2Name.Width = $txtTargetNodeAttribute1Name.Width
				$txtTargetNodeAttribute2Name.Height = 20
				$txtTargetNodeAttribute2Name.BorderStyle = "None"
				$txtTargetNodeAttribute2Name.ReadOnly = $true
				$txtTargetNodeAttribute2Name.BackColor = $pnlComparisonTargetNode.BackColor
				$txtTargetNodeAttribute2Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtTargetNodeAttribute2Name.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($txtTargetNodeAttribute2Name)
			}

		# Add Target Node Attribute 2 Value TextBox
		If (!($txtTargetNodeAttribute2Value)) 
			{
				$txtTargetNodeAttribute2Value = New-Object System.Windows.Forms.TextBox
				$txtTargetNodeAttribute2Value.Left = $txtTargetNodeAttribute2Name.Right + 10
				$txtTargetNodeAttribute2Value.Top = $txtTargetNodeAttribute2Name.Top
				$txtTargetNodeAttribute2Value.Width = $txtTargetNodeAttribute1Value.Width
				$txtTargetNodeAttribute2Value.Height = 20
				$txtTargetNodeAttribute2Value.BorderStyle = "None"
				$txtTargetNodeAttribute2Value.ReadOnly = $true
				$txtTargetNodeAttribute2Value.BackColor = $pnlComparisonTargetNode.BackColor
				$txtTargetNodeAttribute2Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtTargetNodeAttribute2Value.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($txtTargetNodeAttribute2Value)
			}

		# Add Target Node Attribute 3 Name TextBox
		If (!($txtTargetNodeAttribute3Name)) 
			{
				$txtTargetNodeAttribute3Name = New-Object System.Windows.Forms.TextBox
				$txtTargetNodeAttribute3Name.Left = $txtTargetNodeAttribute1Name.Left
				$txtTargetNodeAttribute3Name.Top = $txtTargetNodeAttribute2Name.Bottom + 5
				$txtTargetNodeAttribute3Name.Width = $txtTargetNodeAttribute1Name.Width
				$txtTargetNodeAttribute3Name.Height = 20
				$txtTargetNodeAttribute3Name.BorderStyle = "None"
				$txtTargetNodeAttribute3Name.ReadOnly = $true
				$txtTargetNodeAttribute3Name.BackColor = $pnlComparisonTargetNode.BackColor
				$txtTargetNodeAttribute3Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtTargetNodeAttribute3Name.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($txtTargetNodeAttribute3Name)
			}
		
		
		# Add Target Node Attribute 3 Value TextBox
		If (!($txtTargetNodeAttribute3Value)) 
			{
				$txtTargetNodeAttribute3Value = New-Object System.Windows.Forms.TextBox
				$txtTargetNodeAttribute3Value.Left = $txtTargetNodeAttribute3Name.Right + 10
				$txtTargetNodeAttribute3Value.Top = $txtTargetNodeAttribute3Name.Top
				$txtTargetNodeAttribute3Value.Width = $txtTargetNodeAttribute1Value.Width
				$txtTargetNodeAttribute3Value.Height = 20
				$txtTargetNodeAttribute3Value.BorderStyle = "None"
				$txtTargetNodeAttribute3Value.ReadOnly = $true
				$txtTargetNodeAttribute3Value.BackColor = $pnlComparisonTargetNode.BackColor
				$txtTargetNodeAttribute3Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtTargetNodeAttribute3Value.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($txtTargetNodeAttribute3Value)
			}

		# Add Target Node Attribute 4 Name TextBox
		If (!($txtTargetNodeAttribute4Name)) 
			{
				$txtTargetNodeAttribute4Name = New-Object System.Windows.Forms.TextBox
				$txtTargetNodeAttribute4Name.Left = $txtTargetNodeAttribute1Name.Left
				$txtTargetNodeAttribute4Name.Top = $txtTargetNodeAttribute3Name.Bottom + 5
				$txtTargetNodeAttribute4Name.Width = $txtTargetNodeAttribute1Name.Width
				$txtTargetNodeAttribute4Name.Height = 20
				$txtTargetNodeAttribute4Name.BorderStyle = "None"
				$txtTargetNodeAttribute4Name.ReadOnly = $true
				$txtTargetNodeAttribute4Name.BackColor = $pnlComparisonTargetNode.BackColor
				$txtTargetNodeAttribute4Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtTargetNodeAttribute4Name.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($txtTargetNodeAttribute4Name)
			}
		
		
		# Add Target Node Attribute 4 Value TextBox
		If (!($txtTargetNodeAttribute4Value)) 
			{
				$txtTargetNodeAttribute4Value = New-Object System.Windows.Forms.TextBox
				$txtTargetNodeAttribute4Value.Left = $txtTargetNodeAttribute4Name.Right + 10
				$txtTargetNodeAttribute4Value.Top = $txtTargetNodeAttribute4Name.Top
				$txtTargetNodeAttribute4Value.Width = $txtTargetNodeAttribute1Value.Width
				$txtTargetNodeAttribute4Value.Height = 20
				$txtTargetNodeAttribute4Value.BorderStyle = "None"
				$txtTargetNodeAttribute4Value.ReadOnly = $true
				$txtTargetNodeAttribute4Value.BackColor = $pnlComparisonTargetNode.BackColor
				$txtTargetNodeAttribute4Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtTargetNodeAttribute4Value.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($txtTargetNodeAttribute4Value)
			}

		# Add Target Node Attribute 5 Name TextBox
		If (!($txtTargetNodeAttribute5Name)) 
			{
				$txtTargetNodeAttribute5Name = New-Object System.Windows.Forms.TextBox
				$txtTargetNodeAttribute5Name.Left = $txtTargetNodeAttribute1Name.Left
				$txtTargetNodeAttribute5Name.Top = $txtTargetNodeAttribute4Name.Bottom + 5
				$txtTargetNodeAttribute5Name.Width = $txtTargetNodeAttribute1Name.Width
				$txtTargetNodeAttribute5Name.Height = 20
				$txtTargetNodeAttribute5Name.BorderStyle = "None"
				$txtTargetNodeAttribute5Name.ReadOnly = $true
				$txtTargetNodeAttribute5Name.BackColor = $pnlComparisonTargetNode.BackColor
				$txtTargetNodeAttribute5Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtTargetNodeAttribute5Name.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($txtTargetNodeAttribute5Name)
			}
		
		
		# Add Target Node Attribute 5 Value TextBox
		If (!($txtTargetNodeAttribute5Value)) 
			{
				$txtTargetNodeAttribute5Value = New-Object System.Windows.Forms.TextBox
				$txtTargetNodeAttribute5Value.Left = $txtTargetNodeAttribute5Name.Right + 10
				$txtTargetNodeAttribute5Value.Top = $txtTargetNodeAttribute5Name.Top
				$txtTargetNodeAttribute5Value.Width = $txtTargetNodeAttribute1Value.Width
				$txtTargetNodeAttribute5Value.Height = 20
				$txtTargetNodeAttribute5Value.BorderStyle = "None"
				$txtTargetNodeAttribute5Value.ReadOnly = $true
				$txtTargetNodeAttribute5Value.BackColor = $pnlComparisonTargetNode.BackColor
				$txtTargetNodeAttribute5Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtTargetNodeAttribute5Value.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($txtTargetNodeAttribute5Value)
			}

		# Add Target Node Attribute 6 Name TextBox
		If (!($txtTargetNodeAttribute6Name)) 
			{
				$txtTargetNodeAttribute6Name = New-Object System.Windows.Forms.TextBox
				$txtTargetNodeAttribute6Name.Left = $txtTargetNodeAttribute1Name.Left
				$txtTargetNodeAttribute6Name.Top = $txtTargetNodeAttribute5Name.Bottom + 5
				$txtTargetNodeAttribute6Name.Width = $txtTargetNodeAttribute1Name.Width
				$txtTargetNodeAttribute6Name.Height = 20
				$txtTargetNodeAttribute6Name.BorderStyle = "None"
				$txtTargetNodeAttribute6Name.ReadOnly = $true
				$txtTargetNodeAttribute6Name.BackColor = $pnlComparisonTargetNode.BackColor
				$txtTargetNodeAttribute6Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtTargetNodeAttribute6Name.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($txtTargetNodeAttribute6Name)
			}
		
		
		# Add Target Node Attribute 6 Value TextBox
		If (!($txtTargetNodeAttribute6Value)) 
			{
				$txtTargetNodeAttribute6Value = New-Object System.Windows.Forms.TextBox
				$txtTargetNodeAttribute6Value.Left = $txtTargetNodeAttribute6Name.Right + 10
				$txtTargetNodeAttribute6Value.Top = $txtTargetNodeAttribute6Name.Top
				$txtTargetNodeAttribute6Value.Width = $txtTargetNodeAttribute1Value.Width
				$txtTargetNodeAttribute6Value.Height = 20
				$txtTargetNodeAttribute6Value.BorderStyle = "None"
				$txtTargetNodeAttribute6Value.ReadOnly = $true
				$txtTargetNodeAttribute6Value.BackColor = $pnlComparisonTargetNode.BackColor
				$txtTargetNodeAttribute6Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtTargetNodeAttribute6Value.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($txtTargetNodeAttribute6Value)
			}

		# Add Target Node Attribute 7 Name TextBox
		If (!($txtTargetNodeAttribute7Name)) 
			{
				$txtTargetNodeAttribute7Name = New-Object System.Windows.Forms.TextBox
				$txtTargetNodeAttribute7Name.Left = $txtTargetNodeAttribute1Name.Left
				$txtTargetNodeAttribute7Name.Top = $txtTargetNodeAttribute6Name.Bottom + 5
				$txtTargetNodeAttribute7Name.Width = $txtTargetNodeAttribute1Name.Width
				$txtTargetNodeAttribute7Name.Height = 20
				$txtTargetNodeAttribute7Name.BorderStyle = "None"
				$txtTargetNodeAttribute7Name.ReadOnly = $true
				$txtTargetNodeAttribute7Name.BackColor = $pnlComparisonTargetNode.BackColor
				$txtTargetNodeAttribute7Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtTargetNodeAttribute7Name.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($txtTargetNodeAttribute7Name)
			}
		
		
		# Add Target Node Attribute 7 Value TextBox
		If (!($txtTargetNodeAttribute7Value)) 
			{
				$txtTargetNodeAttribute7Value = New-Object System.Windows.Forms.TextBox
				$txtTargetNodeAttribute7Value.Left = $txtTargetNodeAttribute7Name.Right + 10
				$txtTargetNodeAttribute7Value.Top = $txtTargetNodeAttribute7Name.Top
				$txtTargetNodeAttribute7Value.Width = $txtTargetNodeAttribute1Value.Width
				$txtTargetNodeAttribute7Value.Height = 20
				$txtTargetNodeAttribute7Value.BorderStyle = "None"
				$txtTargetNodeAttribute7Value.ReadOnly = $true
				$txtTargetNodeAttribute7Value.BackColor = $pnlComparisonTargetNode.BackColor
				$txtTargetNodeAttribute7Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtTargetNodeAttribute7Value.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($txtTargetNodeAttribute7Value)
			}

		# Add Target Node Attribute 8 Name TextBox
		If (!($txtTargetNodeAttribute8Name)) 
			{
				$txtTargetNodeAttribute8Name = New-Object System.Windows.Forms.TextBox
				$txtTargetNodeAttribute8Name.Left = $txtTargetNodeAttribute1Name.Left
				$txtTargetNodeAttribute8Name.Top = $txtTargetNodeAttribute7Name.Bottom + 5
				$txtTargetNodeAttribute8Name.Width = $txtTargetNodeAttribute1Name.Width
				$txtTargetNodeAttribute8Name.Height = 20
				$txtTargetNodeAttribute8Name.BorderStyle = "None"
				$txtTargetNodeAttribute8Name.ReadOnly = $true
				$txtTargetNodeAttribute8Name.BackColor = $pnlComparisonTargetNode.BackColor
				$txtTargetNodeAttribute8Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtTargetNodeAttribute8Name.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($txtTargetNodeAttribute8Name)
			}
		
		
		# Add Target Node Attribute 8 Value TextBox
		If (!($txtTargetNodeAttribute8Value)) 
			{
				$txtTargetNodeAttribute8Value = New-Object System.Windows.Forms.TextBox
				$txtTargetNodeAttribute8Value.Left = $txtTargetNodeAttribute8Name.Right + 10
				$txtTargetNodeAttribute8Value.Top = $txtTargetNodeAttribute8Name.Top
				$txtTargetNodeAttribute8Value.Width = $txtTargetNodeAttribute1Value.Width
				$txtTargetNodeAttribute8Value.Height = 20
				$txtTargetNodeAttribute8Value.BorderStyle = "None"
				$txtTargetNodeAttribute8Value.ReadOnly = $true
				$txtTargetNodeAttribute8Value.BackColor = $pnlComparisonTargetNode.BackColor
				$txtTargetNodeAttribute8Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtTargetNodeAttribute8Value.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($txtTargetNodeAttribute8Value)
			}

		# Add Target Node Attribute 9 Name TextBox
		If (!($txtTargetNodeAttribute9Name)) 
			{
				$txtTargetNodeAttribute9Name = New-Object System.Windows.Forms.TextBox
				$txtTargetNodeAttribute9Name.Left = $txtTargetNodeAttribute1Name.Left
				$txtTargetNodeAttribute9Name.Top = $txtTargetNodeAttribute8Name.Bottom + 5
				$txtTargetNodeAttribute9Name.Width = $txtTargetNodeAttribute1Name.Width
				$txtTargetNodeAttribute9Name.Height = 20
				$txtTargetNodeAttribute9Name.BorderStyle = "None"
				$txtTargetNodeAttribute9Name.ReadOnly = $true
				$txtTargetNodeAttribute9Name.BackColor = $pnlComparisonTargetNode.BackColor
				$txtTargetNodeAttribute9Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtTargetNodeAttribute9Name.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($txtTargetNodeAttribute9Name)
			}
		
		
		# Add Target Node Attribute 9 Value TextBox
		If (!($txtTargetNodeAttribute9Value)) 
			{
				$txtTargetNodeAttribute9Value = New-Object System.Windows.Forms.TextBox
				$txtTargetNodeAttribute9Value.Left = $txtTargetNodeAttribute9Name.Right + 10
				$txtTargetNodeAttribute9Value.Top = $txtTargetNodeAttribute9Name.Top
				$txtTargetNodeAttribute9Value.Width = $txtTargetNodeAttribute1Value.Width
				$txtTargetNodeAttribute9Value.Height = 20
				$txtTargetNodeAttribute9Value.BorderStyle = "None"
				$txtTargetNodeAttribute9Value.ReadOnly = $true
				$txtTargetNodeAttribute9Value.BackColor = $pnlComparisonTargetNode.BackColor
				$txtTargetNodeAttribute9Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtTargetNodeAttribute9Value.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($txtTargetNodeAttribute9Value)
			}

		# Add Target Node Attribute 10 Name TextBox
		If (!($txtTargetNodeAttribute10Name)) 
			{
				$txtTargetNodeAttribute10Name = New-Object System.Windows.Forms.TextBox
				$txtTargetNodeAttribute10Name.Left = $txtTargetNodeAttribute1Name.Left
				$txtTargetNodeAttribute10Name.Top = $txtTargetNodeAttribute9Name.Bottom + 5
				$txtTargetNodeAttribute10Name.Width = $txtTargetNodeAttribute1Name.Width
				$txtTargetNodeAttribute10Name.Height = 20
				$txtTargetNodeAttribute10Name.BorderStyle = "None"
				$txtTargetNodeAttribute10Name.ReadOnly = $true
				$txtTargetNodeAttribute10Name.BackColor = $pnlComparisonTargetNode.BackColor
				$txtTargetNodeAttribute10Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtTargetNodeAttribute10Name.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($txtTargetNodeAttribute10Name)
			}
		
		# Add Target Node Attribute 10 Value TextBox
		If (!($txtTargetNodeAttribute10Value)) 
			{
				$txtTargetNodeAttribute10Value = New-Object System.Windows.Forms.TextBox
				$txtTargetNodeAttribute10Value.Left = $txtTargetNodeAttribute10Name.Right + 10
				$txtTargetNodeAttribute10Value.Top = $txtTargetNodeAttribute10Name.Top
				$txtTargetNodeAttribute10Value.Width = $txtTargetNodeAttribute1Value.Width
				$txtTargetNodeAttribute10Value.Height = 20
				$txtTargetNodeAttribute10Value.BorderStyle = "None"
				$txtTargetNodeAttribute10Value.ReadOnly = $true
				$txtTargetNodeAttribute10Value.BackColor = $pnlComparisonTargetNode.BackColor
				$txtTargetNodeAttribute10Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtTargetNodeAttribute10Value.Anchor = "Top,Left,Right"
				$pnlComparisonTargetNode.Controls.Add($txtTargetNodeAttribute10Value)
			}

		# Clear the text boxes
		$txtSourceNodeAttribute1Name.Text = ""
		$txtSourceNodeAttribute1Value.Text = ""
		$txtSourceNodeAttribute2Name.Text = ""
		$txtSourceNodeAttribute2Value.Text = ""
		$txtSourceNodeAttribute3Name.Text = ""
		$txtSourceNodeAttribute3Value.Text = ""
		$txtSourceNodeAttribute4Name.Text = ""
		$txtSourceNodeAttribute4Value.Text = ""
		$txtSourceNodeAttribute5Name.Text = ""
		$txtSourceNodeAttribute5Value.Text = ""
		$txtSourceNodeAttribute6Name.Text = ""
		$txtSourceNodeAttribute6Value.Text = ""
		$txtSourceNodeAttribute7Name.Text = ""
		$txtSourceNodeAttribute7Value.Text = ""
		$txtSourceNodeAttribute8Name.Text = ""
		$txtSourceNodeAttribute8Value.Text = ""
		$txtSourceNodeAttribute9Name.Text = ""
		$txtSourceNodeAttribute9Value.Text = ""
		$txtSourceNodeAttribute10Name.Text = ""
		$txtSourceNodeAttribute10Value.Text = ""
		$txtTargetNodeAttribute1Name.Text = ""
		$txtTargetNodeAttribute1Value.Text = ""
		$txtTargetNodeAttribute2Name.Text = ""
		$txtTargetNodeAttribute2Value.Text = ""
		$txtTargetNodeAttribute3Name.Text = ""
		$txtTargetNodeAttribute3Value.Text = ""
		$txtTargetNodeAttribute4Name.Text = ""
		$txtTargetNodeAttribute4Value.Text = ""
		$txtTargetNodeAttribute5Name.Text = ""
		$txtTargetNodeAttribute5Value.Text = ""
		$txtTargetNodeAttribute6Name.Text = ""
		$txtTargetNodeAttribute6Value.Text = ""
		$txtTargetNodeAttribute7Name.Text = ""
		$txtTargetNodeAttribute7Value.Text = ""
		$txtTargetNodeAttribute8Name.Text = ""
		$txtTargetNodeAttribute8Value.Text = ""
		$txtTargetNodeAttribute9Name.Text = ""
		$txtTargetNodeAttribute9Value.Text = ""
		$txtTargetNodeAttribute10Name.Text = ""
		$txtTargetNodeAttribute10Value.Text = ""
			
		# Change the name label color if they don't match
		If ($lblSourceNodeName.Text -ne $lblTargetNodeName.Text) {$lblSourceNodeName.ForeColor = "Red" ; $lblTargetNodeName.ForeColor = "Red"}

		Switch ($strNodeType)
			{
				"Model" 
					{
						# Populate the Source
						$txtSourceNodeAttribute1Name.Text = "Controller:"
						$txtSourceNodeAttribute1Value.Text = $objSourceNodeXML.Controller
						$txtSourceNodeAttribute2Name.Text = "Start Channel:"
						$txtSourceNodeAttribute2Value.Text = $objSourceNodeXML.StartChannel
						$txtSourceNodeAttribute3Name.Text = "Version Number:"
						$txtSourceNodeAttribute3Value.Text = $objSourceNodeXML.versionNumber
						$txtSourceNodeAttribute4Name.Text = "Submodel Count:"
						$txtSourceNodeAttribute4Value.Text = ($objSourceNodeXML.Submodels).Count
						$txtSourceNodeAttribute5Name.Text = "Pixel Size:"
						$txtSourceNodeAttribute5Value.Text = $objSourceNodeXML.PixelSize
						$txtSourceNodeAttribute6Name.Text = "Layout Group:"
						$txtSourceNodeAttribute6Value.Text = $objSourceNodeXML.LayoutGroup
						$txtSourceNodeAttribute7Name.Text = "Active:"
						$txtSourceNodeAttribute7Value.Text = If ($objSourceNodeXML.Active) {$objSourceNodeXML.Active} Else {"1"}
						$txtSourceNodeAttribute8Name.Text = "Location:"
						$txtSourceNodeAttribute8Value.Text = "$($objSourceNodeXML.WorldPosX) / $($objSourceNodeXML.WorldPosY) / $($objSourceNodeXML.WorldPosZ)"
						$txtSourceNodeAttribute9Name.Text = "Size:"
						$txtSourceNodeAttribute9Value.Text = "$($objSourceNodeXML.ScaleX) / $($objSourceNodeXML.ScaleY) / $($objSourceNodeXML.ScaleZ)"
						$txtSourceNodeAttribute10Name.Text = "Display As:"
						$txtSourceNodeAttribute10Value.Text = $objSourceNodeXML.DisplayAs


						# Populate the Target
						$txtTargetNodeAttribute1Name.Text = "Controller:"
						$txtTargetNodeAttribute1Value.Text = $objTargetNodeXML.Controller
						$txtTargetNodeAttribute2Name.Text = "Start Channel:"
						$txtTargetNodeAttribute2Value.Text = $objTargetNodeXML.StartChannel
						$txtTargetNodeAttribute3Name.Text = "Version Number:"
						$txtTargetNodeAttribute3Value.Text = $objTargetNodeXML.versionNumber
						$txtTargetNodeAttribute4Name.Text = "Submodel Count:"
						$txtTargetNodeAttribute4Value.Text = ($objTargetNodeXML.Submodels).Count
						$txtTargetNodeAttribute5Name.Text = "Pixel Size:"
						$txtTargetNodeAttribute5Value.Text = $objTargetNodeXML.PixelSize
						$txtTargetNodeAttribute6Name.Text = "Layout Group:"
						$txtTargetNodeAttribute6Value.Text = $objTargetNodeXML.LayoutGroup
						$txtTargetNodeAttribute7Name.Text = "Active:"
						$txtTargetNodeAttribute7Value.Text = If ($objTargetNodeXML.Active) {$objTargetNodeXML.Active} Else {"1"}
						$txtTargetNodeAttribute8Name.Text = "Location:"
						$txtTargetNodeAttribute8Value.Text = "$($objTargetNodeXML.WorldPosX) / $($objTargetNodeXML.WorldPosY) / $($objTargetNodeXML.WorldPosZ)"
						$txtTargetNodeAttribute9Name.Text = "Size:"
						$txtTargetNodeAttribute9Value.Text = "$($objTargetNodeXML.ScaleX) / $($objTargetNodeXML.ScaleY) / $($objTargetNodeXML.ScaleZ)"
						$txtTargetNodeAttribute10Name.Text = "Display As:"
						$txtTargetNodeAttribute10Value.Text = $objTargetNodeXML.DisplayAs


						# Change the colors if the values don't match
						If ($txtSourceNodeAttribute1Value.Text -ne $txtTargetNodeAttribute1Value.Text) {$txtSourceNodeAttribute1Value.ForeColor = "Red" ; $txtTargetNodeAttribute1Value.ForeColor = "Red"}
						If ($txtSourceNodeAttribute2Value.Text -ne $txtTargetNodeAttribute2Value.Text) {$txtSourceNodeAttribute2Value.ForeColor = "Red" ; $txtTargetNodeAttribute2Value.ForeColor = "Red"}
						If ($txtSourceNodeAttribute3Value.Text -ne $txtTargetNodeAttribute3Value.Text) {$txtSourceNodeAttribute3Value.ForeColor = "Red" ; $txtTargetNodeAttribute3Value.ForeColor = "Red"}
						If ($txtSourceNodeAttribute4Value.Text -ne $txtTargetNodeAttribute4Value.Text) {$txtSourceNodeAttribute4Value.ForeColor = "Red" ; $txtTargetNodeAttribute4Value.ForeColor = "Red"}
						If ($txtSourceNodeAttribute5Value.Text -ne $txtTargetNodeAttribute5Value.Text) {$txtSourceNodeAttribute5Value.ForeColor = "Red" ; $txtTargetNodeAttribute5Value.ForeColor = "Red"}
						If ($txtSourceNodeAttribute6Value.Text -ne $txtTargetNodeAttribute6Value.Text) {$txtSourceNodeAttribute6Value.ForeColor = "Red" ; $txtTargetNodeAttribute6Value.ForeColor = "Red"}
						If ($txtSourceNodeAttribute7Value.Text -ne $txtTargetNodeAttribute7Value.Text) {$txtSourceNodeAttribute7Value.ForeColor = "Red" ; $txtTargetNodeAttribute7Value.ForeColor = "Red"}
						If ($txtSourceNodeAttribute8Value.Text -ne $txtTargetNodeAttribute8Value.Text) {$txtSourceNodeAttribute8Value.ForeColor = "Red" ; $txtTargetNodeAttribute8Value.ForeColor = "Red"}
						If ($txtSourceNodeAttribute9Value.Text -ne $txtTargetNodeAttribute9Value.Text) {$txtSourceNodeAttribute9Value.ForeColor = "Red" ; $txtTargetNodeAttribute9Value.ForeColor = "Red"}
						If ($txtSourceNodeAttribute10Value.Text -ne $txtTargetNodeAttribute10Value.Text) {$txtSourceNodeAttribute10Value.ForeColor = "Red" ; $txtTargetNodeAttribute10Value.ForeColor = "Red"}

					}
				"ModelGroup" 
					{
						# Populate the Source
						$txtSourceNodeAttribute1Name.Text = "Grid Size:"
						$txtSourceNodeAttribute1Value.Text = $objSourceNodeXML.GridSize
						$txtSourceNodeAttribute2Name.Text = "X Offset:"
						$txtSourceNodeAttribute2Value.Text = $objSourceNodeXML.XCentreOffset
						$txtSourceNodeAttribute3Name.Text = "Y Offset:"
						$txtSourceNodeAttribute3Value.Text = $objSourceNodeXML.YCenterOffset
						$txtSourceNodeAttribute4Name.Text = "Assigned Layout:"
						$txtSourceNodeAttribute4Value.Text = $objSourceNodeXML.layout
						$txtSourceNodeAttribute5Name.Text = "Version Number:"
						$txtSourceNodeAttribute5Value.Text = $objSourceNodeXML.versionNumber
						$txtSourceNodeAttribute6Name.Text = "Tag Color:"
						$txtSourceNodeAttribute6Value.Text = $objSourceNodeXML.TagColour
						$txtSourceNodeAttribute7Name.Text = "Models in Group:"
						$txtSourceNodeAttribute7Value.Text = ($objSourceNodeXML.Models -split ",").Count
						
						
						# $txtSourceNodeAttribute8Value.Text = 
						# $txtSourceNodeAttribute9Name.Text = 
						# $txtSourceNodeAttribute9Value.Text = 
						# $txtSourceNodeAttribute10Name.Text = 
						# $txtSourceNodeAttribute10Value.Text = 
						

						# Populate the Target
						$txtTargetNodeAttribute1Name.Text = "Grid Size:"
						$txtTargetNodeAttribute1Value.Text = $objTargetNodeXML.GridSize
						$txtTargetNodeAttribute2Name.Text = "X Offset:"
						$txtTargetNodeAttribute2Value.Text = $objTargetNodeXML.XCentreOffset
						$txtTargetNodeAttribute3Name.Text = "Y Offset:"
						$txtTargetNodeAttribute3Value.Text = $objTargetNodeXML.YCenterOffset
						$txtTargetNodeAttribute4Name.Text = "Assigned Layout:"
						$txtTargetNodeAttribute4Value.Text = $objTargetNodeXML.layout
						$txtTargetNodeAttribute5Name.Text = "Version Number:"
						$txtTargetNodeAttribute5Value.Text = $objTargetNodeXML.versionNumber
						$txtTargetNodeAttribute6Name.Text = "Tag Color:"
						$txtTargetNodeAttribute6Value.Text = $objTargetNodeXML.TagColour
						$txtTargetNodeAttribute7Name.Text = "Models in Group:"
						$txtTargetNodeAttribute7Value.Text = ($objTargetNodeXML.Models -split ",").Count
						
						
						# $txtTargetNodeAttribute8Value.Text = 
						# $txtTargetNodeAttribute9Name.Text = 
						# $txtTargetNodeAttribute9Value.Text = 
						# $txtTargetNodeAttribute10Name.Text = 
						# $txtTargetNodeAttribute10Value.Text = 


						# If the model counts don't match, populate the text boxes with the models
						If (($objSourceNodeXML.Models -split ",").Count -ne ($objTargetNodeXML.Models -split ",").Count)
							{
								# Source
								$txtSourceNodeAttribute8Name.Width = $pnlComparisonSourceNode.Width - 15
								$txtSourceNodeAttribute8Name.Left = $txtSourceNodeAttribute8Name.Left + 5
								$txtSourceNodeAttribute8Name.Height = $pnlComparisonSourceNode.Height - 5 - $txtSourceNodeAttribute8Name.Top
								$txtSourceNodeAttribute8Name.Multiline = $true
								$txtSourceNodeAttribute8Name.WordWrap = $true
								$txtSourceNodeAttribute8Name.ScrollBars = "Vertical"
								$txtSourceNodeAttribute8Name.Text = $objSourceNodeXML.Models
								$txtSourceNodeAttribute8Name.BackColor = "LavenderBlush"

								# Target
								$txtTargetNodeAttribute8Name.Width = $pnlComparisonTargetNode.Width - 15
								$txtTargetNodeAttribute8Name.Left = $txtTargetNodeAttribute8Name.Left + 5
								$txtTargetNodeAttribute8Name.Height = $pnlComparisonTargetNode.Height - 5 - $txtTargetNodeAttribute8Name.Top
								$txtTargetNodeAttribute8Name.Multiline = $true
								$txtTargetNodeAttribute8Name.WordWrap = $true
								$txtTargetNodeAttribute8Name.ScrollBars = "Vertical"
								$txtTargetNodeAttribute8Name.Text = $objTargetNodeXML.Models
								$txtTargetNodeAttribute8Name.BackColor = "LavenderBlush"
							}
						

						# Change the colors if the values don't match
						If ($txtSourceNodeAttribute1Value.Text -ne $txtTargetNodeAttribute1Value.Text) {$txtSourceNodeAttribute1Value.ForeColor = "Red" ; $txtTargetNodeAttribute1Value.ForeColor = "Red"}
						If ($txtSourceNodeAttribute2Value.Text -ne $txtTargetNodeAttribute2Value.Text) {$txtSourceNodeAttribute2Value.ForeColor = "Red" ; $txtTargetNodeAttribute2Value.ForeColor = "Red"}
						If ($txtSourceNodeAttribute3Value.Text -ne $txtTargetNodeAttribute3Value.Text) {$txtSourceNodeAttribute3Value.ForeColor = "Red" ; $txtTargetNodeAttribute3Value.ForeColor = "Red"}
						If ($txtSourceNodeAttribute4Value.Text -ne $txtTargetNodeAttribute4Value.Text) {$txtSourceNodeAttribute4Value.ForeColor = "Red" ; $txtTargetNodeAttribute4Value.ForeColor = "Red"}
						If ($txtSourceNodeAttribute5Value.Text -ne $txtTargetNodeAttribute5Value.Text) {$txtSourceNodeAttribute5Value.ForeColor = "Red" ; $txtTargetNodeAttribute5Value.ForeColor = "Red"}
						If ($txtSourceNodeAttribute6Value.Text -ne $txtTargetNodeAttribute6Value.Text) {$txtSourceNodeAttribute6Value.ForeColor = "Red" ; $txtTargetNodeAttribute6Value.ForeColor = "Red"}
						If ($txtSourceNodeAttribute7Value.Text -ne $txtTargetNodeAttribute7Value.Text) {$txtSourceNodeAttribute7Value.ForeColor = "Red" ; $txtTargetNodeAttribute7Value.ForeColor = "Red"}
						

					}
				"View" 
					{
						# Populate the Source
						$txtSourceNodeAttribute1Name.Text = "Models in View:"
						$txtSourceNodeAttribute1Value.Text = ($objSourceNodeXML.Models -split ",").Count
						$txtSourceNodeAttribute2Name.Width = $pnlComparisonSourceNode.Width - 15
						$txtSourceNodeAttribute2Name.Left = $txtSourceNodeAttribute2Name.Left + 5
						$txtSourceNodeAttribute2Name.Height = $pnlComparisonSourceNode.Height - 5 - $txtSourceNodeAttribute2Name.Top
						$txtSourceNodeAttribute2Name.BackColor = "WhiteSmoke"
						$txtSourceNodeAttribute2Name.Multiline = $true
						$txtSourceNodeAttribute2Name.WordWrap = $true
						$txtSourceNodeAttribute2Name.ScrollBars = "Vertical"
						$txtSourceNodeAttribute2Name.Text = $objSourceNodeXML.Models

						# Populate the Target
						$txtTargetNodeAttribute1Name.Text = "Models in View:"
						$txtTargetNodeAttribute1Value.Text = ($objTargetNodeXML.Models -split ",").Count
						$txtTargetNodeAttribute2Name.Width = $pnlComparisonTargetNode.Width - 15
						$txtTargetNodeAttribute2Name.Left = $txtTargetNodeAttribute2Name.Left + 5
						$txtTargetNodeAttribute2Name.Height = $pnlComparisonTargetNode.Height - 5 - $txtTargetNodeAttribute2Name.Top
						$txtTargetNodeAttribute2Name.BackColor = "WhiteSmoke"
						$txtTargetNodeAttribute2Name.Multiline = $true
						$txtTargetNodeAttribute2Name.WordWrap = $true
						$txtTargetNodeAttribute2Name.ScrollBars = "Vertical"
						$txtTargetNodeAttribute2Name.Text = $objTargetNodeXML.Models

						
						# Change the background colors if the values don't match
						If ($txtSourceNodeAttribute1Value.Text -ne $txtTargetNodeAttribute1Value.Text) {$txtSourceNodeAttribute1Value.ForeColor = "Red" ; $txtTargetNodeAttribute1Value.ForeColor = "Red"}
						If ($txtSourceNodeAttribute2Name.Text -ne $txtTargetNodeAttribute2Name.Text) {$txtSourceNodeAttribute2Name.BackColor = "LavenderBlush" ; $txtTargetNodeAttribute2Name.BackColor = "LavenderBlush"}


					}
				default
					{
						LogWrite "WARNING" "Compare XML Node failed because Node Type ($strNodeType) is invalid."
						Return	
					}
			}




		# Add the Save Source Version button
		If (!($btnSaveSourceVersion)) 
			{
				$btnSaveSourceVersion = New-Object System.Windows.Forms.Button
				$btnSaveSourceVersion.Width = $frmComparison.Width * .2
				$btnSaveSourceVersion.Left = ($frmComparison.Width * .25) - ($btnSaveSourceVersion.Width / 2)
				$btnSaveSourceVersion.Top = $lblComparisonFormSubHeader.Bottom
				$btnSaveSourceVersion.Forecolor = "White"
				$btnSaveSourceVersion.BackColor = "Green"
				$btnSaveSourceVersion.Text = "Save $strSource Version"
				$btnSaveSourceVersion.Anchor = "Top,Left,Right"
				$btnSaveSourceVersion.Cursor = "Hand"
				$btnSaveSourceVersion.Add_Click({
				
						LogWrite "VERBOSE" "$strSource Version Will Be Saved"
						$script:strVersionToKeep = $strSource
						$frmComparison.Close()
					})
				$frmComparison.Controls.Add($btnSaveSourceVersion)
			}
				
		# Add the Save Target Version button
		If (!($btnSaveTargetVersion)) 
			{
				$btnSaveTargetVersion = New-Object System.Windows.Forms.Button
				$btnSaveTargetVersion.Width = $frmComparison.Width * .2
				$btnSaveTargetVersion.Left = ($frmComparison.Width * .75) - ($btnSaveTargetVersion.Width / 2) - 5
				$btnSaveTargetVersion.Top = $btnSaveSourceVersion.Top
				$btnSaveTargetVersion.Forecolor = "White"
				$btnSaveTargetVersion.BackColor = "Green"
				$btnSaveTargetVersion.Text = "Save $strTarget Version"
				$btnSaveTargetVersion.Anchor = "Top,Left,Right"
				$btnSaveTargetVersion.Cursor = "Hand"
				$btnSaveTargetVersion.Add_Click({
				
						LogWrite "VERBOSE" "$strTarget Version Will Be Saved"
						$script:strVersionToKeep = $strTarget
						$frmComparison.Close()
					})
				$frmComparison.Controls.Add($btnSaveTargetVersion)
			}

		# Add the Cancel button
		If (!($btnComparisonCancel)) 
			{
				$btnComparisonCancel = New-Object Windows.Forms.Button
				$btnComparisonCancel.Width = $frmComparison.Width * .1
				$btnComparisonCancel.Left = $frmComparison.Width - $btnComparisonCancel.Width - 30
				$btnComparisonCancel.Top = $frmComparison.Height - $btnComparisonCancel.Height - 50
				$btnComparisonCancel.Text = "Cancel"
				$btnComparisonCancel.TextAlign = "MiddleCenter"
				$btnComparisonCancel.Cursor = "Hand"
				$btnComparisonCancel.ForeColor = "White"
				$btnComparisonCancel.BackColor = "Red"
				$btnComparisonCancel.Anchor = "Bottom,Right"
				$btnComparisonCancel.Add_Click({
						
						# Prompt to close
						$frmComparison.Close()
					})
				$frmComparison.Controls.Add($btnComparisonCancel)
				$btnComparisonCancel.BringToFront()
			}
		
		# Show the form
		$frmComparison.ShowDialog()

	}



Function ShowDuplicateIDForm ($strNodeType, $strNodeID)
	{
		LogWrite "DEBUG" "Show the $strNodeType Duplicate ID Form"

		Switch ($strNodeType)
			{
				"Model" {}
				"ModelGroup" {}
				"View" {}
				default
					{
						LogWrite "WARNING" "$strNodeType is not a valid node type so no ID can be found"
						$frmDuplicateID.Close()
					}
			}
	
		# Draw the form
		If (!($frmDuplicateID)) 
			{
				$frmDuplicateID = New-Object System.Windows.Forms.Form
				$frmDuplicateID.BackColor = "LightBlue"
				$frmDuplicateID.Text = "Resolve Duplicate $(If ($strNodeType -eq "ModelGroup") {"Model Group"} Else {$strNodeType})"
				$frmDuplicateID.Width = $objForm.Width * .6
				$frmDuplicateID.Height = $objForm.Height * .9
				$frmDuplicateID.StartPosition = "CenterScreen" # CenterScreen, Manual, WindowsDefaultLocation, WindowsDefaultBounds, CenterParent
				$frmDuplicateID.ControlBox = $false # Show/hide the Min/Max/X buttons in the rop right corner of the window. If this is $false, the Minimize and Maximize buttons will be hidden, regardless of the settings below
				$frmDuplicateID.MinimizeBox = $false
				$frmDuplicateID.MaximizeBox = $false
				#$frmDuplicateID.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::DPI
				$frmDuplicateID.FormBorderStyle = "Fixed3D" # None, Fixed3D, FixedSingle
				$frmDuplicateID.Topmost = $true  
				$objIcon = [system.drawing.icon]::ExtractAssociatedIcon($strFormIconPath)
				$frmDuplicateID.Icon = $objIcon
				$frmDuplicateID.Add_Shown({
						# Set what should happen the first time the form is shown
						$frmDuplicateID.Activate()
						$cboOriginalNode.Select()
					})
				$frmDuplicateID.Add_Closed({
						# Try to close the On Screen Keyboard
						Try 
							{
							} Catch {}
					})
			}


		# Add Header label
		If (!($lblDuplicateIDFormHeader)) 
			{
				$lblDuplicateIDFormHeader = New-Object System.Windows.Forms.Label
				$lblDuplicateIDFormHeader.Left = 5
				$lblDuplicateIDFormHeader.Top = 5
				$lblDuplicateIDFormHeader.Width = $frmDuplicateID.Width - 10
				$lblDuplicateIDFormHeader.Height = 25
				$lblDuplicateIDFormHeader.TextAlign = "TopCenter"
				$lblDuplicateIDFormHeader.Text = "- Duplicate $(If ($strNodeType -eq "ModelGroup") {"Model Group"} Else {$strNodeType}) ID Detected -"
				$lblDuplicateIDFormHeader.ForeColor = "DarkRed"
				$lblDuplicateIDFormHeader.Font = New-Object System.Drawing.Font("Arial",16)
				$lblDuplicateIDFormHeader.Anchor = "Top,Left,Right"
				$frmDuplicateID.Controls.Add($lblDuplicateIDFormHeader)
			}

		# Add Sub Header labels
		If (!($lblDuplicateIDFormSubHeader1)) 
			{
				$lblDuplicateIDFormSubHeader1 = New-Object System.Windows.Forms.Label
				$lblDuplicateIDFormSubHeader1.Left = 5
				$lblDuplicateIDFormSubHeader1.Top = $lblDuplicateIDFormHeader.Bottom + 5
				$lblDuplicateIDFormSubHeader1.Width = $frmDuplicateID.Width - 10
				$lblDuplicateIDFormSubHeader1.Height = 25
				$lblDuplicateIDFormSubHeader1.TextAlign = "TopCenter"
				$lblDuplicateIDFormSubHeader1.Text = "Duplicate ID's are common and are created when a $(If ($strNodeType -eq "ModelGroup") {"Model Group"} Else {$strNodeType}) is copied in xLights."
				$lblDuplicateIDFormSubHeader1.ForeColor = "Blue"
				$lblDuplicateIDFormSubHeader1.Font = New-Object System.Drawing.Font("Arial",12)
				$lblDuplicateIDFormSubHeader1.Anchor = "Top,Left,Right"
				$frmDuplicateID.Controls.Add($lblDuplicateIDFormSubHeader1)
			}

		If (!($lblDuplicateIDFormSubHeader2)) 
			{
				$lblDuplicateIDFormSubHeader2 = New-Object System.Windows.Forms.Label
				$lblDuplicateIDFormSubHeader2.Left = 5
				$lblDuplicateIDFormSubHeader2.Top = $lblDuplicateIDFormSubHeader1.Bottom + 3
				$lblDuplicateIDFormSubHeader2.Width = $frmDuplicateID.Width - 10
				$lblDuplicateIDFormSubHeader2.Height = 25
				$lblDuplicateIDFormSubHeader2.TextAlign = "TopCenter"
				$lblDuplicateIDFormSubHeader2.Text = "- Please select the $(If ($strNodeType -eq "ModelGroup") {"Model Group"} Else {$strNodeType}) to retain the Original ID.  Copies will have new ID's assigned. -"
				$lblDuplicateIDFormSubHeader2.ForeColor = "Blue"
				$lblDuplicateIDFormSubHeader2.Font = New-Object System.Drawing.Font("Arial",12)
				$lblDuplicateIDFormSubHeader2.Anchor = "Top,Left,Right"
				$frmDuplicateID.Controls.Add($lblDuplicateIDFormSubHeader2)
			}

		If (!($lblDuplicateIDFormSubHeader3)) 
			{
				$lblDuplicateIDFormSubHeader3 = New-Object System.Windows.Forms.Label
				$lblDuplicateIDFormSubHeader3.Left = 5
				$lblDuplicateIDFormSubHeader3.Top = $lblDuplicateIDFormSubHeader2.Bottom + 3
				$lblDuplicateIDFormSubHeader3.Width = $frmDuplicateID.Width - 10
				$lblDuplicateIDFormSubHeader3.Height = 25
				$lblDuplicateIDFormSubHeader3.TextAlign = "TopCenter"
				$lblDuplicateIDFormSubHeader3.Text = "Note:  Try to pick the correct Original $(If ($strNodeType -eq "ModelGroup") {"Model Group"} Else {$strNodeType}) as it could affect previous Layout Associations"
				$lblDuplicateIDFormSubHeader3.ForeColor = "Blue"
				$lblDuplicateIDFormSubHeader3.Font = New-Object System.Drawing.Font("Arial",12)
				$lblDuplicateIDFormSubHeader3.Anchor = "Top,Left,Right"
				$frmDuplicateID.Controls.Add($lblDuplicateIDFormSubHeader3)
			}

		# Add Footer label
		If (!($lblDuplicateIDFormFooter)) 
			{
				$lblDuplicateIDFormFooter = New-Object System.Windows.Forms.Label
				$lblDuplicateIDFormFooter.Left = 10
				$lblDuplicateIDFormFooter.Top = $frmDuplicateID.Height - $lblDuplicateIDFormFooter.Height - 50
				$lblDuplicateIDFormFooter.Width = $frmDuplicateID.Width - 10
				$lblDuplicateIDFormFooter.Height = 25
				$lblDuplicateIDFormFooter.TextAlign = "MiddleLeft"
				$lblDuplicateIDFormFooter.Text = ""
				$lblDuplicateIDFormFooter.ForeColor = "DarkRed"
				$lblDuplicateIDFormFooter.Font = New-Object System.Drawing.Font("Arial",10)
				$lblDuplicateIDFormFooter.Anchor = "Top,Left,Right"
				$frmDuplicateID.Controls.Add($lblDuplicateIDFormFooter)
			}

			


		##############################
		# Original Node Details
		##############################


		# Original Node Panel
		If (!($pnlOriginalNode)) 
		{
			$pnlOriginalNode = New-Object System.Windows.Forms.Panel
			$pnlOriginalNode.Name = "DuplicateIDPanel"
			$pnlOriginalNode.Width = $frmDuplicateID.Width - 30
			$pnlOriginalNode.Left = 10
			$pnlOriginalNode.Top = $lblDuplicateIDFormSubHeader3.Bottom + 10
			$pnlOriginalNode.Height = $frmDuplicateID.Height - $pnlOriginalNode.Top - 100
			$pnlOriginalNode.BackColor = "Azure"
			$pnlOriginalNode.Anchor = "Top,Left,Right"
			$frmDuplicateID.Controls.Add($pnlOriginalNode)
		}

		# Add Original Node Drop Down
		If (!($cboOriginalNode)) 
			{
				$cboOriginalNode = New-Object System.Windows.Forms.ComboBox
				$cboOriginalNode.Width = $pnlOriginalNode.Width * .7
				$cboOriginalNode.Left = ($pnlOriginalNode.Width / 2) - ($cboOriginalNode.Width / 2)
				$cboOriginalNode.Top = 5
				$cboOriginalNode.Height = 20
				$cboOriginalNode.ForeColor = "Black"
				$cboOriginalNode.Backcolor = "WhiteSmoke"
				$cboOriginalNode.Font = New-Object System.Drawing.Font("Arial",12)
				$cboOriginalNode.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($cboOriginalNode)
			}

		# Add the event to the ComboBox
		$cboOriginalNode.Add_SelectedValueChanged({

			If ($cboOriginalNode.SelectedItem -ne "")
				{
					# Enable the Resolve button
					$btnResolveDuplicate.Enabled = $true
					$btnResolveDuplicate.Forecolor = "White"
					$btnResolveDuplicate.BackColor = "Green"

					$objOriginalNodeXML = $objSourceXML | Where-Object {$_.name -eq $cboOriginalNode.SelectedItem}

					Switch ($strNodeType)
						{
							"Model" 
								{
									# Populate the Details
									$txtOriginalNodeAttribute1Name.Text = "Controller:"
									$txtOriginalNodeAttribute1Value.Text = $objOriginalNodeXML.Controller
									$txtOriginalNodeAttribute2Name.Text = "Start Channel:"
									$txtOriginalNodeAttribute2Value.Text = $objOriginalNodeXML.StartChannel
									$txtOriginalNodeAttribute3Name.Text = "Version Number:"
									$txtOriginalNodeAttribute3Value.Text = $objOriginalNodeXML.versionNumber
									$txtOriginalNodeAttribute4Name.Text = "Submodel Count:"
									$txtOriginalNodeAttribute4Value.Text = ($objOriginalNodeXML.Submodels).Count
									$txtOriginalNodeAttribute5Name.Text = "Pixel Size:"
									$txtOriginalNodeAttribute5Value.Text = $objOriginalNodeXML.PixelSize
									$txtOriginalNodeAttribute6Name.Text = "Layout Group:"
									$txtOriginalNodeAttribute6Value.Text = $objOriginalNodeXML.LayoutGroup
									$txtOriginalNodeAttribute7Name.Text = "Active:"
									$txtOriginalNodeAttribute7Value.Text = If ($objOriginalNodeXML.Active) {$objOriginalNodeXML.Active} Else {"1"}
									$txtOriginalNodeAttribute8Name.Text = "Location:"
									$txtOriginalNodeAttribute8Value.Text = "$($objOriginalNodeXML.WorldPosX) / $($objOriginalNodeXML.WorldPosY) / $($objOriginalNodeXML.WorldPosZ)"
									$txtOriginalNodeAttribute9Name.Text = "Size:"
									$txtOriginalNodeAttribute9Value.Text = "$($objOriginalNodeXML.ScaleX) / $($objOriginalNodeXML.ScaleY) / $($objOriginalNodeXML.ScaleZ)"
									$txtOriginalNodeAttribute10Name.Text = "Display As:"
									$txtOriginalNodeAttribute10Value.Text = $objOriginalNodeXML.DisplayAs
								}
								
							"ModelGroup" 
								{
									# Populate the Details
									$txtOriginalNodeAttribute1Name.Text = "Grid Size:"
									$txtOriginalNodeAttribute1Value.Text = $objOriginalNodeXML.GridSize
									$txtOriginalNodeAttribute2Name.Text = "X Offset:"
									$txtOriginalNodeAttribute2Value.Text = $objOriginalNodeXML.XCentreOffset
									$txtOriginalNodeAttribute3Name.Text = "Y Offset:"
									$txtOriginalNodeAttribute3Value.Text = $objOriginalNodeXML.YCenterOffset
									$txtOriginalNodeAttribute4Name.Text = "Assigned Layout:"
									$txtOriginalNodeAttribute4Value.Text = $objOriginalNodeXML.layout
									$txtOriginalNodeAttribute5Name.Text = "Version Number:"
									$txtOriginalNodeAttribute5Value.Text = $objOriginalNodeXML.versionNumber
									$txtOriginalNodeAttribute6Name.Text = "Tag Color:"
									$txtOriginalNodeAttribute6Value.Text = $objOriginalNodeXML.TagColour
									$txtOriginalNodeAttribute7Name.Text = "Models in Group:"
									$txtOriginalNodeAttribute7Value.Text = ($objOriginalNodeXML.Models -split ",").Count

									# Add the model list
									$txtOriginalNodeAttribute8Name.Left = $txtOriginalNodeAttribute8Name.Left + 5
									$txtOriginalNodeAttribute8Name.Width = $cboOriginalNode.Width - 5
									$txtOriginalNodeAttribute8Name.Height = $pnlOriginalNode.Height - 15 - $txtOriginalNodeAttribute8Name.Top
									$txtOriginalNodeAttribute8Name.BackColor = "WhiteSmoke"
									$txtOriginalNodeAttribute8Name.Multiline = $true
									$txtOriginalNodeAttribute8Name.WordWrap = $true
									$txtOriginalNodeAttribute8Name.ScrollBars = "Vertical"
									$txtOriginalNodeAttribute8Name.Text = $objOriginalNodeXML.Models
								}

							"View" 
								{
									# Populate the Details
									$txtOriginalNodeAttribute1Name.Text = "Models in View:"
									$txtOriginalNodeAttribute1Value.Text = ($objOriginalNodeXML.Models -split ",").Count
									$txtOriginalNodeAttribute2Name.Left = $txtOriginalNodeAttribute2Name.Left + 5
									$txtOriginalNodeAttribute2Name.Width = $cboOriginalNode.Width - 5
									$txtOriginalNodeAttribute2Name.Height = $pnlOriginalNode.Height - 15 - $txtOriginalNodeAttribute2Name.Top
									$txtOriginalNodeAttribute2Name.BackColor = "WhiteSmoke"
									$txtOriginalNodeAttribute2Name.Multiline = $true
									$txtOriginalNodeAttribute2Name.WordWrap = $true
									$txtOriginalNodeAttribute2Name.ScrollBars = "Vertical"
									$txtOriginalNodeAttribute2Name.Text = $objOriginalNodeXML.Models

								}

							default
								{
									LogWrite "WARNING" "Node Type ($strNodeType) is invalid."
									Return	
								}
						}
				}
				Else
					{
						# Enable the Resolve button
						$btnResolveDuplicate.Enabled = $false
						$btnResolveDuplicate.Forecolor = "Gray"
						$btnResolveDuplicate.BackColor = "LightGray"

						# Clear the details boxes
						$txtOriginalNodeAttribute1Name.Text = ""
						$txtOriginalNodeAttribute1Value.Text = ""
						$txtOriginalNodeAttribute2Name.Text = ""
						$txtOriginalNodeAttribute2Value.Text = ""
						$txtOriginalNodeAttribute3Name.Text = ""
						$txtOriginalNodeAttribute3Value.Text = ""
						$txtOriginalNodeAttribute4Name.Text = ""
						$txtOriginalNodeAttribute4Value.Text = ""
						$txtOriginalNodeAttribute5Name.Text = ""
						$txtOriginalNodeAttribute5Value.Text = ""
						$txtOriginalNodeAttribute6Name.Text = ""
						$txtOriginalNodeAttribute6Value.Text = ""
						$txtOriginalNodeAttribute7Name.Text = ""
						$txtOriginalNodeAttribute7Value.Text = ""
						$txtOriginalNodeAttribute8Name.Text = ""
						$txtOriginalNodeAttribute8Value.Text = ""
						$txtOriginalNodeAttribute9Name.Text = ""
						$txtOriginalNodeAttribute9Value.Text = ""
						$txtOriginalNodeAttribute10Name.Text = ""
						$txtOriginalNodeAttribute10Value.Text = ""
					}

			})


		# Add Original Node Attribute 1 Name TextBox
		If (!($txtOriginalNodeAttribute1Name)) 
			{
				$txtOriginalNodeAttribute1Name = New-Object System.Windows.Forms.TextBox
				$txtOriginalNodeAttribute1Name.Width = $cboOriginalNode.Width * .4
				$txtOriginalNodeAttribute1Name.Left = $cboOriginalNode.Left
				$txtOriginalNodeAttribute1Name.Top = $cboOriginalNode.Bottom + 10
				$txtOriginalNodeAttribute1Name.Height = 20
				$txtOriginalNodeAttribute1Name.BorderStyle = "None"
				$txtOriginalNodeAttribute1Name.ReadOnly = $true
				$txtOriginalNodeAttribute1Name.ReadOnly = $true
				$txtOriginalNodeAttribute1Name.BackColor = $pnlOriginalNode.BackColor
				$txtOriginalNodeAttribute1Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtOriginalNodeAttribute1Name.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($txtOriginalNodeAttribute1Name)
			}

		# Add Original Node Attribute 1 Value TextBox
		If (!($txtOriginalNodeAttribute1Value)) 
			{
				$txtOriginalNodeAttribute1Value = New-Object System.Windows.Forms.TextBox
				$txtOriginalNodeAttribute1Value.Width = $cboOriginalNode.Width * .6
				$txtOriginalNodeAttribute1Value.Left = $txtOriginalNodeAttribute1Name.Right + 10
				$txtOriginalNodeAttribute1Value.Top = $txtOriginalNodeAttribute1Name.Top
				$txtOriginalNodeAttribute1Value.Height = 20
				$txtOriginalNodeAttribute1Value.BorderStyle = "None"
				$txtOriginalNodeAttribute1Value.ReadOnly = $true
				$txtOriginalNodeAttribute1Value.BackColor = $pnlOriginalNode.BackColor
				$txtOriginalNodeAttribute1Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtOriginalNodeAttribute1Value.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($txtOriginalNodeAttribute1Value)
			}

		# Add Original Node Attribute 2 Name TextBox
		If (!($txtOriginalNodeAttribute2Name)) 
			{
				$txtOriginalNodeAttribute2Name = New-Object System.Windows.Forms.TextBox
				$txtOriginalNodeAttribute2Name.Left = $txtOriginalNodeAttribute1Name.Left
				$txtOriginalNodeAttribute2Name.Top = $txtOriginalNodeAttribute1Name.Bottom + 5
				$txtOriginalNodeAttribute2Name.Width = $txtOriginalNodeAttribute1Name.Width
				$txtOriginalNodeAttribute2Name.Height = 20
				$txtOriginalNodeAttribute2Name.BorderStyle = "None"
				$txtOriginalNodeAttribute2Name.ReadOnly = $true
				$txtOriginalNodeAttribute2Name.BackColor = $pnlOriginalNode.BackColor
				$txtOriginalNodeAttribute2Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtOriginalNodeAttribute2Name.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($txtOriginalNodeAttribute2Name)
			}

		# Add Original Node Attribute 2 Value TextBox
		If (!($txtOriginalNodeAttribute2Value)) 
			{
				$txtOriginalNodeAttribute2Value = New-Object System.Windows.Forms.TextBox
				$txtOriginalNodeAttribute2Value.Left = $txtOriginalNodeAttribute2Name.Right + 10
				$txtOriginalNodeAttribute2Value.Top = $txtOriginalNodeAttribute2Name.Top
				$txtOriginalNodeAttribute2Value.Width = $txtOriginalNodeAttribute1Value.Width
				$txtOriginalNodeAttribute2Value.Height = 20
				$txtOriginalNodeAttribute2Value.BorderStyle = "None"
				$txtOriginalNodeAttribute2Value.ReadOnly = $true
				$txtOriginalNodeAttribute2Value.BackColor = $pnlOriginalNode.BackColor
				$txtOriginalNodeAttribute2Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtOriginalNodeAttribute2Value.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($txtOriginalNodeAttribute2Value)
			}

		# Add Original Node Attribute 3 Name TextBox
		If (!($txtOriginalNodeAttribute3Name)) 
			{
				$txtOriginalNodeAttribute3Name = New-Object System.Windows.Forms.TextBox
				$txtOriginalNodeAttribute3Name.Left = $txtOriginalNodeAttribute1Name.Left
				$txtOriginalNodeAttribute3Name.Top = $txtOriginalNodeAttribute2Name.Bottom + 5
				$txtOriginalNodeAttribute3Name.Width = $txtOriginalNodeAttribute1Name.Width
				$txtOriginalNodeAttribute3Name.Height = 20
				$txtOriginalNodeAttribute3Name.BorderStyle = "None"
				$txtOriginalNodeAttribute3Name.ReadOnly = $true
				$txtOriginalNodeAttribute3Name.BackColor = $pnlOriginalNode.BackColor
				$txtOriginalNodeAttribute3Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtOriginalNodeAttribute3Name.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($txtOriginalNodeAttribute3Name)
			}
		
		
		# Add Original Node Attribute 3 Value TextBox
		If (!($txtOriginalNodeAttribute3Value)) 
			{
				$txtOriginalNodeAttribute3Value = New-Object System.Windows.Forms.TextBox
				$txtOriginalNodeAttribute3Value.Left = $txtOriginalNodeAttribute3Name.Right + 10
				$txtOriginalNodeAttribute3Value.Top = $txtOriginalNodeAttribute3Name.Top
				$txtOriginalNodeAttribute3Value.Width = $txtOriginalNodeAttribute1Value.Width
				$txtOriginalNodeAttribute3Value.Height = 20
				$txtOriginalNodeAttribute3Value.BorderStyle = "None"
				$txtOriginalNodeAttribute3Value.ReadOnly = $true
				$txtOriginalNodeAttribute3Value.BackColor = $pnlOriginalNode.BackColor
				$txtOriginalNodeAttribute3Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtOriginalNodeAttribute3Value.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($txtOriginalNodeAttribute3Value)
			}

		# Add Original Node Attribute 4 Name TextBox
		If (!($txtOriginalNodeAttribute4Name)) 
			{
				$txtOriginalNodeAttribute4Name = New-Object System.Windows.Forms.TextBox
				$txtOriginalNodeAttribute4Name.Left = $txtOriginalNodeAttribute1Name.Left
				$txtOriginalNodeAttribute4Name.Top = $txtOriginalNodeAttribute3Name.Bottom + 5
				$txtOriginalNodeAttribute4Name.Width = $txtOriginalNodeAttribute1Name.Width
				$txtOriginalNodeAttribute4Name.Height = 20
				$txtOriginalNodeAttribute4Name.BorderStyle = "None"
				$txtOriginalNodeAttribute4Name.ReadOnly = $true
				$txtOriginalNodeAttribute4Name.BackColor = $pnlOriginalNode.BackColor
				$txtOriginalNodeAttribute4Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtOriginalNodeAttribute4Name.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($txtOriginalNodeAttribute4Name)
			}
		
		
		# Add Original Node Attribute 4 Value TextBox
		If (!($txtOriginalNodeAttribute4Value)) 
			{
				$txtOriginalNodeAttribute4Value = New-Object System.Windows.Forms.TextBox
				$txtOriginalNodeAttribute4Value.Left = $txtOriginalNodeAttribute4Name.Right + 10
				$txtOriginalNodeAttribute4Value.Top = $txtOriginalNodeAttribute4Name.Top
				$txtOriginalNodeAttribute4Value.Width = $txtOriginalNodeAttribute1Value.Width
				$txtOriginalNodeAttribute4Value.Height = 20
				$txtOriginalNodeAttribute4Value.BorderStyle = "None"
				$txtOriginalNodeAttribute4Value.ReadOnly = $true
				$txtOriginalNodeAttribute4Value.BackColor = $pnlOriginalNode.BackColor
				$txtOriginalNodeAttribute4Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtOriginalNodeAttribute4Value.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($txtOriginalNodeAttribute4Value)
			}

		# Add Original Node Attribute 5 Name TextBox
		If (!($txtOriginalNodeAttribute5Name)) 
			{
				$txtOriginalNodeAttribute5Name = New-Object System.Windows.Forms.TextBox
				$txtOriginalNodeAttribute5Name.Left = $txtOriginalNodeAttribute1Name.Left
				$txtOriginalNodeAttribute5Name.Top = $txtOriginalNodeAttribute4Name.Bottom + 5
				$txtOriginalNodeAttribute5Name.Width = $txtOriginalNodeAttribute1Name.Width
				$txtOriginalNodeAttribute5Name.Height = 20
				$txtOriginalNodeAttribute5Name.BorderStyle = "None"
				$txtOriginalNodeAttribute5Name.ReadOnly = $true
				$txtOriginalNodeAttribute5Name.BackColor = $pnlOriginalNode.BackColor
				$txtOriginalNodeAttribute5Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtOriginalNodeAttribute5Name.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($txtOriginalNodeAttribute5Name)
			}
		
		# Add Original Node Attribute 5 Value TextBox
		If (!($txtOriginalNodeAttribute5Value)) 
			{
				$txtOriginalNodeAttribute5Value = New-Object System.Windows.Forms.TextBox
				$txtOriginalNodeAttribute5Value.Left = $txtOriginalNodeAttribute5Name.Right + 10
				$txtOriginalNodeAttribute5Value.Top = $txtOriginalNodeAttribute5Name.Top
				$txtOriginalNodeAttribute5Value.Width = $txtOriginalNodeAttribute1Value.Width
				$txtOriginalNodeAttribute5Value.Height = 20
				$txtOriginalNodeAttribute5Value.BorderStyle = "None"
				$txtOriginalNodeAttribute5Value.ReadOnly = $true
				$txtOriginalNodeAttribute5Value.BackColor = $pnlOriginalNode.BackColor
				$txtOriginalNodeAttribute5Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtOriginalNodeAttribute5Value.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($txtOriginalNodeAttribute5Value)
			}

		# Add Original Node Attribute 6 Name TextBox
		If (!($txtOriginalNodeAttribute6Name)) 
			{
				$txtOriginalNodeAttribute6Name = New-Object System.Windows.Forms.TextBox
				$txtOriginalNodeAttribute6Name.Left = $txtOriginalNodeAttribute1Name.Left
				$txtOriginalNodeAttribute6Name.Top = $txtOriginalNodeAttribute5Name.Bottom + 5
				$txtOriginalNodeAttribute6Name.Width = $txtOriginalNodeAttribute1Name.Width
				$txtOriginalNodeAttribute6Name.Height = 20
				$txtOriginalNodeAttribute6Name.BorderStyle = "None"
				$txtOriginalNodeAttribute6Name.ReadOnly = $true
				$txtOriginalNodeAttribute6Name.BackColor = $pnlOriginalNode.BackColor
				$txtOriginalNodeAttribute6Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtOriginalNodeAttribute6Name.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($txtOriginalNodeAttribute6Name)
			}
		
		
		# Add Original Node Attribute 6 Value TextBox
		If (!($txtOriginalNodeAttribute6Value)) 
			{
				$txtOriginalNodeAttribute6Value = New-Object System.Windows.Forms.TextBox
				$txtOriginalNodeAttribute6Value.Left = $txtOriginalNodeAttribute6Name.Right + 10
				$txtOriginalNodeAttribute6Value.Top = $txtOriginalNodeAttribute6Name.Top
				$txtOriginalNodeAttribute6Value.Width = $txtOriginalNodeAttribute1Value.Width
				$txtOriginalNodeAttribute6Value.Height = 20
				$txtOriginalNodeAttribute6Value.BorderStyle = "None"
				$txtOriginalNodeAttribute6Value.ReadOnly = $true
				$txtOriginalNodeAttribute6Value.BackColor = $pnlOriginalNode.BackColor
				$txtOriginalNodeAttribute6Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtOriginalNodeAttribute6Value.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($txtOriginalNodeAttribute6Value)
			}

		# Add Original Node Attribute 7 Name TextBox
		If (!($txtOriginalNodeAttribute7Name)) 
			{
				$txtOriginalNodeAttribute7Name = New-Object System.Windows.Forms.TextBox
				$txtOriginalNodeAttribute7Name.Left = $txtOriginalNodeAttribute1Name.Left
				$txtOriginalNodeAttribute7Name.Top = $txtOriginalNodeAttribute6Name.Bottom + 5
				$txtOriginalNodeAttribute7Name.Width = $txtOriginalNodeAttribute1Name.Width
				$txtOriginalNodeAttribute7Name.Height = 20
				$txtOriginalNodeAttribute7Name.BorderStyle = "None"
				$txtOriginalNodeAttribute7Name.ReadOnly = $true
				$txtOriginalNodeAttribute7Name.BackColor = $pnlOriginalNode.BackColor
				$txtOriginalNodeAttribute7Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtOriginalNodeAttribute7Name.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($txtOriginalNodeAttribute7Name)
			}
		
		
		# Add Original Node Attribute 7 Value TextBox
		If (!($txtOriginalNodeAttribute7Value)) 
			{
				$txtOriginalNodeAttribute7Value = New-Object System.Windows.Forms.TextBox
				$txtOriginalNodeAttribute7Value.Left = $txtOriginalNodeAttribute7Name.Right + 10
				$txtOriginalNodeAttribute7Value.Top = $txtOriginalNodeAttribute7Name.Top
				$txtOriginalNodeAttribute7Value.Width = $txtOriginalNodeAttribute1Value.Width
				$txtOriginalNodeAttribute7Value.Height = 20
				$txtOriginalNodeAttribute7Value.BorderStyle = "None"
				$txtOriginalNodeAttribute7Value.ReadOnly = $true
				$txtOriginalNodeAttribute7Value.BackColor = $pnlOriginalNode.BackColor
				$txtOriginalNodeAttribute7Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtOriginalNodeAttribute7Value.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($txtOriginalNodeAttribute7Value)
			}

		# Add Original Node Attribute 8 Name TextBox
		If (!($txtOriginalNodeAttribute8Name)) 
			{
				$txtOriginalNodeAttribute8Name = New-Object System.Windows.Forms.TextBox
				$txtOriginalNodeAttribute8Name.Left = $txtOriginalNodeAttribute1Name.Left
				$txtOriginalNodeAttribute8Name.Top = $txtOriginalNodeAttribute7Name.Bottom + 5
				$txtOriginalNodeAttribute8Name.Width = $txtOriginalNodeAttribute1Name.Width
				$txtOriginalNodeAttribute8Name.Height = 20
				$txtOriginalNodeAttribute8Name.BorderStyle = "None"
				$txtOriginalNodeAttribute8Name.ReadOnly = $true
				$txtOriginalNodeAttribute8Name.BackColor = $pnlOriginalNode.BackColor
				$txtOriginalNodeAttribute8Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtOriginalNodeAttribute8Name.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($txtOriginalNodeAttribute8Name)
			}
		
		
		# Add Original Node Attribute 8 Value TextBox
		If (!($txtOriginalNodeAttribute8Value)) 
			{
				$txtOriginalNodeAttribute8Value = New-Object System.Windows.Forms.TextBox
				$txtOriginalNodeAttribute8Value.Left = $txtOriginalNodeAttribute8Name.Right + 10
				$txtOriginalNodeAttribute8Value.Top = $txtOriginalNodeAttribute8Name.Top
				$txtOriginalNodeAttribute8Value.Width = $txtOriginalNodeAttribute1Value.Width
				$txtOriginalNodeAttribute8Value.Height = 20
				$txtOriginalNodeAttribute8Value.BorderStyle = "None"
				$txtOriginalNodeAttribute8Value.ReadOnly = $true
				$txtOriginalNodeAttribute8Value.BackColor = $pnlOriginalNode.BackColor
				$txtOriginalNodeAttribute8Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtOriginalNodeAttribute8Value.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($txtOriginalNodeAttribute8Value)
			}

		# Add Original Node Attribute 9 Name TextBox
		If (!($txtOriginalNodeAttribute9Name)) 
			{
				$txtOriginalNodeAttribute9Name = New-Object System.Windows.Forms.TextBox
				$txtOriginalNodeAttribute9Name.Left = $txtOriginalNodeAttribute1Name.Left
				$txtOriginalNodeAttribute9Name.Top = $txtOriginalNodeAttribute8Name.Bottom + 5
				$txtOriginalNodeAttribute9Name.Width = $txtOriginalNodeAttribute1Name.Width
				$txtOriginalNodeAttribute9Name.Height = 20
				$txtOriginalNodeAttribute9Name.BorderStyle = "None"
				$txtOriginalNodeAttribute9Name.ReadOnly = $true
				$txtOriginalNodeAttribute9Name.BackColor = $pnlOriginalNode.BackColor
				$txtOriginalNodeAttribute9Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtOriginalNodeAttribute9Name.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($txtOriginalNodeAttribute9Name)
			}
		
		
		# Add Original Node Attribute 9 Value TextBox
		If (!($txtOriginalNodeAttribute9Value)) 
			{
				$txtOriginalNodeAttribute9Value = New-Object System.Windows.Forms.TextBox
				$txtOriginalNodeAttribute9Value.Left = $txtOriginalNodeAttribute9Name.Right + 10
				$txtOriginalNodeAttribute9Value.Top = $txtOriginalNodeAttribute9Name.Top
				$txtOriginalNodeAttribute9Value.Width = $txtOriginalNodeAttribute1Value.Width
				$txtOriginalNodeAttribute9Value.Height = 20
				$txtOriginalNodeAttribute9Value.BorderStyle = "None"
				$txtOriginalNodeAttribute9Value.ReadOnly = $true
				$txtOriginalNodeAttribute9Value.BackColor = $pnlOriginalNode.BackColor
				$txtOriginalNodeAttribute9Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtOriginalNodeAttribute9Value.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($txtOriginalNodeAttribute9Value)
			}

		# Add Original Node Attribute 10 Name TextBox
		If (!($txtOriginalNodeAttribute10Name)) 
			{
				$txtOriginalNodeAttribute10Name = New-Object System.Windows.Forms.TextBox
				$txtOriginalNodeAttribute10Name.Left = $txtOriginalNodeAttribute1Name.Left
				$txtOriginalNodeAttribute10Name.Top = $txtOriginalNodeAttribute9Name.Bottom + 5
				$txtOriginalNodeAttribute10Name.Width = $txtOriginalNodeAttribute1Name.Width
				$txtOriginalNodeAttribute10Name.Height = 20
				$txtOriginalNodeAttribute10Name.BorderStyle = "None"
				$txtOriginalNodeAttribute10Name.ReadOnly = $true
				$txtOriginalNodeAttribute10Name.BackColor = $pnlOriginalNode.BackColor
				$txtOriginalNodeAttribute10Name.Font = New-Object System.Drawing.Font("Arial",10)
				$txtOriginalNodeAttribute10Name.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($txtOriginalNodeAttribute10Name)
			}
		
		# Add Original Node Attribute 10 Value TextBox
		If (!($txtOriginalNodeAttribute10Value)) 
			{
				$txtOriginalNodeAttribute10Value = New-Object System.Windows.Forms.TextBox
				$txtOriginalNodeAttribute10Value.Left = $txtOriginalNodeAttribute10Name.Right + 10
				$txtOriginalNodeAttribute10Value.Top = $txtOriginalNodeAttribute10Name.Top
				$txtOriginalNodeAttribute10Value.Width = $txtOriginalNodeAttribute1Value.Width
				$txtOriginalNodeAttribute10Value.Height = 20
				$txtOriginalNodeAttribute10Value.BorderStyle = "None"
				$txtOriginalNodeAttribute10Value.ReadOnly = $true
				$txtOriginalNodeAttribute10Value.BackColor = $pnlOriginalNode.BackColor
				$txtOriginalNodeAttribute10Value.Font = New-Object System.Drawing.Font("Arial",10)
				$txtOriginalNodeAttribute10Value.Anchor = "Top,Left,Right"
				$pnlOriginalNode.Controls.Add($txtOriginalNodeAttribute10Value)
			}



		
		# Set the source and target XML structures based on the parameters
		$objSourceXML = $objxLightsEffects.xrgb
		
		# Update the XML structures with the node type
		Switch ($strNodeType)
			{
				"Model" 
					{
						$objSourceXML = $objSourceXML.models.model
					}
				"ModelGroup" 
					{
						$objSourceXML = $objSourceXML.modelGroups.modelGroup
					}
				"View" 
					{
						$objSourceXML = $objSourceXML.views.view
					}
				default
					{
						LogWrite "WARNING" "Duplicate ID Resolution failed because Node Type ($strNodeType) is invalid."
						Return	
					}
			}


		# Get the list of duplicated nodes from the XML
		[array]$arrDuplicateNodeNames = ($objSourceXML | Where-Object {$_.xLightsCompanionID -eq $strNodeID}).Name


		# Populate the ComboBox with a blank
		$cboOriginalNode.Items.Add("")

		# Populate the ComboBox with the duplicate IDs/names
		$arrDuplicateNodeNames | Sort-Object $_ | ForEach-Object {$cboOriginalNode.Items.Add($_)}

			
		# Add the Resolve Duplicate button
		If (!($btnResolveDuplicate)) 
			{
				$btnResolveDuplicate = New-Object Windows.Forms.Button
				$btnResolveDuplicate.Width = $frmDuplicateID.Width * .2
				$btnResolveDuplicate.Left = $frmDuplicateID.Width - $btnResolveDuplicate.Width - 50
				$btnResolveDuplicate.Top = $frmDuplicateID.Height - $btnResolveDuplicate.Height - 50
				$btnResolveDuplicate.Text = "Resolve Duplicate"
				$btnResolveDuplicate.TextAlign = "MiddleCenter"
				$btnResolveDuplicate.Cursor = "Hand"
				$btnResolveDuplicate.Enabled = $false
				$btnResolveDuplicate.ForeColor = "Gray"
				$btnResolveDuplicate.BackColor = "LightGray"
				$btnResolveDuplicate.Anchor = "Bottom,Right"
				$btnResolveDuplicate.Add_Click({
						
						$intIDsCleared = 0

						# Clear the xLightsCompanionID from the unselected nodes
						$objSourceXML  | Where-Object {$_.xLightsCompanionID -eq $strNodeID -and $_.name -ne $cboOriginalNode.SelectedItem} | ForEach-Object {
					
								LogWrite "DEBUG" "Clearing the xLightsCompanionID on $($_.name)"

								# Clear the ID on the model
								$_.SetAttribute("xLightsCompanionID", "")

								$intIDsCleared++
							}

						LogWrite "VERBOSE" "Cleared $intIDsCleared xLightsCompanionIDs"

						# Close the form
						$frmDuplicateID.Close()
					})
			
				$frmDuplicateID.Controls.Add($btnResolveDuplicate)
				$btnResolveDuplicate.BringToFront()
			}
		
		# Show the form
		$frmDuplicateID.ShowDialog()


	}