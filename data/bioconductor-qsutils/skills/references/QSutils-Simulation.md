# Simulating Quasispecies Composition

Guerrero-Murillo, M and Gregori, J

#### 10/30/2025

# 1 Introduction

A viral quasispecies is understood as a collection of closely related viral
genomes produced by viruses with low replication fidelity. RNA viruses show a
high replication error rate due to a lack of proofreading mechanisms. It is
estimated that for viruses with typically high replicative loads, every
possible point mutation and many double mutations are generated with each
viral replication cycle, and these may be present within the population at
any time. Given this inherent dynamic, we may be interested in comparing the
viral diversity indices between sequential samples from a single patient or
between samples from groups of patients. These comparisons can provide
information on the patient’s clinical progression or the appropriateness
of a given treatment.

QSUtils is a package intended for use with quasispecies amplicon data obtained
by NGS, but it could also be useful for analyzing 16S/18S ribosomal-based
metagenomics or tumor genetic diversity by amplicons.

In this tutorial, we illustrate how the functions provided in the package can
be used to simulate quasispecies data. This implies simulation of closely
related genomes, (eventually with segregating subpopulations at higher
genetic distances) and their abundances.

In particular, we can differentiate between acute and chronic infection
profiles by the quasispecies composition. An acute infection is expected
to show a prominent genome that is highly abundant, together with a set
of low-abundance genomes. On the other hand, besides the implicit dynamics,
a chronic infection is expected to show a number of relatively abundant genomes
together with a myriad of derived genomes at low and very low abundances.

In viral terms, the fitness of a genome is a measure of its replicative
performance. High-fitness haplotypes show high abundances after a transient
state, during which they overcome other genomes in the quasispecies. During
infection of a human host, the quasispecies typically shows variations in the
fitness of each genome caused by changes in the bioenvironment. Because of this
dynamic, we may observe the profile of a typical acute infection also in
chronic patients, at least at the level of magnification provided by current
NGS technology.

