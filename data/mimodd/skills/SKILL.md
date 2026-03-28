---
name: mimodd
description: MiModD is a bioinformatics suite designed for identifying mutations and performing linkage mapping in model organism genomes on desktop computers. Use when user asks to align reads, call variants or deletions, filter VCF files, rebase coordinates, or perform linkage analysis to identify causative mutations.
homepage: http://sourceforge.net/projects/mimodd
---

# mimodd

## Overview

MiModD (Mutation Identification in Model Organism Genomes using Desktop PCs) is a specialized bioinformatics suite optimized for identifying mutations in model organisms without requiring high-performance computing clusters. It provides a streamlined workflow for processing WGS (Whole Genome Sequencing) data, emphasizing memory efficiency and ease of use. The tool handles sequence alignment (via SNAP), variant calling, sophisticated filtering based on biological logic, and linkage mapping to narrow down causative mutations.

## Core CLI Usage

### Getting Help and Information
The primary entry point for all operations is the `mimodd` executable.
- Access the integrated help system: `mimodd help`
- Get help for a specific tool: `mimodd help [subcommand]` (e.g., `mimodd help map`)
- Inspect NGS file metadata: `mimodd info [input_file]`

### Variant Calling and Extraction
MiModD uses the SNAP aligner internally for speed and provides tools for identifying SNPs and indels.
- **Variant Calling**: Use `varcall` to identify variants from BAM files.
  - Tip: Use `--index-files` to utilize pre-calculated BAM indices and save time.
  - Ensure the reference FASTA and BAM headers match exactly.
- **Deletion Calling**: Use `delcall` for identifying larger genomic deletions.
- **Extraction**: Use `varextract` to pull specific variants from VCF files. The `--pre` option is useful when working with named samples.

### Filtering and Transformation
- **VCF Filtering**: Use `vcf-filter` to narrow down candidates.
  - Common filters: `--region` (specific genomic coordinates), `--indels-only`, or `--no-indels`.
- **Coordinate Rebasing**: Use `rebase` to port variant coordinates between different reference versions using a UCSC chain file.
- **Fasta Sanitization**: Use `sanitize` with `-t` or `--truncate-at` to clean up long FASTA headers that can break downstream tools.

### Linkage Mapping (NacreousMap)
The `map` tool is a core feature for identifying causative mutations through linkage analysis.
- **Variant Allele Contrast Mapping**: Use this mode to discover regions where two samples (e.g., mutant vs. wild-type) are maximally divergent.
- **Visualization**: The tool generates scatter plots and histograms.
  - **KDE**: Histograms include a Kernel Density Estimate (KDE) to identify peaks independent of bin size.
  - **Loess**: Adjust the Loess span to smooth data; a span of zero disables Loess calculation.

## Expert Tips
- **Resource Management**: MiModD is designed for desktops. If running multiple large jobs, use the `config` tool to set package-wide limits on memory and CPU usage.
- **Temporary Files**: For systems with limited `/tmp` space, configure MiModD to use the current working directory for temporary files via the `config` tool.
- **Galaxy Integration**: If you prefer a GUI, use `mimodd.enablegalaxy` to integrate the CLI tools into a local Galaxy instance.
- **SnpEff Compatibility**: When using `annotate` or `varreport`, ensure your SnpEff version is compatible (v4.1b through v4.3i are supported in v0.1.9).



## Subcommands

| Command | Description |
|---------|-------------|
| annotate | Annotates a VCF file using a specified SnpEff genome annotation. |
| covstats | Calculate coverage statistics from BCF files. |
| delcall | delcall [-h] [--index-files INDEX FILE [INDEX FILE ...]] [-o OFILE] [--max-cov COVERAGE THRESHOLD] [--min-size SIZE THRESHOLD] [-u] [-i] [-v] BAM input files) [BAM input file(s ...] BCF file with coverage information |
| header | Add or modify header information in BAM/SAM/CRAM files. |
| index | Index generation tool for various formats. |
| info | Show information about the input file |
| map | MiModD mapping tool for variant analysis. |
| mimodd | Configure MiModD to specify the location of an existing SnpEff installation for use by MiModD. |
| mimodd_convert | Convert between various sequence file formats. |
| rebase | Remaps variants from one genome assembly to another using a UCSC chain file. |
| reheader | Reheader a BAM file using a template SAM file. |
| snap | Sequencing mode reference genome or index directory input files |
| snap-batch | Runs multiple snap commands |
| sort | Sorts SAM/BAM files by read name. |
| varcall | Call variants from aligned reads |
| varextract | Extracts variant sites from BCF files. |
| varreport | Generates a report from a VCF file. |
| vcf-filter | Filters VCF files based on various criteria. |

## Reference documentation
- [MiModD Files and Release Notes](./references/sourceforge_net_projects_mimodd_files.md)
- [MiModD Project Summary](./references/sourceforge_net_projects_mimodd.md)
- [MiModD Support and Wiki Links](./references/sourceforge_net_projects_mimodd_support.md)