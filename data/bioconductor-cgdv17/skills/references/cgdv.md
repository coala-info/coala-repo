Exploring the Complete Genomics Diversity panel

VJ Carey

November 1, 2018

Contents

1 Introduction

2 Contents of a VCF header

3 Variant calls for chromosome 17

3.1 Recording structural variation for an individual
3.2

. . . . . . . . . . . . . .
Isolating variants in the vicinity of a gene, for an individual . . . . . . . .

4 Filtering and analyzing variants on multiple individuals

4.1 Sample ﬁltering . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
4.2 Counting variants in a speciﬁed region, with quality ﬁltering . . . . . . .
4.3 Enumerating variants by structural context . . . . . . . . . . . . . . . . .

2

3

5
5
7

8
9
9
12

1

1

Introduction

Complete Genomics Inc. distributes a collection of data on deeply sequenced genomes
(from Coriell cell lines) from 11 diﬀerent human populations.

> library(cgdv17)
> data(popvec)
> popvec[1:5]

NA19700 NA19020 NA19701 NA19025 NA19703
"ASW"

"ASW"

"ASW"

"LWK"

"LWK"

> table(popvec)

popvec
ASW CEU CHB GIH JPT LWK MKK MXL TSI YRI
7

4

4

4

4

4

5

4

5

5

The data are distributed with many details; VJC obtained the masterVar TSV ﬁles
from the Complete Genomics ftp2 site, converted these to VCF 4.0 in Oct. 2011, using
a tool noted at

http://community.completegenomics.com/tools/m/cgtools/219.aspx

The conversion tool used was released with various caveats. Perhaps the whole

conversion should be redone with oﬃcial tools.

The purpose of this note is to explore some basic structural features of the data, so
that relevant genetic structures can be identiﬁed for analytic programming and inter-
pretation. We focus on variant calls on chromosome 17.

Formal restrictions on publications related to these data are as follows.

