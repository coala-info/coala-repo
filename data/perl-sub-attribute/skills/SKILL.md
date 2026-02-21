---
name: perl-sub-attribute
description: This skill facilitates the implementation of custom subroutine attributes in Perl using the `Sub::Attribute` module.
homepage: http://metacpan.org/pod/Sub::Attribute
---

# perl-sub-attribute

## Overview
This skill facilitates the implementation of custom subroutine attributes in Perl using the `Sub::Attribute` module. Unlike the standard `Attribute::Handlers`, which can fail during run-time `eval()`, this tool provides a robust and consistent interface for intercepting subroutine definitions and applying custom logic based on their attributes. It is particularly useful for creating frameworks where subroutines need to be "tagged" with specific behaviors or metadata at compile time.

## Implementation Patterns

### Defining an Attribute Handler
To create a custom attribute, define a method in a base package and mark it with the `:ATTR_SUB` meta-attribute.

```perl
package My::Attribute::Provider;
use Sub::Attribute;

# The handler name matches the attribute name used later
sub MyTask :ATTR_SUB {
    my ($class, $sym_ref, $code_ref, $attr_name, $attr_data) = @_;
    
    # $sym_ref:  Typeglob of the sub (e.g., \*main::something)
    # $code_ref: Reference to the actual sub code
    # $attr_name: Name of the attribute ('MyTask')
    # $attr_data: Data passed in parens (e.g., 'priority=1')
    
    print "Applying $attr_name to " . *{$sym_ref}{NAME} . " with data: $attr_data\n";
}
```

### Consuming the Attribute
To use the defined attribute, a package must inherit from the provider.

```perl
package My::App;
use parent qw(My::Attribute::Provider);

sub process_data :MyTask(high_priority) {
    # ... logic ...
}
```

## Expert Tips & Best Practices

- **Reliability**: Prefer `Sub::Attribute` over `Attribute::Handlers` if your code uses string `eval` to define subroutines at runtime, as `Sub::Attribute` correctly triggers handlers in those contexts.
- **Argument Handling**: The `$attr_data` argument is passed as a raw string (whatever is inside the parentheses). If you need complex data structures, you must parse this string manually (e.g., using `eval` or a regex) within your handler.
- **Debugging**: If attributes are not being applied as expected, set the environment variable `SUB_ATTRIBUTE_DEBUG=1`. This causes the module to issue warnings via `warn()` explaining how and when attributes are being applied.
- **Inheritance**: Remember that attributes are resolved via the inheritance tree. The package defining the subroutine must have the attribute handler in its `@ISA` chain.

## Reference documentation
- [Sub::Attribute - Reliable subroutine attribute handlers](./references/metacpan_org_pod_Sub__Attribute.md)