# Gene-set enrichment on single-cell data with **escape**

Nick Borcherding1\* and Jared Andrews1\*\*

1Washington University in St. Louis, School of Medicine, St. Louis, MO, USA

\*ncborch@gmail.com
\*\*jared.andrews07@gmail.com

#### Compiled: January 05, 2026

#### Package

escape 2.6.2

# 1 Overview

escape turns raw single-cell counts into intuitive, per-cell gene-set scores with a single command and then provides plotting helpers to interrogate them.

The core workflow is:

1. Choose gene-set library (`getGeneSets()` or your own list)
2. Score cells (`runEscape()`)
3. (Optional) Normalize for drop-out (`performNormalization()`)
4. Explore with the built-in visualization gallery

# 2 Installation

```
devtools::install_github("BorchLab/escape")

if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("escape")
```

Load escape alongside a single-cell container (Seurat or SingleCellExperiment) and a plotting backend:

```
suppressPackageStartupMessages({
  pkgs <- c(
    "escape", "SingleCellExperiment", "scran", "Seurat", "SeuratObject",
    "RColorBrewer", "ggplot2"
  )
  invisible(lapply(pkgs, library, character.only = TRUE))
})
```

# 3 Loading Processed Single-Cell Data

For the demonstration of *escape*, we will use the example **“pbmc\_small”** data from *Seurat* and also generate a `SingleCellExperiment` object from it.

```
pbmc_small <- get("pbmc_small")
sce.pbmc <- as.SingleCellExperiment(pbmc_small, assay = "RNA")
```

# 4 Getting Gene Sets

## 4.1 Option 1: Built-In gene sets

```
data("escape.gene.sets", package="escape")
```

## 4.2 Option 2: MSigDB via `getGeneSets()`

Gene set enrichment analysis begins by identifying the appropriate gene sets for your study. The `getGeneSets()` function simplifies this process by extracting one or more gene set libraries from the Molecular Signature Database (MSigDB) and returning them as a GSEABase GeneSetCollection object. Note that the first time you run `getGeneSets()`, it downloads a complete local copy of the gene sets, which may take a little while. Future calls will use the cached version, greatly improving performance.

To retrieve gene set collections from MSigDB, specify the library or libraries of interest using the library parameter. For example, to select multiple libraries, use:

In addition, the function supports further subsetting through these parameters:

* **subcategory**: Narrow down your selection by specifying subcategories within a library. Examples include “CGN”, “CGP”, “CP:BIOCARTA”, “CP:KEGG”, “GO:BP”, “IMMUNESIGDB”, etc.
* **gene.sets:** Isolate individual pathways or gene sets by providing their specific names.

```
GS.hallmark <- getGeneSets(library = "H")
```

## 4.3 Option 3: Define personal gene sets

```
gene.sets <- list(Bcells = c("MS4A1","CD79B","CD79A","IGH1","IGH2"),
                        Myeloid = c("SPI1","FCER1G","CSF1R"),
                        Tcells = c("CD3E", "CD3D", "CD3G", "CD7","CD8A"))
```

## 4.4 Option 4: Using msigdbr

