# Comparative transcriptomic analysis of hybrids and their progenitors

Fabricio Almeida-Silva1, Lucas Prost-Boxoen1 and Yves Van de Peer1

1VIB-UGent Center for Plant Systems Biology, Ghent, Belgium

#### 30 October 2025

# 1 Introduction

The formation of hybrids through the fusion of distinct genomes and
subsequent genome duplication (in cases of allopolyploidy) represents a
significant evolutionary event with complex effects on cellular biology,
particularly gene expression. The impact of such genome mergings and
duplications on transcription remain incompletely understood. To bridge this
gap, we introduce **HybridExpress**, a comprehensive package designed to
facilitate the comparative transcriptomic analysis of hybrids and their
progenitor species. **HybridExpress** is tailored for RNA-Seq data derived
from a ‘hybrid triplet’: the hybrid organism and its two parental species.
This package offers a suite of intuitive functions enabling researchers to
perform differential expression analysis with ease, generate principal
component analysis (PCA) plots to visualize sample grouping,
categorize genes into 12 distinct expression pattern groups
(as in Rapp, Udall, and Wendel ([2009](#ref-rapp2009genomic))), and conduct functional analyses.
Acknowledging the potential variability in cell and transcriptome size
across species and ploidy levels, **HybridExpress** incorporates features for
rigorous normalization of count data. Specifically, it allows for the
integration of spike-in controls directly into the normalization process,
ensuring accurate transcriptome size adjustments when these standards are
present in the RNA-Seq count data (see full methodology in Coate ([2023](#ref-coate2023beyond))).
By offering these capabilities, **HybridExpress** provides a robust
tool set for unraveling the intricate effects of genome doubling and
merging on gene expression, paving the way for novel insights into the
cellular biology of hybrid organisms.

# 2 Installation

*[HybridExpress](https://github.com/HybridExpress)* can be installed from Bioconductor
with the following code:

```
if(!requireNamespace('BiocManager', quietly = TRUE))
  install.packages('BiocManager')

BiocManager::install("HybridExpress")
```

```
# Load package after installation
library(HybridExpress)

set.seed(123) # for reproducibility
```

# 3 Data description

For this vignette, we will use an example data set that comprises
(unpublished) gene expression data (in counts) for *Chlamydomonas reinhardtii*.
In our lab, we crossed a diploid line of *C. reinhardtii* (hereafter “P1”)
with a haploid line (hereafter “P2”), thus generating a triploid line through
the merging of the two parental genomes. The count matrix and sample
metadata are stored in `SummarizedExperiment` objects, which is the standard
Bioconductor data structure required by
*[HybridExpress](https://github.com/HybridExpress)*. For instructions on how to create
a `SummarizedExperiment` object, check the FAQ section of this vignette.

Let’s load the example data and take a quick look at it:

```
library(SummarizedExperiment)

# Load data
data(se_chlamy)

# Inspect the `SummarizedExperiment` object
se_chlamy
#> class: SummarizedExperiment
#> dim: 13058 18
#> metadata(0):
#> assays(1): counts
#> rownames(13058): Cre01.g000050 Cre01.g000150 ... ERCC-00170 ERCC-00171
#> rowData names(0):
#> colnames(18): S1 S2 ... S17 S18
#> colData names(2): Ploidy Generation

## Take a look at the colData and count matrix
colData(se_chlamy)
#> DataFrame with 18 rows and 2 columns
#>          Ploidy Generation
#>     <character>   <factor>
#> S1      diploid         P1
#> S2      diploid         P1
#> S3      diploid         P1
#> S4      diploid         P1
#> S5      diploid         P1
#> ...         ...        ...
#> S14    triploid         F1
#> S15    triploid         F1
#> S16    triploid         F1
#> S17    triploid         F1
#> S18    triploid         F1
assay(se_chlamy) |> head()
#>                 S1  S2   S3   S4  S5   S6   S7   S8   S9 S10 S11  S12  S13  S14
#> Cre01.g000050   31  21   26   33  19   48   17    6   13   6  10    7   31   22
#> Cre01.g000150   50  29   35   99  11   58   51   46   41  33  28   14   53   25
#> Cre01.g000200   36  26   24   29  17   36   14   15   12   8  14    7   25   24
#> Cre01.g000250  440 272  394  332 283  585  272  274  255 160 225  235  405  391
#> Cre01.g000300 1242 839 1216 1251 811 1785 1341 1306 1122 877 844 1082 1704 1739
#> Cre01.g000350  412 264  294  336 252  478  233  221  195 155 190  201  299  272
#>                S15  S16  S17  S18
#> Cre01.g000050   29   22   21   16
#> Cre01.g000150   37   17   24   21
#> Cre01.g000200   24   26   18   21
#> Cre01.g000250  358  339  340  332
#> Cre01.g000300 1524 1720 1517 1243
#> Cre01.g000350  276  324  246  275

table(se_chlamy$Ploidy, se_chlamy$Generation)
#>
#>            F1 P1 P2
#>   diploid   0  6  0
#>   haploid   0  0  6
#>   triploid  6  0  0
```

As you can see, the count matrix contains 13058 genes
and 18 samples, with 6 replicates for parent 1
(P1, diploid), 6 replicates for parent 2 (P2, haploid), and 6 replicates
for the progeny (F1, triploid).

# 4 Adding midparent expression values

First of all, you’d want to add in your count matrix *in silico* samples
that contain the expression values of the midparent. This can be done
with the function `add_midparent_expression()`, which takes a random
sample pair (one sample from each parent, sampling without replacement)
and calculates the midparent expression value in one of three ways:

1. **Mean (default):** get the mean expression of the two samples.
2. **Sum:** get the sum of the two samples.
3. **Weighted mean:** get the weighted mean of the two samples by multiplying
   the expression value of each parent by a weight. Typically, this can be used
   if the two parents have different ploidy levels, and the weights would
   correspond to the ploidy level of each parent.

For this function, besides specifying the method to obtain the midparent
expression values (i.e., “mean”, “sum”, or “weightedmean”), users must
also specify the name of the column in `colData` that contains information
about the generations (default: *“Generation”*), as well as the levels
corresponding to each parent (default: *“P1”* and *“P2”* for parents 1 and 2,
respectively).

```
# Add midparent expression using the mean of the counts
se <- add_midparent_expression(se_chlamy)
head(assay(se))
#>                 S1  S2   S3   S4  S5   S6   S7   S8   S9 S10 S11  S12  S13  S14
#> Cre01.g000050   31  21   26   33  19   48   17    6   13   6  10    7   31   22
#> Cre01.g000150   50  29   35   99  11   58   51   46   41  33  28   14   53   25
#> Cre01.g000200   36  26   24   29  17   36   14   15   12   8  14    7   25   24
#> Cre01.g000250  440 272  394  332 283  585  272  274  255 160 225  235  405  391
#> Cre01.g000300 1242 839 1216 1251 811 1785 1341 1306 1122 877 844 1082 1704 1739
#> Cre01.g000350  412 264  294  336 252  478  233  221  195 155 190  201  299  272
#>                S15  S16  S17  S18 midparent1 midparent2 midparent3 midparent4
#> Cre01.g000050   29   22   21   16         18         27         14         20
#> Cre01.g000150   37   17   24   21         32         46         38         56
#> Cre01.g000200   24   26   18   21         19         22         20         18
#> Cre01.g000250  358  339  340  332        310        372        273        284
#> Cre01.g000300 1524 1720 1517 1243       1030       1331       1072       1166
#> Cre01.g000350  276  324  246  275        242        316        242        268
#>               midparent5 midparent6
#> Cre01.g000050         18         22
#> Cre01.g000150         31         46
#> Cre01.g000200         16         24
#> Cre01.g000250        278        348
#> Cre01.g000300       1076       1182
#> Cre01.g000350        242        304

# Alternative 1: using the sum of the counts
add_midparent_expression(se_chlamy, method = "sum") |>
    assay() |>
    head()
#>                 S1  S2   S3   S4  S5   S6   S7   S8   S9 S10 S11  S12  S13  S14
#> Cre01.g000050   31  21   26   33  19   48   17    6   13   6  10    7   31   22
#> Cre01.g000150   50  29   35   99  11   58   51   46   41  33  28   14   53   25
#> Cre01.g000200   36  26   24   29  17   36   14   15   12   8  14    7   25   24
#> Cre01.g000250  440 272  394  332 283  585  272  274  255 160 225  235  405  391
#> Cre01.g000300 1242 839 1216 1251 811 1785 1341 1306 1122 877 844 1082 1704 1739
#> Cre01.g000350  412 264  294  336 252  478  233  221  195 155 190  201  299  272
#>                S15  S16  S17  S18 midparent1 midparent2 midparent3 midparent4
#> Cre01.g000050   29   22   21   16         43         26         58         46
#> Cre01.g000150   37   17   24   21         86         25         86        140
#> Cre01.g000200   24   26   18   21         38         24         50         41
#> Cre01.g000250  358  339  340  332        666        518        810        587
#> Cre01.g000300 1524 1720 1517 1243       2557       1893       2629       2373
#> Cre01.g000350  276  324  246  275        527        453        668        531
#>               midparent5 midparent6
#> Cre01.g000050         37         27
#> Cre01.g000150         96         62
#> Cre01.g000200         51         34
#> Cre01.g000250        714        432
#> Cre01.g000300       2548       1716
#> Cre01.g000350        633        419

# Alternative 2: using the weighted mean of the counts (weights = ploidy)
w <- c(2, 1) # P1 = diploid; P2 = haploid
add_midparent_expression(se_chlamy, method = "weightedmean", weights = w) |>
    assay() |>
    head()
#>                 S1  S2   S3   S4  S5   S6   S7   S8   S9 S10 S11  S12  S13  S14
#> Cre01.g000050   31  21   26   33  19   48   17    6   13   6  10    7   31   22
#> Cre01.g000150   50  29   35   99  11   58   51   46   41  33  28   14   53   25
#> Cre01.g000200   36  26   24   29  17   36   14   15   12   8  14    7   25   24
#> Cre01.g000250  440 272  394  332 283  585  272  274  255 160 225  235  405  391
#> Cre01.g000300 1242 839 1216 1251 811 1785 1341 1306 1122 877 844 1082 1704 1739
#> Cre01.g000350  412 264  294  336 252  478  233  221  195 155 190  201  299  272
#>                S15  S16  S17  S18 midparent1 midparent2 midparent3 midparent4
#> Cre01.g000050   29   22   21   16         25         29         39         22
#> Cre01.g000150   37   17   24   21         27         30         29         16
#> Cre01.g000200   24   26   18   21         27         32         33         21
#> Cre01.g000250  358  339  340  332        181        232        270        210
#> Cre01.g000300 1524 1720 1517 1243       1453       1576       1753       1532
#> Cre01.g000350  276  324  246  275        166        202        223        165
#>               midparent5 midparent6
#> Cre01.g000050         26         17
#> Cre01.g000150         48         15
#> Cre01.g000200         29         17
#> Cre01.g000250        202        148
#> Cre01.g000300       1705       1125
#> Cre01.g000350        186        136
```

We will proceed our analyses with the midparent expression values obtained
from the mean of the counts, stored in the `se` object.

# 5 Normalizing count data

To normalize count data, the function `add_size_factors()` calculates
size factors (used by *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)*
for normalization) and adds them as an extra column in the colData slot
of your `SummarizedExperiment` object. Such size factors are calculated using
one of two methods:

1. By library size (default) using the ‘median of
   ratios’ method implemented in *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)*.
2. By cell size/biomass using spike-in controls (if available). If spike-in
   controls are present in the count matrix, you can use them
   for normalization by setting `spikein = TRUE` and specifying the
   pattern used to indicate rows that contain spike-ins (usually they start
   with *ERCC*)111 **Note:** if you use spike-in normalization, the
   function `add_size_factors()` automatically removes rows containing
   spike-in counts from the `SummarizedExperiment` object after normalization.
   However, if you have counts for spike-in controls in your count matrix,
   but do not want to use spike-in normalization, you should remove them
   before creating the `SummarizedExperiment` object.. Normalization with spike-in controls is
   particularly useful if the amount of mRNA per cell is not equal
   between generations (due to, for instance, different ploidy levels, which
   in turn can lead to different cell sizes and/or biomass).

In our example data set, spike-in controls are available
in the last rows of the count matrix. Let’s take a look at them.

```
# Show last rows of the count matrix
assay(se) |>
    tail()
#>              S1   S2   S3   S4   S5   S6   S7   S8   S9  S10  S11  S12  S13
#> ERCC-00163   74   75   55   77   51   84  132  127   93  108   79  102   66
#> ERCC-00164    0    4    0    1    4    1    6    4    1    4    3    2    5
#> ERCC-00165  147  139   87  165  118  179  236  246  139  218  176  145  118
#> ERCC-00168    2    5    2    2    2    6    5    1    1    5    0    3    4
#> ERCC-00170   97   95   73  101   70  118  186  148  110  167  110  103   72
#> ERCC-00171 4644 4959 3554 5357 4170 5946 8207 7915 4992 7843 6455 5884 4537
#>             S14  S15  S16  S17  S18 midparent1 midparent2 midparent3 midparent4
#> ERCC-00163   67   62   80   88   47         67         96        101         90
#> ERCC-00164    4    3    5    4    2          2          2          4          2
#> ERCC-00165  143  115  185  192  136        132        198        192        155
#> ERCC-00168    6    2   11    5    2          1          6          3          2
#> ERCC-00170   99   64  121  103   84         92        142        122        102
#> ERCC-00171 5665 4598 6168 5771 4747       5004       6894       6437       5620
#>            midparent5 midparent6
#> ERCC-00163         92         84
#> ERCC-00164          5          0
#> ERCC-00165        177        143
#> ERCC-00168          4          2
#> ERCC-00170        128        104
#> ERCC-00171       6188       4818
```

As you can see, rows with spike-in counts start with “ERCC”. Let’s add
size factors to our `SummarizedExperiment` object using
spike-in controls.

```
# Take a look at the original colData
colData(se)
#> DataFrame with 24 rows and 2 columns
#>                 Ploidy Generation
#>            <character>   <factor>
#> S1             diploid         P1
#> S2             diploid         P1
#> S3             diploid         P1
#> S4             diploid         P1
#> S5             diploid         P1
#> ...                ...        ...
#> midparent2          NA  midparent
#> midparent3          NA  midparent
#> midparent4          NA  midparent
#> midparent5          NA  midparent
#> midparent6          NA  midparent

# Add size factors estimated from spike-in controls
se <- add_size_factors(se, spikein = TRUE, spikein_pattern = "ERCC")
#> converting counts to integer mode

# Take a look at the new colData
colData(se)
#> DataFrame with 24 rows and 3 columns
#>                 Ploidy Generation sizeFactor
#>            <character>   <factor>  <numeric>
#> S1             diploid         P1   0.856262
#> S2             diploid         P1   0.938417
#> S3             diploid         P1   0.648653
#> S4             diploid         P1   0.969369
#> S5             diploid         P1   0.718761
#> ...                ...        ...        ...
#> midparent2          NA  midparent   1.278078
#> midparent3          NA  midparent   1.201072
#> midparent4          NA  midparent   1.000892
#> midparent5          NA  midparent   1.186773
#> midparent6          NA  midparent   0.871889
```

# 6 Exploratory data analyses

Next, you can perform exploratory analyses of sample clustering to verify if
samples group as expected. With *[HybridExpress](https://github.com/HybridExpress)*,
this can be performed using two functions:

1. `pca_plot()`: creates principal component analysis (PCA) plots, with colors
   and shapes (optional) mapped to levels of `colData` variables;
2. `plot_samplecor()`: plots a heatmap of hierarchically clustered pairwise
   sample correlations.

Let’s start with the PCA plot:

```
# For colData rows with missing values (midparent samples), add "midparent"
se$Ploidy[is.na(se$Ploidy)] <- "midparent"
se$Generation[is.na(se$Generation)] <- "midparent"

# Create PCA plot
pca_plot(se, color_by = "Generation", shape_by = "Ploidy", add_mean = TRUE)
```

![](data:image/png;base64...)

In the plot above, each data point corresponds to a sample, and colors
and shapes are mapped to levels of the variables specified in the
arguments `color_by` and `shape_by`, respectively. Besides,
by specifying `add_mean = TRUE`,
we added a diamond shape indicating the mean PC coordinates based on the variable
in `color_by` (here, *“Generation”*).

Now, let’s plot the heatmap of sample correlations:

```
# Plot a heatmap of sample correlations
plot_samplecor(se, coldata_cols = c("Generation", "Ploidy"))
```

![](data:image/png;base64...)

We can see that samples group well together both in the PCA plot and in
the correlation heatmap.

Of note, both `pca_plot()` and `plot_samplecor()`
use only the top 500 genes with the highest variances to create the plot.
This is because genes with low variances (i.e., genes that do not vary much
across samples) are uninformative and typically only add noise. You can change
this number (to use more or less genes) in the `ntop` argument of
both functions.

# 7 Identifying differentially expressed genes between hybrids and their parents

To compare gene expression levels of hybrids to their progenitor species, you
can use the function `get_deg_list()`. This function performs
differential expression analyses using *[DESeq2](https://bioconductor.org/packages/3.22/DESeq2)*
and returns a list of data frames with gene-wise test statistics
for the following contrasts:

1. `P2_vs_P1`: parent 2 (numerator) versus parent 1 (denominator).
2. `F1_vs_P1`: hybrid (numerator) versus parent 1 (denominator).
3. `F1_vs_P2`: hybrid (numerator) versus parent 2 (denominator).
4. `F1_vs_midparent`: hybrid (numerator) vs midparent (denominator).

The size factors estimated with `add_size_factors()` are used for normalization
before differential expression testing. Let’s use `get_deg_list()` to get
differentially expressed genes (DEGs) for each contrast.

```
# Get a list of differentially expressed genes for each contrast
deg_list <- get_deg_list(se)
#> using pre-existing size factors
#> estimating dispersions
#> gene-wise dispersion estimates
#> mean-dispersion relationship
#> final dispersion estimates
#> fitting model and testing

# Inspecting the output
## Getting contrast names
names(deg_list)
#> [1] "P2_vs_P1"        "F1_vs_P1"        "F1_vs_P2"        "F1_vs_midparent"

## Accessing gene-wise test statistics for contrast `F1_vs_P1`
head(deg_list$F1_vs_P1)
#>                baseMean log2FoldChange     lfcSE      stat       pvalue
#> Cre01.g000450  39.59273     -1.1632346 0.2165407 -5.371898 7.791211e-08
#> Cre01.g000750 103.10296      0.8807307 0.1842856  4.779162 1.760270e-06
#> Cre01.g000900 471.44084      0.6807925 0.1980730  3.437079 5.880239e-04
#> Cre01.g001000  10.34574     -6.6304915 0.9631384 -6.884256 5.809030e-12
#> Cre01.g001100 453.87151     -0.6457115 0.1506903 -4.285025 1.827187e-05
#> Cre01.g001200 159.03643      0.7231060 0.1946090  3.715685 2.026536e-04
#>                       padj
#> Cre01.g000450 4.653531e-07
#> Cre01.g000750 8.329159e-06
#> Cre01.g000900 1.707442e-03
#> Cre01.g001000 6.659069e-11
#> Cre01.g001100 7.200448e-05
#> Cre01.g001200 6.453951e-04

## Counting the number of DEGs per contrast
sapply(deg_list, nrow)
#>        P2_vs_P1        F1_vs_P1        F1_vs_P2 F1_vs_midparent
#>            8698            5476            7350            4348
```

To summarize the frequencies of up- and down-regulated genes per contrast
in a single data frame, use the function `get_deg_counts()`.

```
# Get a data frame with DEG frequencies for each contrast
deg_counts <- get_deg_counts(deg_list)

deg_counts
#>          contrast   up down total perc_up perc_down perc_total
#> 1        P2_vs_P1  828 7870  8698     6.4      60.7       67.1
#> 2        F1_vs_P1 1471 4005  5476    11.3      30.9       42.2
#> 3        F1_vs_P2 6487  863  7350    50.0       6.7       56.7
#> 4 F1_vs_midparent 2620 1728  4348    20.2      13.3       33.5
```

It is important to note that the columns `perc_up`, `perc_down`,
and `perc_total` show the percentages of up-regulated, down-regulated, and
all differentially expressed genes relative to the total number of genes
in the count matrix. The total number of genes in the count matrix
is stored in the `ngenes` attribute of the list returned by `get_deg_list()`:

```
attributes(deg_list)$ngenes
#> [1] 12966
```

However, since the count matrix usually does not include all genes in the
genome (e.g., lowly expressed genes and genes with low variance are usually
filtered out), the percentages in `perc_up`, `perc_down`, and `perc_total`
are not relative to the total number of genes in the genome. To use the
total number of genes in the genome as the reference, we need to update
the `ngenes` attribute of the DEG list with the appropriate number
as follows:

```
# Total number of genes in the C. reinhardtii genome (v6.1): 16883
attributes(deg_list)$ngenes <- 16883
```

Then, we can run `get_deg_counts()` again to get the percentages relative
to the total number of genes in the genome.

```
deg_counts <- get_deg_counts(deg_list)
deg_counts
#>          contrast   up down total perc_up perc_down perc_total
#> 1        P2_vs_P1  828 7870  8698     4.9      46.6       51.5
#> 2        F1_vs_P1 1471 4005  5476     8.7      23.7       32.4
#> 3        F1_vs_P2 6487  863  7350    38.4       5.1       43.5
#> 4 F1_vs_midparent 2620 1728  4348    15.5      10.2       25.8
```

Finally, we can summarize everything in a single publication-ready figure
using the plot `plot_expression_triangle()`, which shows the
‘experimental trio’ (i.e., hybrid and its progenitors) as a triangle,
with the frequencies of DEGs indicated.

```
# Plot expression triangle
plot_expression_triangle(deg_counts)
```

![](data:image/png;base64...)

This figure is commonly used in publications, and it was inspired by
Rapp, Udall, and Wendel ([2009](#ref-rapp2009genomic)). For each edge (line), numbers in the middle (in bold)
indicate the frequency of all DEGs, and numbers at the ends (close to boxes)
indicate the frequency of up-regulated genes in each generation. For instance,
the figure above shows that, for the contrast between F1 and P1, there
are 5476 DEGs (32.4% of the
genome), of which 1471 are up-regulated in F1,
and 4005 are up-regulated in P1.

For a custom figure, you can also specify your own color palette and
labels for the boxes. For example:

```
# Create vectors (length 4) of colors and box labels
pal <- c("springgreen4", "darkorange3", "mediumpurple4", "mediumpurple3")
labels <- c("Parent 1\n(2n)", "Parent 2\n(n)", "Progeny\n(3n)", "Midparent")

plot_expression_triangle(deg_counts, palette = pal, box_labels = labels)
```

![](data:image/png;base64...)

# 8 Expression-based gene classification

After identifying DEGs for different contrasts, you’d typically want
to classify your genes into expression partitions based on their expression
patterns. This can be performed with the function `expression_partitioning()`,
which classifies genes into one of the 12 **categories** as in Rapp, Udall, and Wendel ([2009](#ref-rapp2009genomic)),
and into 5 major **classes** that summarize the 12 categories. The five classes
are:

1. **Transgressive up-regulation (UP):** gene is up-regulated in the hybrid
   as compared to both parents.
2. **Transgressive down-regulation (DOWN):** gene is down-regulated in the
   hybrid as compared to both parents.
3. **Additivity (ADD):** gene expression in the hybrid is the mean of
   both parents (additive effect).
4. **Expression-level dominance toward parent 1 (ELD\_P1):** gene expression
   in the hybrid is the same as in parent 1, but different from parent 2.
5. **Expression-level dominance toward parent 2 (ELD\_P2):** gene expression
   in the hybrid is the same as in parent 2, but different from parent 1.

```
# Classify genes in expression partitions
exp_partitions <- expression_partitioning(deg_list)

# Inspect the output
head(exp_partitions)
#>            Gene Category Class lFC_F1_vs_P1 lFC_F1_vs_P2
#> 1 Cre01.g003650        1   ADD    0.7838125   -1.0484464
#> 2 Cre01.g005150        1   ADD    1.0473362   -0.5041601
#> 3 Cre01.g008600        1   ADD    5.0518384   -1.4840829
#> 4 Cre01.g013500        1   ADD    2.1099265   -1.5329846
#> 5 Cre01.g034850        1   ADD    1.5838851   -0.7611868
#> 6 Cre01.g800005        1   ADD    1.4928449   -0.9315119

# Count number of genes per category
table(exp_partitions$Category)
#>
#>    1    2    3    4    5    6    7    8    9   10   11   12
#>   70  262   66 3283   77  287  214  651  280  147 1760 1666

# Count number of genes per class
table(exp_partitions$Class)
#>
#>     UP   DOWN    ADD ELD_P1 ELD_P2
#>   1015    427   1736   3563   2022
```

To visualize the expression partitions as a scatter plot of expression
divergences, you can use the function `plot_expression_partitions()`.

```
# Plot partitions as a scatter plot of divergences
plot_expression_partitions(exp_partitions, group_by = "Category")
```

![](data:image/png;base64...)

By default, genes are grouped by `Category`. However, you can also
group genes by `Class` as follows:

```
# Group by `Class`
plot_expression_partitions(exp_partitions, group_by = "Class")
```

![](data:image/png;base64...)

You can also visualize the frequencies of genes in each partition with
the function `plot_partition_frequencies()`.

```
# Visualize frequency of genes in each partition
## By `Category` (default)
plot_partition_frequencies(exp_partitions)
```

![](data:image/png;base64...)

```
## By `Class`
plot_partition_frequencies(exp_partitions, group_by = "Class")
```

![](data:image/png;base64...)

# 9 Overrepresentation analysis of functional terms

Lastly, you’d want to explore whether gene sets of interest (e.g., up-regulated
genes in each contrast) are enriched in any particular GO term, pathway,
protein domain, etc. For that, you will use the function `ora()`,
which performs overrepresentation analysis for a gene set given a data frame
of functional annotation for each gene.

Here, we will use an example data set with GO annotation for *C. reinhardtii*
genes. This data set illustrates how the annotation data frame must be
shaped: gene ID in the first column, and functional annotations in other
columns.

```
# Load example functional annotation (GO terms)
data(go_chlamy)

head(go_chlamy)
#>            gene                                           GO
#> 1 Cre01.g000050                                         <NA>
#> 2 Cre01.g000100                                         <NA>
#> 3 Cre01.g000150                                     membrane
#> 4 Cre01.g000150                          metal ion transport
#> 5 Cre01.g000150 metal ion transmembrane transporter activity
#> 6 Cre01.g000150                      transmembrane transport
```

To demonstrate the usage of `ora()`, let’s check if we can find enrichment
for any GO term among genes assigned to class “ADD”.

```
# Get a vector of genes in class "ADD"
genes_add <- exp_partitions$Gene[exp_partitions$Class == "ADD"]
head(genes_add)
#> [1] "Cre01.g003650" "Cre01.g005150" "Cre01.g008600" "Cre01.g013500"
#> [5] "Cre01.g034850" "Cre01.g800005"

# Get background genes - genes in the count matrix
bg <- rownames(se)

# Perform overrepresentation analysis
ora_add <- ora(genes_add, go_chlamy, background = bg)

# Inspect results
head(ora_add)
#>                                                   term genes all         pval
#> 25                                     DNA replication    17  37 1.471956e-06
#> 68                      aminoacyl-tRNA ligase activity    14  33 3.811521e-05
#> 123                                          cytoplasm    43 151 7.379762e-07
#> 138                             endopeptidase activity     6  10 7.400151e-04
#> 139                              endoplasmic reticulum     9  17 1.193854e-04
#> 142 eukaryotic translation initiation factor 3 complex     7   9 2.144087e-05
#>             padj category
#> 25  1.227611e-04       GO
#> 68  1.766005e-03       GO
#> 123 7.693402e-05       GO
#> 138 2.204188e-02       GO
#> 139 4.978369e-03       GO
#> 142 1.277263e-03       GO
```

## 9.1 Example 1: overrepresentation analyses for all expression-based classes

In the example above, we performed an overrepresentation analysis in
genes associated with class “ADD”. What if we wanted to do the same for *all*
classes?

In that case, you could run `ora()` multiple times by looping over each class.
In details, you would do the following:

1. For each class, create a vector of genes associated with it;
2. Run `ora()` to get a data frame with ORA results.

Below you can find an example on how to do it using `lapply()`. Results
for each class will be stored in elements of a list object.

```
# Create a list of genes in each class
genes_by_class <- split(exp_partitions$Gene, exp_partitions$Class)

names(genes_by_class)
#> [1] "UP"     "DOWN"   "ADD"    "ELD_P1" "ELD_P2"
head(genes_by_class$UP)
#> [1] "Cre01.g029250" "Cre01.g034380" "Cre01.g036700" "Cre01.g049400"
#> [5] "Cre02.g085500" "Cre02.g087150"

# Iterate through each class and perform ORA
ora_classes <- lapply(
    genes_by_class, # list through which we will iterate
    ora, # function we will apply to each element of the list
    annotation = go_chlamy, background = bg # additional arguments to function
)

# Inspect output
ora_classes
#> $UP
#>                                    term genes all         pval         padj
#> 10              ATP hydrolysis activity    21 119 3.380614e-04 0.0469905310
#> 133                      dynein complex     8  13 1.237752e-06 0.0005161427
#> 150 flavin adenine dinucleotide binding    11  42 2.857201e-04 0.0469905310
#>     category
#> 10        GO
#> 133       GO
#> 150       GO
#>
#> $DOWN
#>                                  term genes all         pval         padj
#> 249           oxidoreductase activity    21 274 2.931239e-04 2.444654e-02
#> 278                    photosynthesis    13  58 3.656759e-08 7.624343e-06
#> 279  photosynthesis, light harvesting    18  24 1.638332e-22 6.831844e-20
#> 283                     photosystem I     5  15 8.644389e-05 9.011776e-03
#> 381 tetrapyrrole biosynthetic process     5   8 1.952599e-06 2.714112e-04
#>     category
#> 249       GO
#> 278       GO
#> 279       GO
#> 283       GO
#> 381       GO
#>
#> $ADD
#>                                                                                      term
#> 25                                                                        DNA replication
#> 68                                                         aminoacyl-tRNA ligase activity
#> 123                                                                             cytoplasm
#> 138                                                                endopeptidase activity
#> 139                                                                 endoplasmic reticulum
#> 142                                    eukaryotic translation initiation factor 3 complex
#> 181                                                       intracellular protein transport
#> 235                                                                          nuclear pore
#> 256 oxidoreductase activity, acting on the CH-OH group of donors, NAD or NADP as acceptor
#> 291                                                                     prefoldin complex
#> 294                                                               proteasome core complex
#> 300                                                                       protein folding
#> 301                                                                 protein glycosylation
#> 311                                                                     protein refolding
#> 395                                                translation initiation factor activity
#> 410                                                              unfolded protein binding
#> 414                                                            vesicle-mediated transport
#>     genes all         pval         padj category
#> 25     17  37 1.471956e-06 1.227611e-04       GO
#> 68     14  33 3.811521e-05 1.766005e-03       GO
#> 123    43 151 7.379762e-07 7.693402e-05       GO
#> 138     6  10 7.400151e-04 2.204188e-02       GO
#> 139     9  17 1.193854e-04 4.978369e-03       GO
#> 142     7   9 2.144087e-05 1.277263e-03       GO
#> 181    25  73 4.442015e-06 3.087201e-04       GO
#> 235     6   9 3.339022e-04 1.160310e-02       GO
#> 256    10  27 1.739601e-03 4.533836e-02       GO
#> 291     4   4 3.203862e-04 1.160310e-02       GO
#> 294     9  15 3.165895e-05 1.650223e-03       GO
#> 300    29  81 2.663812e-07 3.702698e-05       GO
#> 301     6  10 7.400151e-04 2.204188e-02       GO
#> 311    10  10 1.809949e-09 7.547489e-07       GO
#> 395     9  21 8.722652e-04 2.424897e-02       GO
#> 410    19  38 6.478683e-08 1.350805e-05       GO
#> 414    13  41 1.955735e-03 4.797302e-02       GO
#>
#> $ELD_P1
#>                term genes all         pval        padj category
#> 79          binding    88 208 2.494608e-06 0.001040251       GO
#> 247         nucleus    77 193 1.141172e-04 0.023793431       GO
#> 335 rRNA processing    15  24 3.464517e-04 0.048156786       GO
#>
#> $ELD_P2
#>                                                                term genes all
#> 75                             aspartic-type endopeptidase activity     6   8
#> 186                                                iron ion binding    30  93
#> 249                                         oxidoreductase activity    71 274
#> 278                                                  photosynthesis    26  58
#> 285                                                  photosystem II    17  32
#> 328 proton-transporting two-sector ATPase complex, catalytic domain     6   8
#>             pval         padj category
#> 75  3.007465e-04 2.090188e-02       GO
#> 186 4.577693e-05 4.772245e-03       GO
#> 249 6.069186e-06 8.436168e-04       GO
#> 278 1.191954e-07 4.970448e-05       GO
#> 285 9.602908e-07 2.002206e-04       GO
#> 328 3.007465e-04 2.090188e-02       GO
```

To do the same for each expression-based category (not class), you’d need
to replace `Class` with `Category` in the `split()` function (see example
above).

## 9.2 Example 2: overrepresentation analyses for differentially expressed genes

The same you can use `lapply()` to loop through each expression class,
you can also loop through each contrast in the list returned
by `get_deg_list()`, and perform ORA for up- and down-regulated genes.
Below you can find an example:

```
# Get up-regulated genes for each contrast
up_genes <- lapply(deg_list, function(x) rownames(x[x$log2FoldChange > 0, ]))
names(up_genes)
#> [1] "P2_vs_P1"        "F1_vs_P1"        "F1_vs_P2"        "F1_vs_midparent"
head(up_genes$F1_vs_P1)
#> [1] "Cre01.g000750" "Cre01.g000900" "Cre01.g001200" "Cre01.g002750"
#> [5] "Cre01.g003524" "Cre01.g003650"

# Perform ORA
ora_up <- lapply(
    up_genes,
    ora,
    annotation = go_chlamy, background = bg
)

ora_up
#> $P2_vs_P1
#> [1] term     genes    all      pval     padj     category
#> <0 rows> (or 0-length row.names)
#>
#> $F1_vs_P1
#>               term genes all         pval        padj category
#> 133 dynein complex     8  13 2.049704e-05 0.008547264       GO
#>
#> $F1_vs_P2
#>                                              term genes all         pval
#> 24                                     DNA repair    56  83 9.520576e-04
#> 38                                    GTP binding    72 111 1.095054e-03
#> 51                                    RNA binding   101 157 1.948736e-04
#> 79                                        binding   138 208 1.214715e-06
#> 185                                 ion transport    33  45 1.225270e-03
#> 225                     microtubule-based process    10  10 9.792020e-04
#> 247                                       nucleus   125 193 2.252487e-05
#> 310                        protein polymerization    10  10 9.792020e-04
#> 311                             protein refolding    10  10 9.792020e-04
#> 314 protein serine/threonine phosphatase activity    20  24 7.724253e-04
#> 389                  transcription, DNA-templated    28  36 5.951883e-04
#>            padj category
#> 24  0.045369693       GO
#> 38  0.045663753       GO
#> 51  0.027087430       GO
#> 79  0.000506536       GO
#> 185 0.046448881       GO
#> 225 0.045369693       GO
#> 247 0.004696435       GO
#> 310 0.045369693       GO
#> 311 0.045369693       GO
#> 314 0.045369693       GO
#> 389 0.045369693       GO
#>
#> $F1_vs_midparent
#>                                              term genes all         pval
#> 119        cyclic nucleotide biosynthetic process    38 108 1.983329e-04
#> 133                                dynein complex     9  13 1.789139e-04
#> 182             intracellular signal transduction    38 110 3.036659e-04
#> 184                          ion channel activity    20  48 5.611617e-04
#> 185                                 ion transport    21  45 5.765412e-05
#> 297                     protein dephosphorylation    21  44 3.792684e-05
#> 314 protein serine/threonine phosphatase activity    15  24 7.437911e-06
#>            padj category
#> 119 0.016540962       GO
#> 133 0.016540962       GO
#> 182 0.021104781       GO
#> 184 0.033429202       GO
#> 185 0.008013923       GO
#> 297 0.007907747       GO
#> 314 0.003101609       GO
```

Likewise, for down-regulated genes, you need to replace the `>` symbol
with a `<` symbol in the anonymous function to subset rows.

# FAQ

1. How do I create a `SummarizedExperiment` object?

A `SummarizedExperiment` is a data structure (an S4 class) that can
be used to store, in a single object, the following elements:

1. **assay:** A quantitative matrix with features in rows and samples in
   columns. In the context of *[HybridExpress](https://github.com/HybridExpress)*, this
   would be a gene expression matrix (in counts) with genes in rows and samples
   in columns.
2. **colData:** A data frame of sample metadata with samples in rows
   and variables that describe samples (e.g., tissue, treatment, and other
   covariates) in columns.
3. **rowData:** A data frame of gene metadata with genes in rows and
   variables that describe genes (e.g., chromosome name, alternative IDs,
   functional information, etc) in columns.

For this package, you must have an *assay* containing the count matrix
and a *colData* slot with sample metadata. *rowData* can be present,
but it is not required.

To demonstrate how to create a `SummarizedExperiment` object, we will
extract the *assay* and *colData* from the example object `se_chlamy`
that comes with this package.

```
# Get count matrix
count_matrix <- assay(se_chlamy)
head(count_matrix)
#>                 S1  S2   S3   S4  S5   S6   S7   S8   S9 S10 S11  S12  S13  S14
#> Cre01.g000050   31  21   26   33  19   48   17    6   13   6  10    7   31   22
#> Cre01.g000150   50  29   35   99  11   58   51   46   41  33  28   14   53   25
#> Cre01.g000200   36  26   24   29  17   36   14   15   12   8  14    7   25   24
#> Cre01.g000250  440 272  394  332 283  585  272  274  255 160 225  235  405  391
#> Cre01.g000300 1242 839 1216 1251 811 1785 1341 1306 1122 877 844 1082 1704 1739
#> Cre01.g000350  412 264  294  336 252  478  233  221  195 155 190  201  299  272
#>                S15  S16  S17  S18
#> Cre01.g000050   29   22   21   16
#> Cre01.g000150   37   17   24   21
#> Cre01.g000200   24   26   18   21
#> Cre01.g000250  358  339  340  332
#> Cre01.g000300 1524 1720 1517 1243
#> Cre01.g000350  276  324  246  275

# Get colData (data frame of sample metadata)
coldata <- colData(se_chlamy)
head(coldata)
#> DataFrame with 6 rows and 2 columns
#>         Ploidy Generation
#>    <character>   <factor>
#> S1     diploid         P1
#> S2     diploid         P1
#> S3     diploid         P1
#> S4     diploid         P1
#> S5     diploid         P1
#> S6     diploid         P1
```

Once you have these two objects, you can create a `SummarizedExperiment` object
with:

```
# Create a SummarizedExperiment object
new_se <- SummarizedExperiment(
    assays = list(counts = count_matrix),
    colData = coldata
)

new_se
#> class: SummarizedExperiment
#> dim: 13058 18
#> metadata(0):
#> assays(1): counts
#> rownames(13058): Cre01.g000050 Cre01.g000150 ... ERCC-00170 ERCC-00171
#> rowData names(0):
#> colnames(18): S1 S2 ... S17 S18
#> colData names(2): Ploidy Generation
```

For more details on this data structure, read the vignette
of the *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* package.

# Session information

This document was created under the following conditions:

```
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-30
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package              * version  date (UTC) lib source
#>  abind                  1.4-8    2024-09-12 [2] CRAN (R 4.5.1)
#>  Biobase              * 2.70.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.56.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26  2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocParallel           1.44.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocStyle            * 2.38.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bookdown               0.45     2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                  0.9.0    2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                 1.1.0    2024-05-16 [2] CRAN (R 4.5.1)
#>  Cairo                  1.7-0    2025-10-29 [2] CRAN (R 4.5.1)
#>  circlize               0.4.16   2024-02-20 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5    2025-04-23 [2] CRAN (R 4.5.1)
#>  clue                   0.3-66   2024-11-13 [2] CRAN (R 4.5.1)
#>  cluster                2.1.8.1  2025-03-12 [3] CRAN (R 4.5.1)
#>  codetools              0.2-20   2024-03-31 [3] CRAN (R 4.5.1)
#>  colorspace             2.1-2    2025-09-22 [2] CRAN (R 4.5.1)
#>  ComplexHeatmap         2.26.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  crayon                 1.5.3    2024-06-20 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.36.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  DESeq2                 1.50.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  dichromat              2.0-0.1  2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37   2024-08-19 [2] CRAN (R 4.5.1)
#>  doParallel             1.0.17   2022-02-07 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4    2023-11-17 [2] CRAN (R 4.5.1)
#>  evaluate               1.0.5    2025-08-27 [2] CRAN (R 4.5.1)
#>  farver                 2.1.2    2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0    2024-05-15 [2] CRAN (R 4.5.1)
#>  foreach                1.5.2    2022-02-02 [2] CRAN (R 4.5.1)
#>  generics             * 0.1.4    2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicRanges        * 1.62.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GetoptLong             1.0.5    2020-12-15 [2] CRAN (R 4.5.1)
#>  ggplot2                4.0.0    2025-09-11 [2] CRAN (R 4.5.1)
#>  GlobalOptions          0.1.2    2020-06-10 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0    2024-09-30 [2] CRAN (R 4.5.1)
#>  gtable                 0.3.6    2024-10-25 [2] CRAN (R 4.5.1)
#>  htmltools              0.5.8.1  2024-04-04 [2] CRAN (R 4.5.1)
#>  HybridExpress        * 1.6.0    2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  IRanges              * 2.44.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  iterators              1.0.14   2022-02-05 [2] CRAN (R 4.5.1)
#>  jquerylib              0.1.4    2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0    2025-03-27 [2] CRAN (R 4.5.1)
#>  knitr                  1.50     2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling               0.4.3    2023-08-29 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7   2025-04-02 [3] CRAN (R 4.5.1)
#>  lifecycle              1.0.4    2023-11-07 [2] CRAN (R 4.5.1)
#>  locfit                 1.5-9.12 2025-03-05 [2] CRAN (R 4.5.1)
#>  magick                 2.9.0    2025-09-08 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.4    2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-4    2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics       * 1.22.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats          * 1.5.0    2025-01-07 [2] CRAN (R 4.5.1)
#>  patchwork              1.3.2    2025-08-25 [2] CRAN (R 4.5.1)
#>  pillar                 1.11.1   2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3    2019-09-22 [2] CRAN (R 4.5.1)
#>  png                    0.1-8    2022-11-29 [2] CRAN (R 4.5.1)
#>  R6                     2.6.1    2025-02-15 [2] CRAN (R 4.5.1)
#>  RColorBrewer           1.1-3    2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0    2025-07-02 [2] CRAN (R 4.5.1)
#>  rjson                  0.2.23   2024-09-16 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6    2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.30     2025-09-28 [2] CRAN (R 4.5.1)
#>  S4Arrays               1.10.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.48.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0    2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10   2025-04-11 [2] CRAN (R 4.5.1)
#>  scales                 1.4.0    2025-04-24 [2] CRAN (R 4.5.1)
#>  Seqinfo              * 1.0.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo            1.2.3    2025-02-05 [2] CRAN (R 4.5.1)
#>  shape                  1.4.6.1  2024-02-23 [2] CRAN (R 4.5.1)
#>  SparseArray            1.10.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  SummarizedExperiment * 1.40.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  tibble                 3.3.0    2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1    2024-03-11 [2] CRAN (R 4.5.1)
#>  vctrs                  0.6.5    2023-12-01 [2] CRAN (R 4.5.1)
#>  withr                  3.0.2    2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                   0.53     2025-08-19 [2] CRAN (R 4.5.1)
#>  XVector                0.50.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10   2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/Rtmp0HzUAX/Rinste2fa2236792c8
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────
```

# References

Coate, Jeremy E. 2023. “Beyond Transcript Concentrations: Quantifying Polyploid Expression Responses Per Biomass, Per Genome, and Per Cell with Rna-Seq.” In *Polyploidy: Methods and Protocols*, 227–50. Springer.

Rapp, Ryan A, Joshua A Udall, and Jonathan F Wendel. 2009. “Genomic Expression Dominance in Allopolyploids.” *BMC Biology* 7 (1): 1–10.