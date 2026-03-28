---
name: gapless
description: Gapless enhances genomic assemblies by integrating scaffolding, gap filling, and consensus correction using low-coverage long reads. Use when user asks to improve draft assemblies, close gaps in a genome, or perform scaffolding with PacBio or Nanopore reads.
homepage: https://github.com/schmeing/gapless
---

# gapless

## Overview

Gapless is a genomic tool designed to enhance existing assemblies by leveraging low-coverage long reads. Unlike tools that handle scaffolding or gap filling in isolation, gapless integrates these tasks to preserve read information across steps. It is particularly effective for refining draft genomes where high-coverage long reads are unavailable, providing a unified approach to scaffolding, gap closing, and consensus correction.

## Native CLI Usage

The primary way to interact with the tool is through the `gapless.sh` wrapper script, which orchestrates the underlying Python modules and external dependencies (minimap2, racon, seqtk).

### Standard Pipeline Execution

Run the full pipeline using the following syntax:

```bash
gapless.sh -i <assembly.fasta> -t <read_type> <long_reads.fastq>
```

### Read Type Specifications (`-t`)

You must specify the correct read type to ensure `minimap2` uses the appropriate alignment presets:
- `pb_clr`: PacBio Continuous Long Reads
- `pb_hifi`: PacBio HiFi (High Fidelity) reads
- `nanopore`: Oxford Nanopore reads

### Common Options

- `-j [INT]`: Number of threads (default: 4). For human-sized genomes, 30+ threads are recommended.
- `-n [INT]`: Number of iterations (default: 3).
- `-o [STRING]`: Output directory (default: `gapless_run`). The final assembly is linked to `gapless_run/gapless.fa`.
- `-r`: Restart at the start iteration and overwrite existing files instead of incorporating them.
- `-s [INT]`: Start at a specific iteration (useful for resuming interrupted runs).

## Advanced Module Usage

If you need to run specific steps manually or troubleshoot the pipeline, use `gapless.py`.

### 1. Splitting the Assembly
Splits the input assembly at gaps (N's) to prepare for re-scaffolding.
```bash
gapless.py split -n 1 -o assembly_split.fa assembly.fasta
```

### 2. Scaffolding
Requires the split assembly, a mapping of reads to the assembly (PAF format), and a self-mapping of the assembly to identify repeats.
```bash
gapless.py scaffold -p prefix -s stats.pdf assembly_split.fa reads.paf repeats.paf
```
**Expert Tip**: For assemblies longer than 2.1 billion bases, use the `--largeGenome` flag to handle large integer sizes.

### 3. Extension
Extends scaffolds using all-vs-all read mappings.
```bash
gapless.py extend -p prefix all_vs_all_reads.paf
```

### 4. Finishing
Generates the final raw fasta before the final consensus step.
```bash
gapless.py finish -o gapless_raw.fa -s scaffold_paths.csv assembly_split.fa used_reads.fastq
```

## Best Practices

- **Resource Allocation**: A human-sized genome with 30x coverage typically requires approximately 12 hours using 30 threads for the default 3 iterations.
- **Input Formats**: The tool supports both `.fasta` and `.fastq` files, including gzipped versions (`.gz`).
- **Dependency Pathing**: Ensure `minimap2`, `racon`, and `seqtk` are in your system PATH.
- **Memory Management**: If encountering memory issues during the scaffolding step on large genomes, ensure you are using the latest version which includes optimizations for repeat identification.



## Subcommands

| Command | Description |
|---------|-------------|
| gapless.py | Program: gapless Version: 0.4 Contact: https://github.com/schmeing/gapless |
| gapless.sh | Improves input assembly with reads in {long_reads}.fq using gapless, minimap2, racon and seqtk |

## Reference documentation
- [Gapless README](./references/github_com_schmeing_gapless_blob_master_README.md)
- [Gapless Shell Script Reference](./references/github_com_schmeing_gapless_blob_master_gapless.sh.md)