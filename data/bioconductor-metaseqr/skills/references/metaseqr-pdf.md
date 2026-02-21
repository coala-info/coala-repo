RNA-Seq data analysis using mulitple statistical algorithms
with metaseqR

Panagiotis Moulos

January 4, 2019

During the past few years, a lot of R/Bioconductor packages have been developped for the analysis of
RNA-Seq data, introducing several approaches. For example, packages using the negative binomial distri-
bution to model the null hypotheses (DESeq, edgeR, NBPSeq) or packages using Bayesian statistics (baySeq,
EBSeq). In addition, packages specialized to RNA-Seq data normalization have also been developed (EDASeq).
The package metaseqR (pronounced meta-seek-er) tries to provide an interface to several algorithms, similar
to the recent TCC package. However, it is much simpler to use than TCC, incoporates more algorithms for
normalization and statistical analysis and builds a full report with several interactive and non-interactive
diagnostic plots so that the users can easily explore the results and have whatever they need for this part
of their research in one place. The metaseqR report is one of its most strong points as it provides an au-
tomatically generated summary, based on the pipeline inputs and the results, which can be used directly
as a draft in methods paragraph in scientiﬁc publications. It also provides a lot of diagnostic ﬁgures and
each ﬁgure is accompanied by a small explanatory text, and a list of references accroding to the algorithms
used in the pipeline, which can also be used in a scientiﬁc article. All the report components are grouped
in a comprehensive way, with a table of contents. Most importantly, metaseqR provides an interface for
RNA-Seq data meta-analysis by providing the ability to use different algorithms for the statistical testing part
and combining the p-values using popular published methods (e.g. Fisher’s method, Whitlock’s method)
and two package-speciﬁc methods (intersection, union of statistically signiﬁcant results). In the future, more
algorithms will be incorporated in the package, with more diagnostic plots and more examples. This initial
vignette contains just this introductory text and reference to some examples in the package documentation,
which we believe that at this point contains sufﬁcient explanation to run the metaseqr pipeline. Throughout
the rest of this document, metaseqr refers to the name of the analysis pipeline while metaseqR refers to the
name of the package.

1 Getting started

Detailed instructions on how to run the metaseqr pipeline can be found under the main documentation of
the metaseqR package:

library(metaseqR)
help(metaseqr) # or
help(metaseqr.main)

Brieﬂy, to run metaseqr you need:

• A text tab delimited ﬁle in a spreadsheet like format containing at least unique gene identiﬁers (corre-

sponding to one of metaseqR’s supported formats, for the time being Ensembl)

• A list of statistical contrasts for which you wish to check differential expression

• An internet connection so that the interactive parts of the report can be properly rendered, as the report
template points to external Content Delivery Networks (CDNs) distributing the appropriate JavaScript

Everything else (e.g. genomic regions annotation etc.) can be handled by the metaseqr pipeline. Some

example data are included in the package. See the related help pages:

help(hg18.exon.data)
help(mm9.gene.data)

1

2 Running the metaseqr pipeline

Running a metaseqr pipeline instance is quite straightforward. Again, see the examples in the main help
page. An example and the command window output follow:

data("mm9.gene.data",package="metaseqR")

head(mm9.gene.counts)

##
## ENSMUSG00000090699
## ENSMUSG00000092168
## ENSMUSG00000079179
## ENSMUSG00000020671
## ENSMUSG00000069181
## ENSMUSG00000020668
##
## ENSMUSG00000090699
## ENSMUSG00000092168
## ENSMUSG00000079179
## ENSMUSG00000020671
## ENSMUSG00000069181
## ENSMUSG00000020668
##
## ENSMUSG00000090699
## ENSMUSG00000092168
## ENSMUSG00000079179
## ENSMUSG00000020671
## ENSMUSG00000069181
## ENSMUSG00000020668

chromosome

start

gene_id
end
chr12 3023883 3025753 ENSMUSG00000090699
chr12 3082667 3087041 ENSMUSG00000092168
chr12 3236611 3249999 ENSMUSG00000079179
chr12 3247430 3309969 ENSMUSG00000020671
chr12 3343816 3357153 ENSMUSG00000069181
chr12 3365132 3406494 ENSMUSG00000020668

gc_content strand transcripts
Gm9071
1
1
Gm9075
1 1700012B15Rik
Rab10
1
Gm17681
1
Kif3c
3

gene_name e14.5_1
2
0
838
1868
15
162

0.4441
0.4649
0.4178
0.4023
0.4508
0.4756

+
+
+
-
-
+

e14.5_2 a8w_1 a8w_2
25
0
261
807
28
122

5
0
718
2004
18
155

11
1
366
977
14
126

sample.list.mm9

## $e14.5
## [1] "e14.5_1" "e14.5_2"
##
## $adult_8_weeks
## [1] "a8w_1" "a8w_2"

libsize.list.mm9

## $e14.5_1
## [1] 3102907
##
## $e14.5_2
## [1] 2067905
##
## $a8w_1
## [1] 3742059
##
## $a8w_2
## [1] 4403954

Following is a full example with the informative messages that are printed in the command window:

library(metaseqR)
data("mm9.gene.data",package="metaseqR")
result <- metaseqr(

counts=mm9.gene.counts,

2

sample.list=sample.list.mm9,
contrast=c("e14.5_vs_adult_8_weeks"),
libsize.list=libsize.list.mm9,
annotation="download",
org="mm9",
count.type="gene",
normalization="edger",
statistics="edger",
pcut=0.05,
fig.format=c("png","pdf"),
export.what=c("annotation","p.value","meta.p.value",

"adj.meta.p.value","fold.change"),

export.scale=c("natural","log2"),
export.values="normalized",
export.stats=c("mean","sd","cv"),
export.where="~/metaseqr_test",
restrict.cores=0.8,
gene.filters=list(
length=list(

length=500

),
avg.reads=list(

average.per.bp=100,
quantile=0.25

),
expression=list(

median=TRUE,
mean=FALSE,
quantile=NA,
known=NA,
custom=NA

),
biotype=get.defaults("biotype.filter","mm9")

),
out.list=TRUE

)

3102907
2067905

e14.5, adult_8_weeks

e14.5_vs_adult_8_weeks

Data processing started...

imported custom data frame

##
## 2019-01-04 20:07:56:
##
## Read counts file:
## Conditions:
## Samples to include: e14.5_1, e14.5_2, a8w_1, a8w_2
## Samples to exclude: none
## Requested contrasts:
## Library sizes:
e14.5_1:
##
e14.5_2:
##
a8w_1:
##
##
a8w_2:
## Annotation:
## Organism:
## Reference source: ensembl
## Count type:
## Transcriptional level:
## Exon filters:
min.active.exons:
##
exons.per.gene:
##
min.exons:
##
##
0.2
frac:
## Gene filters:

min.active.exons

3742059
4403954

download

gene

gene

mm9

5

2

length, avg.reads, expression, biotype

3

NA

NA

NA

500

100

TRUE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

length:

biotype:

length:
avg.reads:

average.per.bp:
quantile:
0.25
expression:
median:
mean:
quantile:
known:
custom:

