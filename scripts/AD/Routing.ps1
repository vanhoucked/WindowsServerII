$ip = "192.168.22.254"

Install-WindowsFeature RemoteAccess
Restart-Computer
Install-WindowsFeature RSAT-RemoteAccess-PowerShell
Install-WindowsFeature Routing
Restart-Computer

