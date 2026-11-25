# Batch

A collection of Windows batch scripts for hardening, networking, cleanup and activation tasks. Most scripts elevate themselves through UAC when started.

## Scripts

All scripts are in `Releases/0.0.1/`.

| Script | Purpose |
|--------|---------|
| `Activator.cmd` | Windows activation helper. |
| `Bios.cmd` | BIOS-related helper. |
| `Bufferbloat.cmd` | Network tuning to reduce bufferbloat. |
| `Consent.cmd` | Consent-related system tweak. |
| `Firewall.cmd` | Configures Windows Firewall rules (extended version). |
| `GSecurityLite.cmd` | Lightweight version of GSecurity hardening. |
| `Hardening.cmd` | Advanced Windows hardening. |
| `MiniFilterDrivers.cmd` | Handles mini filter drivers. |
| `NetworkRepair.cmd` | Network repair. |
| `Ozempic.bat` | Cleans Windows Update backups, similar to NTLite. |
| `PDQ.cmd` | Utility script. |
| `Riddance.cmd` | Removes unwanted components. |
| `Store.cmd` | Microsoft Store helper. |
| `Unbridge.cmd` | Removes network bridges. |

Check the header of each script for exact behavior before running it.

## Usage

Run a script as Administrator. These scripts change system settings, so read one before you run it.

## Releases

Release files are in `Releases/0.0.1/`.