pseudogene:
snRNA: FALSE
protein_coding:
antisense:
miRNA: FALSE
lincRNA: FALSE
snoRNA: FALSE
processed_transcript: FALSE
misc_RNA: FALSE
rRNA: TRUE
sense_overlapping:
sense_intronic:
polymorphic_pseudogene: FALSE
non_coding:
FALSE
three_prime_overlapping_ncrna:
FALSE
IG_C_gene:
FALSE
IG_J_gene:
FALSE
IG_D_gene:
FALSE
IG_V_gene:
ncrna_host:

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
## Filter application: postnorm
## Normalization algorithm:
## Normalization arguments:
##
##
##
##
##
##
## Statistical algorithm:
## Statistical arguments:
##
NULL, NULL, NULL, NULL, 0.125, NULL, auto, chisq, TRUE, FALSE, c(0.05, 0.1)
## Meta-analysis method:
## Multiple testing correction:
## p-value threshold: 0.05
## Logarithmic transformation offset:
## Quality control plots: mds, biodetection, countsbio, saturation, readnoise, filtered, correl,
pairwise, boxplot, gcbias, lengthbias, meandiff, meanvar, rnacomp, deheatmap, volcano, biodist
## Figure format:
## Output directory: ~/metaseqr_test
## Output data:
## Output scale(s): natural, log2
## Output values:
## Downloading gene annotation for mm9...
## Saving gene model to ~/metaseqr_test/data/gene_model.RData
## Removing genes with zero counts in all samples...
## Normalizing with: edger

method:
logratioTrim:
sumTrim:
doWeighting:
Acutoff:
0.75
p:

annotation, p.value, meta.p.value, adj.meta.p.value, fold.change

classic, 5, 10, movingave, NULL, grid, 11, c(-6, 6), NULL, CoxReid, 10000, NULL, auto,

normalized

png, pdf

edger:

-1e+10

FALSE

edger

edger

TRUE

none

0.05

0.3

TMM

BH

1

4

0.0659670745106788

found 906 genes

edger

500

68

rRNA

Contrast:

e14.5_vs_adult_8_weeks

Threshold below which ignored:

Contrast:
Contrast e14.5_vs_adult_8_weeks:

## Applying gene filter length...
##
## Applying gene filter avg.reads...
##
Threshold below which ignored:
## Applying gene filter expression...
Threshold below which ignored:
##
## Applying gene filter biotype...
##
Biotypes ignored:
## 2106 genes filtered out
## 1681 genes remain after filtering
## Running statistical tests with:
##
##
## Building output files...
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
## Creating quality control graphs...
## Plotting in png format...
##
##

Plotting mds...
Plotting biodetection...

Adding non-filtered data...

e14.5_vs_adult_8_weeks

Writing output...

binding annotation...
binding p-values...
binding natural normalized fold changes...
binding log2 normalized fold changes...

Writing output...
Adding filtered data...
binding annotation...
binding p-values...
binding natural normalized fold changes...
binding log2 normalized fold changes...

## Biotypes detection is to be computed for:
"a8w_2"
## [1] "e14.5_1" "e14.5_2" "a8w_1"

##
##

Plotting countsbio...

## [1] "Count distributions are to be computed for:"
## [1] "e14.5_1" "e14.5_2" "a8w_1"

"a8w_2"

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

Plotting saturation...
Plotting readnoise...
Plotting correl...
Plotting pairwise...
Plotting boxplot...
Plotting gcbias...
Plotting lengthbias...
Plotting meandiff...
Plotting meanvar...
Plotting rnacomp...

## [1] "Reference sample is: e14.5_1"
## [1] "Confidence intervals for median of M:"
##
0.83%
## e14.5_2 "0.30473844613"
## a8w_1
## a8w_2
## [1] "Diagnostic test: FAILED. Normalization is required to correct this bias."

Diagnostic Test
99.17%
"0.30473844613"
"FAILED"
"-1.09054872874547"
"-0.868812835466484" "FAILED"
"-0.946582152028315" "-0.718317883147803" "FAILED"

##
##

Plotting boxplot...

5

##
##
##
##
##

Plotting gcbias...
Plotting lengthbias...
Plotting meandiff...
Plotting meanvar...
Plotting rnacomp...

0.83%

## [1] "Reference sample is: e14.5_1"
## [1] "Confidence intervals for median of M:"
##
## e14.5_2 "0.338128778907005"
## a8w_1
## a8w_2
## [1] "Diagnostic test: FAILED. Normalization is required to correct this bias."

Diagnostic Test
99.17%
"0.338128778907005"
"FAILED"
"-0.919761155497175" "FAILED"
"-1.0797077447647"
"-0.942909662422721" "-0.808649511996693" "FAILED"

##
##
##
##
##
##
##

Plotting deheatmap...
Contrast:
Plotting volcano...
Contrast:
Plotting biodist...
Contrast:

e14.5_vs_adult_8_weeks

e14.5_vs_adult_8_weeks

e14.5_vs_adult_8_weeks

## [1] "775 differentially expressed features"

##
##
Plotting filtered...
## Plotting in pdf format...
##
##

Plotting mds...
Plotting biodetection...

## Biotypes detection is to be computed for:
"a8w_2"
## [1] "e14.5_1" "e14.5_2" "a8w_1"

##
##

Plotting countsbio...

## [1] "Count distributions are to be computed for:"
## [1] "e14.5_1" "e14.5_2" "a8w_1"

"a8w_2"

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

Plotting saturation...
Plotting readnoise...
Plotting correl...
Plotting pairwise...
Plotting boxplot...
Plotting gcbias...
Plotting lengthbias...
Plotting meandiff...
Plotting meanvar...
Plotting rnacomp...

## [1] "Reference sample is: e14.5_1"
## [1] "Confidence intervals for median of M:"
##
0.83%
## e14.5_2 "0.30473844613"
## a8w_1
## a8w_2
## [1] "Diagnostic test: FAILED. Normalization is required to correct this bias."

Diagnostic Test
99.17%
"0.30473844613"
"FAILED"
"-1.08496666578228"
"-0.882564803379541" "FAILED"
"-0.932606133042183" "-0.724189730691867" "FAILED"

##
##
##
##
##
##
##

Plotting boxplot...
Plotting gcbias...
Plotting lengthbias...
Plotting meandiff...
Plotting meanvar...
Plotting rnacomp...

6

0.83%

## [1] "Reference sample is: e14.5_1"
## [1] "Confidence intervals for median of M:"
Diagnostic Test
99.17%
##
"0.338128778907005"
"FAILED"
## e14.5_2 "0.338128778907005"
"-1.08861763649592"
## a8w_1
"-0.919761155497175" "FAILED"
"-0.946255477299783" "-0.808649511996693" "FAILED"
## a8w_2
## [1] "Diagnostic test: FAILED. Normalization is required to correct this bias."

##
##
##
##
##
##
##

e14.5_vs_adult_8_weeks

Plotting deheatmap...
Contrast:
Plotting volcano...
Contrast:
Plotting biodist...
Contrast:

e14.5_vs_adult_8_weeks

e14.5_vs_adult_8_weeks

## [1] "775 differentially expressed features"

Plotting filtered...

##
##
## Creating HTML report...
## Compressing figures...
##
## 2019-01-04 20:08:22:
##
##
## Total processing time: 25 seconds

Data processing finished!

To get a glimpse on the results, run:

head(result[["data"]][["e14.5_vs_adult_8_weeks"]])

