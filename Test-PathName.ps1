<#
	.SYNOPSIS
		Tests for valid path names.

	.DESCRIPTION
		Tests for valid path and files names.
	
		Returns two lists, one of valid path names and one with the invalid path names (e.g. empty strings, strings with illegal path characters, etc). 
		Please note that Test-PathName only tests if invalid characters are contained in a path, not if the path really exists in the file system or not.

	.PARAMETER PathList
		Specifies a list of paths to test.

	.INPUTS
		None. You cannot pipe objects to Test-PathName.

	.OUTPUTS
		PSObject. Test-PathName outputs an object containing two ArrayLists, one of valid path names and the other of invalid path names.

	.NOTES
		Author: Benito Matteo Bercini
		Version: 1.1
#>


function Test-PathName {

	param(
		[Parameter(Mandatory=$true)]
		[System.Collections.ArrayList]$PathList
	)

	<#
		Test-PathName
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

	begin {
		# Create a regex query string of illegal folder path and file name characters. The output of the .NET GetInvalidPathChars() and
		# GetInvalidFileNameChars() functions is a character array that will be mapped to a string without spaces with -join ''.
		# Source: https://stackoverflow.com/a/23067832
		$IllegalPathChars = "[{0}]" -f [Regex]::Escape(([System.IO.Path]::GetInvalidPathChars() -join ''))
		$IllegalFileNameChars = "[{0}]" -f [Regex]::Escape(([System.IO.Path]::GetInvalidFileNameChars() -join ''))
	}

	process {
		$ValidPathNameList = New-Object -TypeName "System.Collections.ArrayList" 
        $IllegalPathNameList = New-Object -TypeName "System.Collections.ArrayList"
		
		$PathList.foreach({
			if (-not ([string]::IsNullOrWhiteSpace("$_"))) {
				if (-not ((Split-Path -Path "$_" -Parent | Select-String -Pattern $IllegalPathChars) -or `
				(Split-Path -Path "$_" -Leaf | Select-String -Pattern $IllegalFileNameChars))) {
					$ValidPathNameList.Add("$_") > $null
				} else {
					$IllegalPathNameList.Add("$_") > $null
				}	
			}
		})
		
		# Source: https://devblogs.microsoft.com/scripting/create-custom-objects-in-your-powershell-script/
        $Result = @{
            ValidPathNames = $ValidPathNameList
            IllegalPathNames = $IllegalPathNameList
        }

        New-Object PSObject -Property $Result
	}
}