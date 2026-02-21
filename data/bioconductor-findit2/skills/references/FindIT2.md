Code

* Show All Code
* Hide All Code

# FindIT2:Find influential TF and influential Target

Guandong Shang1,2\*

1National Key Laboratory of Plant Molecular Genetics (NKLPMG), CAS Center for Excellence in Molecular Plant Sciences, Institute of Plant Physiology and Ecology (SIPPE), 200032, Shanghai, P. R. China
2University of Chinese Academy of Sciences, Shanghai 200032, P. R. China

\*shangguandong@cemps.ac.cn

#### 29 October 2025

#### Package

FindIT2 1.16.0

# 1 Basics

## 1.1 Install `FindIT2`

`FindIT2` is available on [Bioconductor](http://bioconductor.org) repository for
packages, you can install it by:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
      install.packages("BiocManager")
  }

BiocManager::install("FindIT2")

# Check that you have a valid Bioconductor installation
BiocManager::valid()
```

## 1.2 Citation

```
citation("FindIT2")
#> To cite FindIT2 in publications use: Guandong Shang(2022)
#>
#>   Shang, G.-D., Xu, Z.-G., Wan, M.-C., Wang, F.-X. & Wang, J.-W.
#>   FindIT2: an R/Bioconductor package to identify influential
#>   transcription factor and targets based on multi-omics data.  BMC
#>   Genomics 23, 272 (2022)
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Article{,
#>     title = {FindIT2: an R/Bioconductor package to identify influential transcription factor and targets based on multi-omics data},
#>     author = {Guandong Shang and Zhougeng Xu and Muchun Wan and Fuxiang Wang and Jiawei Wang},
#>     journal = {BMC Genomics},
#>     year = {2022},
#>     volume = {23},
#>     number = {S1},
#>     pages = {272},
#>     url = {https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-022-08506-8},
#>     doi = {10.1186/s12864-022-08506-8},
#>   }
```

## 1.3 Acknowledgments

I benefited a lot from X. Shirley Liu lab’s tools. The `integrate_ChIP_RNA` model
borrow the idea from BETA(Wang et al. [2013](#ref-wang_target_2013)) and cistromeGO
(Li et al. [2019](#ref-li_cistromego_2019)). The `calcRP` model borrow the idea from regulation
potential(Wang et al. [2016](#ref-wang_modeling_2016)). And the `FindIT_regionRP` model borrow idea from
lisa(Qin et al. [2020](#ref-qin_lisa_2020)).
I also want to thanks the Allen Lynch in Liu lab, it is please to talk with him
on the github about lisa.

I want to thanks for the memberships in our lab. Many ideas in this packages
appeared when I talk with them.

## 1.4 Introduction

The origin name of FindIT2 is MPMG(Multi Peak Multi Gene) :), which means this
package origin purpose is to do mutli-peak-multi-gene annotation. But as the
diversity of analysis increase, it gradually extend its function and rename into
FindIT2(Find influential TF and Target). But the latter function are still build
on the MPMG. Now, it have five module:

* **Multi-peak multi-gene annotaion(mmPeakAnno module)**
* **Calculate regulation potential(calcRP module)**
* **Find influential Target based on ChIP-Seq and RNA-Seq data(Find influential Target module)**
* **Find influential TF based on different input(Find influential TF module)**
* **Calculate peak-gene or peak-peak correlation(peakGeneCor module)**

And there are also some other useful function like integrate different source
information, calculate jaccard similarity for your TF. I will introduce all these
function in below manual. And for each part, I will also show the file type you
may need prepare, which can help you prepare the correct file format.

The ChIP and ATAC datasets in this vignettes are from (Wang et al. [2020](#ref-wang_chromatin_2020a)).
For the speed, I only use the data in chrosome 5.

```
# load packages
# If you want to run this manual, please check you have install below packages.
library(FindIT2)
library(TxDb.Athaliana.BioMart.plantsmart28)
library(SummarizedExperiment)

library(dplyr)
library(ggplot2)

# because of the fa I use, I change the seqlevels of Txdb to make the chrosome levels consistent
Txdb <- TxDb.Athaliana.BioMart.plantsmart28
seqlevels(Txdb) <- c(paste0("Chr", 1:5), "M", "C")

all_geneSet <- genes(Txdb)
```

> Because of the storage restriction, the data used here is a small data set, which
> may not show the deatiled information for result. The user can read the [FindIT2 paper](https://bmcgenomics.biomedcentral.com/articles/10.1186/s12864-022-08506-8)
> and [related github repo](https://github.com/shangguandong1996/FindIT2_paper_relatedCode) to see more detailed information and practical example.

# 2 Multi-peak multi-gene annotation

The multi-peak multi-gene annotation(mmPeakAnno) is the basic of this package.
Most function will use the result of mmPeakAnno. So I explain them first.

The object you may need

* **peak\_GR: a GRange object with a column named feature\_id**

FindIT2 provides `loadPeakFile` to load peak and store in `GRanges` object.
Meanwhile, it also rename one of your GRange column name into `feature_id`. The
`feature_id` is the most important column in FindIT2, which will be used as a
link to join information from different source. The `feature_id` column
represents your peak name, which is often the forth column in bed file and the
first column in GRange metadata column . If you have a GRange without
`feature_id` column, you can rename your first metadata column or just add a
column named `feature_id` like below

```
# when you make sure your first metadata column is peak name
colnames(mcols(yourGR))[1] <- "feature_id"

# or you just add a column
yourGR$feature_id <- paste0("peak_", seq_len(length(yourGR)))
```

* **Txdb: a Txdb object that manages genomic locations and the relationships between genomic feature**

you can see the detailed Txdb description in [Making and Utilizing TxDb
Objects](https://bioconductor.org/packages/devel/bioc/vignettes/GenomicFeatures/inst/doc/GenomicFeatures.pdf)

* **input\_genes: gene id**

Here I take the ChIP-Seq data as example.

```
# load the test ChIP peak bed
ChIP_peak_path <- system.file("extdata", "ChIP.bed.gz", package = "FindIT2")
ChIP_peak_GR <- loadPeakFile(ChIP_peak_path)

# you can see feature_id is in your first column of metadata
ChIP_peak_GR
#> GRanges object with 4288 ranges and 2 metadata columns:
#>          seqnames            ranges strand |  feature_id     score
#>             <Rle>         <IRanges>  <Rle> | <character> <numeric>
#>      [1]     Chr5         6236-6508      * |  peak_14125        27
#>      [2]     Chr5         7627-8237      * |  peak_14126        51
#>      [3]     Chr5        9730-10211      * |  peak_14127        32
#>      [4]     Chr5       12693-12867      * |  peak_14128        22
#>      [5]     Chr5       13168-14770      * |  peak_14129       519
#>      ...      ...               ...    ... .         ...       ...
#>   [4284]     Chr5 26937822-26938526      * |  peak_18408       445
#>   [4285]     Chr5 26939152-26939267      * |  peak_18409        21
#>   [4286]     Chr5 26949581-26950335      * |  peak_18410       263
#>   [4287]     Chr5 26952230-26952558      * |  peak_18411        30
#>   [4288]     Chr5 26968877-26969091      * |  peak_18412        26
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

## 2.1 annotate peak using nearest mode

The nearest mode is the most widely used annotation mode. It will link the peak
to its nearest gene, which means every peak only have one related gene. The
disadvantage is sometimes you can not link the correct gene for your peak because
of the complexity in the genomic feature. But this annotation mode is simple
enough and at most time, for most peak, the result is correct.
The skeleton function is `distanceToNearest` from `GenomicRanges`. I add some
modification so that it will output more human readable result.

```
mmAnno_nearestgene <- mm_nearestGene(peak_GR = ChIP_peak_GR,
                                     Txdb = Txdb)
#> >> checking seqlevels match...       2025-10-29 23:58:20
#> >> your peak_GR seqlevel:Chr5...
#> >> your Txdb seqlevel:Chr1 Chr2 Chr3 Chr4 Chr5 M C...
#> Good, your Chrs in peak_GR is all in Txdb
#> ------------
#> annotating Peak using nearest gene mode begins
#> >> preparing gene features information...        2025-10-29 23:58:20
#> >> finding nearest gene and calculating distance...      2025-10-29 23:58:20
#> >> dealing with gene strand ...      2025-10-29 23:58:20
#> >> merging all info together ...     2025-10-29 23:58:20
#> >> done      2025-10-29 23:58:20

mmAnno_nearestgene
#> GRanges object with 4288 ranges and 4 metadata columns:
#>          seqnames            ranges strand |  feature_id     score     gene_id
#>             <Rle>         <IRanges>  <Rle> | <character> <numeric> <character>
#>      [1]     Chr5         6236-6508      * |  peak_14125        27   AT5G01015
#>      [2]     Chr5         7627-8237      * |  peak_14126        51   AT5G01020
#>      [3]     Chr5        9730-10211      * |  peak_14127        32   AT5G01030
#>      [4]     Chr5       12693-12867      * |  peak_14128        22   AT5G01030
#>      [5]     Chr5       13168-14770      * |  peak_14129       519   AT5G01040
#>      ...      ...               ...    ... .         ...       ...         ...
#>   [4284]     Chr5 26937822-26938526      * |  peak_18408       445   AT5G67510
#>   [4285]     Chr5 26939152-26939267      * |  peak_18409        21   AT5G67520
#>   [4286]     Chr5 26949581-26950335      * |  peak_18410       263   AT5G67560
#>   [4287]     Chr5 26952230-26952558      * |  peak_18411        30   AT5G67570
#>   [4288]     Chr5 26968877-26969091      * |  peak_18412        26   AT5G67630
#>          distanceToTSS
#>              <numeric>
#>      [1]          -344
#>      [2]           206
#>      [3]             0
#>      [4]          2823
#>      [5]          1402
#>      ...           ...
#>   [4284]             0
#>   [4285]             0
#>   [4286]             0
#>   [4287]             0
#>   [4288]           302
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

You can also use this the annotation result to check your TF type using
`plot_annoDistance`. For most TF, the distance density plot maybe like below,
which means your TF is promoter-type. But for some TF, its density plot will be
different, like GATA4, MYOD1(Li et al. [2019](#ref-li_cistromego_2019)).

```
plot_annoDistance(mmAnno = mmAnno_nearestgene)
```

![](data:image/png;base64...)

Sometimes, you may interested in the number peaks of each gene linked. Or
reciprocally, how many genes of each peak link. you can use the
`getAssocPairNumber` to see the deatailed number or summary.

```
getAssocPairNumber(mmAnno = mmAnno_nearestgene)
#> # A tibble: 2,757 × 2
#>    gene_id   peakNumber
#>    <chr>          <int>
#>  1 AT5G01015          1
#>  2 AT5G01020          1
#>  3 AT5G01030          2
#>  4 AT5G01040          2
#>  5 AT5G01050          2
#>  6 AT5G01070          1
#>  7 AT5G01090          1
#>  8 AT5G01100          1
#>  9 AT5G01170          1
#> 10 AT5G01175          3
#> # ℹ 2,747 more rows

getAssocPairNumber(mmAnno = mmAnno_nearestgene,
                   output_summary = TRUE)
#> # A tibble: 8 × 2
#>   N     gene_freq
#>   <fct>     <int>
#> 1 1          1793
#> 2 2           606
#> 3 3           229
#> 4 4            75
#> 5 5            38
#> 6 6             9
#> 7 7             4
#> 8 >=8           3

# you can see all peak's related gene number is 1 because I use the nearest gene mode
getAssocPairNumber(mmAnno_nearestgene, output_type = "feature_id")
#> # A tibble: 4,288 × 2
#>    feature_id geneNumber
#>    <chr>           <int>
#>  1 peak_14125          1
#>  2 peak_14126          1
#>  3 peak_14127          1
#>  4 peak_14128          1
#>  5 peak_14129          1
#>  6 peak_14130          1
#>  7 peak_14131          1
#>  8 peak_14132          1
#>  9 peak_14133          1
#> 10 peak_14134          1
#> # ℹ 4,278 more rows

getAssocPairNumber(mmAnno = mmAnno_nearestgene,
                   output_type = "feature_id",
                   output_summary = TRUE)
#> # A tibble: 1 × 2
#>   N     feature_freq
#>   <fct>        <int>
#> 1 1             4288
```

And if you want the summary plot, you can use the `plot_peakGeneAlias_summary`
function.

```
plot_peakGeneAlias_summary(mmAnno_nearestgene)
```

![](data:image/png;base64...)

```
plot_peakGeneAlias_summary(mmAnno_nearestgene, output_type = "feature_id")
```

![](data:image/png;base64...)

## 2.2 find realted peak using gene Bound mode

The `mm_geneBound` function is designed for finding related peak for your
`input_genes`.Because we do the nearest gene mode to annotate peak, once a peak
is linked by nearest gene, it will not be linked by another gene even if another
gene is very close to your peak. So this function is very useful when you want
to plot peak heatmap or volcano plot. When ploting these plot, you often have a
interesting gene set, and want to plot related peak. If we just filter gene id
in the nearest result,many of your interesting gene will not have related peak.
After all, each peak will be assigned once.

For `mm_geneBound`, it will output realted peak for all your `input_gene` as long
as your `input_genes` in your Txdb. The model behind `mm_geneBound` is simple, it
will do `mm_nearestgene` first and scan nearest peak for these genes which do not
have related peak.

```
# The genes_Chr5 is all gene set in Chr5
genes_Chr5 <- names(all_geneSet[seqnames(all_geneSet) == "Chr5"])

# The genes_Chr5_notAnno is gene set which is not linked by peak
genes_Chr5_notAnno <- genes_Chr5[!genes_Chr5 %in% unique(mmAnno_nearestgene$gene_id)]

# The genes_Chr5_tAnno is gene set which is linked by peak
genes_Chr5_Anno <- unique(mmAnno_nearestgene$gene_id)

# mm_geneBound will tell you there 5 genes in your input_genes not be annotated
# and it will use the distanceToNearest to find nearest peak of these genes
mmAnno_geneBound <- mm_geneBound(peak_GR = ChIP_peak_GR,
                                 Txdb = Txdb,
                                 input_genes = c(genes_Chr5_Anno[1:5], genes_Chr5_notAnno[1:5]))
#> >> checking seqlevels match...       2025-10-29 23:58:23
#> >> your peak_GR seqlevel:Chr5...
#> >> your Txdb seqlevel:Chr1 Chr2 Chr3 Chr4 Chr5 M C...
#> Good, your Chrs in peak_GR is all in Txdb
#> >> using mm_nearestGene to annotate Peak...      2025-10-29 23:58:23
#> >> checking seqlevels match...       2025-10-29 23:58:23
#> >> your peak_GR seqlevel:Chr5...
#> >> your Txdb seqlevel:Chr1 Chr2 Chr3 Chr4 Chr5 M C...
#> Good, your Chrs in peak_GR is all in Txdb
#> ------------
#> annotating Peak using nearest gene mode begins
#> >> preparing gene features information...        2025-10-29 23:58:23
#> >> finding nearest gene and calculating distance...      2025-10-29 23:58:24
#> >> dealing with gene strand ...      2025-10-29 23:58:24
#> >> merging all info together ...     2025-10-29 23:58:24
#> >> done      2025-10-29 23:58:24
#> It seems that there 5 genes have not been annotated by nearestGene mode
#> >> using distanceToNearest to find nearest peak of these genes...        2025-10-29 23:58:25
#> >> merging all anno...       2025-10-29 23:58:25
#> >> done      2025-10-29 23:58:25

# all of your input_genes have related peaks
mmAnno_geneBound
#> # A tibble: 13 × 3
#>    feature_id gene_id   distanceToTSS_abs
#>    <chr>      <chr>                 <dbl>
#>  1 peak_14125 AT5G01015               344
#>  2 peak_14126 AT5G01020               206
#>  3 peak_14127 AT5G01030                 0
#>  4 peak_14128 AT5G01030              2823
#>  5 peak_14129 AT5G01040              1402
#>  6 peak_14130 AT5G01040                 0
#>  7 peak_14131 AT5G01050               571
#>  8 peak_14132 AT5G01050                94
#>  9 peak_14125 AT5G01010              1174
#> 10 peak_14132 AT5G01060              2022
#> 11 peak_14133 AT5G01075               949
#> 12 peak_14134 AT5G01080              2339
#> 13 peak_14135 AT5G01110              6623
```

## 2.3 find related peak using gene scan mode

`mm_geneScan` is the most important annotation mode. Strictly, it is not a peak
annotation mode. The function will define a TSS scan region for each gene
according to your upstream and downstream parameters. Then it will fish all peaks
located in scan region and link gene with peak scaned. For these peak not
locating in the scan region, it will use the `distanceToNearest` to find nearest
gene. After these steps, each peak will have at least one gene. But not all genes
on your Txdb will have at least one peak, after all, there maybe no peak locating
in scan region for these gene. Now, compared with `mm_nearestgene` result, gene
may be linked by more than one peak, and peak maybe linked by more than one gene.

The `mm_geneScan` can be used in many conditions. For example, after differential
peak analysis, you may have 300 diff peaks. Or if your ChIP-Seq peak experiment
not work very well, you only have 100 peaks. You do not want to use the
`mm_nearestgene` because you do not want to lose some important candidate gene
and you also do not want to see each peak in IGV. Now you can use `mm_geneScan`,
just set parameters like `upstream=500` , everything will be different. This
function is especially useful for small genome because the complexity in genomic
feature location. Expect the origin nearest mode result, the final result will
output other peak-gene links.

But I do not recommend you use the `mm_geneScan` mode or set
`upstream/downstream` to big when you have too many peaks, it will make your
final result messy. For this condition, you can use the `mm_nearestgene` or set
`upstream/downstream` small.

The true power of `mm_geneScan` is that it is the foundation of other module,
like `calcRP`, `FindIT`. And in these condition, the upstream and downstream
parameter should be set big, like 2e4, 2e5, 2e6 and so on.

```
mmAnno_geneScan <- mm_geneScan(peak_GR = ChIP_peak_GR,
                               Txdb = Txdb,
                               upstream = 2e4,
                               downstream = 2e4)
#> >> checking seqlevels match...       2025-10-29 23:58:25
#> >> your peak_GR seqlevel:Chr5...
#> >> your Txdb seqlevel:Chr1 Chr2 Chr3 Chr4 Chr5 M C...
#> Good, your Chrs in peak_GR is all in Txdb
#> ------------
#> annotatePeak using geneScan mode begins
#> >> preparing gene features information and scan region...        2025-10-29 23:58:25
#> >> some scan range may cross Chr bound, trimming...      2025-10-29 23:58:25
#> >> finding overlap peak in gene scan region...       2025-10-29 23:58:25
#> >> dealing with left peak not your gene scan region...       2025-10-29 23:58:25
#> >> merging two set peaks...      2025-10-29 23:58:25
#> >> calculating distance and dealing with gene strand...      2025-10-29 23:58:26
#> >> merging all info together ...     2025-10-29 23:58:26
#> >> done      2025-10-29 23:58:26

mmAnno_geneScan
#> GRanges object with 50662 ranges and 4 metadata columns:
#>           seqnames            ranges strand |  feature_id     score     gene_id
#>              <Rle>         <IRanges>  <Rle> | <character> <numeric> <character>
#>       [1]     Chr5         6236-6508      * |  peak_14125        27   AT5G01010
#>       [2]     Chr5         7627-8237      * |  peak_14126        51   AT5G01010
#>       [3]     Chr5        9730-10211      * |  peak_14127        32   AT5G01010
#>       [4]     Chr5       12693-12867      * |  peak_14128        22   AT5G01010
#>       [5]     Chr5       13168-14770      * |  peak_14129       519   AT5G01010
#>       ...      ...               ...    ... .         ...       ...         ...
#>   [50658]     Chr5 26949581-26950335      * |  peak_18410       263   AT5G67630
#>   [50659]     Chr5 26952230-26952558      * |  peak_18411        30   AT5G67630
#>   [50660]     Chr5 26968877-26969091      * |  peak_18412        26   AT5G67630
#>   [50661]     Chr5 26952230-26952558      * |  peak_18411        30   AT5G67640
#>   [50662]     Chr5 26968877-26969091      * |  peak_18412        26   AT5G67640
#>           distanceToTSS
#>               <numeric>
#>       [1]         -1174
#>       [2]         -2565
#>       [3]         -4668
#>       [4]         -7631
#>       [5]         -8106
#>       ...           ...
#>   [50658]         19058
#>   [50659]         16835
#>   [50660]           302
#>   [50661]         18082
#>   [50662]          1549
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

you can also apply below function in the result of `mm_geneScan`.

```
getAssocPairNumber(mmAnno_geneScan)
#> # A tibble: 6,783 × 2
#>    gene_id   peakNumber
#>    <chr>          <int>
#>  1 AT5G01010          8
#>  2 AT5G01015          8
#>  3 AT5G01020          9
#>  4 AT5G01030          9
#>  5 AT5G01040         10
#>  6 AT5G01050         11
#>  7 AT5G01060         11
#>  8 AT5G01070         11
#>  9 AT5G01075         10
#> 10 AT5G01080          9
#> # ℹ 6,773 more rows

getAssocPairNumber(mmAnno_geneScan, output_type = "feature_id")
#> # A tibble: 4,288 × 2
#>    feature_id geneNumber
#>    <chr>           <int>
#>  1 peak_14125          8
#>  2 peak_14126          9
#>  3 peak_14127         10
#>  4 peak_14128         11
#>  5 peak_14129         11
#>  6 peak_14130         11
#>  7 peak_14131         12
#>  8 peak_14132         12
#>  9 peak_14133         12
#> 10 peak_14134         12
#> # ℹ 4,278 more rows
```

```
plot_peakGeneAlias_summary(mmAnno_geneScan)
```

![](data:image/png;base64...)

```
plot_peakGeneAlias_summary(mmAnno_geneScan, output_type = "feature_id")
```

![](data:image/png;base64...)

# 3 Calculate regulation potential(RP)

regulation potential(RP) is a simple but powerful theory to convert peak level
information into gene level. After this transform, analysis will be much easier.
After all, peak do not have id while gene have. The detailed theory about RP can
be seen in (Wang et al. [2016](#ref-wang_modeling_2016)), (Li et al. [2019](#ref-li_cistromego_2019)), (Qin et al. [2020](#ref-qin_lisa_2020)).

The object you may need:

* **mmAnno: the result from mm\_geneScan**

The upstream/downstream parameters of `mm_geneScan` should be big enough. The RP
model actually consider all peaks in TSS scan region. And each peak will be
assigned a weight when calculating final RP. The weight decreases with peak
distance from the TSS of gene. For Arabidopsis thaliana, I set the parameter is
2e4. Because it is the longest interaction distance in HiC
data(Liu et al. [2016](#ref-liu_genomewide_2016)). For human or mouse data, you can set 100kb(1e5). It
is the origin parameters in paper.

Actually, the upstream/downstream parameters can be arbitrary because it only
influence the number of scaned peak. The another important parameter is
`decay_dist`, which control the weight of peak. If you set `decay_dist` to 1000,
a peak 1kb from the TSS contribute one-half of that at TSS. For example, if a
value of peak is 100, and its distance to TSS is 1000, so the final value
contributing to the gene will be `100 * 2 ^ -(1000 / 1000) = 50`.

* **Txdb**

## 3.1 calculate RP using mmAnno

The `calcRP_TFHit` here is to calculate RP according to your TF ChIP-seq
annotation result. The theory behind this is that if there are more peaks near
your gene, then your gene is more likely to be the target. You can use the
result to decide your TF target gene or combine with RNA-Seq data using `integrate_ChIP_RNA`
to infer direct target genes more accurately.

The object you may need to consider:

* decay\_dist:

You can set decay\_dist to 1000 for promoter-type TF and 10 kb for enhancer-type
TF. But you can set the decay\_dist by yourself. You can use the plot from
`plot_annoDistance(mmAnno_nearestgene)` to decide your TF type.

* mmAnno

The result from `mm_geneScan`. `calcRP_TFHit` will use the peak-gene pair in
mmAnno to calculate the contribution of each peak to the final RP of the gene.

The detailed formula used in `calcRP_TFHit` shows below.

\[
\begin{equation}
RP\_{gene\_{g}}=\sum\_{p=1}^{k}RP\_{peak\_p, gene\_g}
\tag{1}
\end{equation}
\]

\[
\begin{equation}
RP\_{peak\_p, gene\_g} = score\_{peak\_p} \* 2^{\frac{-d\_{i}}{d\_0}}
\tag{2}
\end{equation}
\]

The parameter \(d\_0\) is the half\_decay distance(`decay_dist`).
All k binding sites in the scan region of gene g(within the
upstram-TSS-downstream) will be used in the calculation, \(d\_i\) is the distance
between the ith peak’s center and TSS. The \(score\_{peak\_{p}}\) represent your
`feature_score` column if your origin GRange have a column named
`feature_score`, otherwise, it will be 1.

The `feature_score` always be the fifth column in bed file and maybe the second
column in your GRange metadata column.

```
# Here you can see the score column in metadata
ChIP_peak_GR
#> GRanges object with 4288 ranges and 2 metadata columns:
#>          seqnames            ranges strand |  feature_id     score
#>             <Rle>         <IRanges>  <Rle> | <character> <numeric>
#>      [1]     Chr5         6236-6508      * |  peak_14125        27
#>      [2]     Chr5         7627-8237      * |  peak_14126        51
#>      [3]     Chr5        9730-10211      * |  peak_14127        32
#>      [4]     Chr5       12693-12867      * |  peak_14128        22
#>      [5]     Chr5       13168-14770      * |  peak_14129       519
#>      ...      ...               ...    ... .         ...       ...
#>   [4284]     Chr5 26937822-26938526      * |  peak_18408       445
#>   [4285]     Chr5 26939152-26939267      * |  peak_18409        21
#>   [4286]     Chr5 26949581-26950335      * |  peak_18410       263
#>   [4287]     Chr5 26952230-26952558      * |  peak_18411        30
#>   [4288]     Chr5 26968877-26969091      * |  peak_18412        26
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths

# I can rename it into feature_score
colnames(mcols(ChIP_peak_GR))[2] <- "feature_score"

ChIP_peak_GR
#> GRanges object with 4288 ranges and 2 metadata columns:
#>          seqnames            ranges strand |  feature_id feature_score
#>             <Rle>         <IRanges>  <Rle> | <character>     <numeric>
#>      [1]     Chr5         6236-6508      * |  peak_14125            27
#>      [2]     Chr5         7627-8237      * |  peak_14126            51
#>      [3]     Chr5        9730-10211      * |  peak_14127            32
#>      [4]     Chr5       12693-12867      * |  peak_14128            22
#>      [5]     Chr5       13168-14770      * |  peak_14129           519
#>      ...      ...               ...    ... .         ...           ...
#>   [4284]     Chr5 26937822-26938526      * |  peak_18408           445
#>   [4285]     Chr5 26939152-26939267      * |  peak_18409            21
#>   [4286]     Chr5 26949581-26950335      * |  peak_18410           263
#>   [4287]     Chr5 26952230-26952558      * |  peak_18411            30
#>   [4288]     Chr5 26968877-26969091      * |  peak_18412            26
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

For the normal ChIP-seq data, adding or not this column will not make much
difference to the result. Because peaks which are closer to the TSS always have
big feature\_score. But for those tag or GR-induced ChIP-seq data, the above
assumptions may not be satisfied. In this condition, you can add a column named `feature_score`
representing your confidence about each peak. And `feature_score`
in this situation may not be the second column in your GRange metadata column. You should decide it by yourself.

There are advantages and disadvantages to adding `feature_score`.
On the one hand, you can add your confidence to make the final TF target result
more credible. On the other hand, adding this column will make your result less
human-readable. And if you want to adjust your TF result considering the
background from batch existing ChIP-seq data to get the more accurate and
specific function of the TF. You should not add the `feature_score` column
because different scoure ChIP-Seq data have different bias(the background data
will be be ready soon).

```
# if you just want to get RP_df, you can set report_fullInfo FALSE
fullRP_hit <- calcRP_TFHit(mmAnno = mmAnno_geneScan,
                           Txdb = Txdb,
                           decay_dist = 1000,
                           report_fullInfo = TRUE)
#> >> calculating peakCenter to TSS using peak-gene pair...     2025-10-29 23:58:28
#> >> calculating RP using centerToTSS and TF hit       2025-10-29 23:58:28
#> >> merging all info together     2025-10-29 23:58:28
#> >> done      2025-10-29 23:58:28

# if you set report_fullInfo to TRUE, the result will be a GRange object
# it maintain the mmAnno_geneScan result and add other column, which represent
# the contribution of each peak to the final RP of the gene

fullRP_hit
#> GRanges object with 50662 ranges and 6 metadata columns:
#>           seqnames            ranges strand |  feature_id     score     gene_id
#>              <Rle>         <IRanges>  <Rle> | <character> <numeric> <character>
#>       [1]     Chr5         6236-6508      * |  peak_14125        27   AT5G01010
#>       [2]     Chr5         7627-8237      * |  peak_14126        51   AT5G01010
#>       [3]     Chr5        9730-10211      * |  peak_14127        32   AT5G01010
#>       [4]     Chr5       12693-12867      * |  peak_14128        22   AT5G01010
#>       [5]     Chr5       13168-14770      * |  peak_14129       519   AT5G01010
#>       ...      ...               ...    ... .         ...       ...         ...
#>   [50658]     Chr5 26949581-26950335      * |  peak_18410       263   AT5G67630
#>   [50659]     Chr5 26952230-26952558      * |  peak_18411        30   AT5G67630
#>   [50660]     Chr5 26968877-26969091      * |  peak_18412        26   AT5G67630
#>   [50661]     Chr5 26952230-26952558      * |  peak_18411        30   AT5G67640
#>   [50662]     Chr5 26968877-26969091      * |  peak_18412        26   AT5G67640
#>           distanceToTSS centerToTSS          RP
#>               <numeric>   <integer>   <numeric>
#>       [1]         -1174        1310  0.40332088
#>       [2]         -2565        2870  0.13678671
#>       [3]         -4668        4908  0.03330771
#>       [4]         -7631        7718  0.00474953
#>       [5]         -8106        8907  0.00208318
#>       ...           ...         ...         ...
#>   [50658]         19058       19435 1.41085e-06
#>   [50659]         16835       16999 7.63468e-06
#>   [50660]           302         409 7.53145e-01
#>   [50661]         18082       18246 3.21667e-06
#>   [50662]          1549        1656 3.17318e-01
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths

# or you can directly extract from metadata of your result
peakRP_gene <- metadata(fullRP_hit)$peakRP_gene

# The result is ordered by the sumRP and you can decide the target threshold by yourself
peakRP_gene
#> # A tibble: 6,783 × 4
#>    gene_id   withPeakN sumRP RP_rank
#>    <chr>         <int> <dbl>   <dbl>
#>  1 AT5G67190        14  4.31       1
#>  2 AT5G05140        25  3.56       2
#>  3 AT5G62280        12  3.51       3
#>  4 AT5G44380        10  3.38       4
#>  5 AT5G58750        13  3.36       5
#>  6 AT5G66590        13  3.36       6
#>  7 AT5G02760        12  3.24       7
#>  8 AT5G41071         8  3.23       8
#>  9 AT5G64100        18  3.21       9
#> 10 AT5G24030        12  3.19      10
#> # ℹ 6,773 more rows
```

## 3.2 Calculate RP using bw file

The `calcRP_coverage` here is to calculate RP based on the ATAC or other histone
modification bigwig file.

The object you may need to consider:

* bwFile:

A bigwig file. And if you want to compare gene RP between samples, the bigwig
file should be normalized.

* decay\_dist:

You can set 10kb for human/mouse data and set 1kb for Arabidopsis thaliana data.

* scan\_dist:

You can set 100kb for human/mouse data and set 20kb for Arabidopsis thaliana data.

* Chrs\_included:

The Chromosomes where you want to calculate gene RP in. Here I set Chr5 because
I only use the test data in Chr5. Sometimes, we just want to the calculate gene
RP in some chromosomes. For example, we do not want to calculate gene RP in
mitochondrion. The less chrom you select, the faster function calculates.

It can be applied in the condition that you just have bigwig files from GEO. The
purpose here is not to identify the target of TF ChIP-Seq. The real purpose is
to summarize the ATAC, H3K27ac, or other histone modification profiles and
convert into gene level information. The RP score can be a useful predictor of
gene expression changes and a summary representing histone modification in your
gene. You can compare gene RP in different samples and explore the RP trend. Or
you can use RP in the identification of key tissue-specific genes. The detailed
application can be seen in (Wang et al. [2016](#ref-wang_modeling_2016)).

The detailed formula used in `calcRP_coverage` is a little different from the
previous [(1)](#eq:formula1), [(2)](#eq:formula2).
\[
\begin{equation}
RP\_{gene\_{g}}=\sum\_{i\in[t\_g-L,tg+L]}w\_iS\_i
\tag{3}
\end{equation}
\]
\[
\begin{equation}
w\_i=\frac {2e^{-\mu d}} {1+e^{-\mu d}}
\tag{4}
\end{equation}
\]
\(L\) is set to `scan_dist`, and \(w\_i\) is a weight representing the regulatory
influence of a locus at position \(i\) on the TSS of gene \(g\) at genomic position
\(t\_k\). \(d = |i − t\_{g}|/L\), and \(i\) stands for ith nucleotide position within
the \([−L, L]\) genomic interval centered on the TSS at \(t\_g\). \(s\_i\) is the signal
of at position \(i\). μ is the parameter to determine the decay rate of the
weight, which is
defined as \(\mu = -ln\frac{1}{3} \* (L/\Delta)\). \(\Delta\) is set to `decay_dist`.

```
bwFile <- system.file("extdata", "E50h_sampleChr5.bw", package = "FindIT2")
RP_df <- calcRP_coverage(bwFile = bwFile,
                         Txdb = Txdb,
                         Chrs_included = "Chr5")
#> >> preparing gene features information...        2025-10-29 23:58:28
#> >> some scan range may cross Chr bound, trimming...      2025-10-29 23:58:29
#> >> preparing weight info...      2025-10-29 23:58:29
#> >> loading E50h_sampleChr5.bw info...        2025-10-29 23:58:29
#> ------------
#> >> extracting and calcluating Chr5 signal...     2025-10-29 23:58:29
#> >> dealing with Chr5 left gene signal...     2025-10-29 23:58:31
#> >> norming Chr5RP accoring to the whole Chr RP...        2025-10-29 23:58:31
#> >> merging all Chr RP together...        2025-10-29 23:58:31
#> >> done      2025-10-29 23:58:31

head(RP_df)
#>     gene_id      sumRP
#> 1 AT5G01050 -0.8437482
#> 2 AT5G01060  0.6576913
#> 3 AT5G01070  3.5641593
#> 4 AT5G01075  3.2401437
#> 5 AT5G01080  1.6852928
#> 6 AT5G01090 -1.3254554
```

## 3.3 Calculate RP using mmAnno result and peakScore matrix

The `calcRP_region` here is to calculate RP according to your ATAC peak file and
ATAC norm Count matrix.

The object you may need to consider:

* peak\_GR:

if you have several samples, it should be the merge peak set from these samples

* peakScoreMt:

the ATAC norm Count matrix. you can use different normalized ways to norm the
origin peak count matrix, like CPM, FPKM, quantile, DESeq2, edgeR and so on.

* Chrs\_included:

The Chromosomes where you want to calculate gene RP in. Here I set Chr5 because
I only use the test data in Chr5. It do not have a effect on the speed. If your
peak all on the Chr5, and I set Chrs\_included to Chr1 and Chr5, then all gene RP
in Chr1 will be filled with 0.

The calculation formula is same as [(1)](#eq:formula1), [(2)](#eq:formula2). But
it do not use the `feature_score` in peak\_GR. Instead, it will use the count in
`peakScoreMt`. THis is why the count matrix should be normalized firstly. The
class of `calcRP_region` result is a
[MultiAssayExperiment](https://bioconductor.org/packages/release/bioc/html/Mult%20AssayExperiment.html) object containing detailed peak-RP-gene relationship and
sumRP info. The `calcRP_region` result can be as the input of `findIT_regionRP`
to find the influential TF.

```
data("ATAC_normCount")

# This ATAC peak is the merge peak set from E50h-72h
ATAC_peak_path <- system.file("extdata", "ATAC.bed.gz", package = "FindIT2")
ATAC_peak_GR <- loadPeakFile(ATAC_peak_path)

mmAnno_regionRP <- mm_geneScan(ATAC_peak_GR,
                               Txdb,
                               upstream = 2e4,
                               downstream = 2e4)
#> >> checking seqlevels match...       2025-10-29 23:58:31
#> >> your peak_GR seqlevel:Chr5...
#> >> your Txdb seqlevel:Chr1 Chr2 Chr3 Chr4 Chr5 M C...
#> Good, your Chrs in peak_GR is all in Txdb
#> ------------
#> annotatePeak using geneScan mode begins
#> >> preparing gene features information and scan region...        2025-10-29 23:58:31
#> >> some scan range may cross Chr bound, trimming...      2025-10-29 23:58:32
#> >> finding overlap peak in gene scan region...       2025-10-29 23:58:32
#> >> dealing with left peak not your gene scan region...       2025-10-29 23:58:32
#> >> merging two set peaks...      2025-10-29 23:58:32
#> >> calculating distance and dealing with gene strand...      2025-10-29 23:58:32
#> >> merging all info together ...     2025-10-29 23:58:32
#> >> done      2025-10-29 23:58:32

# This ATAC_normCount is the peak count matrix normilzed by DESeq2
calcRP_region(mmAnno = mmAnno_regionRP,
              peakScoreMt = ATAC_normCount,
              Txdb = Txdb,
              Chrs_included = "Chr5") -> regionRP
#> >> calculating peakCenter to TSS using peak-gene pair...     2025-10-29 23:58:32
#> >> pre-filling 446 noAssoc peak gene's RP with 0...      2025-10-29 23:58:33
#> >> calculating RP using centerToTSS and peak score2025-10-29 23:58:33
#> >> merging all info together     2025-10-29 23:58:35
#> >> done      2025-10-29 23:58:35

# The sumRP is a matrix representing your geneRP in every samples
sumRP <- assays(regionRP)$sumRP
head(sumRP)
#>           E5_0h_R1 E5_0h_R2 E5_4h_R1 E5_4h_R2 E5_8h_R1 E5_8h_R2 E5_16h_R1
#> AT5G01010 222.2079 212.7673 218.1653 213.6052 249.9372 206.0400  254.9596
#> AT5G01015 208.7814 203.1862 203.0282 203.9045 224.0673 192.7383  240.3690
#> AT5G01020 433.2978 439.1758 414.0660 446.9142 370.8003 419.2071  507.6845
#> AT5G01030 417.1240 422.5180 395.8684 429.5824 349.7193 401.1142  486.7315
#> AT5G01040 398.0912 398.0977 321.6067 351.3717 243.5476 236.7626  367.2205
#> AT5G01050 269.0832 285.3329 117.0695 102.0756 109.3351 101.0077  135.9758
#>           E5_16h_R2 E5_24h_R1 E5_24h_R2 E5_48h_R1 E5_48h_R2 E5_48h_R3 E5_72h_R1
#> AT5G01010  294.6202  271.1531  262.5603  216.3946  214.0887  226.4749  183.1970
#> AT5G01015  270.5445  248.4688  241.9568  196.3324  194.7707  203.5344  168.8261
#> AT5G01020  524.0937  489.1091  473.2037  338.7931  370.7956  356.9675  332.7021
#> AT5G01030  499.3811  467.3236  452.1052  322.8229  353.5329  339.1584  320.1101
#> AT5G01040  342.5372  360.6502  355.6829  293.5963  295.9778  290.2336  379.6624
#> AT5G01050  139.9906  154.1518  129.9962  134.2388  113.4725  138.8942  161.2767
#>           E5_72h_R2 E5_72h_R3
#> AT5G01010  201.5551  232.2543
#> AT5G01015  188.3035  213.0661
#> AT5G01020  382.2974  405.6337
#> AT5G01030  366.3332  389.1395
#> AT5G01040  342.0031  381.4891
#> AT5G01050  174.7018  176.5979

# The fullRP is a detailed peak-RP-gene relationship
fullRP <- assays(regionRP)$fullRP
head(fullRP)
#>                             E5_0h_R1     E5_0h_R2     E5_4h_R1    E5_4h_R2
#> WFX_peak_19629:AT5G01010   3.2505507   2.94366371   4.91215176   3.2210557
#> WFX_peak_19630:AT5G01010  28.3673260  25.49941664  33.09901392  26.4569161
#> WFX_peak_19631:AT5G01010  11.3199591   8.66507551   7.69205730  10.1043687
#> WFX_peak_19632:AT5G01010 140.0066186 135.72131106 135.00039379 133.1331029
#> WFX_peak_19633:AT5G01010  38.7559482  39.48821374  37.10950497  40.2704327
#> WFX_peak_19634:AT5G01010   0.1620359   0.09696071   0.05939023   0.1040209
#>                              E5_8h_R1     E5_8h_R2   E5_16h_R1   E5_16h_R2
#> WFX_peak_19629:AT5G01010   4.63291194   3.40978941   3.4267032   5.0733396
#> WFX_peak_19630:AT5G01010  33.35699057  35.98214354  31.2959400  37.9690563
#> WFX_peak_19631:AT5G01010  10.00585368  10.17992743  15.1914895  20.1385141
#> WFX_peak_19632:AT5G01010 169.10492510 118.32576124 158.9697269 184.2512264
#> WFX_peak_19633:AT5G01010  32.53901650  37.84312560  45.6184227  46.7559771
#> WFX_peak_19634:AT5G01010   0.08068857   0.09220271   0.1290225   0.1258721
#>                            E5_24h_R1   E5_24h_R2   E5_48h_R1    E5_48h_R2
#> WFX_peak_19629:AT5G01010   4.7636561   3.6203395   3.1645878   3.61212739
#> WFX_peak_19630:AT5G01010  41.7795900  37.5422424  27.0006566  32.58453567
#> WFX_peak_19631:AT5G01010  16.1608755  14.0341872   8.6911928  13.21967538
#> WFX_peak_19632:AT5G01010 164.3433125 164.7184992 147.3949774 131.34350008
#> WFX_peak_19633:AT5G01010  43.6546465  42.2005830  29.7367518  32.99092356
#> WFX_peak_19634:AT5G01010   0.1348949   0.1294783   0.1536341   0.07837431
#>                             E5_48h_R3   E5_72h_R1    E5_72h_R2   E5_72h_R3
#> WFX_peak_19629:AT5G01010   3.44344427   2.7374503   2.61457722   2.6626243
#> WFX_peak_19630:AT5G01010  28.19522111  25.5527166  27.32943247  32.1836089
#> WFX_peak_19631:AT5G01010  17.57139155  11.1322592   9.29903999  13.0251325
#> WFX_peak_19632:AT5G01010 145.44860373 113.7699899 127.73896923 147.9226052
#> WFX_peak_19633:AT5G01010  31.46275054  29.5742561  34.19603669  35.9567241
#> WFX_peak_19634:AT5G01010   0.09615333   0.0841232   0.06690242   0.1683909
```

# 4 Find influential target

`integrate_ChIP_RNA` can combine ChIP-Seq with RNA-Seq data to find target gene
more accurately.

The object you may need:

* **result\_geneRP:**

The data.frame object representing target rank from `calcRP_TFHit`
(set`report_fullInfo=FALSE`) or `metadata(fullRP_hit)$peakRP_gene`.

* **result\_geneDiff:**

The RNA-Seq diff data.frame, it should be have three column:gene\_id,
log2FoldChange, padj.

Differential expression analysis result between TF perturbations (i.e.
stimulation, repression, knock-down or knockout) and controls is an alternative
approach for predicting TF targets. However, it is difficult to determine
whether the differentially expressed genes in such experiments are direct
targets of the TF using expression profile only. Therefore, ChIP-seq peaks
adding differential expression information upon TF perturbation could be used to
discriminate between directly regulated genes and secondary effects more accurately.

The theory behind `integrate_ChIP_RNA` is simple. It will firstly rank the diff
result according to the padj value then integrate the ChIP and RNA data using
the rank-product. If a gene is in the top rank of `calcRP_TFHit` and RNA-Seq,
then it will be the top target in final result. The `integrate_ChIP_RNA` will
also predict your TF function. It will divide genes into three groups according
to expression pattern, up-regulated, down-regulated or unchanged. The threshold
deciding groups is `lfc_threshold` and `padj_threshold` parameters.

```
data("RNADiff_LEC2_GR")
integrate_ChIP_RNA(result_geneRP = peakRP_gene,
                   result_geneDiff = RNADiff_LEC2_GR) -> merge_result

# you can see compared with down gene, there are more up gene on the top rank in ChIP-Seq data
# In the meanwhile, the number of down gene is less than up
merge_result
```

![](data:image/png;base64...)

```
# if you want to extract merge target data
target_result <- merge_result$data
target_result
#> # A tibble: 6,783 × 10
#>    gene_id   withPeakN sumRP RP_rank log2FoldChange      padj diff_rank
#>    <chr>         <int> <dbl>   <dbl>          <dbl>     <dbl>     <dbl>
#>  1 AT5G23370         9  2.84      23          3.56  2.33e- 46        12
#>  2 AT5G13910        11  2.30     140          4.20  1.36e- 85         2
#>  3 AT5G23350        10  1.68     525          3.20  1.34e-121         1
#>  4 AT5G23360        10  2.12     200          2.99  2.24e- 64         6
#>  5 AT5G52882        17  2.50      83          1.63  1.93e- 36        15
#>  6 AT5G05180        21  2.61      52          1.22  3.58e- 23        27
#>  7 AT5G11320         8  2.56      62          2.56  6.28e- 22        29
#>  8 AT5G02760        12  3.24       7          0.719 4.66e-  2       319
#>  9 AT5G55620         5  1.49     759          2.60  5.78e- 68         4
#> 10 AT5G60760        14  2.67      43          1.09  6.47e- 11        71
#> # ℹ 6,773 more rows
#> # ℹ 3 more variables: rankProduct <dbl>, rankOf_rankProduct <dbl>,
#> #   gene_category <fct>
```

# 5 Find influential TF

Find influential TF contains some function to help you find TF based on your
input or analysis type. You can find detailed case in each function section.

The object you may need

* **input\_genes: the gene set you want to find infulential TF for**
* **input\_feature\_id: the peak set you want to find infulential TF for**

The input\_feature\_id should be a part of the total peak set. You can use methods
such as kmeans or differential analysis to get the feature id set you are
interested in.

* **peak\_GR:a GRange object with a column named feature\_id**

The peak GRange can be from ATAC, H3K27ac, or some other histone modification
peak data which you believe TF hit in. `input_feature_id` should be a part of
this GRange’s feature id set.

* **TF\_GR\_database: a GRange object with a column named TF\_id**

The TF\_GR\_database can be from public TF database, or motif scan in ATAC/H3K27ac
data. If your data is from model species, like human/mouse or A. thaliana, there
are some wonderful public ChIP-Seq database, like
[cistrome](http://cistrome.org/db), [Remap](https://remap.univ-amu.fr/),
[unibind](https://unibind.uio.no/). For those species that do not have good
database, you can use motif scan tools like
[memesuite](https://meme-suite.org/meme/),
[HOMER](http://homer.ucsd.edu/homer/motif/),
[GimmeMotifs](https://gimmemotifs.readthedocs.io/en/stable/),
[motifmatchr](https://bioconductor.org/packages/release/bioc/html/motifmatchr.h%20ml) to find your motif location in your ATAC peak to represent TF occupy. And if
you do not have TF database or ATAC-Seq in hand, you can also try some other
database like [PLAZA](https://bioinformatics.psb.ugent.be/plaza/),
[plantTFDB](http://planttfdb.gao-lab.org/download.php), which use the
evolutionary conservation to find the motif occupy. But I do not recommend it,
it can not represent your sample specific TF occupy profile.

Regardless of whether you use public TF ChIP-Seq or motif scan result, all you
need to do is to import the bed file like above and rename one of column into
`TF_id`. The `TF_id` is same as `feature_id`, which always the forth column in
bed file and the first column in GRange metadata column. For `TF_GR_database`,
each site is not important, what is important is the set of sites represented by
each `TF_id`. The `TF_id` is important column when using findIT module, so
please make sure add correctly.

```
# Here I take the top50 gene from integrate_ChIP_RNA as my interesting gene set.
input_genes <- target_result$gene_id[1:50]

# I use mm_geneBound to find related peak, which I will take as my interesting peak set.
related_peaks <- mm_geneBound(peak_GR = ATAC_peak_GR,
                              Txdb = Txdb,
                              input_genes = input_genes)
#> >> checking seqlevels match...       2025-10-29 23:58:36
#> >> your peak_GR seqlevel:Chr5...
#> >> your Txdb seqlevel:Chr1 Chr2 Chr3 Chr4 Chr5 M C...
#> Good, your Chrs in peak_GR is all in Txdb
#> >> using mm_nearestGene to annotate Peak...      2025-10-29 23:58:36
#> >> checking seqlevels match...       2025-10-29 23:58:36
#> >> your peak_GR seqlevel:Chr5...
#> >> your Txdb seqlevel:Chr1 Chr2 Chr3 Chr4 Chr5 M C...
#> Good, your Chrs in peak_GR is all in Txdb
#> ------------
#> annotating Peak using nearest gene mode begins
#> >> preparing gene features information...        2025-10-29 23:58:36
#> >> finding nearest gene and calculating distance...      2025-10-29 23:58:37
#> >> dealing with gene strand ...      2025-10-29 23:58:38
#> >> merging all info together ...     2025-10-29 23:58:38
#> >> done      2025-10-29 23:58:38
#> It seems that there 7 genes have not been annotated by nearestGene mode
#> >> using distanceToNearest to find nearest peak of these genes...        2025-10-29 23:58:39
#> >> merging all anno...       2025-10-29 23:58:39
#> >> done      2025-10-29 23:58:39
input_feature_id <- unique(related_peaks$feature_id)

# AT1G28300 is LEC2 tair ID
# I add a column named TF_id into my ChIP Seq GR
ChIP_peak_GR$TF_id <- "AT1G28300"

# And I also add some other public ChIP-Seq data
TF_GR_database_path <- system.file("extdata", "TF_GR_database.bed.gz", package = "FindIT2")
TF_GR_database <- loadPeakFile(TF_GR_database_path)
TF_GR_database
#> GRanges object with 4223 ranges and 2 metadata columns:
#>          seqnames            ranges strand |  feature_id     score
#>             <Rle>         <IRanges>  <Rle> | <character> <numeric>
#>      [1]     Chr5        9865-10065      * |   AT3G59060         1
#>      [2]     Chr5       14244-14444      * |   AT2G36270         1
#>      [3]     Chr5       14911-15154      * |   AT2G36270         1
#>      [4]     Chr5       17037-17257      * |   AT3G59060         1
#>      [5]     Chr5       20654-21105      * |   AT2G36270         1
#>      ...      ...               ...    ... .         ...       ...
#>   [4219]     Chr5 26934932-26935211      * |   AT2G36270         1
#>   [4220]     Chr5 26938020-26938219      * |   AT5G24110         1
#>   [4221]     Chr5 26947440-26947615      * |   AT5G24110         1
#>   [4222]     Chr5 26949899-26950521      * |   AT3G59060         1
#>   [4223]     Chr5 26967024-26967348      * |   AT2G36270         1
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths

# rename feature_id column into TF_id
# because the true thing I am interested in is TF set, not each TF binding site.
colnames(mcols(TF_GR_database))[1] <- "TF_id"

# merge LEC2 ChIP GR
TF_GR_database <- c(TF_GR_database, ChIP_peak_GR)

TF_GR_database
#> GRanges object with 8511 ranges and 4 metadata columns:
#>          seqnames            ranges strand |       TF_id     score  feature_id
#>             <Rle>         <IRanges>  <Rle> | <character> <numeric> <character>
#>      [1]     Chr5        9865-10065      * |   AT3G59060         1        <NA>
#>      [2]     Chr5       14244-14444      * |   AT2G36270         1        <NA>
#>      [3]     Chr5       14911-15154      * |   AT2G36270         1        <NA>
#>      [4]     Chr5       17037-17257      * |   AT3G59060         1        <NA>
#>      [5]     Chr5       20654-21105      * |   AT2G36270         1        <NA>
#>      ...      ...               ...    ... .         ...       ...         ...
#>   [8507]     Chr5 26937822-26938526      * |   AT1G28300        NA  peak_18408
#>   [8508]     Chr5 26939152-26939267      * |   AT1G28300        NA  peak_18409
#>   [8509]     Chr5 26949581-26950335      * |   AT1G28300        NA  peak_18410
#>   [8510]     Chr5 26952230-26952558      * |   AT1G28300        NA  peak_18411
#>   [8511]     Chr5 26968877-26969091      * |   AT1G28300        NA  peak_18412
#>          feature_score
#>              <numeric>
#>      [1]            NA
#>      [2]            NA
#>      [3]            NA
#>      [4]            NA
#>      [5]            NA
#>      ...           ...
#>   [8507]           445
#>   [8508]            21
#>   [8509]           263
#>   [8510]            30
#>   [8511]            26
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

## 5.1 Find IT of input peak based on wilcox test

Compared with background peak, if TF in `input_feature_id` has more TF hit, this
TF may be important in your `input_feature_id`.

If your `TF_GR_database` is from motif scan result and have a column named `TF_score`, `findIT_enrichWilcox` will consider it to improve the accuracy. The `TF_score` always be the fifth column in your motif scan bed file and it represent your motif hit confidence in the location.

Here is the example bed output from `gimmeMotif scan`. The fifth column can be
treated as `TF_score`. You can directly load this bed file and rename or add meta column
just like `feature_score` before.

```
Chr1    2982    2989    MA0982.1_DOF2.4 5.817207239414311       +
Chr1    3085    3097    MA1044.1_NAC92  8.87118934508003        -
Chr1    3146    3165    MA1062.2_TCP15  7.842209471388505       +
Chr1    3146    3165    MA1065.2_TCP20  7.86289776912883        +
```

```
findIT_enrichWilcox(input_feature_id = input_feature_id,
                    peak_GR = ATAC_peak_GR,
                    TF_GR_database = TF_GR_database) -> result_enrichWilcox

# you can see AT1G28300 is top1
result_enrichWilcox
#> # A tibble: 4 × 7
#>   TF_id    input_meanMotifScore bg_meanMotifScore   pvalue     padj qvalue  rank
#>   <chr>                   <dbl>             <dbl>    <dbl>    <dbl> <lgl>  <dbl>
#> 1 AT1G283…               1.22              0.491  7.88e-18 3.15e-17 NA         1
#> 2 AT2G362…               0.494             0.293  2.95e- 3 8.85e- 3 NA         2
#> 3 AT3G590…               0.338             0.251  3.83e- 2 7.65e- 2 NA         3
#> 4 AT5G241…               0.0130            0.0357 8.50e- 1 8.50e- 1 NA         4
```

## 5.2 Find IT of input peak based on fisher test

You can also find the enrichment of TF using `findIT_enrichFisher`, it use the
same theory like GO-enrich analysis. The background is total ATAC peak, and the
select set is your `input_feature_id`. Compared with `findIT_enrichWilcox`
above, its runs more quickly. But it will have a little problem when using
motif scan result as `TF_GR_database`. A TF may hit more than one time in a
peak, however, here I treat it as one because I want the whole frame to be
more like GO enrichment analysis. Actually, the TF hit number can offer some
other useful information, which you can see in `findIT_MARA`. But it will do
not have a big effect on the final result. After all, what we really need is TF rank instead of p-value.

```
findIT_enrichFisher(input_feature_id = input_feature_id,
                   peak_GR = ATAC_peak_GR,
                   TF_GR_database = TF_GR_database) -> result_enrichFisher

# you can see AT1G28300 is top1
result_enrichFisher
#> # A tibble: 4 × 9
#>   TF_id   num_TFHit_inputFeature inputRatio bgRatio   pvalue odds_ratio     padj
#>   <chr>                    <int> <chr>      <chr>      <dbl>      <dbl>    <dbl>
#> 1 AT1G28…                     64 64/77      2486/5… 1.15e-13      6.91  4.61e-13
#> 2 AT2G36…                     30 30/77      1605/5… 1.59e- 2      1.72  4.76e- 2
#> 3 AT3G59…                     24 24/77      1332/5… 5.02e- 2      1.56  1.00e- 1
#> 4 AT5G24…                      1 1/77       190/59… 9.21e- 1      0.392 9.21e- 1
#> # ℹ 2 more variables: qvalue <lgl>, rank <dbl>
```

In the meanwhile, you can parse your result using `jaccard_findIT_enrichFisher`,
which can help you find co-occupy TF in your `input_feature_id`. But please note
you should not input too much TF\_id in `input_TF_id` because it will run slowly.
You can use the top rank gene as `input_TF_id`.

```
# Here I use the top 4 TF id to calculate jaccard similarity of TF
jaccard_findIT_enrichFisher(input_feature_id = input_feature_id,
                           peak_GR = ATAC_peak_GR,
                           TF_GR_database = TF_GR_database,
                           input_TF_id = result_enrichFisher$TF_id[1:4]) -> enrichAll_jaccard

# it report the jaccard similarity of TF you input

# but here I make the TF's own jaccard similarity 0, which is useful for heatmap
# If you want to convert it to 1, you can just use
# diag(enrichAll_jaccard) <- 1

enrichAll_jaccard
#>           AT1G28300 AT2G36270 AT3G59060 AT5G24110
#> AT1G28300 0.0000000 0.4242424 0.3750000  0.015625
#> AT2G36270 0.4242424 0.0000000 0.2857143  0.000000
#> AT3G59060 0.3750000 0.2857143 0.0000000  0.000000
#> AT5G24110 0.0156250 0.0000000 0.0000000  0.000000
```

## 5.3 Find IT of input genes based on fisher test

The `findIT_TTPair` also use the fisher test like `findIT_enrichFisher`. The
difference is your input set is gene id instead of feature id. And it means that
your database should be the `TF_target_database` like this.

```
data("TF_target_database")

# it should have two column named TF_id and target_gene.
head(TF_target_database)
#>       TF_id target_gene
#> 1 AT1G28300   AT1G50650
#> 2 AT3G23250   AT2G05940
#> 3 AT1G28300   AT4G01720
#> 4 AT5G24110   AT4G04540
#> 5 AT3G23250   AT5G36925
#> 6 AT5G24110   AT5G41750
```

This function is very useful when you have a interesting gene set producing from
some analysis like k-means in RNA-Seq data, WGCNA, single cell analysis. The
test `TF_target_database` here is downloaded from
[iGRN](http://bioinformatics.psb.ugent.be/webtools/iGRN/pages/download).

```
# By default, TTpair will consider all target gene as background
# Because I just use part of true TF_target_database, the background calculation
# is not correct.
# so I use all gene in Txdb as gene_background.

result_TTpair <- findIT_TTPair(input_genes = input_genes,
                               TF_target_database = TF_target_database,
                               gene_background = names(all_geneSet))

# you can see AT1G28300 is top1
result_TTpair
#> # A tibble: 3 × 9
#>   TF_id     num_TFHit_input inputRatio bgRatio  pvalue odds_ratio    padj qvalue
#>   <chr>               <int> <chr>      <chr>     <dbl>      <dbl>   <dbl> <lgl>
#> 1 AT1G28300              14 14/50      1950/3… 6.08e-7       6.35 1.82e-6 NA
#> 2 AT3G23250              11 11/50      2781/3… 2.22e-3       3.13 4.44e-3 NA
#> 3 AT5G24110               6 6/50       2275/3… 1.20e-1       1.88 1.20e-1 NA
#> # ℹ 1 more variable: rank <dbl>
```

You can parse your result\_TT using `jaccard_findIT_TTpair`.

```
# Here I use the all TF_id because I just have three TF in result_TTpair
# For you, you can select top N TF_id as input_TF_id
jaccard_findIT_TTpair(input_genes = input_genes,
                      TF_target_database = TF_target_database,
                      input_TF_id = result_TTpair$TF_id) -> TTpair_jaccard

# Here I make the TF's own jaccard similarity 0, which is useful for heatmap
# If you want to convert it to 1, you can just use
# diag(TTpair_jaccard) <- 1
TTpair_jaccard
#>           AT1G28300 AT3G23250 AT5G24110
#> AT1G28300 0.0000000 0.1363636 0.1111111
#> AT3G23250 0.1363636 0.0000000 0.1333333
#> AT5G24110 0.1111111 0.1333333 0.0000000
```

## 5.4 Find IT of input genes based on TF hit

Even though `findIT_TTpaior` is a very useful tool for finding TF when you have
a interesting gene set. But for most species, it do not have a database like
`TF_target_database`, so I write `findIT_TFHit`. You can think it run
`calcRP_TFhit` for each TF in your `TF_GR_database`. Compared with background
gene, the TF have a effect on your `input_genes` will produce more significant
p-value.

```
# For repeatability of results, you should set seed.
set.seed(20160806)

# the meaning of scan_dist and decay_dist is same as calcRP_TFHit
# the Chrs_included control the chromosome your background in
# the background_number control the number of background gene

# If you want to compare the TF enrichment in your input_genes with other gene set
# you can input other gene set id into background_genes
result_TFHit <- findIT_TFHit(input_genes = input_genes,
                             Txdb = Txdb,
                             TF_GR_database = TF_GR_database,
                             scan_dist = 2e4,
                             decay_dist = 1e3,
                             Chrs_included = "Chr5",
                             background_number = 3000)
#> >> preparing gene features information...        2025-10-29 23:58:40
#> >> some scan range may cross Chr bound, trimming...      2025-10-29 23:58:40
#> >> calculating p-value for each TF, which may be time consuming...       2025-10-29 23:58:40
#> >> merging all info together...      2025-10-29 23:58:40
#> >> done      2025-10-29 23:58:40

# you can see AT1G28300 is top1
result_TFHit
#> # A tibble: 4 × 7
#>   TF_id     mean_value TFPeak_number   pvalue     padj qvalue  rank
#>   <chr>          <dbl>         <dbl>    <dbl>    <dbl> <lgl>  <dbl>
#> 1 AT1G28300     1.88            4288 1.40e-30 5.58e-30 NA         1
#> 2 AT2G36270     0.268           1987 7.84e- 5 2.35e- 4 NA         2
#> 3 AT3G59060     0.172           1712 1.82e- 4 3.65e- 4 NA         3
#> 4 AT5G24110     0.0324           524 7.74e- 2 7.74e- 2 NA         4
```

## 5.5 Find IT of input genes based on region RP

Do you remember the `regionRP` we calculated earlier in (section [3.3](#RP)?) Now
we use the result to find TF for your input\_genes. Compared with `findIT_TFHit`,
it use the RP information and calculate each TF influence on each input\_genes,
and then compare the influence distribution of input genes with background
genes. The advantage of `findIT_regionRP` is that it it provides richer
information for user. The theory behind of `findIT_regionRP` is from
[lisa](https://github.com/AllenWLynch/lisa).

```
# For repeatability of results, you should set seed.
set.seed(20160806)
result_findIT_regionRP <- findIT_regionRP(regionRP = regionRP,
                                          Txdb = Txdb,
                                          TF_GR_database = TF_GR_database,
                                          input_genes = input_genes,
                                          background_number = 3000)
#> >> extracting RP info from regionRP...       2025-10-29 23:58:41
#> >> dealing with TF_GR_databse...     2025-10-29 23:58:41
#> >> calculating percent and p-value...        2025-10-29 23:58:41
#> >> dealing withE5_0h_R1...       2025-10-29 23:58:41
#> >> dealing withE5_0h_R2...       2025-10-29 23:58:41
#> >> dealing withE5_4h_R1...       2025-10-29 23:58:41
#> >> dealing withE5_4h_R2...       2025-10-29 23:58:42
#> >> dealing withE5_8h_R1...       2025-10-29 23:58:42
#> >> dealing withE5_8h_R2...       2025-10-29 23:58:42
#> >> dealing withE5_16h_R1...      2025-10-29 23:58:42
#> >> dealing withE5_16h_R2...      2025-10-29 23:58:42
#> >> dealing withE5_24h_R1...      2025-10-29 23:58:42
#> >> dealing withE5_24h_R2...      2025-10-29 23:58:43
#> >> dealing withE5_48h_R1...      2025-10-29 23:58:43
#> >> dealing withE5_48h_R2...      2025-10-29 23:58:43
#> >> dealing withE5_48h_R3...      2025-10-29 23:58:43
#> >> dealing withE5_72h_R1...      2025-10-29 23:58:43
#> >> dealing withE5_72h_R2...      2025-10-29 23:58:43
#> >> dealing withE5_72h_R3...      2025-10-29 23:58:44
#> >> merging all info together...      2025-10-29 23:58:44
#> >> done      2025-10-29 23:58:44

# The result object of findIT_regionRP is MultiAssayExperiment, same as calcRP_region
# TF_percentMean is the mean influence of TF on input genes minus background,
# which represent the total influence of specific TF on your input genes
TF_percentMean <- assays(result_findIT_regionRP)$TF_percentMean
TF_pvalue <- assays(result_findIT_regionRP)$TF_pvalue
```

The true power of `findIT_regionRP` is that it provide multidimensional data:
gene\_id, TF\_id, feature\_id and sample\_id. You can fold, unfold and combine with
them in different ways.

* **row is TF\_id，column is sample\_id，the value in matrix is TF percentMean**

In this condition, we can see the each TF total influence trend on input genes
set between samples

```
TF_percentMean
#>              E5_0h_R1    E5_0h_R2     E5_4h_R1     E5_4h_R2     E5_8h_R1
#> AT3G59060  0.09925941  0.09712202  0.089206825  0.099649297  0.096098115
#> AT2G36270  0.13635214  0.13608772  0.148323105  0.143089355  0.137866627
#> AT5G24110 -0.01007736 -0.01091903 -0.006733566 -0.007131005 -0.007922378
#> AT1G28300  0.41689657  0.42042912  0.412106202  0.413097486  0.415512274
#>               E5_8h_R2   E5_16h_R1   E5_16h_R2   E5_24h_R1    E5_24h_R2
#> AT3G59060  0.094740188  0.09649221  0.09919591  0.09970536  0.095745267
#> AT2G36270  0.134958108  0.13582114  0.13321162  0.13815229  0.137683060
#> AT5G24110 -0.007370023 -0.01071986 -0.01018437 -0.01129071 -0.009585838
#> AT1G28300  0.411671138  0.41310189  0.40991275  0.41507176  0.413921240
#>              E5_48h_R1   E5_48h_R2   E5_48h_R3   E5_72h_R1   E5_72h_R2
#> AT3G59060  0.097940897  0.09357488  0.10074538  0.09559483  0.09547439
#> AT2G36270  0.139019907  0.13253096  0.13648215  0.13210676  0.13327821
#> AT5G24110 -0.009450179 -0.01094474 -0.01260133 -0.01273412 -0.01376151
#> AT1G28300  0.410781266  0.41151891  0.41379095  0.40970512  0.41691670
#>             E5_72h_R3
#> AT3G59060  0.10141545
#> AT2G36270  0.13397782
#> AT5G24110 -0.01202533
#> AT1G28300  0.41128926

heatmap(TF_percentMean, Colv = NA, scale = "none")
```

![](data:image/png;base64...)

* **select specific sample\_id，row is gene\_id, column is TF\_id，the value in
  matrix is each TF percent on each gene in specific sample**

In this condition, we can see the influence of each TF on each gene in the
specific sample.

```
metadata(result_findIT_regionRP)$percent_df %>%
    filter(sample == "E5_0h_R1") %>%
    select(gene_id, percent, TF_id) %>%
    tidyr::pivot_wider(values_from = percent, names_from = gene_id) -> E50h_TF_percent

E50h_TF_mt <- as.matrix(E50h_TF_percent[, -1])
rownames(E50h_TF_mt) <- E50h_TF_percent$TF_id

E50h_TF_mt
#>           AT5G02760    AT5G04820    AT5G05140    AT5G05180    AT5G07500
#> AT3G59060 0.6185198 9.510659e-01 0.9998695196 0.8599037413 3.548629e-06
#> AT2G36270 0.2870298 4.323193e-02 0.4996276611 0.0006340383 9.553795e-01
#> AT5G24110 0.0000000 2.684875e-06 0.0000148582 0.1379194448 0.000000e+00
#> AT1G28300 0.9804750 9.997659e-01 0.9999273678 0.9995774791 8.719047e-01
#>              AT5G08460    AT5G11320  AT5G13790 AT5G13910    AT5G13990
#> AT3G59060 1.244017e-06 5.733276e-06 0.05908985 0.2153231 0.8272742766
#> AT2G36270 3.609851e-06 0.000000e+00 0.05080496 0.2152208 0.0431370565
#> AT5G24110 4.909990e-01 0.000000e+00 0.00000000 0.2840863 0.0000111638
#> AT1G28300 9.999935e-01 9.045044e-01 0.89659323 0.4993108 0.9941978731
#>              AT5G14070    AT5G14120  AT5G15830 AT5G16110    AT5G17810 AT5G19250
#> AT3G59060 9.350048e-06 3.318164e-06 0.01088969 0.1929898 0.0004321823 0.5861229
#> AT2G36270 6.456453e-04 9.264010e-01 0.09777221 0.8694675 0.8128045462 0.0000000
#> AT5G24110 0.000000e+00 0.000000e+00 0.00000000 0.0000000 0.0000000000 0.0000000
#> AT1G28300 4.191532e-01 9.264015e-01 0.57300981 0.9888982 0.9548497704 0.7455370
#>            AT5G20045   AT5G20050    AT5G20670 AT5G22390    AT5G23000 AT5G23350
#> AT3G59060 0.02123381 0.004773372 0.0007349553 0.0000000 0.0005218444 0.9443291
#> AT2G36270 0.74664572 0.816722826 0.0006931239 0.9148911 0.0000911175 0.2057015
#> AT5G24110 0.00000000 0.000000000 0.0000000000 0.0000000 0.0000911175 0.1534872
#> AT1G28300 0.97875473 0.995219102 0.9339122498 0.9148932 0.4641437769 0.9663600
#>            AT5G23360   AT5G23370 AT5G24600 AT5G36250    AT5G41460 AT5G44260
#> AT3G59060 0.70760567 0.070780064 0.4331444 0.0000000 0.5784376826 0.2686116
#> AT2G36270 0.34142821 0.868768341 0.9262625 0.0000000 0.9084167040 0.9396472
#> AT5G24110 0.06999959 0.007002021 0.0000000 0.0000000 0.0008762819 0.0000000
#> AT1G28300 0.96984817 0.947063959 0.9312906 0.9983315 0.9920151017 0.9426889
#>            AT5G44380    AT5G46060  AT5G46950    AT5G48420 AT5G49100
#> AT3G59060 0.64877424 0.0007712204 0.03947753 7.957429e-04 0.9579552
#> AT2G36270 0.03806873 0.0268983512 0.04003764 4.624518e-06 0.7438419
#> AT5G24110 0.00000000 0.0565108962 0.00000000 7.723619e-03 0.0000000
#> AT1G28300 0.90013014 0.9939655268 0.21824707 9.914729e-01 0.9989870
#>              AT5G52860 AT5G52882 AT5G54230   AT5G55620  AT5G56075 AT5G58350
#> AT3G59060 2.496830e-03 0.1726205 0.0000000 0.007848307 0.00512347 0.9168544
#> AT2G36270 1.542930e-01 0.1722801 0.7925334 0.306030309 0.08232805 0.9774949
#> AT5G24110 3.115976e-05 0.0000000 0.0000000 0.007844281 0.00000000 0.0000000
#> AT1G28300 2.999216e-01 0.9826116 0.7670893 0.986513106 0.92178007 0.9983444
#>             AT5G58660 AT5G58910 AT5G60760 AT5G62000   AT5G62280 AT5G64100
#> AT3G59060 0.974813541 0.2213277 0.9083193 0.9990986 0.405752767 0.5866519
#> AT2G36270 0.974811032 0.3780437 0.9421843 0.9990986 0.001213448 0.6241822
#> AT5G24110 0.006108379 0.0000000 0.0000000 0.0000000 0.001213448 0.0000000
#> AT1G28300 0.999982735 0.6159790 0.9980976 0.9990986 0.126204232 0.6370139
#>           AT5G64530  AT5G64570   AT5G65100    AT5G66360  AT5G67190
#> AT3G59060 0.8879179 0.01827701 0.985395178 8.932819e-01 0.07999059
#> AT2G36270 0.9926487 0.89624267 0.988307943 4.201213e-02 0.81500186
#> AT5G24110 0.0000000 0.00000000 0.005207579 1.862933e-05 0.01015147
#> AT1G28300 0.8879424 0.99968452 0.999970308 9.343217e-01 0.92825295

heatmap(E50h_TF_mt, scale = "none")
```

![](data:image/png;base64...)

* **select specific TF\_id，row is gene\_id, column is sample\_id，the value in
  matrix is specific TF percent on each gene in each sample**

In this condition, we can see the influence trend of specific TF on each gene
between samples.

```
metadata(result_findIT_regionRP)
#> $percent_df
#> # A tibble: 3,200 × 4
#>    gene_id      percent TF_id     sample
#>    <chr>          <dbl> <chr>     <chr>
#>  1 AT5G02760 0.619      AT3G59060 E5_0h_R1
#>  2 AT5G04820 0.951      AT3G59060 E5_0h_R1
#>  3 AT5G05140 1.000      AT3G59060 E5_0h_R1
#>  4 AT5G05180 0.860      AT3G59060 E5_0h_R1
#>  5 AT5G07500 0.00000355 AT3G59060 E5_0h_R1
#>  6 AT5G08460 0.00000124 AT3G59060 E5_0h_R1
#>  7 AT5G11320 0.00000573 AT3G59060 E5_0h_R1
#>  8 AT5G13790 0.0591     AT3G59060 E5_0h_R1
#>  9 AT5G13910 0.215      AT3G59060 E5_0h_R1
#> 10 AT5G13990 0.827      AT3G59060 E5_0h_R1
#> # ℹ 3,190 more rows
#>
#> $hits_df
#> # A tibble: 5,578 × 2
#>    TF_id     feature_id
#>    <chr>     <chr>
#>  1 AT3G59060 WFX_peak_19633
#>  2 AT2G36270 WFX_peak_19634
#>  3 AT2G36270 WFX_peak_19635
#>  4 AT3G59060 WFX_peak_19636
#>  5 AT2G36270 WFX_peak_19637
#>  6 AT3G59060 WFX_peak_19638
#>  7 AT2G36270 WFX_peak_19639
#>  8 AT2G36270 WFX_peak_19641
#>  9 AT2G36270 WFX_peak_19645
#> 10 AT3G59060 WFX_peak_19645
#> # ℹ 5,568 more rows

metadata(result_findIT_regionRP)$percent_df %>%
  filter(TF_id == "AT1G28300") %>%
  select(-TF_id) %>%
  tidyr::pivot_wider(names_from = sample, values_from = percent) -> LEC2_percent_df

LEC2_percent_mt <- as.matrix(LEC2_percent_df[, -1])
rownames(LEC2_percent_mt) <- LEC2_percent_df$gene_id

heatmap(LEC2_percent_mt, Colv = NA, scale = "none")
```

![](data:image/png;base64...)

If above analysis is too complex for you, I also provide the shiny function
`shinyParse_findIT_regionRP` from
[InteractiveFindIT2](https://github.com/shangguandong1996/InteractiveFindIT2) to help you
explore the result interactively.

```
# Before using shiny function, you should merge the regionRP and result_findIT_regionRP firstly.
merge_result <- c(regionRP, result_findIT_regionRP)
InteractiveFindIT2::shinyParse_findIT_regionRP(merge_result = merge_result, mode = "gene")

InteractiveFindIT2::shinyParse_findIT_regionRP(merge_result = merge_result,mode = "TF")
```

## 5.6 Find IT of input genes based on motif activity response

`findIT_regionRP` is a useful tool, but I find for small genome like Arabidopsis
thaliana, it can not provide much information about TF total influence trend on
input genes set between samples. So I write `findIT_MARA` to see the TF
influence trend between samples. The advantage is that it can provide more
valuable result compared with `findIT_regionRP` when you want to see the total
trend. But the disadvantage is that it can not offer you the detailed informatin
on each gene. And the most important thing is it use the `input_feature_id` as
input, so you should use `mm_geneBound`, `peakGeneCor`, `enhancerPromoterCor` to
find related peak for your input genes.

The theory behind `findIT_regionRP` is from Motif Activity Response
Analysis(The FANTOM Consortium and Riken Omics Science Center [2009](#ref-thefantomconsortium_transcriptional_2009)). And I also borrow the idea
from gimmeMotifs maelstrom(Bruse and Heeringen [2018](#ref-bruse_gimmemotifs_2018)).

**And please note that the TF\_GR\_database here should be the motif scan in your
ATAC peak instead of public ChIP-Seq!!!**. Because I use the linear function to
combine with TF, which means TF will influence each other. And for other
function in `findIT` module, each TF result is orthogonal with each other.

If you have a column named `TF_score` in `TF_GR_database`, `findIT_MARA` will
consider it to improve the accuracy. The `TF_score` always be the fifth column
in your motif scan bed file and it represent your motif hit confidence in the
location.

Here is the example bed output from `gimmeMotif scan`. The fifth column can be
treated as `TF_score`.

```
Chr1    2982    2989    MA0982.1_DOF2.4 5.817207239414311       +
Chr1    3085    3097    MA1044.1_NAC92  8.87118934508003        -
Chr1    3146    3165    MA1062.2_TCP15  7.842209471388505       +
Chr1    3146    3165    MA1065.2_TCP20  7.86289776912883        +
```

```
# For repeatability of results, you should set seed.
set.seed(20160806)
findIT_MARA(input_feature_id = input_feature_id,
            peak_GR = ATAC_peak_GR,
            peakScoreMt = ATAC_normCount,
            TF_GR_database = TF_GR_database,
            log = TRUE,
            meanScale = TRUE) -> result_findIT_MARA
#> >> dealing with TF_GR_database...        2025-10-29 23:58:45
#> >> calculating coef and converting into z-score using INT...     2025-10-29 23:58:45
#> >> dealing with E5_0h_R1...      2025-10-29 23:58:45
#> >> dealing with E5_0h_R2...      2025-10-29 23:58:45
#> >> dealing with E5_4h_R1...      2025-10-29 23:58:45
#> >> dealing with E5_4h_R2...      2025-10-29 23:58:45
#> >> dealing with E5_8h_R1...      2025-10-29 23:58:45
#> >> dealing with E5_8h_R2...      2025-10-29 23:58:45
#> >> dealing with E5_16h_R1...     2025-10-29 23:58:45
#> >> dealing with E5_16h_R2...     2025-10-29 23:58:45
#> >> dealing with E5_24h_R1...     2025-10-29 23:58:45
#> >> dealing with E5_24h_R2...     2025-10-29 23:58:45
#> >> dealing with E5_48h_R1...     2025-10-29 23:58:46
#> >> dealing with E5_48h_R2...     2025-10-29 23:58:46
#> >> dealing with E5_48h_R3...     2025-10-29 23:58:46
#> >> dealing with E5_72h_R1...     2025-10-29 23:58:46
#> >> dealing with E5_72h_R2...     2025-10-29 23:58:46
#> >> dealing with E5_72h_R3...     2025-10-29 23:58:46
#> >> merging all info together...      2025-10-29 23:58:46
#> >> done      2025-10-29 23:58:46

# Please note that you should add the total motif scan data in TF_GR_database
# Here I just use the test public ChIP-Seq data, so the result is not valuable
result_findIT_MARA
#> # A tibble: 4 × 17
#>   TF_id     E5_0h_R1 E5_0h_R2 E5_4h_R1 E5_4h_R2 E5_8h_R1 E5_8h_R2 E5_16h_R1
#>   <chr>        <dbl>    <dbl>    <dbl>    <dbl>    <dbl>    <dbl>     <dbl>
#> 1 AT3G59060    1.15     1.15    -1.15    -0.319    1.15     1.15     -0.319
#> 2 AT2G36270   -0.319   -0.319    0.319    1.15    -0.319   -0.319    -1.15
#> 3 AT5G24110   -1.15    -1.15     1.15    -1.15    -1.15    -1.15      1.15
#> 4 AT1G28300    0.319    0.319   -0.319    0.319    0.319    0.319     0.319
#> # ℹ 9 more variables: E5_16h_R2 <dbl>, E5_24h_R1 <dbl>, E5_24h_R2 <dbl>,
#> #   E5_48h_R1 <dbl>, E5_48h_R2 <dbl>, E5_48h_R3 <dbl>, E5_72h_R1 <dbl>,
#> #   E5_72h_R2 <dbl>, E5_72h_R3 <dbl>
```

```
# when you get the zscale value from findIT_MARA,
# you can use integrate_replicates to integrate replicate zscale by setting type as "rank_zscore"
# Here each replicate are combined using Stouffer’s method
MARA_mt <- as.matrix(result_findIT_MARA[, -1])

rownames(MARA_mt) <- result_findIT_MARA$TF_id

MARA_colData <- data.frame(row.names = colnames(MARA_mt),
                           type = gsub("_R[0-9]", "", colnames(MARA_mt))
                           )

integrate_replicates(mt = MARA_mt,
                     colData = MARA_colData,
                     type = "rank_zscore")
#>                E5_0h     E5_4h      E5_8h     E5_16h     E5_24h     E5_48h
#> AT3G59060  1.6268397 -1.038732  1.6268397  0.5881078 -1.6268397 -1.9924636
#> AT2G36270 -0.4506241  1.038732 -0.4506241 -1.0387319 -0.4506241  0.5518996
#> AT5G24110 -1.6268397  0.000000 -1.6268397  0.0000000  1.6268397  1.1443425
#> AT1G28300  0.4506241  0.000000  0.4506241  0.4506241  0.4506241  0.2962215
#>               E5_72h
#> AT3G59060  0.5518996
#> AT2G36270  1.1443425
#> AT5G24110 -0.6641545
#> AT1G28300 -1.0320876
```

## 5.7 integrate result

If you have p-value or rank value from different source, you can combine them
using `integrate_replicates`.

```
list(TF_Hit = result_TFHit,
     enrichFisher = result_enrichFisher,
     wilcox = result_enrichWilcox,
     TT_pair = result_TTpair
     ) -> rank_merge_list
purrr::map(names(rank_merge_list), .f = function(x){
    data <- rank_merge_list[[x]]
    data %>%
        select(TF_id, rank) %>%
        mutate(source = x) -> data
    return(data)
}) %>%
    do.call(rbind, .) %>%
    tidyr::pivot_wider(names_from = source, values_from = rank) -> rank_merge_df

rank_merge_df
#> # A tibble: 5 × 5
#>   TF_id     TF_Hit enrichFisher wilcox TT_pair
#>   <chr>      <dbl>        <dbl>  <dbl>   <dbl>
#> 1 AT1G28300      1            1      1       1
#> 2 AT2G36270      2            2      2      NA
#> 3 AT3G59060      3            3      3      NA
#> 4 AT5G24110      4            4      4       3
#> 5 AT3G23250     NA           NA     NA       2

# we only select TF which appears in all source
rank_merge_df <- rank_merge_df[rowSums(is.na(rank_merge_df)) == 0, ]

rank_merge_mt <- as.matrix(rank_merge_df[, -1])
rownames(rank_merge_mt) <- rank_merge_df$TF_id

colData <- data.frame(row.names = colnames(rank_merge_mt),
                      type = rep("source", ncol(rank_merge_mt)))

integrate_replicates(mt = rank_merge_mt, colData = colData, type = "rank")
#>           source
#> AT1G28300      1
#> AT5G24110      2
```

# 6 Calculate feature correlation

## 6.1 Calculate peak gene correlation

```
data("RNA_normCount")

peak_GR <- loadPeakFile(ATAC_peak_path)[1:100]
mmAnno <- mm_geneScan(peak_GR,Txdb)
#> >> checking seqlevels match...       2025-10-29 23:58:46
#> >> your peak_GR seqlevel:Chr5...
#> >> your Txdb seqlevel:Chr1 Chr2 Chr3 Chr4 Chr5 M C...
#> Good, your Chrs in peak_GR is all in Txdb
#> ------------
#> annotatePeak using geneScan mode begins
#> >> preparing gene features information and scan region...        2025-10-29 23:58:46
#> >> some scan range may cross Chr bound, trimming...      2025-10-29 23:58:47
#> >> finding overlap peak in gene scan region...       2025-10-29 23:58:47
#> >> dealing with left peak not your gene scan region...       2025-10-29 23:58:47
#> >> merging two set peaks...      2025-10-29 23:58:47
#> >> calculating distance and dealing with gene strand...      2025-10-29 23:58:47
#> >> merging all info together ...     2025-10-29 23:58:47
#> >> done      2025-10-29 23:58:47

ATAC_colData <- data.frame(row.names = colnames(ATAC_normCount),
                           type = gsub("_R[0-9]", "", colnames(ATAC_normCount))
                           )

integrate_replicates(ATAC_normCount, ATAC_colData) -> ATAC_normCount_merge
RNA_colData <- data.frame(row.names = colnames(RNA_normCount),
                          type = gsub("_R[0-9]", "", colnames(RNA_normCount))
                          )
integrate_replicates(RNA_normCount, RNA_colData) -> RNA_normCount_merge

peakGeneCor(mmAnno = mmAnno,
            peakScoreMt = ATAC_normCount_merge,
            geneScoreMt = RNA_normCount_merge,
            parallel = FALSE) -> mmAnnoCor
#> Good, your two matrix colnames matchs
#> Warning: some gene_id or feature_id in your mmAnno is not in your geneScoreMt or peakScore Mt, final cor and pvalue of these gene_id or feature_id pair will be NA
#> >> calculating cor and pvalue, which may be time consuming...        2025-10-29 23:58:48
#> >> merging all info together...      2025-10-29 23:58:48
#> >> done      2025-10-29 23:58:48
```

```
subset(mmAnnoCor, cor > 0.8) %>%
  getAssocPairNumber()
#> # A tibble: 10 × 2
#>    gene_id   peakNumber
#>    <chr>          <int>
#>  1 AT5G01075          2
#>  2 AT5G01175          1
#>  3 AT5G01180          1
#>  4 AT5G01230          1
#>  5 AT5G01340          1
#>  6 AT5G01590          1
#>  7 AT5G01600          2
#>  8 AT5G01620          2
#>  9 AT5G01720          1
#> 10 AT5G01890          1
```

```
plot_peakGeneCor(mmAnnoCor = mmAnnoCor,
                 select_gene = "AT5G01075")
#> Joining with `by = join_by(feature_id)`
#> Joining with `by = join_by(feature_id)`
#> `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

```
plot_peakGeneCor(mmAnnoCor = subset(mmAnnoCor, cor > 0.95),
                 select_gene = "AT5G01075")
#> Joining with `by = join_by(feature_id)`
#> Joining with `by = join_by(feature_id)`
#> `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

```
plot_peakGeneCor(mmAnnoCor = subset(mmAnnoCor, cor > 0.95),
                 select_gene = "AT5G01075") +
  geom_point(aes(color = time_point))
#> Joining with `by = join_by(feature_id)`
#> Joining with `by = join_by(feature_id)`
#> `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

```
plot_peakGeneAlias_summary(mmAnno = mmAnnoCor,
                           mmAnno_corFilter = subset(mmAnnoCor, cor > 0.8))
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the FindIT2 package.
#>   Please report the issue at <https://support.bioconductor.org/t/FindIT2>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

the shiny function `shinyParse_peakGeneCor` from
[InteractiveFindIT2](https://github.com/shangguandong1996/InteractiveFindIT2) to help you
explore the result interactively

```
InteractiveFindIT2::shinyParse_peakGeneCor(mmAnnoCor)
```

## 6.2 Calculate enhancer promoter correlation

```
enhancerPromoterCor(peak_GR = peak_GR[1:100],
                    Txdb = Txdb,
                    peakScoreMt = ATAC_normCount,
                    up_scanPromoter = 500,
                    down_scanPromoter = 500,
                    up_scanEnhancer = 2000,
                    down_scanEnhacner = 2000,
                    parallel = FALSE) -> mmAnnoCor_linkEP
#> >> checking seqlevels match...       2025-10-29 23:58:51
#> >> your peak_GR seqlevel:Chr5...
#> >> your Txdb seqlevel:Chr1 Chr2 Chr3 Chr4 Chr5 M C...
#> Good, your Chrs in peak_GR is all in Txdb
#> >> using scanPromoter parameter to scan promoter for each gene...        2025-10-29 23:58:52
#> >> checking seqlevels match...       2025-10-29 23:58:52
#> >> your peak_GR seqlevel:Chr5...
#> >> your Txdb seqlevel:Chr1 Chr2 Chr3 Chr4 Chr5 M C...
#> Good, your Chrs in peak_GR is all in Txdb
#> >> some scan range may cross Chr bound, trimming...      2025-10-29 23:58:52
#> >> there are 85 gene have scaned promoter
#> >> using scanEnhancer parameter to scan Enhancer for each gene...        2025-10-29 23:58:52
#> >> checking seqlevels match...       2025-10-29 23:58:52
#> >> your peak_GR seqlevel:Chr5...
#> >> your Txdb seqlevel:Chr1 Chr2 Chr3 Chr4 Chr5 M C...
#> Good, your Chrs in peak_GR is all in Txdb
#> >> some scan range may cross Chr bound, trimming...      2025-10-29 23:58:53
#> >> calculating cor and pvalue, which may be time consuming...        2025-10-29 23:58:53
#> >> merging all info together...      2025-10-29 23:58:53
#> >> done      2025-10-29 23:58:54
```

```
plot_peakGeneCor(mmAnnoCor = mmAnnoCor_linkEP,
                 select_gene = "AT5G01075") -> p
#> Joining with `by = join_by(feature_id)`
#> Joining with `by = join_by(feature_id)`

p
#> `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

```
p$data$type <- gsub("_R[0-9]", "", p$data$time_point)
p$data$type <- factor(p$data$type, levels = unique(p$data$type))

p +
    ggplot2::geom_point(aes(color = type))
#> `geom_smooth()` using formula = 'y ~ x'
```

![](data:image/png;base64...)

```
plot_peakGeneAlias_summary(mmAnno = mmAnnoCor_linkEP,
                           mmAnno_corFilter = subset(mmAnnoCor_linkEP, cor > 0.8))
```

![](data:image/png;base64...)

the shiny function `shinyParse_peakGeneCor` from
[InteractiveFindIT2](https://github.com/shangguandong1996/InteractiveFindIT2) to help you
explore the result interactively

```
InteractiveFindIT2::shinyParse_peakGeneCor(mmAnnoCor_linkEP)
```

# 7 Integrate result

You have seen `integrate_replicates` in (section [5.7](#integrateTF),
[6.1](#peakGeneCor)), [5.6](#findITMARA)). But actually, `integrate_replicates`
can do more. The `integrate_replicates` has four basic mode: value, rank,
rank\_zscore and p-value. For each mode, it use different function.

# 8 Session info

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-29
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package                             * version   date (UTC) lib source
#>  abind                                 1.4-8     2024-09-12 [2] CRAN (R 4.5.1)
#>  AnnotationDbi                       * 1.72.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biobase                             * 2.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocBaseUtils                         1.12.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics                        * 0.56.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocIO                                1.20.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager                           1.30.26   2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocParallel                          1.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocStyle                           * 2.38.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings                            2.78.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                                   4.6.0     2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64                                 4.6.0-1   2025-01-16 [2] CRAN (R 4.5.1)
#>  bitops                                1.0-9     2024-10-03 [2] CRAN (R 4.5.1)
#>  blob                                  1.2.4     2023-03-17 [2] CRAN (R 4.5.1)
#>  bookdown                              0.45      2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib                                 0.9.0     2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem                                1.1.0     2024-05-16 [2] CRAN (R 4.5.1)
#>  cigarillo                             1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  cli                                   3.6.5     2025-04-23 [2] CRAN (R 4.5.1)
#>  codetools                             0.2-20    2024-03-31 [3] CRAN (R 4.5.1)
#>  crayon                                1.5.3     2024-06-20 [2] CRAN (R 4.5.1)
#>  curl                                  7.0.0     2025-08-19 [2] CRAN (R 4.5.1)
#>  DBI                                   1.2.3     2024-06-02 [2] CRAN (R 4.5.1)
#>  DelayedArray                          0.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  dichromat                             2.0-0.1   2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                                0.6.37    2024-08-19 [2] CRAN (R 4.5.1)
#>  dplyr                               * 1.1.4     2023-11-17 [2] CRAN (R 4.5.1)
#>  evaluate                              1.0.5     2025-08-27 [2] CRAN (R 4.5.1)
#>  farver                                2.1.2     2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                               1.2.0     2024-05-15 [2] CRAN (R 4.5.1)
#>  FindIT2                             * 1.16.0    2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  foreach                               1.5.2     2022-02-02 [2] CRAN (R 4.5.1)
#>  generics                            * 0.1.4     2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomicAlignments                     1.46.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicFeatures                     * 1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicRanges                       * 1.62.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  ggplot2                             * 4.0.0     2025-09-11 [2] CRAN (R 4.5.1)
#>  ggrepel                               0.9.6     2024-09-07 [2] CRAN (R 4.5.1)
#>  glmnet                                4.1-10    2025-07-17 [2] CRAN (R 4.5.1)
#>  glue                                  1.8.0     2024-09-30 [2] CRAN (R 4.5.1)
#>  gtable                                0.3.6     2024-10-25 [2] CRAN (R 4.5.1)
#>  hms                                   1.1.4     2025-10-17 [2] CRAN (R 4.5.1)
#>  htmltools                             0.5.8.1   2024-04-04 [2] CRAN (R 4.5.1)
#>  httr                                  1.4.7     2023-08-15 [2] CRAN (R 4.5.1)
#>  IRanges                             * 2.44.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  iterators                             1.0.14    2022-02-05 [2] CRAN (R 4.5.1)
#>  jquerylib                             0.1.4     2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite                              2.0.0     2025-03-27 [2] CRAN (R 4.5.1)
#>  KEGGREST                              1.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  knitr                                 1.50      2025-03-16 [2] CRAN (R 4.5.1)
#>  labeling                              0.4.3     2023-08-29 [2] CRAN (R 4.5.1)
#>  lattice                               0.22-7    2025-04-02 [3] CRAN (R 4.5.1)
#>  lifecycle                             1.0.4     2023-11-07 [2] CRAN (R 4.5.1)
#>  magrittr                              2.0.4     2025-09-12 [2] CRAN (R 4.5.1)
#>  Matrix                                1.7-4     2025-08-28 [3] CRAN (R 4.5.1)
#>  MatrixGenerics                      * 1.22.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats                         * 1.5.0     2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                               2.0.1     2021-11-26 [2] CRAN (R 4.5.1)
#>  mgcv                                  1.9-3     2025-04-04 [3] CRAN (R 4.5.1)
#>  MultiAssayExperiment                  1.36.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  nlme                                  3.1-168   2025-03-31 [3] CRAN (R 4.5.1)
#>  patchwork                             1.3.2     2025-08-25 [2] CRAN (R 4.5.1)
#>  pillar                                1.11.1    2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig                             2.0.3     2019-09-22 [2] CRAN (R 4.5.1)
#>  plyr                                  1.8.9     2023-10-02 [2] CRAN (R 4.5.1)
#>  png                                   0.1-8     2022-11-29 [2] CRAN (R 4.5.1)
#>  prettyunits                           1.2.0     2023-09-24 [2] CRAN (R 4.5.1)
#>  progress                              1.2.3     2023-12-06 [2] CRAN (R 4.5.1)
#>  purrr                                 1.1.0     2025-07-10 [2] CRAN (R 4.5.1)
#>  qvalue                                2.42.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  R6                                    2.6.1     2025-02-15 [2] CRAN (R 4.5.1)
#>  RColorBrewer                          1.1-3     2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                                  1.1.0     2025-07-02 [2] CRAN (R 4.5.1)
#>  RCurl                                 1.98-1.17 2025-03-22 [2] CRAN (R 4.5.1)
#>  reshape2                              1.4.4     2020-04-09 [2] CRAN (R 4.5.1)
#>  restfulr                              0.0.16    2025-06-27 [2] CRAN (R 4.5.1)
#>  rjson                                 0.2.23    2024-09-16 [2] CRAN (R 4.5.1)
#>  rlang                                 1.1.6     2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown                             2.30      2025-09-28 [2] CRAN (R 4.5.1)
#>  Rsamtools                             2.26.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  RSQLite                               2.4.3     2025-08-20 [2] CRAN (R 4.5.1)
#>  rtracklayer                           1.70.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Arrays                              1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors                           * 0.48.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                                    0.2.0     2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                                  0.4.10    2025-04-11 [2] CRAN (R 4.5.1)
#>  scales                                1.4.0     2025-04-24 [2] CRAN (R 4.5.1)
#>  Seqinfo                             * 1.0.0     2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo                         * 1.2.3     2025-02-05 [2] CRAN (R 4.5.1)
#>  shape                                 1.4.6.1   2024-02-23 [2] CRAN (R 4.5.1)
#>  SparseArray                           1.10.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  stringi                               1.8.7     2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr                               1.5.2     2025-09-08 [2] CRAN (R 4.5.1)
#>  SummarizedExperiment                * 1.40.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  survival                              3.8-3     2024-12-17 [3] CRAN (R 4.5.1)
#>  tibble                                3.3.0     2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyr                                 1.3.1     2024-01-24 [2] CRAN (R 4.5.1)
#>  tidyselect                            1.2.1     2024-03-11 [2] CRAN (R 4.5.1)
#>  TxDb.Athaliana.BioMart.plantsmart28 * 3.2.2     2025-09-10 [2] Bioconductor
#>  utf8                                  1.2.6     2025-06-08 [2] CRAN (R 4.5.1)
#>  vctrs                                 0.6.5     2023-12-01 [2] CRAN (R 4.5.1)
#>  withr                                 3.0.2     2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                                  0.53      2025-08-19 [2] CRAN (R 4.5.1)
#>  XML                                   3.99-0.19 2025-08-22 [2] CRAN (R 4.5.1)
#>  XVector                               0.50.0    2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                                  2.3.10    2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpP9fCvx/Rinst5b4b15cfd668d
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# References

Bruse, Niklas, and Simon J. van Heeringen. 2018. “GimmeMotifs: An Analysis Framework for Transcription Factor Motif Analysis.” Preprint. Bioinformatics. <https://doi.org/10.1101/474403>.

Li, Shaojuan, Changxin Wan, Rongbin Zheng, Jingyu Fan, Xin Dong, Clifford A Meyer, and X Shirley Liu. 2019. “Cistrome-GO: A Web Server for Functional Enrichment Analysis of Transcription Factor ChIP-Seq Peaks.” *Nucleic Acids Research* 47 (July): W206–W211. <https://doi.org/10.1093/nar/gkz332>.

Liu, Chang, Congmao Wang, George Wang, Claude Becker, Maricris Zaidem, and Detlef Weigel. 2016. “Genome-Wide Analysis of Chromatin Packing in Arabidopsis Thaliana at Single-Gene Resolution.” *Genome Research* 26 (August): 1057–68. <https://doi.org/10.1101/gr.204032.116>.

Qin, Qian, Jingyu Fan, Rongbin Zheng, Changxin Wan, Shenglin Mei, Qiu Wu, Hanfei Sun, et al. 2020. “Lisa: Inferring Transcriptional Regulators Through Integrative Modeling of Public Chromatin Accessibility and ChIP-Seq Data.” *Genome Biology* 21 (December): 32. <https://doi.org/10.1186/s13059-020-1934-6>.

The FANTOM Consortium, and Riken Omics Science Center. 2009. “The Transcriptional Network That Controls Growth Arrest and Differentiation in a Human Myeloid Leukemia Cell Line.” *Nature Genetics* 41 (May): 553–62. <https://doi.org/10.1038/ng.375>.

Wang, Fu-Xiang, Guan-Dong Shang, Lian-Yu Wu, Zhou-Geng Xu, Xin-Yan Zhao, and Jia-Wei Wang. 2020. “Chromatin Accessibility Dynamics and a Hierarchical Transcriptional Regulatory Network Structure for Plant Somatic Embryogenesis.” *Developmental Cell* 54 (September): 742–757.e8. <https://doi.org/10.1016/j.devcel.2020.07.003>.

Wang, Su, Hanfei Sun, Jian Ma, Chongzhi Zang, Chenfei Wang, Juan Wang, Qianzi Tang, Clifford A Meyer, Yong Zhang, and X Shirley Liu. 2013. “Target Analysis by Integration of Transcriptome and ChIP-Seq Data with BETA.” *Nature Protocols* 8 (December): 2502–15. <https://doi.org/10.1038/nprot.2013.150>.

Wang, Su, Chongzhi Zang, Tengfei Xiao, Jingyu Fan, Shenglin Mei, Qian Qin, Qiu Wu, et al. 2016. “Modeling Cis-Regulation with a Compendium of Genome-Wide Histone H3K27ac Profiles.” *Genome Research* 26 (October): 1417–29. <https://doi.org/10.1101/gr.201574.115>.