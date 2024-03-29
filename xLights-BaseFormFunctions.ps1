# Created By: Kevin Saucier
# Last Modified Date: 2021-09-24
#
# This script contains the logic for creating the base form used for scripts that need a GUI

Write-Host "[$(Get-Date -Format G)] Initializing Forms..."

##################################################
# Variables
##################################################




##############################################################
# Main script starts here.  No changes should be necessary.
##############################################################

# ------------------------------------------------
# Include Script Files
# ------------------------------------------------



# ------------------------------------------------
# Declare Drawing Requirements
# ------------------------------------------------
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") | Out-Null
[System.Windows.Forms.Application]::EnableVisualStyles() | Out-Null
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null



##############################################################
# Functions
##############################################################

# Clear all checkboxes/buttons and select the right one
Function SetCheckBoxes ($objNavigationButtonName) {
		Try {
				# Uncheck all the buttons
				If ($btnNavigationButton1) {$btnNavigationButton1.Checked = $false}
				If ($btnNavigationButton2) {$btnNavigationButton2.Checked = $false}
				If ($btnNavigationButton3) {$btnNavigationButton3.Checked = $false}
				If ($btnNavigationButton4) {$btnNavigationButton4.Checked = $false}
				If ($btnNavigationButton5) {$btnNavigationButton5.Checked = $false}
				If ($btnNavigationButton6) {$btnNavigationButton6.Checked = $false}
				
				# Check the correct button
				$objNavigationButtonName.Checked = $true
			} Catch {}
	}



# ------------------------------------------------
# Draw the main form and get it ready to run
# ------------------------------------------------
Function DrawBaseForm($boolShowControlBox)
	{
		If ($boolShowControlBox -ne $true) {$boolShowControlBox = $false}
	
		# Calculate if we need to adust the default form size

		# Get the current resolution
		$intPrimaryResolutionWidth = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Width
		$intPrimaryResolutionHeight = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Height


		# If the default form size is smaller than the form minimums, increase the default to match the minimums
		If ($intDefaultFormWidth -lt $intFormMinimumWidth) {$global:intDefaultFormWidth = $intFormMinimumWidth}
		If ($intDefaultFormHeight -lt $intFormMinimumHeight) {$global:intDefaultFormHeight = $intFormMinimumHeight}

		# Make sure the resolution supports the form size defaults.  If not, drop the form size to 75% of the supported resolution.
		If ($($intPrimaryResolutionWidth * .95) -ge $intDefaultFormWidth -and $($intPrimaryResolutionHeight * .95) -ge $intDefaultFormHeight)
			{ 
				LogWrite "INFO" "$intPrimaryResolutionWidth x $intPrimaryResolutionHeight is capable of supporting the form size defaults ($intDefaultFormWidth x $intDefaultFormHeight)"
				$global:intCurrentFormClientWidth = $intDefaultFormWidth
				$global:intCurrentFormClientHeight = $intDefaultFormHeight
			}
			Else
				{ 
					$global:intCurrentFormClientWidth = $intPrimaryResolutionWidth * .97
					$global:intCurrentFormClientHeight = $intPrimaryResolutionHeight * .9
					LogWrite "INFO" "$intPrimaryResolutionWidth x $intPrimaryResolutionHeight cannot support the defaults ($intDefaultFormWidth x $intDefaultFormHeight) so resizing to $([Math]::Round($intCurrentFormClientWidth)) x $([Math]::Round($intCurrentFormClientHeight))"
				}



		# Draw the base form
		$global:objForm = New-Object System.Windows.Forms.Form
		$objForm.BackColor = If ($PSScriptRoot -like "*\- Development*") {"Red"} Else {"Blue"}
		$objForm.Text = $strFormTitle
		$objForm.DataBindings.DefaultDataSourceUpdateMode = 0
		$objForm.ClientSize = New-Object System.Drawing.Size($intCurrentFormClientWidth,$intCurrentFormClientHeight)
		$objForm.MinimumSize = New-Object System.Drawing.Size($intFormMinimumWidth,$intFormMinimumHeight)
		$objForm.StartPosition = "CenterScreen" # CenterScreen, Manual, WindowsDefaultLocation, WindowsDefaultBounds, CenterParent
		$objForm.ControlBox = $boolShowControlBox # Show/hide the Min/Max/X buttons in the rop right corner of the window. If this is $false, the Minimize and Maximize buttons will be hidden, regardless of the settings below
		$objForm.MinimizeBox = $false
		$objForm.MaximizeBox = $false
		#$objForm.AutoScaleMode = [System.Windows.Forms.AutoScaleMode]::DPI
		$objform.FormBorderStyle = "Fixed3D" # None, Fixed3D, FixedSingle
		$objForm.Topmost = $false  
		$objIcon = [system.drawing.icon]::ExtractAssociatedIcon($strFormIconPath)
		$objForm.Icon = $objIcon
		$objForm.KeyPreview = $true
		$objForm.Add_Load({
			})
		$objForm.Add_Shown({
				# Set what should happen the first time the form is shown
				$objForm.Activate()
			})
		$objForm.Add_Closed({

				LogWrite "INFO" "Attempt to stop any sound being played...."

				# Try to Stop the sound, if it exists
				If ($objSoundToPlay) {StopSound}
			})
		$objForm.Add_Resize({
		
			})
	}
	

# ------------------------------------------------
# Bring objForm to the foreground
# ------------------------------------------------
Function ShowObjForm()
	{
		If ($objForm)
			{
				$objForm.Topmost = $true
				$objForm.Topmost = $false
				$objForm.Activate()
			}
	}


