Using the NHLBI GRASP repository of GWAS test results
with Bioconductor
Vincent J. Carey

October 9, 2014

Contents

1 Introduction

2 Installation

3 Demonstration

3.1 Attachment and messaging . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
Indexed p-value bins . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.2
3.3 Tabulations
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
Inspecting some relatively weak associations in asthma . . . . . . . . . . . . . . . . . . . . . . . . . . .
3.4

4 Quick view of the basic interfaces

4.1 dplyr-oriented . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.2 RSQLite-oriented . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

5 Some QC (Consistency check): Are NHGRI GWAS catalog loci included?

1

2

2
2
2
3
4

4
4
4

5

1 Introduction

GRASP (Genome-Wide Repository of Associations Between SNPs and Phenotypes) v2.0 was released in September 2014.
The primary GRASP web resource includes links to a web-based query interface. This document describes a Bioconductor
package that replicates information in the v2.0 textual release.

The primary reference for version 2 is: Eicher JD, Landowski C, Stackhouse B, Sloan A, Chen W, Jensen N, Lien J-P,
Leslie R, Johnson AD (2014) GRASP v 2.0: an update to the genome-wide repository of associations between SNPs and
phenotypes. Nucl Acids Res, published online Nov 26, 2014 PMID 25428361

From the main web page:

GRASP includes all available genetic association results from papers, their supplements and web-based content meeting
the following guidelines:

• All associations with P<0.05 from GWAS deﬁned as >= 25,000 markers tested for 1 or more traits.
• Study exclusion criteria: CNV-only studies, replication/follow-up studies testing <25K markers, non-human only
studies, article not in English, gene-environment or gene-gene GWAS where single SNP main eﬀects are not given,
linkage only studies, aCGH/LOH only studies, heterozygosity/homozygosity (genome-wide or long run) studies,
studies only presenting gene-based or pathway-based results, simulation-only studies, studies which we judge as
redundant with prior studies since they do not provide signiﬁcant inclusion of new samples or exposure of new
results (e.g., many methodological papers on the WTCCC and FHS GWAS).

• More detailed methods and resources used in constructing the catalog are described at Methods & Resources.
• Terms of Use for GRASP data: http://apps.nhlbi.nih.gov/Grasp/Terms.aspx
• Medical disclaimer: [http://apps.nhlbi.nih.gov/Grasp/Overview.aspx] (http://apps.nhlbi.nih.gov/Grasp/Overview.

aspx)

1

Using the NHLBI GRASP repository of GWAS test results with Bioconductor

2

2 Installation

Install the package in Bioconductor version 3.1 or later using BiocInstaller::biocLite("grasp2db").

The ﬁrst time the grasp2 data base is referenced, via the GRASP2() function described below, a large (5.3Gb) ﬁle is
downloaded to a local cache using AnnotationHub. This may take a considerable length of time (10’s of minutes, perhaps
an hour or more depending on internet connections). Subsequent uses refer to the locally cached ﬁle, and are fast.

3 Demonstration

3.1 Attachment and messaging

Attach the package.
library(grasp2db)

Workﬂows start with a reference to the data base.
grasp2 <- GRASP2()
## snapshotDate(): 2017-06-29
## loading from cache '/home/biocadmin//.AnnotationHub/25509'
grasp2
## src: sqlite 3.19.3 [/home/biocadmin/.AnnotationHub/25509]
## tbls: count, study, variant

There are three tables. The ‘variant’ table summarizes NA variants. The ‘study’ table contains NA citations from which
the data are extracted; the ‘variant’ and ‘study’ tables are related by PMID identiﬁer. The ‘count’ table contains NA
records summarizing SNPs observed in Discovery and Replication samples from 12 distinct Populations; theh ‘variant’ and
‘count’ tables are related by NHLBIkey.

3.2 Indexed p-value bins

of the quantity recorded as the

The database has been indexed on a number of ﬁelds, and an integer rounding of − log10
Pvalue of the association is available.
variant <- tbl(grasp2, "variant")
q1 = (variant %>% select(Pvalue, NegativeLog10PBin) %>%

filter(NegativeLog10PBin > 8) %>%
summarize(maxp = max(Pvalue), n=n()))

lazy query [?? x 2]

