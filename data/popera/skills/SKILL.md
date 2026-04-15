---
name: popera
description: Popera identifies DNase I hypersensitive sites by applying kernel smoothing to genomic signal data from sorted BAM files. Use when user asks to call DHS peaks, adjust peak-calling sensitivity through bandwidth and threshold parameters, or generate BigWig tracks for genome visualization.
homepage: https://github.com/forrestzhang/Popera
metadata:
  docker_image: "quay.io/biocontainers/popera:1.0.3--py_0"
---

# popera

## Overview
Popera is a specialized bioinformatics tool designed for the identification of DNase I hypersensitive sites (DHS). It utilizes kernel smoothing techniques to process genomic signal data and identify "hot spots" that correspond to open chromatin regions. This skill should be used when you need to process sorted BAM files to call DHS peaks, optimize peak-calling sensitivity via bandwidth and threshold adjustments, or generate tracks for genome browser visualization.

## Installation
The recommended way to install Popera is via Bioconda:
```bash
conda install bioconda::popera
```

## Core Workflow
Popera requires a **sorted BAM** file as input. The primary execution script is `Popera.py`.

### Basic Execution
To run a standard DHS identification with BigWig output:
```bash
python Popera.py -d input_sorted.bam -n sample_name --bigwig --threads 8
```

### Parameter Tuning
*   **Bandwidth (`-b`, `--bandwidth`)**: Controls the kernel smooth band width. The default is 200. Increase this value for smoother signals or decrease it to identify narrower, more discrete peaks.
*   **Threshold (`-t`, `--threshold`)**: Sets the signal threshold for calling hot spots. The default is 4.0. Lowering this value increases sensitivity (more peaks) but may increase false positives.
*   **Minimum Length (`-l`, `--minlength`)**: Defines the minimum size of a detected hot spot. The default is 5bp.

### Filtering Chromosomes
Use the `-x` or `--excludechr` flag to ignore specific contigs, such as mitochondrial or chloroplast DNA, which often have high non-specific signal:
```bash
python Popera.py -d data.bam -n sample -x ChrM,ChrC
```

## Expert Tips
*   **Input Preparation**: Ensure your BAM file is indexed (`samtools index`) in addition to being sorted, as the underlying `pysam` library often requires indices for efficient genomic access.
*   **Resource Management**: Use the `--threads` parameter to scale performance. Popera is written in Python and utilizes `scipy`/`numpy` for calculations; multi-threading significantly reduces processing time for large mammalian genomes.
*   **Visualization**: Always use the `--bigwig` flag if you intend to validate peaks visually in IGV or the UCSC Genome Browser.

## Reference documentation
- [Popera GitHub Repository](./references/github_com_forrestzhang_Popera.md)
- [Bioconda Popera Package](./references/anaconda_org_channels_bioconda_packages_popera_overview.md)