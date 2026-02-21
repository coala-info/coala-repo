# Building an annotation database for metaseqR2

Panagiotis Moulos

#### 30 October 2025

# 1 Simple, flexible and reusable annotation for metaseqR2 pipeline

When using the first version of metaseqR, one had to either embed the annotation
to the gene/exon/3’ UTR counts, or to download and construct on-the-fly the
required annotation when starting from BAM files. Although the counting and gene
model construction results could (anf still can) be saved and re-used with other
analysis parameters changed (e.g. statistical algorithms), one could not easily
add for example new data to an existing dataset without re-running the whole
pipeline and re-downloading annotation. On top of that, many times, the main
Ensembl servers (when using Ensembl annotations) do not respond well to biomaRt
calls, so the whole pipeline may stall until the servers are back.

Another main issue with the annotation used by metaseqR was that there was no
straightforward way, provided by metaseqR, to archive and version the annotation
used by a specific analysis and was up to the user to take care of
reproducibility at this level. Furthermore, there was no straightforward way for
a user to plugin own annotation elements (e.g. in the form of a GTF file) and
use it in the same manner as standard annotations supported by metaseqR, e.g.
when analyzing data from not-so-often studied organisms such as insects.
Plugging-in own annotation was possible but usually a painful procedure, which
has become now very easy.

The annotation database builder for metaseqR2 remedies the above situations. The
`buildAnnotationDatabase` function should be run once with the organisms one
requires to have locally to work with and then that’s it! Of course you can
manage your database by adding and removing specific annotations (and you even
can play with an SQLite browser, although not advised, as the database structure
is rather simple). Furthermore, you can use the metaseqR2 annotation database
and management mechanism for any other type of analysis where you require to
have a simple tab-delimited annotation file, acquired with very little effort.

# 2 Supported organisms

The following organisms (essentially genome versions) are supported for
automatic database builds:

* Human (*Homo sapiens*) genome version **hg38**
* Human (*Homo sapiens*) genome version **hg19**
* Human (*Homo sapiens*) genome version **hg18**
* Mouse (*Mus musculus*) genome version **mm10**
* Mouse (*Mus musculus*) genome version **mm9**
* Rat (*Rattus norvegicus*) genome version **rn6**
* Rat (*Rattus norvegicus*) genome version **rn5**
* Fruitfly (*Drosophila melanogaster*) genome version **dm6**
* Fruitfly (*Drosophila melanogaster*) genome version **dm3**
* Zebrafish (*Danio rerio*) genome version **danRer7**
* Zebrafish (*Danio rerio*) genome version **danRer10**
* Zebrafish (*Danio rerio*) genome version **danRer11**
* Chimpanzee (*Pan troglodytes*) genome version **panTro4**
* Chimpanzee (*Pan troglodytes*) genome version **panTro5**
* Pig (*Sus scrofa*) genome version **susScr3**
* Pig (*Sus scrofa*) genome version **susScr11**
* Horse (*Equus cabalus*) genome version **equCab2**
* Arabidopsis (*Arabidobsis thaliana*) genome version **TAIR10**

# 3 Using the local database

## 3.1 Installation of metaseqR2

To install the metaseqR2 package, start R and enter:

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("metaseqR2")
```

## 3.2 Setup the database

By default, the database file will be written in the
`system.file(package="metaseqR2")` directory. You can specify another prefered
destination for it using the `db` argument in the function call, but if you do
that, you will have to supply the `localDb` argument pointing to the SQLite
database file you created to every metaseqr2 call you perform, otherwise, the
pipeline will download and use annotations on-the-fly.

In this vignette, we will build a minimal database comprising only the mouse
*mm10* genome version from Ensembl. The database will be build in a temporary
directory inside session `tempdir()`.

**Important note**: As the annotation build function makes use of
[Kent](http://hgdownload.soe.ucsc.edu/admin/exe/) utilities for creating 3’UTR
annotations from RefSeq and UCSC, the latter cannot be built in Windows.
Therefore it is advised to either build the annotation database in a Linux
system or use our pre-built databases.

```
library(metaseqR2)

