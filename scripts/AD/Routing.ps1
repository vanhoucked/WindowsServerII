Install-WindowsFeature Routing -IncludeManagementTools
Install-RemoteAccess -VpnType RoutingOnly

cmd.exe /c "netsh routing ip nat install"
cmd.exe /c "netsh routing ip nat add interface WAN mode=full"
cmd.exe /c "netsh routing ip nat add interface LAN mode=private"
cmd.exe /c "sc config remoteaccess start=auto"

$FQDN = "Zeus.WS2-2223-dre.hogent"
$ip = "192.168.22.254"

Install-WindowsFeature DHCP -IncludeManagementTools
Restart-Service dhcpserver

#deel hieronder geeft ergens foutmelding => wrs DNS
Add-DhcpServerInDC -DnsName $FQDN -IPAddress $ip

Add-DhcpServerSecurityGroup
Add-DhcpServerv4Scope -Name "DHCPScope" -StartRange 192.168.22.101 -EndRange 192.168.22.150 -SubnetMask 255.255.255.0 -State Active
$dnsArray = "1.1.1.1","8.8.8.8","8.8.4.4"
Set-DhcpServerv4OptionValue -ScopeId "DHCPScope" -DnsServer $dnsArray

Restart-Computer