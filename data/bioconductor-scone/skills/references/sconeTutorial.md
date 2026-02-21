# Introduction to SCONE

Michael Cole and Davide Risso

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
  + [1.1 Human Neurogenesis](#human-neurogenesis)
  + [1.2 Visualizing Technical Variability and Batch Effects](#visualizing-technical-variability-and-batch-effects)
  + [1.3 Drop-out Characteristics](#drop-out-characteristics)
  + [1.4 The `scone` Workflow](#the-scone-workflow)
* [2 Sample Filtering with `metric_sample_filter`](#sample-filtering-with-metric_sample_filter)
  + [2.1 On Threshold Selection](#on-threshold-selection)
  + [2.2 Applying the sample filter](#applying-the-sample-filter)
* [3 Running and Scoring Normalization Workflows with `scone`](#running-and-scoring-normalization-workflows-with-scone)
  + [3.1 Creating a SconeExperiment Object](#creating-a-sconeexperiment-object)
  + [3.2 Defining Normalization Modules](#defining-normalization-modules)
  + [3.3 Selecting SCONE Workflows](#selecting-scone-workflows)
  + [3.4 Calling `scone` with `run=TRUE`](#calling-scone-with-runtrue)
* [4 Step 3: Selecting a normalization for downstream analysis](#step-3-selecting-a-normalization-for-downstream-analysis)
* [5 Session Info](#session-info)

# 1 Introduction

Single-cell RNA sequencing (scRNA-Seq) technologies are opening the way for
transcriptome-wide profiling across diverse and complex mammalian tissues,
facilitating unbiased identification of novel cell sub-populations and
discovery of novel cellular function. As in other high-throughput analyses, a
large fraction of the variability observed in scRNA-Seq data results from batch
effects and other technical artifacts (Hicks, Teng, and Irizarry [2015](#ref-hicks2015)). In particular, a unique
reliance on minuscule amounts of starting mRNA can lead to widespread “drop-out
effects,” in which expressed transcripts are missed during library preparation
and sequencing. Due to the biases inherent to these assays, data normalization
is an essential step prior to many downstream analyses. As we face a growing
cohort of scRNA-Seq technologies, diverse biological contexts, and novel
experimental designs, we cannot reasonably expect to find a one-size-fits-all
solution to data normalization.

`scone` supports a rational, data-driven framework for assessing the efficacy
of various normalization workflows, encouraging users to explore trade-offs
inherent to their data prior to finalizing their data normalization strategy.
We provide an interface for running multiple normalization workflows in
parallel, and we offer tools for ranking workflows and visualizing
study-specific trade-offs.

This package was originally developed to address normalization problems
specific to scRNA-Seq expression data, but it should be emphasized that its use
is not limited to scRNA-Seq data normalization. Analyses based on other
high-dimensional data sets - including bulk RNA-Seq data sets - can utilize
tools implemented in the `scone` package.

## 1.1 Human Neurogenesis

We will demonstrate the basic `scone` workflow by using an early scRNA-Seq data
set (Pollen et al. [2014](#ref-pollen2014)). We focus on a set of 65 human cells sampled from four
biological conditions: Cultured neural progenitor cells (“NPC”) derived from
pluripotent stem cells, primary cortical samples at gestation weeks 16 and 21
(“GW16” and “GW21” respectively) and late cortical samples cultured for 3 weeks
(“GW21+3”). Gene-level expression data for these cells can be loaded directly
from the `scRNAseq` package on
[Bioconductor](http://bioconductor.org/packages/scRNAseq/).

```
library(scRNAseq)

## ----- Load Example Data -----
fluidigm <- ReprocessedFluidigmData(assays = "rsem_counts")
assay(fluidigm) <- as.matrix(assay(fluidigm))
```

The `rsem_counts` assay contains expected gene-level read counts via RSEM
(Li and Dewey [2011](#ref-li2011)) quantification of 130 single-cell libraries aligned to the hg38
RefSeq transcriptome. The data object also contains library transcriptome
alignment metrics obtained from
[Picard](http://broadinstitute.github.io/picard/) and other basic tools.

```
## ----- List all QC fields -----

# List all qc fields (accessible via colData())
metadata(fluidigm)$which_qc
```

```
##  [1] "NREADS"                       "NALIGNED"
##  [3] "RALIGN"                       "TOTAL_DUP"
##  [5] "PRIMER"                       "INSERT_SZ"
##  [7] "INSERT_SZ_STD"                "COMPLEXITY"
##  [9] "NDUPR"                        "PCT_RIBOSOMAL_BASES"
## [11] "PCT_CODING_BASES"             "PCT_UTR_BASES"
## [13] "PCT_INTRONIC_BASES"           "PCT_INTERGENIC_BASES"
## [15] "PCT_MRNA_BASES"               "MEDIAN_CV_COVERAGE"
## [17] "MEDIAN_5PRIME_BIAS"           "MEDIAN_3PRIME_BIAS"
## [19] "MEDIAN_5PRIME_TO_3PRIME_BIAS"
```

All cell-level metadata, such as cell origin and sequence coverage (“low” vs
“high” coverage) can be accessed using `colData()`:

```
# Joint distribution of "biological condition"" and "coverage type""
table(colData(fluidigm)$Coverage_Type,
      colData(fluidigm)$Biological_Condition)
```

```
##
##        GW16 GW21 GW21+3 NPC
##   High   26    8     16  15
##   Low    26    8     16  15
```

Each cell had been sequenced twice, at different levels of coverage. In this
vignette we will focus on the high-coverage data. Before we get started we will
do some preliminary filtering to remove the low-coverage replicates and
undetected gene features:

```
# Preliminary Sample Filtering: High-Coverage Only
is_select = colData(fluidigm)$Coverage_Type == "High"
fluidigm = fluidigm[,is_select]

# Retain only detected transcripts
fluidigm = fluidigm[which(apply(assay(fluidigm) > 0,1,any)),]
```

## 1.2 Visualizing Technical Variability and Batch Effects

One of our alignment quality readouts is the fraction of reads aligned to the
transcriptome. We can use simple bar plots to visualize how this metric relates
to the biological batch.

```
# Define a color scheme
cc <- c(brewer.pal(9, "Set1"))

# One batch per Biological Condition
batch = factor(colData(fluidigm)$Biological_Condition)

# Alignment Quality Metrics
qc = colData(fluidigm)[,metadata(fluidigm)$which_qc]

# Barplot of read proportion mapping to human transcriptome
ralign = qc$RALIGN
o = order(ralign)[order(batch[order(ralign)])] # Order by batch, then value

barplot(ralign[o], col=cc[batch][o],
        border=cc[batch][o], main="Percentage of reads mapped")
legend("bottomleft", legend=levels(batch), fill=cc,cex=0.4)
```

![](data:image/png;base64...)

We can see modest differences between batches, and we see that there is one
GW21 cell with a particularly low alignment rate relative to the rest of the
GW21 batch. These types of observations can inform us of “poor-quality”
libraries or batches. We may alternatively consider the number of reads for
each library:

```
# Barplot of total read number
nreads = qc$NREADS
o = order(nreads)[order(batch[order(nreads)])] # Order by batch, then value

barplot(nreads[o], col=cc[batch][o],
        border=cc[batch][o], main="Total number of reads")
legend("topright", legend=levels(batch), fill=cc, cex=0.4)
```

![](data:image/png;base64...)

We see that read coverage varies substantially between batches as well as
within batches. These coverage differences and other technical features can
induce non-intuitive biases upon expression estimates. Though some biases can
be addressed with simple library-size normalization and cell-filtering, demand
for greater cell numbers may require more sophisticated normalization methods
in order to compare multiple batches of cells. Batch-specific biases are
impossible to address directly in this study as biological origin and sample
preparation are completely confounded.

While it can be very helpful to visualize distributions of single quality
metrics it should be noted that QC metrics are often correlated. In some cases
it may be more useful to consider Principal Components (PCs) of the quality
matrix, identifying latent factors of protocol variation:

```
## ----- PCA of QC matrix -----
qpc = prcomp(qc,center = TRUE,scale. = TRUE)
barplot((qpc$sdev^2)/sum(qpc$sdev^2), border="gray",
        xlab="PC", ylab="Proportion of Variance", main="Quality PCA")
```

![](data:image/png;base64...)

Even though 19 different QC metrics have been quantified in this analysis, PCA
shows us that only a small number of PCs are needed to described a majority of
the QC variance (e.g. 3 to explain 76%). We will now visualize the distribution
of the first PC in the context of batch:

```
# Barplot of PC1 of the QC matrix
qc1 = as.vector(qpc$x[,1])
o = order(qc1)[order(batch[order(qc1)])]

barplot(qc1[o], col=cc[batch][o],
        border=cc[batch][o], main="Quality PC1")
legend("bottomright", legend=levels(batch),
       fill=cc, cex=0.8)
```

![](data:image/png;base64...)

This first PC appears to represent both inter-batch and intra-batch sample
heterogeneity, similar the the total number of reads. If this latent factor
reflects variation in sample preparation, we may expect expression artifacts to
trace this factor as well: in other words, we should be very skeptical of genes
for which expression correlates strongly with the first PC of quality metrics.
In this vignette we will show how latent factors like this can be applied to
the normalization problem.

## 1.3 Drop-out Characteristics

Before we move on to normalization, let’s briefly consider a uniquely
single-cell problem: “drop-outs.” One of the greatest challenges in modeling
drop-out effects is modeling both i) technical drop-outs and ii) biological
expression heterogeneity. One way to simplify the problem is to focus on genes
for which we have strong prior belief in true expression. The `scone` package
contains lists of genes that are believed to be ubiquitously and even uniformly
expressed across human tissues. If we assume these genes are truly expressed in
all cells, we can label all zero abundance observations as drop-out events. We
model detection failures as a logistic function of mean expression, in line
with the standard logistic model for drop-outs employed by the field:

```
# Extract Housekeeping Genes
data(housekeeping)
hk = intersect(housekeeping$V1,rownames(assay(fluidigm)))

# Mean log10(x+1) expression
mu_obs = rowMeans(log10(assay(fluidigm)[hk,]+1))

# Assumed False Negatives
drop_outs = assay(fluidigm)[hk,] == 0

# Logistic Regression Model of Failure
ref.glms = list()
for (si in 1:dim(drop_outs)[2]){
  fit = glm(cbind(drop_outs[,si],1 - drop_outs[,si]) ~ mu_obs,
            family=binomial(logit))
  ref.glms[[si]] = fit$coefficients
}
```

The list `ref.glm` contains the intercept and slope of each fit. We can now
visualize the fit curves and the corresponding Area Under the Curves (AUCs):

```
par(mfrow=c(1,2))

# Plot Failure Curves and Calculate AUC
plot(NULL, main = "False Negative Rate Curves",
     ylim = c(0,1),xlim = c(0,6),
     ylab = "Failure Probability", xlab = "Mean log10 Expression")
x = (0:60)/10
AUC = NULL
for(si in 1:ncol(assay(fluidigm))){
  y = 1/(exp(-ref.glms[[si]][1] - ref.glms[[si]][2] * x) + 1)
  AUC[si] = sum(y)/10
  lines(x, 1/(exp(-ref.glms[[si]][1] - ref.glms[[si]][2] * x) + 1),
        type = 'l', lwd = 2, col = cc[batch][si])
}

# Barplot of FNR AUC
o = order(AUC)[order(batch[order(AUC)])]

barplot(AUC[o], col=cc[batch][o], border=cc[batch][o], main="FNR AUC")
legend("topright", legend=levels(batch), fill=cc, cex=0.4)
```

![](data:image/png;base64...)

Model-based metrics such as these may be more interpretable with respect to
upstream sample preparation, and can be very useful for assessing single-cell
library quality.

## 1.4 The `scone` Workflow

So far we have only described potential problems with single-cell expression
data. Now we will take steps to address problems with our example data set. The
basic QC and normalization pipeline we will use in this vignette allows us to:

* Filter out poor libraries using the `metric_sample_filter` function.
* Run and score many different normalization workflows
  (different combinations of normalization modules)
  using the main `scone` function.
* Browse top-ranked methods and visualize trade-offs with the
  `biplot_color` and `sconeReport` function.

In order to run many different workflows, SCONE relies on a normalization
workflow template composed of 3 modules:

1. Data imputation: replacing zero-abundance values with expected values under
   a prior drop-out model. As we will see below, this module may be used as a
   modifier for module 2, without passing imputed values forward to downstream
   analyses. 2) Scaling or quantile normalization: either i) normalization that
   scales each sample’s transcriptome abundances by a single factor or ii) more
   complex offsets that match quantiles across samples. Examples: TMM or DESeq
   scaling factors, upper quartile normalization, or full-quantile normalization.
2. Regression-based approaches for removing unwanted correlated variation from
   the data, including batch effects. Examples: RUVg (Risso et al. [2014](#ref-risso2014)) or regression on
   Quality Principal Components described above.

# 2 Sample Filtering with `metric_sample_filter`

The most basic sample filtering function in `scone` is the
`metric_sample_filter`. The function takes a consensus approach, retaining
samples that pass multiple data-driven criteria.

`metric_sample_filter` takes as input an expression matrix. The output depends
on arguments provided, but generally consists of a list of 4 logicals
designating each sample as having failed (TRUE) or passed (FALSE)
threshold-based filters on 4 sample metrics:

* Number of reads.
* Ratio of reads aligned to the genome.
  Requires the `ralign` argument.
* “Transcriptome breadth” - Defined here as the proportion of “high-quality”
  genes detected in the sample. Requires the `gene_filter` argument.
* FNR AUC. Requires the `pos_controls` argument.

If required arguments are missing for any of the 4, the function will simply
return NA instead of the corresponding logical.

```
# Initial Gene Filtering:
# Select "common" transcripts based on proportional criteria.
num_reads = quantile(assay(fluidigm)[assay(fluidigm) > 0])[4]
num_cells = 0.25*ncol(fluidigm)
is_common = rowSums(assay(fluidigm) >= num_reads ) >= num_cells

# Metric-based Filtering
mfilt = metric_sample_filter(assay(fluidigm),
                             nreads = colData(fluidigm)$NREADS,
                             ralign = colData(fluidigm)$RALIGN,
                             gene_filter = is_common,
                             pos_controls = rownames(fluidigm) %in% hk,

                             zcut = 3, mixture = FALSE,
                             plot = TRUE)
```

![](data:image/png;base64...)

```
# Simplify to a single logical
mfilt = !apply(simplify2array(mfilt[!is.na(mfilt)]),1,any)
```

In the call above, we have set the following parameters:

* zcut = 3. Filter leniency (see below).
* mixture = FALSE. Mixture modeling will not be used (see below).
* plot = TRUE. Plot distributions of metrics before and after filtering.

## 2.1 On Threshold Selection

Let’s take a closer look at the computation behind selecting the ralign filter.
In choosing a threshold value 67.7, `metric_sample_filter` is taking 4 values
into account:

1. `hard_ralign`, the default “hard” threshold at 15 - rather forgiving… 2) 3
   (`zcut`) times the standard deviation below the mean `ralign` value. 3) 3
   (`zcut`) times the MAD below the median `ralign` value. 4) `suff_ralign`, the
   sufficient threshold set to NULL by default.

```
hist(qc$RALIGN, breaks = 0:100)
# Hard threshold
abline(v = 15, col = "yellow", lwd = 2)
# 3 (zcut) standard deviations below the mean ralign value
abline(v = mean(qc$RALIGN) - 3*sd(qc$RALIGN), col = "green", lwd = 2)
# 3 (zcut) MADs below the median ralign value
abline(v = median(qc$RALIGN) - 3*mad(qc$RALIGN), col = "red", lwd = 2)
# Sufficient threshold
abline(v = NULL, col = "grey", lwd = 2)

# Final threshold is the minimum of
# 1) the sufficient threshold and
# 2) the max of all others
thresh = min(NULL,
             max(c(15,mean(qc$RALIGN) - 3*sd(qc$RALIGN),
                   median(qc$RALIGN) - 3*mad(qc$RALIGN))))
abline(v = thresh, col = "blue", lwd = 2, lty = 2)

legend("topleft",legend = c("Hard","SD","MAD","Sufficient","Final"),
       lwd = 2, col = c("yellow","green","red","grey","blue"),
       lty = c(1,1,1,1,2), cex = .5)
```

![](data:image/png;base64...)

We see here that the 3rd “MAD” threshold exceeds the first two thresholds
(“Hard” and “SD”), and as the “Sufficient” threshold is NULL
`metric_sample_filter` settles for the the third threshold. If the “Sufficient”
threshold was not NULL and was exceeded by any of the other three thresholds
(“Hard”,“SD”,“MAD”), `metric_sample_filter` would settle for the “Sufficient”
threshold. Note also that if `mixture=TRUE` an additional criterion is
considered: distributions may be fit to a two-component mixture model, and a
threshold is defined with respect to the mean and standard deviation of the
“best” component.

As `metric_sample_filter` relies on a maximum of candidate thresholds, we
recommend users treat this function as a stringent sample filter.

## 2.2 Applying the sample filter

With the `metric_sample_filter` output in hand, it is fairly straightforward to
remove the one “poor” sample from our study:

```
goodDat = fluidigm[,mfilt]

# Final Gene Filtering: Highly expressed in at least 5 cells
num_reads = quantile(assay(fluidigm)[assay(fluidigm) > 0])[4]
num_cells = 5
is_quality = rowSums(assay(fluidigm) >= num_reads ) >= num_cells
```

# 3 Running and Scoring Normalization Workflows with `scone`

Not only does `scone` normalize expression data, but it also provides a
framework for evaluating the performance of normalization workflows.

## 3.1 Creating a SconeExperiment Object

Prior to running main `scone` function we will want to define a
`SconeExperiment` object that contains the primary expression data,
experimental metadata, and control gene sets.

```
# Expression Data (Required)
expr = assay(goodDat)[is_quality,]

# Biological Origin - Variation to be preserved (Optional)
bio = factor(colData(goodDat)$Biological_Condition)

# Processed Alignment Metrics - Variation to be removed (Optional)
qc = colData(goodDat)[,metadata(goodDat)$which_qc]
ppq = scale(qc[,apply(qc,2,sd) > 0],center = TRUE,scale = TRUE)

# Positive Control Genes - Prior knowledge of DE (Optional)
poscon = intersect(rownames(expr),strsplit(paste0("ALS2, CDK5R1, CYFIP1,",
                                                  " DPYSL5, FEZ1, FEZ2, ",
                                                  "MAPT, MDGA1, NRCAM, ",
                                                  "NRP1, NRXN1, OPHN1, ",
                                                  "OTX2, PARD6B, PPT1, ",
                                                  "ROBO1, ROBO2, RTN1, ",
                                                  "RTN4, SEMA4F, SIAH1, ",
                                                  "SLIT2, SMARCA1, THY1, ",
                                                  "TRAPPC4, UBB, YWHAG, ",
                                                  "YWHAH"),split = ", ")[[1]])

# Negative Control Genes - Uniformly expressed transcripts (Optional)
negcon = intersect(rownames(expr),hk)

# Creating a SconeExperiment Object
my_scone <- SconeExperiment(expr,
                qc=ppq, bio = bio,
                negcon_ruv = rownames(expr) %in% negcon,
                poscon = rownames(expr) %in% poscon
)
```

## 3.2 Defining Normalization Modules

Before we can decide which workflows (normalizations) we will want to compare,
we will also need to define the types of scaling functions we will consider in
the comparison of normalizations:

```
## ----- User-defined function: Dividing by number of detected genes -----

EFF_FN = function (ei)
{
  sums = colSums(ei > 0)
  eo = t(t(ei)*sums/mean(sums))
  return(eo)
}

## ----- Scaling Argument -----

scaling=list(none=identity, # Identity - do nothing

             eff = EFF_FN, # User-defined function

             sum = SUM_FN, # SCONE library wrappers...
             tmm = TMM_FN,
             uq = UQ_FN,
             fq = FQT_FN,
             psi = PSINORM_FN,
             deseq = DESEQ_FN)
```

If imputation is to be included in the comparison, imputation arguments must
also be provided by the user:

```
# Simple FNR model estimation with SCONE::estimate_ziber
fnr_out = estimate_ziber(x = expr, bulk_model = TRUE,
                         pos_controls = rownames(expr) %in% hk,
                         maxiter = 10000)

## ----- Imputation List Argument -----
imputation=list(none=impute_null, # No imputation
                expect=impute_expectation) # Replace zeroes

## ----- Imputation Function Arguments -----
# accessible by functions in imputation list argument
impute_args = list(p_nodrop = fnr_out$p_nodrop, mu = exp(fnr_out$Alpha[1,]))

my_scone <- scone(my_scone,
                imputation = imputation, impute_args = impute_args,
                scaling=scaling,
                k_qc=3, k_ruv = 3,
                adjust_bio="no",
                run=FALSE)
```

Note, that because the imputation step is quite slow, we do not run it here,
but will run scone without imputation.

## 3.3 Selecting SCONE Workflows

The main `scone` method arguments allow for a lot of flexibility, but a user
may choose to run very specific combinations of modules. For this purpose,
`scone` can be run in `run=FALSE` mode, generating a list of workflows to be
performed and storing this list within a `SconeExperiment` object. After
running this command the list can be extracted using the `get_params` method.

```
my_scone <- scone(my_scone,
                scaling=scaling,
                k_qc=3, k_ruv = 3,
                adjust_bio="no",
                run=FALSE)

head(get_params(my_scone))
```

```
##                                 imputation_method scaling_method uv_factors
## none,none,no_uv,no_bio,no_batch              none           none      no_uv
## none,eff,no_uv,no_bio,no_batch               none            eff      no_uv
## none,sum,no_uv,no_bio,no_batch               none            sum      no_uv
## none,tmm,no_uv,no_bio,no_batch               none            tmm      no_uv
## none,uq,no_uv,no_bio,no_batch                none             uq      no_uv
## none,fq,no_uv,no_bio,no_batch                none             fq      no_uv
##                                 adjust_biology adjust_batch
## none,none,no_uv,no_bio,no_batch         no_bio     no_batch
## none,eff,no_uv,no_bio,no_batch          no_bio     no_batch
## none,sum,no_uv,no_bio,no_batch          no_bio     no_batch
## none,tmm,no_uv,no_bio,no_batch          no_bio     no_batch
## none,uq,no_uv,no_bio,no_batch           no_bio     no_batch
## none,fq,no_uv,no_bio,no_batch           no_bio     no_batch
```

In the call above, we have set the following parameter arguments:

* k\_ruv = 3.
  The maximum number of RUVg factors to consider.
* k\_qc = 3.
  The maximum number of quality PCs (QPCs) to be included in a linear model,
  analogous to RUVg normalization. The qc argument must be provided.
* adjust\_bio = “no.” Biological origin will NOT be included in RUVg or QPC
  regression models. The bio argument will be provided for evaluation purposes.

These arguments translate to the following set of options:

```
apply(get_params(my_scone),2,unique)
```

```
## $imputation_method
## [1] "none"
##
## $scaling_method
## [1] "none"  "eff"   "sum"   "tmm"   "uq"    "fq"    "psi"   "deseq"
##
## $uv_factors
## [1] "no_uv"   "ruv_k=1" "ruv_k=2" "ruv_k=3" "qc_k=1"  "qc_k=2"  "qc_k=3"
##
## $adjust_biology
## [1] "no_bio"
##
## $adjust_batch
## [1] "no_batch"
```

Some scaling methods, such as scaling by gene detection rate (`EFF_FN()`), will
not make sense within the context of imputed data, as imputation replaces
zeroes with non-zero values. We can use the `select_methods` method to produce
a `SconeExperiment` object initialized to run only meaningful normalization
workflows.

```
is_screened = ((get_params(my_scone)$imputation_method == "expect") &
                 (get_params(my_scone)$scaling_method %in% c("none",
                                                             "eff")))

my_scone = select_methods(my_scone,
                          rownames(get_params(my_scone))[!is_screened ])
```

## 3.4 Calling `scone` with `run=TRUE`

Now that we have selected our workflows, we can run `scone` in `run=TRUE` mode.
As well as arguments used in `run=FALSE` mode, this mode relies on a few
additional arguments. In order to understand these arguments, we must first
understand the 8 metrics used to evaluate each normalization. The first 6
metrics rely on a reduction of the normalized data down to 3 dimensions via PCA
(default). Each metric is taken to have a positive (higher is better) or
negative (lower is better) signature.

* BIO\_SIL: Preservation of Biological Difference.
  The average silhouette width of clusters defined by `bio`, defined with
  respect to a Euclidean distance metric over the first 3 expression PCs.
  Positive signature.
* BATCH\_SIL: Removal of Batch Structure.
  The average silhouette width of clusters defined by `batch`, defined with
  respect to a Euclidean distance metric over the first 3 expression PCs.
  Negative signature.
* PAM\_SIL: Preservation of Single-Cell Heterogeneity.
  The maximum average silhouette width of clusters defined by PAM clustering,
  defined with respect to a Euclidean distance metric over the first 3
  expression PCs.
  Positive signature.
* EXP\_QC\_COR: Removal of Alignment Artifacts.
  R^2 measure for regression of first 3 expression PCs on
  first `k_qc` QPCs.
  Negative signature.
* EXP\_UV\_COR: Removal of Expression Artifacts.
  R^2 measure for regression of first 3 expression PCs on
  first 3 PCs of the negative control (specified by `eval_negcon` or
  `ruv_negcon` by default) sub-matrix of the original (raw) data.
  Negative signature.
* EXP\_WV\_COR: Preservation of Biological Variance.
  R^2 measure for regression of first 3 expression PCs on
  first 3 PCs of the positive control (specified by `eval_poscon`)
  sub-matrix of the original (raw) data.
  Positive signature.
* RLE\_MED: Reduction of Global Differential Expression.
  The mean squared-median Relative Log Expression (RLE).
  Negative signature.
* RLE\_IQR: Reduction of Global Differential Variability.
  The variance of the inter-quartile range (IQR) of the RLE.
  Negative signature.

```
BiocParallel::register(
  BiocParallel::SerialParam()
) # Register BiocParallel Serial Execution

my_scone <- scone(my_scone,
                  scaling=scaling,
                  run=TRUE,
                  eval_kclust = 2:6,
                  stratified_pam = TRUE,
                  return_norm = "in_memory",
                  zero = "postadjust")
```

In the call above, we have set the following parameter arguments:

* eval\_kclust = 2:6.
  For PAM\_SIL, range of k (# of clusters) to use when computing
  maximum average silhouette width of PAM clusterings.
* stratified\_pam = TRUE.
  For PAM\_SIL, apply separate PAM clusterings to each biological
  batch rather than across all batches. Average is weighted by
  batch group size.
* return\_norm = “in\_memory”.
  Store all normalized matrices in addition to evaluation data.
  Otherwise normalized data is not returned in the resulting
  object.
* zero = “postadjust”.
  Restore data entries that are originally zeroes / negative after
  normalization to zero after the adjustment step.

The output will contain various updated elements:

```
# View Metric Scores
head(get_scores(my_scone))
```

```
##                                    BIO_SIL   PAM_SIL EXP_QC_COR EXP_UV_COR
## none,uq,ruv_k=1,no_bio,no_batch  0.2999009 0.6027087 -0.7687707 -0.4064851
## none,fq,no_uv,no_bio,no_batch    0.3019147 0.5558012 -0.8327434 -0.6553034
## none,uq,ruv_k=2,no_bio,no_batch  0.2335280 0.5106264 -0.7438718 -0.4022547
## none,fq,ruv_k=1,no_bio,no_batch  0.2798231 0.4621010 -0.7798794 -0.4685371
## none,psi,ruv_k=2,no_bio,no_batch 0.2639432 0.4550877 -0.7466728 -0.3252813
## none,uq,ruv_k=3,no_bio,no_batch  0.2456939 0.4646160 -0.7579988 -0.3475772
##                                  EXP_WV_COR      RLE_MED     RLE_IQR
## none,uq,ruv_k=1,no_bio,no_batch   0.4026451 -0.059523383 -0.10170726
## none,fq,no_uv,no_bio,no_batch     0.5878819 -0.013334022 -0.04482276
## none,uq,ruv_k=2,no_bio,no_batch   0.4238010 -0.058967735 -0.09460102
## none,fq,ruv_k=1,no_bio,no_batch   0.4430293 -0.005462639 -0.07016376
## none,psi,ruv_k=2,no_bio,no_batch  0.4399643 -0.057854898 -0.19168375
## none,uq,ruv_k=3,no_bio,no_batch   0.4175758 -0.058506600 -0.10121989
```

```
# View Mean Score Rank
head(get_score_ranks(my_scone))
```

```
##  none,uq,ruv_k=1,no_bio,no_batch    none,fq,no_uv,no_bio,no_batch
##                         40.85714                         39.28571
##  none,uq,ruv_k=2,no_bio,no_batch  none,fq,ruv_k=1,no_bio,no_batch
##                         39.14286                         37.42857
## none,psi,ruv_k=2,no_bio,no_batch  none,uq,ruv_k=3,no_bio,no_batch
##                         36.85714                         36.71429
```

```
# Extract normalized data from top method
out_norm = get_normalized(my_scone,
                          method = rownames(get_params(my_scone))[1])
```

`get_scores` returns the 8 raw metrics for each normalization multiplied by
their signature - or “scores.” `get_score_ranks` returns the mean score rank
for each normalization. Both of these are sorted in decreasing order by mean
score rank. Finally `get_normalized` returns the normalized expression data for
the requested method. If the normalized data isn’t stored in the object it will
be recomputed.

# 4 Step 3: Selecting a normalization for downstream analysis

Based on our sorting criteria, it would appear that
`none,uq,ruv_k=1,no_bio,no_batch` performs well compared to other normalization
workflows. A useful way to visualize this method with respect to others is the
`biplot_color` function

```
pc_obj = prcomp(apply(t(get_scores(my_scone)),1,rank),
                center = TRUE,scale = FALSE)
bp_obj = biplot_color(pc_obj,y = -get_score_ranks(my_scone),expand = .6)
```

![](data:image/png;base64...)

We have colored each point above according the corresponding method’s mean
score rank (yellow vs blue ~ good vs bad), and we can see that workflows span a
continuum of metric performance. Most importantly - and perhaps to no surprise
- there is evidence of strong trade-offs between i) Preserving clustering and
wanted variation and ii) removing unwanted variation. At roughly 90 degrees to
this axis is a direction in which distributional properties of relative
log-expression (RLE\_MED and RLE\_IQR) improve. Let’s visualize the
top-performing method and it’s relation to un-normalized data (“no-op”
normalization):

```
bp_obj = biplot_color(pc_obj,y = -get_score_ranks(my_scone),expand = .6)

points(t(bp_obj[1,]), pch = 1, col = "red", cex = 1)
points(t(bp_obj[1,]), pch = 1, col = "red", cex = 1.5)

points(t(bp_obj[rownames(bp_obj) == "none,none,no_uv,no_bio,no_batch",]),
       pch = 1, col = "blue", cex = 1)
points(t(bp_obj[rownames(bp_obj) == "none,none,no_uv,no_bio,no_batch",]),
       pch = 1, col = "blue", cex = 1.5)

arrows(bp_obj[rownames(bp_obj) == "none,none,no_uv,no_bio,no_batch",][1],
       bp_obj[rownames(bp_obj) == "none,none,no_uv,no_bio,no_batch",][2],
       bp_obj[1,][1],
       bp_obj[1,][2],
       lty = 2, lwd = 2)
```

![](data:image/png;base64...)

The arrow we’ve added to the plot traces a line from the “no-op” normalization
to the top-ranked normalization in SCONE. We see that SCONE has selected a
method in-between the two extremes, reducing the signal of unwanted variation
while preserving biological signal.

Finally, another useful function for browsing results is `sconeReport`. This
function launches a shiny app for evaluating performance of specific
normalization workflows.

```
# Methods to consider
scone_methods = c(rownames(get_params(my_scone))[1:12],
                  "none,none,no_uv,no_bio,no_batch")

# Shiny app
sconeReport(my_scone,methods = scone_methods,
            qc = ppq,
            bio = bio,
            negcon = negcon, poscon = poscon)
```

# 5 Session Info

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] scRNAseq_2.23.1             RColorBrewer_1.1-3
##  [3] TENxPBMCData_1.27.0         HDF5Array_1.38.0
##  [5] h5mread_1.2.0               rhdf5_2.54.0
##  [7] DelayedArray_0.36.0         SparseArray_1.10.0
##  [9] S4Arrays_1.10.0             abind_1.4-8
## [11] Matrix_1.7-4                scone_1.34.0
## [13] cluster_2.1.8.1             scater_1.38.0
## [15] ggplot2_4.0.0               scuttle_1.20.0
## [17] splatter_1.34.0             SingleCellExperiment_1.32.0
## [19] SummarizedExperiment_1.40.0 Biobase_2.70.0
## [21] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [23] IRanges_2.44.0              S4Vectors_0.48.0
## [25] BiocGenerics_0.56.0         generics_0.1.4
## [27] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [29] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] segmented_2.1-4           ProtGenerics_1.42.0
##   [3] bitops_1.0-9              httr_1.4.7
##   [5] prabclus_2.3-4            tools_4.5.1
##   [7] backports_1.5.0           alabaster.base_1.10.0
##   [9] R6_2.6.1                  lazyeval_0.2.2
##  [11] rhdf5filters_1.22.0       withr_3.0.2
##  [13] prettyunits_1.2.0         gridExtra_2.3
##  [15] bayesm_3.1-6              cli_3.6.5
##  [17] textshaping_1.0.4         alabaster.se_1.10.0
##  [19] labeling_0.4.3            sass_0.4.10
##  [21] diptest_0.77-2            S7_0.2.0
##  [23] robustbase_0.99-6         Rsamtools_2.26.0
##  [25] systemfonts_1.3.1         svglite_2.2.2
##  [27] R.utils_2.13.0            dichromat_2.0-0.1
##  [29] limma_3.66.0              rstudioapi_0.17.1
##  [31] RSQLite_2.4.3             BiocIO_1.20.0
##  [33] hwriter_1.3.2.1           gtools_3.9.5
##  [35] dplyr_1.1.4               interp_1.1-6
##  [37] ggbeeswarm_0.7.2          R.methodsS3_1.8.2
##  [39] lifecycle_1.0.4           yaml_2.3.10
##  [41] edgeR_4.8.0               gplots_3.2.0
##  [43] BiocFileCache_3.0.0       grid_4.5.1
##  [45] blob_1.2.4                ExperimentHub_3.0.0
##  [47] crayon_1.5.3              pwalign_1.6.0
##  [49] lattice_0.22-7            beachmat_2.26.0
##  [51] cowplot_1.2.0             GenomicFeatures_1.62.0
##  [53] cigarillo_1.0.0           KEGGREST_1.50.0
##  [55] EDASeq_2.44.0             magick_2.9.0
##  [57] pillar_1.11.1             knitr_1.50
##  [59] rjson_0.2.23              boot_1.3-32
##  [61] fpc_2.2-13                codetools_0.2-20
##  [63] glue_1.8.0                ShortRead_1.68.0
##  [65] data.table_1.17.8         vctrs_0.6.5
##  [67] png_0.1-8                 gypsum_1.6.0
##  [69] gtable_0.3.6              kernlab_0.9-33
##  [71] cachem_1.1.0              aroma.light_3.40.0
##  [73] xfun_0.53                 survival_3.8-3
##  [75] tinytex_0.57              statmod_1.5.1
##  [77] nlme_3.1-168              bit64_4.6.0-1
##  [79] alabaster.ranges_1.10.0   progress_1.2.3
##  [81] filelock_1.0.3            GenomeInfoDb_1.46.0
##  [83] tensorA_0.36.2.1          bslib_0.9.0
##  [85] irlba_2.3.5.1             vipor_0.4.7
##  [87] KernSmooth_2.23-26        DBI_1.2.3
##  [89] nnet_7.3-20               tidyselect_1.2.1
##  [91] bit_4.6.0                 compiler_4.5.1
##  [93] curl_7.0.0                compositions_2.0-9
##  [95] httr2_1.2.1               BiocNeighbors_2.4.0
##  [97] xml2_1.4.1                plotly_4.11.0
##  [99] bookdown_0.45             rtracklayer_1.70.0
## [101] checkmate_2.3.3           scales_1.4.0
## [103] caTools_1.18.3            DEoptimR_1.1-4
## [105] hexbin_1.28.5             rappdirs_0.3.3
## [107] stringr_1.5.2             digest_0.6.37
## [109] mixtools_2.0.0.1          alabaster.matrix_1.10.0
## [111] rmarkdown_2.30            XVector_0.50.0
## [113] htmltools_0.5.8.1         pkgconfig_2.0.3
## [115] jpeg_0.1-11               sparseMatrixStats_1.22.0
## [117] dbplyr_2.5.1              fastmap_1.2.0
## [119] ensembldb_2.34.0          rlang_1.1.6
## [121] htmlwidgets_1.6.4         UCSC.utils_1.6.0
## [123] DelayedMatrixStats_1.32.0 farver_2.1.2
## [125] jquerylib_0.1.4           jsonlite_2.0.0
## [127] BiocParallel_1.44.0       mclust_6.1.1
## [129] R.oo_1.27.1               BiocSingular_1.26.0
## [131] RCurl_1.98-1.17           magrittr_2.0.4
## [133] kableExtra_1.4.0          modeltools_0.2-24
## [135] Rhdf5lib_1.32.0           Rcpp_1.1.0
## [137] viridis_0.6.5             stringi_1.8.7
## [139] alabaster.schemas_1.10.0  MASS_7.3-65
## [141] AnnotationHub_4.0.0       flexmix_2.3-20
## [143] parallel_4.5.1            ggrepel_0.9.6
## [145] deldir_2.0-4              Biostrings_2.78.0
## [147] splines_4.5.1             hms_1.1.4
## [149] locfit_1.5-9.12           biomaRt_2.66.0
## [151] ScaledMatrix_1.18.0       BiocVersion_3.22.0
## [153] XML_3.99-0.19             evaluate_1.0.5
## [155] latticeExtra_0.6-31       BiocManager_1.30.26
## [157] tidyr_1.3.1               purrr_1.1.0
## [159] alabaster.sce_1.10.0      rsvd_1.0.5
## [161] AnnotationFilter_1.34.0   restfulr_0.0.16
## [163] RSpectra_0.16-2           viridisLite_0.4.2
## [165] RUVSeq_1.44.0             class_7.3-23
## [167] rARPACK_0.11-0            tibble_3.3.0
## [169] memoise_2.0.1             beeswarm_0.4.0
## [171] AnnotationDbi_1.72.0      GenomicAlignments_1.46.0
```

Hicks, Stephanie C., Mingxiang Teng, and Rafael A. Irizarry. 2015. “On the Widespread and Critical Impact of Systematic Bias and Batch Effects in Single-Cell Rna-Seq Data.” *bioRxiv Preprint*.

Li, Bo, and Colin N Dewey. 2011. “RSEM: Accurate Transcript Quantification from Rna-Seq Data with or Without a Reference Genome.” *BMC Bioinformatics* 13: 323.

Pollen, Alex A, Tomasz J Nowakowski, Joe Shuga, Xiaohui Wang, Anne A Leyrat, and et al. 2014. “Low-Coverage Single-Cell mRNA Sequencing Reveals Cellular Heterogeneity and Activated Signaling Pathways in Developing Cerebral Cortex.” *Nature Biotechnology* 32: 1053–8.

Risso, Davide, John Ngai, Terence P. Speed, and Sandrine Dudoit. 2014. “Normalization of Rna-Seq Data Using Factor Analysis of Control Genes or Samples.” *Nature Biotechnology* 32: 896–902.