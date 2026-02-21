Using the FunciSNP package
‘FunciSNP: An R/Bioconductor Tool
Integrating Functional Non-coding Datasets with
Genetic Association Studies to
Identify Candidate Regulatory SNPs’

Simon G. Coetzee◦‡*, Suhn K. Rhie‡, Benjamin P. Berman‡,
Gerhard A. Coetzee‡ and Houtan Noushmehr◦‡(cid:132)

October 30, 2018

◦Faculdade de Medicina de Ribeir˜ao Preto
Departmento de Gen´etica
Universidade de S˜ao Paulo
Ribeir˜ao Preto, S˜ao Paulo, BRASIL
–
‡Norris Cancer Center
Keck School of Medicine
University of Southern California
Los Angeles, CA, USA

Contents

1 Introduction

1.1 Benchmark . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . .
1.2 Genome-Wide Association Studies SNP (GWAS SNP)
. . . . . . . . . . . . . . . . . . . . . . . . . . .
1.3
1000 genomes project (1kg)
. . . . . . . . . . . . . . . . . . . . . . . . .
1.4 Genomic features (Biofeatures)

2 Installing and Loading FunciSNP

*scoetzee NEAR gmail POINT com
(cid:132)houtan NEAR usp POINT br

1

2
3
3
3
3

4

3 Running getFSNPs to identify putative functional SNPs

3.1 Create a GWAS SNP ﬁle . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2 Biofeatures in BED format . . . . . . . . . . . . . . . . . . . . . . . . . . . .
getFSNPs analysis using two inputs . . . . . . . . . . . . . . . . . . . . . . .
3.3

4 Annotating newly identiﬁed putative functional SNPs

5 Summarize FunciSNP results

5.1 Summary table used to describe newly identiﬁed YAFSNPs . . . . . . . . . .
. . . . . . . . . . . . .
5.2 Summary of correlated SNPs overlapping biofeatures
. . . . . . .
5.3 Summary of correlated SNPs for a number of diﬀerent tagSNPs

6 Plot FunciSNP results

6.1 Default plot . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6.2 Split by tagSNP . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
6.3 Heatmap of 1kg SNPs by tagSNP vs Biofeature . . . . . . . . . . . . . . . .
6.4 TagSNP and Biofeature Summary . . . . . . . . . . . . . . . . . . . . . . . .
6.5 Genomic Feature Summary . . . . . . . . . . . . . . . . . . . . . . . . . . .

5
5
6
8

10

13
14
14
15

16
16
16
16
17
19

7 Visualize FunciSNP results in a genomic browser (outputs BED format) 21

8 Contact information

9 sessionInfo

1 Introduction

23

23

FunciSNP assist in identifying putative functional SNP in LD to previously annotated GWAS
SNPs (tagSNP). Extracting information from the 1000 genomes database (1kg) by relative
genomic position of GWAS tagSNP currated for a particular trait or disease, FunciSNP aims
to integrate the two information with sequence information provided by peaks identiﬁed from
high-throughput sequencing. FunciSNP assumes user will provide peaks identiﬁed using any
available ChIP peak algorithm, such as FindPeaks, HOMER, or SICER. FunciSNP will
currate all 1kg SNPs which are in linkage disequilibrium (LD) to a known disease associated
tagSNP and more importantly determine if the 1kg SNP in LD to the tagSNP overlaps a
genomic biological feature.

Correlated SNPs are directly imported from the current public release of the 1000 genomes

database. 1000 genomes ftp servers available for the 1000 genomes public data:

(cid:136) National Center for Biotechnology Information (NCBI)1

(cid:136) European Bioinformatics Institute (EBI)2

1ftp://ftp-trace.ncbi.nih.gov/1000genomes/
2ftp://ftp.1000genomes.ebi.ac.uk/vol1/

2

Correlated SNPs in LD to a tagSNP and overlapping genomic biological features are

known as putative functional SNPs.

This vignette provides a ‘HOW-TO’ guide in setting up and running FunciSNP on your
machine. FunciSNP was developed with the idea that a user will have uninterupted high-
speed internet access as well as a desktop machine with more than 4 multiple cores.
If
user is using a windows machine, multiple cores options will not work and thus total time
to complete initial FunciSNP analysis will take longer than expected. Be sure you have
uninterupted computing power when using a windows machine. If using a linux machine,
please use ‘screen’ (see ‘man screen’ for more information).

1.1 Benchmark

Using a 64bit Linux machine running 11.04 Ubuntu OS with 24G RAM and 8 cores connected
to a academic high-speed internet port, the amount of time to complete 99 tagSNP across
20 diﬀerent biofeatures took less than 30 min to complete. We anticipate about 2 hours to
complete the same analysis using one core.

1.2 Genome-Wide Association Studies SNP (GWAS SNP)

Genome-wide association studies (GWASs) have yielded numerous single nucleotide poly-
morphisms (SNPs) associated with many phenotypes. In some cases tens of SNPs, called
tagSNPs, mark many loci of single complex diseases such as prostate (> 50 loci), breast
(> 20 loci), ovarian (>10 loci), colorectal (>20 loci) and brain cancer (>5 loci) for which
functionality remains unknown. Since most of the tagSNPs (>80%) are found in non-protein
coding regions, ﬁnding direct information on the functional and/or causal variant has been
an important limitation of GWAS data interpretation.

