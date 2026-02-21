---
name: perl-getopt-long
description: Getopt::Long is the industry-standard Perl module for parsing command-line arguments.
homepage: http://metacpan.org/pod/Getopt::Long
---

# perl-getopt-long

## Overview
Getopt::Long is the industry-standard Perl module for parsing command-line arguments. It moves beyond simple single-letter flags to support descriptive long names (e.g., `--verbose` vs `-v`) and provides automatic validation for data types. This skill helps in configuring the parser to handle complex CLI inputs, ensuring scripts are user-friendly and follow standard Unix/GNU conventions.

## Basic Implementation
To use Getopt::Long, import the module and call `GetOptions` with a mapping of option specifications to variable references.

```perl
use Getopt::Long;

my $verbose;
my $count = 1; # Default value
my $name = "default";

GetOptions (
    "verbose"  => \$verbose, # Boolean flag
    "count=i"  => \$count,   # Mandatory integer
    "name=s"   => \$name,    # Mandatory string
) or die("Error in command line arguments\n");
```

## Option Specifications
The string defining the option determines how the parser treats the following tokens:

| Specification | Description | Example |
| :--- | :--- | :--- |
| `name` | Boolean flag (no value). | `--name` |
| `name!` | Negatable boolean. | `--name` or `--no-name` |
| `name=s` | Mandatory string value. | `--name "John Doe"` |
| `name:s` | Optional string value. | `--name` or `--name "John"` |
| `name=i` | Mandatory integer value. | `--count 42` |
| `name=f` | Mandatory floating point. | `--ratio 3.14` |
| `name+` | Incremental flag. | `-v -v -v` sets value to 3 |

## Advanced Patterns

### Storing Values in Hashes
Useful for scripts with many options to avoid cluttering the namespace with individual variables.
```perl
my %opts;
GetOptions(\%opts, "length=i", "width=i", "height=i");
# Access via $opts{length}
```

### Multiple Values (Arrays)
To allow an option to be specified multiple times, use the `@` destination.
```perl
my @library_paths;
GetOptions("library=s@" => \@library_paths);
# Usage: --library /lib1 --library /lib2
```

### Key-Value Pairs (Hashes)
To capture pairs like `key=value`, use the `%` destination.
```perl
my %defines;
GetOptions("define=s%" => \%defines);
# Usage: --define OS=linux --define DEBUG=1
```

### Option Bundling
By default, Getopt::Long does not allow bundling (e.g., `-abc`). To enable this behavior (common in tools like `ls` or `tar`), use the configuration method:
```perl
Getopt::Long::Configure("bundling");
GetOptions("v" => \$verbose, "a" => \$all);
# Now supports -va
```

## Best Practices
1.  **Check Return Values**: Always check if `GetOptions` returns true. If it returns false, the user provided an invalid option or type.
2.  **Default Values**: Initialize your variables with default values before calling `GetOptions`.
3.  **Case Sensitivity**: By default, Getopt::Long is case-insensitive. Use `Getopt::Long::Configure("no_ignore_case")` if you need to distinguish between `-v` and `-V`.
4.  **Help Messages**: Combine with `Pod::Usage` to automatically generate help text from the script's POD documentation when `--help` is triggered.
5.  **The Double Dash**: Remind users that `--` can be used to signal the end of options, after which all remaining arguments are treated as non-option data (stored in `@ARGV`).

## Reference documentation
- [Getopt::Long - Extended processing of command line options](./references/metacpan_org_pod_Getopt__Long.md)