---
name: phyutility
description: Phyutility is a Java-based command-line utility designed for high-throughput processing of phylogenetic trees and molecular data.
homepage: https://github.com/blackrim/phyutility
---

# phyutility

## Overview
Phyutility is a Java-based command-line utility designed for high-throughput processing of phylogenetic trees and molecular data. It serves as a Swiss-army knife for bioinformaticians, bridging the gap between raw data and analysis by providing tools for cleaning alignments, managing tree topologies, and interacting with NCBI databases. It is particularly effective for automating the preparation of large-scale phylogenomic datasets.

## CLI Usage and Patterns
Phyutility is executed as a JAR file. The general syntax follows:
`java -jar phyutility.jar [command] [options]`

### Tree Manipulation
- **Rerooting**: A critical prerequisite for many comparative functions.
- **Pruning**: Used to remove specific leaves or clades from a tree.
- **Consensus**: Generates a consensus tree from a collection of trees (e.g., from a Bayesian MCMC or bootstrap replicates).
- **Leaf Stability & Lineage Movement**: Useful for identifying "rogue" taxa or unstable nodes in a forest of trees.

### Data Matrix Operations
- **Concatenation**: Combines multiple individual gene alignments into a single concatenated supermatrix.
- **Trimming/Cleaning**: Removes columns from an alignment based on occupancy or conservation.
- **NCBI Integration**: Allows for searching and fetching sequences directly from GenBank via the command line.

## Best Practices and Expert Tips
- **Amino Acid Handling**: When processing protein sequences using the `-clean` or `-concat` functions, you must explicitly include the `-aa` flag. Without this, the tool may not correctly recognize amino acid characters.
- **Mandatory Rerooting**: You must reroot your trees before performing leaf stability, lineage movement, or consensus functions. The current version of these functions requires rooted trees to calculate metrics accurately.
- **Memory Management**: Since Phyutility is Java-based, for very large alignments or large sets of trees, you may need to increase the heap size using JVM flags (e.g., `java -Xmx4g -jar phyutility.jar ...`).
- **Format Conversion**: Use the tool for quick type conversion between common phylogenetic formats (e.g., Newick, Nexus).

## Reference documentation
- [Phyutility README](./references/github_com_blackrim_phyutility.md)
- [Phyutility Wiki](./references/github_com_blackrim_phyutility_wiki.md)