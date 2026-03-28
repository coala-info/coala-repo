---
name: varvamp
description: varVAMP designs degenerate primers and probes for diverse viral populations by incorporating ambiguous characters to ensure broad reactivity. Use when user asks to design tiled whole-genome sequencing primers, create single amplicons for PCR screening, or develop qPCR assays with optimized TaqMan probes.
homepage: https://github.com/jonas-fuchs/varVAMP
---


# varvamp

## Overview

varVAMP (variable Virus AMplicons) is a specialized bioinformatics tool designed to solve the challenge of primer design for rapidly evolving or highly diverse viral populations. Unlike standard primer design tools, varVAMP introduces ambiguous (IUPAC) characters into primer sequences to ensure broad reactivity across a provided alignment while minimizing mismatches at the critical 3' end. It is particularly effective for generating "pan-specific" primers that can recognize the majority of sequences in a diverse dataset.

## Core Workflows

### 1. Tiled Whole-Genome Sequencing
Use the `tiled` mode to generate overlapping amplicons that cover the entire viral genome. This is the standard approach for Oxford Nanopore or Illumina sequencing.

```bash
varvamp tiled -i alignment.fasta -o output_directory --num_ambiguous 2
```

### 2. PCR Screening (Single Amplicons)
Use the `single` mode to find the highest-quality, non-overlapping amplicons. This is ideal for diagnostic screening or detection assays where full coverage is not required.

```bash
varvamp single -i alignment.fasta -o output_directory
```

### 3. qPCR Assay Design
Use the `qpcr` mode to design small amplicons with optimized internal TaqMan probes. This mode minimizes temperature differences between primers and probes and checks for secondary structures.

```bash
varvamp qpcr -i alignment.fasta -o output_directory
```

## Expert Tips and Best Practices

### Optimization Strategy
If the initial output is poor (too few primers), follow this hierarchy:
1. **Increase Ambiguity**: Increase the number of allowed ambiguous bases (`-a` or `--num_ambiguous`).
2. **Lower Threshold**: If ambiguity is already at your lab's limit, lower the consensus threshold (`-t` or `--threshold`).
3. **Automatic Optimization**: If you provide the ambiguity limit but omit the threshold, varVAMP will automatically estimate the best threshold to meet your amplicon constraints.

### Off-Target Checking
Always validate your designs against host or environmental genomes using a local BLAST database to ensure specificity.
```bash
varvamp tiled -i alignment.fasta -o output -db /path/to/local/blast_db
```

### Handling Primer Dimers
In `tiled` mode, varVAMP uses a graph-based Dijkstra algorithm to minimize penalties. If it reports unsolvable dimers:
* Check the reported melting temperature ($T_m$). If it is significantly lower than your annealing temperature, a hot-start polymerase may still work.
* Consider splitting the scheme into a third pool if the dimer is unavoidable but the amplicon is critical.

### Alignment Preparation
* **Clean Gaps**: varVAMP automatically masks large insertions with "N" to prevent designing primers across unstable regions.
* **RNA to DNA**: The tool automatically handles RNA-to-DNA conversion.
* **Reference Mapping**: The output BED file is relative to the varVAMP consensus. If mapping to a specific reference (e.g., NC_045512.2), you must lift over the coordinates.



## Subcommands

| Command | Description |
|---------|-------------|
| varvamp qpcr | Performs qPCR primer and probe design. |
| varvamp_single | Performs primer design and amplicon prediction for a single input alignment. |
| varvamp_tiled | Performs primer design and amplicon tiling for variant calling. |

## Reference documentation
- [varVAMP README](./references/github_com_jonas-fuchs_varVAMP_blob_master_README.md)
- [How varVAMP Works](./references/github_com_jonas-fuchs_varVAMP_blob_master_docs_how_varvamp_works.md)
- [varVAMP FAQ](./references/github_com_jonas-fuchs_varVAMP_blob_master_docs_FAQ.md)