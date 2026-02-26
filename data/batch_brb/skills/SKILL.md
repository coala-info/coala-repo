---
name: batch_brb
description: Automates best reciprocal BLAST and phylogenetic analysis using FastTree. Use when user asks to identify orthologs across multiple sequences and organisms.
homepage: https://github.com/erin-r-butterfield/batch_brb
---


# batch_brb

yaml
name: batch_brb
description: Automates best reciprocal BLAST and phylogenetic analysis using FastTree. Use when needing to identify orthologs across multiple sequences and organisms, especially for large-scale analyses where manual searching is impractical.
---
## Overview

batch_brb is a command-line tool designed to streamline the process of identifying orthologs through best reciprocal BLAST. It automates the search and filtering steps, making it efficient for analyzing a moderate to large number of sequences. The tool helps overcome limitations of standard ortholog identification methods by handling organism availability and divergent sequences, though user oversight for excluding false positives is still recommended.

## Usage Instructions

batch_brb is available as a Bioconda package. Ensure you have Conda and Bioconda installed.

### Installation

```bash
conda create -n batch_brb batch_brb
conda activate batch_brb
```

### Core Functionality: Best Reciprocal BLAST

The primary function of batch_brb is to perform best reciprocal BLAST to identify orthologs. This involves a two-step BLAST process:

1.  **Initial BLAST:** Search query sequences against a user-defined database.
2.  **Reciprocal BLAST:** Search the top hits from the initial BLAST back against the organism of the original query sequences.

Sequences are considered orthologs if they are reciprocal best hits and meet user-defined criteria for coverage.

### Key Parameters and Workflow

While specific command-line arguments are not detailed in the provided documentation, the general workflow involves:

1.  **Preparing your database:** Ensure your target sequences are in a format suitable for BLAST.
2.  **Running batch_brb:** Execute the tool with your query sequences and database.
3.  **Specifying criteria:** The tool allows users to define:
    *   `x`: The number of top hits to extract per query per organism in the initial BLAST.
    *   `y`: The minimum query coverage percentage required for hits.
    *   Identical hits are excluded from the hit count.

### Best Practices and Expert Tips

*   **Leverage Bioconda:** Installing via Conda simplifies dependency management.
*   **Understand the Parameters:** Carefully choose `x` (number of hits) and `y` (query coverage) to balance sensitivity and specificity. Higher `x` and `y` values can increase the stringency of ortholog identification.
*   **User Analysis is Crucial:** batch_brb automates data collection but requires user interpretation to exclude false positives and paralogs. Review the identified orthologs carefully.
*   **Consult the Manual:** For detailed usage instructions, command-line options, and advanced configurations, refer to the `batch_brb_manual` located in the `documentation` folder of the repository.

## Reference documentation

- [batch_brb README](./references/github_com_erin-r-butterfield_batch_brb.md)
- [batch_brb Documentation Folder](./references/github_com_erin-r-butterfield_batch_brb_tree_main_documentation.md)