curatedBladderData

Markus Riester

November 4, 2025

Contents

1

2

3

4

A

B

C

D

curatedBladderData: Clinically Annotated Data for the Bladder
Cancer Transcriptome .
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

Load data sets .

.

.

.

.

.

.

.

.

Load datasets based on rules.

Non-unique gene symbols.

.

.

.

.

.

.

.

.

Available Clinical Characteristics .

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

Summarizing the List of ExpressionSets .

For non-R users .

Session Info .

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

.

.

.

1

1

2

5

6

6

9

9

1

curatedBladderData: Clinically Annotated Data for
the Bladder Cancer Transcriptome

This package represents a manually curated data collection for gene expression meta-analysis
of patients with bladder cancer. This resource provides uniformly prepared microarray data
with curated and documented clinical metadata. It allows a computational user to efficiently
identify studies and patient subgroups of interest for analysis and to run such analyses imme-
diately without the challenges posed by harmonizing heterogeneous microarray technologies,
study designs, expression data processing methods, and clinical data formats.

In this vignette, we give a short tour of the package and will show how to use it efficiently.

2

Load data sets

Loading a single dataset is very easy. First we load the package:

> library(curatedBladderData)

To get a listing of all the datasets, use the data function:

curatedBladderData

> data(package="curatedBladderData")

Now to load a single dataset, we use the data function again:

> data(GSE89_eset)
> GSE89_eset

ExpressionSet (storageMode: lockedEnvironment)

assayData: 5466 features, 40 samples

element names: exprs

protocolData: none

phenoData

sampleNames: GSM2505 GSM2506 ... GSM2544 (40 total)
varLabels: alt_sample_name unique_patient_ID ...

uncurated_author_metadata (31 total)

varMetadata: labelDescription

featureData

featureNames: A2M AADAC ... ZYX (5466 total)

fvarLabels: probeset gene

fvarMetadata: labelDescription

experimentData: use 'experimentData(object)'

pubMedIds: 12469123

Annotation: hu6800

The datasets are provided as Bioconductor ExpressionSet objects and we refer to the Bio-
conductor documentation for users unfamiliar with this data structure.

3

Load datasets based on rules

For a meta-analysis, we typically want to filter datasets and patients to get a population of
patients we are interested in. We provide a short but powerful R script that does the filtering
and provides the data as a list of ExpressionSet objects. One can use this script within R by
first sourcing a config file which specifies the filters, like the minimum numbers of patients in
each dataset. It is also possible to filter samples by annotation, for example to remove early
stage and normal samples.

> source(system.file("extdata",
+ "patientselection_all.config",package="curatedBladderData"))
> ls()

[1] "GSE89_eset"
[4] "min.number.of.events" "min.sample.size"

"keep.common.only"

[7] "quantile.cutoff"

"rescale"

"meta.required"

"package.name"

"strict.checking"

See what the values of these variables we have loaded are. The variable names are fairly
descriptive, but note that “rule.1” is a character vector of length 2, where the first entry is
the name of a clinical data variable, and the second entry is a Regular Expression providing a
requirement for that variable. Any number of rules can be added, with increasing identifiers,
e.g. “rule.2”, “rule.3”, etc.

2

curatedBladderData

Here strict.checking is FALSE, meaning that samples not annotated for the variables in
these rules are allowed to pass the filter. If strict.checking == TRUE, samples missing this
annotation will be removed.

> sapply(ls(), get)

$GSE89_eset
ExpressionSet (storageMode: lockedEnvironment)

assayData: 5466 features, 40 samples

element names: exprs

protocolData: none

phenoData

sampleNames: GSM2505 GSM2506 ... GSM2544 (40 total)
varLabels: alt_sample_name unique_patient_ID ...

uncurated_author_metadata (31 total)

varMetadata: labelDescription

featureData

featureNames: A2M AADAC ... ZYX (5466 total)

fvarLabels: probeset gene

fvarMetadata: labelDescription

experimentData: use 'experimentData(object)'

pubMedIds: 12469123

Annotation: hu6800

$keep.common.only

[1] FALSE

$meta.required

NULL

$min.number.of.events

[1] 0

$min.sample.size

[1] 1

$package.name

[1] "curatedBladderData"

$quantile.cutoff

[1] 0

$rescale

[1] FALSE

$strict.checking

[1] FALSE

Now that we have defined the sample filter, we create a list of ExpressionSets by sourcing
the createEsetList.R file:

3

curatedBladderData

> source(system.file("extdata", "createEsetList.R", package =

+ "curatedBladderData"))

