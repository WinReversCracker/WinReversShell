$desktopPath = [System.IO.Path]::Combine($env:USERPROFILE, 'Desktop')


$profiles = netsh wlan show profiles | Select-String "All User Profile" | ForEach-Object { ($_ -split ":")[1].Trim() }
foreach ($profile in $profiles) {
    $details = netsh wlan show profile name="$profile" key=clear
    $keyLine = $details | Select-String "Key Content"
    if ($keyLine) {
        "$profile : $($keyLine -replace '.*:','')" | Out-File "$desktopPath\wifi-passwords.txt" -Append
    }
}

netsh wlan show networks mode=bssid | Out-File "$desktopPath\wifi-ssid.txt"

net user | Out-File "$desktopPath\users.txt"

Get-ComputerInfo | Out-File "$desktopPath\system-info.txt"

netstat -an | Select-String "LISTENING" | Out-File "$desktopPath\open-ports.txt"

tasklist | Out-File "$desktopPath\tasklist.txt"

Get-WmiObject -Class Win32_Product | Select-Object Name, Version | Out-File "$desktopPath\programs.txt"

ipconfig /all | Select-String "DNS Servers" -Context 0,1 | Out-File "$desktopPath\dns-info.txt"
