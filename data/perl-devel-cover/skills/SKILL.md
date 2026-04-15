---
name: perl-devel-cover
description: This tool generates and analyzes code coverage metrics for Perl applications to identify untested code paths. Use when user asks to collect statement or branch coverage, generate HTML coverage reports, analyze POD documentation coverage, or convert gcov data for Perl XS extensions.
homepage: http://www.pjcj.net/perl.html
metadata:
  docker_image: "quay.io/biocontainers/perl-devel-cover:1.33--pl526h14c3975_0"
---

# perl-devel-cover

## Overview
This skill enables the generation and analysis of code coverage metrics for Perl applications. It utilizes the `Devel::Cover` module to track execution at the opcode level and the `cover` utility to aggregate this data into human-readable reports. It is essential for identifying untested code paths and ensuring high-quality documentation through POD coverage analysis.

## Core Usage Patterns

### Basic Coverage Collection
To collect coverage data while running a standard Perl test suite, use the `-MDevel::Cover` flag with the Perl interpreter or `HARNESS_PERL_SWITCHES`.

```bash
# Using perl directly
perl -MDevel::Cover test.pl

# Using prove (recommended for test suites)
HARNESS_PERL_SWITCHES=-MDevel::Cover prove t/
```

### Generating Reports
After running tests, a `cover_db` directory is created. Use the `cover` command to process this data.

```bash
# Generate a default HTML report
cover

# Generate specific report formats (e.g., text, html, json)
cover -report text
```

### Coverage Criteria
The tool tracks several metrics. You can filter which ones to collect or report:
- **Statement**: Which lines of code executed.
- **Branch**: Whether both paths of an `if` or `unless` were taken.
- **Condition**: Evaluation of complex boolean expressions.
- **Subroutine**: Whether each sub was called.
- **Pod**: Whether subroutines have associated documentation.

### Working with C/XS Code
If your Perl module uses XS (C extensions), you can convert `gcov` data to `Devel::Cover` format.

```bash
gcov2perl [gcov_files]
cover
```

## Best Practices
- **Clean Starts**: Delete the `cover_db` directory before a fresh run if you want to ensure old test runs don't pollute new metrics: `cover -delete`.
- **Performance**: Code coverage adds significant overhead. Only enable it during dedicated CI steps or local audit phases, not during production-like performance testing.
- **Version Compatibility**: Use Perl 5.8.2 or greater for the most reliable results. Perl 5.6 is supported but may produce less accurate op-tree mapping.
- **Incremental Testing**: You can run multiple test scripts sequentially; `Devel::Cover` will accumulate the data in the database until you run `cover -delete` or manually remove the directory.

## Reference documentation
- [Perl page of Paul Johnson](./references/www_pjcj_net_perl.html.md)
- [bioconda perl-devel-cover overview](./references/anaconda_org_channels_bioconda_packages_perl-devel-cover_overview.md)