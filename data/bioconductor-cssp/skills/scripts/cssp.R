# Code example from 'cssp' vignette. See references/ for full tutorial.

### R code from vignette source 'cssp.rnw'
### Encoding: UTF-8

###################################################
### code chunk number 1: constructbin
###################################################
library( CSSP )
data( bindata.chr1 )
#break the data.frame into different files
write.table( bindata.chr1[,c(1,4)], file = "chr1_map.txt", sep = "\t", 
            row.names = FALSE, col.names = FALSE )
write.table( bindata.chr1[,c(1,5)], file = "chr1_gc.txt", sep = "\t",
             row.names = FALSE, col.names = FALSE )
write.table( bindata.chr1[,c(1,2)], file = "chr1_chip.txt", sep = "\t",
             row.names = FALSE, col.names = FALSE )
write.table( bindata.chr1[,c(1,3)], file = "chr1_input.txt", sep = "\t",
             row.names = FALSE, col.names = FALSE )
#read the text files and construct a unified data.frame
dat <- readBinFile ( type = c("chip", "input","M","GC"),
                   fileName = c("chr1_chip.txt", "chr1_input.txt",
                     "chr1_map.txt", "chr1_gc.txt" ) )
file.remove( paste( "chr1_", c("chip", "input", "map", "gc" ), ".txt", sep = "" ) )
head( dat )


###################################################
### code chunk number 2: createBinData
###################################################
#convert read alignments to bin-level counts
data( tagdat_chip )
data( tagdat_input )
dat_chip <- tag2bin( tagdat_chip, binS = 100, fragL = 100 )
dat_input <- tag2bin( tagdat_input, binS = 100, fragL = 100 )

#construct M, GC and N text files
numBins <- as.integer( runif(5, 190, 220 ))
mapdat <- gcdat <- ndat <- list(1:5)
allmapdat <- allgcdat <- allndat <- NULL
for(i in 1:5){
  mapdat[[i]] <- data.frame( pos = ( 0:(numBins[i]-1 ) ) * 100,
                            M = runif( numBins[i], 0.9, 1 ) )
  gcdat[[i]] <- data.frame( pos = ( 0:( numBins[i]-1 ) ) * 100,
                           GC = runif( numBins[i], 0.5, 1 ) )
  ndat[[i]] <- data.frame( pos = ( 0:( numBins[i]-1 ) ) * 100,
                          N = rbinom( numBins[i], 1, 0.01 ) )
  allmapdat <- rbind( allmapdat, 
                     cbind( paste("chr", i, sep="" ), mapdat[[i]] ))
  allgcdat <- rbind( allgcdat,
                    cbind( paste( "chr", i, sep=""), gcdat[[i]] ))
  allndat <- rbind( allndat,
                   cbind( paste("chr", i, sep=""), ndat[[i]]))
  
  write.table(mapdat[[i]], file = paste( "map_chr", i, ".txt", sep = "" ), 
              sep = "\t",  row.names = FALSE, col.names = FALSE)
  write.table(gcdat[[i]], file = paste( "gc_chr", i, ".txt", sep = "" ),
              sep = "\t",  row.names = FALSE, col.names = FALSE)
  write.table(ndat[[i]], file = paste( "n_chr", i, ".txt", sep = "" ), 
              sep = "\t",  row.names = FALSE, col.names = FALSE)
}
write.table( allmapdat, file = "allmap.txt", sep = "\t", 
            row.names = FALSE, col.names = FALSE )
write.table( allgcdat, file = "allgc.txt", sep = "\t",
            row.names = FALSE, col.names = FALSE )
write.table( allndat, file = "alln.txt", sep = "\t",
            row.names = FALSE, col.names = FALSE )

#construct BinData object
#all M, GC, N files are seperate for each chromosome
bindata1 <- createBinData( dat_chip, dat_input, mfile = "map_", gcfile = "gc_", 
                          nfile = "n_", m.suffix = ".txt", gc.suffix = ".txt", 
                          n.suffix = ".txt", chrlist = NULL, 
                          dataType = "unique" )


