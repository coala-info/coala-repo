---
name: seacr
description: SEACR is a peak caller designed to identify enriched regions in high-sensitivity, low-background chromatin profiling data like CUT&RUN and CUT&Tag. Use when user asks to call peaks from bedgraph files, perform sparse enrichment analysis, or identify chromatin footprints using control-based or numeric thresholding.
homepage: https://github.com/FredHutch/SEACR
---


# seacr

## Overview

SEACR (Sparse Enrichment Analysis for CUT&RUN) is a peak caller specifically designed for high-sensitivity, low-background chromatin profiling data. Unlike traditional peak callers that assume a Poisson background distribution, SEACR leverages the "zero-background" nature of sparse data to identify enriched regions. It provides a data-driven approach to thresholding that avoids the need for arbitrary window sizes or empirical parameter tuning, making it the standard choice for CUT&RUN and CUT&Tag analysis.

## Usage Instructions

### Core Command Syntax

The tool is executed as a bash script requiring five positional arguments:

```bash
bash SEACR_1.3.sh <target.bedgraph> <control> <norm/non> <relaxed/stringent> <output_prefix>
```

### Argument Definitions

1.  **Target Bedgraph**: The experimental data in UCSC bedgraph format. **Note**: You must omit regions with 0 signal from this file.
2.  **Control**: 
    *   Provide a **control bedgraph** (e.g., IgG) to generate an empirical threshold.
    *   Alternatively, provide a **numeric threshold** (a fraction between 0 and 1, e.g., `0.01`) to return the top $n$ fraction of peaks based on total signal.
3.  **Normalization**:
    *   `norm`: Normalizes control data to target data. Recommended for most runs unless data is already spike-in normalized.
    *   `non`: Skips normalization.
4.  **Mode**:
    *   `stringent`: Uses the peak of the total signal curve. Best for high-confidence peaks.
    *   `relaxed`: Uses a threshold between the knee and the peak of the curve. Recommended for discovery or when read depth is high.
5.  **Output Prefix**: The base name for the resulting `.bed` file.

### Preparing Input Bedgraphs

SEACR requires bedgraph files that reflect density across read pairs (fragments) rather than individual reads.

**Recommended Pre-processing Workflow:**

1.  **Convert BAM to BEDPE**:
    `bedtools bamtobed -bedpe -i sample.bam > sample.bed`
2.  **Filter and Clean**:
    `awk '$1==$4 && $6-$2 < 1000 {print $0}' sample.bed > sample.clean.bed`
3.  **Extract Fragment Coordinates**:
    `cut -f 1,2,6 sample.clean.bed | sort -k1,1 -k2,2n -k3,3n > sample.fragments.bed`
4.  **Generate Bedgraph**:
    `bedtools genomecov -bg -i sample.fragments.bed -g genome_size.txt > sample.fragments.bedgraph`

## Expert Tips and Best Practices

*   **Zero-Signal Filtering**: Ensure your input bedgraphs do not contain lines with 0 signal. SEACR is optimized for sparse data and extra zero-lines can interfere with the thresholding algorithm.
*   **Control Selection**: While IgG is the standard control, if IgG background is extremely low, SEACR may produce an unusually high number of peaks. In such cases, using a numeric threshold (e.g., `0.01` or `0.05`) can provide more stable results.
*   **Fragment Size**: For CUT&RUN, it is often beneficial to filter for fragments < 120bp to specifically identify transcription factor footprints, or use all fragments for histone modifications.
*   **Output Interpretation**: The output is a BED file where:
    *   Column 4: Total signal (AUC)
    *   Column 5: Maximum signal (Peak height)
    *   Column 6: The specific coordinates within the peak that attained the maximum signal.

## Reference documentation

- [SEACR README](./references/github_com_FredHutch_SEACR_blob_master_README.md)
- [SEACR Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_seacr_overview.md)