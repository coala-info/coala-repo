# Code example from 'quanGenAnimalModel' vignette. See references/ for full tutorial.

### R code from vignette source 'quanGenAnimalModel.Rnw'

###################################################
### code chunk number 1: options
###################################################
options(width=85)


###################################################
### code chunk number 2: data
###################################################
library(GeneticsPed)
data(Mrode3.1)
(x <- Pedigree(x=Mrode3.1, subject="calf", ascendant=c("sire", "dam"),
               ascendantSex=c("Male", "Female"), sex="sex"))


###################################################
### code chunk number 3: y
###################################################
(y <- x$pwg)


###################################################
### code chunk number 4: X
###################################################
X <- model.matrix(~ x$sex - 1)
t(X)


###################################################
### code chunk number 5: Z
###################################################
(Z <- model.matrix(object=x, y=x$pwg, id=x$calf))


###################################################
### code chunk number 6: LHS
###################################################
LHS <- rbind(cbind(t(X) %*% X, t(X) %*% Z),
             cbind(t(Z) %*% X, t(Z) %*% Z))
## or more efficiently
(LHS <- rbind(cbind(crossprod(X),    crossprod(X, Z)),
              cbind(crossprod(Z, X), crossprod(Z))))


###################################################
### code chunk number 7: LHS2
###################################################
## We want Ainv for all individuals in the pedigree not only individuals
##   with records
x <- extend(x)
Ainv <- inverseAdditive(x=x)
sigma2a <- 20
sigma2e <- 40
alpha <- sigma2e / sigma2a
q <- nIndividual(x)
p <- nrow(LHS) - q
(LHS[(p + 1):(p + q), (p + 1):(p + q)] <-
 LHS[(p + 1):(p + q), (p + 1):(p + q)] + Ainv * alpha)


###################################################
### code chunk number 8: RHS
###################################################
RHS <- rbind(t(X) %*% y,
             t(Z) %*% y)
## or more efficiently
RHS <- rbind(crossprod(X, y),
             crossprod(Z, y))
t(RHS)


###################################################
### code chunk number 9: solve
###################################################
sol <- solve(LHS) %*% RHS
## or more efficiently
sol <- solve(LHS, RHS)
t(sol)


###################################################
### code chunk number 10: sessionInfo
###################################################
toLatex(sessionInfo())


