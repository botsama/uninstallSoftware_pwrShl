#Poll Registry to find installed programs, that do not show as WMI installs.
# This script will find both WMI (typically .msi) installs and the Wow6432Node (Non-MSI)
# If it finds a WMI installer, suggested to run 'RemoveApps.ps1' as it will cleanly invoke Win32_Product.
# As for Wow6432Node results... Not so clean. Uninstall.log will have uninstaller path to execute.

$boxName = $env:COMPUTERNAME
$pathToLog = Get-Location
$appUninReg = Get-ItemProperty -Path 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
$appUninRegWow = Get-ItemProperty -Path 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
# Change below for app name pattern to look for.
$findAppStr = '*TrashAppName*'
$appNameOutput = $findAppStr.Trim('*')

# Default Reg Tree / MSI
Write-Output "Default Uninstall Tree on $boxName :"
$foundCurVer01 = $appUninReg | Where DisplayName -like $findAppStr
#echo Filter output to give relevant strings.
Write-Output $foundCurVer01 | Format-Table -Property DisplayName, UninstallString -Wrap
Write-Output "Also outputting to $pathToLog\Found $appNameOutput Installers (WMI).log"
$foundCurVer01 | Format-Table -Property DisplayName, UninstallString -Wrap | Out-File -FilePath "$pathToLog\Found $appNameOutput Programs (in WMI) on $boxName.log"

Write-Output "`n"
Write-Warning "If nothing above, you need to manually invoke uninstaller with the below UninstallString."
Write-Output "`n"

# Non-MSI / WMI method search
Write-Output "Wow6432Node Tree on $boxName :"
$foundCurVer02 = $appUninRegWow | Where DisplayName -like $findAppStr
#echo Filter output to give relevant strings.
Write-Output $foundCurVer02 | Format-Table -Property DisplayName, UninstallString -Wrap
Write-Output "Also outputting to $pathToLog\Found $appNameOutput Wow6432Node Installers.log"
$foundCurVer02 | Format-Table -Property DisplayName, UninstallString -Wrap | Out-File -FilePath "$pathToLog\Found $appNameOutput Wow6432Node Programs on $boxName - Table.log"
# Write-Output $foundCurVer02 | Format-Table -Property UninstallString -Wrap | Out-File -FilePath "$pathToLog\Found Wow6432Node Table - Just Uninstall Str on $boxName.log"
# Writes the raw output string so we do not have to determine spaces and line breaks from 'Format-Table' display.
Write-Output $foundCurVer02.UninstallString | Out-File -Encoding ASCII -FilePath "$pathToLog\Uninstall $appNameOutput String on $boxName.log"