# Code example from 'TypeInfoNews' vignette. See references/ for full tutorial.

### R code from vignette source 'TypeInfoNews.Rnw'

###################################################
### code chunk number 1: TypeInfoNews.Rnw:24-25
###################################################
options(width=45)


###################################################
### code chunk number 2: oneWayAnova
###################################################
oneWayAnova <- function( response, predictor ) {
    expr <- substitute( response ~ predictor )
    result <- lm( as.formula( expr ))
    anova( result )
}
copyOfOneWayAnova <- oneWayAnova


###################################################
### code chunk number 3: analysis1
###################################################
ctl <- c(4.17,5.58,5.18,6.11,4.50,4.61,5.17,4.53,5.33,5.14)
trt <- c(4.81,4.17,4.41,3.59,5.87,3.83,6.03,4.89,4.32,4.69)
group <- gl(2,10,20, labels=c("Ctl","Trt"))
weight <- c(ctl, trt)
oneWayAnova( weight, group )


###################################################
### code chunk number 4: TypeInfoNews.Rnw:99-100
###################################################
library(TypeInfo)


###################################################
### code chunk number 5: TypeInfoNews.Rnw:105-111
###################################################
typeInfo(oneWayAnova) <-
  SimultaneousTypeSpecification(
    TypedSignature(
      response = "numeric",
      predictor = "factor"),
    returnType = "anova")


###################################################
### code chunk number 6: typedFunc
###################################################
oneWayAnova( weight, group )


###################################################
### code chunk number 7: introspection (eval = FALSE)
###################################################
## typeInfo(oneWayAnova)


###################################################
### code chunk number 8: typeInfoOutupt
###################################################
typeInfo(oneWayAnova)
ngroup <- as.numeric( group )
res <- 
    tryCatch(oneWayAnova( weight, ngroup ),
             error=function(err) {
                 cat("Error:", 
                     conditionMessage(err), "\n")
             })


###################################################
### code chunk number 9: sgroup (eval = FALSE)
###################################################
## ngroup <- as.numeric( group )
## res <- try( oneWayAnova( weight, ngroup ))


###################################################
### code chunk number 10: TypeInfoNews.Rnw:187-197
###################################################
oneWayAnova <- copyOfOneWayAnova
typeInfo(oneWayAnova) <-
  SimultaneousTypeSpecification(
    TypedSignature(
      response = "numeric",
      predictor = "factor"),
    TypedSignature(
      response = "numeric",
      predictor = "numeric"),
    returnType = "anova")


###################################################
### code chunk number 11: integerVals
###################################################
iweight <- as.integer( weight )
oneWayAnova( iweight, group )


###################################################
### code chunk number 12: strictIs (eval = FALSE)
###################################################
## oneWayAnova <- copyOfOneWayAnova
## typeInfo(oneWayAnova) <-
##   SimultaneousTypeSpecification(
##     TypedSignature(
##       response = StrictIsTypeTest("numeric"),
##       predictor = InheritsTypeTest("factor")),
##     returnType = StrictIsTypeTest("anova"))
## oneWayAnova(iweight, group) # ERROR


###################################################
### code chunk number 13: dynamicTypeTest (eval = FALSE)
###################################################
## typeInfo(oneWayAnova) <-
##   SimultaneousTypeSpecification(
##     TypedSignature(
##       response = "numeric",
##       predictor = quote(
##         length(predictor) == 
##             length(response) &&
##         is(predictor, "factor"))),
##     returnType = StrictIsTypeTest("anova"))
## short <- weight[-1]
## oneWayAnova(short, group)   # ERROR


###################################################
### code chunk number 14: IndependentTypeSpecification
###################################################
oneWayAnova <- copyOfOneWayAnova
typeInfo(oneWayAnova) <-
  IndependentTypeSpecification(
    response = "numeric",
    predictor = c( "factor", "numeric" ))


