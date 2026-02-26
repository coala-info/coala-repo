---
name: taxsbp
description: TaxSBP partitions genomic sequences into bins based on taxonomic relationships using a specialized bin packing algorithm. Use when user asks to group sequences by taxonomy, distribute genomic data into balanced bins, or partition sequences for distributed computing while minimizing taxonomic fragmentation.
homepage: https://github.com/pirovc/taxsbp
---


# taxsbp

## Overview
TaxSBP implements a specialized bin packing algorithm designed for hierarchically structured data, specifically optimized for the NCBI Taxonomy database. Its primary purpose is to distribute genomic sequences into "bins" (partitions) such that sequences with close taxonomic relationships are grouped together. This minimizes taxonomic fragmentation across bins while adhering to user-defined constraints on bin size or the total number of bins. It is a critical tool for researchers needing to partition massive genomic datasets for distributed computing or balanced database indexing.

## Input Requirements
TaxSBP requires two primary components:
1.  **Input TSV**: A tab-separated file containing: `sequence id`, `sequence length`, and `taxonomic id`. An optional fourth column for `specialization` (e.g., assembly accession) can be included.
2.  **NCBI Taxonomy**: The `nodes.dmp` and (optionally) `merged.dmp` files from the NCBI taxdump.

## Common CLI Patterns

### Basic Binning by Size
To group sequences into bins with a maximum size of 100MB (100,000,000 bp):
```bash
taxsbp.py -i sequences.tsv -n nodes.dmp -l 100000000 > binned_output.tsv
```

### Binning by Target Number of Bins
To distribute sequences across approximately 50 bins:
```bash
taxsbp.py -i sequences.tsv -n nodes.dmp -b 50 > binned_output.tsv
```

### Enforcing Taxonomic Exclusivity
To ensure that a bin contains sequences from only one specific taxonomic rank (e.g., genus), use the `-e` flag. This prevents different genera from being mixed in the same bin:
```bash
taxsbp.py -i sequences.tsv -n nodes.dmp -l 100000000 -e genus
```

### Pre-clustering Sequences
To treat all sequences belonging to a specific rank (e.g., species) as a single unit that should not be split across bins:
```bash
taxsbp.py -i sequences.tsv -n nodes.dmp -l 100000000 -p species
```

### Handling Large Sequences with Fragmentation
If sequences are larger than the target bin size, use fragmentation to split them into smaller pieces with optional overlap:
```bash
# Fragment into 1MB pieces with 500bp overlap
taxsbp.py -i sequences.tsv -n nodes.dmp -l 10000000 -f 1000000 -a 500
```

### Using Custom Specializations
When taxonomy alone isn't granular enough (e.g., multiple assemblies for one species), use the specialization column:
```bash
taxsbp.py -i sequences.tsv -n nodes.dmp -l 10000000 -s assembly -e assembly
```

## Expert Tips and Best Practices
*   **Memory Management**: For very large datasets, ensure you have enough RAM to load the NCBI `nodes.dmp`.
*   **Bin Exclusivity vs. Efficiency**: Using `-e` (exclusive) provides the cleanest taxonomic separation but may result in many underfilled bins if the data is sparse at that rank.
*   **Update Mode**: Use the `-u` flag to add new sequences to an existing binning scheme without redistributing the original sequences.
*   **LCA Integration**: TaxSBP uses the Lowest Common Ancestor (LCA) logic to determine where to place sequences in the hierarchy. If a taxid is not found in `nodes.dmp`, the tool will fail unless the taxid is updated via `merged.dmp` (using the `-m` flag).

## Reference documentation
- [TaxSBP GitHub Repository](./references/github_com_pirovc_taxsbp.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_taxsbp_overview.md)