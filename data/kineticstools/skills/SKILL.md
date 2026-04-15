---
name: kineticstools
description: kineticstools identifies epigenetic modifications in PacBio SMRT sequencing data by analyzing inter-pulse duration deviations. Use when user asks to identify methylated bases, perform bacterial methylome profiling, or estimate methylated fractions from subread BAM files.
homepage: https://github.com/PacificBiosciences/kineticsTools
metadata:
  docker_image: "biocontainers/kineticstools:v0.6.120161222-1-deb-py2_cv1"
---

# kineticstools

## Overview
`kineticstools` is a specialized bioinformatic suite designed to process Pacific Biosciences (PacBio) SMRT sequencing data to identify epigenetic modifications. It works by analyzing the timing between base incorporations—known as Inter-Pulse Duration (IPD). By comparing observed IPDs to a known baseline (either a control sample or an in-silico model), the tool detects deviations that signify the presence of methylated bases. It is the underlying engine for the `ipdSummary` tool used in bacterial methylome profiling.

## Common CLI Patterns

The primary interface for this suite is the `ipdSummary` command.

### Basic Modification Detection
To identify standard modifications (m6A and m4C) across a genome:
```bash
ipdSummary aligned_subreads.bam --reference reference.fasta --identify m6A,m4C --gff modifications.gff --csv kinetics.csv
```

### Detecting m5C via TET-conversion
When working with TET-converted samples to identify m5C:
```bash
ipdSummary aligned_subreads.bam --reference reference.fasta --identify m5C_TET --gff m5c_modifications.gff
```

### Targeted Analysis
To limit analysis to a specific genomic window and improve processing speed:
```bash
ipdSummary aligned_subreads.bam --reference reference.fasta --referenceWindow "chr1:1-10000" --identify m6A --gff targeted.gff
```

### Estimating Methylated Fraction
To estimate the percentage of molecules methylated at a specific position:
```bash
ipdSummary aligned_subreads.bam --reference reference.fasta --identify m6A --methylFraction --gff fractions.gff
```

## Expert Tips and Best Practices

*   **Chemistry Compatibility**: This specific repository and toolset are optimized for **RSII chemistries**. For data generated on Sequel, Sequel II, or Revio systems, use the modification detection tools bundled with the latest SMRT Analysis/SMRT Link software suites.
*   **Input Requirements**: `ipdSummary` requires BAM files containing **subreads** with kinetics information (IPD and PulseWidth). It generally cannot be run on HiFi/CCS reads unless they have been specifically generated to retain kinetic data.
*   **Reference Alignment**: Ensure the input BAM is sorted and indexed. The tool relies on the alignment to the provided reference FASTA to calculate expected kinetic values.
*   **Strand Conventions**: Be aware that modification results are often mapped to the strand where the kinetic deviation was observed. If results appear on the "opposite" strand, verify your alignment parameters and strand-specific flags.
*   **Performance**: Modification detection is computationally expensive. If the process is taking significant time with low CPU utilization, ensure your environment has sufficient I/O throughput for the large BAM files and consider splitting the reference into smaller windows for parallel processing.

## Reference documentation
- [PacificBiosciences/kineticsTools Main](./references/github_com_PacificBiosciences_kineticsTools.md)
- [kineticsTools Issues and Troubleshooting](./references/github_com_PacificBiosciences_kineticsTools_issues.md)