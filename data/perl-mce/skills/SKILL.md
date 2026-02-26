---
name: perl-mce
description: Perl-MCE provides a framework for parallelizing Perl scripts across multiple CPU cores using a bank-queuing model for efficient load balancing. Use when user asks to parallelize data processing, run loops in parallel, process large files using multiple cores, or implement multi-stage workflows in Perl.
homepage: https://github.com/marioroy/mce-perl
---


# perl-mce

## Overview
Perl-MCE (Many-Core Engine) provides a robust framework for parallelizing Perl scripts without the overhead of forking a new process for every data element. It utilizes a bank-queuing model where a pool of workers processes data in chunks, ensuring efficient load balancing across all available CPU cores. This skill helps you implement MCE's various models—such as Loop, Flow, and Step—to handle data-intensive operations with minimal boilerplate.

## Core API Usage
The Core API provides the most control over worker behavior and data distribution.

```perl
use MCE;

my $mce = MCE->new(
    max_workers => 8,
    chunk_size  => 100,
    user_func   => sub {
        my ($mce, $chunk_ref, $chunk_id) = @_;
        # Process chunk...
        MCE->gather($result);
    }
);

$mce->run();
```

## High-Level Models
For most tasks, use the simplified models to reduce code complexity.

### MCE::Loop (Parallel Iteration)
Best for processing arrays or files where each element/line is independent.
- Use `mce_loop` for arrays.
- Use `mce_loop_f` for files (automatically handles chunking).

```perl
use MCE::Loop;

MCE::Loop->init(max_workers => 8, use_slurpio => 1);

my @results = mce_loop_f {
    my ($mce, $slurp_ref, $chunk_id) = @_;
    if ($$slurp_ref =~ /pattern/) {
        MCE->gather($$slurp_ref);
    }
} "large_data.log";
```

### MCE::Flow (Parallel Sequences)
Best for processing sequences of numbers or complex multi-stage workflows.

```perl
use MCE::Flow;

# bounds_only => 1 sends [begin, end] pairs to workers instead of every number
MCE::Flow->init(max_workers => 4, bounds_only => 1, chunk_size => 1000);

mce_flow_s sub {
    my ($mce, $chunk_ref, $chunk_id) = @_;
    my ($begin, $end) = @{ $chunk_ref };
    for my $i ($begin .. $end) {
        # Perform calculation...
    }
}, 1, 1000000;
```

## Expert Tips and Best Practices
- **Chunk Size Optimization**: Adjust `chunk_size` based on the granularity of the task. Larger chunks reduce IPC (Inter-Process Communication) overhead but can lead to uneven load balancing if tasks vary in duration.
- **Slurp I/O**: When processing files, set `use_slurpio => 1`. This allows MCE to read entire chunks into memory buffers, which is significantly faster than line-by-line reading in a parallel context.
- **Gathering Results**: Use `MCE->gather()` to collect data from workers. It handles the serialization and synchronization required to return data to the manager process safely.
- **Windows Compatibility**: MCE uses threads on Windows and child processes on Unix. If running on Windows, ensure you `use threads;` and `use threads::shared;` before loading MCE modules.
- **Resource Management**: Always call `MCE::Loop->finish()` or let the MCE object go out of scope to ensure worker processes are reaped correctly.

## Reference documentation
- [GitHub README for mce-perl](./references/github_com_marioroy_mce-perl.md)
- [Anaconda Bioconda perl-mce Overview](./references/anaconda_org_channels_bioconda_packages_perl-mce_overview.md)