# Omixer: multivariate and reproducible randomization to proactively counter batch effects in omics studies

Lucy Sinke, Davy Cats and Bas Heijmans

#### 30 October 2025

#### Package

Omixer 1.20.0

# 1 Introduction

Batch effects can have a major impact on the results of omics studies
(Leek et al. [2010](#ref-Leek2010)). Randomization is the first, and arguably most influential, step
in handling them. However, its implementation suffers from a few key issues:

* A single,ATTEMPT314 random draw can inadvertently result in high correlation between
  technical covariates and biological factors. Particularly in studies with
  large numbers of batches and outcomes of interest, minimizing these
  correlations is crucial.
* Long, randomized sample lists are unintuitive and translate poorly into any
  wet lab that is not fully automated. This can result in errors and sample
  mixups.
* The randomization process is inherently unclear in many publications, rarely
  described despite the varying efficacy of methods.
* Randomized layouts are not always reproducible, resulting in inconsistent
  results.

To combat these problems, we developed **Omixer** - an R package for
multivariate randomization and reproducible generation of intuitive sample
layouts.

## 1.1 Dependencies

This document has the following dependencies.

```
library(Omixer)
library(tibble)
library(forcats)
library(stringr)
library(dplyr)
library(ggplot2)
library(magick)
```

## 1.2 Workflow

**Omixer** randomizes input sample lists multiple times (default: 1,000) and
then combines these randomized lists with plate layouts, which can be selected
from commonly used setups or custom-made. It can handle paired samples,
keeping these adjacent but shuffling their order, and allows explicit masking
of specific wells if, for example, plates are shared between different studies.

After performing robust tests of correlation between technical covariates and
selected randomization factors, a layout is chosen using these criteria:

* No test provided sufficient evidence to suggest correlation between the
  variables (all p-values over 0.05).
* From the remaining layouts, return one where the absolute sum of
  correlations is minimized.

The optimal randomized list can then be processed by `omixerSheet`, returning
intuitive sample layouts for the wet lab.

# 2 Creating Layouts

In order to establish correlations between technical covariates and biological
factors, **Omixer** needs to know the plate layout that your samples will be
randomized to. There are several options for automatically creating some
common layouts. Alternatively, a data frame can be input to the `layout`
option alongside specified `techVars`. Possibilities are discussed in more
detail below.

## 2.1 Automated Layouts

Several options can be used to automatically generate common layouts:

* `wells` specifies the number of wells on a plate, which can be 96, 48, or 24.
* `plateNum` determines how many copies of the plate your samples will need.
* `div` is optional, and subdivides the plate into batches. This can be used
  to specify chips within a plate, for example.
* `positional` allows positions within `div` to also be treated as batches.
  This is useful for 450K experiments where positional batch effects have been
  identified (Jiao et al. [2018](#ref-Jiao2018)).

## 2.2 Subdivisions

By default, `div` is set to “none”, but it can be set to “col”, “row”,
“col-block”, or “row-block”.

* `col` treats each column in the plate as a batch
* `row` treats each row in the plate as a batch
* `col-block` will separate the plate into batches that are 2 columns wide
* `row-block` separates the plate into 2 row wide batches

So, for `wells=48, div="col"`, each column of a 48-well plate will be
treated as a batch (different colours in the image below).

![](data:image/png;base64...)

If you instead specify `div="row"`, the rows will be treated as batches.

![](data:image/png;base64...)

Similarly, you can set `div="col-block"` or `div="row-block"` for
batches that are 2 columns or rows wide, respectively. The image below shows
how a 48 well plate would be subdivided with the `div="col-block"` option.

![](data:image/png;base64...)

Combining the above will allow you to create a large number of layouts
commonly used in omics experiments.

## 2.3 Masking

If your experiment requires certain wells to be left empty, then these can be
specified with the `mask` option. By default, no wells are masked, but you can
specify masking, with `1` representing a masked well and `0` signifying that a
sample should be randomized to this position.

Wells are numbered along each row sequentially. In the images above, row A
includes wells 1 through 8, row B is wells 9 to 16, and so on until well 48 at
F8.

## 2.4 Custom Layouts

If none of the automated layouts represent your setup you can input your own
plate layout as a data frame. The only requirement is that the number of
unmasked wells is equal to the number of samples in your experiment, and that
you input the names of technical covariate columns to the `techVars` option.

For example, if we wanted to create a 96-well plate to send for 450K DNA
methylation profiling, we might submit the following `layout` and `techVars`.

```
layout <- tibble(plate=rep(1, 96), well=1:96,
    row=factor(rep(1:8, each=12), labels=toupper(letters[1:8])),
    column=rep(1:12, 8), chip=as.integer(ceiling(column/2)),
    chipPos=ifelse(column %% 2 == 0, as.numeric(row)+8, row))

techVars <- c("chip", "chipPos")

layout
#> # A tibble: 96 × 6
#>    plate  well row   column  chip chipPos
#>    <dbl> <int> <fct>  <int> <int>   <dbl>
#>  1     1     1 A          1     1       1
#>  2     1     2 A          2     1       9
#>  3     1     3 A          3     2       1
#>  4     1     4 A          4     2       9
#>  5     1     5 A          5     3       1
#>  6     1     6 A          6     3       9
#>  7     1     7 A          7     4       1
#>  8     1     8 A          8     4       9
#>  9     1     9 A          9     5       1
#> 10     1    10 A         10     5       9
#> # ℹ 86 more rows
```

# 3 Simple example

We create toy data, representing 48 samples to be sent off for RNA sequencing.
All samples will be on a single 48-well flowcell, with each of the 8-sample
rows being pipetting onto a lane, resulting in 6 lanes. This setup can be
represented using provided **Omixer** layouts, as is described below.

First, we build the sample list that will be provided to **Omixer**, with
information on the age, sex, and smoking status of individuals alongside
sample isolation dates. We want to optimize distribution of these randomization
variables across lanes on the flowcell to minimize batch effects.

```
sampleList <- tibble(sampleId=str_pad(1:48, 4, pad="0"),
    sex=as_factor(sample(c("m", "f"), 48, replace=TRUE)),
    age=round(rnorm(48, mean=30, sd=8), 0),
    smoke=as_factor(sample(c("yes", "ex", "never"), 48,
        replace=TRUE)),
    date=sample(seq(as.Date('2008/01/01'), as.Date('2016/01/01'),
        by="day"), 48))

sampleList
#> # A tibble: 48 × 5
#>    sampleId sex     age smoke date
#>    <chr>    <fct> <dbl> <fct> <date>
#>  1 0001     m        25 ex    2013-02-27
#>  2 0002     m        17 ex    2010-05-25
#>  3 0003     m        37 ex    2015-01-25
#>  4 0004     f        31 never 2014-02-02
#>  5 0005     m        21 ex    2009-07-07
#>  6 0006     f        40 never 2015-11-14
#>  7 0007     f        33 ex    2013-11-01
#>  8 0008     f        28 never 2012-03-26
#>  9 0009     m        37 yes   2015-05-04
#> 10 0010     m        37 never 2011-08-18
#> # ℹ 38 more rows
```

## 3.1 Randomization Variables

Using the `randVars` option, we inform **Omixer** which columns in our data
represent randomization variables. You can specify any number of variables,
but with increasing numbers it will become more difficult to optimize their
distribution across batches.

```
randVars <- c("sex", "age", "smoke", "date")
```

## 3.2 Running **Omixer**

To perform multivariate randomization use the `omixerRand` function. For our
example, we have one 96-well flowcell `wells=96, plateNum=1` and want to
optimize sample distribution across lanes `div="row"`.

Following randomization, `omixerRand` will display a visualization of
correlations between randomization and technical variables. If the returning
correlations are higher than you would like, you can increase the `iterNum`
or decrease the number of randomization variables.

```
omixerLayout <- omixerRand(sampleList, sampleId="sampleId",
    block="block", iterNum=100, wells=48, div="row",
    plateNum=1, randVars=randVars)
#> Random seed saved to working directory
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the Omixer package.
#>   Please report the issue at <https://github.com/molepi/Omixer/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

Following `omixerRand`, an optimal randomized sample list is returned. This
can be used as is or processed by `omixerSheet` to create lab-friendly sample
sheets, which will be shown below.

```
head(omixerLayout[1:11])
#>   sampleId sex age smoke       date plate well row column mask chip
#> 1     0009   m  37   yes 2015-05-04     1    1   A      1    0    1
#> 2     0028   f  30    ex 2014-02-25     1    2   B      1    0    2
#> 3     0001   m  25    ex 2013-02-27     1    3   C      1    0    3
#> 4     0042   f  32   yes 2011-08-05     1    4   D      1    0    4
#> 5     0017   f  24    ex 2009-11-02     1    5   E      1    0    5
#> 6     0026   m  29 never 2015-01-13     1    6   F      1    0    6
```

## 3.3 Regenerating Layouts

Since multivariate randomization can take some time with large datasets and
many randomization variables, we provide the `omixerSpecific` function to
reproduce previously generated layouts. After running `omixerRand`, the seed
of the optimal layout is saved to the working directory.

After setting the global variable `.Random.seed`, you can run `omixerSpecific`
to regenerate the optimal layout.

```
load("randomSeed.Rdata")
.GlobalEnv$.Random.seed <- randomSeed

omixerLayout <- omixerSpecific(sampleList, sampleId="sampleId",
    block="block", wells=96, div="row",
    plateNum=1, randVars=randVars)
```

## 3.4 Sample Sheets

Once the multivariate randomization is complete, the resulting data frame can
be input into `omixerSheet` to produce lab-friendly sample layouts. These will
be saved in your working directory as a PDF document.

It is possible to colour code these sheets by a specific factor using the
`group` option, and this is demonstrated in the extended example.

```
omixerSheet(omixerLayout)
#> Warning: The `size` argument of `element_rect()` is deprecated as of ggplot2 3.4.0.
#> ℹ Please use the `linewidth` argument instead.
#> ℹ The deprecated feature was likely used in the Omixer package.
#>   Please report the issue at <https://github.com/molepi/Omixer/issues>.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

# 4 Extended example

To demonstrate the full functionality of **Omixer**, we present an extended
example.

Here, our toy data represents 616 samples ready to be sent off for EPIC DNA
methylation profiling. These samples will be randomized to 7 96-well plates
where each of the 8 columns are transferred to a 12-sample EPIC chip. The
last chip on each plate needs to be kept empty for control samples, and we
will communicate this to **Omixer** using the `mask` option.

Our samples are taken from 4 different tissues of 77 individuals, and we are
interested in how DNA methylation changes over 2 timepoints. Given our
primary research question, we would like to keep the timepoints adjacent on
the array but randomize their order. We can do this in **Omixer** with the
`block` option, as demonstrated below.

## 4.1 Creating Toy Data

As well as a sample ID, we need to tell **Omixer** which variables specify
paired sample blocks using a blocking variable, which we name `block`.

```
sampleList<- tibble(sampleId=str_pad(1:616, 4, pad="0"),
    block=rep(1:308, each=2),
    time=rep(0:1, 308),
    tissue=as_factor(rep(c("blood", "fat", "muscle", "saliva"),
        each=2, 77)),
    sex=as_factor(rep(sample(c("male", "female"), 77, replace=TRUE),
        each=8)),
    age=round(rep(rnorm(77, mean=60, sd=10), each=8), 0),
    bmi=round(rep(rnorm(77, mean=25, sd=2), each=8) , 1),
    date=rep(sample(seq(as.Date('2015/01/01'), as.Date('2020/01/01'),
        by="day"), 77), each=8))

sampleList
#> # A tibble: 616 × 8
#>    sampleId block  time tissue sex      age   bmi date
#>    <chr>    <int> <int> <fct>  <fct>  <dbl> <dbl> <date>
#>  1 0001         1     0 blood  male      61  26.9 2016-02-28
#>  2 0002         1     1 blood  male      61  26.9 2016-02-28
#>  3 0003         2     0 fat    male      61  26.9 2016-02-28
#>  4 0004         2     1 fat    male      61  26.9 2016-02-28
#>  5 0005         3     0 muscle male      61  26.9 2016-02-28
#>  6 0006         3     1 muscle male      61  26.9 2016-02-28
#>  7 0007         4     0 saliva male      61  26.9 2016-02-28
#>  8 0008         4     1 saliva male      61  26.9 2016-02-28
#>  9 0009         5     0 blood  female    42  24.9 2018-07-16
#> 10 0010         5     1 blood  female    42  24.9 2018-07-16
#> # ℹ 606 more rows
save(sampleList, file="sampleList.Rdata")
```

## 4.2 Setting up Variables

We set up our randomization variables to optimize distribution of our
biological factors across chips and plates. Randomization variables in our
example are tissue, sex, age, body mass index (BMI), and isolation date.

```
randVars <- c("tissue", "sex", "age", "bmi", "date")
```

Since the last chip on each plate needs to be reserved, we specify a mask so
that **Omixer** knows not to assign samples to these wells.

In the mask, a `0` indicates that a sample will be assigned to that well, and
a `1` indicates that it should be left empty.

```
mask <- rep(c(rep(0, 88), rep(1, 8)), 7)
```

## 4.3 Running **Omixer**

Now we are ready to perform multivariate randomization with the `omixerRand`
function. We specify 7 96-well plates `wells=96, plateNum=7` subdivided into
8-sample EPIC chips `div="col"`.

```
omixerLayout <- omixerRand(sampleList, sampleId="sampleId",
    block="block", iterNum=100, wells=96, div="col", plateNum=7,
    randVars=randVars, mask=mask)
#> Random seed saved to working directory
```

![](data:image/png;base64...)

## 4.4 Simple Randomization

Looking at the above correlations, you may wonder how **Omixer** compares to
simple randomization. Briefly, we will investigate this.

Simple randomization can be replicated using `omixerRand` with a `iterNum=1`.
Here, only one randomized layout will be created. If this is not optimal, a
warning will print but the layout will still be returned.

```
simpleLayout <- omixerRand(sampleList, sampleId="sampleId",
    block="block",iterNum=1, wells=96, div="col", plateNum=7,
    randVars=randVars, mask=mask)
#> Warning: There was 1 warning in `filter()`.
#> ℹ In argument: `absSum == min(absSum)`.
#> Caused by warning in `min()`:
#> ! no non-missing arguments to min; returning Inf
#> Warning in omixerRand(sampleList, sampleId = "sampleId", block = "block", : All
#> randomized layouts contained unwanted correlations.
#> Warning in omixerRand(sampleList, sampleId = "sampleId", block = "block", :
#> Returning best possible layout.
#> Random seed saved to working directory
```

![](data:image/png;base64...)

Here, we see strong evidence of a correlation between:

* Age and chip (τ = -0.082, p = 0.005)
* Age and plate (τ = -0.073, p = 0.011)
* Date and plate (τ = 0.082, p = 0.005)

These patterns threaten the validity of our future inferences, as the effects
of biological factors are entangled with technical variations.

In comparison, there is insufficient evidence to suggest correlation between
any biological factor and technical covariate in the **Omixer** produced
layout, and the largest correlation coefficient returned is 0.048, which is
considerably lower than many seen in the simple randomized layout.

## 4.5 Regenerating layouts

As in the simple example, any **Omixer** layouts can be regenerated using the
saved random environment in the `omixerSpecific` function.

After setting the global variable `.Random.seed`, you can run `omixerSpecific`
to regenerate the optimal layout.

```
load("randomSeed.Rdata")
.GlobalEnv$.Random.seed <- randomSeed

omixerLayout <- omixerSpecific(sampleList, sampleId="sampleId",
    block="block", wells=96, div="col", plateNum=7,
    randVars=randVars, mask=mask)
```

## 4.6 Sample Sheets

The bridge between dry and wet labs can be precarious. Technicians are often
faced with long, monotonous lists of samples, which they need to pipette
accurately to minimize sample mixups. This is especially prevalent in more
complicated setups as in this extended example.

The `omixerSheet` function smooths this transition by creating lab-friendly
PDFs of sample layouts.

You can colour code wells by another variable. In our example, we want to
highlight wells of each tissue, since samples from one tissue are likely to be
stored together `group="tissue"`. The first page of the resulting PDF is shown
below.

```
omixerSheet(omixerLayout, group="tissue")
```

![](data:image/png;base64...)

# 5 References

Jiao, Chuan, Chunling Zhang, Rujia Dai, Yan Xia, Kangli Wang, Gina Giase, Chao Chen, and Chunyu Liu. 2018. “Positional effects revealed in Illumina methylation array and the impact on analysis.” *Epigenomics* 10 (5): 643–59. <https://doi.org/10.2217/epi-2017-0105>.

Leek, Jeffrey T., Robert B. Scharpf, Héctor Corrada Bravo, David Simcha, Benjamin Langmead, W. Evan Johnson, Donald Geman, Keith Baggerly, and Rafael A. Irizarry. 2010. “Tackling the widespread and critical impact of batch effects in high-throughput data” 11 (10): 733–39. <https://doi.org/10.1038/nrg2825>.

# Appendix

Jiao, Chuan, Chunling Zhang, Rujia Dai, Yan Xia, Kangli Wang, Gina Giase, Chao Chen, and Chunyu Liu. 2018. “Positional effects revealed in Illumina methylation array and the impact on analysis.” *Epigenomics* 10 (5): 643–59. <https://doi.org/10.2217/epi-2017-0105>.

Leek, Jeffrey T., Robert B. Scharpf, Héctor Corrada Bravo, David Simcha, Benjamin Langmead, W. Evan Johnson, Donald Geman, Keith Baggerly, and Rafael A. Irizarry. 2010. “Tackling the widespread and critical impact of batch effects in high-throughput data” 11 (10): 733–39. <https://doi.org/10.1038/nrg2825>.

# A Session Info

```
sessionInfo()
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
#> other attached packages:
#> [1] magick_2.9.0     ggplot2_4.0.0    dplyr_1.1.4      stringr_1.5.2
#> [5] forcats_1.0.1    tibble_3.3.0     Omixer_1.20.0    BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] sass_0.4.10         utf8_1.2.6          generics_0.1.4
#>  [4] stringi_1.8.7       hms_1.1.4           digest_0.6.37
#>  [7] magrittr_2.0.4      evaluate_1.0.5      grid_4.5.1
#> [10] RColorBrewer_1.1-3  bookdown_0.45       fastmap_1.2.0
#> [13] jsonlite_2.0.0      tinytex_0.57        gridExtra_2.3
#> [16] BiocManager_1.30.26 scales_1.4.0        textshaping_1.0.4
#> [19] jquerylib_0.1.4     cli_3.6.5           rlang_1.1.6
#> [22] crayon_1.5.3        withr_3.0.2         cachem_1.1.0
#> [25] yaml_2.3.10         tools_4.5.1         tzdb_0.5.0
#> [28] vctrs_0.6.5         R6_2.6.1            lifecycle_1.0.4
#> [31] ragg_1.5.0          pkgconfig_2.0.3     pillar_1.11.1
#> [34] bslib_0.9.0         gtable_0.3.6        glue_1.8.0
#> [37] Rcpp_1.1.0          systemfonts_1.3.1   xfun_0.53
#> [40] tidyselect_1.2.1    knitr_1.50          dichromat_2.0-0.1
#> [43] farver_2.1.2        htmltools_0.5.8.1   rmarkdown_2.30
#> [46] labeling_0.4.3      readr_2.1.5         compiler_4.5.1
#> [49] S7_0.2.0
```