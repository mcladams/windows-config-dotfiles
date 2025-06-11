# GroupedComputerInfo.ps1 - source this file
# Retrieve computer info properties
#$compInfo = Get-ComputerInfo -Property "*version","*name","*ID","*type"
$compInfo = Get-ComputerInfo

# Process and split property names
$groupedProperties = $compInfo.PSObject.Properties | ForEach-Object {
    $propertyName = $_.Name
	# Split before the second capital letter
	if ($propertyName -cmatch '^(?<Prefix>[A-Z][a-z]+)(?=[A-Z])') {
		$groupName = switch -CaseSensitive ($Matches.Prefix) {
			"Bios" { "Bios" }
			"Cs" { "Machine" }
			"Device" { "DeviceGuard" }
			"Hyper" { "HyperV" }
			"Logon" { "OS" }
			"Os" { "System" }
			"Time" { "Locale" }
			"Windows" { "Windows" }
			Default { $Matches.Prefix }
		}

		[PSCustomObject]@{
            GroupName = $groupName
            PropertyName = $propertyName
            Value = $_.Value
        }
    }
}

# Display grouped properties
$groupedProperties | Sort-Object GroupName | Format-Table GroupName, PropertyName, Value