---
name: umitools
description: umitools is a specialized suite designed to handle the complexities of Unique Molecular Identifiers (UMIs) in sequencing pipelines.
homepage: https://github.com/weng-lab/umitools
---

# umitools

## Overview

umitools is a specialized suite designed to handle the complexities of Unique Molecular Identifiers (UMIs) in sequencing pipelines. It addresses the challenge of PCR duplication by providing tools to extract UMI sequences from raw reads and mark or remove duplicates after genomic alignment. It is particularly useful for high-precision RNA-seq and small RNA-seq workflows where distinguishing between biological replicates and technical PCR duplicates is critical.

## Installation and Setup

Install via pip or bioconda:

```bash
# Via pip
pip3 install umitools

# Via conda
conda install -c bioconda umitools
```

## Common Workflows

### 1. Small RNA-seq Processing
For small RNA-seq, UMIs are typically identified and processed directly from the FASTQ files.

```bash
umitools reformat_sra_fastq -i clipped.fq.gz -o sra.umi.fq -d sra.dup.fq
```

**Key Options:**
- `--reads-with-improper-umi`: Use this flag to output reads that do not match the expected UMI pattern to a separate file for troubleshooting.
- `--umi-pattern-5` / `--umi-pattern-3`: Customize the expected UMI structure (default patterns involve N-based sequences like `NNNCGANNNTACNNN`).

### 2. Standard RNA-seq Processing (Paired-End)
The workflow for standard RNA-seq involves reformatting the FASTQ files before alignment.

**Step A: Reformat FASTQ**
Extract UMIs and append them to the read headers.
```bash
umitools reformat_fastq -l r1.fq.gz -r r2.fq.gz -L r1.fmt.fq.gz -R r2.fmt.fq.gz
```

**Step B: Mark Duplicates**
After aligning the reformatted reads (e.g., using STAR or Hisat2) and generating a BAM file:
```bash
umitools mark_duplicates -f aligned.bam -p 8
```
This produces a file named `[input].deumi.sorted.bam`.

## Expert Tips and Best Practices

### Handling PCR Duplicates
- **The 0x400 Flag**: `umitools mark_duplicates` does not delete reads; it marks them with the `0x400` SAM flag. 
- **Removal**: To physically remove the duplicates for downstream tools that don't recognize the flag, use samtools:
  ```bash
  samtools view -b -h -F 0x400 input.deumi.sorted.bam > final.deduped.bam
  ```

### Customizing UMI Locators
If your library preparation uses non-standard UMI locators, you must specify them to avoid losing reads:
- **RNA-seq**: Use `--umi-locator LOC1,LOC2` (defaults are GGG, TCA, ATC).
- **Small RNA-seq**: Adjust `N_MISMATCH_ALLOWED_IN_UMI_LOCATOR` within the script or environment if your data quality is low, though the default allows 1 mismatch across non-N positions.

### Simulation
Use `umi_simulator` to perform in silico PCR simulations. This is highly recommended when designing new UMI-based library protocols to estimate the required UMI length and complexity for your expected sequencing depth.

## Reference documentation
- [umitools GitHub Repository](./references/github_com_weng-lab_umitools.md)
- [Bioconda umitools Overview](./references/anaconda_org_channels_bioconda_packages_umitools_overview.md)