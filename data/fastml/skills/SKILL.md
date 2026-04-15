---
name: fastml
description: FastML performs ancestral sequence reconstruction to predict character states and indels at internal nodes of a phylogenetic tree. Use when user asks to reconstruct ancestral sequences, predict ancient protein states, or model indel evolution in a phylogeny.
homepage: http://fastml.tau.ac.il/
metadata:
  docker_image: "quay.io/biocontainers/fastml:3.11--hc9558a2_0"
---

# fastml

## Overview
FastML is a specialized bioinformatics tool designed for ancestral sequence reconstruction (ASR). It excels at predicting the most likely character states at internal nodes of a phylogenetic tree. Unlike many other ASR tools, FastML provides a robust framework for reconstructing both characters and indels, offering both joint and marginal reconstruction algorithms. It is particularly useful for evolutionary biology studies aiming to "resurrect" ancient proteins or track the evolution of specific genetic traits.

## Command Line Usage

The primary interface for FastML is a Perl wrapper script. Note that the script relies on relative paths to its internal binaries, so it should typically be called from its installation directory or via its full path.

### Basic Syntax
```bash
perl FastML_Wrapper.pl --MSA_File <input.fasta> --seqType <AA|NUC|CODON> --outDir <output_directory>
```

### Required Parameters
- `--MSA_File`: Input alignment in FASTA format.
- `--seqType`: Specify the data type: `aa` (amino acids), `nuc` (nucleotides), or `codon`.
- `--outDir`: The full path to the output directory. FastML requires a unique directory for every run; it will be created if it does not exist.

### Common Optional Parameters
- `--Tree <file>`: Provide a user-defined phylogenetic tree in Newick format.
- `--TreeAlg <NJ|RAxML>`: If no tree is provided, specify the algorithm to build one (Default: NJ).
- `--SubMatrix <model>`: Specify the substitution model.
    - **AA**: JTT (default), LG, mtREV, cpREV, WAG, DAYHOFF.
    - **NUC**: JC_Nuc (default), T92, HKY, GTR.
    - **CODON**: yang (default), empiriCodon.
- `--OptimizeBL <yes|no>`: Optimize branch lengths (Default: yes).
- `--UseGamma <yes|no>`: Account for among-site rate variation (Default: yes).
- `--Alpha <value>`: Provide a fixed alpha parameter for the Gamma distribution.
- `--indelReconstruction <PARSIMONY|ML|BOTH>`: Method for reconstructing gaps/indels.

## Expert Tips and Best Practices

- **Unique Output Directories**: FastML will fail or overwrite data if the `--outDir` is not unique for each specific run. Always use descriptive folder names (e.g., `results_JTT_gamma`).
- **Indel Modeling**: For sequences with significant length variation, use `--indelReconstruction BOTH` to compare Parsimony and Maximum Likelihood approaches for gap placement.
- **Codon Sequences**: When working with coding DNA, use `--seqType codon` rather than `nuc` to ensure the evolutionary model accounts for the genetic code and synonymous/non-synonymous substitution rates.
- **Tree Optimization**: If you have a high-confidence topology but uncertain branch lengths, provide the tree via `--Tree` and ensure `--OptimizeBL yes` is set to let FastML calculate the ML branch lengths for your specific alignment.
- **Large Datasets**: The web-server version of FastML is limited to 200 sequences. For larger datasets, always use the CLI version provided via Bioconda or source compilation.

## Reference documentation
- [FastML Source and Usage](./references/fastml_tau_ac_il_source.php.md)
- [FastML Server Overview](./references/fastml_tau_ac_il_index.md)