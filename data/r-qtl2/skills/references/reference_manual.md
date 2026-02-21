Package ‘qtl2’

July 22, 2025

Version 0.38

Date 2025-06-02

Title Quantitative Trait Locus Mapping in Experimental Crosses

Description Provides a set of tools to perform quantitative

trait locus (QTL) analysis in experimental crosses. It is a
reimplementation of the 'R/qtl' package to better handle
high-dimensional data and complex cross designs.
Broman et al. (2019) <doi:10.1534/genetics.118.301595>.

Author Karl W Broman [aut, cre] (ORCID:

<https://orcid.org/0000-0002-4914-6671>),
R Core Team [ctb]

Maintainer Karl W Broman <broman@wisc.edu>
Copyright Code for Brent's method for univariate function optimization
was taken from R 3.2.2 (Copyright 1995, 1996 Robert Gentleman
and Ross Ihaka, Copyright 2003-2004 The R Foundation, Copyright
1998-2014 The R Core Team).

Depends R (>= 3.1.0)

Imports Rcpp (>= 1.0.7), yaml (>= 2.1.13), jsonlite (>= 0.9.17),
data.table (>= 1.10.4-3), parallel, stats, utils, graphics,
grDevices, RSQLite

Suggests testthat, devtools, roxygen2, vdiffr, qtl

License GPL-3

URL https://kbroman.org/qtl2/, https://github.com/rqtl/qtl2

BugReports https://github.com/rqtl/qtl2/issues
LazyData true

Encoding UTF-8

ByteCompile true

LinkingTo Rcpp, RcppEigen

RoxygenNote 7.3.2

NeedsCompilation yes

1

2

Repository CRAN

Date/Publication 2025-06-02 13:00:02 UTC

Contents

Contents

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

5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
.
.
.
add_threshold .
6
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.
basic_summaries
8
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.
.
.
.
.
.
.
batch_cols .
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
.
.
.
.
.
.
batch_vec .
9
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
.
.
.
.
.
.
.
bayes_int
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 11
.
.
.
.
calc_entropy .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
.
.
.
.
calc_errorlod .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
.
.
.
calc_genoprob .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
.
.
.
calc_geno_freq .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
. .
.
.
.
.
.
calc_grid .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
. .
.
.
.
.
calc_het
.
.
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 18
.
.
calc_kinship .
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
.
.
calc_raw_founder_maf
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
.
.
.
calc_raw_geno_freq .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
. .
.
.
.
.
calc_raw_het
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 21
. .
.
.
.
.
calc_raw_maf .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
.
.
calc_sdp .
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
.
.
cbind.calc_genoprob .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 24
.
.
.
cbind.scan1 .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
.
.
.
cbind.scan1perm .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26
.
.
.
.
cbind.sim_geno .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
. .
.
.
.
.
.
.
cbind.viterbi .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 27
.
.
.
.
.
cbind_expand .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28
. .
.
.
.
.
.
CCcolors
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
. .
.
.
.
.
.
check_cross2 .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
. .
.
.
.
.
.
chisq_colpairs .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 30
. .
.
.
.
.
.
.
chr_lengths
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 31
.
.
.
.
clean .
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 31
.
.
.
.
clean_genoprob .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 33
. .
.
.
.
.
.
clean_scan1 .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 34
.
compare_founder_geno .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 35
.
.
compare_geno .
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 36
.
.
compare_genoprob .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 37
. .
.
.
.
.
compare_maps
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 38
. .
.
.
.
convert2cross2 .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 39
count_xo .
.
.
.
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 40
create_gene_query_func .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 41
. .
.
create_snpinfo .
create_variant_query_func . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 42
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 44
.
decomp_kinship .
. .
. .
drop_markers .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 45
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 45
drop_nullmarkers .

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

Contents

3

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
est_herit .
.
.
est_map .
.
.
.
find_dup_markers .
.
.
find_ibd_segments
.
.
find_index_snp .
.
.
.
find_map_gaps
.
.
.
find_marker .
.
.
find_markerpos .
.
.
.
.
find_peaks .
.
.
.
.
fit1 .
.
.
.
.
.
.
fread_csv .
.
fread_csv_numer
.
.
genoprob_to_alleleprob .
.
.
genoprob_to_snpprob .
.
.
.
get_common_ids
.
.
.
.
get_x_covar .
.
.
.
.
guess_phase .
.
.
index_snps
.
.
.
.
.
insert_pseudomarkers .
.
.
.
interp_genoprob .
.
.
.
.
.
interp_map .
.
.
.
.
.
.
invert_sdp .
.
.
.
.
.
locate_xo .
.
.
.
.
.
.
.
.
lod_int .
.
.
.
.
.
map_to_grid .
.
.
.
.
.
.
mat2strata .
.
.
.
.
.
.
maxlod .
.
.
.
.
.
.
.
.
maxmarg .
.
.
.
max_compare_geno .
.
.
.
.
max_scan1 .
.
.
.
.
n_missing .
.
.
.
.
.
.
.
plot_coef
.
.
.
plot_compare_geno .
.
.
.
.
plot_genes .
.
.
.
.
plot_genoprob .
.
.
.
.
plot_genoprobcomp .
.
.
.
.
.
plot_lodpeaks .
.
.
.
.
.
plot_onegeno .
.
.
.
.
.
.
.
plot_peaks .
.
.
.
.
.
.
.
.
plot_pxg .
.
.
.
.
.
.
.
plot_scan1 .
.
.
.
.
.
.
plot_sdp .
.
.
.
.
.
.
plot_snpasso .
.
.
.
.
.
.
predict_snpgeno .
print.cross2 .
.
.
.
.
.
print.summary.scan1perm .
.
probs_to_grid .
.
pull_genoprobint

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

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 46
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 48
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 49
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 50
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 52
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 53
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 54
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 55
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 56
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 58
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 61
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 62
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 63
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 64
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 66
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 67
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 67
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 68
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 70
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 71
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 72
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 73
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 74
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 75
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 76
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 77
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 78
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 79
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 80
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 81
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 82
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 83
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 86
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 86
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 88
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 90
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 92
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 93
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 95
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 97
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 99
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 100
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 101
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 104
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 105
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 105
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 106
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 107

4

Contents

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
pull_genoprobpos .
.
.
.
pull_markers
.
.
.
.
qtl2version .
.
rbind.calc_genoprob .
.
.
.
rbind.scan1 .
.
.
.
.
rbind.scan1perm .
.
.
.
rbind.sim_geno .
.
.
.
.
rbind.viterbi .
.
.
.
.
read_cross2 .
.
.
.
.
read_pheno .
.
.
recode_snps .
.
.
.
.
reduce_map_gaps .
.
.
.
reduce_markers .
.
.
.
.
replace_ids
.
.
.
.
.
scale_kinship .
.
.
.
.
.
scan1 .
.
.
.
.
.
.
scan1blup .
.
.
.
.
.
scan1coef
.
.
.
.
.
.
scan1max .
.
.
.
.
.
scan1perm .
.
.
.
.
.
scan1snps .
.
.
.
.
.
sdp2char .
.
.
.
.
.
sim_geno .
.
.
.
.
.
smooth_gmap .
.
subset.calc_genoprob .
.
.
subset.cross2 .
.
.
.
subset.sim_geno .
.
.
.
subset.viterbi
.
.
.
subset_scan1 .
.
summary.cross2 .
.
.
summary_compare_geno .
.
summary_scan1perm .
.
.
top_snps .
.
.
.
.
.
unsmooth_gmap .
.
.
.
.
.
.
.
viterbi
.
.
write_control_file .
.
.
.
xpos_scan1 .
.
.
.
zip_datafiles .

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

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 108
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 109
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 110
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 110
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 111
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 112
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 113
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 114
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 115
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 116
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 117
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 118
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 118
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 120
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 121
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 122
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 125
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 127
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 129
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 131
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 134
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 137
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 137
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 139
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 140
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 141
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 142
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 143
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 144
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 145
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 145
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 146
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 148
.
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 150
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 151
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 152
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 155
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 157

Index

159

add_threshold

5

add_threshold

Add thresholds to genome scan plot

Description

Draw line segments at significance thresholds for a genome scan plot

Usage

add_threshold(map, thresholdA, thresholdX = NULL, chr = NULL, gap = NULL, ...)

Arguments

map

thresholdA

Marker map used in the genome scan plot

Autosomal threshold. Numeric or a list. (If a list, the "A" component is taken to
be thresholdA and the "X" component is taken to be thresholdX.)

thresholdX

X chromosome threshold (if missing, assumed to be the same as thresholdA)

Chromosomes that were included in the plot

Gap between chromosomes in the plot. Default is 1% of the total genome length.

Additional arguments passed to graphics::segments()

chr

gap

...

Value

None.

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

map <- insert_pseudomarkers(iron$gmap, step=5)
probs <- calc_genoprob(iron, map, error_prob=0.002)
Xcovar <- get_x_covar(iron)
out <- scan1(probs, iron$pheno[,1], Xcovar=Xcovar)
# run just 3 permutations, as a fast illustration
operm <- scan1perm(probs, iron$pheno[,1], addcovar=Xcovar,

n_perm=3, perm_Xsp=TRUE, chr_lengths=chr_lengths(map))

plot(out, map)
add_threshold(map, summary(operm), col="violetred", lty=2)

6

basic_summaries

basic_summaries

Basic summaries of a cross2 object

Description

Basic summaries of a cross2 object.

Usage

n_ind(cross2)

n_ind_geno(cross2)

n_ind_pheno(cross2)

n_ind_covar(cross2)

n_ind_gnp(cross2)

ind_ids(cross2)

ind_ids_geno(cross2)

ind_ids_pheno(cross2)

ind_ids_covar(cross2)

ind_ids_gnp(cross2)

n_chr(cross2)

n_founders(cross2)

founders(cross2)

chr_names(cross2)

tot_mar(cross2)

n_mar(cross2)

marker_names(cross2)

n_pheno(cross2)

pheno_names(cross2)

basic_summaries

7

n_covar(cross2)

covar_names(cross2)

n_phenocovar(cross2)

phenocovar_names(cross2)

Arguments

cross2

Value

An object of class "cross2", as output by read_cross2(). For details, see the
R/qtl2 developer guide.

Variously a number, vector of numbers, or vector of character strings.

Functions

• n_ind(): Number of individuals (either genotyped or phenotyped)
• n_ind_geno(): Number of genotyped individuals
• n_ind_pheno(): Number of phenotyped individuals
• n_ind_covar(): Number of individuals with covariate data
• n_ind_gnp(): Number of individuals with both genotype and phenotype data
• ind_ids(): IDs of individuals (either genotyped or phenotyped)
• ind_ids_geno(): IDs of genotyped individuals
• ind_ids_pheno(): IDs of phenotyped individuals
• ind_ids_covar(): IDs of individuals with covariate data
• ind_ids_gnp(): IDs of individuals with both genotype and phenotype data
• n_chr(): Number of chromosomes
• n_founders(): Number of founder strains
• founders(): Names of founder strains
• chr_names(): Chromosome names
• tot_mar(): Total number of markers
• n_mar(): Number of markers on each chromosome
• marker_names(): Marker names
• n_pheno(): Number of phenotypes
• pheno_names(): Phenotype names
• n_covar(): Number of covariates
• covar_names(): Covariate names
• n_phenocovar(): Number of phenotype covariates
• phenocovar_names(): Phenotype covariate names

8

See Also

summary.cross2()

batch_cols

batch_cols

Batch columns by pattern of missing values

Description

Identify batches of columns of a matrix that have the same pattern of missing values.

Usage

batch_cols(mat, max_batch = NULL)

Arguments

mat

A numeric matrix

max_batch

Maximum batch size

Value

A list containing the batches, each with two components: cols containing numeric indices of the
columns in the corresponding batch, and omit containing a vector of row indices that have missing
values in this batch.

See Also

batch_vec()

Examples

x <- rbind(c( 1, 2, 3, 13, 16),
c( 4, 5, 6, 14, 17),
c( 7, NA, 8, NA, 18),
c(NA, NA, NA, NA, 19),
c(10, 11, 12, 15, 20))

batch_cols(x)

batch_vec

9

batch_vec

Split vector into batches

Description

Split a vector into batches, each no longer than batch_size and creating at least n_cores batches,
for use in parallel calculations.

Usage

batch_vec(vec, batch_size = NULL, n_cores = 1)

Arguments

vec

batch_size

n_cores

Value

A vector to be split into batches

Maximum size for each batch

Number of compute cores, to be used as a minimum number of batches.

A list of vectors, each no longer than batch_size, and with at least n_cores componenets.

See Also

batch_cols()

Examples

vec_split <- batch_vec(1:304, 50, 8)
vec_split2 <- batch_vec(1:304, 50)

bayes_int

Calculate Bayes credible intervals

Description

Calculate Bayes credible intervals for a single LOD curve on a single chromosome, with the ability
to identify intervals for multiple LOD peaks.

bayes_int

10

Usage

bayes_int(

scan1_output,
map,
chr = NULL,
lodcolumn = 1,
threshold = 0,
peakdrop = Inf,
prob = 0.95,
expand2markers = TRUE

)

Arguments

scan1_output

map

chr

lodcolumn

threshold

peakdrop

An object of class "scan1" as returned by scan1().
A list of vectors of marker positions, as produced by insert_pseudomarkers().

Chromosome ID to consider (must be a single value).

LOD score column to consider (must be a single value).

Minimum LOD score for a peak.

Amount that the LOD score must drop between peaks, if multiple peaks are to
be defined on a chromosome.

prob

Nominal coverage for the interval.

expand2markers If TRUE, QTL intervals are expanded so that their endpoints are at genetic mark-

ers.

Details

We identify a set of peaks defined as local maxima that exceed the specified threshold, with the
requirement that the LOD score must have dropped by at least peakdrop below the lowest of any
two adjacent peaks.

At a given peak, if there are ties, with multiple positions jointly achieving the maximum LOD score,
we take the average of these positions as the location of the peak.
The default is to use threshold=0, peakdrop=Inf, and prob=0.95. We then return results a single
peak, no matter the maximum LOD score, and give a 95% Bayes credible interval.

Value

A matrix with three columns:

• ci_lo - lower bound of interval
• pos - peak position
• ci_hi - upper bound of interval

Each row corresponds to a different peak.

calc_entropy

See Also

lod_int(), find_peaks(), scan1()

Examples

11

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)
Xcovar <- get_x_covar(iron)

# perform genome scan
out <- scan1(probs, pheno, addcovar=covar, Xcovar=Xcovar)

# 95% Bayes credible interval for QTL on chr 7, first phenotype
bayes_int(out, map, chr=7, lodcolum=1)

calc_entropy

Calculate entropy of genotype probability distribution

Description

For each individual at each genomic position, calculate the entropy of the genotype probability
distribution, as a quantitative summary of the amount of missing information.

Usage

calc_entropy(probs, quiet = TRUE, cores = 1)

Arguments

probs

quiet

cores

Details

Genotype probabilities, as calculated from calc_genoprob().
IF FALSE, print progress messages.
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

We calculate -sum(p log_2 p), where we take 0 log 0 = 0.

12

Value

calc_errorlod

A list of matrices (each matrix is a chromosome and is arranged as individuals x markers).

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))

probs <- calc_genoprob(grav2, error_prob=0.002)
e <- calc_entropy(probs)
e <- do.call("cbind", e) # combine chromosomes into one big matrix

# summarize by individual
mean_ind <- rowMeans(e)

# summarize by marker
mean_marker <- colMeans(e)

calc_errorlod

Calculate genotyping error LOD scores

Description

Use the genotype probabilities calculated with calc_genoprob() to calculate genotyping error
LOD scores, to help identify potential genotyping errors (and problem markers and/or individuals).

Usage

calc_errorlod(cross, probs, quiet = TRUE, cores = 1)

Arguments

cross

probs

quiet

cores

Details

Object of class "cross2". For details, see the R/qtl2 developer guide.
Genotype probabilities as calculated from calc_genoprob().
If FALSE, print progress messages.
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

Let Ok denote the observed marker genotype at position k, and gk denote the corresponding true
underlying genotype.
Following Lincoln and Lander (1992), we calculate LOD = log10[P r(Ok|gk = Ok)/P r(Ok|gk ̸=
OK)]

Value

A list of matrices of genotyping error LOD scores. Each matrix corresponds to a chromosome and
is arranged as individuals x markers.

calc_genoprob

References

13

Lincoln SE, Lander ES (1992) Systematic detection of errors in genetic linkage data. Genomics
14:604–610.

See Also

calc_genoprob()

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
probs <- calc_genoprob(iron, error_prob=0.002, map_function="c-f")
errorlod <- calc_errorlod(iron, probs)

# combine into one matrix
errorlod <- do.call("cbind", errorlod)

calc_genoprob

Calculate conditional genotype probabilities

Description

Uses a hidden Markov model to calculate the probabilities of the true underlying genotypes given
the observed multipoint marker data, with possible allowance for genotyping errors.

Usage

calc_genoprob(

cross,
map = NULL,
error_prob = 0.0001,
map_function = c("haldane", "kosambi", "c-f", "morgan"),
lowmem = FALSE,
quiet = TRUE,
cores = 1

)

Arguments

cross

map

error_prob

map_function

Object of class "cross2". For details, see the R/qtl2 developer guide.

Genetic map of markers. May include pseudomarker locations (that is, locations
that are not within the marker genotype data).
If NULL, the genetic map in
cross is used.

Assumed genotyping error probability

Character string indicating the map function to use to convert genetic distances
to recombination fractions.

calc_genoprob

If FALSE, split individuals into groups with common sex and crossinfo and then
precalculate the transition matrices for a chromosome; potentially a lot faster
but using more memory.

If FALSE, print progress messages.

Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

14

lowmem

quiet

cores

Details

Let Ok denote the observed marker genotype at position k, and gk denote the corresponding true
underlying genotype.

We use the forward-backward equations to calculate αkv = log P r(O1, . . . , Ok, gk = v) and βkv =
log P r(Ok+1, . . . , On|gk = v)
We then obtain P r(gk|O1, . . . , On) = exp(αkv + βkv)/s where s = (cid:80)

v exp(αkv + βkv)

Value

An object of class "calc_genoprob": a list of three-dimensional arrays of probabilities, individuals
x genotypes x positions. (Note that the arrangement is different from R/qtl.) Also contains four
attributes:

• crosstype - The cross type of the input cross.

• is_x_chr - Logical vector indicating whether chromosomes are to be treated as the X chro-

mosome or not, from input cross.

• alleles - Vector of allele codes, from input cross.

• alleleprobs - Logical value (FALSE) that indicates whether the probabilities are compressed

to allele probabilities, as from genoprob_to_alleleprob().

See Also

insert_pseudomarkers()

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
gmap_w_pmar <- insert_pseudomarkers(grav2$gmap, step=1)
probs <- calc_genoprob(grav2, gmap_w_pmar, error_prob=0.002)

calc_geno_freq

15

calc_geno_freq

Calculate genotype frequencies

Description

Calculate genotype frequencies, by individual or by marker

Usage

calc_geno_freq(probs, by = c("individual", "marker"), omit_x = TRUE)

Arguments

probs

by

omit_x

Value

List of arrays of genotype probabilities, as calculated by calc_genoprob().

Whether to summarize by individual or marker

If TRUE, results are just for the autosomes. If FALSE, results are a list of length
two, containing the results for the autosomes and those for the X chromosome.

If omit_x=TRUE, the result is a matrix of genotype frequencies; columns are genotypes and rows
are either individuals or markers.
If necessary (that is, if omit_x=FALSE, the data include the X chromosome, and the set of genotypes
on the X chromosome are different than on the autosomes), the result is a list with two components
(for the autosomes and for the X chromosome), each being a matrix of genotype frequencies.

See Also

calc_raw_geno_freq(), calc_het()

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
p <- calc_genoprob(iron, err=0.002)

# genotype frequencies by marker
tab_g <- calc_geno_freq(p, "marker")

# allele frequencies by marker
ap <- genoprob_to_alleleprob(p)
tab_a <- calc_geno_freq(ap, "marker")

16

calc_grid

Description

calc_grid

Calculate indicators of which marker/pseudomarker positions are
along a fixed grid

Construct vectors of logical indicators that indicate which positions correspond to locations along a
grid

Usage

calc_grid(map, step = 0, off_end = 0, tol = 0.01)

Arguments

map

step

off_end

tol

Details

A list of numeric vectors; each vector gives marker positions for a single chro-
mosome.
Distance between pseudomarkers and markers; if step=0 no pseudomarkers are
inserted.

Distance beyond terminal markers in which to insert pseudomarkers.

Tolerance for determining whether a pseudomarker would duplicate a marker
position.

The function insert_pseudomarkers(), with stepwidth="fixed", will insert a grid of pseudo-
markers, to a marker map. The present function gives a series of TRUE/FALSE vectors that indicate
which positions fall on the grid. This is for use with probs_to_grid(), for reducing genotype prob-
abilities, calculated with calc_genoprob(), to just the positions on the grid. The main value of this
is to speed up genome scan computations in the case of very dense markers, by focusing on just a
grid of positions rather than on all marker locations.

Value

A list of logical (TRUE/FALSE) vectors that indicate, for a marker/pseudomarker map created by
insert_pseudomarkers() with step>0 and stepwidth="fixed", which positions correspond to
he locations along the fixed grid.

See Also

insert_pseudomarkers(), probs_to_grid(), map_to_grid()

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
gmap_w_pmar <- insert_pseudomarkers(iron$gmap, step=1)
grid <- calc_grid(iron$gmap, step=1)

calc_het

17

calc_het

Calculate heterozygosities

Description

Calculate heterozygosites, by individual or by marker

Usage

calc_het(probs, by = c("individual", "marker"), omit_x = TRUE, cores = 1)

Arguments

probs

by

omit_x

cores

Details

List of arrays of genotype probabilities, as calculated by calc_genoprob().

Whether to summarize by individual or marker

If TRUE, omit the X chromosome.
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

calc_het() looks at the genotype names (the 2nd dimension of the dimnames of the input probs),
which must be two-letter names, and assumes that when the two letters are different it’s a heterozy-
gous genotype while if they’re the same it’s a homozygous genotype

Value

The result is a vector of estimated heterozygosities

See Also

calc_raw_het(), calc_geno_freq()

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
p <- calc_genoprob(iron, err=0.002)

# heterozygosities by individual
het_ind <- calc_het(p)

# heterozygosities by marker
het_mar <- calc_het(p, "marker")

18

calc_kinship

calc_kinship

Calculate kinship matrix

Description

Calculate genetic similarity among individuals (kinship matrix) from conditional genotype proba-
bilities.

Usage

calc_kinship(

probs,
type = c("overall", "loco", "chr"),
omit_x = FALSE,
use_allele_probs = TRUE,
quiet = TRUE,
cores = 1

)

Arguments

probs

type

omit_x
use_allele_probs

Genotype probabilities, as calculated from calc_genoprob().
Indicates whether to calculate the overall kinship ("overall", using all chro-
mosomes), the kinship matrix leaving out one chromosome at a time ("loco"),
or the kinship matrix for each chromosome ("chr").
If TRUE, only use the autosomes; ignored when type="chr".

If TRUE, assess similarity with allele probabilities (that is, first run genoprob_to_alleleprob());
otherwise use the genotype probabilities.
IF FALSE, print progress messages.
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

quiet

cores

Details

If use_allele_probs=TRUE (the default), we first convert the genotype probabilities to allele prob-
abilities (using genoprob_to_alleleprob()).
We then calculate (cid:80)
For crosses with just two possible genotypes (e.g., backcross), we don’t convert to allele probabili-
ties but just use the original genotype probabilities.

kl(piklpjkl) where k = position, l = allele, and i, j are two individuals.

Value

If type="overall" (the default), a matrix of proportion of matching alleles. Otherwise a list with
one matrix per chromosome.

calc_raw_founder_maf

Examples

19

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
map <- insert_pseudomarkers(grav2$gmap, step=1)
probs <- calc_genoprob(grav2, map, error_prob=0.002)
K <- calc_kinship(probs)

# using only markers/pseudomarkers on the grid
grid <- calc_grid(grav2$gmap, step=1)
probs_sub <- probs_to_grid(probs, grid)
K_grid <- calc_kinship(probs_sub)

calc_raw_founder_maf

Calculate founder minor allele frequencies from raw SNP genotypes

Description

Calculate minor allele frequency from raw SNP genotypes in founders, by founder strain or by
marker

Usage

calc_raw_founder_maf(cross, by = c("individual", "marker"))

Arguments

cross

by

Value

Object of class "cross2". For details, see the R/qtl2 developer guide.
Indicates whether to summarize by founder strain ("individual") or by marker.

A vector of minor allele frequencies, one for each founder strain or marker.

See Also

recode_snps(), calc_raw_maf()

Examples

## Not run:
# load example data and calculate genotype probabilities
file <- paste0("https://raw.githubusercontent.com/rqtl/",

"qtl2data/main/DOex/DOex.zip")

DOex <- read_cross2(file)
DOex_maf <- calc_raw_founder_maf(DOex)

## End(Not run)

20

calc_raw_geno_freq

calc_raw_geno_freq

Calculate genotype frequencies from raw SNP genotypes

Description

Calculate genotype frequencies from raw SNP genotypes, by individual or by marker

Usage

calc_raw_geno_freq(cross, by = c("individual", "marker"), cores = 1)

Arguments

cross

by

cores

Value

Object of class "cross2". For details, see the R/qtl2 developer guide.

Indicates whether to summarize by individual or by marker.

Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

A matrix of genotypes frequencies with 3 columns (AA, AB, and BB) and with rows being either
individuals or markers.

See Also

calc_raw_maf(), calc_raw_het(), recode_snps(), calc_geno_freq()

Examples

## Not run:
# load example data and calculate genotype probabilities
file <- paste0("https://raw.githubusercontent.com/rqtl/",

"qtl2data/main/DOex/DOex.zip")

