---
name: bioconductor-geneanswers
description: GeneAnswers performs statistical enrichment analysis and provides integrated visualization for gene lists. Use when user asks to perform enrichment tests against GO or KEGG, visualize concept-gene networks, generate heatmaps of gene expression data, or map Entrez IDs to gene symbols.
homepage: https://bioconductor.org/packages/3.8/bioc/html/GeneAnswers.html
---


# bioconductor-geneanswers

## Overview

GeneAnswers is a Bioconductor package designed for the integrated interpretation of gene lists. It bridges the gap between raw gene lists (e.g., from microarrays or NGS) and biological meaning by performing statistical enrichment tests against various categories, including Gene Ontology (GO), KEGG pathways, and Disease Ontology (DOLite). Its primary strength lies in its visualization capabilities, offering interactive concept-gene networks and cross-tabulation heatmaps that integrate gene expression data with functional annotations.

## Core Workflow

### 1. Data Preparation
The package requires a character vector of Entrez Gene IDs. Optionally, you can provide a data frame where the first column is Entrez IDs and subsequent columns contain values like fold-change or p-values.

```r
library(GeneAnswers)
data(humanGeneInput)
data(humanExpr)
# humanGeneInput: Col 1 = EntrezID, Col 2 = foldChange, Col 3 = pValue
```

### 2. Building a GeneAnswers Object
The `geneAnswersBuilder` function is the central constructor. It performs the enrichment test and stores the results.

```r
# Basic GO Biological Process enrichment
x <- geneAnswersBuilder(humanGeneInput, 'org.Hs.eg.db', categoryType='GO.BP', testType='hyperG')

# KEGG pathway enrichment with expression profile and FDR correction
y <- geneAnswersBuilder(humanGeneInput, 'org.Hs.eg.db', categoryType='KEGG', 
                        testType='hyperG', pvalueT=0.1, FDR.correction=TRUE, 
                        geneExpressionProfile=humanExpr)
```

### 3. Making Results Readable
By default, objects use Entrez IDs and Category IDs. Use `geneAnswersReadable` to map these to Gene Symbols and Category Terms.

```r
x_read <- geneAnswersReadable(x)
```

### 4. Visualization
GeneAnswers provides several ways to visualize the enrichment:

*   **Chart Plots**: Standard barplots and pie charts of top categories.
    ```r
    geneAnswersChartPlots(x_read, chartType='all')
    ```
*   **Concept-Gene Network**: Shows how genes link to specific categories. Nodes are colored by fold-change if provided.
    ```r
    geneAnswersConceptNet(x_read, colorValueColumn='foldChange', centroidSize='pvalue', output='interactive')
    ```
*   **Heatmaps (Cross-tabulation)**: Integrates expression profiles with category membership.
    ```r
    geneAnswersHeatmap(x_read, catTerm=TRUE, geneSymbol=TRUE)
    ```
*   **Concept Relation**: Shows the relationship between GO terms (ontology structure).
    ```r
    geneAnswersConceptRelation(x, direction='both', netMode='connection')
    ```

## Advanced Features

### Custom Annotations
You can use `searchEntrez` to create custom annotation libraries based on NCBI keywords.
```r
keywordsList <- list(Apoptosis=c("apoptosis"), CellAdhesion=c("cell adhesion"))
entrezIDList <- searchEntrez(keywordsList)
q <- geneAnswersBuilder(humanGeneInput, entrezIDList, testType='hyperG')
```

### Multigroup Analysis
To compare enrichment across multiple experiments or time points:
```r
# Assuming a list of geneInputs
gAList <- lapply(sampleGroupsData, geneAnswersBuilder, 'org.Hs.eg.db', categoryType='KEGG')
outputTable <- getConceptTable(gAList, items='geneNum')
```

### Homologous Mapping
If working with non-human species (e.g., Mouse) but wanting to use human-centric databases like DOLite:
1.  Map IDs to human: `getHomoGeneIDs(mouseIDs, species='mouse', speciesL='human', mappingMethod='direct')`
2.  Run `geneAnswersBuilder` on human IDs.
3.  Map back: `geneAnswersHomoMapping(v, species='human', speciesL='mouse')`

### Word Clouds (ListGIF)
Use `getListGIF` to generate word-cloud visualizations of enriched terms via the ListGIF web server.
```r
glist <- c("MRPS35", "NBL1", "PSMD14")
getListGIF(glist=glist, type="genelevel", output="cloud.png")
```

## Tips for Success
*   **Entrez IDs**: Ensure your input IDs are character strings of Entrez IDs.
*   **Annotation Libraries**: Always match the `annLib` (e.g., 'org.Hs.eg.db') to the species of your input genes.
*   **Interactive Mode**: For complex networks, use `output='interactive'` to manually adjust the layout in the tcl/tk window.
*   **Sorting**: Use `geneAnswersSort(x, sortBy='pvalue')` to prioritize specific results before plotting.

## Reference documentation
- [GeneAnswers: Integrated Interpretation of Genes](./references/geneAnswers.md)
- [getListGIF: Visual Annotation Utility](./references/getListGIF.md)