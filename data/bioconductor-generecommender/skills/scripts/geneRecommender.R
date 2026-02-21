# Code example from 'geneRecommender' vignette. See references/ for full tutorial.

### R code from vignette source 'geneRecommender.Rnw'

###################################################
### code chunk number 1: geneRecommender.Rnw:53-58
###################################################
library(geneRecommender)
data(geneData)
my.query <- c("31613_at", "31712_at", "31497_at")
normalized.data <- gr.normalize(geneData)
gr.main(normalized.data, my.query, ngenes = 10)


###################################################
### code chunk number 2: geneRecommender.Rnw:77-78
###################################################
gr.cv(normalized.data, my.query)


###################################################
### code chunk number 3: geneRecommender.Rnw:108-110
###################################################
normal.normalized.data <- qnorm((normalized.data + 1)/2)
gr.main(normal.normalized.data, my.query, ngenes = 10)


###################################################
### code chunk number 4: geneRecommender.Rnw:127-131
###################################################
my.fun.1 <- function(input.vector){
  sum(input.vector^(1/2), na.rm = T)
}
gr.main(normalized.data, my.query, ngenes = 10, fun = my.fun.1)


###################################################
### code chunk number 5: geneRecommender.Rnw:144-148
###################################################
my.fun.2 <- function(input.vector){
  1
}
gr.main(normalized.data, my.query, ngenes = 10, fun = my.fun.2)


###################################################
### code chunk number 6: geneRecommender.Rnw:158-160
###################################################
options(digits = 2)
gr.main(normalized.data, my.query, ngenes = 10, extra = T)


###################################################
### code chunk number 7: geneRecommender.Rnw:200-201
###################################################
toLatex(sessionInfo())


