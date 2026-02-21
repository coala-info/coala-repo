COSMIC 67

Julian Gehring, EMBL Heidelberg

November 4, 2025

Contents

1

2

3

4

5

6

Introduction .

.

.

.

.

.

.

.

.

.

.

.

Accessing and Using the Data .

Data Provenance .

.

.

.

3.1

3.2

COSMIC Mutations .

Cancer Gene Census.

Data Source .

References .

Session Info .

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

.

1

1

4

4

5

5

5

5

1

Introduction

The COSMIC.67 package provides the curated mutations published with the COSMIC release
version 67 (2013-10-24). Both variants found in coding and non-coding regions are included
and offered as a single object of class ’CollapsedVCF’ and a bgzipped and tabix-index ’VCF’
file.

Additionally, the package contains the Cancer Gene Census, a list of genes causally linked to
cancer.

2

Accessing and Using the Data

library(VariantAnnotation)

Loading required package: BiocGenerics

Loading required package: generics

Attaching package: ’generics’

The following objects are masked from ’package:base’:

COSMIC 67

as.difftime, as.factor, as.ordered, intersect,

is.element, setdiff, setequal, union

Attaching package: ’BiocGenerics’

The following objects are masked from ’package:stats’:

IQR, mad, sd, var, xtabs

The following objects are masked from ’package:base’:

Filter, Find, Map, Position, Reduce, anyDuplicated,

aperm, append, as.data.frame, basename, cbind,

colnames, dirname, do.call, duplicated, eval, evalq,

get, grep, grepl, is.unsorted, lapply, mapply, match,

mget, order, paste, pmax, pmax.int, pmin, pmin.int,

rank, rbind, rownames, sapply, saveRDS, table,

tapply, unique, unsplit, which.max, which.min

Loading required package: MatrixGenerics

Loading required package: matrixStats

Attaching package: ’MatrixGenerics’

The following objects are masked from ’package:matrixStats’:

colAlls, colAnyNAs, colAnys, colAvgsPerRowSet,

colCollapse, colCounts, colCummaxs, colCummins,

colCumprods, colCumsums, colDiffs, colIQRDiffs,

colIQRs, colLogSumExps, colMadDiffs, colMads,

colMaxs, colMeans2, colMedians, colMins,

colOrderStats, colProds, colQuantiles, colRanges,

colRanks, colSdDiffs, colSds, colSums2, colTabulates,

colVarDiffs, colVars, colWeightedMads,

colWeightedMeans, colWeightedMedians, colWeightedSds,

colWeightedVars, rowAlls, rowAnyNAs, rowAnys,

rowAvgsPerColSet, rowCollapse, rowCounts, rowCummaxs,

rowCummins, rowCumprods, rowCumsums, rowDiffs,

rowIQRDiffs, rowIQRs, rowLogSumExps, rowMadDiffs,

rowMads, rowMaxs, rowMeans2, rowMedians, rowMins,

rowOrderStats, rowProds, rowQuantiles, rowRanges,

rowRanks, rowSdDiffs, rowSds, rowSums2, rowTabulates,

rowVarDiffs, rowVars, rowWeightedMads,

rowWeightedMeans, rowWeightedMedians, rowWeightedSds,

rowWeightedVars

Loading required package: Seqinfo

Loading required package: GenomicRanges

Loading required package: stats4

Loading required package: S4Vectors

2

COSMIC 67

Attaching package: ’S4Vectors’

The following object is masked from ’package:utils’:

findMatches

The following objects are masked from ’package:base’:

I, expand.grid, unname

Loading required package: IRanges

Loading required package: SummarizedExperiment

Loading required package: Biobase

Welcome to Bioconductor

Vignettes contain introductory material; view with

’browseVignettes()’. To cite Bioconductor, see

’citation("Biobase")’, and for packages

’citation("pkgname")’.

Attaching package: ’Biobase’

The following object is masked from ’package:MatrixGenerics’:

rowMedians

The following objects are masked from ’package:matrixStats’:

anyMissing, rowMedians

Loading required package: Rsamtools

Loading required package: Biostrings

Loading required package: XVector

Attaching package: ’Biostrings’

The following object is masked from ’package:base’:

strsplit

Attaching package: ’VariantAnnotation’

The following object is masked from ’package:base’:

tabulate

library(GenomicRanges)

data(package = "COSMIC.67")
data(cosmic_67, package = "COSMIC.67")

tp53_range = GRanges("17", IRanges(7565097, 7590856))
vcf_path = system.file("vcf", "cosmic_67.vcf.gz", package = "COSMIC.67")
cosmic_tp53 = readVcf(vcf_path, genome = "GRCh37", ScanVcfParam(which = tp53_range))

3

COSMIC 67

cosmic_tp53

class: CollapsedVCF

dim: 5892 0

rowRanges(vcf):

GRanges with 5 metadata columns: paramRangeID, REF, ALT, QUAL, FILTER

info(vcf):

DataFrame with 5 columns: GENE, STRAND, CDS, AA, CNT

info(header(vcf)):

Number Type

Description

GENE

1

STRAND 1

String Gene name

String Gene strand

CDS

AA

CNT

1

1

1

geno(vcf):

String CDS annotation

String Peptide annotation

Integer How many samples have this mutation

List of length 0:

data(cgc_67, package = "COSMIC.67")
head(cgc_67)

