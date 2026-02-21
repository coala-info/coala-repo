# Code example from 'RefactoredAffycoretools' vignette. See references/ for full tutorial.

## ----echo = FALSE, results = "asis"-------------------------------------------

BiocStyle::markdown()
options(bitmapType = "cairo")




## ----eval = FALSE-------------------------------------------------------------
# 
# library(knitr)
# purl(system.file("doc/RefactoredAffycoretools.Rmd", package="affycoretools"))
# 
# 

## ----start--------------------------------------------------------------------

suppressMessages(library(affycoretools))
data(sample.ExpressionSet)
eset <- sample.ExpressionSet
eset


## ----include = FALSE----------------------------------------------------------

featureNames(eset) <- gsub("/", "_", featureNames(eset))


## ----model--------------------------------------------------------------------

suppressMessages(library(hgu95av2.db))
eset <- annotateEset(eset, hgu95av2.db)
suppressMessages(library(limma))
pd <- pData(phenoData(eset))
design <- model.matrix(~0+type+sex, pd)
colnames(design) <- gsub("type|sex", "", colnames(design))
contrast <- matrix(c(1,-1,0))
colnames(contrast) <- "Case vs control"
fit <- lmFit(eset, design)
fit2 <- contrasts.fit(fit, contrast)
fit2 <- eBayes(fit)
topTable(fit2, 1)[,1:4]



## ----output-------------------------------------------------------------------

suppressMessages(library(ReportingTools))
htab <- HTMLReport("afile", "My cool results")
publish(topTable(fit2, 1), htab)
finish(htab)



## ----rtools-------------------------------------------------------------------

htab <- HTMLReport("afile2", "My cool results, ReportingTools style")
publish(fit2, htab, eset, factor = pd$type, coef = 1, n = 10)
finish(htab)


## ----output2------------------------------------------------------------------

d.f <- topTable(fit2, 2)
out <- makeImages(df = d.f, eset = eset, grp.factor = pd$type, design = design,
                  contrast = contrast, colind = 1, repdir = ".")
htab <- HTMLReport("afile3", "My cool results, affycoretools style")
publish(out$df, htab, .mofifyDF = list(entrezLinks, affyLinks))
finish(htab)



## ----param2-------------------------------------------------------------------

grps <- factor(apply(pd[,1:2], 1, paste, collapse = "_"))
design <- model.matrix(~0+grps)
colnames(design) <- gsub("grps", "", colnames(design))
contrast <- matrix(c(1,-1,0,0,
                     0,0,1,-1,
                     1,-1,-1,1),
                   ncol = 3)
colnames(contrast) <- c("Female_Case vs Female_Control",
                        "Male_Case vs Male_Control",
                        "Interaction")
fit <- lmFit(eset, design)
fit2 <- contrasts.fit(fit, contrast)
fit2 <- eBayes(fit2)




## ----output3------------------------------------------------------------------

## get a list containing the output for each comparison
out <- lapply(1:3, function(x) topTable(fit2, x))
## process the output to add images
htab <- lapply(1:3, function(x){
    tmp <- HTMLReport(gsub("_", " ", colnames(contrast)[x]), colnames(contrast)[x], "./reports")
    tmp2 <- makeImages(out[[x]], eset, grps, design, contrast, x)
    publish(tmp2$df, tmp, .modifyDF = list(affyLinks, entrezLinks))
    finish(tmp)
    return(tmp)
})



## ----table, results = "asis"--------------------------------------------------


d.f <- data.frame(Comparison =  sapply(htab, function(x) XML::saveXML(Link(x))),
                  "Number significant" = sapply(out, nrow), check.names = FALSE)
kable(d.f, caption = "Number of significant genes.",
      format = "html", row.names = FALSE)


## ----makevenn, results = "asis"-----------------------------------------------

collist <- list(1:2)
venn <- makeVenn(fit2, contrast, design, collist = collist, adj.meth = "none")
## generate a list of captions for each Venn.
## we only have one, so it's a list of length 1.
## we are using the BiocStyle package to control formatting,
## so the first sentence will be bolded and in blue.
cap <- list(paste("A Venn diagram. Note that the first sentence is bolded",
                  "and blue, whereas the rest is normal type and black. Usually",
                  "one would use a more useful caption than this one."))
vennInLine(venn, cap)



## ----echo = FALSE-------------------------------------------------------------

sessionInfo()



