---
name: piscem
description: piscem is a high-efficiency tool for indexing reference genomes and mapping sequencing data using a compacted colored de Bruijn graph. Use when user asks to construct indices from FASTA files, perform rapid read alignment for bulk transcriptomics, or process single-cell RNA-seq data.
homepage: https://github.com/COMBINE-lab/piscem
---


# piscem

## Overview

piscem is a high-efficiency tool designed for indexing reference genomes and mapping sequencing data using a compacted colored de Bruijn graph (cDBG) structure. It serves as a faster, next-generation successor to traditional k-mer based mappers. Use this skill to construct indices from FASTA files and to perform rapid read alignment for both bulk and single-cell transcriptomics.

## System Configuration

Before running piscem, ensure your environment is configured to handle the high number of intermediate files generated during the k-mer enumeration phase.

*   **File Handle Limit**: Increase the shell's open file limit to at least 2048 to prevent "too many open files" errors.
    ```bash
    ulimit -n 2048
    ```
*   **Hardware Requirements**: Pre-compiled binaries (including Bioconda versions) require a CPU with **BMI2** instruction set support (Intel Haswell/AMD Excavator or newer). If running on older hardware, you must compile from source using `NO_BMI2=TRUE`.

## Indexing (piscem build)

The `build` command creates a searchable index from one or more reference FASTA files.

### Basic Syntax
```bash
piscem build -k <klen> -m <mlen> -t <threads> -o <output_stem> -s <ref_fasta>
```

### Key Parameters
*   `-k, --klen`: The k-mer size for the cDBG.
*   `-m, --mlen`: The minimizer length used for the underlying sshash data structure.
*   `-t, --threads`: Number of threads. **Expert Tip**: For the indexing call, use a power-of-two number of threads (e.g., 8, 16, 32) to ensure optimal performance and compatibility.
*   `-o, --output`: The prefix/stem for the generated index files.

### Input Methods
*   **Single/Multiple Files**: `-s ref1.fa,ref2.fa` (comma-separated).
*   **List File**: `-l refs.txt` (a file containing paths to FASTA files).
*   **Directory**: `-d /path/to/fastas/` (indexes all FASTA files in the directory).

## Mapping (map-sc and map-bulk)

Once an index is built, use the mapping subcommands to align reads.

*   **map-sc**: Optimized for single-cell RNA-seq processing, handling cell barcodes and UMIs.
*   **map-bulk**: Optimized for standard bulk RNA-seq datasets.

## Best Practices and Expert Tips

*   **Memory Management**: During the `build` phase, piscem uses KMC3 for k-mer counting. If you are constrained by disk space in your current directory, use the `-w, --work-dir` flag to point to a high-speed temporary storage location.
*   **Index Persistence**: By default, piscem removes intermediate GFA files. If you need to inspect the graph structure later, use the `--keep-intermediate-dbg` flag.
*   **Quiet Mode**: Use `-q, --quiet` to reduce stderr output, though note this currently primarily affects the sshash indexing phase rather than the initial cDBG construction.
*   **Overwriting**: If you need to re-run an index build into the same directory, you must explicitly provide the `--overwrite` flag.

## Reference documentation
- [piscem GitHub Repository](./references/github_com_COMBINE-lab_piscem.md)
- [piscem Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_piscem_overview.md)