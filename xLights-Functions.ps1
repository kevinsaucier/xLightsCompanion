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



Function ToggleTouchScreen
	{
		# If the Touch Screen ID hasn't been retrieved yet, retrieve it
		If (!($strHIDTouchScreenID)) {$script:strHIDTouchScreenID = (Get-CimInstance Win32_PNPEntity | Where-Object {$_.Name -like "*touch*screen"}).PNPDeviceID}
		
		# If the Touch Screen Device is currently enabled, disable it.  If Disabled, Enable it.
		If ((Get-PnpDevice -InstanceID $strHIDTouchScreenID).Status -eq "OK")
			{
				Try
					{
						LogWrite "INFO" "Disabling Touch Screen"
					
						# Disable the touch screen and update the sub header label
						Disable-PnpDevice -InstanceID $strHIDTouchScreenID -Confirm:$false

						# The variable boolShowScriptDateInHeader above must be true for this Label to exist
						$lblHeader.ForeColor = "Red"
						If ($lblSubHeader)
							{
								$lblSubHeader.Text = "TOUCH SCREEN DISABLED"
								$lblSubHeader.ForeColor = "Red"
							}
					}
					Catch
						{
							LogWrite "WARNING" "Disabling Touch Screen Failed $_"
						}
			}
			Else
				{
					Try
					{
						LogWrite "INFO" "Enabling Touch Screen"
					
						# Enable the touch screen and update the sub header label
						Enable-PnpDevice -InstanceID $strHIDTouchScreenID -Confirm:$false

						# The variable boolShowScriptDateInHeader above must be true for this Label to exist
						$lblHeader.ForeColor = "Green"
						If ($lblSubHeader)
							{
								$lblSubHeader.Text = "TOUCH SCREEN ENABLED"
								$lblSubHeader.ForeColor = "Green"
							}
					}
					Catch
						{
							LogWrite "WARNING" "Enabling Touch Screen Failed $_"
						}
				}	
	}
	
	

Function SaveSettings
	{
		LogWrite "INFO" "Saving Settings to Registry"
		New-ItemProperty $strxLightsCompanionRegRoot -Name "DeployTagNumberMinLength" -Value $intDeployTagNumberMinLength.Value -PropertyType String -Force | Out-Null
		New-ItemProperty $strxLightsCompanionRegRoot -Name "DeployTagNumberMaxLength" -Value $intDeployTagNumberMaxLength.Value -PropertyType String -Force | Out-Null
		New-ItemProperty $strxLightsCompanionRegRoot -Name "ReclaimTagNumberMinLength" -Value $intReclaimTagNumberMinLength.Value -PropertyType String -Force | Out-Null
		New-ItemProperty $strxLightsCompanionRegRoot -Name "ReclaimTagNumberMaxLength" -Value $intReclaimTagNumberMaxLength.Value -PropertyType String -Force | Out-Null
		New-ItemProperty $strxLightsCompanionRegRoot -Name "DeployMinimumImagedDate" -Value $dtDeployMinimumImagedDate.Value -PropertyType String -Force | Out-Null
		New-ItemProperty $strxLightsCompanionRegRoot -Name "EnforceDevicePOLocation" -Value $cboEnforceDevicePOLocation.SelectedItem -PropertyType String -Force | Out-Null
		New-ItemProperty $strxLightsCompanionRegRoot -Name "EnforceDevicePOLocation" -Value $cboEnforceDevicePOLocation.SelectedItem -PropertyType String -Force | Out-Null
		New-ItemProperty $strxLightsCompanionRegRoot -Name "ReclaimInfoRequiredSerialNumber" -Value $cbxReclaimInfoRequiredSerialNumber.Checked -PropertyType String -Force | Out-Null
		New-ItemProperty $strxLightsCompanionRegRoot -Name "ReclaimInfoRequiredAssetNumber" -Value $cbxReclaimInfoRequiredAssetNumber.Checked -PropertyType String -Force | Out-Null
		New-ItemProperty $strxLightsCompanionRegRoot -Name "ReclaimInfoRequiredOtherNumber" -Value $cbxReclaimInfoRequiredAnyNumber.Checked -PropertyType String -Force | Out-Null
		
#		# Set the EnforceDevicePOLocation and Show/Hide the PO Number boxes based on the variable
#		SetEnforceDevicePOLocationVariable
#		ValidateLocation
	}
	
	
Function ReloadSettings
	{
		LogWrite "INFO" "Reload Settings from Registry"
	
		$objDeploymentTrackingSettings = Get-ItemProperty -Path $strxLightsCompanionRegRoot -ErrorAction SilentlyContinue
	
		If ($objDeploymentTrackingSettings.DeployTagNumberMinLength) {$intDeployTagNumberMinLength.Value = $objDeploymentTrackingSettings.DeployTagNumberMinLength}
		If ($objDeploymentTrackingSettings.DeployTagNumberMaxLength) {$intDeployTagNumberMaxLength.Value = $objDeploymentTrackingSettings.DeployTagNumberMaxLength}
		If ($objDeploymentTrackingSettings.ReclaimTagNumberMinLength) {$intReclaimTagNumberMinLength.Value = $objDeploymentTrackingSettings.ReclaimTagNumberMinLength}
		If ($objDeploymentTrackingSettings.ReclaimTagNumberMaxLength) {$intReclaimTagNumberMaxLength.Value = $objDeploymentTrackingSettings.ReclaimTagNumberMaxLength}
		If ($objDeploymentTrackingSettings.DeployMinimumImagedDate) {$dtDeployMinimumImagedDate.Value = $objDeploymentTrackingSettings.DeployMinimumImagedDate}
		If ($objDeploymentTrackingSettings.EnforceDevicePOLocation) {$cboEnforceDevicePOLocation.SelectedItem = $objDeploymentTrackingSettings.EnforceDevicePOLocation}
		If ($objDeploymentTrackingSettings.ReclaimInfoRequiredSerialNumber) {If ($objDeploymentTrackingSettings.ReclaimInfoRequiredSerialNumber -eq "True") {$cbxReclaimInfoRequiredSerialNumber.Checked = $true} Else {$cbxReclaimInfoRequiredSerialNumber.Checked = $false}}
		If ($objDeploymentTrackingSettings.ReclaimInfoRequiredAssetNumber) {If ($objDeploymentTrackingSettings.ReclaimInfoRequiredAssetNumber -eq "True") {$cbxReclaimInfoRequiredAssetNumber.Checked = $true} Else {$cbxReclaimInfoRequiredAssetNumber.Checked = $false}}
		If ($objDeploymentTrackingSettings.ReclaimInfoRequiredOtherNumber) {If ($objDeploymentTrackingSettings.ReclaimInfoRequiredOtherNumber -eq "True") {$cbxReclaimInfoRequiredAnyNumber.Checked = $true} Else {$cbxReclaimInfoRequiredAnyNumber.Checked = $false}}
		
#		SetEnforceDevicePOLocationVariable
	}


