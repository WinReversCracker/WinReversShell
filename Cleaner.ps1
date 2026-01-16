wevtutil el | ForEach-Object { wevtutil cl "$_" }

Remove-MpThreat -All -Force

Remove-Item C:\Windows\Prefetch\* -Force

Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

