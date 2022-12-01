Set-ExecutionPolicy Unrestricted

#Toetsenbordindeling nl-BE als standaard gebruiken
$LanguageList = Get-WinUserLanguageList
$LanguageList.Add("nl-BE")
$LanguageList.Remove($LanguageList[0])
Set-WinUserLanguageList $LanguageList -Force