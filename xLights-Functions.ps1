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

		# If the Repository Layout currently has no models assigned to it, check the Sync to Repository checkbox
		If ((($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.name -eq "- Repository (Recovery) -"}).Models.model).Count -eq 0)
			{
				$cbxSyncToRepository.Checked = $true
				$lblSyncToLayout.Text = "...to Repository"
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
# 						$lbxRepositoryModels.BeginUpdate()
# 							$lbxRepositoryModels.Items.Clear()
# 						$lbxRepositoryModels.EndUpdate()
						
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
				
# 		# 		$lbxRepositoryModels.BeginUpdate()
# 		# 			ForEach ($objModel in $objxLightsEffects.xrgb.models.ChildNodes) {$lbxRepositoryModels.Items.Add($objModel.Name)}
# 		# 		$lbxRepositoryModels.EndUpdate()
				
# 		# 		$script:intAllModelsCount = $lbxRepositoryModels.Count
# 		# 	}
# 	}

	
Function MoveModelsToFromLayout ($strAddRemove, $strModelName)
	{
		If ($strModelName -and $lbxLayouts.SelectedItem)
			{
				If ($strAddRemove -eq "ADD")
					{
						$lbxRepositoryModels.BeginUpdate()
						$lbxLayoutModels.BeginUpdate()
							
							$lbxLayoutModels.Items.Add($strModelName)
							$lbxRepositoryModels.Items.Remove($strModelName)
					
						$lbxRepositoryModels.EndUpdate()
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

						$btnSaveToFile.Enabled = $false
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
					ElseIf ($strAddRemove -eq "REMOVE")
						{
							$lbxRepositoryModels.BeginUpdate()
							$lbxLayoutModels.BeginUpdate()
						
								$lbxRepositoryModels.Items.Add($strModelName)
								$lbxLayoutModels.Items.Remove($strModelName)
							
							$lbxRepositoryModels.EndUpdate()
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

							$btnSaveToFile.Enabled = $false
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

						# Set the flag, lock the listbox, disable the form submit button and enable the layout buttons
						$global:boolLayoutModelGroupsChanged = $true
						$lbxLayouts.Enabled = $false

						$btnSaveToFile.Enabled = $false
						$btnSaveToFile.BackColor = "WhiteSmoke"
						$btnFormSubmit.Enabled = $false
						$btnFormSubmit.BackColor = "WhiteSmoke"
						
						$btnSaveLayout.Visible = $true
						$btnCancelReloadLayout.Visible = $true

					}
					ElseIf ($strAddRemove -eq "REMOVE")
						{
							$lbxRepositoryModelGroups.BeginUpdate()
							$lbxLayoutModelGroups.BeginUpdate()
						
								$lbxRepositoryModelGroups.Items.Add($strModelGroupName)
								$lbxLayoutModelGroups.Items.Remove($strModelGroupName)
							
							$lbxRepositoryModelGroups.EndUpdate()
							$lbxLayoutModelGroups.EndUpdate()
							
							# Hide unnecessary elements
							$btnRenumberNodes.Visible = $false

							# Set the flag, lock the listbox, disable the form submit button and enable the layout buttons
							$global:boolLayoutModelGroupsChanged = $true
							$lbxLayouts.Enabled = $false

							$btnSaveToFile.Enabled = $false
							$btnSaveToFile.BackColor = "WhiteSmoke"
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
						$lbxRepositoryViews.BeginUpdate()
						$lbxLayoutViews.BeginUpdate()
							
							$lbxLayoutViews.Items.Add($strViewName)
							$lbxRepositoryViews.Items.Remove($strViewName)
					
						$lbxRepositoryViews.EndUpdate()
						$lbxLayoutViews.EndUpdate()

						# Set the flag, lock the listbox, disable the form submit button and enable the layout buttons
						$global:boolLayoutViewsChanged = $true
						$lbxLayouts.Enabled = $false
						
						$btnSaveToFile.Enabled = $false
						$btnSaveToFile.BackColor = "WhiteSmoke"
						$btnFormSubmit.Enabled = $false
						$btnFormSubmit.BackColor = "WhiteSmoke"
						
						$btnSaveLayout.Visible = $true
						$btnCancelReloadLayout.Visible = $true

					}
					ElseIf ($strAddRemove -eq "REMOVE")
						{
							$lbxRepositoryViews.BeginUpdate()
							$lbxLayoutViews.BeginUpdate()
						
								$lbxRepositoryViews.Items.Add($strViewName)
								$lbxLayoutViews.Items.Remove($strViewName)
							
							$lbxRepositoryViews.EndUpdate()
							$lbxLayoutViews.EndUpdate()
							
							# Hide unnecessary elements
							$btnRenumberNodes.Visible = $false

							# Set the flag, lock the listbox, disable the form submit button and enable the layout buttons
							$global:boolLayoutViewsChanged = $true
							$lbxLayouts.Enabled = $false
							
							$btnSaveToFile.Enabled = $false
							$btnSaveToFile.BackColor = "WhiteSmoke"
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
				$btnSyncFromxLights.Text = "Sync All From xLights"
				$btnSyncFromxLights.Width = 160
				$btnSyncFromxLights.TextAlign = "MiddleCenter"
				$btnSyncFromxLights.Cursor = "Hand"
				$btnSyncFromxLights.ForeColor = "Black"
				$btnSyncFromxLights.BackColor = "WhiteSmoke"
				$btnSyncFromxLights.Anchor = "Left,Top"
				$btnSyncFromxLights.Add_Click({

						If ($rdoSyncSelectedResources.Checked -eq $true)
							{
								ShowSyncSelectedForm -strLayoutName $(If ($cbxSyncToRepository.Checked -eq $true) {"- Repository (Recovery) -"} Else {$lbxLayouts.SelectedItem}) -boolOverridePrompts $cbxPromptToOverwriteModels.Checked -boolPromptOnNewModels $cbxPromptToCreateNewInCompanion.Checked
							}
							Else
								{
									$dtStartSync = Get-Date

									# Disable the controls
									$btnSyncFromxLights.Text = "Processing...."
									$btnSyncFromxLights.Forecolor = "Blue"
									
									# Call the functions to sync the models, model groups, and views.  If Sync to Repository is checked, sync to the Repository layout
									SyncModelsToCompanion -strLayout $(If ($cbxSyncToRepository.Checked -eq $true) {"- Repository (Recovery) -"} Else {$lbxLayouts.SelectedItem}) -strActiveInactiveAll "All" -boolOverridePrompts $true
									SyncModelGroupsToCompanion -strLayout $(If ($cbxSyncToRepository.Checked -eq $true) {"- Repository (Recovery) -"} Else {$lbxLayouts.SelectedItem}) -boolOverridePrompts $true
									SyncViewsToCompanion -strLayout $(If ($cbxSyncToRepository.Checked -eq $true) {"- Repository (Recovery) -"} Else {$lbxLayouts.SelectedItem}) -boolOverridePrompts $true

									# # If Sync to Repository, reload the Repository list boxes
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

									# Load the Companion layouts
									LoadLayoutsFromCompanionXML

									# Enable the Layouts panel
									ModifyPanels "Enable" "Layouts" 

									# Disable Sync From
									ModifyPanels "Disable" "SyncFrom"
									
									$cbxSyncToRepository.ForeColor = "Black"

									$intSyncDuration = New-TimeSpan -Start $dtStartSync -End $(Get-Date)
									
									$btnSyncFromxLights.Text = "Sync Complete in $([math]::Round($intSyncDuration.TotalSeconds))s"
								}

						

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


		# Add the All/Selected Radio Button Panel
		If (!($pnlSyncAllSelected)) 
		{
			$global:pnlSyncAllSelected = New-Object System.Windows.Forms.Panel
			$pnlSyncAllSelected.Name = "SyncAllSelectedPanel"
			$pnlSyncAllSelected.Left = $btnSyncFromxLights.Left + 10
			$pnlSyncAllSelected.Top = $btnSyncFromxLights.Bottom +5
			$pnlSyncAllSelected.Width = 200
			$pnlSyncAllSelected.Height = 22
			$pnlSyncAllSelected.BackColor = "Transparent"
			$pnlSyncAllSelected.Anchor = "Top,Left,Right"
			$pnlSyncFrom.Controls.Add($pnlSyncAllSelected)
		}


		# Add the Sync All Radio Button
		If (!($rdoSyncAllResources)) 
			{
				$script:rdoSyncAllResources = New-Object Windows.Forms.RadioButton
				$rdoSyncAllResources.Left = 0
				$rdoSyncAllResources.Top = 0
				$rdoSyncAllResources.Text = "Sync All"
				$rdoSyncAllResources.Width = $pnlSyncAllSelected.Width / 2
				$rdoSyncAllResources.TextAlign = "MiddleLeft"
				$rdoSyncAllResources.Cursor = "Hand"
				$rdoSyncAllResources.ForeColor = "Black"
				$rdoSyncAllResources.BackColor = "Transparent"
				$rdoSyncAllResources.Checked = $true
				$rdoSyncAllResources.Anchor = "Left,Top"
				$rdoSyncAllResources.Add_Click({
						If ($rdoSyncAllResources.Checked) {$btnSyncFromxLights.Text = "Sync All From xLights"} Else {$btnSyncFromxLights.Text = "Select Resources to Sync"}
					})
				$pnlSyncAllSelected.Controls.Add($rdoSyncAllResources)
			}

		# Add the Sync All Radio Button
		If (!($rdoSyncSelectedResources)) 
			{
				$script:rdoSyncSelectedResources = New-Object Windows.Forms.RadioButton
				$rdoSyncSelectedResources.Left = $rdoSyncAllResources.Right
				$rdoSyncSelectedResources.Top = 0
				$rdoSyncSelectedResources.Text = "Sync Selected"
				$rdoSyncSelectedResources.Width = $pnlSyncAllSelected.Width / 2
				$rdoSyncSelectedResources.TextAlign = "MiddleLeft"
				$rdoSyncSelectedResources.Cursor = "Hand"
				$rdoSyncSelectedResources.ForeColor = "Black"
				$rdoSyncSelectedResources.BackColor = "Transparent"
				$rdoSyncSelectedResources.Checked = $false
				$rdoSyncSelectedResources.Anchor = "Left,Top"
				$rdoSyncSelectedResources.Add_Click({
					If ($rdoSyncAllResources.Checked) {$btnSyncFromxLights.Text = "Sync All From xLights"} Else {$btnSyncFromxLights.Text = "Select Resources to Sync"}
				})
				$pnlSyncAllSelected.Controls.Add($rdoSyncSelectedResources)
			}

		# Add the Sync to Repository checkbox
		If (!($cbxSyncToRepository)) 
			{
				$script:cbxSyncToRepository = New-Object Windows.Forms.CheckBox
				$cbxSyncToRepository.Left = $pnlSyncAllSelected.Left
				$cbxSyncToRepository.Top = $pnlSyncAllSelected.Bottom
				$cbxSyncToRepository.Text = "Sync to Repository"
				$cbxSyncToRepository.Width = 300
				$cbxSyncToRepository.TextAlign = "MiddleLeft"
				$cbxSyncToRepository.Cursor = "Hand"
				$cbxSyncToRepository.ForeColor = "Black"
				$cbxSyncToRepository.BackColor = "Transparent"
				$cbxSyncToRepository.Checked = $false
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
							If ($rdoSyncAllResources.Checked) {$btnSyncFromxLights.Text = "Sync All From xLights"} Else {$btnSyncFromxLights.Text = "Select Resources to Sync"}
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
										If ($rdoSyncAllResources.Checked) {$btnSyncFromxLights.Text = "Sync All From xLights"} Else {$btnSyncFromxLights.Text = "Select Resources to Sync"}
										$lblSyncToLayout.Text = "...to '$($lbxLayouts.SelectedItem)' Layout"
									}
									Else
										{
											$cbxSyncToRepository.Forecolor = "Black"

											ModifyPanels "Disable" "SyncFrom"
											ModifyPanels "Enable" "Layouts"
											ModifyPanels "Disable" "CommitToxLights"

											# $btnSyncFromxLights.Enabled = $false
											If ($rdoSyncAllResources.Checked) {$btnSyncFromxLights.Text = "Sync All From xLights"} Else {$btnSyncFromxLights.Text = "Select Resources to Sync"}
											$lblSyncToLayout.Text = ""
										}
							}
				})
				$pnlSyncFrom.Controls.Add($cbxSyncToRepository)
			}

		# Add the Prompt To Overwrite Model checkbox
		If (!($cbxPromptToOverwriteModels)) 
			{
				$global:cbxPromptToOverwriteModels = New-Object Windows.Forms.CheckBox
				$cbxPromptToOverwriteModels.Left = $pnlSyncAllSelected.Left
				$cbxPromptToOverwriteModels.Top = $cbxSyncToRepository.Bottom
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
				$global:cbxPromptToCreateNewInCompanion = New-Object Windows.Forms.CheckBox
				$cbxPromptToCreateNewInCompanion.Left = $cbxPromptToOverwriteModels.Left
				$cbxPromptToCreateNewInCompanion.Top = $cbxPromptToOverwriteModels.Bottom
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

									# Enable/Disable the Include Common checkbox
									If ($lbxLayouts.SelectedItem -eq "- Common -")
										{
											$cbxAlsoLoadCommonLayout.Checked = $true
											$cbxAlsoLoadCommonLayout.Enabled = $false
										}
										Else
											{
												$cbxAlsoLoadCommonLayout.Checked = $true
												$cbxAlsoLoadCommonLayout.Enabled = $true
											}

									# $btnSyncFromxLights.Enabled = $true
									If ($rdoSyncAllResources.Checked) {$btnSyncFromxLights.Text = "Sync All From xLights"} Else {$btnSyncFromxLights.Text = "Select Resources to Sync"}
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
										If ($rdoSyncAllResources.Checked) {$btnSyncFromxLights.Text = "Sync All From xLights"} Else {$btnSyncFromxLights.Text = "Select Resources to Sync"}
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
								If ($lbxLayouts.SelectedItem -notin ("- Common -", "- Repository (Recovery) -"))
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
										$lbxLayouts.Enabled = $true
										
										If ($boolxLightsCompanionXMLIsChanged) 
											{
												$btnSaveToFile.Enabled = $true
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
													$btnSaveToFile.Forecolor = "Gray"
													$btnSaveToFile.BackColor = "LightGray"
													
													$btnFormSubmit.Enabled = $true
													$btnFormSubmit.Text = "Close"
													$btnFormSubmit.Forecolor = "Black"
													$btnFormSubmit.BackColor = "WhiteSmoke"	
												}
												
										$btnSaveLayout.Visible = $false
										$btnCancelReloadLayout.Visible = $false
										
										$global:boolLayoutModelsChanged = $false
										$global:boolLayoutModelGroupsChanged = $false
										$global:boolLayoutViewsChanged = $false

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

										# LogWrite "VERBOSE" "Saving Layout Changes for ""$($lbxLayouts.SelectedItem)"""

										# # Save the layout models
										# UpdateLayoutResource -strTargetLayout $lbxLayouts.SelectedItem -strNodeType "Model"
										# UpdateLayoutResource -strTargetLayout $lbxLayouts.SelectedItem -strNodeType "ModelGroup"
										# UpdateLayoutResource -strTargetLayout $lbxLayouts.SelectedItem -strNodeType "View"

										# $lbxLayouts.Enabled = $true
										
										# If ($boolxLightsCompanionXMLIsChanged) 
										# 	{
										# 		$btnSaveToFile.Forecolor = "White"
										# 		$btnSaveToFile.BackColor = "Green"
										# 		$btnSaveToFile.Enabled = $true

										# 		$btnFormSubmit.Text = "Cancel"
										# 		$btnFormSubmit.Forecolor = "White"
										# 		$btnFormSubmit.BackColor = "Red"
										# 	}
										# 	Else
										# 		{
										# 			$btnSaveToFile.Forecolor = "Gray"
										# 			$btnSaveToFile.BackColor = "LightGray"
										# 			$btnSaveToFile.Enabled = $false

										# 			$btnFormSubmit.Text = "Close"
										# 			$btnFormSubmit.Forecolor = "Black"
										# 			$btnFormSubmit.BackColor = "WhiteSmoke"	
										# 		}

										# $btnSaveLayout.Visible = $false
										# $btnCancelReloadLayout.Visible = $false
										
										# $global:boolLayoutModelsChanged = $false
										# $global:boolLayoutModelGroupsChanged = $false
										# $global:boolLayoutViewsChanged = $false

										# ModifyPanels "Enable" "SyncFrom"
										# $btnSyncFromxLights.Enabled = $true
										# $cbxSyncToRepository.Enabled = $true
										# ModifyPanels "Enable" "CommitToxLights"

										# # Set the global Change Made flag
										# xLightsCompanionUpdates $true
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
				# $btnCommitLayoutToxLights.Left = $pnlCommitxLights.Width / 2 - $btnCommitLayoutToxLights.Width / 2
				$btnCommitLayoutToxLights.Left = 10
				# $btnCommitLayoutToxLights.Top = $pnlCommitxLights.Height / 2 - $btnCommitLayoutToxLights.Height / 2
				$btnCommitLayoutToxLights.Top = 10
				$btnCommitLayoutToxLights.Width = 200
				# $btnCommitLayoutToxLights.Height = 40
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
					$global:lblOpenLayoutInxLights = New-Object System.Windows.Forms.Label
					$lblOpenLayoutInxLights.Width = $pnlCommitxLights.Width - 6
					$lblOpenLayoutInxLights.Height = 20
					$lblOpenLayoutInxLights.Left = 3
					# $lblOpenLayoutInxLights.Top = $btnCommitLayoutToxLights.Bottom + 10
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
				$lblLayoutModels.Width = $pnlContentPanel2.Width * .20
				$lblLayoutModels.Height = 20
				$lblLayoutModels.Left = 10
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
				$lbxLayoutModels.Width = $pnlModels.Width - 20
				$lbxLayoutModels.Height = ($pnlModels.Height - 130) / 2
				$lbxLayoutModels.SelectionMode = "MultiExtended"
				$lbxLayoutModels.Sorted = $true
				$lbxLayoutModels.Visible = $true
				$lbxLayoutModels.Enabled = $false
				$lbxLayoutModels.Anchor = "Left,Right,Top"
				$lbxLayoutModels.Add_DoubleClick({
				
						# If the Repository List is not currently being filtered (nothing has been searched for), modify the list
						If ($txtFilterRepositoryModels.Text -eq $strDefaultFilterText)
							{
								# Remove the selected item from the listbox
								MoveModelsToFromLayout "REMOVE" $lbxLayoutModels.SelectedItem
							}
						
				})
				$pnlModels.Controls.Add($lbxLayoutModels)
			}
			
			
		####################################
		# Repository Models
		####################################

		# Create the Repository Models label
		If (!($lblRepositoryModels)) 
			{
				$global:lblRepositoryModels = New-Object System.Windows.Forms.Label
				$lblRepositoryModels.Width = $lblLayoutModels.Width
				$lblRepositoryModels.Height = $lblLayoutModels.Height
				$lblRepositoryModels.Left = $lblLayoutModels.Left
				$lblRepositoryModels.Top = $lbxLayoutModels.Bottom + 50
				$lblRepositoryModels.TextAlign = "MiddleLeft"
				$lblRepositoryModels.ForeColor = "Green"
				$lblRepositoryModels.Backcolor = "Transparent"
				$lblRepositoryModels.Text = "Models in Repository"
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
				$lbxRepositoryModels.Visible = $true
				$lbxRepositoryModels.Enabled = $false
				$lbxRepositoryModels.Anchor = "Right,Top"
				# $lbxRepositoryModels.Add_Click({
				
				# 	# If an item is selected, populate the details labels with the properties of that item from the xLights XML file
				# 	If ($lbxRepositoryModels.SelectedItem)
				# 		{
				# 			# Set the ReNumber Nodes button to visible
				# 			$btnRenumberNodes.Visible = $true
					
				# 			# Get the selected item from the XMl file
				# 			$objRepositoryModel = $objxLightsEffects.xrgb.ChildNodes.Model | Where-Object {$_.Name -eq $lbxRepositoryModels.SelectedItem}
							
				# 			# Get the properties of the selected item from the XML file
				# 			If ($objRepositoryModel.Active -eq 0) {$strModelActive = $false} Else {$strModelActive = $true}
				# 			If ($objRepositoryModel.ControllerConnection.Brightness) {$strModelBrightness = $objRepositoryModel.ControllerConnection.Brightness} Else {$strModelBrightness = 100}
				# 			If ($objRepositoryModel.PixelCount)
				# 				{$intModelNodeCount = $objRepositoryModel.PixelCount}
				# 				ElseIf ($objRepositoryModel.CustomModel)
				# 					{
				# 						$intModelNodeCount = $objRepositoryModel.CustomModel -split {$_ -eq "," -or $_ -eq ";"} | Measure-Object -Maximum | Select-Object -ExpandProperty Maximum
				# 					}
				# 					Else
				# 						{
				# 							$intModelNodeCount = ([int]$objRepositoryModel.parm1 * [int]$objRepositoryModel.parm2)
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
						
						# # Clear the desciption labels
						# $lblModelDescriptionLabel1.Text = ""
						# $lblModelDescriptionLabel2.Text = ""
						# $lblModelDescriptionLabel3.Text = ""
						# $lblModelDescriptionLabel4.Text = ""
						
						# Hide unnecessary elements
						$btnRenumberNodes.Visible = $false
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
	
	
		# ####################################
		# # Create the Model Description Labels
		# ####################################

		# # Add Description Label 1
		# If (!($lblModelDescriptionLabel1)) 
		# 	{
		# 		$global:lblModelDescriptionLabel1 = New-Object System.Windows.Forms.Label
		# 		$lblModelDescriptionLabel1.Width = $pnlContentPanel2.Width - $lbxRepositoryModels.Right - 20
		# 		$lblModelDescriptionLabel1.Height = 20
		# 		$lblModelDescriptionLabel1.Left = $lbxRepositoryModels.Right + 10
		# 		$lblModelDescriptionLabel1.Top = $lbxRepositoryModels.Top
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
				$btnRenumberNodes.Left = $lbxRepositoryModels.Left
				$btnRenumberNodes.Top = $lbxRepositoryModels.Bottom + 5
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
						If ($lbxRepositoryModels.SelectedItems.Count -eq 1)
							{
								ShowRenumberNodesForm $lbxRepositoryModels.SelectedItem #$objxLightsEffects
							}
							ElseIf ($lbxRepositoryModels.SelectedItems.Count -gt 1)
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
				$lblLayoutModelGroups.Text = "Model Groups in Layout"
				
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
				$global:lblRepositoryModelGroups = New-Object System.Windows.Forms.Label
				$lblRepositoryModelGroups.Width = $lblLayoutModels.Width
				$lblRepositoryModelGroups.Height = $lblLayoutModelGroups.Height
				$lblRepositoryModelGroups.Left = $lblLayoutModelGroups.Left
				$lblRepositoryModelGroups.Top = $lblRepositoryModels.Top
				$lblRepositoryModelGroups.TextAlign = "MiddleLeft"
				$lblRepositoryModelGroups.ForeColor = "Green"
				$lblRepositoryModelGroups.Backcolor = "Transparent"
				$lblRepositoryModelGroups.Text = "Model Groups in Repository"
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
				$lbxRepositoryModelGroups.Visible = $true
				$lbxRepositoryModelGroups.Enabled = $false
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
						
						# # Clear the desciption labels
						# $lblModelDescriptionLabel1.Text = ""
						# $lblModelDescriptionLabel2.Text = ""
						# $lblModelDescriptionLabel3.Text = ""
						# $lblModelDescriptionLabel4.Text = ""
						
						# Hide unnecessary elements
						$btnRenumberNodes.Visible = $false
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
				$lbxLayoutViews.Height = ($pnlViews.Height - 130) / 2
				$lbxLayoutViews.SelectionMode = "MultiExtended"
				$lbxLayoutViews.Sorted = $true
				$lbxLayoutViews.Visible = $true
				$lbxLayoutViews.Enabled = $false
				$lbxLayoutViews.Anchor = "Left,Right,Top"
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
				$global:lblRepositoryViews = New-Object System.Windows.Forms.Label
				$lblRepositoryViews.Width = $lblLayoutViews.Width
				$lblRepositoryViews.Height = $lblLayoutViews.Height
				$lblRepositoryViews.Left = $lblLayoutViews.Left
				$lblRepositoryViews.Top = $lbxLayoutViews.Bottom + 50
				$lblRepositoryViews.TextAlign = "MiddleLeft"
				$lblRepositoryViews.ForeColor = "Green"
				$lblRepositoryViews.Backcolor = "Transparent"
				$lblRepositoryViews.Text = "Views in Repository"
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
				$lbxRepositoryViews.Visible = $true
				$lbxRepositoryViews.Enabled = $false
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
								$rdoSyncAllResources.Enabled = $true
								$rdoSyncSelectedResources.Enabled = $true
								$cbxSyncToRepository.Enabled = $true
								$cbxPromptToCreateNewInCompanion.Enabled = $true
								$cbxPromptToOverwriteModels.Enabled = $true

								If ($rdoSyncAllResources.Checked) {$btnSyncFromxLights.Text = "Sync All From xLights"} Else {$btnSyncFromxLights.Text = "Select Resources to Sync"}

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
									$cbxSyncToRepository.Checked = $false
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
								$lblRepositoryModels.ForeColor = "Green"
								$txtFilterRepositoryModels.Enabled = $true
								$lbxRepositoryModels.Enabled = $true

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
								$lblRepositoryModelGroups.ForeColor = "Green"
								$txtFilterRepositoryModelGroups.Enabled = $true
								$lbxRepositoryModelGroups.Enabled = $true

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
									$lblRepositoryModelGroups.ForeColor = "Gray"
									$txtFilterRepositoryModelGroups.Enabled = $false
									$lbxRepositoryModelGroups.Enabled = $false

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
								$lblRepositoryViews.ForeColor = "Green"
								$txtFilterRepositoryViews.Enabled = $true
								$lbxRepositoryViews.Enabled = $true

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
									$lblRepositoryViews.ForeColor = "Gray"
									$txtFilterRepositoryViews.Enabled = $false
									$lbxRepositoryViews.Enabled = $false

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
				AddLayout "- Repository (Recovery) -"
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

				$btnSaveToFile.Enabled = $false
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

		# If ($boolUpdatedModelsExistInImport -or $boolUpdatedModelGroupsExistInImport -or $boolUpdatedViewsExistInImport)

		# Check to see if any models already exist in the repository.  If not, this is probably the first run of Companion so a sync needs to be performed.
		If ($objxlightscompanionxml.xlc.layouts.layout[0].Models.model.Count -lt 1)
			{
				# There are no models available in the Repository Models layout XML so a sync is required
				LogWrite "INFO" "No Repository Models are available so a sync from xLights is required"

				# Disable all of the content panels
				ModifyPanels "Disable" "Layouts"
				ModifyPanels "Disable" "Models" 
				ModifyPanels "Disable" "ModelGroups" 
				ModifyPanels "Disable" "Views" 

				# Highlight the Sync button
				$btnSyncFromxLights.Forecolor = "White"
				$btnSyncFromxLights.BackColor = "Green"
				$btnSyncFromxLights.Enabled = $true
				$cbxSyncToRepository.Checked = $true
				$cbxPromptToOverwriteModels.Enabled = $true
				$cbxPromptToCreateNewInCompanion.Enabled = $true
				
			}
			Else
				{
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

				$btnSaveToFile.Enabled = $true
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

		# Save the layout models
		UpdateLayoutResource -strTargetLayout $lbxLayouts.SelectedItem -strNodeType "Model"
		UpdateLayoutResource -strTargetLayout $lbxLayouts.SelectedItem -strNodeType "ModelGroup"
		UpdateLayoutResource -strTargetLayout $lbxLayouts.SelectedItem -strNodeType "View"

		$lbxLayouts.Enabled = $true

		If ($boolxLightsCompanionXMLIsChanged) 
			{
				$btnSaveToFile.Enabled = $true
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
					$btnSaveToFile.Forecolor = "Gray"
					$btnSaveToFile.BackColor = "LightGray"
					
					$btnFormSubmit.Enabled = $true
					$btnFormSubmit.Text = "Close"
					$btnFormSubmit.Forecolor = "Black"
					$btnFormSubmit.BackColor = "WhiteSmoke"	
				}

		$btnSaveLayout.Visible = $false
		$btnCancelReloadLayout.Visible = $false
		
		$global:boolLayoutModelsChanged = $false
		$global:boolLayoutModelGroupsChanged = $false
		$global:boolLayoutViewsChanged = $false

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
						
						$global:boolxLightsCompanionXMLIsChanged = $false
						
						$btnSaveToFile.Enabled = $false
						$btnSaveToFile.Forecolor = "Gray"
						$btnSaveToFile.BackColor = "LightGray"
						
						$btnFormSubmit.Enabled = $true
						$btnFormSubmit.Text = "Close"
						$btnFormSubmit.Forecolor = "Black"
						$btnFormSubmit.BackColor = "WhiteSmoke"	
				
						
						LogWrite "INFO" "Changes have been saved."
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


Function SyncxLightsToLayout ($strLayoutName, $strNodeType, $arrNodeNames, $boolOverridePrompts)
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

						ForEach ($strNodeName in $arrNodeNames)
							{
								LogWrite "VERBOSE" "Copying ""$strNodeName"""
			
								CopyXMLNode -strSource "xLights" -strTarget "Companion" -strLayoutName $strLayoutName -strNodeType $strNodeType -strNodeName $strNodeName -boolOverridePrompts $boolOverridePrompts

								$intNodesSynced++
							}
					}

				"ModelGroup"
					{
						# If a list of names wasn't passed, get all names from xLights
						If (!($arrNodeNames)) {$arrNodeNames = $objxLightsEffects.xrgb.modelGroups.modelGroup.name}

						ForEach ($strNodeName in $arrNodeNames)
							{
								LogWrite "VERBOSE" "Copying ""$strNodeName"""
			
								CopyXMLNode -strSource "xLights" -strTarget "Companion" -strLayoutName $strLayoutName -strNodeType $strNodeType -strNodeName $strNodeName -boolOverridePrompts $boolOverridePrompts

								$intNodesSynced++
							}
					}

				"View"
					{
						# If a list of names wasn't passed, get all names from xLights
						If (!($arrNodeNames)) {$arrNodeNames = $objxLightsEffects.xrgb.views.view.name}

						ForEach ($strNodeName in $arrNodeNames)
							{
								LogWrite "VERBOSE" "Copying ""$strNodeName"""
			
								CopyXMLNode -strSource "xLights" -strTarget "Companion" -strLayoutName $strLayoutName -strNodeType $strNodeType -strNodeName $strNodeName -boolOverridePrompts $boolOverridePrompts

								$intNodesSynced++
							}
					}
				
				default
					{
						LogWrite "WARNING" "Sync xLights to Layout was called with an invalid node type ($strNodeType)"
						Return
					}
			}

		LogWrite "VERBOSE" "Synced $intNodesSynced $strNodeType(s) to $strLayoutName"
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

												# # If specified, check the resource against xLights to see if it's different
												# If ($boolCheckForUpdates -ne $false)
												# 	{
												# 		# If an updated resource hasn't already been found and Check for updates has been specified, run the the update check
												# 		If ($boolUpdatedModelsExistInImport -ne $true -and $boolModelSyncFromxLightsComplete -ne $true)
												# 			{
												# 				# If the model has been updated in xLights, set the flag
												# 				If ((ComparexLightsToCompanion "Model" $_.Name) -eq $false)
												# 					{
												# 						LogWrite "VERBOSE" "A model ($($_.Name)) in xLights Companion (Repository Layout) has been updated in xLights"

												# 						$global:boolUpdatedModelsExistInImport = $true

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

												# # If specified, check the resource against xLights to see if it's different
												# If ($boolCheckForUpdates -ne $false)
												# 	{
												# 		# If an updated resource hasn't already been found and Check for updates has been specified, run the the update check
												# 		If ($boolUpdatedModelGroupsExistInImport -ne $true -and $boolModelGroupSyncFromxLightsComplete -ne $true)
												# 			{
												# 				# If the resouce has been updated in xLights, set the flag
												# 				If ((ComparexLightsToCompanion "ModelGroup" $_.Name) -eq $false)
												# 					{
												# 						LogWrite "VERBOSE" "A model group ($($_.Name)) in xLights Companion (Repository Layout) has been updated in xLights"

												# 						$global:boolUpdatedModelGroupsExistInImport = $true

												# 						Return
												# 					}
												# 			}
												# 	}
											}
										}

								$lbxRepositoryModelGroups.EndUpdate()
								
								# Go through the list of resources in the selected layout and remove them from the list of Repository resources
								$lbxLayoutModelGroups.Items | ForEach-Object {$lbxRepositoryModelGroups.Items.Remove($_)}

								# Go through the list of resources in the -Common- layout and remove them from the list of Repository resources
								($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.name -eq "- Common -"}).modelGroups.modelGroup.name -split "," | ForEach-Object {$lbxRepositoryModelGroups.Items.Remove($_)}

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

												# # If specified, check the resource against xLights to see if it's different
												# If ($boolCheckForUpdates -ne $false)
												# 	{
												# 		# If an updated resource hasn't already been found and Check for updates has been specified, run the the update check
												# 		If ($boolUpdatedViewsExistInImport -ne $true -and $boolViewSyncFromxLightsComplete -ne $true)
												# 			{
												# 				# If the resource has been updated in xLights, set the flag
												# 				If ((ComparexLightsToCompanion "View" $_.Name) -eq $false)
												# 					{
												# 						LogWrite "VERBOSE" "A view ($($_.Name)) in xLights Companion (Repository Layout) has been updated in xLights"

												# 						$global:boolUpdatedViewsExistInImport = $true

												# 						Return
												# 					}
												# 			}
												# 	}
											}
										}

								$lbxRepositoryViews.EndUpdate()
								
								# Go through the list of resources in the selected layout and remove them from the list of Repository resources
								$lbxLayoutViews.Items | ForEach-Object {$lbxRepositoryViews.Items.Remove($_)}

								# Go through the list of resources in the -Common- layout and remove them from the list of Repository resources
								($objxLightsCompanionXML.xlc.layouts.layout | Where-Object {$_.name -eq "- Common -"}).views.view.name -split "," | ForEach-Object {$lbxRepositoryViews.Items.Remove($_)}

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
						
						# Go through the list of models in the layout and remove them from the list of Repository models
						$lbxLayoutModels.Items | ForEach-Object {$lbxRepositoryModels.Items.Remove($_)}
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
												$boolOverwriteModel = [System.Windows.Forms.MessageBox]::Show("A model named ""$strNodeName"" already exists in $strTarget but the $strSource model is different.  `n`nThis is likely due to the model being updated in xLights and not sync'd to Companion.  `n`nWould you like to replace the $strTarget version?","Model Already Exists" , "YesNo", "Exclamation")

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
									"ModelGroup" {$intNewNodeCount = (($objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfLayout].ModelGroups.modelGroup | Where-Object {$_.name -eq $strNodeName} | Measure-Object).Count -eq 1)}
									"View" {$intNewNodeCount = (($objxLightsCompanionXML.xlc.layouts.layout[$intIndexOfLayout].Views.view | Where-Object {$_.name -eq $strNodeName} | Measure-Object).Count -eq 1)}
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
							LogWrite "WARNING" "Copying $strNodeType ""$strNodeName"" failed"
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
				
				# # Iterate through the list of models in xLights RGB Effects and, if the model does not exist in the to-commit list, remove it from xLights
				# ForEach ($strModelCurrentlyInxLights in $arrModelsCurrentlyInxLights)
				# 	{
				# 		If ($strModelCurrentlyInxLights -notin $arrCommonModelsToCommit -and $strModelCurrentlyInxLights -notin $arrLayoutModelsToCommit)
				# 			{
				# 				RemoveXMLNode -strTarget "xLights" -strNodeType "Model" -strNodeName $strModelCurrentlyInxLights -boolOverridePrompts $true
				# 			}
				# 	}
				
				# If the box is checked, iterate through the list of models in xLights RGB Effects and, if the model does not exist in the to-commit list, remove it from xLights
				If ($cbxRemoveExtraResources.Checked -eq $true)
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

				# If the box is checked, iterate through the list of common models to be committed and add/overwrite them.  If the box is checked, prompt before overwriting.
				If ($cbxAlsoLoadCommonLayout.Checked -eq $true)
					{
						ForEach ($strCommonModelToCommit in $arrCommonModelsToCommit)
							{
								CopyXMLNode -strSource "Companion" -strTarget "xlights" -strLayoutName "- Common -" -strNodeType "Model" -strNodeName $strCommonModelToCommit -boolOverridePrompts $cbxOverwriteExistingResources.Checked
							}
					}

				# If the selected layout is not '- Common -', iterate through the list of layout models to be committed and add/overwrite them.  If the box is checked, prompt before overwriting.
				If ($strLayoutName -ne "- Common -")
					{
						ForEach ($strLayoutModelToCommit in $arrLayoutModelsToCommit)
							{
								CopyXMLNode -strSource "Companion" -strTarget "xlights" -strLayoutName $strLayoutName -strNodeType "Model" -strNodeName $strLayoutModelToCommit -boolOverridePrompts $cbxOverwriteExistingResources.Checked
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

				# # Iterate through the list of Model Groups in xLights RGB Effects and, if the Model Group does not exist in the to-commit list, remove it from xLights
				# ForEach ($strModelGroupCurrentlyInxLights in $arrModelGroupsCurrentlyInxLights)
				# 	{
				# 		If ($strModelGroupCurrentlyInxLights -notin $arrCommonModelGroupsToCommit -and $strModelGroupCurrentlyInxLights -notin $arrLayoutModelGroupsToCommit)
				# 			{
				# 				RemoveXMLNode -strTarget "xLights" -strNodeType "ModelGroup" -strNodeName $strModelGroupCurrentlyInxLights -boolOverridePrompts $true
				# 			}
				# 	}

				# If the box is checked, iterate through the list of model groups in xLights RGB Effects and, if the model group does not exist in the to-commit list, remove it from xLights
				If ($cbxRemoveExtraResources.Checked -eq $true)
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

				# If the box is checked, iterate through the list of Common Model Groups to be committed and add/overwrite them.  If the box is checked, prompt before overwriting.
				If ($cbxAlsoLoadCommonLayout.Checked -eq $true)
					{
						ForEach ($strCommonModelGroupToCommit in $arrCommonModelGroupsToCommit)
							{
								CopyXMLNode -strSource "Companion" -strTarget "xlights" -strLayoutName "- Common -" -strNodeType "ModelGroup" -strNodeName $strCommonModelGroupToCommit -boolOverridePrompts $cbxOverwriteExistingResources.Checked
							}
					}

				# If the selected layout is not '- Common -', iterate through the list of Layout Model Groups to be committed and add/overwrite them.  If the box is checked, prompt before overwriting.
				If ($strLayoutName -ne "- Common -")
					{
						ForEach ($strLayoutModelGroupToCommit in $arrLayoutModelGroupsToCommit)
							{
								CopyXMLNode -strSource "Companion" -strTarget "xlights" -strLayoutName $strLayoutName -strNodeType "ModelGroup" -strNodeName $strLayoutModelGroupToCommit -boolOverridePrompts $cbxOverwriteExistingResources.Checked
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
				
				# # Iterate through the list of Views in xLights RGB Effects and, if the View does not exist in the to-commit list, remove it from xLights
				# ForEach ($strViewCurrentlyInxLights in $arrViewsCurrentlyInxLights)
				# 	{
				# 		If ($strViewCurrentlyInxLights -notin $arrCommonViewsToCommit -and $strViewCurrentlyInxLights -notin $arrLayoutViewsToCommit)
				# 			{
				# 				RemoveXMLNode -strTarget "xLights" -strNodeType "View" -strNodeName $strViewCurrentlyInxLights -boolOverridePrompts $true
				# 			}
				# 	}
					
				# If the box is checked, iterate through the list of view in xLights RGB Effects and, if the view does not exist in the to-commit list, remove it from xLights
				If ($cbxRemoveExtraResources.Checked -eq $true)
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

				# If the box is checked, iterate through the list of Common Views to be committed and add/overwrite them.  If the box is checked, prompt before overwriting.
				If ($cbxAlsoLoadCommonLayout.Checked -eq $true)
					{
						ForEach ($strCommonViewToCommit in $arrCommonViewsToCommit)
							{
								CopyXMLNode -strSource "Companion" -strTarget "xlights" -strLayoutName "- Common -" -strNodeType "View" -strNodeName $strCommonViewToCommit -boolOverridePrompts $cbxOverwriteExistingResources.Checked
							}
					}

				# If the selected layout is not '- Common -', iterate through the list of Layout Views to be committed and add/overwrite them.  If the box is checked, prompt before overwriting.
				If ($strLayoutName -ne "- Common -")
					{
						ForEach ($strLayoutViewToCommit in $arrLayoutViewsToCommit)
							{
								CopyXMLNode -strSource "Companion" -strTarget "xlights" -strLayoutName $strLayoutName -strNodeType "View" -strNodeName $strLayoutViewToCommit -boolOverridePrompts $cbxOverwriteExistingResources.Checked
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

				If (!($strxLightsPath) -or !(Test-Path $strxLightsPath))
					{
						LogWrite "VERBOSE" "Searching for xlights.exe........"
						$strxLightsPath = (Get-ChildItem -Path $env:ProgramFiles -filter xlights.exe -Recurse -ErrorAction SilentlyContinue).FullName
					}

				If (Test-Path $strxLightsPath)
					{
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










Function ShowSyncSelectedForm ($strLayoutName, $boolOverridePrompts, $boolPromptOnNewModels)
	{
		LogWrite "DEBUG" "Show the Sync Selected Form"
	
		$strSelectAllText = "- Select All -"

		# Draw the form
		If (!($frmSyncSelected)) 
			{
				$script:frmSyncSelected = New-Object System.Windows.Forms.Form
				$frmSyncSelected.BackColor = "Azure"
				$frmSyncSelected.Text = "Choose Resources to Sync"
				$frmSyncSelected.Width = $objForm.Width * .8
				$frmSyncSelected.Height = $objForm.Height * .6
				$frmSyncSelected.StartPosition = "CenterScreen" # CenterScreen, Manual, WindowsDefaultLocation, WindowsDefaultBounds, CenterParent
				$frmSyncSelected.ControlBox = $true # Show/hide the Min/Max/X buttons in the rop right corner of the window. If this is $false, the Minimize and Maximize buttons will be hidden, regardless of the settings below
				$frmSyncSelected.MinimizeBox = $false
				$frmSyncSelected.MaximizeBox = $false
				#$frmSyncSelected.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::DPI
				$frmSyncSelected.FormBorderStyle = "Fixed3D" # None, Fixed3D, FixedSingle
				$frmSyncSelected.Topmost = $true  
				$objIcon = [system.drawing.icon]::ExtractAssociatedIcon($strFormIconPath)
				$frmSyncSelected.Icon = $objIcon
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
				$script:lblDescription = New-Object System.Windows.Forms.Label
				$lblDescription.Left = 5
				$lblDescription.Top = 10
				$lblDescription.Width = $frmSyncSelected.Width - 10
				$lblDescription.Height = 20
				$lblDescription.TextAlign = "TopLeft"
				$lblDescription.Text = "Check the resources to sync to $(If ($strLayoutName -eq "- Repository (Recovery) -") {"Repository"} Else {$lbxLayouts.SelectedItem})"
				$lblDescription.ForeColor = "Blue"
				$lblDescription.Font = New-Object System.Drawing.Font("Arial",12)
				$lblDescription.Anchor = "Top,Left,Right"
				$frmSyncSelected.Controls.Add($lblDescription)
			}
	

		# Add the Selected Models label
		If (!($lblSelectedModels)) 
			{
				$script:lblSelectedModels = New-Object System.Windows.Forms.Label
				$lblSelectedModels.Left = $lblDescription.Left + 10
				$lblSelectedModels.Top = $lblDescription.Bottom + 20
				$lblSelectedModels.Width = 200
				# $lblSelectedModels.Height = $lblRenumberStartNode.Height
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
				$script:clbxSelectedModels = New-Object System.Windows.Forms.CheckedListBox
				$clbxSelectedModels.Left = $lblSelectedModels.Left
				$clbxSelectedModels.Top = $lblSelectedModels.Bottom
				$clbxSelectedModels.Width = ($frmSyncSelected.Width - 55) * .33
				$clbxSelectedModels.Height = 280
				# $clbxSelectedModels.TextAlign = "MiddleLeft"
				# $clbxSelectedModels.Text = "From Node: "
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
				$script:lblSelectedModelGroups = New-Object System.Windows.Forms.Label
				$lblSelectedModelGroups.Left = $clbxSelectedModels.Right + 10
				$lblSelectedModelGroups.Top = $lblSelectedModels.Top
				$lblSelectedModelGroups.Width = $lblSelectedModels.Width
				# $lblSelectedModelGroups.Height = $lblRenumberStartNode.Height
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
				$script:clbxSelectedModelGroups = New-Object System.Windows.Forms.CheckedListBox
				$clbxSelectedModelGroups.Left = $lblSelectedModelGroups.Left
				$clbxSelectedModelGroups.Top = $lblSelectedModelGroups.Bottom
				$clbxSelectedModelGroups.Width = $clbxSelectedModels.Width
				$clbxSelectedModelGroups.Height = $clbxSelectedModels.Height
				# $clbxSelectedModelGroups.TextAlign = "MiddleLeft"
				# $clbxSelectedModelGroups.Text = "From Node: "
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
				$script:lblSelectedViews = New-Object System.Windows.Forms.Label
				$lblSelectedViews.Left = $clbxSelectedModelGroups.Right + 10
				$lblSelectedViews.Top = $lblSelectedModels.Top
				$lblSelectedViews.Width = $lblSelectedModels.Width
				# $lblSelectedViews.Height = $lblRenumberStartNode.Height
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
				$script:clbxSelectedViews = New-Object System.Windows.Forms.CheckedListBox
				$clbxSelectedViews.Left = $lblSelectedViews.Left
				$clbxSelectedViews.Top = $lblSelectedViews.Bottom
				$clbxSelectedViews.Width = $clbxSelectedModels.Width
				$clbxSelectedViews.Height = $clbxSelectedModels.Height
				# $clbxSelectedViews.TextAlign = "MiddleLeft"
				# $clbxSelectedViews.Text = "From Node: "
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

			# Add the <All> item to the top of each list box
			$clbxSelectedModels.Items.Add($strSelectAllText)
			$clbxSelectedModelGroups.Items.Add($strSelectAllText)
			$clbxSelectedViews.Items.Add($strSelectAllText)
			

			# Load the list boxes
			LogWrite "VERBOSE" "Load xLights Models into Selected Models"
	
			# Get the list of models from xLights
			If ($strActiveInactiveAll -eq "Active") {$objxLightsModels = $objxLightsEffects.xrgb.models.ChildNodes | Where-Object {$_.Active -ne "0"}}
				ElseIf ($strActiveInactiveAll -eq "Inactive") {$objxLightsModels = $objxLightsEffects.xrgb.models.ChildNodes | Where-Object {$_.Active -eq "0"}}
					Else {$objxLightsModels = $objxLightsEffects.xrgb.models.ChildNodes}
			
			# Copy each model to xlights Companion
			LogWrite "VERBOSE" "Found $(($objxLightsEffects.xrgb.models.model.Count)) Models to Load"
	
			$objxLightsModels | ForEach-Object {
					
					LogWrite "VERBOSE" "Loading ""$($_.name)"""
					
					$clbxSelectedModels.Items.Add($_.name)
				}


			LogWrite "VERBOSE" "Load xLights Model Groups into Selected Model Groups"

			# Get the list of model groups from xLights
			If ($strActiveInactiveAll -eq "Active") {$objxLightsModelGroups = $objxLightsEffects.xrgb.modelGroups.ChildNodes}
				ElseIf ($strActiveInactiveAll -eq "Inactive") {$objxLightsModelGroups = $objxLightsEffects.xrgb.modelGroups.ChildNodes}
					Else {$objxLightsModelGroups = $objxLightsEffects.xrgb.modelGroups.ChildNodes}
			
			# Copy each model to xlights Companion
			LogWrite "VERBOSE" "Found $(($objxLightsEffects.xrgb.modelGroups.modelGroup.Count)) Model Groups to Load"
	
			$objxLightsModelGroups | ForEach-Object {
					
					LogWrite "VERBOSE" "Loading ""$($_.name)"""
					
					$clbxSelectedModelGroups.Items.Add($_.name)
				}


			LogWrite "VERBOSE" "Load xLights Views into Selected Views"

			# Get the list of views from xLights
			If ($strActiveInactiveAll -eq "Active") {$objxLightsViews = $objxLightsEffects.xrgb.views.ChildNodes}
				ElseIf ($strActiveInactiveAll -eq "Inactive") {$objxLightsViews = $objxLightsEffects.xrgb.views.ChildNodes}
					Else {$objxLightsViews = $objxLightsEffects.xrgb.views.ChildNodes}
			
			# Copy each model to xlights Companion
			LogWrite "VERBOSE" "Found $(($objxLightsEffects.xrgb.views.view.Count)) Views to Load"
	
			$objxLightsViews | ForEach-Object {
					
					LogWrite "VERBOSE" "Loading ""$($_.name)"""
					
					$clbxSelectedViews.Items.Add($_.name)
				}
		

		# # Create the Start Node number box
		# If (!($intRenumberStartNode)) 
		# 	{
		# 		$script:intRenumberStartNode = New-Object System.Windows.Forms.NumericUpDown
		# 		$intRenumberStartNode.Width = 75
		# 		$intRenumberStartNode.Height = 20
		# 	    $intRenumberStartNode.Left = $lblRenumberStartNode.Right + 10
		# 		$intRenumberStartNode.Top = $lblRenumberStartNode.Top
		# 		$intRenumberStartNode.Font = New-Object System.Drawing.Font("Arial",10)
		# 		$intRenumberStartNode.Minimum = "1"
		# 		$intRenumberStartNode.Maximum = "9999"
		# 		$intRenumberStartNode.Value = 1
		# 		$intRenumberStartNode.Anchor = "Top,Right"
		# 		$frmSyncSelected.Controls.Add($intRenumberStartNode)
		# 	}

		# # Add End Node label
		# If (!($lblRenumberEndNode)) 
		# 	{
		# 		$script:lblRenumberEndNode = New-Object System.Windows.Forms.Label
		# 		$lblRenumberEndNode.Left = $intRenumberStartNode.Right + 10
		# 		$lblRenumberEndNode.Top = $lblRenumberStartNode.Top
		# 		$lblRenumberEndNode.Width = 50
		# 		$lblRenumberEndNode.Height = $lblRenumberStartNode.Height
		# 		$lblRenumberEndNode.TextAlign = "MiddleCenter"
		# 		$lblRenumberEndNode.Text = "to: "
		# 		$lblRenumberEndNode.ForeColor = "Black"
		# 		$lblRenumberEndNode.Font = New-Object System.Drawing.Font("Arial",10)
		# 		$lblRenumberEndNode.Anchor = "Top,Left,Right"
		# 		$frmSyncSelected.Controls.Add($lblRenumberEndNode)
		# 	}
	
		# # Create the End Node number box
		# If (!($intRenumberEndNode)) 
		# 	{
		# 		$script:intRenumberEndNode = New-Object System.Windows.Forms.NumericUpDown
		# 		$intRenumberEndNode.Width = $intRenumberStartNode.Width
		# 		$intRenumberEndNode.Height = $intRenumberStartNode.Height
		# 	    $intRenumberEndNode.Left = $lblRenumberEndNode.Right + 10
		# 		$intRenumberEndNode.Top = $intRenumberStartNode.Top
		# 		$intRenumberEndNode.Font = New-Object System.Drawing.Font("Arial",10)
		# 		$intRenumberEndNode.Minimum = "1"
		# 		$intRenumberEndNode.Maximum = "9999"
		# 		$intRenumberEndNode.Value = 1
		# 		$intRenumberEndNode.Anchor = "Top,Right"
		# 		$frmSyncSelected.Controls.Add($intRenumberEndNode)	
		# 	}
	
		# # Add Increment By label
		# If (!($lblIncrementBy)) 
		# 	{
		# 		$script:lblIncrementBy = New-Object System.Windows.Forms.Label
		# 		$lblIncrementBy.Left = $lblRenumberStartNode.Left
		# 		$lblIncrementBy.Top = $lblRenumberStartNode.Bottom + 20
		# 		$lblIncrementBy.Width = $lblRenumberStartNode.Width
		# 		$lblIncrementBy.Height = $lblRenumberStartNode.Height
		# 		$lblIncrementBy.TextAlign = "MiddleLeft"
		# 		$lblIncrementBy.Text = "Increment By: "
		# 		$lblIncrementBy.ForeColor = "Black"
		# 		$lblIncrementBy.Font = New-Object System.Drawing.Font("Arial",10)
		# 		$lblIncrementBy.Anchor = "Top,Left,Right"
		# 		$frmSyncSelected.Controls.Add($lblIncrementBy)
		# 	}
		
		# # Create the Increment By number box
		# If (!($intIncrementBy)) 
		# 	{
		# 		$script:intIncrementBy = New-Object System.Windows.Forms.NumericUpDown
		# 		$intIncrementBy.Width = $intRenumberStartNode.Width
		# 		$intIncrementBy.Height = $intRenumberStartNode.Height
		# 	    $intIncrementBy.Left = $intRenumberStartNode.Left
		# 		$intIncrementBy.Top = $lblIncrementBy.Top
		# 		$intIncrementBy.Font = New-Object System.Drawing.Font("Arial",10)
		# 		$intIncrementBy.Minimum = "1"
		# 		$intIncrementBy.Maximum = "100"
		# 		$intIncrementBy.Value = 1
		# 		$intIncrementBy.Anchor = "Top,Right"
		# 		$frmSyncSelected.Controls.Add($intIncrementBy)
		# 	}

		# # Add warning label
		# If (!($lblUnprocessWarning)) 
		# 	{
		# 		$script:lblUnprocessWarning = New-Object System.Windows.Forms.Label
		# 		$lblUnprocessWarning.Left = $lblRenumberStartNode.Left
		# 		$lblUnprocessWarning.Top = $lblIncrementBy.Bottom + 10
		# 		$lblUnprocessWarning.Width = $frmSyncSelected.Width - 10
		# 		$lblUnprocessWarning.Height = 20
		# 		$lblUnprocessWarning.TextAlign = "TopLeft"
		# 		$lblUnprocessWarning.Text = ""
		# 		$lblUnprocessWarning.ForeColor = "Red"
		# 		$lblUnprocessWarning.Font = New-Object System.Drawing.Font("Arial",10)
		# 		$lblUnprocessWarning.Anchor = "Top,Left,Right"
		# 		$frmSyncSelected.Controls.Add($lblUnprocessWarning)
		# 	}
	
#		# Add the On Screen Keyboard button
#		If (!($btnRenumberNodesOnscreenKeyboard)) 
#			{
#				$script:btnRenumberNodesOnscreenKeyboard = New-Object Windows.Forms.Button
#				$btnRenumberNodesOnscreenKeyboard.Left = 5
#				$btnRenumberNodesOnscreenKeyboard.Top = $frmSyncSelected.Height - .Bottom + 20
#				$btnRenumberNodesOnscreenKeyboard.Width = $frmSyncSelected.Width * .4
#				$btnRenumberNodesOnscreenKeyboard.Text = "On Screen Keyboard"
#				$btnRenumberNodesOnscreenKeyboard.TextAlign = "MiddleCenter"
#				$btnRenumberNodesOnscreenKeyboard.Cursor = "Hand"
#				$btnRenumberNodesOnscreenKeyboard.BackColor = "WhiteSmoke"
#				$btnRenumberNodesOnscreenKeyboard.Anchor = "Bottom,Left"
#				$btnRenumberNodesOnscreenKeyboard.Add_Click({
#						Start-Process -FilePath "$env:SystemRoot\System32\osk.exe"
#						$txtStartNode.Focus()
#					})
#				$frmSyncSelected.Controls.Add($btnRenumberNodesOnscreenKeyboard)
#			}
		
		# Add the Sync button
		If (!($btnSyncSelected)) 
			{
				$script:btnSyncSelected = New-Object System.Windows.Forms.Button
				$btnSyncSelected.Width = $frmSyncSelected.Width * .1
				$btnSyncSelected.Left = $frmSyncSelected.Width - ($btnSyncSelected.Width * 2) - 50
				$btnSyncSelected.Top = $frmSyncSelected.Height - $btnSyncSelected.Height - 50
				$btnSyncSelected.Forecolor = "White"
				$btnSyncSelected.BackColor = "Green"
				$btnSyncSelected.Text = "Start Sync"
				$btnSyncSelected.Anchor = "Bottom,Right"
				$btnSyncSelected.Cursor = "Hand"
				$btnSyncSelected.Add_Click({
				
						If ($clbxSelectedModels.CheckedItems.Count -ge 1) {SyncxLightsToLayout -strLayoutName $strLayoutName -strNodeType "Model" -arrNodeNames $clbxSelectedModels.CheckedItems -boolOverridePrompts $boolOverridePrompts} Else {LogWrite "VERBOSE" "No Models Selected For Sync"}
						If ($clbxSelectedModelGroups.CheckedItems.Count -ge 1) {SyncxLightsToLayout -strLayoutName $strLayoutName -strNodeType "ModelGroup" -arrNodeNames $clbxSelectedModelGroups.CheckedItems -boolOverridePrompts $boolOverridePrompts} Else {LogWrite "VERBOSE" "No Model Groups Selected For Sync"}
						If ($clbxSelectedViews.CheckedItems.Count -ge 1) {SyncxLightsToLayout -strLayoutName $strLayoutName -strNodeType "View" -arrNodeNames $clbxSelectedViews.CheckedItems -boolOverridePrompts $boolOverridePrompts} Else {LogWrite "VERBOSE" "No Views Selected For Sync"}

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

						# # Load the Companion layouts
						# LoadLayoutsFromCompanionXML

						# Enable the Layouts panel
						ModifyPanels "Enable" "Layouts" 

						# Disable Sync From
						ModifyPanels "Disable" "SyncFrom"
						
						$cbxSyncToRepository.ForeColor = "Black"
													
					})
				$frmSyncSelected.Controls.Add($btnSyncSelected)
			}
				
		# Add the Cancel button
		If (!($btnCancelSyncSelected)) 
			{
				$script:btnCancelSyncSelected = New-Object Windows.Forms.Button
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


