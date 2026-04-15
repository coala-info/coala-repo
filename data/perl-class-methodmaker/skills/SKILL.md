---
name: perl-class-methodmaker
description: Class::MethodMaker is a Perl module that automates the creation of common class methods and accessors through a declarative syntax. Use when user asks to generate getter and setter methods, manage list or hash-based attributes, or reduce boilerplate code in Perl object-oriented programming.
homepage: http://search.cpan.org/~schwigon/Class-MethodMaker-2.24/
metadata:
  docker_image: "quay.io/biocontainers/perl-class-methodmaker:2.25--pl5321h7b50bb2_1"
---

# perl-class-methodmaker

## Overview
Class::MethodMaker is a meta-programming tool for Perl that automates the creation of common class methods. Instead of manually writing subroutines for getting and setting attributes, handling lists, or managing hash-based data structures, you define the desired components in a declarative syntax. This approach minimizes repetitive "boilerplate" code, reduces the surface area for bugs in basic accessors, and enforces a standard API across your object model.

## Implementation Patterns

### Basic Usage
To use Class::MethodMaker, invoke it during the `use` statement. The module acts on the calling package.

```perl
package My::App::User;
use Class::MethodMaker
  [ scalar => [qw( name email age )],
    new    => [qw( new )],
  ];
```

### Common Method Types

- **scalar**: Creates basic get/set methods.
  - `$obj->name('Alice')` sets the value.
  - `$obj->name` retrieves the value.
- **list**: Manages array-based attributes with helper methods.
  - Creates `attribute`, `attribute_push`, `attribute_pop`, `attribute_shift`, etc.
- **hash**: Manages key-value pairs within an attribute.
  - Creates `attribute`, `attribute_keys`, `attribute_exists`, `attribute_delete`.
- **boolean**: Creates toggle and check methods.
  - Creates `is_attribute`, `set_attribute`, `clear_attribute`.

### Advanced Configuration
You can provide options to method types by using a hash reference instead of an array reference for the definitions.

```perl
use Class::MethodMaker
  [ scalar => [{ -type => 'DateTime' }, 'created_at'],
    new    => [ 'new', 'init' ],
  ];
```

## Best Practices
- **Initialization**: Use the `new` method type to generate standard constructors. If you need custom logic, define an `init` method which Class::MethodMaker's generated `new` will call automatically.
- **Namespace Cleanliness**: Be aware that Class::MethodMaker installs methods directly into the current package's symbol table.
- **Inheritance**: Methods generated are standard Perl subroutines and behave correctly with `@ISA` and `SUPER::` calls.
- **Performance**: Generated methods are generally as fast as hand-written Perl accessors, but for extremely high-performance hot paths, verify if the overhead of the generic wrapper is acceptable.

## Reference documentation
- [Class::MethodMaker CPAN Documentation](./references/metacpan_org_release_SCHWIGON_Class-MethodMaker-2.24.md)