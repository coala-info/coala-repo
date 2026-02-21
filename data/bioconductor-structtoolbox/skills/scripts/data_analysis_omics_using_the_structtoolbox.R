# Code example from 'data_analysis_omics_using_the_structtoolbox' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(
    dpi=96,fig.width=5,fig.height=5.5,fig.retina = 1,fig.small = TRUE
)
set.seed(57475)

## ----eval=FALSE, include=TRUE-------------------------------------------------
# # install BiocManager if not present
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# # install structToolbox and dependencies
# BiocManager::install("structToolbox")

## ----message=FALSE, warning=FALSE---------------------------------------------
## install additional bioc packages for vignette if needed
#BiocManager::install(c('pmp', 'ropls', 'BiocFileCache'))

## install additional CRAN packages if needed
#install.packages(c('cowplot', 'openxlsx'))

suppressPackageStartupMessages({
    # Bioconductor packages
    library(structToolbox)
    library(pmp)
    library(ropls)
    library(BiocFileCache)
  
    # CRAN libraries
    library(ggplot2)
    library(gridExtra)
    library(cowplot)
    library(openxlsx)
})


# use the BiocFileCache
bfc <- BiocFileCache(ask = FALSE)

## -----------------------------------------------------------------------------
## Iris dataset (comment if using MTBLS79 benchmark data)
D = iris_DatasetExperiment()
D$sample_meta$class = D$sample_meta$Species

## MTBLS (comment if using Iris data)
# D = MTBLS79_DatasetExperiment(filtered=TRUE)
# M = pqn_norm(qc_label='QC',factor_name='sample_type') + 
#   knn_impute(neighbours=5) +
#   glog_transform(qc_label='QC',factor_name='sample_type') +
#   filter_smeta(mode='exclude',levels='QC',factor_name='sample_type')
# M = model_apply(M,D)
# D = predicted(M)

# show info
D

## -----------------------------------------------------------------------------
# show some data
head(D$data[,1:4])

## -----------------------------------------------------------------------------
P = PCA(number_components=15)
P$number_components=5
P$number_components

## -----------------------------------------------------------------------------
param_ids(P)

## -----------------------------------------------------------------------------
P

## -----------------------------------------------------------------------------
M = mean_centre() + PCA(number_components = 4)

## -----------------------------------------------------------------------------
M[2]$number_components

## -----------------------------------------------------------------------------
M = model_train(M,D)

## -----------------------------------------------------------------------------
M = model_predict(M,D)

## -----------------------------------------------------------------------------
M = model_apply(M,D)

## -----------------------------------------------------------------------------
output_ids(M[2])
M[2]$scores

## -----------------------------------------------------------------------------
chart_names(M[2])

## ----fig.width=5,fig.height=5-------------------------------------------------
C = pca_scores_plot(factor_name='class') # colour by class
chart_plot(C,M[2])

## -----------------------------------------------------------------------------
# add petal width to meta data of pca scores
M[2]$scores$sample_meta$example=D$data[,1]
# update plot
C$factor_name='example'
chart_plot(C,M[2])

## ----fig.width=10,fig.small=FALSE---------------------------------------------
# scores plot
C1 = pca_scores_plot(factor_name='class') # colour by class
g1 = chart_plot(C1,M[2])

# scree plot
C2 = pca_scree_plot()
g2 = chart_plot(C2,M[2])

# arange in grid
grid.arrange(grobs=list(g1,g2),nrow=1)

## -----------------------------------------------------------------------------
# create an example PCA object
P=PCA()

# ontology for the PCA object
P$ontology

## -----------------------------------------------------------------------------
ontology(P,cache = ontology_cache()) # set cache = NULL (default) for online use

## -----------------------------------------------------------------------------
M = mean_centre() + PLSDA(number_components=2,factor_name='class')
M

## -----------------------------------------------------------------------------
# create object
XCV = kfold_xval(folds=5,factor_name='class')

# change the number of folds
XCV$folds=10
XCV$folds

## -----------------------------------------------------------------------------
models(XCV)=M
models(XCV)

## -----------------------------------------------------------------------------
# cross validation of a mean centred PLSDA model
XCV = kfold_xval(
        folds=5,
        method='venetian',
        factor_name='class') * 
      (mean_centre() + PLSDA(factor_name='class'))

## -----------------------------------------------------------------------------
XCV = run(XCV,D,balanced_accuracy())
XCV$metric

## -----------------------------------------------------------------------------
chart_names(XCV)

## ----warning=FALSE,fig.width=8,fig.height=4,fig.small=FALSE-------------------
C = kfoldxcv_grid(
  factor_name='class',
  level=levels(D$sample_meta$class)[2]) # first level
chart_plot(C,XCV)

## -----------------------------------------------------------------------------
# permute sample order 10 times and run cross-validation
P = permute_sample_order(number_of_permutations = 10) * 
    kfold_xval(folds=5,factor_name='class')*
    (mean_centre() + PLSDA(factor_name='class',number_components=2))
P = run(P,D,balanced_accuracy())
P$metric

## ----warning=FALSE,message=FALSE----------------------------------------------
# the pmp SE object
SE = MTBLS79

# convert to DE
DE = as.DatasetExperiment(SE)
DE$name = 'MTBLS79'
DE$description = 'Converted from SE provided by the pmp package'

