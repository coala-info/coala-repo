# Code example from 'HELP' vignette. See references/ for full tutorial.

### R code from vignette source 'HELP.Rnw'

###################################################
### code chunk number 1: HELP.Rnw:45-46
###################################################
library(HELP)


###################################################
### code chunk number 2: HELP.Rnw:48-49
###################################################
data.path <- system.file("pipeline.data", package="HELP")


###################################################
### code chunk number 3: HELP.Rnw:81-95
###################################################
msp1.files <- dir(data.path, pattern="532[._]pair", full.names=TRUE)
hpa2.files <- dir(data.path, pattern="635[._]pair", full.names=TRUE)
N <- length(msp1.files)
for (i in 1:N) {
	if (i == 1) {
		pairs <- readPairs(msp1.files[i],hpa2.files[i])
	}
	else {
		pairs <- readPairs(msp1.files[i],hpa2.files[i],pairs)
	}
}
class(pairs)
dim(pairs)
sampleNames(pairs)


###################################################
### code chunk number 4: HELP.Rnw:105-111
###################################################
chips <- sub("[_.]*532[_.]*pair.*","",basename(msp1.files))
chips ## CHIP_IDs
samplekey <- file.path(data.path, "sample.key.txt")
chips <- readSampleKey(file=samplekey,chips=chips)
chips ## SAMPLEs (from supplied key)
sampleNames(pairs) <- chips


###################################################
### code chunk number 5: HELP.Rnw:121-126
###################################################
ndf.file <- file.path(data.path, "HELP.ndf.txt")
ngd.file <- file.path(data.path, "HELP.ngd.txt")
pairs <- readDesign(ndf.file, ngd.file, pairs)
pData(featureData(pairs))[1:10,c("CHR","START","STOP")]
getFeatures(pairs,"SEQUENCE")[1]


###################################################
### code chunk number 6: HELP.Rnw:137-139
###################################################
calcTm("ATCTAGGAAGATTTAGAGAGGCAATGTGTCATTTAGCATCTAATTTTACC")
calcTm(getFeatures(pairs,"SEQUENCE")[1:4])


###################################################
### code chunk number 7: HELP.Rnw:145-147
###################################################
calcGC("ATCTAGGAAGATTTAGAGAGGCAATGTGTCATTTAGCATCTAATTTTACC")
calcGC(getFeatures(pairs,"SEQUENCE")[1:4])


###################################################
### code chunk number 8: HELP.Rnw:163-165
###################################################
getSamples(pairs)[1:4,]
calcPrototype(pairs,center=FALSE)[1:4]


###################################################
### code chunk number 9: fig1
###################################################
plotChip(pairs, sample="Brain2")


###################################################
### code chunk number 10: fig2
###################################################
x <- rep(1:100,100)
y <- rep(1:100,each=100)
z <- x*(1001:11000/1000)
z <- z-mean(z)
z <- z*(sample(1:10000/10000)+1)
plotChip(x,y,z,main="Curved gradient",xlab="x",ylab="y")


###################################################
### code chunk number 11: HELP.Rnw:222-224
###################################################
exprs(pairs) <- log2(exprs(pairs))
exprs2(pairs) <- log2(exprs2(pairs))


###################################################
### code chunk number 12: fig3
###################################################
plotFeature(pairs[,"Brain2"],cex=0.5)


###################################################
### code chunk number 13: HELP.Rnw:247-255
###################################################
slopes <- (seq(from=1,to=10,length.out=20)-5.5)/4.5
x <- c()
for (i in 1:20) {
for (j in 1:10) {
x <- c(x,seq(from=0,to=slopes[i]*j,length.out=10))
}
}
y <- rep(1:20,each=100)


###################################################
### code chunk number 14: fig4
###################################################
plot(density(x),main="")
for (i in 1:20) {
d <- density(x[which(y==i)])
lines(d$x,0.3*d$y/max(d$y),col=rainbow(n=20,start=0,end=0.66)[21-i])
}
lines(density(x))


###################################################
### code chunk number 15: fig5
###################################################
x2 <- quantileNormalize(x,y,num.bins=20,num.steps=1,mode="discrete")
d2 <- density(x2)
plot(c(min(d2$x), max(d2$x)), c(0, 20), type="p", cex=0, ylab="Density (by bin)", xlab="", main="")
for (i in 1:20) {
d <- density(x2[which(y==i)])
lines(d$x, 0.5*i+0.25*(1+i/20)*20*d$y/max(d$y), col=rainbow(n=20,start=0,end=0.66)[21-i], lty="solid")
}


###################################################
### code chunk number 16: HELP.Rnw:304-307
###################################################
rand <- which(getFeatures(pairs, "TYPE")=="RAND")
msp.rand <- getSamples(pairs, element="exprs")[rand,]
hpa.rand <- getSamples(pairs, element="exprs2")[rand,]


###################################################
### code chunk number 17: HELP.Rnw:310-317
###################################################
msp.rand.med <- apply(msp.rand, 2, median)
msp.rand.mad <- apply(msp.rand, 2, mad)
hpa.rand.med <- apply(hpa.rand, 2, median)
hpa.rand.mad <- apply(hpa.rand, 2, mad)
msp.fail <- msp.rand.med + 2.5*msp.rand.mad
hpa.fail <- hpa.rand.med + 2.5*hpa.rand.mad
hpa.meth <- apply(hpa.rand, 2, quantile, 0.99)


###################################################
### code chunk number 18: HELP.Rnw:320-327
###################################################
norand <- which(getFeatures(pairs, "TYPE")=="DATA")
size <- as.numeric(getFeatures(pairs, "SIZE"))[norand]
msp <- getSamples(pairs, "Brain2", element="exprs")[norand]
hpa <- getSamples(pairs, "Brain2", element="exprs2")[norand]
nofail <- which(msp>msp.fail["Brain2"] | hpa>hpa.fail["Brain2"])
msp.norm <- msp
msp.norm[nofail] <- quantileNormalize(msp[nofail],size[nofail])


###################################################
### code chunk number 19: HELP.Rnw:330-335
###################################################
meth <- which(msp>msp.fail["Brain2"] & hpa<=hpa.meth["Brain2"])
hpa.norm <- hpa
hpa.norm[meth] <- quantileNormalize(hpa[meth],size[meth])
nometh <- which(hpa>hpa.meth["Brain2"])
hpa.norm[nometh] <- quantileNormalize(hpa[nometh],size[nometh])


###################################################
### code chunk number 20: HELP.Rnw:339-344
###################################################
pairs.norm <- pairs
exprs(pairs.norm)[norand, "Brain2"] <- msp.norm
exprs2(pairs.norm)[norand, "Brain2"] <- hpa.norm
getSamples(pairs, element="exprs")[1:5,]
getSamples(pairs.norm, element="exprs")[1:5,]


###################################################
### code chunk number 21: HELP.Rnw:363-367
###################################################
data <- getSamples(pairs,element="exprs2")
seqids <- getFeatures(pairs,'SEQ_ID')
weight <- getSamples(pairs,element="exprs")
combineData(data, seqids, weight, trim=0.2)[1:5,]


###################################################
### code chunk number 22: HELP.Rnw:371-372
###################################################
combineData(pairs, feature.group='SEQ_ID', trim=0.2)[1:5,]


###################################################
### code chunk number 23: fig6
###################################################
plotPairs(pairs,element="exprs2")


