# Audio Devices Disconnections and Connections System | Maor Idi

$beforeUSB = Get-PnpDevice -PresentOnly | Where-Object  { $_.Class -match '^MEDIA' }

$beforeLength = $beforeUSB.Length

$afterUSB = $beforeUSB
$afterUSBLength = $beforeUSBLength

$amount = 0

$computerName = hostname

for ($i = 0; $i -lt $beforeUSB.Length; $i++){
    Write-Host $beforeUSB[$i].FriendlyName -Foreground Yellow -NoNewLine
    Write-Host  " | " -Foreground White -NoNewline
    Write-Host $beforeUSB[$i].DeviceId -Foreground Green 
    $amount++
}
" "
Write-Host "Total amount of Audio USB Devices conencted currently: $amount" -Foreground White





while (1){
    $afterUSB = Get-PnpDevice -PresentOnly | Where-Object { ($_.Class -match '^MEDIA') }
    $afterUSBLength = $afterUSB.Length

    if ($beforeLength -lt $afterUSBLength){
        $beforeLength = $afterUSB.Length
        $currentTime = Get-Date -Format "g"
        Write-Host "$currentTime" -NoNewline -Foreground Yellow
        Write-Host " | " -NoNewline 
        Write-Host "An Audio device Connected ! " -Foreground Green -NoNewline
        Write-Host "| " -NoNewline
        Write-Host $computerName 
    }
    elseif ($beforeLength -gt $afterUSBLength){
        $currentTime = Get-Date -Format "g"
        Write-Host "$currentTime" -NoNewline -Foreground Yellow
        Write-Host " | " -NoNewline 
        Write-Host "An Audio device Disconnected ! " -Foreground Red -NoNewline
        Write-Host "| " -NoNewline
        Write-Host $computerName 
        $beforeLength = $afterUSBLength
    }
    Start-Sleep -Seconds 1
}