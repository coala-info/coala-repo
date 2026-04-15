---
name: tadrep
description: TaDReP is a bioinformatics tool that detects and reconstructs plasmid sequences from fragmented bacterial draft genomes using a reference-based alignment approach. Use when user asks to identify plasmids in draft assemblies, reconstruct plasmid scaffolds from contigs, or visualize plasmid alignments against reference backbones.
homepage: https://github.com/oschwengers/tadrep
metadata:
  docker_image: "quay.io/biocontainers/tadrep:0.9.2--pyhdfd78af_0"
---

# tadrep

## Overview

TaDReP (Targeted Detection and Reconstruction of Plasmids) is a specialized bioinformatics tool designed to resolve plasmid sequences within fragmented bacterial draft genomes. Instead of relying on de novo plasmid assembly, which often fails in short-read data, TaDReP uses a reference-based approach. It aligns draft contigs to known plasmid backbones using Blast+, applies rigorous coverage and identity filters, and then reorders and merges matching contigs into scaffolds or pseudomolecules.

## Installation and Setup

Install TaDReP via Conda to ensure all third-party dependencies (like Blast+) are correctly configured:

```bash
conda install -c conda-forge -c bioconda tadrep
```

Alternatively, use pip for the Python package:

```bash
python3 -m pip install --user tadrep
```

## Core Workflow and CLI Usage

TaDReP operates through a series of submodules. The typical workflow involves preparing a reference database and then running detection on draft assemblies.

### 1. Database Preparation
Before detection, you must have reference plasmid sequences. Use the `extract` submodule to pull sequences from existing closed genomes or public databases (RefSeq/PLSDB).

### 2. Detecting Plasmids
The primary command for screening genomes. Provide your draft assemblies and the reference plasmid database.

```bash
TaDReP detect --threads 8 --output ./results --input draft_genomes/*.fasta --db reference_plasmids.fasta
```

### 3. Visualizing Results
Generate PDF maps showing how your draft contigs align against the reference plasmid backbone.

```bash
TaDReP visualize --input ./results/summary.tsv --output ./plots
```

## Key Outputs

TaDReP generates several files for each analyzed genome:
- **Summary TSV**: `<genome>-summary.tsv` contains detailed per-contig alignment statistics.
- **Reconstructed Contigs**: `<genome>-<plasmid>-contigs.fna` provides the ordered and rearranged contigs.
- **Pseudomolecule**: `<genome>-<plasmid>-pseudo.fna` contains the N-merged scaffold of the reconstructed plasmid.
- **Visual Map**: `<genome>-<plasmid>.pdf` provides a graphical representation of the alignment.
- **Cohort Analysis**: If multiple genomes are processed, `plasmids.tsv` provides a presence/absence matrix across the entire set.

## Expert Tips and Best Practices

- **Thread Optimization**: Always use the `--threads` (or `-t`) flag to speed up the Blast+ alignment phase, especially when processing large cohorts.
- **Reference Selection**: The quality of reconstruction depends heavily on the similarity between your draft plasmid and the reference. Use the `cluster` submodule to reduce redundancy in your reference database if it is very large.
- **Filtering Thresholds**: TaDReP uses strict default thresholds for coverage and identity. If you suspect a plasmid is present but not being detected, check the `tadrep.log` file to see if contigs were filtered out during the alignment phase.
- **Input Formats**: TaDReP natively handles zipped fasta files, saving disk space when working with large genomic datasets.



## Subcommands

| Command | Description |
|---------|-------------|
| tadrep characterize | Import json file from a given database path into working directory |
| tadrep_cluster | Cluster plasmids based on sequence identity and length difference. |
| tadrep_database | Import external databases for TaDReP. |
| tadrep_detect | Detects plasmids in a draft genome. |
| tadrep_extract | Extracts sequences from input files based on specified criteria. |
| tadrep_visualize | Visualize TaDReP results |

## Reference documentation
- [TaDReP Main README](./references/github_com_oschwengers_tadrep_blob_main_README.md)
- [TaDReP Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tadrep_overview.md)