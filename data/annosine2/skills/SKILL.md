---
name: annosine2
description: AnnoSINE_v2 is a specialized bioinformatics tool designed to identify and annotate SINEs within eukaryotic genomes.
homepage: https://github.com/liaoherui/AnnoSINE
---

# annosine2

## Overview

AnnoSINE_v2 is a specialized bioinformatics tool designed to identify and annotate SINEs within eukaryotic genomes. It improves upon the original AnnoSINE workflow by offering a streamlined process that generates high-quality, non-redundant SINE libraries. The tool is essential for researchers working on genome assembly and repeat annotation, as it combines homology-based searches (using HMMER and Dfam) with structure-based identification (detecting Target Site Duplications and Multiple Sequence Alignments).

## Command Line Usage

The primary command for the Bioconda installation is `AnnoSINE_v2`. If using a manual GitHub installation, use `python bin/AnnoSINE_v2`.

### Basic Syntax
```bash
AnnoSINE_v2 [options] <mode> <input_genome.fasta> <output_directory>
```

### Mode Selection
Choose the mode based on the available data and desired sensitivity:
- **Mode 1 (Homology-based)**: Uses HMMER to search against known SINE families. Best when working with well-studied taxa.
- **Mode 2 (Structure-based)**: Identifies SINEs based on structural features like TSDs. Best for discovering novel SINE families.
- **Mode 3 (Hybrid)**: Combines both methods. **Recommended** for most de novo annotation projects to ensure maximum recovery.

## Best Practices and Expert Tips

### Handling Empty Outputs
If the program completes but produces no output or stops prematurely, the default filtering cutoffs may be too strict for your specific genome. Relax the parameters using the following pattern:
- Set `-e 0.01` (HMMER e-value)
- Set `-minc 1` (Minimum copy number)
- Set `-s 150` (Maximum boundary shift)

### Taxonomic Optimization
By default, the tool may not use all available HMM models. Use the `-a` flag to specify the target domain:
- `-a 1`: Use animal HMM files from Dfam.
- `-a 2`: Use both plant and animal HMM files (useful for ambiguous cases or horizontal transfer studies).

### Performance and Resumption
- **Multi-threading**: Use `-t` to specify threads. The default is 36; adjust this based on your HPC environment.
- **Resuming Jobs**: If a run is interrupted, use `-auto 1`. This allows the program to skip finished steps and continue from the last successful checkpoint in the output directory.
- **RepeatMasker**: By default, Step 8 runs RepeatMasker for whole-genome annotation. If you only need the SINE library and want to save time, set `-rpm 0`.

### Key Output Files
- **Non-redundant Library**: `Seed_SINE.fa` (The primary product for downstream annotation).
- **Redundant Library**: `Step7_cluster_output.fasta`.
- **Genome Annotation**: `[input_genome].fasta.out` (Standard RepeatMasker-style output).

## Reference documentation
- [AnnoSINE_v2 GitHub README](./references/github_com_liaoherui_AnnoSINE_v2.md)
- [AnnoSINE_v2 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_annosine2_overview.md)