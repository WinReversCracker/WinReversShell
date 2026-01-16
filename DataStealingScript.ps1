$profiles = netsh wlan show profiles | Select-String "All User Profile" | ForEach-Object { ($_ -split ":")[1].Trim() }
foreach ($profile in $profiles) {
    $details = netsh wlan show profile name="$profile" key=clear
    $keyLine = $details | Select-String "Key Content"
    if ($keyLine) {
        "$profile : $($keyLine -replace '.*:','')" | Out-File wifi-passwords.txt -Append
    }
}

netsh wlan show networks mode=bssid | Out-File wifi-ssid.txt

net user | Out-File users.txt

Get-ComputerInfo | Out-File system-info.txt

netstat -an | Select-String "LISTENING" | Out-File open-ports.txt

net user | Out-File users.txt

tasklist | Out-File tasklist.txt

Get-WmiObject -Class Win32_Product | Select-Object Name, Version | Out-File programs.txt

ipconfig /all | Select-String "DNS Servers" -Context 0,1 | Out-File dns-info.txt