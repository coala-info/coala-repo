---
name: trimmomatic
description: Trimmomatic is a specialized Java-based utility designed to clean raw Illumina sequencing data.
homepage: https://www.plabipd.de/trimmomatic_main.html
---

# trimmomatic

## Overview

Trimmomatic is a specialized Java-based utility designed to clean raw Illumina sequencing data. It is particularly effective because it handles both Single-End (SE) and Paired-End (PE) data, using a unique "palindrome" mode for PE reads that identifies adapter contamination even when the DNA insert is shorter than the read length. Use this skill to construct precise command-line strings for quality control pipelines.

## Core Command Structure

Trimmomatic is invoked via Java. The basic syntax requires specifying the mode (PE or SE) followed by input/output files and a series of processing steps.

### Paired-End (PE) Mode
```bash
java -jar trimmomatic.jar PE \
    -threads <int> -phred33 \
    input_forward.fq.gz input_reverse.fq.gz \
    out_fwd_paired.fq.gz out_fwd_unpaired.fq.gz \
    out_rev_paired.fq.gz out_rev_unpaired.fq.gz \
    [STEPS...]
```
*Note: PE mode generates four output files. "Paired" files contain reads where both mates survived; "unpaired" files contain reads where only one mate survived.*

### Single-End (SE) Mode
```bash
java -jar trimmomatic.jar SE \
    -threads <int> -phred33 \
    input.fq.gz output.fq.gz \
    [STEPS...]
```

## Trimming Steps (Order Matters)

Steps are executed in the order they appear on the command line. Always place `ILLUMINACLIP` first.

| Step | Syntax | Recommendation |
| :--- | :--- | :--- |
| **Adapter Clipping** | `ILLUMINACLIP:<fasta>:<seedMismatches>:<palindromeThreshold>:<simpleThreshold>` | Use `2:30:10` as standard thresholds. |
| **Sliding Window** | `SLIDINGWINDOW:<windowSize>:<requiredQuality>` | `4:15` or `4:20` is common for general filtering. |
| **Leading/Trailing** | `LEADING:<quality>` or `TRAILING:<quality>` | Use `3` to remove only very low quality ends. |
| **Fixed Crop** | `CROP:<length>` or `HEADCROP:<length>` | Use `HEADCROP` to remove biased bases at the start. |
| **Minimum Length** | `MINLEN:<length>` | Always include this last to discard empty/short reads. |

## Expert Tips & Best Practices

- **Quality Encoding**: Most modern Illumina data uses `-phred33`. If working with very old data (Pipeline < 1.8), you may need `-phred64`.
- **Palindrome Mode**: In PE mode, `ILLUMINACLIP` uses the reverse complement of the mates to identify adapters with high sensitivity. Ensure your adapter FASTA contains the correct sequences for your library kit (e.g., TruSeq3-PE.fa).
- **Performance**: Use the `-threads` parameter to match your available CPU cores for faster processing.
- **Compression**: Trimmomatic handles `.gz` files natively. Use the `.gz` extension in your output filenames to trigger automatic compression.
- **MaxInfo**: For workflows where read length is critical (like assembly), consider `MAXINFO:<targetLength>:<strictness>` instead of `SLIDINGWINDOW` to balance length vs. quality.

## Reference documentation

- [Trimmomatic Main Documentation](./references/www_plabipd_de_trimmomatic_main.html.md)
- [Bioconda Trimmomatic Overview](./references/anaconda_org_channels_bioconda_packages_trimmomatic_overview.md)