---
name: collectl
description: Collectl is a lightweight monitoring tool that captures a broad range of Linux system performance metrics with low overhead. Use when user asks to monitor real-time system performance, log telemetry data for playback, or troubleshoot hardware subsystems like CPU, disk, and network.
homepage: https://github.com/sharkcz/collectl
metadata:
  docker_image: "quay.io/biocontainers/collectl:4.3.20.2--pl5321h05cac1d_0"
---

# collectl

## Overview
Collectl is a lightweight, high-performance monitoring tool for Linux that captures a broad range of system metrics with very low overhead. It serves as a unified alternative to multiple utilities like `top`, `iostat`, `sar`, and `netstat`. Use this skill to configure real-time performance monitoring, set up persistent logging for telemetry, or troubleshoot specific hardware subsystems such as Infiniband or NVMe storage.

## Installation and Setup
Collectl can be installed via package managers or from source.
- **Conda**: `conda install bioconda::collectl`
- **Source**: Run the `INSTALL` script provided in the repository. By default, it installs the binary to `/usr/bin/collectl` and runtime components (including plugins) to `/usr/share/collectl`.
- **Configuration**: The primary configuration file is `collectl.conf`, which the tool searches for in `/etc/` first, then in its binary directory.

## Common CLI Patterns

### Interactive Monitoring
Run `collectl` without arguments to see a default summary of CPU, Disk, and Network activity.

**Monitor Specific Subsystems**
Use the `-s` flag to choose which data to collect. Common subsystems include:
- `c`: CPU
- `d`: Disk
- `n`: Network
- `m`: Memory
- `i`: Inodes
- `l`: Lustre
- `x`: Interconnect (Infiniband)

Example: Monitor CPU and Disk only:
`collectl -scd`

**Detailed vs. Summary Output**
By default, collectl shows summary data. Use `-D` for detailed per-device statistics.
Example: Detailed disk statistics:
`collectl -sd -D`

### Logging and Playback
Collectl is often used to record data for later analysis.

**Log to Disk**
Use `-f` to specify a directory for output files.
`collectl -f /var/log/collectl`

**Playback Logs**
Use `-p` to read and process a previously generated log file.
`collectl -p filename.raw.gz`

## Expert Tips and Hardware Specifics

- **Plugin Support**: Collectl uses `.ph` files for extended functionality (e.g., `graphite.ph`, `statsd.ph`, `vmstat.ph`). These must reside in the same directory as the `collectl` binary or in `/usr/share/collectl`.
- **NVMe and Storage**: Recent versions include specific support for NVMe native multipath devices and Rados Block Devices (rbd). Ensure your `collectl.conf` is updated to include these filters if working with modern storage stacks.
- **Infiniband (IB)**: Collectl is highly effective for HPC environments. It supports monitoring multiple Mellanox cards and specific hardware counters (e.g., `mthca`, `mlx4`, `mlx5`).
- **Network Interfaces**: The tool supports a wide range of interface naming conventions, including wireless (`wl`) and specific IB port counters.
- **Low Overhead**: For high-frequency monitoring (e.g., sub-second intervals), use the `-i` flag to set the interval in seconds or milliseconds.

## Reference documentation
- [Anaconda Bioconda Collectl Overview](./references/anaconda_org_channels_bioconda_packages_collectl_overview.md)
- [GitHub Sharkcz Collectl Repository](./references/github_com_sharkcz_collectl.md)
- [Collectl Tags and Version History](./references/github_com_sharkcz_collectl_tags.md)