$targets = Import-Csv .\WinHost.csv |
    Where-Object {$_.os -eq "Win10"} |
        Select-Object -ExpandProperty ip

$current = Invoke-Command -ComputerName $targets -Credential $creds -FilePath ..\3317\Scripts\scheduledtask.ps1

$current | Sort-Object -Property pscomputername, taskname -Unique |
    Group-Object taskname |
        Where-Object {$_.count -le 2} |
            Select-Object -ExpandProperty Group