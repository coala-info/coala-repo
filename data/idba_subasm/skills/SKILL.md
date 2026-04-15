---
name: idba_subasm
description: idba_subasm is a specialized assembler designed for the local reconstruction of genomic regions during the subassembly phase of metagenomic read cloud analysis. Use when user asks to perform subassembly of linked-read data, reconstruct local genomic regions from seed contigs, or assemble interleaved FASTA reads into connected components.
homepage: https://github.com/abishara/idba
metadata:
  docker_image: "biocontainers/idba:v1.1.3-3-deb_cv1"
---

# idba_subasm

## Overview

idba_subasm is a specialized fork of the Iterative De Bruijn Graph Assembler (IDBA) designed specifically for the subassembly phase of metagenomic read cloud assembly. While standard IDBA-UD is a general-purpose metagenomic assembler, idba_subasm includes modifications to map seed contigs back to reads and retain only those within specific connected components. This targeted approach allows for the local reconstruction of genomic regions, effectively leveraging the long-range information provided by linked-reads (such as 10x Genomics data) to resolve complex structures that standard assemblers might fragment.

## Preprocessing and Data Requirements

IDBA family tools, including idba_subasm, have specific input requirements that differ from many modern assemblers.

### FASTA Conversion
The tool accepts reads in FASTA format. If you have FASTQ files, you must convert them using the included `fq2fa` utility.

```bash
# Convert a single FASTQ file to FASTA
fq2fa read.fq read.fa

# Convert and filter low-quality reads
fq2fa --filter read.fq read.fa
```

### Paired-End Interleaving
idba_subasm requires paired-end reads to be stored in a single FASTA file where pairs appear in consecutive lines.

```bash
# Merge two separate FASTQ files (R1 and R2) into one interleaved FASTA
fq2fa --merge --filter read_1.fq read_2.fq interleaved_reads.fa
```

## Common CLI Patterns

### Basic Subassembly
The primary use case involves providing the interleaved FASTA file and specifying an output directory.

```bash
idba_subasm -r interleaved_reads.fa -o output_directory
```

### Handling Longer Reads
Unlike the original IDBA which was optimized for ~100bp reads, this fork (v1.1.3a2) has been modified to support longer reads, such as those from Illumina MiSeq.
*   **Max Read Length**: Supports up to 500bp.
*   **Orientation**: Assumes standard paired-end orientation (forward-reverse: `->, <-`). If your library uses a different orientation, you must manually reverse-complement one of the reads before assembly.

## Expert Tips and Best Practices

*   **Iterative K-mer Strategy**: idba_subasm iterates through multiple k-mer sizes. If the assembly is failing to resolve specific regions, consider adjusting the minimum and maximum k-mer sizes (typically via `-mink` and `-maxk` flags if available in the specific binary build) to better suit your read length and error profile.
*   **Memory Considerations**: IDBA-based tools are memory-intensive because they maintain the De Bruijn graph in RAM. Ensure your environment has sufficient memory, especially when dealing with high-diversity metagenomic subsets.
*   **Seed Contig Mapping**: The "subasm" modification specifically targets connected components. If you are using this outside of the Athena pipeline, ensure your input reads are pre-partitioned or "cloud-aware" to see the benefits of the subassembly logic.
*   **Docker Fallback**: If you encounter "bus errors" on macOS or specific Linux distributions, use the official Docker container to ensure environment compatibility:
    `docker run -v $(pwd):/data -w /data loneknightpy/idba idba_subasm -r reads.fa -o output`

## Reference documentation
- [idba_subasm - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_idba_subasm_overview.md)
- [GitHub - abishara/idba: Community Fork of IDBA](./references/github_com_abishara_idba.md)
- [idba/tags at master · abishara/idba](./references/github_com_abishara_idba_tags.md)