---
name: rustyread
description: "rustyread is a high-performance long-read simulator that generates synthetic sequencing reads from a reference genome. Use when user asks to simulate long reads, generate synthetic Nanopore data, or create reads with specific error profiles and fragment lengths."
homepage: https://github.com/natir/rustyread
---


# rustyread

## Overview

`rustyread` is a high-performance long-read simulator written in Rust. It is designed as a drop-in replacement for `badread simulate`, utilizing the same error and quality models while providing significant speed improvements through multi-threading. It allows researchers to generate synthetic long reads with fine-grained control over fragment length distributions, sequencing identity, and various artifacts like chimeras, glitches, and adapters.

## Core CLI Usage

The primary command is `simulate`. By default, `rustyread` uses all available CPU cores.

### Basic Simulation
Generate a specific quantity of reads from a reference FASTA:
```bash
rustyread simulate --reference genome.fasta --quantity 500M > simulated_reads.fastq
```

### Controlling Output Quantity
The `--quantity` flag accepts both absolute values and relative coverage:
- **Absolute**: `--quantity 1G` (1 Gigabase) or `--quantity 500M` (500 Megabases).
- **Relative**: `--quantity 30x` (Generates reads equivalent to 30x coverage of the reference).

### Performance and Threading
Global options must be placed before the `simulate` subcommand:
```bash
# Limit to 4 threads
rustyread --threads 4 simulate --reference ref.fa --quantity 10x > output.fastq
```

## Advanced Configuration

### Memory Management
For large genomes or high-depth simulations, manage RAM usage with `--number_base_store`. This limits how many bases are kept in memory before being flushed to the output.
```bash
# Limit memory by storing only 250M bases at a time
rustyread simulate --reference ref.fa --quantity 100x --number_base_store 250M > output.fastq
```

### Error and Quality Profiles
`rustyread` defaults to the `nanopore2020` model. You can specify custom models or adjust identity parameters:
- **Custom Models**: `--error_model path/to/model` and `--qscore_model path/to/model`.
- **Identity**: `--identity 85,95,5` (Mean, Max, and Standard Deviation).

### Fragment and Artifact Control
- **Length**: `--length 15000,13000` (Mean and Standard Deviation).
- **Chimeras**: `--chimera 1.5` (Percentage of reads that are chimeric).
- **Junk/Random**: `--junk_reads 1` and `--random_reads 1` (Percentage of low-complexity or random sequences).
- **Adapters**: Adjust `--start_adapter` and `--end_adapter` (Rate and Amount) or provide custom sequences with `--start_adapter_seq`.

### Reproducibility
To ensure the same reads are generated across different runs, always provide a seed:
```bash
rustyread simulate --reference ref.fa --quantity 10x --seed 42 > reproducible_reads.fastq
```

## Expert Tips
- **Input Compression**: The `--reference` flag natively supports gzipped (`.gz`), bzip2ped (`.bz2`), and xzped (`.xz`) FASTA files.
- **Drop-in Compatibility**: If you have `badread` installed in your Python environment, `rustyread` can automatically locate and use the standard `badread` error and quality models without manual path specification.
- **Small Plasmids**: If simulating a genome with small circular plasmids, be aware that `rustyread` includes them regardless of fragment length unless the `--small_plasmid_bias` flag is used (though note that in current versions, this flag may be ignored as small plasmids are sequenced by default).



## Subcommands

| Command | Description |
|---------|-------------|
| rustyread | A long read simulator based on badread idea and model |
| simulate | Generate fake long read |

## Reference documentation
- [Rustyread Main Readme](./references/github_com_natir_rustyread_blob_master_Readme.md)
- [Rustyread Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_rustyread_overview.md)