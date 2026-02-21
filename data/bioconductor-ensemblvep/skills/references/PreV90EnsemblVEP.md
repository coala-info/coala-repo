Overview of ensemblVEP Pre Ensembl 90

Valerie Obenchain and Lori Shepherd

March 15, 2018

Contents

1 Introduction

2 Results as R objects

3 Write results to a ﬁle

4 Conﬁguring runtime options

5 sessionInfo()

1 Introduction

1

1

4

4

5

Ensembl provides the facility to predict functional consequences of known and unknown variants using the Variant Eﬀect
Predictor (VEP). The ensemblVEP package wraps Ensembl VEP and returns the results as Robjects or a ﬁle on disk.
To use this package the Ensembl VEP perl script must be installed in your path. See the package README for details.
NOTE: As of Ensembl version 88 the VEP script has been renamed from variant eﬀect predictor.pl to vep. The

ensemblVEP package code and documentation have been updated to reﬂect this change.
Downloads: http://uswest.ensembl.org/info/docs/tools/vep/index.html
Complete documentation for runtime options: http://uswest.ensembl.org/info/docs/tools/vep/script/vep_options.
html
To test that Ensembl VEP is properly installed, enter the name of the script from the command line:

vep

2 Results as R objects

> library(ensemblVEP)

The ensemblVEP function can return variant consequences from Ensembl VEP as Robjects (GRanges or VCF) or write
them to a ﬁle. The default behavior returns a GRanges. Runtime options are stored in a VEPParam object and allow a
great deal of control over the content and format of the results. See the man pages for more details.

> ?ensemblVEP
> ?VEPParam

The default runtime options can be inspected by creating a VEPParam.

> param <- VEPParam(version=88)
> param

class: VEPParam88
identifier(0):
colocatedVariants(0):
dataformat(0):
basic(0):
input(1): species

1

cache(3): dir, dir_cache, dir_plugins
output(1): terms
filterqc(0):
database(2): host, database
advanced(1): buffer_size
version: 88
scriptPath:

> basic(param)

$verbose
[1] FALSE

$quiet
[1] FALSE

$no_progress
[1] FALSE

$config
character(0)

$everything
[1] FALSE

$fork
numeric(0)

Using a vcf ﬁle from VariantAnnotation as input, we query Ensembl VEP with the default runtime parameters.

> fl <- system.file("extdata", "gl_chr1.vcf", package="VariantAnnotation")
> gr <- ensemblVEP(fl)

Consequence data are parsed into the metadata columns of the GRanges. To control the type and amount of data

returned see the options in output(VEPParam()).

> head(gr, 3)
GRanges object with 3 ranges and 23 metadata columns:

rs6054257
20:17330_T/A
rs6040355

seqnames
<Rle>

