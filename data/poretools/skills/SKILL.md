---
name: poretools
description: Poretools is a toolkit for manipulating, extracting, and visualizing data from Oxford Nanopore FAST5 files. Use when user asks to extract FASTQ or FASTA sequences, calculate run statistics, or generate plots for read length distributions and sequencing yield.
homepage: https://github.com/arq5x/poretools
---


# poretools

## Overview

`poretools` is a specialized suite of command-line utilities designed to handle the HDF5-based FAST5 format produced by Oxford Nanopore Technologies (ONT) sequencing devices. It serves as a critical bridge between raw basecalled data and standard bioinformatics formats, allowing researchers to perform rapid quality control, data extraction, and exploratory visualization without needing to write custom HDF5 parsing scripts.

## Core CLI Usage

The general syntax for `poretools` follows a subcommand structure:
`poretools [subcommand] [options] [path_to_fast5_files]`

### Data Extraction
*   **Extract FASTQ**: `poretools fastq <data_dir>`
    *   Extracts basecalled sequences in FASTQ format.
    *   Use the `--type` flag to specify which reads to extract (e.g., `fwd`, `rev`, `2D`, or `best`).
*   **Extract FASTA**: `poretools fasta <data_dir>`
    *   Similar to the FASTQ command but outputs FASTA format.
*   **Extract Events**: `poretools events <data_dir>`
    *   Extracts the event data (signal transitions) from the FAST5 files.

### Statistics and Metadata
*   **Summary Statistics**: `poretools stats <data_dir>`
    *   Provides a quick overview of the run, including total reads, total base pairs, and N50.
    *   Use the `--group` switch to organize statistics by specific attributes.
*   **Read Timing**: `poretools times <data_dir>`
    *   Extracts the start time and duration of each read, useful for analyzing throughput over the course of a run.

### Visualization
*   **Yield Plot**: `poretools yield_plot --saveas yield.png <data_dir>`
    *   Generates a plot showing the accumulation of data (bases or reads) over the duration of the sequencing run.
*   **Length Histogram**: `poretools hist --saveas hist.png <data_dir>`
    *   Creates a histogram of read length distributions.
*   **Quality vs. Position**: `poretools qual_vs_pos --saveas qvp.png <data_dir>`
    *   Visualizes how base quality changes across the length of the reads.

## Expert Tips and Best Practices

*   **Recursive Processing**: `poretools` supports directory-level input. It will automatically search for all `.fast5` files within a provided directory path.
*   **Handling Large Datasets**: For very large runs, pipe the output of extraction commands to a file or a compressor (e.g., `poretools fastq data/ | gzip > output.fastq.gz`) to save disk space.
*   **The "Best" Read Type**: When working with 2D sequencing data, using `--type best` is a common heuristic to extract the highest quality representation available for each read (preferring 2D over 1D).
*   **Environment Requirements**: Ensure the environment has `HDF5` (>= 1.8.7) and `h5py` installed, as these are the core dependencies for reading the FAST5 format.
*   **Headless Plotting**: If running on a server without a display, ensure `matplotlib` is configured to use a non-interactive backend (like `Agg`) to avoid errors when generating plots.



## Subcommands

| Command | Description |
|---------|-------------|
| fasta | Extract FASTA sequences from FAST5 files. |
| fastq | Extract FASTQ data from FAST5 files. |
| nucdist | Calculate nucleotide distribution from FAST5 files. |
| poretools index | Index FAST5 files for faster access. |
| poretools metadata | Report metadata from FAST5 files. |
| poretools qualpos | Analyze read quality and position in FAST5 files. |
| poretools readstats | Calculate and display read statistics from FAST5 files. |
| poretools times | Extract timing information from FAST5 files. |
| poretools winner | Reports the winner read from each FAST5 file. |
| poretools_combine | Combine FAST5 files into a TAR archive. |
| poretools_events | Report pre-basecalled events |
| poretools_hist | Generate histograms of read lengths from FAST5 files. |
| poretools_occupancy | Calculate and plot the occupancy of pores over time. |
| poretools_organise | Organise FAST5 files into a directory structure. |
| poretools_qualdist | Calculate and plot quality score distribution for Nanopore sequencing data. |
| poretools_squiggle | Generate squiggle plots from FAST5 files. |
| poretools_stats | Calculate and report statistics from FAST5 files. |
| poretools_tabular | Report FASTA entries from FAST5 files. |
| yield_plot | Generates a plot of yield per read from FAST5 files. |

## Reference documentation
- [poretools: a toolkit for working with Oxford nanopore data](./references/github_com_arq5x_poretools.md)
- [poretools commit history and feature updates](./references/github_com_arq5x_poretools_commits_master.md)