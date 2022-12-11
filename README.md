# PS-Utilities
> Various PowerShell utilities to be used in other projects.

## Write-Log
A simple logging utility for PowerShell.

Used to write an event to the console and (optionally) to a file. Wrapper functions for 'standard' events are provided (e.g. 'INFO', 'SUCCESS', 'WARN', 'ERROR', 'FATAL').


## Test-Folder
Tests if a folder exists and is writable. If the folder does not exist it will be created.


## Test-AdminRights
Tests if the script has administrator rights.


## Test-StringNullOrWhiteSpace
Tests if a string is null, empty or whitespace.


## Start-ProcessWithProgress
A wrapper function for Start-Process that shows an 'indefinite' progress bar while the process is running.


## Test-PathName
Tests for valid path and files names.

Returns two lists, one of valid path names and one with the invalid path names (e.g. empty strings, strings with illegal path characters, etc). 
Please note that this script only tests if invalid characters are contained in a path, not if the path does exist or not in the file system.