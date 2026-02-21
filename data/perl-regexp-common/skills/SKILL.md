---
name: perl-regexp-common
description: The `perl-regexp-common` skill leverages the `Regexp::Common` Perl module to provide a robust library of regular expressions.
homepage: http://metacpan.org/pod/Regexp::Common
---

# perl-regexp-common

## Overview
The `perl-regexp-common` skill leverages the `Regexp::Common` Perl module to provide a robust library of regular expressions. Instead of manually crafting complex patterns for common tasks—such as matching real numbers with specific separators or finding balanced parentheses—you can use the exported `%RE` hash or subroutine interface. This ensures higher reliability and readability in Perl scripts and one-liners.

## Core Usage Patterns

### The %RE Hash Interface
The most common way to use the tool is through the `%RE` hash. Patterns are accessed via hierarchical keys.

```perl
use Regexp::Common;

# Match a real number
if ($val =~ /$RE{num}{real}/) { ... }

# Match a quoted string (handles single, double, and backticks)
if ($str =~ /$RE{quoted}/) { ... }

# Match balanced parentheses
if ($text =~ /$RE{balanced}{-parens=>'()'}/) { ... }
```

### Using Flags
Flags modify the behavior of the pattern. They are passed as keys starting with a minus sign.

```perl
# Match a base-2 (binary) integer with commas every 3 digits
$RE{num}{int}{-base => 2}{-sep => ','}{-group => 3}

# Match a delimited string using '/' as the delimiter
$RE{delimited}{-delim=>'/'}
```

### Object-Oriented Methods
For cleaner syntax in substitutions or boolean checks, use the built-in methods:

```perl
# Boolean match check
if ($RE{num}{int}->matches($input)) { ... }

# Substitution (cropping whitespace)
my $clean = $RE{ws}{crop}->subs($dirty);
```

### Subroutine-Based Interface
If you prefer functions over hashes, import `RE_ALL` or specific sets.

```perl
use Regexp::Common 'RE_ALL';

if ($_ =~ RE_num_real()) { print "Found a number"; }
```

## CLI One-Liner Patterns
`Regexp::Common` is highly effective for quick data filtering from the command line.

```bash
# Extract all lines containing a valid real number
perl -MRegexp::Common -ne 'print if /$RE{num}{real}/' data.txt

# Remove all quoted strings from a file
perl -MRegexp::Common -pe '$_ = $RE{quoted}->subs($_, "")' input.txt

# Find lines with balanced brackets
perl -MRegexp::Common -ne 'print if /$RE{balanced}{-parens=>"[]"}/' config.json
```

## Expert Tips
- **Selective Loading**: To save memory and startup time in large scripts, load only the categories you need: `use Regexp::Common qw/number quoted/;`.
- **Custom Patterns**: You can extend the library using the `pattern` function to create reusable, named regexes that follow the tool's internal logic.
- **No Defaults**: Use `use Regexp::Common qw/no_defaults/;` if you want to manually specify every pattern set to be loaded, preventing namespace bloat.

## Reference documentation
- [Regexp::Common - Provide commonly requested regular expressions](./references/metacpan_org_pod_Regexp__Common.md)