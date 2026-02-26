---
name: delve-bio
description: Delve is a variant caller designed to identify low-frequency alleles and minor clones in samples containing multiple pathogen strains. Use when user asks to call variants in mixed infections, detect minor clones in haploid organisms, or perform targeted variant calling using a BED file.
homepage: https://github.com/berndbohmeier/delve
---


# delve-bio

## Overview
Delve is a specialized variant caller optimized for samples containing multiple pathogen strains. While standard variant callers often struggle with low-frequency alleles in mixed infections, Delve utilizes a statistical model based on base-specific read errors and a Likelihood-ratio Test to identify variants belonging to minor clones. It is particularly effective for Plasmodium falciparum research and other haploid organisms where mixed infections are common.

## Installation
The tool is available via Bioconda:
```bash
conda install bioconda::delve-bio
```

## Core Usage
The primary command for variant calling is `delve call`. At a minimum, you require an indexed reference genome and an indexed BAM file.

### Basic Command Pattern
```bash
delve call -f reference.fasta -o output.vcf input.bam
```

### Targeted Calling
To restrict variant calling to specific genomic coordinates (such as amplicons or genes of interest), provide a BED file:
```bash
delve call -f reference.fasta -R regions.bed -o output.vcf input.bam
```

## Best Practices and Expert Tips
- **Indexing Requirements**: Before running Delve, ensure your reference genome is indexed with `samtools faidx` and your BAM file is indexed with `samtools index`.
- **Minor Clone Detection**: Delve is specifically tuned for low-percentage minor clones. If you are working with pure cultures, standard callers like GATK or BCFtools may suffice, but Delve should be preferred for clinical or field samples where multiplicity of infection (MOI) is expected.
- **Filtering**: Use the `--apply-filter` flag to automatically apply the tool's internal quality and strand-bias filters to the VCF output.
- **Genotype Handling**: If you encounter low-confidence calls, use the `--set-failed-genotype` option to define how the tool should report genotypes that do not meet the statistical threshold.
- **Single Sample Processing**: Currently, Delve processes one sample at a time. For multi-sample cohorts, parallelize the execution at the sample level.

## Common CLI Options
- `-f, --fasta`: Path to the indexed reference FASTA file (Required).
- `-R, --regions`: Path to a BED file defining target regions (Optional).
- `-o, --output`: Path to the output VCF file.
- `--apply-filter`: Applies internal filters to the variant calls.
- `--set-failed-genotype`: Configures the behavior for calls that fail quality checks.

## Reference documentation
- [Bioconda delve-bio Overview](./references/anaconda_org_channels_bioconda_packages_delve-bio_overview.md)
- [Delve GitHub Repository](./references/github_com_berndbohmeier_delve.md)
- [Delve Commit History](./references/github_com_berndbohmeier_delve_commits_main.md)