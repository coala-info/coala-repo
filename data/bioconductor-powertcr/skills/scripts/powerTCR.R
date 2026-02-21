# Code example from 'powerTCR' vignette. See references/ for full tutorial.

## ----echo = 4:5, message = FALSE, warning = FALSE-----------------------------
# This installs packages from BioConductor
# if (!requireNamespace("BiocManager", quietly=TRUE))
    # install.packages("BiocManager")
# BiocManager::install("powerTCR")
library(powerTCR)
data("repertoires")

## -----------------------------------------------------------------------------
str(repertoires)

## ----warning = FALSE----------------------------------------------------------
# This will loop through our list of sample repertoires,
# and store a fit in each
fits <- list()
for(i in seq_along(repertoires)){
    # Choose a sequence of possible u for your model fit
    # Ideally, you want to search a lot of thresholds, but for quick
    # computation, we are only going to test 4
    thresholds <- unique(round(quantile(repertoires[[i]], c(.75,.8,.85,.9))))
    
    fits[[i]] <- fdiscgammagpd(repertoires[[i]], useq = thresholds,
                               shift = min(repertoires[[i]]))
}
names(fits) <- names(repertoires)

## -----------------------------------------------------------------------------
# You could also look at the first sample by typing fits[[1]]
fits$samp1

## -----------------------------------------------------------------------------
# Grab mles of fits:
get_mle(fits)

# Grab negative log likelihoods of fits
get_nllh(fits)

## -----------------------------------------------------------------------------
desponds_fits <- list()
for(i in seq_along(repertoires)){
    desponds_fits[[i]] <- fdesponds(repertoires[[i]])
}
names(desponds_fits) <- names(repertoires)
desponds_fits$samp1

## -----------------------------------------------------------------------------
# The number of clones in each sample
n1 <- length(repertoires[[1]])
n2 <- length(repertoires[[2]])

# Grids of quantiles to check
# (you want the same number of points as were observed in the sample)
q1 <- seq(n1/(n1+1), 1/(n1+1), length.out = n1)
q2 <- seq(n2/(n2+1), 1/(n2+1), length.out = n2)

# Compute the value of fitted distributions at grid of quantiles
theor1 <- qdiscgammagpd(q1, fits[[1]])
theor2 <- qdiscgammagpd(q2, fits[[2]])

## ----fig.wide=TRUE, echo=2:7--------------------------------------------------
par(mfrow = c(1,2))
plot(log(repertoires[[1]]), log(seq_len(n1)), pch = 16, cex = 2,
     xlab = "log clone size", ylab = "log rank", main = "samp1")
points(log(theor1), log(seq_len(n1)), pch = 'x', col = "darkcyan")

plot(log(repertoires[[2]]), log(seq_len(n2)), pch = 16, cex = 2,
     xlab = "log clone size", ylab = "log rank", main = "samp2")
points(log(theor2), log(seq_len(n2)), pch = 'x', col = "chocolate")

## -----------------------------------------------------------------------------
# Simulate 3 sampled repertoires
set.seed(123)
s1 <- rdiscgammagpd(1000, shape = 3, rate = .15, u = 25, sigma = 15,
                    xi = .5, shift = 1)
s2 <- rdiscgammagpd(1000, shape = 3.1, rate = .14, u = 26, sigma = 15,
                    xi = .6, shift = 1)
s3 <- rdiscgammagpd(1000, shape = 10, rate = .3, u = 45, sigma = 20,
                    xi = .7, shift = 1)

## -----------------------------------------------------------------------------
bad <- rdiscgammagpd(1000, shape = 1, rate = 2, u = 25, sigma = 10,
                     xi = .5, shift = 1, phi = .2)
plot(log(sort(bad, decreasing = TRUE)), log(seq_len(1000)), pch = 16,
     xlab = "log clone size", ylab = "log rank", main = "bad simulation")

## -----------------------------------------------------------------------------
# Fit model to the data at the true thresholds
sim_fits <- list("s1" = fdiscgammagpd(s1, useq = 25),
                 "s2" = fdiscgammagpd(s2, useq = 26),
                 "s3" = fdiscgammagpd(s3, useq = 45))

# Compute the pairwise JS distance between 3 fitted models
grid <- min(c(s1,s2,s3)):10000
distances <- get_distances(sim_fits, grid, modelType="Spliced")

## -----------------------------------------------------------------------------
distances

## ----fig.small=TRUE-----------------------------------------------------------
clusterPlot(distances, method = "ward.D")

## ----echo=2:3, message = FALSE, warning = FALSE-------------------------------
library(vegan)
get_diversity(sim_fits)

## -----------------------------------------------------------------------------
boot <- get_bootstraps(fits, resamples = 5, cores = 1, gridStyle = "copy")

## ----echo = 3:5, message = FALSE, warning = FALSE-----------------------------
library(magrittr)
library(purrr)
mles <- get_mle(boot[[1]])
xi_CI <- map(mles, 'xi') %>% 
    unlist %>%
    quantile(c(.025,.5,.975))
xi_CI

