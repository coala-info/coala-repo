---
name: clippy
description: Clippy is a bioinformatics tool designed for intuitive and interactive peak calling of CLIP (Cross-Linking ImmunoPrecipitation) data.
homepage: https://github.com/ulelab/clippy
---

# clippy

## Overview
Clippy is a bioinformatics tool designed for intuitive and interactive peak calling of CLIP (Cross-Linking ImmunoPrecipitation) data. It acts as a wrapper around the `scipy.signal.find_peaks` function, applying a rolling mean to smooth crosslink signals. By calculating gene-specific thresholds for height and topographical prominence, Clippy adaptively identifies binding sites across genes with varying expression levels.

## Installation and Environment
Clippy is available via Bioconda. Note that it requires specific dependency versions for stability.
- **Install**: `conda install -c bioconda -c conda-forge clippy`
- **Critical Constraint**: Use `bedtools` version 2.26.0 or older. Versions newer than 2.26.0 are known to break Clippy's functionality.

## Core Command Line Usage
The basic execution requires an input BED file of crosslink counts, a genomic annotation, and a genome index file.

```bash
clippy --input_bed crosslinks.bed \
       --output_prefix results_ \
       --annotation genes.gtf \
       --genome_file hg38.fa.fai
```

### Required Arguments
- `-i, --input_bed`: BED file containing cDNA counts at each crosslink position.
- `-o, --output_prefix`: Prefix for all generated output files.
- `-a, --annotation`: GTF/GFF annotation file. The 3rd column must contain "gene" labels, and the 9th column must uniquely identify genes.
- `-g, --genome_file`: FASTA index file (.fai) used for genomic operations.

## Parameter Tuning and Optimization
Clippy's sensitivity is controlled by smoothing windows and adjustment factors.

### Peak Shape and Smoothing
- **Window Size (`-n`)**: Sets the rolling mean window (default: 10). Increase this for noisier data to prevent over-calling small fluctuations.
- **Width (`-w`)**: Controls the proportion of prominence at which peak widths are calculated (default: 0.4). Smaller values result in narrower peaks.

### Filtering Thresholds
- **Prominence (`-x`)**: Adjusts the minimum prominence threshold (default: 1.0). This is a multiplier of the gene's mean signal. Higher values filter out shallow peaks in high-density regions.
- **Height (`-mx`)**: Adjusts the minimum height threshold (default: 1.0).
- **Count Filters**: Use `-mg` (default: 5) to set minimum cDNA counts per gene and `-mb` (default: 5) for minimum counts per broad peak.

## Interactive Mode
One of Clippy's primary strengths is its interactive Dash server, which allows users to visualize how parameters affect peak calling in real-time.

```bash
clippy -i crosslinks.bed -o test_ -a annot.gtf -g genome.fa.fai --interactive
```
Once running, navigate to the local URL provided in the terminal to tune parameters using the visual interface.

## Advanced Workflows
- **Intergenic Peaks**: By default, Clippy focuses on annotated genes. To call peaks in intergenic regions, set `--intergenic_peak_threshold` (`-inter`) to a value greater than 0. This merges intergenic crosslinks into pseudo-genes for processing.
- **Upstream/Downstream Extension**: Use `-up` and `-down` to extend gene models by a specific number of nucleotides, capturing binding sites in flanking regions.
- **Multithreading**: Use `-t` to specify the number of threads for parallel processing of genes.

## Reference documentation
- [Clippy Overview](./references/anaconda_org_channels_bioconda_packages_clippy_overview.md)
- [Clippy GitHub Documentation](./references/github_com_ulelab_clippy.md)