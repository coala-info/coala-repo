# Vignette of the esetVis package

#### Laure Cougnaud

#### 2025-10-29

# 1 Introduction

This document explains the functionalities available in the **esetVis** package.

This package contains wrapper functions for three types of visualization: **spectral map**(P.J. 1976), **tsne**(van der Maaten 2008) and **linear discriminant analysis**(Fisher 1936) for data contained in a *expressionSet Bioconductor* (or an *SummarizedExperiment*) object. The visualizations are available in two types: **static**, via the [ggplot2](https://cran.r-project.org/package%3Dggplot2) package or **interactive**, via the [ggvis](https://cran.r-project.org/package%3Dggvis) or [plotly](https://cran.r-project.org/package%3Dplotly) packages.

# 2 Example dataset

## 2.1 ExpressionSet object

The *ALL* dataset contains microarray results from 128 patients with acute lymphoblastic leukemia (ALL). The data is contained in a *Bioconductor* `ExpressionSet` object. Extra gene annotation is added to the object, via the annotation package `hgu95av2.db`.

```
    library(ALL)
    data(ALL)

    # to get gene annotation from probe IDs (from the paper HGU95aV2 gene chip was used)
    library("hgu95av2.db")
    library("AnnotationDbi")
    probeIDs <- featureNames(ALL)
    geneInfo <- AnnotationDbi::select(hgu95av2.db, probeIDs,
        c("ENTREZID", "SYMBOL", "GENENAME"), "PROBEID")
    # 482 on the 12625 probe IDs don't have ENTREZ ID/SYMBOL/GENENAME

    # remove genes with duplicated annotation: 1214
    geneInfoWthtDuplicates <- geneInfo[!duplicated(geneInfo$PROBEID), ]

    # remove genes without annotation: 482
    genesWthtAnnotation <- rowSums(is.na(geneInfoWthtDuplicates)) > 0
    geneInfoWthtDuplicatesAndWithAnnotation <- geneInfoWthtDuplicates[!genesWthtAnnotation, ]

    probeIDsWithAnnotation <- featureNames(ALL)[featureNames(ALL) %in%
        geneInfoWthtDuplicatesAndWithAnnotation$PROBEID]
    ALL <- ALL[probeIDsWithAnnotation, ]

    fData <- geneInfoWthtDuplicatesAndWithAnnotation[
        match(probeIDsWithAnnotation, geneInfoWthtDuplicatesAndWithAnnotation$PROBEID), ]
    rownames(fData) <- probeIDsWithAnnotation
    fData(ALL) <- fData

    # grouping variable: B = B-cell, T = T-cell
    groupingVariable <- pData(ALL)$BT

    # create custom palette
    colorPalette <- c("dodgerblue",
        colorRampPalette(c("white","dodgerblue2", "darkblue"))(5)[-1],
        "red", colorRampPalette(c("white", "red3", "darkred"))(5)[-1])
    names(colorPalette) <- levels(groupingVariable)
    color <- groupingVariable; levels(color) <- colorPalette

    # reformat type of the remission
    remissionType <- ifelse(is.na(ALL$remission), "unknown", as.character(ALL$remission))
    ALL$remissionType <- factor(remissionType,
        levels = c("unknown", "CR", "REF"),
        labels = c("unknown", "achieved", "refractory"))
```

Following tables detail some sample and gene annotation contained in the *ALL* `ExpressionSet` used in the vignette.

subset of the **phenoData** of the ALL dataset for the first genes

|  | cod | sex | age | BT | remissionType |
| --- | --- | --- | --- | --- | --- |
| **01005** | 1005 | M | 53 | B2 | achieved |
| **01010** | 1010 | M | 19 | B2 | achieved |
| **03002** | 3002 | F | 52 | B4 | achieved |
| **04006** | 4006 | M | 38 | B1 | achieved |
| **04007** | 4007 | M | 57 | B2 | achieved |
| **04008** | 4008 | M | 17 | B1 | achieved |

**featureData** of the ALL dataset for the first genes

|  | PROBEID | ENTREZID | SYMBOL | GENENAME |
| --- | --- | --- | --- | --- |
| **1000\_at** | 1000\_at | 5595 | MAPK3 | mitogen-activated protein kinase 3 |
| **1001\_at** | 1001\_at | 7075 | TIE1 | tyrosine kinase with immunoglobulin like and EGF like domains 1 |
| **1002\_f\_at** | 1002\_f\_at | 1557 | CYP2C19 | cytochrome P450 family 2 subfamily C member 19 |
| **1003\_s\_at** | 1003\_s\_at | 643 | CXCR5 | C-X-C motif chemokine receptor 5 |
| **1004\_at** | 1004\_at | 643 | CXCR5 | C-X-C motif chemokine receptor 5 |
| **1005\_at** | 1005\_at | 1843 | DUSP1 | dual specificity phosphatase 1 |

## 2.2 SummarizedExperiment object

The functions of the package also supports object of class: [`SummarizedExperiment`](http://bioconductor.org/packages/release/bioc/html/SummarizedExperiment.html). Note: In this case, the functions `fData`, `pData`, `exprs` should be replaced by their corresponding functions `rowData`, `colData` and `assay`.

# 3 Spectral map: `esetSpectralMap`

## 3.1 Simple spectral map

The function `esetSpectralMap` creates a **spectral map**(P.J. 1976) for the dataset. Some default parameters are set, e.g. to print the top 10 samples and top 10 genes, to display the first two dimensions of the analysis…

The resulting biplot contains two components:

* in the background, a cloud of the genes coordinates (plotted with the [hexbin](https://cran.r-project.org/web/packages/hexbin/index.html) package)
* in the foreground, each sample of the data is represented as a single point/symbol

Here is an example for the *ALL* dataset, with the default parameters.

```
    print(esetSpectralMap(eset = ALL))
```

![](data:image/png;base64...)

## 3.2 Additional sample information

Several annotation variables are available in the `eSet`.

### 3.2.1 General

Four different aesthetics `[aes]` can be used to display these variables:

* **color**, with the tag `color`
* **transparency**, with the tag `alpha`
* **size**, with the tag `size`
* **shape**, with the tag `shape`

For each of this aesthetic `[aes]`, several parameters are available:

* `[aes]Var`: name of the column of the `phenoData` of the `eSet` used for the aesthetic, i.e. `colorVar`
* `[aes]`: palette/specified shape/size used for the aesthetic, i.e. `color`

### 3.2.2 Custom size and transparency

Custom size and the transparency (variables `sizeVar` and `alphaVar`) can be specified:

* if the size/transparency is a numerical variable (numeric or integer), the range of the size/transparency can be specified respectively with the arguments `sizeRange` and `alphaRange`
* in the other cases (factor or character), custom size/transparency can be specified directly respectively via the `size` and `alpha` arguments

In the example, the type and stage of the disease (variable *BT*) is used for coloring, the remission type for the transparency, the *sex* for the shape and the *age* for the size of the points. A custom color palette is specified via the `color` argument.

```
    print(esetSpectralMap(eset = ALL,
        title = "Acute lymphoblastic leukemia dataset \n Spectral map \n Sample annotation (1)",
        colorVar = "BT", color = colorPalette,
        shapeVar = "sex",
        sizeVar = "age", sizeRange = c(0.1, 6),
        alphaVar = "remissionType", alpha = c(0.3, 0.6, 0.9),
        topSamples = 0, topGenes = 0, cloudGenes = TRUE))
```

![](data:image/png;base64...)

Just for the demonstration, another visualization of the same dataset, using this time a continuous variable: *age* for coloring and transparency, a factor for the size and *BT* for the shape. Because the output is a `ggplot` object, any additional customization not implemented via specific parameters, the plot can be modified with additional `ggplot2` functions, e.g. with the color of the gradient.

```
    gg <- esetSpectralMap(eset = ALL,
        title = "Acute lymphoblastic leukemia dataset \n Spectral map \n Sample annotation (2)",
        colorVar = "age",
        shapeVar = "BT", shape = 15+1:nlevels(ALL$BT),
        sizeVar = "remissionType", size = c(2, 4, 6),
        alphaVar = "age", alphaRange = c(0.2, 0.8),
        topSamples = 0, topGenes = 0, cloudGenes = TRUE)
    # change color of gradient
    library(ggplot2)
    gg <- gg + scale_color_gradientn(colours =
        colorRampPalette(c("darkgreen", "gold"))(2)
    )
    print(gg)
```

![](data:image/png;base64...)

## 3.3 Custom gene representation

Several parameters related to the gene visualization are available:

* gene subset: only a subset of the genes (at least two) can be displayed, via the argument `psids`
* gene cloud:
  + inclusion/removal of the gene cloud via `cloudGenes`
  + number of bins specification via `cloudGenesNBins`
  + cloud color via `cloudGenesColor`
  + legend:
    - inclusion/removal of the gene legend via `cloudGenesIncludeLegend`
    - title legend specified via `cloudGenesTitleLegend`

The spectral map is done only on the subset of the genes, with the number of bins, color, and legend title modified.

```
    print(esetSpectralMap(eset = ALL,
        psids = 1:1000,
        title = "Acute lymphoblastic leukemia dataset \n Spectral map \n Custom cloud genes",
        topSamples = 0, topGenes = 0,
        cloudGenes = TRUE, cloudGenesColor = "red", cloudGenesNBins = 50,
        cloudGenesIncludeLegend = TRUE, cloudGenesTitleLegend = "number of features"))
```

![](data:image/png;base64...)

## 3.4 Label outlying elements

### 3.4.1 Parameters

Three different kind of elements can be labelled in the plot: **genes, samples and gene sets**.

For each `[element]`, several parameters are available:

* `top[Elements]`: number of elements to label
* `top[Elements]Var` (not available for gene sets): column of the corresponding element in the `eSet` used for labelling, in `phenoData` for sample and `featureData` for gene. If not specified, the feature/sample names of the `eSet` are used
* `top[Elements]Just`: label justification
* `top[Elements]Cex`: label size
* `top[Elements]Color`: label color

### 3.4.2 Method to select top elements

The **distance (sum of squared coordinates) of the gene/sample/gene set to the origin of the plot** is used to rank the elements, and to extract the top ‘outlying’ ones.

### 3.4.3 Package used for static plot

By default (and if installed), the package [ggrepel](https://cran.r-project.org/web/packages/ggrepel/index.htm) is used for text labelling (as in this vignette), to avoid overlapping labels. The text labels can also be displayed with the [ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html) by setting the parameter `packageTextLabel` to `ggplot2` (default `ggrepel`).

### 3.4.4 Example

In the example, the top genes are labelled with gene symbols (*SYMBOL* column of the phenoData of the eSet), and the top samples with patient identifiers (*cod* column of the phenoData of the eSet).

```
    print(esetSpectralMap(eset = ALL,
        title = paste("Acute lymphoblastic leukemia dataset \n",
            "Spectral map \n Label outlying samples and genes"),
        colorVar = "BT", color = colorPalette,
        shapeVar = "sex",
        sizeVar = "age", sizeRange = c(2, 6),
        alphaVar = "remissionType", alpha = c(0.3, 0.6, 0.9),
        topGenes = 10, topGenesVar = "SYMBOL",
        topGenesCex = 2, topGenesColor = "darkgrey",
        topSamples = 15, topSamplesVar = "cod", topSamplesColor = "chocolate4",
        topSamplesCex = 3
    ))
```

![](data:image/png;base64...)

## 3.5 Gene sets annotation

Genes can be grouped into biologically meaningful gene sets, which can be labelled in the biplot.

Compared to previous section, two additional parameters are available:

* `geneSets` (**required**): list of gene sets. Each element in the list should contain genes identifiers, and the list should be named
* `geneSetsVar`: column of the featureData of the eSet used to map the gene identifiers contained in the `geneSets` object
* `geneSetsMaxNChar`: number of characters used in gene sets labels

The `geneSets` can be created with the `getGeneSetsForPlot` function (wrapper around the `getGeneSets` function of the [MLP](https://www.bioconductor.org/packages/release/bioc/html/MLP.html) package), which can extract gene sets available in the Gene Ontology (Biological Process, Molecular Function and Cellular Component) and KEGG databases. Custom gene set lists can also be provided.

In the following example, only the pathways from the *GOBP* database are used.

```
    geneSets <- getGeneSetsForPlot(
        entrezIdentifiers = fData(ALL)$ENTREZID,
        species = "Human",
        geneSetSource = 'GOBP',
        useDescription = TRUE)
```

Then this list of gene sets is provided to the `esetSpectralMap` function.

```
    print(esetSpectralMap(eset = ALL,
        title = "Acute lymphoblastic leukemia dataset \n Spectral map \n Gene set annotation",
        colorVar = "BT", color = colorPalette,
        shapeVar = "sex",
        sizeVar = "age", sizeRange = c(2, 6),
        alphaVar = "remissionType", alpha = c(0.3, 0.6, 0.9),
        topGenes = 0,
        topGeneSets = 4, geneSets = geneSets, geneSetsVar = "ENTREZID", geneSetsMaxNChar = 30,
        topGeneSetsCex = 2, topGeneSetsColor = "purple"))
```

![](data:image/png;base64...)

Note: because of the inherent hierarchical structure of the Gene Ontology database, sets of genes can be very similar, which can result in close (even overlapping) labels in the visualization.

## 3.6 Dimensions of the biplot

In all previous plots, only the first dimensions of the principal component analysis were visualized, this can be specified via the `dim` parameter. The third and fourth dimensions are visualized in the next Figure. This parameter is only available for the spectral map visualization.

```
    print(esetSpectralMap(eset = ALL,
        title = "Acute lymphoblastic leukemia dataset \n Spectral map \n Dimensions of the PCA",
        colorVar = "BT", color = colorPalette,
        shapeVar = "sex",
        sizeVar = "age", sizeRange = c(0.5, 4),
        alphaVar = "remissionType", alpha = c(0.3, 0.6, 0.9),
        dim = c(3, 4)))
```

![](data:image/png;base64...)

## 3.7 Implementation

The function uses the `mpm` and `plot.mpm` function from the `mpm` package. Some default parameters are set for these two functions, they can be changed via the `mpm.args` and `plot.mpm.args` arguments. For further details, refer to the documentation of these two functions.

Note: One important argument is `logtrans` in `mpm` function, which indicates if the **data should be first log-transformed** before the computation. It is set by default to FALSE, **assuming that the data are already in the log scale** (it is the case for the *ALL* dataset).

## 3.8 Interactive spectral map

All plots available in the `esetVis` package can be **static or interactive**.

The argument `typePlot` can be set respectively to `static` (by default), in this case `ggplot2` is used, or `interactive`, in this case either the `ggvis` or `plotly` package is used.

Two functionalities of the interactive plot can be of interest for such high-dimensional data:

* **hover** to check sample annotation. By default, only the sample variables used for the aesthetics are displayed when hovering on a specific sample dot. Additional sample variables (contained in `phenoData`) displayed in the hover can be specified via the `interactiveTooltipExtraVars` parameter.
* **zoom** to focus on specific sample in high-dimensional dataset

An interactive version of the spectral map of the previous section is created.

### 3.8.1 plotly

```
esetSpectralMap(
    eset = ALL,
    title = paste("Acute lymphoblastic leukemia dataset - spectral map"),
    colorVar = "BT", color = unname(colorPalette),
    shapeVar = "sex",
    alphaVar = "remissionType",
    typePlot = "interactive", packageInteractivity = "plotly",
    figInteractiveSize = c(700, 600),
    topGenes = 10, topGenesVar = "SYMBOL",
    topSamples = 10,
    # use all sample variables for hover
    interactiveTooltipExtraVars = varLabels(ALL)
)
```

### 3.8.2 ggvis

Note: as `ggvis` plot requires to have a R session running, only a static version of the plot is included.

```
library(ggvis)

# embed a static version of the plot
esetSpectralMap(
    eset = ALL,
    title = paste("Acute lymphoblastic leukemia dataset - spectral map"),
    colorVar = "BT", color = unname(colorPalette),
    shapeVar = "sex",
    alphaVar = "remissionType",
    typePlot = "interactive", packageInteractivity = "ggvis",
    figInteractiveSize = c(700, 600),
    sizeVar = "age", sizeRange = c(2, 6),
    # use all phenoData variables for hover
    interactiveTooltipExtraVars = varLabels(ALL)
)
```

* Renderer:
  SVG
  |
  Canvas
* Download

# 4 Tsne: `esetTsne`

## 4.1 General

Another unsupervised visualization is available in the package: **t-Distributed Stochastic Neighbor Embedding** (*tsne*). The function `esetTnse` uses the `Rtsne` function of the same package.

Most of the previous parameters discussed for the spectral map are available for this visualization, at the exception of:

* parameter linked to gene annotation/labelling. The gene annotation is not (yet) mapped to the sample coordinated obtained as output from the `Rtsne` function
* parameter specific to the spectral map, i.e. `dim`

Arguments to the `Rtsne` function can be specified via the `Rtsne.args` argument.

Here is an example of tsne, for the same dataset and same annotation/labelling.

```
    print(esetTsne(eset = ALL,
        title = "Acute lymphoblastic leukemia dataset \n Tsne",
        colorVar = "BT", color = colorPalette,
        shapeVar = "sex",
        sizeVar = "age", sizeRange = c(2, 6),
        alphaVar = "remissionType", alpha = c(0.3, 0.6, 0.9),
        topSamplesVar = "cod"
    ))
```

![](data:image/png;base64...)

## 4.2 Additional pre-processing step

The tsne can be quite time-consuming, especially for big data. As the `Rtsne` function used in the background can also uses an object of class `dist`, the data can be pre-transformed before running the `tsne` analysis. The argument `fctTransformDataForInputTsne` enables to specify a custom function to pre-transform the data.

```
    print(esetTsne(eset = ALL,
        title = "Acute lymphoblastic leukemia dataset \n Tsne",
        colorVar = "BT", color = colorPalette,
        shapeVar = "sex",
        sizeVar = "age", sizeRange = c(2, 6),
        alphaVar = "remissionType", alpha = c(0.3, 0.6, 0.9),
        topSamplesVar = "cod",
        fctTransformDataForInputTsne =
            function(mat)   as.dist((1 - cor(mat))/2)
    ))
```

![](data:image/png;base64...)

# 5 Linear discriminant analysis: `esetLda`

Another visualization, this time semi-supervised (as a variable is used for the computation), is included: **Linear Discriminant Analysis**. This uses the `lda` function from the `MASS` package.

This function maximizes the variance between levels of a factor, here describing some sample annotation, specified via the `ldaVar` argument.

As this analysis can be quite time consuming, for the demonstration, the analysis is run only a random feature subset of the data.

## 5.1 All samples

The `returnAnalysis` parameter can be used, to extract the analysis which will be used as input for the `esetPlotWrapper` function, used in the background. It is available also for the `esetSpectralMap` and `esetTnse` functions.

```
    # extract random features, because analysis is quite time consuming
    retainedFeatures <- sample(featureNames(ALL), size = floor(nrow(ALL)/5))

    # run the analysis
    outputEsetLda <- esetLda(eset = ALL[retainedFeatures, ], ldaVar = "BT",
        title = paste("Acute lymphoblastic leukemia dataset \n",
            "Linear discriminant analysis on BT variable \n",
            "(Subset of the feature data)"),
        colorVar = "BT", color = colorPalette,
        shapeVar = "sex",
        sizeVar = "age", sizeRange = c(2, 6),
        alphaVar = "remissionType", alpha = c(0.3, 0.6, 0.9),
        topSamplesVar = "cod", topGenesVar = "SYMBOL",
        returnAnalysis = TRUE
    )

    # extract and print the ggplot object
    print(outputEsetLda$plot)
```

![](data:image/png;base64...)

The top elements (here genes and samples) labelled in the plot can be accessed via the `topElements` slot of the object. These are labelled with the identifiers used in the plot and named with sample/gene identifiers of the `eset`.

```
    # extract top elements labelled in the plot
    pander(t(data.frame(topGenes = outputEsetLda$topElements[["topGenes"]])))
```

Table continues below

|  | 38319\_at | 33238\_at | 38095\_i\_at | 39389\_at | 40570\_at |
| --- | --- | --- | --- | --- | --- |
| **topGenes** | CD3D | LCK | HLA-DPB1 | CD9 | FOXO1 |

|  | 33316\_at | 39709\_at | 1498\_at | 34741\_at | 38051\_at |
| --- | --- | --- | --- | --- | --- |
| **topGenes** | TOX | SELENOW | ZAP70 | TFDP2 | MAL |

```
    pander(t(data.frame(topSamples = outputEsetLda$topElements[["topSamples"]])))
```

Table continues below

|  | 01005 | 16007 | 63001 | 26008 | 24005 | 12007 | 28008 | 04008 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| **topSamples** | 1005 | 16007 | 63001 | 26008 | 24005 | 12007 | 28008 | 4008 |

|  | 49006 | 04006 |
| --- | --- | --- |
| **topSamples** | 49006 | 4006 |

When `returnAnalysis` is set to TRUE, the output of the function can be used as input to the `esetPlotWrapper` function, and extra parameters can then be modified.

Here the variable used for the shape of the points for the samples is changed to type of remission (*remissionType* column).

```
    # to change some plot parameters
    esetPlotWrapper(
        dataPlotSamples = outputEsetLda$analysis$dataPlotSamples,
        dataPlotGenes = outputEsetLda$analysis$dataPlotGenes,
        esetUsed = outputEsetLda$analysis$esetUsed,
        title = paste("Acute lymphoblastic leukemia dataset \n",
            "Linear discriminant analysis on BT variable (2) \n",
            "(Subset of the feature data)"),
        colorVar = "BT", color = colorPalette,
        shapeVar = "remissionType",
        sizeVar = "age", sizeRange = c(2, 6),
        alphaVar = "remissionType", alpha = c(0.3, 0.6, 0.9),
        topSamplesVar = "cod", topGenesVar = "SYMBOL"
    )
```

![](data:image/png;base64...)

## 5.2 Data sample subset

From the previous visualization (obtained on a subset of the genes), the biggest difference between all levels of the type/stage of the disease seems to reside between all B-cells (tagged *B*) and T-cells (tagged *T*). It might be interesting to focus on a subset of the data, e.g. only one cell type.

```
    # keep only 'B-cell' samples
    ALLBCell <- ALL[, grep("^B", ALL$BT)]
    ALLBCell$BT <- factor(ALLBCell$BT)
    colorPaletteBCell <- colorPalette[1:nlevels(ALLBCell$BT )]

    print(esetLda(eset = ALLBCell[retainedFeatures, ], ldaVar = "BT",
        title = paste("Acute lymphoblastic leukemia dataset \n",
            "Linear discriminant analysis on BT variable \n B-cell only",
            "(Subset of the feature data)"
        ),
        colorVar = "BT", color = colorPaletteBCell,
        shapeVar = "sex",
        sizeVar = "age", sizeRange = c(2, 6),
        alphaVar = "remissionType", alpha = c(0.3, 0.6, 0.9),
        topSamplesVar = "cod", topGenesVar = "SYMBOL",
    ))
```

![](data:image/png;base64...)

The subcell type which seems to differ the most within all B-cell type is the first one: *B1* (most of these samples at the right side of the plot).

# References

Fisher, R. A. 1936. “The Use of Multiple Measurements in Taxonomic Problems” 7 (2): 179–88.

P.J., Lewi. 1976. “Spectral Mapping, a Technique for Classifying Biological Activity Profiles of Chemical Compounds” 26: 1295–1300.

van der Maaten, L. J. P. 2008. “Visualizing High-Dimensional Data Using T-SNE” 26: 2579–2605.