---
name: kalign
description: Kalign performs fast and efficient multiple sequence alignment for biological sequences using SIMD optimizations and multi-threading. Use when user asks to align multiple protein or nucleotide sequences, convert sequence alignment formats, or perform large-scale sequence alignments via command line or Python.
homepage: https://github.com/TimoLassmann/kalign
---


# kalign

## Overview
Kalign is a specialized tool for aligning multiple biological sequences with a focus on speed and efficiency. It utilizes SIMD (Single Instruction, Multiple Data) optimizations and multi-threading to handle large-scale sequence data rapidly. Whether working with highly conserved proteins or divergent nucleotide sequences, Kalign provides a robust command-line interface and Python API to generate accurate alignments in several standard formats.

## Command Line Usage

### Basic Alignment
The most common usage involves specifying an input file and an output destination:
```bash
kalign -i sequences.fasta -o aligned.fasta
```

### Specifying Sequence Types
While Kalign attempts to auto-detect sequence types, manual overrides ensure the correct substitution matrices and gap penalties are applied:
- **Protein**: `--type protein` (Uses CorBLOSUM66)
- **Divergent Protein**: `--type divergent` (Uses Gonnet 250 for highly dissimilar sequences)
- **DNA**: `--type dna`
- **RNA**: `--type rna`
- **Internal DNA**: `--type internal` (Encourages internal gaps by increasing terminal gap penalties)

### Output Formats
Kalign supports several standard bioinformatics formats via the `--format` flag:
- **FASTA**: `-f fasta` (Default)
- **Clustal**: `-f clu`
- **MSF**: `-f msf`
- **Stockholm**: `-f stockholm`
- **PHYLIP**: `-f phylip`

### Threading and Performance
Kalign auto-detects CPU cores and uses $N-1$ threads by default (capped at 16).
- **Manual Control**: Use `-n` or `--nthreads` to set a specific count.
- **Single-threaded**: Use `-n 1` to disable parallelization for debugging or specific environment constraints.

## Common Patterns and Tips

### Piping and Redirection
Kalign can read from standard input, making it easy to integrate into shell pipelines:
```bash
cat input.fa | kalign -f fasta > output.afa
```

### Combining Multiple Files
You can pass multiple input files to be combined and aligned into a single output:
```bash
kalign seqsA.fa seqsB.fa seqsC.fa -f fasta > combined.afa
```

### Fine-tuning Gap Penalties
For specific alignment needs, you can manually adjust the penalty scores:
- `--gpo`: Gap open penalty
- `--gpe`: Gap extension penalty
- `--tgpe`: Terminal gap extension penalty

### Re-aligning Existing Alignments
If you provide a pre-aligned file (e.g., a Clustal file), Kalign will automatically remove existing gaps and re-align the sequences.

## Python API
If working within a Python environment, use the `kalign` package for direct integration:
```python
import kalign

sequences = ["ATCGATCGATCG", "ATCGTCGATCG", "ATCGATCATCG"]
aligned = kalign.align(sequences, seq_type="dna")

for seq in aligned:
    print(seq)
```

## Reference documentation
- [Kalign Main Documentation](./references/github_com_TimoLassmann_kalign.md)