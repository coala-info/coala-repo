---
name: popdel
description: PopDel discovers and genotypes deletions in large-scale diploid germline datasets by performing joint likelihood-based calling. Use when user asks to create insert-size profiles for BAM or CRAM files, perform joint deletion calling across a cohort, or view profile metadata.
homepage: https://github.com/kehrlab/PopDel
---

# popdel

## Overview

PopDel is a high-performance tool designed for the discovery and genotyping of deletions in diploid organisms. It excels at joint calling across massive datasets—capable of handling cohorts exceeding 50,000 samples. The tool operates via a two-stage workflow: first, it generates compact insert-size profiles for individual samples; second, it performs joint likelihood-based calling across these profiles to produce a standardized VCF output. It is specifically optimized for germline WGS data and is not intended for exome (WES) or somatic variant analysis.

## Core Workflow

### 1. Create Sample Profiles
Generate an insert-size profile for every BAM or CRAM file in your cohort. This step is computationally independent for each sample.

```bash
# Basic profiling
popdel profile input_sample.bam

# Specify output path and reference genome (default is GRCh38)
popdel profile -o sample.profile -g hg19 input_sample.bam
```

### 2. Joint Deletion Calling
Create a text file containing the absolute paths to all generated profiles, then run the joint caller.

```bash
# Generate the profile list
realpath *.profile > all_profiles.txt

# Run joint calling
popdel call all_profiles.txt > cohort_deletions.vcf
```

## Expert Tips and Best Practices

### Performance Optimization
*   **Installation Method**: Always prefer building from source using `make`. The Conda distribution has been observed to be significantly slower (up to 50% increase in calling time).
*   **Parallelization Strategy**: 
    *   **Profiling**: Run `popdel profile` in parallel across samples using a task scheduler or `xargs`.
    *   **Calling**: Parallelize by genomic region using the `-r` flag (e.g., per chromosome) and merge the resulting VCFs.

### Reference Genome Handling
PopDel supports several human reference builds out of the box. Use the `-g` flag during the profiling step:
*   `GRCh38` (Default)
*   `hg38`
*   `GRCh37`
*   `hg19`
*   `T2T` (Telomere-to-Telomere)

For non-human or custom genomes, you must provide user-defined sampling intervals for parameter estimation.

### Profile Management
Use `popdel view` to inspect the contents of a profile or convert between compressed and uncompressed formats.
```bash
# View profile metadata and statistics
popdel view sample.profile

# Extract a specific region from a profile
popdel view -r chr1:1000000-2000000 sample.profile
```

### Filtering and Quality
*   **Minimum Size**: PopDel is most reliable for deletions of a few hundred base pairs and upwards.
*   **Diploid Only**: Ensure your data is from diploid organisms. The likelihood model is specifically tuned for homozygous/heterozygous germline states.



## Subcommands

| Command | Description |
|---------|-------------|
| PopDel | Performs joint-calling of deletions using a list of profile-files previously created using the 'popdel profile' command. The input profiles are either specified directly as arguments or listed in PROFILE-LIST-FILE (one filename per line). |
| PopDel | Profile creation from BAM/CRAM file |
| PopDel | Displays a profile file in human readable format or unzips it. |

## Reference documentation
- [PopDel Main Repository](./references/github_com_kehrlab_PopDel.md)
- [Profiling Documentation](./references/github_com_kehrlab_PopDel_wiki_03.-Create-profiles-with-popdel-profile.md)
- [Calling Documentation](./references/github_com_kehrlab_PopDel_wiki_04.-Call-deletions-with-popdel-call.md)
- [Parallelization Guide](./references/github_com_kehrlab_PopDel_wiki_07.-Parallelization.md)