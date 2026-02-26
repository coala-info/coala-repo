---
name: chexalign
description: ChExAlign performs comparative analysis and alignment of ChIP-exo crosslinking patterns to identify high-resolution protein-DNA interaction footprints. Use when user asks to align ChIP-exo signatures across genomic sites, deconvolve crosslinking events, or quantify binding strengths within protein-DNA complexes.
homepage: https://github.com/seqcode/chexalign
---


# chexalign

## Overview

ChExAlign is a specialized computational framework for the comparative analysis of ChIP-exo datasets. Unlike standard peak callers, it focuses on the high-resolution crosslinking patterns unique to ChIP-exo, aligning these signatures across different proteins or genomic sites to identify consistent protein-DNA interaction footprints. It utilizes a probabilistic mixture model to deconvolve individual crosslinking events, enabling precise quantification of binding strengths and the discovery of the spatial organization within protein-DNA complexes.

## Installation and Environment

The most efficient way to install ChExAlign is via Bioconda:

```bash
conda install bioconda::chexalign
```

**Memory Management:** ChExAlign loads all data into memory. For large datasets or multiple conditions, ensure you allocate sufficient heap space to the JVM using the `-Xmx` flag (e.g., `-Xmx10G` for 10GB).

## Core Command Line Usage

The basic execution pattern requires specifying genome information, experiment data, and the regions of interest.

```bash
java -Xmx10G -jar chexalign.jar --geninfo genome.info --exptCOND1-REP1 signal.bam --format BAM --bed regions.bed --out output_prefix
```

### Required Arguments
- `--geninfo <file>`: A tab-separated file containing `chrName` and `chrLength`.
- `--exptCOND-REP <file>`: Path to signal data. Replace `COND` and `REP` with your specific condition and replicate labels.
- `--format <SAM/BAM/BED/IDX>`: The format of your input files.
- `--bed <file>`: Genomic positions (peaks or annotations) where alignment should be performed.

## Advanced Configuration

### Using Design Files
For complex experiments with multiple replicates and controls, use a `--design` file instead of individual command-line flags. The file should be tab-separated with the following columns:
1. File Path
2. Label (`signal` or `control`)
3. Format (`SAM/BAM/BED/IDX`)
4. Condition Name
5. Replicate Name (optional for controls)

```bash
java -Xmx10G -jar chexalign.jar --geninfo genome.info --design experiment_design.txt --bed regions.bed --out output_prefix
```

### Read Filtering and Duplicates
In highly duplicated experiments, filtering is critical to prevent artifacts:
- `--readfilter`: Enables automated filtering based on a Poisson distribution.
- `--fixedpb <value>`: Sets a hard limit on the number of reads allowed at the same 5′ position.
- `--poissongausspb <value>`: Uses a local Gaussian sliding window to determine per-base limits dynamically.

### Data Scaling
If control experiments (IgG/Input) are provided, ChExAlign performs scaling (defaulting to NCIS):
- `--noscaling`: Disables scaling.
- `--sesscale`: Uses SES (Signal Extraction Scaling) instead of NCIS.
- `--medianscale`: Uses the median ratio of binned tag counts.
- `--plotscaling`: Generates diagnostic plots to verify the scaling performance.

### Alignment Parameters
- `--cwin <int>`: Sets the window size for analyzing read profiles (default is 400bp).
- `--gap <value>`: Adjusts the gap open penalty for the alignment algorithm.

## Expert Tips
- **Genome Info:** Ensure the chromosome names in your `--geninfo` file exactly match the headers in your BAM/SAM files.
- **Point Formats:** If you have specific stranded binding sites, use `--points` instead of `--bed` to maintain orientation during alignment.
- **Memory Optimization:** If running on a machine with limited RAM, use the `--nocache` flag to disable caching of experiments, though this will significantly increase runtime.

## Reference documentation
- [ChExAlign GitHub Repository](./references/github_com_seqcode_chexalign.md)
- [Bioconda ChExAlign Overview](./references/anaconda_org_channels_bioconda_packages_chexalign_overview.md)