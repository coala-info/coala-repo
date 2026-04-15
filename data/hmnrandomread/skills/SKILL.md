---
name: hmnrandomread
description: hmnrandomread is a high-performance sequence-read simulator that generates synthetic paired-end NGS data from reference genomes. Use when user asks to simulate sequencing reads, create synthetic datasets with specific error profiles, or model biological variation and library geometry.
homepage: https://github.com/guillaume-gricourt/HmnRandomRead
metadata:
  docker_image: "quay.io/biocontainers/hmnrandomread:0.10.0--h9948957_4"
---

# hmnrandomread

## Overview
`hmnrandomread` is a high-performance sequence-read simulator designed to produce synthetic NGS data. It transforms reference genomes into paired-end reads while allowing fine-grained control over library geometry, sequencing errors, and biological variation. It is capable of generating approximately 1,000 sequences per second, making it suitable for creating large-scale test datasets where the ground truth is known.

## Command Line Usage

### Basic Simulation
To generate a standard paired-end library from a single reference:
```bash
HmnRandomRead \
  --reference genome.fasta 1000000 \
  --read-forward reads_R1.fastq.gz \
  --read-reverse reads_R2.fastq.gz
```
*Note: The reference argument requires both the file path and the number of sequences to generate.*

### Adjusting Library Geometry
Control the fragment size distribution and read length to match specific experimental designs:
```bash
HmnRandomRead \
  -r ref.fa 500000 \
  -r1 R1.fq -r2 R2.fq \
  --length-reads 150 \
  --mean-insert-size 400 \
  --std-insert-size 40
```

### Introducing Diversity and Mutations
Use a diversity profile to simulate SNPs and Indels. The profile must be a comma-separated CSV with a mandatory header: `identifier,Mutation Rate,Indel Fraction,Indel Extend,Maximum Insertion Size`.

```bash
HmnRandomRead \
  -r ref.fa 100000 \
  -r1 R1.fq -r2 R2.fq \
  --profile-diversity diversity_params.csv
```

### Modeling Sequencer Errors
Apply specific error rates per cycle using an error profile CSV. The header must include: `identifier,sequencer,flowcell,version,strand,cycles total,error by cycle`.

```bash
HmnRandomRead \
  -r ref.fa 100000 \
  -r1 R1.fq -r2 R2.fq \
  --profile-error error_model.csv \
  --profile-error-id "Illumina_HiSeq_2500"
```

## Expert Tips and Best Practices

- **Reproducibility**: Always specify a seed using `-s` or `--seed` (default is 0) when generating datasets for benchmarking to ensure the same "random" reads are produced across different runs.
- **Multiple References**: You can provide multiple `--reference` flags to simulate reads from a metagenomic sample or a multi-chromosome genome. Each instance must specify its own read count.
- **Output Compression**: The tool supports writing directly to `.gz` files. Use the `.fastq.gz` extension in `-r1` and `-r2` to save disk space without needing a separate pipe to `gzip`.
- **Profile Headers**: The CSV profiles for diversity and error models are strict. Ensure the headers match the documentation exactly, or the tool will fail to parse the parameters.
- **Performance**: Since the tool is written in C and utilizes `htslib`, it is highly efficient. For massive simulations, ensure your I/O throughput (disk write speed) can keep up with the ~1000 reads/sec generation rate.

## Reference documentation
- [HmnRandomRead Main Documentation](./references/github_com_guillaume-gricourt_HmnRandomRead.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_hmnrandomread_overview.md)