q1
## # Source:
## # Database: sqlite 3.19.3 [/home/biocadmin/.AnnotationHub/25509]
n
##
##
<int>
## 1 3.16181e-09 322794

maxp
<dbl>

This shows that the quantities in NegativeLog10PBin are upper bounds on the exponents of the p-values in the
integer-labeled bins deﬁned by this quantity.

A useful utility from dplyr is the query explain method:
explain(q1)
## <SQL>
## SELECT MAX(`Pvalue`) AS `maxp`, COUNT() AS `n`

Using the NHLBI GRASP repository of GWAS test results with Bioconductor

3

## FROM (SELECT `Pvalue` AS `Pvalue`, `NegativeLog10PBin` AS `NegativeLog10PBin`
## FROM `variant`)
## WHERE (`NegativeLog10PBin` > 8.0)
##
## <PLAN>
##
## 1
## 2
## 3
## 4
## 5
## 6
## 7
## 8
## 9
## 10
## 11
## 12
## 13
## 14
## 15
## 16
## 17
## 18
## 19
## 20
## 21

p2 p3
opcode p1
addr
00
0
19
0
Init
0
00
3
1
0
Null
1
10 00
0
2
2
OpenRead
2
k(2,,) 00
0
3 5465555
OpenRead
3
8 00
0
4
0
Real
4
D 00
0
1
4
Affinity
5
1 00
4
14
3
SeekGT
6
00
2
0
3
Seek
7
00
5
8
2
8
Column
0
0
5
9 RealAffinity
00
0 (BINARY) 00
0
0
CollSeq
10
max(1) 01
1
5
0
AggStep0
11
2 count(0) 00
0
0
AggStep0
12
0
7
3
00
Next
13
0
1
1
AggFinal
max(1) 00
14
0 count(0) 00
0
2
AggFinal
15
00
1
6
1
Copy
16
00
0
2
6
ResultRow
17
0
0
18
00
0
Halt
0 01
0 11
0
19 Transaction
00
0
1
0
Goto
20

p4 p5 comment
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA
NA

3.3 Tabulations

This query select variants with large eﬀect from the ‘variant’ table, and joins them to their published phenotypic eﬀect in
the ‘study’ table.
study <- tbl(grasp2, "study")
large_effect <-

variant %>% select(PMID, SNPid_dbSNP134, NegativeLog10PBin) %>%

filter(NegativeLog10PBin > 5)

phenotype <-

left_join(large_effect,

study %>% select(PMID, PaperPhenotypeDescription))

lazy query [?? x 4]

PMID SNPid_dbSNP134 NegativeLog10PBin
<int>

## Joining, by = "PMID"
phenotype
## # Source:
## # Database: sqlite 3.19.3 [/home/biocadmin/.AnnotationHub/25509]
##
##
<chr>
## 1 20502693
## 2 19913121
## 3 19913121
## 4 19913121
## 5 19913121
## 6 19913121
## 7 19913121

PaperPhenotypeDescription
<chr>
6 Gene expression in monocytes
Lipid level measurements
6
Lipid level measurements
6
Lipid level measurements
6
Lipid level measurements
6
Lipid level measurements
6
Lipid level measurements
6

<int>
253
255
256
263
264
271
285

Using the NHLBI GRASP repository of GWAS test results with Bioconductor

4

## 8 19913121
## 9 20502693
## 10 20502693
## # ... with more rows

301
326
327

Lipid level measurements
6
6 Gene expression in monocytes
6 Gene expression in monocytes

3.4 Inspecting some relatively weak associations in asthma

lkaw <- semi_join(
variant %>%

filter(NegativeLog10PBin <= 4) %>%
select(PMID, chr_hg19, SNPid_dbSNP134, PolyPhen2),
study %>% filter(PaperPhenotypeDescription == "Asthma"))

## Joining, by = "PMID"

lazy query [?? x 4]

We materialize the ﬁltered table into a data.frame and check how many PolyPhen2 notations including a substring of
‘Damaging’:
lkaw %>% filter(PolyPhen2 %like% "%amaging%")
## # Source:
## # Database: sqlite 3.19.3 [/home/biocadmin/.AnnotationHub/25509]
##
##
<chr>
## 1 20860503
## 2 20860503
## 3 20860503
## 4 20860503
## 5 20860503
## 6 20860503
## 7 20860503
## 8 20860503
## 9 20860503
## 10 20860503
## # ... with more rows, and 1 more variables: PolyPhen2 <chr>

