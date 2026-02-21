# gCrisprTools and the Analysis of Pooled Screening Data

## Russell Bainer

```
- <toc id="sec:1-0-overview-of-gcrisprtools">1.0 Overview of gCrisprTools</toc>
- <toc id="sec:2-0-inputs">2.0 Inputs</toc>
- <toc id="sec:3-0-preprocess-raw-data">3.0 Preprocess Raw Data</toc>
- <toc id="sec:4-0-quality-assessment">4.0 Quality Assessment</toc>
- <toc id="sec:5-0-identifying-candidate-targets">5.0 Identifying Candidate Targets</toc>
- <toc id="sec:6-0-visualization-of-results">6.0 Visualization of Results</toc>
- <toc id="sec:7-0-hypothesis-testing">7.0 Hypothesis Testing</toc>
```

### 1.0 Overview of gCrisprTools

Competitive screening experiments, in which bulk cell cultures infected with a heterogeneous viral library are experimentally manipulated to identify guide RNAs or shRNAs that influence cell viability, are conceptually straightforward but often challenging to implement. Here, we present gCrisprTools, an R/Bioconductor analysis suite facilitating quality assessment, target prioritization, and interpretation of arbitrarily complex competitive screening experiments. gCrisprTools provides functionalities for detailed and principled ana lysis of diverse aspects of these experiments both as a standalone pipeline or as an extension to alternative analytical approaches.

#### 1.1 Installation

