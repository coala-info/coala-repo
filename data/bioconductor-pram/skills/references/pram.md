# PRAM: Pooling RNA-seq and Assembling Models

#### Peng Liu, Colin N. Dewey, and Sündüz Keleş

#### 2025-10-30

* [Introduction](#introduction)
* [Installation](#installation)
  + [From GitHub](#from-github)
  + [From Bioconductor](#from-bioconductor)
* [Quick start](#quick-start)
  + [Description](#description)
  + [Examples](#examples)
* [Define intergenic genomic ranges: `defIgRanges()`](#define-intergenic-genomic-ranges-defigranges)
  + [Description](#description-1)
  + [Example](#example)
* [Prepare input RNA-seq alignments: `prepIgBam()`](#prepare-input-rna-seq-alignments-prepigbam)
  + [Description](#description-2)
  + [Example](#example-1)
* [Build transcript models: `buildModel()`](#build-transcript-models-buildmodel)
  + [Description](#description-3)
  + [Transcript prediction methods](#transcript-prediction-methods)
  + [Required external software](#id:required-external-software)
  + [Example](#example-2)
* [Select transcript models: `selModel()`](#select-transcript-models-selmodel)
  + [Description](#description-4)
  + [Example](#example-3)
* [Evaluate transcript models: `evalModel()`](#evaluate-transcript-models-evalmodel)
  + [Motivation](#motivation)
  + [Input](#input)
  + [Output](#output)
  + [Example](#example-4)
* [Session Info](#session-info)

# Introduction

Pooling RNA-seq and Assembling Models (**PRAM**) is an **R** package that utilizes multiple RNA-seq datasets to predict transcript models. The workflow of PRAM contains four steps. Figure 1 shows each step with function name and associated key parameters. In addition, we provide a function named `evalModel()` to evaluate prediction accuracy by comparing transcript models with true transcripts. In the later sections of this vignette, we will describe each function in details.

![PRAM workflow](data:image/jpeg;base64...)

PRAM workflow

# Installation

## From GitHub

Start **R** and enter:

```
devtools::install_github('pliu55/pram')
```

## From Bioconductor

Start **R** and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pram")
```

For different versions of R, please refer to the appropriate [Bioconductor release](https://bioconductor.org/about/release-announcements/).

# Quick start

## Description

PRAM provides a function named `runPRAM()` to let you conveniently run through the whole workflow.

For a given gene annotation and RNA-seq alignments, you can predict transcript models in intergenic genomic regions:

```
##
## assuming the stringtie binary is in folder /usr/local/stringtie-1.3.3/
##
pram::runPRAM(  in_gtf, in_bamv, out_gtf, method='plst',
                stringtie='/usr/loca/stringtie-1.3.3/stringtie')
```

* `in_gtf`: an input GTF file defining genomic coordinates of existing genes. Required to have an attribute of **gene\_id** in the ninth column.
* `in_bamv`: a vector of input BAM file(s) containing RNA-seq alignments. Currently, PRAM only supports strand-specific paired-end RNA-seq with the first mate on the right-most of transcript coordinate, i.e., ‘fr-firststrand’ by Cufflinks definition.
* `out_gtf`: an output GTF file of predicted transcript models.
* `method`: prediction method. For the command above, we were using pooling RNA-seq datasets and building models by **stringtie**. For a list of available PRAM methods, please check Table @ref(tab:methods) below.
* `stringtie`: location of the **stringtie** binary. PRAM’s model-building step depends on external software. For more information on this topic, please see Section @ref(id:required-external-software) below.

## Examples

PRAM has included input examples files in its `extdata/demo/` folder. The table below provides a quick summary of all the example files.

`runPRAM()`’s input example files.

| input argument | file name(s) |
| --- | --- |
| `in_gtf` | in.gtf |
| `in_bamv` | SZP.bam, TLC.bam |

You can access example files by `system.file()` in **R**, e.g. for the argument `in_gtf`, you can access its example file by

```
system.file('extdata/demo/in.gtf', package='pram')
#> [1] "/tmp/Rtmp6BsZsQ/Rinst24728e38d63ce/pram/extdata/demo/in.gtf"
```

Below shows the usage of `runPRAM()` with example input files:

```
in_gtf = system.file('extdata/demo/in.gtf', package='pram')

in_bamv = c(system.file('extdata/demo/SZP.bam', package='pram'),
            system.file('extdata/demo/TLC.bam', package='pram') )

pred_out_gtf = tempfile(fileext='.gtf')

##
## assuming the stringtie binary is in folder /usr/local/stringtie-1.3.3/
##
pram::runPRAM(  in_gtf, in_bamv, pred_out_gtf, method='plst',
                stringtie='/usr/loca/stringtie-1.3.3/stringtie')
```

# Define intergenic genomic ranges: `defIgRanges()`

## Description

To predict intergenic transcripts, we must first define intergenic regions by `defIgRanges()`. This function requires a GTF file containing known gene annotation supplied for its `in_gtf` argument. This GTF file should contain an attribue of **gene\_id** in its ninth column. We provided an example input GTF file in PRAM package: `extdata/gtf/defIGRanges_in.gtf`.

In addition to gene annotation, `defIgRanges()` also requires user to provide chromosome sizes so that it would know the maximum genomic ranges. You can provide one of the following arguments:

* `chromgrs`: a GRanges object, or
* `genome`: a genome name, currently supported ones are: **hg19**, **hg38**, **mm9**, and **mm10**, or
* `fchromsize`: a UCSC genome browser-style size file, e.g. [hg19](http://hgdownload.cse.ucsc.edu/goldenpath/hg19/database/chromInfo.txt.gz)

By default, `defIgRanges()` will define intergenic ranges as regions 10 kb away from any known genes. You can change it by the `radius` argument.

## Example

```
pram::defIgRanges(system.file('extdata/gtf/defIgRanges_in.gtf', package='pram'),
                genome = 'hg38')
#> GRanges object with 456 ranges and 0 metadata columns:
#>                 seqnames          ranges strand
#>                    <Rle>       <IRanges>  <Rle>
#>     [1]             chr1 30001-248956422      *
#>     [2]             chr2     1-242193529      *
#>     [3]             chr3     1-198295559      *
#>     [4]             chr4     1-190214555      *
#>     [5]             chr5     1-181538259      *
#>     ...              ...             ...    ...
#>   [452] chrUn_KI270753v1         1-62944      *
#>   [453] chrUn_KI270754v1         1-40191      *
#>   [454] chrUn_KI270755v1         1-36723      *
#>   [455] chrUn_KI270756v1         1-79590      *
#>   [456] chrUn_KI270757v1         1-71251      *
#>   -------
#>   seqinfo: 455 sequences from an unspecified genome; no seqlengths
```

# Prepare input RNA-seq alignments: `prepIgBam()`

## Description

Once intergenic regions were defined, `prepIgBam()` will extract corresponding RNA-seq alignments from input BAM files. In this way, transcript models predicted at later stage will solely from intergenic regions. Also, with fewer RNA-seq alignments, model prediction will run faster.

Three input arguments are required by `prepIgBam()`:

* `finbam`: an input RNA-seq BAM file sorted by genomic coordinate. Currently, we only support strand-specific paired-end RNA-seq data with the first mate on the right-most of transcript coordinate, i.e. ‘fr-firststrand’ by Cufflinks’s definition.
* `iggrs`: a GRanges object to define intergenic regions.
* `foutbam`: an output BAM file.

## Example

```
finbam =system.file('extdata/bam/CMPRep2.sortedByCoord.raw.bam',
                    package='pram')

iggrs = GenomicRanges::GRanges('chr10:77236000-77247000:+')

foutbam = tempfile(fileext='.bam')

pram::prepIgBam(finbam, iggrs, foutbam)
#> Extracted RNA-seq alignments are saved in /tmp/Rtmpmxo4vt/file24ffba324f6cd6.bam
```

# Build transcript models: `buildModel()`

## Description

`buildModel()` predict transcript models from RNA-seq BAM file(s). This function requires two arguments:

* `in_bamv`: a vector of input BAM file(s)
* `out_gtf`: an output GTF file containing predicted transcript models

## Transcript prediction methods

`buildModel()` has implemented seven transcript prediction methods. You can specify it by the `method` argument with one of the keywords: **plcf**, **plst**, **cfmg**, **cftc**, **stmg**, **cf**, and **st**. The first five denote meta-assembly methods that utilize multiple RNA-seq datasets to predict a single set of transcript models. The last two represent methods that predict transcript models from a single RNA-seq dataset.

The table below compares prediction steps for these seven methods. By default, `buildModel()` uses **plcf** to predict transcript models.

(#tab:methods)Prediction steps of the seven `buildModel()` methods

| method | meta-assembly | preparing RNA-seq input | building transcripts | assembling transcripts |
| --- | --- | --- | --- | --- |
| **plcf** | yes | pooling alignments | Cufflinks | no |
| **plst** | yes | pooling alignments | StringTie | no |
| **cfmg** | yes | no | Cufflinks | Cuffmerge |
| **cftc** | yes | no | Cufflinks | TACO |
| **stmg** | yes | no | StringTie | StringTie-merge |
| **cf** | no | no | Cufflinks | no |
| **st** | no | no | StringTie | no |

## Required external software

Depending on your specified prediction method, `buildModel()` requires external software: Cufflinks, StringTie and/or TACO, to build and/or assemble transcript models. You can either specify the software location using the `cufflinks`, `stringtie`, and `taco` arguments in `buildModel()`, or simply leave these three arugments undefined and let PRAM download them for you automatically. The table below summarized software versions `buildModel()` would download when required software was not specified. Please note that, for **macOS**, pre-compiled Cufflinks binary versions 2.2.1 and 2.2.0 appear to have an issue on processing BAM files, therefore we recommend to use version 2.1.1 instead.

(#tab:software)`buildModel()`-required software and recommended version

| software | Linux binary | macOS binary | required by |
| --- | --- | --- | --- |
| [Cufflinks, Cuffmerge](http://cole-trapnell-lab.github.io/cufflinks/) | [v2.2.1](http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz) | [v2.1.1](http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.1.1.OSX_x86_64.tar.gz) | **plcf**, **cfmg**, **cftc**, and **cf** |
| [StringTie, StringTie-merge](https://ccb.jhu.edu/software/stringtie/) | [v1.3.3b](http://ccb.jhu.edu/software/stringtie/dl/stringtie-1.3.3b.Linux_x86_64.tar.gz) | [v1.3.3b](http://ccb.jhu.edu/software/stringtie/dl/stringtie-1.3.3b.OSX_x86_64.tar.gz) | **plst**, **stmg**, and **st** |
| [TACO](https://tacorna.github.io) | [v0.7.0](https://github.com/tacorna/taco/releases/download/v0.7.0/taco-v0.7.0.Linux_x86_64.tar.gz) | [v0.7.0](https://github.com/tacorna/taco/releases/download/v0.7.0/taco-v0.7.0.OSX_x86_64.tar.gz) | **cftc** |

## Example

```
fbams = c(  system.file('extdata/bam/CMPRep1.sortedByCoord.clean.bam',
                        package='pram'),
            system.file('extdata/bam/CMPRep2.sortedByCoord.clean.bam',
                        package='pram') )

foutgtf = tempfile(fileext='.gtf')

##
## assuming the stringtie binary is in folder /usr/local/stringtie-1.3.3/
##
pram::buildModel(fbams, foutgtf, method='plst',
                stringtie='/usr/loca/stringtie-1.3.3/stringtie')
```

# Select transcript models: `selModel()`

## Description

Once transcript models were built, you may want to select a subset of them by their genomic features. `selModel()` was developed for this purpose. It allows you to select transcript models by their total number of exons and total length of exons and introns.

`selModel()` requires two arguments:

* `fin_gtf`:input GTF file containing to-be-selected transcript models. This file is required to have **transcript\_id** attribute in the ninth column.
* `fout_gtf`: output GTF file containing selected transcript models.

By default: `selModel()` will select transcript models with \(\ge\) 2 exons and \(\ge\) 200 bp total length of exons and introns. You can change the default using the `min_n_exon` and `min_tr_len` arguments.

## Example

```
fin_gtf = system.file('extdata/gtf/selModel_in.gtf', package='pram')

fout_gtf = tempfile(fileext='.gtf')

pram::selModel(fin_gtf, fout_gtf)
#> Selected transcript models are saved in /tmp/Rtmpmxo4vt/file24ffba521aaf84.gtf
```

# Evaluate transcript models: `evalModel()`

## Motivation

After PRAM has predicted a number of transcript models, you may wonder how accurate these models are. To answer this question, you can compare PRAM models with real transcripts (i.e., positive controls) that you know should be predicted. PRAM’s `evalModel()` function will help you to make such comparison. It will calculate precision and recall rates on three features of a transcript: exon nucleotides, individual splice junctions, and transcript structure (i.e., whether all splice junctions within a transcript were constructed in a model).

## Input

`evalModel()` requires two arguments:

* `model_exons`: genomic coordinates of transcript model exons.
* `target_exons`: genomic coordinates of real transcript exons.

The two arguments can be in multiple formats:

* both are `GRanges` objects
* both are `character` objects denoting names of GTF files
* both are `data.table` objects containing the following five columns for each exon:
  + **chrom**: chromosome name
  + **start**: starting coordinate
  + **end**: ending coordinate
  + **strand**: strand information, either ‘+’ or ‘-’
  + **trid**: transcript ID
* `model_exons` is the name of a GTF file and `target_exons` is a `data.table` object.

## Output

The output of `evalModel()` is a `data.table` object, where columns are evaluation results and each row is three transcript features.

`evalModel()` output columns

| column name | representation |
| --- | --- |
| **feat** | transcript feature |
| **ntp** | number of true positives (TP) |
| **nfn** | number of false negatives (FN) |
| **nfp** | number of false positives (FP) |
| **precision** | precision rate: \(\frac{TP}{(TP+FP)}\) |
| **recall** | recall rate: \(\frac{TP}{(TP+FN)}\) |

`evalModel()` output rows

| feature name | representation |
| --- | --- |
| **exon\_nuc** | exon nucleotide |
| **indi\_jnc** | individual splice junction |
| **tr\_jnc** | transcript structure |

## Example

```
fmdl = system.file('extdata/benchmark/plcf.tsv', package='pram')
ftgt = system.file('extdata/benchmark/tgt.tsv',  package='pram')

mdldt = data.table::fread(fmdl, header=TRUE, sep="\t")
tgtdt = data.table::fread(ftgt, header=TRUE, sep="\t")

pram::evalModel(mdldt, tgtdt)
#>        feat     ntp    nfn   nfp precision    recall
#>      <char>   <num>  <num> <num>     <num>     <num>
#> 1: exon_nuc 1723581 109337  8424 0.9951363 0.9403481
#> 2: indi_jnc    2889    162   192 0.9376826 0.9469027
#> 3:   tr_jnc    1138    118   252 0.8187050 0.9060510
```

# Session Info

Below is the output of `sessionInfo()` on the system on which this document was compiled.

```
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> loaded via a namespace (and not attached):
#>  [1] sass_0.4.10                 generics_0.1.4
#>  [3] SparseArray_1.10.0          bitops_1.0-9
#>  [5] lattice_0.22-7              digest_0.6.37
#>  [7] evaluate_1.0.5              grid_4.5.1
#>  [9] fastmap_1.2.0               jsonlite_2.0.0
#> [11] Matrix_1.7-4                cigarillo_1.0.0
#> [13] restfulr_0.0.16             httr_1.4.7
#> [15] XML_3.99-0.19               Biostrings_2.78.0
#> [17] codetools_0.2-20            jquerylib_0.1.4
#> [19] abind_1.4-8                 cli_3.6.5
#> [21] pram_1.26.0                 rlang_1.1.6
#> [23] crayon_1.5.3                XVector_0.50.0
#> [25] Biobase_2.70.0              cachem_1.1.0
#> [27] DelayedArray_0.36.0         yaml_2.3.10
#> [29] S4Arrays_1.10.0             tools_4.5.1
#> [31] parallel_4.5.1              BiocParallel_1.44.0
#> [33] Rsamtools_2.26.0            SummarizedExperiment_1.40.0
#> [35] BiocGenerics_0.56.0         curl_7.0.0
#> [37] R6_2.6.1                    matrixStats_1.5.0
#> [39] BiocIO_1.20.0               stats4_4.5.1
#> [41] lifecycle_1.0.4             rtracklayer_1.70.0
#> [43] Seqinfo_1.0.0               S4Vectors_0.48.0
#> [45] IRanges_2.44.0              bslib_0.9.0
#> [47] data.table_1.17.8           xfun_0.53
#> [49] GenomicAlignments_1.46.0    GenomicRanges_1.62.0
#> [51] MatrixGenerics_1.22.0       knitr_1.50
#> [53] rjson_0.2.23                htmltools_0.5.8.1
#> [55] rmarkdown_2.30              compiler_4.5.1
#> [57] RCurl_1.98-1.17
```