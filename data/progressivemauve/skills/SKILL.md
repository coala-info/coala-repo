---
name: progressivemauve
description: ProgressiveMauve performs multiple genome alignments while accounting for large-scale evolutionary rearrangements such as inversions and translocations. Use when user asks to align non-collinear genomes, identify locally collinear blocks, generate phylogenetic guide trees, or extract backbone statistics from conserved genomic regions.
homepage: http://darlinglab.org/mauve/user-guide/progressivemauve.html
metadata:
  docker_image: "quay.io/biocontainers/progressivemauve:snapshot_2015_02_13--0"
---

# progressivemauve

## Overview
ProgressiveMauve is a specialized tool for comparative genomics designed to align genomes that are not necessarily collinear. Unlike standard aligners, it accounts for inversions, translocations, and deletions by identifying segments of conserved gene order (LCBs). It is particularly effective for bacterial and viral genomics where horizontal gene transfer and rearrangements are common. This skill provides the necessary command-line patterns to execute alignments, refine existing XMFA files, and tune sensitivity for divergent sequences.

## Core Workflows

### Basic Multiple Genome Alignment
To align multiple genomes (e.g., GenBank or FastA format) and save the result in XMFA format:
```bash
progressiveMauve --output=alignment.xmfa genome1.gbk genome2.gbk genome3.fasta
```

### Generating Auxiliary Files
To extract the phylogenetic guide tree and backbone statistics (conserved regions present in all genomes) during the alignment process:
```bash
progressiveMauve --output=alignment.xmfa \
                 --output-guide-tree=alignment.tree \
                 --backbone-output=alignment.backbone \
                 genome1.gbk genome2.gbk
```

### Handling Divergent or Rearranged Genomes
If the default alignment shows too many rearrangements or fails to anchor correctly:
- **Increase Sensitivity**: Use `--seed-family` to improve anchoring in regions with <70% identity.
- **Adjust Breakpoint Penalty**: Use `--weight=<number>` to set the minimum LCB score. A lower weight allows more rearrangements; a higher weight forces longer collinear blocks.
- **Scale Penalties**: Use `--min-scaled-penalty=<number>` to prevent over-calling rearrangements in highly divergent genomes.

### Specialized Alignment Modes
- **Collinear Genomes**: For viral or closely related genomes without rearrangements, use `--collinear` to speed up processing and improve accuracy.
- **MUMs Only**: To find unique maximal exact matches without performing a full gapped alignment:
  ```bash
  progressiveMauve --mums --output=matches.mums genome1.gbk genome2.gbk
  ```
- **Apply Backbone to Existing Alignment**: To calculate backbone statistics for a previously generated XMFA file:
  ```bash
  progressiveMauve --apply-backbone=input.xmfa --output=refined.xmfa --backbone-output=refined.backbone
  ```

## Expert Tips
- **Memory Management**: For large datasets, use `--scratch-path-1=/path/to/tmp` and `--scratch-path-2=/path/to/tmp` to designate temporary storage and prevent memory exhaustion.
- **Input Order**: While progressiveMauve builds a guide tree, providing a known tree via `--input-guide-tree=<file>` (Newick format) can improve results if the phylogeny is already well-understood.
- **Refinement**: If the alignment is computationally expensive, you can skip the iterative refinement step using `--skip-refinement` for a faster but potentially less accurate result.
- **Gap Penalties**: Fine-tune alignment gaps in highly variable regions using `--gap-open` and `--gap-extend`.

## Reference documentation
- [Using progressiveMauve from the command-line](./references/darlinglab_org_mauve_user-guide_progressivemauve.html.md)
- [progressivemauve - bioconda overview](./references/anaconda_org_channels_bioconda_packages_progressivemauve_overview.md)