##
## ENSMUSG00000058207
## ENSMUSG00000079012
## ENSMUSG00000066361
## ENSMUSG00000091553
## ENSMUSG00000074207
## ENSMUSG00000089635
##
## ENSMUSG00000058207
## ENSMUSG00000079012
## ENSMUSG00000066361
## ENSMUSG00000091553
## ENSMUSG00000074207
## ENSMUSG00000089635
##
## ENSMUSG00000058207
## ENSMUSG00000079012
## ENSMUSG00000066361
## ENSMUSG00000091553
## ENSMUSG00000074207
## ENSMUSG00000089635
##
## ENSMUSG00000058207
## ENSMUSG00000079012
## ENSMUSG00000066361
## ENSMUSG00000091553
## ENSMUSG00000074207
## ENSMUSG00000089635
##
## ENSMUSG00000058207

chromosome

end

start

gene_id
chr12 105576696 105583951 ENSMUSG00000058207
chr12 105625374 105632467 ENSMUSG00000079012
chr12 105384592 105392080 ENSMUSG00000066361
chr12 105427727 105431136 ENSMUSG00000091553
chr3 137923955 137953662 ENSMUSG00000074207
chr3 137944372 137969986 ENSMUSG00000089635

gc_content strand
+
+
-
- Serpina3e-ps
+
-

gene_name
biotype
Serpina3k protein_coding
Serpina3m protein_coding
Serpina3c protein_coding
pseudogene
Adh1 protein_coding
antisense

47.53
47.77
48.06
47.65
41.02
42.05

Gm16559

p-value_edger
3.286503e-64
4.278067e-46
2.989298e-44
3.114273e-43
5.271837e-41
8.042133e-41

natural_normalized_fold_change_e14.5_vs_adult_8_weeks
104862.5000
2951.7500
16047.5000
1055.0000
625.5600
652.8095

log2_normalized_fold_change_e14.5_vs_adult_8_weeks
16.678139

7

## ENSMUSG00000079012
## ENSMUSG00000066361
## ENSMUSG00000091553
## ENSMUSG00000074207
## ENSMUSG00000089635

11.527355
13.970061
10.043027
9.289004
9.350518

Check the HTML report generated in the output directory deﬁned by the export.where argument above.
Now, the same example but with more than one statistical selection algorithms, a different normalization,

an analysis preset and ﬁltering applied prior to normalization:

library(metaseqR)
data("mm9.gene.data",package="metaseqR")
result <- metaseqr(

counts=mm9.gene.counts,
sample.list=sample.list.mm9,
contrast=c("e14.5_vs_adult_8_weeks"),
libsize.list=libsize.list.mm9,
annotation="download",
org="mm9",
count.type="gene",
when.apply.filter="prenorm",
normalization="edaseq",
statistics=c("deseq","edger"),
meta.p="fisher",
qc.plots=c(

"mds","biodetection","countsbio","saturation","readnoise","filtered",
"correl","pairwise","boxplot","gcbias","lengthbias","meandiff",
"meanvar","rnacomp","deheatmap","volcano","biodist","venn"

),
fig.format=c("png","pdf"),
preset="medium.normal",
export.where="~/metaseqr_test2",
out.list=TRUE

)

e14.5, adult_8_weeks

e14.5_vs_adult_8_weeks

Data processing started...

imported custom data frame

VennDiagram
grid
futile.logger

## Loading required package:
## Loading required package:
## Loading required package:
##
## 2019-01-04 20:08:22:
##
## Read counts file:
## Conditions:
## Samples to include: e14.5_1, e14.5_2, a8w_1, a8w_2
## Samples to exclude: none
## Requested contrasts:
## Library sizes:
e14.5_1:
##
e14.5_2:
##
a8w_1:
##
##
a8w_2:
## Annotation:
## Organism:
## Reference source: ensembl
## Count type:
## Analysis preset: medium.normal
## Transcriptional level:
## Exon filters:
##
##
##

min.active.exons:
exons.per.gene:
min.exons:

min.active.exons

3102907
2067905

3742059
4403954

download

gene

gene

mm9

2

5

8

NA

NA

NA

500

100

TRUE

FALSE

FALSE

FALSE

FALSE

FALSE

FALSE

biotype:

length:
avg.reads:

length, avg.reads, expression, biotype

average.per.bp:
quantile:
0.25
expression:
median:
mean:
quantile:
known:
custom:

pseudogene:
snRNA: FALSE
protein_coding:
antisense:
miRNA: FALSE
lincRNA: FALSE
snoRNA: FALSE
processed_transcript: FALSE
misc_RNA: FALSE
rRNA: TRUE
sense_overlapping:
sense_intronic:
polymorphic_pseudogene: FALSE
non_coding:
FALSE
three_prime_overlapping_ncrna:
FALSE
IG_C_gene:
FALSE
IG_J_gene:
FALSE
IG_D_gene:
IG_V_gene:
FALSE
ncrna_host:

##
0.2
frac:
## Gene filters:
##
length:
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
## Filter application: prenorm
## Normalization algorithm:
## Normalization arguments:
##
##
## Statistical algorithm:
## Statistical arguments:
##
##
NULL, NULL, NULL, NULL, 0.125, NULL, auto, chisq, TRUE, FALSE, c(0.05, 0.1)
## Meta-analysis method:
## Multiple testing correction:
## p-value threshold: 0.05
## Logarithmic transformation offset:
## Analysis preset: medium.normal
## Quality control plots: mds, biodetection, countsbio, saturation, readnoise, filtered, correl,
pairwise, boxplot, gcbias, lengthbias, meandiff, meanvar, rnacomp, deheatmap, volcano, biodist,
venn
## Figure format:
## Output directory: ~/metaseqr_test2
## Output data:
stats, counts
## Output scale(s): natural, log2
## Output values:
## Output statistics: mean, sd, cv
##

blind, fit-only, local
classic, 5, 10, movingave, NULL, grid, 11, c(-6, 6), NULL, CoxReid, 10000, NULL, auto,

annotation, p.value, adj.p.value, meta.p.value, adj.meta.p.value, fold.change,

within.which:
between.which:

deseq:
edger:

deseq, edger

loess
full

normalized

png, pdf

fisher

edaseq

FALSE

FALSE

BH

1

9

500

rRNA

101.5

edger

deseq

edaseq

Contrast:

found 333 genes

found 925 genes

Biotypes ignored:

0.0983646994748505

e14.5_vs_adult_8_weeks

e14.5_vs_adult_8_weeks

e14.5_vs_adult_8_weeks

Adding non-filtered data...

Threshold below which ignored:

Contrast:
Contrast e14.5_vs_adult_8_weeks:

## Downloading gene annotation for mm9...
## Saving gene model to ~/metaseqr_test2/data/gene_model.RData
## Removing genes with zero counts in all samples...
## Prefiltering normalization with:
## Applying gene filter length...
##
## Applying gene filter avg.reads...
##
Threshold below which ignored:
## Applying gene filter expression...
##
Threshold below which ignored:
## Applying gene filter biotype...
##
## Normalizing with: edaseq
## 2110 genes filtered out
## 1677 genes remain after filtering
## Running statistical tests with:
##
##
## Running statistical tests with:
Contrast:
##
##
Contrast e14.5_vs_adult_8_weeks:
## Performing meta-analysis with fisher
## Building output files...
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
## Creating quality control graphs...
## Plotting in png format...

