# Code example from 'maqcNotes' vignette. See references/ for full tutorial.

### R code from vignette source 'maqcNotes.Rnw'

###################################################
### code chunk number 1: lkdat
###################################################
library(MAQCsubset)
data(afxsubRMAES)
afxsubRMAES
pd = pData(afxsubRMAES)
table(pd$site, pd$samp)


###################################################
### code chunk number 2: dopro
###################################################
#setClass("proboStruct", representation(call="call"),
#  contains="list")
#setMethod("show", "proboStruct", function(object) {
#  cat("proboStruct instance created by:\n")
#  print(object@call)
#})
#setMethod("plot", "proboStruct", function(x, y, xlim=c(-3,3),
#   col="black", ...) {
# plot(x[[1]][x$leftinds], x[[2]][x$leftinds], xlab=names(x)[1],
#  ylab=names(x)[2], type="l", col=col, xlim=xlim, ...)
# lines(x[[1]][-x$leftinds], x[[2]][-x$leftinds], col=col, ...)
#})
proboscis = function(es, site=1, ABp=0.001, CDp=.01, 
   mmrad=100) {
 require(genefilter)
 mcall = match.call()
 # assumes samples labeled A, B, C, D as in MAQC
  mm = function(x,rad) {
  # moving mean
    start = ceiling(rad/2)
    stop = floor(length(x)-(rad/2))
    sapply(start:stop, function(i) mean(x[(i-floor(rad/2)):(i+floor(rad/2))]))
   }
 ess = es[,es$site==site]
 essab = ess[, ess$samp %in% c("A", "B")]
 essab$samp = factor(essab$samp)
 esscd = ess[, ess$samp %in% c("C", "D")]
 esscd$samp = factor(esscd$samp)
 tt = rowttests( exprs(essab), essab$samp ) 
 L = which( tt$p < ABp & tt$dm < 0 )
 R = which( tt$p < ABp & tt$dm > 0 )
 ttcd = rowttests( exprs(esscd), esscd$samp )
 ABL = tt$dm[L]
 CDL = ttcd$dm[L]
 ABR = tt$dm[R]
 CDR = ttcd$dm[R]
 NN = list(ttab=tt,ttcd=ttcd,ABL=sort(ABL),cdokL=1*(CDL<0)[order(ABL)],
  ABR=sort(ABR),dcokR=1*(CDR>0)[order(ABR)])
 `A-B` = c(ONR <- mm(NN$ABL,mmrad), mm(NN$ABR,mmrad))
 `P(SCMT|A-B)` = c(mm(NN$cdokL,mmrad), mm(NN$dcokR,mmrad))
 new("proboStruct", call=mcall,
  list("A-B"=`A-B`, "P(SCMT|A-B)"=`P(SCMT|A-B)`,
  leftinds=1:length(ONR)))
}
NN1 = proboscis(afxsubRMAES)
NN2 = proboscis(afxsubRMAES, site=2)
NN3 = proboscis(afxsubRMAES, site=3)


###################################################
### code chunk number 3: dopl
###################################################
plot(NN1, lwd=2)
lines(NN2[[1]], NN2[[2]], col="green", lwd=2)
lines(NN3[[1]], NN3[[2]], col="blue", lwd=2)
legend(-2.5, .9, lty=1, lwd=2, legend=c("site 1",
 "site 2", "site 3"), col=c("black", "green", "blue"))



