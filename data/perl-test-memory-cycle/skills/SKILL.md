---
name: perl-test-memory-cycle
description: This Perl testing utility checks objects and data structures for circular references to prevent memory leaks. Use when user asks to verify that objects have no memory cycles, check for expected circular references, or integrate memory leak testing into a Test::More suite.
homepage: http://metacpan.org/pod/Test::Memory::Cycle
---


# perl-test-memory-cycle

## Overview
`Test::Memory::Cycle` is a specialized Perl testing utility built upon `Devel::Cycle`. It provides a simple interface to ensure that objects and data structures do not contain circular references, which prevent Perl's reference-counting garbage collector from freeing memory. This skill helps you integrate these checks into standard `Test::More` suites to prevent long-running processes from consuming excessive memory.

## Basic Usage
To use this tool, include it in your test scripts (`.t` files). It exports functions that integrate directly with `Test::Builder` (the backend for `Test::More`).

### Standard Memory Check
The most common use case is verifying an object has no cycles after performing operations:

```perl
use Test::More tests => 1;
use Test::Memory::Cycle;
use MyModule;

my $obj = MyModule->new();
# ... perform operations ...

# Fails the test if any circular references are found within $obj
memory_cycle_ok($obj, "MyObject has no memory cycles");
```

### Checking for Expected Cycles
If a data structure is *intended* to have a cycle (e.g., a doubly-linked list where you haven't yet weakened the back-reference), use:

```perl
memory_cycle_exists($reference, "Check that a cycle exists as expected");
```

## Advanced Memory Testing
When dealing with "weak references" (created via `Scalar::Util::weaken`), standard checks might ignore them. Use the "weakened" variants to ensure even weakened cycles are identified or validated.

*   `weakened_memory_cycle_ok($ref)` - Checks that no cycles exist, including those involving weak references.
*   `weakened_memory_cycle_exists($ref)` - Confirms a cycle exists, even if it is a weak one.

## Best Practices
*   **Test After Destruction**: If your object has a `DESTROY` method or cleanup logic, run `memory_cycle_ok` both before and after manual cleanup to ensure the cleanup actually breaks the cycles.
*   **Deep Inspection**: The tool automatically performs a deep inspection of hashes, arrays, and nested objects. You do not need to manually iterate through an object's internals.
*   **Integration with Test::More**: Always provide a descriptive message as the second argument to help identify which specific structure failed during a large test suite run.

## Reference documentation
- [Test::Memory::Cycle - Check for memory leaks and circular memory references](./references/metacpan_org_pod_Test__Memory__Cycle.md)