---
name: perl-statistics-descriptive
description: This tool provides basic descriptive statistical functions for numerical datasets using the Perl Statistics::Descriptive module. Use when user asks to calculate statistical summaries, generate frequency distributions, or perform memory-efficient data analysis in Perl.
homepage: http://web-cpan.shlomifish.org/modules/Statistics-Descriptive/
---


# perl-statistics-descriptive

## Overview
This skill provides guidance on using the `Statistics::Descriptive` Perl module to process numerical datasets. It is designed for scenarios where quick, programmatic statistical summaries are required without the overhead of a full statistical suite. It supports both "Sparse" (memory-efficient) and "Full" (retains all data points) methods of data accumulation.

## Usage Patterns

### Basic Statistical Summary
To get a standard set of metrics (mean, median, standard deviation), use the `Full` object to ensure all calculations (like median and percentiles) are available.

```perl
use Statistics::Descriptive;

my $stat = Statistics::Descriptive::Full->new();
$stat->add_data(1, 2, 3, 4, 5, 10, 20);

print "Mean: ", $stat->mean(), "\n";
print "Median: ", $stat->median(), "\n";
print "Std Dev: ", $stat->standard_deviation(), "\n";
print "Variance: ", $stat->variance(), "\n";
```

### Frequency Distribution (Histograms)
To analyze the distribution of data, use the `frequency_distribution` method.

```perl
# Define bins (e.g., 0-10, 11-20, 21-30)
my %hash = $stat->frequency_distribution(10, 20, 30);

for my $bin (sort {$a <=> $b} keys %hash) {
    print "Bin $bin: $hash{$bin}\n";
}
```

### Memory Optimization (Sparse Mode)
If you are processing millions of data points and only need the mean, count, sum, and variance (and do not need median or mode), use `Sparse` mode to save memory.

```perl
my $stat = Statistics::Descriptive::Sparse->new();
$stat->add_data(@large_dataset);
print "Mean: ", $stat->mean(); # Works in Sparse
# $stat->median(); # This would fail/return undef in Sparse
```

## Expert Tips
- **Data Cleaning**: Always ensure input data is numeric before calling `add_data`. The module does not automatically filter non-numeric strings.
- **Method Availability**: Remember that `median`, `percentile`, and `mode` require the `Full` implementation because they require the dataset to be sorted.
- **Chaining**: You can add data in chunks using multiple `add_data` calls; the object maintains the running state.

## Reference documentation
- [Statistics-Descriptive Home](./references/web-cpan_shlomifish_org_modules_Statistics-Descriptive.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-statistics-descriptive_overview.md)