DOex <- read_cross2(file)
gfreq <- calc_raw_geno_freq(DOex)

## End(Not run)

calc_raw_het

21

calc_raw_het

Calculate estimated heterozygosity from raw SNP genotypes

Description

Calculate estimated heterozygosity for each individual from raw SNP genotypes

Usage

calc_raw_het(cross, by = c("individual", "marker"))

Arguments

cross

by

Value

Object of class "cross2". For details, see the R/qtl2 developer guide.
Indicates whether to summarize by founder strain ("individual") or by marker.

A vector of heterozygosities, one for each individual or marker.

See Also

recode_snps(), calc_raw_maf(), calc_raw_founder_maf(), calc_raw_geno_freq(), calc_het()

Examples

## Not run:
# load example data and calculate genotype probabilities
file <- paste0("https://raw.githubusercontent.com/rqtl/",

"qtl2data/main/DOex/DOex.zip")

DOex <- read_cross2(file)
DOex_het <- calc_raw_het(DOex)

## End(Not run)

calc_raw_maf

Calculate minor allele frequency from raw SNP genotypes

Description

Calculate minor allele frequency from raw SNP genotypes, by individual or by marker

Usage

calc_raw_maf(cross, by = c("individual", "marker"))

22

Arguments

cross

by

Value

calc_sdp

Object of class "cross2". For details, see the R/qtl2 developer guide.
Indicates whether to summarize by founder strain ("individual") or by marker.

A vector of minor allele frequencies, one for each individual or marker.

See Also

recode_snps(), calc_raw_founder_maf(), calc_raw_het(), calc_raw_geno_freq()

Examples

## Not run:
# load example data and calculate genotype probabilities
file <- paste0("https://raw.githubusercontent.com/rqtl/",

"qtl2data/main/DOex/DOex.zip")

DOex <- read_cross2(file)
DOex_maf <- calc_raw_maf(DOex)

## End(Not run)

calc_sdp

Calculate strain distribution pattern from SNP genotypes

Description

Calculate the strain distribution patterns (SDPs) from the strain genotypes at a set of SNPs.

Usage

calc_sdp(geno)

Arguments

geno

Value

Matrix of SNP genotypes, markers x strains, coded as 1 (AA) and 3 (BB). Mark-
ers with values other than 1 or 3 are omitted, and monomorphic markers, are
omitted.

A vector of strain distribution patterns: integers between 1 and 2n − 2 where n is the number of
strains, whose binary representation indicates the strain genotypes.

See Also

invert_sdp(), sdp2char()

cbind.calc_genoprob

Examples

x <- rbind(m1=c(3, 1, 1, 1, 1, 1, 1, 1),
m2=c(1, 3, 3, 1, 1, 1, 1, 1),
m3=c(1, 1, 1, 1, 3, 3, 3, 3))

calc_sdp(x)

23

cbind.calc_genoprob

Join genotype probabilities for different chromosomes

Description

Join multiple genotype probability objects, as produced by calc_genoprob(), for the same set of
individuals but different chromosomes.

Usage

## S3 method for class 'calc_genoprob'
cbind(...)

Arguments

...

Value

Genotype probability objects as produced by calc_genoprob(). Must have the
same set of individuals.

An object of class "calc_genoprob", like the input; see calc_genoprob().

See Also

rbind.calc_genoprob()

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
map <- insert_pseudomarkers(grav2$gmap, step=1)
probsA <- calc_genoprob(grav2[1:5,1:2], map, error_prob=0.002)
probsB <- calc_genoprob(grav2[1:5,3:4], map, error_prob=0.002)
probs <- cbind(probsA, probsB)

24

cbind.scan1

cbind.scan1

Join genome scan results for different phenotypes.

Description

Join multiple scan1() results for different phenotypes; must have the same map.

Usage

## S3 method for class 'scan1'
cbind(...)

Arguments

...

Details

Genome scan objects of class "scan1", as produced by scan1(). Must have the
same map.

If components addcovar(), Xcovar, intcovar, weights do not match between objects, we omit
this information.
If hsq present but has differing numbers of rows, we omit this information.

Value

An object of class ‘"scan1", like the inputs, but with the lod score columns from the inputs combined
as multiple columns in a single object.

See Also

rbind.scan1(), scan1()

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
map <- insert_pseudomarkers(grav2$gmap, step=1)
probs <- calc_genoprob(grav2, map, error_prob=0.002)
phe1 <- grav2$pheno[,1,drop=FALSE]
phe2 <- grav2$pheno[,2,drop=FALSE]

out1 <- scan1(probs, phe1) # phenotype 1
out2 <- scan1(probs, phe2) # phenotype 2
out <- cbind(out1, out2)

cbind.scan1perm

25

cbind.scan1perm

Combine columns from multiple scan1 permutation results

Description

Column-bind multiple scan1perm objects with the same numbers of rows.

Usage

## S3 method for class 'scan1perm'
cbind(...)

Arguments

...

Details

A set of permutation results from scan1perm() (objects of class "scan1perm".
If different numbers of permutation replicates were used, those columns with
fewer replicates are padded with missing values NA. However, if any include
autosome/X chromosome-specific permutations, they must all be such.

The aim of this function is to concatenate the results from multiple runs of a permutation test
with scan1perm(), generally with different phenotypes and/or methods, to be used in parallel with
rbind.scan1perm().

Value

The combined column-binded input, as an object of class "scan1perm"; see scan1perm().

See Also

rbind.scan1perm(), scan1perm(), scan1()

Examples

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)

26

cbind.sim_geno

Xcovar <- get_x_covar(iron)

# permutations with genome scan (just 3 replicates, for illustration)
operm1 <- scan1perm(probs, pheno[,1,drop=FALSE], addcovar=covar, Xcovar=Xcovar, n_perm=3)
operm2 <- scan1perm(probs, pheno[,2,drop=FALSE], addcovar=covar, Xcovar=Xcovar, n_perm=3)

operm <- cbind(operm1, operm2)

cbind.sim_geno

Join genotype imputations for different chromosomes

Description

Join multiple genotype imputation objects, as produced by sim_geno(), for the same individuals
but different chromosomes.

Usage

## S3 method for class 'sim_geno'
cbind(...)

Arguments

...

Value

Genotype imputation objects as produced by sim_geno(). Must have the same
set of individuals.

An object of class "sim_geno", like the input; see sim_geno().

See Also

rbind.sim_geno(), sim_geno()

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
map <- insert_pseudomarkers(grav2$gmap, step=1)
drawsA <- sim_geno(grav2[1:5,1:2], map, error_prob=0.002, n_draws=4)
drawsB <- sim_geno(grav2[1:5,3:4], map, error_prob=0.002, n_draws=4)
draws <- cbind(drawsA, drawsB)

cbind.viterbi

27

cbind.viterbi

Join viterbi results for different chromosomes

Description

Join multiple viterbi objects, as produced by viterbi(), for the same set of individuals but different
chromosomes.

Usage

## S3 method for class 'viterbi'
cbind(...)

Arguments

...

Value

Imputed genotype objects as produced by viterbi(). Must have the same set
of individuals.

An object of class "viterbi", like the input; see viterbi().

See Also

rbind.viterbi(), viterbi()

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
map <- insert_pseudomarkers(grav2$gmap, step=1)
gA <- viterbi(grav2[1:5,1:2], map, error_prob=0.002)
gB <- viterbi(grav2[1:5,3:4], map, error_prob=0.002)
g <- cbind(gA, gB)

cbind_expand

Combine matrices by columns, expanding and aligning rows

Description

This is like base::cbind() but using row names to align the rows and expanding with missing
values if there are rows in some matrices but not others.

Usage

cbind_expand(...)

28

Arguments

...

Value

A set of matrices or data frames

CCcolors

The matrices combined by columns, using row names to align the rows, and expanding with missing
values if there are rows in some matrices but not others.

Examples

df1 <- data.frame(x=c(1,2,3,NA,4), y=c(5,8,9,10,11), row.names=c("A", "B", "C", "D", "E"))
df2 <- data.frame(w=c(7,8,0,9,10), z=c(6,NA,NA,9,10), row.names=c("A", "B", "F", "C", "D"))
cbind_expand(df1, df2)

CCcolors

Collaborative Cross colors

Description

A vector of 8 colors for use with the mouse Collaborative Cross and Diversity Outbreds.

Details

CCorigcolors are the original eight colors for the Collaborative Cross founder strains. CCaltcolors
are a slightly modified version, but still not color-blind friendly. CCcolors are derived from the the
Okabe-Ito color blind friendly palette in Wong (2011) Nature Methods doi:10.1038/nmeth.1618.

Source

https://web.archive.org/web/20250215070655/https://csbio.unc.edu/CCstatus/index.
py?run=AvailableLines.information

Examples

data(CCcolors)
data(CCaltcolors)
data(CCorigcolors)

check_cross2

29

check_cross2

Check a cross2 object

Description

Check the integrity of the data within a cross2 object.

Usage

check_cross2(cross2)

Arguments

cross2

Details

An object of class "cross2", as output by read_cross2(). For details, see the
R/qtl2 developer guide.

Checks whether a cross2 object meets the specifications. Problems are issued as warnings.

Value

If everything is correct, returns TRUE; otherwise FALSE, with attributes that give the problems.

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
check_cross2(grav2)

chisq_colpairs

Chi-square test on all pairs of columns

Description

Perform a chi-square test for independence for all pairs of columns of a matrix.

Usage

chisq_colpairs(x)

Arguments

x

A matrix of positive integers. NAs and values <= 0 are treated as missing.

30

Value

chr_lengths

A matrix of size p x p, where p is the number of columns in the input matrix x, containing the
chi-square test statistics for independence, applied to pairs of columns of x. The diagonal of the
result will be all NAs.

Examples

z <- matrix(sample(1:2, 500, replace=TRUE), ncol=5)
chisq_colpairs(z)

chr_lengths

Calculate chromosome lengths

Description

Calculate chromosome lengths for a map object

Usage

chr_lengths(map, collapse_to_AX = FALSE)

Arguments

map

A list of vectors, each specifying locations of the markers.
collapse_to_AX If TRUE, collapse to the total lengths of the autosomes and X chromosome.

Details

We take diff(range(v)) for each vector, v.

Value

A vector of chromosome lengths.
(autosomal and X chromosome lengths).

If collapse_to_AX=TRUE, the result is a vector of length 2

See Also

scan1perm()

clean

31

clean

Clean an object

Description

Clean an object by removing messy values

Usage

clean(object, ...)

Arguments

object

...

Value

Object to be cleaned

Other arguments

Input object with messy values cleaned up

See Also

clean.scan1(), clean.calc_genoprob()

clean_genoprob

Clean genotype probabilities

Description

Clean up genotype probabilities by setting small values to 0 and for a genotype column where the
maximum value is rather small, set all values in that column to 0.

Usage

clean_genoprob(

object,
value_threshold = 0.000001,
column_threshold = 0.01,
ind = NULL,
cores = 1,
...

)

## S3 method for class 'calc_genoprob'
clean(

32

clean_genoprob

object,
value_threshold = 0.000001,
column_threshold = 0.01,
ind = NULL,
cores = 1,
...

)

Arguments

object

Genotype probabilities as calculated by calc_genoprob().

value_threshold

column_threshold

Probabilities below this value will be set to 0.

For genotype columns where the maximum value is below this threshold, all
values will be set to 0. This must be less than 1/k where k is the number of
genotypes.

Optional vector of individuals (logical, numeric, or character). If provided, only
the genotype probabilities for these individuals will be cleaned, though the full
set will be returned.

Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

Ignored at this point.

ind

cores

...

Details

In cases where a particular genotype is largely absent, scan1coef() and fit1() can give unstable
estimates of the genotype effects. Cleaning up the genotype probabilities by setting small values to
0 helps to ensure that such effects get set to NA.

At each position and for each genotype column, we find the maximum probability across individu-
als. If that maximum is < column_threshold, all values in that genotype column at that position
are set to 0.

In addition, any genotype probabilities that are < value_threshold (generally < column_threshold)
are set to 0.

The probabilities are then re-scaled so that the probabilities for each individual at each position sum
to 1.

If ind is provided, the function is applied only to the designated subset of individuals. This may
be useful when only a subset of individuals have been phenotyped, as you may want to zero out
genotype columns where that subset of individuals has only negligible probability values.

Value

A cleaned version of the input genotype probabilities object, object.

clean_scan1

Examples

33

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# calculate genotype probabilities
probs <- calc_genoprob(iron, error_prob=0.002)

# clean the genotype probabilities
# (doesn't really do anything in this case, because there are no small but non-zero values)
probs_clean <- clean(probs)

# clean only the females' genotype probabilities
probs_cleanf <- clean(probs, ind=names(iron$is_female)[iron$is_female])

clean_scan1

Clean scan1 output

Description

Clean scan1 output by replacing negative values with NA and remove rows where all values are
NA.

Usage

clean_scan1(object, ...)

## S3 method for class 'scan1'
clean(object, ...)

Arguments

object

...

Value

Output of scan1().

Ignored at present

The input object with negative values replaced with NAs and then rows with all NAs removed.

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

pr <- calc_genoprob(iron)
out <- scan1(pr, iron$pheno)

out <- clean(out)

34

compare_founder_geno

compare_founder_geno

Compare founders genotype data

Description

Count the number of matching genotypes between all pairs of founder lines.

Usage

compare_founder_geno(

cross,
omit_x = FALSE,
proportion = TRUE,
quiet = TRUE,
cores = 1

)

Arguments

cross

omit_x

proportion

quiet

cores

Value

Object of class "cross2". For details, see the R/qtl2 developer guide.

If TRUE, only use autosomal genotypes

If TRUE (the default), the upper triangle of the result contains the proportions of
matching genotypes. If FALSE, the upper triangle contains counts of matching
genotypes.
IF FALSE, print progress messages.
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

A square matrix; diagonal is number of observed genotypes for each founder line. The values in the
lower triangle are the numbers of markers where both of a pair were genotyped. The values in the
upper triangle are either proportions or counts of matching genotypes for each pair (depending on
whether proportion=TRUE or =FALSE). The object is given class "compare_geno".

Examples

## Not run:
file <- paste0("https://raw.githubusercontent.com/rqtl/",

"qtl2data/main/DOex/DOex.zip")

DOex <- read_cross2(file)
cg <- compare_founder_geno(DOex)
summary(cg)

## End(Not run)

compare_geno

35

compare_geno

Compare individuals’ genotype data

Description

Count the number of matching genotypes between all pairs of individuals, to look for unusually
closely related individuals.

Usage

compare_geno(cross, omit_x = FALSE, proportion = TRUE, quiet = TRUE, cores = 1)

Arguments

cross

omit_x

proportion

quiet

cores

Value

Object of class "cross2". For details, see the R/qtl2 developer guide.

If TRUE, only use autosomal genotypes

If TRUE (the default), the upper triangle of the result contains the proportions of
matching genotypes. If FALSE, the upper triangle contains counts of matching
genotypes.

IF FALSE, print progress messages.

Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

A square matrix; diagonal is number of observed genotypes for each individual. The values in the
lower triangle are the numbers of markers where both of a pair were genotyped. The values in the
upper triangle are either proportions or counts of matching genotypes for each pair (depending on
whether proportion=TRUE or =FALSE). The object is given class "compare_geno".

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
cg <- compare_geno(grav2)
summary(cg)

36

compare_genoprob

compare_genoprob

Compare two sets of genotype probabilities

Description

Compare two sets of genotype probabilities for one individual on a single chromosome.

Usage

compare_genoprob(

probs1,
probs2,
cross,
ind = 1,
chr = NULL,
minprob = 0.95,
minmarkers = 10,
minwidth = 0,
annotate = FALSE

)

Arguments

probs1

probs2

cross

ind

chr

minprob

minmarkers

minwidth

annotate

Genotype probabilities (as produced by calc_genoprob()) or allele dosages (as
produced by genoprob_to_alleleprob()).
A second set of genotype probabilities, just like probs1.
Object of class "cross2". For details, see the R/qtl2 developer guide.
Individual to plot, either a numeric index or an ID.

Selected chromosome; a single character string.
Minimum probability for inferring genotypes (passed to maxmarg()).
Minimum number of markers in results.

Minimum width in results.
If TRUE, add some annotations to the geno1 and geno2 columns to indicate,
where they differ, which one matches what appears to be the best genotype. (*
= matches the best genotype; - = lower match).

Details

The function does the following:

• Reduce the probabilities to a set of common locations that also appear in cross.
• Use maxmarg() to infer the genotype at every position using each set of probabilities.
• Identify intervals where the two inferred genotypes are constant.

• Within each segment, compare the observed SNP genotypes to the founders’ genotypes.

compare_maps

Value

37

A data frame with each row corresponding to an interval over which probs1 and probs2 each have
a fixed inferred genotype. Columns include the two inferred genotypes, the start and end points and
width of the interval, and when founder genotypes are in cross, the proportions of SNPs where the
individual matches each possible genotypes.

See Also

plot_genoprobcomp()

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
iron <- iron[1,"2"]
map <- insert_pseudomarkers(iron$gmap, step=1)

# subset to first individual on chr 2

# in presence of a genotyping error, how much does error_prob matter?
iron$geno[[1]][1,3] <- 3
pr_e <- calc_genoprob(iron, map, error_prob=0.002)
pr_ne <- calc_genoprob(iron, map, error_prob=1e-15)

compare_genoprob(pr_e, pr_ne, iron, minmarkers=1, minprob=0.5)

compare_maps

Compare two marker maps

Description

Compare two marker maps, identifying markers that are only in one of the two maps, or that are in
different orders on the two maps.

Usage

compare_maps(map1, map2)

Arguments

map1

map2

A list of numeric vectors; each vector gives marker positions for a single chro-
mosome.

A second map, in the same format as map1.

convert2cross2

38

Value

A data frame containing

• marker - marker name
• chr_map1 - chromosome ID on map1
• pos_map1 - position on map1
• chr_map2 - chromosome ID on map2
• pos_map2 - position on map2

Examples

# load some data
iron <- read_cross2( system.file("extdata", "iron.zip", package="qtl2") )
gmap <- iron$gmap
pmap <- iron$pmap

# omit a marker from each map
gmap[[7]] <- gmap[[7]][-3]
pmap[[8]] <- pmap[[8]][-7]
# swap order of a couple of markers on the physical map
names(pmap[[9]])[3:4] <- names(pmap[[9]])[4:3]
# move a marker to a different chromosome
pmap[[10]] <- c(pmap[[10]], pmap[[1]][2])[c(1,3,2)]
pmap[[1]] <- pmap[[1]][-2]

# compare these messed-up maps
compare_maps(gmap, pmap)

convert2cross2

Convert R/qtl cross object to new format

Description

Convert a cross object from the R/qtl format to the R/qtl2 format

Usage

convert2cross2(cross)

Arguments

cross

Value

An object of class "cross"; see qtl::read.cross() for details.

Object of class "cross2". For details, see the R/qtl2 developer guide.

count_xo

See Also

read_cross2()

Examples

library(qtl)
data(hyper)
hyper2 <- convert2cross2(hyper)

39

count_xo

Count numbers of crossovers

Description

Estimate the numbers of crossovers in each individual on each chromosome.

Usage

count_xo(geno, quiet = TRUE, cores = 1)

Arguments

geno

quiet

cores

Value

List of matrices of genotypes (output of maxmarg() or viterbi()) or a list of
3d-arrays of genotypes (output of sim_geno()).
If FALSE, print progress messages.
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

A matrix of crossover counts, individuals x chromosomes, or (if the input was the output of sim_geno())
a 3d-array of crossover counts, individuals x chromosomes x imputations.

See Also

locate_xo()

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

map <- insert_pseudomarkers(iron$gmap, step=1)
pr <- calc_genoprob(iron, map, error_prob=0.002, map_function="c-f")
g <- maxmarg(pr)
n_xo <- count_xo(g)

# imputations
imp <- sim_geno(iron, map, error_prob=0.002, map_function="c-f", n_draws=32)

40

create_gene_query_func

n_xo_imp <- count_xo(imp)
# sums across chromosomes
tot_xo_imp <- apply(n_xo_imp, c(1,3), sum)
# mean and SD across imputations
summary_xo <- cbind(mean=rowMeans(tot_xo_imp),

sd=apply(tot_xo_imp, 1, sd))

create_gene_query_func

Create a function to query genes

Description

Create a function that will connect to a SQLite database of gene information and return a data frame
with gene information for a selected region.

Usage

create_gene_query_func(

dbfile = NULL,
db = NULL,
table_name = "genes",
chr_field = "chr",
start_field = "start",
stop_field = "stop",
name_field = "Name",
strand_field = "strand",
filter = NULL

)

Arguments

dbfile

db

Name of database file
Optional database connection (provide one of file and db).

table_name

chr_field

start_field

stop_field

name_field

Name of table in the database

Name of chromosome field

Name of field with start position (in basepairs)

Name of field with stop position (in basepairs)

Name of field with gene name

strand_field

Name of field with strand (+/-)

filter

Additional SQL filter (as a character string).

create_snpinfo

Details

41

Note that this function assumes that the database has start and stop fields that are in basepairs,
but the selection uses positions in Mbp, and the output data frame should have start and stop
columns in Mbp.

Also note that a SQLite database of MGI mouse genes is available at figshare: doi:10.6084/m9.figshare.5286019.v7

Value

Function with three arguments, chr, start, and end, which returns a data frame with the genes
overlapping that region, with start and end being in Mbp. The output should contain at least the
columns Name, chr, start, and stop, the latter two being positions in Mbp.

Examples

# create query function by connecting to file
dbfile <- system.file("extdata", "mouse_genes_small.sqlite", package="qtl2")
query_genes <- create_gene_query_func(dbfile, filter="(source=='MGI')")
# query_genes will connect and disconnect each time
genes <- query_genes("2", 97.0, 98.0)

# connect and disconnect separately
library(RSQLite)
db <- dbConnect(SQLite(), dbfile)
query_genes <- create_gene_query_func(db=db, filter="(source=='MGI')")
genes <- query_genes("2", 97.0, 98.0)
dbDisconnect(db)

create_snpinfo

Create snp information table for a cross

Description

Create a table of snp information from a cross, for use with scan1snps().

Usage

create_snpinfo(cross)

Arguments

cross

Object of class "cross2". For details, see the R/qtl2 developer guide.

42

Value

create_variant_query_func

A data frame of SNP information with the following columns:

• chr - Character string or factor with chromosome
• pos - Position (in same units as in the "map" attribute in genoprobs.
• snp - Character string with SNP identifier (if missing, the rownames are used).
• sdp - Strain distribution pattern: an integer, between 1 and 2n − 2 where n is the number of
strains, whose binary encoding indicates the founder genotypes SNPs with missing founder
genotypes are omitted.

See Also

index_snps(), scan1snps(), genoprob_to_snpprob()

Examples

## Not run:
# load example data and calculate genotype probabilities
file <- paste0("https://raw.githubusercontent.com/rqtl/",

"qtl2data/main/DO_Recla/recla.zip")

recla <- read_cross2(file)
snpinfo <- create_snpinfo(recla)

# calculate genotype probabilities
pr <- calc_genoprob(recla, error_prob=0.002, map_function="c-f")

# index the snp information
snpinfo <- index_snps(recla$pmap, snpinfo)

# sex covariate
sex <- setNames((recla$covar$Sex=="female")*1, rownames(recla$covar))

# perform a SNP scan
out <- scan1snps(pr, recla$pmap, recla$pheno[,"bw"], addcovar=sex, snpinfo=snpinfo)

# plot the LOD scores
plot(out$lod, snpinfo, altcol="green3")

## End(Not run)

create_variant_query_func

Create a function to query variants

Description

Create a function that will connect to a SQLite database of founder variant information and return
a data frame with variants for a selected region.

43

create_variant_query_func

Usage

create_variant_query_func(

dbfile = NULL,
db = NULL,
table_name = "variants",
chr_field = "chr",
pos_field = "pos",
id_field = "snp_id",
sdp_field = "sdp",
filter = NULL

)

Arguments

dbfile

db

table_name

chr_field

pos_field

id_field

sdp_field

filter

Details

Name of database file
Optional database connection (provide one of file and db).

Name of table in the database

Name of chromosome field

Name of position field

Name of SNP/variant ID field

Name of strain distribution pattern (SDP) field

Additional SQL filter (as a character string)

Note that this function assumes that the database has a pos field that is in basepairs, but the selection
uses start and end positions in Mbp, and the output data frame should have pos in Mbp.

Also note that a SQLite database of variants in the founder strains of the mouse Collaborative Cross
is available at figshare: doi:10.6084/m9.figshare.5280229.v3

Value

Function with three arguments, chr, start, and end, which returns a data frame with the variants
in that region, with start and end being in Mbp. The output should contain at least the columns
chr and pos, the latter being position in Mbp.

Examples

# create query function by connecting to file
dbfile <- system.file("extdata", "cc_variants_small.sqlite", package="qtl2")
query_variants <- create_variant_query_func(dbfile)
# query_variants will connect and disconnect each time
variants <- query_variants("2", 97.0, 98.0)

# create query function to just grab SNPs
query_snps <- create_variant_query_func(dbfile, filter="type=='snp'")
# query_variants will connect and disconnect each time

44

decomp_kinship

snps <- query_snps("2", 97.0, 98.0)

# connect and disconnect separately
library(RSQLite)
db <- dbConnect(SQLite(), dbfile)
query_variants <- create_variant_query_func(db=db)
variants <- query_variants("2", 97.0, 98.0)
dbDisconnect(db)

decomp_kinship

Calculate eigen decomposition of kinship matrix

Description

Calculate the eigen decomposition of a kinship matrix, or of a list of such matrices.

Usage

decomp_kinship(kinship, cores = 1)

Arguments

kinship

cores

Details

A square matrix, or a list of square matrices.
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

The result contains an attribute "eigen_decomp".

Value

The eigen values and the transposed eigen vectors, as a list containing a vector values and a matrix
vectors.

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

map <- insert_pseudomarkers(iron$gmap, step=1)
probs <- calc_genoprob(iron, map, error_prob=0.002)
K <- calc_kinship(probs)

Ke <- decomp_kinship(K)

drop_markers

45

drop_markers

Drop markers from a cross2 object

Description

Drop a vector of markers from a cross2 object.

Usage

drop_markers(cross, markers)

Arguments

cross

markers

Value

Object of class "cross2". For details, see the R/qtl2 developer guide.

A vector of marker names.

The input cross with the specified markers removed.

See Also

pull_markers(), drop_nullmarkers(), reduce_markers(), find_dup_markers()

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
markers2drop <- c("BH.342C/347L-Col", "GH.94L", "EG.357C/359L-Col", "CD.245L", "ANL2")
grav2_rev <- drop_markers(grav2, markers2drop)

drop_nullmarkers

Drop markers with no genotype data

Description

Drop markers with no genotype data (or no informative genotypes)

Usage

drop_nullmarkers(cross, quiet = FALSE)

Arguments

cross

quiet

Object of class "cross2". For details, see the R/qtl2 developer guide.

If FALSE, print information about how many markers were dropped.

46

Details

est_herit

We omit any markers that have completely missing data, or if founder genotypes are present (e.g.,
for Diversity Outbreds), the founder genotypes are missing or are all the same.

Value

The input cross with the uninformative markers removed.

See Also

drop_markers(), pull_markers()

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
# make a couple of markers missing
grav2$geno[[2]][,c(3,25)] <- 0
grav2_rev <- drop_nullmarkers(grav2)

est_herit

Estimate heritability with a linear mixed model

Description

Estimate the heritability of a set of traits via a linear mixed model, with possible allowance for
covariates.

Usage

est_herit(
pheno,
kinship,
addcovar = NULL,
weights = NULL,
reml = TRUE,
cores = 1,
...

)

Arguments

pheno

kinship

addcovar

weights

A numeric matrix of phenotypes, individuals x phenotypes.

A kinship matrix.

An optional numeric matrix of additive covariates.

An optional numeric vector of positive weights for the individuals. As with the
other inputs, it must have names for individual identifiers.

est_herit

reml

cores

...

Details

If true, use REML; otherwise, use maximimum likelihood.
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

Additional control parameters (see details).

47

We fit the model y = Xβ + ϵ where ϵ is multivariate normal with mean 0 and covariance matrix
σ2[h2(2K) + I] where K is the kinship matrix and I is the identity matrix.
If weights are provided, the covariance matrix becomes σ2[h2(2K) + D] where D is a diagonal
matrix with the reciprocal of the weights.

For each of the inputs, the row names are used as individual identifiers, to align individuals.
If reml=TRUE, restricted maximum likelihood (reml) is used to estimate the heritability, separately
for each phenotype.
Additional control parameters include tol for the tolerance for convergence, quiet for controlling
whether messages will be display, max_batch for the maximum number of phenotypes in a batch,
and check_boundary for whether the 0 and 1 boundary values for the estimated heritability will be
checked explicitly.

Value

A vector of estimated heritabilities, corresponding to the columns in pheno. The result has attributes
"sample_size", "log10lik" and "resid_sd".

Examples

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# kinship matrix
kinship <- calc_kinship(probs)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)

