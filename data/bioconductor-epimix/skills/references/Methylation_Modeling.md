# EpiMix

### A comprehensive tool for the population-level analysis of DNA methylation

#### Yuanning Zheng, John Jun, Kevin Brennan and Olivier Gevaert Stanford Center for Biomedical Informatics Research (BIMR) Department of Medicine 1265 Welch Road Stanford CA, 94305-5479

#### 2025-10-29

## 1. Introduction

EpiMix is a comprehensive tool for the integrative analysis of DNA methylation data and gene expression data (**Figure 1**). EpiMix enables automated data downloading (from TCGA or GEO), pre-processing, methylation modeling, interactive visualization and functional annotation. To identify hypo- or hypermethylated genes, EpiMix uses a beta mixture model to identify the methylation states of each CpG site and compares the DNA methylation of an experimental group to a control group. The output from EpiMix is the functional changes in DNA methylation that is associated with gene expression.

EpiMix incorporates specialized algorithms to identify functional DNA methylation at various genetic elements, including proximal cis-regulatory elements within or surrounding protein-coding genes, distal enhancers, and genes encoding microRNAs (miRNAs) or lncRNAs. There are four alternative analytic modes for modeling DNA methylation at different genetic elements:

* **Regular**: cis-regulatory elements within or surrounding protein-coding genes.
* **Enhancer**: distal enhancers.
* **miRNA**: miRNA-coding genes.
* **lncRNA**: lncRNA-coding genes.

![Figure 1. Overview of EpiMix’s workflow. EpiMix incorporates four functional modules: downloading, preprocessing, methylation modeling and functional analysis. The methylation modeling module enables four alternative analytic modes, including “Regular”, “Enhancer”, “miRNA” and “lncRNA”. These analytic modes target DNA methylation analysis on different genetic elements.](data:image/png;base64...)

## 2. Installation

### 2.1 Bioconductor

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install(version='devel')

BiocManager::install("EpiMix")
```

### 2.2 Github

```
devtools::install_github("gevaertlab/EpiMix.data")
devtools::install_github("gevaertlab/EpiMix")
```

To **load** the EpiMix package in your R session, type `library(EpiMix)`

**Help files**. Detailed information on each function of the EpiMix package can be obtained in the help files. For example, to view the help file for the function *EpiMix*, use `?EpiMix`.

## 3. Data input

The `EpiMix` function requires three data matricies as input:

* **DNA methylation data**: a `matrix` of the DNA methylation data (beta values) with CpG sites in rows and samples in columns.

```
data(MET.data)
```

|  | TCGA-05-4384-01 | TCGA-05-4390-01 | TCGA-05-4396-01 | TCGA-05-4405-01 | TCGA-05-4410-01 |
| --- | --- | --- | --- | --- | --- |
| cg14029001 | 0.5137112 | 0.7590496 | 0.7344551 | 0.3842839 | 0.7792050 |
| cg00374492 | 0.0819639 | 0.1277514 | 0.1730193 | 0.1037328 | 0.1079144 |
| cg21462428 | 0.1397001 | 0.5207123 | 0.0738277 | 0.4853540 | 0.3803233 |
| cg03987115 | 0.3346637 | 0.4516052 | 0.5916153 | 0.1713237 | 0.2410597 |
| cg19351701 | 0.2816598 | 0.4035316 | 0.4949594 | 0.2380439 | 0.2139926 |

* **(Optional) Gene expression data**: a `matrix` of the matched gene expression data with genes in rows and samples in columns. If gene expression data are not provided, no comparision for gene expression will be made beteween the differentially methylated groups. Gene expression data can be normalized values from any methods: TPM, RPKM, FPKM, etc.

```
data(mRNA.data)
```

|  | TCGA-05-4244-01 | TCGA-05-4249-01 | TCGA-05-4250-01 | TCGA-05-4382-01 | TCGA-05-4384-01 |
| --- | --- | --- | --- | --- | --- |
| CCND2 | 8.453134 | 9.740521 | 8.732788 | 10.00435 | 8.772762 |
| CCND3 | 10.891247 | 11.427828 | 10.853533 | 10.30242 | 11.863776 |
| HOXA9 | 1.481609 | 2.757258 | 1.992442 | 1.93693 | 2.096296 |
| MANBAL | 10.548016 | 10.548264 | 10.558500 | 10.18544 | 10.080922 |
| SRC | 11.182247 | 11.940123 | 11.198035 | 11.54182 | 10.154679 |

* **Sample annotation**: a `dataframe` that maps each sample in the DNA methylation data to a study group. Should contain two columns: the first column (named “primary”) indicating the sample names, and the second column (named “sample.type”) indicating which study group each sample belongs to (e.g.,“Cancer” vs. “Normal”, “Experiment” vs. “Control”).

```
data(LUAD.sample.annotation)
```

| primary | sample.type |
| --- | --- |
| TCGA-05-4384-01 | Cancer |
| TCGA-05-4390-01 | Cancer |
| TCGA-05-4396-01 | Cancer |
| TCGA-05-4405-01 | Cancer |
| TCGA-50-6592-11 | Normal |
| TCGA-50-6593-11 | Normal |
| TCGA-50-6594-11 | Normal |
| TCGA-73-4658-11 | Normal |
| TCGA-73-4676-11 | Normal |

## 4. Methylation modeling

### 4.1 Regular mode

```
# Specify the output directory
outputDirectory = tempdir()

