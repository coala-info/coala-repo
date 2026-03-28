---
name: smartdenovo
description: SMARTdenovo is a specialized assembly pipeline designed for the rapid de novo assembly of high-noise long reads without an explicit error-correction step. Use when user asks to assemble long-read sequencing data, generate consensus sequences from raw reads, or perform computationally efficient large genome assembly.
homepage: https://github.com/ruanjue/smartdenovo
---


# smartdenovo

## Overview
SMARTdenovo is a specialized assembly pipeline designed for high-noise long reads. Unlike many other assemblers, it skips the explicit error-correction step, instead relying on a robust all-vs-all overlapping strategy and a final consensus generation phase. It is particularly effective for rapid assembly of large genomes where computational efficiency is required. The tool operates by generating a Makefile that orchestrates several sub-tools (wtzmo, wtobt, wtgbo, etc.) to produce raw unitigs and polished consensus sequences.

## Basic Usage
The standard workflow involves generating a Makefile and then executing it using `make`.

```bash
# 1. Generate the assembly Makefile
smartdenovo.pl -p my_assembly -c 1 reads.fa > my_assembly.mak

# 2. Run the assembly pipeline
make -f my_assembly.mak
```

### Key Output Files
- `prefix.lay.utg`: Raw unitig sequences.
- `prefix.cns`: Consensus unitig sequences (generated if `-c 1` is used).

## Command Line Options for smartdenovo.pl
- `-p STR`: Output prefix (default: wtasm).
- `-t INT`: Number of threads (default: 8).
- `-c INT`: Generate consensus (0: no, 1: yes; default: 0).
- `-J INT`: Minimum read length (default: 5000).
- `-e STR`: Engine for overlapping (zmo or dmo; default: zmo).

## Expert Tips and Best Practices

### Using the Dot Matrix Overlapper (DMO)
For very long reads or specific datasets where Smith-Waterman alignment is a bottleneck, use the "dot matrix alignment" algorithm. This is Smith-Waterman free and can be significantly faster.
- Add `-U -1 -m 0.1` to the `wtzmo` parameters or use the `run_dmo.sh` template for E. coli or Yeast datasets.

### Memory Management for Large Genomes
The overlapper `wtzmo` can consume significant memory. For large genomes, use the `-G` option to split the kmer-index into parts:
- `wtzmo -G 4 ...`: Reduces memory usage to approximately 1/4 by processing the index in 4 parts.

### Parallelization Across Nodes
To run `wtzmo` across a cluster:
- Use `-P <total_nodes> -p <node_index>`.
- Example for node 1 of 60: `wtzmo -P 60 -p 0 ...`

### Tuning Overlaps (wtzmo)
- **Homopolymer Compression**: Enabled by default. Use `-H 0` to disable if working with data where homopolymer lengths are critical.
- **K-mer Frequency**: Use `-K 500` to discard high-frequency kmers (repeats) that slow down the overlapping process.
- **Alignment Sensitivity**: Adjust `-w` (initial band width) and `-W` (max band width) to control the trade-off between speed and sensitivity in gap-heavy regions.

### Read Trimming and Chimera Detection (wtobt)
`wtobt` is used to trim reads based on overlap evidence. It detects "spurs" and chimeric joins by analyzing read coverage and crossing overlaps.
- Use `wtobt -i reads.fa -j overlaps.ovl -o trimmed.obt -c 2` to generate a read mask file.



## Subcommands

| Command | Description |
|---------|-------------|
| smartdenovo.pl | Smartdenovo is a de novo assembler for long reads. |
| wtclp | Maximizing legal overlap by clipping long reads |
| wtcns | Consensus caller |
| wtgbo | Overlapper based on overlap graph |
| wtmsa | Consensus caller using POA |
| wtzmo | Overlaper of long reads using homopolymer compressed k-mer seeding |

## Reference documentation
- [SMARTdenovo Main README](./references/github_com_ruanjue_smartdenovo_blob_master_README.md)
- [Detailed Tool Documentation (wtzmo, wtobt, etc.)](./references/github_com_ruanjue_smartdenovo_blob_master_README-tools.md)
- [Makefile Configuration](./references/github_com_ruanjue_smartdenovo_blob_master_Makefile.md)