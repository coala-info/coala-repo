---
name: perl-test-file-contents
description: This Perl module provides a declarative interface for validating and comparing the contents of files within test scripts. Use when user asks to verify file contents match a string, check files against regular expressions, or compare two files for identity.
homepage: http://search.cpan.org/dist/Test-File-Contents/
---


# perl-test-file-contents

## Overview
The `Test::File::Contents` Perl module is a testing utility designed to streamline the validation of file data. Instead of manually opening files and reading handles within test scripts, this tool provides a declarative interface to assert that a file's content is exactly what is expected. It is particularly useful for integration testing where a program's success is defined by the files it produces.

## Usage Patterns

### Basic Content Matching
Use `file_contents_is` for exact string comparisons. This is the most common check for static configuration files or fixed reports.

```perl
use Test::More;
use Test::File::Contents;

# Check if the file matches a specific string exactly
file_contents_is('output.txt', "Expected Content\n", 'Check output.txt content');

done_testing();
```

### Pattern Validation
When files contain dynamic data (like timestamps or PIDs) alongside static text, use `file_contents_like`.

```perl
# Verify file contains a specific pattern (e.g., a version string)
file_contents_like('version.log', qr/Version: \d+\.\d+/, 'Verify version format');

# Verify file does NOT contain an error string
file_contents_unlike('error.log', qr/CRITICAL_FAILURE/, 'No critical errors found');
```

### File-to-File Comparison
For regression testing where you compare new output against a "golden" reference file, use `file_contents_identical`.

```perl
# Compare two files for identity
file_contents_identical('generated_report.csv', 'references/golden_report.csv');
```

## Best Practices
- **Encoding**: By default, the tool reads files in the default layer. If working with UTF-8 or specific encodings, ensure your test environment handles layers consistently to avoid false negatives on line endings or special characters.
- **Path Management**: Always use absolute paths or paths relative to the project root (often handled via `FindBin` or `File::Spec`) to ensure tests run reliably across different environments.
- **Granularity**: Use `file_contents_like` for large log files where you only care about the presence of specific events, rather than `file_contents_is`, which will fail on any minor whitespace or metadata change.

## Reference documentation
- [Test-File-Contents CPAN Documentation](./references/metacpan_org_release_Test-File-Contents.md)