# We compare the DNA methylation in cancer (group.1) to the normal (group.2) tissues
EpiMixResults_Regular <- EpiMix(methylation.data = MET.data,
                                 gene.expression.data = mRNA.data,
                                 sample.info = LUAD.sample.annotation,
                                 group.1 = "Cancer",
                                 group.2 = "Normal",
                                 met.platform = "HM450",
                                 OutputRoot =  outputDirectory)
```

One of the major outputs of EpiMix is a `$FunctionalPairs` matrix, indicating the differentially methylated CpG sites that are signficantly associated with gene expression:

```
datatable(EpiMixResults_Regular$FunctionalPairs[1:5, ],
          options = list(scrollX = TRUE,
                         autoWidth = TRUE,
                         keys = TRUE,
                         pageLength = 5,
                         rownames= FALSE,
                         digits = 3),
                         rownames = FALSE)
```

### 4.2 Enhancer mode

The Enhancer mode targets DNA methylation analysis on distal enhancers of protein-coding genes.

```
# First, we need to set the analytic mode to enhancer
mode <- "Enhancer"

# Since enhancers are cell or tissue-type specific, EpiMix needs
# to know the reference cell type or tissue to select proper enhancers.
# Available ids for tissue or cell types can be
# obtained from Figure 2 of the RoadmapEpigenomic
# paper: https://www.nature.com/articles/nature14248.
# Alternatively, they can also be retrieved from the
# built-in function `list.epigenomes()`.

roadmap.epigenome.ids = "E096"

# Specify the output directory
outputDirectory = tempdir()

# Third, run EpiMix
EpiMixResults_Enhancer <- EpiMix(methylation.data = MET.data,
                                gene.expression.data = mRNA.data,
                                mode = mode,
                                roadmap.epigenome.ids = roadmap.epigenome.ids,
                                sample.info = LUAD.sample.annotation,
                                group.1 = "Cancer",
                                group.2 = "Normal",
                                met.platform = "HM450",
                                OutputRoot =  outputDirectory)
```

```
datatable(EpiMixResults_Enhancer$FunctionalPairs[1:5, ],
          options = list(scrollX = TRUE,
                         autoWidth = TRUE,
                         keys = TRUE,
                         pageLength = 5,
                         rownames= FALSE,
                         digits = 3),
                         rownames = FALSE)
```

### 4.3 miRNA mode

The miRNA mode targets DNA methylation analysis on miRNA-coding genes.

```
# Note that running the methylation analysis for miRNA genes need gene expression data for miRNAs
data(microRNA.data)

mode <- "miRNA"

# Specify the output directory
outputDirectory = tempdir()

EpiMixResults_miRNA <- EpiMix(methylation.data = MET.data,
                        gene.expression.data = microRNA.data,
                        mode = mode,
                        sample.info = LUAD.sample.annotation,
                        group.1 = "Cancer",
                        group.2 = "Normal",
                        met.platform = "HM450",
                        OutputRoot = outputDirectory)
