---
name: perl-clone
description: The `perl-clone` skill provides a high-performance mechanism for deep-copying Perl data types.
homepage: http://metacpan.org/pod/Clone
---

# perl-clone

## Overview
The `perl-clone` skill provides a high-performance mechanism for deep-copying Perl data types. Unlike simple assignment which only copies references, this tool traverses the entire data structure to create a completely distinct copy. It is particularly useful for managing state in complex applications, handling nested configurations, or implementing object-oriented prototypes where a "clean" copy of an existing object is required.

## Usage Patterns

### Functional Interface
Import the `clone` function to duplicate data structures by reference.

```perl
use Clone 'clone';

# Deep copy a complex hash
my $original = {
    users => [ { id => 1, name => 'Alice' }, { id => 2, name => 'Bob' } ],
    config => { mode => 'active' }
};

my $copy = clone($original);

# Modifications to $copy do not affect $original
$copy->{config}{mode} = 'suspended';
```

### Object-Oriented Interface
You can enable cloning capabilities for your own classes by inheriting from `Clone`.

```perl
package My::App::Data;
use parent 'Clone';

sub new {
    my ($class, %args) = @_;
    return bless \%args, $class;
}

package main;
my $obj = My::App::Data->new( key => 'value' );
my $duplicate = $obj->clone();
```

### Handling Specific Types
*   **Arrays:** Pass by reference: `my $copy = clone(\@array);`
*   **Hashes:** Pass by reference and dereference if a hash is needed: `my %copy = %{ clone(\%hash) };`
*   **Objects and Tied Variables:** `clone()` automatically handles nested objects and tied variables, maintaining their internal structure.

## Best Practices
*   **Performance:** `Clone` is generally faster than `Storable::dclone` for shallow structures (3 levels or fewer). For extremely deep structures (4+ levels), consider benchmarking against `Storable`.
*   **Circular References:** The module correctly handles circular references within the data structure, preventing infinite loops during the copy process.
*   **Memory Management:** Deep copying large structures consumes significant memory. Only use `clone` when a true independent copy is required; otherwise, stick to reference sharing.

## Reference documentation
- [Clone - recursively copy Perl datatypes](./references/metacpan_org_pod_Clone.md)
- [perl-clone bioconda overview](./references/anaconda_org_channels_bioconda_packages_perl-clone_overview.md)