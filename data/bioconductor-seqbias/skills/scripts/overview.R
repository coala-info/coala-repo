# Code example from 'overview' vignette. See references/ for full tutorial.

### R code from vignette source 'overview.Rnw'

###################################################
### code chunk number 1: overview.Rnw:51-56
###################################################
library(seqbias)
library(Rsamtools)
ref_fn <- system.file( "extra/example.fa", package = "seqbias" )
ref_f <- FaFile( ref_fn )
open.FaFile( ref_f )


###################################################
### code chunk number 2: overview.Rnw:60-61
###################################################
reads_fn <- system.file( "extra/example.bam", package = "seqbias" )


###################################################
### code chunk number 3: overview.Rnw:93-94
###################################################
ref_seqs <- scanFaIndex( ref_f )


###################################################
### code chunk number 4: overview.Rnw:102-103
###################################################
I <- random.intervals( ref_seqs, n = 5, m = 100000 )


###################################################
### code chunk number 5: overview.Rnw:111-112
###################################################
seqs <- scanFa( ref_f, I )


###################################################
### code chunk number 6: overview.Rnw:118-120
###################################################
neg_idx <- as.logical( I@strand == '-' )
seqs[neg_idx] <- reverseComplement( seqs[neg_idx] )


###################################################
### code chunk number 7: overview.Rnw:128-129
###################################################
counts <- count.reads( reads_fn, I, binary = T )


###################################################
### code chunk number 8: overview.Rnw:141-142
###################################################
freqs <- kmer.freq( seqs, counts )


###################################################
### code chunk number 9: fig1
###################################################
if( require(ggplot2) ) {
  P <- qplot( x = pos,
              y = freq,
              ylim = c(0.15,0.4),
              color = seq,
              data  = freqs,
              geom  = "line" )
  P <- P + facet_grid( seq ~ . )
  print(P)
} else {
  par( mar = c(5,1,1,1), mfrow = c(4,1) )
  with( subset( freqs, seq == "a" ),
        plot( freq ~ pos, ylim = c(0.15,0.4), sub = "a", type = 'l' ) )
  with( subset( freqs, seq == "c" ),
        plot( freq ~ pos, ylim = c(0.15,0.4), sub = "c", type = 'l' ) )
  with( subset( freqs, seq == "g" ),
        plot( freq ~ pos, ylim = c(0.15,0.4), sub = "g", type = 'l' ) )
  with( subset( freqs, seq == "t" ),
        plot( freq ~ pos, ylim = c(0.15,0.4), sub = "t", type = 'l' ) )
} 


###################################################
### code chunk number 10: overview.Rnw:194-195
###################################################
sb <- seqbias.fit( ref_fn, reads_fn, L = 5, R = 15 )


###################################################
### code chunk number 11: overview.Rnw:209-210
###################################################
bias <- seqbias.predict( sb, I )


###################################################
### code chunk number 12: overview.Rnw:217-218
###################################################
counts.adj <- mapply( FUN = `/`, counts, bias, SIMPLIFY = F )


###################################################
### code chunk number 13: overview.Rnw:222-223
###################################################
freqs.adj <- kmer.freq( seqs, counts.adj )


###################################################
### code chunk number 14: fig2
###################################################
if( require(ggplot2) ) {
  P <- qplot( x = pos,
              y = freq,
              ylim = c(0.15,0.4),
              color = seq,
              data  = freqs.adj,
              geom  = "line" )
  P <- P + facet_grid( seq ~ . )
  print(P)
} else {
  par( mar = c(5,1,1,1), mfrow = c(4,1) )
  with( subset( freqs.adj, seq == "a" ),
        plot( freq ~ pos, ylim = c(0.15,0.4), sub = "a", type = 'l' ) )
  with( subset( freqs.adj, seq == "c" ),
        plot( freq ~ pos, ylim = c(0.15,0.4), sub = "c", type = 'l' ) )
  with( subset( freqs.adj, seq == "g" ),
        plot( freq ~ pos, ylim = c(0.15,0.4), sub = "g", type = 'l' ) )
  with( subset( freqs.adj, seq == "t" ),
        plot( freq ~ pos, ylim = c(0.15,0.4), sub = "t", type = 'l' ) )
}


###################################################
### code chunk number 15: overview.Rnw:265-269
###################################################
seqbias.save( sb, "my_seqbias_model.yml" )

# load the model sometime later
sb <- seqbias.load( ref_fn, "my_seqbias_model.yml" )


###################################################
### code chunk number 16: overview.Rnw:278-279
###################################################
sessionInfo()


