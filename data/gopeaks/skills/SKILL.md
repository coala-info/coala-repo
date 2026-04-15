---
name: gopeaks
description: GoPeaks is a high-performance peak caller designed for identifying enrichment in CUT&TAG, CUT&RUN, and ATAC-Seq datasets. Use when user asks to call narrow or broad peaks from paired-end BAM files, normalize signal against a control sample, or identify chromatin accessibility regions.
homepage: https://github.com/maxsonBraunLab/gopeaks
metadata:
  docker_image: "quay.io/biocontainers/gopeaks:1.0.0--h047eeb3_3"
---

# gopeaks

## Overview

GoPeaks is a high-performance peak caller specifically engineered for the unique signal-to-noise profiles of CUT&TAG and CUT&RUN assays. While many peak callers are designed for ChIP-Seq, GoPeaks accounts for the low background and high sensitivity of newer chromatin profiling methods. It is optimized for narrow peaks (e.g., H3K4me3, TFs) by default but provides flexible parameters and presets for broad epigenetic marks.

## Installation

The recommended way to install GoPeaks is via Bioconda:

```bash
conda install -c bioconda -c conda-forge gopeaks
```

## Command Line Usage

### Basic Peak Calling
For standard narrow-peak datasets (H3K4me3, Transcription Factors, or ATAC-Seq), use the default parameters. GoPeaks requires paired-end BAM files.

```bash
gopeaks -b sample.bam -c control.bam -o output_prefix
```

### Calling Broad Peaks
For broad marks like H3K27Ac or H3K4me1, use the `--broad` flag. It is also recommended to increase the merge distance (`-m`) to ensure contiguous enrichment regions are not fragmented.

```bash
gopeaks -b sample.bam -c control.bam --broad -m 3000 -o output_prefix
```

### Parameter Tuning
- **-b, --bam**: Input sample BAM (must be paired-end).
- **-c, --control**: Control BAM (e.g., IgG or Input) for signal normalization.
- **-m, --mdist**: Merge peaks within this distance (bp). Default is 1000. Increase for broader marks.
- **-p, --pval**: Significance threshold with Benjamini-Hochberg correction. Default is 0.05.
- **-r, --minreads**: Minimum read pairs required to test a genome bin. Default is 15.
- **-w, --minwidth**: Minimum width of a peak in base pairs. Default is 150.

## Best Practices and Expert Tips

1. **Input Requirements**: GoPeaks strictly requires paired-end reads. Ensure your BAM files are properly sorted and indexed before running.
2. **Control Samples**: Always provide a control BAM (like IgG) via the `-c` flag. GoPeaks uses this to normalize the signal and reduce false positives inherent in chromatin profiling.
3. **Broad Mark Strategy**: The `--broad` flag is a shortcut that sets `--step 5000` and `--slide 1000`. If your peaks still appear too fragmented, manually increase `-m` (merge distance) to 3000 or higher.
4. **Chromosome Sizes**: If your BAM header is missing or non-standard, provide a chromosome sizes file using `-s`.
5. **Output Interpretation**:
   - `prefix_peaks.bed`: A standard 3-column BED file containing the coordinates of identified peaks.
   - `prefix_gopeaks.json`: A metadata file containing the command used, version, execution time, and total peak counts. Use this for pipeline logging and reproducibility.

## Reference documentation
- [GoPeaks GitHub Repository](./references/github_com_maxsonBraunLab_gopeaks.md)
- [GoPeaks Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_gopeaks_overview.md)