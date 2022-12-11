<#
	.SYNOPSIS
		Tests if the script has administrator rights.

	.DESCRIPTION
		Test-AdminRights checks whether the current console session has been run as administrator. 

	.INPUTS
		None. You cannot pipe objects to Test-AdminRights.ps1.

	.OUTPUTS
		System.Bool. Test-AdminRights.ps1 returns $true if a user is an administrator, $false otherwise.
	
	.NOTES
		Author: Benito Matteo Bercini
		Version: 1.1
#>


function Test-AdminRights {

	<#
		Test-AdminRights
		Copyright (C) 2022  Benito Matteo Bercini

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

	# Source: https://devblogs.microsoft.com/scripting/use-function-to-determine-elevation-of-powershell-console/
	$id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
	$p = New-Object System.Security.Principal.WindowsPrincipal($id)
	return ($p.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator))
}