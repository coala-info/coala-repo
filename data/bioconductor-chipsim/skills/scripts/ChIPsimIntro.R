# Code example from 'ChIPsimIntro' vignette. See references/ for full tutorial.

### R code from vignette source 'ChIPsimIntro.Rnw'

###################################################
### code chunk number 1: seeding
###################################################
library(ChIPsim)
set.seed(1)


###################################################
### code chunk number 2: genome
###################################################
chrLen <- c(2e5, 1e5)
chromosomes <- sapply(chrLen, function(n) paste(sample(DNA_BASES, n, replace = TRUE), collapse = ""))
names(chromosomes) <- paste("CHR", seq_along(chromosomes), sep="")
genome <- DNAStringSet(chromosomes)


###################################################
### code chunk number 3: ChIPsimIntro.Rnw:114-115
###################################################
rm(chromosomes)


###################################################
### code chunk number 4: simulateQualities
###################################################
randomQuality <- function(read, ...){
	paste(sample(unlist(strsplit(rawToChar(as.raw(64:104)),"")), 
					nchar(read), replace = TRUE), collapse="")
}


###################################################
### code chunk number 5: output
###################################################
dfReads <- function(readPos, readNames, sequence, readLen, ...){
	
	## create vector to hold read sequences and qualities
	readSeq <- character(sum(sapply(readPos, sapply, length)))
	readQual <- character(sum(sapply(readPos, sapply, length)))
	
	idx <- 1
	## process read positions for each chromosome and strand
	for(k in length(readPos)){ ## chromosome
		for(i in 1:2){ ## strand
			for(j in 1:length(readPos[[k]][[i]])){
				## get (true) sequence
				readSeq[idx] <- as.character(readSequence(readPos[[k]][[i]][j], sequence[[k]], 
						strand=ifelse(i==1, 1, -1), readLen=readLen))
				## get quality
				readQual[idx] <- randomQuality(readSeq[idx])
				## introduce sequencing errors
				readSeq[idx] <- readError(readSeq[idx], decodeQuality(readQual[idx]))
				idx <- idx + 1
			}
		}
	}
	data.frame(name=unlist(readNames), sequence=readSeq, quality=readQual, 
			stringsAsFactors = FALSE)
}


###################################################
### code chunk number 6: simulation
###################################################
myFunctions <- defaultFunctions()
myFunctions$readSequence <- dfReads 
nReads <- 1000
simulated <- simChIP(nReads, genome, file = "", functions = myFunctions,
		control = defaultControl(readDensity=list(meanLength = 150)))


###################################################
### code chunk number 7: listSummary
###################################################
	names(simulated)


###################################################
### code chunk number 8: ChIPsimIntro.Rnw:220-221
###################################################
head(simulated$readSequence)


###################################################
### code chunk number 9: ChIPsimIntro.Rnw:226-234 (eval = FALSE)
###################################################
## feat <- simulated$features[[1]]
## stableIdx <- which(sapply(feat, inherits, "StableFeature"))
## start <- feat[[stableIdx[1]]]$start
## plot((start-2000):(start+500), simulated$bindDensity[[1]][(start-2000):(start+500)], xlab="Chromosome 1",
## 		ylab="Density", type='l')
## lines((start-2000):(start+500), simulated$readDensity[[1]][(start-2000):(start+500),1], col=4)
## lines((start-2000):(start+500), simulated$readDensity[[1]][(start-2000):(start+500),2], col=2)
## legend("topright", legend=c("Nucleosome density", "Read density (+)", "Read density (-)"), col=c(1,4,2), lwd=1)


###################################################
### code chunk number 10: ChIPsimIntro.Rnw:238-246
###################################################
feat <- simulated$features[[1]]
stableIdx <- which(sapply(feat, inherits, "StableFeature"))
start <- feat[[stableIdx[1]]]$start
plot((start-2000):(start+500), simulated$bindDensity[[1]][(start-2000):(start+500)], xlab="Chromosome 1",
		ylab="Density", type='l')
