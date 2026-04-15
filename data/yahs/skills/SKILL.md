---
name: yahs
description: YaHS constructs chromosome-scale scaffolds from genomic contigs using Hi-C data. Use when user asks to construct chromosome-scale scaffolds, scaffold genomic contigs, order and orient contigs, or improve genome assembly with Hi-C.
homepage: https://github.com/c-zhou/yahs
metadata:
  docker_image: "quay.io/biocontainers/yahs:1.2.2--he4a0461_0"
---

# yahs

## Overview
YaHS (Yet another Hi-C scaffolding tool) is a high-performance command-line tool designed to construct chromosome-scale scaffolds from genomic contigs. It utilizes a specialized algorithm that analyzes the topological distribution of Hi-C signals to distinguish legitimate interaction signals from mapping noise. It is optimized for speed and accuracy, making it suitable for both small and large-scale genome projects.

## Installation
The tool is available via Bioconda or can be compiled from source:
```bash
# Via Conda
conda install bioconda::yahs

# Via Source
git clone https://github.com/c-zhou/yahs.git
cd yahs
make
```

## Basic Usage
YaHS requires two primary inputs: a FASTA file of contigs and a file containing Hi-C read alignments.

```bash
yahs <contigs.fa> <alignments.bam|bed|bin|pa5>
```

### Input Formats
YaHS automatically detects the input format based on the file extension:
- **.bam**: BAM format (recommended to mark duplicates first).
- **.bed**: BED format (must be sorted by read name).
- **.pa5**: Pair format.
- **.bin**: YaHS-specific binary format (useful for re-runs).

If using a pipe or non-standard extension, specify the type manually:
```bash
yahs --file-type BAM <contigs.fa> <input_stream>
```

## Common CLI Options
- `-o <string>`: Prefix for output files (default: `./yahs.out`).
- `-e <string>`: Specify restriction enzyme(s). Examples:
  - DpnII: `GATC`
  - Arima 2-enzyme: `GATC,GANTC`
  - Arima 4-enzyme: `GATC,GANTC,CTNAG,TTAA`
- `-r <string>`: Comma-separated list of resolutions in ascending order.
- `-R <int>`: Number of rounds to run for each resolution level.
- `-a <file.agp>`: Provide an initial AGP file to use as a starting point for scaffolding.
- `-q <int>`: Minimum mapping quality (default: 10). Note: This is suppressed if the input BAM is not sorted by read name.

## Expert Tips and Best Practices

### BAM Sorting Behaviors
The way your BAM file is sorted changes how YaHS counts Hi-C links:
- **Read-name sorted**: Links are counted between the **middle** positions of read alignments.
- **Coordinate/Unsorted**: Links are counted between the **start** positions of read alignments.
- **Recommendation**: Use read-name sorted BAMs for the most precise link counting and to enable mapping quality filtering (`-q`).

### Handling Fragmented Assemblies
For highly fragmented genomes, the default resolution range might not be sufficient. Try adding smaller resolution values using the `-r` option to capture finer interaction details.

### Performance Optimization
YaHS converts text-based inputs (BAM/BED/PA5) into a binary `.bin` format during the first step. If you need to re-run the scaffolding with different parameters (e.g., changing resolutions or rounds), use the generated `.bin` file as the input to skip the conversion phase and save time.

### Output Interpretation
YaHS produces several files. The most important are:
- `*_scaffolds_final.fa`: The final scaffolded sequences in FASTA format.
- `*_scaffolds_final.agp`: The AGP file describing the structure of the final scaffolds.
- `*_inital_break_00.agp`: AGP file showing initial assembly error corrections (breaks).

## Reference documentation
- [YaHS GitHub Repository](./references/github_com_c-zhou_yahs.md)
- [YaHS Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_yahs_overview.md)