---
name: sequenoscope
description: Sequenoscope is a bioinformatics toolkit designed to analyze, visualize, and filter Oxford Nanopore adaptive sampling data to assess enrichment or depletion. Use when user asks to process raw sequencing data, compare test and control conditions through interactive plots, or subset reads based on ONT metadata.
homepage: https://github.com/phac-nml/sequenoscope
---


# sequenoscope

## Overview
Sequenoscope is a specialized bioinformatics toolkit designed to handle the unique outputs of ONT adaptive sampling. It streamlines the process of assessing enrichment or depletion by providing three distinct modules: `analyze` for data processing and mapping, `plot` for interactive comparative visualization, and `filter_ONT` for precise read subsetting based on sequencing metadata. It is particularly useful for metagenomics and experimental validation where "test" and "control" conditions need to be compared.

## Core Modules and Usage

### 1. The analyze Module
This is the primary engine for processing raw data. It performs read filtering, mapping, and statistic generation.

**Basic Pattern:**
```bash
sequenoscope analyze --fastq <input.fastq> --ref <reference.fasta> --summary <sequencing_summary.txt> --output <output_dir>
```

**Key Tips:**
* **Reference FASTA:** You can include multiple taxa or genomes in a single reference file to assess metagenomic composition.
* **Sequencing Summary:** While optional, providing the Guppy/Dorado `sequencing_summary.txt` is critical for inferring adaptive sampling decisions (e.g., unblock vs. stay).
* **Outputs:** Look for the `sample_manifest.txt` and `summary_sample_manifest.txt` in the output directory for detailed stats on read length, Q-score, and coverage.

### 2. The plot Module
Used for comparative analysis. It requires outputs from the `analyze` module for two different conditions.

**Basic Pattern:**
```bash
sequenoscope plot --test <analyze_output_dir_1> --control <analyze_output_dir_2> --output <plot_dir>
```

**Key Tips:**
* **Interactive Visuals:** This module generates HTML-based interactive plots using Plotly.
* **Adaptive Sampling Focus:** It specifically visualizes independent and cumulative read-decision bar charts to show how the sequencer handled different taxa.
* **Requirement:** You must have both a test and a control directory; it is not designed for single-sample visualization.

### 3. The filter_ONT Module
Used for subsetting raw reads based on specific ONT metadata.

**Basic Pattern:**
```bash
sequenoscope filter_ONT --fastq <input.fastq> --summary <sequencing_summary.txt> --criteria <filter_params>
```

**Key Tips:**
* **Precision Filtering:** Use this to isolate reads from specific channels or those that received specific adaptive sampling decisions (e.g., only "unblocked" reads).

## Expert Tips and Best Practices

* **Data Preparation:** If you have multiple FASTQ files (e.g., from different flow cell pores), concatenate them into a single file or a single `.fastq.gz` before running the `analyze` module.
* **Adaptive Sampling Inference:** Sequenoscope infers decisions based on the `end_reason` field in the summary file. Note that these are operational approximations of the ReadUntil API decisions.
* **Illumina Support:** While optimized for ONT, you can process Illumina short-read data through the `analyze` module for manifest generation. However, adaptive sampling-specific plots will be disabled as the metadata does not exist for Illumina platforms.
* **Performance:** The tool leverages `minimap2` for mapping and `fastp` for filtering. Ensure these are in your PATH or installed via the Bioconda environment.

## Reference documentation
- [Sequenoscope GitHub Repository](./references/github_com_phac-nml_sequenoscope.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_sequenoscope_overview.md)