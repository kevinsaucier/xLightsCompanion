# Created By: Kevin Saucier
# Last Modified Date: 2021-09-24
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




	
	

# Function SaveSettings
# 	{
# 		LogWrite "VERBOSE" "Saving Settings to Registry"
# 		# New-ItemProperty $strxLightsCompanionRegRoot -Name "DeployTagNumberMinLength" -Value $intDeployTagNumberMinLength.Value -PropertyType String -Force | Out-Null
# 		New-ItemProperty $strxLightsCompanionRegRoot -Name "DeployTagNumberMaxLength" -Value $intDeployTagNumberMaxLength.Value -PropertyType String -Force | Out-Null
# 		New-ItemProperty $strxLightsCompanionRegRoot -Name "ReclaimTagNumberMinLength" -Value $intReclaimTagNumberMinLength.Value -PropertyType String -Force | Out-Null
# 		New-ItemProperty $strxLightsCompanionRegRoot -Name "ReclaimTagNumberMaxLength" -Value $intReclaimTagNumberMaxLength.Value -PropertyType String -Force | Out-Null
# 		New-ItemProperty $strxLightsCompanionRegRoot -Name "DeployMinimumImagedDate" -Value $dtDeployMinimumImagedDate.Value -PropertyType String -Force | Out-Null
# 		New-ItemProperty $strxLightsCompanionRegRoot -Name "EnforceDevicePOLocation" -Value $cboEnforceDevicePOLocation.SelectedItem -PropertyType String -Force | Out-Null
# 		New-ItemProperty $strxLightsCompanionRegRoot -Name "EnforceDevicePOLocation" -Value $cboEnforceDevicePOLocation.SelectedItem -PropertyType String -Force | Out-Null
# 		New-ItemProperty $strxLightsCompanionRegRoot -Name "ReclaimInfoRequiredSerialNumber" -Value $cbxReclaimInfoRequiredSerialNumber.Checked -PropertyType String -Force | Out-Null
# 		New-ItemProperty $strxLightsCompanionRegRoot -Name "ReclaimInfoRequiredAssetNumber" -Value $cbxReclaimInfoRequiredAssetNumber.Checked -PropertyType String -Force | Out-Null
# 		New-ItemProperty $strxLightsCompanionRegRoot -Name "ReclaimInfoRequiredOtherNumber" -Value $cbxReclaimInfoRequiredAnyNumber.Checked -PropertyType String -Force | Out-Null
		
# #		# Set the EnforceDevicePOLocation and Show/Hide the PO Number boxes based on the variable
# #		SetEnforceDevicePOLocationVariable
# #		ValidateLocation
# 	}
	
	
# Function ReloadSettings
# 	{
# 		LogWrite "VERBOSE" "Reload Settings from Registry"
	
# 		$objDeploymentTrackingSettings = Get-ItemProperty -Path $strxLightsCompanionRegRoot -ErrorAction SilentlyContinue
	
# 		If ($objDeploymentTrackingSettings.DeployTagNumberMinLength) {$intDeployTagNumberMinLength.Value = $objDeploymentTrackingSettings.DeployTagNumberMinLength}
# 		If ($objDeploymentTrackingSettings.DeployTagNumberMaxLength) {$intDeployTagNumberMaxLength.Value = $objDeploymentTrackingSettings.DeployTagNumberMaxLength}
# 		If ($objDeploymentTrackingSettings.ReclaimTagNumberMinLength) {$intReclaimTagNumberMinLength.Value = $objDeploymentTrackingSettings.ReclaimTagNumberMinLength}
# 		If ($objDeploymentTrackingSettings.ReclaimTagNumberMaxLength) {$intReclaimTagNumberMaxLength.Value = $objDeploymentTrackingSettings.ReclaimTagNumberMaxLength}
# 		If ($objDeploymentTrackingSettings.DeployMinimumImagedDate) {$dtDeployMinimumImagedDate.Value = $objDeploymentTrackingSettings.DeployMinimumImagedDate}
# 		If ($objDeploymentTrackingSettings.EnforceDevicePOLocation) {$cboEnforceDevicePOLocation.SelectedItem = $objDeploymentTrackingSettings.EnforceDevicePOLocation}
# 		If ($objDeploymentTrackingSettings.ReclaimInfoRequiredSerialNumber) {If ($objDeploymentTrackingSettings.ReclaimInfoRequiredSerialNumber -eq "True") {$cbxReclaimInfoRequiredSerialNumber.Checked = $true} Else {$cbxReclaimInfoRequiredSerialNumber.Checked = $false}}
# 		If ($objDeploymentTrackingSettings.ReclaimInfoRequiredAssetNumber) {If ($objDeploymentTrackingSettings.ReclaimInfoRequiredAssetNumber -eq "True") {$cbxReclaimInfoRequiredAssetNumber.Checked = $true} Else {$cbxReclaimInfoRequiredAssetNumber.Checked = $false}}
# 		If ($objDeploymentTrackingSettings.ReclaimInfoRequiredOtherNumber) {If ($objDeploymentTrackingSettings.ReclaimInfoRequiredOtherNumber -eq "True") {$cbxReclaimInfoRequiredAnyNumber.Checked = $true} Else {$cbxReclaimInfoRequiredAnyNumber.Checked = $false}}
		
# #		SetEnforceDevicePOLocationVariable
# 	}


# Function AddSettings
# 	{
# 		LogWrite "DEBUG" "Add Settings to Window"
	
# 		# Update the settings registry path
# 		$script:strxLightsCompanionRegRoot = "$strxLightsCompanionRegRoot\Settings"
	
# 		# If the Settings registry path doesn't exist or isn't already populated, (re)create it
# 		# Note that this will delete/recreate the Settings Key if there are no values in it.  This will delete any subkeys.
# 		Try {
# 				If (!((Get-ItemProperty -Path $strxLightsCompanionRegRoot -ErrorAction SilentlyContinue).CreateDate))
# 					{
# 						New-Item $strxLightsCompanionRegRoot -Force | Out-Null
# 						New-ItemProperty $strxLightsCompanionRegRoot -Name "CreateDate" -Value $(Get-Date -Format G) | Out-Null
# 					}
# 			} Catch {}
					
# 		# Create the Deploy Tag Number Minimum Length label
# 		LogWrite "DEBUG" "Add the Deploy Tag Number Minimum Length Label"
# 		If (!($lblDeployTagNumberMinLength)) {$script:lblDeployTagNumberMinLength = New-Object System.Windows.Forms.Label}
# 	    $lblDeployTagNumberMinLength.Width = $intPanel6ContentLabelWidth
# 		$lblDeployTagNumberMinLength.Height = $intPanel6ContentLabelHeight
# 	    $lblDeployTagNumberMinLength.Left = ($pnlContentPanel6.Width / 2) - (($intPanel6ContentLabelWidth + $intPanel6ContentDataWidth) / 2)
# 		$lblDeployTagNumberMinLength.Top = 50
# 		$lblDeployTagNumberMinLength.Font = New-Object System.Drawing.Font("Arial",12)
# 	    $lblDeployTagNumberMinLength.Text = "Deploy Tag Number - Minimum Length (3 to 20)"
# 		$lblDeployTagNumberMinLength.Cursor = "Arrow"
# 		$lblDeployTagNumberMinLength.TextAlign = "MiddleLeft"
# 		$lblDeployTagNumberMinLength.Anchor = "Top,Right"
# 	    $pnlContentPanel6.Controls.Add($lblDeployTagNumberMinLength)
	
# 		# Create the Deploy Tag Number Minimum Length text box
# 		LogWrite "DEBUG" "Add the Deploy Tag Number Minimum Length Text Box"
# 		If (!($intDeployTagNumberMinLength)) {$script:intDeployTagNumberMinLength = New-Object System.Windows.Forms.NumericUpDown}
# 		$intDeployTagNumberMinLength.Width = $intPanel6ContentDataWidth
# 		$intDeployTagNumberMinLength.Height = $intPanel6ContentDataHeight
# 	    $intDeployTagNumberMinLength.Left = $lblDeployTagNumberMinLength.Right
# 		$intDeployTagNumberMinLength.Top = $lblDeployTagNumberMinLength.Top - 5
# 		$intDeployTagNumberMinLength.Font = New-Object System.Drawing.Font("Arial",12)
# 		$intDeployTagNumberMinLength.Minimum = "3"
# 		$intDeployTagNumberMinLength.Maximum = "7"
# 		$intDeployTagNumberMinLength.Value = $intDeployTagNumberMinLength.Maximum
# 		$intDeployTagNumberMinLength.Anchor = "Top,Right"
# 		$pnlContentPanel6.Controls.Add($intDeployTagNumberMinLength)
	
# 		# Create the Deploy Tag Number Maximum Length label
# 		LogWrite "DEBUG" "Add the Deploy Tag Number Maximum Length Label"
# 		If (!($lblDeployTagNumberMaxLength)) {$script:lblDeployTagNumberMaxLength = New-Object System.Windows.Forms.Label}
# 	    $lblDeployTagNumberMaxLength.Width = $intPanel6ContentLabelWidth
# 		$lblDeployTagNumberMaxLength.Height = $intPanel6ContentLabelHeight
# 	    $lblDeployTagNumberMaxLength.Left = $lblDeployTagNumberMinLength.Left
# 		$lblDeployTagNumberMaxLength.Top = $lblDeployTagNumberMinLength.Bottom + 20
# 		$lblDeployTagNumberMaxLength.Font = New-Object System.Drawing.Font("Arial",12)
# 	    $lblDeployTagNumberMaxLength.Text = "Deploy Tag Number - Maximum Length (3 to 20)"
# 		$lblDeployTagNumberMaxLength.Cursor = "Arrow"
# 		$lblDeployTagNumberMaxLength.TextAlign = "MiddleLeft"
# 		$lblDeployTagNumberMaxLength.Anchor = "Top,Right"
# 	    $pnlContentPanel6.Controls.Add($lblDeployTagNumberMaxLength)
	
# 		# Create the Deploy Tag Number Maximum Length text box
# 		LogWrite "DEBUG" "Add the Deploy Tag Number Maximum Length Text Box"
# 		If (!($intDeployTagNumberMaxLength)) {$script:intDeployTagNumberMaxLength = New-Object System.Windows.Forms.NumericUpDown}
# 		$intDeployTagNumberMaxLength.Width = $intPanel6ContentDataWidth
# 		$intDeployTagNumberMaxLength.Height = $intPanel6ContentDataHeight
# 	    $intDeployTagNumberMaxLength.Left = $lblDeployTagNumberMaxLength.Right
# 		$intDeployTagNumberMaxLength.Top = $lblDeployTagNumberMaxLength.Top - 5
# 		$intDeployTagNumberMaxLength.Font = New-Object System.Drawing.Font("Arial",12)
# 		$intDeployTagNumberMaxLength.Minimum = "3"
# 		$intDeployTagNumberMaxLength.Maximum = "15"
# 		$intDeployTagNumberMaxLength.Value = $intDeployTagNumberMaxLength.Maximum
# 		$intDeployTagNumberMaxLength.Anchor = "Top,Right"
# 		$pnlContentPanel6.Controls.Add($intDeployTagNumberMaxLength)
	
	
# 		# Create the Reclaim Tag Number Minimum Length label
# 		LogWrite "DEBUG" "Add the Reclaim Tag Number Minimum Length Label"
# 		If (!($lblReclaimTagNumberMinLength)) {$script:lblReclaimTagNumberMinLength = New-Object System.Windows.Forms.Label}
# 	    $lblReclaimTagNumberMinLength.Width = $intPanel6ContentLabelWidth
# 		$lblReclaimTagNumberMinLength.Height = $intPanel6ContentLabelHeight
# 	    $lblReclaimTagNumberMinLength.Left = $lblDeployTagNumberMaxLength.Left
# 		$lblReclaimTagNumberMinLength.Top = $lblDeployTagNumberMaxLength.Bottom + 40
# 		$lblReclaimTagNumberMinLength.Font = New-Object System.Drawing.Font("Arial",12)
# 	    $lblReclaimTagNumberMinLength.Text = "Reclaim Tag Number - Minimum Length (3 to 20)"
# 		$lblReclaimTagNumberMinLength.Cursor = "Arrow"
# 		$lblReclaimTagNumberMinLength.TextAlign = "MiddleLeft"
# 		$lblReclaimTagNumberMinLength.Anchor = "Top,Right"
# 	    $pnlContentPanel6.Controls.Add($lblReclaimTagNumberMinLength)
	
# 		# Create the Reclaim Tag Number Minimum Length text box
# 		LogWrite "DEBUG" "Add the Reclaim Tag Number Minimum Length Text Box"
# 		If (!($intReclaimTagNumberMinLength)) {$script:intReclaimTagNumberMinLength = New-Object System.Windows.Forms.NumericUpDown}
# 		$intReclaimTagNumberMinLength.Width = $intPanel6ContentDataWidth
# 		$intReclaimTagNumberMinLength.Height = $intPanel6ContentDataHeight
# 	    $intReclaimTagNumberMinLength.Left = $lblReclaimTagNumberMinLength.Right
# 		$intReclaimTagNumberMinLength.Top = $lblReclaimTagNumberMinLength.Top - 5
# 		$intReclaimTagNumberMinLength.Font = New-Object System.Drawing.Font("Arial",12)
# 		$intReclaimTagNumberMinLength.Minimum = "3"
# 		$intReclaimTagNumberMinLength.Maximum = "7"
# 		$intReclaimTagNumberMinLength.Value = $intReclaimTagNumberMinLength.Maximum
# 		$intReclaimTagNumberMinLength.Anchor = "Top,Right"
# 		$pnlContentPanel6.Controls.Add($intReclaimTagNumberMinLength)
		
# 		# Create the Reclaim Tag Number Maximum Length label
# 		LogWrite "DEBUG" "Add the Reclaim Tag Number Maximum Length Label"
# 		If (!($lblReclaimTagNumberMaxLength)) {$script:lblReclaimTagNumberMaxLength = New-Object System.Windows.Forms.Label}
# 	    $lblReclaimTagNumberMaxLength.Width = $intPanel6ContentLabelWidth
# 		$lblReclaimTagNumberMaxLength.Height = $intPanel6ContentLabelHeight
# 	    $lblReclaimTagNumberMaxLength.Left = $lblReclaimTagNumberMinLength.Left
# 		$lblReclaimTagNumberMaxLength.Top = $lblReclaimTagNumberMinLength.Bottom + 20
# 		$lblReclaimTagNumberMaxLength.Font = New-Object System.Drawing.Font("Arial",12)
# 	    $lblReclaimTagNumberMaxLength.Text = "Reclaim Tag Number - Maximum Length (3 to 20)"
# 		$lblReclaimTagNumberMaxLength.Cursor = "Arrow"
# 		$lblReclaimTagNumberMaxLength.TextAlign = "MiddleLeft"
# 		$lblReclaimTagNumberMaxLength.Anchor = "Top,Right"
# 	    $pnlContentPanel6.Controls.Add($lblReclaimTagNumberMaxLength)
	
# 		# Create the Reclaim Tag Number Maximum Length text box
# 		LogWrite "DEBUG" "Add the Reclaim Tag Number Maximum Length Text Box"
# 		If (!($intReclaimTagNumberMaxLength)) {$script:intReclaimTagNumberMaxLength = New-Object System.Windows.Forms.NumericUpDown}
# 		$intReclaimTagNumberMaxLength.Width = $intPanel6ContentDataWidth
# 		$intReclaimTagNumberMaxLength.Height = $intPanel6ContentDataHeight
# 	    $intReclaimTagNumberMaxLength.Left = $lblReclaimTagNumberMaxLength.Right
# 		$intReclaimTagNumberMaxLength.Top = $lblReclaimTagNumberMaxLength.Top - 5
# 		$intReclaimTagNumberMaxLength.Font = New-Object System.Drawing.Font("Arial",12)
# 		$intReclaimTagNumberMaxLength.Minimum = "3"
# 		$intReclaimTagNumberMaxLength.Maximum = "15"
# 		$intReclaimTagNumberMaxLength.Value = $intReclaimTagNumberMaxLength.Maximum
# 		$intReclaimTagNumberMaxLength.Anchor = "Top,Right"
# 		$pnlContentPanel6.Controls.Add($intReclaimTagNumberMaxLength)
	
		
# 		# Create the Reclaim Info Required label
# 		LogWrite "DEBUG" "Add the Reclaim Tag Number Maximum Length Label"
# 		If (!($lblReclaimInfoRequired)) {$script:lblReclaimInfoRequired = New-Object System.Windows.Forms.Label}
# 	    $lblReclaimInfoRequired.Width = $intPanel6ContentLabelWidth
# 		$lblReclaimInfoRequired.Height = $intPanel6ContentLabelHeight
# 	    $lblReclaimInfoRequired.Left = $lblReclaimTagNumberMaxLength.Left
# 		$lblReclaimInfoRequired.Top = $lblReclaimTagNumberMaxLength.Bottom + 20
# 		$lblReclaimInfoRequired.Font = New-Object System.Drawing.Font("Arial",12)
# 	    $lblReclaimInfoRequired.Text = "Scans Required for Reclamation"
# 		$lblReclaimInfoRequired.Cursor = "Arrow"
# 		$lblReclaimInfoRequired.TextAlign = "MiddleLeft"
# 		$lblReclaimInfoRequired.Anchor = "Top,Right"
# 	    $pnlContentPanel6.Controls.Add($lblReclaimInfoRequired)
	
# 		# Create the Reclaim Info Serial Number checkbox
# 		LogWrite "DEBUG" "Add the Reclaim Info Serial Number checkbox"
# 		If (!($cbxReclaimInfoRequiredSerialNumber)) {$script:cbxReclaimInfoRequiredSerialNumber = New-Object System.Windows.Forms.Checkbox}
# 		$cbxReclaimInfoRequiredSerialNumber.Width = $intPanel6ContentLabelWidth * .2
# 		$cbxReclaimInfoRequiredSerialNumber.Height = $intPanel6ContentDataHeight
# 	    $cbxReclaimInfoRequiredSerialNumber.Left = $lblReclaimInfoRequired.Right
# 		$cbxReclaimInfoRequiredSerialNumber.Top = $lblReclaimInfoRequired.Top - 5
# 		$cbxReclaimInfoRequiredSerialNumber.Font = New-Object System.Drawing.Font("Arial",9)
# 		$cbxReclaimInfoRequiredSerialNumber.Text = "Serial #"
# 		$cbxReclaimInfoRequiredSerialNumber.Anchor = "Top,Right"
# 		$pnlContentPanel6.Controls.Add($cbxReclaimInfoRequiredSerialNumber)
	
# 		# Create the Reclaim Info Asset Number checkbox
# 		LogWrite "DEBUG" "Add the Reclaim Info Asset Number checkbox"
# 		If (!($cbxReclaimInfoRequiredAssetNumber)) {$script:cbxReclaimInfoRequiredAssetNumber = New-Object System.Windows.Forms.Checkbox}
# 		$cbxReclaimInfoRequiredAssetNumber.Width = $intPanel6ContentLabelWidth * .2
# 		$cbxReclaimInfoRequiredAssetNumber.Height = $intPanel6ContentDataHeight
# 	    $cbxReclaimInfoRequiredAssetNumber.Left = $cbxReclaimInfoRequiredSerialNumber.Right + 20
# 		$cbxReclaimInfoRequiredAssetNumber.Top = $lblReclaimInfoRequired.Top - 5
# 		$cbxReclaimInfoRequiredAssetNumber.Font = New-Object System.Drawing.Font("Arial",9)
# 		$cbxReclaimInfoRequiredAssetNumber.Text = "Asset #"
# 		$cbxReclaimInfoRequiredAssetNumber.Anchor = "Top,Right"
# 		$pnlContentPanel6.Controls.Add($cbxReclaimInfoRequiredAssetNumber)
		
