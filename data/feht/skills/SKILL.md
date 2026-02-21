---
name: feht
description: `feht` (pronounced "fate") is a command-line tool designed for predictive marker discovery.
homepage: https://github.com/chadlaing/feht/
---

# feht

## Overview
`feht` (pronounced "fate") is a command-line tool designed for predictive marker discovery. It automates the process of finding features—such as genes, SNPs, or arbitrary characters—that are significantly associated with specific groups defined in your metadata. By performing pairwise comparisons across all available metadata categories, it ranks markers based on their discriminatory power using p-values and ratio filters.

## Command Line Usage

### Basic Syntax
The tool requires an information (metadata) file and a data file. By default, it assumes tab-delimited binary data.

```bash
feht -i metadata.txt -d data.txt
```

### Common Options
- `-m, --mode`: Set to `binary` (default) or `snp` depending on your input data type.
- `-f, --ratioFilter`: Filter results to show only those with a discriminatory ratio greater than or equal to the specified value (0.0–1.0).
- `-c, --correction`: Choose between `bonferroni` (default) or `none` for multiple-testing correction.
- `-l, --delimiter`: Specify a custom delimiter (e.g., `','` for CSV) if not using tabs.

### Targeted Comparisons
While `feht` performs all possible pairwise comparisons by default, you can target specific groups:

```bash
feht -i metadata.txt -d data.txt --one "CategoryName GroupA" --two "CategoryName GroupB"
```

## Data Preparation Best Practices

### Metadata File (`-i`)
- **First Column**: Must contain sample names. A header for this column is optional.
- **Subsequent Columns**: Each must have a header representing the metadata category (e.g., "Source", "Resistance", "Year").
- **Values**: The rows contain the specific group labels for each sample.

### Data File (`-d`)
- **Header Row**: Must contain sample names that match the metadata file exactly.
- **First Column**: Contains the labels for the markers being tested (e.g., "gene_01", "snp_102"). This column should not have a header.
- **Values**: 
  - In `binary` mode: Use `1` for presence, `0` for absence, and `-` for missing data.
  - In `snp` mode: Use character data representing variants.

## Expert Tips
- **Output Interpretation**: `feht` outputs blocks of results. Each block represents a comparison. Markers are ranked from most to least discriminatory.
- **Ratio Column**: The "Ratio" in the output indicates the strength of the association. A ratio of 1.0 means the marker is perfectly predictive of Group One compared to Group Two.
- **Handling Large Datasets**: Use the `-f` (ratio filter) to significantly reduce output volume by ignoring markers with low discriminatory power (e.g., `-f 0.7`).
- **P-Value Correction**: Always keep Bonferroni correction enabled (`-c bonferroni`) unless you are performing exploratory analysis on very small sample sizes where you expect weak signals.

## Reference documentation
- [feht GitHub Repository](./references/github_com_chadlaing_feht.md)
- [Bioconda feht Overview](./references/anaconda_org_channels_bioconda_packages_feht_overview.md)