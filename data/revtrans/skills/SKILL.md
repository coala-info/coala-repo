---
name: revtrans
description: Revtrans generates a codon-based nucleotide alignment by mapping DNA sequences onto a corresponding protein multiple sequence alignment. Use when user asks to create a codon-aware alignment, thread nucleotides through a protein alignment, or prepare sequences for dN/dS and selection analysis.
homepage: http://www.cbs.dtu.dk/services/RevTrans-2.0/web/download.php
---


# revtrans

## Overview
The `revtrans` tool is designed to synchronize protein-level evolutionary analysis with underlying genetic data. It takes a multiple sequence alignment (MSA) of proteins and the corresponding unaligned nucleotide sequences as input. By "threading" the nucleotides through the amino acid alignment, it produces a codon-aware nucleotide alignment. This is essential for calculating dN/dS ratios, identifying synonymous/nonsynonymous mutations, and performing codon-based phylogenetic reconstruction.

## Usage Guidelines

### Basic Command Structure
The standard execution requires a peptide alignment file and a nucleotide sequence file (typically in FASTA format):
```bash
revtrans peptide_alignment.faa nucleotide_sequences.fna [options]
```

### Key Parameters and Best Practices
- **Input Matching**: Ensure that the headers in your peptide alignment match the headers in your nucleotide sequence file exactly. `revtrans` uses these IDs to pair the sequences.
- **Sequence Length**: The nucleotide sequence must be exactly three times the length of the corresponding peptide sequence (excluding gaps). If there are mismatches in length, the tool will typically error out or skip the sequence.
- **Output Redirection**: By default, `revtrans` often outputs to stdout. Redirect to a file for downstream analysis:
  ```bash
  revtrans aln.faa seq.fna > codon_aln.fna
  ```

### Common Workflow
1. Align your protein sequences using a tool like ClustalW, MAFFT, or Muscle.
2. Collect the original CDS (coding sequences) for those proteins.
3. Run `revtrans` to generate the codon-based alignment.
4. Use the resulting alignment in tools like PAML or HyPhy for selection analysis.

## Reference documentation
- [revtrans - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_revtrans_overview.md)