1.3 1000 genomes project (1kg)

The 1000 genomes project recently released a catalog of most human genomic variants (minor
allele frequency of >0.1%) across many diﬀerent ethnic populations.
Initially, the 1000
genomes project goal was to sequence up to 1000 individuals, but has since sequenced more
than 2000 individuals, thereby increasing our current knowledge of known genomic variations
which currently sits at just over 50 million SNPs genome wide (approx. 2% of the entire
genome and on average 1 SNP every 60 base pairs)

1.4 Genomic features (Biofeatures)

With the advent of advanced sequencing technologies (next-generation sequencing, NGS),
genomic regulatory areas in non-coding regions have been well characterized and annotated.
Coupled with chromatin immuno-precipitation for a protein (e.g. transcription factor of hi-
stone) of interest, also known as ChIPseq, the technology have provided us with a unique
view of the genomic landscape, thereby providing a wealth of new knowledge for genomics

3

research. Work by large consortia groups such as the Encyclopedia of DNA Elements (EN-
CODE), the Roadmap Epigenomics Mapping Consortium and The Cancer Genome Atlas
(TCGA), have made publicly available a growing catalog of many diﬀerent histone marks,
transcription factors and genome-wide sequencing datasets for a variety of diﬀerent diseases
and cell lines, including well characterized cancer cell lines such as MCF7 (breast cancer),
HCT116 (colon cancer), U87 (brain cancer) and LNCaP (prostate cancer).

2 Installing and Loading FunciSNP

To obtain a copy of FunciSNP , you will need to install BiocManager via Bioconductor:

library(BiocManager); BiocManager::install(”FunciSNP”);
If you download the source code from the bioconductor page which lists FunciSNP, you
can install FunciSNP by following the instructions described in R CRAN. By installing
FunciSNP from source, the package assumes you have all the required libraries installed.

(cid:136) Rsamtools (>= 1.6.1)

(cid:136) rtracklayer(>= 1.14.1)

(cid:136) GGtools (>= 4.0.0)

(cid:136) methods

(cid:136) ChIPpeakAnno (>= 2.2.0)

(cid:136) GenomicRanges

(cid:136) TxDb.Hsapiens.UCSC.hg19.knownGene

(cid:136) VariantAnnotation

(cid:136) plyr

(cid:136) org.Hs.eg.db

(cid:136) snpStats

The following loads the FunciSNP library in R.

> options(width=80);
> library(FunciSNP);
> package.version("FunciSNP");

[1] "1.26.0"

4

3 Running getFSNPs to identify putative functional

SNPs

Before running getFSNPs, two input ﬁles are required. A list of tagSNPs and a folder with
all available biological features (peak ﬁles in BED format).

3.1 Create a GWAS SNP ﬁle

GWAS SNPs (tagSNP) should be listed in a tab or whitespace separated ﬁle. Three columns
are required for each tagSNP:

(cid:136) Position (chrom:position)

(cid:136) rsID (rsXXXXXXXX)

(cid:136) population (EUR, AFR, AMR, ASN, or ALL)

‘Positon’ should be the exact postion for each rsID as reported by human genome build
hg19 (chrom:postion).
‘rsID’ should contain a unique rsID as determined by the 1000
genomes database (1kg)3 for each identiﬁed ‘tagSNP’. Population should be a three letter
code to determine original ethnic population for which the associated ‘tagSNP’ was identi-
ﬁed. The three letter code should be either European (EUR), Asian (ASN), African (AFR),
American (AMR), or All (ALL). List each tagSNP per ethnic population. If similar rsID
was identiﬁed in multiple ethnic population, list each duplicate tagSNP separately with the
appropriate ethnic pouplation.

Several GWAS SNPs signiﬁcantly associated with Glioblastoma multiforme (GBM)4 were
collected for this example. GBM is a brain cancer with median survival at less than 12
months, making this form of cancer one of the most aggressive of all cancer types. Currently,
there is no known function of any of these associated tagSNPs.
In this example, GBM
includes lower grade glioma, therefore we use the ‘glioma’ to label all objects.

> ## Full path to the example GWAS SNP regions file for Glioblastoma
> # (collected from SNPedia on Jan 2012)
> glioma.snp <- file.path(system.file(
’
+ dir(system.file(
> gsnp <- read.delim(file=glioma.snp,sep=" ",header=FALSE);
> gsnp;

’
, package=
’
), pattern=

FunciSNP
));
.snp$

extdata
’

,package=

FunciSNP

extdata

’

’

’

’

’

’

),

V1

V2 V3
1 11:118477367 rs498872 EUR
5:1286516 rs2736100 ASN
2
3
9:22068652 rs4977756 EUR
4 20:62309839 rs6010620 EUR

3Be sure the rsID is located in this browser: http://browser.1000genomes.org/
4See http://www.snpedia.com/index.php/Glioma

5

Now, glioma.snp contains the full path to the GWAS tagSNP.

3.2 Biofeatures in BED format

Each biofeature used to identify correlated SNP should be in standard BED format5. Each
biofeature should be stored in one folder and should have ﬁle extension ‘*.bed’.

