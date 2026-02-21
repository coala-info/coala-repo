vtpnet: variant-transcription factor-phenotype
networks

VJ Carey

October 30, 2025

1

Introduction

In a wide-ranging paper (PMID 22955828 Maurano et al. (2012)), Maurano and col-
leagues illustrate the concept of “common networks for common diseases” with a bipar-
tite graph. One class of nodes is a set of autoimmune disorders, the other class is a set
of transcription factors (TFs). In this graph, an edge exists between a disorder node and
a TF node if a SNP that is significantly associated with the risk of the disorder lies in
a genomic region possessing a strong match to the binding motif of the TF. This pack-
age defines tools to investigate the construction and statistical interpretation of such
bipartite graphs, which we will denote VTP (variant-transcription factor-phenotype)
networks.

2

Illustrative example of an unpruned VTP

The following code uses the graphNEL class to construct an approximation to the com-
plete bipartite graph underlying Figure 4A of the Maurano paper; Figure 1 illustrates
an arbitrary complete subgraph. The elements of diseaseTags are formatted to allow
multiline rendering of the strings in node displays.
It will be useful to distinguish a
display token type and an analysis token type to simplify programming.

> #
> # tags formatted for display
> #
> diseaseTags = c("Ankylosing\\\nspondylitis", "Asthma",
+
+
+
+
+

"Celiac\\\ndisease", "Crohn's\\\ndisease",
"Multiple\\\nsclerosis", "Primary\\\nbiliary\\\ncirrhosis",
"Psoriasis", "Rheumatoid\\\narthritis",
"Systemic\\\nlupus\\\nerythematosus",
"Systemic\\\nsclerosis", "Type 1\\\ndiabetes",

1

"Ulcerative\\\ncolitis"

+
+ )
> TFtags = c("ELF3", "MEF2A", "TCF3", "PAX4", "STAT3",
"ESR1", "POU2F1", "STAT1", "YY1", "SP1", "CDC5L",
+
"NR3C1", "EGR1", "PPARG", "HNF4A", "REST", "PPARA",
+
+
"AR", "NFKB1", "HNF1A", "TFAP2A")
> # define adjacency matrix
> adjm = matrix(1, nr=length(diseaseTags), nc=length(TFtags))
> dimnames(adjm) = list(diseaseTags, TFtags)
> library(graph)
> cvtp = ugraph(aM2bpG(adjm)) # complete (V)TP network; variants not involved yet

3 Data on GWAS variants: their associated pheno-

type, locations, and other characteristics

We will use the GWAS data provided at https://www.sciencemag.org/content/suppl/
2012/09/04/science.1222794.DC1/1222794-Maurano-tableS2.txt, which was man-
ually imported to a GRanges instance in hg19 origin-1 coordinates.

> library(vtpnet)
> data(maurGWAS)
> length(maurGWAS)

[1] 5654

> names(values(maurGWAS))

[1] "name"
[3] "disease_class"
[5] "independently_replicated" "In_DHS"
[7] "fetal_origin"
[9] "sample_size"

"X.LOG.P."

"disease_trait"
"internally_replicated"

4 Data on transcription factor binding sites

We have included the result of using FIMO Grant et al. (2011) to scan for motif matches
for TF PAX4 as modeled in the Bioconductor MotifDb collection. The –max-stored-scores
parameter was set to 10000000 so that p of up to 10−4 are retained.

> data(pax4)
> length(pax4)

2

flat("Ulcerative\\\ncolitis", cvtp))), cvtp)

> library(Rgraphviz)
> #flat = function(x, g) c(x, edges(g)[[x]])
> #sub = subGraph(unique(c(flat("Crohn's\\\ndisease", cvtp),
> #
> sub = subGraph(unique(c(diseaseTags[1:4], TFtags[1:6])), cvtp)
> plot(sub, attrs=list(node=list(shape="box", fixedsize=FALSE)))
> #plot(cvtp, attrs=list(graph=list(margin=c(.5,.5), size=c(4.1,4.1)),
> #

node=list(shape="box", fixedsize=FALSE, height=1)))

Figure 1: A complete bipartite graph for arbitrarily selected subsets of the autoimmune
disorders and TFs found in Figure 4A of Maurano et al.

3

