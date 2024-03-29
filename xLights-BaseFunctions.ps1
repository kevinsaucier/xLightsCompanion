# Created By: Kevin Saucier
# Last Modified Date: 2021-09-24
#
# This script contains generic functions used by other scripts

Write-Host "[$(Get-Date -Format G)] Initializing Functions..."


# ********************************************************************
# Write messages to the console and color code by type
# ********************************************************************
Function LogWrite ($strLogType, $strLogMessage, $strForceColor)
	{
		Switch ($strLogLevel)
			{
				"ERROR"  {If ($strLogType -eq "ERROR") {$boolOutputLog = $true} Else {$boolOutputLog = $false}}
				"WARNING" {If ($strLogType -in ("WARNING","ERROR")) {$boolOutputLog = $true} Else {$boolOutputLog = $false}}
				"INFO" {If ($strLogType -in ("INFO","WARNING","ERROR")) {$boolOutputLog = $true} Else {$boolOutputLog = $false}}
				"VERBOSE" {If ($strLogType -in ("VERBOSE","INFO","WARNING","ERROR")) {$boolOutputLog = $true} Else {$boolOutputLog = $false}}
				"DEBUG"  {If ($strLogType -in ("DEBUG","VERBOSE","INFO","WARNING","ERROR")) {$boolOutputLog = $true} Else {$boolOutputLog = $false}}
				default {$boolOutputLog = $true}
			}

		If ($boolOutputLog)
			{
				Write-Host "[$(Get-Date -Format G)] " -NoNewline -ForegroundColor "Cyan"
				Write-Host "$strLogType : $strLogMessage" -ForegroundColor $(If ($strForceColor) {$strForceColor} ElseIf ($strLogType -eq "DEBUG") {"Magenta"} ElseIf ($strLogType -eq "VERBOSE") {"DarkYellow"} ElseIf ($strLogType -eq "WARNING") {"Yellow"} ElseIf ($strLogType -eq "ERROR") {"Red"} Else {"White"})
			}
	}


# ********************************************************************
# Check to see if a field is NULL
# Ex. If (IS-NULL($variable)) {echo "Is Null"} else {echo "Is Not Null")
# ********************************************************************
Function IS-NULL($value)
	{
	  Return [System.DBNull]::Value.Equals($value)
	}


# ********************************************************************
# Look through an array of variables and return the first non-NULL variable (use the -EmptyStringAsNull switch to control how blank strings are handled)
# Examples:
#	Write-Host "1 (w/o flag)  - empty/null/'end'                 : ""$((Coalesce '', $null, 'end'))""`n" -ForegroundColor Green # Returns ''
#	Write-Host "1 (with flag) - empty/null/'end'                 : ""$((Coalesce '', $null, 'end' -EmptyStringAsNull))""`n" -ForegroundColor Green # Returns 'end'
#	Write-Host "2 (w/o flag)  - empty/null                       : ""$((Coalesce '', $null))""`n" -ForegroundColor Green # Returns ''
#	Write-Host "2 (with flag) - empty/null                       : ""$((Coalesce '', $null -EmptyStringAsNull))""`n" -ForegroundColor Green # Returns ''
#	Write-Host "3 (w/o flag)  - empty/null/`$false/'end'          : ""$((Coalesce '', $null, $false, 'end'))""`n" -ForegroundColor Green # Returns ''
#	Write-Host "3 (with flag) - empty/null/`$false/'end'          : ""$((Coalesce '', $null, $false, 'end' -EmptyStringAsNull))""`n" -ForegroundColor Green # Returns 'False'
#	Write-Host "4 (w/o flag)  - empty/null/`"`$false`"/'end'        : ""$((Coalesce '', $null, "$false", 'end'))""`n"  -ForegroundColor Green # Returns ''
#	Write-Host "4 (with flag) - empty/null/`"`$false`"/'end'        : ""$((Coalesce '', $null, "$false", 'end' -EmptyStringAsNull))""`n"  -ForegroundColor Green # Returns 'False'
#	Write-Host "5 (w/o flag)  - empty/'false'/null/`"`$false`"/'end': ""$((Coalesce '', 'false', $null, "$false", 'end'))""`n"  -ForegroundColor Green # Returns ''
#	Write-Host "5 (with flag) - empty/'false'/null/`"`$false`"/'end': ""$((Coalesce '', 'false', $null, "$false", 'end' -EmptyStringAsNull))""`n"  -ForegroundColor Green # Returns 'false'
# ********************************************************************
Function Coalesce([string[]] $arrStringsToLookThrough, [switch]$EmptyStringAsNull) 
	{
  		If ($EmptyStringAsNull.IsPresent) 
			{
				# Write-Host "Empty Strings as NULL: ""$arrStringsToLookThrough"""
    			Return ($arrStringsToLookThrough | Where-Object { $_ } | Select-Object -First 1)
  			}
			Else 
				{
					# Write-Host "Include Empty Strings: ""$arrStringsToLookThrough"""
    				Return (($null -ne $arrStringsToLookThrough) | Select-Object -First 1)
  				}  
	}


