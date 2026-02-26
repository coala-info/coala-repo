---
name: dawg
description: "Dawg simulates the evolution of DNA sequences by modeling substitutions and length-dependent gap formation across a phylogeny. Use when user asks to simulate recombinant DNA sequences, generate true alignments for benchmarking, or model sequence evolution using GTR and indel models."
homepage: https://github.com/reedacartwright/dawg
---


# dawg

## Overview
Dawg (DNA Assembly with Gaps) is a simulation tool designed to model the evolution of recombinant DNA sequences in continuous time. It goes beyond simple substitution models by incorporating a robust General Time Reversible (GTR) model with gamma and invariant rate heterogeneity, alongside a length-dependent model for gap formation (indels). It accepts phylogenies in Newick format and can output the sequence of any node in the tree, allowing researchers to record the exact evolutionary history and produce a "true alignment" for benchmarking.

## Command Line Usage

The primary way to interact with dawg is through the command line using a configuration file, referred to as a "trick" file.

- **Basic Execution**: Run a simulation using a trick file.
  ```bash
  dawg trick.dawg
  ```
- **Standard Input**: Read the configuration from stdin.
  ```bash
  cat trick.dawg | dawg -
  ```
- **Help and Documentation**: Access built-in help for CLI options or the trick file format.
  ```bash
  dawg --help
  dawg --help-trick
  ```

## Input File Configuration (Tricks)

Dawg uses a unique section-based configuration format. Sections define different models for specific sequence or tree regions.

### Section Structure and Inheritance
- **Headers**: Defined with double square brackets, e.g., `[[SectionName]]`.
- **Implicit Sections**: The start of a file has an implied `[[_initial_]]` section.
- **Inheritance**: By default, a section inherits parameters from the one preceding it. You can explicitly set a parent using `[[SectionC = SectionA]]`.
- **Automatic Naming**: Use `[[]]` to let dawg generate a section name automatically.

### Common Parameters
- **Tree**: The phylogeny in Newick format.
- **Model**: The substitution model (e.g., GTR).
- **Rate Heterogeneity**: Parameters for Gamma distribution or invariant sites.
- **Indels**: Parameters defining the length-dependent model of gap formation.

## Expert Tips and Best Practices

- **Simulating Recombination**: To simulate recombinant sequences, split the root sequence into multiple "segments." Assign different phylogenies to different segments within the trick file.
- **True Alignments**: Always use dawg when you need the "true" alignment for a benchmark. Because dawg tracks the gap history of every lineage, it produces an alignment that represents the actual evolutionary events rather than a statistical estimate.
- **Modular Configuration**: Leverage the inheritance system to create a base model in the `_initial_` section and then create sub-sections that only override specific parameters (like the tree or mutation rate) for different replicates.
- **Output Redirection**: Since dawg typically outputs to stdout, redirect the results to a file or pipe them into downstream analysis tools.
  ```bash
  dawg my_params.dawg > simulation_results.fasta
  ```

## Reference documentation
- [GitHub - reedacartwright/dawg](./references/github_com_reedacartwright_dawg.md)
- [bioconda / dawg - Anaconda.org](./references/anaconda_org_channels_bioconda_packages_dawg_overview.md)