Writing output...
Adding filtered data...
binding annotation...
binding p-values...
binding FDRs...
binding meta p-values...
binding adjusted meta p-values...
binding natural normalized fold changes...
binding log2 normalized fold changes...
binding normalized mean counts...
binding normalized count sds...
binding normalized count CVs...
binding normalized mean counts...
binding normalized count sds...
binding normalized count CVs...
binding all normalized counts for e14.5...
binding all normalized counts for adult_8_weeks...

binding annotation...
binding p-values...
binding FDRs...
binding meta p-values...
binding adjusted meta p-values...
binding natural normalized fold changes...
binding log2 normalized fold changes...
binding normalized mean counts...
binding normalized count sds...
binding normalized count CVs...
binding normalized mean counts...
binding normalized count sds...
binding normalized count CVs...
binding all normalized counts for e14.5...
binding all normalized counts for adult_8_weeks...

Writing output...

10

##
##

Plotting mds...
Plotting biodetection...

## Biotypes detection is to be computed for:
"a8w_2"
## [1] "e14.5_1" "e14.5_2" "a8w_1"

##
##

Plotting countsbio...

## [1] "Count distributions are to be computed for:"
## [1] "e14.5_1" "e14.5_2" "a8w_1"

"a8w_2"

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

Plotting saturation...
Plotting readnoise...
Plotting correl...
Plotting pairwise...
Plotting boxplot...
Plotting gcbias...
Plotting lengthbias...
Plotting meandiff...
Plotting meanvar...
Plotting rnacomp...

## [1] "Reference sample is: e14.5_1"
## [1] "Confidence intervals for median of M:"
##
0.83%
## e14.5_2 "0.30473844613"
## a8w_1
## a8w_2
## [1] "Diagnostic test: FAILED. Normalization is required to correct this bias."

Diagnostic Test
99.17%
"0.30473844613"
"FAILED"
"-1.08620142905774"
"-0.880679794749017" "FAILED"
"-0.944870408559306" "-0.726716086385111" "FAILED"

##
##
##
##
##
##
##

Plotting boxplot...
Plotting gcbias...
Plotting lengthbias...
Plotting meandiff...
Plotting meanvar...
Plotting rnacomp...

0.83%

## [1] "Reference sample is: e14.5_1"
## [1] "Confidence intervals for median of M:"
##
## e14.5_2 "0"
## a8w_1
## a8w_2
## [1] "Diagnostic test: FAILED. Normalization is required to correct this bias."

Diagnostic Test
99.17%
"0.0430247498795765"
"PASSED"
"-0.00803057701722073" "FAILED"
"FAILED"

"-0.22646732347622"
"-0.290901199266738" "-0.0406419844973458"

##
##
##
##
##
##
##

e14.5_vs_adult_8_weeks

Plotting deheatmap...
Contrast:
Plotting volcano...
Contrast:
Plotting biodist...
Contrast:

e14.5_vs_adult_8_weeks

e14.5_vs_adult_8_weeks

## [1] "825 differentially expressed features"

Plotting filtered...
Plotting venn...
Contrast:

##
##
##
##
## Plotting in pdf format...
##
##

Plotting mds...
Plotting biodetection...

e14.5_vs_adult_8_weeks

11

## Biotypes detection is to be computed for:
"a8w_2"
## [1] "e14.5_1" "e14.5_2" "a8w_1"

##
##

Plotting countsbio...

## [1] "Count distributions are to be computed for:"
## [1] "e14.5_1" "e14.5_2" "a8w_1"

"a8w_2"

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

Plotting saturation...
Plotting readnoise...
Plotting correl...
Plotting pairwise...
Plotting boxplot...
Plotting gcbias...
Plotting lengthbias...
Plotting meandiff...
Plotting meanvar...
Plotting rnacomp...

## [1] "Reference sample is: e14.5_1"
## [1] "Confidence intervals for median of M:"
##
0.83%
## e14.5_2 "0.30473844613"
## a8w_1
## a8w_2
## [1] "Diagnostic test: FAILED. Normalization is required to correct this bias."

Diagnostic Test
99.17%
"0.30473844613"
"FAILED"
"-0.879327314119298" "FAILED"
"-1.08991977325346"
"-0.944215784563569" "-0.725495656191857" "FAILED"

##
##
##
##
##
##
##

Plotting boxplot...
Plotting gcbias...
Plotting lengthbias...
Plotting meandiff...
Plotting meanvar...
Plotting rnacomp...

0.83%

## [1] "Reference sample is: e14.5_1"
## [1] "Confidence intervals for median of M:"
##
## e14.5_2 "0"
## a8w_1
## a8w_2
## [1] "Diagnostic test: FAILED. Normalization is required to correct this bias."

Diagnostic Test
"PASSED"
"-0.214124805352847" "-0.0108883161427366" "FAILED"
"-0.294620748891627" "-0.0237472694912659" "FAILED"

99.17%
"0.042917977934705"

##
##
##
##
##
##
##

e14.5_vs_adult_8_weeks

Plotting deheatmap...
Contrast:
Plotting volcano...
Contrast:
Plotting biodist...
Contrast:

e14.5_vs_adult_8_weeks

e14.5_vs_adult_8_weeks

## [1] "825 differentially expressed features"

e14.5_vs_adult_8_weeks

Plotting filtered...
Plotting venn...
Contrast:

##
##
##
##
## Creating HTML report...
## Compressing figures...
##
## 2019-01-04 20:08:54:
##
##
## Total processing time: 31 seconds

Data processing finished!

12

A similar example with no ﬁltering applied and no Venn diagram generation (not evaluated here):

library(metaseqR)
data("mm9.gene.data",package="metaseqR")
result <- metaseqr(

counts=mm9.gene.counts,
sample.list=sample.list.mm9,
contrast=c("e14.5_vs_adult_8_weeks"),
libsize.list=libsize.list.mm9,
annotation="download",
org="mm9",
count.type="gene",
normalization="edaseq",
statistics=c("deseq","edger"),
meta.p="fisher",
fig.format=c("png","pdf"),
preset="medium.normal",
out.list=TRUE

)

An additional example with human exon data (if you have a multiple core system, be very careful on
how you are using the restrict.cores option and generally how many cores you are using with scripts purely
written in R. The analysis with exon read data can very easily cause memory problems, so unless you have
more than 64Gb of RAM available, consider setting restrict.cores to something like 0.2):

# A full example pipeline with exon counts
data("hg19.exon.data",package="metaseqR")
metaseqr(

counts=hg19.exon.counts,
sample.list=sample.list.hg19,
contrast=c("normal_vs_paracancerous","normal_vs_cancerous",

"normal_vs_paracancerous_vs_cancerous"),

libsize.list=libsize.list.hg19,
id.col=4,
annotation="download",
org="hg19",
count.type="exon",
normalization="edaseq",
statistics="deseq",
pcut=0.05,
qc.plots=c(

"mds","biodetection","countsbio","saturation","rnacomp","pairwise",
"boxplot","gcbias","lengthbias","meandiff","meanvar","correl",
"deheatmap","volcano","biodist","filtered"

),
fig.format=c("png","pdf"),
export.what=c("annotation","p.value","adj.p.value","fold.change","stats","counts"),
export.scale=c("natural","log2","log10","vst"),
export.values=c("raw","normalized"),
export.stats=c("mean","median","sd","mad","cv","rcv"),
restrict.cores=0.8,
gene.filters=list(
length=list(

length=500

),
avg.reads=list(

average.per.bp=100,
quantile=0.25

),
expression=list(

median=TRUE,

13

mean=FALSE

),
biotype=get.defaults("biotype.filter","hg19")

)

)

