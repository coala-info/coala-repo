# Code example from 'histogram-tour' vignette. See references/ for full tutorial.

## ----ideal histogram, echo = FALSE--------------------------------------------
library(flowPloidy)
plot(x = 1, type = 'n', xlim = c(0, 256), ylim = c(0, 500),
     ylab = "Nuclei", xlab = "Fluorescence", main = "Ideal Histogram")
abline(h = 0)
lines(x = c(80, 80), y = c(0, 325))
lines(x = c(160, 160), y = c(0, 150))
tmpfun <- function(x) 100 * exp(-x/80)
curve(tmpfun, 80, 160, add = TRUE)
text(x = 80, y = 325, "G1 Peak", pos = 3)
text(x = 160, y = 150, "G2 Peak", pos = 3)
text(x = 120, y = 30, "S Phase", pos = 3)

## ----real histogram, echo = FALSE---------------------------------------------
set.seed(1234)
plot(x = 1, type = 'n', xlim = c(0, 256), ylim = c(0, 500),
     ylab = "Nuclei", xlab = "Fluorescence", main = "Empirical Histogram")
abline(h = 0)

vals <- rep(0, 257)
G1 <- 3000 * dnorm(0:256, mean = 80, sd = 80 * 0.05)
vals <- vals + G1
G2 <- 3000 * dnorm(0:256, mean = 160, sd = 160 * 0.05)
SPhase <- rep(0, 257) 
SPhase[80:160] <- 100 * exp((-80:-160)/80)
JIT <- 4
G1j <- jitter(G1, amount = JIT)
G2j <- jitter(G2, amount = JIT)
SPhasej <- jitter(SPhase, amount = JIT)
vals <- G1 + G2 + SPhase
Debris <- flowPloidy:::getSingleCutVals(vals, seq_along(vals), 1)/5
Debrisj <- jitter(Debris, amount = JIT)
G1j[G1j<0] <- 0
G2j[G2j<0] <- 0
SPhasej[SPhasej<0] <- 0
Debrisj[Debrisj<0] <- 0

vals <- G1 + G2 + SPhase + Debris
valsj <- G1j + G2j + SPhasej + Debrisj

Debris[0:4] <- 0
Debrisj[0:4] <- 0
vals[0:4] <- 0
valsj[0:4] <- 0

points(valsj, type = 'l')

text(x = 80, y = 450, "G1 Peak", pos = 3)
text(x = 160, y = 220, "G2 Peak", pos = 3)
text(x = 120, y = 100, "S Phase", pos = 3)
text(x = 40, y = 170, "Debris", pos = 3)
text(x = 240, y = 40, "Aggregates", pos = 3)

## ----manual analysis, echo = FALSE--------------------------------------------
plot(x = 1, type = 'n', xlim = c(0, 256), ylim = c(0, 500),
     ylab = "Nuclei", xlab = "Fluorescence",
     main = "Manual Histogram Analysis")
abline(h = 0)

points(valsj, type = 'l')
rect(70, 0, 95, 465, border = 2, lwd = 2)

## ----individual components, echo = FALSE--------------------------------------
plot(x = 1, type = 'n', xlim = c(0, 256), ylim = c(0, 500),
     ylab = "Nuclei", xlab = "Fluorescence",
     main = "Histogram Components")
abline(h = 0)

points(valsj, type = 'l')
points(Debrisj, type = 'l', col = 3, lwd = 2)
points(G1j, type = 'l', col = 4, lwd = 2)
points(SPhasej, type = 'l', col = 2, lwd = 2)
text(x = 25, y = 50, col = 3, "Debris")
text(x = 95, y = 350, col = 4, "G1")
text(x = 120, y = 120, col = 2, "S-Phase")

## ----histogram modeling, echo = FALSE-----------------------------------------
plot(x = 1, type = 'n', xlim = c(0, 256), ylim = c(0, 500),
     ylab = "Nuclei", xlab = "Fluorescence",
     main = "Histogram Modeling")
abline(h = 0)

lines(valsj)
lines(Debris, col = 3, lwd = 2)
lines(G1, col = 4, lwd = 2)
lines(SPhase, col = 2, lwd = 2)
lines(G2, col = 5, lwd = 2)

text(x = 25, y = 50, col = 3, "Debris")
text(x = 95, y = 350, col = 4, "G1")
text(x = 120, y = 120, col = 2, "S-Phase")
text(x = 180, y = 100, col = 5, "G2")

## ----histogram standard, echo = FALSE-----------------------------------------
plot(x = 1, type = 'n', xlim = c(0, 256), ylim = c(0, 500),
     ylab = "Nuclei", xlab = "Fluorescence",
     main = "Histogram with Standard")
abline(h = 0)

standard <- jitter(3000 * dnorm(0:256, mean = 130, sd = 400 * 0.01),
                   amount = 10)
standard[standard<0] <- 0
lines(valsj + standard)
text(x = 160, y = 400, "Standard")
text(x = 95, y = 400, "G1")
text(x = 180, y = 200, "G2")

