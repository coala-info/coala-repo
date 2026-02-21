---
name: perl-test-leaktrace
description: This skill facilitates the identification of memory leaks within Perl applications and modules.
homepage: http://metacpan.org/pod/Test-LeakTrace
---

# perl-test-leaktrace

## Overview
This skill facilitates the identification of memory leaks within Perl applications and modules. By wrapping specific blocks of code or entire test suites, it monitors the reference counts of Perl SVs (Scalar Values). It is essential for ensuring long-running processes remain stable and do not consume unbounded memory due to circular references or improper resource management.

## Usage Patterns

### Basic Leak Testing
Use `no_leaks_ok` to assert that a block of code does not leave behind any new SVs.

```perl
use Test::LeakTrace;

# Simple assertion
no_leaks_ok {
    my $data = { a => 1 };
    $data->{self} = $data; # This will leak if not weakened
} 'Check for circular reference leaks';
```

### Detailed Leak Tracing
When a leak is detected, use `leaked_info` to inspect the specific SVs that were not deallocated.

```perl
use Test::LeakTrace;

my @leaks = leaked_info {
    my $list = [];
    push @$list, $list;
};

foreach my $leak (@leaks) {
    # $leak is an arrayref: [$file, $line, $type, $value]
    printf "Leaked %s at %s line %d\n", $leak->[2], $leak->[0], $leak->[1];
}
```

### Counting Leaks
Use `count_sv` to get a baseline of existing SVs before and after an operation for manual accounting.

```perl
use Test::LeakTrace;

my $before = count_sv();
{
    my $tmp = "data";
}
my $after = count_sv();
print "SVs leaked: ", ($after - $before), "\n";
```

## Expert Tips
- **False Positives**: Be aware that Perl's internal caching (like memoization or constant folding) can sometimes look like a leak. Run the code block once before testing to "warm up" caches.
- **Weak References**: If a leak is found in a circular structure, use `Scalar::Util::weaken` to break the cycle.
- **Integration with Test::More**: This tool is designed to work seamlessly within a standard `TAP` test suite.
- **Scope**: Always ensure the code block passed to `no_leaks_ok` is self-contained. Variables declared outside the block that are modified inside may trigger false reports if they hold new references.

## Reference documentation
- [Test::LeakTrace Documentation](./references/metacpan_org_pod_Test-LeakTrace.md)