---
name: perl-spiffy
description: perl-spiffy is a modular foundation class that streamlines Perl object-oriented programming by consolidating exportation, inheritance, and method handling into a single interface. Use when user asks to modernize Perl OO classes, eliminate boilerplate code, define selfless methods, create mixins, or use simplified super calls and debugging utilities.
homepage: https://github.com/ingydotnet/spiffy-pm
---


# perl-spiffy

## Overview

Spiffy (Spiffy Perl Interface Framework For You) is a modular foundation class designed to modernize Perl's Object-Oriented (OO) programming. It consolidates the functionality of `Exporter.pm`, `base.pm`, `mixin.pm`, and `SUPER.pm` into a single, streamlined interface. By using Spiffy, developers can eliminate repetitive boilerplate—such as manual object shifting and complex super-calls—while gaining powerful features like inherited exportation and source-filtered "selfless" methods.

## Core Usage and Best Practices

### Defining Classes
To establish a Spiffy-based class, use the `-base` or `-Base` flags.
- **Standard Base**: `use Spiffy -base;` provides standard OO features.
- **Selfless Base**: `use Spiffy -Base;` (capital B) or `use Spiffy -selfless;` enables a source filter that automatically inserts `my $self = shift;` at the start of every subroutine.

### Attribute Declaration
Use `field` and `const` to generate accessors automatically.
- **field**: Creates a read/write accessor.
  ```perl
  field 'mirth';
  $self->mirth(10); # Set
  my $val = $self->mirth; # Get
  ```
- **const**: Creates a read-only accessor. These are faster than fields but cannot be modified after initialization.

### Simplified Super Calls
Spiffy provides a `super` function that handles argument passing automatically.
- **Traditional Perl**: `$self->SUPER::method(@_);`
- **Spiffy**: `super;` (No arguments required; it passes the current `@_` implicitly).

### Mixins and Roles
Spiffy supports Ruby-like mixins. You can mix in functionality from other Spiffy classes using the `-mixin` flag.
- **Basic Mixin**: `use MyModule -mixin;`
- **Roles (Filtered Mixins)**: Limit which methods are imported using an exporter-style list.
  ```perl
  use MyModule -mixin => qw(method_a !method_b);
  ```

### Debugging Utilities
Spiffy exports four "dump and run" functions that use YAML (default) or Data::Dumper.
- `WWW`: Warn the dump of the arguments.
- `XXX`: Die with the dump of the arguments.
- `YYY`: Print the dump of the arguments.
- `ZZZ`: Confess (die with stack trace) the dump of the arguments.

To switch from YAML to Data::Dumper, use the `-dumper` flag: `use Spiffy -base, -dumper;`.

### Argument Parsing
For methods requiring complex argument handling, use `parse_arguments`.
1. Define `boolean_arguments` (single flags).
2. Define `paired_arguments` (key/value pairs).
3. Call `parse_arguments(@_)` to receive a hash reference of options and a list of remaining arguments.

## Expert Tips
- **Inherited Exportation**: Unlike standard Perl modules, if a Spiffy subclass exports functions, any class inheriting from that subclass automatically inherits those exports as well.
- **@EXPORT_BASE**: Use this variable instead of `@EXPORT` if you want symbols to be exported only when the module is used with the `-base` flag.
- **Performance**: Use `const` for any attribute that does not change after the object is constructed to take advantage of faster accessor execution.

## Reference documentation
- [Spiffy - Spiffy Perl Interface Framework For You](./references/github_com_ingydotnet_spiffy-pm.md)