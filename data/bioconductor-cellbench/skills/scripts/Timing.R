# Code example from 'Timing' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
library(CellBench)

## -----------------------------------------------------------------------------
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

## -----------------------------------------------------------------------------
res$timed_result[[1]]

## -----------------------------------------------------------------------------
transform2 <- list(
    plus = function(x) { Sys.sleep(0.1); x + 1 },
    minus = function(x) { Sys.sleep(0.1); x - 1 }
)

res2 <- datasets %>%
    time_methods(transform) %>%
    time_methods(transform2)

res2

## -----------------------------------------------------------------------------
# discard results and expand out timings into columns
res2 %>%
    unpack_timing()

## -----------------------------------------------------------------------------
# discard timings and produce benchmark_tbl object
res2 %>%
    strip_timing()

