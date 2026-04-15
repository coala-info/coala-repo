---
name: cutesv-ol
description: cuteSV-OL performs real-time discovery of structural variations by monitoring incoming nanopore sequencing data. Use when user asks to discover structural variations during a live sequencing run, monitor a directory for real-time SV analysis, or calculate target variant recall before a run concludes.
homepage: https://github.com/120L022331/cuteSV-OL
metadata:
  docker_image: "quay.io/biocontainers/cutesv-ol:1.0.2--py312h7b50bb2_0"
---

# cutesv-ol

## Overview

cuteSV-OL is a specialized framework designed for the live discovery of structural variations during nanopore sequencing runs. Unlike standard SV callers that require a completed dataset, cuteSV-OL monitors a directory for incoming sequencing data and performs analysis in real-time. It is particularly useful for clinical or time-sensitive applications where rapid feedback on specific target variants or population-scale SVs is required before the sequencing run concludes.

## Core CLI Usage

The primary command for the online framework is `cuteSV_ONLINE`. It requires four positional arguments followed by optional parameters.

```bash
cuteSV_ONLINE <monitored_dir> <reference.fa> <work_dir> <output_vcf_dir> [options]
```

### Essential Parameters

- **monitored_dir**: The directory where the sequencing instrument (or basecaller) is writing new fastq/bam files.
- **reference.fa**: The reference genome file.
- **work_dir**: Directory for intermediate files and the `recall_file.txt`.
- **output_vcf_dir**: Directory where real-time VCF results are stored.

## Expert Tips and Best Practices

### 1. Accelerate Alignment with MMI
Always pre-generate a minimap2 index (.mmi) for your reference genome. Using the `--mmi_path` option significantly reduces the computational overhead during real-time processing.

```bash
# Pre-generate index
minimap2 -d reference.mmi reference.fa

# Use in cuteSV-OL
cuteSV_ONLINE [args] --mmi_path reference.mmi
```

### 2. Real-Time Benchmarking
If you are looking for specific known variants, use the `--target_set` and `--user_defined` flags. This allows the tool to calculate recall in real-time against your ground truth.

- **For Population SVs**: Use a population VCF (like HGSVC) and set `--sv_freq` (e.g., 0.1) to focus on high-frequency variants.
- **For Custom Targets**: Use `--user_defined` to ensure every variant in your provided VCF is treated as a target.

### 3. Optimizing Resource Usage
- **Threads**: Adjust `--threads` based on available CPU cores (default is 4). For high-throughput PromethION runs, 16-32 threads are recommended.
- **Batch Interval**: Use `--batch_interval` to control how often VCFs are updated. A lower number provides more frequent updates but increases disk I/O.

### 4. Automated Termination
Use `--target_rate` to define a success threshold. If the recall rate of your target SV set reaches this percentage, the process can signal that sufficient data has been collected, potentially saving sequencing reagents and time.

### 5. Handling Monitor Timeouts
The `--monitor_fade` parameter (default 600s) determines how long the tool waits for new files before shutting down. Increase this value if your basecalling pipeline has significant latency or if you are multiplexing and expect long gaps between file outputs.

## Common Workflow Patterns

### Basic Real-Time Monitoring
```bash
cuteSV_ONLINE ~/sequencing_output/ ~/ref/hg38.fa ./work ./results --threads 8
```

### Targeted Recall Analysis (Clinical/Specific SVs)
```bash
cuteSV_ONLINE ~/monitor/ ~/ref/hg38.fa ./work ./results \
    --mmi_path ~/ref/hg38.mmi \
    --target_set ~/targets/pathogenic_svs.vcf \
    --user_defined \
    --target_rate 95
```



## Subcommands

| Command | Description |
|---------|-------------|
| cuteSV_ONLINE | cuteSV-OL is a real-time SV detection tool based on cuteSV. |
| minimap2 | Minimap2 is a versatile tool for sequence alignment. It can be used for various tasks including indexing reference genomes, mapping long reads (PacBio, Nanopore), short reads, and performing spliced alignments for RNA-seq data. It also supports read overlap detection. |

## Reference documentation
- [github_com_gwmHIT_cuteSV-OL_blob_master_README.md](./references/github_com_gwmHIT_cuteSV-OL_blob_master_README.md)
- [github_com_gwmHIT_cuteSV-OL_blob_master_environment.yml.md](./references/github_com_gwmHIT_cuteSV-OL_blob_master_environment.yml.md)