###################################################
### code chunk number 3: createBinData1 (eval = FALSE)
###################################################
## #GC, N files seperate for each chromosome, M file is genome-wide
## bindata2 <- createBinData( dat_chip, dat_input, mfile = "allmap.txt", 
##                           gcfile = "gc_", nfile = "n_", m.suffix = NULL, 
##                           gc.suffix = ".txt", n.suffix = ".txt",   
##                           chrlist = NULL, dataType = "unique" )
## #M, N files seperate for each chromosome, GC file is genome-wide
## bindata3 <- createBinData( dat_chip, dat_input, mfile = "map_", 
##                           gcfile = "allgc.txt", nfile = "n_", m.suffix = ".txt", 
##                           gc.suffix = NULL, n.suffix = ".txt",  
##                           chrlist = NULL, dataType = "unique" )
## #GC, M files seperate for each chromosome, N file is genome-wide
## bindata4 <- createBinData( dat_chip, dat_input, mfile = "map_", gcfile = "gc_", 
##                           nfile = "alln.txt", m.suffix = ".txt",
##                           gc.suffix = ".txt", n.suffix = NULL,  
##                           chrlist = NULL, dataType = "unique" )
## #only imports data for chr1 and chr2
## bindata5 <- createBinData( dat_chip, dat_input, mfile = "map_", gcfile = "gc_", 
##                           nfile = "n_", m.suffix = ".txt", gc.suffix = ".txt",
##                           n.suffix = ".txt", chrlist = c("chr1", "chr2"),
##                           dataType = "unique" )


###################################################
### code chunk number 4: cssp.rnw:142-152
###################################################
#remove the text files
for( i in 1:5 ){
  for( j in c( "map_", "gc_", "n_" )){
    file.remove( paste( j, "chr", i, ".txt", sep="" ))
  }
}
file.remove( "allmap.txt" )
file.remove( "alln.txt" )
file.remove( "allgc.txt" )



###################################################
### code chunk number 5: 3
###################################################
sampleFit <- cssp.fit( bindata1, ngc=0, beta.init=NULL, e0.init=0.9, p2=0.99,
                      p1=0.5, tol=0.01)


###################################################
### code chunk number 6: cssp.rnw:169-170 (eval = FALSE)
###################################################
## sampleFit.grid <- cssp.fit( bindata1, useGrid = TRUE, nsize = 500 )


###################################################
### code chunk number 7: cssp.rnw:175-178 (eval = FALSE)
###################################################
## sampleFit.np <- cssp.fit( bindata1, nonpa = TRUE )
## 
## sampleFit.zi <- cssp.fit( bindata1, nonpa = TRUE, zeroinfl = TRUE )


###################################################
### code chunk number 8: 5 (eval = FALSE)
###################################################
## sampleFit.gem <- cssp.fit( bindata1, ngc = 0, beta.init = NULL, e0.init = 0.9, 
##                           tol = 0.01, method = "gem" )


###################################################
### code chunk number 9: cssp.rnw:190-194
###################################################
slotNames( sampleFit )
sampleFit@b
sampleFit@e0
head( sampleFit@mu.chip )


###################################################
### code chunk number 10: 4
###################################################
slotNames( sampleFit )


###################################################
### code chunk number 11: cssp.rnw:202-205 (eval = FALSE)
###################################################
## ## code for Fig 1
## plot( sampleFit@pvalue, seq( 0, 1, length = length( sampleFit@pvalue ) ),
##      xlab = "P-value", ylab = "Cumulative Probability", cex = 0.3 )


###################################################
### code chunk number 12: cssp.rnw:208-213
###################################################
## code for Fig 1
pdf("pval_fit.pdf",height=4,width=4)
plot( sampleFit@pvalue, seq(0,1,length=length(sampleFit@pvalue)),
     xlab="P-value", ylab="Cumulative Probability", cex=0.3)
dev.off()


###################################################
### code chunk number 13: cssp.rnw:218-219
###################################################
freqFit <- fit.freq(sampleFit, bindata1@tagCount)


