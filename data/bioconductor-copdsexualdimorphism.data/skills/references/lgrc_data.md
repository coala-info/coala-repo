Gene Expression and Methylation from Lung Genomic
Research Consortium (LGRC)

J Fah Sathirapongsasuti

October 30, 2025

The data is also available at https://www.lung-genomics.org/research/. We provide them here in a

processed form to accompany the methods in the package COPDSexualDimorphism.

1 Clinical Data

Clinical phenotypes of 254 LGRC samples are given as a data.frame named meta.
It has six fields:
tissueid, newid, GENDER, age, cigever, pkyrs, and diagmaj. tissueid identifies the samples and newid
identifies the subjects. Some subjects might have more than one sample from left/right/upper/lower lung
or blood. These are designated by the last two letters of the tissue ID. The information for these samples
have been adjudicated as described in Sathirapongsasuti et al (in review).

> library(COPDSexualDimorphism.data)
> `%+%` <- function(x,y) paste(x,y,sep="")
> data(lgrc.meta)
> head(meta)

GENDER age
tissueid newid
1-Male 82 2-Ever (>100)
LT196199RU LT196199RU 202158
LT073345RU LT073345RU
3-Never
1-Male
84736
LT156041LU LT156041LU 299693 2-Female 70 2-Ever (>100)
1-Male 60 2-Ever (>100)
LT095342LU LT095342LU 198904
79946 2-Female 48 2-Ever (>100)
LT155982RU LT155982RU
1-Male 73 2-Ever (>100)
LT083759RL LT083759RL 221323

74

0

diagmaj
60 2-COPD/Emphysema
3-Control
77 2-COPD/Emphysema
19 2-COPD/Emphysema
28 2-COPD/Emphysema
120 2-COPD/Emphysema

cigever pkyrs

2 Gene Expression

Gene expression profile for 229 LGRC samples are available in two parts. One is expr, a matrix of 14497
Ensembl genes (rows) by 229 samples (columns), and the other is expr.meta, a data.frame of 229 samples
(rows) by the subjects’ clinical metadata. The subjects are arranged in the same order in the two objects.

> data(lgrc.expr)
> data(lgrc.expr.meta)
> dim(expr)

[1] 14497

229

> head(expr.meta)

tissueid

sample_name
1 LT001098RU LT001098RU_COPD 161745 2-Female
1-Male
2 LT001796RU LT001796RU_CTRL 212671

newid

GENDER age

46 2-Ever (>100)
48 2-Ever (>100)

cigever pkyrs
35
19

1

3 LT005419RU LT005419RU_COPD 291396
4 LT007392RU LT007392RU_COPD 169067
5 LT009615LU LT009615LU_CTRL
6 LT010491LL LT010491LL_COPD 180409

1-Male
1-Male
49801 2-Female
1-Male

70 2-Ever (>100)
46 2-Ever (>100)
49 2-Ever (>100)
78 2-Ever (>100)

43
45
45
51

diagmaj

gender
1 2-COPD/Emphysema 2-Female
1-Male
2
3-Control
1-Male
3 2-COPD/Emphysema
4 2-COPD/Emphysema
1-Male
3-Control 2-Female
5
1-Male
6 2-COPD/Emphysema

Corresponding to the Ensembl genes in the expression profile is the data frame genes. This is a result

of a query to BiomaRt database, stored here for convenience.

> data(lgrc.genes)
> head(lgrc.genes)

ENSG00000000003 ENSG00000000003
ENSG00000000005 ENSG00000000005
ENSG00000000419 ENSG00000000419
ENSG00000000457 ENSG00000000457
ENSG00000000460 ENSG00000000460
ENSG00000000938 ENSG00000000938

ensembl_gene_id hgnc_symbol
TSPAN6
TNMD
DPM1
SCYL3
C1orf112
FGR

tetraspanin 6 [Source:HGNC Symbol;Acc:11858]
ENSG00000000003
ENSG00000000005
tenomodulin [Source:HGNC Symbol;Acc:17757]
ENSG00000000419 dolichyl-phosphate mannosyltransferase polypeptide 1, catalytic subunit [Source:HGNC Symbol;Acc:3005]
ENSG00000000457
SCY1-like 3 (S. cerevisiae) [Source:HGNC Symbol;Acc:19285]
chromosome 1 open reading frame 112 [Source:HGNC Symbol;Acc:25565]
ENSG00000000460
Gardner-Rasheed feline sarcoma viral (v-fgr) oncogene homolog [Source:HGNC Symbol;Acc:3697]
ENSG00000000938

description

ENSG00000000003
ENSG00000000005
ENSG00000000419
ENSG00000000457
ENSG00000000460
ENSG00000000938

ENSG00000000003
ENSG00000000005
ENSG00000000419
ENSG00000000457
ENSG00000000460
ENSG00000000938

chromosome_name

band strand start_position end_position
99894988
99854882
49575092
169863408
169823221
27961788

99883667
99839799
49551404
169821804
169631245
27938575

X q22.1
X q22.1
20 q13.13
1 q24.2
1 q24.2
1 p36.11

-1
1
-1
-1
1
-1

ensembl_gene_id.1 entrezgene
7105
64102
8813
57147
55732
2268

ENSG00000000003
ENSG00000000005
ENSG00000000419
ENSG00000000457
ENSG00000000460
ENSG00000000938

3 Methylation

Methylation data for 245 LGRC subjects is provided as a data frame methp which contains percent methyla-
tion for 12094 variably methylated regions (VMRs). Each row provides average median absolute deviation
(MAD), length, and the number of probes for a VMR.

> data(lgrc.methp)
> methp[1:5, c("name","ave.mad","length","num.probes")]

2

name

vmr_chr1_932668_932806 0.03778364
1
vmr_chr1_939506_939647 0.04619729
2
vmr_chr1_966705_966843 0.05257659
3
vmr_chr1_989551_989797 0.04155331
4
5 vmr_chr1_1006424_1006565 0.04367978

ave.mad length num.probes
5
139
5
142
5
139
5
247
5
142

4 Session Information

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
[1] stats

graphics

grDevices utils

datasets

methods

base

other attached packages:
[1] COPDSexualDimorphism.data_1.46.0

loaded via a namespace (and not attached):
[1] compiler_4.5.1 tools_4.5.1

3

