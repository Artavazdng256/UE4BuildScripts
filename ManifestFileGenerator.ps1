# Define the folder path
$folderPath = "./"

# Get a list of files in the folder
$files = Get-ChildItem -Path $folderPath

# Define the path for the text file based on the file name
$textFilePath = Join-Path -Path $folderPath -ChildPath "BuildManifest-Windows.txt"

$Version = 1001

$scriptPath = $MyInvocation.MyCommand.Path
# Extract the script file name from the full path
$scriptFileName = [System.IO.Path]::GetFileName($scriptPath)

$NUM_ENTRIES_COUNT = 0

$FILE_BODY_CONTENT = ""

# Loop through each file and create the text file
foreach ($file in $files) {
	# Extract the file name without extension
	$fileNameWithoutExtension = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
	if ("BuildManifest-Windows.txt" -ne $file -and $scriptFileName -ne $file) {
		write-host $scriptFileName
		# Extract the file size
		$fileSize = $file.Length

		# Construct the content for the text file
		$content = "$fileNameWithoutExtension    $fileSize   ver $Version    /Windows/$file"

		# Append the current file's content to the output content
		$FILE_BODY_CONTENT += "$Content`r`n" 
		$NUM_ENTRIES_COUNT += 1
	}

}

$outputContent += "`$NUM_ENTRIES = $NUM_ENTRIES_COUNT`r`n"
$outputContent += "`$BUILD_ID = PatchingDemoKey`r`n"
$outputContent += "$FILE_BODY_CONTENT`r`n"

# Create the text file with the generated content
Set-Content -Path $textFilePath -Value $outputContent