Install gCrisprTools in the usual way:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("gCrisprTools")
```

#### 1.4 Explore the Vignettes Folder

This vignette is only one of the resources provided in `gCrisprTools` to help you understand, analyse, and explore pooled screening data. As appropriate, please see the `/vignettes` subdirectory for additional documentation describing example code, and the `/inst` directory for more information about algorithm implementation and package layout.

#### 1.3 Dependencies

`gCrisprTools` uses the existing `Biobase` framework for data storage and manipulation and consequently depends heavily on the `Biobase` and `limma` packages.

```
library(Biobase)
library(limma)
library(gCrisprTools)
```

### 2.0 Inputs

#### 2.1 Counting Cassettes from Sequencing Data

To use the various methods available in this package, you will first need to conform your screen data into an `ExpressionSet` object containing cassette abundance counts in the assayData slot, retrievable with `exprs()`. This package assumes that end users are familiar enough with the R/Bioconductor framework and their own sequencing pipelines to extract raw cassette counts from FASTQ files and to compose them into an `ExpressionSet`. For newer users read counting may be facilitated with [cutadapt](https://cutadapt.readthedocs.io/en/stable/) or other software designed for these purposes; details about composition of `ExpressionSet` objects can be found in the [Biobase](http://bioconductor.org/packages/release/bioc/manuals/Biobase/man/Biobase.pdf) vignette.

##### 2.2 An ExpressionSet of Cassette Counts

Raw cassette counts should be contained within an `ExpressionSet` object, with the counts retrievable with`exprs()`. The column names (`colnames()`) should correspond to unique sample identifiers, and the row names (`row.names()`) should correspond to identifiers uniquely specifying each cassette of interest.

```
data("es", package = "gCrisprTools")
es
```

```
## ExpressionSet (storageMode: lockedEnvironment)
## assayData: 17214 features, 9 samples
##   element names: exprs
## protocolData: none
## phenoData
##   sampleNames: SAMPLE_1 SAMPLE_2 ... SAMPLE_9 (9 total)
##   varLabels: TREATMENT_NAME sizeFactor.crispr-gRNA REPLICATE_POOL
##   varMetadata: labelDescription
## featureData: none
## experimentData: use 'experimentData(object)'
## Annotation:
```

```
head(exprs(es))
```

```
##               SAMPLE_1 SAMPLE_2  SAMPLE_3  SAMPLE_4  SAMPLE_5  SAMPLE_6
## Target2089_b  24.59438 104.1006  96.22297  27.21276  25.58658  21.98717
## Target1377_d 316.78926 270.2105 284.81543 266.70571 325.01514 351.33774
## Target495_g  160.72282 152.7520 150.99799 148.32776 191.17965 143.76385
## Target160_d  201.28634 201.4035 203.69294 151.06483 238.81601 221.95001
## Target162_e  228.78704 177.7728 173.18534 174.32986 100.44372 227.48532
## Target1684_c 310.60160 212.5238 189.82585 266.70571 372.65150 261.38905
##              SAMPLE_7 SAMPLE_8   SAMPLE_9
## Target2089_b 134.0666 121.5973   37.25687
## Target1377_d 269.6764 359.5304  238.62684
## Target495_g  100.6858 216.9096  527.12806
## Target160_d  177.8790 263.5223  228.94559
## Target162_e  182.0516 237.0853   97.28061
## Target1684_c 154.9297 269.0880 1011.19049
```

##### 2.3 An Annotation Object

gCrisprTools requires an annotation object mapping the individual cassettes to genes or other genomic features for most applications. The annotation object should be provided as a named `data.frame`, with columns describing the ‘`geneID`’ and ‘`geneSymbol`’ of the target elements to which each cassette is annotated. These columns should contain character vectors with elements that uniquely describe the targets in the screen; by convention, the `geneID` field contains an official identifier that unambiguously describes each target element in a manner suitable for external software (e.g., an Entrez ID). The `geneSymbol` column indicates a more human-readable descriptor, such as a gene symbol.

The annotation object may optionally contain other columns with additional information about the corresponding cassettes.

```
data("ann", package = "gCrisprTools")
head(ann)
```

```
##                        ID              target geneID chr end start strand size
## Target2089_b Target2089_b CTCAGAGTTGGTCGACTTT   9437 chr   1     1      *   19
## Target1377_d Target1377_d GCCAAAGTACAGCTTGCCC   3029 chr   1     1      *   19
## Target495_g   Target495_g ACGGTACTTGGTCCTCAAT   5936 chr   1     1      *   19
## Target160_d   Target160_d TTGAGAATCTACAATCACG  10105 chr   1     1      *   19
## Target162_e   Target162_e GACAGACACATAAGAAAGG  10951 chr   1     1      *   19
## Target1684_c Target1684_c CAGTCTCTGGCTGTTACGG   2335 chr   1     1      *   19
##              geneSymbol
## Target2089_b Target2089
## Target1377_d Target1377
## Target495_g   Target495
## Target160_d   Target160
## Target162_e   Target162
## Target1684_c Target1684
```

#### 2.4 A Sample Key

Many `gCrisprTools` functions require or are enhanced by a sample key detailing the experimental groups of the functions included in the study. This key should be provided as a named factor, with `names` perfectly matching the `colnames` of the ExpressionSet. The first level of the sample key should correspond to the ‘control’ condition, indexing samples whose cassette distributions are expected to be the minimally distorted by experimental treatments.

```
sk <- relevel(as.factor(pData(es)$TREATMENT_NAME), "ControlReference")
names(sk) <- row.names(pData(es))
sk
```

```
##         SAMPLE_1         SAMPLE_2         SAMPLE_3         SAMPLE_4
## ControlExpansion ControlReference ControlReference ControlExpansion
##         SAMPLE_5         SAMPLE_6         SAMPLE_7         SAMPLE_8
##   DeathExpansion ControlExpansion   DeathExpansion ControlReference
##         SAMPLE_9
##   DeathExpansion
## Levels: ControlReference ControlExpansion DeathExpansion
```

#### 2.5 Alignment Statistics

Users may provide a matrix of alignment statistics to enhance some applications, including QC reporting. These should be provided as a numeric matrix in which rows correspond to `targets` (reads containing a target cassette), `nomatch` (reads containing a cassette sequence but not a known target sequence), `rejections` (reads not containg a cassette sequence), and `double_match` (reads derived from multiple cassettes). The column names should exactly match the `colnames()` of the ExpressionSet object. Simple charting functionality is also provided to inspect the alignment rates of each sample.

```
data("aln", package = "gCrisprTools")
head(aln)
```

```
##              SAMPLE_1 SAMPLE_2 SAMPLE_3 SAMPLE_4 SAMPLE_5 SAMPLE_6 SAMPLE_7
## targets       7004519  6183983  5738954  6309065  6615134  6156333  7792838
## nomatch        743882   607080   561278   667729   540513   648896   652940
## rejections    1428342  1122692  1148612  1232306  1145034   963777  1336762
## double_match    32428    18729    16854    23830    22156    27811    32852
##              SAMPLE_8 SAMPLE_9
## targets       7934066  5646518
## nomatch        786835   470447
## rejections    1591687  1006863
## double_match    23152    25757
```

```
ct.alignmentChart(aln, sk)
```

![plot of chunk unnamed-chunk-6](data:image/png;base64...)

### 3.0 Preprocess Raw Data

`gCrisprTools` provides tools for common data preprocessing steps, including eliminating underinfected or contaminant cassettes and sample-level normalization.

##### 3.1 ct.filterReads

Low abundance cassettes can be removed by specifying a minimum number of counts or a level relative to the trimmed distribution maximum.

```
es.floor <- ct.filterReads(es, read.floor = 30, sampleKey = sk)
```

```
## Using the supplied minimum threshold of 30 reads for each guide.
```

![plot of chunk unnamed-chunk-7](data:image/png;base64...)

```
es <- ct.filterReads(es, trim = 1000, log2.ratio = 4, sampleKey = sk)
```

![plot of chunk unnamed-chunk-7](data:image/png;base64...)

```
##Convenience function for conforming the annotation object to exclude the trimmed gRNAs
ann <- ct.prepareAnnotation(ann, es, controls = "NoTarget")
```

```
## 307 elements defined in the annotation file are not present in row names of the specified object. Omitting.
```

##### 3.2 ct.normalizeGuides

A suite of normalization tools are provided with the `ct.normalizeGuides()` wrapper function; see the relevant manual pages for further details about these methods.

```
es <- ct.normalizeGuides(es, 'scale', annotation = ann, sampleKey = sk, plot.it = TRUE)
```

![plot of chunk unnamed-chunk-8](data:image/png;base64...)

```
timepoints <- gsub('^(Control|Death)', '', pData(es)$TREATMENT_NAME)
names(timepoints) <- colnames(es)
es.norm <- ct.normalizeGuides(es, 'FQ', annotation = ann, sampleKey = timepoints, plot.it = TRUE)
```

```
## Warning in ct.keyCheck(sampleKey, eset): Coercing the provided sample key to a
## factor. Control group set to: Expansion
```

![plot of chunk unnamed-chunk-8](data:image/png;base64...)

```
es.norm <- ct.normalizeGuides(es, 'slope', annotation = ann, sampleKey = sk, plot.it = TRUE)
```

![plot of chunk unnamed-chunk-8](data:image/png;base64...)

```
es.norm <- ct.normalizeGuides(es, 'controlScale', annotation = ann, sampleKey = sk, plot.it = TRUE, geneSymb = 'NoTarget')
```

![plot of chunk unnamed-chunk-8](data:image/png;base64...)

```
es.norm <- ct.normalizeGuides(es, 'controlSpline', annotation = ann, sampleKey = sk, plot.it = TRUE, geneSymb = 'NoTarget')
```

![plot of chunk unnamed-chunk-8](data:image/png;base64...)

##### 3.3 ct.makeQCReport

For convenience, experiment-level dynamics and the effects of various preprocessing steps may be automatically summarized in the form of a report. The following code isn’t run as part of this vignette, but if run from the terminal `path2QC` will indicate the path to an html Quality Control report.

```
#Not run:
path2QC <- ct.makeQCReport(es,
                 trim = 1000,
                 log2.ratio = 0.05,
                 sampleKey = sk,
                 annotation = ann,
                 aln = aln,
                 identifier = 'Crispr_QC_report',
                 lib.size = NULL
                 )