buildDir <- file.path(tempdir(),"test_anndb")
dir.create(buildDir)

# The location of the custom database
myDb <- file.path(buildDir,"testann.sqlite")

# Since we are using Ensembl, we can also ask for a version
organisms <- list(mm10=100)
sources <- ifelse(.Platform$OS.type=="unix",c("ensembl","refseq"),"ensembl")

# If the example is not running in a multicore system, rc is ignored
buildAnnotationDatabase(organisms,sources,forceDownload=FALSE,db=myDb,rc=0.5)
```

```
## Opening metaseqR2 SQLite database /tmp/RtmpiHhLZD/test_anndb/testann.sqlite
```

```
## Retrieving genome information for mm10 from ensembl
```

```
## Retrieving gene annotation for mm10 from ensembl version 100
```

```
## Using Ensembl host https://apr2020.archive.ensembl.org
```

```
## Retrieving transcript annotation for mm10 from ensembl version 100
```

```
## Using Ensembl host https://apr2020.archive.ensembl.org
```

```
## Merging transcripts for mm10 from ensembl version 100
```

```
## Retrieving 3' UTR annotation for mm10 from ensembl version 100
```

```
## Using Ensembl host https://apr2020.archive.ensembl.org
```

```
## Merging gene 3' UTRs for mm10 from ensembl version 100
```

```
## Merging transcript 3' UTRs for mm10 from ensembl version 100
```

```
## Retrieving exon annotation for mm10 from ensembl version 100
```

```
## Using Ensembl host https://apr2020.archive.ensembl.org
```

```
## Retrieving extended exon annotation for mm10 from ensembl version 100
```

```
## Using Ensembl host https://apr2020.archive.ensembl.org
```

```
## Merging exons for mm10 from ensembl version 100
## Merging exons for mm10 from ensembl version 100
```

## 3.3 Use the database

Now, that a small database is in place, let’s retrieve some data. Remember that
since the built database is not in the default location, we need to pass the
database file in each data retrieval function. The annotation is retrieved as
a `GRanges` object by default.

```
# Load standard annotation based on gene body coordinates
genes <- loadAnnotation(genome="mm10",refdb="ensembl",level="gene",type="gene",
    db=myDb)
genes

# Load standard annotation based on 3' UTR coordinates
utrs <- loadAnnotation(genome="mm10",refdb="ensembl",level="gene",type="utr",
    db=myDb)
utrs

# Load summarized exon annotation based used with RNA-Seq analysis
sumEx <- loadAnnotation(genome="mm10",refdb="ensembl",level="gene",type="exon",
    summarized=TRUE,db=myDb)
sumEx

# Load standard annotation based on gene body coordinates from RefSeq
if (.Platform$OS.type=="unix") {
    refGenes <- loadAnnotation(genome="mm10",refdb="refseq",level="gene",
        type="gene",db=myDb)
    refGenes
}
```

Or as a data frame if you prefer using `asdf=TRUE`. The data frame however does
not contain metadata like `Seqinfo` to be used for any susequent validations:

```
# Load standard annotation based on gene body coordinates
genes <- loadAnnotation(genome="mm10",refdb="ensembl",level="gene",type="gene",
    db=myDb,asdf=TRUE)
