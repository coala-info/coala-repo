---
name: perl-sub-exporter-progressive
description: This Perl tool provides a lightweight export interface that automatically upgrades to Sub::Exporter when advanced features are required. Use when user asks to implement progressive exporting, manage export dependencies, or define exportable subroutines and groups in a Perl module.
homepage: http://search.cpan.org/dist/Sub-Exporter-Progressive/
metadata:
  docker_image: "quay.io/biocontainers/perl-sub-exporter-progressive:0.001013--pl526_0"
---

# perl-sub-exporter-progressive

## Overview

`Sub::Exporter::Progressive` is a specialized Perl tool designed for module authors who want to provide a sophisticated export interface without forcing a heavy dependency on `Sub::Exporter` for every user. It acts as a wrapper that uses the standard, lightweight `Exporter.pm` by default, but automatically upgrades to the full `Sub::Exporter` capabilities only if the user requests advanced features (like generators or renaming). This skill helps you implement this "best of both worlds" approach in your Perl distributions.

## Implementation Patterns

### Basic Setup
To use this tool in your module, replace `use Exporter;` or `use Sub::Exporter;` with the following pattern:

```perl
package Your::Module;
use Sub::Exporter::Progressive -setup => {
    exports => [ qw(func1 func2) ],
    groups  => { default => [ qw(func1) ] },
};
```

### Defining Exports
Define your exportable subroutines within the `-setup` hash:
- **exports**: An array reference of subroutine names available for export.
- **groups**: A hash reference defining collections of subroutines (e.g., `:all`, `:default`).

### Advanced Features (Automatic Upgrade)
When a consumer of your module uses advanced syntax, the tool automatically loads `Sub::Exporter`. You do not need to write conditional loading logic yourself.

Example of a consumer trigger that forces the upgrade:
```perl
use Your::Module func1 => { -as => 'my_func' };
```

## Best Practices

- **Dependency Management**: Always list `Sub::Exporter::Progressive` in your `PREREQ_PM`. You should generally list `Sub::Exporter` as an optional dependency (e.g., in `Recommends`) rather than a hard requirement to maintain the "progressive" benefit.
- **Simplicity First**: Only use the `-setup` syntax for standard exports. If your module requires complex tags or generators that *always* need `Sub::Exporter`, using the progressive version adds unnecessary overhead.
- **Avoid Manual @EXPORT**: Do not manually manipulate `@EXPORT` or `@EXPORT_OK` when using this module; let the `-setup` arguments handle the symbol table injections.

## Reference documentation

- [Sub::Exporter::Progressive on MetaCPAN](./references/metacpan_org_release_Sub-Exporter-Progressive.md)