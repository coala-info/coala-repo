Using GGtools for eQTL discovery and interpretation

VJ Carey stvjc at channing.harvard.edu

October 30, 2017

Contents

1 Overview and installation

2 Data structures

2.1 Reference data supplied with Bioconductor . . . . . . . . . . . . . . . . .
2.2 Working with your own data . . . . . . . . . . . . . . . . . . . . . . . . .
2.3 Filters and permutation support . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . .
2.3.1 Bracket operations
2.3.2 Large scale ﬁlters . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . .
2.3.3 Permutation of expression against genotype
2.4 Post-analysis data structures . . . . . . . . . . . . . . . . . . . . . . . . .

3 Focused analyses

4 Comprehensive surveys

4.1 A set of genes vs. all SNP on a chromosome . . . . . . . . . . . . . . . .
4.2 Tabulating best associated cis-rSNP with permutation-based FDR: small
example . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

5 Comprehensive reporting on FDR for all SNP cis to a set of genes

5.1 Conﬁguring a search . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.2 Executing a search . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
5.2.1 Computing and serializing scored GRanges . . . . . . . . . . . . .
5.2.2 Amalgamation of chromosome-speciﬁc results, recomputation of
FDR . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

6 Full search on an SGE-based cluster

6.1 Removal of empirically identiﬁed expression heterogeneity . . . . . . . . .

7 Exercises

2

2
2
5
5
5
5
6
6

7

10
10

11

13
13
14
14

15

17
18

21

1

8 Appendix: building your own structures

9 Session information

1 Overview and installation

22

24

This document addresses data structure and analytic workﬂow for investigations of ge-
netic sources of expression variation. Key background references are Williams et al.
(2007) for general biologic overview, Cheung et al. (2005) and Stranger et al. (2007) for
key applications, and Stegle et al. (2010), Petretto et al. (2010), and Leek et al. (2010)
for various methodological issues. Majewski and Pastinen (2011) reviews potentials of
eQTL investigations with expression measures based on RNA sequencing.

This document is constructed using R version 3.4.2. See the session information at
the end of the document for full details. Using a comparable version of R, you can obtain
the software needed for the production of this document using

source("http://www.bioconductor.org/biocLite.R")
biocLite("GGtools", dependencies=TRUE)

2 Data structures

2.1 Reference data supplied with Bioconductor

A collection of 30 trios of central European ancestry was genotyped for 4 million SNP
loci in HapMap phase II. Immortalized B-cell lines were assayed for gene expression
using Illumina’s HumanWG6v1 bead array. Digital data on expression and genotype for
the 90 CEU individuals is distributed in Bioconductor package GGdata; the expression
data were retrieved from the GENEVAR website of Wellcome Trust, e.g.,

ftp://ftp.sanger.ac.uk/pub/genevar/CEU_parents_norm_march2007.zip

and the genotype data were obtained directly from hapmap.org at build 36:

ftp://ftp.ncbi.nlm.nih.gov/hapmap/genotypes/2008-03/forward/non-redundant/

The data in GGdata are likely derived from r23, while r23a is now distributed. Some
eﬀort at updating genotypes may be supplied in the future.

Acquire the genome-wide expression data and the genotype data for chromosome 20

as follows:

> suppressPackageStartupMessages(library(GGtools))
> library(parallel)

> g20 = getSS("GGdata", "20")

2

> g20

SnpMatrix-based genotype set:
number of samples: 90
number of chromosomes present: 1
annotation: illuminaHumanv1.db
Expression data dims: 47293 x 90
Total number of SNP: 119921
Phenodata: An object of class

’

AnnotatedDataFrame

’

sampleNames: NA06985 NA06991 ... NA12892 (90 total)
varLabels: famid persid ... male (7 total)
varMetadata: labelDescription

> class(g20)

[1] "smlSet"
attr(,"package")
[1] "GGBase"

The smlSet class was designed in 2006 as an experiment in unifying high-throughput
expression and genotype data. A key resource was the snpMatrix (now snpStats) package
of David Clayton, which deﬁned an 8-bit representation of genotype calls (including
uncertain calls obtained by statistical imputation), import and coercion infrastructure
allowing use of the 8-bit representation with popular genetic data formats (pedﬁles,
mach and beagle outputs, etc.), and statistical testing infrastructure employing this
representation.

The expression and sample-level data are handled just as with familiar ExpressionSet

instances:

> exprs(g20)[1:5,1:5]

NA06991

NA06985

NA07000
GI_10047089-S 5.983962 5.939529 5.912270 5.891347 5.906675
GI_10047091-S 6.544493 6.286516 6.244446 6.277397 6.330893
GI_10047093-S 9.905235 10.353804 10.380972 9.889223 10.155686
GI_10047099-S 7.993935 7.593970 8.261215 6.598430 6.728085
GI_10047103-S 11.882265 12.204753 12.249708 11.798415 12.015252

NA06994

NA06993

> pData(g20)[1:4,]

NA06985 1341
NA06991 1341
NA06993 1341
NA06994 1340

famid persid mothid fathid sampid isFounder male
TRUE FALSE
FALSE FALSE
TRUE TRUE
TRUE TRUE

0 NA06985
13 NA06991
0 NA06993
0 NA06994

14
2
13
9

0
14
0
0

3

The genotype data are held in a list with elements intended to represent chromosomes,

and the list is stored in an environment to reduce copying eﬀorts.

> smList(g20)

‘

‘

20

$
A SnpMatrix with 90 rows and 119921 columns
Row names: NA06985 ... NA12892
Col names: rs4814683 ... rs6090120

> as(smList(g20)[[1]][1:5,1:5], "matrix")