# ------------------------------------------------
# Draw the main panels
# ------------------------------------------------
Function DrawBasePanels()
	{
		# Create the main panels

		# Header Panel
		If (!($pnlHeader)) {$global:pnlHeader = New-Object System.Windows.Forms.Panel}
		$pnlHeader.Name = "HeaderPanel"
		$pnlHeader.Left = 3
		$pnlHeader.Top = 3
		If ($intCurrentFormClientHeight -lt 500)
			{ # Use a fixed height header
				$pnlHeader.Width = $intCurrentFormClientWidth - 6
				$pnlHeader.Height = 50
			}
			Else	
				{ # Use a percentage of the form size
					$pnlHeader.Width = $intCurrentFormClientWidth - 6
					$pnlHeader.Height = $intCurrentFormClientHeight * .116
				}
		$pnlHeader.BackColor = "White"
		$pnlHeader.Anchor = "Top,Left,Right"
		$objForm.Controls.Add($pnlHeader)


		# Footer Panel
		If (!($pnlFooter)) {$global:pnlFooter = New-Object System.Windows.Forms.Panel}
		$pnlFooter.Name = "FooterPanel"
		If ($intCurrentFormClientHeight -lt 500)
			{ # Use a fixed height footer
				$pnlFooter.Width = $intCurrentFormClientWidth - ($pnlHeader.Left * 2)
				$pnlFooter.Height = 40
			}
			Else
				{ # Use a percentage of the form size
					$pnlFooter.Width = $intCurrentFormClientWidth - ($pnlHeader.Left * 2)
					$pnlFooter.Height = ($intCurrentFormClientHeight * .083) - 3
				}
		$pnlFooter.Left = $pnlHeader.Left
		$pnlFooter.Top = $intCurrentFormClientHeight - 3 - $pnlFooter.Height
		$pnlFooter.BackColor = "Azure"
		$pnlFooter.Anchor = "Bottom,Left,Right"
		$objForm.Controls.Add($pnlFooter)
		
		# Footer Panel Header Line
		If (!($lblFooterHeaderLine)) {$global:lblFooterHeaderLine = New-Object System.Windows.Forms.Label}
		$lblFooterHeaderLine.Left = $pnlFooter.Left
		$lblFooterHeaderLine.Top = 0
		$lblFooterHeaderLine.Width = $pnlFooter.Width
		$lblFooterHeaderLine.Height = 1
		$lblFooterHeaderLine.Backcolor = "Gray"
		$lblFooterHeaderLine.Anchor = "Top,Left,Right"
		$pnlFooter.Controls.Add($lblFooterHeaderLine)


		# Navigation Panel
		$global:intTopOfFirstButton = 40
		If (!($pnlNavigation)) {$global:pnlNavigation = New-Object System.Windows.Forms.Panel}
		$pnlNavigation.Name = "NavigationPanel"
		$pnlNavigation.Left = 3
		$pnlNavigation.Top = $pnlHeader.Bottom
		If ($intCurrentFormClientWidth -gt 900)
			{ # Use a fixed width navigation bar
				$pnlNavigation.Width = 200
				$pnlNavigation.Height = $pnlFooter.Top - $pnlHeader.Bottom
			}
			Else
				{ # Use a percentage of the form size
					$pnlNavigation.Width = ($intCurrentFormClientWidth * .2) - 3
					$pnlNavigation.Height = $pnlFooter.Top - $pnlHeader.Bottom
				}
		$global:intBottomOfLastButton = $pnlNavigation.Height - 10
		$pnlNavigation.BackColor = "White"
		$pnlNavigation.Anchor = "Top,Left,Bottom"
		$objForm.Controls.Add($pnlNavigation)
		
		
		# Navigation Panel Header Line
		If (!($lblNavigationHeaderLine)) {$global:lblNavigationHeaderLine = New-Object System.Windows.Forms.Label}
		$lblNavigationHeaderLine.Left = 0
		$lblNavigationHeaderLine.Top = 0
		$lblNavigationHeaderLine.Width = $pnlNavigation.Width
		$lblNavigationHeaderLine.Height = 1
		$lblNavigationHeaderLine.Backcolor = "LightBlue"
		$lblNavigationHeaderLine.Anchor = "Top,Left,Right"
		$pnlNavigation.Controls.Add($lblNavigationHeaderLine)

		
		# Content Panel
		If (!($pnlContent)) {$global:pnlContent = New-Object System.Windows.Forms.Panel}
		$pnlContent.Name = "ContentPanel"
		$pnlContent.Left = $pnlNavigation.Right
		$pnlContent.Top = $pnlHeader.Bottom
		$pnlContent.Width = ($intCurrentFormClientWidth - $pnlNavigation.Right) - 3
		$pnlContent.Height = $pnlFooter.Top - $pnlHeader.Bottom
		$pnlContent.BackColor = "Azure"
		$pnlContent.Anchor = "Top,Left,Right,Bottom"
		$objForm.Controls.Add($pnlContent)
		
		# Content Panel Subpanel Outline
		If (!($pnlContentHeaderOutline)) {$global:pnlContentHeaderOutline = New-Object System.Windows.Forms.Panel}
		$pnlContentHeaderOutline.Name = "ContentSubOutlinePanel"
		$pnlContentHeaderOutline.Left = 5
		$pnlContentHeaderOutline.Top = 5
		$pnlContentHeaderOutline.Width = $pnlContent.Width - 10
		$pnlContentHeaderOutline.Height = 80
		$pnlContentHeaderOutline.BackColor = $pnlContent.BackColor
		$pnlContentHeaderOutline.Anchor = "Top,Left,Right"
		$pnlContent.Controls.Add($pnlContentHeaderOutline)
		
		# Content Panel Subpanel
		If (!($pnlContentHeader)) {$global:pnlContentHeader = New-Object System.Windows.Forms.Panel}
		$pnlContentHeader.Name = "ContentSubPanel"
		$pnlContentHeader.Left = 5
		$pnlContentHeader.Top = 5
		$pnlContentHeader.Width = $pnlContentHeaderOutline.Width - 10
		$pnlContentHeader.Height = $pnlContentHeaderOutline.Height - 10
		$pnlContentHeader.BackColor = $pnlContent.BackColor
		$pnlContentHeader.Anchor = "Top,Left,Right,Bottom"
		$pnlContentHeaderOutline.Controls.Add($pnlContentHeader)

	}
	
	
