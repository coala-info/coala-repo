---
name: chain2paf
description: chain2paf converts genomic alignments from the CHAIN format into the PAF format. Use when user asks to convert CHAIN files to PAF, generate CIGAR strings for genomic alignments, or transform gap-oriented alignments into sequence-level coordinate formats.
homepage: https://github.com/AndreaGuarracino/chain2paf
metadata:
  docker_image: "quay.io/biocontainers/chain2paf:0.1.1--h3ab6199_0"
---

# chain2paf

## Overview

chain2paf is a high-performance utility written in Rust that transforms genomic alignments from the gap-oriented CHAIN format into the more versatile PAF format. While standard CHAIN files lack sequence-level match/mismatch details, this tool can optionally ingest FASTA files to generate full CIGAR strings, making it a critical bridge for modern comparative genomics pipelines.

## Installation

Install the tool via Bioconda or build from source using Cargo:

```bash
# Via Conda
conda install bioconda::chain2paf

# Via Cargo
git clone https://github.com/AndreaGuarracino/chain2paf
cd chain2paf
cargo install --force --path .
```

## Common CLI Patterns

### Basic Conversion
Perform a straightforward conversion when only the alignment coordinates and gaps are required.
```bash
chain2paf -i input.chain > output.paf
```

### Generating Full CIGAR Strings
To include detailed CIGAR strings (using `=` for matches and `X` for mismatches), provide the target and query FASTA files. The tool supports both uncompressed and bgzipped FASTA files.
```bash
chain2paf -i input.chain -f target.fa.gz query.fa.gz > output.paf
```

### Pairwise Self-Alignment
If the CHAIN file represents an alignment of a genome against itself, specify the same FASTA file for both target and query.
```bash
chain2paf -i input.chain -f genome.fa genome.fa > output.paf
```

## Expert Tips and Best Practices

- **CIGAR Operator Precision**: By default, CHAIN files do not contain enough information to distinguish between matches and mismatches. Always use the `-f` flag with the original sequences if your downstream analysis requires `=` and `X` operators rather than the generic `M` operator.
- **Compressed Inputs**: The tool efficiently handles bgzipped FASTA files, saving disk space and I/O time during large-scale genome conversions.
- **Reverse Operations**: If you need to convert PAF back to CHAIN, use the companion tool `paf2chain`.
- **Coordinate Handling**: Note that chain2paf correctly manages the 0-based/1-based coordinate shifts and strand inversions inherent in the CHAIN format to ensure the resulting PAF file is standard-compliant.

## Reference documentation
- [chain2paf GitHub Repository](./references/github_com_AndreaGuarracino_chain2paf.md)
- [chain2paf Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_chain2paf_overview.md)