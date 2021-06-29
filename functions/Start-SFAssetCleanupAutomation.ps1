

function Start-SFAssetCleanupAutomation{
    # Parameter help description
    param
    (
        [psobject]$Config
    )
    $cleanupsfassets = Get-EnabledEnvironmentAutomation -config $Config | Where-Object { $_.AutomationName -eq "CleanupSFLogs" }
    if ($cleanupsfassets) {
        if ($cleanupsfassets.AdditionalSettings.ControlFile) {
            Remove-D365LBDSFOldAssets -config $config -NumberofAssetsToKeep $cleanupsfassets.AdditionalSettings.AssetsToKeep -controlfile $cleanupsfassets.AdditionalSettings.ControlFile -verbose
        }
        else {
            Remove-D365LBDSFOldAssets -config $config -NumberofAssetsToKeep $cleanupsfassets.AdditionalSettings.AssetsToKeep -verbose
        }
    }
}