# ------------------------------------------------
# Populate the Header Panel
# ------------------------------------------------	
Function PopulateHeaderPanel()
	{
		# Populate the panels

		# Header Panel

		# Add the TIG Logo header image
		If (!($pbxTopLeftHeaderLogo)) {$global:pbxTopLeftHeaderLogo = New-Object Windows.Forms.PictureBox}
		$pbxTopLeftHeaderLogo.Left = 3
		$pbxTopLeftHeaderLogo.Top = 3
		$pbxTopLeftHeaderLogo.Width = $pnlNavigation.Right - $pnlNavigation.Left
		$pbxTopLeftHeaderLogo.Height = $pnlHeader.Height - $pnlHeader.Top
		$pbxTopLeftHeaderLogo.SizeMode = "Zoom"
		$pbxTopLeftHeaderLogo.Anchor = "Top,Left,Bottom"
		$pbxTopLeftHeaderLogo.Image = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image-xLightsLogo.png")
		$pbxTopLeftHeaderLogo.Add_DoubleClick({
				Start-Process -FilePath powershell.exe -WindowStyle Normal
			})
		$pnlHeader.Controls.Add($pbxTopLeftHeaderLogo)

		# Add the Show Logo header image
		If ($boolShowShowLogo -eq $true)
			{
				If (!($pbxTopRightHeaderLogo)) {$global:pbxTopRightHeaderLogo = New-Object Windows.Forms.PictureBox}
				$pbxTopRightHeaderLogo.Left = $pnlHeader.Right - $pbxTopLeftHeaderLogo.Left - $pbxTopLeftHeaderLogo.Width - 5
				$pbxTopRightHeaderLogo.Top = 3
				$pbxTopRightHeaderLogo.Width = $pbxTopLeftHeaderLogo.Width
				$pbxTopRightHeaderLogo.Height = $pbxTopLeftHeaderLogo.Height
				$pbxTopRightHeaderLogo.SizeMode = "Zoom"
				$pbxTopRightHeaderLogo.Anchor = "Top,Right,Bottom"
				$pbxTopRightHeaderLogo.Image = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image-ShowLogo.png")
				$pnlHeader.Controls.Add($pbxTopRightHeaderLogo)
			}

		# Add Header Label
		If (!($lblHeader)) {$global:lblHeader = New-Object System.Windows.Forms.Label}
		$lblHeader.Left = $pbxTopLeftHeaderLogo.Right
		$lblHeader.Top = $pnlHeader.Height * .2
		$lblHeader.Width = $pnlHeader.Width - ($pbxTopLeftHeaderLogo.Right * 2)
		$lblHeader.Height = $pnlHeader.Height * .51
		$lblHeader.MinimumSize = New-Object System.Drawing.Size(300,30)
		$lblHeader.Backcolor = "Transparent"
		$lblHeader.TextAlign = "MiddleCenter"
		$lblHeader.ForeColor = "CornflowerBlue"
		$lblHeader.Font = New-Object System.Drawing.Font("Times New Roman",22,[System.Drawing.FontStyle]::Bold)
		$lblHeader.Text = $strFormHeader
		$lblHeader.Anchor = "Top,Left,Right"
		$pnlHeader.Controls.Add($lblHeader)

		# Add Sub Header Label
		If (!($lblSubHeader)) {$global:lblSubHeader = New-Object System.Windows.Forms.Label}
		$lblSubHeader.Left = $pbxTopLeftHeaderLogo.Right
		$lblSubHeader.Top = $lblHeader.Bottom
		$lblSubHeader.Width = $pnlHeader.Width - ($pbxTopLeftHeaderLogo.Right * 2)
		$lblSubHeader.Height = $pnlHeader.Height - $lblHeader.Bottom
		$lblSubHeader.MinimumSize = New-Object System.Drawing.Size(300,30)
		$lblSubHeader.Backcolor = "Transparent"
		$lblSubHeader.TextAlign = "MiddleCenter"
		$lblSubHeader.ForeColor = "Black"
		$lblSubHeader.Font = New-Object System.Drawing.Font("Arial",7)
		$lblSubHeader.Text = ""
		$lblSubHeader.Anchor = "Top,Left,Right"
		$pnlHeader.Controls.Add($lblSubHeader)
				

	}


# ------------------------------------------------
# Populate the Content Panel Header
# ------------------------------------------------	
Function PopulateContentPanelHeader($strDefaultPanelContentHeaderText)
	{
		# Add the Content Panel Header Color

		# Add the Left Content Panel image
		If (!($pbxContentHeaderLeftImage)) {$global:pbxContentHeaderLeftImage = New-Object Windows.Forms.PictureBox}
		$pbxContentHeaderLeftImage.Left = 3
		$pbxContentHeaderLeftImage.Top = 3
		$pbxContentHeaderLeftImage.Width = $pnlContentHeader.Height - 6
		$pbxContentHeaderLeftImage.Height = $pnlContentHeader.Height - 6
		$pbxContentHeaderLeftImage.SizeMode = "Stretch"
		$pbxContentHeaderLeftImage.Image = [System.Drawing.Image]::FromFile("$PSScriptRoot\Image-ContentPanelHeader.png")
		$pbxContentHeaderLeftImage.Anchor = "Top,Left"
		$pnlContentHeader.Controls.Add($pbxContentHeaderLeftImage)

		# Add the Right Content Panel image
		If (!($pbxContentHeaderRightImage)) {$global:pbxContentHeaderRightImage = New-Object Windows.Forms.PictureBox}
		$pbxContentHeaderRightImage.Left = $pnlContentHeader.Right - ($pnlContentHeader.Height + 6) - 3 # Creates a square box the same height and width as the height of the Content Panel Header and right offset by 3
		$pbxContentHeaderRightImage.Top = 3
		$pbxContentHeaderRightImage.Width = $pnlContentHeader.Height - 6
		$pbxContentHeaderRightImage.Height = $pbxContentHeaderRightImage.Width
		$pbxContentHeaderRightImage.SizeMode = "Stretch"
		$pbxContentHeaderRightImage.Image = $null
		$pbxContentHeaderRightImage.Visible = $false
		$pbxContentHeaderRightImage.Anchor = "Top,Right"
		$pnlContentHeader.Controls.Add($pbxContentHeaderRightImage)

		# Add Content Panel Label
		If (!($lblContentHeader)) {$global:lblContentHeader = New-Object System.Windows.Forms.Label}
		$lblContentHeader.Left = $pbxContentHeaderLeftImage.Right + 15
		$lblContentHeader.Top = $pbxContentHeaderLeftImage.Height * .33
		$lblContentHeader.Width = $pbxContentHeaderRightImage.Left - $pbxContentHeaderLeftImage.Right - 30
		$lblContentHeader.Height = $pbxContentHeaderLeftImage.Height * .66
		$lblContentHeader.Font = New-Object System.Drawing.Font("Arial",10,[System.Drawing.FontStyle]::Bold)
		$lblContentHeader.Text = $strDefaultPanelContentHeaderText
		$lblContentHeader.Anchor = "Top,Left,Right"
		$pnlContentHeader.Controls.Add($lblContentHeader)


	}
	

# ------------------------------------------------
# Populate Content Panel 1
# ------------------------------------------------	
Function PopulateContent1($strNavigationButton1Text,$strContentPanelHeader)
	{
		# Navigation Button 1
		If (!($btnNavigationButton1)) {$global:btnNavigationButton1 = New-Object Windows.Forms.Checkbox}
		$btnNavigationButton1.Left = 10
		$btnNavigationButton1.Top = $intTopOfFirstButton
		$btnNavigationButton1.Text = $strNavigationButton1Text
		$btnNavigationButton1.Width = $($pnlNavigation.Width - 20)
		$btnNavigationButton1.TextAlign = "MiddleCenter"
		$btnNavigationButton1.Appearance = "Button"
		$btnNavigationButton1.Cursor = "Hand"
		$btnNavigationButton1.BackColor = "WhiteSmoke"
		$btnNavigationButton1.Anchor = "Top,Left,Right"
		$global:strContentPanel1HeaderText = $strContentPanelHeader
		$btnNavigationButton1.Add_Click({
				$pnlContentPanel1.BringToFront()
				$lblContentHeader.Text = $strContentPanel1HeaderText
				SetCheckBoxes $btnNavigationButton1
				})
		$pnlNavigation.Controls.Add($btnNavigationButton1)

		
		# Add the Content Panel 1
		If (!($pnlContentPanel1)) {$global:pnlContentPanel1 = New-Object System.Windows.Forms.Panel}
		$pnlContentPanel1.Name = "ContentPanel1"
		$pnlContentPanel1.Left = 0
		$pnlContentPanel1.Top = $pnlContentHeaderOutline.Bottom + 5
		$pnlContentPanel1.Width = $pnlContent.Width
		$pnlContentPanel1.Height = $pnlContent.Height - $pnlContentPanel1.Top
		$pnlContentPanel1.BackColor = "Transparent"
		$pnlContentPanel1.Anchor = "Top,Left,Right,Bottom"
		#$pnlContentPanel1.BackColor = "Green"
		$pnlContent.Controls.Add($pnlContentPanel1)


	}


