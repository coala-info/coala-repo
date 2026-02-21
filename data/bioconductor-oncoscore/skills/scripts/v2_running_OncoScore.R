# Code example from 'v2_running_OncoScore' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library("OncoScore")

## -----------------------------------------------------------------------------
query = perform.query(c("ASXL1","IDH1","IDH2","SETBP1","TET2"))

## -----------------------------------------------------------------------------
combine.query.results(query, c('IDH1', 'IDH2'), 'new_gene')

## ----eval=FALSE---------------------------------------------------------------
# chr13 = get.genes.from.biomart(chromosome=13,start=54700000,end=72800000)

## ----eval=FALSE---------------------------------------------------------------
# result = compute.oncoscore.from.region(10, 100000, 500000)

## -----------------------------------------------------------------------------
result = compute.oncoscore(query)

## -----------------------------------------------------------------------------
query.timepoints = perform.query.timeseries(c("ASXL1","IDH1","IDH2","SETBP1","TET2"),
    c("2012/03/01", "2013/03/01", "2014/03/01", "2015/03/01", "2016/03/01"))

## -----------------------------------------------------------------------------
result.timeseries = compute.oncoscore.timeseries(query.timepoints)

## ----fig.width=12, fig.height=8, warning=FALSE, fig.cap="Oncogenetic potential of the considered genes."----
plot.oncoscore(result, col = 'darkblue')

## ----fig.width=12, fig.height=8, warning=FALSE, fig.cap="Absolute values of the oncogenetic potential of the considered genes over times."----
plot.oncoscore.timeseries(result.timeseries)

## ----fig.width=12, fig.height=8, warning=FALSE, fig.cap="Variations of the oncogenetic potential of the considered genes over times."----
plot.oncoscore.timeseries(result.timeseries, incremental = TRUE, ylab='absolute variation')

## ----fig.width=12, fig.height=8, warning=FALSE, fig.cap="Variations as relative values of the oncogenetic potential of the considered genes over times."----
plot.oncoscore.timeseries(result.timeseries, incremental = TRUE, relative = TRUE, ylab='relative variation')

