---
name: perl-statistics-distributions
description: This skill provides guidance on using the Statistics::Descriptive Perl module to analyze numerical datasets.
homepage: https://github.com/shlomif/perl-Statistics-Descriptive
---

# perl-statistics-distributions

## Overview
This skill provides guidance on using the Statistics::Descriptive Perl module to analyze numerical datasets. The tool is designed to handle data in two distinct ways: "Full" mode, which retains the entire dataset in memory to allow for calculations like medians and percentiles, and "Sparse" mode, which is memory-efficient and calculates running statistics (like mean and sum) without storing individual data points.

## Usage Instructions

### Choosing the Right Mode
*   **Full Mode (`Statistics::Descriptive::Full`)**: Use this when you need to calculate the median, mode, percentiles, or trimmed means. It requires enough memory to store every data point added.
*   **Sparse Mode (`Statistics::Descriptive::Sparse`)**: Use this for very large datasets where you only need basic metrics like mean, variance, sum, count, min, and max. It uses minimal memory regardless of the number of data points.

### Basic Workflow
1.  **Initialize**: Create a new statistics object.
2.  **Load Data**: Use the `add_data()` method to input your numbers.
3.  **Extract Metrics**: Call the specific statistical method required.

```perl
use Statistics::Descriptive;

# For full data analysis
my $stat = Statistics::Descriptive::Full->new();
$stat->add_data(1, 2, 3, 4, 5);

print "Mean: " . $stat->mean() . "\n";
print "Median: " . $stat->median() . "\n";
```

### Precision and Tolerance
When dealing with floating-point precision issues in statistical comparisons, you can set a global tolerance value:
```perl
$Statistics::Descriptive::Tolerance = 1e-10;
```

### Common Methods
*   `mean()`: Arithmetic mean.
*   `variance()`: Variance of the dataset.
*   `standard_deviation()`: Square root of the variance.
*   `trimmed_mean($fraction)`: Mean after discarding a fraction of the data from the top and bottom (Full mode only).
*   `min()` / `max()`: The smallest and largest values.
*   `count()`: Total number of data points.

## CLI Patterns and One-Liners
You can use Perl one-liners to get quick statistics from a file or pipe without writing a full script.

**Calculate mean of a column of numbers from a file:**
```bash
cat data.txt | perl -MStatistics::Descriptive -e '$s=Statistics::Descriptive::Sparse->new(); while(<>){chomp; $s->add_data($_) if $_ =~ /^\d/}; print "Mean: ", $s->mean(), "\n"'
```

**Get a summary (Mean and Median) from a list of numbers:**
```bash
perl -MStatistics::Descriptive -e '$s=Statistics::Descriptive::Full->new(); $s->add_data(<>); printf "Mean: %.2f, Median: %.2f\n", $s->mean(), $s->median()' numbers.txt
```

## Expert Tips
*   **Batch Loading**: If you have a large array of data already in a Perl script, pass the entire array to `add_data(@array)` rather than calling it in a loop for better performance.
*   **Memory Management**: If you are processing millions of records and only need the average, always default to `Sparse` to avoid "Out of Memory" errors.
*   **Data Cleaning**: Ensure data is numeric before passing it to `add_data`. The module does not automatically filter out non-numeric strings, which can lead to warnings or incorrect calculations.

## Reference documentation
- [Statistics::Descriptive README](./references/github_com_shlomif_perl-Statistics-Descriptive.md)
- [Module Structure](./references/github_com_shlomif_perl-Statistics-Descriptive_tree_master_Statistics-Descriptive.md)