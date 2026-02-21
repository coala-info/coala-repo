---
name: phylorank
description: PhyloRank is a specialized tool for the manual and automated curation of microbial taxonomies within a phylogenetic context.
homepage: https://github.com/dparks1134/PhyloRank
---

# phylorank

## Overview
PhyloRank is a specialized tool for the manual and automated curation of microbial taxonomies within a phylogenetic context. It allows you to evaluate whether current taxonomic assignments (like those in GTDB) are consistent with the topology and branch lengths of a tree. Its primary strengths are calculating RED values—a metric used to normalize taxonomic ranks across the tree of life—and "decorating" trees by finding the optimal placement for taxonomic labels to maximize congruency.

## Usage Patterns

### Decorating a Tree with Taxonomy
Use this command to map a taxonomy file onto a Newick tree. It calculates the best placement for each taxon based on the F-measure (precision and recall).

```bash
phylorank decorate <input_tree.nwk> <taxonomy.tsv> <output_tree.decorated.tree> --skip_rd_refine
```

*   **Expert Tip**: Always use `--skip_rd_refine` during initial passes. Only remove this flag once you have confirmed the taxonomy and topology are largely congruent and you wish to adjust placements based on evolutionary divergence.
*   **Outputs**: 
    *   `<output_tree>-table`: Contains F-measure, precision, and recall for each taxon.
    *   `<output_tree>-taxonomy`: The resulting assigned taxonomy for each genome.

### Calculating RED and Identifying Outliers
Once a tree is decorated, use the `outliers` command to calculate Relative Evolutionary Divergence (RED). This identifies taxa that are placed too deep or too shallow for their assigned rank.

```bash
phylorank outliers <decorated_tree.tree> <taxonomy.tsv> <output_dir>
```

*   **Input Requirement**: The tree must be "decorated" (contain taxonomic information at internal nodes).
*   **Analysis**: Check the generated plots in the output directory to visualize the distribution of RED values across different ranks (e.g., Phylum, Class, Order).

## File Formats
PhyloRank requires a specific tab-separated taxonomy format (Greengenes/GTDB style):
*   **Format**: `Genome_ID <tab> d__Domain;p__Phylum;c__Class;o__Order;f__Family;g__Genus;s__Species`
*   **Example**: `GCF_001687105.1    d__Bacteria;p__Proteobacteria;c__Alphaproteobacteria;o__Rhodobacterales;f__Rhodobacteraceae;g__Yangia;s__`

## Best Practices
*   **GTDB Compatibility**: If your goal is standard classification against the Genome Taxonomy Database, use `GTDB-Tk`. Use `PhyloRank` specifically for custom tree curation or developing new taxonomic frameworks.
*   **Congruency**: Ensure your taxonomy file and tree leaf names match exactly. Discrepancies will lead to poor F-measure scores and inaccurate RED calculations.
*   **Manual Curation**: Use the F-measure table from the `decorate` command to identify polyphyletic groups. Low precision or recall often indicates that a taxonomic group is split across the tree or contains unrelated members.

## Reference documentation
- [PhyloRank GitHub Repository](./references/github_com_donovan-h-parks_PhyloRank.md)