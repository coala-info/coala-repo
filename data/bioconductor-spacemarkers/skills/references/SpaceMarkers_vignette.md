# Inferring Immune Interactions in Breast Cancer

Orian Stapleton

#### 2025-09-17

# 1 Overview

SpaceMarkers leverages latent feature analysis of the spatial components of
transcriptomic data to identify biologically relevant molecular interactions
between cell groups.This tutorial will use the latent features from CoGAPS to
look at pattern interactions in a Visium 10x breast ductal carcinoma spatial
transcriptomics dataset.

# 2 Installation

```
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("SpaceMarkers")
```

```
library(SpaceMarkers)
```

# 3 Setup

## 3.1 Links to Data

The data that will be used to demonstrate SpaceMarkers’ capabilities is a human
breast cancer spatial transcriptomics dataset that comes from Visium. The CoGAPS
patterns as seen in the manuscript
[Atul Deshpande et al.](https://doi.org/10.1016/j.cels.2023.03.004)
will also be used

```
data_dir <- "visiumBrCA"
unlink(file.path(data_dir), recursive = TRUE)
dir.create(data_dir,showWarnings = FALSE)
main_10xlink <- "https://cf.10xgenomics.com/samples/spatial-exp/1.3.0"
counts_folder <- "Visium_Human_Breast_Cancer"
counts_file <- "Visium_Human_Breast_Cancer_filtered_feature_bc_matrix.h5"
counts_url<-paste(c(main_10xlink,counts_folder,counts_file), collapse = "/")
sp_folder <- "Visium_Human_Breast_Cancer"
sp_file <- "Visium_Human_Breast_Cancer_spatial.tar.gz"
sp_url<-paste(c(main_10xlink,sp_folder,sp_file),collapse = "/")
```

## 3.2 Extracting Counts Matrix

### 3.2.1 load10xExpr

Here the counts matrix will be obtained from the h5 object on the Visium site
and genes with less than 3 counts are removed from the dataset.This can be
achieved with the load10XExpr function.

```
download.file(counts_url,file.path(data_dir,basename(counts_url)), mode = "wb")
counts_matrix <- load10XExpr(visiumDir = data_dir, h5filename = counts_file)
good_gene_threshold <- 3
goodGenes <- rownames(counts_matrix)[
    apply(counts_matrix,1,function(x) sum(x>0)>=good_gene_threshold)]
```

```
## Warning in asMethod(object): sparse->dense coercion: allocating vector of size
## 1.3 GiB
```

```
counts_matrix <- counts_matrix[goodGenes,]
```

## 3.3 Obtaining CoGAPS Patterns

In this example the latent features from CoGAPS will be used to identify
interacting genes with SpaceMarkers. Here the featureLoadings (genes) and
samplePatterns (barcodes) for both the expression matrix and CoGAPS matrix
need to match.

```
cogaps_result <- readRDS(system.file("extdata","CoGAPS_result.rds",
    package="SpaceMarkers",mustWork = TRUE))
features <- intersect(rownames(counts_matrix),rownames(
    slot(cogaps_result,"featureLoadings")))
barcodes <- intersect(colnames(counts_matrix),rownames(
    slot(cogaps_result,"sampleFactors")))
counts_matrix <- counts_matrix[features,barcodes]
cogaps_matrix<-slot(cogaps_result,"featureLoadings")[features,]%*%
    t(slot(cogaps_result,"sampleFactors")[barcodes,])
```

## 3.4 Obtaining Spatial Coordinates

### 3.4.1 load10XCoords

The spatial coordinates will also be pulled from Visium for this dataset.
These are combined with the latent features to demonstrate how cells for each
pattern interact in 2D space. The data can be extracted with the
**load10XCoords()** function

```
download.file(sp_url, file.path(data_dir,basename(sp_url)), mode = "wb")
untar(file.path(data_dir,basename(sp_url)), exdir = file.path(data_dir))
spCoords <- load10XCoords(visiumDir = data_dir,
                          resolution="lowres", version = "1.0")
```

```
## resolution: lowres
```

```
rownames(spCoords) <- spCoords$barcode
spCoords <- spCoords[barcodes,]
spPatterns <- cbind(spCoords,slot(cogaps_result,"sampleFactors")[barcodes,])
head(spPatterns)
```

```
##                               barcode         y        x    Pattern_1
## AAACAACGAATAGTTC-1 AAACAACGAATAGTTC-1  67.28568 207.4858 0.4676255882
## AAACAAGTATCTCCCA-1 AAACAAGTATCTCCCA-1 238.79054 375.0650 0.2690758109
## AAACAATCTACTAGCA-1 AAACAATCTACTAGCA-1  77.82161 260.3531 0.1105933860
## AAACACCAATAACTGC-1 AAACACCAATAACTGC-1 268.53653 212.2053 0.0002508377
## AAACAGAGCGACTCCT-1 AAACAGAGCGACTCCT-1 115.92419 360.0982 0.2849308848
## AAACAGCTTTCAGAAG-1 AAACAGCTTTCAGAAG-1 213.86511 192.9231 0.1583736390
##                       Pattern_2    Pattern_3    Pattern_4    Pattern_5
## AAACAACGAATAGTTC-1 1.049391e-01 2.576064e-01 0.6848062277 4.747092e-02
## AAACAAGTATCTCCCA-1 4.394425e-01 2.056469e-01 0.2921337187 1.167576e-02
## AAACAATCTACTAGCA-1 1.148523e-02 2.309153e-01 0.4111314714 9.508318e-02
## AAACACCAATAACTGC-1 1.685795e-01 1.223603e-01 0.0001562788 8.041928e-01
## AAACAGAGCGACTCCT-1 1.102506e-01 9.053156e-08 0.2429406196 3.430807e-08
## AAACAGCTTTCAGAAG-1 9.741083e-06 1.723470e-01 0.3059957027 7.167605e-01
```

For demonstration purposes we will look at two patterns; Pattern\_1 (immune cell)
and Pattern\_5 (invasive carcinoma lesion). Furthermore we will only look at the
relationship between a pre-curated list of genes for efficiency.

```
data("curated_genes")
spPatterns <- spPatterns[c("barcode","y","x","Pattern_1","Pattern_5")]
counts_matrix <- counts_matrix[curated_genes,]
cogaps_matrix <- cogaps_matrix[curated_genes, ]
```

# 4 Executing SpaceMarkers

## 4.1 SpaceMarker Modes

SpaceMarkers can operate in ‘residual’ or ‘DE’ (DifferentialExpression) mode.
In an ideal world the overlapping patterns identified by SpaceMarkers would be a
homogeneous population of cells and the relationship between them would be
linear. However, due to confounding effects of variations in cell density and
common cell types in any given region, this is not always true.

To account for these confounding effects, the ‘residual’ mode compares the
feature interactions between the expression matrix and the reconstructed latent
space matrix. The features with the highest residual error are reported.
The genes are then classified according to regions of overlapping vs exclusive
influence. The default mode is ‘residual’ mode.

However this is not to say there is no utility for DE mode. Suppose the
feature (gene) information is not readily available and only the sample (cells)
latent feature patterns with P-values are available? This is the advantage of
‘DE’ mode. Where residual mode assesses the non-linear effects that may arise
from confounding variables, ‘DE’ mode assesses simple linear interactions
between patterns directly from expression. DE mode like residual mode also
compares genes from regions of overlapping vs exclusive influence butdoes not
consider residuals from the expression matrix as there is no matrix
reconstruction with the latent feature matrix.

### 4.1.1 Residual Mode

#### 4.1.1.1 SpaceMarkers Step1: Hotpsots

SpaceMarkers identifies regions of influence using a gaussian kernel outlier
based model. Spots that have spatial influence beyond the defined outlier
threshold are termed **hotspots**. SpaceMarkers then identifies where the
hotspots are overlapping/interacting and where they are mutually exclusive.

get\_spatial\_params\_morans\_i: This function sets the width of the spatial kernel
(sigmaOpt) as well as the outlier threshold around the set of spots
(threshOpt) for each pattern. By default, the sigmaOpt is set to the spot
diameter at the appropriate resolution. Note that the legacy function has been
deprecated and has been renamed to .get\_spatial\_params\_morans\_i. Please read the
documentation for more information.

```
optParams <- get_spatial_params_morans_i(spPatterns,visiumDir = data_dir,
                                          resolution = "lowres")
```

```
## Warning in get_spatial_params_morans_i(spPatterns, visiumDir = data_dir, : 'get_spatial_params_morans_i' is deprecated.
## Use 'get_spatial_parameters' instead.
## See help("Deprecated")
```

#### 4.1.1.2 SpaceMarkers Step2: Interacting Genes

get\_pairwise\_interacting\_genes: This function identifies the regions of influence
and interaction as well as the **genes** associated with these regions.
A non-parametric Kruskal-Wallis test is used to identify statistically
significant genes in any one region of influence without discerning which region
is more significant. A post hoc Dunn’s Test is used for analysis of genes
between regions and can distinguish which of two regions is more significant.
If ‘residual’ mode is selected the user must provide a reconstructed matrix from
the latent feature matrix. The matrix is passed to the ‘reconstruction’ argument
and can be left as NULL for ‘DE’ mode. The ‘data’ parameter is the original
expression matrix. The ‘spPatterns’ argument takes a dataframe with the spatial
coordinates of each cell as well as the patterns. The spatial coordinate columns
must contain the labels ‘x’ and ‘y’ to be recognized by the function.
The output of this are all possible pairs fo interactions from the spatial
patterns.

```
SpaceMarkers <- get_pairwise_interacting_genes(data = counts_matrix,
                                    reconstruction = cogaps_matrix,
                                    optParams = optParams,
                                    spPatterns = spPatterns,
                                    mode ="residual",analysis="overlap")
```

```
## pattern_pairs not provided. Calculating all
##             possible pairs.
```

```
## Using user provided optParams.
```

```
## Calculating genes of interest for Pattern_1 and Pattern_5
```

```
## Warning in matrixTests::row_kruskalwallis(x = testMat, g = region): 1627
## columns dropped due to missing group information
```

NB: When running get\_pairwise\_interacting\_genes some warnings may be generated.
The warnings are due to the nature of the ‘sparse’ data being used.
Comparing two cells from the two patterns with identical information is
redundant as SpaceMarkers is identifying statistically different expression for
interactions exclusive to either of the two patterns and a region that is due
to interaction between the given two patterns. Also, if there are too many
zeros in the genes (rows) of those regions, the columns are dropped as there
is nothing to compare in the Kruskal Wallis test.

```
print(head(SpaceMarkers[[1]]$interacting_genes[[1]]))
```

```
##        Gene Pattern_1 x Pattern_5 KW.obs.tot KW.obs.groups KW.df KW.statistic
## CLU     CLU                vsBoth       3271             3     2     97.35912
## FAH     FAH                vsBoth       3271             3     2     97.74151
## APOE   APOE                vsBoth       3271             3     2    119.70615
## APOC1 APOC1                vsBoth       3271             3     2    500.95643
## CAPG   CAPG                vsBoth       3271             3     2    213.54229
## IFI30 IFI30                vsBoth       3271             3     2    240.37301
##           KW.pvalue      KW.p.adj Dunn.zP1_Int Dunn.zP2_Int Dunn.zP2_P1
## CLU    7.223284e-22  1.680519e-21    -8.847651    -9.207378  -0.9322089
## FAH    5.966246e-22  1.416983e-21    -9.356186    -8.688843   0.3455428
## APOE   1.014240e-26  2.688915e-26    -9.696829   -10.297178  -1.2835579
## APOC1 1.654605e-109 8.982142e-109   -17.929659   -22.001759  -6.1370836
## CAPG   4.264619e-47  1.313964e-46   -11.737779   -14.354975  -3.9558893
## IFI30  6.363026e-53  2.014958e-52   -11.839673   -15.384016  -5.1394508
##       Dunn.pval_1_Int Dunn.pval_2_Int Dunn.pval_2_1 Dunn.pval_1_Int.adj
## CLU      8.938087e-19    3.341878e-20  3.512286e-01        4.357317e-18
## FAH      8.266668e-21    3.661489e-18  7.296863e-01        4.371526e-20
## APOE     3.110139e-22    7.255887e-25  1.992967e-01        1.732792e-21
## APOC1    6.920318e-72   2.770221e-107  8.405016e-10        9.387562e-71
## CAPG     8.160157e-32    9.916065e-47  7.625045e-05        5.304102e-31
## IFI30    2.434015e-32    2.095393e-53  2.755426e-07        1.615771e-31
##       Dunn.pval_2_Int.adj Dunn.pval_2_1.adj SpaceMarkersMetric
## CLU          1.709289e-19      5.345528e-01           6.365687
## FAH          1.757515e-17      1.000000e+00           6.362723
## APOE         4.192290e-24      3.172478e-01           6.299969
## APOC1       4.801717e-106      3.014213e-09           6.028541
## CAPG         7.545883e-46      1.918560e-04           5.446044
## IFI30        1.720428e-52      8.511810e-07           5.187448
```

```
print(head(SpaceMarkers[[1]]$hotspots))
```

```
##      Pattern_1   Pattern_5
## [1,] "Pattern_1" NA
## [2,] "Pattern_1" NA
## [3,] NA          NA
## [4,] NA          "Pattern_5"
## [5,] "Pattern_1" NA
## [6,] "Pattern_1" "Pattern_5"
```

The output is a list of data frames with information about the interacting genes
between patterns from the CoGAPS matrix
(interacting\_genes object).
There is also a data frame with all of the regions of influence for any two of
patterns (the hotspotRegions object).

For the ‘interacting\_genes’ data frames, the first column is the list of genes
and the second column says whether the statistical test were done vsPattern\_1,
vsPattern\_2 or vsBoth. The remaining columns are statistics
for the Kruskal-Wallis test and the post hoc Dunn’s test.The SpaceMarkersMetric
column is a product of sums of the Dunn’s statistics and
is used to rank the genes.

### 4.1.2 DE Mode

As described previously ‘DE’ mode only requires the counts matrix and spatial
patterns and not the reconstructed CoGAPS matrix. It identifies simpler
molecular interactions between regions and still executes the ‘hotspots’ and
‘interacting genes’ steps of SpaceMarkers

```
SpaceMarkers_DE <- get_pairwise_interacting_genes(
    data=counts_matrix,reconstruction=NULL,
    optParams = optParams,
    spPatterns = spPatterns,
    mode="DE",analysis="overlap")
```

```
## pattern_pairs not provided. Calculating all
##             possible pairs.
```

```
## Using user provided optParams.
```

```
## Calculating genes of interest for Pattern_1 and Pattern_5
```

```
## Warning in matrixTests::row_kruskalwallis(x = testMat, g = region): 1627
## columns dropped due to missing group information
```

### 4.1.3 Residual Mode vs DE Mode: Differences

One of the first things to notice is the difference in the number
of genes identified between the two modes.

```
residual_p1_p5<-SpaceMarkers[[1]]$interacting_genes[[1]]
DE_p1_p5<-SpaceMarkers_DE[[1]]$interacting_genes[[1]]
```

```
paste(
    "Residual mode identified",dim(residual_p1_p5)[1],
        "interacting genes,while DE mode identified",dim(DE_p1_p5)[1],
        "interacting genes",collapse = NULL)
```

```
## [1] "Residual mode identified 114 interacting genes,while DE mode identified 114 interacting genes"
```

DE mode produces more genes than residual mode because the matrix of
residuals highlights less significant differences for confounding genes
across the spots.The next analysis will show where the top genes rank in each
mode’s list if they are identified at all. A function was created that will take
the top 20 genes of a reference list of genes and compare it to the entire list
of a second list of genes. The return object is a data frame of the gene, the
name of each list and the ranking of each gene as compared to the reference
list. If there is no gene identified in the second list compared to the
reference it is classified as NA.

```
compare_genes <- function(ref_list, list2,ref_name = "mode1",
                            list2_name = "mode2", sub_slice = NULL){
    ref_rank <- seq(1,length(ref_list),1)
    list2_ref_rank <- which(list2 %in% ref_list)
    list2_ref_genes <- list2[which(list2 %in% ref_list)]
    ref_genes_only <- ref_list[ !ref_list  %in% list2_ref_genes ]
    mode1 <- data.frame("Gene" = ref_list,"Rank" = ref_rank,"mode"= ref_name)
    mode2 <- data.frame("Gene" = c(list2_ref_genes, ref_genes_only),"Rank" = c(
        list2_ref_rank,rep(NA,length(ref_genes_only))),"mode"= list2_name)
    mode1_mode2 <- merge(mode1, mode2, by = "Gene", all = TRUE)
    mode1_mode2 <- mode1_mode2[order(mode1_mode2$Rank.x),]
    mode1_mode2 <- subset(mode1_mode2,select = c("Gene","Rank.x","Rank.y"))
    colnames(mode1_mode2) <- c("Gene",paste0(ref_name,"_Rank"),
                                paste0(list2_name,"_Rank"))
    return(mode1_mode2)
}
```

```
res_to_DE <- compare_genes(head(residual_p1_p5$Gene, n = 20),DE_p1_p5$Gene,
                            ref_name="residual",list2_name="DE")
DE_to_res <- compare_genes(head(DE_p1_p5$Gene, n = 20),residual_p1_p5$Gene,
                            ref_name = "DE",list2_name = "residual")
```

#### 4.1.3.1 Comparing residual mode to DE mode

```
res_to_DE
```

```
##        Gene residual_Rank DE_Rank
## 6       CLU             1      48
## 12      FAH             2      30
## 4      APOE             3      16
## 3     APOC1             4      21
## 5      CAPG             5      32
## 14    IFI30             6      11
## 18    PHGR1             7      67
## 11    CYB5A             8      34
## 1    AKR1A1             9       4
## 8    COL4A1            10       7
## 13 HLA-DRB1            11     113
## 2     AP2S1            12      22
## 10     CTSB            13       1
## 15     IGHE            14      46
## 17   NDUFB2            15      18
## 19     TGM2            16      42
## 7   COL18A1            17      26
## 9      CST1            18       2
## 16   LAPTM5            19      45
## 20   ZNF593            20      54
```

Here we identify the top 20 genes in ‘residual’ mode and their corresponding
ranking in DE mode. HLA-DRB1 is the only gene identified in
residual mode and not in DE mode. The other genes are ranked relatively high
in both residual and DE mode.

#### 4.1.3.2 Comparing DE mode to residual mode

```
DE_to_res
```

```
##       Gene DE_Rank residual_Rank
## 7     CTSB       1            13
## 6     CST1       2            18
## 19     SDS       3            76
## 3   AKR1A1       4             9
## 11     FTL       5            41
## 1     ACTB       6           102
## 5   COL4A1       7            10
## 8     CTSD       8            56
## 15  MAP2K2       9            44
## 13    HCP5      10            57
## 14   IFI30      11             6
## 20   TREM2      12            51
## 12   GCHFR      13            38
## 16 NDUFA10      14            24
## 10    FTH1      15            65
## 4     APOE      16             3
## 18   PRKD3      17           106
## 17  NDUFB2      18            15
## 9   ELOVL5      19            30
## 2    ADPGK      20           114
```

Recall that DE mode looks at the information encoded in the latent feature space
and does not filter out genes based on any confounders between the counts matrix
and latent feature matrix as is done in ‘residual’ mode. Therefore there are
more genes in DE mode not identified at all in residual mode.

There is some agreement with interacting genes between the two methods but there
are also quite a few differences. Therefore, the selected mode can significantly
impact the downstream results and should be taken into consideration based on
the specific biological question being answered and the data available.

## 4.2 Types of Analyses

Another feature of the SpaceMarkers package is the type of analysis that can be
carried out, whether ‘overlap’ or ‘enrichment’ mode. The major difference
between the two is that enrichment mode includes genes even if they did not
pass the post-hoc Dunn’s test. These additional genes were included to enable a
more statistically powerful pathway enrichment analysis and understand to a
better extent the impact of genes involved each pathway.
Changing analysis = ‘enrichment’ in the get\_pairwise\_interacting\_genes function
will enable this.

```
SpaceMarkers_enrich <- get_pairwise_interacting_genes(data = counts_matrix,
                                    reconstruction = cogaps_matrix,
                                    optParams = optParams,
                                    spPatterns = spPatterns,
                                    mode ="residual",analysis="enrichment")
```

```
## pattern_pairs not provided. Calculating all
##             possible pairs.
```

```
## Using user provided optParams.
```

```
## Calculating genes of interest for Pattern_1 and Pattern_5
```

```
## Warning in matrixTests::row_kruskalwallis(x = testMat, g = region): 1627
## columns dropped due to missing group information
```

```
SpaceMarkers_DE_enrich <- get_pairwise_interacting_genes(
    data=counts_matrix,reconstruction=NULL,
    optParams = optParams,
    spPatterns = spPatterns,
    mode="DE",analysis="enrichment")
```

```
## pattern_pairs not provided. Calculating all
##             possible pairs.
```

```
## Using user provided optParams.
```

```
## Calculating genes of interest for Pattern_1 and Pattern_5
```

```
## Warning in matrixTests::row_kruskalwallis(x = testMat, g = region): 1628
## columns dropped due to missing group information
```

```
residual_p1_p5_enrichment<-SpaceMarkers_enrich[[1]]$interacting_genes[[1]]$Gene
DE_p1_p5_enrichment<-SpaceMarkers_DE_enrich[[1]]$interacting_genes[[1]]$Gene
```

### 4.2.1 Residual Mode vs DE Mode: Enrichment

The data frames for the Pattern\_1 x Pattern\_5 will be used to compare the
results of the enrichment analyses

```
enrich_res_to_de<-compare_genes(
    head(DE_p1_p5_enrichment, 20),
    residual_p1_p5_enrichment,
    ref_name="DE_Enrich",list2_name = "res_Enrich")
enrich_res_to_de
```

```
##       Gene DE_Enrich_Rank res_Enrich_Rank
## 7     CTSB              1              14
## 6     CST1              2              18
## 19     SDS              3              76
## 3   AKR1A1              4              10
## 11     FTL              5              41
## 1     ACTB              6             102
## 5   COL4A1              7               9
## 8     CTSD              8              56
## 15  MAP2K2              9              43
## 13    HCP5             10              57
## 14   IFI30             11               6
## 20   TREM2             12              51
## 12   GCHFR             13              38
## 16 NDUFA10             14              24
## 10    FTH1             15              65
## 4     APOE             16               3
## 17  NDUFB2             17              15
## 18   PRKD3             18             106
## 2    ADPGK             19             114
## 9   ELOVL5             20              30
```

The ranks differ alot more here because now genes that were not previously
ranked are assigned a score.

```
overlap_enrich_de<-compare_genes(
    head(DE_p1_p5_enrichment,20),
    DE_p1_p5$Gene,
    ref_name="DE_Enrich",
    list2_name="DE_Overlap")
overlap_enrich_de
```

```
##       Gene DE_Enrich_Rank DE_Overlap_Rank
## 7     CTSB              1               1
## 6     CST1              2               2
## 19     SDS              3               3
## 3   AKR1A1              4               4
## 11     FTL              5               5
## 1     ACTB              6               6
## 5   COL4A1              7               7
## 8     CTSD              8               8
## 15  MAP2K2              9               9
## 13    HCP5             10              10
## 14   IFI30             11              11
## 20   TREM2             12              12
## 12   GCHFR             13              13
## 16 NDUFA10             14              14
## 10    FTH1             15              15
## 4     APOE             16              16
## 17  NDUFB2             17              18
## 18   PRKD3             18              17
## 2    ADPGK             19              20
## 9   ELOVL5             20              19
```

The enrichment and overlap analysis are in great agreement for DE mode.
Typically, you may see more changes among genes lower in the ranking. This is
especially important where genes that do not pass the Dunn’s test for
interactions between any of the other two patterns in the overlap analysis are
now ranked in enrichment analysis. The Pattern\_1 x Pattern\_5 entry for these
genes is labelled as **FALSE**.

Here is an example of the statistics for such genes.

```
tail(SpaceMarkers_DE_enrich[[1]]$interacting_genes[[1]])
```

```
##                  Gene Pattern_1 x Pattern_5 KW.obs.tot KW.obs.groups KW.df
## GPD1             GPD1                 FALSE       3270             3     2
## AC018521.5 AC018521.5                 FALSE       3270             3     2
## AC012236.1 AC012236.1                 FALSE       3270             3     2
## ADAM23         ADAM23                 FALSE       3270             3     2
## HLA-DRB1     HLA-DRB1                 FALSE       3270             3     2
## DUSP18         DUSP18                 FALSE       3270             3     2
##            KW.statistic     KW.pvalue      KW.p.adj Dunn.zP1_Int Dunn.zP2_Int
## GPD1          62.414616  2.797940e-14  5.062939e-14    5.5135315   -0.4264871
## AC018521.5    10.249982  5.946270e-03  7.135524e-03    0.5286137   -1.9644109
## AC012236.1    10.597365  4.998174e-03  6.061616e-03    1.9165150   -0.6370846
## ADAM23         9.115421  1.048604e-02  1.232380e-02    1.1849234   -1.2397657
## HLA-DRB1    1289.077879 1.203082e-280 1.371513e-278    4.7661947  -22.9457070
## DUSP18         6.201769  4.500938e-02  4.840631e-02    2.4897799    1.7254664
##            Dunn.zP2_P1 Dunn.pval_1_Int Dunn.pval_2_Int Dunn.pval_2_1
## GPD1        -7.2499741               1    6.697530e-01  4.168512e-13
## AC018521.5  -3.1390124               1    4.948246e-02  1.695183e-03
## AC012236.1  -3.1411942               1    5.240697e-01  1.682604e-03
## ADAM23      -3.0168266               1    2.150621e-01  2.554359e-03
## HLA-DRB1   -34.9523519               1   1.626324e-116 1.192647e-267
## DUSP18      -0.8369415               1    1.000000e+00  4.026255e-01
##            Dunn.pval_1_Int.adj Dunn.pval_2_Int.adj Dunn.pval_2_1.adj
## GPD1                         1        7.099381e-01      1.027587e-12
## AC018521.5                   1        6.028897e-02      2.385257e-03
## AC012236.1                   1        5.611252e-01      2.378080e-03
## ADAM23                       1        2.391250e-01      3.562658e-03
## HLA-DRB1                     1       3.978240e-115     3.792616e-265
## DUSP18                       1        1.000000e+00      4.369792e-01
##            SpaceMarkersMetric
## GPD1               -0.4052725
## AC018521.5         -0.4123039
## AC012236.1         -0.4737350
## ADAM23             -0.5723509
## HLA-DRB1           -2.0457704
## DUSP18             -2.4049118
```

The rankings of genes between the overlap and enrichment
analysis in residual mode are comparable as well.

```
overlap_enrich_res<-compare_genes(
    head(residual_p1_p5$Gene, 20),
    residual_p1_p5_enrichment,
    ref_name ="res_overlap",list2_name="res_enrich")
overlap_enrich_res
```

```
##        Gene res_overlap_Rank res_enrich_Rank
## 6       CLU                1               2
## 12      FAH                2               1
## 4      APOE                3               3
## 3     APOC1                4               4
## 5      CAPG                5               5
## 14    IFI30                6               6
## 18    PHGR1                7               7
## 11    CYB5A                8               8
## 1    AKR1A1                9              10
## 8    COL4A1               10               9
## 13 HLA-DRB1               11              11
## 2     AP2S1               12              12
## 10     CTSB               13              14
## 15     IGHE               14              13
## 17   NDUFB2               15              15
## 19     TGM2               16              16
## 7   COL18A1               17              19
## 9      CST1               18              18
## 16   LAPTM5               19              17
## 20   ZNF593               20              20
```

# 5 Visualizing SpaceMarkers

## 5.1 Loading Packages

The following libraries are required to make the plots and summarize dataframes

```
library(Matrix)
library(rjson)
library(cowplot)
library(RColorBrewer)
library(grid)
library(readbitmap)
library(dplyr)
library(data.table)
library(viridis)
library(ggplot2)
```

The two main statistics used to help interpret the expression of genes across
the patterns are the KW statistics/pvalue and the Dunn’s test. In this context
the null hypothesis of the KW test is that the expression of a given gene across
all of the spots is equal. The post hoc Dunn’s test identifies how statistically
significant the difference in expression of the given gene is between two
patterns. The Dunn’s test considers the differences between specific patterns
and the KW test considers differences across all of the spots without
considering the specific patterns. Ultimately, we summarize and rank these
effects with the SpaceMarkersMetric.

We will look at the top few genes based on our SpaceMarkersMetric

```
res_enrich <- SpaceMarkers_enrich[[1]]$interacting_genes[[1]]
hotspots <- SpaceMarkers_enrich[[1]]$hotspots
top <- res_enrich %>% arrange(-SpaceMarkersMetric)
print(head(top))
```

```
##        Gene Pattern_1 x Pattern_5 KW.obs.tot KW.obs.groups KW.df KW.statistic
## FAH     FAH                vsBoth       3271             3     2     98.60235
## CLU     CLU                vsBoth       3271             3     2     97.27727
## APOE   APOE                vsBoth       3271             3     2    119.10677
## APOC1 APOC1                vsBoth       3271             3     2    502.18329
## CAPG   CAPG                vsBoth       3271             3     2    214.66083
## IFI30 IFI30                vsBoth       3271             3     2    241.57592
##           KW.pvalue      KW.p.adj Dunn.zP1_Int Dunn.zP2_Int Dunn.zP2_P1
## FAH    3.879455e-22  9.213705e-22    -9.402078    -8.717245   0.3656356
## CLU    7.525051e-22  1.750726e-21    -8.843024    -9.202233  -0.9301390
## APOE   1.368655e-26  3.628526e-26    -9.665874   -10.274118  -1.2904748
## APOC1 8.959506e-110 4.863732e-109   -17.963839   -22.022573  -6.1167554
## CAPG   2.437768e-47  7.510960e-47   -11.785329   -14.385623  -3.9336200
## IFI30  3.487032e-53  1.104227e-52   -11.890364   -15.417249  -5.1158504
##       Dunn.pval_1_Int Dunn.pval_2_Int Dunn.pval_2_1 Dunn.pval_1_Int.adj
## FAH      5.349594e-21    2.850533e-18  7.146370e-01        2.828938e-20
## CLU      9.316247e-19    3.505884e-20  3.522991e-01        4.541670e-18
## APOE     4.210111e-22    9.218379e-25  1.968859e-01        2.345633e-21
## APOC1    3.740190e-72   1.750366e-107  9.549976e-10        5.073649e-71
## CAPG     4.646001e-32    6.370164e-47  8.367602e-05        3.019900e-31
## IFI30    1.328267e-32    1.253310e-53  3.123305e-07        8.817431e-32
##       Dunn.pval_2_Int.adj Dunn.pval_2_1.adj SpaceMarkersMetric
## FAH          1.368256e-17      1.000000e+00           6.374348
## CLU          1.793173e-19      5.388104e-01           6.364144
## APOE         5.326174e-24      3.134102e-01           6.284567
## APOC1       3.033968e-106      3.424819e-09           6.037304
## CAPG         4.847539e-46      2.122514e-04           5.462709
## IFI30        1.029033e-52      9.648230e-07           5.202930
```

## 5.2 Code Setup

The plot\_spatial\_data\_over\_image function allows you to look at the
deconvoluted patterns on the tissue image. We can compare these spatial maps to
the expression of genes identified interacting genes on violin plots.

```
createInteractCol <- function(spHotspots,
                              interaction_cols = c("T.cells","B-cells")){
  col1 <- spHotspots[,interaction_cols[1]]
  col2 <- spHotspots[,interaction_cols[2]]
  one <- col1
  two <- col2
  one[!is.na(col1)] <- "match"
  two[!is.na(col2)] <- "match"
  both_idx <- which(one == two)
  both <- col1
  both[both_idx] <- "interacting"
  one_only <- setdiff(which(!is.na(col1)),unique(c(which(is.na(col1)),
                                                   both_idx)))
  two_only <- setdiff(which(!is.na(col2)),unique(c(which(is.na(col2)),
                                                   both_idx)))
  both[one_only] <- interaction_cols[1]
  both[two_only] <- interaction_cols[2]
  both <- factor(both,levels = c(interaction_cols[1],"interacting",
                                 interaction_cols[2]))
  return(both)
}

#NB: Since we are likely to plot multipe genes, this function assumes an
#already transposed counts matrix. This saves time and memory in the long run
#for larger counts matrices
plotSpatialExpr <- function(data,gene,hotspots,patterns,
                               remove.na = TRUE,
                               title = "Expression (Log)", text_size = 15){
  counts <- data
  interact <- createInteractCol(spHotspots = hotspots,
                                interaction_cols = patterns)
  df <- cbind(counts,hotspots,data.frame("region" = interact))
  if (remove.na){
    df <- df[!is.na(df$region),]
  }
  p <- df %>% ggplot( aes_string(x='region',y=gene,
                                            fill='region')) + geom_violin() +
    scale_fill_viridis(discrete = TRUE,alpha=0.6) +
    geom_jitter(color="black",size=0.4,alpha=0.9) +
    theme(legend.position="none",plot.title = element_text(size=text_size),
            axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
    ggtitle(paste0(gene,": ",title)) + xlab("")
  return(p)
}
```

## 5.3 Get the Spatial Data

Let’s transpose the counts matrix and combine the expression information with
the spatial information.

```
genes <- top$Gene
counts_df <- as.data.frame(as.matrix(
  t(counts_matrix[rownames(counts_matrix) %in% genes,])))
```

## 5.4 Generate Plots

```
spatialMaps <- list()
exprPlots <- list()

for (g in genes){

    spatialMaps[[length(spatialMaps)+1]] <- suppressMessages(
        plot_spatial_data_over_image(visiumDir = data_dir,
                                                         df = cbind(spPatterns, counts_df),feature_col = g,
                                                         resolution="lowres",title = g))
  exprPlots[[length(exprPlots)+1]] <- plotSpatialExpr(
    data = counts_df,gene = g,hotspots = hotspots,
                   patterns = c("Pattern_1","Pattern_5"))
}
```

Below are violin plots and spatial heatmaps to help visualize the expression
of individual genes across different patterns.

### 5.4.1 Pattern\_1

```
plot_spatial_data_over_image(visiumDir = data_dir,
                         df = cbind(spPatterns, counts_df),
                         feature_col = "Pattern_1",
                         resolution="lowres",title = "Pattern_1")
```

![](data:image/png;base64...)

### 5.4.2 Pattern\_5

```
plot_spatial_data_over_image(visiumDir = data_dir,
                         df = cbind(spPatterns, counts_df),
                         feature_col = "Pattern_5",
                         resolution="lowres",title = "Pattern_5")
```

![](data:image/png;base64...)

On the spatial heatmap, Pattern\_5, the invasive carcinoma pattern, is
more prevalent on the bottom left of the tissue image. Where as Pattern\_1,
the immune pattern is prevalent along the diagonal of the tissue image.

### 5.4.3 Top SpaceMarkers

```
plot_grid(plotlist = list(exprPlots[[1]],spatialMaps[[1]]))
```

![](data:image/png;base64...)

APOE is expressed highly across all patterns but is especially strong in the
interacting pattern. This is a good example of a SpaceMarker that is highly
expressed in the interacting region relative to both Pattern\_1 and Pattern\_5.
The second gene also has a similar expression profile.

```
plot_grid(plotlist = list(exprPlots[[3]],spatialMaps[[3]]))
```

![](data:image/png;base64...)

This gene is not as highly expressed in the tissue as the previous genes but
still shows higher and specific expression in the interacting region relative to
either Pattern\_1 and Pattern\_5 hence why it is still highly ranked by the
SpaceMarkersMetric.

### 5.4.4 Negative SpaceMarkersMetric

More negative SpaceMarkersMetric highlights that the expression of a gene in the
interacting region is **lower** relative to either pattern.

```
bottom <- res_enrich %>% arrange(SpaceMarkersMetric)
print(head(bottom))
```

```
##          Gene Pattern_1 x Pattern_5 KW.obs.tot KW.obs.groups KW.df KW.statistic
## ADPGK   ADPGK                 FALSE       3271             3     2     57.01956
## PCDH7   PCDH7                 FALSE       3271             3     2    407.63943
## CREB1   CREB1                 FALSE       3271             3     2     77.66453
## TINF2   TINF2                 FALSE       3271             3     2     50.91034
## HMBOX1 HMBOX1                 FALSE       3271             3     2    306.48990
## MPRIP   MPRIP                 FALSE       3271             3     2     63.83870
##           KW.pvalue     KW.p.adj Dunn.zP1_Int Dunn.zP2_Int Dunn.zP2_P1
## ADPGK  4.152971e-13 7.890644e-13     6.812051     7.010360   0.6169602
## PCDH7  3.035452e-89 1.384166e-88    15.320163    20.050751   6.8281788
## CREB1  1.365719e-17 2.883184e-17     7.594792     8.432348   1.4706430
## TINF2  8.809681e-12 1.646399e-11     6.327617     6.711058   0.8260767
## HMBOX1 2.796175e-67 1.062546e-66    13.215983    17.397960   6.0187536
## MPRIP  1.372782e-14 2.745563e-14     6.673110     7.752150   1.7278785
##        Dunn.pval_1_Int Dunn.pval_2_Int Dunn.pval_2_1 Dunn.pval_1_Int.adj
## ADPGK                1               1  5.372610e-01                   1
## PCDH7                1               1  8.599938e-12                   1
## CREB1                1               1  1.413877e-01                   1
## TINF2                1               1  4.087606e-01                   1
## HMBOX1               1               1  1.757652e-09                   1
## MPRIP                1               1  8.401001e-02                   1
##        Dunn.pval_2_Int.adj Dunn.pval_2_1.adj SpaceMarkersMetric
## ADPGK                    1      7.869738e-01          -5.607476
## PCDH7                    1      3.324785e-11          -5.523161
## CREB1                    1      2.321735e-01          -5.477253
## TINF2                    1      6.102072e-01          -5.441782
## HMBOX1                   1      6.231676e-09          -5.292872
## MPRIP                    1      1.424517e-01          -4.951354
```

```
g <- bottom$Gene[1]
p1 <- plotSpatialExpr(
    data = counts_df,gene = g,hotspots = hotspots,
                   patterns = c("Pattern_1","Pattern_5"))
p2 <- plot_spatial_data_over_image(visiumDir = data_dir,
                         df = cbind(spPatterns, counts_df),
                         feature_col = g,
                         resolution="lowres",title = g)
```

```
## resolution: lowres
```

```
## Version not provided. Trying to infer.
```

```
## probe_set.csv or .parquet not found.Assuming version 1.0.
```

```
plot_grid(plotlist = list(p1,p2))
```

![](data:image/png;base64...)

# 6 Removing Directories

```
unlink(file.path(data_dir), recursive = TRUE)
```

# 7 References

# Appendix

Deshpande, Atul, et al. “Uncovering the spatial landscape of molecular
interactions within the tumor microenvironment through latent spaces.”
Cell Systems 14.4 (2023): 285-301.

“Space Ranger.” Secondary Analysis in R -Software -Spatial Gene Expression -
Official 10x Genomics Support,
support.10xgenomics.com/spatial-gene-expression/software/pipelines/latest/rkit.
Accessed 22 Dec. 2023.

## 1 load10XExpr() Arguments

| Argument | Description |
| --- | --- |
| visiumDir | A string path to the h5 file with expression information |
| h5filename | A string of the name of the h5 file in the directory |

## 2 load10XCoords() Arguments

| Argument | Description |
| --- | --- |
| visiumDir | A path to the location of the the spatial coordinates folder. |
| resolution | String values to look for in the .json object;lowres or highres. |

## 3 get\_spatial\_params\_morans\_i() Arguments

| Argument | Description |
| --- | --- |
| spPatterns | A data frame of spatial coordinates and patterns. |
| visiumDir | A directory with the spatial and expression data for |
| the tissue sample |  |
| spatialDir | A directory with spatial data for the tissue sample |
| pattern | A string of the .json filename with the image parameters |
| sigma | A numeric value specifying the kernel distribution width |
| threshold | A numeric value specifying the outlier threshold for the |
| kernel |  |
| resolution | A string specifying the image resolution to scale |

## 4 get\_pairwise\_interacting\_genes() Arguments

| Argument | Description |
| --- | --- |
| data | An expression matrix of genes and columns being the samples. |
| reconstruction | Latent feature matrix. NULL if ‘DE’ mode is specified |
| optParams | A matrix of sigmaOpts (width) and the thresOpt (outlierthreshold) |
| spPatterns | A data frame that contains of spatial coordinates and patterns. |
| mode | A string of the reference pattern for comparison to other patterns |
| minOverlap | A string specifying either ‘residual’ or ‘DE’ mode. |
| hotspotRegions | A value that specifies the minimum pattern overlap. 50 is the default |
| analysis | A string specifying the type of analysis |

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
## [1] grid      stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] ggplot2_4.0.0      viridis_0.6.5      viridisLite_0.4.2  data.table_1.17.8
##  [5] dplyr_1.1.4        readbitmap_0.1.5   RColorBrewer_1.1-3 cowplot_1.2.0
##  [9] rjson_0.2.23       Matrix_1.7-4       SpaceMarkers_2.0.0 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] deldir_2.0-4           gridExtra_2.3          rlang_1.1.6
##  [4] magrittr_2.0.4         matrixStats_1.5.0      compiler_4.5.1
##  [7] spatstat.geom_3.6-0    png_0.1-8              vctrs_0.6.5
## [10] reshape2_1.4.4         hdf5r_1.3.12           stringr_1.5.2
## [13] pkgconfig_2.0.3        shape_1.4.6.1          fastmap_1.2.0
## [16] magick_2.9.0           backports_1.5.0        labeling_0.4.3
## [19] nanoparquet_0.4.2      rmarkdown_2.30         effsize_0.8.1
## [22] tinytex_0.57           purrr_1.1.0            bit_4.6.0
## [25] xfun_0.53              cachem_1.1.0           jsonlite_2.0.0
## [28] goftest_1.2-3          matrixTests_0.2.3.1    spatstat.utils_3.2-0
## [31] BiocParallel_1.44.0    jpeg_0.1-11            tiff_0.1-12
## [34] broom_1.0.10           parallel_4.5.1         R6_2.6.1
## [37] bslib_0.9.0            stringi_1.8.7          spatstat.data_3.1-9
## [40] spatstat.univar_3.1-4  car_3.1-3              jquerylib_0.1.4
## [43] Rcpp_1.1.0             bookdown_0.45          knitr_1.50
## [46] tensor_1.5.1           mixtools_2.0.0.1       splines_4.5.1
## [49] tidyselect_1.2.1       qvalue_2.42.0          dichromat_2.0-0.1
## [52] abind_1.4-8            yaml_2.3.10            codetools_0.2-20
## [55] spatstat.random_3.4-2  spatstat.explore_3.5-3 lattice_0.22-7
## [58] tibble_3.3.0           plyr_1.8.9             withr_3.0.2
## [61] S7_0.2.0               evaluate_1.0.5         survival_3.8-3
## [64] polyclip_1.10-7        circlize_0.4.16        kernlab_0.9-33
## [67] pillar_1.11.1          BiocManager_1.30.26    carData_3.0-5
## [70] plotly_4.11.0          generics_0.1.4         scales_1.4.0
## [73] glue_1.8.0             lazyeval_0.2.2         tools_4.5.1
## [76] bmp_0.3.1              tidyr_1.3.1            ape_5.8-1
## [79] colorspace_2.1-2       nlme_3.1-168           Formula_1.2-5
## [82] cli_3.6.5              spatstat.sparse_3.1-0  segmented_2.1-4
## [85] gtable_0.3.6           rstatix_0.7.3          sass_0.4.10
## [88] digest_0.6.37          htmlwidgets_1.6.4      farver_2.1.2
## [91] htmltools_0.5.8.1      lifecycle_1.0.4        httr_1.4.7
## [94] GlobalOptions_0.1.2    bit64_4.6.0-1          MASS_7.3-65
```