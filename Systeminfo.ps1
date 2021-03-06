$adcomputer = Get-ADComputer -Filter *
foreach ($computer in $adcomputer.name) 
{
    Invoke-Command -ComputerName $computer -ScriptBlock 
        {
            Get-ComputerInfo | Out-File -FilePath "\\192.***.***.***\temp bkp\systeminfo\$env:COMPUTERNAME.txt"
        }
}

#$adcomputer = Get-ADComputer -Filter *;
#foreach ($computer in $adcomputer.name)
#{
#   Invoke-Command -ComputerName $computer -ScriptBlock 
#        {
#            Write-Output "Computername : $computer"
#            Get-ComputerInfo | Out-File -FilePath "\\192.***.***.***\temp bkp\systeminfo\$env:COMPUTERNAME.txt"
#        }
#}

#region (Ping test for list of machines)
$gpfailedpcs = Get-Content -Path C:\Users\it****\Desktop\test.txt
Foreach ($pc in $gpfailedpcs)
{
#Ping Test. If PC is shut off, script will stop for the current PC in pipeline and move to the next one.
$PingRequest = Test-Connection $Computer -Count 1 -Quiet
if ($PingRequest -eq $false)
{
Write-Output "Ping Failed in $pc"
}
else 
{Write-Output "Ping success in $pc"
}
}
#endregion

Invoke-Command -ComputerName telliant69 -ScriptBlock {Get-ComputerInfo | Out-File -FilePath "\\192.***.***.***\temp bkp\Systeminfo\$env:computername.txt"}
