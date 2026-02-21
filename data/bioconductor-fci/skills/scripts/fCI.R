# Code example from 'fCI' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("fCI")

## ----warning = FALSE, message = FALSE-----------------------------------------
 suppressPackageStartupMessages(library(fCI))
 library(fCI)

## -----------------------------------------------------------------------------
fci.data=data.frame(matrix(sample(3:100, 1043*6, replace=TRUE), 1043,6))
fci.data=total.library.size.normalization(fci.data)

## -----------------------------------------------------------------------------
fci.data=data.frame(matrix(sample(3:100, 1043*6, replace=TRUE), 1043,6))
fci.data=trim.size.normalization(fci.data)

## -----------------------------------------------------------------------------
  
pkg.path=path.package('fCI')
filename=paste(pkg.path, "/extdata/Supp_Dataset_part_2.txt", sep="")

if(file.exists(filename)){
  fci=new("NPCI")
  fci=find.fci.targets(fci, c(1,2,3), c(4,5,6), filename)
}


## -----------------------------------------------------------------------------
  Diff.Expr.Genes=show.targets(fci)
  head(Diff.Expr.Genes)

## -----------------------------------------------------------------------------
  figures(fci)

## -----------------------------------------------------------------------------
  fci=find.fci.targets(fci, c(1,2), 5, filename)

## -----------------------------------------------------------------------------
if(file.exists(filename)){
  Diff.Expr.Genes=fCI.call.by.index(c(1,2,3), c(4,5,6), filename)
  head(Diff.Expr.Genes)
}

## ----results='asis'-----------------------------------------------------------
fci.data=data.frame(matrix(sample(3:100, 1043*6, replace=TRUE), 1043,6))

## ----warning = FALSE, message = FALSE-----------------------------------------
 library(fCI)
 fci=new("NPCI")
 targets=find.fci.targets(fci, c(1,2,3), c(4,5,6), fci.data)
 Diff.Expr.Genes=show.targets(targets)
 head(Diff.Expr.Genes)
 figures(targets)

## -----------------------------------------------------------------------------
fci=new("NPCI")
filename2=paste(pkg.path, "/extdata/proteoGenomics.txt", sep="")
if(file.exists(filename2)){
  targets=find.fci.targets(fci, list(1:2, 7:8), list(5:6, 11:12),
                       filename2)
  Diff.Expr.Genes=show.targets(targets)
  head(Diff.Expr.Genes)
}

## -----------------------------------------------------------------------------
proteogenomic.data=read.csv(filename2, sep="\t")
head(proteogenomic.data)

## -----------------------------------------------------------------------------
fci=new("NPCI")
fci=setfCI(fci, 7:8, 11:12, seq(from=1.1,to=3,by=0.1), TRUE)

## -----------------------------------------------------------------------------
if(file.exists(filename2)){
  fci=find.fci.targets(fci, 7:8, 11:12, filename2)
  head(show.targets(fci))
}
figures(fci)