# add a column indicating the order the samples were measured in
DE$sample_meta$run_order = 1:nrow(DE)

# add a column indicating if the sample is biological or a QC
Type=as.character(DE$sample_meta$Class)
Type[Type != 'QC'] = 'Sample'
DE$sample_meta$Type = factor(Type)

# add a column for plotting batches
DE$sample_meta$batch_qc = DE$sample_meta$Batch
DE$sample_meta$batch_qc[DE$sample_meta$Type=='QC']='QC'

# convert to factors
DE$sample_meta$Batch = factor(DE$sample_meta$Batch)
DE$sample_meta$Type = factor(DE$sample_meta$Type)
DE$sample_meta$Class = factor(DE$sample_meta$Class)
DE$sample_meta$batch_qc = factor(DE$sample_meta$batch_qc)

# print summary
DE

## ----message=FALSE,warning=FALSE----------------------------------------------

M = # batch correction
    sb_corr(
      order_col='run_order',
      batch_col='Batch', 
      qc_col='Type', 
      qc_label='QC',
      spar_lim = c(0.6,0.8) 
    )

M = model_apply(M,DE)

## ----fig.wide = TRUE,warning=FALSE,fig.width=10-------------------------------
C = feature_profile(
      run_order='run_order',
      qc_label='QC',
      qc_column='Type',
      colour_by='batch_qc',
      feature_to_plot='200.03196',
      plot_sd=FALSE
  )

# plot and modify using ggplot2 
chart_plot(C,M,DE)+ylab('Peak area')+ggtitle('Before')
chart_plot(C,predicted(M))+ylab('Peak area')+ggtitle('After')

## -----------------------------------------------------------------------------
M2 = filter_na_count(
      threshold=3,
      factor_name='Batch'
    )
M2 = model_apply(M2,predicted(M))

# calculate number of features removed
nc = ncol(DE) - ncol(predicted(M2))

cat(paste0('Number of features removed: ', nc))

## -----------------------------------------------------------------------------
M3 = kw_rank_sum(
      alpha=0.0001,
      mtc='none',
      factor_names='Batch',
      predicted='significant'
    ) +
    filter_by_name(
      mode='exclude',
      dimension = 'variable',
      seq_in = 'names', 
      names='seq_fcn', # this is a placeholder and will be replaced by seq_fcn
      seq_fcn=function(x){return(x[,1])}
    )
M3 = model_apply(M3, predicted(M2))

nc = ncol(predicted(M2)) - ncol(predicted(M3))
cat(paste0('Number of features removed: ', nc))

## -----------------------------------------------------------------------------
M4 = wilcox_test(
      alpha=1e-14,
      factor_names='Type', 
      mtc='none', 
      predicted = 'significant'
    ) +
    filter_by_name(
      mode='exclude',
      dimension='variable',
      seq_in='names', 
      names='place_holder',
      seq_fcn=function(x){return(x$significant)}
    )
M4 = model_apply(M4, predicted(M3))

nc = ncol(predicted(M3)) - ncol(predicted(M4))
cat(paste0('Number of features removed: ', nc))

## -----------------------------------------------------------------------------
M5 = rsd_filter(
     rsd_threshold=20,
     factor_name='Type'
)
M5 = model_apply(M5,predicted(M4))

nc = ncol(predicted(M4)) - ncol(predicted(M5))
cat(paste0('Number of features removed: ', nc))


## -----------------------------------------------------------------------------
# peak matrix processing
M6 = pqn_norm(qc_label='QC',factor_name='Type') + 
     knn_impute(neighbours=5) +
     glog_transform(qc_label='QC',factor_name='Type')
M6 = model_apply(M6,predicted(M5))

## -----------------------------------------------------------------------------
# PCA
M7  = mean_centre() + PCA(number_components = 2)

# apply model sequence to data
M7 = model_apply(M7,predicted(M6))

# plot pca scores
C = pca_scores_plot(factor_name=c('Sample_Rep','Class'),ellipse='none')
chart_plot(C,M7[2]) + coord_fixed() +guides(colour=FALSE)

## -----------------------------------------------------------------------------
# chart object
C = pca_scores_plot(factor_name=c('Batch'),ellipse='none')
# plot
chart_plot(C,M7[2]) + coord_fixed()

## -----------------------------------------------------------------------------
data('sacurine',package = 'ropls')
# the 'sacurine' list should now be available

# move the annotations to a new column and rename the features by index to avoid issues
# later when data.frames get transposed and names get checked/changed
sacurine$variableMetadata$annotation=rownames(sacurine$variableMetadata)
rownames(sacurine$variableMetadata)=1:nrow(sacurine$variableMetadata)
colnames(sacurine$dataMatrix)=1:ncol(sacurine$dataMatrix)

# create DatasetExperiment
DE = DatasetExperiment(data = data.frame(sacurine$dataMatrix),
                       sample_meta = sacurine$sampleMetadata,
                       variable_meta = sacurine$variableMetadata,
                       name = 'Sacurine data',
                       description = 'See ropls package documentation for details')

# print summary
DE

## ----fig.width=15,fig.height=6.5,fig.wide = TRUE------------------------------
# prepare model sequence
M = autoscale() + PCA(number_components = 5)
# apply model sequence to dataset
M = model_apply(M,DE)

