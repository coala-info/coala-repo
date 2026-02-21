---
name: bioconductor-cummerbund
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/cummeRbund.html
---

# bioconductor-cummerbund

name: bioconductor-cummerbund
description: Analysis, exploration, and visualization of Cufflinks high-throughput sequencing data. Use this skill when a user needs to process output from the Cufflinks suite (Cuffdiff), perform differential expression analysis, create expression plots (heatmaps, scatter plots, volcano plots), or manage Cuffdiff data using the SQLite backend in R.

# bioconductor-cummerbund

## Overview
cummeRbund is a Bioconductor package designed to simplify the analysis and visualization of results from a Cufflinks RNA-Seq experiment. It takes the output files from `cuffdiff` and parses them into a local SQLite database, allowing for persistent storage and efficient querying of large datasets. It provides high-level plotting functions using `ggplot2` to visualize differential expression, isoform usage, and sample relationships.

## Core Workflow

### 1. Data Ingestion
The primary entry point is `readCufflinks()`. By default, it looks for Cuffdiff output files in the current working directory.

```r
library(cummeRbund)

# Read cuffdiff output and create/connect to SQLite database
cuff <- readCufflinks(dir = "path/to/cuffdiff_out", rebuild = FALSE)

# Access specific data levels
genes.data <- genes(cuff)
isoforms.data <- isoforms(cuff)
tss.data <- TSS(cuff)
cds.data <- CDS(cuff)
```

### 2. Identifying Differentially Expressed Features
Use `getSig()` to retrieve identifiers for genes or features that are significantly differentially expressed.

```r
# Get IDs of significant genes (default alpha = 0.05)
sigGeneIds <- getSig(cuff, alpha = 0.05, level = "genes")

# Get a CuffGeneSet object for these significant genes
sigGenes <- getGenes(cuff, sigGeneIds)
```

### 3. Visualization
cummeRbund provides several specialized plotting functions.

*   **Global Distributions**:
    ```r
    # Density plot of FPKM values
    csDensity(genes(cuff))
    # Boxplot of FPKM values
    csBoxplot(genes(cuff))
    # Scatter plot between two conditions
    csScatter(genes(cuff), "control", "treatment")
    ```
*   **Differential Expression**:
    ```r
    # Volcano plot
    csVolcano(genes(cuff), "control", "treatment")
    ```
*   **Gene-Specific Plots**:
    ```r
    # Retrieve a specific gene by ID or symbol
    myGene <- getGene(cuff, "GAPDH")
    
    # Expression barplot
    expressionBarplot(myGene)
    # Expression plot over time/conditions
    expressionPlot(myGene)
    ```
*   **Clustering and Heatmaps**:
    ```r
    # Heatmap of significant genes
    csHeatmap(sigGenes, cluster = "both")
    # Dendrogram of sample relationships
    csDendro(genes(cuff))
    ```

### 4. Data Extraction
To get raw data frames for custom analysis:
```r
# Get FPKM values
gene_fpkm <- fpkm(genes(cuff))

# Get differential expression test results
gene_diff <- diffData(genes(cuff))
```

## Tips and Best Practices
- **Database Persistence**: `readCufflinks` creates a file named `cuffData.db`. In future sessions, you can point to this directory to reload the data instantly without re-parsing the text files.
- **Memory Management**: For very large datasets, use `getGenes()` to create a `CuffGeneSet` containing only the genes of interest rather than performing operations on the entire `CuffSet`.
- **Replicates**: If your Cuffdiff run included replicates, use `csDispersion()` to visualize the model fit and `replicates = TRUE` in plotting functions to see individual replicate FPKM values.
- **Feature Levels**: Most functions accept a `level` argument (e.g., 'genes', 'isoforms', 'TSS', 'CDS') to switch the granularity of the analysis.

## Reference documentation
- [cummeRbund Bioconductor Page](https://bioconductor.org/packages/release/bioc/html/cummeRbund.html)