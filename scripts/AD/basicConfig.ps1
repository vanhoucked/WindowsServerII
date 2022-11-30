#Toetsenbordindeling nl-BE als standaard gebruiken
$LanguageList = Get-WinUserLanguageList
$LanguageList.Add("nl-BE")
$LanguageList.Remove($LanguageList[0])
Set-WinUserLanguageList $LanguageList

#Netwerkadapters
$ip = "192.168.22.254"

Rename-NetAdapter "Ethernet" -NewName "WAN"
Rename-NetAdapter "Ethernet 2" -NewName "LAN"

Get-NetAdapter -Name "LAN" | New-NetIPAddress -IPAddress $ip -AddressFamily IPv4 -PrefixLength 24