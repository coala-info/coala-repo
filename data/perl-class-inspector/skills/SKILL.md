---
name: perl-class-inspector
description: This skill provides a programmatic interface for inspecting Perl classes.
homepage: http://metacpan.org/pod/Class-Inspector
---

# perl-class-inspector

## Overview
This skill provides a programmatic interface for inspecting Perl classes. It is particularly useful for dynamic code analysis, debugging dependency issues, and verifying the runtime state of Perl modules. Instead of manually parsing files, it uses the `Class::Inspector` API to provide reliable metadata about any loaded or installable class.

## Usage Guidelines

### Core Inspection Methods
Use the following methods to query class information:

- **Check if a class is loaded**: `Class::Inspector->loaded( 'My::Class' )` returns true if the class is already in memory.
- **Find module location**: `Class::Inspector->resolved_filename( 'My::Class' )` returns the absolute path to the `.pm` file.
- **List methods**: 
    - `Class::Inspector->methods( 'My::Class', 'public' )` returns only public methods.
    - `Class::Inspector->methods( 'My::Class', 'full' )` returns fully qualified method names.
    - `Class::Inspector->methods( 'My::Class', 'expanded' )` returns a list of array references containing `[ 'Package::Name', 'method_name' ]`.

### Advanced Discovery
- **Subclasses**: Use `Class::Inspector->subclasses( 'My::Class' )` to find all loaded classes that inherit from the target class.
- **Function List**: Use `Class::Inspector->functions( 'My::Class' )` to get a list of all functions defined in the package namespace, regardless of whether they are intended as methods.

### Best Practices
- **Validation**: Always use `Class::Inspector->installed( 'My::Class' )` before attempting to load or inspect a class that might not exist in `@INC`.
- **Performance**: Method resolution can be expensive on large inheritance trees. Cache the results of `methods()` if you need to reference them multiple times in a single execution.
- **Namespace Safety**: Be aware that `functions()` will return everything in the symbol table, including imported constants and internal helper functions. Use `methods()` for object-oriented introspection.

## Reference documentation
- [Class::Inspector Documentation](./references/metacpan_org_pod_Class-Inspector.md)