NA06985
NA06991
NA06993
NA06994
NA07000

rs4814683 rs6076506 rs6139074 rs1418258 rs7274499
03
03
03
03
03

03
02
01
01
03

03
02
01
01
03

03
03
03
03
03

03
02
01
01
03

The leading zeroes in the display above indicate that raw bytes are used to represent

the genotypes per sample (rows) per SNP (columns). Coercions:

> as(smList(g20)[[1]][1:5,1:5], "numeric")

NA06985
NA06991
NA06993
NA06994
NA07000

rs4814683 rs6076506 rs6139074 rs1418258 rs7274499
2
2
2
2
2

2
1
0
0
2

2
1
0
0
2

2
2
2
2
2

2
1
0
0
2

> as(smList(g20)[[1]][1:5,1:5], "character")

rs4814683 rs6076506 rs6139074 rs1418258 rs7274499

NA06985 "B/B"
NA06991 "A/B"
NA06993 "A/A"
NA06994 "A/A"
NA07000 "B/B"

"B/B"
"B/B"
"B/B"
"B/B"
"B/B"

"B/B"
"A/B"
"A/A"
"A/A"
"B/B"

"B/B"
"A/B"
"A/A"
"A/A"
"B/B"

"B/B"
"B/B"
"B/B"
"B/B"
"B/B"

Any number of chromosomes can be held in the genotype list component, but the
design allows working with only one chromosome at a time and examples emphasize this
approach. Amalgamation of results across chromosomes is generally straightforward.

4

2.2 Working with your own data

The make_smlSet function can be used to bind a list of suitably named SnpMatrix
instances with an ExpressionSet instance to create a single smlSet instance covering
multiple chromosomes.

The externalize function can be applied to such an smlSet instance to create a new
package which can be installed for use with getSS. This is the preferred way of managing
work with large genotyping panels (such as the 10 million locus panel achievable with
“thousand genomes imputation”).

Brieﬂy, externalize arranges a DESCRIPTION ﬁle and system of folders that
can be installed as an R package. The expression data are stored as object ex in
data/eset.rda, and the SnpMatrix instances are stored separately as .rda ﬁles in inst/parts.
The getSS function will create smlSet instances on the ﬂy from the externalize-generated
package.

2.3 Filters and permutation support

Here “ﬁlter” is used to refer to any function that processes an smlSet instance and returns
an smlSet instance after altering the contents, which may involve eliminating probes
or SNPs, performing numerical transformations to expression or genotype measures,
transforming sample data or eliminating samples.

2.3.1 Bracket operations

Coordinated manipulations of genotype, expression, and phenotype information on sam-
ples can be accomplished with the second subscript to the bracket operator. Thus
g20[,1:5] is the restriction of g20 to the ﬁrst ﬁve samples. Sample names may also be
used for such manipulations.

Reduction of the expression component can be accomplished with the ﬁrst subscript
to the bracket operator. Thus g20[1:5,] is the restriction of g20 to ﬁve expression
If it is desired to use feature names for such
probes; all other data are unaltered.
manipulations, the character vector of feature names must be cast to class probeId with
the probeId() method. At present no such operations can be used to alter the genotype
data contents.

2.3.2 Large scale ﬁlters

It is known that non-speciﬁc ﬁltering (removal of probes with low variation across sam-
ples, without regard to sample phenotype or class information) can increase sensitivity
and speciﬁcity of certain diﬀerential expression test procedures (Bourgon et al., 2010).
The nsFilter function of the geneﬁlter package has been adapted to work with smlSet
instances.

5

SNPs can be ﬁltered out of the smlSet instance on the basis of observed minor allele

or genotype frequencies using MAFfilter and GTFfilter respectively.

Various approaches to reduction of “expression heterogeneity” can be examined.
clipPCs(x, vec) will form the singular value decomposition of the expression matrix
and remove principal components enumerated in vec by reassembling the expression ma-
trix after setting eigenvalues in vec to zero. It is also possible to employ any computed
quantities such as principal components or surrogate variables identiﬁed in SVA (Leek
and Storey, 2007) as covariates in the formula element of analysis functions in GGtools,
but note that simple permutations do not lead to valid permutation tests of SNP eﬀects
in the presence of covariates (see (B˚uˇzkov´a et al., 2011) who focus on interaction, but
describe the problem for main eﬀects models, with references, early in the paper.)

The introduction of novel approaches to expression transformation can be accom-
plished using code similar to the following, illustrating of the use of PEER (Stegle et al.,
2010):

> library(peer)
> model = PEER()
> PEER_setPhenoMean(model, t(exprs(g20)))
> PEER_setNk(model, 10)
> PEER_setCovariates(model, matrix(1*g20$male,nc=1))
> PEER_update(model)
> resid=t(PEER_getResiduals(model))
> rownames(resid) = featureNames(g20)
> colnames(resid) = sampleNames(g20)
> g20peer10 = g20
> g20peer10@assayData = assayDataNew("lockedEnvironment", exprs=resid)

At this point, g20peer10 holds expression data with 10 latent factors removed after
adjustment for gender.

2.3.3 Permutation of expression against genotype

Because the snpStats testing procedures defensively match predictor to response vari-
able orderings using sample labels, special steps must be taken to ensure that tests use
properly permuted responses. The permEx function takes care of this, using the current
state of the random number generator.

2.4 Post-analysis data structures

While it is possible to construe the results of an eQTL search as a static report, it
is more productive to conceptualize the result as a data object for further analysis.
Unfortunately, the number of tests to be managed can be very large – at least hundreds
of millions, and these must be joinable with location metadata to be maximally useful.

6

