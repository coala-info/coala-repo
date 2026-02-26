---
name: perl-extutils-helpers
description: This tool provides portability utilities for Perl module builders to ensure consistent behavior across different operating systems. Use when user asks to make scripts executable, split strings like a shell, resolve home directory paths, or generate platform-specific man page names.
homepage: http://metacpan.org/pod/ExtUtils::Helpers
---


# perl-extutils-helpers

## Overview
This skill provides guidance on using `ExtUtils::Helpers`, a collection of portability utilities designed for Perl module builders. It ensures that common installation tasks—such as making scripts executable or calculating man page paths—behave consistently across different operating systems, including Unix-like systems and Windows.

## Core Functions and Usage

### Script Portability
When generating or installing scripts, use `make_executable` to ensure the file has the correct permissions or wrappers for the local platform.
```perl
use ExtUtils::Helpers qw/make_executable/;

my $script = 'bin/my-tool';
# Ensures the script is runnable on Unix (chmod +x) or Windows (wrappers)
make_executable($script);
```

### Command Line Parsing
To handle environment variables or strings containing multiple arguments in a way that respects the local shell's quoting rules, use `split_like_shell`.
```perl
use ExtUtils::Helpers qw/split_like_shell/;

my $opts = $ENV{MY_MODULE_OPTS} || "";
my @args = split_like_shell($opts);
```

### Path Manipulation
Use `detildefy` to resolve home directory shortcuts (`~`) into absolute paths. This is safer than manual regex replacement as it follows platform-specific logic.
```perl
use ExtUtils::Helpers qw/detildefy/;

my $path = detildefy('~/perl5/lib');
```

### Documentation Management
When installing man pages, use the following helpers to determine the correct destination filename based on the system's configuration (e.g., `$Config{man1ext}`).

*   **For Scripts (Section 1):**
    `man1_pagename($filename, $ext)`
*   **For Libraries (Section 3):**
    `man3_pagename($filename, $basedir, $ext)`
    *   Default `$basedir` is 'lib'.
    *   It converts directory separators to dots (e.g., `Foo/Bar.pm` becomes `Foo::Bar.3`).

## Best Practices
*   **Avoid Manual Chmod:** Always prefer `make_executable` over `chmod 0755` to maintain compatibility with Windows environments where `chmod` may not behave as expected for execution.
*   **Consistent Argument Handling:** Use `split_like_shell` when processing options passed via environment variables to ensure that quoted strings with spaces are handled correctly.
*   **Configuration Defaults:** When using man page helpers, you typically do not need to provide the `$ext` argument; the module automatically fetches the correct extension from the Perl `%Config` hash.

## Reference documentation
- [ExtUtils::Helpers - Various portability utilities for module builders](./references/metacpan_org_pod_ExtUtils__Helpers.md)