2025-11-04 11:13:55.518744 INFO::Inside script createEsetList.R - inputArgs =

2025-11-04 11:13:55.560482 INFO::Loading curatedBladderData 1.46.0

2025-11-04 11:14:06.589586 INFO::Clean up the esets.
2025-11-04 11:14:06.766289 INFO::including GSE13507_eset
2025-11-04 11:14:07.243545 INFO::including GSE1827_eset
2025-11-04 11:14:07.26769 INFO::including GSE19915.GPL3883_eset
2025-11-04 11:14:07.301361 INFO::including GSE19915.GPL5186_eset
2025-11-04 11:14:07.341706 INFO::including GSE31189_eset
2025-11-04 11:14:07.400236 INFO::including GSE31684_eset
2025-11-04 11:14:07.869038 INFO::including GSE32894_eset
2025-11-04 11:14:07.919438 INFO::including GSE37317_eset
2025-11-04 11:14:07.943888 INFO::including GSE5287_eset
2025-11-04 11:14:07.967988 INFO::including GSE89_eset
2025-11-04 11:14:07.984817 INFO::including PMID17099711.GPL8300_eset
2025-11-04 11:14:08.00477 INFO::including PMID17099711.GPL91_eset
2025-11-04 11:14:08.26207 INFO::Ids with missing data: GSE1827_eset, GSE19915.GPL3883_eset, GSE19915.GPL5186_eset

It is also possible to run the script from the command line and then load the R data file
within R:

R --vanilla "--args patientselection.config ovarian.eset.rda tmp.log"

< createEsetList.R

Now we have 12 datasets with samples that passed our filter in a list of ExpressionSets
called esets:

> names(esets)

[1] "GSE13507_eset"
[3] "GSE19915.GPL3883_eset"
[5] "GSE31189_eset"
[7] "GSE32894_eset"
[9] "GSE5287_eset"
[11] "PMID17099711.GPL8300_eset" "PMID17099711.GPL91_eset"

"GSE1827_eset"
"GSE19915.GPL5186_eset"
"GSE31684_eset"
"GSE37317_eset"
"GSE89_eset"

4

curatedBladderData

4

Non-unique gene symbols

In the standard version of curatedBladderData (the version available on Bioconductor), we
collapse manufacturer probesets to official HGNC symbols using the Biomart database. Some
probesets are mapped to multiple HGNC symbols in this database. For these probesets, we
provide all the symbols. For example 220159_at maps to ABCA11P and ZNF721 and we
provide ABCA11P///ZNF721 as probeset name. If you have an array of gene symbols for which
you want to access the expression data, "ABCA11P" would not be found in curatedBladder-
Data in this example. The following function will create a new ExpressionSet in which both
ZNF721 and ABCA11P are features with identical expression data:

> expandProbesets <- function (eset, sep = "///")

+ {

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

x <- lapply(featureNames(eset), function(x) strsplit(x, sep)[[1]])

eset <- eset[order(sapply(x, length)), ]

x <- lapply(featureNames(eset), function(x) strsplit(x, sep)[[1]])

idx <- unlist(sapply(1:length(x), function(i) rep(i, length(x[[i]]))))

xx <- !duplicated(unlist(x))

idx <- idx[xx]

x <- unlist(x)[xx]

eset <- eset[idx, ]

featureNames(eset) <- x

eset

+ }
> X <- GSE89_eset[head(grep("///", featureNames(GSE89_eset))),]
> exprs(X)[,1:3]

GSM2505

GSM2506

GSM2507

ACOT1///ACOT2

11.324354 11.149031 10.847654

ACTBP11///ACTB

15.257080 15.123444 15.008748

ACY1///ABHD14A-ACY1

10.733768 12.309362 11.906228

ADH1A///ADH1B///ADH1C 8.899369 9.618607 10.684844

AGAP11///ADIRF

11.769862 15.264290 14.838765

AK4P3///AK4P1///AK4

10.273964 8.519981

8.572399

> exprs(expandProbesets(X))[,1:3]

ACOT1

ACOT2

GSM2505

GSM2506

GSM2507

11.324354 11.149031 10.847654

11.324354 11.149031 10.847654

ACTBP11

15.257080 15.123444 15.008748

ACTB

ACY1

15.257080 15.123444 15.008748

10.733768 12.309362 11.906228

ABHD14A-ACY1 10.733768 12.309362 11.906228

AGAP11

11.769862 15.264290 14.838765

ADIRF

ADH1A

ADH1B

ADH1C

AK4P3

