---
name: locityper
description: Locityper is a specialized bioinformatics tool designed to resolve genotypes for highly polymorphic genomic regions that are typically difficult to analyze with standard pipelines.
homepage: https://github.com/tprodanov/locityper
---

# locityper

## Overview
Locityper is a specialized bioinformatics tool designed to resolve genotypes for highly polymorphic genomic regions that are typically difficult to analyze with standard pipelines. It is particularly effective for genes with high structural variation or sequence divergence. The tool provides a modular workflow to recruit relevant reads from whole genome sequencing (WGS) datasets—supporting both Illumina short-reads and PacBio/Oxford Nanopore long-reads—and performs targeted alignment and genotyping against a local pangenome or reference set.

## Installation
Locityper is available via Bioconda:
```bash
conda install bioconda::locityper
```

## Core CLI Subcommands
The tool operates through several functional modules:

### 1. Target Preparation
Prepare the genomic regions of interest.
- **Subcommand**: `locityper target`
- **Key Feature**: Supports multiple boundary expansions to capture flanking sequences necessary for accurate recruitment.

### 2. Read Recruitment
Extract reads relevant to the target loci from the global WGS data.
- **Subcommand**: `locityper recruit`
- **Common Flags**:
  - `--distinct`: Refines recruitment logic for specific alleles.
  - Can be configured to output a single consolidated file for downstream steps.

### 3. Alignment
Align the recruited reads to the locus-specific reference.
- **Subcommand**: `locityper align`
- **Expert Tip**: Use the `--ordered` argument to ensure the alignment output is sorted, which is often required for the genotyping stage.

### 4. Genotyping
The final step to determine the sample's genotype at the target loci.
- **Subcommand**: `locityper genotype`
- **Common Flags**:
  - `--recr-alt-len`: Adjusts parameters for alternative allele lengths.
  - It is recommended to explicitly specify recruitment regions during this step to improve accuracy.

### 5. Haplotype Pruning
Optimize the search space by clustering or removing redundant haplotypes.
- **Subcommand**: `locityper prune`
- **Common Flags**:
  - `--n-clusters`: Defines the number of clusters for pruning.
  - This module generates a `distances.bin` file for the pruned data.

## Best Practices and Troubleshooting
- **VCF Handling**: Always provide input variant files in compressed format (`.vcf.gz`). Using uncompressed `.vcf` files can lead to segmentation faults.
- **Read Types**: The tool is compatible with both short-read and long-read data; ensure your recruitment parameters match the expected read lengths of your platform.
- **Memory**: When processing a high volume of targets simultaneously, monitor memory usage during the recruitment phase.
- **Progress Tracking**: The `align` subcommand provides a progress bar to monitor long-running alignment tasks.

## Reference documentation
- [Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_locityper_overview.md)
- [GitHub Repository](./references/github_com_tprodanov_locityper.md)
- [Development History and Subcommands](./references/github_com_tprodanov_locityper_commits_main.md)
- [Known Issues and Parameters](./references/github_com_tprodanov_locityper_issues.md)