# Batch

A collection of standalone Windows `.cmd` and `.bat` scripts for hardening, cleanup, network repair and system tweaks. Each script is independent.

> **Warning:** these scripts change system settings, services, registry permissions and system files, and some delete files or accounts. Read a script before you run it. Test on a virtual machine or a machine with a restore point first. Most of them are not reversible by a matching script.

## Requirements

- Windows 10 or 11
- Administrator rights. Most scripts re-launch themselves elevated through a UAC prompt.

## Scripts

| Script | What it does |
| --- | --- |
| `Hardening.cmd` | Ten-step hardening pass. Disables SMBv1, sets NTLMv2-only authentication, blocks inbound SMB, RDP and WinRM, disables the Print Spooler, Remote Registry and Xbox services, disables the Guest and built-in Administrator accounts, sets an account lockout policy, disables Autorun and USB storage, blocks Office macros from the internet, enables Defender controlled folder access and attack surface reduction rules, and cleans temp files. |
| `Firewall.cmd` | Resets Windows Firewall to defaults, then blocks all inbound traffic and adds block rules for NetBIOS, SMB, remote-access, database, tunneling and legacy ports. |
| `GSecurityLite.cmd` | Runs everything as a standard user with elevation only at the physical console. Restricts `consent.exe` to the console logon, sets the UAC prompt levels and configures Software Restriction Policies (SAFER) through the registry. |
| `Consent.cmd` | The UAC part of `GSecurityLite.cmd` only: restricts `consent.exe` and sets `ConsentPromptBehaviorAdmin` and `ConsentPromptBehaviorUser`. |
| `Bios.cmd` | Sets a list of `bcdedit` boot options, such as NX always on, legacy boot menu, hypervisor off, dynamic tick off and legacy APIC mode. Affects boot behavior, and turning the hypervisor off disables VBS and Hyper-V. |
| `MiniFilterDrivers.cmd` | Unloads the `bfs` and `unionfs` minifilter drivers, takes ownership of their `.sys` files and deletes them. |
| `Riddance.cmd` | Deletes local user accounts other than the current one and enables UAC (`EnableLUA`). **Destroys accounts and their data.** |
| `Unbridge.cmd` | Not a script. The file contains Markdown documentation for a network registry permission cleanup that uses `SetACL.exe` and `devcon.exe` from `C:\Tools\`. Running it as a batch file will not do what the text describes. |
| `NetworkRepair.cmd` | Restores network connectivity settings. Re-enables network location awareness probing, sets the networking, firewall, DNS client and WLAN services back to automatic or manual start, and starts them. |
| `Bufferbloat.cmd` | Sets TCP receive window auto-tuning to `restricted` with `netsh` to reduce bufferbloat. |
| `Ozempic.bat` | Frees disk space. Stops Windows Update and BITS, deletes `SoftwareDistribution`, runs DISM component cleanup with `/ResetBase`, runs Disk Cleanup, and restarts the services. After `/ResetBase` you cannot uninstall installed Windows updates. |
| `PDQ.cmd` | System cleanup utility with a log in `%SystemDrive%\Logs`. Removes Adobe Flash and VNC remnants, clears temp files and cleans USB device registry entries. Closes browser processes while it runs. Uses `wmic`, which is removed in recent Windows 11 builds. |
| `Store.cmd` | Installs the Microsoft Store with `wsreset -i`. |
| `Activator.cmd` | Detects the Windows edition and installs the matching public KMS client key, then activates against a third-party KMS server (`kms.digiboy.ir`) that is not run by Microsoft. Use it only on systems you hold a licence for. Some keys in the script are marked unverified. |

## Usage

1. Right-click the script and choose **Run as administrator**, or run it from an elevated Command Prompt.
2. Read the on-screen output. Several scripts pause at the end.

```bat
Hardening.cmd
```

## Notes

- `Hardening.cmd`, `Firewall.cmd` and `Consent.cmd` overlap with the policies in the `Policies`, `INF` and `Provisioning` projects. Apply one approach, not all of them.
- Blocking RDP, SMB and WinRM, and disabling USB storage, will cut off remote management and USB drives.
- A `Releases/0.0.1/Batch.zip` archive holds the released copy of these scripts.

## Author

Gorstak