```

```
# View the EpiMix results
datatable(EpiMixResults_miRNA$FunctionalPairs[1:5, ],
          options = list(scrollX = TRUE,
                         autoWidth = TRUE,
                         keys = TRUE,
                         pageLength = 5,
                         rownames= FALSE,
                         digits = 3),
                         rownames = FALSE)
```

### 4.4 lncRNA mode

The lncRNA mode targets DNA methylation analysis on lncRNA-coding genes.

```
# Note: standard RNA-seq processing method can not detect sufficient amount of lncRNAs.
# To maximize the capture of lncRNA expression, please use the pipeline propoased
# in our previous study: PMID: 31808800

data(lncRNA.data)

mode <- "lncRNA"

# Specify the output directory
outputDirectory =  tempdir()

EpiMixResults_lncRNA <- EpiMix(methylation.data = MET.data,
                        gene.expression.data = lncRNA.data,
                        mode = mode,
                        sample.info = LUAD.sample.annotation,
                        group.1 = "Cancer",
                        group.2 = "Normal",
                        met.platform = "HM450",
                        OutputRoot = outputDirectory)
```

```
datatable(EpiMixResults_lncRNA$FunctionalPairs[1:5, ],
          options = list(scrollX = TRUE,
                         autoWidth = TRUE,
                         keys = TRUE,
                         pageLength = 5,
                         rownames= FALSE,
                         digits = 3),
                         rownames = FALSE)
```

## 5. One-step functions for TCGA data

EpiMix enables automated DNA methylation analysis for cancer data from the TCGA project with a single-function `TCGA_GetData`. This function wraps the functions for (1) data downloading, (2) pre-processing and (3) DNA methylation analysis. By default, EpiMix compares the DNA methylation in tumors to normal tissues.

```
# Set up the TCGA cancer site. "OV" stands for ovarian cancer.
CancerSite <- "OV"

# Specify the analytic mode.
mode <- "Regular"

# Set the file path for saving the output.
outputDirectory <- tempdir()

# Only required if mode == "Enhancer".
roadmap.epigenome.ids = "E097"

# Run EpiMix

# We highly encourage to use multiple (>=10) CPU cores to
# speed up the computational process for large datasets

EpiMixResults <- TCGA_GetData(CancerSite = CancerSite,
                              mode = mode,
                              roadmap.epigenome.ids = roadmap.epigenome.ids,
                              outputDirectory = outputDirectory,
                              cores = 10)
```

## 6. Step-by-step functions for TCGA data

The above one-step functions in Section can be executed in a step-by-step manner in case users want to inspect the output from each individual step.

### 6.1 Download and preprocess DNA methylation data from TCGA

* Download DNA methylation data

```
METdirectories <- TCGA_Download_DNAmethylation(CancerSite = "OV",
                                               TargetDirectory = outputDirectory)
```

```
cat("HM27k directory:", METdirectories$METdirectory27k, "\n")
#> HM27k directory: /tmp/RtmphHXuyZ/gdac_20160128/gdac.broadinstitute.org_OV.Merge_methylation__humanmethylation27__jhu_usc_edu__Level_3__within_bioassay_data_set_function__data.Level_3.2016012800.0.0/
cat("HM450k directory:", METdirectories$METdirectory450k, "\n")
#> HM450k directory: /tmp/RtmphHXuyZ/gdac_20160128/gdac.broadinstitute.org_OV.Merge_methylation__humanmethylation450__jhu_usc_edu__Level_3__within_bioassay_data_set_function__data.Level_3.2016012800.0.0/
```

* Preprocess DNA methylation data

Preprocessing includes eliminating samples and genes with too many missing values (default: 20%), imputing remaining missing values, removing single-nucleotide polymorphism (SNP) probes.

```
METProcessedData <- TCGA_Preprocess_DNAmethylation(CancerSite = "OV", METdirectories)
```

The pre-processed DNA methylation data is a matrix with CpG probes in rows and patient in columns. The values in the matrix represent beta values of DNA methylation:

```
knitr::kable(METProcessedData[1:5,1:5])
```

|  | TCGA-04-1331-01 | TCGA-04-1332-01 | TCGA-04-1335-01 | TCGA-04-1336-01 | TCGA-04-1337-01 |
| --- | --- | --- | --- | --- | --- |
| cg00000292 | 0.9221302 | 0.4648186 | 0.9042943 | 0.7567368 | 0.8791313 |
| cg00002426 | 0.1486593 | 0.0562675 | 0.2632028 | 0.2009483 | 0.0726626 |
| cg00003994 | 0.0293567 | 0.0344792 | 0.0552332 | 0.0840847 | 0.0209836 |
| cg00005847 | 0.8248150 | 0.4201426 | 0.6690116 | 0.7688814 | 0.7630715 |
| cg00007981 | 0.0177981 | 0.0122320 | 0.0410097 | 0.0276765 | 0.0110274 |

**Optional**. Since TCGA data were collected in technical batches, systematic differences may exist between technical batches. Users can optionally correct the batch effect using the`doBatchCorrection` parameter. EpiMix provides two alternative methods for batch effect correction: Seurat and Combat. The Seurat method ([PMID: 31178118](https://pubmed.ncbi.nlm.nih.gov/31178118/)) is much more time efficient compared to the Combat ([PMID: 16632515](https://pubmed.ncbi.nlm.nih.gov/16632515/)). If using the Combat method, users are encouraged to use multiple CPU cores by tuning the `cores` parameter.

### 6.2 Download and preprocess gene expression data

```
# If use the Regular or the Enhancer mode:
GEdirectories <- TCGA_Download_GeneExpression(CancerSite = "OV",
                                              TargetDirectory = outputDirectory)

