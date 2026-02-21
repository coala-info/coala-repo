Code

* Show All Code
* Hide All Code

# Example Usage

Jonathan Carroll\*

\*rpkg@jcarroll.com.au

#### 29 October 2025

#### Package

DFplyr 1.4.0

# 1 Basics

## 1.1 Install `DFplyr`

*[DFplyr](https://bioconductor.org/packages/3.22/DFplyr)* is a `R` package available via the
[Bioconductor](http://bioconductor.org) repository for packages and can be
downloaded via `BiocManager::install()`:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("DFplyr")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

## 1.2 Background

*[DFplyr](https://bioconductor.org/packages/3.22/DFplyr)* is inspired by *[dplyr](https://CRAN.R-project.org/package%3Ddplyr)* which implements a
wide variety of common data manipulations (`mutate`, `select`, `filter`) but
which only operates on objects of class `data.frame` or `tibble` (from `r CRANpkg("tibble")`).

When working with *[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)* `DataFrame`s - which are frequently
used as components of, for example *[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* objects -
a common workaround is to convert the `DataFrame` to a `tibble` in order to then
use *[dplyr](https://CRAN.R-project.org/package%3Ddplyr)* functions to manipulate the contents, before converting
back to a `DataFrame`.

This has several drawbacks, including the fact that `tibble` does not support
rownames (and *[dplyr](https://CRAN.R-project.org/package%3Ddplyr)* frequently does not preserve them), does not
support S4 columns (e.g. *[IRanges](https://bioconductor.org/packages/3.22/IRanges)* vectors), and requires the back
and forth transformation any time manipulation is desired.

# 2 Quick start to using `DFplyr`

```
library("DFplyr")
```

To being with, we create an *[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)* `DataFrame`, including some
S4 columns

```
library(S4Vectors)
m <- mtcars[, c("cyl", "hp", "am", "gear", "disp")]
d <- as(m, "DataFrame")
d$grX <- GenomicRanges::GRanges("chrX", IRanges::IRanges(1:32, width = 10))
d$grY <- GenomicRanges::GRanges("chrY", IRanges::IRanges(1:32, width = 10))
d$nl <- IRanges::NumericList(lapply(d$gear, function(n) round(rnorm(n), 2)))
d
#> DataFrame with 32 rows and 8 columns
#>                         cyl        hp        am      gear      disp        grX
#>                   <numeric> <numeric> <numeric> <numeric> <numeric>  <GRanges>
#> Mazda RX4                 6       110         1         4       160  chrX:1-10
#> Mazda RX4 Wag             6       110         1         4       160  chrX:2-11
#> Datsun 710                4        93         1         4       108  chrX:3-12
#> Hornet 4 Drive            6       110         0         3       258  chrX:4-13
#> Hornet Sportabout         8       175         0         3       360  chrX:5-14
#> ...                     ...       ...       ...       ...       ...        ...
#> Lotus Europa              4       113         1         5      95.1 chrX:28-37
#> Ford Pantera L            8       264         1         5     351.0 chrX:29-38
#> Ferrari Dino              6       175         1         5     145.0 chrX:30-39
#> Maserati Bora             8       335         1         5     301.0 chrX:31-40
#> Volvo 142E                4       109         1         4     121.0 chrX:32-41
#>                          grY                      nl
#>                    <GRanges> <CompressedNumericList>
#> Mazda RX4          chrY:1-10   -0.70,-0.08, 0.38,...
#> Mazda RX4 Wag      chrY:2-11    1.65, 0.18,-0.35,...
#> Datsun 710         chrY:3-12   -1.06,-0.85, 1.14,...
#> Hornet 4 Drive     chrY:4-13        0.05, 0.47,-1.03
#> Hornet Sportabout  chrY:5-14          0.05,0.04,0.74
#> ...                      ...                     ...
#> Lotus Europa      chrY:28-37      0.27,0.35,2.49,...
#> Ford Pantera L    chrY:29-38    0.93,-1.67,-0.75,...
#> Ferrari Dino      chrY:30-39   -0.65,-0.49, 0.71,...
#> Maserati Bora     chrY:31-40      0.71,1.22,2.60,...
#> Volvo 142E        chrY:32-41   -0.19, 0.70, 1.85,...
```

This will appear in RStudio’s environment pane as a

```
Formal class DataFrame (dplyr-compatible)
```

when using *[DFplyr](https://bioconductor.org/packages/3.22/DFplyr)*. No interference with the actual object is
required, but this helps identify that *[dplyr](https://CRAN.R-project.org/package%3Ddplyr)*-compatibility is
available.

`DataFrame`s can then be used in *[dplyr](https://CRAN.R-project.org/package%3Ddplyr)*-like calls the same as
`data.frame` or `tibble` objects. Support for working with S4 columns is enabled
provided they have appropriate functions. Adding multiple columns will result in
the new columns being created in alphabetical order. For example, adding a new
column `newvar` which is the sum of the `cyl` and `hp` columns

```
mutate(d, newvar = cyl + hp)
#> DataFrame with 32 rows and 9 columns
#>                         cyl        hp        am      gear      disp        grX
#>                   <numeric> <numeric> <numeric> <numeric> <numeric>  <GRanges>
#> Mazda RX4                 6       110         1         4       160  chrX:1-10
#> Mazda RX4 Wag             6       110         1         4       160  chrX:2-11
#> Datsun 710                4        93         1         4       108  chrX:3-12
#> Hornet 4 Drive            6       110         0         3       258  chrX:4-13
#> Hornet Sportabout         8       175         0         3       360  chrX:5-14
#> ...                     ...       ...       ...       ...       ...        ...
#> Lotus Europa              4       113         1         5      95.1 chrX:28-37
#> Ford Pantera L            8       264         1         5     351.0 chrX:29-38
#> Ferrari Dino              6       175         1         5     145.0 chrX:30-39
#> Maserati Bora             8       335         1         5     301.0 chrX:31-40
#> Volvo 142E                4       109         1         4     121.0 chrX:32-41
#>                          grY                      nl    newvar
#>                    <GRanges> <CompressedNumericList> <numeric>
#> Mazda RX4          chrY:1-10   -0.70,-0.08, 0.38,...       116
#> Mazda RX4 Wag      chrY:2-11    1.65, 0.18,-0.35,...       116
#> Datsun 710         chrY:3-12   -1.06,-0.85, 1.14,...        97
#> Hornet 4 Drive     chrY:4-13        0.05, 0.47,-1.03       116
#> Hornet Sportabout  chrY:5-14          0.05,0.04,0.74       183
#> ...                      ...                     ...       ...
#> Lotus Europa      chrY:28-37      0.27,0.35,2.49,...       117
#> Ford Pantera L    chrY:29-38    0.93,-1.67,-0.75,...       272
#> Ferrari Dino      chrY:30-39   -0.65,-0.49, 0.71,...       181
#> Maserati Bora     chrY:31-40      0.71,1.22,2.60,...       343
#> Volvo 142E        chrY:32-41   -0.19, 0.70, 1.85,...       113
```

or doubling the `nl` column as `nl2`

```
mutate(d, nl2 = nl * 2)
#> DataFrame with 32 rows and 9 columns
#>                         cyl        hp        am      gear      disp        grX
#>                   <numeric> <numeric> <numeric> <numeric> <numeric>  <GRanges>
#> Mazda RX4                 6       110         1         4       160  chrX:1-10
#> Mazda RX4 Wag             6       110         1         4       160  chrX:2-11
#> Datsun 710                4        93         1         4       108  chrX:3-12
#> Hornet 4 Drive            6       110         0         3       258  chrX:4-13
#> Hornet Sportabout         8       175         0         3       360  chrX:5-14
#> ...                     ...       ...       ...       ...       ...        ...
#> Lotus Europa              4       113         1         5      95.1 chrX:28-37
#> Ford Pantera L            8       264         1         5     351.0 chrX:29-38
#> Ferrari Dino              6       175         1         5     145.0 chrX:30-39
#> Maserati Bora             8       335         1         5     301.0 chrX:31-40
#> Volvo 142E                4       109         1         4     121.0 chrX:32-41
#>                          grY                      nl                     nl2
#>                    <GRanges> <CompressedNumericList> <CompressedNumericList>
#> Mazda RX4          chrY:1-10   -0.70,-0.08, 0.38,...   -1.40,-0.16, 0.76,...
#> Mazda RX4 Wag      chrY:2-11    1.65, 0.18,-0.35,...    3.30, 0.36,-0.70,...
#> Datsun 710         chrY:3-12   -1.06,-0.85, 1.14,...   -2.12,-1.70, 2.28,...
#> Hornet 4 Drive     chrY:4-13        0.05, 0.47,-1.03        0.10, 0.94,-2.06
#> Hornet Sportabout  chrY:5-14          0.05,0.04,0.74          0.10,0.08,1.48
#> ...                      ...                     ...                     ...
#> Lotus Europa      chrY:28-37      0.27,0.35,2.49,...      0.54,0.70,4.98,...
#> Ford Pantera L    chrY:29-38    0.93,-1.67,-0.75,...    1.86,-3.34,-1.50,...
#> Ferrari Dino      chrY:30-39   -0.65,-0.49, 0.71,...   -1.30,-0.98, 1.42,...
#> Maserati Bora     chrY:31-40      0.71,1.22,2.60,...      1.42,2.44,5.20,...
#> Volvo 142E        chrY:32-41   -0.19, 0.70, 1.85,...   -0.38, 1.40, 3.70,...
```

or calculating the `length()` of the `nl` column cells as `length_nl`

```
mutate(d, length_nl = lengths(nl))
#> DataFrame with 32 rows and 9 columns
#>                         cyl        hp        am      gear      disp        grX
#>                   <numeric> <numeric> <numeric> <numeric> <numeric>  <GRanges>
#> Mazda RX4                 6       110         1         4       160  chrX:1-10
#> Mazda RX4 Wag             6       110         1         4       160  chrX:2-11
#> Datsun 710                4        93         1         4       108  chrX:3-12
#> Hornet 4 Drive            6       110         0         3       258  chrX:4-13
#> Hornet Sportabout         8       175         0         3       360  chrX:5-14
#> ...                     ...       ...       ...       ...       ...        ...
#> Lotus Europa              4       113         1         5      95.1 chrX:28-37
#> Ford Pantera L            8       264         1         5     351.0 chrX:29-38
#> Ferrari Dino              6       175         1         5     145.0 chrX:30-39
#> Maserati Bora             8       335         1         5     301.0 chrX:31-40
#> Volvo 142E                4       109         1         4     121.0 chrX:32-41
#>                          grY                      nl length_nl
#>                    <GRanges> <CompressedNumericList> <integer>
#> Mazda RX4          chrY:1-10   -0.70,-0.08, 0.38,...         4
#> Mazda RX4 Wag      chrY:2-11    1.65, 0.18,-0.35,...         4
#> Datsun 710         chrY:3-12   -1.06,-0.85, 1.14,...         4
#> Hornet 4 Drive     chrY:4-13        0.05, 0.47,-1.03         3
#> Hornet Sportabout  chrY:5-14          0.05,0.04,0.74         3
#> ...                      ...                     ...       ...
#> Lotus Europa      chrY:28-37      0.27,0.35,2.49,...         5
#> Ford Pantera L    chrY:29-38    0.93,-1.67,-0.75,...         5
#> Ferrari Dino      chrY:30-39   -0.65,-0.49, 0.71,...         5
#> Maserati Bora     chrY:31-40      0.71,1.22,2.60,...         5
#> Volvo 142E        chrY:32-41   -0.19, 0.70, 1.85,...         4
```

Transformations can involve S4-related functions, such as extracting the
`seqnames()`, `strand()`, and `end()` of the `grX` column

```
mutate(d,
    chr = GenomeInfoDb::seqnames(grX),
    strand_X = BiocGenerics::strand(grX),
    end_X = BiocGenerics::end(grX)
)
#> DataFrame with 32 rows and 11 columns
#>                         cyl        hp        am      gear      disp        grX
#>                   <numeric> <numeric> <numeric> <numeric> <numeric>  <GRanges>
#> Mazda RX4                 6       110         1         4       160  chrX:1-10
#> Mazda RX4 Wag             6       110         1         4       160  chrX:2-11
#> Datsun 710                4        93         1         4       108  chrX:3-12
#> Hornet 4 Drive            6       110         0         3       258  chrX:4-13
#> Hornet Sportabout         8       175         0         3       360  chrX:5-14
#> ...                     ...       ...       ...       ...       ...        ...
#> Lotus Europa              4       113         1         5      95.1 chrX:28-37
#> Ford Pantera L            8       264         1         5     351.0 chrX:29-38
#> Ferrari Dino              6       175         1         5     145.0 chrX:30-39
#> Maserati Bora             8       335         1         5     301.0 chrX:31-40
#> Volvo 142E                4       109         1         4     121.0 chrX:32-41
#>                          grY                      nl   chr     end_X strand_X
#>                    <GRanges> <CompressedNumericList> <Rle> <integer>    <Rle>
#> Mazda RX4          chrY:1-10   -0.70,-0.08, 0.38,...  chrX        10        *
#> Mazda RX4 Wag      chrY:2-11    1.65, 0.18,-0.35,...  chrX        11        *
#> Datsun 710         chrY:3-12   -1.06,-0.85, 1.14,...  chrX        12        *
#> Hornet 4 Drive     chrY:4-13        0.05, 0.47,-1.03  chrX        13        *
#> Hornet Sportabout  chrY:5-14          0.05,0.04,0.74  chrX        14        *
#> ...                      ...                     ...   ...       ...      ...
#> Lotus Europa      chrY:28-37      0.27,0.35,2.49,...  chrX        37        *
#> Ford Pantera L    chrY:29-38    0.93,-1.67,-0.75,...  chrX        38        *
#> Ferrari Dino      chrY:30-39   -0.65,-0.49, 0.71,...  chrX        39        *
#> Maserati Bora     chrY:31-40      0.71,1.22,2.60,...  chrX        40        *
#> Volvo 142E        chrY:32-41   -0.19, 0.70, 1.85,...  chrX        41        *
```

the object returned remains a standard `DataFrame`, and further calls can be
piped with `%>%`, in this case extracting the newly created `newvar` column

```
mutate(d, newvar = cyl + hp) %>%
    pull(newvar)
#>  [1] 116 116  97 116 183 111 253  66  99 129 129 188 188 188 213 223 238  70  56
#> [20]  69 101 158 158 253 183  70  95 117 272 181 343 113
```

Some of the variants of the `dplyr` verbs also work, such as transforming the
numeric columns using a quosure style lambda function, in this case squaring
them

```
mutate_if(d, is.numeric, ~ .^2)
#> DataFrame with 32 rows and 8 columns
#>                         cyl        hp        am      gear      disp        grX
#>                   <numeric> <numeric> <numeric> <numeric> <numeric>  <GRanges>
#> Mazda RX4                36     12100         1        16     25600  chrX:1-10
#> Mazda RX4 Wag            36     12100         1        16     25600  chrX:2-11
#> Datsun 710               16      8649         1        16     11664  chrX:3-12
#> Hornet 4 Drive           36     12100         0         9     66564  chrX:4-13
#> Hornet Sportabout        64     30625         0         9    129600  chrX:5-14
#> ...                     ...       ...       ...       ...       ...        ...
#> Lotus Europa             16     12769         1        25   9044.01 chrX:28-37
#> Ford Pantera L           64     69696         1        25 123201.00 chrX:29-38
#> Ferrari Dino             36     30625         1        25  21025.00 chrX:30-39
#> Maserati Bora            64    112225         1        25  90601.00 chrX:31-40
#> Volvo 142E               16     11881         1        16  14641.00 chrX:32-41
#>                          grY                      nl
#>                    <GRanges> <CompressedNumericList>
#> Mazda RX4          chrY:1-10   -0.70,-0.08, 0.38,...
#> Mazda RX4 Wag      chrY:2-11    1.65, 0.18,-0.35,...
#> Datsun 710         chrY:3-12   -1.06,-0.85, 1.14,...
#> Hornet 4 Drive     chrY:4-13        0.05, 0.47,-1.03
#> Hornet Sportabout  chrY:5-14          0.05,0.04,0.74
#> ...                      ...                     ...
#> Lotus Europa      chrY:28-37      0.27,0.35,2.49,...
#> Ford Pantera L    chrY:29-38    0.93,-1.67,-0.75,...
#> Ferrari Dino      chrY:30-39   -0.65,-0.49, 0.71,...
#> Maserati Bora     chrY:31-40      0.71,1.22,2.60,...
#> Volvo 142E        chrY:32-41   -0.19, 0.70, 1.85,...
```

or extracting the `start` of all of the `"GRanges"` columns

```
mutate_if(d, ~ isa(., "GRanges"), BiocGenerics::start)
#> DataFrame with 32 rows and 8 columns
#>                         cyl        hp        am      gear      disp       grX
#>                   <numeric> <numeric> <numeric> <numeric> <numeric> <integer>
#> Mazda RX4                 6       110         1         4       160         1
#> Mazda RX4 Wag             6       110         1         4       160         2
#> Datsun 710                4        93         1         4       108         3
#> Hornet 4 Drive            6       110         0         3       258         4
#> Hornet Sportabout         8       175         0         3       360         5
#> ...                     ...       ...       ...       ...       ...       ...
#> Lotus Europa              4       113         1         5      95.1        28
#> Ford Pantera L            8       264         1         5     351.0        29
#> Ferrari Dino              6       175         1         5     145.0        30
#> Maserati Bora             8       335         1         5     301.0        31
#> Volvo 142E                4       109         1         4     121.0        32
#>                         grY                      nl
#>                   <integer> <CompressedNumericList>
#> Mazda RX4                 1   -0.70,-0.08, 0.38,...
#> Mazda RX4 Wag             2    1.65, 0.18,-0.35,...
#> Datsun 710                3   -1.06,-0.85, 1.14,...
#> Hornet 4 Drive            4        0.05, 0.47,-1.03
#> Hornet Sportabout         5          0.05,0.04,0.74
#> ...                     ...                     ...
#> Lotus Europa             28      0.27,0.35,2.49,...
#> Ford Pantera L           29    0.93,-1.67,-0.75,...
#> Ferrari Dino             30   -0.65,-0.49, 0.71,...
#> Maserati Bora            31      0.71,1.22,2.60,...
#> Volvo 142E               32   -0.19, 0.70, 1.85,...
```

Use of *[tidyselect](https://CRAN.R-project.org/package%3Dtidyselect)* helpers is limited to within `vars()`
calls and using the `_at` variants

```
mutate_at(d, vars(starts_with("c")), ~ .^2)
#> DataFrame with 32 rows and 8 columns
#>                         cyl        hp        am      gear      disp        grX
#>                   <numeric> <numeric> <numeric> <numeric> <numeric>  <GRanges>
#> Mazda RX4                36       110         1         4       160  chrX:1-10
#> Mazda RX4 Wag            36       110         1         4       160  chrX:2-11
#> Datsun 710               16        93         1         4       108  chrX:3-12
#> Hornet 4 Drive           36       110         0         3       258  chrX:4-13
#> Hornet Sportabout        64       175         0         3       360  chrX:5-14
#> ...                     ...       ...       ...       ...       ...        ...
#> Lotus Europa             16       113         1         5      95.1 chrX:28-37
#> Ford Pantera L           64       264         1         5     351.0 chrX:29-38
#> Ferrari Dino             36       175         1         5     145.0 chrX:30-39
#> Maserati Bora            64       335         1         5     301.0 chrX:31-40
#> Volvo 142E               16       109         1         4     121.0 chrX:32-41
#>                          grY                      nl
#>                    <GRanges> <CompressedNumericList>
#> Mazda RX4          chrY:1-10   -0.70,-0.08, 0.38,...
#> Mazda RX4 Wag      chrY:2-11    1.65, 0.18,-0.35,...
#> Datsun 710         chrY:3-12   -1.06,-0.85, 1.14,...
#> Hornet 4 Drive     chrY:4-13        0.05, 0.47,-1.03
#> Hornet Sportabout  chrY:5-14          0.05,0.04,0.74
#> ...                      ...                     ...
#> Lotus Europa      chrY:28-37      0.27,0.35,2.49,...
#> Ford Pantera L    chrY:29-38    0.93,-1.67,-0.75,...
#> Ferrari Dino      chrY:30-39   -0.65,-0.49, 0.71,...
#> Maserati Bora     chrY:31-40      0.71,1.22,2.60,...
#> Volvo 142E        chrY:32-41   -0.19, 0.70, 1.85,...
```

and also works with other verbs

```
select_at(d, vars(starts_with("gr")))
#> DataFrame with 32 rows and 2 columns
#>                          grX        grY
#>                    <GRanges>  <GRanges>
#> Mazda RX4          chrX:1-10  chrY:1-10
#> Mazda RX4 Wag      chrX:2-11  chrY:2-11
#> Datsun 710         chrX:3-12  chrY:3-12
#> Hornet 4 Drive     chrX:4-13  chrY:4-13
#> Hornet Sportabout  chrX:5-14  chrY:5-14
#> ...                      ...        ...
#> Lotus Europa      chrX:28-37 chrY:28-37
#> Ford Pantera L    chrX:29-38 chrY:29-38
#> Ferrari Dino      chrX:30-39 chrY:30-39
#> Maserati Bora     chrX:31-40 chrY:31-40
#> Volvo 142E        chrX:32-41 chrY:32-41
```

Importantly, grouped operations are supported. `DataFrame` does not
natively support groups (the same way that `data.frame` does not) so these
are implemented specifically for `DFplyr` with group information shown at the
top of the printed output

```
group_by(d, cyl, am)
#> DataFrame with 32 rows and 8 columns
#> Groups:  cyl, am
#>                         cyl        hp        am      gear      disp        grX
#>                   <numeric> <numeric> <numeric> <numeric> <numeric>  <GRanges>
#> Mazda RX4                 6       110         1         4       160  chrX:1-10
#> Mazda RX4 Wag             6       110         1         4       160  chrX:2-11
#> Datsun 710                4        93         1         4       108  chrX:3-12
#> Hornet 4 Drive            6       110         0         3       258  chrX:4-13
#> Hornet Sportabout         8       175         0         3       360  chrX:5-14
#> ...                     ...       ...       ...       ...       ...        ...
#> Lotus Europa              4       113         1         5      95.1 chrX:28-37
#> Ford Pantera L            8       264         1         5     351.0 chrX:29-38
#> Ferrari Dino              6       175         1         5     145.0 chrX:30-39
#> Maserati Bora             8       335         1         5     301.0 chrX:31-40
#> Volvo 142E                4       109         1         4     121.0 chrX:32-41
#>                          grY                      nl
#>                    <GRanges> <CompressedNumericList>
#> Mazda RX4          chrY:1-10   -0.70,-0.08, 0.38,...
#> Mazda RX4 Wag      chrY:2-11    1.65, 0.18,-0.35,...
#> Datsun 710         chrY:3-12   -1.06,-0.85, 1.14,...
#> Hornet 4 Drive     chrY:4-13        0.05, 0.47,-1.03
#> Hornet Sportabout  chrY:5-14          0.05,0.04,0.74
#> ...                      ...                     ...
#> Lotus Europa      chrY:28-37      0.27,0.35,2.49,...
#> Ford Pantera L    chrY:29-38    0.93,-1.67,-0.75,...
#> Ferrari Dino      chrY:30-39   -0.65,-0.49, 0.71,...
#> Maserati Bora     chrY:31-40      0.71,1.22,2.60,...
#> Volvo 142E        chrY:32-41   -0.19, 0.70, 1.85,...
```

Other verbs are similarly implemented, and preserve row names where possible.
For example, selecting a limited set of columns using non-standard evaluation
(NSE)

```
select(d, am, cyl)
#> DataFrame with 32 rows and 2 columns
#>                          am       cyl
#>                   <numeric> <numeric>
#> Mazda RX4                 1         6
#> Mazda RX4 Wag             1         6
#> Datsun 710                1         4
#> Hornet 4 Drive            0         6
#> Hornet Sportabout         0         8
#> ...                     ...       ...
#> Lotus Europa              1         4
#> Ford Pantera L            1         8
#> Ferrari Dino              1         6
#> Maserati Bora             1         8
#> Volvo 142E                1         4
```

Arranging rows according to the ordering of a column

```
arrange(d, desc(hp))
#> DataFrame with 32 rows and 8 columns
#>                         cyl        hp        am      gear      disp        grX
#>                   <numeric> <numeric> <numeric> <numeric> <numeric>  <GRanges>
#> Maserati Bora             8       335         1         5       301 chrX:31-40
#> Ford Pantera L            8       264         1         5       351 chrX:29-38
#> Duster 360                8       245         0         3       360  chrX:7-16
#> Camaro Z28                8       245         0         3       350 chrX:24-33
#> Chrysler Imperial         8       230         0         3       440 chrX:17-26
#> ...                     ...       ...       ...       ...       ...        ...
#> Fiat 128                  4        66         1         4      78.7 chrX:18-27
#> Fiat X1-9                 4        66         1         4      79.0 chrX:26-35
#> Toyota Corolla            4        65         1         4      71.1 chrX:20-29
#> Merc 240D                 4        62         0         4     146.7  chrX:8-17
#> Honda Civic               4        52         1         4      75.7 chrX:19-28
#>                          grY                      nl
#>                    <GRanges> <CompressedNumericList>
#> Maserati Bora     chrY:31-40      0.71,1.22,2.60,...
#> Ford Pantera L    chrY:29-38    0.93,-1.67,-0.75,...
#> Duster 360         chrY:7-16       -0.04, 0.20,-0.81
#> Camaro Z28        chrY:24-33       -1.65, 0.87, 0.73
#> Chrysler Imperial chrY:17-26       -0.08,-0.28,-0.03
#> ...                      ...                     ...
#> Fiat 128          chrY:18-27   -1.67, 1.99, 1.15,...
#> Fiat X1-9         chrY:26-35    0.14, 0.69,-2.68,...
#> Toyota Corolla    chrY:20-29   -1.62, 0.30, 1.14,...
#> Merc 240D          chrY:8-17   -0.82, 0.06, 0.40,...
#> Honda Civic       chrY:19-28      0.97,2.11,1.58,...
```

Filtering to only specific values appearing in a column

```
filter(d, am == 0)
#> DataFrame with 19 rows and 8 columns
#>                         cyl        hp        am      gear      disp        grX
#>                   <numeric> <numeric> <numeric> <numeric> <numeric>  <GRanges>
#> Hornet 4 Drive            6       110         0         3     258.0  chrX:4-13
#> Hornet Sportabout         8       175         0         3     360.0  chrX:5-14
#> Valiant                   6       105         0         3     225.0  chrX:6-15
#> Duster 360                8       245         0         3     360.0  chrX:7-16
#> Merc 240D                 4        62         0         4     146.7  chrX:8-17
#> ...                     ...       ...       ...       ...       ...        ...
#> Toyota Corona             4        97         0         3     120.1 chrX:21-30
#> Dodge Challenger          8       150         0         3     318.0 chrX:22-31
#> AMC Javelin               8       150         0         3     304.0 chrX:23-32
#> Camaro Z28                8       245         0         3     350.0 chrX:24-33
#> Pontiac Firebird          8       175         0         3     400.0 chrX:25-34
#>                          grY                      nl
#>                    <GRanges> <CompressedNumericList>
#> Hornet 4 Drive     chrY:4-13        0.05, 0.47,-1.03
#> Hornet Sportabout  chrY:5-14          0.05,0.04,0.74
#> Valiant            chrY:6-15       -1.05, 0.85, 0.62
#> Duster 360         chrY:7-16       -0.04, 0.20,-0.81
#> Merc 240D          chrY:8-17   -0.82, 0.06, 0.40,...
#> ...                      ...                     ...
#> Toyota Corona     chrY:21-30        0.73,-0.09, 0.33
#> Dodge Challenger  chrY:22-31        0.01, 1.91,-0.82
#> AMC Javelin       chrY:23-32        1.11, 0.02,-0.93
#> Camaro Z28        chrY:24-33       -1.65, 0.87, 0.73
#> Pontiac Firebird  chrY:25-34        1.46,-0.42,-0.01
```

Selecting specific rows by index

```
slice(d, 3:6)
#> DataFrame with 4 rows and 8 columns
#>                         cyl        hp        am      gear      disp       grX
#>                   <numeric> <numeric> <numeric> <numeric> <numeric> <GRanges>
#> Datsun 710                4        93         1         4       108 chrX:3-12
#> Hornet 4 Drive            6       110         0         3       258 chrX:4-13
#> Hornet Sportabout         8       175         0         3       360 chrX:5-14
#> Valiant                   6       105         0         3       225 chrX:6-15
#>                         grY                      nl
#>                   <GRanges> <CompressedNumericList>
#> Datsun 710        chrY:3-12   -1.06,-0.85, 1.14,...
#> Hornet 4 Drive    chrY:4-13        0.05, 0.47,-1.03
#> Hornet Sportabout chrY:5-14          0.05,0.04,0.74
#> Valiant           chrY:6-15       -1.05, 0.85, 0.62
```

These also work for grouped objects, and also preserve the rownames, e.g.
selecting the first two rows from *each group* of `gear`

```
group_by(d, gear) %>%
    slice(1:2)
#> DataFrame with 6 rows and 8 columns
#>                         cyl        hp        am      gear      disp        grX
#>                   <numeric> <numeric> <numeric> <numeric> <numeric>  <GRanges>
#> Hornet Sportabout         8       175         0         3     360.0  chrX:5-14
#> Merc 450SL                8       180         0         3     275.8 chrX:13-22
#> Mazda RX4                 6       110         1         4     160.0  chrX:1-10
#> Mazda RX4 Wag             6       110         1         4     160.0  chrX:2-11
#> Porsche 914-2             4        91         1         5     120.3 chrX:27-36
#> Ford Pantera L            8       264         1         5     351.0 chrX:29-38
#>                          grY                      nl
#>                    <GRanges> <CompressedNumericList>
#> Hornet Sportabout  chrY:5-14          0.05,0.04,0.74
#> Merc 450SL        chrY:13-22        2.05,-0.66,-0.44
#> Mazda RX4          chrY:1-10   -0.70,-0.08, 0.38,...
#> Mazda RX4 Wag      chrY:2-11    1.65, 0.18,-0.35,...
#> Porsche 914-2     chrY:27-36   -1.95,-0.98,-0.42,...
#> Ford Pantera L    chrY:29-38    0.93,-1.67,-0.75,...
```

`rename` is itself renamed to `rename2` due to conflicts between
*[dplyr](https://CRAN.R-project.org/package%3Ddplyr)* and *[S4Vectors](https://bioconductor.org/packages/3.22/S4Vectors)*, but works in the
*[dplyr](https://CRAN.R-project.org/package%3Ddplyr)* sense of taking `new = old` replacements with NSE syntax

```
select(d, am, cyl) %>%
    rename2(foo = am)
#> Warning in rename2(., foo = am): DFplyr now properly supports rename with NSE
#> syntax
```

Row names are not preserved when there may be duplicates or they don’t make
sense, otherwise the first label (according to the current de-duplication
method, in the case of `distinct`, this is via `BiocGenerics::duplicated`). This
may have complications for S4 columns.

```
distinct(d)
#> DataFrame with 32 rows and 8 columns
#>                         cyl        hp        am      gear      disp        grX
#>                   <numeric> <numeric> <numeric> <numeric> <numeric>  <GRanges>
#> Mazda RX4                 6       110         1         4       160  chrX:1-10
#> Mazda RX4 Wag             6       110         1         4       160  chrX:2-11
#> Datsun 710                4        93         1         4       108  chrX:3-12
#> Hornet 4 Drive            6       110         0         3       258  chrX:4-13
#> Hornet Sportabout         8       175         0         3       360  chrX:5-14
#> ...                     ...       ...       ...       ...       ...        ...
#> Lotus Europa              4       113         1         5      95.1 chrX:28-37
#> Ford Pantera L            8       264         1         5     351.0 chrX:29-38
#> Ferrari Dino              6       175         1         5     145.0 chrX:30-39
#> Maserati Bora             8       335         1         5     301.0 chrX:31-40
#> Volvo 142E                4       109         1         4     121.0 chrX:32-41
#>                          grY                      nl
#>                    <GRanges> <CompressedNumericList>
#> Mazda RX4          chrY:1-10   -0.70,-0.08, 0.38,...
#> Mazda RX4 Wag      chrY:2-11    1.65, 0.18,-0.35,...
#> Datsun 710         chrY:3-12   -1.06,-0.85, 1.14,...
#> Hornet 4 Drive     chrY:4-13        0.05, 0.47,-1.03
#> Hornet Sportabout  chrY:5-14          0.05,0.04,0.74
#> ...                      ...                     ...
#> Lotus Europa      chrY:28-37      0.27,0.35,2.49,...
#> Ford Pantera L    chrY:29-38    0.93,-1.67,-0.75,...
#> Ferrari Dino      chrY:30-39   -0.65,-0.49, 0.71,...
#> Maserati Bora     chrY:31-40      0.71,1.22,2.60,...
#> Volvo 142E        chrY:32-41   -0.19, 0.70, 1.85,...
```

Behaviours are ideally the same as those of *[dplyr](https://CRAN.R-project.org/package%3Ddplyr)* wherever
possible, for example a grouped tally

```
group_by(d, cyl, am) %>%
    tally(gear)
#> DataFrame with 6 rows and 3 columns
#>         cyl        am         n
#>   <numeric> <numeric> <numeric>
#> 1         4         0        11
#> 2         4         1        34
#> 3         6         0        14
#> 4         6         1        13
#> 5         8         0        36
#> 6         8         1        10
```

or a count with weights

```
count(d, gear, am, cyl)
#> DataFrame with 10 rows and 4 columns
#>        gear    am   cyl         n
#>    <factor> <Rle> <Rle> <integer>
#> 1         3     0     4         1
#> 2         3     0     6         2
#> 3         3     0     8        12
#> 4         4     0     4         2
#> 5         4     0     6         2
#> 6         4     1     4         6
#> 7         4     1     6         2
#> 8         5     1     4         2
#> 9         5     1     6         1
#> 10        5     1     8         2
```

Joins attempt to preserve rownames and grouping wherever possible

```
Da <- as(starwars[, c("name", "eye_color", "height", "mass")], "DataFrame") |>
    head(10) |>
    group_by(eye_color)
Da
#> DataFrame with 10 rows and 4 columns
#> Groups:  eye_color
#>                  name   eye_color    height      mass
#>           <character> <character> <integer> <numeric>
#> 1      Luke Skywalker        blue       172        77
#> 2               C-3PO      yellow       167        75
#> 3               R2-D2         red        96        32
#> 4         Darth Vader      yellow       202       136
#> 5         Leia Organa       brown       150        49
#> 6           Owen Lars        blue       178       120
#> 7  Beru Whitesun Lars        blue       165        75
#> 8               R5-D4         red        97        32
#> 9   Biggs Darklighter       brown       183        84
#> 10     Obi-Wan Kenobi   blue-gray       182        77

Db <- as(starwars[, c("name", "eye_color", "homeworld")], "DataFrame")
Db
#> DataFrame with 87 rows and 3 columns
#>               name   eye_color   homeworld
#>        <character> <character> <character>
#> 1   Luke Skywalker        blue    Tatooine
#> 2            C-3PO      yellow    Tatooine
#> 3            R2-D2         red       Naboo
#> 4      Darth Vader      yellow    Tatooine
#> 5      Leia Organa       brown    Alderaan
#> ...            ...         ...         ...
#> 83            Finn        dark          NA
#> 84             Rey       hazel          NA
#> 85     Poe Dameron       brown          NA
#> 86             BB8       black          NA
#> 87  Captain Phasma     unknown          NA

left_join(Da, Db)
#> Joining with `by = c("name", "eye_color")`
#> DataFrame with 10 rows and 5 columns
#> Groups:  eye_color
#>                  name   eye_color    height      mass   homeworld
#>           <character> <character> <integer> <numeric> <character>
#> 1      Luke Skywalker        blue       172        77    Tatooine
#> 2               C-3PO      yellow       167        75    Tatooine
#> 3               R2-D2         red        96        32       Naboo
#> 4         Darth Vader      yellow       202       136    Tatooine
#> 5         Leia Organa       brown       150        49    Alderaan
#> 6           Owen Lars        blue       178       120    Tatooine
#> 7  Beru Whitesun Lars        blue       165        75    Tatooine
#> 8               R5-D4         red        97        32    Tatooine
#> 9   Biggs Darklighter       brown       183        84    Tatooine
#> 10     Obi-Wan Kenobi   blue-gray       182        77     Stewjon

right_join(Da, Db)
#> Joining with `by = c("name", "eye_color")`
#> DataFrame with 87 rows and 5 columns
#> Groups:  eye_color
#>               name     eye_color    height      mass   homeworld
#>        <character>   <character> <integer> <numeric> <character>
#> 1   Luke Skywalker          blue       172        77    Tatooine
#> 2            C-3PO        yellow       167        75    Tatooine
#> 3            R2-D2           red        96        32       Naboo
#> 4      Darth Vader        yellow       202       136    Tatooine
#> 5      Leia Organa         brown       150        49    Alderaan
#> ...            ...           ...       ...       ...         ...
#> 83             BB8         black        NA        NA          NA
#> 84  Captain Phasma       unknown        NA        NA          NA
#> 85        San Hill          gold        NA        NA  Muunilinst
#> 86        Shaak Ti         black        NA        NA       Shili
#> 87        Grievous green, yellow        NA        NA       Kalee

inner_join(Da, Db[1:3, ])
#> Joining with `by = c("name", "eye_color")`
#> DataFrame with 3 rows and 5 columns
#> Groups:  eye_color
#>             name   eye_color    height      mass   homeworld
#>      <character> <character> <integer> <numeric> <character>
#> 1 Luke Skywalker        blue       172        77    Tatooine
#> 2          C-3PO      yellow       167        75    Tatooine
#> 3          R2-D2         red        96        32       Naboo

full_join(Da, Db[1:3, ])
#> Joining with `by = c("name", "eye_color")`
#> DataFrame with 10 rows and 5 columns
#> Groups:  eye_color
#>                  name   eye_color    height      mass   homeworld
#>           <character> <character> <integer> <numeric> <character>
#> 1      Luke Skywalker        blue       172        77    Tatooine
#> 2               C-3PO      yellow       167        75    Tatooine
#> 3               R2-D2         red        96        32       Naboo
#> 4         Leia Organa       brown       150        49          NA
#> 5           Owen Lars        blue       178       120          NA
#> 6  Beru Whitesun Lars        blue       165        75          NA
#> 7         Darth Vader      yellow       202       136          NA
#> 8   Biggs Darklighter       brown       183        84          NA
#> 9      Obi-Wan Kenobi   blue-gray       182        77          NA
#> 10              R5-D4         red        97        32          NA
```

## 2.1 Citing `DFplyr`

We hope that *[DFplyr](https://bioconductor.org/packages/3.22/DFplyr)* will be useful for your research. Please use
the following information to cite the package and the overall approach. Thank
you!

```
citation("DFplyr")
#> To cite package 'DFplyr' in publications use:
#>
#>   Carroll J (2025). _DFplyr: A `DataFrame` (`S4Vectors`) backend for
#>   `dplyr`_. doi:10.18129/B9.bioc.DFplyr
#>   <https://doi.org/10.18129/B9.bioc.DFplyr>, R package version 1.4.0,
#>   <https://bioconductor.org/packages/DFplyr>.
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Manual{,
#>     title = {DFplyr: A `DataFrame` (`S4Vectors`) backend for `dplyr`},
#>     author = {Jonathan Carroll},
#>     year = {2025},
#>     note = {R package version 1.4.0},
#>     url = {https://bioconductor.org/packages/DFplyr},
#>     doi = {10.18129/B9.bioc.DFplyr},
#>   }
```

## 2.2 Session Information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-29
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package       * version date (UTC) lib source
#>  BiocGenerics  * 0.56.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  BiocManager     1.30.26 2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocStyle     * 2.38.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  bookdown        0.45    2025-10-03 [2] CRAN (R 4.5.1)
#>  bslib           0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem          1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
#>  cli             3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
#>  DFplyr        * 1.4.0   2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  digest          0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
#>  dplyr         * 1.1.4   2023-11-17 [2] CRAN (R 4.5.1)
#>  evaluate        1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
#>  fastmap         1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
#>  generics      * 0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
#>  GenomeInfoDb    1.46.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  GenomicRanges   1.62.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  glue            1.8.0   2024-09-30 [2] CRAN (R 4.5.1)
#>  htmltools       0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
#>  httr            1.4.7   2023-08-15 [2] CRAN (R 4.5.1)
#>  IRanges         2.44.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  jquerylib       0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite        2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
#>  knitr           1.50    2025-03-16 [2] CRAN (R 4.5.1)
#>  lifecycle       1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
#>  magrittr        2.0.4   2025-09-12 [2] CRAN (R 4.5.1)
#>  pillar          1.11.1  2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig       2.0.3   2019-09-22 [2] CRAN (R 4.5.1)
#>  R6              2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
#>  rlang           1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown       2.30    2025-09-28 [2] CRAN (R 4.5.1)
#>  S4Vectors     * 0.48.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sass            0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
#>  Seqinfo         1.0.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  sessioninfo     1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
#>  tibble          3.3.0   2025-06-08 [2] CRAN (R 4.5.1)
#>  tidyselect      1.2.1   2024-03-11 [2] CRAN (R 4.5.1)
#>  UCSC.utils      1.6.0   2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  vctrs           0.6.5   2023-12-01 [2] CRAN (R 4.5.1)
#>  withr           3.0.2   2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun            0.53    2025-08-19 [2] CRAN (R 4.5.1)
#>  yaml            2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpFW4j0O/Rinst140ff431d55e9
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```