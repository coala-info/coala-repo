---
name: tidehunter
description: TideHunter is a high-performance tool designed to identify tandemly repeated sequences and call consensus sequences from long-read genomic data.
homepage: https://github.com/yangao07/TideHunter
---

# tidehunter

## Overview

TideHunter is a high-performance tool designed to identify tandemly repeated sequences and call consensus sequences from long-read genomic data. It utilizes an efficient seed-and-chain algorithm that remains robust even in the presence of high sequencing error rates. Use this skill to extract high-quality consensus sequences from repetitive reads, identify individual repeat units, or find full-length sequences flanked by specific adapters.

## Command Line Usage

### Basic Consensus Generation
The default output is a FASTA file containing the consensus sequences of detected tandem repeats.
```bash
TideHunter input.fq > consensus.fa
```

### Output Formats
Control the output type using the `-f` flag:
- **FASTA (Default):** `-f 1`
- **Tabular:** `-f 2` (Provides coordinates, period size, copy number, and divergence)
- **FASTQ:** `-f 3` (Includes quality scores based on consensus coverage)
- **Tabular with Quality:** `-f 4`

### Working with Adapters (Full-Length Sequences)
To identify full-length sequences that are flanked by specific 5' and 3' adapters:
```bash
TideHunter -5 5prime.fa -3 3prime.fa input.fa > full_length_cons.fa
```
*   Use `-F` to **only** output full-length consensus sequences.
*   Use `-s` to output additional single-copy full-length sequences when adapters are found but tandem repeats are not necessarily present.

### Extracting Unit Sequences
If you need the individual repeat units rather than just the consensus:
```bash
TideHunter -u input.fa > units.fa
```

## Optimization and Best Practices

### Handling Noisy Data
- **Homopolymers:** For Oxford Nanopore (ONT) data, enable homopolymer-compressed k-mers using `-H` to improve sensitivity.
- **K-mer Length:** The default k-mer length is 8 (`-k 8`). For very noisy reads, decreasing this may increase sensitivity at the cost of speed.
- **Divergence:** Adjust `-e` (default 0.25) to allow for higher or lower divergence between consecutive repeat units.

### Filtering Criteria
- **Copy Number:** Use `-c` to set the minimum number of copies required to report a repeat (default is 2).
- **Period Size:** Use `-p` (min) and `-P` (max) to restrict the search to specific repeat sizes. The default range is 30bp to 10kbp.
- **Longest Only:** Use `-l` to only output the consensus of the tandem repeat that covers the longest portion of the read, which is useful for filtering out sub-repeats.

### Performance
- **Multi-threading:** TideHunter is multi-threaded. Use `-t` to specify the number of CPU threads (default is 4).
- **Minimizers:** For large period sizes or very long reads, enable minimizer seeding by setting the window size `-w` to a value greater than 1.

## Reference documentation
- [TideHunter GitHub Repository](./references/github_com_yangao07_TideHunter.md)
- [Bioconda TideHunter Overview](./references/anaconda_org_channels_bioconda_packages_tidehunter_overview.md)