$iso = "X:\Exchange.iso"
$image = Mount-DiskImage -ImagePath $iso -NoDriveLetter

$volInfo = $image | Get-Volume

mountvol "E:" $volInfo.UniqueId

E:\Setup.exe /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF /mode:Install /r:MB