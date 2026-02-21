# Code example from 'RITANdata' vignette. See references/ for full tutorial.

## ----load_data from package, echo=TRUE, results='hide'------------------------
library(RITANdata)

## ----echo_geneset_list_names, echo=TRUE---------------------------------------
names(geneset_list)

## ----net_citation, echo=TRUE--------------------------------------------------
require(knitr)
kable( attr(network_list, 'network_data_sources') )

