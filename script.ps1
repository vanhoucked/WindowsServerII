#Hostnames van virtuele machines definiëren
$AD = "Zeus"
$CA = "Apollo"
$IIS = "Artemis"
$Exchange = "Hermes"
$Client = "Client"

#Groottes opslagapparaten bepalen
$opslagTable = @{$AD=75;$CA=50;$IIS=100;$Exchange=100;$Client=50}
#vRAM bepalen
$geheugenTable = @{$AD=4;$CA=1;$IIS=2;$Exchange=8;$Client=4}
#vCPU bepalen
$processorTable = @{$AD=2;$CA=1;$IIS=1;$Exchange=4;$Client=2}

$vmArray = $AD,$CA,$IIS,$Exchange,$Client
$serverArray = $AD,$CA,$IIS,$Exchange

#VM's aanmaken
foreach ($vm in $serverArray) {
    try {
        VBoxManage createvm --name=$vm --ostype="Windows2019_64" --register
        Write-Output "[CREATIE MELDING] $vm werd aangemaakt."
    } catch {
        Write-Output "[CREATIE MELDING] Er gebeurde een fout tijdens het aanmaken van $vm."
    }
    
}
try {
    VBoxManage createvm --name=$Client --ostype="Windows10_64" --register
    Write-Output "[CREATIE MELDING] $Client werd aangemaakt."
} catch {
    Write-Output "[CREATIE MELDING] Er gebeurde een fout tijdens het aanmaken van $Client."
}


#Virtuele opslagapparaten aanmaken
foreach ($vm in $vmArray) {
    try {
        $grootteMB = $opslagTable.$vm * 1024
        VBoxManage createmedium --filename=/vdi/$vm.vdi --size=$grootteMB
        VBoxManage storagectl $vm --name="SATA Controller $vm" --add sata --controller=IntelAHCI
        VBoxManage storageattach $vm --storagectl="SATA Controller $vm" --port=0 --type hdd --medium=/vdi/$vm.vdi
        Write-Output "[OPSLAG MELDING] Virtuele harde schijf aangemaakt voor $vm met een grootte van $grootteMB MB." 
    } catch {
        Write-Output "[OPSLAG MELDING] Er gebeurde een fout tijdens het aanmaken van de harde schijf voor $vm."
    }
}

#iso toevoegen
foreach ($vm in $serverArray) {
    try {
        VBoxManage storagectl $vm --name="IDE Controller $vm" --add ide
        VBoxManage storageattach $vm --storagectl="IDE Controller $vm" --port=1 --type dvddrive --medium=/iso/Windows2019.iso
        Write-Output "[OPSLAG MELDING] ISO gemount aan $vm."
    } catch {
        Write-Output "[OPSLAG MELDING] Er gebeurde een fout tijdens het mounten van de iso aan $vm."
    }
}
try {
    VBoxManage storagectl $Client --name="IDE Controller $Client" --add ide
    VBoxManage storageattach $Client --storagectl="IDE Controller $Client" --port=1 --type dvddrive --medium=/iso/Windows10.iso
    Write-Output "[OPSLAG MELDING] ISO gemount aan $Client."
} catch {
    Write-Output "[OPSLAG MELDING] Er gebeurde een fout tijdens het mounten van de iso aan $Client."
}

#Geheugen toekennen
foreach ($vm in $vmArray) {
    try {
        $geheugenMB = $geheugenTable.$vm * 1024
        VBoxManage modifyvm $vm --memory=$geheugenMB
        Write-Output "[RAM MELDING] $geheugenMBMB werkgeheugen toegekend aan $vm."
    } catch {
        Write-Output "[RAM MELDING] Er gebeurde een fout tijdens het toekennen van werkgeheugen aan $vm."
    }
}

#vCPU cores toekennen
foreach ($vm in $vmArray) {
    try {
        VBoxManage modifyvm $vm --cpus $processorTable.$vm
        Write-Output "[CPU MELDING] $processorTable.$vm cores toegekend aan $vm."
    } catch {
        Write-Output "[CPU MELDING] Er gebeurde een fout tijdens het toekennen van de processorkernen aan $vm."
    }
}

#netwerkinstellingen
foreach ($vm in $vmArray) {
    try {
        VBoxManage modifyvm $vm --nic1=intnet
        Write-Output "[NETWERK MELDING] Intnet netwerkkaart toegevoegd aan $vm."
    } catch {
        Write-Output "[NETWERK MELDING] Er gebeurde een fout tijdens het toekennen van de intnet netwerkkaart aan $vm."
    }
}
try {
    VBoxManage modifyvm $AD --nic2=nat
    Write-Output "[NETWERK MELDING] NAT netwerkkaart toegevoegd aan $AD."
} catch {
    Write-Output "[NETWERK MELDING] Er gebeurde een fout tijdens het toekennen van de NAT netwerkkaart aan $AD."
}