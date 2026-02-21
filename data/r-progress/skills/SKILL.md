---
name: r-progress
description: "Configurable Progress bars, they may include percentage,     elapsed time, and/or the estimated completion time. They work in     terminals, in 'Emacs' 'ESS', 'RStudio', 'Windows' 'Rgui' and the     'macOS' 'R.app'. The package also provides a 'C++' 'API', that works     with or without 'Rcpp'.</p>"
homepage: https://cloud.r-project.org/web/packages/progress/index.html
---

# r-progress

name: r-progress
description: Create and manage configurable terminal progress bars in R using the 'progress' package. Use this skill when you need to provide visual feedback for long-running loops, iterations (purrr/plyr), or data processing tasks. It supports custom formats, ETA estimation, percentage completion, and custom tokens.

# r-progress

## Overview
The `progress` package provides a flexible R6-based API for creating ASCII progress bars in the R terminal. It is highly configurable, allowing for custom characters, progress rates, and time estimates.

## Installation
```r
install.packages("progress")
```

## Core Workflow
To use a progress bar, initialize the `progress_bar` R6 class and call the `$tick()` method inside your loop or functional iteration.

### Basic Usage
```r
library(progress)

# 1. Initialize
pb <- progress_bar$new(total = 100)

# 2. Iterate and Tick
for (i in 1:100) {
  pb$tick()
  Sys.sleep(0.01)
}
```

### Immediate Display
By default, the bar appears after the first tick. To show it immediately (e.g., at 0%), call `$tick(0)` before starting the loop.
```r
pb <- progress_bar$new(total = 100)
pb$tick(0)
# ... loop starts here
```

## Customization
The `format` argument in `$new()` defines the bar's appearance using specific tokens:
- `:bar`: The progress bar itself.
- `:percent`: Percentage completion.
- `:elapsed`: Time elapsed in seconds.
- `:elapsedfull`: Elapsed time in hh:mm:ss format.
- `:eta`: Estimated time to completion.
- `:rate`: Progress rate (ticks per second).
- `:current`: Current tick count.
- `:total`: Total ticks.

### Example: Detailed Format
```r
pb <- progress_bar$new(
  format = "  Processing [:bar] :percent | ETA: :eta | Rate: :rate",
  total = 100, 
  clear = FALSE, 
  width = 60
)
```

### Custom Tokens
You can pass dynamic data to the progress bar using the `tokens` argument in `$tick()`.
```r
pb <- progress_bar$new(format = "  working on :file [:bar] :percent", total = 10)
files <- paste0("file_", 1:10, ".csv")

for (f in files) {
  pb$tick(tokens = list(file = f))
  Sys.sleep(0.1)
}
```

## Integration with Iterators

### Using purrr
```r
pb <- progress_bar$new(total = 100)
purrr::walk(1:100, ~{
  pb$tick()
  Sys.sleep(0.01)
})
```

### Using plyr
To use with `plyr`, create a progress bar generator function:
```r
progress_progress <- function(...) {
  pb <- NULL
  list(
    init = function(x, ...) pb <<- progress_bar$new(total = x, ...),
    step = function() pb$tick(),
    term = function() NULL
  )
}

plyr::l_ply(1:100, function(x) Sys.sleep(0.01), .progress = "progress")
```

## Advanced Features
- **Handling Unknown Sizes**: For downloads or streams where the total is unknown, use `:bytes` and `:rate` tokens.
- **Regression**: Use negative values in `$tick(-n)` to move the progress bar backward.
- **C++ API**: The package provides a C++ header `RProgress.h` for use in compiled code (Rcpp).

## Reference documentation
- [README.md](./references/README.md)