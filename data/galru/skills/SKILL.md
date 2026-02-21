---
name: galru
description: Galru is a specialized bioinformatics tool designed for the rapid identification and strain typing of *Mycobacterium tuberculosis* (Mtb).
homepage: https://github.com/quadram-institute-bioscience/galru
---

# galru

## Overview
Galru is a specialized bioinformatics tool designed for the rapid identification and strain typing of *Mycobacterium tuberculosis* (Mtb). It bypasses the need for high-accuracy read correction or assembly by performing spoligotyping directly on uncorrected long reads. This makes it ideal for clinical and research workflows using Oxford Nanopore (ONT) or Pacific Biosciences (PacBio) platforms, allowing for near real-time typing as sequencing progresses.

## Usage Instructions

### Basic Spoligotyping
To generate a spoligotype from a FASTQ or FASTA file, provide the input file path. The tool outputs a binary string where `1` indicates a spacer is present and `0` indicates it is absent.

```bash
galru input_reads.fastq
```

### Specifying Sequencing Technology
For optimal mapping accuracy, always specify the sequencing technology used. The default is `map-ont`.
- **Oxford Nanopore**: `-y map-ont`
- **PacBio (CLR)**: `-y map-pb`
- **PacBio (CCS/HiFi)**: `-y ava-pb`

```bash
galru -y map-pb input_reads.fastq
```

### Performance and Output Management
- **Multi-threading**: Use the `-t` flag to speed up processing, especially for large datasets.
- **Save to File**: Redirect output to a specific file using `-o`.
- **Extended Results**: Use `-x` to get more detailed information beyond the simple binary string.

```bash
galru -t 8 -o results.txt -x input_reads.fastq.gz
```

### Advanced Filtering and Quality Control
Adjust these parameters if working with low-quality data or if you need stricter validation:
- **Mapping Quality**: Set the minimum mapping quality with `-m` (default: 10).
- **Identity**: Set the minimum BLAST identity with `-i` (default: 95).
- **Bitscore**: Adjust the minimum BLAST bitscore with `-b` (default: 38).

## Expert Tips
- **Input Compatibility**: Galru supports gzipped files (`.fastq.gz`) directly.
- **No Short Reads**: This tool is specifically optimized for long reads; do not use it with Illumina or other short-read data.
- **Assembly Support**: While designed for raw reads, Galru can also be run on assembled contigs to confirm spoligotypes.
- **Species Selection**: While optimized for *M. tuberculosis*, you can check available species databases using the `galru_species` command and specify them with `-s`.
- **OS Limitations**: Galru is designed for Linux and macOS; it is not compatible with Windows.

## Reference documentation
- [galru - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_galru_overview.md)
- [GitHub - quadram-institute-bioscience/galru](./references/github_com_quadram-institute-bioscience_galru.md)