14370]
20 [ 14370,
17330]
20 [ 17330,
20 [1110696, 1110696]

ranges strand |

Allele
<IRanges> <Rle> | <factor>
A
A
G

* |
* |
* |
SYMBOL
<factor> <factor> <factor>
<NA>
<NA>

IMPACT

Consequence

Gene
<factor>
<NA>
<NA>
PSMF1 ENSG00000125818

rs6054257
20:17330_T/A

intergenic_variant MODIFIER
intergenic_variant MODIFIER
rs6040355 upstream_gene_variant MODIFIER

Feature_type
<factor>
<NA>
<NA>

Feature
<factor>
<NA>
<NA>
<NA>
<NA>
Transcript ENST00000479715 processed_transcript
INTRON

EXON
<factor> <factor>
<NA>
<NA>
<NA>

BIOTYPE

HGVSc

<factor> <factor> <factor>
<NA>
<NA>
<NA>

<NA>
<NA>
<NA>

<NA>
<NA>
<NA>

HGVSp cDNA_position CDS_position
<factor>
<NA>
<NA>
<NA>

<factor>
<NA>
<NA>
<NA>

rs6054257
20:17330_T/A
rs6040355

rs6054257
20:17330_T/A
rs6040355

Protein_position Amino_acids

<factor>

<factor> <factor>

Codons Existing_variation
<factor>

2

rs6054257
20:17330_T/A
rs6040355

rs6054257
20:17330_T/A
rs6040355

<NA>
<NA>
<NA>
STRAND

<NA>
<NA>
<NA>

<NA>
<NA>
<NA>

<NA>
<NA>
<NA>

FLAGS SYMBOL_SOURCE

DISTANCE
<factor> <factor> <factor>
<NA>
<NA>
<NA>

<NA>
<NA>
1

<NA>
<NA>
2610

HGNC_ID
<factor> <factor>
<NA>
<NA>
<NA>
<NA>
HGNC HGNC:9571

-------
seqinfo: 1 sequence from genome

Next we use a vcf of structural variants as input

> fl <- system.file("extdata", "structural.vcf", package="VariantAnnotation")

and request that a VCF object be returned by setting the vcf option in the dataformat slot to TRUE.

> param <- VEPParam(dataformat=c(vcf=TRUE), version=88)

An call to ensemblVEP results in an error.

> vcf <- ensemblVEP(fl, param)
2012-12-03 16:40:55 - Starting...
ERROR: Could not detect input file format

In most situations Ensembl VEP can auto-detect the input format. In this case, however, it cannot so we explicitly

set the format option to ’vcf’.

> input(param)$format <- "vcf"

Try again.

> vep <- ensemblVEP(fl, param)

Success! When a VCF is returned, consequence data are included as an unparsed INFO column labeled CSQ.

> info(vep)$CSQ

CharacterList of length 0

The parseCSQToGRanges function parses these data into a GRanges. When the rownames of the original VCF are

provided as VCFRowID a metadata column of the same name is included in the output.

> vcf <- readVcf(fl, "hg19")
> csq <- parseCSQToGRanges(vep, VCFRowID=rownames(vcf))
> head(csq, 3)

GRanges object with 0 ranges and 23 metadata columns:

seqnames

SYMBOL
<Rle> <IRanges> <Rle> | <character> <character> <character> <character>

Allele Consequence

ranges strand |

IMPACT

INTRON
<character> <character> <character> <character> <character> <character>

Gene Feature_type

BIOTYPE

Feature

EXON

HGVSc

<character> <character>
Amino_acids
<character> <character>

HGVSp cDNA_position CDS_position Protein_position
<character>

<character> <character>

Codons Existing_variation

STRAND
<character> <character> <character>

DISTANCE

FLAGS SYMBOL_SOURCE

HGNC_ID
<character> <character>

<character>

-------
seqinfo: no sequences

The VCFRowID columns maps the expanded CSQ data back to the rows in the VCF object. This index can be used

to subset the original VCF.

3

> vcf[csq$"VCFRowID"]

class: CollapsedVCF
dim: 0 1
rowRanges(vcf):

GRanges with 5 metadata columns: paramRangeID, REF, ALT, QUAL, FILTER

info(vcf):

DataFrame with 10 columns: BKPTID, CIEND, CIPOS, END, HOMLEN, HOMSEQ, IMPR...

info(header(vcf)):

Description

Number Type
.
BKPTID
2
CIEND
2
CIPOS
1
END
.
HOMLEN
.
HOMSEQ
IMPRECISE 0
4
MEINFO
.
SVLEN
1
SVTYPE

String ID of the assembled alternate allele in the asse...
Integer Confidence interval around END for imprecise var...
Integer Confidence interval around POS for imprecise var...
Integer End position of the variant described in this re...
Integer Length of base pair identical micro-homology at ...
String Sequence of base pair identical micro-homology a...
Flag
String Mobile element info of the form NAME,START,END,P...
Integer Difference in length between REF and ALT alleles
String Type of structural variant

Imprecise structural variation

geno(vcf):

SimpleList of length 4: GT, GQ, CN, CNQ

geno(header(vcf)):
Number Type

Description

GT 1
GQ 1
CN 1
CNQ 1

String Genotype
Float
Integer Copy number genotype for imprecise events
Float

Genotype quality

Copy number genotype quality for imprecise events

3 Write results to a ﬁle

In the previous section we saw Ensembl VEP results returned as R objects in the workspace. Alternatively, these results
can be written directly to a ﬁle. The ﬂag that controls how the data are returned is the output ﬁle ﬂag in the input
options.

When output ﬁle is an empty character (default), the results are returned as either a GRanges or VCF object.

> input(param)$output_file

character(0)

To write results directly to a ﬁle, specify a ﬁle name for the output ﬁle ﬂag.

> input(param)$output_file <- "/mypath/myfile"

The ﬁle can be written as a vcf or gvf by setting the options in the dataformat slot to TRUE. If neither of vcf or gvf

are TRUE the ﬁle is written out as tab delimited.

> ## Write a vcf file to myfile.vcf:
> myparam <- VEPParam(dataformat=c(vcf=TRUE),
+
> ## Write a gvf file to myfile.gvf:
> myparam <- VEPParam(dataformat=c(gvf=TRUE),
+
> ## Write a tab delimited file to myfile.txt:
> myparam <- VEPParam(input=c(output_file="/path/myfile.txt"), version=88)

input=c(output_file="/path/myfile.gvf"), version=88)

input=c(output_file="/path/myfile.vcf"), version=88)

4 Conﬁguring runtime options

The Ensembl VEP web page has complete descriptions of all runtime options. http://uswest.ensembl.org/info/
docs/tools/vep/script/vep_options.html Below are examples of how to conﬁgure the runtime options in the VEP-
Param for speciﬁc situations. Investigate the diﬀerences in results using a sample ﬁle from VariantAnnotation.

4

> fl <- system.file("extdata", "ex2.vcf", package="VariantAnnotation")

(cid:136) Add regulatory region consequences:

> param <- VEPParam(output=c(regulatory=TRUE), version=88)
> gr <- ensemblVEP(fl, param)

(cid:136) Specify input ﬁle format as VCF, add HGNC gene identiﬁers, output SO consequence terms:

> param <- VEPParam(input=c(format="vcf"),
+
+
> gr <- ensemblVEP(fl, param)

output=c(terms="so"),
identifiers=c(symbol=TRUE), version=88)

(cid:136) Check for co-located variants, output only coding sequence consequences, output HGVS names:

> param <- VEPParam(filterqc=c(coding_only=TRUE),
+
+
> gr <- ensemblVEP(fl, param)

colocatedVariants=c(check_existing=TRUE),
identifiers=c(symbol=TRUE), version=88)

(cid:136) Add SIFT score and prediction, PolyPhen prediction only, output results as VCF:

fl <- system.file("extdata", "chr22.vcf.gz", package="VariantAnnotation")
param <- VEPParam(output=c(sift="b", polyphen="p"),

dataformat=c(vcf=TRUE), version=88)

vcf <- ensemblVEP(fl, param)
csq <- parseCSQToGRanges(vcf)

> head(levels(mcols(csq)$SIFT))
[1] "deleterious(0.01)" "deleterious(0.02)" "deleterious(0.03)"
[4] "deleterious(0.04)" "deleterious(0.05)" "deleterious(0)"

> levels(mcols(csq)$PolyPhen)
[1] "benign"
[4] "unknown"

"possibly_damaging" "probably_damaging"

5 sessionInfo()

> sessionInfo()

R version 3.4.3 (2017-11-30)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.4 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.6-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.6-bioc/R/lib/libRlapack.so

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
[1] stats4
[8] methods

parallel stats
base

graphics grDevices utils

datasets

5

other attached packages:
[1] ensemblVEP_1.20.1
[3] Rsamtools_1.30.0
[5] XVector_0.18.0
[7] DelayedArray_0.4.1
[9] Biobase_2.38.0

[11] GenomeInfoDb_1.14.0
[13] S4Vectors_0.16.0

VariantAnnotation_1.24.5
Biostrings_2.46.0
SummarizedExperiment_1.8.1
matrixStats_0.53.1
GenomicRanges_1.30.3
IRanges_2.12.0
BiocGenerics_0.24.0

loaded via a namespace (and not attached):

[1] Rcpp_0.12.16
[4] prettyunits_1.0.2
[7] tools_3.4.3

compiler_3.4.3
GenomicFeatures_1.30.3
zlibbioc_1.24.0
digest_0.6.15
RSQLite_2.0
lattice_0.20-35
DBI_0.8
httr_1.3.1
grid_3.4.3
XML_3.98-1.10
magrittr_1.5

[10] biomaRt_2.34.2
[13] BSgenome_1.46.0
[16] tibble_1.4.2
[19] Matrix_1.2-12
[22] rtracklayer_1.38.3
[25] bit64_0.9-7
[28] AnnotationDbi_1.40.0
[31] BiocParallel_1.12.0
[34] GenomicAlignments_1.14.1 assertthat_0.2.0
[37] RCurl_1.95-4.10

pillar_1.2.1
bitops_1.0-6
progress_1.1.2
bit_1.1-12
memoise_1.1.0
rlang_0.2.0
GenomeInfoDbData_1.0.0
stringr_1.3.0
R6_2.2.2
RMySQL_0.10.14
blob_1.1.0
stringi_1.1.7

6