Several data structures for managing post-analysis results have emerged as this pack-
age has matured. Of particular concern are those that use ﬀ out-of-memory archiving
for test statistic values or eﬀect estimates and those that use the GRanges infrastructure
to facilitate eﬃcient query resolution in genomic coordinates. These will be described
along with the related analytic workﬂow steps.

3 Focused analyses

A speciﬁc gene can be checked for eQTL on a given chromosome or set of chromosomes
with gwSnpTests. There are various convenience facilities. In the call to gwSnpTests
below, a gene symbol is used to pick out an expression element, and adjustment for
gender is commodated in an additive genetic model for eﬀects of B allele copy number
on expression of CPNE1. One degree of freedom chi-squared tests are computed.

> t1 = gwSnpTests(genesym("CPNE1")~male, g20, chrnum("20"))
> t1

gwSnpScreenResult for gene CPNE1 [probe GI_23397697-A ]

> topSnps(t1)

‘

$

‘

20

p.val
rs17093026 6.485612e-14
rs1118233 1.897898e-13
rs2425078 2.426168e-13
rs1970357 2.426168e-13
rs12480408 2.426168e-13
rs6060535 2.426168e-13
rs11696527 2.426168e-13
rs6058303 2.426168e-13
rs6060578 2.426168e-13
rs7273815 2.544058e-13

It is possible to compute tests for this speciﬁc gene for association with SNP across
several chromosomes if desired; change the value of the third argument to a vector.

There are a few approaches to visualization of the results that are relevant, but

complications arise in relation to choice of genomic coordinates.

> plot(t1, snplocsDefault())
> plot_EvG(genesym("CPNE1"), rsid("rs17093026"), g20)

7

Code like the following can be used to display scores (− log10 p) on the genome

browser, here with hg19 locations.

> library(snplocsDefault(), character.only=TRUE)
> sl = get(snplocsDefault())
> S20 = snplocs(sl, "ch20", as.GRanges=TRUE)
> GR20 = makeGRanges(t1, S20)
> library(rtracklayer)
> export(GR20, "~/cpne1new.wig")

With this code, it will be necessary to manually alter the chr assignment in the wig

ﬁle, and place an informative title to get the following display.

8

0e+001e+072e+073e+074e+075e+076e+07024681012CPNE1position on chr 20−log10 p Gaussian LM [1df]llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll lA/AA/BB/BNA8.08.59.09.510.0rs17093026CPNE1llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll9

4 Comprehensive surveys

4.1 A set of genes vs. all SNP on a chromosome

The performance of snpStats snp.rhs.tests is very good and so our principle for large-
scale searches is to compute all association statistics, save them in truncated form, and
ﬁlter results later. This is carried out with the eqtlTests function. To illustrate, the
expression data is sharply ﬁltered to the 50 most variable genes on chromosome 20
as measured by cross-sample median absolute deviation, SNP with MAF < 0.05 are
removed, and then all SNP-gene association tests are executed.

> g20 = GGtools:::restrictProbesToChrom(g20, "20")
> mads = apply(exprs(g20),1,mad)
> oo = order(mads, decreasing=TRUE)
> g20 = g20[oo[1:50],]
> tf = tempfile()
> dir.create(tf)
> e1 = eqtlTests(MAFfilter(g20, lower=0.05), ~male,
+
> e1

geneApply=mclapply, targdir=tf)

eqtlTestsManager computed Mon Oct 30 18:45:35 2017
gene annotation: illuminaHumanv1.db
some genes (out of 50): hmm9615-S GI_31077201-S ... GI_34335276-S GI_32483384-A
some snps (out of 55039): rs4814683 rs6139074 ... rs6062363 rs4809418

On a two-core macbook pro, this computation completes in less than a minute. The
details of the underlying data structure are involved. Brieﬂy, a short integer is used to
represent each chi-squared statistic obtained in the 1 tests computed, in an ff archive.
Use topFeats to manually harvest this.

> pm1 = colnames(e1@fffile)
> tops = sapply(pm1, function(x) topFeats(probeId(x), mgr=e1, n=1))
> top6 = sort(tops, decreasing=TRUE)[1:6]

> print(top6)

GI_17149835-I.rs6041750 GI_34147330-S.rs6037097 GI_41327717-S.rs2223883
24.87
GI_31563517-A.rs6085541 GI_29826316-A.rs6135980 GI_13540544-S.rs11905405
19.20

40.30

21.38

36.49

19.70

R has propagated the names of probes and SNPs with the scores so that a table can

be created as follows:

10

> nms = strsplit(names(top6), "\\.")
> gn = sapply(nms,"[",1)
> sn = sapply(nms,"[",2)
> tab = data.frame(snp=sn,score=as.numeric(top6))
> rownames(tab) = gn
> tab

snp score
GI_17149835-I rs6041750 40.30
GI_34147330-S rs6037097 36.49
GI_41327717-S rs2223883 24.87
GI_31563517-A rs6085541 21.38
GI_29826316-A rs6135980 19.70
GI_13540544-S rs11905405 19.20

Statistical interpretation of the scores in this table is not clear as the data structure
includes familial aggregation in trios and extended pedigrees, and may include population
stratiﬁcation, Nevertheless, consistency of these ﬁndings with other published results
involving multiple populations can be checked. GGtools includes a table published by
Stranger and colleagues in 2007 enumerating multipopulation eQTL (Stranger et al.,
2007).

> data(strMultPop)
> strMultPop[ strMultPop$rsid %in% tab$snp, ]

rsid genesym

11306 rs6041750
FKBP1A GI_17149835-I
PYGB GI_34577123-S
11398 rs6037097
25370 rs6037097 C20orf22 GI_34147330-S

11306
11398
25370

1794
68869
71612

