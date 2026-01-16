$desktopPath = [System.IO.Path]::Combine($env:USERPROFILE, 'Desktop'); `
$profiles = netsh wlan show profiles | Select-String "All User Profile" | ForEach-Object { ($_ -split ":")[1].Trim() }; `
$profiles | ForEach-Object { `
    $keyLine = netsh wlan show profile name="$_" key=clear | Select-String "Key Content"; `
    if ($keyLine) { "$_ : $($keyLine -replace '.*:','').Trim()" | Out-File "$desktopPath\wifi-passwords.txt" -Append -Encoding UTF8 } `
}; `
netsh wlan show networks mode=bssid | Out-File "$desktopPath\wifi-ssid.txt" -Encoding UTF8; `
net user | Out-File "$desktopPath\users.txt" -Encoding UTF8; `
Get-ComputerInfo | Out-File "$desktopPath\system-info.txt" -Encoding UTF8; `
netstat -an | Select-String "LISTENING" | Out-File "$desktopPath\open-ports.txt" -Encoding UTF8; `
tasklist | Out-File "$desktopPath\tasklist.txt" -Encoding UTF8; `
Get-CimInstance -ClassName Win32_Product | Select-Object Name, Version | Out-File "$desktopPath\programs.txt" -Encoding UTF8; `
ipconfig /all | Select-String "DNS Servers" -Context 0,1 | Out-File "$desktopPath\dns-info.txt" -Encoding UTF8
