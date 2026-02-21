HowTo: get pretty HTML output for my gene list

James W. MacDonald

October 29, 2025

1 Overview

The intent of this vignette is to show how to make reasonably nice looking
HTML tables for presenting the results of a microarray analysis. These
tables are a very nice format because you can insert clickable links to various
public annotation databases, which facilitates the downstream analysis. In
addition, the format is quite compact, can be posted on the web, and can
be viewed using any number of free web browsers. One caveat; an HTML
table is probably not the best format for presenting the results for all of the
genes on a chip. For even a small (5000 gene) chip, the file could be 10 Mb
or more, which would take an inordinate amount of time to open and view.
Also note that the Bioconductor project supplies annotation packages for
many of the more popular Affymetrix chips, as well as for many commercial
spotted cDNA chips. For chips that have annotation packages, the annaffy
package is the preferred method for making HTML tables.

To make an annotated HTML table, the only requirement is that we
have some sort of annotation data for the microarray that we are using.
Most manufacturers supply data in various formats that can be read into R.
For instance, Affymetrix supplies CSV files that can be read into R using the
read.csv() function http://www.affymetrix.com/support/technical/byproduct.
affx?cat=arrays.

2 Alternate methods

Please note that one can also make these HTML tables by parsing data from
e.g., an online (or local) Biomart database, using functions in the biomaRt
package. This may be easier, and may result in more current annotation
data. Please see the prettyOutput vignette in the biomaRt package for more
information.

1

3 Data Analysis

I will assume that the reader is familiar with the analysis of microarray
data, and has a set of genes that she would like to use. In addition, I will
assume that the reader is familiar enough with R that she can subset the data
based on a list of genes, and reorder based on a particular statistic. For any
questions about subsetting or ordering data, please see “An Introduction to
R”. For questions regarding microarray analysis, please consult the vignettes
for, say limma, multtest, or marray.

4 Getting Started

We first load the annotate package, as well as some data. These data will
be from the Affymetrix HG-U95Av2 chip (for which we would normally use
annaffy). To keep the HTML table small, we will take a subset of fifteen
genes as an example.

> library("annotate")
> data(sample.ExpressionSet)
> igenes <- featureNames(sample.ExpressionSet)[246:260]

5 Annotation Data

For this vignette I have supplied the annotation data. In a normal situation,
these data would be subset from the manufacturer’s annotation data, using
the manufacturer’s gene identifiers (which is how I got these IDs).

First, we will look at the GenBank and LocusLink IDs. We will be able
to use these IDs without further modification. Note that the LocusLink IDs
contain some missing data (“—”). This will not pose a problem because Lo-
cusLink IDs are all numeric, so we have incorporated code in htmlpage()
to automatically convert any non-numeric ID to an HTML empty cell char-
acter (“&nbsp;”). GenBank IDs (which often correspond to either RefSeq or
GenBank IDs) are not as consistent, so any missing data would have to be
manually converted to the HTML empty cell character. Missing data for
LocusLink, UniGene and OMIM IDs are automatically converted, whereas
Affymetrix, SwissProt and GenBank IDs have to be done manually. I will
give examples of how to do this below.

> gb

2

[1] "M57423"
[7] "X98175"
[13] "U19142"

"Z70218"
"L17328"
"AB019392" "J03071"
"X16863"
"U19147"

"S81916"
"D25272"

"U63332"
"D63789"

"M77235"
"D63789"

> ll

[1] "221823" "4330"
[8] "27335"

"---"

"9637"
"---"

"---"
"6375"

"---"
"---"

"6331"
"2543"

"841"
"2578"

[15] "2215"

The UniGene and SwissProt IDs present different challenges, so we will
modify them separately. For the UniGene IDs we need to strip off the extra
information appended to each ID. If we didn’t do this, our hyperlink would
not work correctly.

> ug

