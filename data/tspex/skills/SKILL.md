---
name: tspex
description: The `tspex` tool is a specialized utility for bioinformaticians and researchers to quantify the tissue-specificity of gene expression.
homepage: https://github.com/apcamargo/tspex
---

# tspex

## Overview

The `tspex` tool is a specialized utility for bioinformaticians and researchers to quantify the tissue-specificity of gene expression. It transforms raw or normalized expression matrices into specificity scores, allowing for the identification of highly specific biomarkers or ubiquitously expressed housekeeping genes. The tool provides a unified interface for various metrics that are otherwise scattered across different statistical packages, ensuring consistent calculation and normalization.

## Command Line Interface (CLI)

The primary command is `tspex`. It requires an input file, an output path, and a specific metric method.

### Basic Syntax
```bash
tspex [options] <input_file> <output_file> <method>
```

### Supported Metrics
Choose the method that best fits your biological question:
- `tau`: Generally recommended as the most robust and reliable metric for general tissue specificity.
- `gini`: Based on the Gini coefficient; measures the inequality of expression across tissues.
- `counts`: Counts the number of tissues where expression exceeds a specific threshold.
- `tsi`: Tissue Specificity Index.
- `zscore`: Measures how many standard deviations an expression value is from the mean.
- `shannon_specificity`: Based on Shannon entropy.
- `spm`: Specificity Measure (based on expression enrichment).
- `roku_specificity`: Uses Tukey's biweight to identify outliers.
- `simpson`, `js_specificity`, `spm_dpm`, `js_specificity_dpm`.

### Common CLI Patterns

**1. Standard Tau Calculation**
The most common use case for identifying tissue-specific genes.
```bash
tspex expression_matrix.tsv results.tsv tau
```

**2. Analyzing Raw Data with Log Transformation**
If your input matrix contains non-log-transformed values (e.g., raw TPM or FPKM), use the `--log` flag.
```bash
tspex --log raw_tpm.csv results_spm.tsv spm
```

**3. Using a Custom Threshold for Presence/Absence**
When using the `counts` method, define the expression level that constitutes "expressed" using `-t`.
```bash
tspex --threshold 10 input.xlsx output.tsv counts
```

**4. Preserving Original Metric Ranges**
By default, `tspex` scales all outputs from 0 (ubiquitous) to 1 (perfectly specific). To get the raw mathematical output (e.g., actual Z-scores), use the disable flag.
```bash
tspex --disable_transformation input.tsv output.tsv zscore
```

## Expert Tips and Best Practices

- **Input Formatting**: Ensure your input file has gene identifiers in the first column and tissue/sample names in the first row. `tspex` supports `.tsv`, `.csv`, and `.xlsx` formats.
- **Metric Selection**: While `tau` is the gold standard for most applications, `zscore` is often better for identifying genes that are specifically *under-expressed* in a tissue compared to others.
- **Data Pre-processing**: `tspex` expects a filtered matrix. It is recommended to remove genes with zero expression across all tissues before running the tool to avoid computational artifacts in entropy-based metrics.
- **Normalization**: Ensure your data is properly normalized (e.g., TPM, CPM, or FPKM) before calculation. `tspex` calculates specificity based on the relative distribution across the provided columns, so inter-sample normalization is critical.

## Reference documentation
- [tspex Overview](./references/anaconda_org_channels_bioconda_packages_tspex_overview.md)
- [tspex GitHub Repository](./references/github_com_apcamargo_tspex.md)