```

### 4.0 Quality Assessment

The `gCrisprTools` package provides a series of functions for assessing distributional and technical properties of sequencing libraries. Please see additional details about all of these methods on their respective manual pages.

##### 4.1 ct.rawCountDensities

The raw cassette count distributions can be visualized to determine whether samples were inadequately sequenced or if PCR amplification artifacts might be present.

```
ct.rawCountDensities(es, sk)
```

![plot of chunk unnamed-chunk-10](data:image/png;base64...)

##### 4.2 ct.gRNARankByReplicate

Aspects of cassette distributions are often better visualized with a ‘waterfall’ plot than a standard density estimate, which can clarify the ranking relationships in specific parts of the distribution.

```
ct.gRNARankByReplicate(es, sk)  #Visualization of gRNA abundance distribution
```

![plot of chunk unnamed-chunk-11](data:image/png;base64...)

These plots also enable explicit visualization of cassettes of interest in the context of the experimental distribution.

```
ct.gRNARankByReplicate(es, sk, annotation = ann, geneSymb = "Target1633")
```

![plot of chunk unnamed-chunk-12](data:image/png;base64...)

##### 4.3 ct.viewControls

`gCrisprTools` provides tools for visualizing the behavior of control gRNAs across experimental conditions.

```
ct.viewControls(es, ann, sk, normalize = FALSE, geneSymb = 'NoTarget')
```

![plot of chunk unnamed-chunk-13](data:image/png;base64...)

##### 4.4 ct.guideCDF

Depending on the screen in question, it can be useful to quantify the extent to which experimental libraries have been distorted by experimental treatments. `gCrisprTools` provides tools to estimate an empirical cumulative distribution function describing the cassettes or (targets) within a screen.

```
ct.guideCDF(es, sk, plotType = "gRNA")
```

![plot of chunk unnamed-chunk-14](data:image/png;base64...)

### 5.0 Identifying Candidate Targets

The core analytical machinery of gCrisprTools is built on the linear modelling framework implemented in the `limma` package. Specifically, users employ `limma/voom` to generate an experimental contrast of interest at the gRNA level. The model coefficent and P-value estimates may be subsequently processed with the infrastructure provided by `gCrisprTools`.

```
design <- model.matrix(~ 0 + REPLICATE_POOL + TREATMENT_NAME, pData(es))
colnames(design) <- gsub('TREATMENT_NAME', '', colnames(design))
contrasts <-makeContrasts(DeathExpansion - ControlExpansion, levels = design)

