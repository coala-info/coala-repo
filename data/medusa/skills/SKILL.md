---
name: medusa
description: Medusa organizes and orients contigs from a draft genome assembly into scaffolds using multiple reference genomes. Use when user asks to scaffold a draft genome, orient contigs using reference genomes, estimate inter-contig distances, or calculate assembly N50 statistics.
homepage: https://github.com/combogenomics/medusa
metadata:
  docker_image: "quay.io/biocontainers/medusa:1.6--1"
---

# medusa

## Overview
Medusa is a specialized tool designed to organize and orient contigs from a draft genome assembly into larger scaffolds. Unlike single-reference scaffolders, Medusa can utilize multiple reference genomes simultaneously. It builds a contig adjacency graph based on alignments (using MUMmer) and finds the optimal path to produce a final scaffolded assembly. This skill provides the necessary command-line patterns and best practices for executing scaffolding tasks, estimating inter-contig distances, and calculating assembly statistics.

## Core CLI Usage

The primary way to run Medusa is via its Java executable. Ensure that `mummer` and `python` (with `biopython`, `numpy`, and `networkx`) are available in your environment.

### Basic Scaffolding
To scaffold a target genome using a directory of reference genomes:
```bash
java -jar medusa.jar -i target_genome.fasta -f /path/to/reference_drafts/ -v
```

### Recommended Production Command
For most research use cases, it is recommended to use the distance estimation and randomization features to improve scaffold quality:
```bash
java -jar medusa.jar -i target.fasta -f ./references/ -d -random 5 -v -o scaffolded_output.fasta
```

## Command Options Reference

| Option | Description |
| :--- | :--- |
| `-i <file>` | **Required.** The target draft genome in FASTA format. |
| `-f <dir>` | Path to the directory containing auxiliary reference FASTA files. |
| `-o <file>` | Name of the output FASTA file (default appends "Scaffold" to input name). |
| `-d` | Estimate distances between contigs and fill gaps with a representative number of 'N's. |
| `-random <int>` | Number of cleaning rounds to find the best path (5 is usually sufficient). |
| `-w2` | Enables a sequence similarity-based weighting scheme for the graph. |
| `-v` | Verbose mode; shows MUMmer output (highly recommended for troubleshooting). |
| `-gexf` | Exports the contig network and path cover in GEXF format for visualization. |
| `-n50 <file>` | Standalone mode to calculate the N50 statistic for a specific FASTA file. |

## Expert Tips and Best Practices

- **Reference Selection**: The quality of Medusa's output is highly dependent on the phylogenetic distance of the reference genomes. Use the most closely related organisms available.
- **Gap Filling**: By default, Medusa uses a fixed 100 'N's between contigs. Always use the `-d` flag if you require a more realistic estimation of the physical distance between contigs based on the reference alignments.
- **MUMmer Dependencies**: If Medusa fails during the alignment phase, run with `-v` to see the MUMmer error. Ensure `nucmer` and `show-coords` are in your system PATH.
- **Memory Management**: For very large assemblies or numerous reference genomes, you may need to increase the Java heap size: `java -Xmx4g -jar medusa.jar ...`.
- **Visualization**: Use the `-gexf` option to generate network files that can be opened in tools like Gephi to inspect how contigs are being linked and identify potential assembly conflicts.

## Reference documentation
- [Medusa GitHub README](./references/github_com_combogenomics_medusa.md)
- [Bioconda Medusa Package Overview](./references/anaconda_org_channels_bioconda_packages_medusa_overview.md)