# pca scores plots
g=list()
for (k in colnames(DE$sample_meta)) {
    C = pca_scores_plot(factor_name = k)
    g[[k]] = chart_plot(C,M[2])
}
# plot using cowplot
plot_grid(plotlist=g, nrow=1, align='vh', labels=c('A','B','C'))

## ----fig.height=10,fig.width=9,fig.wide=TRUE----------------------------------
C = pca_scree_plot()
g1 = chart_plot(C,M[2])

C = pca_loadings_plot()
g2 = chart_plot(C,M[2])

C = pca_dstat_plot(alpha=0.95)
g3 = chart_plot(C,M[2])

p1=plot_grid(plotlist = list(g1,g2),align='h',nrow=1,axis='b')
p2=plot_grid(plotlist = list(g3),nrow=1)
plot_grid(p1,p2,nrow=2)

## ----fig.width=5, fig.height=5------------------------------------------------
# prepare model sequence
M = autoscale() + PLSDA(factor_name='gender')
M = model_apply(M,DE)

C = pls_scores_plot(factor_name = 'gender')
chart_plot(C,M[2])

## ----fig.width=10,fig.height=9,fig.wide=TRUE----------------------------------
# convert gender to numeric
DE$sample_meta$gender=as.numeric(DE$sample_meta$gender)

# models sequence
M = autoscale(mode='both') + PLSR(factor_name='gender',number_components=3)
M = model_apply(M,DE)

# some diagnostic charts
C = plsr_cook_dist()
g1 = chart_plot(C,M[2])

C = plsr_prediction_plot()
g2 = chart_plot(C,M[2])

C = plsr_qq_plot()
g3 = chart_plot(C,M[2])

C = plsr_residual_hist()
g4 = chart_plot(C,M[2])

plot_grid(plotlist = list(g1,g2,g3,g4), nrow=2,align='vh')

## ----results='asis'-----------------------------------------------------------
# model sequence
M = kfold_xval(folds=7, factor_name='gender') * 
    (autoscale(mode='both') + PLSR(factor_name='gender'))
M = run(M,DE,r_squared())


## ----results='asis',echo=FALSE------------------------------------------------
# training set performance
cat('Training set R2:\n')
cat(M$metric.train)
cat('\n\n')
# test set performance
cat('Test set Q2:\n')
cat(M$metric.test)

## ----fig.width=5,fig.height=5-------------------------------------------------
# reset gender to original factor
DE$sample_meta$gender=sacurine$sampleMetadata$gender
# model sequence
M = permutation_test(number_of_permutations = 10, factor_name='gender') *
    kfold_xval(folds=7,factor_name='gender') *
    (autoscale() + PLSDA(factor_name='gender',number_components = 3))
M = run(M,DE,balanced_accuracy())

C = permutation_test_plot(style='boxplot')
chart_plot(C,M)+ylab('1 - balanced accuracy')

## -----------------------------------------------------------------------------
url = 'https://github.com/CIMCB/MetabWorkflowTutorial/raw/master/GastricCancer_NMR.xlsx'

# read in file directly from github...
# X=read.xlsx(url)

# ...or use BiocFileCache
path = bfcrpath(bfc,url)
X = read.xlsx(path)

# sample meta data
SM=X[,1:4]
rownames(SM)=SM$SampleID
# convert to factors
SM$SampleType=factor(SM$SampleType)
SM$Class=factor(SM$Class)
# keep a numeric version of class for regression
SM$Class_num = as.numeric(SM$Class)

## data matrix
# remove meta data
X[,1:4]=NULL
rownames(X)=SM$SampleID

# feature meta data
VM=data.frame(idx=1:ncol(X))
rownames(VM)=colnames(X)

# prepare DatasetExperiment
DE = DatasetExperiment(
    data=X,
    sample_meta=SM,
    variable_meta=VM,
    description='1H-NMR urinary metabolomic profiling for diagnosis of gastric cancer',
    name='Gastric cancer (NMR)')

DE


## -----------------------------------------------------------------------------
# prepare model sequence
M = rsd_filter(rsd_threshold=20,qc_label='QC',factor_name='Class') +
    mv_feature_filter(threshold = 10,method='across',factor_name='Class')

# apply model
M = model_apply(M,DE)

# get the model output
filtered = predicted(M)

# summary of filtered data
filtered


## ----fig.width=10,fig.height=5.5,fig.small=FALSE------------------------------
# prepare the model sequence
M = log_transform(base = 10) +
    autoscale() + 
    knn_impute(neighbours = 3) +
    PCA(number_components = 10)

# apply model sequence to data
M = model_apply(M,filtered)

# get the transformed, scaled and imputed matrix
TSI = predicted(M[3])

# scores plot
C = pca_scores_plot(factor_name = 'SampleType')
g1 = chart_plot(C,M[4])

# loadings plot
C = pca_loadings_plot()
g2 = chart_plot(C,M[4])

plot_grid(g1,g2,align='hv',nrow=1,axis='tblr')

## -----------------------------------------------------------------------------
# prepare model
TT = filter_smeta(mode='include',factor_name='Class',levels=c('GC','HE')) +  
     ttest(alpha=0.05,mtc='fdr',factor_names='Class')

# apply model
TT = model_apply(TT,filtered)

# keep the data filtered by group for later
filtered = predicted(TT[1])

# convert to data frame
out=as_data_frame(TT[2])

