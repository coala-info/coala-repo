---
name: metavelvet
description: MetaVelvet is an extension of the Velvet assembler designed specifically for metagenomics.
homepage: https://github.com/hacchy/MetaVelvet
---

# metavelvet

## Overview
MetaVelvet is an extension of the Velvet assembler designed specifically for metagenomics. While standard assemblers struggle with the varying coverage depths of different species in a single sample, MetaVelvet analyzes the k-mer coverage histogram to identify multiple peaks representing different organisms. It then decomposes the shared de Bruijn graph into individual species-specific components to produce more accurate contigs and scaffolds.

## CLI Usage Patterns

The MetaVelvet workflow typically follows the standard Velvet pipeline but replaces or follows the final assembly step with `meta-velvetg`.

### 1. Initial Graph Construction (Velvet)
First, use the standard Velvet components to hash reads and build the initial de Bruijn graph.
```bash
velveth <output_directory> <kmer_size> -fastq -short <reads.fastq>
velvetg <output_directory> -exp_cov auto -ins_length <length>
```

### 2. Metagenomic Assembly (MetaVelvet)
Run `meta-velvetg` on the directory prepared by Velvet. The core of MetaVelvet is the identification of coverage peaks.

```bash
meta-velvetg <directory> [options]
```

**Key Option: -exp_covs**
Unlike standard Velvet which uses a single expected coverage, MetaVelvet requires the expected coverage for each species peak identified in the dataset.
*   **Pattern**: `-exp_covs <peak1>_<peak2>_<peak3>`
*   **Expert Tip**: Peaks must be delimited by underscores (`_`). For example, if you identify peaks at 15x, 45x, and 80x, use `-exp_covs 15_45_80`.

## Best Practices and Expert Tips

### Peak Detection
Before running `meta-velvetg`, analyze the `stats.txt` file in the Velvet output directory to generate a k-mer coverage histogram. 
*   Identify the local maxima in the distribution.
*   Each significant peak typically represents a different member of the microbial community or a different abundance level.

### Troubleshooting Known Issues
Based on repository reports, be aware of the following potential failure points:
*   **Pebble Resolution**: The assembly may crash during the "Starting pebble resolution..." phase. This is often related to graph complexity or memory constraints.
*   **Scaffolding Stalls**: If the process appears stuck during the Scaffolding step, ensure that the `-ins_length` (insert length) provided during the `velvetg` stage was accurate, as MetaVelvet relies heavily on these distances for graph decomposition.

### Version Compatibility
This skill is optimized for MetaVelvet v1.2.01, which includes updates to the `VelvetAPI` and `ISGraph` components for improved graph handling compared to earlier versions.

## Reference documentation
- [github_com_hacchy_MetaVelvet.md](./references/github_com_hacchy_MetaVelvet.md)
- [github_com_hacchy_MetaVelvet_commits_master.md](./references/github_com_hacchy_MetaVelvet_commits_master.md)
- [github_com_hacchy_MetaVelvet_issues.md](./references/github_com_hacchy_MetaVelvet_issues.md)