head(genes)
```

```
##   chromosome   start     end            gene_id gc_content strand     gene_name
## 1       chr1 3073253 3074322 ENSMUSG00000102693      34.21      + 4933401J01Rik
## 2       chr1 3102016 3102125 ENSMUSG00000064842      36.36      +       Gm26206
## 3       chr1 3205901 3671498 ENSMUSG00000051951      38.51      -          Xkr4
## 4       chr1 3252757 3253236 ENSMUSG00000102851      39.79      +       Gm18956
## 5       chr1 3365731 3368549 ENSMUSG00000103377      40.79      -       Gm37180
## 6       chr1 3375556 3377788 ENSMUSG00000104017      36.99      -       Gm37363
##                biotype
## 1                  TEC
## 2                snRNA
## 3       protein_coding
## 4 processed_pseudogene
## 5                  TEC
## 6                  TEC
```

## 3.4 Add a custom annotation

Apart from the supported organisms and databases, you can add a custom
annotation. Such an annotation can be:

* A non-supported organism (e.g. an insect or another mammal e.g. dog)
* A modification or further curation you have done to existing/supported
  annotations
* A supported organism but from a different source
* Any other case where the provided annotations are not adequate

This can be achieved through the usage of
[GTF](https://www.ensembl.org/info/website/upload/gff.html) files, along with
some simple metadata that you have to provide for proper import to the
annotation database. This can be achieved through the usage of the
`buildCustomAnnotation` function. Details on required metadata can be found
in the function’s help page.

**Important note:** Please note that importing a custom genome annotation
directly from UCSC (UCSC SQL database dumps) is not supported in Windows as the
process involves using the `genePredToGtf` which is not available for Windows.

Let’s try a couple of exammples. The first one is a custom annotation for the
Ebola virus from UCSC:

```
# Setup a temporary directory to download files etc.
customDir <- file.path(tempdir(),"test_custom")
dir.create(customDir)

# Convert from GenePred to GTF - Unix/Linux only!
if (.Platform$OS.type == "unix" && !grepl("^darwin",R.version$os)) {
    # Download data from UCSC
    goldenPath="http://hgdownload.cse.ucsc.edu/goldenPath/"
    # Gene annotation dump
    download.file(paste0(goldenPath,"eboVir3/database/ncbiGene.txt.gz"),
        file.path(customDir,"eboVir3_ncbiGene.txt.gz"))
    # Chromosome information
    download.file(paste0(goldenPath,"eboVir3/database/chromInfo.txt.gz"),
        file.path(customDir,"eboVir3_chromInfo.txt.gz"))

    # Prepare the build
    chromInfo <- read.delim(file.path(customDir,"eboVir3_chromInfo.txt.gz"),
        header=FALSE)
    chromInfo <- chromInfo[,1:2]
    rownames(chromInfo) <- as.character(chromInfo[,1])
    chromInfo <- chromInfo[,2,drop=FALSE]

    # Coversion from genePred to GTF
    genePredToGtfEnv <- Sys.getenv("GENEPREDTOGTF_BINARY")
    if (genePredToGtfEnv == "") {
        genePredToGtf <- file.path(customDir,"genePredToGtf")
    } else {
        genePredToGtf <- file.path(genePredToGtfEnv)
    }
    if (!file.exists(genePredToGtf)) {
        download.file(
        "http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/genePredToGtf",
            genePredToGtf
        )
        system(paste("chmod 775",genePredToGtf))
    }
    gtfFile <- file.path(customDir,"eboVir3.gtf")
    tmpName <- file.path(customDir,paste(format(Sys.time(),"%Y%m%d%H%M%S"),
        "tgtf",sep="."))
    command <- paste0(
        "zcat ",file.path(customDir,"eboVir3_ncbiGene.txt.gz"),
        " | ","cut -f2- | ",genePredToGtf," file stdin ",tmpName,
        " -source=eboVir3"," -utr && grep -vP '\t\\.\t\\.\t' ",tmpName," > ",
        gtfFile
    )
    system(command)

    # Build with the metadata list filled (you can also provide a version)
    buildCustomAnnotation(
        gtfFile=gtfFile,
        metadata=list(
            organism="eboVir3_test",
            source="ucsc_test",
            chromInfo=chromInfo
        ),
        db=myDb
    )

    # Try to retrieve some data
    eboGenes <- loadAnnotation(genome="eboVir3_test",refdb="ucsc_test",
        level="gene",type="gene",db=myDb)
    eboGenes
}
```

Another example, the Atlantic cod from UCSC. The same things apply for the
operating system.

```
if (.Platform$OS.type == "unix") {
    # Gene annotation dump
    download.file(paste0(goldenPath,"gadMor1/database/augustusGene.txt.gz"),
        file.path(customDir,"gadMori1_augustusGene.txt.gz"))
    # Chromosome information
    download.file(paste(goldenPath,"gadMor1/database/chromInfo.txt.gz",sep=""),
        file.path(customDir,"gadMori1_chromInfo.txt.gz"))

    # Prepare the build
    chromInfo <- read.delim(file.path(customDir,"gadMori1_chromInfo.txt.gz"),
        header=FALSE)
    chromInfo <- chromInfo[,1:2]
    rownames(chromInfo) <- as.character(chromInfo[,1])
    chromInfo <- chromInfo[,2,drop=FALSE]

    # Coversion from genePred to GTF
    genePredToGtf <- file.path(customDir,"genePredToGtf")
    if (!file.exists(genePredToGtf)) {
        download.file(
        "http://hgdownload.soe.ucsc.edu/admin/exe/linux.x86_64/genePredToGtf",
            genePredToGtf
        )
        system(paste("chmod 775",genePredToGtf))
    }
    gtfFile <- file.path(customDir,"gadMori1.gtf")
    tmpName <- file.path(customDir,paste(format(Sys.time(),"%Y%m%d%H%M%S"),
        "tgtf",sep="."))
    command <- paste0(
        "zcat ",file.path(customDir,"gadMori1_augustusGene.txt.gz"),
        " | ","cut -f2- | ",genePredToGtf," file stdin ",tmpName,
        " -source=gadMori1"," -utr && grep -vP '\t\\.\t\\.\t' ",tmpName," > ",
        gtfFile
    )
    system(command)

    # Build with the metadata list filled (you can also provide a version)
    buildCustomAnnotation(
        gtfFile=gtfFile,
        metadata=list(
            organism="gadMor1_test",
            source="ucsc_test",
            chromInfo=chromInfo
        ),
        db=myDb
    )

    # Try to retrieve some data
    gadGenes <- loadAnnotation(genome="gadMor1_test",refdb="ucsc_test",
        level="gene",type="gene",db=myDb)
    gadGenes
}
```

Another example, Armadillo from Ensembl. This should work irrespectively of
operating system. We are downloading chromosomal information from UCSC.

```
# Gene annotation dump from Ensembl
download.file(paste0("ftp://ftp.ensembl.org/pub/release-98/gtf/",
    "dasypus_novemcinctus/Dasypus_novemcinctus.Dasnov3.0.98.gtf.gz"),
    file.path(customDir,"Dasypus_novemcinctus.Dasnov3.0.98.gtf.gz"))

