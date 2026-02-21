# Code example from 'example_linear' vignette. See references/ for full tutorial.

## ----message=FALSE, warning=FALSE---------------------------------------------
library(graper)
library(ggplot2)

## -----------------------------------------------------------------------------
set.seed(123)
data <- makeExampleData(n = 500, p=800, g=4,
                        pis=c(0.05, 0.1, 0.05, 0.1),
                        gammas=c(0.1, 0.1, 10, 10))
# training data set
Xtrain <- data$X[1:400, ]
ytrain <- data$y[1:400]

# annotations of features to groups
annot <- data$annot

# test data set
Xtest <- data$X[401:500, ]
ytest <- data$y[401:500]

## -----------------------------------------------------------------------------
fit <- graper(Xtrain, ytrain, annot,
            n_rep=3, verbose=FALSE, th=0.001)
fit

## -----------------------------------------------------------------------------
plotELBO(fit)

## -----------------------------------------------------------------------------
plotPosterior(fit, "gamma", gamma0=data$gammas, range=c(0, 20))
plotPosterior(fit, "pi", pi0=data$pis)

## -----------------------------------------------------------------------------
# get coefficients (without the intercept)
beta <- coef(fit, include_intercept=FALSE)
# beta <- fit$EW_beta

# plot estimated versus true beta
qplot(beta, data$beta) +
    coord_fixed() + theme_bw()

## -----------------------------------------------------------------------------
# get intercept
intercept <- fit$intercept

## -----------------------------------------------------------------------------
# get estimated posterior inclusion probabilities per feature
pips <- getPIPs(fit)

# plot pips for zero versus non-zero features
df <- data.frame(pips = pips,
                nonzero = data$beta != 0)
ggplot(df, aes(x=nonzero, y=pips, col=nonzero)) +
    geom_jitter(height=0, width=0.2) +
    theme_bw() + ylab("Posterior inclusion probability")

## -----------------------------------------------------------------------------
plotGroupPenalties(fit)

## -----------------------------------------------------------------------------
preds <- predict(fit, Xtest)
qplot(preds, ytest) +
    coord_fixed() + theme_bw()

## -----------------------------------------------------------------------------
sessionInfo()

