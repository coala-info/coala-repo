---
name: export2graphlan
description: export2graphlan is a preprocessing utility designed to bridge the gap between microbial community profiling tools and GraPhlAn visualization.
homepage: https://github.com/segatalab/export2graphlan
---

# export2graphlan

## Overview

export2graphlan is a preprocessing utility designed to bridge the gap between microbial community profiling tools and GraPhlAn visualization. It automates the creation of the two mandatory GraPhlAn input files: the phylogenetic tree structure and the corresponding annotation file. By parsing abundance tables and biomarker results, it automatically infers which clades should be highlighted, colored, or labeled, significantly reducing the manual effort required to produce publication-quality circular cladograms.

## Core Usage Patterns

### Basic Conversion (MetaPhlAn/HUMAnN)
To generate GraPhlAn inputs from a standard abundance table:
```bash
export2graphlan.py -i input_abundance.txt -t output.tree.txt -a output.annot.txt
```

### Integrating LEfSe Biomarkers
When you have performed a LEfSe analysis and want to highlight significant biomarkers:
```bash
export2graphlan.py -i lefse_input.txt -o lefse_output.res -t output.tree.txt -a output.annot.txt
```

### Visual Customization
*   **Highlighting Levels**: Use `--background_levels` to add shaded backgrounds to specific taxonomic ranks (e.g., 1 for Kingdom, 2 for Phylum).
*   **Specific Clade Highlighting**: Use `--background_clades` followed by the full taxonomic path to emphasize specific groups.
*   **Color Mapping**: Provide colors in hex or RGB/HSV format using `--background_colors`.

## Expert Tips and Best Practices

*   **Abundance Filtering**: Use `--abundance_threshold` (default 20.0) to prevent the tree from becoming overcrowded with labels for low-abundance organisms.
*   **Handling Missing Biomarkers**: If you do not have LEfSe output but want to highlight important clades, use `--most_abundant` to automatically select the top N clades based on the input abundance file.
*   **Taxonomy Cleaning**: The tool defaults to keeping OTU IDs. If your taxonomy contains trailing OTU identifiers that clutter the visualization, ensure they are formatted correctly or use `--discard_otus` if applicable to your version's specific parsing logic.
*   **Font and Clade Scaling**: Adjust `--min_clade_size` and `--max_clade_size` to ensure that biomarker nodes are visually distinct from non-significant nodes.
*   **Downstream Workflow**: Remember that the output of this tool is only the first step. You must follow this with:
    1. `graphlan_annotate.py --annot output.annot.txt output.tree.txt output.xml`
    2. `graphlan.py output.xml output_image.png`

## Reference documentation
- [GitHub - SegataLab/export2graphlan](./references/github_com_SegataLab_export2graphlan.md)
- [export2graphlan - bioconda](./references/anaconda_org_channels_bioconda_packages_export2graphlan_overview.md)