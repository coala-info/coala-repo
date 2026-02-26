---
name: perl-mce-shared
description: This tool provides a high-performance parallel computing framework for Perl that manages persistent worker pools and shared data structures. Use when user asks to parallelize log parsing, process data sequences in chunks, or implement cross-platform multi-core computations.
homepage: https://github.com/marioroy/mce-perl
---


# perl-mce-shared

## Overview

The Many-Core Engine (MCE) for Perl provides a high-performance parallel computing framework that utilizes a bank-queuing model. Unlike traditional approaches that might fork a new process for every data element, MCE maintains a persistent pool of workers and efficiently chunks data from an input stream to available workers. This skill helps you implement parallelized log parsing, sequence processing, and mathematical computations while managing the nuances of cross-platform execution (Unix vs. Windows).

## Installation

Install the shared data extension via Conda or from source:

```bash
# Via Conda (Bioconda channel)
conda install bioconda::perl-mce-shared

# From Source
perl Makefile.PL
make
make test
make install
```

## Core API Patterns

### Basic Worker Pool
Use the Core API for fine-grained control over worker counts and specific user functions.

```perl
use MCE;

my $mce = MCE->new(
    max_workers => 8,
    user_func => sub {
        my ($mce) = @_;
        $mce->say("Worker " . $mce->wid . " is processing");
    }
);

$mce->run();
```

### Parallel Loop with Chunking
`MCE::Loop` is ideal for processing arrays or files. Chunking improves performance by reducing IPC (Inter-Process Communication) overhead.

```perl
use MCE::Loop;

MCE::Loop->init(
    max_workers => 8,
    chunk_size  => 1000
);

mce_loop {
    my ($mce, $chunk_ref, $chunk_id) = @_;
    foreach my $item (@$chunk_ref) {
        # Process item
        MCE->gather($item) if $item =~ /pattern/;
    }
} @input_data;
```

## High-Utility Patterns

### Parallel File Parsing (Slurp IO)
For massive log files, use `use_slurpio` to read chunks of the file into memory for workers to process.

```perl
use MCE::Loop;

MCE::Loop->init(
    max_workers  => 8,
    use_slurpio  => 1,
    chunk_size   => '2M' # 2MB chunks
);

my @results = mce_loop_f {
    my ($mce, $slurp_ref, $chunk_id) = @_;
    # Process the scalar reference $$slurp_ref
    if ($$slurp_ref =~ /critical_error/m) {
        MCE->gather("Found in chunk $chunk_id");
    }
} "large_log_file.log";
```

### Sequence Processing
Use `MCE::Flow` for numerical sequences or bounds-only processing to minimize memory usage.

```perl
use MCE::Flow;

# bounds_only => 1 sends [begin, end] instead of the full sequence
MCE::Flow->init(max_workers => 4, bounds_only => 1, chunk_size => 10000);

mce_flow_s sub {
    my ($beg, $end) = @{ $_[0] };
    for my $i ($beg .. $end) {
        # Perform calculation
    }
}, 1, 1000000;
```

## Expert Tips & Best Practices

*   **Windows Compatibility**: Performance on Windows can degrade significantly when using memory-mapped file handles (`open my $fh, '<', \$slurp_ref`) with more than 4 workers. Use regex-based line splitting (`while ($$slurp_ref =~ /([^\n]+\n)/mg)`) as a fallback for better scaling on Windows.
*   **Data Gathering**: Always use `MCE->gather()` to collect results from workers. It handles the serialization and synchronization required to return data to the manager process safely.
*   **Serialization**: MCE prefers `Sereal` for performance. If `Sereal::Encoder` and `Sereal::Decoder` (v3.015+) are installed, MCE will use them automatically; otherwise, it falls back to `Storable`.
*   **Worker Persistence**: MCE workers persist across the lifecycle of the object. Avoid spawning new MCE instances inside loops; instead, use `init` or reuse the object to prevent process creation overhead.

## Reference documentation
- [Many-Core Engine for Perl Overview](./references/github_com_marioroy_mce-perl.md)
- [perl-mce-shared Bioconda Package](./references/anaconda_org_channels_bioconda_packages_perl-mce-shared_overview.md)