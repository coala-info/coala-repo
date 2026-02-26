---
name: art_modern
description: art_modern generates synthetic sequencing reads from reference genomes or transcriptomes to create datasets with known ground truths for tool validation. Use when user asks to simulate sequencing reads, generate synthetic datasets for WGS or RNA-Seq, or create custom error profiles from existing sequencing data.
homepage: https://github.com/YU-Zhejian/art_modern
---


# art_modern

## Overview

art_modern is a modernized re-implementation of the popular ART read simulator, optimized for better performance and expanded functionality. It generates synthetic sequencing reads from reference genomes or transcriptomes, allowing researchers to create datasets with known ground truths. This is essential for validating the accuracy of alignment tools, variant callers, and RNA-Seq quantification pipelines. The tool supports both single-end (SE) and paired-end (PE) sequencing and includes a high-performance profile creator to generate custom error profiles from existing FASTQ, SAM, or BAM files.

## Common CLI Patterns

### Whole Genome Sequencing (WGS) Simulation

**Single-End (SE) Simulation**
Generate reads using the default HiSeq 2500 profile with 10X coverage:
```bash
art_modern \
  --mode wgs \
  --lc se \
  --i-file reference.fna \
  --o-fastq output_se.fastq \
  --i-fcov 10 \
  --parallel
```

**Paired-End (PE) Simulation**
Generate paired reads with specific fragment length distributions:
```bash
art_modern \
  --mode wgs \
  --lc pe \
  --i-file reference.fna \
  --o-fastq output_pe.fastq \
  --i-fcov 10 \
  --pe_frag_dist_mean 300 \
  --pe_frag_dist_std_dev 50 \
  --parallel
```

### Customizing Read Parameters

*   **Read Length**: Use `--read_len <int>` to specify length (ensure it does not exceed the maximum supported by the profile).
*   **Sequencer Profile**: Use `--builtin_qual_file <profile_name>` (e.g., `HiSeq2500_150bp`) to select specific error models.
*   **Thread Control**: Use `--parallel` to utilize all available threads for simulation.

## Expert Tips and Best Practices

*   **Paired-End Output Handling**: By default, art_modern may generate a single interleaved FASTQ file for paired-end data. Most downstream pipelines require these to be split into two files (R1 and R2) and potentially sorted.
*   **Performance Optimization**: While pre-compiled binaries are available via Conda or Docker, compiling from source with a modern C++ compiler (GCC >= 9.5.0) is recommended for maximum performance on specific hardware.
*   **Profile Accuracy**: art_modern fixes a known bug in the original ART profile builder where quality scores were offset by 1. When creating custom profiles from your own FASTQ/BAM data, art_modern provides a more reliable error model.
*   **RNA-Seq Simulation**: For transcriptome simulation, art_modern requires transcript quantification results (e.g., from Salmon, Kallisto, or featureCounts). It is often best used in conjunction with high-level simulators like YASIM to generate expression levels before read generation.
*   **Static Build Limitations**: If using the fully static Alpine Linux build, note that it does not support MPI or NCBI SRA files. For cluster-wide parallelization via MPI, use the `art_modern-openmpi` package from BioConda.

## Reference documentation
- [art_modern GitHub Repository](./references/github_com_YU-Zhejian_art_modern.md)
- [art_modern BioConda Overview](./references/anaconda_org_channels_bioconda_packages_art_modern_overview.md)
- [art_modern Security and Known Bugs](./references/github_com_YU-Zhejian_art_modern_security.md)