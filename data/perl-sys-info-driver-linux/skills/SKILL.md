---
name: perl-sys-info-driver-linux
description: This tool extracts detailed Linux system metadata and hardware information through the Sys::Info API. Use when user asks to identify Linux distribution details, extract CPU architecture and flags, or retrieve memory and resource statistics.
homepage: http://metacpan.org/pod/Sys::Info::Driver::Linux
---


# perl-sys-info-driver-linux

## Overview
This skill enables the extraction of detailed system metadata on Linux platforms through the `Sys::Info::Driver::Linux` backend. It is essential when general Perl system calls are insufficient and you require deep inspection of Linux-specific attributes such as bogomips, CPU flags, distribution-specific versions, and detailed memory statistics. It acts as the translation layer between the operating system's raw data files and the object-oriented `Sys::Info` API.

## Usage Patterns

### Initializing the Driver
To access Linux-specific data, initialize the `Sys::Info` object. The driver is loaded automatically when the host OS is detected as Linux.

```perl
use Sys::Info;
my $info = Sys::Info->new;
my $os   = $info->device('OS');
my $cpu  = $info->device('CPU');
```

### Extracting CPU Metadata
The Linux driver parses `/proc/cpuinfo` to provide more than just clock speed. Use it to identify:
- **CPU Architecture**: `print $cpu->architecture;`
- **Load Averages**: `print $cpu->load;`
- **Processor Details**: Access specific flags and counts that are often obscured in generic cross-platform tools.

### Operating System and Distribution Details
Unlike standard Perl `$^O`, this driver identifies specific Linux distributions (Ubuntu, CentOS, Debian, etc.) and kernel versions.
- **Distribution**: `$os->name;` (e.g., "Ubuntu")
- **Version**: `$os->version;` (e.g., "22.04")
- **Kernel**: `$os->meta->{kernel};`

### Memory and Resource Inspection
The driver provides a structured way to view physical and swap memory without manual regex parsing of `/proc/meminfo`.
- **Total RAM**: `$os->total_mem;`
- **Free RAM**: `$os->free_mem;`

## Best Practices
- **Dependency Management**: Ensure `perl-sys-info` (the frontend) is installed alongside this driver. In Conda environments, use `conda install bioconda::perl-sys-info-driver-linux`.
- **Error Handling**: Always check if the device object is successfully created, as certain restricted environments (like some containers) may mask `/proc` or `/sys`, causing the driver to return incomplete data.
- **Performance**: Cache the `Sys::Info` object if you are performing multiple lookups in a loop, as the driver performs file I/O on the `/proc` filesystem upon instantiation of device objects.

## Reference documentation
- [Sys::Info::Driver::Linux Documentation](./references/metacpan_org_pod_Sys__Info__Driver__Linux.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-sys-info-driver-linux_overview.md)