# Code example from 'Vignette' vignette. See references/ for full tutorial.

### R code from vignette source 'Vignette.Rnw'

###################################################
### code chunk number 1: Vignette.Rnw:51-54
###################################################
library(oposSOM)
env <- opossom.new(list(dataset.name="Tissues",
                        dim.1stLvlSom=20))


###################################################
### code chunk number 2: Vignette.Rnw:61-65
###################################################
data(opossom.tissues)
str(opossom.tissues, vec.len=3)

env$indata <- opossom.tissues


###################################################
### code chunk number 3: Vignette.Rnw:71-78
###################################################
data(opossom.tissues)

library(Biobase)
opossom.tissues.eset = ExpressionSet(assayData=opossom.tissues)
opossom.tissues.eset

env$indata <- opossom.tissues.eset


###################################################
### code chunk number 4: Vignette.Rnw:88-97
###################################################
env$group.labels <- c(rep("Homeostasis", 2),
                          "Endocrine",
                          "Digestion",
                          "Exocrine",
                          "Epithelium",
                          "Reproduction",
                          "Muscle",
                      rep("Immune System", 2),
                      rep("Nervous System", 2) )


###################################################
### code chunk number 5: Vignette.Rnw:99-108
###################################################
env$group.colors <- c(rep("gold", 2),
                          "red2",
                          "brown",
                          "purple",
                          "cyan",
                          "pink",
                          "green2",
                      rep("blue2", 2),
                      rep("gray", 2) )


###################################################
### code chunk number 6: Vignette.Rnw:114-136
###################################################
group.info <- data.frame( 
                  group.labels = c(rep("Homeostasis", 2),
                                       "Endocrine",
                                       "Digestion",
                                       "Exocrine",
                                       "Epithelium",
                                       "Reproduction",
                                       "Muscle",
                                   rep("Immune System", 2),
                                   rep("Nervous System", 2) ),

                  group.colors = c(rep("gold", 2),
                                       "red2",
                                       "brown",
                                       "purple",
                                       "cyan",
                                       "pink",
                                       "green2",
                                   rep("blue2", 2),
                                   rep("gray", 2) ),
													
                  row.names=colnames(opossom.tissues))


###################################################
### code chunk number 7: Vignette.Rnw:138-143
###################################################
opossom.tissues.eset = ExpressionSet(assayData=opossom.tissues,
                                     phenoData=AnnotatedDataFrame(group.info) )
opossom.tissues.eset

env$indata <- opossom.tissues.eset


###################################################
### code chunk number 8: Vignette.Rnw:153-154 (eval = FALSE)
###################################################
## opossom.run(env)


###################################################
### code chunk number 9: Vignette.Rnw:293-298
###################################################
env$preferences$pairwise.comparison.list <-
    list(list(c("liver","kidney cortex"),
              c("accumbens","cerebral cortex")),
         list(c("tongue","small intestine"),
              c("accumbens","cerebral cortex")))


###################################################
### code chunk number 10: Vignette.Rnw:324-327 (eval = FALSE)
###################################################
## library(biomaRt)
## mart<-useMart("ensembl")
## listDatasets(mart)


###################################################
### code chunk number 11: Vignette.Rnw:332-335 (eval = FALSE)
###################################################
## library(biomaRt)
## mart<-useMart(biomart="ensembl", dataset="hsapiens_gene_ensembl")
## listFilters(mart)


###################################################
### code chunk number 12: Vignette.Rnw:349-350
###################################################
sessionInfo()


