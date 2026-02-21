# Code example from 'rnd_effects' vignette. See references/ for full tutorial.

## ----knitr, echo=FALSE, results='hide'------------------------------------------------------------
library("knitr")
opts_chunk$set(
  tidy = FALSE, dev = "pdf", fig.show = "hide",
  fig.width = 4, fig.height = 4.5,
  message = FALSE, warning = FALSE
)

## ----options, results="hide", echo=FALSE--------------------------------------
options(digits = 3, width = 80, prompt = " ", continue = " ")
opts_chunk$set(comment = NA, fig.width = 7, fig.height = 7)

## ----code, cache=TRUE---------------------------------------------------------
library("variancePartition")
library("lme4")
library("r2glmm")

set.seed(1)

N <- 1000
beta <- 3
alpha <- c(1, 5, 7)

# generate 1 fixed variable and 1 random variable with 3 levels
data <- data.frame(X = rnorm(N), Subject = sample(c("A", "B", "C"), 100, replace = TRUE))

# simulate variable
# y = X\beta + Subject\alpha + \sigma^2
data$y <- data$X * beta + model.matrix(~ data$Subject) %*% alpha + rnorm(N, 0, 1)

# fit model
fit <- lmer(y ~ X + (1 | Subject), data, REML = FALSE)

# calculate variance fraction using variancePartition
# include the total sum in the denominator
frac <- calcVarPart(fit)
frac

# the variance fraction excluding the random effect from the denominator
# is the same as from r2glmm
frac[["X"]] / (frac[["X"]] + frac[["Residuals"]])

# using r2glmm
r2beta(fit)

## ----resetOptions, results="hide", echo=FALSE---------------------------------
options(prompt = "> ", continue = "+ ")

## ----session, echo=FALSE------------------------------------------------------
sessionInfo()

