# Code example from 'tutorial' vignette. See references/ for full tutorial.

### R code from vignette source 'tutorial.Rnw'

###################################################
### code chunk number 1: read-tab (eval = FALSE)
###################################################
## df <- read.table("exptData.txt", header=TRUE)


###################################################
### code chunk number 2: chromos
###################################################
chr.lens <- structure(c(247249719L, 242951149L, 199501827L,
    191273063L, 180857866L, 170899992L, 158821424L, 146274826L,
    140273252L, 135374737L, 134452384L, 132349534L, 114142980L,
    106368585L, 100338915L, 88827254L, 78774742L, 76117153L,
    63811651L, 62435964L, 46944323L, 49691432L, 154913754L,
    57772954L), .Names = c("chr1", "chr2", "chr3", "chr4", "chr5",
    "chr6", "chr7", "chr8", "chr9", "chr10", "chr11", "chr12",
    "chr13", "chr14", "chr15", "chr16", "chr17", "chr18", "chr19",
    "chr20", "chr21", "chr22", "chrX", "chrY"))


###################################################
### code chunk number 3: chr-samples
###################################################
set.seed(13245)
chr.names <- names(chr.lens)
chr.factor <- factor(chr.names,chr.names)
chrs <- sample(chr.factor,40000,repl=TRUE,
	       prob=chr.lens)
chr.ns <- table(chrs)
sample.pos <- function(x,y) sort(sample(y,x,repl=TRUE))
chr.pos <-
    mapply( sample.pos, chr.ns,chr.lens,SIMPLIFY=FALSE)
df <-
    data.frame(chromo=rep(chr.factor,chr.ns),
	       pos=unlist(chr.pos))


###################################################
### code chunk number 4: grp-samp
###################################################
df$grp <-
    rbinom(40000, 1, 0.5)==1


###################################################
### code chunk number 5: null-run
###################################################
require(geneRxCluster,quietly=TRUE)
null.results <-
    gRxCluster(df$chromo,df$pos,df$grp,15L:30L,nperm=100L)
as.data.frame(null.results)[,c(-4,-5)]


###################################################
### code chunk number 6: grxsmry
###################################################
gRxSummary( null.results )


###################################################
### code chunk number 7: sim-true
###################################################
clump.chrs <- sample(chr.factor,30,repl=TRUE,
		 prob=chr.lens)


###################################################
### code chunk number 8: tutorial.Rnw:182-184
###################################################
clump.chr.pos.bound <-
    sapply(chr.lens[clump.chrs], function(y) sample.pos(1,y))


###################################################
### code chunk number 9: tutorial.Rnw:189-190
###################################################
clump.site.ns <- rep(c(15,25,40),each=10)


###################################################
### code chunk number 10: tutorial.Rnw:195-209
###################################################
clump.sites <-
    lapply(seq_along(clump.chrs),
	   function(x) {
	       chromo <- clump.chrs[x]
	       n <- clump.site.ns[x]
	       ctr <- clump.chr.pos.bound[x]
	       chrLen <- chr.lens[chromo]
	       if (ctr<chrLen/2)
		   {
		       ctr + sample(1e6,n)
		   } else {
		       ctr - sample(1e6,n)
		   }
	   })


###################################################
### code chunk number 11: tutorial.Rnw:214-215
###################################################
clump.grps <- rep(0:1,15)==1


###################################################
### code chunk number 12: tutorial.Rnw:220-228
###################################################
df2 <- data.frame(
    chromo=rep(clump.chrs,clump.site.ns),
    pos=unlist(clump.sites),
    grp=rep(clump.grps,clump.site.ns)
    )

df3 <- rbind(df,df2)
df3 <- df3[order(df3$chromo,df3$pos),]


###################################################
### code chunk number 13: alt-clumps
###################################################
alt.results <-
    gRxCluster(df3$chromo,df3$pos,df3$grp,
	       15L:30L, nperm=100L)
gRxSummary(alt.results)


###################################################
### code chunk number 14: torf-disc
###################################################
df2.GRanges <-
    GRanges(seqnames=df2$chromo,IRanges(start=df2$pos,width=1),
	    clump=rep(1:30,clump.site.ns))


###################################################
### code chunk number 15: tutorial.Rnw:256-257
###################################################
clumps.found <- subjectHits(findOverlaps(alt.results,df2.GRanges))


###################################################
### code chunk number 16: tutorial.Rnw:263-266
###################################################
matrix(
    table(factor(df2.GRanges$clump[ clumps.found ],1:30)),
    nrow=10,dimnames=list(clump=NULL,site.ns=c(15,25,40)))


###################################################
### code chunk number 17: tutorial.Rnw:278-279
###################################################
sum( countOverlaps(alt.results, df2.GRanges ) == 0 )


###################################################
### code chunk number 18: alt-res
###################################################
gRxPlot(alt.results,method="criticalRegions")


###################################################
### code chunk number 19: tutorial.Rnw:296-297
###################################################
xtabs(~grp, df3)


###################################################
### code chunk number 20: tutorial.Rnw:306-307
###################################################
as.list(metadata(alt.results)$call)[['cutpt.tail.expr']]


###################################################
### code chunk number 21: tutorial.Rnw:321-328
###################################################
generous.target.expr <-
    quote(critVal.target(k,n, target=20, posdiff=x))
generous.results <-
    gRxCluster(df3$chromo,df3$pos,df3$grp,
	       15L:30L,nperm=100L,
	       cutpt.tail.expr=generous.target.expr)
gRxSummary(generous.results)


###################################################
### code chunk number 22: tutorial.Rnw:333-334
###################################################
sum( 0==countOverlaps(generous.results,df2.GRanges))


###################################################
### code chunk number 23: tutorial.Rnw:341-342
###################################################
as.list(metadata(alt.results)$call)[['cutpt.filter.expr']]


###################################################
### code chunk number 24: tutorial.Rnw:354-359
###################################################
no.filter.expr <- quote(rep(Inf,ncol(x)))
no.filter.results <-
    gRxCluster(df3$chromo,df3$pos,df3$grp,15L:30L,nperm=100L,
	       cutpt.filter.expr=no.filter.expr)
gRxSummary(no.filter.results)


###################################################
### code chunk number 25: tutorial.Rnw:367-368
###################################################
sum( 0==countOverlaps(no.filter.results,df2.GRanges))


###################################################
### code chunk number 26: tutorial.Rnw:374-381
###################################################
hard.filter.expr <-
    quote(apply(x,2,quantile, 0.15, na.rm=TRUE))
hard.filter.results <-
    gRxCluster(df3$chromo,df3$pos,df3$grp,15L:30L,
	       nperm=100L,
	       cutpt.filter.expr=hard.filter.expr)
gRxSummary(hard.filter.results)


###################################################
### code chunk number 27: tutorial.Rnw:387-388
###################################################
sum( 0==countOverlaps(hard.filter.results,df2.GRanges))