# show first few features
head(out)

## -----------------------------------------------------------------------------
# prepare model
M = stratified_split(p_train=0.75,factor_name='Class')
# apply to filtered data
M = model_apply(M,filtered)
# get data from object
train = M$training
train
cat('\n')

test = M$testing
test

## -----------------------------------------------------------------------------
# scale/transform training data
M = log_transform(base = 10) +
    autoscale() + 
    knn_impute(neighbours = 3,by='samples')

# apply model
M = model_apply(M,train)

# get scaled/transformed training data
train_st = predicted(M)

# prepare model sequence
MS = grid_search_1d(
        param_to_optimise = 'number_components',
        search_values = as.numeric(c(1:6)),
        model_index = 2,
        factor_name = 'Class_num',
        max_min = 'max') *
     permute_sample_order(
        number_of_permutations = 10) *
     kfold_xval(
        folds = 5,
        factor_name = 'Class_num') * 
     (mean_centre(mode='sample_meta')+
      PLSR(factor_name='Class_num'))

# run the validation
MS = struct::run(MS,train_st,r_squared())

#
C = gs_line()
chart_plot(C,MS)

## ----fig.wide=TRUE,warning=FALSE,fig.width=15,fig.height=5.5------------------
# prepare the discriminant model
P = PLSDA(number_components = 2, factor_name='Class')

# apply the model
P = model_apply(P,train_st)

# charts
C = plsda_predicted_plot(factor_name='Class',style='boxplot')
g1 = chart_plot(C,P)

C = plsda_predicted_plot(factor_name='Class',style='density')
g2 = chart_plot(C,P)+xlim(c(-2,2))

C = plsda_roc_plot(factor_name='Class')
g3 = chart_plot(C,P)

plot_grid(g1,g2,g3,align='vh',axis='tblr',nrow=1, labels=c('A','B','C'))

## -----------------------------------------------------------------------------
# AUC for comparison with Mendez et al
MET = calculate(AUC(),P$y$Class,P$yhat[,1])
MET

## -----------------------------------------------------------------------------
# model sequence
MS = permutation_test(number_of_permutations = 20,factor_name = 'Class_num') * 
     kfold_xval(folds = 5,factor_name = 'Class_num') *
     (mean_centre(mode='sample_meta') + PLSR(factor_name='Class_num', number_components = 2))

# run iterator
MS = struct::run(MS,train_st,r_squared())

# chart
C = permutation_test_plot(style = 'density') 
chart_plot(C,MS) + xlim(c(-1,1)) + xlab('R Squared')

## -----------------------------------------------------------------------------
# prepare the discriminant model
P = PLSDA(number_components = 2, factor_name='Class')

# apply the model
P = model_apply(P,train_st)

C = pls_scores_plot(components=c(1,2),factor_name = 'Class')
chart_plot(C,P)

## ----fig.width=10,fig.height=5.5,fig.small=FALSE------------------------------
# prepare chart
C = pls_vip_plot(ycol = 'HE')
g1 = chart_plot(C,P)

C = pls_regcoeff_plot(ycol='HE')
g2 = chart_plot(C,P)

plot_grid(g1,g2,align='hv',axis='tblr',nrow=2)

## ----include=FALSE------------------------------------------------------------
# read in file using BiocFileCache
url='https://github.com/CIMCB/MetabWorkflowTutorial/raw/master/GastricCancer_NMR.xlsx'
path = bfcrpath(bfc,url)
X = read.xlsx(path)

# sample meta data
SM=X[,1:4]
rownames(SM)=SM$SampleID
# convert to factors
SM$SampleType=factor(SM$SampleType)
SM$Class=factor(SM$Class)
# keep a numeric version of class for regression
SM$Class_num = as.numeric(SM$Class)

## data matrix
# remove meta data
X[,1:4]=NULL
rownames(X)=SM$SampleID

# feature meta data
VM=data.frame(idx=1:ncol(X))
rownames(VM)=colnames(X)

# prepare DatasetExperiment
DE = DatasetExperiment(
    data=X,
    sample_meta=SM,
    variable_meta=VM,
    description='1H-NMR urinary metabolomic profiling for diagnosis of gastric cancer',
    name='Gastric cancer (NMR)')

M = rsd_filter(rsd_threshold=20,qc_label='QC',factor_name='Class') +
    mv_feature_filter(threshold = 10,method='across',factor_name='Class') +
    log_transform(base = 10) +
    autoscale() + 
    knn_impute(neighbours = 3)

M = model_apply(M,DE)
DE = predicted(M)


## -----------------------------------------------------------------------------
# summary of DatasetExperiment object
DE

## ----fig.height=6,fig.width=5-------------------------------------------------
# model sequence and pls model (NB data already centred)
MS = filter_smeta(mode = 'include', levels = c('GC','HE'), factor_name = 'Class') +
     PLSDA(factor_name = 'Class',number_components = 2)

# apply PLS model
MS = model_apply(MS,DE)

# plot the data
C = pls_scores_plot(factor_name = 'Class')
chart_plot(C,MS[2])

# new DatasetExperiment object from the PLS scores
DE2 = DatasetExperiment(
  data = MS[2]$scores$data, 
  sample_meta = predicted(MS[1])$sample_meta,
  variable_meta = data.frame('LV'=c(1,2),row.names = colnames(MS[2]$scores)),
  name = 'Illustrativate SVM dataset',
  description = 'Generated by applying PLS to the processed Gastric cancer (NMR) dataset'
)

