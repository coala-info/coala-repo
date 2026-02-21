# Code example from 'epivizrData' vignette. See references/ for full tutorial.

## ----message=FALSE------------------------------------------------------------
library(epivizrData)
library(GenomicRanges)

server <- epivizrServer::createServer(port=7123L)
data_mgr <- epivizrData::createMgr(server)

## add measurements from a GRanges object
gr <- GRanges("chr10", IRanges(start=1:1000, width=100), score=rnorm(1000))
data_mgr$add_measurements(gr, "example_gr", type="bp", columns="score")

