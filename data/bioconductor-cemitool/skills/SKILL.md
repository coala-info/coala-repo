---
name: bioconductor-cemitool
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/CEMiTool.html
---

# bioconductor-cemitool

name: bioconductor-cemitool
description: Automated gene co-expression network analysis, module identification, and functional enrichment using the CEMiTool R package. Use this skill when you need to identify gene modules from expression data, perform Gene Set Enrichment Analysis (GSEA), Over Representation Analysis (ORA), or visualize gene interactions and expression profiles across different sample classes.

# bioconductor-cemitool

## Overview
CEMiTool (Co-expression Modules Identification Tool) is a Bioconductor package that streamlines the identification of gene co-expression modules. It integrates several steps of a standard systems biology workflow into a single automated pipeline, including gene filtering, module discovery, enrichment analysis (GSEA and ORA), and network visualization. It is particularly useful for identifying biologically relevant gene clusters that correlate with specific experimental conditions or phenotypes.

## Basic Workflow
The most efficient way to use CEMiTool is through the primary `cemitool()` function, which can handle the entire pipeline if provided with the necessary inputs.

```r
library(CEMiTool)

# 1. Load data (Expression data: genes in rows, samples in columns)
data(expr0)
data(sample_annot) # Optional: SampleName and Class columns
data(interactions) # Optional: gene1 and gene2 columns

# 2. Run the full pipeline
cem <- cemitool(expr = expr0, 
                annot = sample_annot, 
                interactions = interactions,
                filter = TRUE, 
                plot = TRUE, 
                verbose = TRUE)

# 3. Generate outputs
generate_report(cem, directory="./Report")
write_files(cem, directory="./Tables")
save_plots(cem, "all", directory="./Plots")
```

## Key Functions and Procedures

### Module Inspection
After running the analysis, you can inspect the resulting modules and identify hub genes.
- `nmodules(cem)`: Returns the number of identified modules.
- `module_genes(cem)`: Returns a data frame mapping genes to modules. Genes labeled "Not.Correlated" did not fit into a specific module.
- `get_hubs(cem, n=10)`: Identifies the top `n` most connected genes in each module.
- `mod_summary(cem)`: Provides a summary statistic (mean or eigengene) for each module.

### Functional Enrichment
CEMiTool supports two types of enrichment to provide biological context:
- **ORA (Over Representation Analysis)**: Requires a GMT file.
  ```r
  gmt_in <- read_gmt("pathways.gmt")
  cem <- mod_ora(cem, gmt_in)
  cem <- plot_ora(cem)
  ```
- **GSEA (Gene Set Enrichment Analysis)**: Automatically runs if `sample_annot` is provided to show how modules are regulated across classes.
  ```r
  cem <- mod_gsea(cem)
  cem <- plot_gsea(cem)
  ```

### Visualization
Visualizations are stored within the CEMiTool object and can be viewed using `show_plot`.
- `show_plot(cem, "profile")`: Displays gene expression patterns within modules.
- `show_plot(cem, "gsea")`: Shows module enrichment across sample classes.
- `show_plot(cem, "interaction")`: Displays the interaction network for modules (requires interaction data).
- `show_plot(cem, "ora")`: Shows significantly enriched pathways.

## Troubleshooting and Diagnostics
If the automated pipeline fails or produces unexpected results, use the diagnostic tool:
```r
diagnostic_report(cem)
```
This generates plots to evaluate:
- **Sample Clustering**: Detects batch effects or outliers.
- **Mean x Variance**: Checks if Variance Stabilizing Transformation (`apply_vst = TRUE`) is needed, common for RNA-seq.
- **Beta x R2**: Evaluates the soft-thresholding parameter for scale-free topology.

## Reference documentation
- [CEMiTool: Co-expression Modules Identification Tool](./references/CEMiTool.md)