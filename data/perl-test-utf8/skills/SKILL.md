---
name: perl-test-utf8
description: The perl-test-utf8 tool provides functions for testing the UTF-8 state and validity of strings within a Perl testing environment. Use when user asks to check if a string has the UTF-8 flag set, verify valid UTF-8 byte sequences, or detect double-encoding and mojibake in Perl scripts.
homepage: https://github.com/2shortplanks/Test-utf8/tree
metadata:
  docker_image: "quay.io/biocontainers/perl-test-utf8:1.03--pl5321hdfd78af_0"
---

# perl-test-utf8

## Overview
The `Test::utf8` Perl module provides a set of handy functions for testing Unicode and UTF-8 strings within a standard `Test::More` environment. While Perl's internal handling of strings is robust, it is common to encounter issues where strings are not correctly upgraded to UTF-8 or where raw bytes are treated as characters. This skill helps you implement precise checks to ensure data integrity across encoding boundaries.

## Usage Patterns

### Core Testing Functions
Use these functions within your `.t` scripts to validate string states:

- `is_utf8($string, $name)`: Checks if the UTF-8 flag is turned on for the given string. This is essential for ensuring Perl treats the string as characters rather than raw bytes.
- `is_valid_utf8($string, $name)`: Checks if a scalar contains a valid sequence of UTF-8 bytes. This is useful for testing data recently read from a filehandle or socket before it is decoded.
- `is_within_ascii($string, $name)`: Verifies that a string contains only ASCII characters (code points 0-127).
- `is_within_latin_1($string, $name)`: Verifies that a string contains only Latin-1 characters (code points 0-255).

### Detecting Encoding Errors
One of the most powerful features of this tool is identifying "mojibake" or double-encoding:

- `is_sane_utf8($string, $name)`: A heuristic test that looks for byte sequences that are technically valid UTF-8 but highly unlikely in normal text (often indicating double-encoding).

### Best Practices
- **Layering Tests**: Always use `is_utf8()` to check the internal state and `is_valid_utf8()` to check the payload if you are dealing with raw buffers.
- **Integration**: Combine with `Test::More`. `Test::utf8` exports its functions by default, making them available alongside standard `ok()` and `is()` functions.
- **Boilerplate**:
  ```perl
  use Test::More tests => 3;
  use Test::utf8;

  my $str = "Scheckter\x{2019}s";
  is_utf8($str, "String should be flagged as UTF-8");
  is_valid_utf8($str, "String contains valid sequences");
  is_sane_utf8($str, "String does not look double-encoded");
  ```

## Reference documentation
- [perl-test-utf8 Overview](./references/anaconda_org_channels_bioconda_packages_perl-test-utf8_overview.md)