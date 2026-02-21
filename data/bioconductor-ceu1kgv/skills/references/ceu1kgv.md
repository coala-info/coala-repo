Building ceu1kgv

VJ Carey

November 1, 2018

1

Introduction

The collection of 1KG genotype calls and expression data for CEU HapMap lines is
a complicated process. Channing has worked with various images of the CEU data,
obtained before central distribution at ArrayExpress. Here we document clearly how to
combine ArrayExpress data with VCF on 1KG.

2 Expression data

Brieﬂy, the ArrayExpress E-MTAB-198.processed.1.zip ﬁle includes two matrices of nor-
malized expression values, one with 60 samples, one with 109. The latter is converted
to a matrix and the probe IDs are converted to nuIDs using lumiHumanIDMapping
package.

It is regrettable that the ArrayExpress function fails (as of 11/15/13) to work with

a request for this E-MTAB resource.

3 Genotype data

We use VCF representations of genotype calls as found in such 1000 genome resources
as

ALL.chr22.phase1_release_v3.20101123.snps_indels_svs.genotypes.vcf.gz
ALL.chr22.phase1_release_v3.20101123.snps_indels_svs.genotypes.vcf.gz.tbi

Code that imports the genotype information and converts to a snpStats SnpMatrix

instance is

> dochrGr = function(chrn, ids, which, genome="hg19",
+ path2vcf = "/proj/rerefs/reref00/1000Genomes_Phase1_v3/ALL/") {
+ Require(VariantAnnotation)
+ Require(snpStats)

1

full=TRUE)

+ allvc = dir(path2vcf, patt="ALL.*gz$",
+
+ f_ind = grep(paste0(chrn, "\\."), allvc)
+ cpath = allvc[f_ind]
+ stopifnot(file.exists(cpath))
+ stopifnot(length(cpath)==1)
+ vp = ScanVcfParam( info=NA, geno="GT", fixed="ALT", samples=ids,
+
+ tmp = readVcf( cpath, genome=genome, param=vp )
+ sz = prod(dim(tmp))
+ if (sz == 0) return(NULL)
+ genotypeToSnpMatrix(tmp)$genotypes
+ }

which=which )

The chromosome-speciﬁc SnpMatrix indices are stored in inst/parts of the source

image of this package.

4

Integrative data container

We use GGBase getSS to combine expression and genotype data in a compact format.

> library(GGBase)
> c22 = getSS("ceu1kgv", "chr22")
> c22

SnpMatrix-based genotype set:
number of samples: 79
number of chromosomes present: 1
annotation: lumiHumanAll.db
Expression data dims: 46713 x 79
Total number of SNP: 494328
Phenodata: An object of class

’

AnnotatedDataFrame

’

rowNames: NA06984 NA06986 ... NA12890 (79 total)
varLabels: IID FID ... V12 (18 total)
varMetadata: labelDescription

5 Session information

> sessionInfo()

R version 3.5.1 Patched (2018-07-12 r74967)
Platform: x86_64-pc-linux-gnu (64-bit)

2

Running under: Ubuntu 16.04.5 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] stats

graphics grDevices utils

datasets methods

base

other attached packages:
[1] GGBase_3.44.0

snpStats_1.32.0 Matrix_1.2-14

survival_2.43-1

loaded via a namespace (and not attached):

[1] Rcpp_0.12.19
[3] XVector_0.22.0
[5] BiocGenerics_0.28.0
[7] zlibbioc_1.28.0
[9] bit_1.1-14
[11] xtable_1.8-3
[13] blob_1.1.1
[15] tools_3.5.1
[17] parallel_3.5.1
[19] Biobase_2.42.0
[21] genefilter_1.64.0
[23] bit64_0.9-7
[25] GenomeInfoDbData_1.2.0
[27] bitops_1.0-6
[29] memoise_1.1.0
[31] DelayedArray_0.8.0
[33] stats4_3.5.1
[35] annotate_1.60.0

AnnotationDbi_1.44.0
GenomicRanges_1.34.0
splines_3.5.1
IRanges_2.16.0
BiocParallel_1.16.0
lattice_0.20-35
GenomeInfoDb_1.18.0
SummarizedExperiment_1.12.0
grid_3.5.1
DBI_1.0.0
matrixStats_0.54.0
digest_0.6.18
S4Vectors_0.20.0
RCurl_1.95-4.11
RSQLite_2.1.1
compiler_3.5.1
XML_3.98-1.16

3