# If use the miRNA mode, download miRNA expression data:
mode <- "miRNA"
GEdirectories <- TCGA_Download_GeneExpression(CancerSite = "OV",
                                              TargetDirectory = outputDirectory,
                                              mode = mode)

# If use the lncRNA mode, download lncRNA expression data:
mode <- "lncRNA"
GEdirectories <- TCGA_Download_GeneExpression(CancerSite = "OV",
                                              TargetDirectory = outputDirectory,
                                              mode = mode)
```

* Preprocess gene expression data

```
GEProcessedData <- TCGA_Preprocess_GeneExpression(CancerSite = "OV",
                                                  MAdirectories = GEdirectories,
                                                  mode = mode
                                                  )
```

The pre-processed gene expression data is a matrix with gene in rows and patients in columns.

**Example of gene expression data**:

|  | TCGA-04-1331-01 | TCGA-04-1332-01 | TCGA-04-1335-01 | TCGA-04-1336-01 | TCGA-04-1337-01 |
| --- | --- | --- | --- | --- | --- |
| ELMO2 | -0.6204167 | 0.184750 | -0.6716667 | -1.105500 | 0.7858333 |
| CREB3L1 | -0.0032500 | 1.008500 | 1.2210000 | -0.623000 | 1.1265000 |
| RPS11 | 0.5672500 | 0.967625 | -0.2337500 | 0.555375 | 0.6608750 |
| PNMA1 | 1.2940000 | 1.159000 | -0.8425000 | 0.476750 | 0.6160000 |
| MMP2 | -0.3280000 | 0.416500 | -1.1091667 | -1.716333 | 0.9626667 |

* Generate the sample annotation

To identify the hypo- or hyper-methylated genes, EpiMix compares the DNA methylation in tumors to normal tissues. Therefore, EpiMix needs to know which samples in the DNA methylation and gene expression data are tumors (group.1), and which are normal tissues (group.2). The `TCGA_GetSampleInfo` function can be used to generate a dataframe of sample information.

```
sample.info = TCGA_GetSampleInfo(METProcessedData = METProcessedData,
                                 CancerSite = "OV",
                                 TargetDirectory = outputDirectory)
```

The `sample.info` is a dataframe with two columns: the **primary** column indicates the sample identifiers and the **sample.type** column indicates which group each sample belongs to:

```
knitr::kable(sample.info[1:4,])
```

| primary | sample.type |
| --- | --- |
| TCGA-04-1331-01 | Cancer |
| TCGA-04-1332-01 | Cancer |
| TCGA-04-1335-01 | Cancer |
| TCGA-04-1336-01 | Cancer |

## 7. Visualization

EpiMix enables diverse types of visualization.

### 7.1 Mixture model and gene expression

```
data(Sample_EpiMixResults_Regular)

