---
name: grimer
description: GRIMER transforms microbiome taxonomic profiles into interactive dashboards for quality control and contamination detection. Use when user asks to generate interactive microbiome visualizations, identify potential contaminants by correlating abundance with metadata, or fetch and analyze study data from the MGnify database.
homepage: https://github.com/pirovc/grimer
---


# grimer

## Overview
GRIMER (Genomic Research Integration for Microbiome Exploration and Review) is a bioinformatics tool designed to transform microbiome taxonomic profiles into interactive, portable dashboards. It is particularly useful for quality control, as it automates the process of identifying potential contaminants by correlating taxonomic abundance with sample metadata (such as DNA concentration or experimental batches). By integrating taxonomy, metadata, and functional annotations, it provides a study-level overview that helps researchers distinguish biological signals from technical artifacts.

## Installation and Setup
The most reliable way to install GRIMER is via Bioconda:

```bash
conda install -c bioconda grimer
```

## Core Usage Patterns

### Standard Analysis
The primary workflow involves providing a taxonomic table (typically in BIOM format) and a corresponding metadata file. GRIMER processes these to generate a Bokeh-based interactive HTML dashboard.

*   **Input Requirements**: Ensure your metadata file contains fields that can be used for contamination detection, such as "is_control" or "quant_reading" (DNA concentration).
*   **Output**: The tool generates a directory containing the `index.html` dashboard and associated data files.

### Working with MGnify Data
GRIMER includes a specific utility for fetching and analyzing data from the EBI MGnify database:

```bash
python grimer-mgnify.py -a <MGnify_Accession>
```
This script automates the download of study data and prepares it for visualization within the GRIMER framework.

## Expert Tips and Best Practices

### Contamination Detection (Decontam)
GRIMER implements logic similar to the "decontam" approach. To maximize the effectiveness of this feature:
*   **Metadata Quality**: Include a numeric column for DNA concentration. Contaminants often show an inverse correlation between concentration and relative abundance.
*   **Control Samples**: Clearly label negative controls in your metadata. GRIMER uses these to identify taxa that are prevalent in controls but absent or low-abundance in true samples.

### Dashboard Navigation
The generated dashboard is interactive. Use the following features for deeper exploration:
*   **Taxonomy Filtering**: Use the sidebar to filter by specific taxonomic ranks or abundance thresholds.
*   **Metadata Grouping**: Group samples by metadata categories (e.g., "Treatment", "Location") to see if taxonomic distributions align with experimental variables.
*   **Heatmaps**: Utilize the integrated heatmaps to observe clustering patterns across samples and taxa simultaneously.

### Configuration
GRIMER uses a configuration system to manage default parameters. If you need to customize the visualization (e.g., changing color palettes or default thresholds), check the `config/` directory within the installation or repository for the YAML-based configuration logic (though execution remains CLI-driven).

## Reference documentation
- [Anaconda Bioconda GRIMER Overview](./references/anaconda_org_channels_bioconda_packages_grimer_overview.md)
- [GRIMER GitHub Repository](./references/github_com_pirovc_grimer.md)
- [GRIMER Tags and Version History](./references/github_com_pirovc_grimer_tags.md)