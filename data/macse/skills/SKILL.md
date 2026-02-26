---
name: macse
description: MACSE performs codon-aware multiple sequence alignment of nucleotide sequences while accounting for frameshifts and stop codons. Use when user asks to align coding sequences, handle frameshifts in alignments, or process pseudogenes and sequences with internal stop codons.
homepage: https://bioweb.supagro.inra.fr/macse/
---


# macse

## Overview
MACSE (Multiple Alignment of Coding SEquences) is a specialized alignment tool that works at the nucleotide level while accounting for the amino acid translation. Unlike standard aligners that fail when encountering non-functional sequences, MACSE explicitly models frameshifts and stop codons. This makes it the primary choice for evolutionary biologists working with datasets where sequences are not perfectly conserved or contain sequencing errors that disrupt the open reading frame.

## Usage Guidelines

### Core Functionality
- **Codon-Aware Alignment**: MACSE aligns sequences based on their amino acid properties but outputs the results in nucleotides, ensuring gaps are placed in multiples of three unless a frameshift is detected.
- **Frameshift Handling**: It uses specific symbols (typically `!`) to denote frameshifts, allowing the alignment to continue in the correct reading frame.
- **Stop Codon Tolerance**: It can process sequences containing internal stop codons (pseudogenes) without crashing or producing biologically nonsensical alignments.

### Common CLI Patterns
While specific subcommands vary by version (v1 vs v2), the general execution follows this pattern:

```bash
# Basic alignment of a fasta file
java -jar macse.jar -prog alignSequences -seq sequences.fasta

# Aligning sequences to a reference
java -jar macse.jar -prog alignSequences -seq sequences.fasta -seq_lr reads.fasta
```

### Expert Tips
- **Genetic Codes**: Always specify the correct genetic code if your sequences are not from the standard nuclear code (e.g., mitochondrial DNA) to ensure accurate translation during alignment.
- **Cost Parameters**: MACSE relies on costs for frameshifts and stop codons. If you are working with high-quality genomic data, increase the frameshift penalty; for raw NGS reads, a lower penalty may be more appropriate to identify sequencing errors.
- **Output Formats**: The tool typically produces two files: one for the nucleotide alignment (NT) and one for the amino acid translation (AA). Use the NT alignment for downstream dN/dS or phylogenetic analyses.

## Reference documentation
- [MACSE Overview](./references/www_agap-ge2pop_org_macse.md)
- [Bioconda MACSE Package](./references/anaconda_org_channels_bioconda_packages_macse_overview.md)