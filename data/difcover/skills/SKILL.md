---
name: difcover
description: DifCover identifies genomic regions with significant read coverage differences between two samples aligned to the same reference using a window-stretching approach. Use when user asks to identify differential coverage regions, compare read depth between BAM files, or perform circular binary segmentation on coverage ratios.
homepage: https://github.com/timnat/DifCover
metadata:
  docker_image: "quay.io/biocontainers/difcover:3.0.1--h9948957_2"
---

# difcover

---

## Overview
DifCover is a bioinformatics pipeline designed to identify genomic regions where the read coverage of one sample significantly differs from another when aligned to the same reference. It utilizes a unique "window stretching" method, where windows are defined by a fixed number of "valid" bases rather than a fixed genomic length. This approach allows the tool to bridge across under-represented fragments (low coverage) and over-represented repetitive regions, providing a more accurate comparison in complex or fragmented genomes.

## Installation and Setup
Before running the pipeline, ensure `BEDTOOLS`, `SAMTOOLS`, `AWK`, and the R package `DNAcopy` are in your PATH.

1.  **Compile the C++ component**:
    Navigate to the `dif_cover_scripts` directory and run `make` to compile the `from_unionbed_to_ratio_per_window_CC0` binary.
2.  **Permissions**:
    Ensure all shell scripts are executable: `chmod +x *.sh`.

## Core Workflow
The pipeline can be executed using the `run_difcover.sh` wrapper or stage-by-stage for fine-tuned parameter control.

### Stage 1: BAM to UnionBed
Converts two coordinate-sorted BAM files into a single coverage file.
```bash
./from_bams_to_unionbed.sh sample1.bam sample2.bam
```
*   **Output**: `sample1_sample2.unionbedcv` and `ref.length.Vk1s_sorted`.

### Stage 2: Stretched Window Calculation
This is the core logic where coverage ratios are calculated using "valid" bases.
```bash
./from_unionbed_to_ratio_per_window_CC0 sample1_sample2.unionbedcv a A b B v l
```
*   **a / A**: Minimum and maximum coverage thresholds for Sample 1.
*   **b / B**: Minimum and maximum coverage thresholds for Sample 2.
*   **v**: Target number of valid bases per window (e.g., 1000).
*   **l**: Minimum window size (total bases) to output.
*   **Logic**: A base is "valid" if it is not a repeat (below max thresholds) and has sufficient data (above min thresholds in at least one sample).

### Stage 3: DNAcopy Segmentation
Normalizes the ratios and performs circular binary segmentation.
```bash
./from_ratio_per_window__to__DNAcopy_output.sh <ratio_file> AC
```
*   **AC (Adjustment Coefficient)**: Used to normalize samples if their modal coverages differ. Set to 1.0 if samples are already balanced.

### Stage 4: Extracting Significant Fragments
Extracts the final regions of interest based on an enrichment threshold.
```bash
./from_DNAcopyout_to_p_fragments.sh <dnacopy_file> P
```
*   **P**: Enrichment score threshold. A value of `P=2` typically identifies regions where Sample 1 coverage is ~4x higher than Sample 2.

## Expert Tips
*   **Handling Zero Coverage**: If Sample 2 has zero coverage in a window, the tool uses a continuity correction (CC0) representing 0.5 reads to avoid division by zero.
*   **Fragmented Assemblies**: If working with highly fragmented scaffolds, the "stretched window" approach is superior to `bedtools` or `sambamba` because it prevents small gaps from artificially inflating or deflating coverage ratios.
*   **Parameter Tuning**: For highly contiguous genomes, you can combine adjacent windows with similar ratios to generate larger consensus regions for downstream analysis.



## Subcommands

| Command | Description |
|---------|-------------|
| difcover_from_ratio_per_window__to__DNAcopy_output.sh | Converts ratio per window files to DNAcopy output format. |
| difcover_from_unionbed_to_ratio_per_window_CC0 | Calculates the ratio of coverage per window between two samples from a unionbed file. |
| difcover_run_difcover.sh | Stage 1 |
| from_DNAcopyout_to_p_fragments.sh | Converts DNAcopy output to p fragments, filtering intervals based on enrichment scores. |
| from_bams_to_unionbed.sh | Calculates coverage for BAM files using BEDTOOLS and SAMTOOLS. The main output reports coverage for input samples in corresponding columns for each bed interval. Additional files report coverage for each sample separately. |

## Reference documentation
- [DifCover GitHub Home](./references/github_com_timnat_DifCover.md)
- [DifCover Wiki](./references/github_com_timnat_DifCover_wiki.md)