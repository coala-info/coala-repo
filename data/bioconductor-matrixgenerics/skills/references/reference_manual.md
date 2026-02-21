Package ‘MatrixGenerics’

February 13, 2026

Title S4 Generic Summary Statistic Functions that Operate on

Matrix-Like Objects

Description S4 generic functions modeled after the 'matrixStats' API

for alternative matrix implementations. Packages with alternative matrix
implementation can depend on this package and implement the generic
functions that are defined here for a useful set of row and column
summary statistics. Other package developers can import this package
and handle a different matrix implementations without worrying
about incompatibilities.

biocViews Infrastructure, Software

URL https://bioconductor.org/packages/MatrixGenerics

BugReports https://github.com/Bioconductor/MatrixGenerics/issues

Version 1.22.0

License Artistic-2.0

Encoding UTF-8

Depends matrixStats (>= 1.4.1)

Imports methods

Suggests Matrix, sparseMatrixStats, SparseArray, DelayedArray,

DelayedMatrixStats, SummarizedExperiment, testthat (>= 2.1.0)

RoxygenNote 7.3.2

Roxygen list(markdown = TRUE, old_usage = TRUE)

Collate 'MatrixGenerics-package.R' 'rowAlls.R' 'rowAnyNAs.R'

'rowAnys.R' 'rowAvgsPerColSet.R' 'rowCollapse.R' 'rowCounts.R'
'rowCummaxs.R' 'rowCummins.R' 'rowCumprods.R' 'rowCumsums.R'
'rowDiffs.R' 'rowIQRDiffs.R' 'rowIQRs.R' 'rowLogSumExps.R'
'rowMadDiffs.R' 'rowMads.R' 'rowMaxs.R' 'rowMeans.R'
'rowMeans2.R' 'rowMedians.R' 'rowMins.R' 'rowOrderStats.R'
'rowProds.R' 'rowQuantiles.R' 'rowRanges.R' 'rowRanks.R'
'rowSdDiffs.R' 'rowSds.R' 'rowSums.R' 'rowSums2.R'
'rowTabulates.R' 'rowVarDiffs.R' 'rowVars.R'
'rowWeightedMads.R' 'rowWeightedMeans.R' 'rowWeightedMedians.R'
'rowWeightedSds.R' 'rowWeightedVars.R'

git_url https://git.bioconductor.org/packages/MatrixGenerics

git_branch RELEASE_3_22

1

2

Contents

git_last_commit 75d9a54

git_last_commit_date 2025-10-29

Repository Bioconductor 3.22

Date/Publication 2026-02-12

