# Code example from 'v2_running_VERSO' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library("VERSO")
data(variants)

## -----------------------------------------------------------------------------
alpha = c(0.01,0.05)
beta = c(0.01,0.05)
head(alpha)
head(beta)

## -----------------------------------------------------------------------------
set.seed(12345)
inference = VERSO(D = variants, 
                  alpha = alpha, 
                  beta = beta, 
                  check_indistinguishable = TRUE, 
                  num_rs = 5, 
                  num_iter = 100, 
                  n_try_bs = 50, 
                  num_processes = 1, 
                  verbose = FALSE)

## -----------------------------------------------------------------------------
data(inference)
print(names(inference))

## ----fig.width=12, fig.height=8, warning=FALSE, fig.cap=""--------------------
plot(inference$phylogenetic_tree)

