# Code example from 'DataManipulation' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
library(CellBench)
library(dplyr)
library(purrr)

## -----------------------------------------------------------------------------
library(CellBench)
datasets <- list(
    random_mat1 = matrix(runif(100), 10, 10),
    random_mat2 = matrix(runif(100), 10, 10)
)

cor_method <- list(
    pearson = function(x) { cor(x, method = "pearson") },
    kendall = function(x) { cor(x, method = "kendall") }
)

res <- datasets %>%
    apply_methods(cor_method)

## -----------------------------------------------------------------------------
class(res)

## -----------------------------------------------------------------------------
res[1:2, ]

## -----------------------------------------------------------------------------
library(dplyr)
res %>%
    filter(cor_method == "pearson")

## -----------------------------------------------------------------------------
cor_method <- list(
    spearman = function(x) cor(x, method = "spearman")
)

res2 <- datasets %>%
    apply_methods(cor_method)

res2

## -----------------------------------------------------------------------------
rbind(res, res2)

## -----------------------------------------------------------------------------
class(res$result)

## ----eval = FALSE-------------------------------------------------------------
# # this code will fail
# res %>%
#     mutate(exp_result = exp(result))

## -----------------------------------------------------------------------------
res %>%
    mutate(exp_result = lapply(result, exp)) %>%
    mutate(sum_of_exp = unlist(lapply(exp_result, sum)))

## -----------------------------------------------------------------------------
library(tibble)

df1 <- data.frame(
    little = c(1, 3),
    big = c(5, 7)
)

df1

## -----------------------------------------------------------------------------
df2 <- data.frame(
    little = c(2, 4),
    big = c(6, 8)
)

df2

## -----------------------------------------------------------------------------
tbl <- tibble(
    type = c("odds", "evens"),
    values = list(df1, df2)
)

tbl

## -----------------------------------------------------------------------------
tidyr::unnest(tbl)

## ----result = 'hide'----------------------------------------------------------
# a numeric literal
1

# a character literal
"a"

# a function literal
function(x) { print(x) }

## ----result = 'hide'----------------------------------------------------------
# assigning numeric literal
x <- 1

# assigning character literal
x <- "a"

# assigning function literal
f <- function(x) { print(x) }

## ----result = 'hide'----------------------------------------------------------
# assigning numeric literal
x <- 1
y <- x # y = 1

# assigning character literal
x <- "a"
y <- x # y = "a"

# assigning function literal
f <- function(x) { print(x) }
g <- f # g = function(x) { print(x) }

## -----------------------------------------------------------------------------
# function to add two things
plus <- function(x, y) { x + y }

# function that adds 2 to x
plus_two <- function(x) { plus(x, y = 2) }

plus_two(1)

## -----------------------------------------------------------------------------
library(purrr)

plus_two <- partial(plus, y = 2)

plus_two(1)

## -----------------------------------------------------------------------------
# define a function that multiplies 3 numbers together
g <- function(x, y, z) {
    x * y * z
}

g(1, 2, 3)

## -----------------------------------------------------------------------------
# create a list of functions with the second and third values partially applied
# all combinations of y and z are generates, resulting in a list of 4 functions
g_list <- fn_arg_seq(g, y = c(1, 2), z = c(3, 4))

# apply each of the functions in the list to the value 1
lapply(g_list, function(func) { func(x = 1) })

## ----eval = FALSE-------------------------------------------------------------
# # initialise the CellBench cache
# cellbench_cache_init()
# 
# # dummy simulation of a slow function
# f <- function(x) {
#     Sys.sleep(2)
#     return(x)
# }
# 
# # create the memoised version of the function
# cached_f <- cache_method(f)
# 
# # running the first time will be slow
# cached_f(1)
# 
# # running the second time will be fast
# cached_f(1)

