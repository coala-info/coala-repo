# matrixStats: Summary of functions

##

###

# matrixStats: Summary of functions

Henrik Bengtsson on NA

## Location and scale estimators

| Estimator | Functions | Example |
| --- | --- | --- |
| Weighted sample mean | weightedMean(), colWeightedMeans(), rowWeightedMeans() | `weightedMean(x, w); rowWeightedMeans(x, w)` |
| Mean | mean2(), colMeans2(), rowMeans2() | `mean2(x); rowMeans2(x)` |
| Median | median(), colMedians(), rowMedians() | `median(x); rowMedians(x)` |
| Weighted median | weightedMedian(), colWeightedMedians(), rowWeightedMedians() | `weightedMedian(x, w); rowWeightedMedians(x, w)` |
| Sample variance | var(), colVars(), rowVars() | `var(x); rowVars(x)` |
| Weighted sample variance | weightedVar(), colWeightedVars(), rowWeightedVars() | `weightedVar(x, w), rowWeightedVars(x, w)` |
| Sample variance by n-order differences | varDiff(), colVarDiffs(), rowVarDiffs() | `varDiff(x); rowVarDiffs(x)` |
| Sample standard deviation | sd(), colSds(), rowSds() | `sd(x); rowSds(x)` |
| Weighted sample deviation | weightedSd(), colWeightedSds(), rowWeightedSds() | `weightedSd(x, w), rowWeightedSds(x, w)` |
| Sample standard deviation by n-order differences | sdDiff(), colSdDiffs(), rowSdDiffs() | `sdDiff(x); rowSdDiffs(x)` |
| Median absolute deviation (MAD) | mad(), colMads(), rowMads() | `mad(x); rowMads(x)` |
| Weighted median absolute deviation (MAD) | weightedMad(), colWeightedMads(), rowWeightedMads() | `weightedMad(x, w), rowWeightedMads(x, w)` |
| Median absolute deviation (MAD) by n-order differences | madDiff(), colMadDiffs(), rowMadDiffs() | `madDiff(x); rowMadDiffs()` |
| Quantile | quantile(), colQuantiles(), rowQuantiles() | `quantile(x, probs); rowQuantiles(x, probs)` |
| Interquartile range (IQR) | iqr(), colIQRs(), rowIQRs() | `iqr(x); rowIQRs(x)` |
| Interquartile range (IQR) by n-order differences | iqrDiff(), colIQRDiffs(), rowIQRDiffs() | `iqrDiff(x); rowIQRDiffs(x)` |
| Range | range(), colRanges(), rowRanges() | `range(x); rowRanges(x)` |
| Minimum | min(), colMins(), rowMins() | `min(x); rowMins(x)` |
| Maximum | max(), colMaxs(), rowMaxs() | `max(x); rowMaxs(x)` |

## Testing for and counting values

| Operator | Functions | Example |
| --- | --- | --- |
| Are there any missing values? | anyMissing(), colAnyMissings(), rowAnyMissings() | `anyMissing(x); rowAnyMissings(x)` |
| Does TRUE exists? | any(), colAnys(), rowAnys() | `any(x); rowAnys(x)` |
| Are all values TRUE? | all(), colAlls(), rowAlls() | `all(x); rowAlls(x)` |
| Does value exists? | anyValue(), colAnys(), rowAnys() | `anyValue(x, value); rowAnys(x, value)` |
| Do all elements have a given value? | allValue(), colAlls(), rowAlls() | `allValue(x, value); rowAlls(x, value)` |
| Number of occurrences of a value? | count(), colCounts(), rowCounts() | `count(x, value); rowCounts(x, value)` |

## Cumulative functions

| Operator | Functions | Example |
| --- | --- | --- |
| Cumulative sum | cumsum(), colCumsums(), rowCumsums() | `cumsum(x); rowCumsums(x)` |
| Cumulative product | cumprod(), colCumprods(), rowCumprods() | `cumprod(x); rowCumprods(x)` |
| Cumulative minimum | cummin(), colCummins(), rowCummins() | `cummin(x); rowCummins(x)` |
| Cumulative maximum | cummax(), colCummaxs(), rowCummaxs() | `cummax(x); rowCummaxs(x)` |

## Binning

| Estimator | Functions | Example |
| --- | --- | --- |
| Counts in disjoint bins | binCounts() | `binCounts(x, bx)` |
| Sample means (and counts) in disjoint bins | binMeans() | `binMeans(y, x, bx)` |

## Miscellaneous

| Operation | Functions | Example |
| --- | --- | --- |
| Sum | sum2(), colSums2(), rowSums2() | `sum2(x); rowSums2(x)` |
| Lagged differences | diff2(), colDiffs(), rowDiffs() | `diff2(x), rowDiffs(x)` |

---

matrixStats v1.5.0. Release: [CRAN](https://cran.r-project.org/package%3DmatrixStats), Development: [GitHub](https://github.com/HenrikBengtsson/matrixStats).