# ------------------------------------------------
# Populate Content Panel 2
# ------------------------------------------------	
Function PopulateContent2($strNavigationButton2Text,$strContentPanelHeader)
	{
		# Navigation Button 2
		If (!($btnNavigationButton2)) {$global:btnNavigationButton2 = New-Object Windows.Forms.Checkbox}
		$btnNavigationButton2.Left = 10
		$btnNavigationButton2.Top = $intTopOfFirstButton + (40 * 1)
		$btnNavigationButton2.Width = $($pnlNavigation.Width - 20)
		$btnNavigationButton2.Text = $strNavigationButton2Text
		$btnNavigationButton2.TextAlign = "MiddleCenter"
		$btnNavigationButton2.Appearance = "Button"
		$btnNavigationButton2.Cursor = "Hand"
		$btnNavigationButton2.BackColor = "WhiteSmoke"
		$btnNavigationButton2.Anchor = "Top,Left,Right"
		$global:strContentPanel2HeaderText = $strContentPanelHeader
		$btnNavigationButton2.Add_Click({
				$pnlContentPanel2.BringToFront()
				$lblContentHeader.Text = $strContentPanel2HeaderText
				SetCheckBoxes $btnNavigationButton2
			})
		$pnlNavigation.Controls.Add($btnNavigationButton2)
		
		# Add Content Panel 2
		If (!($pnlContentPanel2)) {$global:pnlContentPanel2 = New-Object System.Windows.Forms.Panel}
		$pnlContentPanel2.Name = "ContentPanel2"
		$pnlContentPanel2.Left = 0
		$pnlContentPanel2.Top = $pnlContentHeaderOutline.Bottom + 5
		$pnlContentPanel2.Width = $pnlContent.Width
		$pnlContentPanel2.Height = $pnlContent.Height - $pnlContentPanel2.Top
		$pnlContentPanel2.BackColor = "Transparent"
		$pnlContentPanel2.Anchor = "Top,Left,Right,Bottom"
		#$pnlContentPanel2.BackColor = "Blue"
		$pnlContent.Controls.Add($pnlContentPanel2)

		
	}


# ------------------------------------------------
# Populate Content Panel 3
# ------------------------------------------------	
Function PopulateContent3($strNavigationButton3Text,$strContentPanelHeader)
	{
		# Navigation Button 3
		If (!($btnNavigationButton3)) {$global:btnNavigationButton3 = New-Object Windows.Forms.Checkbox}
		$btnNavigationButton3.Left = 10
		$btnNavigationButton3.Top = $intTopOfFirstButton + (40 * 2)
		$btnNavigationButton3.Width = $($pnlNavigation.Width - 20)
		$btnNavigationButton3.Text = $strNavigationButton3Text
		$btnNavigationButton3.TextAlign = "MiddleCenter"
		$btnNavigationButton3.Appearance = "Button"
		$btnNavigationButton3.Cursor = "Hand"
		$btnNavigationButton3.BackColor = "WhiteSmoke"
		$btnNavigationButton3.Anchor = "Top,Left,Right"
		$global:strContentPanel3HeaderText = $strContentPanelHeader
		$btnNavigationButton3.Add_Click({
				$pnlContentPanel3.BringToFront()
				$lblContentHeader.Text = $strContentPanel3HeaderText
				SetCheckBoxes $btnNavigationButton3
			})
		$pnlNavigation.Controls.Add($btnNavigationButton3)

		# Add Content Panel 3
		If (!($pnlContentPanel3)) {$global:pnlContentPanel3 = New-Object System.Windows.Forms.Panel}
		$pnlContentPanel3.Name = "ContentPanel3"
		$pnlContentPanel3.Left = 0
		$pnlContentPanel3.Top = $pnlContentHeaderOutline.Bottom + 5
		$pnlContentPanel3.Width = $pnlContent.Width
		$pnlContentPanel3.Height = $pnlContent.Height - $pnlContentPanel3.Top
		$pnlContentPanel3.BackColor = "Transparent"
		$pnlContentPanel3.Anchor = "Top,Left,Right,Bottom"
		#$pnlContentPanel3.BackColor = "Blue"
		$pnlContent.Controls.Add($pnlContentPanel3)		
		
	
	}
		

# ------------------------------------------------
# Populate Content Panel 4
# ------------------------------------------------	
Function PopulateContent4($strNavigationButton4Text,$strContentPanelHeader)
	{
		# Navigation Button 4
		If (!($btnNavigationButton4)) {$global:btnNavigationButton4 = New-Object Windows.Forms.Checkbox}
		$btnNavigationButton4.Left = 10
		$btnNavigationButton4.Top = $intTopOfFirstButton + (40 * 3)
		$btnNavigationButton4.Width = $($pnlNavigation.Width - 20)
		$btnNavigationButton4.Text = $strNavigationButton4Text
		$btnNavigationButton4.TextAlign = "MiddleCenter"
		$btnNavigationButton4.Appearance = "Button"
		$btnNavigationButton4.Cursor = "Hand"
		$btnNavigationButton4.BackColor = "WhiteSmoke"
		$btnNavigationButton4.Anchor = "Top,Left,Right"
		$global:strContentPanel4HeaderText = $strContentPanelHeader
		$btnNavigationButton4.Add_Click({
				$pnlContentPanel4.BringToFront()
				$lblContentHeader.Text = $strContentPanel4HeaderText
				SetCheckBoxes $btnNavigationButton4
			})
		$pnlNavigation.Controls.Add($btnNavigationButton4)
	
		# Add Content Panel 4
		If (!($pnlContentPanel4)) {$global:pnlContentPanel4 = New-Object System.Windows.Forms.Panel}
		$pnlContentPanel4.Name = "ContentPanel4"
		$pnlContentPanel4.Left = 0
		$pnlContentPanel4.Top = $pnlContentHeaderOutline.Bottom + 5
		$pnlContentPanel4.Width = $pnlContent.Width
		$pnlContentPanel4.Height = $pnlContent.Height - $pnlContentPanel4.Top
		$pnlContentPanel4.BackColor = "Transparent"
		$pnlContentPanel4.Anchor = "Top,Left,Right,Bottom"
		#$pnlContentPanel4.BackColor = "Blue"
		$pnlContent.Controls.Add($pnlContentPanel4)		
		
	}
		

