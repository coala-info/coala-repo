# Code example from 'eiR' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'--------------------------------------------------------
BiocStyle::markdown()
options(width=100, max.print=1000)
knitr::opts_chunk$set(
    eval=as.logical(Sys.getenv("KNITR_EVAL", "TRUE")),
    cache=as.logical(Sys.getenv("KNITR_CACHE", "TRUE")))

## ----setup, echo=FALSE, messages=FALSE, warnings=FALSE--------------------------------------------
suppressPackageStartupMessages({
    library(eiR)
    library(ChemmineR)
})

## -------------------------------------------------------------------------------------------------
library(eiR) 
data(sdfsample) 
eiInit(sdfsample[1:99],priorityFn=randomPriorities) 

## -------------------------------------------------------------------------------------------------
r<- 60 
d<- 40 
runId <- eiMakeDb(r,d) 

## ----term=FALSE,fig=TRUE--------------------------------------------------------------------------
#find compounds similar to each query
result=eiQuery(runId,sdfsample[45],K=10,asSimilarity=TRUE)
print(result)

#Compare to traditional similarity search: 
data(apset)
print(cmp.search(apset,apset[45],type=3,cutoff=4,quiet=TRUE))

cid(sdfsample)=sdfid(sdfsample)
plot(sdfsample[result$target[1:4]],regenCoords=TRUE,print=FALSE)

## ----term=FALSE-----------------------------------------------------------------------------------
 eiAdd(runId,sdfsample[100]) 

## ----echo = FALSE, results = 'asis'---------------------------------------------------------------
# on windows it seems the file handle used in eiAdd 
# does not get closed right away, so we wait a little here first
Sys.sleep(1)

## ----term=FALSE-----------------------------------------------------------------------------------
 eiPerformanceTest(runId,K=22) 

## ----eval=FALSE-----------------------------------------------------------------------------------
# 	clustering <- eiCluster(runId,K=5,minNbrs=2,cutoff=0.5)
# 	byCluster(clustering)

## -------------------------------------------------------------------------------------------------
setDefaultDistance("ap", function(d1,d2) 1-cmp.similarity(d1,d2) ) 
setDefaultDistance("fp", function(d1,d2) 1-fpSim(d1,d2) ) 

## -------------------------------------------------------------------------------------------------
addTransform("ap","sdf",
	toObject = function(input,conn=NULL,dir="."){
		sdfset=if(is.character(input) && file.exists(input)){
			read.SDFset(input)
		}else if(inherits(input,"SDFset")){
			input
		}else{
			stop(paste("unknown type for 'input', 
				or filename does not exist. type found:",class(input)))
		}
		list(names=sdfid(sdfset),descriptors=sdf2ap(sdfset))
	}
)

addTransform("ap",  
	toString = function(apset,conn=NULL,dir="."){
		unlist(lapply(ap(apset), function(x) paste(x,collapse=", ")))
	},
	toObject= function(v,conn=NULL,dir="."){ 
		if(inherits(v,"list") || length(v)==0)
			return(v)

		as( if(!inherits(v,"APset")){
				names(v)=as.character(1:length(v));  
				read.AP(v,type="ap",isFile=FALSE)
			} else v,
			"list")  
	}
)


## ----echo=FALSE,term=FALSE------------------------------------------------------------------------
unlink("data",recursive=TRUE)
unlink(paste("run",r,d,sep="-"),recursive=TRUE) 

## ----sessionInfo, results='asis'------------------------------------------------------------------
sessionInfo()

