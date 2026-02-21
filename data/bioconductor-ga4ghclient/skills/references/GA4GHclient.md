# GA4GHclient

Welliton Souza1

1University of Campinas, Campinas, Brazil

#### 30 October 2025

#### Package

GA4GHclient 1.34.0

# 1 Introduction

The [Global Alliance for Genomics and Health](http://genomicsandhealth.org/) (GA4GH) was formed to help accelerate the potential of genomic medicine to advance human health.
It brings together over 400 leading institutions working in healthcare, research, disease advocacy, life science, and information technology.
The [Data Working Group](http://ga4gh.org/#/) of the GA4GH developed [data model schemas](https://github.com/ga4gh/schemas) and application program interfaces (APIs) for genomic data.
These APIs are specifically designed to allow sharing of genomics data in a standardized manner and without having to exchange complete experiments.
They developed a [reference implementation for these APIs](https://github.com/ga4gh/server) providing a web server for hosting genomic data.

The [Bioconductor](http://bioconductor.org/) project provides tools for the analysis and comprehension of high-throughput genomic data.
It uses the [R statistical programming language](https://cran.r-project.org/), and is open source and open development.
The Bioconductor provides stable representations for genomics data such as [biological sequences](https://bioconductor.org/packages/Biostrings/) and [genomic variants](https://bioconductor.org/packages/VariantAnnotation/).

We developed GA4GHclient, a Bioconductor package that provides an easy way to access public data servers through GA4GH APIs.
The requested output data are converted into [tidy data](http://vita.had.co.nz/papers/tidy-data.pdf) and presented as data frames.
Our package provides methods for converting genomic variant data into VCF data allowing the creation of complex data analysis using public genomic data and well validated Bioconductor packages.
This package also provides an interactive web application for interacting with genomics data through GA4GH APIs.

Public data servers that use GA4GH Genomics API:

* [Hosting Thousand Genomes Project](http://1kgenomes.ga4gh.org/)
* [Ensembl REST API](https://rest.ensembl.org/)

# 2 Available request methods

The table below shows all available methods in **GA4GHclient** package.
These methods are based on the [official GA4GH schemas](https://ga4gh-schemas.readthedocs.io/en/latest/schemas/).
Let us know if some method is missing by opening an issue at <https://github.com/labbcb/GA4GHclient/issues>.

| Method | Description |
| --- | --- |
| searchDatasets | Search for datasets |
| searchReferenceSets | Search for reference sets (reference genomes) |
| searchReferences | Search for references (genome sequences, e.g. chromosomes) |
| listReferenceBases | Get the sequence bases of a reference genome by genomic range |
| searchVariantSets | Search for for variant sets (VCF files) |
| searchVariants | Search for variants by genomic ranges (lines of VCF files) |
| searchCallSets | Search for call sets (sample columns of VCF files) |
| searchVariantAnnotationSets | Search for variant annotation sets (annotated VCF files) |
| searchVariantAnnotations | Search for annotated variants by genomic range |
| searchFeatureSets | Search for feature sets (genomic features, e.g. GFF files) |
| searchFeatures | Search for features (lines of genomic feature files) |
| searchReadGroupSets | Search for read group sets (sequence alignement, e.g BAM files) |
| searchReads | Search for reads by genomic range (bases of aligned sequences) |
| searchBiosamples | Search for biosamples |
| searchIndividuals | Search for individuals |
| searchRnaQuantificationSets | Search for RNA quantification sets |
| searchRnaQuantifications | Search for RNA quantifications |
| searchExpressionLevels | Search for expression levels |
| searchPhenotypeAssociationSets | Search for phenotype association sets |
| searchPhenotypeAssociations | Search for phenotype associations |
| getDataset | Get a dataset by its ID |
| getReferenceSet | Get a reference set by its ID |
| getReference | Get a reference by its ID |
| getVariantSet | Get a variant set by its ID |
| getVariant | Get a variant by its ID with all call sets for this variant |
| getCallSet | Get a call set by its ID |
| getVariantAnnotationSet | Get a variant annotation set by its ID |
| getVariantAnnotation | Get an annotated variant by its ID |
| getFeatureSet | Get a feature set by its ID |
| getFeature | Get a feature by its ID |
| getReadGroupSet | Get a read group set by its ID |
| getBiosample | Get a biosample by its ID |
| getIndividual | Get an individual by its ID |
| getRnaQuantificationSet | Get an RNA quantification set by its ID |
| getRnaQuantification | Get an RNA quantification by its ID |
| getExpressionLevel | Get an expression level by its ID |

# 3 Retrieving Thousand Genomes Project data through GA4GHclient package

First, load required packages for this vignette.

```
library(GA4GHclient)
library(org.Hs.eg.db)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
library(VariantAnnotation)
library(GenomeInfoDb)  # for seqlevelsStyle()
```

For this example we will use [Hosting Thousand Genomes Project](http://1kgenomes.ga4gh.org/) server.
It contains data from the [1000 Genomes project](http://www.internationalgenome.org/).
Set the URL of GA4GH API data server. This variable will be used by all request functions.

```
host <- "http://1kgenomes.ga4gh.org/"
```

Get basic information about data server.
The dataset may contain many variant sets.
A variant set represents the header of an VCF file.
A collection of variants represent lines of an VCF file.
The `nrow` attribute define the amount of entries we want to get from the server.
For the dataset and variant set we want only the first entry.

The `searchVariants` function requests genomic variant data from the server.
It uses genomic intervals to retrieve these varants.
As R programming language, the genomic indice is 1-based.
If you want to see what reference names (e.g. chromosomes) are available run the `searchReferences` function.

```
datasets <- searchDatasets(host, nrows = 1)
datasetId <- datasets$id
variantSets <- searchVariantSets(host, datasetId, nrows = 1)
variantSetId <- variantSets$id
variants <- searchVariants(host, variantSetId, referenceName = "1",
    start = 15000, end = 16000, nrows = 10)
```

```
variants
```

```
## class: CollapsedVCF
## dim: 10 0
## rowRanges(vcf):
##   GRanges with 3 metadata columns: ID, REF, ALT
## info(vcf):
##   DataFrame with 14 columns: EUR_AF, SAS_AF, AC, AA, AF, AFR_AF, AMR_AF, AN,...
## info(header(vcf)):
##                  Number Type    Description
##    EUR_AF        A      Float   Allele frequency in the EUR populations calc...
##    SAS_AF        A      Float   Allele frequency in the SAS populations calc...
##    AC            A      Integer Total number of alternate alleles in called ...
##    AA            1      String  Ancestral Allele. Format: AA|REF|ALT|IndelTy...
##    AF            A      Float   Estimated allele frequency in the range (0,1)
##    AFR_AF        A      Float   Allele frequency in the AFR populations calc...
##    AMR_AF        A      Float   Allele frequency in the AMR populations calc...
##    AN            1      Integer Total number of alleles in called genotypes
##    VT            .      String  indicates what type of variant the line repr...
##    EAS_AF        A      Float   Allele frequency in the EAS populations calc...
##    NS            1      Integer Number of samples with data
##    EX_TARGET     0      Flag    indicates whether a variant is within the ex...
##    DP            1      Integer Total read depth; only low coverage data wer...
##    MULTI_ALLELIC 0      Flag    indicates whether a site is multi-allelic
## geno(vcf):
##   List of length 0:
```

Almost search functions will return an `DataFrame` object from *[S4Vector](https://bioconductor.org/packages/3.22/S4Vector)* package.
The `searchVariants` and `getVariant` functions will return an `VCF` object with header from *[VariantAnnotation](https://bioconductor.org/packages/3.22/VariantAnnotation)* package.
The `getVariantSet` function will return an `VCFHeader` object.
These three functions will return `DataFrame` object when `asVCF` or `asVCFHeader` parameters be `FALSE`.

```
variants.df <- searchVariants(host, variantSetId, referenceName = "1",
    start = 15000, end = 16000, nrows = 10, asVCF = FALSE)
```

```
DT::datatable(as.data.frame(variants.df), options = list(scrollX = TRUE))
```

Due to internet connection, there is a limit of amount for response data imposed by the server (or the `responseSize` parameter).
By default the function will make requests until get all response data.
Increasing the value of the `responseSize` parameter will reduce the number os requests to server.

# 4 Search Variants by genomic location of genes

Bioconductor has annotation packages for many genomes.
For example, the *[TxDb.Hsapiens.UCSC.hg19.knownGene](https://bioconductor.org/packages/3.22/TxDb.Hsapiens.UCSC.hg19.knownGene)* pakage exposes an annotation databases generated from UCSC by exposing these as TxDb objects.
Before using annotation packages, it is very important to check what version of reference genome was used by the GA4GH API-based data server.
In other words, what reference genome was used to align sequencing reads and call for variants.
This information can be accessed via `searchReferenceSets` function.

```
referenceSets <- searchReferenceSets(host, nrows = 1)
referenceSets$name
```

In this case, the version of reference genome is NCBI37, which is compatible with *[TxDb.Hsapiens.UCSC.hg19.knownGene](https://bioconductor.org/packages/3.22/TxDb.Hsapiens.UCSC.hg19.knownGene)*.

Get name of all available genes.

```
head(keys(org.Hs.eg.db, keytype = "SYMBOL"))
```

```
## [1] "A1BG"     "A2M"      "NAT1"     "NAT2"     "NATP"     "SERPINA3"
```

Get genomic location of all genes.

```
head(genes(TxDb.Hsapiens.UCSC.hg19.knownGene))
```

```
##   24 genes were dropped because they have exons located on both strands of the
##   same reference sequence or on more than one reference sequence, so cannot be
##   represented by a single genomic range.
##   Use 'single.strand.genes.only=FALSE' to get all the genes in a GRangesList
##   object, or use suppressMessages() to suppress this message.
```

```
## GRanges object with 6 ranges and 1 metadata column:
##             seqnames              ranges strand |     gene_id
##                <Rle>           <IRanges>  <Rle> | <character>
##           1    chr19   58856544-58874117      - |           1
##          10     chr8   18248792-18258728      + |          10
##         100    chr20   43213537-43280893      - |         100
##        1000    chr18   25512843-25757910      - |        1000
##       10000     chr1 243651535-244014381      - |       10000
##   100008586     chrX   49315881-49332821      + |   100008586
##   -------
##   seqinfo: 298 sequences (2 circular) from hg19 genome
```

Use case: search for variants located in SCN1A gene.

```
df <- select(org.Hs.eg.db, keys = "SCN1A", columns = c("SYMBOL", "ENTREZID"), keytype = "SYMBOL")
```

```
## 'select()' returned 1:1 mapping between keys and columns
```

```
gr <- genes(TxDb.Hsapiens.UCSC.hg19.knownGene, filter=list(gene_id=df$ENTREZID))
seqlevelsStyle(gr) <- "NCBI"
```

```
## Warning in (function (seqlevels, genome, new_style) : cannot switch some hg19's
## seqlevels from UCSC to NCBI style
```

```
variants.scn1a <- searchVariantsByGRanges(host, variantSetId, gr, asVCF = FALSE)
```

```
DT::datatable(as.data.frame(variants.scn1a[[1]]), options = list(scrollX = TRUE))
```

```
## Warning in instance$preRenderHook(instance): It seems your data is too big for
## client-side DataTables. You may consider server-side processing:
## https://rstudio.github.io/DT/server.html
```

Use case: locate annotation data for a group of variants located at SCN1A gene.

```
variants.scn1a.gr <- makeGRangesFromDataFrame(variants.scn1a[[1]],
    seqnames.field = "referenceName")
seqlevelsStyle(variants.scn1a.gr) <- "UCSC"
locateVariants(variants.scn1a.gr, TxDb.Hsapiens.UCSC.hg19.knownGene,
    CodingVariants())
```

```
## Warning in valid.GenomicRanges.seqinfo(x, suggest.trim = TRUE): GRanges object contains 3056 out-of-bound ranges located on sequences 57712,
##   57713, 57714, 57715, 57716, 57718, 57721, 57722, 57726, 57727, 57719, 57725,
##   57717, and 57720. Note that ranges located on a sequence whose length is
##   unknown (NA) or on a circular sequence are not considered out-of-bound (use
##   seqlengths() and isCircular() to get the lengths and circularity flags of the
##   underlying sequences). You can use trim() to trim these ranges. See
##   ?`trim,GenomicRanges-method` for more information.
```

```
## 'select()' returned many:1 mapping between keys and columns
```

```
## GRanges object with 1301 ranges and 9 metadata columns:
##          seqnames    ranges strand | LOCATION  LOCSTART    LOCEND   QUERYID
##             <Rle> <IRanges>  <Rle> | <factor> <integer> <integer> <integer>
##      [1]     chr2 166847834      - |   coding      5915      5915        51
##      [2]     chr2 166847834      - |   coding      5669      5669        51
##      [3]     chr2 166847834      - |   coding      5951      5951        51
##      [4]     chr2 166847834      - |   coding      5951      5951        51
##      [5]     chr2 166847834      - |   coding      5918      5918        51
##      ...      ...       ...    ... .      ...       ...       ...       ...
##   [1297]     chr2 166930078      - |   coding        54        54      2160
##   [1298]     chr2 166930078      - |   coding        54        54      2160
##   [1299]     chr2 166930078      - |   coding        54        54      2160
##   [1300]     chr2 166930078      - |   coding        54        54      2160
##   [1301]     chr2 166930078      - |   coding        54        54      2160
##                 TXID         CDSID      GENEID       PRECEDEID        FOLLOWID
##          <character> <IntegerList> <character> <CharacterList> <CharacterList>
##      [1]       57712         43709        6323
##      [2]       57713         43709        6323
##      [3]       57714         43709        6323
##      [4]       57715         43709        6323
##      [5]       57716         43709        6323
##      ...         ...           ...         ...             ...             ...
##   [1297]       57722         43749        6323
##   [1298]       57723         43749        6323
##   [1299]       57725         43749        6323
##   [1300]       57727         43749        6323
##   [1301]       57734         43749        6323
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

# 5 VariantAnnotation classes

The `searchVariants` and `getVariant` functions return `VCF` objects.
These `VCF` objects contains the VCF header.
This is an example of how to get variants with call data.
We can get calls running the `searchCallSets` function.
After convertion, it can be written into disk as VCF file using `writeVcf`.

```
callSetIds <- searchCallSets(host, variantSetId, nrows = 5)$id
vcf <- searchVariants(host, variantSetId, referenceName = "1",
    start = 15000, end = 16000, callSetIds = callSetIds, nrows = 10)
```

```
vcf
```

```
## class: CollapsedVCF
## dim: 10 5
## rowRanges(vcf):
##   GRanges with 3 metadata columns: ID, REF, ALT
## info(vcf):
##   DataFrame with 14 columns: EUR_AF, SAS_AF, AC, AA, AF, AFR_AF, AMR_AF, AN,...
## info(header(vcf)):
##                  Number Type    Description
##    EUR_AF        A      Float   Allele frequency in the EUR populations calc...
##    SAS_AF        A      Float   Allele frequency in the SAS populations calc...
##    AC            A      Integer Total number of alternate alleles in called ...
##    AA            1      String  Ancestral Allele. Format: AA|REF|ALT|IndelTy...
##    AF            A      Float   Estimated allele frequency in the range (0,1)
##    AFR_AF        A      Float   Allele frequency in the AFR populations calc...
##    AMR_AF        A      Float   Allele frequency in the AMR populations calc...
##    AN            1      Integer Total number of alleles in called genotypes
##    VT            .      String  indicates what type of variant the line repr...
##    EAS_AF        A      Float   Allele frequency in the EAS populations calc...
##    NS            1      Integer Number of samples with data
##    EX_TARGET     0      Flag    indicates whether a variant is within the ex...
##    DP            1      Integer Total read depth; only low coverage data wer...
##    MULTI_ALLELIC 0      Flag    indicates whether a site is multi-allelic
## geno(vcf):
##   List of length 1: GT
## geno(header(vcf)):
##       Number Type   Description
##    GT 1      String Genotype
```

```
header(vcf)
```

```
## class: VCFHeader
## samples(0):
## meta(0):
## fixed(0):
## info(27): CIEND CIPOS ... EX_TARGET MULTI_ALLELIC
## geno(1): GT
```

The `vcf` object works as expected.
We can get the genotype data for example.
More information about working with VCF data see `vignette("VariantAnnotation")`.

```
geno(vcf)$GT
```

```
##       HG00096 HG00097 HG00099 HG00100 HG00101
##  [1,] "0|0"   "0|0"   "0|1"   "0|0"   "0|0"
##  [2,] "0|0"   "0|0"   "0|1"   "0|0"   "0|0"
##  [3,] "0|0"   "0|0"   "0|1"   "0|0"   "0|0"
##  [4,] "0|0"   "0|0"   "0|1"   "0|0"   "0|0"
##  [5,] "0|0"   "0|0"   "1|0"   "0|0"   "0|0"
##  [6,] "0|0"   "0|0"   "0|0"   "0|0"   "1|2"
##  [7,] "0|0"   "0|0"   "0|0"   "0|0"   "2|2"
##  [8,] "0|0"   "0|0"   "0|0"   "0|0"   "2|2"
##  [9,] "0|0"   "0|0"   "0|0"   "0|0"   "1|2"
## [10,] "0|0"   "0|0"   "0|0"   "0|0"   "1|2"
```

# 6 Session Information

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
##  [1] GenomeInfoDb_1.46.0
##  [2] VariantAnnotation_1.56.0
##  [3] Rsamtools_2.26.0
##  [4] Biostrings_2.78.0
##  [5] XVector_0.50.0
##  [6] SummarizedExperiment_1.40.0
##  [7] MatrixGenerics_1.22.0
##  [8] matrixStats_1.5.0
##  [9] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
## [10] GenomicFeatures_1.62.0
## [11] GenomicRanges_1.62.0
## [12] Seqinfo_1.0.0
## [13] org.Hs.eg.db_3.22.0
## [14] AnnotationDbi_1.72.0
## [15] IRanges_2.44.0
## [16] Biobase_2.70.0
## [17] GA4GHclient_1.34.0
## [18] S4Vectors_0.48.0
## [19] BiocGenerics_0.56.0
## [20] generics_0.1.4
## [21] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] KEGGREST_1.50.0          rjson_0.2.23             xfun_0.53
##  [4] bslib_0.9.0              htmlwidgets_1.6.4        lattice_0.22-7
##  [7] crosstalk_1.2.2          vctrs_0.6.5              tools_4.5.1
## [10] bitops_1.0-9             curl_7.0.0               parallel_4.5.1
## [13] tibble_3.3.0             RSQLite_2.4.3            blob_1.2.4
## [16] pkgconfig_2.0.3          Matrix_1.7-4             BSgenome_1.78.0
## [19] cigarillo_1.0.0          lifecycle_1.0.4          compiler_4.5.1
## [22] codetools_0.2-20         htmltools_0.5.8.1        sass_0.4.10
## [25] RCurl_1.98-1.17          yaml_2.3.10              pillar_1.11.1
## [28] crayon_1.5.3             jquerylib_0.1.4          DT_0.34.0
## [31] BiocParallel_1.44.0      DelayedArray_0.36.0      cachem_1.1.0
## [34] abind_1.4-8              tidyselect_1.2.1         digest_0.6.37
## [37] dplyr_1.1.4              restfulr_0.0.16          bookdown_0.45
## [40] fastmap_1.2.0            grid_4.5.1               cli_3.6.5
## [43] SparseArray_1.10.0       magrittr_2.0.4           S4Arrays_1.10.0
## [46] XML_3.99-0.19            UCSC.utils_1.6.0         bit64_4.6.0-1
## [49] rmarkdown_2.30           httr_1.4.7               bit_4.6.0
## [52] png_0.1-8                memoise_2.0.1            evaluate_1.0.5
## [55] knitr_1.50               BiocIO_1.20.0            rtracklayer_1.70.0
## [58] rlang_1.1.6              glue_1.8.0               DBI_1.2.3
## [61] BiocManager_1.30.26      jsonlite_2.0.0           R6_2.6.1
## [64] GenomicAlignments_1.46.0
```