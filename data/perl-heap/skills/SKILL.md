---
name: perl-heap
description: This tool manages partially sorted data structures in Perl to provide efficient access to extreme values. Use when user asks to implement priority queues, manage task scheduling, handle streaming data, or perform heap operations like adding, extracting, or merging elements.
homepage: http://metacpan.org/pod/Heap
---


# perl-heap

## Overview
The `perl-heap` skill enables the management of partially sorted data structures within Perl environments. Unlike full sorting algorithms which can be computationally expensive for dynamic datasets, a heap maintains a structure where the "top" element (typically the minimum) is always easily accessible. This is particularly useful for implementing priority queues, scheduling tasks, or handling streaming data where only the extreme values are of immediate interest.

## Implementation Patterns

### Basic Heap Lifecycle
To use the heap, you must instantiate a heap object and use compatible element objects.

```perl
use Heap;
use Heap::Elem::Num(NumElem); # For numeric elements

my $heap = Heap->new;

# Adding elements
foreach my $val (42, 10, 85, 7) {
    $heap->add( NumElem($val) );
}

# Accessing the top without removal
my $top = $heap->top; 

# Extracting elements in sorted order
while( defined( my $elem = $heap->extract_top ) ) {
    print "Processing: ", $elem->val, "\n";
}
```

### Choosing the Right Heap Implementation
While `Heap->new` provides a default, specific subclasses offer different performance characteristics:
- **Heap::Binary**: Standard binary heap; good all-purpose performance.
- **Heap::Binomial**: Efficient for merging two heaps.
- **Heap::Fibonacci**: Best theoretical complexity for `decrease_key` and `merge` operations.

### Key Methods and Best Practices
- **`add($elem)`**: Inserts a new element. Elements must conform to the `Heap::Elem` interface (providing a `cmp` method).
- **`extract_top`**: Removes and returns the smallest element. Returns `undef` if empty.
- **`absorb($heap2)`**: Efficiently moves all elements from `$heap2` into the current heap, leaving `$heap2` empty.
- **`decrease_key($elem)`**: Use this when an element's value has been updated to be "smaller" (closer to the top). You must modify the element's internal value *before* calling this method.
- **`delete($elem)`**: Removes a specific element from the heap, even if it is not at the top.

### Element Compatibility
All elements added to a single heap must be mutually compatible. Use the built-in element wrappers for standard data types:
- `Heap::Elem::Num`: For numeric comparisons.
- `Heap::Elem::Str`: For string comparisons.
- `Heap::Elem::Ref`: For comparing based on references.

## Expert Tips
- **Memory Management**: The `DESTROY` method is automatically called when a heap goes out of scope to clean up internal circular references. In long-running loops, ensure heaps are scoped tightly to prevent memory bloat.
- **Reverse Ordering**: To create a "Max-Heap" (where the largest element is at the top), provide an element class with a reversed `cmp` logic.
- **Performance**: If your collection is static, a standard `sort` is often faster. Use `perl-heap` specifically when the collection changes frequently between extractions.

## Reference documentation
- [Heap - Perl extensions for keeping data partially sorted](./references/metacpan_org_pod_Heap.md)
- [perl-heap Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-heap_overview.md)