[1] "Hs.169284 // ---"
[3] "Hs.103419 // full length" "Hs.380429 // ---"
"Hs.169331 // full length"
[5] "--- // ---"
[7] "Hs.381231 // full length" "Hs.283781 // full length"
[9] "--- // ---"

"Hs.268515 // full length"

[11] "Hs.3195 // full length"
[13] "Hs.176660 // full length" "Hs.272484 // full length"
[15] "Hs.372679 // full length"

"--- // ---"
"--- // ---"

> ug <- sub(" //.*$", "", ug)
> ug

[1] "Hs.169284" "Hs.268515" "Hs.103419" "Hs.380429" "---"
"---"
[6] "Hs.169331" "Hs.381231" "Hs.283781" "---"

[11] "Hs.3195"

"---"

"Hs.176660" "Hs.272484" "Hs.372679"

The SwissProt IDs present a different challenge. Here there isn’t any
extra information. Instead, we have multiple IDs for some of the genes, and
missing IDs for some of the others. Because the code for SwissProt IDs will
not automatically handle missing data, we have to convert the missing data
to an HTML empty cell identifier (“&nbsp;”). For htmlpage() to correctly
handle multiple IDs, we have to convert the character vector into a list of
character vectors.

> sp

3

[1] "P21108"
[2] "Q10571"
[3] "Q9UHY8"
[4] "Q16444"
[5] "---"
[6] "Q14524 /// Q8IZC9 /// Q8WTQ6 /// Q8WWN5 /// Q96J69"
[7] "Q14790"
[8] "Q9UBQ5"
[9] "---"
[10] "---"
[11] "P47992"
[12] "---"
[13] "Q13065 /// Q8IYC5"
[14] "Q13070"
[15] "O75015"

> sp <- strsplit(sub("---","&nbsp;",as.character(sp)), "///")
> sp

[[1]]
[1] "P21108"

[[2]]
[1] "Q10571"

[[3]]
[1] "Q9UHY8"

[[4]]
[1] "Q16444"

[[5]]
[1] "&nbsp;"

[[6]]
[1] "Q14524 "

[[7]]
[1] "Q14790"

" Q8IZC9 " " Q8WTQ6 " " Q8WWN5 " " Q96J69"

4

[[8]]
[1] "Q9UBQ5"

[[9]]
[1] "&nbsp;"

[[10]]
[1] "&nbsp;"

[[11]]
[1] "P47992"

[[12]]
[1] "&nbsp;"

[[13]]
[1] "Q13065 " " Q8IYC5"

[[14]]
[1] "Q13070"

[[15]]
[1] "O75015"

We have converted the data to a list of character vectors, and also con-
verted the “—” missing data identifier to the HTML character for an empty
cell.

6 Build the Table

Usually we would like to include the expression values for our genes along
with some statistics, say a t-statistic, fold change, and p-value. As an exam-
ple, we will make a comparison using the first ten samples.

> dat <- exprs(sample.ExpressionSet)[igenes,1:10]
> FC <- rowMeans(dat[igenes,1:5]) - rowMeans(dat[igenes,6:10])
> pval <- esApply(sample.ExpressionSet[igenes,1:10], 1, function(x) t.test(x[1:5], x[6:10])$p.value)
> tstat <- esApply(sample.ExpressionSet[igenes,1:10], 1, function(x) t.test(x[1:5], x[6:10])$statistic)

It is also usually a good idea to include gene names in the table. Normally
the names would be subsetted from the annotation data, but here we have

5

to supply them. Again, we have to manually convert any missing names to
the HTML empty cell character.

> name

[1] "hypothetical protein LOC221823"
[2] "meningioma (disrupted in balanced translocation) 1"
[3] "fasciculation and elongation protein zeta 2 (zygin II)"
[4] "Phosphoglycerate kinase {alternatively spliced}"
[5] "---"
[6] "sodium channel, voltage-gated, type V, alpha polypeptide"
[7] "caspase 8, apoptosis-related cysteine protease"
[8] "muscle specific gene"
[9] "---"
[10] "---"
[11] "chemokine (C motif) ligand 1"
[12] "---"
[13] "G antigen 1"
[14] "G antigen 6"
[15] "Fc fragment of IgG, low affinity IIIb, receptor for (CD16)"

