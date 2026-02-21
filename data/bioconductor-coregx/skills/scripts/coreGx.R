# Code example from 'coreGx' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
library(knitr)
knitr::opts_chunk$set(echo = TRUE)

## ----coregx_load, hide=TRUE, message=FALSE------------------------------------
library(CoreGx)
library(Biobase)
library(SummarizedExperiment)

## ----CoreSet_class------------------------------------------------------------
getClass("CoreSet")

## ----CoreSet_accessors--------------------------------------------------------
methods(class="CoreSet")

## ----the_cSet_object----------------------------------------------------------
data(clevelandSmall_cSet)
clevelandSmall_cSet

## ----cSet_accessor_demo-------------------------------------------------------
mProf <- molecularProfiles(clevelandSmall_cSet, "rna")
mProf[seq_len(5), seq_len(5)]

## ----cSet_accessor_demo1------------------------------------------------------
cInfo <- sampleInfo(clevelandSmall_cSet)
cInfo[seq_len(5), seq_len(5)]

## ----cSet_accessor_demo2------------------------------------------------------
sensProf <- sensitivityProfiles(clevelandSmall_cSet)
sensProf[seq_len(5), seq_len(5)]

## ----defining_a_new_class-----------------------------------------------------
DemoSet <- setClass("DemoSet",
                    representation(demoSlot="character"),
                    contains="CoreSet")
getClass("DemoSet")

## ----inherit_methods----------------------------------------------------------
methods(class="DemoSet")

## ----defining_methods_for_a_new_class-----------------------------------------
clevelandSmall_dSet <- DemoSet(clevelandSmall_cSet)
class(clevelandSmall_dSet@molecularProfiles[['rna']])

expressionSets <- lapply(molecularProfilesSlot(clevelandSmall_dSet), FUN=as,
  'ExpressionSet')
molecularProfilesSlot(clevelandSmall_dSet) <- expressionSets

# Now this will error
tryCatch({molecularProfiles(clevelandSmall_dSet, 'rna')},
         error=function(e)
             print(paste("Error: ", e$message)))

## ----redefine_the_method------------------------------------------------------
setMethod(molecularProfiles,
          signature("DemoSet"),
          function(object, mDataType) {
            pData(object@molecularProfiles[[mDataType]])
          })

## ----testing_new_method-------------------------------------------------------
# Now we test our new method
mProf <- molecularProfiles(clevelandSmall_dSet, 'rna')
head(mProf)[seq_len(5), seq_len(5)]

## ----defining_setter_methods--------------------------------------------------
# Define generic for setter method
setGeneric('demoSlot<-', function(object, value) standardGeneric('demoSlot<-'))

# Define a setter method
setReplaceMethod('demoSlot',
                 signature(object='DemoSet', value="character"),
                 function(object, value) {
                   object@demoSlot <- value
                   return(object)
                 })

# Lets add something to our demoSlot
demoSlot(clevelandSmall_dSet) <- c("This", "is", "the", "demoSlot")

## ----defining_getter_methods--------------------------------------------------
# Define generic for getter method
setGeneric('demoSlot', function(object, ...) standardGeneric("demoSlot"))

# Define a getter method
setMethod("demoSlot",
          signature("DemoSet"),
          function(object) {
            paste(object@demoSlot, collapse=" ")
          })

# Test our getter method
demoSlot(clevelandSmall_dSet)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

