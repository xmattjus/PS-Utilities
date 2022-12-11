<#
	.SYNOPSIS
		Tests if a folder exists and is writable.

	.DESCRIPTION
		Tests if a folder exists and is writable. If the folder does not exist it will be created.

	.PARAMETER Path
		Specifies the path to test.

	.INPUTS
		None. You cannot pipe objects to Test-Folder.

	.OUTPUTS
		System.Exception. Test-Folder throws a generic exception if the folder cannot be created.

	.NOTES
		Author: Benito Matteo Bercini
		Version: 1.2
#>


function Test-Folder {

	param (
		[Parameter(Mandatory=$true)]
		[string]$Path
	)

	<#
		Test-Folder
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

	$TestFileName = "WriteTest-" + [guid]::NewGuid()
	
	$TestPath = (Join-Path $Path $TestFileName)
	
	# Check if string is null
	if ("$Path" -eq $null) {
		throw "No path has been specified"
	}

	# Check if string is empty
	if ("$Path" -eq "") {
		throw "The path specified is not correct"
	}

	# Check if string is whitespace
	if ("$Path" -match "\s*") {
		throw "The path specified is not correct"
	}

	if (Test-Path "$Path" -PathType Leaf) {
		throw "The path specified is not a folder: $Path"
	}
	
	try {
		# Try to create the folder if it doesn't exist already
		if (-not ([System.IO.Directory]::Exists("$Path"))) {
			New-Item -ItemType Directory -Path "$Path" -ErrorAction SilentlyContinue | Out-Null
		}
	} catch {
		throw "The path specified cannot be created: $Path"
	}
	
	try {
		# Try to create a temporary file in the folder
		[System.IO.File]::OpenWrite("$TestPath").Close()
		
		# Try to delete the temporary file
		Remove-Item -ErrorAction SilentlyContinue $TestPath
	} catch {
		throw "No write access to the path: $Path"
	}
}