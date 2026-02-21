# Code example from 'affyContam' vignette. See references/ for full tutorial.

### R code from vignette source 'affyContam.Rnw'

###################################################
### code chunk number 1: lkd
###################################################
library(affydata)
data(Dilution)
image(Dilution[,1])


###################################################
### code chunk number 2: dodef
###################################################
library(affyContam)
dilc = setCircRegion(Dilution, chip=1)


###################################################
### code chunk number 3: lkp (eval = FALSE)
###################################################
## image(dilc[,1])


###################################################
### code chunk number 4: getl (eval = FALSE)
###################################################
## library(affyMvout)
## library(affy)
## library(SpikeIn)
## data(SpikeIn133)
## library(mdqc)
## library(affyContam)
## library(limma)


###################################################
### code chunk number 5: doperm (eval = FALSE)
###################################################
## s12 = SpikeIn133[,1:12]
## s12rma = rma(s12)
## mads = apply(exprs(s12rma),1,mad)
## kp = which(mads > quantile(mads,.95))
## kppn = featureNames(s12rma)[kp]
## # these are the 18 genes found to be mostly monotone over 12 chips
## mostmr = c("203508_at", "204563_at", "204513_s_at", "204205_at", "204959_at", 
## "207655_s_at", "204836_at", "205291_at", "209795_at", "207777_s_at", 
## "204912_at", "205569_at", "207160_at", "205692_s_at", "212827_at", 
## "AFFX-LysX-3_at", "AFFX-PheX-3_at", "AFFX-ThrX-3_at")
## 


###################################################
### code chunk number 6: cod (eval = FALSE)
###################################################
## fullrun = function( abatch, arma, contFun, filtpn, targpn, chips=1, ... ) {
## # assess detectability in original data
##  dvec = (1:ncol(exprs(abatch)))
##  des = model.matrix(~dvec)
##  af1 = lmFit( arma[filtpn,], des, method="robust", maxit=300 )
##  eaf1 = eBayes(af1)
##  orig.tt = eaf1$t[targpn,2]
## # contaminate
##  cbat = contFun(abatch, chip=chips[1], ...)
##  if (length(chips)>1) {
##    for (i in 2:(length(chips)))
##      cbat = contFun(cbat, chip=chips[i], ...)
##    }
## # assess detectability in contaminated data
##  crma = rma(cbat)[filtpn,]
##  dvec = (1:ncol(exprs(abatch)))
##  des = model.matrix(~dvec)
##  cf1 = lmFit( crma, des, method="robust", maxit=300 )
##  ecf1 = eBayes(cf1)
##  contam.tt = ecf1$t[targpn,2]
## # now test for outliers
##  caos = ArrayOutliers(cbat)
##  if (nrow(caos[[1]]) < 1) {
##     warning("no outliers by affyMvout")
##     return(list(aos=caos, md=mdqc(caos[[3]][,2:10])))
##     }
##  todrop = as.numeric(rownames(caos[[1]]))
##  cbatf = cbat[,-todrop]
## # assess detectability in repaired data
##  frma = rma(cbatf)[filtpn,]
##  dvec = (1:ncol(exprs(abatch)))[-todrop]
##  des = model.matrix(~dvec)
##  f1 = lmFit( frma, des, method="robust", maxit=300 )
##  ef1 = eBayes(f1)
##  repair.tt = ef1$t[targpn,2]
## # compute the mdqc result
##  md = mdqc(caos[[3]][,2:10], robust="MCD")
##  list(orig=orig.tt, contam=contam.tt, repair=repair.tt, md=md, todrop=todrop)
## }
##  


###################################################
### code chunk number 7: ddd (eval = FALSE)
###################################################
## ff = fullrun( s12, s12rma, setCircRegion, kppn, mostmr, chips=1:2 )


###################################################
### code chunk number 8: scr (eval = FALSE)
###################################################
## scr.40 = function (x, chip = 1, center = c(150, 150), rad = 75, vals = 30, 
##     valgen = NULL) 
## {
##     cdfname = paste(annotation(x), "cdf", sep = "")
##     require(cdfname, character.only = TRUE, quietly = TRUE)
##     xext = seq(center[1] - rad, center[1] + rad)
##     yext = seq(center[2] - rad, center[2] + rad)
##     badco = expand.grid(xext, yext)
##     badco = badco[(badco[, 1] - center[1])^2 + (badco[, 2] - 
##         center[2])^2 < rad^2, ]
##     indsbad = apply(badco, 1, function(x) xy2indices(x[1], x[2], 
##         cdf = cdfname))
##     if (is.null(valgen)) 
##         exprs(x)[indsbad, chip] = vals
##     else exprs(x)[indsbad, chip] = valgen(length(indsbad))
##     x
## }


