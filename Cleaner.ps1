Remove-MpThreat -All -Force

wevtutil el | ForEach-Object { wevtutil cl "$_" }

Remove-Item C:\Windows\Prefetch\* -Force

Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
