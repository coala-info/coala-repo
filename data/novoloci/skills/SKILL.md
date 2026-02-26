---
name: novoloci
description: NOVOLoci is a specialized assembly tool designed to reconstruct individual haplotypes and phase small genomes or specific genomic targets using long-read data. Use when user asks to perform targeted assembly using a seed sequence, reconstruct haplotypes from Nanopore or PacBio reads, or assemble small genomes.
homepage: https://github.com/ndierckx/NOVOLoci
---


# novoloci

## Overview

NOVOLoci is a specialized assembly tool designed to handle the complexities of phasing in small genomes and specific genomic targets. It excels at reconstructing individual haplotypes from long-read data. While it supports whole-genome assembly for smaller organisms, its primary strength lies in targeted assembly using a "seed" sequence to anchor the process in complex regions. It is compatible with Nanopore (ONT) and PacBio (HiFi) reads.

## Installation and Environment

The most reliable way to use NOVOLoci is via Conda or Docker to ensure all Perl dependencies (MCE, Parallel::ForkManager) and alignment tools (BLAST, MAFFT) are present.

- **Conda**: `conda install -c bioconda novoloci`
- **Docker**: `docker pull ndierckx/novoloci:latest`
- **Singularity**: `singularity pull docker://ndierckx/novoloci:latest`

## Core Usage Pattern

NOVOLoci is driven by a configuration file. The standard execution command is:

```bash
novoloci -c config.txt
```

If running via Docker:
```bash
docker run --rm -v $(pwd):/data ndierckx/novoloci -c /data/config.txt
```

## Configuration File Best Practices

The configuration file (`config.txt`) must follow a strict format: `Parameter = Value`. 
- **Critical**: Ensure there is exactly one space after the equals sign.
- **Critical**: Every parameter must be on a single line.

### Project Section Tips
- **Assembly length**: Set to `WG` for whole-genome assembly. For targeted regions, provide the expected length in base pairs (e.g., `1000000`).
- **Seed Input**: Required for targeted assembly. The seed should be a FASTA file containing a sequence (at least 500 bp) located *upstream* of the complex region. Do not start the seed within a repetitive or duplicated region.
- **Ploidy**: For highly heterozygous diploid species (>2% heterozygosity), setting `Ploidy = 1` can sometimes improve results.
- **Circular**: Set to `Yes` for chloroplasts or plasmids. You must also provide an `Assembly length` for the circularization logic to trigger.

### Read Input Tips
- **Nanopore/PacBio reads**: Provide the full path to the raw reads for the first run.
- **Local DB**: To save time on subsequent runs using the same dataset, point `Local DB and NP reads` to the output folder of a previous run to reuse the generated BLAST databases.
- **Min read length**: Default is 1000 for ONT and 500 for PacBio. Increase this if the region is highly repetitive to force the use of more informative long reads.

## Expert Tips for Complex Regions

1. **Depth Requirements**: Ensure a minimum sequencing depth of 10x per haplotype. If depth is lower, the assembler may fail to phase correctly.
2. **Targeted Anchoring**: If a targeted assembly fails to extend, try a different seed sequence further away from the complex region to ensure the assembler has a "clean" starting point.
3. **Resource Allocation**: Always specify the maximum available `Threads`. NOVOLoci relies heavily on parallel processing for BLAST and MAFFT operations.
4. **Tool Selection**: If you are working with high-accuracy HiFi or R10 ONT data and require faster runtimes for whole genomes, `hifiasm` is a recommended alternative. NOVOLoci is preferred when specific targeted phasing of complex loci is the priority.

## Reference documentation
- [NOVOLoci GitHub Repository](./references/github_com_ndierckx_NOVOLoci.md)
- [Bioconda NOVOLoci Overview](./references/anaconda_org_channels_bioconda_packages_novoloci_overview.md)