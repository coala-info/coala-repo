# Code example from 'MultiMed' vignette. See references/ for full tutorial.

### R code from vignette source 'MultiMed.Rnw'

###################################################
### code chunk number 1: setup
###################################################
library(MultiMed)


###################################################
### code chunk number 2: simSingMed
###################################################
set.seed(20183)

alpha <- 0.2
beta <- 0.2
gamma <- 0.4
n <- 100
sigma2E <- 1
sigma2M <- 1 - alpha^2
sigma2Y <- 1 - beta^2 * (1 - alpha^2) - (alpha * beta + gamma)^2

## exposure:
E <- rnorm(n, 0, sd = sqrt(sigma2E))
## mediator:
M <- matrix(0, nrow = n, ncol = 1)
M[, 1] <- rnorm(n, alpha * E, sd = sqrt(sigma2M))
## outcome:
Y <- rep(0, n)
for (subj in 1:n) Y[subj] <- rnorm(1, beta * M[subj, ], sd = sqrt(sigma2Y))


###################################################
### code chunk number 3: testSingMed
###################################################
medTest(E, M, Y, nperm = 500)


###################################################
### code chunk number 4: simMultMed
###################################################
set.seed(380184)

alpha <- c(rep(0, 6), rep(0.3, 2), rep(0, 2))
beta <- c(rep(0, 6), rep(0, 2), rep(0.3, 2))
gamma <- 0.6

alpha
beta

n <- 100

sigma2E <- 1
sigma2M <- 1-alpha^2
sigma2Y <- 1-sum(beta^2*sigma2M)-(sum(alpha*beta)+gamma)^2

sigma2M
sigma2Y


###################################################
### code chunk number 5: simMultMed2
###################################################
K <- length(alpha)

## exposure:
E <- rnorm(n, 0, sd = sqrt(sigma2E))
## mediator:
M <- matrix(0, nrow = n, ncol = K)
for (i in 1:K) {
  M[, i] <- rnorm(n, alpha[i] * E, sd = sqrt(sigma2M[i]))
}
## outcome:
Y <- rep(0, n)
for (subj in 1:n)
  Y[subj] <- rnorm(1, sum(beta*M[subj,])+gamma*E[subj], sd=sqrt(sigma2Y))


###################################################
### code chunk number 6: testMultMed
###################################################
medTest(E, M, Y, nperm = 500)


###################################################
### code chunk number 7: loadData
###################################################
data(NavyAdenoma)


###################################################
### code chunk number 8: exploreData1
###################################################
colnames(NavyAdenoma)[1:5]


###################################################
### code chunk number 9: exploreData2
###################################################
colnames(NavyAdenoma)[c(6:9,154)]
colnames(NavyAdenoma)[155]
table(NavyAdenoma$Adenoma)


###################################################
### code chunk number 10: getWeights
###################################################
prev <- 0.228

p <- sum(NavyAdenoma$Adenoma==1)/nrow(NavyAdenoma)
p

w <- rep(NA, nrow(NavyAdenoma))
w[NavyAdenoma$Adenoma == 1] <- prev/p
w[NavyAdenoma$Adenoma == 0] <- (1-prev)/(1-p)

table(w)


###################################################
### code chunk number 11: medFish
###################################################
set.seed(840218)
medsFish <- medTest(E=NavyAdenoma$Fish,
                    M=NavyAdenoma[, 6:154],
                    Y=NavyAdenoma$Adenoma,
                    Z=NavyAdenoma[, 2:5],
                    nperm=1000, w=w,
                    useWeightsZ=FALSE)


###################################################
### code chunk number 12: findTopMeds
###################################################
rownames(medsFish) <- colnames(NavyAdenoma[,-c(1:5, 154)])
medsFish[which.min(medsFish[,"p"]),,drop=FALSE]


