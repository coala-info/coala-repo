EDIRquery

Laura D.T. Vo Ngoc

2025-10-29

Introduction

Intragenic exonic deletions are known to contribute to genetic diseases and are often flanked by regions of
homology. The Exome Database of Interspersed Repeats (EDIR) was developed to provide an overview of the
positions of repetitive structures within the human genome composed of interspersed repeats encompassing a
coding sequence. The package EDIRquery provides user-friendly tools to query this database for genes of
interest.

Dataset

EDIR provides a dataset of pairwise repeat structures in which both sequences are located within a maximum
of 1000 bp from each other, and fulfill one of the following selection criteria:

• >= 1 repeat located in an exon

• Both repeats situated in different introns flanking one or more exons

A subset of EDIR is provided as example data, representing a subset of the interspersed repeats data for the
gene GAA (ENSG00000171298) on chromosome 17.

To query the full the database, provide the data directory to gene_lookup() in the path parameter.

Usage

Installation

To install this package, enter the following in R:

if (!require("BiocManager", quietly = TRUE))

install.packages("BiocManager")

BiocManager::install("EDIRquery")

Then load the package:

library("EDIRquery")

EDIR can easily be queried using the gene_lookup function, using the gene name and additional parameters:

Argument

gene

Description

required: The gene name (ENSEMBLE ID or HGNC
symbol)

Default

-

1

Description

Repeat sequence length, must be between 7 and 20. If NA,
results will include all available lengths in dataset for queried
gene
Minimum spacer distance (bp) between repeats
Maximum spacer distance (bp) between repeats
Output table format. One of ‘data.frame’, ‘GInteractions’.
Logical value indicating whether to store summary
Logical value indicating whether to allow 1 mismatch in
sequence
String containing path to directory holding downloaded
dataset files. If not provided (path = NA), example subset of
data will be used

Default

NA

0
1000
‘data.frame’
FALSE
TRUE

NA

Argument

length

mindist
maxdist
format
summary
mismatch

path

Examples

A summary of the input printed to console, including the gene name, gene length (bp), Ensembl transcript
ID, queried distance between repeats (default: 0-1000 bp), and an overview of total results for the given
repeat length. Console outputs include runtime.

Example querying the gene “GAA” with repeats of length 7, and allowing for 1 mismatch:

ENSG00000171298 / GAA
18325 bp
ENST00000302262
0-1000 bp
TRUE

# Summary of results (printed to console)
gene_lookup("GAA", length = 7, mismatch = TRUE)
#> Parameters
#> Repeat length: 7 bp
#>
#> Gene:
#> Gene length:
#> Transcript ID:
#> Distance:
#> Mismatch:
#>
#>
#>
#> 1
#>
#> 1
#>
#>
#> Runtime: 0.82 sec elapsed

0.5708049

570804.9

5172

repeat_length unique_seqs tot_instances tot_structures avg_dist
14562 486.2603

10460
norm_instances_bp norm_instances_Mb norm_structures_bp norm_structures_Mb
794652.1

0.7946521

7

If no length is provided, a summary of all available repeat length results will be printed:
# Summary of results (printed to console)
gene_lookup("GAA", mismatch = TRUE)
#> Parameters
#>
#>
#> Gene:
#> Gene length:
#> Transcript ID:
#> Distance:
#> Mismatch:

ENSG00000171298 / GAA
18325 bp
ENST00000302262
0-1000 bp
TRUE

2

repeat_length unique_seqs tot_instances tot_structures avg_dist
14562 486.2603
7062 516.1827
2226 508.7588
690 500.2217
209 492.5263
63 454.6190
21 346.2857
7 271.1429
43.0000
2
42.0000
1

10460
7592
3461
1227
399
124
42
14
4
2

5172
5677
3160
1172
389
122
42
14
4
2

norm_instances_bp norm_instances_Mb norm_structures_bp norm_structures_Mb
794652.11460
385375.17053
121473.39700
37653.47885
11405.18417
3437.92633
1145.97544
381.99181
109.14052
54.57026

7.946521e-01
3.853752e-01
1.214734e-01
3.765348e-02
1.140518e-02
3.437926e-03
1.145975e-03
3.819918e-04
1.091405e-04
5.457026e-05

570804.9113
414297.4079
188867.6671
66957.7080
21773.5334
6766.7121
2291.9509
763.9836
218.2810
109.1405

7
8
9
10
11
12
13
14
15
16