DE2

## ----fig.width=5,fig.height=6-------------------------------------------------
# SVM model
M = SVM(
  factor_name = 'Class',
  kernel = 'linear'
)

# apply model
M = model_apply(M,DE2)

# plot boundary
C = svm_plot_2d(factor_name = 'Class')
chart_plot(C,M, DE2)


## ----fig.width=10,fig.height=11,fig.small=FALSE-------------------------------
# low cost
M$cost=0.01
M=model_apply(M,DE2)
C=svm_plot_2d(factor_name='Species')
g1=chart_plot(C,M,DE2)

# medium cost
M$cost=0.05
M=model_apply(M,DE2)
C=svm_plot_2d(factor_name='Species')
g2=chart_plot(C,M,DE2)

# high cost
M$cost=100
M=model_apply(M,DE2)

C=svm_plot_2d(factor_name='Species')
g3=chart_plot(C,M,DE2)

# plot
prow <- plot_grid(
  g1 + theme(legend.position="none"),
  g2 + theme(legend.position="none"),
  g3 + theme(legend.position="none"),
  align = 'vh',
  labels = c("Low cost", "Medium cost", "High cost"),
  hjust = -1,
  nrow = 2
)

legend <- get_legend(
  # create some space to the left of the legend
  g1 + guides(color = guide_legend(nrow = 1)) +
  theme(legend.position = "bottom")
)

plot_grid(prow, legend, ncol=1, rel_heights = c(1, .1))

## ----fig.width=10,fig.height=11,fig.small=FALSE-------------------------------
# set a fixed cost for this comparison
M$cost=1

# linear kernel
M$kernel='linear'
M=model_apply(M,DE2)
C=svm_plot_2d(factor_name='Species')
g1=chart_plot(C,M,DE2)

# polynomial kernel
M$kernel='polynomial'
M$gamma=1
M$coef0=0
M=model_apply(M,DE2)
C=svm_plot_2d(factor_name='Species')
g2=chart_plot(C,M,DE2)

# rbf kernel
M$kernel='radial'
M$gamma=1
M=model_apply(M,DE2)
C=svm_plot_2d(factor_name='Species')
g3=chart_plot(C,M,DE2)

# sigmoid kernel
M$kernel='sigmoid'
M$gamma=1
M$coef0=0
M=model_apply(M,DE2)
C=svm_plot_2d(factor_name='Species')
g4=chart_plot(C,M,DE2)

# plot
prow <- plot_grid(
  g1 + theme(legend.position="none"),
  g2 + theme(legend.position="none"),
  g3 + theme(legend.position="none"),
  g4 + theme(legend.position="none"),
  align = 'vh',
  labels = c("Linear", "Polynomial", "Radial","Sigmoid"),
  hjust = -1,
  nrow = 2
)
legend <- get_legend(
  # create some space to the left of the legend
  g1 + guides(color = guide_legend(nrow = 1)) +
    theme(legend.position = "bottom")
)
plot_grid(prow, legend, ncol = 1, rel_heights = c(1, .1))

## ----fig.width=10,fig.height=11,fig.small=FALSE-------------------------------
# rbf kernel and cost
M$kernel = 'radial'
M$cost = 1

# low gamma
M$gamma=0.01
M=model_apply(M,DE2)
C=svm_plot_2d(factor_name='Species')
g1=chart_plot(C,M,DE2)

# medium gamma
M$gamma=0.1
M=model_apply(M,DE2)
C=svm_plot_2d(factor_name='Species')
g2=chart_plot(C,M,DE2)

# high gamma
M$gamma=1
M=model_apply(M,DE2)
C=svm_plot_2d(factor_name='Species')
g3=chart_plot(C,M,DE2)

# plot
prow <- plot_grid(
 g1 + theme(legend.position="none"),
 g2 + theme(legend.position="none"),
 g3 + theme(legend.position="none"),
 align = 'vh',
 labels = c("Low gamma", "Medium gamma", "High gamma"),
 hjust = -1,
 nrow = 2
)
legend <- get_legend(
  # create some space to the left of the legend
  g1 + guides(color = guide_legend(nrow = 1)) +
  theme(legend.position = "bottom")
)
plot_grid(prow, legend, ncol = 1, rel_heights = c(1, .1))

## ----warning=FALSE, message=FALSE---------------------------------------------
# path to zip
zipfile = "https://raw.github.com/STATegraData/STATegraData/master/Script_STATegra_Proteomics.zip"

## retrieve from BiocFileCache
path = bfcrpath(bfc,zipfile)
temp = bfccache(bfc)

## ... or download to temp location
# path = tempfile()
# temp = tempdir()
# download.file(zipfile,path)

# unzip
unzip(path, files = "Proteomics_01_uniprot_canonical_normalized.txt", exdir=temp)
# read samples
all_data <-  read.delim(file.path(temp,"Proteomics_01_uniprot_canonical_normalized.txt"), as.is = TRUE, header = TRUE, sep = "\t")

## -----------------------------------------------------------------------------
# extract data matrix
data = all_data[1:2527,51:86]
# shorten sample names
colnames(data) = lapply(colnames(data), function (x) substr(x, 27, nchar(x)))
# replace 0 with NA
data[data == 0] <- NA
# transpose
data=as.data.frame(t(data))

