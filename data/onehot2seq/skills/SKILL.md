---
name: onehot2seq
description: "onehot2seq decodes 3D numpy arrays into DNA, RNA, or protein sequences in text or FASTA format. Use when user asks to convert one-hot encoded numpy arrays to biological sequences, decode tensors into FASTA files, or translate numeric arrays into DNA, RNA, or protein strings."
homepage: https://github.com/akikuno/onehot2seq
---


# onehot2seq

## Overview
onehot2seq is a specialized command-line utility designed to decode 3D numpy arrays into biological sequences. It bridges the gap between numeric tensors used in deep learning and standard bioinformatics file formats. The tool supports DNA, RNA, and protein sequences, providing options for standard text output or structured FASTA files, including support for ambiguous IUPAC characters.

## Installation
The tool can be installed via pip or bioconda:
```bash
pip install onehot2seq
# OR
conda install -c bioconda onehot2seq
```

## Command Line Usage
The basic syntax requires specifying the sequence type, the input numpy file, and the output destination.

### Basic Patterns
- **DNA to Text**: `onehot2seq -t dna -i input.npy -o output.txt`
- **RNA to FASTA**: `onehot2seq -t rna -f fasta -i input.npy -o output.fasta`
- **Protein with Ambiguous Characters**: `onehot2seq -t protein -a -i input.npy -o output.txt`

### Argument Reference
- `-t, --type`: Sequence type (`dna`, `rna`, or `protein`).
- `-i, --input`: Path to the input `.npy` file.
- `-o, --output`: Path for the output file.
- `-f, --format`: Output format (`txt` or `fasta`). Default is `txt`.
- `-a, --ambiguous`: Flag to include ambiguous characters in the decoding process.

## Technical Requirements for Input Arrays
To ensure successful decoding, the input numpy array must follow a specific 3D structure: **RxNxL** (Reads x Nucleotide/Amino Acid Channels x Sequence Length).

### Channel Ordering
The tool expects specific character orders in the second dimension (N) of the array:
- **DNA**: A, C, G, T (followed by NVHDBMRWSYK if `-a` is used).
- **RNA**: A, C, G, U (followed by NVHDBMRWSYK if `-a` is used).
- **Protein**: A, C, D, E, F, G, H, I, K, L, M, N, P, Q, R, S, T, V, W, Y (followed by XBZJ if `-a` is used).

## Expert Tips
- **FASTA Headers**: When using `-f fasta`, the tool automatically generates sequential headers (e.g., `>seq1`, `>seq2`). If you require specific metadata in your headers, you will need to post-process the output file.
- **Ambiguous Characters**: Always use the `-a` flag if your encoding process included IUPAC ambiguity codes (like `N` for any nucleotide or `X` for any amino acid). Without this flag, the tool may fail to map those channels correctly.
- **Complementary Tool**: To perform the inverse operation (encoding sequences into numpy arrays), use the companion tool `seq2onehot`.

## Reference documentation
- [onehot2seq GitHub Repository](./references/github_com_akikuno_onehot2seq.md)
- [onehot2seq Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_onehot2seq_overview.md)