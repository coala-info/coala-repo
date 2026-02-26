---
name: portello
description: Portello projects HiFi read mappings from assembly contigs onto a standard reference genome to enable reference-based analysis of assembly-aligned data. Use when user asks to lift over read-to-contig mappings, project assembly-based methylation calls onto reference coordinates, or visualize assembly support in the context of a reference genome.
homepage: https://github.com/PacificBiosciences/portello
---


# portello

## Overview
Portello is a bioinformatics tool designed to bridge the gap between de novo assembly and reference-based analysis. While de novo assembly is superior for capturing highly diverged or structural variants, most clinical and research pipelines rely on standard reference coordinates (e.g., GRCh38). Portello allows you to take HiFi reads that have been mapped to their own assembly contigs and project those mappings onto a standard reference. This enables the use of standard tools for variant calling, somatic analysis, and methylation assessment while retaining the accuracy of the assembly-based alignment.

## Installation
The tool is available via Bioconda. It is recommended to use a dedicated environment:
```bash
conda install -c bioconda portello
```

## Core Workflow and CLI Patterns
Portello typically operates within a pipeline involving an assembler (like hifiasm) and a reference aligner (like pbmm2 or minimap2).

### Primary Use Case
1. **Assemble** HiFi reads into contigs.
2. **Map** the original HiFi reads to the resulting contigs.
3. **Map** the contigs themselves to the standard reference genome.
4. **Run Portello** to "lift over" the read-to-contig mappings to read-to-reference mappings using the contig-to-reference alignment as a guide.

### Best Practices
- **Phased Analysis**: When using portello-transferred mappings in IGV, group reads by their associated assembly contig. This creates a phased-like view that helps distinguish haplotypes in rare-disease research.
- **Alignment Parameters**: Ensure that the contig-to-reference alignment is performed with parameters suitable for long, highly accurate sequences. Portello's development history suggests using optimized `minimap2` parameters for the best results.
- **Comparison**: Use portello mappings alongside standard `pbmm2` mappings to identify regions where the assembly provides better resolution of complex variants or highly diverged regions.

## Expert Tips
- **CIGAR String Caution**: Be aware of a known edge case where portello-generated CIGAR strings may occasionally extend slightly outside the remapped reference sequence. Always validate alignments in critical regions of interest.
- **Methylation Assessment**: Use portello to project assembly-based methylation calls onto reference coordinates for easier comparison across cohorts or with existing epigenetic databases.
- **Error/Compression Check**: Portello is highly effective for assessing assembly errors or compression by visualizing how reads support the assembly when viewed in the context of the reference genome.

## Reference documentation
- [github_com_PacificBiosciences_portello.md](./references/github_com_PacificBiosciences_portello.md)
- [anaconda_org_channels_bioconda_packages_portello_overview.md](./references/anaconda_org_channels_bioconda_packages_portello_overview.md)
- [github_com_PacificBiosciences_portello_issues.md](./references/github_com_PacificBiosciences_portello_issues.md)