# Code example from 'onlineFDR' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

knitr::include_graphics("stream-diagram.png")

## -----------------------------------------------------------------------------
sample.df <- data.frame(
  id = c('A15432', 'B90969', 'C18705', 'B49731', 'E99902',
         'C38292', 'A30619', 'D46627', 'E29198', 'A41418',
         'D51456', 'C88669', 'E03673', 'A63155', 'B66033'),
  date = as.Date(c(rep("2014-12-01",3),
                   rep("2015-09-21",5),
                   rep("2016-05-19",2),
                   "2016-11-12",
                   rep("2017-03-27",4))),
  pval = c(2.90e-14, 0.00143, 0.06514, 0.00174, 0.00171,
           3.61e-05, 0.79149, 0.27201, 0.28295, 7.59e-08,
           0.69274, 0.30443, 0.000487, 0.72342, 0.54757))

## -----------------------------------------------------------------------------
library(onlineFDR)

set.seed(1)
LOND_results <- LOND(sample.df)
LOND_results

## -----------------------------------------------------------------------------
sum(LOND_results$R)

## -----------------------------------------------------------------------------
set.seed(1)
LORD_results <- LORD(sample.df)

set.seed(1)
Bonf_results <- Alpha_spending(sample.df) # Bonferroni-like test

x <- seq_len(nrow(LOND_results))
par(mar=c(5.1, 4.1, 4.1, 9.1))

plot(x, log(LOND_results$alphai), ylim = c(-9.5, -2.5), type = 'l',
     col = "green", xlab = "Index", ylab = "log(alphai)", panel.first = grid())

lines(x, log(LORD_results$alphai), col = "blue") # LORD
lines(x, log(Bonf_results$alphai), col = "red") # Bonferroni-like test
lines(x, rep(log(0.05),length(x)), col = "purple") # Unadjusted

legend("right", legend = c("Unadjusted", "Bonferroni", "LORD", "LOND"),
       col = c("purple", "red", "blue", "green"), lty = rep(1,4),
       inset = c(-0.35,0), xpd = TRUE)



## -----------------------------------------------------------------------------
# Initial experimental data
sample.df <- data.frame(
  id = c('A15432', 'B90969', 'C18705'),
  date = as.Date(c(rep("2014-12-01",3))),
  pval = c(2.90e-14, 0.06743, 0.01514))

set.seed(1)
LOND_results <- LOND(sample.df)

## -----------------------------------------------------------------------------
# After you've completed more experiments
sample.df <- data.frame(
  id = c('A15432', 'B90969', 'C18705', 'B49731', 'E99902',
         'C38292', 'A30619', 'D46627', 'E29198', 'A41418',
         'D51456', 'C88669', 'E03673', 'A63155', 'B66033'),
  date = as.Date(c(rep("2014-12-01",3),
                   rep("2015-09-21",5),
                   rep("2016-05-19",2),
                   "2016-11-12",
                   rep("2017-03-27",4))),
  pval = c(2.90e-14, 0.06743, 0.01514, 0.08174, 0.00171,
           3.61e-05, 0.79149, 0.27201, 0.28295, 7.59e-08,
           0.69274, 0.30443, 0.000487, 0.72342, 0.54757))

set.seed(1)
LOND_results <- LOND(sample.df)

## -----------------------------------------------------------------------------
sample.df <- data.frame(
  id = c('A15432', 'B90969', 'C18705', 'B49731', 'E99902',
         'C38292', 'A30619', 'D46627', 'E29198', 'A41418',
         'D51456', 'C88669', 'E03673', 'A63155', 'B66033'),
  pval = c(2.90e-08, 0.06743, 0.01514, 0.08174, 0.00171,
           3.60e-05, 0.79149, 0.27201, 0.28295, 7.59e-08,
           0.69274, 0.30443, 0.00136, 0.72342, 0.54757),
  batch = c(rep(1,5), rep(2,6), rep(3,4)))

batchprds_results <- BatchPRDS(sample.df)

## -----------------------------------------------------------------------------
sample.df <- data.frame(
  id = c('A15432', 'B90969', 'C18705', 'B49731', 'E99902',
         'C38292', 'A30619', 'D46627', 'E29198', 'A41418',
         'D51456', 'C88669', 'E03673', 'A63155', 'B66033'),
  date = as.Date(c(rep("2014-12-01",3),
                   rep("2015-09-21",5),
                   rep("2016-05-19",2),
                   "2016-11-12",
                   rep("2017-03-27",4))),
  pval = c(2.90e-14, 0.06743, 0.01514, 0.08174, 0.00171,
           3.61e-05, 0.79149, 0.27201, 0.28295, 7.59e-08,
           0.69274, 0.30443, 0.000487, 0.72342, 0.54757))

# Assuming a bound of 20 hypotheses
bound <- setBound("LOND", alpha = 0.04, 20)

set.seed(1)
LOND_results <- LOND(sample.df, alpha = 0.04, betai = bound)

