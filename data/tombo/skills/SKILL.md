---
name: tombo
description: Tombo is a specialized suite of tools designed to process raw electrical signal data from Oxford Nanopore sequencers.
homepage: https://github.com/nanoporetech/tombo
---

# tombo

## Overview
Tombo is a specialized suite of tools designed to process raw electrical signal data from Oxford Nanopore sequencers. It enables the identification of modified bases (such as 5mC, 6mA, dam, or dcm) by aligning raw signal levels to a reference sequence—a process known as "re-squiggling." Once aligned, Tombo can detect modifications by comparing observed signals against a standard canonical model, an alternative modified-base model, or a control sample.

## Core Workflow and CLI Patterns

### 1. Pre-processing: Single-read FAST5 Requirement
Tombo does **not** support multi-read FAST5 files. You must convert them to single-read format before starting.
```bash
# Use ont_fast5_api (external to tombo) if files are in multi-read format
multi_to_single_fast5 --input_path multi_fast5_dir --save_path single_fast5_dir
```

### 2. Re-squiggle (Signal-to-Reference Alignment)
This is the mandatory first step for all Tombo analyses. It creates an index and stores the raw signal alignments.
```bash
tombo resquiggle path/to/fast5s/ genome.fasta --processes 4 --num-most-common-errors 5
```

### 3. Modification Detection
Choose the algorithm based on your experimental design:

*   **Alternative Model (Preferred for known mods):** Use for specific modifications like CpG, dam, or dcm.
    ```bash
    tombo detect_modifications alternative_model --fast5-basedirs path/to/fast5s/ \
        --statistics-file-basename sample_stats --alternate-bases dam dcm --processes 4
    ```
*   **Sample Comparison:** Best for high-coverage data where a modified sample is compared to an unmodified control.
    ```bash
    tombo detect_modifications level_sample_compare --fast5-basedirs path/to/modified_fast5s/ \
        --control-fast5-basedirs path/to/control_fast5s/ --statistics-file-basename compare_stats
    ```
*   **De Novo Detection:** Use to find deviations from the canonical model when the specific modification type is unknown.
    ```bash
    tombo detect_modifications de_novo --fast5-basedirs path/to/fast5s/ \
        --statistics-file-basename denovo_stats
    ```

### 4. Visualization and Export
*   **Plotting Signal:** Visualize raw signal at the most significant sites.
    ```bash
    tombo plot most_significant --fast5-basedirs path/to/fast5s/ \
        --statistics-filename sample_stats.dam.tombo.stats \
        --plot-standard-model --pdf-filename plots.pdf
    ```
*   **Genome Browser Files:** Export results to wiggle (.wig) format for IGV or UCSC.
    ```bash
    tombo text_output browser_files --statistics-filename sample_stats.dam.tombo.stats \
        --file-types dampened_fraction --browser-file-basename sample_output
    ```

## Expert Tips and Best Practices
*   **RNA Analysis:** When processing direct RNA, ensure you use the `--rna` flag during the `resquiggle` step if it is not automatically detected.
*   **Resource Management:** Use the `--processes` flag to parallelize tasks, but be mindful of RAM, as signal processing is memory-intensive.
*   **Model Selection:** The `alternative_model` is generally more accurate than `de_novo` because it uses trained signal distributions for specific modified bases.
*   **Legacy Status:** Note that Tombo is currently unsupported by Oxford Nanopore and has been largely replaced by **Remora**. Use Tombo primarily for legacy pipelines or specific visualization features not yet available in newer tools.

## Reference documentation
- [Tombo GitHub Repository](./references/github_com_nanoporetech_tombo.md)
- [Tombo Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tombo_overview.md)