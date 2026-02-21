# Predicting TAD/loop boundaries using pre-trained models provided by preciseTADhub

Spiro Stilianoudakis1 and Mikhail Dozmorov1

1Department of Biostatistics, Virginia Commonwealth University, Richmond, VA

#### November 4, 2025

#### Package

preciseTADhub 1.18.0

# Contents

* [1 Introduction](#introduction)
* [2 Getting Started](#getting-started)
  + [2.1 Installation](#installation)
  + [2.2 Reading in a file stored on ExperimentHub](#reading-in-a-file-stored-on-experimenthub)
* [3 Use the pre-trained model to predict TAD boundaries on the holdout chromosome (CHR22) for GM12878 between coordinates 18000000-19000000 at base-level resolution](#use-the-pre-trained-model-to-predict-tad-boundaries-on-the-holdout-chromosome-chr22-for-gm12878-between-coordinates-18000000-19000000-at-base-level-resolution)

# 1 Introduction

`preciseTADhub` is an ExperimentData R package that supplements the `preciseTAD` software R package. `preciseTADhub` offers users access to pre-trained random forest classification models used to predict TAD/loop boundary regions. The model building process introduced by `preciseTAD` (<https://doi.org/10.1101/2020.09.03.282186>) can be computationally intensive. To avoid this burden, we have provided users with 84 (2 cell lines \(\times\) 2 ground truth boundaries \(\times\) 21 autosomal chromosomes) .RDS files containing pre-trained models that can be leveraged to predict TAD and/or chromatin loop boundaries at base-level resolution using functionality provided by [preciseTAD](https://bioconductor.org/packages/devel/bioc/vignettes/preciseTAD/inst/doc/preciseTAD.html).

Each of the 84 files are stored as lists containing two objects: 1) a train object from with RF model information, and 2) a data.frame of variable importance for each genomic annotation included in the model. The file names are structured as follows:

\(i\)*\(j\)*\(k\)\_\(l\).rds

where \(i\) denotes the chromosome that was used as a holdout {CHR1, CHR2, …, CHR21, CHR22} (i.e. for testing; meaning all other chromosomes were used for training), \(j\) denotes the cell line {GM12878, K562}, \(k\) denotes the resolution (size of genomic bins) {5kb, 10kb}, and \(l\) denotes the TAD/loop caller used to define ground truth {Arrowhead, Peakachu}.

For example the file named “CHR1\_GM12878\_5kb\_Arrowhead.rds” is a list whose first item is a RF model that was built on data for chromosomes 2-22 (omitting CHR9; see <https://doi.org/10.1101/2020.09.03.282186>), binned using 5 kb bins, ground truth TAD boundaries were identified using the Arrowhead TAD caller at 5 kb on GM12878. All models included the same number of predictors including CTCF, RAD21, SMC3, and ZNF143. The second item in the list is a data.frame with variable importances for CTCF, RAD21, SMC3, and ZNF143.

The pre-trained models set up users to apply them to predict their own boundaries on chromosomes that were heldout, per the framework in the preciseTAD paper (<https://doi.org/10.1101/2020.09.03.282186>).

# 2 Getting Started

The following is an example of how to predict TAD boundaries at base-level resolution for CHR22 on GM12878, using a pre-trained model stored in `preciseTADhub`.

## 2.1 Installation

```
#if (!requireNamespace("BiocManager", quietly = TRUE))
#    install.packages("BiocManager")
#BiocManager::install(c("ExperimentHub"), version = "3.12")

library(ExperimentHub)
library(preciseTAD)
library(preciseTADhub)
```

## 2.2 Reading in a file stored on ExperimentHub

Table 1 shows the file names and the corresponding ExperimentHub (EH) IDs. Since we want to make TAD boundary predictions on CHR22 for GM12878, we opt to read in the “CHR22\_GM12878\_5kb\_Arrowhead.rds” file. This corresponds to the EH3895 EHID.

File names and corresponding ExperimentHub (EH) IDs for all 84 .RDS files stored in `preciseTADhub`.

| FileName | EHID |
| --- | --- |
| CHR1\_GM12878\_5kb\_Arrowhead.rds | EH3815 |
| CHR1\_GM12878\_10kb\_Peakachu.rds | EH3816 |
| CHR1\_K562\_5kb\_Arrowhead.rds | EH3817 |
| CHR1\_K562\_10kb\_Peakachu.rds | EH3818 |
| CHR2\_GM12878\_5kb\_Arrowhead.rds | EH3819 |
| CHR2\_GM12878\_10kb\_Peakachu.rds | EH3820 |
| CHR2\_K562\_5kb\_Arrowhead.rds | EH3821 |
| CHR2\_K562\_10kb\_Peakachu.rds | EH3822 |
| CHR3\_GM12878\_5kb\_Arrowhead.rds | EH3823 |
| CHR3\_GM12878\_10kb\_Peakachu.rds | EH3824 |
| CHR3\_K562\_5kb\_Arrowhead.rds | EH3825 |
| CHR3\_K562\_10kb\_Peakachu.rds | EH3826 |
| CHR4\_GM12878\_5kb\_Arrowhead.rds | EH3827 |
| CHR4\_GM12878\_10kb\_Peakachu.rds | EH3828 |
| CHR4\_K562\_5kb\_Arrowhead.rds | EH3829 |
| CHR4\_K562\_10kb\_Peakachu.rds | EH3830 |
| CHR5\_GM12878\_5kb\_Arrowhead.rds | EH3831 |
| CHR5\_GM12878\_10kb\_Peakachu.rds | EH3832 |
| CHR5\_K562\_5kb\_Arrowhead.rds | EH3833 |
| CHR5\_K562\_10kb\_Peakachu.rds | EH3834 |
| CHR6\_GM12878\_5kb\_Arrowhead.rds | EH3835 |
| CHR6\_GM12878\_10kb\_Peakachu.rds | EH3836 |
| CHR6\_K562\_5kb\_Arrowhead.rds | EH3837 |
| CHR6\_K562\_10kb\_Peakachu.rds | EH3838 |
| CHR7\_GM12878\_5kb\_Arrowhead.rds | EH3839 |
| CHR7\_GM12878\_10kb\_Peakachu.rds | EH3840 |
| CHR7\_K562\_5kb\_Arrowhead.rds | EH3841 |
| CHR7\_K562\_10kb\_Peakachu.rds | EH3842 |
| CHR8\_GM12878\_5kb\_Arrowhead.rds | EH3843 |
| CHR8\_GM12878\_10kb\_Peakachu.rds | EH3844 |
| CHR8\_K562\_5kb\_Arrowhead.rds | EH3845 |
| CHR8\_K562\_10kb\_Peakachu.rds | EH3846 |
| CHR10\_GM12878\_5kb\_Arrowhead.rds | EH3847 |
| CHR10\_GM12878\_10kb\_Peakachu.rds | EH3848 |
| CHR10\_K562\_5kb\_Arrowhead.rds | EH3849 |
| CHR10\_K562\_10kb\_Peakachu.rds | EH3850 |
| CHR11\_GM12878\_5kb\_Arrowhead.rds | EH3851 |
| CHR11\_GM12878\_10kb\_Peakachu.rds | EH3852 |
| CHR11\_K562\_5kb\_Arrowhead.rds | EH3853 |
| CHR11\_K562\_10kb\_Peakachu.rds | EH3854 |
| CHR12\_GM12878\_5kb\_Arrowhead.rds | EH3855 |
| CHR12\_GM12878\_10kb\_Peakachu.rds | EH3856 |
| CHR12\_K562\_5kb\_Arrowhead.rds | EH3857 |
| CHR12\_K562\_10kb\_Peakachu.rds | EH3858 |
| CHR13\_GM12878\_5kb\_Arrowhead.rds | EH3859 |
| CHR13\_GM12878\_10kb\_Peakachu.rds | EH3860 |
| CHR13\_K562\_5kb\_Arrowhead.rds | EH3861 |
| CHR13\_K562\_10kb\_Peakachu.rds | EH3862 |
| CHR14\_GM12878\_5kb\_Arrowhead.rds | EH3863 |
| CHR14\_GM12878\_10kb\_Peakachu.rds | EH3864 |
| CHR14\_K562\_5kb\_Arrowhead.rds | EH3865 |
| CHR14\_K562\_10kb\_Peakachu.rds | EH3866 |
| CHR15\_GM12878\_5kb\_Arrowhead.rds | EH3867 |
| CHR15\_GM12878\_10kb\_Peakachu.rds | EH3868 |
| CHR15\_K562\_5kb\_Arrowhead.rds | EH3869 |
| CHR15\_K562\_10kb\_Peakachu.rds | EH3870 |
| CHR16\_GM12878\_5kb\_Arrowhead.rds | EH3871 |
| CHR16\_GM12878\_10kb\_Peakachu.rds | EH3872 |
| CHR16\_K562\_5kb\_Arrowhead.rds | EH3873 |
| CHR16\_K562\_10kb\_Peakachu.rds | EH3874 |
| CHR17\_GM12878\_5kb\_Arrowhead.rds | EH3875 |
| CHR17\_GM12878\_10kb\_Peakachu.rds | EH3876 |
| CHR17\_K562\_5kb\_Arrowhead.rds | EH3877 |
| CHR17\_K562\_10kb\_Peakachu.rds | EH3878 |
| CHR18\_GM12878\_5kb\_Arrowhead.rds | EH3879 |
| CHR18\_GM12878\_10kb\_Peakachu.rds | EH3880 |
| CHR18\_K562\_5kb\_Arrowhead.rds | EH3881 |
| CHR18\_K562\_10kb\_Peakachu.rds | EH3882 |
| CHR19\_GM12878\_5kb\_Arrowhead.rds | EH3883 |
| CHR19\_GM12878\_10kb\_Peakachu.rds | EH3884 |
| CHR19\_K562\_5kb\_Arrowhead.rds | EH3885 |
| CHR19\_K562\_10kb\_Peakachu.rds | EH3886 |
| CHR20\_GM12878\_5kb\_Arrowhead.rds | EH3887 |
| CHR20\_GM12878\_10kb\_Peakachu.rds | EH3888 |
| CHR20\_K562\_5kb\_Arrowhead.rds | EH3889 |
| CHR20\_K562\_10kb\_Peakachu.rds | EH3890 |
| CHR21\_GM12878\_5kb\_Arrowhead.rds | EH3891 |
| CHR21\_GM12878\_10kb\_Peakachu.rds | EH3892 |
| CHR21\_K562\_5kb\_Arrowhead.rds | EH3893 |
| CHR21\_K562\_10kb\_Peakachu.rds | EH3894 |
| CHR22\_GM12878\_5kb\_Arrowhead.rds | EH3895 |
| CHR22\_GM12878\_10kb\_Peakachu.rds | EH3896 |
| CHR22\_K562\_5kb\_Arrowhead.rds | EH3897 |
| CHR22\_K562\_10kb\_Peakachu.rds | EH3898 |

Suppose we want to read in the model that was built using CHR1-CHR21, on GM12878, using Arrowhead defined TAD boundaries at 5kb resolution. We can do this with the following wrapper function. Note: you must initialize `ExperimentHub` first.

```
#Initialize ExperimentHub
hub <- ExperimentHub()
query(hub, "preciseTADhub")
```

```
## ExperimentHub with 84 records
## # snapshotDate(): 2025-10-29
## # $dataprovider: preciseTAD
## # $species: Homo sapiens
## # $rdataclass: list
## # additional mcols(): taxonomyid, genome, description,
## #   coordinate_1_based, maintainer, rdatadateadded, preparerclass, tags,
## #   rdatapath, sourceurl, sourcetype
## # retrieve records with, e.g., 'object[["EH3815"]]'
##
##            title
##   EH3815 | CHR1_GM12878_5kb_Arrowhead.rds
##   EH3816 | CHR1_GM12878_10kb_Peakachu.rds
##   EH3817 | CHR1_K562_5kb_Arrowhead.rds
##   EH3818 | CHR1_K562_10kb_Peakachu.rds
##   EH3819 | CHR2_GM12878_5kb_Arrowhead.rds
##   ...      ...
##   EH3894 | CHR21_K562_10kb_Peakachu.rds
##   EH3895 | CHR22_GM12878_5kb_Arrowhead.rds
##   EH3896 | CHR22_GM12878_10kb_Peakachu.rds
##   EH3897 | CHR22_K562_5kb_Arrowhead.rds
##   EH3898 | CHR22_K562_10kb_Peakachu.rds
```

```
myfiles <- query(hub, "preciseTADhub")

CHR22_GM12878_5kb_Arrowhead <- readEH(chr = "CHR22", cl = "GM12878", gt = "Arrowhead", source = myfiles)
```

# 3 Use the pre-trained model to predict TAD boundaries on the holdout chromosome (CHR22) for GM12878 between coordinates 18000000-19000000 at base-level resolution

```
data("tfbsList")

# Restrict the data matrix to include only SMC3, RAD21, CTCF, and ZNF143
tfbsList_filt <- tfbsList[names(tfbsList) %in% c("Gm12878-Ctcf-Broad",
                                            "Gm12878-Rad21-Haib",
                                            "Gm12878-Smc3-Sydh",
                                            "Gm12878-Znf143-Sydh")]
names(tfbsList_filt) <- c("Ctcf", "Rad21", "Smc3", "Znf143")

# Run preciseTAD
set.seed(123)
pt <- preciseTAD(genomicElements.GR = tfbsList_filt,
                featureType         = "distance",
                CHR                 = "CHR22",
                chromCoords         = list(18000000, 19000000),
                tadModel            = CHR22_GM12878_5kb_Arrowhead,
                threshold           = 1.0,
                verbose             = FALSE,
                parallel            = NULL,
                DBSCAN_params       = list(30000, 3))
                # flank               = 5000)
                # genome              = "hg19")

pt
```

```
## $preciseTADparams
##   MinPts   eps NEmean k
## 1      3 30000    4.8 5
##
## $PTBR
## GRanges object with 5 ranges and 0 metadata columns:
##       seqnames            ranges strand
##          <Rle>         <IRanges>  <Rle>
##   [1]    chr22 18038169-18038406      *
##   [2]    chr22 18268086-18268246      *
##   [3]    chr22 18310018-18312978      *
##   [4]    chr22 18499231-18507447      *
##   [5]    chr22 18557665-18559050      *
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $PTBP
## GRanges object with 5 ranges and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]    chr22  18038310      *
##   [2]    chr22  18268166      *
##   [3]    chr22  18312917      *
##   [4]    chr22  18507320      *
##   [5]    chr22  18558977      *
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $Summaries
## $Summaries$PTBRWidth
##   min  max median  iqr   mean       sd
## 1 161 8217   1386 2723 2592.6 3342.241
##
## $Summaries$PTBRCoverage
##         min       max     median       iqr      mean        sd
## 1 0.0230011 0.8385093 0.08730159 0.6643423 0.3392469 0.3986859
##
## $Summaries$DistanceBetweenPTBR
##     min    max   median      iqr     mean       sd
## 1 41772 229680 118235.5 149003.2 126980.8 95242.47
##
## $Summaries$NumSubRegions
##   min max median iqr mean      sd
## 1   2  16      3   1  5.6 5.85662
##
## $Summaries$SubRegionWidth
##   min max median iqr     mean       sd
## 1   1 162      6 9.5 26.28571 45.35037
##
## $Summaries$DistBetweenSubRegions
##   min  max median   iqr     mean       sd
## 1   3 2957     58 612.5 532.6087 871.3022
##
## $Summaries$NormilizedEnrichment
## [1] 4.8
##
## $Summaries$BaseProbs
## [1] NA
```