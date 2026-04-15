---
name: bioconductor-reportingtools
description: ReportingTools automates the creation of interactive HTML reports and tables from R objects and genomic analysis results. Use when user asks to create interactive HTML reports, publish differential expression results from limma or DESeq2, or generate web-based summaries for gene enrichment analysis.
homepage: https://bioconductor.org/packages/release/bioc/html/ReportingTools.html
---

# bioconductor-reportingtools

## Overview

ReportingTools is a Bioconductor package designed to automate the creation of rich, interactive HTML reports. It transforms complex R objects (like data frames, linear model fits, or enrichment results) into web-based tables with built-in sorting and filtering. It is particularly powerful for genomic workflows, providing specialized methods for `limma`, `edgeR`, `DESeq2`, and `GOstats` objects.

## Core Workflow

The general pattern for creating a report involves three steps:
1.  **Initialize**: Create an `HTMLReport` or `CSVFile` object.
2.  **Publish**: Add data, plots, or text to the report using the `publish` function.
3.  **Finish**: Call `finish` to write the final files to disk.

```r
library(ReportingTools)
# 1. Initialize
myRep <- HTMLReport(shortName = "my_report", title = "Analysis Results", reportDirectory = "./reports")

# 2. Publish
publish(my.df, myRep)

# 3. Finish
finish(myRep)
```

## Specialized Analysis Workflows

### Microarray (limma)
To report differential expression from a `limma` fit, provide the `eSet` and the factor used in the model.
```r
# fit is an MArrayLM object
publish(fit, deReport, eSet = ALL, factor = ALL$mol.biol, coef = 2, n = 100)
```

### RNA-seq (edgeR and DESeq2)
ReportingTools handles `DGEExact`, `DGELRT`, and `DESeqDataSet` objects directly.
```r
# edgeR
publish(edgeR.de, deReport, countTable = counts, conditions = conditions, annotation.db = 'org.Mm.eg')

# DESeq2
publish(dds, deReport, pvalueCutoff = 0.05, annotation.db = "org.Mm.eg.db")
```

### Enrichment Analysis (GO and PFAM)
You can publish results from `GOHyperGResult` or `PFAMHyperGResult` objects.
```r
# goResults is a GOHyperGResult
publish(goResults, goReport, selectedIDs = genesOfInteresting, annotation.db = "org.Hs.eg")
```

## Customizing Reports

### Adding Plots and Links
You can publish R plots (lattice, ggplot2, or recorded base plots) and use `hwriter` for custom HTML elements.
```r
# Add a plot
publish(myPlot, myRep, name = "scatterPlot")

# Add a link using hwriter
library(hwriter)
publish(hwrite("Bioconductor", link = "http://www.bioconductor.org"), myRep)
```

### Modifying Data Frames (.modifyDF)
Use the `.modifyDF` argument in `publish` to transform data before it is rendered (e.g., adding custom links or image tags to table cells).
```r
# Function to add a custom column
addLink <- function(df, ...){
    df$Link <- hwrite("Details", link = paste0("http://site.com/", df$ID), table = FALSE)
    return(df)
}
publish(my.df, myRep, .modifyDF = addLink)
```

### Creating Index Pages
Link multiple reports together into a single project dashboard.
```r
indexPage <- HTMLReport(shortName = "index", reportDirectory = "./reports")
publish(Link(list(deReport, goReport), report = indexPage), indexPage)
finish(indexPage)
```

## Tips for Success
*   **Directory Management**: ReportingTools creates the `reportDirectory` if it doesn't exist.
*   **Finishing**: Always call `finish(reportObject)` or the HTML file will not be properly closed/written.
*   **Shiny Integration**: Use `shinyHandlers` and `renderRepTools` to embed interactive ReportingTools tables within a Shiny UI.

## Reference documentation
- [Basics of ReportingTools](./references/basicReportingTools.md)
- [Using ReportingTools in an Analysis of Microarray Data](./references/microarrayAnalysis.md)
- [Using ReportingTools in an Analysis of RNA-seq Data](./references/rnaseqAnalysis.md)
- [Using ReportingTools within Shiny Applications](./references/shiny.md)