---
name: perl-statistics-caseresampling
description: This skill provides guidance on using the `Statistics::CaseResampling` Perl module, which is optimized for high-performance bootstrapping.
homepage: http://metacpan.org/pod/Statistics::CaseResampling
---

# perl-statistics-caseresampling

## Overview
This skill provides guidance on using the `Statistics::CaseResampling` Perl module, which is optimized for high-performance bootstrapping. Unlike general statistical packages, this tool focuses on "case resampling"—sampling with replacement from an existing dataset—to calculate robust confidence intervals for medians and other statistics. It is particularly useful in bioinformatics and data science workflows where empirical distribution estimation is required for small or non-normally distributed datasets.

## Usage Patterns

### Basic Resampling
To generate a bootstrap sample from an existing array of data:
```perl
use Statistics::CaseResampling qw(resample);

my @data = (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
my $resampled_data = resample(\@data); # Returns a reference to a new array of the same size
```

### Calculating Medians with Confidence Intervals
The most common use case is estimating the median and its uncertainty:
```perl
use Statistics::CaseResampling qw(median median_absolute_deviation);

my $m = median(\@data);
my $mad = median_absolute_deviation(\@data);
```

### Efficient Bootstrapping Workflow
For large-scale simulations, use the internal C-based functions for speed:
```perl
use Statistics::CaseResampling qw(resample_median);

# Calculate 1000 bootstrap medians
my @bootstrap_medians;
for (1..1000) {
    push @bootstrap_medians, resample_median(\@data);
}
```

## Best Practices
- **Performance**: This module uses XS (C code) for the heavy lifting. Always prefer the built-in `resample_median` or `resample_mean` functions over manual loops in Perl for significant speed gains.
- **Sample Size**: Ensure the input array is large enough for meaningful resampling; bootstrapping very small samples (n < 10) can lead to biased estimates.
- **Randomness**: The module relies on Perl's internal random number generator. For reproducible results, seed `srand()` before starting the resampling process.

## Reference documentation
- [Statistics::CaseResampling Documentation](./references/metacpan_org_pod_Statistics__CaseResampling.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-statistics-caseresampling_overview.md)