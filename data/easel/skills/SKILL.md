---
name: easel
description: Easel is a library and suite of command-line utilities for biological sequence analysis and alignment manipulation. Use when user asks to convert sequence formats, calculate alignment statistics, translate DNA to protein, or shuffle sequences for null hypothesis testing.
homepage: https://github.com/EddyRivasLab/easel
---


# easel

## Overview

Easel is a foundational ANSI C library developed by the Eddy/Rivas laboratory for biological sequence analysis using probabilistic models. While it serves as the engine for HMMER and Infernal, it includes a powerful suite of standalone "miniapps" (prefixed with `esl-`) that provide high-performance utilities for sequence and alignment manipulation. Use this skill to perform tasks such as converting between sequence formats, calculating alignment statistics, shuffling sequences for null hypothesis testing, and translating DNA to protein.

## Installation and Setup

Easel is most easily managed via Bioconda.

```bash
conda install bioconda::easel
```

To build from source for development:
1. Clone the repository.
2. Run `autoconf`.
3. Execute `./configure`, `make`, and `make check`.

## Common Miniapp Patterns

### Sequence Reformatting (esl-reformat)
The most common use of Easel is converting between sequence and alignment formats (e.g., Stockholm, FASTA, Phylip, Clustal).

*   **Convert Alignment to FASTA**:
    `esl-reformat fasta alignment.sto`
*   **Handle Long Names in Phylip**:
    `esl-reformat --namelen 20 phylip alignment.sto`
*   **Prepend Index to Non-Unique Names**:
    Useful when dealing with aligned FASTA files where sequence names might collide.

### Alignment Manipulation (esl-alimanip and esl-alistat)
*   **Alignment Statistics**:
    `esl-alistat alignment.sto` provides summary statistics including number of sequences, alignment length, and average identity.
*   **Calculate Percent Identity**:
    `esl-alipid alignment.sto` calculates pairwise identity between sequences in an MSA.
*   **Masking Alignments**:
    `esl-mask` or `esl-alimask` can be used to remove or mask specific columns or regions in an alignment.

### Sequence Statistics and Translation (esl-seqstat and esl-translate)
*   **Sequence File Summary**:
    `esl-seqstat sequences.fa` provides a quick report on sequence counts and residue composition.
*   **DNA to Protein Translation**:
    `esl-translate sequences.fa` translates DNA sequences into protein. Note that for genomes with alternative start sites or unusual codon usage, specific parameters may be required.

### Null Hypothesis Testing (esl-shuffle)
*   **Sequence Shuffling**:
    `esl-shuffle` is used to generate randomized sequences that preserve specific properties (like mononucleotide or dinucleotide composition) for use as negative controls.
*   **Large Sequence Handling**:
    Be aware that older versions may have limitations with extremely large sequences; ensure you are using the latest release (0.49+) for robust performance.

## Expert Tips

*   **Stockholm Format**: Easel is the reference implementation for the Stockholm format. When working with Pfam or Rfam data, Easel tools are the most reliable way to parse `#=GC` (GC content) and `#=GS` (sequence information) annotation lines.
*   **Digital Sequence Files**: For high-performance applications, Easel uses a "digital" representation of sequences. If you are developing C code against the library, utilize `ESL_ALPHABET` to handle DNA, RNA, and Amino Acid types efficiently.
*   **Vector Operations**: The library includes optimized vector operations (SIMD) for sequence comparisons, which are utilized by the miniapps for speed.

## Reference documentation
- [Easel GitHub Repository](./references/github_com_EddyRivasLab_easel.md)
- [Easel Wiki and Workflow](./references/github_com_EddyRivasLab_easel_wiki.md)
- [Bioconda Easel Overview](./references/anaconda_org_channels_bioconda_packages_easel_overview.md)