> name <- gsub("---", "&nbsp;", name)
> name

[1] "hypothetical protein LOC221823"
[2] "meningioma (disrupted in balanced translocation) 1"
[3] "fasciculation and elongation protein zeta 2 (zygin II)"
[4] "Phosphoglycerate kinase {alternatively spliced}"
[5] "&nbsp;"
[6] "sodium channel, voltage-gated, type V, alpha polypeptide"
[7] "caspase 8, apoptosis-related cysteine protease"
[8] "muscle specific gene"
[9] "&nbsp;"
[10] "&nbsp;"
[11] "chemokine (C motif) ligand 1"
[12] "&nbsp;"
[13] "G antigen 1"
[14] "G antigen 6"
[15] "Fc fragment of IgG, low affinity IIIb, receptor for (CD16)"

We can now build our HTML table. To make the process more trans-
parent, this will be done in steps. In practice however, this can be done in

6

one line. Note here that the genelist consists of annotation data that will be
hyperlinked to online databases, whereas othernames consists of other data
that will not be hyperlinked.

> genelist <- list(igenes, ug, ll, gb, sp)
> filename <- "Interesting_genes.html"
> title <- "An Artificial Set of Interesting Genes"
> othernames <- list(name, round(tstat, 2), round(pval, 3), round(FC, 1), round(dat, 2))
> head <- c("Probe ID", "UniGene", "LocusLink", "GenBank", "SwissProt", "Gene Name", "t-statistic", "p-value",
"Fold Change", "Sample 1", "Sample 2", "Sample 3", "Sample 4", "Sample 5", "Sample 6",
+
+
"Sample 7", "Sample 8", "Sample 9", "Sample 10")
> repository <- list("affy", "ug", "en", "gb", "sp")
> htmlpage(genelist, filename, title, othernames, head, repository = repository)

7 Session Information

The version number of R and packages loaded for generating the vignette
were:

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
[1] grid

stats4

stats

graphics

grDevices utils

7

[7] datasets

methods

base

other attached packages:

[1] Rgraphviz_2.54.0
[4] GO.db_3.22.0
[7] annotate_1.88.0

graph_1.88.0
hgu95av2.db_3.13.0
XML_3.99-0.19
S4Vectors_0.48.0

[10] IRanges_2.44.0
[13] BiocGenerics_0.56.0 generics_0.1.4

loaded via a namespace (and not attached):

[1] bit_4.6.0
[4] BiocManager_1.30.26 crayon_1.5.3
[7] Biostrings_2.78.0

jsonlite_2.0.0

[10] png_0.1-8
[13] R6_2.6.1
[16] bookdown_0.45
[19] rlang_1.1.6
[22] xfun_0.53
[25] RSQLite_2.4.3
[28] digest_0.6.37
[31] evaluate_1.0.5
[34] pkgconfig_2.0.3

jquerylib_0.1.4
yaml_2.3.10
XVector_0.50.0
DBI_1.2.3
KEGGREST_1.50.0
sass_0.4.10
memoise_2.0.1
lifecycle_1.0.4
rmarkdown_2.30
tools_4.5.1

xtable_1.8-4
org.Hs.eg.db_3.22.0
AnnotationDbi_1.72.0
Biobase_2.70.0
BiocStyle_2.38.0

compiler_4.5.1
blob_1.2.4
Seqinfo_1.0.0
fastmap_1.2.0
knitr_1.50
bslib_0.9.0
cachem_1.1.0
bit64_4.6.0-1
cli_3.6.5
vctrs_0.6.5
httr_1.4.7
htmltools_0.5.8.1

8

