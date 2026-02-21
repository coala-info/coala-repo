---
name: fastga
description: FastGA is a specialized toolset designed for rapid DNA alignment between two high-quality genomes or a genome against itself.
homepage: https://github.com/thegenemyers/FASTGA
---

# fastga

## Overview

FastGA is a specialized toolset designed for rapid DNA alignment between two high-quality genomes or a genome against itself. It operates on the assumption of high-quality sequence data (Q40 or better) and relatively complete assemblies. The suite utilizes a custom Genome Database (GDB) format and a Genome Index (GIX) to achieve high performance, often completing Gbp-scale comparisons in minutes. It features a space-efficient "trace point" encoding for alignments and supports standard output formats like PAF and PSL through conversion utilities.

## Core Workflow

The standard FastGA pipeline requires three primary steps: database creation, indexing, and alignment.

### 1. Create a Genome Database (GDB)
Convert your FASTA files into the internal GDB format.
```bash
FAtoGDB <database_root> <input.fasta>
```
*Note: If the input FASTA uses lower-case for soft-masking, FAtoGDB automatically creates a corresponding `.1ano` file.*

### 2. Build a Genome Index (GIX)
Generate the index required for the alignment process.
```bash
GIXmake <database_root>
```
*   **Soft Masking**: To apply specific masks during indexing, provide the `.1ano` files: `GIXmake <database_root> <mask1.1ano> <mask2.1ano>`.
*   **Performance**: `GIXmake` is multi-threaded and memory-optimized.

### 3. Run the Aligner
Perform the pairwise alignment between two indexed databases.
```bash
FastGA [options] <genome1.gdb> <genome2.gdb>
```
*   **Self-alignment**: Use the same GDB for both arguments to find internal repeats or duplications.
*   **Soft Masking**: Use the `-M` flag to instruct FastGA to respect the soft masks encoded in the GIX.
*   **Logging**: Use `-L <logfile>` for HPC cluster environments to track progress.

## Utility Commands and Best Practices

### Output Conversion
FastGA produces `.1aln` files by default. Convert these for use with other bioinformatics tools:
*   **PAF**: `ALNtoPAF <file.1aln> > <output.paf>`
*   **PSL**: `ALNtoPSL <file.1aln> > <output.psl>`

### Database Management
Because GDB and GIX structures involve hidden files and multiple components, use the provided utilities instead of standard filesystem commands:
*   **Remove**: `GIXrm <database_root>` (cleans up all hidden parts).
*   **Copy**: `GIXcp <source_root> <dest_root>`.
*   **Move**: `GIXmv <source_root> <dest_root>`.

### Inspection and Visualization
*   **Statistics**: Use `GDBstat <database_root>` to view contig N50, histograms, and scaffold info.
*   **Alignment View**: Use `ALNshow <file.1aln>` to inspect specific alignment records.
*   **Plotting**: Use `ALNplot <file.1aln>` to generate a static collinear plot of the alignments.

### Annotation and Masking (V1.5+)
FastGA uses `.1ano` files (ONEcode version of BED) for intervals.
*   **Convert BED to ANO**: `BEDtoANO <input.bed> <database.gdb> <output.1ano>`
*   **Convert ANO to BED**: `ANOtoBED <input.1ano> > <output.bed>`
*   **Statistics**: `ANOstat <input.1ano>` provides summary statistics of the intervals.

## Expert Tips
*   **Assembly Quality**: FastGA is optimized for "nearly complete" genomes. If working with highly fragmented assemblies (thousands of small contigs), performance may degrade or trigger known boundary condition issues.
*   **Masking Logic**: The only way to change the mask used by the aligner is to rebuild the GIX with the desired `.1ano` files.
*   **Memory Usage**: V1.3+ significantly improved `GIXmake` memory efficiency. If running on older versions, ensure sufficient RAM is available for large genomes.

## Reference documentation
- [FastGA GitHub Repository](./references/github_com_thegenemyers_FASTGA.md)
- [Bioconda FastGA Overview](./references/anaconda_org_channels_bioconda_packages_fastga_overview.md)