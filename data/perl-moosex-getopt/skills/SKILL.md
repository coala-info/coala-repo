---
name: perl-moosex-getopt
description: MooseX::Getopt automatically processes command-line arguments to initialize Moose class attributes. Use when user asks to create a command-line interface for Moose-based Perl applications, map CLI flags to object attributes, or handle command-line options using the new_with_options constructor.
homepage: https://github.com/moose/MooseX-Getopt
metadata:
  docker_image: "quay.io/biocontainers/perl-moosex-getopt:0.78--pl5321hdfd78af_0"
---

# perl-moosex-getopt

## Overview

MooseX::Getopt is a powerful Perl role that bridges the gap between Moose class attributes and command-line arguments. It provides an alternate constructor, `new_with_options`, which introspects a class's attributes and automatically generates a command-line interface based on their names and type constraints. This eliminates the need for manual `Getopt::Long` configuration in Moose-based applications, ensuring that the CLI remains in sync with the object model.

## Implementation Best Practices

### Basic Integration
To enable CLI support in a Moose class, consume the `MooseX::Getopt` role.

```perl
package My::App;
use Moose;
with 'MooseX::Getopt';

has 'input_file'  => (is => 'ro', isa => 'Str', required => 1, documentation => 'Path to input');
has 'output_file' => (is => 'ro', isa => 'Str', required => 1, documentation => 'Path to output');

1;
```

In your executable script, initialize the object using the specialized constructor:

```perl
#!/usr/bin/perl
use My::App;
my $app = My::App->new_with_options();
# The object is now populated with values from @ARGV
```

### Attribute to CLI Mapping
The tool automatically maps Moose types to `Getopt::Long` specifications:

| Moose Type | CLI Specification | Example Usage |
|------------|-------------------|---------------|
| `Bool` | `name!` (negatable) | `--verbose` or `--noverbose` |
| `Str` | `name=s` | `--name "some string"` |
| `Int` | `name=i` | `--count 42` |
| `Float` | `name=f` | `--ratio 3.14` |
| `ArrayRef` | `name=s@` | `--include /lib --include /usr/lib` |
| `HashRef` | `name=s%` | `--define os=linux --define arch=x86` |

### Handling Help and Usage
If `Getopt::Long::Descriptive` is installed, the skill automatically handles help flags (`-h`, `--help`, `--usage`, `-?`).
*   Use the `documentation` option in your attribute definition to provide descriptions for the help menu.
*   The program will automatically print usage text and exit if a help flag is detected.

### Advanced CLI Control
*   **Private Attributes**: Attributes starting with an underscore (e.g., `_internal`) are ignored by the CLI parser by default.
*   **Excluding Attributes**: To prevent a public attribute from being exposed to the CLI, use the `NoGetopt` trait:
    ```perl
    has 'secret' => (traits => ['NoGetopt'], is => 'ro', isa => 'Str');
    ```
*   **Leftover Arguments**: Access unparsed command-line arguments (those not matching attributes) via the `extra_argv` accessor:
    ```perl
    my $leftovers = $app->extra_argv; # Returns an ArrayRef
    ```

## Common CLI Patterns

### Boolean Flags
For a `Bool` attribute named `verbose`, the following are valid:
```bash
perl script.pl --verbose
perl script.pl --noverbose
```

### Multiple Values (Arrays)
For an `ArrayRef` attribute named `libs`:
```bash
perl script.pl --libs path1 --libs path2 --libs path3
```

### Key-Value Pairs (Hashes)
For a `HashRef` attribute named `config`:
```bash
perl script.pl --config user=admin --config mode=debug
```

### Overriding Defaults
Values passed via `new_with_options` act as defaults but are overridden by command-line arguments:
```perl
# Script default is 'out.txt'
my $app = My::App->new_with_options(output_file => 'out.txt');

# CLI override:
# perl script.pl --output_file override.txt
```

## Expert Tips

*   **Pass-through Mode**: If you need to pass unrecognized options to another class or sub-process, enable `pass_through` in your script before calling the constructor:
    ```perl
    use Getopt::Long qw(:config pass_through);
    ```
*   **Attribute Aliasing**: Use `MooseX::Getopt::Meta::Attribute::Trait` to define short aliases (e.g., mapping `--input_file` to `-i`).
*   **Precedence**: Remember the hierarchy of data: Command-line arguments > Config files (if using `MooseX::ConfigFromFile`) > Explicit constructor parameters > Attribute defaults.

## Reference documentation
- [perl-moosex-getopt Overview](./references/anaconda_org_channels_bioconda_packages_perl-moosex-getopt_overview.md)
- [MooseX::Getopt GitHub Repository](./references/github_com_moose_MooseX-Getopt.md)