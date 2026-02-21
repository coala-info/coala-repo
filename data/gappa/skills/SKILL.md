---
name: gappa
description: Gappa (Genesis Applications for Phylogenetic Placement Analysis) is a high-performance toolkit designed for the post-processing of phylogenetic placement data.
homepage: https://github.com/lczech/gappa
---

# gappa

## Overview

Gappa (Genesis Applications for Phylogenetic Placement Analysis) is a high-performance toolkit designed for the post-processing of phylogenetic placement data. It serves as the primary bridge between raw placement outputs (from tools like EPA-ng, RAxML-EPA, or pplacer) and biological interpretation. Use this skill to handle large-scale metagenomic datasets where you need to compare microbial communities, assign taxonomy to environmental reads, or visualize the distribution of placement mass across a reference phylogeny.

## Command Line Usage

Gappa follows a hierarchical command structure:
`gappa <module> <subcommand> <options>`

### Core Modules

*   **analyze**: Statistical comparisons and clustering (e.g., Edge PCA, KR Distance).
*   **edit**: Manipulation of `.jplace`, `.fasta`, or `.newick` files (e.g., merging, filtering).
*   **examine**: Visualization and tabulation (e.g., taxonomic assignment, heat-trees).
*   **prepare**: Pre-processing tasks (e.g., cleaning trees, chunking alignments).

### Common Workflows and Patterns

#### 1. Inspecting Placement Data
Before running complex analyses, verify the contents of your placement files.
```bash
gappa examine info --jplace input.jplace
```

#### 2. Taxonomic Assignment
Assign taxonomy to placed sequences using a reference taxonomy.
```bash
gappa examine assign --jplace input.jplace --taxonomy taxonomy.db --out-dir output_folder
```

#### 3. Visualizing Placement Mass
Generate a "heat-tree" where branch colors or widths represent the amount of placement mass (reads) assigned to those lineages.
```bash
gappa examine heat-tree --jplace input.jplace --out-dir visualization_results
```

#### 4. Community Comparison (Edge PCA)
Compare multiple samples to find differences in community composition based on their phylogenetic placements.
```bash
gappa analyze edgepca --jplace sample1.jplace sample2.jplace sample3.jplace
```

#### 5. Merging Results
Combine multiple placement files into a single file for collective analysis.
```bash
gappa edit merge --jplace *.jplace --out-dir merged_data
```

#### 6. Filtering Placements
Remove low-confidence placements based on Likelihood Weight Ratio (LWR) or other criteria.
```bash
gappa edit filter --jplace input.jplace --threshold 0.9 --out-dir filtered_results
```

### Expert Tips

*   **Memory Efficiency**: Gappa is written in C++ and is significantly faster and more memory-efficient than older tools like `guppy`. It is preferred for datasets with millions of environmental sequences.
*   **Reference Citations**: Use `gappa tools citation` to get the specific papers to cite for the subcommands you used in your analysis.
*   **Tree Cleaning**: Many phylogenetic tools fail on non-standard Newick characters. Use `gappa prepare clean-tree` to sanitize your reference trees before starting a pipeline.
*   **Output Formats**: Most `examine` commands produce tabulated text files or SVG/PDF visualizations. Always specify an `--out-dir` to keep results organized.

## Reference documentation

- [Gappa Wiki - Command Overview](./references/github_com_lczech_gappa_wiki.md)
- [Gappa GitHub Repository](./references/github_com_lczech_gappa.md)