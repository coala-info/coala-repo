---
name: 3d-dna
description: 3D-DNA is a pipeline that scales draft genome assemblies to chromosome-length scaffolds using Hi-C proximity ligation data. Use when user asks to scaffold a genome assembly, detect and correct misjoins, or generate files for manual curation in Juicebox.
homepage: https://github.com/aidenlab/3d-dna/tree/201008
---


# 3d-dna

## Overview

3D-DNA is a specialized pipeline designed to scale draft genome assemblies to chromosome-length scaffolds using Hi-C proximity ligation data. It operates through an iterative workflow that eliminates misjoins in input scaffolds, performs scaffolding, and applies post-processing steps like polishing and sealing. It is the standard tool for generating assemblies compatible with the Juicebox Assembly Tools (JBAT) for manual curation.

## Core Workflows

### Primary Assembly Pipeline
The main entry point is `run-asm-pipeline.sh`. It requires a draft assembly (FASTA) and a Hi-C contact map (typically in a merged_nodups format).

```bash
# Basic usage
./run-asm-pipeline.sh [options] <input.fasta> <mnd.txt>

# View all available options
./run-asm-pipeline.sh --help
```

### Post-Review Processing
After manually editing an assembly in Juicebox, use the post-review script to finalize the FASTA and contact maps based on the `.assembly` file produced by the manual review.

```bash
./run-asm-pipeline-post-review.sh [options] -r <reviewed.assembly> <input.fasta> <mnd.txt>
```

## Key Modules and Scripts

The pipeline is modular; individual components can be run independently if specific stages need re-running:

- **Scaffolding (`run-liger-scaffolder.sh`)**: Orders and orients scaffolds.
- **Visualization (`run-asm-visualizer.sh`)**: Generates `.hic` files for Juicebox.
- **Misassembly Detection (`run-misassembly-detector.sh`)**: Annotates putative misjoins.
- **Polishing (`run-asm-polisher.sh`)**: Fixes errors where 3D signal contradicts the diagonal.
- **Finalization (`finalize-output.sh`)**: Produces the final FASTA files.

## Expert Tips and Best Practices

- **Performance**: Highly recommended to have **GNU Parallel** (version >= 20150322) installed. The pipeline detects and uses it automatically to significantly increase performance.
- **Diploid Mode**: If working with highly heterozygous genomes, use the diploid mode to trigger the `merge` algorithm, which corrects undercollapsed heterozygosity. This requires **LastZ** (version 1.03.73).
- **Output Identification**: The primary output files are annotated with `FINAL`. Look for `FINAL.fasta` for your chromosome-length scaffolds.
- **Iterative Correction**: By default, the pipeline performs iterative rounds of misjoin correction. If the input assembly is already high-quality, you can adjust the number of iterations to save time.
- **Juicebox Integration**: The pipeline produces `.assembly` files. These are the modern standard for loading into Juicebox Assembly Tools, superseding older `.cprops` and `.asm` formats.

## Reference documentation
- [3D-DNA Repository Overview](./references/github_com_aidenlab_3d-dna_tree_201008.md)
- [3D-DNA Wiki Home](./references/github_com_aidenlab_3d-dna_wiki.md)