Here is an example of three diﬀerent biofeatures used for this glioma example. NRSF
and PolII (both transcription factors) where extracted from a recent release of ENCODE, as
well as promoters of approximately 38,000 gene transcription start sites (TSS). Promoters
are identiﬁed as +1000 to -100 base pair of each annotated TSS. In addition, we include
all known DNAseI sites as supplied by ENCODE as well as FAIRE data. In additoin, we
used known CTCF sites to diﬀerentiate the DNAseI. The DNAseI and FAIRE data were
extracted in April of 2012 and they represent the best known regions across several diﬀerent
cell lines. In addition, for the FAIRE data, we selected peaks with p-values less than 0.01.

> ## Full path to the example biological features BED files
> # derived from the ENCODE project for Glioblastoma U-87 cell lines.
> glioma.bio <- system.file(
> #user supplied biofeatures
> as.matrix(list.files(glioma.bio, pattern=

,package=

FunciSNP

extdata

.bed$

));

);

’

’

’

’

’

’

[,1]

[1,] "TFBS_Nrsf_U87.bed"
[2,] "TFBS_Pol2_U87.bed"

> #FunciSNP builtin biofeatures
> as.matrix(list.files(paste(glioma.bio, "/builtInFeatures", sep=""),
+

pattern=

.bed$

));

’

’

[,1]

’
’

’
’

)[1];
)[2];

.bed$
.bed$