# perform genome scan
hsq <- est_herit(pheno, kinship, covar)

48

est_map

est_map

Estimate genetic maps

Description

Uses a hidden Markov model to re-estimate the genetic map for an experimental cross, with possible
allowance for genotyping errors.

Usage

est_map(
cross,
error_prob = 0.0001,
map_function = c("haldane", "kosambi", "c-f", "morgan"),
lowmem = FALSE,
maxit = 10000,
tol = 0.000001,
quiet = TRUE,
save_rf = FALSE,
cores = 1

)

Arguments

cross

error_prob

map_function

lowmem

maxit

tol

quiet

save_rf

cores

Details

Object of class "cross2". For details, see the R/qtl2 developer guide.
Assumed genotyping error probability

Character string indicating the map function to use to convert genetic distances
to recombination fractions.
If FALSE, precalculate initial and emission probabilities, and at each iteration
calculate the transition matrices for a chromosome; potentially a lot faster but
using more memory. Needs to be tailored somewhat to cross type. For exam-
ple, multi-way RIL may need to reorder the transition matrix according to cross
order, and AIL and DO need separate transition matrices for each generation.

Maximum number of iterations in EM algorithm.

Tolerance for determining convergence
If FALSE, print progress messages.
If TRUE, save the estimated recombination fractions as an attribute ("rf") of the
result.
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

The map is estimated assuming no crossover interference, but a map function (by default, Haldane’s)
is used to derive the genetic distances.

find_dup_markers

Value

49

A list of numeric vectors, with the estimated marker locations (in cM). The location of the initial
marker on each chromosome is kept the same as in the input cross.

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))

gmap <- est_map(grav2, error_prob=0.002)

find_dup_markers

Find markers with identical genotype data

Description

Identify sets of markers with identical genotype data.

Usage

find_dup_markers(cross, chr, exact_only = TRUE, adjacent_only = FALSE)

Arguments

cross

chr

exact_only

Object of class "cross2". For details, see the R/qtl2 developer guide.

Optional vector specifying which chromosomes to consider. This may be a log-
ical, numeric, or character string vector.

If TRUE, look only for markers that have matching genotypes and the same pat-
tern of missing data; if FALSE, also look for cases where the observed genotypes
at one marker match those at another, and where the first marker has missing
genotype whenever the genotype for the second marker is missing.

adjacent_only

If TRUE, look only for sets of markers that are adjacent to each other.

Details

If exact.only=TRUE, we look only for groups of markers whose pattern of missing data and ob-
served genotypes match exactly. One marker (chosen at random) is selected as the name of the
group (in the output of the function).
If exact.only=FALSE, we look also for markers whose observed genotypes are contained in the
observed genotypes of another marker. We use a pair of nested loops, working from the markers
with the most observed genotypes to the markers with the fewest observed genotypes.

Value

A list of marker names; each component is a set of markers whose genotypes match one other
marker, and the name of the component is the name of the marker that they match.

50

See Also

find_ibd_segments

drop_markers(), drop_nullmarkers(), reduce_markers()

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
dup <- find_dup_markers(grav2)
grav2_nodup <- drop_markers(grav2, unlist(dup))

find_ibd_segments

Find IBD segments for a set of strains

Description

Find IBD segments (regions with a lot of shared SNP genotypes) for a set of strains

Usage

find_ibd_segments(geno, map, min_lod = 15, error_prob = 0.001, cores = 1)

Arguments

geno

map

min_lod

error_prob

cores

Details

List of matrices of founder genotypes. The matrices correspond to the genotypes
on chromosomes and are arrayed as founders x markers.

List of vectors of marker positions

Threshold for minimum LOD score for a segment

Genotyping error/mutation probability
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

For each strain pair on each chromosome, we consider all marker intervals and calculate a LOD
score comparing the two hypotheses: that the strains are IBD in the interval, vs. that they are not.
We assume that the two strains are homozygous at all markers, and use the model from Broman and
Weber (1999), which assumes linkage equilibrium between markers and uses a simple model for
genotype frequencies in the presence of genotyping errors or mutations.

Note that inference of IBD segments is heavily dependent on how SNPs were chosen to be geno-
typed. (For example, were the SNPs ascertained based on their polymorphism between a particular
strain pair?)

find_ibd_segments

Value

A data frame whose rows are IBD segments and whose columns are:

51

• Strain 1

• Strain 2

• Chromosome

• Left marker

• Right marker

• Left position

• Right position

• Left marker index

• Right marker index

• Interval length

• Number of markers

• Number of mismatches

• LOD score

References

Broman KW, Weber JL (1999) Long homozygous chromosomal segments in reference families
from the Centre d’Étude du Polymorphisme Humain. Am J Hum Genet 65:1493–1500.

Examples

## Not run:
# load DO data from Recla et al. (2014) Mamm Genome 25:211-222.
recla <- read_cross2("https://raw.githubusercontent.com/rqtl/qtl2data/main/DO_Recla/recla.zip")

# grab founder genotypes and physical map
fg <- recla$founder_geno
pmap <- recla$pmap

# find shared segments
(segs <- find_ibd_segments(fg, pmap, min_lod=10, error_prob=0.0001))

## End(Not run)

52

find_index_snp

find_index_snp

Find name of indexed snp

Description

For a particular SNP, find the name of the corresponding indexed SNP.

Usage

find_index_snp(snpinfo, snp)

Arguments

snpinfo

snp

Value

Data frame with SNP information with the following columns:

• chr - Character string or factor with chromosome
• index - Numeric index of equivalent, indexed SNP, as produced by index_snps().
• snp - Character string with SNP identifier (if missing, the rownames are

used).

Name of snp to look for (can be a vector).

A vector of SNP IDs (the corresponding indexed SNPs), with NA if a SNP is not found.

See Also

find_marker()

Examples

## Not run:
# load example data and calculate genotype probabilities
file <- paste0("https://raw.githubusercontent.com/rqtl/",

"qtl2data/main/DO_Recla/recla.zip")

recla <- read_cross2(file)

# founder genotypes for a set of SNPs
snpgeno <- rbind(m1=c(3,1,1,3,1,1,1,1),
m2=c(3,1,1,3,1,1,1,1),
m3=c(1,1,1,1,3,3,3,3),
m4=c(1,3,1,3,1,3,1,3))

sdp <- calc_sdp(snpgeno)
snpinfo <- data.frame(chr=c("19", "19", "X", "X"),

pos=c(40.36, 40.53, 110.91, 111.21),
sdp=sdp,
snp=c("m1", "m2", "m3", "m4"), stringsAsFactors=FALSE)

# update snp info by adding the SNP index column

find_map_gaps

53

snpinfo <- index_snps(recla$pmap, snpinfo)

# find indexed snp for a particular snp
find_index_snp(snpinfo, "m3")

## End(Not run)

find_map_gaps

Find gaps in a genetic map

Description

Find gaps between markers in a genetic map

Usage

find_map_gaps(map, min_gap = 50)

Arguments

map

Genetic map as a list of vectors (each vector is a chromosome and contains the
marker positions).

min_gap

Minimum gap length to return.

Value

Data frame with 6 columns: chromosome, marker to left of gap, numeric index of marker to left,
marker to right of gap, numeric index of marker to right, and the length of the gap.

See Also

reduce_map_gaps()

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
find_map_gaps(iron$gmap, 40)

54

find_marker

find_marker

Find markers by chromosome position

Description

Find markers closest to specified set of positions, or within a specified interval.

Usage

find_marker(map, chr, pos = NULL, interval = NULL)

Arguments

map

chr

pos

interval

Details

A map object: a list (corresponding to chromosomes) of vectors of marker po-
sitions. Can also be a snpinfo object (data frame with columns chr and pos;
marker names taken from column snp or if that doesn’t exist from the row
names)

A vector of chromosomes

A vector of positions
A pair of positions (provide either pos or interval but not both)

If pos is provided, interval should not be, and vice versa.
If pos is provided, then chr and pos should either be the same length, or one of them should have
length 1 (to be expanded to the length of the other).
If interval is provided, then chr should have length 1.

Value

A vector of marker names, either closest to the positions specified by pos, or within the interval
defined by interval.

See Also

find_markerpos(), find_index_snp(), pull_genoprobpos(), pull_genoprobint()

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# find markers by their genetic map positions
find_marker(iron$gmap, c(8, 11), c(37.7, 56.9))

# find markers by their physical map positions (two markers on chr 7)
find_marker(iron$pmap, 7, c(44.2, 108.9))

find_markerpos

55

# find markers in an interval
find_marker(iron$pmap, 16, interval=c(35, 80))

find_markerpos

Find positions of markers

Description

Find positions of markers within a cross object

Usage

find_markerpos(cross, markers, na.rm = TRUE)

Arguments

cross

markers

na.rm

Value

Object of class "cross2". For details, see the R/qtl2 developer guide. Can also
be a map (as a list of vectors of marker positions).

A vector of marker names.

If TRUE, don’t include not-found markers in the results (but issue a warning if
some markers weren’t found). If FALSE, include those markers with NA for chr
and position.

A data frame with chromosome and genetic and physical positions (in columns "gmap" and "pmap"),
with markers as row names. If the input cross is not a cross2 object but rather a map, the output
contains chr and pos.

See Also

find_marker()

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# find markers
find_markerpos(iron, c("D8Mit294", "D11Mit101"))

56

find_peaks

find_peaks

Find peaks in a set of LOD curves

Description

Find peaks in a set of LOD curves (output from scan1()

Usage

find_peaks(

scan1_output,
map,
threshold = 3,
peakdrop = Inf,
drop = NULL,
prob = NULL,
thresholdX = NULL,
peakdropX = NULL,
dropX = NULL,
probX = NULL,
expand2markers = TRUE,
sort_by = c("column", "pos", "lod"),
cores = 1

)

Arguments

scan1_output

map

threshold

peakdrop

drop

prob

thresholdX

An object of class "scan1" as returned by scan1().
A list of vectors of marker positions, as produced by insert_pseudomarkers().
Can also be an indexed SNP info table, as from index_snps() or scan1snps().

Minimum LOD score for a peak (can be a vector with separate thresholds for
each lod score column in scan1_output)

Amount that the LOD score must drop between peaks, if multiple peaks are to
be defined on a chromosome. (Can be a vector with separate values for each lod
score column in scan1_output.)

If provided, LOD support intervals are included in the results, and this indicates
the amount to drop in the support interval. (Can be a vector with separate values
for each lod score column in scan1_output.) Must be ≤ peakdrop

If provided, Bayes credible intervals are included in the results, and this indi-
cates the nominal coverage. (Can be a vector with separate values for each lod
score column in scan1_output.) Provide just one of drop and prob.

Separate threshold for the X chromosome; if unspecified, the same threshold is
used for both autosomes and the X chromosome. (Like threshold, this can be
a vector with separate thresholds for each lod score column.)

find_peaks

peakdropX

dropX

probX

57

Like peakdrop, but for the X chromosome; if unspecified, the same value is
used for both autosomes and the X chromosome. (Can be a vector with separate
values for each lod score column in scan1_output.)

Amount to drop for LOD support intervals on the X chromosome. Ignored if
drop is not provided. (Can be a vector with separate values for each lod score
column in scan1_output.)

Nominal coverage for Bayes intervals on the X chromosome. Ignored if prob is
not provided. (Can be a vector with separate values for each lod score column
in scan1_output.)

expand2markers If TRUE (and if drop or prob is provided, so that QTL intervals are calculated),

QTL intervals are expanded so that their endpoints are at genetic markers.

Indicates whether to sort the rows by lod column, genomic position, or LOD
score.

Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

sort_by

cores

Details

For each lod score column on each chromosome, we return a set of peaks defined as local maxima
that exceed the specified threshold, with the requirement that the LOD score must have dropped
by at least peakdrop below the lowest of any two adjacent peaks.

At a given peak, if there are ties, with multiple positions jointly achieving the maximum LOD score,
we take the average of these positions as the location of the peak.

Value

A data frame with each row being a single peak on a single chromosome for a single LOD score
column, and with columns

• lodindex - lod column index

• lodcolumn - lod column name

• chr - chromosome ID

• pos - peak position

• lod - lod score at peak

If drop or prob is provided, the results will include two additional columns: ci_lo and ci_hi, with
the endpoints of the LOD support intervals or Bayes credible wintervals.

See Also

scan1(), lod_int(), bayes_int()

58

Examples

fit1

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)
Xcovar <- get_x_covar(iron)

# perform genome scan
out <- scan1(probs, pheno, addcovar=covar, Xcovar=Xcovar)

# find just the highest peak on each chromosome
find_peaks(out, map, threshold=3)

# possibly multiple peaks per chromosome
find_peaks(out, map, threshold=3, peakdrop=1)

# possibly multiple peaks, also getting 1-LOD support intervals
find_peaks(out, map, threshold=3, peakdrop=1, drop=1)

# possibly multiple peaks, also getting 90% Bayes intervals
find_peaks(out, map, threshold=3, peakdrop=1, prob=0.9)

fit1

Fit single-QTL model at a single position

Description

Fit a single-QTL model at a single putative QTL position and get detailed results about estimated
coefficients and individuals contributions to the LOD score.

Usage

fit1(

genoprobs,
pheno,
kinship = NULL,
addcovar = NULL,
nullcovar = NULL,
intcovar = NULL,

fit1

59

weights = NULL,
contrasts = NULL,
model = c("normal", "binary"),
zerosum = TRUE,
se = TRUE,
hsq = NULL,
reml = TRUE,
blup = FALSE,
...

)

Arguments

genoprobs

pheno

kinship

addcovar

nullcovar

intcovar

weights

contrasts

model

zerosum

se

hsq

reml

blup

...

Details

A matrix of genotype probabilities, individuals x genotypes. If NULL, we create
a single intercept column, matching the individual IDs in pheno.

A numeric vector of phenotype values (just one phenotype, not a matrix of them)

Optional kinship matrix.

An optional numeric matrix of additive covariates.

An optional numeric matrix of additional additive covariates that are used under
the null hypothesis (of no QTL) but not under the alternative (with a QTL).
This is needed for the X chromosome, where we might need sex as a additive
covariate under the null hypothesis, but we wouldn’t want to include it under the
alternative as it would be collinear with the QTL effects.

An optional numeric matrix of interactive covariates.

An optional numeric vector of positive weights for the individuals. As with the
other inputs, it must have names for individual identifiers.

An optional numeric matrix of genotype contrasts, size genotypes x genotypes.
For an intercross, you might use cbind(mu=c(1,1,1), a=c(-1, 0, 1), d=c(0,
1, 0)) to get mean, additive effect, and dominance effect. The default is the
identity matrix.

Indicates whether to use a normal model (least squares) or binary model (logistic
regression) for the phenotype. If model="binary", the phenotypes must have
values in [0, 1].

If TRUE, force the genotype or allele coefficients sum to 0 by subtracting their
mean and add another column with the mean. Ignored if contrasts is provided.

If TRUE, calculate the standard errors.
(Optional) residual heritability; used only if kinship provided.
If kinship provided: if reml=TRUE, use REML; otherwise maximum likelihood.
If TRUE, fit a model with QTL effects being random, as in scan1blup().

Additional control parameters; see Details;

For each of the inputs, the row names are used as individual identifiers, to align individuals.

60

fit1

If kinship is absent, Haley-Knott regression is performed. If kinship is provided, a linear mixed
model is used, with a polygenic effect estimated under the null hypothesis of no (major) QTL, and
then taken as fixed as known in the genome scan.
If contrasts is provided, the genotype probability matrix, P , is post-multiplied by the contrasts
matrix, A, prior to fitting the model. So we use P · A as the X matrix in the model. One might view
the rows of A−1 as the set of contrasts, as the estimated effects are the estimated genotype effects
pre-multiplied by A−1.
The ... argument can contain several additional control parameters; suspended for simplicity (or
confusion, depending on your point of view). tol is used as a tolerance value for linear regression
by QR decomposition (in determining whether columns are linearly dependent on others and should
be omitted); default 1e-12. maxit is the maximum number of iterations for converence of the
iterative algorithm used when model=binary. bintol is used as a tolerance for converence for
the iterative algorithm used when model=binary. eta_max is the maximum value for the "linear
predictor" in the case model="binary" (a bit of a technicality to avoid fitted values exactly at 0 or
1).

Value

A list containing

• coef - Vector of estimated coefficients.
• SE - Vector of estimated standard errors (included if se=TRUE).
• lod - The overall lod score.
• ind_lod - Vector of individual contributions to the LOD score (not provided if kinship is

used).

• fitted - Fitted values.
• resid - Residuals. If blup==TRUE, only coef and SE are included at present.

References

Haley CS, Knott SA (1992) A simple regression method for mapping quantitative trait loci in line
crosses using flanking markers. Heredity 69:315–324.

Kang HM, Zaitlen NA, Wade CM, Kirby A, Heckerman D, Daly MJ, Eskin E (2008) Efficient
control of population structure in model organism association mapping. Genetics 178:1709–1723.

See Also

pull_genoprobpos(), find_marker()

Examples

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=5)

fread_csv

61

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno[,1]
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)

# scan chromosome 7 to find peak
out <- scan1(probs[,"7"], pheno, addcovar=covar)

# find peak position
max_pos <- max(out, map)

# genoprobs at max position
pr_max <- pull_genoprobpos(probs, map, max_pos$chr, max_pos$pos)

# fit QTL model just at that position
out_fit1 <- fit1(pr_max, pheno, addcovar=covar)

fread_csv

Read a csv file

Description

Read a csv file via data.table::fread() using a particular set of options, including the ability to
transpose the result.

Usage

fread_csv(

filename,
sep = ",",
na.strings = c("NA", "-"),
comment.char = "#",
transpose = FALSE,
rownames_included = TRUE

)

Arguments

filename
sep
na.strings
comment.char
transpose
rownames_included

Name of input file
Field separator
Missing value codes
Comment character; rest of line after this character is ignored
If TRUE, transpose the result

If TRUE, the first column is taken to be row names.

62

Details

fread_csv_numer

Initial two lines can contain comments with number of rows and columns. Number of columns
includes an ID column; number of rows does not include the header row.

The first column is taken to be a set of row names

Value

Data frame

See Also

fread_csv_numer()

Examples

## Not run: mydata <- fread_csv("myfile.csv", transpose=TRUE)

fread_csv_numer

Read a csv file that has numeric columns

Description

Read a csv file via data.table::fread() using a particular set of options, including the ability
to transpose the result. This version assumes that the contents other than the first column and the
header row are strictly numeric.

Usage

fread_csv_numer(

filename,
sep = ",",
na.strings = c("NA", "-"),
comment.char = "#",
transpose = FALSE,
rownames_included = TRUE

)

Arguments

filename

sep

na.strings

comment.char

Name of input file

Field separator

Missing value codes

Comment character; rest of line after this character is ignored

transpose
rownames_included

If TRUE, transpose the result

If TRUE, the first column is taken to be row names.

genoprob_to_alleleprob

Details

63

Initial two lines can contain comments with number of rows and columns. Number of columns
includes an ID column; number of rows does not include the header row.

The first column is taken to be a set of row names

Value

Data frame

See Also

fread_csv()

Examples

## Not run: mydata <- fread_csv_numer("myfile.csv", transpose=TRUE)

genoprob_to_alleleprob

Convert genotype probabilities to allele probabilities

Description

Reduce genotype probabilities (as calculated by calc_genoprob()) to allele probabilities.

Usage

genoprob_to_alleleprob(probs, quiet = TRUE, cores = 1)

Arguments

probs

quiet

cores

Value

Genotype probabilities, as calculated from calc_genoprob().
IF FALSE, print progress messages.
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

An object of class "calc_genoprob", like the input probs, but with probabilities collapsed to
alleles rather than genotypes. See calc_genoprob().

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
gmap_w_pmar <- insert_pseudomarkers(iron, step=1)
probs <- calc_genoprob(iron, gmap_w_pmar, error_prob=0.002)
allele_probs <- genoprob_to_alleleprob(probs)

64

genoprob_to_snpprob

genoprob_to_snpprob

Convert genotype probabilities to SNP probabilities

Description

For multi-parent populations, convert use founder genotypes at a set of SNPs to convert founder-
based genotype probabilities to SNP genotype probabilities.

Usage

genoprob_to_snpprob(genoprobs, snpinfo)

Arguments

genoprobs

Genotype probabilities as calculated by calc_genoprob().

snpinfo

Data frame with SNP information with the following columns (the last three are
generally derived with index_snps()):