AnkylosingspondylitisAsthmaCeliacdiseaseCrohn'sdiseaseELF3MEF2ATCF3PAX4STAT3ESR1[1] 1862156

> pax4[1:4]

GRanges object with 4 ranges and 8 metadata columns:

seqnames
<Rle>

ranges strand |

source
<IRanges> <Rle> | <factor>

type

score
<factor> <numeric>
999.917
999.962
999.999
999.955

fimo nucleotide_motif
fimo nucleotide_motif
fimo nucleotide_motif
fimo nucleotide_motif

+ |
+ |
- |
- |

[1]
[2]
[3]
[4]

chr1 10273-10302
chr1 10279-10308
chr1 11703-11732
chr1 11704-11733
phase
<integer>

Name

pvalue

[1]
[2]
[3]
[4]

8.35e-05
3.79e-05
8.04e-07
4.46e-05

qvalue
<character> <character> <character>
0.396
0.361
0.194
0.368

<NA> +Mmusculus-JASPAR_CO..
<NA> +Mmusculus-JASPAR_CO..
<NA> -Mmusculus-JASPAR_CO..
<NA> -Mmusculus-JASPAR_CO..
sequence
<character>
[1] TAACCCTAACCCTAACCCCA..
[2] TAACCCTAACCCCAACCCCA..
[3] AAAAAAATACACATGGCCAG..
[4] TAAAAAAATACACATGGCCA..
-------
seqinfo: 92 sequences from an unspecified genome; no seqlengths

We can also generate our own motif-match ranges. Here is an example of a paral-

lelized search against hg19 using matchPWM.

> library(foreach)
> library(doParallel)
> registerDoParallel(cores=12)
> library(BSgenome.Hsapiens.UCSC.hg19)
> library(MotifDb)
> sn = seqnames(Hsapiens)[1:24]
> pax4 = query(MotifDb, "pax4")[[1]]
> ans = foreach(i=1:24) %dopar% {
+
+
+
+ }
> pax4_75 =
+

cat(i)
subj = Hsapiens[[ sn[i] ]]
matchPWM( pax4, subj, "75%" )

do.call(c, lapply(1:length(ans), function(x)

4

{GRanges(sn[x], as(ans[[x]], "IRanges"))}))

+
> save(pax4_75, file="pax4_75.rda")

Results of such searches retaining matches at scores of 85% and 75% of the maximum

achievable score have been stored with this package.

5 Building a VTP network: one edge per phenotype

5.1 Raw matches

We can survey the entire GWAS catalog for intersection with putative PAX4 binding
sites. First the two Bioconductor internal binding site sets.

> data(pax4_85)
> vp_pax4_85 = maurGWAS[ overlapsAny(maurGWAS, pax4_85) ]
> length(vp_pax4_85)

[1] 0

> data(pax4_75)
> vp_pax4_75 = maurGWAS[ overlapsAny(maurGWAS, pax4_75) ]
> length(vp_pax4_75)

[1] 54

Then the FIMO-based set.

> vp_pax4_fimo = maurGWAS[ overlapsAny(maurGWAS, pax4) ]
> length(vp_pax4_fimo)

[1] 67

The lengths reported here are the numbers of phenotypes linked to PAX4 in a VTP

according to various motif matching schemes. For the two non-null results, we have

> u75 = unique(vp_pax4_75$disease_trait)
> ufimo = unique(vp_pax4_fimo$disease_trait)
> length(setdiff(u75, ufimo))

[1] 23

> length(setdiff(ufimo, u75))

[1] 28

Clearly the identification of TP links is sensitive to the approach used to locate
binding sites. However, as noted in the Maurano paper, the use of matching to the
reference genome without SNP injection is potentially problematic.

5

5.2 Filtering

It is useful to restrict the phenotypes of interest, and to map them to broader classes,
and to include TFBS matching scores for the purpose of filtering edges. Here we will
use the NHGRI GWAS catalog against FIMO-based (reference genome matching only)
PAX4 calls.

> data(cancerMap)
> requireNamespace("gwascat")
> load(system.file("legacy/gwrngs19.rda", package="gwascat"))
> cangw = filterGWASbyMap( gwrngs19, cancerMap )
> getOneHits( pax4, cangw, "fimo" )

GRanges object with 8 ranges and 41 metadata columns:

seqnames

First.Author

chr20
chrX
chr12
chr10

ranges strand | Date.Added.to.Catalog

