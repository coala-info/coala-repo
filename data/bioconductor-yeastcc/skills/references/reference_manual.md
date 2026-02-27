Package ‘yeastCC’

February 26, 2026

Version 1.50.0

Title Spellman et al. (1998) and Pramila/Breeden (2006) yeast cell

cycle microarray data

Author Sandrine Dudoit <sandrine@stat.berkeley.edu>

Maintainer Sandrine Dudoit <sandrine@stat.berkeley.edu>

Description ExpressionSet for Spellman et al. (1998) yeast cell cycle microarray experiment

License Artistic-2.0

LazyData yes

Depends Biobase (>= 2.5.5)

biocViews ExperimentData, CellCulture, Saccharomyces_cerevisiae_Data,

CancerData, MicroarrayData, OneChannelData, GEO

git_url https://git.bioconductor.org/packages/yeastCC

git_branch RELEASE_3_22

git_last_commit 7987c0e

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-26

Contents

.
.

.
breeden .
orf800 .
.
.
spYCCmeta .
.
yeastCC .

.

Index

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

. .
. .
. .
. .

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

2
4
5
9

10

1

2

breeden

breeden

Breeden et al. yeast cell cycle experiment

Description

ExpressionSet instance; 50 samples from a 25-sample dye-swap of alpha-synchronized yeast cul-
tures

Usage

data(breeden)

Format

The format is:
Formal class ’ExpressionSet’ [package "Biobase"] with 7 slots
..@ assayData :<environment: 0x10221ebc8>
..@ phenoData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots
.. .. ..@ varMetadata :’data.frame’: 37 obs. of 1 variable:
.. .. .. ..$ labelDescription: chr [1:37] NA NA NA NA ...
.. .. ..@ data :’data.frame’: 50 obs. of 37 variables:
.. .. .. ..$ title : Factor w/ 50 levels "Yeast cell cycle-time point 0 min 2001-08-17_0000.rfm Yeast
W303 cells",..: 1 29 3 15 17 19 21 23 25 27 ...
.. .. .. ..$ geo_accession : Factor w/ 50 levels "GSM112133","GSM112134",..: 1 2 3 4 5 6 7 8 9 10
...
.. .. .. ..$ status : Factor w/ 1 level "Public on Aug 05 2006": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ submission_date : Factor w/ 1 level "Jun 01 2006": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ last_update_date : Factor w/ 1 level "Jun 23 2006": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ type : Factor w/ 1 level "RNA": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ channel_count : Factor w/ 1 level "2": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ source_name_ch1 : Factor w/ 25 levels "Yeast cell cycle-time point 0 min",..: 1 15 2 8 9
10 11 12 13 14 ...
.. .. .. ..$ organism_ch1 : Factor w/ 1 level "Saccharomyces cerevisiae": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ characteristics_ch1 : Factor w/ 25 levels "Yeast cell cycle-time point 0 min",..: 1 15 2 8 9
10 11 12 13 14 ...
..
..$ treatment_protocol_ch1 : Factor w/ 1 level "Cells were arrested with alpha factor,and
released into YEPD to get a synchronized population. Cells were sampled every 5 min a"| __trun-
cated__: 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ molecule_ch1 : Factor w/ 1 level "total RNA": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ label_ch1 : Factor w/ 2 levels "Cy3","Cy5": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ source_name_ch2 : Factor w/ 1 level "Yeast asynchronous culture": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ organism_ch2 : Factor w/ 1 level "Saccharomyces cerevisiae": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ characteristics_ch2 : Factor w/ 1 level "Yeast asynchronous culture": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ treatment_protocol_ch2 : Factor w/ 1 level "Cells were grown overnight to an OD of 0.6
in YEPD": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ molecule_ch2 : Factor w/ 1 level "total RNA": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ label_ch2 : Factor w/ 2 levels "Cy3","Cy5": 2 2 2 2 2 2 2 2 2 2 ...
.. .. .. ..$ description : Factor w/ 1 level "Yeast cell cycle": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ data_processing : Factor w/ 1 level "normalized log ratio using Rosetta Resolver": 1 1 1 1
1 1 1 1 1 1 ...
.. .. .. ..$ platform_id : Factor w/ 1 level "GPL1914": 1 1 1 1 1 1 1 1 1 1 ...

