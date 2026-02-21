# Code example from 'nullranges' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# vignette(package="nullranges")

## ----nullranges-diagram, echo=FALSE-------------------------------------------
DiagrammeR::grViz("digraph {
  graph [layout = dot, rankdir = TB]
  
  node [shape = rectangle]        
  source [label = 'Features defined with respect to a pool']
  poolyes [label = 'Yes']
  poolno [label =  'No']
  cov [label = 'Potential confounding covariates']
  covyes [label = 'Yes']
  covno [label = 'No']
  diffcov [label = 'Different covariate distribution']
  diffcovyes [label = 'Yes']
  diffcovno [label =  'No']
  match [label = 'matchRanges']
  random [label = 'Random sample']
  context [label = 'Local genomic context matters']
  contextyes [label = 'Yes']
  contextno [label = 'No']
  cluster [label = 'Features cluster in genome']
  random2 [label = 'Random sample']
  clusteryes [label = 'Yes']
  clusterno [label = 'No']
  boot [label = 'bootRanges']
  shuffle [label = 'Shuffle + exclusion']

  source -> poolyes
  source -> poolno
  poolyes -> cov
  cov -> covyes
  cov -> covno
  covyes -> diffcov
  covno -> random
  diffcov -> diffcovyes
  diffcov -> diffcovno
  diffcovyes -> match
  diffcovno -> random
  poolno -> context
  context -> contextyes
  context -> contextno
  contextyes -> cluster
  contextno -> random2
  cluster -> clusteryes
  cluster -> clusterno
  clusteryes -> boot
  clusterno -> shuffle
}", height = 500)


