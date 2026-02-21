# Correlation of epigenetic signals and genes in TADs

Konstantin Okonechnikov1

1German Cancer Research Center (DKFZ), Heidelberg, Germany

#### 30 October 2025

#### Abstract

The InTAD package is focused on the detection of correlation between expressed genes and selected epigenomic signals (i.e. enhancers) either located within same topologically associated domains (TADs) or connected via chromatin loops.
For the first task coordinates of known publicly avialable TADs can be used due to their stability across cell types.
Additionally novel TADs or direct loops detected using HiC technology can be applied to strengthen the specificity.
For the usage of TADs the analysis procedure starts from collecting signals and genes lying in the same TAD. Then the combined groups in a TAD are analyzed to detect correlations among them.
For the usage of HiC loops the procedure starts from searching for connections between genes and target signals. Afterwards correlation is computed in similar manner as with TADs for each signal-gene pair.
Various parameters can be
further controlled. For example, the gene expression filters, correlation
methods (Pearson, Spearman), statistical limits (q-value computation), etc.
The connection to TADs can be also expanded to find correlation with closest
gene outside of a TAD. Multiple analysis steps include generation of special
plots for results visualization.

# Contents

* [1 Introduction](#introduction)
* [2 Main data analysis using TADs](#main-data-analysis-using-tads)
* [3 Integration of chromatin loops](#integration-of-chromatin-loops)
* [4 Visualization](#visualization)
* [5 Session info](#session-info)
* [6 References](#references)
* **Appendix**

# 1 Introduction

The InTAD analysis is focused on the processing of generated object that
combines all input datasets. Required input data is the following:

* epigenetic signals data.frame e.g. enhancers along with their coordinates in
  GRanges format
* gene expression counts data.frame along with gene coordinates
  in GRanges format
* TAD borders GRanges or loops data.frame e.g. from results of HiC technique application

Further explained example of performing the analysis procedure is based on
H3K27ac data reflecting activity of enhancers in medulloblastoma brain tumour
descrbied in the manuscript from [C.Y.Lin, S.Erkek et al., Nature,
2016.](http://www.nature.com/nature/journal/v530/n7588/full/nature16546.html)

This dataset includes normalized enhancer signals obtained from H3K27ac
ChIP-seq data and RNA-seq gene expression RPKM counts from 25 medulloblastoma
samples. The test subset is extracted from a selected region inside
chromosome 15. Additionally, the coordinates for enhancers and genes along
with specific sample annotation are provided.

The analysis starts from preparing and loading the data. Here is the
overview of integrated input test data, that can serve as a useful example
describing supported input formats:

```
library(InTAD)
# normalized enhancer signals table
enhSel[1:3,1:3]
```

```
##                              MB176       MB95       MB40
## chr15:25661165-25662833 -0.3041844 -0.7661778 -1.9551413
## chr15:25682177-25685608  4.3015286  5.0409281  5.8519724
## chr15:25709081-25711634  0.5399542 -0.1572336 -0.6773354
```

```
# enhancer signal genomic coordinates
as.data.frame(enhSelGR[1:3])
```

```
##   seqnames    start      end width strand
## 1    chr15 25661165 25662833  1669      *
## 2    chr15 25682177 25685608  3432      *
## 3    chr15 25709081 25711634  2554      *
```

```
# gene expression normalized counts
rpkmCountsSel[1:3,1:3]
```

```
##                   MB176     MB95 MB40
## ENSG00000215567.4     0 0.000000    0
## ENSG00000201241.1     0 0.000000    0
## ENSG00000258463.1     0 4.183154    0
```

```
# gene coordiantes
as.data.frame(txsSel[1:3])
```

```
##   seqnames    start      end width strand           gene_id    gene_name
## 1    chr15 20083769 20093074  9306      + ENSG00000215567.4 RP11-79C23.1
## 2    chr15 20088867 20088969   103      + ENSG00000201241.1    RNU6-978P
## 3    chr15 20104587 20104812   226      + ENSG00000258463.1 RP11-173D3.3
##    gene_type
## 1 pseudogene
## 2      snRNA
## 3 pseudogene
```

```
# additional sample info data.frame
head(mbAnnData)
```

```
##       Subgroup Age Gender    Histology M.Stage
## MB176      WNT   9      F      Classic      M0
## MB95    Group3   3      M      Classic      M0
## MB40    Group4   3      M      Classic      M0
## MB37       SHH   1      F Desmoplastic      M0
## MB38    Group4   6      M Desmoplastic      M0
## MB28       SHH   1      M Desmoplastic      M0
```

Importantly, there are specific requriements for the input datasets. The names
of samples should match in signals and gene expression datasets.

```
summary(colnames(rpkmCountsSel) == colnames(enhSel))
```

```
##    Mode    TRUE
## logical      25
```

Next, the genomic regions should be provided for each signal as well as for
each gene.

```
# compare number of signal regions and in the input table
length(enhSelGR) == nrow(enhSel)
```

```
## [1] TRUE
```

The genomic regions reflecting the gene coordinates must include *“gene\_id”*
and *“gene\_name”* marks. These are typical GTF format markers. One more mark
*“gene\_type”* is also useful to perform filtering of gene expression matrix.

All the requirements are checked during the generation of the **InTADSig**
object. Main part of this object is *[MultiAssayExperiment](https://bioconductor.org/packages/3.22/MultiAssayExperiment)* subset
that combines signals and gene expression. Specific annotation information
about samples can be also included for further control and visualization. In
provided example for medulloblastoma samples annotation contains various
aspects such as tumour subgroup, age, gender, etc.

```
inTadSig <- newSigInTAD(enhSel, enhSelGR, rpkmCountsSel, txsSel,mbAnnData)
```

```
## Created signals and genes object for 25 samples
```

The created object contains MultiAssayExperiment that includes both signals and
gene expression data.

```
inTadSig
```

```
## S4 InTADSig object
## Num samples: 25
## Num signals: 116
## Num genes:  2080
```

During the main object generation there are also available special options to
activate parallel computing based on usage of R multi-thread librares and log2 adjustment for gene expression. The generated data subsets can be
accessed using specific call functions on the object i.e. *signals* or *exprs*.

Notably, the main object can be also loaded from the text files representing
the input data using function *loadSigInTAD*. Refer to the documetation of this
function for more details.

# 2 Main data analysis using TADs

The usage of input gene expression counts matrix assumes filtering of non- or low expressed genes. However if these counts were not filtered before starting the InTAD analysis it’s possible to adjust gene expression limits using function *filterGeneExpr*. This function provides parameters to control
minimum gene expression and type. There is additionally a special option to
compute gene expression distribution based on usage of *[mclust](https://CRAN.R-project.org/package%3Dmclust)*
package in order to find suitable minimum gene expression cut limit.
Here’s example how to use this procedure:

```
# filter gene expression
inTadSig <- filterGeneExpr(inTadSig, checkExprDistr = TRUE)
```

```
## Initial result: 2080 genes
```

```
## Gene expression cut value: 1.7940580646795
```

```
## Filtered result: 671 genes
```

The analysis starts from the combination of signals and genes inside the TADs.
Since the TADs are known to be stable across various cell types, it’s possible
to use already known TADs obtained from IMR90 cells using HiC technology
([Dixon et al 2012](https://www.nature.com/articles/nature11082)). The human
IMR90 TADs regions object is integrated into the package.

```
# IMR90 hg19 TADs
head(tadGR)
```

```
## GRanges object with 6 ranges and 0 metadata columns:
##                        seqnames          ranges strand
##                           <Rle>       <IRanges>  <Rle>
##    chr1:770137-1250137     chr1  770137-1250137      *
##   chr1:1250137-1850140     chr1 1250137-1850140      *
##   chr1:1850140-2330140     chr1 1850140-2330140      *
##   chr1:2330140-3650140     chr1 2330140-3650140      *
##   chr1:4660140-6077413     chr1 4660140-6077413      *
##   chr1:6077413-6277413     chr1 6077413-6277413      *
##   -------
##   seqinfo: 23 sequences from an unspecified genome; no seqlengths
```

However, since the variance is actually observed between TAD calling methods
(i.e. described in detailed review by [Rola Dali and Mathieu Blanchette, NAR
2017](https://academic.oup.com/nar/article/45/6/2994/3059658) ), novel obtained
TADs can be also applied for the analysis. The requried format: GRanges object.

Composition of genes and signals in TADs is performed using function
*combineInTAD* that has several options. By default, it marks the signal
belonging to the TAD by largest overlap and also takes into account genes that
are not overlaping the TADs by connecting them to the closest TAD. This can be
sensetive strategy since some genomic regions can be missed due to the limits
of input HiC data and variance of existing TAD calling methods.

```
# combine signals and genes in TADs
inTadSig <- combineInTAD(inTadSig, tadGR)
```

```
## Combined 768 signal-gene pairs in TADs
```

Final step is the correlation analysis. Various options are avialble for this
function i.e. correlation method, computation of q-value to control the
evidence strength and visualization of connection proportions. This last option
allows to show differences in gene and signal regulations.

```
par(mfrow=c(1,2)) # option to combine plots in the graph
# perform correlation anlaysis
corData <- findCorrelation(inTadSig,plot.proportions = TRUE)
```

![](data:image/png;base64...)

The result data.frame has a special format. It includes each signal, TAD, gene
and correlation information.

```
head(corData,5)
```

```
##                    peakid                     tad               gene
## 1 chr15:25748892-25750259 chr15:25728907-27128907 ENSG00000114062.13
## 2 chr15:25748892-25750259 chr15:25728907-27128907  ENSG00000261529.1
## 3 chr15:25748892-25750259 chr15:25728907-27128907  ENSG00000206190.7
## 4 chr15:25748892-25750259 chr15:25728907-27128907  ENSG00000166206.9
## 5 chr15:25748892-25750259 chr15:25728907-27128907  ENSG00000235518.2
##            name         cor     pvalue   eucDist corRank
## 1         UBE3A  0.37789578 0.06253400 25.748716       3
## 2 RP13-487P22.1  0.21115682 0.31095743  7.360294       5
## 3        ATP10A -0.03977321 0.85028161  7.703550       6
## 4        GABRB3  0.44145787 0.02716195 21.972593       1
## 5    AC011196.3  0.36894539 0.06953544  7.381633       4
```

Further filtering of this result data can be performed by adjusting p-value and
correlation effect limits (i.e. p-val < 0.01, positive correlation only).

# 3 Integration of chromatin loops

Another clear approach to find contacts between genes and epigenetic signals
is to use direct chromatin connections, so called loops. The loops are typically derived from HiC data and there are well-known tools that allow to perform this (e.g. [FitHiC](https://ay-lab.github.io/fithic/) or [HiCCUPS](https://github.com/aidenlab/juicer/wiki/HiCCUPS)).

![](data:image/png;base64...)

An example of chromatin loops visualisation from IGV showing connection of medulloblastoma tumor specific enhancers to genes. The loops are derived from IMR90 HiC data.

InTAD starting from version 1.9.1 also allows to use HiC loops for the analysis. Main functions to perform this task are *combineWithLoops* and *findCorFromLoops*.

To demonstrate this approach InTAD includes an example subset of loops derived from [IMR90 cells](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE63525). This loops data.frame has a specific format where the first 6 columns represent genomic regions for both loop anchors: *(chr1,start1,end1,chr2,start2,end2)*:

```
loopsDfSel[1:4,1:6]
```

```
##    chr1        x1        x2  chr2        y1        y2
## 1 chr15 100470000 100480000 chr15 100670000 100680000
## 2 chr15 101170000 101180000 chr15 101410000 101420000
## 3 chr15 101170000 101180000 chr15 101800000 101810000
## 4 chr15 101175000 101180000 chr15 101540000 101545000
```

The loaded loops are applied to find connections between genes and signals using function *combineWithLoops*. By default 6-column loops format is expected, but the function also supports 4-column format where for the loop anchors only middle positions are provided (as in [FitHiC](https://ay-lab.github.io/fithic/) output): *(chr1,middlePos1,chr2,middlePos2)* .

Howerer in this case loop fragment length is also required and using the variable *fragmentLength* allows to activate this format. In addition other parameters (e.g. transcription start site width, extension of the loops) can be controlled to increase the sensitivity.

In result the function reports how many connections are detected to be supported by loops and saves them within the returned InTAD object:

```
inTadSig <- combineWithLoops(inTadSig, loopsDfSel)
```

```
## NOTE: 6-column loops format is assumed.
```

```
## Combined 1 signal-gene pairs with loops
```

In this particular example only 1 connection between gene and enhancer is found. To find if there are correlations between detected connected signal-gene pairs the function *fincCorFromLoops* is applied. It has a list of options similar to corresponding function *findCorrelation* for usage of TADs (e.g. correlation method, adjusted p-value):

```
loopEag <- findCorFromLoops(inTadSig,method = "spearman")
```

Final result also has format similar to representation of correlations between genes and enhancers within TADs. The only difference is that the loops supporting found connection are included:

```
loopEag
```

```
##                      peak               loopStart                 loopEnd
## 1 chr15:25748892-25750259 chr15:25750000-25760000 chr15:27110000-27120000
##                gene   name       cor      pvalue  eucDist
## 1 ENSG00000186297.7 GABRA5 0.6123077 0.001430953 12.80297
```

In general, the focus on loops allows to increase the specificity of the detected connections between signals and genes in order to find possible perspective targets for further investigation. However, ideally it should be applied on HiC data derived from the same research target materials (e.g. same tumor type), while TADs from other sources could be used due to their stability.

# 4 Visualization

The package provides post-analysis visualization function: the specific signal
and gene can be selected for correlation plot generation. Here’s example of
verified medulllobastoma Group3-specifc enhancer assoicated gene GABRA5 lying
in the same TAD as the enhancer, but not close to the gene:

```
# example enhancer in correlation with GABRA5
cID <- "chr15:26372163-26398073"
selCorData <- corData[corData$peakid == cID, ]
selCorData[ selCorData$name == "GABRA5", ]
```

```
##                      peakid                     tad              gene   name
## 430 chr15:26372163-26398073 chr15:25728907-27128907 ENSG00000186297.7 GABRA5
##          cor       pvalue  eucDist corRank
## 430 0.878531 7.724306e-09 10.92154       1
```

For the plot generation it is required to provide the signal id and gene name:

```
plotCorrelation(inTadSig, cID, "GABRA5",
                xLabel = "RPKM gene expr log2",
                yLabel = "H3K27ac enrichment log2",
                colByPhenotype = "Subgroup")
```

```
## ENSG00000186297.7
```

![](data:image/png;base64...)

Note that in the visualization it’s also possible to mark the colours
representing the samples using option *colByPhenotype* based on the sample
annotation information included in the generation of the main object. In the
provided example medulloblastma tumour subgroups are marked.

Specific genomic region of interest can be also visualised to observe the
variance and impact of TADs using special function that works on result
data.frame obtained from function *findCorrelation*. The resulting plot
provides the location of signals in X-axis and genes in Y-axis. Each point
reflects the correlation stength based on p-value: *-log10(P-val)*. This
visualization strategy was introduced in the study by [S. Waszak et al, Cell,
2015](https://www.sciencedirect.com/science/article/pii/S0092867415009770)
focused on investigation of chromatin architecture in human cells.

By default only detected TADs with signals inside are visualized,
but it is also possible to include all avaialble TAD regions using special
option. Here’s the example plot covering the whole chromosome 15 region used
in the test dataset:

```
plotCorAcrossRef(inTadSig,corData,
                 targetRegion = GRanges("chr15:25000000-28000000"),
                 tads = tadGR)
```

![](data:image/png;base64...)

One more option of this function allows to activaite representation of postive
correlation values from 0 to 1 instead of strength.

```
plotCorAcrossRef(inTadSig,corData,
                 targetRegion = GRanges("chr15:25000000-28000000"),
                 showCorVals = TRUE, tads = tadGR)
```

![](data:image/png;base64...)

It’s also possible to focus on the connections by ignoring the signal/gene
locations and focusing only on correlation values by adjusting for symmetery.
This is typical approach used for HiC contact data visualization in such
tools as for example [JuiceBox](http://aidenlab.org/juicebox/). This can be activate by using the corresponding option:

```
plotCorAcrossRef(inTadSig,corData,
                 targetRegion = GRanges("chr15:25000000-28000000"),
                 showCorVals = TRUE, symmetric = TRUE, tads = tadGR)
```

![](data:image/png;base64...)

These visualization strategies allow to investigate the impact of TADs.

Additional documentation is available for each function via standard R help.

# 5 Session info

Here is the output of `sessionInfo()` on the system on which this
document was compiled:

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
##  [1] InTAD_1.30.0                MultiAssayExperiment_1.36.0
##  [3] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [5] MatrixGenerics_1.22.0       matrixStats_1.5.0
##  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [9] IRanges_2.44.0              S4Vectors_0.48.0
## [11] BiocGenerics_0.56.0         generics_0.1.4
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1         dplyr_1.1.4              farver_2.1.2
##  [4] Biostrings_2.78.0        S7_0.2.0                 bitops_1.0-9
##  [7] fastmap_1.2.0            RCurl_1.98-1.17          GenomicAlignments_1.46.0
## [10] XML_3.99-0.19            digest_0.6.37            lifecycle_1.0.4
## [13] magrittr_2.0.4           compiler_4.5.1           rlang_1.1.6
## [16] sass_0.4.10              tools_4.5.1              yaml_2.3.10
## [19] rtracklayer_1.70.0       knitr_1.50               ggsignif_0.6.4
## [22] labeling_0.4.3           S4Arrays_1.10.0          mclust_6.1.1
## [25] curl_7.0.0               DelayedArray_0.36.0      plyr_1.8.9
## [28] RColorBrewer_1.1-3       BiocParallel_1.44.0      abind_1.4-8
## [31] withr_3.0.2              purrr_1.1.0              grid_4.5.1
## [34] ggpubr_0.6.2             ggplot2_4.0.0            scales_1.4.0
## [37] tinytex_0.57             dichromat_2.0-0.1        cli_3.6.5
## [40] rmarkdown_2.30           crayon_1.5.3             httr_1.4.7
## [43] reshape2_1.4.4           rjson_0.2.23             BiocBaseUtils_1.12.0
## [46] qvalue_2.42.0            cachem_1.1.0             stringr_1.5.2
## [49] splines_4.5.1            parallel_4.5.1           BiocManager_1.30.26
## [52] XVector_0.50.0           restfulr_0.0.16          vctrs_0.6.5
## [55] Matrix_1.7-4             jsonlite_2.0.0           carData_3.0-5
## [58] bookdown_0.45            car_3.1-3                rstatix_0.7.3
## [61] Formula_1.2-5            magick_2.9.0             tidyr_1.3.1
## [64] jquerylib_0.1.4          glue_1.8.0               codetools_0.2-20
## [67] stringi_1.8.7            gtable_0.3.6             BiocIO_1.20.0
## [70] tibble_3.3.0             pillar_1.11.1            htmltools_0.5.8.1
## [73] R6_2.6.1                 evaluate_1.0.5           lattice_0.22-7
## [76] cigarillo_1.0.0          Rsamtools_2.26.0         backports_1.5.0
## [79] broom_1.0.10             bslib_0.9.0              Rcpp_1.1.0
## [82] SparseArray_1.10.0       xfun_0.53                pkgconfig_2.0.3
```

# 6 References

# Appendix

*[Dali, R. and Blanchette, M., 2017. A critical assessment of topologically
associating domain prediction tools. Nucleic acids research, 45(6),
pp.2994-3005.](https://academic.oup.com/nar/article/45/6/2994/3059658)*

*[Dixon, J.R., Selvaraj, S., Yue, F., Kim, A., Li, Y., Shen, Y., Hu, M.,
Liu, J.S. and Ren, B., 2012. Topological domains in mammalian genomes
identified by analysis of chromatin interactions. Nature, 485(7398),
p.376.](https://www.nature.com/articles/nature11082)*

*[Lin, C.Y., Erkek, S., Tong, Y., Yin, L., Federation, A.J., Zapatka, M.,
Haldipur, P., Kawauchi, D., Risch, T., Warnatz, H.J. and Worst, B.C., 2016.
Active medulloblastoma enhancers reveal subgroup-specific cellular origins.
Nature, 530(7588),
p.57.](http://www.nature.com/nature/journal/v530/n7588/full/nature16546.html)*

*[Waszak, S.M., Delaneau, O., Gschwind, A.R., Kilpinen, H., Raghav, S.K.,
Witwicki, R.M., Orioli, A., Wiederkehr, M., Panousis, N.I., Yurovsky, A.
and Romano-Palumbo, L., 2015. Population variation and genetic control of modular chromatin architecture in humans. Cell,
162(5)](https://www.sciencedirect.com/science/article/pii/S0092867415009770)*