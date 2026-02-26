---
name: gotree
description: Gotree is a command-line toolkit for the manipulation, analysis, and visualization of phylogenetic trees. Use when user asks to reformat tree files, compute bootstrap support, prune specific tips, calculate tree statistics, or generate random tree models.
homepage: https://github.com/fredericlemoine/gotree
---


# gotree

## Overview
The `gotree` skill provides a specialized interface for handling phylogenetic data through a modular, pipe-oriented CLI. It transforms Claude into a bioinformatics expert capable of performing complex tree operations—such as collapsing clades based on support values, comparing topologies, or downloading data directly from iTOL and TreeBase—without requiring manual script writing for standard tree manipulations.

## Core CLI Patterns
Gotree follows a "command subcommand" structure. Most commands read from stdin and write to stdout, allowing for powerful chaining.

### Input and Output
- **Standard Input**: Use `-i` or pipe data into the command.
- **Remote Files**: Gotree natively supports URLs.
- **Format Conversion**: Use `gotree reformat [format]` (e.g., `newick`, `nexus`, `phyloxml`) to convert between types.

### Common Workflows
- **Visualization**: 
  - Quick ASCII preview: `gotree draw text -i tree.nwk`
  - High-quality render: `gotree draw png -i tree.nwk -o tree.png` (supports `--layout` radial or circular).
- **Tree Statistics**: 
  - Get node/tip counts and branch length sums: `gotree stats -i tree.nwk`
- **Filtering and Pruning**:
  - List all labels: `gotree labels -i tree.nwk`
  - Remove specific tips: `gotree prune -i tree.nwk -l tip_name`
- **Bootstrap Analysis**:
  - Compute Transfer Bootstrap Expectation (TBE): `gotree compute support tbe -t ref.nwk -b boot.nwk`
  - Compute Felsenstein Bootstrap (FBP): `gotree compute support fbp -t ref.nwk -b boot.nwk`

## Expert Tips
- **Chaining**: Combine commands to perform complex edits in one line. For example, to scale branch lengths and then collapse low-support nodes:
  `gotree brlen scale -f 1.5 -i tree.nwk | gotree collapse clades --support-min 70`
- **Internal Nodes**: When listing labels or annotating, use the `--internal` flag to include non-tip nodes.
- **Random Trees**: Use `gotree generate` (e.g., `uniformtree`, `yuletree`) to create null models for topological comparisons.
- **Gzipped Files**: Gotree automatically detects and handles `.gz` extensions for input files.

## Reference documentation
- [GitHub Repository and README](./references/github_com_evolbioinfo_gotree.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_gotree_overview.md)