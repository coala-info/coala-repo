# Code example from 'struct_templates_and_helper_functions' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
    dpi=72,fig.width=5,fig.height=5.5
)
set.seed(57475)

## ----eval=FALSE, include=TRUE-------------------------------------------------
# # install BiocManager if not present
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# 
# # install structToolbox and dependencies
# BiocManager::install("struct")
# 
# # install ggplot if not already present
#  if (!require('ggplot2')) {
#   install.packages('ggplot2')
# }

## ----message=FALSE,warning=FALSE----------------------------------------------
suppressPackageStartupMessages({
  # load the package
  library(struct)
  
  # load ggplot
  library(ggplot2)
})

## -----------------------------------------------------------------------------
S = struct_class()
S

## -----------------------------------------------------------------------------
S = struct_class(name = 'Example',
                 description = 'An example struct object')
S

## -----------------------------------------------------------------------------
# set the name
S$name = 'Basic example'

# get the name
S$name

## -----------------------------------------------------------------------------
DE = DatasetExperiment(
  data = iris[,1:4],
  sample_meta=iris[,5,drop=FALSE],
  variable_meta=data.frame('idx'=1:4,row.names=colnames(data)),
  name = "Fisher's iris dataset",
  description = 'The famous one')
DE

## -----------------------------------------------------------------------------
DE = iris_DatasetExperiment()
DE

## -----------------------------------------------------------------------------
# number of columns
ncol(DE)

# number of rows
nrow(DE)

# subset the 2nd and 3rd column
Ds = DE[,c(2,3)]
Ds

## -----------------------------------------------------------------------------
# get data frame 
head(DE$data)

# sample meta
head(DE$sample_meta)


## -----------------------------------------------------------------------------
# mean centre object
mean_centre = set_struct_obj(
  class_name = 'mean_centre', 
  struct_obj = 'model',       
  params = character(0),            
  outputs = c(centred = 'DatasetExperiment',
              mean = 'numeric'),
  private = character(0),
  prototype=list(predicted = 'centred')
)

# PCA object
PCA = set_struct_obj(
  class_name = 'PCA', 
  struct_obj = 'model',       
  params = c(number_components = 'numeric'),                
  outputs = c(scores = 'DatasetExperiment',
              loadings = 'data.frame'),
  private = character(0),
  prototype = list(number_components = 2,
                  ontology = 'OBI:0200051',
                  predicted = 'scores')
)

## -----------------------------------------------------------------------------
M = mean_centre()
M

P = PCA(number_components=4)
P

## -----------------------------------------------------------------------------
# mean centre training
set_obj_method(
  class_name = 'mean_centre',
  method_name = 'model_train',
  definition = function(M,D) {
    # calculate the mean of all training data columns
    m = colMeans(D$data)
    # assign to output slot
    M$mean = m
    # always return the modified model object
    return(M)
  }
)

# mean_centre prediction
set_obj_method(
  class_name = 'mean_centre',
  method_name = 'model_predict',
  definition = function(M,D) {
    # subtract the mean from each column of the test data
    D$data = D$data - rep(M$mean, rep.int(nrow(D$data), ncol(D$data)))
    # assign to output
    M$centred = D
    # always return the modified model object
    return(M)
  }
)

## -----------------------------------------------------------------------------
# create instance of object
M = mean_centre()

# train with iris data
M = model_train(M,iris_DatasetExperiment())

# print to mean to show the function worked
M$mean

# apply to iris_data
M = model_predict(M,iris_DatasetExperiment())

# retrieve the centred data and show that the column means are zero
colMeans(M$centred$data)

## -----------------------------------------------------------------------------
# PCA training
set_obj_method(
  class_name = 'PCA',
  method_name = 'model_train',
  definition = function(M,D) {
    
    # get number of components
    A = M$number_components
    
    # convert to matrix
    X=as.matrix(D$data)
    
    # do svd
    model=svd(X,A,A)

    # loadings
    P=as.data.frame(model$v)
    
    # prepare data.frame for output
    varnames=rep('A',1,A)
    for (i in 1:A) {
      varnames[i]=paste0('PC',i)
    }
    rownames(P)=colnames(X)
    colnames(P)=varnames
    output_value(M,'loadings')=P
    
    # set output
    M$loadings = P
    
    # always return the modified model object
    return(M)
  }
)

