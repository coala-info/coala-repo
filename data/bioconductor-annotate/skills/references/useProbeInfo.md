Using Probe Information

Robert Gentleman

Overview

The Bioconductor project maintains a rich body of annotation data assembled into R
libraries. For many different Affymetrix chips information is provided on both the
sequence of the mRNA that was intended to be matched and the actual 25mers that
were used for the bindings. In this vignette we show how to make use of the probe
information.

A Simple Example

To demonstrate the use of probe level data we will use the rae230a chip (for rats).
So we first need to load these libraries.

> library("annotate")
> library("rae230a.db")
> library("rae230aprobe")

Now, we do not have any data so all we are going to do is to examine the probe data
and show how to use some of the different Bioconductor tools to access that informa-
tion, and potentially check on the mapping information that has been given.

We will select a probe set,

> ps = names(as.list(rae230aACCNUM))
> myp = ps[1001]
> myA = get(myp, rae230aACCNUM)
> wp = rae230aprobe$Probe.Set.Name == myp
> myPr = rae230aprobe[wp,]
>

The probe data is stored as a data.frame with 6 columns. They are

sequence The sequence of the 25mer

x The x position of the probe on the array.

y The y position of the probe on the array.

Probe.Set.Name The Affymetrix ID for the probe set.

1

Probe.Interrogation.Position The location (in bases) of the 13th base in the 25mer,

in the target sequence.

Target.Strandedness Whether the 25mer is a Sense or an Antisense match to the tar-

get sequence.

We note that it is not always the case that the sequence reported is found in the
reference or if it is, it is not always at the location reported. One can check that using
other tools available in the annotate package and in the Biostrings package.

> myseq = getSEQ(myA)
> nchar(myseq)

[1] 5775

> library("Biostrings")
> mybs = DNAString(myseq)
> match1 = matchPattern(as.character(myPr[1,1]), mybs)
> match1

Views on a 5775-letter DNAString subject
subject: GCCCGGGTCCCGCCTCTTCCTCAGCTTGG...TTAATAAAGGATTTACGGGATTTCCTTTC
views:

start end width

[1] 5212 5236

25 [TGGGATTATGGCCTGTGTCACCACG]

> as.matrix(ranges(match1))

[,1] [,2]
25

[1,] 5212

> myPr[1,5]

[1] 5224

And we can see that in this case the 13th nucleotide is indeed in exactly the place that
has been predicted.

One additional thing to note is that Affymetrix does not accurately report the strand-
edness of the probes, so it is necessary to check the reverse complement of the sequence
prior to assuming that the probe does not interrogate the correct gene.

> myp = ps[100]
> myA = get(myp, rae230aACCNUM)
> wp = rae230aprobe$Probe.Set.Name == myp
> myPr = rae230aprobe[wp,]
> myseq = getSEQ(myA)
> mybs = DNAString(myseq)
> Prstr = as.character(myPr[1,1])
> match2 = matchPattern(Prstr, mybs)
> ## expecting 0 (no match)
> length(match2)

2

[1] 0

> match2 = matchPattern(reverseComplement(DNAString(Prstr)), mybs)
> nchar(match2)

[1] 25

> nchar(myseq) - as.matrix(ranges(match2))

[,1] [,2]
[1,] 273 652

> myPr[1,5]

[1] 262

Again, we see that the 13th nucleotide is exactly where predicted. It is relatively
straightforward to check the other 25mers, and to develop different visualization tools
that can be used to investigate the available data.

Other Sources of Information

There are other tools available that may also be of some interest. For instance, the
Mental Health Research Institute at the University of Michigan have various custom cdf
files for Affymetrix data analysis that have been updated using more current annotation
information from GenBank and Ensembl.

http://brainarray.mhri.med.umich.edu/Brainarray/Database/

CustomCDF/genomic_curated_CDF.asp

The Weizmann Institute of Science have a database that can be queried to get the
sensitivity and specificity for the probes on the Affymetrix HG-U95av2 chip. Although
the information here is limited to a particular chip, this general idea is something that
an enterprising end-user might want to replicate for other chips.

http://genecards.weizmann.ac.il/geneannot/

1 Session Information

The version number of R and packages loaded for generating the vignette were:

R version 4.5.1 Patched (2025-08-23 r88802)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.3 LTS

Matrix products: default
BLAS:
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LAPACK version 3.12.0

3

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
[7] datasets methods

stats4

stats
base

graphics

grDevices utils

other attached packages:
[1] Biostrings_2.78.0
[4] rae230aprobe_2.18.0
[7] Rgraphviz_2.54.0

[10] GO.db_3.22.0
[13] annotate_1.88.0
[16] IRanges_2.44.0
[19] BiocGenerics_0.56.0

Seqinfo_1.0.0
rae230a.db_3.13.0
graph_1.88.0
hgu95av2.db_3.13.0
XML_3.99-0.19
S4Vectors_0.48.0
generics_0.1.4

XVector_0.50.0
org.Rn.eg.db_3.22.0
xtable_1.8-4
org.Hs.eg.db_3.22.0
AnnotationDbi_1.72.0
Biobase_2.70.0
BiocStyle_2.38.0

loaded via a namespace (and not attached):

[1] sass_0.4.10
[4] evaluate_1.0.5
[7] blob_1.2.4

RSQLite_2.4.3
bookdown_0.45
jsonlite_2.0.0

[10] BiocManager_1.30.26 httr_1.4.7
[13] cli_3.6.5
[16] bit64_4.6.0-1
[19] tools_4.5.1
[22] R6_2.6.1
[25] KEGGREST_1.50.0
[28] bslib_0.9.0
[31] htmltools_0.5.8.1

rlang_1.1.6
cachem_1.1.0
memoise_2.0.1
png_0.1-8
bit_4.6.0
xfun_0.53
rmarkdown_2.30

digest_0.6.37
fastmap_1.2.0
DBI_1.2.3
jquerylib_0.1.4
crayon_1.5.3
yaml_2.3.10
vctrs_0.6.5
lifecycle_1.0.4
pkgconfig_2.0.3
knitr_1.50
compiler_4.5.1

4

