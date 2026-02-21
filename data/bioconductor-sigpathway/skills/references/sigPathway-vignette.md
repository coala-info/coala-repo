sigPathway: Pathway Analysis with Microarray Data

Weil Lai1, Lu Tian2, and Peter Park1,3

May 5, 2017

1. Harvard-Partners Center for Genetics and Genomics, 77 Avenue Louis Pasteur, Boston, MA
02115
2. Department of Preventive Medicine, Feinberg School of Medicine, Northwestern University, 680
North Lake Shore Drive, Chicago, IL 60611
3. Children’s Hospital Informatics Program, 300 Longwood Avenue, Boston, MA 02115

Contents

1 Introduction

2 Data

3 Example

4 Notes

1 Introduction

1

1

2

7

sigPathway is an R package that performs pathway (gene set) analysis on microarray data.
It
calculates two gene set statistics, the N Tk (Q1) and N Ek (Q2), by permutation, ranks the pathways
based on the magnitudes of the two statistical tests, and estimates q-values for each pathway (Tian
et al., 2005). The program permutes the rows and columns of the expression matrix for N Tk and
N Ek, respectively. In this vignette, we demonstrate how the user can use this package to identify
statistically signiﬁcant pathways in their data and export the results to HTML for browsing.

2 Data

In Tian et al. (2005), microarray data from patients with diabetes, inﬂammatory myopathies, and
Alzheimers’ data sets were analyzed. To save disk space, a small portion of the inﬂammatory
myopathies data set has been included with sigPathway as an example data set. Expression values
and annotations for this data set are stored in the MuscleExample workspace. This workspace
contains the following R objects:

tab a ﬁltered numeric matrix containing expression values from 7/13 normal (NORM) and 8/23
inclusion body myositis (IBM) samples. The row and column names of the matrix correspond
to Aﬀymetrix probe set IDs and sample IDs, respectively. The 5000 probe sets in this matrix
represent the most variable probe sets (by expression value) in the 15 arrays.

1

phenotype a character vector with 0_NORM to represent NORM and 1_IBM to represent IBM

G a pathway annotation list containing the pathway’s source, title, and associated probe set IDs

To load this data set, type ’data(MuscleExample)’ after loading the sigPathway package.

The pathways annotated in G were curated from Gene Ontology, KEGG, BioCarta, BioCyc, and
SuperArray. Each element within G is a list describing a pathway with the following sub-elements:

src a character vector containing either the pathway ID (for Gene Ontology) or the name of the

pathway database

title a character vector containing the pathway name

probes a character vector containing probe set IDs that are associated with the pathway (by

mapping them to Entrez Gene IDs)

The full inﬂammatory myopathway data set and pathway annotations for other, selected Aﬀymetrix
microarray platforms are available at http://www.chip.org/~ppark/Supplements/PNAS05.html.
For example, the more comprehensive pathway annotation list for the Aﬀymetrix HG-U133A plat-
form is called GenesetsU133a. For arrays not listed on the website (or for scenarios such as linkage
analysis), the user can make his/her own pathway annotations and use them in sigPathway as long
as the pathway annotations are arranged in the above format.

3 Example

In this section, we show the R code necessary to conduct pathway analysis with sigPathway on an
example data set.

First, we load sigPathway and the example data set into memory. If we are dealing with the
full data set, we could remove probe sets that have expression values less than the trimmed mean
in all of the arrays. We assume that the probe sets with lower expression values across all arrays
are not of interest. The trimmed mean was used as the ﬁltering criteron in Tian et al. (2005). The
probe sets in the example data set were selected for their variance across 15 arrays (not shown).

> library(sigPathway)
> data(MuscleExample)
> ls()

[1] "G"

"phenotype" "tab"

>

For microarray data, the convention is to use rows and columns to represent probe sets and in-
dividual arrays, respectively. To tell the program which column in tab belongs to which phenotype,
we have created a character vector with 0_NORM to represent NORM and 1_IBM to represent IBM.
Because 0_NORM comes before 1_IBM in alphanumeric order, the program internally treats NORM
as 0 and IBM as 1. Alternatively, we could have simply used the numerals 0 and 1 to represent
NORM and IBM. Note that the row names for tab are probe set IDs.

> dim(tab)

2

[1] 5000

15

> print(tab[501:504, 1:3])

217466_x_at
211939_x_at
203932_at
200715_x_at

GEIM1.IBM.S GEIM7.IBM.S GEIM20.IBM.S
23736
36890
13392
18865

4085
32293
3596
12647

3203
28250
6452
20792

> table(phenotype)

phenotype
0_NORM 1_IBM
8

7

>

How much do IBM and NORM samples diﬀer? Let us plot the unadjusted p-values for each
probe set from the 2 group (sample) t-test, assuming unequal variances and using the Welch ap-
proximation to estimate the appropriate degrees of freedom.

