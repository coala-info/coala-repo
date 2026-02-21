---
name: perl-return-multilevel
description: The `Return::MultiLevel` module provides a way to exit from a deeply nested call stack back to a specific higher-level point, effectively allowing a "long return." Unlike standard Perl `return`, which only exits the current subroutine, this tool creates a scoped return callback.
homepage: http://metacpan.org/pod/Return::MultiLevel
---

# perl-return-multilevel

## Overview
The `Return::MultiLevel` module provides a way to exit from a deeply nested call stack back to a specific higher-level point, effectively allowing a "long return." Unlike standard Perl `return`, which only exits the current subroutine, this tool creates a scoped return callback. It is a lightweight alternative to using `die` and `eval` for control flow, offering better performance and clearer intent for non-exceptional exits.

## Usage Patterns

### Basic Implementation
To use the multi-level return, wrap the block of code you wish to return to within `with_return`. This function provides a code reference (usually named `$return`) that, when invoked, immediately exits the `with_return` block.

```perl
use Return::MultiLevel qw(with_return);

my $result = with_return {
    my $return = shift;
    # ... deep in some logic or nested callbacks ...
    $return->("Value to return"); 
    # Execution stops here and jumps out of the with_return block
    print "This will never execute";
};
```

### Escaping Nested Callbacks
This is the primary use case for the module, especially when dealing with functional programming patterns or recursive searches where a result is found deep within the stack.

```perl
use Return::MultiLevel qw(with_return);

my $found_item = with_return {
    my $return = shift;
    
    $tree->walk(sub {
        my $node = shift;
        if ($node->id eq $target_id) {
            $return->($node); # Exit the entire walk immediately
        }
    });
    return undef; # Default if not found
};
```

### Best Practices
- **Lexical Scoping**: Always keep the `$return` callback within the lexical scope of the `with_return` block. Passing the callback to external asynchronous processes or storing it in long-lived global variables can lead to undefined behavior if the original scope has already been exited.
- **Naming Convention**: Use a clear name for the return callback (like `$return` or `$break_to_top`) to distinguish it from standard subroutine returns.
- **Performance**: Use this module when you need a non-local exit but want to avoid the overhead of the exception system (`die`/`eval`), as `Return::MultiLevel` is optimized for this specific control flow pattern.

## Installation
If the environment lacks the module, it can be installed via Bioconda:
```bash
conda install bioconda::perl-return-multilevel
```

## Reference documentation
- [Return::MultiLevel Documentation](./references/metacpan_org_pod_Return__MultiLevel.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-return-multilevel_overview.md)