#>
#>
#>
#> 1
#> 2
#> 3
#> 4
#> 5
#> 6
#> 7
#> 8
#> 9
#> 10
#>
#> 1
#> 2
#> 3
#> 4
#> 5
#> 6
#> 7
#> 8
#> 9
#> 10
#>
#>
#> Runtime: 0.824 sec elapsed

0.5708049113
0.4142974079
0.1888676671
0.0669577080
0.0217735334
0.0067667121
0.0022919509
0.0007639836
0.0002182810
0.0001091405

Storing the output in a variable allows viewing of the individual results in the output dataframe:

7 bp

ENSG00000171298 / GAA
18325 bp
ENST00000302262
0-1000 bp
TRUE

# Database output of query
results <- gene_lookup("GAA", length = 7, mismatch = TRUE)
#> Parameters
#> Repeat length:
#>
#> Gene:
#> Gene length:
#> Transcript ID:
#> Distance:
#> Mismatch:
#>
#>
#>
#> 1
#>
#> 1
#>
#>
#> Runtime: 0.646 sec elapsed
head(results)
#>
#> 3930
#> 3931
#> 3932

chromosome repeat_length

0.5708049

570804.9

17
17
17

start1

end1

7

start2

repeat_length unique_seqs tot_instances tot_structures avg_dist
14562 486.2603

10460
norm_instances_bp norm_instances_Mb norm_structures_bp norm_structures_Mb
794652.1

0.7946521

5172

7 80101595 80101601 80101734 80101740
7 80105602 80105608 80105843 80105849
7 80110005 80110011 80110061 80110067

end2 repeat_seq1
CCGCGGG
CCGAGGC
CGGAGGG

3

7 80118254 80118260 80118270 80118276
7 80118270 80118276 80118318 80118324
7 80118270 80118276 80118533 80118539

CCAAGGG
CCGAGGG
CCGAGGG

intron_exon1 repeat_seq2 intron_exon2 distance ensembl_gene_id hgnc_symbol
GAA
GAA
GAA
GAA
GAA
GAA

132 ENSG00000171298
234 ENSG00000171298
49 ENSG00000171298
9 ENSG00000171298
41 ENSG00000171298
256 ENSG00000171298

CCGCGGG
CCGAGGA
GCGAGGG
CCGAGGG
GCGAGGG
CAGAGGG

E1
E3
I9
E18
E18
I18

gene_range ensembl_transcript_id

transcript_range
ENST00000302262 80101581-80101890
ENST00000302262 80105133-80105748
ENST00000302262 80109945-80110055
ENST00000302262 80118193-80118357
ENST00000302262 80118193-80118357
ENST00000302262 80118193-80118357

17
17
17

E1
I2
E9
E18
E18
E18

#> 3933
#> 3934
#> 3935
#>
#> 3930
#> 3931
#> 3932
#> 3933
#> 3934
#> 3935
#>
#> 3930 80101556-80119881
#> 3931 80101556-80119881
#> 3932 80101556-80119881
#> 3933 80101556-80119881
#> 3934 80101556-80119881
#> 3935 80101556-80119881
#>
#> 3930
same exon
#> 3931 spanning intron-exon
#> 3932 spanning intron-exon
same exon
#> 3933
#> 3934
same exon
#> 3935 spanning intron-exon

feature mismatch
0
1
1
1
1
1

Changing the format parameter to GInteractions returns a GenomicInteractions object instead of a
dataframe:

7 bp

ENSG00000171298 / GAA
18325 bp
ENST00000302262
0-1000 bp
TRUE

# Database output of query
results <- gene_lookup("GAA", length = 7, format = "GInteractions", mismatch = TRUE)
#> Parameters
#> Repeat length:
#>
#> Gene:
#> Gene length:
#> Transcript ID:
#> Distance:
#> Mismatch:
#>
#>
#>
#> 1
#>
#> 1
#>
#>
#> Runtime: 0.746 sec elapsed
head(results)
#> GInteractions object with 6 interactions and 11 metadata columns:
#>
#>
#>
#>
#>

10460
norm_instances_bp norm_instances_Mb norm_structures_bp norm_structures_Mb
794652.1

repeat_length unique_seqs tot_instances tot_structures avg_dist
14562 486.2603

ranges2 |
<IRanges> |
17 80101734-80101740 |
17 80105843-80105849 |
17 80110061-80110067 |

