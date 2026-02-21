---
name: perl-test-eol
description: `perl-test-eol` (provided via the `Test::EOL` Perl module) is a quality assurance tool designed to identify inconsistent line endings and unnecessary trailing whitespace.
homepage: http://metacpan.org/release/Test-EOL
---

# perl-test-eol

## Overview
`perl-test-eol` (provided via the `Test::EOL` Perl module) is a quality assurance tool designed to identify inconsistent line endings and unnecessary trailing whitespace. It is primarily used to enforce Unix-style line endings (LF) across a codebase, preventing "hidden" diffs caused by developers working on different operating systems (Windows vs. macOS/Linux).

## Usage Patterns

### Standard Test Script (t/eol.t)
The most common way to use this tool is by creating a standard Perl test file. This allows `prove` or `make test` to automatically validate all files in the distribution.

```perl
use Test::More;
use Test::EOL;

# Plan: check all files in the distribution
all_perl_files_ok({ trailing_whitespace => 1 });
```

### Targeted File Checking
If you only want to check specific directories or files (e.g., excluding third-party libraries), use `all_eol_ok`.

```perl
use Test::EOL;

# Check only the 'lib' and 'bin' directories
all_eol_ok(qw( lib bin ), { trailing_whitespace => 1 });
```

### Configuration Options
The behavior of the check is controlled by a trailing hash reference of options:

- `trailing_whitespace => 1`: (Recommended) Fails the test if any line ends with spaces or tabs before the newline.
- `all_perl_files_ok()`: Automatically finds `.pm`, `.pl`, and `.t` files.

## Best Practices
- **Integration**: Always include `Test::EOL` in your `xt/` (author tests) directory rather than `t/` (unit tests) if you don't want to force end-users to install the module just to run basic tests.
- **Version Control**: Use this tool in conjunction with `.gitattributes` (`* text=auto`) to ensure that the repository remains clean regardless of local editor settings.
- **Trailing Whitespace**: Enable the `trailing_whitespace` check by default; it is the most common source of "noisy" commits in collaborative projects.

## Reference documentation
- [Test-EOL on MetaCPAN](./references/metacpan_org_release_Test-EOL.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-test-eol_overview.md)