• chr - Character string or factor with chromosome
• pos - Position (in same units as in the "map" attribute in genoprobs.
• sdp - Strain distribution pattern: an integer, between 1 and 2n − 2 where
n is the number of strains, whose binary encoding indicates the founder
genotypes

• snp - Character string with SNP identifier (if missing, the rownames are

used).

• index - Indices that indicate equivalent groups of SNPs, calculated by

index_snps().

• intervals - Indexes that indicate which marker intervals the SNPs reside.
• on_map - Indicate whether SNP coincides with a marker in the genoprobs

Alternatively, snpinfo can be a object of class "cross2", as output by read_cross2(),
containing the data for a multi-parent population with founder genotypes, in
which case the SNP information for all markers with complete founder geno-
type data is calculated and then used. But, in this case, the genotype probabilities
must be at the markers in the cross.

Details

We first split the SNPs by chromosome and use snpinfo$index to subset to non-equivalent SNPs.
snpinfo$interval indicates the intervals in the genotype probabilities that contain each. For SNPs
contained within an interval, we use the average of the probabilities for the two endpoints. We then
collapse the probabilities according to the strain distribution pattern.

genoprob_to_snpprob

Value

65

An object of class "calc_genoprob", like the input genoprobs, but with imputed genotype proba-
bilities at the selected SNPs indicated in snpinfo$index. See calc_genoprob().
If the input genoprobs is for allele probabilities, the probs output has just two probability columns
(for the two SNP alleles). If the input has a full set of n(n + 1)/2 probabilities for n strains, the
probs output has 3 probabilities (for the three SNP genotypes). If the input has full genotype prob-
abilities for the X chromosome (n(n + 1)/2 genotypes for the females followed by n hemizygous
genotypes for the males), the output has 5 probabilities: the 3 female SNP genotypes followed by
the two male hemizygous SNP genotypes.

See Also

index_snps(), calc_genoprob(), scan1snps()

Examples

## Not run:
# load example data and calculate genotype probabilities
file <- paste0("https://raw.githubusercontent.com/rqtl/",

"qtl2data/main/DO_Recla/recla.zip")

recla <- read_cross2(file)
recla <- recla[c(1:2,53:54), c("19","X")] # subset to 4 mice and 2 chromosomes
probs <- calc_genoprob(recla, error_prob=0.002)

# founder genotypes for a set of SNPs
snpgeno <- rbind(m1=c(3,1,1,3,1,1,1,1),
m2=c(1,3,1,3,1,3,1,3),
m3=c(1,1,1,1,3,3,3,3),
m4=c(1,3,1,3,1,3,1,3))

sdp <- calc_sdp(snpgeno)
snpinfo <- data.frame(chr=c("19", "19", "X", "X"),

pos=c(40.36, 40.53, 110.91, 111.21),
sdp=sdp,
snp=c("m1", "m2", "m3", "m4"), stringsAsFactors=FALSE)

# identify groups of equivalent SNPs
snpinfo <- index_snps(recla$pmap, snpinfo)

# collapse to SNP genotype probabilities
snpprobs <- genoprob_to_snpprob(probs, snpinfo)

# could also first convert to allele probs
aprobs <- genoprob_to_alleleprob(probs)
snpaprobs <- genoprob_to_snpprob(aprobs, snpinfo)

## End(Not run)

66

get_common_ids

get_common_ids

Get common set of IDs from objects

Description

For a set objects with IDs as row names (or, for a vector, just names), find the IDs that are present
in all of the objects.

Usage

get_common_ids(..., complete.cases = FALSE)

Arguments

...

A set of objects: vectors, lists, matrices, data frames, and/or arrays. If one is a
character vector with no names attribute, it’s taken to be a set of IDs, itself.

complete.cases If TRUE, look at matrices and non-character vectors and keep only individuals

with no missing values.

Details

This is used (mostly internally) to align phenotypes, genotype probabilities, and covariates in prepa-
ration for a genome scan. The complete.cases argument is used to omit individuals with any
missing covariate values.

Value

A vector of character strings for the individuals that are in common.

Examples

x <- matrix(0, nrow=10, ncol=5); rownames(x) <- LETTERS[1:10]
y <- matrix(0, nrow=5, ncol=5); rownames(y) <- LETTERS[(1:5)+7]
z <- LETTERS[5:15]
get_common_ids(x, y, z)

x[8,1] <- NA
get_common_ids(x, y, z)
get_common_ids(x, y, z, complete.cases=TRUE)

get_x_covar

67

get_x_covar

Get X chromosome covariates

Description

Get the matrix of covariates to be used for the null hypothesis when performing QTL analysis with
the X chromosome.

Usage

get_x_covar(cross)

Arguments

cross

Details

Object of class "cross2". For details, see the R/qtl2 developer guide.

For most crosses, the result is either NULL (indicating no additional covariates are needed) or a
matrix with a single column containing sex indicators (1 for males and 0 for females).

For an intercross, we also consider cross direction. There are four cases: (1) All male or all female
but just one direction: no covariate; (2) All female but both directions: covariate indicating cross
direction; (3) Both sexes, one direction: covariate indicating sex; (4) Both sexes, both directions:
a covariate indicating sex and a covariate that is 1 for females from the reverse direction and 0
otherwise.

Value

A matrix of size individuals x no. covariates.

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
xcovar <- get_x_covar(iron)

guess_phase

Guess phase of imputed genotypes

Description

Turn imputed genotypes into phased genotypes along chromosomes by attempting to pick the phase
that leads to the fewest recombination events.

Usage

guess_phase(cross, geno, deterministic = FALSE, cores = 1)

68

Arguments

cross

geno

index_snps

Object of class "cross2". For details, see the R/qtl2 developer guide.
Imputed genotypes, as a list of matrices, as from maxmarg().

deterministic

cores

If TRUE, preferentially put smaller allele first when there’s uncertainty.
FALSE, the order of alleles is random in such cases.
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

If

Details

We randomly assign the pair of alleles at the first locus to two haplotypes, and then work left to
right, assigning alleles to haplotypes one locus at a time seeking the fewest recombination events.
The results are subject to arbitrary and random choices. For example, to the right of a homozygous
region, either orientation is equally reasonable.

Value

If input cross is phase-known (e.g., recombinant inbred lines), the output will be the input geno.
Otherwise, the output will be a list of three-dimensional arrays of imputed genotypes, individual x
position x haplotype (1/2).

See Also

maxmarg()

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
gmap <- insert_pseudomarkers(iron$gmap, step=1)
probs <- calc_genoprob(iron, gmap, error_prob=0.002)
imp_geno <- maxmarg(probs)
ph_geno <- guess_phase(iron, imp_geno)

index_snps

Create index of equivalent SNPs

Description

For a set of SNPs and a map of marker/pseudomarkers, partition the SNPs into groups that are
contained within common intervals and have the same strain distribution pattern, and then create an
index to a set of distinct SNPs, one per partition.

Usage

index_snps(map, snpinfo, tol = 0.00000001)

index_snps

Arguments

map

snpinfo

tol

Details

69

Physical map of markers and pseudomarkers; generally created from insert_pseudomarkers()
and used for a set of genotype probabilities (calculated with calc_genoprob())
that are to be used to interpolate SNP genotype probabilities (with genoprob_to_snpprob()).
Data frame with SNP information with the following columns:

• chr - Character string or factor with chromosome
• pos - Position (in same units as in the "map").
• sdp - Strain distribution pattern: an integer, between 1 and 2n − 2 where
n is the number of strains, whose binary encoding indicates the founder
genotypes

• snp - Character string with SNP identifier (if missing, the rownames are

used).

Tolerance for determining whether a SNP is exactly at a position at which geno-
type probabilities were already calculated.

We split the SNPs by chromosome and identify the intervals in the map that contain each. For SNPs
within tol of a position at which the genotype probabilities were calculated, we take the SNP to be
at that position. For each marker position or interval, we then partition the SNPs into groups that
have distinct strain distribution patterns, and choose a single index SNP for each partition.

Value

A data frame containing the input snpinfo with three added columns: "index" (which indicates
the groups of equivalent SNPs), "interval" (which indicates the map interval containing the SNP,
with values starting at 0), and on_map (which indicates that the SNP is within tol of a position on
the map). The rows get reordered, so that they are ordered by chromosome and position, and the
values in the "index" column are by chromosome.

See Also

genoprob_to_snpprob(), scan1snps(), find_index_snp()

Examples

## Not run:
# load example data and calculate genotype probabilities
file <- paste0("https://raw.githubusercontent.com/rqtl/",

"qtl2data/main/DO_Recla/recla.zip")

recla <- read_cross2(file)

# founder genotypes for a set of SNPs
snpgeno <- rbind(m1=c(3,1,1,3,1,1,1,1),
m2=c(1,3,1,3,1,3,1,3),
m3=c(1,1,1,1,3,3,3,3),
m4=c(1,3,1,3,1,3,1,3))

sdp <- calc_sdp(snpgeno)
snpinfo <- data.frame(chr=c("19", "19", "X", "X"),

70

insert_pseudomarkers

pos=c(40.36, 40.53, 110.91, 111.21),
sdp=sdp,
snp=c("m1", "m2", "m3", "m4"), stringsAsFactors=FALSE)

# update snp info by adding the SNP index column
snpinfo <- index_snps(recla$pmap, snpinfo)

## End(Not run)

insert_pseudomarkers

Insert pseudomarkers into a marker map

Description

Insert pseudomarkers into a map of genetic markers

Usage

insert_pseudomarkers(

map,
step = 0,
off_end = 0,
stepwidth = c("fixed", "max"),
pseudomarker_map = NULL,
tol = 0.01,
cores = 1

)

Arguments

map

step

off_end

stepwidth

A list of numeric vectors; each vector gives marker positions for a single chro-
mosome.
Distance between pseudomarkers and markers; if step=0 no pseudomarkers are
inserted.

Distance beyond terminal markers in which to insert pseudomarkers.
Indicates whether to use a fixed grid (stepwidth="fixed") or to use the max-
imal distance between pseudomarkers to ensure that no two adjacent mark-
ers/pseudomarkers are more than step apart.

pseudomarker_map

A map of pseudomarker locations; if provided the step, off_end, and stepwidth
arguments are ignored.

tol

cores

Tolerance for determining whether a pseudomarker would duplicate a marker
position.
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

interp_genoprob

Details

71

If stepwidth="fixed", a grid of pseudomarkers is added to the marker map.
If stepwidth="max", a minimal set of pseudomarkers are added, so that the maximum distance
between adjacent markers or pseudomarkers is at least step. If two adjacent markers are separated
by less than step, no pseudomarkers will be added to the interval. If they are more then step apart,
a set of equally-spaced pseudomarkers will be added.
If pseudomarker_map is provided, then the step, off_end, and stepwidth arguments are ignored,
and the input pseudomarker_map is taken to be the set of pseudomarker positions.

Value

A list like the input map with pseudomarkers inserted. Will also have an attribute "is_x_chr", taken
from the input map.

See Also

calc_genoprob(), calc_grid()

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
gmap_w_pmar <- insert_pseudomarkers(iron$gmap, step=1)

interp_genoprob

Interpolate genotype probabilities

Description

Linear interpolation of genotype probabilities, mostly to get two sets onto the same map for com-
parison purposes.

Usage

interp_genoprob(probs, map, cores = 1)

Arguments

probs

map

cores

Genotype probabilities, as calculated from calc_genoprob().

List of vectors of map positions.
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

72

Details

interp_map

We reduce probs to the positions present in map and then interpolate the genotype probabilities at
additional positions in map by linear interpolation using the two adjacent positions. Off the ends,
we just copy over the first or last value unchanged.
In general, it’s better to use insert_pseudomarkers() and calc_genoprob() to get genotype
probabilities at additional positions along a chromosome. This function is a very crude alternative
that was implemented in order to compare genotype probabilities derived by different methods,
where we first need to get them onto a common set of positions.

Value

An object of class "calc_genoprob", like the input, but with additional positions present in map.
See calc_genoprob().

See Also

calc_genoprob()

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

probs <- calc_genoprob(iron, iron$gmap, error_prob=0.002)

# you generally wouldn't want to do this, but this is an illustration
map <- insert_pseudomarkers(iron$gmap, step=1)
probs_map <- interp_genoprob(probs, map)

interp_map

Interpolate between maps

Description

Use interpolate to convert from one map to another

Usage

interp_map(map, oldmap, newmap)

Arguments

map

oldmap

newmap

The map to be interpolated; a list of vectors.
Map with positions in the original scale, as in map.

Map with positions in the new scale.

73

invert_sdp

Value

Object of same form as input map but in the units as in newmap.

Examples

# load example data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# positions to interpolate from cM to Mbp
tointerp <- list("7" = c(pos7.1= 5, pos7.2=15, pos7.3=25),

"9" = c(pos9.1=20, pos9.2=40))

interp_map(tointerp, iron$gmap, iron$pmap)

invert_sdp

Calculate SNP genotype matrix from strain distribution patterns

Description

Calculate the matrix of SNP genotypes from a vector of strain distribution patterns (SDPs).

Usage

invert_sdp(sdp, n_strains)

Arguments

sdp

Vector of strain distribution patterns (integers between 1 and 2n − 2 where n is
the number of strains.

n_strains

Number of strains

Value

Matrix of SNP genotypes, markers x strains, coded as 1 (AA) and 3 (BB). Markers with values
other than 1 or 3 are omitted, and monomorphic markers, are omitted.

See Also

sdp2char(), calc_sdp()

Examples

sdp <- c(m1=1, m2=12, m3=240)
invert_sdp(sdp, 8)

74

locate_xo

locate_xo

Locate crossovers

Description

Estimate the locations of crossovers in each individual on each chromosome.

Usage

locate_xo(geno, map, quiet = TRUE, cores = 1)

Arguments

geno

map

quiet

cores

Value

List of matrices of genotypes (output of maxmarg() or viterbi()).

List of vectors with the map positions of the markers.

If FALSE, print progress messages.

Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

A list of lists of estimated crossover locations, with crossovers placed at the midpoint of the intervals
that contain them.

See Also

count_xo()

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
map <- insert_pseudomarkers(iron$gmap, step=1)
pr <- calc_genoprob(iron, map, error_prob=0.002, map_function="c-f")
g <- maxmarg(pr)
pos <- locate_xo(g, iron$gmap)

lod_int

75

lod_int

Calculate LOD support intervals

Description

Calculate LOD support intervals for a single LOD curve on a single chromosome, with the ability
to identify intervals for multiple LOD peaks.

Usage

lod_int(

scan1_output,
map,
chr = NULL,
lodcolumn = 1,
threshold = 0,
peakdrop = Inf,
drop = 1.5,
expand2markers = TRUE

)

Arguments

scan1_output

map

chr

lodcolumn

threshold

An object of class "scan1" as returned by scan1().
A list of vectors of marker positions, as produced by insert_pseudomarkers().

Chromosome ID to consider (must be a single value).

LOD score column to consider (must be a single value).

Minimum LOD score for a peak.

peakdrop

Amount that the LOD score must drop between peaks, if multiple peaks are to
be defined on a chromosome.
Amount to drop in the support interval. Must be ≤ peakdrop
expand2markers If TRUE, QTL intervals are expanded so that their endpoints are at genetic mark-

drop

ers.

Details

We identify a set of peaks defined as local maxima that exceed the specified threshold, with the
requirement that the LOD score must have dropped by at least peakdrop below the lowest of any
two adjacent peaks.

At a given peak, if there are ties, with multiple positions jointly achieving the maximum LOD score,
we take the average of these positions as the location of the peak.
The default is to use threshold=0, peakdrop=Inf, and drop=1.5. We then return results a single
peak, no matter the maximum LOD score, and give a 1.5-LOD support interval.

map_to_grid

76

Value

A matrix with three columns:

• ci_lo - lower bound of interval
• pos - peak position
• ci_hi - upper bound of interval

Each row corresponds to a different peak.

See Also

bayes_int(), find_peaks(), scan1()

Examples

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)
Xcovar <- get_x_covar(iron)

# perform genome scan
out <- scan1(probs, pheno, addcovar=covar, Xcovar=Xcovar)

# 1.5-LOD support interval for QTL on chr 7, first phenotype
lod_int(out, map, chr=7, lodcolum=1)

map_to_grid

Subset a map to positions on a grid

Description

Subset a map object to the locations on some grid.

Usage

map_to_grid(map, grid)

mat2strata

Arguments

map

grid

Details

77

A list of vectors of marker positions.
A list of logical vectors (aligned with map), with TRUE indicating the position
is on the grid.

This is generally for the case of a map created with insert_pseudomarkers() with step>0 and
stepwidth="fixed", so that the pseudomarkers form a grid along each chromosome.

Value

Same list as input, but subset to just include pseudomarkers along a grid.

See Also

calc_grid(), probs_to_grid()

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
map_w_pmar <- insert_pseudomarkers(grav2$gmap, step=1)
sapply(map_w_pmar, length)
grid <- calc_grid(grav2$gmap, step=1)
map_sub <- map_to_grid(map_w_pmar, grid)
sapply(map_sub, length)

mat2strata

Define strata based on rows of a matrix

Description

Use the rows of a matrix to define a set of strata for a stratified permutation test

Usage

mat2strata(mat)

Arguments

mat

Value

A covariate matrix, as individuals x covariates

A vector of character strings: for each row of mat, we use base::paste() with collapse="|".

See Also

get_x_covar(), scan1perm()

78

Examples

maxlod

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

Xcovar <- get_x_covar(iron)
perm_strata <- mat2strata(Xcovar)

maxlod

Overall maximum LOD score

Description

Find overall maximum LOD score in genome scan results, across all positions and columns.

Usage

maxlod(scan1_output, map = NULL, chr = NULL, lodcolumn = NULL)

Arguments

scan1_output

map

chr

lodcolumn

Value

An object of class "scan1" as returned by scan1().
A list of vectors of marker positions, as produced by insert_pseudomarkers().
Optional vector of chromosomes to consider.

An integer or character string indicating the LOD score column, either as a nu-
meric index or column name. If NULL, return maximum for all columns.

A single number: the maximum LOD score across all columns and positions for the selected chro-
mosomes.

Examples

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)
Xcovar <- get_x_covar(iron)

maxmarg

79

# perform genome scan
out <- scan1(probs, pheno, addcovar=covar, Xcovar=Xcovar)

# overall maximum
maxlod(out)

# maximum on chromosome 2
maxlod(out, map, "2")

maxmarg

Find genotypes with maximum marginal probabilities

Description

For each individual at each position, find the genotype with the maximum marginal probability.

Usage

maxmarg(
probs,
map = NULL,
minprob = 0.95,
chr = NULL,
pos = NULL,
return_char = FALSE,
quiet = TRUE,
cores = 1,
tol = 0.0000000000001

)

Arguments

probs

map

minprob

chr

pos

Genotype probabilities, as calculated from calc_genoprob().
Map of pseudomarkers in probs. Used only if chr and pos are provided.

Minimum probability for making a call. If maximum probability is less then this
value, give NA.
If provided (along with pos), consider only the single specified position.
If provided (along with chr), consider only the single specified position.

return_char

quiet

cores

tol

If TRUE, return genotype names as character strings.
IF FALSE, print progress messages.
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().
Tolerance value; genotypes with probability that are within tol of each other
are treated as equivalent.

80

Details

max_compare_geno

If multiple genotypes share the maximum probability, one is chosen at random.

Value

If chr and pos are provided, a vector of genotypes is returned. In this case, map is needed.
Otherwise, the result is a object like that returned by viterbi(), A list of two-dimensional arrays
of imputed genotypes, individuals x positions. Also includes these attributes:

• crosstype - The cross type of the input cross.
• is_x_chr - Logical vector indicating whether chromosomes are to be treated as the X chro-

mosome or not, from input cross.

• alleles - Vector of allele codes, from input cross.

See Also

sim_geno(), viterbi()

Examples

# load data and calculate genotype probabilities
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
pr <- calc_genoprob(iron, error_prob=0.002)

# full set of imputed genotypes
ginf <- maxmarg(pr)

# imputed genotypes at a fixed position
g <- maxmarg(pr, iron$gmap, chr=8, pos=45.5)

# return genotype names rather than integers
g <- maxmarg(pr, iron$gmap, chr=8, pos=45.5, return_char=TRUE)

max_compare_geno

Find pair with most similar genotypes

Description

From results of compare_geno(), show the pair with most similar genotypes.

Usage

max_compare_geno(object, ...)

## S3 method for class 'compare_geno'
max(object, ...)

max_scan1

Arguments

object

...

Value

81

A square matrix with genotype comparisons for pairs of individuals, as output
by compare_geno().
Ignored

Data frame with individual pair, proportion matches, number of mismatches, number of matches,
and total markers genotyped.

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
cg <- compare_geno(grav2)
max(cg)

max_scan1

Find position with maximum LOD score

Description

Return data frame with the positions having maximum LOD score for a particular LOD score col-
umn

Usage

max_scan1(

scan1_output,
map = NULL,
lodcolumn = 1,
chr = NULL,
na.rm = TRUE,
...

)

## S3 method for class 'scan1'
max(scan1_output, map = NULL, lodcolumn = 1, chr = NULL, na.rm = TRUE, ...)

Arguments

scan1_output
map

lodcolumn

chr
na.rm
...

An object of class "scan1" as returned by scan1().
A list of vectors of marker positions, as produced by insert_pseudomarkers().
Can also be an indexed SNP info table, as from index_snps() or scan1snps().
An integer or character string indicating the LOD score column, either as a nu-
meric index or column name. If NULL, return maximum for all columns.
Optional vector of chromosomes to consider.
Ignored (take to be TRUE)
Ignored

82

Value

n_missing

If map is NULL, the genome-wide maximum LOD score for the selected column is returned. If also
lodcolumn is NULL, you get a vector with the maximum LOD for each column.
If map is provided, the return value is a data.frame with three columns: chr, pos, and lod score. But
if lodcolumn is NULL, you get the maximum for each lod score column, in the format provided by
find_peaks(), so a data.frame with five columns: lodindex, lodcolumn, chr, pos, and lod.

Examples

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)
Xcovar <- get_x_covar(iron)

# perform genome scan
out <- scan1(probs, pheno, addcovar=covar, Xcovar=Xcovar)

# maximum of first column
max(out, map)

# maximum of spleen column
max(out, map, lodcolumn="spleen")

# maximum of first column on chr 2
max(out, map, chr="2")

n_missing

Count missing genotypes

Description

Number (or proportion) of missing (or non-missing) genotypes by individual or marker

Usage

n_missing(
cross,
by = c("individual", "marker"),

plot_coef

83

summary = c("count", "proportion")

)

n_typed(
cross,
by = c("individual", "marker"),
summary = c("count", "proportion")

)

Arguments

cross

An object of class "cross2", as output by read_cross2(). For details, see the
R/qtl2 developer guide.

by

summary

Whether to summarize by individual or marker

Whether to take count or proportion

Value

Vector of counts (or proportions) of missing (or non-missing) genotypes.

Functions

• n_missing(): Count missing genotypes
• n_typed(): Count genotypes

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
nmis_ind <- n_missing(iron)
pmis_mar <- n_typed(iron, "mar", "proportion")
plot(nmis_ind, xlab="Individual", ylab="No. missing genotypes")
plot(pmis_mar, xlab="Markers", ylab="Prop. genotyped")

plot_coef

Plot QTL effects along chromosome

Description

Plot estimated QTL effects along a chromosomes.

Usage

plot_coef(

x,
map,
columns = NULL,
col = NULL,

84

plot_coef

scan1_output = NULL,
add = FALSE,
gap = NULL,
top_panel_prop = 0.65,
legend = NULL,
...

)

plot_coefCC(

x,
map,
columns = 1:8,
col = qtl2::CCcolors,
scan1_output = NULL,
add = FALSE,
gap = NULL,
top_panel_prop = 0.65,
legend = NULL,
...

)

## S3 method for class 'scan1coef'
plot(
x,
map,
columns = 1,
col = NULL,
scan1_output = NULL,
add = FALSE,
gap = NULL,
top_panel_prop = 0.65,
legend = NULL,
...

)

Arguments

x

map

columns

col

scan1_output

Estimated QTL effects ("coefficients") as obtained from scan1coef().
A list of vectors of marker positions, as produced by insert_pseudomarkers().
Vector of columns to plot
Vector of colors, same length as columns. If NULL, some default choices are
made.

If provided, we make a two-panel plot with coefficients on top and LOD scores
below. Should have just one LOD score column; if multiple, only the first is
used.

add

gap

If TRUE, add to current plot (must have same map and chromosomes).

Gap between chromosomes. The default is 1% of the total genome length.

plot_coef

85

top_panel_prop If scan1_output provided, this gives the proportion of the plot that is devoted

to the top panel.
Location of legend, such as "bottomleft" or "topright" (NULL for no leg-
end)
Additional graphics parameters.

legend

...

Details

plot_coefCC() is the same as plot_coef(), but forcing columns=1:8 and using the Collaborative
Cross colors, CCcolors.

Value

None.

Hidden graphics parameters

A number of graphics parameters can be passed via .... For example, bgcolor to control the
background color, and things like ylab and ylim. These are not included as formal parameters in
order to avoid cluttering the function definition.
In the case that scan1_output is provided, col, ylab, and ylim all control the panel with estimated
QTL effects, while col_lod, ylab_lod, and ylim_lod control the LOD curve panel.
If legend is indicated so that a legend is shown, legend_lab controls the labels in the legend, and
legend_ncol indicates the number of columns in the legend.

See Also

CCcolors, plot_scan1(), plot_snpasso()

Examples

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno[,1]
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)

# calculate coefficients for chromosome 7
coef <- scan1coef(probs[,7], pheno, addcovar=covar)

# plot QTL effects (note the need to subset the map object, for chromosome 7)
plot(coef, map[7], columns=1:3, col=c("slateblue", "violetred", "green3"))

86

plot_genes

plot_compare_geno

Plot of compare_geno object.

Description

From results of compare_geno(), plot histogram of

Usage

plot_compare_geno(x, rug = TRUE, ...)

## S3 method for class 'compare_geno'
plot(x, rug = TRUE, ...)

A square matrix with genotype comparisons for pairs of individuals, as output
by compare_geno().

If true, use rug() to plot tick marks at observed values below the histogram.

Additional graphics parameters passed to hist()

Arguments

x

rug

...

Value

None.

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
cg <- compare_geno(grav2)
plot(cg)

plot_genes

Plot gene locations for a genomic interval

Description

Plot gene locations for a genomic interval, as rectangles with gene symbol (and arrow indicating
strand/direction) below.

plot_genes

Usage

87

plot_genes(
genes,
minrow = 4,
padding = 0.2,
colors = c("black", "red3", "green4", "blue3", "orange"),
scale_pos = 1,
start_field = "start",
stop_field = "stop",
strand_field = "strand",
name_field = "Name",
...

)

Arguments

genes

minrow

padding

colors

scale_pos

start_field

stop_field

strand_field

Data frame containing start and stop in Mbp, strand (as "-", "+", or NA),
and Name.

Minimum number of rows of genes in the plot

Proportion to pad with white space around the genes

Vectors of colors, used sequentially and then re-used.

Factor by which to scale position (for example, to convert basepairs to Mbp)

Character string with name of column containing the genes’ start positions.

Character string with name of column containing the genes’ stop positions.

Character string with name of column containing the genes’ strands. (The values
of the corresponding field can be character strings "+" or "-", or numeric +1 or
-1.)

name_field

...

Character string with name of column containing the genes’ names.
Optional arguments passed to plot().

Value

None.

Hidden graphics parameters

Graphics parameters can be passed via .... For example, xlim to control the x-axis limits. These
are not included as formal

Examples

genes <- data.frame(chr = c("6", "6", "6", "6", "6", "6", "6", "6"),

start = c(139988753, 140680185, 141708118, 142234227, 142587862,

143232344, 144398099, 144993835),

stop = c(140041457, 140826797, 141773810, 142322981, 142702315,

143260627, 144399821, 145076184),

88

plot_genoprob

strand = c("-", "+", "-", "-", "-", NA, "+", "-"),
Name = c("Plcz1", "Gm30215", "Gm5724", "Slco1a5", "Abcc9",

"4930407I02Rik", "Gm31777", "Bcat1"),

stringsAsFactors=FALSE)

