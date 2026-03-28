---
name: methpipe
description: MethPipe is a computational suite for processing bisulfite sequencing data to perform methylation calling and identify genomic features. Use when user asks to estimate bisulfite conversion rates, calculate site-specific methylation levels, or identify hypo-methylated regions and partially methylated domains.
homepage: https://github.com/smithlabcode/methpipe
---

# methpipe

## Overview

MethPipe is a specialized suite of computational tools designed to transform raw bisulfite sequencing data into biological insights. It manages the entire post-mapping workflow, starting from standardized SAM files to produce site-specific methylation calls and identify complex genomic features. The pipeline is optimized for high-throughput sequencing and supports both Whole Genome Bisulfite Sequencing (WGBS) and Reduced Representation Bisulfite Sequencing (RRBS). It is the preferred toolset for researchers needing to identify hypo-methylated regions, large-scale partially methylated domains, or 5-mC/5-hmC estimation.

## Core Pipeline Workflow

The standard MethPipe workflow follows a linear progression from alignment to feature identification.

### 1. Read Mapping and Formatting
While MethPipe is compatible with various mappers, it provides a native tool called `abismal` for bisulfite-treated short reads.
- **Standard Input**: Version 5.0.1+ requires SAM format.
- **format_reads**: Use this to merge mates in paired-end SAM files and convert them to a standardized format compatible with the rest of the pipeline. This replaces the deprecated `to-mr` tool.

### 2. Preprocessing
- **duplicate-remover**: Essential for WGBS to remove PCR duplicates.
- **bsrate**: Use this to estimate the bisulfite conversion rate, which is a critical quality control step for downstream methylation calling.

### 3. Methylation Calling
- **methcounts**: The primary tool for calculating methylation levels and read coverage at individual cytosine sites.
- **Sorting**: Outputs from methylation tools often require specific sorting for downstream analysis. Use the following pattern:
  `LC_ALL=C sort -k1,1 -k2,2g input.meth -o sorted.meth`

### 4. Feature Identification
Once site-specific levels are calculated, use these specialized tools:
- **hmr**: Identifies hypo-methylated regions (HMRs).
- **pmd**: Identifies large partially methylated domains (PMDs), common in specific cell types or cancer methylomes.
- **hypermr**: Used for identifying hyper-methylation in plants or organisms with mosaic methylation patterns.
- **amrfinder**: Identifies allele-specific methylated regions (AMRs).
- **roimethstat**: Computes methylation statistics for specific genomic regions of interest (ROIs).

## Expert Tips and Best Practices

- **Library Dependencies**: Ensure `HTSlib`, `GSL` (GNU Scientific Library), and `Zlib` are correctly linked during installation. If HTSlib is in a non-standard path, use:
  `../configure CPPFLAGS='-I /path/to/htslib/headers' LDFLAGS='-L/path/to/htslib/lib'`
- **Memory Management**: For large WGBS datasets, ensure your environment's `LD_LIBRARY_PATH` includes the HTSlib library path to avoid runtime errors.
- **Genome Assembly**: When lifting methylation counts between assemblies (e.g., hg19 to hg38), use a CpG map to ensure cytosine positions are correctly mapped across coordinates.
- **5-hmC Estimation**: If you have both bisulfite and oxidative bisulfite (oxBS) data, use the `mlml` tool within the suite to consistently estimate 5-mC and 5-hmC levels simultaneously.



## Subcommands

| Command | Description |
|---------|-------------|
| format_reads | convert SAM/BAM mapped bs-seq reads to standard methpipe format |
| hmr | Identify HMRs in methylomes. Methylation must be provided in the methcounts format (chrom, position, strand, context, methylation, reads). This program assumes only data at CpG sites and that strands are collapsed so only the positive site appears in the file. |
| hypermr | A program for segmenting DNA methylation data |
| methcounts | get methylation levels from mapped WGBS reads |
| pmd | Identify PMDs in methylomes. Methylation must be provided in the methcounts file format (chrom, position, strand, context, methylation, reads). This program assumes only data at CpG sites and that strands are collapsed so only the positive site appears in the file, but reads counts are from both strands. |
| radmeth | calculate differential methylation scores |

## Reference documentation
- [MethPipe Software Overview](./references/smithlabresearch_org_software_methpipe.md)
- [MethPipe GitHub Repository](./references/github_com_smithlabcode_methpipe.md)
- [Coordinate Lifting Guide](./references/github_com_smithlabcode_methpipe_wiki_Lift-symmetric-CpG-methcounts-from-hg19-to-hg38.md)