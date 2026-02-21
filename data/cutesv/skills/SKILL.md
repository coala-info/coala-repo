---
name: cutesv
description: cuteSV is a high-performance tool designed for sensitive and fast structural variation detection in human genomes using noisy long reads.
homepage: https://github.com/tjiangHIT/cuteSV
---

# cutesv

## Overview
cuteSV is a high-performance tool designed for sensitive and fast structural variation detection in human genomes using noisy long reads. It employs a signature-based clustering-and-refinement method to handle the unique characteristics of PacBio (CLR and HiFi) and Oxford Nanopore (ONT) data. Use this skill to configure optimal parameters for different sequencing platforms and to generate genotyped VCF files.

## Command Line Usage
The basic syntax for cuteSV requires a sorted BAM file, the reference FASTA, an output VCF path, and a temporary working directory.

```bash
cuteSV <sorted.bam> <reference.fa> <output.vcf> <work_dir> [options]
```

### Essential Parameters
- `--threads`: Set the number of CPU threads (default: 16).
- `--sample`: Specify the sample name to be used in the VCF header.
- `--genotype`: Enable this flag to generate genotypes (GT) for the detected SVs.
- `--min_support`: Minimum number of reads required to support an SV (default: 10). Adjust based on coverage (e.g., lower for low-depth data).
- `--min_size`: Minimum length of SV to report (default: 30bp).

## Platform-Specific Best Practices
Sequencing technologies have different error profiles. Use these recommended parameter sets for optimal sensitivity and precision:

### PacBio CLR
```bash
cuteSV <bam> <ref> <vcf> <dir> \
    --max_cluster_bias_INS 100 --diff_ratio_merging_INS 0.3 \
    --max_cluster_bias_DEL 200 --diff_ratio_merging_DEL 0.5
```

### PacBio CCS (HiFi)
HiFi reads are highly accurate; use larger cluster biases to capture variations.
```bash
cuteSV <bam> <ref> <vcf> <dir> \
    --max_cluster_bias_INS 1000 --diff_ratio_merging_INS 0.9 \
    --max_cluster_bias_DEL 1000 --diff_ratio_merging_DEL 0.5
```

### Oxford Nanopore (ONT)
```bash
cuteSV <bam> <ref> <vcf> <dir> \
    --max_cluster_bias_INS 100 --diff_ratio_merging_INS 0.3 \
    --max_cluster_bias_DEL 100 --diff_ratio_merging_DEL 0.3
```

## Expert Tips
- **Force Calling**: Note that the force calling module has been moved to a separate tool called `cuteFC`. Use cuteSV for discovery and `cuteFC` for regenotyping.
- **Memory Management**: The `--batches` parameter (default 10,000,000) controls genome segmentation. If running into memory constraints on very large datasets, consider adjusting this value.
- **Filtering**: Use `--min_mapq` (default: 20) to ignore low-quality alignments that might introduce false positive SV signatures.
- **Large SVs**: By default, cuteSV reports SVs up to 100,000bp. To report SVs of any length, set `--max_size -1`.
- **CRAM Support**: Recent versions (v2.1.2+) support `.cram` files. Ensure you provide the reference path when using CRAM input.

## Reference documentation
- [cuteSV GitHub Repository](./references/github_com_tjiangHIT_cuteSV.md)
- [cuteSV Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_cutesv_overview.md)