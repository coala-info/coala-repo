# Code example from 'chopsticks-vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'chopsticks-vignette.Rnw'

###################################################
### code chunk number 1: init
###################################################
library(chopsticks)
library(hexbin)
data(for.exercise)


###################################################
### code chunk number 2: chopsticks-vignette.Rnw:98-99
###################################################
show(snps.10)


###################################################
### code chunk number 3: chopsticks-vignette.Rnw:104-105
###################################################
summary(snp.support)


###################################################
### code chunk number 4: chopsticks-vignette.Rnw:116-117
###################################################
summary(subject.support)


###################################################
### code chunk number 5: chopsticks-vignette.Rnw:137-139
###################################################
snpsum <- summary(snps.10)
summary(snpsum)


###################################################
### code chunk number 6: plot-snpsum
###################################################
par(mfrow = c(1, 2))
hist(snpsum$MAF)
hist(snpsum$z.HWE)


###################################################
### code chunk number 7: sample-qc
###################################################
sample.qc <- row.summary(snps.10)
summary(sample.qc)


###################################################
### code chunk number 8: plot-outliners-qc
###################################################
par(mfrow = c(1, 1))
plot(sample.qc)


###################################################
### code chunk number 9: outliers
###################################################
use <- sample.qc$Heterozygosity>0
snps.10 <- snps.10[use, ]
subject.support <- subject.support[use, ]


###################################################
### code chunk number 10: if-case-control
###################################################
if.case <- subject.support$cc == 1
if.control <- subject.support$cc == 0


###################################################
### code chunk number 11: sum-case-control
###################################################
sum.cases <- summary(snps.10[if.case, ])
sum.controls <- summary(snps.10[if.control, ])


###################################################
### code chunk number 12: plot-summaries
###################################################
hb <- hexbin(sum.controls$Call.rate, sum.cases$Call.rate, xbin=50)
sp <- plot(hb)
hexVP.abline(sp$plot.vp, a=0, b=1, col="black")


###################################################
### code chunk number 13: plot-freqs
###################################################
sp <- plot(hexbin(sum.controls$MAF, sum.cases$MAF, xbin=50))
hexVP.abline(sp$plot.vp, a=0, b=1, col="white") 


###################################################
### code chunk number 14: tests
###################################################
tests <- single.snp.tests(cc, data = subject.support, snp.data = snps.10)


###################################################
### code chunk number 15: sum-tests
###################################################
summary(tests)


###################################################
### code chunk number 16: use
###################################################
use <- snpsum$MAF > 0.01 & snpsum$z.HWE^2 < 200


###################################################
### code chunk number 17: sum-use
###################################################
sum(use)


###################################################
### code chunk number 18: subset-tests
###################################################
tests <- tests[use, ]
position <- snp.support[use, "position"]


###################################################
### code chunk number 19: plot-tests
###################################################
p1 <- pchisq(tests$chi2.1df, df = 1, lower.tail = FALSE)
plot(hexbin(position, -log10(p1), xbin=50))


###################################################
### code chunk number 20: qqplot
###################################################
qq.chisq(tests$chi2.1df, df = 1)


###################################################
### code chunk number 21: more-tests
###################################################
tests <- single.snp.tests(cc, stratum, data = subject.support,
     snp.data = snps.10)
tests <- tests[use, ]
p1 <- pchisq(tests$chi2.1df, df = 1, lower.tail = FALSE)
plot(hexbin(position, -log10(p1), xbin=50))


###################################################
### code chunk number 22: more-tests-qq
###################################################
qq.chisq(tests$chi2.1df, df = 1)


###################################################
### code chunk number 23: ord
###################################################
ord <- order(p1)
top10 <- ord[1:10]
top10


###################################################
### code chunk number 24: top-10
###################################################
names <- rownames(tests)
p1[top10]
names[top10]
position[top10]


###################################################
### code chunk number 25: top10-local
###################################################
posord <- order(position)
position <- position[posord]
names <- names[posord]
local <- names[position > 9.6e+07 & position < 9.8e+07]


###################################################
### code chunk number 26: ld-2mb
###################################################
snps.2mb <- snps.10[, local]
ld.2mb <- ld.snp(snps.2mb)


###################################################
### code chunk number 27: top1
###################################################
attach(subject.support)
top <- snps.10[, "rs870041"]
top <- as.numeric(top)
glm(cc ~ top + stratum, family = "binomial")


###################################################
### code chunk number 28: top2-3
###################################################
top2 <- snps.10[, "rs7088765"]
top2 <- as.numeric(top2)
glm(cc ~ top2 + stratum, family = "binomial")
top3 <- snps.10[, "rs1916572"]
top3 <- as(top3, "numeric")
glm(cc ~ top3 + stratum, family = binomial)


###################################################
### code chunk number 29: blocks
###################################################
blocks <- split(posord, cut(position, seq(100000, 135300000, 20000)))
bsize <- sapply(blocks, length)
table(bsize)
blocks <- blocks[bsize>0]  


###################################################
### code chunk number 30: twentyfive
###################################################
posord[1:20]
blocks[1:5]


###################################################
### code chunk number 31: blocks-use
###################################################
snps.use <- snps.10[, use]
remove(snps.10)


###################################################
### code chunk number 32: mtests
###################################################
mtests <- snp.rhs.tests(cc ~ stratum, family = "binomial", 
     data = subject.support, snp.data = snps.use, tests = blocks)
summary(mtests)


###################################################
### code chunk number 33: plot-mtests
###################################################
pm <- pchisq(mtests$Chi.squared, mtests$Df, lower.tail = FALSE)
plot(hexbin(-log10(pm), xbin=50))


###################################################
### code chunk number 34: qqplot-mtests
###################################################
qq.chisq(-2 * log(pm), df = 2)