# ********************************************************************
# Check to see if a value is numeric
# ********************************************************************
Function IsNumeric ($ValueToCheck) {
		[reflection.assembly]::LoadWithPartialName("'Microsoft.VisualBasic") | Out-Null
		Return [Microsoft.VisualBasic.Information]::isnumeric($ValueToCheck)
	}


# ********************************************************************
# Determine if the user is running the script as an Administrator
# ********************************************************************
Function ScriptRunningAsAdmin ()
	{
		Return ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] “Administrator”)
	}


# ********************************************************************
# Bring a window to the foreground using Windows APIs - Use Get-Process to pass an object to the function
# Requires PowerShell v2
# intWindowState controls the state of the window when brought forward - https://docs.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-showwindow
# ********************************************************************
Function BringProcessToFront($objProcess, $intWindowState)
	{
		If (!($objShowProcessDLLs) -or !($objShowProcessType))
			{
				$global:objShowProcessDLLs = '
					[DllImport("user32.dll")] public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
					[DllImport("user32.dll")] public static extern int SetForegroundWindow(IntPtr hwnd);
					'
				
				$global:objShowProcessType = Add-Type -MemberDefinition $objShowProcessDLLs -Name WindowAPI -PassThru -ErrorAction SilentlyContinue
			}
	
		# If the Window State wasn't specified or wasn't numeric, set it to 9 (Restore)
		If (!($intWindowState) -or (IsNumeric $intWindowState) -eq $false) {$intWindowState = 9}
		
		# Get the Window Handle
		$objProcessWindowHandle = $objProcess.MainWindowHandle
#		$objShowProcessType::ShowWindowAsync($objProcessWindowHandle, $intWindowState) | Out-Null
		$objShowProcessType::SetForegroundWindow($objProcessWindowHandle) | Out-Null
	}

	


##############################################################
# Parse an INI file and break it up by section/name/value
# https://devblogs.microsoft.com/scripting/use-powershell-to-work-with-any-ini-file/
##############################################################	
Function Get-IniContent ($strIniFilePath)
	{
	    $objIniSettings = [ordered]@{}
	    Switch -Regex -File $strIniFilePath
		    {
		        "^\[(.+)\]" # Section
			        {
			            $objSection = $matches[1]
			            $objIniSettings[$objSection] = @{}
			            $intCommentCount = 0
			        }
				
		        "^(;.*)$" # Comment
			        {
			            $value = $matches[1]
			            $intCommentCount = $intCommentCount + 1
			            $name = "Comment" + $intCommentCount
			            $objIniSettings[$objSection][$name] = $value
			        }
					
		        "(.+?)\s*=(.*)" # Key
			        {
			            $name,$value = $matches[1..2]
			            $objIniSettings[$objSection][$name] = $value
			        }
		    }
			
	    Return $objIniSettings
	}
	
	

##############################################################
# Ouput a hash table to an INI file creating section/name/value
# https://devblogs.microsoft.com/scripting/use-powershell-to-work-with-any-ini-file/
##############################################################	
Function Out-IniFile($objInputTable, $strIniFilePath)
	{
	    $objOutputFile = New-Item -ItemType file -Path $strIniFilePath -Force
	    
		ForEach ($i in $objInputTable.Keys)
		    {
		        If (!($($objInputTable[$i].GetType().Name) -eq "Hashtable"))
			        {
			            #No Sections
			            Add-Content -Path $objOutputFile -Value "$i=$($objInputTable[$i])"
			        } 
					Else 
						{
				            #Sections
				            Add-Content -Path $objOutputFile -Value "[$i]"
				            Foreach ($j in ($objInputTable[$i].Keys))
					            {
					                If ($j -match "^Comment[\d]+") 
										{Add-Content -Path $objOutputFile -Value "$($objInputTable[$i][$j])"}
										Else 
											{Add-Content -Path $objOutputFile -Value "$j=$($objInputTable[$i][$j])"}

					            }
								
				            Add-Content -Path $objOutputFile -Value ""
				        }
		    }
	}



Function Get-Duplicates ($arrSourceArray)
	{
		# Get a list of all unique values in the array
		$arrUniqueValues = $arrSourceArray | Select-Object -Unique
	
		# Subtract the unique values from the original array to get a list of all non-unique (duplicated) values
		$arrDuplicateValues = (Compare-Object -ReferenceObject $arrSourceArray -DifferenceObject $arrUniqueValues | Where-Object {$_.sideIndicator -like "<="}).InputObject
	
		# Get a list of unique duplicate values from the overall list of non-unique duplicate values
		$arrUniqueDuplicatedValues = $arrDuplicateValues | Select-Object -Unique

		# Return the list of duplicated values
		Return $arrUniqueDuplicatedValues
	}