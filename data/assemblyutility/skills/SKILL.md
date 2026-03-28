---
name: assemblyutility
description: The assemblyutility suite provides high-performance tools for calculating genome assembly statistics and downsampling sequencing data by read length. Use when user asks to generate assembly metrics like N50, estimate genome size statistics, or select the longest reads from sequencing files for assembly preparation.
homepage: https://github.com/yechengxi/AssemblyUtility
---


# assemblyutility

## Overview
The assemblyutility suite provides high-performance C++ tools for common post-assembly and pre-assembly bioinformatics tasks. It consists of two primary modules: `AssemblyStatistics` for evaluating the contiguity of genome assemblies and `SelectLongestReads` for downsampling sequencing data based on length. Use these tools when you need to generate standard assembly metrics or prepare a subset of long-read data (like Oxford Nanopore or PacBio) for assembly.

## Assembly Statistics
Use `AssemblyStatistics` to analyze FASTA files containing contigs or scaffolds.

### Basic Usage
Calculate standard metrics for an assembly:
`./AssemblyStatistics contigs YourAssembly.fasta`

### Advanced Options
*   **Genome Size Estimation**: Provide the estimated genome size to calculate NG50 (instead of N50 based on assembly size).
    `./AssemblyStatistics contigs YourAssembly.fasta GS 3000000000`
*   **Length Threshold**: Set a minimum length cutoff for contigs to be included in the statistics (default is 100bp).
    `./AssemblyStatistics contigs YourAssembly.fasta LenTh 500`

### Output Files
The tool generates two text files in the same directory as the input:
1.  `[input]Stats.txt`: Contains N10 through N90 metrics, total length, and the longest contig size.
2.  `[input]Stats_10k_5k_1k.txt`: Contains counts and cumulative lengths for contigs exceeding 10kb, 5kb, 1kb, and 100bp, along with average contig size.

## Read Selection
Use `SelectLongestReads` to extract a specific volume of data from FASTA or FASTQ files.

### Command Structure
`./SelectLongestReads sum [total_length] longest [0 or 1] o [outfile] f [input1] f [input2] ...`

### Parameters
*   **sum**: The target total number of bases to select (e.g., for 30x coverage of a 1GB genome, use 30000000000).
*   **longest**: 
    *   `1`: Select the longest available reads until the `sum` is reached (recommended for assembly).
    *   `0`: Select reads in the order they appear in the file until the `sum` is reached.
*   **o**: Path to the output FASTA file.
*   **f**: Path to input files. You can specify multiple input files by repeating the `f` flag.

### Example: Selecting 5GB of the longest reads
`./SelectLongestReads sum 5000000000 longest 1 o selected_long_reads.fasta f raw_reads_1.fastq f raw_reads_2.fastq`

## Compilation
If the binaries are not present, compile the source files using g++ with optimization:
`g++ -o AssemblyStatistics -O3 AssemblyStatistics.cpp`
`g++ -o SelectLongestReads -O3 SelectLongestReads.cpp`

## Expert Tips
*   **Input Formats**: `SelectLongestReads` automatically detects FASTA vs FASTQ based on the first character (`>` or `@`), but it typically outputs in FASTA format.
*   **Memory Efficiency**: When using `longest 1`, the tool must load read lengths into memory to sort them. For extremely large datasets, ensure sufficient RAM is available.
*   **N-stats**: Note that `AssemblyStatistics` calculates N-stats by sorting contigs in descending order and finding the length at which the cumulative sum reaches X% of the total (or Genome Size if GS is provided).



## Subcommands

| Command | Description |
|---------|-------------|
| assemblyutility_SelectLongestReads | A tool to select the longest reads from FASTA/FASTQ files until a specified total length is reached. |
| contigs | A tool to calculate assembly statistics for a given contigs file with a specified length cutoff. |

## Reference documentation
- [README.md](./references/github_com_yechengxi_AssemblyUtility_blob_master_README.md)
- [AssemblyStatistics Source](./references/github_com_yechengxi_AssemblyUtility_blob_master_AssemblyStatistics.cpp.md)
- [SelectLongestReads Source](./references/github_com_yechengxi_AssemblyUtility_blob_master_SelectLongestReads.cpp.md)