..

..

breeden

3

.. .. .. ..$ contact_name : Factor w/ 1 level "Tata„Pramila": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ contact_email : Factor w/ 1 level "tpramila@fhcrc.org": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ contact_phone : Factor w/ 1 level "(206)6674483": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ contact_laboratory : Factor w/ 1 level "Breeden Lab": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ contact_department : Factor w/ 1 level "Basic Sciences": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ contact_institute : Factor w/ 1 level "FHCRC": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ contact_address : Factor w/ 1 level "1100, Fairview Avenue N": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ contact_city : Factor w/ 1 level "Seattle": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ contact_state : Factor w/ 1 level "WA": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ contact_zip/postal_code: Factor w/ 1 level "98109": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ contact_country : Factor w/ 1 level "USA": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ supplementary_file : Factor w/ 50 levels "ftp://ftp.ncbi.nih.gov/pub/geo/DATA/supplementary/samples/GSM112nnn/GSM112133/GSM112133.gpr.gz",..:
1 2 3 4 5 6 7 8 9 10 ...
.. .. .. ..$ data_row_count : Factor w/ 1 level "6228": 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ mins : num [1:50] 0 5 10 15 20 25 30 35 40 45 ...
.. .. .. ..$ sign : num [1:50] 1 1 1 1 1 1 1 1 1 1 ...
.. .. ..@ dimLabels : chr [1:2] "sampleNames" "sampleColumns"
.. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots
..@ featureData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots
.. .. ..@ varMetadata :’data.frame’: 10 obs. of 3 variables:
.. .. .. ..$ Column : chr [1:10] "ID" "ORF" "SPOT_ID" "Gene" ...
.. .. .. ..$ Description : Factor w/ 2 levels ""," LINK_PRE:\"http://www.ncbi.nlm.nih.gov/entrez/query.fcgi?CMD=search&DB=gene&cmd=search&term=\"
LINK_SUF:\"[gene name]\"": 1 2 1 1 1 1 1 1 1 1
.. .. .. ..$ labelDescription: chr [1:10] NA NA NA NA ...
.. .. ..@ data :’data.frame’: 6228 obs. of 10 variables:
.. .. .. ..$ ID : Factor w/ 6337 levels "YPR105C","YPR106W",..: 116 6322 119 6327 124 133 6328
6329 6330 6331 ...
..
6221 6221 6221 6221 6221 ...
.. .. .. ..$ SPOT_ID : chr [1:6228] "<blank>" "blank" "E. coli control" "empty" ...
.. .. .. ..$ Gene : Factor w/ 3347 levels "","AOS1","APG13",..: 1 1 1 1 1 1 1 1 1 1 ...
.. .. .. ..$ SGDID : Factor w/ 6205 levels "S0006309","S0006310",..: 1001 1001 1001 1001 1001
1001 1001 1001 1001 1001 ...
.. .. .. ..$ CHR : Factor w/ 17 levels "XVI","XV","XIV",..: 13 13 13 13 13 13 13 13 13 13 ...
.. .. .. ..$ ORF.Length: chr [1:6228] "" "" "" "" ...
.. .. .. ..$ Process : Factor w/ 488 levels "DNA repair*",..: 194 194 194 194 194 194 194 194 194
194 ...
.. .. .. ..$ Function : Factor w/ 760 levels "CDP-diacylglycerol-inositol 3-phosphatidyltransferase",..:
215 215 215 215 215 215 215 215 215 215 ...
.. .. .. ..$ Component : Factor w/ 211 levels "19S proteasome regulatory particle",..: 90 90 90 90 90
90 90 90 90 90 ...
.. .. ..@ dimLabels : chr [1:2] "featureNames" "featureColumns"
.. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots
.. .. .. .. ..@ .Data:List of 1
.. .. .. .. .. ..$ : int [1:3] 1 1 0
..@ experimentData :Formal class ’MIAME’ [package "Biobase"] with 13 slots
.. .. ..@ name : chr [1:2] "Pramila T" "Breeden LL"
.. .. ..@ lab : chr "Fred Hutchinson Cancer Research Center, Seattle, Washington 98109, USA."
.. .. ..@ contact : chr ""
..
genes and fills the S-phase gap in the transcriptional "| __truncated__
.. .. ..@ abstract : chr "Transcription patterns shift dramatically as cells transit from one phase of

