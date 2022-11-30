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
Add-DhcpServerInDC -DnsName $FQDN -IPAddress $ip

Add-DhcpServerSecurityGroup
Add-DhcpServerv4Scope -Name "DHCPScope" -StartRange 192.168.22.50 -EndRange 192.168.22.100 -SubnetMask 255.255.255.0 -State Active
Set-DhcpServerv4OptionValue -OptionID 3 -Value 192.168.22.254 -ScopeID 192.168.22.0
Set-DhcpServerv4OptionValue -DnsServer $FQDN