AK4P1

AK4

11.769862 15.264290 14.838765

8.899369 9.618607 10.684844

8.899369 9.618607 10.684844

8.899369 9.618607 10.684844

10.273964 8.519981 8.572399

10.273964 8.519981 8.572399

10.273964 8.519981 8.572399

5

curatedBladderData

A

Available Clinical Characteristics

Figure 1: Available clinical annotation. This heatmap visualizes for each curated clinical characteris-
tic (rows) the availability in each dataset (columns). Red indicates that the corresponding characteris-
tic is available for at least one sample in the dataset. This plot is Figure 2 of the curatedBladderData
manuscript.

B

Summarizing the List of ExpressionSets

This example provides a table summarizing the datasets being used, and is useful when
publishing analyses based on curatedBladderData. First, define some useful functions for this
purpose:

> source(system.file("extdata", "summarizeEsets.R", package =

+

"curatedBladderData"))

Optionally write this table to file, for example ( replace myfile <- tempfile() with something
like myfile <- “nicetable.csv” )

> (myfile <- tempfile())

[1] "/tmp/RtmpfS7H1Q/file140131670c62f"

6

GSE31684PMID17099711.GPL8300PMID17099711.GPL91GSE1827GSE13507GSE32894GSE5287GSE37317GSE31189GSE89GSE19915.GPL3883GSE19915.GPL5186uncurated_author_metadatabatchnomogram_scoresmoking_package_yearssmoking_statusdfs_eventvital_statusdays_to_deathrecurrence_statusdays_to_tumor_recurrenceadjuvant_regimenadjuvant_chemoneoadjuvant_regimenneoadjuvant_chemoecog_psgenderagelymphovascular_invasionvisceral_metastasisMNGsubstageTsummarystagesummarygradehistological_typesurgery_typesample_typecuratedBladderData

> write.table(summary.table, file=myfile, row.names=FALSE, quote=TRUE, sep=",")

7

curatedBladderData

m
r
o
f
t
a
P

l

l

y
g
o
o
t
s
i
h

e
g
a
t
s

s
e
l
p
m
a
s
N

K
5
3

1
.
0
.
3
v
_
H
E
N
E
G
E
W
S

K
7
2

n
a
m
u
H
e
n
e
g
e
w
S

E
K
A
J

l

-

2
s
u
P
3
3
1
U
G
H
x
i
r
t
e
m
y
ff
A

l

-

2
s
u
P
3
3
1
U
G
H
x
i
r
t
e
m
y
ff
A

0
/
6
/
0
/
4
7

4
8
/
0
/
0
/
0

8
9
/
0
/
0
/
0

2
9
/
0
/
0
/
0

0
/
5
/
2
/
6
8

0
/
3
5
/
7
2

9
/
2
/
3
7

0
1
/
5
4
/
3
4

0
/
8
7
/
5
1

2
9
/
0
/
0

0
.
2
v

6
-
n
a
m
u
h

i

a
n
m
u

l
l
I

5
5
2
/
0
/
0
/
0

0
9
/
2
6
/
3
0
1

0
.
3
V

2
1
-
T
H
n
a
m
u
H
a
n
m
u

i

l
l
I

8
0
3
/
0
/
0
/
0

2
/
3
9
/
3
1
2

-

A
3
3
1
U
G
H
x
i
r
t
e
m
y
ff
A

-

A
3
3
1
U
G
H
x
i
r
t
e
m
y
ff
A

L
F
e
n
e
G
u
H
x
i
r
t
e
m
y
ff
A

2
v
A
5
9
U
x
i
r
t
e
m
y
ff
A

A
5
9
U
x
i
r
t
e
m
y
ff
A

0
/
1
/
0
/
8
1

0
3
/
0
/
0
/
0

0
4
/
0
/
0
/
0

0
3
/
0
/
0
/
0

1
3
/
0
/
0
/
0

0
/
1
1
/
8

0
/
0
3
/
0

0
/
9
/
1
3

0
/
4
1
/
6
1

5
/
7
1
/
9

5
5
2

0
8

4
8

8
9

2
9

3
9

8
0
3

9
1

0
3

0
4

0
3

1
3

9
6
7
9
5
0
0
2

9
3
3
0
3
9
5
1

6
7
9
6
0
4
0
2

6
7
9
6
0
4
0
2

9
7
5
7
9
0
3
2

6
3
6
8
2
2
2
2

7
4
3
3
5
5
2
2

3
6
0
6
8
5
2
2

3
2
1
1
7
6
7
1

