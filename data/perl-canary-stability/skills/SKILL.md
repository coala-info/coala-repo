---
name: perl-canary-stability
description: This tool manages pre-installation sanity checks and stability requirements for specific Perl modules. Use when user asks to bypass interactive installation prompts, disable stability checks, or configure environment variables for non-interactive builds.
homepage: http://metacpan.org/pod/Canary::Stability
---


# perl-canary-stability

## Overview
This skill provides guidance on managing `Canary::Stability`, a specialized utility used by "Schmorp" modules to perform pre-installation sanity checks. While primarily an internal tool for specific distributions, users often encounter it when builds fail or hang during the configuration phase. This skill helps you configure the environment to ensure smooth, non-interactive installations and understand the stability requirements of the underlying Perl environment.

## Usage and Best Practices

### Non-Interactive Installations (CI/CD)
If a build is hanging or waiting for user input during the `perl Makefile.PL` stage, use the following environment variable to bypass prompts:
- `PERL_CANARY_STABILITY_NOPROMPT=1`: Disables interactive alerts. This is essential for automated build systems and containers.

### Handling Compatibility Failures
If the module detects an incompatible Perl version, it may exit to prevent "false positive" test results.
- **Automated Testing**: If `AUTOMATED_TESTING=1` is set and the Perl version is insufficient, the module will exit immediately. This is intended to skip tests on platforms the author does not support.
- **Disabling Checks**: If you are certain your environment is compatible despite warnings, you can completely bypass the check using:
  `PERL_CANARY_STABILITY_DISABLE=1`

### Visual Configuration
You can control how stability alerts appear in your terminal:
- **Disable Color**: `PERL_CANARY_STABILITY_COLOUR=0`
- **Force Color**: `PERL_CANARY_STABILITY_COLOUR=1`

### Implementation in Makefile.PL
For developers maintaining or patching modules that use this tool, the standard implementation pattern is:
```perl
use Canary::Stability DISTNAME => 2001, MINIMUM_PERL_VERSION;
```
Replace `DISTNAME` with the distribution name and `MINIMUM_PERL_VERSION` with the required version (e.g., `5.010`).

## Reference documentation
- [Canary::Stability - Metacpan](./references/metacpan_org_pod_Canary__Stability.md)
- [perl-canary-stability - Bioconda](./references/anaconda_org_channels_bioconda_packages_perl-canary-stability_overview.md)