or in a more simpliﬁed version

# A full example pipeline with exon counts
data("hg19.exon.data",package="metaseqR")
metaseqr(

counts=hg19.exon.counts,
sample.list=sample.list.hg19,
contrast=c("normal_vs_paracancerous","normal_vs_cancerous",

"normal_vs_paracancerous_vs_cancerous"),

libsize.list=libsize.list.hg19,
id.col=4,
annotation="download",
org="hg19",
count.type="exon",
normalization="edaseq",
statistics="deseq",
preset="medium.normal",
restrict.cores=0.8

)

One of the main strong points of metaseqR is the use of the area under False Discovery Curves to assess
the performance of each statistical test with simulated datasets created from true datasets (e.g. your dataset).
Then, the performance assessment can be used to construct p-value weights for each test and use these
weights to supply the “weight” parameter of metaseqr when “meta.p” is “weight” or “whitlock” (see the
next sections for p-value combination methods). The following example shows how to create such weights
(depending on the size of the dataset, it might take some time to run):

data("mm9.gene.data",package="metaseqR")
multic <- check.parallel(0.8)
weights <- estimate.aufc.weights(

counts=as.matrix(mm9.gene.counts[,9:12]),
normalization="edaseq",
statistics=c("edger","limma"),
nsim=1,N=10,ndeg=c(2,2),top=4,model.org="mm9",
seed=42,multic=multic,libsize.gt=1e+5

)

zoo

index, index<-

as.Date, as.Date.numeric

## Loading required package:
##
## Attaching package: ’zoo’
## The following objects are masked from ’package:Rsamtools’:
##
##
## The following objects are masked from ’package:base’:
##
##
##
## Downsampling counts...
## Estimating initial dispersion population...
## Estimating dispersions using log-likelihood...
##
## Running simulations...
## 2019-01-04 20:09:02:
##
## Read counts file:

imported custom data frame

Data processing started...

This procedure requires time... Please wait...

14

classic, 5, 10, movingave, NULL, grid, 11, c(-6, 6), NULL, CoxReid, 10000, NULL, auto,

annotation, p.value, adj.p.value, meta.p.value, adj.meta.p.value, fold.change

1

BH

png

mm9

gene

gene

none

edaseq

edger:

limma:

G1, G2

G1_vs_G2

embedded

loess
full

edger, limma

none applied
none applied

within.which:
between.which:

## Conditions:
## Samples to include: G1_rep1, G1_rep2, G1_rep3, G2_rep1, G2_rep2, G2_rep3
## Samples to exclude: none
## Requested contrasts:
## Annotation:
## Organism:
## Reference source: ensembl
## Count type:
## Analysis preset: all.basic
## Transcriptional level:
## Exon filters:
## Gene filters:
## Filter application: postnorm
## Normalization algorithm:
## Normalization arguments:
##
##
## Statistical algorithm:
## Statistical arguments:
##
NULL, NULL, NULL, NULL, 0.125, NULL, auto, chisq, TRUE, FALSE, c(0.05, 0.1)
##
simes
## Meta-analysis method:
## Multiple testing correction:
## Logarithmic transformation offset:
## Analysis preset: all.basic
## Quality control plots:
## Figure format:
## Output directory: /tmp/RtmpftymRQ
## Output data:
## Output scale(s): natural, log2
## Output values:
## Saving gene model to /tmp/RtmpftymRQ/data/gene_model.RData
## Removing genes with zero counts in all samples...
## Normalizing with: edaseq
## Warning:
## Use ’counts’ instead.
## See help("Deprecated")
##
## Running statistical tests with:
##
## Running statistical tests with:
##
G1_vs_G2
## Performing meta-analysis with simes
## Building output files...
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
## 2019-01-04 20:09:02:
##
##
## Total processing time: 00 seconds

binding annotation...
binding p-values...
binding FDRs...
binding meta p-values...
binding adjusted meta p-values...
binding natural normalized fold changes...
binding log2 normalized fold changes...

G1_vs_G2
Adding non-filtered data...

Data processing finished!

’exprs’ is deprecated.

Writing output...

normalized

Contrast:

Contrast:

Contrast:

G1_vs_G2

edger

limma

15

Please wait...

##
##
## Estimating AUFC weights...
## Processing edger
## Processing limma
##
## Retrieving edger
## Retrieving limma

...and the weights...

weights

##
limma
## 0.5384615 0.4615385

edger

3 metaseqR components

The metaseqR package includes several functions which are responsible for running each part of the pipeline
(data reading and summarization, ﬁltering, normalization, statistical analysis and meta-analysis and report-
ing). Although metaseqR is designed to run as a pipeline, where all the parameters for each individual part
can be passed in the main function, several of the individual functions can be run separately so that the more
experienced user can build custom pipelines. All the HTML help pages contain analytical documentation on
how to run these functions, their inputs and outputs and contain basic examples. For example, runnning

help(stat.edgeR)

will open the help page of the wrapper function over the edgeR statistical testing algorithm which contains

an example of data generation, processing, up to statistical selection.

Most of the diagnostic plots, work with simple matrices as inputs, so they can be easily used outside
the main pipeline, as long as all the necessary arguments are given. It should be noted that a report can be
generated only when running the whole metaseqr pipeline and in the current version there is no support for
generating custom reports.

A very detailed documentation on how to run metaseqr and explanation for all its parameters can be

obtained by

help(metaseqr)

4 Details on metaseqR’s components

4.1 Data input

The metaseqR package currently supports three methods of data input:

1. Aligned reads in SAM/BAM or BED format. In this case, the input ﬁles are passed to the metaseqr
pipeline through a simply structured tab-delimited text ﬁle. This ﬁle contains in its ﬁrst column unique
names that are used to identify each sample, the SAM/BAM/ BED ﬁle names (preferably with their
full path) in the second column, and the biological conditions/groups for each sample/ﬁle in the third
column. The columns may or may not be named, as this information is not used by metaseqR. The
above order (sample names, ﬁle names, biological condition) is used instead. This is the preferred
method of data input as in this way, the analysis is streamlined within R from the beginning until the
end, ensuring data integrity (e.g.
the compatibility of the genome annotations used, something that
can sometimes be broken when using external read counting software). SAM/BAM ﬁles are imported
through the Bioconductor packages Rsamtools and GenomicRanges and BED ﬁles are imported through
the Bioconductor package rtracklayer. The aligned reads are converted to a read counts table through
facilities provided in the Bioconductor package GenomicRanges. The Ensembl/UCSC/RefSeq gene or
exon regions which are used to summarize the read alignments and create the ﬁnal read counts table
for each gene or exon can be obtained either through downloading at the time of usage using the
Bioconductor packages biomaRt/RMySQL, or from a user-speciﬁed ﬁle.

16