# #		# Create the Reclaim Info Other Number checkbox
# #		LogWrite "DEBUG" "Add the Reclaim Info Other Number checkbox"
# #		If (!($cbxReclaimInfoRequiredAnyNumber)) {$script:cbxReclaimInfoRequiredAnyNumber = New-Object System.Windows.Forms.Checkbox}
# #		$cbxReclaimInfoRequiredAnyNumber.Width = $intPanel6ContentLabelWidth * .2
# #		$cbxReclaimInfoRequiredAnyNumber.Height = $intPanel6ContentDataHeight
# #	    $cbxReclaimInfoRequiredAnyNumber.Left = $cbxReclaimInfoRequiredAssetNumber.Right + 20
# #		$cbxReclaimInfoRequiredAnyNumber.Top = $lblReclaimInfoRequired.Top - 5
# #		$cbxReclaimInfoRequiredAnyNumber.Font = New-Object System.Drawing.Font("Arial",9)
# #		$cbxReclaimInfoRequiredAnyNumber.Text = "Either #"
# #		$cbxReclaimInfoRequiredAnyNumber.Anchor = "Top,Right"
# #		$pnlContentPanel6.Controls.Add($cbxReclaimInfoRequiredAnyNumber)
		
	
# #		# Create the Deploy Minimum Create Date label
# #		LogWrite "DEBUG" "Add the Deploy Minimum Create Date Label"
# #		If (!($lblDeployMinimumCreateDate)) {$script:lblDeployMinimumCreateDate = New-Object System.Windows.Forms.Label}
# #	    $lblDeployMinimumCreateDate.Width = $intPanel6ContentLabelWidth
# #		$lblDeployMinimumCreateDate.Height = $intPanel6ContentLabelHeight
# #	    $lblDeployMinimumCreateDate.Left = $lblReclaimTagNumberMinLength.Left
# #		$lblDeployMinimumCreateDate.Top = $lblReclaimInfoRequired.Bottom + 30
# #		$lblDeployMinimumCreateDate.Font = New-Object System.Drawing.Font("Arial",12)
# #	    $lblDeployMinimumCreateDate.Text = "Deploy Tag Number - Minimum Create Date"
# #		$lblDeployMinimumCreateDate.Cursor = "Arrow"
# #		$lblDeployMinimumCreateDate.TextAlign = "MiddleLeft"
# #		$lblDeployMinimumCreateDate.Anchor = "Top,Right"
# #	    $pnlContentPanel6.Controls.Add($lblDeployMinimumCreateDate)
# #	
# #		# Create the Deploy Minimum Create Date date/time picker
# #		LogWrite "DEBUG" "Add the Deploy Minimum Create Date/Time Box"
# #		If (!($dtDeployMinimumImagedDate)) {$script:dtDeployMinimumImagedDate = New-Object System.Windows.Forms.DateTimePicker}
# #		$dtDeployMinimumImagedDate.Width = $intPanel6ContentDataWidth
# #		$dtDeployMinimumImagedDate.Height = $intPanel6ContentDataHeight
# #	    $dtDeployMinimumImagedDate.Left = $lblDeployMinimumCreateDate.Right
# #		$dtDeployMinimumImagedDate.Top = $lblDeployMinimumCreateDate.Top - 5
# #		# Set the MinDate and MaxDate.
# #		$dtDeployMinimumImagedDate.Format = [Windows.Forms.DateTimePickerFormat]::Short
# #		$dtDeployMinimumImagedDate.MinDate = "8/1/2015"
# #		$dtDeployMinimumImagedDate.MaxDate = (Get-Date).AddDays(1) # Nothing later than tomorrow
# #		$dtDeployMinimumImagedDate.Value = $dtDefaultEarliestImagingCompletionDate
# #		# Hide the CheckBox and Don't display the control as an up-down control.
# #		$dtDeployMinimumImagedDate.ShowCheckBox = $false
# #		$dtDeployMinimumImagedDate.ShowUpDown = $false
# #		$dtDeployMinimumImagedDate.Font = New-Object System.Drawing.Font("Arial",12)
# #		$dtDeployMinimumImagedDate.Enabled = $true
# #		$dtDeployMinimumImagedDate.Anchor = "Top,Right"
# #		$pnlContentPanel6.Controls.Add($dtDeployMinimumImagedDate)
		
		
# 		# Create the Enforce Device/PO/Location Checking label
# 		LogWrite "DEBUG" "Add the Enforce Device/PO/Location Label"
# 		If (!($lblEnforceDevicePOLocation)) {$script:lblEnforceDevicePOLocation = New-Object System.Windows.Forms.Label}
# 	    $lblEnforceDevicePOLocation.Width = $intPanel6ContentLabelWidth
# 		$lblEnforceDevicePOLocation.Height = $intPanel6ContentLabelHeight
# 	    $lblEnforceDevicePOLocation.Left = $lblDeployMinimumCreateDate.Left
# 		$lblEnforceDevicePOLocation.Top = $lblDeployMinimumCreateDate.Bottom + 30
# 		$lblEnforceDevicePOLocation.Font = New-Object System.Drawing.Font("Arial",12)
# 	    $lblEnforceDevicePOLocation.Text = "Enforce Device/PO/Location Associations"
# 		$lblEnforceDevicePOLocation.Cursor = "Arrow"
# 		$lblEnforceDevicePOLocation.TextAlign = "MiddleLeft"
# 		$lblEnforceDevicePOLocation.Anchor = "Top,Right"
# 	    $pnlContentPanel6.Controls.Add($lblEnforceDevicePOLocation)
	
# 		# Create the Device/PO/Location combo box
# 		LogWrite "DEBUG" "Add the Enforce Device/PO/Location Combo Box"
# 		If (!($cboEnforceDevicePOLocation)) {$script:cboEnforceDevicePOLocation = New-Object System.Windows.Forms.ComboBox}
# 		$cboEnforceDevicePOLocation.Width = $intPanel6ContentDataWidth
# 		$cboEnforceDevicePOLocation.Height = $intPanel6ContentDataHeight
# 	    $cboEnforceDevicePOLocation.Left = $lblEnforceDevicePOLocation.Right
# 		$cboEnforceDevicePOLocation.Top = $lblEnforceDevicePOLocation.Top - 5
# 		$cboEnforceDevicePOLocation.Font = New-Object System.Drawing.Font("Arial",12)
# 		$cboEnforceDevicePOLocation.Items.Add("Device to Any Location") | Out-Null
# 		$cboEnforceDevicePOLocation.Items.Add("Device to Assigned Location") | Out-Null
# 		$cboEnforceDevicePOLocation.Items.Add("Device to Assigned PO/Location") | Out-Null
# 		$cboEnforceDevicePOLocation.SelectedItem = "Device to Assigned PO/Location"
# 		$cboEnforceDevicePOLocation.Anchor = "Top,Right"
# 		$pnlContentPanel6.Controls.Add($cboEnforceDevicePOLocation)
		
	
		
# 		# Create the Save Settings Button
# 		LogWrite "DEBUG" "Add the Save Settings Button"
# 		If (!($btnSaveSettings)) {$script:btnSaveSettings = New-Object System.Windows.Forms.Button}
# 		$btnSaveSettings.Width = 150
# 		$btnSaveSettings.Height = 30
# 		$btnSaveSettings.Left = ($pnlContentPanel6.Width / 2) - $btnSaveSettings.Width - 15
# 		$btnSaveSettings.Top = $pnlContentPanel6.Height - 15 - $btnSaveSettings.Height
# 		$btnSaveSettings.Cursor = "Hand"
# 		$btnSaveSettings.FlatStyle = "Flat"
# 		$btnSaveSettings.Font = New-Object System.Drawing.Font("Arial",10)
# 		$btnSaveSettings.ForeColor = "Black"
# 		$btnSaveSettings.BackColor = "LightGray"
# 		$btnSaveSettings.Text = "Save Settings"
# 		$btnSaveSettings.Visible = $true
# 		$btnSaveSettings.Anchor = "Top,Right"
# 		$btnSaveSettings.Add_Click({
# 					SaveSettings
# 			})
# 		$pnlContentPanel6.Controls.Add($btnSaveSettings)
		
		
# 		# Create the Reload Settings Button
# 		LogWrite "DEBUG" "Add the Reload Settings Button"
# 		If (!($btnReloadSettings)) {$script:btnReloadSettings = New-Object System.Windows.Forms.Button}
# 		$btnReloadSettings.Width = 150
# 		$btnReloadSettings.Height = 30
# 		$btnReloadSettings.Left = ($pnlContentPanel6.Width / 2) + 15
# 		$btnReloadSettings.Top = $btnSaveSettings.Top
# 		$btnReloadSettings.Cursor = "Hand"
# 		$btnReloadSettings.FlatStyle = "Flat"
# 		$btnReloadSettings.Font = New-Object System.Drawing.Font("Arial",10)
# 		$btnReloadSettings.ForeColor = "Black"
# 		$btnReloadSettings.BackColor = "LightGray"
# 		$btnReloadSettings.Text = "Reload Settings"
# 		$btnReloadSettings.Visible = $true
# 		$btnReloadSettings.Anchor = "Top,Right"
# 		$btnReloadSettings.Add_Click({
# 					ReloadSettings
# 			})
# 		$pnlContentPanel6.Controls.Add($btnReloadSettings)
	
# 		# Reload the settings from the Registry and then Save settings to be sure everything has been saved
# 		ReloadSettings
# 		SaveSettings
	
# 	}
	

Function ShowRenumberNodesForm ($strModelName)#, $objxLightsEffects)
	{
		LogWrite "DEBUG" "Show the Renumber Nodes Form"
	
		# Draw the form
		If (!($frmRenumberNodes)) 
			{
				$script:frmRenumberNodes = New-Object System.Windows.Forms.Form
				$frmRenumberNodes.BackColor = "Azure"
				$frmRenumberNodes.Text = "Renumber Nodes"
				$frmRenumberNodes.Width = 600 #$objForm.Width * .4
				$frmRenumberNodes.Height = 350 #$objForm.Height / 4
				$frmRenumberNodes.StartPosition = "CenterScreen" # CenterScreen, Manual, WindowsDefaultLocation, WindowsDefaultBounds, CenterParent
				$frmRenumberNodes.ControlBox = $true # Show/hide the Min/Max/X buttons in the rop right corner of the window. If this is $false, the Minimize and Maximize buttons will be hidden, regardless of the settings below
				$frmRenumberNodes.MinimizeBox = $false
				$frmRenumberNodes.MaximizeBox = $false
				#$frmRenumberNodes.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::DPI
				$frmRenumberNodes.FormBorderStyle = "Fixed3D" # None, Fixed3D, FixedSingle
				$frmRenumberNodes.Topmost = $true  
				$objIcon = [system.drawing.icon]::ExtractAssociatedIcon($strFormIconPath)
				$frmRenumberNodes.Icon = $objIcon
				$frmRenumberNodes.Add_Shown({
						# Set what should happen the first time the form is shown
						$frmRenumberNodes.Activate()
						$intRenumberStartNode.Focus()
						write-host "- + $($objxLightsEffects.xrgb.models.model | Measure-Object | Select-Object -expandproperty count)"
					})
				$frmRenumberNodes.Add_Closed({
						# Try to close the On Screen Keyboard
						Try 
							{
								Stop-Process (Get-Process "osk" -ErrorAction SilentlyContinue).ID -ErrorAction SilentlyContinue
							} Catch {}
					})
			}

		# Add description label
		If (!($lblDescription)) 
			{
				$script:lblDescription = New-Object System.Windows.Forms.Label
				$lblDescription.Left = 5
				$lblDescription.Top = 10
				$lblDescription.Width = $frmRenumberNodes.Width - 10
				$lblDescription.Height = 20
				$lblDescription.TextAlign = "TopLeft"
				$lblDescription.Text = $strModelName
				$lblDescription.ForeColor = "Blue"
				$lblDescription.Font = New-Object System.Drawing.Font("Arial",12)
				$lblDescription.Anchor = "Top,Left,Right"
				$frmRenumberNodes.Controls.Add($lblDescription)
			}
	

		# Add Start Node label
		If (!($lblRenumberStartNode)) 
			{
				$script:lblRenumberStartNode = New-Object System.Windows.Forms.Label
				$lblRenumberStartNode.Left = $lblDescription.Left + 10
				$lblRenumberStartNode.Top = $lblDescription.Bottom + 20
				$lblRenumberStartNode.Width = 100
				$lblRenumberStartNode.Height = 20
				$lblRenumberStartNode.TextAlign = "MiddleLeft"
				$lblRenumberStartNode.Text = "From Node: "
				$lblRenumberStartNode.ForeColor = "Black"
				$lblRenumberStartNode.Font = New-Object System.Drawing.Font("Arial",10)
				$lblRenumberStartNode.Anchor = "Top,Left,Right"
				$frmRenumberNodes.Controls.Add($lblRenumberStartNode)
			}
		
		# Create the Start Node number box
		If (!($intRenumberStartNode)) 
			{
				$script:intRenumberStartNode = New-Object System.Windows.Forms.NumericUpDown
				$intRenumberStartNode.Width = 75
				$intRenumberStartNode.Height = 20
			    $intRenumberStartNode.Left = $lblRenumberStartNode.Right + 10
				$intRenumberStartNode.Top = $lblRenumberStartNode.Top
				$intRenumberStartNode.Font = New-Object System.Drawing.Font("Arial",10)
				$intRenumberStartNode.Minimum = "1"
				$intRenumberStartNode.Maximum = "9999"
				$intRenumberStartNode.Value = 1
				$intRenumberStartNode.Anchor = "Top,Right"
				$frmRenumberNodes.Controls.Add($intRenumberStartNode)
			}

		# Add End Node label
		If (!($lblRenumberEndNode)) 
			{
				$script:lblRenumberEndNode = New-Object System.Windows.Forms.Label
				$lblRenumberEndNode.Left = $intRenumberStartNode.Right + 10
				$lblRenumberEndNode.Top = $lblRenumberStartNode.Top
				$lblRenumberEndNode.Width = 50
				$lblRenumberEndNode.Height = $lblRenumberStartNode.Height
				$lblRenumberEndNode.TextAlign = "MiddleCenter"
				$lblRenumberEndNode.Text = "to: "
				$lblRenumberEndNode.ForeColor = "Black"
				$lblRenumberEndNode.Font = New-Object System.Drawing.Font("Arial",10)
				$lblRenumberEndNode.Anchor = "Top,Left,Right"
				$frmRenumberNodes.Controls.Add($lblRenumberEndNode)
			}
	
		# Create the End Node number box
		If (!($intRenumberEndNode)) 
			{
				$script:intRenumberEndNode = New-Object System.Windows.Forms.NumericUpDown
				$intRenumberEndNode.Width = $intRenumberStartNode.Width
				$intRenumberEndNode.Height = $intRenumberStartNode.Height
			    $intRenumberEndNode.Left = $lblRenumberEndNode.Right + 10
				$intRenumberEndNode.Top = $intRenumberStartNode.Top
				$intRenumberEndNode.Font = New-Object System.Drawing.Font("Arial",10)
				$intRenumberEndNode.Minimum = "1"
				$intRenumberEndNode.Maximum = "9999"
				$intRenumberEndNode.Value = 1
				$intRenumberEndNode.Anchor = "Top,Right"
				$frmRenumberNodes.Controls.Add($intRenumberEndNode)	
			}
	
		# Add Increment By label
		If (!($lblIncrementBy)) 
			{
				$script:lblIncrementBy = New-Object System.Windows.Forms.Label
				$lblIncrementBy.Left = $lblRenumberStartNode.Left
				$lblIncrementBy.Top = $lblRenumberStartNode.Bottom + 20
				$lblIncrementBy.Width = $lblRenumberStartNode.Width
				$lblIncrementBy.Height = $lblRenumberStartNode.Height
				$lblIncrementBy.TextAlign = "MiddleLeft"
				$lblIncrementBy.Text = "Increment By: "
				$lblIncrementBy.ForeColor = "Black"
				$lblIncrementBy.Font = New-Object System.Drawing.Font("Arial",10)
				$lblIncrementBy.Anchor = "Top,Left,Right"
				$frmRenumberNodes.Controls.Add($lblIncrementBy)
			}
		
		# Create the Increment By number box
		If (!($intIncrementBy)) 
			{
				$script:intIncrementBy = New-Object System.Windows.Forms.NumericUpDown
				$intIncrementBy.Width = $intRenumberStartNode.Width
				$intIncrementBy.Height = $intRenumberStartNode.Height
			    $intIncrementBy.Left = $intRenumberStartNode.Left
				$intIncrementBy.Top = $lblIncrementBy.Top
				$intIncrementBy.Font = New-Object System.Drawing.Font("Arial",10)
				$intIncrementBy.Minimum = "1"
				$intIncrementBy.Maximum = "100"
				$intIncrementBy.Value = 1
				$intIncrementBy.Anchor = "Top,Right"
				$frmRenumberNodes.Controls.Add($intIncrementBy)
			}

		# Add warning label
		If (!($lblUnprocessWarning)) 
			{
				$script:lblUnprocessWarning = New-Object System.Windows.Forms.Label
				$lblUnprocessWarning.Left = $lblRenumberStartNode.Left
				$lblUnprocessWarning.Top = $lblIncrementBy.Bottom + 10
				$lblUnprocessWarning.Width = $frmRenumberNodes.Width - 10
				$lblUnprocessWarning.Height = 20
				$lblUnprocessWarning.TextAlign = "TopLeft"
				$lblUnprocessWarning.Text = ""
				$lblUnprocessWarning.ForeColor = "Red"
				$lblUnprocessWarning.Font = New-Object System.Drawing.Font("Arial",10)
				$lblUnprocessWarning.Anchor = "Top,Left,Right"
				$frmRenumberNodes.Controls.Add($lblUnprocessWarning)
			}
	
#		# Add the On Screen Keyboard button
#		If (!($btnRenumberNodesOnscreenKeyboard)) 
#			{
#				$script:btnRenumberNodesOnscreenKeyboard = New-Object Windows.Forms.Button
#				$btnRenumberNodesOnscreenKeyboard.Left = 5
#				$btnRenumberNodesOnscreenKeyboard.Top = $frmRenumberNodes.Height - .Bottom + 20
#				$btnRenumberNodesOnscreenKeyboard.Width = $frmRenumberNodes.Width * .4
#				$btnRenumberNodesOnscreenKeyboard.Text = "On Screen Keyboard"
#				$btnRenumberNodesOnscreenKeyboard.TextAlign = "MiddleCenter"
#				$btnRenumberNodesOnscreenKeyboard.Cursor = "Hand"
#				$btnRenumberNodesOnscreenKeyboard.BackColor = "WhiteSmoke"
#				$btnRenumberNodesOnscreenKeyboard.Anchor = "Bottom,Left"
#				$btnRenumberNodesOnscreenKeyboard.Add_Click({
#						Start-Process -FilePath "$env:SystemRoot\System32\osk.exe"
#						$txtStartNode.Focus()
#					})
#				$frmRenumberNodes.Controls.Add($btnRenumberNodesOnscreenKeyboard)
#			}
		
		# Add the Submit button
		If (!($btnRenumberNodesSubmit)) 
			{
				$script:btnRenumberNodesSubmit = New-Object System.Windows.Forms.Button
				$btnRenumberNodesSubmit.Width = $frmRenumberNodes.Width / 6
				$btnRenumberNodesSubmit.Left = $frmRenumberNodes.Width - ($btnRenumberNodesSubmit.Width * 2) - 50
				$btnRenumberNodesSubmit.Top = $frmRenumberNodes.Height - $btnRenumberNodesSubmit.Height - 50
				$btnRenumberNodesSubmit.BackColor = "WhiteSmoke"
				$btnRenumberNodesSubmit.Text = "Save"
				$btnRenumberNodesSubmit.Anchor = "Bottom,Right"
				$btnRenumberNodesSubmit.Cursor = "Hand"
				$btnRenumberNodesSubmit.Add_Click({
				
						# Read the custom model into an array
						$objModel = $objxLightsEffects.xrgb.models.model | Where-Object {$_.Name -eq "$strModelName"}
						$strCustomModel = $objModel.CustomModel
						
						# Define the integer string (stored as a string value) to be used as a replacement for the line break semicolon
						$strLineBreakReplacement = "999999"
						
						# Replace the semicolon (line breaks) with 999999 and split the array leaving only empty space and integers
						[array]$arrToUpdate = (($strCustomModel-replace ";",$strLineBreakReplacement) -split "\D")
						
						# Read the variables from the from
						$intFirstNodeToModify = 10 #$intStartNode.Text
						$intLastNodeToModify = 65 #$intRenumberEndNode.Text
						$intIncrementNodesBy = 1 #$intIncrementBy.Text
						
						# Declare a new array to store the updates in
						[array]$arrUpdatedModel = @()
						
						# Iterate through the array.  If a number in the range, increment by the variable and add it to the array.  If a number outside of the range, the Line Break replacement, or a string, just add into the array.
						$arrToUpdate | ForEach-Object {
						
							If (IsNumeric($_) -and $_ -ne $strLineBreakReplacement)
								{
									If ($_.IndexOf($strLineBreakReplacement) -ne -1) 
										{
											# Node is at the beginning or end of a row (or both) so needs to be broken up
											$intCurrentNode = $_
										Write-Host "1 - $intCurrentNode"	
											While ($intCurrentNode.IndexOf($strLineBreakReplacement) -ne -1)
												{
													$intIndexOfSemicolon = $intCurrentNode.IndexOf($strLineBreakReplacement)
													
													If ($intIndexOfSemicolon -eq 0)
														{
															# One or more line breaks are at the beginning of the line so remove the line break replacement and add it to the array, then loop
															$intCurrentNode = $intCurrentNode.SubString(6,$intCurrentNode.Length - 6)
															[array]$arrNodesToProcess += "$strLineBreakReplacement"
												Write-Host "2 - $intCurrentNode"
														}ElseIf ($intCurrentNode.Length -eq $intIndexOfSemicolon + 6)
															{
																# A single line break is at the end of the line so remove the line break replacement and add them to the array after the node number, then loop
																$intCurrentNode = $intCurrentNode.SubString(0,$intIndexOfSemicolon)
																[array]$arrNodesToProcess += "$intCurrentNode"
																[array]$arrNodesToProcess += "$strLineBreakReplacement"
												Write-Host "3 - $intCurrentNode"
															}Else{
																	# Line break is between 2 node numbers so add the first node to the array, then remove it from the variable and loop
																	[array]$arrNodesToProcess += $intCurrentNode.SubString(0,$intIndexOfSemicolon)
																	$intCurrentNode = $intCurrentNode.SubString($intIndexOfSemicolon,$intCurrentNode.Length - $intIndexOfSemicolon)
												Write-Host "4 - $intCurrentNode"
																}
												}
											
											# Add the final entry to the array to process
											[array]$arrNodesToProcess += $intCurrentNode
											
											Remove-Variable intCurrentNode
											
										}Else {[array]$arrNodesToProcess = $_}
									
									
									$arrNodesToProcess | ForEach {
									Write-Host "5 - $_"
											If ($_ -ge $intFirstNodeToModify -and $_ -le $intLastNodeToModify)
												{
													# Node number is part of the range so increment it and add it to the updated model
													[int]$strNodeToUpdate = [int]$_ + [int]$intIncrementNodesBy
													$arrUpdatedModel += "$strNodeToUpdate"
											Write-Host "6 - $strNodeToUpdate"
													Remove-Variable strNodeToUpdate
												} Else{
														# If not blank, node is the line break replacement so just add it
														If ($_ -ne "") {$arrUpdatedModel += $_ ; Write-Host "7 - $_"}
													}
										}
										
									Remove-Variable arrNodesToProcess
									
								}Else{
										# Node is the line break replacement or not numeric so just add it
										$arrUpdatedModel += $_
									}
							}
							
						# Put the array back together again, replacing the 999999 with a semicolon and joining the rows with a comma
						$strUpdatedModel = ($arrUpdatedModel -replace $strLineBreakReplacement,";") -join ","
						
						# Write the new model into the XML
						$objModel.CustomModel = $strUpdatedModel
						
						Remove-Variable -Name objModel,strCustomModel,arrToUpdate,arrUpdatedModel
						
				
								# If rows were deleted, close the window.  If not, show the warning and leave the window open
								If ($intUnprocessedRowsTotal -gt 0)
									{
										$lblFooterTitle.Text = "$intUnprocessedRowsTotal Records Removed for $strTagToUnprocess"
										$lblFooterTitle.Forecolor = "Green"
										
										$frmRenumberNodes.Close()
										
										PlaySound "SUCCESS"
										
									}
									Else
										{
											$lblUnprocessWarning.Text = "No Records Found for $strTagToUnprocess"
											
											PlaySound "FAILURE"
											
											$txtStartNode.Focus()
											$txtStartNode.SelectAll()
											
										}
							
						
					})
				$frmRenumberNodes.Controls.Add($btnRenumberNodesSubmit)
			}
				
		# Add the Cancel button
		If (!($btnRenumberNodesCancel)) 
			{
				$script:btnRenumberNodesCancel = New-Object Windows.Forms.Button
				$btnRenumberNodesCancel.Width = $btnRenumberNodesSubmit.Width
				$btnRenumberNodesCancel.Left = $btnRenumberNodesSubmit.Right + 10
				$btnRenumberNodesCancel.Top = $btnRenumberNodesSubmit.Top
				$btnRenumberNodesCancel.Text = "Cancel"
				$btnRenumberNodesCancel.TextAlign = "MiddleCenter"
				$btnRenumberNodesCancel.Cursor = "Hand"
				$btnRenumberNodesCancel.BackColor = "WhiteSmoke"
				$btnRenumberNodesCancel.Anchor = "Bottom,Right"
				$btnRenumberNodesCancel.Add_Click({
						$frmRenumberNodes.Close()
					})
				$frmRenumberNodes.Controls.Add($btnRenumberNodesCancel)
			}
		
		
#		$frmRenumberNodes.AcceptButton = $btnRenumberNodesSubmit
#		$btnRenumberNodesSubmit.Select()
		
		$frmRenumberNodes.ShowDialog()
	
	}


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
				$lblSubHeader.ForeColor = "Blue"
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

		# Assign xLights Companion IDs to the elements in the xLights RGB Effects and, if IDs are added, save the file
		$intNewIDs = AssignCompanionIDs
		If ($intNewIDs -gt 0) {$objxLightsEffects.Save($strxlightsRGBEffectsFilePath)}

		# Load the xLights Companion File
		CreateLoadxLightsCompanionXML

		# If the Master Layout currently has no models assigned to it, check the Sync to Master checkbox
		If ((($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.name -eq "- Master (Recovery) -"}).Models.model).Count -eq 0)
			{
				$cbxSyncToMaster.Checked = $true
			}
			Else
				{
					# Load the Companion layouts
					LoadLayoutsFromCompanionXML

					# Enable the Layouts panel
					ModifyPanels "Enable" "Layouts" 
				}
	}



