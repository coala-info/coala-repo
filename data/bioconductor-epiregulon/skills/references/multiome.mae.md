# Epiregulon tutorial with MultiAssayExperiment

Xiaosai Yao, Tomasz Włodarczyk

#### 8 December 2025

#### Package

epiregulon 2.0.2

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Data preparation](#data-preparation)
* [4 Quick start](#quick-start)
  + [4.1 Retrieve bulk TF ChIP-seq binding sites](#retrieve-bulk-tf-chip-seq-binding-sites)
  + [4.2 Link ATAC-seq peaks to target genes](#link-atac-seq-peaks-to-target-genes)
    - [4.2.1 Optimize the number of metacells (Optional)](#optimize-the-number-of-metacells-optional)
    - [4.2.2 Calculate Peak to Gene Links](#calculate-peak-to-gene-links)
  + [4.3 Add TF motif binding to peaks](#add-tf-motif-binding-to-peaks)
  + [4.4 Generate regulons](#generate-regulons)
  + [4.5 Network pruning (highly recommended)](#network-pruning-highly-recommended)
  + [4.6 Add Weights](#add-weights)
  + [4.7 Annotate with TF motifs (Optional)](#annotate-with-tf-motifs-optional)
  + [4.8 Annotate with log fold changes (Optional)](#annotate-with-log-fold-changes-optional)
  + [4.9 Calculate TF activity](#calculate-tf-activity)
* [5 Session Info](#session-info)

# 1 Introduction

Gene regulatory networks model the underlying gene regulation hierarchies that drive gene expression and cell states. The main functions of this package are to construct gene regulatory networks and infer transcription factor (TF) activity at the single cell level by integrating scATAC-seq and scRNA-seq data and incorporating of public bulk TF ChIP-seq data.

There are three related packages: *[epiregulon](https://bioconductor.org/packages/3.22/epiregulon)*, *[epiregulon.extra](https://bioconductor.org/packages/3.22/epiregulon.extra)* and `epiregulon.archr`, the two of which are available through Bioconductor and the last of which is only available through [github](https://github.com/xiaosaiyao/epiregulon.archr). The basic `epiregulon` package takes in gene expression and chromatin accessibility matrices in the form of `SingleCellExperiment` objects, constructs gene regulatory networks (“regulons”) and outputs the activity of transcription factors at the single cell level. The `epiregulon.extra` package provides a suite of tools for enrichment analysis of target genes, visualization of target genes and transcription factor activity, and network analysis which can be run on the `epiregulon` output. If the users would like to start from `ArchR` projects instead of `SingleCellExperiment` objects, they may choose to use `epiregulon.archr` package, which allows for seamless integration with the [ArchR](https://www.archrproject.com/) package, and continue with the rest of the workflow offered in `epiregulon.extra`.

For full documentation of the `epiregulon` package, please refer to the [epiregulon book](https://xiaosaiyao.github.io/epiregulon.book/).

# 2 Installation

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("epiregulon")
```

Alternatively, you could install from github

```
devtools::install_github(repo ='xiaosaiyao/epiregulon')
```

Load package

```
library(epiregulon)
```

# 3 Data preparation

Prior to using `epiregulon`, single cell preprocessing needs to performed by user’s favorite methods. The following components are required:
1. Peak matrix from scATAC-seq containing the chromatin accessibility information
2. Gene expression matrix from either paired or unpaired scRNA-seq. RNA-seq integration needs to be performed for unpaired dataset.
3. Dimensionality reduction matrix from either single modality dataset or joint scRNA-seq and scATAC-seq

This tutorial demonstrates the basic functions of `epiregulon`, using the reprogram-seq dataset which can be downloaded from the *[scMultiome](https://bioconductor.org/packages/3.22/scMultiome)* package. In this example, prostate cancer cells (LNCaP) were infected in separate wells with viruses encoding 4 transcription factors (NKX2-1, GATA6, FOXA1 and FOXA2) and a positive control (mNeonGreen) before pooling. The identity of the infected transcription factors was tracked through cell hashing (available in the field `hash_assignment` of the `colData`) and serves as the ground truth.

```
# load the MAE object
library(scMultiome)
mae <- scMultiome::reprogramSeq()

# extract peak matrix
PeakMatrix <- mae[["PeakMatrix"]]

# extract expression matrix
GeneExpressionMatrix <- mae[["GeneExpressionMatrix"]]
rownames(GeneExpressionMatrix) <- rowData(GeneExpressionMatrix)$name

# define the order of hash_assigment
GeneExpressionMatrix$hash_assignment <-
  factor(as.character(GeneExpressionMatrix$hash_assignment),
         levels = c("HTO10_GATA6_UTR", "HTO2_GATA6_v2",
                    "HTO8_NKX2.1_UTR", "HTO3_NKX2.1_v2",
                    "HTO1_FOXA2_v2", "HTO4_mFOXA1_v2", "HTO6_hFOXA1_UTR",
                    "HTO5_NeonG_v2"))
# extract dimensional reduction matrix
reducedDimMatrix <- reducedDim(mae[['TileMatrix500']], "LSI_ATAC")

# transfer UMAP_combined from TileMatrix to GeneExpressionMatrix
reducedDim(GeneExpressionMatrix, "UMAP_Combined") <-
  reducedDim(mae[['TileMatrix500']], "UMAP_Combined")
```

Visualize singleCellExperiment by UMAP

```
scater::plotReducedDim(GeneExpressionMatrix,
                       dimred = "UMAP_Combined",
                       text_by = "Clusters",
                       colour_by = "Clusters")
```

![](data:image/png;base64...)

# 4 Quick start

## 4.1 Retrieve bulk TF ChIP-seq binding sites

First, we retrieve a `GRangesList` object containing the binding sites of all the transcription factors and co-regulators. These binding sites are derived from bulk ChIP-seq data in the [ChIP-Atlas](https://chip-atlas.org/) and [ENCODE](https://www.encodeproject.org/) databases. For the same transcription factor, multiple ChIP-seq files from different cell lines or tissues are merged. For further information on how these peaks are derived, please refer to `?epiregulon::getTFMotifInfo`. Currently, human genomes hg19 and hg38 and mouse mm10 are supported.

```
grl <- getTFMotifInfo(genome = "hg38")
#> Retrieving chip-seq data, version 2
#> see ?scMultiome and browseVignettes('scMultiome') for documentation
#> loading from cache
grl
#> GRangesList object of length 1377:
#> $AEBP2
#> GRanges object with 2700 ranges and 0 metadata columns:
#>          seqnames            ranges strand
#>             <Rle>         <IRanges>  <Rle>
#>      [1]     chr1        9792-10446      *
#>      [2]     chr1     942105-942400      *
#>      [3]     chr1     984486-984781      *
#>      [4]     chr1   3068932-3069282      *
#>      [5]     chr1   3069411-3069950      *
#>      ...      ...               ...    ...
#>   [2696]     chrY   8465261-8465730      *
#>   [2697]     chrY 11721744-11722260      *
#>   [2698]     chrY 11747448-11747964      *
#>   [2699]     chrY 19302661-19303134      *
#>   [2700]     chrY 19985662-19985982      *
#>   -------
#>   seqinfo: 25 sequences from an unspecified genome; no seqlengths
#>
#> ...
#> <1376 more elements>
```

We recommend the use of ChIP-seq data over motif for estimating TF occupancy. However, if the user would like to start from motifs, it is possible to switch to the `motif` mode. The user can provide the peak regions as a `GRanges` object and the location of the motifs will be annotated based on Cisbp from chromVARmotifs (human\_pwms\_v2 and mouse\_pwms\_v2, version 0.2)

```
grl.motif <- getTFMotifInfo(genome = "hg38",
                            mode = "motif",
                            peaks = rowRanges(PeakMatrix))
```

## 4.2 Link ATAC-seq peaks to target genes

Next, we try to link ATAC-seq peaks to their putative target genes. We assign a peak to a gene within a size window (default ±250kb) if the chromatin accessibility of the peak and expression of the target genes are highly correlated (default p-vale threshold 0.05). To compute correlations, we first create cell aggregates by performing k-means clustering on the reduced dimensionality matrix. Then we aggregate the counts of the gene expression and peak matrix and average across the number of cells. Correlations are computed on the averaged gene expression and chromatin accessibility.

### 4.2.1 Optimize the number of metacells (Optional)

The number of metacells used to aggregate cells into meta-cells is a sensitive parameter, as it should strike the correct balance between averaging out biological variation and reducing signal noise caused by sparsity in single cells. Therefore, we provide a separate function, `optimizeMetacellNumber`, to automatically select the optimal value for this parameter. The algorithm samples different possible values and calculates the mean empirical p-value of RE–TG connections for each value. Then, a quadratic regression is fitted to the relationship, and the minimum of the function is determined.

```
cellNum <- optimizeMetacellNumber(peakMatrix = PeakMatrix,
                                  expMatrix = GeneExpressionMatrix,
                                  reducedDim = reducedDimMatrix,
                                  exp_assay = "normalizedCounts",
                                  peak_assay = "counts",
                                  BPPARAM = BiocParallel::SerialParam(progressbar = FALSE))
#> Warning in optimizeMetacellNumber(peakMatrix = PeakMatrix, expMatrix =
#> GeneExpressionMatrix, : Coefficient of quadratic term in linear regression is
#> not positive.
#> Warning in optimizeMetacellNumber(peakMatrix = PeakMatrix, expMatrix =
#> GeneExpressionMatrix, : Solution at the boundary of examined range.
#> Warning in optimizeMetacellNumber(peakMatrix = PeakMatrix, expMatrix =
#> GeneExpressionMatrix, : Coefficient of determination of the regression model is
#> lower thant 0.7
#> An issue detected during estimation optimal number of metacells.
#> Consider at least one of the following actions:
#> 1. Change of the `cellNumMin` and `cellNumMax` paramaters
#> 2. Increasing the number of evaluation points (`n_evaluation_points` argument)
#> 3. Increasing the number of iterations (`n_iter` argument)
#> 4. Increasing the number of false connections used to compute p-value
#> null distribution (`nRandConns` argument)
#> Solution not found using quadratic regression. Using cluster size with the lowest mean p-value.
```

We can plot the results to make sure that the relationship is correctly generalized.

```
plot(cellNum)
```

![](data:image/png;base64...)

### 4.2.2 Calculate Peak to Gene Links

The output of `optimizeMetacellNumber` function is then passed to `calculateP2G` as `cellNum` argument. Alternatively, users may skip `optimizeMetacellNumber` and specify their own cell number in `cellNum`.

```
set.seed(1010)
p2g <- calculateP2G(peakMatrix = PeakMatrix,
                    expMatrix = GeneExpressionMatrix,
                    reducedDim = reducedDimMatrix,
                    exp_assay = "normalizedCounts",
                    peak_assay = "counts",
                    cellNum = cellNum,
                    BPPARAM = BiocParallel::SerialParam(progressbar = FALSE))
#> Using epiregulon to compute peak to gene links...
#> Creating metacells...
#> Looking for regulatory elements near target genes...
#> Computing correlations...

p2g
#> DataFrame with 28120 rows and 10 columns
#>         idxATAC         chr     start       end    idxRNA     target
#>       <integer> <character> <integer> <integer> <integer>    <array>
#> 1             1        chr1    817121    817621        15  LINC01409
#> 2             8        chr1    917255    917755        27    PLEKHN1
#> 3            10        chr1    920987    921487        28      PERM1
#> 4            14        chr1    932922    933422        18  LINC00115
#> 5            14        chr1    932922    933422        20 AL645608.6
#> ...         ...         ...       ...       ...       ...        ...
#> 28116    126579        chrX 154799320 154799820     36414       DKC1
#> 28117    126581        chrX 154917936 154918436     36420     FUNDC2
#> 28118    126589        chrX 155216677 155217177     36426      CLIC2
#> 28119    126590        chrX 155228844 155229344     36426      CLIC2
#> 28120    126591        chrX 155264314 155264814     36424       VBP1
#>       Correlation p_val_peak_gene FDR_peak_gene  distance
#>          <matrix>        <matrix>      <matrix> <integer>
#> 1        0.670692      0.01973535      0.876821     38363
#> 2       -0.426836      0.03049020      0.893849     48725
#> 3        0.638859      0.02585148      0.892849     59540
#> 4       -0.576828      0.00344532      0.849255    105400
#> 5       -0.482178      0.01426327      0.874095     28088
#> ...           ...             ...           ...       ...
#> 28116   -0.498616      0.01140705      0.867484     36578
#> 28117   -0.501012      0.01110357      0.867484    108406
#> 28118    0.601789      0.03426402      0.893849    117435
#> 28119    0.803239      0.00582056      0.849255    105268
#> 28120    0.597658      0.03544632      0.893849     67307
```

## 4.3 Add TF motif binding to peaks

The next step is to add the TF binding information by overlapping regions of the peak matrix with the bulk chip-seq database. The output is a data frame object with three columns:

1. `idxATAC` - index of the peak in the peak matrix
2. `idxTF` - index in the gene expression matrix corresponding to the transcription factor
3. `tf` - name of the transcription factor

```
overlap <- addTFMotifInfo(grl = grl,
                          p2g = p2g,
                          peakMatrix = PeakMatrix)
#> Computing overlap...
#> Success!
head(overlap)
#>   idxATAC idxTF    tf
#> 1       1    16  ATF1
#> 2       1    17  ATF2
#> 3       1    18  ATF3
#> 4       1    21  ATF7
#> 5       1    35 BRCA2
#> 6       1    36  BRD4
```

## 4.4 Generate regulons

A DataFrame, representing the inferred regulons, is then generated. The DataFrame consists of ten columns:

1. `idxATAC` - index of the peak in the peak matrix
2. `chr` - chromosome number
3. `start` - start position of the peak
4. `end` - end position of the peak
5. `idxRNA` - index in the gene expression matrix corresponding to the target gene
6. `target` - name of the target gene
7. `distance` - distance between the transcription start site of the target gene and the middle of the peak
8. `idxTF` - index in the gene expression matrix corresponding to the transcription factor
9. `tf` - name of the transcription factor
10. `corr` - correlation between target gene expression and the chromatin accessibility at the peak. if cluster labels are provided,
    this field is a matrix with columns names corresponding to correlation across all cells and for each of the clusters.

```
regulon <- getRegulon(p2g = p2g,
                      overlap = overlap)
regulon
#> DataFrame with 5265039 rows and 12 columns
#>           idxATAC         chr     start       end    idxRNA    target     corr
#>         <integer> <character> <integer> <integer> <integer>   <array> <matrix>
#> 1               1        chr1    817121    817621        15 LINC01409 0.670692
#> 2               1        chr1    817121    817621        15 LINC01409 0.670692
#> 3               1        chr1    817121    817621        15 LINC01409 0.670692
#> 4               1        chr1    817121    817621        15 LINC01409 0.670692
#> 5               1        chr1    817121    817621        15 LINC01409 0.670692
#> ...           ...         ...       ...       ...       ...       ...      ...
#> 5265035    126591        chrX 155264314 155264814     36424      VBP1 0.597658
#> 5265036    126591        chrX 155264314 155264814     36424      VBP1 0.597658
#> 5265037    126591        chrX 155264314 155264814     36424      VBP1 0.597658
#> 5265038    126591        chrX 155264314 155264814     36424      VBP1 0.597658
#> 5265039    126591        chrX 155264314 155264814     36424      VBP1 0.597658
#>         p_val_peak_gene FDR_peak_gene  distance     idxTF          tf
#>                <matrix>      <matrix> <integer> <integer> <character>
#> 1             0.0197353      0.876821     38363        16        ATF1
#> 2             0.0197353      0.876821     38363        17        ATF2
#> 3             0.0197353      0.876821     38363        18        ATF3
#> 4             0.0197353      0.876821     38363        21        ATF7
#> 5             0.0197353      0.876821     38363        35       BRCA2
#> ...                 ...           ...       ...       ...         ...
#> 5265035       0.0354463      0.893849     67307      1316      ZNF692
#> 5265036       0.0354463      0.893849     67307      1357      ZNF843
#> 5265037       0.0354463      0.893849     67307      1366     ZSCAN21
#> 5265038       0.0354463      0.893849     67307      1370     ZSCAN30
#> 5265039       0.0354463      0.893849     67307      1376        ZXDB
```

## 4.5 Network pruning (highly recommended)

Epiregulon prunes the network by performing tests of independence on the observed number of cells jointly expressing transcription factor (TF), regulatory element (RE) and target gene (TG) vs the expected number of cells if TF/RE and TG are independently expressed. The users can choose between two tests, the binomial test and the chi-square test. In the binomial test, the expected probability is P(TF, RE) \* P(TG), and the number of trials is the total number of cells, and the observed successes is the number of cells jointly expressing all three elements. In the chi-square test, the expected probability for having all 3 elements active is also P(TF, RE) \* P(TG) and the probability otherwise is 1- P(TF, RE) \* P(TG). The observed cell count for the category of “active TF” is the number of cells jointly expressing all three elements, and the cell count for the inactive category is n - n\_triple.

We calculate cluster-specific p-values if users supply cluster labels. This is useful if we are interested in cluster-specific networks. The pruned regulons can then be used to visualize differential networks for transcription factors of interest.

```
pruned.regulon <- pruneRegulon(expMatrix = GeneExpressionMatrix,
                               exp_assay = "normalizedCounts",
                               peakMatrix = PeakMatrix,
                               peak_assay = "counts",
                               test = "chi.sq",
                               regulon = regulon[regulon$tf %in%
                                         c("NKX2-1","GATA6","FOXA1","FOXA2", "AR"),],
                               clusters = GeneExpressionMatrix$Clusters,
                               prune_value = "pval",
                               regulon_cutoff = 0.05
                               )

pruned.regulon
```

## 4.6 Add Weights

While the `pruneRegulon` function provides statistics on the joint occurrence of TF-RE-TG, we would like to further estimate the strength of regulation. Biologically, this can be interpreted as the magnitude of gene expression changes induced by transcription factor activity. Epiregulon estimates the regulatory potential using one of the three measures: 1) correlation between TF and target gene expression, 2) mutual information between the TF and target gene expression and 3) Wilcoxon test statistics of target gene expression in cells jointly expressing all 3 elements vs cells that do not.

Two of the measures (correlation and Wilcoxon statistics) give both the magnitude and directionality of changes whereas mutual information is always positive. The correlation and mutual information statistics are computed on pseudobulks aggregated by user-supplied cluster labels, whereas the Wilcoxon method groups cells into two categories: 1) the active category of cells jointly expressing TF, RE and TG and 2) the inactive category consisting of the remaining cells.

We calculate cluster-specific weights if users supply cluster labels.

```
regulon.w <- addWeights(regulon = pruned.regulon,
                        expMatrix  = GeneExpressionMatrix,
                        exp_assay  = "normalizedCounts",
                        peakMatrix = PeakMatrix,
                        peak_assay = "counts",
                        clusters = GeneExpressionMatrix$Clusters,
                        method = "wilcox")

regulon.w
```

## 4.7 Annotate with TF motifs (Optional)

So far the gene regulatory network was constructed from TF ChIP-seq exclusively. Some users would prefer to further annotate regulatory elements with the presence of motifs. We provide an option to annotate peaks with motifs from the Cisbp database. If no motifs are present for this particular factor (as in the case of co-factors or chromatin modifiers), we return NA. If motifs are available for a factor and the RE contains a motif, we return 1. If motifs are available and the RE does not contain a motif, we return 0. The users can also provide their own motif annotation through the `pwms` argument.

```
regulon.w.motif <- addMotifScore(regulon = regulon.w,
                                 peaks = rowRanges(PeakMatrix),
                                 species = "human",
                                 genome = "hg38")
#> annotating peaks with motifs
#> see ?scMultiome and browseVignettes('scMultiome') for documentation
#> loading from cache
#>
#> Attaching package: 'Biostrings'
#> The following object is masked from 'package:base':
#>
#>     strsplit
#>
#> Attaching package: 'rtracklayer'
#> The following object is masked from 'package:AnnotationHub':
#>
#>     hubUrl

# if desired, set weight to 0 if no motif is found
regulon.w.motif$weight[regulon.w.motif$motif == 0] <- 0

regulon.w.motif
#> DataFrame with 12405 rows and 17 columns
#>         idxATAC         chr     start       end    idxRNA     target      corr
#>       <integer> <character> <integer> <integer> <integer>    <array>  <matrix>
#> 1            10        chr1    920987    921487        28      PERM1  0.638859
#> 2            14        chr1    932922    933422        25      NOC2L -0.395829
#> 3            14        chr1    932922    933422        20 AL645608.6 -0.482178
#> 4            14        chr1    932922    933422        28      PERM1 -0.388740
#> 5            37        chr1   1020509   1021009        33       AGRN  0.639086
#> ...         ...         ...       ...       ...       ...        ...       ...
#> 12401    123380        chr9 128635245 128635745     35034     SPTAN1  0.843048
#> 12402    123444        chr9 129139814 129140314     35053    SH3GLB2 -0.399388
#> 12403    124120        chr9 137240872 137241372     35274      NELFB -0.394052
#> 12404    124405        chrX  15737784  15738284     35402      AP1S2 -0.389650
#> 12405    124978        chrX  47541057  47541557     35594      ZNF41 -0.452951
#>       p_val_peak_gene FDR_peak_gene  distance     idxTF          tf
#>              <matrix>      <matrix> <integer> <integer> <character>
#> 1           0.0258515      0.892849     59540       485          AR
#> 2           0.0436110      0.893849     25832       485          AR
#> 3           0.0142633      0.874095     28088       485          AR
#> 4           0.0469135      0.893849     47605       485          AR
#> 5           0.0258060      0.892849       389       485          AR
#> ...               ...           ...       ...       ...         ...
#> 12401      0.00356964      0.849255     82687       723      NKX2-1
#> 12402      0.04196865      0.893849    111629       723      NKX2-1
#> 12403      0.04450355      0.893849     13953       723      NKX2-1
#> 12404      0.04650291      0.893849    116469       723      NKX2-1
#> 12405      0.02158235      0.880129     58472       723      NKX2-1
#>                          pval                    stats             qval
#>                      <matrix>                 <matrix>         <matrix>
#> 1     0.103465:0.880435:1:... 2.651304:0.0226256:0:...        1:1:1:...
#> 2     0.280507:0.843914:1:... 1.164630:0.0387653:0:...        1:1:1:...
#> 3     0.182226:0.509635:1:... 1.779378:0.4348165:0:...        1:1:1:...
#> 4     0.559820:0.787860:1:... 0.340016:0.0724101:0:...        1:1:1:...
#> 5     0.105800:0.564073:1:... 2.615861:0.3327009:0:...        1:1:1:...
#> ...                       ...                      ...              ...
#> 12401     4.51202e-02:1:1:...          4.01414:0:0:... 1.000000:1:1:...
#> 12402     1.79623e-01:1:1:...          1.80074:0:0:... 1.000000:1:1:...
#> 12403     1.07516e-01:1:1:...          2.59036:0:0:... 1.000000:1:1:...
#> 12404     1.65845e-02:1:1:...          5.73982:0:0:... 1.000000:1:1:...
#> 12405     9.49637e-06:1:1:...         19.61014:0:0:... 0.680861:1:1:...
#>          weight     motif
#>        <matrix> <numeric>
#> 1     0:0:0:...         0
#> 2     0:0:0:...         0
#> 3     0:0:0:...         0
#> 4     0:0:0:...         0
#> 5     0:0:0:...         0
#> ...         ...       ...
#> 12401 0:0:0:...         0
#> 12402 0:0:0:...         0
#> 12403 0:0:0:...         0
#> 12404 0:0:0:...         0
#> 12405 0:0:0:...         0
```

## 4.8 Annotate with log fold changes (Optional)

It is sometimes helpful to filter the regulons based on gene expression changes between two conditions. The `addLogFC` function is a wrapper around `scran::findMarkers` and adds extra columns of log changes to the regulon DataFrame. The users can specify the reference condition in `logFC_ref` and conditions for comparison in
`logFC_condition`. If these are not provided, log fold changes are calculated for every condition in the cluster labels against the rest of the conditions.

```
# create logcounts
GeneExpressionMatrix <- scuttle::logNormCounts(GeneExpressionMatrix)

# add log fold changes which are calculated by taking the difference of the log counts
regulon.w <- addLogFC(regulon = regulon.w,
                      clusters = GeneExpressionMatrix$hash_assignment,
                      expMatrix  = GeneExpressionMatrix,
                      assay.type  = "logcounts",
                      pval.type = "any",
                      logFC_condition = c("HTO10_GATA6_UTR",
                                          "HTO2_GATA6_v2",
                                          "HTO8_NKX2.1_UTR"),
                      logFC_ref = "HTO5_NeonG_v2")

regulon.w
#> DataFrame with 12405 rows and 25 columns
#>         idxATAC         chr     start       end    idxRNA     target      corr
#>       <integer> <character> <integer> <integer> <integer>    <array>  <matrix>
#> 1            10        chr1    920987    921487        28      PERM1  0.638859
#> 2            14        chr1    932922    933422        25      NOC2L -0.395829
#> 3            14        chr1    932922    933422        20 AL645608.6 -0.482178
#> 4            14        chr1    932922    933422        28      PERM1 -0.388740
#> 5            37        chr1   1020509   1021009        33       AGRN  0.639086
#> ...         ...         ...       ...       ...       ...        ...       ...
#> 12401    123380        chr9 128635245 128635745     35034     SPTAN1  0.843048
#> 12402    123444        chr9 129139814 129140314     35053    SH3GLB2 -0.399388
#> 12403    124120        chr9 137240872 137241372     35274      NELFB -0.394052
#> 12404    124405        chrX  15737784  15738284     35402      AP1S2 -0.389650
#> 12405    124978        chrX  47541057  47541557     35594      ZNF41 -0.452951
#>       p_val_peak_gene FDR_peak_gene  distance     idxTF          tf
#>              <matrix>      <matrix> <integer> <integer> <character>
#> 1           0.0258515      0.892849     59540       485          AR
#> 2           0.0436110      0.893849     25832       485          AR
#> 3           0.0142633      0.874095     28088       485          AR
#> 4           0.0469135      0.893849     47605       485          AR
#> 5           0.0258060      0.892849       389       485          AR
#> ...               ...           ...       ...       ...         ...
#> 12401      0.00356964      0.849255     82687       723      NKX2-1
#> 12402      0.04196865      0.893849    111629       723      NKX2-1
#> 12403      0.04450355      0.893849     13953       723      NKX2-1
#> 12404      0.04650291      0.893849    116469       723      NKX2-1
#> 12405      0.02158235      0.880129     58472       723      NKX2-1
#>                          pval                    stats             qval
#>                      <matrix>                 <matrix>         <matrix>
#> 1     0.103465:0.880435:1:... 2.651304:0.0226256:0:...        1:1:1:...
#> 2     0.280507:0.843914:1:... 1.164630:0.0387653:0:...        1:1:1:...
#> 3     0.182226:0.509635:1:... 1.779378:0.4348165:0:...        1:1:1:...
#> 4     0.559820:0.787860:1:... 0.340016:0.0724101:0:...        1:1:1:...
#> 5     0.105800:0.564073:1:... 2.615861:0.3327009:0:...        1:1:1:...
#> ...                       ...                      ...              ...
#> 12401     4.51202e-02:1:1:...          4.01414:0:0:... 1.000000:1:1:...
#> 12402     1.79623e-01:1:1:...          1.80074:0:0:... 1.000000:1:1:...
#> 12403     1.07516e-01:1:1:...          2.59036:0:0:... 1.000000:1:1:...
#> 12404     1.65845e-02:1:1:...          5.73982:0:0:... 1.000000:1:1:...
#> 12405     9.49637e-06:1:1:...         19.61014:0:0:... 0.680861:1:1:...
#>                             weight HTO10_GATA6_UTR.vs.HTO5_NeonG_v2.FDR
#>                           <matrix>                            <numeric>
#> 1     0.02638820:-0.00723681:0:...                            1.0000000
#> 2     0.01967612: 0.00569181:0:...                            0.9752600
#> 3     0.03590731:-0.03273486:0:...                            0.3913742
#> 4     0.00967161:-0.01328838:0:...                            1.0000000
#> 5     0.02420994:-0.02931996:0:...                            0.0333213
#> ...                            ...                                  ...
#> 12401            0.0277381:0:0:...                             0.891051
#> 12402            0.0211504:0:0:...                             1.000000
#> 12403            0.0246483:0:0:...                             1.000000
#> 12404            0.0397841:0:0:...                             1.000000
#> 12405            0.0696895:0:0:...                             1.000000
#>       HTO10_GATA6_UTR.vs.HTO5_NeonG_v2.p.value
#>                                      <numeric>
#> 1                                    -0.306482
#> 2                                    -1.087602
#> 3                                    -3.630700
#> 4                                    -0.306482
#> 5                                    -6.908244
#> ...                                        ...
#> 12401                                -2.088809
#> 12402                                -0.875472
#> 12403                                -0.346989
#> 12404                                -0.817361
#> 12405                                -1.048695
#>       HTO10_GATA6_UTR.vs.HTO5_NeonG_v2.logFC HTO2_GATA6_v2.vs.HTO5_NeonG_v2.FDR
#>                                    <numeric>                          <numeric>
#> 1                                 0.00267018                         0.95051180
#> 2                                -0.02672751                         1.00000000
#> 3                                -0.02908575                         1.00000000
#> 4                                 0.00267018                         0.95051180
#> 5                                 0.06228930                         0.00813329
#> ...                                      ...                                ...
#> 12401                             0.05722383                          0.0780338
#> 12402                            -0.01947302                          1.0000000
#> 12403                            -0.00696269                          1.0000000
#> 12404                            -0.01490592                          0.9505118
#> 12405                             0.01652101                          1.0000000
#>       HTO2_GATA6_v2.vs.HTO5_NeonG_v2.p.value
#>                                    <numeric>
#> 1                                  -1.145473
#> 2                                  -0.764604
#> 3                                  -0.613957
#> 4                                  -1.145473
#> 5                                  -8.744274
#> ...                                      ...
#> 12401                              -5.984106
#> 12402                              -0.685001
#> 12403                              -0.430542
#> 12404                              -1.533481
#> 12405                              -0.434791
#>       HTO2_GATA6_v2.vs.HTO5_NeonG_v2.logFC HTO8_NKX2.1_UTR.vs.HTO5_NeonG_v2.FDR
#>                                  <numeric>                            <numeric>
#> 1                              -0.00410095                             1.000000
#> 2                              -0.01947775                             1.000000
#> 3                              -0.00903561                             1.000000
#> 4                              -0.00410095                             1.000000
#> 5                               0.06470266                             0.968083
#> ...                                    ...                                  ...
#> 12401                           0.11104599                             0.992412
#> 12402                          -0.01469769                             1.000000
#> 12403                          -0.00758876                             1.000000
#> 12404                          -0.02184636                             0.978457
#> 12405                           0.00696425                             0.978457
#>       HTO8_NKX2.1_UTR.vs.HTO5_NeonG_v2.p.value
#>                                      <numeric>
#> 1                                    -0.125877
#> 2                                    -0.877433
#> 3                                    -0.318033
#> 4                                    -0.125877
#> 5                                    -2.479073
#> ...                                        ...
#> 12401                                -1.122331
#> 12402                                -0.154245
#> 12403                                -0.784077
#> 12404                                -1.855533
#> 12405                                -1.356691
#>       HTO8_NKX2.1_UTR.vs.HTO5_NeonG_v2.logFC
#>                                    <numeric>
#> 1                               -0.000708047
#> 2                               -0.021300165
#> 3                                0.005164618
#> 4                               -0.000708047
#> 5                                0.024761627
#> ...                                      ...
#> 12401                             0.03146638
#> 12402                             0.00395594
#> 12403                            -0.01222574
#> 12404                            -0.02439659
#> 12405                             0.01700461
```

## 4.9 Calculate TF activity

Finally, the activities for a specific TF in each cell are computed by averaging expressions of target genes linked to the TF weighted by the test statistics of choice, chosen from either correlation, mutual information or the Wilcoxon test statistics.
\[y=\frac{1}{n}\sum\_{i=1}^{n} x\_i \* weights\_i\]
where \(y\) is the activity of a TF for a cell,
\(n\) is the total number of targets for a TF,
\(x\_i\) is the log count expression of target \(i\) where \(i\) in {1,2,…,n} and
\(weights\_i\) is the weight of TF - target \(i\)

```
score.combine <- calculateActivity(expMatrix = GeneExpressionMatrix,
                                   regulon = regulon.w,
                                   mode = "weight",
                                   method = "weightedMean",
                                   exp_assay = "normalizedCounts",
                                   normalize = FALSE)
#> Warning in calculateActivity(expMatrix = GeneExpressionMatrix, regulon =
#> regulon.w, : Argument 'method' to calculateActivity was deprecated as of
#> epiregulon version 2.0.0
#> calculating TF activity from regulon using weightedMean
#> Warning in calculateActivity(expMatrix = GeneExpressionMatrix, regulon = regulon.w, : The weight column contains multiple subcolumns but no cluster information was provided.
#>           Using first column to compute activity...
#> aggregating regulons...
#> creating weight matrix...
#> calculating activity scores...
#> normalize by the number of targets...

score.combine[1:5,1:5]
#> 5 x 5 sparse Matrix of class "dgCMatrix"
#>        reprogram#TTAGGAACAAGGTACG-1 reprogram#GAGCGGTCAACCTGGT-1
#> AR                       0.01748754                   0.01902210
#> FOXA1                    0.01594352                   0.01562493
#> FOXA2                    0.01668285                   0.02000509
#> GATA6                    0.01590999                   0.05706049
#> NKX2-1                   0.02949717                   0.01737281
#>        reprogram#TTATAGCCACCCTCAC-1 reprogram#TGGTGATTCCTGTTCA-1
#> AR                      0.010467290                  0.010765099
#> FOXA1                   0.010635861                  0.010349299
#> FOXA2                   0.012503277                  0.014421759
#> GATA6                   0.009035979                  0.007895991
#> NKX2-1                  0.012772370                  0.011795167
#>        reprogram#TCGGTTCTCACTAGGT-1
#> AR                       0.01775971
#> FOXA1                    0.01581682
#> FOXA2                    0.01439649
#> GATA6                    0.01188049
#> NKX2-1                   0.02613054
```

# 5 Session Info

```
sessionInfo()
#> R version 4.5.2 (2025-10-31)
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
#>  [1] BSgenome.Hsapiens.UCSC.hg38_1.4.5 BSgenome_1.78.0
#>  [3] rtracklayer_1.70.0                BiocIO_1.20.0
#>  [5] Biostrings_2.78.0                 XVector_0.50.0
#>  [7] GenomeInfoDb_1.46.2               scMultiome_1.10.0
#>  [9] MultiAssayExperiment_1.36.1       ExperimentHub_3.0.0
#> [11] AnnotationHub_4.0.0               BiocFileCache_3.0.0
#> [13] dbplyr_2.5.1                      epiregulon_2.0.2
#> [15] SingleCellExperiment_1.32.0       SummarizedExperiment_1.40.0
#> [17] Biobase_2.70.0                    GenomicRanges_1.62.1
#> [19] Seqinfo_1.0.0                     IRanges_2.44.0
#> [21] S4Vectors_0.48.0                  BiocGenerics_0.56.0
#> [23] generics_0.1.4                    MatrixGenerics_1.22.0
#> [25] matrixStats_1.5.0                 BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>   [1] RColorBrewer_1.1-3          jsonlite_2.0.0
#>   [3] magrittr_2.0.4              ggbeeswarm_0.7.3
#>   [5] magick_2.9.0                farver_2.1.2
#>   [7] rmarkdown_2.30              vctrs_0.6.5
#>   [9] memoise_2.0.1               Rsamtools_2.26.0
#>  [11] RCurl_1.98-1.17             tinytex_0.58
#>  [13] htmltools_0.5.9             S4Arrays_1.10.1
#>  [15] BiocBaseUtils_1.12.0        curl_7.0.0
#>  [17] BiocNeighbors_2.4.0         Rhdf5lib_1.32.0
#>  [19] SparseArray_1.10.6          rhdf5_2.54.1
#>  [21] sass_0.4.10                 bslib_0.9.0
#>  [23] httr2_1.2.2                 cachem_1.1.0
#>  [25] GenomicAlignments_1.46.0    igraph_2.2.1
#>  [27] lifecycle_1.0.4             pkgconfig_2.0.3
#>  [29] rsvd_1.0.5                  Matrix_1.7-4
#>  [31] R6_2.6.1                    fastmap_1.2.0
#>  [33] digest_0.6.39               TFMPvalue_0.0.9
#>  [35] AnnotationDbi_1.72.0        scater_1.38.0
#>  [37] dqrng_0.4.1                 irlba_2.3.5.1
#>  [39] RSQLite_2.4.5               beachmat_2.26.0
#>  [41] seqLogo_1.76.0              filelock_1.0.3
#>  [43] labeling_0.4.3              httr_1.4.7
#>  [45] abind_1.4-8                 compiler_4.5.2
#>  [47] bit64_4.6.0-1               withr_3.0.2
#>  [49] S7_0.2.1                    backports_1.5.0
#>  [51] BiocParallel_1.44.0         viridis_0.6.5
#>  [53] DBI_1.2.3                   HDF5Array_1.38.0
#>  [55] rappdirs_0.3.3              DelayedArray_0.36.0
#>  [57] bluster_1.20.0              rjson_0.2.23
#>  [59] gtools_3.9.5                caTools_1.18.3
#>  [61] tools_4.5.2                 vipor_0.4.7
#>  [63] otel_0.2.0                  beeswarm_0.4.0
#>  [65] glue_1.8.0                  h5mread_1.2.1
#>  [67] restfulr_0.0.16             rhdf5filters_1.22.0
#>  [69] grid_4.5.2                  checkmate_2.3.3
#>  [71] cluster_2.1.8.1             TFBSTools_1.48.0
#>  [73] gtable_0.3.6                metapod_1.18.0
#>  [75] BiocSingular_1.26.1         ScaledMatrix_1.18.0
#>  [77] ggrepel_0.9.6               BiocVersion_3.22.0
#>  [79] pillar_1.11.1               motifmatchr_1.32.0
#>  [81] limma_3.66.0                dplyr_1.1.4
#>  [83] lattice_0.22-7              bit_4.6.0
#>  [85] DirichletMultinomial_1.52.0 tidyselect_1.2.1
#>  [87] locfit_1.5-9.12             scuttle_1.20.0
#>  [89] knitr_1.50                  gridExtra_2.3
#>  [91] scrapper_1.4.0              bookdown_0.46
#>  [93] edgeR_4.8.1                 xfun_0.54
#>  [95] statmod_1.5.1               UCSC.utils_1.6.0
#>  [97] yaml_2.3.11                 evaluate_1.0.5
#>  [99] codetools_0.2-20            cigarillo_1.0.0
#> [101] tibble_3.3.0                BiocManager_1.30.27
#> [103] cli_3.6.5                   jquerylib_0.1.4
#> [105] dichromat_2.0-0.1           Rcpp_1.1.0
#> [107] png_0.1-8                   XML_3.99-0.20
#> [109] parallel_4.5.2              ggplot2_4.0.1
#> [111] blob_1.2.4                  scran_1.38.0
#> [113] bitops_1.0-9                pwalign_1.6.0
#> [115] viridisLite_0.4.2           scales_1.4.0
#> [117] purrr_1.2.0                 crayon_1.5.3
#> [119] rlang_1.1.6                 cowplot_1.2.0
#> [121] KEGGREST_1.50.0
```