---
name: genmap
description: "GenMap computes (k, e)-mappability to identify unique and repetitive regions within genomic sequences. Use when user asks to build genomic indices, compute k-mer mappability, or generate bedGraph files for sequence uniqueness analysis."
homepage: https://github.com/cpockrandt/genmap
---


# genmap

## Overview
GenMap is a specialized bioinformatics tool designed to compute (k, e)-mappability, which represents the reciprocal of how often a k-mer of length *k* occurs in a genome with up to *e* mismatches. A mappability value of 1 indicates a unique sequence, while lower values signify repetitive regions. This skill provides the procedural knowledge to build genomic indices and execute mappability calculations efficiently using GenMap's command-line interface.

## Installation and Setup
GenMap is most easily installed via Bioconda:
```bash
conda install -c bioconda genmap
```
Note: The CPU must support the POPCNT instruction. For a 10% performance boost on modern CPUs, ensure SSE4 support is available.

## Core Workflow

### 1. Building the Index
Before computing mappability, you must index the FASTA file(s). This is a one-time operation per genome.

```bash
genmap index -F /path/to/genome.fasta -I /path/to/index_folder
```

**Expert Tips for Indexing:**
- **Algorithm Selection (`-A`)**: 
    - Use `divsufsort` (default) for speed. It requires ~6n RAM for files < 2GB and ~10n for larger files.
    - Use `skew` if RAM is limited; it uses more disk space (~25n) but significantly less RAM.
- **Memory Reduction (`-S`)**: Increase the sampling value (e.g., `-S 20`, up to 64) to reduce the index size and RAM usage at the cost of slower mappability computation later.
- **Multiple Genomes**: To index an entire directory of FASTA files, use `-FD /path/to/directory`.

### 2. Computing Mappability
Calculate the (k, e)-mappability by referencing the created index.

```bash
genmap map -K 30 -E 2 -I /path/to/index_folder -O /path/to/output_folder -t -w -bg
```

**Parameter Guide:**
- `-K`: k-mer length.
- `-E`: Number of allowed mismatches (errors).
- `-O`: Output directory.
- **Output Formats**:
    - `-t`: Text file (.map)
    - `-w`: Wig file (for genome browsers)
    - `-bg`: bedGraph file (recommended for most downstream analysis)
    - `-csv`: Detailed CSV listing every location a k-mer maps to.

## Advanced CLI Patterns

### Frequency vs. Mappability
To output the absolute frequency (count) of k-mers instead of the reciprocal mappability value, add the frequency flag:
```bash
genmap map -K 30 -E 2 -I /path/to/index -O /path/to/output -fl
```

### Multi-Genome Analysis
When working with multiple genomes in a single index:
- **Default behavior**: Counts occurrences across all indexed files.
- **Species-specific uniqueness**: Use `--exclude-pseudo` to count a k-mer only once per FASTA file. This is useful for finding k-mers present in *n* different genomes regardless of how many times they repeat within a single genome.

### Strand Specificity
By default, GenMap searches both strands. If you require detailed mapping locations including strand information, use the `--csv` flag. The resulting CSV will contain:
1. Query position (sequence index, position)
2. Plus strand occurrences
3. Minus strand occurrences (if applicable)

## Troubleshooting and Resource Management
- **Memory Peaks**: If `index` fails due to RAM, switch to `-A skew` or increase `-S`.
- **Large Genomes**: For Human GRCh38, expect a memory peak of ~31 GB with `divsufsort`.
- **Alphabet Support**: GenMap supports A, C, G, T/U, and N. Other IUPAC characters are automatically converted to N.



## Subcommands

| Command | Description |
|---------|-------------|
| genmap_index | GenMap is a tool for fast and exact computation of genome mappability and can also be used for multiple genomes, e.g., to search for marker sequences. |
| genmap_map | Tool for computing the mappability/frequency on nucleotide sequences. It supports multi-fasta files with DNA or RNA alphabets (A, C, G, T/U, N). Frequency is the absolute number of occurrences, mappability is the inverse, i.e., 1 / frequency-value. |

## Reference documentation
- [GenMap GitHub README](./references/github_com_cpockrandt_genmap.md)
- [GenMap Wiki Home](./references/github_com_cpockrandt_genmap_wiki.md)