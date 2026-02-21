# Analyzing Hi-C and HiChIP data with HiCDCPlus

#### Merve Sahin

#### 10/30/2025

Abstract

A necessary task in the analysis of HiC or HiChIP count data is the detection of statistically significant and differential genomic interactions. The count data are available as a table which reports, with regions typically as genomic regions binned uniformly or across restriction enzyme fragments, the number of interactions between pairs of genomic regions. The package HiCDCPlus provides methods to determine significant and differential chromatin interactions by use of a negative binomial generalized linear model, as well as implementations for TopDom to call topologically associating domains (TADs), and Juicer eigenvector to find the A/B compartments. This vignette explains the use of the package and demonstrates typical workflows on HiC and HiChIP data. HiCDCPlus package version: 1.18.0

* [Installation](#installation)
* [Standard workflow](#standard-workflow)
  + [Overview](#overview)
  + [Quickstart](#quickstart)
    - [Finding Significant Interactions from Hi-C/HiChIP](#finding-significant-interactions-from-hi-chichip)
  + [Finding Differential Interactions](#diff_int)
    - [ICE normalization using HiTC](#ice)
    - [Finding TADs using TopDom](#topdom)
    - [Finding A/B compartment using Juicer](#comp)
* [Creating genomic feature files](#bintolen)
* [The `gi_list` instance](#gi_list)
  + [Uniformly binned `gi_list` instance](#uniform)
  + [Restriction enzyme binned `gi_list` instance](#re_sites)
  + [Generating `gi_list` instance from a bintolen file](#generating-gi_list-instance-from-a-bintolen-file)
* [Using custom features with HiCDCPlus](#using-custom-features-with-hicdcplus)
* [How to get help for HiCDCPlus](#how-to-get-help-for-hicdcplus)
* [Session info](#session-info)

**Note:** if you use HiCDCPlus in published research, please cite:

> Sahin, M., Wong, W., Zhan, Y., Van Deyze, K., Koche, R., and Leslie, C. S. (2021) HiC-DC+: systematic 3D interaction calls and differential analysis for Hi-C and HiChIP *Nature Communications*, **12(3366)**. [10.1038/s41467-021-23749-x](http://dx.doi.org/10.1038/s41467-021-23749-x)

# Installation

To install this package, start R and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("HiCDCPlus")
```

If you are reinstalling the package, we recommend erasing the associated file cache for the package. The cache folder location can be obtained by running.

```
cache <- rappdirs::user_cache_dir(appname="HiCDCPlus")
print(cache)
```

# Standard workflow

## Overview

`HiCDCPlus` can take the outputs of the popular Hi-C pre-processing tools such as .hic (from Juicebox), .matrix, and .allValidPairs (from HiC-Pro). It can also be used with HTClist objects (from Bioconductor package HiTC).

In the standard workflow, one first needs to generate genomic features present in the `HiCDCPlus` model (GC content, mappability, effective length) using the `construct_features` function (see [Creating genomic feature files](#bintolen)). This can be either done for uniformly or multiple restriction fragment binned data.

`HiCDCPlus` stores counts and features in a memory-efficient way using what we name as a `gi_list` instance(see [The `gi_list` instance](#gi_list)). One next feeds the genomic features in the form of a `gi_list` instance using `generate_bintolen_gi_list` function. Then, counts can be added to this `gi_list` instance using dedicated functions for each input Hi-C file format (`add_hic_counts`, `add_hicpro_matrix_counts`,`add_hicpro_allvalidpairs.counts`).

Before modeling, 1D features from the `gi_list` instance coming from the bintolen file must be expanded to 2D using `expand_1D_features` function. Different transformations can be applied to combine genomic features derived for each anchor.

At the core of `HiCDCPlus` is an efficient implementation of the [HiC-DC](https://www.nature.com/articles/ncomms15454) negative binomial count model for normalization and removal of biases (see ?HiCDCPlus). A platform-agnostic parallelizable implementation is also available in the `HiCDCPlus_parallel` function for efficient interaction calling across chromosomes. The `HiCDCPlus` (or `HiCDCPlus_parallel`) function outputs the significance of each interaction (`pvalue` and FDR adjusted p-value `qvalue`) along with following estimated from the model: 1. `mu`: expected interaction frequency estimated from biases, 2. `sdev`: the standard deviation of expected interaction frequencies.

Once results are obtained, they can be output into text files using `gi_list_write` function or to a `.hic` file using the `hicdc2hic`function (where one can pass either raw counts, observed/expected normalized counts, -log10 *P*-value, -log10 *P*-adjusted value, or negative binomial Z-score normalized counts: (counts-mu)/sdev to the `.hic` file

To detect differential significant interactions across conditions, `HiCDCPlus` also provides a modified implementation of [DESeq2](https://bioconductor.org/packages/DESeq2/) using replicate Hi-C/HiChIP datasets `hicdcdiff`. This function requires a (1) definition of the experimental setup (see ?hicdcdiff), (2) a filtered set of interactions to consider, as a text file containing columns `chr`, `startI`, and `startJ` (startI<=startJ) and (3) count data per each condition and replicate either as `gi_list` instances or as output text files generated using the `gi_list_write` function that can be read as valid `gi_list` instances using `gi_list_read`. The `hicdcdiff` function performs the differential analysis and outputs genomic coordinates of pairs of regions with corresponding logFC difference, *P*-value and BH adjusted *P*-value (see the example in [Quickstart](#diff_int)).

We next demonstrate the standard workflow to detect significant as well as differential interactions.

## Quickstart

In this section we show a complete workflow for identifying significant interactions and differential interactions from Hi-C data across replicate experiments. For HiChIP, the functions used are the same, but the distance thresholds used are slightly reduced (recommended Dmax = 1.5e6).

### Finding Significant Interactions from Hi-C/HiChIP

Here, we identify significant interactions from HiC data at 50kb resolution across multiple chromosomes (in the example below, across chromosomes 21 and 22). The following example code chunk assumes that you have downloaded a `.hic` file from [GSE63525](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE63525) and also downloaded [Juicebox command line tools](https://github.com/aidenlab/juicer/wiki/Download). Example below runs with [GSE63525\_HMEC\_combined.hic](http://hgdownload.soe.ucsc.edu/gbdb/hg19/bbi/hic/GSE63525_HMEC_combined.hic) and stores the path to it into the variable `hicfile_path` with features generated for restriction enzyme fragments with the pattern `"GATC"` in hg19 genome.

```
hicfile_path<-system.file("extdata", "GSE63525_HMEC_combined_example.hic", package = "HiCDCPlus")
outdir<-tempdir(check=TRUE)
#generate features
construct_features(output_path=paste0(outdir,"/hg19_50kb_GATC"),
                   gen="Hsapiens",gen_ver="hg19",
                   sig="GATC",
                   bin_type="Bins-uniform",
                   binsize=50000,
                   chrs=c("chr21","chr22"))
```

```
## [1] "/tmp/RtmpFffKZR/hg19_50kb_GATC_bintolen.txt.gz"
```

If you have a multiple enzyme cocktail used to generate Hi-C data, you can specify multiple patterns including `"N"` as string to this function (e.g., sig=c(“GATC”,“GANTC”)). If you want to analyze data binned by multiple restriction enzyme fragments, you can change bin\_type to “Bins-RE-sites”, and binsize to the number of fragments that you would like to merge as bin (e.g., bin\_type=“Bins-RE-sites” and binsize=10 means 10 restriction fragment binning).

```
#generate gi_list instance
gi_list<-generate_bintolen_gi_list(
  bintolen_path=paste0(outdir,"/hg19_50kb_GATC_bintolen.txt.gz"))
#add .hic counts
gi_list<-add_hic_counts(gi_list,hic_path = hicfile_path)
```

If you have HiC-Pro outputs instead, you can use either `add_hicpro_matrix_counts` or `add_hicpro_allvalidpairs_counts` depending on the file format. `add_hicpro_matrix_counts` function requires .bed output from HiC-Pro matrix generation step, together with count data in .matrix format.

```
#expand features for modeling
gi_list<-expand_1D_features(gi_list)
#run HiC-DC+
set.seed(1010) #HiC-DC downsamples rows for modeling
gi_list<-HiCDCPlus(gi_list) #HiCDCPlus_parallel runs in parallel across ncores
head(gi_list)
```

```
## $chr21
## GInteractions object with 27498 interactions and 8 metadata columns:
##           seqnames1           ranges1     seqnames2           ranges2 |
##               <Rle>         <IRanges>         <Rle>         <IRanges> |
##       [1]     chr21   9400000-9450000 ---     chr21   9400000-9450000 |
##       [2]     chr21   9400000-9450000 ---     chr21   9450000-9500000 |
##       [3]     chr21   9400000-9450000 ---     chr21   9500000-9550000 |
##       [4]     chr21   9400000-9450000 ---     chr21   9550000-9600000 |
##       [5]     chr21   9400000-9450000 ---     chr21   9600000-9650000 |
##       ...       ...               ... ...       ...               ... .
##   [27494]     chr21 48000000-48050000 ---     chr21 48050000-48100000 |
##   [27495]     chr21 48000000-48050000 ---     chr21 48100000-48129895 |
##   [27496]     chr21 48050000-48100000 ---     chr21 48050000-48100000 |
##   [27497]     chr21 48050000-48100000 ---     chr21 48100000-48129895 |
##   [27498]     chr21 48100000-48129895 ---     chr21 48100000-48129895 |
##                   D    counts        gc        len        mu      sdev
##           <integer> <numeric> <numeric>  <numeric> <numeric> <numeric>
##       [1]         0       199 -1.162350   -2.03355 893.45296 475.73037
##       [2]     50000         6 -1.018867   -1.14588 361.44390 193.01373
##       [3]    100000         1 -1.034474   -1.69222 135.53550  72.95983
##       [4]    150000         7 -0.962964   -1.81222  69.29311  37.75226
##       [5]    200000         0 -0.672519  -11.25302   5.75596   3.88742
##       ...       ...       ...       ...        ...       ...       ...
##   [27494]     50000       648 0.6628281 -0.0888584   500.961  267.1554
##   [27495]     89947        29 0.4459603 -3.9564444   105.847   57.1815
##   [27496]         0      2468 0.5083961 -0.3549451  1415.297  753.0440
##   [27497]     39947       170 0.2915283 -4.2225312   245.662  131.4849
##   [27498]         0        97 0.0746605 -8.0901172   259.698  138.9441
##              pvalue    qvalue
##           <numeric> <numeric>
##       [1]  0.980622         1
##       [2]  0.999994         1
##       [3]  0.999998         1
##       [4]  0.997504         1
##       [5]  1.000000         1
##       ...       ...       ...
##   [27494] 0.2491665  0.919972
##   [27495] 0.9626372  1.000000
##   [27496] 0.0932895  0.663891
##   [27497] 0.6805805  1.000000
##   [27498] 0.9185031  1.000000
##   -------
##   regions: 963 ranges and 2 metadata columns
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
##
## $chr22
## GInteractions object with 27855 interactions and 8 metadata columns:
##           seqnames1           ranges1     seqnames2           ranges2 |
##               <Rle>         <IRanges>         <Rle>         <IRanges> |
##       [1]     chr22 16050000-16100000 ---     chr22 16050000-16100000 |
##       [2]     chr22 16050000-16100000 ---     chr22 16100000-16150000 |
##       [3]     chr22 16050000-16100000 ---     chr22 16150000-16200000 |
##       [4]     chr22 16050000-16100000 ---     chr22 16200000-16250000 |
##       [5]     chr22 16050000-16100000 ---     chr22 16250000-16300000 |
##       ...       ...               ... ...       ...               ... .
##   [27851]     chr22 51100000-51150000 ---     chr22 51150000-51200000 |
##   [27852]     chr22 51100000-51150000 ---     chr22 51200000-51250000 |
##   [27853]     chr22 51150000-51200000 ---     chr22 51150000-51200000 |
##   [27854]     chr22 51150000-51200000 ---     chr22 51200000-51250000 |
##   [27855]     chr22 51200000-51250000 ---     chr22 51200000-51250000 |
##                   D    counts        gc        len        mu      sdev
##           <integer> <numeric> <numeric>  <numeric> <numeric> <numeric>
##       [1]         0        72 -0.321755  -0.551744 1673.7051 1099.5644
##       [2]     50000         3 -2.018640  -0.698418  484.3915  318.7682
##       [3]    100000         0 -1.017838  -0.333627  278.6914  183.7235
##       [4]    150000         0 -0.741770  -1.247963  121.6267   80.6071
##       [5]    200000         1 -1.069967  -0.293187   95.8473   63.6817
##       ...       ...       ...       ...        ...       ...       ...
##   [27851]     50000       586  0.878598 -0.2088985   806.215   530.048
##   [27852]    100000       121  0.129452 -0.8134144   282.701   186.356
##   [27853]         0      2665  0.641536  0.0178216  2220.278  1458.395
##   [27854]     50000       307 -0.107610 -0.5866943   639.170   420.382
##   [27855]         0       445 -0.856757 -1.1912102  1307.568   859.192
##              pvalue    qvalue
##           <numeric> <numeric>
##       [1]  0.998347         1
##       [2]  0.999971         1
##       [3]  1.000000         1
##       [4]  1.000000         1
##       [5]  0.999832         1
##       ...       ...       ...
##   [27851]  0.593328         1
##   [27852]  0.815618         1
##   [27853]  0.307224         1
##   [27854]  0.777558         1
##   [27855]  0.876441         1
##   -------
##   regions: 1027 ranges and 2 metadata columns
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
#write normalized counts (observed/expected) to a .hic file
hicdc2hic(gi_list,hicfile=paste0(outdir,'/GSE63525_HMEC_combined_result.hic'),
          mode='normcounts',gen_ver='hg19')
```

```
## [1] "/tmp/RtmpFffKZR/GSE63525_HMEC_combined_result.hic"
```

```
#write results to a text file
gi_list_write(gi_list,fname=paste0(outdir,'/GSE63525_HMEC_combined_result.txt.gz'))
```

```
## [1] "/tmp/RtmpFffKZR/GSE63525_HMEC_combined_result.txt.gz"
```

`HiCDCPlus` results can be converted into .hic using `hicdc2hic` function. Values that should be supplied as “mode” into the `hicdc2hic` function for the corresponding score stored in the .hic file are: ‘pvalue’ for -log10 significance p-value, ‘qvalue’ for -log10 FDR corrected p-value, ‘normcounts’ for raw counts/expected counts, ‘zvalue’ for standardized counts (raw counts-expected counts)/modeled standard deviation of expected counts and ‘raw’ to pass-through raw counts.

.hic files can be further converted into .cool format using hic2cool software and be visualized using HiCExplorer.

## Finding Differential Interactions

Suppose we’re interested in finding differential interactions on `chr21` and `chr22` at 50kb between NSD2 and NTKO/TKO cells given the following `.hic` files available in [GSE131651](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE131651): `GSE131651_NSD2_LOW_arima.hic`, `GSE131651_NSD2_HIGH_arima.hic`, `GSE131651_TKOCTCF_new.hic`, `GSE131651_NTKOCTCF_new.hic`. We first find significant interactions in each, and save results to a file:

```
#generate features
construct_features(output_path=paste0(outdir,"/hg38_50kb_GATC"),
                   gen="Hsapiens",gen_ver="hg38",
                   sig="GATC",bin_type="Bins-uniform",
                   binsize=50000,
                   chrs=c("chr22"))
```

```
## [1] "/tmp/RtmpFffKZR/hg38_50kb_GATC_bintolen.txt.gz"
```

```
#add .hic counts
hicfile_paths<-c(
system.file("extdata", "GSE131651_NSD2_LOW_arima_example.hic", package = "HiCDCPlus"),
system.file("extdata", "GSE131651_NSD2_HIGH_arima_example.hic", package = "HiCDCPlus"),
system.file("extdata", "GSE131651_TKOCTCF_new_example.hic", package = "HiCDCPlus"),
system.file("extdata", "GSE131651_NTKOCTCF_new_example.hic", package = "HiCDCPlus"))
indexfile<-data.frame()
for(hicfile_path in hicfile_paths){
output_path<-paste0(outdir,'/',
                    gsub("^(.*[\\/])", "",gsub('.hic','.txt.gz',hicfile_path)))
#generate gi_list instance
gi_list<-generate_bintolen_gi_list(
  bintolen_path=paste0(outdir,"/hg38_50kb_GATC_bintolen.txt.gz"),
  gen="Hsapiens",gen_ver="hg38")
gi_list<-add_hic_counts(gi_list,hic_path = hicfile_path)
#expand features for modeling
gi_list<-expand_1D_features(gi_list)
#run HiC-DC+ on 2 cores
set.seed(1010) #HiC-DC downsamples rows for modeling
gi_list<-HiCDCPlus(gi_list,ssize=0.1)
for (i in seq(length(gi_list))){
indexfile<-unique(rbind(indexfile,
  as.data.frame(gi_list[[i]][gi_list[[i]]$qvalue<=0.05])[c('seqnames1',
                                                           'start1','start2')]))
}
#write results to a text file
gi_list_write(gi_list,fname=output_path)
}
#save index file---union of significants at 50kb
colnames(indexfile)<-c('chr','startI','startJ')
data.table::fwrite(indexfile,
            paste0(outdir,'/GSE131651_analysis_indices.txt.gz'),
            sep='\t',row.names=FALSE,quote=FALSE)
```

We next get the union set of significant interactions and save it as the index file, and then run `hicdcdiff`.

```
#Differential analysis using modified DESeq2 (see ?hicdcdiff)
hicdcdiff(input_paths=list(NSD2=c(paste0(outdir,'/GSE131651_NSD2_LOW_arima_example.txt.gz'),
                 paste0(outdir,'/GSE131651_NSD2_HIGH_arima_example.txt.gz')),
TKO=c(paste0(outdir,'/GSE131651_TKOCTCF_new_example.txt.gz'),
paste0(outdir,'/GSE131651_NTKOCTCF_new_example.txt.gz'))),
filter_file=paste0(outdir,'/GSE131651_analysis_indices.txt.gz'),
output_path=paste0(outdir,'/diff_analysis_example/'),
fitType = 'mean',
chrs = 'chr22',
binsize=50000,
diagnostics=TRUE)
```

```
## $deseq2paths
## NULL
##
## $outputpaths
## [1] "/tmp/RtmpFffKZR/diff_analysis_example/diff_resTKOoverNSD2_chr22.txt.gz"
##
## $plotpaths
## [1] "/tmp/RtmpFffKZR/diff_analysis_example/sizefactors_chr22.pdf"
## [2] "/tmp/RtmpFffKZR/diff_analysis_example/geomean_sizefactors_chr22.pdf"
## [3] "/tmp/RtmpFffKZR/diff_analysis_example/plotMA_TKOoverNSD2_chr22.pdf"
## [4] "/tmp/RtmpFffKZR/diff_analysis_example/diff_chr22_PCA.pdf"
## [5] "/tmp/RtmpFffKZR/diff_analysis_example/dispersionplot.pdf"
```

```
#Check the generated plots as well as DESeq2 results
```

Suppose you provide multiple conditions in input\_paths such as input\_paths=list(A=“..”,B=“..”,C=“..”), then the pairwise comparisons reported by `hicdcdiff` will be B over A, C over B, C over A.

### ICE normalization using HiTC

To find TADs, we use ICE normalized Hi-C data. If you use HiC-Pro to process counts, we suggest feeding ICE normalized .matrix files into a `gi_list` instance.

```
gi_list<-generate_binned_gi_list(50000,chrs=c("chr21","chr22"))
gi_list<-add_hicpro_matrix_counts(gi_list,absfile_path,matrixfile_path,chrs=c("chr21","chr22")) #add paths to iced absfile and matrix files here
```

If you have .hic file instead, then you can perform ICE normalization with our HiTC wrapper as follows:

```
hic_path<-system.file("extdata", "GSE63525_HMEC_combined_example.hic", package = "HiCDCPlus")
gi_list=hic2icenorm_gi_list(hic_path,binsize=50e3,chrs=c('chr22'),Dthreshold=400e3)
```

You can also output a ICE normalized .hic file to the path `gsub(".hic","_icenorm.hic",hic_path)` from `hic2icenorm_gi_list` if you set `hic_out=TRUE` to your call to this function.

### Finding TADs using TopDom

`HiCDCPlus` converts the gi\_list instance with ICE normalized counts into TAD annotations through an implementation of TopDom v0.0.2 (<https://github.com/HenrikBengtsson/TopDom>) adapted as TopDom. We recommend call TADs with to ICE normalized counts at 50kb resolution with window.size 10 in TopDom.

```
tads<-gi_list_topdom(gi_list,chrs=c("chr22"),window.size = 10)
```

### Finding A/B compartment using Juicer

`HiCDCPlus` can call Juicer eigenvector function to determine A/B compartments from .hic files. `extract_hic_eigenvectors` generates text files for each chromosome containing chromosome, start, end and compartment score values that may need to be flipped signs for each chromosome. File paths follow gsub(‘.hic’,’\_\_eigenvalues.txt’,hicfile).

```
extract_hic_eigenvectors(
  hicfile=system.file("extdata", "eigenvector_example.hic", package = "HiCDCPlus"),
  mode = "KR",
  binsize = 50e3,
  chrs = "chr22",
  gen = "Hsapiens",
  gen_ver = "hg19",
  mode = "NONE"
)
```

# Creating genomic feature files

Genomic features can be generated using the `construct_features` function. This function finds all restriction enzyme cutsites of a given genome and genome version and computes GC content, mappability (if a relevant `.bigWig` file is provided) and effective fragment length for uniform bin or across specified multiples of restriction enzyme cutsites of given pattern(s).

```
#generate features
construct_features(output_path=paste0(outdir,"/hg19_50kb_GATC"),
                   gen="Hsapiens",gen_ver="hg19",
                   sig=c("GATC","GANTC"),bin_type="Bins-uniform",
                   binsize=50000,
                   wg_file=NULL, #e.g., 'hg19_wgEncodeCrgMapabilityAlign50mer.bigWig',
                   chrs=c("chr22"))
```

```
## [1] "/tmp/RtmpFffKZR/hg19_50kb_GATC_bintolen.txt.gz"
```

```
#read and print
bintolen<-data.table::fread(paste0(outdir,"/hg19_50kb_GATC_bintolen.txt.gz"))
tail(bintolen,20)
```

```
##                        bins     gc   len
##                      <char>  <num> <int>
##  1: chr22-49850001-49900000 0.4833 49875
##  2: chr22-49900001-49950000 0.5126 47521
##  3: chr22-49950001-50000000 0.5139 46220
##  4: chr22-50000001-50050000 0.5472 48270
##  5: chr22-50050001-50100000 0.5241 49289
##  6: chr22-50100001-50150000 0.5014 49584
##  7: chr22-50150001-50200000 0.5466 48171
##  8: chr22-50200001-50250000 0.5232 47970
##  9: chr22-50250001-50300000 0.4675 49242
## 10: chr22-50300001-50350000 0.6117 41993
## 11: chr22-50350001-50400000 0.1997 49875
## 12: chr22-50400001-50450000 0.3623 47683
## 13: chr22-50450001-50500000 0.5526 49544
## 14: chr22-50500001-50550000 0.5126 49105
## 15: chr22-50550001-50600000 0.4790 49875
## 16: chr22-50600001-50650000 0.6103 49700
## 17: chr22-50650001-50700000 0.5927 49531
## 18: chr22-50700001-50750000 0.6473 49469
## 19: chr22-50750001-50800000 0.5409 49669
## 20: chr22-50800001-50818468 0.4792  7806
##                        bins     gc   len
```

# The `gi_list` instance

`HiCDCPlus` stores features and count data in a list of `InteractionSet` objects generated for each chromosome, what we name as a `gi_list` instance.

A `gi_list` instance can be initialized through multiple ways. One can generate a uniformly binsized `gi_list` instance using `generate_binned_gi_list`. One can also generate a restriction enzyme fragment binning of the genome as a `data.frame` and ingest it as a `gi_list` instance (see ?generate\_df\_gi\_list) Third, one can generate some genomic features (GC content, mappability, effective length) and restriction enzyme fragment regions into as a `bintolen` file (see [Creating bintolen files](#bintolen)) and generate a `gi_list` instance from this `bintolen` file. Finally, one can read a `gi_list` instance from a file generated by `gi_list_write` (see ?gi\_list\_read).

## Uniformly binned `gi_list` instance

One can generate a uniform binsized `gi_list` instance for a genome using `generate_binned_gi_list`:

```
gi_list<-generate_binned_gi_list(binsize=50000,chrs=c('chr22'),
                                 gen="Hsapiens",gen_ver="hg19")
head(gi_list)
```

```
## $chr22
## GInteractions object with 40877 interactions and 1 metadata column:
##           seqnames1           ranges1     seqnames2           ranges2 |
##               <Rle>         <IRanges>         <Rle>         <IRanges> |
##       [1]     chr22           0-50000 ---     chr22           0-50000 |
##       [2]     chr22           0-50000 ---     chr22      50000-100000 |
##       [3]     chr22           0-50000 ---     chr22     100000-150000 |
##       [4]     chr22           0-50000 ---     chr22     150000-200000 |
##       [5]     chr22           0-50000 ---     chr22     200000-250000 |
##       ...       ...               ... ...       ...               ... .
##   [40873]     chr22 50700000-50750000 ---     chr22 50750000-50800000 |
##   [40874]     chr22 50700000-50750000 ---     chr22 50800000-50818468 |
##   [40875]     chr22 50750000-50800000 ---     chr22 50750000-50800000 |
##   [40876]     chr22 50750000-50800000 ---     chr22 50800000-50818468 |
##   [40877]     chr22 50800000-50818468 ---     chr22 50800000-50818468 |
##                   D
##           <integer>
##       [1]         0
##       [2]     50000
##       [3]    100000
##       [4]    150000
##       [5]    200000
##       ...       ...
##   [40873]     50000
##   [40874]     84234
##   [40875]         0
##   [40876]     34234
##   [40877]         0
##   -------
##   regions: 1017 ranges and 0 metadata columns
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

## Restriction enzyme binned `gi_list` instance

One can also generate an restriction enzyme fragment binning (indeed, any arbitrary binning) of the genome containing columns named `chr` and `start` as a `data.frame` (e.g., a `data.frame` read from a `.bed` file) and use it to generate a `gi_list` instance using `generate_df_gi_list`.

```
df<-data.frame(chr='chr9',start=c(1,300,7867,103938))
gi_list<-generate_df_gi_list(df)
gi_list
```

```
## $chr9
## GInteractions object with 7 interactions and 1 metadata column:
##       seqnames1          ranges1     seqnames2          ranges2 |         D
##           <Rle>        <IRanges>         <Rle>        <IRanges> | <integer>
##   [1]      chr9            1-300 ---      chr9            1-300 |         0
##   [2]      chr9            1-300 ---      chr9         300-7867 |      3933
##   [3]      chr9            1-300 ---      chr9      7867-103938 |     55752
##   [4]      chr9         300-7867 ---      chr9         300-7867 |         0
##   [5]      chr9         300-7867 ---      chr9      7867-103938 |     51819
##   [6]      chr9      7867-103938 ---      chr9      7867-103938 |         0
##   [7]      chr9 103938-138394717 ---      chr9 103938-138394717 |         0
##   -------
##   regions: 4 ranges and 0 metadata columns
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

## Generating `gi_list` instance from a bintolen file

One can generate genomic features (gc, mappability, effective length) and restriction enzyme fragment regions as a `bintolen` file (see [Creating bintolen files](#bintolen)) first and then generate a `gi_list` instance from it. This instance will readily store genomic features of the `bintolen` file.

```
#generate features
construct_features(output_path=paste0(outdir,"/hg19_50kb_GATC"),
                   gen="Hsapiens",gen_ver="hg19",
                   sig="GATC",bin_type="Bins-uniform",
                   binsize=50000,
            wg_file=NULL, #e.g., 'hg19_wgEncodeCrgMapabilityAlign50mer.bigWig',
                   chrs=c("chr22"))
```

```
## [1] "/tmp/RtmpFffKZR/hg19_50kb_GATC_bintolen.txt.gz"
```

```
#generate gi_list instance
gi_list<-generate_bintolen_gi_list(
  bintolen_path=paste0(outdir,"/hg19_50kb_GATC_bintolen.txt.gz"))
head(gi_list)
```

```
## $chr22
## GInteractions object with 40877 interactions and 1 metadata column:
##           seqnames1           ranges1     seqnames2           ranges2 |
##               <Rle>         <IRanges>         <Rle>         <IRanges> |
##       [1]     chr22           0-50000 ---     chr22           0-50000 |
##       [2]     chr22           0-50000 ---     chr22      50000-100000 |
##       [3]     chr22           0-50000 ---     chr22     100000-150000 |
##       [4]     chr22           0-50000 ---     chr22     150000-200000 |
##       [5]     chr22           0-50000 ---     chr22     200000-250000 |
##       ...       ...               ... ...       ...               ... .
##   [40873]     chr22 50700000-50750000 ---     chr22 50750000-50800000 |
##   [40874]     chr22 50700000-50750000 ---     chr22 50800000-50818468 |
##   [40875]     chr22 50750000-50800000 ---     chr22 50750000-50800000 |
##   [40876]     chr22 50750000-50800000 ---     chr22 50800000-50818468 |
##   [40877]     chr22 50800000-50818468 ---     chr22 50800000-50818468 |
##                   D
##           <integer>
##       [1]         0
##       [2]     50000
##       [3]    100000
##       [4]    150000
##       [5]    200000
##       ...       ...
##   [40873]     50000
##   [40874]     84234
##   [40875]         0
##   [40876]     34234
##   [40877]         0
##   -------
##   regions: 1017 ranges and 2 metadata columns
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

# Using custom features with HiCDCPlus

HiCDCPlus allows modeling with user-defined 1D (genomic features for each bin) and 2D (features belonging to an interaction) features.

Once a `gi_list` instance is at hand, one can ingest counts (and 2D features) using a sparse matrix format text file containing `chr`, `startI`, `startJ` and `<featurename>` columns (see ?add\_2D\_features) for features you would like to add. `counts` can be ingested this way as well provided you have a text file containing columns named `chr`, `startI` and `startJ`.

```
df<-data.frame(chr='chr9',start=seq(1e6,10e6,1e6))
gi_list<-generate_df_gi_list(df,Dthreshold=500e3,chrs="chr9")
feats<-data.frame(chr='chr9',
startI=seq(1e6,10e6,1e6),
startJ=seq(1e6,10e6,1e6),
counts=rpois(20,lambda=5))
gi_list[['chr9']]<-add_2D_features(gi_list[['chr9']],feats)
gi_list
```

```
## $chr9
## GInteractions object with 10 interactions and 2 metadata columns:
##        seqnames1            ranges1     seqnames2            ranges2 |
##            <Rle>          <IRanges>         <Rle>          <IRanges> |
##    [1]      chr9    1000000-2000000 ---      chr9    1000000-2000000 |
##    [2]      chr9    2000000-3000000 ---      chr9    2000000-3000000 |
##    [3]      chr9    3000000-4000000 ---      chr9    3000000-4000000 |
##    [4]      chr9    4000000-5000000 ---      chr9    4000000-5000000 |
##    [5]      chr9    5000000-6000000 ---      chr9    5000000-6000000 |
##    [6]      chr9    6000000-7000000 ---      chr9    6000000-7000000 |
##    [7]      chr9    7000000-8000000 ---      chr9    7000000-8000000 |
##    [8]      chr9    8000000-9000000 ---      chr9    8000000-9000000 |
##    [9]      chr9   9000000-10000000 ---      chr9   9000000-10000000 |
##   [10]      chr9 10000000-138394717 ---      chr9 10000000-138394717 |
##                D    counts
##        <integer> <numeric>
##    [1]         0         5
##    [2]         0         9
##    [3]         0         7
##    [4]         0        10
##    [5]         0         7
##    [6]         0        13
##    [7]         0         9
##    [8]         0        15
##    [9]         0         6
##   [10]         0        15
##   -------
##   regions: 10 ranges and 0 metadata columns
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

One can also ingest 1D features using a sparse matrix format text file containing `chr`, `start` and `<featurename>` (see ?add\_1D\_features) and broadcast 1D features to 2D for modeling using a user-specified function (see ?expand\_1D\_features). Ingesting 1D features first and then expanding has a better memory footprint compared to using `add_2D_features` directly.

```
df<-data.frame(chr='chr9',start=seq(1e6,10e6,1e6),end=seq(2e6,11e6,1e6))
gi_list<-generate_df_gi_list(df)
feats<-data.frame(chr='chr9',start=seq(1e6,10e6,1e6),gc=runif(10))
gi_list<-add_1D_features(gi_list,feats)
gi_list
```

```
## $chr9
## GInteractions object with 27 interactions and 1 metadata column:
##        seqnames1           ranges1     seqnames2           ranges2 |         D
##            <Rle>         <IRanges>         <Rle>         <IRanges> | <integer>
##    [1]      chr9   1000000-2000000 ---      chr9   1000000-2000000 |         0
##    [2]      chr9   1000000-2000000 ---      chr9   2000000-3000000 |   1000000
##    [3]      chr9   1000000-2000000 ---      chr9   3000000-4000000 |   2000000
##    [4]      chr9   2000000-3000000 ---      chr9   2000000-3000000 |         0
##    [5]      chr9   2000000-3000000 ---      chr9   3000000-4000000 |   1000000
##    ...       ...               ... ...       ...               ... .       ...
##   [23]      chr9   8000000-9000000 ---      chr9  9000000-10000000 |   1000000
##   [24]      chr9   8000000-9000000 ---      chr9 10000000-11000000 |   2000000
##   [25]      chr9  9000000-10000000 ---      chr9  9000000-10000000 |         0
##   [26]      chr9  9000000-10000000 ---      chr9 10000000-11000000 |   1000000
##   [27]      chr9 10000000-11000000 ---      chr9 10000000-11000000 |         0
##   -------
##   regions: 10 ranges and 1 metadata column
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
mcols(InteractionSet::regions(gi_list[['chr9']]))
```

```
## DataFrame with 10 rows and 1 column
##           gc
##    <numeric>
## 1  0.5100410
## 2  0.6598618
## 3  0.6023221
## 4  0.4176259
## 5  0.6214595
## 6  0.0935324
## 7  0.4715000
## 8  0.7649827
## 9  0.6588052
## 10 0.3132930
```

```
gi_list<-expand_1D_features(gi_list)
gi_list
```

```
## $chr9
## GInteractions object with 27 interactions and 2 metadata columns:
##        seqnames1           ranges1     seqnames2           ranges2 |         D
##            <Rle>         <IRanges>         <Rle>         <IRanges> | <integer>
##    [1]      chr9   1000000-2000000 ---      chr9   1000000-2000000 |         0
##    [2]      chr9   1000000-2000000 ---      chr9   2000000-3000000 |   1000000
##    [3]      chr9   1000000-2000000 ---      chr9   3000000-4000000 |   2000000
##    [4]      chr9   2000000-3000000 ---      chr9   2000000-3000000 |         0
##    [5]      chr9   2000000-3000000 ---      chr9   3000000-4000000 |   1000000
##    ...       ...               ... ...       ...               ... .       ...
##   [23]      chr9   8000000-9000000 ---      chr9  9000000-10000000 |   1000000
##   [24]      chr9   8000000-9000000 ---      chr9 10000000-11000000 |   2000000
##   [25]      chr9  9000000-10000000 ---      chr9  9000000-10000000 |         0
##   [26]      chr9  9000000-10000000 ---      chr9 10000000-11000000 |   1000000
##   [27]      chr9 10000000-11000000 ---      chr9 10000000-11000000 |         0
##                gc
##         <numeric>
##    [1]   0.253977
##    [2]   0.520972
##    [3]   0.426384
##    [4]   0.787966
##    [5]   0.693378
##    ...        ...
##   [23]  0.9395545
##   [24]  0.1689767
##   [25]  0.7846432
##   [26]  0.0140655
##   [27] -0.7565123
##   -------
##   regions: 10 ranges and 1 metadata column
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

# How to get help for HiCDCPlus

Any and all HiCDCPlus questions should be posted to the **Bioconductor support site**, which serves as a searchable knowledge base of questions and answers:

<https://support.bioconductor.org>

Posting a question and tagging with “HiCDCPlus” or “HiC-DC+” will automatically send an alert to the package authors to respond on the support site.
You should **not** email your question to the package authors directly, as we will just reply that the question should be posted to the **Bioconductor support site** instead.

# Session info

```
sessionInfo()
```

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
##  [1] BSgenome.Hsapiens.UCSC.hg38_1.4.5 GenomeInfoDb_1.46.0
##  [3] BSgenome.Hsapiens.UCSC.hg19_1.4.3 BSgenome_1.78.0
##  [5] rtracklayer_1.70.0                BiocIO_1.20.0
##  [7] Biostrings_2.78.0                 XVector_0.50.0
##  [9] GenomicRanges_1.62.0              Seqinfo_1.0.0
## [11] IRanges_2.44.0                    S4Vectors_0.48.0
## [13] BiocGenerics_0.56.0               generics_0.1.4
## [15] HiCDCPlus_1.18.0
##
## loaded via a namespace (and not attached):
##   [1] RColorBrewer_1.1-3          rstudioapi_0.17.1
##   [3] jsonlite_2.0.0              magrittr_2.0.4
##   [5] GenomicFeatures_1.62.0      farver_2.1.2
##   [7] rmarkdown_2.30              vctrs_0.6.5
##   [9] memoise_2.0.1               Rsamtools_2.26.0
##  [11] RCurl_1.98-1.17             base64enc_0.1-3
##  [13] htmltools_0.5.8.1           S4Arrays_1.10.0
##  [15] progress_1.2.3              curl_7.0.0
##  [17] SparseArray_1.10.0          Formula_1.2-5
##  [19] sass_0.4.10                 bslib_0.9.0
##  [21] htmlwidgets_1.6.4           Gviz_1.54.0
##  [23] httr2_1.2.1                 cachem_1.1.0
##  [25] GenomicAlignments_1.46.0    igraph_2.2.1
##  [27] lifecycle_1.0.4             pkgconfig_2.0.3
##  [29] Matrix_1.7-4                R6_2.6.1
##  [31] fastmap_1.2.0               MatrixGenerics_1.22.0
##  [33] digest_0.6.37               colorspace_2.1-2
##  [35] AnnotationDbi_1.72.0        DESeq2_1.50.0
##  [37] Hmisc_5.2-4                 RSQLite_2.4.3
##  [39] labeling_0.4.3              filelock_1.0.3
##  [41] httr_1.4.7                  abind_1.4-8
##  [43] compiler_4.5.1              bit64_4.6.0-1
##  [45] withr_3.0.2                 htmlTable_2.4.3
##  [47] S7_0.2.0                    backports_1.5.0
##  [49] BiocParallel_1.44.0         DBI_1.2.3
##  [51] R.utils_2.13.0              biomaRt_2.66.0
##  [53] MASS_7.3-65                 rappdirs_0.3.3
##  [55] DelayedArray_0.36.0         rjson_0.2.23
##  [57] tools_4.5.1                 foreign_0.8-90
##  [59] nnet_7.3-20                 R.oo_1.27.1
##  [61] glue_1.8.0                  restfulr_0.0.16
##  [63] InteractionSet_1.38.0       grid_4.5.1
##  [65] checkmate_2.3.3             cluster_2.1.8.1
##  [67] gtable_0.3.6                R.methodsS3_1.8.2
##  [69] tidyr_1.3.1                 ensembldb_2.34.0
##  [71] data.table_1.17.8           hms_1.1.4
##  [73] pillar_1.11.1               stringr_1.5.2
##  [75] splines_4.5.1               dplyr_1.1.4
##  [77] BiocFileCache_3.0.0         lattice_0.22-7
##  [79] bit_4.6.0                   deldir_2.0-4
##  [81] biovizBase_1.58.0           tidyselect_1.2.1
##  [83] locfit_1.5-9.12             knitr_1.50
##  [85] gridExtra_2.3               ProtGenerics_1.42.0
##  [87] SummarizedExperiment_1.40.0 xfun_0.53
##  [89] Biobase_2.70.0              matrixStats_1.5.0
##  [91] stringi_1.8.7               UCSC.utils_1.6.0
##  [93] lazyeval_0.2.2              yaml_2.3.10
##  [95] evaluate_1.0.5              codetools_0.2-20
##  [97] cigarillo_1.0.0             interp_1.1-6
##  [99] tibble_3.3.0                cli_3.6.5
## [101] rpart_4.1.24                jquerylib_0.1.4
## [103] GenomicInteractions_1.44.0  dichromat_2.0-0.1
## [105] Rcpp_1.1.0                  dbplyr_2.5.1
## [107] png_0.1-8                   XML_3.99-0.19
## [109] parallel_4.5.1              ggplot2_4.0.0
## [111] blob_1.2.4                  prettyunits_1.2.0
## [113] latticeExtra_0.6-31         jpeg_0.1-11
## [115] AnnotationFilter_1.34.0     bitops_1.0-9
## [117] VariantAnnotation_1.56.0    HiTC_1.54.0
## [119] scales_1.4.0                purrr_1.1.0
## [121] crayon_1.5.3                rlang_1.1.6
## [123] KEGGREST_1.50.0
```