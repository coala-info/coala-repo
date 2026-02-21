---
name: pypolca
description: pypolca is a standalone Python re-implementation of the POLCA (POLishing by Calling Alternatives) polisher originally from the MaSuRCA toolkit.
homepage: https://github.com/gbouras13/pypolca
---

# pypolca

## Overview
pypolca is a standalone Python re-implementation of the POLCA (POLishing by Calling Alternatives) polisher originally from the MaSuRCA toolkit. It is optimized for polishing bacterial genome assemblies generated from long-read technologies (like Oxford Nanopore) using high-accuracy short reads. It identifies and corrects small insertions, deletions, and substitutions by mapping reads and calling variants with Freebayes.

## Core Workflows

### Standard Polishing (Paired-End)
The most common use case involves polishing a draft assembly with paired-end Illumina reads.
```bash
pypolca run -a assembly.fasta -1 reads_R1.fastq.gz -2 reads_R2.fastq.gz -t 8 -o output_dir --careful
```

### Single-End Polishing
If only one read file is available, omit the `-2` parameter.
```bash
pypolca run -a assembly.fasta -1 single_reads.fastq.gz -t 4 -o output_dir
```

### Assembly Evaluation Only
To generate a VCF of potential errors without actually modifying the assembly file, use the `--no_polish` flag.
```bash
pypolca run -a assembly.fasta -1 R1.fq -2 R2.fq --no_polish
```

## Expert Tips and Best Practices

### The --careful Flag
Always use the `--careful` flag for bacterial isolate polishing. This setting is more stringent than the defaults, requiring:
- At least 4 reads to support an alternative allele.
- A minimum ratio of 3:1 (alternative vs. reference allele).
This significantly reduces false positives in low-depth regions without sacrificing sensitivity for real errors.

### Homopolymer-Only Mode
If the assembly is known to have specific issues with homopolymer lengths (common in certain long-read technologies), use the `--homopolymers` flag to restrict corrections.
- Example: `--homopolymers 5` will only apply changes to homopolymer runs of length 5 or greater.

### Resource Management
- **Threads**: Use the `-t` flag to specify CPU cores. Note that pypolca does not implement the batched multiprocessing of the original POLCA, so it may be slower on very large (eukaryotic) genomes.
- **Memory**: Use `-m` to set the memory limit per thread for Samtools (e.g., `-m 2G`).
- **Overwriting**: Use `-f` or `--force` if the output directory already exists and you wish to overwrite it.

### Dependencies
pypolca relies on external binaries. Ensure the following are available in your environment:
- `bwa` (>= 0.7.17)
- `samtools` (>= 1.18)
- `freebayes` (>= 1.3.9)

## Reference documentation
- [github_com_gbouras13_pypolca.md](./references/github_com_gbouras13_pypolca.md)
- [anaconda_org_channels_bioconda_packages_pypolca_overview.md](./references/anaconda_org_channels_bioconda_packages_pypolca_overview.md)