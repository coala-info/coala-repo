# Code example from 'props' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
library(PROPS)

## ----results=FALSE------------------------------------------------------------
data(example_healthy)
example_healthy[1:5,1:5]

## ----echo = FALSE, results = 'asis'-------------------------------------------
knitr::kable(example_healthy[1:5,1:5])

## ----results=FALSE------------------------------------------------------------
data(example_data)
example_data[1:5,1:5]

## ----echo = FALSE, results='asis'---------------------------------------------
knitr::kable(example_data[1:5,1:5])

## ----results=FALSE------------------------------------------------------------
props_features <- props(example_healthy, example_data)
props_features[1:5,1:5]

## ----echo = FALSE, results='asis'---------------------------------------------
knitr::kable(props_features[1:5,1:5])

## ----results = FALSE----------------------------------------------------------
healthy_batches = c(rep(1, 25), rep(2, 25))
dat_batches = c(rep(1, 20), rep(2, 30))

props_features_batchcorrected <- props(example_healthy, example_data, batch_correct = TRUE, healthy_batches = healthy_batches, dat_batches = dat_batches)
props_features_batchcorrected[1:5,1:5]

## ----echo = FALSE, results='asis'---------------------------------------------
knitr::kable(props_features_batchcorrected[1:5,1:5])

## ----results = FALSE----------------------------------------------------------
data(example_edges)
example_edges[1:8, ]

## ----echo = FALSE, results='asis'---------------------------------------------
knitr::kable(example_edges[1:8, ])

## ----results = FALSE----------------------------------------------------------
props_features_userpathways <- props(example_healthy, example_data, pathway_edges = example_edges)
props_features_userpathways[,1:5]

## ----echo = FALSE, results='asis'---------------------------------------------
knitr::kable(props_features_userpathways[,1:5])

