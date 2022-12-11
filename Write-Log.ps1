<#
	.SYNOPSIS
		A simple logging utility for Powershell.

	.DESCRIPTION
		Writes a generic event to the console and optionally to a file. Wrapper functions for 'standard' events are provided.  

	.PARAMETER EventType
		Specifies the type of event to log, e.g. INFO, ERROR or CUSTOM_EVENT.

	.PARAMETER EventMessage
		Specifies the text of the event to log.

	.PARAMETER LogToFile
		Specifies whether the event must be logged to a file or not.

	.PARAMETER LogFilePath
		Specifies the path to the log file.

	.INPUTS
		None. You cannot pipe objects to Write-Log.ps1.

	.OUTPUTS
		None. Write-Log.ps1 does not output any object.

	.EXAMPLE
		PS> .\Write-Log -EventType "CUSTOM_EVENT" -EventMessage "An interesting event"
		
		2021-08-25 12:03:06 CUSTOM_EVENT An interesting event

	.NOTES
		Author: Benito Matteo Bercini
		Version: 1.1
#>


function Write-Log {

	param (
		[parameter(Mandatory=$true)]
		[string]$EventType,
		[parameter(Mandatory=$true)]
		[string]$EventMessage,
        [bool]$LogToFile = $false,
        [string]$LogFilePath
	)

	<#
		Write-Log
		Copyright (C) 2021-current  Benito Matteo Bercini

		This program is free software: you can redistribute it and/or modify
		it under the terms of the GNU General Public License as published by
		the Free Software Foundation, either version 3 of the License, or
		(at your option) any later version.

		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.

		You should have received a copy of the GNU General Public License
		along with this program.  If not, see <https://www.gnu.org/licenses/>.
	#>

	$LogDateTime = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

	$s = "$LogDateTime $EventType $EventMessage"

	if ($LogToFile) {
		$s | Out-File -FilePath "$LogFilePath" -Append 
	}

	if ($EventType -eq 'FATAL') {
		Throw "$s"
	} else {
		Write-Output "$s"
	} 
}

function Write-LogInfo {
	<#
		.SYNOPSIS
			Write-Log wrapper function.

		.DESCRIPTION
			Can be used to log events considered as 'info'. 

		.PARAMETER EventMessage
			Specifies the text of the event to log.

		.PARAMETER LogToFile
			Specifies whether the event must be logged to a file or not.

		.PARAMETER LogFilePath
			Specifies the path to the log file.

		.INPUTS
			None. You cannot pipe objects to Write-LogInfo.

		.OUTPUTS
			None. Write-LogInfo does not output any object.
	#>


	param (
		[Parameter(Mandatory=$true, Position=0)]
		[String]$EventMessage,
		[Parameter(Position=1)]
        [Boolean]$LogToFile = $false,
		[Parameter(Position=2)]
        [String]$LogFilePath
	)
	
	Write-Log -EventType "INFO" -EventMessage $EventMessage -LogToFile $LogToFile -LogFilePath $LogFilePath
}

function Write-LogSuccess {
	<#
		.SYNOPSIS
			Write-Log wrapper function.

		.DESCRIPTION
			Can be used to log events considered as 'success'. 

		.PARAMETER EventMessage
			Specifies the text of the event to log.

		.PARAMETER LogToFile
			Specifies whether the event must be logged to a file or not.

		.PARAMETER LogFilePath
			Specifies the path to the log file.

		.INPUTS
			None. You cannot pipe objects to Write-LogInfo.

		.OUTPUTS
			None. Write-LogInfo does not output any object.
	#>


	param (
		[Parameter(Mandatory=$true, Position=0)]
		[String]$EventMessage,
		[Parameter(Position=1)]
        [Boolean]$LogToFile = $false,
		[Parameter(Position=2)]
        [String]$LogFilePath
	)

	# Source: https://www.powershellgallery.com/packages/TMOutput/1.1
	$DefaultConsoleForegroundColor = [System.Console]::ForegroundColor
	#$DefaultConsoleBackgroundColor = [System.Console]::BackgroundColor
	
	[System.Console]::ForegroundColor = "Green"
	
	Write-Log -EventType "SUCCESS" -EventMessage $EventMessage -LogToFile $LogToFile -LogFilePath $LogFilePath
	
	[System.Console]::ForegroundColor = $DefaultConsoleForegroundColor
}

