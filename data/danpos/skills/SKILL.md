---
name: danpos
description: The `danpos` (Dynamic Analysis of Nucleosome and Protein Occupancy by Sequencing) toolkit is a specialized suite for high-resolution chromatin analysis.
homepage: https://sites.google.com/site/danposdoc/
---

# danpos

## Overview
The `danpos` (Dynamic Analysis of Nucleosome and Protein Occupancy by Sequencing) toolkit is a specialized suite for high-resolution chromatin analysis. It is particularly effective for MNase-seq and ChIP-seq workflows where the goal is to define discrete binding sites (nucleosomes or TFs) or broader enriched regions (histone marks). The tool provides unique metrics such as "fuzziness" scores to describe the stability of protein binding and supports complex experimental designs including replicates, background subtraction, and spike-in normalization.

## Command Line Usage Patterns

### Core Analysis Functions
Choose the command based on the expected width and characteristics of the protein binding:
- **dpos**: Best for nucleosomes or proteins with similar binding footprints (~147bp). Analyzes location, fuzziness, and occupancy.
- **dpeak**: Best for transcription factors. Analyzes peak width, height, and total signal.
- **dregion**: Best for broad histone modifications (e.g., H3K4me3). Analyzes enriched regions that may contain multiple peaks.
- **dtriple**: Runs all three algorithms simultaneously when the binding characteristics are unknown.

### Common CLI Syntax
The general structure is: `python danpos.py <command> <path> [options]`

**1. Basic Position Calling (Single Sample)**
```bash
python danpos.py dpos ./sample_directory/
```
*Note: If a directory is provided, danpos treats all files within as replicates.*

**2. Differential Analysis (Comparison)**
Use a colon `:` to separate treatment and control groups:
```bash
python danpos.py dpos treatment_dir:control_dir
```

**3. Background (Input/IgG) Subtraction**
Use the `-b` flag to specify background data:
```bash
python danpos.py dpeak treatment_sample.bed -b input_sample.bed
```

**4. Spike-in or Library Size Normalization**
Use the `-c` flag to manually specify read counts for normalization:
```bash
python danpos.py dpos sampleA:sampleB -c sampleA:10000000,sampleB:20000000
```

### Normalization and Processing Tips
- **Paired-end Data**: Always include `-m 1` if using paired-end reads.
- **Quantile Normalization**: The `-n Q` parameter is deprecated in newer versions. To perform quantile normalization:
    1. Run `dpos` with `-n N --smooth_width 0` to generate raw `.wig` files.
    2. Use the `wiq` command: `python danpos.py wiq <chr_size_file> fileA.wig:fileB.wig`.
- **Normalization Methods (`-n`)**:
    - `F`: Normalization by fold change (Default).
    - `S`: Normalization by sampling.
    - `N`: No normalization.

### Input Format Requirements
- **BED**: Requires the first 6 columns. For paired-end, pairs must be in adjacent lines with names ending in 1 and 2 (e.g., readA1, readA2).
- **BAM/SAM**: Must include header information (use `samtools view -h`).
- **Wiggle (.wig)**: When using `.wig` as input, `danpos` skips read shifting and fragment extension, assuming occupancy is already calculated.

## Expert Best Practices
- **Replicate Handling**: Group replicates into a single directory. `danpos` will automatically detect them and use them to improve statistical power.
- **Fuzziness Metric**: Pay attention to the `fuzziness_score` in `.positions.xls` files. A higher score indicates more delocalized or unstable binding, which is often biologically significant in nucleosome remodeling studies.
- **Output Navigation**:
    - `*.positions.integrative.xls`: The primary file for differential analysis results.
    - `pooled/*.wig`: Genome-wide occupancy tracks for visualization in IGV/UCSC.
    - `diff/*.wig`: Tracks representing the statistical significance of occupancy changes.

## Reference documentation
- [DANPOS Home](./references/sites_google_com_site_danposdoc_home.md)
- [Dpos Parameters](./references/sites_google_com_site_danposdoc_b-documentation_1-dpos_parameters.md)
- [Input File Specifications](./references/sites_google_com_site_danposdoc_b-documentation_1-dpos_input-files.md)
- [Output File Descriptions](./references/sites_google_com_site_danposdoc_b-documentation_1-dpos_output-files.md)
- [Quantile Normalization (WIQ)](./references/sites_google_com_site_danposdoc_a-tutorial_7-wiq.md)