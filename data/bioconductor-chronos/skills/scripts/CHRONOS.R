# Code example from 'CHRONOS' vignette. See references/ for full tutorial.

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
if (.Platform$OS.type == 'unix') 
    { options('CHRONOS_CACHE'=file.path(path.expand("~"), '.CHRONOS') ) }
if (.Platform$OS.type == 'windows') 
    { options('CHRONOS_CACHE'=file.path(gsub("\\\\", "/",
                            Sys.getenv("USERPROFILE")), "AppData/.CHRONOS")) }

## ----eval=TRUE, echo=TRUE-----------------------------------------------------
library('CHRONOS')
load(system.file('extdata', 'Examples//data.RData', package='CHRONOS'))
head(mRNAexpr)

## ----eval=TRUE, echo=TRUE, message=FALSE--------------------------------------
out <- CHRONOSrun(  mRNAexp=mRNAexpr,
                    mRNAlabel='entrezgene',
                    miRNAexp=miRNAexpr,
                    pathType=c('04915', '04917', '04930', '05031'),
                    org='hsa',
                    subType='All',
                    thresholds=c('subScore'=0.4, 'mirScore'=0.4),
                    miRNAinteractions=miRNAinteractions,
                    export='.txt')