2. Summarized numbers of reads for each genomic feature (gene or exon) by providing a ﬁle containing
the read counts table. This ﬁle should contain at least: a) a column with a unique identiﬁer for each
gene/exon (currently, Ensembl, UCSC and RefSeq identiﬁers are supported unless the required anno-
tation elements for each genomic region are embedded in the ﬁle), b) as many columns as the number
of samples in the experiment. Each column with sample read counts should be named with a unique
sample name. Optionally, the read counts ﬁle can contain annotation elements for each genomic fea-
ture (gene or exon) corresponding to the unique identiﬁer column. In this case, the pipeline may be
executed with the annotation=“embedded” argument and it is very useful when the user does not wish
to use supported annotations or the organisms under investigation is not supported by metaseqR. If
the user chooses to use embedded to the read counts ﬁle annotation, then at least the following ele-
ments should be provided for each genomic region, apart from its unique name should be provided (in
parenthesis next to each element, the required column name): chromosome where the genomic feature
is located (chromosome), starting base pair in the chromosome (start), ending base pair in the chro-
mosome (end). For best performance (e.g. availability of all quality control and diagnostic plots), the
following annotation elements should also be provided: GC content (gc_content) for genomic features
of type “gene”, the gene model name (gene_name) for genomic features of type “exon”, the transcribing
strand of each feature, denoted as “+” or “-” (strand), HUGO (or other alias) gene name (gene_name)
and each genomic features biotype/biological categorization, for example Ensembl categorizations like
“protein_coding”, “ncRNA”, “pseudogene”, etc. (biotype). In any case, if the user needs are satisﬁed
with Ensembl annotation, it is better practice not to use embedded annotation in the counts ﬁle but
download it or use the embedded in the package annotation using the respective options.

3. Like case (2) but all the data mentioned in (2) are stored in an R data frame object (for example, derived

after a user-deﬁned or otherwise customized preprocessing).

In any case of the above, some of the main input arguments to the pipeline can become mutually exclusive.
For example the user cannot supply both an input read counts table and a ﬁle with targets including sample
ﬁlenames. Details on such issues can be found in the package documentation.

4.2 Data ﬁltering

Two optional data ﬁlter types are implemented in the metaseqR package, operating at the exon (when exon
counts are requested or provided to/from the pipeline) or the gene level (applied after summarizing exon
counts to gene counts when exon counts are provided, or applied on gene counts if only a gene read counts
table is provided).
It should also be noted that, like the metaseqr pipeline, these ﬁlters are created with
only the detection of differential expression at the gene level and not at the exon level or the detection of
differential splicing.

Exon ﬁlters

Currently only one exon ﬁlter is implemented in metaseqr. This ﬁlter excludes genes that do not have enough
reads presence in a fraction of their exons. This fraction should not be too high so that to avoid excluding
genes that are possibly simply differentially spliced (although metaseqR is not intended to detect differential
splicing), nor too low so as to be able to exclude artifacts. This ﬁltered was inspired by the fact that certain
genes contain “spikes” of read data in their UTR regions or a couple of their exons. These spikes are usually
artifacts that can affect the subsequent differential expression analysis. The exon ﬁlter has three parameters:
exons.per.gene, min.exons and frac and is applied as follows: if a gene has up to exons.per.gene exons, then
read presence is required in at least min.exons of them, else read presence is required in a frac fraction of the
total exons in the gene mode. With the default values, the ﬁlter instructs that if a gene has up to 5 exons, read
presence is required in at least 2, else in at least 20% of its exons, in order to be included in further analysis.
More ﬁlters will be implemented in future versions and users are encouraged to propose exon ﬁlter ideas.

After the determination of the genes that will be ﬁltered from further processing (normalization and/or
statistical analysis), a gene model expression value is constructed based on the sum of all exons of an an-
notated Ensembl gene. It should be noted that while this particular way of summarizing a gene expression
value is not recommended in applications where for example, one studies differential splicing, differential
isoform expression or differential exon usage, it is sufﬁcient for most applications where only expression of
a gene as a total is the goal of the study. Thus, it should be sufﬁcient for a majority of related projects, where
the researchers are interested in summarized gene expression values.

17

Gene ﬁlters

The gene ﬁlters are a set of ﬁlters applied to gene expression as this is manifested through the read presence
on each gene and can be applied before or after normalization. While for some categories this is not important
(e.g. gene length ﬁlter), for others (e.g. expression ﬁlters), the application prior to or post normalization is
important as any expression ﬁlter must be applied to normalized data. In that case, metaseqr performs two
rounds of normalization. The ﬁrst round serves as a temporary normalization in order to get normalized
expression values. The expression ﬁlters are then applied there and genes not passing the ﬁlters are excluded
from the second and ﬁnal round of normalization. The gene ﬁlters can be applied both when the pipeline
input consists of exon read counts and gene read counts. Such ﬁlter can for example be verbalized to
“accept all genes above a certain count threshold” or “accept all genes with expression above the median
of the normalized counts distribution” or “accept all genes with length above a certain threshold in kb”
or “exclude the ’pseudogene’ biotype from further analysis”. Currently, there are four categories of gene
ﬁlters. The ﬁrst category is a qualitative ﬁlter, speciﬁcally a gene length ﬁlter where genes are accepted
for further analysis if they are above a certain (the ﬁlter parameter) kb. The second category consists of a
combined qualitative/quantitative ﬁlter where a gene is accepted for further analysis if it has more average
reads per x bp than the quantile of the average normalized count distribution per x bp in the gene body. This
ﬁlter avg.reads has two parameters: average.per.bp expressing the number of base pairs for which reads are
summarized and quantile for the quantile of the averaged normalized count distribution. The latter quantiles
are calculated for each normalized sample and genes passing the ﬁlter should have an average read count
larger than the maximum of the quantiles vector calculated above. The third category consists of a set of
expression ﬁlters which can be applied altogether or only a subset of them. The expression ﬁlters are the
following:

