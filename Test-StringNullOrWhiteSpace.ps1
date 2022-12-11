<#
	.SYNOPSIS
		Tests if a string is null, empty or whitespace.

	.DESCRIPTION
		Tests if a string is null, empty or whitespace. On newer .NET Framework versions [string]::IsNullOrWhiteSpace() is recommended.

	.PARAMETER String
		Specifies the string to check.

	.INPUTS
		None. You cannot pipe objects to Test-StringNullOrWhiteSpace.ps1

	.OUTPUTS
		System.Bool. Test-StringNullOrWhiteSpace.ps1 returns $true if a string is not null, empty or whitespace. $false otherwise.

	.EXAMPLE
		PS> .\Test-StringNullOrWhiteSpace.ps1 "Valid test string"
        True

		PS> .\Test-StringNullOrWhiteSpace.ps1 ""
        False

		PS> .\Test-StringNullOrWhiteSpace.ps1 "   "
        False

	.NOTES
		Author: Benito Matteo Bercini
		Version: 1.0
#>


param (
	[Parameter(Mandatory=$true)]
    [string]$String
)

<#
    Test-StringNullOrWhiteSpace. Tests if a string is null, empty or whitespace.
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

# 
$ErrorActionPreference='Stop'

[bool]$IsValidString = $true

# Check if string is null
if ($String -eq $null) {
    $IsValidString = $false
}

# Check if string is empty
if ($String -eq "") {
    $IsValidString = $false
}

# Check if string is whitespace
if ($String -match "\s*") {
    $IsValidString = $false
}

return $IsValidString