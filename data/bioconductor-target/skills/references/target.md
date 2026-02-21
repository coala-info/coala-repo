# Using the `target` package

#### Mahmoud Ahmed

#### 2025-10-30

## Overview

In this document, we describe the [BETA](http://cistrome.org/BETA/) algorithm for predicting associated peaks from binding ChIP data and integrating binding data and expression data to predict direct binding target regions. In addition, we describe the implementation of the algorithm in an R package, `target`. Finally, we provide an example for using `target` to predict associated peaks and direct gene targets of androgen receptors in the LNCap cell line.

## The theory

The [BETA](http://cistrome.org/BETA/) algorithm in its simplest form, *minus*, is composed of three steps:

1. Selecting the peaks (\(p\)) within a certain range from the regions of interest (\(g\)).
2. Calculate the distance (\(\Delta\)) between the center of the peak and each of the regions expressed relative to a distance of 100 kb.
3. Calculate a the peak scores (\(S\_p\)) as the transformed exponential of the distance, \(\Delta\), as follows;

\[
S\_p = e^{-(0.5+4\Delta)}
\]

4. Calculate the region/gene regulatory potential (\(S\_g\)) as the sum of the scores, \(S\_p\), as follows:

\[
S\_g = \sum\_{i=1}^k S\_{pi}
\] where \(p\) is \(\{1,...,k\}\) peaks near the region of interest.

In addition, in [BETA](http://cistrome.org/BETA/) *basic* another step is added to predict real region/gene targets

5. Rank all regions based on their regulatory potential, \(S\_g\), to give their binding potential (\(R\_{gb}\)) and based on their differential expression (\(R\_{ge}\)). The product of the two ranks predicts real region/gene targets.

\[
RP\_g = \frac{R\_{gb}\times R\_{ge}}{n^2}
\]

where \(n\) is the number of regions \(g\).

## Python implementation

The original [paper](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4135175/) on this work presented an implementation of the algorithm in [python](https://github.com/suwangbio/BETA) which can be invoked form the command-line interface (CLI).

* Input: peaks file in `bed` format and optionally the differential expression output in `txt`
* Output: `txt` files of the associated peaks and direct targets in each direction; up and/or down.
* Options: users can define the distances around the transcription start sites to select the overlapping peaks, cut offs for the significance of the peaks or the top number of peaks to be included in the analysis.

## R implementation

The `target` package implement the [BETA](http://cistrome.org/BETA/) algorithm in several low-level functions that correspond to the previously described steps.

1. `merge_ranges`: select the peaks in the genomic regions of interest, e.g.  genes.
2. `find_distance`: calculate the distance between the peaks and the regions of interest, e.g. transcription start sites (TSS).
3. `score_peaks`: calculate a regulatory score for each peak in relation to a region of interest.
4. `score_regions`: Calculate a regulatory score for regions of interest/genes
5. `rank_product`: rank the regions of interest/genes based on the regulatory potential and another statistics, e.g. differential expression.

In addition, two high-level functions can be used to apply these functions sequentially and obtain only the final output. These are:

1. `associated_peaks`: select and calculate a regulatory potential for peaks within a defined distance from regions of interest/genes.
2. `direct_targets`: predict direct target regions among regions of interest/genes based on the regulatory potential of the peaks in the region and one more statistics such as differential expression.

Finally, two additional functions `plot_predictions` and `test_predictions` were added to visually and statistically examine the predictions made by `target`.

## Example

The example below was presented in this [paper](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4135175/). The dataset used in the example is from another published [study](https://www.ncbi.nlm.nih.gov/pubmed/17679089/). The study used the LNCap cell line to determine the androgen receptor (AR) binding sites using ChIP-on-chip and the gene expression in the cell line after treatment with physiological androgen 5α-dihydrotestosterone (DHT) for 16 hours using microarrays. The binding sites of AR are recorded in a `bed` file, `3656_peaks.bed`. The differential gene expression results are recorded in `AR_diff_expr.xls`. The reference genome [hg19](https://www.ncbi.nlm.nih.gov/assembly/GCF_000001405.13/) was used to define the gene coordinates and identifiers, `hg19.refseq`.

```
# load reguired libraries
library(target)
library(GenomicRanges)
```

Each of the three following chuncks is reading one of the required input data and transforming it into the appropriate format. The test data of the [python](https://github.com/suwangbio/BETA) package is shipped with the R `target` package for testing purposes. Two datasets `real_peaks` and `real_transcripts` are the two `GRanges` object that holds the identified peaks and the differential expression results respectively.

```
# load peaks and transcripts data
data("real_peaks")
data("real_transcripts")
```

The two high-level functions mentioned above can be called directly into the objects. `associated_peaks` takes as arguments two `GRanges` objects; `peaks` and `regions`. In this case, the two inputs are the `peaks` and `transcripts` which we prepared earlier. The output of this function is a `GRanges`, the same as the input `peaks`, with three additional metadata columns: `assigned_region`, `distance` and `peak_score`.

```
# get associated peaks
ap <- associated_peaks(real_peaks, real_transcripts, 'ID')
ap
#> GRanges object with 18877 ranges and 5 metadata columns:
#>           seqnames              ranges strand |     peak_name      pval
#>              <Rle>           <IRanges>  <Rle> |   <character> <numeric>
#>       [1]     chr1     1208689-1209509      * |    AR_LNCaP_2     51.58
#>       [2]     chr1     1208689-1209509      * |    AR_LNCaP_2     51.58
#>       [3]     chr1     1208689-1209509      * |    AR_LNCaP_2     51.58
#>       [4]     chr1     1208689-1209509      * |    AR_LNCaP_2     51.58
#>       [5]     chr1     1208689-1209509      * |    AR_LNCaP_2     51.58
#>       ...      ...                 ...    ... .           ...       ...
#>   [18873]     chrX 153362757-153363593      * | AR_LNCaP_7151     51.71
#>   [18874]     chrY   21706080-21707252      * | AR_LNCaP_7174     74.36
#>   [18875]     chrY   21706080-21707252      * | AR_LNCaP_7174     74.36
#>   [18876]     chrY   21706080-21707252      * | AR_LNCaP_7174     74.36
#>   [18877]     chrY   21706080-21707252      * | AR_LNCaP_7174     74.36
#>           assigned_region  distance peak_score
#>               <character> <numeric>  <numeric>
#>       [1]       NM_030649    -34171  0.1546115
#>       [2]       NM_080605     41471  0.1154590
#>       [3]       NM_032348    -85075  0.0201813
#>       [4]    NM_001130413     -6715  0.4636617
#>       [5]       NR_037668     -6715  0.4636617
#>       ...             ...       ...        ...
#>   [18873]    NM_001025243     77833  0.0269622
#>   [18874]       NR_045128    -22576  0.2458484
#>   [18875]       NR_045129    -22576  0.2458484
#>   [18876]       NR_002923     41626  0.1147453
#>   [18877]       NR_033732     41626  0.1147453
#>   -------
#>   seqinfo: 24 sequences from an unspecified genome; no seqlengths
```

`direct_targets` also takes as arguments two `GRanges` objects; `peaks` and `regions`. Two other arguments are required when the user desires to rank the target genes based on both the regulatory potential and the differential expression statistics. The arguments are `regions_col` and `stats_col`, these should be strings for the columns names in the metadata of the `regions` object for the gene names/symbols and the chosen statistics to rank the genes. The output of this function is a `GRanges`, the same as the input `regions`, with four additional metadata columns: `score`, `stat`, `score_rank`, `stat_rank` and `rank`. These correspond to the regulatory potential gene score, the chosen statistics, the rank of each and the final rank product. The values in the `rank` column are the product of the two ranks, the less the value the more likely a region/gene is a direct target. The direction of the regulation can be infered from the sign of the `stat` column.

```
# get direct targets
dt <- direct_targets(real_peaks, real_transcripts, 'ID', 't')
dt
#> GRanges object with 12955 ranges and 13 metadata columns:
#>         seqnames              ranges strand |          ID      logFC   AveExpr
#>            <Rle>           <IRanges>  <Rle> | <character>  <numeric> <numeric>
#>       1    chr17     7023149-7223148      + |   NM_000018  0.0409878  11.01544
#>       2    chr14   73503142-73703141      + |   NM_000021  0.1199713   8.39135
#>       3    chr17   48143365-48343364      + |   NM_000023  0.1371541   5.12358
#>       4     chr5 148106155-148306154      + |   NM_000024  0.5994898   8.44558
#>       5    chr22   40642503-40842502      + |   NM_000026 -0.1418942   9.81567
#>     ...      ...                 ...    ... .         ...        ...       ...
#>   18869    chr19   39781836-39981835      - |   NR_046384 -0.1408625   7.61365
#>   18871     chr9     6313150-6513149      + |   NR_046386  0.4066894   9.48455
#>   18872     chr3 174733033-174933032      - |   NR_046390 -0.0174116   3.48394
#>   18875    chr13 106259178-106459177      + |   NR_046391  0.0760666   3.50244
#>   18877     chr6   37221747-37421746      + |   NR_046399 -0.0680422   6.66562
#>                 t    P.Value   adj.P.Val         B        name2     score
#>         <numeric>  <numeric>   <numeric> <numeric>  <character> <numeric>
#>       1  0.746629 0.47468629 0.739166575  -6.81149       ACADVL  0.148900
#>       2  2.343828 0.04424855 0.207403547  -4.75252        PSEN1  0.583250
#>       3  1.795674 0.10673795 0.341644528  -5.59209         SGCA  0.324542
#>       4  9.238179 0.00000783 0.000798244   4.22568        ADRB2  0.323984
#>       5 -1.800457 0.10593744 0.340460418  -5.58514         ADSL  0.320545
#>     ...       ...        ...         ...       ...          ...       ...
#>   18869 -1.838306  0.0997969  0.32891069  -5.52988         PAF1 0.6433463
#>   18871  7.448831  0.0000431  0.00247311   2.45378        UHRF2 0.5980745
#>   18872 -0.276204  0.7887433  0.91123015  -7.06834 NAALADL2-AS3 0.6114942
#>   18875  1.573865  0.1505990  0.41261732  -5.90400    LINC00343 0.6186284
#>   18877 -1.211998  0.2569285  0.54534918  -6.35935         RNF8 0.0158377
#>         score_rank      stat stat_rank       rank
#>          <integer> <numeric> <integer>  <numeric>
#>       1       6250  0.746629      8615 0.32081928
#>       2       1396  2.343828      3203 0.02664204
#>       3       3646  1.795674      4438 0.09641156
#>       4       3655  9.238179       222 0.00483466
#>       5       3697 -1.800457      4426 0.09749583
#>     ...        ...       ...       ...        ...
#>   18869        745 -1.838306      4307 0.01911861
#>   18871       1182  7.448831       364 0.00256356
#>   18872        896 -0.276204     11329 0.06048181
#>   18875        863  1.573865      5154 0.02650211
#>   18877      12077 -1.211998      6507 0.46823626
#>   -------
#>   seqinfo: 51 sequences from an unspecified genome; no seqlengths
```

The following code shows the relation between the peak distance and the peak score (left), the genes t-statitics and the gene regulatory potentials (middle), and the emperical cumlative distribution function (ECDF) of the regulatory potential ranks of the up, down and non-regulated genes (right) .

```
par(mfrow = c(1, 3))

# show peak distance vs score
plot(ap$distance, ap$peak_score,
     pch = 19, cex = .5,
     xlab = 'Peak Distance', ylab = 'Peak Score')
abline(v = 0, lty = 2, col = 'gray')

# show gene stat vs score
plot(dt$stat, dt$score,
     pch = 19, cex = .5,
     xlim = c(-35, 35),
     xlab = 'Gene t-stats', ylab = 'Gene Score')
abline(v = 0, lty = 2, col = 'gray')

# show gene regulatory potential ecdf
groups <- c('Down', 'None', 'Up')
colors <- c('darkgreen', 'gray', 'darkred')

fold_change <- cut(dt$logFC,
                   breaks = c(min(dt$logFC), -.5, .5, max(dt$logFC)),
                   labels = groups)

plot_predictions(dt$score_rank,
                 fold_change,
                 colors,
                 groups,
                 xlab = 'Gene Regulatory Potential Rank',
                 ylab = 'ECDF')
```

![](data:image/png;base64...)

The graph shows that more of the up-regulated transcripts are ranking higher than the down- and none-regulated genes. We can test whether the distribution function of the two regulated group are drawn from the same distribution of the none-regulated transcripts.

```
# test up-regulated transcripts are not random
test_predictions(dt$score_rank,
                 group = fold_change,
                 compare = c('Up', 'None'),
                 alternative = 'greater')
#>
#>  Asymptotic two-sample Kolmogorov-Smirnov test
#>
#> data:  x and y
#> D^+ = 0.39159, p-value < 2.2e-16
#> alternative hypothesis: the CDF of x lies above that of y

# test down-regulated transcripts are not random
test_predictions(dt$score_rank,
                 group = fold_change,
                 compare = c('Down', 'None'),
                 alternative = 'greater')
#>
#>  Asymptotic two-sample Kolmogorov-Smirnov test
#>
#> data:  x and y
#> D^+ = 0.12398, p-value = 0.01296
#> alternative hypothesis: the CDF of x lies above that of y
```

The names of the top regulated transcript by rank, gene name and its associated peaks.

```
# show the top regulated transcript, gene name and its associated peaks
top_trans <- unique(dt$ID[dt$rank == min(dt$rank)])
top_trans
#> [1] "NR_045762"

unique(dt$name2[dt$ID == top_trans])
#> [1] "KLK2"
unique(ap$peak_name[ap$assigned_region == top_trans])
#> [1] "AR_LNCaP_4914" "AR_LNCaP_4915" "AR_LNCaP_4916"
```

## Advantages of the R implementation

The `target` package implements the [BETA](http://cistrome.org/BETA/) algorithm for detecting the associated peaks of DNA-binding proteins or histone markers from ChIP data. In addition, when genetic or chemical perturbation data is provided the algorithm can predict direct target regions of the protein or the marker by integrating the binding and the expression data. The implementation of the algorithm in R provide a few advantages:

* `target` leverages the Bioconductor data structures such as `GRanges` and `DataFrame` to provide flexible containers which can be manipulated and updated to prepare the input data. The containers are also faster to perform merge and selection operations on.
* In the R package, the input data are limited to the peaks and the regions expression data. This gives the users more control. For example, regions can be defined as genes, transcripts, promoters of differentially expressed regions. Similarly, the expression data can be any signed statistics that corresponds to the defined regions. Finally, any old or recent can be used to define genomic coordinates without being limited to built in reference genomes.
* The same R functions can be used to predict the combined function of two factors in the same condition. Predicting cooperative or competitive effect of two factors is described in `vignette('extend-target')`.

## References

Wang S, Sun H, Ma J, et al. Target analysis by integration of transcriptome and ChIP-seq data with BETA. Nat Protoc. 2013;8(12):2502–2515. doi:10.1038/nprot.2013.150

Wang Q, Li W, Liu XS, et al. A hierarchical network of transcription factors governs androgen receptor-dependent prostate cancer growth. Mol Cell. 2007;27(3):380–392. doi:10.1016/j.molcel.2007.05.041

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
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
#> [1] GenomicRanges_1.62.0 Seqinfo_1.0.0        IRanges_2.44.0
#> [4] S4Vectors_0.48.0     BiocGenerics_0.56.0  generics_0.1.4
#> [7] target_1.24.0
#>
#> loaded via a namespace (and not attached):
#>  [1] cli_3.6.5         knitr_1.50        rlang_1.1.6       xfun_0.53
#>  [5] otel_0.2.0        promises_1.4.0    shiny_1.11.1      xtable_1.8-4
#>  [9] jsonlite_2.0.0    htmltools_0.5.8.1 httpuv_1.6.16     sass_0.4.10
#> [13] rmarkdown_2.30    evaluate_1.0.5    jquerylib_0.1.4   fastmap_1.2.0
#> [17] yaml_2.3.10       lifecycle_1.0.4   compiler_4.5.1    Rcpp_1.1.0
#> [21] later_1.4.4       digest_0.6.37     R6_2.6.1          magrittr_2.0.4
#> [25] bslib_0.9.0       tools_4.5.1       mime_0.13         matrixStats_1.5.0
#> [29] cachem_1.1.0
```