

function Start-SFLogsCleanupAutomation {
    # Parameter help description
    param
    (
        [psobject]$Config
    )
    $cleanupsflogs = Get-EnabledEnvironmentAutomation -config $Config | Where-Object { $_.AutomationName -eq "CleanupSFLogs" }
    if ($cleanupsflogs) {
        if ($cleanupsflogs.AdditionalSettings.ControlFile) {
            Remove-D365LBDSFLogs -config $config -cleanupolderthandays $cleanupsflogs.AdditionalSettings.cleanupolderthandays -controlfile $cleanupsflogs.AdditionalSettings.ControlFile -verbose
        }
        else {
            Remove-D365LBDSFLogs -config $config -cleanupolderthandays $cleanupsflogs.AdditionalSettings.cleanupolderthandays -verbose
        }
    }
}