---
name: musicc
description: MUSICC normalizes metagenomic gene abundances by converting them into genomic copies per cell using universal single-copy marker genes. Use when user asks to normalize metagenomic data, correct for genome size bias, or convert gene counts to copies per cell.
homepage: http://elbo.gs.washington.edu/software_musicc.html
---


# musicc

## Overview
The MUSICC (Marker genes-based framework for metagenomic normalization) tool addresses the bias introduced by varying genome sizes in metagenomic samples. By utilizing a set of universal single-copy marker genes, it allows for the conversion of raw gene abundances into "genomic copies per cell," enabling more accurate comparisons across different microbial communities.

## Command Line Usage

### Basic Normalization
The primary workflow involves taking a table of gene abundances (typically KO or OG counts) and normalizing them.

```bash
# Basic normalization of a KO abundance table
musicc -i input_ko_table.tab -o normalized_output.tab
```

### Key Parameters
- `-i, --input`: Path to the input abundance table (tab-separated). Rows should be genes (e.g., KO IDs) and columns should be samples.
- `-o, --output`: Path for the normalized output file.
- `-m, --marker_genes`: (Optional) Specify a custom marker gene file if not using the default set.
- `-v, --verbose`: Enable detailed logging for troubleshooting.

## Best Practices
- **Input Format**: Ensure your input file is a tab-delimited text file. The first column must contain the gene identifiers (KEGG Orthology IDs are standard).
- **Pre-processing**: MUSICC expects raw or RPKM-normalized counts. It is most effective when the input contains a comprehensive set of genes, including the universal marker genes required for the internal calculation of average genome size.
- **Interpretation**: The output values represent the average number of copies of a gene per cell in the sample. This is a more biologically relevant metric than raw proportions, which are confounded by genome size variation.

## Reference documentation
- [MUSICC Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_musicc_overview.md)