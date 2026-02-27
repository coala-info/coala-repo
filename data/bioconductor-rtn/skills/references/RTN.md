# RTN: Reconstruction of Transcriptional regulatory Networks and analysis of regulons.

Clarice Groeneveld [ctb], Gordon Robertson [ctb], Xin Wang [aut], Michael Fletcher [aut], Florian Markowetz [aut], Kerstin Meyer [aut], and Mauro Castro [aut].

#### 25 February 2026

#### Abstract

A transcriptional regulatory network (TRN) consists of a collection of regulated target genes and transcription factors (TFs). The TFs recognize specific DNA sequences and influence gene expression across the genome, either activating or repressing the expression of target genes. The set of genes controlled by a given TF forms a *regulon*. The RTN package provides classes and methods for the reconstruction of TRNs and analysis of regulons. New computational frameworks are also available from [RTNduals](http://bioconductor.org/packages/RTNduals/) and [RTNsurvival](http://bioconductor.org/packages/RTNsurvival/) packages.

#### Package

RTN 2.34.1

# Contents

* [1 Overview](#overview)
* [2 Quick Start](#quick-start)
  + [2.1 Transcriptional Network Inference (TNI)](#transcriptional-network-inference-tni)
  + [2.2 Transcriptional Network Analysis (TNA)](#transcriptional-network-analysis-tna)
* [3 TCGA-BRCA case study](#tcga-brca-case-study)
  + [3.1 Context](#context)
  + [3.2 Package and data requirements](#package-and-data-requirements)
  + [3.3 Data preprocessing](#data-preprocessing)
  + [3.4 Inferring the transcriptional regulatory network](#inferring-the-transcriptional-regulatory-network)
  + [3.5 How to select the significance level when inferring regulons from different cohorts](#how-to-select-the-significance-level-when-inferring-regulons-from-different-cohorts)
* [4 METABRIC case study](#metabric-case-study)
  + [4.1 Context](#context-1)
  + [4.2 Package and data requirements](#package-and-data-requirements-1)
  + [4.3 Regulon activity profiles](#regulon-activity-profiles)
* [5 Assessing samples with regulons calculated from a different cohort](#assessing-samples-with-regulons-calculated-from-a-different-cohort)
* [6 Citation](#citation)
* [7 Session information](#session-information)
* [References](#references)

# 1 Overview

The **RTN** package is designed for the reconstruction of TRNs and analysis of regulons using mutual information (MI) (Fletcher et al. [2013](#ref-Fletcher2013)). It is implemented by S4 classes in *R* (R Core Team [2012](#ref-Rcore)) and extends several methods previously validated for assessing regulons, *e.g.* MRA (Carro et al. [2010](#ref-Carro2010)), GSEA (Subramanian et al. [2005](#ref-Subramanian2005)), and EVSE (Castro et al. [2016](#ref-Castro2016)). The package tests the association between a given TF and all potential targets using either RNA-Seq or microarray transcriptome data. It is tuned to deal with large gene expression datasets in order to build transcriptional regulatory units that are centered on TFs. **RTN** allows a user to set the stringency of the analysis in a stepwise process, including a bootstrap routine designed to remove unstable associations. Parallel data processing is available for steps that benefit from high-performance computing.

# 2 Quick Start

## 2.1 Transcriptional Network Inference (TNI)

The **TNI** pipeline starts with the generic function `tni.constructor()` and creates a `TNI-class` object, which provides methods for TRN inference from high-throughput gene expression data. The `tni.constructor` takes in a matrix of normalized gene expression and the corresponding gene and sample annotations, as well as a list of regulators to be evaluated. Here, the gene expression matrix and annotations are available in the `tniData` dataset, which was extracted, pre-processed and size-reduced from Fletcher et al. ([2013](#ref-Fletcher2013)) and Curtis et al. ([2012](#ref-Curtis2012)). This dataset consists of a list with 3 objects: a named gene expression matrix (`tniData$expData`), a data frame with gene annotations (`tniData$rowAnnotation`), and a data frame with sample annotations (`tniData$colAnnotation`). We will use this dataset to demonstrate the construction of a small TRN that has only 5 regulons. In general, though, we recommend building regulons for all TFs annotated for a given species; please see the *case study* sections for additional recommendations.

The `tni.constructor` method will check the consistency of all the given arguments. The **TNI** pipeline is then executed in three steps: (i) compute MI between a regulator and all potential targets, removing non-significant associations by permutation analysis; (ii) remove unstable interactions by bootstrapping; and (iii) apply the ARACNe algorithm. Additional comments are provided throughout the examples.

```
library(RTN)
data(tniData)
```

```
# Input 1: 'expData', a named gene expression matrix (genes on rows, samples on cols);
# Input 2: 'regulatoryElements', a vector listing genes regarded as TFs
# Input 3: 'rowAnnotation', an optional data frame with gene annotation
# Input 4: 'colAnnotation', an optional data frame with sample annotation
tfs <- c("FOXM1","E2F2","E2F3","RUNX2","PTTG1")
rtni <- tni.constructor(expData = tniData$expData,
                        regulatoryElements = tfs,
                        rowAnnotation = tniData$rowAnnotation,
                        colAnnotation = tniData$colAnnotation)
# p.s. alternatively, 'expData' can be a 'SummarizedExperiment' object
```

Then the `tni.permutation()` function takes the pre-processed `TNI-class` object and returns a TRN inferred by permutation analysis (with corrections for multiple hypothesis testing).

```
# Please set nPermutations >= 1000
rtni <- tni.permutation(rtni, nPermutations = 100)
```

Unstable interactions are subsequently removed by bootstrap analysis using the `tni.bootstrap()` function, which creates a consensus bootstrap network, referred here as `refnet` (reference network).

```
rtni <- tni.bootstrap(rtni)
```

At this stage each target in the TRN may be linked to multiple TFs. Because regulation can occur by both direct (TF-target) and indirect interactions (TF-TF-target), the pipeline next applies the ARACNe algorithm (Margolin, Nemenman, et al. [2006](#ref-Margolin2006a)) to remove the weakest interaction in any triplet formed by two TFs and a common target gene, preserving the dominant TF-target pair (Meyer, Lafitte, and Bontempi [2008](#ref-Meyer2008)). The ARACNe algorithm uses the data processing inequality (DPI) theorem to enrich the regulons with direct TF-target interactions, creating a DPI-filtered TRN, referred here as `tnet` (transcriptional network). For additional details, please refer to Margolin, Wang, et al. ([2006](#ref-Margolin2006b)) and Fletcher et al. ([2013](#ref-Fletcher2013)). Briefly, consider three random variables, `X`, `Y` and `Z` that form a network triplet, with `X` interacting with `Z` only through `Y` (*i.e.*, the interaction network is `X->Y->Z`), and no alternative path exists between `X` and `Z`). The DPI theorem states that the information transferred between `Y` and `Z` is always larger than the information transferred between `X` and `Z`. Based on this assumption, the ARACNe algorithm scans all triplets formed by two regulators and one target and removes the edge with the smallest MI value of each triplet, which is regarded as a redundant association.

```
rtni <- tni.dpi.filter(rtni)
```

For a summary of the resulting regulatory network we recommend using the `tni.regulon.summary()` function. From the summary below, we can see the number of regulons, the number of inferred targets and the regulon size distribution.

```
tni.regulon.summary(rtni)
## Regulatory network comprised of 5 regulons.
## -- DPI-filtered network:
## regulatoryElements            Targets              Edges
##                  5               1126               1287
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##      77     231     317     257     327     335
## -- Reference network:
## regulatoryElements            Targets              Edges
##                  5               1126               2396
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##      77     445     598     479     626     650
## ---
```

The `tni.regulon.summary()` function also lets us get detailed information about a specific regulon, including the number of positive and negative targets. Please use this information as an initial guide in assessing the set of regulons. Usually small regulons (<15 targets) are not useful for most downstream methods, and highly unbalanced regulons (*e.g.* those with only positive targets) provide unstable activity readouts.

```
tni.regulon.summary(rtni, regulatoryElements = "FOXM1")
## The FOXM1 regulon has 231 targets, it's a large and balanced regulon.
## -- DPI filtered network targets:
##    Total Positive Negative
##      231      126      105
## -- Reference network targets:
##    Total Positive Negative
##      598      353      245
## -- Regulators with mutual information:
## E2F2, E2F3, PTTG1
##
## ---
```

All results available in the `TNI-class` object can be retrieved using the `tni.get()` accessory function. For example, setting `what = 'regulons.and.mode'` will return a list with regulons, including the weight assigned for each interaction.

```
regulons <- tni.get(rtni, what = "regulons.and.mode", idkey = "SYMBOL")
head(regulons$FOXM1)
##   C1orf106        HBB       MAPT       HBA2       FOSB       CBX2
##  0.1321503 -0.1378999 -0.2063462 -0.1029147 -0.1271561  0.1762198
```

The absolute value of a weight represents the MI value, while the sign (+/-) indicates the predicted mode of action based on the Pearson’s correlation between the regulator and its targets.

## 2.2 Transcriptional Network Analysis (TNA)

In the previous section we outlined the **TNI** pipeline, which calculates a TRN and makes information available on its regulons. Here, we describe the **TNA** pipeline, which provides methods for doing enrichment analysis over a list of regulons. The **TNA** pipeline starts with the function `tni2tna.preprocess()`, converting the `TNI-class` into a `TNA-class` object. Then regulons will be tested for association with a given gene expression signature, provided here in the `tnaData` dataset. Note that the dataset in this vignette should be used for demonstration purposes only. It consists of a list with 3 objects: a named numeric vector with log2 fold changes from a differential gene expression analysis, called here a ‘phenotype’ (`tnaData$phenotype`), a character vector listing the differentially expressed genes (`tnaData$hits`), and a data frame with gene annotations mapped to the phenotype (`tnaData$phenoIDs`).

```
# Input 1: 'object', a TNI object with regulons
# Input 2: 'phenotype', a named numeric vector, usually log2 differential expression levels
# Input 3: 'hits', a character vector, usually a set of differentially expressed genes
# Input 4: 'phenoIDs', an optional data frame with gene anottation mapped to the phenotype
data(tnaData)
rtna <- tni2tna.preprocess(object = rtni,
                           phenotype = tnaData$phenotype,
                           hits = tnaData$hits,
                           phenoIDs = tnaData$phenoIDs)
```

The `tna.mra()` function takes the `TNA-class` object and runs the Master Regulator Analysis (MRA) (Carro et al. [2010](#ref-Carro2010)) over a list of regulons (with corrections for multiple hypothesis testing). The MRA assesses the overlap between each regulon and the genes listed in the `hits` argument.

```
# Run the MRA method
rtna <- tna.mra(rtna)
```

All results available in the `TNA-class` object can be retrieved using the `tna.get()` accessory function; setting `what = 'mra'` will return a data frame listing the total number of genes in the TRN (`Universe.Size`), the number of targets in each regulon (`Regulon.Size`), the number of genes listed in the `hits` argument (`Total.Hits`), the expected overlap between a given regulon and the ‘hits’ (`Expected.Hits`), the observed overlap between a given regulon and the ‘hits’ (`Observed.Hits`), the statistical significance of the observed overlap assessed by the `phyper()` function (`Pvalue`), and the adjusted P-value (`Adjusted.Pvalue`).

```
# Get MRA results;
#..setting 'ntop = -1' will return all results, regardless of a threshold
mra <- tna.get(rtna, what="mra", ntop = -1)
head(mra)
##      Regulon Universe.Size Regulon.Size Total.Hits Expected.Hits Observed.Hits
## 1870    E2F2          5304          317        660         39.45            80
## 2305   FOXM1          5304          231        660         28.74            59
## 9232   PTTG1          5304          335        660         41.69            73
## 1871    E2F3          5304          327        660         40.69            58
## 860    RUNX2          5304           77        660          9.58             7
##       Pvalue Adjusted.Pvalue
## 1870 9.3e-11         4.6e-10
## 2305 2.1e-08         5.2e-08
## 9232 5.0e-07         8.4e-07
## 1871 2.6e-03         3.3e-03
## 860  8.6e-01         8.6e-01
```

As a complementary approach, the `tna.gsea1()` function runs the one-tailed gene set enrichment analysis (GSEA-1T) to find regulons associated with a particular ‘response’, which is represented by a ranked list of genes generated from a differential gene expression signature (*i.e.* the ‘phenotype’ included in the TNI-to-TNA preprocessing step). Here the regulon’s target genes are considered a gene set, which is evaluated against the phenotype. The GSEA-1T uses a rank-based scoring metric in order to test the association between the gene set and the phenotype (Subramanian et al. [2005](#ref-Subramanian2005)).

```
# Run the GSEA method
# Please set nPermutations >= 1000
rtna <- tna.gsea1(rtna, nPermutations=100)
```

Setting `what = 'gsea1'` in the `tna.get()` accessory function will retrive a data frame listing the GSEA statistics, and the corresponding GSEA plots can be generated using the `tna.plot.gsea1()` function (**Figure 2**).

```
# Get GSEA results
gsea1 <- tna.get(rtna, what="gsea1", ntop = -1)
head(gsea1)
##      Regulon Regulon.Size Observed.Score     Pvalue Adjusted.Pvalue
## 1870    E2F2          317           0.68 3.0071e-31      1.5036e-30
## 2305   FOXM1          231           0.68 1.8643e-24      4.6607e-24
## 9232   PTTG1          334           0.65 1.5674e-22      2.6123e-22
## 1871    E2F3          327           0.61 2.2079e-19      2.7599e-19
## 860    RUNX2           77           0.44 1.9802e-01      1.9802e-01
```

```
# Plot GSEA results
tna.plot.gsea1(rtna, labPheno="abs(log2 fold changes)", ntop = -1)
```

![title](data:image/png;base64...)
**Figure 2.** GSEA analysis showing genes in each regulon (vertical bars) ranked by differential gene expression analysis (phenotype). This toy example illustrates the output from the **TNA** pipeline evaluated by the `tna.gsea1()` function.

The GSEA-1T, however, does not indicate the direction of the association. Next the **TNA** pipeline uses the two-tailed GSEA (GSEA-2T) approach to test whether the regulon is positively or negatively associated with the phenotype. The `tna.gsea2()` function separates the regulon into positive and negative targets (based on Pearson’s correlation between the TF and its targets), and then assesses the distribution of the targets across the ranked list of genes.

```
# Run the GSEA-2T method
# Please set nPermutations >= 1000
rtna <- tna.gsea2(rtna, nPermutations = 100)
```

Setting `what = 'gsea2'` in the `tna.get()` accessory function will retrieve a data frame listing the GSEA-2T statistics, and the corresponding GSEA plots can be generated using the `tna.plot.gsea2()` function.

```
# Get GSEA-2T results
gsea2 <- tna.get(rtna, what = "gsea2", ntop = -1)
head(gsea2$differential)
##      Regulon Regulon.Size Observed.Score     Pvalue Adjusted.Pvalue
## 9232   PTTG1          334           1.13 0.00040413       0.0020206
## 1870    E2F2          317           0.43 0.16832000       0.3217800
## 2305   FOXM1          231           0.41 0.20792000       0.3217800
## 1871    E2F3          327           0.10 0.25743000       0.3217800
## 860    RUNX2           77           0.33 0.45545000       0.4554500
```

In GSEA-2T (**Figure 3**), a regulon’s positive and negative targets are each considered as separate *pos* and *neg* gene sets, which are then evaluated against the phenotype. For each gene set (*pos* and *neg*) a walk down the ranked list is performed, stepwise. When a gene in the gene set is found, its position is marked in the ranked list. A running sum, shown as the pink and blue (*pos* and *neg* gene sets, respectively) lines, increases when the gene at that position belongs to the gene set and decreases when it doesn’t. The maximum distance of each running sum from the x-axis represents the enrichment score. GSEA-2T produces two per-phenotype enrichment scores (ES), whose difference (dES = ES*pos* - ES*neg*) represents the regulon activity. The goal is to assess whether the target genes are overrepresented among the genes that are more positively or negatively differentially expressed. A large positive dES indicates an induced (activated) regulon, while a large negative dES indicates a repressed regulon. Please refer to Campbell et al. ([2016](#ref-Campbell2016)) and Campbell et al. ([2018](#ref-Campbell2018)) for cases illustrating the use of this approach; an extension of the GSEA-2T to single samples was implemented by Castro et al. ([2016](#ref-Castro2016)) and Groeneveld et al. ([2019](#ref-Groeneveld2019)).

```
# Plot GSEA-2T results
tna.plot.gsea2(rtna, labPheno="log2 fold changes", tfs="PTTG1")
```

![title](data:image/png;base64...)
**Figure 3.** Two-tailed GSEA analysis showing regulon’s positive or negative targets (red/blue vertical bars) ranked by differential gene expression analysis (phenotype). This toy example illustrates the output from the **TNA** pipeline evaluated by the `tna.gsea2()` function (Campbell et al. ([2016](#ref-Campbell2016)) and Campbell et al. ([2018](#ref-Campbell2018)) provide examples on how to interpret results from this method).

# 3 TCGA-BRCA case study

## 3.1 Context

Here we show how to prepare input data for the **RTN** package using publicly available mRNA-seq data, and clinical/molecular data for the TCGA-BRCA cohort. We show how to download harmonized GRCh38/hg38 data from the Genomic Data Commons (GDC) using the **TCGAbiolinks** package (Colaprico et al. [2016](#ref-Colaprico2016)). The preprocessing will generate a `SummarizedExperiment` object that contains gene expression data, which we will then use to compute BRCA-specific regulons.

## 3.2 Package and data requirements

Please ensure you have installed all libraries before proceeding.

```
library(RTN)
library(TCGAbiolinks)
library(SummarizedExperiment)
library(TxDb.Hsapiens.UCSC.hg38.knownGene)
library(snow)
```

## 3.3 Data preprocessing

We’ll use the Bioconductor package **TCGAbiolinks** to query and download from the GDC. We want the GRCh38/hg38 harmonized, normalized RNA-seq data for the TCGA-BRCA cohort. **TCGAbiolinks** will create a directory called GDCdata in your working directory and will save into it the files downloaded from the GDC. The files for each patient will be downloaded in a separate file, and we will use a subset of 500 cases for demonstration purposes only. As a large number of mRNA-seq text files will be downloaded, totaling >140 MB, the download can take a while. Then, the `GDCprepare()` function will compile the files into an R object of class `RangedSummarizedExperiment`. The `RangedSummarizedExperiment` has 6 slots. The most important are `rowRanges` (gene annotation), `colData` (sample annotation), and `assays`, which contains the gene expression matrix.

```
# Set GDCquery for the TCGA-BRCA cohort
# Gene expression data will be aligned against hg38
query <- GDCquery(project = "TCGA-BRCA",
                  data.category = "Transcriptome Profiling",
                  data.type = "Gene Expression Quantification",
                  workflow.type = "HTSeq - FPKM-UQ",
                  sample.type = c("Primary solid Tumor"))

# Get a subset for demonstration (n = 500 cases)
cases <- getResults(query, cols = "cases")
cases <- sample(cases, size = 500)
query <- GDCquery(project = "TCGA-BRCA",
                  data.category = "Transcriptome Profiling",
                  data.type = "Gene Expression Quantification",
                  workflow.type = "HTSeq - FPKM-UQ",
                  sample.type = c("Primary solid Tumor"),
                  barcode = cases)
GDCdownload(query)
tcgaBRCA_mRNA_data <- GDCprepare(query)
```

The object downloaded from the GDC contains gene-level expression data that include both coding and noncoding genes (*e.g.* lncRNAs). We will filter these, retaining only genes annotated in the UCSC hg38 gene list (~30,000 genes).

```
# Subset by known gene locations
geneRanges <- genes(TxDb.Hsapiens.UCSC.hg38.knownGene)
tcgaBRCA_mRNA_data <- subsetByOverlaps(tcgaBRCA_mRNA_data, geneRanges)
```

```
nrow(rowData(tcgaBRCA_mRNA_data))
## [1] ~30,000
```

Finally, we’ll simplify names in the cohort annotation for better summarizations in the subsequent RTN functions. When this step has been run, the `tcgaBRCA_mRNA_data` object is ready for the *TNI* pipeline. Please ensure that you save the `tcgaBRCA_mRNA_data` object in an appropriated folder.

```
# Change column names in gene annotation for better summarizations
colnames(rowData(tcgaBRCA_mRNA_data)) <- c("ENSEMBL", "SYMBOL", "OG_ENSEMBL")
```

```
# Save the preprocessed data for subsequent analyses
save(tcgaBRCA_mRNA_data, file = "tcgaBRCA_mRNA_data_preprocessed.RData")
```

## 3.4 Inferring the transcriptional regulatory network

Next we will generate regulons for the TCGA-BRCA cohort, following the steps described in the *Quick Start* section. For the regulon reconstruction, we will use a comprehensive list of regulators available in the `tfsData` dataset, comprising 1612 TFs compiled from Lambert et al. ([2018](#ref-Lambert2018)). This pipeline should be used on data sets containing at least 100 transcriptome profiles. This represents an empirical lower bound for the ARACNe algorithm (Margolin, Wang, et al. [2006](#ref-Margolin2006b)).

```
# Load TF annotation
data("tfsData")
```

```
# Check TF annotation:
# Intersect TFs from Lambert et al. (2018) with gene annotation
# from the TCGA-BRCA cohort
geneannot <- rowData(tcgaBRCA_mRNA_data)
regulatoryElements <- intersect(tfsData$Lambert2018$SYMBOL, geneannot$SYMBOL)
```

```
# Run the TNI constructor
rtni_tcgaBRCA <- tni.constructor(expData = tcgaBRCA_mRNA_data,
                                 regulatoryElements = regulatoryElements)
```

We can offer some general practical guidance. To compute a large regulatory network we recommend using a multithreaded mode with the **snow** package. As minimum computational resources, we suggest a processor with >= 4 cores and RAM >= 8 GB per core (you should adjust specific routines to suit your available resources). The `makeCluster()` function will set the number of nodes to create on the local machine, making a `cluster` object available for the `TNI-class` methods. For example, it should take ~3h to reconstruct 1600 regulons from a gene expression matrix with ~30,000 genes and 500 samples when running on a 2.9 GHz Core i9-8950H workstation with 32GB DDR4 RAM. Please note that running large datasets in parallel can consume all the system memory. We recommend monitoring the parallelization to avoid working too close to the memory ceiling; the `parChunks` argument available in the `tni.permutation()` and `tni.bootstrap()` functions can be used to adjust the job size sent for parallelization. Finally, for RNA-seq data we recommend using the non-parametric estimator of mutual information (default option of the `tni.permutation()` function).

```
# Compute the reference regulatory network by permutation and bootstrap analyses.
# Please set 'spec' according to your available hardware
options(cluster=snow::makeCluster(spec=4, "SOCK"))
rtni_tcgaBRCA <- tni.permutation(rtni_tcgaBRCA, pValueCutoff = 1e-7)
rtni_tcgaBRCA <- tni.bootstrap(rtni_tcgaBRCA)
stopCluster(getOption("cluster"))
```

Next we run the ARACNe algorithm with `eps = 0`, which sets the tolerance for removing the edge with the smallest weight in each triplet. For example, the `XY` edge in the `XYZ` triplet is removed if its weight is below `YZ - eps` and `XZ - eps` (see comments in *section 2.1* and the `aracne()` function documentation). Empirically, values between 0 (no tolerance) and 0.15 should be used (Margolin, Wang, et al. [2006](#ref-Margolin2006b)). As a less arbitrary approach we suggest setting `eps = NA`, which will estimate the threshold from the null distribution computed in the permutation and bootstrap steps.

```
# Compute the DPI-filtered regulatory network
rtni_tcgaBRCA <- tni.dpi.filter(rtni_tcgaBRCA, eps = 0)
```

```
# Save the TNI object for subsequent analyses
save(rtni_tcgaBRCA, file="rtni_tcgaBRCA.RData")
```

The choice of `pValueCutoff` threshold will depend on the desired tradeoff between false positives and false negatives. A sensible `pValueCutoff` threshold can be selected *a priori* by dividing the desired expected number of false positives by the number of tested TF-target interactions (Margolin, Wang, et al. [2006](#ref-Margolin2006b)). For example, in this example we tested about 5e+7 TF-target interactions (*i.e.* ~1,600 TFs vs. ~30,000 genes); therefore a `pValueCutoff` threshold of 1e-7 should result in about 5 false positives.

Note that some level of missing annotation is expected, as not all gene symbols listed in the `regulatoryElements` might be available in the TCGA-BRCA preprocessed data. Also, data that are inconsistent with the calculation may be removed in the `tni.constructor` preprocess. For example, if a gene’s expression does not vary across a cohort, it is not possible to associate this gene’s expression with the expression of other genes in the cohort. As an extreme case, genes that exhibit no variability (*e.g.* that are not expressed in all samples) are excluded from the analysis. For a summary of the resulting regulatory network we recommend using the `tni.regulon.summary()` function (see the *Quick Start* section).

Note also that the MI metric is based on a gene’s expression varying across a cohort. Large cohorts of tumour samples typically contain multiple molecular subtypes, and typically provide good expression variability for building regulons. In contrast, sample sets that are more homogeneous may be more challenging to explore with regulons, and this may be the case with sets of normal, non-cancerous samples. We do not recommend computing regulons for sample sets of low expression variability.

## 3.5 How to select the significance level when inferring regulons from different cohorts

An important challenge in comparing regulatory information for different cohorts is to generate regulons under similar statistical conditions in each cohort. For example, say cohort *A* has gene expression data for 300 samples and *B* for 100 samples. In each cohort, we’d infer regulons with **RTN** by running four sequential steps: `tni.constructor()` to check the input data; `tni.permutation()`, where we’d set a `pValueCutoff` for the mutual information (MI) between expression profiles for pairs of genes; `tni.bootstrap()`, which assesses the stability of MI; and finally `tni.dpi.filter()`, which enhances direct regulator-target interactions.

If we set a permutation `pValueCutoff = 1e-5` to infer regulons for *A*, what should be our choice of `pValueCutoff` for *B*? The issue here is that the p-value is an inverse function of the sample size; that is, for a smaller cohort we should use a larger (less stringent) p-value. Ideally, sample size for a second cohort should be determined *a priori*, but this is seldom an option, as regulons are typically reconstructed from large retrospective cohort studies.

For RTN regulons, the ‘effect size’ is the MI value between a regulator and a potential target gene, and our null hypothesis is that the expression profiles for a regulator and a potential target gene have a statistically non-significant relationship; so, for this regulator, the transcriptional network should not retain this target gene. In general, and in RTN’s MI permutation calculations, the p-value threshold controls the rate of Type I errors (*i.e.* when we reject a true null hypothesis, creating a false positive result), but it also affects the rate of Type II errors (when we fail to reject a false null hypothesis, creating a false negative result) (Miller [2019](#ref-Miller2019)). Type I and Type II error rates are denoted by α and β, respectively, and the power of a statistical test is defined as 1 - β. Decreasing α increases β and vice-versa (Mudge et al. [2012](#ref-Mudge2012)). Because α determines the power to detect a given effect size, the choice of a `pValueCutoff` makes implicit decisions about β; that is, about the true regulatory interactions that **RTN** will likely consider non-significant, and so will reject. When it comes to assessing the regulatory commonalities between regulons reconstructed from two different cohorts (*e.g.* *A* and *B*), failing to detect a real effect only in *A* should be considered as serious an error as falsely detecting a non-existent effect only in *B*. To minimize the risk of such problems we suggest adjusting α by looking at the tradeoff between Type I and Type II errors. Mudge et al. ([2012](#ref-Mudge2012)) developed R code to calculate optimal α levels for correlations; we adapted this code by implementing the `tni.alpha.adjust()` function to assist choosing the `pValueCutoff` when analyzing datasets with different numbers of samples.

```
# For example, to estimate 'alphaB' for 'nB', given 'nA', 'alphaA', and 'betaA'
alphaB <- tni.alpha.adjust(nB = 100, nA = 300, alphaA = 1e-5, betaA = 0.2)
alphaB
# [1] 0.029
```

For the second cohort *B*, we suggest using a value close to `alphaB` for the `pValueCutoff` in the `tni.permutation()` function (and for cohort *A*, `alphaA`), in order that **RTN** will return regulon results that have been generated with similar tradeoffs between Type I and Type II errors for both cohorts.

# 4 METABRIC case study

## 4.1 Context

Fletcher et al. ([2013](#ref-Fletcher2013)) reconstructed regulons for 809 transcription factors (TFs) using microarray transcriptomic data from the METABRIC breast cancer cohort (Curtis et al. [2012](#ref-Curtis2012)). Castro et al. ([2016](#ref-Castro2016)) found that 36 of these TF regulons were associated with genetic risk of breast cancer. The risk TFs were in two distinct clusters. The “cluster 1” risk TFs were associated with estrogen receptor-positive (ER+) breast cancer risk, and included ESR1, FOXA1, and GATA3, whereas the “cluster 2” risk TFs were associated with estrogen receptor-negative (ER-), basal-like breast cancer. Our goal here is to demonstrate how to generate regulon activity profiles for individual tumour samples, using the regulons reconstructed by Fletcher et al. ([2013](#ref-Fletcher2013)) for the 36 risk TFs.

## 4.2 Package and data requirements

Please ensure you have installed all libraries before proceeding. The **Fletcher2013b** data package is available from the R/Bioconductor repository. Installing and then loading this package will make available all data required for this case study. The `rtni1st` dataset is a pre-processed `TNI-class` object that includes the regulons reconstructed by Fletcher et al. ([2013](#ref-Fletcher2013)) and a gene expression matrix for the METABRIC cohort 1 (n=997 primary tumors).

```
library(RTN)
library(Fletcher2013b)
library(pheatmap)
```

```
# Load 'rtni1st' data object, which includes regulons and expression profiles
data("rtni1st")
```

```
# A list of transcription factors of interest (here 36 risk-associated TFs)
risk.tfs <- c("AFF3", "AR", "ARNT2", "BRD8", "CBFB", "CEBPB", "E2F2", "E2F3", "ENO1", "ESR1", "FOSL1", "FOXA1", "GATA3", "GATAD2A", "LZTFL1", "MTA2", "MYB", "MZF1", "NFIB", "PPARD", "RARA", "RB1", "RUNX3", "SNAPC2", "SOX10", "SPDEF", "TBX19", "TCEAL1", "TRIM29", "XBP1", "YBX1", "YPEL3", "ZNF24", "ZNF434", "ZNF552", "ZNF587")
```

## 4.3 Regulon activity profiles

Regulon activity profiles (RAPs) characterize regulatory program similarities and differences between samples in a cohort. In order to assess a large number of samples, we implemented a function that computes the two-tailed GSEA for an entire cohort (additional details are provided in Groeneveld et al. ([2019](#ref-Groeneveld2019))). Briefly, for each regulon, the `tni.gsea2()` function estimates a regulon activity score for each sample available in the `TNI-class` object. For each gene in a sample, a differential gene expression is calculated from its expression in the sample relative to its average expression in the cohort; the genes are then ordered as a ranked list representing a differential gene expression signature in that sample, which is used to run the GSEA-2T as explained in `tna.gsea2` method (see *section 2.2*).

```
# Compute regulon activity for individual samples
rtni1st <- tni.gsea2(rtni1st, regulatoryElements = risk.tfs)
metabric_regact <- tni.get(rtni1st, what = "regulonActivity")
```

The `tni.gsea2` returns a list with the calculated enrichment scores: ES*pos*, ES*neg* and dES, which represents the regulon activity of individual samples. Next, the **pheatmap** package is used to generate a heatmap showing RAPs along with some sample attributes (**Figure 4**).

```
# Get sample attributes from the 'rtni1st' dataset
metabric_annot <- tni.get(rtni1st, "colAnnotation")
# Get ER+/- and PAM50 attributes for pheatmap
attribs <- c("LumA","LumB","Basal","Her2","Normal","ER+","ER-")
metabric_annot <- metabric_annot[,attribs]
```

```
# Plot regulon activity profiles
pheatmap(t(metabric_regact$dif),
         main="METABRIC cohort 1 (n=977 samples)",
         annotation_col = metabric_annot,
         show_colnames = FALSE, annotation_legend = FALSE,
         clustering_method = "ward.D2", fontsize_row = 6,
         clustering_distance_rows = "correlation",
         clustering_distance_cols = "correlation")
```

![title](data:image/png;base64...)
**Figure 4.** Regulon activity profiles of individual tumour samples from the METABRIC cohort 1 (for an example where this approach has been used, please see Figures 4A and 5A from Robertson et al. ([2017](#ref-Robertson2017))).

# 5 Assessing samples with regulons calculated from a different cohort

You may want to assess transcriptome data for a set of samples from cohort B against regulons that you have previously calculated for cohort A. For example, cohort A may be large enough to support inferring regulons, while cohort B may be too small for these calculations. Alternatively, you may wish to compare regulon results between two cohorts (see **Figures 4** and **5**).

The `tni.replace.samples()` function is the entry point for assessing new samples with previously calculated regulons. This function will require an existing `TNI-class` object from cohort A, whose gene expression matrix and sample annotation will be replaced by cohort B. The `tni.replace.samples` will check all the given arguments, particularly the consistency of gene annotations between the two datasets. Next we show how to generate RAPs for TCGA-BRCA samples using the regulons reconstructed for METABRIC cohort 1 by Fletcher et al. ([2013](#ref-Fletcher2013)).

```
# Replace samples
rtni1st_tcgasamples <- tni.replace.samples(rtni1st, tcgaBRCA_mRNA_data)
```

```
# Compute regulon activity for the new samples
rtni1st_tcgasamples <- tni.gsea2(rtni1st_tcgasamples, regulatoryElements = risk.tfs)
tcga_regact <- tni.get(rtni1st_tcgasamples, what = "regulonActivity")
```

```
# Get sample attributes from the 'rtni1st_tcgasamples' dataset
tcga_annot <- tni.get(rtni1st_tcgasamples, "colAnnotation")
# Adjust PAM50 attributes for pheatmap
tcga_annot <- within(tcga_annot,{
  'LumA' = ifelse(subtype_BRCA_Subtype_PAM50%in%c("LumA"),1,0)
  'LumB' = ifelse(subtype_BRCA_Subtype_PAM50%in%c("LumB"),1,0)
  'Basal' = ifelse(subtype_BRCA_Subtype_PAM50%in%"Basal",1,0)
  'Her2' = ifelse(subtype_BRCA_Subtype_PAM50%in%c("Her2"),1,0)
  'Normal' = ifelse(subtype_BRCA_Subtype_PAM50%in%c("Normal"),1,0)
})
attribs <- c("LumA","LumB","Basal","Her2","Normal")
tcga_annot <- tcga_annot[,attribs]
```

```
# Plot regulon activity profiles
pheatmap(t(tcga_regact$dif),
         main="TCGA-BRCA cohort subset (n=500 samples)",
         annotation_col = tcga_annot,
         show_colnames = FALSE, annotation_legend = FALSE,
         clustering_method = "ward.D2", fontsize_row = 6,
         clustering_distance_rows = "correlation",
         clustering_distance_cols = "correlation")
```

![title](data:image/png;base64...)
**Figure 5.** Regulon activity profiles of individual tumour samples for a subset (n=500) of the TCGA-BRCA cohort using regulons reconstructed by Fletcher et al. ([2013](#ref-Fletcher2013)) (for an example where this approach has been used, please see Figure S7A-F from Corces et al. ([2018](#ref-Corces2018))).

The unsupervised hierarchical clustering in **Figure 5** is obtained using RAPs from 500 samples of the TCGA-BRCA cohort for the set of 36 regulons calculated from the METABRIC cohort 1. Despite the different cohorts, and different technologies used to quantify gene expression on these cohorts (TCGA used RNA-seq, while METABRIC used microarrays), the luminal, basal and Her2 covariate tracks indicate that the RAPs in **Figures 4** and **5** return similar clustering structure.

# 6 Citation

The RTN, RTNsurvival and RTNduals packages provide methods that were implemented by the authors and contributors. When using these packages in publications, please cite the appropriate papers that introduced the methods and analysis pipelines.

When using the TNI and TNA analysis pipelines:

* Fletcher MNC *et al.*, Master regulators of FGFR2 signalling and breast cancer risk. *Nature Communications*, 4:2464, 2013. doi: [10.1038/ncomms3464](https://doi.org/10.1038/ncomms3464)

When using the GSEA-2T method to estimate regulon activity:

* Castro MAA *et al.*, Regulators of genetic risk of breast cancer identified by integrative network analysis. *Nature Genetics*, 48(1):12-21, 2016. doi: [10.1038/ng.3458](https://doi.org/10.1038/ng.3458)
* Campbell TM *et al.*, FGFR2 risk SNPs confer breast cancer risk by augmenting oestrogen responsiveness. *Carcinogenesis*, 37(8):741-750, 2016. doi: [10.1093/carcin/bgw065](https://doi.org/10.1093/carcin/bgw065)

When using RAPs to characterize regulatory similarities and differences between samples in a cohort:

* Robertson AG *et al.*, Comprehensive Molecular Characterization of Muscle-Invasive Bladder Cancer. *Cell*, 171(3):540-556, 2017. doi: [10.1016/j.cell.2017.09.007](https://doi.org/10.1016/j.cell.2017.09.007)
* Corces MR *et al.*, The chromatin accessibility landscape of primary human cancers. *Science*, 362(6413):eaav1898, 2018. doi: [10.1126/science.aav1898](https://doi.org/10.1126/science.aav1898)

When using the EVSE method to explore regulators of genetic risk:

* Castro MAA *et al.*, Regulators of genetic risk of breast cancer identified by integrative network analysis. *Nature Genetics*, 48(1):12-21, 2016. doi: [10.1038/ng.3458](https://doi.org/10.1038/ng.3458)

When using the conditional mutual information analysis pipeline to explore modulators of transcription factors:

* Campbell TM *et al.*, Identification of Post-Transcriptional Modulators of Breast Cancer Transcription Factor Activity Using MINDy. PLoS ONE 11(12):e0168770, 2016. doi: [10.1371/journal.pone.0168770](https://doi.org/10.1371/journal.pone.0168770)

When using the survival analysis pipeline to integrate RAPs with clinical variables:

* Groeneveld CS *et al.*, RTNsurvival: An R/Bioconductor package for regulatory network survival analysis. *Bioinformatics*, btz229, 2019. doi: [10.1093/bioinformatics/btz229](https://doi.org/10.1093/bioinformatics/btz229)

When using the dual-regulon analysis pipeline to search for co-regulatory associations between pairs of regulators:

* Chagas VS *et al.*, RTNduals: An R/Bioconductor package for analysis of co-regulation and inference of dual regulons. *Bioinformatics*, btz534, 2019. doi: [10.1093/bioinformatics/btz534](https://doi.org/10.1093/bioinformatics/btz534)

# 7 Session information

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] RTN_2.34.1       BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] SummarizedExperiment_1.40.0 gtable_0.3.6
##  [3] xfun_0.56                   bslib_0.10.0
##  [5] ggplot2_4.0.2               htmlwidgets_1.6.4
##  [7] Biobase_2.70.0              lattice_0.22-9
##  [9] vctrs_0.7.1                 tools_4.5.2
## [11] generics_0.1.4              stats4_4.5.2
## [13] parallel_4.5.2              tibble_3.3.1
## [15] proxy_0.4-29                pkgconfig_2.0.3
## [17] pheatmap_1.0.13             Matrix_1.7-4
## [19] KernSmooth_2.23-26          data.table_1.18.2.1
## [21] RColorBrewer_1.1-3          S7_0.2.1
## [23] S4Vectors_0.48.0            lifecycle_1.0.5
## [25] compiler_4.5.2              farver_2.1.2
## [27] viper_1.44.0                mixtools_2.0.0.1
## [29] statmod_1.5.1               Seqinfo_1.0.0
## [31] carData_3.0-6               snow_0.4-4
## [33] htmltools_0.5.9             class_7.3-23
## [35] sass_0.4.10                 yaml_2.3.12
## [37] lazyeval_0.2.2              Formula_1.2-5
## [39] plotly_4.12.0               car_3.1-5
## [41] pillar_1.11.1               jquerylib_0.1.4
## [43] tidyr_1.3.2                 MASS_7.3-65
## [45] DelayedArray_0.36.0         cachem_1.1.0
## [47] limma_3.66.0                RedeR_3.6.2
## [49] abind_1.4-8                 nlme_3.1-168
## [51] tidyselect_1.2.1            digest_0.6.39
## [53] dplyr_1.2.0                 purrr_1.2.1
## [55] kernlab_0.9-33              bookdown_0.46
## [57] splines_4.5.2               fastmap_1.2.0
## [59] grid_4.5.2                  SparseArray_1.10.8
## [61] cli_3.6.5                   magrittr_2.0.4
## [63] S4Arrays_1.10.1             dichromat_2.0-0.1
## [65] survival_3.8-6              e1071_1.7-17
## [67] scales_1.4.0                minet_3.68.0
## [69] segmented_2.2-1             XVector_0.50.0
## [71] rmarkdown_2.30              httr_1.4.8
## [73] matrixStats_1.5.0           igraph_2.2.2
## [75] otel_0.2.0                  evaluate_1.0.5
## [77] pwr_1.3-0                   knitr_1.51
## [79] GenomicRanges_1.62.1        IRanges_2.44.0
## [81] viridisLite_0.4.3           rlang_1.1.7
## [83] glue_1.8.0                  BiocManager_1.30.27
## [85] BiocGenerics_0.56.0         jsonlite_2.0.0
## [87] R6_2.6.1                    MatrixGenerics_1.22.0
```

# References

Campbell, Thomas, Mauro Castro, Ines de Santiago, Michael Fletcher, Silvia Halim, Radhika Prathalingam, Bruce Ponder, and Kerstin Meyer. 2016. “FGFR2 Risk Snps Confer Breast Cancer Risk by Augmenting Oestrogen Responsiveness.” *Carcinogenesis* 37 (8): 741–50. <https://doi.org/10.1093/carcin/bgw065>.

Campbell, Thomas M., Mauro A. A. Castro, Kelin Gonçalves de Oliveira, Bruce A. J. Ponder, and Kerstin B. Meyer. 2018. “ERα Binding by Transcription Factors Nfib and Ybx1 Enables Fgfr2 Signaling to Modulate Estrogen Responsiveness in Breast Cancer.” *Cancer Research* 78 (2): 410–21. <https://doi.org/10.1158/0008-5472.CAN-17-1153>.

Carro, Maria, Wei Lim, Mariano Alvarez, Robert Bollo, Xudong Zhao, Evan Snyder, Erik Sulman, et al. 2010. “The Transcriptional Network for Mesenchymal Transformation of Brain Tumours.” *Nature* 463 (7279): 318–25. <https://doi.org/10.1038/nature08712>.

Castro, Mauro, Ines de Santiago, Thomas Campbell, Courtney Vaughn, Theresa Hickey, Edith Ross, Wayne Tilley, Florian Markowetz, Bruce Ponder, and Kerstin Meyer. 2016. “Regulators of Genetic Risk of Breast Cancer Identified by Integrative Network Analysis.” *Nature Genetics* 48: 12–21. <https://doi.org/10.1038/ng.3458>.

Colaprico, Antonio, Tiago C. Silva, Catharina Olsen, Luciano Garofano, Claudia Cava, Davide Garolini, Thais S. Sabedot, et al. 2016. “TCGAbiolinks: An R/Bioconductor Package for Integrative Analysis of Tcga Data.” *Nucleic Acids Research* 44 (8): e71. <https://doi.org/10.1093/nar/gkv1507>.

Corces, M. Ryan, Jeffrey M. Granja, Shadi Shams, Bryan H. Louie, Jose A. Seoane, Wanding Zhou, Tiago C. Silva, et al. 2018. “The Chromatin Accessibility Landscape of Primary Human Cancers.” Edited by Rehan Akbani, Christopher C. Benz, Evan A. Boyle, Bradley M. Broom, Andrew D. Cherniack, Brian Craft, John A. Demchok, et al. *Science* 362 (6413). <https://doi.org/10.1126/science.aav1898>.

Curtis, Christina, Sohrab Shah, Suet-Feung Chin, Gulisa Turashvili, Mark Rueda Oscar amd Dunning, Doug Speed, and et al. 2012. “The Genomic and Transcriptomic Architecture of 2,000 Breast Tumours Reveals Novel Subgroups.” *Nature* 486: 346–52. <https://doi.org/10.1038/nature10983>.

Fletcher, Michael, Mauro Castro, Suet-Feung Chin, Oscar Rueda, Xin Wang, Carlos Caldas, Bruce Ponder, Florian Markowetz, and Kerstin Meyer. 2013. “Master Regulators of FGFR2 Signalling and Breast Cancer Risk.” *Nature Communications* 4: 2464. <https://doi.org/10.1038/ncomms3464>.

Groeneveld, Clarice S, Vinicius S Chagas, Steven J M Jones, A Gordon Robertson, Bruce A J Ponder, Kerstin B Meyer, and Mauro A A Castro. 2019. “RTNsurvival: an R/Bioconductor package for regulatory network survival analysis.” *Bioinformatics*, March, btz229. <https://doi.org/10.1093/bioinformatics/btz229>.

Lambert, S A, A Jolma, L F Campitelli, P K Das, Y Yin, M Albu, X Chen, J Taipale, T R Hughes, and Weirauch M T. 2018. “The Human Transcription Factors.” *Cell* 172 (4): 650–65. <https://doi.org/10.1016/j.cell.2018.01.029>.

Margolin, Adam, Ilya Nemenman, Katia Basso, Chris Wiggins, Gustavo Stolovitzky, Riccardo Favera, and Andrea Califano. 2006. “ARACNE: An Algorithm for the Reconstruction of Gene Regulatory Networks in a Mammalian Cellular Context.” *BMC Bioinformatics* 7 (Suppl 1): S7. <https://doi.org/10.1186/1471-2105-7-S1-S7>.

Margolin, Adam, Kai Wang, Wei Keat Lim, Manjunath Kustagi, Ilya Nemenman, and Andrea Califano. 2006. “Reverse Engineering Cellular Networks.” *Nature Protocols* 1 (2): 662–71. <https://doi.org/10.1038/nprot.2006.106>.

Meyer, Patrick E., Frédéric Lafitte, and Gianluca Bontempi. 2008. “Minet: A R/Bioconductor Package for Inferring Large Transcriptional Networks Using Mutual Information.” *BMC Bioinformatics* 9 (1): 461. <https://doi.org/10.1186/1471-2105-9-461>.

Miller, Rolf, Jeff AND Ulrich. 2019. “The Quest for an Optimal Alpha.” *PLOS ONE* 14 (1): 1–13. <https://doi.org/10.1371/journal.pone.0208631>.

Mudge, J F, L F Baker, C B Edge, and J E Houlahan. 2012. “Setting an Optimal Alpha That Minimizes Errors in Null Hypothesis Significance Tests.” *PLoS ONE* 7 (2): e32734. <https://doi.org/10.1371/journal.pone.0032734>.

R Core Team. 2012. *R: A Language and Environment for Statistical Computing*. Vienna, Austria: R Foundation for Statistical Computing. <http://www.R-project.org/>.

Robertson, A G, Kim J, Al-Ahmadie H, Bellmunt J, Guo G, Cherniack A D, Hinoue T, et al. 2017. “Comprehensive Molecular Characterization of Muscle-Invasive Bladder Cancer.” *Cell* 171 (3): 540–56. <https://doi.org/10.1016/j.cell.2017.09.007>.

Subramanian, Aravind, Pablo Tamayo, Vamsi Mootha, Sayan Mukherjee, Benjamin Ebert, Michael Gillette, Amanda Paulovich, et al. 2005. “Gene Set Enrichment Analysis: A Knowledge-Based Approach for Interpreting Genome-Wide Expression Profiles.” *Proceedings of the National Academy of Sciences of the United States of America* 102 (43): 15545–50. <https://doi.org/10.1073/pnas.0506580102>.