---
name: nanoraw
description: Nanoraw processes FAST5 files to align raw nanopore electrical signals to a reference genome through a process called re-squiggling. Use when user asks to re-squiggle reads, visualize signal traces across genomic regions, or export signal statistics into wiggle formats.
homepage: https://github.com/marcus1487/nanoraw
---


# nanoraw

## Overview

The `nanoraw` skill enables the processing of FAST5 files to align raw electrical signal levels to a reference genome. This process, known as "re-squiggling," is a prerequisite for downstream analysis such as DNA modification detection or signal-level visualization. Use this skill when you need to correct basecall-to-signal assignments, plot signal traces across genomic regions, or export signal statistics into wiggle formats for genome browsers.

Note: This package is the predecessor to Tombo. While functional for legacy workflows, users seeking the latest features in nanopore signal analysis may also consider Tombo.

## Core Workflow

### 1. Genome Resquiggling (Required First Step)
Before any plotting or analysis, you must run `genome_resquiggle`. This command maps existing basecalls to the reference genome and then re-aligns the raw signal to that genomic sequence.

```bash
nanoraw genome_resquiggle --fast5-search-dir /path/to/fast5s/ --genome-lib-prep /path/to/genome.fa
```

### 2. Signal Visualization
Once resquiggled, use plotting commands to inspect the data.

*   **By Location**: View signal at specific coordinates.
    ```bash
    nanoraw plot_genome_location --fast5-search-dir /path/to/fast5s/ --genome-location chr1:100-200
    ```
*   **By Motif**: Center plots on a specific DNA sequence (e.g., GATC).
    ```bash
    nanoraw plot_motif_centered --fast5-search-dir /path/to/fast5s/ --motif GATC --genome-lib-prep /path/to/genome.fa
    ```
*   **Comparison**: Identify differences between a "treatment" and "control" set of reads.
    ```bash
    nanoraw plot_most_significant --fast5-search-dir /path/to/treatment/ --control-fast5-search-dir /path/to/control/
    ```

### 3. Data Export
Export signal data for use in external tools like IGV or UCSC Genome Browser.

```bash
nanoraw write_wiggles --fast5-search-dir /path/to/fast5s/ --output-filename my_experiment
```

## Expert Tips and Best Practices

*   **Alignment Tools**: `nanoraw` requires either `graphmap` or `BWA-MEM` to be installed and in your system PATH for the resquiggle step.
*   **Plotting Dependencies**: If plotting commands fail, ensure the R packages `ggplot2` and `cowplot` are installed in your R environment, as `nanoraw` calls these via `rpy2`.
*   **Recursive Search**: Use the `--recursive` flag if your FAST5 files are organized in subdirectories.
*   **Batch Size**: If encountering memory issues during alignment, adjust the alignment batch size (default is 500 reads).
*   **HDF5 Errors**: If you see "simultaneous access" errors, avoid running multiple `nanoraw` instances on the same directory of FAST5 files, as the HDF5 format often restricts concurrent write access.



## Subcommands

| Command | Description |
|---------|-------------|
| nanoraw | nanoraw: error: invalid choice: 'Additional' (choose from 'genome_resquiggle', 'plot_max_coverage', 'plot_genome_location', 'plot_motif_centered', 'plot_max_difference', 'plot_most_significant', 'plot_motif_with_stats', 'plot_correction', 'plot_multi_correction', 'cluster_most_significant', 'plot_kmer', 'write_most_significant_fasta', 'write_wiggles') |
| nanoraw cluster_most_significant | Compares two sets of fast5 files to find significant differences in signal levels. |
| nanoraw genome_resquiggle | Resquiggle raw signal data to a reference genome. |
| nanoraw plot_correction | Plotting tool for Nanopore genome correction. |
| nanoraw plot_genome_location | Plot signal at specified genomic locations. |
| nanoraw plot_kmer | Plot k-mer distribution from FAST5 files. |
| nanoraw plot_max_coverage | Plots the maximum coverage of Nanopore reads across genomic regions. |
| nanoraw plot_max_difference | Plotting the maximum difference between two sets of fast5 files. |
| nanoraw plot_most_significant | Plot regions with significant differences in signal level between two sets of FAST5 files. |
| nanoraw plot_motif_centered | Plot motif centered regions and statistic distributions at each genomic base in the region. |
| nanoraw plot_multi_correction | Plot signal at specified genomic locations. |
| nanoraw_plot_motif_with_stats | Plot motif statistics |
| nanoraw_write_wiggles | Write wiggle files for Nanopore data. |
| write_most_significant_fasta | Write the most significant regions to a FASTA file. |

## Reference documentation

- [nanoraw GitHub README](./references/github_com_marcus1487_nanoraw_blob_master_README.md)
- [nanoraw PyPI Overview](./references/pypi_org_project_nanoraw.md)