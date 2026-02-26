---
name: greenhill
description: "GreenHill scaffolds and phases contigs into chromosome-scale haplotypes using Hi-C data and optional sequencing reads. Use when user asks to scaffold contigs into chromosome-scale assemblies, phase diploid genomes, or integrate Hi-C data with haplotype-aware assemblies."
homepage: https://github.com/ShunOuchi/GreenHill
---


# greenhill

## Overview
GreenHill is a specialized bioinformatics tool for scaffolding and phasing contigs into chromosome-scale haplotypes. It leverages Hi-C contact information alongside optional short-read (PE/MP) and long-read data to produce phased diploid assemblies. It is particularly effective when starting from haplotype-aware assemblies (like those from Platanus-allee) but also supports pseudo-haplotype and mixed-haplotype inputs from tools like FALCON-Unzip or Canu.

## Command Line Usage

### Core Input Styles
GreenHill requires different flags based on the nature of your input assembly:

1.  **Haplotype-aware (e.g., Platanus-allee)**:
    Use `-c` for non-bubble contigs and `-b` for primary/secondary bubble sequences.
    ```bash
    greenhill -c nonBubble.fa -b primaryBubble.fa secondaryBubble.fa -HIC hic_1.fq hic_2.fq
    ```

2.  **Pseudo-haplotype or Mixed-haplotype (e.g., FALCON-Unzip, Canu)**:
    Use `-cph` for the contig/scaffold files.
    ```bash
    greenhill -cph contigs.fa -HIC hic_1.fq hic_2.fq
    ```

### Read Input Flags
*   **Hi-C (Required)**: `-HIC FWD REV` (separate files) or `-hic PAIR` (interleaved).
*   **Short Reads (Optional)**: 
    *   Inward Pairs (PE): `-IP{ID} FWD REV`
    *   Outward Pairs (MP): `-OP{ID} FWD REV`
*   **Long Reads (Optional)**: `-p READS.fq` (supports PacBio/Nanopore).

### Common Options
*   `-o STR`: Set the output prefix (default is `out`).
*   `-t INT`: Set the number of threads (default is 1).
*   `-tmp DIR`: Specify a directory for temporary files (useful for large datasets).
*   `-l INT`: Minimum number of links required to scaffold (default 3).
*   `-k INT`: Minimum number of links to phase variants (default 1).

## Expert Tips and Best Practices

*   **Input Compression**: GreenHill natively accepts gzipped (`.gz`) or bzipped (`.bz2`) fasta/fastq files, saving significant disk space.
*   **Mapper Selection**: If using long reads (`-p`), GreenHill defaults to `minimap2`. Ensure `minimap2` is in your PATH. You can use the `-minimap2_sensitive` flag to improve mapping at the cost of runtime.
*   **Memory Management**: For large genomes, always specify a `-tmp` directory on a high-speed disk (like an SSD or NVMe) to prevent bottlenecks during the scaffolding process.
*   **Juicebox Integration**: The final output `out_afterPhase.fa` can be manually curated. Use the `fasta_to_juicebox_assembly.py` script found in the GreenHill `utils` directory to generate the necessary `.assembly` files for Juicebox Assembly Tool (JBAT).
*   **Logging**: Always redirect stderr to a log file (`2> greenhill.log`) to monitor the phasing progress and identify potential mapping issues.

## Reference documentation
- [GreenHill GitHub Repository](./references/github_com_ShunOuchi_GreenHill.md)
- [Bioconda GreenHill Overview](./references/anaconda_org_channels_bioconda_packages_greenhill_overview.md)