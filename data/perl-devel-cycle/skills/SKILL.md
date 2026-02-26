---
name: perl-devel-cycle
description: This tool traverses Perl reference trees to identify circularities and memory leaks. Use when user asks to find memory cycles in objects, detect circular references in data structures, or debug memory leaks in Perl code.
homepage: http://metacpan.org/pod/Devel::Cycle
---


# perl-devel-cycle

## Overview
The `perl-devel-cycle` skill provides tools to traverse Perl reference trees and identify circularities. Because Perl uses reference counting for memory management, any group of objects that reference each other will never have their reference counts reach zero, leading to persistent memory leaks. This skill enables the developer to find these cycles, including those hidden within code closures (if PadWalker is installed) and weakened references.

## Usage Patterns

### Basic Cycle Detection
To find cycles in a data structure or object, use the `find_cycle` function. By default, it prints a report to STDOUT.

```perl
use Devel::Cycle;

my $data = { a => 1 };
$data->{self} = $data; # Create a cycle

find_cycle($data);
```

### Handling Weak References
If you are using `Scalar::Util::weaken` to prevent leaks, use `find_weakened_cycle` to see if the cycles are properly weakened or if strong cycles still exist.

```perl
use Devel::Cycle;
use Scalar::Util 'weaken';

my $obj = { name => 'parent' };
$obj->{child} = { parent => $obj };
weaken($obj->{child}->{parent});

# This will report the cycle and indicate it is weakened (w->)
find_weakened_cycle($obj);
```

### Controlling Output Format
You can change how the memory references are displayed by setting `$Devel::Cycle::FORMATTING` or using import flags.

*   **cooked** (Default): Uses readable aliases like `$A`, `$B`.
*   **raw**: Shows actual memory addresses (e.g., `HASH(0x8124394)`).
*   **roasted**: Similar to cooked but formats object references differently.

```perl
# At compile time
use Devel::Cycle -raw;

# Or at runtime
use Devel::Cycle;
$Devel::Cycle::FORMATTING = 'roasted';
find_cycle($target);
```

### Custom Callbacks
Instead of printing to STDOUT, you can process cycle data programmatically by providing a callback. The callback receives an array reference of edges.

```perl
find_cycle($obj, sub {
    my $path = shift;
    foreach my $edge (@$path) {
        my ($type, $index, $ref, $value) = @$edge;
        print "Found $type at index $index\n";
    }
});
```

## Expert Tips and Best Practices

*   **Closure Debugging**: If your cycles involve subroutines or closures, ensure `PadWalker` is installed. `Devel::Cycle` will automatically attempt to use it to peek into lexical scopes.
*   **Suppressing Warnings**: If you cannot install `PadWalker` and want to ignore the warnings about being unable to inspect CODE references, use the `-quiet` flag: `use Devel::Cycle -quiet;`.
*   **Test Integration**: For automated regression testing, use this in conjunction with `Test::Memory::Cycle` to ensure new code changes don't introduce circularities.
*   **Large Structures**: Be cautious when running `find_cycle` on extremely deep or complex singleton objects in production, as the traversal can be resource-intensive.

## Reference documentation
- [Devel::Cycle - Find memory cycles in objects](./references/metacpan_org_pod_Devel__Cycle.md)
- [perl-devel-cycle - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-devel-cycle_overview.md)