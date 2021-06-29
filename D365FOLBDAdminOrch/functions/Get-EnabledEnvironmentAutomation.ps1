
function Get-EnabledEnvironmentAutomation {
    # Parameter help description
    param
    (
    [psobject]$Config
    )

    $additionalPath = Join-Path $($config.AgentShareLocation) "scripts\D365FOLBDAdmin\AdditionalEnvironmentDetails.xml"
    $additionalenvironmentdetails = get-childitem $additionalPath

    [xml]$xml = Get-Content $additionalenvironmentdetails.FullName

    $enabledautomation = $xml.D365FOLBDEnvironment.Automation.ChildNodes | Where-Object { $_.Enabled -eq $true }
    $enabledautomationhash = @()
    foreach ($automation in $enabledautomation) {
        $automationname = $automation.LocalName
        $Frequency = $automation.$Frequency
        $properties = $automation | Get-Member | Where-Object { $_.MemberType -eq "Property" } | Select-Object Name
        $properties = $properties | Where-Object { $_ -notlike "*#comment*" -and $_ -ne "$($automationname.Trim())" -and $_ -notlike "*Enabled*" -and $_ -notlike "*Frequency*" }

        $propertyoptions = @()
        $hash = $null

        $hash = @{}

        foreach ($property in $properties) {
            $propertyoptions = $automation.$($property.name)
            $hash.Add($($property.name), $propertyoptions)

        }
        $properties = @{
            AutomationName     = $automationname
            Frequency          = $Frequency
            AdditionalSettings = $hash
        }

        $hash = New-Object psobject -Property $properties
        $enabledautomationhash += $hash

    }
    $enabledautomationhash
}