---
name: a3partitioner
description: a3partitioner partitions nucleotide alignments by isolating or masking sites associated with the APOBEC3 mutation signature. Use when user asks to isolate APOBEC3-related sites, remove APOBEC3 bias from an alignment, or generate separate partitions for phylogenetic analysis.
homepage: https://github.com/DaanJansen94/a3partitioner
---


# a3partitioner

## Overview
a3partitioner is a specialized bioinformatics utility designed to partition nucleotide alignments based on the APOBEC3 mutation signature. In many viral outbreaks, specifically Monkeypox (MPXV), the majority of observed mutations are driven by host deaminase activity (C → T or G → A substitutions in specific dinucleotide contexts) rather than polymerase errors. This tool enables researchers to isolate these specific sites or exclude them, facilitating more accurate phylogenetic reconstructions by separating biological signatures from potential noise or specific evolutionary pressures.

## Installation
The recommended way to install a3partitioner is via Conda:
```bash
conda install -c bioconda a3partitioner
```

## Command Line Usage
The tool uses a straightforward CLI for processing FASTA alignments.

### Core Arguments
- `-partition`: The type of partition to generate. Options: `apobec`, `non-apobec`, or `both`.
- `-i, --input`: Path to the input FASTA alignment file.
- `-o, --output`: Base name or path for the output FASTA file(s).

### Common Patterns

**1. Isolate APOBEC3-related sites**
Use this to create an alignment where only putative APOBEC3 modifications are preserved, and all other sites are masked as ambiguous nucleotides (N).
```bash
A3Partitioner -partition apobec -i alignment.fasta -o apobec_only.fasta
```

**2. Remove APOBEC3 bias**
Use this to create a "clean" alignment that masks all APOBEC3 target sites, focusing on mutations likely arising from error-prone polymerases.
```bash
A3Partitioner -partition non-apobec -i alignment.fasta -o non_apobec.fasta
```

**3. Generate a complete partition set**
This is the most common research workflow, producing two separate files for comparative analysis.
```bash
A3Partitioner -partition both -i alignment.fasta -o mpxv_analysis
```
*Output files generated:*
- `mpxv_analysis_APOBEC3.fasta`
- `mpxv_analysis_non_APOBEC3.fasta`

## Expert Tips and Best Practices
- **Input Requirements**: Ensure your input file is a multiple sequence alignment (MSA) in FASTA format. The tool relies on site-specific contexts, so unaligned sequences will produce incorrect results.
- **Phylogenetic Analysis**: The `apobec` partition is specifically designed as input for Maximum Likelihood (ML) or Bayesian phylogenetic analyses to isolate the deaminase-driven evolutionary signal.
- **Monkeypox Workflow**: For MPXV research, it is recommended to use a reliable aligner like `squirrel` to generate the initial alignment before processing it with a3partitioner.
- **Masking Logic**: Understand that "partitioning" in this tool refers to masking. The `apobec` partition masks non-APOBEC sites, while the `non-apobec` partition masks the APOBEC sites; the sequence length remains identical to the input.

## Reference documentation
- [a3partitioner Overview](./references/anaconda_org_channels_bioconda_packages_a3partitioner_overview.md)
- [a3partitioner GitHub Documentation](./references/github_com_DaanJansen94_a3partitioner.md)