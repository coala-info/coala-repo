---
name: expressbetadiversity
description: Express Beta Diversity is a high-performance tool for calculating taxon-based and phylogenetic diversity metrics from large-scale community data. Use when user asks to calculate ecological dissimilarity matrices, incorporate Newick trees into diversity analysis, or perform jackknife replicates for statistical support.
homepage: https://github.com/dparks1134/ExpressBetaDiversity
---


# expressbetadiversity

## Overview
Express Beta Diversity (EBD) is a high-performance command-line tool designed to efficiently process large-scale community data. It bridges the gap between traditional ecological indices (like Bray-Curtis) and phylogeny-aware metrics by allowing users to incorporate Newick-formatted trees into their diversity calculations. The tool is optimized for speed and can handle datasets with thousands of samples, providing both raw dissimilarity matrices and clustered tree outputs.

## Core CLI Patterns

### Listing Available Metrics
Before running an analysis, check the supported calculators (indices):
```bash
ExpressBetaDiversity -l
```

### Taxon-Based Analysis
To calculate diversity based solely on OTU/species counts without a phylogeny:
```bash
ExpressBetaDiversity -s seq_counts.txt -c Bray-Curtis -w -p my_analysis
```
*   `-s`: The sequence count file (tab-delimited).
*   `-c`: The specific calculator name.
*   `-w`: Use weighted (abundance) data.
*   `-p`: Prefix for output files (`.diss` and `.tre`).

### Phylogenetic-Based Analysis
To include evolutionary relationships in the diversity measure:
```bash
ExpressBetaDiversity -t input.tre -s seq_counts.txt -c [CalculatorName] -w
```
*   `-t`: Input tree in Newick format.

### Statistical Support (Jackknifing)
To perform jackknife replicates and generate a cluster tree with support values:
```bash
ExpressBetaDiversity -s seq_counts.txt -c Bray-Curtis -j 100 -d 500 -p jackknife_results
```
*   `-j`: Number of replicates (e.g., 100).
*   `-d`: Number of sequences to sub-sample per replicate.

## Input Requirements and Formatting

### The Sequence Count File
EBD requires a specific tab-delimited format. **Critical Requirement:** The first line (header) must start with a leading tab character.
```text
	OTU_A	OTU_B	OTU_C
Sample1	10	0	5
Sample2	2	15	0
```
*   Columns must match the leaf nodes in the Newick tree if performing phylogenetic analysis.
*   Zeros must be explicitly provided for missing taxa.

### Data Conversion
If your data is in QIIME or UniFrac format (sparse/dense OTU tables), use the provided helper script:
```bash
python scripts/convertToEBD.py input_otu_table.txt output_ebd_format.txt
```

## Expert Tips and Best Practices

*   **Memory Management:** For extremely large datasets, use the `-x` flag to limit the number of data vectors (profiles) held in memory at once (default is 1000).
*   **Relative vs. Absolute:** By default, EBD uses relative proportions. Use the `-y` flag if you specifically need to use raw count data for the calculations.
*   **Clustering Methods:** While UPGMA is the default (`-g UPGMA`), you can specify `SingleLinkage`, `CompleteLinkage`, or `NJ` (Neighbor Joining) depending on your downstream requirements.
*   **Matrix Conversion:** EBD outputs a lower-triangular dissimilarity matrix to save space. To convert this to a full square matrix for use in other R or Python packages, use:
    ```bash
    python scripts/convertToFullMatrix.py output.diss full_matrix.txt
    ```
*   **Verification:** Always run `ExpressBetaDiversity -u` after installation to ensure the unit tests pass on your specific architecture.



## Subcommands

| Command | Description |
|---------|-------------|
| ExpressBetaDiversity | Express Beta Diversity (EBD) for calculating phylogenetic and non-phylogenetic beta-diversity, including jackknife replicates and hierarchical clustering. |
| convertToEBD.py | Convert UniFrac environment files for use with EBD. |
| convertToFullMatrix.py | Convert Phylip lower-triangular matrix produced by EBD to full matrix. |

## Reference documentation
- [Express Beta Diversity (EBD) Overview](./references/github_com_donovan-h-parks_ExpressBetaDiversity.md)