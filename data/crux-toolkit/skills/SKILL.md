---
name: crux-toolkit
description: The Crux toolkit is a unified command-line interface for proteomics informatics that identifies peptides and quantifies proteins from raw mass spectra. Use when user asks to index protein databases, search MS2 spectra using Tide or Comet, calculate false discovery rates with Percolator, or perform label-free protein quantification.
homepage: http://crux.ms
metadata:
  docker_image: "quay.io/biocontainers/crux-toolkit:4.2--h9ee0642_0"
---

# crux-toolkit

## Overview
The Crux toolkit is a unified command-line interface for proteomics informatics. It streamlines the transition from raw mass spectra to identified peptides and quantified proteins. This skill provides the necessary command structures and workflow logic to navigate its primary engines—Tide for fast indexing and searching, Comet for traditional searching, and Percolator for post-processing and statistical validation.

## Core Command Patterns

Crux is executed via a single binary using the syntax: `crux <command> [options] <arguments>`.

### 1. Database Search Workflow (Tide)
Tide is the recommended engine for high-speed searches. It requires a two-step process:

**Step A: Indexing**
Create a binary index of the protein database to speed up subsequent searches.
```bash
crux tide-index protein_database.fasta tide-index-output
```

**Step B: Searching**
Search MS2 spectra against the generated index.
```bash
crux tide-search spectra.ms2 tide-index-output
```

### 2. Alternative Search (Comet)
Use Comet if you prefer searching directly against a FASTA file without a pre-indexing step.
```bash
crux comet spectra.ms2 protein_database.fasta
```

### 3. Statistical Confidence (Percolator)
After a search, use Percolator to re-rank PSMs and calculate False Discovery Rates (FDR). This is essential for publishing results.
```bash
crux percolator crux-output/tide-search.target.txt
```

### 4. Protein Quantification
To perform label-free quantification using spectral counting:
```bash
crux spectral-counts crux-output/percolator.target.peptides.txt
```

## Expert Tips & Best Practices

- **Precursor Refinement**: Use `crux bullseye` before searching if you have high-resolution MS1 data but low-resolution MS2, as it assigns more accurate precursor m/z values.
- **Parameter Estimation**: If unsure about mass tolerances, run `crux param-medic` on your spectra files to automatically estimate optimal search settings.
- **Decoy Generation**: By default, `tide-index` generates "shuffled" decoy peptides. Ensure decoys are present to allow `percolator` to calculate FDR.
- **Output Management**: Crux creates a directory named `crux-output` by default. Use `--output-dir <name>` to prevent overwriting previous runs.
- **Memory Efficiency**: For extremely large FASTA files, `tide-index` is significantly more memory-efficient than `comet` during the search phase.

## Primary Commands Reference

| Command | Purpose |
|---------|---------|
| `tide-index` | Pre-computes peptide theoretical spectra. |
| `tide-search` | Fast database search using Tide index. |
| `comet` | Traditional database search (no index required). |
| `percolator` | Semi-supervised learning to improve PSM identification. |
| `kojak` | Specialized search for cross-linked peptides. |
| `diameter` | Analysis of Data-Independent Acquisition (DIA) data. |
| `pipeline` | Runs index, search, and percolator in one command. |

## Reference documentation
- [Crux Toolkit Overview](./references/anaconda_org_channels_bioconda_packages_crux-toolkit_overview.md)
- [Crux Command Index](./references/crux_ms_index.md)