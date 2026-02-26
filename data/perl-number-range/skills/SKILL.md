---
name: perl-number-range
description: This tool manages and tests numerical sets containing multiple intervals and discrete points using the Number::Range Perl extension. Use when user asks to define complex numerical ranges, check if values fall within specific bounds, or filter data based on coordinate regions.
homepage: http://metacpan.org/pod/Number::Range
---


# perl-number-range

## Overview
The `perl-number-range` skill utilizes the `Number::Range` Perl extension to simplify the handling of numerical sets. Instead of writing verbose conditional logic to check if a number falls within various bounds, this tool allows you to define a single range object containing multiple intervals and discrete points. It is particularly effective in bioinformatics for coordinate-based filtering where data must be checked against specific regions of interest.

## Usage Patterns

### Perl Script Integration
The primary way to use this tool is within a Perl script to create a range object and test values.

```perl
use Number::Range;

# Define a range with mixed intervals and single numbers
my $range = Number::Range->new("1-10, 15, 20-30");

# Check if a number is in the range (returns 1 for true, 0 for false)
if ($range->in_range(15)) {
    print "Value is within the defined set.\n";
}

# Dynamically add or remove ranges
$range->addrange("50-60");
$range->delrange("5");
```

### Command Line One-Liners
For quick data filtering at the CLI, use the `-M` flag to load the module. This is useful for filtering a list of numbers provided via STDIN.

**Filter a list of numbers (one per line) based on a range:**
```bash
cat numbers.txt | perl -MNumber::Range -ne 'BEGIN{$r=Number::Range->new("100-200,500")} print if $r->in_range($_)'
```

**Filter a specific column in a TSV/CSV file:**
```bash
# Filters rows where the second column is in the range 1-50 or is 100
awk -F'\t' '{print $2}' data.tsv | perl -MNumber::Range -ne 'BEGIN{$r=Number::Range->new("1-50,100")} print if $r->in_range($_)'
```

## Best Practices and Tips
- **Overlapping Ranges:** The tool automatically handles overlapping ranges (e.g., "1-10, 5-15" becomes "1-15"). You do not need to pre-sort or merge your intervals.
- **Memory Efficiency:** For extremely large sets of discrete numbers, consider if a hash lookup is more appropriate. `Number::Range` is optimized for interval-based logic.
- **String Formatting:** When passing strings to the constructor, ensure there are no trailing commas, though whitespace between ranges is generally handled gracefully.
- **Negation:** To find numbers *outside* a range, simply negate the `in_range` check in your logic (`!$range->in_range($val)`).

## Reference documentation
- [Number::Range on MetaCPAN](./references/metacpan_org_pod_Number__Range.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-number-range_overview.md)