# ------------------------------------------------
# Populate Content Panel 5
# ------------------------------------------------	
Function PopulateContent5($strNavigationButton5Text,$strContentPanelHeader)
	{
		# Navigation Button 5
		If (!($btnNavigationButton5)) {$global:btnNavigationButton5 = New-Object Windows.Forms.Checkbox}
		$btnNavigationButton5.Left = 10
		$btnNavigationButton5.Top = $intTopOfFirstButton + (40 * 4)
		$btnNavigationButton5.Width = $($pnlNavigation.Width - 20)
		$btnNavigationButton5.Text = $strNavigationButton5Text
		$btnNavigationButton5.TextAlign = "MiddleCenter"
		$btnNavigationButton5.Appearance = "Button"
		$btnNavigationButton5.Cursor = "Hand"
		$btnNavigationButton5.BackColor = "WhiteSmoke"
		$btnNavigationButton5.Anchor = "Top,Left,Right"
		$global:strContentPanel5HeaderText = $strContentPanelHeader
		$btnNavigationButton5.Add_Click({
				$pnlContentPanel5.BringToFront()
				$lblContentHeader.Text = $strContentPanel5HeaderText
				SetCheckBoxes $btnNavigationButton5
			})
		$pnlNavigation.Controls.Add($btnNavigationButton5)
	
		# Add Content Panel 5
		If (!($pnlContentPanel5)) {$global:pnlContentPanel5 = New-Object System.Windows.Forms.Panel}
		$pnlContentPanel5.Name = "ContentPanel5"
		$pnlContentPanel5.Left = 0
		$pnlContentPanel5.Top = $pnlContentHeaderOutline.Bottom + 5
		$pnlContentPanel5.Width = $pnlContent.Width
		$pnlContentPanel5.Height = $pnlContent.Height - $pnlContentPanel5.Top
		$pnlContentPanel5.BackColor = "Transparent"
		$pnlContentPanel5.Anchor = "Top,Left,Right,Bottom"
		#$pnlContentPanel5.BackColor = "Blue"
		$pnlContent.Controls.Add($pnlContentPanel5)	
	
	}		
		

# ------------------------------------------------
# Populate Content Panel 6
# ------------------------------------------------	
Function PopulateContent6($strNavigationButton6Text,$strContentPanelHeader)
	{
		# Navigation Button 6
		If (!($btnNavigationButton6)) {$global:btnNavigationButton6 = New-Object Windows.Forms.Checkbox}
		$btnNavigationButton6.Left = 10
		$btnNavigationButton6.Top = $intTopOfFirstButton + (40 * 5)
		$btnNavigationButton6.Width = $($pnlNavigation.Width - 20)
		$btnNavigationButton6.Text = $strNavigationButton6Text
		$btnNavigationButton6.TextAlign = "MiddleCenter"
		$btnNavigationButton6.Appearance = "Button"
		$btnNavigationButton6.Cursor = "Hand"
		$btnNavigationButton6.BackColor = "WhiteSmoke"
		$btnNavigationButton6.Anchor = "Top,Left,Right"
		$global:strContentPanel6HeaderText = $strContentPanelHeader
		$btnNavigationButton6.Add_Click({
				$pnlContentPanel6.BringToFront()
				$lblContentHeader.Text = $strContentPanel6HeaderText
				SetCheckBoxes $btnNavigationButton6
			})
		$pnlNavigation.Controls.Add($btnNavigationButton6)
	
		# Add Content Panel 6
		If (!($pnlContentPanel6)) {$global:pnlContentPanel6 = New-Object System.Windows.Forms.Panel}
		$pnlContentPanel6.Name = "ContentPanel6"
		$pnlContentPanel6.Left = 0
		$pnlContentPanel6.Top = $pnlContentHeaderOutline.Bottom + 5
		$pnlContentPanel6.Width = $pnlContent.Width
		$pnlContentPanel6.Height = $pnlContent.Height - $pnlContentPanel6.Top
		$pnlContentPanel6.BackColor = "Transparent"
		$pnlContentPanel6.Anchor = "Top,Left,Right,Bottom"
		#$pnlContentPanel6.BackColor = "Blue"
		$pnlContent.Controls.Add($pnlContentPanel6)	
	
	}

	
# ------------------------------------------------
# Add Control Button 4
# ------------------------------------------------	
Function AddControlButton4($strControlButton4Text)
	{
		If (!($btnControlButton4)) {$global:btnControlButton4 = New-Object Windows.Forms.Button}
		$btnControlButton4.Left = 10
		$btnControlButton4.Top = $intTopOfFirstButton + (40 * 3)
		$btnControlButton4.Width = $($pnlNavigation.Width - 20)
		$btnControlButton4.Text = $strControlButton4Text
		$btnControlButton4.TextAlign = "MiddleCenter"
		$btnControlButton4.Cursor = "Hand"
		$btnControlButton4.BackColor = "WhiteSmoke"
		$btnControlButton4.Anchor = "Top,Left,Right"
		$btnControlButton4.Add_Click({
				SetCheckBoxes $btnControlButton4
			})
		$pnlNavigation.Controls.Add($btnControlButton4)
	}

	

# ------------------------------------------------
# Add Control Button 5
# ------------------------------------------------	
Function AddControlButton5($strControlButton5Text)
	{
		If (!($btnControlButton5)) {$global:btnControlButton5 = New-Object Windows.Forms.Button}
		$btnControlButton5.Left = 10
		$btnControlButton5.Top = $intTopOfFirstButton + (40 * 4)
		$btnControlButton5.Width = $($pnlNavigation.Width - 20)
		$btnControlButton5.Text = $strControlButton5Text
		$btnControlButton5.TextAlign = "MiddleCenter"
		$btnControlButton5.Cursor = "Hand"
		$btnControlButton5.BackColor = "WhiteSmoke"
		$btnControlButton5.Anchor = "Top,Left,Right"
		$btnControlButton5.Add_Click({
				SetCheckBoxes $btnControlButton5
			})
		$pnlNavigation.Controls.Add($btnControlButton5)
	}
	

	
# ------------------------------------------------
# Add Control Button 6
# ------------------------------------------------	
Function AddControlButton6($strControlButton6Text)
	{
		If (!($btnControlButton6)) {$global:btnControlButton6 = New-Object Windows.Forms.Button}
		$btnControlButton6.Left = 10
		$btnControlButton6.Top = $intTopOfFirstButton + (40 * 5)
		$btnControlButton6.Width = $($pnlNavigation.Width - 20)
		$btnControlButton6.Text = $strControlButton6Text
		$btnControlButton6.TextAlign = "MiddleCenter"
		$btnControlButton6.Appearance = "Button"
		$btnControlButton6.Cursor = "Hand"
		$btnControlButton6.BackColor = "WhiteSmoke"
		$btnControlButton6.Anchor = "Top,Left,Right"
		$btnControlButton6.Add_Click({
				SetCheckBoxes $btnControlButton6
			})
		$pnlNavigation.Controls.Add($btnControlButton6)
	}
	

	
