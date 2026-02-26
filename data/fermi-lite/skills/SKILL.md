---
name: fermi-lite
description: Fermi-lite is an in-memory assembly tool that transforms Illumina short reads into unitigs for targeted genomic reconstruction. Use when user asks to perform local assembly of a specific locus, reconstruct small viral or bacterial genomes, or preserve heterozygous events for accurate variant calling.
homepage: https://github.com/lh3/fermi-lite
---


# fermi-lite

## Overview

Fermi-lite is a specialized assembly tool designed for targeted genomic reconstruction. Unlike large-scale assemblers that generate massive intermediate files, fermi-lite operates entirely in-memory to transform Illumina short reads into unitigs. It is particularly valuable for "local assembly" tasks—such as reconstructing a specific locus or a viral/bacterial genome—where preserving heterozygous events is critical for accurate variant calling.

## Common CLI Patterns

### Basic Assembly
The primary command-line interface is `fml-asm`. It accepts FASTQ input (typically gzipped) and streams the resulting unitigs to standard output.

```bash
fml-asm input_reads.fq.gz > assembly_unitigs.fq
```

### Compiling Custom Tools
If you are integrating the fermi-lite library into a custom C application, use the following compilation pattern to link the necessary math, compression, and threading libraries:

```bash
gcc -Wall -O2 your_prog.c -o your_prog -L/path/to/fermi-lite -lfml -lz -lm -lpthread
```

## Best Practices and Expert Tips

### Scope and Scaling
*   **Target Size**: Limit usage to regions or genomes under 10 million base pairs. For whole-genome assembly of large eukaryotes (e.g., human, maize), use the full FermiKit instead.
*   **Memory Management**: Since fermi-lite is an in-memory assembler, ensure your environment has enough RAM to hold the entire FM-index and overlap graph. It does not write temporary files to disk.

### Data Characteristics
*   **Read Type**: Optimized specifically for Illumina short-read data.
*   **Heterozygosity**: Use fermi-lite when you need to retain heterozygous bubbles in the assembly graph. This makes it superior to "unitig-only" assemblers that collapse all variations into a single consensus.
*   **Error Correction**: The tool performs internal k-mer based error correction before building the FM-index. You generally do not need to pre-process reads with external error correctors.

### Graph Analysis
*   **Output Format**: While the CLI tool outputs sequences, the underlying library represents the assembly as a graph. If you require a Graphical Fragment Assembly (GFA) format to visualize bubbles or overlaps, you must use the library's `fml_utg_print_gfa()` function within a custom C wrapper.

## Reference documentation
- [Bioconda fermi-lite Overview](./references/anaconda_org_channels_bioconda_packages_fermi-lite_overview.md)
- [lh3/fermi-lite GitHub Repository](./references/github_com_lh3_fermi-lite.md)