21.6949 0.3798
8.9349 0.1645
8.9684 0.2257

20
20
20

1298709
25295221
25295221

illv1pid snpChr snpCoordB35 probeMidCoorB35
1300503
25226352
25223609
popSet
12.4815 CEU-CHB-JPT-YRI
6.5410 CEU-CHB-JPT-YRI
CEU-CHB-JPT
6.5535

0.4708
0.1324
0.3396

snp2probe minuslog10p adjR2 assocGrad permThresh

Thus the top two SNP in the table computed here are identiﬁed as multipopulation
eQTL by Stranger. The other association scores are not very strong and likely do not
correspond to genuine associations.

4.2 Tabulating best associated cis-rSNP with permutation-based

FDR: small example

The workhorse for identifying genes to which can be associated putatively regulating
SNP (rSNP) is best.cis.eQTLs. This can be used for genome-wide analysis, but here

11

an alternative table is created for the sharply ﬁltered chromosome 20 data given above.
This call says that gene location information will be acquired from the Bioconductor
TxDb.Hsapiens annotation package for hg19 UCSC known genes, and that tests for as-
sociation within 1 Mbase of the coding region for each gene will be considered. The
expression data will be permuted against genotype data in two independent draws to as-
semble the null reference distribution for association scores; these are used to enumerate
false signiﬁcance claims at various magnitudes of the distribution of association scores.
The plug-in procedure for estimating FDR XXX cite Hastie Tibs Friedman is used.

> fn = probeId(featureNames(g20))

> if (file.exists("db2")) unlink("db2", recursive=TRUE)
> fn = probeId(featureNames(g20))
> exTx = function(x) MAFfilter( x[fn, ], lower=0.05)
> b1 = best.cis.eQTLs("GGdata", ~male, radius=1e6,
folderstem="db2", nperm=2, geneApply=mclapply,
+
smFilter= exTx, chrnames="20", snpannopk=snplocsDefault())
+

> b1

GGtools mcwBestCis instance. The call was:
best.cis.eQTLs(smpack = "GGdata", rhs = ~male, folderstem = "db2",

radius = 1e+06, chrnames = "20", geneApply = mclapply, snpannopk = snplocsDefault(),
smFilter = exTx, nperm = 2)

Best loci for 50 probes are recorded.
There were 83969 gene:snp tests.
Top 4 probe:SNP combinations:
GRanges object with 4 ranges and 6 metadata columns:

seqnames
<Rle>

ranges strand |

snpid
<IRanges> <Rle> | <numeric> <character>
rs6037097
36.49
rs3810504
16.78
16.67 rs13043344
14.78 rs13044229

* |
* |
* |
* |

20 [24280834, 26371618]
20 [61665697, 63671315]
20 [ 352356, 2373816]
20 [61679079, 63680979]

score

GI_34147330-S
hmm26961-S
GI_17149835-I
GI_31077201-S

nsnp

snploc radiusUsed

fdr
<integer> <numeric> <integer> <numeric>
0.00
0.00
0.00
0.25

GI_34147330-S 25347221
hmm26961-S 62678549
544417
GI_17149835-I
GI_31077201-S 61738288
-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

1e+06
1e+06
1e+06
1e+06

1387
783
2382
766

====
use chromsUsed(), fullreport(), etc. for additional information.

12

5 Comprehensive reporting on FDR for all SNP cis

to a set of genes

We want to support improved control of cis-eQTL searches and better reﬂectance of cis-
eQTL search outputs. The basic idea is that we can, in most modern computing facilities,
retain fairly substantial archives resulting from comprehensive searches; previous versions
of GGtools emphasized gene-centric analysis which could then be extended to higher
levels of resolution in a targeted manner. We can do a single comprehensive search and
then ﬁlter to understand sensitivity of FDR measures to aspects of upstream ﬁltering.

5.1 Conﬁguring a search

> suppressPackageStartupMessages(library(GGtools))
> ini = new("CisConfig")
> ini

CisConfig instance; genome hg19 . Key parameters:
smpack = GGdata ; chrnames = 22
nperm = 3 ; radius = 50000
====
Configure using
[1] "smpack<-"
[5] "radius<-"
[9] "gchrpref<-"
[13] "snpannopk<-"
[17] "SSgen<-"
[21] "extraProps<-"

"rhs<-"
"shortfac<-"
"schrpref<-"
"smFilter<-"
"genome<-"
"useME<-"

"nperm<-"
"chrnames<-"
"geneApply<-"
"exFilter<-"
"excludeRadius<-" "estimates<-"
"MEpvot<-"

"folderStem<-"
"smchrpref<-"
"geneannopk<-"
"keepMapCache<-"

> radius(ini) = 75000L
> smFilter(ini) = function(x) nsFilter(x, var.cutoff=.98)
> smpack(ini) = "GGtools"
> chrnames(ini) = "20"
> library(parallel) # to define mclapply
> geneApply(ini) = mclapply
> ini

CisConfig instance; genome hg19 . Key parameters:
smpack = GGtools ; chrnames = 20
nperm = 3 ; radius = 75000
====
Configure using
[1] "smpack<-"
[5] "radius<-"

"rhs<-"
"shortfac<-"

"nperm<-"
"chrnames<-"

13

"folderStem<-"
"smchrpref<-"

[9] "gchrpref<-"
[13] "snpannopk<-"
[17] "SSgen<-"
[21] "extraProps<-"

"schrpref<-"
"smFilter<-"
"genome<-"
"useME<-"

"geneApply<-"
"exFilter<-"
"excludeRadius<-" "estimates<-"
"MEpvot<-"

"geneannopk<-"
"keepMapCache<-"

5.2 Executing a search

