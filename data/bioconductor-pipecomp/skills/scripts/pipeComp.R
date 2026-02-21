# Code example from 'pipeComp' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(BiocStyle)

## ----eval=FALSE---------------------------------------------------------------
# BiocManager::install("plger/pipeComp")

## ----echo = FALSE, fig.cap = "Overview of PipeComp and the PipelineDefinition"----
knitr::include_graphics(system.file('docs', 'pipeComp_scheme.png', package = 'pipeComp'),)

## -----------------------------------------------------------------------------
library(pipeComp)
alternatives <- list(
  par1=c("function_A", "function_B"),
  par2=1:3,
  par3=TRUE,
  # ...
  parN=c(10,25,50)
)

## ----eval=FALSE---------------------------------------------------------------
# res <- runPipeline(datasets, alternatives, pipelineDef=PipelineDefinition)

## -----------------------------------------------------------------------------
comb <- buildCombMatrix(alternatives)
head(comb)

## ----eval=FALSE---------------------------------------------------------------
# comb <- comb[ (comb$par1 != "function_A" | comb$par2 == 2) ,]
# res <- runPipeline( datasets, alternatives, pipelineDef=PipelineDefinition,
#                     nthreads=3, comb=comb )

## -----------------------------------------------------------------------------
my_pip <- PipelineDefinition( list( 
  step1=function(x, param1){
    # do something with x and param1
    x
  },
  step2=function(x, method1, param2){
    get(method1)(x, param2) # apply method1 to x, with param2
  },
  step3=function(x, param3){
    x <- some_fancy_function(x, param3)
    # the functions can also output evaluation through the `intermediate_return` slot:
    e <- my_evaluation_function(x)
    list( x=x, intermediate_return=e)
  }
))
my_pip

## -----------------------------------------------------------------------------
my_pip <- PipelineDefinition( 
  list( step1=function(x, meth1){ get(meth1)(x) },
        step2=function(x, meth2){ get(meth2)(x) } ),
  evaluation=list( step2=function(x) c(mean=mean(x), max=max(x)) ),
  description=list( step1="This steps applies meth1 to x.",
                    step2="This steps applies meth2 to x.")
)
my_pip

## -----------------------------------------------------------------------------
datasets <- list( ds1=1:3, ds2=c(5,10,15))
alternatives <- list(meth1=c("log","sqrt"), meth2="cumsum")
tmpdir1 <- paste0(tempdir(),"/")
res <- runPipeline(datasets, alternatives, my_pip, output.prefix=tmpdir1)
res$evaluation$step2

## -----------------------------------------------------------------------------
my_pip[-1]

## -----------------------------------------------------------------------------
pip2 <- addPipelineStep(my_pip, name="newstep", after="step1")
pip2

## -----------------------------------------------------------------------------
stepFn(pip2, "newstep", type="function") <- function(x, newparam){
  do_something(x, newparam)
}
pip2

## -----------------------------------------------------------------------------
list.files(tmpdir1, pattern="evaluation\\.rds")

## -----------------------------------------------------------------------------
ds <- list.files(tmpdir1, pattern="evaluation\\.rds", full.names = TRUE)
names(ds) <- basename(ds)
res1 <- readPipelineResults(resfiles=ds)
res <- aggregatePipelineResults(res1)

## -----------------------------------------------------------------------------
alternatives <- list(meth1=c("log2","sqrt"), meth2="cumsum")
tmpdir2 <- paste0(tempdir(),"/")
res <- runPipeline(datasets, alternatives, my_pip, output.prefix=tmpdir2)

## -----------------------------------------------------------------------------
res1 <- readPipelineResults(tmpdir1)
res2 <- readPipelineResults(tmpdir2)
res <- mergePipelineResults(res1,res2)

## -----------------------------------------------------------------------------
res <- aggregatePipelineResults(res)
res$evaluation$step2

## -----------------------------------------------------------------------------
fragile.fun <- function(x){
  if(any(x>10)) stop("Too big!")
  2^x
}
alternatives$meth1 <- c(alternatives$meth1, "fragile.fun")
res <- runPipeline(datasets, alternatives, my_pip, output.prefix=tmpdir1, skipErrors=TRUE)


## -----------------------------------------------------------------------------
res$evaluation$step2

## ----fig.width=5, fig.height=2------------------------------------------------
plotElapsed(res, agg.by=FALSE)

## ----fig.width=3.5, fig.height=2.5--------------------------------------------
evalHeatmap(res, what=c("mean", "max"))

