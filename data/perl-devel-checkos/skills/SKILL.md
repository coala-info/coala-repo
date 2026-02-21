---
name: perl-devel-checkos
description: The `perl-devel-checkos` tool provides a standardized way to determine the operating system environment.
homepage: http://metacpan.org/pod/Devel::CheckOS
---

# perl-devel-checkos

## Overview
The `perl-devel-checkos` tool provides a standardized way to determine the operating system environment. Unlike simple `$^O` checks, it uses a hierarchy of platform names (e.g., "Unix", "Linux", "POSIX") to allow for more robust and portable code. Use this skill when you need to verify if the current system matches specific OS requirements or when debugging platform-specific execution failures.

## Usage Guidelines

### Basic OS Identification
To check if the current system matches a specific OS type, use the `perl` command line interface to invoke the module:

```bash
# Check if the OS is a type of Linux
perl -MDevel::CheckOS -e 'die "Not Linux" unless os_is("Linux")'

# Check for POSIX compatibility
perl -MDevel::CheckOS -e 'print "System is POSIX compliant\n" if os_is("POSIX")'
```

### Listing Supported OS Names
To see the full list of OS identifiers that the tool can recognize, you can query the available data:

```bash
perl -MDevel::CheckOS -e 'print join(", ", Devel::CheckOS::list_platforms())'
```

### Common Platform Targets
When writing conditional logic, use these common platform strings:
- `Unix`: Matches most non-Windows, non-VMS systems.
- `Linux`: Specific to Linux distributions.
- `MicrosoftWindows`: Matches Windows environments.
- `Darwin`: Matches macOS/OSX.
- `POSIX`: Matches systems adhering to POSIX standards.

### Best Practices
- **Prefer Hierarchy**: Use broader categories like `Unix` or `POSIX` instead of specific versions unless your software strictly requires a specific kernel.
- **Error Handling**: Use `die` or exit codes within your one-liners to halt CI/CD pipelines or installation scripts if the OS requirements are not met.
- **Environment Validation**: Run a check at the very beginning of a script to prevent cryptic errors later in the execution caused by missing platform-specific binaries.

## Reference documentation
- [Devel::CheckOS Documentation](./references/metacpan_org_pod_Devel__CheckOS.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-devel-checkos_overview.md)