---
name: pypints
description: pypints (Peak Identifier for Nascent Transcripts Starts) is a bioinformatics tool designed to identify Transcriptional Regulatory Elements (TREs) by pinpointing Transcription Start Sites (TSSs) at high resolution.
homepage: https://pints.yulab.org
---

# pypints

## Overview

pypints (Peak Identifier for Nascent Transcripts Starts) is a bioinformatics tool designed to identify Transcriptional Regulatory Elements (TREs) by pinpointing Transcription Start Sites (TSSs) at high resolution. It is specifically optimized for nascent transcript sequencing assays where the 5' end of the read corresponds to the TSS. The tool allows users to distinguish between divergent (bidirectional) transcription—often associated with active enhancers—and unidirectional transcription, typically associated with canonical promoters.

## Installation

Install via Bioconda or pip:

```bash
conda install bioconda::pypints
# OR
pip install pyPINTS
```

## Core Workflows

### 1. Peak Calling from BAM Files
The primary command for identifying TREs. PINTS automatically handles TSS extraction based on the experiment type.

```bash
pints_caller --bam-file input.sorted.bam \
             --exp-type GROcap \
             --file-prefix sample_name \
             --thread 16 \
             --save-to ./output_dir
```

**Supported Experiment Types (`--exp-type`):**
- `GROcap` (also for single-end PRO-cap)
- `CoPRO` (also for paired-end PRO-cap)
- `csRNAseq`
- `NETCAGE`
- `CAGE`
- `RAMPAGE`
- `STRIPEseq`

### 2. Peak Calling from bigWig Files
If you already have strand-specific signal tracks, you can provide them directly.

```bash
pints_caller --bw-pl signal_plus.bw \
             --bw-mn signal_minus.bw \
             --file-prefix sample_name \
             --thread 8
```

### 3. Generating Visualization Tracks
Use `pints_visualizer` to create strand-specific bigWig files for genome browsers like IGV.

```bash
pints_visualizer -b input.sorted.bam \
                 -e GROcap \
                 --mapq-threshold 255 \
                 --chromosome-start-with chr \
                 -o output_prefix
```

## Expert Tips and Best Practices

### Filtering and Quality Control
- **Uniquely Mapped Reads**: When using STAR for alignment, use `--mapq-threshold 255` in the visualizer or pre-filter your BAM with `samtools view -q 255` to ensure only unique alignments are used.
- **Contig Filtering**: Use the `--filters` flag in `pints_caller` to exclude problematic regions like mitochondria (`chrM`) or unplaced scaffolds.
- **Reverse Complement**: If your library chemistry results in reads that are the reverse complement of the RNA (e.g., certain PRO-seq protocols), add the `--reverse-complement` flag.

### Classifying Enhancers vs. Promoters
PINTS outputs all TREs, but identifying distal enhancers requires post-processing with `bedtools` and a reference promoter annotation:

1.  **Extract Distal TREs (Enhancer Candidates)**:
    ```bash
    bedtools intersect -a sample_bidirectional_peaks.bed -b promoters.bed -v > distal_enhancers.bed
    ```
2.  **Filter Exonic Signals**: For CAGE-like assays, it is often helpful to remove TREs overlapping known exons (excluding the first exon):
    ```bash
    bedtools intersect -a sample_bidirectional_peaks.bed -b exons.bed -f 0.6 -v > non_exonic_TREs.bed
    ```

### Output File Interpretation
PINTS generates several BED files per run:
- `*_bidirectional_peaks.bed`: Combined divergent and convergent TREs.
- `*_divergent_peaks.bed`: Specifically divergent TREs (high-confidence enhancers/promoters).
- `*_unidirectional_peaks.bed`: TREs with signal on only one strand.

## Reference documentation
- [TRE calling guide](./references/pints_yulab_org_tre_calling.md)
- [PINTS FAQ and TRE-BED format](./references/pints_yulab_org_faq.md)
- [Bioconda pypints overview](./references/anaconda_org_channels_bioconda_packages_pypints_overview.md)