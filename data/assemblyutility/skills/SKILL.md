---
name: assemblyutility
description: AssemblyUtility provides high-performance C++ tools for calculating genome assembly metrics and subsetting sequencing reads by length. Use when user asks to calculate assembly statistics like N50, generate genome-size-normalized metrics, or select the longest reads from FASTA and FASTQ files to reach a target base count.
homepage: https://github.com/yechengxi/AssemblyUtility
---


# assemblyutility

## Overview
The AssemblyUtility suite provides high-performance C++ tools for common bioinformatics tasks in genome assembly. It consists of two primary utilities: `AssemblyStatistics` for generating assembly metrics and `SelectLongestReads` for subsetting read data. Use this skill when you need to analyze the continuity of a genome assembly or extract a specific volume of data from long-read sequencing files (FASTA/FASTQ) while prioritizing read length.

## Compilation
The tools are provided as C++ source files and should be compiled with optimization for best performance:

```bash
g++ -o AssemblyStatistics -O3 AssemblyStatistics.cpp
g++ -o SelectLongestReads -O3 SelectLongestReads.cpp
```

## AssemblyStatistics Usage
This tool analyzes contig or scaffold files to provide metrics such as N50, total length, and contig counts.

### Basic Statistics
To get standard metrics for an assembly:
```bash
./AssemblyStatistics contigs YourAssembly.fasta
```

### Statistics with Estimated Genome Size
Providing the estimated genome size (GS) allows the tool to calculate NG50 and other genome-size-normalized metrics:
```bash
./AssemblyStatistics contigs YourAssembly.fasta GS 3000000000
```

## SelectLongestReads Usage
This tool filters sequencing reads to reach a target total base count. It is highly effective for reducing dataset size while maintaining the longest available reads.

### Command Structure
```bash
./SelectLongestReads sum [total_length] longest [0 or 1] o [outfile] f [input1] f [input2] ...
```

### Selection Modes
- **Longest First (Mode 1)**: Selects the longest reads until the `total_length` is reached. This is the preferred method for maximizing assembly potential.
- **First-In (Mode 0)**: Selects reads in the order they appear in the file until the `total_length` is reached.

### Examples
**Select the longest 5GB of reads from a FASTQ file:**
```bash
./SelectLongestReads sum 5000000000 longest 1 o longest_5gb.fq f input.fastq
```

**Combine and subset multiple input files:**
```bash
./SelectLongestReads sum 2000000000 longest 1 o subset.fa f run1.fa f run2.fa f run3.fa
```

## Best Practices
- **Performance**: Always use the `-O3` flag during compilation, as these tools often process multi-gigabyte files where I/O and string processing speed are critical.
- **Memory Management**: `SelectLongestReads` with `longest 1` must load read lengths into memory to sort them. Ensure the system has sufficient RAM for very large datasets (millions of reads).
- **File Formats**: The tools are designed to handle both `.fasta` and `.fastq` formats. Ensure your file extensions match the content to avoid parsing errors.
- **Cumulative Length**: When using `SelectLongestReads`, the `sum` parameter is in bases (e.g., use `5000000` for 5MB).

## Reference documentation
- [AssemblyUtility Main Repository](./references/github_com_yechengxi_AssemblyUtility.md)
- [Compiled Binaries and Source Info](./references/github_com_yechengxi_AssemblyUtility_tree_master_compiled.md)