# use scale_pos=1e-6 because data in bp but we want the plot in Mbp
plot_genes(genes, xlim=c(140, 146), scale_pos=1e-6)

plot_genoprob

Plot genotype probabilities for one individual on one chromosome.

Description

Plot the genotype probabilities for one individual on one chromosome, as a heat map.

Usage

plot_genoprob(

probs,
map,
ind = 1,
chr = NULL,
geno = NULL,
color_scheme = c("gray", "viridis"),
col = NULL,
threshold = 0,
swap_axes = FALSE,
...

)

## S3 method for class 'calc_genoprob'
plot(x, ...)

Arguments

probs

map

ind

chr

geno

color_scheme

col

threshold

Genotype probabilities (as produced by calc_genoprob()) or allele dosages (as
produced by genoprob_to_alleleprob()).
Marker map (a list of vectors of marker positions).

Individual to plot, either a numeric index or an ID.

Selected chromosome to plot; a single character string.

Optional vector of genotypes or alleles to be shown (vector of integers or char-
acter strings)
Color scheme for the heatmap (ignored if col is provided).
Optional vector of colors for the heatmap.

Threshold for genotype probabilities; only genotypes that achieve this value
somewhere on the chromosome will be shown.

89

If TRUE, swap the axes, so that the genotypes are on the x-axis and the chromo-
some position is on the y-axis.
Additional graphics parameters passed to graphics::image().
Genotype probabilities (as produced by calc_genoprob()) or allele dosages (as
produced by genoprob_to_alleleprob()). (For the S3 type plot function, this
has to be called x.)

plot_genoprob

swap_axes

...

x

Value

None.

Hidden graphics parameters

A number of graphics parameters can be passed via .... For example, hlines, hlines_col,
hlines_lwd, and hlines_lty to control the horizontal grid lines. (Use hlines=NA to avoid plotting
horizontal grid lines.) Similarly vlines, vlines_col, vlines_lwd, and vlines_lty for vertical
grid lines. You can also use many standard graphics parameters like xlab and xlim. These are not
included as formal parameters in order to avoid cluttering the function definition.

See Also

plot_genoprobcomp()

Examples

# load data and calculate genotype probabilities
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
iron <- iron[,"2"] # subset to chr 2
map <- insert_pseudomarkers(iron$gmap, step=1)
pr <- calc_genoprob(iron, map, error_prob=0.002)

# plot the probabilities for the individual labeled "262"
# (white = 0, black = 1)
plot_genoprob(pr, map, ind="262")

# change the x-axis label
plot_genoprob(pr, map, ind="262", xlab="Position (cM)")

# swap the axes so that the chromosome runs vertically
plot_genoprob(pr, map, ind="262", swap_axes=TRUE, ylab="Position (cM)")

# This is more interesting for a Diversity Outbred mouse example
## Not run:
file <- paste0("https://raw.githubusercontent.com/rqtl/",

"qtl2data/main/DOex/DOex.zip")

DOex <- read_cross2(file)
# subset to chr 2 and X and individuals labeled "232" and "256"
DOex <- DOex[c("232", "256"), c("2", "X")]
pr <- calc_genoprob(DOex, error_prob=0.002)
# plot individual "256" on chr 2 (default is to pick first chr in the probs)
plot_genoprob(pr, DOex$pmap, ind="256")

90

plot_genoprobcomp

# omit states that never have probability >= 0.5
plot_genoprob(pr, DOex$pmap, ind="256", threshold=0.05)

# X chr male 232: just show the AY-HY genotype probabilities
plot_genoprob(pr, DOex$pmap, ind="232", chr="X", geno=paste0(LETTERS[1:8], "Y"))
# could also indicate genotypes by number
plot_genoprob(pr, DOex$pmap, ind="232", chr="X", geno=37:44)
# and can use negative indexes
plot_genoprob(pr, DOex$pmap, ind="232", chr="X", geno=-(1:36))

# X chr female 256: just show the first 36 genotype probabilities
plot_genoprob(pr, DOex$pmap, ind="256", chr="X", geno=1:36)

# again, can give threshold to omit genotypes whose probabilities never reach that threshold
plot_genoprob(pr, DOex$pmap, ind="256", chr="X", geno=1:36, threshold=0.5)

# can also look at the allele dosages
apr <- genoprob_to_alleleprob(pr)
plot_genoprob(apr, DOex$pmap, ind="232")

## End(Not run)

plot_genoprobcomp

Plot comparison of two sets of genotype probabilities

Description

Plot a comparison of two sets of genotype probabilities for one individual on one chromosome, as
a heat map.

Usage

plot_genoprobcomp(

probs1,
probs2,
map,
ind = 1,
chr = NULL,
geno = NULL,
threshold = 0,
n_colors = 256,
swap_axes = FALSE,
...

)

plot_genoprobcomp

Arguments

probs1

probs2

map

ind

chr

geno

threshold

n_colors

swap_axes

...

Details

91

Genotype probabilities (as produced by calc_genoprob()) or allele dosages (as
produced by genoprob_to_alleleprob()).
A second set of genotype probabilities, just like probs1.

Marker map (a list of vectors of marker positions).

Individual to plot, either a numeric index or an ID.

Selected chromosome to plot; a single character string.

Optional vector of genotypes or alleles to be shown (vector of integers or char-
acter strings)

Threshold for genotype probabilities; only genotypes that achieve this value
somewhere on the chromosome (in one or the other set of probabilities) will
be shown.

Number of colors in each color scale.

If TRUE, swap the axes, so that the genotypes are on the x-axis and the chromo-
some position is on the y-axis.
Additional graphics parameters passed to graphics::image().

We plot the first set of probabilities in the range white to blue and the second set in the range white
to red and attempt to combine them, for colors that are white, some amount of blue or red, or where
both are large something like blackish purple.

Value

None.

See Also

plot_genoprob()

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
iron <- iron[228,"1"]
map <- insert_pseudomarkers(iron$gmap, step=5)

# subset to one individual on chr 1

# introduce genotype error and look at difference in genotype probabilities
pr_ne <- calc_genoprob(iron, map, error_prob=0.002)
iron$geno[[1]][1,2] <- 3
pr_e <- calc_genoprob(iron, map, error_prob=0.002)

# image of probabilities + comparison

par(mfrow=c(3,1))
plot_genoprob(pr_ne, map, main="No error")
plot_genoprob(pr_e, map, main="With an error")

92

plot_lodpeaks

plot_genoprobcomp(pr_ne, pr_e, map, main="Comparison")

plot_lodpeaks

Plot LOD scores vs QTL peak locations

Description

Create a scatterplot of LOD scores vs QTL peak locations (possibly with intervals) for multiple
traits.

Usage

plot_lodpeaks(peaks, map, chr = NULL, gap = NULL, intervals = FALSE, ...)

Data frame such as that produced by find_peaks()) containing columns chr,
pos, lodindex, and lodcolumn. May also contain columns ci_lo and ci_hi,
in which case intervals will be plotted.

Marker map, used to get chromosome lengths (and start and end positions).

Selected chromosomes to plot; a vector of character strings.

Gap between chromosomes. The default is 1% of the total genome length.
If TRUE and peaks contains QTL intervals, plot the intervals.

Additional graphics parameters

Arguments

peaks

map

chr

gap

intervals

...

Value

None.

Hidden graphics parameters

A number of graphics parameters can be passed via .... For example, bgcolor to control the back-
ground color and altbgcolor to control the background color on alternate chromosomes. These
are not included as formal parameters in order to avoid cluttering the function definition.

See Also

find_peaks(), plot_peaks()

plot_onegeno

Examples

93

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)
Xcovar <- get_x_covar(iron)

# perform genome scan
out <- scan1(probs, pheno, addcovar=covar, Xcovar=Xcovar)

# find peaks above lod=3.5 (and calculate 1.5-LOD support intervals)
peaks <- find_peaks(out, map, threshold=3.5, drop=1.5)

plot_lodpeaks(peaks, map)

plot_onegeno

Plot one individual’s genome-wide genotypes

Description

Plot one individual’s genome-wide genotypes

Usage

plot_onegeno(

geno,
map,
ind = 1,
chr = NULL,
col = NULL,
na_col = "white",
swap_axes = FALSE,
border = "black",
shift = FALSE,
chrwidth = 0.5,
...

)

94

Arguments

geno

map

ind

chr

col

na_col

swap_axes

border

shift

chrwidth

plot_onegeno

Imputed phase-known genotypes, as a list of matrices (as produced by maxmarg())
or a list of three-dimensional arrays (as produced by guess_phase()).

Marker map (a list of vectors of marker positions).

Individual to plot, either a numeric index or an ID.

Selected chromosomes to plot; a vector of character strings.

Vector of colors for the different genotypes.

Color for missing segments.

If TRUE, swap the axes, so that the chromosomes run horizontally.

Color of outer border around chromosome rectangles.

If TRUE, shift the chromosomes so they all start at 0.

Total width of rectangles for each chromosome, as a fraction of the distance
between them.

...

Additional graphics parameters

Value

None.

Hidden graphics parameters

A number of graphics parameters can be passed via .... For example, bgcolor to control the
background color. These are not included as formal parameters in order to avoid cluttering the
function definition.

Examples

# load data and calculate genotype probabilities
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
iron <- iron["146", ] # subset to individual 146
map <- insert_pseudomarkers(iron$gmap, step=1)
pr <- calc_genoprob(iron, map, error_prob=0.002)

# infer genotypes, as those with maximal marginal probability
m <- maxmarg(pr)

# guess phase
ph <- guess_phase(iron, m)

# plot phased genotypes
plot_onegeno(ph, map, shift=TRUE, col=c("slateblue", "Orchid"))

# this is more interesting for Diversity Outbred mouse data
## Not run:
file <- paste0("https://raw.githubusercontent.com/rqtl/",

"qtl2data/main/DOex/DOex.zip")

DOex <- read_cross2(file)

plot_peaks

95

# subset to individuals labeled "232" and "256"
DOex <- DOex[c("232", "256"), ]
pr <- calc_genoprob(DOex, error_prob=0.002)

# infer genotypes, as those with maximal marginal probability
m <- maxmarg(pr, minprob=0.5)
# guess phase
ph <- guess_phase(DOex, m)

# plot phased genotypes
plot_onegeno(ph, DOex$gmap, shift=TRUE)
plot_onegeno(ph, DOex$gmap, ind="256", shift=TRUE)

## End(Not run)

plot_peaks

Plot QTL peak locations

Description

Plot QTL peak locations (possibly with intervals) for multiple traits.

Usage

plot_peaks(
peaks,
map,
chr = NULL,
tick_height = 0.3,
gap = NULL,
lod_labels = FALSE,
...

)

Arguments

peaks

map

chr

tick_height

gap

Data frame such as that produced by find_peaks()) containing columns chr,
pos, lodindex, and lodcolumn. May also contain columns ci_lo and ci_hi,
in which case intervals will be plotted.

Marker map, used to get chromosome lengths (and start and end positions).

Selected chromosomes to plot; a vector of character strings.

Height of tick marks at the peaks (a number between 0 and 1).

Gap between chromosomes. The default is 1% of the total genome length.

96

lod_labels

plot_peaks

If TRUE, plot LOD scores near the intervals. Uses three hidden graphics param-
eters, label_gap (distance between CI and LOD text label), label_left (vec-
tor that indicates whether the labels should go on the left side; TRUE=on left,
FALSE=on right, NA=put into larger gap on that chromosome), and label_cex
that controls the size of these labels

...

Additional graphics parameters

Value

None.

Hidden graphics parameters

A number of graphics parameters can be passed via .... For example, bgcolor to control the back-
ground color and altbgcolor to control the background color on alternate chromosomes. These
are not included as formal parameters in order to avoid cluttering the function definition.

See Also

find_peaks(), plot_lodpeaks()

Examples

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)
Xcovar <- get_x_covar(iron)

# perform genome scan
out <- scan1(probs, pheno, addcovar=covar, Xcovar=Xcovar)

# find peaks above lod=3.5 (and calculate 1.5-LOD support intervals)
peaks <- find_peaks(out, map, threshold=3.5, drop=1.5)

plot_peaks(peaks, map)

# show LOD scores
plot_peaks(peaks, map, lod_labels=TRUE)

# show LOD scores, controlling whether they go on the left or right

plot_pxg

97

plot_peaks(peaks, map, lod_labels=TRUE,

label_left=c(TRUE, TRUE, TRUE, FALSE, TRUE, FALSE))

plot_pxg

Plot phenotype vs genotype

Description

Plot phenotype vs genotype for a single putative QTL and a single phenotype.

Usage

plot_pxg(
geno,
pheno,
sort = TRUE,
SEmult = NULL,
pooledSD = TRUE,
swap_axes = FALSE,
jitter = 0.2,
force_labels = TRUE,
alternate_labels = FALSE,
omit_points = FALSE,
...

)

Arguments

geno

pheno
sort
SEmult

pooledSD

swap_axes

jitter

force_labels
alternate_labels

Vector of genotypes, for example as produced by maxmarg() with specific chr
and pos.
Vector of phenotypes.
If TRUE, sort genotypes from largest to smallest.
If specified, interval estimates of the within-group averages will be displayed,
as mean +/- SE * SEmult.
If TRUE and SEmult is specified, calculated a pooled within-group SD. Other-
wise, get separate estimates of the within-group SD for each group.
If TRUE, swap the axes, so that the genotypes are on the y-axis and the pheno-
type is on the x-axis.
Amount to jitter the points horizontally, if a vector of length > 0, it is taken to
be the actual jitter amounts (with values between -0.5 and 0.5).
If TRUE, force all genotype labels to be shown.

omit_points

...

If TRUE, place genotype labels in two rows
If TRUE, omit the points, just plotting the averages (and, potentially, the +/- SE
intervals).
Additional graphics parameters, passed to plot().

98

Value

plot_pxg

(Invisibly) A matrix with rows being the genotype groups and columns for the means and (if SEmult
is specified) the SEs.

Hidden graphics parameters

A number of graphics parameters can be passed via .... For example, bgcolor to control the
background color, and seg_width, seg_lwd, and seg_col to control the lines at the confidence
intervals. Further, hlines, hlines_col, hlines_lwd, and hlines_lty to control the horizontal
grid lines. (Use hlines=NA to avoid plotting horizontal grid lines.) Similarly vlines, vlines_col,
vlines_lwd, and vlines_lty for vertical grid lines. These are not included as formal parameters
in order to avoid cluttering the function definition.

See Also

plot_coef()

Examples

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# inferred genotype at a 28.6 cM on chr 16
geno <- maxmarg(probs, map, chr=16, pos=28.6, return_char=TRUE)

# plot phenotype vs genotype
plot_pxg(geno, log10(iron$pheno[,1]), ylab=expression(log[10](Liver)))

# include +/- 2 SE intervals
plot_pxg(geno, log10(iron$pheno[,1]), ylab=expression(log[10](Liver)),

SEmult=2)

# plot just the means
plot_pxg(geno, log10(iron$pheno[,1]), ylab=expression(log[10](Liver)),

omit_points=TRUE)

# plot just the means +/- 2 SEs
plot_pxg(geno, log10(iron$pheno[,1]), ylab=expression(log[10](Liver)),

omit_points=TRUE, SEmult=2)

plot_scan1

99

plot_scan1

Plot a genome scan

Description

Plot LOD curves for a genome scan

Usage

plot_scan1(x, map, lodcolumn = 1, chr = NULL, add = FALSE, gap = NULL, ...)

## S3 method for class 'scan1'
plot(x, map, lodcolumn = 1, chr = NULL, add = FALSE, gap = NULL, ...)

An object of class "scan1", as output by scan1().
A list of vectors of marker positions, as produced by insert_pseudomarkers().

LOD score column to plot (a numeric index, or a character string for a column
name). Only one value allowed.

Selected chromosomes to plot; a vector of character strings.

If TRUE, add to current plot (must have same map and chromosomes).

Gap between chromosomes. The default is 1% of the total genome length.

Additional graphics parameters.

Arguments

x

map

lodcolumn

chr

add

gap

...

Value

None.

Hidden graphics parameters

A number of graphics parameters can be passed via .... For example, bgcolor to control the
background color and altbgcolor to control the background color on alternate chromosomes. col
controls the color of lines/curves; altcol can be used if you want alternative chromosomes in
different colors. These are not included as formal parameters in order to avoid cluttering the function
definition.

See Also

plot_coef(), plot_coefCC(), plot_snpasso()

100

Examples

plot_sdp

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)
Xcovar <- get_x_covar(iron)

# perform genome scan
out <- scan1(probs, pheno, addcovar=covar, Xcovar=Xcovar)

# plot the results for selected chromosomes
ylim <- c(0, maxlod(out)*1.02) # need to strip class to get overall max LOD
chr <- c(2,7,8,9,15,16)
plot(out, map, chr=chr, ylim=ylim)
plot(out, map, lodcolumn=2, chr=chr, col="violetred", add=TRUE)
legend("topleft", lwd=2, col=c("darkslateblue", "violetred"), colnames(out),

bg="gray90")

# plot just one chromosome
plot(out, map, chr=8, ylim=ylim)
plot(out, map, chr=8, lodcolumn=2, col="violetred", add=TRUE)

# lodcolumn can also be a column name
plot(out, map, lodcolumn="liver", ylim=ylim)
plot(out, map, lodcolumn="spleen", col="violetred", add=TRUE)

plot_sdp

plot strain distribution patterns for SNPs

Description

plot the strain distribution patterns of SNPs using tracks of tick-marks for each founder strain

Usage

plot_sdp(pos, sdp, strain_labels = names(qtl2::CCcolors), ...)

Arguments

pos

vector of SNP positions

plot_snpasso

101

sdp
strain_labels
...

vector of strain distribution patterns (as integers)
names of the strains
additional graphic arguments

Details

Additional arguments, such as xlab, ylab, xlim, and main, are passed via ...; also bgcolor to
control the color of the background, and col and lwd to control the color and thickness of the tick
marks.

Value

None.

See Also

calc_sdp(), invert_sdp()

Examples

n_tick <- 50
plot_sdp(runif(n_tick, 0, 100), sample(0:255, n_tick, replace=TRUE))

plot_snpasso

Plot SNP associations

Description

Plot SNP associations, with possible expansion from distinct snps to all snps.

Usage

plot_snpasso(

scan1output,
snpinfo,
genes = NULL,
lodcolumn = 1,
show_all_snps = TRUE,
chr = NULL,
add = FALSE,
drop_hilit = NA,
col_hilit = "violetred",
col = "darkslateblue",
gap = NULL,
minlod = 0,
sdp_panel = FALSE,
strain_labels = names(qtl2::CCcolors),
...

)

102

Arguments

plot_snpasso

scan1output

Output of scan1() using SNP probabilities derived by genoprob_to_snpprob().

snpinfo

Data frame with SNP information with the following columns (the last three are
generally derived from with index_snps()):

