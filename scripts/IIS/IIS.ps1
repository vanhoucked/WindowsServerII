Install-WindowsFeature -name Web-Server -IncludeManagementTools
Set-Service -name "W3SVC" -StartupType Automatic

New-Item -ItemType Directory -Name "Website" -Path "C:\"
Copy-Item -Path "X:\html" -Destination "C:\Website" -Recurse

Remove-IISSite -Name "Default Web Site" -Confirm

New-IISSite -Name 'Website' -PhysicalPath 'C:\Website\html\' -BindingInformation "*:80:"