Function AddSettings
	{
		LogWrite "INFO" "Add Settings to Window"
	
		# Update the settings registry path
		$script:strxLightsCompanionRegRoot = "$strxLightsCompanionRegRoot\Settings"
	
		# If the Settings registry path doesn't exist or isn't already populated, (re)create it
		# Note that this will delete/recreate the Settings Key if there are no values in it.  This will delete any subkeys.
		Try {
				If (!((Get-ItemProperty -Path $strxLightsCompanionRegRoot -ErrorAction SilentlyContinue).CreateDate))
					{
						New-Item $strxLightsCompanionRegRoot -Force | Out-Null
						New-ItemProperty $strxLightsCompanionRegRoot -Name "CreateDate" -Value $(Get-Date -Format G) | Out-Null
					}
			} Catch {}
					
		# Create the Deploy Tag Number Minimum Length label
		LogWrite "INFO" "Add the Deploy Tag Number Minimum Length Label"
		If (!($lblDeployTagNumberMinLength)) {$script:lblDeployTagNumberMinLength = New-Object System.Windows.Forms.Label}
	    $lblDeployTagNumberMinLength.Width = $intPanel6ContentLabelWidth
		$lblDeployTagNumberMinLength.Height = $intPanel6ContentLabelHeight
	    $lblDeployTagNumberMinLength.Left = ($pnlContentPanel6.Width / 2) - (($intPanel6ContentLabelWidth + $intPanel6ContentDataWidth) / 2)
		$lblDeployTagNumberMinLength.Top = 50
		$lblDeployTagNumberMinLength.Font = New-Object System.Drawing.Font("Arial",12)
	    $lblDeployTagNumberMinLength.Text = "Deploy Tag Number - Minimum Length (3 to 20)"
		$lblDeployTagNumberMinLength.Cursor = "Arrow"
		$lblDeployTagNumberMinLength.TextAlign = "MiddleLeft"
		$lblDeployTagNumberMinLength.Anchor = "Top,Right"
	    $pnlContentPanel6.Controls.Add($lblDeployTagNumberMinLength)
	
		# Create the Deploy Tag Number Minimum Length text box
		LogWrite "INFO" "Add the Deploy Tag Number Minimum Length Text Box"
		If (!($intDeployTagNumberMinLength)) {$script:intDeployTagNumberMinLength = New-Object System.Windows.Forms.NumericUpDown}
		$intDeployTagNumberMinLength.Width = $intPanel6ContentDataWidth
		$intDeployTagNumberMinLength.Height = $intPanel6ContentDataHeight
	    $intDeployTagNumberMinLength.Left = $lblDeployTagNumberMinLength.Right
		$intDeployTagNumberMinLength.Top = $lblDeployTagNumberMinLength.Top - 5
		$intDeployTagNumberMinLength.Font = New-Object System.Drawing.Font("Arial",12)
		$intDeployTagNumberMinLength.Minimum = "3"
		$intDeployTagNumberMinLength.Maximum = "7"
		$intDeployTagNumberMinLength.Value = $intDeployTagNumberMinLength.Maximum
		$intDeployTagNumberMinLength.Anchor = "Top,Right"
		$pnlContentPanel6.Controls.Add($intDeployTagNumberMinLength)
	
		# Create the Deploy Tag Number Maximum Length label
		LogWrite "INFO" "Add the Deploy Tag Number Maximum Length Label"
		If (!($lblDeployTagNumberMaxLength)) {$script:lblDeployTagNumberMaxLength = New-Object System.Windows.Forms.Label}
	    $lblDeployTagNumberMaxLength.Width = $intPanel6ContentLabelWidth
		$lblDeployTagNumberMaxLength.Height = $intPanel6ContentLabelHeight
	    $lblDeployTagNumberMaxLength.Left = $lblDeployTagNumberMinLength.Left
		$lblDeployTagNumberMaxLength.Top = $lblDeployTagNumberMinLength.Bottom + 20
		$lblDeployTagNumberMaxLength.Font = New-Object System.Drawing.Font("Arial",12)
	    $lblDeployTagNumberMaxLength.Text = "Deploy Tag Number - Maximum Length (3 to 20)"
		$lblDeployTagNumberMaxLength.Cursor = "Arrow"
		$lblDeployTagNumberMaxLength.TextAlign = "MiddleLeft"
		$lblDeployTagNumberMaxLength.Anchor = "Top,Right"
	    $pnlContentPanel6.Controls.Add($lblDeployTagNumberMaxLength)
	
		# Create the Deploy Tag Number Maximum Length text box
		LogWrite "INFO" "Add the Deploy Tag Number Maximum Length Text Box"
		If (!($intDeployTagNumberMaxLength)) {$script:intDeployTagNumberMaxLength = New-Object System.Windows.Forms.NumericUpDown}
		$intDeployTagNumberMaxLength.Width = $intPanel6ContentDataWidth
		$intDeployTagNumberMaxLength.Height = $intPanel6ContentDataHeight
	    $intDeployTagNumberMaxLength.Left = $lblDeployTagNumberMaxLength.Right
		$intDeployTagNumberMaxLength.Top = $lblDeployTagNumberMaxLength.Top - 5
		$intDeployTagNumberMaxLength.Font = New-Object System.Drawing.Font("Arial",12)
		$intDeployTagNumberMaxLength.Minimum = "3"
		$intDeployTagNumberMaxLength.Maximum = "15"
		$intDeployTagNumberMaxLength.Value = $intDeployTagNumberMaxLength.Maximum
		$intDeployTagNumberMaxLength.Anchor = "Top,Right"
		$pnlContentPanel6.Controls.Add($intDeployTagNumberMaxLength)
	
	
		# Create the Reclaim Tag Number Minimum Length label
		LogWrite "INFO" "Add the Reclaim Tag Number Minimum Length Label"
		If (!($lblReclaimTagNumberMinLength)) {$script:lblReclaimTagNumberMinLength = New-Object System.Windows.Forms.Label}
	    $lblReclaimTagNumberMinLength.Width = $intPanel6ContentLabelWidth
		$lblReclaimTagNumberMinLength.Height = $intPanel6ContentLabelHeight
	    $lblReclaimTagNumberMinLength.Left = $lblDeployTagNumberMaxLength.Left
		$lblReclaimTagNumberMinLength.Top = $lblDeployTagNumberMaxLength.Bottom + 40
		$lblReclaimTagNumberMinLength.Font = New-Object System.Drawing.Font("Arial",12)
	    $lblReclaimTagNumberMinLength.Text = "Reclaim Tag Number - Minimum Length (3 to 20)"
		$lblReclaimTagNumberMinLength.Cursor = "Arrow"
		$lblReclaimTagNumberMinLength.TextAlign = "MiddleLeft"
		$lblReclaimTagNumberMinLength.Anchor = "Top,Right"
	    $pnlContentPanel6.Controls.Add($lblReclaimTagNumberMinLength)
	
		# Create the Reclaim Tag Number Minimum Length text box
		LogWrite "INFO" "Add the Reclaim Tag Number Minimum Length Text Box"
		If (!($intReclaimTagNumberMinLength)) {$script:intReclaimTagNumberMinLength = New-Object System.Windows.Forms.NumericUpDown}
		$intReclaimTagNumberMinLength.Width = $intPanel6ContentDataWidth
		$intReclaimTagNumberMinLength.Height = $intPanel6ContentDataHeight
	    $intReclaimTagNumberMinLength.Left = $lblReclaimTagNumberMinLength.Right
		$intReclaimTagNumberMinLength.Top = $lblReclaimTagNumberMinLength.Top - 5
		$intReclaimTagNumberMinLength.Font = New-Object System.Drawing.Font("Arial",12)
		$intReclaimTagNumberMinLength.Minimum = "3"
		$intReclaimTagNumberMinLength.Maximum = "7"
		$intReclaimTagNumberMinLength.Value = $intReclaimTagNumberMinLength.Maximum
		$intReclaimTagNumberMinLength.Anchor = "Top,Right"
		$pnlContentPanel6.Controls.Add($intReclaimTagNumberMinLength)
		
		# Create the Reclaim Tag Number Maximum Length label
		LogWrite "INFO" "Add the Reclaim Tag Number Maximum Length Label"
		If (!($lblReclaimTagNumberMaxLength)) {$script:lblReclaimTagNumberMaxLength = New-Object System.Windows.Forms.Label}
	    $lblReclaimTagNumberMaxLength.Width = $intPanel6ContentLabelWidth
		$lblReclaimTagNumberMaxLength.Height = $intPanel6ContentLabelHeight
	    $lblReclaimTagNumberMaxLength.Left = $lblReclaimTagNumberMinLength.Left
		$lblReclaimTagNumberMaxLength.Top = $lblReclaimTagNumberMinLength.Bottom + 20
		$lblReclaimTagNumberMaxLength.Font = New-Object System.Drawing.Font("Arial",12)
	    $lblReclaimTagNumberMaxLength.Text = "Reclaim Tag Number - Maximum Length (3 to 20)"
		$lblReclaimTagNumberMaxLength.Cursor = "Arrow"
		$lblReclaimTagNumberMaxLength.TextAlign = "MiddleLeft"
		$lblReclaimTagNumberMaxLength.Anchor = "Top,Right"
	    $pnlContentPanel6.Controls.Add($lblReclaimTagNumberMaxLength)
	
		# Create the Reclaim Tag Number Maximum Length text box
		LogWrite "INFO" "Add the Reclaim Tag Number Maximum Length Text Box"
		If (!($intReclaimTagNumberMaxLength)) {$script:intReclaimTagNumberMaxLength = New-Object System.Windows.Forms.NumericUpDown}
		$intReclaimTagNumberMaxLength.Width = $intPanel6ContentDataWidth
		$intReclaimTagNumberMaxLength.Height = $intPanel6ContentDataHeight
	    $intReclaimTagNumberMaxLength.Left = $lblReclaimTagNumberMaxLength.Right
		$intReclaimTagNumberMaxLength.Top = $lblReclaimTagNumberMaxLength.Top - 5
		$intReclaimTagNumberMaxLength.Font = New-Object System.Drawing.Font("Arial",12)
		$intReclaimTagNumberMaxLength.Minimum = "3"
		$intReclaimTagNumberMaxLength.Maximum = "15"
		$intReclaimTagNumberMaxLength.Value = $intReclaimTagNumberMaxLength.Maximum
		$intReclaimTagNumberMaxLength.Anchor = "Top,Right"
		$pnlContentPanel6.Controls.Add($intReclaimTagNumberMaxLength)
	
		
		# Create the Reclaim Info Required label
		LogWrite "INFO" "Add the Reclaim Tag Number Maximum Length Label"
		If (!($lblReclaimInfoRequired)) {$script:lblReclaimInfoRequired = New-Object System.Windows.Forms.Label}
	    $lblReclaimInfoRequired.Width = $intPanel6ContentLabelWidth
		$lblReclaimInfoRequired.Height = $intPanel6ContentLabelHeight
	    $lblReclaimInfoRequired.Left = $lblReclaimTagNumberMaxLength.Left
		$lblReclaimInfoRequired.Top = $lblReclaimTagNumberMaxLength.Bottom + 20
		$lblReclaimInfoRequired.Font = New-Object System.Drawing.Font("Arial",12)
	    $lblReclaimInfoRequired.Text = "Scans Required for Reclamation"
		$lblReclaimInfoRequired.Cursor = "Arrow"
		$lblReclaimInfoRequired.TextAlign = "MiddleLeft"
		$lblReclaimInfoRequired.Anchor = "Top,Right"
	    $pnlContentPanel6.Controls.Add($lblReclaimInfoRequired)
	
		# Create the Reclaim Info Serial Number checkbox
		LogWrite "INFO" "Add the Reclaim Info Serial Number checkbox"
		If (!($cbxReclaimInfoRequiredSerialNumber)) {$script:cbxReclaimInfoRequiredSerialNumber = New-Object System.Windows.Forms.Checkbox}
		$cbxReclaimInfoRequiredSerialNumber.Width = $intPanel6ContentLabelWidth * .2
		$cbxReclaimInfoRequiredSerialNumber.Height = $intPanel6ContentDataHeight
	    $cbxReclaimInfoRequiredSerialNumber.Left = $lblReclaimInfoRequired.Right
		$cbxReclaimInfoRequiredSerialNumber.Top = $lblReclaimInfoRequired.Top - 5
		$cbxReclaimInfoRequiredSerialNumber.Font = New-Object System.Drawing.Font("Arial",9)
		$cbxReclaimInfoRequiredSerialNumber.Text = "Serial #"
		$cbxReclaimInfoRequiredSerialNumber.Anchor = "Top,Right"
		$pnlContentPanel6.Controls.Add($cbxReclaimInfoRequiredSerialNumber)
	
		# Create the Reclaim Info Asset Number checkbox
		LogWrite "INFO" "Add the Reclaim Info Asset Number checkbox"
		If (!($cbxReclaimInfoRequiredAssetNumber)) {$script:cbxReclaimInfoRequiredAssetNumber = New-Object System.Windows.Forms.Checkbox}
		$cbxReclaimInfoRequiredAssetNumber.Width = $intPanel6ContentLabelWidth * .2
		$cbxReclaimInfoRequiredAssetNumber.Height = $intPanel6ContentDataHeight
	    $cbxReclaimInfoRequiredAssetNumber.Left = $cbxReclaimInfoRequiredSerialNumber.Right + 20
		$cbxReclaimInfoRequiredAssetNumber.Top = $lblReclaimInfoRequired.Top - 5
		$cbxReclaimInfoRequiredAssetNumber.Font = New-Object System.Drawing.Font("Arial",9)
		$cbxReclaimInfoRequiredAssetNumber.Text = "Asset #"
		$cbxReclaimInfoRequiredAssetNumber.Anchor = "Top,Right"
		$pnlContentPanel6.Controls.Add($cbxReclaimInfoRequiredAssetNumber)
		
#		# Create the Reclaim Info Other Number checkbox
#		LogWrite "INFO" "Add the Reclaim Info Other Number checkbox"
#		If (!($cbxReclaimInfoRequiredAnyNumber)) {$script:cbxReclaimInfoRequiredAnyNumber = New-Object System.Windows.Forms.Checkbox}
#		$cbxReclaimInfoRequiredAnyNumber.Width = $intPanel6ContentLabelWidth * .2
#		$cbxReclaimInfoRequiredAnyNumber.Height = $intPanel6ContentDataHeight
#	    $cbxReclaimInfoRequiredAnyNumber.Left = $cbxReclaimInfoRequiredAssetNumber.Right + 20
#		$cbxReclaimInfoRequiredAnyNumber.Top = $lblReclaimInfoRequired.Top - 5
#		$cbxReclaimInfoRequiredAnyNumber.Font = New-Object System.Drawing.Font("Arial",9)
#		$cbxReclaimInfoRequiredAnyNumber.Text = "Either #"
#		$cbxReclaimInfoRequiredAnyNumber.Anchor = "Top,Right"
#		$pnlContentPanel6.Controls.Add($cbxReclaimInfoRequiredAnyNumber)
		
	
#		# Create the Deploy Minimum Create Date label
#		LogWrite "INFO" "Add the Deploy Minimum Create Date Label"
#		If (!($lblDeployMinimumCreateDate)) {$script:lblDeployMinimumCreateDate = New-Object System.Windows.Forms.Label}
#	    $lblDeployMinimumCreateDate.Width = $intPanel6ContentLabelWidth
#		$lblDeployMinimumCreateDate.Height = $intPanel6ContentLabelHeight
#	    $lblDeployMinimumCreateDate.Left = $lblReclaimTagNumberMinLength.Left
#		$lblDeployMinimumCreateDate.Top = $lblReclaimInfoRequired.Bottom + 30
#		$lblDeployMinimumCreateDate.Font = New-Object System.Drawing.Font("Arial",12)
#	    $lblDeployMinimumCreateDate.Text = "Deploy Tag Number - Minimum Create Date"
#		$lblDeployMinimumCreateDate.Cursor = "Arrow"
#		$lblDeployMinimumCreateDate.TextAlign = "MiddleLeft"
#		$lblDeployMinimumCreateDate.Anchor = "Top,Right"
#	    $pnlContentPanel6.Controls.Add($lblDeployMinimumCreateDate)
#	
#		# Create the Deploy Minimum Create Date date/time picker
#		LogWrite "INFO" "Add the Deploy Minimum Create Date/Time Box"
#		If (!($dtDeployMinimumImagedDate)) {$script:dtDeployMinimumImagedDate = New-Object System.Windows.Forms.DateTimePicker}
#		$dtDeployMinimumImagedDate.Width = $intPanel6ContentDataWidth
#		$dtDeployMinimumImagedDate.Height = $intPanel6ContentDataHeight
#	    $dtDeployMinimumImagedDate.Left = $lblDeployMinimumCreateDate.Right
#		$dtDeployMinimumImagedDate.Top = $lblDeployMinimumCreateDate.Top - 5
#		# Set the MinDate and MaxDate.
#		$dtDeployMinimumImagedDate.Format = [Windows.Forms.DateTimePickerFormat]::Short
#		$dtDeployMinimumImagedDate.MinDate = "8/1/2015"
#		$dtDeployMinimumImagedDate.MaxDate = (Get-Date).AddDays(1) # Nothing later than tomorrow
#		$dtDeployMinimumImagedDate.Value = $dtDefaultEarliestImagingCompletionDate
#		# Hide the CheckBox and Don't display the control as an up-down control.
#		$dtDeployMinimumImagedDate.ShowCheckBox = $false
#		$dtDeployMinimumImagedDate.ShowUpDown = $false
#		$dtDeployMinimumImagedDate.Font = New-Object System.Drawing.Font("Arial",12)
#		$dtDeployMinimumImagedDate.Enabled = $true
#		$dtDeployMinimumImagedDate.Anchor = "Top,Right"
#		$pnlContentPanel6.Controls.Add($dtDeployMinimumImagedDate)
		
		
		# Create the Enforce Device/PO/Location Checking label
		LogWrite "INFO" "Add the Enforce Device/PO/Location Label"
		If (!($lblEnforceDevicePOLocation)) {$script:lblEnforceDevicePOLocation = New-Object System.Windows.Forms.Label}
	    $lblEnforceDevicePOLocation.Width = $intPanel6ContentLabelWidth
		$lblEnforceDevicePOLocation.Height = $intPanel6ContentLabelHeight
	    $lblEnforceDevicePOLocation.Left = $lblDeployMinimumCreateDate.Left
		$lblEnforceDevicePOLocation.Top = $lblDeployMinimumCreateDate.Bottom + 30
		$lblEnforceDevicePOLocation.Font = New-Object System.Drawing.Font("Arial",12)
	    $lblEnforceDevicePOLocation.Text = "Enforce Device/PO/Location Associations"
		$lblEnforceDevicePOLocation.Cursor = "Arrow"
		$lblEnforceDevicePOLocation.TextAlign = "MiddleLeft"
		$lblEnforceDevicePOLocation.Anchor = "Top,Right"
	    $pnlContentPanel6.Controls.Add($lblEnforceDevicePOLocation)
	
		# Create the Device/PO/Location combo box
		LogWrite "INFO" "Add the Enforce Device/PO/Location Combo Box"
		If (!($cboEnforceDevicePOLocation)) {$script:cboEnforceDevicePOLocation = New-Object System.Windows.Forms.ComboBox}
		$cboEnforceDevicePOLocation.Width = $intPanel6ContentDataWidth
		$cboEnforceDevicePOLocation.Height = $intPanel6ContentDataHeight
	    $cboEnforceDevicePOLocation.Left = $lblEnforceDevicePOLocation.Right
		$cboEnforceDevicePOLocation.Top = $lblEnforceDevicePOLocation.Top - 5
		$cboEnforceDevicePOLocation.Font = New-Object System.Drawing.Font("Arial",12)
		$cboEnforceDevicePOLocation.Items.Add("Device to Any Location") | Out-Null
		$cboEnforceDevicePOLocation.Items.Add("Device to Assigned Location") | Out-Null
		$cboEnforceDevicePOLocation.Items.Add("Device to Assigned PO/Location") | Out-Null
		$cboEnforceDevicePOLocation.SelectedItem = "Device to Assigned PO/Location"
		$cboEnforceDevicePOLocation.Anchor = "Top,Right"
		$pnlContentPanel6.Controls.Add($cboEnforceDevicePOLocation)
		
	
		
		# Create the Save Settings Button
		LogWrite "INFO" "Add the Save Settings Button"
		If (!($btnSaveSettings)) {$script:btnSaveSettings = New-Object System.Windows.Forms.Button}
		$btnSaveSettings.Width = 150
		$btnSaveSettings.Height = 30
		$btnSaveSettings.Left = ($pnlContentPanel6.Width / 2) - $btnSaveSettings.Width - 15
		$btnSaveSettings.Top = $pnlContentPanel6.Height - 15 - $btnSaveSettings.Height
		$btnSaveSettings.Cursor = "Hand"
		$btnSaveSettings.FlatStyle = "Flat"
		$btnSaveSettings.Font = New-Object System.Drawing.Font("Arial",10)
		$btnSaveSettings.ForeColor = "Black"
		$btnSaveSettings.BackColor = "LightGray"
		$btnSaveSettings.Text = "Save Settings"
		$btnSaveSettings.Visible = $true
		$btnSaveSettings.Anchor = "Top,Right"
		$btnSaveSettings.Add_Click({
					SaveSettings
			})
		$pnlContentPanel6.Controls.Add($btnSaveSettings)
		
		
		# Create the Reload Settings Button
		LogWrite "INFO" "Add the Reload Settings Button"
		If (!($btnReloadSettings)) {$script:btnReloadSettings = New-Object System.Windows.Forms.Button}
		$btnReloadSettings.Width = 150
		$btnReloadSettings.Height = 30
		$btnReloadSettings.Left = ($pnlContentPanel6.Width / 2) + 15
		$btnReloadSettings.Top = $btnSaveSettings.Top
		$btnReloadSettings.Cursor = "Hand"
		$btnReloadSettings.FlatStyle = "Flat"
		$btnReloadSettings.Font = New-Object System.Drawing.Font("Arial",10)
		$btnReloadSettings.ForeColor = "Black"
		$btnReloadSettings.BackColor = "LightGray"
		$btnReloadSettings.Text = "Reload Settings"
		$btnReloadSettings.Visible = $true
		$btnReloadSettings.Anchor = "Top,Right"
		$btnReloadSettings.Add_Click({
					ReloadSettings
			})
		$pnlContentPanel6.Controls.Add($btnReloadSettings)
	
		# Reload the settings from the Registry and then Save settings to be sure everything has been saved
		ReloadSettings
		SaveSettings
	
	}
	

