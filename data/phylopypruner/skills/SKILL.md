---
name: phylopypruner
description: PhyloPyPruner is a specialized tool for phylogenomic data refinement.
homepage: https://github.com/fethalen/phylopypruner
---

# phylopypruner

## Overview
PhyloPyPruner is a specialized tool for phylogenomic data refinement. While graph-based orthology inference tools provide a starting point, they often include paralogs or sequences from contaminated samples. This skill enables the identification of 1:1 orthologs by analyzing gene trees and alignments. It implements the species overlap method to distinguish between speciation and duplication events, effectively "pruning" trees to retain only the most phylogenetically informative sequences while filtering out potential contaminants.

## Installation and Setup
PhyloPyPruner is a Python-based tool that can be installed via pip or conda:

```bash
# Via pip
pip install phylopypruner

# Via conda
conda install -c bioconda phylopypruner
```

## Core Workflow
To use PhyloPyPruner effectively, follow this general procedure:

1.  **Prepare Input**: Ensure you have a directory containing gene trees (Newick format) and their corresponding alignments (FASTA format).
2.  **Execution**: Run the tool pointing to your input data.
3.  **Refinement**: Apply specific pruning criteria such as minimum taxon occupancy or monophyly requirements to improve the quality of the resulting ortholog sets.

## Common CLI Patterns
While specific flags depend on the version, the standard execution follows this pattern:

- **Basic Run**: Execute `phylopypruner` within the directory containing your orthogroup files or specify the path to the input data.
- **Contamination Reduction**: Use the tool's built-in algorithms to identify and remove sequences that cause unexpected paralogy, which is often a sign of contamination in single-taxon samples.
- **Output Handling**: The tool typically generates pruned alignments and trees ready for species tree inference (e.g., via IQ-TREE or RAxML).

## Expert Tips
- **Input Consistency**: Ensure that the headers in your alignment files match the leaf names in your tree files exactly.
- **Graph-Based Pre-processing**: PhyloPyPruner is most effective when used as a secondary filter after initial clustering by tools like OrthoFinder.
- **Handling Gaps**: Note that recent versions of the tool do not count 'X' and '?' as gap characters, which may affect occupancy calculations compared to older versions.
- **Recursion Limits**: For very large trees, you may need to ensure your environment supports high recursion limits, as tree traversal is a core part of the orthology inference logic.

## Reference documentation
- [GitHub Repository - fethalen/phylopypruner](./references/github_com_fethalen_phylopypruner.md)
- [Anaconda Bioconda - phylopypruner Overview](./references/anaconda_org_channels_bioconda_packages_phylopypruner_overview.md)