# Timing methods in CellBench

Shian Su

#### 2025-10-29

# Contents

* [1 Introduction](#introduction)
* [2 Timing methods](#timing-methods)
* [3 Summary](#summary)

# 1 Introduction

CellBench provides the ability to measure the running time of pipelines. This is done using the `time_methods()` function which runs in the same way that `apply_methods()` does, with the difference that it does not run in parallel. This is an intentional design choice because running things in parallel usually results in some competition for computer resource and therefore produces less reliable or stable timings.

# 2 Timing methods

The setup for timing methods is identical to applying methods. You have a list of data and a list of functions, then you use `time_methods()` instead of `apply_methods()`.

```
library(CellBench)

# wrap a simple vector in a list
datasets <- list(
    data1 = c(1, 2, 3)
)

# use Sys.sleep in functions to simulate long-running functions
transform <- list(
    log = function(x) { Sys.sleep(0.1); log(x) },
    sqrt = function(x) { Sys.sleep(0.1); sqrt(x) }
)

# time the functions
res <- datasets %>%
    time_methods(transform)

res
```

```
## # A tibble: 2 × 3
##   data  transform timed_result
##   <fct> <fct>     <list>
## 1 data1 log       <named list [2]>
## 2 data1 sqrt      <named list [2]>
```

Where we usually have the `result` column we now have `timed_result`, this is a list of two objects: the timing object and the result. It is necessary to keep the result so that we can chain computations together.

```
res$timed_result[[1]]
```

```
## $timing
##    user  system elapsed
##   0.000   0.000   0.101
##
## $result
## [1] 0.0000000 0.6931472 1.0986123
```

As is the case with `apply_methods()`, more lists of methods can be applied and results will expand out combinatorially. The timings in this case will be cumulative over the methods applied.

```
transform2 <- list(
    plus = function(x) { Sys.sleep(0.1); x + 1 },
    minus = function(x) { Sys.sleep(0.1); x - 1 }
)

res2 <- datasets %>%
    time_methods(transform) %>%
    time_methods(transform2)

res2
```

```
## # A tibble: 4 × 4
##   data  transform transform2 timed_result
##   <fct> <fct>     <fct>      <list>
## 1 data1 log       plus       <named list [2]>
## 2 data1 log       minus      <named list [2]>
## 3 data1 sqrt      plus       <named list [2]>
## 4 data1 sqrt      minus      <named list [2]>
```

The class of results from `time_methods()` is `benchmark_timing_tbl`. Once all methods have been applied, the result may be discarded using `unpack_timing()` and the object can be transformed into a more flat `tbl` representation. See `?proc_time` for an explanation of what `user`, `system` and `elapsed` refer to.

The timing values have been converted to `Duration` objects from the `lubridate` package, these behave as numeric measurements in seconds but have nicer printing properties (try `lubridate::duration(1000, units = "seconds")`).

```
# discard results and expand out timings into columns
res2 %>%
    unpack_timing()
```

```
## # A tibble: 4 × 6
##   data  transform transform2 user       system     elapsed
##   <fct> <fct>     <fct>      <Duration> <Duration> <Duration>
## 1 data1 log       plus       0.002s     0s         0.203s
## 2 data1 log       minus      0.002s     0s         0.203s
## 3 data1 sqrt      plus       0.004s     0s         0.204s
## 4 data1 sqrt      minus      0.004s     0s         0.204s
```

Alternatively the timing information can be discarded and a `benchmark_tbl` can be produced using `strip_timing()`.

```
# discard timings and produce benchmark_tbl object
res2 %>%
    strip_timing()
```

```
## # A tibble: 4 × 4
##   data  transform transform2 result
##   <fct> <fct>     <fct>      <list>
## 1 data1 log       plus       <dbl [3]>
## 2 data1 log       minus      <dbl [3]>
## 3 data1 sqrt      plus       <dbl [3]>
## 4 data1 sqrt      minus      <dbl [3]>
```

# 3 Summary

CellBench provides a simple way to measure the running times of pipelines from various combinations of methods. This is done with the `time_methods()` function which is called in the same way as `apply_methods()` and has the same chaining properties. The resultant object can be transformed in two useful ways, as a flat `tibble` with timings expanded out as columns and discarding the results, or as a `benchmark_tbl` with the results as a `list-column` and discarding the timings.