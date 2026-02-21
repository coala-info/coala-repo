# Fragmentation Analysis with topdownr

Pavel V. Shliaha1, Sebastian Gibb2 and Ole Nørregaard Jensen1

1Department of Biochemistry and Molecular Biology, University of Southern Denmark, Denmark.
2Department of Anesthesiology and Intensive Care, University Medicine Greifswald, Germany.

#### 30 October 2025

#### Abstract

This vignette describes the fragmentation analysis functionality of the `topdownr` package.

#### Package

topdownr 1.32.0

# Foreword

*[topdownr](https://bioconductor.org/packages/3.22/topdownr)* is free and
open-source software. If you use it, please support the project by
citing it in publications:

P.V. Shliaha, S. Gibb, V. Gorshkov, M.S. Jespersen, G.R. Andersen, D. Bailey, J. Schwartz, S. Eliuk, V. Schwämmle, and O.N. Jensen. 2018. Maximizing Sequence Coverage in Top-Down Proteomics By Automated Multi-modal Gas-phase Protein Fragmentation. Analytical Chemistry. DOI: [10.1021/acs.analchem.8b02344](https://doi.org/10.1021/acs.analchem.8b02344)

# Questions and bugs

For bugs, typos, suggestions or other questions, please file an issue
in our tracking system (<https://github.com/sgibb/topdownr/issues>)
providing as much information as possible, a reproducible example and
the output of `sessionInfo()`.

If you don’t have a GitHub account or wish to reach a broader audience
for general questions about proteomics analysis using R, you may want
to use the Bioconductor support site: <https://support.bioconductor.org/>.

# 1 Introduction/Working with `topdownr`

Load the package.

```
library("topdownr")
```

## 1.1 Importing Files

Some example files are provided in the `topdownrdata` package. For a full
analysis you need a `.fasta` file with the protein sequence, the
`.experiments.csv` files containing the method information, the `.txt` files
containing the scan header information and the `.mzML` files with the
deconvoluted spectra.

```
## list.files(topdownrdata::topDownDataPath("myoglobin"))
```

```
$csv
[1] ".../20170629_myo/experiments/myo_1211_ETDReagentTarget_1e6_1.experiments.csv.gz"
[2] ".../20170629_myo/experiments/myo_1211_ETDReagentTarget_1e6_2.experiments.csv.gz"
[3] "..."

$fasta
[1] ".../20170629_myo/fasta/myoglobin.fasta.gz"
[2] "..."

$mzML
[1] ".../20170629_myo/mzml/myo_1211_ETDReagentTarget_1e6_1.mzML.gz"
[2] ".../20170629_myo/mzml/myo_1211_ETDReagentTarget_1e6_2.mzML.gz"
[3] "..."

$txt
[1] ".../20170629_myo/header/myo_1211_ETDReagentTarget_1e6_1.txt.gz"
[2] ".../20170629_myo/header/myo_1211_ETDReagentTarget_1e6_2.txt.gz"
[3] "..."
```

All these files have to be in a directory. You could import them via
`readTopDownFiles`. This function has some arguments. The most important ones
are the `path` of the directory containing the files,
the protein `modification` (e.g. initiator methionine removal,
`"Met-loss"`), and adducts (e.g. proton transfer often occurs
from c to z-fragment after ETD reaction).

```
## the mass adduct for a proton
H <- 1.0078250321

myoglobin <- readTopDownFiles(
    ## directory path
    path = topdownrdata::topDownDataPath("myoglobin"),
    ## fragmentation types
    type = c("a", "b", "c", "x", "y", "z"),
    ## adducts (add -H/H to c/z and name
    ## them cmH/zpH (c minus H, z plus H)
    adducts = data.frame(
        mass=c(-H, H),
        to=c("c", "z"),
        name=c("cmH", "zpH")),
    ## initiator methionine removal
    modifications = "Met-loss",
    ## don't use neutral loss
    neutralLoss = NULL,
    ## tolerance for fragment matching
    tolerance = 5e-6,
    ## topdownrdata was generate with an older version of topdownr,
    ## the method files were generated with FilterString identification,
    ## use `conditions = "ScanDescription"` (default) for recent data.
    conditions = "FilterString"
)
```

```
## Warning in FUN(X[[i]], ...): 61 FilterString entries modified because of
## duplicated ID for different conditions.
```

```
## Warning in FUN(X[[i]], ...): 63 FilterString entries modified because of
## duplicated ID for different conditions.
```

```
## Warning in FUN(X[[i]], ...): 53 FilterString entries modified because of
## duplicated ID for different conditions.
```

```
## Warning in FUN(X[[i]], ...): 55 FilterString entries modified because of
## duplicated ID for different conditions.
```

```
## Warning in FUN(X[[i]], ...): 50 FilterString entries modified because of
## duplicated ID for different conditions.
## Warning in FUN(X[[i]], ...): 50 FilterString entries modified because of
## duplicated ID for different conditions.
```

```
## Warning in FUN(X[[i]], ...): ID in FilterString are not sorted in ascending
## order. Introduce own condition ID via 'cumsum'.
## Warning in FUN(X[[i]], ...): ID in FilterString are not sorted in ascending
## order. Introduce own condition ID via 'cumsum'.
```

```
myoglobin
```

```
## TopDownSet object (7.28 Mb)
## - - - Protein data - - -
## Amino acid sequence (153): GLSDGEWQQVLNVWGKVEADIAGHGQ...GAMTKALELFRNDIAAKYKELGFQG
## Mass : 16922.95
## Modifications (1): Met-loss
## - - - Fragment data - - -
## Number of theoretical fragments: 1216
## Theoretical fragment types (6): a, b, c, x, y, z
## Theoretical mass range: [30.03;16910.93]
## - - - Condition data - - -
## Number of conditions: 1852
## Number of scans: 5882
## Condition variables (66): File, Scan, ..., Sample, MedianIonInjectionTimeMs
## - - - Intensity data - - -
## Size of array: 1216x5882 (5.15% != 0)
## Number of matched fragments: 368296
## Intensity range: [87.61;10704001.00]
## - - - Processing information - - -
## [2025-10-30 02:59:40] 368296 fragments [1216;5882] matched (tolerance: 5 ppm, strategies ion/fragment: remove/remove).
## [2025-10-30 02:59:40] Condition names updated based on: Mz, AgcTarget, EtdReagentTarget, EtdActivation, CidActivation, HcdActivation. Order of conditions changed. 1852 conditions.
## [2025-10-30 02:59:41] Recalculate median injection time based on: Mz, AgcTarget.
```

## 1.2 The `TopDownSet` Anatomy

The assembled object is an `TopDownSet` object.
Briefly it is composed of three interconnected tables:

1. `rowViews`/*fragment data*: holds the information on the type of fragments,
   their modifications and adducts.
2. `colData`/*condition data*: contains the corresponding fragmentation
   condition for every spectrum.
3. `assayData`: contains the intensity of assigned fragments.

![](data:image/svg+xml;base64...)

TopDownSet anatomy, image adopted from (Morgan et al. [2017](#ref-SummarizedExperiment)).

## 1.3 Technical Details

This section explains the implementation details of the `TopDownSet` class. It
is not necessary to understand everything written here to use `topdownr` for the
analysis of fragmentation data.

The `TopDownSet` contains the following components: *Fragment data*, *Condition
data*, *Assay data*.

### 1.3.1 Fragment data

```
rowViews(myoglobin)
```

```
## FragmentViews on a 153-letter sequence:
##   GLSDGEWQQVLNVWGKVEADIAGHGQEVLIRLFTGHPE...SKHPGDFGADAQGAMTKALELFRNDIAAKYKELGFQG
## Mass:
##   16922.95406
## Modifications:
##   Met-loss
## Views:
##        start end width     mass name   type   z
##    [1]     1   1     1    30.03 a1     a      1 [G]
##    [2]     1   1     1    58.03 b1     b      1 [G]
##    [3]     1   1     1    59.01 z1     z      1 [G]
##    [4]     1   1     1    60.02 zpH1   z      1 [G]
##    [5]     1   1     1    74.05 cmH1   c      1 [G]
##    ...   ... ...   ...      ... ...    ...  ... ...
## [1212]     2 153   152 16868.93 zpH152 z      1 [LSDGEWQQVLNVWG...DIAAKYKELGFQG]
## [1213]     1 152   152 16882.96 cmH152 c      1 [GLSDGEWQQVLNVW...NDIAAKYKELGFQ]
## [1214]     1 152   152 16883.97 c152   c      1 [GLSDGEWQQVLNVW...NDIAAKYKELGFQ]
## [1215]     2 153   152 16884.95 y152   y      1 [LSDGEWQQVLNVWG...DIAAKYKELGFQG]
## [1216]     2 153   152 16910.93 x152   x      1 [LSDGEWQQVLNVWG...DIAAKYKELGFQG]
```

The fragmentation data are represented by an `FragmentViews` object that is an
overloaded `XStringViews` object. It contains one `AAString`
(the protein sequence) and an `IRanges` object that stores the
`start`, `end` (and `width`) values of the fragments.
Additionally it has a `DataFrame` for the `mass`, `type` and `z` information
of each fragment.

### 1.3.2 Condition data

```
conditionData(myoglobin)[, 1:5]
```

```
## DataFrame with 5882 rows and 5 columns
##                                                  File      Scan SpectrumIndex
##                                                 <Rle> <numeric>     <integer>
## C0707.30_1.0e+05_1.0e+06_02.50_07_00_1  myo_707_ET...        33            22
## C0707.30_1.0e+05_1.0e+06_02.50_07_00_2  myo_707_ET...        34            23
## C0707.30_1.0e+05_1.0e+06_02.50_07_00_3  myo_707_ET...        33            23
## C0707.30_1.0e+05_1.0e+06_02.50_07_00_4  myo_707_ET...        34            24
## C0707.30_1.0e+05_1.0e+06_02.50_14_00_1  myo_707_ET...        36            25
## ...                                               ...       ...           ...
## C1211.70_1.0e+06_0.0e+00_00.00_00_35_07 myo_1211_E...       223           203
## C1211.70_1.0e+06_0.0e+00_00.00_00_35_08 myo_1211_E...       221           202
## C1211.70_1.0e+06_0.0e+00_00.00_00_35_09 myo_1211_E...       222           203
## C1211.70_1.0e+06_0.0e+00_00.00_00_35_10 myo_1211_E...       223           203
## C1211.70_1.0e+06_0.0e+00_00.00_00_35_11 myo_1211_E...       224           204
##                                         PeaksCount TotIonCurrent
##                                          <integer>     <numeric>
## C0707.30_1.0e+05_1.0e+06_02.50_07_00_1         161      27224937
## C0707.30_1.0e+05_1.0e+06_02.50_07_00_2         175      29167765
## C0707.30_1.0e+05_1.0e+06_02.50_07_00_3         180      26132872
## C0707.30_1.0e+05_1.0e+06_02.50_07_00_4         171      25475501
## C0707.30_1.0e+05_1.0e+06_02.50_14_00_1         172      27347105
## ...                                            ...           ...
## C1211.70_1.0e+06_0.0e+00_00.00_00_35_07        213       2566120
## C1211.70_1.0e+06_0.0e+00_00.00_00_35_08        250       2348707
## C1211.70_1.0e+06_0.0e+00_00.00_00_35_09        145       2305900
## C1211.70_1.0e+06_0.0e+00_00.00_00_35_10        207       2262800
## C1211.70_1.0e+06_0.0e+00_00.00_00_35_11        158       2212189
```

Condition data is a `DataFrame` that contains the combined header information
for each MS run (combined from method (`.experiments.csv` files)/scan header
(`.txt` files) table and metadata from the `.mzML` files).

### 1.3.3 Assay data

```
assayData(myoglobin)[206:215, 1:10]
```

```
## 10 x 10 sparse Matrix of class "dgCMatrix"
```

```
##   [[ suppressing 10 column names 'C0707.30_1.0e+05_1.0e+06_02.50_07_00_1', 'C0707.30_1.0e+05_1.0e+06_02.50_07_00_2', 'C0707.30_1.0e+05_1.0e+06_02.50_07_00_3' ... ]]
```

```
##
## z26        .        .        .        .        .        .        .        .
## zpH26 491328.4 446301.1 407389.1 473200.9 470679.3 493244.8 390025.8 389430.25
## y26        .        .        .        .        .        .        .    23648.63
## b27        .        .        .        .        .        .        .        .
## cmH27      .        .        .        .        .        .        .        .
## c27        .        .        .        .        .        .        .        .
## x26        .        .        .        .        .        .        .        .
## z27        .        .        .        .        .        .        .        .
## zpH27 534307.6 534135.1 434296.8 436866.2 550887.3 513038.8 460476.4 456524.97
## y27        .        .        .        .        .        .        .        .
##
## z26        .        .
## zpH26 496551.3 554295.7
## y26        .        .
## b27        .        .
## cmH27      .        .
## c27        .        .
## x26        .        .
## z27        .        .
## zpH27 602207.0 579989.8
## y27        .        .
```

Assay data is a `sparseMatrix` from the `Matrix` package
(in detail a `dgCMatrix`) where the rows correspond to the fragments,
the columns to the runs/conditions and the entries to the intensity values.
A `sparseMatrix` is similar to the classic `matrix` in *R* but stores just
the values that are different from zero.

## 1.4 Subsetting a `TopDownSet`

A `TopDownSet` could be subsetted by the fragment and the condition data.

```
# select the first 100 fragments
myoglobin[1:100]
```

```
## TopDownSet object (3.56 Mb)
## - - - Protein data - - -
## Amino acid sequence (153): GLSDGEWQQVLNVWGKVEADIAGHGQ...GAMTKALELFRNDIAAKYKELGFQG
## Mass : 16922.95
## Modifications (1): Met-loss
## - - - Fragment data - - -
## Number of theoretical fragments: 100
## Theoretical fragment types (6): a, b, c, x, y, z
## Theoretical mass range: [30.03;1426.70]
## - - - Condition data - - -
## Number of conditions: 1852
## Number of scans: 5882
## Condition variables (66): File, Scan, ..., Sample, MedianIonInjectionTimeMs
## - - - Intensity data - - -
## Size of array: 100x5882 (9.68% != 0)
## Number of matched fragments: 56955
## Intensity range: [105.70;1076768.00]
## - - - Processing information - - -
## [2025-10-30 02:59:40] 368296 fragments [1216;5882] matched (tolerance: 5 ppm, strategies ion/fragment: remove/remove).
## [2025-10-30 02:59:40] Condition names updated based on: Mz, AgcTarget, EtdReagentTarget, EtdActivation, CidActivation, HcdActivation. Order of conditions changed. 1852 conditions.
## [2025-10-30 02:59:41] Recalculate median injection time based on: Mz, AgcTarget.
## [2025-10-30 02:59:41] Subsetted 368296 fragments [1216;5882] to 56955 fragments [100;5882].
```

```
# select all "c" fragments
myoglobin["c"]
```

```
## TopDownSet object (4.51 Mb)
## - - - Protein data - - -
## Amino acid sequence (153): GLSDGEWQQVLNVWGKVEADIAGHGQ...GAMTKALELFRNDIAAKYKELGFQG
## Mass : 16922.95
## Modifications (1): Met-loss
## - - - Fragment data - - -
## Number of theoretical fragments: 304
## Theoretical fragment types (1): c
## Theoretical mass range: [74.05;16883.97]
## - - - Condition data - - -
## Number of conditions: 1852
## Number of scans: 5882
## Condition variables (66): File, Scan, ..., Sample, MedianIonInjectionTimeMs
## - - - Intensity data - - -
## Size of array: 304x5882 (7.69% != 0)
## Number of matched fragments: 137461
## Intensity range: [87.61;1203763.75]
## - - - Processing information - - -
## [2025-10-30 02:59:40] 368296 fragments [1216;5882] matched (tolerance: 5 ppm, strategies ion/fragment: remove/remove).
## [2025-10-30 02:59:40] Condition names updated based on: Mz, AgcTarget, EtdReagentTarget, EtdActivation, CidActivation, HcdActivation. Order of conditions changed. 1852 conditions.
## [2025-10-30 02:59:41] Recalculate median injection time based on: Mz, AgcTarget.
## [2025-10-30 02:59:41] Subsetted 368296 fragments [1216;5882] to 137461 fragments [304;5882].
```

```
# select just the 100. "c" fragment
myoglobin["c100"]
```

```
## TopDownSet object (2.89 Mb)
## - - - Protein data - - -
## Amino acid sequence (153): GLSDGEWQQVLNVWGKVEADIAGHGQ...GAMTKALELFRNDIAAKYKELGFQG
## Mass : 16922.95
## Modifications (1): Met-loss
## - - - Fragment data - - -
## Number of theoretical fragments: 1
## Theoretical fragment types (1): c
## Theoretical mass range: [11085.96;11085.96]
## - - - Condition data - - -
## Number of conditions: 1852
## Number of scans: 5882
## Condition variables (66): File, Scan, ..., Sample, MedianIonInjectionTimeMs
## - - - Intensity data - - -
## Size of array: 1x5882 (0.09% != 0)
## Number of matched fragments: 5
## Intensity range: [1276.91;17056.12]
## - - - Processing information - - -
## [2025-10-30 02:59:40] 368296 fragments [1216;5882] matched (tolerance: 5 ppm, strategies ion/fragment: remove/remove).
## [2025-10-30 02:59:40] Condition names updated based on: Mz, AgcTarget, EtdReagentTarget, EtdActivation, CidActivation, HcdActivation. Order of conditions changed. 1852 conditions.
## [2025-10-30 02:59:41] Recalculate median injection time based on: Mz, AgcTarget.
## [2025-10-30 02:59:41] Subsetted 368296 fragments [1216;5882] to 5 fragments [1;5882].
```

```
# select all "a" and "b" fragments but just the first 100 "c"
myoglobin[c("a", "b", paste0("c", 1:100))]
```

```
## TopDownSet object (4.59 Mb)
## - - - Protein data - - -
## Amino acid sequence (153): GLSDGEWQQVLNVWGKVEADIAGHGQ...GAMTKALELFRNDIAAKYKELGFQG
## Mass : 16922.95
## Modifications (1): Met-loss
## - - - Fragment data - - -
## Number of theoretical fragments: 404
## Theoretical fragment types (3): a, b, c
## Theoretical mass range: [30.03;16866.94]
## - - - Condition data - - -
## Number of conditions: 1852
## Number of scans: 5882
## Condition variables (66): File, Scan, ..., Sample, MedianIonInjectionTimeMs
## - - - Intensity data - - -
## Size of array: 404x5882 (6.04% != 0)
## Number of matched fragments: 143582
## Intensity range: [87.61;1630533.12]
## - - - Processing information - - -
## [2025-10-30 02:59:40] 368296 fragments [1216;5882] matched (tolerance: 5 ppm, strategies ion/fragment: remove/remove).
## [2025-10-30 02:59:40] Condition names updated based on: Mz, AgcTarget, EtdReagentTarget, EtdActivation, CidActivation, HcdActivation. Order of conditions changed. 1852 conditions.
## [2025-10-30 02:59:41] Recalculate median injection time based on: Mz, AgcTarget.
## [2025-10-30 02:59:41] Subsetted 368296 fragments [1216;5882] to 143582 fragments [404;5882].
```

```
# select condition/run 1 to 10
myoglobin[, 1:10]
```

```
## TopDownSet object (0.26 Mb)
## - - - Protein data - - -
## Amino acid sequence (153): GLSDGEWQQVLNVWGKVEADIAGHGQ...GAMTKALELFRNDIAAKYKELGFQG
## Mass : 16922.95
## Modifications (1): Met-loss
## - - - Fragment data - - -
## Number of theoretical fragments: 1216
## Theoretical fragment types (6): a, b, c, x, y, z
## Theoretical mass range: [30.03;16910.93]
## - - - Condition data - - -
## Number of conditions: 3
## Number of scans: 10
## Condition variables (66): File, Scan, ..., Sample, MedianIonInjectionTimeMs
## - - - Intensity data - - -
## Size of array: 1216x10 (8.38% != 0)
## Number of matched fragments: 1019
## Intensity range: [7872.05;1036892.19]
## - - - Processing information - - -
## [2025-10-30 02:59:40] 368296 fragments [1216;5882] matched (tolerance: 5 ppm, strategies ion/fragment: remove/remove).
## [2025-10-30 02:59:40] Condition names updated based on: Mz, AgcTarget, EtdReagentTarget, EtdActivation, CidActivation, HcdActivation. Order of conditions changed. 1852 conditions.
## [2025-10-30 02:59:41] Recalculate median injection time based on: Mz, AgcTarget.
## [2025-10-30 02:59:41] Subsetted 368296 fragments [1216;5882] to 1019 fragments [1216;10].
```

```
# select all conditions from one file
myoglobin[, myoglobin$File == "myo_1211_ETDReagentTarget_1e+06_1"]
```

```
## TopDownSet object (0.24 Mb)
## - - - Protein data - - -
## Amino acid sequence (153): GLSDGEWQQVLNVWGKVEADIAGHGQ...GAMTKALELFRNDIAAKYKELGFQG
## Mass : 16922.95
## Modifications (1): Met-loss
## - - - Fragment data - - -
## Number of theoretical fragments: 1216
## Theoretical fragment types (6): a, b, c, x, y, z
## Theoretical mass range: [30.03;16910.93]
## - - - Processing information - - -
## [2025-10-30 02:59:40] 368296 fragments [1216;5882] matched (tolerance: 5 ppm, strategies ion/fragment: remove/remove).
## [2025-10-30 02:59:40] Condition names updated based on: Mz, AgcTarget, EtdReagentTarget, EtdActivation, CidActivation, HcdActivation. Order of conditions changed. 1852 conditions.
## [2025-10-30 02:59:41] Recalculate median injection time based on: Mz, AgcTarget.
## [2025-10-30 02:59:41] Subsetted 368296 fragments [1216;5882] to 0 fragments [1216;0].
```

```
# select all "c" fragments from a single file
myoglobin["c", myoglobin$File == "myo_1211_ETDReagentTarget_1e+06_1"]
```

```
## TopDownSet object (0.11 Mb)
## - - - Protein data - - -
## Amino acid sequence (153): GLSDGEWQQVLNVWGKVEADIAGHGQ...GAMTKALELFRNDIAAKYKELGFQG
## Mass : 16922.95
## Modifications (1): Met-loss
## - - - Fragment data - - -
## Number of theoretical fragments: 304
## Theoretical fragment types (1): c
## Theoretical mass range: [74.05;16883.97]
## - - - Processing information - - -
## [2025-10-30 02:59:40] 368296 fragments [1216;5882] matched (tolerance: 5 ppm, strategies ion/fragment: remove/remove).
## [2025-10-30 02:59:40] Condition names updated based on: Mz, AgcTarget, EtdReagentTarget, EtdActivation, CidActivation, HcdActivation. Order of conditions changed. 1852 conditions.
## [2025-10-30 02:59:41] Recalculate median injection time based on: Mz, AgcTarget.
## [2025-10-30 02:59:41] Subsetted 368296 fragments [1216;5882] to 0 fragments [304;0].
```

## 1.5 Plotting a `TopDownSet`

Each condition represents one spectrum. We could plot a single condition
interactively or all spectra into a `pdf` file
(or any other *R* device that supports multiple pages/plots).

```
# plot a single condition
plot(myoglobin[, "C0707.30_1.0e+05_1.0e+06_10.00_00_28_3"])
```

```
## Warning: `aes_string()` was deprecated in ggplot2 3.0.0.
## ℹ Please use tidy evaluation idioms with `aes()`.
## ℹ See also `vignette("ggplot2-in-packages")` for more information.
## ℹ The deprecated feature was likely used in the topdownr package.
##   Please report the issue at <https://codeberg.org/sgibb/topdownr/issues/>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## [[1]]
```

```
## Warning: The `guide` argument in `scale_*()` cannot be `FALSE`. This was deprecated in
## ggplot2 3.3.4.
## ℹ Please use "none" instead.
## ℹ The deprecated feature was likely used in the topdownr package.
##   Please report the issue at <https://codeberg.org/sgibb/topdownr/issues/>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

![](data:image/png;base64...)

```
## # example to plot the first ten conditions into a pdf
## # (not evaluated in the vignette)
## pdf("topdown-conditions.pdf", paper="a4r", width=12)
## plot(myoglobin[, 1:10])
## dev.off()
```

`plot` returns a `list` (an item per condition) of `ggplot` objects which could
further modified or investigated interactively by calling `plotly::ggplotly()`.

# 2 Fragmentation Data Analysis of Myoglobin

We follow the following workflow:

![](data:image/png;base64...)

topdownr workflow

We use the example data loaded in
[Importing Files](analysis.html#21_importing_files).

The data contains several replicates for each fragmentation condition.
Before aggregation can be performed we need to remove scans with
inadequate injection times and fragments with low intensity or poor
intensity reproducibility.

## 2.1 Filter Conditions on Injection Times

Injection times should be consistent for a particular *m/z* and particular
AGC target. High or low injection times indicate problems with on-the-flight
AGC calculation or spray instability for a particular scan. Hence the
`topdownr` automatically calculates median injection time for a given *m/z*
and AGC target combination. The user can choose to remove all scans that
deviate more than a certain amount from the corresponding median and/or
choose to keep `N` scans with the lowest deviation from the median for
every condition.

Here we show an example of such filtering and the effect on the distribution of
injection times.

```
injTimeBefore <- colData(myoglobin)
injTimeBefore$Status <- "before filtering"

## filtering on max deviation and just keep the
## 2 technical replicates per condition with the
## lowest deviation
myoglobin <- filterInjectionTime(
    myoglobin,
    maxDeviation = log2(3),
    keepTopN = 2
)

myoglobin
```

```
## TopDownSet object (5.11 Mb)
## - - - Protein data - - -
## Amino acid sequence (153): GLSDGEWQQVLNVWGKVEADIAGHGQ...GAMTKALELFRNDIAAKYKELGFQG
## Mass : 16922.95
## Modifications (1): Met-loss
## - - - Fragment data - - -
## Number of theoretical fragments: 1216
## Theoretical fragment types (6): a, b, c, x, y, z
## Theoretical mass range: [30.03;16910.93]
## - - - Condition data - - -
## Number of conditions: 1852
## Number of scans: 3696
## Condition variables (66): File, Scan, ..., Sample, MedianIonInjectionTimeMs
## - - - Intensity data - - -
## Size of array: 1216x3696 (5.63% != 0)
## Number of matched fragments: 252897
## Intensity range: [109.29;8493567.00]
## - - - Processing information - - -
## [2025-10-30 02:59:40] 368296 fragments [1216;5882] matched (tolerance: 5 ppm, strategies ion/fragment: remove/remove).
## [2025-10-30 02:59:40] Condition names updated based on: Mz, AgcTarget, EtdReagentTarget, EtdActivation, CidActivation, HcdActivation. Order of conditions changed. 1852 conditions.
## [2025-10-30 02:59:41] Recalculate median injection time based on: Mz, AgcTarget.
## [2025-10-30 02:59:42] Subsetted 368296 fragments [1216;5882] to 252897 fragments [1216;3696].
## [2025-10-30 02:59:42] 2186 scans filtered with injection time deviation >= 1.58496250072116 or rank >= 3; 252897 fragments [1216;3696].
```

```
injTimeAfter <- colData(myoglobin)
injTimeAfter$Status <- "after filtering"

injTime <- as.data.frame(rbind(injTimeBefore, injTimeAfter))

## use ggplot for visualisation
library("ggplot2")

ggplot(injTime,
    aes(x = as.factor(AgcTarget),
        y = IonInjectionTimeMs,
        group = AgcTarget)) +
    geom_boxplot() +
    facet_grid(Status ~ Mz)
```

![](data:image/png;base64...)

## 2.2 Filter Fragments on CV

High CV of intensity for a fragment suggests either fragment contamination
by another *m/z* species or problems with deisotoping and we recommend
removing all fragments with CV > 30, as shown below.

```
myoglobin <- filterCv(myoglobin, threshold=30)
myoglobin
```

```
## TopDownSet object (4.68 Mb)
## - - - Protein data - - -
## Amino acid sequence (153): GLSDGEWQQVLNVWGKVEADIAGHGQ...GAMTKALELFRNDIAAKYKELGFQG
## Mass : 16922.95
## Modifications (1): Met-loss
## - - - Fragment data - - -
## Number of theoretical fragments: 1216
## Theoretical fragment types (6): a, b, c, x, y, z
## Theoretical mass range: [30.03;16910.93]
## - - - Condition data - - -
## Number of conditions: 1852
## Number of scans: 3696
## Condition variables (66): File, Scan, ..., Sample, MedianIonInjectionTimeMs
## - - - Intensity data - - -
## Size of array: 1216x3696 (4.80% != 0)
## Number of matched fragments: 215569
## Intensity range: [109.29;8493567.00]
## - - - Processing information - - -
## [2025-10-30 02:59:40] 368296 fragments [1216;5882] matched (tolerance: 5 ppm, strategies ion/fragment: remove/remove).
## [2025-10-30 02:59:40] Condition names updated based on: Mz, AgcTarget, EtdReagentTarget, EtdActivation, CidActivation, HcdActivation. Order of conditions changed. 1852 conditions.
## [2025-10-30 02:59:41] Recalculate median injection time based on: Mz, AgcTarget.
## [2025-10-30 02:59:42] Subsetted 368296 fragments [1216;5882] to 252897 fragments [1216;3696].
## [2025-10-30 02:59:42] 2186 scans filtered with injection time deviation >= 1.58496250072116 or rank >= 3; 252897 fragments [1216;3696].
## [2025-10-30 02:59:44] 37328 fragments with CV > 30% filtered; 215569 fragments [1216;3696].
```

## 2.3 Filter Fragments on Intensity

When optimizing protein fragmentation we also want to focus on the most
intense fragments, hence we recommend removing all low intensity fragments
from analysis.

Low intensity is defined relatively to the most intense observation for
this fragment (i.e. relatively to the maximum value in an `assayData` row).
In the example below all intensity values, which have less than 10%
intensity of the highest intensity to their corresponding fragment
(in their corresponding row) are removed.

```
myoglobin <- filterIntensity(myoglobin, threshold=0.1)
myoglobin
```

```
## TopDownSet object (3.82 Mb)
## - - - Protein data - - -
## Amino acid sequence (153): GLSDGEWQQVLNVWGKVEADIAGHGQ...GAMTKALELFRNDIAAKYKELGFQG
## Mass : 16922.95
## Modifications (1): Met-loss
## - - - Fragment data - - -
## Number of theoretical fragments: 1216
## Theoretical fragment types (6): a, b, c, x, y, z
## Theoretical mass range: [30.03;16910.93]
## - - - Condition data - - -
## Number of conditions: 1852
## Number of scans: 3696
## Condition variables (66): File, Scan, ..., Sample, MedianIonInjectionTimeMs
## - - - Intensity data - - -
## Size of array: 1216x3696 (3.13% != 0)
## Number of matched fragments: 140483
## Intensity range: [219.52;8493567.00]
## - - - Processing information - - -
## [2025-10-30 02:59:40] 368296 fragments [1216;5882] matched (tolerance: 5 ppm, strategies ion/fragment: remove/remove).
## [2025-10-30 02:59:40] Condition names updated based on: Mz, AgcTarget, EtdReagentTarget, EtdActivation, CidActivation, HcdActivation. Order of conditions changed. 1852 conditions.
## [2025-10-30 02:59:41] Recalculate median injection time based on: Mz, AgcTarget.
## [2025-10-30 02:59:42] Subsetted 368296 fragments [1216;5882] to 252897 fragments [1216;3696].
## [2025-10-30 02:59:42] 2186 scans filtered with injection time deviation >= 1.58496250072116 or rank >= 3; 252897 fragments [1216;3696].
## [2025-10-30 02:59:44] 37328 fragments with CV > 30% filtered; 215569 fragments [1216;3696].
## [2025-10-30 02:59:44] 75086 intensity values < 0.1 (relative) filtered; 140483 fragments [1216;3696].
```

## 2.4 Data Aggregation

The next step of analysis is aggregating technical replicates of fragmentation
conditions (columns of `assayData`).

```
myoglobin <- aggregate(myoglobin)
myoglobin
```

```
## TopDownSet object (2.25 Mb)
## - - - Protein data - - -
## Amino acid sequence (153): GLSDGEWQQVLNVWGKVEADIAGHGQ...GAMTKALELFRNDIAAKYKELGFQG
## Mass : 16922.95
## Modifications (1): Met-loss
## - - - Fragment data - - -
## Number of theoretical fragments: 1216
## Theoretical fragment types (6): a, b, c, x, y, z
## Theoretical mass range: [30.03;16910.93]
## - - - Condition data - - -
## Number of conditions: 1852
## Number of scans: 1852
## Condition variables (66): File, Scan, ..., Sample, MedianIonInjectionTimeMs
## - - - Intensity data - - -
## Size of array: 1216x1852 (3.96% != 0)
## Number of matched fragments: 89230
## Intensity range: [219.52;8492743.50]
## - - - Processing information - - -
## [2025-10-30 02:59:40] 368296 fragments [1216;5882] matched (tolerance: 5 ppm, strategies ion/fragment: remove/remove).
## [2025-10-30 02:59:40] Condition names updated based on: Mz, AgcTarget, EtdReagentTarget, EtdActivation, CidActivation, HcdActivation. Order of conditions changed. 1852 conditions.
## [2025-10-30 02:59:41] Recalculate median injection time based on: Mz, AgcTarget.
## [2025-10-30 02:59:42] Subsetted 368296 fragments [1216;5882] to 252897 fragments [1216;3696].
## [2025-10-30 02:59:42] 2186 scans filtered with injection time deviation >= 1.58496250072116 or rank >= 3; 252897 fragments [1216;3696].
## [2025-10-30 02:59:44] 37328 fragments with CV > 30% filtered; 215569 fragments [1216;3696].
## [2025-10-30 02:59:44] 75086 intensity values < 0.1 (relative) filtered; 140483 fragments [1216;3696].
## [2025-10-30 02:59:45] Aggregated 140483 fragments [1216;3696] to 89230 fragments [1216;1852].
```

## 2.5 Random Forest

To examine which of the features (fragmentation parameters) have the highest
overall impact for a protein we perform random forest machine learning using the
`ranger` (Wright and Ziegler [2017](#ref-ranger)) `R`-package.

Before we compute some fragmentation statistics
(number of assigned fragments, total assigned intensity, etc.).

```
library("ranger")

## statistics
head(summary(myoglobin))
```

```
##   Fragments    Total      Min       Q1   Median     Mean       Q3      Max
## 1       114 20287547 15477.93 50676.35 117379.4 16683.84 284206.6 889160.9
## 2       112 20647046  9950.82 52033.36 130829.6 16979.48 280873.9 880548.7
## 3       107 21156793  7872.05 51000.28 137816.3 17398.68 299479.5 945866.1
## 4       112 20148236 13521.25 50698.44 118552.1 16569.27 280191.6 874603.0
## 5       113 19598593 11322.55 53494.00 113005.6 16117.26 272462.7 882041.0
## 6       110 19913901 15506.45 65573.98 119684.7 16376.56 265715.7 950459.8
```

```
## number of fragments
nFragments <- summary(myoglobin)$Fragments

## features of interest
foi <- c(
    "AgcTarget",
    "EtdReagentTarget",
    "EtdActivation",
    "CidActivation",
    "HcdActivation",
    "Charge"
)

rfTable <- as.data.frame(colData(myoglobin)[foi])

## set NA to zero
rfTable[is.na(rfTable)] <- 0

rfTable <- as.data.frame(cbind(
    scale(rfTable),
    Fragments = nFragments
))

featureImportance <- ranger(
    Fragments ~ .,
    data = rfTable,
    importance = "impurity"
)$variable.importance

barplot(
    featureImportance/sum(featureImportance),
    cex.names = 0.7
)
```

![](data:image/png;base64...)

The two parameters having the lowest overall impact in the `myoglobin`
dataset across all conditions are ETD reagent target (`EtdReagentTarget`),
CID activation energy (`CidActivation`) and AGC target (`AgcTarget`),
while ETD reaction energy (`EtdActivation`) and HCD activation energy
(`HcdActivation`) demonstrate the highest overall impact.

## 2.6 Combining Fragmentation Conditions to Maximize Coverage

The purpose of `topdownr` is to investigate how maximum coverage with high
intensity fragments can be achieved with minimal instrument time.
Therefore `topdownr` reports the best combination of fragmentation conditions
(with user specified number of conditions) that covers the highest number of
different bonds.

Different fragmentation methods predominantly generate different types of
fragments (e.g. b and y for HCD and CID, c and z for ETD, a and x for UVPD).

However N-terminal (a, b and c) as well as C-terminal (x, y and z) fragments
originating from the same bond, cover the same number of amino acid sidechains.
Hence different types of N-terminal (a, b and c) or C-terminal (x, y and z)
fragments from the same bond add no extra sequence information.

Before we compute combinations all the fragments are converted to either
N- or C-terminal, as shown in the image below.

![](data:image/svg+xml;base64...)

Schema of N-/C-terminal fragments or bidirectional

In `topdownr` we convert the `TopDownSet` into an `NCBSet` object
(*N*-terminal/*C*-terminal/*B*idirectional).

```
myoglobinNcb <- as(myoglobin, "NCBSet")
myoglobinNcb
```

```
## NCBSet object (2.07 Mb)
## - - - Protein data - - -
## Amino acid sequence (153): GLSDGEWQQVLNVWGKVEADIAGHGQ...GAMTKALELFRNDIAAKYKELGFQG
## - - - Fragment data - - -
## Number of N-terminal fragments: 30592
## Number of C-terminal fragments: 29456
## Number of N- and C-terminal fragments: 9506
## - - - Condition data - - -
## Number of conditions: 1852
## Number of scans: 1852
## Condition variables (67): File, Scan, ..., MedianIonInjectionTimeMs, AssignedIntensity
## - - - Assay data - - -
## Size of array: 152x1852 (24.71% != 0)
## - - - Processing information - - -
## [2025-10-30 02:59:40] 368296 fragments [1216;5882] matched (tolerance: 5 ppm, strategies ion/fragment: remove/remove).
## [2025-10-30 02:59:40] Condition names updated based on: Mz, AgcTarget, EtdReagentTarget, EtdActivation, CidActivation, HcdActivation. Order of conditions changed. 1852 conditions.
## [2025-10-30 02:59:41] Recalculate median injection time based on: Mz, AgcTarget.
## [2025-10-30 02:59:42] Subsetted 368296 fragments [1216;5882] to 252897 fragments [1216;3696].
## [2025-10-30 02:59:42] 2186 scans filtered with injection time deviation >= 1.58496250072116 or rank >= 3; 252897 fragments [1216;3696].
## [2025-10-30 02:59:44] 37328 fragments with CV > 30% filtered; 215569 fragments [1216;3696].
## [2025-10-30 02:59:44] 75086 intensity values < 0.1 (relative) filtered; 140483 fragments [1216;3696].
## [2025-10-30 02:59:45] Aggregated 140483 fragments [1216;3696] to 89230 fragments [1216;1852].
## [2025-10-30 02:59:47] Coerced TopDownSet into an NCBSet object; 69554 fragments [152;1852].
```

An `NCBSet` is very similar to a `TopDownSet` but instead of an `FragmentViews`
the `rowViews` are an `XStringViews` for the former. Another difference is that
the `NCBSet` has one row per bond instead one row per fragment. Also the
`assayData` contains no intensity information but a `1` for an *N*-terminal, a
`2` for a *C*-terminal and a `3` for bidirectional fragments.

The `NCBSet` can be used to select the combination of conditions that provide
the best fragment coverage. While computing coverage `topdownr` awards 1 point
for every fragment going from every bond in either *N* or *C* directions.
This means that bonds covered in both directions increase the score of a
condition by 2 points.
For the myoglobin fragmentation example we get the following table for the best
three conditions:

```
bestConditions(myoglobinNcb, n=3)
```

```
##                                         Index FragmentsAddedToCombination
## C0893.10_1.0e+06_1.0e+06_05.00_14_00_1   1049                         143
## C1211.70_1.0e+05_0.0e+00_00.00_28_00_05  1431                          62
## C0707.30_5.0e+05_5.0e+06_02.50_07_00_1    275                          28
##                                         BondsAddedToCombination
## C0893.10_1.0e+06_1.0e+06_05.00_14_00_1                       98
## C1211.70_1.0e+05_0.0e+00_00.00_28_00_05                      36
## C0707.30_5.0e+05_5.0e+06_02.50_07_00_1                       10
##                                         FragmentsInCondition BondsInCondition
## C0893.10_1.0e+06_1.0e+06_05.00_14_00_1                   143               98
## C1211.70_1.0e+05_0.0e+00_00.00_28_00_05                  108               82
## C0707.30_5.0e+05_5.0e+06_02.50_07_00_1                   132               97
##                                         FragmentCoverage BondCoverage
## C0893.10_1.0e+06_1.0e+06_05.00_14_00_1         0.4703947    0.6447368
## C1211.70_1.0e+05_0.0e+00_00.00_28_00_05        0.6743421    0.8815789
## C0707.30_5.0e+05_5.0e+06_02.50_07_00_1         0.7664474    0.9473684
```

## 2.7 Building a Fragmentation Map

Fragmentation maps allow visualising the type of fragments produced by
fragmentation conditions and their overall distribution along the protein
backbone. It also illustrates how the combination of conditions results in
a cumulative increase in fragment coverage.
Shown below is a fragmentation map for myoglobin *m/z* 707.3, AGC target `1e6`
and ETD reagent target of `1e7` for ETD
(plotting more conditions is not practical for the vignette):

```
sel <-
    myoglobinNcb$Mz == 707.3 &
    myoglobinNcb$AgcTarget == 1e6 &
    (myoglobinNcb$EtdReagentTarget == 1e7 &
     !is.na(myoglobinNcb$EtdReagentTarget))

myoglobinNcbSub <- myoglobinNcb[, sel]

fragmentationMap(
    myoglobinNcbSub,
    nCombinations = 10,
    labels = seq_len(ncol(myoglobinNcbSub))
)
```

```
## Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
## ℹ Please use `linewidth` instead.
## ℹ The deprecated feature was likely used in the topdownr package.
##   Please report the issue at <https://codeberg.org/sgibb/topdownr/issues/>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## Warning: Raster pixels are placed at uneven horizontal intervals and will be shifted
## ℹ Consider using `geom_tile()` instead.
```

![](data:image/png;base64...)

# 3 Session Information

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
##  [1] ggplot2_4.0.0       ranger_0.17.0       topdownrdata_1.31.0
##  [4] topdownr_1.32.0     Biostrings_2.78.0   Seqinfo_1.0.0
##  [7] XVector_0.50.0      IRanges_2.44.0      S4Vectors_0.48.0
## [10] ProtGenerics_1.42.0 BiocGenerics_0.56.0 generics_0.1.4
## [13] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] rlang_1.1.6                 magrittr_2.0.4
##  [3] clue_0.3-66                 matrixStats_1.5.0
##  [5] compiler_4.5.1              vctrs_0.6.5
##  [7] reshape2_1.4.4              stringr_1.5.2
##  [9] pkgconfig_2.0.3             MetaboCoreUtils_1.18.0
## [11] crayon_1.5.3                fastmap_1.2.0
## [13] magick_2.9.0                labeling_0.4.3
## [15] rmarkdown_2.30              preprocessCore_1.72.0
## [17] tinytex_0.57                purrr_1.1.0
## [19] xfun_0.53                   MultiAssayExperiment_1.36.0
## [21] cachem_1.1.0                jsonlite_2.0.0
## [23] DelayedArray_0.36.0         BiocParallel_1.44.0
## [25] parallel_4.5.1              cluster_2.1.8.1
## [27] R6_2.6.1                    bslib_0.9.0
## [29] stringi_1.8.7               RColorBrewer_1.1-3
## [31] limma_3.66.0                GenomicRanges_1.62.0
## [33] jquerylib_0.1.4             Rcpp_1.1.0
## [35] bookdown_0.45               SummarizedExperiment_1.40.0
## [37] iterators_1.0.14            knitr_1.50
## [39] BiocBaseUtils_1.12.0        Matrix_1.7-4
## [41] igraph_2.2.1                tidyselect_1.2.1
## [43] dichromat_2.0-0.1           abind_1.4-8
## [45] yaml_2.3.10                 doParallel_1.0.17
## [47] codetools_0.2-20            affy_1.88.0
## [49] lattice_0.22-7              tibble_3.3.0
## [51] plyr_1.8.9                  Biobase_2.70.0
## [53] withr_3.0.2                 S7_0.2.0
## [55] evaluate_1.0.5              Spectra_1.20.0
## [57] pillar_1.11.1               affyio_1.80.0
## [59] BiocManager_1.30.26         MatrixGenerics_1.22.0
## [61] foreach_1.5.2               MSnbase_2.36.0
## [63] MALDIquant_1.22.3           ncdf4_1.24
## [65] scales_1.4.0                glue_1.8.0
## [67] lazyeval_0.2.2              tools_4.5.1
## [69] mzID_1.48.0                 QFeatures_1.20.0
## [71] vsn_3.78.0                  mzR_2.44.0
## [73] fs_1.6.6                    XML_3.99-0.19
## [75] grid_4.5.1                  impute_1.84.0
## [77] tidyr_1.3.1                 MsCoreUtils_1.22.0
## [79] PSMatch_1.14.0              cli_3.6.5
## [81] S4Arrays_1.10.0             dplyr_1.1.4
## [83] AnnotationFilter_1.34.0     pcaMethods_2.2.0
## [85] gtable_0.3.6                sass_0.4.10
## [87] digest_0.6.37               SparseArray_1.10.0
## [89] farver_2.1.2                htmltools_0.5.8.1
## [91] lifecycle_1.0.4             statmod_1.5.1
## [93] MASS_7.3-65
```

# References

Morgan, Martin, Valerie Obenchain, Jim Hester, and Hervé Pagès. 2017. *SummarizedExperiment: SummarizedExperiment Container*.

Wright, Marvin N., and Andreas Ziegler. 2017. “ranger: A Fast Implementation of Random Forests for High Dimensional Data in C++ and R.” *Journal of Statistical Software* 77 (1): 1–17. <https://doi.org/10.18637/jss.v077.i01>.