vm <- voom(exprs(es), design)

fit <- lmFit(vm, design)
fit <- contrasts.fit(fit, contrasts)
fit <- eBayes(fit)
```

##### 5.1 ct.generateResults

After generating a fit object (class `MArrayLM`) for a contrast of interest, we may summarize the signals from the various cassettes annotated to each target via RRA$\alpha$ aggregation. The core algorithm is described in detail in the original publication on Robust Rank Aggregation[1](#fn-1) and has been implemented according to the \(\alpha\) thresholding modification proposed by Li et al.[2](#fn-2) Briefly, gRNA signals contained in the specified fit object are ranked and normalized, and these ranks are grouped by the associated target and assigned a score (\(\rho\)) on the basis of the skewness of the gRNA signal ranks. The statistical significance of each target-level score is then assessed by permutation of the gRNA target assignments. *Q*-values are computed directly from the resulting *P*-value distributions using the FDR approach described by Benjamini and Hochberg.[3](#fn-3)

A more extensive treatment of RRA$\alpha$ and comparisons to MAGeCK may be found in `inst/Mageck_&_gCrisprTools.html`.

```
resultsDF <-
  ct.generateResults(
    fit,
    annotation = ann,
    RRAalphaCutoff = 0.1,
    permutations = 1000,
    scoring = "combined"
  )
```

The resulting dataframe contains columns passing some of the information from the fit and annotation objects, as well as a number of statistics describing the evidence for a target’s depletion or enrichment within the context of the screen. These include the Target-level *P* and *Q* values quantifying the evidence for enrichment or depletion, the median log2 fold change of all of the gRNAs associated with each target, and the rankings of the target-level \(/rho\) statistics (gene-level scores may be useful for ranking targets with equivalent *P*-values).

### 6.0 Visualization of Results

After identifying candidate targets, various aspects of the contrast may be visualized with `gCrisprTools`.

##### 6.1 ct.topTargets

The `ct.topTargets` function enables simple visualization of the model effect estimates (log2 fold changes) and associated uncertainties of all cassettes associated with the top-ranking targets.

```
ct.topTargets(fit,
              resultsDF,
              ann,
              targets = 10,
              enrich = TRUE)
