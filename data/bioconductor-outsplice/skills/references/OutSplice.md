# OutSplice

Joseph Bendik, Sandhya Kalavacherla, Michael Considine, Bahman Afsari, Michael F. Ochs, Joseph Califano, Daria A. Gaykalova, Elana Fertig and Theresa Guo

#### 30 October 2025

#### Package

OutSplice 1.10.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Functionality](#functionality)
  + [1.2 Minimum required packages](#minimum-required-packages)
  + [1.3 Installation from Bioconductor](#installation-from-bioconductor)
* [2 Inputs](#inputs)
  + [2.1 outspliceAnalysis/outspliceTCGA](#outspliceanalysisoutsplicetcga)
  + [2.2 Phenotype matrix](#phenotype-matrix)
  + [2.3 plotJunctionData](#plotjunctiondata)
* [3 Methodology](#methodology)
  + [3.1 Junction RPM normalization](#junction-rpm-normalization)
  + [3.2 OGSA initial filtering](#ogsa-initial-filtering)
  + [3.3 OGSA outlier analysis](#ogsa-outlier-analysis)
  + [3.4 Genomic references](#genomic-references)
  + [3.5 Junction expression normalization](#junction-expression-normalization)
  + [3.6 Filter by expression via offsets](#filter-by-expression-via-offsets)
  + [3.7 Splice Burden Calculation](#splice-burden-calculation)
  + [3.8 Junction Plotting](#junction-plotting)
* [4 Outputs](#outputs)
  + [4.1 outSpliceAnalysis/outSpliceTCGA](#outspliceanalysisoutsplicetcga-1)
  + [4.2 plotJunctionData](#plotjunctiondata-1)
* [5 References](#references)
* **Appendix**
* [A Session Info](#session-info)

# 1 Introduction

*[OutSplice](https://bioconductor.org/packages/3.22/OutSplice)* is a package that identifies aberrant splicing events in tumor samples when compared to normal samples using outlier statistics to better characterize sporadic events occurring in heterogenous cancer samples. Events are classified as skipping, insertion, or deletion events. Additionally, outlier expression of each splicing event is called per sample allowing for evaluation of splicing burden of individual samples. This package is specifically designed to analyze RNA sequencing data provided by the user; additional functions have also been added for direct analysis from the Cancer Genome Atlas (TCGA). Packages in Bioconductor, such as the *[psichomics](https://bioconductor.org/packages/3.22/psichomics)* package, perform similar analyses on TCGA or user-generated data, however they are not specifically designed to identify cancer specific events. Because of the heterogeneity of tumors in the context of cancer biology, outlier statistics rather than mean comparisons are used to identify aberrant events, where outliers are classified on a per sample basis; this allows the algorithm to discern splicing events with outlier expression that may occur within a subset of tumor samples when compared to normal conditions. Therefore, this package generates a matrix of splicing outliers, which are associated with splice junctions that are either significantly over or under-expressed compared to the distribution of expression in normal tissue. The *[FRASER](https://bioconductor.org/packages/3.22/FRASER)* package also offers functionality to determine splicing outliers, however, *[OutSplice](https://bioconductor.org/packages/3.22/OutSplice)* utilizes a rank sum outlier approach instead of a beta binomial model. This allows for users to eliminate less biologically relevant events by setting a minimum level of event expression. Additionally, *[OutSplice](https://bioconductor.org/packages/3.22/OutSplice)* has an easy to use work-flow that makes it accessible for researchers of varying experience with bioinformatics tools. With *[OutSplice](https://bioconductor.org/packages/3.22/OutSplice)*, the junction normalization, filtering, outlier calling, and statistical analysis are done in one function call, simplifying this process for the user. *[OutSplice](https://bioconductor.org/packages/3.22/OutSplice)* is also capable of automatically calculating the splicing burden in each of the user’s samples and will provide waterfall plots of expression to help visualize individual splicing events. Overall, this package is novel in that it determines differential splicing burdens between tumors and normal samples and characterizes the nature of splicing outliers in a quick and user friendly fashion.

## 1.1 Functionality

The main functions of *[OutSplice](https://bioconductor.org/packages/3.22/OutSplice)* achieve the following for either user
provided data or data provided from the TCGA.

1. Junction normalization
2. Outlier analysis
3. Determination of a junctional outlier as a skipping, insertion, or deletion
4. Calculation of splicing burden
5. Plotting expression levels

## 1.2 Minimum required packages

*[OutSplice](https://bioconductor.org/packages/3.22/OutSplice)* will import the below packages and their dependencies so please ensure they are installed
before using the software:

1. AnnotationDbi
2. GenomicRanges
3. GenomicFeatures
4. IRanges
5. org.Hs.eg.db
6. Repitools
7. TxDb.Hsapiens.UCSC.hg19.knownGene
8. TxDb.Hsapiens.UCSC.hg38.knownGene
9. S4Vectors

## 1.3 Installation from Bioconductor

The *[OutSplice](https://bioconductor.org/packages/3.22/OutSplice)* package is available at <https://bioconductor.org> and can be
installed via BiocManager::install:

A package only needs to be installed once. Load the package into an R session with:

```
library(OutSplice)
```

# 2 Inputs

## 2.1 outspliceAnalysis/outspliceTCGA

Full Sample data for *[OutSplice](https://bioconductor.org/packages/3.22/OutSplice)* can be downloaded from The Cancer Genome Atlas (TCGA).

The outspliceAnalysis function has 4 required inputs and 13 optional Inputs.
The outspliceTCGA function has 3 required inputs and 9 optional Inputs and
should only be used if the data is in TCGA format.

In the below examples we run outspliceAnalysis and outspliceTCGA on a subset of Head
and Neck squamous cell carcinoma data obtained from The Broad Institute TCGA
GDAC Firehose database.

```
junction <- system.file("extdata", "HNSC_junctions.txt.gz", package = "OutSplice")
gene_expr <- system.file("extdata", "HNSC_genes_normalized.txt.gz", package = "OutSplice")
rawcounts <- system.file("extdata", "Total_Rawcounts.txt", package = "OutSplice")
sample_labels <- system.file("extdata", "HNSC_pheno_table.txt", package = "OutSplice")
output_file_prefix <- "OutSplice_Example"
TxDb_hg19 <- "TxDb.Hsapiens.UCSC.hg19.knownGene"
dir <- paste0(tempdir(), "/")
message("Output is located at: ", dir)
```

```
## Output is located at: /tmp/RtmpK7utiC/
```

```
results <- outspliceAnalysis(junction, gene_expr, rawcounts, sample_labels, saveOutput = TRUE, output_file_prefix, dir, filterSex = TRUE, annotation = "org.Hs.eg.db", TxDb = TxDb_hg19, offsets_value = 0.00001, correction_setting = "fdr", p_value = 0.05)
```

```
## Loading data
```

```
## pheno
## Normal  Tumor
##     44     50
```

```
## convert to RPM
```

```
## filter the putative junctions
```

```
## run the ogsa function for pre filtering
```

```
## get the genomic information for all the junctions
```

```
##   24 genes were dropped because they have exons located on both strands of the
##   same reference sequence or on more than one reference sequence, so cannot be
##   represented by a single genomic range.
##   Use 'single.strand.genes.only=FALSE' to get all the genes in a GRangesList
##   object, or use suppressMessages() to suppress this message.
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
## filtering for putative junctions, skipping, insertion and deletion events based on known exons.
```

```
## skipping
```

```
## insertions
```

```
## deletions
```

```
## remove all that map to 'NA' no gene name, and assign gene expression from gene_expr
```

```
## align with gene_expr data
```

```
## subset removing any genes without normalization
```

```
## Perform normalization using gene_expr values
```

```
## run the ogsa function
```

```
junction <- system.file("extdata", "TCGA_HNSC_junctions.txt.gz", package = "OutSplice")
gene_expr <- system.file("extdata", "TCGA_HNSC_genes_normalized.txt.gz", package = "OutSplice")
rawcounts <- system.file("extdata", "Total_Rawcounts.txt", package = "OutSplice")
output_file_prefix <- "TCGA_OutSplice_Example"
dir <- paste0(tempdir(), "/")
message("Output is located at: ", dir)
```

```
## Output is located at: /tmp/RtmpK7utiC/
```

```
results_TCGA <- outspliceTCGA(junction, gene_expr, rawcounts, saveOutput = TRUE, output_file_prefix, dir, filterSex = TRUE, annotation = "org.Hs.eg.db", TxDb = "TxDb.Hsapiens.UCSC.hg19.knownGene", offsets_value = 0.00001, correction_setting = "fdr", p_value = 0.05)
```

```
## Loading data
```

```
## pheno
## Normal  Tumor
##     44     50
```

```
## convert to RPM
```

```
## filter the putative junctions
```

```
## run the ogsa function for pre filtering
```

```
## get the genomic information for all the junctions
```

```
##   24 genes were dropped because they have exons located on both strands of the
##   same reference sequence or on more than one reference sequence, so cannot be
##   represented by a single genomic range.
##   Use 'single.strand.genes.only=FALSE' to get all the genes in a GRangesList
##   object, or use suppressMessages() to suppress this message.
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
## filtering for putative junctions, skipping, insertion and deletion events based on known exons.
```

```
## skipping
```

```
## insertions
```

```
## deletions
```

```
## remove all that map to 'NA' no gene name, and assign gene expression from gene_expr
```

```
## align with gene_expr data
```

```
## subset removing any genes without normalization
```

```
## Perform normalization using gene_expr values
```

```
## run the ogsa function
```

-junction: filepath to a matrix of junction raw read counts

-gene\_expr: filepath to a matrix of normalized gene expression data. RSEM quartile normalized data is recommended.

-rawcounts: filepath to a matrix of raw read counts for each gene. Can either be per gene, or a summed total for each sample.

-sample\_labels: filepath to a matrix of phenotypes (in Section 2.2)

-saveOutput: saves results output to a user specified directory. Default is FALSE [OPTIONAL]

-output\_file\_prefix: user defined string for what the prefix of the output file should be named. Default is NULL [OPTIONAL]

-dir: string containing the desired output path. Ex) “~/my\_outsplice\_output/”. Default is NULL [OPTIONAL]

-filtersex: ignores sex chromosomes when generating results. Default is TRUE [OPTIONAL]

-annotation: the bioconductor package containing the annotations to use. Uses the human genome by default (in Section 3.4) [OPTIONAL]

-TxDb: the bioconductor package containing the transcript annotations to use. The outspliceAnalysis function uses the hg38 genome by default, and outspliceTCGA uses hg19 by default (in Section 3.4) [OPTIONAL]

-offsets\_value: the normalized junction expression threshold. Uses 0.00001 by Default (in Section 3.6) [OPTIONAL]

-correction\_setting: the correction value to be used for p-value adjustment during Fisher analyses. The available options are: “holm”, “hochberg”, “hommel”, “bonferroni”, “BH”, “BY”, “fdr”, and “none”. Uses ‘fdr’ by Default. [OPTIONAL]

-p\_value: the significance threshold to use during Fisher analyses. Uses 0.05 by default. [OPTIONAL]

-use\_junc\_col: an integer indicating which column in the junction matrix contains the junction regions in your matricies. Uses the first column (1) by default. outSpliceAnalysis only. [OPTIONAL]

-use\_gene\_col: which column in the gene\_expr matrix contains the entrez ids of your genes. Uses the first column (1) by default. outSpliceAnalysis only. [OPTIONAL]

-use\_rc\_col: which column in the rawcounts matrix contains the row names. Uses the first column (1) by default. outSpliceAnalysis only. [OPTIONAL]

-use\_labels\_col: which column in the sample\_labels matrix contains the sample names. Uses the first column (1) by default. outSpliceAnalysis only. [OPTIONAL]

This algorithm is compatible with any organism provided the genome object,
genome wide annotation, and transcript annotations exist as packages on Bioconductor.

## 2.2 Phenotype matrix

If using the outspliceAnalysis function, users must provide a phenotype matrix,
designating which samples in the junction file belong to the tumor group
(labeled as “T”) and the normal group (labeled as “F”). Please ensure the
matrix file contains a header row with the first column designating the sample
names, and the second column designating the phenotype. If using TCGA data,
the two phenotypes are “tumor” and “normal.” outspliceTCGA can automatically
infer the phenotype of TCGA data using the sample names. Only if the phenotype
matrix has more than 10 control samples, and more than 1 tumor sample, the program proceeds.

## 2.3 plotJunctionData

After running outspliceAnalysis or outspliceTCGA, the user can create plots of specified
junctions using the plotJunctionData function.

The function plotJunctionData has 1 required input and 10 optional inputs

In the below example we can plot the expression levels for a “skipping” junction
event on the ECM1 gene based on our example data from the TCGA.

```
data_file <- system.file("extdata", "OutSplice_Example_2023-01-06.RDa", package = "OutSplice")
ecm1_junc <- "chr1:150483674-150483933"
pdf <- "ecm1_expression.pdf"
pdf_output <- paste0(tempdir(), "/", pdf)
message("Output is located at: ", pdf_output)
```

```
## Output is located at: /tmp/RtmpK7utiC/ecm1_expression.pdf
```

```
plotJunctionData(data_file, NUMBER = 1, junctions = ecm1_junc, tail = NULL, p_value = 0.05, GENE = FALSE, SYMBOL = NULL, makepdf = TRUE, pdffile = pdf_output, tumcol = "red", normcol = "blue")
```

```
## chr1:150483674-150483933
```

-data\_file: filepath to an R Data file containing output from the outspliceAnalysis or outspliceTCGA functions.

-NUMBER: number of junctions to plot. This can be top number of junctions (over or under expressed), or can be specific junctions in a list. Default is 1 [OPTIONAL]

-junctions: you can input the specific junction you want to graph (or vector of junctions). Default is NULL [OPTIONAL]

-tail: you can specify if you want top over or under expressed with tail=‘RIGHT’ for junctions overexpressed in tumors, or tail=‘LEFT’ for junctions underexpressed in tumors. Default is NULL [OPTIONAL]

-p\_value: p-value threshold to use when plotting the top over or under-expressed junctions with “tail”. Default is 0.05 [OPTIONAL]

-GENE: Pick junctions based on a specific gene. TRUE means you will pick all the junctions mapping to a certain gene. FALSE means you do not pick based on the gene. Default is False. [OPTIONAL]

-SYMBOL: HGNC SYMBOL of gene you want to graph [OPTIONAL]

-makepdf: Save graphs to a pdf? Default is no/FALSE [OPTIONAL]

-pdffile: if you want to save to a pdf, you will need to write the file path [OPTIONAL when makepdf = F]

-tumcol: color for tumors on graph. Default is red [OPTIONAL]

-normcol: color for normals on graph. Default is blue [OPTIONAL]

# 3 Methodology

The below sections describe the processes used in the above functions.

## 3.1 Junction RPM normalization

The program automatically normalizes the junction counts by dividing the
junction counts by the total raw counts and then dividing each count by 10^6
to generate RPM junction data.

## 3.2 OGSA initial filtering

The dotheogsa function from the Bioconductor package OGSA is sourced to remove
junctions that may not be biologically relevant due to low expression or that have any difference between tumor and normal.
In this package, we set a 0.1 RPM expression threshold for pre-filtering.

## 3.3 OGSA outlier analysis

The dotheogsa function is again employed to determine splicing events as
outliers, which are defined as any normalized junctions that are two standard
deviations above or below the median of the normal distribution. A Fisher exact
test is used to determine which junctions are significantly over or under
expressed in tumors compared to the normal samples.

## 3.4 Genomic references

The Bioconductor GenomicRanges packages are used to assign each junction to a
known gene. The user has the option in the main function to input which genome
and its associated Bioconductor packages to use as the reference. These Bioconductor
packages should include the genome object, annotations, and transcript annotations.

Ex) For mouse genomes aligned to mm39, install and load:
*[Mus.musculus](https://bioconductor.org/packages/3.22/Mus.musculus)* (genome object), *[org.Mm.eg.db](https://bioconductor.org/packages/3.22/org.Mm.eg.db)* (annotations),
and *[TxDb.Mmusculus.UCSC.mm39.refGene](https://bioconductor.org/packages/3.22/TxDb.Mmusculus.UCSC.mm39.refGene)* (transcript annotations) using the library() function. Then, when using the *[OutSplice](https://bioconductor.org/packages/3.22/OutSplice)* functions, specify *[org.Mm.eg.db](https://bioconductor.org/packages/3.22/org.Mm.eg.db)* for the annotation argument,
and *[TxDb.Mmusculus.UCSC.mm39.refGene](https://bioconductor.org/packages/3.22/TxDb.Mmusculus.UCSC.mm39.refGene)* for the TxDb argument.

This process will also work for any genome provided the correct annotation
package, its corresponding transcript annotation package, and their dependencies
from Bioconductor are provided and loaded.

Using this genomic assignment, the dotheogsa function determines insertion, skipping, or deletion events based on the following criteria:

insertion: junction that starts outside a known exon

skipping: junction that skips over a known exon

deletion: junction that is inside a known exon but not as its start or end

## 3.5 Junction expression normalization

Junction expression is normalized based on its corresponding gene expression
from the gene\_expr input. This is achieved by dividing the junction RPM data by the
normalized gene expression counts from a junction’s corresponding gene. If a junction is aligned
to more than one gene, then the gene with the lower entrez id will be the one selected for the normalization.

## 3.6 Filter by expression via offsets

Offsets, which the user can specify, sets a minimum value relative to the normal
samples in order to call a junction an outlier. The goal is to remove data with
low expression that may not be biologically relevant. In this example example, an
outlier junction must have a normalized expression greater than 0.00001 in
order to be called an outlier. Any outliers with expressions below this value
are too low to be relevant for the analysis in this example.

## 3.7 Splice Burden Calculation

Sums the number of splicing events in each sample that were marked as a TRUE
outlier for both over-expressed and under-expressed events. The total number of
outliers is then calculated as the sum of the over and under-expressed outliers.

## 3.8 Junction Plotting

Creates bar and waterfall plots of junction expression in both the tumor and
normal samples. The data for these plots comes from the raw junction input, the
gene expression values to reflect overall gene expression, and the junction
expression normalized by gene expression.

# 4 Outputs

## 4.1 outSpliceAnalysis/outSpliceTCGA

Returns a list and, if specified, an R data file and tab deliminated text files with the following data:

-ASE.type: significant junction events labeled by type (skipping, insertion, or deletion)

-FisherAnalyses: Data Frame of junction events containing the number of under/over-expressed outliers in the tumor group (Num\_UE\_Outliers/Num\_OE\_Outliers), the Fisher p-value for under/over-expressed events (FisherP1/FisherP2), and a ranking of the under/over expressed events (UE\_Rank/OE\_Rank)

-geneAnnotations: object containing gene names corresponding to each junction region

junc.Outliers: list containing the logical matrices TumorOverExpression and TumorUnderExpression. “True” indicates an over-expressed event in TumorOverExpression, or an under-expressed event in TumorUnderExpression.

-junc.RPM: junction counts in reads per million following a division of the junction counts input by the total rawcounts for each sample

-junc.RPM.norm: junction counts normalized by each event’s total gene expression value

-gene\_expr: gene expression values for each junction event

-splice\_burden: matrix containing the number of Fisher-P significant over-expressed, under-expressed, and total number of outliers per sample

-NORM.gene\_expr.norm: Median of junction data normalized by gene expression for normal samples only (Used for Junction Plotting Only)

-pheno: Phenotypes of Samples (Tumor or Normal)

-pvalues: Junction Fisher P-values

If file output was specified, the files are:

-Data File: \_.RDa

-ASE.type: event\_types.txt

-FisherAnalyses: FisherAnalyses.txt

-geneAnnotations: gene\_annotations.txt

-junc.Outliers: TumorOverExpression.txt, TumorUnderExpression.txt

-splice\_burden: splice\_burden.txt

## 4.2 plotJunctionData

Outputs junction expression plots of user specified junctions as defined in
Section 3.8. Plots can be saved to a user defined pdf file.

# 5 References

# Appendix

Broad Institute TCGA Genome Data Analysis Center (2016): Firehose stddata\_\_2016\_01\_28 run. Broad Institute of MIT and Harvard. doi:10.7908/C11G0KM9

Cancer Genome Atlas Network. Comprehensive genomic characterization of head and neck squamous cell carcinomas. Nature. 2015 Jan 29;517(7536):576-82. doi: 10.1038/nature14129. PMID: 25631445; PMCID: PMC4311405.

Guo T, Sakai A, Afsari B, Considine M, Danilova L, Favorov AV, Yegnasubramanian S, Kelley DZ, Flam E, Ha PK, Khan Z, Wheelan SJ, Gutkind JS, Fertig EJ, Gaykalova DA, Califano J. A Novel Functional Splice Variant of AKT3 Defined by Analysis of Alternative Splice Expression in HPV-Positive Oropharyngeal Cancers. Cancer Res. 2017 Oct 1;77(19):5248-5258. doi: 10.1158/0008-5472.CAN-16-3106. Epub 2017 Jul 21. PMID: 28733453; PMCID: PMC6042297.

Liu C, Guo T, Sakai A, Ren S, Fukusumi T, Ando M, Sadat S, Saito Y, Califano JA. A novel splice variant of LOXL2 promotes progression of human papillomavirus-negative head and neck squamous cell carcinoma. Cancer. 2020 Feb 15;126(4):737-748. doi: 10.1002/cncr.32610. Epub 2019 Nov 13. PMID: 31721164.

Liu C, Guo T, Xu G, Sakai A, Ren S, Fukusumi T, Ando M, Sadat S, Saito Y, Khan Z, Fisch KM, Califano J. Characterization of Alternative Splicing Events in HPV-Negative Head and Neck Squamous Cell Carcinoma Identifies an Oncogenic DOCK5 Variant. Clin Cancer Res. 2018 Oct 15;24(20):5123-5132. doi: 10.1158/1078-0432.CCR-18-0752. Epub 2018 Jun 26. PMID: 29945995; PMCID: PMC6440699.

M. F. Ochs, J. E. Farrar, M. Considine, Y. Wei, S. Meshinchi, and R. J.
Arceci. Outlier analysis and top scoring pair for integrated data analysis and
biomarker discovery. IEEE/ACM Trans Comput Biol Bioinform, 11: 520-32, 2014. PMCID: PMC4156935

# A Session Info

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] OutSplice_1.10.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0
##  [2] SummarizedExperiment_1.40.0
##  [3] rjson_0.2.23
##  [4] xfun_0.53
##  [5] bslib_0.9.0
##  [6] Biobase_2.70.0
##  [7] lattice_0.22-7
##  [8] vctrs_0.6.5
##  [9] tools_4.5.1
## [10] bitops_1.0-9
## [11] generics_0.1.4
## [12] stats4_4.5.1
## [13] curl_7.0.0
## [14] parallel_4.5.1
## [15] AnnotationDbi_1.72.0
## [16] RSQLite_2.4.3
## [17] blob_1.2.4
## [18] pkgconfig_2.0.3
## [19] Matrix_1.7-4
## [20] cigarillo_1.0.0
## [21] S4Vectors_0.48.0
## [22] lifecycle_1.0.4
## [23] compiler_4.5.1
## [24] Rsamtools_2.26.0
## [25] Biostrings_2.78.0
## [26] Seqinfo_1.0.0
## [27] codetools_0.2-20
## [28] htmltools_0.5.8.1
## [29] sass_0.4.10
## [30] RCurl_1.98-1.17
## [31] yaml_2.3.10
## [32] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
## [33] crayon_1.5.3
## [34] jquerylib_0.1.4
## [35] BiocParallel_1.44.0
## [36] cachem_1.1.0
## [37] DelayedArray_0.36.0
## [38] org.Hs.eg.db_3.22.0
## [39] abind_1.4-8
## [40] digest_0.6.37
## [41] restfulr_0.0.16
## [42] bookdown_0.45
## [43] fastmap_1.2.0
## [44] grid_4.5.1
## [45] TxDb.Hsapiens.UCSC.hg38.knownGene_3.22.0
## [46] SparseArray_1.10.0
## [47] cli_3.6.5
## [48] S4Arrays_1.10.0
## [49] GenomicFeatures_1.62.0
## [50] XML_3.99-0.19
## [51] bit64_4.6.0-1
## [52] rmarkdown_2.30
## [53] XVector_0.50.0
## [54] httr_1.4.7
## [55] matrixStats_1.5.0
## [56] bit_4.6.0
## [57] png_0.1-8
## [58] memoise_2.0.1
## [59] evaluate_1.0.5
## [60] knitr_1.50
## [61] GenomicRanges_1.62.0
## [62] IRanges_2.44.0
## [63] BiocIO_1.20.0
## [64] rtracklayer_1.70.0
## [65] rlang_1.1.6
## [66] DBI_1.2.3
## [67] BiocManager_1.30.26
## [68] BiocGenerics_0.56.0
## [69] jsonlite_2.0.0
## [70] R6_2.6.1
## [71] MatrixGenerics_1.22.0
## [72] GenomicAlignments_1.46.0
```