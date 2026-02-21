# Code example from 'BayesPeak' vignette. See references/ for full tutorial.

### R code from vignette source 'BayesPeak.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex(use.unsrturl=FALSE)


###################################################
### code chunk number 2: BayesPeak.Rnw:84-85
###################################################
library(BayesPeak)


###################################################
### code chunk number 3: ex1 (eval = FALSE)
###################################################
## raw.output <- bayespeak("H3K4me3-chr16.bed", "Input-chr16.bed",
## 			chr = "chr16", start = 9.2E7, end = 9.5E7, job.size = 6E6)
## output <- summarize.peaks(raw.output, method = "lowerbound")


###################################################
### code chunk number 4: ex2 (eval = FALSE)
###################################################
## raw.output <- bayespeak("H3K4me3-chr16.bed", "Input-chr16.bed")
## output <- summarize.peaks(raw.output, method = "lowerbound")


###################################################
### code chunk number 5: savetodisk2 (eval = FALSE)
###################################################
## write.table(as.data.frame(output), file = "H3K4me3output.txt", quote = FALSE)
## write.csv(as.data.frame(output), file = "H3K4me3output.csv", quote = FALSE)


###################################################
### code chunk number 6: Help (eval = FALSE)
###################################################
## raw.output <- bayespeak("H3K4me3-chr16.bed", "Input-chr16.bed")


###################################################
### code chunk number 7: Help (eval = FALSE)
###################################################
## library(parallel)
## raw.output <- bayespeak("H3K4me3-chr16.bed", "Input-chr16.bed",
## 	use.multicore = TRUE, mc.cores = 4)
## output <- summarize.peaks(raw.output, method = "lowerbound")


###################################################
### code chunk number 8: Help (eval = FALSE)
###################################################
## library(parallel)
## cl <- makeCluster(4, type="PSOCK") ##adapt this line as appropriate for your cluster
## cl <- clusterEvalQ(cl, library(BayesPeak)) ##load BayesPeak on the cluster
## raw.output <- bayespeak("H3K4me3-chr16.bed", "Input-chr16.bed",
## 	snow.cluster = cl)
## output <- summarize.peaks(raw.output, method = "lowerbound")


###################################################
### code chunk number 9: PP1
###################################################
data(raw.output)
raw.output$call


###################################################
### code chunk number 10: PP3a
###################################################
min.job <- min(raw.output$peaks$job)
max.job <- max(raw.output$peaks$job)

par(mfrow = c(2,2), ask = TRUE)
for(i in min.job:max.job) {plot.PP(raw.output, job = i, ylim = c(0,50))}


###################################################
### code chunk number 11: job324
###################################################
i <- 324
plot.PP(raw.output, job = i, ylim = c(0,50))


###################################################
### code chunk number 12: job324fig
###################################################
i <- 324
plot.PP(raw.output, job = i, ylim = c(0,50))


###################################################
### code chunk number 13: job325
###################################################
i <- 325
plot.PP(raw.output, job = i, ylim = c(0,50))


###################################################
### code chunk number 14: job325fig
###################################################
i <- 325
plot.PP(raw.output, job = i, ylim = c(0,50))


###################################################
### code chunk number 15: OF1
###################################################
data(raw.output)


###################################################
### code chunk number 16: OF3
###################################################

plot.overfitdiag(raw.output, whatX = "calls", whatY = "lambda1",
	logX = TRUE, logY = TRUE)


###################################################
### code chunk number 17: OF3b
###################################################
plot.overfitdiag(raw.output, whatX = "calls", whatY = "score",
	logX = TRUE, logY = TRUE)


###################################################
### code chunk number 18: OF3fig
###################################################

plot.overfitdiag(raw.output, whatX = "calls", whatY = "lambda1",
	logX = TRUE, logY = TRUE)


###################################################
### code chunk number 19: OF3bfig
###################################################
plot.overfitdiag(raw.output, whatX = "calls", whatY = "score",
	logX = TRUE, logY = TRUE)


###################################################
### code chunk number 20: OF3
###################################################
plot.overfitdiag(raw.output, whatX = "calls", whatY = "score",
	logX = TRUE, logY = FALSE)


###################################################
### code chunk number 21: OF3b
###################################################
plot.overfitdiag(raw.output, whatX = "lambda1", whatY = "score",
	logX = TRUE, logY = TRUE)


###################################################
### code chunk number 22: OF4
###################################################
unreliable.jobs <- log(raw.output$QC$lambda1) < 1.5
output <- summarize.peaks(raw.output, method = "lowerbound",
	exclude.jobs = unreliable.jobs)


###################################################
### code chunk number 23: OF5
###################################################
unreliable.jobs2 <- log(raw.output$QC$lambda1) < 1.5 | log(raw.output$QC$calls) > 5
output.2 <- summarize.peaks(raw.output, method = "lowerbound",
	exclude.jobs = unreliable.jobs2)


###################################################
### code chunk number 24: region.overfitdiag.help
###################################################
unreliable.jobs3 <- region.overfitdiag(raw.output, whatX = "lambda1", whatY = "score",
	logX = TRUE, logY = TRUE)
##user defines a polygon on the resulting plot
##left-click to place each vertex, right-click to close polygon 
output.3 <- summarize.peaks(raw.output, method = "lowerbound",
	exclude.jobs = unreliable.jobs3)


###################################################
### code chunk number 25: QCcommand
###################################################
log(raw.output$QC[,c("calls", "score", "lambda1")])


###################################################
### code chunk number 26: coda (eval = FALSE)
###################################################
## data(raw.output)
## library(coda)
## mcmc.job1 <- mcmc(raw.output$p.samples[[316]], thin = 10)
## geweke.diag(mcmc.job1)


###################################################
### code chunk number 27: BayesPeak.Rnw:562-563
###################################################
sessionInfo()