> nrsf.filename <- list.files(glioma.bio, pattern=
> pol2.filename <- list.files(glioma.bio, pattern=
> Ctcf <- ctcf_only
> Dnase1 <- encode_dnase1_only
> Dnase1Ctcf <- encode_dnase1_with_ctcf
> Faire <- encode_faire
> Promoters <- known_gene_promoters
> Nrsf <- read.delim(file=paste(glioma.bio, nrsf.filename,sep="/"), sep="\t",
+ header=FALSE);
> PolII <- read.delim(file=paste(glioma.bio, pol2.filename,sep="/"), sep="\t",
+ header=FALSE);
> dim(Nrsf);

5See UCSC FAQ: http://genome.ucsc.edu/FAQ/FAQformat

6

[1] 1264

6

> dim(PolII);

[1] 10918

6

> dim(Ctcf);

NULL

> dim(Dnase1);

NULL

> dim(Dnase1Ctcf);

NULL

> dim(Faire);

NULL

> dim(Promoters);

NULL

> ## Example of what the BED format looks like:
> head(Nrsf);

V1

V2

V3

V4 V5 V6
1 chr5 178601706 178602140 Merged-chr5-178601923-1 0 +
2 chr5 178850156 178850592 Merged-chr5-178850374-1 0 +
3 chr5 179015119 179015553 Merged-chr5-179015336-1 0 +
Merged-chr7-24240-1 0 +
4 chr7
Merged-chr7-65833-1 0 +
5 chr7
Merged-chr7-129164-1 0 +
6 chr7

23844
65601
128907

24636
66065
129421

As an example, Nrsf was created to illustrate the format needed for each biofeatures. To

run getFSNPs, only the path to the folder to each biofeature is required (glioma.bio).

7

3.3 getFSNPs analysis using two inputs

To run the example data could take more than 5 minutes, thus the R code is commented out
for this tutorial. If you are interested in running the glioma example from scratch, please
uncomment the following and rerun in your R session. NOTE: The main method to run
FunciSNP is getFSNPs.

> ## FunciSNP analysis, extracts correlated SNPs from the
> ## 1000 genomes db ("ncbi" or "ebi") and finds overlaps between
> ## correlated SNP and biological features and then
> ## calculates LD (Rsquare, Dprime, distance, p-value).
> ## Depending on number of CPUs and internet connection, this step may take
> ## some time. Please consider using a unix machine to access multiple cores.
>
> # glioma <- getFSNPs(snp.regions.file=glioma.snp, bio.features.loc = glioma.bio,
> # bio.features.TSS=FALSE);

As an alternative, glioma was pre-run and stored in the package as an R object. To call

this data object, simily run the following commands.

> data(glioma);
> class(glioma);

[1] "TSList"
attr(,"package")
[1] "FunciSNP"

Now, glioma contains the R data structure that holds all the results for this particular
analysis. Each tagSNP is stored as a slot which contains associated correlated SNP and
overlapping biofeature. It also contains a number of diﬀerent annotations (see below for more
details). To see a brief summary of the results (summary), type the following commands:

> glioma;

TagSNP List with 4 Tag SNPs and

1855 nearby, potentially correlated SNPs, that overlap at least one biofeature
‘

‘

$

R squared: 0.1

tagSNPs
1K SNPs
Biofeatures

Total R.sq>=0.1 Percent
4 100.00
7.06
6 100.00

4
1855
6

131

‘

$

R squared: 0.5

‘

Total R.sq>=0.5 Percent

8

tagSNPs
1K SNPs
Biofeatures

4
1855
6

3
64
4

75.00
3.45
66.67

‘

$

R squared: 0.9

‘

tagSNPs
1K SNPs
Biofeatures

Total R.sq>=0.9 Percent
25.0
0.7
50.0

4
1855
6

1
13
3

As you can quickly observe from the above analysis, using 4 tagSNPs position and 7
diﬀerent biological features (ChIPseq for ‘NRSF’, ‘PolII’, promoters of approx. 38,000 genes,
DNAseI sites, DNAseI sites with CTCFs, FAIRE, CTCFs) as two types of input, FunciSNP
identiﬁed 1809 1kg SNPs that overlap at least one biofeature. Each 1kg SNP contains an
Rsquare value to the associated tagSNP. As a result, the ﬁrst output (glioma), summarizes
the analysis subsetted in three diﬀerent Rsquare values (0.1, 0.5 and 0.9). If we consider
Rsquare cutoﬀ at 0.9 (Rsquare ≥ 0.9), 14 1kg SNPs overlapping at least one biofeature. This
value represents 0.77% of the total (1809). In addition, at this Rsquare cutoﬀ, 3 biological
features are represented among the 14 1kg SNPs.

> summary(glioma);

TagSNP List with 4 Tag SNPs and

1855 nearby, potentially correlated SNPs, that overlap at least one biofeature

Number of potentially correlated SNPs
overlapping at least x biofeatures, per Tag SNP at a specified R squared
$

R squared: 0.1 in 4 Tag SNPs with a total of

‘

‘

rs2736100
rs4977756
rs498872
rs6010620
TOTAL # 1kgSNPs

bio.1 bio.2 bio.3 bio.4
0
0
0
4
4

2
17
29
83
131

0
4
9
20
33

0
0
0
9
9

‘

$

R squared: 0.5 in 3 Tag SNPs with a total of

rs4977756
rs498872
rs6010620
TOTAL # 1kgSNPs

bio.1 bio.2 bio.3 bio.4
0
0
3
3

7
6
51
64

3
2
10
15

0
0
5
5

‘

$

R squared: 0.9 in 1 Tag SNPs with a total of

bio.1 bio.2

9

‘

‘

rs6010620
TOTAL # 1kgSNPs

13
13

2
2

Running summary however will output a slightly diﬀerent report yet just as informative.
At three diﬀerent Rsquare cutoﬀs (0.1, 0.5, 0.9), the summary output illustrates the tagSNP
with the total number of 1kg SNPs overlapping a total number of biofeatures. For example,
at Rsquare ≥ 0.5, tagSNP ‘rs6010620’ is assocated with 53 diﬀerent 1kg SNPs which overlap
at least one biofeature, and 11 of them overlap at least two biofeatures.

Each newly identiﬁed 1kg SNP is now deﬁned as putative functional SNP since they are
in LD to an associated tagSNP and they overlap at least one interesting biological feature.
Thus, each 1kg SNP can now be deﬁned as ‘YAFSNP’ or ‘putative functional SNP.’

4 Annotating newly identiﬁed putative functional SNPs

All known genomic features (exon, intron, 5’UTR, 3’UTR, promoter, lincRNA or in gene
desert (intergentic)) are used to annotate each newly identiﬁed YAFSNP as described above.
Information stored in this glioma.anno is used for all summary plots, table, and to output
results in BED format (see following sections for more details). The following step will output
the data.frame.

> glioma.anno <- FunciSNPAnnotateSummary(glioma);
> class(glioma.anno);

[1] "data.frame"

> gl.anno <- glioma.anno;
> ## remove rownames for this example section.
> rownames(gl.anno) <- c(1:length(rownames(gl.anno)))
> dim(gl.anno);

[1] 2470

28

> names(gl.anno);

[1] "chromosome"
[3] "bio.feature.end"
[5] "corr.snp.id"
[7] "tag.snp.id"
[9] "D.prime"
[11] "p.value"
[13] "population.count"
[15] "nearest.lincRNA.ID"
[17] "nearest.lincRNA.coverage"

"bio.feature.start"
"bio.feature"
"corr.snp.position"
"tag.snp.position"
"R.squared"
"distance.from.tag"
"population"
"nearest.lincRNA.distancetoFeature"
"nearest.TSS.refseq"

10

[19] "nearest.TSS.GeneSymbol"
[21] "nearest.TSS.coverage"
[23] "Promoter"
[25] "Exon"
[27] "utr3"

"nearest.TSS.ensembl"
"nearest.TSS.distancetoFeature"
"utr5"
"Intron"
"Intergenic"

> head(gl.anno[, c(1:18,20:28)]);

chromosome bio.feature.start bio.feature.end

1
2
3
4
5
6

5
5
5
5
5
5

1200710
1211569
1211569
1211569
1211569
1221979

bio.feature
1201809 knownGene.Promoters.known
EncodeFaire.known
1212494
EncodeFaire.known
1212494
EncodeFaire.known
1212494
EncodeFaire.known
1212494
EncodeFaire.known
1222994

corr.snp.id corr.snp.position tag.snp.id tag.snp.position D.prime
NA
1
NA
1
NA
1

1201778 rs2736100
1212406 rs2736100
1212431 rs2736100
1212445 rs2736100
1212490 rs2736100
1221997 rs2736100

1 chr5:1201778
2 chr5:1212406
3 chr5:1212431
4 chr5:1212445
5 chr5:1212490
6 chr5:1221997

1286516
1286516
1286516
1286516
1286516
1286516

R.squared p.value distance.from.tag population.count population
ASN
-84738
ASN
-74110
ASN
-74085
ASN
-74071
ASN
-74026
ASN
-64519

1
NA
2 0.002275140
3
NA
4 0.002275140
5
NA
6 0.002700915

286
286
286
286
286
286

1
1
1
1
1
1

1
2
3
4
5
6

1
2
3
4
5
6

nearest.lincRNA.ID nearest.lincRNA.distancetoFeature nearest.lincRNA.coverage
upstream
upstream
upstream
upstream
upstream
upstream

TCONS_00010241
TCONS_00010241
TCONS_00010241
TCONS_00010241
TCONS_00010241
TCONS_00010241

-40360
-50988
-51013
-51027
-51072
-60579

nearest.TSS.refseq nearest.TSS.ensembl nearest.TSS.coverage
inside
inside
inside
inside
inside
upstream

ENST00000304460
ENST00000304460
ENST00000304460
ENST00000304460
ENST00000304460
ENST00000324642

NM_001003841
NM_001003841
NM_001003841
NM_001003841
NM_001003841
NM_182632

11

nearest.TSS.distancetoFeature Promoter utr5 Exon Intron utr3 Intergenic
NO
NO
NO
NO
NO
NO

NO YES
NO
NO
NO YES
NO YES
NO YES
NO YES

69
10697
10722
10736
10781
-3472

YES
NO
NO
NO
NO
NO

NO
YES
NO
NO
NO
NO

NO
NO
NO
NO
NO
NO

1
2
3
4
5
6

> summary(gl.anno[, c(1:18,20:28)]);

chromosome
Length:2470
Class :character
Mode :character

bio.feature.start
Min.
: 1190775
1st Qu.: 22102754
Median : 62315624
: 56309305
Mean
3rd Qu.: 62365185
:118574381
Max.

bio.feature.end
Min.
: 1191397
1st Qu.: 22103702
Median : 62324005
: 56311568
Mean
3rd Qu.: 62366592
:118574590
Max.

bio.feature
EncodeDnaseI_only.known
: 463
EncodeDnaseI_withCTCF.known: 10
:1016
EncodeFaire.known
knownGene.Promoters.known : 420
: 13
TFBS_Nrsf_U87
: 548
TFBS_Pol2_U87

corr.snp.id
4
4
4
4
4
4
:2446

rs1291208 :
rs1291209 :
rs1295810 :
rs143566670:
rs183316902:
rs186971726:
(Other)

D.prime

Min.
:0.0037
1st Qu.:0.8934
Median :1.0000
Mean
:0.8594
3rd Qu.:1.0000
:1.0000
Max.
’
:1427
s
NA

corr.snp.position
Min.
: 1190800
1st Qu.: 22102896
Median : 62317710
Mean
: 56310408
3rd Qu.: 62365808
:118574557
Max.

R.squared

Min.
:0.0000
1st Qu.:0.0010
Median :0.0045
Mean
:0.0933
3rd Qu.:0.0259
:0.9776
Max.
’
:1427
s
NA

tag.snp.position
Min.
: 1286516
1st Qu.: 22068652
Median : 62309839
Mean
: 56305808
3rd Qu.: 62309839
:118477367
Max.

distance.from.tag population.count population
:-100000
Min.
1st Qu.: -31474
Median : 13384
4600
:
Mean
3rd Qu.: 30547
: 99950
Max.

:286.0
Min.
1st Qu.:379.0
Median :379.0
:365.3
Mean
3rd Qu.:379.0
:379.0
Max.

ASN: 365
EUR:2105

nearest.lincRNA.ID nearest.lincRNA.distancetoFeature

12

tag.snp.id
rs2736100: 365
rs4977756: 418
rs498872 : 432
rs6010620:1255

p.value

:0.0000
Min.
1st Qu.:1.0000
Median :1.0000
:0.8198
Mean
3rd Qu.:1.0000
:1.0000
Max.

TCONS_00010241: 365
TCONS_00015797: 418
TCONS_00020001: 432
TCONS_00027984: 88
TCONS_00028269:1167

:-266862
Min.
1st Qu.: -85894
Median : 57458
9749
:
Mean
3rd Qu.: 79664
: 246019
Max.

nearest.lincRNA.coverage
downstream:1564
inside
: 21
upstream : 885

nearest.TSS.refseq

nearest.TSS.ensembl

:600
NM_003823
NM_004936
:366
NM_001144758:232
:129
NM_020062
:112
NM_017806
:106
NM_007180
:925
(Other)

ENST00000480273:600
ENST00000276925:366
ENST00000361465:232
ENST00000266077:129
ENST00000486025:112
ENST00000264029:106
:925
(Other)

nearest.TSS.coverage nearest.TSS.distancetoFeature Promoter
NO :2205
downstream: 195
YES: 265
: 865
inside
upstream :1410

Min.
:-156104.0
1st Qu.: -9952.0
-709.5
Median :
: -10244.2
Mean
4161.0
3rd Qu.:
: 30391.0
Max.

utr5

NO :2296
YES: 174

Exon

NO :2219
YES: 251

Intron
NO : 842
YES:1628

utr3

NO :2189
YES: 281

Intergenic
NO :2128
YES: 342

> rm(gl.anno);

As you can see, each tagSNP (‘tag.snp.id’) is associated with an identiﬁable YAFSNP
(‘corr.snp.id’) and each are associated with a biological feature (‘bio.feature’). Additional
columns are included which assist in summarizing the ﬁnal results.

Now, if you prefer, you can use several functions to help summarize and plot the ﬁnal
analysis or you can use your own set of scripts to further summarize the results. Either case,
the ﬁnal results are stored in glioma.anno.

5 Summarize FunciSNP results

The following sections describe methods to summarize and plot the newly identiﬁed YAFS-
NPs.

13

5.1 Summary table used to describe newly identiﬁed YAFSNPs

Using a speciﬁed Rsquare value (0-1) to subset the data, a table is generated which sum-
marizes the total number of YAFSNPs, associated tagSNPs, and number of overlapping
biofeatures. This will provide user a ﬁrst look at the total number of available YAFSNP at
a particular Rsquare cutoﬀ.

The output is very similar to the output generated by calling glioma. But instead of
getting a summary report three distinct Rsquare cutoﬀs, you can now specify the Rsquare
cutoﬀs. In this case, we used rsq = 0.44 (to get a more objective rsq value, see ﬁgure 1 on
page 17.

> FunciSNPtable(glioma.anno, rsq=0.44);

tagSNPs
1K SNPs
Biofeatures

Total R.sq>=0.44 Percent
4 100.00
3.88
83.33

4
1855
6

72
5

If ‘geneSum’ argument is set to ‘TRUE’, a list of gene names is reported instead which
informs on the nearest gene symbols to the set of YAFSNPs. Only unique gene symbols are
reported since multiple distinct YAFSNP can be near the same gene.

> FunciSNPtable(glioma.anno, rsq=0.44, geneSum=TRUE);

Gene_Names
ARFRP1
CDKN2B
LIME1
PHLDB1
RTEL1
SLC2A4RG
STMN3
TERT
TNFRSF6B
TREH

1
2
3
4
5
6
7
8
9
10

5.2 Summary of correlated SNPs overlapping biofeatures

FunciSNPsummaryOverlaps function helps to determine the total number of YAFSNPs over-
lapping a number of diﬀerent biofeatures. This is similar to running summary on glioma
above, except now you can speciﬁcally call the function and set a pre-determined ‘rsq’ value
to subset the data and thereby obtain a more objective and informative result.

> FunciSNPsummaryOverlaps(glioma.anno)

14

rs2736100
rs4977756
rs498872
rs6010620
TOTAL # 1kgSNPs

bio.1 bio.2 bio.3 bio.4
0
0
0
9
9

10
43
34
115
202

128
112
124
431
795

1
1
4
31
37

Using a ‘rsq’ value, the output is subsetted to summarize the results with Rsquare values

≥ ‘rsq’.

> FunciSNPsummaryOverlaps(glioma.anno, rsq=0.44)

rs2736100
rs4977756
rs498872
rs6010620
TOTAL # 1kgSNPs

bio.1 bio.2 bio.3 bio.4
0
0
0
3
3

1
9
7
55
72

0
3
3
13
19

0
0
0
7
7

5.3 Summary of correlated SNPs for a number of diﬀerent tagSNPs

After running FunciSNPsummaryOverlaps, the next question one would like to know is which
correlated SNPs overlapping a number of diﬀerent biofeatures for a number of associated
tagSNP. Thus, in the example above, we have determined that we are interested in learning
more about the YAFSNPs associated with ‘rs6010620’ and which overlap at least 3 diﬀerent
biofeatures.

> rs6010620 <- FunciSNPidsFromSummary(glioma.anno, tagsnpid="rs6010620",
+ num.features=2, rsq=0.44);
> #summary(rs6010620);
> dim(rs6010620);

[1] 36 28

> class(rs6010620);

[1] "data.frame"

> ## See FunciSNPbed to visualize this data in a genome browser.

15

6 Plot FunciSNP results

6.1 Default plot

FunciSNPplot is a function developed to plot various types of plots to summarize and assist
end-user in making informed discoveries of FunciSNP results. Plots can be stored in a folder
for future reference. Most plots were created in with the idea that they can be directly
outputted in presentations or publication formats.

The following example plots the distribution of the Rsquare values for each YAFSNP
(Figure 1, page 17). We recommend attempting this plot before subsetting any data by
a speciﬁed rsq value. The distribution helps to identify a speciﬁc Rsquare value that will
provide the most informative discovery.

> pdf("glioma_dist.pdf")
> FunciSNPplot(glioma.anno)
> dev.off()

null device
1

Figure 1 (page 17) illustrates the total number of YAFSNPsbinned at diﬀerent Rsquare
cutoﬀs. As you can see in this ﬁgure (1, page 17), there are a total of 13 YAFSNP with an
Rsquare ≥ 0.9. Since this plot does not take into consideration unique YAFSNP the number
may represent duplicate YAFSNP since they may overlap more than one biological feature.

6.2 Split by tagSNP

Using ‘splitbysnp’ argument, the same type of plot as above (Figure 1, page 17) is generated,
however the total number of YAFSNPs are now divided by the associated tagSNP (Figure 2,
page 18). It should be clear from this plot that 3 of the 4 tagSNP have a number of YAFSNP
with Rsquares ≥ 0.5. And one tagSNP contains many more YAFSNP (‘rs6010620’).

> FunciSNPplot(glioma.anno, splitbysnp=TRUE)
> ggsave("glioma_dist_bysnp.pdf")

6.3 Heatmap of 1kg SNPs by tagSNP vs Biofeature

Now, if you are interested in knowing which biofeature and associated tagSNP contains the
most number of 1kg SNPs, run the following.

> pdf("glioma_heatmap.pdf")
> FunciSNPplot(glioma.anno, heatmap=TRUE, rsq = 0.1)
> dev.off()

pdf
2

16

Figure 1: Distribution of Rsquare values of all YAFSNPs. Each marked bin contains the
total number of YAFSNPs (correlated SNPs). The sum of all the counts would total the
number of correlated SNPs.

6.4 TagSNP and Biofeature Summary

Using ‘tagSummary’ argument will automatically save all plots in a speciﬁc folder. This is
done because this function will generate a summary plot for each biofeature. The ﬁrst plot
(Figure 4, page 20) is a scatter plot showing the relationship between Rsquare and Distance
to tagSNP for each YAFSNP.

> ## Following will output a series of plots for each biofeature at rsq=0.5
> FunciSNPplot(glioma.anno, tagSummary=TRUE, rsq=0.5)

Finished plotting 1 / 6
Finished plotting 2 / 6

17

*********************************************************************************************************************************************************************************************************************************************************************************************************************************************************************0.00.20.40.60.81.0020406080100120Distribution of 1kgSNPs by R² valuesTotal # of 1kgSNPs: 2470(with an Rsq value: 1043; unique 1kgSNPs: 795)R² values (0−1)Number of 1kgSNPs88229249287640513Figure 2: Distribution of Rsquare values of all YAFSNPs divided by the tagSNP and by its
genomic location.

Finished plotting 3 / 6
Finished plotting 4 / 6
Finished plotting 5 / 6
Finished plotting 6 / 6

Figure 4 on page 20 helps identify the relative postion of all newly identiﬁed YAFSNP
to the associated tagSNP. As highlighted in ﬁgure 4, it is clear that tagSNP ‘rs6010620’
contains many more YAFSNP with Rsquares ≥ 0.5, and the majority of them are within
40,000 base pairs of the tagSNP. There are a few YAFSNP which are more than 50,000 base
pairs away while some are within 5,000 base pairs.

The second plot (Figure 5, page 21) is a histogram distribution of total number of YAF-
SNPs at each Rsquare value. This plot is similar to Figure 2 on page 18, except it is further

18

5rs27361009rs497775611rs49887220rs60106200.000.250.500.751.000.000.250.500.751.00010020030040001002003004001kgSNPs R² to tagSNP (0−1)Total # of 1kgSNPs associated with tagSNPDistribution of 1kgSNPs for each tagSNPat R² valuesFigure 3: Heatmap of the number of 1kg SNPs by relationship between tagSNP and biofea-
ture.

divided by biofeature. Each set of plot is further divided by tagSNP to help identify locus
with the most identiﬁable YAFSNP. This argument is best used in conjunction with a ‘rsq’
value.

6.5 Genomic Feature Summary

Using ‘genomicSum’ argument set to ‘TRUE’ will output the overall genomic distribution
of the newly identiﬁed YAFSNPs (Figure 6, page 22). Using ‘rsq’ value, the plot is divided
into all YAFSNPs vs subset. This type of plot informs the relative enrichment for genomic
features.

19

EncodeDnaseI_only.knownEncodeDnaseI_withCTCF.knownEncodeFaire.knownknownGene.Promoters.knownTFBS_Nrsf_U87TFBS_Pol2_U87rs6010620rs2736100rs4977756rs498872010203040tagSNP vs Biofeature1kgSNP with R² >= 0.1Figure 4: Scatter plot showing the relationship between Rsquare and Distance to tagSNP
for each getFSNPs

> pdf("glioma_genomic_sum_rcut.pdf")
> FunciSNPplot(glioma.anno, rsq=0.5, genomicSum=TRUE, save=FALSE)
> dev.off()

pdf
2

Figure 6 on page 22 illustrates the distribution of the YAFSNP by genomic features. It
is clear by using an Rsquare cutoﬀ of 0.5, there is a slight enrichment of YAFSNP in introns
and exonds and a depletion at promoters and other coding regions as well as intergentic
regions.

20

llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll11rs49887220rs60106205rs27361000.000.250.500.751.000.000.250.500.751.000.000.250.500.751.00−50,000−25,000025,00050,000R² Values (0−1)Distance to 1kgSNPs associated with tagSNP (bp)Distance between tagSNP and 1kgSNPOverlapping biofeature: TFBS_Pol2_U87Figure 5: Histogram distribution of number of correlated SNPs at each Rsquare value

7 Visualize FunciSNP results in a genomic browser

(outputs BED format)

Finally, after evaluating all results using the above tables and plots functions, a unique
pattern emerges that helps identify a unique cluster of tagSNP and biofeature that can
identify a set of YAFSNPs. To better visualize and to get a better perspective of the location
of each newly identiﬁed YAFSNP, the results can be outputted using FunciSNPbed .

FunciSNPbed outputs a unique BED ﬁle which can be used to view in any genomic
browser which supports BED formats. To learn more about BED formats, see UCSC Genome
Browser FAQ (http://genome.ucsc.edu/FAQ/FAQformat).

> ## will output to current working directory.
> FunciSNPbed(glioma.anno, rsq=0.22);

21

11rs49887220rs60106205rs27361000.000.250.500.751.000.000.250.500.751.000.000.250.500.751.00050100150R² Values (0−1)Total # of 1kgSNPs associated with riskSNPDistribution of 1kgSNPs R²divided by tagSNP & Overlapping biofeature: TFBS_Pol2_U87Figure 6:
Stacked bar chart summarizing all correlated SNPs for each of the identiﬁed
genomie features: exon, intron, 5UTR, 3UTR, promoter, lincRNA or in gene desert. Rsquare
cutoﬀ at 0.5. This plot is most informative if used with a rsq value.

Total corSNP (RED): 103
Total tagSNP (BLK): 4

> # FunciSNPbed(rs6010620, rsq=0.5);

Each tagSNP which is in LD to a corresponding YAFSNP overlapping at least one biofea-
ture is colored black, while the YAFSNP is colored red. The initial position is provided by
the ﬁrst tagSNP and the ﬁrst linked YAFSNP. We recommend using UCSC genome browser
to view your BED ﬁles. This is useful so you can view all public and private tracks in rela-
tion to FunciSNP results. As an example, see Figure 7 on page 23 or visit this saved UCSC
Genome Browser session: http://goo.gl/xrZPD.

22

All 1kgSNPsR² >= 0.5Promoterutr5ExonIntronutr3IntergenicPromoterutr5ExonIntronutr3Intergenic0.000.250.500.751.00Percent of Total 1kgSNPs at R² cut−offOverlap1.YES2.NODistribution of 1kgSNP SNPs across Genomic Features  at R² cut−off of 0.5Figure 7: FunciSNP results viewed in UCSC genome browser. Top track represents Fun-
ciSNP results, second track is the known GWAS hits.

8 Contact information

Questions or comments, please contact Simon G. Coetzee (scoetzee NEAR gmail POINT
com) or Houtan Noushmehr, PhD (houtan NEAR usp POINT br).

9 sessionInfo

(cid:136) R version 3.5.1 Patched (2018-07-12 r74967), x86_64-pc-linux-gnu

(cid:136) Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_US.UTF-8,
LC_COLLATE=C, LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8,
LC_PAPER=en_US.UTF-8, LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C,
LC_MEASUREMENT=en_US.UTF-8, LC_IDENTIFICATION=C

(cid:136) Running under: Ubuntu 16.04.5 LTS

23

(cid:136) Matrix products: default

(cid:136) BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so

(cid:136) LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so

(cid:136) Base packages: base, datasets, grDevices, graphics, methods, parallel, stats, stats4,

utils

(cid:136) Other packages: AnnotationDbi 1.44.0, Biobase 2.42.0, BiocGenerics 0.28.0,

FunciSNP 1.26.0, FunciSNP.data 1.17.0, GenomeInfoDb 1.18.0,
GenomicFeatures 1.34.0, GenomicRanges 1.34.0, IRanges 2.16.0, S4Vectors 0.20.0,
TxDb.Hsapiens.UCSC.hg19.knownGene 3.2.2, ggplot2 3.1.0

(cid:136) Loaded via a namespace (and not attached): AnnotationFilter 1.6.0,

BSgenome 1.50.0, BiocManager 1.30.3, BiocParallel 1.16.0, Biostrings 2.50.0,
ChIPpeakAnno 3.16.0, DBI 1.0.0, DelayedArray 0.8.0, GO.db 3.7.0,
GenomeInfoDbData 1.2.0, GenomicAlignments 1.18.0, MASS 7.3-51, Matrix 1.2-14,
ProtGenerics 1.14.0, R6 2.3.0, RBGL 1.58.0, RCurl 1.95-4.11, RSQLite 2.1.1,
Rcpp 0.12.19, Rsamtools 1.34.0, SummarizedExperiment 1.12.0,
VariantAnnotation 1.28.0, VennDiagram 1.6.20, XML 3.98-1.16, XVector 0.22.0,
ade4 1.7-13, assertthat 0.2.0, bindr 0.1.1, bindrcpp 0.2.2, biomaRt 2.38.0, bit 1.1-14,
bit64 0.9-7, bitops 1.0-6, blob 1.1.1, colorspace 1.3-2, compiler 3.5.1, crayon 1.3.4,
curl 3.2, digest 0.6.18, dplyr 0.7.7, ensembldb 2.6.0, formatR 1.5, futile.logger 1.4.3,
futile.options 1.0.1, glue 1.3.0, graph 1.60.0, grid 3.5.1, gtable 0.2.0, hms 0.4.2,
httr 1.3.1, idr 1.2, labeling 0.3, lambda.r 1.2.3, lattice 0.20-35, lazyeval 0.2.1,
limma 3.38.0, magrittr 1.5, matrixStats 0.54.0, memoise 1.1.0, multtest 2.38.0,
munsell 0.5.0, pillar 1.3.0, pkgconﬁg 2.0.2, plyr 1.8.4, prettyunits 1.0.2, progress 1.2.0,
purrr 0.2.5, regioneR 1.14.0, reshape 0.8.8, rlang 0.3.0.1, rtracklayer 1.42.0,
scales 1.0.0, seqinr 3.4-5, snpStats 1.32.0, splines 3.5.1, stringi 1.2.4, stringr 1.3.1,
survival 2.43-1, tibble 1.4.2, tidyselect 0.2.5, tools 3.5.1, withr 2.1.2, zlibbioc 1.28.0

Our recent paper describing FunciSNP and FunciSNP.data can be found in the Journal
Nucleic Acids Research (doi:10.1093/nar/gks542).
This document was proudly made using LATEXand Sweave.

24

