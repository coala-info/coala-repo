---
name: goenrichment
description: The goenrichment tool performs statistical analysis to identify significantly enriched Gene Ontology terms within a set of genes. Use when user asks to perform GO enrichment analysis, find overrepresented biological functions, or generate visual graphs of enriched ontology terms.
homepage: https://github.com/DanFaria/GOEnrichment
metadata:
  docker_image: "quay.io/biocontainers/goenrichment:2.0.1--0"
---

# goenrichment

## Overview
The goenrichment tool is designed to statistically evaluate sets of genes to find significantly enriched GO terms. It processes ontology files (OBO/OWL) and annotation data (GAF/BLAST2GO/Tabular) to generate results for Molecular Function (MF), Biological Process (BP), and Cellular Component (CC) categories. It provides both tabular statistical summaries and visual graph representations of the enriched terms.

## Command Line Usage

### Basic Enrichment Analysis
Run a standard analysis using the mandatory ontology, annotation, and study set files:
```bash
goenrichment -g ontology.obo -a annotations.gaf -s study_genes.txt
```

### Advanced Configuration
Customize the statistical parameters and output formats:
```bash
goenrichment -g ontology.owl \
             -a annotations.txt \
             -s study.txt \
             -p population.txt \
             -c Benjamini-Hochberg \
             -o 0.05 \
             -gf SVG \
             -so
```

## Parameters and Options

### Input Files (Mandatory)
- `-g, --go`: Path to the Gene Ontology file (OBO or OWL format).
- `-a, --annotation`: Path to the annotation file (GAF, BLAST2GO, or 2-column tabular format).
- `-s, --study`: Path to the file listing gene IDs in the study set (one per line).

### Statistical Options
- `-p, --population`: Path to the background population gene list. If omitted, all genes in the annotation file are used.
- `-c, --correction`: Multiple test correction strategy. Options: `Bonferroni`, `Bonferroni-Holm`, `Sidak`, `SDA`, `Benjamini-Hochberg` (Default).
- `-o, --cut_off`: Significance threshold for q-values or corrected p-values (Default: 0.01).
- `-e, --exclude_singletons`: Exclude GO terms annotated to only one gene in the study set.

### Output and Visualization
- `-gf, --graph_format`: Format for output graphs. Options: `PNG`, `SVG`, `TXT` (Default: PNG).
- `-so, --summarize_output`: Remove closely related/redundant terms to simplify the results.
- `-r, --use_all_relations`: Infer annotations through 'part_of' and other non-hierarchical relations.

### Custom Output Paths
- `-mfr, --mf_result`: Path for Molecular Function results.
- `-bpr, --bp_result`: Path for Biological Process results.
- `-ccr, --cc_result`: Path for Cellular Component results.
- `-mfg, --mf_graph`: Path for Molecular Function graph.

## Best Practices and Tips

- **ID Matching**: Ensure the gene IDs in your Study Set and Population Set files exactly match the IDs used in the first column of your Annotation file.
- **Ontology Selection**: Use GOSlim files for a higher-level, less granular overview of functional enrichment.
- **Redundancy Reduction**: Always consider using the `-so` (summarize output) flag when dealing with large sets of enriched terms to make the results more interpretable.
- **Relation Inference**: Use the `-r` flag if your research context requires accounting for `part_of` relations, which are common in developmental and anatomical GO terms.
- **Graph Interpretation**: When using `TXT` as a graph format, the tool produces a list of relations that can be imported into other network visualization software.

## Reference documentation
- [GOEnrichment Overview](./references/anaconda_org_channels_bioconda_packages_goenrichment_overview.md)
- [GOEnrichment GitHub Documentation](./references/github_com_DanFaria_GOEnrichment.md)