Code

* Show All Code
* Hide All Code

# ODER: Optimising the Definition of Expressed Regions

Emmanuel Olagbaju1\*

1UCL

\*e.olagbaju@ucl.ac.uk

#### 26 October 2021

#### Package

ODER 1.0.0

# 1 Basics

## 1.1 Install `ODER`

`R` is an open-source statistical environment which can be easily modified to
enhance its functionality via packages. *[ODER](https://bioconductor.org/packages/3.14/ODER)* is a `R` package
available via the [Bioconductor](http://bioconductor.org) repository for
packages. `R` can be installed on any operating system from
[CRAN](https://cran.r-project.org/) after which you can install
*[ODER](https://bioconductor.org/packages/3.14/ODER)* by using the following commands in your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("eolagbaju/ODER")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

## 1.2 Required knowledge

The expected input of *[ODER](https://bioconductor.org/packages/3.14/ODER)* is coverage in the form of BigWig
files as well as, depending on the functionalility required by a specific user,
junctions in form of a `RangedSummarizedExperiments`.

*[ODER](https://bioconductor.org/packages/3.14/ODER)* is based on many other packages and in particular in those
that have implemented the infrastructure needed for dealing with RNA-seq data.
The *[GenomicRanges](https://bioconductor.org/packages/3.14/GenomicRanges)* package is heavily used in *[ODER](https://bioconductor.org/packages/3.14/ODER)*
while other packages like *[SummarizedExperiment](https://bioconductor.org/packages/3.14/SummarizedExperiment)* and
*[derfinder](https://bioconductor.org/packages/3.14/derfinder)*. Previous experience with these packages will help in
the comprehension and use of *[ODER](https://bioconductor.org/packages/3.14/ODER)*.

If you are asking yourself the question “Where do I start using Bioconductor?”
you might be interested in
[this blog post](http://lcolladotor.github.io/2014/10/16/startbioc/#.VkOKbq6rRuU).
If you find the structure of a *[SummarizedExperiment](https://bioconductor.org/packages/3.14/SummarizedExperiment)* unclear, you
might consider checking out [this manual](http://master.bioconductor.org/help/course-materials/2019/BSS2019/04_Practical_CoreApproachesInBioconductor.html).

## 1.3 Asking for help

As package developers, we try to explain clearly how to use our packages and in
which order to use the functions. But `R` and `Bioconductor` have a steep
learning curve so it is critical to learn where to ask for help. The blog post
quoted above mentions some but we would like to highlight the
[Bioconductor support site](https://support.bioconductor.org/) as the main
resource for getting help: remember to use the `ODER` tag and check
[the older posts](https://support.bioconductor.org/t/ODER/). Other alternatives
are available such as creating GitHub issues and tweeting. However, please note
that if you want to receive help you should adhere to the [posting guidelines](http://www.bioconductor.org/help/support/posting-guide/). It is
particularly critical that you provide a small reproducible example and your
session information so package developers can track down the source of the error.

## 1.4 Citing `ODER`

We hope that *[ODER](https://bioconductor.org/packages/3.14/ODER)* will be useful for your research. Please use
the following information to cite the package and the overall approach. Thank you!

```
## Citation info
citation("ODER")
#>
#> eolagbaju (2021). _Optimising the Definition of Expressed Regions_.
#> doi: 10.18129/B9.bioc.ODER (URL:
#> https://doi.org/10.18129/B9.bioc.ODER),
#> https://github.com/eolagbaju/ODER/ODER - R package version 1.0.0, <URL:
#> http://www.bioconductor.org/packages/ODER>.
#>
#> eolagbaju (2021). "Optimising the Definition of Expressed Regions."
#> _bioRxiv_. doi: 10.1101/TODO (URL: https://doi.org/10.1101/TODO), <URL:
#> https://www.biorxiv.org/content/10.1101/TODO>.
#>
#> To see these entries in BibTeX format, use 'print(<citation>,
#> bibtex=TRUE)', 'toBibtex(.)', or set
#> 'options(citation.bibtex.max=999)'.
```

# 2 Background

`ODER` is a packaged form of the method developed in the Zhang et al. 2020 publication:
[Incomplete annotation has a disproportionate impact on our understanding of Mendelian and complex neurogenetic disorders](https://advances.sciencemag.org/content/6/24/eaay8299.full).
The overarching aim of `ODER` is use RNA-sequencing data to define regions of
unannotated expression (ERs) in the genome, optimise their definition, then link
them to known genes.

`ODER` builds upon the method defined in *[derfinder](https://bioconductor.org/packages/3.14/derfinder)* by improving
the definition of ERs in a few ways. Firstly, rather than being a fixed value,
the coverage cut off is optimised based on a set of user-inputted, gold-standard
exons for a given set of samples. Secondly, `ODER` introduces a second
optimisation parameter, the max region gap, which determines the number of
base-pairs of gap between which ERs are merged. Thirdly, ERs can be connected to
known genes through junction reads. This aids the interpretation of ERs and also
allows their definition to be refined further using the intersection between ERs
and junctions. For more detailed methods, please see the methods section of the
[original publication](https://www.science.org/doi/10.1126/sciadv.aay8299).

Unannotated ERs can provide evidence for the existence and location of novel
exons, which are yet to be added within reference annotation. Improving the
completeness of reference annotation can aid the interpretation of genetic
variation. For example, the output of `ODER` can help to better interpret
non-coding genetics variants that are found in the genome of Mendelian disease
patients, poetentially leading to improvements in diagnosis rates.

# 3 Quick start to using to `ODER`

From the top-level ODER consists of 4 core functions, which are broken down
internally into several smaller helper functions. These functions are expected
to be run sequentially in the order presented below:

1. `ODER()` - Takes as input coverage in the form of BigWig files. Uses
   *[derfinder](https://bioconductor.org/packages/3.14/derfinder)* to call contigous blocks of expression that we term
   expressed regions or ERs. ER definitions are optimised across a pair of
   parameters the mean coverage cut-off (MCC) and the max region gap (MRG) with
   respect to a user-inputted set of gold standard exons. The set of ERs for the
   optimised MCC and MRG are returned.
2. `annotatER()` - Takes as input the optimised set of ERs and a set of
   junctions. Finds overlaps between the ERs and junctions, thereby annotating ERs
   with the gene associated with it’s corresponding junction. Also categorises ERs
   into “exon”, “intron”, “intergenic” or any combination of these three categories
   depending on the ERs overlap with existing annotation.
3. `refine_ers()` - Takes as input the optimised set of ERs annotated with
   junctions. Refines the ER definition based on the intersection between the ER
   and it’s overlapping junction.
4. `get_count_matrix()` - Takes as input any set of `GenomicRanges` and a set of
   `BigWig` files. Returns a `RangedSummarizedExperiment` with `assays` containing
   the average coverage across each range. This function is intended to obtain the
   coverage across ERs to allow usage in downstream analyses such as differential
   expression.

## 3.1 Example

This is a basic example to show how you can use ODER. First, we need to download
the example `BigWig` data required as input for `ODER`.

```
library("ODER")
library("magrittr")

# Download recount data in the form of BigWigs
gtex_metadata <- recount::all_metadata("gtex")
#> Setting options('download.file.method.GEOquery'='auto')
#> Setting options('GEOquery.inmemory.gpl'=FALSE)
#> 2021-10-26 18:05:33 downloading the metadata to /tmp/RtmpnAkezX/metadata_clean_gtex.Rdata

gtex_metadata <- gtex_metadata %>%
    as.data.frame() %>%
    dplyr::filter(project == "SRP012682")

url <- recount::download_study(
    project = "SRP012682",
    type = "samples",
    download = FALSE
)

# file_cache is an internal ODER function to cache files for
# faster repeated loading
bw_path <- file_cache(url[1])

bw_path
#>                                                                                              BFC27
#> "/home/biocbuild/.cache/R/BiocFileCache/35dafa364cd476_SRR660824_SRS389722_SRX222703_male_lung.bw"
```

To get the optimum set of ERs from a BigWig file we can use the `ODER()`
function.This will obtain the optimally defined ERs by finding the combination
of MCC and MRG parameters that gives the lowest exon delta between the ERs and
the inputted gold-standard exons. The MCC is minimum read depth that a base pair
needs to have to be considered expressed. The MRG is the maximum number of base
pairs between reads that fall below the MCC before you would not include it as
part of the expressed region. Internally, gold-standard exons are obtained by
finding the non-overlapping exons from the inputted reference annotation.

In this example, we demonstrate `ODER()` on a single unstranded `Bigwig`.
However, in reality, it is likely that you will want to optimise the ER
definitions across multiple `BigWigs`. It is worth noting that the arguments
`bw_pos` and `bw_neg` in `ODER()` allow for the input of stranded `BigWigs`.

```
# load reference annotation from Ensembl
gtf_url <- paste0(
    "http://ftp.ensembl.org/pub/release-103/gtf/homo_sapiens",
    "/Homo_sapiens.GRCh38.103.chr.gtf.gz"
)
gtf_path <- file_cache(gtf_url)
gtf_gr <- rtracklayer::import(gtf_path)
# As of rtracklayer 1.25.16, BigWig is not supported on Windows.
if (!xfun::is_windows()) {
    opt_ers <- ODER(
        bw_paths = bw_path, auc_raw = gtex_metadata[["auc"]][1],
        auc_target = 40e6 * 100, chrs = c("chr21"),
        genome = "hg38", mccs = c(2, 4, 6, 8, 10), mrgs = c(10, 20, 30),
        gtf = gtf_gr, ucsc_chr = TRUE, ignore.strand = TRUE,
        exons_no_overlap = NULL, bw_chr = "chr"
    )
}
#> Loading required package: BiocGenerics
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, intersect, is.unsorted,
#>     lapply, mapply, match, mget, order, paste, pmax, pmax.int, pmin,
#>     pmin.int, rank, rbind, rownames, sapply, setdiff, sort, table,
#>     tapply, union, unique, unsplit, which.max, which.min
#> Loading required package: S4Vectors
#> Loading required package: stats4
#>
#> Attaching package: 'S4Vectors'
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> 2021-10-26 18:06:59 - Obtaining mean coverage across 1 samples
#> 2021-10-26 18:06:59 - chr21
#> 2021-10-26 18:06:59 - Generating ERs for chr21
#> 2021-10-26 18:07:03 - Obtaining non-overlapping exons
#> 2021-10-26 18:07:11 - Calculating delta for ERs...
#> 2021-10-26 18:07:17 - Obtaining optimal set of ERs...
```

Once we have the obtained the optimised set of ERs, we may consider plotting the
exon delta across the various MCCs and MRGs. This can be useful to check the
error associated with the definition of the set of optimised ERs. This error is
measured through two metrics; the median exon delta and the number of ERs with
exon delta equal to 0. The median exon delta represents the overall accuracy of
all ER definitions, whereas the number of ERs with exon delta equal to 0
indicates the extent to which ER definitions precisely match overlapping
gold-standard exon boundaries.

```
# visualise the spread of mccs and mrgs
if (!xfun::is_windows()) { # uses product of ODER
    plot_ers(opt_ers[["deltas"]], opt_ers[["opt_mcc_mrg"]])
}
```

![](data:image/png;base64...)

Next, we will use `annotatERs()` to find the overlap between the ERs and
junctions. Furthermore, `annotatERs()` will also classify ERs by their overlap
with existing reference annotation into the categories; “exon”, “intron” and
“intergenic”. This can be helpful for two reasons. Primarily, junctions can be
used to inform which gene the ER is associated to. This gene-level association
can be useful multiple downstream applications, such as novel exon discovery.
Furthermore, the category of ER, in terms of whether it overlaps a exonic,
intronic or intergenic region, can help determine whether the ER represents
novel expression. For example, ERs solely overlapping intronic or intergenic
regions and associated with a gene can be the indication of the expression of
an unannotated exon.

To note, it is recommended that the inputted junctions are derived from the same
samples or tissue as the `BigWig` files used to define ERs.

```
library(utils)
# running only chr21 to reduce runtime
chrs_to_keep <- c("21")

# prepare the txdb object to create a genomic state
# based on https://support.bioconductor.org/p/93235/
hg38_chrominfo <- GenomeInfoDb::getChromInfoFromUCSC("hg38")

new_info <- hg38_chrominfo$size[match(
    chrs_to_keep,
    GenomeInfoDb::mapSeqlevels(hg38_chrominfo$chrom, "Ensembl")
)]

names(new_info) <- chrs_to_keep
gtf_gr_tx <- GenomeInfoDb::keepSeqlevels(gtf_gr,
    chrs_to_keep,
    pruning.mode = "tidy"
)

GenomeInfoDb::seqlengths(gtf_gr_tx) <- new_info
GenomeInfoDb::seqlevelsStyle(gtf_gr_tx) <- "UCSC"
GenomeInfoDb::genome(gtf_gr_tx) <- "hg38"

ucsc_txdb <- GenomicFeatures::makeTxDbFromGRanges(gtf_gr_tx)
#> Warning in .get_cds_IDX(mcols0$type, mcols0$phase): The "phase" metadata column contains non-NA values for features of type
#>   stop_codon. This information was ignored.
genom_state <- derfinder::makeGenomicState(txdb = ucsc_txdb)
#> extendedMapSeqlevels: sequence names mapped from NCBI to UCSC for species homo_sapiens
#> 'select()' returned 1:1 mapping between keys and columns

# convert UCSC chrs format to Ensembl to match the ERs
ens_txdb <- ucsc_txdb
GenomeInfoDb::seqlevelsStyle(ens_txdb) <- "Ensembl"

# lung_junc_21_22 is an example data set of junctions
# obtained from recount3, derived from the lung tissue
# run annotatERs()
data(lung_junc_21_22, package = "ODER")
if (!xfun::is_windows()) { # uses product of ODER
    annot_ers <- annotatERs(
        opt_ers = head(opt_ers[["opt_ers"]], 100),
        junc_data = lung_junc_21_22,
        genom_state = genom_state,
        gtf = gtf_gr,
        txdb = ens_txdb
    )

    # print first 5 ERs
    annot_ers[1:5]
}
#> [1] "2021-10-26 18:07:30 - Obtaining co-ordinates of annotated exons and junctions..."
#> [1] "2021-10-26 18:07:31 - Getting junction annotation using overlapping exons..."
#> [1] "2021-10-26 18:07:31 - Tidying junction annotation..."
#> [1] "2021-10-26 18:07:32 - Deriving junction categories..."
#> [1] "2021-10-26 18:07:32 - done!"
#> 2021-10-26 18:07:32 - Finding junctions overlapping ers...
#> 2021-10-26 18:07:35 - Annotating the Expressed regions...
#> 2021-10-26 18:07:35 annotateRegions: counting
#> 2021-10-26 18:07:35 annotateRegions: annotating
#> 2021-10-26 18:07:45 - done!
#> GRanges object with 5 ranges and 5 metadata columns:
#>       seqnames          ranges strand |           grl           genes
#>          <Rle>       <IRanges>  <Rle> | <GRangesList> <CharacterList>
#>   [1]    chr21 5032176-5032217      * |               ENSG00000277117
#>   [2]    chr21 5033408-5033425      * |               ENSG00000277117
#>   [3]    chr21 5034717-5034756      * |               ENSG00000277117
#>   [4]    chr21 5035188-5035189      * |               ENSG00000277117
#>   [5]    chr21 5036577-5036581      * |               ENSG00000277117
#>        annotation  og_index       gene_source
#>       <character> <integer>       <character>
#>   [1]        exon         1 nearest gtf genes
#>   [2]        exon         2 nearest gtf genes
#>   [3]        exon         3 nearest gtf genes
#>   [4]        exon         4 nearest gtf genes
#>   [5]        exon         5 nearest gtf genes
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

After we have annotated ERs with the overlapping junctions, optionally we can
use `refine_ers()` to refine the starts and ends of the ERs based on the
overlapping junctions. This will filter ERs for those which have either a single
or two non-intersecting junctions overlapping. For the remaining ERs,
`refine_ers()` will shave the ER definitions to the exon boundaries matching the
overlapping junctions. This can be useful for downstream applications whereby
the accuracy of the ER definition is extremely important. For example, the
interpretion of variants in diagnostic setting.

```
if (!xfun::is_windows()) { # uses product of ODER
    refined_ers <- refine_ERs(annot_ers)

    refined_ers
}
#> 2021-10-26 18:07:49 - Refining the Expressed regions...
#> GRanges object with 2 ranges and 5 metadata columns:
#>       seqnames          ranges strand |                     grl           genes
#>          <Rle>       <IRanges>  <Rle> |           <GRangesList> <CharacterList>
#>   [1]    chr21 5093713-5093743      * | chr21:5093712-5093744:+ ENSG00000280071
#>   [2]    chr21 5162182-5162248      * | chr21:5162249-5162287:+ ENSG00000280433
#>        annotation  og_index       gene_source
#>       <character> <integer>       <character>
#>   [1]      intron        15 nearest gtf genes
#>   [2]      intron        71 nearest gtf genes
#>   -------
#>   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

Finally, we can generate an ER count matrix with `get_count_matrix()`. This
function can flexibly be run at any stage of the `ODER` pipeline and it requires
a set of `GenomicRanges` and `BigWig` paths as input. `get_count_matrix()` will
return a `RangedSummarizedExperiment` which has `assays` filled with the mean
coverage across each inputted range. Internally, `get_count_matrix()` relies on
*[megadepth](https://bioconductor.org/packages/3.14/megadepth)* to obtain coverage from `BigWigs` therefore
`megadepth::install_megadepth()` must be executed at least once on the user’s
system before `get_count_matrix()`.

```
# create sample metadata containing identifiers for each BigWig
run <- gtex_metadata[["run"]][[1]]
col_info <- as.data.frame(run)

# install megadepth
megadepth::install_megadepth()
#> The latest megadepth version is 1.1.1
#> This is not an interactive session, therefore megadepth has been installed temporarily to
#> /tmp/RtmpnAkezX/megadepth
if (!xfun::is_windows()) { # uses product of ODER
    er_count_matrix <- get_count_matrix(
        bw_paths = bw_path, annot_ers = annot_ers,
        cols = col_info
    )

    er_count_matrix
}
#> Warning in is.na(.x): is.na() applied to non-(list or vector) of type 'S4'
#> class: RangedSummarizedExperiment
#> dim: 100 1
#> metadata(0):
#> assays(1): ''
#> rownames: NULL
#> rowData names(5): grl genes annotation og_index gene_source
#> colnames: NULL
#> colData names(1): run
```

# 4 Reproducibility

The *[ODER](https://bioconductor.org/packages/3.14/ODER)* package (eolagbaju, 2021) was made possible
thanks to:

* R (R Core Team, 2021)
* *[BiocStyle](https://bioconductor.org/packages/3.14/BiocStyle)* (Oleś, 2021)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2021)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng, Chang, and Iannone, 2021)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Csárdi, core, Wickham, Chang, Flight, Müller, and Hester, 2018)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)

This package was developed using *[biocthis](https://bioconductor.org/packages/3.14/biocthis)*.

Date the vignette was generated.

```
#> [1] "2021-10-26 18:08:26 EDT"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 3.319 mins
```

`R` session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.1.1 (2021-08-10)
#>  os       Ubuntu 20.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2021-10-26
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package              * version  date       lib source
#>  abind                  1.4-5    2016-07-21 [2] CRAN (R 4.1.1)
#>  AnnotationDbi          1.56.0   2021-10-26 [2] Bioconductor
#>  assertthat             0.2.1    2019-03-21 [2] CRAN (R 4.1.1)
#>  backports              1.2.1    2020-12-09 [2] CRAN (R 4.1.1)
#>  base64enc              0.1-3    2015-07-28 [2] CRAN (R 4.1.1)
#>  basilisk               1.6.0    2021-10-26 [2] Bioconductor
#>  basilisk.utils         1.6.0    2021-10-26 [2] Bioconductor
#>  Biobase                2.54.0   2021-10-26 [2] Bioconductor
#>  BiocFileCache          2.2.0    2021-10-26 [2] Bioconductor
#>  BiocGenerics         * 0.40.0   2021-10-26 [2] Bioconductor
#>  BiocIO                 1.4.0    2021-10-26 [2] Bioconductor
#>  BiocManager            1.30.16  2021-06-15 [2] CRAN (R 4.1.1)
#>  BiocParallel           1.28.0   2021-10-26 [2] Bioconductor
#>  BiocStyle            * 2.22.0   2021-10-26 [2] Bioconductor
#>  biomaRt                2.50.0   2021-10-26 [2] Bioconductor
#>  Biostrings             2.62.0   2021-10-26 [2] Bioconductor
#>  bit                    4.0.4    2020-08-04 [2] CRAN (R 4.1.1)
#>  bit64                  4.0.5    2020-08-30 [2] CRAN (R 4.1.1)
#>  bitops                 1.0-7    2021-04-24 [2] CRAN (R 4.1.1)
#>  blob                   1.2.2    2021-07-23 [2] CRAN (R 4.1.1)
#>  bookdown               0.24     2021-09-02 [2] CRAN (R 4.1.1)
#>  broom                  0.7.9    2021-07-27 [2] CRAN (R 4.1.1)
#>  BSgenome               1.62.0   2021-10-26 [2] Bioconductor
#>  bslib                  0.3.1    2021-10-06 [2] CRAN (R 4.1.1)
#>  bumphunter             1.36.0   2021-10-26 [2] Bioconductor
#>  cachem                 1.0.6    2021-08-19 [2] CRAN (R 4.1.1)
#>  car                    3.0-11   2021-06-27 [2] CRAN (R 4.1.1)
#>  carData                3.0-4    2020-05-22 [2] CRAN (R 4.1.1)
#>  cellranger             1.1.0    2016-07-27 [2] CRAN (R 4.1.1)
#>  checkmate              2.0.0    2020-02-06 [2] CRAN (R 4.1.1)
#>  cli                    3.0.1    2021-07-17 [2] CRAN (R 4.1.1)
#>  cluster                2.1.2    2021-04-17 [2] CRAN (R 4.1.1)
#>  cmdfun                 1.0.2    2020-10-10 [2] CRAN (R 4.1.1)
#>  codetools              0.2-18   2020-11-04 [2] CRAN (R 4.1.1)
#>  colorspace             2.0-2    2021-06-24 [2] CRAN (R 4.1.1)
#>  cowplot                1.1.1    2020-12-30 [2] CRAN (R 4.1.1)
#>  crayon                 1.4.1    2021-02-08 [2] CRAN (R 4.1.1)
#>  curl                   4.3.2    2021-06-23 [2] CRAN (R 4.1.1)
#>  dasper                 1.4.0    2021-10-26 [2] Bioconductor
#>  data.table             1.14.2   2021-09-27 [2] CRAN (R 4.1.1)
#>  DBI                    1.1.1    2021-01-15 [2] CRAN (R 4.1.1)
#>  dbplyr                 2.1.1    2021-04-06 [2] CRAN (R 4.1.1)
#>  DelayedArray           0.20.0   2021-10-26 [2] Bioconductor
#>  derfinder              1.28.0   2021-10-26 [2] Bioconductor
#>  derfinderHelper        1.28.0   2021-10-26 [2] Bioconductor
#>  desc                   1.4.0    2021-09-28 [2] CRAN (R 4.1.1)
#>  digest                 0.6.28   2021-09-23 [2] CRAN (R 4.1.1)
#>  dir.expiry             1.2.0    2021-10-26 [2] Bioconductor
#>  doRNG                  1.8.2    2020-01-27 [2] CRAN (R 4.1.1)
#>  downloader             0.4      2015-07-09 [2] CRAN (R 4.1.1)
#>  dplyr                  1.0.7    2021-06-18 [2] CRAN (R 4.1.1)
#>  ellipsis               0.3.2    2021-04-29 [2] CRAN (R 4.1.1)
#>  evaluate               0.14     2019-05-28 [2] CRAN (R 4.1.1)
#>  fansi                  0.5.0    2021-05-25 [2] CRAN (R 4.1.1)
#>  farver                 2.1.0    2021-02-28 [2] CRAN (R 4.1.1)
#>  fastmap                1.1.0    2021-01-25 [2] CRAN (R 4.1.1)
#>  filelock               1.0.2    2018-10-05 [2] CRAN (R 4.1.1)
#>  forcats                0.5.1    2021-01-27 [2] CRAN (R 4.1.1)
#>  foreach                1.5.1    2020-10-15 [2] CRAN (R 4.1.1)
#>  foreign                0.8-81   2020-12-22 [2] CRAN (R 4.1.1)
#>  Formula                1.2-4    2020-10-16 [2] CRAN (R 4.1.1)
#>  fs                     1.5.0    2020-07-31 [2] CRAN (R 4.1.1)
#>  generics               0.1.1    2021-10-25 [2] CRAN (R 4.1.1)
#>  GenomeInfoDb         * 1.30.0   2021-10-26 [2] Bioconductor
#>  GenomeInfoDbData       1.2.7    2021-09-23 [2] Bioconductor
#>  GenomicAlignments      1.30.0   2021-10-26 [2] Bioconductor
#>  GenomicFeatures        1.46.0   2021-10-26 [2] Bioconductor
#>  GenomicFiles           1.30.0   2021-10-26 [2] Bioconductor
#>  GenomicRanges          1.46.0   2021-10-26 [2] Bioconductor
#>  GEOquery               2.62.0   2021-10-26 [2] Bioconductor
#>  ggplot2                3.3.5    2021-06-25 [2] CRAN (R 4.1.1)
#>  ggpubr                 0.4.0    2020-06-27 [2] CRAN (R 4.1.1)
#>  ggrepel                0.9.1    2021-01-15 [2] CRAN (R 4.1.1)
#>  ggsignif               0.6.3    2021-09-09 [2] CRAN (R 4.1.1)
#>  glue                   1.4.2    2020-08-27 [2] CRAN (R 4.1.1)
#>  gridExtra              2.3      2017-09-09 [2] CRAN (R 4.1.1)
#>  gtable                 0.3.0    2019-03-25 [2] CRAN (R 4.1.1)
#>  haven                  2.4.3    2021-08-04 [2] CRAN (R 4.1.1)
#>  highr                  0.9      2021-04-16 [2] CRAN (R 4.1.1)
#>  Hmisc                  4.6-0    2021-10-07 [2] CRAN (R 4.1.1)
#>  hms                    1.1.1    2021-09-26 [2] CRAN (R 4.1.1)
#>  htmlTable              2.3.0    2021-10-12 [2] CRAN (R 4.1.1)
#>  htmltools              0.5.2    2021-08-25 [2] CRAN (R 4.1.1)
#>  htmlwidgets            1.5.4    2021-09-08 [2] CRAN (R 4.1.1)
#>  httr                   1.4.2    2020-07-20 [2] CRAN (R 4.1.1)
#>  IRanges              * 2.28.0   2021-10-26 [2] Bioconductor
#>  iterators              1.0.13   2020-10-15 [2] CRAN (R 4.1.1)
#>  jpeg                   0.1-9    2021-07-24 [2] CRAN (R 4.1.1)
#>  jquerylib              0.1.4    2021-04-26 [2] CRAN (R 4.1.1)
#>  jsonlite               1.7.2    2020-12-09 [2] CRAN (R 4.1.1)
#>  KEGGREST               1.34.0   2021-10-26 [2] Bioconductor
#>  knitr                  1.36     2021-09-29 [2] CRAN (R 4.1.1)
#>  labeling               0.4.2    2020-10-20 [2] CRAN (R 4.1.1)
#>  lattice                0.20-45  2021-09-22 [2] CRAN (R 4.1.1)
#>  latticeExtra           0.6-29   2019-12-19 [2] CRAN (R 4.1.1)
#>  lifecycle              1.0.1    2021-09-24 [2] CRAN (R 4.1.1)
#>  limma                  3.50.0   2021-10-26 [2] Bioconductor
#>  locfit                 1.5-9.4  2020-03-25 [2] CRAN (R 4.1.1)
#>  lubridate              1.8.0    2021-10-07 [2] CRAN (R 4.1.1)
#>  magrittr             * 2.0.1    2020-11-17 [2] CRAN (R 4.1.1)
#>  Matrix                 1.3-4    2021-06-01 [2] CRAN (R 4.1.1)
#>  MatrixGenerics         1.6.0    2021-10-26 [2] Bioconductor
#>  matrixStats            0.61.0   2021-09-17 [2] CRAN (R 4.1.1)
#>  megadepth              1.4.0    2021-10-26 [2] Bioconductor
#>  memoise                2.0.0    2021-01-26 [2] CRAN (R 4.1.1)
#>  munsell                0.5.0    2018-06-12 [2] CRAN (R 4.1.1)
#>  nnet                   7.3-16   2021-05-03 [2] CRAN (R 4.1.1)
#>  ODER                 * 1.0.0    2021-10-26 [1] Bioconductor
#>  openxlsx               4.2.4    2021-06-16 [2] CRAN (R 4.1.1)
#>  pillar                 1.6.4    2021-10-18 [2] CRAN (R 4.1.1)
#>  pkgconfig              2.0.3    2019-09-22 [2] CRAN (R 4.1.1)
#>  pkgload                1.2.3    2021-10-13 [2] CRAN (R 4.1.1)
#>  plyr                   1.8.6    2020-03-03 [2] CRAN (R 4.1.1)
#>  png                    0.1-7    2013-12-03 [2] CRAN (R 4.1.1)
#>  prettyunits            1.1.1    2020-01-24 [2] CRAN (R 4.1.1)
#>  progress               1.2.2    2019-05-16 [2] CRAN (R 4.1.1)
#>  purrr                  0.3.4    2020-04-17 [2] CRAN (R 4.1.1)
#>  qvalue                 2.26.0   2021-10-26 [2] Bioconductor
#>  R6                     2.5.1    2021-08-19 [2] CRAN (R 4.1.1)
#>  rappdirs               0.3.3    2021-01-31 [2] CRAN (R 4.1.1)
#>  RColorBrewer           1.1-2    2014-12-07 [2] CRAN (R 4.1.1)
#>  Rcpp                   1.0.7    2021-07-07 [2] CRAN (R 4.1.1)
#>  RCurl                  1.98-1.5 2021-09-17 [2] CRAN (R 4.1.1)
#>  readr                  2.0.2    2021-09-27 [2] CRAN (R 4.1.1)
#>  readxl                 1.3.1    2019-03-13 [2] CRAN (R 4.1.1)
#>  recount                1.20.0   2021-10-26 [2] Bioconductor
#>  RefManageR           * 1.3.0    2020-11-13 [2] CRAN (R 4.1.1)
#>  rentrez                1.2.3    2020-11-10 [2] CRAN (R 4.1.1)
#>  reshape2               1.4.4    2020-04-09 [2] CRAN (R 4.1.1)
#>  restfulr               0.0.13   2017-08-06 [2] CRAN (R 4.1.1)
#>  reticulate             1.22     2021-09-17 [2] CRAN (R 4.1.1)
#>  rio                    0.5.27   2021-06-21 [2] CRAN (R 4.1.1)
#>  rjson                  0.2.20   2018-06-08 [2] CRAN (R 4.1.1)
#>  rlang                  0.4.12   2021-10-18 [2] CRAN (R 4.1.1)
#>  rmarkdown              2.11     2021-09-14 [2] CRAN (R 4.1.1)
#>  rngtools               1.5.2    2021-09-20 [2] CRAN (R 4.1.1)
#>  rpart                  4.1-15   2019-04-12 [2] CRAN (R 4.1.1)
#>  rprojroot              2.0.2    2020-11-15 [2] CRAN (R 4.1.1)
#>  Rsamtools              2.10.0   2021-10-26 [2] Bioconductor
#>  RSQLite                2.2.8    2021-08-21 [2] CRAN (R 4.1.1)
#>  rstatix                0.7.0    2021-02-13 [2] CRAN (R 4.1.1)
#>  rstudioapi             0.13     2020-11-12 [2] CRAN (R 4.1.1)
#>  rtracklayer            1.54.0   2021-10-26 [2] Bioconductor
#>  S4Vectors            * 0.32.0   2021-10-26 [2] Bioconductor
#>  sass                   0.4.0    2021-05-12 [2] CRAN (R 4.1.1)
#>  scales                 1.1.1    2020-05-11 [2] CRAN (R 4.1.1)
#>  sessioninfo          * 1.1.1    2018-11-05 [2] CRAN (R 4.1.1)
#>  stringi                1.7.5    2021-10-04 [2] CRAN (R 4.1.1)
#>  stringr                1.4.0    2019-02-10 [2] CRAN (R 4.1.1)
#>  SummarizedExperiment   1.24.0   2021-10-26 [2] Bioconductor
#>  survival               3.2-13   2021-08-24 [2] CRAN (R 4.1.1)
#>  testthat               3.1.0    2021-10-04 [2] CRAN (R 4.1.1)
#>  tibble                 3.1.5    2021-09-30 [2] CRAN (R 4.1.1)
#>  tidyr                  1.1.4    2021-09-27 [2] CRAN (R 4.1.1)
#>  tidyselect             1.1.1    2021-04-30 [2] CRAN (R 4.1.1)
#>  tzdb                   0.1.2    2021-07-20 [2] CRAN (R 4.1.1)
#>  utf8                   1.2.2    2021-07-24 [2] CRAN (R 4.1.1)
#>  VariantAnnotation      1.40.0   2021-10-26 [2] Bioconductor
#>  vctrs                  0.3.8    2021-04-29 [2] CRAN (R 4.1.1)
#>  vroom                  1.5.5    2021-09-14 [2] CRAN (R 4.1.1)
#>  waldo                  0.3.1    2021-09-14 [2] CRAN (R 4.1.1)
#>  withr                  2.4.2    2021-04-18 [2] CRAN (R 4.1.1)
#>  xfun                   0.27     2021-10-18 [2] CRAN (R 4.1.1)
#>  XML                    3.99-0.8 2021-09-17 [2] CRAN (R 4.1.1)
#>  xml2                   1.3.2    2020-04-23 [2] CRAN (R 4.1.1)
#>  XVector                0.34.0   2021-10-26 [2] Bioconductor
#>  yaml                   2.2.1    2020-02-01 [2] CRAN (R 4.1.1)
#>  zip                    2.2.0    2021-05-31 [2] CRAN (R 4.1.1)
#>  zlibbioc               1.40.0   2021-10-26 [2] Bioconductor
#>
#> [1] /tmp/Rtmp6FpoE7/Rinst17c2cddbed392
#> [2] /home/biocbuild/bbs-3.14-bioc/R/library
```