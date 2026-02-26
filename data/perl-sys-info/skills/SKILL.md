---
name: perl-sys-info
description: The perl-sys-info tool provides a standardized interface for probing system internals and hardware metadata across different platforms. Use when user asks to retrieve CPU details, identify operating system metadata, or generate cross-platform system reports.
homepage: http://metacpan.org/pod/Sys::Info
---


# perl-sys-info

## Overview
The `perl-sys-info` skill provides a standardized interface for probing system internals. It abstracts the complexities of platform-specific commands (like `lscpu`, `uname`, or `sysctl`) into a unified Perl-based API. This is particularly useful for environment auditing, hardware benchmarking, or generating system reports in a cross-platform manner.

## Usage Patterns

### Basic Perl One-Liner for System Summary
To quickly dump system information to the terminal without writing a full script:
```bash
perl -MSys::Info -e 'my $info = Sys::Info->new; printf "OS: %s\nCPU: %s\n", $info->os->name, $info->device("CPU")->identify'
```

### Identifying CPU Details
Use the `device` method specifically for processor architecture and speed:
```perl
use Sys::Info;
my $info   = Sys::Info->new;
my $cpu    = $info->device('CPU');
print "CPU: " . $cpu->identify . "\n";
print "Cores: " . $cpu->count . "\n";
print "Speed: " . $cpu->speed . " MHz\n";
```

### Operating System Metadata
Retrieve specific distribution details and kernel versions:
```perl
use Sys::Info;
my $os = Sys::Info->new->os;
print "Name: "    . $os->name(long => 1) . "\n";
print "Version: " . $os->version         . "\n";
print "Node: "    . $os->node            . "\n";
```

## Best Practices
- **Object Persistence**: Create a single `Sys::Info->new` object and reuse it if querying multiple devices to reduce overhead.
- **Platform Compatibility**: While the module is cross-platform, certain specific device attributes may return `undef` if the underlying system provider (e.g., `Sys::Info::Driver::Linux`) does not support that specific hardware probe. Always check for defined values.
- **Conda Environment**: Ensure the tool is executed within the environment where it was installed via `conda install bioconda::perl-sys-info` to ensure all Perl @INC paths are correctly set.

## Reference documentation
- [Sys::Info Documentation](./references/metacpan_org_pod_Sys__Info.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-sys-info_overview.md)