5.2.1 Computing and serializing scored GRanges

The FDR reported are for the speciﬁc search (here one chromosome). Various tools for
combining multiple searches are used to get FDRs for more comprehensive searches.

> options(mc.cores=max(1, detectCores()-3))
> system.time(t20 <- All.cis(ini))

get data...build map...run smFilter...filter probes in map...tests...get data...build map...run smFilter...filter probes in map...tests...get data...build map...run smFilter...filter probes in map...tests...get data...build map...run smFilter...filter probes in map...tests...
176.364 26.192 104.556

user system elapsed

> t20

cisRun object with 8383 ranges and 15 metadata columns:

GI_11496985-S
GI_11496985-S
GI_11496985-S
...
hmm9615-S

GI_11496985-S
GI_11496985-S
GI_11496985-S
...
hmm9615-S

snp

ranges strand |

seqnames
<Rle>
chr20 [23004355, 23161340]
chr20 [23004355, 23161340]
chr20 [23004355, 23161340]
...
chr20 [13920499, 16128196]
se

snplocs
<IRanges> <Rle> | <character> <integer>
rs2746621 23004620
- |
rs2567613 23004858
- |
- | rs16984838 23005819
...
rs6043760 16128165

fdr
<numeric> <numeric> <numeric> <numeric>

... .
+ |

score

ests

...

...

0.78
4.12
0.00
...
0

-0.30
0.26
<NA>
...
<NA>

MAF dist.mid

probeid
<character>
0.34 0.9466940 GI_11496985-S
0.12 1.0000000 GI_11496985-S
<NA> 0.6941591 GI_11496985-S
...
hmm9615-S

...
<NA> 0.6941591
mindist genestart

...

GI_11496985-S 0.04444444
GI_11496985-S 0.41111111
GI_11496985-S 0.00000000
...
...
0
hmm9615-S

<numeric> <numeric> <numeric> <integer> <integer>
74735 -23079355 -23086340
74497 -23079355 -23086340
73536 -23079355 -23086340
...
74969 13995499 16053196

78227.5
77989.5
77028.5
...
1103818

...

...

geneend permScore_1
<numeric>
0.02
1.17
0.00
...
0

permScore_2 permScore_3
<numeric>

<numeric>

14

GI_11496985-S
GI_11496985-S
GI_11496985-S
...
hmm9615-S

0.00
0.21
0.00
...
0

3.48
3.47
0.00
...
0

-------
seqinfo: 93 sequences (1 circular) from hg19 genome

Note that the observed score is retained along with all associated scores achieved under
permutation of expression against genotype.

We can update to a diﬀerent chromosome:

> chrnames(ini) = "21"
> system.time(t21 <- All.cis(ini))

For realistic and comprehensive ﬁltering settings (radius 250000 or greater, MAF
bound .005, the results of All.cis can be quite large, so most downstream utilities assume
the results are serialized to disk.

> td = tempdir()
> save(t20, file=paste0(td, "/t20.rda"))
> #save(t21, file=paste0(td, "/t21.rda"))

5.2.2 Amalgamation of chromosome-speciﬁc results, recomputation of FDR

We will use a collection method that focuses on sensitivity analysis, generating FDRs
for diﬀerent tuning parameters within the scope of the search.

> fns = dir(td, full=TRUE, patt="^t2.*rda$")
> cf = collectFiltered(fns, mafs=c(.02,.03,.1), hidists=c(1000,10000,75000))

....................................

> class(cf)

[1] "list"

> names(cf) # MAFs are primary organization, distances secondary

[1] "0.02" "0.03" "0.1"

> names(cf[[1]])

[1] "1000" "10000" "75000"

15

> sapply(cf, sapply, function(x) sum(x$fdr <= 0.05)) # best per gene

0.02 0.03 0.1
0
0
0

0
0
0

0
0
0

1000
10000
75000

> of = order(cf[[3]][[1]]$fdr)
> cf[[3]][[1]][of,][1:4,] # shows best hits

genes
GI_11496985-S GI_11496985-S
hmm9615-S
GI_40804463-S GI_40804463-S rs12329540 chr20 0.7037037
GI_30795228-S GI_30795228-S rs1999242 chr20 0.7500000

7.96
hmm9615-S rs7272442 chr20 0.6666667 10.81
0.80
1.23

fdr scores MAF.observed
0.1348315
0.4367816
0.1516854
0.1611111

chr
rs844820 chr20 0.6666667

bestsnp

GI_11496985-S
hmm9615-S
GI_40804463-S
GI_30795228-S

permScore_1 permScore_2 permScore_3
0.40
7.77
5.61
0.11

2.56
13.45
0.43
2.94

0.64
9.44
1.20
6.19

> g20 = getSS("GGtools", "20")

> plot_EvG(probeId("GI_4502372-S"), rsid("rs290449"), g20)

collectFiltered has a default filterFun which isolates the best scoring SNP per

gene. A SNP-centric FDR can also be computed.

> cf2 = collectFiltered(fns, mafs=c(.02,.05,.1), hidists=c(10000,75000),
+
> sapply(cf2, sapply, function(x) sum(x$fdr<=0.01))

filterFun=cis.FDR.filter.SNPcentric)

16

A/AA/BB/BNA7891011rs290449BCAS1llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll0.02 0.05 0.1
0
0

0
0

0
0

10000
75000

6 Full search on an SGE-based cluster

The stages are:

(cid:136) create the smlSet-based package via externalize

(cid:136) set up the chromosome-speciﬁc run as a function

bf = basicFilter = function(ww) MAFfilter(clipPCs(ww, 1:npc), lower=MAF)[, which(ww$isFounder==1)]

else bf = basicFilter = function(ww) MAFfilter(ww, lower=MAF)[, which(

ww$isFounder==1)]

if (!is.null(npc))

npc=10, radius=50000, exclRadius=NULL) {

ssm(library(GGtools))
iniconf = new("CisConfig")
smpack(iniconf) = "GGdata"
rhs(iniconf) = ~1
folderStem(iniconf) = paste0("cisScratch_", chrn)
chrnames(iniconf) = as.character(chrn)
geneannopk(iniconf) = "illuminaHumanv1.db"
snpannopk(iniconf) = snplocsDefault()
smchrpref(iniconf) = ""
geneApply(iniconf) = mclapply
exFilter(iniconf) = function(x)x
smFilter(iniconf) = bf
nperm(iniconf) = as.integer(nperm)
radius(iniconf) = radius
estimates(iniconf) = TRUE
MAFlb(iniconf) = MAF

> onepopConfig = function(chrn="22", nperm=3L, MAF=.05,
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
+
+
+
+
+
+

library(parallel)
options(mc.cores=3)
options(error=recover)
set.seed(1234)
tmp = All.cis( iniconf )
metadata(tmp)$config = iniconf
obn = paste("pop2_", "np_", nperm, "_maf_", MAF, "_chr_", chrn,

17

"_npc_", npc, "_rad_", radius, "_exc_", exclRadius, sep="")

fn = paste(obn, file=".rda", sep="")
assign(obn, tmp)
save(list=obn, file=fn)

+
+
+
+
+ }

(cid:136) Create a script that invokes the function

#!/bin/bash
RCMD=/udd/stvjc/bin/R3
CHR=$1
MAF=$2
NPERM=$3
NPC=$4
RAD=$5
EXCL=$6
LANG=C
echo "source(

’

); \
onepopConfig(chrn=${CHR}, MAF=${MAF}, nperm=${NPERM}, \

onepopConfig.R

’

npc=${NPC}, radius=${RAD}, exclRadius=${EXCL})" | ${RCMD} \