# # Populate the models into the list box
# Function PopulateModels
# 	{
# 		# If there are existing models, prompt to clear them
# 		If ($intAllModelsCount -gt 0)
# 			{
# 				$boolRefreshAllModels = [System.Windows.Forms.MessageBox]::Show("The list of models already exists.  Do you want to clear the list and reload from xLights? `n`nNote that this will clear the Selected Models list as well.","Reload Models" , "YesNo", "Exclamation")
					
# 				# Check to see if a Proceed flag has been set
# 				If ($boolRefreshAllModels -eq "Yes")
# 					{
# 						$lbxMasterModels.BeginUpdate()
# 							$lbxMasterModels.Items.Clear()
# 						$lbxMasterModels.EndUpdate()
						
# 						$lbxLayoutModels.BeginUpdate()
# 							$lbxLayoutModels.Items.Clear()
# 						$lbxLayoutModels.EndUpdate()
						
# 						$script:intAllModelsCount = $null

# 						# If ($lblModelDescriptionLabel1) {$lblModelDescriptionLabel1.Text = ""}
# 						# If ($lblModelDescriptionLabel2) {$lblModelDescriptionLabel2.Text = ""}
# 						# If ($lblModelDescriptionLabel3) {$lblModelDescriptionLabel3.Text = ""}
# 						# If ($lblModelDescriptionLabel4) {$lblModelDescriptionLabel4.Text = ""}
						
# 					}
# 			}
		
# 		# # If the model list is empty, populate it
# 		# If ($null -eq $intAllModelsCount)
# 		# 	{
# 		# 		LoadRGBEffects
				
# 		# 		$lbxMasterModels.BeginUpdate()
# 		# 			ForEach ($objModel in $objxLightsEffects.xrgb.models.ChildNodes) {$lbxMasterModels.Items.Add($objModel.Name)}
# 		# 		$lbxMasterModels.EndUpdate()
				
