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

# Case Studies

# Introduction

This vignette shows a complete workflow of the TCGAbiolinks package. The code is divided in 4 case study:

1. Expression pipeline (BRCA)
2. Expression pipeline (GBM)
3. Integration of DNA methylation and RNA expression pipeline (COAD)
4. ELMER pipeline (KIRC)

# Case study n. 1: Pan Cancer downstream analysis BRCA

```
library(SummarizedExperiment)
library(TCGAbiolinks)

query.exp <- GDCquery(
    project = "TCGA-BRCA",
    data.category = "Transcriptome Profiling",
    data.type = "Gene Expression Quantification",
    workflow.type = "STAR - Counts",
    sample.type = c("Primary Tumor","Solid Tissue Normal")
)
GDCdownload(
    query = query.exp,
    files.per.chunk = 100
)

brca.exp <- GDCprepare(
    query = query.exp,
    save = TRUE,
    save.filename = "brcaExp.rda"
)

# get subtype information
infomation.subtype <- TCGAquery_subtype(tumor = "BRCA")

# get clinical data
information.clinical <- GDCquery_clinic(project = "TCGA-BRCA",type = "clinical")

# Which samples are Primary Tumor
samples.primary.tumour <- brca.exp$barcode[brca.exp$shortLetterCode == "TP"]

# which samples are solid tissue normal
samples.solid.tissue.normal <- brca.exp$barcode[brca.exp$shortLetterCode == "NT"]
```

Using `TCGAnalyze_DEA`, we identified 4,815 differentially expression genes (DEG) (log fold change >=1 and FDR < 1%) between 113 normal and 1106 BRCA samples. In order to understand the underlying biological process from DEGs we performed an enrichment analysis using `TCGAnalyze_EA_complete` function.

```
dataPrep <- TCGAanalyze_Preprocessing(
    object = brca.exp,
    cor.cut = 0.6
)

dataNorm <- TCGAanalyze_Normalization(
    tabDF = dataPrep,
    geneInfo = geneInfoHT,
    method = "gcContent"
)

dataFilt <- TCGAanalyze_Filtering(
    tabDF = dataNorm,
    method = "quantile",
    qnt.cut =  0.25
)

dataDEGs <- TCGAanalyze_DEA(
    mat1 = dataFilt[,samples.solid.tissue.normal],
    mat2 = dataFilt[,samples.primary.tumour],
    Cond1type = "Normal",
    Cond2type = "Tumor",
    fdr.cut = 0.01 ,
    logFC.cut = 2,
    method = "glmLRT",
    pipeline = "edgeR"
)
```

TCGAbiolinks outputs bar chart with the number of genes for the main categories of three ontologies (GO:biological process, GO:cellular component, and GO:molecular function, respectively).

```
ansEA <- TCGAanalyze_EAcomplete(
    TFname = "DEA genes Normal Vs Tumor",
    RegulonList = dataDEGs$gene_name
)

TCGAvisualize_EAbarplot(
    tf = rownames(ansEA$ResBP),
    GOBPTab = ansEA$ResBP,
    GOCCTab = ansEA$ResCC,
    GOMFTab = ansEA$ResMF,
    PathTab = ansEA$ResPat,
    nRGTab = dataDEGs$gene_name,
    nBar = 10
)
```

The figure resulted from the code above is shown below. ![](data:image/png;base64...)

The Kaplan-Meier analysis was used to compute survival univariate curves, and
log-Ratio test was computed to assess the statistical significance by using TCGAanalyze\_SurvivalKM function; starting with 3,390 DEGs genes we found 555 significantly genes with p.value <0.05.

```
group1 <- TCGAquery_SampleTypes(colnames(dataFilt), typesample = c("NT"))
group2 <- TCGAquery_SampleTypes(colnames(dataFilt), typesample = c("TP"))

dataSurv <- TCGAanalyze_SurvivalKM(
    clinical_patient = dataClin,
    dataGE = dataFilt,
    Genelist = rownames(dataDEGs),
    Survresult = FALSE,
    ThreshTop = 0.67,
    ThreshDown = 0.33,
    p.cut = 0.05,
    group1 = group1,
    group2 = group2
)
```

