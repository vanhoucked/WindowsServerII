Add-DnsServerForwarder -IPAddress 1.1.1.1
Add-DnsServerForwarder -IPAddress 8.8.8.8

$domein = "WS2-2223-dre.hogent"

#Reverse lookup zone aanmaken
Add-DnsServerPrimaryZone -NetworkID "192.168.22.0/24" -ZoneFile "22.168.192.in-addr.arpa.DNS"

#A-records voor alle servers maken, behalve AD Zeus aangezien die al bestaat
Add-DnsServerResourcerecordA -Name "Apollo" -ZoneName $domein -IPv4Address "192.168.22.253"
Add-DnsServerResourcerecordA -Name "Artemis" -ZoneName $domein -IPv4Address "192.168.22.252"
Add-DnsServerResourcerecordA -Name "Hermes" -ZoneName $domein -IPv4Address "192.168.22.251"

#PTR records voor reverse lookup maken voor alle servers
Add-DnsServerResourcerecordPtr -Name "254" -ZoneName "22.168.192.in-addr.arpa" -PtrDomainName "Zeus.$domein"
Add-DnsServerResourcerecordPtr -Name "253" -ZoneName "22.168.192.in-addr.arpa" -PtrDomainName "Apollo.$domein"
Add-DnsServerResourcerecordPtr -Name "252" -ZoneName "22.168.192.in-addr.arpa" -PtrDomainName "Artemis.$domein"
Add-DnsServerResourcerecordPtr -Name "251" -ZoneName "22.168.192.in-addr.arpa" -PtrDomainName "Hermes.$domein"

#CNAME (alias) record maken voor de webserver
Add-DnsServerResourceRecordCName -Name "www" -HostNameAlias "artemis.$domein" -ZoneName $domein

#Mail?