lines((start-2000):(start+500), simulated$readDensity[[1]][(start-2000):(start+500),1], col=4)
lines((start-2000):(start+500), simulated$readDensity[[1]][(start-2000):(start+500),2], col=2)
legend("topright", legend=c("Nucleosome density", "Read density (+)", "Read density (-)"), col=c(1,4,2), lwd=1)


###################################################
### code chunk number 11: transitions
###################################################
 transition <- list(Binding=c(Background=1), Background=c(Binding=0.05, Background=0.95))
 transition <- lapply(transition, "class<-", "StateDistribution")


###################################################
### code chunk number 12: initial
###################################################
 init <- c(Binding=0, Background=1)
 class(init) <- "StateDistribution"


###################################################
### code chunk number 13: bgEmission
###################################################
 backgroundFeature <- function(start, length=1000, shape=1, scale=20){
	 weight <- rgamma(1, shape=1, scale=20)
	 params <- list(start = start, length = length, weight = weight)
	 class(params) <- c("Background", "SimulatedFeature")
	 
	 params
 }


###################################################
### code chunk number 14: bindingEmission
###################################################
 bindingFeature <- function(start, length=500, shape=1, scale=20, enrichment=5, r=1.5){
	 stopifnot(r > 1)
	 
	 avgWeight <- shape * scale * enrichment
	 lowerBound <- ((r - 1) * avgWeight)
	 weight <- actuar::rpareto1(1, r, lowerBound)
	 
	 params <- list(start = start, length = length, weight = weight)
	 class(params) <- c("Binding", "SimulatedFeature")
	 
	 params
 }


###################################################
### code chunk number 15: features1_1
###################################################
 set.seed(1)
 generator <- list(Binding=bindingFeature, Background=backgroundFeature)
 
 features <- ChIPsim::makeFeatures(generator, transition, init, start = 0, length = 1e6, globals=list(shape=1, scale=20),
		 experimentType="TFExperiment", lastFeat=c(Binding = FALSE, Background = TRUE))


###################################################
### code chunk number 16: ChIPsimIntro.Rnw:404-410
###################################################
 bindIdx <- sapply(features, inherits, "Binding")
 
 plot(density(sapply(features[!bindIdx], "[[", "weight")), 
		 xlim=c(0,max(sapply(features, "[[", "weight"))), xlab="Sampling weight", main="")
 lines(density(sapply(features[bindIdx], "[[", "weight")), col=2)
 legend("topright", legend=c("Background", "Binding"), col=1:2, lty=1)


###################################################
### code chunk number 17: ChIPsimIntro.Rnw:417-418
###################################################
features[[1]]


###################################################
### code chunk number 18: features1_2
###################################################
 set.seed(1)
 features <- ChIPsim::placeFeatures(generator, transition, init, start = 0, length = 1e6, globals=list(shape=1, scale=20),
		 experimentType="TFExperiment", lastFeat=c(Binding = FALSE, Background = TRUE))


###################################################
### code chunk number 19: ChIPsimIntro.Rnw:441-442
###################################################
features[[1]]


###################################################
### code chunk number 20: featureDensity1
###################################################
constRegion <- function(weight, length) rep(weight, length)
featureDensity.Binding <- function(feature, ...) constRegion(feature$weight, feature$length)
featureDensity.Background <- function(feature, ...) constRegion(feature$weight, feature$length)


###################################################
### code chunk number 21: density1
###################################################
 dens <- ChIPsim::feat2dens(features)


###################################################
### code chunk number 22: readLoc1
###################################################
 readLoc <- sample(44000:64000, 1e3, prob=dens[44000:64000], replace=TRUE)


###################################################
### code chunk number 23: ChIPsimIntro.Rnw:471-486
###################################################
 start <- features[[min(which(bindIdx))]]$start
 length <- features[[min(which(bindIdx))]]$length
 par(mfrow=c(2,1))
 par(mar=c(0, 4.1, 1.1, 2.1))
 plot((start-10000):(start+10000), dens[(start-10000):(start+10000)], type='l',
		xlab="", ylab="Sampling weight", xaxt = 'n')
 abline(v=start, col="grey", lty=2)
 abline(v=start+length-1, col="grey", lty=2) 
 par(mar=c(4.1, 4.1, 0, 2.1))
 counts <- hist(readLoc, breaks=seq(44000-0.5, 64000.5, 1), plot = FALSE)$counts
 extReads <- zoo::rollmean(ts(counts), 200)*200
 plot(44100:63901,extReads, xlab="Position in genomic region", ylab="Read count", main="", 
		 type='l', xlim = c(start-10000, start+10000))
 abline(v=start, col="grey", lty=2)
 abline(v=start+length-1, col="grey", lty=2) 


