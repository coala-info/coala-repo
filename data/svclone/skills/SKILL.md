---
name: svclone
description: svclone is a modular computational framework used to determine the clonality of structural variations in cancer genomes.
homepage: https://github.com/mcmero/SVclone
---

# svclone

## Overview

svclone is a modular computational framework used to determine the clonality of structural variations in cancer genomes. By processing SV calls alongside BAM-level information, it estimates the proportion of cancer cells carrying specific rearrangements. This allows researchers to distinguish between early clonal events and later subclonal mutations. The tool follows a five-step workflow: annotate, count, filter, cluster, and post-assign.

## Installation and Setup

Install svclone via bioconda:
```bash
conda install -c bioconda -c conda-forge svclone
```

Before running the pipeline, obtain the default configuration file and review the settings:
```bash
wget https://raw.githubusercontent.com/mcmero/SVclone/master/svclone_config.ini
```

## Core Workflow

### 1. Annotate
Prepares SV calls by inferring directionality, recalibrating breakpoints to soft-clip boundaries, and classifying SV types.
- **Input**: VCF (recommended), Socrates, or simple format.
- **Command**: `svclone annotate -i <sv_input> -b <indexed_bam> -s <sample_name>`
- **Tip**: Use a blacklist BED file (e.g., DAC blacklist) with `--blacklist <file.bed>` to exclude problematic genomic regions.

### 2. Count
Extracts variant and non-variant read counts from the BAM file at the breakpoint locations identified in the annotation step.
- **Command**: `svclone count -i <annotated_svs> -b <indexed_bam> -s <sample_name>`
- **Note**: Ensure the classification of DNA-gain events (e.g., DUP) in your input matches the `[SVclasses]` section in your `svclone_config.ini`.

### 3. Filter
Refines the dataset by removing low-quality SVs and integrating copy-number variation (CNV) and single-nucleotide variant (SNV) data.
- **Integration**: Match CNV information to SV/SNV loci to improve CCF accuracy.
- **Command**: `svclone filter -i <counts_file> -s <sample_name> --cnvs <cnv_file> --snvs <snv_file>`

### 4. Cluster and Post-Assign
Groups variants into clones based on CCF and assigns SVs to the resulting models.
- **Joint Modeling**: SVs and SNVs can be post-assigned to a joint model for a unified view of tumor phylogeny.

## Input Formats

### Simple Format
If not using VCF, use a tab-delimited "simple" format.
- **Basic**: `chr1 pos1 chr2 pos2`
- **Full (Recommended)**: `chr1 pos1 dir1 chr2 pos2 dir2 classification`
  - Directions (`dir1`/`dir2`) should be `+` or `-`.
  - Classifications must match the config (e.g., `DEL`, `DUP`, `INV`, `INTRX`).

## Best Practices

- **Directionality**: If your SV caller provides breakpoint directions, set `use_dir = True` in the configuration file to use them instead of inferring them.
- **VCF Requirements**: For VCF input, ensure `MATEID` is present in the INFO section. svclone does not support unpaired break-ends; `PARID` must be specified for break-end records.
- **Config Customization**: Always specify your config file using `-cfg <config.ini>` if it is not in the current working directory.
- **Validation**: Run the provided `run_example.sh` script from the source repository to verify the installation and observe the expected output plots in the `ccube_out` directory.

## Reference documentation
- [SVclone GitHub Repository](./references/github_com_mcmero_SVclone.md)
- [SVclone Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_svclone_overview.md)