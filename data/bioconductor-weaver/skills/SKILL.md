---
name: bioconductor-weaver
description: This tool provides caching mechanisms for R Sweave documents to speed up the processing of computationally expensive code chunks. Use when user asks to optimize Sweave document compilation, cache R code results in Rnw files, or manage dependencies between code chunks using the weaver driver.
homepage: https://bioconductor.org/packages/release/bioc/html/weaver.html
---


# bioconductor-weaver

name: bioconductor-weaver
description: Extensions for the Sweave document processing system in R, specifically providing caching mechanisms for computationally expensive code chunks. Use this skill when a user needs to optimize Rnw (Sweave) document compilation by caching results, managing dependencies between code chunks, or using the weaver driver instead of the default Sweave driver.

# bioconductor-weaver

## Overview
The `weaver` package is an extension of the standard R `utils` Sweave framework. Its primary purpose is to provide expression-level caching. When processing large or computationally intensive Sweave documents, `weaver` tracks dependencies and caches the results of R expressions. If an expression or its dependencies haven't changed, `weaver` loads the result from the cache rather than re-evaluating the code, significantly speeding up subsequent document compilations.

## Typical Workflow

### 1. Enabling Caching in Rnw Documents
To use the caching feature, you must set the `cache=TRUE` option in the header of the code chunks you wish to cache.

```latex
<<myExpensiveChunk, cache=TRUE>>=
# This code will be cached
data <- read.large.file("data.csv")
result <- perform.heavy.computation(data)
@
```

### 2. Processing Documents with the Weaver Driver
Instead of using the default Sweave driver, you must explicitly specify `weaver()` as the driver when calling the `Sweave` function.

```r
library(weaver)

# Process a document using the weaver driver
Sweave("my_document.Rnw", driver = weaver())
```

### 3. Controlling Cache Usage
You can globally disable the cache during a specific run (e.g., for a final clean build) without modifying the `.Rnw` file by passing the `use.cache` argument.

```r
# Force re-computation of all chunks regardless of cache status
Sweave("my_document.Rnw", driver = weaver(), use.cache = FALSE)
```

## Important Considerations and Tips

### Side Effects
Caching in `weaver` works at the expression level but **does not capture side effects**.
- **Avoid** plotting, printing, defining S4 classes/methods, or setting global `options()` inside a cached chunk.
- If a chunk has `cache=TRUE`, treat it as if `results=hide` is also set, as printed output will not be captured in the final document upon cache reload.

### Dependency Tracking
`weaver` uses the `codetools` package to detect dependencies.
- If you change a variable in an earlier chunk that a later cached chunk depends on, `weaver` will attempt to detect this and invalidate the cache for the affected expressions.
- **Warning:** Dependency detection is not perfect. If you make significant structural changes to your data or logic, it is safest to manually clear the cache.

### Cache Management
- **Cache Location:** By default, the cache is stored in a directory named `r_env_cache` in your current working directory.
- **Clearing Cache:** To completely reset the cache, delete the `r_env_cache` directory.
- **Debugging:** `weaver` generates a log file named `weaver_debug_log.txt` in the working directory. Check this file to see how `weaver` is interpreting dependencies.
- **Randomness:** Be careful with random number generation (e.g., `rnorm`). If cached, the same "random" values will be reloaded every time rather than generating a new stream.

## Reference documentation
- [How to use weaver for Sweave document processing](./references/weaver_howTo.md)