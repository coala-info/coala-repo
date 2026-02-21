# Code example from 'ReQON' vignette. See references/ for full tutorial.

### R code from vignette source 'ReQON.Rnw'

###################################################
### code chunk number 1: style
###################################################
BiocStyle::latex()


###################################################
### code chunk number 2: ReQON.Rnw:46-54
###################################################
library( ReQON )
library( seqbias )
library( Rsamtools )
reads_fn <- system.file( "extra/example.bam", package = "seqbias" )
# sort BAM
sorted <- sortBam( reads_fn, tempfile() )
# index BAM
indexBam( sorted )


###################################################
### code chunk number 3: ReQON.Rnw:67-88
###################################################
ref_fn <- system.file( "extra/example.fa", package = "seqbias" )
ref_f <- FaFile( ref_fn )
open.FaFile( ref_f )
seqs <- scanFa( ref_f )
len <- length( seqs[[1]] )

ref <- matrix( nrow = len, ncol = 3 )
# chromosome/sequence name in column 1
ref[,1] <- rep( "seq1", len )			
# sequence position in column 2
ref[,2] <- c( 1:len )
# reference base in column 3
str <- toString( subseq( seqs[[1]], 1, len ) )
s <- strsplit( str, NULL )
ref[,3] <- s[[1]]
# look at reference file
ref[1:5,]

# save reference file
write.table( ref, file = "ref_seq.txt", sep = "\t", quote = FALSE, 
   row.names = FALSE, col.names = FALSE )


###################################################
### code chunk number 4: ReQON.Rnw:109-117
###################################################
# set training region
reg <- paste( "seq1:1-", len, sep = "" )
diagnostics <- ReQON( sorted, "Recalibrated_example.bam", region = reg, 
   RefSeq = "ref_seq.txt", nerr = 20, nraf = 0.25, 
   plotname = "Recalibrated_example_plots.pdf" )

# delete reference sequence file	
unlink( "ref_seq.txt" )


###################################################
### code chunk number 5: ReQON.Rnw:148-153
###################################################
# show the error counts by read position
diagnostics$ReadPosErrors

# plot
ReadPosErrorPlot( diagnostics$ReadPosErrors, startpos = 0 )


###################################################
### code chunk number 6: ReQON.Rnw:164-166
###################################################
# plot
QualFreqPlot( diagnostics$QualFreqBefore, diagnostics$QualFreqAfter )


###################################################
### code chunk number 7: ReQON.Rnw:188-200
###################################################
# report FWSE from ReQON output
diagnostics$FWSE

# plot before recalibration and report FWSE
f1 <- FWSEplot(diagnostics$ErrRatesBefore, diagnostics$QualFreqBefore, 
   col = "blue", main_title = "Reported vs. Empirical Quality: Before")
f1

# plot after recalibration and report FWSE
f2 <- FWSEplot(diagnostics$ErrRatesAfter, diagnostics$QualFreqAfter, 
   col = "red", main_title = "Reported vs. Empirical Quality: After")
f2      


