---
name: popdel
description: popdel identifies and genotypes deletions in large-scale genomic datasets using a likelihood-based joint-calling approach. Use when user asks to create sample profiles from BAM or CRAM files, perform joint deletion calling across a cohort, or inspect and convert profile files.
homepage: https://github.com/kehrlab/PopDel
---


# popdel

## Overview

The `popdel` tool is a lightweight, high-performance suite designed to identify and genotype deletions (typically 100bp and larger) across massive genomic datasets. It utilizes a likelihood-based approach that excels in joint-calling scenarios. The workflow is split into two main phases: an initial profiling step that summarizes insert-size distributions for individual samples, followed by a joint-calling step that processes these profiles together to produce a unified VCF output. This tool is specifically optimized for diploid germline WGS data and should not be used for exome sequencing (WES) or somatic mutation detection.

## Command Line Usage

### 1. Create Sample Profiles
Before calling variants, you must generate a profile for every BAM or CRAM file in your cohort. This step estimates the library's insert-size distribution.

```bash
# Basic profiling
popdel profile input_sample.bam

# Profiling with a specific output name
popdel profile -o sample_name.profile input_sample.bam
```

**Expert Tips for Profiling:**
- **Reference Genome**: The default is GRCh38. If using a different build (e.g., hg19 or T2T), you must specify it or provide sampling intervals.
- **Read Group Conflicts**: If your BAM files have conflicting read group IDs, use the `-e` or `--per-sample-rgid` flag to resolve them.
- **Performance**: While available via Bioconda, the tool performs significantly faster when compiled from source using `make`.

### 2. Joint Deletion Calling
Once profiles are created, they are processed together. You must first create a text file containing the absolute paths to all `.profile` files.

```bash
# Generate the profile list
realpath *.profile > all_profiles.txt

# Run joint calling
popdel call all_profiles.txt > output_deletions.vcf
```

**Expert Tips for Calling:**
- **Scaling**: `popdel` is tested for up to 50,000 samples. For very large cohorts, ensure your system's memory management is optimized.
- **Output**: The resulting VCF (v4.2) includes standard fields and specific INFO tags like `SVLEN` (deletion length).

### 3. Inspecting and Converting Profiles
Use the `view` command to examine the contents of a profile or convert between compressed and uncompressed formats.

```bash
# View profile information
popdel view sample.profile

# Unzip an existing profile
popdel view -o unzipped.profile -x sample.profile
```

## Best Practices

- **Input Requirements**: Only use short-read paired-end data. The tool relies on insert-size statistics which are not applicable to long-read or single-end data.
- **Reference Consistency**: Ensure the reference genome used for alignment matches the intervals specified during the `profile` step.
- **Parallelization**: Profiling is an "embarrassingly parallel" task. Use a workload manager (like Slurm) or `xargs` to profile multiple samples simultaneously before running the single `call` command.
- **Avoid Somatic/WES**: Do not use `popdel` for cancer somatic calling or whole-exome data, as the underlying statistical model assumes diploid germline distributions across the whole genome.

## Reference documentation
- [PopDel GitHub Repository](./references/github_com_kehrlab_PopDel.md)
- [PopDel Wiki Home](./references/github_com_kehrlab_PopDel_wiki.md)
- [PopDel Version 1.5.0 Release Notes](./references/github_com_kehrlab_PopDel_tags.md)