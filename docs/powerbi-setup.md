# Power BI Desktop on macOS (UTM route)

Power BI Desktop is Windows-only. On Apple Silicon the free option is **UTM**, a macOS virtualization app built on QEMU.

## What you need

1. **UTM** — free, from <https://mac.getutm.app/> (or `brew install --cask utm`).
2. **Windows 11 ARM64 ISO** — free download from Microsoft: <https://www.microsoft.com/software-download/windows11arm>.
3. **Power BI Desktop** — free, installed *inside* the VM from <https://powerbi.microsoft.com/desktop/> (choose the ARM-compatible installer / Microsoft Store version).
4. A Microsoft account. Windows activation may be required after the grace period; Power BI Desktop itself is free.

## Steps

1. Install UTM and open it.
2. **Create a New Virtual Machine → Virtualize → Windows**.
3. Select the downloaded Windows 11 ARM64 ISO, allocate at least:
   - **4 CPU cores**, **8 GB RAM**, **64 GB disk** (more if you work with large datasets).
4. Boot the VM and complete Windows Setup (choose the option to install without a product key if you don't have one yet).
5. In the VM, open Microsoft Edge and download/install **Power BI Desktop**.
6. Share a folder from macOS to the VM (UTM → VM Settings → Shared Directory) so you can pass CSV/Excel files between the two systems.
7. In Power BI Desktop: **Get Data → Power Query** is built in. Use it for the Indian Retail Sales and Logistics SLA capstones.

## Alternatives

- **Parallels Desktop** — paid, easier setup and better performance on Apple Silicon.
- **Windows 365 / Azure VM / a friend's Windows PC** — use Remote Desktop from macOS; no local VM needed.
- **Power BI Service in a browser** — good for viewing dashboards, but you still need Desktop to author them.

## Note for this portfolio

Keep Power Query transformation steps documented in each project README so the work is reproducible even for reviewers without Power BI.
