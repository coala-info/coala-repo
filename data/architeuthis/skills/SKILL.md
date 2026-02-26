---
name: architeuthis
description: Architeuthis is a bioinformatics utility designed to merge, annotate, and analyze Kraken and Bracken classification reports. Use when user asks to merge multiple sample outputs into a single table, append taxonomic lineage to Bracken files, or analyze k-mer mapping quality and consistency.
homepage: https://github.com/cdiener/architeuthis
---


# architeuthis

## Overview

architeuthis is a specialized command-line utility designed to bridge the gap between raw Kraken-family outputs and downstream statistical analysis. It provides a fast, standalone solution for common bioinformatics bottlenecks such as merging large sets of classification reports and annotating Bracken files with complete taxonomic hierarchies. Beyond simple data manipulation, it offers advanced diagnostic capabilities to investigate k-mer classification patterns, allowing researchers to assess the reliability of taxonomic assignments based on mapping consistency and entropy across different ranks.

## Core Workflows and CLI Patterns

### Merging Sample Outputs
Use the `merge` command to combine multiple Kraken or Bracken output files into a single table. This is significantly more efficient than manual joins for large cohorts.

```bash
# Merge multiple Bracken files into a single abundance matrix
architeuthis merge sample1.bracken sample2.bracken sample3.bracken > merged_abundance.tsv

# Merge Kraken report files
architeuthis merge *.kreport > combined_reports.tsv
```

### Adding Taxonomic Lineage
Bracken reports typically lack the full lineage string. Use the `lineage` command to append this information, which is essential for hierarchical analysis and visualization.

```bash
# Add lineage information using a Kraken database
architeuthis lineage --db /path/to/kraken_db sample_report.bracken > annotated_report.tsv
```

### Analyzing Mapping Quality
To dive deeper into how reads were classified at the k-mer level, use the `mapping` command. This helps identify taxa that may be false positives due to inconsistent k-mer hits.

```bash
# Analyze k-mer level mapping for a Kraken output file
architeuthis mapping --db /path/to/kraken_db kraken_output.txt > mapping_analysis.tsv
```

### Filtering and Metrics
architeuthis can filter mappings based on several quality metrics:
- **Mapping Consistency**: How uniformly k-mers support the assigned taxon.
- **Mapping Entropy**: A measure of the uncertainty in the k-mer distribution at the final taxonomic rank.
- **Multiple Mappings**: Identifying reads that match multiple taxa at the same rank.

## Expert Tips and Best Practices

- **Database Path**: While the `--db` flag is optional for some commands, always provide it when performing lineage annotation or mapping analysis to ensure the tool uses the correct taxonomic nodes and names from your specific Kraken build.
- **Performance**: architeuthis is written in Go and optimized for speed. When merging hundreds of samples, pipe the output directly to a compressed file or a downstream tool to save disk I/O.
- **Shell Integration**: Generate autocompletion scripts to speed up CLI usage:
  ```bash
  architeuthis completion bash > /etc/bash_completion.d/architeuthis
  ```
- **Bracken Compatibility**: Ensure your Bracken files are in the standard format produced by `bracken -r` or `bracken-build`. architeuthis detects the format automatically but relies on standard column headers.

## Reference documentation

- [architeuthis GitHub Repository](./references/github_com_cdiener_architeuthis.md)
- [Bioconda architeuthis Overview](./references/anaconda_org_channels_bioconda_packages_architeuthis_overview.md)