--no-save >& lk${CHR}_${MAF}_${NPERM}_${RAD}_${EXCL}.txt

(cid:136) Use the scheduler implicitly (or somehow)

#!/bin/bash
for i in {1..22};

do qsub -cwd -l lx6,large ./doOne.sh $i .005 3L 18 250000L NULL; echo $i;

done;

At conclusion, 22 .rda ﬁles will be present for harvesting using the collectFiltered
function.

6.1 Removal of empirically identiﬁed expression heterogeneity

Leek et al. (2010) describe implications of batch eﬀects in high-throughput experimental
contexts. Various methods for adjustment of responses have been proposed; a very
simple but evidently risky approach is nonspeciﬁc removal of principal components of
variation. To maximize information on possible batch eﬀects, the entire expression
matrix is restored and decomposed for principal component removal.

> if (file.exists("db2")) unlink("db2", recursive=TRUE)
> g20 = getSS("GGdata", "20")
> exTx = function(x) MAFfilter( clipPCs(x,1:10)[fn, ], lower=0.05)
> g20f = exTx(g20)

18

> b2 = best.cis.eQTLs("GGdata", ~male, radius=50000,
+
+

folderstem="db3", nperm=2, geneApply=mclapply,
smFilter= exTx, chrnames="20", snpannopk=snplocsDefault())

> b2

GGtools mcwBestCis instance. The call was:
best.cis.eQTLs(smpack = "GGdata", rhs = ~male, folderstem = "db3",

radius = 50000, chrnames = "20", geneApply = mclapply, snpannopk = snplocsDefault(),
smFilter = exTx, nperm = 2)

Best loci for 50 probes are recorded.
There were 7838 gene:snp tests.
Top 4 probe:SNP combinations:
GRanges object with 4 ranges and 6 metadata columns:

seqnames
<Rle>

ranges strand |

snpid
<IRanges> <Rle> | <numeric> <character>
rs6037097
rs3810504
rs163782
rs7272442

36.49
16.78
10.46
10.84

* |
* |
* |
* |

20 [25230834, 25421618]
20 [62615697, 62721315]
20 [57520242, 57632309]
20 [13926146, 16083841]

score

GI_34147330-S
hmm26961-S
GI_22538441-S
hmm9615-S

snploc radiusUsed

fdr
<integer> <numeric> <integer> <numeric>
94 0.0000000
47 0.0000000
66 0.1111111
2480 0.1250000

50000
50000
50000
50000

GI_34147330-S 25347221
hmm26961-S 62678549
GI_22538441-S 57565943
hmm9615-S 15275538

nsnp

-------
seqinfo: 1 sequence from an unspecified genome; no seqlengths

====
use chromsUsed(), fullreport(), etc. for additional information.

An improvement in sensitivity can be seen after this adjustment. The probes with
FDR at 0.13 (used for demonstration purposes with this drastically reduced data) or
lower are identiﬁed by the helper function

> goodProbes = function(x) names(x@scoregr[elementMetadata(x@scoregr)$fdr<0.13])

All probes identiﬁed as signiﬁcant (at FDR ≤ 0.13) before the PCA adjustment are
identiﬁed as such after it:

> setdiff(goodProbes(b2), goodProbes(b1))

[1] "GI_22538441-S" "hmm9615-S"

The adjustment can lead to loss of signiﬁcance for some probes.

19

> setdiff(goodProbes(b1), goodProbes(b2))

[1] "GI_17149835-I"

The eﬀects of the adjustment for genes that were signiﬁcant only in the adjusted

analysis can be visualized:

