# Code example from 'compare-predicted-observed-flycodes' vignette. See references/ for full tutorial.

## ----echo=TRUE, message=FALSE-------------------------------------------------
library(NestLink)

## ----fig.retina=1, fig.height=5, fig.width=5----------------------------------
# load(url("http://fgcz-ms.uzh.ch/~cpanse/p1875/F255744.RData"))
# F255744 <- as.data.frame.mascot(F255744) 
# now available through ExperimentHub

library(ExperimentHub)
eh <- ExperimentHub(); 

load(query(eh, c("NestLink", "F255744.RData"))[[1]])

.ssrc.mascot(F255744, scores = c(10, 20, 40, 50), 
             pch = 16, 
             col = rgb(0.1,0.1,0.1,
                       alpha = 0.1)
)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

