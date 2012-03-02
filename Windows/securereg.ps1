#DISA/DoD 2k3/2k8 Security Configuration
#Disable AutoRun
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Cdrom' -Name "AutoRun" -Value 0
#Harden TCP/IP Stack
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters' -Name "EnableICMPRedirect" -Value 0 -PropertyType DWORD
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters' -Name "SynAttackProtect" -Value 1 -PropertyType DWORD
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters' -Name "EnableDeadGWDetect" -Value 0 -PropertyType DWORD
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters' -Name "KeepAliveTime" -Value 300000 -PropertyType DWORD
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters' -Name "DisableIPSourceRouting" -Value 2 -PropertyType DWORD
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters' -Name "TcpMaxConnectResponseRetransmissions" -Value 2 -PropertyType DWORD
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters' -Name "TcpMaxDataRetransmissions" -Value 3 -PropertyType DWORD
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters' -Name "PerformRouterDiscovery" -Value 0 -PropertyType DWORD
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\Netbt\Parameters' -Name "NoNameReleaseOnDemand" -Value 1 -PropertyType DWORD
#Lockdown SMB
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' -Name "RestrictAnonymous" -Value 1
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Lsa' -Name "RestrictAnonymousSAM" -Value 1
New-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters' -Name "EnablePlainTextPassword" -Value 0 -PropertyType DWORD