---
name: groopm
description: GroopM is an automated tool for binning metagenomic contigs into individual microbial genomes using differential coverage and sequence composition. Use when user asks to parse BAM files into profiles, generate core bins, recruit contigs to existing bins, or extract binned sequences into FASTA files.
homepage: https://ecogenomics.github.io/GroopM/
---


# groopm

## Overview
GroopM is a specialized tool for the automated binning of metagenomic contigs. It leverages the principle of differential coverage—how the abundance of a specific sequence varies across different metagenomic datasets—combined with sequence composition (k-mer frequencies) to isolate individual microbial genomes from complex environmental samples. This skill provides the necessary command-line patterns to execute the core binning workflow.

## Core Workflow and CLI Patterns

The standard GroopM workflow follows a sequence of parsing, core binning, and refinement.

### 1. Data Preparation (Parsing)
Before binning, you must transform BAM files (mappings of reads to contigs) into a GroopM-compatible profile.
```bash
groopm parse <output_profile> <fasta_file> <bam_files...>
```
*   **Tip**: Ensure all BAM files are indexed and derived from the same assembly (the provided FASTA).

### 2. Core Binning
Generate the initial set of bins based on the parsed profile.
```bash
groopm core <output_directory> <parsed_profile>
```
*   This step identifies the "core" of each population genome where the signal is strongest.

### 3. Recruitment and Refinement
Expand the core bins by recruiting remaining contigs that match the established profiles.
```bash
groopm recruit <output_directory> <parsed_profile>
```
*   This increases the completeness of the extracted genomes.

### 4. Extraction
Once binning is complete, extract the sequences into individual FASTA files.
```bash
groopm extract <output_directory> <fasta_file> <bin_file>
```

## Expert Tips
- **Coverage Variation**: GroopM's power scales with the number of samples. Using at least 3-5 samples with varying biological conditions significantly improves binning resolution.
- **Contig Length**: For reliable tetranucleotide frequency calculations, filter your assembly to include only contigs >1000bp (ideally >2500bp) before running `groopm parse`.
- **Resource Management**: Parsing large BAM files is memory-intensive. Ensure your environment has sufficient RAM relative to the size of your global assembly.



## Subcommands

| Command | Description |
|---------|-------------|
| flyover | Visualize the contig binning process. |
| groopm core | Load saved data and make bin cores |
| groopm explore | Exploration mode [binpoints, binids, allcontigs, unbinnedcontigs, binnedcontigs, binassignments, compare, sidebyside, together] |
| groopm highlight | Highlight contigs in a groopm database. |
| groopm merge | Merge BAM files based on a database of alignments. |
| groopm recruit | Recruit more contigs into existing bins |
| groopm split | Split a database into parts |
| groopm_delete | Delete bins from a groopm database. |
| groopm_dump | Dump data from a groopm database. |
| groopm_extract | Extract contigs or reads based on bin affiliations |
| groopm_parse | Parse raw data and save to disk |
| groopm_plot | Plotting tool for groopm |
| groopm_print | Print information from a groopm database. |
| groopm_refine | Merge similar bins and split chimeric ones |

## Reference documentation
- [GroopM Overview](./references/anaconda_org_channels_bioconda_packages_groopm_overview.md)