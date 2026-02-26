---
name: perl-test-notabs
description: This tool scans Perl source code files to ensure they do not contain hard tabs. Use when user asks to check files for tab characters, enforce no-tabs policies in Perl projects, or integrate tab testing into a Test::More suite.
homepage: http://metacpan.org/pod/Test-NoTabs
---


# perl-test-notabs

## Overview
`Test::NoTabs` is a Perl testing utility designed to scan files for hard tabs. It is primarily used within the Perl `Test::More` framework to ensure that source code adheres to "no-tabs" policies. This is critical for maintaining readability across diverse development environments where tab widths may vary. The tool can be used to scan specific files, directories, or an entire project automatically.

## Usage Patterns

### Standard Test Script
To integrate tab checking into a standard Perl test suite, create a file (e.g., `t/notabs.t`):

```perl
use Test::NoTabs;
all_perl_files_ok();
```

### Targeted File Testing
If you only want to check specific files or directories rather than the default Perl file locations:

```perl
use Test::NoTabs;
# Check specific files
notabs_ok('lib/Module.pm');
notabs_ok('bin/script.pl');

# Check a specific directory
all_perl_files_ok('src/', 'scripts/');
```

### Command Line One-Liners
For a quick check without creating a dedicated test file:

```bash
# Check all perl files in the current directory
perl -MTest::NoTabs -e 'all_perl_files_ok()'

# Check a specific file
perl -MTest::NoTabs -e 'notabs_ok("filename.pl")'
```

## Best Practices
- **Placement**: Always place tab tests in the `t/` directory of your Perl distribution so they run during `make test` or `prove`.
- **Author Testing**: Since tab violations are stylistic, consider wrapping the test in an environment check so it only runs for the author/maintainer:
  ```perl
  use Test::More;
  eval "use Test::NoTabs";
  plan skip_all => "Test::NoTabs required for testing tabs" if $@;
  all_perl_files_ok();
  ```
- **File Discovery**: `all_perl_files_ok()` automatically looks for `.pm`, `.pl`, and `.t` files. If your project uses non-standard extensions, you must specify the files individually using `notabs_ok()`.

## Reference documentation
- [Test::NoTabs Documentation](./references/metacpan_org_pod_Test-NoTabs.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-test-notabs_overview.md)