3475
3480
6963
7155
7480
12585
13650
15145

<Rle> |
* |
* |
* |
* |
* |
* |
* |
* |

PUBMEDID
<character> <integer>
23535729
23535729
23144319
23108145
22976474
20932654
20543847
19684604

<Rle> <IRanges>
chr8 129194641
65583066
chr11
chr2
26526419
chr6 143943314
32588095
37854727
14653867
63752159

09/12/2013
09/12/2013
01/25/2013
01/15/2013
11/30/2012
11/15/2010
07/12/2010
09/04/2009
Journal
Date
<character>
<character> <character>
Nat Genet
04/01/2013
Nat Genet
04/01/2013
Carcinogenesis
11/08/2012
Cancer Res
10/29/2012
Hum Mol Genet
09/13/2012
10/05/2010 Int J Radiat Oncol B..
Nat Genet
06/13/2010
Nat Genet
08/16/2009
Disease.Trait
Study
<character>
<character>
Breast cancer
3475 http://www.ncbi.nlm... Large-scale genotypi..
Breast cancer
3480 http://www.ncbi.nlm... Large-scale genotypi..
6963 http://www.ncbi.nlm... Prognostic implicati.. Non-small cell lung ..
7155 http://www.ncbi.nlm... Genome-wide associat.. Lung Cancer (DNA rep..
Breast cancer
7480 http://www.ncbi.nlm... A meta-analysis of g..
12585 http://www.ncbi.nlm... Genome-wide associat.. Erectile dysfunction..
13650 http://www.ncbi.nlm... Variants near DMRT1,.. Testicular germ cell..

Michailidou K
3475
Michailidou K
3480
Lee Y
6963
Wang LE
7155
Siddiq A
7480
Kerns SL
12585
13650
Turnbull C
15145 Papaemmanuil E

Link
<character>

6

15145 http://www.ncbi.nlm... Loci on 7p12.2, 10q2.. Acute lymphoblastic ..

Initial.Sample.Size Replication.Sample.Size

<character>
3475 10,052 European ance..
3480 10,052 European ance..
6963 348 Korean ancestry ..
7155 914 European ancestr..
7480 3,666 European ances..
12585 27 African American ..
13650 979 European ancestr..
15145 907 European ancestr..

Region

Chr_id
<character> <character> <character>
8
11
2
6
20
23
12
10

45,290 European ance..
45,290 European ance..
NR
679 European ancestr..
562 European ancestr..
<NA>
664 European ancestr..
<NA>

8q24.21
11q13.1
2p23.3
6q24.2
20q11.22
Xp11.4
12p13.1
10q21.2

3475
3480
6963
7155
7480
12585
13650
15145

3475
3480
6963
7155
7480
12585
13650
15145

3475
3480
6963
7155
7480
12585
13650
15145

Chr_pos.hg38
<numeric>
128182395

Reported.Gene.s.
<character>

Mapped_gene
<character>
MIR1208, MYC MIR1208 - LINC01263
OVOL1-AS1 - SNX32
HADHB - GPR113
PHACTR2
RALY
CXorf27 - SYTL5
ATF7IP
ARID5B

65815595 DKFZp761E198, OVOL1,..
GPR113
26303551
PHACTR2
143622177
RALY, EIF2S2, ASIP
34000289
SYTL5
37995474
ATF7IP
14500933
ARID5B
61992400

<character>

Upstream_gene_id Downstream_gene_id Snp_gene_ids Upstream_gene_distance
<character>
32.21
24.73
13.09
<NA>
<NA>
4.16
<NA>
<NA>

<character>
101927774
254122
165082
<NA>
<NA>
94122
<NA>
<NA>

<character>
100302281
101927828
3032
<NA>
<NA>
25763
<NA>
<NA>

55729
84159

9749
22913

Downstream_gene_distance Strongest.SNP.Risk.Allele

<character>
222.87
18.24
4.62
<NA>
<NA>
11.11
<NA>
<NA>

Merged Snp_id_current

7

SNPs
<character> <character>
rs11780156
rs3903072
rs6753473
rs9390123
rs2284378
rs872690
rs2900333
rs7089424

rs11780156-T
rs3903072-G
rs6753473-G
rs9390123-A
rs2284378-T
rs872690-?
rs2900333-C
rs7089424-C
Context Intergenic

