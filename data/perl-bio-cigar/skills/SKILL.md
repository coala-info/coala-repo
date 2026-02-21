---
name: perl-bio-cigar
description: The `Bio::Cigar` Perl module provides a robust interface for handling Compact Idiosyncratic Gabor Alignment Resolution (CIGAR) strings, which are standard in SAM/BAM files.
homepage: http://search.cpan.org/~tsibley/Bio-Cigar-1.01
---

# perl-bio-cigar

## Overview
The `Bio::Cigar` Perl module provides a robust interface for handling Compact Idiosyncratic Gabor Alignment Resolution (CIGAR) strings, which are standard in SAM/BAM files. While primarily a library, it is essential for bioinformatics workflows that require precise coordinate mapping—determining exactly which base in a read corresponds to which base in a genome, accounting for insertions, deletions, and skips.

## Usage Patterns

### Object Initialization
To work with a CIGAR string, initialize the object with the string and the optional reference sequence (if available for MD tag calculations).

```perl
use Bio::Cigar;

# Basic initialization
my $cigar = Bio::Cigar->new("10M2I5M1D8M");

# Accessing basic properties
my $query_len = $cigar->query_length;
my $ref_len   = $cigar->reference_length;
```

### Coordinate Translation
The core utility of this tool is moving between coordinate systems.

*   **Reference to Query**: Find where a genomic position sits on the read.
    ```perl
    # Returns the query position (1-based) for reference position 15
    my $query_pos = $cigar->rpos_to_qpos(15);
    ```
*   **Query to Reference**: Find where a read base sits on the genome.
    ```perl
    my $ref_pos = $cigar->qpos_to_rpos(5);
    ```

### Alignment Analysis
Extracting metrics from the CIGAR string:

*   **Decomposition**: Get a list of individual operations.
    ```perl
    # Returns an array of [length, op] tuples: ([10, 'M'], [2, 'I'], ...)
    my @ops = $cigar->parts;
    ```
*   **Alignment Stats**: If the CIGAR string uses extended operators (X/=) or if you provide the reference/query sequences, you can calculate identity.
    ```perl
    my $identity = $cigar->identity;
    ```

## Best Practices
*   **Coordinate Systems**: Always remember that `Bio::Cigar` typically operates on 1-based coordinates. Ensure your input matches this to avoid "off-by-one" errors common in bioinformatics.
*   **Validation**: Before performing complex translations, check if the CIGAR string is valid for your expected sequence lengths using `$cigar->query_length`.
*   **Memory Efficiency**: For high-throughput SAM processing, reuse the `Bio::Cigar` object or ensure it is scoped properly to avoid memory leaks in long-running Perl scripts.

## Reference documentation
- [Bio-Cigar 1.01 Documentation](./references/metacpan_org_release_TSIBLEY_Bio-Cigar-1.01.md)