# PCA prediction
set_obj_method(
  class_name = 'PCA',
  method_name = 'model_predict',
  definition = function(M,D) {
    ## calculate scores using loadings
    
    # get number of components
    A = M$number_components
    
    # convert to matrix
    X=as.matrix(D$data)
    
    # get loadings
    P=M$loadings
    
    # calculate scores
    that=X%*%as.matrix(P)
    
    # convert scores to DatasetExperiment
    that=as.data.frame(that)
    rownames(that)=rownames(X)
    varnames=rep('A',1,A)
    for (i in 1:A) {
      varnames[i]=paste0('PC',i)
    }
    colnames(that)=varnames
    S=DatasetExperiment(
      data=that,
      sample_meta=D$sample_meta,
      variable_meta=varnames)
    
    # set output
    M$scores=S
    
    # always return the modified model object
    return(M)
  }
)

## -----------------------------------------------------------------------------
# get the mean centred data
DC = M$centred

# train PCA model
P = model_apply(P,DC)

# get scores
P$scores

## -----------------------------------------------------------------------------
# create model sequence
MS = mean_centre() + PCA(number_components = 2)

# print summary
MS

## -----------------------------------------------------------------------------
# apply model sequence to iris_data
MS = model_apply(MS,iris_DatasetExperiment())

# get default output from sequence (PCA scores with 2 components)
predicted(MS)

## -----------------------------------------------------------------------------
# create iterator
I = iterator()

# add PCA model sequence
models(I) = MS

# retrieve model sequence
models(I)

## -----------------------------------------------------------------------------
# alternative to assign models for iterators
I = iterator() * (mean_centre() + PCA())
models(I)

## -----------------------------------------------------------------------------
I = iterator() * iterator() * (mean_centre() + PCA())

## -----------------------------------------------------------------------------
# new chart object
set_struct_obj(
  class_name = 'pca_scores_plot',
  struct_obj = 'chart',
  params = c(factor_name = 'character'),
  prototype = list(
    name = 'PCA scores plot',
    description = 'Scatter plot of the first two principal components',
    libraries = 'ggplot2'
  )
)

## -----------------------------------------------------------------------------
# new chart_plot method
set_obj_method(
  class_name = 'pca_scores_plot',
  method_name = 'chart_plot',
  signature = c('pca_scores_plot','PCA'),
  definition = function(obj,dobj) {
    
    if (!is(dobj,'PCA')) {
      stop('this chart is only for PCA objects')
    }
    
    # get the PCA scores data
    S = dobj$scores$data
    
    # add the group labels
    S$factor_name = dobj$scores$sample_meta[[obj$factor_name]]
    
    # ggplot
    g = ggplot(data = S, aes_string(x='PC1',y='PC2',colour='factor_name')) +
      geom_point() + labs(colour = obj$factor_name) 
    
    # chart objects return the ggplot object
    return(g)
  }
    
)

## ----fig.width = 5, fig.height = 4--------------------------------------------
# create chart object
C = pca_scores_plot(factor_name = 'Species')

# plot chart using trained PCA object from model sequence
chart_plot(C,MS[2]) + theme_bw() # add theme

## -----------------------------------------------------------------------------
# define entity
npc = entity(
  name = 'Number of principal components',
  description = 'The number of principal components to calculate',
  type = c('numeric','integer'),
  value = 2,
  max_length = 1
)

# summary
npc


## -----------------------------------------------------------------------------
# PCA object
PCA = set_struct_obj(
  class_name = 'PCA', 
  struct_obj = 'model',       
  params = c(number_components = 'entity'),                
  outputs = c(scores = 'DatasetExperiment',
              loadings = 'data.frame'),
  private = character(0),
  prototype = list(number_components = npc,
                  ontology = 'OBI:0200051',
                  predicted = 'scores')
)

# create PCA model 
P = PCA(number_components = 3)

# get set value
P$number_components

# get description
param_obj(P,'number_components')$description


## -----------------------------------------------------------------------------
P = PCA()

# return a list of ontologies for PCA, including the input parameters and outputs
ontology(P)

# return the ontology id'd for PCA only (not inputs/outputs)
P$ontology

# get the ontology for a specific input
IN = param_obj(P,'number_components') # get as entity object
IN$ontology

## -----------------------------------------------------------------------------
sessionInfo()

