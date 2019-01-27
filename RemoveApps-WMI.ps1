#echo Searching for target installers and invoking a removal, as would be done in Add / Remove Programs.

$boxName = $env:COMPUTERNAME
$pathToLog = Get-Location

# Enter name as it is presented in Add Remove Programs list.
$appZabbixDrop = Get-WmiObject -Class Win32_Product -Filter "Name = 'Zabbix Agent'"
$appScrConDrop = Get-WmiObject -Class Win32_Product -Filter "Name like 'ScreenConnect%'"

# Call the uninstallers for each match.

Write-Output "Zabbix State:"
$appZabbixDrop.Uninstall()

Write-Output "ScreenConnect:"
$appScrConDrop.Uninstall()

Write-Warning "If you get Red Error about 'null-valued expression', App is likely not on said machine."