Cox-regression analysis was used to compute survival multivariate curves, and cox p-value was computed to assess the statistical significance by using TCGAnalyze\_SurvivalCoxNET function. Survival multivariate analysis found 160 significantly genes according to the cox p-value FDR 5.00e-02. From DEGs that we found to correlate significantly with survival by both univariate and multivariate analyses we analyzed the following network.

The interactome network graph was generated using STRING.,org.Hs.string version 10 (Human functional protein association network). The network graph was resized by dnet package considering only multivariate survival genes, with strong interaction (threshold = 700) we obtained a subgraphsub graph of 24 nodes and 31 edges.

```
require(dnet)  # to change
org.Hs.string <- dRDataLoader(RData = "org.Hs.string")

TabCoxNet <- TCGAvisualize_SurvivalCoxNET(
    dataClin,
    dataFilt,
    Genelist = rownames(dataSurv),
    scoreConfidence = 700,
    org.Hs.string = org.Hs.string,
    titlePlot = "Case Study n.1 dnet"
)
```

The figure resulted from the code above is shown below. ![](data:image/png;base64...)

# Case study n. 2: Pan Cancer downstream analysis LGG

We focused on the analysis of LGG samples. In particular, we used TCGAbiolinks to download 293 samples with molecular subtypes. Link the complete [complete code](https://gist.github.com/tiagochst/277651ebed998fd3d1952d3fbc376ef2). .

```
library(TCGAbiolinks)
library(SummarizedExperiment)

query.exp <- GDCquery(
    project = "TCGA-LGG",
    data.category = "Transcriptome Profiling",
    data.type = "Gene Expression Quantification",
    workflow.type = "STAR - Counts",
    sample.type = c("Primary Tumor")
)

GDCdownload(query.exp)

lgg.exp <- GDCprepare(
    query = query.exp,
    save = FALSE
)
```

First, we searched for possible outliers using the `TCGAanalyze_Preprocessing` function, which performs an Array Array Intensity correlation AAIC. We used all samples in expression data which contain molecular subtypes, filtering out samples without molecular information, and using only IDHmut-codel (n=85), IDHmut-non-codel (n=141) and IDHwt (n=56), NA (11), to define a square symmetric matrix of pearson correlation among all samples (n=293). According to this matrix we found no samples with low correlation (cor.cut = 0.6) that can be identified as possible outliers, so we continued our analysis with 70 samples.

Second, using the `TCGAanalyze_Normalization` function we normalized mRNA transcripts and miRNA, using EDASeq package. This function does use Within-lane normalization procedures to adjust for GC-content effect (or other gene-level effects) on read counts: loess robust local regression, global-scaling, and full-quantile normalization (Risso et al. 2011) and between-lane normalization procedures to adjust for distributional differences between lanes (e.g., sequencing depth): global-scaling and full-quantile normalization (Bullard et al. 2010).

Third, using the `TCGAanalyze_Filtering` function we applied 3 filters removing features / mRNAs with low signal across samples obtaining 4578, 4284, 1187 mRNAs respectively.

Then we applied two Hierarchical cluster analysis on 1187 mRNAs after the three filters described above, the first cluster using as method ward.D2, and the second with ConsensusClusterPlus.

After the two clustering analysis, with cut.tree = 4 we obtained n= 4 expression clusters (EC).

```
library(dplyr)

dataPrep <- TCGAanalyze_Preprocessing(
    object = lgg.exp,
    cor.cut = 0.6
)
dataNorm <- TCGAanalyze_Normalization(
    tabDF = dataPrep,
    geneInfo = geneInfoHT,
    method = "gcContent"
)

datFilt <- dataNorm %>%
    TCGAanalyze_Filtering(method = "varFilter") %>%
    TCGAanalyze_Filtering(method = "filter1") %>%
    TCGAanalyze_Filtering(method = "filter2",foldChange = 1)

data_Hc2 <- TCGAanalyze_Clustering(
    tabDF = datFilt,
    method = "consensus",
    methodHC = "ward.D2"
)
# Add  cluster information to Summarized Experiment
colData(lgg.exp)$groupsHC <- paste0("EC",data_Hc2[[4]]$consensusClass)
```

The next steps will be to visualize the data. First, we created the survival plot.

```
TCGAanalyze_survival(
    data = colData(lgg.exp),
    clusterCol = "groupsHC",
    main = "TCGA kaplan meier survival plot from consensus cluster",
    legend = "RNA Group",
    height = 10,
    risk.table = T,
    conf.int = F,
    color = c("black","red","blue","green3"),
    filename = "survival_lgg_expression_subtypes.png"
)
```

The result is showed below: ![](data:image/png;base64...)

We will also, create a heatmap of the expression.

```
TCGAvisualize_Heatmap(
    data = t(datFilt),
    col.metadata =  colData(lgg.exp)[,
                                     c("barcode",
                                       "groupsHC",
                                       "paper_Histology",
                                       "paper_IDH.codel.subtype")
    ],
    col.colors =  list(
        groupsHC = c(
            "EC1"="black",
            "EC2"="red",
            "EC3"="blue",
            "EC4"="green3")
    ),
    sortCol = "groupsHC",
    type = "expression", # sets default color
    scale = "row", # use z-scores for better visualization. Center gene expression level around 0.
    title = "Heatmap from concensus cluster",
    filename = "case2_Heatmap.png",
    extremes = seq(-2,2,1),
    color.levels = colorRampPalette(c("green", "black", "red"))(n = 5),
    cluster_rows = TRUE,
    cluster_columns = FALSE,
    width = 1000,
    height = 500
)
```

The result is shown below:

![](data:image/png;base64...)

Finally, we will take a look in the mutation genes. We will first download the MAF file with `GDCquery`,`GDCdownload` and `GDCprepare`. In this example we will investigate the gene “ATR”.

```
library(maftools)
library(dplyr)
query <- GDCquery(
    project = "TCGA-LGG",
    data.category = "Simple Nucleotide Variation",
    access = "open",
    data.type = "Masked Somatic Mutation",
    workflow.type = "Aliquot Ensemble Somatic Variant Merging and Masking"
)
GDCdownload(query)
LGGmut <- GDCprepare(query)
# Selecting gene
LGGmut.atr <- LGGmut %>% dplyr::filter(Hugo_Symbol == "ATR")

dataMut <- LGGmut.atr[!duplicated(LGGmut.atr$Tumor_Sample_Barcode),]
dataMut$Tumor_Sample_Barcode <- substr(dataMut$Tumor_Sample_Barcode,1,12)

# Adding the Expression Cluster classification found before
dataMut <- merge(dataMut, cluster, by.y = "patient", by.x = "Tumor_Sample_Barcode")
```

# Case study n. 3: Integration of methylation and expression for ACC

In recent years, it has been described the relationship between DNA methylation and gene expression and the study of this relationship is often difficult to accomplish.

This case study will show the steps to investigate the relationship between the two types of data.

First, we downloaded ACC DNA methylation data for HumanMethylation450k platforms, and ACC RNA expression data for Illumina HiSeq platform.

TCGAbiolinks adds by default the subtypes classification already published by researchers.

We will use this classification to do our examples. So, selected the groups CIMP-low and CIMP-high to do RNA expression and DNA methylation comparison.

```
library(TCGAbiolinks)
library(SummarizedExperiment)

#-----------------------------------
# STEP 1: Search, download, prepare |
#-----------------------------------
# 1.1 - DNA methylation
# ----------------------------------
query.met <- GDCquery(
    project = "TCGA-ACC",
    data.category = "DNA Methylation",
    data.type = "Methylation Beta Value",
    platform = "Illumina Human Methylation 450"
)

GDCdownload(
    query = query.met,
    files.per.chunk = 20,
    directory = "case3/GDCdata"
)

acc.met <- GDCprepare(
    query = query.met,
    save = FALSE,
    directory = "case3/GDCdata"
)

#-----------------------------------
# 1.2 - RNA expression
# ----------------------------------
query.exp <- GDCquery(
    project = "TCGA-ACC",
    data.category = "Transcriptome Profiling",
    data.type = "Gene Expression Quantification",
    workflow.type = "STAR - Counts"
)

GDCdownload(
    query = query.exp,
    files.per.chunk = 20,
    directory = "case3/GDCdata"
)

acc.exp <- GDCprepare(
    query = query.exp,
    save = FALSE,
    directory = "case3/GDCdata"
)
```

For DNA methylation, we perform a DMC (different methylated CpGs) analysis, which will give the difference of DNA methylation for the probes of the groups and their significance value. The output can be seen in a volcano plot. Note: Depending on the number of samples this function can be very slow due to the wilcoxon test, taking from hours to days.

```
# na.omit
acc.met <- acc.met[rowSums(is.na(assay(acc.met))) == 0,]

# Volcano plot
acc.met <- TCGAanalyze_DMC(
    data = acc.met,
    groupCol = "subtype_MethyLevel",
    group1 = "CIMP-high",
    group2="CIMP-low",
    p.cut = 10^-5,
    diffmean.cut = 0.25,
    legend = "State",
    plot.filename = "case3/CIMP-highvsCIMP-low_metvolcano.png"
)
```

The figure resulted from the code above is shown below: ![](data:image/png;base64...)

For the expression analysis, we do a DEA (differential expression analysis) which will give the fold change of gene expression and their significance value.

```
#-------------------------------------------------
# 2.3 - DEA - Expression analysis - volcano plot
# ------------------------------------------------
acc.exp.aux <- subset(
    acc.exp,
    select = colData(acc.exp)$subtype_MethyLevel %in% c("CIMP-high","CIMP-low")
)

idx <- colData(acc.exp.aux)$subtype_MethyLevel %in% c("CIMP-high")
idx2 <- colData(acc.exp.aux)$subtype_MethyLevel %in% c("CIMP-low")

dataPrep <- TCGAanalyze_Preprocessing(
    object = acc.exp.aux,
    cor.cut = 0.6
)

dataNorm <- TCGAanalyze_Normalization(
    tabDF = dataPrep,
    geneInfo = geneInfoHT,
    method = "gcContent"
)

dataFilt <- TCGAanalyze_Filtering(
    tabDF = dataNorm,
    qnt.cut = 0.25,
    method = 'quantile'
)

dataDEGs <- TCGAanalyze_DEA(
    mat1 = dataFilt[,idx],
    mat2 = dataFilt[,idx2],
    Cond1type = "CIMP-high",
    Cond2type = "CIMP-low",
    method = "glmLRT"
)

TCGAVisualize_volcano(
    x = dataDEGs$logFC,
    y = dataDEGs$FDR,
    filename = "case3/Case3_volcanoexp.png",
    x.cut = 3,
    y.cut = 10^-5,
    names = rownames(dataDEGs),
    color = c("black","red","darkgreen"),
    names.size = 2,
    xlab = " Gene expression fold change (Log2)",
    legend = "State",
    title = "Volcano plot (CIMP-high vs CIMP-low)",
    width = 10
)
```

The figure resulted from the code above is shown below: ![](data:image/png;base64...)

Finally, using both previous analysis we do a starburst plot to select the genes that are Candidate Biologically Significant.

Observation: over the time, the number of samples has increased and the clinical data updated. We used only the samples that had a classification in the examples.

```
#------------------------------------------
# 2.4 - Starburst plot
# -----------------------------------------
# If true the argument names of the genes in circle
# (biologically significant genes, has a change in gene
# expression and DNA methylation and respects all the thresholds)
# will be shown
# these genes are returned by the function see starburst object after the function is executed
starburst <- TCGAvisualize_starburst(
    met = acc.met,
    exp = dataDEGs,
    genome = "hg19"
    group1 = "CIMP-high",
    group2 = "CIMP-low",
    filename = "case3/starburst.png",
    met.platform = "450K",
    met.p.cut = 10^-5,
    exp.p.cut = 10^-5,
    diffmean.cut = 0.25,
    logFC.cut = 3,
    names = FALSE,
    height = 10,
    width = 15,
    dpi = 300
)
```

The figure resulted from the code above is shown below: ![](data:image/png;base64...)

# Case study n. 4: ELMER pipeline - KIRC

An example of package to perform DNA methylation and RNA expression analysis is ELMER (L. Yao et al. 2015, @elmer2, @yao2015demystifying). ELMER, which is designed to combine DNA methylation and gene expression data from human tissues to infer multi-level cis-regulatory networks. ELMER uses DNA methylation to identify distal probes, and correlates them with the expression of nearby genes to identify one or more transcriptional targets. Transcription factor (TF) binding site analysis of those anti-correlated distal probes is coupled with expression analysis of all TFs to infer upstream regulators. This package can be easily applied to TCGA public available cancer data sets and custom DNA methylation and gene expression data sets.

ELMER analyses have the following steps:

1. Organize data as a *MultiAssayExperiment* object
2. Identify distal probes with significantly different DNA methylation level when comparing two sample groups.
3. Identify putative target genes for differentially methylated distal probes, using methylation vs. expression correlation
4. Identify enriched motifs for each probe belonging to a significant probe-gene pair
5. Identify master regulatory Transcription Factors (TF) whose expression associate with DNA methylation changes at multiple regulatory regions.

We will present this the study KIRC by TCGAbiolinks and ELMER integration.

ELMER package

For more information, please consult the ELMER package:

* <http://bioconductor.org/packages/ELMER/>

And the following articles:

* <http://www.biorxiv.org/content/early/2017/06/11/148726.full.pdf>
* <https://www.ncbi.nlm.nih.gov/pubmed/26446758>
* <https://genomebiology.biomedcentral.com/articles/10.1186/s13059-015-0668-3>

For the DNA methylation data we will search the platform HumanMethylation450. After, we will download the data and prepared into a *SummarizedExperiment* object.

```
library(TCGAbiolinks)
library(SummarizedExperiment)
library(ELMER)
library(parallel)
dir.create("case4")
setwd("case4")
#-----------------------------------
# STEP 1: Search, download, prepare |
#-----------------------------------
# 1.1 - DNA methylation
# ----------------------------------
query.met <- GDCquery(
    project = "TCGA-KIRC",
    data.category = "DNA Methylation",
    data.type = "Methylation Beta Value",
    platform = "Illumina Human Methylation 450"
)
GDCdownload(query.met)
kirc.met <- GDCprepare(
    query = query.met,
    save = TRUE,
    save.filename = "kircDNAmet.rda",
    summarizedExperiment = TRUE
)
```

For gene expression we will use Gene Expression Quantification.

```
# Step 1.2 download expression data
#-----------------------------------
# 1.2 - RNA expression
# ----------------------------------
query.exp <- GDCquery(
    project = "TCGA-KIRC",
    data.category = "Transcriptome Profiling",
    data.type = "Gene Expression Quantification",
    workflow.type = "STAR - Counts"
)
GDCdownload(query.exp,files.per.chunk = 20)
kirc.exp <- GDCprepare(
    query = query.exp,
    save = TRUE,
    save.filename = "kircExp.rda"
)
```

A MultiAssayExperiment object from the r BiocStyle::Biocpkg(“MultiAssayExperiment”) package is the input for multiple main functions of r BiocStyle::Biocpkg(“ELMER”).

We will first need to get distal probes (2 KB away from TSS).

```
distal.probes <- get.feature.probe(genome = "hg38", met.platform = "450K")
```

To create it you can use the **createMAE** function. This function will keep only samples that have both DNA methylation and gene expression.

```
library(MultiAssayExperiment)
mae <- createMAE(
    exp = kirc.exp,
    met = kirc.met,
    save = FALSE,
    linearize.exp = TRUE,
    filter.probes = distal.probes,
    save.filename = "mae_kirc.rda",
    met.platform = "450K",
    genome = "hg38",
    TCGA = TRUE
)
# Remove FFPE samples
mae <- mae[,!mae$is_ffpe]
```

We will execute ELMER to identify probes that are hypomethylated in tumor samples compared to the normal samples.

```
group.col <- "definition"
group1 <-  "Primary Tumor"
group2 <- "Solid Tissue Normal"
direction <- "hypo"
dir.out <- file.path("kirc",direction)
dir.create(dir.out, recursive = TRUE)
#--------------------------------------
# STEP 3: Analysis                     |
#--------------------------------------
# Step 3.1: Get diff methylated probes |
#--------------------------------------
sig.diff <- get.diff.meth(
    data = mae,
    group.col = group.col,
    group1 =  group1,
    group2 = group2,
    minSubgroupFrac = 0.2,
    sig.dif = 0.3,
    diff.dir = direction, # Search for hypomethylated probes in group 1
    cores = 1,
    dir.out = dir.out,
    pvalue = 0.01
)

#-------------------------------------------------------------
# Step 3.2: Identify significant probe-gene pairs            |
#-------------------------------------------------------------
# Collect nearby 20 genes for Sig.probes
nearGenes <- GetNearGenes(
    data = mae,
    probes = sig.diff$probe,
    numFlankingGenes = 20, # 10 upstream and 10 dowstream genes
    cores = 1
)

pair <- get.pair(
    data = mae,
    group.col = group.col,
    group1 =  group1,
    group2 = group2,
    nearGenes = nearGenes,
    minSubgroupFrac = 0.4, # % of samples to use in to create groups U/M
    permu.dir = file.path(dir.out,"permu"),
    permu.size = 100, # Please set to 100000 to get significant results
    raw.pvalue  = 0.05,
    Pe = 0.01, # Please set to 0.001 to get significant results
    filter.probes = TRUE, # See preAssociationProbeFiltering function
    filter.percentage = 0.05,
    filter.portion = 0.3,
    dir.out = dir.out,
    cores = 1,
    label = direction
)

# Identify enriched motif for significantly hypomethylated probes which
# have putative target genes.
enriched.motif <- get.enriched.motif(
    data = mae,
    probes = pair$Probe,
    dir.out = dir.out,
    label = direction,
    min.incidence = 10,
    lower.OR = 1.1
)

TF <- get.TFs(
    data = mae,
    group.col = group.col,
    group1 =  group1,
    group2 = group2,
    minSubgroupFrac = 0.4,
    enriched.motif = enriched.motif,
    dir.out = dir.out,
    cores = 1,
    label = direction
)
```

From this analysis it is possible to verify the relationship between nearby 20 gene expression vs DNA methylation at this probe. The result of this is show by the ELMER scatter plot.

```
scatter.plot(
    data = mae,
    byProbe = list(probe = sig.diff$probe[1], numFlankingGenes = 20),
    category = "definition",
    dir.out = "plots",
    lm = TRUE, # Draw linear regression curve
    save = TRUE
)
```

The result is shown below: ![](data:image/png;base64...)

Each scatter plot showing the average DNA methylation level of sites with the UA6 motif in all KIRC samples plotted against the expression of the transcription factor ZNF677 and PEG3 respectively.

```
scatter.plot(
    data = mae,
    byTF = list(
        TF = c("RUNX1","RUNX2","RUNX3"),
        probe = enriched.motif[[names(enriched.motif)[10]]]
    ),
    category = "definition",
    dir.out = "plots",
    save = TRUE,
    lm_line = TRUE
)
```

The result is shown below: ![](data:image/png;base64...)

You cen see the anticorrelated pairs of gene and probes by drawing a heatmap.

```
heatmapPairs(
    data = mae,
    group.col = "definition",
    group1 = "Primary Tumor",
    annotation.col = c("gender"),
    group2 = "Solid Tissue Normal",
    pairs = pair,
    filename =  "heatmap.pdf"
)
```

The result is shown below: ![](data:image/png;base64...)

The plot shows the odds ratio (x axis) for the selected motifs with lower boundary of OR above 1.8. The range shows the 95% confidence interval for each Odds Ratio.

![](data:image/png;base64...)

---

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
## [19] fontawesome_0.5.3           promises_1.4.0
## [21] rmarkdown_2.30              tzdb_0.5.0
## [23] sessioninfo_1.2.3           ps_1.9.1
## [25] purrr_1.1.0                 bit_4.6.0
## [27] xfun_0.54                   cachem_1.1.0
## [29] jsonlite_2.0.0              progress_1.2.3
## [31] blob_1.2.4                  later_1.4.4
## [33] DelayedArray_0.36.0         prettyunits_1.2.0
## [35] R6_2.6.1                    bslib_0.9.0
## [37] stringi_1.8.7               RColorBrewer_1.1-3
## [39] pkgload_1.4.1               brio_1.1.5
## [41] jquerylib_0.1.4             Rcpp_1.1.0
## [43] knitr_1.50                  usethis_3.2.1
## [45] downloader_0.4.1            R.utils_2.13.0
## [47] readr_2.1.5                 Matrix_1.7-4
## [49] tidyselect_1.2.1            rstudioapi_0.17.1
## [51] dichromat_2.0-0.1           abind_1.4-8
## [53] yaml_2.3.10                 websocket_1.4.4
## [55] curl_7.0.0                  processx_3.8.6
## [57] pkgbuild_1.4.8              lattice_0.22-7
## [59] tibble_3.3.0                plyr_1.8.9
## [61] KEGGREST_1.50.0             S7_0.2.0
## [63] evaluate_1.0.5              desc_1.4.3
## [65] BiocFileCache_3.0.0         xml2_1.4.1
## [67] Biostrings_2.78.0           pillar_1.11.1
## [69] filelock_1.0.3              rprojroot_2.1.1
## [71] chromote_0.5.1              hms_1.1.4
## [73] ggplot2_4.0.0               scales_1.4.0
## [75] glue_1.8.0                  tools_4.5.1
## [77] data.table_1.17.8           fs_1.6.6
## [79] XML_3.99-0.19               tidyr_1.3.1
## [81] devtools_2.4.6              AnnotationDbi_1.72.0
## [83] cli_3.6.5                   rappdirs_0.3.3
## [85] S4Arrays_1.10.0             gtable_0.3.6
## [87] R.methodsS3_1.8.2           TCGAbiolinksGUI.data_1.30.0
## [89] sass_0.4.10                 digest_0.6.37
## [91] SparseArray_1.10.0          htmlwidgets_1.6.4
## [93] farver_2.1.2                memoise_2.0.1
## [95] htmltools_0.5.8.1           R.oo_1.27.1
## [97] lifecycle_1.0.4             httr_1.4.7
## [99] bit64_4.6.0-1
```

# References

Bullard, James H, Elizabeth Purdom, Kasper D Hansen, and Sandrine Dudoit. 2010. “Evaluation of Statistical Methods for Normalization and Differential Expression in mRNA-Seq Experiments.” *BMC Bioinformatics* 11 (1): 94.

Risso, Davide, Katja Schwartz, Gavin Sherlock, and Sandrine Dudoit. 2011. “GC-Content Normalization for Rna-Seq Data.” *BMC Bioinformatics* 12 (1): 480.

Silva, Tiago C, Simon G Coetzee, Nicole Gull, Lijing Yao, Dennis J Hazelett, Houtan Noushmehr, De-Chen Lin, and Benjamin P Berman. 2018. “ELMER V.2: An R/Bioconductor Package to Reconstruct Gene Regulatory Networks from Dna Methylation and Transcriptome Profiles.” *Bioinformatics*, bty902. <https://doi.org/10.1093/bioinformatics/bty902>.

Yao, Lijing, Benjamin P Berman, and Peggy J Farnham. 2015. “Demystifying the Secret Mission of Enhancers: Linking Distal Regulatory Elements to Target Genes.” *Critical Reviews in Biochemistry and Molecular Biology* 50 (6): 550–73.

Yao, L, H Shen, PW Laird, PJ Farnham, and BP Berman. 2015. “Inferring Regulatory Element Landscapes and Transcription Factor Networks from Cancer Methylomes.” *Genome Biology* 16 (1): 105–5.