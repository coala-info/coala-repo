---
name: soapdenovo2
description: SOAPdenovo2 is a powerful de novo assembler designed to handle large-scale genomic data using short reads.
homepage: https://github.com/aquaskyline/SOAPdenovo2
---

# soapdenovo2

## Overview

SOAPdenovo2 is a powerful de novo assembler designed to handle large-scale genomic data using short reads. It utilizes a de Bruijn graph-based approach to construct draft assemblies. The tool is highly modular, allowing users to run the entire process in a single command or execute individual steps (pregraph, contig, map, and scaffold) to fine-tune the assembly. It is particularly well-suited for human-sized genomes but demands significant computational resources, often requiring 150 GB of RAM or more for large projects.

## Configuration File Construction

SOAPdenovo2 requires a configuration file to define sequencing libraries and global parameters.

### Global Section
*   `max_rd_len`: Maximum read length. Reads longer than this will be trimmed.

### Library Section ([LIB])
Each library starts with a `[LIB]` tag and can include:
*   `avg_ins`: Average insert size of the library.
*   `reverse_seq`: Set to `0` for forward-reverse (PE < 500bp) or `1` for reverse-forward (MP > 2kb).
*   `asm_flags`: 
    *   `1`: Only contig assembly.
    *   `2`: Only scaffold assembly.
    *   `3`: Both contig and scaffold (default).
    *   `4`: Only gap closure.
*   `rank`: Integer determining the order libraries are used during scaffolding (lower ranks used first).
*   `pair_num_cutoff`: Minimum number of pairs to connect two contigs (default 3 for PE, 5 for MP).
*   `map_len`: Minimum alignment length for a read to be used in the "map" step (default 32 for PE, 35 for MP).

### Input File Indicators
*   `q1=`, `q2=`: Paired-end FASTQ files.
*   `f1=`, `f2=`: Paired-end FASTA files.
*   `q=`, `f=`: Single-end FASTQ/FASTA files.
*   `p=`: Single FASTA file with interleaved paired reads.
*   `b=`: BAM alignment file.

## Command Line Usage

### All-in-One Execution
For most standard runs, use the `all` command:
`SOAPdenovo-64mer all -s config_file -K 63 -R -o graph_prefix`

### Step-by-Step Execution
Use this approach to troubleshoot or adjust parameters between stages:

1.  **Pregraph**: Build the de Bruijn graph.
    `SOAPdenovo-64mer pregraph -s config_file -K 63 -R -o graph_prefix`
    *Note: Use `sparse_pregraph` for extremely large genomes to save memory.*
2.  **Contig**: Form contigs from the graph.
    `SOAPdenovo-64mer contig -g graph_prefix -R`
3.  **Map**: Map reads back to contigs for connectivity.
    `SOAPdenovo-64mer map -s config_file -g graph_prefix`
4.  **Scaffold**: Build scaffolds using paired-end information.
    `SOAPdenovo-64mer scaff -g graph_prefix -F`

## Expert Tips and Best Practices

*   **K-mer Selection**: The `-K` parameter is critical. Smaller k-mers provide higher sensitivity for low-coverage regions but increase graph complexity. Larger k-mers resolve repeats better but require higher coverage. Always use an odd number (max 63 or 127 depending on the binary version).
*   **Memory Management**: Use the `-a` flag to initialize memory assumption (in GB) to prevent frequent reallocations during the pregraph step.
*   **Repeat Resolution**: Always include the `-R` flag to resolve repeats using read information, which significantly improves contig N50.
*   **Data Quality**: If using BAM files, SOAPdenovo2 automatically ignores reads that fail platform/vendor quality checks (flag 0x0200).
*   **Metagenomics**: For metagenomic or single-cell data, consider using MEGAHIT for contig generation, then use `SOAPdenovo-fusion` to prepare files for the SOAPdenovo2 `map` and `scaff` modules.

## Reference documentation
- [Manual of SOAPdenovo2](./references/github_com_aquaskyline_SOAPdenovo2.md)