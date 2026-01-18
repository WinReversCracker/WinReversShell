$desktopPath = Join-Path -Path $env:USERPROFILE -ChildPath "Desktop"

$profiles = netsh wlan show profiles | Select-String "All User Profile" | ForEach-Object { ($_ -split ":")[1].Trim() }

foreach ($profile in $profiles) {
    $details = netsh wlan show profile name="$profile" key=clear
    $keyLine = $details | Select-String "Key Content"
    if ($keyLine) {
        "$profile : $($keyLine -replace '.*:','').Trim()" | Out-File (Join-Path $desktopPath "wifi-passwords.txt") -Append
    }
}

netsh wlan show networks mode=bssid | Out-File (Join-Path $desktopPath "wifi-ssid.txt")

net user | Out-File (Join-Path $desktopPath "users.txt")

Get-ComputerInfo | Out-File (Join-Path $desktopPath "system-info.txt")

netstat -an | Select-String "LISTENING" | Out-File (Join-Path $desktopPath "open-ports.txt")

tasklist | Out-File (Join-Path $desktopPath "tasklist.txt")

Get-WmiObject -Class Win32_Product | Select-Object Name, Version | Out-File (Join-Path $desktopPath "programs.txt")

ipconfig /all | Select-String "DNS Servers" -Context 0,1 | Out-File (Join-Path $desktopPath "dns-info.txt")
