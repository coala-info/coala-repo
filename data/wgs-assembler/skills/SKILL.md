---
name: wgs-assembler
description: The wgs-assembler tool assembles short-read Illumina data, preserving maximum information including heterozygous events. Use when user asks to assemble short reads, assemble paired-end reads, correct sequencing errors, or identify mutations and structural variations.
homepage: https://github.com/lh3/fermi
metadata:
  docker_image: "quay.io/biocontainers/wgs-assembler:8.3--pl5.22.0_0"
---

# wgs-assembler

## Overview
The `fermi` assembler is a specialized tool for processing short-read Illumina data. Unlike many assemblers that focus solely on generating contigs, fermi aims to preserve maximum information from raw reads, including heterozygous events. It follows a workflow similar to SGA (String Graph Assembler) but uses a unique FMD-index for a smaller memory footprint. This skill provides the necessary command-line patterns for standard assembly, error correction, and the "contrast assembly" method used to identify mutations and breakpoints between two different read sets.

## Installation and Setup
Fermi requires `zlib` for compilation.
1. Clone the repository or download the source.
2. Run `make` in the source directory.
3. The primary executables are the `fermi` binary and the `run-fermi.pl` wrapper script.

## Standard Assembly Workflow
The recommended way to run fermi is via the `run-fermi.pl` script, which generates a Makefile to manage the multi-step assembly process.

### Basic Assembly (Single-end)
```bash
# Generate the Makefile
run-fermi.pl -ct8 -e ./fermi reads.fastq > fmdef.mak

# Execute the assembly using 8 cores
make -f fmdef.mak -j 8
```

### Paired-end Assembly
Use the `-P` flag for paired-end reads.
```bash
run-fermi.pl -Pe ./fermi -t12 read1.fq.gz read2.fq.gz > fmdef.mak
make -f fmdef.mak -j 12
```
*   **Output**: The final contigs are stored in `fmdef.p5.fq.gz`.
*   **Quality Scores**: In the output FASTQ, the quality line represents per-base read depth from non-redundant error-corrected reads.

## Error Correction Only
If you only need to correct sequencing errors without performing a full assembly:
```bash
run-fermi.pl -ct12 -p sample_prefix reads.fq.gz > sample.mak
make -f sample.mak -j 12 sample_prefix.ec.fq.gz
```

## Contrast Assembly (Variant Discovery)
Contrast assembly identifies k-mers present in one sample but absent in another to pinpoint mutations or structural variations.

1.  **Generate indices for both samples**:
    ```bash
    # For Sample 1
    run-fermi.pl -ct12 -p s1 s1.fq.gz > s1.mak
    make -f s1.mak -j 12 s1.ec.rank

    # For Sample 2
    run-fermi.pl -ct12 -p s2 s2.fq.gz > s2.mak
    make -f s2.mak -j 12 s2.ec.rank
    ```

2.  **Identify unique reads**:
    ```bash
    fermi contrast -t12 s1.ec.fmd s1.ec.rank s1.sub s2.ec.fmd s2.ec.rank s2.sub
    ```

3.  **Extract and assemble unique reads**:
    ```bash
    # Extract FMD-index for unique reads
    fermi sub -t12 s1.fmd s1.sub > s1.sub.fmd

    # Assemble and clean the graph
    fermi unitig -l50 -t12 s1.sub.fmd > s1.sub.mag
    fermi clean -CA -l150 s1.sub.mag > s1_cleaned.sub.mag
    ```

## Expert Tips
*   **Memory Footprint**: Fermi can assemble a 35-fold human genome in approximately 90GB of RAM, making it suitable for high-memory nodes that are not necessarily "super-computers."
*   **Heterozygosity**: Because fermi preserves heterozygous events, it is superior for SNP and INDEL calling via unitig alignment compared to standard mapping-based approaches.
*   **Cleaning Parameters**: The `fermi clean` command with `-CA` is essential for simplifying the assembly graph by removing bubbles and small overlaps.

## Reference documentation
- [Fermi GitHub Repository Overview](./references/github_com_lh3_fermi.md)