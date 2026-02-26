---
name: perl-parallel-iterator
description: This tool provides a simple interface to parallelize iterative tasks in Perl by managing a pool of worker processes. Use when user asks to parallelize loops or map calls, manage worker concurrency, or process large datasets in batches.
homepage: http://metacpan.org/pod/Parallel::Iterator
---


# perl-parallel-iterator

## Overview
The `perl-parallel-iterator` skill provides guidance on using the `Parallel::Iterator` library to parallelize iterative tasks. Unlike complex fork-management systems, this tool provides a simple "iterate" function that replaces standard loops or `map` calls, automatically managing a pool of worker processes to handle items in parallel. It is particularly useful for bioinformatics pipelines or general-purpose Perl scripts where individual task execution time justifies the overhead of process creation.

## Implementation Patterns

### Basic Parallel Map
To process a list of items in parallel, use the `iterate` function. It takes a configuration hash (or `undef` for defaults) and a subroutine to execute.

```perl
use Parallel::Iterator qw(iterate);

my @items = (1 .. 100);
my $worker = sub {
    my ($index, $item) = @_;
    # Perform task
    return $item * 2;
};

# Returns an array of results in the same order as input
my @results = iterate(undef, $worker, \@items);
```

### Controlling Concurrency
By default, the module attempts to detect the number of CPUs. To manually limit resources or increase throughput, set the `workers` parameter.

```perl
my $config = { workers => 4 }; # Limit to 4 parallel processes
my @results = iterate($config, $worker, \@items);
```

### Handling Large Datasets (Batching)
For very fast tasks, the overhead of forking for every single item can decrease performance. Use `batch_size` to group items together.

```perl
my $config = { 
    workers => 8,
    batch_size => 50 # Each worker processes 50 items per fork
};
my @results = iterate($config, $worker, \@items);
```

## Expert Tips
- **Order Preservation**: `Parallel::Iterator` preserves the order of the input list in the output array, making it a drop-in replacement for `map`.
- **Shared Resources**: Avoid opening database handles or filehandles before the `iterate` call, as child processes will inherit them and may cause race conditions. Open resources inside the worker subroutine instead.
- **Error Handling**: If a worker dies, the iterator will typically propagate the failure. Wrap worker logic in `eval {}` if you need the loop to continue despite individual item failures.
- **Input Types**: The third argument to `iterate` can be an array reference or a subroutine (coderef) that acts as an iterator, allowing you to process streams of data that don't fit in memory.

## Reference documentation
- [Parallel::Iterator Documentation](./references/metacpan_org_pod_Parallel__Iterator.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-parallel-iterator_overview.md)