PMID chr_hg19 SNPid_dbSNP134
<int>
4762
880633
880633
1053338
1054940
1060622
1156281
1536207
1799853
2186797

<chr>
1
1
1
3
19
1
1
13
10
11

4 Quick view of the basic interfaces

4.1 dplyr-oriented

grasp2
## src: sqlite 3.19.3 [/home/biocadmin/.AnnotationHub/25509]
## tbls: count, study, variant

4.2 RSQLite-oriented

gcon = grasp2$con
library(RSQLite)
gcon
## <SQLiteConnection>

Using the NHLBI GRASP repository of GWAS test results with Bioconductor

5

Path: /home/biocadmin/.AnnotationHub/25509
Extensions: TRUE

##
##
dbListTables(gcon)
## [1] "count"

"study"

"variant"

Note that the package opens the SQLite data base in ‘read-only’ mode, but updates are possible (e.g., directly opening a
connection to the data base without restricting access). There may be implicit control if the user does not have write
access to the ﬁle.

5 Some QC (Consistency check): Are NHGRI GWAS catalog loci included?

combine, intersect, setdiff, union

clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
clusterExport, clusterMap, parApply, parCapply, parLapply,
parLapplyLB, parRapply, parSapply, parSapplyLB

We have an image of the NHGRI GWAS catalog inheriting from GRanges.
library(gwascat)
## Loading required package: Homo.sapiens
## Loading required package: AnnotationDbi
## Loading required package: stats4
## Loading required package: BiocGenerics
## Loading required package: parallel
##
## Attaching package: 'BiocGenerics'
## The following objects are masked from 'package:parallel':
##
##
##
##
## The following objects are masked from 'package:dplyr':
##
##
## The following objects are masked from 'package:stats':
##
##
## The following objects are masked from 'package:base':
##
##
##
##
##
##
##
##
## Loading required package: Biobase
## Welcome to Bioconductor
##
##
##
##
## Loading required package: IRanges
## Loading required package: S4Vectors
##
## Attaching package: 'S4Vectors'
## The following objects are masked from 'package:dplyr':

Filter, Find, Map, Position, Reduce, anyDuplicated, append,
as.data.frame, cbind, colMeans, colSums, colnames, do.call,
duplicated, eval, evalq, get, grep, grepl, intersect,
is.unsorted, lapply, lengths, mapply, match, mget, order,
paste, pmax, pmax.int, pmin, pmin.int, rank, rbind, rowMeans,
rowSums, rownames, sapply, setdiff, sort, table, tapply,
union, unique, unsplit, which, which.max, which.min

Vignettes contain introductory material; view with
'browseVignettes()'. To cite Bioconductor, see
'citation("Biobase")', and for packages 'citation("pkgname")'.

IQR, mad, sd, var, xtabs

Using the NHLBI GRASP repository of GWAS test results with Bioconductor

6

select

expand.grid

first, rename

collapse, desc, slice

##
##
## The following object is masked from 'package:base':
##
##
##
## Attaching package: 'IRanges'
## The following objects are masked from 'package:dplyr':
##
##
##
## Attaching package: 'AnnotationDbi'
## The following object is masked from 'package:dplyr':
##
##
## Loading required package: OrganismDbi
## Loading required package: GenomicFeatures
## Loading required package: GenomeInfoDb
## Loading required package: GenomicRanges
## No methods found in "RSQLite" for requests: dbGetQuery
## Loading required package: GO.db
##
## Loading required package: org.Hs.eg.db
##
## Loading required package: TxDb.Hsapiens.UCSC.hg19.knownGene
## gwascat loaded. Use data(ebicat38) for hg38 coordinates;
## data(ebicat37) for hg19 coordinates.
data(gwrngs19)
gwrngs19
## gwasloc instance with 17254 records and 35 attributes per record.
## Extracted:
## Genome: hg19
## Excerpt:
## GRanges object with 5 ranges and 35 metadata columns:
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
##
##
##