• chr - Character string or factor with chromosome
• pos - Position (in same units as in the "map" attribute in genoprobs.
• sdp - Strain distribution pattern: an integer, between 1 and 2n − 2 where
n is the number of strains, whose binary encoding indicates the founder
genotypes

• snp - Character string with SNP identifier (if missing, the rownames are

used).

• index - Indices that indicate equivalent groups of SNPs.
• intervals - Indexes that indicate which marker intervals the SNPs reside.
• on_map - Indicate whether SNP coincides with a marker in the genoprobs

Optional data frame containing gene information for the region, with columns
start and stop in Mbp, strand (as "-", "+", or NA), and Name. If included,
a two-panel plot is produced, with SNP associations above and gene locations
below.

genes

lodcolumn

LOD score column to plot (a numeric index, or a character string for a column
name). Only one value allowed.

show_all_snps

If TRUE, expand to show all SNPs.

chr

add

drop_hilit

Vector of character strings with chromosome IDs to plot.

If TRUE, add to current plot (must have same map and chromosomes).

SNPs with LOD score within this amount of the maximum SNP association will
be highlighted.

col_hilit

Color of highlighted points

col

gap

minlod

Color of other points

Gap between chromosomes. The default is 1% of the total genome length.

Minimum LOD to display. (Mostly for GWAS, in which case using minlod=1
will greatly increase the plotting speed, since the vast majority of points would
be omittted.

sdp_panel

Include a panel with the strain distribution patterns for the highlighted SNPs

strain_labels

Labels for the strains, if sdp_panel=TRUE.

...

Additional graphics parameters.

Value

None.

plot_snpasso

Hidden graphics parameters

103

A number of graphics parameters can be passed via .... For example, bgcolor to control the
background color,altbgcolor to control the background color on alternate chromosomes, altcol
to control the point color on alternate chromosomes, cex for character expansion for the points
(default 0.5), pch for the plotting character for the points (default 16), and ylim for y-axis limits. If
you are including genes and/or SDP panels, you can use panel_prop to control the relative heights
of the panels, from top to bottom.

See Also

plot_scan1(), plot_coef(), plot_coefCC()

Examples

## Not run:
# load example DO data from web
file <- paste0("https://raw.githubusercontent.com/rqtl/",

"qtl2data/main/DOex/DOex.zip")

DOex <- read_cross2(file)

# subset to chr 2
DOex <- DOex[,"2"]

# calculate genotype probabilities and convert to allele probabilities
pr <- calc_genoprob(DOex, error_prob=0.002)
apr <- genoprob_to_alleleprob(pr)

# query function for grabbing info about variants in region
snp_dbfile <- system.file("extdata", "cc_variants_small.sqlite", package="qtl2")
query_variants <- create_variant_query_func(snp_dbfile)

# SNP association scan
out_snps <- scan1snps(apr, DOex$pmap, DOex$pheno, query_func=query_variants,

chr=2, start=97, end=98, keep_all_snps=TRUE)

# plot results
plot_snpasso(out_snps$lod, out_snps$snpinfo)

# can also just type plot()
plot(out_snps$lod, out_snps$snpinfo)

# plot just subset of distinct SNPs
plot(out_snps$lod, out_snps$snpinfo, show_all_snps=FALSE)

# highlight the top snps (with LOD within 1.5 of max)
plot(out_snps$lod, out_snps$snpinfo, drop_hilit=1.5)

# query function for finding genes in region
gene_dbfile <- system.file("extdata", "mouse_genes_small.sqlite", package="qtl2")
query_genes <- create_gene_query_func(gene_dbfile)
genes <- query_genes(2, 97, 98)

104

predict_snpgeno

# plot SNP association results with gene locations
plot(out_snps$lod, out_snps$snpinfo, drop_hilit=1.5, genes=genes)

# plot SNP asso results with genes plus SDPs of highlighted SNPs
plot(out_snps$lod, out_snps$snpinfo, drop_hilit=2, genes=genes, sdp_panel=TRUE)

## End(Not run)

predict_snpgeno

Predict SNP genotypes

Description

Predict SNP genotypes in a multiparent population from inferred genotypes plus founder strains’
SNP alleles.

Usage

predict_snpgeno(cross, geno, cores = 1)

Arguments

cross

geno

cores

Value

Object of class "cross2". For details, see the R/qtl2 developer guide.
Imputed genotypes, as a list of matrices, as from maxmarg().
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

A list of matrices with inferred SNP genotypes, coded 1/2/3.

See Also

maxmarg(), viterbi(), calc_errorlod()

Examples

## Not run:
# load example data and calculate genotype probabilities
file <- paste0("https://raw.githubusercontent.com/rqtl/",

"qtl2data/main/DOex/DOex.zip")

DOex <- read_cross2(file)
probs <- calc_genoprob(DOex, error_prob=0.002)

# inferred genotypes
m <- maxmarg(probs, minprob=0.5)

print.cross2

105

# inferred SNP genotypes
inferg <- predict_snpgeno(DOex, m)

## End(Not run)

print.cross2

Print a cross2 object

Description

Print a summary of a cross2 object

Usage

## S3 method for class 'cross2'
print(x, ...)

Arguments

x

...

Value

None.

An object of class "cross2", as output by read_cross2(). For details, see the
R/qtl2 developer guide.

Ignored.

print.summary.scan1perm

Print summary of scan1perm permutations

Description

Print summary of scan1perm permutations

Usage

## S3 method for class 'summary.scan1perm'
print(x, digits = 3, ...)

Arguments

x

digits

...

Object of class "summary.scan1perm", as produced by summary_scan1perm().
Number of digits in printing significance thresholds; passed to base::print().
Ignored.

106

Details

probs_to_grid

This is to go with summary_scan1perm(), so that the summary output is printed in a nice format.
Generally not called directly, but it can be in order to control the number of digits that appear.

Value

Invisibly returns the input, x.

Examples

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)
Xcovar <- get_x_covar(iron)

# permutations with genome scan (just 3 replicates, for illustration)
operm <- scan1perm(probs, pheno, addcovar=covar, Xcovar=Xcovar,

n_perm=3)

print( summary(operm, alpha=c(0.20, 0.05)), digits=8 )

probs_to_grid

Subset genotype probability array to pseudomarkers on a grid

Description

Subset genotype probability array (from calc_genoprob() to a grid of pseudomarkers along each
chromosome.

Usage

probs_to_grid(probs, grid)

Arguments

probs
grid

Genotype probabilities as output from calc_genoprob() with stepwidth="fixed".
List of logical vectors that indicate which positions are on the grid and should
be retained.

pull_genoprobint

Details

107

This only works if calc_genoprob() was run with stepwidth="fixed", so that the genotype
probabilities were calculated at a grid of markers/pseudomarkers. When this is the case, we omit
all but the probabilities on this grid. Use calc_grid() to find the grid positions.

Value

An object of class "calc_genoprob", like the input, subset to just include pseudomarkers along a
grid. See calc_genoprob().

See Also

calc_grid(), map_to_grid()

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
map_w_pmar <- insert_pseudomarkers(grav2$gmap, step=1)
probs <- calc_genoprob(grav2, map_w_pmar, error_prob=0.002)
sapply(probs, dim)
grid <- calc_grid(grav2$gmap, step=1)
probs_sub <- probs_to_grid(probs, grid)
sapply(probs_sub, dim)

pull_genoprobint

Pull genotype probabilities for an interval

Description

Pull out the genotype probabilities for a given genomic interval

Usage

pull_genoprobint(genoprobs, map, chr, interval)

Arguments

genoprobs

Genotype probabilities as calculated by calc_genoprob().

map

chr

The marker map for the genotype probabilities

Chromosome ID (single character sting)

interval

Interval (pair of numbers)

Value

A list containing a single 3d array of genotype probabilities, like the input genoprobs but for the
designated interval.

pull_genoprobpos

108

See Also

find_marker(), pull_genoprobpos()

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

gmap <- insert_pseudomarkers(iron$gmap, step=1)
pr <- calc_genoprob(iron, gmap, error_prob=0.002)

pr_sub <- pull_genoprobint(pr, gmap, "8", c(25, 35))

pull_genoprobpos

Pull genotype probabilities for a particular position

Description

Pull out the genotype probabilities for a particular position (by name)

Usage

pull_genoprobpos(genoprobs, map = NULL, chr = NULL, pos = NULL, marker = NULL)

Arguments

genoprobs

map

chr

pos

marker

Details

Genotype probabilities as calculated by calc_genoprob().
A map object: a list (corresponding to chromosomes) of vectors of marker po-
sitions. Can also be a snpinfo object (data frame with columns chr and pos;
marker names taken from column snp or if that doesn’t exist from the row
names)

A chromosome ID

A numeric position

A single character string with the name of the position to pull out.

Provide either a marker/pseudomarker name (with the argument marker) or all of map, chr, and
pos.

Value

A matrix of genotype probabilities for the specified position.

See Also

find_marker(), fit1(), pull_genoprobint()

pull_markers

Examples

109

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

gmap <- insert_pseudomarkers(iron$gmap, step=1)
pr <- calc_genoprob(iron, gmap, error_prob=0.002)

pmar <- find_marker(gmap, 8, 40)
pr_8_40 <- pull_genoprobpos(pr, pmar)

pr_8_40_alt <- pull_genoprobpos(pr, gmap, 8, 40)

pull_markers

Drop all but a specified set of markers

Description

Drop all markers from a cross2 object expect those in a specified vector.

Usage

pull_markers(cross, markers)

Arguments

cross

markers

Value

Object of class "cross2". For details, see the R/qtl2 developer guide.

A vector of marker names.

The input cross with only the specified markers.

See Also

drop_markers(), drop_nullmarkers()

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
markers2drop <- c("BH.342C/347L-Col", "GH.94L", "EG.357C/359L-Col", "CD.245L", "ANL2")
grav2_rev <- pull_markers(grav2, markers2drop)

110

rbind.calc_genoprob

qtl2version

Installed version of R/qtl2

Description

Get installed version of R/qtl2

Usage

qtl2version()

Value

A character string with the installed version of the R/qtl2 package.

Examples

qtl2version()

rbind.calc_genoprob

Join genotype probabilities for different individuals

Description

Join multiple genotype probability objects, as produced by calc_genoprob(), for the same set of
markers and genotypes but for different individuals.

Usage

## S3 method for class 'calc_genoprob'
rbind(...)

Arguments

...

Value

Genotype probability objects as produced by calc_genoprob(). Must have the
same set of markers and genotypes.

An object of class "calc_genoprob", like the input; see calc_genoprob().

See Also

cbind.calc_genoprob()

rbind.scan1

Examples

111

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
map <- insert_pseudomarkers(grav2$gmap, step=1)
probsA <- calc_genoprob(grav2[1:5,], map, error_prob=0.002)
probsB <- calc_genoprob(grav2[6:12,], map, error_prob=0.002)
probs <- rbind(probsA, probsB)

rbind.scan1

Join genome scan results for different chromosomes.

Description

Join multiple scan1() results for different chromosomes; must have the same set of lod score
column.

Usage

## S3 method for class 'scan1'
rbind(...)

Arguments

...

Details

Genome scan objects of class "scan1", as produced by scan1(). Must have the
same lod score columns.

If components addcovar, Xcovar, intcovar, weights, sample_size do not match between ob-
jects, we omit this information.

If hsq present, we simply rbind() the contents.

Value

An object of class ‘"scan1", like the inputs, but with the results for different sets of chromosomes
combined.

See Also

cbind.scan1(), scan1()

112

Examples

rbind.scan1perm

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
map <- insert_pseudomarkers(grav2$gmap, step=1)
probs <- calc_genoprob(grav2, map, error_prob=0.002)
phe <- grav2$pheno[,1,drop=FALSE]

out1 <- scan1(probs[,1], phe) # chr 1
out2 <- scan1(probs[,5], phe) # chr 5
out <- rbind(out1, out2)

rbind.scan1perm

Combine data from scan1perm objects

Description

Row-bind multiple scan1perm objects with the same set of columns

Usage

## S3 method for class 'scan1perm'
rbind(...)

## S3 method for class 'scan1perm'
c(...)

Arguments

...

Details

A set of permutation results from scan1perm() (objects of class "scan1perm").
They must have the same set of columns. If any include autosome/X chromosome-
specific permutations, they must all be such.

The aim of this function is to concatenate the results from multiple runs of a permutation test
with scan1perm(), to assist in the case that such permutations are done on multiple processors in
parallel.

Value

The combined row-binded input, as an object of class "scan1perm"; see scan1perm().

See Also

cbind.scan1perm(), scan1perm(), scan1()

rbind.sim_geno

Examples

113

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)
Xcovar <- get_x_covar(iron)

# permutations with genome scan (just 3 replicates, for illustration)
operm1 <- scan1perm(probs, pheno, addcovar=covar, Xcovar=Xcovar, n_perm=3)
operm2 <- scan1perm(probs, pheno, addcovar=covar, Xcovar=Xcovar, n_perm=3)

operm <- rbind(operm1, operm2)

rbind.sim_geno

Join genotype imputations for different individuals

Description

Join multiple genotype imputation objects, as produced by sim_geno(), for the same set of markers
but for different individuals.

Usage

## S3 method for class 'sim_geno'
rbind(...)

Arguments

...

Value

Genotype imputation objects as produced by sim_geno(). Must have the same
set of markers and genotypes.

An object of class "sim_geno", like the input; see sim_geno().

See Also

cbind.sim_geno(), sim_geno()

114

Examples

rbind.viterbi

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
map <- insert_pseudomarkers(grav2$gmap, step=1)
drawsA <- sim_geno(grav2[1:5,], map, error_prob=0.002, n_draws=4)
drawsB <- sim_geno(grav2[6:12,], map, error_prob=0.002, n_draws=4)
draws <- rbind(drawsA, drawsB)

rbind.viterbi

Join Viterbi results for different individuals

Description

Join multiple imputed genotype objects, as produced by viterbi(), for the same set of markers but
for different individuals.

Usage

## S3 method for class 'viterbi'
rbind(...)

Arguments

...

Value

Imputed genotype objects as produced by viterbi(). Must have the same set
of markers.

An object of class "viterbi", like the input; see viterbi().

See Also

cbind.viterbi(), viterbi()

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
map <- insert_pseudomarkers(grav2$gmap, step=1)
gA <- viterbi(grav2[1:5,], map, error_prob=0.002)
gB <- viterbi(grav2[6:12,], map, error_prob=0.002)
g <- rbind(gA, gB)

read_cross2

115

read_cross2

Read QTL data from files

Description

Read QTL data from a set of files

Usage

read_cross2(file, quiet = TRUE)

Arguments

file

quiet

Details

Character string with path to the YAML or JSON file containing all of the control
information. This could instead be a zip file containing all of the data files, in
which case the contents are unzipped to a temporary directory and then read.
If FALSE, print progress messages.

A control file in YAML or JSON format contains information about basic parameters as well as the
names of the series of data files to be read. See the sample data files and the vignette describing the
input file format.

Value

Object of class "cross2". For details, see the R/qtl2 developer guide.

See Also

read_pheno(), write_control_file(), sample data files at https://kbroman.org/qtl2/pages/
sampledata.html and https://github.com/rqtl/qtl2data

Examples

## Not run:
yaml_file <- "https://kbroman.org/qtl2/assets/sampledata/grav2/grav2.yaml"
grav2 <- read_cross2(yaml_file)

## End(Not run)
zip_file <- system.file("extdata", "grav2.zip", package="qtl2")
grav2 <- read_cross2(zip_file)

116

read_pheno

read_pheno

Read phenotype data

Description

Read phenotype data from a CSV file (and, optionally, phenotype covariate data from a separate
CSV file). The CSV files may be contained in zip files, separately or together.

Usage

read_pheno(
file,
phenocovarfile = NULL,
sep = ",",
na.strings = c("-", "NA"),
comment.char = "#",
transpose = FALSE,
quiet = TRUE

)

Arguments

file

Character string with path to the phenotype data file (or a zip file containing both
the phenotype and phenotype covariate files).

phenocovarfile Character string with path to the phenotype covariate file. This can be a separate
CSV or zip file; if a zip file, it must contain exactly one CSV file. Alternatively,
if the file argument indicates a zip file that contains two files (phenotypes and
phenotype covariates), then this phenocovarfile argument must indicate the
base name for the phenotype covariate file.

sep

na.strings

comment.char

transpose

quiet

the field separator character
a character vector of strings which are to be interpreted as NA values.
A character vector of length one containing a single character to denote com-
ments within the CSV files.

If TRUE, the phenotype data will be transposed. The phenotype covariate infor-
mation is never transposed.
If FALSE, print progress messages.

Value

Either a matrix of phenotype data, or a list containing pheno (phenotype matrix) and phenocovar
(phenotype covariate matrix).

See Also

read_cross2(), sample data files at https://kbroman.org/qtl2/pages/sampledata.html and
https://github.com/rqtl/qtl2data

117

recode_snps

Examples

## Not run:
file <- paste0("https://raw.githubusercontent.com/rqtl/",

"qtl2data/main/Gough/gough_pheno.csv")

phe <- read_pheno(file)

phecovfile <- paste0("https://raw.githubusercontent.com/rqtl/",
"qtl2data/main/Gough/gough_phenocovar.csv")

phe_list <- read_pheno(file, phecovfile)

## End(Not run)

recode_snps

Recode SNPs by major allele

Description

For multi-parent populations with founder genotypes, recode the raw SNP genotypes so that 1
means homozygous for the major allele in the founders.

Usage

recode_snps(cross)

Arguments

cross

Value

Object of class "cross2". For details, see the R/qtl2 developer guide.

The input cross object with the raw SNP genotypes recoded so that 1 is homozygous for the major
alleles in the founders.

See Also

calc_raw_founder_maf(), calc_raw_maf()

Examples

## Not run:
# load example data and calculate genotype probabilities
file <- paste0("https://raw.githubusercontent.com/rqtl/",

"qtl2data/main/DOex/DOex.zip")

DOex <- read_cross2(file)
DOex <- recode_snps(DOex)

## End(Not run)

118

reduce_markers

reduce_map_gaps

Reduce the lengths of gaps in a map

Description

Reduce the lengths of gaps in a map

Usage

reduce_map_gaps(map, min_gap = 50)

Arguments

map

Genetic map as a list of vectors (each vector is a chromosome and contains the
marker positions).

min_gap

Minimum gap length to return.

Value

Input map with any gaps greater than min_gap reduced to min_gap.

See Also

find_map_gaps()

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
rev_map <- reduce_map_gaps(iron$gmap, 30)

reduce_markers

Reduce markers to a subset of more-evenly-spaced ones

Description

Find the largest subset of markers such that no two adjacent markers are separated by less than some
distance.

reduce_markers

Usage

reduce_markers(

map,
min_distance = 1,
weights = NULL,
max_batch = 10000,
batch_distance_mult = 1,
cores = 1

119

)

Arguments

map

A list with each component being a vector with the marker positions for a chro-
mosome.

min_distance Minimum distance between markers.
weights

A (optional) list of weights on the markers; same size as map.

max_batch
batch_distance_mult

Maximum number of markers to consider in a batch

If working with batches of markers, reduce min_distance by this multiple.
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

cores

Details

Uses a dynamic programming algorithm to find, for each chromosome, the subset of markers for
with max(weights) is maximal, subject to the constraint that no two adjacent markers may be
separated by more than min_distance.

The computation time for the algorithm grows with like the square of the number of markers, like
1 sec for 10k markers but 30 sec for 50k markers. If the number of markers on a chromosome is
greater than max_batch, the markers are split into batches and the algorithm applied to each batch
with min_distance smaller by a factor min_distance_mult, and then merged together for one last
pass.

Value

A list like the input map, but with the selected subset of markers.

References

Broman KW, Weber JL (1999) Method for constructing confidently ordered linkage maps. Genet
Epidemiol 16:337–343

See Also

find_dup_markers(), drop_markers()

120

Examples

replace_ids

# read data
grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))

# grab genetic map
gmap <- grav2$gmap

# subset to markers that are >= 1 cM apart
gmap_sub <- reduce_markers(gmap, 1)

# drop all of the other markers from the cross
markers2keep <- unlist(lapply(gmap_sub, names))
grav2_sub <- pull_markers(grav2, markers2keep)

replace_ids

Replace individual IDs

Description

Replace the individual IDs in an object with new ones

Usage

replace_ids(x, ids)

## S3 method for class 'cross2'
replace_ids(x, ids)

## S3 method for class 'calc_genoprob'
replace_ids(x, ids)

## S3 method for class 'viterbi'
replace_ids(x, ids)

## S3 method for class 'sim_geno'
replace_ids(x, ids)

## S3 method for class 'matrix'
replace_ids(x, ids)

## S3 method for class 'data.frame'
replace_ids(x, ids)

Arguments

x

ids

Object whose IDs will be replaced

Vector of character strings with the new individual IDs, with the names being
the original IDs.

121

scale_kinship

Value

The input x object, but with individual IDs replaced.

Methods (by class)

• replace_ids(cross2): Replace IDs in a "cross2" object
• replace_ids(calc_genoprob): Replace IDs in output from calc_genoprob()
• replace_ids(viterbi): Replace IDs in output from viterbi()
• replace_ids(sim_geno): Replace IDs in output from sim_geno()
• replace_ids(matrix): Replace IDs in a matrix
• replace_ids(data.frame): Replace IDs in a data frame

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
ids <- as.numeric(ind_ids(iron))

# replace the numeric IDs with IDs like "mouse003"
new_ids <- setNames( sprintf("mouse%03d", as.numeric(ids)), ids)

iron <- replace_ids(iron, new_ids)

scale_kinship

Scale kinship matrix

Description

Scale kinship matrix to be like a correlation matrix.

Usage

scale_kinship(kinship)

Arguments

kinship

A kinship matrix, or a list of such in the case of the "leave one chromosome out"
method, as calculated by calc_kinship().

Details

We take cij = kij/(cid:112)kiikjj

Value

A matrix or list of matrices, as with the input, but with the matrices scaled to be like correlation
matrices.

122

Examples

scan1

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
map <- insert_pseudomarkers(grav2$gmap, step=1)
probs <- calc_genoprob(grav2, map, error_prob=0.002)
K <- calc_kinship(probs)
Ka <- scale_kinship(K)

scan1

Genome scan with a single-QTL model

Description

Genome scan with a single-QTL model by Haley-Knott regression or a linear mixed model, with
possible allowance for covariates.

Usage

scan1(

genoprobs,
pheno,
kinship = NULL,
addcovar = NULL,
Xcovar = NULL,
intcovar = NULL,
weights = NULL,
reml = TRUE,
model = c("normal", "binary"),
hsq = NULL,
cores = 1,
...

)

Arguments

genoprobs

pheno

kinship

addcovar

Xcovar

intcovar

weights

reml

Genotype probabilities as calculated by calc_genoprob().
A numeric matrix of phenotypes, individuals x phenotypes.

Optional kinship matrix, or a list of kinship matrices (one per chromosome), in
order to use the LOCO (leave one chromosome out) method.

An optional numeric matrix of additive covariates.

An optional numeric matrix with additional additive covariates used for null
hypothesis when scanning the X chromosome.

An numeric optional matrix of interactive covariates.

An optional numeric vector of positive weights for the individuals. As with the
other inputs, it must have names for individual identifiers.
If kinship provided: if reml=TRUE, use REML; otherwise maximum likelihood.

scan1

model

hsq

cores

...

Details

123

Indicates whether to use a normal model (least squares) or binary model (logistic
regression) for the phenotype. If model="binary", the phenotypes must have
values in [0, 1].
Considered only if kinship is provided, in which case this is taken as the as-
sumed value for the residual heritability. It should be a vector with length corre-
sponding to the number of columns in pheno, or (if kinship corresponds to a list
of LOCO kinship matrices) a matrix with dimension length(kinship) x ncol(pheno).
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().
Additional control parameters; see Details.

We first fit the model y = Xβ + ϵ where X is a matrix of covariates (or just an intercept) and ϵ
is multivariate normal with mean 0 and covariance matrix σ2[h2(2K) + I] where K is the kinship
matrix and I is the identity matrix.
We then take h2 as fixed and then scan the genome, at each genomic position fitting the model
y = P α+Xβ +ϵ where P is a matrix of genotype probabilities for the current position and again X
is a matrix of covariates ϵ is multivariate normal with mean 0 and covariance matrix σ2[h2(2K)+I],
taking h2 to be known.
Note that if weights are provided, the covariance matrix becomes σ2[h2(2K) + D] where D is a
diagonal matrix with the reciprocal of the weights.

For each of the inputs, the row names are used as individual identifiers, to align individuals. The
genoprobs object should have a component "is_x_chr" that indicates which of the chromosomes
is the X chromosome, if any.
The ... argument can contain several additional control parameters; suspended for simplicity (or
confusion, depending on your point of view). tol is used as a tolerance value for linear regres-
sion by QR decomposition (in determining whether columns are linearly dependent on others and
should be omitted); default 1e-12. intcovar_method indicates whether to use a high-memory (but
potentially faster) method or a low-memory (and possibly slower) method, with values "highmem"
or "lowmem"; default "lowmem". max_batch indicates the maximum number of phenotypes to run
together; default is unlimited. maxit is the maximum number of iterations for converence of the
iterative algorithm used when model=binary. bintol is used as a tolerance for converence for
the iterative algorithm used when model=binary. eta_max is the maximum value for the "linear
predictor" in the case model="binary" (a bit of a technicality to avoid fitted values exactly at 0 or
1).
If kinship is absent, Haley-Knott regression is performed. If kinship is provided, a linear mixed
model is used, with a polygenic effect estimated under the null hypothesis of no (major) QTL, and
then taken as fixed as known in the genome scan.
If kinship is a single matrix, then the hsq in the results is a vector of heritabilities (one value
If kinship is a list (one matrix per chromosome), then hsq is a matrix,
for each phenotype).
chromosomes x phenotypes.

Value

An object of class "scan1": a matrix of LOD scores, positions x phenotypes. Also contains one or
more of the following attributes:

124

scan1

• sample_size - Vector of sample sizes used for each phenotype

• hsq - Included if kinship provided: A matrix of estimated heritabilities under the null hy-
If the "loco" method was used with
pothesis of no QTL. Columns are the phenotypes.
calc_kinship() to calculate a list of kinship matrices, one per chromosome, the rows of
hsq will be the heritabilities for the different chromosomes (well, leaving out each one). If
Xcovar was not NULL, there will at least be an autosome and X chromosome row.

References

Haley CS, Knott SA (1992) A simple regression method for mapping quantitative trait loci in line
crosses using flanking markers. Heredity 69:315–324.

Kang HM, Zaitlen NA, Wade CM, Kirby A, Heckerman D, Daly MJ, Eskin E (2008) Efficient
control of population structure in model organism association mapping. Genetics 178:1709–1723.

See Also

scan1perm(), scan1coef(), cbind.scan1(), rbind.scan1(), scan1max()

Examples

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)
Xcovar <- get_x_covar(iron)

# perform genome scan
out <- scan1(probs, pheno, addcovar=covar, Xcovar=Xcovar)

# leave-one-chromosome-out kinship matrices
kinship <- calc_kinship(probs, "loco")

# genome scan with a linear mixed model
out_lmm <- scan1(probs, pheno, kinship, covar, Xcovar)

scan1blup

125

scan1blup

Calculate BLUPs of QTL effects in scan along one chromosome

Description

Calculate BLUPs of QTL effects in scan along one chromosome, with a single-QTL model treating
the QTL effects as random, with possible allowance for covariates and for a residual polygenic
effect.

Usage

scan1blup(

genoprobs,
pheno,
kinship = NULL,
addcovar = NULL,
nullcovar = NULL,
contrasts = NULL,
se = FALSE,
reml = TRUE,
tol = 0.000000000001,
cores = 1,
quiet = TRUE

)

Arguments

genoprobs

pheno

kinship

addcovar

nullcovar

contrasts

se

reml

Genotype probabilities as calculated by calc_genoprob().
A numeric vector of phenotype values (just one phenotype, not a matrix of them)

Optional kinship matrix, or a list of kinship matrices (one per chromosome), in
order to use the LOCO (leave one chromosome out) method.

An optional numeric matrix of additive covariates.

An optional numeric matrix of additional additive covariates that are used under
the null hypothesis (of no QTL) but not under the alternative (with a QTL).
This is needed for the X chromosome, where we might need sex as a additive
covariate under the null hypothesis, but we wouldn’t want to include it under the
alternative as it would be collinear with the QTL effects. Only used if kinship
is provided but hsq is not, to get estimate of residual heritability.
An optional numeric matrix of genotype contrasts, size genotypes x genotypes.
For an intercross, you might use cbind(mu=c(1,0,0), a=c(-1, 0, 1), d=c(0,
1, 0)) to get mean, additive effect, and dominance effect. The default is the
identity matrix.

If TRUE, also calculate the standard errors.
If reml=TRUE, use REML to estimate variance components; otherwise maximum
likelihood.

126

tol

cores

quiet

Details

scan1blup

Tolerance value for convergence of linear mixed model fit.
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().
If FALSE, print message about number of cores used when multi-core.

For each of the inputs, the row names are used as individual identifiers, to align individuals.
If kinship is provided, the linear mixed model accounts for a residual polygenic effect, with a the
polygenic variance estimated under the null hypothesis of no (major) QTL, and then taken as fixed
as known in the scan to estimate QTL effects.
If contrasts is provided, the genotype probability matrix, P , is post-multiplied by the contrasts
matrix, A, prior to fitting the model. So we use P · A as the X matrix in the model. One might view
the rows of A−1 as the set of contrasts, as the estimated effects are the estimated genotype effects
pre-multiplied by A−1.

Value

An object of class "scan1coef": a matrix of estimated regression coefficients, of dimension posi-
tions x number of effects. The number of effects is n_genotypes + n_addcovar. May also contain
the following attributes:

• SE - Present if se=TRUE: a matrix of estimated standard errors, of same dimension as coef.
• sample_size - Vector of sample sizes used for each phenotype

References

Haley CS, Knott SA (1992) A simple regression method for mapping quantitative trait loci in line
crosses using flanking markers. Heredity 69:315–324.

Kang HM, Zaitlen NA, Wade CM, Kirby A, Heckerman D, Daly MJ, Eskin E (2008) Efficient
control of population structure in model organism association mapping. Genetics 178:1709–1723.

Robinson GK (1991) That BLUP is a good thing: The estimation of random effects. Statist Sci
6:15–32.

Examples

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# convert to allele probabilities
aprobs <- genoprob_to_alleleprob(probs)

scan1coef

127

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno[,1]
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)

# calculate BLUPs of coefficients for chromosome 7
blup <- scan1blup(aprobs[,"7"], pheno, addcovar=covar)

# leave-one-chromosome-out kinship matrix for chr 7
kinship7 <- calc_kinship(probs, "loco")[["7"]]

# calculate BLUPs of coefficients for chromosome 7, adjusting for residual polygenic effect
blup_pg <- scan1blup(aprobs[,"7"], pheno, kinship7, addcovar=covar)

scan1coef

Calculate QTL effects in scan along one chromosome

Description

Calculate QTL effects in scan along one chromosome with a single-QTL model using Haley-Knott
regression or a linear mixed model (the latter to account for a residual polygenic effect), with pos-
sible allowance for covariates.

Usage

scan1coef(

genoprobs,
pheno,
kinship = NULL,
addcovar = NULL,
nullcovar = NULL,
intcovar = NULL,
weights = NULL,
contrasts = NULL,
model = c("normal", "binary"),
zerosum = TRUE,
se = FALSE,
hsq = NULL,
reml = TRUE,
...

)

Arguments

genoprobs

pheno

Genotype probabilities as calculated by calc_genoprob().
A numeric vector of phenotype values (just one phenotype, not a matrix of them)

128

kinship

addcovar

nullcovar

intcovar

weights

contrasts

model

zerosum

se

hsq

reml

...

Details

scan1coef

Optional kinship matrix, or a list of kinship matrices (one per chromosome), in
order to use the LOCO (leave one chromosome out) method.

An optional numeric matrix of additive covariates.

An optional numeric matrix of additional additive covariates that are used under
the null hypothesis (of no QTL) but not under the alternative (with a QTL).
This is needed for the X chromosome, where we might need sex as a additive
covariate under the null hypothesis, but we wouldn’t want to include it under the
alternative as it would be collinear with the QTL effects. Only used if kinship
is provided but hsq is not, to get estimate of residual heritability.

An optional numeric matrix of interactive covariates.

An optional numeric vector of positive weights for the individuals. As with the
other inputs, it must have names for individual identifiers.

An optional numeric matrix of genotype contrasts, size genotypes x genotypes.
For an intercross, you might use cbind(mu=c(1,1,1), a=c(-1, 0, 1), d=c(0,
1, 0)) to get mean, additive effect, and dominance effect. The default is the
identity matrix.

