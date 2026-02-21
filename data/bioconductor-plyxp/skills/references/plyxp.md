# plyxp Usage Guide

#### Justin Landis

#### Michael Love

#### 11/09/2025

# Introduction

`plyxp` provides efficient abstractions to the *SummarizedExperiment* such that using common dplyr functions feels as natural to operating on a *data.frame* or *tibble*. `plyxp` uses [data-masking](https://rlang.r-lib.org/reference/topic-data-mask-programming.html) from the `rlang` package in order to connect dplyr functions to *SummarizedExperiment* slots in a manner that aims to be intuitive and avoiding ambiguity in outcomes.

## Enabling dplyr verbs

`plyxp` works on *SummarizedExperiment* objects, as well as most classes derived from this, including *DESeqDataSet*, *SingleCellExperiment*, etc.

It supports the following operations:

* `mutate`
* `select`
* `summarize`
* `pull`
* `filter`
* `arrange`

## Typical use case

```
library(airway)
data(airway)
library(dplyr)
```

```
library(plyxp)
# to use plyxp, call `new_plyxp()` on your SummarizedExperiment object
xp <- new_plyxp(airway)
```

```
# add data (mutate) to any of the three tables,
# assay, colData, rowData,
# ...using contextual helpers cols() and rows()
xp |>
  mutate(log_counts = log1p(counts),
         cols(treated = dex == "trt"),
         rows(new_id = paste0("gene-", gene_name)))
```

```
## # A RangedSummarizedExperiment-tibble Abstraction: 63,677 × 8
##     .features      .samples | counts log_counts | gene_id gene_name gene_biotype
##     <chr>          <chr>    |  <int>      <dbl> | <chr>   <chr>     <chr>
##   1 ENSG000000000… SRR1039… |    679       6.52 | ENSG00… TSPAN6    protein_cod…
##   2 ENSG000000000… SRR1039… |      0       0    | ENSG00… TNMD      protein_cod…
##   3 ENSG000000004… SRR1039… |    467       6.15 | ENSG00… DPM1      protein_cod…
##   4 ENSG000000004… SRR1039… |    260       5.56 | ENSG00… SCYL3     protein_cod…
##   5 ENSG000000004… SRR1039… |     60       4.11 | ENSG00… C1orf112  protein_cod…
##   …        …           …           …         …       …        …           …
## n-4 ENSG000002734… SRR1039… |      0       0    | ENSG00… RP11-180… antisense
## n-3 ENSG000002734… SRR1039… |      0       0    | ENSG00… TSEN34    protein_cod…
## n-2 ENSG000002734… SRR1039… |      0       0    | ENSG00… RP11-138… lincRNA
## n-1 ENSG000002734… SRR1039… |      0       0    | ENSG00… AP000230… lincRNA
## n   ENSG000002734… SRR1039… |      0       0    | ENSG00… RP11-80H… lincRNA
## # ℹ n = 509,416
## # ℹ 7 more variables: new_id <chr>, `` <>, SampleName <fct>, cell <fct>,
## #   dex <fct>, albut <fct>, treated <lgl>
```

The operations can span contexts, and only the necessary data will be extracted from each context for computation:

```
# suppose a variable, `sizeFactor`, in the colData
xp$sizeFactor <- runif(8, .9, 1.1)

# we wish to scale the counts in the matrix using the size factor,
# then compute row means over the scaled counts matrix:
xp |>
  mutate(scaled_counts = counts / .cols$sizeFactor, #
         rows(ave_scl_cts = rowMeans(.assays_asis$scaled_counts)))
```

```
## # A RangedSummarizedExperiment-tibble Abstraction: 63,677 × 8
##     .features   .samples | counts scaled_counts | gene_id gene_name gene_biotype
##     <chr>       <chr>    |  <int>         <dbl> | <chr>   <chr>     <chr>
##   1 ENSG000000… SRR1039… |    679         742.  | ENSG00… TSPAN6    protein_cod…
##   2 ENSG000000… SRR1039… |      0           0   | ENSG00… TNMD      protein_cod…
##   3 ENSG000000… SRR1039… |    467         510.  | ENSG00… DPM1      protein_cod…
##   4 ENSG000000… SRR1039… |    260         284.  | ENSG00… SCYL3     protein_cod…
##   5 ENSG000000… SRR1039… |     60          65.6 | ENSG00… C1orf112  protein_cod…
##   …      …          …           …            …       …        …           …
## n-4 ENSG000002… SRR1039… |      0           0   | ENSG00… RP11-180… antisense
## n-3 ENSG000002… SRR1039… |      0           0   | ENSG00… TSEN34    protein_cod…
## n-2 ENSG000002… SRR1039… |      0           0   | ENSG00… RP11-138… lincRNA
## n-1 ENSG000002… SRR1039… |      0           0   | ENSG00… AP000230… lincRNA
## n   ENSG000002… SRR1039… |      0           0   | ENSG00… RP11-80H… lincRNA
## # ℹ n = 509,416
## # ℹ 7 more variables: ave_scl_cts <dbl>, `` <>, SampleName <fct>, cell <fct>,
## #   dex <fct>, albut <fct>, sizeFactor <dbl>
```

Calling `.cols` in the assay context produces an object of the matching size and orientation to the other assay data.

Alternatively we could have used *purrr* to compute row means:

```
xp |>
  mutate(scaled_counts = counts / .cols$sizeFactor,
         # You may expect a list when accessing other contexts
         # from either the rows() or cols() contexts.
         rows(ave_scl_cts = purrr::map_dbl(.assays$scaled_counts, mean)))
```

```
## # A RangedSummarizedExperiment-tibble Abstraction: 63,677 × 8
##     .features   .samples | counts scaled_counts | gene_id gene_name gene_biotype
##     <chr>       <chr>    |  <int>         <dbl> | <chr>   <chr>     <chr>
##   1 ENSG000000… SRR1039… |    679         742.  | ENSG00… TSPAN6    protein_cod…
##   2 ENSG000000… SRR1039… |      0           0   | ENSG00… TNMD      protein_cod…
##   3 ENSG000000… SRR1039… |    467         510.  | ENSG00… DPM1      protein_cod…
##   4 ENSG000000… SRR1039… |    260         284.  | ENSG00… SCYL3     protein_cod…
##   5 ENSG000000… SRR1039… |     60          65.6 | ENSG00… C1orf112  protein_cod…
##   …      …          …           …            …       …        …           …
## n-4 ENSG000002… SRR1039… |      0           0   | ENSG00… RP11-180… antisense
## n-3 ENSG000002… SRR1039… |      0           0   | ENSG00… TSEN34    protein_cod…
## n-2 ENSG000002… SRR1039… |      0           0   | ENSG00… RP11-138… lincRNA
## n-1 ENSG000002… SRR1039… |      0           0   | ENSG00… AP000230… lincRNA
## n   ENSG000002… SRR1039… |      0           0   | ENSG00… RP11-80H… lincRNA
## # ℹ n = 509,416
## # ℹ 7 more variables: ave_scl_cts <dbl>, `` <>, SampleName <fct>, cell <fct>,
## #   dex <fct>, albut <fct>, sizeFactor <dbl>
```

See below for details on how objects are made available across contexts.

`plyxp` also enables common grouping and summarization routines:

```
summary <- xp |>
  group_by(rows(gene_biotype)) |>
  summarize(col_sums = colSums(counts),
            # may rename rows with .features
            rows(.features = unique(gene_biotype)))
# summarize returns a SummarizedExperiment here,
# retaining rowData and colData

summary |> rowData()
```

```
## DataFrame with 30 rows and 1 column
##                                    gene_biotype
##                                     <character>
## protein_coding                   protein_coding
## pseudogene                           pseudogene
## processed_transcript       processed_transcript
## antisense                             antisense
## lincRNA                                 lincRNA
## ...                                         ...
## IG_C_pseudogene                 IG_C_pseudogene
## TR_D_gene                             TR_D_gene
## IG_J_pseudogene                 IG_J_pseudogene
## 3prime_overlapping_ncrna 3prime_overlapping_n..
## processed_pseudogene       processed_pseudogene
```

```
# visualizing the output as a tibble:
library(tibble)
summary |>
  pull(col_sums) |>
  as_tibble(rownames = "type")
```

```
## # A tibble: 30 × 9
##    type        SRR1039508 SRR1039509 SRR1039512 SRR1039513 SRR1039516 SRR1039517
##    <chr>            <dbl>      <dbl>      <dbl>      <dbl>      <dbl>      <dbl>
##  1 protein_co…   19413626   17741060   23926011   14360299   23003444   29233398
##  2 pseudogene      807285     733916     868950     478980     852106     946776
##  3 processed_…      47547      46534      47788      26367      43965      52063
##  4 antisense        49682      43769      60098      33066      56696      66335
##  5 lincRNA         133335     120060     206075     125015     145078     170641
##  6 polymorphi…       2804       2895       3417       2247       3497       4065
##  7 IG_V_pseud…          3          0          1          0          1          0
##  8 IG_V_gene            0          7          2          3          4          4
##  9 sense_over…       6038       5618       7662       5579       7869       9443
## 10 sense_intr…       3560       3595       3963       2837       4503       5990
## # ℹ 20 more rows
## # ℹ 2 more variables: SRR1039520 <dbl>, SRR1039521 <dbl>
```

To extract the *SummarizedExperiment* (if needed):

```
se(xp)
```

```
## class: RangedSummarizedExperiment
## dim: 63677 8
## metadata(1): ''
## assays(1): counts
## rownames(63677): ENSG00000000003 ENSG00000000005 ... ENSG00000273492
##   ENSG00000273493
## rowData names(3): gene_id gene_name gene_biotype
## colnames(8): SRR1039508 SRR1039509 ... SRR1039520 SRR1039521
## colData names(5): SampleName cell dex albut sizeFactor
```

## Related work

We note that `plyxp` is highly related to other *tidyomics* projects including:

* *tidySummarizedExperiment*
* *plyranges*
* *DFplyr*

Here we have focused on the design principles of: (1) function *endomorphism* (returning the same class of object that was input), (2) avoiding code ambiguity through strictly defined behavior and scope, and (3) allowing the user the convenience of multiple expressions for the same result, which may involve a trade-off between efficiency and verbosity.

### A Note on `tidySummarizedExperiment`

`plyxp` and `tidySummarizedExperiment` both provide *dplyr*-style interfaces to *SummarizedExperiment* objects, and can easily be loaded and used in the same R session without the functions conflicting. By casting objects with the `new_plyxp` constructor, users can enable the `plyxp`-driven functionality. We plan to also use `plyxp` functions in some cases to speed up or improve efficiency of functions implemented in *tidySummarizedExperiment*.

# `plyxp` grammar

The `SummarizedExperiment` object contains three main components/“contexts” that we mask, the `assays()`, `rowData()`[1](#fn1) and `colData()`.

![Simplified view of data masking structure. Figure made with [Biorender](https://biorender.com)](data:image/png;base64...)

Simplified view of data masking structure. Figure made with [Biorender](https://biorender.com)

`plyxp` provides variables as-is to data **within their current contexts** enabling you to call S4 methods on S4 objects with `dplyr` verbs. If you require access to variables *outside the context*, you may use pronouns made available through `plyxp` to specify where to find those variables.

![Simplified view of reshaping pronouns. Arrows indicates to where the pronoun provides access. For each pronoun listed, there is an `_asis` variant that returns underlying data without reshaping it to fit the context. Figure made with [Biorender](https://biorender.com)](data:image/png;base64...)

Simplified view of reshaping pronouns. Arrows indicates to where the pronoun provides access. For each pronoun listed, there is an `_asis` variant that returns underlying data without reshaping it to fit the context. Figure made with [Biorender](https://biorender.com)

The `.assays`, `.rows` and `.cols` pronouns outputs depends on the evaluating context. Users should expect that the underlying data returned from `.rows` or `.cols` pronouns in the ***assays context*** is a vector, replicated to match size of the assay context.

Alternatively, using a pronoun in either the `rows()` or `cols()` contexts will return a list equal in length to either `nrows(rowData())` or `nrows(colData())` respectively.

## assay context

* Default evaluation context
* `.assays` \(\to\) contextual pronoun, returns list of the matrix, sliced by the dimension it was referenced from.
  + within the rowData context: `.assays$foo` is an alias for `lapply(seq_len(nrow()), \(i, x) x[i,,drop=FALSE], x = foo)`
  + within the colData context: `.assays$foo` is an alias for `lapply(seq_len(ncol()), \(i, x) x[,i,drop=FALSE], x = foo)`
* `.assays_asis` \(\to\) pronoun to direct bindings in `assays()`
* `assay_ctx(expr, asis = FALSE)` \(\to\) short hand to bind the assay context in front of the current context.

## rows context

* `rows(...)` \(\to\) sentinel function call to indicate evaluation context.
* `.rows` \(\to\) contextual pronoun
  + within assay context: `.rows$foo` is an alias for `vctrs::vec_rep(foo, times = ncol())`
  + within colData context: `.rows$foo` is an alias for `vctrs::vec_rep(list(foo), times = n())`
* `.rows_asis` \(\to\) pronoun to direct bindings in `rowData()`
* `row_ctx(expr, asis = FALSE)` \(\to\) shorthand to bind the rowData context in front of the current context

## cols context

* `cols(...)` \(\to\) sentinel function call to indicate evaluation context.
* `.cols` \(\to\) contextual pronoun
  + within assay context: `.cols$foo` is an alias for `vctrs::vec_rep_each(foo, times = nrow())`
  + within rowData context: `.rows$foo` is an alias for `vctrs::vec_rep(list(foo), times = n())`
* `.cols_asis` \(\to\) pronoun to direct bindings in `colData()`
* `col_ctx(expr, asis = FALSE)` \(\to\) shorthand to bind the colData context in front of the current context

## Multiple expressions enabled via `plyxp`

We can compare two ways of dividing out a vector from `colData` along the columns of `assay` data:

```
# here the `.cols$` pronoun reshapes the data to fit the `assays` context
xp |>
  mutate(scaled_counts = counts / .cols$sizeFactor)
```

```
## # A RangedSummarizedExperiment-tibble Abstraction: 63,677 × 8
##     .features .samples | counts scaled_counts | gene_id gene_name gene_biotype |
##     <chr>     <chr>    |  <int>         <dbl> | <chr>   <chr>     <chr>        |
##   1 ENSG0000… SRR1039… |    679         742.  | ENSG00… TSPAN6    protein_cod… |
##   2 ENSG0000… SRR1039… |      0           0   | ENSG00… TNMD      protein_cod… |
##   3 ENSG0000… SRR1039… |    467         510.  | ENSG00… DPM1      protein_cod… |
##   4 ENSG0000… SRR1039… |    260         284.  | ENSG00… SCYL3     protein_cod… |
##   5 ENSG0000… SRR1039… |     60          65.6 | ENSG00… C1orf112  protein_cod… |
##   …     …         …           …            …       …        …           …
## n-4 ENSG0000… SRR1039… |      0           0   | ENSG00… RP11-180… antisense    |
## n-3 ENSG0000… SRR1039… |      0           0   | ENSG00… TSEN34    protein_cod… |
## n-2 ENSG0000… SRR1039… |      0           0   | ENSG00… RP11-138… lincRNA      |
## n-1 ENSG0000… SRR1039… |      0           0   | ENSG00… AP000230… lincRNA      |
## n   ENSG0000… SRR1039… |      0           0   | ENSG00… RP11-80H… lincRNA      |
## # ℹ n = 509,416
## # ℹ 5 more variables: SampleName <fct>, cell <fct>, dex <fct>, albut <fct>,
## #   sizeFactor <dbl>
```

```
# this is equivalent to the following, where we have to transpose
# the `counts` assay data twice to enable the correct recycling
# of the size factor vector
xp |>
  mutate(scaled_counts = t(t(counts) / .cols_asis$sizeFactor))
```

```
## # A RangedSummarizedExperiment-tibble Abstraction: 63,677 × 8
##     .features .samples | counts scaled_counts | gene_id gene_name gene_biotype |
##     <chr>     <chr>    |  <int>         <dbl> | <chr>   <chr>     <chr>        |
##   1 ENSG0000… SRR1039… |    679         742.  | ENSG00… TSPAN6    protein_cod… |
##   2 ENSG0000… SRR1039… |      0           0   | ENSG00… TNMD      protein_cod… |
##   3 ENSG0000… SRR1039… |    467         510.  | ENSG00… DPM1      protein_cod… |
##   4 ENSG0000… SRR1039… |    260         284.  | ENSG00… SCYL3     protein_cod… |
##   5 ENSG0000… SRR1039… |     60          65.6 | ENSG00… C1orf112  protein_cod… |
##   …     …         …           …            …       …        …           …
## n-4 ENSG0000… SRR1039… |      0           0   | ENSG00… RP11-180… antisense    |
## n-3 ENSG0000… SRR1039… |      0           0   | ENSG00… TSEN34    protein_cod… |
## n-2 ENSG0000… SRR1039… |      0           0   | ENSG00… RP11-138… lincRNA      |
## n-1 ENSG0000… SRR1039… |      0           0   | ENSG00… AP000230… lincRNA      |
## n   ENSG0000… SRR1039… |      0           0   | ENSG00… RP11-80H… lincRNA      |
## # ℹ n = 509,416
## # ℹ 5 more variables: SampleName <fct>, cell <fct>, dex <fct>, albut <fct>,
## #   sizeFactor <dbl>
```

# Advanced features

## Object integrity

`plyxp` provides an opinionated framework for how `dplyr` verbs should interact with `SummarizedExperiment` objects. In general, `plyxp` will not allow any operations that it could not guarantee a valid return object.

It is for this reason that `arrange()`, `filter()` and `group_by()` do not allow operations in the default assay context, as this would likely break the assumed structure of a `SummarizedExperiment` object.

## `group_by()`

`plyxp` also supports `group_by` operations allowing users to query information with `dplyr::n()` or `dplyr::cur_group_id()`. However due to the linked structure of a `SummarizedExperiment` object and `plyxp` providing multiple evaluation contexts, grouping operations would be complex and return values would be potentionally ambiguous.

It is for this reason that groupings are themselves **contextual**. The assay context is dependently linked to both the groupings of the rows and cols contexts but, the grouping of rows is ignored when viewed from the cols context and similarly the grouping of cols is ignored when viewed from the rows context. In this way, we have chosen to make the groupings of rows and cols independent between each other. The below figure attempts to show how groupings are conditionally dropped for the scope of an evaluation.

![When evaluating in row context, groupings along `colData()` are temporarily ignored. Figure created with [Biorender](https://biorender.com)](data:image/png;base64...)

When evaluating in row context, groupings along `colData()` are temporarily ignored. Figure created with [Biorender](https://biorender.com)

To further motivate this choice, suppose we did not drop grouping values. Assume you have a small 5 by 4 `SummarizedExperiment` object. Both of the `rowData()` and `colData()` are grouped such that there are 2 groups in both `rowData()` and `colData()` totaling in 4 groups across the assays.

```
group_by(se_simple, rows(direction), cols(condition)) |>
  mutate(rows(data_from_cols = .cols$condition))
```

The above syntax implies we wish to move data from the `colData()` into the `rowData()`. From a previously established conventions, we would expect the output to be an alias for `vctrs::vec_rep(list(condition), times = n())`.
Additionally the `rows()` sentinal will expect that the output of `.cols$condition` will need to match the size of the evaluation context.

Unfortunately, this becomes extremely difficult to resolve with the current conventions. Without dropping the `cols()` groupings, each `rows()` grouping is evaluated equal to the number of groups in `cols()`. At first glance, this may seem desirable, but the problem arises when considering how theses outputs across groups should be stored per group of `rows()`. For example, should the output of the `.cols$condition` return a list equal to the number of groups of the column context? If yes, we would need to consider the size stability of the output context! Assuming that `rowData()` has at least one group with three elements, there is no guarentee it would fit (this also makes a poor assumption that the elements of `rowData()` somehow correspond to the groups of `colData()`). Thus we would be left with wrapping all the results in a list and replicating to the appropriate size. When its all said and done, we would have a list of lists, which is difficult to reason about, potentionally unexpected and painful to work with. For this reason the only groupings present in the `rowData()` context are the groupings in `rowData()`, and similarly for the `colData()` context.

## Printing

Motivated by the `show`/`print` function in *tidySummarizedExperiment*, we visualize the data as if it was tabular. `plyxp` offers the option to opt-in on this behavior by setting the associated global option:

```
options("show_SummarizedExperiment_as_tibble_abstraction" = TRUE)
```

Alternatively, you may use helper functions `use_show_tidy()` and `use_show_default()` to enable and disable this alternative printing respectively.

Since `plyxp` aims to leave the input data as-is when possible, we have considered providing support for printing `S4Vectors` within a `tibble()`. To be clear, `plyxp` **will not** allow you to put `S4Vectors` inside a `tibble()`, but will allow for `S4Vectors` to be printed with `pillar()`, the formatting engine behind `tibble()` pretty printing.

To enable this behavior, before any data is reported to the user, we proxy any `S4Vector` with a custom `vctrs_vctr` object with `plyxp::vec_phantom()`. In truth, the `vec_phantom` object is a simple integer vector with a “phantomData” attribute. This allows us to carry along `S4Vector` through `pillar()`’s printing pipeline until it is time to print the column.

The `pillar_shaft()` method for `vec_phantom` will format the S4 data with `plyxp_pillar_format()` generic, which by default calls `S4Vectors::showAsCell()`. Users are free to create their own methods for S4 vectors that differ from `S4Vectors::showAsCell()` if they like, as seen in `` ?`plyxp-printing` ``

## renaming rows or columns

Inspired by `tidySummarizedExperiment`, `plyxp` provides access to the rownames and colnames of a `SummarizedExperiment` object by installing `.features` and `.samples` into the `rowData()` and `colData()` contexts respectively. These are special in that assigning a value to `.features` in the `rowData()` context or `.samples` in the `colData()` context does not create a new column, but changes the rownames or colnames of the resulting object.

```
se_simple
```

```
## # A SummarizedExperiment-tibble Abstraction: 5 × 4
##     .features .samples | counts logcounts | gene  length direction | sample
##     <chr>     <chr>    |  <int>     <dbl> | <chr>  <int> <chr>     | <chr>
##   1 row_1     col_1    |     14      2.64 | g1         1 -         | s1
##   2 row_2     col_1    |     19      2.94 | g2        24 +         | s1
##   3 row_3     col_1    |     16      2.77 | g3        60 +         | s1
##   4 row_4     col_1    |     11      2.40 | g4        39 -         | s1
##   5 row_5     col_1    |     18      2.89 | g5        37 +         | s1
##   …   …         …             …        …     …         … …            …
## n-4 row_1     col_4    |      9      2.20 | g1         1 -         | s4
## n-3 row_2     col_4    |      4      1.39 | g2        24 +         | s4
## n-2 row_3     col_4    |     20      3.00 | g3        60 +         | s4
## n-1 row_4     col_4    |      3      1.10 | g4        39 -         | s4
## n   row_5     col_4    |      5      1.61 | g5        37 +         | s4
## # ℹ n = 20
## # ℹ 1 more variable: condition <chr>
```

```
# moving data to rownames and colnames
se_simple |>
  mutate(
    orig_names = sprintf(
      "%s-%s",
      # .features is installed in the rows() context
      .rows$.features,
      # .samples is installed in the cols() context
      .cols$.samples),
    rows(.features = gene,
         # deleting rowData column
         gene = NULL),
    cols(.samples = sample,
         # deleting colData column
         sample = NULL)
  )
```

```
## # A SummarizedExperiment-tibble Abstraction: 5 × 4
##     .features .samples | counts logcounts orig_names  | length direction |
##     <chr>     <chr>    |  <int>     <dbl> <chr>       |  <int> <chr>     |
##   1 g1        s1       |     14      2.64 row_1-col_1 |      1 -         |
##   2 g2        s1       |     19      2.94 row_2-col_1 |     24 +         |
##   3 g3        s1       |     16      2.77 row_3-col_1 |     60 +         |
##   4 g4        s1       |     11      2.40 row_4-col_1 |     39 -         |
##   5 g5        s1       |     18      2.89 row_5-col_1 |     37 +         |
##   …  …         …              …        …       …             … …
## n-4 g1        s4       |      9      2.20 row_1-col_4 |      1 -         |
## n-3 g2        s4       |      4      1.39 row_2-col_4 |     24 +         |
## n-2 g3        s4       |     20      3.00 row_3-col_4 |     60 +         |
## n-1 g4        s4       |      3      1.10 row_4-col_4 |     39 -         |
## n   g5        s4       |      5      1.61 row_5-col_4 |     37 +         |
## # ℹ n = 20
## # ℹ 1 more variable: condition <chr>
```

# Troubleshooting and best practices

while `plyxp` takes inspiration from the data masks used in `dplyr`, they are unfortunately more complex. This means there is some overhead in creating the evaluation mask per dplyr verb. Try to reduce the number of `dplyr` verb calls and instead increase the content of each verb. For example instead of doing:

```
.data |>
  mutate(foo = bar) |>
  mutate(baz = foo^2)
```

do the following

```
.data |>
  mutate(
    foo = bar,
    baz = foo^2
  )
```

# Community and support

Please feel free to post questions about `plyxp` to:

* the [Bioconductor support site](https://support.bioconductor.org/)
* as an [Issue](https://github.com/jtlandis/plyxp/issues) on GitHub
* in the `#tidiness_in_bioc` channel on the *community-bioc* Slack

For code contributions:

* For small fixes, feel free to post a PR on GitHub
* For larger structural changes to the package code, please reach out to the development team first through one of the above channels.

Thanks for your interest in `plyxp`!

# Session info

```
devtools::session_info()
```

```
## ─ Session info ───────────────────────────────────────────────────────────────
##  setting  value
##  version  R version 4.5.1 Patched (2025-08-23 r88802)
##  os       Ubuntu 24.04.3 LTS
##  system   x86_64, linux-gnu
##  ui       X11
##  language (EN)
##  collate  C
##  ctype    en_US.UTF-8
##  tz       America/New_York
##  date     2025-11-09
##  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
##  quarto   1.7.32 @ /usr/local/bin/quarto
##
## ─ Packages ───────────────────────────────────────────────────────────────────
##  package              * version date (UTC) lib source
##  abind                  1.4-8   2024-09-12 [2] CRAN (R 4.5.1)
##  airway               * 1.30.0  2025-11-06 [2] Bioconductor 3.22 (R 4.5.1)
##  Biobase              * 2.70.0  2025-11-09 [2] Bioconductor 3.22 (R 4.5.1)
##  BiocGenerics         * 0.56.0  2025-11-09 [2] Bioconductor 3.22 (R 4.5.1)
##  bslib                  0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
##  cachem                 1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
##  cli                    3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
##  DelayedArray           0.36.0  2025-11-09 [2] Bioconductor 3.22 (R 4.5.1)
##  devtools               2.4.6   2025-10-03 [2] CRAN (R 4.5.1)
##  digest                 0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
##  dplyr                * 1.1.4   2023-11-17 [2] CRAN (R 4.5.1)
##  ellipsis               0.3.2   2021-04-29 [2] CRAN (R 4.5.1)
##  evaluate               1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
##  fastmap                1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
##  fs                     1.6.6   2025-04-12 [2] CRAN (R 4.5.1)
##  generics             * 0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
##  GenomicRanges        * 1.62.0  2025-11-09 [2] Bioconductor 3.22 (R 4.5.1)
##  glue                   1.8.0   2024-09-30 [2] CRAN (R 4.5.1)
##  htmltools              0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
##  IRanges              * 2.44.0  2025-11-09 [2] Bioconductor 3.22 (R 4.5.1)
##  jquerylib              0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
##  jsonlite               2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
##  knitr                  1.50    2025-03-16 [2] CRAN (R 4.5.1)
##  lattice                0.22-7  2025-04-02 [3] CRAN (R 4.5.1)
##  lifecycle              1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
##  magrittr               2.0.4   2025-09-12 [2] CRAN (R 4.5.1)
##  Matrix                 1.7-4   2025-08-28 [3] CRAN (R 4.5.1)
##  MatrixGenerics       * 1.22.0  2025-11-09 [2] Bioconductor 3.22 (R 4.5.1)
##  matrixStats          * 1.5.0   2025-01-07 [2] CRAN (R 4.5.1)
##  memoise                2.0.1   2021-11-26 [2] CRAN (R 4.5.1)
##  pillar                 1.11.1  2025-09-17 [2] CRAN (R 4.5.1)
##  pkgbuild               1.4.8   2025-05-26 [2] CRAN (R 4.5.1)
##  pkgconfig              2.0.3   2019-09-22 [2] CRAN (R 4.5.1)
##  pkgload                1.4.1   2025-09-23 [2] CRAN (R 4.5.1)
##  plyxp                * 1.4.3   2025-11-09 [1] Bioconductor 3.22 (R 4.5.1)
##  png                    0.1-8   2022-11-29 [2] CRAN (R 4.5.1)
##  purrr                  1.2.0   2025-11-04 [2] CRAN (R 4.5.1)
##  R6                     2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
##  remotes                2.5.0   2024-03-17 [2] CRAN (R 4.5.1)
##  rlang                  1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
##  rmarkdown              2.30    2025-09-28 [2] CRAN (R 4.5.1)
##  S4Arrays               1.10.0  2025-11-09 [2] Bioconductor 3.22 (R 4.5.1)
##  S4Vectors            * 0.48.0  2025-11-09 [2] Bioconductor 3.22 (R 4.5.1)
##  S7                     0.2.0   2024-11-07 [2] CRAN (R 4.5.1)
##  sass                   0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
##  Seqinfo              * 1.0.0   2025-11-09 [2] Bioconductor 3.22 (R 4.5.1)
##  sessioninfo            1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
##  SparseArray            1.10.1  2025-11-09 [2] Bioconductor 3.22 (R 4.5.1)
##  SummarizedExperiment * 1.40.0  2025-11-09 [2] Bioconductor 3.22 (R 4.5.1)
##  tibble               * 3.3.0   2025-06-08 [2] CRAN (R 4.5.1)
##  tidyr                  1.3.1   2024-01-24 [2] CRAN (R 4.5.1)
##  tidyselect             1.2.1   2024-03-11 [2] CRAN (R 4.5.1)
##  usethis                3.2.1   2025-09-06 [2] CRAN (R 4.5.1)
##  utf8                   1.2.6   2025-06-08 [2] CRAN (R 4.5.1)
##  vctrs                  0.6.5   2023-12-01 [2] CRAN (R 4.5.1)
##  withr                  3.0.2   2024-10-28 [2] CRAN (R 4.5.1)
##  xfun                   0.54    2025-10-30 [2] CRAN (R 4.5.1)
##  XVector                0.50.0  2025-11-09 [2] Bioconductor 3.22 (R 4.5.1)
##  yaml                   2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
##
##  [1] /tmp/Rtmpf5HQeh/Rinst254a2a3188928c
##  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
##  [3] /home/biocbuild/bbs-3.22-bioc/R/library
##  * ── Packages attached to the search path.
##
## ──────────────────────────────────────────────────────────────────────────────
```

# References

---

1. At this moment `rowRanges()` is not supported in `plyxp` but may become its own pronoun in the future.[↩︎](#fnref1)