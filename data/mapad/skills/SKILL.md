---
name: mapad
description: mapad is a bioinformatics tool designed to align short, damaged ancient DNA reads to a reference genome using a probabilistic deamination model. Use when user asks to index a reference genome, map ancient DNA reads, or account for post-mortem DNA damage during alignment.
homepage: https://github.com/mpieva/mapAD
metadata:
  docker_image: "quay.io/biocontainers/mapad:0.45.0--ha96b9cd_1"
---

# mapad

## Overview

mapAD is a high-performance bioinformatics tool designed to address the unique challenges of ancient DNA sequencing. Unlike general-purpose mappers, it incorporates a probabilistic model of post-mortem DNA damage—specifically the deamination of cytosine to uracil, which appears as C-to-T (or G-to-A) substitutions. It utilizes a bidirectional FMD-index and pure backtracking to provide sensitive alignments for short, damaged reads.

## Core Workflows

### 1. Reference Indexing
Before mapping, you must generate the FMD-index files for your reference FASTA. This process creates six auxiliary files (`.tbw`, `.tle`, `.toc`, `.tpi`, `.trt`, `.tsa`).

```bash
mapad index --reference /path/to/reference.fasta
```

### 2. Mapping with Damage Awareness
The `map` command requires specifying the library type and damage parameters to accurately score alignments.

**Basic Mapping Template:**
```bash
mapad -vv map \
  --threads 0 \
  --library <single_stranded|double_stranded> \
  -p 0.03 \
  -f 0.5 \
  -t 0.5 \
  -d 0.02 \
  -s 1.0 \
  --reference /path/to/reference.fasta \
  --reads /path/to/reads.fastq > output.sam
```

## Parameter Optimization

### Damage Model Parameters
*   **`-f` (5' overhang) & `-t` (3' overhang)**: Controls the geometric distribution of overhangs. For double-stranded libraries, `-f` is the generic overhang parameter.
*   **`-s` (Single-stranded deamination)**: The rate of deamination in the overhangs (typically high, e.g., `1.0` for 50% deamination at the very ends).
*   **`-d` (Double-stranded deamination)**: The rate of deamination in the interior double-stranded parts of the fragment (typically low, e.g., `0.01` or `0.02`).
*   **`-p` (Mismatch threshold)**: The allowed mismatch rate under the base error rate `D`. A value of `0.03` is a standard starting point for aDNA.

### Performance Tuning
*   **Threading**: Set `--threads 0` to automatically use all available CPU cores.
*   **SIMD Acceleration**: If compiling from source, use `RUSTFLAGS="-C target-feature=+avx2,+fma"` for significant speedups on modern CPUs.
*   **Verbosity**: Use `-vv` to monitor mapping progress and statistics.

## Expert Tips
*   **Over-specification**: It is generally safer to slightly over-specify damage parameters (e.g., using "50% deamination" settings) than to under-specify them; tests indicate minimal negative impact on accuracy when parameters are higher than the actual damage.
*   **Library Selection**: Ensure `--library` matches your wet-lab protocol (single-stranded vs. double-stranded), as this fundamentally changes how the deamination probabilities $p_C$ and $p_G$ are calculated across the read length.
*   **Memory Management**: For large genomes (like Human hg19/hg38), ensure the system has sufficient RAM to load the FMD-index into memory.



## Subcommands

| Command | Description |
|---------|-------------|
| mapad map | Maps reads to an indexed genome |
| mapad worker | Spawns worker |
| mapad_index | Indexes a genome file |

## Reference documentation
- [mapAD Repository Overview](./references/github_com_mpieva_mapAD_blob_main_Readme.md)
- [Build and Configuration Details](./references/github_com_mpieva_mapAD_blob_main_Cargo.toml.md)