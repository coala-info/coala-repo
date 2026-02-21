---
name: cistrome_beta
description: The `cistrome_beta` skill provides a workflow for the Binding and Expression Target Analysis (BETA) software.
homepage: https://github.com/hanfeisun/BETA
---

# cistrome_beta

## Overview
The `cistrome_beta` skill provides a workflow for the Binding and Expression Target Analysis (BETA) software. This tool is designed to bridge the gap between physical binding events (ChIP-seq) and functional output (transcriptome changes). By calculating a regulatory potential score for each gene based on the proximity and number of binding peaks, and then integrating this with differential expression data using a non-parametric rank product approach, BETA identifies which genes are likely direct targets and whether the factor primarily up-regulates or down-regulates its targets.

## Command Line Usage

The primary command is `BETA`. It requires both a peak file and a differential expression file.

### Basic Syntax
```bash
BETA -p <peak_bed> -e <expression_file> -k <M|R> -g <genome_sqlite> [options]
```

### Required Arguments
- `-p, --peakfile`: Input BED format peak file (e.g., from MACS2).
- `-e, --diff_expr`: Differential expression file (Limma output for Microarray; Cuffdiff output for RNA-seq).
- `-k, --kind`: The type of expression data. Use `M` for Microarray or `R` for RNA-seq.
- `-g, --genome`: The genome reference file in sqlite3 format (e.g., hg19, mm9).

### Common Options
- `-b, --bound`: Input a conserved CTCF binding site BED file to act as an insulator boundary for regulatory potential calculations.
- `-d, --distance`: Set the maximum distance from the TSS to consider peaks. Default is 100,000 (100kb).
- `--pn`: Number of peaks to consider (ordered by significance). Default is 10,000.
- `--df`: FDR threshold to filter differential expression genes (0 to 1). Default is 1 (no filter).
- `--da`: Amount of top differential genes to use. If < 1, it's a percentage (e.g., 0.25). If > 1, it's a specific count (e.g., 2000).
- `-c, --cutoff`: P-value threshold for the Kolmogorov-Smirnov (KS) test to determine significance of up/down regulation. Default is 0.001.
- `-n, --name`: Prefix for the output files.

## Input Data Preparation

### Peak File (BED)
BETA expects at least 5 columns: `chrom`, `start`, `end`, `name`, `score`. If your BED file lacks name or score columns, you must provide placeholders to maintain the format.

### Expression File Formats
- **RNA-seq (R)**: Specifically supports the `gene_exp.diff` format from Cuffdiff.
- **Microarray (M)**: Specifically supports the output format from Limma.

## Best Practices and Tips

1. **Genome Selection**: Ensure the sqlite3 genome file matches the assembly used for peak calling and expression mapping.
2. **CTCF Boundaries**: Using the `-b` argument with CTCF boundary files is highly recommended to improve the accuracy of target prediction by preventing "leaking" of regulatory potential across topological boundaries.
3. **Interpreting Results**:
   - **score.pdf**: This is the most critical output. It shows a Cumulative Distribution Function (CDF) plot. If the "Up" or "Down" line is significantly above the "Background" line (p < cutoff), the TF is predicted to have that functional role.
   - **uptarget.txt / downtarget.txt**: These files contain the predicted direct targets. Focus on genes with the lowest Rank Product and FDR.
4. **Permutations**: For publication-quality results, increase `--pt` (permutation times) from the default 500 to 1000 or more to get a more precise FDR, though this will increase computation time.
5. **Peak Filtering**: If you have a very high number of peaks (e.g., > 50,000), use `--pn` to limit the analysis to the most confident peaks to reduce noise in the regulatory potential calculation.

## Reference documentation
- [BETA GitHub Repository](./references/github_com_hanfeisun_BETA.md)
- [BETA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cistrome_beta_overview.md)