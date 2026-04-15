---
name: ont-tombo
description: Tombo processes raw Nanopore electrical signals to align them to a reference genome and identify base modifications. Use when user asks to resquiggle reads, detect DNA or RNA modifications using alternative models or sample comparisons, and visualize raw signal deviations.
homepage: https://github.com/nanoporetech/tombo
metadata:
  docker_image: "quay.io/biocontainers/ont-tombo:1.5.1--py37r36hb3f55d8_0"
---

# ont-tombo

## Overview
Tombo is a specialized suite of tools designed to process the raw electrical signal from Nanopore sequencers. Its primary function is to "resquiggle" reads—aligning raw signal levels to a reference genome—and then apply statistical tests to identify base modifications. It supports three main detection strategies: alternative model comparison (most accurate for known motifs), sample comparison (comparing a treated sample to a control), and de novo detection (identifying deviations from canonical signal levels).

**Note:** Tombo is currently unsupported by Oxford Nanopore and has been largely replaced by **Remora**. Use this skill only when legacy Tombo workflows are specifically required.

## Core Workflow and CLI Patterns

### 1. Data Preparation
Tombo does **not** support multi-read FAST5 files. You must convert them to single-read format using `ont_fast5_api` before starting.

```bash
# Convert multi-read FAST5 to single-read
multi_to_single_fast5 --input_path multi_fast5/ --save_path single_fast5/
```

### 2. Resquiggling (Required First Step)
This aligns the raw signal to the reference sequence. This step is mandatory for all downstream analysis.

```bash
tombo resquiggle path/to/single_fast5s/ genome.fasta --processes 4 --num-most-common-errors 5
```

### 3. Detecting Modifications
Choose the algorithm based on your experimental design:

**Alternative Model (Preferred for DNA Methylation)**
Best for specific known modifications like CpG, dam, or dcm.
```bash
tombo detect_modifications alternative_model --fast5-basedirs path/to/fast5s/ \
    --statistics-file-basename sample_name \
    --alternate-bases dam dcm --processes 4
```

**Sample Comparison**
Best for direct RNA or cases where you have a "clean" control sample.
```bash
tombo detect_modifications level_sample_compare --fast5-basedirs path/to/treated_fast5s/ \
    --control-fast5-basedirs path/to/control_fast5s/ \
    --minimum-test-reads 50 --processes 4 \
    --statistics-file-basename sample_comparison
```

**De Novo Detection**
Used when looking for unknown modifications without a control.
```bash
tombo detect_modifications de_novo --fast5-basedirs path/to/fast5s/ \
    --statistics-file-basename sample_de_novo --processes 4
```

### 4. Exporting Results
Convert internal statistics into standard genomic formats (Wiggle/BedGraph) for visualization in IGV or UCSC Genome Browser.

```bash
# Output dampened fraction (estimated fraction of modified reads)
tombo text_output browser_files --statistics-filename sample_name.dam.tombo.stats \
    --file-types dampened_fraction --browser-file-basename sample_output
```

### 5. Visualization
Generate PDF plots of the raw signal compared to the expected canonical model.

```bash
tombo plot most_significant --fast5-basedirs path/to/fast5s/ \
    --statistics-filename sample_name.tombo.stats \
    --plot-standard-model --pdf-filename visualization.pdf
```

## Expert Tips
- **Resource Management**: Always use the `--processes` flag to utilize multiple CPU cores, as resquiggling and modification detection are computationally intensive.
- **RNA Analysis**: When working with direct RNA, ensure you use the `--rna` flag during the `resquiggle` step if it is not automatically detected.
- **Dampened Fraction**: When exporting results, `dampened_fraction` is generally more useful than raw statistics for biological interpretation, as it accounts for low-coverage noise.
- **Failed Reads**: If many reads fail to resquiggle, check if the basecalls in the FAST5 files match the reference genome provided.

## Reference documentation
- [Tombo GitHub Repository](./references/github_com_nanoporetech_tombo.md)
- [ont-tombo Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ont-tombo_overview.md)