1. a global median ﬁlter, where genes below the median of the global normalized count distribution
in all samples are not accepted for further analysis (this ﬁlter has been used to distinguish between
“expressed” and “not expressed” genes in several cases, e.g. (Mokry et al., NAR, 2011). The value of
this ﬁlter is a boolean, TRUE for applying this ﬁlter and FALSE for not applying.

2. a global mean ﬁlter, similar as the global median ﬁlter but using the global mean.

3. a global quantile ﬁlter, which is the same as the previous two but using a speciﬁc quantile of the total

counts distribution

4. a ﬁlter based on the expression of genes known to be speciﬁcally expressed (e.g. not expressed) under
the system under investigation. In this case, a set of known not-expressed genes is used to estimate
an expression cutoff. This can be quite useful, as the genes are ﬁltered based on a true biological cutoff
instead of a statistical cutoff. The value of this ﬁlter is a character vector of HUGO gene symbols (which
must be contained in the annotation, see previous section). Thus, if the user intends to use this ﬁlter,
it is better to instruct metaseqr to download annotation on the ﬂy or use the annotations embedded in
the package. Then, these genes are used to build a “null” expression distribution. The 90th quantile
of this distribution is then the expression cutoff. This ﬁlter can be combined with any other ﬁlter. The
user should be careful with gene names as they are case sensitive and must match exactly (“Pten” is
different from “PTEN”).

The fourth ﬁlter category is a qualitative ﬁlter based on the biological categorization of each gene (for
example using Ensembl biotypes). In this case, genes with a certain biotype (which must be contained in the
annotation) are excluded from the analysis.

4.3 Data normalization

The metaseqR package currently supports ﬁve count data normalization algorithms from ﬁve different RNA-
Seq analysis Bioconductor packages. Each package may provide additional options for normalization (e.g.
more than one normalization algorithm present in a package, for example the NOISeq package), which can
be controlled through normalization options (norm.opts parameter) passed to the pipeline call. The initial
normalization parameters are the default parameters provided by the authors of each package. Speciﬁcally,
metaseqR supports normalization with the EDASeq package which is the default option, with the edgeR
package, with the NOISeq package and the NBPSeq package. There is also an option to not normalize
the data (not recommended). Popular normalization methods (e.g. RPKM normalization) are not directly
supported as they are coded within the current package and they can be used by changing the normalization
parameters passed to the pipeline. For example, RPKM normalization can be performed with the NOISeq
package, although not currently recommended due to RPKM limitations discussed in several articles.

18

Data normalization can be performed before or after data ﬁltering. The issue of applying normalization
to the total dataset or to a ﬁltered instance of the dataset is not sufﬁciently treated in the relative literature
and there is not a deﬁnite answer. Our own experience suggests that normalization is smoother and sub-
sequently, the statistical analysis more accurate, when normalization is applied after ﬁltering. In the case
of pre-normalization ﬁltering, a ﬁrst round of normalization is applied as certain thresholds (e.g. gene ex-
pression thresholds) must be deﬁned based on the global distributions of normalized data, otherwise, biases
present in individual samples will cause confusion. For example, if the user ﬁlters data below a speciﬁc
quantile of the normalized count distribution, if that quantile is not determined based on normalized data, it
will not be representative of the global data distribution but it will comprise a biased estimation depended
on the initial count distribution of the un-normalized samples. After the ﬁrst normalization round, ﬁlters
are applied and the ﬁltered un-normalized data are normalized again. In the case of post-normalization ﬁl-
tering, data are ﬁrstly normalized and then ﬁltered. In any case (pre- or post-normalization ﬁltering), genes
with zero counts across all samples are removed prior to normalization (as also suggested by most package
authors).

4.4 Statistical testing

The metaseqR package currently supports six statistical testing algorithms developed for RNA-Seq data.
The algorithms supported are the testing procedures in the Bioconductor packages DESeq, edgeR, NOISeq,
baySeq, limma and NBPSeq. The arguments required for each statistical testing algorithm are passed by the
metaseqr pipeline through the argument stat.opts (please refer to the package documentation for instructions
on how to use the argument). The default options for each algorithm are the same as the corresponding
default arguments used by the authors of each package. The default algorithm used by metaseqR is DESeq.

4.5 Meta analysis

When analyzing data with metaseqR, the user may use more than one statistical testing method (any combi-
nation of the six currently supported). In this case, metaseqR will perform meta-analysis on the p-values that
will be returned from each of the applied statistical tests and will also report, apart from the p-value from
each method, a combined p-value using one of the following methods:

1. The Simes p-value combination method. This method uses the minimum ordered p-value from all
methods divided by the inverse order of the p-values. The ordering is performed across the number of
statistics used. This is the default method.

2. the Fisher p-value combination meta-analysis method, implemented in the R package MADAM. This is

the default method.

3. same as (2) but using permutations, as implemented in the R package MADAM. This option is quite

computationally intensive and requires additional running time.

4. the Whitlock p-value combination method, implemented in the Bioconductor package survcomp. This
method has the advantage of allowing weighting for each methodology.
In the current version of
metaseqR, the weights are equal for all statistical tests. For example, the user may estimate weights for
his/her dataset using metaseqR facilities for this purpose.

5. The maximum p-value returned by a set of statistical tests for the same gene. This is equivalent to the
“intersection” of the results derived from each statistical test, returning genes which have been found
as statistically signiﬁcant by all the statistical tests applied. The maximum p-value ensures that the false
positives are minimized at a (usually high) cost on the true positives (statistical power).

6. The minimum p-value returned by a set of statistical tests for the same gene. This is equivalent to
the “union” of the results derived from each statistical test, returning genes which have been found as
statistically signiﬁcant by at least one of the statistical tests applied. The minimum p-value ensures that
the true positives are maximized at a (usually high) cost on the false positives (type I error).

7. A weighted p-value where the weights can be either ﬁxed (e.g. equal or set by the user according
to performance evidence from the literature), or estimated using metaseqR’s facilities for this purpose
(simulation based on the user data and weighting according to performance measurement on simulated
data). The weights must sum to 1.

8. A method based on permutations. This method has three variants:

19

(a) In the ﬁrst variant (dperm.min), an initial p-value vector is constructed for each gene, containing

the minimum p-value resulted from the applied statistical tests (more lose, see above).

(b) In the second variant (dperm.max), an initial p-value vector is constructed for each gene, containing

the maximum p-value resulted from the applied statistical tests (more strict, see above).

(c) In the third variant (dperm.weight), an initial p-vale vector is constructed for each gene, containing
the convex linear combination of the p-values resulted from all the statistical tests applied for each
gene. To construct the convex linear combination, a vector of weights is used, one for each statistical
test, and the sum of all weights must be 1.

After the construction of the original combined p-value with one of the aforementioned variants a per-
mutation procedure is initialed, where nperm permutations are performed across the samples of the
normalized counts matrix, producing nperm permuted instances of the initial dataset. Then, all the
chosen statistical tests are re-executed for each permutation. The ﬁnal p-value is the number of times
that the p-value of the permuted datasets is smaller than the original dataset. The p-value of the original
dataset is created based on the choice of one. Generally, the permutation procedure usually requires
a lot of time in order to yield accurate results (at least 10000 iterations especially in smaller datasets).
Additionally, this method will NOT work when there are no replicated samples across biological con-
ditions. In that case, the Simes method or one of the others should be used.

It should be noted that in the case of NOISeq, the signiﬁcance value returned is not similar to the “classic”
t-test like statistics, thus its inclusion to a meta-analysis should be handled and interpreted with caution. It
should also be noted that the meta-analysis feature provided by metaseqR is currently experimental and
does not satisfy the strict deﬁnition of “meta-analysis”, which is the combination of multiple similar datasets
under the same statistical methodology. Instead it is the use of multiple statistical tests applied to the same
data so the results at this point are not guaranteed and should be interpreted appropriately. We are working
on a more solid methodology for combining multiple statistical tests based on multiple testing correction and
Monte Carlo methods.

5 References

1. Anders, S., and Huber, W. (2010). Differential expression analysis for sequence count data. Genome

Biol 11, R106.

2. Benjamini, Y., and Hochberg, Y. (1995). Controlling the False Discovery Rate: A Practical and Powerful
Journal of the Royal Statistical Society Series B (Methodological) 57,

Approach to Multiple Testing.
289-300.

3. Benjamini, Y., and Yekutieli, D. (2001). The control of the false discovery rate in multiple testing under

dependency. Annals of Statistics 26, 1165-1188.

4. Chen, H., and Boutros, P.C. (2011). VennDiagram: a package for the generation of highly-customizable

Venn and Euler diagrams in R. BMC Bioinformatics 12, 35.

5. Di, Y, Schafer, D. (2012): NBPSeq: Negative Binomial Models for RNA-Sequencing Data. R package

version 0.1.8, http://CRAN.R-project.org/package=NBPSeq.

6. Fisher, R.A. (1932). Statistical Methods for Research Workers (Edinburgh, Oliver and Boyd).

7. Hardcastle, T.J., and Kelly, K.A. (2010). baySeq: empirical Bayesian methods for identifying differential

expression in sequence count data. BMC Bioinformatics 11, 422.

8. Hochberg, Y. (1988). A sharper Bonferroni procedure for multiple tests of signiﬁcance. Biometrika 75,

800-803.

9. Holm, S. (1979). A simple sequentially rejective multiple test procedure. Scandinavian Journal of

Statistics 6, 65-70.

10. Hommel, G. (1988). A stagewise rejective multiple test procedure based on a modiﬁed Bonferroni test.

Biometrika 75, 383-386.

11. Leng, N., Dawson, J.A., Thomson, J.A., Ruotti, V., Rissman, A.I., Smits, B.M., Haag, J.D., Gould, M.N.,
Stewart, R.M., and Kendziorski, C. (2013). EBSeq: an empirical Bayes hierarchical model for inference
in RNA-seq experiments. Bioinformatics 29, 1035-1043

20

12. Planet, E., Attolini, C.S., Reina, O., Flores, O., and Rossell, D. (2012). htSeqTools: high-throughput

sequencing quality control, processing and visualization in R. Bioinformatics 28, 589-590.

13. Risso, D., Schwartz, K., Sherlock, G., and Dudoit, S. (2011). GC-content normalization for RNA-Seq

data. BMC Bioinformatics 12, 480.

14. Robinson, M.D., McCarthy, D.J., and Smyth, G.K. (2010). edgeR: a Bioconductor package for differential

expression analysis of digital gene expression data. Bioinformatics 26, 139-140.

15. Schroder, M.S., Culhane, A.C., Quackenbush, J., and Haibe-Kains, B. (2011). survcomp: an R/Biocon-
ductor package for performance assessment and comparison of survival models. Bioinformatics 27,
3206-3208.

16. Shaffer, J.P. (1995). Multiple hypothesis testing. Annual Review of Psychology 46, 561-576.

17. Simes, R. J. (1986). An improved Bonferroni procedure for multiple tests of signiﬁcance. Biometrika 73

(3): 751-754.

18. Smyth, G. (2005). Limma: linear models for microarray data.

Biology Solutions using R and Bioconductor, G. R., C. V., D. S., I. R., and H. W., eds.
Springer), pp. 397-420.

