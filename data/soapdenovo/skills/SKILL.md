---
name: soapdenovo
description: SOAPdenovo is a short-read assembly tool that uses de Bruijn graph algorithms to construct contigs and scaffolds for large-scale genome projects. Use when user asks to perform de novo genome assembly, build reference sequences from Illumina reads, or construct scaffolds from short-read data.
homepage: https://github.com/aquaskyline/SOAPdenovo2
metadata:
  docker_image: "biocontainers/soapdenovo:v240_cv2"
---

# soapdenovo

## Overview
SOAPdenovo2 is a short-read assembly tool optimized for large-scale genome projects. It utilizes a de Bruijn graph algorithm to process Illumina GA reads, offering a balance between assembly quality and computational efficiency. The tool is particularly effective for building reference sequences for unexplored genomes. It operates through a multi-step pipeline—pregraph construction, contig formation, read mapping, and scaffolding—or via a single "all" command that executes the entire workflow.

## Configuration File Setup
The configuration file is mandatory for defining library metadata and file paths. It consists of a global section followed by one or more library `[LIB]` sections.

### Global Section
- `max_rd_len`: Maximum read length. Reads longer than this are truncated.

### Library Section `[LIB]`
- `avg_ins`: Average insert size of the library.
- `reverse_seq`: `0` for forward-reverse (insert < 500bp); `1` for reverse-forward (insert > 2kb).
- `asm_flags`: `1` (contig only), `2` (scaffold only), `3` (both), `4` (gap closure).
- `rank`: Integer determining the order of libraries used during scaffolding (lower ranks first).
- `pair_num_cutoff`: Minimum number of pairs to link two contigs (default 3 for PE, 5 for MP).
- `map_len`: Minimum alignment length for a read to be used in mapping (default 32 for PE, 35 for MP).

### Input Formats
- `q1=`, `q2=`: FASTQ paired-end files.
- `f1=`, `f2=`: FASTA paired-end files.
- `p=`: Single FASTA file with interleaved paired reads.
- `q=`, `f=`: Single-end FASTQ or FASTA files.
- `b=`: BAM alignment files.

## Command Line Usage

### The All-in-One Workflow
For most standard assemblies, use the `all` command:
```bash
SOAPdenovo-64mer all -s project.config -K 63 -R -o output_prefix -p 16
```

### Step-by-Step Execution
Running steps individually allows for fine-tuning and resource management:

1.  **Pregraph**: Build the de Bruijn graph.
    ```bash
    SOAPdenovo-64mer pregraph -s project.config -K 63 -R -o output_prefix
    ```
    *Note: Use `sparse_pregraph` for very large genomes to reduce memory consumption.*

2.  **Contig**: Form contigs from the graph.
    ```bash
    SOAPdenovo-64mer contig -g output_prefix -R
    ```

3.  **Map**: Align reads back to contigs.
    ```bash
    SOAPdenovo-64mer map -s project.config -g output_prefix
    ```

4.  **Scaff**: Link contigs into scaffolds.
    ```bash
    SOAPdenovo-64mer scaff -g output_prefix -F
    ```

## Expert Tips and Best Practices
- **K-mer Selection**: The `-K` parameter is critical. Smaller K-mers provide higher sensitivity for low-coverage regions but increase graph complexity. Larger K-mers resolve repeats better but require higher coverage. Common values range from 23 to 63 (or 127 in the 127-mer version).
- **Memory Management**: For human-sized genomes, expect to need ~150GB of RAM. If memory is a bottleneck, use the `sparse_pregraph` module with the `-z` (genome size assumption) parameter.
- **Repeat Resolution**: Always use the `-R` flag in the `pregraph` and `contig` steps to allow the assembler to use reads to resolve small repeats.
- **Scaffolding Rank**: Assign lower `rank` values to short-insert libraries (PE) and higher `rank` values to long-insert libraries (MP). This ensures the scaffold is built from the most reliable connections first.
- **Handling Errors**: If the program exits during `pregraph` when using compressed files, ensure files are fully decompressed or check for format inconsistencies in the FASTQ headers.

## Reference documentation
- [Manual of SOAPdenovo2](./references/github_com_aquaskyline_SOAPdenovo2.md)
- [Known Issues and Troubleshooting](./references/github_com_aquaskyline_SOAPdenovo2_issues.md)