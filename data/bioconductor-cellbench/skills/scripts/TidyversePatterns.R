# Code example from 'TidyversePatterns' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(purrr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(CellBench)

## -----------------------------------------------------------------------------
library(CellBench)
library(purrr)

# function to raise number to a power
pow <- function(x, n) {
    x^n
}

pow2 <- partial(pow, n = 2)
pow3 <- partial(pow, n = 3)

pow2(2)
pow3(2)

## ----eval = FALSE-------------------------------------------------------------
# pow2 <- function(x) {
#     x^2
# }
# 
# pow3 <- function(x) {
#     x^3
# }

## ----eval = FALSE-------------------------------------------------------------
# pow <- function(x, n) {
#     x^n
# }
# 
# pow2 <- function(x) {
#     pow(x, 2)
# }
# 
# pow3 <- function(x) {
#     pow(x, 3)
# }

## -----------------------------------------------------------------------------
# find the maximum absolute value
max_absolute <- compose(max, abs)

max_absolute(rnorm(100))

## ----eval = FALSE-------------------------------------------------------------
# method1 <- function(x) {
#     x <- normalise(x)
#     method_func1(x)
# }
# 
# method2 <- function(x) {
#     method_func2(x)
# }
# 
# method3 <- function(x) {
#     x <- normalise(x)
#     method_func3(x)
# }

## ----eval = FALSE-------------------------------------------------------------
# # identity simply returns its argument, useful here for code consistency
# method1 <- compose(method_func1, normalise)
# method2 <- compose(method_func2, identity)
# method3 <- compose(method_func3, normalise)

## -----------------------------------------------------------------------------
x <- list(1, 2, 3)

map(x, function(x) { x * 2 })

## -----------------------------------------------------------------------------
# list of random values from different distributions
x <- list(
    rpois(100, lambda = 5),
    rpois(100, lambda = 5),
    rgamma(100, shape = 5),
    rgamma(100, shape = 5)
)

# list of additional parameters
y <- list(
    "mean",
    "median",
    "mean",
    "median"
)

# function that takes values and a mode argument
centrality <- function(x, mode = c("mean", "median")) {
    mode <- match.arg(mode)
    
    if (mode == "mean") {
       mean = mean(x)
    } else if (mode == "median") {
       median = median(x)
    }
}

# using map2 to apply function to two lists
map2(x, y, centrality)

## -----------------------------------------------------------------------------
library(dplyr)
# list of data
datasets <- list(
    set1 = rnorm(500, mean = 2, sd = 1),
    set2 = rnorm(500, mean = 1, sd = 2)
)

# list of functions
add_noise <- list(
    none = identity,
    add_bias = function(x) { x + 1 }
)

res <- apply_methods(datasets, add_noise)
class(res)
res

## -----------------------------------------------------------------------------
# filtering rows to only data from set 1
res %>%
    filter(data == "set1")

# filtering rows to only add_bias method
res %>%
    filter(add_noise == "add_bias")

# mutating data column to prepend "data" to data set names
res %>%
    mutate(data = paste0("data", data))

## -----------------------------------------------------------------------------
metric <- list(
    mean = mean,
    median = median
)

# simply applying the metrics results in a single column
res %>%
    apply_methods(metric)

# spread metrics across columns
res %>%
    apply_methods(metric) %>%
    spread(metric, result)

## -----------------------------------------------------------------------------
library(tidyr)
library(ggplot2)

# I prefer my own theme for ggplot2, following theme code is optional
theme_set(theme_bw() + theme(
    plot.title = element_text(face = "plain", size = rel(20/12),
                              hjust = 1/2, margin = margin(t = 10, b = 20)),
    axis.text = element_text(size = rel(14/12)),
    strip.text.x = element_text(size = rel(16/12)),
    axis.title = element_text(size = rel(16/12))
))

scale_colour_discrete <- function(...) scale_colour_brewer(..., palette="Set1")
scale_fill_discrete <- function(...) scale_fill_brewer(... , palette="Set1")

## -----------------------------------------------------------------------------
# pipeline collapse constructs a single string from the pipeline steps,
# unnest expands the list-column of results, transforming the result 
# into a flat table.
collapsed_res <- pipeline_collapse(res) %>%
    unnest()

ggplot(collapsed_res, aes(x = pipeline, y = result)) +
    geom_boxplot()

## -----------------------------------------------------------------------------
# remember that we have to unnest the data before it's appropriate
# for plotting
ggplot(unnest(res), aes(x = add_noise, y = result)) +
    geom_boxplot() +
    facet_grid(~data)

