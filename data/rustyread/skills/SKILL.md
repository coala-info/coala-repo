---
name: rustyread
description: `rustyread` is a high-performance, multi-threaded long-read simulator designed as a drop-in replacement for `badread simulate`.
homepage: https://github.com/natir/rustyread
---

# rustyread

## Overview

`rustyread` is a high-performance, multi-threaded long-read simulator designed as a drop-in replacement for `badread simulate`. It generates realistic synthetic reads in FASTQ format by applying error and quality models to a reference sequence. Because it is written in Rust, it offers significant speed improvements over Python-based alternatives while maintaining compatibility with existing `badread` error and quality model files.

## Installation

The tool is primarily available via Bioconda or Cargo:

```bash
# Via Conda
conda install -c bioconda rustyread

# Via Cargo (Rust)
cargo install rustyread
```

## Common CLI Patterns

### Basic Simulation
To generate a specific depth of coverage from a reference:
```bash
rustyread simulate --reference genome.fasta --quantity 20x > reads.fastq
```

### Performance Tuning
By default, `rustyread` uses all available CPU cores. To limit resource usage:
```bash
rustyread --threads 4 simulate --reference genome.fasta --quantity 500M > reads.fastq
```

### Customizing Read Geometry
Adjust the fragment length distribution (mean and standard deviation) to match specific library prep results:
```bash
rustyread simulate --reference ref.fa --quantity 10x --length 20000,15000
```

### Controlling Accuracy
Modify the sequencing identity distribution (mean, max, and standard deviation):
```bash
# Simulate high-accuracy reads (95% mean identity)
rustyread simulate --reference ref.fa --quantity 5x --identity 95,99,1
```

### Reproducible Results
Use a seed to ensure the simulator produces the same output across different runs:
```bash
rustyread simulate --reference ref.fa --quantity 1G --seed 42
```

## Expert Tips

### Memory Management
For very large genomes or high-coverage simulations, `rustyread` memory usage can be estimated as `2 * reference base + 2 * targeted base`. To prevent OOM (Out of Memory) errors, use the `--number_base_store` parameter to limit how many bases are kept in RAM before being flushed to disk:
```bash
# Limit RAM storage to 500MB of bases
rustyread simulate --reference large_genome.fa --quantity 50x --number_base_store 500M
```

### Model Selection
If `badread` is installed in your Python environment, `rustyread` will attempt to find the default `nanopore2020` models automatically. If using custom models or if they are not found, specify them explicitly:
```bash
rustyread simulate --reference ref.fa --quantity 10x --error_model /path/to/error_model.txt --qscore_model /path/to/qscore_model.txt
```

### Simulating Noise
You can fine-tune the "messiness" of the data using the noise flags:
- `--junk_reads`: Percentage of low-complexity junk reads (default 1%).
- `--random_reads`: Percentage of completely random sequences (default 1%).
- `--chimera`: Percentage of chimeric reads (default 1%).
- `--glitches`: Parameters for read glitches (rate, size, skip).

## Reference documentation
- [github_com_natir_rustyread.md](./references/github_com_natir_rustyread.md)
- [anaconda_org_channels_bioconda_packages_rustyread_overview.md](./references/anaconda_org_channels_bioconda_packages_rustyread_overview.md)