# Chromosome information will be provided from the following BAM file
# available from Ensembl. We have noticed that when using Windows as the OS,
# a remote BAM files cannot be opened by scanBamParam, so for this example,
# chromosome length information will not be available when running in Windows.
bamForInfo <- NULL
if (.Platform$OS.type == "unix")
    bamForInfo <- paste0("ftp://ftp.ensembl.org/pub/release-98/bamcov/",
        "dasypus_novemcinctus/genebuild/Dasnov3.broad.Ascending_Colon_5.1.bam")

# Build with the metadata list filled (you can also provide a version)
buildCustomAnnotation(
    gtfFile=file.path(customDir,"Dasypus_novemcinctus.Dasnov3.0.98.gtf.gz"),
    metadata=list(
        organism="dasNov3_test",
        source="ensembl_test",
        chromInfo=bamForInfo
    ),
    db=myDb
)

# Try to retrieve some data
dasGenes <- loadAnnotation(genome="dasNov3_test",refdb="ensembl_test",
    level="gene",type="gene",db=myDb)
dasGenes
```

## 3.5 A complete build

A quite complete build (with latest versions of Ensembl annotations) would look
like (supposing the default annotation database location):

```
organisms <- list(
    hg18=54,
    hg19=75,
    hg38=110:111,
    mm9=54,
    mm10=110:111,
    rn5=77,
    rn6=110:111,
    dm3=77,
    dm6=110:111,
    danrer7=77,
    danrer10=80,
    danrer11=110:111,
    pantro4=80,
    pantro5=110:111,
    susscr3=80,
    susscr11=110:111,
    equcab2=110:111
)

