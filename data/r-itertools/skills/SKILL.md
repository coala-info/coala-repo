---
name: r-itertools
description: "Various tools for creating iterators, many patterned after         functions in the Python itertools module, and others patterned         after functions in the 'snow' package.</p>"
homepage: https://cloud.r-project.org/web/packages/itertools/index.html
---

# r-itertools

name: r-itertools
description: Advanced iterator tools for R, providing Python-style iteration (zip, product, enumerate) and memory-efficient chunking. Use when processing large datasets that exceed memory, performing parallel computations with the foreach package, or creating complex looping logic without materializing full objects.

# r-itertools

## Overview
The `itertools` package extends the `iterators` framework in R. It provides a variety of functions to create and manipulate iterators, many of which are inspired by Python's `itertools` module. These tools allow for memory-efficient data processing by yielding elements one at a time rather than loading entire datasets into memory.

## Installation
To install the package from CRAN:
```R
install.packages("itertools")
```

## Core Functions

### Python-Inspired Iterators
- `ienumerate(it)`: Returns an iterator that yields a list containing an index and the value from the original iterator.
- `izip(...)`: Combines multiple iterators into one that yields a list of elements, one from each input.
- `iproduct(...)`: Returns an iterator representing the Cartesian product of the input iterators.
- `irepeat(x, times)`: Yields the value `x` repeatedly for a specified number of times (or infinitely).
- `icount(start, step)`: Yields an infinite sequence of numbers starting at `start`.
- `icycle(it)`: Cycles through the elements of an iterator repeatedly.
- `ifilter(pred, it)`: Yields only elements from the iterator for which the predicate function returns `TRUE`.

### Chunking and Splitting
- `ichunk(it, size)`: Groups elements from an iterator into chunks of a specified size.
- `isplit(x, f, ...)`: Returns an iterator that yields pieces of `x` defined by the factor `f`. This is a memory-efficient alternative to `split()`.
- `iwrite(it, file, ...)`: Iterates through an object and writes the elements to a file.

### Utility Functions
- `ihasNext(it)`: Wraps an iterator to provide a `hasNext` method, allowing you to check if more elements are available before calling `nextElem`.
- `iapply(X, MARGIN, ...)`: An iterator version of the `apply` function.
- `ilapply(it, FUN, ...)`: An iterator version of `lapply`.

## Common Workflows

### Using with foreach
`itertools` is frequently used to provide data to `foreach` loops, especially for parallel processing.
```R
library(foreach)
library(itertools)

# Process a large vector in chunks of 100 to reduce overhead
foreach(chunk = ichunk(1:1000, 100), .combine = 'c') %dopar% {
  sum(chunk)
}
```

### Memory-Efficient Splitting
Instead of using `split(df, df$group)`, which creates a full list in memory, use `isplit`:
```R
it <- isplit(large_df, large_df$group_column)
while(hasNext(it)) {
  piece <- nextElem(it)
  # Process piece
}
```

### Zipping Iterators
Combine multiple data sources element-wise:
```R
it <- izip(a = 1:3, b = c('x', 'y', 'z'))
nextElem(it) # returns list(a=1, b='x')
```

## Tips and Best Practices
- **Always use ihasNext**: When manually consuming an iterator with a `while` loop, wrap the iterator in `ihasNext(it)` to avoid catching "StopIteration" errors.
- **Lazy Evaluation**: Remember that iterators are lazy. Calculations are only performed when `nextElem` is called.
- **Combining with iterators package**: `itertools` depends on the `iterators` package. Use `iter(obj)` to convert standard R objects into basic iterators before applying `itertools` transformations if necessary.

## Reference documentation
- [itertools: Iterator Tools](./references/home_page.md)