plots <- EpiMix_PlotModel(
                 EpiMixResults = Sample_EpiMixResults_Regular,
                 Probe = "cg14029001",
                 methylation.data = MET.data,
                 gene.expression.data = mRNA.data,
                 GeneName = "CCND3"
                 )
```

```
# Mixture model of the DNA methylation of the CCND3 gene at cg14029001
plots$MixtureModelPlot

# Violin plot of the gene expression levels of the CCND3 gene in different mixtures
plots$ViolinPlot

# Correlation between DNA methylation and gene expression of CCND3
plots$CorrelationPlot
```

![](data:image/png;base64...)![](data:image/png;base64...)![](data:image/png;base64...)

### 7.2 Genome-browser style visualization

#### 7.2.1 Integrative visualization of the chromatin state, DNA methylation, and transcript structure of a specific gene

```
library(karyoploteR)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(org.Hs.eg.db)
library(regioneR)

data(Sample_EpiMixResults_Regular)

gene.name = "CCND2"
met.platform = "HM450"

# Since the chromatin states are cell-type specific, we need to specify a reference cell or
# tissue type for plotting. Available cell or tissue type can be found in
# Figure 2 of the Roadmap Epigenomics paper (nature, PMID: 25693563):
# https://www.nature.com/articles/nature14248

roadmap.epigenome.id = "E096"

EpiMix_PlotGene(gene.name = gene.name,
                EpiMixResults = Sample_EpiMixResults_Regular,
                met.platform = met.platform,
                roadmap.epigenome.id = roadmap.epigenome.id
               )
```

![](data:image/png;base64...)

Integrative visualization of the chromatin state, DM values and the transcript structure of the *CCND2* gene. The differential methylation (DM) value represents the mean difference in beta values between the hypermethylated samples versus the normally methylated samples.

#### 7.2.2 Plot the chromatin state of a CpG site and the expression of its nearby genes

This plot is used for visualization of a differentially methylated enhancer. The genes shown in red are the genes whose transcription was negatively associated with the DNA methylation of an enhancer.

```
# The CpG site to plot
probe.name = "cg00374492"

# The number of adjacent genes to be plotted
# Warnings: setting the gene number to a high value (>20 genes) may blow the internal memory
numFlankingGenes = 10

# Set up the reference cell/tissue type
roadmap.epigenome.id = "E096"

# Generate the plot
EpiMix_PlotProbe(probe.name,
                 EpiMixResults = Sample_EpiMixResults_Regular,
                 met.platform = "HM450",
                 numFlankingGenes = numFlankingGenes,
                 roadmap.epigenome.id = roadmap.epigenome.id,
                 left.gene.margin = 10000,  # left graph margin in nucleotide base pairs
                 right.gene.margin = 10000  # right graph margin in nucleotide base pairs
                 )
```

![Integrative visualization of the chromatin state and the nearby genes of a differentially methylated CpG site.](data:image/png;base64...)

## 8. Pathway enrichment analysis

EpiMix integrates the `clusterProfiler` R package to perform the function enrichment analysis of the differentially methylated genes. Enrichment results can be visualized in both **tabular** format and in **graphic** format. See [this paper](https://pubmed.ncbi.nlm.nih.gov/34557778/) for more details.

### 8.1 Gene ontology (GO) analysis

```
library(clusterProfiler)
library(org.Hs.eg.db)

# We want to check the functions of both the hypo- and hypermethylated genes.
methylation.state = "all"

# Use the gene ontology for functional analysis.
enrich.method = "GO"

# Use the "biological process" subterm
selected.pathways = "BP"

# Perform enrichment analysis
enrich.results <- functionEnrich(EpiMixResults = Sample_EpiMixResults_Regular,
                                  methylation.state = methylation.state,
                                  enrich.method = enrich.method,
                                  ont = selected.pathways,
                                  simplify = TRUE,
                                  save.dir = ""
                                  )