```

![plot of chunk unnamed-chunk-17](data:image/png;base64...)

##### 6.2 ct.stackGuides

In some screens it can be useful to visualize the degree of library distortion associated with the strongest signals. Such an approach can supply additional confidence in a particular candidate of interest by showing that clear differences are evident outside of the linear modeling framework (which may be inaccurate in heavily distorted libraries).

```
ct.stackGuides(
  es,
  sk,
  plotType = "Target",
  annotation = ann,
  subset = names(sk)[grep('Expansion', sk)]
)
```

```
## Summarizing gRNA counts into targets.
```

![plot of chunk unnamed-chunk-18](data:image/png;base64...)

##### 6.3 ct.viewGuides

`gCrisprTools` provides methods to visualize the behavior of individual cassettes annotated to target of interest, and positions these within the observed distribution of effect sizes across all cassettes within the experiment.

```
ct.viewGuides("Target1633", fit, ann)
```

![plot of chunk unnamed-chunk-19](data:image/png;base64...)

##### 6.3 ct.signalSummary

Sometimes it can be useful to visualize known sets of targets together in the context of the full screen contrast:

```
ct.signalSummary(resultsDF,
                 targets = list('TargetSetA' = c(sample(unique(resultsDF$geneSymbol), 3)),
                                'TargetSetB' = c(sample(unique(resultsDF$geneSymbol), 2))))
```

![plot of chunk unnamed-chunk-20](data:image/png;base64...)

#### 6.4 ct.makeContrastReport and ct.makeReport

As with the Quality Control components of an individual screen, `gCrisprTools` provides functionality to automatically generate contrast-level reports.

```
#Not run:
path2Contrast <-
  ct.makeContrastReport(eset = es,
                        fit = fit,
                        sampleKey = sk,
                        results = resultsDF,
                        annotation = ann,
                        comparison.id = NULL,
                        identifier = 'Crispr_Contrast_Report')
```

If you wish, you can also make a single report encompassing both quality control and the contrast of interest.

```
#Not run:
path2report <-
  ct.makeReport(fit = fit,
                eset = es,
                sampleKey = sk,
                annotation = ann,
                results = resultsDF,
                aln = aln,
                outdir = ".")
```

### 7.0 Hypothesis Testing

In addition to identifying targets of interest within a screen, it may be worthwhile to ask more comprehensive questions about the targets identified. `gCrisprTools` provides a series of basic functions for determining the enrichment of known or unknown target groups within the context of a screen.

##### 7.1 ct.seas

If a screen was performed with a library targeting genes, `gCrisprTools` can provide basic ontological enrichment testing by leveraging the various functions available in the `sparrow` package.

```
#Not run:
genesetdb <- sparrow::getMSigGeneSetDb(collection = 'h', species = 'human', id.type = 'entrez')

# If you have a library that targets elements unevenly (e.g., variable numbers of
# elements/promoters per genes), you can conform it via GREAT
genesetdb.GREAT <- ct.GREATdb(ann, gsdb = genesetdb)

