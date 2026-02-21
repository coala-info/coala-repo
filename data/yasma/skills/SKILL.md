---
name: yasma
description: YASMA is a modular suite designed for the comprehensive analysis of small RNA populations.
homepage: https://github.com/NateyJay/YASMA
---

# yasma

## Overview

YASMA is a modular suite designed for the comprehensive analysis of small RNA populations. Unlike tools that focus strictly on miRNAs, YASMA performs de novo annotation across all sRNA classes by calculating an RPM threshold that balances read capture against genomic space. It is built around a directory-oriented workflow where a central `inputs.json` file tracks project state, allowing modules to be run sequentially without manually passing file paths between steps.

## Installation and Setup

Install YASMA via Bioconda:
```bash
conda install bioconda::yasma
```

Initialize a project directory to create the tracking configuration:
```bash
yasma inputs -o my_analysis -s SRR1234567 SRR1234568 -g /path/to/genome.fa
cd ./my_analysis
```

## Core Workflow Patterns

### 1. Pre-processing
YASMA provides wrappers for common upstream tasks. These update the project configuration automatically.
- **Download**: `yasma download` (fetches SRR codes defined during init).
- **Adapter Detection**: `yasma adapter` (identifies 3' adapters).
- **Trimming**: `yasma trim` (executes `cutadapt` based on detected adapters).

### 2. Alignment
The alignment module uses a ShortStack3-style weighting approach to handle multi-mapping reads.
```bash
yasma align
```
*Note: You can use external BAM files, but they must contain the `@RG` (Read Group) field.*

### 3. Annotation (The Tradeoff Module)
This is the core engine. It builds coverage profiles and merges peaks based on sRNA profiles.
```bash
yasma tradeoff
```
**Expert Tip**: Use the `-r` or `--annotation_readgroups` flag to restrict annotation to specific libraries (e.g., only Wild Type replicates) while still maintaining the full alignment context.

### 4. Analysis and Visualization
- **Counting**: `yasma count` generates tabular data for readgroups, loci, and size distributions.
- **Structure**: `yasma hairpin` evaluates loci for potential miRNA/hairpin structures.
- **Visualization**: `yasma jbrowse` prepares tracks for JBrowse2.
- **Coverage**: `yasma coverage` produces combined BigWig files for genome browsers.

## Best Practices

- **Directory Context**: Always run `yasma` commands from within the initialized project directory. The tool looks for `inputs.json` in the current working directory by default.
- **Manual Overrides**: While `inputs.json` is managed by the tool, it is human-readable. You can manually edit it to fix pathing issues or add metadata, though re-running the `inputs` module is safer.
- **Handling Noise**: If you observe over-annotation in background sequences, review the `removed_loci.gff3` file produced by the `tradeoff` module to understand which filters (depth, density, or complexity) are being triggered.
- **Size Profiles**: Use `yasma size-profile` early in the analysis to verify the quality of your sRNA libraries and ensure the expected 21nt or 24nt peaks are present.

## Reference documentation
- [YASMA GitHub Repository](./references/github_com_NateyJay_YASMA.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_yasma_overview.md)