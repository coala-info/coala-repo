---
name: squirrel
description: The `squirrel` tool (Some QUIck Reconstruction to Resolve Evolutionary Links) is a specialized bioinformatics pipeline for MPXV data.
homepage: https://github.com/aineniamh/squirrel
---

# squirrel

## Overview
The `squirrel` tool (Some QUIck Reconstruction to Resolve Evolutionary Links) is a specialized bioinformatics pipeline for MPXV data. It automates the process of mapping query genomes to clade-specific references, generating multiple sequence alignments, and performing phylogenetic analysis. It is particularly useful for detecting APOBEC3-mediated mutations, which are signatures of sustained human-to-human transmission, and for performing quality control on consensus sequences to identify clusters of unique SNPs or reversions.

## Core CLI Usage

### Basic Alignment
Align sequences to a specific reference based on the known clade:

- **Clade II (Default):** `squirrel <input.fasta> > output.aln.fasta`
- **Clade I:** `squirrel --clade cladei <input.fasta> > output.aln.fasta`

### Automated Clade Splitting
If the input file contains a mixture of Clade I and Clade II sequences, use the split feature to process them automatically:
`squirrel --clade split <input.fasta>`
*Note: This will assign clades, split sequences into separate alignments, and produce a unified report.*

### Phylogenetic Reconstruction
To move beyond alignment and build maximum-likelihood trees:
- **Standard Tree:** `squirrel --run-phylo <input.fasta>`
- **APOBEC3 Analysis:** `squirrel --run-apobec3-phylo <input.fasta>`
  *This mode runs ancestral state reconstruction to identify and map APOBEC3-like mutations (red) vs. other mutations (yellow) on the phylogeny.*

## Expert Tips and Best Practices

### Sequence Naming
Avoid special characters in FASTA headers. Characters like `' " { ( [ ] ) } ; , ` % # :` can break downstream phylogenetic tools like IQ-TREE or baltic. Use underscores or hyphens instead.

### Quality Control (QC Mode)
Use `--cns-qc` to flag potential issues in sequences, such as:
- SNPs near tracts of Ns.
- Clusters of unique SNPs.
- Reversions to reference alleles.
- Convergent mutations.
Squirrel generates a mask file that can be reviewed and then reapplied to the sequences before final phylogenetic analysis.

### Reference Coordinates
- **Clade II** uses NC_063383 as the reference.
- **Clade I** uses NC_003310 as the reference.
All coordinates in the resulting alignments are relative to these accessions. Note that insertions relative to these references are excluded from the final alignment.

### Handling Ambiguity
If a sequence consists entirely of `N` characters or is extremely short, `squirrel` may fail to align it. If all sequences in a file are 100% ambiguous, the tool will exit with an error.

## Reference documentation
- [Squirrel GitHub Repository](./references/github_com_aineniamh_squirrel.md)
- [Bioconda Squirrel Overview](./references/anaconda_org_channels_bioconda_packages_squirrel_overview.md)