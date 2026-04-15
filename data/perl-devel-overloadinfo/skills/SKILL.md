---
name: perl-devel-overloadinfo
description: This tool provides introspection for Perl's operator overloading to identify which packages and methods implement specific behaviors. Use when user asks to check if an object is overloaded, retrieve metadata for a specific operator, or audit all overloaded operators within a class.
homepage: http://metacpan.org/pod/Devel::OverloadInfo
metadata:
  docker_image: "quay.io/biocontainers/perl-devel-overloadinfo:0.007--pl5321hdfd78af_0"
---

# perl-devel-overloadinfo

## Overview
This skill provides a specialized interface for using the `Devel::OverloadInfo` Perl module. While Perl's native `overload::Overloaded()` can be buggy in older versions, this tool offers a robust way to determine if an object is overloaded and, more importantly, provides a detailed map of the implementation. Use this to resolve "magic" behavior in complex object-oriented Perl codebases where it is unclear which package is controlling operator behavior.

## Core Functions

### Checking for Overloading
To check if a class or object has any overloading defined (including a bare `use overload;` with no operators):

```perl
use Devel::OverloadInfo qw(is_overloaded);

if (is_overloaded($object_or_class)) {
    # Returns true if any overloading exists
}
```

### Detailed Operator Introspection
To get metadata for a specific operator (e.g., stringification `""` or addition `+`):

```perl
use Devel::OverloadInfo qw(overload_op_info);

my $info = overload_op_info($object, '""');
# Returns undef if not overloaded, otherwise a hash ref:
# {
#   class       => "My::Package",        # Where the overload was declared
#   code        => \&sub_ref,            # Reference to the implementation
#   code_name   => "My::Package::as_str",# Fully qualified name
#   method_name => "as_str",             # Optional: method name if string-based
#   code_class  => "My::Base",           # Optional: where the method was found
# }
```

### Full Class Audit
To retrieve information for every overloaded operator defined for a target:

```perl
use Devel::OverloadInfo qw(overload_info);

my $all_overloads = overload_info($class_name);
foreach my $op (keys %$all_overloads) {
    printf "Operator %s implemented in %s\n", $op, $all_overloads->{$op}{class};
}
```

## Expert Tips
- **Inheritance Resolution**: Use `overload_op_info` to debug "Method not found" errors in overloaded contexts. It explicitly separates `class` (where the overload was declared) from `code_class` (where the implementing method actually resides).
- **Fallback Behavior**: Be aware that the `fallback` key's existence in the returned hash varies by Perl version. Before 5.18, it exists even if undef; in 5.18+, it may be missing if it has the default value.
- **Operator Names**: When querying specific operators, use the keys defined in `%overload::ops` (e.g., `0+` for numification, `bool` for boolean context).

## Reference documentation
- [Devel::OverloadInfo Documentation](./references/metacpan_org_pod_Devel__OverloadInfo.md)