---
name: isonform
description: isONform reconstructs transcript isoforms from long-read sequencing data without requiring a reference genome. Use when user asks to reconstruct transcript isoforms, generate consensus sequences from clustered reads, or perform de novo transcriptome assembly.
homepage: https://github.com/aljpetri/isONform
---


# isonform

## Overview

isONform is a specialized tool for reconstructing transcript isoforms directly from long-read sequencing data without the need for a reference genome. It operates by building a graph from clustered and corrected reads, applying simplification algorithms such as bubble popping and node merging to resolve complex transcript structures, and utilizing the SPOA (Simulated Partial Order Alignment) library to generate final consensus sequences. This skill is essential when working with non-model organisms or samples where a high-quality reference transcriptome is unavailable.

## Installation and Environment

The tool can be installed via Conda or Pip. It requires Python 3.7 or higher.

```bash
# Recommended installation via Bioconda
conda install bioconda::isonform

# Alternative installation via Pip
pip install isONform
```

## Input Requirements

Before running isONform, ensure your data meets the following criteria:
- **Format**: .fastq files.
- **Preprocessing**: Reads must be cleaned of barcodes. Use **LIMA** for PacBio data or **Pychopper** for Oxford Nanopore (ONT) data.
- **Upstream Pipeline**: Data should ideally be clustered (e.g., via isONclust) and error-corrected (e.g., via isONcorrect) before isoform reconstruction.

## Command Line Usage

### Standalone Isoform Reconstruction
Use `isONform_parallel` to process a folder of clustered/corrected reads.

```bash
isONform_parallel --fastq_folder /absolute/path/to/input --t <nr_cores> --outfolder /absolute/path/to/output --split_wrt_batches
```

**Key Parameters:**
- `--fastq_folder`: Path to the directory containing input FASTQ files.
- `--t`: Number of CPU cores to utilize.
- `--outfolder`: Destination for output files.
- `--split_wrt_batches`: Processes data in batches (typically 1000 reads) to manage memory and complexity.

### Full Pipeline Execution
If you have raw reads and need to run the entire isON-pipeline (Clustering -> Correction -> Reconstruction):

```bash
./isON_pipeline.sh --raw_reads /path/to/raw.fq --outfolder /path/to/out --num_cores 16 --isONform_folder /path/to/isonform_src --iso_abundance 2 --mode default
```

## Output Interpretation

isONform generates three primary files in the specified output folder:

1.  **transcriptome.fasta**: The reconstructed isoform sequences.
    - **ID Format**: `x_y_z`
    - `x`: The original isONclust cluster ID.
    - `y`: The batch ID (if processed in batches).
    - `z`: A unique identifier for the specific isoform.
2.  **mapping.txt**: A record indicating which original reads contributed to each reconstructed isoform.
3.  **support.txt**: Provides the "support" count (number of original reads) for each isoform.

## Expert Tips and Best Practices

- **Absolute Paths**: Always use absolute paths for input folders and output directories to avoid execution errors within the parallel processing scripts.
- **Memory Management**: If processing very large clusters, ensure `--split_wrt_batches` is enabled to prevent the graph construction from consuming excessive RAM.
- **Abundance Filtering**: When running the full pipeline, use `--iso_abundance` to filter out low-confidence isoforms that lack sufficient read support.
- **Output Format**: By default, isONform outputs FASTA. If FASTQ is required for downstream quality-aware tools, use the `--write_fastq` flag.

## Reference documentation
- [isONform GitHub Repository](./references/github_com_aljpetri_isONform.md)
- [Bioconda isONform Overview](./references/anaconda_org_channels_bioconda_packages_isonform_overview.md)