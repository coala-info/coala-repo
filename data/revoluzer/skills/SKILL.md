---
name: revoluzer
description: revoluzer is a bioinformatics suite designed to analyze gene order evolution and identify parsimonious rearrangement scenarios between genomes. Use when user asks to identify rearrangement operations between gene orders, reconstruct evolutionary scenarios on a phylogenetic tree, or compute genomic distance matrices.
homepage: https://gitlab.com/Bernt/revoluzer/
---


# revoluzer

## Overview
revoluzer is a specialized bioinformatics suite designed for the analysis of gene order evolution. It implements the Common Interval Rearrangement Explorer (CREx) and TreeREx algorithms to identify parsimonious rearrangement scenarios between genomes. The toolset allows researchers to compute distance matrices based on rearrangement events and visualize the specific evolutionary steps (such as inversions, transpositions, and inverse transpositions) that distinguish one gene order from another.

## Command Line Usage

The revoluzer suite typically provides three primary binaries: `crex`, `trex` (TreeREx), and `distmat`.

### Common Interval Rearrangement Explorer (crex)
Use `crex` to analyze the rearrangement operations between two gene orders.
- **Basic Analysis**: Run `crex` on input files containing gene orders to identify the sequence of rearrangements.
- **Output**: As of version 0.1.6, `crex` prints all rearrangements of the identified scenario.
- **Version Check**: Use `crex --version` to ensure you are running the latest logic.

### TreeREx (trex)
Use `trex` for analyzing rearrangements within the context of a phylogenetic tree.
- **Scenario Reconstruction**: It infers rearrangement events on the edges of a given tree topology.
- **Help**: Access specific parameters via `trex --help`.

### Distance Matrix Computation (distmat)
Use `distmat` to generate a matrix of genomic distances for multiple genomes.
- **CREx Distance**: Use the specific option to compute distances based on the CREx algorithm (added in v0.1.4).
- **CLI Flags**:
  - `-b` and `-i`: These flags are used to configure specific distance parameters; note that using them will reset the `-c` parameter in recent versions.
  - `-v`: Display version information.

## Best Practices and Expert Tips

- **Gene Content Consistency**: Ensure that the input genomes have equal gene content. As of version 0.1.8, both `crex` and `trex` will trigger an error if gene content is unequal, as the underlying algorithms require a 1-to-1 mapping of genes.
- **Output Formatting**: Recent updates have improved the output formatting for better readability in downstream scripts. The tool uses tabs instead of pipe characters (`|`) in CREx output to facilitate easier parsing.
- **Distance Selection**: When using `distmat`, explicitly verify the distance metric being used. The tool prints the name of the distance metric being calculated to `stderr` to help you verify your configuration.
- **CLI Reset Logic**: Be aware that in the `distmat` tool, certain flags are mutually exclusive or reset others. Specifically, setting `-b` or `-i` will reset the `-c` option to ensure consistent parameter states.



## Subcommands

| Command | Description |
|---------|-------------|
| crex | Process gene orders in a file or process random rearrangement scenario and compare with reconstruction. |
| distmat | Compute distance matrix between genomes. |
| trex | trex method selection |

## Reference documentation
- [Releases](./references/gitlab_com_Bernt_revoluzer_-_releases.md)
- [Tags and Version History](./references/gitlab_com_Bernt_revoluzer_-_tags.md)
- [Project Overview](./references/gitlab_com_Bernt_revoluzer.md)