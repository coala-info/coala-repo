---
name: tombo
description: Tombo analyzes raw nanopore sequencing signals by aligning them to a reference genome to identify base modifications. Use when user asks to re-squiggle raw signal data, detect DNA or RNA modifications, compare signal levels between samples, or visualize signal-to-reference alignments.
homepage: https://github.com/nanoporetech/tombo
---

# tombo

## Overview

Tombo is a comprehensive suite designed for the analysis of raw nanopore sequencing signals. It functions by aligning raw electrical signal data to a reference genome—a process known as "re-squiggling"—which allows for the identification of base modifications based on deviations from expected canonical signal levels. It supports both DNA and direct RNA sequencing and provides tools for statistical detection, visualization of signal-to-reference alignments, and exporting results into standard genomic formats like wiggle files.

## Core Workflow and CLI Patterns

### 1. Signal Alignment (Re-squiggle)
The mandatory first step for any Tombo analysis is to align raw signal to a reference sequence. This creates the necessary index for downstream tools.

```bash
# Basic re-squiggle command
tombo resquiggle path/to/fast5s/ genome.fasta --processes 4 --num-most-common-errors 5
```

### 2. Modification Detection
Tombo offers three primary algorithms depending on the experimental design:

*   **Alternative Model (Preferred):** Use for known modifications with trained models (e.g., CpG, 5mC, 6mA, dam, dcm).
    ```bash
    tombo detect_modifications alternative_model --fast5-basedirs path/to/fast5s/ \
        --statistics-file-basename sample_stats \
        --alternate-bases dam dcm --processes 4
    ```
*   **De Novo Detection:** Use to identify deviations from canonical signal without a control sample or specific model.
    ```bash
    tombo detect_modifications de_novo --fast5-basedirs path/to/fast5s/ \
        --statistics-file-basename sample.de_novo --processes 4
    ```
*   **Sample Comparison:** Use to compare signal levels between a "treated" and "control" sample.
    ```bash
    tombo detect_modifications level_sample_compare --fast5-basedirs path/to/treated/ \
        --control-fast5-basedirs path/to/control/ --statistics-file-basename comparison_results
    ```

### 3. Visualization
Visualize raw signal at specific genomic locations or the most significantly modified sites.

```bash
# Plot signal at the most significant sites for a specific modification
tombo plot most_significant --fast5-basedirs path/to/fast5s/ \
    --statistics-filename sample_stats.dcm.tombo.stats \
    --plot-standard-model --plot-alternate-model dcm \
    --pdf-filename significant_sites.pdf
```

### 4. Exporting Results
Convert Tombo statistics into browser-compatible formats for visualization in IGV or UCSC Genome Browser.

```bash
# Generate wiggle files for modified fraction
tombo text_output browser_files --statistics-filename sample_stats.tombo.stats \
    --file-types dampened_fraction --browser-file-basename output_prefix

# Generate coverage files
tombo text_output browser_files --fast5-basedirs path/to/fast5s/ \
    --file-types coverage --browser-file-basename sample_coverage
```

## Expert Tips and Best Practices

*   **Data Format:** Tombo does not support multi-read FAST5 files. You must convert multi-read FAST5s to single-read format using `ont_fast5_api` (command: `multi_to_single_fast5`) before processing.
*   **Dependency Management:** Tombo is sensitive to Python library versions. Ensure `numpy < 1.20` and `h5py < 3` are installed to avoid compatibility errors during execution or installation.
*   **Performance:** Always utilize the `--processes` flag to parallelize re-squiggling and modification detection, as these tasks are computationally intensive.
*   **RNA Analysis:** When processing direct RNA data, ensure you use the specific RNA-trained models and reference the [RNA-specific documentation](./references/github_com_nanoporetech_tombo_blob_master_README.rst.md) for parameter adjustments.
*   **Successor Tool:** Note that Oxford Nanopore now recommends `remora` for many modification calling tasks; use Tombo specifically for its unique de novo detection capabilities or legacy FAST5 workflows.



## Subcommands

| Command | Description |
|---------|-------------|
| tombo | Tombo is a suite of tools primarily for the identification of modified nucleotides from nanopore sequencing data. |
| tombo clear_filters | Clear filters from FAST5 files in the specified directories. |
| tombo cluster_most_significant | Cluster and plot the most significant signal differences between two sets of FAST5 files. |
| tombo estimate_alt_reference | Estimate alternative reference models from FAST5 data for non-standard base detection. |
| tombo estimate_kmer_reference | Estimate k-mer reference model from FAST5 files. |
| tombo event_resquiggle | Resquiggle (align) raw nanopore signal to a reference genome using existing basecalls. |
| tombo filter_stuck | Filter reads based on observations per base percentile thresholds to identify 'stuck' reads. |
| tombo model_resquiggle | Perform model-based re-squiggle of FAST5 files to refine signal-to-sequence alignment. |
| tombo plot_correction | Plot signal-to-sequence alignment correction (resquiggle) results from FAST5 files. |
| tombo plot_genome_location | Plot raw signal at specific genomic locations from fast5 files. |
| tombo plot_kmer | Plot k-mer distributions from FAST5 data using Tombo. |
| tombo plot_max_coverage | Plot regions with maximum coverage from FAST5 data using Tombo. |
| tombo plot_max_difference | Plot regions with the maximum difference in signal between two sets of FAST5 files. |
| tombo plot_most_significant | Plot the most significant regions of difference between two sets of FAST5 files or based on statistics. |
| tombo plot_motif_centered | Plot signal and statistics centered at a specific motif using Tombo-processed FAST5 data. |
| tombo plot_motif_with_stats | Plot signal and statistics at a specific motif using Tombo. |
| tombo plot_multi_correction | Plot multiple corrected signal alignments from FAST5 files. |
| tombo plot_per_read | Plot per-read signal at specific genomic locations using Tombo. |
| tombo resquiggle | Re-annotate raw nanopore signal to a genomic reference (resquiggle). |
| tombo test_significance | Test for significant differences in signal between two sets of FAST5 files or against a model to identify modified bases. |
| tombo write_most_significant_fasta | Write FASTA file of sequences from the most significant regions based on Tombo statistics. |
| tombo write_wiggles | Write wiggle files from FAST5 data or statistics for visualization. |

## Reference documentation
- [Tombo README and Usage Guide](./references/github_com_nanoporetech_tombo_blob_master_README.rst.md)
- [Installation and Dependency Specifications](./references/github_com_nanoporetech_tombo_blob_master_setup.py.md)