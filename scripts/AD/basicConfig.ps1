Unblock-File AD.ps1
Unblock-File addUsers.ps1
Unblock-File DNS.ps1
Unblock-File Routing.ps1

#Toetsenbordindeling nl-BE als standaard gebruiken
$LanguageList = Get-WinUserLanguageList
$LanguageList.Add("nl-BE")
$LanguageList.Remove($LanguageList[0])
Set-WinUserLanguageList $LanguageList -Force

#Netwerkadapters
$ip = "192.168.22.254"

Rename-NetAdapter "Ethernet" -NewName "LAN"
Rename-NetAdapter "Ethernet 2" -NewName "WAN"

Get-NetAdapter -Name "LAN" | New-NetIPAddress -IPAddress $ip -AddressFamily IPv4 -PrefixLength 24