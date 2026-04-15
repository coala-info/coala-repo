---
name: perl-params-util
description: This tool provides lightweight functions for validating Perl data types and object instances to ensure input reliability. Use when user asks to validate strings or identifiers, check array or hash references, and verify object instances or class names in Perl.
homepage: http://metacpan.org/pod/Params::Util
metadata:
  docker_image: "quay.io/biocontainers/perl-params-util:1.102--pl5321h9f5acd7_1"
---

# perl-params-util

## Overview
The `perl-params-util` skill facilitates the implementation of the `Params::Util` module for defensive programming in Perl. It provides a suite of lightweight, standalone functions designed to validate untrusted input at the edges of an API. By using these functions, you ensure that variables contain the expected data types or object instances before processing them, reducing boilerplate code and improving reliability.

## Implementation Patterns

### Import Functions
Import only the necessary validation functions to keep the namespace clean, or use the `:ALL` tag for rapid development.

```perl
use Params::Util qw(_STRING _ARRAY _INSTANCE);
# OR
use Params::Util ':ALL';
```

### Validate Basic Types
Use these functions to check for defined, non-empty values.

- **_STRING($val)**: Returns the string if it is a normal non-false string of non-zero length; otherwise returns `undef`.
- **_IDENTIFIER($val)**: Returns the string if it is a valid Perl identifier.
- **_POSINT($val)**: Validates that the input is a positive integer (greater than zero).
- **_NONNEGINT($val)**: Validates that the input is a non-negative integer (zero or greater).

### Validate References
Ensure that parameters are the correct reference type before dereferencing.

- **_ARRAY($val)**: Returns the reference if it is a "real" ARRAY reference.
- **_ARRAY0($val)**: Returns the reference if it is an ARRAY reference, even if empty.
- **_ARRAYLIKE($val)**: Returns the reference if it is an ARRAY or an object that behaves like one.
- **_HASH($val)**: Returns the reference if it is a "real" HASH reference.
- **_CODE($val)**: Returns the reference if it is a CODE reference.

### Validate Objects and Classes
Perform strict checks on class names and object instances.

- **_INSTANCE($object, 'ClassName')**: Returns the object if it is an instance of the specified class.
- **_CLASS($string)**: Returns the string if it is a valid Perl class name (checks format, not if loaded).
- **_CLASSISA($string, 'ParentClass')**: Returns the string if it is a valid class and is a subclass of the parent.
- **_DRIVER($string)**: Returns the string if it is a valid class name in the format `Parent::Name`, often used for driver/plugin loading.

## Best Practices
- **API Boundaries**: Apply `Params::Util` checks at the start of subroutines receiving data from external sources or other modules.
- **Concise Error Handling**: Use the functions in logical OR statements for short-circuiting: `my $data = _ARRAY(shift) or return undef;`.
- **Strictness**: Prefer `_ARRAY` over `_ARRAYLIKE` unless you explicitly want to support objects that use overloading to mimic arrays.
- **Installation**: When working in Conda environments, ensure the package is available via `conda install bioconda::perl-params-util`.

## Reference documentation
- [Params::Util - Simple, compact and correct param-checking functions](./references/metacpan_org_pod_Params__Util.md)
- [perl-params-util - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-params-util_overview.md)