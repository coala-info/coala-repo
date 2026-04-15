---
name: kalign3
description: Kalign3 is a high-performance tool for fast and efficient multiple sequence alignment of protein, DNA, and RNA sequences. Use when user asks to align multiple biological sequences, perform large-scale sequence alignments, or convert sequence files into formats like Clustal, MSF, or Stockholm.
homepage: https://github.com/TimoLassmann/kalign
metadata:
  docker_image: "quay.io/biocontainers/kalign3:3.4.0--h503566f_2"
---

# kalign3

## Overview
Kalign3 is a high-performance multiple sequence alignment tool optimized for speed and efficiency. It leverages SIMD (Single Instruction, Multiple Data) vectorization and intelligent multi-threading to process large datasets significantly faster than many traditional aligners. It is particularly effective for aligning protein, DNA, and RNA sequences, offering specialized parameters for divergent sequences and specific nucleic acid types.

## Command Line Interface (CLI) Usage

### Basic Alignment
The simplest way to run kalign3 is by providing an input file and specifying an output file.
```bash
kalign -i sequences.fasta -o aligned.fasta
```

### Handling Multiple Input Files
Kalign can combine and align sequences from multiple files into a single output.
```bash
kalign seqsA.fa seqsB.fa seqsC.fa -f fasta > combined_aligned.fasta
```

### Specifying Sequence Types
While kalign3 attempts to auto-detect sequence types, manual overrides ensure the correct substitution matrices and gap penalties are applied:
- **Protein**: `--type protein` (Uses CorBLOSUM66_13plus)
- **Divergent Protein**: `--type divergent` (Uses Gonnet 250 for highly dissimilar sequences)
- **DNA**: `--type dna`
- **RNA**: `--type rna`
- **Internal DNA**: `--type internal` (Encourages internal gaps by increasing terminal gap penalties)

### Output Formats
Specify the desired alignment format using the `--format` flag:
- **FASTA**: `-f fasta` (Default)
- **Clustal**: `-f clu`
- **MSF**: `-f msf`
- **Stockholm**: `-f stockholm`
- **PHYLIP**: `-f phylip`

## Performance and Threading

### Thread Management
Kalign3 auto-detects CPU cores and uses **N-1 threads** by default (up to a maximum of 16) to maintain system responsiveness.
- **Manual Override**: Use `-n` or `--nthreads` to set a specific count.
  ```bash
  kalign -i input.fa -o output.fa -n 8
  ```
- **Single-threaded Mode**: Use `-n 1` for debugging or when running in environments with strict resource limits.

### Piping and Redirection
Kalign3 supports standard streams, making it easy to integrate into shell pipelines.
```bash
cat input.fa | kalign -f fasta > output.afa
```

## Expert Tips and Best Practices

- **Re-aligning Existing Alignments**: If you provide a pre-aligned file (FASTA, MSF, or Clustal), kalign3 will automatically remove existing gaps and re-align the sequences from scratch.
- **Gap Penalty Fine-tuning**: For non-standard datasets, manually adjust penalties:
  - `--gpo`: Gap open penalty.
  - `--gpe`: Gap extension penalty.
  - `--tgpe`: Terminal gap extension penalty.
- **Large-scale Proteomics**: When dealing with highly divergent protein families, always use `--type divergent` to improve alignment accuracy at the cost of slight computational overhead.
- **Memory Efficiency**: Kalign3 is designed to be memory-efficient, but for extremely large datasets (thousands of long sequences), ensure your environment has sufficient RAM as MSA is inherently memory-intensive.

## Reference documentation
- [Kalign GitHub Repository](./references/github_com_TimoLassmann_kalign.md)
- [Kalign3 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_kalign3_overview.md)