---
name: perl-experimental
description: The `experimental` pragma simplifies the use of Perl's evolving feature set.
homepage: http://metacpan.org/pod/experimental
---

# perl-experimental

## Overview
The `experimental` pragma simplifies the use of Perl's evolving feature set. Instead of requiring developers to track which version of Perl introduced a feature or which specific warning category needs to be disabled (e.g., `use feature 'signatures'; no warnings 'experimental::signatures';`), this skill allows for a single, clean declaration. It is particularly useful for maintaining readability in modern Perl scripts and ensuring compatibility with the `warnings` pragma.

## Usage Patterns

### Enabling Features
To enable one or more experimental features in the current lexical scope, use the following syntax:

```perl
use experimental 'signatures', 'try';

sub add($x, $y) {
    try {
        return $x + $y;
    }
    catch ($e) {
        warn "Addition failed: $e";
    }
}
```

### Disabling Features
To explicitly disable a feature and re-enable its associated warnings:

```perl
no experimental 'smartmatch';
```

### Common Feature Keys
Use these keys based on the Perl version available:
- `signatures`: Subroutine signatures (Perl 5.20+)
- `try`: Native try/catch syntax (Perl 5.34+)
- `class`: New object-oriented syntax (class, field, method) (Perl 5.38+)
- `builtin`: Functions in the `builtin::` namespace (Perl 5.36+)
- `defer`: Defer blocks for scope-exit execution (Perl 5.36+)
- `for_list`: Iterating over multiple values in a `for` loop (Perl 5.36+)
- `isa`: The `isa` infix operator (Perl 5.32+)
- `bitwise`: Modern stringwise bit operators (Perl 5.22+)

## Best Practices

### Ordering is Critical
The `experimental` pragma works by disabling specific warning categories. If you load a module that enables warnings *after* you have loaded `experimental`, the warnings may be re-enabled. Always place the `experimental` declaration after `use warnings` or modules like `Moose`.

**Correct Pattern:**
```perl
use strict;
use warnings;
use Moose; 
use experimental 'signatures'; # experimental comes last to ensure warnings stay off
```

### Version Awareness
While `experimental` provides a stable interface, the underlying features are only available if the Perl interpreter supports them. 
- If using `class`, ensure the environment is Perl 5.38 or higher.
- If using `signatures`, ensure Perl 5.20 or higher.

### Forward Compatibility
Experimental features can change or be removed in future Perl releases. Use this pragma for rapid development or modernizing codebases, but be prepared for potential syntax adjustments if a feature is significantly redesigned before becoming stable.

## Reference documentation
- [experimental - Experimental features made easy](./references/metacpan_org_pod_experimental.md)