ct.seas(resultsDF, gdb = genesetdb)
#ct.seas(resultsDF, gdb = genesetdb.GREAT)
```

The `sparrow` package is quite rich, and the the possible applications and extensions of geneset testing in crispr screens are detailed in the `Crispr_example_workflow` and `Contrast_Comparisons` vignettes, and in the vignettes of the `sparrow` package.

##### 7.2 ct.targetSetEnrichment, ct.signalSummary, ct.ROC, and ct.PRC

In some cases, it may be useful to ask whether a set of known targets is disproportionately enriched or depleted within a screen. `gCrisprTools` provides functions for answering these sorts of questions with `ct.ROC()`, which generates Reciever-Operator Characteristics for a specified gene set within a screen, and `ct.PRC()`, which draws precision-recall curves. When called, both functions return the raw data necessary to reproduce or combine these results, along with appropriate statistics for assessing the significance of the overall signal within the specified target set (via a hypergeometric test).

```
data("essential.genes", package = "gCrisprTools")  #Artificial list created for demonstration
data("resultsDF", package = "gCrisprTools")
ROC <- ct.ROC(resultsDF, essential.genes, 'enrich')
```

![plot of chunk unnamed-chunk-24](data:image/png;base64...)

```
str(ROC)
```

```
## List of 6
##  $ sensitivity: num [1:142] 0 0 0 0 0 0 0 0 0 0 ...
##  $ specificity: num [1:142] 0.99 0.989 0.988 0.986 0.985 ...
##  $ AUC        : num 0.792
##  $ targets    : chr [1:99] "8877" "26999" "10061" "4050" ...
##  $ P.values   : num [1:8, 1:3] 0e+00 1e-05 1e-04 1e-03 1e-02 1e-01 5e-01 1e+00 0e+00 0e+00 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:3] "Cutoff" "Sig" "Hypergeometric_P"
##  $ Q.values   : num [1:8, 1:3] 0e+00 1e-05 1e-04 1e-03 1e-02 1e-01 5e-01 1e+00 0e+00 0e+00 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:3] "Cutoff" "Sig" "Hypergeometric_P"
```

```
PRC <- ct.PRC(resultsDF, essential.genes, 'enrich')
```

![plot of chunk unnamed-chunk-25](data:image/png;base64...)

```
str(PRC)
```

```
## List of 5
##  $ precision: num [1:144] 1 0 0 0 0 0 0 0 0 0 ...
##  $ recall   : num [1:144] 0 0 0 0 0 0 0 0 0 0 ...
##  $ targets  : chr [1:99] "8877" "26999" "10061" "4050" ...
##  $ P.values : num [1:8, 1:3] 0e+00 1e-05 1e-04 1e-03 1e-02 1e-01 5e-01 1e+00 0e+00 0e+00 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:3] "Cutoff" "Sig" "Hypergeometric_P"
##  $ Q.values : num [1:8, 1:3] 0e+00 1e-05 1e-04 1e-03 1e-02 1e-01 5e-01 1e+00 0e+00 0e+00 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:3] "Cutoff" "Sig" "Hypergeometric_P"
```

Alternatively, the significance of the enrichment within the target set may be assessed directly with `ct.targetSetEnrichment`.

```
##' tar <-  sample(unique(resultsDF$geneSymbol), 20)
##' res <- ct.targetSetEnrichment(resultsDF, tar)

