---
name: genericrepeatfinder
description: Generic Repeat Finder identifies structural repeats like terminal inverted repeats, terminal direct repeats, and MITE candidates within genomic sequences. Use when user asks to find transposable element candidates, detect terminal inverted repeats, or identify terminal direct repeats in a genome.
homepage: https://github.com/bioinfolabmu/GenericRepeatFinder
metadata:
  docker_image: "quay.io/biocontainers/genericrepeatfinder:1.0.2--h9948957_1"
---

# genericrepeatfinder

## Overview
Generic Repeat Finder (GRF) is a specialized C++ toolset for the high-throughput identification of structural repeats within genomic sequences. It is designed to find both perfect and imperfect repeats by allowing for mismatches and indels during the alignment process. The tool is particularly effective at identifying transposable element candidates like MITEs and LTR transposons by searching for their characteristic terminal repeats and target site duplications (TSDs).

## Command Line Usage

The primary executable is `grf-main`. It requires an input FASTA file, an output directory, and a specific analysis mode.

### Mandatory Parameters
- `-i <file>`: Input genome sequence in FASTA format.
- `-c <int>`: Analysis mode:
    - `0`: TIR (Terminal Inverted Repeat) detection.
    - `1`: MITE (Miniature Inverted Repeat Transposable Element) candidate detection.
    - `2`: TDR (Terminal Direct Repeat) detection.
- `-o <directory>`: Output directory for results.
- `--min_tr <int>`: Minimum length of the terminal repeat.

### Common Analysis Patterns

**1. Detecting Terminal Inverted Repeats (TIRs)**
To find TIRs with a minimum repeat length of 10bp using 8 threads:
```bash
grf-main -i genome.fa -o ./tir_results -c 0 --min_tr 10 -t 8
```

**2. Detecting MITE Candidates**
MITE detection requires CD-HIT to be installed and available in your PATH.
```bash
grf-main -i genome.fa -o ./mite_results -c 1 --min_tr 10 --min_tsd 2 --max_tsd 10
```

**3. Detecting Terminal Direct Repeats (TDRs)**
```bash
grf-main -i genome.fa -o ./tdr_results -c 2 --min_tr 15
```

### Advanced Filtering and Sensitivity
- **Mismatches and Indels**: By default, these are unlimited (-1). To increase stringency for imperfect repeats, set specific limits:
  - `--max_mismatch 4`: Allow a maximum of 4 mismatches in the repeat.
  - `--max_indel 2`: Allow a maximum of 2 indels in the repeat.
  - `-p 10`: Maximum percentage of unpaired nucleotides allowed (default 10).
- **Seed Parameters**: GRF uses a seed-and-extend approach.
  - `-s <int>`: Seed length (default 10, must be >= 5).
  - `--seed_mismatch <int>`: Mismatches allowed in the seed region (default 1).
- **Spacing**:
  - `--min_space` / `--max_space`: Control the distance between the two seed regions (the internal sequence of the repeat element).

## Expert Tips and Best Practices
- **Performance**: Always use the `-t` flag to specify the number of threads, as GRF is optimized with OpenMP for parallel processing.
- **Output Formats**: Use `-f 1` if you only need a list of IDs; the default `-f 0` provides full FASTA sequences of the detected repeats.
- **MITE Detection**: When searching for MITEs, the `--min_tsd` and `--max_tsd` parameters are critical. For example, if targeting Tc1/Mariner-like elements, ensure `--min_tsd 2` and `--max_tsd 2` are considered if you want to be specific to "TA" TSDs.
- **Memory Management**: For very large genomes, ensure the output directory is on a volume with sufficient space, as the "imperfect" repeat files can become quite large depending on the mismatch settings.
- **Environment**: If running in a high-performance computing environment, you can control the OpenMP scheduling strategy by setting the `OMP_SCHEDULE` environment variable before execution.

## Reference documentation
- [Generic Repeat Finder GitHub Repository](./references/github_com_bioinfolabmu_GenericRepeatFinder.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_genericrepeatfinder_overview.md)