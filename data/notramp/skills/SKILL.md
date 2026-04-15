---
name: notramp
description: The notramp tool performs coverage normalization and primer trimming for multiplexed amplicon sequencing data. Use when user asks to downsample over-represented amplicons, clip reads to amplicon boundaries, or prepare raw reads for variant calling and assembly.
homepage: https://github.com/simakro/NoTrAmp.git
metadata:
  docker_image: "quay.io/biocontainers/notramp:1.1.9--pyh7e72e81_0"
---

# notramp

## Overview
The `notramp` skill enables efficient processing of multiplexed amplicon reads. It addresses the common issue of uneven coverage in tiling schemes by downsampling over-represented amplicons to a user-defined threshold. Additionally, it performs "one-step" trimming, which precisely clips reads to the expected amplicon boundaries defined by a primer BED file, effectively removing non-target sequences like adapters and primers.

## Core Workflows

### 1. Full Processing (Normalization + Trimming)
Use the `-a` flag to perform both coverage capping and trimming. This is the standard workflow for preparing raw reads for assembly or variant calling.
```bash
notramp -a -p primers.bed -r reads.fasta -g reference.fasta -m 100
```

### 2. Normalization Only
Use the `-c` flag if you only want to downsample reads to a specific depth without altering the read length or sequence.
```bash
notramp -c -p primers.bed -r reads.fasta -g reference.fasta -m 200
```

### 3. Trimming Only
Use the `-t` flag to clip reads to the amplicon coordinates. By default, primers are removed.
```bash
notramp -t -p primers.bed -r reads.fasta -g reference.fasta
```

## Expert Tips and Best Practices

- **Primer Naming**: Ensure your primer BED file follows a consistent naming scheme (e.g., `Scheme_1_LEFT`, `Scheme_1_RIGHT`). The tool relies on these suffixes to pair primers into amplicons.
- **Short-Read Adjustment**: If using Illumina or reads significantly shorter than the amplicon size, you must adjust the minimum alignment length using `--set_min_len` to prevent valid reads from being discarded.
- **Sequencing Technology**: Specify the platform using `-s` (`ont` for Oxford Nanopore or `pb` for PacBio). The default is `ont`.
- **Include Primers**: If your downstream analysis requires primer sequences to remain in the reads, always add the `--incl_prim` flag during trimming.
- **Reference Constraints**: The reference FASTA (`-g`) must contain only **one** target sequence. Multi-sequence references are not supported.
- **Output Management**: By default, results are saved in the input directory. Use `-o /path/to/dir` to redirect outputs to a specific folder.
- **Validation**: Run `notramp --selftest` after installation to verify that `minimap2` and other dependencies are correctly configured in your environment.

## Reference documentation
- [NoTrAmp GitHub Documentation](./references/github_com_simakro_NoTrAmp.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_notramp_overview.md)