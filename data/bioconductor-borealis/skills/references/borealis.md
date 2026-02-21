# Borealis outlier methylation detection

Gavin Oliver1, Garrett Jenkinson1\* and Eric Klee1

1Mayo Clinic

\*jenkinson.william@mayo.edu

#### 29 October 2025

#### Package

borealis 1.14.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Citation](#citation)
* [2 Installation](#installation)
* [3 Running Borealis](#running-borealis)
* [4 Basic post-processing and analysis of Borealis results](#basic-post-processing-and-analysis-of-borealis-results)
  + [4.1 Read in entire cohort’s results](#read-in-entire-cohorts-results)
  + [4.2 Generating summary metrics across all samples](#generating-summary-metrics-across-all-samples)
    - [4.2.1 How many CpG sites worth of data do we have across all samples combined?](#how-many-cpg-sites-worth-of-data-do-we-have-across-all-samples-combined)
    - [4.2.2 How many unique samples and unique CpG sites are we analyzing data from?](#how-many-unique-samples-and-unique-cpg-sites-are-we-analyzing-data-from)
    - [4.2.3 Distribution of the mean methylation values and variability per CpG Site](#distribution-of-the-mean-methylation-values-and-variability-per-cpg-site)
    - [4.2.4 Summary of read depth distributions](#summary-of-read-depth-distributions)
    - [4.2.5 Summary of uncorrected p-values](#summary-of-uncorrected-p-values)
    - [4.2.6 Summary of corrected p-values](#summary-of-corrected-p-values)
    - [4.2.7 Summary of methylation fraction across sites](#summary-of-methylation-fraction-across-sites)
    - [4.2.8 Summary of effect sizes](#summary-of-effect-sizes)
    - [4.2.9 Outliers and most significant CpG site](#outliers-and-most-significant-cpg-site)
  + [4.3 Annotating outputs with epigenetic features](#annotating-outputs-with-epigenetic-features)
  + [4.4 Summarizing single-site data across epigenetic features](#summarizing-single-site-data-across-epigenetic-features)
* [Session info](#session-info)

# 1 Introduction

Borealis is a package for the detection of outlier methylation at single
CpG-site resolution, where a cohort of 3 to 100+ samples can be processed and
each sample is analyzed versus the rest of the cohort to identify outlier
hypermethylated or hypomethylated CpG sites. This form of one vs many analysis
differs from traditional case vs control group analyses and has been successful
in domains such as rare genetic disease driver identification. Furthermore, the
ability of Borealis to identify single CpG-site differences offers a higher
resolution view of methylation, since increasing numbers of studies demonstrate
single-site methylation aberrations in disease.

This vignette provides an introduction to some basic and advanced operations
with Borealis using a region of chromosome 14 in a cohort of 20 individuals
being investigated for causes of rare genetic disease. In real-world use,
Borealis expects outputs from the aligner *[Bismark](https://github.com//FelixKrueger/Bismark)*
which is available on Github.

After completing this vignette users should be able to conduct in-depth
methylation analysis and discover biological signals in their data. After
learning basic functionality, creating summary metrics and looking for outlier
samples, users will optionally learn how to annotate CpGs with epigenetic
feature context using *[annotatr](https://bioconductor.org/packages/3.22/annotatr)*. Finally users will learn how to
summarize CpG data across epigenetic features.

## 1.1 Citation

If you use borealis in your research, please cite Oliver et al. ([2022](#ref-borealis)).

# 2 Installation

The release version of *[borealis](https://bioconductor.org/packages/3.22/borealis)* is available via Bioconductor and
can be installed as follows:

```
if (!requireNamespace("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("borealis")
```

The development version of *[borealis](https://github.com/GarrettJenkinson/borealis)* can be
obtained via the Github repository.

It is easiest to install development versions with the CRANpkg(“devtools”)
package as follows:

```
devtools::install_github('GarrettJenkinson/borealis')
```

Changelogs for development releases will be detailed on GitHub releases.

# 3 Running Borealis

Now let’s load the test data included with Borealis. This represents a specific
region from chromosome 14 (hg19) for 20 individuals with undiagnosed rare
disease.

The entire Borealis pipeline can be run with the single `runBorealis` command.

```
library("borealis")

# Set data locations
outdir <- tempdir()
extdata <- system.file("extdata","bismark", package="borealis")

# Run borealis
results <- runBorealis(extdata,nThreads=2, chrs="chr14", suffix=".gz",
                        outprefix=file.path(outdir,"vignette_borealis_"),
                        modelOutPrefix=file.path(outdir,"vignette_CpG_model"))
```

Now let’s quickly make sure we generated one output per sample:

```
# Read in the name of all files for analysis
borealis_in <- dir(outdir,pattern="*DMLs.tsv")
length(borealis_in)
```

```
## [1] 20
```

Looks good? Let’s continue!

# 4 Basic post-processing and analysis of Borealis results

## 4.1 Read in entire cohort’s results

Now you should have successfully loaded the provided methylation data, run
Borealis and created a list of its output files.

Let’s now have a look at the data and generate some summary metrics.

First we’ll read in the data for each of the 20 patients and create GRanges
for each:

```
# Read in list of Borealis output files and create a dataframe for each
for (file in borealis_in) {
    name <- sub("_DMLs.tsv", "", file)
    assign(name,GenomicRanges::makeGRangesFromDataFrame(
                read.table(file.path(outdir,file), header=TRUE,
                stringsAsFactors=FALSE), start.field="pos", end.field="pos.1",
                seqnames.field="chr", keep.extra.columns=TRUE))
}

# Create a list of the newly created dataframes
list_object_names <- ls(pattern="borealis_patient")
listGRanges <- lapply(list_object_names, get)
```

Let’s check we have 20 new GRange objects and confirm the naming convention:

```
length(list_object_names)
```

```
## [1] 20
```

```
list_object_names[1]
```

```
## [1] "vignette_borealis_patient_70_chr14"
```

Looks good - now let’s have a look at one row to get familiar with the fields
of data:

```
listGRanges[[1]][1,]
```

```
## GRanges object with 1 range and 7 metadata columns:
##       seqnames    ranges strand |         x         n        mu     theta
##          <Rle> <IRanges>  <Rle> | <integer> <integer> <numeric> <numeric>
##   [1]    chr14  24802152      * |        11        18   0.21535 0.0502731
##            pVal    isHypo   effSize
##       <numeric> <logical> <numeric>
##   [1] 0.0156873     FALSE  0.395761
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

To explain the data you see in brief:

* x = number of methylated CpGs at a given position
* n = the toal number of reads at that position
* mu = the mean fraction of reads methylated at this position across all samples
* theta = the disperson of the methylation values at this position
* pVal= probability of deviation from normal methylation at this position
* isHypo = if the site is hypomethylated at this position
  + Yes = the site is defined as hypomethylated
  + No = the site is defined as hypermethylated
  + NA = the change is not significant enough to call hyper/hypo
* effSize = the effect size i.e. how large a deviation from normal methylation

Okay - now let’s start summarizing some of this information across samples.

## 4.2 Generating summary metrics across all samples

First we will add two new columns to each GRange. One column will be the
sample ID for each patient, to enable us to distinguish between results later.
The second will contain p-values adjusted for multiple comparisons at each CpG
site per-patient.

We decouple the generation of adjusted p-values from the main package since
users may wish to use uncorrected p-values or generate adjusted p-values in a
specific fashion depending on their analysis.

```
# Add sample ID and a corrected p-value to each and output as new files (.padj)
for (i in seq_along(listGRanges)) {
    sample=sub("_chr.*", "", list_object_names[i])
    listGRanges[[i]]$sampleID <- sample
    listGRanges[[i]]$pAdj <- p.adjust( listGRanges[[i]]$pVal, method="BH")
}
```

Let’s have a look at the first entry to see those newly added columns:

```
listGRanges[[1]][1,]
```

```
## GRanges object with 1 range and 9 metadata columns:
##       seqnames    ranges strand |         x         n        mu     theta
##          <Rle> <IRanges>  <Rle> | <integer> <integer> <numeric> <numeric>
##   [1]    chr14  24802152      * |        11        18   0.21535 0.0502731
##            pVal    isHypo   effSize               sampleID      pAdj
##       <numeric> <logical> <numeric>            <character> <numeric>
##   [1] 0.0156873     FALSE  0.395761 vignette_borealis_pa..         1
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

Looking good. We now have adjusted p-values and sample identifiers.

Now we will create a single dataframe containing data for all samples and
generate our summary metrics.

```
# Create a single GRanges obect with data for all samples and a dataframe for summaries
combined_files <- Reduce(c,listGRanges)
combined_files_df<-data.frame(combined_files)
```

### 4.2.1 How many CpG sites worth of data do we have across all samples combined?

```
# How many rows of data in combined GRange object?
length(combined_files)
```

```
## [1] 3724
```

Lets create a table to summarize useful metrics about the CpG sites

```
# Create table of unique positions and mu/theta values
mu_theta <- unique(subset(combined_files_df,
                    select=-c(x,n,pVal, isHypo, pAdj, effSize, sampleID)))
```

### 4.2.2 How many unique samples and unique CpG sites are we analyzing data from?

```
#Number of unique samples
length(unique(combined_files_df$sampleID))
```

```
## [1] 20
```

```
#Number of unique CpG sites
nrow(unique(mu_theta))
```

```
## [1] 245
```

### 4.2.3 Distribution of the mean methylation values and variability per CpG Site

```
#generate summaries for mu and theta
summary(mu_theta$mu)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.0247  0.0680  0.1206  0.3333  0.7961  0.9260
```

```
summary(mu_theta$theta)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.0000  0.0000  0.0000  0.0142  0.0239  0.1417
```

Now let’s look at the distribitions of other important values.

```
# Create table of unique positions and depth/p-val/padj for each position in
# each case
depth_pvals_eff <- unique(combined_files_df)
```

### 4.2.4 Summary of read depth distributions

```
#Summarize read depths
summary(depth_pvals_eff$n)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##    10.0    15.0    22.0    24.5    32.2    71.0
```

### 4.2.5 Summary of uncorrected p-values

```
#Summarize pvals
summary(depth_pvals_eff$pVal)
```

```
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max.
## 0.000592 0.374370 0.638833 0.614286 0.880635 1.000000
```

### 4.2.6 Summary of corrected p-values

```
#Summarize corrected pvals
summary(depth_pvals_eff$pAdj)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##   0.019   1.000   1.000   0.981   1.000   1.000
```

### 4.2.7 Summary of methylation fraction across sites

```
#Summarize fraction of methylation
summary(depth_pvals_eff$x/depth_pvals_eff$n)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
##  0.0000  0.0000  0.0435  0.2632  0.5455  1.0000
```

### 4.2.8 Summary of effect sizes

```
#Summarize effect size
summary(depth_pvals_eff$effSize)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
## -0.4833 -0.0682 -0.0381 -0.0164  0.0191  0.5952
```

### 4.2.9 Outliers and most significant CpG site

Now lets see if any samples are extreme outliers in terms of number of CpG sites
called significant (p <= 0.05):

```
# Detection of outliers based on number of significant sites
# Count significant CpG sites per patient
signif_only <- subset(combined_files_df, pVal <= 0.05)
signif_counts <- dplyr::count(as.data.frame(signif_only),sampleID)

# Calculate the percentiles of the number of significant sites
sig_quantiles <- quantile(signif_counts$n,
                            probs=c(0.025, 0.05, 0.95, 0.975, 0.999))

# Check if nay patients are above the 99.9th percentile
subset(signif_counts, n >= sig_quantiles["99.9%"])
```

```
##                       sampleID  n
## 3 vignette_borealis_patient_72 53
```

We can see that one patient appears to be an extreme outlier.

Let’s also have a look at which site is most significant.

```
# What is the most significant CpG site between all samples?
subset(combined_files_df, pVal == min(combined_files$pVal))
```

```
##     seqnames    start      end width strand  x  n    mu  theta     pVal isHypo
## 366    chr14 24780569 24780569     1      * 17 28 0.117 0.0567 0.000592  FALSE
##     effSize                     sampleID  pAdj
## 366    0.49 vignette_borealis_patient_72 0.019
```

---

Depending on your use-case, this might be enough information for you and you
could stop here, or you could extract the top 100 outlier sites.

Another useful step is contextualizing CpG sites on the basis of which
epigenetic features they reside in. We provide an example of how to do so in the
following section. We will do this for the single sample containing the most
significant CpG site for the sake of brevity in the vignette.

## 4.3 Annotating outputs with epigenetic features

In this section we will add further biological context to our results by
annotating epigenetically relevant features. We will use the
*[annotatr](https://bioconductor.org/packages/3.22/annotatr)* package but you can use your favorite tool instead. The
release version of *[annotatr](https://bioconductor.org/packages/3.22/annotatr)* is available via Bioconductor and can
be installed as follows:

```
if (!requireNamespace("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("annotatr")
```

Now let’s load the package and read in the data we created in the previous steps
for the patient with the most significant CpG site.

We will annotate with annotations from *[annotatr](https://bioconductor.org/packages/3.22/annotatr)*.

Let’s will start by defining the annotations we want to utilize.

```
#Assign approproate genome version based on alignments
genome.version <- "hg19"

# Select annnotation classes we want from annotatr (can be user-customized)
myAnnots <- c('_genes_promoters', '_genes_5UTRs', '_genes_exons',
    '_genes_3UTRs','_cpg_islands')
```

Now let’s annotate for our patient of interest:

```
#Read in patient 72 Grange data for annotation
dmrs.gr<-subset(combined_files,
    sampleID == "vignette_borealis_patient_72")

# Annotate using annotatr
myAnnots <- paste(genome.version,myAnnots,sep="")
annots.all.gr <- annotatr::build_annotations(genome = genome.version,
    annotations = myAnnots)
allAnnot <- annotatr::annotate_regions(regions=dmrs.gr,
    annotations=annots.all.gr, ignore.strand=TRUE, minoverlap=0)
```

Now let’s look at that most significant site again - with annotations.

```
# Extract the annotated site with the smallest p-value
subset(allAnnot, pVal == min(allAnnot$pVal))$annot
```

```
## GRanges object with 13 ranges and 5 metadata columns:
##        seqnames            ranges strand |              id               tx_id
##           <Rle>         <IRanges>  <Rle> |     <character>         <character>
##    [1]    chr14 24779656-24780655      + | promoter:259778 ENST00000553481.1_4
##    [2]    chr14 24779708-24780707      + | promoter:259779 ENST00000345363.8_4
##    [3]    chr14 24779925-24780924      - | promoter:266420 ENST00000555471.1_3
##    [4]    chr14 24779855-24780601      - |     5UTR:117772 ENST00000336557.9_5
##    [5]    chr14 24779855-24780628      - |     5UTR:117776 ENST00000258807.5_5
##    ...      ...               ...    ... .             ...                 ...
##    [9]    chr14 24779805-24780827      + |    exon:1452914 ENST00000530080.1_5
##   [10]    chr14 24779855-24780601      - |    exon:1493635 ENST00000336557.9_5
##   [11]    chr14 24779855-24780628      - |    exon:1493643 ENST00000258807.5_5
##   [12]    chr14 24780434-24780636      - |    exon:1493654 ENST00000555817.1_3
##   [13]    chr14 24779875-24780932      * |    island:17101                <NA>
##            gene_id      symbol                 type
##        <character> <character>          <character>
##    [1]        1241       LTB4R hg19_genes_promoters
##    [2]        1241       LTB4R hg19_genes_promoters
##    [3]       27141       CIDEB hg19_genes_promoters
##    [4]       27141       CIDEB     hg19_genes_5UTRs
##    [5]       27141       CIDEB     hg19_genes_5UTRs
##    ...         ...         ...                  ...
##    [9]       56413      LTB4R2     hg19_genes_exons
##   [10]       27141       CIDEB     hg19_genes_exons
##   [11]       27141       CIDEB     hg19_genes_exons
##   [12]        <NA>        <NA>     hg19_genes_exons
##   [13]        <NA>        <NA>     hg19_cpg_islands
##   -------
##   seqinfo: 298 sequences (2 circular) from hg19 genome
```

This CpG site overlaps multiple genes and features in Patient 72 but perhaps
most interesting is the LTB4R promoter, since promoters are so strongly linked
to control of gene expression.

Let’s use a handy Borealis plotting function to investigate this site further.

```
# Use Borealis plotting function to investigate this site further
plotCpGsite("chr14:24780288", sampleOfInterest="patient_72",
            modelFile=file.path(outdir,"vignette_CpG_model_chr14.csv"),
            methCountFile=file.path(outdir,
                                "vignette_CpG_model_rawMethCount_chr14.tsv"),
            totalCountFile=file.path(outdir,
                                "vignette_CpG_model_rawTotalCount_chr14.tsv"))
```

```
## $`chr14:24780288`
```

![plotCpGsite function demo](data:image/png;base64...)

Figure 1: plotCpGsite function demo

The graph above shows us the expected methylation profile under our model, and
how far our site deviates from the expected methylation profile. As you can see
this site stands out. It is hypermethylated.

Now what if we wanted to know if this site is surrounded by other
hypermethylated CpG sites? We could do this using the data we have already
generated, but an advanced approach that will be useful for further analysis is
to summarize all our data across epigenetic features.

That’s what we will do next.

## 4.4 Summarizing single-site data across epigenetic features

First lets set a p-value we will use to determine significance in our
feature-summarized data. In our summarization we will make
use of corrected p-values and ignore uncorrected p-values. Your analysis can
optionally use an alternative approach.

```
padjThresh <- 0.05
```

Okay - now let’s do the summarization. You can use this code as-is or easily
customize it to create summary metrics specific to your application.

```
# Calculate how may CpGs per annotatr feature and store in dataframe
allAnnot <- as.data.frame(allAnnot)
featureids <- allAnnot$annot.id
featurecnts <- as.data.frame(table(featureids))
colnames(featurecnts) <- c("annot.id", "NoSites")
```

Since the inputs are individual CpGs we are just creating a count of how many
individual sites exist in every unique feature. Let’s look:

```
head(featurecnts)
```

```
##      annot.id NoSites
## 1 3UTR:145400       2
## 2 3UTR:145419       2
## 3 5UTR:113916       7
## 4 5UTR:113917       7
## 5 5UTR:113928       6
## 6 5UTR:113930       7
```

Okay, now we want to figure out how many of the CpGs in each feature have a
significant corrected p-value, meaning they appear abnormal. We will subset the
sample data on the basic of the p-value and create counts,

```
# Calculate how many sites per feature pass p-value threshold
# Add data to new summary dataframe
signifonly <- subset(allAnnot, pAdj<=padjThresh)
signifonly <- signifonly$annot.id
signifonlycnt <- as.data.frame(table(signifonly))
colnames(signifonlycnt) <- c("annot.id", "signifCount")
featurecnts <- merge(featurecnts, signifonlycnt, by.x="annot.id",
                        by.y="annot.id", all.x=TRUE)
```

Now for convenience let’s figure out what fraction of sites in each feature
are significant.

```
# What fraction of sites per feature pass p-value threshold?
featurecnts$fractionSignif <- featurecnts$signifCount/featurecnts$NoSites
```

And finally lets merge the new and orignal data for output:

```
# Let's combine the data for final output
locations <- subset(allAnnot, select=c("annot.id", "annot.seqnames",
                                        "annot.start", "annot.end"))
featurecnts <- merge(unique(locations), featurecnts, by="annot.id")
genemap <- unique(cbind(allAnnot$annot.symbol, allAnnot$annot.id,
                        allAnnot$annot.tx_id,allAnnot$annot.width,
                        allAnnot$sampleID))
colnames(genemap) <- c("annot.symbol", "annot.id", "annot.tx_id", "annot.width",
                        "SampleID")

summarized <- merge(featurecnts, genemap, by="annot.id")
summarized$signifCount[is.na(summarized$signifCount)] <- 0
summarized$fractionSignif[is.na(summarized$fractionSignif)] <- 0
```

Now let’s have a look at that promoter region!

```
# Select the LTB4R promoter region
subset(summarized, select=c(annot.symbol, NoSites, signifCount, fractionSignif),
        (annot.symbol=="LTB4R" & grepl("promoter", annot.id)))
```

```
##     annot.symbol NoSites signifCount fractionSignif
## 122        LTB4R      41          35          0.854
## 123        LTB4R      46          37          0.804
```

You can see that the outlier site from earlier isn’t alone - multiple other
sites are affected in the same region. In fact, in that LTB4R promoter 78.7% of
the CpG sites we have data for are called significant by Borealis! That’s 37 CpG
sites and all are called hypermethylated. This could be a very relevant finding.
Maybe you can now used the code provided to look at the data in different ways.
What other genes overlap this region? What features are affected for each?

Thank you for trying Borealis and for working through this vignette. We hope it
was helpful. This is as far as we will go but hopefully you have all you need to
expand the analysis and apply it to your own data!

Good luck!

# Session info

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] org.Hs.eg.db_3.22.0
##  [2] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
##  [3] GenomicFeatures_1.62.0
##  [4] AnnotationDbi_1.72.0
##  [5] GenomicRanges_1.62.0
##  [6] Seqinfo_1.0.0
##  [7] IRanges_2.44.0
##  [8] S4Vectors_0.48.0
##  [9] borealis_1.14.0
## [10] Biobase_2.70.0
## [11] BiocGenerics_0.56.0
## [12] generics_0.1.4
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
##   [3] magrittr_2.0.4              magick_2.9.0
##   [5] farver_2.1.2                rmarkdown_2.30
##   [7] BiocIO_1.20.0               vctrs_0.6.5
##   [9] memoise_2.0.1               Rsamtools_2.26.0
##  [11] DelayedMatrixStats_1.32.0   RCurl_1.98-1.17
##  [13] tinytex_0.57                htmltools_0.5.8.1
##  [15] S4Arrays_1.10.0             AnnotationHub_4.0.0
##  [17] curl_7.0.0                  Rhdf5lib_1.32.0
##  [19] SparseArray_1.10.0          rhdf5_2.54.0
##  [21] sass_0.4.10                 bslib_0.9.0
##  [23] bsseq_1.46.0                plyr_1.8.9
##  [25] httr2_1.2.1                 cachem_1.1.0
##  [27] GenomicAlignments_1.46.0    lifecycle_1.0.4
##  [29] iterators_1.0.14            pkgconfig_2.0.3
##  [31] Matrix_1.7-4                R6_2.6.1
##  [33] fastmap_1.2.0               MatrixGenerics_1.22.0
##  [35] digest_0.6.37               regioneR_1.42.0
##  [37] RSQLite_2.4.3               beachmat_2.26.0
##  [39] labeling_0.4.3              filelock_1.0.3
##  [41] httr_1.4.7                  abind_1.4-8
##  [43] compiler_4.5.1              withr_3.0.2
##  [45] bit64_4.6.0-1               doParallel_1.0.17
##  [47] S7_0.2.0                    BiocParallel_1.44.0
##  [49] DBI_1.2.3                   HDF5Array_1.38.0
##  [51] R.utils_2.13.0              MASS_7.3-65
##  [53] rappdirs_0.3.3              DelayedArray_0.36.0
##  [55] rjson_0.2.23                gtools_3.9.5
##  [57] permute_0.9-8               tools_4.5.1
##  [59] DSS_2.58.0                  R.oo_1.27.1
##  [61] glue_1.8.0                  h5mread_1.2.0
##  [63] restfulr_0.0.16             nlme_3.1-168
##  [65] rhdf5filters_1.22.0         grid_4.5.1
##  [67] reshape2_1.4.4              snow_0.4-4
##  [69] gtable_0.3.6                BSgenome_1.78.0
##  [71] tzdb_0.5.0                  R.methodsS3_1.8.2
##  [73] data.table_1.17.8           hms_1.1.4
##  [75] XVector_0.50.0              stringr_1.5.2
##  [77] BiocVersion_3.22.0          foreach_1.5.2
##  [79] pillar_1.11.1               limma_3.66.0
##  [81] splines_4.5.1               dplyr_1.1.4
##  [83] BiocFileCache_3.0.0         lattice_0.22-7
##  [85] survival_3.8-3              rtracklayer_1.70.0
##  [87] bit_4.6.0                   gamlss.data_6.0-7
##  [89] tidyselect_1.2.1            locfit_1.5-9.12
##  [91] Biostrings_2.78.0           knitr_1.50
##  [93] bookdown_0.45               SummarizedExperiment_1.40.0
##  [95] xfun_0.53                   statmod_1.5.1
##  [97] annotatr_1.36.0             matrixStats_1.5.0
##  [99] stringi_1.8.7               UCSC.utils_1.6.0
## [101] yaml_2.3.10                 evaluate_1.0.5
## [103] codetools_0.2-20            cigarillo_1.0.0
## [105] tibble_3.3.0                BiocManager_1.30.26
## [107] cli_3.6.5                   jquerylib_0.1.4
## [109] dichromat_2.0-0.1           Rcpp_1.1.0
## [111] GenomeInfoDb_1.46.0         dbplyr_2.5.1
## [113] png_0.1-8                   XML_3.99-0.19
## [115] parallel_4.5.1              ggplot2_4.0.0
## [117] readr_2.1.5                 blob_1.2.4
## [119] sparseMatrixStats_1.22.0    bitops_1.0-9
## [121] gamlss.dist_6.1-1           scales_1.4.0
## [123] gamlss_5.5-0                purrr_1.1.0
## [125] crayon_1.5.3                rlang_1.1.6
## [127] cowplot_1.2.0               KEGGREST_1.50.0
```

Oliver, Gavin R., Garrett Jenkinson, Rory J. Olson, Laura E. Shultz-Rogers, and Eric W. Klee. 2022. “Detection of Outlier Methylation from Bisulfite Sequencing Data with Novel Bioconductor Package Borealis.” *bioRxiv*. <https://doi.org/10.1101/2022.05.19.492700>.