---
name: pbhoover
description: pbhoover is a genomic consensus caller designed to generate VCF files from legacy Pacific Biosciences sequencing data. Use when user asks to call variants from low-coverage PacBio BAM files, generate a consensus sequence, or process older P4C2 and P6C4 chemistry data.
homepage: https://gitlab.com/LPCDRP/pbhoover
metadata:
  docker_image: "quay.io/biocontainers/pbhoover:1.1.0--pyhdfd78af_1"
---

# pbhoover

## Overview

`pbhoover` is a specialized genomic consensus caller tailored for legacy Pacific Biosciences sequencing data. It is particularly effective for low-coverage samples where standard variant calling pipelines might fail to produce reliable results. The tool processes aligned BAM files against a reference genome to generate VCF outputs, utilizing specific logic to handle the unique error profiles of older PacBio chemistries.

## Command Line Usage

The primary interface for `pbhoover` is the command line. Ensure your input BAM file is indexed and aligned to the reference FASTA.

### Basic Command Pattern
```bash
pbhoover --bam <input.bam> -r <reference.fasta> --nproc <threads> -o <output.vcf>
```

### Key Arguments
- `--bam`: Path to the aligned BAM file.
- `-r`: Path to the reference genome in FASTA format.
- `--nproc`: Number of CPU cores to use for parallel processing.
- `-o`: Path for the output VCF file.
- `--min-vf`: Minimum variant frequency for SNPs and multi-base indels (default is often 0.333).
- `--min-vf-si`: Minimum variant frequency for single-base indels (default is often 0.5).

## Expert Tips and Best Practices

### Stability and Thresholds
The tool's internal logic for combining and normalizing variants is sensitive to frequency cutoffs. For the most stable performance and to avoid "IndexError" or "unknown case" crashes during the normalization phase, it is recommended to explicitly set the original allele cutoffs:
```bash
pbhoover --bam aligned.bam -r ref.fasta --min-vf 0.333 --min-vf-si 0.5 -o out.vcf
```

### Chemistry-Specific Considerations
- **P4C2 Chemistry**: Be aware that `pbhoover` may miscall SNPs as deletions in homopolymer regions when processing P4C2 data (e.g., the *rpoB* gene in *M. tuberculosis*). If a deletion is called in a known SNP hotspot, manually inspect the alignment.
- **P6C4 Chemistry**: Generally provides higher accuracy; variants called in P6C4 data are typically more reliable than those in P4C2.

### Troubleshooting Common Errors
- **Logging Errors**: If you encounter a `TypeError` during the "Combining variants" phase, it often indicates a logging formatting issue with specific variant records. Check the intermediate output if available.
- **Memory and Performance**: For large genomes or high coverage, ensure the `--tmpdir` is set to a location with sufficient space, as `pbhoover` generates intermediate files during the calling process.

### Version Differences
- **v1.x**: Uses RSR/VSR/VF notation in the output.
- **v2.x (Beta)**: Updated for Python 3 and replaces legacy notation with standard allele frequency (AF) in the VCF output. It also includes significant speed-ups via Cythonized I/O.

## Reference documentation
- [pbhoover - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_pbhoover_overview.md)
- [LPCDRP / pbhoover · GitLab (Activity/Issues)](./references/gitlab_com_LPCDRP_pbhoover.atom.md)
- [Releases · LPCDRP / pbhoover · GitLab](./references/gitlab_com_LPCDRP_pbhoover_-_releases.md)