Indicates whether to use a normal model (least squares) or binary model (logistic
regression) for the phenotype. If model="binary", the phenotypes must have
values in [0, 1].

If TRUE, force the genotype or allele coefficients sum to 0 by subtracting their
mean and add another column with the mean. Ignored if contrasts is provided.

If TRUE, also calculate the standard errors.
(Optional) residual heritability; used only if kinship provided.
If kinship provided: if reml=TRUE, use REML; otherwise maximum likelihood.

Additional control parameters; see Details;

For each of the inputs, the row names are used as individual identifiers, to align individuals.
If kinship is absent, Haley-Knott regression is performed. If kinship is provided, a linear mixed
model is used, with a polygenic effect estimated under the null hypothesis of no (major) QTL, and
then taken as fixed as known in the genome scan.
If contrasts is provided, the genotype probability matrix, P , is post-multiplied by the contrasts
matrix, A, prior to fitting the model. So we use P · A as the X matrix in the model. One might view
the rows of A−1 as the set of contrasts, as the estimated effects are the estimated genotype effects
pre-multiplied by A−1.
The ... argument can contain several additional control parameters; suspended for simplicity (or
confusion, depending on your point of view). tol is used as a tolerance value for linear regression
by QR decomposition (in determining whether columns are linearly dependent on others and should
be omitted); default 1e-12. maxit is the maximum number of iterations for converence of the
iterative algorithm used when model=binary. bintol is used as a tolerance for converence for
the iterative algorithm used when model=binary. eta_max is the maximum value for the "linear
predictor" in the case model="binary" (a bit of a technicality to avoid fitted values exactly at 0 or
1).

scan1max

Value

129

An object of class "scan1coef": a matrix of estimated regression coefficients, of dimension posi-
tions x number of effects. The number of effects is n_genotypes + n_addcovar + (n_genotypes-1)*n_intcovar.
May also contain the following attributes:

• SE - Present if se=TRUE: a matrix of estimated standard errors, of same dimension as coef.
• sample_size - Vector of sample sizes used for each phenotype

References

Haley CS, Knott SA (1992) A simple regression method for mapping quantitative trait loci in line
crosses using flanking markers. Heredity 69:315–324.

Kang HM, Zaitlen NA, Wade CM, Kirby A, Heckerman D, Daly MJ, Eskin E (2008) Efficient
control of population structure in model organism association mapping. Genetics 178:1709–1723.

Examples

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno[,1]
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)

# calculate coefficients for chromosome 7
coef <- scan1coef(probs[,"7"], pheno, addcovar=covar)

# leave-one-chromosome-out kinship matrix for chr 7
kinship7 <- calc_kinship(probs, "loco")[["7"]]

# calculate coefficients for chromosome 7, adjusting for residual polygenic effect
coef_pg <- scan1coef(probs[,"7"], pheno, kinship7, addcovar=covar)

scan1max

Maximum LOD score from genome scan with a single-QTL model

Description

Maximum LOD score from genome scan with a single-QTL model by Haley-Knott regression or a
linear mixed model, with possible allowance for covariates.

scan1max

130

Usage

scan1max(

genoprobs,
pheno,
kinship = NULL,
addcovar = NULL,
Xcovar = NULL,
intcovar = NULL,
weights = NULL,
reml = TRUE,
model = c("normal", "binary"),
hsq = NULL,
by_chr = FALSE,
cores = 1,
...

)

Arguments

genoprobs
pheno
kinship

addcovar
Xcovar

intcovar
weights

reml
model

hsq

by_chr
cores

...

Details

Genotype probabilities as calculated by calc_genoprob().
A numeric matrix of phenotypes, individuals x phenotypes.
Optional kinship matrix, or a list of kinship matrices (one per chromosome), in
order to use the LOCO (leave one chromosome out) method.
An optional numeric matrix of additive covariates.
An optional numeric matrix with additional additive covariates used for null
hypothesis when scanning the X chromosome.
An numeric optional matrix of interactive covariates.
An optional numeric vector of positive weights for the individuals. As with the
other inputs, it must have names for individual identifiers.
If kinship provided: if reml=TRUE, use REML; otherwise maximum likelihood.
Indicates whether to use a normal model (least squares) or binary model (logistic
regression) for the phenotype. If model="binary", the phenotypes must have
values in [0, 1].
Considered only if kinship is provided, in which case this is taken as the as-
sumed value for the residual heritability. It should be a vector with length corre-
sponding to the number of columns in pheno, or (if kinship corresponds to a list
of LOCO kinship matrices) a matrix with dimension length(kinship) x ncol(pheno).
If TRUE, save the individual chromosome maxima.
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().
Additional control parameters; see Details.

Equivalent to running scan1() and then saving the column maxima, with some savings in memory
usage.

scan1perm

Value

131

Either a vector of genome-wide maximum LOD scores, or if by_chr is TRUE, a matrix with the
chromosome-specific maxima, with the rows being the chromosomes and the columns being the
phenotypes.

See Also

scan1(), scan1perm()

Examples

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)
Xcovar <- get_x_covar(iron)

# perform genome scan
out <- scan1max(probs, pheno, addcovar=covar, Xcovar=Xcovar)

scan1perm

Permutation test for genome scan with a single-QTL model

Description

Permutation test for a enome scan with a single-QTL model by Haley-Knott regression or a linear
mixed model, with possible allowance for covariates.

Usage

scan1perm(

genoprobs,
pheno,
kinship = NULL,
addcovar = NULL,
Xcovar = NULL,
intcovar = NULL,

132

scan1perm

weights = NULL,
reml = TRUE,
model = c("normal", "binary"),
n_perm = 1,
perm_Xsp = FALSE,
perm_strata = NULL,
chr_lengths = NULL,
cores = 1,
...

)

Arguments

genoprobs

Genotype probabilities as calculated by calc_genoprob().

pheno

kinship

addcovar

Xcovar

intcovar

weights

reml

model

n_perm

perm_Xsp

perm_strata

chr_lengths

cores

...

Details

A numeric matrix of phenotypes, individuals x phenotypes.

Optional kinship matrix, or a list of kinship matrices (one per chromosome), in
order to use the LOCO (leave one chromosome out) method.

An optional numeric matrix of additive covariates.

An optional numeric matrix with additional additive covariates used for null
hypothesis when scanning the X chromosome.

An optional numeric matrix of interactive covariates.

An optional numeric vector of positive weights for the individuals. As with the
other inputs, it must have names for individual identifiers.
If kinship provided: if reml=TRUE, use REML; otherwise maximum likelihood.

Indicates whether to use a normal model (least squares) or binary model (logistic
regression) for the phenotype. If model="binary", the phenotypes must have
values in [0, 1].

Number of permutation replicates.

If TRUE, do separate permutations for the autosomes and the X chromosome.

Vector of strata, for a stratified permutation test. Should be named in the same
way as the rows of pheno. The unique values define the strata.
Lengths of the chromosomes; needed only if perm_Xsp=TRUE. See chr_lengths().
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

Additional control parameters; see Details.

If kinship is not provided, so that analysis proceeds by Haley-Knott regression, we permute the
rows of the phenotype data; the same permutations are also applied to the rows of the covariates
(addcovar, Xcovar, and intcovar) are permuted.
If kinship is provided, we instead permute the rows of the genotype data and fit an LMM with the
same residual heritability (estimated under the null hypothesis of no QTL).

scan1perm

133

If Xcovar is provided and perm_strata=NULL, we do a stratified permutation test with the strata
defined by the rows of Xcovar. If a simple permutation test is desired, provide perm_strata that is
a vector containing a single repeated value.
The ... argument can contain several additional control parameters; suspended for simplicity (or
confusion, depending on your point of view). tol is used as a tolerance value for linear regression
by QR decomposition (in determining whether columns are linearly dependent on others and should
be omitted); default 1e-12. maxit is the maximum number of iterations for converence of the
iterative algorithm used when model=binary. bintol is used as a tolerance for converence for
the iterative algorithm used when model=binary. eta_max is the maximum value for the "linear
predictor" in the case model="binary" (a bit of a technicality to avoid fitted values exactly at 0 or
1).

Value

If perm_Xsp=FALSE, the result is matrix of genome-wide maximum LOD scores, permutation repli-
cates x phenotypes. If perm_Xsp=TRUE, the result is a list of two matrices, one for the autosomes
and one for the X chromosome. The object is given class "scan1perm".

References

Churchill GA, Doerge RW (1994) Empirical threshold values for quantitative trait mapping. Genet-
ics 138:963–971.

Manichaikul A, Palmer AA, Sen S, Broman KW (2007) Significance thresholds for quantitative
trait locus mapping under selective genotyping. Genetics 177:1963–1966.

Haley CS, Knott SA (1992) A simple regression method for mapping quantitative trait loci in line
crosses using flanking markers. Heredity 69:315–324.

Kang HM, Zaitlen NA, Wade CM, Kirby A, Heckerman D, Daly MJ, Eskin E (2008) Efficient
control of population structure in model organism association mapping. Genetics 178:1709–1723.

See Also

scan1(), chr_lengths(), mat2strata()

Examples

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)

134

scan1snps

Xcovar <- get_x_covar(iron)

# strata for permutations
perm_strata <- mat2strata(Xcovar)

# permutations with genome scan (just 3 replicates, for illustration)
operm <- scan1perm(probs, pheno, addcovar=covar, Xcovar=Xcovar,

n_perm=3, perm_strata=perm_strata)

summary(operm)

# leave-one-chromosome-out kinship matrices
kinship <- calc_kinship(probs, "loco")

# permutations of genome scan with a linear mixed model

operm_lmm <- scan1perm(probs, pheno, kinship, covar, Xcovar, n_perm=3,

perm_Xsp=TRUE, perm_strata=perm_strata,
chr_lengths=chr_lengths(map))

summary(operm_lmm)

scan1snps

Single-QTL genome scan at imputed SNPs

Description

Perform a single-QTL scan across the genome or a defined region at SNPs genotyped in the founders,
by Haley-Knott regression or a liear mixed model, with possible allowance for covariates.

Usage

scan1snps(

genoprobs,
map,
pheno,
kinship = NULL,
addcovar = NULL,
Xcovar = NULL,
intcovar = NULL,
weights = NULL,
reml = TRUE,
model = c("normal", "binary"),
query_func = NULL,
chr = NULL,
start = NULL,
end = NULL,
snpinfo = NULL,
batch_length = 20,

scan1snps

135

keep_all_snps = FALSE,
cores = 1,
...

)

Arguments

genoprobs

map

pheno

kinship

addcovar

Xcovar

intcovar

weights

reml

model

query_func

chr

start

end

snpinfo

Genotype probabilities as calculated by calc_genoprob().
Physical map for the positions in the genoprobs object: A list of numeric vec-
tors; each vector gives marker positions for a single chromosome.

A numeric matrix of phenotypes, individuals x phenotypes.

Optional kinship matrix, or a list of kinship matrices (one per chromosome), in
order to use the LOCO (leave one chromosome out) method.

An optional numeric matrix of additive covariates.

An optional numeric matrix with additional additive covariates used for null
hypothesis when scanning the X chromosome.

An optional numeric matrix of interactive covariates.

An optional numeric vector of positive weights for the individuals. As with the
other inputs, it must have names for individual identifiers.
If kinship provided: if reml=TRUE, use REML; otherwise maximum likelihood.

Indicates whether to use a normal model (least squares) or binary model (logistic
regression) for the phenotype. If model="binary", the phenotypes must have
values in [0, 1].
Function for querying SNP information; see create_variant_query_func()).
Takes arguments chr, start, end, (with start and end in the units in map,
generally Mbp), and returns a data frame containing the columns snp, chr, pos,
and sdp. (See snpinfo below.)

Chromosome or chromosomes to scan

Position defining the start of an interval to scan. Should be a single number, and
if provided, chr should also have length 1.

Position defining the end of an interval to scan. Should be a single number, and
if provided, chr should also have length 1.
Optional data frame of SNPs to scan; if provided, query_func, chr, start, and
end are ignored. Should contain the following columns:
• chr - Character string or factor with chromosome
• pos - Position (in same units as in the "map").
• sdp - Strain distribution pattern: an integer, between 1 and 2n − 2 where
n is the number of strains, whose binary encoding indicates the founder
genotypes

• snp - Character string with SNP identifier (if missing, the rownames are

used).

batch_length

Interval length (in units of map, generally Mbp) to scan at one time.

scan1snps

SNPs are grouped into equivalence classes based on position and founder geno-
types; if keep_all_snps=FALSE, the return value will contain information only
on the indexed SNPs (one per equivalence class).

Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

Additional control parameters passed to scan1()

136

keep_all_snps

cores

...

Details

The analysis proceeds as follows:

• Call query_func() to grab all SNPs over a region.

• Use index_snps() to group SNPs into equivalence classes.

• Use genoprob_to_snpprob() to convert genoprobs to SNP probabilities.

• Use scan1() to do a single-QTL scan at the SNPs.

Value

A list with two components: lod (matrix of LOD scores) and snpinfo (a data frame of SNPs that
were scanned, including columns index which indicates groups of equivalent SNPs)

See Also

scan1(), genoprob_to_snpprob(), index_snps(), create_variant_query_func(), plot_snpasso()

Examples

## Not run:
# load example data and calculate genotype probabilities
file <- paste0("https://raw.githubusercontent.com/rqtl/",

"qtl2data/main/DOex/DOex.zip")

DOex <- read_cross2(file)
probs <- calc_genoprob(DOex, error_prob=0.002)

snpdb_file <- system.file("extdata", "cc_variants_small.sqlite", package="qtl2")
queryf <- create_variant_query_func(snpdb_file)

out <- scan1snps(probs, DOex$pmap, DOex$pheno, query_func=queryf, chr=2, start=97, end=98)

## End(Not run)

sdp2char

137

sdp2char

Convert strain distribution patterns to character strings

Description

Convert a vector of numeric codes for strain distribution patterns to character strings.

Usage

sdp2char(sdp, n_strains = NULL, strains = NULL)

Arguments

sdp

n_strains

Vector of strain distribution patterns (integers between 1 and 2n − 2 where n is
the number of strains.
Number of founder strains (if missing but strains is provided, we use the
length of strains)

strains

Vector of single-letter codes for the strains

Value

Vector of character strings with the two groups of alleles separated by a vertical bar (|).

See Also

invert_sdp(), calc_sdp()

Examples

sdp <- c(m1=1, m2=12, m3=240)
sdp2char(sdp, 8)
sdp2char(sdp, strains=c("A", "B", "1", "D", "Z", "C", "P", "W"))

sim_geno

Simulate genotypes given observed marker data

Description

Uses a hidden Markov model to simulate from the joint distribution Pr(g | O) where g is the un-
derlying sequence of true genotypes and O is the observed multipoint marker data, with possible
allowance for genotyping errors.

138

Usage

sim_geno

sim_geno(
cross,
map = NULL,
n_draws = 1,
error_prob = 0.0001,
map_function = c("haldane", "kosambi", "c-f", "morgan"),
lowmem = FALSE,
quiet = TRUE,
cores = 1

)

Arguments

cross

map

n_draws

error_prob

map_function

lowmem

quiet

cores

Details

Object of class "cross2". For details, see the R/qtl2 developer guide.
Genetic map of markers. May include pseudomarker locations (that is, locations
that are not within the marker genotype data).
If NULL, the genetic map in
cross is used.
Number of simulations to perform.

Assumed genotyping error probability

Character string indicating the map function to use to convert genetic distances
to recombination fractions.
If FALSE, split individuals into groups with common sex and crossinfo and then
precalculate the transition matrices for a chromosome; potentially a lot faster
but using more memory.
If FALSE, print progress messages.
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

After performing the backward equations, we draw from P r(g1 = v|O) and then P r(gk+1 =
v|O, gk = u).

Value

An object of class "sim_geno": a list of three-dimensional arrays of imputed genotypes, individuals
x positions x draws. Also contains three attributes:

• crosstype - The cross type of the input cross.
• is_x_chr - Logical vector indicating whether chromosomes are to be treated as the X chro-

mosome or not, from input cross.

• alleles - Vector of allele codes, from input cross.

See Also

cbind.sim_geno(), rbind.sim_geno()

smooth_gmap

Examples

139

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
map_w_pmar <- insert_pseudomarkers(grav2$gmap, step=1)
draws <- sim_geno(grav2, map_w_pmar, n_draws=4, error_prob=0.002)

smooth_gmap

Smooth genetic map

Description

Smooth a genetic map by mixing it with a bit of constant recombination (using a separate recombi-
nation rate for each chromosome), to eliminate intervals that have exactly 0 recombination.

Usage

smooth_gmap(gmap, pmap, alpha = 0.02)

Arguments

gmap

pmap

alpha

Details

Genetic map, as a list of numeric vectors; each vector gives marker positions for
a single chromosome.

Physical map, as a list of numeric vectors; each vector gives marker positions
for a single chromosome, with the same chromosomes and markers as gmap.

Proportion of mixture to take from constant recombination.

An interval of genetic length dg and physical length dp is changed to have length (1 − α)dg + αdpr
where r = Lg/Lp is the chromosome-specific recombination rate.

Value

A genetic map like the input gmap, but smoothed by mixing it with a proportion alpha of constant
recombination on each chromosome.

See Also

unsmooth_gmap()

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
gmap_adj <- smooth_gmap(iron$gmap, iron$pmap)

140

subset.calc_genoprob

subset.calc_genoprob

Subsetting genotype probabilities

Description

Pull out a specified set of individuals and/or chromosomes from the results of calc_genoprob().

Usage

## S3 method for class 'calc_genoprob'
subset(x, ind = NULL, chr = NULL, ...)

## S3 method for class 'calc_genoprob'
x[ind = NULL, chr = NULL]

Arguments

x

ind

chr

...

Value

Genotype probabilities as output from calc_genoprob().

A vector of individuals: numeric indices, logical values, or character string IDs

A vector of chromosomes: logical values, or character string IDs. Numbers are
interpreted as character string IDs.

Ignored.

An object of class "calc_genoprob", like the input, with the selected individuals and/or chrom-
somes; see calc_genoprob().

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))

pr <- calc_genoprob(grav2)
# keep just individuals 1:5, chromosome 2
prsub <- pr[1:5,2]
# keep just chromosome 2
prsub2 <- pr[,2]

subset.cross2

141

subset.cross2

Subsetting data for a QTL experiment

Description

Pull out a specified set of individuals and/or chromosomes from a cross2 object.

Usage

## S3 method for class 'cross2'
subset(x, ind = NULL, chr = NULL, ...)

## S3 method for class 'cross2'
x[ind = NULL, chr = NULL]

Arguments

x

ind

chr

...

Details

An object of class "cross2", as output by read_cross2(). For details, see the
R/qtl2 developer guide.

A vector of individuals: numeric indices, logical values, or character string IDs.

A vector of chromosomes: numeric indices, logical values, or character string
IDs

Ignored.

When subsetting by individual, if ind is numeric, they’re assumed to be numeric indices; if character
strings, they’re assumed to be individual IDs. ind can be numeric or logical only if the genotype,
phenotype, and covariate data all have the same individuals in the same order.
When subsetting by chromosome, chr is always converted to character strings and treated as chro-
mosome IDs. So if there are three chromosomes with IDs "18", "19", and "X", mycross[,18] will
give the first of the chromosomes (labeled "18") and mycross[,3] will give an error.
When using character string IDs for ind or chr, you can use "negative" subscripts to indicate
exclusions, for example mycross[,c("-18", "-X")] or mycross["-Mouse2501",]. But you can’t
mix "positive" and "negative" subscripts, and if any of the individuals has an ID that begins with
"-", you can’t use negative subscripts like this.

Value

The input cross2 object, with the selected individuals and/or chromsomes.

Warning

The order of the two arguments is reversed relative to the related function in R/qtl.

142

Examples

subset.sim_geno

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
# keep individuals 1-20 and chromosomes 3 and 4
grav2sub <- grav2[1:20, c(3,4)]
# keep just chromosome 1
grav2_c1 <- grav2[,1]

subset.sim_geno

Subsetting imputed genotypes

Description

Pull out a specified set of individuals and/or chromosomes from the results of sim_geno().

Usage

## S3 method for class 'sim_geno'
subset(x, ind = NULL, chr = NULL, ...)

## S3 method for class 'sim_geno'
x[ind = NULL, chr = NULL]

Arguments

x

ind

chr

...

Value

Imputed genotypes as output from sim_geno().

A vector of individuals: numeric indices, logical values, or character string IDs

A vector of chromosomes: logical values, or character string IDs. Numbers are
interpreted as character string IDs.

Ignored.

An object of class "sim_geno", like the input with the selected individuals and/or chromsomes; see
sim_geno().

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))

dr <- sim_geno(grav2, n_draws=4)
# keep just individuals 1:5, chromosome 2
drsub <- dr[1:5,2]
# keep just chromosome 2
drsub2 <- dr[,2]

subset.viterbi

143

subset.viterbi

Subsetting Viterbi results

Description

Pull out a specified set of individuals and/or chromosomes from the results of viterbi()

Usage

## S3 method for class 'viterbi'
subset(x, ind = NULL, chr = NULL, ...)

## S3 method for class 'viterbi'
x[ind = NULL, chr = NULL]

Arguments

x

ind

chr

...

Value

Imputed genotypes as output from viterbi().

A vector of individuals: numeric indices, logical values, or character string IDs

A vector of chromosomes: logical values, or character string IDs. Numbers are
interpreted as character string IDs.

Ignored.

An object of class "viterbi", like the input, with the selected individuals and/or chromosomes;
see viterbi().

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))

g <- viterbi(grav2)
# keep just individuals 1:5, chromosome 2
gsub <- g[1:5,2]
# keep just chromosome 2
gsub2 <- g[,2]

144

subset_scan1

subset_scan1

Subset scan1 output

Description

Subset the output of scan1() by chromosome or column

Usage

subset_scan1(x, map = NULL, chr = NULL, lodcolumn = NULL, ...)

## S3 method for class 'scan1'
subset(x, map = NULL, chr = NULL, lodcolumn = NULL, ...)

Arguments

x

map

chr

lodcolumn

An object of class "scan1" as returned by scan1().
A list of vectors of marker positions, as produced by insert_pseudomarkers().
Vector of chromosomes.

Vector of integers or character strings indicating the LOD score columns, either
as a numeric indexes or column names.

...

Ignored

Value

Object of class "scan1", like the input, but subset by chromosome and/or column. See scan1().

Examples

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)
Xcovar <- get_x_covar(iron)

# perform genome scan
out <- scan1(probs, pheno, addcovar=covar, Xcovar=Xcovar)

# pull out chromosome 8

summary.cross2

145

out_c8 <- subset(out, map, chr="8")

# just the second column on chromosome 2
out_c2_spleen <- subset(out, map, "2", "spleen")

# all positions, but just the "liver" column
out_spleen <- subset(out, map, lodcolumn="spleen")

summary.cross2

Summary of cross2 object

Description

Summarize a cross2 object

Usage

## S3 method for class 'cross2'
summary(object, ...)

Arguments

object

An object of class "cross2", as output by read_cross2(). For details, see the
R/qtl2 developer guide.

...

Ignored.

Value

None.

See Also

basic_summaries

summary_compare_geno

Basic summary of compare_geno object

Description

From results of compare_geno(), show pairs of individuals with similar genotypes.

summary_scan1perm

146

Usage

summary_compare_geno(object, threshold = 0.9, ...)

## S3 method for class 'compare_geno'
summary(object, threshold = 0.9, ...)

## S3 method for class 'summary.compare_geno'
print(x, digits = 2, ...)

Arguments

object

threshold

...

x

digits

Value

A square matrix with genotype comparisons for pairs of individuals, as output
by compare_geno().

Minimum proportion matches for a pair of individuals to be shown.

Ignored
Results of summary.compare_geno()

Number of digits to print

Data frame with names of individuals in pair, proportion matches, number of mismatches, num-
ber of matches, and total markers genotyped. Last two columns are the numeric indexes of the
individuals in the pair.

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
cg <- compare_geno(grav2)
summary(cg)

summary_scan1perm

Summarize scan1perm results

Description

Summarize permutation test results from scan1perm(), as significance thresholds.

Usage

summary_scan1perm(object, alpha = 0.05)

## S3 method for class 'scan1perm'
summary(object, alpha = 0.05, ...)

summary_scan1perm

147

Arguments

object

alpha

...

Details

An object of class "scanoneperm", as output by scan1perm()

Vector of significance levels

Ignored

In the case of X-chromosome-specific permutations (when scan1perm() was run with perm_Xsp=TRUE,
we follow the approach of Broman et al. (2006) to get separate thresholds for the autosomes and X
chromosome, using

Let LA and LX be total the genetic lengths of the autosomes and X chromosome, respectively, and
let LT = LA + LX Then in place of α, we use

αA = 1 − (1 − α)LA/LT

as the significance level for the autosomes and

αX = 1 − (1 − α)LX /LT

as the significance level for the X chromosome.

Value

An object of class summary.scan1perm. If scan1perm() was run with perm_Xsp=FALSE, this is a
single matrix of significance thresholds, with rows being signicance levels and columns being the
columns in the input. If scan1perm() was run with perm_Xsp=TRUE, this is a list of two matrices,
with the significance thresholds for the autosomes and X chromosome, respectively.
The result has an attribute "n_perm" that has the numbers of permutation replicates (either a matrix
or a list of two matrices).

References

Broman KW, Sen ´S, Owens SE, Manichaikul A, Southard-Smith EM, Churchill GA (2006) The X
chromosome in quantitative trait locus mapping. Genetics 174:2151-2158

Examples

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno

148

top_snps

covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)
Xcovar <- get_x_covar(iron)

# permutations with genome scan (just 3 replicates, for illustration)
operm <- scan1perm(probs, pheno, addcovar=covar, Xcovar=Xcovar,

n_perm=3)