###################################################
### code chunk number 14: cssp.rnw:222-227 (eval = FALSE)
###################################################
## ## code for Fig 2
## plot( freqFit$freq ~ freqFit$count, ylab = "Frequency",
##      xlab = "Count", lty = 2, type = "l" )
## lines( freqFit$freq.est ~ freqFit$count, lty = 1 )
## legend( "topright", c( "Empirical", "Fitted" ), lty = 2:1 )


###################################################
### code chunk number 15: cssp.rnw:230-238
###################################################
pdf("freq_fit.pdf",width=4,height=4)
plot(freqFit$freq ~ freqFit$count,
     ylab="Frequency", xlab="Count", lty=2, type="l")
lines(freqFit$freq.est ~ freqFit$count,
      lty=1)
legend("topright", c("Empirical", "Fitted"),
       lty=2:1)
dev.off()


###################################################
### code chunk number 16: 6
###################################################
cssp.power( fit = sampleFit, x = sampleFit@lambday, ite = 5, fold = 2, 
           min.count = 0, useC = TRUE )


###################################################
### code chunk number 17: 7
###################################################
power.fit<-sapply( (1:5)/5, function(x)
                    {
                      cssp.power( fit = sampleFit, x = sampleFit@lambday*x,
                                 ite = 5, fold = 0, min.count = 0,useC = TRUE )
                    })


###################################################
### code chunk number 18: cssp.rnw:272-276
###################################################
pdf("power_fit.pdf",width=4,height=4)
plot(power.fit ~ seq(20,100,length=5), ylab="Power", type="l",
     xlab="% of Depth")
dev.off()


###################################################
### code chunk number 19: cssp.rnw:285-288
###################################################
power.fit
plot(power.fit~seq(20,100,length=5), ylab="Power", type="l",
     xlab="Sequencing Depth")


###################################################
### code chunk number 20: 8
###################################################
fit.tail1 <- qBBT( fit = sampleFit, prob = 0.99, depth = sampleFit@lambday )
fit.tail2 <- qBBT( fit = sampleFit, prob = 0.99, depth = sampleFit@lambday/10 )


###################################################
### code chunk number 21: cssp.rnw:298-300
###################################################
fit.tail1
fit.tail2


###################################################
### code chunk number 22: cssp.rnw:305-307 (eval = FALSE)
###################################################
## cssp.power( fit = sampleFit, x = sampleFit@lambday*0.1, ite = 5,
##            fold = 2, min.count = fit.tail2, useC = TRUE )


###################################################
### code chunk number 23: 11
###################################################
data( bindpos )
bind.count <- bindcount( tagdat_chip, tagdat_input, bindpos = bindpos, fragL = 100,
                             whs = 200 )
summary( bind.count[["chr1"]] )


###################################################
### code chunk number 24: 11
###################################################
data( peakpos )
peak.count <- peakcount( tagdat_chip, tagdat_input, peakpos = peakpos, fragL = 100 )
summary( peak.count[["chr1"]] )


###################################################
### code chunk number 25: cssp.rnw:333-341
###################################################
thr.fold <- min( c( bind.count[[1]]$chip / bind.count[[1]]$input,
                   bind.count[[2]]$chip / bind.count[[2]]$input,
                   bind.count[[3]]$chip / bind.count[[3]]$input,
                   bind.count[[4]]$chip / bind.count[[4]]$input,
                   bind.count[[5]]$chip / bind.count[[5]]$input ) )*
  sampleFit@lambdax / sampleFit@lambday / sampleFit@e0
thr.count <- min( c( bind.count[[1]]$chip, bind.count[[2]]$chip,
                   bind.count[[3]]$chip, bind.count[[4]]$chip, bind.count[[5]]$chip ) )


###################################################
### code chunk number 26: cssp.rnw:346-348 (eval = FALSE)
###################################################
## cssp.power( fit = sampleFit, x = sampleFit@lambday, ite = 5, fold = thr.fold,
##            min.count = thr.count, qval = 0.05, useC = TRUE )


###################################################
### code chunk number 27: 12
###################################################
print(sessionInfo())


