---
name: nanoraw
description: "nanoraw is a toolkit for genome-guided re-segmentation and visualization of raw nanopore sequencing data. Use when user asks to resquiggle nanopore reads, visualize signal intensity at specific genomic locations, or identify differences in signal between control and treatment groups."
homepage: https://github.com/marcus1487/nanoraw
---


# nanoraw

## Overview
nanoraw is a specialized toolkit designed for genome-guided re-segmentation and visualization of raw nanopore sequencing data. It functions by anchoring the raw electrical signal from a nanopore read to a specific genomic alignment, a process often referred to as "resquiggling." This allows for high-resolution analysis of signal intensity at the level of individual bases. While the project is now in maintenance mode (succeeded by the Tombo package), it remains a standard tool for legacy workflows involving signal-level analysis and de novo identification of DNA modifications.

## Core Workflow: The genome_resquiggle Command
The `genome_resquiggle` command is the mandatory first step in any nanoraw pipeline. It re-annotates raw signal with the genomic alignment of existing basecalls.

```bash
nanoraw genome_resquiggle --fast5-directory /path/to/fast5s/ --genome-fasta /path/to/genome.fasta
```

### Key Parameters
- `--fast5-directory`: Path to the folder containing your .fast5 files.
- `--genome-fasta`: The reference genome in FASTA format.
- `--recursive`: Use this flag if your FAST5 files are organized in subdirectories.
- `--aligner`: Choose between `graphmap` (default) or `bwamem`. Ensure the chosen aligner is installed in your PATH.

## Visualization and Plotting
Once the data is resquiggled, you can use various plotting commands to inspect the signal. Most plotting commands require the `[plot]` installation variant and an R environment with `ggplot2`.

### Genome Anchored Plotting
- **Specific Locations**: Plot signal at defined coordinates.
  ```bash
  nanoraw plot_genome_location --genome-locations chr1:1000-1100
  ```
- **Motif Centered**: Visualize signal around a specific sequence motif (e.g., GATC).
  ```bash
  nanoraw plot_motif_centered --motif GATC --genome-lib /path/to/resquiggled_data/
  ```
- **Max Difference**: Compare two groups of reads to find where signal differs most.
  ```bash
  nanoraw plot_max_difference --control-fast5-dirs /path/to/control/ --test-fast5-dirs /path/to/treatment/
  ```

### Sequencing Time Anchored Plotting
- **Correction Check**: Compare the segmentation before and after the resquiggle process.
  ```bash
  nanoraw plot_correction --fast5-file /path/to/read.fast5
  ```

## Data Export and Auxiliary Commands
- **Wiggle Files**: Export signal values, coverage, or statistics for viewing in genome browsers like IGV.
  ```bash
  nanoraw write_wiggles --fast5-directories /path/to/resquiggled_data/ --output-prefix my_experiment
  ```
- **Significant Regions**: Write out sequences where signal differences between groups are statistically significant.
  ```bash
  nanoraw write_most_significant --control-fast5-dirs /path/to/control/ --test-fast5-dirs /path/to/treatment/
  ```

## Expert Tips and Best Practices
- **Installation**: For full functionality including plotting, use `pip install nanoraw[plot]`. This requires `rpy2`, `ggplot2`, and `cowplot` to be available in your R environment.
- **Alignment Failures**: If `genome_resquiggle` fails to produce alignments, verify that your reference genome is indexed for the aligner you are using (e.g., `bwa index genome.fasta`).
- **Resource Management**: For large datasets, use the `--processes` flag to parallelize the resquiggling process.
- **Legacy Note**: If you encounter limitations or bugs, consider migrating your workflow to **Tombo**, which is the official successor to nanoraw and handles many of these tasks with improved algorithms.

## Reference documentation
- [nanoraw GitHub Repository](./references/github_com_marcus1487_nanoraw.md)
- [nanoraw Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_nanoraw_overview.md)