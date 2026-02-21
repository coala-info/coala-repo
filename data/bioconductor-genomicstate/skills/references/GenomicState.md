# Introduction to GenomicState

Leonardo Collado-Torres1,2\*

1Lieber Institute for Brain Development, Johns Hopkins Medical Campus
2Center for Computational Biology, Johns Hopkins University

\*lcolladotor@gmail.com

#### 30 July 2025

#### Package

GenomicState 0.99.17

# Contents

* [1 Basics](#basics)
  + [1.1 Install *GenomicState*](#install-genomicstate)
  + [1.2 Required knowledge](#required-knowledge)
  + [1.3 Asking for help](#asking-for-help)
  + [1.4 Citing *GenomicState*](#citing-genomicstate)
* [2 Overview](#overview)
* [3 AnnotationHub](#annotationhub)
* [4 Using the objects](#using-the-objects)
* [5 JHPCE](#jhpce)
* [6 Build objects](#build-objects)
* [7 Reproducibility](#reproducibility)
* [8 Bibliography](#bibliography)

# 1 Basics

## 1.1 Install *[GenomicState](https://bioconductor.org/packages/3.22/GenomicState)*

`R` is an open-source statistical environment which can be easily modified to enhance its functionality via packages. *[GenomicState](https://bioconductor.org/packages/3.22/GenomicState)* is a `R` package available via Bioconductor. `R` can be installed on any operating system from [CRAN](https://cran.r-project.org/) after which you can install *[GenomicState](https://bioconductor.org/packages/3.22/GenomicState)* by using the following commands in your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("GenomicState")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

## 1.2 Required knowledge

*[GenomicState](https://bioconductor.org/packages/3.22/GenomicState)* is based on many other packages and in particular in those that have implemented the infrastructure needed for dealing with annotation data. That is, packages like *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)* that allow you to import the data. A *[GenomicState](https://bioconductor.org/packages/3.22/GenomicState)* user is not expected to deal with those packages directly but will need to be familiar with *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* and *[derfinderPlot](https://bioconductor.org/packages/3.22/derfinderPlot)* to understand the results *[GenomicState](https://bioconductor.org/packages/3.22/GenomicState)* generates. Furthermore, it’ll be useful for the user to know the syntax of *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* (Morgan and Shepherd, 2025) in order to query and load the data provided by this package.

If you are asking yourself the question “Where do I start using Bioconductor?” you might be interested in [this blog post](http://lcolladotor.github.io/2014/10/16/startbioc/#.VkOKbq6rRuU).

## 1.3 Asking for help

As package developers, we try to explain clearly how to use our packages and in which order to use the functions. But `R` and `Bioconductor` have a steep learning curve so it is critical to learn where to ask for help. The blog post quoted above mentions some but we would like to highlight the [Bioconductor support site](https://support.bioconductor.org/) as the main resource for getting help regarding Bioconductor. Other alternatives are available such as creating GitHub issues and tweeting. However, please note that if you want to receive help you should adhere to the [posting guidelines](http://www.bioconductor.org/help/support/posting-guide/). It is particularly critical that you provide a small reproducible example and your session information so package developers can track down the source of the error.

## 1.4 Citing *[GenomicState](https://bioconductor.org/packages/3.22/GenomicState)*

We hope that *[GenomicState](https://bioconductor.org/packages/3.22/GenomicState)* will be useful for your research. Please use the following information to cite the package and the overall approach. Thank you!

```
## Citation info
citation("GenomicState")
#> To cite package 'GenomicState' in publications use:
#>
#>   Collado-Torres L (2025). _Build and access GenomicState objects for
#>   use with derfinder tools from sources like Gencode_.
#>   doi:10.18129/B9.bioc.GenomicState
#>   <https://doi.org/10.18129/B9.bioc.GenomicState>,
#>   https://github.com/LieberInstitute/GenomicState - R package version
#>   0.99.17, <http://www.bioconductor.org/packages/GenomicState>.
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Manual{,
#>     title = {Build and access GenomicState objects for use with derfinder tools from sources like Gencode},
#>     author = {Leonardo Collado-Torres},
#>     year = {2025},
#>     url = {http://www.bioconductor.org/packages/GenomicState},
#>     note = {https://github.com/LieberInstitute/GenomicState - R package version 0.99.17},
#>     doi = {10.18129/B9.bioc.GenomicState},
#>   }
```

# 2 Overview

The *[GenomicState](https://bioconductor.org/packages/3.22/GenomicState)* package was developed for speeding up analyses that require these objects and in particular those that rely on Gencode annotation data. The package *[GenomicState](https://bioconductor.org/packages/3.22/GenomicState)* provides functions for building `GenomicState` objects from diverse annotation sources such as [`Gencode`](https://www.gencodegenes.org/human/releases.html). It also provides a way to load pre-computed `GenomicState` objects if you are working at [JHPCE](https://jhpce.jhu.edu/). These `GenomicState` objects are normally created using [derfinder::makeGenomicState()](https://rdrr.io/bioc/derfinder/man/makeGenomicState.html) and can be used for annotating regions with [derfinder::annotateRegions()](https://rdrr.io/bioc/derfinder/man/annotateRegions.html) which are in turn used by [derfinderPlot::plotRegionCoverage()](https://rdrr.io/bioc/derfinderPlot/man/plotRegionCoverage.html).

To get started, load the *[GenomicState](https://bioconductor.org/packages/3.22/GenomicState)* package.

```
library("GenomicState")
```

# 3 AnnotationHub

Using the `GencodeStateHub()` function you can query and download the data from *[GenomicState](https://bioconductor.org/packages/3.22/GenomicState)* using *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* (Morgan and Shepherd, 2025).

```
## Query AnnotationHub for the GenomicState object for Gencode v31 on
## hg19 coordinates
hub_query_gs_gencode_v31_hg19 <- GenomicStateHub(
    version = "31",
    genome = "hg19",
    filetype = "GenomicState"
)
hub_query_gs_gencode_v31_hg19
#> AnnotationHub with 1 record
#> # snapshotDate(): 2025-06-23
#> # names(): AH75184
#> # $dataprovider: GENCODE
#> # $species: Homo sapiens
#> # $rdataclass: list
#> # $rdatadateadded: 2019-10-22
#> # $title: GenomicState for Gencode v31 on hg19 coordinates
#> # $description: Gencode v31 GenomicState from derfinder::makeGenomicState() ...
#> # $taxonomyid: 9606
#> # $genome: GRCh37
#> # $sourcetype: GTF
#> # $sourceurl: ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/releas...
#> # $sourcesize: NA
#> # $tags: c("Gencode", "GenomicState", "hg19", "v31")
#> # retrieve record with 'object[["AH75184"]]'

## Check the metadata
mcols(hub_query_gs_gencode_v31_hg19)
#> DataFrame with 1 row and 15 columns
#>                          title dataprovider      species taxonomyid      genome
#>                    <character>  <character>  <character>  <integer> <character>
#> AH75184 GenomicState for Gen..      GENCODE Homo sapiens       9606      GRCh37
#>                    description coordinate_1_based             maintainer
#>                    <character>          <integer>            <character>
#> AH75184 Gencode v31 GenomicS..                  1 Leonardo Collado-Tor..
#>         rdatadateadded preparerclass                          tags  rdataclass
#>            <character>   <character>                        <AsIs> <character>
#> AH75184     2019-10-22  GenomicState Gencode,GenomicState,hg19,...        list
#>                      rdatapath              sourceurl  sourcetype
#>                    <character>            <character> <character>
#> AH75184 GenomicState/gencode.. ftp://ftp.ebi.ac.uk/..         GTF

## Access the file through AnnotationHub
if (length(hub_query_gs_gencode_v31_hg19) == 1) {
    hub_gs_gencode_v31_hg19 <- hub_query_gs_gencode_v31_hg19[[1]]

    hub_gs_gencode_v31_hg19
}
#> loading from cache
#> $fullGenome
#> GRanges object with 659263 ranges and 5 metadata columns:
#>          seqnames            ranges strand |   theRegion         tx_id
#>             <Rle>         <IRanges>  <Rle> | <character> <IntegerList>
#>        1     chr1       11869-12227      + |        exon           1,2
#>        2     chr1       12228-12612      + |      intron           1,2
#>        3     chr1       12613-12721      + |        exon           1,2
#>        4     chr1       12722-12974      + |      intron           1,2
#>        5     chr1       12975-13052      + |        exon             2
#>      ...      ...               ...    ... .         ...           ...
#>   659259     chrY 59208555-59214013      * |  intergenic
#>   659260     chrY 59276440-59311662      * |  intergenic
#>   659261     chrY 59311997-59318040      * |  intergenic
#>   659262     chrY 59318921-59330251      * |  intergenic
#>   659263     chrY 59360549-59373566      * |  intergenic
#>                                          tx_name          gene          symbol
#>                                  <CharacterList> <IntegerList> <CharacterList>
#>        1 ENST00000450305.2_1,ENST00000456328.2_1         26085         DDX11L1
#>        2 ENST00000450305.2_1,ENST00000456328.2_1         26085         DDX11L1
#>        3 ENST00000450305.2_1,ENST00000456328.2_1         26085         DDX11L1
#>        4 ENST00000450305.2_1,ENST00000456328.2_1         26085         DDX11L1
#>        5                     ENST00000450305.2_1         26085         DDX11L1
#>      ...                                     ...           ...             ...
#>   659259
#>   659260
#>   659261
#>   659262
#>   659263
#>   -------
#>   seqinfo: 24 sequences from hg19 genome
#>
#> $codingGenome
#> GRanges object with 878954 ranges and 5 metadata columns:
#>          seqnames            ranges strand |   theRegion         tx_id
#>             <Rle>         <IRanges>  <Rle> | <character> <IntegerList>
#>        1     chr1        9869-11868      + |    promoter           1,2
#>        2     chr1       11869-12227      + |        exon           1,2
#>        3     chr1       12228-12612      + |      intron           1,2
#>        4     chr1       12613-12721      + |        exon           1,2
#>        5     chr1       12722-12974      + |      intron           1,2
#>      ...      ...               ...    ... .         ...           ...
#>   878950     chrY 59208555-59212013      * |  intergenic
#>   878951     chrY 59276440-59311662      * |  intergenic
#>   878952     chrY 59313997-59318040      * |  intergenic
#>   878953     chrY 59320921-59328251      * |  intergenic
#>   878954     chrY 59362549-59373566      * |  intergenic
#>                                          tx_name          gene          symbol
#>                                  <CharacterList> <IntegerList> <CharacterList>
#>        1 ENST00000450305.2_1,ENST00000456328.2_1         26085         DDX11L1
#>        2 ENST00000450305.2_1,ENST00000456328.2_1         26085         DDX11L1
#>        3 ENST00000450305.2_1,ENST00000456328.2_1         26085         DDX11L1
#>        4 ENST00000450305.2_1,ENST00000456328.2_1         26085         DDX11L1
#>        5 ENST00000450305.2_1,ENST00000456328.2_1         26085         DDX11L1
#>      ...                                     ...           ...             ...
#>   878950
#>   878951
#>   878952
#>   878953
#>   878954
#>   -------
#>   seqinfo: 24 sequences from hg19 genome
```

# 4 Using the objects

To show how we can use these objects, first we build those for Gencode version 31 on hg19 coordinates.

```
## Load the example TxDb object
## or start from scratch with:
## txdb_v31_hg19_chr21 <- gencode_txdb(version = '31', genome = 'hg19',
##     chrs = 'chr21')
txdb_v31_hg19_chr21 <- AnnotationDbi::loadDb(
    system.file("extdata", "txdb_v31_hg19_chr21.sqlite",
        package = "GenomicState"
    )
)
#> Loading required package: GenomicFeatures
#> Loading required package: S4Vectors
#> Loading required package: stats4
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:utils':
#>
#>     findMatches
#> The following objects are masked from 'package:base':
#>
#>     I, expand.grid, unname
#> Loading required package: IRanges
#> Loading required package: Seqinfo
#> Loading required package: GenomicRanges
#> Loading required package: AnnotationDbi
#> Loading required package: Biobase
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
#>
#> Attaching package: 'Biobase'
#> The following object is masked from 'package:AnnotationHub':
#>
#>     cache

## Build the GenomicState and annotated genes
genes_v31_hg19_chr21 <- gencode_annotated_genes(txdb_v31_hg19_chr21)
#> 2025-07-30 06:32:40.636196 annotating the transcripts
#> No annotationPackage supplied. Trying org.Hs.eg.db.
#> Loading required package: org.Hs.eg.db
#>
#> Getting TSS and TSE.
#> Getting CSS and CSE.
#> Getting exons.
#> Annotating genes.
#> 'select()' returned 1:many mapping between keys and columns
gs_v31_hg19_chr21 <- gencode_genomic_state(txdb_v31_hg19_chr21)
#> 2025-07-30 06:33:12.488622 making the GenomicState object
#> extendedMapSeqlevels: sequence names mapped from NCBI to UCSC for species homo_sapiens
#> 'select()' returned 1:1 mapping between keys and columns
#> 2025-07-30 06:33:20.332789 finding gene symbols
#> 'select()' returned 1:many mapping between keys and columns
#> 2025-07-30 06:33:20.75593 adding gene symbols to the GenomicState
```

You can alternatively use the files hosted in *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* (Morgan and Shepherd, 2025) which will be faster in general.

```
## Create the AnnotationHub object once and re-use it to speed up things
ah <- AnnotationHub::AnnotationHub()

## Find the TxDb object for hg19 Gencode version 31
hub_query_txdb_gencode_v31_hg19 <- GenomicStateHub(
    version = "31",
    genome = "hg19",
    filetype = "TxDb", ah = ah
)
hub_query_txdb_gencode_v31_hg19
#> AnnotationHub with 1 record
#> # snapshotDate(): 2025-06-23
#> # names(): AH75182
#> # $dataprovider: GENCODE
#> # $species: Homo sapiens
#> # $rdataclass: TxDb
#> # $rdatadateadded: 2019-10-22
#> # $title: TxDb for Gencode v31 on hg19 coordinates
#> # $description: Gencode v31 TxDb object on hg19 coordinates. This is useful ...
#> # $taxonomyid: 9606
#> # $genome: GRCh37
#> # $sourcetype: GTF
#> # $sourceurl: ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/releas...
#> # $sourcesize: NA
#> # $tags: c("Gencode", "GenomicState", "hg19", "v31")
#> # retrieve record with 'object[["AH75182"]]'

## Now the Annotated Genes for hg19 Gencode v31
hub_query_genes_gencode_v31_hg19 <- GenomicStateHub(
    version = "31",
    genome = "hg19",
    filetype = "AnnotatedGenes", ah = ah
)
hub_query_genes_gencode_v31_hg19
#> AnnotationHub with 1 record
#> # snapshotDate(): 2025-06-23
#> # names(): AH75183
#> # $dataprovider: GENCODE
#> # $species: Homo sapiens
#> # $rdataclass: GRanges
#> # $rdatadateadded: 2019-10-22
#> # $title: Annotated genes for Gencode v31 on hg19 coordinates
#> # $description: Gencode v31 annotated genes from bumphunter::annotateTranscr...
#> # $taxonomyid: 9606
#> # $genome: GRCh37
#> # $sourcetype: GTF
#> # $sourceurl: ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/releas...
#> # $sourcesize: NA
#> # $tags: c("Gencode", "GenomicState", "hg19", "v31")
#> # retrieve record with 'object[["AH75183"]]'

## And finally the GenomicState for hg19 Gencode v31
hub_query_gs_gencode_v31_hg19 <- GenomicStateHub(
    version = "31",
    genome = "hg19",
    filetype = "GenomicState", ah = ah
)
hub_query_gs_gencode_v31_hg19
#> AnnotationHub with 1 record
#> # snapshotDate(): 2025-06-23
#> # names(): AH75184
#> # $dataprovider: GENCODE
#> # $species: Homo sapiens
#> # $rdataclass: list
#> # $rdatadateadded: 2019-10-22
#> # $title: GenomicState for Gencode v31 on hg19 coordinates
#> # $description: Gencode v31 GenomicState from derfinder::makeGenomicState() ...
#> # $taxonomyid: 9606
#> # $genome: GRCh37
#> # $sourcetype: GTF
#> # $sourceurl: ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/releas...
#> # $sourcesize: NA
#> # $tags: c("Gencode", "GenomicState", "hg19", "v31")
#> # retrieve record with 'object[["AH75184"]]'

## If you want to access the files use the double bracket AnnotationHub syntax
## to retrieve the R objects from the web.
if (FALSE) {
    hub_txdb_gencode_v31_hg19 <- hub_query_txdb_gencode_v31_hg19[[1]]
    hub_genes_gencode_v31_hg19 <- hub_query_genes_gencode_v31_hg19[[1]]
    hub_gs_gencode_v31_hg19 <- hub_query_gs_gencode_v31_hg19[[1]]
}
```

Next we load a series of related packages that use the objects we created with *[GenomicState](https://bioconductor.org/packages/3.22/GenomicState)* or downloaded from *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* (Morgan and Shepherd, 2025).

```
## Load external packages
library("derfinder")
library("derfinderPlot")
library("bumphunter")
#> Loading required package: foreach
#> Loading required package: iterators
#> Loading required package: parallel
#> Loading required package: locfit
#> locfit 1.5-9.12   2025-03-05
library("GenomicRanges")
```

Next we can prepare the needed for running `derfinderPlot::plotRegionCoverage()` where we use the `TxDb` object, the `GenomicState` and the `annotated genes` we prepared for Gencode v31 on hg19.

```
## Some example regions from derfinder (set the chromosome lengths)
regions <- genomeRegions$regions[1:2]
seqlengths(regions) <- seqlengths(txdb_v31_hg19_chr21)[
    names(seqlengths(regions))
]

## Annotate them
nearestAnnotation <- matchGenes(x = regions, subject = genes_v31_hg19_chr21)
annotatedRegions <- annotateRegions(
    regions = regions,
    genomicState = gs_v31_hg19_chr21$fullGenome, minoverlap = 1
)
#> 2025-07-30 06:33:36.011688 annotateRegions: counting
#> 2025-07-30 06:33:36.108726 annotateRegions: annotating

## Obtain fullCov object
fullCov <- list("chr21" = genomeDataRaw$coverage)
regionCov <- getRegionCoverage(fullCov = fullCov, regions = regions)
#> 2025-07-30 06:33:36.253742 getRegionCoverage: processing chr21
#> 2025-07-30 06:33:36.312827 getRegionCoverage: done processing chr21
```

And now we can make the example plot as shown below.

```
## now make the plot
plotRegionCoverage(
    regions = regions, regionCoverage = regionCov,
    groupInfo = genomeInfo$pop, nearestAnnotation = nearestAnnotation,
    annotatedRegions = annotatedRegions, whichRegions = 1:2,
    txdb = txdb_v31_hg19_chr21, verbose = FALSE
)
```

![](data:image/png;base64...)![](data:image/png;base64...)

# 5 JHPCE

You can also access the data locally using the function `local_metadata()` which works at [JHPCE](https://jhpce.jhu.edu/) or anywhere where you have re-created the files from this package. This returns a `data.frame()` which you can subset. It also inclused the R code for loading the data which you can do using `eval(parse(text = local_metadata()$loadCode))` as shown below.

```
## Get the local metadata
meta <- local_metadata()

## Subset to the data of interest, lets say hg19 TxDb for v31
interest <- subset(meta, RDataClass == "TxDb" & Tags == "Gencode:v31:hg19")

## Next you can load the data
if (file.exists(interest$RDataPath)) {
    ## This only works at JHPCE
    eval(parse(text = interest$loadCode))

    ## Explore the loaded object (would be gencode_v31_hg19_txdb in this case)
    gencode_v31_hg19_txdb
}
```

# 6 Build objects

The objects provided by `GenomicState` through *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* (Morgan and Shepherd, 2025) were built using code like the one included below which is how the Gencode version 23 for hg19 files were built.

```
outdir <- "gencode"
dir.create(outdir, showWarnings = FALSE)

## Build and save the TxDb object
gencode_v23_hg19_txdb <- gencode_txdb("23", "hg19")
saveDb(gencode_v23_hg19_txdb,
    file = file.path(outdir, "gencode_v23_hg19_txdb.sqlite")
)

## Build and save the annotateTranscripts output
gencode_v23_hg19_annotated_genes <- gencode_annotated_genes(
    gencode_v23_hg19_txdb
)
save(gencode_v23_hg19_annotated_genes,
    file = file.path(outdir, "gencode_v23_hg19_annotated_genes.rda")
)

## Build and save the GenomicState
gencode_v23_hg19_GenomicState <- gencode_genomic_state(
    gencode_v23_hg19_txdb
)
save(gencode_v23_hg19_GenomicState,
    file = file.path(outdir, "gencode_v23_hg19_GenomicState.rda")
)
```

For more details check the source files:

```
## R commands for building the files:
system.file("scripts", "make-data_gencode_human.R",
    package = "GenomicState"
)
#> [1] "/tmp/RtmpN308tx/Rinst1601f660b6c6f3/GenomicState/scripts/make-data_gencode_human.R"
## The above file was created by this one:
system.file("scripts", "generate_make_data_gencode_human.R",
    package = "GenomicState"
)
#> [1] "/tmp/RtmpN308tx/Rinst1601f660b6c6f3/GenomicState/scripts/generate_make_data_gencode_human.R"
```

# 7 Reproducibility

The *[GenomicState](https://bioconductor.org/packages/3.22/GenomicState)* package (Collado-Torres, 2025) was made possible thanks to:

* R (R Core Team, 2025)
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
* *[Seqinfo](https://bioconductor.org/packages/3.22/Seqinfo)* (Pagès, 2025)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2014)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng, Chang, and Iannone, 2024)
* *[rtracklayer](https://bioconductor.org/packages/3.22/rtracklayer)* (Lawrence, Gentleman, and Carey, 2009)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight, Müller, and Hester, 2025)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)
* *[GenomicFeatures](https://bioconductor.org/packages/3.22/GenomicFeatures)* (Lawrence, Huber, Pagès, Aboyoun, Carlson, Gentleman, Morgan, and Carey, 2013)
* *[bumphunter](https://bioconductor.org/packages/3.22/bumphunter)* (Jaffe, Murakami, Lee, Leek, Fallin, Feinberg, and Irizarry, 2012)
* *[derfinder](https://bioconductor.org/packages/3.22/derfinder)* (Collado-Torres, Nellore, Frazee, Wilks, Love, Langmead, Irizarry, Leek, and Jaffe, 2017)
* *[AnnotationDbi](https://bioconductor.org/packages/3.22/AnnotationDbi)* (Pagès, Carlson, Falcon, and Li, 2025)
* *[IRanges](https://bioconductor.org/packages/3.22/IRanges)* (Lawrence, Huber, Pagès et al., 2013)
* *[org.Hs.eg.db](https://bioconductor.org/packages/3.22/org.Hs.eg.db)* (Carlson, 2025)
* *[glue](https://CRAN.R-project.org/package%3Dglue)* (Hester and Bryan, 2024)
* *[AnnotationHub](https://bioconductor.org/packages/3.22/AnnotationHub)* (Morgan and Shepherd, 2025)
* *[AnnotationHubData](https://bioconductor.org/packages/3.22/AnnotationHubData)* (Bioconductor Package Maintainer, 2025)
* *[GenomicRanges](https://bioconductor.org/packages/3.22/GenomicRanges)* (Lawrence, Huber, Pagès et al., 2013)
* *[txdbmaker](https://bioconductor.org/packages/3.22/txdbmaker)* (Pagès, Carlson, Aboyoun, Falcon, and Morgan, 2025)

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("GenomicState.Rmd"))

## Extract the R code
library("knitr")
knit("GenomicState.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
#> [1] "2025-07-30 06:33:37 EDT"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 1.453 mins
```

`R` session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 (2025-06-13)
#>  os       Ubuntu 24.04.2 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-07-30
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package              * version   date (UTC) lib source
#>  abind                  1.4-8     2024-09-12 [2] CRAN (R 4.5.1)
#>  AnnotationDbi        * 1.71.1    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  AnnotationFilter       1.33.0    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  AnnotationHub        * 3.99.6    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  backports              1.5.0     2024-05-23 [2] CRAN (R 4.5.1)
#>  base64enc              0.1-3     2015-07-28 [2] CRAN (R 4.5.1)
#>  bibtex                 0.5.1     2023-01-26 [2] CRAN (R 4.5.1)
#>  Biobase              * 2.69.0    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocFileCache        * 2.99.5    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocGenerics         * 0.55.1    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocIO                 1.19.0    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager            1.30.26   2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocParallel           1.43.4    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocStyle            * 2.37.0    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocVersion            3.22.0    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  biomaRt                2.65.0    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  Biostrings             2.77.2    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  biovizBase             1.57.1    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bit                    4.6.0     2025-03-06 [2] CRAN (R 4.5.1)
#>  bit64                  4.6.0-1   2025-01-16 [2] CRAN (R 4.5.1)
#>  bitops                 1.0-9     2024-10-03 [2] CRAN (R 4.5.1)
#>  blob                   1.2.4     2023-03-17 [2] CRAN (R 4.5.1)
#>  bookdown               0.43      2025-04-15 [2] CRAN (R 4.5.1)
#>  BSgenome               1.77.1    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bslib                  0.9.0     2025-01-30 [2] CRAN (R 4.5.1)
#>  bumphunter           * 1.51.1    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  cachem                 1.1.0     2024-05-16 [2] CRAN (R 4.5.1)
#>  checkmate              2.3.2     2024-07-29 [2] CRAN (R 4.5.1)
#>  cli                    3.6.5     2025-04-23 [2] CRAN (R 4.5.1)
#>  cluster                2.1.8.1   2025-03-12 [3] CRAN (R 4.5.1)
#>  codetools              0.2-20    2024-03-31 [3] CRAN (R 4.5.1)
#>  colorspace             2.1-1     2024-07-26 [2] CRAN (R 4.5.1)
#>  crayon                 1.5.3     2024-06-20 [2] CRAN (R 4.5.1)
#>  curl                   6.4.0     2025-06-22 [2] CRAN (R 4.5.1)
#>  data.table             1.17.8    2025-07-10 [2] CRAN (R 4.5.1)
#>  DBI                    1.2.3     2024-06-02 [2] CRAN (R 4.5.1)
#>  dbplyr               * 2.5.0     2024-03-19 [2] CRAN (R 4.5.1)
#>  DelayedArray           0.35.2    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  derfinder            * 1.43.1    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  derfinderHelper        1.43.0    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  derfinderPlot        * 1.43.1    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  dichromat              2.0-0.1   2022-05-02 [2] CRAN (R 4.5.1)
#>  digest                 0.6.37    2024-08-19 [2] CRAN (R 4.5.1)
#>  doRNG                  1.8.6.2   2025-04-02 [2] CRAN (R 4.5.1)
#>  dplyr                  1.1.4     2023-11-17 [2] CRAN (R 4.5.1)
#>  ensembldb              2.33.1    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  evaluate               1.0.4     2025-06-18 [2] CRAN (R 4.5.1)
#>  farver                 2.1.2     2024-05-13 [2] CRAN (R 4.5.1)
#>  fastmap                1.2.0     2024-05-15 [2] CRAN (R 4.5.1)
#>  filelock               1.0.3     2023-12-11 [2] CRAN (R 4.5.1)
#>  foreach              * 1.5.2     2022-02-02 [2] CRAN (R 4.5.1)
#>  foreign                0.8-90    2025-03-31 [3] CRAN (R 4.5.1)
#>  Formula                1.2-5     2023-02-24 [2] CRAN (R 4.5.1)
#>  generics             * 0.1.4     2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomeInfoDb           1.45.9    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicAlignments      1.45.2    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicFeatures      * 1.61.6    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicFiles           1.45.2    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicRanges        * 1.61.1    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicState         * 0.99.17   2025-07-30 [1] Bioconductor 3.22 (R 4.5.1)
#>  GGally                 2.3.0     2025-07-18 [2] CRAN (R 4.5.1)
#>  ggbio                  1.57.1    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  ggplot2                3.5.2     2025-04-09 [2] CRAN (R 4.5.1)
#>  ggstats                0.10.0    2025-07-02 [2] CRAN (R 4.5.1)
#>  glue                   1.8.0     2024-09-30 [2] CRAN (R 4.5.1)
#>  graph                  1.87.0    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  gridExtra              2.3       2017-09-09 [2] CRAN (R 4.5.1)
#>  gtable                 0.3.6     2024-10-25 [2] CRAN (R 4.5.1)
#>  Hmisc                  5.2-3     2025-03-16 [2] CRAN (R 4.5.1)
#>  hms                    1.1.3     2023-03-21 [2] CRAN (R 4.5.1)
#>  htmlTable              2.4.3     2024-07-21 [2] CRAN (R 4.5.1)
#>  htmltools              0.5.8.1   2024-04-04 [2] CRAN (R 4.5.1)
#>  htmlwidgets            1.6.4     2023-12-06 [2] CRAN (R 4.5.1)
#>  httr                   1.4.7     2023-08-15 [2] CRAN (R 4.5.1)
#>  httr2                  1.2.1     2025-07-22 [2] CRAN (R 4.5.1)
#>  IRanges              * 2.43.0    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  iterators            * 1.0.14    2022-02-05 [2] CRAN (R 4.5.1)
#>  jquerylib              0.1.4     2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite               2.0.0     2025-03-27 [2] CRAN (R 4.5.1)
#>  KEGGREST               1.49.1    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  knitr                  1.50      2025-03-16 [2] CRAN (R 4.5.1)
#>  lattice                0.22-7    2025-04-02 [3] CRAN (R 4.5.1)
#>  lazyeval               0.2.2     2019-03-15 [2] CRAN (R 4.5.1)
#>  lifecycle              1.0.4     2023-11-07 [2] CRAN (R 4.5.1)
#>  limma                  3.65.2    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  locfit               * 1.5-9.12  2025-03-05 [2] CRAN (R 4.5.1)
#>  lubridate              1.9.4     2024-12-08 [2] CRAN (R 4.5.1)
#>  magick                 2.8.7     2025-06-06 [2] CRAN (R 4.5.1)
#>  magrittr               2.0.3     2022-03-30 [2] CRAN (R 4.5.1)
#>  Matrix                 1.7-3     2025-03-11 [3] CRAN (R 4.5.1)
#>  MatrixGenerics         1.21.0    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  matrixStats            1.5.0     2025-01-07 [2] CRAN (R 4.5.1)
#>  memoise                2.0.1     2021-11-26 [2] CRAN (R 4.5.1)
#>  nnet                   7.3-20    2025-01-01 [3] CRAN (R 4.5.1)
#>  org.Hs.eg.db         * 3.21.0    2025-06-19 [2] Bioconductor
#>  OrganismDbi            1.51.4    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  pillar                 1.11.0    2025-07-04 [2] CRAN (R 4.5.1)
#>  pkgconfig              2.0.3     2019-09-22 [2] CRAN (R 4.5.1)
#>  plyr                   1.8.9     2023-10-02 [2] CRAN (R 4.5.1)
#>  png                    0.1-8     2022-11-29 [2] CRAN (R 4.5.1)
#>  prettyunits            1.2.0     2023-09-24 [2] CRAN (R 4.5.1)
#>  progress               1.2.3     2023-12-06 [2] CRAN (R 4.5.1)
#>  ProtGenerics           1.41.0    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  purrr                  1.1.0     2025-07-10 [2] CRAN (R 4.5.1)
#>  qvalue                 2.41.0    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  R6                     2.6.1     2025-02-15 [2] CRAN (R 4.5.1)
#>  rappdirs               0.3.3     2021-01-31 [2] CRAN (R 4.5.1)
#>  RBGL                   1.85.0    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  RColorBrewer           1.1-3     2022-04-03 [2] CRAN (R 4.5.1)
#>  Rcpp                   1.1.0     2025-07-02 [2] CRAN (R 4.5.1)
#>  RCurl                  1.98-1.17 2025-03-22 [2] CRAN (R 4.5.1)
#>  RefManageR           * 1.4.0     2022-09-30 [2] CRAN (R 4.5.1)
#>  reshape2               1.4.4     2020-04-09 [2] CRAN (R 4.5.1)
#>  restfulr               0.0.16    2025-06-27 [2] CRAN (R 4.5.1)
#>  rjson                  0.2.23    2024-09-16 [2] CRAN (R 4.5.1)
#>  rlang                  1.1.6     2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown              2.29      2024-11-04 [2] CRAN (R 4.5.1)
#>  rngtools               1.5.2     2021-09-20 [2] CRAN (R 4.5.1)
#>  rpart                  4.1.24    2025-01-07 [3] CRAN (R 4.5.1)
#>  Rsamtools              2.25.2    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  RSQLite                2.4.2     2025-07-18 [2] CRAN (R 4.5.1)
#>  rstudioapi             0.17.1    2024-10-22 [2] CRAN (R 4.5.1)
#>  rtracklayer            1.69.1    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Arrays               1.9.1     2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S4Vectors            * 0.47.0    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  S7                     0.2.0     2024-11-07 [2] CRAN (R 4.5.1)
#>  sass                   0.4.10    2025-04-11 [2] CRAN (R 4.5.1)
#>  scales                 1.4.0     2025-04-24 [2] CRAN (R 4.5.1)
#>  Seqinfo              * 0.99.2    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo          * 1.2.3     2025-02-05 [2] CRAN (R 4.5.1)
#>  SparseArray            1.9.1     2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  statmod                1.5.0     2023-01-06 [2] CRAN (R 4.5.1)
#>  stringi                1.8.7     2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr                1.5.1     2023-11-14 [2] CRAN (R 4.5.1)
#>  SummarizedExperiment   1.39.1    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  tibble                 3.3.0     2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyr                  1.3.1     2024-01-24 [2] CRAN (R 4.5.1)
#>  tidyselect             1.2.1     2024-03-11 [2] CRAN (R 4.5.1)
#>  timechange             0.3.0     2024-01-18 [2] CRAN (R 4.5.1)
#>  tinytex                0.57      2025-04-15 [2] CRAN (R 4.5.1)
#>  txdbmaker              1.5.6     2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  UCSC.utils             1.5.0     2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  VariantAnnotation      1.55.1    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  vctrs                  0.6.5     2023-12-01 [2] CRAN (R 4.5.1)
#>  withr                  3.0.2     2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun                   0.52      2025-04-02 [2] CRAN (R 4.5.1)
#>  XML                    3.99-0.18 2025-01-01 [2] CRAN (R 4.5.1)
#>  xml2                   1.3.8     2025-03-14 [2] CRAN (R 4.5.1)
#>  XVector                0.49.0    2025-07-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  yaml                   2.3.10    2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpN308tx/Rinst1601f660b6c6f3
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 8 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025), *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2014) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2024) running behind the scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2024rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.29.
2024.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-2025annotationhubdata)
Bioconductor Package Maintainer.
*AnnotationHubData: Transform public data resources into Bioconductor Data Structures*.
R package version 1.39.2.
2025.
DOI: [10.18129/B9.bioc.AnnotationHubData](https://doi.org/10.18129/B9.bioc.AnnotationHubData).
URL: <https://bioconductor.org/packages/AnnotationHubData>.

[[3]](#cite-carlson2025genome)
M. Carlson.
*org.Hs.eg.db: Genome wide annotation for Human*.
R package version 3.21.0.
2025.

[[4]](#cite-colladotorres2025build)
L. Collado-Torres.
*Build and access GenomicState objects for use with derfinder tools from sources like Gencode*.
<https://github.com/LieberInstitute/GenomicState> - R package version 0.99.17.
2025.
DOI: [10.18129/B9.bioc.GenomicState](https://doi.org/10.18129/B9.bioc.GenomicState).
URL: <http://www.bioconductor.org/packages/GenomicState>.

[[5]](#cite-colladotorres2017flexible)
L. Collado-Torres, A. Nellore, A. C. Frazee, et al.
“Flexible expressed region analysis for RNA-seq with derfinder”.
In: *Nucl. Acids Res.* (2017).
DOI: [10.1093/nar/gkw852](https://doi.org/10.1093/nar/gkw852).
URL: <http://nar.oxfordjournals.org/content/early/2016/09/29/nar.gkw852>.

[[6]](#cite-hester2024glue)
J. Hester and J. Bryan.
*glue: Interpreted String Literals*.
R package version 1.8.0.
2024.
DOI: [10.32614/CRAN.package.glue](https://doi.org/10.32614/CRAN.package.glue).
URL: [https://CRAN.R-project.org/package=glue](https://CRAN.R-project.org/package%3Dglue).

[[7]](#cite-bumphunter)
A. E. Jaffe, P. Murakami, H. Lee, et al.
“Bump hunting to identify differentially methylated regions in epigenetic epidemiology studies”.
In: *International journal of epidemiology* 41.1 (2012), pp. 200–209.
DOI: [10.1093/ije/dyr238](https://doi.org/10.1093/ije/dyr238).

[[8]](#cite-lawrence2009rtracklayer)
M. Lawrence, R. Gentleman, and V. Carey.
“rtracklayer: an R package for interfacing with
genome browsers”.
In: *Bioinformatics* 25 (2009), pp. 1841-1842.
DOI: [10.1093/bioinformatics/btp328](https://doi.org/10.1093/bioinformatics/btp328).
URL: <http://bioinformatics.oxfordjournals.org/content/25/14/1841.abstract>.

[[9]](#cite-lawrence2013software)
M. Lawrence, W. Huber, H. Pagès, et al.
“Software for Computing and Annotating Genomic Ranges”.
In: *PLoS Computational Biology* 9 (8 2013).
DOI: [10.1371/journal.pcbi.1003118](https://doi.org/10.1371/journal.pcbi.1003118).
URL: [[http://www.ploscompbiol.org/article/info%3Adoi%2F10.1371%2Fjournal.pcbi.1003118](http://www.ploscompbiol.org/article/info%3Adoi/10.1371/journal.pcbi.1003118)}.](http://www.ploscompbiol.org/article/info%3Adoi/10.1371/journal.pcbi.1003118%7D.)

[[10]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[11]](#cite-morgan2025annotationhub)
M. Morgan and L. Shepherd.
*AnnotationHub: Client to access AnnotationHub resources*.
R package version 3.99.6.
2025.
DOI: [10.18129/B9.bioc.AnnotationHub](https://doi.org/10.18129/B9.bioc.AnnotationHub).
URL: <https://bioconductor.org/packages/AnnotationHub>.

[[12]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.37.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[13]](#cite-pags2025seqinfo)
H. Pagès.
*Seqinfo: A simple S4 class for storing basic information about a collection of genomic sequences*.
R package version 0.99.2.
2025.
DOI: [10.18129/B9.bioc.Seqinfo](https://doi.org/10.18129/B9.bioc.Seqinfo).
URL: <https://bioconductor.org/packages/Seqinfo>.

[[14]](#cite-pags2025txdbmaker)
H. Pagès, M. Carlson, P. Aboyoun, et al.
*txdbmaker: Tools for making TxDb objects from genomic annotations*.
R package version 1.5.6.
2025.
DOI: [10.18129/B9.bioc.txdbmaker](https://doi.org/10.18129/B9.bioc.txdbmaker).
URL: <https://bioconductor.org/packages/txdbmaker>.

[[15]](#cite-pags2025annotationdbi)
H. Pagès, M. Carlson, S. Falcon, et al.
*AnnotationDbi: Manipulation of SQLite-based annotations in Bioconductor*.
R package version 1.71.1.
2025.
DOI: [10.18129/B9.bioc.AnnotationDbi](https://doi.org/10.18129/B9.bioc.AnnotationDbi).
URL: <https://bioconductor.org/packages/AnnotationDbi>.

[[16]](#cite-2025language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2025.
URL: <https://www.R-project.org/>.

[[17]](#cite-wickham2011testthat)
H. Wickham.
“testthat: Get Started with Testing”.
In: *The R Journal* 3 (2011), pp. 5–10.
URL: <https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

[[18]](#cite-wickham2025sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.3.
2025.
DOI: [10.32614/CRAN.package.sessioninfo](https://doi.org/10.32614/CRAN.package.sessioninfo).
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[19]](#cite-xie2014knitr)
Y. Xie.
“knitr: A Comprehensive Tool for Reproducible Research in R”.
In:
*Implementing Reproducible Computational Research*.
Ed. by V. Stodden, F. Leisch and R. D. Peng.
ISBN 978-1466561595.
Chapman and Hall/CRC, 2014.