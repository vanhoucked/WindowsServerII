$ouArray = "Management", "IT", "Accounting", "HR", "Sales"

foreach ($ou in $ouArray) {
    New-ADOrganizationalUnit -Name $ou -Path "DC=WS2-2223-Dre,DC=hogent" –ProtectedFromAccidentalDeletion $False
}

$securePassword = ConvertTo-SecureString -String "HoGent2022" -AsPlainText -Force

New-ADUser -Name "Peter Griffin" -SamAccountName "pgriffin" -Path "OU=Management,DC=WS2-2223-Dre,DC=hogent" -Accountpassword $securePassword –Enabled $True
New-ADUser -Name "Stewie Griffin" -SamAccountName "sgriffin" -Path "OU=IT,DC=WS2-2223-Dre,DC=hogent" -Accountpassword $securePassword –Enabled $True
New-ADUser -Name "Joe Swanson" -SamAccountName "jswanson" -Path "OU=Accounting,DC=WS2-2223-Dre,DC=hogent" -Accountpassword $securePassword –Enabled $True
New-ADUser -Name "Glenn Quagmire" -SamAccountName "gquagmire" -Path "OU=Accounting,DC=WS2-2223-Dre,DC=hogent" -Accountpassword $securePassword –Enabled $True
New-ADUser -Name "Lois Griffin" -SamAccountName "lgriffin" -Path "OU=Management,DC=WS2-2223-Dre,DC=hogent" -Accountpassword $securePassword –Enabled $True