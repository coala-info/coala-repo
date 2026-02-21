# An Introduction to TMSig

Tyler J. Sagendorf1

1Pacific Northwest National Laboratory, Richland, WA

#### 30 October 2025

#### Abstract

The *[TMSig](https://bioconductor.org/packages/3.22/TMSig)* package contains tools to prepare, analyze, and visualize named lists of sets, with an emphasis on molecular signatures (such as gene or kinase sets). It includes fast, memory efficient functions to construct sparse incidence and similarity matrices; filter, cluster, invert, and decompose sets; perform pre-ranked Correlation Adjusted MEan RAnk (CAMERA-PR) gene set testing via a flexible matrix method (see *[limma](https://bioconductor.org/packages/3.22/limma)* for the original implementation); and create bubble heatmaps to visualize the results of any differential or molecular signatures analysis.

#### Package

TMSig 1.4.0

Report issues at <https://github.com/EMSL-Computing/TMSig>

License: GPL (>= 3)

# 1 Read GMT Files

GMT files, such as those available through the Molecular Signatures Database
(MSigDB)(Liberzon et al. [2011](#ref-liberzon_molecular_2011), [2015](#ref-liberzon_molecular_2015)), can be read as
named lists with `readGMT`:

```
# Path to GMT file - MSigDB Gene Ontology sets
pathToGMT <- system.file(
    "extdata", "c5.go.v2023.2.Hs.symbols.gmt.gz",
    package = "TMSig"
)

geneSets <- readGMT(path = pathToGMT)

length(geneSets) # 10461 gene sets
#> [1] 10461

head(names(geneSets)) # first 6 gene set names
#> [1] "GOBP_10_FORMYLTETRAHYDROFOLATE_METABOLIC_PROCESS"
#> [2] "GOBP_2FE_2S_CLUSTER_ASSEMBLY"
#> [3] "GOBP_2_OXOGLUTARATE_METABOLIC_PROCESS"
#> [4] "GOBP_3_PHOSPHOADENOSINE_5_PHOSPHOSULFATE_METABOLIC_PROCESS"
#> [5] "GOBP_3_UTR_MEDIATED_MRNA_DESTABILIZATION"
#> [6] "GOBP_3_UTR_MEDIATED_MRNA_STABILIZATION"

geneSets[[1]] # genes in first set
#> [1] "AASDHPPT" "ALDH1L1"  "ALDH1L2"  "MTHFD1"   "MTHFD1L"  "MTHFD2L"
```

# 2 Filter Sets

`filterSets` keeps sets that satisfy minimum and maximum size constraints.
Optionally, sets can be restricted to a smaller background of genes before
filtering by size.

```
# Filter by size - no background
filt <- filterSets(x = geneSets,
                   min_size = 10L,
                   max_size = 500L)
length(filt) # 7096 gene sets remain (down from 10461)
#> [1] 7096
```

Normally, **the background is the set of genes quantified in a particular
experiment**. For the purposes of this example, the top 2000 most common genes
will be selected to serve as the background. This ensures the gene sets will
maintain some degree of overlap for later steps.

```
# Top 2000 most common genes
topGenes <- table(unlist(geneSets))
topGenes <- head(sort(topGenes, decreasing = TRUE), 2000L)
head(topGenes)
#>
#>    TNF   AKT1  WNT5A CTNNB1  TGFB1 NOTCH1
#>    809    675    669    655    609    588

background <- names(topGenes)
```

The gene sets will be restricted to elements of the background before filtering
by size.

```
# Restrict genes sets to background of genes
geneSetsFilt <- filterSets(
    x = geneSets,
    background = background,
    min_size = 10L # min. overlap of each set with background
)

length(geneSetsFilt) # 4629 gene sets pass
#> [1] 4629
```

The proportion of genes in each set that overlap with the background will be
calculated and used to further select sets.

```
# Calculate proportion of overlap with background
setSizes <- lengths(geneSetsFilt)
setSizesOld <- lengths(geneSets)[names(geneSetsFilt)]
overlapProp <- setSizes / setSizesOld

plot(setSizesOld, overlapProp, main = "Set Size vs. Overlap")
```

![Scatterplot of the original set size vs. overlap proportion.](data:image/png;base64...)

Figure 1: Scatterplot of the original set size vs. overlap proportion

Gene sets with an overlap of at least 70% will be kept, so we can be reasonably
confident that the gene sets are correctly described by their labels. However,
since the background is small, this will remove the majority of sets.

```
table(overlapProp >= 0.7)
#>
#> FALSE  TRUE
#>  3614  1015

geneSetsFilt <- geneSetsFilt[overlapProp >= 0.7]
length(geneSetsFilt) # 1015 gene sets pass
#> [1] 1015
```

# 3 Incidence Matrix

An incidence matrix is a representation of a graph. For a named list of sets,
the set names form the rows of the matrix, and all unique elements are columns.
A value of 1 indicates that the element is a member of the set, while a value of
0 indicates otherwise. The incidence matrix forms the basis for many of the
functions in TMSig, including `similarity`, `clusterSets`, `decomposeSets`,
and `cameraPR.matrix`.

```
imat <- sparseIncidence(x = geneSetsFilt)
dim(imat) # 1015 sets, 1914 genes
#> [1] 1015 1914

imat[seq_len(8L), seq_len(5L)] # first 8 sets, first 5 genes
#> 8 x 5 sparse Matrix of class "dgCMatrix"
#>                                              ABL1 AGER ARG1 BTN2A2 CADM1
#> GOBP_ACTIVATED_T_CELL_PROLIFERATION             1    1    1      1     1
#> GOBP_ACTIVATION_OF_JANUS_KINASE_ACTIVITY        .    .    .      .     .
#> GOBP_ACTIVATION_OF_PROTEIN_KINASE_ACTIVITY      1    .    .      .     .
#> GOBP_ACTIVATION_OF_PROTEIN_KINASE_B_ACTIVITY    .    .    .      .     .
#> GOBP_ADHESION_OF_SYMBIONT_TO_HOST               .    .    .      .     .
#> GOBP_ADRENAL_GLAND_DEVELOPMENT                  .    .    .      .     .
#> GOBP_ALPHA_BETA_T_CELL_ACTIVATION               1    1    .      .     .
#> GOBP_ALPHA_BETA_T_CELL_DIFFERENTIATION          1    .    .      .     .
```

The incidence matrix can be used to calculate the sizes of all pairwise set
intersections or the number of sets or pairs of sets to which each gene belongs.

```
# Calculate sizes of all pairwise intersections
tcrossprod(imat)[1:3, 1:3] # first 3 gene sets
#> 3 x 3 sparse Matrix of class "dsCMatrix"
#>                                            GOBP_ACTIVATED_T_CELL_PROLIFERATION
#> GOBP_ACTIVATED_T_CELL_PROLIFERATION                                         40
#> GOBP_ACTIVATION_OF_JANUS_KINASE_ACTIVITY                                     3
#> GOBP_ACTIVATION_OF_PROTEIN_KINASE_ACTIVITY                                   8
#>                                            GOBP_ACTIVATION_OF_JANUS_KINASE_ACTIVITY
#> GOBP_ACTIVATED_T_CELL_PROLIFERATION                                               3
#> GOBP_ACTIVATION_OF_JANUS_KINASE_ACTIVITY                                         13
#> GOBP_ACTIVATION_OF_PROTEIN_KINASE_ACTIVITY                                       13
#>                                            GOBP_ACTIVATION_OF_PROTEIN_KINASE_ACTIVITY
#> GOBP_ACTIVATED_T_CELL_PROLIFERATION                                                 8
#> GOBP_ACTIVATION_OF_JANUS_KINASE_ACTIVITY                                           13
#> GOBP_ACTIVATION_OF_PROTEIN_KINASE_ACTIVITY                                         67

# Calculate number of sets and pairs of sets to which each gene belongs
crossprod(imat)[1:3, 1:3] # first 3 genes
#> 3 x 3 sparse Matrix of class "dsCMatrix"
#>      ABL1 AGER ARG1
#> ABL1   76   15    3
#> AGER   15   52    6
#> ARG1    3    6   31
```

# 4 Set Similarity

The `similarity` function constructs a sparse symmetric matrix of pairwise
Jaccard, overlap/Simpson, or Ōtsuka similarity coefficients for all pairs of
sets \(A\) and \(B\), where

* Jaccard(\(A\), \(B\)) = \(\frac{|A \cap B|}{|A \cup B|}\)
* Overlap(\(A\), \(B\)) = \(\frac{|A \cap B|}{\min(|A|, |B|)}\)
* Ōtsuka(\(A\), \(B\)) = \(\frac{|A \cap B|}{\sqrt{|A| \times |B|}}\)

All 3 similarity measures can identify aliasing of sets: when two or more sets
contain the same elements, but have different descriptions. Only the
overlap/Simpson similarity can also identify when one set is a subset of
another.

## 4.1 Jaccard

```
# Jaccard similarity (default)
jaccard <- similarity(x = geneSetsFilt)
dim(jaccard) # 1015 1015`
#> [1] 1015 1015
class(jaccard)
#> [1] "dgCMatrix"
#> attr(,"package")
#> [1] "Matrix"
```

The 6 sets having the highest Jaccard similarity with
GOBP\_CARDIAC\_ATRIUM\_DEVELOPMENT are shown for each of the 3 measures of set
similarity.

```
# 6 sets with highest Jaccard for a specific term
idx <- order(jaccard[, "GOBP_CARDIAC_ATRIUM_DEVELOPMENT"],
             decreasing = TRUE)
idx <- head(idx)

jaccard[idx, "GOBP_CARDIAC_ATRIUM_DEVELOPMENT", drop = FALSE]
#> 6 x 1 sparse Matrix of class "dgCMatrix"
#>                                         GOBP_CARDIAC_ATRIUM_DEVELOPMENT
#> GOBP_CARDIAC_ATRIUM_DEVELOPMENT                               1.0000000
#> GOBP_CARDIAC_ATRIUM_MORPHOGENESIS                             0.8529412
#> GOBP_ATRIAL_SEPTUM_DEVELOPMENT                                0.5882353
#> GOBP_ATRIAL_SEPTUM_MORPHOGENESIS                              0.4411765
#> GOBP_ATRIOVENTRICULAR_VALVE_DEVELOPMENT                       0.3111111
#> GOBP_CARDIAC_CHAMBER_MORPHOGENESIS                            0.3039216
```

GOBP\_CARDIAC\_ATRIUM\_MORPHOGENESIS is highly similar to
GOBP\_CARDIAC\_ATRIUM\_DEVELOPMENT (\(J\) = 0.853).

## 4.2 Overlap/Simpson

```
overlap <- similarity(x = geneSetsFilt, type = "overlap")

overlap[idx, "GOBP_CARDIAC_ATRIUM_DEVELOPMENT", drop = FALSE]
#> 6 x 1 sparse Matrix of class "dgCMatrix"
#>                                         GOBP_CARDIAC_ATRIUM_DEVELOPMENT
#> GOBP_CARDIAC_ATRIUM_DEVELOPMENT                               1.0000000
#> GOBP_CARDIAC_ATRIUM_MORPHOGENESIS                             1.0000000
#> GOBP_ATRIAL_SEPTUM_DEVELOPMENT                                1.0000000
#> GOBP_ATRIAL_SEPTUM_MORPHOGENESIS                              1.0000000
#> GOBP_ATRIOVENTRICULAR_VALVE_DEVELOPMENT                       0.5600000
#> GOBP_CARDIAC_CHAMBER_MORPHOGENESIS                            0.9117647
```

GOBP\_CARDIAC\_ATRIUM\_MORPHOGENESIS, GOBP\_ATRIAL\_SEPTUM\_DEVELOPMENT, and
GOBP\_ATRIAL\_SEPTUM\_MORPHOGENESIS are subsets of GOBP\_CARDIAC\_ATRIUM\_DEVELOPMENT,
since they are smaller (each containing 15 to 29 genes compared to 34 in
GOBP\_CARDIAC\_ATRIUM\_DEVELOPMENT).

## 4.3 Ōtsuka

```
otsuka <- similarity(x = geneSetsFilt, type = "otsuka")

otsuka[idx, "GOBP_CARDIAC_ATRIUM_DEVELOPMENT", drop = FALSE]
#> 6 x 1 sparse Matrix of class "dgCMatrix"
#>                                         GOBP_CARDIAC_ATRIUM_DEVELOPMENT
#> GOBP_CARDIAC_ATRIUM_DEVELOPMENT                               1.0000000
#> GOBP_CARDIAC_ATRIUM_MORPHOGENESIS                             0.9235481
#> GOBP_ATRIAL_SEPTUM_DEVELOPMENT                                0.7669650
#> GOBP_ATRIAL_SEPTUM_MORPHOGENESIS                              0.6642112
#> GOBP_ATRIOVENTRICULAR_VALVE_DEVELOPMENT                       0.4801960
#> GOBP_CARDIAC_CHAMBER_MORPHOGENESIS                            0.5343239
```

# 5 Cluster Similar Sets

`clusterSets` employs hierarchical clustering to identify groups of highly
similar sets. This procedure was developed for the removal of redundant Gene
Ontology and Reactome gene sets for the MSigDB. See
`help(topic = "clusterSets", package = "TMSig")` for details.

```
# clusterSets with default arguments
clusterDF <- clusterSets(x = geneSetsFilt,
                         type = "jaccard",
                         cutoff = 0.85,
                         method = "complete",
                         h = 0.9)

# First 4 clusters with 2 or more sets
subset(clusterDF, subset = cluster <= 4L)
#>                                                                             set
#> 1                                               GOBP_CARDIAC_ATRIUM_DEVELOPMENT
#> 2                                             GOBP_CARDIAC_ATRIUM_MORPHOGENESIS
#> 3                                                GOBP_T_CELL_LINEAGE_COMMITMENT
#> 4        GOBP_CD4_POSITIVE_OR_CD8_POSITIVE_ALPHA_BETA_T_CELL_LINEAGE_COMMITMENT
#> 5                                GOBP_CELL_COMMUNICATION_BY_ELECTRICAL_COUPLING
#> 6 GOBP_CELL_COMMUNICATION_BY_ELECTRICAL_COUPLING_INVOLVED_IN_CARDIAC_CONDUCTION
#> 7                                                      GOBP_CHOLESTEROL_STORAGE
#> 8                                        GOBP_REGULATION_OF_CHOLESTEROL_STORAGE
#>   cluster set_size
#> 1       1       34
#> 2       1       29
#> 3       2       27
#> 4       2       23
#> 5       3       24
#> 6       3       21
#> 7       4       18
#> 8       4       16
```

In each cluster, a single set can be retained for analysis using a combination
of criteria such as set size, overlap proportion, or length of the description
(shorter descriptions tend to be more general terms).

```
## Use clusterSets output to select sets to retain for analysis
clusterDF$overlap_prop <- overlapProp[clusterDF$set] # overlap proportion
clusterDF$n_char <- nchar(clusterDF$set) # length of set description

# Reorder rows so that the first set in each cluster is the one to keep
o <- with(clusterDF,
          order(cluster, set_size, overlap_prop, n_char, set,
                decreasing = c(FALSE, TRUE, TRUE, FALSE, TRUE),
                method = "radix"))
clusterDF <- clusterDF[o, ]

subset(clusterDF, cluster <= 4L) # show first 4 clusters
#>                                                                             set
#> 1                                               GOBP_CARDIAC_ATRIUM_DEVELOPMENT
#> 2                                             GOBP_CARDIAC_ATRIUM_MORPHOGENESIS
#> 3                                                GOBP_T_CELL_LINEAGE_COMMITMENT
#> 4        GOBP_CD4_POSITIVE_OR_CD8_POSITIVE_ALPHA_BETA_T_CELL_LINEAGE_COMMITMENT
#> 5                                GOBP_CELL_COMMUNICATION_BY_ELECTRICAL_COUPLING
#> 6 GOBP_CELL_COMMUNICATION_BY_ELECTRICAL_COUPLING_INVOLVED_IN_CARDIAC_CONDUCTION
#> 7                                                      GOBP_CHOLESTEROL_STORAGE
#> 8                                        GOBP_REGULATION_OF_CHOLESTEROL_STORAGE
#>   cluster set_size overlap_prop n_char
#> 1       1       34    0.9189189     31
#> 2       1       29    1.0000000     33
#> 3       2       27    0.8437500     30
#> 4       2       23    0.8846154     70
#> 5       3       24    0.7058824     46
#> 6       3       21    0.7777778     77
#> 7       4       18    0.7200000     24
#> 8       4       16    0.8421053     38
```

Now that the first gene set (first row) in each cluster is the one to keep, we
can remove rows where the cluster is duplicated (this only keeps the first row
of each cluster) and then extract the vector of sets to subset `geneSetsFilt`.
Note that `max(clusterDF$cluster)` will indicate how many gene sets will remain
after this redundancy filter.

```
# Sets to keep for analysis
keepSets <- with(clusterDF, set[!duplicated(cluster)])
head(keepSets, 4L)
#> [1] "GOBP_CARDIAC_ATRIUM_DEVELOPMENT"
#> [2] "GOBP_T_CELL_LINEAGE_COMMITMENT"
#> [3] "GOBP_CELL_COMMUNICATION_BY_ELECTRICAL_COUPLING"
#> [4] "GOBP_CHOLESTEROL_STORAGE"

# Subset geneSetsFilt to those sets
geneSetsFilt <- geneSetsFilt[keepSets]
length(geneSetsFilt) # 986 (down from 1015)
#> [1] 986
```

# 6 Decompose Sets

Decompose all pairs of sufficiently overlapping sets, \(A\) and \(B\), into 3
disjoint parts:

1. The elements unique to \(A\): \(A \setminus B\) (“A minus B”)
2. The elements unique to \(B\): \(B \setminus A\) (“B minus A”)
3. The elements common to both \(A\) and \(B\): \(A \cap B\) (“A and B”)

![Decomposition of sets.](data:image/png;base64...)

Figure 2: Decomposition of sets

Decomposition of sets is described in section 2.3.1 of “Extensions to Gene Set
Enrichment” (Jiang and Gentleman [2007](#ref-jiang_extensions_2007)) as a method to reduce the redundancy of
gene set testing results.

```
# Limit maximum set size for this example
geneSetsFilt2 <- filterSets(geneSetsFilt, max_size = 50L)

# Decompose all pairs of sets with at least 10 genes in common
decompSets <- decomposeSets(x = geneSetsFilt2, overlap = 10L)

# Last 3 components
tail(decompSets, 3L)
#> $`GOCC_NPBAF_COMPLEX ~MINUS~ GOCC_NBAF_COMPLEX`
#> [1] "ACTL6A" "PHF10"
#>
#> $`GOCC_NBAF_COMPLEX ~MINUS~ GOCC_NPBAF_COMPLEX`
#> [1] "ACTL6B"
#>
#> $`GOCC_NBAF_COMPLEX ~AND~ GOCC_NPBAF_COMPLEX`
#>  [1] "SMARCD3" "ACTB"    "ARID1A"  "SMARCB1" "SMARCA4" "SMARCC1" "ARID1B"
#>  [8] "SMARCA2" "SMARCC2" "SMARCE1" "SMARCD1"
```

# 7 Invert Sets

A list of sets can be inverted so that elements become set names and set names
become elements. This is primarily used to identify all sets to which a
particular element belongs.

```
invertedSets <- invertSets(x = geneSetsFilt)

length(invertedSets) # 1914 genes
#> [1] 1914

head(names(invertedSets)) # names are genes
#> [1] "ABAT"   "ABCA1"  "ABCA12" "ABCA2"  "ABCA3"  "ABCA7"

invertedSets["FOXO1"] # all gene sets containing FOXO1
#> $FOXO1
#>  [1] "GOBP_CELLULAR_RESPONSE_TO_REACTIVE_NITROGEN_SPECIES"
#>  [2] "GOBP_MUSCLE_HYPERTROPHY"
#>  [3] "GOBP_NEGATIVE_REGULATION_OF_MUSCLE_HYPERTROPHY"
#>  [4] "GOBP_POSITIVE_REGULATION_OF_CARBOHYDRATE_METABOLIC_PROCESS"
#>  [5] "GOBP_POSITIVE_REGULATION_OF_GLUCONEOGENESIS"
#>  [6] "GOBP_POSITIVE_REGULATION_OF_GLUCOSE_METABOLIC_PROCESS"
#>  [7] "GOBP_POSITIVE_REGULATION_OF_SMALL_MOLECULE_METABOLIC_PROCESS"
#>  [8] "GOBP_REGULATION_OF_CARDIAC_MUSCLE_ADAPTATION"
#>  [9] "GOBP_REGULATION_OF_MUSCLE_HYPERTROPHY"
#> [10] "GOBP_REGULATION_OF_REACTIVE_OXYGEN_SPECIES_METABOLIC_PROCESS"
#> [11] "GOBP_RESPONSE_TO_HYPEROXIA"
#> [12] "GOBP_RESPONSE_TO_NITRIC_OXIDE"
```

This can also be used to calculate the similarity of each pair of genes. That
is, do pairs of genes tend to appear in the same sets?

```
similarity(x = invertedSets[1:5]) # first 5 genes
#> 5 x 5 sparse Matrix of class "dgCMatrix"
#>        ABAT     ABCA1    ABCA12 ABCA2     ABCA3
#> ABAT      1 .         .          .    .
#> ABCA1     . 1.0000000 0.1333333  0.05 0.1333333
#> ABCA12    . 0.1333333 1.0000000  .    1.0000000
#> ABCA2     . 0.0500000 .          1.00 .
#> ABCA3     . 0.1333333 1.0000000  .    1.0000000
```

# 8 Enrichment Analysis

We will simulate a matrix of gene expression data for those 2000 genes that were
selected earlier and perform differential analysis using `limma`. Then, the
differential analysis results, as well as the filtered gene sets, will be used
as input for the pre-ranked version of Correlation Adjusted MEan RAnk gene set
testing (CAMERA) (Wu and Smyth [2012](#ref-wu_camera_2012)).

## 8.1 Simulate Gene Expression Data

Gene expression data is simulated for 3 biological replicates in each of 3
experimental groups: ctrl (control), treat1 (treatment group 1), and treat2
(treatment group 2.

```
# Control and 2 treatment groups, 3 replicates each
group <- rep(c("ctrl", "treat1", "treat2"),
             each = 3)
design <- model.matrix(~ 0 + group) # design matrix
contrasts <- makeContrasts(
    contrasts = c("grouptreat1 - groupctrl",
                  "grouptreat2 - groupctrl"),
    levels = colnames(design)
)

# Shorten contrast names
colnames(contrasts) <- gsub("group", "", colnames(contrasts))

ngenes <- length(background) # 2000 genes
nsamples <- length(group) # 9 samples

set.seed(0)
y <- matrix(data = rnorm(ngenes * nsamples),
            nrow = ngenes, ncol = nsamples,
            dimnames = list(background, make.unique(group)))
head(y)
#>              ctrl       ctrl.1     ctrl.2     treat1   treat1.1    treat1.2
#> TNF     1.2629543  0.444345820  0.7928027 -0.4210379  0.2277948 -1.21955126
#> AKT1   -0.3262334  0.011929380 -1.1373714 -1.2714751  1.9445279 -1.20146018
#> WNT5A   1.3297993 -0.009280045 -0.2015088  0.8393109 -2.0414912 -0.49604255
#> CTNNB1  1.2724293 -0.302377554 -1.0223649  0.5400129  0.1747742  0.06693112
#> TGFB1   0.4146414  0.492355022 -0.8237988  1.8679387  0.1490125 -0.05694914
#> NOTCH1 -1.5399500 -0.602719618  0.2414621  0.4445180  1.5725517  0.25558017
#>            treat2   treat2.1   treat2.2
#> TNF    -0.1984714  1.2707294  1.3388829
#> AKT1    0.1498199 -0.4548994  1.1401323
#> WNT5A  -0.9205130  0.5317540 -0.1473067
#> CTNNB1 -0.5952829  0.4932479  0.9614810
#> TGFB1  -1.0171751 -0.5465015 -1.3908547
#> NOTCH1  0.5891424  0.5235780  0.5885306
```

Now, we introduce differential expression in two randomly selected gene sets. We
will make genes in the “GOBP\_CARDIAC\_ATRIUM\_DEVELOPMENT” set higher in control
relative to treatment samples, and we will make genes in the
“GOBP\_ACTIVATED\_T\_CELL\_PROLIFERATION” set higher in treatment relative to
control samples. Since the contrasts are “treat1 - ctrl” and “treat2 - ctrl”,
the direction of change will be “Down” for cardiac atrium development and “Up”
for activated T cell proliferation. The degree of change will be less for the
“treat2 - ctrl” comparison.

```
cardiacGenes <- geneSetsFilt[["GOBP_CARDIAC_ATRIUM_DEVELOPMENT"]]
tcellGenes <- geneSetsFilt[["GOBP_ACTIVATED_T_CELL_PROLIFERATION"]]

# Indices of treatment group samples
trt1 <- which(group == "treat1")
trt2 <- which(group == "treat2")

# Cardiac genes: higher in control relative to treatment
y[cardiacGenes, trt1] <- y[cardiacGenes, trt1] - 2
y[cardiacGenes, trt2] <- y[cardiacGenes, trt2] - 0.7

# T cell proliferation genes: higher in treatment relative to control
y[tcellGenes, trt1] <- y[tcellGenes, trt1] + 2
y[tcellGenes, trt2] <- y[tcellGenes, trt2] + 1
```

## 8.2 Differential Gene Expression Analysis

```
# Differential analysis with LIMMA
fit <- lmFit(y, design)
fit.contr <- contrasts.fit(fit, contrasts = contrasts)
fit.smooth <- eBayes(fit.contr)

# Matrix of z-score equivalents of moderated t-statistics
modz <- with(fit.smooth, zscoreT(x = t, df = df.total))
head(modz)
#>         Contrasts
#>          treat1 - ctrl treat2 - ctrl
#>   TNF       -1.6151363   -0.03685223
#>   AKT1       0.3762490    0.93096154
#>   WNT5A     -3.5528576   -1.53460494
#>   CTNNB1     0.3442251    0.37629330
#>   TGFB1      0.7751130   -1.25290937
#>   NOTCH1    -0.7565066    0.62257285
```

The results will be reformatted to make bubble heatmaps later.

```
# Reformat differential analysis results for enrichmap
resDA <- lapply(colnames(contrasts), function(contrast_i) {
    res_i <- topTable(fit.smooth,
                      coef = contrast_i,
                      number = Inf,
                      sort.by = "none")
    res_i$contrast <- contrast_i
    res_i$gene <- rownames(res_i)
    res_i$df.total <- fit.smooth$df.total

    return(res_i)
})

resDA <- data.table::rbindlist(resDA)

# Add z-statistic column
resDA$z <- with(resDA, zscoreT(x = t, df = df.total))

# Reorder rows
resDA <- resDA[with(resDA, order(contrast, P.Value, z)), ]

head(resDA)
#>        logFC    AveExpr         t      P.Value  adj.P.Val        B
#>        <num>      <num>     <num>        <num>      <num>    <num>
#> 1: -3.703006 -0.4690872 -4.582075 8.487516e-06 0.01697503 3.295885
#> 2: -3.394212 -0.9283708 -4.236070 3.595590e-05 0.02756659 2.030462
#> 3: -3.473165 -1.2123347 -4.139674 5.296838e-05 0.02756659 1.692116
#> 4: -3.307502 -0.3271868 -4.129613 5.513317e-05 0.02756659 1.657166
#> 5: -3.326092 -0.4175039 -4.036147 7.971089e-05 0.03137933 1.335823
#> 6: -3.246138 -0.3336773 -3.993443 9.413798e-05 0.03137933 1.191014
#>         contrast   gene df.total         z
#>           <char> <char>    <num>     <num>
#> 1: treat1 - ctrl  BMPR2 183.4439 -4.452503
#> 2: treat1 - ctrl   SOX4 183.4439 -4.132039
#> 3: treat1 - ctrl   MYH6 183.4439 -4.042128
#> 4: treat1 - ctrl EXOSC6 183.4439 -4.032728
#> 5: treat1 - ctrl   MDM2 183.4439 -3.945268
#> 6: treat1 - ctrl   HEY2 183.4439 -3.905224
```

Below is the number of significantly differentially expressed genes for each
comparison.

```
# Count number of significant (P adj. < 0.05) genes
table(resDA$contrast, resDA$adj.P.Val < 0.05)
#>
#>                 FALSE TRUE
#>   treat1 - ctrl  1990   10
#>   treat2 - ctrl  2000    0
```

## 8.3 CAMERA-PR

LIMMA moderated t-statistics are converted to z-score equivalents and used as
input for `cameraPR.matrix`. CAMERA-PR is a modification of the two-sample
t-test that accounts for inter-gene correlation to correctly control the false
discovery rate (FDR) (Wu and Smyth [2012](#ref-wu_camera_2012)). For the pre-ranked version, a default
inter-gene correlation of 0.01 is assumed for all gene sets. A non-parametric
version of CAMERA-PR is also available by specifying `use.ranks=TRUE`. See
`help(topic = "cameraPR.matrix", package = "TMSig")` for details. See
`help(topic = "cameraPR", package = "limma")` for the original implementation.

The main benefits of using `cameraPR.matrix` over `cameraPR.default` are
significantly faster execution times and the ability to perform simultaneous
inference of multiple contrasts or coefficients.

```
# CAMERA-PR (matrix method)
res <- cameraPR(statistic = modz,
                index = geneSetsFilt)
head(res)
#>        Contrast                                                    GeneSet
#> 1 treat1 - ctrl                        GOBP_ACTIVATED_T_CELL_PROLIFERATION
#> 2 treat1 - ctrl                            GOBP_CARDIAC_ATRIUM_DEVELOPMENT
#> 3 treat1 - ctrl GOBP_POSITIVE_REGULATION_OF_ACTIVATED_T_CELL_PROLIFERATION
#> 4 treat1 - ctrl                             GOBP_ATRIAL_SEPTUM_DEVELOPMENT
#> 5 treat1 - ctrl                           GOBP_ATRIAL_SEPTUM_MORPHOGENESIS
#> 6 treat1 - ctrl GOBP_NEGATIVE_REGULATION_OF_ACTIVATED_T_CELL_PROLIFERATION
#>   NGenes Direction TwoSampleT   df     ZScore       PValue          FDR
#> 1     40        Up  13.884761 1998  13.564587 6.494436e-42 6.403514e-39
#> 2     34      Down -11.679847 1998 -11.486100 1.549498e-30 7.639023e-28
#> 3     22        Up  11.164767 1998  10.994909 4.043202e-28 1.328866e-25
#> 4     20      Down -10.148402 1998 -10.019904 1.246239e-23 3.071979e-21
#> 5     15      Down  -8.934331 1998  -8.845874 9.081462e-19 1.790864e-16
#> 6     13        Up   8.170612 1998   8.102558 5.381537e-16 8.843659e-14
```

Both cardiac atrium development and activated T cell proliferation gene sets
have adjusted p-values below 0.05 and are ranked at the top of “Down” and “Up”
sets. However, other gene sets are also statistically significant after
adjustment due to their genes overlapping with these two terms.

```
# Number of sets passing FDR threshold
table(res$Contrast, res$FDR < 0.05)
#>
#>                 FALSE TRUE
#>   treat1 - ctrl   916   70
#>   treat2 - ctrl   978    8
```

To illustrate the above point, notice that GOBP\_CARDIAC\_ATRIUM\_DEVELOPMENT and
GOBP\_ATRIAL\_SEPTUM\_DEVELOPMENT are both significantly down. Their Jaccard and
Overlap coefficients are 0.588 and 1, respectively. That is, atrial septum
development is a subset of cardiac atrium development (at least, when both sets
are restricted to the background we defined earlier), so it is being driven by
changes in the latter.

# 9 Bubble Heatmaps

A bubble heatmap will be generated to visualize the top genes from the
differential expression analysis. Since `plot_sig_only=TRUE` only those 10 genes
that were significantly differentially expressed in the “treat1 - ctrl”
comparison will appear in the heatmap. The bubbles will be scaled such that the
most significant contrast/gene combination (smallest adjusted p-value) is of
maximum diameter, and all other bubbles will be scaled relative to it based on
their -log\(\_{10}\) adjusted p-values. See
`help(topic = "enrichmap", package = "TMSig")` for more details.

```
# Differential analysis bubble heatmap
enrichmap(x = resDA,
          scale_by = "max",
          n_top = 15L, # default
          plot_sig_only = TRUE, # default
          set_column = "gene",
          statistic_column = "z",
          contrast_column = "contrast",
          padj_column = "adj.P.Val",
          padj_legend_title = "BH Adjusted\nP-Value",
          padj_cutoff = 0.05,
          cell_size = grid::unit(20, "pt"),
          # Additional arguments passed to ComplexHeatmap::Heatmap. Used to
          # modify default appearance.
          heatmap_args = list(
              name = "Z-Score",
              column_names_rot = 60,
              column_names_side = "top"
          ))
```

![Bubble heatmap of differential expression analysis results.](data:image/png;base64...)

Figure 3: Bubble heatmap of differential expression analysis results

Now, a bubble heatmap will be generated to visualize the CAMERA-PR gene set
analysis results. The top 20 gene sets will be shown.

```
# CAMERA-PR bubble heatmap
enrichmap(x = res,
          scale_by = "row", # default
          n_top = 20L,
          set_column = "GeneSet",
          statistic_column = "ZScore",
          contrast_column = "Contrast",
          padj_column = "FDR",
          padj_legend_title = "BH Adjusted\nP-Value",
          padj_cutoff = 0.05,
          cell_size = grid::unit(13, "pt"),
          # Additional arguments passed to ComplexHeatmap::Heatmap. Used to
          # modify default appearance.
          heatmap_args = list(
              name = "Z-Score",
              column_names_rot = 60,
              column_names_side = "top"
          ))
```

![Bubble heatmap of CAMERA-PR results.](data:image/png;base64...)

Figure 4: Bubble heatmap of CAMERA-PR results

Although no genes were differentially expressed in the “treat2 - ctrl”
comparison, summarizing results at the gene set level uncovered several
significant changes, though they are less pronounced than those in the
“treat1 - ctrl” comparison, as evidenced by the sizes and colors of the
bubbles.

# Session Information

```
print(sessionInfo(), locale = FALSE)
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] TMSig_1.4.0      limma_3.66.0     BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] KEGGREST_1.50.0       circlize_0.4.16       shape_1.4.6.1
#>  [4] rjson_0.2.23          xfun_0.53             bslib_0.9.0
#>  [7] GlobalOptions_0.1.2   Biobase_2.70.0        lattice_0.22-7
#> [10] Cairo_1.7-0           vctrs_0.6.5           tools_4.5.1
#> [13] generics_0.1.4        stats4_4.5.1          parallel_4.5.1
#> [16] AnnotationDbi_1.72.0  RSQLite_2.4.3         cluster_2.1.8.1
#> [19] blob_1.2.4            Matrix_1.7-4          data.table_1.17.8
#> [22] RColorBrewer_1.1-3    S4Vectors_0.48.0      graph_1.88.0
#> [25] lifecycle_1.0.4       compiler_4.5.1        Biostrings_2.78.0
#> [28] statmod_1.5.1         tinytex_0.57          Seqinfo_1.0.0
#> [31] codetools_0.2-20      ComplexHeatmap_2.26.0 clue_0.3-66
#> [34] htmltools_0.5.8.1     sass_0.4.10           yaml_2.3.10
#> [37] crayon_1.5.3          jquerylib_0.1.4       cachem_1.1.0
#> [40] magick_2.9.0          iterators_1.0.14      foreach_1.5.2
#> [43] digest_0.6.37         bookdown_0.45         fastmap_1.2.0
#> [46] grid_4.5.1            colorspace_2.1-2      cli_3.6.5
#> [49] magrittr_2.0.4        XML_3.99-0.19         GSEABase_1.72.0
#> [52] bit64_4.6.0-1         rmarkdown_2.30        XVector_0.50.0
#> [55] httr_1.4.7            matrixStats_1.5.0     bit_4.6.0
#> [58] png_0.1-8             GetoptLong_1.0.5      memoise_2.0.1
#> [61] evaluate_1.0.5        knitr_1.50            IRanges_2.44.0
#> [64] doParallel_1.0.17     rlang_1.1.6           Rcpp_1.1.0
#> [67] xtable_1.8-4          DBI_1.2.3             BiocManager_1.30.26
#> [70] BiocGenerics_0.56.0   annotate_1.88.0       jsonlite_2.0.0
#> [73] R6_2.6.1
```

# References

Jiang, Zhen, and Robert Gentleman. 2007. “Extensions to Gene Set Enrichment.” *Bioinformatics* 23 (3): 306–13. <https://doi.org/10.1093/bioinformatics/btl599>.

Liberzon, Arthur, Chet Birger, Helga Thorvaldsdóttir, Mahmoud Ghandi, Jill P. Mesirov, and Pablo Tamayo. 2015. “The Molecular Signatures Database Hallmark Gene Set Collection.” *Cell Systems* 1 (6): 417–25. <https://doi.org/10.1016/j.cels.2015.12.004>.

Liberzon, Arthur, Aravind Subramanian, Reid Pinchback, Helga Thorvaldsdóttir, Pablo Tamayo, and Jill P. Mesirov. 2011. “Molecular Signatures Database (MSigDB) 3.0.” *Bioinformatics* 27 (12): 1739–40. <https://doi.org/10.1093/bioinformatics/btr260>.

Wu, Di, and Gordon K. Smyth. 2012. “Camera: A Competitive Gene Set Test Accounting for Inter-Gene Correlation.” *Nucleic Acids Research* 40 (17): e133–e133. <https://doi.org/10.1093/nar/gks461>.