###################################################
### code chunk number 9: scr2 (eval = FALSE)
###################################################
## scr.20k = function (x, chip = 1, center = c(500, 500), rad = 75, vals = 30000,
##     valgen = NULL)
## {
##     cdfname = paste(annotation(x), "cdf", sep = "")
##     require(cdfname, character.only = TRUE, quietly = TRUE)
##     xext = seq(center[1] - rad, center[1] + rad)
##     yext = seq(center[2] - rad, center[2] + rad)
##     badco = expand.grid(xext, yext)
##     badco = badco[(badco[, 1] - center[1])^2 + (badco[, 2] -
##         center[2])^2 < rad^2, ]
##     indsbad = apply(badco, 1, function(x) xy2indices(x[1], x[2],
##         cdf = cdfname))
##     if (is.null(valgen))
##         exprs(x)[indsbad, chip] = vals
##     else exprs(x)[indsbad, chip] = valgen(length(indsbad))
##     x
## }


###################################################
### code chunk number 10: dov (eval = FALSE)
###################################################
## incvarCircRegion = function(x, chip=1, center=c(150,500), rad=100, fac=3) {
##  tmp = fac*getCircRegion(x, chip, center, rad)
##  setCircRegion(x, chip, center, rad, vals=tmp)
## }


###################################################
### code chunk number 11: dov (eval = FALSE)
###################################################
## incvarRectRegion = function(x, chip=1, xinds=350:700, yinds=1:700, fac=3) {
##  tmp = fac*getRectRegion(x, chip, xinds, yinds)
##  setRectRegion(x, chip, xinds, yinds, vals=tmp)
## }


###################################################
### code chunk number 12: compo (eval = FALSE)
###################################################
## tryout = scr.40(s12)
## tryout = scr.20k(tryout)
## tryout = incvarCircRegion(tryout)
## fin = incvarRectRegion(tryout)
## png(file="lkcomp.png")
## image(fin[,1], main="composite contamination")
## dev.off()


###################################################
### code chunk number 13: doruns (eval = FALSE)
###################################################
## d1b = fullrun( s12, s12rma, scr.40, kppn, mostmr, chips=1 )
## save(d1b, file="d1b.rda")
## d2b = fullrun( s12, s12rma, scr.40, kppn, mostmr, chips=1:2 )
## save(d2b, file="d2b.rda")
## d3b = fullrun( s12, s12rma, scr.40, kppn, mostmr, chips=c(1:2,11) )
## save(d3b, file="d3b.rda")
## H1b = fullrun( s12, s12rma, scr.20k, kppn, mostmr, chips=1 )
## save(H1b, file="H1b.rda")
## H2b = fullrun( s12, s12rma, scr.20k, kppn, mostmr, chips=1:2 )
## save(H2b, file="H2b.rda")
## H3b = fullrun( s12, s12rma, scr.20k, kppn, mostmr, chips=c(1:2,11) )
## save(H3b, file="H3b.rda")
## I1b = fullrun( s12, s12rma, incvarCircRegion, kppn, mostmr, chips=1 )
## save(I1b, file="I1b.rda")
## I2b = fullrun( s12, s12rma, incvarCircRegion, kppn, mostmr, chips=1:2 )
## save(I2b, file="I2b.rda")
## I3b = fullrun( s12, s12rma, incvarCircRegion, kppn, mostmr, chips=c(1:2,11) )
## save(I3b, file="I3b.rda")
## R1b = fullrun( s12, s12rma, incvarRectRegion, kppn, mostmr, chips=1 )
## save(R1b, file="R1b.rda")
## R2b = fullrun( s12, s12rma, incvarRectRegion, kppn, mostmr, chips=1:2 )
## save(R2b, file="R2b.rda")
## R3b = fullrun( s12, s12rma, incvarRectRegion, kppn, mostmr, chips=c(1:2,11) )
## save(R3b, file="R3b.rda")