# prepare sample meta
SM = lapply(rownames(data),function(x) {
  s=strsplit(x,'_')[[1]] # split at underscore
  out=data.frame(
    'treatment' = s[[1]],
    'time' = substr(s[[2]],1,nchar(s[[2]])-1) ,    
    'batch' = substr(s[[3]],6,nchar(s[[3]])),
    'condition' = substr(x,1,6) # interaction between treatment and time
  )
  return(out)
})
SM = do.call(rbind,SM)
rownames(SM)=rownames(data)
# convert to factors
SM$treatment=factor(SM$treatment)
SM$time=ordered(SM$time,c("0","2","6","12","18","24"))
SM$batch=ordered(SM$batch,c(1,3,4,5,6,7))
SM$condition=factor(SM$condition)

# variable meta data
VM = all_data[1:2527,c(1,6,7)]
rownames(VM)=colnames(data)

# prepare DatasetExperiment
DS = DatasetExperiment(
  data = data, 
  sample_meta = SM, 
  variable_meta = VM, 
  name = 'STATegra Proteomics',
  description = 'downloaded from: https://github.com/STATegraData/STATegraData/'
)
DS

## ----fig.width=10,fig.height=4.5,fig.small=FALSE------------------------------
# find id of reporters
Ldha = which(DS$variable_meta$Gene.names=='Ldha')
Hk2 = which(DS$variable_meta$Gene.names=='Hk2')

# chart object
C = feature_boxplot(feature_to_plot=Ldha,factor_name='time',label_outliers=FALSE)
g1=chart_plot(C,DS)+ggtitle('Ldha')+ylab('expression')
C = feature_boxplot(feature_to_plot=Hk2,factor_name='time',label_outliers=FALSE)
g2=chart_plot(C,DS)+ggtitle('Hk2')+ylab('expression')

plot_grid(g1,g2,nrow=1,align='vh',axis='tblr')

## ----fig.width=10,fig.height=4.5,fig.small=FALSE------------------------------
# prepare model sequence
M = log_transform(
  base=2) + 
  mean_of_medians(
    factor_name = 'condition')
# apply model sequence
M = model_apply(M,DS) 

# get transformed data
DST = predicted(M)

## ----fig.width=10,fig.height=4.5----------------------------------------------
# chart object
C = feature_boxplot(feature_to_plot=Ldha,factor_name='time',label_outliers=FALSE)
g1=chart_plot(C,DST)+ggtitle('Ldha')+ylab('log2(expression)')
C = feature_boxplot(feature_to_plot=Hk2,factor_name='time',label_outliers=FALSE)
g2=chart_plot(C,DST)+ggtitle('Hk2')+ylab('log2(expression)')

plot_grid(g1,g2,nrow=1,align='vh',axis='tblr')

## -----------------------------------------------------------------------------
# build model sequence
M2 = filter_na_count(
  threshold=2,
  factor_name='condition', 
  predicted='na_count') +    # override the default output
  filter_by_name(
    mode='exclude',
    dimension='variable',
    names='place_holder',
    seq_in='names',
    seq_fcn=function(x) {      # convert NA count pre group to true/false
      x=x>2                  # more the two missing per group
      x=rowSums(x)>10        # in more than 10 groups
      return(x)
    }
  )
# apply to transformed data
M2 = model_apply(M2,DST)

# get the filtered data
DSTF = predicted(M2)

## -----------------------------------------------------------------------------
# create new imputation object
set_struct_obj(
  class_name = 'STATegra_impute1',
  struct_obj = 'model',
  params=c(factor_sd='character',factor_name='character'),
  outputs=c(imputed='DatasetExperiment'),
  prototype = list(
    name = 'STATegra imputation 1',
    description = 'If missing values are present for all one group then they are replaced with min/2 + "random value below discovery".',
    predicted = 'imputed'
  ) 
)

# create method_apply for imputation method 1
set_obj_method(
  class_name='STATegra_impute1',
  method_name='model_apply',
  definition=function(M,D) {
    
    # for each feature count NA within each level
    na = apply(D$data,2,function(x){
      tapply(x,D$sample_meta[[M$factor_name]],function(y){
        sum(is.na(y))
      })
    })
    # count number of samples in each group
    count=summary(D$sample_meta[[M$factor_name]])
    # standard deviation of features within levels of factor_sd
    sd = apply(D$data,2,function(x) {tapply(x,D$sample_meta[[M$factor_sd]],sd,na.rm=TRUE)})
    sd = median(sd,na.rm=TRUE)
    
    # impute or not
    check=na == matrix(count,nrow=2,ncol=ncol(D)) # all missing in one class
    
    # impute matrix
    mi = D$data
    for (j in 1:nrow(mi)) {
      # index of group for this sample
      g = which(levels(D$sample_meta[[M$factor_name]])==D$sample_meta[[M$factor_name]][j])
      iv=rnorm(ncol(D),min(D$data[j,],na.rm=TRUE)/2,sd)
      mi[j,is.na(mi[j,]) & check[g,]] = iv[is.na(mi[j,]) & check[g,]]
    }
    D$data = mi
    M$imputed=D
    return(M)
  }
)

