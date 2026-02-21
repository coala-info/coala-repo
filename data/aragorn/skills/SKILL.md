---
name: aragorn
description: Aragorn is a specialized bioinformatic tool designed to identify tRNA and tmRNA genes within DNA sequences.
homepage: http://www.ansikte.se/ARAGORN/
---

# aragorn

## Overview
Aragorn is a specialized bioinformatic tool designed to identify tRNA and tmRNA genes within DNA sequences. It utilizes heuristic algorithms to search for the conserved secondary structures and sequence motifs characteristic of these non-coding RNAs. This skill provides the necessary command-line patterns to execute searches, handle different genetic codes, and format outputs for downstream genomic analysis.

## Usage Patterns

### Basic tRNA Detection
To perform a standard search for tRNA genes in a FASTA file:
```bash
aragorn -t <input_file.fasta>
```

### Combined tRNA and tmRNA Detection
To search for both tRNA and tmRNA genes simultaneously:
```bash
aragorn -m -t <input_file.fasta>
```

### Specifying Genetic Codes
Aragorn defaults to the standard genetic code. Use specific flags for organellar or alternative genomes:
- **Mammalian Mitochondrial**: `-mtmam`
- **Yeast Mitochondrial**: `-mtyst`
- **Ciliate/Protozoan**: `-mtpro`
- **Invertebrate Mitochondrial**: `-mtinv`

### Output Formatting
- **Standard Output**: Displays secondary structure "cloverleaf" diagrams.
- **Summary Only**: Use `-s` to output a concise one-line summary per gene.
- **GFF Format**: Use `-gc` to output results in Gene Feature Format, which is ideal for genome annotation pipelines.

## Expert Tips
- **Topology**: If searching a circular genome (like a bacterial chromosome or plasmid), use the `-c` flag to allow genes to be detected across the sequence wrap-around point.
- **Sensitivity**: If you suspect missing tRNAs, use the `-i` flag to search for tRNA genes with introns, which are common in Archaeal and Eukaryotic genomes.
- **Performance**: For very large datasets, redirect the output to a file (`> results.txt`) as the structural diagrams can be voluminous in the terminal.

## Reference documentation
- [Aragorn Overview](./references/anaconda_org_channels_bioconda_packages_aragorn_overview.md)
- [Aragorn Homepage](./references/www_ansikte_se_ARAGORN.md)