17 80101595-80101601 ---
17 80105602-80105608 ---
17 80110005-80110011 ---

seqnames2
<Rle>

seqnames1
<Rle>

ranges1
<IRanges>

[1]
[2]
[3]

0.7946521

0.5708049

570804.9

5172

7

4

#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>
#>

[4]
[5]
[6]

[1]
[2]
[3]
[4]
[5]
[6]

[1]
[2]
[3]
[4]
[5]
[6]

17 80118254-80118260 ---
17 80118270-80118276 ---
17 80118270-80118276 ---

17 80118270-80118276 |
17 80118318-80118324 |
17 80118533-80118539 |

anchor1.repeat_seq1 anchor1.intron_exon1 anchor2.repeat_seq2
<character>
CCGCGGG
CCGAGGA
GCGAGGG
CCGAGGG
GCGAGGG
CAGAGGG

<character>
E1
I2
E9
E18
E18
E18

<character>
CCGCGGG
CCGAGGC
CGGAGGG
CCAAGGG
CCGAGGG
CCGAGGG

anchor2.intron_exon2 ensembl_gene_id hgnc_symbol
<character> <character>

<character>

E1 ENSG00000171298
E3 ENSG00000171298
I9 ENSG00000171298
E18 ENSG00000171298
E18 ENSG00000171298
I18 ENSG00000171298

gene_range
<character>
GAA 80101556-80119881
GAA 80101556-80119881
GAA 80101556-80119881
GAA 80101556-80119881
GAA 80101556-80119881
GAA 80101556-80119881

feature

ensembl_transcript_id
<character>

transcript_range
<character>
same exon
ENST00000302262 80101581-80101890
ENST00000302262 80105133-80105748 spanning intron-exon
ENST00000302262 80109945-80110055 spanning intron-exon
same exon
ENST00000302262 80118193-80118357
same exon
ENST00000302262 80118193-80118357
ENST00000302262 80118193-80118357 spanning intron-exon

[1]
[2]
[3]
[4]
[5]
[6]
-------
regions: 10460 ranges and 0 metadata columns
seqinfo: 1 sequence from an unspecified genome; no seqlengths

mismatch
<character> <integer>
0
1
1
1
1
1

Session info

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

# Database output of query
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
#>
#> locale:
#> [1] LC_CTYPE=en_US.UTF-8
#> [3] LC_TIME=en_GB
#> [5] LC_MONETARY=en_US.UTF-8
#> [7] LC_PAPER=en_US.UTF-8
#> [9] LC_ADDRESS=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

5

LAPACK version 3.12.0

methods

base

datasets

graphics

grDevices utils

Matrix_1.7-4
compiler_4.5.1
Rcpp_1.1.0

#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats
#>
#> other attached packages:
#> [1] EDIRquery_1.10.0
#>
#> loaded via a namespace (and not attached):
#> [1] bit_4.6.0
#> [3] crayon_1.5.3
#> [5] tidyselect_1.2.1
#> [7] SummarizedExperiment_1.40.0 Biobase_2.70.0
IRanges_2.44.0
#> [9] GenomicRanges_1.62.0
yaml_2.3.10
#> [11] Seqinfo_1.0.0
lattice_0.22-7
#> [13] fastmap_1.2.0
R6_2.6.1
#> [15] readr_2.1.5
S4Arrays_1.10.0
#> [17] XVector_0.50.0
knitr_1.50
#> [19] generics_0.1.4
tibble_3.3.0
#> [21] BiocGenerics_0.56.0
MatrixGenerics_1.22.0
#> [23] DelayedArray_0.36.0
pillar_1.11.1
#> [25] tzdb_0.5.0
xfun_0.53
#> [27] rlang_1.1.6
SparseArray_1.10.0
#> [29] bit64_4.6.0-1
magrittr_2.0.4
#> [31] cli_3.6.5
digest_0.6.37
#> [33] tictoc_1.2.1
grid_4.5.1
#> [35] InteractionSet_1.38.0
hms_1.1.4
#> [37] vroom_1.6.6
S4Vectors_0.48.0
#> [39] lifecycle_1.0.4
evaluate_1.0.5
#> [41] vctrs_0.6.5
abind_1.4-8
#> [43] glue_1.8.0
rmarkdown_2.30
#> [45] stats4_4.5.1
tools_4.5.1
#> [47] matrixStats_1.5.0
htmltools_0.5.8.1
#> [49] pkgconfig_2.0.3

6

