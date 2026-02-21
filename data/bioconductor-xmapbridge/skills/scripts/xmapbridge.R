# Code example from 'xmapbridge' vignette. See references/ for full tutorial.

### R code from vignette source 'xmapbridge.Rnw'

###################################################
### code chunk number 1: xmapbridge.Rnw:145-150
###################################################
#We are actually writing everything to a tmp directory behind the scenes.
path     <- tempdir()
old.path <- Sys.getenv( "XMAP_BRIDGE_CACHE" )
Sys.setenv( XMAP_BRIDGE_CACHE=path )
#We put things back later


###################################################
### code chunk number 2: xmapbridge.Rnw:152-156
###################################################
library( xmapbridge )
set.seed( 100 )
x <- runif( 100, 1100000,1200000 )
y <- 10 * sin( 2 * pi * ( x-1000000 ) / 10000 )


###################################################
### code chunk number 3: xmapbridge.Rnw:158-159 (eval = FALSE)
###################################################
## xmap.plot( x, y, species="homo_sapiens", chr="1", type="line" )


###################################################
### code chunk number 4: xmapbridge.Rnw:161-162
###################################################
cat( xmap.debug( xmap.plot( x, y, species="homo_sapiens", chr="1", type="line" ), newlines=TRUE ) )


###################################################
### code chunk number 5: xmapbridge.Rnw:211-212
###################################################
data(xmapbridge)


###################################################
### code chunk number 6: xmapbridge.Rnw:224-225
###################################################
l <- split(exon.data,exon.data$"gene")


###################################################
### code chunk number 7: xmapbridge.Rnw:236-242
###################################################

g <- l[[1]]
x   <- g$"seq_region_end" + (g$"seq_region_end" - g$"seq_region_start")/2
y   <- g[,2]
chr <- unique(g$"name")



###################################################
### code chunk number 8: xmapbridge.Rnw:251-252 (eval = FALSE)
###################################################
## xmap.plot(x,y,chr,species="homo_sapiens",type="area",col="#ff000066")


###################################################
### code chunk number 9: xmapbridge.Rnw:254-255
###################################################
cat( xmap.debug( xmap.plot(x,y,chr,species="homo_sapiens",type="area",col="#ff000066"), newlines=TRUE ) )


###################################################
### code chunk number 10: xmapbridge.Rnw:273-274 (eval = FALSE)
###################################################
## xmap.plot(x,y,chr,species="homo_sapiens",type="scatter",col="#ff000066")


###################################################
### code chunk number 11: xmapbridge.Rnw:276-277
###################################################
cat( xmap.debug( xmap.plot(x,y,chr,species="homo_sapiens",type="scatter",col="#ff000066"), newlines=TRUE ) )


###################################################
### code chunk number 12: xmapbridge.Rnw:279-280 (eval = FALSE)
###################################################
## xmap.plot(x,y,chr,species="homo_sapiens",type="line",col="#ff000066")


###################################################
### code chunk number 13: xmapbridge.Rnw:282-283
###################################################
cat( xmap.debug( xmap.plot(x,y,chr,species="homo_sapiens",type="line",col="#ff000066"), newlines=TRUE ) )


###################################################
### code chunk number 14: xmapbridge.Rnw:285-286 (eval = FALSE)
###################################################
## xmap.plot(x,y,chr,species="homo_sapiens",type="bar",col="#ff000066")


###################################################
### code chunk number 15: xmapbridge.Rnw:288-289
###################################################
cat( xmap.debug( xmap.plot(x,y,chr,species="homo_sapiens",type="bar",col="#ff000066"), newlines=TRUE ) )


###################################################
### code chunk number 16: xmapbridge.Rnw:291-292 (eval = FALSE)
###################################################
## xmap.plot(x,y,chr,species="homo_sapiens",type="area",col="#ff000066")


###################################################
### code chunk number 17: xmapbridge.Rnw:294-295
###################################################
cat( xmap.debug( xmap.plot(x,y,chr,species="homo_sapiens",type="area",col="#ff000066"), newlines=TRUE ) )


###################################################
### code chunk number 18: xmapbridge.Rnw:297-298 (eval = FALSE)
###################################################
## xmap.plot(x,y,chr,species="homo_sapiens",type="steparea",col="#ff000066")


###################################################
### code chunk number 19: xmapbridge.Rnw:300-301
###################################################
cat( xmap.debug( xmap.plot(x,y,chr,species="homo_sapiens",type="steparea",col="#ff000066"), newlines=TRUE ) )


###################################################
### code chunk number 20: xmapbridge.Rnw:317-322
###################################################
#Pick an interesting gene
g <- l[["ENSG00000128394"]]
x   <- g$"seq_region_end" + (g$"seq_region_end" - g$"seq_region_start")/2
chr <- unique(g$"name")
y <- g[,2]