..@ title : chr "The Forkhead transcription factor Hcm1 regulates chromosome segregation

..$ ORF : Factor w/ 6222 levels "YPR105C","YPR106W",..: 6221 6221 6221 6221 6221

..

..

..

4

orf800

the cell cycle to another. To better define this t"| __truncated__
.. .. ..@ url : chr "http://labs.fhcrc.org/breeden/cellcycle/index.html"
.. .. ..@ pubMedIds : chr "16912276"
.. .. ..@ samples : list()
.. .. ..@ hybridizations : list()
.. .. ..@ normControls : list()
.. .. ..@ preprocessing : list()
.. .. ..@ other : list()
.. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots
.. .. .. .. ..@ .Data:List of 1
.. .. .. .. .. ..$ : int [1:3] 1 0 0
..@ annotation : chr(0)
..@ protocolData :Formal class ’AnnotatedDataFrame’ [package "Biobase"] with 4 slots
.. .. ..@ varMetadata :’data.frame’: 0 obs. of 1 variable:
.. .. .. ..$ labelDescription: chr(0)
.. .. ..@ data :’data.frame’: 50 obs. of 0 variables
.. .. ..@ dimLabels : chr [1:2] "sampleNames" "sampleColumns"
.. .. ..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots
.. .. .. .. ..@ .Data:List of 1
.. .. .. .. .. ..$ : int [1:3] 1 1 0
..@ .__classVersion__:Formal class ’Versions’ [package "Biobase"] with 1 slots
.. .. ..@ .Data:List of 4
.. .. .. ..$ : int [1:3] 2 10 0
.. .. .. ..$ : int [1:3] 2 5 5
.. .. .. ..$ : int [1:3] 1 3 0
.. .. .. ..$ : int [1:3] 1 0 0

Details

Retrieved from GEO using getGEO in package GEOquery, August 27 2009. Variables mins and
sign added to pData manually.

Source

PMID 16912276; see url slot of experimentData slot.

Examples

data(breeden)
#
# show how to use the dye-swap 'sign' variable
#
plot(exprs(breeden)["YBL002W",]~breeden$mins)
plot(I(exprs(breeden)["YBL002W",]*breeden$sign)~breeden$mins)

orf800

Cell cycle regulated genes from Spellman et al. (1998)

spYCCmeta

Description

5

Vector of ORF names for the 800 cell cycle regulated genes identified by the analysis of Spellman
et al. (1998). The expression measures and sample descriptions are stored in the ExpressionSet
instance yeastCC.

Usage

data(orf800)

Format

The format is: chr [1:800] "YAL022C" "YAL040C" "YAL053W" "YAL067C" "YAR003W" "YAR007C"
...

Source

