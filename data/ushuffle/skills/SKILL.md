---
name: ushuffle
description: "ushuffle randomizes biological sequences while preserving k-mer counts. Use when user asks to shuffle DNA, RNA, or protein sequences while preserving k-mer counts."
homepage: http://digital.cs.usu.edu/~mjiang/ushuffle/
---


# ushuffle

ushuffle/
├── SKILL.md
└── references/
    └── anaconda_org_channels_bioconda_packages_ushuffle_overview.md
```
ushuffle/SKILL.md:
```yaml
name: ushuffle
description: |
  Shuffles biological sequences while preserving k-let counts. Use when Claude needs to randomize DNA, RNA, or protein sequences for simulation, testing, or analysis, ensuring that the frequency of short subsequences (k-mers) remains consistent with the original sequence. This is particularly useful for null hypothesis testing in bioinformatics.
```
```markdown
## Overview
ushuffle is a command-line tool designed to randomize biological sequences (DNA, RNA, or protein) while strictly preserving the counts of all possible k-mers (subsequences of length k). This is crucial for generating null models in sequence analysis, where you need to shuffle sequences in a way that maintains specific statistical properties of the original data, such as the frequency of dinucleotides, trinucleotides, etc.

## Usage Instructions

ushuffle operates by taking a sequence as input and outputting a shuffled version. The primary control is the `k` parameter, which defines the length of the subsequences whose counts must be preserved.

### Basic Usage

The most common way to use `ushuffle` is to provide the input sequence and specify the `k` value.

**Command Structure:**

```bash
ushuffle -k <k_value> < input_sequence.fasta > output_sequence.fasta
```

*   `-k <k_value>`: Specifies the size of the k-mer to preserve. For example, `-k 2` preserves dinucleotide counts, `-k 3` preserves trinucleotide counts.
*   `< input_sequence.fasta`: Reads the input sequence from standard input. This can be a FASTA file or a plain sequence.
*   `> output_sequence.fasta`: Writes the shuffled sequence to standard output, typically redirected to a file.

### Example: Preserving Dinucleotide Counts

To shuffle a DNA sequence and preserve all dinucleotide counts:

```bash
ushuffle -k 2 < dna_sequence.txt > shuffled_dna_sequence.txt
```

### Example: Preserving Trinucleotide Counts

To shuffle a protein sequence and preserve all trinucleotide counts:

```bash
ushuffle -k 3 < protein_sequence.fasta > shuffled_protein_sequence.fasta
```

### Input Formats

`ushuffle` can accept sequences in plain text format or FASTA format. If using FASTA, it will process the sequence part and output a shuffled sequence, typically without the FASTA header unless the input was structured to include it. For simplicity, it's often best to extract just the sequence data before piping it to `ushuffle` and then reformat if necessary.

### Expert Tips

*   **Choosing `k`**: The choice of `k` depends on the biological context and the specific statistical properties you wish to preserve. For DNA, `k=2` (dinucleotides) and `k=3` (trinucleotides) are common. For proteins, `k=2` or `k=3` are also frequently used.
*   **Large Sequences**: For very large sequences, `ushuffle` can be computationally intensive. Ensure your system has sufficient memory and processing power.
*   **Multiple Sequences**: If you have multiple sequences in a file, you will need to process them individually or use scripting to loop through them and apply `ushuffle` to each.
*   **FASTA Handling**: When working with FASTA files containing multiple sequences or headers, it's often more robust to use a dedicated FASTA parsing tool to extract only the sequence data before piping it to `ushuffle`, and then reconstruct the FASTA output if needed.

## Reference documentation
- [ushuffle Overview](./references/anaconda_org_channels_bioconda_packages_ushuffle_overview.md)