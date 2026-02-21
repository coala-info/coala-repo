---
name: hitea
description: HiTea (Hi-C based Transposable Element Analyzer) is a specialized computational tool designed to detect non-reference transposable element insertions by leveraging the unique properties of Hi-C sequencing data.
homepage: https://github.com/parklab/HiTea
---

# hitea

## Overview

HiTea (Hi-C based Transposable Element Analyzer) is a specialized computational tool designed to detect non-reference transposable element insertions by leveraging the unique properties of Hi-C sequencing data. It utilizes split-read information and read coverage to pinpoint insertions of major active human TE classes. The tool is particularly useful for researchers studying genomic structural variations and mobile element activity using proximity ligation assays.

## Command Line Usage

The primary interface for HiTea is a single-line bash command. It validates dependencies before processing the user-provided alignment files.

### Basic Syntax
```bash
hitea -i "<input_files>" -w <workdir> -e <enzyme> -g <genome> [options]
```

### Common Patterns

**Processing a single BAM file:**
```bash
hitea -i "path/to/sample.bam" -w /absolute/path/to/workdir -o sample_name -g hg38 -e 'MboI' -r 'T'
```

**Processing multiple BAM files for a single experiment:**
```bash
hitea -i 'bam/file1.bam bam/file2.bam bam/file3.bam' -w /absolute/path/to/workdir -o experiment_prefix -g hg38 -e 'HindIII'
```

## Parameters and Configuration

### Required Arguments
- `-i`: Input files. Accepts pairsam format or unsorted-lossless BAM format. Multiple files must be space-separated and enclosed in quotes.
- `-e`: Restriction endonuclease used in the Hi-C assay. Supported: `MboI`, `DpnII`, `HindIII`, `Arima`, `NcoI`, `NotI`.
- `-g`: Genome build. Supported: `hg38` (default), `hg19`.

### Key Options
- `-w`: Working directory. **Critical**: Use a full absolute path to ensure the HTML report generates correctly.
- `-o`: Output prefix for report files (default: `project`).
- `-r`: Remapping toggle (`T` or `F`). Set to `T` to remap unmapped clipped reads to polymorphic sequences for higher sensitivity.
- `-s`: Minimum clip length for detection (default: 20bp, minimum: 13bp).
- `-q`: Mapping quality threshold for the repeat-anchored mate (default: 28).

## Expert Tips and Best Practices

- **Input Preparation**: Ensure BAM files are name-sorted. HiTea relies on `pairtools` for read-type classification; if your BAM lacks classification tags, HiTea will attempt to run `pairtools` internally.
- **Path Management**: Always provide the absolute path for the `-w` (working directory) argument. Relative paths often cause failures in the final R-based HTML report generation phase.
- **Custom Genomes**: While hg19 and hg38 have precomputed files, you can use other assemblies by manually providing the TE-consensus (`-n`), Repbase subfamily (`-b`), and reference copy locations (`-a`).
- **Memory and Parallelism**: HiTea utilizes `GNU-parallel`. Ensure your environment has sufficient cores available, especially when processing multiple input BAMs or enabling the remapping (`-r T`) feature.
- **Dependency Check**: Before a full run, execute `hitea` with no arguments to trigger the dependency check for PERL, R, bedtools, and samtools.

## Reference documentation
- [HiTea GitHub Repository](./references/github_com_parklab_HiTea.md)
- [HiTea Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_hitea_overview.md)