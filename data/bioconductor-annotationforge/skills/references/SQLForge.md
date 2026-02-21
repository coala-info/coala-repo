Creating a New Annotation Package using
SQLForge

Marc Carlson, Hervé Pagès, Nianhua Li

October 29, 2025

1

Introduction

The AnnotationForge package provides a series of functions that can be used to
build AnnotationDbi packages for supported organisms. This collection of functions
is called SQLForge.

In order to use SQLForge you really only need to have one kind of information and
that is a list of paired IDs. These IDs are to be stored in a tab delimited file that is
formatted in the same way that they used to be for the older AnnBuilder package.
For those who are unfamiliar with the AnnBuilder package, this just means that there
are two columns separated by a tab where the column on the left contains probe or
probeset identifiers and the column on the right contains some sort of widely accepted
gene accession. This file should NOT contain a header. SQLForge will then use these
IDs along with it’s own support databases to make an AnnotationDbi package for
you. Here is how these IDs should look if you were to read them into R:

library(RSQLite)

library(AnnotationForge)
read.table(system.file("extdata", "hcg110_ID",

package="AnnotationDbi"),

sep = "\t", header = FALSE, as.is = TRUE)[1:5,]

##

## 1

V2
V1
1000_at X60188
1001_at X60957
## 2
## 3 1002_f_at X65962
## 4 1003_s_at X68149
1004_at X68149
## 5

In the example above, Genbank IDs are demonstrated. But it is also possible to use
If refseq IDs are used, it is
entrez gene IDs, or refseq IDs as the gene identifiers.
preferable to strip off the version extensions that can sometimes be added on by some
vendors. The version extensions are digits that are sometimes tacked onto the end
of a refseq ID and separated from the accession by a dot. As an example consider
"NM_000193.2" . The "NM_000193" portion would be the actual accession number
and the ".2" would be the version number. These version numbers are not used by
these databases and their presence in your input can cause less than desirable results.

Creating a New Annotation Package using SQLForge

Alternatively, if you have an annotation file for an Affymetrix chip, you can use a
parameter called affy that will automatically parse such a file and produce a similar
mapping from that. It is important to understand however that despite that rather
rich contents of an Affymetrix annotation file, almost none of these data are used
in the making of an annotation package with SQLForge.
Instead, the relevant IDs
are stripped out, and then passed along to SQLForge as if you had created a file like
is seen above. The option here to use such a file is offered purely as a convenience
because the platform is so popular.

If you have additional information about your probes in the form of other kinds of
supported gene IDs, you can pass these in as well by using the otherSrc parameter.
These IDs must be formatted using the same two column format as described above,
and if there are multiple source files, then you can pass them in as a list of strings
that correspond to the file paths for these files.

Once you have your IDs ready, SQLForge will read them in, and use the gene IDs to
compare to an intermediate database. The data from this database is what is used
to make the specialized database that is placed inside of an annotation package.

At the present time, it is possible to make annotation packages for the most common
model organisms. For each of these organisms another support package will be
maintained and updated biannually which will include all the basic data gathered
for this organism from sources such as NCBI, GO, KEGG and Flybase etc. These
support packages will each be named after the organism they are intended for and
will each include a large sqlite database with all the supporting information for that
organism. Please note that support databases are not necessary unless you intend to
actually make a new annotation package for one of the supported organisms. In the
case where you want to make annotation packages, the support databases are only
required for the organism in question. When SQLForge makes a new database, it
uses the information supplied by the support database as the data source to make the
annotation package. So the relevant support packages needs to be updated to the
latest version in order to guarantee that the annotation packages you produce will be
made with information from the last biannual update. These support packages are
not meant to be annotation packages themselves and they come with no schema of
their own. Instead these are merely a way to distribute the data to those who want
to make custom annotation packages.

To check if your organism is supported simply look in the metadata packages repos-
itory on the bioconductor website for a .db0 package. Only special organism base
packages will end with the .db0 extension. If you find a package that is named after
the organism you are interested in, then your organism is supported, and you can
use that database to make custom packages. To list all the supported organism .db0
packages directly from R you can use available.db0pkgs().

available.db0pkgs()

## [1] "anopheles.db0"

"arabidopsis.db0" "bovine.db0"

"canine.db0"

## [5] "chicken.db0"

"chimp.db0"

"ecoliK12.db0"

"ecoliSakai.db0"

2

Creating a New Annotation Package using SQLForge

## [9] "fly.db0"

"human.db0"

"malaria.db0"

"mouse.db0"

## [13] "pig.db0"

"rat.db0"

"rhesus.db0"

"worm.db0"

## [17] "xenopus.db0"

"yeast.db0"

"zebrafish.db0"

2

How to use SQLForge

Once you know the name of the package that you need, you can get the latest .db0
package for your organism by using BiocManager::install():

library(BiocManager)

install("human.db0")

## Loading required package:

human.db0

Even if you have installed the .db0 package before, it’s a good idea to run this again
to be sure that you have the latest organism package.

Once you have the appropriate .db0 package, you may also need to install the appro-
priate org.* package. Most users probably have this already, because using any chip
packages for this organism will require it. But if you don’t have it yet, you can find
a list of these packagesit on the web site here:

