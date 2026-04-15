---
name: perl-tie-toobject
description: This tool associates a Perl variable with an existing object to delegate variable operations to that object's methods. Use when user asks to tie a scalar, hash, or array to a pre-constructed object, delegate variable access to an existing reference, or maintain object state across multiple tied variables.
homepage: http://metacpan.org/pod/Tie::ToObject
metadata:
  docker_image: "quay.io/biocontainers/perl-tie-toobject:0.03--pl526_1"
---

# perl-tie-toobject

## Overview
The `Tie::ToObject` module provides a mechanism to associate a Perl variable with an object that has already been constructed. While standard Perl `tie` implementations typically call a constructor like `TIESCALAR` or `TIEHASH` to create a new internal object, this tool allows you to pass an existing reference. This is essential for scenarios where an object must maintain state across multiple tied variables or when the object requires complex initialization that the standard `tie` interface does not support.

## Usage Patterns

### Tying to a Hash
To delegate hash operations (FETCH, STORE, etc.) to an existing object:
```perl
use Tie::ToObject;

my $object = MyImplementation->new(%args);
tie my %hash, 'Tie::ToObject', $object;

# Operations on %hash now call methods on $object
$hash{key} = "value"; # Calls $object->STORE("key", "value")
```

### Tying to a Scalar
To delegate scalar access to an existing object:
```perl
use Tie::ToObject;

my $object = MyScalarLogic->new();
tie my $scalar, 'Tie::ToObject', $object;

$scalar = "new value"; # Calls $object->STORE("new value")
print $scalar;         # Calls $object->FETCH()
```

### Tying to an Array
To delegate array indexing and manipulation:
```perl
use Tie::ToObject;

my $object = MyArrayLogic->new();
tie my @array, 'Tie::ToObject', $object;

push @array, "item"; # Calls $object->PUSH("item")
my $val = $array[0]; # Calls $object->FETCH(0)
```

## Best Practices
- **Method Implementation**: Ensure the object being tied implements the standard Perl tie methods (`FETCH`, `STORE`, `EXISTS`, `DELETE`, `CLEAR`, etc.) for the specific variable type being used.
- **Object Persistence**: The tied variable holds a reference to the object. The object will not be destroyed as long as the variable remains tied or in scope.
- **Direct Access**: You can still call regular methods on the `$object` directly; the tied interface simply provides a way to use standard Perl variable syntax as a proxy for those method calls.

## Reference documentation
- [Tie::ToObject Documentation](./references/metacpan_org_pod_Tie__ToObject.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-tie-toobject_overview.md)