> newp = setdiff(goodProbes(b2), goodProbes(b1))
> np = length(newp)
> bestSnp = function(pn, esm) elementMetadata(esm@scoregr[pn])$snpid
> par(mfrow=c(2,2))
> plot_EvG(probeId(newp[1]), rsid(bestSnp(newp[1], b2)), g20, main="raw")
> plot_EvG(probeId(newp[1]), rsid(bestSnp(newp[1], b2)), g20f, main="PC-adjusted")
> plot_EvG(probeId(newp[np]), rsid(bestSnp(newp[np], b2)), g20, main="raw")
> plot_EvG(probeId(newp[np]), rsid(bestSnp(newp[np], b2)), g20f, main="PC-adjusted")

20

7 Exercises

1. All computations performed above ignore familial structure in the data that can
be determined using the famid, mothid, fathid variables in the pData(g20).
Reduce the smlSet instance used for eQTL testing to parents only, who have
parent identiﬁers equal to zero, and recompute the main tables.

2. For selected eQTLs that are were signiﬁcant with low FDR in the full data ignoring,
but are not signiﬁcant in the analysis of the reduced data, use a reasonably speciﬁed
variance components model on the full data with familial structure and compute
a third test statistic. Is the restriction to parents only a good policy for eQTL
discovery? Is there evidence of substantial familial aggregation in expression after
heterogeneity reduction?

3. How can we select in a principled way the number of principal components to be

removed for heterogeneity reduction?

21

8 Appendix: building your own structures

The following code illustrates construction of a minimal smlSet instance.

> library(Biobase)
> suppressPackageStartupMessages(library(GGtools))
> ex = matrix(0, nr=5, nc=3)
> pd = data.frame(v1 = 1:3, v2=5:7)
> colnames(ex) = rownames(pd) = LETTERS[1:3]
> adf = AnnotatedDataFrame(pd)
> rownames(ex) = letters[1:5]
> es = ExpressionSet(ex, phenoData=adf)
> exprs(es)

A B C
a 0 0 0
b 0 0 0
c 0 0 0
d 0 0 0
e 0 0 0

> pData(es)

v1 v2
A 1 5
B 2 6
C 3 7

> library(snpStats)
> mysnps = matrix(rep(1:3, 10), nr=3) # note 1=A/A, ... 0 = NA
> rownames(mysnps) = colnames(ex)
> mysm = new("SnpMatrix", mysnps)

coercing object of mode numeric to SnpMatrix

> as(mysm, "character")

