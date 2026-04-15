---
name: pastml
description: PastML reconstructs ancestral states by mapping discrete characters onto rooted phylogenetic trees and generating interactive visualizations. Use when user asks to reconstruct ancestral scenarios, map discrete characters onto phylogenetic trees, select inference models like MPPA, or generate interactive HTML visualizations.
homepage: https://pastml.pasteur.fr
metadata:
  docker_image: "quay.io/biocontainers/pastml:1.9.51--pyhdfd78af_0"
---

# pastml

## Overview
PastML is a specialized tool for mapping discrete characters onto rooted phylogenetic trees. It excels at processing large datasets to reconstruct ancestral scenarios and generating interactive, zoomable HTML maps. Use this skill to guide the preparation of Newick trees and CSV annotation tables, select appropriate inference models (like MPPA), and generate both compressed and full-tree visualizations.

## Input Requirements
PastML requires two primary files for any analysis:
- **Rooted Tree**: Must be in Newick format. The tree can be dated or undated but must be rooted (e.g., via outgroup or LSD).
- **Annotation Table**: A CSV file where the first column contains tip IDs matching the tree labels. Subsequent columns contain the discrete states (e.g., Country, Mutation presence).

## Core CLI Usage
The primary command for running an analysis is `pastml`.

### Basic Reconstruction
```bash
pastml --tree tree.nwk --data data.csv --columns Country --output result.html
```

### Recommended Method: MPPA
The **Marginal Posterior Probabilities Approximation (MPPA)** is the recommended method as it minimizes prediction error and can handle state ambiguity by predicting a subset of likely states.
```bash
pastml --tree tree.nwk --data data.csv --columns Country --method MPPA --model F81 --output mppa_result.html
```

### Alternative Methods
- **Maximum Likelihood (ML)**:
  - `MAP`: Maximum a posteriori (chooses the single most probable state per node).
  - `JOINT`: Reconstructs the scenario with the highest overall likelihood.
- **Maximum Parsimony (MP)**:
  - `DOWNPASS`, `ACCTRAN`, or `DELTRAN`. Use these for quick, non-probabilistic estimates that ignore branch lengths.

### Evolution Models
- `F81` (Recommended): Optimized equilibrium frequencies.
- `JC`: Equal frequencies and rates.
- `EFT`: Frequencies estimated directly from tip proportions (not recommended for biased sampling).

## Visualization Features
PastML generates interactive HTML files. By default, it applies compression to make large trees readable:
- **Vertical Merge**: Clusters parts of the tree where no state change occurs.
- **Horizontal Merge**: Clusters independent identical events to simplify the view.
- **Trimming**: For extremely large trees, PastML hides minor details to focus on the main ancestral transitions.

## Expert Tips
- **Handling Unknown States**: If a tip state is unknown, leave it blank in the CSV or omit the row; PastML will infer it during the ACR process.
- **Ambiguous States**: To restrict a tip to multiple possible states (e.g., "UK" or "France"), provide multiple rows for that tip ID in the annotation file, each with one of the possible states.
- **Internal Nodes**: If you have known states for internal nodes, ensure the Newick tree has named internal nodes and include those names in the ID column of your CSV.
- **Separator Issues**: If your CSV uses tabs or specific characters, specify it with the `--sep` flag (e.g., `--sep ','` for standard CSV).

## Reference documentation
- [PastML Help and Methodology](./references/pastml_pasteur_fr_help.md)
- [Input Data and Examples](./references/pastml_pasteur_fr_index.md)
- [Installation and CLI Overview](./references/pastml_pasteur_fr_install.md)