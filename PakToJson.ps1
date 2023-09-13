if ($args.Length -eq 0) {
    Write-Host "Please provide the directory path as a command-line argument."
    exit 1
}

$pakDirectory = $args[0]


if (-not (Test-Path -Path $pakDirectory -PathType Container)) {
    Write-Host "The specified directory does not exist: $pakDirectory"
    exit 1
}


$chunks = @()

$pakFiles = Get-ChildItem -Path $pakDirectory -Filter "*.pak"

$pattern = "\w+(\d+)-\w+\.pak"


foreach ($pakFile in $pakFiles) {
    if ($pakFile.Name -match $pattern) {
        $chunkID = $Matches[1]
    } else {
        $chunkID = $pakFile.BaseName
    }
    
    $fileContents = Get-Content -Path $pakFile.FullName -Raw
    $md5Hash = [System.Security.Cryptography.MD5]::Create().ComputeHash([System.Text.Encoding]::UTF8.GetBytes($fileContents))
    $md5HashHex = [BitConverter]::ToString($md5Hash) -replace '-'
    $chunkInfo = @{
        "ChunkID" = $chunkID
        "Name" = $pakFile.BaseName
        "Hash" = $md5HashHex.ToLower()
    }
    $chunks += $chunkInfo
}

$jsonData = @{
    "Chunks" = $chunks
}

$jsonFile = Join-Path -Path $pakDirectory -ChildPath "chunks.json"
$jsonString = ConvertTo-Json -InputObject $jsonData -Depth 4
$jsonString | Set-Content -Path $jsonFile

Write-Host "JSON file saved to $jsonFile"