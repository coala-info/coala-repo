---
name: find_differential_primers
description: This tool identifies discriminatory PCR primers that uniquely amplify target sequences while avoiding non-target groups. Use when user asks to design diagnostic primers, perform in silico primer validation, or identify specific markers for metabarcoding.
homepage: https://github.com/widdowquinn/find_differential_primers
---


# find_differential_primers

## Overview
The `find_differential_primers` tool (invoked via the `pdp` command) is a pipeline for the automated discovery of discriminatory PCR primers. It allows researchers to define "target" and "non-target" groups of sequences and identifies primer sets that uniquely amplify the targets. The workflow integrates primer design (via Primer3), off-target screening (via BLAST), and in silico validation (via EMBOSS primersearch) to classify primers by their diagnostic capability.

## Core Workflow and CLI Patterns

### 1. Configuration Setup
The tool requires a tab-separated configuration file (`.tab`) to define the input sequences and their groupings.
**Format:** `ShortName [TAB] Full_Name [TAB] Path/to/FASTA [TAB] Class`

Example `config.tab`:
```text
StrainA    Species_Target    /data/strain_a.fasta    target
StrainB    Species_Target    /data/strain_b.fasta    target
StrainC    Outgroup_Control  /data/strain_c.fasta    negative
```

### 2. Sequence Preparation
Initialize the project and validate the configuration file.
```bash
pdp config config.tab
```

### 3. Primer Design
Design primers for each sequence in the configuration. This step uses `eprimer3` (an EMBOSS wrapper for Primer3).
```bash
pdp eprimer3
```
*   **Tip**: Ensure `primer3` version 1.1.4 is installed, as newer versions may be incompatible with the EMBOSS wrappers used by this tool.

### 4. Off-Target Screening (Optional but Recommended)
Screen designed primers against a BLAST database of negative examples or environmental sequences to ensure specificity.
```bash
pdp blastscreen -d /path/to/blast_db
```

### 5. In Silico Cross-Hybridization
Test the primers against all input sequences to predict amplification patterns and identify potential cross-reactivity.
```bash
pdp primersearch
```

### 6. Classification
Classify the primers based on their ability to distinguish between the classes defined in your config file.
```bash
pdp classify
```
This produces the final set of candidate diagnostic primers, ranked by their specificity.

### 7. Metabarcoding Marker Extraction
If the goal is metabarcoding, use the `extract` subcommand to pull out the predicted amplicon sequences.
```bash
pdp extract
```

## Expert Tips
*   **Targeting Specific Regions**: If you only want primers for coding sequences (CDS), run `pdp filter` before `pdp eprimer3`. This uses `prodigal` to identify genes and restricts primer design to those regions.
*   **Subcommand Help**: Every step has specific parameters. Use `pdp <subcommand> -h` to view options for melting temperature (Tm), product size, and GC content.
*   **Deduplication**: If designing primers for many closely related genomes, use `pdp deduplicate` (if available in your version) to reduce the computational load of screening identical primer sequences multiple times.

## Reference documentation
- [github_com_widdowquinn_find_differential_primers.md](./references/github_com_widdowquinn_find_differential_primers.md)
- [anaconda_org_channels_bioconda_packages_find_differential_primers_overview.md](./references/anaconda_org_channels_bioconda_packages_find_differential_primers_overview.md)