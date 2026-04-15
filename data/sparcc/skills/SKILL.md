---
name: sparcc
description: SparCC estimates correlation coefficients between components in compositional datasets where only relative abundances are available. Use when user asks to calculate correlation matrices from microbial count tables, generate bootstrap replicates for significance testing, or compute pseudo-p-values for taxonomic interactions.
homepage: https://bitbucket.org/yonatanf/sparcc
metadata:
  docker_image: "quay.io/biocontainers/sparcc:0.1.0--0"
---

# sparcc

## Overview
SparCC (Sparse Correlations for Compositional data) is a specialized tool designed to estimate correlation coefficients between components in a system where only relative abundances are known. In microbiome research, total microbial load is often unknown, making standard correlation techniques prone to spurious results. This skill provides the necessary CLI patterns to estimate these correlations and perform significance testing using bootstrap iterations.

## Usage Patterns

### Basic Correlation Estimation
To calculate the correlation matrix from a count table (rows as samples, columns as OTUs/taxa):
```bash
SparCC.py input_counts.txt -i 10 -c correlations.txt -v variations.txt
```
- `-i`: Number of iterations (default is 20; 10-15 is often sufficient for initial runs).
- `-c`: Output file for the correlation matrix.
- `-v`: Output file for the variation matrix.

### Significance Testing (P-values)
Determining significance requires a multi-step bootstrapping workflow:

1. **Generate Simulated Datasets**:
   Create shuffled datasets to build a null distribution.
   ```bash
   MakeBootstraps.py input_counts.txt -n 100 -t bootstrap_prefix -p bootstraps/
   ```
   - `-n`: Number of bootstrap replicates (100 for testing, 1000+ for publication).
   - `-p`: Directory to store generated files.

2. **Run SparCC on Bootstraps**:
   Iterate through the generated files. This is computationally intensive.
   ```bash
   for i in {0..99}; do
     SparCC.py bootstraps/input_counts_$i.txt -i 10 -c correlations/corr_$i.txt >> sparcc.log
   done
   ```

3. **Calculate P-values**:
   Compare the original correlation matrix against the bootstrap distribution.
   ```bash
   PseudoPvals.py correlations.txt correlations/corr_ 100 -o pvals.txt
   ```

## Best Practices
- **Data Filtering**: SparCC performs best when extremely rare OTUs are removed. Filter your table to include only taxa present in a minimum number of samples or above a specific total count threshold before running.
- **Input Format**: Ensure the input file is a tab-separated text file. While SparCC handles zeros (using a log-ratio transform), excessive sparsity can still impact stability.
- **Interpretation**: Correlation values range from -1 to 1. Focus on strong positive or negative correlations that also pass the pseudo-p-value threshold (typically < 0.05).

## Reference documentation
- [SparCC Overview](./references/anaconda_org_channels_bioconda_packages_sparcc_overview.md)