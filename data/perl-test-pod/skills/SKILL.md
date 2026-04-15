---
name: perl-test-pod
description: This tool verifies the syntax and integrity of Perl Plain Old Documentation (POD) files. Use when user asks to check POD files for errors, validate documentation syntax, or integrate POD testing into a Perl test suite.
homepage: http://search.cpan.org/dist/Test-Pod/
metadata:
  docker_image: "quay.io/biocontainers/perl-test-pod:1.52--pl526_0"
---

# perl-test-pod

## Overview
This skill provides guidance on using `Test::Pod` to verify the integrity of Perl documentation. It is essential for Perl module developers to ensure that their POD is free of syntax errors, unclosed tags, or formatting issues that could break documentation rendering.

## Usage Patterns

### Basic Test Script
To integrate POD testing into a standard Perl test suite, create a file named `t/pod.t`:

```perl
use Test::More;
eval "use Test::Pod 1.48";
plan skip_all => "Test::Pod 1.48 required for testing POD" if $@;
all_pod_files_ok();
```

### Testing Specific Files
If you only want to test specific files rather than the entire distribution:

```perl
use Test::Pod;
pod_file_ok( "lib/My/Module.pm", "Validating POD for My::Module" );
```

### Finding POD Files
The `all_pod_files()` function can be used to retrieve a list of files that appear to contain POD, which is useful for custom test loops:

```perl
my @files = all_pod_files(@directories);
foreach my $file (@files) {
    pod_file_ok($file);
}
```

## Best Practices
- **Version Requirement**: Always require at least version 1.48 of `Test::Pod` to ensure compatibility with modern POD features.
- **Author Testing**: Wrap POD tests in an environment variable check (e.g., `RELEASE_TESTING` or `AUTHOR_TESTING`) so they don't fail for end-users who may not have the module installed.
- **Encoding**: Ensure your POD files use `=encoding utf8` if they contain non-ASCII characters, as `Test::Pod` will validate encoding consistency.

## Reference documentation
- [Test-Pod on MetaCPAN](./references/metacpan_org_release_Test-Pod.md)