## -----------------------------------------------------------------------------
# create new imputation object
set_struct_obj(
  class_name = 'STATegra_impute2',
  struct_obj = 'model',
  params=c(factor_name='character'),
  outputs=c(imputed='DatasetExperiment'),
  prototype = list(
    name = 'STATegra imputation 2',
    description = 'For those conditions with only 1 NA impute with the mean of the condition.',
    predicted = 'imputed'
  ) 
)

# create method_apply for imputation method 2
set_obj_method(
  class_name='STATegra_impute2',
  method_name='model_apply',
  definition=function(M,D) {
    # levels in condition
    L = levels(D$sample_meta[[M$factor_name]])
    
    # for each feature count NA within each level
    na = apply(D$data,2,function(x){
      tapply(x,D$sample_meta[[M$factor_name]],function(y){
        sum(is.na(y))
      })
    })
    
    # standard deviation of features within levels of factor_sd
    sd = apply(D$data,2,function(x) {tapply(x,D$sample_meta[[M$factor_name]],sd,na.rm=TRUE)})
    sd = median(sd,na.rm=TRUE)
    
    # impute or not
    check=na == 1 # only one missing for a condition
    
    # index of samples for each condition
    IDX = list()
    for (k in L) {
      IDX[[k]]=which(D$sample_meta[[M$factor_name]]==k)
    }
    
    ## impute
    # for each feature
    for (k in 1:ncol(D)) {
      # for each condition
      for (j in 1:length(L)) {
        # if passes test
        if (check[j,k]) {
          # mean of samples in group
          m = mean(D$data[IDX[[j]],k],na.rm=TRUE)
          # imputed value
          im = rnorm(1,m,sd)
          # replace NA with imputed
          D$data[is.na(D$data[,k]) & D$sample_meta[[M$factor_name]]==L[j],k]=im
        }
      }
    }
    M$imputed=D
    return(M)
  }
)

## ----fig.width=10,fig.height=4.5----------------------------------------------
# model sequence
M3 = STATegra_impute1(factor_name='treatment',factor_sd='condition') +
     STATegra_impute2(factor_name = 'condition') + 
     filter_na_count(threshold = 3, factor_name='condition')
# apply model
M3 = model_apply(M3,DSTF)
# get imputed data
DSTFI = predicted(M3)
DSTFI



## ----fig.height=10,fig.width=9,warning=FALSE,message=FALSE,echo=FALSE,fig.small=FALSE----
# distributions plot
C = compare_dist(factor_name = 'treatment')
g=chart_plot(C,DS,DSTFI)

## ----fig.width=9,fig.height=5,warning=FALSE,message=FALSE,fig.small=FALSE-----
# model sequence
P = filter_smeta(mode='include',factor_name='treatment',levels='IKA') +
    mean_centre() + 
    PCA(number_components = 2)
# apply model
P = model_apply(P,DSTFI)

# scores plots coloured by factors
g = list()
for (k in c('batch','time')) {
  C = pca_scores_plot(factor_name=k,ellipse='none')
  g[[k]]=chart_plot(C,P[3])
}

plot_grid(plotlist = g,nrow=1)

## ----warning=FALSE, message=FALSE---------------------------------------------
# path to zip
zipfile = "https://raw.github.com/STATegraData/STATegraData/master/Script_STATegra_Metabolomics.zip"

## retrieve from BiocFileCache
path = bfcrpath(bfc,zipfile)
temp = bfccache(bfc)

## ... or download to temp location
# path = tempfile()
# temp = tempdir()
# download.file(zipfile,path)

# unzip
unzip(zipfile=path, files = "LC_MS_raw_data.xlsx", exdir=temp)

# read samples
data <- as.data.frame(read.xlsx(file.path(temp,"LC_MS_raw_data.xlsx"),sheet = 'Data'))

## -----------------------------------------------------------------------------
# extract sample meta data
SM = data[ ,1:8]

# add coloumn for sample type (QC, blank etc)
blanks=c(1,2,33,34,65,66)
QCs=c(3,4,11,18,25,32,35,36,43,50,57,64)
SM$sample_type='Sample'
SM$sample_type[blanks]='Blank'
SM$sample_type[QCs]='QC'

# put qc/blank labels in all factors for plotting later
SM$biol.batch[SM$sample_type!='Sample']=SM$sample_type[SM$sample_type!='Sample']
SM$time.point[SM$sample_type!='Sample']=SM$sample_type[SM$sample_type!='Sample']
SM$condition[SM$sample_type!='Sample']=SM$sample_type[SM$sample_type!='Sample']

# convert to factors
SM$biol.batch=ordered(SM$biol.batch,c('9','10','11','12','QC','Blank'))
SM$time.point=ordered(SM$time.point,c('0h','2h','6h','12h','18h','24h','QC','Blank'))
SM$condition=factor(SM$condition)
SM$sample_type=factor(SM$sample_type)

# variable meta data
VM = data.frame('annotation'=colnames(data)[9:ncol(data)])

# raw data
X = data[,9:ncol(data)]
# convert 0 to NA
X[X==0]=NA
# force to numeric; any non-numerics will become NA
X=data.frame(lapply(X,as.numeric),check.names = FALSE)

# make sure row/col names match
rownames(X)=data$label
rownames(SM)=data$label
rownames(VM)=colnames(X)


