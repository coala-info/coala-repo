---
name: pal2nal
description: pal2nal is a specialized tool designed to "back-translate" a protein alignment into a nucleotide alignment.
homepage: http://www.bork.embl.de/pal2nal/
---

# pal2nal

## Overview
pal2nal is a specialized tool designed to "back-translate" a protein alignment into a nucleotide alignment. Unlike a simple translation, it uses the protein alignment as a template to ensure that the resulting DNA alignment maintains the correct reading frame and codon structure. It is exceptionally robust, capable of handling input DNA that contains UTRs, polyA tails, or mismatches with the protein sequence. It is also a preferred tool for analyzing pseudogenes because it can account for frame shifts.

## Command Line Usage

The basic syntax for the pal2nal Perl script is:
`pal2nal.pl pep.aln nuc.fasta [options]`

### Common CLI Patterns

- **Basic Conversion**:
  `pal2nal.pl protein_alignment.fasta dna_sequences.fasta -output fasta > codon_alignment.fasta`

- **Preparing for PAML/codeml**:
  Use the PAML output format to ensure compatibility with downstream selection pressure analysis.
  `pal2nal.pl pep.aln nuc.fa -output paml > codon.phy`

- **Handling Gaps and Mismatches**:
  To remove columns containing gaps or mismatched codons (where the DNA does not match the protein translation):
  `pal2nal.pl pep.aln nuc.fa -nogap -nomismatch > clean_codon.aln`

- **Specifying Codon Tables**:
  Use the `-codontable` flag followed by the NCBI genetic code index (default is 1, Universal).
  `pal2nal.pl pep.aln nuc.fa -codontable 2` (Vertebrate Mitochondrial)

### Expert Tips

- **ID Matching**: While older versions required identical ordering, current versions (v12+) can match sequences by ID. Ensure that the headers in your protein alignment and your nucleotide FASTA file are identical.
- **Frame Shift Analysis**: If you are working with pseudogenes, pal2nal can handle frame shifts in the alignment. Ensure your protein alignment accurately reflects the intended gaps to allow the tool to map the DNA correctly.
- **dS/dN Calculation**: If the input consists of only a pair of sequences, pal2nal can automatically trigger PAML's `codeml` to calculate substitution rates if PAML is installed in your path.
- **Selection of Sites**: You can use the '#' character under a Clustal format protein alignment to specify specific positions for conversion, which is useful for targeted domain analysis.

## Reference documentation
- [PAL2NAL Official Documentation](./references/www_bork_embl_de_pal2nal.md)
- [Bioconda pal2nal Package Overview](./references/anaconda_org_channels_bioconda_packages_pal2nal_overview.md)