In Bioinformatics and Computational
(New York,

19. Storey, J.D., and Tibshirani, R. (2003). Statistical signiﬁcance for genomewide studies. Proc Natl Acad

Sci U S A 100, 9440-9445.

20. Tarazona, S., Garcia-Alcalde, F., Dopazo, J., Ferrer, A., and Conesa, A. (2011). Differential expression in

RNA-seq: a matter of depth. Genome Res 21, 2213-2223.

21. Whitlock, M.C. (2005). Combining probability from independent tests: the weighted Z-method is supe-

rior to Fisher’s approach. J Evol Biol 18, 1368-1373.

6 R session information

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

## R version 3.5.2 (2018-12-20)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 16.04.5 LTS
##
## Matrix products: default
## BLAS: /home/biocbuild/bbs-3.8-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.8-bioc/R/lib/libRlapack.so
##
## locale:
##
##
##
##
##
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
##
##
##
## other attached packages:
##
##
##
##
##
## [11] ShortRead_1.40.0
## [13] SummarizedExperiment_1.12.0 DelayedArray_0.8.0
## [15] matrixStats_0.54.0

VennDiagram_1.6.20
metaseqR_1.22.1
limma_3.38.3
lattice_0.20-38
EDASeq_2.16.1
GenomicAlignments_1.18.1

[1] zoo_1.8-4
[3] futile.logger_1.4.3
[5] qvalue_2.14.0
[7] DESeq_1.34.1
[9] locfit_1.5-9.1

[1] grid
[8] datasets

parallel
base

Rsamtools_1.34.0

stats4
methods

graphics

stats

grDevices utils

21

RColorBrewer_1.1-2
tools_3.5.2
KernSmooth_2.23-15
colorspace_1.3-2
curl_3.2
compiler_3.5.2
caTools_1.17.1.1
genefilter_1.64.0
R.utils_2.7.0
highr_0.7
RSQLite_2.1.1
gtools_3.8.1
RCurl_1.95-4.11

[1] bitops_1.0-6
[4] progress_1.2.0
[7] affyio_1.52.0

GenomeInfoDb_1.18.1
XVector_0.22.0
S4Vectors_0.20.1
Biobase_2.42.0

## [17] GenomicRanges_1.34.0
## [19] Biostrings_2.50.2
## [21] IRanges_2.16.0
## [23] BiocParallel_1.16.5
## [25] BiocGenerics_0.28.0
##
## loaded via a namespace (and not attached):
##
##
##
## [10] DBI_1.0.0
## [13] tidyselect_0.2.5
## [16] preprocessCore_1.44.0
## [19] formatR_1.5
## [22] scales_1.0.0
## [25] stringr_1.3.1
## [28] NBPSeq_0.3.0
## [31] baySeq_2.16.0
## [34] bindr_0.1.1
## [37] dplyr_0.7.8
## [40] magrittr_1.5
## [43] Rcpp_1.0.0
## [46] vsn_3.50.0
## [49] edgeR_3.24.3
## [52] plyr_1.8.4
## [55] crayon_1.3.4
## [58] annotate_1.60.0
## [61] pillar_1.3.1
## [64] geneplotter_1.60.0
## [67] futile.options_1.0.1
## [70] evaluate_0.12
## [73] BiocManager_1.30.4
## [76] assertthat_0.2.0
## [79] aroma.light_3.12.0
## [82] tibble_2.0.0
## [85] memoise_1.1.0
## [88] brew_1.0-6

bit64_0.9-7
httr_1.4.0
R6_2.3.0
lazyeval_0.2.1
prettyunits_1.0.2
bit_1.1-14
rtracklayer_1.42.1
affy_1.60.0
digest_0.6.18
pkgconfig_2.0.2
rlang_0.3.0.1
hwriter_1.3.2
R.oo_1.22.0
GenomeInfoDbData_1.2.0 Matrix_1.2-15
munsell_0.5.0
R.methodsS3_1.7.1
zlibbioc_1.28.0
blob_1.1.1
splines_3.5.2
hms_0.4.2
log4r_0.2
reshape2_1.4.3
XML_3.98-1.16
latticeExtra_0.6-28
gtable_0.2.0
ggplot2_3.1.0
xtable_1.8-3
NOISeq_2.26.1
bindrcpp_0.2.2

abind_1.4-5
stringi_1.2.4
gplots_3.0.1
gdata_2.18.0
GenomicFeatures_1.34.1
knitr_1.21
rjson_0.2.20
biomaRt_2.38.0
glue_1.3.0
lambda.r_1.2.3
purrr_0.2.5
xfun_0.4
survival_2.43-3
AnnotationDbi_1.44.0
corrplot_0.84

22

