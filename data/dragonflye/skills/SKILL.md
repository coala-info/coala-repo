---
name: dragonflye
description: Dragonflye is a comprehensive microbial assembly pipeline specifically optimized for Oxford Nanopore Technologies (ONT) data.
homepage: https://github.com/rpetit3/dragonflye
---

# dragonflye

## Overview

Dragonflye is a comprehensive microbial assembly pipeline specifically optimized for Oxford Nanopore Technologies (ONT) data. Built on the design philosophy of Shovill, it provides a "batteries-included" approach to bacterial genome assembly. The tool automates the complex sequence of events required to produce high-quality circularized or near-complete genomes, including read length filtering, depth reduction to manageable levels, assembly, and multiple rounds of polishing (Racon, Medaka, Pilon, or Polypolish). It also handles final contig cleaning and reorientation to ensure the output is ready for downstream analysis.

## Usage Patterns

### Basic Assembly
The most common usage requires only the input reads, an output directory, and an estimated genome size.
```bash
dragonflye --reads reads.fastq.gz --outdir assembly_results --gsize 5M
```

### Hybrid Polishing
If Illumina short reads are available, they can be used to significantly improve the consensus accuracy of the Nanopore assembly.
```bash
dragonflye --reads ont_reads.fastq.gz --R1 illumina_R1.fq.gz --R2 illumina_R2.fq.gz --outdir hybrid_assembly --gsize 4.0M
```

### Selecting Assemblers and Polishers
While Flye is the default, you can switch to Raven or Miniasm depending on your speed and accuracy requirements.
```bash
# Using Raven with 2 rounds of Racon polishing
dragonflye --reads reads.fq.gz --outdir raven_out --assembler raven --racon 2 --gsize 3.5M

# Using Medaka polishing (requires specifying the model)
dragonflye --reads reads.fq.gz --outdir medaka_out --medaka 1 --model r941_min_high_g360 --gsize 5M
```

## Expert Tips and Best Practices

- **Genome Size (`--gsize`)**: Always provide an estimated genome size if known. This parameter is used by `rasusa` to downsample reads to a specific depth (default 150x), which prevents excessive memory usage and speeds up the assembly without sacrificing quality.
- **Read Filtering**: By default, dragonflye filters out reads shorter than 1000bp (`--minreadlen 1000`). For highly fragmented libraries, you may need to lower this, though it may impact assembly contiguity.
- **High-Quality Reads**: If using newer ONT chemistry (e.g., Q20+), use the `--nanohq` flag when the assembler is set to `flye` to utilize the `--nano-hq` mode.
- **Contig Reorientation**: Dragonflye uses `dnaapler` by default to reorient contigs (e.g., starting at *dnaA*). If you prefer the raw output from the assembler, use `--noreorient`.
- **Resource Management**: Use `--cpus` and `--ram` to limit resource consumption in shared environments. The pipeline is generally memory-efficient due to the initial subsampling step.
- **Adapter Trimming**: Trimming is not enabled by default. Use `--trim` to invoke `Porechop` for adapter removal if your reads haven't been pre-processed.

## Reference documentation
- [Dragonflye GitHub Repository](./references/github_com_rpetit3_dragonflye.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_dragonflye_overview.md)