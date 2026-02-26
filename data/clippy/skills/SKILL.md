---
name: clippy
description: Clippy is a bioinformatics tool that performs peak calling on CLIP data by applying a rolling mean to smooth crosslink signals. Use when user asks to call peaks in CLIP data, identify significant binding sites, or interactively tune peak calling parameters.
homepage: https://github.com/ulelab/clippy
---


# clippy

## Overview

Clippy is a bioinformatics tool designed for intuitive peak calling in CLIP (Cross-Linking ImmunoPrecipitation) data. It functions as a wrapper around the SciPy `find_peaks` function, applying a rolling mean to smooth crosslink signals across genes. By comparing signal prominence and height against gene-specific means, it identifies significant binding sites. The tool is unique for its interactive mode, which allows researchers to visualize and adjust parameters in real-time to suit the specific binding characteristics of different proteins.

## Installation and Environment

Clippy is available via Bioconda. Note that it has a specific dependency requirement for older versions of bedtools.

- **Install via Conda**: `conda install -c bioconda -c conda-forge clippy`
- **Critical Dependency**: Using bedtools versions newer than **2.26.0** will break Clippy's functionality. Ensure your environment uses an older version.

## Core Command Line Usage

The basic execution requires an input BED file of crosslink counts, a genomic annotation, and a genome index.

```bash
clippy --input_bed crosslinks.bed \
       --output_prefix results_ \
       --annotation genes.gtf \
       --genome_file genome.fa.fai
```

### Required Arguments
- `-i, --input_bed`: BED file containing cDNA counts at each crosslink position.
- `-o, --output_prefix`: Prefix for all generated output files.
- `-a, --annotation`: GTF/GFF annotation file. The file must contain "gene" in the 3rd column.
- `-g, --genome_file`: FASTA index file (.fai) used for genomic operations.

## Peak Tuning and Filtering

Clippy uses a rolling mean to define thresholds. You can adjust these to control peak sensitivity and specificity.

- **Smoothing**: Use `-n [WINDOW_SIZE]` (default: 10) to change the rolling mean window. Larger windows result in smoother signals but may merge close peaks.
- **Prominence**: Use `-x [MIN_PROM_ADJUST]` (default: 1.0) to adjust the minimum prominence threshold. This is a multiplier of the mean signal.
- **Height**: Use `-mx [MIN_HEIGHT_ADJUST]` (default: 1.0) to set the minimum height threshold, also calculated as a multiplier of the mean.
- **Width**: Use `-w [WIDTH]` (default: 0.4) to determine how peak widths are calculated relative to prominence. Smaller values yield narrower peaks.

## Interactive Mode

One of Clippy's most powerful features is the interactive Dash server. This allows you to tune parameters on a subset of data before running a full pipeline.

```bash
clippy -i tests/data/crosslinkcounts.bed -o tuning_ -a tests/data/annot.gff -g tests/data/genome.fa.fai -int
```

- Trigger this mode by adding the `-int` flag.
- It launches a local web server where you can visualize how changing `-x` or `-mx` affects peak calls on specific genes.

## Advanced Annotation Handling

- **Intergenic Peaks**: By default, Clippy only calls peaks within annotated genes. To call intergenic peaks, set `-inter [THRESHOLD]` to a value greater than zero. This merges intergenic crosslinks into regions for peak calling.
- **Alternative Features**: Use `-alt <name>-<key>-<pattern>` to set individual thresholds on specific GTF features (e.g., specific biotypes).
- **Extensions**: Use `-up` and `-down` to extend gene models upstream or downstream by a set number of nucleotides.

## Reference documentation
- [Clippy GitHub Repository](./references/github_com_ulelab_clippy.md)
- [Bioconda Clippy Package](./references/anaconda_org_channels_bioconda_packages_clippy_overview.md)