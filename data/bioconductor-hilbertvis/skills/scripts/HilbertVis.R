# Code example from 'HilbertVis' vignette. See references/ for full tutorial.

### R code from vignette source 'HilbertVis.Rnw'

###################################################
### code chunk number 1: setSeed
###################################################
set.seed(271828)


###################################################
### code chunk number 2: HilbertVis.Rnw:49-51
###################################################
library( HilbertVis )
vec <- makeRandomTestData( )


###################################################
### code chunk number 3: HilbertVis.Rnw:55-56
###################################################
length(vec)


###################################################
### code chunk number 4: plotLongVector
###################################################
plotLongVector( vec )


###################################################
### code chunk number 5: zoomIn
###################################################
start <- 1500000
plotLongVector( vec[ start + 0:100000 ], offset=start )


###################################################
### code chunk number 6: HilbertCurves
###################################################
library( grid )
pushViewport( viewport( layout=grid.layout( 2, 2 ) ) )
for( i in 1:4 ) {
   pushViewport( viewport( 
       layout.pos.row=1+(i-1)%/%2, layout.pos.col=1+(i-1)%%2 ) )
   plotHilbertCurve( i, new.page=FALSE )
   popViewport( )
}   


###################################################
### code chunk number 7: HilbertVis.Rnw:191-192
###################################################
hMat <- hilbertImage( vec )


###################################################
### code chunk number 8: HilbertVis.Rnw:204-205 (eval = FALSE)
###################################################
## showHilbertImage( hMat ) 


###################################################
### code chunk number 9: HilbertTest
###################################################
show( showHilbertImage( hMat ) )


###################################################
### code chunk number 10: HilbertVis.Rnw:218-219 (eval = FALSE)
###################################################
## showHilbertImage( hMat, mode="EBImage" )


###################################################
### code chunk number 11: HilbertVis.Rnw:237-238 (eval = FALSE)
###################################################
## library( HilbertVisGUI )


###################################################
### code chunk number 12: HilbertVis.Rnw:241-242 (eval = FALSE)
###################################################
## hilbertDisplay( vec )


###################################################
### code chunk number 13: HilbertVis.Rnw:277-282 (eval = FALSE)
###################################################
## dumpDataInsteadOfPlotting <- function( data, info ) {
##    str( data )
##    print( info )
## }
## hilbertDisplay( vec, plotFunc=dumpDataInsteadOfPlotting )


###################################################
### code chunk number 14: HilbertVis.Rnw:320-322
###################################################
vec2 <- vec
vec2[ 7000000 : 8000000 ] <- vec[ 7010000 : 8010000 ]


###################################################
### code chunk number 15: HilbertVis.Rnw:327-328 (eval = FALSE)
###################################################
## hilbertDisplay( vec, vec2 )


###################################################
### code chunk number 16: HilbertVis.Rnw:346-348 (eval = FALSE)
###################################################
## hilbertDisplayThreeChannel( 
##    vec / max(vec), vec2 / max(vec), rep( 0, length(vec) ) )


###################################################
### code chunk number 17: HilbertVis.Rnw:440-441
###################################################
sessionInfo()