```

```
knitr::kable(head(enrich.results), row.names = FALSE)
```

| ID | Description | GeneRatio | BgRatio | RichFactor | FoldEnrichment | zScore | pvalue | p.adjust | qvalue | geneID | Count |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| GO:1900087 | positive regulation of G1/S transition of mitotic cell cycle | 2/5 | 56/18860 | 0.0357143 | 134.71429 | 16.318407 | 0.0000861 | 0.0070106 | 0.0020578 | CCND2/CCND3 | 2 |
| GO:1902808 | positive regulation of cell cycle G1/S phase transition | 2/5 | 70/18860 | 0.0285714 | 107.77143 | 14.573764 | 0.0001348 | 0.0070106 | 0.0020578 | CCND2/CCND3 | 2 |
| GO:0048704 | embryonic skeletal system morphogenesis | 2/5 | 94/18860 | 0.0212766 | 80.25532 | 12.544044 | 0.0002434 | 0.0077839 | 0.0022848 | HOXA9/HOXB7 | 2 |
| GO:0048706 | embryonic skeletal system development | 2/5 | 136/18860 | 0.0147059 | 55.47059 | 10.381576 | 0.0005089 | 0.0077839 | 0.0022848 | HOXA9/HOXB7 | 2 |
| GO:0045931 | positive regulation of mitotic cell cycle | 2/5 | 138/18860 | 0.0144928 | 54.66667 | 10.303840 | 0.0005239 | 0.0077839 | 0.0022848 | CCND2/CCND3 | 2 |
| GO:0009952 | anterior/posterior pattern specification | 2/5 | 224/18860 | 0.0089286 | 33.67857 | 8.012016 | 0.0013716 | 0.0139012 | 0.0040803 | HOXA9/HOXB7 | 2 |

### 8.2 KEGG pathway enrichment analysis

```
enrich.results <- functionEnrich(EpiMixResults = Sample_EpiMixResults_Regular,
                                  methylation.state = "all",
                                  enrich.method = "KEGG",
                                  simplify = TRUE,
                                  save.dir = "")
```

```
knitr::kable(head(enrich.results), row.names = FALSE)
```

| category | subcategory | ID | Description | GeneRatio | BgRatio | RichFactor | FoldEnrichment | zScore | pvalue | p.adjust | qvalue | geneID | Count |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Cellular Processes | Cell growth and death | hsa04115 | p53 signaling pathway | 2/3 | 75/9497 | 0.0266667 | 84.41778 | 12.892112 | 0.0001837 | 0.0024933 | 0.0003937 | 894/896 | 2 |
| Human Diseases | Infectious disease: viral | hsa05162 | Measles | 2/3 | 139/9497 | 0.0143885 | 45.54916 | 9.405064 | 0.0006320 | 0.0024933 | 0.0003937 | 894/896 | 2 |
| Cellular Processes | Cell growth and death | hsa04218 | Cellular senescence | 2/3 | 157/9497 | 0.0127389 | 40.32696 | 8.832287 | 0.0008059 | 0.0024933 | 0.0003937 | 894/896 | 2 |
| Environmental Information Processing | Signal transduction | hsa04390 | Hippo signaling pathway | 2/3 | 157/9497 | 0.0127389 | 40.32696 | 8.832287 | 0.0008059 | 0.0024933 | 0.0003937 | 894/896 | 2 |
| Cellular Processes | Cell growth and death | hsa04110 | Cell cycle | 2/3 | 158/9497 | 0.0126582 | 40.07173 | 8.803338 | 0.0008161 | 0.0024933 | 0.0003937 | 894/896 | 2 |
| Environmental Information Processing | Signal transduction | hsa04630 | JAK-STAT signaling pathway | 2/3 | 168/9497 | 0.0119048 | 37.68651 | 8.528052 | 0.0009224 | 0.0024933 | 0.0003937 | 894/896 | 2 |

## 9. Biomarker identification

After the differentially methylated genes were identified, we look for the genes whose methylation states are associated with patient survival. For each differentially methylated CpG, we compare the survival of the abnormally methylated patients to the normally methylated patients. The `GetSurvivalProbe` function generates all the survival associated CpGs.

```
library(survival)

# We use a sample result from running the EpiMix's miRNA mode on the
# lung adenocarcinomas (LUAD) data from TCGA
data("Sample_EpiMixResults_miRNA")

# Set the TCGA cancer site.
CancerSite = "LUAD"

