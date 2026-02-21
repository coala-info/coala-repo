# Code example from 'MBCB' vignette. See references/ for full tutorial.

### R code from vignette source 'MBCB.Rnw'

###################################################
### code chunk number 1: load package and data
###################################################
library(MBCB);
data(MBCBExpressionData);


###################################################
### code chunk number 2: write sample data to files
###################################################
write.table(expressionSignal, 'signal.txt', sep="\t");
write.table(negativeControl, 'negative.control.txt', sep="\t");


###################################################
### code chunk number 3: read sample files in
###################################################
data <- mbcb.parseFile('signal.txt', 'negative.control.txt');
signal <- data$sig;
negCon <- data$con;


###################################################
### code chunk number 4: set BGcorrection method variables
###################################################
nonparametric <- TRUE;
RMA<- TRUE;
MLE <- TRUE;
GMLE <- FALSE;
MCMC <- FALSE;


###################################################
### code chunk number 5: BG correct sample data
###################################################
 cor <- mbcb.correct(expressionSignal, negativeControl, nonparametric, RMA, MLE, MCMC, GMLE);


###################################################
### code chunk number 6: mbcb.main with values set
###################################################
mbcb.main(expressionSignal, negativeControl, nonparametric, RMA, MLE, MCMC, GMLE, "param-est", "bgCorrected");


###################################################
### code chunk number 7: default mbcb.main run
###################################################
mbcb.main(expressionSignal, negativeControl, paramEstFile="param-est", bgCorrectedFile="bgCorrected");


###################################################
### code chunk number 8: plotcorrections
###################################################
ylimits <- c(10,60000);

par(mfrow=c(2,2), mar=c(4,4,3,1))
boxplot(expressionSignal, log="y", ylim=ylimits, main="Raw Expression")
boxplot(cor$NP, log="y", ylim=ylimits, main="NP-corrected")
boxplot(cor$RMA, log="y", ylim=ylimits, main="RMA-corrected")
boxplot(cor$MLE, log="y", ylim=ylimits, main="MLE-corrected")


###################################################
### code chunk number 9: MBCBnormalization
###################################################
mbcb.main(expressionSignal, negativeControl, normMethod="quant");
quant_np <- read.csv("bgCorrected-NP.csv", row.names=1)
mbcb.main(expressionSignal, negativeControl, normMethod="median");
median_np <- read.csv("bgCorrected-NP.csv", row.names=1)


###################################################
### code chunk number 10: normPlots
###################################################
par(mfrow=c(2,2), mar=c(4,4,3,1))
boxplot(expressionSignal, log="y", main="Raw Expression")
boxplot(cor$NP, log="y", main="Non-normalized NP")
boxplot(median_np, log="y", main="Quantile Norm, NP-corrected")
boxplot(quant_np, log="y", main="Median Norm, NP-corrected")


###################################################
### code chunk number 11: open GUI
###################################################
mbcb.gui();


###################################################
### code chunk number 12: sessionInfo
###################################################
sessionInfo();


