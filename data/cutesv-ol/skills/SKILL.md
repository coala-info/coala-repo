---
name: cutesv-ol
description: cutesv-ol is a specialized framework for real-time structural variation discovery.
homepage: https://github.com/120L022331/cuteSV-OL
---

# cutesv-ol

## Overview
cutesv-ol is a specialized framework for real-time structural variation discovery. Unlike standard SV callers that require a completed sequencing run, this tool monitors a directory for incoming data and processes it incrementally. It is ideal for clinical or time-sensitive applications where early detection of genomic variations is required to inform decision-making before a sequencing run concludes.

## Installation and Environment
The tool requires a specific environment setup due to its dependencies (Python < 3.13).

```bash
# Recommended installation via Bioconda
conda install -c conda-forge -c bioconda cutesv-ol
```

## Core Command Structure
The primary command is `cuteSV_ONLINE`. It requires four positional arguments followed by optional parameters.

```bash
cuteSV_ONLINE <monitored_dir> <reference.fa> <work_dir> <output_vcf_dir> [options]
```

- **monitored_dir**: The directory where the sequencer or basecaller is writing new fastq/bam files.
- **reference.fa**: The reference genome file.
- **work_dir**: Directory for intermediate files and the recall log.
- **output_vcf_dir**: Where real-time VCF results are stored.

## Common CLI Patterns

### Basic Real-Time Monitoring
Use this for standard runs where you simply want to see SVs as they appear.
```bash
cuteSV_ONLINE ./raw_data ./ref.fa ./tmp ./results --threads 16 --monitor_fade 600
```

### Targeted SV Detection (Ground Truth Comparison)
If you are looking for specific known variants (e.g., from a population study or a specific patient's previous record), use the `--target_set` parameter.

```bash
cuteSV_ONLINE ./raw_data ./ref.fa ./tmp ./results \
    --target_set known_variants.vcf \
    --user_defined \
    --target_rate 95
```

### High-Performance Alignment
To speed up the alignment phase, provide a pre-computed minimap2 index (.mmi).
```bash
# Generate index first
minimap2 -d reference.mmi reference.fa

# Run with index
cuteSV_ONLINE ./raw_data ./ref.fa ./tmp ./results --mmi_path reference.mmi
```

## Expert Tips and Best Practices

- **Monitor Fade**: The `--monitor_fade` parameter (default 600s) determines when the tool stops. If your basecaller is slow or network-delayed, increase this value to prevent the process from exiting prematurely.
- **Batch Intervals**: Adjust `--batch_interval` (default 4) to balance between update frequency and computational overhead. Lower values provide more frequent updates but consume more CPU.
- **VCF Versioning**: The tool generates multiple VCF files in the output directory. The filenames typically indicate the sequencing depth at the time of generation. Always check the most recent file for the most complete current call set.
- **Population Frequency**: When using a population VCF as a target set, ensure it has an `AF` (Allele Frequency) field. You can use `bcftools +fill-tags` to generate this if it is missing. Use `--sv_freq` to filter the target set to only high-frequency variants.
- **Recall Analysis**: Check `<work_dir>/recall_file.txt` to see the real-time sensitivity/recall statistics against your target set.

## Reference documentation
- [github_com_gwmHIT_cuteSV-OL.md](./references/github_com_gwmHIT_cuteSV-OL.md)
- [anaconda_org_channels_bioconda_packages_cutesv-ol_overview.md](./references/anaconda_org_channels_bioconda_packages_cutesv-ol_overview.md)