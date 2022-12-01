$ouArray = "Management", "IT", "Accounting", "HR", "Sales"

Foreach ($groep in $ouArray) {
    New-ADOrganizationalUnit -Name $groep -Path "DC=WS2-2223-Dre,DC=hogent" 
    Set-ADOrganizationalUnit -Identity "OU=$groep,DC=WS2-2223-Dre,DC=hogent" -ProtectedFromAccidentalDeletion $False
    #protected geeft probleem
}

$Import = Import-CSV "users.csv"
$BasicOU = "DC=WS2-2223-Dre,DC=hogent"
 
Foreach ($user in $Import) {
    $password = $user.Wachtwoord | ConvertTo-SecureString -AsPlainText -Force
    $OU = "OU=" + $user.Afdeling + "," + $BasicOU
    New-ADUser -Name $user.Naam -GivenName $user.Voornaam -Surname $user.Achternaam -Path $OU -AccountPassword $password -ChangePasswordAtLogon $True -Enabled $True
}