# 		# 		$script:intAllModelsCount = $lbxMasterModels.Count
# 		# 	}
# 	}

	
Function MoveModelsToFromLayout ($strAddRemove, $strModelName)
	{
		If ($strModelName -and $lbxLayouts.SelectedItem)
			{
				If ($strAddRemove -eq "ADD")
					{
						$lbxMasterModels.BeginUpdate()
						$lbxLayoutModels.BeginUpdate()
							
							$lbxLayoutModels.Items.Add($strModelName)
							$lbxMasterModels.Items.Remove($strModelName)
					
						$lbxMasterModels.EndUpdate()
						$lbxLayoutModels.EndUpdate()

						# # Clear the desciption labels
						# $lblModelDescriptionLabel1.Text = ""
						# $lblModelDescriptionLabel2.Text = ""
						# $lblModelDescriptionLabel3.Text = ""
						# $lblModelDescriptionLabel4.Text = ""

						# Hide unnecessary elements
						$btnRenumberNodes.Visible = $false

						# Set the flag, lock the listbox, disable the form submit button and enable the layout buttons
						$global:boolLayoutModelsChanged = $true
						$lbxLayouts.Enabled = $false
						$btnFormSubmit.Enabled = $false
						$btnFormSubmit.BackColor = "WhiteSmoke"
						$btnSaveLayout.Visible = $true
						$btnCancelReloadLayout.Visible = $true

						ModifyPanels "Disable" "SyncFrom"
						$cbxSyncToMaster.Enabled = $false
						ModifyPanels "Disable" "CommitToxLights"

					}
					ElseIf ($strAddRemove -eq "REMOVE")
						{
							$lbxMasterModels.BeginUpdate()
							$lbxLayoutModels.BeginUpdate()
						
								$lbxMasterModels.Items.Add($strModelName)
								$lbxLayoutModels.Items.Remove($strModelName)
							
							$lbxMasterModels.EndUpdate()
							$lbxLayoutModels.EndUpdate()
							
							# # Clear the desciption labels
							# $lblModelDescriptionLabel1.Text = ""
							# $lblModelDescriptionLabel2.Text = ""
							# $lblModelDescriptionLabel3.Text = ""
							# $lblModelDescriptionLabel4.Text = ""
							
							# Hide unnecessary elements
							$btnRenumberNodes.Visible = $false

							# Set the flag, lock the listbox, disable the form submit button and enable the layout buttons
							$global:boolLayoutModelsChanged = $true
							$lbxLayouts.Enabled = $false
							$btnFormSubmit.Enabled = $false
							$btnFormSubmit.BackColor = "WhiteSmoke"
							$btnSaveLayout.Visible = $true
							$btnCancelReloadLayout.Visible = $true

							ModifyPanels "Disable" "SyncFrom"
							$cbxSyncToMaster.Enabled = $false
							ModifyPanels "Disable" "CommitToxLights"
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
						$lbxMasterModelGroups.BeginUpdate()
						$lbxLayoutModelGroups.BeginUpdate()
							
							$lbxLayoutModelGroups.Items.Add($strModelGroupName)
							$lbxMasterModelGroups.Items.Remove($strModelGroupName)
					
						$lbxMasterModelGroups.EndUpdate()
						$lbxLayoutModelGroups.EndUpdate()

						# Set the flag, lock the listbox, disable the form submit button and enable the layout buttons
						$global:boolLayoutModelGroupsChanged = $true
						$lbxLayouts.Enabled = $false
						$btnFormSubmit.Enabled = $false
						$btnFormSubmit.BackColor = "WhiteSmoke"
						$btnSaveLayout.Visible = $true
						$btnCancelReloadLayout.Visible = $true

					}
					ElseIf ($strAddRemove -eq "REMOVE")
						{
							$lbxMasterModelGroups.BeginUpdate()
							$lbxLayoutModelGroups.BeginUpdate()
						
								$lbxMasterModelGroups.Items.Add($strModelGroupName)
								$lbxLayoutModelGroups.Items.Remove($strModelGroupName)
							
							$lbxMasterModelGroups.EndUpdate()
							$lbxLayoutModelGroups.EndUpdate()
							
							# Hide unnecessary elements
							$btnRenumberNodes.Visible = $false

							# Set the flag, lock the listbox, disable the form submit button and enable the layout buttons
							$global:boolLayoutModelGroupsChanged = $true
							$lbxLayouts.Enabled = $false
							$btnFormSubmit.Enabled = $false
							$btnFormSubmit.BackColor = "WhiteSmoke"
							$btnSaveLayout.Visible = $true
							$btnCancelReloadLayout.Visible = $true

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
						$lbxMasterViews.BeginUpdate()
						$lbxLayoutViews.BeginUpdate()
							
							$lbxLayoutViews.Items.Add($strViewName)
							$lbxMasterViews.Items.Remove($strViewName)
					
						$lbxMasterViews.EndUpdate()
						$lbxLayoutViews.EndUpdate()

						# Set the flag, lock the listbox, disable the form submit button and enable the layout buttons
						$global:boolLayoutViewsChanged = $true
						$lbxLayouts.Enabled = $false
						$btnFormSubmit.Enabled = $false
						$btnFormSubmit.BackColor = "WhiteSmoke"
						$btnSaveLayout.Visible = $true
						$btnCancelReloadLayout.Visible = $true

					}
					ElseIf ($strAddRemove -eq "REMOVE")
						{
							$lbxMasterViews.BeginUpdate()
							$lbxLayoutViews.BeginUpdate()
						
								$lbxMasterViews.Items.Add($strViewName)
								$lbxLayoutViews.Items.Remove($strViewName)
							
							$lbxMasterViews.EndUpdate()
							$lbxLayoutViews.EndUpdate()
							
							# Hide unnecessary elements
							$btnRenumberNodes.Visible = $false

							# Set the flag, lock the listbox, disable the form submit button and enable the layout buttons
							$global:boolLayoutViewsChanged = $true
							$lbxLayouts.Enabled = $false
							$btnFormSubmit.Enabled = $false
							$btnFormSubmit.BackColor = "WhiteSmoke"
							$btnSaveLayout.Visible = $true
							$btnCancelReloadLayout.Visible = $true

						}
						Else
							{
								LogWrite "WARNING" "Modify Layout Model Groups called with invalid parameter ($strAddRemove)"
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
				$global:pnlSyncFrom = New-Object System.Windows.Forms.Panel
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

						$dtStartSync = Get-Date

						# Disable the controls
						$btnSyncFromxLights.Text = "Processing...."
						$btnSyncFromxLights.Forecolor = "Blue"
						
						# Call the functions to sync the models, model groups, and views.  If Sync to Master is checked, sync to the master layout
						SyncModelsToCompanion -strLayout $(If ($cbxSyncToMaster.Checked -eq $true) {"- Master (Recovery) -"} Else {$lbxLayouts.SelectedItem}) -strActiveInactiveAll "All" -boolOverridePrompts $true
						SyncModelGroupsToCompanion -strLayout $(If ($cbxSyncToMaster.Checked -eq $true) {"- Master (Recovery) -"} Else {$lbxLayouts.SelectedItem}) -boolOverridePrompts $true
						SyncViewsToCompanion -strLayout $(If ($cbxSyncToMaster.Checked -eq $true) {"- Master (Recovery) -"} Else {$lbxLayouts.SelectedItem}) -boolOverridePrompts $true

						# If Sync to Master, reload the Master list boxes
						If ($cbxSyncToMaster.Checked -eq $true)
							{
								LoadMasterResourcesFromCompanionXML -strNodeType "Model" -boolLoadListboxes $true -boolCheckForUpdates $false
								LoadMasterResourcesFromCompanionXML -strNodeType "ModelGroup" -boolLoadListboxes $true -boolCheckForUpdates $false
								LoadMasterResourcesFromCompanionXML -strNodeType "View" -boolLoadListboxes $true -boolCheckForUpdates $false
							}

						# If a layout is selected, reload the models
						If ($lbxLayouts.SelectedItem)
							{
								LoadLayoutResourcesFromCompanionXML -strLayoutName $lbxLayouts.SelectedItem -strNodeType "Model"
								LoadLayoutResourcesFromCompanionXML -strLayoutName $lbxLayouts.SelectedItem -strNodeType "ModelGroup"
								LoadLayoutResourcesFromCompanionXML -strLayoutName $lbxLayouts.SelectedItem -strNodeType "View"
							}

						# Load the Companion layouts
						LoadLayoutsFromCompanionXML

						# Enable the Layouts panel
						ModifyPanels "Enable" "Layouts" 

						# Disable Sync From
						ModifyPanels "Disable" "SyncFrom"
						
						$cbxSyncToMaster.ForeColor = "Black"

						$intSyncDuration = New-TimeSpan -Start $dtStartSync -End $(Get-Date)
						
						$btnSyncFromxLights.Text = "Sync Complete in $([math]::Round($intSyncDuration.TotalSeconds))s"

						

					})
					
				$pnlSyncFrom.Controls.Add($btnSyncFromxLights)
			}

		
		# Create the Sync To Layout label
		If (!($lblSyncToLayout)) 
			{
				$global:lblSyncToLayout = New-Object System.Windows.Forms.Label
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


		# Add the Sync to Master checkbox
		If (!($cbxSyncToMaster)) 
			{
				$script:cbxSyncToMaster = New-Object Windows.Forms.CheckBox
				$cbxSyncToMaster.Left = $btnSyncFromxLights.Left + 10
				$cbxSyncToMaster.Top = $btnSyncFromxLights.Bottom + 10
				$cbxSyncToMaster.Text = "Sync to Master"
				$cbxSyncToMaster.Width = 300
				$cbxSyncToMaster.TextAlign = "MiddleLeft"
				$cbxSyncToMaster.Cursor = "Hand"
				$cbxSyncToMaster.ForeColor = "Black"
				$cbxSyncToMaster.BackColor = "Transparent"
				$cbxSyncToMaster.Checked = $false
				$cbxSyncToMaster.Anchor = "Left,Top"
				$cbxSyncToMaster.Add_Click({
					If ($cbxSyncToMaster.Checked -eq $true)
						{
							$cbxSyncToMaster.ForeColor = "Green"

							$lbxLayouts.ClearSelected()

							ModifyPanels "Enable" "SyncFrom"
							ModifyPanels "Disable" "CommitToxLights"
							ModifyPanels "Disable" "Layouts"
							ModifyPanels "Disable" "Models"
							ModifyPanels "Disable" "ModelGroups"
							ModifyPanels "Disable" "Views"
							
							# $btnSyncFromxLights.Enabled = $true
							$btnSyncFromxLights.Text = "Sync From xLights"
							$lblSyncToLayout.Text = "...to Master"
						}
						Else
							{
								If ($lbxLayouts.SelectedItem)
									{
										$cbxSyncToMaster.Forecolor = "Black"

										$lbxLayouts.ClearSelected()

										ModifyPanels "Disable" "SyncFrom"
										ModifyPanels "Enable" "Layouts"
										ModifyPanels "Enable" "CommitToxLights"

										# $btnSyncFromxLights.Enabled = $true
										$btnSyncFromxLights.Text = "Sync From xLights"
										$lblSyncToLayout.Text = "...to '$($lbxLayouts.SelectedItem)' Layout"
									}
									Else
										{
											$cbxSyncToMaster.Forecolor = "Black"

											ModifyPanels "Disable" "SyncFrom"
											ModifyPanels "Enable" "Layouts"
											ModifyPanels "Disable" "CommitToxLights"

											# $btnSyncFromxLights.Enabled = $false
											$btnSyncFromxLights.Text = "Sync From xLights"
											$lblSyncToLayout.Text = ""
										}
							}
				})
				$pnlSyncFrom.Controls.Add($cbxSyncToMaster)
			}



		# Add the Prompt To Overwrite Model checkbox
		If (!($cbxPromptToOverwriteModels)) 
			{
				$script:cbxPromptToOverwriteModels = New-Object Windows.Forms.CheckBox
				$cbxPromptToOverwriteModels.Left = $cbxSyncToMaster.Left
				$cbxPromptToOverwriteModels.Top = $cbxSyncToMaster.Bottom + 5
				$cbxPromptToOverwriteModels.Text = "Overwrite Existing Models Without Prompting"
				$cbxPromptToOverwriteModels.Width = 300
				$cbxPromptToOverwriteModels.TextAlign = "MiddleLeft"
				$cbxPromptToOverwriteModels.Cursor = "Hand"
				$cbxPromptToOverwriteModels.ForeColor = "Black"
				$cbxPromptToOverwriteModels.BackColor = "Transparent"
				$cbxPromptToOverwriteModels.Checked = $true
				$cbxPromptToOverwriteModels.Anchor = "Left,Top"
				$pnlSyncFrom.Controls.Add($cbxPromptToOverwriteModels)
			}



		
		# Add the Prompt To Overwrite Model checkbox
		If (!($cbxPromptToCreateNewInCompanion)) 
			{
				$script:cbxPromptToCreateNewInCompanion = New-Object Windows.Forms.CheckBox
				$cbxPromptToCreateNewInCompanion.Left = $cbxPromptToOverwriteModels.Left
				$cbxPromptToCreateNewInCompanion.Top = $cbxPromptToOverwriteModels.Bottom + 5
				$cbxPromptToCreateNewInCompanion.Text = "Prompt on New or Replacement Models"
				$cbxPromptToCreateNewInCompanion.Width = $cbxPromptToOverwriteModels.Width
				$cbxPromptToCreateNewInCompanion.TextAlign = "MiddleLeft"
				$cbxPromptToCreateNewInCompanion.Cursor = "Hand"
				$cbxPromptToCreateNewInCompanion.ForeColor = "Black"
				$cbxPromptToCreateNewInCompanion.BackColor = "Transparent"
				$cbxPromptToCreateNewInCompanion.Checked = $false
				$cbxPromptToCreateNewInCompanion.Anchor = "Left,Top"
				$pnlSyncFrom.Controls.Add($cbxPromptToCreateNewInCompanion)
			}


		####################################
		# Layouts
		####################################

		# Layouts Panel
		If (!($pnlLayouts)) 
			{
				$global:pnlLayouts = New-Object System.Windows.Forms.Panel
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
				$global:lblLayouts = New-Object System.Windows.Forms.Label
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
				$lbxLayouts.SelectionMode = "MultiExtended"
				$lbxLayouts.Sorted = $true
				$lbxLayouts.Visible = $true
				$lbxLayouts.Anchor = "Left,Right,Top"
				$lbxLayouts.Add_Click({
						
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
									
									# Load the master resouce list boxes
									LoadMasterResourcesFromCompanionXML -strNodeType "Model" -boolLoadListboxes $true -boolCheckForUpdates $false
									LoadMasterResourcesFromCompanionXML -strNodeType "ModelGroup" -boolLoadListboxes $true -boolCheckForUpdates $false
									LoadMasterResourcesFromCompanionXML -strNodeType "View" -boolLoadListboxes $true -boolCheckForUpdates $false

									# Enable the content panels
									ModifyPanels "Enable" "Models" 
									ModifyPanels "Enable" "ModelGroups" 
									ModifyPanels "Enable" "Views" 
									ModifyPanels "Enable" "SyncFrom"
									ModifyPanels "Enable" "CommitToxLights"

									# $btnSyncFromxLights.Enabled = $true
									$btnSyncFromxLights.Text = "Sync From xLights"
									$lblSyncToLayout.Text = "...to '$($lbxLayouts.SelectedItem)' Layout"
									
								}
								Else
									{
										# Disable the content panels
										ModifyPanels "Disable" "Models" 
										ModifyPanels "Disable" "ModelGroups" 
										ModifyPanels "Disable" "Views"
										ModifyPanels "Disable" "SyncFrom"
										ModifyPanels "Disable" "CommitToxLights"

										# $btnSyncFromxLights.Enabled = $false
										$btnSyncFromxLights.Text = "Sync From xLights"
										$lblSyncToLayout.Text = ""
									}
						
					})
				$pnlLayouts.Controls.Add($lbxLayouts)
			}


		####################################
		# Add/Remove Layout Buttons
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
				$btnAddLayout.Anchor = "Left,Top"
				$btnAddLayout.Add_Click({
				
						# Prompt for the layout name
						$strNewLayoutName = [Microsoft.VisualBasic.Interaction]::InputBox("Enter a name for the new layout", "New Layout Name")

						# Add code here to validate/sanitize the entered name

						AddLayout $strNewLayoutName

						LoadLayoutsFromCompanionXML
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
				$btnRemoveLayout.Anchor = "Top,Left"
				$btnRemoveLayout.Add_Click({
				
						# Remove the selected layout
						If ($lbxLayouts.SelectedItem)
							{
								If ($lbxLayouts.SelectedItem -notin ("- Common -", "- Master (Recovery) -"))
									{
										RemoveLayout $lbxLayouts.SelectedItem
								
										LoadLayoutsFromCompanionXML
									}
									Else
										{
											LogWrite "WARNING" "The ""$($lbxLayouts.SelectedItem)"" layout cannot be removed."
										}
							}
					})
				$pnlLayouts.Controls.Add($btnRemoveLayout)
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
								$boolReloadModels = [System.Windows.Forms.MessageBox]::Show("Are you sure you want to discard any changes to ""$($lbxLayouts.SelectedItem)"" without saving?" , "Discard Changes?", "YesNo", "Exclamation")

								If ($boolReloadModels -eq "Yes")
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

										# Clear the layout models
										$lbxLayouts.ClearSelected()
										$lbxLayouts.Enabled = $true
										$btnFormSubmit.Enabled = $true
										If ($boolxLightsCompanionXMLIsChanged) {$btnFormSubmit.BackColor = "Green"}
										$btnSaveLayout.Visible = $false
										$btnCancelReloadLayout.Visible = $false
										
										$global:boolLayoutModelsChanged = $false
										$global:boolLayoutModelGroupsChanged = $false
										$global:boolLayoutViewsChanged = $false

										LoadMasterResourcesFromCompanionXML -strNodeType "Model"	-boolLoadListBoxes $true -boolCheckForUpdates $false
										LoadMasterResourcesFromCompanionXML -strNodeType "ModelGroup" -boolLoadListBoxes $true -boolCheckForUpdates $false
										LoadMasterResourcesFromCompanionXML -strNodeType "View"	-boolLoadListBoxes $true -boolCheckForUpdates $false

										ModifyPanels "Disable" "SyncFrom"
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
									
					})
				$pnlLayouts.Controls.Add($btnSaveLayout)
			}


		####################################
		# Commmit Layout to xLights 
		####################################

		# CommitLayout Panel
		If (!($pnlCommitxLights)) 
			{
				$global:pnlCommitxLights = New-Object System.Windows.Forms.Panel
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
				$btnCommitLayoutToxLights.Width = 200
				$btnCommitLayoutToxLights.Height = 40
				$btnCommitLayoutToxLights.Left = $pnlCommitxLights.Width / 2 - $btnCommitLayoutToxLights.Width / 2
				$btnCommitLayoutToxLights.Top = $pnlCommitxLights.Height / 2 - $btnCommitLayoutToxLights.Height / 2
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


			# Create the open xLights button
			If (!($lblOpenLayoutInxLights)) 
				{
					$global:lblOpenLayoutInxLights = New-Object System.Windows.Forms.Label
					$lblOpenLayoutInxLights.Width = $pnlCommitxLights.Width - 6
					$lblOpenLayoutInxLights.Height = 20
					$lblOpenLayoutInxLights.Left = 3
					$lblOpenLayoutInxLights.Top = $btnCommitLayoutToxLights.Bottom + 10
					$lblOpenLayoutInxLights.TextAlign = "MiddleCenter"
					$lblOpenLayoutInxLights.ForeColor = "Blue"
					$lblOpenLayoutInxLights.Backcolor = "Transparent"
					$lblOpenLayoutInxLights.Text = ""
					$lblOpenLayoutInxLights.Anchor = "Left,Top"
			#		$lblOpenLayoutInxLights.Cursor = "Hand"
					# $lblOpenLayoutInxLights.Add_Click({
					# })
					$pnlCommitxLights.Controls.Add($lblOpenLayoutInxLights)
				}


		# # Add the Prompt To Overwrite Model checkbox
		# If (!($cbxPromptToOverwriteModels)) 
		# 	{
		# 		$script:cbxPromptToOverwriteModels = New-Object Windows.Forms.CheckBox
		# 		$cbxPromptToOverwriteModels.Left = $btnSyncFromxLights.Left + 10
		# 		$cbxPromptToOverwriteModels.Top = $btnSyncFromxLights.Bottom + 10
		# 		$cbxPromptToOverwriteModels.Text = "Overwrite Existing Models Without Prompting"
		# 		$cbxPromptToOverwriteModels.Width = 300
		# 		$cbxPromptToOverwriteModels.TextAlign = "MiddleLeft"
		# 		$cbxPromptToOverwriteModels.Cursor = "Hand"
		# 		$cbxPromptToOverwriteModels.ForeColor = "Black"
		# 		$cbxPromptToOverwriteModels.BackColor = "Transparent"
		# 		$cbxPromptToOverwriteModels.Checked = $true
		# 		$cbxPromptToOverwriteModels.Anchor = "Left,Top"
		# 		$pnlCommitxLights.Controls.Add($cbxPromptToOverwriteModels)
		# 	}



		
		# # Add the Prompt To Overwrite Model checkbox
		# If (!($cbxPromptToCreateNewInCompanion)) 
		# 	{
		# 		$script:cbxPromptToCreateNewInCompanion = New-Object Windows.Forms.CheckBox
		# 		$cbxPromptToCreateNewInCompanion.Left = $cbxPromptToOverwriteModels.Left
		# 		$cbxPromptToCreateNewInCompanion.Top = $cbxPromptToOverwriteModels.Bottom + 5
		# 		$cbxPromptToCreateNewInCompanion.Text = "Prompt on New or Replacement Models"
		# 		$cbxPromptToCreateNewInCompanion.Width = $cbxPromptToOverwriteModels.Width
		# 		$cbxPromptToCreateNewInCompanion.TextAlign = "MiddleLeft"
		# 		$cbxPromptToCreateNewInCompanion.Cursor = "Hand"
		# 		$cbxPromptToCreateNewInCompanion.ForeColor = "Black"
		# 		$cbxPromptToCreateNewInCompanion.BackColor = "Transparent"
		# 		$cbxPromptToCreateNewInCompanion.Checked = $false
		# 		$cbxPromptToCreateNewInCompanion.Anchor = "Left,Top"
		# 		$pnlCommitxLights.Controls.Add($cbxPromptToCreateNewInCompanion)
		# 	}




		####################################
		# Models
		####################################

		# Model Panel
		If (!($pnlModels)) 
			{
				$global:pnlModels = New-Object System.Windows.Forms.Panel
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


		# Create the Layout Models Label
		If (!($lblLayoutModels)) 
			{
				$global:lblLayoutModels = New-Object System.Windows.Forms.Label
				$lblLayoutModels.Width = $pnlContentPanel2.Width * .15
				$lblLayoutModels.Height = 20
				$lblLayoutModels.Left = 10
				$lblLayoutModels.Top = 10
				$lblLayoutModels.TextAlign = "MiddleLeft"
				$lblLayoutModels.ForeColor = "Blue"
				$lblLayoutModels.Backcolor = "Transparent"
				$lblLayoutModels.Text = "Layout Models"
				
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
				$lbxLayoutModels.Width = $pnlModels.Width - 20
				$lbxLayoutModels.Height = ($pnlModels.Height - 130) / 2
				$lbxLayoutModels.SelectionMode = "MultiExtended"
				$lbxLayoutModels.Sorted = $true
				$lbxLayoutModels.Visible = $true
				$lbxLayoutModels.Enabled = $false
				$lbxLayoutModels.Anchor = "Left,Right,Top"
				$lbxLayoutModels.Add_DoubleClick({
				
						# If the Master List is not currently being filtered (nothing has been searched for), modify the list
						If ($txtFilterMasterModels.Text -eq $strDefaultFilterText)
							{
								# Remove the selected item from the listbox
								MoveModelsToFromLayout "REMOVE" $lbxLayoutModels.SelectedItem
							}
						
				})
				$pnlModels.Controls.Add($lbxLayoutModels)
			}
			
			
		####################################
		# Master Models
		####################################

		# Create the Master Models label
		If (!($lblMasterModels)) 
			{
				$global:lblMasterModels = New-Object System.Windows.Forms.Label
				$lblMasterModels.Width = $lblLayoutModels.Width
				$lblMasterModels.Height = $lblLayoutModels.Height
				$lblMasterModels.Left = $lblLayoutModels.Left
				$lblMasterModels.Top = $lbxLayoutModels.Bottom + 50
				$lblMasterModels.TextAlign = "MiddleLeft"
				$lblMasterModels.ForeColor = "Green"
				$lblMasterModels.Backcolor = "Transparent"
				$lblMasterModels.Text = "Master Models"
				$lblMasterModels.Anchor = "Right,Top"
		#		$lblMasterModels.Cursor = "Hand"
		#		$lblMasterModels.Add_Click({
		#							})
				$pnlModels.Controls.Add($lblMasterModels)
			}
		
		# Create the Master Models Listbox
		If (!($lbxMasterModels)) 
			{
				$script:lbxMasterModels = New-Object System.Windows.Forms.ListBox
				$lbxMasterModels.Left = $lblMasterModels.Left
				$lbxMasterModels.Top = $lblMasterModels.Bottom + 5
				$lbxMasterModels.Width = $lbxLayoutModels.Width
				$lbxMasterModels.Height = $lbxLayoutModels.Height
				$lbxMasterModels.SelectionMode = "MultiExtended"
				$lbxMasterModels.Sorted = $true
				$lbxMasterModels.Visible = $true
				$lbxMasterModels.Enabled = $false
				$lbxMasterModels.Anchor = "Right,Top"
				# $lbxMasterModels.Add_Click({
				
				# 	# If an item is selected, populate the details labels with the properties of that item from the xLights XML file
				# 	If ($lbxMasterModels.SelectedItem)
				# 		{
				# 			# Set the ReNumber Nodes button to visible
				# 			$btnRenumberNodes.Visible = $true
					
				# 			# Get the selected item from the XMl file
				# 			$objMasterModel = $objxLightsEffects.xrgb.ChildNodes.Model | Where-Object {$_.Name -eq $lbxMasterModels.SelectedItem}
							
				# 			# Get the properties of the selected item from the XML file
				# 			If ($objMasterModel.Active -eq 0) {$strModelActive = $false} Else {$strModelActive = $true}
				# 			If ($objMasterModel.ControllerConnection.Brightness) {$strModelBrightness = $objMasterModel.ControllerConnection.Brightness} Else {$strModelBrightness = 100}
				# 			If ($objMasterModel.PixelCount)
				# 				{$intModelNodeCount = $objMasterModel.PixelCount}
				# 				ElseIf ($objMasterModel.CustomModel)
				# 					{
				# 						$intModelNodeCount = $objMasterModel.CustomModel -split {$_ -eq "," -or $_ -eq ";"} | Measure-Object -Maximum | Select-Object -ExpandProperty Maximum
				# 					}
				# 					Else
				# 						{
				# 							$intModelNodeCount = ([int]$objMasterModel.parm1 * [int]$objMasterModel.parm2)
				# 						}
							
				# 			# # Populate the labels with the properties
				# 			# $lblModelDescriptionLabel1.Text = "Brightness: $strModelBrightness"
				# 			# $lblModelDescriptionLabel2.Text = "Active: $strModelActive"
				# 			# $lblModelDescriptionLabel3.Text = "Model Node Count: $intModelNodeCount"
							
				# 			# # Color code the labels according to property values
				# 			# $lblModelDescriptionLabel1.ForeColor = $(If ($strModelBrightness -le 20) {"Blue"} ElseIf ($strModelBrightness -le 30) {"Green"} ElseIf ($strModelBrightness -le 60) {"Yellow"} Else {"Red"})
				# 			# $lblModelDescriptionLabel2.ForeColor = $(If ($strModelActive) {"Green"} Else {"Gray"})
							
				# 		}
				# })
				$lbxMasterModels.Add_DoubleClick({
						
						# If the layout models list is not currently being filtered, modify the list
						If ($txtFilterLayoutModels.Text -eq $strDefaultFilterText)
							{
								MoveModelsToFromLayout "ADD" $lbxMasterModels.SelectedItem
							}
						
					})
				$pnlModels.Controls.Add($lbxMasterModels)
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
						
						# If ($arrCurrentListOfMasterModels.Length -gt 0)
						If ($arrCurrentListOfActiveModels.Length -gt 0)
							{
								# If the filter text box is currently hiding the filter reset button, resize the text box to show the button
								If ($txtFilterLayoutModels.Right -eq $btnResetFilterLayoutModels.Right) {$txtFilterLayoutModels.Width = $txtFilterLayoutModels.Width - $btnResetFilterLayoutModels.Width - 2}
								
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
		# Master Model Filters
		####################################

		# Filter Master Models
		If (!($txtFilterMasterModels)) 
			{
				$script:txtFilterMasterModels = New-Object System.Windows.Forms.TextBox
				$txtFilterMasterModels.Left = $lblMasterModels.Right
				$txtFilterMasterModels.Top = $lblMasterModels.Top
				$txtFilterMasterModels.Width = $lbxMasterModels.Width - $lblMasterModels.Width
				$txtFilterMasterModels.Height = 30
				$txtFilterMasterModels.Font = New-Object System.Drawing.Font("Arial",10)
				$txtFilterMasterModels.ForeColor = "Gray"
				$txtFilterMasterModels.BackColor = "LightGray"
				$txtFilterMasterModels.Text = $strDefaultFilterText
				$txtFilterMasterModels.Anchor = "Top,Right"
				$pnlModels.Controls.Add($txtFilterMasterModels)
				
				# Add Enter Event
				$txtFilterMasterModels.Add_Enter({
						If ($txtFilterMasterModels.Text -eq $strDefaultFilterText)
							{
								$txtFilterMasterModels.Text = ""
							}
						$txtFilterMasterModels.SelectAll()
						$txtFilterMasterModels.ForeColor = "Black"
						$txtFilterMasterModels.BackColor = "White"
						
						If (!($arrCurrentListOfMasterModels)) {[array]$script:arrCurrentListOfMasterModels = $lbxMasterModels.Items}
					})
					
				# Add Leave Event
				$txtFilterMasterModels.Add_Leave({
						If ($txtFilterMasterModels.Text -eq "") 
							{
								ClearListBoxFilter -strTarget "Master" -strType "Model"
							}
					})
					
				# Add KeyUp Event
				$txtFilterMasterModels.Add_KeyUp({
						
						If ($txtFilterMasterModels.Right -eq $btnResetFilterMasterModels.Right) {$txtFilterMasterModels.Width = $txtFilterMasterModels.Width - $btnResetFilterMasterModels.Width - 2}
						
						If ($lblMasterModels.Text -notlike "* (Filtered)") {$lblMasterModels.Text += " (Filtered)"}

						# Disable buttons allowing movement 'into' Master Models while the filter is applied
						$btnMoveAllModelsDown.Enabled = $false
						$btnMoveModelDown.Enabled = $false
				
						$lbxMasterModels.BeginUpdate()
							$lbxMasterModels.Items.Clear()
							$arrCurrentListOfMasterModels | Where-Object {$_ -like "*$($txtFilterMasterModels.Text)*"} | ForEach-Object {If ($_) {$lbxMasterModels.Items.Add($_)}}
						$lbxMasterModels.EndUpdate()
						
						# # Clear the desciption labels
						# $lblModelDescriptionLabel1.Text = ""
						# $lblModelDescriptionLabel2.Text = ""
						# $lblModelDescriptionLabel3.Text = ""
						# $lblModelDescriptionLabel4.Text = ""
						
						# Hide unnecessary elements
						$btnRenumberNodes.Visible = $false
					})
			}
		
		# Add the Reset Filter Master Models button
		If (!($btnResetFilterMasterModels)) 
			{
				$script:btnResetFilterMasterModels = New-Object Windows.Forms.Button
				$btnResetFilterMasterModels.Width = 20
				$btnResetFilterMasterModels.Height = 25
				$btnResetFilterMasterModels.Left = $lbxMasterModels.Right - $btnResetFilterMasterModels.Width
				$btnResetFilterMasterModels.Top = $lblMasterModels.Top - 1
				$btnResetFilterMasterModels.Text = "X"
				$btnResetFilterMasterModels.TextAlign = "MiddleCenter"
				$btnResetFilterMasterModels.Cursor = "Hand"
				$btnResetFilterMasterModels.ForeColor = "Black"
				$btnResetFilterMasterModels.BackColor = "WhiteSmoke"
				$btnResetFilterMasterModels.Anchor = "Top,Right"
				$btnResetFilterMasterModels.Add_Click({
						
						ClearListBoxFilter -strTarget "Master" -strType "Model"
						
					})
				$pnlModels.Controls.Add($btnResetFilterMasterModels)
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
				$btnMoveModelUp.Anchor = "Top,Right"
				$btnMoveModelUp.Add_Click({

						[array]$arrItemsToMoveUp = $lbxMasterModels.SelectedItems

						ForEach ($objItemToMoveUp in $arrItemsToMoveUp)
							{
								MoveModelsToFromLayout "ADD" $objItemToMoveUp
							}
						
						$lbxMasterModels.ClearSelected()
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
				$btnMoveAllModelsUp.Anchor = "Top,Right"
				$btnMoveAllModelsUp.Add_Click({
				
						[array]$arrItemsToMoveUp = $lbxMasterModels.Items

						ForEach ($objItemToMoveUp in $arrItemsToMoveUp)
							{
								MoveModelsToFromLayout "ADD" $objItemToMoveUp
							}

						$lbxMasterModels.ClearSelected()
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
				$btnMoveModelDown.Anchor = "Top,Right"
				$btnMoveModelDown.Add_Click({
				
						[array]$arrItemsToMoveDown = $lbxLayoutModels.SelectedItems

						ForEach ($objItemToMoveDown in $arrItemsToMoveDown)
							{
								MoveModelsToFromLayout "REMOVE" $objItemToMoveDown
							}
						
						$lbxMasterModels.ClearSelected()
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
				$btnMoveAllModelsDown.Anchor = "Top,Right"
				$btnMoveAllModelsDown.Add_Click({
				
						[array]$arrItemsToMoveDown = $lbxLayoutModels.Items

						ForEach ($objItemToMoveDown in $arrItemsToMoveDown)
							{
								#Write-Host "Move $objItemToMoveDown"
								MoveModelsToFromLayout "REMOVE" $objItemToMoveDown
							}

						$lbxMasterModels.ClearSelected()
						$lbxLayoutModels.ClearSelected()
				
						Remove-Variable objItemToMoveDown -ErrorAction SilentlyContinue
						Remove-Variable arrItemsToMoveDown -ErrorAction SilentlyContinue
					})
				$pnlModels.Controls.Add($btnMoveAllModelsDown)
			}
	
	
		# ####################################
		# # Create the Model Description Labels
		# ####################################

		# # Add Description Label 1
		# If (!($lblModelDescriptionLabel1)) 
		# 	{
		# 		$global:lblModelDescriptionLabel1 = New-Object System.Windows.Forms.Label
		# 		$lblModelDescriptionLabel1.Width = $pnlContentPanel2.Width - $lbxMasterModels.Right - 20
		# 		$lblModelDescriptionLabel1.Height = 20
		# 		$lblModelDescriptionLabel1.Left = $lbxMasterModels.Right + 10
		# 		$lblModelDescriptionLabel1.Top = $lbxMasterModels.Top
		# 		$lblModelDescriptionLabel1.TextAlign = "MiddleLeft"
		# 		$lblModelDescriptionLabel1.ForeColor = "Black"
		# 		$lblModelDescriptionLabel1.Backcolor = "Transparent"
		# 		$lblModelDescriptionLabel1.Text = ""
		# 		$lblModelDescriptionLabel1.Anchor = "Left,Right,Top"
		# #		$lblModelDescriptionLabel1.Cursor = "Hand"
		# #		$lblModelDescriptionLabel1.Add_Click({
		# #							})
		# 		$pnlModels.Controls.Add($lblModelDescriptionLabel1)
		# 	}
			
			
		# # Add Description Label 2
		# If (!($lblModelDescriptionLabel2)) 
		# 	{
		# 		$global:lblModelDescriptionLabel2 = New-Object System.Windows.Forms.Label
		# 		$lblModelDescriptionLabel2.Width = $lblModelDescriptionLabel1.Width
		# 		$lblModelDescriptionLabel2.Height = $lblModelDescriptionLabel1.Height
		# 		$lblModelDescriptionLabel2.Left = $lblModelDescriptionLabel1.Left
		# 		$lblModelDescriptionLabel2.Top = $lblModelDescriptionLabel1.Bottom + 5
		# 		$lblModelDescriptionLabel2.TextAlign = "MiddleLeft"
		# 		$lblModelDescriptionLabel2.ForeColor = "Black"
		# 		$lblModelDescriptionLabel2.Backcolor = "Transparent"
		# 		$lblModelDescriptionLabel2.Text = ""
		# 		$lblModelDescriptionLabel2.Anchor = "Left,Right,Top"
		# #		$lblModelDescriptionLabel2.Cursor = "Hand"
		# #		$lblModelDescriptionLabel2.Add_Click({
		# #							})
		# 		$pnlModels.Controls.Add($lblModelDescriptionLabel2)
		# 	}
			
			
		# # Add Description Label 3
		# If (!($lblModelDescriptionLabel3)) 
		# 	{
		# 		$global:lblModelDescriptionLabel3 = New-Object System.Windows.Forms.Label
		# 		$lblModelDescriptionLabel3.Width = $lblModelDescriptionLabel1.Width
		# 		$lblModelDescriptionLabel3.Height = $lblModelDescriptionLabel1.Height
		# 		$lblModelDescriptionLabel3.Left = $lblModelDescriptionLabel1.Left
		# 		$lblModelDescriptionLabel3.Top = $lblModelDescriptionLabel2.Bottom + 5
		# 		$lblModelDescriptionLabel3.TextAlign = "MiddleLeft"
		# 		$lblModelDescriptionLabel3.ForeColor = "Black"
		# 		$lblModelDescriptionLabel3.Backcolor = "Transparent"
		# 		$lblModelDescriptionLabel3.Text = ""
		# 		$lblModelDescriptionLabel3.Anchor = "Left,Right,Top"
		# #		$lblModelDescriptionLabel3.Cursor = "Hand"
		# #		$lblModelDescriptionLabel3.Add_Click({
		# #							})
		# 		$pnlModels.Controls.Add($lblModelDescriptionLabel3)
		# 	}	
			
		
		# # Add Description Label 4
		# If (!($lblModelDescriptionLabel4)) 
		# 	{
		# 		$global:lblModelDescriptionLabel4 = New-Object System.Windows.Forms.Label
		# 		$lblModelDescriptionLabel4.Width = $lblModelDescriptionLabel1.Width
		# 		$lblModelDescriptionLabel4.Height = $lblModelDescriptionLabel1.Height
		# 		$lblModelDescriptionLabel4.Left = $lblModelDescriptionLabel1.Left
		# 		$lblModelDescriptionLabel4.Top = $lblModelDescriptionLabel3.Bottom + 5
		# 		$lblModelDescriptionLabel4.TextAlign = "MiddleLeft"
		# 		$lblModelDescriptionLabel4.ForeColor = "Black"
		# 		$lblModelDescriptionLabel4.Backcolor = "Transparent"
		# 		$lblModelDescriptionLabel4.Text = ""
		# 		$lblModelDescriptionLabel4.Anchor = "Left,Right,Top"
		# #		$lblModelDescriptionLabel4.Cursor = "Hand"
		# #		$lblModelDescriptionLabel4.Add_Click({
		# #							})
		# 		$pnlModels.Controls.Add($lblModelDescriptionLabel4)
		# 	}	


		####################################
		# Renumber Nodes
		####################################

		# Create the Renumber Nodes button
		If (!($btnRenumberNodes)) 
			{
				$script:btnRenumberNodes = New-Object Windows.Forms.Button
				$btnRenumberNodes.Left = $lbxMasterModels.Left
				$btnRenumberNodes.Top = $lbxMasterModels.Bottom + 5
				$btnRenumberNodes.Text = "Renumber Nodes"
				$btnRenumberNodes.Width = 150
				$btnRenumberNodes.TextAlign = "MiddleCenter"
				$btnRenumberNodes.Cursor = "Hand"
				$btnRenumberNodes.ForeColor = "Black"
				$btnRenumberNodes.BackColor = "WhiteSmoke"
				$btnRenumberNodes.Visible = $false
				$btnRenumberNodes.Anchor = "Top,Left"
				$btnRenumberNodes.Add_Click({
				
						# If only a single model is selected in the listbox, show the Renumber Nodes form
						If ($lbxMasterModels.SelectedItems.Count -eq 1)
							{
								ShowRenumberNodesForm $lbxMasterModels.SelectedItem #$objxLightsEffects
							}
							ElseIf ($lbxMasterModels.SelectedItems.Count -gt 1)
								{
									# More than one model was selected
									[System.Windows.Forms.MessageBox]::Show("Only a single model can be modified at a time. `n`nPlease try again","More than one model was selected" , "OK", "Exclamation")
								}
								Else
									{
										# No models were selected
										[System.Windows.Forms.MessageBox]::Show("No model selected. `n`nPlease try again","No model selected" , "OK", "Exclamation")
									}
							
								
					})
				$pnlModels.Controls.Add($btnRenumberNodes)
			}
		

		####################################
		# Layout Model Groups
		####################################

		# Model Groups Panel
		If (!($pnlModelGroups)) 
			{
				$global:pnlModelGroups = New-Object System.Windows.Forms.Panel
				$pnlModelGroups.Name = "ModelGroupsPanel"
				$pnlModelGroups.Left = $pnlModels.Right + 10
				$pnlModelGroups.Top = $pnlModels.Top
				$pnlModelGroups.Width = $pnlModels.Width
				$pnlModelGroups.Height = $pnlModels.Height
				$pnlModelGroups.BackColor = "WhiteSmoke"
				$pnlModelGroups.Anchor = "Top,Left,Right"
				$pnlContentPanel2.Controls.Add($pnlModelGroups)
			}

		# Create the Layout Model Groups Label
		If (!($lblLayoutModelGroups)) 
			{
				$global:lblLayoutModelGroups = New-Object System.Windows.Forms.Label
				$lblLayoutModelGroups.Width = $lblLayoutModels.Width
				$lblLayoutModelGroups.Height = $lblLayouts.Height
				$lblLayoutModelGroups.Left = 10
				$lblLayoutModelGroups.Top = 10
				$lblLayoutModelGroups.TextAlign = "MiddleLeft"
				$lblLayoutModelGroups.ForeColor = "Blue"
				$lblLayoutModelGroups.Backcolor = "Transparent"
				$lblLayoutModelGroups.Text = "Layout Model Groups"
				
		#		$lblLayoutModelGroups.Cursor = "Hand"
		#		$lblLayoutModelGroups.Add_Click({
		#							})
				$pnlModelGroups.Controls.Add($lblLayoutModelGroups)
			}
		
		# Create the Layout Models listbox
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
				$lbxLayoutModelGroups.Add_DoubleClick({
				
						# If the master model groups list is not currently being filtered, modify the list
						If ($txtFilterMasterModelGroups.Text -eq $strDefaultFilterText)
							{
								# Remove the selected item from the listbox
								MoveModelGroupsToFromLayout "REMOVE" $lbxLayoutModelGroups.SelectedItem
							}
						
				})
				$pnlModelGroups.Controls.Add($lbxLayoutModelGroups)
			}
			
			
		####################################
		# Master Model Groups
		####################################

		# Create the Master Model Groups label
		If (!($lblMasterModelGroups)) 
			{
				$global:lblMasterModelGroups = New-Object System.Windows.Forms.Label
				$lblMasterModelGroups.Width = $lblLayoutModels.Width
				$lblMasterModelGroups.Height = $lblLayoutModelGroups.Height
				$lblMasterModelGroups.Left = $lblLayoutModelGroups.Left
				$lblMasterModelGroups.Top = $lblMasterModels.Top
				$lblMasterModelGroups.TextAlign = "MiddleLeft"
				$lblMasterModelGroups.ForeColor = "Green"
				$lblMasterModelGroups.Backcolor = "Transparent"
				$lblMasterModelGroups.Text = "Master Model Groups"
				$lblMasterModelGroups.Anchor = "Right,Top"
		#		$lblMasterModelGroups.Cursor = "Hand"
		#		$lblMasterModelGroups.Add_Click({
		#							})
				$pnlModelGroups.Controls.Add($lblMasterModelGroups)
			}
		
		# Create the Master Model Groups Listbox
		If (!($lbxMasterModelGroups)) 
			{
				$script:lbxMasterModelGroups = New-Object System.Windows.Forms.ListBox
				$lbxMasterModelGroups.Left = $lblMasterModelGroups.Left
				$lbxMasterModelGroups.Top = $lblMasterModels.Bottom + 5
				$lbxMasterModelGroups.Width = $lbxLayoutModelGroups.Width
				$lbxMasterModelGroups.Height = $lbxLayoutModelGroups.Height
				$lbxMasterModelGroups.SelectionMode = "MultiExtended"
				$lbxMasterModelGroups.Sorted = $true
				$lbxMasterModelGroups.Visible = $true
				$lbxMasterModelGroups.Enabled = $false
				$lbxMasterModelGroups.Anchor = "Right,Top"
				$lbxMasterModelGroups.Add_Click({
				
					# If an item is selected, populate the details labels with the properties of that item from the xLights XML file
					If ($lbxMasterModelGroups.SelectedItem)
						{
							
							
						}
				})
				$lbxMasterModelGroups.Add_DoubleClick({
						
						# If the layout model groups list is not currently being filtered, modify the list
						If ($txtFilterLayoutModelGroups.Text -eq $strDefaultFilterText)
							{
								MoveModelGroupsToFromLayout "ADD" $lbxMasterModelGroups.SelectedItem
							}
						
					})
				$pnlModelGroups.Controls.Add($lbxMasterModelGroups)
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
		# Filter Master Model Groups
		####################################

		# Filter Master Model Groups
		If (!($txtFilterMasterModelGroups)) 
			{
				$script:txtFilterMasterModelGroups = New-Object System.Windows.Forms.TextBox
				$txtFilterMasterModelGroups.Left = $lblMasterModelGroups.Right
				$txtFilterMasterModelGroups.Top = $lblMasterModelGroups.Top
				$txtFilterMasterModelGroups.Width = $lbxMasterModelGroups.Width - $lblMasterModelGroups.Width
				$txtFilterMasterModelGroups.Height = 30
				$txtFilterMasterModelGroups.Font = New-Object System.Drawing.Font("Arial",10)
				$txtFilterMasterModelGroups.ForeColor = "Gray"
				$txtFilterMasterModelGroups.BackColor = "LightGray"
				$txtFilterMasterModelGroups.Text = $strDefaultFilterText
				$txtFilterMasterModelGroups.Anchor = "Top,Right"
				$pnlModelGroups.Controls.Add($txtFilterMasterModelGroups)
				
				# Add Enter Event
				$txtFilterMasterModelGroups.Add_Enter({
						If ($txtFilterMasterModelGroups.Text -eq $strDefaultFilterText)
							{
								$txtFilterMasterModelGroups.Text = ""
							}
						$txtFilterMasterModelGroups.SelectAll()
						$txtFilterMasterModelGroups.ForeColor = "Black"
						$txtFilterMasterModelGroups.BackColor = "White"
						
						If (!($arrCurrentListOfMasterModelGroups)) {[array]$script:arrCurrentListOfMasterModelGroups = $lbxMasterModelGroups.Items}
					})
					
				# Add Leave Event
				$txtFilterMasterModelGroups.Add_Leave({
						If ($txtFilterMasterModelGroups.Text -eq "") 
							{
								ClearListBoxFilter -strTarget "Master" -strType "ModelGroup"
							}

					})
					
				# Add KeyUp Event
				$txtFilterMasterModelGroups.Add_KeyUp({
						
						If ($txtFilterMasterModelGroups.Right -eq $btnResetFilterMasterModelGroups.Right) {$txtFilterMasterModelGroups.Width = $txtFilterMasterModelGroups.Width - $btnResetFilterMasterModelGroups.Width - 2}
						
						If ($lblMasterModelGroups.Text -notlike "* (Filtered)") {$lblMasterModelGroups.Text += " (Filtered)"}
						
						# Disable buttons allowing movement 'into' Master Model Groups while the filter is applied
						$btnMoveAllModelGroupsDown.Enabled = $false
						$btnMoveModelGroupDown.Enabled = $false
				
						$lbxMasterModelGroups.BeginUpdate()
							$lbxMasterModelGroups.Items.Clear()
							$arrCurrentListOfMasterModelGroups | Where-Object {$_ -like "*$($txtFilterMasterModelGroups.Text)*"} | ForEach-Object {If ($_) {$lbxMasterModelGroups.Items.Add($_)}}
						$lbxMasterModelGroups.EndUpdate()
						
						# # Clear the desciption labels
						# $lblModelDescriptionLabel1.Text = ""
						# $lblModelDescriptionLabel2.Text = ""
						# $lblModelDescriptionLabel3.Text = ""
						# $lblModelDescriptionLabel4.Text = ""
						
						# Hide unnecessary elements
						$btnRenumberNodes.Visible = $false
					})
			}
		
		# Add the Reset Filter Master Model Groups button
		If (!($btnResetFilterMasterModelGroups)) 
			{
				$script:btnResetFilterMasterModelGroups = New-Object Windows.Forms.Button
				$btnResetFilterMasterModelGroups.Width = 20
				$btnResetFilterMasterModelGroups.Height = 25
				$btnResetFilterMasterModelGroups.Left = $lbxMasterModelGroups.Right - $btnResetFilterMasterModelGroups.Width
				$btnResetFilterMasterModelGroups.Top = $lblMasterModelGroups.Top - 1
				$btnResetFilterMasterModelGroups.Text = "X"
				$btnResetFilterMasterModelGroups.TextAlign = "MiddleCenter"
				$btnResetFilterMasterModelGroups.Cursor = "Hand"
				$btnResetFilterMasterModelGroups.ForeColor = "Black"
				$btnResetFilterMasterModelGroups.BackColor = "WhiteSmoke"
				$btnResetFilterMasterModelGroups.Anchor = "Top,Right"
				$btnResetFilterMasterModelGroups.Add_Click({
						
						ClearListBoxFilter -strTarget "Master" -strType "ModelGroup"

					})
				$pnlModelGroups.Controls.Add($btnResetFilterMasterModelGroups)
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
				$btnMoveModelGroupUp.Anchor = "Top,Right"
				$btnMoveModelGroupUp.Add_Click({

						[array]$arrItemsToMoveUp = $lbxMasterModelGroups.SelectedItems

						ForEach ($objItemToMoveUp in $arrItemsToMoveUp)
							{
								MoveModelGroupsToFromLayout "ADD" $objItemToMoveUp
							}
						
						$lbxMasterModelGroups.ClearSelected()
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
				$btnMoveAllModelGroupsUp.Anchor = "Top,Right"
				$btnMoveAllModelGroupsUp.Add_Click({
				
						[array]$arrItemsToMoveUp = $lbxMasterModelGroups.Items

						ForEach ($objItemToMoveUp in $arrItemsToMoveUp)
							{
								MoveModelGroupsToFromLayout "ADD" $objItemToMoveUp
							}

						$lbxMasterModelGroups.ClearSelected()
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
				$btnMoveModelGroupDown.Anchor = "Top,Right"
				$btnMoveModelGroupDown.Add_Click({
				
						[array]$arrItemsToMoveDown = $lbxLayoutModelGroups.SelectedItems

						ForEach ($objItemToMoveDown in $arrItemsToMoveDown)
							{
								MoveModelGroupsToFromLayout "REMOVE" $objItemToMoveDown
							}
						
						$lbxMasterModelGroups.ClearSelected()
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
				$btnMoveAllModelGroupsDown.Anchor = "Top,Right"
				$btnMoveAllModelGroupsDown.Add_Click({
				
						[array]$arrItemsToMoveDown = $lbxLayoutModelGroups.Items

						ForEach ($objItemToMoveDown in $arrItemsToMoveDown)
							{
								#Write-Host "Move $objItemToMoveDown"
								MoveModelGroupsToFromLayout "REMOVE" $objItemToMoveDown
							}

						$lbxMasterModelGroups.ClearSelected()
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
			$global:pnlViews = New-Object System.Windows.Forms.Panel
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


		# Create the Layout Views Label
		If (!($lblLayoutViews)) 
			{
				$global:lblLayoutViews = New-Object System.Windows.Forms.Label
				$lblLayoutViews.Width = $pnlContentPanel2.Width * .15
				$lblLayoutViews.Height = 20
				$lblLayoutViews.Left = 10
				$lblLayoutViews.Top = 10
				$lblLayoutViews.TextAlign = "MiddleLeft"
				$lblLayoutViews.ForeColor = "Blue"
				$lblLayoutViews.Backcolor = "Transparent"
				$lblLayoutViews.Text = "Layout Views"
				
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
				$lbxLayoutViews.Height = ($pnlViews.Height - 130) / 2
				$lbxLayoutViews.SelectionMode = "MultiExtended"
				$lbxLayoutViews.Sorted = $true
				$lbxLayoutViews.Visible = $true
				$lbxLayoutViews.Enabled = $false
				$lbxLayoutViews.Anchor = "Left,Right,Top"
				$lbxLayoutViews.Add_DoubleClick({
				
						# If the layout views list is not currently being filtered, modify the list
						If ($txtFilterMasterViews.Text -eq $strDefaultFilterText)
							{
								# Remove the selected item from the listbox
								MoveViewsToFromLayout "REMOVE" $lbxLayoutViews.SelectedItem
							}
						
				})
				$pnlViews.Controls.Add($lbxLayoutViews)
			}
			
			
		####################################
		# Master Views
		####################################

		# Create the Master Views label
		If (!($lblMasterViews)) 
			{
				$global:lblMasterViews = New-Object System.Windows.Forms.Label
				$lblMasterViews.Width = $lblLayoutViews.Width
				$lblMasterViews.Height = $lblLayoutViews.Height
				$lblMasterViews.Left = $lblLayoutViews.Left
				$lblMasterViews.Top = $lbxLayoutViews.Bottom + 50
				$lblMasterViews.TextAlign = "MiddleLeft"
				$lblMasterViews.ForeColor = "Green"
				$lblMasterViews.Backcolor = "Transparent"
				$lblMasterViews.Text = "Master Views"
				$lblMasterViews.Anchor = "Right,Top"
		#		$lblMasterViews.Cursor = "Hand"
		#		$lblMasterViews.Add_Click({
		#							})
				$pnlViews.Controls.Add($lblMasterViews)
			}
		
		# Create the Master Views Listbox
		If (!($lbxMasterViews)) 
			{
				$script:lbxMasterViews = New-Object System.Windows.Forms.ListBox
				$lbxMasterViews.Left = $lblMasterViews.Left
				$lbxMasterViews.Top = $lblMasterViews.Bottom + 5
				$lbxMasterViews.Width = $lbxLayoutViews.Width
				$lbxMasterViews.Height = $lbxLayoutViews.Height
				$lbxMasterViews.SelectionMode = "MultiExtended"
				$lbxMasterViews.Sorted = $true
				$lbxMasterViews.Visible = $true
				$lbxMasterViews.Enabled = $false
				$lbxMasterViews.Anchor = "Right,Top"
				$lbxMasterViews.Add_Click({
				
					# If an item is selected, populate the details labels with the properties of that item from the xLights XML file
					If ($lbxMasterViews.SelectedItem)
						{
							
							
						}
				})
				$lbxMasterViews.Add_DoubleClick({
						
						# If the master views list is not currently being filtered, modify the list
						If ($txtFilterLayoutViews.Text -eq $strDefaultFilterText)
							{
								MoveViewsToFromLayout "ADD" $lbxMasterViews.SelectedItem
							}
						
					})
				$pnlViews.Controls.Add($lbxMasterViews)
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
		# Master View Filters
		####################################

		# Filter Master Views
		If (!($txtFilterMasterViews)) 
			{
				$script:txtFilterMasterViews = New-Object System.Windows.Forms.TextBox
				$txtFilterMasterViews.Left = $lblMasterViews.Right
				$txtFilterMasterViews.Top = $lblMasterViews.Top
				$txtFilterMasterViews.Width = $lbxMasterViews.Width - $lblMasterViews.Width
				$txtFilterMasterViews.Height = 30
				$txtFilterMasterViews.Font = New-Object System.Drawing.Font("Arial",10)
				$txtFilterMasterViews.ForeColor = "Gray"
				$txtFilterMasterViews.BackColor = "LightGray"
				$txtFilterMasterViews.Text = $strDefaultFilterText
				$txtFilterMasterViews.Anchor = "Top,Right"
				$pnlViews.Controls.Add($txtFilterMasterViews)
				
				# Add Enter Event
				$txtFilterMasterViews.Add_Enter({
						If ($txtFilterMasterViews.Text -eq $strDefaultFilterText)
							{
								$txtFilterMasterViews.Text = ""
							}
						$txtFilterMasterViews.SelectAll()
						$txtFilterMasterViews.ForeColor = "Black"
						$txtFilterMasterViews.BackColor = "White"
						
						If (!($arrCurrentListOfMasterViews)) {[array]$script:arrCurrentListOfMasterViews = $lbxMasterViews.Items}
					})
					
				# Add Leave Event
				$txtFilterMasterViews.Add_Leave({
						If ($txtFilterMasterViews.Text -eq "") 
							{
								ClearListBoxFilter -strTarget "Master" -strType "View"
							}

					})
					
				# Add KeyUp Event
				$txtFilterMasterViews.Add_KeyUp({
						
						If ($txtFilterMasterViews.Right -eq $btnResetFilterMasterViews.Right) {$txtFilterMasterViews.Width = $txtFilterMasterViews.Width - $btnResetFilterMasterViews.Width - 2}
						
						If ($lblMasterViews.Text -notlike "* (Filtered)") {$lblMasterViews.Text += " (Filtered)"}
						
						# Disable buttons allowing movement 'into' Master Views while the filter is applied
						$btnMoveAllViewsDown.Enabled = $false
						$btnMoveViewDown.Enabled = $false
				
						$lbxMasterViews.BeginUpdate()
							$lbxMasterViews.Items.Clear()
							$arrCurrentListOfMasterViews | Where-Object {$_ -like "*$($txtFilterMasterViews.Text)*"} | ForEach-Object {If ($_) {$lbxMasterViews.Items.Add($_)}}
						$lbxMasterViews.EndUpdate()

					})
			}
		
		# Add the Reset Filter Master Views button
		If (!($btnResetFilterMasterViews)) 
			{
				$script:btnResetFilterMasterViews = New-Object Windows.Forms.Button
				$btnResetFilterMasterViews.Width = 20
				$btnResetFilterMasterViews.Height = 25
				$btnResetFilterMasterViews.Left = $lbxMasterViews.Right - $btnResetFilterMasterViews.Width
				$btnResetFilterMasterViews.Top = $lblMasterViews.Top - 1
				$btnResetFilterMasterViews.Text = "X"
				$btnResetFilterMasterViews.TextAlign = "MiddleCenter"
				$btnResetFilterMasterViews.Cursor = "Hand"
				$btnResetFilterMasterViews.ForeColor = "Black"
				$btnResetFilterMasterViews.BackColor = "WhiteSmoke"
				$btnResetFilterMasterViews.Anchor = "Top,Right"
				$btnResetFilterMasterViews.Add_Click({
						
						ClearListBoxFilter -strTarget "Master" -strType "View"
						
					})
				$pnlViews.Controls.Add($btnResetFilterMasterViews)
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
				$btnMoveViewUp.Anchor = "Top,Right"
				$btnMoveViewUp.Add_Click({

						[array]$arrItemsToMoveUp = $lbxMasterViews.SelectedItems

						ForEach ($objItemToMoveUp in $arrItemsToMoveUp)
							{
								MoveViewsToFromLayout "ADD" $objItemToMoveUp
							}
						
						$lbxMasterViews.ClearSelected()
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
				$btnMoveAllViewsUp.Anchor = "Top,Right"
				$btnMoveAllViewsUp.Add_Click({
				
						[array]$arrItemsToMoveUp = $lbxMasterViews.Items

						ForEach ($objItemToMoveUp in $arrItemsToMoveUp)
							{
								MoveViewsToFromLayout "ADD" $objItemToMoveUp
							}

						$lbxMasterViews.ClearSelected()
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
				$btnMoveViewDown.Anchor = "Top,Right"
				$btnMoveViewDown.Add_Click({
				
						[array]$arrItemsToMoveDown = $lbxLayoutViews.SelectedItems

						ForEach ($objItemToMoveDown in $arrItemsToMoveDown)
							{
								MoveViewsToFromLayout "REMOVE" $objItemToMoveDown
							}
						
						$lbxMasterViews.ClearSelected()
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
				$btnMoveAllViewsDown.Anchor = "Top,Right"
				$btnMoveAllViewsDown.Add_Click({
				
						[array]$arrItemsToMoveDown = $lbxLayoutViews.Items

						ForEach ($objItemToMoveDown in $arrItemsToMoveDown)
							{
								#Write-Host "Move $objItemToMoveDown"
								MoveViewsToFromLayout "REMOVE" $objItemToMoveDown
							}

						$lbxMasterViews.ClearSelected()
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
				"Master"
					{
						Switch ($strType)
							{
								"Model"
									{
										# Reset the filter box
										$txtFilterMasterModels.Text = $strDefaultFilterText
										$txtFilterMasterModels.ForeColor = "Gray"
										$txtFilterMasterModels.BackColor = "LightGray"
										
										# Clear the filter config
										$lbxMasterModels.Items.Clear()
										$arrCurrentListOfMasterModels | ForEach-Object {$lbxMasterModels.Items.Add($_)}
										Remove-Variable -Name arrCurrentListOfMasterModels -Scope Script -Force -ErrorAction SilentlyContinue
										$txtFilterMasterModels.Width = $txtFilterMasterModels.Width + $btnResetFilterMasterModels.Width + 2
										
										$lblMasterModels.Text = ($lblMasterModels.Text).Trim(" (Filtered)")

										# Reset the listbox controls
										$btnMoveAllModelsDown.Enabled = $true
										$btnMoveModelDown.Enabled = $true
										
										# Resync the boxes
										[array]$lbxLayoutModels.Items | ForEach-Object {$lbxMasterModels.Items.Remove($_)}
									}

								"ModelGroup"
									{
										# Reset the filter box
										$txtFilterMasterModelGroups.Text = $strDefaultFilterText
										$txtFilterMasterModelGroups.ForeColor = "Gray"
										$txtFilterMasterModelGroups.BackColor = "LightGray"
										
										# Clear the filter config
										$lbxMasterModelGroups.Items.Clear()
										$arrCurrentListOfMasterModelGroups | ForEach-Object {$lbxMasterModelGroups.Items.Add($_)}
										Remove-Variable -Name arrCurrentListOfMasterModelGroups -Scope Script -Force -ErrorAction SilentlyContinue
										$txtFilterMasterModelGroups.Width = $txtFilterMasterModelGroups.Width + $btnResetFilterMasterModelGroups.Width + 2
										
										$lblMasterModelGroups.Text = ($lblMasterModelGroups.Text).Trim(" (Filtered)")

										# Reset the listbox controls
										$btnMoveAllModelGroupsDown.Enabled = $true
										$btnMoveModelGroupDown.Enabled = $true
										
										# Resync the boxes
										[array]$lbxLayoutModelGroups.Items | ForEach-Object {$lbxMasterModelGroups.Items.Remove($_)}
									}

								"View"
									{
										# Reset the filter box
										$txtFilterMasterViews.Text = $strDefaultFilterText
										$txtFilterMasterViews.ForeColor = "Gray"
										$txtFilterMasterViews.BackColor = "LightGray"

										# Clear the filter config
										$lbxMasterViews.Items.Clear()
										$arrCurrentListOfMasterViews | ForEach-Object {$lbxMasterViews.Items.Add($_)}
										Remove-Variable -Name arrCurrentListOfMasterViews -Scope Script -Force -ErrorAction SilentlyContinue
										$txtFilterMasterViews.Width = $txtFilterMasterViews.Width + $btnResetFilterMasterViews.Width + 2

										$lblMasterViews.Text = ($lblMasterViews.Text).Trim(" (Filtered)")

										# Reset the listbox controls
										$btnMoveAllViewsDown.Enabled = $true
										$btnMoveViewDown.Enabled = $true

										# Resync the boxes
										[array]$lbxLayoutViews.Items | ForEach-Object {$lbxMasterViews.Items.Remove($_)}
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
										
										$txtFilterLayoutModels.Width = $txtFilterLayoutModels.Width + $btnResetFilterLayoutModels.Width + 2
										
										$lblLayoutModels.Text = ($lblLayoutModels.Text).Trim(" (Filtered)")

										# Reset the listbox controls
										$btnMoveAllModelsUp.Enabled = $true
										$btnMoveModelUp.Enabled = $true
										
										# Resync the boxes
										[array]$lbxMasterModels.Items | ForEach-Object {$lbxLayoutModels.Items.Remove($_)}
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
										
										$txtFilterLayoutModelGroups.Width = $txtFilterLayoutModelGroups.Width + $btnResetFilterLayoutModelGroups.Width + 2
										
										$lblLayoutModelGroups.Text = ($lblLayoutModelGroups.Text).Trim(" (Filtered)")

										# Reset the listbox controls
										$btnMoveAllModelGroupsUp.Enabled = $true
										$btnMoveModelGroupUp.Enabled = $true
										
										# Resync the boxes
										[array]$lbxMasterModelGroups.Items | ForEach-Object {$lbxLayoutModelGroups.Items.Remove($_)}
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

										$txtFilterLayoutViews.Width = $txtFilterLayoutViews.Width + $btnResetFilterLayoutViews.Width + 2

										$lblLayoutViews.Text = ($lblLayoutViews.Text).Trim(" (Filtered)")

										# Reset the listbox controls
										$btnMoveAllViewsUp.Enabled = $true
										$btnMoveViewUp.Enabled = $true

										# Resync the boxes
										[array]$lbxMasterViews.Items | ForEach-Object {$lbxLayoutViews.Items.Remove($_)}
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
	
	
Function RenumberNodes
	{
		
	
	
	
	
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
								$cbxSyncToMaster.Enabled = $true
								$cbxPromptToCreateNewInCompanion.Enabled = $true
								$cbxPromptToOverwriteModels.Enabled = $true

								$pnlSyncFrom.BackColor = "MintCream"
							}
							ElseIf ($strTask -eq "Disable")
								{
									$btnSyncFromxLights.Forecolor = "Black"
									$btnSyncFromxLights.BackColor = "WhiteSmoke"
									$btnSyncFromxLights.Enabled = $false
									$lblSyncToLayout.Text = ""
									$cbxSyncToMaster.Enabled = $true
									$cbxSyncToMaster.Checked = $false
									$cbxPromptToCreateNewInCompanion.Enabled = $false
									$cbxPromptToOverwriteModels.Enabled = $false

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
								
								$pnlCommitxLights.BackColor = "MintCream"
							}
							ElseIf ($strTask -eq "Disable")
								{
									$btnCommitLayoutToxLights.Forecolor = "Gray"
									$btnCommitLayoutToxLights.BackColor = "LightGray"
									$btnCommitLayoutToxLights.Enabled = $false
									
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

								$pnlLayouts.BackColor = "Azure"
							}
							ElseIf ($strTask -eq "Disable")
								{
									$lblLayouts.ForeColor = "Gray"
									$lbxLayouts.Enabled = $false

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
								$lblMasterModels.ForeColor = "Green"
								$txtFilterMasterModels.Enabled = $true
								$lbxMasterModels.Enabled = $true

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
									$lblMasterModels.ForeColor = "Gray"
									$txtFilterMasterModels.Enabled = $false
									$lbxMasterModels.Enabled = $false

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
								$btnMoveModelUp.Enabled = $true
								$btnMoveModelDown.Enabled = $true
								$btnMoveAllModelGroupsDown.Enabled = $true
								$lblMasterModelGroups.ForeColor = "Green"
								$txtFilterMasterModelGroups.Enabled = $true
								$lbxMasterModelGroups.Enabled = $true

								$pnlModelGroups.BackColor = "Azure"
							}
							ElseIf ($strTask -eq "Disable")
								{
									$lblLayoutModelGroups.ForeColor = "Gray"
									$txtFilterLayoutModelGroups.Enabled = $false
									$lbxLayoutModelGroups.Enabled = $false
									$btnMoveAllModelGroupsUp.Enabled = $false
									$btnMoveModelUp.Enabled = $false
									$btnMoveModelDown.Enabled = $false
									$btnMoveAllModelGroupsDown.Enabled = $false
									$lblMasterModelGroups.ForeColor = "Gray"
									$txtFilterMasterModelGroups.Enabled = $false
									$lbxMasterModelGroups.Enabled = $false

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
								$btnMoveModelUp.Enabled = $true
								$btnMoveModelDown.Enabled = $true
								$btnMoveAllViewsDown.Enabled = $true
								$lblMasterViews.ForeColor = "Green"
								$txtFilterMasterViews.Enabled = $true
								$lbxMasterViews.Enabled = $true

								$pnlViews.BackColor = "Azure"
							}
							ElseIf ($strTask -eq "Disable")
								{
									$lblLayoutViews.ForeColor = "Gray"
									$txtFilterLayoutViews.Enabled = $false
									$lbxLayoutViews.Enabled = $false
									$btnMoveAllViewsUp.Enabled = $false
									$btnMoveModelUp.Enabled = $false
									$btnMoveModelDown.Enabled = $false
									$btnMoveAllViewsDown.Enabled = $false
									$lblMasterViews.ForeColor = "Gray"
									$txtFilterMasterViews.Enabled = $false
									$lbxMasterViews.Enabled = $false

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
		[xml]$global:objxLightsEffects = Get-Content -raw $strxlightsRGBEffectsFilePath

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
				LogWrite "INFO" "xLights_RGBEffects File Successfully backed up to ""$strxLightsRGBEffectsFileBackupPath""" -ForegroundColor Green
			
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

		$global:strxLightsCompanionXML = "$strxLightsCompanionXMLPath\xLightsCompanion.xml"

		If (!(Test-Path $global:strxLightsCompanionXML))
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

		[xml]$global:objxLightsCompanionXML = Get-Content -raw $strxLightsCompanionXML

		# If the layouts are currently empty, populate them
		If (($objxLightsCompanionXML.xlc.layouts.layout).Count -eq 0)
			{
				# Prepopulate the layouts with US Holidays
				AddLayout "- Master (Recovery) -"
				AddLayout "- Common -"
				AddLayout "Christmas"
				AddLayout "Easter"
				AddLayout "Halloween"
				AddLayout "Independence Day"
				AddLayout "Memorial Day"
				AddLayout "Thanksgiving"
				AddLayout "Valentines Day"
				AddLayout "Veterans Day"

				# Save the file and reset the button
				$objxLightsCompanionXML.Save($strxLightsCompanionXML)
				$global:boolxLightsCompanionXMLIsChanged = $false
				$btnFormSubmit.Text = "Close"
				$btnFormSubmit.Forecolor = "Black"
				$btnFormSubmit.BackColor = "WhiteSmoke"
			}

		
		# Check to see if the count of models, model groups, and views are the same between RGB Effects and Companion.  
		# If not, trigger a sync.  If so, loop through to see if a sync is required


# Removed as there is no need to check the Master list against xLights every time
		# # Load the data and check for updates to the models
		# LoadMasterResourcesFromCompanionXML -strNodeType "Model" -boolLoadListBoxes $false -boolCheckForUpdates $true
		# LoadMasterResourcesFromCompanionXML -strNodeType "ModelGroup" -boolLoadListBoxes $false -boolCheckForUpdates $true
		# LoadMasterResourcesFromCompanionXML -strNodeType "View" -boolLoadListBoxes $false -boolCheckForUpdates $true

		# If ($boolUpdatedModelsExistInImport -or $boolUpdatedModelGroupsExistInImport -or $boolUpdatedViewsExistInImport)
		If ($lbxMasterModels.Items.Count -lt 1)
			{
				# The xLights XML has been updated so a sync is required before working in Companion.

				# LogWrite "INFO" "xLights XML has been updated so a Sync is required before continuing" "Yellow"

				# There are no models available in the Master Models list box so the first step is a sync from xLights

				 LogWrite "INFO" "No Master Models are available so a sync from xLights is required"

				# Disable all of the content panels
				ModifyPanels "Disable" "Layouts"
				ModifyPanels "Disable" "Models" 
				ModifyPanels "Disable" "ModelGroups" 
				ModifyPanels "Disable" "Views" 

				# Highlight the Sync button
				$btnSyncFromxLights.Forecolor = "White"
				$btnSyncFromxLights.BackColor = "Green"
				$btnSyncFromxLights.Enabled = $true
				$cbxPromptToOverwriteModels.Enabled = $true
				$cbxPromptToCreateNewInCompanion.Enabled = $true
				
			}
			Else
				{
					# Load the list boxes
					LoadLayoutsFromCompanionXML
					LoadMasterResourcesFromCompanionXML -strNodeType "Model" -boolLoadListBoxes $true -boolCheckForUpdates $false
					LoadMasterResourcesFromCompanionXML -strNodeType "ModelGroup" -boolLoadListBoxes $true -boolCheckForUpdates $false
					LoadMasterResourcesFromCompanionXML -strNodeType "View" -boolLoadListBoxes $true -boolCheckForUpdates $false

					# Enable the Layouts panel
					ModifyPanels "Enable" "Layouts" 

					# Disable the content panels
					ModifyPanels "Disable" "Models" 
					ModifyPanels "Disable" "ModelGroups" 
					ModifyPanels "Disable" "Views" 

					# # Disable the Sync From Panel
					ModifyPanels "Disable" "SyncFrom"

					$btnSyncFromxLights.Text = "No Sync Required"
				}

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
				LogWrite "INFO" "xLights Companion File Successfully backed up to ""$strxLightsCompanionXMLFileBackupPath""" -ForegroundColor Green
			
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

				$global:boolxLightsCompanionXMLIsChanged = $true

				$btnFormSubmit.ForeColor = "White"
				$btnFormSubmit.BackColor = "Green"
				$btnFormSubmit.Text = "Save"
			}
	}

	

Function SyncModelsToCompanion ($strLayoutName, $strActiveInactiveAll, $boolOverridePrompts)
	{
		LogWrite "INFO" "Sync $strActiveInactiveAll models from xLights to Companion ($strLayoutName) with Override Prompts = ""$boolOverridePrompts"""

		$intModelsSynced = 0

		# Get the list of models from xLights
		If ($strActiveInactiveAll -eq "Active") {$objxLightsProps = $objxLightsEffects.xrgb.models.ChildNodes | Where-Object {$_.Active -ne "0"}}
			ElseIf ($strActiveInactiveAll -eq "Inactive") {$objxLightsProps = $objxLightsEffects.xrgb.models.ChildNodes | Where-Object {$_.Active -eq "0"}}
				Else {$objxLightsProps = $objxLightsEffects.xrgb.models.ChildNodes}
		
		# Copy each model to xlights Companion
		LogWrite "VERBOSE" "Found $(($objxLightsEffects.xrgb.models.model.Count)) Models to Sync"

		$objxLightsProps | ForEach-Object {
			
			LogWrite "VERBOSE" "Copying ""$($_.name)"""
			
			CopyXMLNode -strSource "xLights" -strTarget "Companion" -strLayoutName $strLayoutName -strNodeType "Model" -strNodeName $_.name -boolOverridePrompts $cbxPromptToOverwriteModels.Checked
			#CopyModelToCompanion $_.name $cbxPromptToOverwriteModels.Checked $false

			$intModelsSynced++

		}

		LogWrite "VERBOSE" "Synced $intModelsSynced models to xLights Companion"

		$global:boolModelSyncFromxLightsComplete = $true

	}



Function SyncModelGroupsToCompanion ($strLayoutName, $boolOverridePrompts)
	{
		LogWrite "INFO" "Sync all model groups from xLights to Companion ($strLayoutName) with Override Prompts = ""$boolOverridePrompts"""

		$intModelGroupsSynced = 0

		# Get the list of ModelGroups from xLights
		$objxLightsModelGroups = $objxLightsEffects.xrgb.ModelGroups.ChildNodes
		
		# Copy each model to xlights Companion
		LogWrite "VERBOSE" "Found $(($objxLightsEffects.xrgb.ModelGroups.modelGroup.Count)) Model Groups to Sync"

		$objxLightsModelGroups | ForEach-Object {
			
			LogWrite "VERBOSE" "Copying ""$($_.name)"""

			CopyXMLNode -strSource "xLights" -strTarget "Companion" -strLayoutName $strLayoutName -strNodeType "ModelGroup" -strNodeName $_.name -boolOverridePrompts $cbxPromptToOverwriteModels.Checked
			#CopyModelGroupToCompanion $_.name $cbxPromptToOverwriteModels.Checked $false

			$intModelGroupsSynced++

		}

		LogWrite "VERBOSE" "Synced $intModelGroupsSynced Model Groups to xLights Companion"

		$global:boolModelGroupsyncFromxLightsComplete = $true

	}



Function SyncViewsToCompanion ($strLayoutName, $boolOverridePrompts)
	{
		LogWrite "INFO" "Sync all model groups from xLights to Companion ($strLayoutName) with Override Prompts = ""$boolOverridePrompts"""

		$intViewsSynced = 0

		# Get the list of Views from xLights
		$objxLightsViews = $objxLightsEffects.xrgb.Views.ChildNodes
		
		# Copy each model to xlights Companion
		LogWrite "VERBOSE" "Found $(($objxLightsEffects.xrgb.Views.modelGroup.Count)) Model Groups to Sync"

		$objxLightsViews | ForEach-Object {
			
			LogWrite "VERBOSE" "Copying ""$($_.name)"""

			CopyXMLNode -strSource "xLights" -strTarget "Companion" -strLayoutName $strLayoutName -strNodeType "View" -strNodeName $_.name -boolOverridePrompts $cbxPromptToOverwriteModels.Checked
			#CopyViewToCompanion $_.name $cbxPromptToOverwriteModels.Checked $false

			$intViewsSynced++

		}

		LogWrite "VERBOSE" "Synced $intViewsSynced Model Groups to xLights Companion"

		$global:boolViewsyncFromxLightsComplete = $true

	}


Function ComparexLightsToCompanion ($strObjectType, $strName)
	{
		LogWrite "DEBUG" "Comparing ""$strModelName"" between xLights and xLights Companion"

		Switch ($strObjectType)
			{
				"Model" 
					{$objxLightsParentNode = $objxLightsEffects.xrgb.models.model ; $objxLightsCompanionParentNode = $objxLightsCompanionXML.xlc.Models.Model}
				
				"ModelGroup" 
					{$objxLightsParentNode = $objxLightsEffects.xrgb.modelGroups.modelGroup ; $objxLightsCompanionParentNode = $objxLightsCompanionXML.xlc.ModelGroups.ModelGroup}
				
				"View" 
					{$objxLightsParentNode = $objxLightsEffects.xrgb.views.view ; $objxLightsCompanionParentNode = $objxLightsCompanionXML.xlc.Views.View}

				default {}
			}
		
		$strxLightsModelToCompare = ($objxLightsParentNode | Where-Object {$_.name -eq $strName}).OuterXML
		$strxLightsCompanionModelToCompare = ($objxLightsCompanionParentNode | Where-Object {$_.name -eq $strName}).OuterXML

		If ($strxLightsModelToCompare -eq $strxLightsCompanionModelToCompare)
			{
				Return $true
			}
			Else
				{
					Return $false
				}

	}

Function AssignCompanionIDs
	{
		LogWrite "INFO" "Assigning xLights Companion IDs to xLights RGB Effects Elements without a current ID"

		# If it exists, clear the array
		If ($arrxLightsCompanionIDsInUse) {[array]$global:arrxLightsCompanionIDsInUse.Clear()}

		$intNewIDsAssigned = 0

		# Get the list of current xLightsCompanionIDs
		$objxLightsEffects.xrgb.models.model | Where-Object {($_.xlightscompanionid).length -gt 0}  | ForEach-Object {[array]$global:arrxLightsCompanionIDsInUse += $_.xLightsCompanionID}
		$objxLightsEffects.xrgb.modelGroups.modelGroup | Where-Object {($_.xlightscompanionid).length -gt 0}  | ForEach-Object {[array]$global:arrxLightsCompanionIDsInUse += $_.xLightsCompanionID}
		$objxLightsEffects.xrgb.views.view | Where-Object {($_.xlightscompanionid).length -gt 0}  | ForEach-Object {[array]$global:arrxLightsCompanionIDsInUse += $_.xLightsCompanionID}

		# Go through the models that don't yet have an xLightsCompanionID and ensure each model has a unique xLightsCompanionID
		$objxLightsEffects.xrgb.models.model  | Where-Object {!($_.xlightscompanionid) -or ($_.xlightscompanionid).length -eq 0} | ForEach-Object {
				
				# Get a random ID and loop until it doesn't exist in the array
				$strRandomID = "model-$(Get-Random)"
				While ($strRandomID -in $arrxLightsCompanionIDsInUse) {$strRandomID = "model-$(Get-Random)"}

				# Set the ID on the model
				$_.SetAttribute("xLightsCompanionID", "$strRandomID")

				$intNewIDsAssigned++

				Remove-Variable strRandomID -ErrorAction SilentlyContinue
			}

		# Go through the model groups that don't yet have an xLightsCompanionID and ensure each model group has a unique xLightsCompanionID
		$objxLightsEffects.xrgb.modelgroups.modelgroup  | Where-Object {!($_.xlightscompanionid) -or ($_.xlightscompanionid).length -eq 0} | ForEach-Object {
		
			# Get a random ID and loop until it doesn't exist in the array
			$strRandomID = "modelgroup-$(Get-Random)"
			While ($strRandomID -in $arrxLightsCompanionIDsInUse) {$strRandomID = "modelgroup-$(Get-Random)"}

			# Set the ID on the model group
			$_.SetAttribute("xLightsCompanionID", "$strRandomID")

			$intNewIDsAssigned++

			Remove-Variable strRandomID -ErrorAction SilentlyContinue
		}

		# Go through the views that don't yet have an xLightsCompanionID and ensure each view has a unique xLightsCompanionID
		$objxLightsEffects.xrgb.views.view  | Where-Object {!($_.xlightscompanionid) -or ($_.xlightscompanionid).length -eq 0} | ForEach-Object {
				
			# Get a random ID and loop until it doesn't exist in the array
			$strRandomID = "view-$(Get-Random)"
			While ($strRandomID -in $arrxLightsCompanionIDsInUse) {$strRandomID = "view-$(Get-Random)"}

			# Set the ID on the view
			$_.SetAttribute("xLightsCompanionID", "$strRandomID")

			$intNewIDsAssigned++

			Remove-Variable strRandomID -ErrorAction SilentlyContinue
		}

		LogWrite "INFO" "$intNewIDsAssigned New xLights Companion IDs assigned"

		Return $intNewIDsAssigned

	}


Function AddLayout ($strLayoutName, $boolOverridePrompts)
	{
		# If a layout with the name already exists in xLights Companion, exit.
		If (($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.name -eq $strLayoutName}).Count -ge 1)
			{
				LogWrite "WARNING" "A layout named ""$strLayoutName"" already exists in xLights Companion"
				Return
			}
			Else
				{
					LogWrite "VERBOSE" "Creating ""$strLayoutName"" in xLights Companion Layouts"

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
					$objNewLayoutDescription.Value = If ($strLayoutName -eq "- Master (Recovery) -") {"THIS LAYOUT IS USED FOR AVAILABLE RESOURCES AND AS A RECOVERY LAYOUT.  DO NOT MODIFY"} Else {""}
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
					If ($objLayout.Name -ne '- Master (Recovery) -')
						{$lbxLayouts.Items.Add($objLayout.Name)}
				}
		$lbxLayouts.EndUpdate()
	}




Function LoadMasterResourcesFromCompanionXML ($strNodeType, $boolLoadListboxes, $boolCheckForUpdates)
	{
		LogWrite "VERBOSE" "Load Master $strNodeType(s) $(if ($boolLoadListboxes) {"into List Box "})$(If ($boolCheckForUpdates) {"with"} Else {"without"}) update check" 
		
		Switch ($strNodeType)
			{
				"Model"
					{
						$lbxMasterModels.BeginUpdate()
							$lbxMasterModels.Items.Clear()
						$lbxMasterModels.EndUpdate()

						[array]$arrMasterLayoutResources = ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq "- Master (Recovery) -"}).models.ChildNodes
						
						# If the Master master resources array has a length and the first entry is not blank, add each array item to the list box.
						If ($arrMasterLayoutResources.Length -and $arrMasterLayoutResources[0] -ne "")
							{
								# Load the list box
								$lbxMasterModels.BeginUpdate()

									# For each of the Master master resources.......
									$arrMasterLayoutResources | ForEach-Object {
										
										# If the model doesn't already exist in the Master resources List Box.......
										If ($_.Name -notin $lbxMasterModels.Items)
											{
												# If not $false, add the resource to the list box
												If ($boolLoadListboxes -ne $false) {$lbxMasterModels.Items.Add($_.Name)}

												# # If specified, check the resource against xLights to see if it's different
												# If ($boolCheckForUpdates -ne $false)
												# 	{
												# 		# If an updated resource hasn't already been found and Check for updates has been specified, run the the update check
												# 		If ($boolUpdatedModelsExistInImport -ne $true -and $boolModelSyncFromxLightsComplete -ne $true)
												# 			{
												# 				# If the model has been updated in xLights, set the flag
												# 				If ((ComparexLightsToCompanion "Model" $_.Name) -eq $false)
												# 					{
												# 						LogWrite "VERBOSE" "A model ($($_.Name)) in xLights Companion (Master Layout) has been updated in xLights"

												# 						$global:boolUpdatedModelsExistInImport = $true

												# 						Return
												# 					}
												# 			}
												# 	}
											}
										}

								$lbxMasterModels.EndUpdate()
								
								# Go through the list of resources in the selected layout and remove them from the list of Master resources
								$lbxLayoutModels.Items | ForEach-Object {$lbxMasterModels.Items.Remove($_)}

								# # Go through the list of resources in the -Common- layout and remove them from the list of Master resources - Disabled at this time
								# ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.name -eq "- Common -"}).models.model.name -split "," | ForEach-Object {$lbxMasterModels.Items.Remove($_)}

								$lbxMasterModels.Enabled = $true
							}
						
					}

				"ModelGroup"
					{
						$lbxMasterModelGroups.BeginUpdate()
							$lbxMasterModelGroups.Items.Clear()
						$lbxMasterModelGroups.EndUpdate()

						[array]$arrMasterLayoutResources = ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq "- Master (Recovery) -"}).modelGroups.ChildNodes
						
						# If the Master master resources array has a length and the first entry is not blank, add each array item to the list box.
						If ($arrMasterLayoutResources.Length -and $arrMasterLayoutResources[0] -ne "")
							{
								# Load the list box
								$lbxMasterModelGroups.BeginUpdate()

									# For each of the Master master resources.......
									$arrMasterLayoutResources | ForEach-Object {
										
										# If the model doesn't already exist in the Master resources List Box.......
										If ($_.Name -notin $lbxMasterModelGroups.Items)
											{
												# If not $false, add the resource to the list box
												If ($boolLoadListboxes -ne $false) {$lbxMasterModelGroups.Items.Add($_.Name)}

												# # If specified, check the resource against xLights to see if it's different
												# If ($boolCheckForUpdates -ne $false)
												# 	{
												# 		# If an updated resource hasn't already been found and Check for updates has been specified, run the the update check
												# 		If ($boolUpdatedModelGroupsExistInImport -ne $true -and $boolModelGroupSyncFromxLightsComplete -ne $true)
												# 			{
												# 				# If the resouce has been updated in xLights, set the flag
												# 				If ((ComparexLightsToCompanion "ModelGroup" $_.Name) -eq $false)
												# 					{
												# 						LogWrite "VERBOSE" "A model group ($($_.Name)) in xLights Companion (Master Layout) has been updated in xLights"

												# 						$global:boolUpdatedModelGroupsExistInImport = $true

												# 						Return
												# 					}
												# 			}
												# 	}
											}
										}

								$lbxMasterModelGroups.EndUpdate()
								
								# Go through the list of resources in the selected layout and remove them from the list of Master resources
								$lbxLayoutModelGroups.Items | ForEach-Object {$lbxMasterModelGroups.Items.Remove($_)}

								# Go through the list of resources in the -Common- layout and remove them from the list of Master resources
								($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.name -eq "- Common -"}).modelGroups.modelGroup.name -split "," | ForEach-Object {$lbxMasterModelGroups.Items.Remove($_)}

								$lbxMasterModelGroups.Enabled = $true
							}
					}

				"View"
					{
						$lbxMasterViews.BeginUpdate()
							$lbxMasterViews.Items.Clear()
						$lbxMasterViews.EndUpdate()

						[array]$arrMasterLayoutResources = ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq "- Master (Recovery) -"}).views.ChildNodes
						
						# If the Master master resources array has a length and the first entry is not blank, add each array item to the list box.
						If ($arrMasterLayoutResources.Length -and $arrMasterLayoutResources[0] -ne "")
							{
								# Load the list box
								$lbxMasterViews.BeginUpdate()

									# For each of the Master master resources.......
									$arrMasterLayoutResources | ForEach-Object {
										
										# If the model doesn't already exist in the Master resources List Box.......
										If ($_.Name -notin $lbxMasterViews.Items)
											{
												# If not $false, add the resource to the list box
												If ($boolLoadListboxes -ne $false) {$lbxMasterViews.Items.Add($_.Name)}

												# # If specified, check the resource against xLights to see if it's different
												# If ($boolCheckForUpdates -ne $false)
												# 	{
												# 		# If an updated resource hasn't already been found and Check for updates has been specified, run the the update check
												# 		If ($boolUpdatedViewsExistInImport -ne $true -and $boolViewSyncFromxLightsComplete -ne $true)
												# 			{
												# 				# If the resource has been updated in xLights, set the flag
												# 				If ((ComparexLightsToCompanion "View" $_.Name) -eq $false)
												# 					{
												# 						LogWrite "VERBOSE" "A view ($($_.Name)) in xLights Companion (Master Layout) has been updated in xLights"

												# 						$global:boolUpdatedViewsExistInImport = $true

												# 						Return
												# 					}
												# 			}
												# 	}
											}
										}

								$lbxMasterViews.EndUpdate()
								
								# Go through the list of resources in the selected layout and remove them from the list of Master resources
								$lbxLayoutViews.Items | ForEach-Object {$lbxMasterViews.Items.Remove($_)}

								# Go through the list of resources in the -Common- layout and remove them from the list of Master resources
								($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.name -eq "- Common -"}).views.view.name -split "," | ForEach-Object {$lbxMasterViews.Items.Remove($_)}

								$lbxMasterViews.Enabled = $true
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
						
						# Go through the list of models in the layout and remove them from the list of Master models
						$lbxLayoutModels.Items | ForEach-Object {$lbxMasterModels.Items.Remove($_)}
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

						# Go through the list of model groups in the layout and remove them from the list of Master model groups
						$lbxLayoutModelGroups.Items | ForEach-Object {$lbxMasterModelGroups.Items.Remove($_)}
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
						
							# Go through the list of views in the layout and remove them from the list of Master views
							$lbxLayoutViews.Items | ForEach-Object {$lbxMasterViews.Items.Remove($_)}
					}
			}

		# Go through the list of models in the layout and remove them from the list of Master models
		$lbxLayoutModels.Items | ForEach-Object {$lbxMasterModels.Items.Remove($_)}

	}



Function UpdateLayoutResource ($strTargetLayout, $strSourceLayout, $strNodeType)
	{
		LogWrite "VERBOSE" "Save the $strNodeType(s) for Layout $strTargetLayout"

		# If the Source Layout wasn't specified, assume the source is the Master layout
		If (!($strSourceLayout)) {$strSourceLayout = "- Master (Recovery) -"}

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


Function CopyXMLNode ($strSource, $strTarget, $strLayoutName, $strNodeType, $strNodeName, $boolOverridePrompts)
	{
		LogWrite "VERBOSE" "Attempting to copy $strNodeType ""$strNodeName"" to ""$strTarget"""

		# Get an array of all layouts from Companion
		$arrListOfLayouts = $objxLightsCompanionXML.xlc.layouts.layout

		# Get the index of the target layout (then add 1, as the XML is a 1,2,3 Index)
		$intIndexOfLayout = [array]::IndexOf($arrListOfLayouts.Name, $strLayoutName)

		# Set the source and target XML structures based on the parameters
		If ($strSource -eq "xLights" -and $strTarget -eq "Companion")
			{
				$objSourceXML = $objxLightsEffects.xrgb
				$objTargetXML = $objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfLayout]
			}
			ElseIf ($strSource -eq "Companion" -and $strTarget -eq "xLights")
				{
					$objSourceXML = $objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfLayout]
					$objTargetXML = $objxLightsEffects.xrgb
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
				# If the node already exists in the target, check to see if the ID is the same.  If so, prompt to overwrite.  If not, if specified, prompt whether to create a new node.  If not specified, just copy it.
				If (($objTargetXML | Where-Object {$_.name -eq $strNodeName}).Count -ge 1)
					{
						# Node already exists. Check the ID to see if it's the same node
						$strxLightsCompanionIDFromSource = ($objSourceXML | Where-Object {$_.name -eq $strNodeName}).xLightsCompanionID
						$strxLightsCompanionIDFromTarget = ($objTargetXML | Where-Object {$_.name -eq $strNodeName}).xLightsCompanionID
						
						# Compare the ID to see if it's the same node.  If so, compare the properties of the node and flag if it's been updated.
						If ($strxLightsCompanionIDFromSource -eq $strxLightsCompanionIDFromTarget)
							{
								# The ID's match so compare the properties of the nodes to see if they're different
								If ((ComparexLightsToCompanion $strNodeType $strNodeName) -eq $false)
									{
										# The nodes have different properties.  If not overridden, prompt to replace it in the target.
										If ($boolOverridePrompts -ne $true)
											{
												$boolOverwriteModel = [System.Windows.Forms.MessageBox]::Show("A model named ""$strNodeName"" already exists in $strTarget but the $strSource model has is different.  `n`nThis is likely due to the model being updated in xLights and not sync'd to Companion.  `n`nWould you like to replace the $strTarget version?","Model Already Exists" , "YesNo", "Exclamation")

												# Add code later to show comparison between the nodes
											}
											Else
												{$boolOverwriteModel = "Yes"}
									}
						
								# Check to see if overwrite is authorized.  If not, Return.  If so, remove the existing node and copy the updated version over.
								If ($boolOverwriteModel -ne "Yes")
									{
										LogWrite "VERBOSE" "$strNodeType already exists in $strTarget and will not be overwritten"
										Return
									}
									Else
										{
											LogWrite "INFO" "Removing ""$strNodeName"" from $strTarget and replacing with the latest version"

											If ($strTarget -eq "xLights")
												{
													Switch ($strNodeType)
														{
															"Model" {$boolProcessRemove = RemoveXMLNode -strTarget "xLights" -strNodeType "Model" -strNodeName $strNodeName -boolOverridePrompts $true} #RemoveModelFromxLights $strModelName}
															"ModelGroup" {$boolProcessRemove = RemoveXMLNode -strTarget "xLights" -strNodeType "ModelGroup" -strNodeName $strNodeName -boolOverridePrompts $true} #RemoveModelGroupFromxLights $strModelName}
															"View" {$boolProcessRemove = RemoveXMLNode -strTarget "xLights" -strNodeType "View" -strNodeName $strNodeName -boolOverridePrompts $true} #RemoveViewFromxLights $strModelName}
															default	{$boolProcessRemove = $false}
														}
												}
												Else
													{
														Switch ($strNodeType)
															{
																"Model"	{$boolProcessRemove = RemoveXMLNode -strTarget "Companion" -strLayoutName $strLayoutName -strNodeType "Model" -strNodeName $strNodeName -boolOverridePrompts $true } #RemoveModelFromxLightsCompanion $strModelName}
																"ModelGroup" {$boolProcessRemove = RemoveXMLNode -strTarget "Companion" -strLayoutName $strLayoutName -strNodeType "ModelGroup" -strNodeName $strNodeName -boolOverridePrompts $true} #RemoveModelGroupFromxLightsCompanion $strModelName}
																"View" {$boolProcessRemove = RemoveXMLNode -strTarget "Companion" -strLayoutName $strLayoutName -strNodeType "View" -strNodeName $strNodeName -boolOverridePrompts $true} #RemoveViewFromxLightsCompanion $strModelName}
																default	{$boolProcessRemove = $false}
															}
													}
											
											If ($boolProcessRemove -ne $true)
												{
													LogWrite "WARNING" "Remove from $strTarget failed so overwrite is being aborted"
													Return
												}
										}
							}
							Else
								{
									# The xLightsCompanionID of the model is different between RGB Effects and Companion XML.  This is likely because the model was renamed to a name previously in use.

									# Add code here to update Companion for the new model.  
								}
					}
					# Else # The model does not already exist in the Target.  This should no longer be required with the xLightsCompanionID added
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
							$intIndexPlusOneOfNewLayout = [array]::IndexOf($arrListOfLayouts.Name, $strLayoutName) + 1
					
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
									"Model"	{$intNewNodeCount = (($objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfLayout].models.model | Where-Object {$_.name -eq $strNodeName} | Measure-Object).Count -eq 1)}
									"ModelGroup" {$intNewNodeCount = (($objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfLayout].ModelGroups.ModelGroup | Where-Object {$_.name -eq $strNodeName} | Measure-Object).Count -eq 1)}
									"View" {$intNewNodeCount = (($objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfLayout].Views.View | Where-Object {$_.name -eq $strNodeName} | Measure-Object).Count -eq 1)}
									default	{}
								}
						}

				If ($intNewNodeCount -eq 1)
					{
						LogWrite "VERBOSE" "Copy succeeded"
						
						# If the target was Companion, set the flag to require a save
						If ($strTarget -eq "Companion")
							{
								xLightsCompanionUpdates $true
							}
						
						Return $true
					}
					Else
						{
							LogWrite "WARNING" "Copy failed"
							Return $false
						}
			}
			Else
				{
					LogWrite "WARNING" "$strNodeType ""$strNodeName"" not found in $strSource"
					Return $false
				}

		Remove-Variable intNewNodeCount
		Remove-Variable strSourceXML
		Remove-Variable strTargetXML
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
							
						#	# Get an array of all layouts
						#	$arrListOfLayouts = $objxLightsCompanionXML.xlc.layouts.layout

						#	# Get the index of the target layout (then add 1, as the XML is a 1,2,3 Index)
						#	$intIndexPlusOneOfNewLayout = [array]::IndexOf($arrListOfLayouts.Name, $strLayoutName) + 1
					
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

		Try
			{
				# *****************************
				# ********** Models ***********
				# *****************************

				# Get the list of models currently in xLights RGB Effects
				$arrModelsCurrentlyInxLights = ($objxLightsEffects.xrgb.models.model).Name

				# Get the lists of models in "- Common -" and the specified layout
				[array]$arrCommonModelsToCommit += ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq "- Common -"}).Models.model.name -split ","
				[array]$arrLayoutModelsToCommit += ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq $strLayoutName}).Models.model.name -split ","
				
				# Iterate through the list of models in xLights RGB Effects and, if the model does not exist in the to-commit list, remove it from xLights
				ForEach ($strModelCurrentlyInxLights in $arrModelsCurrentlyInxLights)
					{
						If ($strModelCurrentlyInxLights -notin $arrCommonModelsToCommit -and $strModelCurrentlyInxLights -notin $arrLayoutModelsToCommit)
							{
								RemoveXMLNode -strTarget "xLights" -strNodeType "Model" -strNodeName $strModelCurrentlyInxLights -boolOverridePrompts $true
							}
					}
				
				# Iterate through the list of common models to be committed and add/overwrite them
				ForEach ($strCommonModelToCommit in $arrCommonModelsToCommit)
					{
						CopyXMLNode -strSource "Companion" -strTarget "xlights" -strLayoutName "- Common -" -strNodeType "Model" -strNodeName $strCommonModelToCommit -boolOverridePrompts $true
					}

				# If the selected layout is not '- Common -', iterate through the list of layout models to be committed and add/overwrite them
				If ($strLayoutName -ne "- Common -")
					{
						ForEach ($strLayoutModelToCommit in $arrLayoutModelsToCommit)
							{
								CopyXMLNode -strSource "Companion" -strTarget "xlights" -strLayoutName $strLayoutName -strNodeType "Model" -strNodeName $strLayoutModelToCommit -boolOverridePrompts $true
							}
					}

				
				# OLD WAY
				# [array]$arrModelIDsToCommit += ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq "- Common -"}).Models.model.xLightsCompanionID -split ","
				# [array]$arrModelIDsToCommit += ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq $strLayoutName}).Models.model.xLightsCompanionID -split ","

				# # Translate the list of Model IDs to model names
				# ForEach ($strModelID in $arrModelIDsToCommit)
				# 	{
				# 		$strModelName = ($objxLightsCompanionXML.xlc.layouts.layout[0]models.model | Where-Object {$_.xLightsCompanionID -eq $strModelID}).Name
				# 		[array]$arrModelsToCommit += $strModelName
				# 	}
				


				# *****************************
				# ******* Model Groups ********
				# *****************************

				# Get the list of model groups currently in xLights RGB Effects
				$arrModelGroupsCurrentlyInxLights = ($objxLightsEffects.xrgb.modelGroups.modelGroup).Name

				# Get the lists of model groups in "- Common -" and the specified layout
				[array]$arrCommonModelGroupsToCommit += ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq "- Common -"}).ModelGroups.modelGroup.name -split ","
				[array]$arrLayoutModelGroupsToCommit += ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq $strLayoutName}).ModelGroups.modelGroup.name -split ","

				# Iterate through the list of Model Groups in xLights RGB Effects and, if the Model Group does not exist in the to-commit list, remove it from xLights
				ForEach ($strModelGroupCurrentlyInxLights in $arrModelGroupsCurrentlyInxLights)
					{
						If ($strModelGroupCurrentlyInxLights -notin $arrCommonModelGroupsToCommit -and $strModelGroupCurrentlyInxLights -notin $arrLayoutModelGroupsToCommit)
							{
								RemoveXMLNode -strTarget "xLights" -strNodeType "ModelGroup" -strNodeName $strModelGroupCurrentlyInxLights -boolOverridePrompts $true
							}
					}

				# Iterate through the list of Common Model Groups to be committed and add/overwrite them
				ForEach ($strCommonModelGroupToCommit in $arrCommonModelGroupsToCommit)
					{
						CopyXMLNode -strSource "Companion" -strTarget "xlights" -strLayoutName "- Common -" -strNodeType "ModelGroup" -strNodeName $strCommonModelGroupToCommit -boolOverridePrompts $true
					}

				# If the selected layout is not '- Common -', iterate through the list of Layout Model Groups to be committed and add/overwrite them
				If ($strLayoutName -ne "- Common -")
					{
						ForEach ($strLayoutModelGroupToCommit in $arrLayoutModelGroupsToCommit)
							{
								CopyXMLNode -strSource "Companion" -strTarget "xlights" -strLayoutName $strLayoutName -strNodeType "ModelGroup" -strNodeName $strLayoutModelGroupToCommit -boolOverridePrompts $true
							}
					}

				# OLD WAY
				# # Combine the list of model groups in "- Common -" and the specified layout
				# [array]$arrModelGroupIDsToCommit += ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq "- Common -"}).ModelGroups.modelGroup.xLightsCompanionID -split ","
				# [array]$arrModelGroupIDsToCommit += ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq $strLayoutName}).ModelGroups.modelGroup.xLightsCompanionID -split ","

				# # Translate the list of Model GroupIDs to model group names
				# ForEach ($strModelGroupID in $arrModelGroupIDsToCommit)
				# 	{
				# 		$strModelGroupName = ($objxLightsCompanionXML.xlc.modelGroups.modelGroup | Where-Object {$_.xLightsCompanionID -eq $strModelGroupID}).Name
				# 		[array]$arrModelGroupsToCommit += $strModelGroupName
				# 	}



				
				# *****************************
				# ********** Views ************
				# *****************************

				# Get the list of views currently in xLights RGB Effects
				$arrViewsCurrentlyInxLights = ($objxLightsEffects.xrgb.views.view).Name

				# Get the lists of views in "- Common -" and the specified layout
				[array]$arrCommonViewsToCommit += ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq "- Common -"}).Views.view.name -split ","
				[array]$arrLayoutViewsToCommit += ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq $strLayoutName}).Views.view.name -split ","
				
				# Iterate through the list of Views in xLights RGB Effects and, if the View does not exist in the to-commit list, remove it from xLights
				ForEach ($strViewCurrentlyInxLights in $arrViewsCurrentlyInxLights)
					{
						If ($strViewCurrentlyInxLights -notin $arrCommonViewsToCommit -and $strViewCurrentlyInxLights -notin $arrLayoutViewsToCommit)
							{
								RemoveXMLNode -strTarget "xLights" -strNodeType "View" -strNodeName $strViewCurrentlyInxLights -boolOverridePrompts $true
							}
					}
					
				# Iterate through the list of Common Views to be committed and add/overwrite them
				ForEach ($strCommonViewToCommit in $arrCommonViewsToCommit)
					{
						CopyXMLNode -strSource "Companion" -strTarget "xlights" -strLayoutName "- Common -" -strNodeType "View" -strNodeName $strCommonViewToCommit -boolOverridePrompts $true
					}

				# If the selected layout is not '- Common -', iterate through the list of Layout Views to be committed and add/overwrite them
				If ($strLayoutName -ne "- Common -")
					{
						ForEach ($strLayoutViewToCommit in $arrLayoutViewsToCommit)
							{
								CopyXMLNode -strSource "Companion" -strTarget "xlights" -strLayoutName $strLayoutName -strNodeType "View" -strNodeName $strLayoutViewToCommit -boolOverridePrompts $true
							}
					}


				# OLD WAY
				# # Combine the list of views in "- Common -" and the specified layout
				# [array]$arrViewIDsToCommit += ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq "- Common -"}).Views.view.xLightsCompanionID -split ","
				# [array]$arrViewIDsToCommit += ($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.Name -eq $strLayoutName}).Views.view.xLightsCompanionID -split ","

				# # Translate the list of View IDs to View names
				# ForEach ($strViewID in $arrViewIDsToCommit)
				# 	{
				# 		$strViewName = ($objxLightsCompanionXML.xlc.Views.View | Where-Object {$_.xLightsCompanionID -eq $strViewID}).Name
				# 		[array]$arrViewsToCommit += $strViewName
				# 	}


# 				# Iterate through each remaining model group in xLights RGB Effects and, if the model no longer exists in xLights, remove it from the group
# 				ForEach ($objModelGroup in $objxLightsEffects.xrgb.modelGroups.modelGroup) 
# 					{write-host "1 $($objModelGroup.Name)" -ForegroundColor Magenta
# 						# Iterate through the list of models in the current model group
# 						ForEach ($objModel in ($objModelGroup.models -split ","))
# 							{write-host "2 $objModel"
# 								# Split the current model into an array.  This is necessary to support keeping submodels in a group.
# 								[array]$arrModelToCheck = $objModel -split "/"
# 								write-host "3 $($arrModelToCheck[0])"
# 								# If the current model (or parent of a submodel) is in the list of models to commit, add it to the array of valid models.
# 								If ($arrModelToCheck[0] -in $arrModelsToCommit -or $arrModelToCheck -in $arrModelGroupsToCommit)
# 									{write-host "4 $($arrValidModelsInGroup -join ",")" -ForegroundColor Green
# 										[array]$arrValidModelsInGroup += $objModel
# 										write-host "5 $($arrValidModelsInGroup -join ",")"
# 									}

# 								# Set the models attribute to the new array
# 								#$objModelGroup.SetAttribute("models", "$($arrValidModelsInGroup -join ",")")
# 								$objModelGroup.models = $arrValidModelsInGroup -join ","
# write-host "6 $($objModelGroup.models)" -ForegroundColor Red
# 								Remove-Variable arrModelToCheck -ErrorAction SilentlyContinue
# 								Remove-Variable arrValidModelsInGroup -ErrorAction SilentlyContinue

# 							}
# 					}


				# # Iterate through each remaining voew in xLights RGB Effects and, if the model no longer exists in xLights, remove it from the view
				# ForEach ($objView in $objxLightsEffects.xrgb.Views.View)
				# 	{
				# 		# Iterate through the list of models in the current view
				# 		ForEach ($objModel in ($objView.models -split ","))
				# 			{
				# 				# Split the current model into an array.  This is necessary to support keeping submodels in a group.
				# 				[array]$arrModelToCheck = $objModel -split "/"

				# 				# If the current model (or parent of a submodel) is in the list of models to commit, add it to the array of valid models.
				# 				If ($arrModelToCheck[0] -in $arrModelsToCommit -or $arrModelToCheck -in $arrModelGroupsToCommit)
				# 					{
				# 						[array]$arrValidModelsInGroup += $objModel
				# 					}

				# 				# Set the models attribute to the new array
				# 				$objView.SetAttribute("models", "$($arrValidModelsInGroup -join ",")")

				# 				Remove-Variable arrModelToCheck -ErrorAction SilentlyContinue
				# 				Remove-Variable arrValidModelsInGroup -ErrorAction SilentlyContinue
				# 			}
				# 	}

				# Save the xLights file
				$objxLightsEffects.Save($strxlightsRGBEffectsFilePath)

				LogWrite "INFO" "Committing to xLights completed successfully" "Green"

				If ($strxLightsPath -or !(Test-Path $strxlightsRGBEffectsFilePath))
					{
						LogWrite "VERBOSE" "Searching for xlights.exe........"
						$strxLightsPath = (Get-ChildItem -Path $env:ProgramFiles -filter xlights.exe -Recurse -ErrorAction SilentlyContinue).FullName
					}

				If (Test-Path $strxLightsPath)
					{
						$lblOpenLayoutInxLights.Text = "Open $strLayoutName in xLights"
						$lblOpenLayoutInxLights.Add_Click({
								
								LogWrite "INFO" "Opening ""$strxlightsRGBEffectsFilePath"" in xLights"
								Start-Process -FilePath $strxLightsPath -ArgumentList "--show ""$((Get-Item $strxlightsRGBEffectsFilePath).DirectoryName)""" -WindowStyle Normal
							})
					}
					
				
			}
			Catch
				{
					LogWrite "WARNING" "An error occurred committing the layout to xLights: $_"
				}
	}