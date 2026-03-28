---
name: fastga
description: FastGA is a high-performance toolset for aligning genomes using a specialized database format. Use when user asks to convert FASTA files to GDB format, index genomes, perform sequence alignments, or convert alignment results to PAF and PSL formats.
homepage: https://github.com/thegenemyers/FASTGA
---


# fastga

## Overview
FastGA is a high-performance genome alignment toolset designed by Gene Myers and Chenxi Zhou. It operates on a specialized "Genome Database" (GDB) format rather than raw FASTA files to achieve superior speed. The workflow typically involves converting sequences to GDB, indexing them, performing the alignment, and then using various utilities to process or visualize the resulting alignment files.

## Core Workflow

### 1. Data Preparation (FAtoGDB)
Before aligning, you must convert your FASTA files into the GDB format.
```bash
FAtoGDB <genome:path>[.fa|.fna|.fasta][.gz] <database:path>[.1gdb]
```

### 2. Indexing (GIXmake)
Create a Genome Index (GIX) for the target database to enable fast lookups.
```bash
GIXmake <database:path>[.1gdb]
```

### 3. Alignment (FastGA)
Compare a query genome against a target genome.
```bash
FastGA [options] <target:path>[.1gdb] <query:path>[.1gdb]
```
*Common Options:*
- `-o<path>`: Specify output file (defaults to `.1aln`).
- `-T<int>`: Set number of threads.
- `-k<int>`: Set k-mer size for the seed match.

### 4. Processing Results
FastGA provides several utilities to handle the `.1aln` output:

**Visualization and Inspection:**
- `ALNshow`: Display alignments in a human-readable format.
  ```bash
  ALNshow -a <alignments:path>[.1aln]
  ```
- `ALNplot`: Generate dot-plots of the alignments.
- `GDBstat`: Provide statistics about the genome database.

**Format Conversion:**
- `ALNtoPAF`: Convert `.1aln` to Pairwise Mapping Format (PAF).
- `ALNtoPSL`: Convert `.1aln` to Pattern Space Layout (PSL).

**Maintenance:**
- `ALNreset`: Update or change the database names in the header of a `.1aln` file. Useful if GDB files have been moved or renamed.
  ```bash
  ALNreset <alignments:path>[.1aln] <new_source1> [<new_source2>]
  ```

## Expert Tips
- **Self-Alignment**: To find repeats or segmental duplications within a single genome, run `FastGA` with the same GDB path for both target and query.
- **Memory Management**: For very large genomes, ensure you have sufficient disk space for the GIX index, which can be significantly larger than the input FASTA.
- **Thread Scaling**: Use the `-T` flag in `FastGA` and `ALNreset` to match your CPU core count for maximum throughput.



## Subcommands

| Command | Description |
|---------|-------------|
| ALNplot | Plots alignments from various formats. |
| ALNshow | Show alignments |
| ALNtoPAF | Convert ALN alignment files to PAF format. |
| ALNtoPSL | Convert alignment file to PSL format. |
| FAtoGDB | Converts FASTA files to a 1GDB database. |
| FastGA | FastGA is a tool for aligning sequences. |
| GDBstat | Display histograms of scaffold & contig lengths. |
| GIXcp | Copies GIX database files, with options for verbosity, prompting, and overwriting. |
| GIXmake | Builds a GIX index for a given source file. |
| GIXmv | Move or rename GIX database files. |
| GIXrm | Deletes GIX index files and optionally associated GDB files. |

## Reference documentation
- [FastGA Repository Overview](./references/github_com_thegenemyers_FASTGA.md)
- [ALNshow Utility Details](./references/github_com_thegenemyers_FASTGA_blob_main_ALNshow.c.md)
- [ALNreset Utility Details](./references/github_com_thegenemyers_FASTGA_blob_main_ALNreset.c.md)
- [FAtoGDB Conversion](./references/github_com_thegenemyers_FASTGA_blob_main_FAtoGDB.c.md)