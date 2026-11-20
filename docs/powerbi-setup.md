# Power BI Desktop on macOS (UTM route)

Power BI Desktop is Windows-only. On Apple Silicon the free option is **UTM**, a macOS
virtualization app built on QEMU. This document records the exact setup used for this
portfolio so it can be reproduced.

## What was installed

| Component | Version / detail |
| --- | --- |
| UTM | 5.0.9 (free, from <https://mac.getutm.app/>) |
| Guest OS | Windows 11 Pro, Arm64 — 2026 Update (26H2), build 26300.9457 |
| Windows ISO | `Win11_ARM64.iso` (en-us, multi-edition) — SHA-256 `8992F2D2CFD2FA647E579E9EB31FC21F34DA8333C29B6170FDE17D2ED6623E9C` |
| VM name | `Windows 11 ARM` |
| VM resources | 4 CPU cores, **4 GB RAM**, 64 GB sparse disk |
| Display | `virtio-gpu-pci`, dynamic resolution (set after guest-tools install for a stable desktop framebuffer) |
| Firmware | UEFI + TPM, RTC local time |
| UTM Guest Tools | `utm-guest-tools-3d-latest.iso` (QEMU/virtio drivers + QEMU guest agent) installed in Windows |
| Power BI Desktop | Microsoft Power BI Desktop **x64** (`PBIDesktopSetup_x64.exe`, direct download from Microsoft Download Center, Authenticode-signed by Microsoft; ~703 MB). Installed silently and verified to launch on the VM. |

> **RAM note:** the host Mac has 8 GB total, so the VM is sized at **4 GB** (not 8 GB).
> Bump it to 6–8 GB if the host is upgraded. RAM can be changed in the VM's settings
> while it is shut down.
>
> **ARM note:** Microsoft states Power BI Desktop is supported on Windows on ARM PCs
> (with the required cumulative update). At time of setup, Microsoft publicly provides the
> x64 installer; on Windows 11 ARM it runs under the platform's x64 emulation. There is no
> separately documented native ARM64 Power BI Desktop installer.

## Files used

- `~/Library/Containers/com.utmapp.UTM/Data/Documents/Windows 11 ARM.utm` — the VM bundle.
- `~/Library/Containers/com.utmapp.UTM/Data/Documents/Windows 11 ARM.utm/Data/` — VM data
  (Windows ISO, unattended ISO, `efi_vars.fd`, qcow2 disk).
- `Autounattend.xml` — answers file that automates Windows Setup (language, disk layout,
  Pro edition, local account `analyst`, auto-logon, OOBE skip). Packaged into a small ISO
  and attached to a second CD drive during install.
- `vm-shared/` (in this repo) — macOS↔Windows exchange folder configured for UTM SPICE
  WebDAV sharing (read/write): `datasets/` for inputs, `exports/` for outputs.

## Steps taken

1. Install UTM and open it.
2. **Create a New Virtual Machine → Virtualize → Windows.**
3. Attach the Windows 11 Arm64 ISO and set resources: **4 cores, 4 GB RAM, 64 GB disk**.
4. Switch the main disk interface from `VirtIO` to **NVMe** (Windows 11 has an inbox NVMe
   driver; it has no inbox VirtIO driver).
5. Attach the `Autounattend.xml` ISO to a second CD drive so Setup runs unattended.
6. Boot the VM. If the firmware drops to the UEFI shell, run the CD's boot loader:
   ```
   efi\boot\bootaa64.efi
   ```
   and press a key at the *"Press any key to boot from CD or DVD"* prompt.
7. Windows Setup installs unattended, then OOBE creates the local account and auto-logs in.
8. Inside Windows, run **Install Windows Guest Tools** (UTM menu / mounted guest-tools ISO,
   `utm-guest-tools.exe`) and complete the wizard — this installs the VirtIO drivers
   (including **network/NetKVM**, balloon, input) and the **QEMU guest agent** (`qemu-ga`).
   A reboot may follow driver installation.
9. If the display becomes unstable/grey after guest tools, set the VM display hardware to
   **`virtio-gpu-pci`** (dynamic resolution on) in UTM/VM config while the VM is stopped,
   then boot again. Log in as `analyst` / `Analyst!2026`.
10. Verify network inside Windows (e.g. `ipconfig`, ping) — confirmed with an IP on the VM
    network and successful outbound connectivity.
11. Download the x64 Power BI Desktop installer from the Microsoft Download Center and run:
    ```
    PBIDesktopSetup_x64.exe -quiet ACCEPT_EULA=1 INSTALLDESKTOPSHORTCUT=1 DISABLE_UPDATE_NOTIFICATION=1
    ```
12. Launch **Power BI Desktop** to confirm it opens (start/home screen). Sign-in to the
    Power BI service is optional for local authoring.
13. Configure a shared folder from macOS to the VM (UTM → VM Settings → Sharing) to pass
    CSV/Excel files between the two systems.
    - **Sharing mode:** SPICE WebDAV (DirectoryShareMode `WebDAV`), **Read Only:** off.
    - **macOS folder (configured):** `data-analytics-portfolio/vm-shared/` (absolute: `/Users/dikshitpunwar/Documents/Default Project/data-analytics-portfolio/vm-shared`)
      - `datasets/` — place CSV/Excel/Parquet source files for Power BI / Power Query.
      - `exports/` — save reports/exports/output files from the VM back to macOS.
    - **Inside Windows (UTM Guest Tools required):** the WebDAV share should appear in File
      Explorer (e.g. under This PC / Network locations) after boot/login. If it does not
      auto-mount, add/map the guest WebDAV endpoint (commonly `http://localhost:9843` inside
      the VM) as a network location/drive, then browse to the shared folder.
    - **Verify:** start "Windows 11 ARM", log in as `analyst`, confirm `vm-shared` (with
      `datasets/` and `exports/`) is accessible, and open a file from `datasets/` in Power BI
      Desktop or Power Query. Keep source data/outputs in this repo folder on macOS (the VM
      disk is disposable).

### Windows credentials (local VM only)

- Username: `analyst`
- Password: `Analyst!2026`

## Notes for this portfolio

- Keep Power Query transformation steps documented in each project README so the work is
  reproducible even for reviewers without Power BI.
- The VM is disposable — datasets live in the repo, not in the VM.
- Power BI Desktop on this Windows-on-ARM VM runs as the x64 build under emulation; expect
  slower startup/performance than a native Windows x64 machine.

## Alternatives

- **Parallels Desktop** — paid, easier setup and better performance on Apple Silicon.
- **Windows 365 / Azure VM / a Windows PC** — use Remote Desktop from macOS; no local VM.
- **Power BI Service in a browser** — good for viewing dashboards, but authoring needs Desktop.