# Find survival-associated CpGs/genes
survival.CpGs <- GetSurvivalProbe (EpiMixResults = Sample_EpiMixResults_miRNA, TCGA_CancerSite = CancerSite)
```

```
knitr::kable(survival.CpGs, row.names = FALSE)
```

| Probe | Genes | State | HR | lower.Cl | higher.Cl | p.value | adjusted.p.value |
| --- | --- | --- | --- | --- | --- | --- | --- |
| cg00909706 | hsa-mir-34a | Hyper | 1.8164322924391 | 1.17176293780833 | 2.8157796825242 | 0.0067882646557248 | 0.0067883 |

Plot the Kaplan-Meier survival curve for the normally and the abnormally methylated patients.

```
library(survminer)

# Select the target CpG site whose methylation states will be evaluated
Probe = "cg00909706"

# If using data from TCGA, just input the cancer site
CancerSite = "LUAD"

EpiMix_PlotSurvival(EpiMixResults = Sample_EpiMixResults_miRNA,
                                     plot.probe = Probe,
                                     TCGA_CancerSite = CancerSite)
```

![Survival curve for patients showing different methylation states at the CpG cg00909706](data:image/png;base64...)

Survival curve for patients showing different methylation states at the CpG cg00909706

## 10. Find potential miRNA targets

Find miRNA targets whose transcription levels are associated with the differential methylation of miRNAs: 1. Hyper-methylation miRNA -> upregulation of targets 2. Hypo-methylation miRNA -> downregulation of targets

```
library(multiMiR)
library(miRBaseConverter)

miRNA_targets <- find_miRNA_targets(
 EpiMixResults = Sample_EpiMixResults_miRNA,
 geneExprData = mRNA.data
)
```

```
datatable(miRNA_targets[1:5, ],
          options = list(scrollX = TRUE,
                         autoWidth = TRUE,
                         keys = TRUE,
                         pageLength = 5,
                         rownames= FALSE,
                         digits = 3),
                         rownames = FALSE)
