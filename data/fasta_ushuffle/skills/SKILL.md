---
name: fasta_ushuffle
description: `fasta_ushuffle` is a command-line utility that wraps the uShuffle library to process FASTA files.
homepage: https://github.com/agordon/fasta_ushuffle
---

# fasta_ushuffle

## Overview

`fasta_ushuffle` is a command-line utility that wraps the uShuffle library to process FASTA files. It allows researchers to shuffle DNA, RNA, or protein sequences while preserving the distribution of k-mers (e.g., dinucleotide or trinucleotide counts). This preservation is critical for maintaining the local composition and statistical properties of the original sequence in the shuffled control, ensuring that observed biological signals are not merely a result of simple sequence composition.

## Usage and CLI Patterns

The tool reads from standard input (stdin) and writes to standard output (stdout).

### Basic Command Structure
```bash
fasta_ushuffle [options] < INPUT.FA > OUTPUT.FA
```

### Common Options
- `-k N`: Specifies the k-let (k-mer) size to preserve. For example, `-k 2` preserves dinucleotide counts, while `-k 3` preserves trinucleotide counts.
- `-n N`: Specifies the number of shuffled permutations to generate for each input sequence.
- `-s N`: Sets a specific seed for the random number generator to ensure reproducible results.
- `-o`: Includes the original (unshuffled) sequence in the output file alongside the shuffled versions.
- `-r N`: Sets the number of retries (default is 10) to find a valid shuffle. If a valid permutation cannot be found after N tries, the tool prints a warning and outputs the non-shuffled sequence.

### Example Workflows

**Preserving Dinucleotide Content**
To shuffle a sequence while keeping the exact same dinucleotide frequencies (common in genomic studies):
```bash
fasta_ushuffle -k 2 < input.fa > shuffled_dinuc.fa
```

**Generating Multiple Controls for Statistical Testing**
To generate 100 shuffled versions of each sequence in a file for p-value calculation:
```bash
fasta_ushuffle -n 100 -k 2 < input.fa > controls_100x.fa
```

**Reproducible Shuffling**
To ensure the shuffle is the same across different runs:
```bash
fasta_ushuffle -k 2 -s 42 < input.fa > reproducible.fa
```

## Expert Tips and Best Practices

### Single-Line Sequence Requirement
`fasta_ushuffle` requires that the nucleotide or amino acid sequences in the input FASTA file be on a **single line**. It will not correctly process multi-line FASTA sequences.
- **Invalid Input:**
  ```text
  >seq1
  ATGCATGC
  ATGCATGC
  ```
- **Valid Input:**
  ```text
  >seq1
  ATGCATGCATGCATGC
  ```

### Pre-processing Multi-line FASTA
If your input file has wrapped sequences, use the `fasta_formatter` tool from the FASTX-Toolkit or a simple `awk` command to linearize it before passing it to `fasta_ushuffle`:
```bash
# Using awk to linearize FASTA
awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}' input.fa | tr "\t" "\n" | fasta_ushuffle -k 2 > output.fa
```

### Choosing the K-let Size
- **k=1**: Simple mononucleotide shuffle (preserves %GC but destroys all local structure).
- **k=2**: Preserves dinucleotide counts. This is the standard for most biological sequence modeling as it accounts for CpG depletion and other neighbor-dependent biases.
- **k=3**: Preserves codon usage bias (if shuffling coding regions). Note that as `k` increases, the number of possible permutations decreases significantly, especially for shorter sequences.

### Handling Shuffling Failures
If you see warnings about "retries," it means the sequence is too short or the k-mer constraints are too restrictive to allow for a new unique permutation. Increase the retry count with `-r 100` if you are working with highly repetitive or very short sequences.

## Reference documentation
- [fasta_ushuffle - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_fasta_ushuffle_overview.md)
- [GitHub - agordon/fasta_ushuffle: Wrapper for uShuffle](./references/github_com_agordon_fasta_ushuffle.md)