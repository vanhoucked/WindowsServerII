#Toetsenbordindeling nl-BE als standaard gebruiken
$LanguageList = Get-WinUserLanguageList
$LanguageList.Add("nl-BE")
$LanguageList.Remove($LanguageList[0])
Set-WinUserLanguageList $LanguageList -Force

$LanguageList = Get-WinUserLanguageList
$LanguageList.Add("nl-BE")
$LanguageList.Remove($LanguageList[0])
Set-WinUserLanguageList $LanguageList -Force

Add-Computer -DomainName "WS2-2223-dre.hogent" #vraagt om credentials en reboot

Restart-Computer