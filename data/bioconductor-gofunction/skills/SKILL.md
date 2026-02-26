---
name: bioconductor-gofunction
description: This tool performs Gene Ontology enrichment analysis while treating local and global redundancy to identify biologically meaningful terms. Use when user asks to identify significant GO terms from gene lists, handle redundant or overlapping GO structures, or filter GO enrichment results for final significant terms.
homepage: https://bioconductor.org/packages/3.6/bioc/html/GOFunction.html
---


# bioconductor-gofunction

name: bioconductor-gofunction
description: Gene Ontology (GO) enrichment analysis with redundancy treatment. Use this skill to identify statistically significant and biologically meaningful GO terms from gene lists, specifically when needing to handle local and global redundancy in GO structures.

## Overview
The `GOFunction` package provides a specialized approach to GO enrichment analysis. Unlike standard tools that may return many redundant, overlapping GO terms due to the hierarchical nature of the Gene Ontology, `GOFunction` applies specific rules to filter out local and global redundancy. It identifies "Final" terms that are both statistically interpretable and biologically meaningful, distinguishing them from terms that are significant only because of overlapping genes or child-parent relationships.

## Typical Workflow

1.  **Prepare Input Data**:
    *   `interestGenes`: A character vector of Entrez Gene IDs (e.g., differentially expressed genes).
    *   `refGenes`: A character vector of Entrez Gene IDs for the background/reference set (e.g., all genes on the microarray).

2.  **Install Annotation Dependencies**:
    Ensure the organism-specific `org.XX.eg.db` package is installed (e.g., `org.Hs.eg.db` for Human).

3.  **Run Enrichment Analysis**:
    Use the main `GOFunction` function to perform the analysis and redundancy treatment.

```r
library(GOFunction)

# Example using internal data
data(exampledata)

# Run the main function
sigTerm <- GOFunction(
  interestGenes = interestGenes, 
  refGenes = refGenes, 
  organism = "org.Hs.eg.db", # Change based on species
  ontology = "BP",           # "BP", "CC", or "MF"
  fdrmethod = "BY",          # "bonferroni", "BH", or "BY"
  fdrth = 0.05,              # FDR threshold
  filename = "my_results"    # Base name for .csv and .bmp output
)
```

## Key Parameters
*   **organism**: Supports 18 organisms (e.g., "org.Mm.eg.db" for Mouse, "org.Rn.eg.db" for Rat).
*   **Redundancy Thresholds**:
    *   `ppth`: Significance level for testing ancestor terms after removing significant offspring genes.
    *   `pcth`: Significance level for comparing frequency of genes between offspring and ancestor.
    *   `poth`: Significance level for testing overlapping vs non-overlapping genes.
    *   `peth`: Significance level for testing if non-overlapping genes are enriched.
*   **bmpSize**: Default is 2000. Increase if the GO DAG is complex; decrease if the `bmp()` function throws an error.

## Interpreting Results
The function produces a CSV file and a BMP image. The `FinalResult` column in the output table categorizes terms:
*   **Local**: Terms removed during local redundancy treatment (redundancy within a branch). Represented as **circles** in the DAG plot.
*   **Global**: Terms removed during global redundancy treatment (redundancy across different branches). Represented as **boxes** in the DAG plot.
*   **Final**: Terms that remain after all treatments, showing strong evidence of independent biological significance. Represented as **rectangles** in the DAG plot.

## Tips
*   **Entrez IDs**: Ensure input gene lists are strictly Entrez IDs. Use `AnnotationDbi` to convert symbols or Ensembl IDs if necessary.
*   **Graphviz**: The visualization step requires the `Rgraphviz` package and the system-level `graphviz` tool to be installed and in the system PATH.
*   **Memory/Size**: If the GO DAG is too large to render, focus on a more stringent `fdrth` or adjust the `bmpSize`.

## Reference documentation
- [GOFunction](./references/GOFunction.md)