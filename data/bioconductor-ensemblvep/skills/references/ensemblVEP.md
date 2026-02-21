Overview of ensemblVEP

Lori Shepherd and Valerie Obenchain

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

5

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
them to a ﬁle. The default behavior returns a GRanges. Runtime options are stored in a VEPFlags object and allow a
great deal of control over the content and format of the results. See the man pages for more details.

> ?ensemblVEP
> ?VEPFlags

The default runtime options can be inspected by creating a VEPFlags.

> param <- VEPFlags()
> param

class: VEPFlags
flags(2): host, database
version: 90
scriptPath:

> flags(param)

1

$host
[1] "useastdb.ensembl.org"

$database
[1] TRUE

$vcf
[1] FALSE

Using a vcf ﬁle from VariantAnnotation as input, we query Ensembl VEP with the default runtime parameters.
Consequence data are parsed into the metadata columns of the GRanges. To control the type and amount of data
returned see the output options at http://uswest.ensembl.org/info/docs/tools/vep/script/vep_options.html.

> fl <- system.file("extdata", "gl_chr1.vcf", package="VariantAnnotation")
> gr <- ensemblVEP(fl)
> head(gr, 3)

GRanges object with 3 ranges and 23 metadata columns:

rs58108140
rs58108140
rs58108140

seqnames
<Rle>

ranges strand |

Allele
<IRanges> <Rle> | <character>
A
1 [10583, 10583]
A
1 [10583, 10583]
A
1 [10583, 10583]
Consequence
SYMBOL
<character> <character> <character>

* |
* |
* |
IMPACT

upstream_gene_variant
rs58108140
rs58108140
upstream_gene_variant
rs58108140 downstream_gene_variant
Feature_type
<character>

Feature
<character>

MODIFIER
MODIFIER
MODIFIER

Gene
<character>
DDX11L1 ENSG00000223972
DDX11L1 ENSG00000223972
WASH7P ENSG00000227232
BIOTYPE
<character>
Transcript ENST00000450305 transcribed_unprocessed_pseudogene
processed_transcript
Transcript ENST00000456328
unprocessed_pseudogene
Transcript ENST00000488147
HGVSp cDNA_position
<character>
<NA>
<NA>
<NA>

<character> <character> <character> <character>
<NA>
<NA>
<NA>

<NA>
<NA>
<NA>
CDS_position Protein_position Amino_acids

<NA>
<NA>
<NA>

<NA>
<NA>
<NA>

INTRON

HGVSc

EXON

<character>
<NA>
<NA>
<NA>

<NA>
<NA>
<NA>

Codons
<character> <character> <character>
<NA>
<NA>
<NA>
FLAGS
<character> <character> <character> <character>
<NA>
<NA>
<NA>

<NA>
<NA>
<NA>
STRAND

<NA>
<NA>
<NA>

1427
1286
3821

DISTANCE

1
1
-1

Existing_variation

rs58108140
rs58108140
rs58108140

rs58108140
rs58108140
rs58108140

rs58108140
rs58108140
rs58108140

rs58108140
rs58108140
rs58108140

SYMBOL_SOURCE

HGNC_ID
<character> <character>
HGNC HGNC:37102
HGNC HGNC:37102
HGNC HGNC:38034

rs58108140
rs58108140
rs58108140
-------
seqinfo: 1 sequence from genome; no seqlengths

Next we request that a VCF object be returned by setting the vcf option in the ﬂags slot to TRUE.

> param <- VEPFlags(flags=list(vcf=TRUE))
> vep <- ensemblVEP(fl, param)

2

Success! When a VCF is returned, consequence data are included as an unparsed INFO column labeled CSQ.

> info(vep)$CSQ

CharacterList of length 3
[[1]] A|upstream_gene_variant|MODIFIER|DDX11L1|ENSG00000223972|Transcript|ENS...
[[2]] T|non_coding_transcript_exon_variant|MODIFIER|DDX11L1|ENSG00000223972|T...
[[3]] T|downstream_gene_variant|MODIFIER|FAM138A|ENSG00000237613|Transcript|E...