# ------------------------------------------------
# Add Task Label 1
# ------------------------------------------------	
Function AddTaskLabel1 ($strTaskLabel1Text)
	{
		If (!($lblTaskLabel1)) {$global:lblTaskLabel1 = New-Object System.Windows.Forms.Label}
		$lblTaskLabel1.Left = 10
		$lblTaskLabel1.Top = $intBottomOfLastButton - (30 * 5)
		$lblTaskLabel1.Width = $pnlNavigation.Width - 20
		$lblTaskLabel1.Text = $strTaskLabel1Text
#		$lblTaskLabel1.ForeColor = "LightGray"
		$lblTaskLabel1.BackColor = "Transparent"
		$lblTaskLabel1.Visible = $true
		$lblTaskLabel1.Anchor = "Bottom,Left,Right"
		$pnlNavigation.Controls.Add($lblTaskLabel1)	
	}


	
# ------------------------------------------------
# Add Task Label 2
# ------------------------------------------------	
Function AddTaskLabel2 ($strTaskLabel2Text)
	{
		If (!($lblTaskLabel2)) {$global:lblTaskLabel2 = New-Object System.Windows.Forms.Label}
		$lblTaskLabel2.Left = 10
		$lblTaskLabel2.Top = $intBottomOfLastButton - (30 * 4)
		$lblTaskLabel2.Width = $pnlNavigation.Width - 20
		$lblTaskLabel2.Text = $strTaskLabel2Text
#		$lblTaskLabel2.ForeColor = "LightGray"
		$lblTaskLabel2.BackColor = "Transparent"
		$lblTaskLabel2.Visible = $true
		$lblTaskLabel2.Anchor = "Bottom,Left,Right"
		$pnlNavigation.Controls.Add($lblTaskLabel2)	
	}


	
# ------------------------------------------------
# Add Task Label 3
# ------------------------------------------------	
Function AddTaskLabel3 ($strTaskLabel3Text)
	{
		If (!($lblTaskLabel3)) {$global:lblTaskLabel3 = New-Object System.Windows.Forms.Label}
		$lblTaskLabel3.Left = 10
		$lblTaskLabel3.Top = $intBottomOfLastButton - (30 * 3)
		$lblTaskLabel3.Width = $pnlNavigation.Width - 20
		$lblTaskLabel3.Text = $strTaskLabel3Text
#		$lblTaskLabel3.ForeColor = "LightGray"
		$lblTaskLabel3.BackColor = "Transparent"
		$lblTaskLabel3.Visible = $true
		$lblTaskLabel3.Anchor = "Bottom,Left,Right"
		$pnlNavigation.Controls.Add($lblTaskLabel3)	
	}
	


# ------------------------------------------------
# Add Task Button 1
# ------------------------------------------------	
Function AddTaskButton1 ($strTaskButton1Text)
	{
		If (!($btnTaskButton1)) {$global:btnTaskButton1 = New-Object System.Windows.Forms.Button}
		$btnTaskButton1.Left = 10
		$btnTaskButton1.Top = $intBottomOfLastButton - (30 * 5)
		$btnTaskButton1.Width = $pnlNavigation.Width - 20
		$btnTaskButton1.Text = $strTaskButton1Text
		$btnTaskButton1.Cursor = "Hand"
		$btnTaskButton1.ForeColor = "Black"
		$btnTaskButton1.BackColor = "WhiteSmoke"
		$btnTaskButton1.Visible = $true
		$btnTaskButton1.Anchor = "Bottom,Left,Right"
		$pnlNavigation.Controls.Add($btnTaskButton1)	
	}


	
# ------------------------------------------------
# Add Task Button 2
# ------------------------------------------------	
Function AddTaskButton2 ($strTaskButton2Text)
	{
		If (!($btnTaskButton2)) {$global:btnTaskButton2 = New-Object System.Windows.Forms.Button}
		$btnTaskButton2.Left = 10
		$btnTaskButton2.Top = $intBottomOfLastButton - (30 * 4)
		$btnTaskButton2.Width = $pnlNavigation.Width - 20
		$btnTaskButton2.Text = $strTaskButton2Text
		$btnTaskButton2.Cursor = "Hand"
		$btnTaskButton2.ForeColor = "Black"
		$btnTaskButton2.BackColor = "WhiteSmoke"
		$btnTaskButton2.Visible = $true
		$btnTaskButton2.Anchor = "Bottom,Left,Right"
		$btnTaskButton2.Add_Click({
				
			})
		$pnlNavigation.Controls.Add($btnTaskButton2)	
	}


	
# ------------------------------------------------
# Add Task Button 3
# ------------------------------------------------	
Function AddTaskButton3 ($strTaskButton3Text)
	{
		If (!($btnTaskButton3)) {$global:btnTaskButton3 = New-Object System.Windows.Forms.Button}
		$btnTaskButton3.Left = 10
		$btnTaskButton3.Top = $intBottomOfLastButton - (30 * 3)
		$btnTaskButton3.Width = $pnlNavigation.Width - 20
		$btnTaskButton3.Text = $strTaskButton3Text
		$btnTaskButton3.Cursor = "Hand"
		$btnTaskButton3.ForeColor = "Black"
		$btnTaskButton3.BackColor = "WhiteSmoke"
		$btnTaskButton3.Visible = $true
		$btnTaskButton3.Anchor = "Bottom,Left,Right"
		$btnTaskButton3.Add_Click({
				
			})
		$pnlNavigation.Controls.Add($btnTaskButton3)	
	}


	
# ------------------------------------------------
# Add Task Button 4
# ------------------------------------------------	
Function AddTaskButton4 ($strTaskButton4Text)
	{
		If (!($btnTaskButton4)) {$global:btnTaskButton4 = New-Object System.Windows.Forms.Button}
		$btnTaskButton4.Left = 10
		$btnTaskButton4.Top = $intBottomOfLastButton - (30 * 2)
		$btnTaskButton4.Width = $pnlNavigation.Width - 20
		$btnTaskButton4.Text = $strTaskButton4Text
		$btnTaskButton4.Cursor = "Hand"
		$btnTaskButton4.ForeColor = "Black"
		$btnTaskButton4.BackColor = "WhiteSmoke"
		$btnTaskButton4.Visible = $true
		$btnTaskButton4.Anchor = "Bottom,Left,Right"
		$btnTaskButton4.Add_Click({
				
			})
		$pnlNavigation.Controls.Add($btnTaskButton4)	
	}


	