targetsTest <- ct.targetSetEnrichment(resultsDF, essential.genes, enrich = FALSE)
str(targetsTest)
```

```
## List of 3
##  $ targets : chr [1:99] "8877" "26999" "10061" "4050" ...
##  $ P.values: num [1:8, 1:3] 0e+00 1e-05 1e-04 1e-03 1e-02 1e-01 5e-01 1e+00 2e+00 2e+00 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:3] "Cutoff" "Sig" "Hypergeometric_P"
##  $ Q.values: num [1:8, 1:3] 0e+00 1e-05 1e-04 1e-03 1e-02 1e-01 5e-01 1e+00 2e+00 2e+00 ...
##   ..- attr(*, "dimnames")=List of 2
##   .. ..$ : NULL
##   .. ..$ : chr [1:3] "Cutoff" "Sig" "Hypergeometric_P"
```

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
## [1] limma_3.66.0        gCrisprTools_2.16.0 Biobase_2.70.0
## [4] BiocGenerics_0.56.0 generics_0.1.4
##
## loaded via a namespace (and not attached):
##   [1] DBI_1.2.3                   gridExtra_2.3
##   [3] BiasedUrn_2.0.12            GSEABase_1.72.0
##   [5] BiocSet_1.24.0              rlang_1.1.6
##   [7] magrittr_2.0.4              clue_0.3-66
##   [9] GetoptLong_1.0.5            msigdbr_25.1.1
##  [11] sparrow_1.16.0              matrixStats_1.5.0
##  [13] compiler_4.5.1              RSQLite_2.4.3
##  [15] png_0.1-8                   vctrs_0.6.5
##  [17] pkgconfig_2.0.3             shape_1.4.6.1
##  [19] crayon_1.5.3                fastmap_1.2.0
##  [21] backports_1.5.0             magick_2.9.0
##  [23] XVector_0.50.0              labeling_0.4.3
##  [25] rmarkdown_2.30              markdown_2.0
##  [27] graph_1.88.0                purrr_1.1.0
##  [29] bit_4.6.0                   xfun_0.53
##  [31] cachem_1.1.0                litedown_0.7
##  [33] jsonlite_2.0.0              blob_1.2.4
##  [35] DelayedArray_0.36.0         BiocParallel_1.44.0
##  [37] irlba_2.3.5.1               parallel_4.5.1
##  [39] cluster_2.1.8.1             R6_2.6.1
##  [41] RColorBrewer_1.1-3          GenomicRanges_1.62.0
##  [43] assertthat_0.2.1            Rcpp_1.1.0
##  [45] Seqinfo_1.0.0               SummarizedExperiment_1.40.0
##  [47] iterators_1.0.14            knitr_1.50
##  [49] IRanges_2.44.0              Matrix_1.7-4
##  [51] tidyselect_1.2.1            dichromat_2.0-0.1
##  [53] abind_1.4-8                 viridis_0.6.5
##  [55] doParallel_1.0.17           codetools_0.2-20
##  [57] curl_7.0.0                  plyr_1.8.9
##  [59] lattice_0.22-7              tibble_3.3.0
##  [61] withr_3.0.2                 KEGGREST_1.50.0
##  [63] S7_0.2.0                    evaluate_1.0.5
##  [65] ontologyIndex_2.12          circlize_0.4.16
##  [67] Biostrings_2.78.0           pillar_1.11.1
##  [69] MatrixGenerics_1.22.0       checkmate_2.3.3
##  [71] foreach_1.5.2               stats4_4.5.1
##  [73] plotly_4.11.0               S4Vectors_0.48.0
##  [75] ggplot2_4.0.0               commonmark_2.0.0
##  [77] scales_1.4.0                xtable_1.8-4
##  [79] glue_1.8.0                  lazyeval_0.2.2
##  [81] tools_4.5.1                 BiocIO_1.20.0
##  [83] data.table_1.17.8           fgsea_1.36.0
##  [85] annotate_1.88.0             locfit_1.5-9.12
##  [87] babelgene_22.9              XML_3.99-0.19
##  [89] fastmatch_1.1-6             cowplot_1.2.0
##  [91] grid_4.5.1                  Cairo_1.7-0
##  [93] tidyr_1.3.1                 AnnotationDbi_1.72.0
##  [95] edgeR_4.8.0                 colorspace_2.1-2
##  [97] cli_3.6.5                   S4Arrays_1.10.0
##  [99] viridisLite_0.4.2           ComplexHeatmap_2.26.0
## [101] dplyr_1.1.4                 gtable_0.3.6
## [103] digest_0.6.37               SparseArray_1.10.0
## [105] rjson_0.2.23                htmlwidgets_1.6.4
## [107] farver_2.1.2                memoise_2.0.1
## [109] htmltools_0.5.8.1           lifecycle_1.0.4
## [111] httr_1.4.7                  mime_0.13
## [113] GlobalOptions_0.1.2         statmod_1.5.1
## [115] bit64_4.6.0-1
```

1. Kolde R, Laur S, Adler P, Vilo J. Robust rank aggregation for gene list integration and meta-analysis. Bioinformatics. 2012;28(4):573-80. PMID:22247279 [↩](#fnref-1)
2. Li W, Xu H, Xiao T, Cong L, Love MI, Zhang F, Irizarry RA, Liu JS, Brown M, Liu XS. MAGeCK enables robust identification of essential genes from genome-scale CRISPR/Cas9 knockout screens. Genome Biol. 2014;15(12):554. PMID:25476604 [↩](#fnref-2)
3. Benjamini Y, Hochberg Y. Controlling the false discovery rate: a practical and powerful approach to multiple testing. Journal of the Royal Statistical Society, Series B. 1995;57(1):289–300. MR 1325392. [↩](#fnref-3)