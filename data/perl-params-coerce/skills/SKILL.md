---
name: perl-params-coerce
description: perl-params-coerce is a Perl utility that facilitates flexible parameter handling by automatically converting various input types into specific object classes. Use when user asks to handle flexible parameter types, convert inputs into specific Perl objects, or implement coercion methods in Perl classes.
homepage: http://metacpan.org/pod/Params::Coerce
metadata:
  docker_image: "quay.io/biocontainers/perl-params-coerce:0.14--pl526_1"
---

# perl-params-coerce

## Overview
Params::Coerce is a Perl utility designed to facilitate "Do What I Mean" (DWIM) parameter handling. It allows a class to define how it should be created from various types of input, or allows other classes to define how they can be converted into the target class. This is particularly useful in complex workflows where a function might receive a raw string, a file path, or a pre-instantiated object, and needs to ensure it is working with a specific object type before proceeding.

## Usage and Best Practices

### Core Mechanism
The tool relies on a "Coerce" function that attempts to turn a value into an object of a specific class by looking for specific method patterns:
1. **Local Coercion**: It looks for a `__as_ClassName` method in the input object.
2. **Remote Coercion**: It looks for a `from_ClassName` method in the target class.

### Implementation Patterns
When using this module within your Perl scripts, follow these patterns:

- **Importing the Coerce function**:
  ```perl
  use Params::Coerce 'coerce';
  
  # Attempt to coerce $input into a My::Object
  my $obj = coerce('My::Object', $input);
  ```

- **Handling Failure**:
  The `coerce` function returns `undef` if coercion is not possible. Always check the result:
  ```perl
  my $obj = coerce('My::Object', $input) or die "Could not coerce input to My::Object";
  ```

- **Enabling Coercion in your Classes**:
  To allow your class to be a target for coercion, implement a `from_` method:
  ```perl
  package My::Object;
  sub from_string {
      my ($class, $string) = @_;
      return $class->new(path => $string);
  }
  ```

### Expert Tips
- **Performance**: `Params::Coerce` is lightweight but involves method lookups. In tight loops processing millions of records, consider pre-validating types if the input is guaranteed to be consistent.
- **Chain of Command**: If you have multiple possible input types, `Params::Coerce` will automatically find the correct `from_` or `__as_` method, reducing the need for complex `if (ref $val eq ...)` blocks.
- **Bioconda Context**: When installed via Bioconda, ensure your `PERL5LIB` environment variable is correctly configured to include the site-perl directory where Conda installs modules.

## Reference documentation
- [Params::Coerce - MetaCPAN](./references/metacpan_org_pod_Params__Coerce.md)
- [Bioconda perl-params-coerce Overview](./references/anaconda_org_channels_bioconda_packages_perl-params-coerce_overview.md)