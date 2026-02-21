# Code example from 'example_logistic' vignette. See references/ for full tutorial.

## ----message=FALSE, warning=FALSE---------------------------------------------
library(graper)
library(ggplot2)

## -----------------------------------------------------------------------------
set.seed(123)
data <- makeExampleData(n=200, p=320, g=4,
                        pis=c(0.05, 0.1, 0.05, 0.1),
                        gammas=c(0.1, 0.1, 10, 10),
                        response="bernoulli")
# training data set
Xtrain <- data$X[1:100, ]
ytrain <- data$y[1:100]

# annotations of features to groups
annot <- data$annot

# test data set
Xtest <- data$X[101:200, ]
ytest <- data$y[101:200]

## -----------------------------------------------------------------------------
fit <- graper(Xtrain, ytrain, annot, verbose=FALSE,
            family="binomial", calcELB=FALSE)
fit

## -----------------------------------------------------------------------------
plotPosterior(fit, "gamma", gamma0=data$gammas)
plotPosterior(fit, "pi", pi0=data$pis)

## -----------------------------------------------------------------------------
# get coefficients (without the intercept)
beta <- coef(fit, include_intercept=FALSE)
# beta <- fit$EW_beta

# plot estimated versus true beta
qplot(beta, data$beta)

## -----------------------------------------------------------------------------
# get intercept
intercept <- fit$intercept

## -----------------------------------------------------------------------------
# get estimated posterior inclusion probabilities per feature
pips <- getPIPs(fit)

## -----------------------------------------------------------------------------
preds <- predict(fit, Xtest)

## -----------------------------------------------------------------------------
sessionInfo()

