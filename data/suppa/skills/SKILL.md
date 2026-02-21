---
name: suppa
description: SUPPA is a high-performance toolset designed for the rapid and accurate analysis of alternative splicing.
homepage: https://github.com/comprna/SUPPA
---

# suppa

## Overview
SUPPA is a high-performance toolset designed for the rapid and accurate analysis of alternative splicing. Unlike traditional methods that rely on heavy read-mapping, SUPPA leverages transcript-level quantification (e.g., TPM values from Salmon or Kallisto) to calculate splicing inclusion levels. It is particularly effective for large-scale datasets where computational speed is critical, allowing users to move from transcript abundances to differential splicing and clustering in a modular, multi-step workflow.

## Core Command Structure
All operations are executed via subcommands:
`python3 suppa.py <subcommand> <options>`

### 1. Event Generation
Generate local alternative splicing events or transcript-centric events from a GTF annotation.
- **Subcommand**: `generateEvents`
- **Key Options**:
  - `-i <input.gtf>`: Input annotation file.
  - `-o <output_prefix>`: Prefix for output files.
  - `-f <format>`: Output format (`ioi` for transcript-centric, `ioe` for local events).
  - `-e <event_types>`: Space-separated list of events (e.g., `SE SS MX RI FL`).
- **Tip**: SUPPA reads gene/transcript info solely from "exon" lines in the GTF. Ensure your GTF is well-formatted.

### 2. PSI Quantification
Calculate the Percent Spliced In (PSI) values for events or isoforms.
- **Subcommands**: `psiPerEvent` or `psiPerIsoform`
- **Inputs**: 
  - For events: Requires the `.ioe` file and a transcript expression file (TPM).
  - For isoforms: Requires the `.ioi` file and a transcript expression file (TPM).
- **Key Options**:
  - `-e <expression_file>`: TPM values for transcripts.
  - `-i <ioe_or_ioi_file>`: The event file generated in step 1.
- **Tip**: Ensure the transcript IDs in your expression file match exactly with those in the GTF/IOE files.

### 3. Differential Splicing Analysis
Calculate ΔPSI and statistical significance across conditions.
- **Subcommand**: `diffSplice`
- **Method**: Compares observed ΔPSI between conditions against the distribution of ΔPSI between replicates.
- **Key Options**:
  - `-m <method>`: Statistical test (e.g., `empirical` for few replicates, `wilcoxon` for >10 replicates).
  - `-p <psi_files>`: Space-separated list of PSI files for conditions.
  - `-e <exp_files>`: Space-separated list of expression files.
  - `-i <ioe_file>`: The event definition file.
- **Output**: A `.dpsi` file containing the change in inclusion and a `.psivec` file with the significance values.

### 4. Cluster Analysis
Group events or transcripts with similar splicing patterns across multiple conditions.
- **Subcommand**: `clusterEvents`
- **Key Options**:
  - `-d <dpsi_file>`: Output from the differential splicing step.
  - `-p <psivec_file>`: PSI values across conditions.
  - `-c <clustering_method>`: Typically density-based clustering.
- **Output**: A `.clustvec` file mapping events to specific clusters.

## Expert Tips & Best Practices
- **Version Selection**: Use version 2.4 (available on GitHub) over older Bioconda versions to ensure access to the latest bug fixes and performance improvements.
- **Expression Input**: SUPPA is optimized for TPM (Transcripts Per Million). Using raw counts or other normalization methods may lead to inaccurate PSI calculations.
- **Replicate Handling**: For `diffSplice`, provide replicates as comma-separated files within the space-separated condition list to ensure the empirical distribution is calculated correctly.
- **Coordinate Systems**: Be aware of 0-based vs 1-based coordinates in your GTF; SUPPA follows standard GTF conventions (1-based).

## Reference documentation
- [SUPPA Main README](./references/github_com_comprna_SUPPA.md)
- [SUPPA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_suppa_overview.md)