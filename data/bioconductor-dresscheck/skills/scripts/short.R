# Code example from 'short' vignette. See references/ for full tutorial.

### R code from vignette source 'short.Rnw'

###################################################
### code chunk number 1: do1
###################################################
psurv = function (x, digits = max(options()$digits - 4, 3), ...) 
{
    saveopt <- options(digits = digits)
    on.exit(options(saveopt))
    if (!inherits(x, "survdiff")) 
        stop("Object is not the result of survdiff")
    if (!is.null(cl <- x$call)) {
    }
    omit <- x$na.action
    if (length(omit)) {
    }
    if (length(x$n) == 1) {
        z <- sign(x$exp - x$obs) * sqrt(x$chisq)
        temp <- c(x$obs, x$exp, z, signif(1 - pchisq(x$chisq, 
            1), digits))
        names(temp) <- c("Observed", "Expected", "Z", "p")
        print(temp)
    }
    else {
        if (is.matrix(x$obs)) {
            otmp <- apply(x$obs, 1, sum)
            etmp <- apply(x$exp, 1, sum)
        }
        else {
            otmp <- x$obs
            etmp <- x$exp
        }
        df <- (sum(1 * (etmp > 0))) - 1
        temp <- cbind(x$n, otmp, etmp, ((otmp - etmp)^2)/etmp, 
            ((otmp - etmp)^2)/diag(x$var))
        dimnames(temp) <- list(names(x$n), c("N", "Observed", 
            "Expected", "(O-E)^2/E", "(O-E)^2/V"))
        uu <- 1 - pchisq(x$chisq, df)
    }
    uu
}
library(dressCheck)
library(chron)
library(survival)
data(DrAsGiven)
data(corrp116)

an = as.numeric
pdf(file="twox3.pdf", width=8, height=5)
par(mfrow=c(2,3))
plot(an(exprs(corrp116["213350_at",]))~chron(corrp116$rundate), main="(a)",
xlab="array run date", ylab="RMA+SFR expression of RPS11")

CC = cut(chron(corrp116$rundate),2)

 with(pData(corrp116), d0 <<- survdiff(Surv(Survival, dead)~CC,
  subset=CR==0))

 with(pData(corrp116), plot(survfit(Surv(Survival, dead)~CC,
  subset=CR==0),col=c("red", "green"), lwd=3,
  xlab="Months", ylab="survival (%)", main="(b)"))
text(37,.03, paste("logrank p=", round(psurv(d0),3)))


#giv = DrAsGiven[intersect(featureNames(DrAsGiven), names(srcWts)),]
#srcWtsL = srcWts[featureNames(giv)]
#sco = t(exprs(giv))%*%srcWtsL
#sdys = 1*(sco>median(sco))
#with(pData(DrAsGiven), plot(survfit(Surv(Survival, X0...alive...1...dead)~sdys,
# subset=response.0.NR..1.CR==0),col=c("blue", "yellow"), lwd=3,
# xlab="Months", ylab="survival (%)", main="(b)"))
#with(pData(DrAsGiven), d1 <<- survdiff(Surv(Survival, X0...alive...1...dead)~sdys,
# subset=response.0.NR..1.CR==0))
#text(37,.05, paste("logrank p=", round(psurv(d1),3)))

data(srcWts)    # get scoring coefficients, then restrict expression data to the
                # genes in the pathway signature
corr = corrp116[intersect(featureNames(corrp116), names(srcWts)),]
srcWtsL = srcWts[featureNames(corr)]
                # score the tumors
sco = t(exprs(corr))%*%srcWtsL
sdys = 1*(sco>median(sco))  # dichotomize
with(pData(corrp116), plot(survfit(Surv(Survival, dead)~sdys,
 subset=CR==0),col=c("blue", "yellow"), lwd=3,
 xlab="Months", ylab="survival (%)", main="(c)"))
with(pData(corrp116), d2 <<- survdiff(Surv(Survival, dead)~sdys,
 subset=CR==0))
text(37,.05, paste("logrank p=", round(psurv(d2),3)))

data(e2f3Wts)
corr = corrp116[intersect(featureNames(corrp116), names(e2f3Wts)),]
eWtsL = e2f3Wts[featureNames(corr)]
sco = t(exprs(corr))%*%eWtsL
edys = 1*(sco<median(sco)) # different parity than Src -- see doPW2
with(pData(corrp116), d1 <<- survdiff(Surv(Survival, dead)~edys,
 subset=CR==0))
with(pData(corrp116), plot(survfit(Surv(Survival, dead)~edys,
 subset=CR==0),col=c("blue", "yellow"), lwd=3,
 xlab="Months", ylab="survival (%)", main="(d)"))
text(37,.05, paste("logrank p=", round(psurv(d1),3)))
with(pData(corrp116), d2 <<- survdiff(Surv(Survival, dead)~edys,
 subset=CR==1))

with(pData(corrp116), plot(survfit(Surv(Survival, dead)~edys,
 subset=CR==1),col=c("blue", "yellow"), lwd=3,
 xlab="Months", ylab="survival (%)", main="(e)"))
text(57,.05, paste("logrank p=", round(psurv(d2),3)))


###################################################
### code chunk number 2: short.Rnw:269-270
###################################################
xx = dev.off()


###################################################
### code chunk number 3: lkmod
###################################################
with(pData(corrp116), m2 <<- survreg(Surv(Survival, dead)~sdys+poly(chron(rundate),2),
 subset=CR==0))
summary(m2)

with(pData(corrp116), m3 <<- survreg(Surv(Survival, dead)~edys,
 subset=CR==1))
summary(m3)

with(pData(corrp116), m3a <<- survreg(Surv(Survival, dead)~edys+poly(chron(rundate),2),
 subset=CR==1))
summary(m3a)




