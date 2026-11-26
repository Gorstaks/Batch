@echo off
:: Batch script to configure Windows Firewall rules (Extended Version)
:: Run this script in an elevated Command Prompt
:: Owner: Gorstak

:: Reset Windows Firewall to default
netsh advfirewall reset

:: Set default policies: block all inbound, allow outbound (by default)
netsh advfirewall set allprofiles state on
netsh advfirewall set allprofiles firewallpolicy blockinbound,allowoutbound

:: === SYSTEM Rules (NetBIOS & SMB) ===
:: NetBIOS Name & Datagram Services (UDP 137-138)
netsh advfirewall firewall add rule name="Block NetBIOS UDP Inbound" dir=in action=block protocol=UDP localport=137-138 profile=any
netsh advfirewall firewall add rule name="Block NetBIOS UDP Outbound" dir=out action=block protocol=UDP localport=137-138 profile=any

:: NetBIOS Session Service (TCP 139)
netsh advfirewall firewall add rule name="Block NetBIOS TCP Inbound" dir=in action=block protocol=TCP localport=139 profile=any
netsh advfirewall firewall add rule name="Block NetBIOS TCP Outbound" dir=out action=block protocol=TCP localport=139 profile=any

:: Microsoft DS / SMB (TCP 445) - Ključno za sprječavanje Ransomwarea (npr. WannaCry)
netsh advfirewall firewall add rule name="Block SMB TCP Inbound" dir=in action=block protocol=TCP localport=445 profile=any
netsh advfirewall firewall add rule name="Block SMB TCP Outbound" dir=out action=block protocol=TCP localport=445 profile=any


:: === HACKING & REMOTE ACCESS PORTS ===
:: RDP / Remote Desktop (TCP/UDP 3389) - Česta meta za brute-force napade
netsh advfirewall firewall add rule name="Block RDP Inbound" dir=in action=block protocol=TCP localport=3389 profile=any
netsh advfirewall firewall add rule name="Block RDP UDP Inbound" dir=in action=block protocol=UDP localport=3389 profile=any

:: WinRM / Windows Remote Management (TCP 5985-5986) - Hakeri koriste za PowerShell napade
netsh advfirewall firewall add rule name="Block WinRM HTTP Inbound" dir=in action=block protocol=TCP localport=5985 profile=any
netsh advfirewall firewall add rule name="Block WinRM HTTPS Inbound" dir=in action=block protocol=TCP localport=5986 profile=any

:: RPC / Remote Procedure Call (TCP 135) - Koristi se za izviđanje mreže i eksploataciju
netsh advfirewall firewall add rule name="Block RPC Inbound" dir=in action=block protocol=TCP localport=135 profile=any

:: SSH & Telnet (TCP 22, 23) - Zaustavljanje neovlaštenog udaljenog pristupa konzoli
netsh advfirewall firewall add rule name="Block SSH Inbound" dir=in action=block protocol=TCP localport=22 profile=any
netsh advfirewall firewall add rule name="Block Telnet Inbound" dir=in action=block protocol=TCP localport=23 profile=any

:: VNC (TCP 5900-5903) - Blokiranje nesigurnih alata za udaljenu radnu površinu
netsh advfirewall firewall add rule name="Block VNC Inbound" dir=in action=block protocol=TCP localport=5900-5903 profile=any


:: === DATABASE PORTS (Spriječavanje curenja podataka) ===
:: SQL Server, MySQL, Oracle, PostgreSQL (TCP 1433, 3306, 1521, 5432)
netsh advfirewall firewall add rule name="Block Database Ports Inbound" dir=in action=block protocol=TCP localport=1433,3306,1521,5432 profile=any


:: === NETWORK & TUNNELING ===
:: ICMP / Ping (IPv4 & IPv6) - Sakriva računalo od mrežnih skenera (Nmap)
netsh advfirewall firewall add rule name="Block ICMPv4 Inbound" dir=in action=block protocol=ICMPv4 type=8 profile=any
netsh advfirewall firewall add rule name="Block ICMPv4 Outbound" dir=out action=block protocol=ICMPv4 type=8 profile=any
netsh advfirewall firewall add rule name="Block ICMPv6 Error" dir=in action=block protocol=ICMPv6 type=1,2,3,4 profile=any
netsh advfirewall firewall add rule name="Block ICMPv6 Info" dir=in action=block protocol=ICMPv6 type=128,129,133,134,135,136,137 profile=any

:: 6to4 & Teredo Tunnels (Protocol 41, UDP 3544-3545) - Zaustavlja zaobilaženje IPv4 pravila
netsh advfirewall firewall add rule name="Block 6to4 Tunnel" dir=in action=block protocol=41 profile=any
netsh advfirewall firewall add rule name="Block Teredo UDP" dir=in action=block protocol=UDP localport=3544-3545 profile=any


:: === LEGACY & UNSAFE PROTOCOLS ===
:: FTP, SMTP, POP3, IMAP (TCP 20, 21, 25, 110, 143) - Tekstualni protokoli koji šalju lozinke u čistom tekstu
netsh advfirewall firewall add rule name="Block Cleartext Mail/FTP Inbound" dir=in action=block protocol=TCP localport=20,21,25,110,143 profile=any