Function ShowRenumberNodesForm ($strModelName)#, $objxLightsEffects)
	{
		LogWrite "INFO" "Show the Renumber Nodes Form"
	
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
						$intFromNode.Focus()
						write-host "- + $($objxLightsEffects.xrgb.models.model | measure | select -expandproperty count)"
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
	
#		# Create the Tag to Unprocess text box
#		If (!($txtStartNode)) {$script:txtStartNode = New-Object System.Windows.Forms.TextBox}
#		$txtStartNode.Left = $lblDescription.Left + 10
#		$txtStartNode.Top = $lblDescription.Bottom + 10
#		$txtStartNode.Width = 200
#		$txtStartNode.Height = 30
#		$txtStartNode.Font = New-Object System.Drawing.Font("Arial",10)
#		$txtStartNode.Text = ""
#		$txtStartNode.Anchor = "Top,Left"
#		$frmRenumberNodes.Controls.Add($txtStartNode)

		# Add description label
		If (!($lblFromNode)) 
			{
				$script:lblFromNode = New-Object System.Windows.Forms.Label
				$lblFromNode.Left = $lblDescription.Left + 10
				$lblFromNode.Top = $lblDescription.Bottom + 20
				$lblFromNode.Width = 100
				$lblFromNode.Height = 20
				$lblFromNode.TextAlign = "MiddleLeft"
				$lblFromNode.Text = "From Node: "
				$lblFromNode.ForeColor = "Black"
				$lblFromNode.Font = New-Object System.Drawing.Font("Arial",10)
				$lblFromNode.Anchor = "Top,Left,Right"
				$frmRenumberNodes.Controls.Add($lblFromNode)
			}
		
		# Create the Reclaim Tag Number Maximum Length text box
		If (!($intFromNode)) 
			{
				$script:intFromNode = New-Object System.Windows.Forms.NumericUpDown
				$intFromNode.Width = 75
				$intFromNode.Height = 20
			    $intFromNode.Left = $lblFromNode.Right + 10
				$intFromNode.Top = $lblFromNode.Top
				$intFromNode.Font = New-Object System.Drawing.Font("Arial",10)
				$intFromNode.Minimum = "1"
				$intFromNode.Maximum = "9999"
				$intFromNode.Value = 1
				$intFromNode.Anchor = "Top,Right"
				$frmRenumberNodes.Controls.Add($intFromNode)
			}

		# Add description label
		If (!($lblToNode)) 
			{
				$script:lblToNode = New-Object System.Windows.Forms.Label
				$lblToNode.Left = $intFromNode.Right + 10
				$lblToNode.Top = $lblFromNode.Top
				$lblToNode.Width = 50
				$lblToNode.Height = $lblFromNode.Height
				$lblToNode.TextAlign = "MiddleCenter"
				$lblToNode.Text = "to: "
				$lblToNode.ForeColor = "Black"
				$lblToNode.Font = New-Object System.Drawing.Font("Arial",10)
				$lblToNode.Anchor = "Top,Left,Right"
				$frmRenumberNodes.Controls.Add($lblToNode)
			}
	
		# Create the Reclaim Tag Number Maximum Length text box
		If (!($intEndNode)) 
			{
				$script:intEndNode = New-Object System.Windows.Forms.NumericUpDown
				$intEndNode.Width = $intFromNode.Width
				$intEndNode.Height = $intFromNode.Height
			    $intEndNode.Left = $lblToNode.Right + 10
				$intEndNode.Top = $intFromNode.Top
				$intEndNode.Font = New-Object System.Drawing.Font("Arial",10)
				$intEndNode.Minimum = "1"
				$intEndNode.Maximum = "9999"
				$intEndNode.Value = 1
				$intEndNode.Anchor = "Top,Right"
				$frmRenumberNodes.Controls.Add($intEndNode)	
			}
	
		# Add description label
		If (!($lblIncrementBy)) 
			{
				$script:lblIncrementBy = New-Object System.Windows.Forms.Label
				$lblIncrementBy.Left = $lblFromNode.Left
				$lblIncrementBy.Top = $lblFromNode.Bottom + 20
				$lblIncrementBy.Width = $lblFromNode.Width
				$lblIncrementBy.Height = $lblFromNode.Height
				$lblIncrementBy.TextAlign = "MiddleLeft"
				$lblIncrementBy.Text = "Increment By: "
				$lblIncrementBy.ForeColor = "Black"
				$lblIncrementBy.Font = New-Object System.Drawing.Font("Arial",10)
				$lblIncrementBy.Anchor = "Top,Left,Right"
				$frmRenumberNodes.Controls.Add($lblIncrementBy)
			}
		
		# Create the Reclaim Tag Number Maximum Length text box
		If (!($intIncrementBy)) 
			{
				$script:intIncrementBy = New-Object System.Windows.Forms.NumericUpDown
				$intIncrementBy.Width = $intFromNode.Width
				$intIncrementBy.Height = $intFromNode.Height
			    $intIncrementBy.Left = $intFromNode.Left
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
				$lblUnprocessWarning.Left = $lblFromNode.Left
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
						$objModel = $objxLightsEffects.xrgb.models.model | where {$_.Name -eq "$strModelName"}
						$strCustomModel = $objModel.CustomModel
						
						# Define the integer string (stored as a string value) to be used as a replacement for the line break semicolon
						$strLineBreakReplacement = "999999"
						
						# Replace the semicolon (line breaks) with 999999 and split the array leaving only empty space and integers
						[array]$arrToUpdate = (($strCustomModel-replace ";",$strLineBreakReplacement) -split "\D")
						
						# Read the variables from the from
						$intFirstNodeToModify = 10 #$intStartNode.Text
						$intLastNodeToModify = 65 #$intEndNode.Text
						$intIncrementNodesBy = 1 #$intIncrementBy.Text
						
						# Declare a new array to store the updates in
						[array]$arrUpdatedModel = @()
						
						# Iterate through the array.  If a number in the range, increment by the variable and add it to the array.  If a number outside of the range, the Line Break replacement, or a string, just add into the array.
						$arrToUpdate | ForEach {
						
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
				LogWrite "INFO" "A Valid Show Folder Was Selected ($strFolderPath)"
				
				$lblSubHeader.Text = $strFolderPath
				$lblSubHeader.ForeColor = "Blue"
				$script:strxLightsRGBEffectsFilePath = "$strFolderPath\$strxLightsRGBEffectsFileName"
				$script:strxLightsNetworksFilePath = "$strFolderPath\$strxLightsNetworksFileName"

				$btnNavigationButton2.Visible = $true
				$btnNavigationButton6.Visible = $true
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

	}
	
	
Function BackupxLightsFiles
	{
		LogWrite "INFO" "Backup the xLights Files"
	
		# Make a backup of the RGBEffects Files before even touching them
		$strxLightsRGBEffectsFileBackupPath = $strxlightsRGBEffectsFilePath -replace ".xml",$strFileBackupSuffix
		Copy-Item -Path $strxlightsRGBEffectsFilePath -Destination $strxLightsRGBEffectsFileBackupPath -Force
			
		# Report the status of the backup
		If ((Get-FileHash $strxlightsRGBEffectsFilePath).Hash -eq (Get-FileHash $strxLightsRGBEffectsFileBackupPath).Hash)
			{LogWrite "INFO" "xLights_RGBEffects File Successfully backed up to ""$strxLightsRGBEffectsFileBackupPath""" -ForegroundColor Green}
			Else {LogWrite "WARNING" "xLights_RGBEffects File was NOT successfully backed up"}
	}
	

# Load the RBG Effects file into memory
Function LoadRGBEffects
	{
		LogWrite "INFO" "Load RGBEffects File"
		
		BackupxLightsFiles
	
		# Read the RGBEffects File into Memory
		[xml]$global:objxLightsEffects = Get-Content $strxlightsRGBEffectsFilePath
	}


# Populate the models into the list box
Function PopulateModels
	{
		# If there are existing models, prompt to clear them
		If ($intAllModelsCount -gt 0)
			{
				$boolRefreshAllModels = [System.Windows.Forms.MessageBox]::Show("The list of models already exists.  Do you want to clear the list and reload from xLights? `n`nNote that this will clear the Selected Models list as well.","Reload Models" , "YesNo", "Exclamation")
					
				# Check to see if a Proceed flag has been set
				If ($boolRefreshAllModels -eq "Yes")
					{
						$lbxAllModels.BeginUpdate()
							$lbxAllModels.Items.Clear()
						$lbxAllModels.EndUpdate()
						
						$lbxSelectedModels.BeginUpdate()
							$lbxSelectedModels.Items.Clear()
						$lbxSelectedModels.EndUpdate()
						
						$script:intAllModelsCount = $null
						
					}
			}
		
		# If the model list is empty, populate it
		If ($intAllModelsCount -eq $null)
			{
				LoadRGBEffects
				
				$lbxAllModels.BeginUpdate()
					ForEach ($objModel in $objxLightsEffects.xrgb.models.ChildNodes) {$lbxAllModels.Items.Add($objModel.Name)}
				$lbxAllModels.EndUpdate()
				
				$script:intAllModelsCount = $lbxAllModels.Count
			}
	}

	
# Move models between the list boxes
Function ModifySelectedModels ($strAddRemove, $strModelName)
	{
		If ($strModelName)
			{
				If ($strAddRemove -eq "ADD")
					{
						$lbxAllModels.BeginUpdate()
						$lbxSelectedModels.BeginUpdate()
						
						$lbxSelectedModels.Items.Add($strModelName)
						$lbxAllModels.Items.Remove($strModelName)
					
						$lbxAllModels.EndUpdate()
						$lbxSelectedModels.EndUpdate()
					}
					ElseIf ($strAddRemove -eq "REMOVE")
						{
							$lbxAllModels.BeginUpdate()
							$lbxSelectedModels.BeginUpdate()
						
							$lbxAllModels.Items.Add($strModelName)
							$lbxSelectedModels.Items.Remove($strModelName)
							
							$lbxAllModels.EndUpdate()
							$lbxSelectedModels.EndUpdate()
							
							# Clear the desciption labels
							$lblDescriptionLabel1.Text = ""
							$lblDescriptionLabel2.Text = ""
							$lblDescriptionLabel3.Text = ""
							$lblDescriptionLabel4.Text = ""
							
							# Hide unnecessary elements
							$btnRenumberNodes.Visible = $false
						}
						Else
							{
								LogWrite "WARNING" "Modify Selected Models called with invalid parameter ($strAddRemove)"
							}
			}
	
	}


# Create the Models panel
Function LoadModels
	{
		# Add the list boxes and buttons to manage model work
		
		If (!($lblAllModels)) 
			{
				$global:lblAllModels = New-Object System.Windows.Forms.Label
				$lblAllModels.Width = $pnlContentPanel2.Width * .07
				$lblAllModels.Height = 20
				$lblAllModels.Left = 10
				$lblAllModels.Top = 3
				$lblAllModels.TextAlign = "MiddleLeft"
				$lblAllModels.ForeColor = "Black"
				$lblAllModels.Backcolor = "Transparent"
				$lblAllModels.Text = "All Models"
				$lblAllModels.Anchor = "Left,Right,Top"
		#		$lblAllModels.Cursor = "Hand"
		#		$lblAllModels.Add_Click({
		#							})
				$pnlContentPanel2.Controls.Add($lblAllModels)
			}
		
		If (!($lbxAllModels)) 
			{
				$script:lbxAllModels = New-Object System.Windows.Forms.ListBox
				$lbxAllModels.Left = $lblAllModels.Left
				$lbxAllModels.Top = $lblAllModels.Bottom + 5
				$lbxAllModels.Width = $pnlContentPanel2.Width * .2
				$lbxAllModels.Height = $pnlContentPanel6.Height * .2
				$lbxAllModels.SelectionMode = "MultiExtended"
				$lbxAllModels.Sorted = $true
				$lbxAllModels.Visible = $true
				$lbxAllModels.Add_DoubleClick({
						
						# If no filter is applied, modify the list
						If ($txtFilterSelectedModels.Text -eq $strDefaultFilterText)
							{
								ModifySelectedModels "ADD" $lbxAllModels.SelectedItem
							}
						
					})
				$pnlContentPanel2.Controls.Add($lbxAllModels)
			}
	
		If (!($lblSelectedModels)) 
			{
				$global:lblSelectedModels = New-Object System.Windows.Forms.Label
				$lblSelectedModels.Width = $lblAllModels.Width
				$lblSelectedModels.Height = $lblAllModels.Height
				$lblSelectedModels.Left = $lbxAllModels.Right + 100
				$lblSelectedModels.Top = $lblAllModels.Top
				$lblSelectedModels.TextAlign = "MiddleLeft"
				$lblSelectedModels.ForeColor = "Black"
				$lblSelectedModels.Backcolor = "Transparent"
				$lblSelectedModels.Text = "Selected Models"
				$lblSelectedModels.Anchor = "Left,Right,Top"
		#		$lblSelectedModels.Cursor = "Hand"
		#		$lblSelectedModels.Add_Click({
		#							})
				$pnlContentPanel2.Controls.Add($lblSelectedModels)
			}
			
		If (!($lbxSelectedModels)) 
			{
				$script:lbxSelectedModels = New-Object System.Windows.Forms.ListBox
				$lbxSelectedModels.Left = $lblSelectedModels.Left
				$lbxSelectedModels.Top = $lbxAllModels.Top
				$lbxSelectedModels.Width = $lbxAllModels.Width
				$lbxSelectedModels.Height = $lbxAllModels.Height
				$lbxSelectedModels.SelectionMode = "MultiExtended"
				$lbxSelectedModels.Sorted = $true
				$lbxSelectedModels.Visible = $true
				$lbxSelectedModels.Add_Click({
				
							If ($lbxSelectedModels.SelectedItem)
								{
									$btnRenumberNodes.Visible = $true
							
									$objSelectedModel = $objxLightsEffects.xrgb.ChildNodes.Model | where {$_.Name -eq $lbxSelectedModels.SelectedItem}
									
									If ($objSelectedModel.Active -eq 0) {$strModelActive = $false} Else {$strModelActive = $true}
									If ($objSelectedModel.ControllerConnection.Brightness) {$strModelBrightness = $objSelectedModel.ControllerConnection.Brightness} Else {$strModelBrightness = 100}
									If ($objSelectedModel.PixelCount)
										{$intModelNodeCount = $objSelectedModel.PixelCount}
										ElseIf ($objSelectedModel.CustomModel)
											{
												$intModelNodeCount = $objSelectedModel.CustomModel -split {$_ -eq "," -or $_ -eq ";"} | Measure -Maximum | Select-Object -ExpandProperty Maximum
											}
											Else
												{
													$intModelNodeCount = ([int]$objSelectedModel.parm1 * [int]$objSelectedModel.parm2)
												}
									
									$lblDescriptionLabel1.Text = "Brightness: $strModelBrightness"
									$lblDescriptionLabel2.Text = "Active: $strModelActive"
									$lblDescriptionLabel3.Text = "Model Node Count: $intModelNodeCount"
									
									$lblDescriptionLabel1.ForeColor = $(If ($strModelBrightness -le 20) {"Blue"} ElseIf ($strModelBrightness -le 30) {"Green"} ElseIf ($strModelBrightness -le 60) {"Yellow"} Else {"Red"})
									$lblDescriptionLabel2.ForeColor = $(If ($strModelActive) {"Green"} Else {"Gray"})
									
								}
						})
				$lbxSelectedModels.Add_DoubleClick({
				
						# If no filter is applied, modify the list
						If ($txtFilterAllModels.Text -eq $strDefaultFilterText)
							{
								ModifySelectedModels "REMOVE" $lbxSelectedModels.SelectedItem
							}
						
				})
				$pnlContentPanel2.Controls.Add($lbxSelectedModels)
			}
		
		
		$script:strDefaultFilterText = "Filter..."
		
		# Populuate the list box
		PopulateModels
		
		
		# Create the filter fields
		
		# Filter All Models
		If (!($txtFilterAllModels)) 
			{
				$script:txtFilterAllModels = New-Object System.Windows.Forms.TextBox
				$txtFilterAllModels.Left = $lblAllModels.Right
				$txtFilterAllModels.Top = $lblAllModels.Top
				$txtFilterAllModels.Width = $lbxAllModels.Width - $lblAllModels.Width
				$txtFilterAllModels.Height = 30
				$txtFilterAllModels.Font = New-Object System.Drawing.Font("Arial",10)
				$txtFilterAllModels.ForeColor = "Gray"
				$txtFilterAllModels.BackColor = "LightGray"
				$txtFilterAllModels.Text = $strDefaultFilterText
				$txtFilterAllModels.Anchor = "Top,Left"
				$pnlContentPanel2.Controls.Add($txtFilterAllModels)
				
				# Add Enter Event
				$txtFilterAllModels.Add_Enter({
						If ($txtFilterAllModels.Text -eq $strDefaultFilterText)
							{
								$txtFilterAllModels.Text = ""
							}
						$txtFilterAllModels.SelectAll()
						$txtFilterAllModels.ForeColor = "Black"
						$txtFilterAllModels.BackColor = "White"
						
						If (!($arrCurrentListOfActiveModels)) {[array]$script:arrCurrentListOfActiveModels = $lbxAllModels.Items}
					})
					
				# Add Leave Event
				$txtFilterAllModels.Add_Leave({
						If ($txtFilterAllModels.Text -eq "") 
							{
								$txtFilterAllModels.Text = $strDefaultFilterText
							}
							$txtFilterAllModels.ForeColor = "Gray"
							$txtFilterAllModels.BackColor = "LightGray"
					})
					
				# Add KeyUp Event
				$txtFilterAllModels.Add_KeyUp({
						
						If ($txtFilterAllModels.Right -eq $btnResetFilterAllModels.Right) {$txtFilterAllModels.Width = $txtFilterAllModels.Width - $btnResetFilterAllModels.Width - 2}
						$btnMoveAllModelsLeft.Enabled = $false
						$btnMoveModelLeft.Enabled = $false
				
						$lbxAllModels.BeginUpdate()
							$lbxAllModels.Items.Clear()
							$arrCurrentListOfActiveModels | Where {$_ -like "*$($txtFilterAllModels.Text)*"} | ForEach {If ($_) {$lbxAllModels.Items.Add($_)}}
						$lbxAllModels.EndUpdate()
						
						# Clear the desciption labels
						$lblDescriptionLabel1.Text = ""
						$lblDescriptionLabel2.Text = ""
						$lblDescriptionLabel3.Text = ""
						$lblDescriptionLabel4.Text = ""
						
						# Hide unnecessary elements
						$btnRenumberNodes.Visible = $false
					})
			}
		
		If (!($btnResetFilterAllModels)) 
			{
				$script:btnResetFilterAllModels = New-Object Windows.Forms.Button
				$btnResetFilterAllModels.Width = 20
				$btnResetFilterAllModels.Height = 25
				$btnResetFilterAllModels.Left = $lbxAllModels.Right - $btnResetFilterAllModels.Width
				$btnResetFilterAllModels.Top = $lblAllModels.Top - 1
				$btnResetFilterAllModels.Text = "X"
				$btnResetFilterAllModels.TextAlign = "MiddleCenter"
				$btnResetFilterAllModels.Cursor = "Hand"
				$btnResetFilterAllModels.ForeColor = "Black"
				$btnResetFilterAllModels.BackColor = "WhiteSmoke"
				$btnResetFilterAllModels.Anchor = "Top,Right"
				$btnResetFilterAllModels.Add_Click({
						
						# Reset the filter box
						$txtFilterAllModels.Text = $strDefaultFilterText
						$txtFilterAllModels.ForeColor = "Gray"
						$txtFilterAllModels.BackColor = "LightGray"
						
						# Clear the filter config
						$lbxAllModels.Items.Clear()
						$arrCurrentListOfActiveModels | ForEach {$lbxAllModels.Items.Add($_)}
						Remove-Variable -Name arrCurrentListOfActiveModels -Scope Script -Force -ErrorAction SilentlyContinue
						$txtFilterAllModels.Width = $txtFilterAllModels.Width + $btnResetFilterAllModels.Width + 2
						
						# Reset the listbox controls
						$btnMoveAllModelsLeft.Enabled = $true
						$btnMoveModelLeft.Enabled = $true
						
						# Resync the boxes
						[array]$lbxSelectedModels.Items | ForEach{$lbxAllModels.Items.Remove($_)}
					})
				$pnlContentPanel2.Controls.Add($btnResetFilterAllModels)
			}
		
		# Filter Selected Models
		If (!($txtFilterSelectedModels)) 
			{
				$script:txtFilterSelectedModels = New-Object System.Windows.Forms.TextBox
				$txtFilterSelectedModels.Left = $lblSelectedModels.Right
				$txtFilterSelectedModels.Top = $lblSelectedModels.Top
				$txtFilterSelectedModels.Width = $lbxSelectedModels.Width - $lblSelectedModels.Width
				$txtFilterSelectedModels.Height = 30
				$txtFilterSelectedModels.Font = New-Object System.Drawing.Font("Arial",10)
				$txtFilterSelectedModels.ForeColor = "Gray"
				$txtFilterSelectedModels.BackColor = "LightGray"
				$txtFilterSelectedModels.Text = $strDefaultFilterText
				$txtFilterSelectedModels.Anchor = "Top,Left"
				$pnlContentPanel2.Controls.Add($txtFilterSelectedModels)
				
				# Add Enter Event
				$txtFilterSelectedModels.Add_Enter({
				
						If ($txtFilterSelectedModels.Text -eq $strDefaultFilterText)
							{
								$txtFilterSelectedModels.Text = ""
							}
						$txtFilterSelectedModels.SelectAll()
						$txtFilterSelectedModels.ForeColor = "Black"
						$txtFilterSelectedModels.BackColor = "White"

						If (!($arrCurrentListOfSelectedModels)) {[array]$script:arrCurrentListOfSelectedModels = $lbxSelectedModels.Items}

					})
					
				# Add Leave Event
				$txtFilterSelectedModels.Add_Leave({
				
						If ($txtFilterSelectedModels.Text -eq "") 
							{
								$txtFilterSelectedModels.Text = $strDefaultFilterText
							}
							$txtFilterSelectedModels.ForeColor = "Gray"
							$txtFilterSelectedModels.BackColor = "LightGray"
					})
					
				# Add KeyUp Event
				$txtFilterSelectedModels.Add_KeyUp({
						
						If ($arrCurrentListOfSelectedModels.Length -gt 0)
							{
					
								If ($txtFilterSelectedModels.Right -eq $btnResetFilterSelectedModels.Right) {$txtFilterSelectedModels.Width = $txtFilterSelectedModels.Width - $btnResetFilterSelectedModels.Width - 2}
								$btnMoveAllModelsRight.Enabled = $false
								$btnMoveModelRight.Enabled = $false
						
								$lbxSelectedModels.BeginUpdate()
									$lbxSelectedModels.Items.Clear()
									$arrCurrentListOfSelectedModels | Where {$_ -like "*$($txtFilterSelectedModels.Text)*"} | ForEach {If ($_) {$lbxSelectedModels.Items.Add($_)}}
								$lbxSelectedModels.EndUpdate()
							}
					})
				
			}
		
		
		If (!($btnResetFilterSelectedModels)) 
			{
				$script:btnResetFilterSelectedModels = New-Object Windows.Forms.Button
				$btnResetFilterSelectedModels.Width = 20
				$btnResetFilterSelectedModels.Height = 25
				$btnResetFilterSelectedModels.Left = $txtFilterSelectedModels.Right - $btnResetFilterSelectedModels.Width
				$btnResetFilterSelectedModels.Top = $lblSelectedModels.Top - 1
				$btnResetFilterSelectedModels.Text = "X"
				$btnResetFilterSelectedModels.TextAlign = "MiddleCenter"
				$btnResetFilterSelectedModels.Cursor = "Hand"
				$btnResetFilterSelectedModels.ForeColor = "Black"
				$btnResetFilterSelectedModels.BackColor = "WhiteSmoke"
				$btnResetFilterSelectedModels.Anchor = "Top,Right"
				$btnResetFilterSelectedModels.Add_Click({
				
						# Reset the filter box
						$txtFilterSelectedModels.Text = $strDefaultFilterText
						$txtFilterSelectedModels.ForeColor = "Gray"
						$txtFilterSelectedModels.BackColor = "LightGray"
						
						# Clear the filter config
						$lbxSelectedModels.Items.Clear()
						$arrCurrentListOfSelectedModels | ForEach {$lbxSelectedModels.Items.Add($_)}
						Remove-Variable -Name arrCurrentListOfSelectedModels -Scope Script -ErrorAction SilentlyContinue
						
						$txtFilterSelectedModels.Width = $txtFilterSelectedModels.Width + $btnResetFilterSelectedModels.Width + 2
						
						# Reset the listbox controls
						$btnMoveAllModelsRight.Enabled = $true
						$btnMoveModelRight.Enabled = $true
						
						# Resync the boxes
						[array]$lbxAllModels.Items | ForEach {$lbxSelectedModels.Items.Remove($_)}
					})
				$pnlContentPanel2.Controls.Add($btnResetFilterSelectedModels)
			}
		
		
		# Create the movement buttons
		
		# Move all models right
		If (!($btnMoveAllModelsRight)) 
			{
				$script:btnMoveAllModelsRight = New-Object Windows.Forms.Button
				$btnMoveAllModelsRight.Left = $lbxAllModels.Right + 35
				$btnMoveAllModelsRight.Top = $lbxAllModels.Top + 5
				$btnMoveAllModelsRight.Text = ">>"
				$btnMoveAllModelsRight.Width = 30
				$btnMoveAllModelsRight.TextAlign = "MiddleCenter"
				$btnMoveAllModelsRight.Cursor = "Hand"
				$btnMoveAllModelsRight.ForeColor = "Black"
				$btnMoveAllModelsRight.BackColor = "WhiteSmoke"
				$btnMoveAllModelsRight.Anchor = "Top,Right"
				$btnMoveAllModelsRight.Add_Click({
				
						[array]$arrItemsToMoveRight = $lbxAllModels.Items

						ForEach ($objItemToMoveRight in $arrItemsToMoveRight)
							{
								#Write-Host "Move $objItemToMoveRight"
								ModifySelectedModels "ADD" $objItemToMoveRight
							}

						$lbxAllModels.ClearSelected()
						$lbxSelectedModels.ClearSelected()
				
						Remove-Variable objItemToMoveRight -ErrorAction SilentlyContinue
						Remove-Variable arrItemsToMoveRight -ErrorAction SilentlyContinue
					})
				$pnlContentPanel2.Controls.Add($btnMoveAllModelsRight)
			}
	
		# Move selected models right
		If (!($btnMoveModelRight)) 
			{
				$script:btnMoveModelRight = New-Object Windows.Forms.Button
				$btnMoveModelRight.Left = $lbxAllModels.Right + 35
				$btnMoveModelRight.Top = $btnMoveAllModelsRight.Bottom + 2 #($lbxAllModels.Bottom - $lbxAllModels.Top) * .2 + $lbxAllModels.Top
				$btnMoveModelRight.Text = ">"
				$btnMoveModelRight.Width = 30
				$btnMoveModelRight.TextAlign = "MiddleCenter"
				$btnMoveModelRight.Cursor = "Hand"
				$btnMoveModelRight.ForeColor = "Black"
				$btnMoveModelRight.BackColor = "WhiteSmoke"
				$btnMoveModelRight.Anchor = "Top,Left"
				$btnMoveModelRight.Add_Click({
				
						[array]$arrItemsToMoveRight = $lbxAllModels.SelectedItems

						ForEach ($objItemToMoveRight in $arrItemsToMoveRight)
							{
								ModifySelectedModels "ADD" $objItemToMoveRight
							}
						
						$lbxAllModels.ClearSelected()
						$lbxSelectedModels.ClearSelected()
				
						Remove-Variable objItemToMoveRight -ErrorAction SilentlyContinue
						Remove-Variable arrItemsToMoveRight -ErrorAction SilentlyContinue
					})
				$pnlContentPanel2.Controls.Add($btnMoveModelRight)
			}
	
		# Move all models left
		If (!($btnMoveAllModelsLeft)) 
			{
				$script:btnMoveAllModelsLeft = New-Object Windows.Forms.Button
				$btnMoveAllModelsLeft.Left = $lbxAllModels.Right + 35
				$btnMoveAllModelsLeft.Top = $lbxAllModels.Bottom - ($btnMoveAllModelsRight.Top - $lbxAllModels.Top) - $btnMoveAllModelsRight.Height
				$btnMoveAllModelsLeft.Text = "<<"
				$btnMoveAllModelsLeft.Width = 30
				$btnMoveAllModelsLeft.TextAlign = "MiddleCenter"
				$btnMoveAllModelsLeft.Cursor = "Hand"
				$btnMoveAllModelsLeft.ForeColor = "Black"
				$btnMoveAllModelsLeft.BackColor = "WhiteSmoke"
				$btnMoveAllModelsLeft.Anchor = "Top,Left"
				$btnMoveAllModelsLeft.Add_Click({
				
						[array]$arrItemsToMoveLeft = $lbxSelectedModels.Items

						ForEach ($objItemToMoveLeft in $arrItemsToMoveLeft)
							{
								ModifySelectedModels "REMOVE" $objItemToMoveLeft
							}

						$lbxAllModels.ClearSelected()
						$lbxSelectedModels.ClearSelected()
				
						Remove-Variable objItemToMoveLeft -ErrorAction SilentlyContinue
						Remove-Variable arrItemsToMoveLeft -ErrorAction SilentlyContinue
					})
				$pnlContentPanel2.Controls.Add($btnMoveAllModelsLeft)
			}
		
		# Move selected models left
		If (!($btnMoveModelLeft)) 
			{
				$script:btnMoveModelLeft = New-Object Windows.Forms.Button
				$btnMoveModelLeft.Left = $btnMoveModelRight.Left
				$btnMoveModelLeft.Top = $btnMoveAllModelsLeft.Top - $btnMoveModelLeft.Height - 2 #$lbxAllModels.Bottom - ($btnMoveModelRight.Top - $lbxAllModels.Top) - $btnMoveModelRight.Height
				$btnMoveModelLeft.Text = "<"
				$btnMoveModelLeft.Width = $btnMoveModelRight.Width
				$btnMoveModelLeft.TextAlign = "MiddleCenter"
				$btnMoveModelLeft.Cursor = "Hand"
				$btnMoveModelLeft.ForeColor = "Black"
				$btnMoveModelLeft.BackColor = "WhiteSmoke"
				$btnMoveModelLeft.Anchor = "Top,Left"
				$btnMoveModelLeft.Add_Click({

						[array]$arrItemsToMoveLeft = $lbxSelectedModels.SelectedItems

						ForEach ($objItemToMoveLeft in $arrItemsToMoveLeft)
							{
								ModifySelectedModels "REMOVE" $objItemToMoveLeft
							}
						
						$lbxAllModels.ClearSelected()
						$lbxSelectedModels.ClearSelected()
				
						Remove-Variable objItemToMoveLeft -ErrorAction SilentlyContinue
						Remove-Variable arrItemsToMoveLeft -ErrorAction SilentlyContinue
					})
				$pnlContentPanel2.Controls.Add($btnMoveModelLeft)
			}
		
		# Add Description Label 1
		If (!($lblDescriptionLabel1)) 
			{
				$global:lblDescriptionLabel1 = New-Object System.Windows.Forms.Label
				$lblDescriptionLabel1.Width = $pnlContentPanel2.Width - $lbxSelectedModels.Right - 20
				$lblDescriptionLabel1.Height = 20
				$lblDescriptionLabel1.Left = $lbxSelectedModels.Right + 10
				$lblDescriptionLabel1.Top = $lbxSelectedModels.Top
				$lblDescriptionLabel1.TextAlign = "MiddleLeft"
				$lblDescriptionLabel1.ForeColor = "Black"
				$lblDescriptionLabel1.Backcolor = "Transparent"
				$lblDescriptionLabel1.Text = ""
				$lblDescriptionLabel1.Anchor = "Left,Right,Top"
		#		$lblDescriptionLabel1.Cursor = "Hand"
		#		$lblDescriptionLabel1.Add_Click({
		#							})
				$pnlContentPanel2.Controls.Add($lblDescriptionLabel1)
			}
			
			
		# Add Description Label 2
		If (!($lblDescriptionLabel2)) 
			{
				$global:lblDescriptionLabel2 = New-Object System.Windows.Forms.Label
				$lblDescriptionLabel2.Width = $lblDescriptionLabel1.Width
				$lblDescriptionLabel2.Height = $lblDescriptionLabel1.Height
				$lblDescriptionLabel2.Left = $lblDescriptionLabel1.Left
				$lblDescriptionLabel2.Top = $lblDescriptionLabel1.Bottom + 5
				$lblDescriptionLabel2.TextAlign = "MiddleLeft"
				$lblDescriptionLabel2.ForeColor = "Black"
				$lblDescriptionLabel2.Backcolor = "Transparent"
				$lblDescriptionLabel2.Text = ""
				$lblDescriptionLabel2.Anchor = "Left,Right,Top"
		#		$lblDescriptionLabel2.Cursor = "Hand"
		#		$lblDescriptionLabel2.Add_Click({
		#							})
				$pnlContentPanel2.Controls.Add($lblDescriptionLabel2)
			}
			
			
		# Add Description Label 3
		If (!($lblDescriptionLabel3)) 
			{
				$global:lblDescriptionLabel3 = New-Object System.Windows.Forms.Label
				$lblDescriptionLabel3.Width = $lblDescriptionLabel1.Width
				$lblDescriptionLabel3.Height = $lblDescriptionLabel1.Height
				$lblDescriptionLabel3.Left = $lblDescriptionLabel1.Left
				$lblDescriptionLabel3.Top = $lblDescriptionLabel2.Bottom + 5
				$lblDescriptionLabel3.TextAlign = "MiddleLeft"
				$lblDescriptionLabel3.ForeColor = "Black"
				$lblDescriptionLabel3.Backcolor = "Transparent"
				$lblDescriptionLabel3.Text = ""
				$lblDescriptionLabel3.Anchor = "Left,Right,Top"
		#		$lblDescriptionLabel3.Cursor = "Hand"
		#		$lblDescriptionLabel3.Add_Click({
		#							})
				$pnlContentPanel2.Controls.Add($lblDescriptionLabel3)
			}	
			
		
		# Add Description Label 4
		If (!($lblDescriptionLabel4)) 
			{
				$global:lblDescriptionLabel4 = New-Object System.Windows.Forms.Label
				$lblDescriptionLabel4.Width = $lblDescriptionLabel1.Width
				$lblDescriptionLabel4.Height = $lblDescriptionLabel1.Height
				$lblDescriptionLabel4.Left = $lblDescriptionLabel1.Left
				$lblDescriptionLabel4.Top = $lblDescriptionLabel3.Bottom + 5
				$lblDescriptionLabel4.TextAlign = "MiddleLeft"
				$lblDescriptionLabel4.ForeColor = "Black"
				$lblDescriptionLabel4.Backcolor = "Transparent"
				$lblDescriptionLabel4.Text = ""
				$lblDescriptionLabel4.Anchor = "Left,Right,Top"
		#		$lblDescriptionLabel4.Cursor = "Hand"
		#		$lblDescriptionLabel4.Add_Click({
		#							})
				$pnlContentPanel2.Controls.Add($lblDescriptionLabel4)
			}	


		
		# Create the Renumber Nodes button
		If (!($btnRenumberNodes)) 
			{
				$script:btnRenumberNodes = New-Object Windows.Forms.Button
				$btnRenumberNodes.Left = $lbxSelectedModels.Left
				$btnRenumberNodes.Top = $lbxSelectedModels.Bottom + 5
				$btnRenumberNodes.Text = "Renumber Nodes"
				$btnRenumberNodes.Width = 150
				$btnRenumberNodes.TextAlign = "MiddleCenter"
				$btnRenumberNodes.Cursor = "Hand"
				$btnRenumberNodes.ForeColor = "Black"
				$btnRenumberNodes.BackColor = "WhiteSmoke"
				$btnRenumberNodes.Visible = $false
				$btnRenumberNodes.Anchor = "Top,Left"
				$btnRenumberNodes.Add_Click({
				
						If ($lbxSelectedModels.SelectedItems.Count -eq 1)
							{
								ShowRenumberNodesForm $lbxSelectedModels.SelectedItem #$objxLightsEffects
							}
							ElseIf ($lbxSelectedModels.SelectedItems.Count -gt 1)
								{
									[System.Windows.Forms.MessageBox]::Show("Only a single model can be modified at a time. `n`nPlease try again","More than one model was selected" , "OK", "Exclamation")
								}
								Else
									{
										[System.Windows.Forms.MessageBox]::Show("No model selected. `n`nPlease try again","No model selected" , "OK", "Exclamation")
									}
							
								
					})
				$pnlContentPanel2.Controls.Add($btnRenumberNodes)
			}
		
	
	}
	


	
Function ListModelDetails ($boolActiveInactiveBoth)
	{
		LogWrite "INFO" "List Model Details"
		
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
							$intModelNodeCount = $objChildNode.CustomModel -split {$_ -eq "," -or $_ -eq ";"} | Measure -Maximum | Select-Object -ExpandProperty Maximum
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