###################################################
### code chunk number 24: reconcileFeatures
###################################################
	reconcileFeatures.TFExperiment <- function(features, ...){
		bindIdx <- sapply(features, inherits, "Binding")
		if(any(bindIdx))
			bindLength <- features[[min(which(bindIdx))]]$length
		else bindLength <- 1
		lapply(features, function(f){
				if(inherits(f, "Background"))
					f$weight <- f$weight/bindLength
				## The next three lines (or something to this effect)
				## are required by all 'reconcileFeatures' implementations. 
				f$overlap <- 0
				currentClass <- class(f)
				class(f) <- c(currentClass[-length(currentClass)], 
						"ReconciledFeature", currentClass[length(currentClass)])
				f
			})
	}


###################################################
### code chunk number 25: features2
###################################################
 set.seed(1)
 features <- ChIPsim::placeFeatures(generator, transition, init, start = 0, length = 1e6, globals=list(shape=1, scale=20),
		 experimentType="TFExperiment", lastFeat=c(Binding = FALSE, Background = TRUE), 
		 control=list(Binding=list(length=50)))


###################################################
### code chunk number 26: ChIPsimIntro.Rnw:547-548
###################################################
	features[[1]]


###################################################
### code chunk number 27: featureDensity2
###################################################
 featureDensity.Binding <- function(feature, ...){
	 featDens <- numeric(feature$length)
	 featDens[floor(feature$length/2)] <- feature$weight
	 featDens
 }


###################################################
### code chunk number 28: density2
###################################################
	dens <- ChIPsim::feat2dens(features, length = 1e6)


###################################################
### code chunk number 29: fragmentLength
###################################################
	fragLength <- function(x, minLength, maxLength, meanLength, ...){
		sd <- (maxLength - minLength)/4
		prob <- dnorm(minLength:maxLength, mean = meanLength, sd = sd)
		prob <- prob/sum(prob)
		prob[x - minLength + 1]
	}


###################################################
### code chunk number 30: readDens
###################################################
	readDens <- ChIPsim::bindDens2readDens(dens, fragLength, bind = 50, minLength = 150, maxLength = 250,
			meanLength = 200) 


###################################################
### code chunk number 31: ChIPsimIntro.Rnw:594-606
###################################################
 bindIdx <- sapply(features, inherits, "Binding")
 start <- features[[min(which(bindIdx))]]$start
 length <- features[[min(which(bindIdx))]]$length
 par(mfrow=c(2,1))
 par(mar=c(0, 4.1, 1.1, 2.1))
 plot((start-10000):(start+10000), dens[(start-10000):(start+10000)], type='l',
		 xlab="", ylab="Sampling weight", xaxt='n')
 par(mar=c(4.1, 4.1, 0, 2.1))
 plot((start-10000):(start+10000), readDens[(start-10000):(start+10000), 1], col=4, type='l',
		 xlab="Position in genomic region", ylab="Sampling weight")
 lines((start-10000):(start+10000), readDens[(start-10000):(start+10000), 2], col=2)
 legend("topleft", legend=c("forward", "reverse"), col=c(4,2), lty=1)


###################################################
### code chunk number 32: readLoc2
###################################################
	readLoc <- ChIPsim::sampleReads(readDens, 1e5)