SYMBOL ENTREZID

ENSEMBL

1

2

3

4

5

ABI1

ABL1

ABL2

ACSL3

CASC5

10006 ENSG00000136754

25 ENSG00000097007

27 ENSG00000143322

2181 ENSG00000123983

57082 ENSG00000137812

6 MLLT11

10962 ENSG00000213190

For details on the collection and curation of the original data, please see the webpage of the
COSMIC project: http://cancer.sanger.ac.uk/cancergenome/projects/cosmic/.

3

3.1

Data Provenance

COSMIC Mutations
The following steps are performed for importing and processing of the VCF data:

1. Downloading of the VCF files ’CosmicCodingMuts_v67_20131024.vcf.gz’ and ’Cosmic-

NonCodingVariants_v67_20131024.vcf.gz’ from ’ftp://ngs.sanger.ac.uk/production/cosmic/’
to ’inst/raw/’.

2. Importing of both files to R using ’readVcf’.

3. Sorting of the seqlevels and adding ’seqinfo’ data for the toplevel chromosomes of

’GRCh37’.

4. Merging of both objects, sorting according to genomic position.

5. Converting the object to class VariantAnnotation::VRanges.

6. Converting the ’character’ columns to ’factors’.

7. Saving the merged object to ’data/cosmic_v67_vcf.rda’.

4

COSMIC 67

8. Exporting the merged object as a bgzipped and tabix-indexed ’VCF’ to ’inst/vcf/cosmic_v67.vcf.gz’.

3.2

Cancer Gene Census
The following steps are performed for importing and processing of the Cancer Gene Census
data:

1. Downloading of the ’cancer_gene_census.tsv’ file from ftp://ftp.sanger.ac.uk/pub/

CGP/cosmic/data_export to ’inst/raw’.

2. Import of the files as a data frame.

3. Annotation of the ’HGNC’ and ’ENSEMBLID’ identifiers, using the ’ENTREZ gene ID’

as query with the ’org.Hs.eg.db’ object.

4. Saving the object to ’data/cgc_67.rda’.

4

Data Source

The mutation data was obtained from the Sanger Institute Catalogue Of Somatic Mutations
In Cancer web site, http://www.sanger.ac.uk/cosmic

Bamford et al (2004):
The COSMIC (Catalogue of Somatic Mutations in Cancer) database and website.
Br J Cancer, 91,355-358.

For details on the usage and redistribution of the data, please see ftp://ftp.sanger.ac.uk/
pub/CGP/cosmic/GUIDELINES_ON_THE_USE_OF_THIS_DATA.txt.

5

References

• http://cancer.sanger.ac.uk/cancergenome/projects/cosmic/

• http://nar.oxfordjournalls.org/content/39/suppl_1/D945.long

• ftp://ftp.sanger.ac.uk/pub/CGP/cosmic/GUIDELINES_ON_THE_USE_OF_THIS_

DATA.txt

6

Session Info

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default

BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

locale:
[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_GB
[5] LC_MONETARY=en_US.UTF-8

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8

5

COSMIC 67

[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C
[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

LC_NAME=C
LC_TELEPHONE=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:

[1] stats4

stats

graphics grDevices utils

datasets

[7] methods

base

other attached packages:
Rsamtools_2.26.0
[1] VariantAnnotation_1.56.0
[3] Biostrings_2.78.0
XVector_0.50.0
[5] SummarizedExperiment_1.40.0 Biobase_2.70.0
IRanges_2.44.0
[7] GenomicRanges_1.62.0
Seqinfo_1.0.0
[9] S4Vectors_0.48.0
matrixStats_1.5.0
[11] MatrixGenerics_1.22.0
[13] BiocGenerics_0.56.0
generics_0.1.4
[15] knitr_1.50

loaded via a namespace (and not attached):
bitops_1.0-9
[1] SparseArray_1.10.1
lattice_0.22-7
[3] RSQLite_2.4.3
evaluate_1.0.5
[5] digest_0.6.37
fastmap_1.2.0
[7] grid_4.5.1
Matrix_1.7-4
[9] blob_1.2.4
AnnotationDbi_1.72.0
[11] cigarillo_1.0.0
DBI_1.2.3
[13] restfulr_0.0.16
httr_1.4.7
[15] BiocManager_1.30.26
XML_3.99-0.19
[17] BSgenome_1.78.0
abind_1.4-8
[19] codetools_0.2-20
rlang_1.1.6
[21] cli_3.6.5
BiocStyle_2.38.0
[23] crayon_1.5.3
cachem_1.1.0
[25] bit64_4.6.0-1
yaml_2.3.10
[27] DelayedArray_0.36.0
S4Arrays_1.10.0
[29] GenomicFeatures_1.62.0
parallel_4.5.1
[31] tools_4.5.1
memoise_2.0.1
[33] BiocParallel_1.44.0
vctrs_0.6.5
[35] curl_7.0.0
png_0.1-8
[37] R6_2.6.1
rtracklayer_1.70.0
[39] BiocIO_1.20.0
bit_4.6.0
[41] KEGGREST_1.50.0
GenomicAlignments_1.46.0
[43] highr_0.11
rjson_0.2.23
[45] xfun_0.54
rmarkdown_2.30
[47] htmltools_0.5.8.1
RCurl_1.98-1.17
[49] compiler_4.5.1

6

