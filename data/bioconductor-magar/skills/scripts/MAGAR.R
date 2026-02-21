# Code example from 'MAGAR' vignette. See references/ for full tutorial.

## ----setup, include=FALSE, cache=FALSE----------------------------------------
knitr::opts_chunk$set(echo = TRUE)
#knitr::opts_knit$set(root.dir="")

## ----installation, echo=TRUE, eval=FALSE--------------------------------------
# if(!requireNamespace("BiocManager")){
#     install.packages("BiocManager")
# }
# if(!requireNamespace("MAGAR")){
#     BiocManager::install("MAGAR")
# }

## ----loading, eval=TRUE-------------------------------------------------------
suppressPackageStartupMessages(library(MAGAR))  

## ----options, eval=TRUE-------------------------------------------------------
opts <- rnb.xml2options(system.file("extdata","rnbeads_options.xml",package="MAGAR"))
rnb.options(identifiers.column="geo_accession",
    import.idat.platform="probes450")
xml.fi <- file.path(getwd(),"rnbeads_options.xml")
cat(rnb.options2xml(),file=xml.fi)
qtlSetOption(rnbeads.options = xml.fi)

## ----plink_folder, eval=FALSE-------------------------------------------------
# geno.dir <- "plink_data"
# rnb.set <- load.rnb.set("rnb_set_dir")
# s.anno <- "sample_annotation.csv"
# data.loc <- list(idat.dir=rnb.set,geno.dir=plink.dir)
# qtlSetOption(geno.data.type="plink",
#     meth.data.type="rnb.set")
# meth.qtl <- doImport(data.location=data.loc,
#     s.anno=s.anno,
#     s.id.col="SampleID",
#     out.folder=getwd())

## ----imputation options, eval=TRUE--------------------------------------------
qtlSetOption(
  impute.geno.data=TRUE,
  imputation.reference.panel="apps@hrc-r1.1",
  imputation.phasing.method="shapeit",
  imputation.population="eur"
)

## ----imputed_import,eval=FALSE------------------------------------------------
# idat.dir <- "idat_dir"
# geno.dir <- "geno_dir"
# anno.sheet <- "sample_annotation.tsv"
# qtlSetOption(hdf5dump=TRUE)
# imp.data <- doImport(data.location = c(idat.dir=idat.dir,geno.dir=geno.dir),
#                     s.anno = anno.sheet,
#                     s.id.col = "ID",
#                     tab.sep = "\t",
#                     out.folder = getwd())

## ----call_methQTL, eval=TRUE--------------------------------------------------
imp.data <- loadMethQTLInput(system.file("extdata","reduced_methQTL",package="MAGAR"))
qtlSetOption(standard.deviation.gauss=100,
    cluster.cor.threshold=0.75)
meth.qtl.res <- doMethQTL(imp.data,default.options=FALSE,p.val.cutoff=0.05)

## ----show_results, eval=TRUE--------------------------------------------------
result.table <- getResult(meth.qtl.res)
head(result.table)
anno.meth <- getAnno(meth.qtl.res,"meth")
head(anno.meth)
anno.geno <- getAnno(meth.qtl.res,"geno")
head(anno.geno)

## ----plots,eval=TRUE, include=TRUE--------------------------------------------
result.table <- result.table[order(result.table$P.value,decreasing=FALSE),]
qtlPlotSNPCpGInteraction(imp.data,result.table$CpG[1],result.table$SNP[1])
qtlDistanceScatterplot(meth.qtl.res)

## ----interpretation, eval=TRUE, include=TRUE, warning=FALSE-------------------
res <- qtlBaseSubstitutionEnrichment(meth.qtl.res)

## ----list, eval=TRUE, warning=FALSE-------------------------------------------
meth.qtl.res.2 <- loadMethQTLResult(system.file("extdata","MethQTLResult_chr18",package="MAGAR"))
meth.qtl.list <- list(First=meth.qtl.res,Second=meth.qtl.res.2)
qtlVennPlot(meth.qtl.list,out.folder=getwd())
qtlUpsetPlot(meth.qtl.list,type = "cor.block")
spec.first <- getSpecificQTL(meth.qtl.list$First,meth.qtl.list[-1])

## ----cluster, eval=FALSE------------------------------------------------------
# qtlSetOption(cluster.config = c(h_vmem="60G",mem_free="20G"))
# qtlSetOption(rscript.path = "/usr/bin/Rscript")
# meth.qtl.res <- doMethQTL(meth.qtl = imp.data,
#                         cluster.submit = T)