The 800 ORF names were obtained from the file "CellCycle98.xls" on the Yeast Cell Cycle Anal-
ysis Project website (http://genome-www.stanford.edu/cellcycle/). The raw data (images,
TIFF) and processed data "combine.txt" used to create the ExpressionSet instance yeastCC are
also available on the website. Gene annotation information is available from the Saccharomyces
Genome Database (SGD, http://genome-www.stanford.edu/Saccharomyces/gene_list.shtml).
The script "createYeastCC.R" for generating the yeastCC package is available in ../doc.

References

Spellman et al. (1998). Comprehensive Identification of Cell Cycle-regulated Genes of the Yeast
Saccharomyces cerevisiae by Microarray Hybridization. Molecular Biology of the Cell, 9: 3273-
3297 (../doc).

Examples

data(orf800)

spYCCmeta

metadata on yeast cell cycle microarray experiment

Description

data.frame instance with metadata on 800 genes

Usage

data(spYCCmeta)

Format

A data frame with 800 observations on the following 75 variables.

Process a factor with levels 4-nitroquinoline-N-oxide resistance ATP synthesis ...
Function a factor with levels (1->6)-beta-glucan synthase subunit (putative) Glc7p regulatory

subunit ...
X a logical vector

6

spYCCmeta

Peak a factor with levels G1 G2/M M/G1 S S/G2
Phase.Order a numeric vector
Cluster.Order a numeric vector
ORF a factor with levels YAL022C YAL040C YAL053W YAL067C YAR003W YAR007C ...
YPD a factor with levels AAD10 ACE2 ADA2 ADK2 AFR1 AGA1 AGA2 AGP1 ...
SGD a factor with levels AAD10 ACE2 ADA2 ADK2 AFR1 AGA1 AGA2 ...
YPD.1 a factor with levels YPD
SGD.1 a factor with levels SGD
MIPS a factor with levels MIPS
n1 a numeric vector
n2 a numeric vector
Geomean a numeric vector
Absolute a numeric vector
g1 a numeric vector
g2 a numeric vector
Geomean.1 a numeric vector
Absolute.1 a numeric vector
Deletion a factor with levels irrelevant lethal undocumented viable
Known. a factor with levels Known New New
Description a factor with levels Inhibitor of Cdc28p/Cln1p and Cdc28p/Cln2p complexes

involved in cell cycle arrest for mating 1,3-beta-D-glucan synthase 3\'-Phosphoadenylylsulfate
reductase; part of the sulfate assimilation pathway ...

Aggregate.Score a numeric vector
Phase a numeric vector
No..Elements a numeric vector
Most.Relevant.Promoter.Elements a factor with levels AATAGATGACCCGATTTGGAAAAAGGTAAACAACAATG
ATTTGATTGCCGAAAGAGGCAAAAC GTAAATAGGTTGT C 156 TCTGCCAGCCAA C 253 AAAGCCAGCCAT C
256 TATGCCAGCCAA C 276 AAGGCCAGCCTC C 293 TTGACCAGCTAA ...

X.1 a factor with levels ATATAGCGACCGAATCAGGAAAAG GTCAACAACGAAG C 102 CGAGCCAGCATT C

252 AAGACCAGCATG C 301 AGTGCCAGCAAA C 496 GAAGCCAGCACA C 550 GCGGCCAGCAAC c 106 attACGCGaaaat
c 112 aaaACGCGagaaa c 121 ggaACGCGacgc ...

X.2 a factor with levels C 125 GCAACCAGCTCT C 146 CAAGCCAGCCAT C 195 CGCACCAGCAAC C 212

TATACCAGCGTT C 245 TAAACCAGCGCA C 402 TATGCCAGCAAA c 112 ttaACGCGatcga c 115 agtACGCGaaagg
c 123 acaACGCGaacac c 127 gtgACGCGaaaaa ...

X.3 a factor with levels C 307 AAGACCAGCATT c 163 ctgACGCGcgaaa c 190 aatACGCGagaaa c 220
tagACGCGcctta c 241 cgaACGCGaaact c 275 aaaACGCGaccgt c 282 aagACGCGatttt c 289
attACGCGcatta c 290 aggACGCGaaact ...

X.4 a factor with levels C 200 CAAACCAGCATC c 117 gtcACGCGaaaaa c 314 cctACGCGaaagt c 338
caaACGCGaaaaa c 359 acgACGCGccttc c 382 gttACGCGaagtc c 384 tcaACGCGaattt c 397
aaaACGCGaaaac c 440 gtgACGCGcggtt ...

X.5 a factor with levels C 306 GGAGCCAGCGCG c 467 accACGCGaaaag c 588 gaaACGCGccaaa w 266

ATAACCAGCAAA w 383 cagACGCGagaac w 478 GGAGCCAGCGCG w401 tatCGCGAAAatt

X.6 a factor with levels C 337 AGAGCCAGCAAG C 417 TCGGCCAGCAAT c 501 acaACGCGaaaaa w 370

gcgACGCGaaaaa w 447 AGAGCCAGCAAG

spYCCmeta

7

X.7 a factor with levels C 388 GGAACCAGCAGA w 396 GGAACCAGCAGA
Number a numeric vector
SCB a factor with levels c 103 gacCACGAAAttt c 105 atgCACGAAAaag c 106 ctaCACGAAAcac c
108 tacCACGAAAgta c 110 ccaCACGAAAaga c 123 agaCACGAAAtgt c 127 acaCACGAAAacg c
181 cagCACGAAAtgg ...

SCB.1 a factor with levels c178 tgaCACGAAAaac c232 gaaCACGAAAtgc c539 gtaCACGAAAttc w269

agcCACGAAAtgc w347 tgaCACGAAAtgt w541 agtCACGAAAcgc w601 tgtCACGAAAagt
SCB.2 a factor with levels c330 aacCACGAAAaaa c582 agtCACGAAAcgc w467 attCACGAAAtaa
SCB.3 a factor with levels w435 atcCACGAAAatc
X.8 a factor with levels w252 aacCACGAAAagt
Number.1 a numeric vector
SCB_d a factor with levels c 156 gatCGCGAAAttt c 184 cgaCGCGAAAatg c 218 cagCGCGAAAagt c
222 tatCGCGAAAaaa c 229 tgaCGCGAAAcgc c 237 tatCGCGAAAcga c 238 atcCGCGAAAgga c
283 aagCGCGAAAcaa ....

SCB_d.1 a factor with levels c 126 tttCGCGAAActg c 415 tttCGCGAAAtct c 566 ttcCGCGAAAaaa

c 592 aggCGCGAAAtac c 633 aaaCGCGAAAtgt c242 gaaCGCGAAActt c297 ctcCGCGAAAaat c306
tcgCGCGAAAaga ...

SCB_d.2 a factor with levels c468 ccaCGCGAAAaga c508 tttCGCGAAAtct
SCB_d.3 a factor with levels c502 caaCGCGAAAaat
Number.2 a numeric vector
MCB a factor with levels w 126 gcaACGCGTcgc w 187 caaACGCGTaca w 207 ctcACGCGTcgg w 209

attACGCGTtta w 226 cagACGCGTtgc w 228 acaACGCGTctt w 23 acaACGCGTgct w 267 cccACGCGTagg
...

MCB.1 a factor with levels w111 gaaACGCGTtct w124 ttgACGCGTttc w128 gtgACGCGTtat w130

agaACGCGTtct w131 gcgACGCGTaac w138 aagACGCGTgaa w139 attACGCGTtta w153 ctaACGCGTttt
...

MCB.2 a factor with levels w374 taaACGCGTcat
MCB.3 a factor with levels w309 aggACGCGTaaa
Number.3 a numeric vector
MCB_d a factor with levels c 106 attACGCGaaaat c 109 acaACGCGactgg c 112 aaaACGCGagaaa
c 115 agtACGCGaaagg c 117 gtcACGCGaaaaa c 121 ggaACGCGacgc c 127 gtgACGCGaaaaa c
129 acaACGCGcccga ...

MCB_d.1 a factor with levels c 123 acaACGCGaacac c 136 aatACGCGattgg c 147 gcaACGCGagaga
c 158 tctACGCGcgaag c 163 ctgACGCGcgaaa c 176 gcgACGCGgttgt c 187 agtACGCGatttg c
189 gaaACGCGggcac ...

MCB_d.2 a factor with levels c 112 ttaACGCGatcga c 220 tagACGCGcctta c 294 ttcACGCGcttaa
c 382 gttACGCGaagtc c 477 gcaACGCGcctgg c 501 acaACGCGaaaaa c 549 attACGCGcacg c
557 tgtACGCGcgaac ...

MCB_d.3 a factor with levels c 617 gaaACGCGcagta w 50 gtaACGCGctttt
X.9 a factor with levels c 359 acgACGCGccttc
Number.4 a numeric vector
SFF a factor with levels AATAGATGACCCGATTTGGAAAAAGGTAAACAACAATG ATTTGATTGCCGAAAGAGGCAAAAC

GTAAATAGGTTGT CAAAACAAACCCAATAAAGAAAATCCAAAATATAGAAC GTACTTTAACCTGTTTAGGAAAAAG
GTAAACAATAACA TCGAACAATTCTAAAAAGGTAAAT AAAAACAATGGTA ...

Number.5 a factor with levels 1 2 3 4 ATATAGCGACCGAATCAGGAAAAGGTCAACAACGAAG

8

spYCCmeta

Swi5 a factor with levels C 102 CGAGCCAGCATT C 156 TCTGCCAGCCAA C 200 CAAACCAGCATC C 252

AAGACCAGCATG C 253 AAAGCCAGCCAT C 256 TATGCCAGCCAA C 276 AAGGCCAGCCTC C 293 TTGACCAGCTAA
...

Swi5.1 a factor with levels C 125 GCAACCAGCTCT C 146 CAAGCCAGCCAT C 195 CGCACCAGCAAC C

245 TAAACCAGCGCA C 301 AGTGCCAGCAAA C 306 GGAGCCAGCGCG C 307 AAGACCAGCATT C 402 TATGCCAGCAAA
...

Swi5.2 a factor with levels C 212 TATACCAGCGTT C 337 AGAGCCAGCAAG c 19 AGAACCAGCTGA c 320

ACCACCAGCTTA c 545 ACCACCAGCGTA c 569 TTCACCAGCGGC c 642 GAGACCAGCGGA c 651 ATCACCAGCAAA
...

Swi5.3 a factor with levels C 388 GGAACCAGCAGA C 417 TCGGCCAGCAAT c 336 TTTACCAGCTCA c

363 TGCACCAGCATT c 494 CTGGCCAGCAAG w 396 GGAACCAGCAGA

Number.6 a numeric vector
Swi5e a factor with levels c 102 CGAGCCAGCATT c 137 TAGGCCAGCAAA c 155 ACAACCAGCAGT c 156

CTAACCAGCAAG c 16 AGAGCCAGCAGA c 174 TAAACCAGCATT c 184 ATGGCCAGCATA c 200 CAAACCAGCATC
...

Swi5e.1 a factor with levels c 222 TTGACCAGCGCC c 256 TAAACCAGCAAA c 306 GGAGCCAGCGCG c

307 AAGACCAGCATT c 637 GGAGCCAGCGAT w 265 TAAACCAGCAAT w 266 ATAACCAGCAAA w 467 TGAGCCAGCAAT
w 478 GGAGCCAGCGCG w 536 GAAACCAGCAAC w 554 ATGGCCAGCACC

Swi5e.2 a factor with levels c 337 AGAGCCAGCAAG c 417 TCGGCCAGCAAT c 642 GAGACCAGCGGA w

447 AGAGCCAGCAAG

Swi5e.3 a factor with levels c 388 GGAACCAGCAGA w 396 GGAACCAGCAGA
Number.7 a numeric vector
ECB a factor with levels c 185 TTACCCATTTAGGAAA c 221 TTACCCAATTAGGAAA c 251 TTTCCCTTTAAGGAAA

c 258 TTTCCCAAAAAGGAAA c 387 TTTCCCTTTTAGGAAA c 394 TTACCCACTTAGGAAA w 154 TTTCCCTTTTAGGAAA
w 177 TTACCCACTTAGGAAA w 229 TTACCCAGAAAGGAAA w 378 TTTCCCTAATAGGAAA w 453 TTTCCCGTTTAGGAAA
w 595 TTTCCCACTAAGGAAA

Number.8 a numeric vector
STE12 a factor with levels c 243 CCTTTTTCAGTTTCTATTTTTAACACTGAAACT w 112 CCCTATTTGGTTGCAATTCAATTCCGTGAAACC

w 119 CCCAATGTAGAAAAGTACATCATATGAAACA w 218 CCTAATTGGGTAAGTACATGATGAAACA w 224
CCCAAAAAGGAAATTTACATGTTAAATGAAACC ...

MIG1.sites a factor with levels c 114 AATAGACTGGGG c 137 TCTATCCTGGGG c 147 TGAATGCTGGGG
c 165 AATAAAGTGGGG c 215 TATAATGCGGGG c 304 AAATCGCCGGGG c 332 AAATATCTGGGG c 368
AATTGCGCGGGG ...

X.10 a factor with levels c 161 AGTTTGGTGGGG c 262 AAGATGGTGGGG c 498 AAAAAACCGGGG c 499

AAAAATGCGGGG w 296 TATTCGGCGGGG w 578 CTTTTGCCGGGG

X.11 a logical vector

Details

taken from the Spellman support web site.

Source

cellcycle-www.stanford.edu

References

PMID 9843569

yeastCC

Examples

data(spYCCmeta)
spYCCmeta[1:5,1:6]

yeastCC

Description

9

Data from the Spellman et al. (1998) yeast cell cycle microarray ex-
periment

This data package contains an ExpressionSet instance for the yeast cell cycle microarray ex-
periment. The dataset contains gene expression measures (log-ratios, with Cy3-labeled common
reference) for 6,178 yeast genes in 77 conditions.

Usage

data(yeastCC)

Details

There are four main timecourses: alpha (alpha factor arrest), cdc15, cdc28, and elu (elutriation),
corresponding to different synchronization methods. For details on experimental procedures and
analysis, refer to Spellman et al. (1998) (in ../doc) and the Yeast Cell Cycle Analysis Project web-
site (http://genome-www.stanford.edu/cellcycle/). The ExpressionSet instance yeastCC
was derived from the file "combined.txt" on the website. The ORF names for the 800 cell cycle
regulated genes are stored in orf800.

Source

The raw data (images, TIFF) and processed data "combine.txt" used to create the ExpressionSet
instance yeastCC are available from the Yeast Cell Cycle Analysis Project website (http://genome-www.
stanford.edu/cellcycle/). Gene annotation information is available from the Saccharomyces
Genome Database (SGD, http://genome-www.stanford.edu/Saccharomyces/gene_list.shtml).
The script "createYeastCC.R" for generating the yeastCC package is available in ../doc.
Note that spYCCES is an ExpressionSet instance with the same data and slightly different pheno-
data annotation.

References

Spellman et al. (1998). Comprehensive Identification of Cell Cycle-regulated Genes of the Yeast
Saccharomyces cerevisiae by Microarray Hybridization. Molecular Biology of the Cell, 9: 3273-
3297.

Examples

data(yeastCC)
yeastCC
varLabels(yeastCC)
pData(yeastCC)
description(yeastCC)
abstract(yeastCC)
featureNames(yeastCC)[1:10]
dim(exprs(yeastCC))

Index

∗ datasets

breeden, 2
orf800, 4
spYCCmeta, 5
yeastCC, 9

breeden, 2

ExpressionSet, 5, 9

orf800, 4, 9

spYCCES (yeastCC), 9
spYCCmeta, 5

yeastCC, 5, 9

10