summary(operm, alpha=c(0.20, 0.05))

top_snps

Create table of top snp associations

Description

Create a table of the top snp associations

Usage

top_snps(

scan1_output,
snpinfo,
lodcolumn = 1,
chr = NULL,
drop = 1.5,
show_all_snps = TRUE

)

Arguments

scan1_output

snpinfo

Output of scan1(). Should contain a component "snpinfo", as when scan1()
is run with SNP probabilities produced by genoprob_to_snpprob().

Data frame with SNP information with the following columns (the last three are
generally derived with index_snps()):

• chr - Character string or factor with chromosome
• pos - Position (in same units as in the "map" attribute in genoprobs.
• sdp - Strain distribution pattern: an integer, between 1 and 2n − 2 where
n is the number of strains, whose binary encoding indicates the founder
genotypes

• snp - Character string with SNP identifier (if missing, the rownames are

used).

• index - Indices that indicate equivalent groups of SNPs, calculated by

index_snps().

• intervals - Indexes that indicate which marker intervals the SNPs reside.
• on_map - Indicate whether SNP coincides with a marker in the genoprobs

top_snps

lodcolumn

chr

drop

149

Selected LOD score column to (a numeric index, or a character string for a
column name). Only one value allowed.

Selected chromosome; only one value allowed.

Show all SNPs with LOD score within this amount of the maximum SNP asso-
ciation.

show_all_snps

If TRUE, expand to show all SNPs.

Value

Data frame like the input snpinfo with just the selected subset of rows, and with an added column
with the LOD score.

See Also

index_snps(), genoprob_to_snpprob(), scan1snps(), plot_snpasso()

Examples

## Not run:
# load example DO data from web
file <- paste0("https://raw.githubusercontent.com/rqtl/",

"qtl2data/main/DOex/DOex.zip")

DOex <- read_cross2(file)

# subset to chr 2
DOex <- DOex[,"2"]

# calculate genotype probabilities and convert to allele probabilities
pr <- calc_genoprob(DOex, error_prob=0.002)
apr <- genoprob_to_alleleprob(pr)

# query function for grabbing info about variants in region
dbfile <- system.file("extdata", "cc_variants_small.sqlite", package="qtl2")
query_variants <- create_variant_query_func(dbfile)

# SNP association scan, keep information on all SNPs
out_snps <- scan1snps(apr, DOex$pmap, DOex$pheno, query_func=query_variants,

chr=2, start=97, end=98, keep_all_snps=TRUE)

# table with top SNPs
top_snps(out_snps$lod, out_snps$snpinfo)

# top SNPs among the distinct subset at which calculations were performed
top_snps(out_snps$lod, out_snps$snpinfo, show_all_snps=FALSE)

# top SNPs within 0.5 LOD of max
top_snps(out_snps$lod, out_snps$snpinfo, drop=0.5)

## End(Not run)

150

unsmooth_gmap

unsmooth_gmap

Unsmooth genetic map

Description

Performs the reverse operation of smooth_gmap(), in case one wants to go back to the original
genetic map.

Usage

unsmooth_gmap(gmap, pmap, alpha = 0.02)

Arguments

gmap

pmap

alpha

Details

Genetic map, as a list of numeric vectors; each vector gives marker positions for
a single chromosome.

Physical map, as a list of numeric vectors; each vector gives marker positions
for a single chromosome, with the same chromosomes and markers as gmap.

Proportion of mixture to take from constant recombination.

An interval of genetic length dg and physical length dp is changed to have length (dg − αdpr)/(1 −
α) where r = Lg/Lp is the chromosome-specific recombination rate.

Value

A genetic map like the input gmap, but with the reverse operation of smooth_gmap() applied, pro-
vided that exactly the same physical map and alpha are used.

See Also

smooth_gmap()

Examples

iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))
gmap_adj <- smooth_gmap(iron$gmap, iron$pmap)
gmap_back <- unsmooth_gmap(gmap_adj, iron$pmap)

viterbi

151

viterbi

Calculate most probable sequence of genotypes

Description

Uses a hidden Markov model to calculate arg max Pr(g | O) where g is the underlying sequence of
true genotypes and O is the observed multipoint marker data, with possible allowance for genotyp-
ing errors.

Usage

viterbi(
cross,
map = NULL,
error_prob = 0.0001,
map_function = c("haldane", "kosambi", "c-f", "morgan"),
lowmem = FALSE,
quiet = TRUE,
cores = 1

)

Arguments

cross

map

error_prob

map_function

lowmem

quiet

cores

Details

Object of class "cross2". For details, see the R/qtl2 developer guide.
Genetic map of markers. May include pseudomarker locations (that is, locations
If NULL, the genetic map in
that are not within the marker genotype data).
cross is used.
Assumed genotyping error probability

Character string indicating the map function to use to convert genetic distances
to recombination fractions.
If FALSE, split individuals into groups with common sex and crossinfo and then
precalculate the transition matrices for a chromosome; potentially a lot faster
but using more memory.
If FALSE, print progress messages.
Number of CPU cores to use, for parallel calculations. (If 0, use parallel::detectCores().)
Alternatively, this can be links to a set of cluster sockets, as produced by parallel::makeCluster().

We use a hidden Markov model to find, for each individual on each chromosome, the most probable
sequence of underlying genotypes given the observed marker data.

Note that we break ties at random, and our method for doing this may introduce some bias.

Consider the results with caution; the most probable sequence can have very low probability, and
can have features that are quite unusual (for example, the number of recombination events can be
too small). In most cases, the results of a single imputation with sim_geno() will be more realistic.

152

Value

write_control_file

An object of class "viterbi": a list of two-dimensional arrays of imputed genotypes, individuals
x positions. Also contains three attributes:

• crosstype - The cross type of the input cross.
• is_x_chr - Logical vector indicating whether chromosomes are to be treated as the X chro-

mosome or not, from input cross.

• alleles - Vector of allele codes, from input cross.

See Also

sim_geno(), maxmarg(), cbind.viterbi(), rbind.viterbi()

Examples

grav2 <- read_cross2(system.file("extdata", "grav2.zip", package="qtl2"))
map_w_pmar <- insert_pseudomarkers(grav2$gmap, step=1)
g <- viterbi(grav2, map_w_pmar, error_prob=0.002)

write_control_file

Write a control file for QTL data

Description

Write the control file (in YAML or JSON) needed by read_cross2() for a set of QTL data.

Usage

write_control_file(

output_file,
crosstype = NULL,
geno_file = NULL,
founder_geno_file = NULL,
gmap_file = NULL,
pmap_file = NULL,
pheno_file = NULL,
covar_file = NULL,
phenocovar_file = NULL,
sex_file = NULL,
sex_covar = NULL,
sex_codes = NULL,
crossinfo_file = NULL,
crossinfo_covar = NULL,
crossinfo_codes = NULL,
geno_codes = NULL,
alleles = NULL,
xchr = NULL,

write_control_file

153

sep = ",",
na.strings = c("-", "NA"),
comment.char = "#",
geno_transposed = FALSE,
founder_geno_transposed = FALSE,
pheno_transposed = FALSE,
covar_transposed = FALSE,
phenocovar_transposed = FALSE,
description = NULL,
comments = NULL,
overwrite = FALSE

)

Arguments

output_file

File name (with path) of the YAML or JSON file to be created, as a character
string. If extension is .json, JSON format is used; otherwise, YAML is used.

crosstype

Character string with the cross type.

geno_file
founder_geno_file

File name for genotype data.

File name for the founder genotype data.

gmap_file

pmap_file

pheno_file

covar_file
phenocovar_file

File name for genetic map.

File name for the physical map.

File name for the phenotype data.

File name for the covariate data.

sex_file

sex_covar

sex_codes

File name for the phenotype covariate data (i.e., metadata about the phenotypes).
File name for the individuals’ sex. (Specify just one of sex_file or sex_covar.)

Column name in the covariate data that corresponds to sex. (Specify just one of
sex_file or sex_covar.)

Named vector of character strings specifying the encoding of sex. The names
attribute should be the codes used in the data files; the values within the vector
should be "female" and "male".

crossinfo_file File name for the cross_info data. (Specify just one of crossinfo_file or

crossinfo_covar.)

crossinfo_covar

crossinfo_codes

Column name in the covariate data that corresponds to the cross_info data.
(Specify just one of crossinfo_file or crossinfo_covar.)

In the case that there is a single cross info column (whether in a file or as a
covariate), you can provide a named vector of character strings specifying the
encoding of cross_info. The names attribute should be the codes used; the
values within the vector should be the codes to which they will be converted
(for example, 0 and 1 for an intercross).

154

geno_codes

alleles

xchr

sep

na.strings

comment.char

geno_transposed

write_control_file

Named vector specifying the encoding of genotypes. The names attribute has
the codes used within the genotype and founder genotype data files; the values
within the vector should be the integers to which the genotypes will be con-
verted.

Vector of single-character codes for the founder alleles.

Character string with the ID for the X chromosome.

Character string that separates columns in the data files.

Vector of character strings with codes to be treated as missing values.

Character string that is used as initial character in a set of leading comment lines
in the data files.

If TRUE, genotype file is transposed (with markers as rows).

founder_geno_transposed

If TRUE, founder genotype file is transposed (with markers as rows).

pheno_transposed

If TRUE, phenotype file is transposed (with phenotypes as rows).

covar_transposed

If TRUE, covariate file is transposed (with covariates as rows).

phenocovar_transposed

If TRUE, phenotype covariate file is transposed (with phenotype covariates as
rows).

Optional character string describing the data.

Vector of character strings to be inserted as comments at the top of the file (in
the case of YAML), with each string as a line. For JSON, the comments are
instead included within the control object.

If TRUE, overwrite file if it exists. If FALSE (the default) and the file exists,
stop with an error.

description

comments

overwrite

Details

This function takes a set of parameters and creates the control file (in YAML or JSON format)
needed for the new input data file format for R/qtl2. See the sample data files and the vignette
describing the input file format.

Value

(Invisibly) The data structure that was written.

See Also

read_cross2(), sample data files at https://kbroman.org/qtl2/pages/sampledata.html

155

xpos_scan1

Examples

# Control file for the sample dataset, grav2
grav2_control_file <- file.path(tempdir(), "grav2.yaml")
write_control_file(grav2_control_file,
crosstype="riself",
geno_file="grav2_geno.csv",
gmap_file="grav2_gmap.csv",
pheno_file="grav2_pheno.csv",
phenocovar_file="grav2_phenocovar.csv",
geno_codes=c(L=1L, C=2L),
alleles=c("L", "C"),
na.strings=c("-", "NA"))

# Control file for the sample dataset, iron
iron_control_file <- file.path(tempdir(), "iron.yaml")
write_control_file(iron_control_file,

crosstype="f2",
geno_file="iron_geno.csv",
gmap_file="iron_gmap.csv",
pheno_file="iron_pheno.csv",
covar_file="iron_covar.csv",
phenocovar_file="iron_phenocovar.csv",
geno_codes=c(SS=1L, SB=2L, BB=3L),
sex_covar="sex",
sex_codes=c(f="female", m="male"),
crossinfo_covar="cross_direction",
crossinfo_codes=c("(SxB)x(SxB)"=0L, "(BxS)x(BxS)"=1L),
xchr="X",
alleles=c("S", "B"),
na.strings=c("-", "NA"))

# Remove these files, to clean up temporary directory
unlink(c(grav2_control_file, iron_control_file))

xpos_scan1

Get x-axis position for genomic location

Description

For a plot of scan1() results, get the x-axis location that corresponds to a particular genomic
location (chromosome ID and position).

Usage

xpos_scan1(map, chr = NULL, gap = NULL, thechr, thepos)

Arguments

map

A list of vectors of marker positions, as produced by insert_pseudomarkers().

156

chr

gap

thechr

thepos

Details

xpos_scan1

Selected chromosomes that were plotted (if used in the call to plot_scan1().
The gap between chromosomes used in the call to plot_scan1().

Vector of chromosome IDs

Vector of chromosomal positions

thechr and thepos should be the same length, or should have length 1 (in which case they are
expanded to the length of the other vector).

Value

A vector of x-axis locations.

Examples

# read data
iron <- read_cross2(system.file("extdata", "iron.zip", package="qtl2"))

# insert pseudomarkers into map
map <- insert_pseudomarkers(iron$gmap, step=1)

# calculate genotype probabilities
probs <- calc_genoprob(iron, map, error_prob=0.002)

# grab phenotypes and covariates; ensure that covariates have names attribute
pheno <- iron$pheno
covar <- match(iron$covar$sex, c("f", "m")) # make numeric
names(covar) <- rownames(iron$covar)
Xcovar <- get_x_covar(iron)

# perform genome scan
out <- scan1(probs, pheno, addcovar=covar, Xcovar=Xcovar)

# plot the results for selected chromosomes
ylim <- c(0, maxlod(out)*1.02) # need to strip class to get overall max LOD
chr <- c(2,7,8,9,15,16)
plot(out, map, chr=chr, ylim=ylim)
plot(out, map, lodcolumn=2, chr=chr, col="violetred", add=TRUE)
legend("topleft", lwd=2, col=c("darkslateblue", "violetred"), colnames(out),

bg="gray90")

# Use xpos_scan1 to add points at the peaks
# first find the peaks with LOD > 3
peaks <- find_peaks(out, map)

# keep just the peaks for chromosomes that were plotted
peaks <- peaks[peaks$chr %in% chr,]

# find x-axis positions
xpos <- xpos_scan1(map, chr=chr, thechr=peaks$chr, thepos=peaks$pos)

zip_datafiles

157

# point colors
ptcolor <- c("darkslateblue", "violetred")[match(peaks$lodcolumn, c("liver", "spleen"))]

# plot points
points(xpos, peaks$lod, pch=21, bg=ptcolor)

zip_datafiles

Zip a set of data files

Description

Zip a set of data files (in format read by read_cross2()).

Usage

zip_datafiles(control_file, zip_file = NULL, overwrite = FALSE, quiet = TRUE)

Arguments

control_file

zip_file

overwrite

quiet

Details

Character string with path to the control file (YAML or JSON) containing all of
the control information.
Name of zip file to use. If NULL, we use the stem of control_file but with a
.zip extension.
If TRUE, overwrite file if it exists. If FALSE (the default) and the file exists, stop
with an error.
If FALSE, print progress messages.

The input control_file is the control file (in YAML or JSON format) to be read by read_cross2().
(See the sample data files and the vignette describing the input file format.)
The utils::zip() function is used to do the zipping.
The files should all be contained within the directory where the control_file sits, or in a subdi-
rectory of that directory. If file paths use .., these get stripped by zip, and so the resulting zip file
may not work with read_cross2().

Value

Character string with the file name of the zip file that was created.

See Also

read_cross2(), sample data files at https://kbroman.org/qtl2/pages/sampledata.html

158

Examples

## Not run:
zipfile <- file.path(tempdir(), "grav2.zip")
zip_datafiles("grav2.yaml", zipfile)

## End(Not run)

zip_datafiles

Index

∗ IO

read_cross2, 115
read_pheno, 116
zip_datafiles, 157

∗ datasets

CCcolors, 28

∗ graphics

plot_compare_geno, 86

∗ hgraphics

plot_genes, 86
plot_sdp, 100

∗ htest

chisq_colpairs, 29

∗ utilities

basic_summaries, 6
calc_entropy, 11
calc_errorlod, 12
calc_genoprob, 13
calc_grid, 16
calc_kinship, 18
calc_raw_founder_maf, 19
calc_raw_geno_freq, 20
calc_raw_het, 21
calc_raw_maf, 21
compare_founder_geno, 34
compare_geno, 35
convert2cross2, 38
est_map, 48
find_dup_markers, 49
genoprob_to_alleleprob, 63
get_x_covar, 67
guess_phase, 67
insert_pseudomarkers, 70
map_to_grid, 76
max_compare_geno, 80
predict_snpgeno, 104
print.cross2, 105
probs_to_grid, 106
recode_snps, 117

scale_kinship, 121
sim_geno, 137
smooth_gmap, 139
subset.calc_genoprob, 140
subset.cross2, 141
subset.sim_geno, 142
subset.viterbi, 143
summary.cross2, 145
summary_compare_geno, 145
unsmooth_gmap, 150
write_control_file, 152

[.calc_genoprob (subset.calc_genoprob),

140

[.cross2 (subset.cross2), 141
[.sim_geno (subset.sim_geno), 142
[.viterbi (subset.viterbi), 143

add_threshold, 5

base::cbind(), 27
base::paste(), 77
base::print(), 105
basic_summaries, 6, 145
batch_cols, 8
batch_cols(), 9
batch_vec, 9
batch_vec(), 8
bayes_int, 9
bayes_int(), 57, 76

c.scan1perm (rbind.scan1perm), 112
calc_entropy, 11
calc_errorlod, 12
calc_errorlod(), 104
calc_geno_freq, 15
calc_geno_freq(), 17, 20
calc_genoprob, 13
calc_genoprob(), 11–13, 15–18, 23, 32, 36,

63–65, 69, 71, 72, 79, 88, 89, 91,

159

160

INDEX

106–108, 110, 121, 122, 125, 127,
130, 132, 135, 140

calc_grid, 16
calc_grid(), 71, 77, 107
calc_het, 17
calc_het(), 15, 21
calc_kinship, 18
calc_kinship(), 121, 124
calc_raw_founder_maf, 19
calc_raw_founder_maf(), 21, 22, 117
calc_raw_geno_freq, 20
calc_raw_geno_freq(), 15, 21, 22
calc_raw_het, 21
calc_raw_het(), 17, 20, 22
calc_raw_maf, 21
calc_raw_maf(), 19–21, 117
calc_sdp, 22
calc_sdp(), 73, 101, 137
cbind.calc_genoprob, 23
cbind.calc_genoprob(), 110
cbind.scan1, 24
cbind.scan1(), 111, 124
cbind.scan1perm, 25
cbind.scan1perm(), 112
cbind.sim_geno, 26
cbind.sim_geno(), 113, 138
cbind.viterbi, 27
cbind.viterbi(), 114, 152
cbind_expand, 27
CCaltcolors (CCcolors), 28
CCcolors, 28, 85
CCorigcolors (CCcolors), 28
check_cross2, 29
chisq_colpairs, 29
chr_lengths, 30
chr_lengths(), 132, 133
chr_names (basic_summaries), 6
clean, 31
clean.calc_genoprob (clean_genoprob), 31
clean.calc_genoprob(), 31
clean.scan1 (clean_scan1), 33
clean.scan1(), 31
clean_genoprob, 31
clean_scan1, 33
compare_founder_geno, 34
compare_geno, 35
compare_geno(), 80, 81, 86, 145, 146
compare_genoprob, 36

compare_maps, 37
convert2cross2, 38
count_xo, 39
count_xo(), 74
covar_names (basic_summaries), 6
create_gene_query_func, 40
create_snpinfo, 41
create_variant_query_func, 42
create_variant_query_func(), 135, 136

data.table::fread(), 61, 62
decomp_kinship, 44
drop_markers, 45
drop_markers(), 46, 50, 109, 119
drop_nullmarkers, 45
drop_nullmarkers(), 45, 50, 109

est_herit, 46
est_map, 48

find_dup_markers, 49
find_dup_markers(), 45, 119
find_ibd_segments, 50
find_index_snp, 52
find_index_snp(), 54, 69
find_map_gaps, 53
find_map_gaps(), 118
find_marker, 54
find_marker(), 52, 55, 60, 108
find_markerpos, 55
find_markerpos(), 54
find_peaks, 56
find_peaks(), 11, 76, 82, 92, 95, 96
fit1, 58
fit1(), 108
founders (basic_summaries), 6
fread_csv, 61
fread_csv(), 63
fread_csv_numer, 62
fread_csv_numer(), 62

genoprob_to_alleleprob, 63
genoprob_to_alleleprob(), 14, 18, 36, 88,

89, 91
genoprob_to_snpprob, 64
genoprob_to_snpprob(), 42, 69, 102, 136,

148, 149

get_common_ids, 66
get_x_covar, 67

INDEX

get_x_covar(), 77
graphics::image(), 89, 91
graphics::segments(), 5
guess_phase, 67
guess_phase(), 94

hist(), 86

ind_ids (basic_summaries), 6
ind_ids_covar (basic_summaries), 6
ind_ids_geno (basic_summaries), 6
ind_ids_gnp (basic_summaries), 6
ind_ids_pheno (basic_summaries), 6
index_snps, 68
index_snps(), 42, 52, 56, 64, 65, 81, 102,

136, 148, 149

insert_pseudomarkers, 70
insert_pseudomarkers(), 10, 14, 16, 56, 69,

72, 75, 77, 78, 81, 84, 99, 144, 155

interp_genoprob, 71
interp_map, 72
invert_sdp, 73
invert_sdp(), 22, 101, 137

locate_xo, 74
locate_xo(), 39
lod_int, 75
lod_int(), 11, 57

map_to_grid, 76
map_to_grid(), 16, 107
marker_names (basic_summaries), 6
mat2strata, 77
mat2strata(), 133
max.compare_geno (max_compare_geno), 80
max.scan1 (max_scan1), 81
max_compare_geno, 80
max_scan1, 81
maxlod, 78
maxmarg, 79
maxmarg(), 36, 39, 68, 74, 94, 97, 104, 152

n_chr (basic_summaries), 6
n_covar (basic_summaries), 6
n_founders (basic_summaries), 6
n_ind (basic_summaries), 6
n_ind_covar (basic_summaries), 6
n_ind_geno (basic_summaries), 6
n_ind_gnp (basic_summaries), 6

161

n_ind_pheno (basic_summaries), 6
n_mar (basic_summaries), 6
n_missing, 82
n_pheno (basic_summaries), 6
n_phenocovar (basic_summaries), 6
n_typed (n_missing), 82

parallel::detectCores(), 11, 12, 14, 17,

18, 20, 32, 34, 35, 39, 44, 47, 48, 50,
57, 63, 68, 70, 71, 74, 79, 104, 119,
123, 126, 130, 132, 136, 138, 151
parallel::makeCluster(), 11, 12, 14, 17,

18, 20, 32, 34, 35, 39, 44, 47, 48, 50,
57, 63, 68, 70, 71, 74, 79, 104, 119,
123, 126, 130, 132, 136, 138, 151

pheno_names (basic_summaries), 6
phenocovar_names (basic_summaries), 6
plot.calc_genoprob (plot_genoprob), 88
plot.compare_geno (plot_compare_geno),

86

plot.scan1 (plot_scan1), 99
plot.scan1coef (plot_coef), 83
plot_coef, 83
plot_coef(), 98, 99, 103
plot_coefCC (plot_coef), 83
plot_coefCC(), 99, 103
plot_compare_geno, 86
plot_genes, 86
plot_genoprob, 88
plot_genoprob(), 91
plot_genoprobcomp, 90
plot_genoprobcomp(), 37, 89
plot_lodpeaks, 92
plot_lodpeaks(), 96
plot_onegeno, 93
plot_peaks, 95
plot_peaks(), 92
plot_pxg, 97
plot_scan1, 99
plot_scan1(), 85, 103, 156
plot_sdp, 100
plot_snpasso, 101
plot_snpasso(), 85, 99, 136, 149
predict_snpgeno, 104
print.cross2, 105
print.summary.compare_geno

(summary_compare_geno), 145

print.summary.scan1perm, 105
probs_to_grid, 106

INDEX

scan1snps, 134
scan1snps(), 41, 42, 56, 65, 69, 81, 149
sdp2char, 137
sdp2char(), 22, 73
sim_geno, 137
sim_geno(), 26, 39, 80, 113, 121, 142, 151,

152

smooth_gmap, 139
smooth_gmap(), 150
subset.calc_genoprob, 140
subset.cross2, 141
subset.scan1 (subset_scan1), 144
subset.sim_geno, 142
subset.viterbi, 143
subset_scan1, 144
summary.compare_geno

(summary_compare_geno), 145

summary.compare_geno(), 146
summary.cross2, 145
summary.cross2(), 8
summary.scan1perm (summary_scan1perm),

146

summary_compare_geno, 145
summary_scan1perm, 146
summary_scan1perm(), 105, 106

top_snps, 148
tot_mar (basic_summaries), 6

unsmooth_gmap, 150
unsmooth_gmap(), 139
utils::zip(), 157

viterbi, 151
viterbi(), 27, 39, 74, 80, 104, 114, 121, 143

write_control_file, 152
write_control_file(), 115

xpos_scan1, 155

zip_datafiles, 157

162

probs_to_grid(), 16, 77
pull_genoprobint, 107
pull_genoprobint(), 54, 108
pull_genoprobpos, 108
pull_genoprobpos(), 54, 60, 108
pull_markers, 109
pull_markers(), 45, 46

qtl2version, 110
qtl::read.cross(), 38

rbind.calc_genoprob, 110
rbind.calc_genoprob(), 23
rbind.scan1, 111
rbind.scan1(), 24, 124
rbind.scan1perm, 112
rbind.scan1perm(), 25
rbind.sim_geno, 113
rbind.sim_geno(), 26, 138
rbind.viterbi, 114
rbind.viterbi(), 27, 152
read_cross2, 115
read_cross2(), 7, 29, 39, 64, 83, 105, 116,
141, 145, 152, 154, 157

read_pheno, 116
read_pheno(), 115
recode_snps, 117
recode_snps(), 19–22
reduce_map_gaps, 118
reduce_map_gaps(), 53
reduce_markers, 118
reduce_markers(), 45, 50
replace_ids, 120
rug(), 86

scale_kinship, 121
scan1, 122
scan1(), 10, 11, 24, 25, 33, 56, 57, 75, 76, 78,
81, 99, 102, 111, 112, 131, 133, 136,
144, 148, 155

scan1blup, 125
scan1blup(), 59
scan1coef, 127
scan1coef(), 84, 124
scan1max, 129
scan1max(), 124
scan1perm, 131
scan1perm(), 25, 30, 77, 112, 124, 131, 146,

147