# create DatasetExperiment object
DE = DatasetExperiment(
  data = X, 
  sample_meta = SM, 
  variable_meta = VM, 
  name = 'STATegra Metabolomics LCMS',
  description = 'https://www.nature.com/articles/s41597-019-0202-7'
)

DE

## -----------------------------------------------------------------------------
# prepare model sequence
MS = filter_smeta(mode = 'include', levels='QC', factor_name = 'sample_type') +
     knn_impute(neighbours=5) +
     vec_norm() + 
     log_transform(base = 10) 

# apply model sequence
MS = model_apply(MS, DE)

## ----fig.width=5,fig.height=5.5-----------------------------------------------
# pca model sequence
M =  mean_centre() +
     PCA(number_components = 3)

# apply model
M = model_apply(M,predicted(MS))


# PCA scores plot
C = pca_scores_plot(factor_name = 'sample_type',label_factor = 'order',points_to_label = 'all')
# plot
chart_plot(C,M[2])

## -----------------------------------------------------------------------------
# prepare model sequence
MS = filter_smeta(
      mode = 'include', 
      levels='QC', 
      factor_name = 'sample_type') +
  
     filter_by_name(
      mode = 'exclude', 
      dimension='sample',
      names = c('1358BZU_0001QC_H1','1358BZU_0001QC_A1','1358BZU_0001QC_G1')) +
  
     knn_impute(
      neighbours=5) +
  
     vec_norm() + 
  
     log_transform(
       base = 10) + 
  
     mean_centre() +
  
     PCA(
       number_components = 3)

# apply model sequence
MS = model_apply(MS, DE)

# PCA scores plot
C = pca_scores_plot(factor_name = 'sample_type',label_factor = 'order',points_to_label = 'all')
# plot
chart_plot(C,MS[7])

## -----------------------------------------------------------------------------
# prepare model sequence
MS = filter_smeta(
      mode = 'exclude', 
      levels='Blank', 
      factor_name = 'sample_type') +
  
     filter_smeta(
      mode = 'exclude', 
      levels='12', 
      factor_name = 'biol.batch') +
  
     filter_by_name(
      mode = 'exclude', 
      dimension='sample',
      names = c('1358BZU_0001QC_H1',
                '1358BZU_0001QC_A1',
                '1358BZU_0001QC_G1')) +
  
     knn_impute(
      neighbours=5) +
  
     vec_norm() + 
  
     log_transform(
       base = 10) + 
  
     mean_centre() +
  
     PCA(
       number_components = 3)

# apply model sequence
MS = model_apply(MS, DE)

# PCA scores plots
C = pca_scores_plot(factor_name = 'sample_type')
# plot
chart_plot(C,MS[8])


## ----fig.height=10,fig.width=10,fig.small=FALSE-------------------------------

MS =  filter_smeta(
       mode = 'exclude', 
       levels = '12', 
       factor_name = 'biol.batch') +
  
      filter_by_name(
       mode = 'exclude', 
       dimension='sample',
       names = c('1358BZU_0001QC_H1',
                 '1358BZU_0001QC_A1',
                 '1358BZU_0001QC_G1')) +

      blank_filter(
       fold_change = 20,
       qc_label = 'QC',
       factor_name = 'sample_type') +

      filter_smeta(
       mode='exclude',
       levels='Blank',
       factor_name='sample_type') +
  
      mv_feature_filter(
       threshold = 80, 
       qc_label = 'QC', 
       factor_name = 'sample_type', 
       method = 'QC') +
     
      mv_feature_filter(
        threshold = 50, 
        factor_name = 'sample_type', 
        method='across') +
  
     rsd_filter(
       rsd_threshold=20, 
       qc_label='QC',
       factor_name='sample_type') +
  
     mv_sample_filter(
       mv_threshold = 50) +
     
     pqn_norm(
       qc_label='QC',
       factor_name='sample_type') +
     
     knn_impute(
       neighbours=5, 
       by='samples') +
     
     glog_transform(
       qc_label = 'QC',
       factor_name = 'sample_type') +
     
     mean_centre() + 
     
     PCA(
       number_components = 10)

# apply model sequence
MS = model_apply(MS, DE)


# PCA plots using different factors
g=list()
for (k in c('order','biol.batch','time.point','condition')) {
  C = pca_scores_plot(factor_name = k,ellipse='none')
  # plot
  g[[k]]=chart_plot(C,MS[length(MS)])
}

plot_grid(plotlist = g,align='vh',axis='tblr',nrow=2,labels=c('A','B','C','D'))


## ----warning=FALSE,message=FALSE,fig.height=11,fig.width=5,fig.small=TRUE-----
# get the glog scaled data
GL = predicted(MS[11])

# extract the Ikaros group and apply PCA
IK = filter_smeta(
      mode='include',
      factor_name='condition',
      levels='Ikaros') +
     mean_centre() + 
     PCA(number_components = 5)

# apply the model sequence to glog transformed data
IK = model_apply(IK,GL)

# plot the PCA scores
C = pca_scores_plot(factor_name='time.point',ellipse = 'sample')
g1=chart_plot(C,IK[3])
g2=g1 + scale_color_viridis_d() # add continuous scale colouring

plot_grid(g1,g2,nrow=2,align='vh',axis = 'tblr',labels=c('A','B'))

## -----------------------------------------------------------------------------
sessionInfo()

