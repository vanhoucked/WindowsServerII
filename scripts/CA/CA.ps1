Install-WindowsFeature ADCS-Cert-Authority -IncludeManagementTools

Install-ADcsCertificationAuthority -CAType "StandaloneRootCA" –Force