# Case study: command-line interface (CLI) tutorial

#### Nuno Saraiva-Agostinho

#### 2026-01-08

* [Installing and starting the program](#installing-and-starting-the-program)
* [Quick reference of psichomics functions](#quick-reference-of-psichomics-functions)
* [Exploration of clinically-relevant, differentially spliced events in breast cancer](#exploration-of-clinically-relevant-differentially-spliced-events-in-breast-cancer)
  + [Downloading and loading TCGA data](#downloading-and-loading-tcga-data)
  + [Filtering and normalising gene expression](#filtering-and-normalising-gene-expression)
  + [Quantifying alternative splicing](#quantifying-alternative-splicing)
  + [Data grouping](#data-grouping)
  + [Principal component analysis (PCA)](#principal-component-analysis-pca)
  + [*NUMB* exon 12 inclusion and correlation with QKI gene expression](#numb-exon-12-inclusion-and-correlation-with-qki-gene-expression)
    - [Differential inclusion of *NUMB* exon 12](#differential-inclusion-of-numb-exon-12)
    - [Correlation between *NUMB* exon 12 inclusion and QKI expression](#correlation-between-numb-exon-12-inclusion-and-qki-expression)
  + [Differential splicing analysis](#differential-splicing-analysis)
    - [Performing multiple survival analysis](#performing-multiple-survival-analysis)
  + [Differential gene expression](#differential-gene-expression)
    - [*UHRF2* exon 10 inclusion](#uhrf2-exon-10-inclusion)
* [Loading data from other sources](#loading-data-from-other-sources)
  + [Load GTEx data](#load-gtex-data)
  + [Load SRA project data using recount](#load-sra-project-data-using-recount)
  + [Load user-provided data](#load-user-provided-data)
* [Feedback](#feedback)
* [References](#references)

*psichomics* is an interactive R package for integrative analyses of alternative splicing and gene expression based on [The Cancer Genome Atlas (TCGA)](https://tcga-data.nci.nih.gov/docs/publications/tcga) (containing molecular data associated with 34 tumour types), the [Genotype-Tissue Expression (GTEx)](http://gtexportal.org) project (containing data for multiple normal human tissues), [Sequence Read Archive (SRA)](https://www.ncbi.nlm.nih.gov/sra) and user-provided data. The data from GTEx, TCGA and select SRA projects include subject/sample-associated information and transcriptomic data, such as the quantification of RNA-Seq reads aligning to splice junctions (henceforth called junction quantification) and exons.

# Installing and starting the program

Install *psichomics* by typing the following in an R console (the [R environment](https://www.r-project.org/) is required):

```
install.packages("BiocManager")
BiocManager::install("psichomics")
```

After the installation, load psichomics by typing:

```
library(psichomics)
```

# Quick reference of psichomics functions

Please read the following [function reference](https://nuno-agostinho.github.io/psichomics/reference).

# Exploration of clinically-relevant, differentially spliced events in breast cancer

> The following case study was adapted from *psichomics*’ original article:
>
> Nuno Saraiva-Agostinho and Nuno L. Barbosa-Morais (2019). **[psichomics: graphical application for alternative splicing quantification and analysis](https://doi.org/10.1093/nar/gky888)**. *Nucleic Acids Research*.

Breast cancer is the cancer type with the highest incidence and mortality in women (Torre *et al.*, 2015) and multiple studies have suggested that transcriptome-wide analyses of alternative splicing changes in breast tumours are able to uncover tumour-specific biomarkers (Tsai *et al.*, 2015; Danan-Gotthold *et al.*, 2015; Anczuków *et al.*, 2015). Given the relevance of early detection of breast cancer to patient survival, we can use *psichomics* to identify novel tumour stage-I-specific molecular signatures based on differentially spliced events.

## Downloading and loading TCGA data

The quantification of each alternative splicing event is based on the proportion of junction reads that support the inclusion isoform, known as percent spliced-in or PSI (Wang *et al.*, 2008).

To estimate this value for each splicing event, both alternative splicing annotation and junction quantification are required. While alternative splicing annotation is provided by the package, junction quantification may be retrieved from [TCGA](https://tcga-data.nci.nih.gov/docs/publications/tcga), [GTEx](http://gtexportal.org), [SRA](https://www.ncbi.nlm.nih.gov/sra) or user-provided files.

Data is downloaded from [FireBrowse](http://firebrowse.org), a service that hosts processed data from [TCGA](https://tcga-data.nci.nih.gov/docs/publications/tcga), as required to run the downstream analyses. Before downloading data, check the following options:

```
# Available tumour types
cohorts <- getFirebrowseCohorts()

# Available sample dates
date <- getFirebrowseDates()

# Available data types
dataTypes <- getFirebrowseDataTypes()
```

> Note there is also the option for *Gene expression (normalised by RSEM)*. However, we recommend to load the raw gene expression data instead, followed by filtering and normalisation as demonstrated afterwards.

After deciding on the options to use, download and load breast cancer data as follows:

```
# Set download folder
folder <- getDownloadsFolder()

# Download and load most recent junction quantification and clinical data from
# TCGA/FireBrowse for Breast Cancer
data <- loadFirebrowseData(folder=folder,
                           cohort="BRCA",
                           data=c("clinical", "junction_quantification",
                                  "RSEM_genes"),
                           date="2016-01-28")
names(data)
names(data[[1]])

# Select clinical and junction quantification dataset
clinical      <- data[[1]]$`Clinical data`
sampleInfo    <- data[[1]]$`Sample metadata`
junctionQuant <- data[[1]]$`Junction quantification (Illumina HiSeq)`
geneExpr      <- data[[1]]$`Gene expression`
```

Data is only downloaded if the files are not present in the given folder. In other words, if the files were already downloaded, the function will just load the files, so it is possible to reuse the code above just to load the requested files.

> **Windows limitations**: If you are using *Windows*, note that the downloaded files have huge names that may be over [*Windows* Maximum Path Length](https://msdn.microsoft.com/library/windows/desktop/aa365247.aspx#maxpath). A workaround would be to manually rename the downloaded files to have shorter names, move all downloaded files to a single folder and load such folder.

## Filtering and normalising gene expression

As this package does not focuses on gene expression analysis, we suggest to read the RNA-seq section of `limma`’s user guide. Nevertheless, we present the following commands to quickly filter and normalise gene expression:

```
# Check genes with 10 or more counts in at least some samples and 15 or more
# total counts across all samples
filter <- filterGeneExpr(geneExpr, minCounts=10, minTotalCounts=15)

# What normaliseGeneExpression() does:
# 1) Filter gene expression based on its argument "geneFilter"
# 2) Normalise gene expression with edgeR::calcNormFactors (internally) using
#    the trimmed mean of M-values (TMM) method (by default)
# 3) Calculate log2-counts per million (logCPM)
geneExprNorm <- normaliseGeneExpression(geneExpr,
                                        geneFilter=filter,
                                        method="TMM",
                                        log2transform=TRUE)
```

## Quantifying alternative splicing

After loading the clinical and alternative splicing junction quantification data from TCGA, quantify alternative splicing by clicking the green panel **Alternative splicing quantification**.

As previously mentioned, alternative splicing is quantified from the previously loaded junction quantification and an alternative splicing annotation file. To check current annotation files available:

```
# Available alternative splicing annotation
annotList <- listSplicingAnnotations()
annotList
```

```
##                                            Human hg19 (2016-10-11)
##                                                          "AH51461"
##                                            Human hg19 (2017-10-20)
##                                                          "AH60272"
##                                            Human hg38 (2018-04-30)
##                                                          "AH63657"
##                            Human hg19 from VAST-TOOLS (2021-06-15)
##                                                          "AH95569"
##                            Human hg38 from VAST-TOOLS (2021-06-15)
##                                                          "AH95570"
##                      Mus musculus mm9 from VAST-TOOLS (2021-06-15)
##                                                          "AH95571"
##                     Mus musculus mm10 from VAST-TOOLS (2021-06-15)
##                                                          "AH95572"
##                    Bos taurus bosTau6 from VAST-TOOLS (2021-06-15)
##                                                          "AH95573"
##                 Gallus gallus galGal3 from VAST-TOOLS (2021-06-15)
##                                                          "AH95574"
##                 Gallus gallus galGal4 from VAST-TOOLS (2021-06-15)
##                                                          "AH95575"
##            Xenopus tropicalis xenTro3 from VAST-TOOLS (2021-06-15)
##                                                          "AH95576"
##                  Danio rerio danRer10 from VAST-TOOLS (2021-06-15)
##                                                          "AH95577"
##     Branchiostoma lanceolatum braLan2 from VAST-TOOLS (2021-06-15)
##                                                          "AH95578"
## Strongylocentrotus purpuratus strPur4 from VAST-TOOLS (2021-06-15)
##                                                          "AH95579"
##           Drosophila melanogaster dm6 from VAST-TOOLS (2021-06-15)
##                                                          "AH95580"
##            Strigamia maritima strMar1 from VAST-TOOLS (2021-06-15)
##                                                          "AH95581"
##           Caenorhabditis elegans ce11 from VAST-TOOLS (2021-06-15)
##                                                          "AH95582"
##       Schmidtea mediterranea schMed31 from VAST-TOOLS (2021-06-15)
##                                                          "AH95583"
##        Nematostella vectensis nemVec1 from VAST-TOOLS (2021-06-15)
##                                                          "AH95584"
##         Arabidopsis thaliana araTha10 from VAST-TOOLS (2021-06-15)
##                                                          "AH95585"
```

> **Custom splicing annotation:** Additional alternative splicing annotations can be prepared for *psichomics* by parsing the annotation from programs like [VAST-TOOLS](https://github.com/vastgroup/vast-tools), [MISO](http://genes.mit.edu/burgelab/miso/), [SUPPA](https://bitbucket.org/regulatorygenomicsupf/suppa) and [rMATS](http://rnaseq-mats.sourceforge.net). Note that SUPPA and rMATS are able to create their splicing annotation based on transcript annotation. Please read [Preparing alternative splicing annotations](https://nuno-agostinho.github.io/psichomics/articles/AS_events_preparation.html).

To quantify alternative splicing, first select the junction quantification, alternative splicing annotation and alternative splicing event type(s) of interest:

```
# Load Human (hg19/GRCh37 assembly) annotation
hg19 <- listSplicingAnnotations(assembly="hg19")[[1]]
annotation <- loadAnnotation(hg19)
```

```
# Available alternative splicing event types (skipped exon, alternative
# first/last exon, mutually exclusive exons, etc.)
getSplicingEventTypes()
```

```
##                                          Skipped exon
##                                                  "SE"
##                               Mutually exclusive exon
##                                                 "MXE"
##                            Alternative 5' splice site
##                                                "A5SS"
##                            Alternative 3' splice site
##                                                "A3SS"
##                                Alternative first exon
##                                                 "AFE"
##                                 Alternative last exon
##                                                 "ALE"
## Alternative first exon (exon-centred - less reliable)
##                                            "AFE_exon"
##  Alternative last exon (exon-centred - less reliable)
##                                            "ALE_exon"
```

Afterwards, quantify alternative splicing using the previously defined parameters:

```
# Discard alternative splicing quantified using few reads
minReads <- 10 # default

psi <- quantifySplicing(annotation, junctionQuant, minReads=minReads)
```

```
# Check the identifier of the splicing events in the resulting table
events <- rownames(psi)
head(events)
```

```
## [1] "SE_3_+_13661331_13663275_13663415_13667945_FBLN2"
## [2] "SE_3_+_57908750_57911572_57911661_57913023_SLMAP"
## [3] "ALE_3_+_57908750_57911572_57913023_SLMAP"
## [4] "SE_3_-_37136283_37133029_37132958_37125297_LRRFIP2"
## [5] "SE_12_-_56558432_56558152_56558087_56557549_SMARCC2"
## [6] "AFE_4_+_56755098_56750094_56756389_EXOC1"
```

Note that the event identifier (for instance, `SE_1_-_2125078_2124414_2124284_2121220_C1orf86`) is composed of:

* Event type (`SE` stands for skipped exon)
* Chromosome (`1`)
* Strand (`-`)
* Relevant coordinates depending on event type (in this case, the first constitutive exon’s end, the alternative exon’ start and end and the second constitutive exon’s start)
* Associated gene (`C1orf86`)

> **Warning:** all examples shown in this case study are performed using a small, yet representative subset of the available data. Therefore, values shown here may correspond to those when performing the whole analysis.

## Data grouping

Let us create groups based on available samples types (i.e. *Metastatic*, *Primary solid Tumor* and *Solid Tissue Normal*) and tumour stages. As tumour stages are divided by sub-stages, we will merge sub-stages so as to have only tumour samples from stages I, II, III and IV (stage X samples are discarded as they are uncharacterised tumour samples).

```
# Group by normal and tumour samples
types  <- createGroupByAttribute("Sample types", sampleInfo)
normal <- types$`Solid Tissue Normal`
tumour <- types$`Primary solid Tumor`

# Group by tumour stage (I, II, III or IV) or normal samples
stages <- createGroupByAttribute(
    "patient.stage_event.pathologic_stage_tumor_stage", clinical)
groups <- list()
for (i in c("i", "ii", "iii", "iv")) {
    stage <- Reduce(union,
           stages[grep(sprintf("stage %s[a|b|c]{0,1}$", i), names(stages))])
    # Include only tumour samples
    stageTumour <- names(getSubjectFromSample(tumour, stage))
    elem <- list(stageTumour)
    names(elem) <- paste("Tumour Stage", toupper(i))
    groups <- c(groups, elem)
}
groups <- c(groups, Normal=list(normal))

# Prepare group colours (for consistency across downstream analyses)
colours <- c("#6D1F95", "#FF152C", "#00C7BA", "#FF964F", "#00C65A")
names(colours) <- names(groups)
attr(groups, "Colour") <- colours

# Prepare normal versus tumour stage I samples
normalVSstage1Tumour <- groups[c("Tumour Stage I", "Normal")]
attr(normalVSstage1Tumour, "Colour") <- attr(groups, "Colour")

# Prepare normal versus tumour samples
normalVStumour <- list(Normal=normal, Tumour=tumour)
attr(normalVStumour, "Colour") <- c(Normal="#00C65A", Tumour="#EFE35C")
```

## Principal component analysis (PCA)

PCA is a technique to reduce data dimensionality by identifying variable combinations (called principal components) that explain the variance in the data (Ringnér, 2008). Use the following commands to perform PCA:

```
# PCA of PSI between normal and tumour stage I samples
psi_stage1Norm    <- psi[ , unlist(normalVSstage1Tumour)]
pcaPSI_stage1Norm <- performPCA(t(psi_stage1Norm))
```

> As PCA cannot be performed on data with missing values, missing values need to be either removed (thus discarding data from whole splicing events or genes) or impute them (i.e. attributing to missing values the median of the non-missing ones). Use the argument `missingValues` of `performPCA()` to select the number of missing values that are tolerable per event (i.e. if a splicing event or gene has less than N missing values, those missing values will be imputed; otherwise, the event is discarded from PCA).

```
# Explained variance across principal components
plotPCAvariance(pcaPSI_stage1Norm)
```

```
# Score plot (clinical individuals)
plotPCA(pcaPSI_stage1Norm, groups=normalVSstage1Tumour)
```

```
# Loading plot (variable contributions)
plotPCA(pcaPSI_stage1Norm, loadings=TRUE, individuals=FALSE,
        nLoadings=100)
```

> For performance reasons, the loading plot is able to limit the number of top variables that most contribute to the select principal components, as controlled by the argument `nLoadings` of `plotPCA()`.

> **Hint:** As most plots in *psichomics*, PCA plots can be zoomed-in by clicking-and-dragging within the plot (click *Reset zoom* to zoom-out). To toggle the visibility of the data series represented in the plot, click its respective name in the plot legend.

```
# Table of variable contributions (as used to plot PCA, also)
table <- calculateLoadingsContribution(pcaPSI_stage1Norm)
head(table, 5)
```

|  | Rank | Event type | Chromosome | Strand | Gene | Event position | PC1 loading | PC2 loading | Contribution to PC1 (%) | Contribution to PC2 (%) | Contribution to PC1 and PC2 (%) |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| SE\_3\_+\_13661331\_13663275\_13663415\_13667945\_FBLN2 | 1 | Skipped exon (SE) | 3 | + | FBLN2 | 13661331, 13667945 | 0.1339504 | -0.1403020 | 1.794271 | 1.9684643 | 1.814085 |
| AFE\_15\_+\_74466994\_74466360\_74467192\_ISLR | 2 | Alternative first exon (AFE) | 15 | + | ISLR | 74466360, 74467192 | 0.1190302 | -0.2101108 | 1.416820 | 4.4146553 | 1.757812 |
| SE\_3\_+\_57908750\_57911572\_57911661\_57913023\_SLMAP | 3 | Skipped exon (SE) | 3 | + | SLMAP | 57908750, 57913023 | 0.1365527 | -0.0591862 | 1.864663 | 0.3503006 | 1.692410 |
| ALE\_3\_+\_57908750\_57911572\_57913023\_SLMAP | 4 | Alternative last exon (ALE) | 3 | + | SLMAP | 57908750, 57913023 | 0.1358264 | -0.0608691 | 1.844880 | 0.3705053 | 1.677176 |
| SE\_3\_-\_37136283\_37133029\_37132958\_37125297\_LRRFIP2 | 5 | Skipped exon (SE) | 3 | - | LRRFIP2 | 37125297, 37136283 | 0.1320250 | -0.0141660 | 1.743061 | 0.0200676 | 1.547077 |

To perform PCA using alternative splicing quantification and gene expression data (both using *all samples* and only *Tumour Stage I* and *Normal* samples):

```
# PCA of PSI between all samples (coloured by tumour stage and normal samples)
pcaPSI_all <- performPCA(t(psi))
plotPCA(pcaPSI_all, groups=groups)
plotPCA(pcaPSI_all, loadings=TRUE, individuals=FALSE)

# PCA of gene expression between all samples (coloured by tumour stage and
# normal samples)
pcaGE_all <- performPCA(t(geneExprNorm))
plotPCA(pcaGE_all, groups=groups)
plotPCA(pcaGE_all, loadings=TRUE, individuals=FALSE)

# PCA of gene expression between normal and tumour stage I samples
ge_stage1Norm    <- geneExprNorm[ , unlist(normalVSstage1Tumour)]
pcaGE_stage1Norm <- performPCA(t(ge_stage1Norm))
plotPCA(pcaGE_stage1Norm, groups=normalVSstage1Tumour)
plotPCA(pcaGE_stage1Norm, loadings=TRUE, individuals=FALSE)
```

## *NUMB* exon 12 inclusion and correlation with QKI gene expression

One of the splicing events that most contribute the separation between tumour stage I and normal samples is **NUMB exon 12 inclusion**, whose protein is crucial for cell differentiation as a key regulator of the Notch pathway. The RNA-binding protein QKI has been shown to repress NUMB exon 12 inclusion in lung cancer cells by competing with core splicing factor SF1 for binding to the branch-point sequence, thereby repressing the Notch signalling pathway, which results in decreased cancer cell proliferation (Zong *et al.*, 2014).

### Differential inclusion of *NUMB* exon 12

Let’s check whether a significant difference in *NUMB* exon 12 inclusion between tumour and normal TCGA breast samples. To do so:

```
# Find the right event
ASevents <- rownames(psi)
(tmp     <- grep("NUMB", ASevents, value=TRUE))
```

```
## [1] "SE_14_-_73749067_73746132_73745989_73744001_NUMB"
```

```
NUMBskippedExon12 <- tmp[1]

# Plot the representation of NUMB exon 12 inclusion
plotSplicingEvent(NUMBskippedExon12)
```

73749067

73746132
73745989
143 nts

73744001

```
# Plot its PSI distribution
plotDistribution(psi[NUMBskippedExon12, ], normalVStumour)
```

Consistent with the cited article, *NUMB* exon 12 inclusion is significantly increased in cancer.

Also of interest:

* Hover each group in the plot to compare the respective number of samples, median and variance.
* To zoom in a specific region, click-and-drag in the region of interest.
* To hide or show groups, click on their name in the legend.

### Correlation between *NUMB* exon 12 inclusion and QKI expression

To verify if *NUMB* exon 12 inclusion is correlated with QKI expression:

```
# Find the right gene
genes <- rownames(geneExprNorm)
(tmp  <- grep("QKI", genes, value=TRUE))
```

```
## [1] "QKI|9444"
```

```
QKI   <- tmp[1] # "QKI|9444"

# Plot its gene expression distribution
plotDistribution(geneExprNorm[QKI, ], normalVStumour, psi=FALSE)
```

```
plotCorrelation(correlateGEandAS(
    geneExprNorm, psi, QKI, NUMBskippedExon12, method="spearman"))
```

```
## $`SE_14_-_73749067_73746132_73745989_73744001_NUMB`
## $`SE_14_-_73749067_73746132_73745989_73744001_NUMB`$`QKI|9444`
```

![](data:image/png;base64...)

According to the obtained results and also consistent with the previous article, the inclusion of the exon is negatively correlated with QKI expression.

## Differential splicing analysis

To analyse alternative splicing between normal and tumour stage I samples:

```
diffSplicing <- diffAnalyses(psi, normalVSstage1Tumour)
```

```
# Filter based on |∆ Median PSI| > 0.1 and q-value < 0.01
deltaPSIthreshold <- abs(diffSplicing$`∆ Median`) > 0.1
pvalueThreshold   <- diffSplicing$`Wilcoxon p-value (BH adjusted)` < 0.01
eventsThreshold <- diffSplicing[deltaPSIthreshold & pvalueThreshold, ]

# Plot results
library(ggplot2)
ggplot(diffSplicing, aes(`∆ Median`,
                         -log10(`Wilcoxon p-value (BH adjusted)`))) +
    geom_point(data=eventsThreshold,
               colour="orange", alpha=0.5, size=3) +
    geom_point(data=diffSplicing[!deltaPSIthreshold | !pvalueThreshold, ],
               colour="gray", alpha=0.5, size=3) +
    theme_light(16) +
    ylab("-log10(q-value)")
```

![](data:image/png;base64...)

```
# Table of events that pass the thresholds
head(eventsThreshold)
```

|  | Event type | Chromosome | Strand | Gene | Survival by PSI cutoff | Optimal PSI cutoff | Log-rank p-value | Samples (Normal) | Samples (Tumour Stage I) | T-test statistic | T-test parameter | T-test p-value | T-test p-value (BH adjusted) | T-test conf int1 | T-test conf int2 | T-test estimate1 | T-test estimate2 | T-test null value | T-test stderr | T-test alternative | T-test method | T-test data name | Wilcoxon statistic | Wilcoxon p-value | Wilcoxon p-value (BH adjusted) | Wilcoxon null value | Wilcoxon alternative | Wilcoxon method | Wilcoxon data name | Kruskal statistic | Kruskal parameter | Kruskal p-value | Kruskal p-value (BH adjusted) | Kruskal method | Kruskal data name | Levene statistic | Levene p-value | Levene p-value (BH adjusted) | Levene data name | Levene method | Fligner-Killeen statistic | Fligner-Killeen parameter | Fligner-Killeen p-value | Fligner-Killeen p-value (BH adjusted) | Fligner-Killeen method | Fligner-Killeen data name | Variance (Normal) | Variance (Tumour Stage I) | Median (Normal) | Median (Tumour Stage I) | ∆ Variance | ∆ Median |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| SE\_3\_+\_13661331\_13663275\_13663415\_13667945\_FBLN2 | Skipped exon (SE) | 3 | + | FBLN2 | NA | NA | NA | 112 | 178 | 35.25121 | 256.8713 | 0 | 0 | 0.4913165 | 0.5494573 | 0.6951339 | 0.1747470 | 0 | 0.0147622 | two.sided | Welch Two Sample t-test | vector[typeOne] and vector[!typeOne] | 19781.5 | 0 | 0 | 0 | two.sided | Wilcoxon rank sum test with continuity correction | vector[typeOne] and vector[!typeOne] | 199.2100 | 1 | 0 | 0 | Kruskal-Wallis rank sum test | vector and group | 0.0030809 | 0.9557741 | 0.9557741 | vector and group | Levene’s test (using the median) | 0.5378107 | 1 | 0.4633415 | 0.5022233 | Fligner-Killeen test of homogeneity of variances | vector and group | 0.0135423 | 0.0172679 | 0.7189603 | 0.1416915 | -0.0037256 | 0.5772688 |
| SE\_3\_+\_57908750\_57911572\_57911661\_57913023\_SLMAP | Skipped exon (SE) | 3 | + | SLMAP | NA | NA | NA | 112 | 181 | 22.08735 | 290.9932 | 0 | 0 | 0.3970111 | 0.4746859 | 0.7505524 | 0.3147039 | 0 | 0.0197329 | two.sided | Welch Two Sample t-test | vector[typeOne] and vector[!typeOne] | 18879.0 | 0 | 0 | 0 | two.sided | Wilcoxon rank sum test with continuity correction | vector[typeOne] and vector[!typeOne] | 153.9075 | 1 | 0 | 0 | Kruskal-Wallis rank sum test | vector and group | 10.4441525 | 0.0013716 | 0.0024722 | vector and group | Levene’s test (using the median) | 7.0960805 | 1 | 0.0077253 | 0.0122185 | Fligner-Killeen test of homogeneity of variances | vector and group | 0.0167379 | 0.0434298 | 0.7547746 | 0.2470588 | -0.0266920 | 0.5077157 |
| ALE\_3\_+\_57908750\_57911572\_57913023\_SLMAP | Alternative last exon (ALE) | 3 | + | SLMAP | NA | NA | NA | 112 | 181 | 21.76346 | 289.9965 | 0 | 0 | 0.3947718 | 0.4732735 | 0.7172262 | 0.2832036 | 0 | 0.0199427 | two.sided | Welch Two Sample t-test | vector[typeOne] and vector[!typeOne] | 18942.5 | 0 | 0 | 0 | two.sided | Wilcoxon rank sum test with continuity correction | vector[typeOne] and vector[!typeOne] | 156.1536 | 1 | 0 | 0 | Kruskal-Wallis rank sum test | vector and group | 7.8066040 | 0.0055511 | 0.0090571 | vector and group | Levene’s test (using the median) | 5.3586469 | 1 | 0.0206198 | 0.0285363 | Fligner-Killeen test of homogeneity of variances | vector and group | 0.0182637 | 0.0424705 | 0.7195130 | 0.2206573 | -0.0242068 | 0.4988557 |
| SE\_3\_-\_37136283\_37133029\_37132958\_37125297\_LRRFIP2 | Skipped exon (SE) | 3 | - | LRRFIP2 | NA | NA | NA | 112 | 180 | 20.17074 | 251.8459 | 0 | 0 | 0.3578812 | 0.4353285 | 0.7089629 | 0.3123581 | 0 | 0.0196624 | two.sided | Welch Two Sample t-test | vector[typeOne] and vector[!typeOne] | 19065.0 | 0 | 0 | 0 | two.sided | Wilcoxon rank sum test with continuity correction | vector[typeOne] and vector[!typeOne] | 164.0062 | 1 | 0 | 0 | Kruskal-Wallis rank sum test | vector and group | 1.5743988 | 0.2105796 | 0.2417766 | vector and group | Levene’s test (using the median) | 1.6230249 | 1 | 0.2026705 | 0.2344323 | Fligner-Killeen test of homogeneity of variances | vector and group | 0.0247654 | 0.0297881 | 0.6925958 | 0.2860301 | -0.0050227 | 0.4065657 |
| SE\_12\_-\_56558432\_56558152\_56558087\_56557549\_SMARCC2 | Skipped exon (SE) | 12 | - | SMARCC2 | NA | NA | NA | 112 | 181 | -20.73860 | 177.9125 | 0 | 0 | -0.4497058 | -0.3715582 | 0.3877788 | 0.7984108 | 0 | 0.0198004 | two.sided | Welch Two Sample t-test | vector[typeOne] and vector[!typeOne] | 694.0 | 0 | 0 | 0 | two.sided | Wilcoxon rank sum test with continuity correction | vector[typeOne] and vector[!typeOne] | 179.5060 | 1 | 0 | 0 | Kruskal-Wallis rank sum test | vector and group | 27.5729041 | 0.0000003 | 0.0000008 | vector and group | Levene’s test (using the median) | 23.2937373 | 1 | 0.0000014 | 0.0000037 | Fligner-Killeen test of homogeneity of variances | vector and group | 0.0337541 | 0.0164129 | 0.3897698 | 0.8210526 | 0.0173413 | -0.4312828 |
| AFE\_4\_+\_56755098\_56750094\_56756389\_EXOC1 | Alternative first exon (AFE) | 4 | + | EXOC1 | NA | NA | NA | 112 | 175 | 14.23168 | 208.5711 | 0 | 0 | 0.2866482 | 0.3788319 | 0.6677512 | 0.3350112 | 0 | 0.0233802 | two.sided | Welch Two Sample t-test | vector[typeOne] and vector[!typeOne] | 17428.0 | 0 | 0 | 0 | two.sided | Wilcoxon rank sum test with continuity correction | vector[typeOne] and vector[!typeOne] | 123.7057 | 1 | 0 | 0 | Kruskal-Wallis rank sum test | vector and group | 3.3371823 | 0.0687764 | 0.0881019 | vector and group | Levene’s test (using the median) | 3.2181098 | 1 | 0.0728277 | 0.0932917 | Fligner-Killeen test of homogeneity of variances | vector and group | 0.0419169 | 0.0301660 | 0.6466063 | 0.3134328 | 0.0117509 | 0.3331735 |

### Performing multiple survival analysis

To study the impact of alternative splicing events on prognosis, Kaplan-Meier curves may be plotted for groups of patients separated by the optimal PSI cutoff for a given alternative splicing event that that maximises the significance of group differences in survival analysis (i.e. minimises the p-value of the log-rank tests of difference in survival between individuals whose samples have their PSI below and above that threshold).

Given the slow process of calculating the optimal splicing quantification cutoff for multiple events, it is recommended to perform this for a subset of differentially spliced events.

```
# Events already tested which have prognostic value
events <- c(
    "SE_9_+_6486925_6492303_6492401_6493826_UHRF2",
    "SE_4_-_87028376_87024397_87024339_87023185_MAPK10",
    "SE_2_+_152324660_152324988_152325065_152325155_RIF1",
    "SE_2_+_228205096_228217230_228217289_228220393_MFF",
    "MXE_15_+_63353138_63353397_63353472_63353912_63353987_63354414_TPM1",
    "SE_2_+_173362828_173366500_173366629_173368819_ITGA6",
    "SE_1_+_204957934_204971724_204971876_204978685_NFASC")

# Survival curves based on optimal PSI cutoff
library(survival)

# Assign alternative splicing quantification to patients based on their samples
samples <- colnames(psi)
match <- getSubjectFromSample(samples, clinical, sampleInfo=sampleInfo)

survPlots <- list()
for (event in events) {
    # Find optimal cutoff for the event
    eventPSI <- assignValuePerSubject(psi[event, ], match, clinical,
                                      samples=unlist(tumour))
    opt <- optimalSurvivalCutoff(clinical, eventPSI, censoring="right",
                                 event="days_to_death",
                                 timeStart="days_to_death")
    (optimalCutoff <- opt$par)    # Optimal exon inclusion level
    (optimalPvalue <- opt$value)  # Respective p-value

    label     <- labelBasedOnCutoff(eventPSI, round(optimalCutoff, 2),
                                    label="PSI values")
    survTerms <- processSurvTerms(clinical, censoring="right",
                                  event="days_to_death",
                                  timeStart="days_to_death",
                                  group=label, scale="years")
    surv <- survfit(survTerms)
    pvalue <- testSurvival(survTerms)
    survPlots[[event]] <- plotSurvivalCurves(surv, pvalue=pvalue, mark=FALSE)
}

# Now print the survival plot of a specific event
survPlots[[ events[[1]] ]]
```

## Differential gene expression

Detected alterations in alternative splicing may simply be a reflection of changes in gene expression levels. Therefore, to disentangle these two effects, differential expression analysis between tumour stage I and normal samples should also be performed. In order to do so:

```
# Prepare groups of samples to analyse and further filter unavailable samples in
# selected groups for gene expression
ge           <- geneExprNorm[ , unlist(normalVSstage1Tumour), drop=FALSE]
isFromGroup1 <- colnames(ge) %in% normalVSstage1Tumour[[1]]
design       <- cbind(1, ifelse(isFromGroup1, 0, 1))

# Fit a gene-wise linear model based on selected groups
library(limma)
fit <- lmFit(as.matrix(ge), design)

# Calculate moderated t-statistics and DE log-odds using limma::eBayes
ebayesFit <- eBayes(fit, trend=TRUE)

# Prepare data summary
pvalueAdjust <- "BH" # Benjamini-Hochberg p-value adjustment (FDR)
summary <- topTable(ebayesFit, number=nrow(fit), coef=2, sort.by="none",
                    adjust.method=pvalueAdjust, confint=TRUE)
names(summary) <- c("log2 Fold-Change", "CI (low)", "CI (high)",
                    "Average expression", "moderated t-statistics", "p-value",
                    paste0("p-value (", pvalueAdjust, " adjusted)"),
                    "B-statistics")
attr(summary, "groups") <- normalVSstage1Tumour

# Calculate basic statistics
stats <- diffAnalyses(ge, normalVSstage1Tumour, "basicStats",
                      pvalueAdjust=NULL)
```

```
final <- cbind(stats, summary)

# Differential gene expression between breast tumour stage I and normal samples
library(ggplot2)
library(ggrepel)
cognateGenes <- unlist(parseSplicingEvent(events)$gene)
logFCthreshold  <- abs(final$`log2 Fold-Change`) > 1
pvalueThreshold <- final$`p-value (BH adjusted)` < 0.01

final$genes <- gsub("\\|.*$", "\\1", rownames(final))
ggplot(final, aes(`log2 Fold-Change`,
                  -log10(`p-value (BH adjusted)`))) +
    geom_point(data=final[logFCthreshold & pvalueThreshold, ],
               colour="orange", alpha=0.5, size=3) +
    geom_point(data=final[!logFCthreshold | !pvalueThreshold, ],
               colour="gray", alpha=0.5, size=3) +
    geom_text_repel(data=final[cognateGenes, ], aes(label=genes),
                    box.padding=0.4, size=5) +
    theme_light(16) +
    ylab("-log10(q-value)")
```

![](data:image/png;base64...)

### *UHRF2* exon 10 inclusion

One splicing event with prognostic value is the alternative splicing of *UHRF2* exon 10. Cell-cycle regulator UHRF2 promotes cell proliferation and inhibits the expression of tumour suppressors in breast cancer (Wu *et al.*, 2012).

#### Differential splicing analysis

Let’s check whether a significant difference in *UHRF2* exon 10 inclusion between tumour stage I and normal samples. To do so:

```
# UHRF2 skipped exon 10's PSI values per tumour stage I and normal samples
UHRF2skippedExon10 <- events[1]
plotDistribution(psi[UHRF2skippedExon10, ], normalVSstage1Tumour)
```

Higher inclusion of *UHRF2* exon 10 is associated with normal samples.

#### Survival analysis

To study the impact of alternative splicing events on prognosis, Kaplan-Meier curves may be plotted for groups of patients separated by a given PSI cutoff for a given alternative splicing event. The optimal PSI cutoff maximises the significance of group differences in survival analysis (i.e.  minimises the p-value of the log-rank tests of difference in survival between individuals whose samples have a PSI below and above that threshold).

```
# Find optimal cutoff for the event
UHRF2skippedExon10 <- events[1]
eventPSI <- assignValuePerSubject(psi[UHRF2skippedExon10, ], match, clinical,
                                  samples=unlist(tumour))
opt <- optimalSurvivalCutoff(clinical, eventPSI, censoring="right",
                             event="days_to_death", timeStart="days_to_death")
(optimalCutoff <- opt$par)    # Optimal exon inclusion level
```

```
## [1] 0.1436954
```

```
(optimalPvalue <- opt$value)  # Respective p-value
```

```
## [1] 0.0358
```

```
label     <- labelBasedOnCutoff(eventPSI, round(optimalCutoff, 2),
                                label="PSI values")
survTerms <- processSurvTerms(clinical, censoring="right",
                              event="days_to_death", timeStart="days_to_death",
                              group=label, scale="years")
surv <- survfit(survTerms)
pvalue <- testSurvival(survTerms)
plotSurvivalCurves(surv, pvalue=pvalue, mark=FALSE)
```

As per the results, higher inclusion of *UHRF2* exon 10 is associated with better prognosis.

#### Differential expression

To check whether alternative splicing changes are related with gene expression alterations, let us perform differential expression analysis on UHRF2:

```
plotDistribution(geneExprNorm["UHRF2", ], normalVSstage1Tumour)
```

It seems UHRF2 is differentially expressed between *Tumour Stage I* and *Solid Tissue Normal*. However, going back to exploratory differential gene expression, *UHRF2* has a log2(fold-change) ≤ 1, low enough not to be biologically relevant. Following this criterium, the gene can thus be considered not to be differentially expressed between these conditions.

#### Survival analysis

To confirm if gene expression has an overall prognostic value, perform the following:

```
UHRF2ge <- assignValuePerSubject(geneExprNorm["UHRF2", ], match, clinical,
                                 samples=unlist(tumour))

# Survival curves based on optimal gene expression cutoff
opt <- optimalSurvivalCutoff(clinical, UHRF2ge, censoring="right",
                             event="days_to_death", timeStart="days_to_death")
(optimalCutoff <- opt$par)    # Optimal exon inclusion level
```

```
## [1] 10.42619
```

```
(optimalPvalue <- opt$value)  # Respective p-value
```

```
## [1] 0.176
```

```
# Process again after rounding the cutoff
roundedCutoff <- round(optimalCutoff, 2)
label     <- labelBasedOnCutoff(UHRF2ge, roundedCutoff, label="Gene expression")
survTerms <- processSurvTerms(clinical, censoring="right",
                              event="days_to_death", timeStart="days_to_death",
                              group=label, scale="years")
surv   <- survfit(survTerms)
pvalue <- testSurvival(survTerms)
plotSurvivalCurves(surv, pvalue=pvalue, mark=FALSE)
```

There seems to be no significant difference in survival between patient groups stratified by UHRF2’s optimal gene expression cutoff in tumour samples (log-rank p-value > 0.05).

#### Literature support and external database information

If an event is differentially spliced and has an impact on patient survival, its association with the studied disease might be already described in the literature. To check so, go to **Analyses** > **Gene, transcript and protein information** where information regarding the associated gene (such as description and genomic position), transcripts and protein domain annotation are available.

* The protein plot shows the UniProt matches for the selected transcript. Hover the protein’s rendered domains to obtain more information on them. More information about each protein can be retrieved by clicking the respective **UniProt** link.
* Links to related research articles are also available. Click **Show more articles** to be directed to PubMed.
* Multiple links to related external databases are available too:
  + **Human Protein Atlas (Cancer Atlas)** allows to check the evidence of a gene at protein level for multiple cancer tissues.
  + **VastDB** shows multi-species alternative splicing profiles for diverse tissues and cell types.
  + **UCSC Genome Browser** may reveal protein domain disruptions caused by the alternative splicing event. To check so, activate the **Pfam in UCSC Gene** and **UniProt** tracks (in *Genes and Gene Predictions*) and check if any domains are annotated in the alternative and/or constitutive exons of the splicing event.

#### Interpretation

Higher inclusion of *UHRF2* exon 10 is associated with normal samples and better prognosis, and potentially disrupts UHRF2’s SRA-YDG protein domain, related to the binding affinity to epigenetic marks. Hence, exon 10 inclusion may suppress UHRF2’s oncogenic role in breast cancer by impairing its activity through the induction of a truncated protein or a non-coding isoform. Moreover, this hypothesis is independent from gene expression changes, as UHRF2 is not differentially expressed between tumour stage I and normal samples (|log2(fold-change)| < 1) and there is no significant difference in survival between patient groups stratified by its expression in tumour samples (log-rank p-value > 0.05).

# Loading data from other sources

## Load GTEx data

GTEx data (subject phenotype, sample attributes, gene expression and junction quantification) for specific tissues can be automatically retrieved and loaded by following these commands:

```
# Check GTEx tissues available based on the sample attributes
getGtexTissues(sampleAttr)

tissues <- c("blood", "brain")
gtex <- loadGtexData("~/Downloads", tissues=tissues)
names(gtex)
names(gtex[[1]])
```

To load data for all GTEx tissues, please type:

```
gtex <- loadGtexData("~/Downloads", tissues=NULL)
names(gtex)
names(gtex[[1]])
```

## Load SRA project data using recount

[recount](https://jhubiostatistics.shinyapps.io/recount/) is a resource of pre-processed data for thousands of [SRA](https://www.ncbi.nlm.nih.gov/sra) projects (including gene read counts, splice junction quantification and sample metadata). psichomics supports automatic downloading and loading of [SRA](https://www.ncbi.nlm.nih.gov/sra) data from recount, as exemplified below:

```
View(recount::recount_abstract)
sra <- loadSRAproject("SRP053101")
names(sra)
names(sra[[1]])
```

Please refer to our methods article for more information (the code for performing the analysis can be found at [GitHub](https://github.com/nuno-agostinho/stem-cell-analysis-in-psichomics)):

> Nuno Saraiva-Agostinho and Nuno L. Barbosa-Morais (2020). **[Interactive Alternative Splicing Analysis of Human Stem Cells Using psichomics](https://doi.org/10.1007/978-1-0716-0301-7_10)**. In: Kidder B. (eds) Stem Cell Transcriptional Networks. *Methods in Molecular Biology*, vol 2117. Humana, New York, NY

## Load user-provided data

> Any FASTQ files can be manually aligned using a splice-aware aligner and loaded by following the instructions in [Loading user-provided data](https://nuno-agostinho.github.io/psichomics/articles/custom_data.html).

Local files can be loaded by indicating their containing folder. Any files located in this folder and sub-folders will be loaded.

For instance, to load [GTEx](http://gtexportal.org) data via local files, create a directory called **GTEx**, put all GTEx files within that folder and type these commands:

```
folder <- "~/Downloads/GTEx/"
ignore <- c(".aux.", ".mage-tab.") # File patterns to ignore
data <- loadLocalFiles(folder, ignore=ignore)[[1]]
names(data)
names(data[[1]])

# Select clinical and junction quantification dataset
clinical      <- data[["Clinical data"]]
sampleInfo    <- data[["Sample metadata"]]
geneExpr      <- data[["Gene expression"]]
junctionQuant <- data[["Junction quantification"]]
```

# Feedback

All feedback on the program, documentation and associated material (including this tutorial) is welcome. Please send any suggestions and comments to:

> Nuno Saraiva-Agostinho (nunodanielagostinho@gmail.com)
>
> [Disease Transcriptomics Lab, Instituto de Medicina Molecular (Portugal)](http://imm.medicina.ulisboa.pt/group/distrans/)

# References

Anczuków,O. *et al.* (2015) SRSF1-Regulated Alternative Splicing in Breast Cancer. *Molecular Cell*, **60**, 105–117.

Danan-Gotthold,M. *et al.* (2015) Identification of recurrent regulated alternative splicing events across human solid tumors. *Nucleic Acids Research*, **43**, 5130–5144.

Ringnér,M. (2008) What is principal component analysis? *Nature biotechnology*, **26**, 303–304.

Torre,L.A. *et al.* (2015) Global cancer statistics, 2012. *CA: a cancer journal for clinicians*, **65**, 87–108.

Tsai,Y.S. *et al.* (2015) Transcriptome-wide identification and study of cancer-specific splicing events across multiple tumors. *Oncotarget*, **6**, 6825–6839.

Wang,E.T. *et al.* (2008) Alternative isoform regulation in human tissue transcriptomes. *Nature*, **456**, 470–476.

Wu,J. *et al.* (2012) Identification and functional analysis of 9p24 amplified genes in human breast cancer. *Oncogene*, **31**, 333–341.

Zong,F.-Y. *et al.* (2014) The RNA-binding protein QKI suppresses cancer-associated aberrant splicing. *PLoS genetics*, **10**, e1004289.