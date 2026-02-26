---
name: macs2
description: MACS2 identifies enriched genomic regions from high-throughput sequencing data by modeling fragment shifts and evaluating statistical significance. Use when user asks to call narrow or broad peaks, identify transcription factor binding sites, or detect differential peaks between samples.
homepage: https://pypi.org/project/MACS2/
---


# macs2

## Overview
MACS2 (Model-based Analysis of ChIP-Seq) is a specialized toolset designed to identify enriched genomic regions from high-throughput sequencing data. It improves the spatial resolution of binding sites by modeling the shift between sequencing tags on opposite strands and accounts for genome complexity to evaluate the significance of enriched regions. While primarily used for ChIP-Seq, it is applicable to any DNA enrichment assay where significant read coverage over background needs to be identified.

## Core Workflows

### Standard Peak Calling
Use the `callpeak` subcommand for most transcription factor binding site analyses.

```bash
macs2 callpeak -t treatment.bam -c control.bam -f BAM -g hs -n experiment_name -q 0.01
```

*   **-t / --treatment**: Treatment sample file(s). Multiple files can be pooled (e.g., `-t rep1.bam rep2.bam`).
*   **-c / --control**: Control/Input sample file(s).
*   **-g / --gsize**: Effective genome size. Use shortcuts for common organisms:
    *   `hs`: Human (2.7e9)
    *   `mm`: Mouse (1.87e9)
    *   `ce`: C. elegans (9e7)
    *   `dm`: D. melanogaster (1.2e8)
*   **-q / --qvalue**: Minimum FDR cutoff for significant regions (default is 0.05).

### Broad Peak Calling
For histone modifications or markers that cover wider genomic regions (e.g., H3K36me3), use the `--broad` flag.

```bash
macs2 callpeak -t treatment.bam -c control.bam --broad -g hs --broad-cutoff 0.1
```

### Paired-End Data
When working with paired-end sequencing, specify the format explicitly to use actual fragment sizes instead of the bimodal model.

```bash
macs2 callpeak -t treatment.bam -c control.bam -f BAMPE -g hs -n pe_experiment
```

## Subcommand Reference

| Subcommand | Purpose |
| :--- | :--- |
| `callpeak` | Main function for identifying narrow or broad peaks. |
| `bdgdiff` | Differential peak detection based on paired bedGraph files. |
| `filterdup` | Remove duplicate reads to reduce PCR bias. |
| `predictd` | Predict the fragment size (d) from alignment results without calling peaks. |
| `bdgcmp` | Compare two signal tracks (e.g., treatment vs control) in bedGraph format. |
| `randsample` | Randomly sample a subset of reads to balance library sizes. |
| `refinepeak` | Refine peak summits using raw read alignments. |

## Expert Tips and Best Practices

*   **Format Detection**: While `-f AUTO` works for many formats, it cannot automatically detect `BAMPE` or `BEDPE`. Always specify these formats manually for paired-end data to ensure fragment-based pileup.
*   **Effective Genome Size**: Do not use the total chromosome length for `-g`. Use the mappable genome size (roughly 70-90% of the total size). If your organism is not in the shortcut list, provide the specific number (e.g., `-g 1.2e8`).
*   **Output Files**:
    *   `.xls`: A tab-delimited file containing peak coordinates and statistics.
    *   `_peaks.bed`: Standard BED file for genome browsers.
    *   `_summits.bed`: Single-nucleotide locations of peak summits; ideal for motif discovery.
*   **Duplicate Reads**: MACS2's `callpeak` has an internal duplicate filter. If you have already filtered duplicates using other tools (like Picard), you can adjust `--keep-dup` to `all`.
*   **BedGraph Output**: Use the `-B` or `--bdg` flag during `callpeak` to generate bedGraph files. These are essential if you plan to use `bdgcmp` or `bdgdiff` later.

## Reference documentation
- [MACS2 Project Description](./references/pypi_org_project_MACS2_2.2.9.1.md)
- [MACS2 Subcommand Overview](./references/pypi_org_project_MACS2_2.2.8.md)