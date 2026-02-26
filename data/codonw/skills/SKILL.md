---
name: codonw
description: CodonW analyzes codon usage bias and molecular evolution trends in DNA sequences using summary indices and multivariate statistical techniques. Use when user asks to calculate codon adaptation indices, perform correspondence analysis of codon usage, or determine gene-specific parameters like GC content and aromaticity.
homepage: http://codonw.sourceforge.net
---


# codonw

## Overview
CodonW is a specialized tool for molecular evolution and bioinformatics research. It simplifies the analysis of codon usage bias by providing both summary indices and advanced multivariate statistical techniques. Use this skill to identify major trends in codon usage variation across genes, determine optimal codons for a species, and calculate gene-specific parameters like GRAVY scores, aromaticity, and dinucleotide composition.

## Core Workflows

### Basic Sequence Analysis
To calculate standard indices and gene parameters for a set of sequences:
`codonw input.fasta output.out [options]`

Commonly used flags for indices:
- `-cai`: Calculate Codon Adaptation Index (CAI).
- `-fop`: Calculate Frequency of Optimal Codons (Fop).
- `-nc`: Calculate Effective Number of Codons (Nc).
- `-cbi`: Calculate Codon Bias Index (CBI).
- `-gc`: Calculate G+C content (total).
- `-gc3s`: Calculate G+C content at synonymous 3rd codon positions.
- `-all_indices`: Calculate all available indices.

### Correspondence Analysis (COA)
COA is used to identify the primary axes of variation in codon usage.
- `-coa_cu`: Correspondence analysis of Codon Usage.
- `-coa_rscu`: Correspondence analysis of Relative Synonymous Codon Usage (removes amino acid usage bias).
- `-coa_aa`: Correspondence analysis of Amino Acid usage.

### Output Customization
- `-machine`: Generates machine-readable output (tab-delimited) for easy import into R or Excel.
- `-human`: Generates formatted, easy-to-read output.
- `-silent`: Suppresses screen output during processing.

### Genetic Code Selection
CodonW supports various genetic codes. Use the `-code` flag followed by the appropriate number:
1. Universal
2. Mammalian Mitochondrial
3. Yeast Mitochondrial
4. Plant Mitochondrial
5. Ciliate
6. Drosophila Mitochondrial
7. Vertebrate Mitochondrial
8. Second Variant Yeast Mitochondrial

## Expert Tips
- **Input Formatting**: Ensure sequences are in-frame and start with the first position of the first codon. Use `>` or `;` for header lines.
- **Optimal Codons**: When calculating CAI or Fop, CodonW may prompt for a reference set of optimal codons. You can generate these automatically during a COA run; the tool creates `.cai` and `.fop` files based on the major trend (Axis 1).
- **Sequence Integrity**: CodonW warns about internal stop codons or non-translatable characters but does not exclude them automatically. Always check the output logs for warnings to ensure data quality.
- **Concatenation**: Use the `-total` flag to concatenate all genes in the input file into a single aggregate sequence for calculating overall genome-wide codon usage.

## Reference documentation
- [CodonW Features and Installation](./references/codonw_sourceforge_net_index.md)
- [Input File Requirements and COA Details](./references/codonw_sourceforge_net_culong.html.md)
- [General Readme and Build Instructions](./references/codonw_sourceforge_net_Readme.html.md)