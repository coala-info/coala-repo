---
name: oligon-design
description: This tool identifies unique oligonucleotide candidates for FISH or PCR by comparing target sequences against an exclusion set. Use when user asks to design genetic markers, generate specific probes for ribosomal DNA, or identify unique oligonucleotides from environmental data.
homepage: https://github.com/MiguelMSandin/oligoN-design
---


# oligon-design

## Overview

The `oligon-design` tool provides a streamlined approach for researchers to generate specific genetic markers from heterogeneous environmental data. By comparing a set of target sequences against an exclusion set, the tool identifies unique oligonucleotide candidates that can be used for Fluorescence in situ Hybridization (FISH) or PCR amplification. While optimized for ribosomal DNA, the logic can be applied to other conserved genes where high specificity is required amidst high biological diversity.

## Installation

The tool is distributed via Bioconda. It is recommended to use a dedicated environment:

```bash
# Create and install in a new environment
micromamba create --name oligoNenv oligon-design
micromamba activate oligoNenv

# Or install in an existing environment
conda install bioconda::oligon-design
```

## Command Line Usage

The primary interface is the `oligoNdesign` command. It requires two input FASTA files and an output designation.

### Basic Syntax
```bash
oligoNdesign -t <target_sequences.fasta> -e <excluding_sequences.fasta> -o <output_prefix>
```

### Parameters
- `-t`: Path to the FASTA file containing sequences you want the oligonucleotides to match.
- `-e`: Path to the FASTA file containing sequences you want to avoid (non-targets).
- `-o`: The prefix or directory name for the resulting oligonucleotide files.

## Best Practices and Expert Tips

- **Input Quality**: Ensure your FASTA headers are clean and sequences are validated. Large environmental datasets often contain noise; pre-filtering sequences for length and quality improves the specificity of the resulting probes.
- **Exclusion Set Selection**: The effectiveness of the tool depends heavily on the `excluding.fasta` file. Include the most closely related non-target species to ensure the designed oligonucleotides do not have off-target hits.
- **SSU rDNA Focus**: While versatile, the tool's internal logic is optimized for 16S and 18S rDNA. When using it for other genes, verify that the conserved regions provide enough sequence variation for unique probe design.
- **Empirical Validation**: As noted by the developers, the output should be treated as a list of candidates. Always perform empirical testing (e.g., melting temperature analysis, PCR optimization, or FISH signal-to-noise checks) before full-scale application.
- **Environment Management**: Always run the tool within its specific Conda/Micromamba environment to avoid dependency conflicts with other bioinformatics software.

## Reference documentation
- [oligon-design Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_oligon-design_overview.md)
- [oligoN-design GitHub Repository](./references/github_com_MiguelMSandin_oligoN-design.md)