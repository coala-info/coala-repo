---
name: dampa
description: "DAMPA designs and evaluates oligonucleotide probes for targeted sequencing using a pangenome graph approach to account for genetic diversity. Use when user asks to design a new probeset from genomic data, evaluate the coverage of existing probes against target genomes, or optimize probe sets for diverse populations."
homepage: https://github.com/MultipathogenGenomics/dampa
---


# dampa

## Overview
DAMPA (Diversity Aware Metagenomic Panel Assignment) is a specialized pipeline for designing oligonucleotide probes used in targeted sequencing. It addresses the challenge of genetic diversity by representing input sequences as a pangenome graph, which collapses conserved regions and separates diverse ones. This approach allows for the design of probes that account for recombination and sequence variation while minimizing the total number of probes required to cover a target population.

## Core Workflows

### Designing a New Probeset
The `design` module is the primary tool for generating probes from genomic data.

```bash
dampa design -g <input_genomes.fasta> -o <output_dir> -p <prefix>
```

**Key Parameters:**
- `-g, --input`: A single multi-FASTA file or a directory containing individual `.fasta`, `.fna`, or `.fa` files.
- `-l, --probelen`: Length of the probes (default: 120bp).
- `-s, --probestep`: Distance between probe starts. For non-overlapping probes, set this equal to `--probelen`.
- `-t, --threads`: Number of CPU threads to utilize.

### Evaluating Existing Probes
The `eval` module tests how well a set of probes covers a specific set of target genomes.

```bash
dampa eval -g <target_genomes.fasta> -q <probes.fasta> -o <output_dir> -p <prefix>
```

## Expert Tips and Best Practices

### Managing Graph Complexity
The underlying pangenome graph determines the probe quality. You can fine-tune the graph generation using these settings:
- **Fragmentation Control**: Use `--pangraphalpha` (default: 100) to control the energy cost of splitting blocks. Higher values reduce graph fragmentation.
- **Diversity Merging**: Use `--pangraphbeta` (default: 10) to control the cost of diversity. High values prevent the merging of distantly related sequences into the same block.
- **Identity Threshold**: Adjust `--pangraphident` (5, 10, or 20) to set the allowable percentage identity for the pangenome alignment.

### Optimizing Coverage
DAMPA uses "probetools" to fill gaps in coverage that the pangenome graph might miss.
- **Gap Filling**: If you want probes derived *only* from the pangenome graph without the final gap-filling step, use the `--skip_probetoolsfinal` flag.
- **Binding Sensitivity**: Adjust `--probetoolsidentity` (default: 85) and `--probetoolsalignmin` (default: 90) to define the stringency of what constitutes a "successful" probe-to-target match.

### Handling Ambiguous Bases
By default, DAMPA substitutes ambiguous nucleotides (like N) with ATGC based on weighted proportions in the input.
- Use `--skipsubambig` to disable this behavior.
- Use `--maxambig` (default: 10) to set the maximum number of ambiguous bases allowed in a single probe before it is discarded.

### Output Interpretation
- **Summary Plots**: Unless `--skip_summaries` is used, DAMPA generates visualizations showing probe coverage relative to input genomes.
- **Reporting**: Use `--report0covperc` to set the threshold for reporting genomes that have insufficient coverage.

## Reference documentation
- [DAMPA GitHub Repository](./references/github_com_MultipathogenGenomics_dampa.md)
- [DAMPA Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_dampa_overview.md)