# Define the path to the .reg file
$regFilePath = "C:\Users\mikex\Documents\PowerShell\Lxss.reg"

# Read the contents of the .reg file
$regFileContent = Get-Content -Path $regFilePath

# Initialize variables to hold the parsed information
$rootKey = $null
$currentKey = $null
$registryData = @{}

foreach ($line in $regFileContent) {
    if ($line -match '^

\[.*\]

$') {
        # This line represents a registry key
        $keyPath = $line.Trim('[', ']')
        if (-not $rootKey) {
            $rootKey = $keyPath
        }
        $currentKey = $keyPath
        $registryData[$currentKey] = @{}
    } elseif ($line -match '^(.*)=(.*)$') {
        # This line represents a property
        $name, $value = $line -split '=', 2
        $name = $name.Trim()
        $value = $value.Trim()
        $registryData[$currentKey][$name] = $value
    }
}

# Create the custom object representation
$lxssObject = New-Object PSObject -Property @{
    Path = $rootKey
    SubKeys = @()
    Properties = @()
}

foreach ($key in $registryData.Keys) {
    $subKeyObject = New-Object PSObject -Property @{
        Path = $key
        Properties = @()
    }
    foreach ($property in $registryData[$key].Keys) {
        $propertyObject = New-Object PSObject -Property @{
            Name = $property
            Value = $registryData[$key][$property]
        }
        $subKeyObject.Properties += $propertyObject
    }
    $lxssObject.SubKeys += $subKeyObject
}

# Output the custom object
$lxssObject

# Access a specific distribution object
$lxssDistroObject = $lxssObject.SubKeys | Where-Object { $_.Path -match '\{[0-9a-fA-F-]+\}' }
$lxssDistroObject

