# Code example from 'ClusterSignificance-vignette' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()
library(ggplot2)

## ----echo=TRUE, eval=TRUE, message=FALSE--------------------------------------
library(ClusterSignificance)

## ----demoDataMlp--------------------------------------------------------------
data(mlpMatrix)

## ----headMat, echo=FALSE, eval=TRUE-------------------------------------------
##Mlp
printMat <- mlpMatrix
classes <- rownames(mlpMatrix)
dimnames(printMat) <- list(classes, paste("dim", 1:2, sep = ""))
knitr::kable(
    printMat[1:3,], 
    digits = 2, 
    caption = "Head; Mlp matrix.", 
    align = c(rep('l', 2))
)

gTable <- as.data.frame(table(classes))
knitr::kable(
    gTable, 
    digits = 2, 
    align = c(rep('l', 2)), 
    caption = "Rownames table; Mlp matrix."
)

## ----demoDataPcp--------------------------------------------------------------
data(pcpMatrix)

## ----headPcp, echo=FALSE------------------------------------------------------
##Pcp
printMat <- pcpMatrix
classes <- rownames(pcpMatrix)
dimnames(printMat) <- list(classes, paste("dim", 1:3, sep=""))
knitr::kable(
    printMat[1:3,], 
    digits = 2, 
    caption = "Head; Pcp matrix.", 
    align = c(rep('l', 2))
)

gTable <- as.data.frame(table(classes))
knitr::kable(
    gTable, 
    digits = 2, 
    align = c(rep('l', 2)), 
    caption = "Rownames table; Pcp matrix."
)

## ----PcpProjection, fig.align='center', fig.width=10, fig.height=10-----------
## Create the group variable.
classes <- rownames(pcpMatrix)

## Run Pcp and plot.
prj <- pcp(pcpMatrix, classes)
plot(prj)

## ----classifyPcp, message=FALSE, fig.width=10, fig.height=7-------------------
cl <- classify(prj)
plot(cl)

## -----------------------------------------------------------------------------
getData(cl, "AUC")

## ----permutePcp, message=FALSE, fig.width=10, fig.height=7--------------------
#permute matrix
iterations <- 100 ## Set the number of iterations.

## Permute and plot.
pe <- permute(
    mat = pcpMatrix, 
    iter = iterations, 
    classes = classes, 
    projmethod = "pcp"
)

plot(pe)

## ----pValuePcp, echo=TRUE, eval=TRUE, message=FALSE---------------------------
pvalue(pe)

## ----confIntPcp, echo=TRUE, eval=TRUE, message=FALSE--------------------------
conf.int(pe, conf.level = .99)

## ----fig.align='center', fig.width=10, fig.height=8---------------------------
## Create the group variable.
classes <- rownames(mlpMatrix)

## Run Mlp and plot.
prj <- mlp(mlpMatrix, classes)
plot(prj)

## ----classifyMlp, message=FALSE, fig.align='center', fig.width=8, fig.height=6----
## Classify and plot.
cl <- classify(prj)
plot(cl)

## ----permuteMlp, message=FALSE, fig.align='center', message = FALSE-----------
## Set the seed and number of iterations.
iterations <- 500 

## Permute and plot.
pe <- permute(
    mat = mlpMatrix, 
    iter = iterations, 
    classes = classes, 
    projmethod = "mlp"
)

plot(pe)

## ----pValueMlp, echo=FALSE, eval=TRUE, message=FALSE--------------------------
## p-value
pvalue(pe)
conf.int(pe)

## ----echo=TRUE, eval=TRUE, message=FALSE--------------------------------------
## The leukemia dataset is provided as a list with 3 elements. 
## An explaination of these can be found using the command:
## help(leukemia)

library(plsgenomics, quietly = TRUE)
data(leukemia)

## Extract the expression matrix.
expression <- leukemia$X 

## Run PCA and extract the principal components.
pca <- prcomp(expression, scale = TRUE)
mat <- pca$x

## Extract the grouping variable (coded as 1 (ALL) and 2 (AML)).
classes <- ifelse(leukemia$Y == 1, "ALL", "AML")

## ----echo = FALSE-------------------------------------------------------------
gTable <- as.data.frame(table(classes))
knitr::kable(gTable, 
    digits = 2, 
    align = c(rep('l', 2)), 
    caption = "Classes argument table."
)

## ----ALLprojection, fig.align='center', fig.width=10, fig.height=10-----------
ob <- pcp(mat, classes, normalize = TRUE)
plot(ob)

## ----ALLclassification, fig.align='center', fig.width=8, fig.height=6---------
cl <- classify(ob)
plot(cl)

## ----ALLpermutation, fig.align='center', message = FALSE----------------------
iterations <- 100
pe <- permute(mat = mat, iter = iterations, classes = classes, projmethod = "pcp")
pvalue(pe)
conf.int(pe)

## ----concatPermuts, message=FALSE, eval=TRUE----------------------------------
mat <- mlpMatrix
classes <- rownames(mlpMatrix)
iterations <- 10

pe1 <- permute(mat=mat, iter=iterations, classes=classes, projmethod="pcp")
pe2 <- permute(mat=mat, iter=iterations, classes=classes, projmethod="pcp")
pe3 <- permute(mat=mat, iter=iterations, classes=classes, projmethod="pcp")
pvalue(pe1)

pe <- c(pe1, pe2, pe3)
pvalue(pe)

## ----userDefinedPermats, eval=TRUE--------------------------------------------
##define permMatrix function
.pca <- function(y, classes, uniq.groups, mat) {
    pca <- prcomp(
        sapply(1:ncol(mat[classes %in% uniq.groups[, y], ]), 
            function(i)
                mat[classes %in% uniq.groups[, y], i] <- 
                    sample(
                        mat[classes %in% uniq.groups[, y], i], 
                        replace=FALSE
                    )
        ), scale=TRUE
    )
    return(pca$x)
}

permMatrix <- function(iterations, classes, mat) {
    uniq.groups <- combn(unique(classes), 2)
    permats <- lapply(1:ncol(uniq.groups), 
        function(y)
            lapply(1:iterations, 
                function(x)
                    .pca(y, classes, uniq.groups, mat)
            )
    )
    return(permats)
}

set.seed(3)
mat <- pcpMatrix
classes <- rownames(pcpMatrix)
iterations = 100
permats <- permMatrix(iterations, classes, mat)

## ----runUserDefinedMatrix, eval=FALSE-----------------------------------------
# pe <- permute(
#     mat = mat,
#     iter=100,
#     classes=classes,
#     projmethod="pcp",
#     userPermats=permats
# )

## ----echo=TRUE, eval=TRUE-----------------------------------------------------
sessionInfo()