[msigdbr](https://cran.r-project.org/web/packages/msigdbr/index.html) is an alternative R package to access the Molecular Signature Database in R. There is expanded support for species in the package as well as a mix of accessible versus downloadable gene sets, so it can be faster than caching a copy locally.

```
GS.hallmark <- msigdbr(species  = "Homo sapiens",
                       category = "H")
```

# 5 Performing Enrichment Calculation

Several popular methods exist for Gene Set Enrichment Analysis (GSEA). These methods can vary in the underlying assumptions. *escape* incorporates several methods that are particularly advantageous for single-cell RNA values:

### 5.0.1 **ssGSEA**

This method calculates the enrichment score using a rank-normalized approach and generating an empirical cumulative distribution function for each individual cell. The enrichment score is defined for a gene set (*G*) using the number of genes in the gene set (*NG*) and total number of genes (*N*).

\[
ES(G,S) \sum\_{i = 1}^{n} [P\_W^G(G,S,i)-P\_{NG}(G,S,i)]
\]

Please see the following [citation](https://pubmed.ncbi.nlm.nih.gov/19847166/) for more information.

### 5.0.2 **GSVA**

GSVA varies slightly by estimating a Poisson-based kernel cumulative density function. But like ssGSEA, the ultimate enrichment score reported is based on the maximum value of the random walk statistic. GSVA appears to have better overall consistency and runs faster than ssGSEA.

\[
ES\_{jk}^{max} = V\_{jk} [max\_{l=1,...,p}|v\_{jk}(l)]
\]

Please see the following [citation](https://pubmed.ncbi.nlm.nih.gov/23323831/) for more information.

### 5.0.3 **AUCell**

In contrast to ssGSEA and GSVA, AUCell takes the gene rankings for each cell and step-wise plots the position of each gene in the gene set along the y-axis. The output score is the area under the curve for this approach.

Please see the following [citation](https://pubmed.ncbi.nlm.nih.gov/28991892/) for more information.

### 5.0.4 UCell

UCell calculates a Mann-Whitney U statistic based on the gene rank list. **Importantly**, UCell has a cut-off for ranked genes (\[r\_{max}\]) at 1500 - this is per design as drop-out in single-cell can alter enrichment results. This also substantially speeds the calculations up.

The enrichment score output is then calculated using the complement of the U statistic scaled by the gene set size and cut-off.

\[
U\_j^` = 1-\frac{U\_j}{n \bullet r\_{max}}
\]

Please see the following [citation](https://pubmed.ncbi.nlm.nih.gov/34285779/) for more information.

## 5.1 escape.matrix

escape has 2 major functions - the first being `escape.matrix()`, which serves as the backbone of enrichment calculations. Using count-level data supplied from a single-cell object or matrix, `escape.matrix()` will produce an enrichment score for the individual cells with the gene sets selected and output the values as a matrix.

**method**

* AUCell
* GSVA
* ssGSEA
* UCell

**groups**

* The number of cells to calculate at once.

**min.size**

* The minimum size of detectable genes in a gene set. Gene sets less than the **min.size** will be removed before the calculation.

**normalize**

* Use the number of genes from the gene sets in each cell to normalize the enrichment scores. The default value is **FALSE**.

**make.positive**

* During normalization, whether to shift the enrichment values to a positive range (**TRUE**) or not (**FALSE**). The default value is **FALSE**.

*Cautionary note:* **make.positive** was added to allow for differential analysis downstream of enrichment as some methods may produce negative values. It preserves log-fold change, but ultimately modifies the enrichment values and should be used with caution.

```
enrichment.scores <- escape.matrix(pbmc_small,
                                   gene.sets = escape.gene.sets,
                                   groups = 1000,
                                   min.size = 5)

ggplot(data = as.data.frame(enrichment.scores),
      mapping = aes(enrichment.scores[,1], enrichment.scores[,2])) +
  geom_point() +
  theme_classic() +
  xlab(colnames(enrichment.scores)[1]) +
  ylab(colnames(enrichment.scores)[2])
```

![](data:image/png;base64...)

Multi-core support is for all methods is available through [BiocParallel](https://bioconductor.org/packages/release/bioc/html/BiocParallel.html). To add more cores, use the argument **BPPARAM** to `escape.matrix()`. Here we will use the `SnowParam()` for it’s support across platforms and explicitly call 2 workers (or cores).

```
enrichment.scores <- escape.matrix(pbmc_small,
                                   gene.sets = escape.gene.sets,
                                   groups = 1000,
                                   min.size = 3,
                                   BPPARAM = BiocParallel::SnowParam(workers = 2))
```

## 5.2 runEscape

Alternatively, we can use `runEscape()` to calculate the enrichment score and directly attach the output to a single-cell object. The additional parameter for ```runEscape` is **new.assay.name**, in order to save the enrichment scores as a custom assay in the single-cell object.

```
pbmc_small <- runEscape(pbmc_small,
                        method = "ssGSEA",
                        gene.sets = escape.gene.sets,
                        groups = 1000,
                        min.size = 3,
                        new.assay.name = "escape.ssGSEA")

sce.pbmc <- runEscape(sce.pbmc,
                      method = "UCell",
                      gene.sets = escape.gene.sets,
                      groups = 1000,
                      min.size = 5,
                      new.assay.name = "escape.UCell")
```

We can quickly examine the attached enrichment scores using the visualization/workflow we prefer - here we will use just `FeaturePlot()` from the Seurat R package.

```
#Define color palette
colorblind_vector <- hcl.colors(n=7, palette = "inferno", fixup = TRUE)

FeaturePlot(pbmc_small, "Proinflammatory") +
  scale_color_gradientn(colors = colorblind_vector) +
  theme(plot.title = element_blank())
```

![](data:image/png;base64...)

## 5.3 performNormalization

Although we glossed over the normalization that can be used in `escape.matrix()` and `runEscape()`, it is worth mentioning here as normalization can affect all downstream analyses.

There can be inherent bias in enrichment values due to drop out in single-cell expression data. Cells with larger numbers of features and counts will likely have higher enrichment values. `performNormalization()` will normalize the enrichment values by calculating the number of genes expressed in each gene set and cell. This is similar to the normalization in classic GSEA and it will be stored in a new assay.

```
pbmc_small <- performNormalization(input.data = pbmc_small,
                                   assay = "escape.ssGSEA",
                                   gene.sets = escape.gene.sets)
```

An alternative for scaling by expressed gene sets would be to use a scaling factor previously calculated during normal single-cell data processing and quality control. This can be done using the **scale.factor** argument and providing a vector.

```
pbmc_small <- performNormalization(input.data = pbmc_small,
                                   assay = "escape.ssGSEA",
                                   gene.sets = escape.gene.sets,
                                   scale.factor = pbmc_small$nFeature_RNA)
```

`performNormalization()` has an additional parameter **make.positive**. Across the individual gene sets, if negative normalized enrichment scores are seen, the minimum value is added to all values. For example if the normalized enrichment scores (after the above accounting for drop out) ranges from -50 to 50, **make.positive** will adjust the range to 0 to 100 (by adding 50). This allows for compatible log2-fold change downstream, but can alter the enrichment score interpretation.

---

# 6 Visualizations

There are a number of ways to look at the enrichment values downstream of `runEscape()` with the myriad plotting and visualizations functions/packages for single-cell data. *escape* include several additional plotting functions to assist in the analysis.

## 6.1 heatmapEnrichment

We can examine the enrichment values across our gene sets by using `heatmapEnrichment()`. This visualization will return the mean of the **group.by** variable. As a default - all visualizations of single-cell objects will use the cluster assignment or active identity as a default for visualizations.

```
heatmapEnrichment(pbmc_small,
                  group.by = "ident",
                  gene.set.use = "all",
                  assay = "escape.ssGSEA")
```

![](data:image/png;base64...)

Most of the visualizations in *escape* have a defined set of parameters.

**group.by**

* The grouping variable for the comparison.

**facet.by**

* Using a variable to facet the graph into separate visualizations.

**scale**

* **TRUE** - z-transform the enrichment values.
* **FALSE** - leave raw values (**DEFAULT**).

In addition, `heatmapEnrichment()` allows for the reclustering of rows and columns using Euclidean distance of the enrichment scores and the Ward2 methods for clustering using **cluster.rows** and **cluster.columns**.

```
heatmapEnrichment(sce.pbmc,
                  group.by = "ident",
                  assay = "escape.UCell",
                  scale = TRUE,
                  cluster.rows = TRUE,
                  cluster.columns = TRUE)
```

![](data:image/png;base64...)

Each visualization has an additional argument called \*\*palette that supplies the coloring scheme to be used - available color palettes can be viewed with `hcl.pals()`.

```
hcl.pals()
```

```
##   [1] "Pastel 1"      "Dark 2"        "Dark 3"        "Set 2"
##   [5] "Set 3"         "Warm"          "Cold"          "Harmonic"
##   [9] "Dynamic"       "Grays"         "Light Grays"   "Blues 2"
##  [13] "Blues 3"       "Purples 2"     "Purples 3"     "Reds 2"
##  [17] "Reds 3"        "Greens 2"      "Greens 3"      "Oslo"
##  [21] "Purple-Blue"   "Red-Purple"    "Red-Blue"      "Purple-Orange"
##  [25] "Purple-Yellow" "Blue-Yellow"   "Green-Yellow"  "Red-Yellow"
##  [29] "Heat"          "Heat 2"        "Terrain"       "Terrain 2"
##  [33] "Viridis"       "Plasma"        "Inferno"       "Rocket"
##  [37] "Mako"          "Dark Mint"     "Mint"          "BluGrn"
##  [41] "Teal"          "TealGrn"       "Emrld"         "BluYl"
##  [45] "ag_GrnYl"      "Peach"         "PinkYl"        "Burg"
##  [49] "BurgYl"        "RedOr"         "OrYel"         "Purp"
##  [53] "PurpOr"        "Sunset"        "Magenta"       "SunsetDark"
##  [57] "ag_Sunset"     "BrwnYl"        "YlOrRd"        "YlOrBr"
##  [61] "OrRd"          "Oranges"       "YlGn"          "YlGnBu"
##  [65] "Reds"          "RdPu"          "PuRd"          "Purples"
##  [69] "PuBuGn"        "PuBu"          "Greens"        "BuGn"
##  [73] "GnBu"          "BuPu"          "Blues"         "Lajolla"
##  [77] "Turku"         "Hawaii"        "Batlow"        "Blue-Red"
##  [81] "Blue-Red 2"    "Blue-Red 3"    "Red-Green"     "Purple-Green"
##  [85] "Purple-Brown"  "Green-Brown"   "Blue-Yellow 2" "Blue-Yellow 3"
##  [89] "Green-Orange"  "Cyan-Magenta"  "Tropic"        "Broc"
##  [93] "Cork"          "Vik"           "Berlin"        "Lisbon"
##  [97] "Tofino"        "ArmyRose"      "Earth"         "Fall"
## [101] "Geyser"        "TealRose"      "Temps"         "PuOr"
## [105] "RdBu"          "RdGy"          "PiYG"          "PRGn"
## [109] "BrBG"          "RdYlBu"        "RdYlGn"        "Spectral"
## [113] "Zissou 1"      "Cividis"       "Roma"
```

```
heatmapEnrichment(pbmc_small,
                  assay = "escape.ssGSEA",
                  palette = "Spectral")
```

![](data:image/png;base64...)

Alternatively, we can add an additional layer to the ggplot object that is returned by the visualizations using something like `scale_fill_gradientn()` for continuous values or `scale_fill_manual()` for the categorical variables.

```
heatmapEnrichment(sce.pbmc,
                  group.by = "ident",
                  assay = "escape.UCell") +
  scale_fill_gradientn(colors = rev(brewer.pal(11, "RdYlBu")))
```

![](data:image/png;base64...)

## 6.2 geyserEnrichment

We can also focus on individual gene sets - one approach is to use `geyserEnrichment()`. Here individual cells are plotted along the Y-axis with graphical summary where the central dot refers to the median enrichment value and the thicker/thinner lines demonstrate the interval summaries referring to the 66% and 95%.

```
geyserEnrichment(pbmc_small,
                 assay = "escape.ssGSEA",
                 gene.set.use = "T1-Interferon")
```

![](data:image/png;base64...)

To show the additional parameters that appear in visualizations of individual enrichment gene sets - we can reorder the groups by the mean of the gene set using **order.by** = “mean”.

```
geyserEnrichment(pbmc_small,
                 assay = "escape.ssGSEA",
                 gene.set.use = "T1-Interferon",
                 order.by = "mean")
```

![](data:image/png;base64...)

What if we had 2 separate samples or groups within the data? Another parameter we can use is **facet.by** to allow for direct visualization of an additional variable.

```
geyserEnrichment(pbmc_small,
                 assay = "escape.ssGSEA",
                 gene.set.use = "T1-Interferon",
                 facet.by = "groups")
```

![](data:image/png;base64...)

Lastly, we can select the way the color is applied to the plot using the **color.by** parameter. Here we can set it to the gene set of interest *“HALLMARK-INTERFERON-GAMMA-RESPONSE”*.

```
geyserEnrichment(pbmc_small,
                 assay = "escape.ssGSEA",
                 gene.set.use = "T1-Interferon",
                 color.by  = "T1-Interferon")
```

![](data:image/png;base64...)

## 6.3 ridgeEnrichment

Similar to the `geyserEnrichment()` the `ridgeEnrichment()` can display the distribution of enrichment values across the selected gene set. The central line is at the median value for the respective grouping.

```
ridgeEnrichment(sce.pbmc,
                assay = "escape.UCell",
                gene.set.use = "T2_Interferon")
```

![](data:image/png;base64...)

We can get the relative position of individual cells along the x-axis using the **add.rug** parameter.

```
ridgeEnrichment(sce.pbmc,
                assay = "escape.UCell",
                gene.set.use = "T2_Interferon",
                add.rug = TRUE,
                scale = TRUE)
```

![](data:image/png;base64...)

## 6.4 splitEnrichment

Another distribution visualization is a violin plot, which we separate and directly compare using a binary classification. Like `ridgeEnrichment()`, this allows for greater use of categorical variables. For `splitEnrichment()`, the output will be two halves of a violin plot based on the **split.by** parameter with a central boxplot with the relative distribution across all samples.

```
splitEnrichment(pbmc_small,
                assay = "escape.ssGSEA",
                gene.set.use = "Lipid-mediators",
                split.by = "groups")
```

![](data:image/png;base64...)

If selecting a **split.by** variable with more than 2 levels, `splitEnrichment()` will convert the violin plots to dodge.

```
splitEnrichment(pbmc_small,
                assay = "escape.ssGSEA",
                gene.set.use = "Lipid-mediators",
                split.by = "ident",
                group.by = "groups")
```

![](data:image/png;base64...)

## 6.5 gseaEnrichment

`gseaEnrichment()` reproduces the two-panel GSEA graphic from Subramanian et al. (2005):
\* Panel A – the running enrichment score (RES) as you “walk” down the ranked list.
\* Panel B – a rug showing exact positions of each pathway gene.

It works on escape’s per-cell ranks, but collapses them across cells with a summary statistic (summary.fun = “mean” by default).

**How it works:**

1. Rank all genes in each group by summary.fun of expression/statistic.
2. Perform the weighted Kolmogorov–Smirnov walk: +w when the next gene is in
   the set, −1/(N − NG) otherwise.
3. ES = maximum signed deviation; permutation on gene labels (or phenotypes)
   to derive NES and p.

```
gseaEnrichment(pbmc_small,
               gene.set.use = "T2_Interferon",
               gene.sets    = escape.gene.sets,
               group.by     = "ident",
               summary.fun  = "mean",
               nperm        = 1000)
```

![](data:image/png;base64...)

## 6.6 densityEnrichment

`densityEnrichment()` is a method to visualize the mean rank position of the gene set features along the total feature space by group. Instead of the classic GSEA running-score, it overlays **kernel-density traces** of the *gene ranks* (1 = most highly expressed/ranked gene) for every group or cluster. High densities at the *left-hand* side mean the pathway is collectively **up-regulated**; peaks on the *right* imply down-regulation.

**Anatomy of the plot**

1. **X-axis** – gene rank (1 … *N*). Left = top-ranked genes.
2. **Y-axis** – density estimate (area under each curve = 1).
3. **One coloured line per level of `group.by`** – default is Seurat/SCE cluster.

```
densityEnrichment(pbmc_small,
                  gene.set.use = "T2_Interferon",
                  gene.sets = escape.gene.sets)
```

## 6.7 scatterEnrichment

It may be advantageous to look at the distribution of multiple gene sets - here we can use `scatterEnrichment()` for a 2 gene set comparison. The color values are based on the density of points determined by the number of neighbors, similar to the [Nebulosa R package](https://www.bioconductor.org/packages/release/bioc/html/Nebulosa.html). We just need to define which gene set to plot on the **x.axis** and which to plot on the **y.axis**.

```
scatterEnrichment(pbmc_small,
                  assay = "escape.ssGSEA",
                  x.axis = "T2-Interferon",
                  y.axis = "Lipid-mediators")
```

![](data:image/png;base64...)

The scatter plot can also be converted into a hexbin, another method for summarizing the individual cell distributions along the x and y axis, by setting **style** = “hex”.

```
scatterEnrichment(sce.pbmc,
                  assay = "escape.UCell",
                  x.axis = "T2_Interferon",
                  y.axis = "Lipid_mediators",
                  style = "hex")
```

![](data:image/png;base64...)

---

# 7 Statistical Analysis

## 7.1 Principal Component Analysis (PCA)

escape has its own PCA function `performPCA()` which will work on a single-cell object or a matrix of enrichment values. This is specifically useful for downstream visualizations as it stores the eigenvalues and rotations. If we want to look at the relative contribution to overall variance of each component or a Biplot-like overlay of the individual features, use `performPCA()`.

Alternatively, other PCA-based functions like Seurat’s `RunPCA()` or scater’s ```runPCA()` can be used. These functions are likely faster and would be ideal if we have a larger number of cells and/or gene sets.

```
pbmc_small <- performPCA(pbmc_small,
                         assay = "escape.ssGSEA",
                         n.dim = 1:10)
```

*escape* has a built in method for plotting PCA `pcaEnrichment()` that functions similarly to the `scatterEnrichment()` function where **x.axis** and **y.axis** are the components to plot.

```
pcaEnrichment(pbmc_small,
              dimRed = "escape.PCA",
              x.axis = "PC1",
              y.axis = "PC2")
```

![](data:image/png;base64...)

`pcaEnrichment()` can plot additional information on the principal component analysis.

**add.percent.contribution** will add the relative percent contribution of the x and y.axis to total variability observed in the PCA.

**display.factors** will overlay the magnitude and direction that the features/gene sets contribute to the selected components. The number of gene sets is determined by **number.of.factors**. This can assist in understanding the underlying differences in enrichment across different cells.

```
pcaEnrichment(pbmc_small,
              dimRed = "escape.PCA",
              x.axis = "PC1",
              y.axis = "PC2",
              add.percent.contribution = TRUE,
              display.factors = TRUE,
              number.of.factors = 10)
```

![](data:image/png;base64...)

## 7.2 Precomputed Rank Lists

Functional enrichment is not limited to per-cell scores. Many workflows start with **differential-expression (DE) statistics** (e.g. Seurat’s `FindMarkers()`,
DESeq2’s `results()`, edgeR’s `topTags()`). Those produce a *ranked gene list*
that can be fed into a classical **Gene-Set Enrichment Analysis (GSEA)**.

### 7.2.1 Why do this?

* **Aggregates signal across genes**: a borderline but *consistent* trend across
  30 pathway genes is often more informative than a single high-logFC gene.
* **Directionality**: by combining log-fold-change (*effect size*) and an
  adjusted *p*-value (*confidence*)
* **Speed**: you avoid re-scoring every cell; only one numeric vector is needed.

`enrichIt()` accepts either

1. a **named numeric vector** (*already ranked*), or
2. a **data frame** containing logFC + *p* (or *adj.p*).

The helper **automatically chooses** the best *p*-value column in this order:

1. `p_val_adj`
2. `padj` (DESeq2)
3. `FDR` (edgeR)
4. plain `p_val`

### 7.2.2 Example `enrichIt()` workflow

```
DEG.markers <- FindMarkers(pbmc_small,
                           ident.1 = "0",
                           ident.2 = "1")

GSEA.results <- enrichIt(input.data = DEG.markers,
                         gene.sets = escape.gene.sets,
                         ranking_fun = "signed_log10_p")

head(GSEA.results)
```

```
##            pathway      pval      padj    log2err         ES        NES  size
##             <char>     <num>     <num>      <num>      <num>      <num> <int>
## 1:   T2_Interferon 0.2500000 0.8161157 0.08289621 -0.8228147 -1.1002301    10
## 2:        M1.Macro 0.3264463 0.8161157 0.06720651 -0.7714736 -1.0667436    15
## 3: Proinflammatory 0.7155963 0.9487459 0.15740290  0.4002094  0.6185734     8
## 4: Lipid_mediators 0.8472554 0.9487459 0.02921031 -0.6849303 -0.8766974     6
## 5:  CD8_Activation 0.9487459 0.9487459 0.01770381 -0.5167583 -0.6854459     9
##                                                                                leadingEdge
##                                                                                     <char>
## 1:           HLA-DRB1;HLA-DPB1;HLA-DPA1;HLA-DRA;HLA-DRB5;HLA-DQB1;HLA-DQA1;HLA-DMB;HLA-DMA
## 2: HLA-DRB1;HLA-DPB1;HLA-DPA1;HLA-DRA;HLA-DRB5;CD14;HLA-DQB1;HLA-DQA1;HLA-DMB;HLA-DMA;IL1B
## 3:                                                                               GZMA;PRF1
## 4:                                                                    CTSS;CFD;LGALS3;IL1B
## 5:                                                                                 HLA-DRA
##    geneRatio
##        <num>
## 1: 0.9000000
## 2: 0.7333333
## 3: 0.2500000
## 4: 0.6666667
## 5: 0.1111111
```

What does the result look like?

* **ES / NES** – raw and normalised enrichment scores from fgsea
* **pval / padj** – nominal and multiple-testing-corrected p
* **size** – total number of genes in the set
* **geneRatio** – (core hits)/(size), useful for dot plots
* **leadingEdge** – semi-colon-separated genes driving the signal

### 7.2.3 Visualising the enrichment table

The companion `enrichItPlot()` gives three quick chart types.

```
## (1) Bar plot –20 most significant per database
enrichItPlot(GSEA.results)
```

![](data:image/png;base64...)

```
## (2) Dot plot – coloured by –log10 padj, sized by core-hits
enrichItPlot(GSEA.results, "dot", top = 10)
```

![](data:image/png;base64...)

```
## (3) C-net plot – network of pathways ↔ leading-edge genes
enrichItPlot(GSEA.results, "cnet", top = 5)
```

![](data:image/png;base64...)

## 7.3 Differential Enrichment

Differential enrichment analysis can be performed similar to differential gene expression analysis. For the purposes of finding the differential enrichment values, we can first normalize the enrichment values for the ssGSEA calculations. Notice here, we are using **make.positive** = TRUE in order to adjust any negative values. This is a particular issue when it comes to ssGSEA and GSVA enrichment scores.

```
pbmc_small <- performNormalization(pbmc_small,
                                   assay = "escape.ssGSEA",
                                   gene.sets = escape.gene.sets,
                                   make.positive = TRUE)

all.markers <- FindAllMarkers(pbmc_small,
                              assay = "escape.ssGSEA_normalized",
                              min.pct = 0,
                              logfc.threshold = 0)

head(all.markers)
```

```
##                        p_val avg_log2FC pct.1 pct.2    p_val_adj cluster
## T2-Interferon   2.210898e-09 -0.4499809     1     1 1.989808e-08       0
## CD8-Activation  2.791543e-06  0.9948584     1     1 2.512388e-05       0
## M1.Macro        9.243851e-06 -0.3021382     1     1 8.319466e-05       0
## Cytolytic       1.104433e-04  1.9352033     1     1 9.939895e-04       0
## T1-Interferon   4.895518e-04 -0.4474723     1     1 4.405966e-03       0
## Lipid-mediators 6.294119e-03 -0.2174715     1     1 5.664707e-02       0
##                            gene
## T2-Interferon     T2-Interferon
## CD8-Activation   CD8-Activation
## M1.Macro               M1.Macro
## Cytolytic             Cytolytic
## T1-Interferon     T1-Interferon
## Lipid-mediators Lipid-mediators
```

---

# 8 Conclusions

If you have any questions, comments or suggestions, feel free to visit the [github repository](https://github.com/ncborcherding/escape).

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] ggplot2_4.0.1               RColorBrewer_1.1-3
##  [3] Seurat_5.4.0                SeuratObject_5.3.0
##  [5] sp_2.2-0                    scran_1.38.0
##  [7] scuttle_1.20.0              SingleCellExperiment_1.32.0
##  [9] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [11] GenomicRanges_1.62.1        Seqinfo_1.0.0
## [13] IRanges_2.44.0              S4Vectors_0.48.0
## [15] BiocGenerics_0.56.0         generics_0.1.4
## [17] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [19] escape_2.6.2                BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] GSVA_2.4.4                spatstat.sparse_3.1-0
##   [3] httr_1.4.7                tools_4.5.2
##   [5] sctransform_0.4.2         R6_2.6.1
##   [7] HDF5Array_1.38.0          lazyeval_0.2.2
##   [9] uwot_0.2.4                ggdist_3.3.3
##  [11] rhdf5filters_1.22.0       withr_3.0.2
##  [13] gridExtra_2.3             progressr_0.18.0
##  [15] cli_3.6.5                 spatstat.explore_3.6-0
##  [17] fastDummies_1.7.5         labeling_0.4.3
##  [19] sass_0.4.10               S7_0.2.1
##  [21] spatstat.data_3.1-9       ggridges_0.5.7
##  [23] pbapply_1.7-4             dichromat_2.0-0.1
##  [25] parallelly_1.46.0         limma_3.66.0
##  [27] RSQLite_2.4.5             ica_1.0-3
##  [29] spatstat.random_3.4-3     dplyr_1.1.4
##  [31] distributional_0.5.0      Matrix_1.7-4
##  [33] abind_1.4-8               lifecycle_1.0.4
##  [35] yaml_2.3.12               edgeR_4.8.2
##  [37] rhdf5_2.54.1              SparseArray_1.10.8
##  [39] Rtsne_0.17                grid_4.5.2
##  [41] blob_1.2.4                promises_1.5.0
##  [43] dqrng_0.4.1               crayon_1.5.3
##  [45] miniUI_0.1.2              lattice_0.22-7
##  [47] beachmat_2.26.0           cowplot_1.2.0
##  [49] annotate_1.88.0           KEGGREST_1.50.0
##  [51] magick_2.9.0              pillar_1.11.1
##  [53] knitr_1.51                metapod_1.18.0
##  [55] fgsea_1.36.2              rjson_0.2.23
##  [57] future.apply_1.20.1       codetools_0.2-20
##  [59] fastmatch_1.1-6           glue_1.8.0
##  [61] spatstat.univar_3.1-5     data.table_1.18.0
##  [63] memuse_4.2-3              vctrs_0.6.5
##  [65] png_0.1-8                 spam_2.11-1
##  [67] gtable_0.3.6              cachem_1.1.0
##  [69] xfun_0.55                 S4Arrays_1.10.1
##  [71] mime_0.13                 tidygraph_1.3.1
##  [73] survival_3.8-3            tinytex_0.58
##  [75] statmod_1.5.1             bluster_1.20.0
##  [77] fitdistrplus_1.2-4        ROCR_1.0-11
##  [79] nlme_3.1-168              bit64_4.6.0-1
##  [81] RcppAnnoy_0.0.22          bslib_0.9.0
##  [83] irlba_2.3.5.1             KernSmooth_2.23-26
##  [85] otel_0.2.0                DBI_1.2.3
##  [87] UCell_2.14.0              tidyselect_1.2.1
##  [89] bit_4.6.0                 compiler_4.5.2
##  [91] graph_1.88.1              BiocNeighbors_2.4.0
##  [93] h5mread_1.2.1             DelayedArray_0.36.0
##  [95] plotly_4.11.0             bookdown_0.46
##  [97] scales_1.4.0              lmtest_0.9-40
##  [99] hexbin_1.28.5             stringr_1.6.0
## [101] SpatialExperiment_1.20.0  digest_0.6.39
## [103] goftest_1.2-3             spatstat.utils_3.2-0
## [105] rmarkdown_2.30            XVector_0.50.0
## [107] htmltools_0.5.9           pkgconfig_2.0.3
## [109] sparseMatrixStats_1.22.0  fastmap_1.2.0
## [111] rlang_1.1.6               htmlwidgets_1.6.4
## [113] shiny_1.12.1              DelayedMatrixStats_1.32.0
## [115] farver_2.1.2              jquerylib_0.1.4
## [117] zoo_1.8-15                jsonlite_2.0.0
## [119] BiocParallel_1.44.0       BiocSingular_1.26.1
## [121] magrittr_2.0.4            dotCall64_1.2
## [123] patchwork_1.3.2           Rhdf5lib_1.32.0
## [125] Rcpp_1.1.0                viridis_0.6.5
## [127] reticulate_1.44.1         stringi_1.8.7
## [129] ggraph_2.2.2              MASS_7.3-65
## [131] plyr_1.8.9                parallel_4.5.2
## [133] listenv_0.10.0            ggrepel_0.9.6
## [135] deldir_2.0-4              Biostrings_2.78.0
## [137] graphlayouts_1.2.2        splines_4.5.2
## [139] tensor_1.5.1              locfit_1.5-9.12
## [141] igraph_2.2.1              spatstat.geom_3.6-1
## [143] RcppHNSW_0.6.0            reshape2_1.4.5
## [145] ScaledMatrix_1.18.0       XML_3.99-0.20
## [147] evaluate_1.0.5            BiocManager_1.30.27
## [149] tweenr_2.0.3              httpuv_1.6.16
## [151] RANN_2.6.2                tidyr_1.3.2
## [153] purrr_1.2.0               polyclip_1.10-7
## [155] future_1.68.0             scattermore_1.2
## [157] ggforce_0.5.0             rsvd_1.0.5
## [159] xtable_1.8-4              RSpectra_0.16-2
## [161] later_1.4.4               viridisLite_0.4.2
## [163] ggpointdensity_0.2.1      tibble_3.3.0
## [165] memoise_2.0.1             AnnotationDbi_1.72.0
## [167] cluster_2.1.8.1           globals_0.18.0
## [169] GSEABase_1.72.0
```