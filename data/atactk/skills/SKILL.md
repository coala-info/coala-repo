---
name: atactk
description: The `atactk` toolkit provides a suite of command-line utilities designed to handle the unique properties of ATAC-seq data.
homepage: http://theparkerlab.org/
---

# atactk

## Overview

The `atactk` toolkit provides a suite of command-line utilities designed to handle the unique properties of ATAC-seq data. It streamlines the transition from aligned reads (BAM files) to quality control metrics and analysis-ready signal tracks. It is particularly useful for assessing library quality through nucleosome banding patterns and transcription start site (TSS) accessibility.

## Installation

Install via bioconda:
```bash
conda install -c bioconda atactk
```

## Core CLI Patterns

### 1. Quality Control: Fragment Size Distribution
ATAC-seq libraries should show a distinct periodicity representing nucleosome protection. Use `atactk` to generate these distributions.

```bash
# Generate fragment size metrics from a BAM file
atactk trim_adapters -i input.bam -o trimmed.bam
```

### 2. TSS Enrichment
A primary metric for ATAC-seq quality is the signal-to-noise ratio at Transcription Start Sites.

```bash
# Calculate TSS enrichment scores
# Requires a reference BED file of TSS locations
atactk tss_enrichment -i input.bam -r reference_tss.bed
```

### 3. Signal Normalization and Shifting
Since Tn5 transposase inserts adapters 9bp apart, reads are often shifted to represent the center of the transposition event.

```bash
# Shift reads to account for Tn5 insertion offset (+4bp on plus, -5bp on minus)
atactk shift_reads -i input.bam -o shifted.bam
```

## Best Practices

- **Input Preparation**: Ensure BAM files are coordinate-sorted and indexed (`samtools index`) before running enrichment or distribution tools.
- **Mitochondrial Reads**: ATAC-seq often contains high levels of mtDNA. It is recommended to filter these out or account for them during normalization to avoid skewed enrichment scores.
- **Duplicate Removal**: Always perform PCR duplicate removal (e.g., via `picard MarkDuplicates`) before calculating library complexity metrics with `atactk`.
- **Reference Consistency**: Ensure the chromosome naming convention (e.g., "chr1" vs "1") in your BAM file matches your TSS reference BED file.

## Reference documentation
- [atactk Overview](./references/anaconda_org_channels_bioconda_packages_atactk_overview.md)
- [The Parker Lab Home](./references/theparkerlab_org_index.md)