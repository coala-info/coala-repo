---
name: translatorx
description: TranslatorX is a specialized tool for aligning nucleotide sequences that encode proteins.
homepage: http://pc16141.mncn.csic.es/
---

# translatorx

## Overview
TranslatorX is a specialized tool for aligning nucleotide sequences that encode proteins. Standard nucleotide alignment often introduces gaps that break the open reading frame (ORF), leading to biological inaccuracies. This tool solves that by using the amino acid information as a guide. It translates the DNA, aligns the resulting protein sequences using external aligners (like Muscle, MAFFT, or ClustalW), and then maps the nucleotide sequences back onto the protein alignment to ensure a codon-aligned result.

## Usage Guidelines

### Basic Command Pattern
The most common usage involves providing a FASTA file of protein-coding DNA sequences:
```bash
perl translatorx.pl -i input_dna.fasta -o output_prefix
```

### Key Parameters and Options
- `-i`: Input file containing nucleotide sequences in FASTA format.
- `-o`: Output filename prefix for all generated files (alignments, translated sequences, etc.).
- `-p`: Specify the protein alignment program (default is Muscle). Options typically include `m` (Muscle), `f` (MAFFT), `w` (ClustalW), or `t` (T-Coffee).
- `-c`: Genetic code table number (default is 1, the Standard Code). Use this if working with mitochondrial or alternative genetic codes.
- `-t`: Force translation of the entire sequence or specific frames.

### Best Practices
- **Verify Reading Frames**: Ensure input sequences are in-frame and do not contain internal stop codons unless expected by the specific genetic code.
- **Clean Headers**: Use simple FASTA headers without spaces or special characters to avoid issues with downstream alignment programs.
- **Output Inspection**: TranslatorX generates several files. Always check the `.nt_ali.fasta` for the final codon-aligned nucleotide sequence and the `.aa_ali.fasta` for the protein alignment used as the template.
- **Gaps and Masking**: Use the `-g` option if you need to handle sequences with many gaps or if you wish to use GBlocks for automated alignment cleaning/masking.

## Reference documentation
- [TranslatorX Overview](./references/anaconda_org_channels_bioconda_packages_translatorx_overview.md)