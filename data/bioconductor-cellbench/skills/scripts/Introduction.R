# Code example from 'Introduction' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
library(CellBench)
library(limma)
library(dplyr)
library(purrr)

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.retina = 1
)

## -----------------------------------------------------------------------------
library(CellBench)
library(limma)

datasets <- list(
    sample_10x = readRDS(cellbench_file("10x_sce_sample.rds"))
)

norm_method <- list(
    none = counts,
    cpm = function(x) t(t(1e6 * counts(x)) / colSums(counts(x)))
)

transform <- list(
    none = identity,
    log2 = function(x) log2(x+1)
)

## -----------------------------------------------------------------------------
res1 <- datasets %>%
    apply_methods(norm_method)

res1

## -----------------------------------------------------------------------------
res2 <- res1 %>%
    apply_methods(transform)

res2

## -----------------------------------------------------------------------------
# generate colour values from cell line information
cell_line <- factor(colData(datasets$sample_10x)$cell_line)
cell_line_col <- c("red", "blue", "green")[cell_line]

collapsed_res <- res2 %>%
    pipeline_collapse()

collapsed_res

## ----fig.height = 9, fig.width = 8--------------------------------------------
par(mfrow = c(2, 2)) # declare 2x2 plotting grid

# loop through row of summarised pipeline table
for (i in 1:nrow(collapsed_res)) {
    title <- collapsed_res$pipeline[i]
    expr_mat <- collapsed_res$result[[i]] # note the use of [[]] due to list
    
    limma::plotMDS(
        expr_mat,
        main = title,
        pch = 19, # draw circles rather than label name
        col = cell_line_col
    )
}

par(mfrow = c(1, 1)) # undo plotting grid for future plots

## ----eval = FALSE-------------------------------------------------------------
# # loading the individual sets of data
# sc_data <- load_sc_data()
# mrna_mix_data <- load_mrna_mix_data()
# cell_mix_data <- load_cell_mix_data()
# 
# # loading all datasets
# all_data <- load_all_data()

## ----eval = FALSE-------------------------------------------------------------
# # removes all locally cached CellBench datasets
# clear_cached_datasets()

## ----eval = FALSE-------------------------------------------------------------
# # the following two statements are equivalent
# f(x)
# x %>% f()
# 
# # as are these
# f(x, y)
# x %>% f(y)
# 
# # and these
# h(g(f(x)))
# x %>% f() %>% g() %>% h()
# 
# # or these
# h(g(f(x, a), b), c)
# x %>% f(a) %>% g(b) %>% h(c)

## -----------------------------------------------------------------------------
x <- list(
    a = 1,
    b = 2,
    c = 3
)

lapply(x, sqrt)

## ----result = 'hide'----------------------------------------------------------
sample_10x <- readRDS(cellbench_file("10x_sce_sample.rds"))

# even with a single dataset we need to construct a list
datasets <- list(
    sample_10x = sample_10x
)

# we can add more datasets to the pipeline by adding to the list
# here we have two datasets that are random samplings of the genes in the 10x
# sample data
datasets <- list(
    subsample1_10x = sample_genes(sample_10x, n = 1000),
    subsample2_10x = sample_genes(sample_10x, n = 1000)
)

# could have been any other kind of object as long as they are consistent
datasets <- list(
    set1 = matrix(rnorm(500, mean = 2, sd = 1), ncol = 5, nrow = 100),
    set2 = matrix(rnorm(500, mean = 2, sd = 1), ncol = 5, nrow = 100)
)

## ----result = 'hide'----------------------------------------------------------
# counts is a function that can be run with counts(x) here it is named 
# "none" as it denotes the lack of normalisation
norm_method <- list(
    none = counts,
    cpm = function(x) t(t(1e6 * counts(x)) / colSums(counts(x)))
)

# "identity" is a useful function that simply returns its input 
# it allows the comparison between applying and not applying a method
transform <- list(
    none = identity,
    log2 = function(x) log2(x+1)
)

## ----result = 'hide'----------------------------------------------------------
# using anonymous function wrappers
metric <- list(
    mean = function(x) { mean(x, na.rm = TRUE) },
    sd = function(x) { sd(x, na.rm = TRUE) }
)

# using purrr partial function
partial <- purrr::partial # explicit namespacing to avoid ambiguity
metric <- list(
    mean = partial(mean, na.rm = TRUE),
    sd = partial(sd, na.rm = TRUE)
)

# example use with kmeans
clustering <- list(
    kmeans_4 = partial(kmeans, centers = 4),
    kmeans_5 = partial(kmeans, centers = 5),
    kmeans_6 = partial(kmeans, centers = 6)
)

## -----------------------------------------------------------------------------
class(res2)

## -----------------------------------------------------------------------------
res2 %>% dplyr::filter(norm_method == "cpm")

## -----------------------------------------------------------------------------
# datasets
datasets <- list(
    sample_10x = readRDS(cellbench_file("10x_sce_sample.rds"))
)

# first set of methods in pipeline
norm_method <- list(
    none = counts,
    cpm = function(x) t(t(1e6 * counts(x)) / colSums(counts(x)))
)

# second set of methods in pipeline
transform <- list(
    none = identity,
    log2 = function(x) log2(x+1)
)

datasets %>%
    apply_methods(norm_method)

## -----------------------------------------------------------------------------
datasets %>%
    apply_methods(norm_method) %>%
    apply_methods(transform)

## ----eval = FALSE-------------------------------------------------------------
# # set cellbench to use 4 threads
# set_cellbench_threads(4)

## ----eval = FALSE-------------------------------------------------------------
# set_cellbench_cache_path(".CellBenchCache")
# methods <- list(
#     method1 = cache_method(method1),
#     method2 = cache_method(method2)
# )

## ----eval = FALSE-------------------------------------------------------------
# # clears the cache set by set_cellbench_cache_path() in the same session
# clear_cellbench_cache()

## -----------------------------------------------------------------------------
# f is a function of three parameters
f <- function(x, y, z) {
    x + y + z
}

# f_list is a list of functions with two of the parameters pre-filled
f_list <- fn_arg_seq(f, y = 1:2, z = 3:4)

f_list

## -----------------------------------------------------------------------------
names(f_list)[1]
g <- f_list[[1]]
g(10)

names(f_list)[2]
h <- f_list[[2]]
h(20)