<character>
0
0
0
0
0
0
0
0
Risk.Allele.Frequency

11780156
3903072
6753473
9390123
2284378

<character> <character> <character>
1
Intergenic
1
Intergenic
1
Intergenic
0
intron
0
intron
1
872690 Intergenic
0
UTR-3
0
intron

2900333
7089424

<character> <numeric>
3e-11
9e-12
4e-06
7e-06
1e-08
9e-06
6e-10
7e-19

0.16
0.53
0.052
0.3957
0.31
0.03
0.62
0.34

p.Value Pvalue_mlog
<numeric>
10.52288
11.04576

<character>

p.Value..text. OR.or.beta
<numeric>
1.07
1.05
NA
NA
1.16
11.78
1.27
1.65

5.39794 (Additive model)
5.15490
8.00000
5.04576
9.22185
18.15490

X95..CI..text. Platform..SNPs.passing.QC.

<character>

[1.04-1.10]
[1.04-1.08]

NR
NR

[1.10-1.22]
[NR]
[1.12-1.44]
[1.54-1.76]

CNV
<character> <character>
N
N
N
N
N
N
N
N

Illumina & Affymetri..
Illumina & Affymetri..
Affymetrix [271,817]
Illumina [303,669]
Illumina [2,608,509]..
Affymetrix [512,497]
Illumina [298,782]
Illumina [291,473]

num.Risk.Allele.Frequency

score

dclass

tfstart

tfend
<numeric> <character> <numeric> <integer> <integer>
999.985 129194621 129194650
65583094
65583065
999.952
26526444
26526415
999.987
999.939 143943292 143943321
32588104
32588075
999.928
37854750
37854721
999.903
14653877
14653848
999.990
63752171
63752142
999.962

Breast
Breast
Lung
Lung
Breast
Prostate
Testicular
ALL (ped)

0.1600
0.5300
0.0520
0.3957
0.3100
0.0300
0.6200
0.3400

3475
3480
6963
7155
7480
12585
13650
15145

3475
3480
6963
7155
7480
12585
13650
15145

3475
3480
6963
7155
7480
12585
13650
15145

3475
3480
6963
7155
7480
12585
13650
15145

pvalue

qvalue
<numeric> <numeric>
0.318

3475 1.49e-05

8

3480 4.83e-05
6963 1.25e-05
7155 6.13e-05
7480 7.16e-05
9.72e-05
1.05e-05
3.79e-05

0.373
0.310
0.383
0.388
0.403
0.301
0.361

12585
13650
15145
-------
seqinfo: 23 sequences from hg19 genome

6 Appendix: generating the ALT-injected genome im-

age