Author Constantin Ahlmann-Eltze [aut] (ORCID:

<https://orcid.org/0000-0002-3762-068X>),
Peter Hickey [aut, cre] (ORCID:
<https://orcid.org/0000-0002-8153-6258>),
Hervé Pagès [aut]

Maintainer Peter Hickey <peter.hickey@gmail.com>

Contents

.

.

.

.

.
.
.

.
.
.
.

MatrixGenerics-package .
.
.
internal-helpers .
.
.
.
rowAlls .
.
.
.
.
rowAnyNAs .
.
.
rowAnys .
.
.
.
.
rowAvgsPerColSet
.
.
.
.
.
rowCollapse .
.
.
.
.
.
.
rowCounts .
.
.
.
.
rowCummaxs .
.
.
.
.
rowCummins
.
.
.
.
.
rowCumprods .
.
.
.
.
rowCumsums .
.
.
.
.
.
.
rowDiffs .
.
.
.
.
.
rowIQRDiffs
.
.
rowIQRs .
.
.
.
.
.
.
rowLogSumExps .
.
.
.
.
.
rowMadDiffs
.
.
.
.
.
.
.
rowMads
.
.
.
.
.
.
rowMaxs
.
.
.
.
.
.
rowMeans .
.
.
.
.
.
.
rowMeans2 .
.
.
.
.
.
rowMedians .
.
.
.
.
rowMins .
.
.
.
.
.
.
rowOrderStats .
.
.
.
.
.
.
rowProds
.
.
.
.
.
rowQuantiles
.
.
.
.
.
rowRanges
.
.
.
.
.
rowRanks .
.
.
.
.
.
rowSdDiffs
.
.
.
.
.
.
rowSds
.
.
.
.
.
.
rowSums
.
.
.
.
.
.
rowSums2 .
.
.
.
.
.
rowTabulates
.
.
.
.
.
rowVarDiffs .
.
.
rowVars .
.
.
.
.
.
rowWeightedMads
.
.
rowWeightedMeans .

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.
.

.
.
.
.
.
.

.

.

.

3
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
3
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
3
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
5
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. .
6
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
7
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
9
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 10
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 12
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 13
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 15
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 16
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 17
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 19
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 20
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 22
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 23
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 25
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 26
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 28
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 29
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 30
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 32
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 33
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 34
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 36
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 38
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 39
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 41
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 42
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 44
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 45
.
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 46
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 48
. .
. .
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 49
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 51
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 53

MatrixGenerics-package

3

rowWeightedMedians .
.
rowWeightedSds
.
.
rowWeightedVars .

.
.

.
.
.

.
.
.

.
.
.

. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 54
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 56
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 57

Index

59

MatrixGenerics-package

The MatrixGenerics package

Description

The MatrixGenerics package defines S4 generic summary statistic functions that operate on matrix-
Like objects.

internal-helpers

Internal helpers

Description

Not for end users

Usage

normarg_center(center, n, what)

rowAlls

Description

Check if all elements in a row (column) of a matrix-like object are
equal to a value

Check if all elements in a row (column) of a matrix-like object are equal to a value.

Usage

rowAlls(x, rows = NULL, cols = NULL, value = TRUE, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowAlls(x, rows = NULL,

cols = NULL, value = TRUE, na.rm = FALSE, dim. = dim(x), ...,
useNames = TRUE)

## S4 method for signature 'ANY'
rowAlls(x, rows = NULL, cols = NULL, value = TRUE,

na.rm = FALSE, ..., useNames = TRUE)

4

rowAlls

colAlls(x, rows = NULL, cols = NULL, value = TRUE, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colAlls(x, rows = NULL,

cols = NULL, value = TRUE, na.rm = FALSE, dim. = dim(x), ...,
useNames = TRUE)

## S4 method for signature 'ANY'
colAlls(x, rows = NULL, cols = NULL, value = TRUE,

na.rm = FALSE, ..., useNames = TRUE)

Arguments

x
rows, cols

value
na.rm
...
useNames

dim.

Details

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.
The value to search for.
If TRUE, missing values (NA or NaN) are omitted from the calculations.
Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.
An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowAlls /
matrixStats::colAlls.

Value

Returns a logical vector of length N (K).

See Also

• matrixStats::rowAlls() and matrixStats::colAlls() which are used when the input is

a matrix or numeric vector.

• For checks if any element is equal to a value, see rowAnys().
• base::all().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowAlls(mat)
colAlls(mat)

5

Check if any elements in a row (column) of a matrix-like object is
missing

rowAnyNAs

rowAnyNAs

Description

Check if any elements in a row (column) of a matrix-like object is missing.

Usage

rowAnyNAs(x, rows = NULL, cols = NULL, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowAnyNAs(x, rows = NULL,

cols = NULL, ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowAnyNAs(x, rows = NULL, cols = NULL, ...,

useNames = TRUE)

colAnyNAs(x, rows = NULL, cols = NULL, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colAnyNAs(x, rows = NULL,

cols = NULL, ..., useNames = TRUE)

## S4 method for signature 'ANY'
colAnyNAs(x, rows = NULL, cols = NULL, ...,

useNames = TRUE)

Arguments

x

rows, cols

...

useNames

Details

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.

Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowAnyNAs /
matrixStats::colAnyNAs.

Value

Returns a logical vector of length N (K).

6

See Also

rowAnys

• matrixStats::rowAnyNAs() and matrixStats::colAnyNAs() which are used when the in-

put is a matrix or numeric vector.

• For checks if any element is equal to a value, see rowAnys().
• base::is.na() and base::any().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowAnyNAs(mat)
colAnyNAs(mat)

rowAnys

Description

Check if any elements in a row (column) of a matrix-like object is equal
to a value

Check if any elements in a row (column) of a matrix-like object is equal to a value.

Usage

rowAnys(x, rows = NULL, cols = NULL, value = TRUE, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowAnys(x, rows = NULL,

cols = NULL, value = TRUE, na.rm = FALSE, dim. = dim(x), ...,
useNames = TRUE)

## S4 method for signature 'ANY'
rowAnys(x, rows = NULL, cols = NULL, value = TRUE,

na.rm = FALSE, ..., useNames = TRUE)

colAnys(x, rows = NULL, cols = NULL, value = TRUE, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colAnys(x, rows = NULL,

cols = NULL, value = TRUE, na.rm = FALSE, dim. = dim(x), ...,
useNames = TRUE)

## S4 method for signature 'ANY'
colAnys(x, rows = NULL, cols = NULL, value = TRUE,

na.rm = FALSE, ..., useNames = TRUE)

rowAvgsPerColSet

Arguments

x

rows, cols

value

na.rm

...

useNames

dim.

Details

7

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.

The value to search for.
If TRUE, missing values (NA or NaN) are omitted from the calculations.

Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.
An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowAnys /
matrixStats::colAnys.

Value

Returns a logical vector of length N (K).

See Also

• matrixStats::rowAnys() and matrixStats::colAnys() which are used when the input is

a matrix or numeric vector.

• For checks if all elements are equal to a value, see rowAlls().
• base::any().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowAnys(mat)
colAnys(mat)

rowAvgsPerColSet

Calculates for each row (column) a summary statistic for equally sized
subsets of columns (rows)

Description

Calculates for each row (column) a summary statistic for equally sized subsets of columns (rows).

8

Usage

rowAvgsPerColSet

rowAvgsPerColSet(X, W = NULL, rows = NULL, S, FUN = rowMeans, ...,

na.rm = NA, tFUN = FALSE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowAvgsPerColSet(X, W = NULL,

rows = NULL, S, FUN = rowMeans, ..., na.rm = NA, tFUN = FALSE)

## S4 method for signature 'ANY'
rowAvgsPerColSet(X, W = NULL, rows = NULL, S,

FUN = rowMeans, ..., na.rm = NA, tFUN = FALSE)

colAvgsPerRowSet(X, W = NULL, cols = NULL, S, FUN = colMeans, ...,

na.rm = NA, tFUN = FALSE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colAvgsPerRowSet(X, W = NULL,

cols = NULL, S, FUN = colMeans, ..., na.rm = NA, tFUN = FALSE)

## S4 method for signature 'ANY'
colAvgsPerRowSet(X, W = NULL, cols = NULL, S,

FUN = colMeans, ..., na.rm = NA, tFUN = FALSE)

Arguments

X

W
rows, cols

S

FUN

...

na.rm

tFUN

Details

An NxM matrix-like object.
An optional numeric NxM matrix of weights.
A vector indicating the subset (and/or columns) to operate over. If NULL, no
subsetting is done.
An integer KxJ matrix that specifying the J subsets. Each column hold K column
(row) indices for the corresponding subset. The range of values is [1, M] ([1,N]).

A row-by-row (column-by-column) summary statistic function. It is applied to
to each column (row) subset of X that is specified by S.
Additional arguments passed to FUN.
(logical) Argument passed to FUN() as na.rm = na.rm.
If NA (default), then
na.rm = TRUE is used if X or S holds missing values, otherwise na.rm = FALSE.
If TRUE, X is transposed before it is passed to FUN.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowAvgsPerColSet
/ matrixStats::colAvgsPerRowSet.

Value

Returns a numeric JxN (MxJ) matrix.

See Also

• matrixStats::rowAvgsPerColSet() and matrixStats::colAvgsPerRowSet() which are

used when the input is a matrix or numeric vector.

9

rowCollapse

Examples

mat <- matrix(rnorm(20), nrow = 5, ncol = 4)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

S <- matrix(1:ncol(mat), ncol = 2)
print(S)

rowAvgsPerColSet(mat, S = S, FUN = rowMeans)
rowAvgsPerColSet(mat, S = S, FUN = rowVars)

rowCollapse

Extract one cell from each row (column) of a matrix-like object

Description

Extract one cell from each row (column) of a matrix-like object.

Usage

rowCollapse(x, idxs, rows = NULL, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowCollapse(x, idxs,

rows = NULL, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowCollapse(x, idxs, rows = NULL, ..., useNames = TRUE)

colCollapse(x, idxs, cols = NULL, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colCollapse(x, idxs,

cols = NULL, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
colCollapse(x, idxs, cols = NULL, ..., useNames = TRUE)

Arguments

x

idxs

rows, cols

...

An NxK matrix-like object.
An index vector with the position to extract. It is recycled to match the number
of rows (column)
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.

Additional arguments passed to specific methods.

10

useNames

dim.

Details

rowCounts

If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.
An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowCollapse
/ matrixStats::colCollapse.

Value

Returns a numeric vector of length N (K).

See Also

• matrixStats::rowCollapse() and matrixStats::colCollapse() which are used when

the input is a matrix or numeric vector.

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowCollapse(mat, idxs = 2)
rowCollapse(mat, idxs = c(1,1,2,3,2))

colCollapse (mat, idxs = 4)

rowCounts

Description

Count how often an element in a row (column) of a matrix-like object
is equal to a value

Count how often an element in a row (column) of a matrix-like object is equal to a value.

Usage

rowCounts(x, rows = NULL, cols = NULL, value = TRUE, na.rm = FALSE,

..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowCounts(x, rows = NULL,

cols = NULL, value = TRUE, na.rm = FALSE, dim. = dim(x), ...,
useNames = TRUE)

rowCounts

11

## S4 method for signature 'ANY'
rowCounts(x, rows = NULL, cols = NULL, value = TRUE,

na.rm = FALSE, ..., useNames = TRUE)

colCounts(x, rows = NULL, cols = NULL, value = TRUE, na.rm = FALSE,

..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colCounts(x, rows = NULL,

cols = NULL, value = TRUE, na.rm = FALSE, dim. = dim(x), ...,
useNames = TRUE)

## S4 method for signature 'ANY'
colCounts(x, rows = NULL, cols = NULL, value = TRUE,

na.rm = FALSE, ..., useNames = TRUE)

Arguments

x
rows, cols

value

na.rm

...

useNames

dim.

Details

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.
The value to search for.
If TRUE, missing values (NA or NaN) are omitted from the calculations.
Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.
An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowCounts /
matrixStats::colCounts.

Value

Returns a integer vector of length N (K).

See Also

• matrixStats::rowCounts() and matrixStats::colCounts() which are used when the in-

put is a matrix or numeric vector.

• For checks if any element is equal to a value, see rowAnys(). To check if all elements are

equal, see rowAlls().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf

12

mat[4, 1] <- 0

print(mat)

rowCounts(mat)
colCounts(mat)

rowCounts(mat, value = 0)
colCounts(mat, value = Inf, na.rm = TRUE)

rowCummaxs

rowCummaxs

Calculates the cumulative maxima for each row (column) of a matrix-
like object

Description

Calculates the cumulative maxima for each row (column) of a matrix-like object.

Usage

rowCummaxs(x, rows = NULL, cols = NULL, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowCummaxs(x, rows = NULL,

cols = NULL, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowCummaxs(x, rows = NULL, cols = NULL, ...,

useNames = TRUE)

colCummaxs(x, rows = NULL, cols = NULL, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colCummaxs(x, rows = NULL,

cols = NULL, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
colCummaxs(x, rows = NULL, cols = NULL, ...,

useNames = TRUE)

Arguments

x

rows, cols

...

useNames

dim.

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.

Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.
An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.

rowCummins

Details

13

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowCummaxs
/ matrixStats::colCummaxs.

Value

Returns a numeric matrixwith the same dimensions as x.

See Also

• matrixStats::rowCummaxs() and matrixStats::colCummaxs() which are used when the

input is a matrix or numeric vector.

• For single maximum estimates, see rowMaxs().
• base::cummax().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowCummaxs(mat)
colCummaxs(mat)

rowCummins

Calculates the cumulative minima for each row (column) of a matrix-
like object

Description

Calculates the cumulative minima for each row (column) of a matrix-like object.

Usage

rowCummins(x, rows = NULL, cols = NULL, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowCummins(x, rows = NULL,

cols = NULL, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowCummins(x, rows = NULL, cols = NULL, ...,

useNames = TRUE)

colCummins(x, rows = NULL, cols = NULL, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colCummins(x, rows = NULL,

14

rowCummins

cols = NULL, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
colCummins(x, rows = NULL, cols = NULL, ...,

useNames = TRUE)

Arguments

x

rows, cols

...

useNames

dim.

Details

An NxK matrix-like object.

A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.

Additional arguments passed to specific methods.

If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.

An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowCummins
/ matrixStats::colCummins.

Value

Returns a numeric matrixwith the same dimensions as x.

See Also

• matrixStats::rowCummins() and matrixStats::colCummins() which are used when the

input is a matrix or numeric vector.

• For single minimum estimates, see rowMins().

• base::cummin().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowCummins(mat)
colCummins(mat)

rowCumprods

15

rowCumprods

Calculates the cumulative product for each row (column) of a matrix-
like object

Description

Calculates the cumulative product for each row (column) of a matrix-like object.

Usage

rowCumprods(x, rows = NULL, cols = NULL, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowCumprods(x, rows = NULL,

cols = NULL, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowCumprods(x, rows = NULL, cols = NULL, ...,

useNames = TRUE)

colCumprods(x, rows = NULL, cols = NULL, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colCumprods(x, rows = NULL,

cols = NULL, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
colCumprods(x, rows = NULL, cols = NULL, ...,

useNames = TRUE)

Arguments

x

rows, cols

...

useNames

dim.

Details

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.

Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.
An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowCumprods
/ matrixStats::colCumprods.

Value

Returns a numeric matrixwith the same dimensions as x.

16

See Also

rowCumsums

• matrixStats::rowCumprods() and matrixStats::colCumprods() which are used when

the input is a matrix or numeric vector.

• base::cumprod().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowCumprods(mat)
colCumprods(mat)

rowCumsums

Calculates the cumulative sum for each row (column) of a matrix-like
object

Description

Calculates the cumulative sum for each row (column) of a matrix-like object.

Usage

rowCumsums(x, rows = NULL, cols = NULL, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowCumsums(x, rows = NULL,

cols = NULL, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowCumsums(x, rows = NULL, cols = NULL, ...,

useNames = TRUE)

colCumsums(x, rows = NULL, cols = NULL, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colCumsums(x, rows = NULL,

cols = NULL, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
colCumsums(x, rows = NULL, cols = NULL, ...,

useNames = TRUE)

rowDiffs

Arguments

x

rows, cols

...

useNames

dim.

Details

17

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.

Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.
An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowCumsums
/ matrixStats::colCumsums.

Value

Returns a numeric matrixwith the same dimensions as x.

See Also

• matrixStats::rowCumsums() and matrixStats::colCumsums() which are used when the

input is a matrix or numeric vector.

• base::cumsum().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowCumsums(mat)
colCumsums(mat)

rowDiffs

Description

Calculates the difference between each element of a row (column) of a
matrix-like object

Calculates the difference between each element of a row (column) of a matrix-like object.

18

Usage

rowDiffs

rowDiffs(x, rows = NULL, cols = NULL, lag = 1L, differences = 1L, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowDiffs(x, rows = NULL,

cols = NULL, lag = 1L, differences = 1L, dim. = dim(x), ...,
useNames = TRUE)

## S4 method for signature 'ANY'
rowDiffs(x, rows = NULL, cols = NULL, lag = 1L,

differences = 1L, ..., useNames = TRUE)

colDiffs(x, rows = NULL, cols = NULL, lag = 1L, differences = 1L, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colDiffs(x, rows = NULL,

cols = NULL, lag = 1L, differences = 1L, dim. = dim(x), ...,
useNames = TRUE)

## S4 method for signature 'ANY'
colDiffs(x, rows = NULL, cols = NULL, lag = 1L,

differences = 1L, ..., useNames = TRUE)

Arguments

x

rows, cols

An NxK matrix-like object.

A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.

lag

An integer specifying the lag.

differences

An integer specifying the order of difference.

...

useNames

dim.

Details

Additional arguments passed to specific methods.

If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.

An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowDiffs /
matrixStats::colDiffs.

Value

Returns a numeric matrix with one column (row) less than x: N x(K − 1) or (N − 1)xK.

rowIQRDiffs

See Also

19

• matrixStats::rowDiffs() and matrixStats::colDiffs() which are used when the input

is a matrix or numeric vector.

• base::diff().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowDiffs(mat)
colDiffs(mat)

rowIQRDiffs

Calculates the interquartile range of the difference between each ele-
ment of a row (column) of a matrix-like object

Description

Calculates the interquartile range of the difference between each element of a row (column) of a
matrix-like object.

Usage

rowIQRDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE, diff = 1L,

trim = 0, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowIQRDiffs(x, rows = NULL,

cols = NULL, na.rm = FALSE, diff = 1L, trim = 0, ...,
useNames = TRUE)

## S4 method for signature 'ANY'
rowIQRDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE,

diff = 1L, trim = 0, ..., useNames = TRUE)

colIQRDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE, diff = 1L,

trim = 0, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colIQRDiffs(x, rows = NULL,

cols = NULL, na.rm = FALSE, diff = 1L, trim = 0, ...,
useNames = TRUE)

## S4 method for signature 'ANY'
colIQRDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE,

diff = 1L, trim = 0, ..., useNames = TRUE)

20

Arguments

x

rows, cols

na.rm

diff

trim

...

useNames

Details

rowIQRs

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.
If TRUE, missing values (NA or NaN) are omitted from the calculations.

An integer specifying the order of difference.

A double in [0,1/2] specifying the fraction of observations to be trimmed from
each end of (sorted) x before estimation.

Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowIQRDiffs
/ matrixStats::colIQRDiffs.

Value

Returns a numeric vector of length N (K).

See Also

• matrixStats::rowIQRDiffs() and matrixStats::colIQRDiffs() which are used when

the input is a matrix or numeric vector.

• For the direct interquartile range see also rowIQRs.

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowIQRDiffs(mat)
colIQRDiffs(mat)

rowIQRs

Description

Calculates the interquartile range for each row (column) of a matrix-
like object

Calculates the interquartile range for each row (column) of a matrix-like object.

rowIQRs

Usage

21

rowIQRs(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowIQRs(x, rows = NULL,

cols = NULL, na.rm = FALSE, ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowIQRs(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

colIQRs(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colIQRs(x, rows = NULL,

cols = NULL, na.rm = FALSE, ..., useNames = TRUE)

## S4 method for signature 'ANY'
colIQRs(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

Arguments

x

rows, cols

na.rm

...

useNames

Details

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.
If TRUE, missing values (NA or NaN) are omitted from the calculations.

Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowIQRs /
matrixStats::colIQRs.

Value

Returns a numeric vector of length N (K).

See Also

• matrixStats::rowIQRs() and matrixStats::colIQRs() which are used when the input is

a matrix or numeric vector.

• For a non-robust analog, see rowSds(). For a more robust version see rowMads()
• stats::IQR().

rowLogSumExps

22

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowIQRs(mat)
colIQRs(mat)

rowLogSumExps

Accurately calculates the logarithm of the sum of exponentials for each
row (column) of a matrix-like object

Description

Accurately calculates the logarithm of the sum of exponentials for each row (column) of a matrix-
like object.

Usage

rowLogSumExps(lx, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowLogSumExps(lx,

rows = NULL, cols = NULL, na.rm = FALSE, dim. = dim(lx), ...,
useNames = TRUE)

## S4 method for signature 'ANY'
rowLogSumExps(lx, rows = NULL, cols = NULL,

na.rm = FALSE, ..., useNames = TRUE)

colLogSumExps(lx, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colLogSumExps(lx,

rows = NULL, cols = NULL, na.rm = FALSE, dim. = dim(lx), ...,
useNames = TRUE)

## S4 method for signature 'ANY'
colLogSumExps(lx, rows = NULL, cols = NULL,

na.rm = FALSE, ..., useNames = TRUE)

Arguments

lx
rows, cols

An NxK matrix-like object. Typically lx are log(x) values.
A vector indicating the subset (and/or columns) to operate over. If NULL, no
subsetting is done.

rowMadDiffs

na.rm

...

useNames

dim.

Details

23

If TRUE, missing values (NA or NaN) are omitted from the calculations.

Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.
An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowLogSumExps
/ matrixStats::colLogSumExps.

Value

Returns a numeric vector of length N (K).

See Also

• matrixStats::rowLogSumExps() and matrixStats::colLogSumExps() which are used when

the input is a matrix or numeric vector.

• rowSums2()

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowLogSumExps(mat)
colLogSumExps(mat)

rowMadDiffs

Calculates the mean absolute deviation of the difference between each
element of a row (column) of a matrix-like object

Description

Calculates the mean absolute deviation of the difference between each element of a row (column)
of a matrix-like object.

Usage

rowMadDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE, diff = 1L,

trim = 0, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowMadDiffs(x, rows = NULL,

24

rowMadDiffs

cols = NULL, na.rm = FALSE, diff = 1L, trim = 0, ...,
useNames = TRUE)

## S4 method for signature 'ANY'
rowMadDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE,

diff = 1L, trim = 0, ..., useNames = TRUE)

colMadDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE, diff = 1L,

trim = 0, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colMadDiffs(x, rows = NULL,

cols = NULL, na.rm = FALSE, diff = 1L, trim = 0, ...,
useNames = TRUE)

## S4 method for signature 'ANY'
colMadDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE,

diff = 1L, trim = 0, ..., useNames = TRUE)

Arguments

x

rows, cols

na.rm

diff

trim

...

useNames

Details

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.
If TRUE, missing values (NA or NaN) are omitted from the calculations.

An integer specifying the order of difference.

A double in [0,1/2] specifying the fraction of observations to be trimmed from
each end of (sorted) x before estimation.

Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowMadDiffs
/ matrixStats::colMadDiffs.

Value

Returns a numeric vector of length N (K).

See Also

• matrixStats::rowMadDiffs() and matrixStats::colMadDiffs() which are used when

the input is a matrix or numeric vector.

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

rowMads

25

print(mat)

rowMadDiffs(mat)
colMadDiffs(mat)

rowMads

Description

Calculates the median absolute deviation for each row (column) of a
matrix-like object

Calculates the median absolute deviation for each row (column) of a matrix-like object.

Usage

rowMads(x, rows = NULL, cols = NULL, center = NULL, constant = 1.4826,

na.rm = FALSE, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowMads(x, rows = NULL,

cols = NULL, center = NULL, constant = 1.4826, na.rm = FALSE,
dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowMads(x, rows = NULL, cols = NULL, center = NULL,

constant = 1.4826, na.rm = FALSE, ..., useNames = TRUE)

colMads(x, rows = NULL, cols = NULL, center = NULL, constant = 1.4826,

na.rm = FALSE, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colMads(x, rows = NULL,

cols = NULL, center = NULL, constant = 1.4826, na.rm = FALSE,
dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
colMads(x, rows = NULL, cols = NULL, center = NULL,

constant = 1.4826, na.rm = FALSE, ..., useNames = TRUE)

Arguments

x

rows, cols

center

constant

na.rm

...

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.

(optional) the center, defaults to the row means
A scale factor. See stats::mad() for details.
If TRUE, missing values (NA or NaN) are omitted from the calculations.

Additional arguments passed to specific methods.

26

useNames

dim.

Details

rowMaxs

If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.
An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowMads /
matrixStats::colMads.

Value

Returns a numeric vector of length N (K).

See Also

• matrixStats::rowMads() and matrixStats::colMads() which are used when the input is

a matrix or numeric vector.

• For mean estimates, see rowMeans2() and rowMeans().
• For non-robust standard deviation estimates, see rowSds().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowMads(mat)
colMads(mat)

rowMaxs

Calculates the maximum for each row (column) of a matrix-like object

Description

Calculates the maximum for each row (column) of a matrix-like object.

Usage

rowMaxs(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowMaxs(x, rows = NULL,

cols = NULL, na.rm = FALSE, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowMaxs(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

rowMaxs

useNames = TRUE)

27

colMaxs(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colMaxs(x, rows = NULL,

cols = NULL, na.rm = FALSE, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
colMaxs(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

Arguments

x
rows, cols

na.rm

...

useNames

dim.

Details

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.
If TRUE, missing values (NA or NaN) are omitted from the calculations.
Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.
An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowMaxs /
matrixStats::colMaxs.

Value

Returns a numeric vector of length N (K).

See Also

• matrixStats::rowMaxs() and matrixStats::colMaxs() which are used when the input is

a matrix or numeric vector.

• For min estimates, see rowMins().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowMaxs(mat)
colMaxs(mat)

28

rowMeans

rowMeans

Calculates the mean for each row (column) of a matrix-like object

Description

Calculates the mean for each row (column) of a matrix-like object.

Usage

rowMeans(x, na.rm = FALSE, dims = 1, ...)

colMeans(x, na.rm = FALSE, dims = 1, ...)

Arguments

x

na.rm

dims

...

Details

An NxK matrix-like object, a numeric data frame, or an array-like object of two
or more dimensions.
If TRUE, missing values (NA or NaN) are omitted from the calculations.

A single integer indicating which dimensions are regarded as rows or columns
to mean over. For rowMeans, the mean is over dimensions dims+1, ...; for
colMeans it is over dimensions 1:dims.

Additional arguments passed to specific methods.

This man page documents the rowMeans and colMeans S4 generic functions defined in the Matrix-
Generics package. See ?base::colMeans for the default methods (defined in the base package).

Value

Returns a numeric vector of length N (K).

See Also

• base::colMeans for the default rowMeans and colMeans methods.
• Matrix::colMeans in the Matrix package for rowMeans and colMeans methods defined for

CsparseMatrix derivatives (e.g. dgCMatrix objects).

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowMeans(mat)
colMeans(mat)

rowMeans2

29

rowMeans2

Calculates the mean for each row (column) of a matrix-like object

Description

Calculates the mean for each row (column) of a matrix-like object.

Usage

rowMeans2(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowMeans2(x, rows = NULL,

cols = NULL, na.rm = FALSE, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowMeans2(x, rows = NULL, cols = NULL, na.rm = FALSE,

..., useNames = TRUE)

colMeans2(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colMeans2(x, rows = NULL,

cols = NULL, na.rm = FALSE, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
colMeans2(x, rows = NULL, cols = NULL, na.rm = FALSE,

..., useNames = TRUE)

Arguments

x

rows, cols

na.rm

...

useNames

dim.

Details

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.
If TRUE, missing values (NA or NaN) are omitted from the calculations.

Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.
An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowMeans2 /
matrixStats::colMeans2.

30

Value

Returns a numeric vector of length N (K).

See Also

rowMedians

• matrixStats::rowMeans2() and matrixStats::colMeans2() which are used when the in-

put is a matrix or numeric vector.

• See also rowMeans() for the corresponding function in base R.
• For variance estimates, see rowVars().
• See also the base R version base::rowMeans().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowMeans2(mat)
colMeans2(mat)

rowMedians

Calculates the median for each row (column) of a matrix-like object

Description

Calculates the median for each row (column) of a matrix-like object.

Usage

rowMedians(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowMedians(x, rows = NULL,

cols = NULL, na.rm = FALSE, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowMedians(x, rows = NULL, cols = NULL, na.rm = FALSE,

..., useNames = TRUE)

colMedians(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colMedians(x, rows = NULL,

cols = NULL, na.rm = FALSE, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'

rowMedians

31

colMedians(x, rows = NULL, cols = NULL, na.rm = FALSE,

..., useNames = TRUE)

Arguments

x

rows, cols

na.rm

...

useNames

dim.

Details

An NxK matrix-like object.

A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.

If TRUE, missing values (NA or NaN) are omitted from the calculations.

Additional arguments passed to specific methods.

If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.

An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowMedians
/ matrixStats::colMedians.

Value

Returns a numeric vector of length N (K).

See Also

• matrixStats::rowMedians() and matrixStats::colMedians() which are used when the

input is a matrix or numeric vector.

• For mean estimates, see rowMeans2() and rowMeans().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowMedians(mat)
colMedians(mat)

32

rowMins

rowMins

Calculates the minimum for each row (column) of a matrix-like object

Description

Calculates the minimum for each row (column) of a matrix-like object.

Usage

rowMins(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowMins(x, rows = NULL,

cols = NULL, na.rm = FALSE, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowMins(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

colMins(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colMins(x, rows = NULL,

cols = NULL, na.rm = FALSE, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
colMins(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

Arguments

x

rows, cols

na.rm

...

useNames

dim.

Details

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.
If TRUE, missing values (NA or NaN) are omitted from the calculations.

Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.
An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowMins /
matrixStats::colMins.

rowOrderStats

Value

Returns a numeric vector of length N (K).

See Also

33

• matrixStats::rowMins() and matrixStats::colMins() which are used when the input is

a matrix or numeric vector.

• For max estimates, see rowMaxs().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowMins(mat)
colMins(mat)

rowOrderStats

Calculates an order statistic for each row (column) of a matrix-like
object

Description

Calculates an order statistic for each row (column) of a matrix-like object.

Usage

rowOrderStats(x, rows = NULL, cols = NULL, which, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowOrderStats(x, rows = NULL,

cols = NULL, which, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowOrderStats(x, rows = NULL, cols = NULL, which, ...,

useNames = TRUE)

colOrderStats(x, rows = NULL, cols = NULL, which, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colOrderStats(x, rows = NULL,

cols = NULL, which, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
colOrderStats(x, rows = NULL, cols = NULL, which, ...,

useNames = TRUE)

34

Arguments

x

rows, cols

which

...

useNames

dim.

Details

rowProds

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.

An integer index in [1,K] ([1,N]) indicating which order statistic to be returned

Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.
An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowOrderStats
/ matrixStats::colOrderStats.

Value

Returns a numeric vector of length N (K).

See Also

• matrixStats::rowOrderStats() and matrixStats::colOrderStats() which are used when

the input is a matrix or numeric vector.

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- 2
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowOrderStats(mat, which = 1)
colOrderStats(mat, which = 3)

rowProds

Calculates the product for each row (column) of a matrix-like object

Description

Calculates the product for each row (column) of a matrix-like object.

rowProds

Usage

35

rowProds(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowProds(x, rows = NULL,

cols = NULL, na.rm = FALSE, method = c("direct", "expSumLog"), ...,
useNames = TRUE)

## S4 method for signature 'ANY'
rowProds(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

colProds(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colProds(x, rows = NULL,

cols = NULL, na.rm = FALSE, method = c("direct", "expSumLog"), ...,
useNames = TRUE)

## S4 method for signature 'ANY'
colProds(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

Arguments

x

rows, cols

na.rm

...

useNames

method

Details

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.
If TRUE, missing values (NA or NaN) are omitted from the calculations.

Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.

A character vector of length one that specifies the how the product is calculated.
Note, that this is not a generic argument and not all implementation have to
provide it.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowProds /
matrixStats::colProds.

Value

Returns a numeric vector of length N (K).

See Also

• matrixStats::rowProds() and matrixStats::colProds() which are used when the input

is a matrix or numeric vector.

36

rowQuantiles

• For sums across rows (columns), see rowSums2() (colSums2())
• base::prod().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowProds(mat)
colProds(mat)

rowQuantiles

Calculates quantiles for each row (column) of a matrix-like object

Description

Calculates quantiles for each row (column) of a matrix-like object.

Usage

rowQuantiles(x, rows = NULL, cols = NULL, probs = seq(from = 0, to = 1,

by = 0.25), na.rm = FALSE, type = 7L, digits = 7L, ...,
useNames = TRUE, drop = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowQuantiles(x, rows = NULL,

cols = NULL, probs = seq(from = 0, to = 1, by = 0.25), na.rm = FALSE,
type = 7L, digits = 7L, ..., useNames = TRUE, drop = TRUE)

## S4 method for signature 'ANY'
rowQuantiles(x, rows = NULL, cols = NULL,

probs = seq(from = 0, to = 1, by = 0.25), na.rm = FALSE, type = 7L,
digits = 7L, ..., useNames = TRUE, drop = TRUE)

colQuantiles(x, rows = NULL, cols = NULL, probs = seq(from = 0, to = 1,

by = 0.25), na.rm = FALSE, type = 7L, digits = 7L, ...,
useNames = TRUE, drop = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colQuantiles(x, rows = NULL,

cols = NULL, probs = seq(from = 0, to = 1, by = 0.25), na.rm = FALSE,
type = 7L, digits = 7L, ..., useNames = TRUE, drop = TRUE)

## S4 method for signature 'ANY'
colQuantiles(x, rows = NULL, cols = NULL,

probs = seq(from = 0, to = 1, by = 0.25), na.rm = FALSE, type = 7L,
digits = 7L, ..., useNames = TRUE, drop = TRUE)

rowQuantiles

Arguments

x

rows, cols

probs

na.rm

type

digits

...

useNames

37

An NxK matrix-like object.

A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.

A numeric vector of J probabilities in [0, 1].

If TRUE, missing values (NA or NaN) are omitted from the calculations.

An integer specifying the type of estimator. See stats::quantile() for more
details.

An integer specifying the precision of the formatted percentages. See stats::quantile()
for more details.

Additional arguments passed to specific methods.

If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.

drop

If TRUE a vector is returned if J == 1.

Details

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowQuantiles
/ matrixStats::colQuantiles.

Value

a numeric NxJ (KxJ) matrix, where N (K) is the number of rows (columns) for which the J values
are calculated.

See Also

• matrixStats::rowQuantiles() and matrixStats::colQuantiles() which are used when

the input is a matrix or numeric vector.

• stats::quantile

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowQuantiles(mat)
colQuantiles(mat)

38

rowRanges

rowRanges

Calculates the minimum and maximum for each row (column) of a
matrix-like object

Description

Calculates the minimum and maximum for each row (column) of a matrix-like object.

Usage

rowRanges(x, ...)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowRanges(x, rows = NULL,

cols = NULL, na.rm = FALSE, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowRanges(x, ...)

colRanges(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colRanges(x, rows = NULL,

cols = NULL, na.rm = FALSE, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
colRanges(x, rows = NULL, cols = NULL, na.rm = FALSE,

..., useNames = TRUE)

Arguments

x

...

rows, cols

na.rm

dim.

useNames

Details

An NxK matrix-like object.

Additional arguments passed to specific methods.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.
If TRUE, missing values (NA or NaN) are omitted from the calculations.
An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowRanges /
matrixStats::colRanges.

rowRanks

Value

39

a numeric Nx2 (Kx2) matrix, where N (K) is the number of rows (columns) for which the ranges
are calculated.

Note

Unfortunately for the argument list of the rowRanges() generic function we cannot follow the
scheme used for the other row/column matrix summarization generic functions. This is because
we need to be compatible with the historic rowRanges() getter for RangedSummarizedExperiment
objects. See ?SummarizedExperiment::rowRanges.

See Also

• matrixStats::rowRanges() and matrixStats::colRanges() which are used when the in-

put is a matrix or numeric vector.
• For max estimates, see rowMaxs().
• For min estimates, see rowMins().
• base::range().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowRanges(mat)
colRanges(mat)

rowRanks

Description

Calculates the rank of the elements for each row (column) of a matrix-
like object

Calculates the rank of the elements for each row (column) of a matrix-like object.

Usage

rowRanks(x, rows = NULL, cols = NULL, ties.method = c("max", "average"),

..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowRanks(x, rows = NULL,

cols = NULL, ties.method = c("max", "average", "first", "last", "random",
"max", "min", "dense"), dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowRanks(x, rows = NULL, cols = NULL,

40

rowRanks

ties.method = c("max", "average"), ..., useNames = TRUE)

colRanks(x, rows = NULL, cols = NULL, ties.method = c("max", "average"),

..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colRanks(x, rows = NULL,

cols = NULL, ties.method = c("max", "average", "first", "last", "random",
"max", "min", "dense"), dim. = dim(x), preserveShape = FALSE, ...,
useNames = TRUE)

## S4 method for signature 'ANY'
colRanks(x, rows = NULL, cols = NULL,

ties.method = c("max", "average"), ..., useNames = TRUE)

Arguments

x
rows, cols

ties.method

...
useNames

dim.

preserveShape

Details

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.
A character string specifying how ties are treated. Note that the default specifies
fewer options than the original matrixStats package.
Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.
An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.
If TRUE the output matrix has the same shape as the input x. Note, that this is not
a generic argument and not all implementation of this function have to provide
it.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowRanks /
matrixStats::colRanks.
The matrixStats::rowRanks() function can handle a lot of different values for the ties.method
argument. Users of the generic function should however only rely on max and average because the
other ones are not guaranteed to be implemented:
max for values with identical values the maximum rank is returned
average for values with identical values the average of the ranks they cover is returned. Note, that

in this case the return value is of type numeric.

Value

A matrix of type integer is returned, unless ties.method = "average" when it is of type numeric.
The rowRanks() function always returns an NxK matrix, where N (K) is the number of rows
(columns) whose ranks are calculated.
The colRanks() function returns an NxK matrix, if preserveShape = TRUE, otherwise a KxN
matrix.
Any names of x are ignored and absent in the result.

rowSdDiffs

See Also

41

• matrixStats::rowRanks() and matrixStats::colRanks() which are used when the input

is a matrix or numeric vector.

• base::rank

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowRanks(mat)
colRanks(mat)

rowSdDiffs

Calculates the standard deviation of the difference between each ele-
ment of a row (column) of a matrix-like object

Description

Calculates the standard deviation of the difference between each element of a row (column) of a
matrix-like object.

Usage

rowSdDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE, diff = 1L,

trim = 0, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowSdDiffs(x, rows = NULL,

cols = NULL, na.rm = FALSE, diff = 1L, trim = 0, ...,
useNames = TRUE)

## S4 method for signature 'ANY'
rowSdDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE,

diff = 1L, trim = 0, ..., useNames = TRUE)

colSdDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE, diff = 1L,

trim = 0, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colSdDiffs(x, rows = NULL,

cols = NULL, na.rm = FALSE, diff = 1L, trim = 0, ...,
useNames = TRUE)

## S4 method for signature 'ANY'
colSdDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE,

diff = 1L, trim = 0, ..., useNames = TRUE)

42

Arguments

x

rows, cols

na.rm

diff

trim

...

useNames

Details

rowSds

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.
If TRUE, missing values (NA or NaN) are omitted from the calculations.

An integer specifying the order of difference.

A double in [0,1/2] specifying the fraction of observations to be trimmed from
each end of (sorted) x before estimation.

Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowSdDiffs
/ matrixStats::colSdDiffs.

Value

Returns a numeric vector of length N (K).

See Also

• matrixStats::rowSdDiffs() and matrixStats::colSdDiffs() which are used when the

input is a matrix or numeric vector.

• for the direct standard deviation see rowSds().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowSdDiffs(mat)
colSdDiffs(mat)

rowSds

Description

Calculates the standard deviation for each row (column) of a matrix-
like object

Calculates the standard deviation for each row (column) of a matrix-like object.

rowSds

Usage

43

rowSds(x, rows = NULL, cols = NULL, na.rm = FALSE, center = NULL, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowSds(x, rows = NULL,

cols = NULL, na.rm = FALSE, center = NULL, dim. = dim(x), ...,
useNames = TRUE)

## S4 method for signature 'ANY'
rowSds(x, rows = NULL, cols = NULL, na.rm = FALSE,

center = NULL, ..., useNames = TRUE)

colSds(x, rows = NULL, cols = NULL, na.rm = FALSE, center = NULL, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colSds(x, rows = NULL,

cols = NULL, na.rm = FALSE, center = NULL, dim. = dim(x), ...,
useNames = TRUE)

## S4 method for signature 'ANY'
colSds(x, rows = NULL, cols = NULL, na.rm = FALSE,

center = NULL, ..., useNames = TRUE)

Arguments

x

rows, cols

na.rm

center

...

useNames

dim.

Details

An NxK matrix-like object.

A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.

If TRUE, missing values (NA or NaN) are omitted from the calculations.

(optional) the center, defaults to the row means

Additional arguments passed to specific methods.

If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.

An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowSds /
matrixStats::colSds.

Value

Returns a numeric vector of length N (K).

44

See Also

rowSums

• matrixStats::rowSds() and matrixStats::colSds() which are used when the input is a

matrix or numeric vector.

• For mean estimates, see rowMeans2() and rowMeans().
• For variance estimates, see rowVars().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowSds(mat)
colSds(mat)

rowSums

Calculates the sum for each row (column) of a matrix-like object

Description

Calculates the sum for each row (column) of a matrix-like object.

Usage

rowSums(x, na.rm = FALSE, dims = 1, ...)

colSums(x, na.rm = FALSE, dims = 1, ...)

Arguments

x

na.rm

dims

...

Details

An NxK matrix-like object, a numeric data frame, or an array-like object of two
or more dimensions.
If TRUE, missing values (NA or NaN) are omitted from the calculations.

A single integer indicating which dimensions are regarded as rows or columns to
sum over. For rowSums, the sum is over dimensions dims+1, ...; for colSums
it is over dimensions 1:dims.

Additional arguments passed to specific methods.

This man page documents the rowSums and colSums S4 generic functions defined in the Matrix-
Generics package. See ?base::colSums for the default methods (defined in the base package).

Value

Returns a numeric vector of length N (K).

rowSums2

See Also

45

• base::colSums for the default rowSums and colSums methods.
• Matrix::colSums in the Matrix package for rowSums and colSums methods defined for

CsparseMatrix derivatives (e.g. dgCMatrix objects).

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowSums(mat)
colSums(mat)

rowSums2

Calculates the sum for each row (column) of a matrix-like object

Description

Calculates the sum for each row (column) of a matrix-like object.

Usage

rowSums2(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowSums2(x, rows = NULL,

cols = NULL, na.rm = FALSE, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowSums2(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

colSums2(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colSums2(x, rows = NULL,

cols = NULL, na.rm = FALSE, dim. = dim(x), ..., useNames = TRUE)

## S4 method for signature 'ANY'
colSums2(x, rows = NULL, cols = NULL, na.rm = FALSE, ...,

useNames = TRUE)

46

Arguments

x

rows, cols

na.rm

...

useNames

dim.

Details

rowTabulates

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.
If TRUE, missing values (NA or NaN) are omitted from the calculations.

Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.
An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowSums2 /
matrixStats::colSums2.

Value

Returns a numeric vector of length N (K).

See Also

• matrixStats::rowSums2() and matrixStats::colSums2() which are used when the input

is a matrix or numeric vector.

• For mean estimates, see rowMeans2() and rowMeans().
• base::sum().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowSums2(mat)
colSums2(mat)

rowTabulates

Tabulates the values in a matrix-like object by row (column)

Description

Tabulates the values in a matrix-like object by row (column).

rowTabulates

Usage

47

rowTabulates(x, rows = NULL, cols = NULL, values = NULL, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowTabulates(x, rows = NULL,

cols = NULL, values = NULL, ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowTabulates(x, rows = NULL, cols = NULL, values = NULL,

..., useNames = TRUE)

colTabulates(x, rows = NULL, cols = NULL, values = NULL, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colTabulates(x, rows = NULL,

cols = NULL, values = NULL, ..., useNames = TRUE)

## S4 method for signature 'ANY'
colTabulates(x, rows = NULL, cols = NULL, values = NULL,

..., useNames = TRUE)

Arguments

x

rows, cols

values

...

useNames

Details

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.

the values to search for.

Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowTabulates
/ matrixStats::colTabulates.

Value

a numeric NxJ (KxJ) matrix, where N (K) is the number of rows (columns) for which the J values
are calculated.

See Also

• matrixStats::rowTabulates() and matrixStats::colTabulates() which are used when

the input is a matrix or numeric vector.

• base::table()

48

Examples

rowVarDiffs

mat <- matrix(rpois(15, lambda = 3), nrow = 5, ncol = 3)
mat[2, 1] <- NA_integer_
mat[3, 3] <- 0L
mat[4, 1] <- 0L

print(mat)

rowTabulates(mat)
colTabulates(mat)

rowTabulates(mat, values = 0)
colTabulates(mat, values = 0)

rowVarDiffs

Calculates the variance of the difference between each element of a
row (column) of a matrix-like object

Description

Calculates the variance of the difference between each element of a row (column) of a matrix-like
object.

Usage

rowVarDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE, diff = 1L,

trim = 0, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowVarDiffs(x, rows = NULL,

cols = NULL, na.rm = FALSE, diff = 1L, trim = 0, ...,
useNames = TRUE)

## S4 method for signature 'ANY'
rowVarDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE,

diff = 1L, trim = 0, ..., useNames = TRUE)

colVarDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE, diff = 1L,

trim = 0, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colVarDiffs(x, rows = NULL,

cols = NULL, na.rm = FALSE, diff = 1L, trim = 0, ...,
useNames = TRUE)

## S4 method for signature 'ANY'
colVarDiffs(x, rows = NULL, cols = NULL, na.rm = FALSE,

diff = 1L, trim = 0, ..., useNames = TRUE)

rowVars

Arguments

x

rows, cols

na.rm

diff

trim

...

useNames

Details

49

An NxK matrix-like object.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.
If TRUE, missing values (NA or NaN) are omitted from the calculations.

An integer specifying the order of difference.

A double in [0,1/2] specifying the fraction of observations to be trimmed from
each end of (sorted) x before estimation.

Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowVarDiffs
/ matrixStats::colVarDiffs.

Value

Returns a numeric vector of length N (K).

See Also

• matrixStats::rowVarDiffs() and matrixStats::colVarDiffs() which are used when

the input is a matrix or numeric vector.

• for the direct variance see rowVars().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowVarDiffs(mat)
colVarDiffs(mat)

rowVars

Calculates the variance for each row (column) of a matrix-like object

Description

Calculates the variance for each row (column) of a matrix-like object.

50

Usage

rowVars

rowVars(x, rows = NULL, cols = NULL, na.rm = FALSE, center = NULL, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowVars(x, rows = NULL,

cols = NULL, na.rm = FALSE, center = NULL, dim. = dim(x), ...,
useNames = TRUE)

## S4 method for signature 'ANY'
rowVars(x, rows = NULL, cols = NULL, na.rm = FALSE,

center = NULL, ..., useNames = TRUE)

colVars(x, rows = NULL, cols = NULL, na.rm = FALSE, center = NULL, ...,

useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colVars(x, rows = NULL,

cols = NULL, na.rm = FALSE, center = NULL, dim. = dim(x), ...,
useNames = TRUE)

## S4 method for signature 'ANY'
colVars(x, rows = NULL, cols = NULL, na.rm = FALSE,

center = NULL, ..., useNames = TRUE)

Arguments

x

rows, cols

na.rm

center

...

useNames

dim.

Details

An NxK matrix-like object.

A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.

If TRUE, missing values (NA or NaN) are omitted from the calculations.

(optional) the center, defaults to the row means.

Additional arguments passed to specific methods.

If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.

An integer vector of length two specifying the dimension of x, essential when
x is a numeric vector. Note, that this is not a generic argument and not all
methods need provide it.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowVars /
matrixStats::colVars.

Value

Returns a numeric vector of length N (K).

rowWeightedMads

See Also

51

• matrixStats::rowVars() and matrixStats::colVars() which are used when the input is

a matrix or numeric vector.

• For mean estimates, see rowMeans2() and rowMeans().
• For standard deviation estimates, see rowSds().
• stats::var().

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)

rowVars(mat)
colVars(mat)

rowWeightedMads

Calculates the weighted median absolute deviation for each row (col-
umn) of a matrix-like object

Description

Calculates the weighted median absolute deviation for each row (column) of a matrix-like object.

Usage

rowWeightedMads(x, w = NULL, rows = NULL, cols = NULL, na.rm = FALSE,

constant = 1.4826, center = NULL, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowWeightedMads(x, w = NULL,

rows = NULL, cols = NULL, na.rm = FALSE, constant = 1.4826,
center = NULL, ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowWeightedMads(x, w = NULL, rows = NULL, cols = NULL,

na.rm = FALSE, constant = 1.4826, center = NULL, ...,
useNames = TRUE)

colWeightedMads(x, w = NULL, rows = NULL, cols = NULL, na.rm = FALSE,

constant = 1.4826, center = NULL, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colWeightedMads(x, w = NULL,

rows = NULL, cols = NULL, na.rm = FALSE, constant = 1.4826,
center = NULL, ..., useNames = TRUE)

52

rowWeightedMads

## S4 method for signature 'ANY'
colWeightedMads(x, w = NULL, rows = NULL, cols = NULL,

na.rm = FALSE, constant = 1.4826, center = NULL, ...,
useNames = TRUE)

Arguments

x

w

rows, cols

na.rm

constant

center

...

useNames

Details

An NxK matrix-like object.
A numeric vector of length K (N) that specifies by how much each element is
weighted.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.
If TRUE, missing values (NA or NaN) are omitted from the calculations.
A scale factor. See stats::mad() for details.

(optional) the center, defaults to the row means

Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowWeightedMads
/ matrixStats::colWeightedMads.

Value

Returns a numeric vector of length N (K).

See Also

• matrixStats::rowWeightedMads() and matrixStats::colWeightedMads() which are used

when the input is a matrix or numeric vector.

• See also rowMads for the corresponding unweighted function.

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)
w <- rnorm(n = 5, mean = 3)
rowWeightedMads(mat, w = w[1:3])
colWeightedMads(mat, w = w)

rowWeightedMeans

53

rowWeightedMeans

Calculates the weighted mean for each row (column) of a matrix-like
object

Description

Calculates the weighted mean for each row (column) of a matrix-like object.

Usage

rowWeightedMeans(x, w = NULL, rows = NULL, cols = NULL, na.rm = FALSE,

..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowWeightedMeans(x, w = NULL,

rows = NULL, cols = NULL, na.rm = FALSE, ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowWeightedMeans(x, w = NULL, rows = NULL, cols = NULL,

na.rm = FALSE, ..., useNames = TRUE)

colWeightedMeans(x, w = NULL, rows = NULL, cols = NULL, na.rm = FALSE,

..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colWeightedMeans(x, w = NULL,

rows = NULL, cols = NULL, na.rm = FALSE, ..., useNames = TRUE)

## S4 method for signature 'ANY'
colWeightedMeans(x, w = NULL, rows = NULL, cols = NULL,

na.rm = FALSE, ..., useNames = TRUE)

Arguments

x

w

rows, cols

na.rm

...

useNames

Details

An NxK matrix-like object.
A numeric vector of length K (N) that specifies by how much each element is
weighted.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.
If TRUE, missing values (NA or NaN) are omitted from the calculations.

Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowWeightedMeans
/ matrixStats::colWeightedMeans.

54

Value

Returns a numeric vector of length N (K).

See Also

rowWeightedMedians

• matrixStats::rowWeightedMeans() and matrixStats::colWeightedMeans() which are

used when the input is a matrix or numeric vector.

• See also rowMeans2 for the corresponding unweighted function.

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)
w <- rnorm(n = 5, mean = 3)
rowWeightedMeans(mat, w = w[1:3])
colWeightedMeans(mat, w = w)

rowWeightedMedians

Calculates the weighted median for each row (column) of a matrix-like
object

Description

Calculates the weighted median for each row (column) of a matrix-like object.

Usage

rowWeightedMedians(x, w = NULL, rows = NULL, cols = NULL,

na.rm = FALSE, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowWeightedMedians(x,

w = NULL, rows = NULL, cols = NULL, na.rm = FALSE, ...,
useNames = TRUE)

## S4 method for signature 'ANY'
rowWeightedMedians(x, w = NULL, rows = NULL, cols = NULL,

na.rm = FALSE, ..., useNames = TRUE)

colWeightedMedians(x, w = NULL, rows = NULL, cols = NULL,

na.rm = FALSE, ..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colWeightedMedians(x,

w = NULL, rows = NULL, cols = NULL, na.rm = FALSE, ...,
useNames = TRUE)

rowWeightedMedians

55

## S4 method for signature 'ANY'
colWeightedMedians(x, w = NULL, rows = NULL, cols = NULL,

na.rm = FALSE, ..., useNames = TRUE)

Arguments

x

w

rows, cols

na.rm

...

useNames

Details

An NxK matrix-like object.

A numeric vector of length K (N) that specifies by how much each element is
weighted.

A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.

If TRUE, missing values (NA or NaN) are omitted from the calculations.

Additional arguments passed to specific methods.

If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowWeightedMedians
/ matrixStats::colWeightedMedians.

Value

Returns a numeric vector of length N (K).

See Also

• matrixStats::rowWeightedMedians() and matrixStats::colWeightedMedians() which

are used when the input is a matrix or numeric vector.

• See also rowMedians for the corresponding unweighted function.

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)
w <- rnorm(n = 5, mean = 3)
rowWeightedMedians(mat, w = w[1:3])
colWeightedMedians(mat, w = w)

56

rowWeightedSds

rowWeightedSds

Calculates the weighted standard deviation for each row (column) of
a matrix-like object

Description

Calculates the weighted standard deviation for each row (column) of a matrix-like object.

Usage

rowWeightedSds(x, w = NULL, rows = NULL, cols = NULL, na.rm = FALSE,

..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowWeightedSds(x, w = NULL,

rows = NULL, cols = NULL, na.rm = FALSE, ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowWeightedSds(x, w = NULL, rows = NULL, cols = NULL,

na.rm = FALSE, ..., useNames = TRUE)

colWeightedSds(x, w = NULL, rows = NULL, cols = NULL, na.rm = FALSE,

..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colWeightedSds(x, w = NULL,

rows = NULL, cols = NULL, na.rm = FALSE, ..., useNames = TRUE)

## S4 method for signature 'ANY'
colWeightedSds(x, w = NULL, rows = NULL, cols = NULL,

na.rm = FALSE, ..., useNames = TRUE)

Arguments

x

w

rows, cols

na.rm

...

useNames

Details

An NxK matrix-like object.
A numeric vector of length K (N) that specifies by how much each element is
weighted.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.
If TRUE, missing values (NA or NaN) are omitted from the calculations.

Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowWeightedSds
/ matrixStats::colWeightedSds.

rowWeightedVars

Value

Returns a numeric vector of length N (K).

See Also

57

• matrixStats::rowWeightedSds() and matrixStats::colWeightedSds() which are used

when the input is a matrix or numeric vector.

• See also rowSds for the corresponding unweighted function.

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)
w <- rnorm(n = 5, mean = 3)
rowWeightedSds(mat, w = w[1:3])
colWeightedSds(mat, w = w)

rowWeightedVars

Calculates the weighted variance for each row (column) of a matrix-
like object

Description

Calculates the weighted variance for each row (column) of a matrix-like object.

Usage

rowWeightedVars(x, w = NULL, rows = NULL, cols = NULL, na.rm = FALSE,

..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
rowWeightedVars(x, w = NULL,

rows = NULL, cols = NULL, na.rm = FALSE, ..., useNames = TRUE)

## S4 method for signature 'ANY'
rowWeightedVars(x, w = NULL, rows = NULL, cols = NULL,

na.rm = FALSE, ..., useNames = TRUE)

colWeightedVars(x, w = NULL, rows = NULL, cols = NULL, na.rm = FALSE,

..., useNames = TRUE)

## S4 method for signature 'matrix_OR_array_OR_table_OR_numeric'
colWeightedVars(x, w = NULL,

rows = NULL, cols = NULL, na.rm = FALSE, ..., useNames = TRUE)

## S4 method for signature 'ANY'
colWeightedVars(x, w = NULL, rows = NULL, cols = NULL,

na.rm = FALSE, ..., useNames = TRUE)

58

Arguments

x

w

rows, cols

na.rm

...

useNames

Details

rowWeightedVars

An NxK matrix-like object.
A numeric vector of length K (N) that specifies by how much each element is
weighted.
A vector indicating the subset of rows (and/or columns) to operate over. If
NULL, no subsetting is done.
If TRUE, missing values (NA or NaN) are omitted from the calculations.
Additional arguments passed to specific methods.
If TRUE (default), names attributes of result are set. Else if FALSE, no naming
support is done.

The S4 methods for x of type matrix, array, table, or numeric call matrixStats::rowWeightedVars
/ matrixStats::colWeightedVars.

Value

Returns a numeric vector of length N (K).

See Also

• matrixStats::rowWeightedVars() and matrixStats::colWeightedVars() which are used

when the input is a matrix or numeric vector.

• See also rowVars for the corresponding unweighted function.

Examples

mat <- matrix(rnorm(15), nrow = 5, ncol = 3)
mat[2, 1] <- NA
mat[3, 3] <- Inf
mat[4, 1] <- 0

print(mat)
w <- rnorm(n = 5, mean = 3)
rowWeightedVars(mat, w = w[1:3])
colWeightedVars(mat, w = w)

Index

∗ algebra

rowMeans, 28
rowSums, 44

∗ arith

rowMeans, 28
rowSums, 44

∗ array

rowAvgsPerColSet, 7
rowCollapse, 9
rowCummaxs, 12
rowCummins, 13
rowCumprods, 15
rowCumsums, 16
rowDiffs, 17
rowIQRDiffs, 19
rowIQRs, 20
rowLogSumExps, 22
rowMadDiffs, 23
rowMads, 25
rowMaxs, 26
rowMeans, 28
rowMeans2, 29
rowMedians, 30
rowMins, 32
rowOrderStats, 33
rowProds, 34
rowQuantiles, 36
rowRanges, 38
rowRanks, 39
rowSdDiffs, 41
rowSds, 42
rowSums, 44
rowSums2, 45
rowTabulates, 46
rowVarDiffs, 48
rowVars, 49
rowWeightedMads, 51
rowWeightedMeans, 53
rowWeightedMedians, 54
rowWeightedSds, 56
rowWeightedVars, 57

∗ internal

internal-helpers, 3

∗ iteration

rowAvgsPerColSet, 7
rowCollapse, 9
rowCummaxs, 12
rowCummins, 13
rowCumprods, 15
rowCumsums, 16
rowDiffs, 17
rowIQRDiffs, 19
rowIQRs, 20
rowLogSumExps, 22
rowMadDiffs, 23
rowMads, 25
rowMaxs, 26
rowMeans, 28
rowMeans2, 29
rowMedians, 30
rowMins, 32
rowOrderStats, 33
rowProds, 34
rowQuantiles, 36
rowRanges, 38
rowRanks, 39
rowSdDiffs, 41
rowSds, 42
rowSums, 44
rowSums2, 45
rowTabulates, 46
rowVarDiffs, 48
rowVars, 49
rowWeightedMads, 51
rowWeightedMeans, 53
rowWeightedMedians, 54
rowWeightedSds, 56
rowWeightedVars, 57

∗ robust

rowAvgsPerColSet, 7
rowCollapse, 9
rowCummaxs, 12
rowCummins, 13
rowCumprods, 15
rowCumsums, 16
rowDiffs, 17

59

60

INDEX

rowIQRDiffs, 19
rowIQRs, 20
rowLogSumExps, 22
rowMadDiffs, 23
rowMads, 25
rowMaxs, 26
rowMeans, 28
rowMeans2, 29
rowMedians, 30
rowMins, 32
rowOrderStats, 33
rowProds, 34
rowQuantiles, 36
rowRanges, 38
rowRanks, 39
rowSdDiffs, 41
rowSds, 42
rowSums, 44
rowSums2, 45
rowTabulates, 46
rowVarDiffs, 48
rowVars, 49
rowWeightedMads, 51
rowWeightedMeans, 53
rowWeightedMedians, 54
rowWeightedSds, 56
rowWeightedVars, 57

∗ univar2

rowAvgsPerColSet, 7

∗ univar

rowCollapse, 9
rowCummaxs, 12
rowCummins, 13
rowCumprods, 15
rowCumsums, 16
rowDiffs, 17
rowIQRDiffs, 19
rowIQRs, 20
rowLogSumExps, 22
rowMadDiffs, 23
rowMads, 25
rowMaxs, 26
rowMeans, 28
rowMeans2, 29
rowMedians, 30
rowMins, 32
rowOrderStats, 33
rowProds, 34
rowSdDiffs, 41
rowSds, 42
rowSums, 44
rowSums2, 45

rowTabulates, 46
rowVarDiffs, 48
rowVars, 49
rowWeightedMads, 51
rowWeightedMeans, 53
rowWeightedMedians, 54
rowWeightedSds, 56
rowWeightedVars, 57

∗ utilities

internal-helpers, 3

all, 4
any, 6, 7
array, 4, 5, 7, 8, 10, 11, 13–15, 17, 18, 20, 21,
23, 24, 26, 27, 29, 31, 32, 34, 35, 37,
38, 40, 42, 43, 46, 47, 49, 50, 52, 53,
55, 56, 58

base::rank, 41

class:matrix_OR_array_OR_table_OR_numeric
(MatrixGenerics-package), 3

colAlls, 4
colAlls (rowAlls), 3
colAlls,ANY-method (rowAlls), 3
colAlls,matrix_OR_array_OR_table_OR_numeric-method

(rowAlls), 3

colAnyNAs, 5, 6
colAnyNAs (rowAnyNAs), 5
colAnyNAs,ANY-method (rowAnyNAs), 5
colAnyNAs,matrix_OR_array_OR_table_OR_numeric-method

(rowAnyNAs), 5

colAnys, 7
colAnys (rowAnys), 6
colAnys,ANY-method (rowAnys), 6
colAnys,matrix_OR_array_OR_table_OR_numeric-method

(rowAnys), 6
colAvgsPerRowSet, 8
colAvgsPerRowSet (rowAvgsPerColSet), 7
colAvgsPerRowSet,ANY-method
(rowAvgsPerColSet), 7

colAvgsPerRowSet,matrix_OR_array_OR_table_OR_numeric-method

(rowAvgsPerColSet), 7

colCollapse, 10
colCollapse (rowCollapse), 9
colCollapse,ANY-method (rowCollapse), 9
colCollapse,matrix_OR_array_OR_table_OR_numeric-method

(rowCollapse), 9

colCounts, 11
colCounts (rowCounts), 10
colCounts,ANY-method (rowCounts), 10
colCounts,matrix_OR_array_OR_table_OR_numeric-method

(rowCounts), 10

INDEX

61

colCummaxs, 13
colCummaxs (rowCummaxs), 12
colCummaxs,ANY-method (rowCummaxs), 12
colCummaxs,matrix_OR_array_OR_table_OR_numeric-method

colMaxs (rowMaxs), 26
colMaxs,ANY-method (rowMaxs), 26
colMaxs,matrix_OR_array_OR_table_OR_numeric-method

(rowMaxs), 26

(rowCummaxs), 12

colCummins, 14
colCummins (rowCummins), 13
colCummins,ANY-method (rowCummins), 13
colCummins,matrix_OR_array_OR_table_OR_numeric-method

colMeans, 28
colMeans (rowMeans), 28
colMeans2, 29, 30
colMeans2 (rowMeans2), 29
colMeans2,ANY-method (rowMeans2), 29
colMeans2,matrix_OR_array_OR_table_OR_numeric-method

(rowCummins), 13

colCumprods, 15, 16
colCumprods (rowCumprods), 15
colCumprods,ANY-method (rowCumprods), 15
colCumprods,matrix_OR_array_OR_table_OR_numeric-method

(rowMeans2), 29

colMedians, 31
colMedians (rowMedians), 30
colMedians,ANY-method (rowMedians), 30
colMedians,matrix_OR_array_OR_table_OR_numeric-method

(rowCumprods), 15

colCumsums, 17
colCumsums (rowCumsums), 16
colCumsums,ANY-method (rowCumsums), 16
colCumsums,matrix_OR_array_OR_table_OR_numeric-method

(rowMedians), 30

colMins, 32, 33
colMins (rowMins), 32
colMins,ANY-method (rowMins), 32
colMins,matrix_OR_array_OR_table_OR_numeric-method

(rowCumsums), 16

colDiffs, 18, 19
colDiffs (rowDiffs), 17
colDiffs,ANY-method (rowDiffs), 17
colDiffs,matrix_OR_array_OR_table_OR_numeric-method

colOrderStats, 34
colOrderStats (rowOrderStats), 33
colOrderStats,ANY-method

(rowMins), 32

(rowDiffs), 17

(rowOrderStats), 33

colIQRDiffs, 20
colIQRDiffs (rowIQRDiffs), 19
colIQRDiffs,ANY-method (rowIQRDiffs), 19
colIQRDiffs,matrix_OR_array_OR_table_OR_numeric-method

(rowIQRDiffs), 19

colIQRs, 21
colIQRs (rowIQRs), 20
colIQRs,ANY-method (rowIQRs), 20
colIQRs,matrix_OR_array_OR_table_OR_numeric-method

(rowIQRs), 20

colLogSumExps, 23
colLogSumExps (rowLogSumExps), 22
colLogSumExps,ANY-method

(rowLogSumExps), 22

(rowLogSumExps), 22

colLogSumExps,matrix_OR_array_OR_table_OR_numeric-method

colOrderStats,matrix_OR_array_OR_table_OR_numeric-method

(rowOrderStats), 33

colProds, 35
colProds (rowProds), 34
colProds,ANY-method (rowProds), 34
colProds,matrix_OR_array_OR_table_OR_numeric-method

(rowProds), 34

colQuantiles, 37
colQuantiles (rowQuantiles), 36
colQuantiles,ANY-method (rowQuantiles),

36

colQuantiles,matrix_OR_array_OR_table_OR_numeric-method

(rowQuantiles), 36

colRanges, 38, 39
colRanges (rowRanges), 38
colRanges,ANY-method (rowRanges), 38
colRanges,matrix_OR_array_OR_table_OR_numeric-method

colMadDiffs, 24
colMadDiffs (rowMadDiffs), 23
colMadDiffs,ANY-method (rowMadDiffs), 23
colMadDiffs,matrix_OR_array_OR_table_OR_numeric-method

(rowRanges), 38

(rowMadDiffs), 23

colMads, 26
colMads (rowMads), 25
colMads,ANY-method (rowMads), 25
colMads,matrix_OR_array_OR_table_OR_numeric-method

(rowMads), 25

colMaxs, 27

colRanks, 40, 41
colRanks (rowRanks), 39
colRanks,ANY-method (rowRanks), 39
colRanks,matrix_OR_array_OR_table_OR_numeric-method

(rowRanks), 39

colSdDiffs, 42
colSdDiffs (rowSdDiffs), 41
colSdDiffs,ANY-method (rowSdDiffs), 41
colSdDiffs,matrix_OR_array_OR_table_OR_numeric-method

colWeightedSds,matrix_OR_array_OR_table_OR_numeric-method

colWeightedVars,matrix_OR_array_OR_table_OR_numeric-method

62

INDEX

(rowSdDiffs), 41

(rowWeightedSds), 56

colSds, 43, 44
colSds (rowSds), 42
colSds,ANY-method (rowSds), 42
colSds,matrix_OR_array_OR_table_OR_numeric-method

(rowSds), 42

colSums, 44, 45
colSums (rowSums), 44
colSums2, 46
colSums2 (rowSums2), 45
colSums2(), 36
colSums2,ANY-method (rowSums2), 45
colSums2,matrix_OR_array_OR_table_OR_numeric-method

cummax, 13
cummin, 14
cumprod, 16
cumsum, 17

(rowWeightedSds), 56

colWeightedVars, 58
colWeightedVars (rowWeightedVars), 57
colWeightedVars,ANY-method

(rowWeightedVars), 57

(rowWeightedVars), 57

(rowSums2), 45

colTabulates, 47
colTabulates (rowTabulates), 46
colTabulates,ANY-method (rowTabulates),

46

diff, 19

FALSE, 4, 5, 7, 10–12, 14, 15, 17, 18, 20, 21,

23, 24, 26, 27, 29, 31, 32, 34, 35, 37,
38, 40, 42, 43, 46, 47, 49, 50, 52, 53,
55, 56, 58

colTabulates,matrix_OR_array_OR_table_OR_numeric-method

(rowTabulates), 46

colVarDiffs, 49
colVarDiffs (rowVarDiffs), 48
colVarDiffs,ANY-method (rowVarDiffs), 48
colVarDiffs,matrix_OR_array_OR_table_OR_numeric-method

integer, 4, 7, 8, 10–12, 14, 15, 17, 18, 23, 26,
27, 29, 31, 32, 34, 38, 40, 43, 46, 50

(rowVarDiffs), 48

colVars, 50, 51
colVars (rowVars), 49
colVars,ANY-method (rowVars), 49
colVars,matrix_OR_array_OR_table_OR_numeric-method

logical, 4, 5, 7

internal-helpers, 3
IQR, 21
is.na, 6

(rowVars), 49

colWeightedMads, 52
colWeightedMads (rowWeightedMads), 51
colWeightedMads,ANY-method

(rowWeightedMads), 51

mad, 25, 52
matrix, 4, 5, 7, 8, 10, 11, 13–15, 17, 18, 20,

21, 23, 24, 26, 27, 29, 31, 32, 34, 35,
37–40, 42, 43, 46, 47, 49, 50, 52, 53,
55, 56, 58

colWeightedMads,matrix_OR_array_OR_table_OR_numeric-method

matrix_OR_array_OR_table_OR_numeric

(rowWeightedMads), 51

colWeightedMeans, 53, 54
colWeightedMeans (rowWeightedMeans), 53
colWeightedMeans,ANY-method

(rowWeightedMeans), 53

(MatrixGenerics-package), 3
matrix_OR_array_OR_table_OR_numeric-class
(MatrixGenerics-package), 3

MatrixGenerics-package, 3

colWeightedMeans,matrix_OR_array_OR_table_OR_numeric-method

(rowWeightedMeans), 53

colWeightedMedians, 55
colWeightedMedians

(rowWeightedMedians), 54

colWeightedMedians,ANY-method

(rowWeightedMedians), 54

(rowWeightedMedians), 54

colWeightedSds, 56, 57
colWeightedSds (rowWeightedSds), 56
colWeightedSds,ANY-method

NA, 4, 7, 11, 20, 21, 23–25, 27–29, 31, 32, 35,
37, 38, 42–44, 46, 49, 50, 52, 53, 55,
56, 58

names, 40
NaN, 4, 7, 11, 20, 21, 23–25, 27–29, 31, 32, 35,
37, 38, 42–44, 46, 49, 50, 52, 53, 55,
56, 58

normarg_center (internal-helpers), 3
NULL, 4, 5, 7–9, 11, 12, 14, 15, 17, 18, 20–22,
24, 25, 27, 29, 31, 32, 34, 35, 37, 38,
40, 42, 43, 46, 47, 49, 50, 52, 53, 55,
56, 58

colWeightedMedians,matrix_OR_array_OR_table_OR_numeric-method

INDEX

63

numeric, 4, 5, 7, 8, 10–15, 17, 18, 20, 21, 23,
24, 26–35, 37–40, 42–44, 46, 47, 49,
50, 52–58

prod, 36

quantile, 37

rowDiffs,matrix_OR_array_OR_table_OR_numeric-method

(rowDiffs), 17

rowIQRDiffs, 19, 20
rowIQRDiffs,ANY-method (rowIQRDiffs), 19
rowIQRDiffs,matrix_OR_array_OR_table_OR_numeric-method

(rowIQRDiffs), 19

rowIQRs, 20, 20, 21
rowIQRs,ANY-method (rowIQRs), 20
rowIQRs,matrix_OR_array_OR_table_OR_numeric-method

range, 39
RangedSummarizedExperiment, 39
rowAlls, 3, 4, 7, 11
rowAlls,ANY-method (rowAlls), 3
rowAlls,matrix_OR_array_OR_table_OR_numeric-method

(rowAlls), 3

rowAnyNAs, 5, 5, 6
rowAnyNAs,ANY-method (rowAnyNAs), 5
rowAnyNAs,matrix_OR_array_OR_table_OR_numeric-method

(rowAnyNAs), 5

rowAnys, 4, 6, 6, 7, 11
rowAnys,ANY-method (rowAnys), 6
rowAnys,matrix_OR_array_OR_table_OR_numeric-method

(rowIQRs), 20
rowLogSumExps, 22, 23
rowLogSumExps,ANY-method

(rowLogSumExps), 22

(rowLogSumExps), 22

(rowAnys), 6

rowAvgsPerColSet, 7, 8
rowAvgsPerColSet,ANY-method
(rowAvgsPerColSet), 7

rowAvgsPerColSet,matrix_OR_array_OR_table_OR_numeric-method

(rowAvgsPerColSet), 7

rowCollapse, 9, 10
rowCollapse,ANY-method (rowCollapse), 9
rowCollapse,matrix_OR_array_OR_table_OR_numeric-method

rowLogSumExps,matrix_OR_array_OR_table_OR_numeric-method

rowMadDiffs, 23, 24
rowMadDiffs,ANY-method (rowMadDiffs), 23
rowMadDiffs,matrix_OR_array_OR_table_OR_numeric-method

(rowMadDiffs), 23

rowMads, 25, 26, 52
rowMads(), 21
rowMads,ANY-method (rowMads), 25
rowMads,matrix_OR_array_OR_table_OR_numeric-method

(rowMads), 25

rowMaxs, 13, 26, 27, 33, 39
rowMaxs,ANY-method (rowMaxs), 26
rowMaxs,matrix_OR_array_OR_table_OR_numeric-method

(rowMaxs), 26
rowMeans, 26, 28, 30, 31, 44, 46, 51
rowMeans2, 26, 29, 29, 30, 31, 44, 46, 51, 54
rowMeans2,ANY-method (rowMeans2), 29
rowMeans2,matrix_OR_array_OR_table_OR_numeric-method

rowCounts, 10, 11
rowCounts,ANY-method (rowCounts), 10
rowCounts,matrix_OR_array_OR_table_OR_numeric-method

(rowMeans2), 29

(rowCollapse), 9

(rowCounts), 10

rowCummaxs, 12, 13
rowCummaxs,ANY-method (rowCummaxs), 12
rowCummaxs,matrix_OR_array_OR_table_OR_numeric-method

(rowMedians), 30

rowMedians, 30, 31, 55
rowMedians,ANY-method (rowMedians), 30
rowMedians,matrix_OR_array_OR_table_OR_numeric-method

(rowCummaxs), 12

rowCummins, 13, 14
rowCummins,ANY-method (rowCummins), 13
rowCummins,matrix_OR_array_OR_table_OR_numeric-method

rowMins, 14, 27, 32, 32, 33, 39
rowMins,ANY-method (rowMins), 32
rowMins,matrix_OR_array_OR_table_OR_numeric-method

(rowCummins), 13

rowCumprods, 15, 15, 16
rowCumprods,ANY-method (rowCumprods), 15
rowCumprods,matrix_OR_array_OR_table_OR_numeric-method

(rowCumprods), 15

(rowMins), 32
rowOrderStats, 33, 34
rowOrderStats,ANY-method

(rowOrderStats), 33

(rowOrderStats), 33

rowCumsums, 16, 17
rowCumsums,ANY-method (rowCumsums), 16
rowCumsums,matrix_OR_array_OR_table_OR_numeric-method

rowProds, 34, 35
rowProds,ANY-method (rowProds), 34
rowProds,matrix_OR_array_OR_table_OR_numeric-method

(rowCumsums), 16

rowDiffs, 17, 18, 19
rowDiffs,ANY-method (rowDiffs), 17

(rowProds), 34

rowQuantiles, 36, 37
rowQuantiles,ANY-method (rowQuantiles),

rowOrderStats,matrix_OR_array_OR_table_OR_numeric-method

64

36

INDEX

(rowWeightedMedians), 54

(rowWeightedMedians), 54

rowQuantiles,matrix_OR_array_OR_table_OR_numeric-method

rowWeightedMedians,matrix_OR_array_OR_table_OR_numeric-method

(rowQuantiles), 36

rowRanges, 38, 38, 39
rowRanges,ANY-method (rowRanges), 38
rowRanges,matrix_OR_array_OR_table_OR_numeric-method

rowWeightedSds, 56, 56, 57
rowWeightedSds,ANY-method

(rowWeightedSds), 56

rowRanks, 39, 40, 41
rowRanks,ANY-method (rowRanks), 39
rowRanks,matrix_OR_array_OR_table_OR_numeric-method

(rowWeightedSds), 56

rowWeightedVars, 57, 58
rowWeightedVars,ANY-method

(rowRanges), 38

rowWeightedSds,matrix_OR_array_OR_table_OR_numeric-method

rowWeightedVars,matrix_OR_array_OR_table_OR_numeric-method

(rowWeightedVars), 57

(rowWeightedVars), 57

(rowRanks), 39

rowSdDiffs, 41, 42
rowSdDiffs,ANY-method (rowSdDiffs), 41
rowSdDiffs,matrix_OR_array_OR_table_OR_numeric-method

(rowSdDiffs), 41

rowSds, 21, 26, 42, 43, 44, 51, 57
rowSds(), 42
rowSds,ANY-method (rowSds), 42
rowSds,matrix_OR_array_OR_table_OR_numeric-method

(rowSds), 42

stats::quantile, 37
sum, 46

table, 4, 5, 7, 8, 10, 11, 13–15, 17, 18, 20, 21,
23, 24, 26, 27, 29, 31, 32, 34, 35, 37,
38, 40, 42, 43, 46, 47, 49, 50, 52, 53,
55, 56, 58

rowSums, 44
rowSums2, 36, 45, 46
rowSums2(), 23
rowSums2,ANY-method (rowSums2), 45
rowSums2,matrix_OR_array_OR_table_OR_numeric-method
var, 51
vector, 4, 5, 7–12, 14, 15, 17, 18, 20–35, 37,
38, 40, 42–44, 46, 47, 49, 50, 52–58

TRUE, 4, 5, 7, 10–12, 14, 15, 17, 18, 20, 21,
23–29, 31, 32, 34, 35, 37, 38, 40,
42–44, 46, 47, 49, 50, 52, 53, 55, 56,
58

rowTabulates, 46, 47
rowTabulates,ANY-method (rowTabulates),

(rowSums2), 45

46

rowTabulates,matrix_OR_array_OR_table_OR_numeric-method

(rowTabulates), 46

rowVarDiffs, 48, 49
rowVarDiffs,ANY-method (rowVarDiffs), 48
rowVarDiffs,matrix_OR_array_OR_table_OR_numeric-method

(rowVarDiffs), 48

rowVars, 30, 44, 49, 50, 51, 58
rowVars(), 49
rowVars,ANY-method (rowVars), 49
rowVars,matrix_OR_array_OR_table_OR_numeric-method

(rowVars), 49

rowWeightedMads, 51, 52
rowWeightedMads,ANY-method

(rowWeightedMads), 51

rowWeightedMads,matrix_OR_array_OR_table_OR_numeric-method

(rowWeightedMads), 51

rowWeightedMeans, 53, 53, 54
rowWeightedMeans,ANY-method

(rowWeightedMeans), 53

rowWeightedMeans,matrix_OR_array_OR_table_OR_numeric-method

(rowWeightedMeans), 53

rowWeightedMedians, 54, 55
rowWeightedMedians,ANY-method