# ------------------------------------------------
# Add Task Button 5
# ------------------------------------------------	
Function AddTaskButton5 ($strTaskButton5Text)
	{
		If (!($btnTaskButton5)) {$global:btnTaskButton5 = New-Object System.Windows.Forms.Button}
		$btnTaskButton5.Left = 10
		$btnTaskButton5.Top = $intBottomOfLastButton - (30 * 1)
		$btnTaskButton5.Width = $pnlNavigation.Width - 20
		$btnTaskButton5.Text = $strTaskButton5Text
		$btnTaskButton5.Cursor = "Hand"
		$btnTaskButton5.ForeColor = "Black"
		$btnTaskButton5.BackColor = "WhiteSmoke"
		$btnTaskButton5.Visible = $true
		$btnTaskButton5.Anchor = "Bottom,Left,Right"
		$btnTaskButton5.Add_Click({
				
			})
		$pnlNavigation.Controls.Add($btnTaskButton5)	
	}


	
# ------------------------------------------------
# Create the Sound control button
# ------------------------------------------------	
Function ControlPlaySoundButton ()
	{
		# Add a button to stop/start the sound test
		If (!($btnControlPlaySound)) {$global:btnControlPlaySound = New-Object System.Windows.Forms.Button}
		$btnControlPlaySound.Left = 10
		$btnControlPlaySound.Top = $pnlNavigation.Height - 30
		$btnControlPlaySound.Width = $pnlNavigation.Width - 20
		$btnControlPlaySound.Text = "Sound Test"
		$btnControlPlaySound.Cursor = "Hand"
		$btnControlPlaySound.ForeColor = "LightGray"
		$btnControlPlaySound.BackColor = "WhiteSmoke"
		$btnControlPlaySound.Visible = $false
		$btnControlPlaySound.Anchor = "Bottom,Left,Right"
		$btnControlPlaySound.Add_Click({
				ToggleControlPlaySoundButton
			})
		$pnlNavigation.Controls.Add($btnControlPlaySound)

		# Commented out (as it makes more sense to leave this generic and add it to the parent script) but left as an example
#		# Add a key event to the main form so CTRL-Z will toggle the sound
#		$objForm.Add_KeyDown({
#				# Press CTRL-Z to toggle the test sound on/off
#				If ($_.KeyCode -eq "Z" -and $_.Modifiers -eq "Control")
#					{ToggleControlPlaySoundButton}
#			})


		# Set a tooltip on the button to show the path to the sound file (the Tooltip info is updated later in the script)
		If (!($btnControlPlaySoundToolTip)) {$global:btnControlPlaySoundToolTip = New-Object System.Windows.Forms.ToolTip}
		$btnControlPlaySoundToolTip.AutomaticDelay = 0
		$btnControlPlaySoundToolTip.AutoPopDelay = "30000"
		$btnControlPlaySoundToolTip.ToolTipTitle = "WAV File"
		$btnControlPlaySoundToolTip.SetToolTip($btnControlPlaySound,"")
	}
	


# ------------------------------------------------
# Add the Computer Info labels to the footer
# ------------------------------------------------	
Function ShowComputerInfoInFooter()
	{
		# Add Footer Computer Info Labels
		# Note that this section queries WMI again instead of using the previously created variables as those variables may have been shortened/trimmed and this section should show the true values.
		If (!($lblComputerMakeModel)) {$global:lblComputerMakeModel = New-Object System.Windows.Forms.Label}
		$lblComputerMakeModel.Left = 8 
		$lblComputerMakeModel.Top = ($pnlFooter.Height * .25) - ($lblComputerMakeModel.Height / 2)
		$lblComputerMakeModel.Width = $pnlFooter.Width * .33
		$lblComputerMakeModel.Backcolor = "Transparent"
		$lblComputerMakeModel.TextAlign = "MiddleLeft"
		$lblComputerMakeModel.ForeColor = "Gray"
		$lblComputerMakeModel.Text = ((Get-CimInstance -ClassName Win32_ComputerSystem).Manufacturer.Replace(" Inc.","").Trim()) + " " + ((Get-CimInstance -Classname Win32_ComputerSystem).Model.Trim()) + " / BIOS Version: " + (Get-CimInstance -ClassName Win32_BIOS).SMBIOSBIOSVersion
		$lblComputerMakeModel.Anchor = "Top,Left"
		$pnlFooter.Controls.Add($lblComputerMakeModel)

		If (!($lblComputerSerial)) {$global:lblComputerSerial = New-Object System.Windows.Forms.Label}
		$lblComputerSerial.Left = 8
		$lblComputerSerial.Top = ($pnlFooter.Height * .75) - ($lblComputerSerial.Height / 2)
		$lblComputerSerial.Width = $lblComputerMakeModel.Width
		$lblComputerSerial.Backcolor = "Transparent"
		$lblComputerSerial.TextAlign = "MiddleLeft"
		$lblComputerSerial.ForeColor = "Gray"
		$lblComputerSerial.Text = "Serial Number: " + (Get-CimInstance -ClassName Win32_BIOS).SerialNumber
		$lblComputerSerial.Anchor = "Bottom,Left"
		$pnlFooter.Controls.Add($lblComputerSerial)
	}
	
	
# ------------------------------------------------
# Add the Footer Title labels
# ------------------------------------------------	
Function AddFooterTitles($strDefaultFooterTitleText,$strDefaultFooterSubTitleText)
	{
		# Add the Footer Title
		If (!($lblFooterTitle)) {$global:lblFooterTitle = New-Object System.Windows.Forms.Label}
		$lblFooterTitle.Width = $pnlFooter.Width * .5
		$lblFooterTitle.Height = $pnlFooter.Height * .5
		$lblFooterTitle.Left = $pnlFooter.Width * .25
		$lblFooterTitle.Top = ($pnlFooter.Height * .25) - ($lblFooterTitle.Height / 2)
		$lblFooterTitle.MinimumSize = New-Object System.Drawing.Size(300,$lblFooterTitle.Height)
		$lblFooterTitle.Backcolor = "Transparent"
		$lblFooterTitle.TextAlign = "MiddleCenter"
		$lblFooterTitle.ForeColor = "Gray"
		$lblFooterTitle.Text = $strDefaultFooterTitleText
		$lblFooterTitle.Anchor = "Left,Right,Top"
		$lblFooterTitle.Cursor = "Hand"
#		$lblFooterTitle.Add_Click({
#							StartStopTimerWhenClicked
#					})							
		$pnlFooter.Controls.Add($lblFooterTitle)

		# Add the Footer Sub Title
		If (!($lblFooterSubTitle)) {$global:lblFooterSubTitle = New-Object System.Windows.Forms.Label}
		$lblFooterSubTitle.Width = $lblFooterTitle.Width
		$lblFooterSubTitle.Height = $pnlFooter.Height * .5
		$lblFooterSubTitle.Left = $lblFooterTitle.Left
		$lblFooterSubTitle.Top = $lblFooterTitle.Bottom
		$lblFooterSubTitle.MinimumSize = New-Object System.Drawing.Size(300,$lblFooterSubTitle.Height)
		$lblFooterSubTitle.Backcolor = "Transparent"
		$lblFooterSubTitle.TextAlign = "MiddleCenter"
		$lblFooterSubTitle.ForeColor = "Gray"
		$lblFooterSubTitle.Text = $strDefaultFooterSubTitleText
		$lblFooterSubTitle.Anchor = "Left,Right,Top"
		$lblFooterSubTitle.Cursor = "Hand"
#		$lblFooterSubTitle.Add_Click({
#								StartStopTimerWhenClicked
#							})
		$pnlFooter.Controls.Add($lblFooterSubTitle)
	}
	
	
