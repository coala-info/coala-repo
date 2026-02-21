---
name: trumicount
description: TRUmiCount provides a mechanistic model for PCR amplification to improve the accuracy of molecule counting.
homepage: https://cibiv.github.io/trumicount/
---

# trumicount

## Overview
TRUmiCount provides a mechanistic model for PCR amplification to improve the accuracy of molecule counting. While standard pipelines often count distinct UMIs, this approach can be skewed by "phantom" UMIs (chimeras) or under-counted due to molecules lost during sequencing. This skill assists in configuring the `trumicount` command-line tool to produce bias-corrected transcript counts from indexed BAM files.

## Installation and Setup
The tool is primarily distributed via Bioconda. It is recommended to use the patched version of UMI-Tools for better integration.

```bash
# Install trumicount and dependencies
conda install -c bioconda trumicount samtools

# Recommended: Install the patched UMI-Tools for seamless integration
conda install -c cibiv umi_tools_tuc
```

## Common CLI Patterns

### Basic Bias Correction
To process a mapped BAM file and output a table of corrected gene counts:

```bash
trumicount --input-bam input.bam --output-counts counts.tab
```

### Handling Specific UMI Formats
If UMIs are stored in the read name or separated by a specific character, use the `--umi-sep` flag.

```bash
# Example: UMI is appended to the read name with a colon separator
trumicount --input-bam data.bam --umi-sep ':' --output-counts results.tab
```

### Filtering and Thresholds
For high-confidence counting, you can set thresholds for the minimum number of UMIs required per gene or the number of molecules.

```bash
trumicount --input-bam data.bam \
  --molecules 2 \
  --threshold 2 \
  --genewise-min-umis 3 \
  --output-counts results.tab
```

## Expert Tips
- **Indexing**: Always ensure your BAM file is sorted and indexed (`samtools index file.bam`) before running `trumicount`.
- **Single-Cell Data**: When working with 10x Genomics or similar single-cell datasets, use the `umi_tools_tuc` patch to avoid common compatibility issues with cell barcode/UMI extraction.
- **Memory Management**: For very large BAM files, ensure the environment has sufficient RAM as the tool builds a mechanistic model of the amplification process.
- **Validation**: Compare the raw UMI counts against the `trumicount` corrected counts to assess the extent of PCR bias in your specific library preparation.

## Reference documentation
- [TRUmiCount Manual and Usage](./references/cibiv_github_io_trumicount.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_trumicount_overview.md)