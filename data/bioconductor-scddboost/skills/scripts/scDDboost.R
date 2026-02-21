# Code example from 'scDDboost' vignette. See references/ for full tutorial.

## ----options, include=FALSE, echo=FALSE---------------------------------------
library(BiocStyle)
knitr::opts_chunk$set(warning=FALSE, error=FALSE, message=FALSE)

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("scDDboost")

## ----echo=FALSE---------------------------------------------------------------
library(ggplot2)
df <- data.frame(
  group = as.factor(rep(c("subtype1", "subtype2", "subtype3"),2)),
proportion = c(1/3,1/3,1/3,1/6,1/2,1/3),
  label = as.factor(rep(c("condition1","condition2"),each = 3))
  )
bp<- ggplot(df, aes(x=proportion,y = "", fill=group))+
geom_bar(width = 2, stat = "identity") + facet_grid(cols = vars(label)) 
pie <- bp + coord_polar("x", start=0) + xlab("subtype proportions") + ylab("")
pie +
  theme(panel.background = element_rect(
    fill = 'white', colour = 'black'),
    panel.grid.minor.x = element_line(size = 0.5),
    panel.grid.minor.y = element_line(size = 0.5),
    panel.grid.major.x = element_line(size = 0.5),
    panel.grid.major.y = element_line(size = 0.5),
    panel.grid.major = element_line(colour = "grey"))

## ----echo = F-----------------------------------------------------------------
x1 <- rnorm(33,10,2)
x2 <- rnorm(33,10,2)
x3 <- rnorm(33,20,2)

x4 <- rnorm(17,10,2)
x5 <- rnorm(50,10,2)
x6 <- rnorm(33,20,2)

df <- data.frame(
  group = c(rep(c("subtype1", "subtype2", "subtype3"),each = 33), c(rep("subtype1",17),rep("subtype2",50),rep("subtype3",33))),
  conditions = factor(c(rep(1,99),rep(2,100))),
  values = c(x1,x2,x3,x4,x5,x6)
  )
p <- ggplot(df,aes(x = conditions,y = values)) + geom_violin() + geom_jitter(aes(colour = group)) + xlab("conditions") + 
  ylab("gene expressions")
  

p + theme(panel.background = element_rect(
    fill = 'white', colour = 'black'),
    panel.grid.minor.x = element_line(size = 0.5),
    panel.grid.minor.y = element_line(size = 0.5),
    panel.grid.major.x = element_line(size = 0.5),
    panel.grid.major.y = element_line(size = 0.5),
    panel.grid.major = element_line(colour = "grey"))

## ----echo = F-----------------------------------------------------------------
x1 <- rnorm(33,10,2)
x2 <- rnorm(33,20,2)
x3 <-  rnorm(33,30,2)

x4 <- rnorm(17,10,2)
x5 <- rnorm(50,20,2)
x6 <- rnorm(33,30,2)

df <- data.frame(
  group = c(rep(c("subtype1", "subtype2", "subtype3"),each = 33), c(rep("subtype1",17),rep("subtype2",50),rep("subtype3",33))),
  conditions = factor(c(rep(1,99),rep(2,100))),
  values = c(x1,x2,x3,x4,x5,x6)
  )
p <- ggplot(df,aes(x = conditions,y = values)) + geom_violin() + geom_jitter(aes(colour = group)) + xlab("conditions") + 
  ylab("gene expressions")
  

p + theme(panel.background = element_rect(
    fill = 'white', colour = 'black'),
    panel.grid.minor.x = element_line(size = 0.5),
    panel.grid.minor.y = element_line(size = 0.5),
    panel.grid.major.x = element_line(size = 0.5),
    panel.grid.major.y = element_line(size = 0.5),
    panel.grid.major = element_line(colour = "grey"))






## -----------------------------------------------------------------------------
suppressMessages(library(scDDboost))

## -----------------------------------------------------------------------------
data(sim_dat)

## -----------------------------------------------------------------------------
data_counts <- SummarizedExperiment::assays(sim_dat)$counts
conditions <- SummarizedExperiment::colData(sim_dat)$conditions
rownames(data_counts) <- seq_len(1000)

##here we use 2 cores to compute the distance matrix
bp <- BiocParallel::MulticoreParam(2)
D_c <- calD(data_counts,bp)

ProbDD <- pdd(data = data_counts,cd = conditions, bp = bp, D = D_c)

## -----------------------------------------------------------------------------
## determine the number of subtypes
K <- detK(D_c)

## -----------------------------------------------------------------------------
EDD <- which(ProbDD > 0.95)

## -----------------------------------------------------------------------------
EDD <- getDD(ProbDD,0.05)

## -----------------------------------------------------------------------------
sessionInfo()

