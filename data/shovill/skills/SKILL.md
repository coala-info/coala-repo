---
name: shovill
description: Shovill is an assembly pipeline that optimizes the assembly of small, haploid microbial genomes by wrapping SPAdes and other assemblers with pre- and post-processing steps. Use when user asks to assemble bacterial isolates, perform de novo assembly of microbial reads, or generate high-quality contigs with optimized memory and speed.
homepage: https://github.com/tseemann/shovill
---


# shovill

## Overview

Shovill is a specialized assembly pipeline designed for small, haploid microbial genomes. It wraps the SPAdes assembler (and others) with optimized pre-processing and post-processing steps to produce high-quality contigs faster and with less memory than raw SPAdes. It automates tasks such as genome size estimation, read subsampling (defaulting to 150x depth), adapter trimming, and assembly polishing.

**Note:** Shovill is intended for isolate data only. It is not suitable for metagenomes or large eukaryotic genomes.

## Usage Patterns

### Basic Assembly
The most common usage requires only the forward and reverse reads and an output directory.
```bash
shovill --outdir assembly_results --R1 reads_R1.fastq.gz --R2 reads_R2.fastq.gz
```

### Specifying Genome Size
While Shovill can autodetect genome size using Mash, providing it manually ensures more accurate read subsampling and error correction.
```bash
shovill --gsize 3.2M --outdir out --R1 R1.fq.gz --R2 R2.fq.gz
```

### Selecting an Alternative Assembler
While SPAdes is the default, you can switch to faster or different engines depending on your needs:
*   **SKESA:** Often faster and produces more conservative assemblies.
*   **MEGAHIT:** Very memory efficient.
*   **Velvet:** A classic De Bruijn graph assembler.
```bash
shovill --assembler skesa --outdir out_skesa --R1 R1.fq.gz --R2 R2.fq.gz
```

### Resource Management
In HPC or cloud environments, explicitly set CPU and RAM limits to avoid over-allocation.
```bash
shovill --cpus 16 --ram 32 --outdir out --R1 R1.fq.gz --R2 R2.fq.gz
```

## Expert Tips and Best Practices

*   **Depth Control:** Shovill subsamples reads to 150x by default (`--depth 150`). Increasing this rarely improves the assembly and often introduces noise from sequencing errors. Use `--depth 0` only if you are certain you want to use all available data.
*   **Adapter Trimming:** Trimming is **OFF** by default. If your reads still contain Illumina adapters, always include the `--trim` flag.
*   **Plasmid Assembly:** If you are interested in recovering plasmids, use the `--plasmid` flag. This enables specific plasmid-tracking modes in supported assemblers (like SPAdes).
*   **Contig Filtering:** Shovill automatically removes low-coverage (`--mincov 2`) and short contigs. You can adjust the minimum length (default is auto-calculated) using `--minlen`.
*   **Output Interpretation:** 
    *   `contigs.fa`: The final, corrected, and filtered assembly. Use this for downstream analysis.
    *   `shovill.log`: Essential for troubleshooting and verifying the parameters used for each sub-tool.
    *   `shovill.corrections`: Lists the post-assembly changes made during the polishing step.

## Reference documentation
- [Shovill GitHub Repository](./references/github_com_tseemann_shovill.md)
- [Shovill Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_shovill_overview.md)