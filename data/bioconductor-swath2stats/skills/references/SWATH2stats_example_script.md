SWATH2stats example script

Example R code showing the usage of the SWATH2stats package. The data processed is the publicly available
dataset of S.pyogenes (Röst et al. 2014) (http://www.peptideatlas.org/PASS/PASS00289). The results file
‘rawOpenSwathResults_1pcnt_only.tsv’ can be found on PeptideAtlas (ftp://PASS00289@ftp.peptideatlas.o
rg/../Spyogenes/results/). This is a R Markdown file, showing the result of processing this data. The lines
shaded in grey represent the R code executed during this analysis.

The SWATH2stats package can be directly installed from Bioconductor using the commands below (http:
//bioconductor.org/packages/devel/bioc/html/SWATH2stats.html).
if (!require("BiocManager"))

install.packages("BiocManager")
BiocManager::install("SWATH2stats")

Part 1: Loading and annotation

Load the SWATH-MS example data from the package, this is a reduced file in order to limit the file size of
the package.
library(SWATH2stats)
library(data.table)
data('Spyogenes', package = 'SWATH2stats')

Alternatively the original file downloaded from the Peptide Atlas can be loaded from the working directory.
data <- data.frame(fread('rawOpenSwathResults_1pcnt_only.tsv', sep='\t', header=TRUE))

Extract the study design information from the file names. Alternatively, the study design table can be
provided as an external table.
Study_design <- data.frame(Filename = unique(data$align_origfilename))
Study_design$Filename <- gsub(".*strep_align/(.*)_all_peakgroups.*", "\\1", Study_design$Filename)
Study_design$Condition <- gsub("(Strep.*)_Repl.*", "\\1", Study_design$Filename)
Study_design$BioReplicate <- gsub(".*Repl([[:digit:]])_.*", "\\1", Study_design$Filename)
Study_design$Run <- seq_len(nrow(Study_design))
head(Study_design)

##
## 1 Strep0_Repl1_R02/split_hroest_K120808
## 2 Strep0_Repl2_R02/split_hroest_K120808
## 3 Strep10_Repl1_R02/split_hroest_K120808
## 4 Strep10_Repl2_R02/split_hroest_K120808

Filename Condition BioReplicate Run
1
2
3
4

Strep0
Strep0
Strep10
Strep10

1
2
1
2

The SWATH-MS data is annotated using the study design table.
data.annotated <- sample_annotation(data, Study_design, column_file = "align_origfilename")

Remove the decoy peptides for a subsequent inspection of the data.
data.annotated.nodecoy <- subset(data.annotated, decoy==FALSE)

1

Part 2: Analyze correlation, variation and signal

Count the different analytes for the different injections.
count_analytes(data.annotated.nodecoy)

##
## 1 Strep0_1_1
## 2 Strep0_2_2
## 3 Strep10_1_3
## 4 Strep10_2_4

run_id transition_group_id FullPeptideName ProteinName
1031
1003
943
910

10229
9716
8692
8424

8377
7970
7138
6941

Plot the correlation of the signal intensity.
correlation <- plot_correlation_between_samples(data.annotated.nodecoy, column.values = 'Intensity')

## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## i Please use tidy evaluation idioms with `aes()`.
## i See also `vignette("ggplot2-in-packages")` for more information.
## i The deprecated feature was likely used in the SWATH2stats package.
##
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.

Please report the issue at <https://github.com/peterblattmann/SWATH2stats>.

## Warning: Use of `data.plot$value` is discouraged.
## i Use `value` instead.

Plot the correlation of the delta_rt, which is the deviation of the retention time from the expected retention
time.
correlation <- plot_correlation_between_samples(data.annotated.nodecoy, column.values = 'delta_rt')

## Warning: Use of `data.plot$value` is discouraged.
## i Use `value` instead.

2

10.9910.960.9710.930.950.9710.970.920.880.930.90.95Strep10_2Strep10_1Strep0_2Strep0_1Strep0_1Strep0_2Strep10_1Strep10_2Correlation[R or rho]0.9000.9250.9500.9751.000Intensity correlation between samples:Pearson (upper triangle) and Spearman correlation (lower triangle)3

10.9910.960.9710.930.950.9710.970.920.880.930.90.95Strep10_2Strep10_1Strep0_2Strep0_1Strep0_1Strep0_2Strep10_1Strep10_2Correlation[R or rho]0.9000.9250.9500.9751.000Intensity correlation between samples:Pearson (upper triangle) and Spearman correlation (lower triangle)Plot the variation of the signal across replicates.
variation <- plot_variation(data.annotated.nodecoy)

variation[[2]]

##
## 1
## 2

Condition

mode_cv

mean_cv median_cv
Strep0 0.2280372 0.2545450 0.2351859
Strep10 0.1706934 0.2947144 0.2592725

Plot the total variation versus variation within replicates.
variation_total <- plot_variation_vs_total(data.annotated.nodecoy)

variation_total[[2]]

scope

mean_cv median_cv
##
## 1 replicate 0.2209867 0.2728681 0.2438041
total 0.2655678 0.3439050 0.3139993
## 2

mode_cv

Calculate the summed signal per peptide and protein across samples.
peptide_signal <- write_matrix_peptides(data.annotated.nodecoy)
protein_signal <- write_matrix_proteins(data.annotated.nodecoy)
head(protein_signal)

##
## 1 Spyo_Exp3652_DDB_SeqID_1571119
## 2 Spyo_Exp3652_DDB_SeqID_1579753

ProteinName Strep0_1_1 Strep0_2_2 Strep10_1_3 Strep10_2_4
45021
144314

265206
185725

163326
150672

51831
21483

4

0.00.51.0Strep0Strep10Conditioncvcv across conditions0.00.51.01.5totalreplicatecvcoefficient of variation − total versus within replicates## 3 Spyo_Exp3652_DDB_SeqID_1631459
## 4 Spyo_Exp3652_DDB_SeqID_1640263
## 5 Spyo_Exp3652_DDB_SeqID_1709452
## 6 Spyo_Exp3652_DDB_SeqID_17244480

176686
3310
852502
17506

132415
6617
747772
29578

42165
98550
503581
7607

32735
45169
504761
2482

5

Part 3: FDR estimation

Estimate the overall FDR across runs using a target decoy strategy.
par(mfrow = c(1, 3))
fdr_target_decoy <- assess_fdr_overall(data.annotated, n_range = 10,

FFT = 0.25, output = 'Rconsole')

According to this
FDR estimation one would need to filter the data with a lower mscore threshold to reach an overall protein
FDR of 5%.
mscore4protfdr(data, FFT = 0.25, fdr_target = 0.05)

## Target protein FDR:0.05

## Required overall m-score cutoff:0.0017783
## achieving protein FDR =0.0488

## [1] 0.001778279

6

0.0000.0050.0100.0150200040006000800012000assay FDR# of assaysall targetstrue targets0.0000.0100.0200200040006000800010000peptide FDR# of peptidesall targetstrue targets0.000.040.0802004006008001000protein FDR# of proteinsall targetstrue targetsGlobal m−score cutoff connectivity to FDR quality0.0000.010Assay FDR0.0000.0100.020Peptide FDR0.000.040.080.12Protein FDR−10−8−6−4−2log10(m_score cutoff)Part 4: Filtering

Filter data for values that pass the 0.001 mscore criteria in at least two replicates of one condition.
data.filtered <- filter_mscore_condition(data.annotated, 0.001, n_replica = 2)

## Fraction of peptides selected: 0.67

## Dimension difference: 7226, 0

Select only the 10 peptides showing strongest signal per protein.
data.filtered2 <- filter_on_max_peptides(data.filtered, n_peptides = 10)

Number of proteins: 884
Number of peptides: 6594

## Before filtering:
##
##
##
## Percentage of peptides removed: 29.6%
##
## After filtering:
##
##

Number of proteins: 884
Number of peptides: 4642

7

Filter for proteins that are supported by at least two peptides.
data.filtered3 <- filter_on_min_peptides(data.filtered2, n_peptides = 2)

Number of proteins: 884
Number of peptides: 4642

## Before filtering:
##
##
##
## Percentage of peptides removed: 3.6%
##
## After filtering:
##
##

Number of proteins: 717
Number of peptides: 4475

Part 5: Conversion

Convert the data into a transition-level format (one row per transition measured).
data.transition <- disaggregate(data.filtered3)

## The library contains 6 transitions per precursor.
##
## The data table was transformed into a table containing one row per transition.

Convert the data into the format required by MSstats.
MSstats.input <- convert4MSstats(data.transition)

## One or several columns required by MSstats were not in the data.
##
## Missing columns: ProductCharge, IsotopeLabelType

The columns were created and filled with NAs.

## IsotopeLabelType was filled with light.

## Warning in convert4MSstats(data.transition): Intensity values that were 0, were
## replaced by NA
head(MSstats.input)

PeptideSequence PrecursorCharge
3
3
3
3
2
2

ProteinName

##
## 1 Spyo_Exp3652_DDB_SeqID_1571119 AEAAIYQFLEAIGENPNR
## 2 Spyo_Exp3652_DDB_SeqID_1571119 AEAAIYQFLEAIGENPNR
## 3 Spyo_Exp3652_DDB_SeqID_1571119 AEAAIYQFLEAIGENPNR
## 4 Spyo_Exp3652_DDB_SeqID_1571119 AEAAIYQFLEAIGENPNR
AHIAYLPSDGR
## 5 Spyo_Exp3652_DDB_SeqID_1571119
## 6 Spyo_Exp3652_DDB_SeqID_1571119
AHIAYLPSDGR
##
## 1 105801_AEAAIYQFLEAIGENPNR/3_y6
## 2 105801_AEAAIYQFLEAIGENPNR/3_y6
## 3 105801_AEAAIYQFLEAIGENPNR/3_y6
## 4 105801_AEAAIYQFLEAIGENPNR/3_y6
118149_AHIAYLPSDGR/2_y8
## 5
## 6
118149_AHIAYLPSDGR/2_y8
##
## 1
## 2
## 3
## 4

BioReplicate Condition Run
2
3
4
1

Strep0
Strep10
Strep10
Strep0

NA
NA
NA
NA
NA
NA

2
1
2
1

FragmentIon ProductCharge IsotopeLabelType Intensity
4752
6144
3722
6624
4036
1642

light
light
light
light
light
light

8

## 5
## 6

1
1

Strep0
Strep10

1
3

Convert the data into the format required by mapDIA.
mapDIA.input <- convert4mapDIA(data.transition)
head(mapDIA.input)

PeptideSequence
##
ProteinName
AEAAIYQFLEAIGENPNR
## 1 Spyo_Exp3652_DDB_SeqID_1571119
AHIAYLPSDGR
## 2 Spyo_Exp3652_DDB_SeqID_1571119
## 3 Spyo_Exp3652_DDB_SeqID_1571119
EEFTAVFK
## 4 Spyo_Exp3652_DDB_SeqID_1571119 EKAEAAIYQFLEAIGENPNR
## 5 Spyo_Exp3652_DDB_SeqID_1571119
EQHEDVVIVK
LTSQIADALVEALNPK
## 6 Spyo_Exp3652_DDB_SeqID_1571119
##
## 1 105801_AEAAIYQFLEAIGENPNR/3_y6
118149_AHIAYLPSDGR/2_y8
## 2
35179_EEFTAVFK/2_y5
## 3
## 4 28903_EKAEAAIYQFLEAIGENPNR/3_y6
## 5
73581_EQHEDVVIVK/2_b6
115497_LTSQIADALVEALNPK/2_y11
## 6

FragmentIon Strep0_1 Strep0_2 Strep10_1 Strep10_2
3722
720
NaN
1984
NaN
NaN

4752
2405
1541
2185
1343
6349

6144
1642
1561
NaN
NaN
NaN

6624
4036
2307
3410
2423
6553

Convert the data into the format required by aLFQ.
aLFQ.input <- convert4aLFQ(data.transition)

## Checking the integrity of the transitions takes a lot of time.
##
head(aLFQ.input)

To speed up consider changing the option.

run_id

protein_id

transition_id

##
peptide_id
## 1 Strep0_2_2 Spyo_Exp3652_DDB_SeqID_1571119 AEAAIYQFLEAIGENPNR
## 2 Strep10_1_3 Spyo_Exp3652_DDB_SeqID_1571119 AEAAIYQFLEAIGENPNR
## 3 Strep10_2_4 Spyo_Exp3652_DDB_SeqID_1571119 AEAAIYQFLEAIGENPNR
## 4 Strep0_1_1 Spyo_Exp3652_DDB_SeqID_1571119 AEAAIYQFLEAIGENPNR
AHIAYLPSDGR
## 5 Strep0_1_1 Spyo_Exp3652_DDB_SeqID_1571119
## 6 Strep10_1_3 Spyo_Exp3652_DDB_SeqID_1571119
AHIAYLPSDGR
##
peptide_sequence
## 1 AEAAIYQFLEAIGENPNR 105801_AEAAIYQFLEAIGENPNR/3_y6 AEAAIYQFLEAIGENPNR
## 2 AEAAIYQFLEAIGENPNR 105801_AEAAIYQFLEAIGENPNR/3_y6 AEAAIYQFLEAIGENPNR
## 3 AEAAIYQFLEAIGENPNR 105801_AEAAIYQFLEAIGENPNR/3_y6 AEAAIYQFLEAIGENPNR
## 4 AEAAIYQFLEAIGENPNR 105801_AEAAIYQFLEAIGENPNR/3_y6 AEAAIYQFLEAIGENPNR
AHIAYLPSDGR
AHIAYLPSDGR 118149_AHIAYLPSDGR/2_y8
## 5
AHIAYLPSDGR
AHIAYLPSDGR 118149_AHIAYLPSDGR/2_y8
## 6
##
## 1
## 2
## 3
## 4
## 5
## 6

precursor_charge transition_intensity concentration
?
?
?
?
?
?

4752
6144
3722
6624
4036
1642

3
3
3
3
2
2

Session info on the R version and packages used.
sessionInfo()

9

LAPACK version 3.12.0

base

methods

datasets

graphics

grDevices utils

/home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so

LC_NUMERIC=C
LC_COLLATE=C
LC_MESSAGES=en_US.UTF-8
LC_NAME=C
LC_TELEPHONE=C

## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0
##
## locale:
## [1] LC_CTYPE=en_US.UTF-8
## [3] LC_TIME=en_GB
## [5] LC_MONETARY=en_US.UTF-8
## [7] LC_PAPER=en_US.UTF-8
## [9] LC_ADDRESS=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats
##
## other attached packages:
## [1] data.table_1.18.0
##
## loaded via a namespace (and not attached):
## [1] KEGGREST_1.50.0
## [4] ggplot2_4.0.1
## [7] vctrs_0.6.5
## [10] stats4_4.5.2
## [13] AnnotationDbi_1.72.0 RSQLite_2.4.5
## [16] pkgconfig_2.0.3
## [19] S7_0.2.1
## [22] compiler_4.5.2
## [25] Biostrings_2.78.0
## [28] Seqinfo_1.0.0
## [31] pillar_1.11.1
## [34] tidyselect_1.2.1
## [37] dplyr_1.1.4
## [40] biomaRt_2.66.0
## [43] cli_3.6.5
## [46] withr_3.0.2
## [49] scales_1.4.0
## [52] rmarkdown_2.30
## [55] bit_4.6.0
## [58] hms_1.1.4
## [61] knitr_1.51
## [64] rlang_1.1.6
## [67] DBI_1.2.3
## [70] R6_2.6.1

dbplyr_2.5.1
S4Vectors_0.48.0
farver_2.1.2
progress_1.2.3
htmltools_0.5.9
crayon_1.5.3
digest_0.6.39
reshape2_1.4.5
fastmap_1.2.0
magrittr_2.0.4
prettyunits_1.2.0
rappdirs_0.3.3
XVector_0.50.0
otel_0.2.0
memoise_2.0.1
IRanges_2.44.0
Rcpp_1.1.0
formatR_1.14
plyr_1.8.9

xfun_0.55
Biobase_2.70.0
generics_0.1.4
tibble_3.3.0
blob_1.2.4
RColorBrewer_1.1-3
lifecycle_1.0.4
stringr_1.6.0
tinytex_0.58
yaml_2.3.12
cachem_1.1.0
stringi_1.8.7
labeling_0.4.3
grid_4.5.2
dichromat_2.0-0.1
filelock_1.0.3
bit64_4.6.0-1
httr_1.4.7
png_0.1-8
evaluate_1.0.5
BiocFileCache_3.0.0
glue_1.8.0
BiocGenerics_0.56.0

gtable_0.3.6
httr2_1.2.2
tools_4.5.2
curl_7.0.0

SWATH2stats_1.40.1

10

