# Code example from 'quick_start_guide' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
# knitr::knit("vignettes/quick_start_guide.Rmd", output = "README.md")
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library("SharedObject")
SharedObject:::setVerbose(FALSE)

## -----------------------------------------------------------------------------
## Create data
A1 <- matrix(1:9, 3, 3)
## Create a shared object
A2 <- share(A1)

## -----------------------------------------------------------------------------
## Check the data
A1
A2

## Check if they are identical
identical(A1, A2)

## -----------------------------------------------------------------------------
## Check if an object is shared
is.shared(A1)
is.shared(A2)

## -----------------------------------------------------------------------------
library(parallel)
## Create a cluster with only 1 worker
cl <- makeCluster(1)
clusterExport(cl, "A2")
## Check if the object is still a shared object
clusterEvalQ(cl, SharedObject::is.shared(A2))
stopCluster(cl)

## -----------------------------------------------------------------------------
## make a larger vector
x1 <- rep(0, 10000)
x2 <- share(x1)

## This is the actual data that will
## be sent to the other R workers
data1 <-serialize(x1, NULL)
data2 <-serialize(x2, NULL)

## Check the size of the data
length(data1)
length(data2)

## -----------------------------------------------------------------------------
SharedObject(mode = "integer", length = 6)

## -----------------------------------------------------------------------------
SharedObject(mode = "integer", length = 6, attrib = list(dim = c(2L, 3L)))

## -----------------------------------------------------------------------------
## get a summary report
sharedObjectProperties(A2)

## -----------------------------------------------------------------------------
## get the individual properties
getCopyOnWrite(A2)
getSharedSubset(A2)
getSharedCopy(A2)

## set the individual properties
setCopyOnWrite(A2, FALSE)
setSharedSubset(A2, TRUE)
setSharedCopy(A2, TRUE)

## Check if the change has been made
getCopyOnWrite(A2)
getSharedSubset(A2)
getSharedCopy(A2)

## -----------------------------------------------------------------------------
## the element `A` is sharable and `B` is not
x <- list(A = 1:3, B = as.symbol("x"))

## No error will be given, 
## but the element `B` is not shared
shared_x <- share(x)

## Use the `mustWork` argument
## An error will be given for the non-sharable object `B`
tryCatch({
  shared_x <- share(x, mustWork = TRUE)
},
error=function(msg)message(msg$message)
)

## -----------------------------------------------------------------------------
## A single logical is returned
is.shared(shared_x)
## Check each element in x
is.shared(shared_x, depth = 1)

## -----------------------------------------------------------------------------
sharedObjectPkgOptions()

## -----------------------------------------------------------------------------
## change the default setting
sharedObjectPkgOptions(mustWork = TRUE)

## Check if the change is made
sharedObjectPkgOptions("mustWork")

## Restore the default
sharedObjectPkgOptions(mustWork = FALSE)

## -----------------------------------------------------------------------------
x1 <- share(1:4)
x2 <- x1

## x2 becames a regular R object after the change
is.shared(x2)
x2[1] <- 10L
is.shared(x2)

## x1 is not changed
x1
x2

## -----------------------------------------------------------------------------
x1 <- share(1:4, copyOnWrite = FALSE)
x2 <- x1

## x2 will not be duplicated when a change is made
is.shared(x2)
x2[1] <- 0L
is.shared(x2)

## x1 has been changed
x1
x2

## -----------------------------------------------------------------------------
x <- share(1:4, copyOnWrite = FALSE)
x
-x
x

## -----------------------------------------------------------------------------
## Create x1 with copy-on-write off
x1 <- share(1:4, copyOnWrite = FALSE)
x2 <- x1
## change the value of x2
x2[1] <- 0L
## Both x1 and x2 are affected
x1
x2

## Enable copy-on-write
## x2 is now independent with x1
setCopyOnWrite(x2, TRUE)
x2[2] <- 0L
## only x2 is affected
x1
x2

## -----------------------------------------------------------------------------
x1 <- share(1:4)
x2 <- x1
## x2 is not shared after the duplication
is.shared(x2)
x2[1] <- 0L
is.shared(x2)


x1 <- share(1:4, sharedCopy = TRUE)
x2 <- x1
## x2 is still shared(but different from x1) 
## after the duplication
is.shared(x2)
x2[1] <- 0L
is.shared(x2)

## -----------------------------------------------------------------------------
listSharedObjects()

## -----------------------------------------------------------------------------
sessionInfo()

