---
name: binning_refiner
description: `binning_refiner` is a bioinformatics tool designed to optimize metagenomic binning results.
homepage: https://github.com/songweizhi/Binning_refiner
---

# binning_refiner

## Overview
`binning_refiner` is a bioinformatics tool designed to optimize metagenomic binning results. Instead of relying on a single binning algorithm, it identifies the intersection of contigs across different binning outputs. By keeping only the contigs that multiple programs agree upon (or reconciling their differences), it significantly increases the precision and purity of the resulting genome bins. It is particularly effective when you have run three or more binning programs and want to consolidate them into a single, more reliable set of MAGs (Metagenome-Assembled Genomes).

## Installation
The tool can be installed via Bioconda or pip:
```bash
# Via Conda
conda install -c bioconda binning_refiner

# Via Pip
pip install Binning_refiner
```

## Command Line Usage
The primary command is `Binning_refiner`. It requires an input directory organized by binning program.

### Basic Syntax
```bash
Binning_refiner -i <input_folder> -p <output_prefix> [options]
```

### Key Arguments
- `-i`: Path to the input folder containing sub-folders for each binning program.
- `-p`: Prefix for all output files and the output directory.
- `-m`: Minimum size (in Kbp) for a refined bin to be kept (default: 512).
- `-plot`: Generate a Sankey plot to visualize the refinement process (requires R packages `optparse` and `googleVis`).
- `-x` / `-y`: Set the width and height of the Sankey plot.

## Input Data Structure
For `binning_refiner` to work correctly, your input directory must follow a specific nested structure. Each binning program's results must reside in its own sub-folder:

```text
input_bin_folder/
├── metabat_bins/
│   ├── bin.1.fa
│   └── bin.2.fa
├── maxbin_bins/
│   ├── bin.001.fasta
│   └── bin.002.fasta
└── concoct_bins/
    ├── 1.fa
    └── 2.fa
```
**Note:** All files within a single sub-folder must share the same file extension.

## Best Practices and Tips
- **Assembly Consistency**: Ensure all input bins were generated from the **exact same assembly file**. The tool identifies contigs by their IDs; if IDs differ between binning runs, the refinement will fail.
- **Program Count**: While the tool supports two programs, using **three or more** typically yields much higher quality refinements as it provides more "votes" for contig placement.
- **Minimum Size**: The default `-m 512` (512 Kbp) is a standard threshold for "medium quality" MAGs. If you are looking for small or viral genomes, you may need to lower this value.
- **Visualization**: Use the `-plot` flag to understand how your initial bins were merged or split. This is highly useful for identifying which binning programs are over-splitting or over-merging your data.
- **R Dependencies**: If using the `-plot` or the R-native version (`Binning_refiner.R`), ensure you have `seqinr`, `assertr`, `tidyr`, and `googleVis` installed in your R environment.

## Reference documentation
- [Binning_refiner GitHub Repository](./references/github_com_songweizhi_Binning_refiner.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_binning_refiner_overview.md)