# Code example from 'MBAmethyl' vignette. See references/ for full tutorial.

### R code from vignette source 'MBAmethyl.Rnw'

###################################################
### code chunk number 1: MBAmethyl.Rnw:54-76
###################################################
  p <- 80
  n <- 40
  K <- 2
  k <- K - 1
  cp <- numeric()
  L <- c(0, floor(p / K) * (1 : k), p)
  cp <- floor(p / K) * (1 : k) + 1

  ## phi0: probe effects; theta0: true methylation values; part: partition of probe indices
  phi0 <- runif(p, 0.5, 2.0)
  theta0 <- matrix(0, p, n)
  part <- list()

  for (s in 1 : K) {
    part[[s]] <- (L[s] + 1) : L[s + 1]
    phi0[part[[s]]] <- phi0[part[[s]]] / sqrt(mean(phi0[part[[s]]]^2))
  }
  theta0[part[[1]], ] <- rep(1, length(part[[1]])) %x% t(runif(n, 0.1, 0.6))
  theta0[part[[2]], ] <- rep(1, length(part[[2]])) %x% t(runif(n, 0.4, 0.9))
  
  error <- matrix(runif(p * n, 0, 0.1), p, n)
  Y <- theta0 * phi0  + error


###################################################
### code chunk number 2: MBAmethyl.Rnw:81-83
###################################################
 library(MBAmethyl)
 fit <- MBAmethyl(Y, steps = 30)


###################################################
### code chunk number 3: MBAmethyl.Rnw:87-89
###################################################
  str(fit$ans.bic)
  theta <- fit$ans.bic


###################################################
### code chunk number 4: sessionInfo
###################################################
toLatex(sessionInfo())


