---
name: koeken
description: Koeken acts as a specialized wrapper for LEfSe and QIIME, streamlining the identification of microbial biomarkers in complex datasets.
homepage: https://github.com/twbattaglia/koeken
---

# koeken

## Overview
Koeken acts as a specialized wrapper for LEfSe and QIIME, streamlining the identification of microbial biomarkers in complex datasets. It is particularly effective for researchers who need to run statistical comparisons across a "split" variable (such as time points) without manually subsetting their data. The tool handles taxonomic summarization, LEfSe formatting, and significance testing in a single command, producing organized outputs including cladograms and effect size results.

## Core Workflow and CLI Patterns

### Basic Longitudinal Analysis
To run a standard analysis across multiple time points, use the following pattern:

```bash
koeken.py \
  --input otu_table.biom \
  --output output_folder/ \
  --map mapping_file.txt \
  --class Treatment_Column \
  --split Time_Point_Column
```

### Generating Visualizations
To automatically generate LEfSe cladograms for every time point processed, add the `--clade` flag. You can specify the image format and resolution:

```bash
koeken.py \
  -i input.biom -o output/ -m map.txt -cl Treatment -sp Day \
  --clade \
  --image pdf \
  --dpi 300
```

### Targeted Group Comparisons
If your mapping file contains multiple groups but you only want to compare specific ones (e.g., Control vs. Treatment A), use the `--compare` argument:

```bash
koeken.py \
  -i input.biom -o output/ -m map.txt -cl Treatment -sp Day \
  --compare Control Treatment_A
```

### Functional Biomarker Discovery (PICRUSt)
When working with PICRUSt functional predictions (Level 3), use the `--pi` flag to optimize the analysis for functional features:

```bash
koeken.py -i picrust_l3.biom -o output/ -m map.txt -cl Treatment -sp Day --pi
```

## Parameters and Best Practices

### Statistical Thresholds
*   **Effect Size**: Adjust the LDA score cutoff with `-e` (default is 2.0). Higher values (e.g., 3.0 or 4.0) identify more "influential" biomarkers.
*   **Alpha Value**: Change the p-value threshold for the ANOVA test using `-p` (default is 0.05).
*   **Strictness**: Use `-str 0` (default) for more strict comparisons or `-str 1` for less strict settings.

### Data Organization
*   **Taxonomic Level**: By default, Koeken collapses data at Level 6 (Genus). Use `-l` to specify levels 2 through 7.
*   **Subject ID**: If your mapping file uses a header other than `#SampleID` for the first column, specify it with `--subject`.

### Output Structure
Koeken organizes results into specific subdirectories to prevent file clutter:
*   `summarize_taxa/`: Contains the QIIME-generated taxonomic summaries.
*   `lefse_output/format_lefse/`: Contains the processed files ready for LEfSe.
*   `lefse_output/run_lefse/`: Contains the final significance test results and LDA scores.

## Expert Tips
*   **Environment**: Koeken relies on QIIME scripts and R. Ensure you are in a QIIME-enabled environment (like MacQIIME) or that QIIME scripts are in your system PATH.
*   **Naming Conventions**: The tool automatically cleans GreenGenes naming strings (e.g., removing `k__` or `g__` prefixes) to ensure cleaner labels in outputs and plots.
*   **Galaxy Compatibility**: The files in `run_lefse/` (extension `.lefse_res`) and `format_lefse/` (extension `.lefse_for`) can be uploaded directly to the Galaxy LEfSe web tool for further custom visualization.

## Reference documentation
- [twbattaglia/koeken README](./references/github_com_twbattaglia_koeken.md)