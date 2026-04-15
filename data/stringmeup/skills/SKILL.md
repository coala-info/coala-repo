---
name: stringmeup
description: stringmeup reclassifies Kraken 2 results by adjusting taxonomic assignments based on a user-defined confidence threshold. Use when user asks to reclassify metagenomic reads, adjust Kraken 2 confidence scores, or tune classification sensitivity and specificity.
homepage: https://github.com/danisven/StringMeUp
metadata:
  docker_image: "quay.io/biocontainers/stringmeup:0.1.5--pyhdfd78af_0"
---

# stringmeup

## Overview

stringmeup is a post-processing utility that allows for the rapid reclassification of Kraken 2 results. By using the original read-by-read output and the corresponding NCBI taxonomy files, it calculates confidence scores for each read and moves classifications up the taxonomic tree until the user-specified threshold is met. This process is significantly faster than re-running Kraken 2 with different `--confidence` parameters, making it an essential tool for tuning metagenomic classification sensitivity and specificity.

## Usage and Best Practices

### Basic Reclassification
To reclassify a Kraken 2 output file with a new confidence threshold (e.g., 0.1), use the following pattern:

```bash
stringmeup --names names.dmp --nodes nodes.dmp 0.1 original_output.kraken2
```

### Managing Outputs
By default, the tool outputs a Kraken-style report to `stdout`. To save results to specific files, use the following flags:

*   **Report File**: `--output_report [FILE]` (Standard Kraken 2 report format)
*   **Classification File**: `--output_classifications [FILE]` (Read-by-read assignments)
*   **Verbose Output**: `--output_verbose [FILE]` (Detailed metrics for each read, including original vs. new TaxIDs and confidence scores)

### Confidence Score Logic
The confidence score (CS) is calculated as $CS = N / M$, where:
*   **N**: Number of k-mers hitting any node in the clade rooted at the classified node.
*   **M**: Total number of k-mers queried against the database (excluding ambiguous nucleotides).

If a read fails the threshold at its current node, stringmeup checks the parent node iteratively until the threshold is met or the root is reached.

### Advanced Filtering with Minimizer Hit Groups
If the initial classification was performed using the specific `danisven` fork of Kraken 2, you can filter reads based on the number of minimizer hit groups:

```bash
stringmeup --names names.dmp --nodes nodes.dmp --minimum_hit_groups 2 0.1 original_output.kraken2
```
This ensures a read is only classified if it meets both the confidence score and the minimum hit group requirement.

### Expert Tips
*   **Taxonomy Consistency**: Always use the exact `names.dmp` and `nodes.dmp` files that were used to build the Kraken 2 database used for the initial classification. Discrepancies in taxonomy versions will lead to errors or incorrect reclassifications.
*   **Verbose Analysis**: Use the `--output_verbose` flag when troubleshooting unexpected "Unclassified" results. It provides the `MAX_CONFIDENCE` a read can achieve, which helps determine if your threshold is realistically attainable for specific sequences.
*   **Performance**: stringmeup supports gzipped input and output files; it will automatically handle `.gz` extensions.

## Reference documentation
- [StringMeUp GitHub Repository](./references/github_com_danisven_StringMeUp.md)
- [StringMeUp Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_stringmeup_overview.md)