http://www.bioconductor.org/packages/release/BiocViews.html#___OrgDb

Once you know the name of the package you need, you can install it like before.

install("org.Hs.eg.db")

All the supported organisms with a .db0 package, will also have a matching org.*
package. The org.* packages are named like this: org.<species abbreviation>.<source
abbreviation>.db. The source indicates where the data originates from and also which
central ID the data all connects to, while the species abbreviation indicates which
organism the data is for. The web site spells out the species a bit more clearly by
listing the titles for each package.

Since each organism will have different kinds of data available, the schemas that will
be needed for each organism will also change. SQLForge provides support functions
for each of the model organisms that will create a sqlite database that complies
with a specified database schema. The following helper function will list supported
Schemas.

available.dbschemas()

## [1] "ARABIDOPSISCHIP_DB" "BOVINECHIP_DB"
## [4] "CANINECHIP_DB"
## [7] "CHICKEN_DB"
## [10] "FLYCHIP_DB"

"CANINE_DB"
"ECOLICHIP_DB"
"FLY_DB"

"BOVINE_DB"
"CHICKENCHIP_DB"
"ECOLI_DB"
"GO_DB"

3

Creating a New Annotation Package using SQLForge

"HUMAN_DB"

"HUMANCROSSCHIP_DB"

## [13] "HUMANCHIP_DB"
## [16] "INPARANOIDDROME_DB" "INPARANOIDHOMSA_DB" "INPARANOIDMUSMU_DB"
## [19] "INPARANOIDRATNO_DB" "INPARANOIDSACCE_DB" "KEGG_DB"
"MOUSE_DB"
## [22] "MALARIA_DB"
"PIG_DB"
## [25] "PFAM_DB"
"WORMCHIP_DB"
## [28] "RATCHIP_DB"
"YEAST_DB"
## [31] "WORM_DB"
## [34] "ZEBRAFISHCHIP_DB"

"MOUSECHIP_DB"
"PIGCHIP_DB"
"RAT_DB"
"YEASTCHIP_DB"
"ZEBRAFISH_DB"

The following shows an example of how to make a chip package:

hcg110_IDs = system.file("extdata",

"hcg110_ID",
package="AnnotationDbi")

tmpout = tempdir()

makeDBPackage("HUMANCHIP_DB",

affy=FALSE,

prefix="hcg110",
fileName=hcg110_IDs,
baseMapType="gb",

outputDir = tmpout,

version="1.0.0",

manufacturer = "Affymetrix",

chipName = "Human Cancer G110 Array",

manufacturerUrl = "http://www.affymetrix.com")

##

##

##

##

##

##

##

##

##

##

##

##

4

Creating a New Annotation Package using SQLForge

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

##

Wrapper functions are provided for making all of the different kinds of chip based
package types that are presently defined. These are named after the schemas that
they correspond to. So for example makeHUMANCHIP_DB() corresponds to the HU-
MANCHIP_DB schema, and is used to produce chip based annotation packages of
that type.

2.1

Installing your custom package

To install your package in Unix simply use R CMD INSTALL <packageName> at
the command line. But if you are on Windows or Mac, you may have to instead
use install.packages from within R. This will work because this kind of simple
annotation package does not contain any code that has to be compiled. So you can
simply call install.packages and set the repos parameter to NULL and the type
parameter to "source". The final R command will look something like this:

5

Creating a New Annotation Package using SQLForge

install.packages("packageNameAndPath", repos=NULL, type="source")

Of course, you still have to type the path to your source directory correctly as the
1st argument. It is recommended that you use the autocomplete feature in R as you
enter it so that you get the path specified correctly.

3

For Advanced users: How to add extra data into
your packages

Sometimes you may find that you want to add extra supplementary data into the
database for the package that you just created.
In these cases, you will have to
begin by using the SQL to add more data into the database. Before you can do
that however, you will have to change the permissions on the sqlite database. The
database will always be in the inst/extdata directory of your package source after you
run SQLForge. Once you can edit your database, you will have to create a new table,
and populate that table with new information using SQL statements. One good way
to do this would be to use the RSQLite interface that is introduced in portions of the
AnnotationDbi vignette. For a more thorough treatment of the RSQLite package,
please see the vignette for that package at CRAN. Once you are finished editing the
database with SQL, be sure to change the database file back to being a read only
file.

However, adding the content to the database is only the 1st part of what has to be
In order for the data to be exposed to the R layer as a mapping, you will
done.
have to also create and document a mapping object. To do this step we have added
a simple utility function to AnnotationDbi that allows you to make a simple Bimap
from a single table. The following example will make an additional mapping between
the gene names and the gene symbols found in the gene_info table for the package
hgu95av2.db. For this particular example, no additional SQL has to be inserted 1st
into the database since it is just adding a mapping onto data that already exists in
the database (but is just not normally exposed as a mapping).

library(hgu95av2.db)

##

hgu95av2NAMESYMBOL <- createSimpleBimap("gene_info",
"gene_name",
"symbol",

hgu95av2.db:::datacache,

"NAMESYMBOL",

"hgu95av2.db")

