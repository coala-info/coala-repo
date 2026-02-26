---
name: perl-types-serialiser
description: This tool provides a common repository of simple data types to ensure data integrity when serializing Perl objects into formats like JSON or CBOR. Use when user asks to handle boolean constants, check for serializable error types, or implement FREEZE and THAW methods for custom object serialization.
homepage: http://metacpan.org/pod/Types::Serialiser
---


# perl-types-serialiser

## Overview
This skill facilitates the use of `Types::Serialiser`, a Perl module providing a common repository of simple data types. It is essential for maintaining data integrity when serializing Perl objects into formats that distinguish between types that Perl often treats interchangeably (like integers vs. booleans). Use this to ensure that `1` remains `true` and `0` remains `false` when passed between different serialization implementations.

## Core Data Types

### Booleans
Use these constants to ensure JSON/CBOR encoders recognize values as booleans rather than integers.

- **True**: `$Types::Serialiser::true` or `Types::Serialiser::true`
- **False**: `$Types::Serialiser::false` or `Types::Serialiser::false`

**Utility Functions:**
- `Types::Serialiser::as_bool $value`: Converts a Perl scalar to a `Types::Serialiser` boolean.
- `Types::Serialiser::is_bool $value`: Checks if a scalar is a `Types::Serialiser` boolean instance.
- `Types::Serialiser::is_true $value` / `is_false $value`: Specific type checks.

### Error Handling
The `Types::Serialiser::error` value is used to represent values that cannot be encoded (e.g., "undefined" in CBOR).
- **Accessing** an error type value will throw an exception.
- **Check**: `Types::Serialiser::is_error $value`

## Object Serialization Protocol
When creating custom classes that need to be serialized, implement the `FREEZE` and `THAW` methods.

### FREEZE (Encoding)
The encoder calls this method to transform an object into serializable data.
- **Arguments**: `($self, $model)` where `$model` is a string like 'JSON' or 'CBOR'.
- **Requirement**: Must return a list of values representing the object. Do NOT modify the object state during this call.

### THAW (Decoding)
The decoder calls this to reconstruct the object.
- **Arguments**: `($class, $model, @data)` where `@data` is the list previously returned by `FREEZE`.

```perl
# Example Implementation
sub FREEZE {
    my ($self, $model) = @_;
    return ($self->{id}, $self->{data});
}

sub THAW {
    my ($class, $model, $id, $data) = @_;
    return $class->new(id => $id, data => $data);
}
```

## Expert Tips
- **XS Performance**: For XS module developers, check the stash pointer against `Types::Serialiser::Boolean` or `Types::Serialiser::Error` for the fastest type detection.
- **Compatibility**: `Types::Serialiser::Boolean` is aliased to `JSON::PP::Boolean` for historical reasons; `isa` tests will work for both.
- **Memory Overhead**: Be aware that this module loads the `overload` module, which increases the memory footprint (RSS) of the Perl process.

## Reference documentation
- [Types::Serialiser - simple data types for common serialisation formats](./references/metacpan_org_pod_Types__Serialiser.md)