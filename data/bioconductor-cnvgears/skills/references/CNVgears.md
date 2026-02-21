# CNVgears package.

#### 19 May 2021

# Contents

* [1 Initial Note](#initial-note)
* [2 Introduction](#introduction)
* [3 Main Steps](#main-steps)
* [4 Setup](#setup)
  + [4.1 Install](#install)
  + [4.2 Load library](#load-library)
  + [4.3 Set data.table threads](#set-data.table-threads)
* [5 Data Load](#data-load)
  + [5.1 Cohort PED and Markers data](#cohort-ped-and-markers-data)
  + [5.2 CNV Calling Results and Markers-level raw data](#cnv-calling-results-and-markers-level-raw-data)
  + [5.3 `cn.mops` package results loading](#cn.mops-package-results-loading)
* [6 Data integration and processing](#data-integration-and-processing)
  + [6.1 Results exploration and filtering](#results-exploration-and-filtering)
  + [6.2 Inheritance pattern detection](#inheritance-pattern-detection)
  + [6.3 Inter-methods merging](#inter-methods-merging)
  + [6.4 CNV Regions Computation](#cnv-regions-computation)
  + [6.5 De-novo CNVs visual confirmation](#de-novo-cnvs-visual-confirmation)
* [7 Annotation](#annotation)
* [8 Visualization](#visualization)
* [9 Data export](#data-export)
* [10 Notes on Parallelization](#notes-on-parallelization)

# 1 Initial Note

The illustrative pipelines shown in this file uses real data from the 1000
Genomes project (<https://www.internationalgenome.org/>). The examples are
performed on array data for chromosomes 14 and 22 only and the raw final report
files provided as they are necessary for some critical steps of the pipeline.
Because those files are relatively large (> 5Mb) they are stored as a separate
GitHub repository (<https://github.com/SinomeM/CNVgears_data>). The user is kindly
asked to download the repo and give the directory path at the step 5.2 in order to
being able to perform all the examples.

# 2 Introduction

The CNVgears package aims to implement an interactive and extensible framework for
the analysis of Copy Number Variation calling and/or segmentation results, typically
from multiple pipelines or algorithms, regardless the initial raw data type. At
the moment Illumina SNPs array and any type of NGS data are supported, provided
that at least the raw log2R value, or any related measure is accessible for each
sample. The package is particularly suited for the analysis of family based studies,
however, the more vast majority of the functions are of general
purpose and useful for any CNVs study. Next session illustrate the pipeline main
steps and most of the package features using CNVs calling results on a subset
of the 1000 Genomes cohort. We created the subset using samples that creates full
trios and have both SNP array and WGS data available. However at the moment only
the arrays are used here. CNVs calling was performed using a modified minimal
version of EnsembleCNV.

# 3 Main Steps

CNVgears supports multiple analysis and cohort composition (e.g. family based or not)
as it is possible to perform all or only a fraction of these steps. As an example, if the
cohort is not family based, if CNVs inheritance pattern is not a desired information
or if the markers-level raw data is not available, the raw data load step can be
easily skip. The package can be used also only to combine the results of different
methods in a uniform format and export the output to be processed in other programs.

The typical main steps of such analysis using CNVgears are:

1. Load the cohort minimal metadata in the form of PED file (mandatory);
2. Load the markers file (i.e. genomic location of each marker, SNP in case of
   array, interval/bin in case of NGS data) (mandatory);
3. Read and pre-process the CNVs calling results for all samples from the
   individual algorithms/pipelines, in particular adjacent calls with equal
   genotype (i.e. deletions/duplications) can be merged if closer than
   user-specified distances (mandatory);
4. Read and pre-process the “raw data” (in particular the log2R for each marker
   for all samples) (not mandatory but required for CNVs inheritance detection);
5. Explore the sample’s summary statistics, identify groups of unwanted events
   (e.g. smaller then 5 kbp or consisting of less than 5 points) and possible
   over-segmented samples (not mandatory but strongly suggested);
6. Filter the results based on several parameters and blacklist (both provided
   by the package and user-generated), such as immunoglobulin and
   telomeric/centromeric regions. Also more extreme intra-results merging can be
   performed if one or more methods appear to over-segment (not mandatory but
   strongly suggested);
7. Detect CNVs inheritance pattern, if families structure is given (not mandatory);
8. Visually inspect the good de novo CNVs candidate raw data (not mandatory,
   strongly suggested in the case of de novo CNVs, require the previous step);
9. Merge the various methods results in a single object (not mandatory, however
   this is one of the main points of the package);
10. Second round of filtering, keep only the call made by N (one or more)
    algorithms/pipelines (not mandatory, requires the previous step);
11. Annotate genomic locus of the calls and search for CNVs in known
    disease-linked loci (e.g. in studies on ASD or schizophrenia) (not mandatory);
12. Annotate genic content of selected CNVs (not mandatory);
13. Compute CNV regions (CNVRs) (not mandatory);
14. Extract high confidence rare events based on CNVRs (not mandatory, requires
    the previous step);
15. Export desired data. Several format are supported, such as BED (e.g. for
    being viewed in IGV) or VCF (e.g. for being processed with Annovar), as well
    as TSV (not mandatory).

# 4 Setup

## 4.1 Install

CNVgears is part of Bioconductor (<https://bioconductor.org>), to install it
using `BiocManager`:

```
if (!require("BiocManager"))
    install.packages("BiocManager")

BiocManager::install("CNVgears")
```

Until Biconductor 3.14 it can be found in the devel branch.

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

# The following initializes usage of Bioc devel
BiocManager::install(version='devel')

BiocManager::install("CNVgears")
```

To install the latest development version of the package via GitHub repository:

```
# not run
devtools::install_github("SinomeM/CNVgears")
```

## 4.2 Load library

To load the package.

```
library(CNVgears, quietly = TRUE)
```

## 4.3 Set data.table threads

All the major functions uses `data.table` package, especially in the more intensive
steps. The package uses by default half the CPU threads available, this can be changed
with the function `data.table::setDTthreads`. For example to use the 75% of available
threads or an integer number (four in the example) of them:

```
data.table::setDTthreads(percent=75)
data.table::setDTthreads(4)
```

Empirically, we found the ideal number of threads being between 4 and 8.
See the relative man pages for details on each function used.

# 5 Data Load

## 5.1 Cohort PED and Markers data

The first two objects we need to load are the cohort and markers information. The
first object is loaded from a PED file from with the following columns are extracted:
Sample ID, Family ID, sex and role (proband/sibling/mother/father). Role information
needs to be present only if CNV inheritance detection is a desired step. The second
object contains the genomic location of the markers used for CNV calling, thus the
SNPs in case of DNA chip and genomic intervals if WES/WGS. The following columns are
needed: SNP ID (only for DNA chips), chromosome, start, end. One of these objects
is needed for each data type used for calling. Here we used only SNP arrays so only
one markers object is needed.
In the package are bundled CNV calling results of three different algorithms for
chromosomes 14 and 22 of 24 samples from the 1000 Genomes project, as well as a PED
file of the cohort and the markers-level raw data for a single trio (within the
24 samples).

```
# cohort data
cohort <- read_metadt(DT_path = system.file("extdata", "cohort.ped",
                                            package = "CNVgears"),
                      sample_ID_col = "Individual ID",
                      fam_ID_col = "Family ID",
                      sex_col = "Gender", role_col = "Role")
head(cohort)
#>    sample_ID sex    role fam_ID
#> 1:   NA12878   2 sibling   1463
#> 2:   NA12891   1  father   1463
#> 3:   NA12892   2  mother   1463
#> 4:   NA11840   2  mother   1349
#> 5:   NA11843   1  father   1349
#> 6:   NA11881   1  father   1347

# markers location
SNP_markers <- read_finalreport_snps(system.file("extdata", "SNP.pfb",
                                                 package = "CNVgears"),
                                     mark_ID_col = "Name", chr_col = "Chr",
                                     pos_col = "Position")
head(SNP_markers)
#>            SNP_ID chr    start      end P_ID
#> 1: SNP14-18070480  14 18070480 18070480    1
#> 2: SNP14-18074211  14 18074211 18074211    2
#> 3: SNP14-18075102  14 18075102 18075102    3
#> 4: SNP14-18080693  14 18080693 18080693    4
#> 5: SNP14-18082028  14 18082028 18082028    5
#> 6: SNP14-18090808  14 18090808 18090808    6
```

## 5.2 CNV Calling Results and Markers-level raw data

Then we load the actual CNV calling results and the marker-level raw data.
The results are loaded in the session as R objects, while the raw data are
processed and stored as RDS one chromosome at the time. The RDS files will be
loaded only when necessary in order
to reduce the RAM requirements of processing results from very large cohorts
and/or from several methods.
In this scenario the raw data consist of the SNP array only, thus we can process
them one single time and use them for all the three callers results.
Note that during the importing of the results an intra-method CNV merging step is
performed, i.e. adjacent call are merged into a single one if requirements are met.
This step is performed by default but can be avoided by setting `do_merge` parameter
to `FALSE`. The resulting objects are of the class `CNVresults`.

```
# CNV calling results
penn <- read_results(DT_path = system.file("extdata",
                                           "chrs_14_22_cnvs_penn.txt",
                                           package = "CNVgears"),
                     res_type = "file", DT_type = "TSV/CSV",
                     chr_col = "chr", start_col = "posStart",
                     end_col = "posEnd", CN_col = "CN",
                     samp_ID_col = "Sample_ID", sample_list = cohort,
                     markers = SNP_markers, method_ID = "P")
head(penn)
#>    chr     start       end CN sample_ID GT first_P last_P NP    len seg_ID
#> 1:  14 105765452 105847784  3   NA12878  2   78998  79029 32  82333      1
#> 2:  14 105866436 105887901  1   NA12878  1   79035  79037  3  21466      2
#> 3:  14 105899453 106106393  3   NA12878  2   79038  79112 75 206941      3
#> 4:  22  20824864  20841719  3   NA12878  2   83965  83997 33  16856      4
#> 5:  22  20892562  20931293  1   NA12878  1   84095  84155 61  38732      5
#> 6:  22  21060265  21090100  1   NA12878  1   84229  84247 19  29836      6
#>    meth_ID
#> 1:       P
#> 2:       P
#> 3:       P
#> 4:       P
#> 5:       P
#> 6:       P

quanti <- read_results(DT_path = system.file("extdata",
                                             "chrs_14_22_cnvs_quanti.txt",
                                             package = "CNVgears"),
                      res_type = "file", DT_type = "TSV/CSV",
                      chr_col = "chr", start_col = "posStart",
                      end_col = "posEnd", CN_col = "CN",
                      samp_ID_col = "Sample_ID", sample_list = cohort,
                      markers = SNP_markers, method_ID = "Q")

ipn <-  read_results(DT_path = system.file("extdata",
                                           "chrs_14_22_cnvs_ipn.txt",
                                           package = "CNVgears"),
                     res_type = "file", DT_type = "TSV/CSV",
                     chr_col = "chr", start_col = "posStart",
                     end_col = "posEnd", CN_col = "CN",
                     samp_ID_col = "Sample_ID", sample_list = cohort,
                     markers = SNP_markers, method_ID = "I")
```

```
# raw data
# not run. This step needs the additional data
library("data.table", quietly = TRUE)
setDTthreads(4)

read_finalreport_raw(DT_path = "PATH_TO_DOWNLOADED_DATA_DIRECTORY",
                     pref = NA, suff = ".txt",
                     rds_path = file.path("tmp_RDS"),
                     markers = SNP_markers,
                     sample_list = cohort[fam_ID == "1463", ])
```

Note that when loading the raw data only the trio is used as cohort. The samples
object is subset using a `data.table` query.

Now the initial step of data load and normalization is completed and all a series
of integration and analysis steps can take place.
Obviously, if more methods are used this initial step is longer, in particular if
also WGS and/or high density SNPs array data is used (because of the very high
number of markers). More examples will be added in future version of this vignette.

## 5.3 `cn.mops` package results loading

CNVs calling from NGS data Bioconductor package `cn.mops` uses `GRanges` objects as
results. In particular, the actual calls are stored in the `cnvs` slot. These can
be loaded into a `CNVgears` pipeline using the function `cnmops_to_CNVresults`
as shown here. Note that only calls in chromosomes 1:22 are supported by this package
at the moment.

```
## not run
library(cn.mops)
data(cn.mops)
resCNMOPS <- cn.mops(XRanges)
resCNMOPS <- calcIntegerCopyNumbers(resCNMOPS)
resCNMOPS_cnvs <- cnvs(resCNMOPS)

sample_list <- read_metadt("path/to/PED_like_file")
intervals <- read_NGS_intervals("path/to/markers/file")
cnmops_calls <- cnmops_to_CNVresults(resCNMOPS_cnvs, sample_list, intervals)
```

# 6 Data integration and processing

## 6.1 Results exploration and filtering

When analyzing CNVs calling or segmentation results, an important step is to filter
out undesired and/or noisy/unreliable calls. This package provide the means to do
so in an integrated an standardized manner using two functions: `summary_stats`
and `cleaning_filter`. The first produces several summary statistics and exploratory
plot on the results, both cohort-wise and samples-wise. They are designed for
interactive use, also more then one time if desired.
An example for one of the callers results.

```
sstatPenn <- summary(object = penn, sample_list = cohort,
                     markers = SNP_markers)
#>
#> Basic summary statistics...
#>
#> # samples: 23
#> # families: 9
#> # probands: 0
#> # segments (normal genotype, deletions, duplications): 172
#> # CNVs (deletions, duplications): 172
#> # deletions: 92
#> # duplications: 80
#> # CNVs per sample: 7.5
#>
#> Summary of CNVs length, len, and number of points (SNPs or intervals), NP in the results.
#>
#> CNVs length
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#>     184    9625   31565  113509  127341 1146278
#>
#> Deletions length
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#>     184    5000   16900   58309   46904  846719
#>
#> Duplications length
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#>    1660   16851   88457  176990  227142 1146278
#>
#> CNVs NP
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#>    3.00    9.00   18.00   37.82   38.00  458.00
#>
#> Deletions NP
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#>    3.00    7.00   13.00   24.99   27.25  458.00
#>
#> Duplications NP
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#>    4.00   13.75   30.50   52.58   72.75  292.00
#>
#> Number of CNVs, mean length and NP computed per sample, could help identifig over-segmented samples.
#> First and last 10 lines (most segmented samples first)...
#>     sample_ID n_cnvs  mean_NP  mean_len
#>  1:   NA12891     25 35.04000  87063.48
#>  2:   NA11992     13 46.30769 115276.62
#>  3:   NA11994     13 35.00000  86285.62
#>  4:   NA11840     11 19.90909  17237.82
#>  5:   NA12878      8 29.62500  76599.88
#>  6:   NA11893      8 80.37500 136523.25
#>  7:   NA11931      8 32.87500 155824.12
#>  8:   NA11995      8 46.87500  95909.75
#>  9:   NA12006      8 48.37500  92219.00
#> 10:   NA11881      7 17.85714  36989.00
#>     sample_ID n_cnvs  mean_NP  mean_len
#>  1:   NA11993      6 40.16667 156348.83
#>  2:   NA12005      6 31.83333 261371.50
#>  3:   NA11892      5 24.40000 108388.40
#>  4:   NA12043      5 45.60000 179167.20
#>  5:   NA11843      4 88.75000 295675.25
#>  6:   NA11920      4 34.25000 454433.00
#>  7:   NA11930      4 28.00000  47897.75
#>  8:   NA12892      3 41.66667 141247.33
#>  9:   NA11919      3 15.33333  24456.00
#> 10:   NA12003      2 52.50000 133992.00
#>
#> Summary on number of CNVs in the entire cohort..
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max.
#>   2.000   4.500   7.000   7.478   8.000  25.000
```

```
# not run
sstatPenn <- summary(object = penn, sample_list = cohort,
                     markers = SNP_markers,
                     plots_path = file.path("tmp","sstatPenn")) # plots are saved
```

Exploring these summary statistics can provide important insights on the cohort
composition and on the differences between the individual callers. Obviously, the
process is completely optional, and we provide default values for the filtering
function based on literature and our experience.
The output of summary can help identifying over-segmented samples.

```
head(sstatPenn)
#>    sample_ID n_cnvs  mean_NP  mean_len
#> 1:   NA12891     25 35.04000  87063.48
#> 2:   NA11992     13 46.30769 115276.62
#> 3:   NA11994     13 35.00000  86285.62
#> 4:   NA11840     11 19.90909  17237.82
#> 5:   NA12878      8 29.62500  76599.88
#> 6:   NA11893      8 80.37500 136523.25
```

```
penn_filtered <- cleaning_filter(results = penn, min_len = 10000, min_NP = 10)
quanti_filtered <- cleaning_filter(quanti)
ipn_filtered <- cleaning_filter(ipn)
```

It is also possible to filter calls based on blacklists, e.g. immunoglobulin regions
or telomers. In our package we provide two functions to generate immunoglobulin,
telomeric and centromeric regions for the hg18, hg19 and hg38 genome assemblies.
The user can specify the number of minimum consecutive immuno genes to create a
region and the desired telomers and centromers blacklists width. Here we create
those blacklists in hg19 as an example.
Note that the fucntion `immuno_regions` uses internally the package `biomaRt` that
work with the hg38 genome assembly by default. To work with older assemblies we
need to pass a custom `mart` object, as exemplified here.

```
hg19telom <- telom_centrom(hg19_start_end_centromeres, centrom = FALSE)
hg19centrom <- telom_centrom(hg19_start_end_centromeres, telom = FALSE,
                             region = 25000)
```

```
ensembl37 <- biomaRt::useMart("ENSEMBL_MART_ENSEMBL",
                              host = "grch37.ensembl.org",
                              dataset="hsapiens_gene_ensembl")
hg19_immuno <- immuno_regions(n_genes = 10, mart = ensembl37)
```

A blacklist can be any `data.table` with at least these three columns: chr, start,
end. Users should be particularly careful when filtering using blacklists as
it is possible to filter out relevant data.

```
head(hg19telom)
#>    chr     start       end
#> 1:   1         0     50000
#> 2:   1 249200621 249250621
#> 3:  10         0     50000
#> 4:  10 135484747 135534747
#> 5:  11         0     50000
#> 6:  11 134956516 135006516
```

## 6.2 Inheritance pattern detection

In family-based cohort studies, CNV inheritance detection is possible. However,
because the process of CNVs calling tends to be imprecise, both false positive and
false negative are present in the results. This is in part solved with the filtering
process and can be solved combining more than one methods results.

Here, to identify good *de-novo* candidates hits as well as inherited events we
use the function `cnvs_inheritance` that integrates three screening steps,
both at segment-level and at marker-level. The first step, for every CNVs in an
offspring, searches compatible CNVs in both parents (i.e. with 30% reciprocal
overlap, by default). If an hit is found the CNVs is inherited, if not it is
considered a putative *de-novo* ad undergoes the successive marker-level screenings.
At this point the CopyRatio values for all the markers in the region are considered
in the trio. A first screening consider as potentially inherited all the putative
*de-novo* events of the offspring for witch a parent have more than 75% compatible
markers points in the regions, i.e. markers with a CopyRatio < 0.75 if the CNV is
a deletion or a CopyRatio > 1.25 if the CNV is a duplication. This step is mostly
needed to speed up the function and will be made optional in near future.

For autosomal chromosomes

\[LRR = log2R = log2(CopyRatio) = log2(numeric\_{CN}/2)\]

The putative *de-novo* events that survive undergo the final screening. This can
be performed in several way, at the moment the suggested and most supported is the
following. In brief for both pairs parent-offspring the mean of the CopyRatio values
are compared using a Wilcox test. Under the null hypothesis that the difference of
the two means is zero, we test if a difference is statistically significant, i.e.
if the resulting p-value is lower than a user-defined alpha (default value is 0.05).
If the test has a positive outcome for both parents than the CNV is defined as a
good de-novo candidate. The two p-values from each comparison are stored in the
dataset and, when all the individual comparison are done, two additional columns
containing the adjusted p-values are computed, leaving to the user the choice of
which sets of p-value use.

```
# not run, needs the additional raw data
penn_inheritance <-
  cnvs_inheritance(results = penn_filtered, sample_list =  cohort[fam_ID == "1463", ],
                   markers = SNP_markers, raw_path = file.path("tmp_RDS"))
quanti_inheritance <-
  cnvs_inheritance(results = quanti_filtered, sample_list =  cohort[fam_ID == "1463", ],
                   markers = SNP_markers, raw_path = file.path("tmp_RDS"))
ipn_inheritance <-
  cnvs_inheritance(results = ipn_filtered, sample_list =  cohort[fam_ID == "1463", ],
                   markers = SNP_markers, raw_path = file.path("tmp_RDS"))

penn_denovo <- penn_inheritance[inheritance == "denovo", ]
quanti_denovo <- quanti_inheritance[inheritance == "denovo", ]
ipn_denovo <- ipn_inheritance[inheritance == "denovo", ]
```

Note that inheritance detection is performed separately for each method, in this
way it is possible to use marker-level raw data. However, when all the results use
the same raw data (as in in this vignette, at the moment), it is also possible to
first combine the results (see next section) an only then perform inheritance
detection.

## 6.3 Inter-methods merging

At this point we can integrate the multiple methods results into a single object.
As exemplification of a real pipeline we also process the *de-novo* calls.

```
ipq_filtered <-
  inter_res_merge(res_list = list(penn_filtered, quanti_filtered, ipn_filtered),
                  sample_list = cohort, chr_arms = hg19_chr_arms)
```

```
# not run, it needs inheritance detection step
ipq_denovo <-
  inter_res_merge(res_list = list(penn_denovo, quanti_denovo, ipn_denovo),
                  sample_list = cohort, chr_arms = hg19_chr_arms)
```

At this point it is possible to perform a second filtering step based on the number
of calling methods, e.g. filter out all the calls made by one single algorithm.

Note how the merge perform **reciprocal** overlap comparison in order to merge two
calls. Candidate events should thus not only overlap but must also be of comparable
size.

## 6.4 CNV Regions Computation

Copy Number Variable Regions can be defined in several ways, an intuitive way to
visualize them is: regions of the human genomes were CNVs (of comparable size) are
present across samples in a population. This can be due for examples because such
region is bordered by two particularly active breakpoints. CNVRs can be used for
CNVs-GWAS and, more easily, to extract rare events from a cohort.
In this package, we provide a method to compute Copy Number Variable Regions (CNVRs),
based on reciprocal overlap, starting from the integrated object created in the
previous step. See the `?cnvrs_create` for details.

```
cnvrs_chr22 <- cnvrs_create(cnvs = ipq_filtered[chr == 22,],
                            chr_arms = hg19_chr_arms)
#>
#> -- Computing CNVRs in chromosome arm:1p--
#>
#> -- Computing CNVRs in chromosome arm:1q--
#>
#> -- Computing CNVRs in chromosome arm:10p--
#>
#> -- Computing CNVRs in chromosome arm:10q--
#>
#> -- Computing CNVRs in chromosome arm:11p--
#>
#> -- Computing CNVRs in chromosome arm:11q--
#>
#> -- Computing CNVRs in chromosome arm:12p--
#>
#> -- Computing CNVRs in chromosome arm:12q--
#>
#> -- Computing CNVRs in chromosome arm:13p--
#>
#> -- Computing CNVRs in chromosome arm:13q--
#>
#> -- Computing CNVRs in chromosome arm:14p--
#>
#> -- Computing CNVRs in chromosome arm:14q--
#>
#> -- Computing CNVRs in chromosome arm:15p--
#>
#> -- Computing CNVRs in chromosome arm:15q--
#>
#> -- Computing CNVRs in chromosome arm:16p--
#>
#> -- Computing CNVRs in chromosome arm:16q--
#>
#> -- Computing CNVRs in chromosome arm:17p--
#>
#> -- Computing CNVRs in chromosome arm:17q--
#>
#> -- Computing CNVRs in chromosome arm:18p--
#>
#> -- Computing CNVRs in chromosome arm:18q--
#>
#> -- Computing CNVRs in chromosome arm:19p--
#>
#> -- Computing CNVRs in chromosome arm:19q--
#>
#> -- Computing CNVRs in chromosome arm:2p--
#>
#> -- Computing CNVRs in chromosome arm:2q--
#>
#> -- Computing CNVRs in chromosome arm:20p--
#>
#> -- Computing CNVRs in chromosome arm:20q--
#>
#> -- Computing CNVRs in chromosome arm:21p--
#>
#> -- Computing CNVRs in chromosome arm:21q--
#>
#> -- Computing CNVRs in chromosome arm:22p--
#>
#> -- Computing CNVRs in chromosome arm:22q--
#>
#> Creating/filling CNVRs, loop #1...
#> 87 CNVs to be assigned
#>
#> Re-checking CNVRs 1...
#> CNVR updated
#> CNVR updated
#> CNVR updated
#>
#> Re-checking CNVRs 2...
#>
#> Re-checking CNVs ...
#> 0 CNVs removed from the assigned CNVR
#>
#> -- Computing CNVRs in chromosome arm:23p--
#>
#> -- Computing CNVRs in chromosome arm:23q--
#>
#> -- Computing CNVRs in chromosome arm:24p--
#>
#> -- Computing CNVRs in chromosome arm:24q--
#>
#> -- Computing CNVRs in chromosome arm:3p--
#>
#> -- Computing CNVRs in chromosome arm:3q--
#>
#> -- Computing CNVRs in chromosome arm:4p--
#>
#> -- Computing CNVRs in chromosome arm:4q--
#>
#> -- Computing CNVRs in chromosome arm:5p--
#>
#> -- Computing CNVRs in chromosome arm:5q--
#>
#> -- Computing CNVRs in chromosome arm:6p--
#>
#> -- Computing CNVRs in chromosome arm:6q--
#>
#> -- Computing CNVRs in chromosome arm:7p--
#>
#> -- Computing CNVRs in chromosome arm:7q--
#>
#> -- Computing CNVRs in chromosome arm:8p--
#>
#> -- Computing CNVRs in chromosome arm:8q--
#>
#> -- Computing CNVRs in chromosome arm:9p--
#>
#> -- Computing CNVRs in chromosome arm:9q--
#>
#> CNVRs final check...
```

CNVRs can also be used for filtering purposes, as an example a user can be more
interested in rare events and use CNVRs frequency to achieve this internally.
Rare (within the cohort) calls can be obtained filtering out the common CNVRs, as
follows.

```
# define common CNVR as the one present in > 5% of the cohort
# here the cohort is very small so it won't be a significative result
common_cnvrs_chr22 <- cnvrs_chr22[[1]][freq > nrow(cohort)*0.5, ]
rare_cvns_chr22 <- cnvrs_chr22[[2]][!cnvr %in% common_cnvrs_chr22$r_ID, ]
```

## 6.5 De-novo CNVs visual confirmation

In the package it is also implemented a function to visually inspect the de-novo
candidates. We use as an example the two calls detected by both PennCNV and
QantiSNP and the larger one made by IPattern.

```
# not run, it needs inheritance detection step
lrr_trio_plot(cnv = ipq_denovo[1], raw_path =  file.path("tmp_RDS"),
              sample_list = cohort, results = ipn_filtered)
lrr_trio_plot(cnv = ipq_denovo[2], raw_path =  file.path("tmp_RDS"),
              sample_list = cohort, results = ipn_filtered)
lrr_trio_plot(cnv = ipq_denovo[3], raw_path =  file.path("tmp_RDS"),
              sample_list = cohort, results = ipn_filtered)
```

Note that the two calls are quite close.

# 7 Annotation

The package include also some annotation functions, for extracting both the CNVs
locus and affected genes. At the moment the affected genes are listed using “-”
separated Ensemble IDs.
As `immuno_regions`, the function `genic_load` uses `biomaRt` internally, thus a
custom mart is needed to work in hg19.

```
# locus

ensembl37 <- biomaRt::useMart("ENSEMBL_MART_ENSEMBL",
                              host = "grch37.ensembl.org",
                              dataset="hsapiens_gene_ensembl")

ipq_denovo_genes <- genic_load(DT_in = ipq_filtered, mart = ensembl37)

rm(ensembl37)
```

# 8 Visualization

All CNVs from an offspring (not only the de novo ones) can be visualized in the raw
data using the function `lrr_trio_plot`. A simpler function to visualize one single
event without any focus on family relations will be implemented soon. Integration
with the package `IGVR` is also planned.

# 9 Data export

All the major object handled by the package are `data.table`. Thus to export outside
of R an object (as an example the output of the combination of several methods
results) it is possible to use `data.table` semantics and functions.

```
## not run

# Select a subset of columns using DT[, .(col1,col2,coln)]
tmp <- ipq_filtered[, .(sample_ID, chr, start, end, GT, meth_ID)]
head(tmp, 3)

# Select a subset of rows (i.e. filter) using DT[condition, ]
tmp <- ipq_filtered[n_meth > 1, .(sample_ID, chr, start, end, GT, meth_ID)]
head(tmp, 3)

# Export object as a TSV
fwrite(tmp, "example.tsv", sep = "\t")
```

As an example to create a BED4 file were the entries names consist of
`sample_ID"-"GT` that can be loaded in IGV we do:

```
tmp <- ipq_filtered[, .(chr, start, end, paste0(sample_ID, "-", GT))]
head(tmp)
#>    chr    start      end        V4
#> 1:  14 18070480 18117862 NA12891-2
#> 2:  14 18070480 18117862 NA11840-2
#> 3:  14 18070480 18117862 NA11894-2
#> 4:  14 18070480 18117862 NA11930-2
#> 5:  14 18070480 18117862 NA11931-2
#> 6:  14 18070480 18117862 NA12006-2
```

```
## not run
fwrite(tmp, "example.bed", sep = "\t", col.names = FALSE)
```

Objects of the class `CNVresults` can also be converted into `GenomicRanges::GRanges()`
using the function `CNVresults_to_GRanges`. Required columns (and thus maintained
in the resulting object) are: chr, start, end, sample\_ID, GT, meth\_ID. The last
three columns will be placed in the `metadata` field.
In the near future a more general function to convert all the major object into
`GRanges` as well as `GRangesList` (e.g. for integration with `CNVranger`
package) will be implemented.

```
ipq_filtered_GRanges <- CNVresults_to_GRanges(ipq_filtered)
```

`data.table` queries can also be used to easily extract subset of interest from the
results. Some relevant examples are shown here.

```
# only call with > 1 calling methods
tmp <- ipq_filtered[n_meth > 1, ]

# de novo CNVs with a significant corrected p-value (note that the p-values are
# lost when combining more result-objects)
tmp <- penn_inheritance[adj_m_pval < 0.05 & adj_p_pval < 0.05, ]
```

# 10 Notes on Parallelization

As already mentioned, this package use `data.table` whenever is possible to handle
the big tables that working with large cohorts produces and `data.table` is internally
parallelized. As a consequence, most of the function already use more than one
thread an should be run serially on system with a low number of CPU cores. On more
CPU and RAM equipped systems however, the user may want to parallelize the longer
steps. This can be done easily on two particularly long steps, i.e. the results and
the markers-level raw data load. The suggested way for `read_results` is to split
the `sample_list` object in two or more batches, run `read_results` in parallel
on those batches, and finally combine the objects into a final one. The raw data
processing do not produce any object, as it stores all its results into `RDS` files
named after the individual samples, so it can be run as parallel as the user desire,
again by simply generating subsets of the `sample_list` object. Ideally, the entire
pipeline (excluding for obvious reasons CNVRs creation, in that case it is possible
to run subset of chromosomes in parallel) can be run in parallel on
more than one cohort subsets, as long as families are kept together. However, in
order to have a better view on the cohort summary statistics and the filtering
procedure effect, it is recommended to perform at least those steps on the entire
dataset. While parallelizing the user should always keep in mind that `data.table`
uses more than one thread by default, so `data.table::setDTthreads()` should always
be set appropriately.
Again, empirically we found that the optimal number of threads is between 2 and 8 depending
on the number of total accessible threads and the amount of formal, external
parallelization desired, as more tend to increase the process speed rather than
increasing it.