1. The Coriell and ATCC Repository number(s) of the
cell line(s) or the DNA sample(s) must be cited in
publication or presentations that are based on the
use of these materials.
2. You must reference our Science paper (R. Drmanac,
et. al. Science 327(5961), 78. [DOI: 10.1126/
science.1181498])
3. You must provide the version number of the
Complete Genomics assembly software with which
the data was generated. This can be found in the
header of the summary.tsv file (\# Software_Version).

2

2 Contents of a VCF header

There is a lot of redundancy among the headers for the 46 ﬁles, so one was isolated for
distribution.

> data(h1)
> h1

$NA21767_17.vcf.gz
List of length 3
names(3): Reference Sample Header

> h1[[1]]$Sample

[1] "GS21767-1100-37-ASM"

> h1[[1]]$Header$META

DataFrame with 5 rows and 1 column

Value
<character>
VCFv4.1
20111102
masterVar2VCFv40
build37.fa.bz2
partial

fileformat
fileDate
source
reference
phasing

> h1[[1]]$Header$INFO

DataFrame with 3 rows and 3 columns

Number

Type
<character> <character>

Description
<character>
Integer Number of Samples With Data
Total Depth
Integer
Flag dbSNP membership, build 131

NS
DP
DB

1
1
0

> h1[[1]]$Header$FORMAT

DataFrame with 12 rows and 3 columns

Number

Type
<character> <character>
String
Integer
Integer

1
1
1

GT
GQ
DP

Description
<character>
Genotype
Genotype Quality
Read Depth

3

HDP
HQ
...
mRNA
rmsk
segDup
rCov
cPd

2
2
...
.
.
.
1
1

Haplotype Read Depth
Integer
Haplotype Quality
Integer
...
...
Overlaping mRNA
String
String
Overlaping Repeats
String Overlaping segmentation duplication
relative Coverage
called Ploidy(level)

Float
String

4

3 Variant calls for chromosome 17

3.1 Recording structural variation for an individual

We created a provisional container for the call data on chromosome 17. Tabix facilities
were used to ﬁlter and index the data from the full VCF to all of chromosome 17.

At present it is not clear how to model a collection of deeply sequenced chromosomes.
I have used VariantAnnotation:::readVcf, which must be applied separately for each in-
dividual, given the Complete Genomics distribution. The focus is on structural informa-
tion in the rowRanges component of the VCF object returned by readVcf, which is a
GRanges instance. From the elementMetadata I removed FILTER and added geno()$GT
information. This gives us information to speciﬁc variants and phase for some variants,
depending on the string content of the GT information.

The getRVS function will collect ﬁle references for the serialized GRanges.

> rv = getRVS("cgdv17")
> rv

raggedVariantSet instance with 46 elements.
some sampleNames: NA06985 NA06994 ... NA21737 NA21767

Data on one individual can be extracted using getrd(). We will conﬁne attention

to variants with quality score in the top quartile of its distribution for this individual.

> R85 = getrd(rv, "NA06985")
> length(R85)

[1] 174744

> summary(elementMetadata(R85)$QUAL)

Min. 1st Qu. Median
98

0

0

Mean 3rd Qu.
166

117

Max.
1714

> kp = which(elementMetadata(R85)$QUAL >= 166)
> R85hiq = R85[kp]

A small excerpt gives us a sense of the sorts of variation to be encountered:

> elementMetadata(R85hiq)[11:20,]

DataFrame with 10 rows and 5 columns

rs7209783

REF

geno
<DNAStringSet> <CharacterList> <numeric> <character>
1|0

QUAL

309

ALT

C

T

5

T
T
A
CTG
A
C
G
TAGT
T

C
C
G
CCA,CCG
G
T
A
TGGG
G

417
187
187
203
380
272
324
237
396

1/0
1/1
1/0
1/2
1/1
1/0
1/0
1/0
1|0

rs7209943
rs7220384
rs7210283
rs7220537,rs35411518
rs8075072
chr17:20080
rs2294074
chr17:23182
chr17:23722

rs7209783
rs7209943
rs7220384
rs7210283
rs7220537,rs35411518
rs8075072
chr17:20080
rs2294074
chr17:23182
chr17:23722

depth
<integer>
66
63
61
48
46
26
45
45
62
50

8
21
21
2

9
25
22
1

10
17
23
2

11
16
24
2

12
18
25
2

13
15
26
1

> refs = elementMetadata(R85hiq)$REF
> alts = elementMetadata(R85hiq)$ALT
> genos = elementMetadata(R85hiq)$geno
> table(nchar(refs))

1
41848
14
9
27
2

2
646
15
10
29
1

3
645
16
7
30
2

4
347
17
5
31
1

5
193
18
3
32
2

6
63
19
1
34
1

7
33
20
2
135
1

> alts[grep(",",unlist(alts))]

CharacterList of length 120
[[1]] CCA,CCG
[[2]] CCC,CCG
[[3]] A,C
[[4]] ACA,ATG
[[5]] CTCG,CNCN
[[6]] GCA,GTG

6

[[7]] CGCA,CGCG
[[8]] C,G
[[9]] TGG,TCA
[[10]] CAAG,CGAG
...
<110 more elements>

Summary: references are recorded as DNAStrings, alternatives are compressed char-
acter strings with commas, and the phasing of the individual-level calls can be derived
by parsing the geno component.

3.2

Isolating variants in the vicinity of a gene, for an individual

We are interested in gene ORMDL3. We will use the hg19 transcriptDb to obtain the
locations and tabulate higher quality variants observed 100kb up and downstream of the
transcript.

> library(TxDb.Hsapiens.UCSC.hg19.knownGene)
> tx19 = TxDb.Hsapiens.UCSC.hg19.knownGene
> library(org.Hs.eg.db)
> get("ORMDL3", revmap(org.Hs.egSYMBOL))

[1] "94103"

> ortx = transcriptsBy(tx19, "gene")$"94103"
> seqlevels(R85hiq) = "chr17"
> aro = subsetByOverlaps(R85hiq, ortx+100000)
> table(elementMetadata(aro)$geno)

0/. 0|. 1/0 1/1 1|0 1|2
1

1 121 10 65

2

> alts = unlist(elementMetadata(aro)$ALT)
> alts[nchar(alts)>1]

[1] "AGTG"
[8] "ACAC"

"CC"
"GG"

"GG"
"ACA,ACG" "GAA"

"CTGC"

"AT"

"AGG"

"AA"

There are deletion and insertion events, but I don’t see any simple way of isolating

and counting them at the moment. Some code will be added to address this.

We can use VariantAnnotation to obtain structural contexts. It takes over a minute

to use locateVariants, so I just show the code and results here for now.

7

mycache = new.env(hash=TRUE)
lvaro = locateVariants(aro, tx19, cache=mycache)
lvaro[1:4,]
table(lvaro$loca,sapply((lvaro$geneID), function(x)strsplit(x, ",")[[1]][1]))
DataFrame with 4 rows and 5 columns

txID

queryID location

cdsID
<integer> <factor> <integer> <CompressedCharacterList> <integer>
189661
189661
189661
189661

intron
intron
intron
intron

22806
22806
22806
22806

60959
60960
60961
60962

geneID

1
1
1
1

1
2
3
4

’
’

UTR
3
5
UTR
coding
intergenic
intron

124626 1440 22806 284110 2886 55876 5709 94103 9862
20
10
10
0
0

0
0
0
10
105

0
8
0
2
138

0
0
0
34
28

0
0
0
10
6

0
0
0
25
99

0
1
6
4
42

0
0
0
1
0

0
0
0
1
0

We see that this search for variants near ORMDL3 identiﬁes variants aﬀecting other

nearby genes.

4 Filtering and analyzing variants on multiple indi-

viduals

The analysis of a ragged variant set requires infrastructure. We will illustrate with a
focused analysis of variants in the vicinity of ORMDL3. We have used the GGdata and
hmyriB36 packages to collect expression data on 12 individuals in the diversity cohort,
in the CY17 smlSet instance. This includes expression on all genes on chr17, and the
HapMap phase 2 genotypes as well.

> suppressPackageStartupMessages(library(GGtools))
> data(CY17)
> CY17

SnpMatrix-based genotype set:
number of samples: 12
number of chromosomes present: 1
annotation: illuminaHumanv1.db
Expression data dims: 1291 x 12
Total number of SNP: 83889
Phenodata: An object of class

’

AnnotatedDataFrame

’

8

rowNames: NA06985 NA06994 ... NA19129 (12 total)
varLabels: mothid fathid isFounder male
varMetadata: labelDescription

> sn = sampleNames(CY17)

4.1 Sample ﬁltering

The ragged variant set can be ﬁltered to these individuals.

> rv17 = rv[, sn]
> rv17

raggedVariantSet instance with 12 elements.
some sampleNames: NA06985 NA06994 ... NA18517 NA19129

4.2 Counting variants in a speciﬁed region, with quality ﬁlter-

ing

The variant counting function takes two key parameters in addition to the variant set: a
region within which to count, and a lower bound on call quality for retained variants. A
third additional parameter tells how to iterate over samples with an lapply-like function.
Since ORMDL3 is on the minus strand, the upstream region is to the right. We will

create a region from start site to 50k upstream.

> if (length(ortx)>1) ortx = ortx[2]
> ortss = end(ortx)
> ortup50 = GRanges("chr17", IRanges(ortss, width=50000))
> cv50k = countVariants(rv17, ortup50, 160, lapply )

> cv50k

NA06985 NA06994 NA07357 NA10851 NA12004 NA18501 NA18502 NA18504 NA18505 NA18508
56

51

56

68

10

26

72

9

65

0
NA18517 NA19129
58

81

We see that the second sample seems to have a quality problem. We will now drop it
from both the expression and variant structures.

> if (length(sampleNames(rv17))==12) rv17 = rv17[,-2]
> if (length(sampleNames(CY17))==12) CY17 = CY17[,-2]
> #redo

> cv50k = countVariants(rv17, ortup50, 160, lapply )

9

We can acquire the full data on variants in the region under the quality constraint

using variantGRanges.

> vv50k = variantGRanges( rv17, ortup50, 160, lapply )

> vv50k[[1]][1:5]

GRanges object with 5 ranges and 5 metadata columns:

seqnames

REF

ranges strand |

ALT
<Rle> <IRanges> <Rle> | <DNAStringSet> <CharacterList>
G
T
T
A
C

17 38087429
17 38087439
17 38090808
17 38091660
17 38095174

* |
* |
* |
* |
* |

T
C
C
G
G

QUAL

geno

depth
<numeric> <character> <integer>
70
56
48
66
69

1/1
1/0
1/0
1/0
1/0

339
339
270
470
440

rs12946393
rs35557848
rs56199421
rs7207600
rs6503525

rs12946393
rs35557848
rs56199421
rs7207600
rs6503525

-------
seqinfo: 1 sequence from hg19 genome; no seqlengths

> sapply(vv50k,length)

NA06985 NA07357 NA10851 NA12004 NA18501 NA18502 NA18504 NA18505 NA18508 NA18517
81

68

72

10

26

56

51

56

9

65
NA19129
58

As a naive hint of a connection of “variant burden” with ORMDL3 expression, con-

sider the following display.

> ORMDL3ex = as.numeric(exprs(CY17[genesym("ORMDL3"),]))
> ygr = ifelse((1:11)<=4, "red", "green")
> plot(ORMDL3ex~cv50k, col=ygr, pch=19,
+
> legend(10, 8.5, pch=19, col=c("red", "green"), legend=c("CEU", "YRI"))
> summary(lm(ORMDL3ex~cv50k*factor(ygr)))

ylab="variant count from 50kb upstream to TSS")

Call:
lm(formula = ORMDL3ex ~ cv50k * factor(ygr))

10

Residuals:

Min

Max
-0.29969 -0.13281 -0.02538 0.12717 0.32077

Median

3Q

1Q

Coefficients:

Estimate Std. Error t value Pr(>|t|)
(Intercept)
8.912418
cv50k
-0.010792
-0.520704
factor(ygr)red
cv50k:factor(ygr)red 0.008317
---
Signif. codes: 0

0.355770 25.051 4.12e-08 ***
0.005763 -1.873
0.412601 -1.262
1.091
0.007625

0.103
0.247
0.311

0.001

0.01

0.05

’ ’

***

0.1

**

.

*

’

’

’

’

’

’

’

’

1

Residual standard error: 0.2472 on 7 degrees of freedom
Multiple R-squared: 0.3528,
F-statistic: 1.272 on 3 and 7 DF, p-value: 0.3557

Adjusted R-squared: 0.07538

11

lllllllllll10203040506070808.08.28.48.6cv50kvariant count from 50kb upstream to TSSllCEUYRI4.3 Enumerating variants by structural context

Now we focus on variants in the ORMDL3 coding region.

> library(parallel)
> options(mc.cores=max(c(2, parallel::detectCores()-2)))
> vv = variantGRanges( rv17, ortx, 160, mclapply )
> vvv = lapply(vv, function(x) renameSeqlevels(x, c("17"="chr17")))
> mycache = new.env(hash=TRUE)
> locs = lapply(vvv, function(x) {
+
+ })

locateVariants(x, tx19, CodingVariants(),cache=mycache)

Further work: illustrate the predictCoding behavior, streamline the catalog of vari-
ants relevant to a given gene over the 46 individuals. Relate to population membership,
and, where available, to expression variation.

12

