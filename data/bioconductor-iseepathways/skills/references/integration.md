Code

* Show All Code
* Hide All Code

# Integration with other panels

Kevin Rue-Albrecht1\*

1University of Oxford

\*kevin.rue-albrecht@imm.ox.ac.uk

#### 30 October 2025

#### Package

iSEEpathways 1.8.0

# 1 Scenario

In this vignette, we use the example of a differential expression and pathway analysis workflow on a real data set to demonstrate how a selection made in a panel of pathway analysis results may be transmitted to other row-oriented panels in the *[iSEE](https://bioconductor.org/packages/3.22/iSEE)* application.

# 2 Demonstration

## 2.1 Example data

## 2.2 Experimental metadata

We use the `?airway` data set.

We briefly adjust the reference level of the treatment factor to the untreated condition.

```
library("airway")
data("airway")
airway$dex <- relevel(airway$dex, "untrt")
```

## 2.3 Feature identifiers

We also map the Ensembl gene identifiers to more recognisable gene symbols, setting row names to a unique identifier composed of either gene symbol, gene identifier, of a concatenate of both.

Although not essential, this implicitly defines the primary piece of information displayed for genes in the live app.
No information is lost in the process, as the original Ensembl identifier and the corresponding gene symbol are both stored in the `rowData()` of the object.

```
library("org.Hs.eg.db")
library("scater")
rowData(airway)[["ENSEMBL"]] <- rownames(airway)
rowData(airway)[["SYMBOL"]] <- mapIds(org.Hs.eg.db, rownames(airway), "SYMBOL", "ENSEMBL")
rowData(airway)[["uniquifyFeatureNames"]] <- uniquifyFeatureNames(
  ID = rowData(airway)[["ENSEMBL"]],
  names = rowData(airway)[["SYMBOL"]]
)
rownames(airway) <- rowData(airway)[["uniquifyFeatureNames"]]
```

## 2.4 Gene expression

We also compute log-transformed counts, for a better visualisation of differential expression in the live app.

```
library("scuttle")
airway <- logNormCounts(airway)
```

## 2.5 Differential expression analysis

We run a standard Limma-Voom analysis using `limma::voom()`, `limma::lmFit()`, `limma::makeContrasts()`, and `limma::eBayes()`.

```
library("edgeR")

counts <- assay(airway, "counts")
design <- model.matrix(~ 0 + dex + cell, data = colData(airway))

keep <- filterByExpr(counts, design)
v <- voom(counts[keep,], design, plot=FALSE)
fit <- lmFit(v, design)
contr <- makeContrasts("dextrt - dexuntrt", levels = colnames(coef(fit)))
tmp <- contrasts.fit(fit, contr)
tmp <- eBayes(tmp)
res_limma <- topTable(tmp, sort.by = "P", n = Inf)
head(res_limma)
#>             logFC  AveExpr         t      P.Value    adj.P.Val        B
#> CACNB2   3.205582 3.682244  36.60079 2.137481e-11 3.603794e-07 16.17300
#> DUSP1    2.864813 6.644455  28.95810 1.867716e-10 8.660658e-07 14.74054
#> MAOA     3.257581 5.950559  28.34252 2.277611e-10 8.660658e-07 14.53525
#> SPARCL1  4.489229 4.166904  28.07264 2.487930e-10 8.660658e-07 14.13243
#> PRSS35  -2.828191 3.224885 -27.59003 2.919696e-10 8.660658e-07 13.93532
#> STEAP2   1.894509 6.790009  26.83769 3.767814e-10 8.660658e-07 14.07952
```

Then, we embed this set of differential expression results in the `?airway` object using the `iSEEde::embedContrastResults()` method.

```
library("iSEEde")
airway <- iSEEde::embedContrastResults(res_limma, airway, name = "Limma-Voom", class = "limma")
rowData(airway)
#> DataFrame with 63677 rows and 14 columns
#>                         gene_id     gene_name  entrezid   gene_biotype gene_seq_start gene_seq_end
#>                     <character>   <character> <integer>    <character>      <integer>    <integer>
#> TSPAN6          ENSG00000000003        TSPAN6        NA protein_coding       99883667     99894988
#> TNMD            ENSG00000000005          TNMD        NA protein_coding       99839799     99854882
#> DPM1            ENSG00000000419          DPM1        NA protein_coding       49551404     49575092
#> SCYL3           ENSG00000000457         SCYL3        NA protein_coding      169818772    169863408
#> FIRRM           ENSG00000000460      C1orf112        NA protein_coding      169631245    169823221
#> ...                         ...           ...       ...            ...            ...          ...
#> ENSG00000273489 ENSG00000273489 RP11-180C16.1        NA      antisense      131178723    131182453
#> ENSG00000273490 ENSG00000273490        TSEN34        NA protein_coding       54693789     54697585
#> ENSG00000273491 ENSG00000273491  RP11-138A9.2        NA        lincRNA      130600118    130603315
#> APP-DT          ENSG00000273492    AP000230.1        NA        lincRNA       27543189     27589700
#> ENSG00000273493 ENSG00000273493  RP11-80H18.4        NA        lincRNA       58315692     58315845
#>                              seq_name seq_strand seq_coord_system        symbol         ENSEMBL      SYMBOL
#>                           <character>  <integer>        <integer>   <character>     <character> <character>
#> TSPAN6                              X         -1               NA        TSPAN6 ENSG00000000003      TSPAN6
#> TNMD                                X          1               NA          TNMD ENSG00000000005        TNMD
#> DPM1                               20         -1               NA          DPM1 ENSG00000000419        DPM1
#> SCYL3                               1         -1               NA         SCYL3 ENSG00000000457       SCYL3
#> FIRRM                               1          1               NA      C1orf112 ENSG00000000460       FIRRM
#> ...                               ...        ...              ...           ...             ...         ...
#> ENSG00000273489                     7         -1               NA RP11-180C16.1 ENSG00000273489          NA
#> ENSG00000273490 HSCHR19LRC_LRC_J_CTG1          1               NA        TSEN34 ENSG00000273490          NA
#> ENSG00000273491          HG1308_PATCH          1               NA  RP11-138A9.2 ENSG00000273491          NA
#> APP-DT                             21          1               NA    AP000230.1 ENSG00000273492      APP-DT
#> ENSG00000273493                     3          1               NA  RP11-80H18.4 ENSG00000273493          NA
#>                 uniquifyFeatureNames             iSEEde
#>                          <character>        <DataFrame>
#> TSPAN6                        TSPAN6 <iSEELimmaResults>
#> TNMD                            TNMD <iSEELimmaResults>
#> DPM1                            DPM1 <iSEELimmaResults>
#> SCYL3                          SCYL3 <iSEELimmaResults>
#> FIRRM                          FIRRM <iSEELimmaResults>
#> ...                              ...                ...
#> ENSG00000273489      ENSG00000273489 <iSEELimmaResults>
#> ENSG00000273490      ENSG00000273490 <iSEELimmaResults>
#> ENSG00000273491      ENSG00000273491 <iSEELimmaResults>
#> APP-DT                        APP-DT <iSEELimmaResults>
#> ENSG00000273493      ENSG00000273493 <iSEELimmaResults>
```

## 2.6 Pathways

We prepare Gene Ontology gene sets of biological pathways using *[org.Hs.eg.db](https://bioconductor.org/packages/3.22/org.Hs.eg.db)*.

Due to the use of `uniquifyFeatureNames()` above, we must first map pathway identifiers to the unique Ensembl gene identifier, to accurately perform pathway analysis using the feature identifiers matching those of the embedded differential expression results.

```
library("org.Hs.eg.db")
pathways <- select(org.Hs.eg.db, keys(org.Hs.eg.db, "ENSEMBL"), c("GOALL"), keytype = "ENSEMBL")
#> 'select()' returned 1:many mapping between keys and columns
pathways <- subset(pathways, ONTOLOGYALL == "BP")
pathways <- unique(pathways[, c("ENSEMBL", "GOALL")])
pathways <- merge(pathways, rowData(airway)[, c("ENSEMBL", "uniquifyFeatureNames")])
pathways <- split(pathways$uniquifyFeatureNames, pathways$GOALL)
```

## 2.7 Mapping pathways to genes

Separately, we define and register a function that fetches the gene identifiers associated with a given pathway identifier.
This function is required to transmit selections from pathway-level panels to feature-level panels.

Due to the use of `uniquifyFeatureNames()` above, the function must first map to the unique Ensembl gene identifier, to accurately identify the corresponding value in `rownames(airway)`.

```
map_GO <- function(pathway_id, se) {
    pathway_ensembl <- mapIds(org.Hs.eg.db, pathway_id, "ENSEMBL", keytype = "GOALL", multiVals = "CharacterList")[[pathway_id]]
    pathway_rownames <- rownames(se)[rowData(se)[["gene_id"]] %in% pathway_ensembl]
    pathway_rownames
}
airway <- registerAppOptions(airway, Pathways.map.functions = list(GO = map_GO))
```

## 2.8 Gene set enrichment analysis

We run a standard GSEA analysis using *[fgsea](https://bioconductor.org/packages/3.22/fgsea)*.

```
library("fgsea")
set.seed(42)
stats <- na.omit(log2FoldChange(contrastResults(airway, "Limma-Voom")))
fgseaRes <- fgsea(pathways = pathways,
                  stats    = stats,
                  minSize  = 15,
                  maxSize  = 500)
#> Warning in preparePathwaysAndStats(pathways, stats, minSize, maxSize, gseaParam, : There are ties in the preranked stats (0.05% of the list).
#> The order of those tied genes will be arbitrary, which may produce unexpected results.
head(fgseaRes[order(pval), ])
#>       pathway         pval         padj   log2err         ES       NES  size  leadingEdge
#>        <char>        <num>        <num>     <num>      <num>     <num> <int>       <list>
#> 1: GO:0051962 2.064608e-07 0.0008937686 0.6901325 -0.4902006 -1.842929   210 LRRTM2, ....
#> 2: GO:0071375 4.467192e-06 0.0096692378 0.6105269  0.4067362  1.717227   264 KLF15, I....
#> 3: GO:0051965 7.916687e-06 0.0114237795 0.5933255 -0.6673163 -2.022407    42 LRRTM2, ....
#> 4: GO:0050886 1.363545e-05 0.0143554447 0.5933255  0.6200268  2.064136    58 INHBB, L....
#> 5: GO:1904659 1.658056e-05 0.0143554447 0.5756103  0.5533766  1.973546    83 KLF15, L....
#> 6: GO:0031589 2.165828e-05 0.0152370109 0.5756103  0.3852328  1.649440   296 FAM107A,....
```

Then, we embed this set of pathway analysis results in the `airway` object, using the `?iSEEpathways::embedPathwaysResults` method.

But first, we reorder the results by increasing p-value.
Although not essential, this implicitly defines the default ordering of the table in the live app.

```
library("iSEEpathways")
fgseaRes <- fgseaRes[order(pval), ]
airway <- embedPathwaysResults(
  fgseaRes, airway, name = "fgsea (p-value)", class = "fgsea",
  pathwayType = "GO", pathwaysList = pathways, featuresStats = stats)
airway
#> class: RangedSummarizedExperiment
#> dim: 63677 8
#> metadata(3): '' iSEE iSEEpathways
#> assays(2): counts logcounts
#> rownames(63677): TSPAN6 TNMD ... APP-DT ENSG00000273493
#> rowData names(14): gene_id gene_name ... uniquifyFeatureNames iSEEde
#> colnames(8): SRR1039508 SRR1039509 ... SRR1039520 SRR1039521
#> colData names(9): SampleName cell ... Sample BioSample
```

To showcase a choice of pathway analysis results in the live app, we repeat the process above, this time sorting by a different score that combines the log-transformed p-value and the absolute log-transformed fold-change.

```
stats <- na.omit(
  log2FoldChange(contrastResults(airway, "Limma-Voom")) *
  -log10(pValue(contrastResults(airway, "Limma-Voom")))
)
set.seed(42)
fgseaRes <- fgsea(pathways = pathways,
                  stats    = na.omit(stats),
                  minSize  = 15,
                  maxSize  = 500)
fgseaRes <- fgseaRes[order(pval), ]
airway <- embedPathwaysResults(
  fgseaRes, airway, name = "fgsea (p-value & fold-change)", class = "fgsea",
  pathwayType = "GO", pathwaysList = pathways, featuresStats = stats)
airway
#> class: RangedSummarizedExperiment
#> dim: 63677 8
#> metadata(3): '' iSEE iSEEpathways
#> assays(2): counts logcounts
#> rownames(63677): TSPAN6 TNMD ... APP-DT ENSG00000273493
#> rowData names(14): gene_id gene_name ... uniquifyFeatureNames iSEEde
#> colnames(8): SRR1039508 SRR1039509 ... SRR1039520 SRR1039521
#> colData names(9): SampleName cell ... Sample BioSample
```

## 2.9 Displaying additional pathway information

For further user-friendliness in the live app, we define and register a function that displays details for the selected Gene Ontology gene set using the *[GO.db](https://bioconductor.org/packages/3.22/GO.db)* package.

```
library("GO.db")
library("shiny")
library("iSEE")
go_details <- function(x) {
    info <- select(GO.db, x, c("TERM", "ONTOLOGY", "DEFINITION"), "GOID")
    html <- list(p(strong(info$GOID), ":", info$TERM, paste0("(", info$ONTOLOGY, ")")))
    if (!is.na(info$DEFINITION)) {
        html <- append(html, list(p(info$DEFINITION)))
    }
    tagList(html)
}
airway <- registerAppOptions(airway, PathwaysTable.select.details = go_details)
```

## 2.10 Live app

Finally, we configure the initial state and launch the live app.

```
app <- iSEE(airway, initial = list(
  PathwaysTable(ResultName="fgsea (p-value)", Selected = "GO:0046324", PanelWidth = 4L),
  VolcanoPlot(RowSelectionSource = "PathwaysTable1", ColorBy = "Row selection", PanelWidth = 4L),
  ComplexHeatmapPlot(RowSelectionSource = "PathwaysTable1",
      PanelWidth = 4L, PanelHeight = 700L,
      CustomRows = FALSE, ColumnData = "dex",
      ClusterRows = TRUE, ClusterRowsDistance = "euclidean", AssayCenterRows = TRUE),
  FgseaEnrichmentPlot(ResultName="fgsea (p-value)", PathwayId = "GO:0046324", PanelWidth = 12L)
))

if (interactive()) {
  shiny::runApp(app)
}
```

![](data:image/png;base64...)

# 3 Trading off memory usage for speed

The function `map_GO()` that we defined earlier above – to map a pathway identifier to a set of gene identifiers – uses the *[org.Hs.eg.db](https://bioconductor.org/packages/3.22/org.Hs.eg.db)* package and the `?AnnotationDbi::select()` function.

While memory-efficient, the repeated calls to the database of gene annotations introduce a bottleneck that limits the reactivity of the app.

We can improve the speed of the app rendering by trading off an increased memory usage.
Specifically, we can use the object `pathways` that we created earlier as a named list of pathway identifiers and character vectors of gene identifiers associated with each pathway, instead of querying the `GO.db` database.

First, for the app to be self-contained, the list of pathways should be stored within the `airway` object itself.
For instance, we store those in the `metadata()` of the `airway` object.

```
metadata(airway)[["pathways"]] <- list(GO = pathways)
```

Then, we can write a new, faster, function that fetches gene identifiers directly from that list rather than the database.
The function should take as first argument a single pathway identifier, and the second argument must be called `se` to match the name of the `SummarizedExperiment` object used within the app.

As a a trade off, the app now relies on the list of pathway annotations being available in the metadata of the `se` object, using additional memory for the benefit of dramatically faster access.

```
map_GO_v2 <- function(pathway_id, se) {
    pathway_list <- metadata(se)[["pathways"]][["GO"]]
    if (!pathway_id %in% names(pathway_list)) {
        warning("Pathway identifier %s not found.", sQuote(pathway_id))
        return(character(0))
    }
    pathway_list[[pathway_id]]
}
airway <- registerAppOptions(airway, Pathways.map.functions = list(GO = map_GO_v2))
```

We can then launch a new instance of the app, using the same initial configuration, but the update `airway` object.

```
app <- iSEE(airway, initial = list(
  PathwaysTable(ResultName="fgsea (p-value)", Selected = "GO:0046324", PanelWidth = 4L),
  VolcanoPlot(RowSelectionSource = "PathwaysTable1", ColorBy = "Row selection", PanelWidth = 4L),
  ComplexHeatmapPlot(RowSelectionSource = "PathwaysTable1",
      PanelWidth = 4L, PanelHeight = 700L,
      CustomRows = FALSE, ColumnData = "dex",
      ClusterRows = TRUE, ClusterRowsDistance = "euclidean", AssayCenterRows = TRUE),
  FgseaEnrichmentPlot(ResultName="fgsea (p-value)", PathwayId = "GO:0046324", PanelWidth = 12L)
))

if (interactive()) {
  shiny::runApp(app)
}
```

![](data:image/png;base64...)

# 4 Reproducibility

The *[iSEEpathways](https://bioconductor.org/packages/3.22/iSEEpathways)* package (Rue-Albrecht and Soneson, 2025) was made possible thanks to:

* R (R Core Team, 2025)
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight et al., 2025)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)

This package was developed using *[biocthis](https://bioconductor.org/packages/3.22/biocthis)*.

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("integration.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("integration.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
#> [1] "2025-10-30 00:41:36 EDT"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 1.124 mins
```

`R` session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-30
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package              * version  date (UTC) lib source
#>  abind                  1.4-8    2024-09-12 [2] CRAN (R 4.5.1)
#>  airway               * 1.29.0   2025-10-28 [2] Bioconductor 3.22 (R 4.5.1)
#>  AnnotationDbi        * 1.72.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  backports              1.5.0    2024-05-23 [2] CRAN (R 4.5.1)
#>  beachmat               2.26.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  beeswarm               0.4.0    2021-06-01 [2] CRAN (R 4.5.1)
#>  bibtex                 0.5.1    2023-01-26 [2] CRAN (R 4.5.1)
#>  Biobase              * 2.70.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26  2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocNeighbors          2.4.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocParallel           1.44.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocSingular           1.26.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocStyle            * 2.38.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings             2.78.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                    4.6.0    2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64                  4.6.0-1  2025-01-16 [2] CRAN (R 4.5.1)
#>  blob                   1.2.4    2023-03-17 [2] CRAN (R 4.5.1)
#>  bookdown               0.45     2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0    2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0    2024-05-16 [2] CRAN (R 4.5.1)
#>  circlize               0.4.16   2024-02-20 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5    2025-04-23 [2] CRAN (R 4.5.1)
#>  clue                   0.3-66   2024-11-13 [2] CRAN (R 4.5.1)
#>  cluster                2.1.8.1  2025-03-12 [3] CRAN (R 4.5.1)
#>  codetools              0.2-20   2024-03-31 [3] CRAN (R 4.5.1)
#>  colorspace             2.1-2    2025-09-22 [2] CRAN (R 4.5.1)
#>  colourpicker           1.3.0    2023-08-21 [2] CRAN (R 4.5.1)
#>  ComplexHeatmap         2.26.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  cowplot                1.2.0    2025-07-07 [2] CRAN (R 4.5.1)
#>  crayon                 1.5.3    2024-06-20 [2] CRAN (R 4.5.1)
#>  data.table             1.17.8   2025-07-10 [2] CRAN (R 4.5.1)
#>  DBI                    1.2.3    2024-06-02 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  DESeq2                 1.50.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  dichromat              2.0-0.1  2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37   2024-08-19 [2] CRAN (R 4.5.1)
#>  doParallel             1.0.17   2022-02-07 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4    2023-11-17 [2] CRAN (R 4.5.1)
#>  DT                     0.34.0   2025-09-02 [2] CRAN (R 4.5.1)
#>  edgeR                * 4.8.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  evaluate               1.0.5    2025-08-27 [2] CRAN (R 4.5.1)
#>  farver                 2.1.2    2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0    2024-05-15 [2] CRAN (R 4.5.1)
#>  fastmatch              1.1-6    2024-12-23 [2] CRAN (R 4.5.1)
#>  fgsea                * 1.36.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  fontawesome            0.5.3    2024-11-16 [2] CRAN (R 4.5.1)
#>  foreach                1.5.2    2022-02-02 [2] CRAN (R 4.5.1)
#>  generics             * 0.1.4    2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicRanges        * 1.62.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GetoptLong             1.0.5    2020-12-15 [2] CRAN (R 4.5.1)
#>  ggbeeswarm             0.7.2    2023-04-29 [2] CRAN (R 4.5.1)
#>  ggplot2              * 4.0.0    2025-09-11 [2] CRAN (R 4.5.1)
#>  ggrepel                0.9.6    2024-09-07 [2] CRAN (R 4.5.1)
#>  GlobalOptions          0.1.2    2020-06-10 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0    2024-09-30 [2] CRAN (R 4.5.1)
#>  GO.db                * 3.22.0   2025-10-08 [2] Bioconductor
#>  gridExtra              2.3      2017-09-09 [2] CRAN (R 4.5.1)
#>  gtable                 0.3.6    2024-10-25 [2] CRAN (R 4.5.1)
#>  htmltools              0.5.8.1  2024-04-04 [2] CRAN (R 4.5.1)
#>  htmlwidgets            1.6.4    2023-12-06 [2] CRAN (R 4.5.1)
#>  httpuv                 1.6.16   2025-04-16 [2] CRAN (R 4.5.1)
#>  httr                   1.4.7    2023-08-15 [2] CRAN (R 4.5.1)
#>  igraph                 2.2.1    2025-10-27 [2] CRAN (R 4.5.1)
#>  IRanges              * 2.44.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  irlba                  2.3.5.1  2022-10-03 [2] CRAN (R 4.5.1)
#>  iSEE                 * 2.22.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  iSEEde               * 1.8.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  iSEEpathways         * 1.8.0    2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  iterators              1.0.14   2022-02-05 [2] CRAN (R 4.5.1)
#>  jquerylib              0.1.4    2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0    2025-03-27 [2] CRAN (R 4.5.1)
#>  KEGGREST               1.50.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  knitr                  1.50     2025-03-16 [2] CRAN (R 4.5.1)
#>  later                  1.4.4    2025-08-27 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7   2025-04-02 [3] CRAN (R 4.5.1)
#>  lifecycle              1.0.4    2023-11-07 [2] CRAN (R 4.5.1)
#>  limma                * 3.66.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  listviewer             4.0.0    2023-09-30 [2] CRAN (R 4.5.1)
#>  locfit                 1.5-9.12 2025-03-05 [2] CRAN (R 4.5.1)
#>  lubridate              1.9.4    2024-12-08 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4    2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-4    2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics       * 1.22.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats          * 1.5.0    2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                2.0.1    2021-11-26 [2] CRAN (R 4.5.1)
#>  mgcv                   1.9-3    2025-04-04 [3] CRAN (R 4.5.1)
#>  mime                   0.13     2025-03-17 [2] CRAN (R 4.5.1)
#>  miniUI                 0.1.2    2025-04-17 [2] CRAN (R 4.5.1)
#>  nlme                   3.1-168  2025-03-31 [3] CRAN (R 4.5.1)
#>  org.Hs.eg.db         * 3.22.0   2025-10-08 [2] Bioconductor
#>  otel                   0.2.0    2025-08-29 [2] CRAN (R 4.5.1)
#>  pillar                 1.11.1   2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3    2019-09-22 [2] CRAN (R 4.5.1)
#>  plyr                   1.8.9    2023-10-02 [2] CRAN (R 4.5.1)
#>  png                    0.1-8    2022-11-29 [2] CRAN (R 4.5.1)
#>  promises               1.4.0    2025-10-22 [2] CRAN (R 4.5.1)
#>  R6                     2.6.1    2025-02-15 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3    2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0    2025-07-02 [2] CRAN (R 4.5.1)
#>  RefManageR           * 1.4.0    2022-09-30 [2] CRAN (R 4.5.1)
#>  rintrojs               0.3.4    2024-01-11 [2] CRAN (R 4.5.1)
#>  rjson                  0.2.23   2024-09-16 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6    2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30     2025-09-28 [2] CRAN (R 4.5.1)
#>  RSQLite                2.4.3    2025-08-20 [2] CRAN (R 4.5.1)
#>  rsvd                   1.0.5    2021-04-16 [2] CRAN (R 4.5.1)
#>  S4Arrays               1.10.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.48.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0    2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10   2025-04-11 [2] CRAN (R 4.5.1)
#>  ScaledMatrix           1.18.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  scales                 1.4.0    2025-04-24 [2] CRAN (R 4.5.1)
#>  scater               * 1.38.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  scuttle              * 1.20.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Seqinfo              * 1.0.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo          * 1.2.3    2025-02-05 [2] CRAN (R 4.5.1)
#>  shape                  1.4.6.1  2024-02-23 [2] CRAN (R 4.5.1)
#>  shiny                * 1.11.1   2025-07-03 [2] CRAN (R 4.5.1)
#>  shinyAce               0.4.4    2025-02-03 [2] CRAN (R 4.5.1)
#>  shinydashboard         0.7.3    2025-04-21 [2] CRAN (R 4.5.1)
#>  shinyjs                2.1.0    2021-12-23 [2] CRAN (R 4.5.1)
#>  shinyWidgets           0.9.0    2025-02-21 [2] CRAN (R 4.5.1)
#>  SingleCellExperiment * 1.32.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  SparseArray            1.10.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  statmod                1.5.1    2025-10-09 [2] CRAN (R 4.5.1)
#>  stringi                1.8.7    2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr                1.5.2    2025-09-08 [2] CRAN (R 4.5.1)
#>  SummarizedExperiment * 1.40.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  tibble                 3.3.0    2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1    2024-03-11 [2] CRAN (R 4.5.1)
#>  timechange             0.3.0    2024-01-18 [2] CRAN (R 4.5.1)
#>  vctrs                  0.6.5    2023-12-01 [2] CRAN (R 4.5.1)
#>  vipor                  0.4.7    2023-12-18 [2] CRAN (R 4.5.1)
#>  viridis                0.6.5    2024-01-29 [2] CRAN (R 4.5.1)
#>  viridisLite            0.4.2    2023-05-02 [2] CRAN (R 4.5.1)
#>  withr                  3.0.2    2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                   0.53     2025-08-19 [2] CRAN (R 4.5.1)
#>  xml2                   1.4.1    2025-10-27 [2] CRAN (R 4.5.1)
#>  xtable                 1.8-4    2019-04-21 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10   2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpDpXsPn/Rinst12017346528164
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 5 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
with *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025) running behind the scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2025rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.30.
2025.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[3]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.38.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[4]](#cite-2025language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2025.
URL: <https://www.R-project.org/>.

[[5]](#cite-ruealbrecht2025iseepathways)
K. Rue-Albrecht and C. Soneson.
*iSEEpathways: iSEE extension for panels related to pathway analysis*.
R package version 1.8.0.
2025.
DOI: [10.18129/B9.bioc.iSEEpathways](https://doi.org/10.18129/B9.bioc.iSEEpathways).
URL: <https://bioconductor.org/packages/iSEEpathways>.

[[6]](#cite-wickham2011testthat)
H. Wickham.
“testthat: Get Started with Testing”.
In: *The R Journal* 3 (2011), pp. 5–10.
URL: <https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

[[7]](#cite-wickham2025sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.3.
2025.
DOI: [10.32614/CRAN.package.sessioninfo](https://doi.org/10.32614/CRAN.package.sessioninfo).
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[8]](#cite-xie2025knitr)
Y. Xie.
*knitr: A General-Purpose Package for Dynamic Report Generation in R*.
R package version 1.50.
2025.
URL: <https://yihui.org/knitr/>.