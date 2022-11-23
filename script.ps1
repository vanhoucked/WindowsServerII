#Variabelen voor script bepalen
$userName = [System.Environment]::UserName

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
    } catch {
        Write-Output "Er gebeurde een fout tijdens het aanmaken van " $vm
    }
    
}
try {
    VBoxManage createvm --name=$Client --ostype="Windows10_64" --register
} catch {
    Write-Output "Er gebeurde een fout tijdens het aanmaken van " $Client
}


#Virtuele opslagapparaten aanmaken
foreach ($vm in $vmArray) {
    try {
        $grootteMB = $opslagTable.$vm * 1024 #MiB?
        VBoxManage createmedium --filename=$vm.vdi --size=$grootteMB
        VBoxManage storagectl $vm --name="SATA Controller"$vm --add=sata --controller=IntelAHCI
        VBoxManage storageattach $vm --storagectl="SATA Controller"$vm --port=0 --device=0 --type=hdd --medium=$vm.vdi
        Write-Output "Virtuele harde schijf aangemaakt voor $vm met een grootte van $grootteMB MB" 
    } catch {
        Write-Output "Er gebeurde een fout tijdens het aanmaken van de harde schijf voor " $vm
    }
    
}

#Geheugen toekennen
foreach ($vm in $vmArray) {
    try {
        $geheugenMB = $geheugenTable.$vm * 1024
        VBoxManage modifyvm $vm --memory=$geheugenMB
        Write-Output $geheugenMB " MB werkgeheugen toegekend aan " $vm
    } catch {
        Write-Output "Er gebeurde een fout tijdens het toekennen van werkgeheugen aan " $vm
    }
}

#vCPU cores toekennen

#netwerkinstellingen
foreach ($vm in $vmArray) {
    try {
        VBoxManage modifyvm $vm --nic1=intnet
        Write-Output "Intnet netwerkkaart toegevoegd aan " $vm
    } catch {
        Write-Output "Er gebeurde een fout tijdens het toekennen van de intnet netwerkkaart aan " $vm
    }
}
try {
    VBoxManage modifyvm $vm --nic2=nat
    Write-Output "NAT netwerkkaart toegevoegd aan " $vm
} catch {
    Write-Output "Er gebeurde een fout tijdens het toekennen van de NAT netwerkkaart aan " $vm
}