```

Now, the `Fold change of gene expression` column indicates the change of gene expression for the miRNA targets, where the comparisions were made between patients with different methylation states for the corresponding miRNAs.

## 11. Session Information

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats4    stats     graphics  grDevices utils     datasets  methods
#> [8] base
#>
#> other attached packages:
#>  [1] miRBaseConverter_1.34.0 multiMiR_1.32.0         survminer_0.5.1
#>  [4] ggpubr_0.6.2            ggplot2_4.0.0           survival_3.8-3
#>  [7] org.Hs.eg.db_3.22.0     AnnotationDbi_1.72.0    Biobase_2.70.0
#> [10] clusterProfiler_4.18.0  GenomicRanges_1.62.0    Seqinfo_1.0.0
#> [13] IRanges_2.44.0          S4Vectors_0.48.0        sesameData_1.27.1
#> [16] DT_0.34.0               EpiMix_1.12.0           EpiMix.data_1.11.0
#> [19] ExperimentHub_3.0.0     AnnotationHub_4.0.0     BiocFileCache_3.0.0
#> [22] dbplyr_2.5.1            BiocGenerics_0.56.0     generics_0.1.4
#>
#> loaded via a namespace (and not attached):
#>   [1] splines_4.5.1               BiocIO_1.20.0
#>   [3] bitops_1.0-9                ggplotify_0.1.3
#>   [5] filelock_1.0.3              tibble_3.3.0
#>   [7] R.oo_1.27.1                 XML_3.99-0.19
#>   [9] lifecycle_1.0.4             httr2_1.2.1
#>  [11] rstatix_0.7.3               doParallel_1.0.17
#>  [13] lattice_0.22-7              crosstalk_1.2.2
#>  [15] backports_1.5.0             magrittr_2.0.4
#>  [17] limma_3.66.0                sass_0.4.10
#>  [19] rmarkdown_2.30              jquerylib_0.1.4
#>  [21] yaml_2.3.10                 ggtangle_0.0.7
#>  [23] cowplot_1.2.0               DBI_1.2.3
#>  [25] RColorBrewer_1.1-3          abind_1.4-8
#>  [27] purrr_1.1.0                 R.utils_2.13.0
#>  [29] RCurl_1.98-1.17             yulab.utils_0.2.1
#>  [31] rappdirs_0.3.3              gdtools_0.4.4
#>  [33] KMsurv_0.1-6                enrichplot_1.30.0
#>  [35] ggrepel_0.9.6               tidytree_0.4.6
#>  [37] codetools_0.2-20            DelayedArray_0.36.0
#>  [39] DOSE_4.4.0                  tidyselect_1.2.1
#>  [41] aplot_0.2.9                 farver_2.1.2
#>  [43] matrixStats_1.5.0           GenomicAlignments_1.46.0
#>  [45] jsonlite_2.0.0              Formula_1.2-5
#>  [47] iterators_1.0.14            systemfonts_1.3.1
#>  [49] foreach_1.5.2               tools_4.5.1
#>  [51] progress_1.2.3              treeio_1.34.0
#>  [53] snow_0.4-4                  Rcpp_1.1.0
#>  [55] glue_1.8.0                  gridExtra_2.3
#>  [57] SparseArray_1.10.0          xfun_0.53
#>  [59] mgcv_1.9-3                  qvalue_2.42.0
#>  [61] MatrixGenerics_1.22.0       dplyr_1.1.4
#>  [63] withr_3.0.2                 BiocManager_1.30.26
#>  [65] fastmap_1.2.0               digest_0.6.37
#>  [67] R6_2.6.1                    gridGraphics_0.5-1
#>  [69] GO.db_3.22.0                RPMM_1.25
#>  [71] dichromat_2.0-0.1           biomaRt_2.66.0
#>  [73] RSQLite_2.4.3               cigarillo_1.0.0
#>  [75] R.methodsS3_1.8.2           tidyr_1.3.1
#>  [77] fontLiberation_0.1.0        data.table_1.17.8
#>  [79] rtracklayer_1.70.0          prettyunits_1.2.0
#>  [81] httr_1.4.7                  htmlwidgets_1.6.4
#>  [83] S4Arrays_1.10.0             pkgconfig_2.0.3
#>  [85] gtable_0.3.6                blob_1.2.4
#>  [87] S7_0.2.0                    impute_1.84.0
#>  [89] XVector_0.50.0              survMisc_0.5.6
#>  [91] htmltools_0.5.8.1           carData_3.0-5
#>  [93] fontBitstreamVera_0.1.1     fgsea_1.36.0
#>  [95] scales_1.4.0                png_0.1-8
#>  [97] doSNOW_1.0.20               ggfun_0.2.0
#>  [99] km.ci_0.5-6                 knitr_1.50
#> [101] tzdb_0.5.0                  reshape2_1.4.4
#> [103] rjson_0.2.23                nlme_3.1-168
#> [105] curl_7.0.0                  zoo_1.8-14
#> [107] cachem_1.1.0                stringr_1.5.2
#> [109] BiocVersion_3.22.0          parallel_4.5.1
#> [111] restfulr_0.0.16             pillar_1.11.1
#> [113] grid_4.5.1                  vctrs_0.6.5
#> [115] car_3.1-3                   xtable_1.8-4
#> [117] cluster_2.1.8.1             evaluate_1.0.5
#> [119] readr_2.1.5                 GenomicFeatures_1.62.0
#> [121] cli_3.6.5                   compiler_4.5.1
#> [123] Rsamtools_2.26.0            rlang_1.1.6
#> [125] crayon_1.5.3                ggsignif_0.6.4
#> [127] labeling_0.4.3              plyr_1.8.9
#> [129] fs_1.6.6                    ggiraph_0.9.2
#> [131] stringi_1.8.7               BiocParallel_1.44.0
#> [133] Biostrings_2.78.0           lazyeval_0.2.2
#> [135] GOSemSim_2.36.0             fontquiver_0.2.1
#> [137] Matrix_1.7-4                hms_1.1.4
#> [139] patchwork_1.3.2             bit64_4.6.0-1
#> [141] KEGGREST_1.50.0             statmod_1.5.1
#> [143] SummarizedExperiment_1.40.0 broom_1.0.10
#> [145] igraph_2.2.1                memoise_2.0.1
#> [147] bslib_0.9.0                 ggtree_4.0.0
#> [149] fastmatch_1.1-6             bit_4.6.0
#> [151] ELMER.data_2.33.0           downloader_0.4.1
#> [153] gson_0.1.0                  ape_5.8-1
```