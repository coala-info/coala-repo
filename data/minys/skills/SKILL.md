---
name: minys
description: MinYS is a bioinformatics pipeline that reconstructs target genomes from metagenomic samples using a reference-guided assembly approach. Use when user asks to assemble symbiont genomes, perform reference-guided metagenomic assembly, or fill gaps between contigs using sequencing reads.
homepage: https://github.com/cguyomar/MinYS
---


# minys

## Overview
MinYS (MineYourSymbiont) is a specialized bioinformatics pipeline for reconstructing target genomes from metagenomic samples using a reference-guided approach. It automates a multi-step workflow involving read mapping (BWA), contig assembly (Minia), gap-filling (MindTheGap), and graph simplification. This tool is particularly effective for extracting and assembling symbiont genomes or specific bacterial targets where a related reference genome is available to guide the recruitment of reads.

## Command Line Usage

### Basic Execution
The primary entry point is `MinYS.py`. A standard run requires paired-end reads and a reference genome.

```bash
MinYS.py -1 reads.1.fq -2 reads.2.fq -ref reference.fa -out results_dir
```

### Input Variations
- **Paired-end files**: Use `-1` and `-2`.
- **Single file**: Use `-in`.
- **Batch processing**: Use `-fof` (File of Files). For paired data, the file should contain two tab-separated columns.

### Workflow Control and Optimization
- **Parallelization**: Use `-nb-cores` to specify the number of CPU threads.
- **Bypassing Steps**: 
  - If you already have contigs: `-contigs <file.fa>`. Note: You must also provide `-assembly-kmer-size` to define the overlap.
  - If you already have a graph: `-graph <file.h5>`.
- **Memory/Storage**: If running on a Lustre filesystem, prevent HDF5 locking errors by setting the environment variable:
  `export HDF5_USE_FILE_LOCKING='FALSE'`

## Parameter Tuning

### Assembly and Gap-filling
- **K-mer Size**: Controlled by `-assembly-kmer-size` and `-gapfilling-kmer-size` (Default: 31). These should be adjusted based on read length and complexity.
- **Abundance Threshold**: `-assembly-abundance-min` and `-gapfilling-abundance-min` default to `auto`, but can be set manually to filter out low-frequency sequencing errors.
- **Contig Filtering**: Use `-min-contig-size` (Default: 400) to ignore small, potentially chimeric contigs during the gap-filling stage.

### Graph Simplification
- **Node Merging**: The `-l` parameter (Default: 100) defines the minimum prefix length for merging nodes in the assembly graph.
- **Gap Limits**: `-max-length` (Default: 50000) sets the maximum allowed distance for gap-filling between contigs.

## Post-Processing Utilities
MinYS includes scripts in the `graph_simplification/` directory to handle the GFA output:

- **Convert to FASTA**: `gfa2fasta.py in.gfa out.fa`
- **Filter by Size**: `filter_components.py in.gfa min_size` (returns components larger than the specified total nucleotide count).
- **Path Enumeration**: `enumerate_paths.py in.gfa out_dir` (extracts distinct genomic paths from the graph based on ANI and coverage).

## Reference documentation
- [MinYS GitHub Repository](./references/github_com_cguyomar_MinYS.md)
- [Bioconda MinYS Overview](./references/anaconda_org_channels_bioconda_packages_minys_overview.md)