##What is the mapping we just made?

hgu95av2NAMESYMBOL

## NAMESYMBOL map for hgu95av2.db (object of class "AnnDbBimap")

6

Creating a New Annotation Package using SQLForge

##Display the 1st 4 relationships in this new mapping

as.list(hgu95av2NAMESYMBOL)[1:4]

## $`alpha-1-B glycoprotein`
## [1] "A1BG"

##
## $`alpha-2-macroglobulin`
## [1] "A2M"

##
## $`N-acetyltransferase 1`
## [1] "NAT1"

##
## $`N-acetyltransferase 2`
## [1] "NAT2"

If instead of creating a mapping on an existing example, you wanted to add a new
mapping to your customized annotation package, you would need to call this function
from zzz.R in your modified annotation package (and also expose it in the names-
pace). You will then want to be sure that your updated database has replaced the
one in the inst/extdata directory that was originally generated by SQLForge. And
finally, you will need to also put a man page into your package so that users will
know how to make use of this new mapping.

4

Session Information

The version number of R and packages loaded for generating the vignette were:

## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS

##

## Matrix products: default

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##

LAPACK version 3.12.0

## locale:
## [1] LC_CTYPE=en_US.UTF-8
## [3] LC_TIME=en_GB
## [5] LC_MONETARY=en_US.UTF-8
## [7] LC_PAPER=en_US.UTF-8
## [9] LC_ADDRESS=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

7

Creating a New Annotation Package using SQLForge

##

## attached base packages:

## [1] stats4

stats

graphics

grDevices utils

datasets

methods

## [8] base

##

## other attached packages:
## [1] hgu95av2.db_3.13.0
## [2] human.db0_3.22.0
## [3] Biostrings_2.78.0
## [4] XVector_0.50.0
## [5] XML_3.99-0.19
## [6] Homo.sapiens_1.3.1
## [7] TxDb.Hsapiens.UCSC.hg19.knownGene_3.22.1
## [8] org.Hs.eg.db_3.22.0
## [9] GO.db_3.22.0
## [10] OrganismDbi_1.52.0
## [11] GenomicFeatures_1.62.0
## [12] GenomicRanges_1.62.0
## [13] Seqinfo_1.0.0
## [14] RSQLite_2.4.3
## [15] knitr_1.50
## [16] AnnotationForge_1.52.0
## [17] AnnotationDbi_1.72.0
## [18] IRanges_2.44.0
## [19] S4Vectors_0.48.0
## [20] Biobase_2.70.0
## [21] BiocGenerics_0.56.0
## [22] generics_0.1.4
## [23] BiocStyle_2.38.0
##

## loaded via a namespace (and not attached):
## [1] tidyselect_1.2.1
## [3] blob_1.2.4
## [5] bitops_1.0-9
## [7] RCurl_1.98-1.17
## [9] GenomicAlignments_1.46.0
## [11] lifecycle_1.0.4
## [13] magrittr_2.0.4
## [15] rlang_1.1.6
## [17] tools_4.5.1
## [19] rtracklayer_1.70.0
## [21] bit_4.6.0
## [23] DelayedArray_0.36.0
## [25] BiocParallel_1.44.0
## [27] purrr_1.1.0

dplyr_1.1.4
filelock_1.0.3
fastmap_1.2.0
BiocFileCache_3.0.0
digest_0.6.37
KEGGREST_1.50.0
compiler_4.5.1
sass_0.4.10
yaml_2.3.10
S4Arrays_1.10.0
curl_7.0.0
abind_1.4-8
withr_3.0.2
grid_4.5.1

8

Creating a New Annotation Package using SQLForge

## [29] preprocessCore_1.72.0
## [31] cli_3.6.5
## [33] crayon_1.5.3
## [35] rjson_0.2.23
## [37] DBI_1.2.3
## [39] affy_1.88.0
## [41] BiocManager_1.30.26
## [43] matrixStats_1.5.0
## [45] Matrix_1.7-4
## [47] litedown_0.7
## [49] bit64_4.6.0-1
## [51] jquerylib_0.1.4
## [53] glue_1.8.0
## [55] BiocIO_1.20.0
## [57] pillar_1.11.1
## [59] htmltools_0.5.8.1
## [61] httr2_1.2.1
## [63] dbplyr_2.5.1
## [65] lattice_0.22-7
## [67] highr_0.11
## [69] Rsamtools_2.26.0
## [71] memoise_2.0.1
## [73] SparseArray_1.10.0
## [75] MatrixGenerics_1.22.0

SummarizedExperiment_1.40.0
rmarkdown_2.30
httr_1.4.7
commonmark_2.0.0
cachem_1.1.0
parallel_4.5.1
restfulr_0.0.16
vctrs_0.6.5
jsonlite_2.0.0
bookdown_0.45
RBGL_1.86.0
affyio_1.80.0
codetools_0.2-20
tibble_3.3.0
rappdirs_0.3.3
graph_1.88.0
R6_2.6.1
evaluate_1.0.5
markdown_2.0
png_0.1-8
cigarillo_1.0.0
bslib_0.9.0
xfun_0.53
pkgconfig_2.0.3

9

