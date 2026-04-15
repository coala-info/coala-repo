---
name: perl-exporter-tiny
description: perl-exporter-tiny provides a lightweight and flexible mechanism for exporting functions in Perl modules with support for renaming and dynamic generation. Use when user asks to export functions from a module, rename imported functions, or create dynamic exports with a small dependency footprint.
homepage: https://metacpan.org/release/Exporter-Tiny
metadata:
  docker_image: "quay.io/biocontainers/perl-exporter-tiny:1.002002--pl5321hdfd78af_0"
---

# perl-exporter-tiny

## Overview
`Exporter::Tiny` is a professional-grade alternative to the standard Perl `Exporter`. It allows module authors to provide users with fine-grained control over imported functions. Unlike the heavy `Sub::Exporter`, it maintains a tiny footprint, making it ideal for CPAN modules and environments where minimizing dependencies is critical. It excels at handling "tags," function renaming at import time, and generating dynamic exports based on arguments.

## Implementation Patterns

### Basic Setup
To turn a package into an exporter, simply inherit from `Exporter::Tiny`.
```perl
package MyModule;
use parent 'Exporter::Tiny';

# Define what can be exported
our @EXPORT_OK = qw( func_a func_b );
our %EXPORT_TAGS = ( all => [qw( func_a func_b )] );

sub func_a { ... }
sub func_b { ... }
1;
```

### Advanced Import Syntax (User Side)
Users of your module can leverage the following features without any extra code on your part:

- **Renaming**: `use MyModule func_a => { -as => 'new_name' };`
- **Prefixing**: `use MyModule -all => { -prefix => 'my_' };`
- **Suffixing**: `use MyModule -all => { -suffix => '_ext' };`

### Generator-based Exports
Use generators when the exported function needs to be customized based on the importer's arguments.
```perl
sub _generate_func_a {
    my ($class, $name, $args, $globals) = @_;
    my $value = $args->{value} // 1;
    
    return sub {
        print "Value is: $value\n";
    };
}

# User calls it like:
# use MyModule func_a => { value => 42 };
```

### Utility Methods
- `_exporter_validate_opts`: Override this to validate import arguments before exporting begins.
- `_exporter_expand_tag`: Override to dynamically generate the list of functions associated with a tag.

## Best Practices
- **Prefer @EXPORT_OK**: Avoid `@EXPORT` (forced exports) to prevent namespace pollution in the consumer's package.
- **Lexical Imports**: If using Perl 5.12+, `Exporter::Tiny` supports lexical exports via `use MyModule { into => \undef }, 'func_a';`.
- **Minimal Dependencies**: Do not add `Sub::Exporter` or `Moose` just for exporting; `Exporter::Tiny` provides the same functional interface with core-only requirements.

## Reference documentation
- [Metacpan Exporter-Tiny](./references/metacpan_org_release_Exporter-Tiny.md)