[,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
A "A/A" "A/A" "A/A" "A/A" "A/A" "A/A" "A/A" "A/A" "A/A" "A/A"
B "A/B" "A/B" "A/B" "A/B" "A/B" "A/B" "A/B" "A/B" "A/B" "A/B"
C "B/B" "B/B" "B/B" "B/B" "B/B" "B/B" "B/B" "B/B" "B/B" "B/B"

> as(mysm, "numeric")

22

[,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
0
1
2

0
1
2

0
1
2

0
1
2

0
1
2

0
1
2

0
1
2

0
1
2

0
1
2

0
1
2

A
B
C

> sml = make_smlSet(es, list(c1=mysm))
> annotation(sml)

character(0)

> colnames(smList(sml)[[1]])

NULL

23

9 Session information

> toLatex(sessionInfo())

(cid:136) R version 3.4.2 (2017-09-28), x86_64-pc-linux-gnu

(cid:136) Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_US.UTF-8,
LC_COLLATE=C, LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8,
LC_PAPER=en_US.UTF-8, LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C,
LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

(cid:136) Running under: Ubuntu 16.04.3 LTS

(cid:136) Matrix products: default

(cid:136) BLAS: /home/biocbuild/bbs-3.6-bioc/R/lib/libRblas.so

(cid:136) LAPACK: /home/biocbuild/bbs-3.6-bioc/R/lib/libRlapack.so

(cid:136) Base packages: base, datasets, grDevices, graphics, methods, parallel, stats,

stats4, utils

(cid:136) Other packages: AnnotationDbi 1.40.0, BSgenome 1.46.0, Biobase 2.38.0,
BiocGenerics 0.24.0, Biostrings 2.46.0, GGBase 3.40.0, GGtools 5.14.0,
GO.db 3.4.2, GenomeInfoDb 1.14.0, GenomicFeatures 1.30.0,
GenomicRanges 1.30.0, Homo.sapiens 1.3.1, IRanges 2.12.0, Matrix 1.2-11,
OrganismDbi 1.20.0, S4Vectors 0.16.0,
SNPlocs.Hsapiens.dbSNP144.GRCh37 0.99.20,
TxDb.Hsapiens.UCSC.hg19.knownGene 3.2.2, XVector 0.18.0,
data.table 1.10.4-3, illuminaHumanv1.db 1.26.0, org.Hs.eg.db 3.4.2,
rtracklayer 1.38.0, snpStats 1.28.0, survival 2.41-3

(cid:136) Loaded via a namespace (and not attached): AnnotationFilter 1.2.0,

AnnotationHub 2.10.0, BiocInstaller 1.28.0, BiocParallel 1.12.0, DBI 0.7,
DelayedArray 0.4.0, Formula 1.2-2, GenomeInfoDbData 0.99.1,
GenomicAlignments 1.14.0, Gviz 1.22.0, Hmisc 4.0-3, KernSmooth 2.23-15,
ProtGenerics 1.10.0, R6 2.2.2, RBGL 1.54.0, RColorBrewer 1.1-2, RCurl 1.95-4.8,
RMySQL 0.10.13, ROCR 1.0-7, RSQLite 2.0, Rcpp 0.12.13, Rsamtools 1.30.0,
SummarizedExperiment 1.8.0, VariantAnnotation 1.24.0, XML 3.98-1.9,
acepack 1.4.1, annotate 1.56.0, assertthat 0.2.0, backports 1.1.1, base64enc 0.1-3,
biglm 0.9-1, biomaRt 2.34.0, biovizBase 1.26.0, bit 1.1-12, bit64 0.9-7,
bitops 1.0-6, blob 1.1.0, caTools 1.17.1, checkmate 1.8.5, cluster 2.0.6,
colorspace 1.3-2, compiler 3.4.2, curl 3.0, dichromat 2.0-0, digest 0.6.12,
ensembldb 2.2.0, ﬀ 2.2-13, foreign 0.8-69, gdata 2.18.0, geneﬁlter 1.60.0,
ggplot2 2.2.1, gplots 3.0.1, graph 1.56.0, grid 3.4.2, gridExtra 2.3, gtable 0.2.0,

24

gtools 3.5.0, hexbin 1.27.1, htmlTable 1.9, htmltools 0.3.6, htmlwidgets 0.9,
httpuv 1.3.5, httr 1.3.1, interactiveDisplayBase 1.16.0, iterators 1.0.8, knitr 1.17,
lattice 0.20-35, latticeExtra 0.6-28, lazyeval 0.2.1, magrittr 1.5,
matrixStats 0.52.2, memoise 1.1.0, mime 0.5, munsell 0.4.3, nnet 7.3-12,
pkgconﬁg 2.0.1, plyr 1.8.4, prettyunits 1.0.2, progress 1.1.2, reshape2 1.4.2,
rlang 0.1.2, rpart 4.1-11, scales 0.5.0, shiny 1.0.5, splines 3.4.2, stringi 1.1.5,
stringr 1.2.0, tibble 1.3.4, tools 3.4.2, xtable 1.8-2, yaml 2.1.14, zlibbioc 1.24.0

References

Richard Bourgon, Robert Gentleman, and Wolfgang Huber. Independent ﬁltering in-
creases detection power for high-throughput experiments. Proc Natl Acad Sci USA,
107(21):9546–51, May 2010. doi: 10.1073/pnas.0914005107.

Petra B˚uˇzkov´a, Thomas Lumley, and Kenneth Rice. Permutation and parametric boot-
strap tests for gene-gene and gene-environment interactions. Ann Hum Genet, 75(1):
36–45, Jan 2011. doi: 10.1111/j.1469-1809.2010.00572.x.

Vivian G Cheung, Richard S Spielman, Kathryn G Ewens, Teresa M Weber, Michael
Morley, and Joshua T Burdick. Mapping determinants of human gene expression by
regional and genome-wide association. Nature, 437(7063):1365–9, Oct 2005. doi:
10.1038/nature04244. URL http://192.168.100.1:5280/?redirect=http%253A/
/eutils.ncbi.nlm.nih.gov/entrez/eutils/elink.fcgi.

Jeﬀrey T Leek and John D Storey. Capturing heterogeneity in gene expression stud-
ies by surrogate variable analysis. PLoS Genet, 3(9):1724–35, Sep 2007. doi: 10.
1371/journal.pgen.0030161. URL http://www.plosgenetics.org/article/info%
253Adoi%252F10.1371%252Fjournal.pgen.0030161.

Jeﬀrey T Leek, Robert B Scharpf, H´ector Corrada Bravo, David Simcha, Benjamin
Langmead, W Evan Johnson, Donald Geman, Keith Baggerly, and Rafael A Irizarry.
Tackling the widespread and critical impact of batch eﬀects in high-throughput data.
Nat Rev Genet, 11(10):733–9, Oct 2010. doi: 10.1038/nrg2825. URL http://www.
nature.com/nrg/journal/v11/n10/full/nrg2825.html.

Jacek Majewski and Tomi Pastinen. The study of eqtl variations by rna-seq: from snps
to phenotypes. Trends Genet, 27(2):72–9, Feb 2011. doi: 10.1016/j.tig.2010.10.006.

Enrico Petretto, Leonardo Bottolo, Sarah R Langley, Matthias Heinig, Chris
McDermott-Roe, Rizwan Sarwar, Michal Pravenec, Norbert H¨ubner, Timo-
thy J Aitman, Stuart A Cook, and Sylvia Richardson.
New insights into
the genetic control of gene expression using a bayesian multi-tissue approach.
10.1371/journal.pcbi.
PLoS Comput Biol,

6(4):e1000737, Apr 2010.

doi:

25

1000737. URL http://www.ploscompbiol.org/article/info%253Adoi%252F10.
1371%252Fjournal.pcbi.1000737.

Oliver Stegle, Leopold Parts, Richard Durbin, and John Winn. A bayesian frame-
work to account for complex non-genetic factors in gene expression levels greatly
increases power in eqtl studies. PLoS Comput Biol, 6(5):e1000770, May 2010.
doi: 10.1371/journal.pcbi.1000770. URL http://www.ploscompbiol.org/article/
info%253Adoi%252F10.1371%252Fjournal.pcbi.1000770.

Barbara E Stranger, Alexandra C Nica, Matthew S Forrest, Antigone Dimas, Christine P
Bird, Claude Beazley, Catherine E Ingle, Mark Dunning, Paul Flicek, Daphne Koller,
Stephen Montgomery, Simon Tavar´e, Panos Deloukas, and Emmanouil T Dermitzakis.
Population genomics of human gene expression. Nat Genet, 39(10):1217–1224, Oct
2007. doi: 10.1038/ng2142.

R. B.H Williams, E. K.F Chan, M. J Cowley, and P. F.R Little. The inﬂuence of genetic
variation on gene expression. Genome Research, 17(12):1707–1716, Dec 2007. doi:
10.1101/gr.6981507.

26