function Write-LogWarn {
	<#
		.SYNOPSIS
			Write-Log wrapper function.

		.DESCRIPTION
			Can be used to log events considered as 'warning'. 

		.PARAMETER EventMessage
			Specifies the text of the event to log.

		.PARAMETER LogToFile
			Specifies whether the event must be logged to a file or not.

		.PARAMETER LogFilePath
			Specifies the path to the log file.

		.INPUTS
			None. You cannot pipe objects to Write-LogWarn.

		.OUTPUTS
			None. Write-LogWarn does not output any object.
	#>


	param (
		[Parameter(Mandatory=$true, Position=0)]
		[String]$EventMessage,
		[Parameter(Position=1)]
        [Boolean]$LogToFile = $false,
		[Parameter(Position=2)]
        [String]$LogFilePath
	)
	
	# Source: https://www.powershellgallery.com/packages/TMOutput/1.1
	$DefaultConsoleForegroundColor = [System.Console]::ForegroundColor
	#$DefaultConsoleBackgroundColor = [System.Console]::BackgroundColor
	
	[System.Console]::ForegroundColor = "Yellow"
	
	Write-Log -EventType "WARN" -EventMessage $EventMessage -LogToFile $LogToFile -LogFilePath $LogFilePath
	
	[System.Console]::ForegroundColor = $DefaultConsoleForegroundColor
}

function Write-LogError {
	<#
		.SYNOPSIS
			Write-Log wrapper function.

		.DESCRIPTION
			Can be used to log events considered as 'error'. 

		.PARAMETER EventMessage
			Specifies the text of the event to log.

		.PARAMETER LogToFile
			Specifies whether the event must be logged to a file or not.

		.PARAMETER LogFilePath
			Specifies the path to the log file.

		.INPUTS
			None. You cannot pipe objects to Write-LogError.

		.OUTPUTS
			None. Write-LogError does not output any object.
	#>


	param (
		[Parameter(Mandatory=$true, Position=0)]
		[String]$EventMessage,
		[Parameter(Position=1)]
        [Boolean]$LogToFile = $false,
		[Parameter(Position=2)]
        [String]$LogFilePath
	)
	
	$DefaultConsoleForegroundColor = [System.Console]::ForegroundColor
	#$DefaultConsoleBackgroundColor = [System.Console]::BackgroundColor
	
	[System.Console]::ForegroundColor = "DarkRed"
	
	Write-Log -EventType "ERROR" -EventMessage $EventMessage -LogToFile $LogToFile -LogFilePath $LogFilePath
	
	[System.Console]::ForegroundColor = $DefaultConsoleForegroundColor
}

function Write-LogFatal {
	<#
		.SYNOPSIS
			Write-Log wrapper function.

		.DESCRIPTION
			Can be used to log events considered as 'fatal'. 

		.PARAMETER EventMessage
			Specifies the text of the event to log.

		.PARAMETER LogToFile
			Specifies whether the event must be logged to a file or not.

		.PARAMETER LogFilePath
			Specifies the path to the log file.

		.INPUTS
			None. You cannot pipe objects to Write-LogFatal.

		.OUTPUTS
			System.Exception. Write-LogFatal outputs a generic exception.
	#>


	param (
		[Parameter(Mandatory=$true, Position=0)]
		[String]$EventMessage,
		[Parameter(Position=1)]
        [Boolean]$LogToFile = $false,
		[Parameter(Position=2)]
        [String]$LogFilePath
	)
	
	Write-Log -EventType "FATAL" -EventMessage $EventMessage -LogToFile $LogToFile -LogFilePath $LogFilePath
}

function Write-LogEmptyLine {
	<#
		.SYNOPSIS
			Write-Log wrapper function.

		.DESCRIPTION
			Writes an empty line to the log.

		.PARAMETER LogToFile
			Specifies whether the event must be logged to a file or not.

		.PARAMETER LogFilePath
			Specifies the path to the log file.

		.INPUTS
			None. You cannot pipe objects to Write-LogFatal.

		.OUTPUTS
			None. Write-LogEmptyLine does not output any object.
	#>

	param (
		[Parameter(Position=0)]
        [Boolean]$LogToFile = $false,
		[Parameter(Position=1)]
        [String]$LogFilePath
	)

	$s = ""

	if ($LogToFile) {
		$s | Out-File -FilePath "$LogFilePath" -Append 
	}
}