# Code example from 'BayesKnockdown' vignette. See references/ for full tutorial.

### R code from vignette source 'BayesKnockdown.rnw'

###################################################
### code chunk number 1: SimulatedEx
###################################################
library(BayesKnockdown);
set.seed(1618);
n <- 100;
p <- 10;
x <- rnorm(n);
y <- matrix(nrow=p, data=rnorm(n*p));
y[3,] <- y[3,] + 0.5*x;

simResult <- BayesKnockdown(x, y);
simResult;

barplot(simResult, names.arg="", xlab="Target Gene",
        ylab="Posterior Probability", ylim=c(0,1));


###################################################
### code chunk number 2: simPlot
###################################################
barplot(simResult, names.arg="", xlab="Target Gene",
      ylab="Posterior Probability", ylim=c(0,1));


###################################################
### code chunk number 3: KnockdownEx
###################################################
data(lincs.kd);
kdResult <- BayesKnockdown(lincs.kd[1,], lincs.kd[-1,], prior=0.0005);
kdResult;

barplot(kdResult, names.arg="", xlab="Target Gene",
        ylab="Posterior Probability", ylim=c(0,1));


###################################################
### code chunk number 4: kdPlot
###################################################
barplot(kdResult, names.arg="", xlab="Target Gene",
        ylab="Posterior Probability", ylim=c(0,1));


###################################################
### code chunk number 5: KnockdownES
###################################################
library(Biobase);
data(sample.ExpressionSet);
subset <- sample.ExpressionSet[1:10,];

BayesKnockdown.es(subset, "AFFX-MurIL10_at");


###################################################
### code chunk number 6: BayesKnockdown.diffExp
###################################################
n1 <- 25;
n2 <- 30;
p <- 10;
y1 <- matrix(nrow=p, data=rnorm(n1*p));
y2 <- matrix(nrow=p, data=rnorm(n2*p));
y2[3,] <- y2[3,] + 1;

diffExpResult <- BayesKnockdown.diffExp(y1, y2);

barplot(diffExpResult, names.arg="", xlab="Target Gene",
        ylab="Posterior Probability", ylim=c(0,1));


###################################################
### code chunk number 7: diffExpPlot
###################################################
barplot(diffExpResult, names.arg="", xlab="Target Gene",
        ylab="Posterior Probability", ylim=c(0,1));