Journal
<character>
03/03/2014 Diabetes Metab Res Rev
12/30/2013 J Allergy Clin Immunol
12/30/2013 J Allergy Clin Immunol
12/30/2013 J Allergy Clin Immunol
12/30/2013 J Allergy Clin Immunol
Link
<character>
1 http://www.ncbi.nlm.nih.gov/pubmed/24123702
2 http://www.ncbi.nlm.nih.gov/pubmed/24388013
3 http://www.ncbi.nlm.nih.gov/pubmed/24388013
4 http://www.ncbi.nlm.nih.gov/pubmed/24388013

ranges strand | Date.Added.to.Catalog
<character>
04/16/2014
08/02/2014
08/02/2014
08/02/2014
08/02/2014

<IRanges>
7739177,
7739177]
chr6 [ 32626601,
32626601]
38799710]
chr4 [ 38799710,
chr5 [110467499, 110467499]
chr2 [102966549, 102966549]

<integer>
1 24123702
2 24388013
3 24388013
4 24388013
5 24388013

Chung CM
Ferreira MA
Ferreira MA
Ferreira MA
Ferreira MA

Date
<character> <character>

<Rle> |
* |
* |
* |
* |
* |

# hg19 addresses; NHGRI ships hg38

seqnames
<Rle>
chr19 [

Mon Sep 8 13:08:13 2014

PUBMEDID First.Author

1
2
3
4
5

Using the NHLBI GRASP repository of GWAS test results with Bioconductor

7

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
##
##

5 http://www.ncbi.nlm.nih.gov/pubmed/24388013

1 Common quantitative trait locus downstream of RETN gene identified by genome-wide association study is associated with risk of type 2 diabetes mellitus in Han Chinese: a Mendelian randomization effect.
Genome-wide association analysis identifies 11 risk variants associated with the asthma with hay fever phenotype.
2
Genome-wide association analysis identifies 11 risk variants associated with the asthma with hay fever phenotype.
3
Genome-wide association analysis identifies 11 risk variants associated with the asthma with hay fever phenotype.
4
Genome-wide association analysis identifies 11 risk variants associated with the asthma with hay fever phenotype.
5

Study

<character>

Disease.Trait
<character>

Resistin levels

1
2 Asthma and hay fever
3 Asthma and hay fever
4 Asthma and hay fever
5 Asthma and hay fever

Initial.Sample.Size
<character>
382 Han Chinese ancestry indiviudals
1
2 6,685 European ancestry cases, 14,091 European ancestry controls
3 6,685 European ancestry cases, 14,091 European ancestry controls
4 6,685 European ancestry cases, 14,091 European ancestry controls
5 6,685 European ancestry cases, 14,091 European ancestry controls

Replication.Sample.Size
<character>
1
559 Han Chinese ancestry indiviudals
2 878 European ancestry cases, 2,455 European ancestry controls
3 878 European ancestry cases, 2,455 European ancestry controls
4 878 European ancestry cases, 2,455 European ancestry controls
5 878 European ancestry cases, 2,455 European ancestry controls

Region

<character> <character>
19
6
4
5
2

19p13.2
6p21.32
4p14
5q22.1
2q12.1

Chr_id Chr_pos.hg38 Reported.Gene.s.
<character>
RETN
HLA-DQB1
TLR1

<numeric>
7674291
32658824
38798089
111131801
102350089

WDR36
IL1RL1

Mapped_gene
<character>
RETN - C19orf59
TRNAI25
TLR1
WDR36 - RPS3AP21
IL1RL1

Upstream_gene_id Downstream_gene_id Snp_gene_ids
<character>

<character>
56729
<NA>
<NA>
134430
<NA>

<character>
199675
<NA>
<NA>
402287
<NA>

100189401
7096

9173

<character>
3.84
<NA>
<NA>
1.3
<NA>

Upstream_gene_distance Downstream_gene_distance
<character>
2.77
<NA>
<NA>
60.38
<NA>
Merged Snp_id_current
<character>
1423096

<character> <character> <character>
0
rs1423096-G

Strongest.SNP.Risk.Allele

rs1423096

SNPs

1
2
3
4
5

1
2
3
4
5

1
2
3
4
5

1

Using the NHLBI GRASP repository of GWAS test results with Bioconductor

8

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

9273373
4833095
1438673
10197862

0
0
0
0
p.Value Pvalue_mlog
<numeric>
7.00000
13.39794
11.30103
10.52288
10.39794

<character> <numeric>
1e-07
4e-14
5e-12
3e-11
4e-11

0.78
0.54
0.74
0.49
0.85

2
3
4
5

rs9273373-G
rs4833095-T
rs1438673-C
rs10197862-A

rs9273373
rs4833095
rs1438673
rs10197862

Context Intergenic Risk.Allele.Frequency

<character> <character>
1
0
0
1
0

1 Intergenic
2
3
missense
4 Intergenic
intron
5

p.Value..text. OR.or.beta
<character> <numeric>

1
2
3
4
5

X95..CI..text.
<character>
0.32 [0.25-0.40] ug/mL increase
1.24
1.20
1.16
1.24
Platform..SNPs.passing.QC.

[1.17-1.30]
[1.14-1.26]
[1.11-1.21]
[1.16-1.32]

1
Illumina [NR]
2 Illumina [up to 4,972,397] (imputed)
3 Illumina [up to 4,972,397] (imputed)
4 Illumina [up to 4,972,397] (imputed)
5 Illumina [up to 4,972,397] (imputed)

CNV
<character> <character>
N
N
N
N
N

num.Risk.Allele.Frequency
<numeric>
0.78
0.54
0.74
0.49
0.85

1
2
3
4
5
-------
seqinfo: 23 sequences from hg19 genome

We would like to verify that the majority of the variants enumerated in the NHGRI catalog are also present in GRASP 2.0.
We supply a function called checkAnti which obtains the anti-join between a chromosome-speciﬁc slice of the NHGRI
catalogue and the slice of GRASP2 for the same chromosome. We compute for chromosome 22 the fraction of NHGRI
records present in GRASP2.
gr22 = variant %>% filter(chr_hg19 == "22")
abs22 = checkAnti("22")
1 - (abs22 %>% nrow()) /

(gr22 %>% count %>% collect %>% `[[`("n"))

## [1] 0.9982036

The absent records can be seen to be relatively recent additions to the NHGRI catalog.
abs22
## # A tibble: 217 x 42
start
##
##
<int>
## 1
## 2
## 3

end width strand Date.Added.to.Catalog PUBMEDID
<int>
08/05/2014 24390342
08/05/2014 24390342
08/05/2014 24390342

<int> <int> <fctr>
*
*
*

22 37545505 37545505
22 39747671 39747671
22 21979096 21979096

seqnames
<fctr>

<chr>

1
1
1

Using the NHLBI GRASP repository of GWAS test results with Bioconductor

9

1
1
1
1
1
1
1

*
*
*
*
*
*
*

07/28/2014 24322204
07/29/2014 24348519
07/23/2014 24324551
07/23/2014 24324551
07/23/2014 24324551
07/23/2014 24324551
04/26/2014 24165912

22 48923459 48923459
22 36125264 36125264
22 21431054 21431054
22 35144411 35144411
22 22047969 22047969
22 37586792 37586792
22 34386473 34386473

## 4
## 5
## 6
## 7
## 8
## 9
## 10
## # ... with 207 more rows, and 35 more variables: First.Author <chr>,
## #
## #
## #
## #
## #
## #
## #
## #
## #
## #
## #
## #

Date <chr>, Journal <chr>, Link <chr>, Study <chr>,
Disease.Trait <chr>, Initial.Sample.Size <chr>,
Replication.Sample.Size <chr>, Region <chr>, Chr_id <chr>,
Chr_pos.hg38 <dbl>, Reported.Gene.s. <chr>, Mapped_gene <chr>,
Upstream_gene_id <chr>, Downstream_gene_id <chr>, Snp_gene_ids <chr>,
Upstream_gene_distance <chr>, Downstream_gene_distance <chr>,
Strongest.SNP.Risk.Allele <chr>, SNPs <chr>, Merged <chr>,
Snp_id_current <chr>, Context <chr>, Intergenic <chr>,
Risk.Allele.Frequency <chr>, p.Value <dbl>, Pvalue_mlog <dbl>,
p.Value..text. <chr>, OR.or.beta <dbl>, X95..CI..text. <chr>,
Platform..SNPs.passing.QC. <chr>, CNV <chr>,
num.Risk.Allele.Frequency <dbl>, chr_hg19 <chr>, pos_hg19 <int>