###################################################
### code chunk number 21: xmapbridge.Rnw:324-325 (eval = FALSE)
###################################################
## xmap.plot(x,y,chr,species="homo_sapiens",type="area",col="#ff000033",ylim=c(0,16))


###################################################
### code chunk number 22: xmapbridge.Rnw:327-328
###################################################
cat( xmap.debug( xmap.plot(x,y,chr,species="homo_sapiens",type="area",col="#ff000033",ylim=c(0,16)), newlines=TRUE ) )


###################################################
### code chunk number 23: xmapbridge.Rnw:330-331 (eval = FALSE)
###################################################
## xmap.points(x,y,chr,type="line",col="#ff0000ff")


###################################################
### code chunk number 24: xmapbridge.Rnw:333-334
###################################################
cat( xmap.debug( xmap.points(x,y,chr,type="line",col="#ff0000ff"), newlines=TRUE ) )


###################################################
### code chunk number 25: xmapbridge.Rnw:337-339
###################################################
#We were plotting the 1st array (2nd column in g), now plot the 4th (5th column in g)
y <- g[,5]


###################################################
### code chunk number 26: xmapbridge.Rnw:341-342 (eval = FALSE)
###################################################
## xmap.points(x,y,chr,type="area",col="#0000ff33")


###################################################
### code chunk number 27: xmapbridge.Rnw:344-345
###################################################
cat( xmap.debug( xmap.points(x,y,chr,type="area",col="#0000ff33"), newlines=TRUE ) )


###################################################
### code chunk number 28: xmapbridge.Rnw:347-348 (eval = FALSE)
###################################################
## xmap.points(x,y,chr,type="line",col="#0000ffff")


###################################################
### code chunk number 29: xmapbridge.Rnw:350-351
###################################################
cat( xmap.debug( xmap.points(x,y,chr,type="line",col="#0000ffff"), newlines=TRUE ) )


###################################################
### code chunk number 30: xmapbridge.Rnw:403-406
###################################################
cols.bg <- c(rep("#ff000011",3),rep("#0000ff11",3))
cols.fg <- c(rep("#ff0000ff",3),rep("#0000ffff",3))
names   <- c("7.1","7.2","7.3","10a.1","10a.2","10a.3")


###################################################
### code chunk number 31: xmapbridge.Rnw:417-418
###################################################
pid <- xmap.project.new("mcf7 vs mcf10a")


###################################################
### code chunk number 32: xmapbridge.Rnw:427-439
###################################################
plot.a.gene <- function(g,pid) {
  x    <- g$"seq_region_end" + (g$"seq_region_end" - g$"seq_region_start")/2
  y    <- g[,2:7]
  chr  <- unique(g$"name")
  gene <- unique(g$"gene")
  xlim <- range(x)
  gph  <- xmap.graph.new(projectid=pid, name=gene,desc="vignette example", min=0, max=16, chr=chr, start=xlim[1], stop=xlim[2], ylab="value",species="homo_sapiens")
  for(i in 1:6) {
    xmap.points(graphid=gph,x=x,y=y[,i],type="area",col=cols.bg[i],xlab="")
    xmap.points(graphid=gph,x=x,y=y[,i],type="line",col=cols.fg[i],xlab=names[i])
  }
}


###################################################
### code chunk number 33: xmapbridge.Rnw:453-454
###################################################
lapply(l,plot.a.gene,pid=pid)


###################################################
### code chunk number 34: xmapbridge.Rnw:475-476
###################################################
library( RColorBrewer )


###################################################
### code chunk number 35: xmapbridge.Rnw:478-481 (eval = FALSE)
###################################################
## #A light grey almost transparent step area
## xmap.plot( x, y, type="steparea", col="#11111111", ylab="intensity",
##            chr="4", species="homo_sapiens" )


###################################################
### code chunk number 36: xmapbridge.Rnw:483-485
###################################################
cat( xmap.debug( xmap.plot( x, y, type="steparea", col="#11111111", ylab="intensity",
           chr="4", species="homo_sapiens" ), newlines=TRUE ) )


###################################################
### code chunk number 37: xmapbridge.Rnw:488-490 (eval = FALSE)
###################################################
## #With an opaque orange edge
## xmap.points( x, y, type="step", col="#F7941DFF" )


###################################################
### code chunk number 38: xmapbridge.Rnw:492-493
###################################################
cat( xmap.debug( xmap.points( x, y, type="step", col="#F7941DFF" ), newlines=TRUE ) )


###################################################
### code chunk number 39: xmapbridge.Rnw:502-509
###################################################
#Five levels of red, chosen by the RColorBrewer
reds <- brewer.pal( 5, "Reds" )
reds <- xmap.col( reds, alpha=0x55 )

for( i in 1:5 ) {
  xmap.points( x, y / i, type="area", col=reds[i] )
}


###################################################
### code chunk number 40: xmapbridge.Rnw:527-529
###################################################
#put the environment variable back. Not strictly necessary, but why not?
Sys.setenv(XMAP_BRIDGE_CACHE=old.path)