sources <- c("ensembl","ucsc","refseq")

buildAnnotationDatabase(organisms,sources,forceDownload=FALSE,rc=0.5)
```

The aforementioned complete built can be found
[here](https://tinyurl.com/ybycpr6b)
Complete builts will become available from time to time (e.g. with every new
Ensembl relrase) for users who do not wish to create annotation databases on
their own. Root access may be required (depending on the metaseqR2 library
location) to place it in the default location where it can be found
automatically.

# 4 Annotations on-the-fly

If for some reason you do not want to build and use an annotation database for
metaseqR2 analyses (not recommended) or you wish to perform an analysis with an
organism that does not yet exist in the database, the `loadAnnotation` function
will perform all required actions (download and create a `GRanges` object)
on-the-fly as long as there is an internet connection.

However, the above function does not handle custom annotations in GTF files.
In a scenario where you want to use a custom annotation only once, you should
supply the `annotation` argument to the `metaseqr2` function, which is almost
the same as the `metadata` argument used in `buildCustomAnnotation`, actually
augmented by a list member for the GTF
file, that is:

```
annotation <- list(
    gtf="PATH_TO_GTF",
    organism="ORGANISM_NAME",
    source="SOURCE_NAME",
    chromInfo="CHROM_INFO"
)
```

The above argument can be passed to the metaseqr2 call in the respective
position.

For further details about custom annotations on the fly, please check
`buildCustomAnnotation` and `importCustomAnnotation` functions.

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
## [1] splines   stats4    stats     graphics  grDevices utils     datasets
## [8] methods   base
##
## other attached packages:
##  [1] metaseqR2_1.22.0            locfit_1.5-9.12
##  [3] limma_3.66.0                DESeq2_1.50.0
##  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [7] MatrixGenerics_1.22.0       matrixStats_1.5.0
##  [9] GenomicRanges_1.62.0        Seqinfo_1.0.0
## [11] IRanges_2.44.0              S4Vectors_0.48.0
## [13] BiocGenerics_0.56.0         generics_0.1.4
## [15] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] BiocIO_1.20.0             survcomp_1.60.0
##   [3] bitops_1.0-9              filelock_1.0.3
##   [5] tibble_3.3.0              R.oo_1.27.1
##   [7] preprocessCore_1.72.0     XML_3.99-0.19
##   [9] lifecycle_1.0.4           httr2_1.2.1
##  [11] pwalign_1.6.0             edgeR_4.8.0
##  [13] globals_0.18.0            MASS_7.3-65
##  [15] lattice_0.22-7            dendextend_1.19.1
##  [17] magrittr_2.0.4            plotly_4.11.0
##  [19] sass_0.4.10               rmarkdown_2.30
##  [21] jquerylib_0.1.4           yaml_2.3.10
##  [23] DBI_1.2.3                 RColorBrewer_1.1-3
##  [25] ABSSeq_1.64.0             harmonicmeanp_3.0.1
##  [27] abind_1.4-8               ShortRead_1.68.0
##  [29] purrr_1.1.0               R.utils_2.13.0
##  [31] rmeta_3.0                 RCurl_1.98-1.17
##  [33] rappdirs_0.3.3            lava_1.8.1
##  [35] seriation_1.5.8           survivalROC_1.0.3.1
##  [37] listenv_0.9.1             genefilter_1.92.0
##  [39] parallelly_1.45.1         annotate_1.88.0
##  [41] permute_0.9-8             DelayedMatrixStats_1.32.0
##  [43] codetools_0.2-20          DelayedArray_0.36.0
##  [45] xml2_1.4.1                DT_0.34.0
##  [47] SuppDists_1.1-9.9         tidyselect_1.2.1
##  [49] futile.logger_1.4.3       UCSC.utils_1.6.0
##  [51] farver_2.1.2              viridis_0.6.5
##  [53] TSP_1.2-5                 rmdformats_1.0.4
##  [55] BiocFileCache_3.0.0       webshot_0.5.5
##  [57] GenomicAlignments_1.46.0  jsonlite_2.0.0
##  [59] iterators_1.0.14          survival_3.8-3
##  [61] foreach_1.5.2             tools_4.5.1
##  [63] progress_1.2.3            Rcpp_1.1.0
##  [65] glue_1.8.0                prodlim_2025.04.28
##  [67] gridExtra_2.3             SparseArray_1.10.0
##  [69] xfun_0.53                 qvalue_2.42.0
##  [71] GenomeInfoDb_1.46.0       ca_0.71.1
##  [73] dplyr_1.1.4               HDF5Array_1.38.0
##  [75] withr_3.0.2               NBPSeq_0.3.1
##  [77] formatR_1.14              BiocManager_1.30.26
##  [79] fastmap_1.2.0             latticeExtra_0.6-31
##  [81] rhdf5filters_1.22.0       caTools_1.18.3
##  [83] digest_0.6.37             R6_2.6.1
##  [85] gtools_3.9.5              jpeg_0.1-11
##  [87] dichromat_2.0-0.1         biomaRt_2.66.0
##  [89] RSQLite_2.4.3             cigarillo_1.0.0
##  [91] R.methodsS3_1.8.2         h5mread_1.2.0
##  [93] tidyr_1.3.1               data.table_1.17.8
##  [95] rtracklayer_1.70.0        prettyunits_1.2.0
##  [97] httr_1.4.7                htmlwidgets_1.6.4
##  [99] S4Arrays_1.10.0           pkgconfig_2.0.3
## [101] gtable_0.3.6              registry_0.5-1
## [103] blob_1.2.4                S7_0.2.0
## [105] hwriter_1.3.2.1           XVector_0.50.0
## [107] htmltools_0.5.8.1         bookdown_0.45
## [109] log4r_0.4.4               scales_1.4.0
## [111] png_0.1-8                 corrplot_0.95
## [113] knitr_1.50                lambda.r_1.2.4
## [115] reshape2_1.4.4            rjson_0.2.23
## [117] curl_7.0.0                zoo_1.8-14
## [119] cachem_1.1.0              rhdf5_2.54.0
## [121] stringr_1.5.2             KernSmooth_2.23-26
## [123] parallel_4.5.1            AnnotationDbi_1.72.0
## [125] vsn_3.78.0                restfulr_0.0.16
## [127] pillar_1.11.1             grid_4.5.1
## [129] vctrs_0.6.5               gplots_3.2.0
## [131] dbplyr_2.5.1              beachmat_2.26.0
## [133] xtable_1.8-4              evaluate_1.0.5
## [135] bsseq_1.46.0              VennDiagram_1.7.3
## [137] GenomicFeatures_1.62.0    cli_3.6.5
## [139] compiler_4.5.1            futile.options_1.0.1
## [141] Rsamtools_2.26.0          rlang_1.1.6
## [143] crayon_1.5.3              FMStable_0.1-4
## [145] future.apply_1.20.0       heatmaply_1.6.0
## [147] interp_1.1-6              aroma.light_3.40.0
## [149] affy_1.88.0               plyr_1.8.9
## [151] pander_0.6.6              stringi_1.8.7
## [153] viridisLite_0.4.2         deldir_2.0-4
## [155] BiocParallel_1.44.0       assertthat_0.2.1
## [157] txdbmaker_1.6.0           Biostrings_2.78.0
## [159] lazyeval_0.2.2            DSS_2.58.0
## [161] EDASeq_2.44.0             Matrix_1.7-4
## [163] BSgenome_1.78.0           hms_1.1.4
## [165] future_1.67.0             sparseMatrixStats_1.22.0
## [167] bit64_4.6.0-1             ggplot2_4.0.0
## [169] Rhdf5lib_1.32.0           KEGGREST_1.50.0
## [171] statmod_1.5.1             memoise_2.0.1
## [173] affyio_1.80.0             bslib_0.9.0
## [175] bootstrap_2019.6          bit_4.6.0
```