> statList <- calcTStatFast(tab, phenotype, ngroups = 2)
> hist(statList$pval, breaks = seq(0,1,0.025), xlab = "p-value",
+

ylab = "Frequency", main = "")

3

The two diﬀerent types of samples are certainly very diﬀerent by the probe set level, but what
pathways are driving the diﬀerences? With our pathway annotations, we calculate the N Tk and
N Ek statistics for each gene set, and rank the top pathways based on the magnitude of the two
statistics. The result is stored in a list (res.muscle), of which we will later use to write results to
HTML.

> set.seed(1234)
> res.muscle <-
+
+
+
+

runSigPathway(G, 20, 500, tab, phenotype, nsim = 1000,

weightType = "constant", ngroups = 2, npath = 25,
verbose = FALSE, allpathways = FALSE, annotpkg = "hgu133a.db",
alwaysUseRandomPerm = FALSE)

Selecting the gene sets
Calculating NTk statistics for each selected gene set
Calculating NEk statistics for each selected gene set
Summarizing the top 25 pathways from each statistic
Done! Use the writeSigPathway() function to write results to HTML

The set.seed function is used here only for the purpose of getting the exact results when

regenerating this vignette from its source ﬁles.

4

p−valueFrequency0.00.20.40.60.81.0020040060080010001200Because there can be many thousands of pathways represented in the pathway annotations, we
have chosen to analyze pathways that contain at least 20 probe sets as represented in tab. We
also exclude pathways represented by more than 500 probe sets because larger pathways tend to be
non-speciﬁc. These two values were the ones used in Tian et al. (2005). To save space, our pathway
annotation list has already been ﬁltered with the above criteria. So, all of the 626 pathways in G
will be considered in the calculations.

The run time of the N Tk and N Ek is approximately linearly proportional to nsim, or the
maximum number of permutations. When alwaysUseRandomPerm is set to FALSE (the default
value), the program will use a smaller nsim for the N Ek calculations and switch to using complete
permutation if the total number of unique permutations for the phenotype is less than nsim.

We are setting weightType to ’constant’ because of the additional time required to calculate
If the histogram of unadjusted p-values (of the probe sets) is nearly
variable weights for N Ek.
horizontal, and we later observe high q-values (i.e., approaching 1) for the top ranked pathways,
then setting weightType to ’variable’ would help lower some of the N Ek q-values.

To rank the pathways, the program adds up the ranks corresponding to the magnitudes of N Tk
and N Ek. When npath is set to 25 and allpathways to FALSE, the program considers the top
25 pathways for each gene set statistic before summing the individual ranks. If allpathways is
set to TRUE, then all pathways are ranked for each gene set statistic before summing the individual
ranks. Here, allpathways is set to FALSE because we are interested in observing pathways that are
consistently highly ranked for each gene set statistic.

Also, please note that out of the numerous input parameters to runSigPathway, annotpkg is
optional because it refers to a Bioconductor metadata package that may not already be present on
your installation of R. In our example, ’hgu133a.db’ refers to the BioConductor metadata package
of the Aﬀymetrix HG-U133A platform. By specifying ’hgu133a.db’ for annotpkg, runSigPathway
will include the accession number, Entrez Gene ID, gene symbol, and gene name of probe sets
associated with each pathway in the list of top pathways.

Printed below is a table of the top 10 pathways, the set size, the N Tk and N Ek statistics, and

the statistics’ ranks and q-values. This table is accessible through the following command:

> print(res.muscle$df.pathways[1:10, ])

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

1
2
3
4
5

IndexG Gene Set Category
GO:0019883
GO:0042611
GO:0042612
GO:0019882
GO:0030333
GO:0019885
GO:0030106
GO:0001772
humanpaths
humanpaths

234
292
293
233
84
237
117
92
613
601

antigen presentation, endogenous antigen
MHC protein complex
MHC class I protein complex
antigen presentation
antigen processing

Pathway Set Size Percent Up
0.00
0.00
0.00
0.00
0.00

22
20
20
45
44

5

6 antigen processing, endogenous antigen via MHC class I
MHC class I receptor activity
7
8
immunological synapse
9
10

Interferon a,b Response
Dendritic / Antigen Presenting Cell

23
22
26
71
105

0.00
0.00
0.00
12.68
5.71

NTk Stat NTk q-value NTk Rank NEk Stat NEk q-value NEk Rank
2
1
1
7
6
4
3
5
9
11

18.97
17.83
17.83
19.41
19.03
18.44
18.37
16.95
10.79
10.66

9.33
9.36
9.36
7.24
7.26
9.11
9.28
8.27
4.83
3.62

0
0
0
0
0
0
0
0
0
0

3
6
6
1
2
4
5
7
8
9

0
0
0
0
0
0
0
0
0
0

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

The positive signs on the gene set statistics indicate that the corresponding pathways are more
highly expressed in IBM compared to NORM. Had we deﬁned 1 for NORM and 0 for IBM, the
interpretation would remain the same, but we would expect the signs for the gene set statistics to
be ﬂipped.

