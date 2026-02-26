---
name: phylocsf
description: PhyloCSF identifies conserved protein-coding regions in multi-species nucleotide sequence alignments by analyzing evolutionary signatures. Use when user asks to distinguish between protein-coding genes and non-coding RNAs, identify coding potential in novel transcripts, or evaluate alignments using phylogenetic codon substitution frequencies.
homepage: https://github.com/mlin/PhyloCSF/wiki
---


# phylocsf

## Overview

PhyloCSF (Phylogenetic Codon Substitution Frequencies) is a comparative genomics tool used to identify conserved protein-coding regions within multi-species nucleotide sequence alignments. Unlike homology-based searches, PhyloCSF examines evolutionary signatures characteristic of coding sequences, such as the frequency of synonymous codon substitutions and the avoidance of nonsense mutations. It is a standard tool for distinguishing between protein-coding genes and non-coding RNAs (like lincRNAs) in novel transcript models.

## Command Line Usage

The basic syntax for running PhyloCSF is:

```bash
PhyloCSF <phylogeny> <alignment_file> [options]
```

### Core Parameters
- **Phylogeny**: A keyword representing a pre-computed set of parameters (e.g., `100vertebrates`, `58mammals`, `12flies`, `29mammals`).
- **Alignment File**: A multi-species alignment in FASTA format.

### Common Options
- `--strategy omega`: Uses the "Omega Test" mode, which requires only a phylogenetic tree rather than full empirical codon models.
- `--frames=3`: Evaluates the alignment in three forward reading frames.
- `--remove-gaps`: Relaxes the requirement that the reference sequence must be ungapped.

## Input Requirements

- **Format**: FASTA format is required.
- **Reference Sequence**: The first sequence in the file is treated as the reference. By default, this sequence must be ungapped to define the reading frame.
- **Species Headers**: The species name must appear at the start of the header line. Any text following a pipe (`|`) is ignored (e.g., `>hg38|chr1:100-200`).
- **Species Matching**: Species names in the FASTA headers must exactly match the leaf names in the phylogenetic tree associated with the chosen phylogeny parameter.

## Interpreting Results

PhyloCSF outputs a score in **decibans** (10 * log10 of the likelihood ratio).
- **Positive Score**: The alignment is more likely to represent a conserved protein-coding region.
- **Negative Score**: The alignment is more likely to be non-coding.
- **Magnitude**: A higher absolute value indicates stronger evidence for the classification.

## The Omega Test

Use the Omega Test when you have a custom phylogenetic tree but lack the thousands of parameters required for a full empirical codon model.

1. Place a Newick format tree file (e.g., `my_tree.nh`) in the `PhyloCSF_Parameters` directory.
2. Run PhyloCSF using the filename (without extension) as the phylogeny argument:
   ```bash
   PhyloCSF my_tree alignment.fa --strategy omega
   ```
*Note: The Omega Test is generally slower and less sensitive than the standard mode.*

## Expert Tips

- **Concatenated Exons**: For multi-exonic transcripts, concatenate the aligned exons into a single FASTA entry to increase the statistical power of the score.
- **Missing Species**: You do not need all species present in a phylogeny to run the tool; PhyloCSF automatically marginalizes out missing data for species defined in the tree but absent in the alignment.
- **U to T**: The program automatically treats 'U' (RNA) as 'T' (DNA).

## Reference documentation

- [PhyloCSF Home](./references/github_com_mlin_PhyloCSF_wiki.md)
- [Omega Test Details](./references/github_com_mlin_PhyloCSF_wiki_Omega-Test.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_phylocsf_overview.md)