The parseCSQToGRanges function parses these data into a GRanges. When the rownames of the original VCF are

provided as VCFRowID a metadata column of the same name is included in the output.

> vcf <- readVcf(fl, "hg19")
> csq <- parseCSQToGRanges(vep, VCFRowID=rownames(vcf))
> head(csq, 3)

GRanges object with 3 ranges and 24 metadata columns:

upstream_gene_variant
rs58108140
rs58108140
upstream_gene_variant
rs58108140 downstream_gene_variant
Feature_type
<character>

seqnames
<Rle>

ranges strand | VCFRowID

Allele
<IRanges> <Rle> | <integer> <character>
A
A
A

1
1 [10583, 10583]
1
1 [10583, 10583]
1
1 [10583, 10583]
Consequence
SYMBOL
<character> <character> <character>

* |
* |
* |
IMPACT

Feature
<character>

MODIFIER
MODIFIER
MODIFIER

Gene
<character>
DDX11L1 ENSG00000223972
DDX11L1 ENSG00000223972
WASH7P ENSG00000227232
BIOTYPE
<character>
Transcript ENST00000450305 transcribed_unprocessed_pseudogene
processed_transcript
Transcript ENST00000456328
unprocessed_pseudogene
Transcript ENST00000488147
HGVSp cDNA_position
<character>
<NA>
<NA>
<NA>

<character> <character> <character> <character>
<NA>
<NA>
<NA>

<NA>
<NA>
<NA>
CDS_position Protein_position Amino_acids

<NA>
<NA>
<NA>

<NA>
<NA>
<NA>

INTRON

HGVSc

EXON

<character>
<NA>
<NA>
<NA>

<NA>
<NA>
<NA>

Codons
<character> <character> <character>
<NA>
<NA>
<NA>
FLAGS
<character> <character> <character> <character>
<NA>
<NA>
<NA>

<NA>
<NA>
<NA>
STRAND

<NA>
<NA>
<NA>

1427
1286
3821

DISTANCE

1
1
-1

Existing_variation

rs58108140
rs58108140
rs58108140

rs58108140
rs58108140
rs58108140

rs58108140
rs58108140
rs58108140

rs58108140
rs58108140
rs58108140

rs58108140
rs58108140
rs58108140

SYMBOL_SOURCE

HGNC_ID
<character> <character>
HGNC HGNC:37102
HGNC HGNC:37102
HGNC HGNC:38034

rs58108140
rs58108140
rs58108140
-------
seqinfo: 1 sequence from genome; no seqlengths

The VCFRowID columns maps the expanded CSQ data back to the rows in the VCF object. This index can be used

to subset the original VCF.

> vcf[csq$"VCFRowID"]

3

class: CollapsedVCF
dim: 13 85
rowRanges(vcf):

GRanges with 5 metadata columns: paramRangeID, REF, ALT, QUAL, FILTER

info(vcf):

DataFrame with 22 columns: LDAF, AVGPOST, RSQ, ERATE, THETA, CIEND, CIPOS,...

info(header(vcf)):

Number Type
1
LDAF
1
AVGPOST
1
RSQ
1
ERATE
1
THETA
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
1
SVLEN
1
SVTYPE
.
AC
1
AN
1
AA
1
AF
1
AMR_AF
1
ASN_AF
1
AFR_AF
1
EUR_AF
VT
1
SNPSOURCE .

