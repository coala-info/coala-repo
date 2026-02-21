---
name: perl-test-sys-info
description: This skill provides guidance for utilizing the `Test::Sys::Info` suite.
homepage: http://metacpan.org/pod/Test::Sys::Info
---

# perl-test-sys-info

## Overview
This skill provides guidance for utilizing the `Test::Sys::Info` suite. It is used to verify that the `Sys::Info` module correctly interfaces with the underlying host system. This is critical when deploying Perl applications that rely on accurate system metrics, as it validates the driver's ability to parse platform-specific data (such as `/proc` on Linux or `WMI` on Windows).

## Usage Guidelines

### Installation
The package is available via Bioconda for environment-managed Perl installations:
```bash
conda install -c bioconda perl-test-sys-info
```

### Basic Test Execution
To run the standard test suite against the installed `Sys::Info` distribution, use the `prove` utility which is standard for Perl distributions:

```bash
# Run all tests in the suite
prove -lv t/
```

### Common Patterns
*   **Validation of System Drivers**: Use this tool when `Sys::Info` returns "Unknown" or "N/A" values to determine if the issue lies in the module's parser or the system's permissions.
*   **Cross-Platform Verification**: Since `Sys::Info` behaves differently on `linux-64` vs `macOS-64`, always run this test suite after a platform migration to ensure the hardware abstraction layer is functioning.
*   **Integration Testing**: Include these tests in CI/CD pipelines when building Perl-based system monitoring tools to catch regressions in system calls.

### Troubleshooting
*   **Missing Dependencies**: Ensure `Sys::Info` and its platform-specific drivers (e.g., `Sys::Info::Driver::Linux`) are installed, as `Test::Sys::Info` acts as a wrapper to validate these drivers.
*   **Permission Issues**: Some system information requires root/sudo access. If tests fail on CPU or Memory fetches, verify the user has read access to system interfaces.

## Reference documentation
- [Test::Sys::Info Documentation](./references/metacpan_org_pod_Test__Sys__Info.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-test-sys-info_overview.md)