sub("%%TAG%%", x, "alt%%TAG%%_hg19.fa")) {

slpack="SNPlocs.Hsapiens.dbSNP.20120608",
hgpack ="BSgenome.Hsapiens.UCSC.hg19",
faElFun = function(x) sub("%%TAG%%", x, "alt%%TAG%%chr"),
faTargFun = function(x)

require(slpack, character.only=TRUE)
require(hgpack, character.only=TRUE)
require("ShortRead", character.only=TRUE)
chk = grep("ch|chr", chtag)
if (length(chk)>0) {

> altize = function(chtag = "21",
+ #
+ # from sketch by Herve Pages, May 2013
+ #
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+
+

sub(ref, "", all, fixed=TRUE),

NULL, fixed=TRUE)[[1L]]

snpgettag = paste0("ch", chtag)
ggettag = paste0("chr", chtag)
cursnps = getSNPlocs(snpgettag, as.GRanges=TRUE)
curgenome = unmasked(Hsapiens[[ggettag]])
ref_allele =

warning("clearing prefix ch or chr from chtag")
chtag = gsub("ch|chr", "", chtag)
}

all_alleles = IUPAC_CODE_MAP[cursnps$alleles_as_ambig]
alt_alleles = mapply( function(ref,all)

strsplit(as.character(curgenome[start(cursnps)]),

ref_allele, all_alleles, USE.NAMES=FALSE)

9

cursnps$ref_allele = ref_allele
cursnps$alt_alleles = alt_alleles
cursnps$one_alt = substr(cursnps$alt_alleles, 1, 1)
altg = list(replaceLetterAt(curgenome, start(cursnps),

cursnps$one_alt))

names(altg) = faElFun(chtag)
writeFasta(DNAStringSet(altg), file=faTargFun(chtag))

+
+
+
+
+
+
+
+ }

7 Session information

> sessionInfo()

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
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

time zone: America/New_York
tzcode source: system (glibc)

attached base packages:

[1] parallel
[8] datasets

stats4
methods

grid
base

stats

graphics

grDevices utils

other attached packages:

[1] vtpnet_0.50.0
[4] foreach_1.5.2
[7] Seqinfo_1.0.0

[10] Rgraphviz_2.54.0
[13] generics_0.1.4

doParallel_1.0.17
gwascat_2.42.0
IRanges_2.44.0
graph_1.88.0

iterators_1.0.14
GenomicRanges_1.62.0
S4Vectors_0.48.0
BiocGenerics_0.56.0

10

loaded via a namespace (and not attached):

[1] KEGGREST_1.50.0
[3] rjson_0.2.23
[5] Biobase_2.70.0
[7] vctrs_0.6.5
[9] bitops_1.0-9
[11] tibble_3.3.0
[13] RSQLite_2.4.3
[15] pkgconfig_2.0.3
[17] data.table_1.17.8
[19] dbplyr_2.5.1
[21] lifecycle_1.0.4
[23] Rsamtools_2.26.0
[25] codetools_0.2-20
[27] snpStats_1.60.0
[29] RCurl_1.98-1.17
[31] crayon_1.5.3
[33] DelayedArray_0.36.0
[35] abind_1.4-8
[37] dplyr_1.1.4
[39] VariantAnnotation_1.56.0
[41] fastmap_1.2.0
[43] SparseArray_1.10.0
[45] S4Arrays_1.10.0
[47] survival_3.8-3
[49] UCSC.utils_1.6.0
[51] rappdirs_0.3.3
[53] XVector_0.50.0
[55] matrixStats_1.5.0
[57] png_0.1-8
[59] BiocIO_1.20.0
[61] rtracklayer_1.70.0
[63] glue_1.8.0
[65] jsonlite_2.0.0
[67] GenomicAlignments_1.46.0

SummarizedExperiment_1.40.0
httr2_1.2.1
lattice_0.22-7
tools_4.5.1
curl_7.0.0
AnnotationDbi_1.72.0
blob_1.2.4
Matrix_1.7-4
BSgenome_1.78.0
cigarillo_1.0.0
compiler_4.5.1
Biostrings_2.78.0
GenomeInfoDb_1.46.0
yaml_2.3.10
pillar_1.11.1
BiocParallel_1.44.0
cachem_1.1.0
tidyselect_1.2.1
restfulr_0.0.16
splines_4.5.1
cli_3.6.5
magrittr_2.0.4
GenomicFeatures_1.62.0
XML_3.99-0.19
filelock_1.0.3
bit64_4.6.0-1
httr_1.4.7
bit_4.6.0
memoise_2.0.1
BiocFileCache_3.0.0
rlang_1.1.6
DBI_1.2.3
R6_2.6.1
MatrixGenerics_1.22.0

11

8 Bibliography

References

Charles E Grant, Timothy L Bailey, and William Stafford Noble. Fimo: scanning for
occurrences of a given motif. Bioinformatics (Oxford, England), 27(7):1017–8, Apr
2011. doi: 10.1093/bioinformatics/btr064.

Matthew T Maurano, Richard Humbert, Eric Rynes, Robert E Thurman, Eric Hau-
gen, Hao Wang, Alex P Reynolds, Richard Sandstrom, Hongzhu Qu, Jennifer Brody,
Anthony Shafer, Fidencio Neri, Kristen Lee, Tanya Kutyavin, Sandra Stehling-Sun,
Audra K Johnson, Theresa K Canfield, Erika Giste, Morgan Diegel, Daniel Bates,
R Scott Hansen, Shane Neph, Peter J Sabo, Shelly Heimfeld, Antony Raubitschek,
Steven Ziegler, Chris Cotsapas, Nona Sotoodehnia, Ian Glass, Shamil R Sunyaev, Ra-
jinder Kaul, and John A Stamatoyannopoulos. Systematic localization of common
disease-associated variation in regulatory dna. Science, 337(6099):1190–5, Sep 2012.
doi: 10.1126/science.1222794.

12

