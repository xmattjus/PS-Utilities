<#
	.SYNOPSIS
		A wrapper for Start-Process that shows an 'indefinite' progress bar while the process is running.

	.DESCRIPTION
		A wrapper for Start-Process that shows an 'indefinite' progress bar while the process is running.

	.PARAMETER FilePath
		Specifies the process name (e.g. cmd.exe) or filepath of the program to be started.

	.PARAMETER ArgumentList
		Specifies the process arguments to be used.

	.PARAMETER PassThru
		TODO

	.PARAMETER NoNewWindow
		Start the new process in the current console window.
		By default on Windows systems PowerShell opens a new window. On non-Windows systems the process starts in the same console window.

	.PARAMETER ProgressActivity
		Specifies the first line of text in the heading above the status bar. This text describes the activity whose progress is being reported.

	.PARAMETER ProgressStatus
		Specifies the second line of text in the heading above the status bar. This text describes current state of the activity.

	.INPUTS
		None. You cannot pipe objects to Start-ProcessWithProgress.ps1.

	.OUTPUTS
		System.Int. Start-ProcessWithProgress.ps1 outputs the process exit code.

	.EXAMPLE
		PS> .\Start-ProcessWithProgress -FilePath "powershell"

	.NOTES
		Author: Benito Matteo Bercini
		Version: 1.1
#>


function Start-ProcessWithProgress {

    param (
		[Parameter(Mandatory=$true)]
        [string]$FilePath,
        [string[]]$ArgumentList,
        [switch]$PassThru,
        [switch]$NoNewWindow,
        [string]$ProgressActivity,
        [string]$ProgressStatus
    )

	<#
		Start-ProcessWithProgress
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

    $ProcessOptions = @{
		FilePath = $FilePath
		ArgumentList = $ArgumentList
		PassThru = $PassThru
		NoNewWindow = $NoNewWindow
	}

	# TODO Implement logic for the PassThru switch. If the function is not invoked with this parameter,
	# Start-Process will not output the Process object and the exit code must be fetched in another way ($LastExitCode).
	if (-not $PassThru) {
		throw 'Not yet implemented.'
	}

    $Process = Start-Process @ProcessOptions
	$ProcessHandle = $Process.Handle # Source: https://stackoverflow.com/a/23797762

    for($i = 0; $i -le 100; $i = ($i + 1) % 100) {
        Write-Progress -Activity "$ProgressActivity" -PercentComplete $i -Status "$ProgressStatus"

        Start-Sleep -Milliseconds 200

        if ($Process.HasExited) {
            Write-Progress -Activity "$ProgressActivity" -Completed

            break
        }
    }

	return $Process.ExitCode
}