3
2
1
9
6
4
2
1

1
1
7
9
9
0
7
1

1
1
7
9
9
0
7
1

I

D
M
P

9
8
1
1
3
E
S
G

4
8
6
1
3
E
S
G

4
9
8
2
3
E
S
G

7
1
3
7
3
E
S
G

7
8
2
5
E
S
G

9
8
E
S
G

7
2
8
1
E
S
G

7
0
5
3
1
E
S
G

3
8
8
3
L
P
G
.
5
1
9
9
1
E
S
G

6
8
1
5
L
P
G
.
5
1
9
9
1
E
S
G

1
9
L
P
G
.
1
1
7
9
9
0
7
1
D
M
P

I

0
0
3
8
L
P
G
.
1
1
7
9
9
0
7
1
D
M
P

I

.
a
t
a
D
r
e
d
d
a
B
d
e
t
a
r
u
c

l

y
b

d
e
d
i
v
o
r
p

s
t
e
s
a
t
a
D

:
1

e
l
b
a
T

8

curatedBladderData

C

For non-R users

If you are not doing your analysis in R, and just want to get some data you have identified
from the curatedBladderData manual, here is a simple way to do it. For one dataset:

> library(curatedBladderData)

> library(affy)
> data(GSE89_eset)
> write.csv(exprs(GSE89_eset), file="GSE89_eset_exprs.csv")
> write.csv(pData(GSE89_eset), file="GSE89_eset_clindata.csv")

Or for several datasets:

> data.to.fetch <- c("GSE89_eset", "GSE37317_eset")
> for (onedata in data.to.fetch){

print(paste("Fetching", onedata))

data(list=onedata)
write.csv(exprs(get(onedata)), file=paste(onedata, "_exprs.csv", sep=""))
write.csv(pData(get(onedata)), file=paste(onedata, "_clindata.csv", sep=""))

+

+

+

+

+ }

D

Session Info

• R version 4.5.1 Patched (2025-08-23 r88802), x86_64-pc-linux-gnu

• Locale: LC_CTYPE=en_US.UTF-8, LC_NUMERIC=C, LC_TIME=en_GB, LC_COLLATE=C,
LC_MONETARY=en_US.UTF-8, LC_MESSAGES=en_US.UTF-8, LC_PAPER=en_US.UTF-8,
LC_NAME=C, LC_ADDRESS=C, LC_TELEPHONE=C, LC_MEASUREMENT=en_US.UTF-8,
LC_IDENTIFICATION=C

• Time zone: America/New_York

• TZcode source: system (glibc)

• Running under: Ubuntu 24.04.3 LTS

• Matrix products: default

• BLAS: /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

• LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

• Base packages: base, datasets, grDevices, graphics, methods, stats, utils

• Other packages: Biobase 2.70.0, BiocGenerics 0.56.0, BiocParallel 1.44.0, affy 1.88.0,

curatedBladderData 1.46.0, genefilter 1.92.0, generics 0.1.4, logging 0.10-108,
mgcv 1.9-3, nlme 3.1-168, survival 3.8-3, sva 3.58.0, xtable 1.8-4

• Loaded via a namespace (and not attached): AnnotationDbi 1.72.0,

BiocManager 1.30.26, BiocStyle 2.38.0, Biostrings 2.78.0, DBI 1.2.3, IRanges 2.44.0,
KEGGREST 1.50.0, Matrix 1.7-4, MatrixGenerics 1.22.0, R6 2.6.1, RSQLite 2.4.3,
S4Vectors 0.48.0, Seqinfo 1.0.0, XML 3.99-0.19, XVector 0.50.0, affyio 1.80.0,
annotate 1.88.0, bit 4.6.0, bit64 4.6.0-1, blob 1.2.4, cachem 1.1.0, cli 3.6.5,
codetools 0.2-20, compiler 4.5.1, crayon 1.5.3, digest 0.6.37, edgeR 4.8.0,
evaluate 1.0.5, fastmap 1.2.0, grid 4.5.1, htmltools 0.5.8.1, httr 1.4.7, knitr 1.50,

9

curatedBladderData

lattice 0.22-7, limma 3.66.0, locfit 1.5-9.12, matrixStats 1.5.0, memoise 2.0.1,
parallel 4.5.1, png 0.1-8, preprocessCore 1.72.0, rlang 1.1.6, rmarkdown 2.30,
splines 4.5.1, statmod 1.5.1, stats4 4.5.1, tools 4.5.1, vctrs 0.6.5, xfun 0.54,
yaml 2.3.10

10