###################################################
### code chunk number 33: ChIPsimIntro.Rnw:626-647
###################################################
	fwdCount <- hist(readLoc$fwd, breaks=seq(0.5, 1000000.5, by=1), plot=FALSE)$counts
	revCount <- hist(readLoc$rev, breaks=seq(0.5, 1000000.5, by=1), plot=FALSE)$counts
	fwdExt <- zoo::rollmean(ts(fwdCount[(start-1000):(start+1050)]), 200, align="right")*200
	revExt <- zoo::rollmean(ts(revCount[(start-1000):(start+1050)]), 200, align="left")*200
	
	par(mfrow=c(2,1))
	mar.old <- par("mar")
	par(mar=c(0, 4.1, 1.1, 2.1))
	plot((start-1000):(start+1050) ,fwdCount[(start-1000):(start+1050)], col="lightblue",
			type='h', xlab="", ylab="Read count / density", ylim=c(0, 2),
			xlim=c(start-975, start+1025), xaxt='n')
	lines((start-975):(start+1025) ,revCount[(start-975):(start+1025)], col="mistyrose2", type='h')
	lines((start-10000):(start+10000), dens[(start-10000):(start+10000)])
	lines((start-10000):(start+10000), readDens[(start-10000):(start+10000), 1], col=4)
	lines((start-10000):(start+10000), readDens[(start-10000):(start+10000), 2], col=2)
	par(mar=c(4.1, 4.1, 0, 2.1))
	plot((start-801):(start+851), fwdExt+revExt, xlim=c(start-975, start+1025), 
			xlab="Position in genomic region", ylab="Overlap count", type='s')
	lines((start-801):(start+1050), fwdExt, col=4)
	lines((start-1000):(start+851), revExt, col=2)
	abline(v=c(start-150, start+200), col="grey", lty=2)


###################################################
### code chunk number 34: ChIPsimIntro.Rnw:666-694
###################################################
	randomQuality <- function(read, ...){
		paste(sample(unlist(strsplit(rawToChar(as.raw(64:104)),"")), 
						nchar(read), replace = TRUE), collapse="")
	}
	dfReads <- function(readPos, readNames, sequence, readLen, ...){
		## create vector to hold read sequences and qualities
		readSeq <- character(sum(sapply(readPos, sapply, length)))
		readQual <- character(sum(sapply(readPos, sapply, length)))
		
		idx <- 1
		## process read positions for each chromosome and strand
		for(k in length(readPos)){ ## chromosome
			for(i in 1:2){ ## strand
				for(j in 1:length(readPos[[k]][[i]])){
					## get (true) sequence
					readSeq[idx] <- as.character(ChIPsim::readSequence(readPos[[k]][[i]][j], sequence[[k]], 
									strand=ifelse(i==1, 1, -1), readLen=readLen))
					## get quality
					readQual[idx] <- randomQuality(readSeq[idx])
					## introduce sequencing errors
					readSeq[idx] <- ChIPsim::readError(readSeq[idx], ChIPsim::decodeQuality(readQual[idx]))
					idx <- idx + 1
				}
			}
		}
		data.frame(name=unlist(readNames), sequence=readSeq, quality=readQual, 
				stringsAsFactors = FALSE)
	}


###################################################
### code chunk number 35: ChIPsimIntro.Rnw:701-703
###################################################
	myFunctions <- ChIPsim::defaultFunctions()
	myFunctions$readSequence <- dfReads


###################################################
### code chunk number 36: ChIPsimIntro.Rnw:707-712
###################################################
	featureArgs <- list(generator=generator, transition=transition, init=init, start = 0, 
			length = 1e6, globals=list(shape=1, scale=20), experimentType="TFExperiment", 
			lastFeat=c(Binding = FALSE, Background = TRUE), control=list(Binding=list(length=50)))
	readDensArgs <- list(fragment=fragLength, bind = 50, minLength = 150, maxLength = 250,
			meanLength = 200)


###################################################
### code chunk number 37: simulation
###################################################
	genome <- Biostrings::DNAStringSet(c(CHR=paste(sample(Biostrings::DNA_BASES, 1e6, replace = TRUE), collapse = "")))
	set.seed(1)
	simulated <- ChIPsim::simChIP(1e4, genome, file = "", functions = myFunctions,
			control = ChIPsim::defaultControl(features=featureArgs, readDensity=readDensArgs))


###################################################
### code chunk number 38: ChIPsimIntro.Rnw:724-725
###################################################
	all.equal(readDens, simulated$readDensity[[1]])


###################################################
### code chunk number 39: ChIPsimIntro.Rnw:730-731
###################################################
sessionInfo()


