# Pedigree object

Terry Therneau, Elizabeth Atkinson, Louis Le Nezet

#### 30 October, 2025

# Contents

* [1 Introduction](#introduction)
* [2 Pedigree Constructor](#pedigree-constructor)
  + [2.1 Arguments](#arguments)
  + [2.2 Notes](#notes)
  + [2.3 Column renaming](#column-renaming)
  + [2.4 Normalisation](#normalisation)
  + [2.5 Validation](#validation)
* [3 Pedigree Class](#pedigree-class)
* [4 Pedigree accessors](#pedigree-accessors)
  + [4.1 For the Pedigree object](#for-the-pedigree-object)
  + [4.2 For the Ped object](#for-the-ped-object)
  + [4.3 For the Rel object](#for-the-rel-object)
  + [4.4 For the Scales object](#for-the-scales-object)
  + [4.5 For the Hints object](#for-the-hints-object)
  + [4.6 Focus on `mcols()`](#focus-on-mcols)
* [5 Pedigree methods](#pedigree-methods)
* [6 Session information](#session-information)

# 1 Introduction

The pedigree routines came out of a simple need – to quickly draw a
Pedigree structure on the screen, within R, that was “good enough” to
help with debugging the actual routines of interest, which were those for
fitting mixed effecs Cox models to large family data. As such the routine
had compactness and automation as primary goals; complete annotation
(monozygous twins, multiple types of affected status) and most certainly
elegance were not on the list. Other software could do that much
better.

It therefore came as a major surprise when these routines proved useful
to others. Through their constant feedback, application to more
complex pedigrees, and ongoing requests for one more feature, the routine has
become what it is today. This routine is still not
suitable for really large pedigrees, nor for heavily inbred ones such as in
animal studies, and will likely not evolve in that way. The authors fondest
hope is that others will pick up the project.

# 2 Pedigree Constructor

## 2.1 Arguments

The Pedigree function is the first step, creating an object of class
Pedigree.
It accepts the following input

* `ped_df` A dataframe containing the columns
  + `id` A numeric or character vector of subject identifiers.
  + `dadid` The identifier of the father.
  + `momid` The identifier of the mother.
  + `famid` Optional, a numeric or character vector of family
    identifiers.
  + `sex` The gender of the individual. This can be a numeric
    variable with codes of `1`=male, `2`=female, `3`=unknown,
    or NA=unknown.
    A character or factor variable can also be supplied containing
    the above; the string may be truncated and of arbitrary case.
  + `fertility` Optional, will be transformed to an ordered factor using the
    `fertility_to_factor()` function.
    `infertile_choice_na`, `infertile`, `fertile`
    The following values are recognized:
    - character() or factor() : “fertile”, “infertile”, “steril”,
      “infertile\_choice”, “infertile\_na”, “infertile\_choice\_na”
    - numeric() : 1 = “fertile”, 0 = “infertile”
    - logical() : `TRUE` = “fertile”, `FALSE` = “infertile”
  + `miscarriage` Optional, will be transformed to an factor using the
    `miscarriage_to_factor()` function.
    `TOP`, `SAB`, `ECT`, `FALSE`
    The following values are recognized:
    - character() or factor() : “spontaneous”, “spontaenous abortion”,
      “termination”, “terminated”, “termination of pregnancy”,
      “ectopic”, “ectopic pregnancy”, “false”
    - numeric() : 0 = “FALSE”, `NA` = “FALSE”
    - logical() : `FALSE` = “FALSE”
  + `deceased` Optional, a logical variable with `0`=alive and
    `1`=dead.
  + `avail` Optional, a logical variable with `0`=unavailable
    and `1`=available.
  + `evaluated` Optional, a logical variable with `0`=not evaluated
    and `1`=evaluated.
  + `consultand` Optional, a logical variable with `0`=not consultand
    and `1`=consultand.
  + `proband` Optional, a logical variable with `0`=not proband
    and `1`=proband.
  + `affected` Optional, a logical variable with `0`=unaffected
    and `1`=affected.
  + `carrier` Optional, a logical variable with `0`=not a carrier
    `1`=carrier and `NA`=unknown.
  + `asymptomatic` Optional, a logical variable with `0`=not asymptomatic
    `1`=asymptomatic and `NA`=asymptomatic.
  + `adopted` Optional, a logical variable with `0`=not adopted
    `1`=adopted.
* `rel_df` Optional, a data frame with three columns or four columns.
  + `id1` identifier values of the subject pairs
  + `id2` identifier values of the subject pairs
  + `code` relationship codification : `1`=Monozygotic twin,
    `2`=Dizygotic twin, `3`=twin of unknown zygosity, `4`=Spouse.
  + `famid` Optional, a numeric or character vector of family
    identifiers.
* `cols_ren_ped` Optional, a named list for the renaming of the
  `ped_df` dataframe
* `cols_ren_rel` Optional, a named list for the renaming of the
  `rel_df` dataframe
* `normalize` Optional, a logical to know if the data should be normalised.
* `hints` Optional, a list containing the horder in which to plot the
  individuals and the matrix of the spouse.

## 2.2 Notes

Note that a factor variable is not listed as one of the choices for the
subject identifier. This is on purpose. Factors
were designed to accomodate character strings whose values came from a limited
class – things like race or gender, and are not appropriate for a subject
identifier. All of their special properties as compared to a character
variable turn out to be backwards for this case, in particular a memory
of the original level set when subscripting is done.

However, due to the awful decision early on in S to automatically turn every
character into a factor, unless you stood at the door with a club to
head the package off, most users have become ingrained to the idea of
using them for every character variable.

(I encourage you to set the global option `stringsAsFactors = FALSE` to turn
off autoconversion, it will measurably improve your R experience).

Therefore, to avoid unnecessary hassle for our users
the code will accept a factor as input for the id variables, but
the final structure does not retain it.
Gender and relation do become factors.
Status follows the pattern of the survival routines and remains an integer.

## 2.3 Column renaming

Based on the dataframe given for `ped_df` and `rel_df` and their
corresponding named list, the columns are renamed for them to be used
correctly.
The renaming is done as follow

```
rel_df <- data.frame(
    indId1 = c("110", "204"),
    indId2 = c("112", "205"),
    code = c(1, 2),
    family = c("1", "2")
)
cols_ren_rel <- list(
    id1 = "indId1",
    id2 = "indId2",
    famid = "family"
)

## Rename columns rel
old_cols <- as.vector(unlist(cols_ren_rel))
new_cols <- names(cols_ren_rel)
cols_to_ren <- match(old_cols, names(rel_df))
names(rel_df)[cols_to_ren[!is.na(cols_to_ren)]] <-
    new_cols[!is.na(cols_to_ren)]
print(rel_df)
```

```
##   id1 id2 code famid
## 1 110 112    1     1
## 2 204 205    2     2
```

## 2.4 Normalisation

If the normalisation process is selected `normalize = TRUE`, then both
dataframe will be checked by their dedicated normalization function.
It will ensure that all modalities are written correctly and set up the
right way. If a `famid` column is present in the dataframe, then it will
be aggregated to the id of each individual and separated by an ’’\_’’ to
ensure the uniqueness of the individuals identifiers.

```
library(Pedixplorer)
data("sampleped")
cols <- c("sex", "id", "avail")
summary(sampleped[cols])
```

```
##       sex             id                avail
##  Min.   :1.000   Length:55          Min.   :0.0000
##  1st Qu.:1.000   Class :character   1st Qu.:0.0000
##  Median :2.000   Mode  :character   Median :0.0000
##  Mean   :1.564                      Mean   :0.4364
##  3rd Qu.:2.000                      3rd Qu.:1.0000
##  Max.   :3.000                      Max.   :1.0000
```

```
pedi <- Pedigree(sampleped)
summary(as.data.frame(ped(pedi))[cols])
```

```
##       sex          id              avail
##  male   :26   Length:55          Mode :logical
##  female :27   Class :character   FALSE:31
##  unknown: 2   Mode  :character   TRUE :24
```

### 2.4.1 Errors present after the normalisation process

If any error is detected after the normalisation process, then the normalised
dataframe is gave back to the user with errors column added describing the
encountered problems.

```
rel_wrong <- rel_df
rel_wrong$code[2] <- "A"
df <- Pedigree(sampleped, rel_wrong)
```

```
## Warning in .local(obj, ...): The relationship informations are not valid. Here is the normalised
## relationship informations with the identified problems
```

```
print(df)
```

```
##     id1   id2    code famid              error
## 1 1_110 1_112 MZ twin     1               <NA>
## 2 2_204 2_205    <NA>     2 code-not-recognise
```

## 2.5 Validation

Now that the data for the Pedigree object creation are ready, they are
given to a new `Pedigree` object, trigerring the *validation* process.

This validation step will check up for many errors such as:

* All necessary columns are present
* No duplicated `id`
* All `momid` and `dadid` are present in `id`
* `sex` column only contain “male”, “female”, “unknown” values
* `fertility` column only contain “fertile”, “infertile”, “infertile\_choice\_na”
* `miscarriage` column only contain “SAB”, “TOP”, “ECT”, “FALSE”
* `deceased`, `avail`, `evaluated`, `consultand`, `proband`,
  `affected`, `carrier`, `asymptomatic`, `adopted` only contains 0, 1 or NA values
* Father are males and Mother are females
* Twins have same parents and MZ twins have same sex
* Hints object is valid and ids contained is in the Ped object
* …

# 3 Pedigree Class

After validation an \(S4\) object is generated.
This new concept make it possible to easily setup methods for this new
type of object.
The controls of the parameters is also more precise.

The `Pedigree` object contains 4 slots, each of them contains a different
\(S4\) object containing a specific type of information used for the Pedigree
construction.

* `ped` a Ped object for the Pedigree information with at least the following
  slots:
  + `id` the identifiers of the individuals
  + `dadid` the identifiers of the fathers
  + `momid` the identifiers of the mothers
  + `sex` the gender of each individuals
* `rel` a Rel object describing all special relationship beetween individuals
  that can’t be descibed in the `ped` slot.
  The minimal slots needed are :
  + `id1` the identifiers of the 1st individuals
  + `id2` the identifiers of the 2nd individuals
  + `code` factor describing the type of relationship
    (“MZ twin”, “DZ twin”, “UZ twin”, “Spouse”)
* `scales` a Scales object with two slots :
  + `fill` a dataframe describing which modalities in which columns
    correspond to an affected individuals.
    Plotting information such as colour, angle and density are also provided
  + `border` a dataframe describing which modalities in which columns to
    use to plot the border of the plot elements.
* `hints` a Hints object with two slots :
  + `horder` numeric vector for the ordering of the individuals plotting
  + `spouse` a matrix of the spouses

For more information on each object:

* `help(Ped)`
* `help(Rel)`
* `help(Scales)`
* `help(Hints)`

# 4 Pedigree accessors

As the Pedigree object is now an \(S4\) class, we have made available a number
of accessors.
Most of them can be used as a getter or as a setter to modify a value in the
correponding slot of the object

## 4.1 For the Pedigree object

* Get/Set slots : `ped()`, `rel()`, `scales()`, `hints()`
* Wrapper to the Ped object: `mcols()`
* Wrapper of the Scales object: `fill()`, `border()`
* Wrapper of the Hints object: `horder()`, `spouse()`

## 4.2 For the Ped object

* Identity input: `id()`, `dadid()`, `momid()`, `famid()`, `sex()`
* Other infos used : `fertility()`, `miscarriage()`, `deceased()`,
  `avail()`, `evaluated()`, `consultand()`, `proband()`,
  `affected()`, `carrier()`, `asymptomatic()`, `adopted()`
* Computed : `isinf()`, `kin()`, `useful()`
* Metadata : `mcols()`

## 4.3 For the Rel object

* `id1()`, `id2()`, `code()`, `famid()`

## 4.4 For the Scales object

* `fill()`, `border()`

## 4.5 For the Hints object

* `horder()`, `spouse()`

## 4.6 Focus on `mcols()`

The `mcols()` accessors is the one you should use to add more
informations to your individuals.

```
pedi <- Pedigree(sampleped)
mcols(pedi)
```

```
## DataFrame with 55 rows and 5 columns
##     affection       num       error affection_mods avail_mods
##     <integer> <integer> <character>      <numeric>  <numeric>
## 1           0         2          NA              0          0
## 2           1         3          NA              1          0
## 3           1         2          NA              1          0
## 4           0         4          NA              0          0
## 5          NA         6          NA             NA          0
## ...       ...       ...         ...            ...        ...
## 51          0         2          NA              0          0
## 52          0         1          NA              0          1
## 53          0         3          NA              0          1
## 54          0         2          NA              0          0
## 55          1         0          NA              1          1
```

```
## Add new columns as a threshold if identifiers of individuals superior
## to a given threshold for example
mcols(pedi)$idth <- ifelse(as.numeric(
    stringr::str_split_i(id(ped(pedi)), "_", 2)
) < 200, "A", "B")
mcols(pedi)$idth
```

```
##  [1] "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A"
## [25] "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "A" "B" "B" "B" "B" "B" "B" "B"
## [49] "B" "B" "B" "B" "B" "B" "B"
```

# 5 Pedigree methods

With this new S4 object comes multiple methods to ease the use of it:

* `plot()`
* `summary()`
* `print()`
* `show()`
* `as.list()`
* `[`
* `shrink()`
* `generate_colors()`
* `is_informative()`
* `kindepth()`
* `kinship()`
* `make_famid()`
* `upd_famid()`
* `num_child()`
* `unrelated()`
* `useful_inds()`

```
## We can change the family name based on an other column
pedi <- upd_famid(pedi, mcols(pedi)$idth)

## We can substract a given family
ped_a <- pedi[famid(ped(pedi)) == "A"]

## Plot it
plot(ped_a, cex = 0.5)
```

```
## Individuals:  A_113 won't be plotted
```

![Pedigree plot](data:image/png;base64...)

```
## Do a summary
summary(ped_a)
```

```
## $pedigree_summary
## [1] "Ped object with 41 individuals and 6 metadata columns"
##
## $relationship_summary
## [1] "Rel object with 0 relationshipswith 0 MZ twin, 0 DZ twin, 0 UZ twin, 0 Spouse"
```

```
## Coerce it to a list
as.list(ped_a)[[1]][1:3]
```

```
## $id
##  [1] "A_101" "A_102" "A_103" "A_104" "A_105" "A_106" "A_107" "A_108" "A_109" "A_110" "A_111" "A_112"
## [13] "A_113" "A_114" "A_115" "A_116" "A_117" "A_118" "A_119" "A_120" "A_121" "A_122" "A_123" "A_124"
## [25] "A_125" "A_126" "A_127" "A_128" "A_129" "A_130" "A_131" "A_132" "A_133" "A_134" "A_135" "A_136"
## [37] "A_137" "A_138" "A_139" "A_140" "A_141"
##
## $dadid
##  [1] NA      NA      "A_135" NA      NA      NA      NA      NA      "A_101" "A_103" "A_103" "A_103"
## [13] NA      "A_103" "A_105" "A_105" NA      "A_105" "A_105" "A_107" "A_110" "A_110" "A_110" "A_110"
## [25] "A_112" "A_112" "A_114" "A_114" "A_117" "A_119" "A_119" "A_119" "A_119" "A_119" NA      NA
## [37] NA      "A_135" "A_137" "A_137" "A_137"
##
## $momid
##  [1] NA      NA      "A_136" NA      NA      NA      NA      NA      "A_102" "A_104" "A_104" "A_104"
## [13] NA      "A_104" "A_106" "A_106" NA      "A_106" "A_106" "A_108" "A_109" "A_109" "A_109" "A_109"
## [25] "A_118" "A_118" "A_115" "A_115" "A_116" "A_120" "A_120" "A_120" "A_120" "A_120" NA      NA
## [37] NA      "A_136" "A_138" "A_138" "A_138"
```

```
## Shrink it to keep only the necessary information
lst1_s <- shrink(ped_a, max_bits = 10)
plot(lst1_s$pedObj, cex = 0.5)
```

![Pedigree plot](data:image/png;base64...)

```
## Compute the kinship individuals matrix
adopted(ped(ped_a)) <- FALSE # Set adopted to FALSE
kinship(ped_a)[1:10, 1:10]
```

```
## 10 x 10 sparse Matrix of class "dsCMatrix"
```

```
##   [[ suppressing 10 column names 'A_101', 'A_102', 'A_103' ... ]]
```

```
##
## A_101 0.50 .    .    .    .   .   .   .   0.25 .
## A_102 .    0.50 .    .    .   .   .   .   0.25 .
## A_103 .    .    0.50 .    .   .   .   .   .    0.25
## A_104 .    .    .    0.50 .   .   .   .   .    0.25
## A_105 .    .    .    .    0.5 .   .   .   .    .
## A_106 .    .    .    .    .   0.5 .   .   .    .
## A_107 .    .    .    .    .   .   0.5 .   .    .
## A_108 .    .    .    .    .   .   .   0.5 .    .
## A_109 0.25 0.25 .    .    .   .   .   .   0.50 .
## A_110 .    .    0.25 0.25 .   .   .   .   .    0.50
```

```
## Get the useful individuals
ped_a <- is_informative(ped_a, informative = "AvAf", col_aff = "affection")
ped_a <- useful_inds(ped_a)
as.data.frame(ped(ped_a))["useful"][1:10, ]
```

```
##  [1]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE  TRUE  TRUE
```

# 6 Session information

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
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=en_GB
##  [4] LC_COLLATE=C               LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                  LC_ADDRESS=C
## [10] LC_TELEPHONE=C             LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] cowplot_1.2.0     Pedixplorer_1.6.0 dplyr_1.1.4       plotly_4.11.0     ggplot2_4.0.0
## [6] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] gtable_0.3.6          shinyjqui_0.4.1       xfun_0.53             bslib_0.9.0
##  [5] shinyjs_2.1.0         htmlwidgets_1.6.4     lattice_0.22-7        crosstalk_1.2.2
##  [9] quadprog_1.5-8        vctrs_0.6.5           tools_4.5.1           generics_0.1.4
## [13] stats4_4.5.1          tibble_3.3.0          pkgconfig_2.0.3       Matrix_1.7-4
## [17] data.table_1.17.8     RColorBrewer_1.1-3    S7_0.2.0              S4Vectors_0.48.0
## [21] readxl_1.4.5          lifecycle_1.0.4       stringr_1.5.2         compiler_4.5.1
## [25] farver_2.1.2          shinytoastr_2.2.0     tinytex_0.57          httpuv_1.6.16
## [29] shinyWidgets_0.9.0    htmltools_0.5.8.1     sass_0.4.10           yaml_2.3.10
## [33] lazyeval_0.2.2        pillar_1.11.1         later_1.4.4           jquerylib_0.1.4
## [37] tidyr_1.3.1           DT_0.34.0             cachem_1.1.0          magick_2.9.0
## [41] mime_0.13             tidyselect_1.2.1      digest_0.6.37         stringi_1.8.7
## [45] colourpicker_1.3.0    purrr_1.1.0           bookdown_0.45         labeling_0.4.3
## [49] fastmap_1.2.0         grid_4.5.1            cli_3.6.5             magrittr_2.0.4
## [53] dichromat_2.0-0.1     withr_3.0.2           scales_1.4.0          promises_1.4.0
## [57] rmarkdown_2.30        httr_1.4.7            igraph_2.2.1          otel_0.2.0
## [61] cellranger_1.1.0      shiny_1.11.1          evaluate_1.0.5        knitr_1.50
## [65] shinycssloaders_1.1.0 miniUI_0.1.2          viridisLite_0.4.2     rlang_1.1.6
## [69] Rcpp_1.1.0            xtable_1.8-4          glue_1.8.0            shinyhelper_0.3.2
## [73] BiocManager_1.30.26   BiocGenerics_0.56.0   jsonlite_2.0.0        R6_2.6.1
## [77] plyr_1.8.9
```