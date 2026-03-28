---
name: phylorank
description: PhyloRank is a tool for the manual taxonomic curation of phylogenetic trees using Relative Evolutionary Divergence to ensure rank consistency. Use when user asks to decorate a tree with taxonomy, identify taxonomic outliers, or calculate Relative Evolutionary Divergence values.
homepage: https://github.com/dparks1134/PhyloRank
---

# phylorank

## Overview
PhyloRank is a specialized tool for the manual taxonomic curation of phylogenetic trees, particularly those spanning the bacterial or archaeal domains. It implements the methodology used by the Genome Taxonomy Database (GTDB) to ensure that taxonomic ranks are applied consistently across the tree of life. By calculating Relative Evolutionary Divergence (RED), it allows researchers to identify taxa that are misplaced or inconsistently ranked relative to their evolutionary depth.

## Installation
PhyloRank requires Python 3 and can be installed via Bioconda or PyPI:
- `conda install -c bioconda phylorank`
- `pip install phylorank`

## Core Workflows

### 1. Decorating a Tree with Taxonomy
Use this command to map taxonomic labels onto an undecorated Newick tree. It determines the best placement for each taxon by maximizing the F-measure (balancing precision and recall).

```bash
phylorank decorate <input_tree> <taxonomy_file> <output_tree> --skip_rd_refine
```

**Best Practices:**
- **Initial Pass:** Always use the `--skip_rd_refine` flag during the first iteration. Adjusting for RED is only recommended after the taxonomy and tree topology are confirmed to be largely congruent.
- **Output Files:** This command generates three files:
  - `<output_tree>`: The decorated Newick tree.
  - `<output_tree>-table`: Contains F-measure, precision, and recall scores for each taxon.
  - `<output_tree>-taxonomy`: The final assigned taxonomy for each genome.

### 2. Identifying Taxonomic Outliers (RED Calculation)
Once a tree is decorated, use the `outliers` command to calculate RED values. This identifies taxa at a specific rank that have "conspicuous" placements (i.e., they are too deep or too shallow compared to other taxa at that same rank).

```bash
phylorank outliers <decorated_tree> <taxonomy_file> <output_dir>
```

**Key Considerations:**
- **Congruence:** Ensure the decorated tree and the taxonomy file are congruent.
- **Singletons:** The taxonomy file is essential because it provides affiliations for species with only a single representative (which lack an internal node in the tree).
- **Visualization:** The output directory will contain a table of RED values and a plot visualizing the distribution of RED values across different ranks.

## File Formats
- **Input Tree:** Standard Newick format.
- **Taxonomy File:** A tab-separated (TSV) file with two columns:
  1. Genome ID (matching the leaf names in the tree).
  2. Greengenes-style taxonomy string (e.g., `d__Bacteria;p__Proteobacteria;c__Alphaproteobacteria;o__Rhodobacterales;f__Rhodobacteraceae;g__Yangia;s__`).

## Expert Tips
- **GTDB Integration:** If your goal is simply to classify genomes according to the GTDB methodology, use **GTDB-Tk** instead. PhyloRank is intended for users building or curating their own custom trees.
- **Polyphyletic Groups:** If the provided taxonomy is incongruent with the tree topology, PhyloRank will only label the most cohesive lineage of a polyphyletic group.
- **Nested Ranks:** In cases of high incongruency, you may see nested labels (e.g., two different genus labels in the same lineage). Use the F-measure scores in the output table to identify and resolve these conflicts manually.



## Subcommands

| Command | Description |
|---------|-------------|
| phylorank bl_decorate | Decorate tree using a mean branch length criterion. |
| phylorank bl_dist | Calculate distribution of branch lengths at each taxonomic rank. |
| phylorank bl_optimal | Determine branch length for best congruency with existing taxonomy. |
| phylorank bl_table | Generate a branch length table for a given input tree and taxon category. |
| phylorank compare_red | Compare RED (Relative Evolutionary Divergence) tables and dictionaries. |
| phylorank decorate | Place internal taxonomic labels on tree. |
| phylorank mark_tree | Mark nodes with distribution information and predicted taxonomic ranks. |
| phylorank outliers | Create information for identifying taxonomic outliers |
| phylorank rank_res | Calculate rank results based on an input tree and taxonomy. |
| phylorank rogue_test | Perform rogue taxon testing within the phylorank suite. |
| phylorank scale_tree | Scale a phylogenetic tree using phylorank |
| phylorank taxon_stats | Calculate taxon statistics based on a taxonomy file. |

## Reference documentation
- [PhyloRank GitHub Repository](./references/github_com_donovan-h-parks_PhyloRank.md)