# ------------------------------------------------
# Add the Save To File Button
# ------------------------------------------------	
Function AddSaveToFileButton()
	{
		If (!($btnSaveToFile)) {$global:btnSaveToFile = New-Object System.Windows.Forms.Button}
		$btnSaveToFile.Left = $pnlFooter.Right - 100 - 20 - 100 - 15
		$btnSaveToFile.Top = ($pnlFooter.Height * .5) - ($btnSaveToFile.Height / 2)
		$btnSaveToFile.Width = 100 
		$btnSaveToFile.Text = "Save To File"
		$btnSaveToFile.BackColor = "WhiteSmoke"
		$btnSaveToFile.Anchor = "Top,Right"
		$btnSaveToFile.Cursor = "Hand"
#				$btnSaveToFile.Add_Click({
#						CreateOutputFile
#					})
		$pnlFooter.Controls.Add($btnSaveToFile)
	}
	
	
# ------------------------------------------------
# Add the Form Submit Button (used for OK/Close/Submit)
# ------------------------------------------------	
Function AddFormSubmitButton($strFormSubmitButtonText, $boolSetFormToCloseOnClick)
	{
		If (!($btnFormSubmit)) {$global:btnFormSubmit = New-Object System.Windows.Forms.Button}
		$btnFormSubmit.Left = $pnlFooter.Right - 100 - 15
		$btnFormSubmit.Top = ($pnlFooter.Height * .5) - ($btnFormSubmit.Height / 2)
		$btnFormSubmit.Width = 100
		$btnFormSubmit.BackColor = "WhiteSmoke"
		$btnFormSubmit.Text = $strFormSubmitButtonText
		$btnFormSubmit.Anchor = "Top,Right"
		$btnFormSubmit.Cursor = "Hand"
		If ($boolSetFormToCloseOnClick -eq $true)
			{
				$btnFormSubmit.Add_Click({
						$objForm.Close()
					})
			}
		$pnlFooter.Controls.Add($btnFormSubmit)
		#$objForm.AcceptButton = $btnFormSubmit
	}



# ------------------------------------------------
# Add a Data Grid to Content Panel 
# ------------------------------------------------	
Function AddDataGrid($strContentButtonText,$strContentHeaderText,$tblDataGridContent,$objPanel)
	{
		If ($objPanel -ge 1 -and $objPanel -le 6) 
			{$global:objDataGridPanel = $objPanel}
			Else{$global:objDataGridPanel = 1}
		
		&"PopulateContent$objDataGridPanel" $strContentButtonText $strContentHeaderText
	
		# Add a data grid to the Content Panel	
		If (!($objDataGrid1)) {$global:objDataGrid1 = New-Object System.Windows.Forms.DataGridView}
		$objDataGrid1.Name = "DataGrid"
		$objDataGrid1.Left = 5
		$objDataGrid1.Top = 0
		$objDataGrid1.Width = $pnlContentPanel2.Width - 10
		$objDataGrid1.Height = $pnlContentPanel2.Height - 5
		$objDataGrid1.DataBindings.DefaultDataSourceUpdateMode = 0
		$objDataGrid1.DataSource = $tblDataGridContent
		$objDataGrid1.AutoSizeColumnsMode = 16
		$objDataGrid1.RowHeadersVisible = $false
		$objDataGrid1.SelectionMode = "FullRowSelect"
		$objDataGrid1.AllowUserToAddRows = $false
		$objDataGrid1.AllowUserToDeleteRows = $false
		$objDataGrid1.AllowUserToOrderColumns = $false
		$objDataGrid1.AllowUserToResizeRows = $false
		$objDataGrid1.ReadOnly = $true;
		$objDataGrid1.MultiSelect = $false
		$objDataGrid1.Anchor = "Top,Left,Right,Bottom"


		Switch ($objDataGridPanel)
			{
				1  {$objDataGrid1.Width = $pnlContentPanel1.Width - 10 ; $objDataGrid1.Height = $pnlContentPanel1.Height - 5 ; $pnlContentPanel1.Controls.Add($objDataGrid1) ; Break}
				2  {$objDataGrid1.Width = $pnlContentPanel2.Width - 10 ; $objDataGrid1.Height = $pnlContentPanel2.Height - 5 ; $pnlContentPanel2.Controls.Add($objDataGrid1) ; Break}
				3  {$objDataGrid1.Width = $pnlContentPanel3.Width - 10 ; $objDataGrid1.Height = $pnlContentPanel3.Height - 5 ; $pnlContentPanel3.Controls.Add($objDataGrid1) ; Break}
				4  {$objDataGrid1.Width = $pnlContentPanel4.Width - 10 ; $objDataGrid1.Height = $pnlContentPanel4.Height - 5 ; $pnlContentPanel4.Controls.Add($objDataGrid1) ; Break}
				5  {$objDataGrid1.Width = $pnlContentPanel5.Width - 10 ; $objDataGrid1.Height = $pnlContentPanel5.Height - 5 ; $pnlContentPanel5.Controls.Add($objDataGrid1) ; Break}
				6  {$objDataGrid1.Width = $pnlContentPanel6.Width - 10 ; $objDataGrid1.Height = $pnlContentPanel6.Height - 5 ; $pnlContentPanel6.Controls.Add($objDataGrid1) ; Break}
			}
	}
	
	
	
# ------------------------------------------------
# Add a multiline text box to Content Panel 6
# ------------------------------------------------	
Function AddMultiLineTextBox($strContent6ButtonText,$strContentHeaderText)
	{
		PopulateContent6 $strContent6ButtonText $strContentHeaderText
			
		# Add a multiline text box to Content Panel 6 for showing a large amount of formatted or unformatted text
		If (!($objContent6MultiLineTextBox)) {$global:objContent6MultiLineTextBox = New-Object System.Windows.Forms.RichTextBox}
		$objContent6MultiLineTextBox.Left = 5
		$objContent6MultiLineTextBox.Top = 0
		$objContent6MultiLineTextBox.Width = $pnlContentPanel6.Width - 10
		$objContent6MultiLineTextBox.Height = $pnlContentPanel6.Height - 5
#		$objContent6MultiLineTextBox.AppendText("Line1:`t`tTEXT`n")
#		$objContent6MultiLineTextBox.AppendText("Line2:`t`tTEXT`n")
		$objContent6MultiLineTextBox.Visible = $true
		$objContent6MultiLineTextBox.ReadOnly = $true
		$pnlContentPanel6.Controls.Add($objContent6MultiLineTextBox)
	}