A few functions in the package were designed to simulate quasispecies
composition, with the aim of studying the statistical properties of the
diversity indices (Gregori et al. [2016](#ref-Gregori2016)) (Gregori et al. [2014](#ref-Gregori2014)).

# 2 Install package

```
BiocManager::install("QSutils")
```

```
## Warning: package(s) not installed when version(s) same as or greater than current; use
##   `force = TRUE` to re-install: 'QSutils'
```

```
library(QSutils)
```

# 3 Abundance

Two different types of information define the quasispecies composition: the
genomes present and their current frequency (abundance) in the viral
population. The package provides three ways to simulate abundance
with various decreasing profiles.

## 3.1 Powers of a fraction

\(fn.ab\) setting the argument \(fn\) to \(pf\) computes consecutive fractions,
given the frequency of the most abundant haplotype, according to:

\[h ~r^{(i-1)}, ~~ r<1, ~~ i=1..n\]
Using \(table\) on the \(fn.ab\) result, we obtain the number of haplotypes for
each frequency:

```
table(fn.ab(25,fn="pf"))
```

```
##
##     1     2     4     9    19    39    78   156   312   625  1250  2500  5000
##    12     1     1     1     1     1     1     1     1     1     1     1     1
## 10000
##     1
```

```
par(mfrow=c(1,2))
plot(fn.ab(25,fn="pf"),type="h")
plot(fn.ab(25,r=0.7,fn="pf"),type="h")
```

![Profile of abundances simulated with `fn.ab` with fn=pf](data:image/png;base64...)

Figure 1: Profile of abundances simulated with `fn.ab` with fn=pf

The default value for \(r\) is 0.5. Higher \(r\) values moderate the decrease of
abundances. By default, the frequency of the most abundant haplotype, \(h\), is
10000.

## 3.2 Power of consecutive fractions

\(fn.ab\) with the argument \(fn="pcf"\) computes the power of consecutive
fractions, according to:

\[h ~ \frac{1}{i^{r}}, ~~ r>0, ~~ i=1..n\]
Default values are 0.5 for \(r\) and 10,000 for \(h\). The higher the \(r\), the more
pronounced the decrease in frequencies.

```
table(fn.ab(25,r=3,fn="pcf"))
```

```
##
##     1     2     3     4     5     7    10    13    19    29    46    80   156
##     8     3     1     1     1     1     1     1     1     1     1     1     1
##   370  1250 10000
##     1     1     1
```

```
table(fn.ab(25,r=2,fn="pcf"))
```

```
##
##    16    17    18    20    22    25    27    30    34    39    44    51    59
##     1     1     1     1     1     1     1     1     1     1     1     1     1
##    69    82   100   123   156   204   277   400   625  1111  2500 10000
##     1     1     1     1     1     1     1     1     1     1     1     1
```

```
par(mfrow=c(1,2))
plot(fn.ab(25,r=3,fn="pcf"),type="h")
plot(fn.ab(25,r=2,fn="pcf"),type="h")
```

![Abundances simulated with `fn.ab` with fn=pcf](data:image/png;base64...)

Figure 2: Abundances simulated with `fn.ab` with fn=pcf

## 3.3 Decreasing fractional powers

\(fn.ab\) with \(fn="dfp"\) computes decreasing roots of the maximum frequency, \(h\),
according to:

\[h^{1/i}, ~~ i=1..n\]

```
table(fn.ab(25,fn="dfp"))
```

```
##
##     1     2     3     4     6    10    21   100 10000
##    12     5     2     1     1     1     1     1     1
```

```
par(mfrow=c(1,2))
plot(fn.ab(25,fn="dfp"),type="h")
```

![Abundances simulated with `fn.ab` with fn=dpf](data:image/png;base64...)

Figure 3: Abundances simulated with `fn.ab` with fn=dpf

The figure and the previous table both show that this function is the one that
generates the greatest distance between the dominant haplotype and the others.

To compare the profiles of the three functions, this figure plots the outputs
of the functions with default parameters.

`{rplot-fn3.2,fig.cap="Comparison of the data simulation functions"} par(mfrow=c(1,3)) plot(fn.ab(25,fn="pf"),type="h",main="fn.ab - pf") plot(fn.ab(25,r=3,fn="pcf"),type="h",main="fn.ab - pcf") plot(fn.ab(25,fn="dfp"),type="h",main="fn.ab - dpf")`

A linear combination of results of the three functions provides greater
flexibility.

```
ab <- 0.25*fn.ab(25,fn="pf")+0.75*fn.ab(25,r=3,fn="pcf")
table(ab)
```

```
## ab
##      1   1.75    2.5    3.5   4.75    7.5  12.25   19.5  33.75  60.75  112.5
##      8      3      1      1      1      1      1      1      1      1      1
## 216.25  429.5  902.5 2187.5  10000
##      1      1      1      1      1
```

```
plot(ab,type="h",main="Linear combination of results")
```

![Abundances simulated with a linear combination of the functions](data:image/png;base64...)

Figure 4: Abundances simulated with a linear combination of the functions

```
ab <- 0.7*fn.ab(25,fn="pf")+0.3*fn.ab(25,fn="dfp")
table(ab)
```

```
## ab
##      1      2    3.4    6.9   13.9   27.9   55.5  110.1  219.6  439.3    878
##     12      1      1      1      1      1      1      1      1      1      1
## 1756.3   3530  10000
##      1      1      1
```

```
plot(ab,type="h",main="Linear combination of results")
```

![Abundances simulated with a linear combination of the functions](data:image/png;base64...)

Figure 5: Abundances simulated with a linear combination of the functions

## 3.4 Geometric sequence

Appropriate for the typical load of rare haplotypes observed in our experiments
with the HCV quasispecies before the abundance filter. That is, the large
number of very low fitness or defective haplotypes are best simulated by a
geometric sequence with low values for the parameter. The geometric sequence
is expressed as:

\[p ~(1-p)^{k-1}, ~~ k=1..n, ~~ 0 < p < 1\]

and is implemented in the function \(geom.series\), taking two arguments: \(n\),
the number of frequencies to compute and \(p\), the parameter of the geometric
function.

This function is useful to simulate a broad spectrum of frequency profiles,
from quasispecies with very prevalent haplotypes to the above-mentioned long
queues of very low abundances, as illustrated in the next figure.

```
par(mfrow=c(1,2))
ab1 <- 1e5 * geom.series(100,0.8)
plot(ab1,type="h",main="Geometric series with p=0.8",cex.main=1)
ab2 <- 1e5 * geom.series(100,0.001)
plot(ab2,type="h",main="Geometric series with p=0.001",ylim=c(0,max(ab2)),
    cex.main=1)
```

![](data:image/png;base64...)

Linear combinations of geometric sequences with parameters of differing
magnitudes help to obtain typical quasispecies profiles:

```
ab1 <- 1e5 * (geom.series(100,0.8)+geom.series(100,0.05))
plot(ab1,type="h",main="Combination of geometric series")
```

![](data:image/png;base64...)

The function \(fn.ab\) with fn argument set to \(pf\), \(pcf\), and \(dfp\) is flexible
enough to obtain typical quasispecies profiles after filtering out all
haplotypes below an abundance threshold, considered the technical noise level.
This function, combined with geometric series having low to very low parameter
values, provide profiles close to those observed empirically.

# 4 Random genomes and variant haplotypes

In addition to frequencies, we need to simulate the quasispecies genomes. The
first task for this purpose is to generate the dominant haplotype by
\(GetRandomSeq\). The only parameter for this function is the genome length.
The output is a fully random sequence of nucleotides, returned as a character
string.

```
set.seed(23)
m1 <- GetRandomSeq(50)
m1
```

```
## [1] "ATTGTAGGACTAGAATTGCCGCACTCACGCGGCGCTAAGTGGTAGCTAGC"
```

Variant genomes of this haplotype can be generated by \(GenerateVars\). This
function takes four parameters, \(seq\) the dominant haplotype, \(nhpl\) the number
of variants to generate, \(max.muts\) the maximum number of mutations in a
genome, and \(p.muts\) the probability for each number of mutations from 1 to
\(max.muts\). It returns a vector of character strings with the variant genomes.

```
v1 <- GenerateVars(m1,20,2,c(10,1))
DottedAlignment(c(m1,v1))
```

```
##  [1] "ATTGTAGGACTAGAATTGCCGCACTCACGCGGCGCTAAGTGGTAGCTAGC"
##  [2] "........T........................................."
##  [3] ".............G...................................."
##  [4] ".................................................T"
##  [5] ".................T................................"
##  [6] "...T.............................................."
##  [7] ".............................................A...."
##  [8] "...........G......................................"
##  [9] "...........................A....G................."
## [10] "....G............................................."
## [11] ".........A........................................"
## [12] "....................................T............."
## [13] "................A................................."
## [14] ".........G........................................"
## [15] "........................G........................."
## [16] "...........G......................................"
## [17] ".................................A................"
## [18] "......................................A..........."
## [19] ".........................G...T...................."
## [20] "................C................................."
## [21] ".........A.....................................C.."
```

## 4.1 Generate a quasispecies of acute infection

With these functions we can simulate a quasispecies with a profile of acute
infection; that is, characterized by a dominant haplotype which is fairly
abundant, together with a number of haplotypes at low abundances.

```
set.seed(23)
n.genomes <- 25
m1 <- GetRandomSeq(50)
v1 <- GenerateVars(m1,n.genomes-1,2,c(10,1))
w1 <- fn.ab(n.genomes,r=3,fn="pcf")
data.frame(Hpl=DottedAlignment(c(m1,v1)),Freq=w1)
```

```
##                                                   Hpl  Freq
## 1  ATTGTAGGACTAGAATTGCCGCACTCACGCGGCGCTAAGTGGTAGCTAGC 10000
## 2  .................................................T  1250
## 3  .................T................................   370
## 4  ...T..............................................   156
## 5  .............................................A....    80
## 6  ...........G......................................    46
## 7  ................................T.................    29
## 8  ...........................G......................    19
## 9  ....A....G........................................    13
## 10 ..........................T.......................    10
## 11 ....................................T.............     7
## 12 ................A.................................     5
## 13 .........G........................................     4
## 14 ........................G.........................     3
## 15 ...........G......................................     2
## 16 .................................A................     2
## 17 ......................................A...........     2
## 18 .............................G....................     1
## 19 ..................T..................G............     1
## 20 .........A........................................     1
## 21 ......C................................A..........     1
## 22 T.................................................     1
## 23 ............C.....................................     1
## 24 ..............................A...................     1
## 25 ........................................A.........     1
```

The quasispecies composition can be visualized using a bar plot depicting the
haplotype frequencies, with haplotypes sorted by increasing number of mutations
with respect to the dominant haplotype, and within the number of mutations,
by decreasing order of abundance:

```
qs <- DNAStringSet(c(m1,v1))
lst <- SortByMutations(qs,w1)
qs <- lst$bseqs

cnm <- cumsum(table(lst$nm))+1
nm.pos <- as.vector(cnm)[-length(cnm)]
names(nm.pos) <- names(cnm[-1])

bp <- barplot(lst$nr,col="lavender")
axis(1,at=bp[nm.pos],labels=names(nm.pos),cex.axis=0.7)
```

![Simulated abundances in an acute infection](data:image/png;base64...)

(#fig:plot accute)Simulated abundances in an acute infection

## 4.2 Generate a quasispecies of chronic infection

In contrast to acute infection, chronic infection develops more slowly; hence,
a larger number of mutations are generated with regard to the dominant
haplotype. Furthermore, the mutated haplotypes may be more abundant in chronic
than in acute infections. In this case, we would use \(GenerateVars\) with a
higher value of \(max.muts\) and higher probabilities for mutants at any level.

```
set.seed(23)
n.genomes <- 40
m1 <- GetRandomSeq(50)
v1 <- GenerateVars(m1,n.genomes-1,6,c(10,3,1,0.5,2,0.5))
w1 <- fn.ab(n.genomes,r=1.5,fn="pcf")
data.frame(Hpl=DottedAlignment(c(m1,v1)),Freq=w1)
```

```
##                                                   Hpl  Freq
## 1  ATTGTAGGACTAGAATTGCCGCACTCACGCGGCGCTAAGTGGTAGCTAGC 10000
## 2  ...........................A......................  3535
## 3  ..A........C...............G....G.........C.......  1924
## 4  ..........................T.......................  1250
## 5  ......A..T......G...................C...T.........   894
## 6  .....G...........................T..............A.   680
## 7  .............................G....................   539
## 8  .....................................G............   441
## 9  ......C..T......A........T.............AT.........   370
## 10 ........................G.........................   316
## 11 .............C.........T...G......................   274
## 12 .........................................T........   240
## 13 ...................A..............................   213
## 14 ..................................A...............   190
## 15 ...........................G......................   172
## 16 ...............C..................................   156
## 17 ..........................................C.......   142
## 18 ....C.............................................   130
## 19 ........T..G.....T.....AC.................C.......   120
## 20 ...................................C..............   111
## 21 .G.........C...A...............T..................   103
## 22 ..........................T.......................    96
## 23 ....A......G.....A....................A.........A.    90
## 24 .................T...............C...........A....    85
## 25 ..............................................C...    80
## 26 ..............................T...................    75
## 27 ..A...............................................    71
## 28 C.................A.T.G........C..................    67
## 29 .........A........................................    64
## 30 ......A.........G.................................    60
## 31 .............................A....A..............G    57
## 32 ............A......T.............T.....G........A.    55
## 33 ............................................T.....    52
## 34 ............C...C.T...............................    50
## 35 ...............A.C....T.............C.......A.....    48
## 36 .........T.C...........A.....T..........T.........    46
## 37 .....................................C............    44
## 38 ........C.........................................    42
## 39 ........CG..................A.....................    41
## 40 .....................................T............    39
```

Again, we can visualize the quasispecies composition using a bar plot.

```
qs <- DNAStringSet(c(m1,v1))
lst <- SortByMutations(qs,w1)
qs <- lst$bseqs
cnm <- cumsum(table(lst$nm))+1
nm.pos <- as.vector(cnm)[-length(cnm)]
names(nm.pos) <- names(cnm[-1])
bp <- barplot(lst$nr,col="lavender")
axis(1,at=bp[nm.pos],labels=names(nm.pos),cex.axis=0.7)
```

![Simulated abundances in a chronic infection](data:image/png;base64...)

Figure 6: Simulated abundances in a chronic infection

## 4.3 Diverging populations

Along the quasispecies dynamics we may see emergence of a segregating
subpopulation with improved fitness due to the combination of mutations,
rather than a single one. In this instance, the \(Diverge\) function helps by
producing variants with a common pattern of mutations.

```
set.seed(23)
m1 <- GetRandomSeq(50)
p2 <- Diverge(3:5,m1)
DottedAlignment(c(m1,p2))
```

```
## [1] "ATTGTAGGACTAGAATTGCCGCACTCACGCGGCGCTAAGTGGTAGCTAGC"
## [2] "...........................A........C...........T."
## [3] "...........................A........C.......A...T."
## [4] "...........................A..T.....C.......A...T."
```

Variants of these sequences can be produced in the usual way by \(GenerateVars\).

```
v1 <- GenerateVars(m1,20,3,c(10,4,0.2))
wv1 <- fn.ab(length(v1),h=1000,r=1.5,fn="pcf")
wp2 <- c(600,1000,400)
v2 <- GenerateVars(p2[2],20,3,c(10,1,0.1))
wv2 <- fn.ab(length(v2),r=2,h=wp2[2]*3,fn="pcf")

qs <-DNAStringSet(c(m1,v1,p2,v2))
w <- round(c(10000,wv1,wp2,wv2))

lst <- SortByMutations(qs,w)
qs <- lst$bseqs
data.frame(Hpl=DottedAlignment(qs),nr=lst$nr)
```

```
##                                                           Hpl    nr
## Hpl_0_0001 ATTGTAGGACTAGAATTGCCGCACTCACGCGGCGCTAAGTGGTAGCTAGC 10000
## Hpl_1_0001 ...T..............................................  1000
## Hpl_1_0002 .............................................A....   353
## Hpl_1_0003 ...........G......................................   192
## Hpl_1_0004 ................................T.................   125
## Hpl_1_0005 ...........................G......................    89
## Hpl_1_0006 .........T........................................    68
## Hpl_1_0007 ....G.............................................    53
## Hpl_1_0008 ................A.................................    37
## Hpl_1_0009 ...........G......................................    27
## Hpl_1_0010 ..................G...............................    19
## Hpl_1_0011 ........................................C.........    17
## Hpl_1_0012 ...............................................C..    15
## Hpl_1_0013 ....................C.............................    13
## Hpl_1_0014 ..........................T.......................    12
## Hpl_2_0001 .........T................T.......................    44
## Hpl_2_0002 .................................A...............T    24
## Hpl_2_0003 ......A......................T....................    21
## Hpl_2_0004 .........................T.............A..........    14
## Hpl_2_0005 ........................G...............A.........    11
## Hpl_3_0001 ...........................A........C...........T.   600
## Hpl_3_0002 .........G..............C...............A.........    31
## Hpl_3_0003 ...........................A........C.......A.....    10
## Hpl_4_0001 ...........................A........C.......A...T.  1000
## Hpl_4_0002 ...........................A........C.......A...C.    17
## Hpl_5_0001 ....C......................A........C.......A...T.  3000
## Hpl_5_0002 .......................G...A........C.......A...T.   750
## Hpl_5_0003 ...........................A..T.....C.......A...T.   400
## Hpl_5_0004 ...........................A........C.....G.A...T.   333
## Hpl_5_0005 ........................A..A........C.......A...T.   187
## Hpl_5_0006 .................T.........A........C.......A...T.   120
## Hpl_5_0007 ...........................A....G...C.......A...T.    83
## Hpl_5_0008 ......................T....A........C.......A...T.    61
## Hpl_5_0009 ...........................A...C....C.......A...T.    37
## Hpl_5_0010 ...............G...........A........C.......A...T.    30
## Hpl_5_0011 ...........................A........C.....A.A...T.    24
## Hpl_5_0012 ..........................TA........C.......A...T.    20
## Hpl_5_0013 ....G......................A........C.......A...T.    15
## Hpl_5_0014 ...........................A........C.......A.C.T.    13
## Hpl_5_0015 .................A.........A........C.......A...T.    11
## Hpl_5_0016 .................T.........A........C.......A...T.     9
## Hpl_5_0017 ...........................A........C.......AT..T.     8
## Hpl_6_0001 ...........................A.......CC...A...A...T.    46
## Hpl_6_0002 ..........................TA........C.......A.G.T.     7
```

The genome Hpl\_4\_0001 gives rise to the segregating population.

```
cnm <- cumsum(table(lst$nm))+1
nm.pos <- as.vector(cnm)[-length(cnm)]
names(nm.pos) <- names(cnm[-1])
bp <- barplot(lst$nr,col=c("lavender","pink")[c(rep(1,22),rep(2,20))])
axis(1,at=bp[nm.pos],labels=names(nm.pos),cex.axis=0.7)
```

![Simulated abundances with diverging populations](data:image/png;base64...)

Figure 7: Simulated abundances with diverging populations

---

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] psych_2.5.6         QSutils_1.28.0      pwalign_1.6.0
##  [4] ggplot2_4.0.0       ape_5.8-1           Biostrings_2.78.0
##  [7] Seqinfo_1.0.0       XVector_0.50.0      IRanges_2.44.0
## [10] S4Vectors_0.48.0    BiocGenerics_0.56.0 generics_0.1.4
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] sass_0.4.10         lattice_0.22-7      digest_0.6.37
##  [4] magrittr_2.0.4      evaluate_1.0.5      grid_4.5.1
##  [7] RColorBrewer_1.1-3  bookdown_0.45       fastmap_1.2.0
## [10] jsonlite_2.0.0      tinytex_0.57        BiocManager_1.30.26
## [13] scales_1.4.0        jquerylib_0.1.4     mnormt_2.1.1
## [16] cli_3.6.5           rlang_1.1.6         crayon_1.5.3
## [19] withr_3.0.2         cachem_1.1.0        yaml_2.3.10
## [22] tools_4.5.1         parallel_4.5.1      dplyr_1.1.4
## [25] vctrs_0.6.5         R6_2.6.1            magick_2.9.0
## [28] lifecycle_1.0.4     pkgconfig_2.0.3     bslib_0.9.0
## [31] pillar_1.11.1       gtable_0.3.6        glue_1.8.0
## [34] Rcpp_1.1.0          xfun_0.53           tibble_3.3.0
## [37] tidyselect_1.2.1    knitr_1.50          dichromat_2.0-0.1
## [40] farver_2.1.2        htmltools_0.5.8.1   nlme_3.1-168
## [43] rmarkdown_2.30      labeling_0.4.3      compiler_4.5.1
## [46] S7_0.2.0
```

# References

Gregori, Josep, Celia Perales, Francisco Rodriguez-Frias, Juan I. Esteban, Josep Quer, and Esteban Domingo. 2016. “Viral quasispecies complexity measures.” *Virology* 493: 227–37. <https://doi.org/10.1016/j.virol.2016.03.017>.

Gregori, Josep, Miquel Salicrú, Esteban Domingo, Alex Sanchez, Juan I. Esteban, Francisco Rodríguez-Frías, and Josep Quer. 2014. “Inference with viral quasispecies diversity indices: Clonal and NGS approaches.” *Bioinformatics* 30 (8): 1104–11. <https://doi.org/10.1093/bioinformatics/btt768>.