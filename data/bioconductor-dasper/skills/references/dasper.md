Code

* Show All Code
* Hide All Code

# Introduction to dasper

David Zhang1\*

1UCL

\*david.zhang.12@ucl.ac.uk

#### 27 October 2020

#### Package

dasper 1.0.0

# 1 Basics

## 1.1 Install `dasper`

`R` is an open-source statistical environment which can be easily modified to enhance its functionality via packages. *[dasper](https://bioconductor.org/packages/3.12/dasper)* is a `R` package available via the [Bioconductor](http://bioconductor.org) repository for packages. `R` can be installed on any operating system from [CRAN](https://cran.r-project.org/) after which you can install *[dasper](https://bioconductor.org/packages/3.12/dasper)* by using the following commands in your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("dzhang32/dasper")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

## 1.2 Required knowledge

The expected input of *[dasper](https://bioconductor.org/packages/3.12/dasper)* are junctions reads (e.g. directly outputted from an aligner such as [STAR](https://github.com/alexdobin/STAR) or extracted from a BAM file (e.g. using [megadepth](https://github.com/LieberInstitute/megadepth)) and coverage in the form of BigWig files (which can be generated from BAM files using [megadepth](https://github.com/LieberInstitute/megadepth) or [RSeQC](http://rseqc.sourceforge.net/#bam2wig-py)). *[dasper](https://bioconductor.org/packages/3.12/dasper)* is based on many other packages and in particular in those that have implemented the infrastructure needed for dealing with RNA-sequencing data. The packages *[SummarizedExperiment](https://bioconductor.org/packages/3.12/SummarizedExperiment)* and *[GenomicRanges](https://bioconductor.org/packages/3.12/GenomicRanges)* are used throughout, therefore familiarity with these packages will greatly help in interpreting the output of *[dasper](https://bioconductor.org/packages/3.12/dasper)*.

If you are asking yourself the question “Where do I start using Bioconductor?” you might be interested in [this blog post](http://lcolladotor.github.io/2014/10/16/startbioc/#.VkOKbq6rRuU). Or if you find the structure of a *[SummarizedExperiment](https://bioconductor.org/packages/3.12/SummarizedExperiment)* unclear, you might consider checking out [this manual](http://master.bioconductor.org/help/course-materials/2019/BSS2019/04_Practical_CoreApproachesInBioconductor.html).

## 1.3 Asking for help

As package developers, we try to explain clearly how to use our packages and in which order to use the functions. But `R` and `Bioconductor` have a steep learning curve so it is critical to learn where to ask for help. The blog post quoted above mentions some but we would like to highlight the [Bioconductor support site](https://support.bioconductor.org/) as the main resource for getting help: remember to use the `dasper` tag and check [the older posts](https://support.bioconductor.org/t/dasper/). Other alternatives are available such as creating GitHub issues and tweeting. However, please note that if you want to receive help you should adhere to the [posting guidelines](http://www.bioconductor.org/help/support/posting-guide/). It is particularly critical that you provide a small reproducible example and your session information so package developers can track down the source of the error.

## 1.4 Citing `dasper`

We hope that *[dasper](https://bioconductor.org/packages/3.12/dasper)* will be useful for your research. Please use the following information to cite the package and the overall approach. Thank you!

```
## Citation info
citation("dasper")
#>
#> dzhang32 (2020). _Detecting abberant splicing events from
#> RNA-sequencing data_. doi: 10.18129/B9.bioc.dasper (URL:
#> https://doi.org/10.18129/B9.bioc.dasper),
#> https://github.com/dzhang32/dasper - R package version 1.0.0, <URL:
#> http://www.bioconductor.org/packages/dasper>.
#>
#> dzhang32 (2020). "Detecting abberant splicing events from
#> RNA-sequencing data." _bioRxiv_. doi: 10.1101/TODO (URL:
#> https://doi.org/10.1101/TODO), <URL:
#> https://www.biorxiv.org/content/10.1101/TODO>.
#>
#> To see these entries in BibTeX format, use 'print(<citation>,
#> bibtex=TRUE)', 'toBibtex(.)', or set
#> 'options(citation.bibtex.max=999)'.
```

# 2 Quick start guide

## 2.1 Workflow

![](data:image/png;base64...)

The above workflow diagram gives a top-level overview of the available functions within `dasper` and describes the order in which they are intended to be run. This are broadly split into 4 categories:

1. **Process junctions** functions are prefixed with a *junction\_*. They will load in your junctions into an `RangedSummarizedExperiment` object, annotate your junctions using reference annotation, filter out junctions for those that likely originate from technical noise and normalize your junction counts to allow for comparison between samples.
2. **Process coverage** functions are prefixed with a *coverage\_*. They annotate your junctions with coverage from associated regions then normalize this coverage to allow for comparison between samples.
3. **Outlier detection** functions are prefixed with a *outlier\_*. They will use a outlier detection algorithm ([isolation forest](https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.IsolationForest.html)) to detect the most outlier/abnormal/aberrant junctions in terms of their counts and associated coverage.
4. **Sashimi plots** can be generated using the function `plot_sashimi`. This enables you to select a gene, transcript or region of interest and plot the splicing and coverage across that region in the form of sashimi plot.

## 2.2 Example

`dasper` includes wrapper functions for the 3 major analysis steps in the workflow - processing junction data, processing coverage data, then performing outlier detection. If you are familiar with `dasper` or uninterested with the intermediates, you can go from start to finish using these wrappers.

### 2.2.1 Setup

First, we need to install the system dependency [megadepth](https://github.com/ChristopherWilks/megadepth), which is required for the loading of coverage from BigWig files. The easiest way to do this is to run `install_megadepth` from the *[megadepth](https://bioconductor.org/packages/3.12/megadepth)*

```
megadepth::install_megadepth()
#> The latest megadepth version is 1.0.7
#> megadepth has been installed to /home/biocbuild/bin
```

`dasper` requires reference annotation that can either be inputted as a `GTF` path or pre-loaded into a `TxDb` object as shown below.

```
# use GenomicState to load txdb (GENCODE v31)
ref <- GenomicState::GenomicStateHub(version = "31", genome = "hg38", filetype = "TxDb")[[1]]
#> using temporary cache /tmp/Rtmpxy19gt/BiocFileCache
#> snapshotDate(): 2020-10-26
#> downloading 1 resources
#> retrieving 1 resource
#> loading from cache
#> Loading required package: GenomicFeatures
#> Loading required package: BiocGenerics
#> Loading required package: parallel
#>
#> Attaching package: 'BiocGenerics'
#> The following objects are masked from 'package:parallel':
#>
#>     clusterApply, clusterApplyLB, clusterCall, clusterEvalQ,
#>     clusterExport, clusterMap, parApply, parCapply, parLapply,
#>     parLapplyLB, parRapply, parSapply, parSapplyLB
#> The following objects are masked from 'package:stats':
#>
#>     IQR, mad, sd, var, xtabs
#> The following objects are masked from 'package:base':
#>
#>     Filter, Find, Map, Position, Reduce, anyDuplicated, append,
#>     as.data.frame, basename, cbind, colnames, dirname, do.call,
#>     duplicated, eval, evalq, get, grep, grepl, intersect, is.unsorted,
#>     lapply, mapply, match, mget, order, paste, pmax, pmax.int, pmin,
#>     pmin.int, rank, rbind, rownames, sapply, setdiff, sort, table,
#>     tapply, union, unique, unsplit, which.max, which.min
#> Loading required package: S4Vectors
#> Loading required package: stats4
#>
#> Attaching package: 'S4Vectors'
#> The following object is masked from 'package:base':
#>
#>     expand.grid
#> Loading required package: IRanges
#> Loading required package: GenomeInfoDb
#> Loading required package: GenomicRanges
#> Loading required package: AnnotationDbi
#> Loading required package: Biobase
#> Welcome to Bioconductor
#>
#>     Vignettes contain introductory material; view with
#>     'browseVignettes()'. To cite Bioconductor, see
#>     'citation("Biobase")', and for packages 'citation("pkgname")'.
```

RNA-seq data in the form of junctions and BigWig files are the required raw input to `dasper`. For illustration, in this vignette we will use an BigWig file from the GTEx v6 data publicly hosted by [recount2](https://jhubiostatistics.shinyapps.io/recount/). In reality, users should use the BigWig files that correspond to the same samples as those your junction data originate from.

```
# Obtain the urls to the remotely hosted GTEx BigWig files
url <- recount::download_study(
    project = "SRP012682",
    type = "samples",
    download = FALSE
)
#> Setting options('download.file.method.GEOquery'='auto')
#> Setting options('GEOquery.inmemory.gpl'=FALSE)
#> No methods found in package 'IRanges' for request: 'values<-' when loading 'derfinder'
#> No methods found in package 'IRanges' for request: 'values' when loading 'derfinder'

# cache the file using BiocFileCache for faster retrieval
bw_path <- dasper:::.file_cache(url[1])
```

A small set of example junctions are included within the package, which can be used for testing the functionality of `dasper`.

```
library(dasper)

junctions_example
#> class: RangedSummarizedExperiment
#> dim: 97671 5
#> metadata(0):
#> assays(1): raw
#> rownames: NULL
#> rowData names(0):
#> colnames(5): count_1 count_2 gtex_54020 gtex_51495 gtex_56930
#> colData names(2): samp_id case_control
```

### 2.2.2 Running `dasper`

Here, we run the 3 wrapper functions (`junction_process`, `coverage_process` and `outlier_process`) on `junctions_example`. These functions are designed to be compatible with usage of the `%>%` pipe from [tidyverse](https://www.tidyverse.org/). The time-limiting steps of this analysis can be run parallel using *[BiocParallel](https://bioconductor.org/packages/3.12/BiocParallel)* as shown.

```
library(magrittr)

outlier_scores <-
    junction_process(junctions_example, ref) %>%
    coverage_process(ref,
        coverage_paths_case = rep(bw_path, 2),
        coverage_paths_control = rep(bw_path, 3),
        bp_param = BiocParallel::MulticoreParam(5)
    ) %>%
    outlier_process(bp_param = BiocParallel::MulticoreParam(5))
```

# 3 Comprehensive usage guide

In this section, we will run each of the 1-9 functions shown in [workflow](#workflow). This can be helpful for users that want to understand or modify the intermediates of the `dasper` pipeline or are only interested in a executing a specific step (e.g. annotating junctions using `junction_annot`). If you want to follow along and run this code in your R session, make sure you have followed the instructions in the section [setup](#setup).

## 3.1 Junction processing

The first step is to load in patient (and control) junction data using `junction_load`. By default, this expects junction files in the format outputted by the [STAR](https://github.com/alexdobin/STAR) aligner (SJ.out). If the user’s junctions are in a different format you can accommodate for this by adjusting the `load_func` argument. The output of this will be junctions stored in a `RangedSummarizedExperiment` object required for the downstream `dasper` functions.

Additionally, users can choose to add a set of control junctions from GTEx v6 (publicly available through [recount2](https://jhubiostatistics.shinyapps.io/recount/)) using the argument `controls`. This may be useful if the user only has RNA-seq data from only a single or small number of patients, which is often the case in a diagnostic setting. In this example, we arbitrarily chose to use the GTEx junctions from the fibroblast tissue. However, we would recommend matching the control tissue to the tissue from which your patient RNA-seq data was derived. The current available tissues that be selected via `controls` are “fibroblasts”, “lymphocytes”, “skeletal\_muscle” and “whole\_blood”.

```
junctions_example_1_path <-
    system.file(
        "extdata",
        "junctions_example_1.txt",
        package = "dasper",
        mustWork = TRUE
    )
junctions_example_2_path <-
    system.file(
        "extdata",
        "junctions_example_2.txt",
        package = "dasper",
        mustWork = TRUE
    )

# only keep chromosomes 21 + 22 for speed
junctions <-
    junction_load(
        junction_paths = c(
            junctions_example_1_path,
            junctions_example_2_path
        ),
        controls = "fibroblasts",
        chrs = c("chr21", "chr22")
    )
#> [1] "2020-10-27 19:34:54 - Loading junctions for sample 1/2..."
#> [1] "2020-10-27 19:34:54 - Loading junctions for sample 2/2..."
#> [1] "2020-10-27 19:34:54 - Adding control junctions..."
#> [1] "2020-10-27 19:34:54 - Downloading and importing fibroblasts junction data..."
#> [1] "2020-10-27 19:35:28 - Tidying and storing junction data as a RangedSummarizedExperiment..."
#> [1] "2020-10-27 19:35:29 - done!"

junctions
#> class: RangedSummarizedExperiment
#> dim: 97671 286
#> metadata(0):
#> assays(1): raw
#> rownames: NULL
#> rowData names(0):
#> colnames(286): count_1 count_2 ... gtex_56472 gtex_57475
#> colData names(2): samp_id case_control
```

Next, we will annotate our junctions using `junction_annot`. Using reference annotation inputted via `ref`, this will classify junctions into the categories “annotated”, “novel\_acceptor”, “novel\_donor”, “novel\_combo”, “novel\_exon\_skip”, “ambig\_gene” and “unannotated”. Additionally, the genes/transcripts/exons that each junction overlaps will be stored in the `SummarizedExperiment::rowData`. This information is necessary for the downstream `dasper` functions but can also be useful independently if user’s are interested in for example, only retrieving the annotated/unannotated junctions.

```
# take only the first 5 samples (2 cases, 3 controls)
# to increase the speed of the vignette
junctions <- junctions[, 1:5]

junctions <- junction_annot(junctions, ref)
#> [1] "2020-10-27 19:35:30 - Obtaining co-ordinates of annotated exons and junctions from gtf/gff3..."
#> [1] "2020-10-27 19:35:49 - Getting junction annotation using overlapping exons..."
#> [1] "2020-10-27 19:35:53 - Tidying junction annotation..."
#> [1] "2020-10-27 19:35:54 - Deriving junction categories..."
#> [1] "2020-10-27 19:36:01 - done!"

head(SummarizedExperiment::rowData(junctions))
#> DataFrame with 6 rows and 14 columns
#>      in_ref     gene_id_start
#>   <logical>   <CharacterList>
#> 1     FALSE
#> 2      TRUE ENSG00000277117.4
#> 3      TRUE ENSG00000277117.4
#> 4     FALSE
#> 5     FALSE
#> 6     FALSE
#>                                               tx_name_start
#>                                             <CharacterList>
#> 1
#> 2 ENST00000612610.4,ENST00000620481.4,ENST00000623960.3,...
#> 3 ENST00000612610.4,ENST00000620481.4,ENST00000623960.3,...
#> 4
#> 5
#> 6
#>                       exon_name_start    strand_start exon_width_start
#>                       <CharacterList> <CharacterList>    <IntegerList>
#> 1
#> 2 ENSE00003728725.1,ENSE00003760332.1               +          291,291
#> 3 ENSE00003746700.1,ENSE00003759504.1               +          165,165
#> 4
#> 5
#> 6
#>         gene_id_end                                               tx_name_end
#>     <CharacterList>                                           <CharacterList>
#> 1
#> 2 ENSG00000277117.4 ENST00000612610.4,ENST00000620481.4,ENST00000623960.3,...
#> 3 ENSG00000277117.4 ENST00000612610.4,ENST00000620481.4,ENST00000623960.3,...
#> 4
#> 5
#> 6
#>                         exon_name_end      strand_end exon_width_end
#>                       <CharacterList> <CharacterList>  <IntegerList>
#> 1
#> 2 ENSE00003746700.1,ENSE00003759504.1               +        165,165
#> 3 ENSE00003753253.1,ENSE00003757428.1               +          36,36
#> 4
#> 5
#> 6
#>    gene_id_junction strand_junction        type
#>     <CharacterList> <CharacterList>    <factor>
#> 1                                 * unannotated
#> 2 ENSG00000277117.4               + annotated
#> 3 ENSG00000277117.4               + annotated
#> 4                                 * unannotated
#> 5                                 * unannotated
#> 6                                 * unannotated
```

We will then filter our junctions using `junction_filter`. You have the option of choosing to filter by count, width, type (annotation category) and whether junctions overlap a particular genomic region. The default settings shown below filter only by count and require a junction to have at least 5 reads in at least 1 sample to be kept in.

```
junctions <- junction_filter(junctions,
    count_thresh = c(raw = 5),
    n_samp = c(raw = 1)
)
#> [1] "2020-10-27 19:36:02 - Filtering junctions..."
#> [1] "2020-10-27 19:36:02 - by count..."
#> [1] "2020-10-27 19:36:02 - done!"

junctions
#> class: RangedSummarizedExperiment
#> dim: 4873 5
#> metadata(0):
#> assays(1): raw
#> rownames: NULL
#> rowData names(14): in_ref gene_id_start ... strand_junction type
#> colnames(5): count_1 count_2 gtex_54020 gtex_51495 gtex_56930
#> colData names(2): samp_id case_control
```

We can then normalize our raw junctions counts into a proportion-spliced-in using `junction_norm`. This will first cluster each junction by finding all other junctions that share an acceptor or donor site with it. Then, calculate the normalized counts by dividing the number of reads supporting each junction with the total number of reads in it’s associated cluster.

```
junctions <- junction_norm(junctions)
#> [1] "2020-10-27 19:36:02 - Clustering junctions..."
#> [1] "2020-10-27 19:36:03 - Normalising junction counts..."
#> [1] "2020-10-27 19:36:03 - done!"

# save a separate object for plotting
junctions_normed <- junctions

# show the raw counts
tail(SummarizedExperiment::assays(junctions)[["raw"]])
#>         count_1 count_2 gtex_54020 gtex_51495 gtex_56930
#> [4868,]       0       0          2          4          6
#> [4869,]       0       0         39         20         54
#> [4870,]       0       0          5          2          1
#> [4871,]       0       0         82         57        125
#> [4872,]       0       9          0          0          0
#> [4873,]       0      12          0          0          0

# and those after normalisation
tail(SummarizedExperiment::assays(junctions)[["norm"]])
#>         count_1   count_2 gtex_54020 gtex_51495  gtex_56930
#> [4868,]       0 0.0000000 1.00000000 1.00000000 1.000000000
#> [4869,]       0 0.0000000 1.00000000 1.00000000 1.000000000
#> [4870,]       0 0.0000000 0.05747126 0.03389831 0.007936508
#> [4871,]       0 0.0000000 0.94252874 0.96610169 0.992063492
#> [4872,]       0 0.4285714 0.00000000 0.00000000 0.000000000
#> [4873,]       0 0.5714286 0.00000000 0.00000000 0.000000000
```

Finally, we need to score each patient junction by how much it’s (normalized) counts deviate from the count distribution of the same junction in the control samples using `junction_score`. By default, this uses a z-score measure, however this can be modified to a user-inputted function by adjusting the argument `score_func`. These junction scores with be stored in the `SummarizedExperiment::assays` “score”.

```
junctions <- junction_score(junctions)
#> [1] "2020-10-27 19:36:03 - Calculating the direction of change of junctions..."
#> [1] "2020-10-27 19:36:03 - Generating junction abnormality score..."
#> [1] "2020-10-27 19:36:03 - done!"

names(SummarizedExperiment::assays(junctions))
#> [1] "raw"       "norm"      "direction" "score"
```

## 3.2 Coverage processing

We then move on to loading and normalising the coverage across regions associated with each junction using `coverage_norm`. Namely, these are the 2 exonic regions flanking each junction and the intron inbetween. Given that there are 3 regions for each junction and we need to obtain coverage for every junction from every sample, this step can be very computationally intense to run. Here, `dasper` allows parrallelisation across samples using *[BiocParallel](https://bioconductor.org/packages/3.12/BiocParallel)* and uses the tool [megadepth](https://github.com/ChristopherWilks/megadepth) developed by [Chris Wilks](https://github.com/ChristopherWilks), which is significantly faster than other tools (`rtracklayer` and `pyBigWig`) for loading coverage from BigWig files (see [runtime comparison](https://github.com/LieberInstitute/megadepth/blob/master/analysis/test_megadepth_pyBigWig_rtracklayer.Rmd)).

```
coverage <- coverage_norm(
    junctions,
    ref,
    coverage_paths_case = rep(bw_path, 2),
    coverage_paths_control = rep(bw_path, 3),
    bp_param = BiocParallel::SerialParam()
)
#> [1] "2020-10-27 19:36:03 - Obtaining exonic and intronic regions to load coverage from..."
#> [1] "2020-10-27 19:36:03 - Obtaining regions to use to normalise coverage..."
#> [1] "2020-10-27 19:36:10 - Loading coverage..."
#> [1] "2020-10-27 19:36:25 - Normalising coverage..."
#> [1] "2020-10-27 19:36:25 - done!"
```

`coverage_score` can then be used to compare the coverage associated with each junction to the coverage distribution corresponding to the same region in controls. After which, junctions should have the `SummarizedExperiment::assays` “coverage\_score”.

```
junctions <- coverage_score(junctions, coverage)
#> [1] "2020-10-27 19:36:25 - Generating coverage abnormality score..."
#> [1] "2020-10-27 19:36:25 - Obtaining regions with greatest coverage dysruption..."
#> [1] "2020-10-27 19:36:25 - done!"

names(SummarizedExperiment::assays(junctions))
#> [1] "raw"             "norm"            "direction"       "score"
#> [5] "coverage_region" "coverage_score"
```

## 3.3 Outlier processing

The last step in the `dasper` pipeline is to use the “scores” and “coverage scores” as input into an outlier detection model. This involves using `outlier_detect` to score each junction in each sample by how aberrant it looks. The outputted scores will be stored in the `SummarizedExperiment::assays` “outlier\_score”. This step can be can be parallelised using *[BiocParallel](https://bioconductor.org/packages/3.12/BiocParallel)*. The fit of the `isolation forest` may fluctuate depending on it’s intial `random_state`. For reproducibility you can avoid this by setting the parameter `random_state` to an fixed integer (for more details on the isolation forest model see <https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.IsolationForest.html>).

```
junctions <- outlier_detect(
    junctions,
    bp_param = BiocParallel::SerialParam(),
    random_state = 32L
)
#> [1] "2020-10-27 19:36:25 - generating outlier scores for sample 1/2"
#> [1] "2020-10-27 19:37:05 - fitting outlier detection model with parameters: behaviour=deprecated, bootstrap=FALSE, contamination=auto, max_features=1, max_samples=auto, n_estimators=100, n_jobs=NULL, random_state=32, verbose=0, warm_start=FALSE"
#> [1] "2020-10-27 19:37:05 - fitting outlier detection model with parameters: behaviour=deprecated, bootstrap=FALSE, contamination=auto, max_features=1, max_samples=auto, n_estimators=100, n_jobs=NULL, random_state=32, verbose=0, warm_start=FALSE"
#> [1] "2020-10-27 19:37:05 - generating outlier scores for sample 2/2"
#> [1] "2020-10-27 19:37:06 - fitting outlier detection model with parameters: behaviour=deprecated, bootstrap=FALSE, contamination=auto, max_features=1, max_samples=auto, n_estimators=100, n_jobs=NULL, random_state=32, verbose=0, warm_start=FALSE"
#> [1] "2020-10-27 19:37:07 - fitting outlier detection model with parameters: behaviour=deprecated, bootstrap=FALSE, contamination=auto, max_features=1, max_samples=auto, n_estimators=100, n_jobs=NULL, random_state=32, verbose=0, warm_start=FALSE"
#> [1] "2020-10-27 19:37:07 - done!"

names(SummarizedExperiment::assays(junctions))
#> [1] "raw"             "norm"            "direction"       "score"
#> [5] "coverage_region" "coverage_score"  "outlier_score"
```

Finally, `outlier_aggregate` will aggregate the junction-level “outlier\_scores” to a cluster level. The returned `outlier_scores` object contains a `DataFrame` with each row detailing a cluster in terms of how aberrant it looks. The `gene_id_cluster` column describes the gene linked to each cluster, derived from the gene annotation returned by `junction_annot`. Splicing events are ranked in the `rank` column with 1 referring to the most aberrant splicing event in that patient. Details of the specific junctions that look the most aberrant for each cluster can be found in the `junctions` column.

```
outlier_scores <- outlier_aggregate(junctions, samp_id_col = "samp_id", )
#> [1] "2020-10-27 19:37:07 - Aggregating outlier scores to cluster level... "
#> [1] "2020-10-27 19:37:08 - Annotating clusters with gene details..."
#> [1] "2020-10-27 19:37:09 - done!"

head(outlier_scores)
#> DataFrame with 6 rows and 6 columns
#>       samp_id cluster_index mean_outlier_score      rank    gene_id_cluster
#>   <character>   <character>          <numeric> <numeric>    <CharacterList>
#> 1      samp_1          4123          -0.200174         1 ENSG00000100243.21
#> 2      samp_1          1286          -0.199448         2 ENSG00000142156.14
#> 3      samp_1          3993          -0.189962         3  ENSG00000100418.8
#> 4      samp_1          1000          -0.158565         4  ENSG00000160213.7
#> 5      samp_1          3456          -0.156321         5 ENSG00000100129.18
#> 6      samp_1          3462          -0.155961         6 ENSG00000100129.18
#>                                         junctions
#>                                            <list>
#> 1 4123: 1:-0.219912:...,4124:-1:-0.180436:...,...
#> 2 1287:-1:-0.225970:...,1288: 1:-0.172927:...,...
#> 3 3993: 1:-0.134843:...,3994:-1:-0.245081:...,...
#> 4 1000: 1:-0.119976:...,1001:-1:-0.197153:...,...
#> 5 3456: 1:-0.121972:...,3457:-1:-0.190670:...,...
#> 6 3462: 1:-0.105657:...,3463:-1:-0.206265:...,...
```

## 3.4 Sashimi plots

In order to help further inspection of the candidate genes with abberrant splicing returned by `dasper`, we also include functions to visualise splicing across genes/transcripts/regions of interest. For example, you could visualise the gene with the most aberrant cluster in `samp_1`.

```
# take gene_id of the cluster ranked 1
gene_id <- unlist(outlier_scores[["gene_id_cluster"]][1])

plot_sashimi(
    junctions_normed,
    ref,
    case_id = list(samp_id = "samp_1"),
    gene_tx_id = gene_id,
    count_label = FALSE
)
```

![](data:image/png;base64...)

Often regions of splicing can be very complex within a gene/transcript. In which case, you may consider zooming in on a specific region of interest using the argument `region`. Furthermore, the thickness of the lines represents the normalized counts of each junction however in this way, it can be difficult to accurately differentiate junctions that have similar counts. Users may want to add a label representing the count of each junction using the argument `count_label`.

```
plot_sashimi(junctions_normed,
    ref,
    case_id = list(samp_id = "samp_1"),
    gene_tx_id = gene_id,
    region = GenomicRanges::GRanges("chr22:42620000-42630000"),
    count_label = TRUE
)
```

![](data:image/png;base64...)

# 4 Reproducibility

The *[dasper](https://bioconductor.org/packages/3.12/dasper)* package ([dzhang32, 2020](http://www.bioconductor.org/packages/dasper)) was made possible thanks to:

* R ([R Core Team, 2020](https://www.R-project.org/))
* *[BiocStyle](https://bioconductor.org/packages/3.12/BiocStyle)* ([Oleś, Morgan, and Huber, 2020](https://github.com/Bioconductor/BiocStyle))
* *[knitcitations](https://CRAN.R-project.org/package%3Dknitcitations)* ([Boettiger, 2019](https://CRAN.R-project.org/package%3Dknitcitations))
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* ([Xie, 2020](https://yihui.org/knitr/))
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* ([Allaire, Xie, McPherson, Luraschi, et al., 2020](https://github.com/rstudio/rmarkdown))
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* ([Csárdi, core, Wickham, Chang, et al., 2018](https://CRAN.R-project.org/package%3Dsessioninfo))
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* ([Wickham, 2011](https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf))

This package was developed using *[biocthis](https://github.com/lcolladotor/biocthis)*.

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("dasper.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("dasper.Rmd", tangle = TRUE)
```

```
## Clean up
file.remove("dasper.bib")
#> [1] TRUE
```

Date the vignette was generated.

```
#> [1] "2020-10-27 19:37:16 EDT"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 3.315 mins
```

`R` session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.0.3 (2020-10-10)
#>  os       Ubuntu 18.04.5 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2020-10-27
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package                * version  date       lib source
#>  abind                    1.4-5    2016-07-21 [2] CRAN (R 4.0.3)
#>  AnnotationDbi          * 1.52.0   2020-10-27 [2] Bioconductor
#>  AnnotationHub            2.22.0   2020-10-27 [2] Bioconductor
#>  askpass                  1.1      2019-01-13 [2] CRAN (R 4.0.3)
#>  assertthat               0.2.1    2019-03-21 [2] CRAN (R 4.0.3)
#>  backports                1.1.10   2020-09-15 [2] CRAN (R 4.0.3)
#>  base64enc                0.1-3    2015-07-28 [2] CRAN (R 4.0.3)
#>  basilisk                 1.2.0    2020-10-27 [2] Bioconductor
#>  basilisk.utils           1.2.0    2020-10-27 [2] Bioconductor
#>  bibtex                   0.4.2.3  2020-09-19 [2] CRAN (R 4.0.3)
#>  Biobase                * 2.50.0   2020-10-27 [2] Bioconductor
#>  BiocFileCache            1.14.0   2020-10-27 [2] Bioconductor
#>  BiocGenerics           * 0.36.0   2020-10-27 [2] Bioconductor
#>  BiocManager              1.30.10  2019-11-16 [2] CRAN (R 4.0.3)
#>  BiocParallel             1.24.0   2020-10-27 [2] Bioconductor
#>  BiocStyle              * 2.18.0   2020-10-27 [2] Bioconductor
#>  BiocVersion              3.12.0   2020-10-27 [2] Bioconductor
#>  biomaRt                  2.46.0   2020-10-27 [2] Bioconductor
#>  Biostrings               2.58.0   2020-10-27 [2] Bioconductor
#>  bit                      4.0.4    2020-08-04 [2] CRAN (R 4.0.3)
#>  bit64                    4.0.5    2020-08-30 [2] CRAN (R 4.0.3)
#>  bitops                   1.0-6    2013-08-17 [2] CRAN (R 4.0.3)
#>  blob                     1.2.1    2020-01-20 [2] CRAN (R 4.0.3)
#>  bookdown                 0.21     2020-10-13 [2] CRAN (R 4.0.3)
#>  broom                    0.7.2    2020-10-20 [2] CRAN (R 4.0.3)
#>  BSgenome                 1.58.0   2020-10-27 [2] Bioconductor
#>  bumphunter               1.32.0   2020-10-27 [2] Bioconductor
#>  car                      3.0-10   2020-09-29 [2] CRAN (R 4.0.3)
#>  carData                  3.0-4    2020-05-22 [2] CRAN (R 4.0.3)
#>  cellranger               1.1.0    2016-07-27 [2] CRAN (R 4.0.3)
#>  checkmate                2.0.0    2020-02-06 [2] CRAN (R 4.0.3)
#>  cli                      2.1.0    2020-10-12 [2] CRAN (R 4.0.3)
#>  cluster                  2.1.0    2019-06-19 [2] CRAN (R 4.0.3)
#>  cmdfun                   1.0.2    2020-10-10 [2] CRAN (R 4.0.3)
#>  codetools                0.2-16   2018-12-24 [2] CRAN (R 4.0.3)
#>  colorspace               1.4-1    2019-03-18 [2] CRAN (R 4.0.3)
#>  cowplot                  1.1.0    2020-09-08 [2] CRAN (R 4.0.3)
#>  crayon                   1.3.4    2017-09-16 [2] CRAN (R 4.0.3)
#>  curl                     4.3      2019-12-02 [2] CRAN (R 4.0.3)
#>  dasper                 * 1.0.0    2020-10-27 [1] Bioconductor
#>  data.table               1.13.2   2020-10-19 [2] CRAN (R 4.0.3)
#>  DBI                      1.1.0    2019-12-15 [2] CRAN (R 4.0.3)
#>  dbplyr                   1.4.4    2020-05-27 [2] CRAN (R 4.0.3)
#>  DelayedArray             0.16.0   2020-10-27 [2] Bioconductor
#>  derfinder                1.24.0   2020-10-27 [2] Bioconductor
#>  derfinderHelper          1.24.0   2020-10-27 [2] Bioconductor
#>  digest                   0.6.27   2020-10-24 [2] CRAN (R 4.0.3)
#>  doRNG                    1.8.2    2020-01-27 [2] CRAN (R 4.0.3)
#>  downloader               0.4      2015-07-09 [2] CRAN (R 4.0.3)
#>  dplyr                    1.0.2    2020-08-18 [2] CRAN (R 4.0.3)
#>  ellipsis                 0.3.1    2020-05-15 [2] CRAN (R 4.0.3)
#>  evaluate                 0.14     2019-05-28 [2] CRAN (R 4.0.3)
#>  fansi                    0.4.1    2020-01-08 [2] CRAN (R 4.0.3)
#>  farver                   2.0.3    2020-01-16 [2] CRAN (R 4.0.3)
#>  fastmap                  1.0.1    2019-10-08 [2] CRAN (R 4.0.3)
#>  filelock                 1.0.2    2018-10-05 [2] CRAN (R 4.0.3)
#>  forcats                  0.5.0    2020-03-01 [2] CRAN (R 4.0.3)
#>  foreach                  1.5.1    2020-10-15 [2] CRAN (R 4.0.3)
#>  foreign                  0.8-80   2020-05-24 [2] CRAN (R 4.0.3)
#>  Formula                  1.2-4    2020-10-16 [2] CRAN (R 4.0.3)
#>  fs                       1.5.0    2020-07-31 [2] CRAN (R 4.0.3)
#>  generics                 0.0.2    2018-11-29 [2] CRAN (R 4.0.3)
#>  GenomeInfoDb           * 1.26.0   2020-10-27 [2] Bioconductor
#>  GenomeInfoDbData         1.2.4    2020-10-12 [2] Bioconductor
#>  GenomicAlignments        1.26.0   2020-10-27 [2] Bioconductor
#>  GenomicFeatures        * 1.42.0   2020-10-27 [2] Bioconductor
#>  GenomicFiles             1.26.0   2020-10-27 [2] Bioconductor
#>  GenomicRanges          * 1.42.0   2020-10-27 [2] Bioconductor
#>  GenomicState             0.99.12  2020-10-14 [2] Bioconductor
#>  GEOquery                 2.58.0   2020-10-27 [2] Bioconductor
#>  ggplot2                  3.3.2    2020-06-19 [2] CRAN (R 4.0.3)
#>  ggpubr                   0.4.0    2020-06-27 [2] CRAN (R 4.0.3)
#>  ggrepel                  0.8.2    2020-03-08 [2] CRAN (R 4.0.3)
#>  ggsci                    2.9      2018-05-14 [2] CRAN (R 4.0.3)
#>  ggsignif                 0.6.0    2019-08-08 [2] CRAN (R 4.0.3)
#>  glue                     1.4.2    2020-08-27 [2] CRAN (R 4.0.3)
#>  gridExtra                2.3      2017-09-09 [2] CRAN (R 4.0.3)
#>  gtable                   0.3.0    2019-03-25 [2] CRAN (R 4.0.3)
#>  haven                    2.3.1    2020-06-01 [2] CRAN (R 4.0.3)
#>  Hmisc                    4.4-1    2020-08-10 [2] CRAN (R 4.0.3)
#>  hms                      0.5.3    2020-01-08 [2] CRAN (R 4.0.3)
#>  htmlTable                2.1.0    2020-09-16 [2] CRAN (R 4.0.3)
#>  htmltools                0.5.0    2020-06-16 [2] CRAN (R 4.0.3)
#>  htmlwidgets              1.5.2    2020-10-03 [2] CRAN (R 4.0.3)
#>  httpuv                   1.5.4    2020-06-06 [2] CRAN (R 4.0.3)
#>  httr                     1.4.2    2020-07-20 [2] CRAN (R 4.0.3)
#>  interactiveDisplayBase   1.28.0   2020-10-27 [2] Bioconductor
#>  IRanges                * 2.24.0   2020-10-27 [2] Bioconductor
#>  iterators                1.0.13   2020-10-15 [2] CRAN (R 4.0.3)
#>  jpeg                     0.1-8.1  2019-10-24 [2] CRAN (R 4.0.3)
#>  jsonlite                 1.7.1    2020-09-07 [2] CRAN (R 4.0.3)
#>  knitcitations          * 1.0.10   2019-09-15 [2] CRAN (R 4.0.3)
#>  knitr                    1.30     2020-09-22 [2] CRAN (R 4.0.3)
#>  labeling                 0.4.2    2020-10-20 [2] CRAN (R 4.0.3)
#>  later                    1.1.0.1  2020-06-05 [2] CRAN (R 4.0.3)
#>  lattice                  0.20-41  2020-04-02 [2] CRAN (R 4.0.3)
#>  latticeExtra             0.6-29   2019-12-19 [2] CRAN (R 4.0.3)
#>  lifecycle                0.2.0    2020-03-06 [2] CRAN (R 4.0.3)
#>  limma                    3.46.0   2020-10-27 [2] Bioconductor
#>  locfit                   1.5-9.4  2020-03-25 [2] CRAN (R 4.0.3)
#>  lubridate                1.7.9    2020-06-08 [2] CRAN (R 4.0.3)
#>  magrittr                 1.5      2014-11-22 [2] CRAN (R 4.0.3)
#>  Matrix                   1.2-18   2019-11-27 [2] CRAN (R 4.0.3)
#>  MatrixGenerics           1.2.0    2020-10-27 [2] Bioconductor
#>  matrixStats              0.57.0   2020-09-25 [2] CRAN (R 4.0.3)
#>  megadepth                1.0.0    2020-10-27 [2] Bioconductor
#>  memoise                  1.1.0    2017-04-21 [2] CRAN (R 4.0.3)
#>  mime                     0.9      2020-02-04 [2] CRAN (R 4.0.3)
#>  munsell                  0.5.0    2018-06-12 [2] CRAN (R 4.0.3)
#>  nnet                     7.3-14   2020-04-26 [2] CRAN (R 4.0.3)
#>  openssl                  1.4.3    2020-09-18 [2] CRAN (R 4.0.3)
#>  openxlsx                 4.2.3    2020-10-27 [2] CRAN (R 4.0.3)
#>  pillar                   1.4.6    2020-07-10 [2] CRAN (R 4.0.3)
#>  pkgconfig                2.0.3    2019-09-22 [2] CRAN (R 4.0.3)
#>  plyr                     1.8.6    2020-03-03 [2] CRAN (R 4.0.3)
#>  plyranges                1.10.0   2020-10-27 [2] Bioconductor
#>  png                      0.1-7    2013-12-03 [2] CRAN (R 4.0.3)
#>  prettyunits              1.1.1    2020-01-24 [2] CRAN (R 4.0.3)
#>  progress                 1.2.2    2019-05-16 [2] CRAN (R 4.0.3)
#>  promises                 1.1.1    2020-06-09 [2] CRAN (R 4.0.3)
#>  purrr                    0.3.4    2020-04-17 [2] CRAN (R 4.0.3)
#>  qvalue                   2.22.0   2020-10-27 [2] Bioconductor
#>  R6                       2.4.1    2019-11-12 [2] CRAN (R 4.0.3)
#>  rappdirs                 0.3.1    2016-03-28 [2] CRAN (R 4.0.3)
#>  RColorBrewer             1.1-2    2014-12-07 [2] CRAN (R 4.0.3)
#>  Rcpp                     1.0.5    2020-07-06 [2] CRAN (R 4.0.3)
#>  RCurl                    1.98-1.2 2020-04-18 [2] CRAN (R 4.0.3)
#>  readr                    1.4.0    2020-10-05 [2] CRAN (R 4.0.3)
#>  readxl                   1.3.1    2019-03-13 [2] CRAN (R 4.0.3)
#>  recount                  1.16.0   2020-10-27 [2] Bioconductor
#>  RefManageR               1.2.12   2019-04-03 [2] CRAN (R 4.0.3)
#>  rentrez                  1.2.2    2019-05-02 [2] CRAN (R 4.0.3)
#>  reshape2                 1.4.4    2020-04-09 [2] CRAN (R 4.0.3)
#>  reticulate               1.18     2020-10-25 [2] CRAN (R 4.0.3)
#>  rio                      0.5.16   2018-11-26 [2] CRAN (R 4.0.3)
#>  rlang                    0.4.8    2020-10-08 [2] CRAN (R 4.0.3)
#>  rmarkdown                2.5      2020-10-21 [2] CRAN (R 4.0.3)
#>  rngtools                 1.5      2020-01-23 [2] CRAN (R 4.0.3)
#>  rpart                    4.1-15   2019-04-12 [2] CRAN (R 4.0.3)
#>  Rsamtools                2.6.0    2020-10-27 [2] Bioconductor
#>  RSQLite                  2.2.1    2020-09-30 [2] CRAN (R 4.0.3)
#>  rstatix                  0.6.0    2020-06-18 [2] CRAN (R 4.0.3)
#>  rstudioapi               0.11     2020-02-07 [2] CRAN (R 4.0.3)
#>  rtracklayer              1.50.0   2020-10-27 [2] Bioconductor
#>  S4Vectors              * 0.28.0   2020-10-27 [2] Bioconductor
#>  scales                   1.1.1    2020-05-11 [2] CRAN (R 4.0.3)
#>  sessioninfo            * 1.1.1    2018-11-05 [2] CRAN (R 4.0.3)
#>  shiny                    1.5.0    2020-06-23 [2] CRAN (R 4.0.3)
#>  stringi                  1.5.3    2020-09-09 [2] CRAN (R 4.0.3)
#>  stringr                  1.4.0    2019-02-10 [2] CRAN (R 4.0.3)
#>  SummarizedExperiment     1.20.0   2020-10-27 [2] Bioconductor
#>  survival                 3.2-7    2020-09-28 [2] CRAN (R 4.0.3)
#>  testthat                 2.3.2    2020-03-02 [2] CRAN (R 4.0.3)
#>  tibble                   3.0.4    2020-10-12 [2] CRAN (R 4.0.3)
#>  tidyr                    1.1.2    2020-08-27 [2] CRAN (R 4.0.3)
#>  tidyselect               1.1.0    2020-05-11 [2] CRAN (R 4.0.3)
#>  VariantAnnotation        1.36.0   2020-10-27 [2] Bioconductor
#>  vctrs                    0.3.4    2020-08-29 [2] CRAN (R 4.0.3)
#>  withr                    2.3.0    2020-09-22 [2] CRAN (R 4.0.3)
#>  xfun                     0.18     2020-09-29 [2] CRAN (R 4.0.3)
#>  XML                      3.99-0.5 2020-07-23 [2] CRAN (R 4.0.3)
#>  xml2                     1.3.2    2020-04-23 [2] CRAN (R 4.0.3)
#>  xtable                   1.8-4    2019-04-21 [2] CRAN (R 4.0.3)
#>  XVector                  0.30.0   2020-10-27 [2] Bioconductor
#>  yaml                     2.2.1    2020-02-01 [2] CRAN (R 4.0.3)
#>  zip                      2.1.1    2020-08-27 [2] CRAN (R 4.0.3)
#>  zlibbioc                 1.36.0   2020-10-27 [2] Bioconductor
#>
#> [1] /tmp/RtmpYIsp1B/Rinst7f567e90856e
#> [2] /home/biocbuild/bbs-3.12-bioc/R/library
```

# 5 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.12/BiocStyle)* ([Oleś, Morgan, and Huber, 2020](https://github.com/Bioconductor/BiocStyle)) with *[knitr](https://CRAN.R-project.org/package%3Dknitr)* ([Xie, 2020](https://yihui.org/knitr/)) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* ([Allaire, Xie, McPherson, Luraschi, et al., 2020](https://github.com/rstudio/rmarkdown)) running behind the scenes.

Citations made with *[knitcitations](https://CRAN.R-project.org/package%3Dknitcitations)* ([Boettiger, 2019](https://CRAN.R-project.org/package%3Dknitcitations)).

[1] J. Allaire, Y. Xie, J. McPherson, J. Luraschi, et al. *rmarkdown: Dynamic Documents for R*. R package
version 2.5. 2020. <URL: <https://github.com/rstudio/rmarkdown>>.

[2] C. Boettiger. *knitcitations: Citations for ‘Knitr’ Markdown Files*. R package version 1.0.10. 2019.
<URL: [https://CRAN.R-project.org/package=knitcitations](https://CRAN.R-project.org/package%3Dknitcitations)>.

[3] G. Csárdi, R. core, H. Wickham, W. Chang, et al. *sessioninfo: R Session Information*. R package
version 1.1.1. 2018. <URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)>.

[4] A. Oleś, M. Morgan, and W. Huber. *BiocStyle: Standard styles for vignettes and other Bioconductor
documents*. R package version 2.18.0. 2020. <URL: <https://github.com/Bioconductor/BiocStyle>>.

[5] R Core Team. *R: A Language and Environment for Statistical Computing*. R Foundation for Statistical
Computing. Vienna, Austria, 2020. <URL: <https://www.R-project.org/>>.

[6] H. Wickham. “testthat: Get Started with Testing”. In: *The R Journal* 3 (2011), pp. 5-10. <URL:
<https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>>.

[7] Y. Xie. *knitr: A General-Purpose Package for Dynamic Report Generation in R*. R package version 1.30.
2020. <URL: <https://yihui.org/knitr/>>.

[8] dzhang32. *Detecting abberant splicing events from RNA-sequencing data*.
<https://github.com/dzhang32/dasper> - R package version 1.0.0. 2020. DOI: 10.18129/B9.bioc.dasper. <URL:
<http://www.bioconductor.org/packages/dasper>>.