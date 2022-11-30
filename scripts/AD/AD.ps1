$domain = "WS2-2223-dre.hogent"
$netBiosName = "WS2-2223-dre"

Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

Install-ADDSForest -DomainName $domain -DomainNetBiosName $netBiosName -InstallDns:$true -Confirm:$false #vraagt om wachtwoord

Restart-Computer