Description
MLE Allele Frequency Accounting for LD
Float
Average posterior probability from MaCH/Thunder
Float
Genotype imputation quality from MaCH/Thunder
Float
Per-marker Mutation rate from MaCH/Thunder
Float
Float
Per-marker Transition rate from MaCH/Thunder
Integer Confidence interval around END for imprecise var...
Integer Confidence interval around POS for imprecise var...
Integer End position of the variant described in this re...
Integer Length of base pair identical micro-homology at ...
String Sequence of base pair identical micro-homology a...
Integer Difference in length between REF and ALT alleles
String Type of structural variant
Integer Alternate Allele Count
Integer Total Allele Count
String Ancestral Allele, ftp://ftp.1000genomes.ebi.ac.u...
Float
Float
Float
Float
Float
String indicates what type of variant the line represents
String indicates if a snp was called when analysing the...

Global Allele Frequency based on AC/AN
Allele Frequency for samples from AMR based on A...
Allele Frequency for samples from ASN based on A...
Allele Frequency for samples from AFR based on A...
Allele Frequency for samples from EUR based on A...

geno(vcf):

SimpleList of length 3: GT, DS, GL

geno(header(vcf)):

Number Type

Description

GT 1
DS 1
GL .

String Genotype
Float Genotype dosage from MaCH/Thunder
Float Genotype Likelihoods

3 Write results to a ﬁle

In the previous section we saw Ensembl VEP results returned as R objects in the workspace. Alternatively, these results
can be written directly to a ﬁle. The ﬂag that controls how the data are returned is the output ﬁle ﬂag.
When output ﬁle is NULL (default), the results are returned as either a GRanges or VCF object.

> flags(param)$output_file

NULL

To write results directly to a ﬁle, specify a ﬁle name for the output ﬁle ﬂag.

> flags(param)$output_file <- "/mypath/myfile"

The ﬁle can be written as a vcf or gvf by setting the options of the slot to TRUE. If neither of vcf or gvf are TRUE

the ﬁle is written out as tab delimited.

> ## Write a vcf file to myfile.vcf:
> myparam <- VEPFlags(flags=list(vcf=TRUE,
+
> ## Write a gvf file to myfile.gvf:
> myparam <- VEPFlags(flags=list(gvf=TRUE,

output_file="/path/myfile.vcf"))

4

+
> ## Write a tab delimited file to myfile.txt:
> myparam <- VEPFlags(flags=list(output_file="/path/myfile.txt"))

output_file="/path/myfile.gvf"))

4 Conﬁguring runtime options

The Ensembl VEP web page has complete descriptions of all runtime options. http://uswest.ensembl.org/info/
docs/tools/vep/script/vep_options.html Below are examples of how to conﬁgure the runtime options in the VEPFlags
for speciﬁc situations. Investigate the diﬀerences in results using a sample ﬁle from VariantAnnotation.

> fl <- system.file("extdata", "ex2.vcf", package="VariantAnnotation")

(cid:136) Add regulatory region consequences:

> param <- VEPFlags(flags=list(regulatory=TRUE))
> gr <- ensemblVEP(fl, param)

(cid:136) Specify input ﬁle format as VCF, add HGNC gene identiﬁers, output SO consequence terms:

> param <- VEPFlags(flag=list(format="vcf",
+
+
> gr <- ensemblVEP(fl, param)

terms="SO",
symbol=TRUE))

(cid:136) Check for co-located variants, output only coding sequence consequences, output HGVS names:

> param <- VEPFlags(flags=list(coding_only=TRUE,
+
+
> gr <- ensemblVEP(fl, param)

check_existing=TRUE,
symbol=TRUE))

(cid:136) Add SIFT score and prediction, PolyPhen prediction only, output results as VCF:

fl <- system.file("extdata", "chr22.vcf.gz", package="VariantAnnotation")
param <- VEPFlags(flags=list(sift="b", polyphen="p",

vcf=TRUE))
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

5

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

other attached packages:
[1] ensemblVEP_1.20.1
[3] Rsamtools_1.30.0
[5] XVector_0.18.0
[7] DelayedArray_0.4.1
[9] Biobase_2.38.0

[11] GenomeInfoDb_1.14.0
[13] S4Vectors_0.16.0

graphics grDevices utils

datasets

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

