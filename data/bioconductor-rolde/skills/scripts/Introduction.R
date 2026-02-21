# Code example from 'Introduction' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
        collapse = TRUE,
        comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(RolDE)
library(printr)
library(knitr)

## ----install RolDE, eval=FALSE, message=FALSE, warning=FALSE------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager", repos = "http://cran.us.r-project.org")
# BiocManager::install("RolDE")

## ----load data1, echo=TRUE----------------------------------------------------
data(data1)
data("des_matrix1")

## ----explore data1, echo=TRUE-------------------------------------------------
dim(data1)

## ----explore data1 2, echo=TRUE-----------------------------------------------
head(colnames(data1))

## ----explore data1 3, echo=TRUE-----------------------------------------------
dim(des_matrix1)

## ----explore data1 4, echo=TRUE-----------------------------------------------
colnames(des_matrix1)

## ----explore data1 5, echo=TRUE-----------------------------------------------
head(des_matrix1)
tail(des_matrix1)

## ----explore data1 6, echo=TRUE-----------------------------------------------
unique(des_matrix1[,1])

## ----explore data1 7, echo=TRUE-----------------------------------------------
unique(des_matrix1[,2])
table(des_matrix1[,2])

## ----explore data1 8, echo=TRUE-----------------------------------------------
unique(des_matrix1[,3])
table(des_matrix1[,3])

## ----explore data1 9, echo=TRUE-----------------------------------------------
unique(des_matrix1[,4])
table(des_matrix1[,4])

## ----RolDE data1, echo=TRUE, eval=FALSE---------------------------------------
# set.seed(1)
# data1.res<-RolDE(data=data1, des_matrix=des_matrix1, n_cores=3)

## ----RolDE SE usage, echo=TRUE, eval=FALSE------------------------------------
# SE_object_for_RolDE = SummarizedExperiment(assays=list(data1),
#                                             colData = des_matrix1)

## ----RolDE SE object run, echo=TRUE, eval=FALSE-------------------------------
# set.seed(1)
# data1.res<-RolDE(data=SE_object_for_RolDE, n_cores=3)

## ----explore RolDE res data1, echo=FALSE--------------------------------------
data(res1)
data1.res=res1

## ----explore RolDE res data1 2, echo=TRUE-------------------------------------
names(data1.res)

## ----explore RolDE res data1 3, echo=TRUE-------------------------------------
RolDE.data1<-data1.res$RolDE_Results
dim(RolDE.data1)
colnames(RolDE.data1)

## ----explore RolDE res data1 4, echo=TRUE, fig.height=5, fig.width=7----------
RolDE.data1<-RolDE.data1[order(as.numeric(RolDE.data1[,2])),]
head(RolDE.data1, 5)

## ----explore RolDE res data1 5, echo=TRUE, fig.height=5, fig.width=7----------
hist(RolDE.data1$`Estimated Significance Value`, main = "Estimated significance values", xlab="")

## ----explore RolDE res data1 6, echo=TRUE-------------------------------------
length(which(RolDE.data1$`Adjusted Estimated Significance Value`<=0.05))

## ----explore data3, echo=TRUE-------------------------------------------------
data("data3")
data("des_matrix3")
?data3

## ----Run RolDE for data3, echo=TRUE, eval=FALSE-------------------------------
# set.seed(1)
# data3.res<-RolDE(data=data3, des_matrix=des_matrix3, n_cores=3, sig_adj_meth = "bonferroni")

## ----explore RolDE res data3, echo=FALSE--------------------------------------
data(res3)
data3.res=res3

## ----explore RolDE res data3 2, echo=TRUE, fig.height=5, fig.width=7----------
RolDE.data3<-data3.res$RolDE_Results
RolDE.data3<-RolDE.data3[order(as.numeric(RolDE.data3[,2])),]
head(RolDE.data3, 3)

## ----explore RolDE res data3 3, echo=TRUE, fig.height=5, fig.width=7----------
hist(RolDE.data3$`Estimated Significance Value`, main = "Estimated significance values", xlab="")

## ----explore RolDE res data3 4, echo=TRUE, fig.height=5, fig.width=7----------
grep("ups", RolDE.data3[,1])

## ----explore RolDE res data3 5, echo=TRUE, fig.height=5, fig.width=7----------
length(which(RolDE.data3[,4]<=0.05))

## ----plotfindings, echo=TRUE, fig.height=5, fig.width=7-----------------------
?plotFindings

## ----change RolDE parameters, echo=TRUE, eval=FALSE---------------------------
# set.seed(1)
# data1.res<-RolDE(data=data1, des_matrix=des_matrix1, doPar=T, n_cores=3, min_comm_diff = c(4,3))

## ----change RolDE parameters 2, echo=TRUE, eval=FALSE-------------------------
# set.seed(1)
# data1.res<-RolDE_Main(data=data1, des_matrix=des_matrix1, n_cores=3, degree_RegROTS = 2, degree_PolyReg = 3)

## ----change RolDE parameters 3, echo=TRUE, eval=FALSE-------------------------
# set.seed(1)
# data1.res<-RolDE_Main(data=data1, des_matrix=des_matrix1, n_cores=3, model_type="mixed0")

## ----change RolDE parameters 4, echo=TRUE, eval=FALSE-------------------------
# set.seed(1)
# data1.res<-RolDE(data=data1, des_matrix=des_matrix1, n_cores=3, model_type="mixed1")

## ----session info, echo=TRUE--------------------------------------------------
#Session info
sessionInfo()

