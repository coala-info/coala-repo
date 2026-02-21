---
name: sigprofilermatrixgenerator
description: SigProfilerMatrixGenerator is a high-performance tool designed to transform raw somatic mutation calls into structured matrices required for mutational signature extraction.
homepage: https://github.com/AlexandrovLab/SigProfilerMatrixGenerator.git
---

# sigprofilermatrixgenerator

## Overview
SigProfilerMatrixGenerator is a high-performance tool designed to transform raw somatic mutation calls into structured matrices required for mutational signature extraction. It supports multiple reference genomes and provides automated classification of Single Base Substitutions (SBS), Doublet Base Substitutions (DBS), and Small Insertions and Deletions (ID). Use this skill when you need to prepare genomic data for signature analysis, perform transcriptional strand bias tests, or visualize mutational profiles.

## Quick Start & Installation
The tool requires Python 3.8+ and approximately 3GB of storage per reference genome.

```bash
# Install via pip
pip install SigProfilerMatrixGenerator

# Install via Conda
conda install bioconda::sigprofilermatrixgenerator
```

## Reference Genome Management
Before generating matrices, you must install the relevant reference genome. This only needs to be done once per assembly.

**CLI Method:**
```bash
SigProfilerMatrixGenerator install <genome_name>
# Supported: GRCh37, GRCh38, mm10, mm9, rn6, c_elegans, dog, ebv, yeast
```

**Python Method:**
```python
from SigProfilerMatrixGenerator import install as genInstall
genInstall.install('GRCh37', rsync=False, bash=True)
```

## Matrix Generation
Place your input files (VCF, MAF, or text) in a dedicated input folder. Each sample must be a separate file if using VCF format.

### Command Line Interface (CLI)
```bash
SigProfilerMatrixGenerator matrix_generator <project_name> <reference_genome> <path_to_input_files>
```

### Python Interface
```python
from SigProfilerMatrixGenerator.scripts import SigProfilerMatrixGeneratorFunc as matGen

matrices = matGen.SigProfilerMatrixGeneratorFunc(
    "my_project", 
    "GRCh37", 
    "/path/to/input/files",
    plot=True,          # Generate PDF visualizations
    exome=False,        # Set True for exome-only analysis
    bed_file=None,      # Path to custom BED file for targeted regions
    tsb_stat=True,      # Perform transcriptional strand bias test
    seqInfo=True        # Output classification for every mutation
)
```

## Expert Tips & Best Practices
- **Input Organization**: The tool creates an `input`, `output`, and `logs` directory within your project path. Ensure the input directory contains only the mutation files you wish to process.
- **Custom Regions**: When using a `bed_file`, ensure it has a header. You can use the `cushion` parameter (default 100bp) to include mutations flanking your BED regions.
- **Memory & Storage**: If working behind a firewall, use `rsync=True` during genome installation. Ensure sufficient disk space for the FASTA files of the chromosomes.
- **Visualization**: Setting `plot=True` integrates with SigProfilerPlotting. This is highly recommended for a first-pass quality check of the mutational profiles.
- **Large Datasets**: For massive cohorts, use `chrom_based=True` to output matrices partitioned by chromosome, which can help manage memory overhead in downstream steps.

## Reference documentation
- [SigProfilerMatrixGenerator GitHub Repository](./references/github_com_SigProfilerSuite_SigProfilerMatrixGenerator.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_sigprofilermatrixgenerator_overview.md)