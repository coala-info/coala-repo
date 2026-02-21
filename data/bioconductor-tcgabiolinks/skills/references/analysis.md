[[![](data:image/png;base64...)](http://bioconductor.org/packages/TCGAbiolinks/)](index.html)

* [Introduction](index.html)
* Data

  + Molecular data
  + [Query](query.html)
  + [Download & Prepare](download_prepare.html)
  + Other data
  + [Clinical data](clinical.html)
  + [Mutation data](mutation.html)
  + [Molecular subtypes](subtypes.html)
  + [ATAC-seq](http://rpubs.com/tiagochst/atac_seq_workshop)
* Analysis

  + [Analysis functions](analysis.html)
  + [Other functions](extension.html)
  + [Importing data to DESeq2](http://rpubs.com/tiagochst/TCGAbiolinks_to_DESEq2)
  + [Glioma classsifier](classifiers.html)
* [Case Study](casestudy.html)

* Workshops
  + TCGA workshop
  + [Workshop - TCGA data analysis](http://rpubs.com/tiagochst/TCGAworkshop)
  + ELMER workshop
  + [Workshop for multi-omics analysis with ELMER](http://rpubs.com/tiagochst/ELMER_workshop)
  + ATAC-Seq workshop
  + [Workshop for ATAC-Seq analysis](http://rpubs.com/tiagochst/atac_seq_workshop)
  + Bioc2017 workshop
  + [Github ELMER/TCGAbiolinks](https://github.com/BioinformaticsFMRP/Bioc2017.TCGAbiolinks.ELMER)
* + TCGAbiolinks package
  + [Github](https://github.com/BioinformaticsFMRP/TCGAbiolinks)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/TCGAbiolinks.html)
  + TCGAbiolinksGUI package
  + [Github](https://github.com/BioinformaticsFMRP/TCGAbiolinksGUI)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/TCGAbiolinksGUI.html)
  + ELMER package
  + [Github](https://github.com/tiagochst/ELMER)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/ELMER.html)
  + ELMER.data package
  + [Github](https://github.com/tiagochst/ELMER)
  + [Bioconductor](http://bioconductor.org/packages/devel/bioc/html/ELMER.html)
* + University of São Paulo (USP)
  + [fmrp.usp.br](http://www.fmrp.usp.br/?lang=en)
  + Fundings
  + [FAPESP (16/10436-9)](http://www.bv.fapesp.br/en/pesquisa/?sort=-data_inicio&q2=%28instituicao%3A%22Cedars-Sinai+Medical+Center%22%29+AND+%28%28bolsa_en_exact%3A%22Scholarships+abroad%22+AND+situacao_en_exact%3A%22Ongoing%22%29%29)
  + [FAPESP (16/01389-7)](http://bv.fapesp.br/en/pesquisa/?sort=-data_inicio&q2=%28id_pesquisador_exact%3A679917%29+AND+%28%28bolsa_en_exact%3A%22Scholarships+in+Brazil%22+AND+situacao_en_exact%3A%22Ongoing%22%29%29)

# Analyzing and visualizing TCGA data

# `TCGAanalyze`: Analyze data from TCGA.

You can easily analyze data using following functions:

## `TCGAanalyze_Preprocessing`: Preprocessing of Gene Expression data (IlluminaHiSeq\_RNASeqV2)

You can easily search TCGA samples, download and prepare a matrix of gene expression.

```
# You can define a list of samples to query and download providing relative TCGA barcodes.
listSamples <- c(
    "TCGA-E9-A1NG-11A-52R-A14M-07","TCGA-BH-A1FC-11A-32R-A13Q-07",
    "TCGA-A7-A13G-11A-51R-A13Q-07","TCGA-BH-A0DK-11A-13R-A089-07",
    "TCGA-E9-A1RH-11A-34R-A169-07","TCGA-BH-A0AU-01A-11R-A12P-07",
    "TCGA-C8-A1HJ-01A-11R-A13Q-07","TCGA-A7-A13D-01A-13R-A12P-07",
    "TCGA-A2-A0CV-01A-31R-A115-07","TCGA-AQ-A0Y5-01A-11R-A14M-07"
)

# Query platform Illumina HiSeq with a list of barcode
query <- GDCquery(
    project = "TCGA-BRCA",
    data.category = "Transcriptome Profiling",
    data.type = "Gene Expression Quantification",
    barcode = listSamples
)

# Download a list of barcodes with platform IlluminaHiSeq_RNASeqV2
GDCdownload(query)

# Prepare expression matrix with geneID in the rows and samples (barcode) in the columns
# rsem.genes.results as values
BRCA.Rnaseq.SE <- GDCprepare(query)

BRCAMatrix <- assay(BRCA.Rnaseq.SE,"unstranded")
# For gene expression if you need to see a boxplot correlation and AAIC plot to define outliers you can run
BRCA.RNAseq_CorOutliers <- TCGAanalyze_Preprocessing(BRCA.Rnaseq.SE)
```

The result is shown below:

Example of a matrix of gene expression (10 genes in rows and 2 samples in columns)

|  | TCGA-BH-A0AU-01A-11R-A12P-07 | TCGA-A7-A13D-01A-13R-A12P-07 |
| --- | --- | --- |
| BCL2L15|440603 | 6 | 10 |
| CDH17|1015 | 6 | 1 |
| COL13A1|1305 | 41 | 553 |
| IFI44|10561 | 914 | 2192 |
| GSTT2|2953 | 246 | 334 |
| DEFB103B|414325 | 0 | 0 |
| DNAJC30|84277 | 584 | 1170 |
| FAM164A|51101 | 618 | 636 |
| POLR2G|5436 | 3184 | 5283 |
| IGF2BP2|10644 | 51 | 861 |

The result from `TCGAanalyze_Preprocessing` is shown below: ![](data:image/png;base64...)

## `TCGAanalyze_DEA` `&` `TCGAanalyze_LevelTab`: Differential expression analysis (DEA)

Perform DEA (Differential expression analysis) to identify differentially expressed genes (DEGs) using the `TCGAanalyze_DEA` function.

`TCGAanalyze_DEA` performs DEA using following functions from R :

1. edgeR::DGEList converts the count matrix into an edgeR object.
2. edgeR::estimateCommonDisp each gene gets assigned the same dispersion estimate.
3. edgeR::exactTest performs pair-wise tests for differential expression between two groups.
4. edgeR::topTags takes the output from exactTest(), adjusts the raw p-values using the False Discovery Rate (FDR) correction, and returns the top differentially expressed genes.

This function receives as arguments:

* **mat1** The matrix of the first group (in the example, group 1 is the normal samples),
* **mat2** The matrix of the second group (in the example, group 2 is tumor samples)
* **Cond1type** Label for group 1
* **Cond1type** Label for group 2

Next, we filter the output of dataDEGs by abs(LogFC) >=1, and uses the `TCGAanalyze_LevelTab` function to create a table with DEGs (differentially expressed genes), log Fold Change (FC), false discovery rate (FDR), the gene expression level for samples in Cond1type, and Cond2type, and Delta value (the difference of gene expression between the two conditions multiplied logFC).

```
library(TCGAbiolinks)

# normalization of genes
dataNorm <- TCGAanalyze_Normalization(
    tabDF = BRCA.RNAseq_CorOutliers,
    geneInfo =  geneInfoHT
)

# quantile filter of genes
dataFilt <- TCGAanalyze_Filtering(
    tabDF = dataNorm,
    method = "quantile",
    qnt.cut =  0.25
)

# selection of normal samples "NT"
samplesNT <- TCGAquery_SampleTypes(
    barcode = colnames(dataFilt),
    typesample = c("NT")
)

# selection of tumor samples "TP"
samplesTP <- TCGAquery_SampleTypes(
    barcode = colnames(dataFilt),
    typesample = c("TP")
)

# Diff.expr.analysis (DEA)
dataDEGs <- TCGAanalyze_DEA(
    mat1 = dataFilt[,samplesNT],
    mat2 = dataFilt[,samplesTP],
    Cond1type = "Normal",
    Cond2type = "Tumor",
    fdr.cut = 0.01 ,
    logFC.cut = 1,
    method = "glmLRT"
)

# DEGs table with expression values in normal and tumor samples
dataDEGsFiltLevel <- TCGAanalyze_LevelTab(
    FC_FDR_table_mRNA = dataDEGs,
    typeCond1 = "Tumor",
    typeCond2 = "Normal",
    TableCond1 = dataFilt[,samplesTP],
    TableCond2 = dataFilt[,samplesNT]
)
```

The result is shown below:

Table of DEGs after DEA

| mRNA | logFC | FDR | Tumor | Normal | Delta |
| --- | --- | --- | --- | --- | --- |
| FN1 | 2.88 | 1.296151e-19 | 347787.48 | 41234.12 | 1001017.3 |
| COL1A1 | 1.77 | 1.680844e-08 | 358010.32 | 89293.72 | 633086.3 |
| C4orf7 | 5.20 | 2.826474e-50 | 87821.36 | 2132.76 | 456425.4 |
| COL1A2 | 1.40 | 9.480478e-06 | 273385.44 | 91241.32 | 383242.9 |
| GAPDH | 1.32 | 3.290678e-05 | 179057.44 | 63663.00 | 236255.5 |
| CLEC3A | 6.79 | 7.971002e-74 | 27257.16 | 259.60 | 185158.6 |
| IGFBP5 | 1.24 | 1.060717e-04 | 128186.88 | 53323.12 | 158674.6 |
| CPB1 | 4.27 | 3.044021e-37 | 37001.76 | 2637.72 | 157968.8 |
| CARTPT | 6.72 | 1.023371e-72 | 21700.96 | 215.16 | 145872.8 |
| DCD | 7.26 | 1.047988e-80 | 19941.20 | 84.80 | 144806.3 |

Other examples are in the next sections.

### HTSeq data: Downstream analysis BRCA

```
query <- GDCquery(
    project = "TCGA-BRCA",
    data.category = "Transcriptome Profiling",
    data.type = "Gene Expression Quantification",
    workflow.type = "STAR - Counts"
)

samplesDown <- getResults(query,cols=c("cases"))

dataSmTP <- TCGAquery_SampleTypes(
    barcode = samplesDown,
    typesample = "TP"
)

dataSmNT <- TCGAquery_SampleTypes(
    barcode = samplesDown,
    typesample = "NT"
)
dataSmTP_short <- dataSmTP[1:10]
dataSmNT_short <- dataSmNT[1:10]

query.selected.samples <- GDCquery(
    project = "TCGA-BRCA",
    data.category = "Transcriptome Profiling",
    data.type = "Gene Expression Quantification",
    workflow.type = "STAR - Counts",
    barcode = c(dataSmTP_short, dataSmNT_short)
)

GDCdownload(
    query = query.selected.samples
)

dataPrep <- GDCprepare(
    query = query.selected.samples,
    save = TRUE
)

dataPrep <- TCGAanalyze_Preprocessing(
    object = dataPrep,
    cor.cut = 0.6,
    datatype = "HTSeq - Counts"
)

dataNorm <- TCGAanalyze_Normalization(
    tabDF = dataPrep,
    geneInfo = geneInfoHT,
    method = "gcContent"
)

boxplot(dataPrep, outline = FALSE)

boxplot(dataNorm, outline = FALSE)

dataFilt <- TCGAanalyze_Filtering(
    tabDF = dataNorm,
    method = "quantile",
    qnt.cut =  0.25
)

dataDEGs <- TCGAanalyze_DEA(
    mat1 = dataFilt[,dataSmTP_short],
    mat2 = dataFilt[,dataSmNT_short],
    Cond1type = "Normal",
    Cond2type = "Tumor",
    fdr.cut = 0.01 ,
    logFC.cut = 1,
    method = "glmLRT"
)
```

### miRNA expression data: Downstream analysis BRCA

```
require(TCGAbiolinks)

query.miRNA <- GDCquery(
    project = "TCGA-BRCA",
    experimental.strategy = "miRNA-Seq",
    data.category = "Transcriptome Profiling",
    data.type = "miRNA Expression Quantification"
)

GDCdownload(query = query.miRNA)

dataAssy.miR <- GDCprepare(
    query = query.miRNA
)
rownames(dataAssy.miR) <- dataAssy.miR$miRNA_ID

# using read_count's data
read_countData <-  colnames(dataAssy.miR)[grep("count", colnames(dataAssy.miR))]
dataAssy.miR <- dataAssy.miR[,read_countData]
colnames(dataAssy.miR) <- gsub("read_count_","", colnames(dataAssy.miR))

dataFilt <- TCGAanalyze_Filtering(
    tabDF = dataAssy.miR,
    method = "quantile",
    qnt.cut =  0.25
)

dataDEGs <- TCGAanalyze_DEA(
    mat1 = dataFilt[,dataSmNT_short.miR],
    mat2 = dataFilt[,dataSmTP_short.miR],
    Cond1type = "Normal",
    Cond2type = "Tumor",
    fdr.cut = 0.01 ,
    logFC.cut = 1,
    method = "glmLRT"
)
```

## `TCGAanalyze_EAcomplete & TCGAvisualize_EAbarplot`: Enrichment Analysis

Researchers, in order to better understand the underlying biological processes, often want to retrieve a functional profile of a set of genes that might have an important role. This can be done by performing an enrichment analysis.

We will perform an enrichment analysis on gene sets using the `TCGAanalyze_EAcomplete` function. Given a set of genes that are up-regulated under certain conditions, an enrichment analysis will identify classes of genes or proteins that are over-represented using annotations for that gene set.

To view the results you can use the `TCGAvisualize_EAbarplot` function as shown below.

```
library(TCGAbiolinks)
# Enrichment Analysis EA
# Gene Ontology (GO) and Pathway enrichment by DEGs list
Genelist <- rownames(dataDEGsFiltLevel)

ansEA <- TCGAanalyze_EAcomplete(
    TFname = "DEA genes Normal Vs Tumor",
    RegulonList = Genelist
)

# Enrichment Analysis EA (TCGAVisualize)
# Gene Ontology (GO) and Pathway enrichment barPlot

TCGAvisualize_EAbarplot(
    tf = rownames(ansEA$ResBP),
    GOBPTab = ansEA$ResBP,
    GOCCTab = ansEA$ResCC,
    GOMFTab = ansEA$ResMF,
    PathTab = ansEA$ResPat,
    nRGTab = Genelist,
    nBar = 10
)
```

The result is shown below: ![](data:image/png;base64...)

The figure shows canonical pathways significantly overrepresented (enriched) by the DEGs (differentially expressed genes). The most statistically significant canonical pathways identified in DEGs list are listed according to their p value corrected FDR (-Log) (colored bars) and the ratio of list genes found in each pathway over the total number of genes in that pathway (Ratio, red line).

## `TCGAanalyze_survival`: Survival Analysis

When analyzing survival, different problems come up than the ones discussed so far. One question is how do we deal with subjects dropping out of a study. For example, assuming that we test a new cancer drug. While some subjects die, others may believe that the new drug is not effective, and decide to drop out of the study before the study is finished. A similar problem would be faced when we investigate how long a machine lasts before it breaks down.

Using the clinical data, it is possible to create a survival plot with the function `TCGAanalyze_survival` as follows:

```
clin.gbm <- GDCquery_clinic("TCGA-GBM", "clinical")
TCGAanalyze_survival(
    data = clin.gbm,
    clusterCol = "gender",
    main = "TCGA Set\n GBM",
    height = 10,
    width=10
)
```

The arguments of `TCGAanalyze_survival` are:

* **clinical\_patient** TCGA Clinical patient with the information days\_to\_death
* **clusterCol** Column with groups to plot. This is a mandatory field, the caption will be based in this column
* **legend** Legend title of the figure
* **xlim** xlim x axis limits e.g. xlim = c(0, 1000). Present narrower X axis, but not affect survival estimates.
* **main** main title of the plot
* **ylab** y-axis text of the plot
* **xlab** x-axis text of the plot
* **filename** The name of the pdf file
* **color** Define the colors of the lines.
* **pvalue** Show pvalue in the plot.
* **risk.table** Show or not the risk table
* **conf.int** Show confidence intervals for point estimates of survival curves.

The result is shown below: ![](data:image/png;base64...)

## `TCGAanalyze_SurvivalKM`: Correlating gene expression and Survival Analysis

```
library(TCGAbiolinks)
# Survival Analysis SA

clinical_patient_Cancer <- GDCquery_clinic("TCGA-BRCA","clinical")
dataBRCAcomplete <- log2(BRCA_rnaseqv2)

tokenStop <- 1

tabSurvKMcomplete <- NULL

for( i in 1: round(nrow(dataBRCAcomplete)/100)){
    message( paste( i, "of ", round(nrow(dataBRCAcomplete)/100)))
    tokenStart <- tokenStop
    tokenStop <- 100 * i
    tabSurvKM <- TCGAanalyze_SurvivalKM(
        clinical_patient_Cancer,
        dataBRCAcomplete,
        Genelist = rownames(dataBRCAcomplete)[tokenStart:tokenStop],
        Survresult = F,
        ThreshTop = 0.67,
        ThreshDown = 0.33
    )

    tabSurvKMcomplete <- rbind(tabSurvKMcomplete,tabSurvKM)
}

tabSurvKMcomplete <- tabSurvKMcomplete[tabSurvKMcomplete$pvalue < 0.01,]
tabSurvKMcomplete <- tabSurvKMcomplete[order(tabSurvKMcomplete$pvalue, decreasing=F),]

tabSurvKMcompleteDEGs <- tabSurvKMcomplete[
    rownames(tabSurvKMcomplete) %in% dataDEGsFiltLevel$mRNA,
]
```

The result is shown below:

Table KM-survival genes after SA

|  | pvalue | Cancer Deaths | Cancer Deaths with Top | Cancer Deaths with Down |
| --- | --- | --- | --- | --- |
| DCTPP1 | 6.204170e-08 | 66 | 46 | 20 |
| APOO | 9.390193e-06 | 65 | 49 | 16 |
| LOC387646 | 1.039097e-05 | 69 | 48 | 21 |
| PGK1 | 1.198577e-05 | 71 | 49 | 22 |
| CCNE2 | 2.100348e-05 | 65 | 48 | 17 |

|  | Mean Tumor Top | Mean Tumor Down | Mean Normal |
| --- | --- | --- | --- |
| DCTPP1 | 13.31 | 12.01 | 11.74 |
| APOO | 11.40 | 10.17 | 10.01 |
| LOC387646 | 7.92 | 4.64 | 5.90 |
| PGK1 | 15.66 | 14.18 | 14.28 |
| CCNE2 | 11.07 | 8.23 | 7.03 |

## `TCGAanalyze_DMR`: Differentially methylated regions Analysis

We will search for differentially methylated CpG sites using the `TCGAanalyze_DMR` function. In order to find these regions we use the beta-values (methylation values ranging from 0.0 to 1.0) to compare two groups.

First, it calculates the difference between the mean DNA methylation of each group for each probe.

Second, it test for differential expression between two groups using the wilcoxon test adjusting by the Benjamini-Hochberg method. The default arguments was set to require a minimum absolute beta-values difference of 0.2 and an adjusted p-value of < 0.01.

After these tests, we save a volcano plot (x-axis:diff mean methylation, y-axis: statistical significance) that will help the user identify the differentially methylated CpG sites, then the results are saved in a csv file (DMR\_results.groupCol.group1.group2.csv) and finally the object is returned with the calculus in the rowRanges.

The arguments of TCGAanalyze\_DMR are:

| Argument | Description |
| --- | --- |
| data | SummarizedExperiment obtained from the TCGAPrepare |
| groupCol | Columns with the groups inside the SummarizedExperiment object. (This will be obtained by the function colData(data)) |
| group1 | In case our object has more than 2 groups, you should set the name of the group |
| group2 | In case our object has more than 2 groups, you should set the name of the group |
| calculate.pvalues.probes | In order to get the probes faster the user can select to calculate the pvalues only for the probes with a difference in DNA methylation. The default is to calculate to all probes. Possible values: “all”, “differential”. Default “all” |
| plot.filename | Filename. Default: volcano.pdf, volcano.svg, volcano.png. If set to FALSE, there will be no plot. |
| ylab | y axis text |
| xlab | x axis text |
| title | main title. If not specified it will be "Volcano plot (group1 vs group2) |
| legend | Legend title |
| color | vector of colors to be used in graph |
| label | vector of labels to be used in the figure. Example: c(“Not Significant”,“Hypermethylated in group1”, “Hypomethylated in group1”)) |
| xlim | x limits to cut image |
| ylim | y limits to cut image |
| p.cut | p values threshold. Default: 0.01 |
| probe.names | is probe.names |
| diffmean.cut | diffmean threshold. Default: 0.2 |
| paired | Wilcoxon paired parameter. Default: FALSE |
| adj.method | Adjusted method for the p-value calculation |
| overwrite | Overwrite the pvalues and diffmean values if already in the object for both groups? Default: FALSE |
| cores | Number of cores to be used in the non-parametric test Default = groupCol.group1.group2.rda |
| save | Save object with results? Default: TRUE |

```
data <- TCGAanalyze_DMC(
    data = data,
    groupCol = "methylation_subtype",
    group1 = "CIMP.H",
    group2 = "CIMP.L",
    p.cut = 10^-5,
    diffmean.cut = 0.25,
    legend = "State",
    plot.filename = "coad_CIMPHvsCIMPL_metvolcano.png"
)
```

The output will be a plot such as the figure below. The green dots are the probes that are hypomethylated in group 2 compared to group 1, while the red dots are the hypermethylated probes in group 2 compared to group 1

![](data:image/png;base64...)

Also, the `TCGAanalyze_DMR` function will save the plot as pdf and return the same SummarizedExperiment that was given as input with the values of p-value, p-value adjusted, diffmean and the group it belongs in the graph (non significant, hypomethylated, hypermethylated) in the rowRanges. The columns will be (where group1 and group2 are the names of the groups):

* diffmean.group1.group2 (mean.group2 - mean.group1)
* diffmean.group2.group1 (mean.group1 - mean.group2)
* p.value.group1.group2
* p.value.adj.group1.group2
* status.group1.group2 (Status of probes in group2 in relation to group1)
* status.group2.group1 (Status of probes in group1 in relation to group2)

This values can be view/acessed using the `rowRanges` acessesor (`rowRanges(data)`).

**Observation:** Calling the same function again, with the same arguments will only plot the results, as it was already calculated. If you want to have them recalculated, please set `overwrite` to `TRUE` or remove the calculated columns.

# `TCGAvisualize`: Visualize results from analysis functions with TCGA’s data.

You can easily visualize results from some following functions:

## `TCGAvisualize_Heatmap`: Create heatmaps with cluster bars

In order to have a better view of clusters, we normally use heatmaps. `TCGAvisualize_Heatmap` will plot a heatmap and add to each sample bars representing different features. This function is a wrapper to the package [ComplexHeatmap](http://bioconductor.org/packages/ComplexHeatmap/) package,

The arguments of this function are:

* **data** The object with the heatmap data (expression, methylation)
* **col.metadata** Metadata for the columns (patients). It should have the column bcr\_patient\_barcode or patient or ID with the patients barcodes.
* **row.metadata** Metadata for the rows genes (expression) or probes (methylation)
* **col.colors**  A list of names colors
* **row.colors**  A list of named colors
* **show\_column\_names**  Show column names names? Default: FALSE
* **show\_row\_names**  Show row names? Default: FALSE
* **cluster\_rows**  Cluster rows ? Default: FALSE
* **cluster\_columns** Cluster columns ? Default: FALSE
* **sortCol** Name of the column to be used to sort the columns
* **title** Title of the plot
* **type** Select the colors of the heatmap values. Possible values are “expression” (default), “methylation”
* **scale** Use z-score to make the heamat? If we want to show differences between genes, it is good to make Z-score by samples (force each sample to have zero mean and standard deviation=1). If we want to show differences between samples, it is good to make Z-score by genes (force each gene to have zero mean and standard deviation=1). Possibilities: “row”, “col. Default”none"

For more information please take a look on case study #2.

The result is shown below: ![](data:image/png;base64...)

## `TCGAvisualize_Volcano`: Create volcano plot

Creates a volcano plot for DNA methylation or expression

The arguments of this function are:

| Argument | Description |
| --- | --- |
| x | x-axis data |
| y | y-axis data |
| filename | Filename. Default: volcano.pdf, volcano.svg, volcano.png |
| ylab | y axis text |
| xlab | x axis text |
| title | main title. If not specified it will be "Volcano plot (group1 vs group2) |
| legend | Legend title |
| label | vector of labels to be used in the figure. Example: c(“Not Significant”,“Hypermethylated in group1”, “Hypomethylated in group1”))#’ |
| xlim | x limits to cut image |
| ylim | y limits to cut image |
| color | vector of colors to be used in graph |
| names | Names to be plotted if significant. Should be the same size of x and y |
| names.fill | Names should be filled in a color box? Default: TRUE |
| show.names | What names will be showd? Possibilities: “both”, “significant”, “highlighted” |
| x.cut | x-axis threshold. Default: 0.0 If you give only one number (e.g. 0.2) the cut-offs will be -0.2 and 0.2. Or you can give different cut-offs as a vector (e.g. c(-0.3,0.4)) |
| y.cut | p-values threshold. |
| height | Figure height |
| width | Figure width |
| highlight | List of genes/probes to be highlighted. It should be in the names argument. |
| highlight.color | Color of the points highlighted |
| names.size | Size of the names text |
| dpi | Figure dpi |
|  |  |
|  |  |
|  |  |
|  |  |

For more information please take a look on case study #3.

## `TCGAvisualize_PCA`: Principal Component Analysis plot for differentially expressed genes

In order to better understand our genes, we can perform a PCA to reduce the number of dimensions of our gene set. The function `TCGAvisualize_PCA` will plot the PCA for different groups.

The arguments of this function are:

* **dataFilt** The expression matrix after normalization and quantile filter
* **dataDEGsFiltLevel** The TCGAanalyze\_LevelTab output
* **ntopgenes** number of DEGs genes to plot in PCA
* \*\* group1 a string containing the barcode list of the samples in control group
* \*\* group2 a string containing the barcode list of the samples in disease group

```
# normalization of genes
dataNorm <- TCGAbiolinks::TCGAanalyze_Normalization(dataBRCA, geneInfo)

# quantile filter of genes
dataFilt <- TCGAanalyze_Filtering(
    tabDF = dataNorm,
    method = "quantile",
    qnt.cut =  0.25
)

# selection of normal samples "NT"
group1 <- TCGAquery_SampleTypes(colnames(dataFilt), typesample = c("NT"))
# selection of normal samples "TP"
group2 <- TCGAquery_SampleTypes(colnames(dataFilt), typesample = c("TP"))

# Principal Component Analysis plot for ntop selected DEGs
pca <- TCGAvisualize_PCA(
    dataFilt = dataFilt,
    dataDEGsFiltLevel = dataDEGsFiltLevel,
    ntopgenes = 200,
    group1 = group1,
    group2 =  group2
)
```

The result is shown below: ![](data:image/png;base64...)

## `TCGAvisualize_meanMethylation`: Mean DNA Methylation Analysis

Using the data and calculating the mean DNA methylation per group, it is possible to create a mean DNA methylation boxplot with the function `TCGAvisualize_meanMethylation` as follows:

```
query <- GDCquery(
    project = "TCGA-GBM",
    data.category = "DNA methylation",
    platform = "Illumina Human Methylation 27",
    barcode = c(
        "TCGA-02-0058-01A-01D-0186-05", "TCGA-12-1597-01B-01D-0915-05",
        "TCGA-12-0829-01A-01D-0392-05", "TCGA-06-0155-01B-01D-0521-05",
        "TCGA-02-0099-01A-01D-0199-05", "TCGA-19-4068-01A-01D-1228-05",
        "TCGA-19-1788-01A-01D-0595-05", "TCGA-16-0848-01A-01D-0392-05"
    )
)
GDCdownload(query, method = "api")
data <- GDCprepare(query)
```

## `TCGAvisualize_starburst`: Integration of gene expression and DNA methylation data

The starburst plot is proposed to combine information from two volcano plots, and is applied for a study of DNA methylation and gene expression. It first introduced in 2010 (Noushmehr et al. 2010). In order to reproduce this plot, we will use the `TCGAvisualize_starburst` function.

The function creates Starburst plot for comparison of DNA methylation and gene expression. The log10 (FDR-corrected P value) for DNA methylation is plotted in the x axis, and for gene expression in the y axis, for each gene. The black dashed line shows the FDR-adjusted P value of 0.01.

The arguments of this function are:

| Argument | Description |
| --- | --- |
| exp | Object obtained by DEArnaSEQ function |
| group1 | The name of the group 1 Obs: Column p.value.adj.group1.group2 should exist |
| group2 | The name of the group 2. Obs: Column p.value.adj.group1.group2 should exist |
| exp.p.cut | expression p value cut-off |
| met.p.cut | methylation p value cut-off |
| diffmean.cut | If set, the probes with diffmean higher than methylation cut-off will be highlighted in the plot. And the data frame return will be subseted. |
| logFC.cut | If set, the probes with expression fold change higher than methylation cut-off will be highlighted in the plot. And the data frame return will be subseted. |
| met.platform | DNA methylation platform (“27K”,“450K” or “EPIC”) |
| genome | Genome of reference (“hg38” or “hg19”) used to identify nearest probes TSS |
| names | Add the names of the significant genes? Default: FALSE |
| names.fill | Names should be filled in a color box? Default: TRUE |
| filename | The filename of the file (it can be pdf, svg, png, etc) |
| return.plot | If true only plot object will be returned (pdf will not be created) |
| ylab | y axis text |
| xlab | x axis text |
| title | main title |
| legend | legend title |
| color | vector of colors to be used in graph |
| label | vector of labels to be used in graph |
| xlim | x limits to cut image |
| ylim | y limits to cut image |
| height | Figure height |
| width | Figure width |
| dpi | Figure dpi |

```
starburst <- TCGAvisualize_starburst(
    met = coad.SummarizeExperiment,
    exp = different.experssion.analysis.data,
    group1 = "CIMP.H",
    group2 = "CIMP.L",
    met.platform = "450K",
    genome = "hg19",
    met.p.cut = 10^-5,
    exp.p.cut = 10^-5,
    names = TRUE
)
```

As a result, the function will a plot the figure below and return a matrix with the Gene\_symbol and it status in relation to expression (up regulated/down regulated) and to methylation (Hyper/Hypo methylated). The case study 3, shows the complete pipeline for creating this figure.

![](data:image/png;base64...)

# Session Information

---

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
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
## [1] grid      stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] jpeg_0.1-11                 png_0.1-8
##  [3] DT_0.34.0                   dplyr_1.1.4
##  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [9] IRanges_2.44.0              S4Vectors_0.48.0
## [11] BiocGenerics_0.56.0         generics_0.1.4
## [13] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [15] TCGAbiolinks_2.38.0         testthat_3.2.3
##
## loaded via a namespace (and not attached):
##  [1] DBI_1.2.3                   httr2_1.2.1
##  [3] remotes_2.5.0               biomaRt_2.66.0
##  [5] rlang_1.1.6                 magrittr_2.0.4
##  [7] otel_0.2.0                  compiler_4.5.1
##  [9] RSQLite_2.4.3               vctrs_0.6.5
## [11] rvest_1.0.5                 stringr_1.5.2
## [13] pkgconfig_2.0.3             crayon_1.5.3
## [15] fastmap_1.2.0               dbplyr_2.5.1
## [17] XVector_0.50.0              ellipsis_0.3.2
## [19] promises_1.4.0              rmarkdown_2.30
## [21] tzdb_0.5.0                  sessioninfo_1.2.3
## [23] ps_1.9.1                    purrr_1.1.0
## [25] bit_4.6.0                   xfun_0.54
## [27] cachem_1.1.0                jsonlite_2.0.0
## [29] progress_1.2.3              blob_1.2.4
## [31] later_1.4.4                 DelayedArray_0.36.0
## [33] prettyunits_1.2.0           R6_2.6.1
## [35] bslib_0.9.0                 stringi_1.8.7
## [37] RColorBrewer_1.1-3          pkgload_1.4.1
## [39] brio_1.1.5                  jquerylib_0.1.4
## [41] Rcpp_1.1.0                  knitr_1.50
## [43] usethis_3.2.1               downloader_0.4.1
## [45] R.utils_2.13.0              readr_2.1.5
## [47] Matrix_1.7-4                tidyselect_1.2.1
## [49] rstudioapi_0.17.1           dichromat_2.0-0.1
## [51] abind_1.4-8                 yaml_2.3.10
## [53] websocket_1.4.4             curl_7.0.0
## [55] processx_3.8.6              pkgbuild_1.4.8
## [57] lattice_0.22-7              tibble_3.3.0
## [59] plyr_1.8.9                  KEGGREST_1.50.0
## [61] S7_0.2.0                    evaluate_1.0.5
## [63] desc_1.4.3                  BiocFileCache_3.0.0
## [65] xml2_1.4.1                  Biostrings_2.78.0
## [67] pillar_1.11.1               filelock_1.0.3
## [69] rprojroot_2.1.1             chromote_0.5.1
## [71] hms_1.1.4                   ggplot2_4.0.0
## [73] scales_1.4.0                glue_1.8.0
## [75] tools_4.5.1                 data.table_1.17.8
## [77] fs_1.6.6                    XML_3.99-0.19
## [79] tidyr_1.3.1                 devtools_2.4.6
## [81] AnnotationDbi_1.72.0        cli_3.6.5
## [83] rappdirs_0.3.3              S4Arrays_1.10.0
## [85] gtable_0.3.6                R.methodsS3_1.8.2
## [87] TCGAbiolinksGUI.data_1.30.0 sass_0.4.10
## [89] digest_0.6.37               SparseArray_1.10.0
## [91] htmlwidgets_1.6.4           farver_2.1.2
## [93] memoise_2.0.1               htmltools_0.5.8.1
## [95] R.oo_1.27.1                 lifecycle_1.0.4
## [97] httr_1.4.7                  bit64_4.6.0-1
```

Noushmehr, Houtan, Daniel J Weisenberger, Kristin Diefes, Heidi S Phillips, Kanan Pujara, Benjamin P Berman, Fei Pan, et al. 2010. “Identification of a Cpg Island Methylator Phenotype That Defines a Distinct Subgroup of Glioma.” *Cancer Cell* 17 (5): 510–22.