Detailed information about each probe set in each pathway on the list of top pathways are
stored in the list.gPS, an element within res.muscle. list.gPS is a list containing data frames
describing the probe sets for each top pathway. For example, let us view the annotations and test
statistics for 10 probe sets in the MHC class I receptor activity pathway.

> print(res.muscle$list.gPS[[7]][1:10, ])

Probes

567
567

201891_s_at 201891_s_at NM_004048
216231_s_at 216231_s_at AW188940
218831_s_at 218831_s_at NM_004107
213932_x_at 213932_x_at AI923492
215313_x_at 215313_x_at AA573862
D83043
208729_x_at 208729_x_at
L42024
209140_x_at 209140_x_at
211911_x_at 211911_x_at
L07950
208812_x_at 208812_x_at BC004489
U62824
211799_x_at 211799_x_at

AccNum GeneID Symbol
B2M
B2M
2217 FCGRT
3105 HLA-A
3105 HLA-A
3106 HLA-B
3106 HLA-B
3106 HLA-B
3107 HLA-C
3107 HLA-C

beta-2-microglobulin
201891_s_at
beta-2-microglobulin
216231_s_at
218831_s_at Fc fragment of IgG receptor and transporter
213932_x_at major histocompatibility complex, class I, A
215313_x_at major histocompatibility complex, class I, A
208729_x_at major histocompatibility complex, class I, B
209140_x_at major histocompatibility complex, class I, B
211911_x_at major histocompatibility complex, class I, B

Name Mean_0_NORM Mean_1_IBM
64165.88
78550.75
4444.00
65602.12
68365.12
46637.62
65679.25
53755.88

38735.143
43285.857
1592.000
23739.857
20685.286
6648.571
12258.857
9150.286

6

208812_x_at major histocompatibility complex, class I, C
211799_x_at major histocompatibility complex, class I, C

13994.429
2167.571

62945.38
23667.38

StDev_0_NORM StDev_1_IBM T-Statistic

201891_s_at
216231_s_at
218831_s_at
213932_x_at
215313_x_at
208729_x_at
209140_x_at
211911_x_at
208812_x_at
211799_x_at

5551.0402
4350.8622
351.2762
6463.6639
5568.5959
609.5618
1433.5514
2499.9600
1825.2766
451.3210

7325.835
9728.212
2263.444
8931.066
9316.500
11082.266
5988.982
14031.821
8910.416
8454.758

p-value
7.629433 4.155125e-06
9.250160 3.329180e-06
3.515833 8.973576e-03
10.485603 1.363431e-07
12.197747 5.615578e-08
10.188448 1.804436e-05
24.441414 9.843999e-09
8.832473 3.162204e-05
15.178761 5.386934e-07
7.180791 1.749504e-04

A much more intuitive method to browse through the results is to write the results to HTML,
which can then be read by an Internet browser program (e.g., Mozilla Firefox, Microsoft Internet
Explorer). Writing the results can be achieved with the writeSigPathway function. Please refer to
the help ﬁle of writeSigPathway for more details on how to save to results to a speciﬁc directory.
Figures 1 and 2 show examples of the HTML output after running writeSigPathway and opening
the corresponding HTML ﬁle in an Internet browser.

4 Notes

This vignette was compiled with the following settings:

> print(sessionInfo())

R version 3.4.0 (2017-04-21)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 16.04.2 LTS

Matrix products: default
BLAS: /home/biocbuild/bbs-3.5-bioc/R/lib/libRblas.so
LAPACK: /home/biocbuild/bbs-3.5-bioc/R/lib/libRlapack.so

locale:

[1] LC_CTYPE=en_US.UTF-8
[3] LC_TIME=en_US.UTF-8
[5] LC_MONETARY=en_US.UTF-8
[7] LC_PAPER=en_US.UTF-8
[9] LC_ADDRESS=C

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

[11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C

attached base packages:
[1] parallel stats4
[8] methods

base

stats

graphics grDevices utils

datasets

other attached packages:

7

Figure 1: List of Top Pathways in Inclusion Body Myositis versus Normal

8

Figure 2: MHC class I receptor activity

9

[1] hgu133a.db_3.2.3
[4] IRanges_2.10.0
[7] BiocGenerics_0.22.0 sigPathway_1.44.1

org.Hs.eg.db_3.4.1
S4Vectors_0.14.0

AnnotationDbi_1.38.0
Biobase_2.36.2

loaded via a namespace (and not attached):
[1] compiler_3.4.0 DBI_0.6-1
[6] RSQLite_1.1-2 digest_0.6.12

tools_3.4.0

memoise_1.1.0 Rcpp_0.12.10

References

Lu Tian, Steven A Greenberg, Sek Won Kong, Josiah Altschuler, Isaac S Kohane, and Peter J Park.
Discovering statistically signiﬁcant pathways in expression proﬁling studies. Proc Natl Acad Sci
U S A, 102(38):13544–13549, Sep 2005.

10

