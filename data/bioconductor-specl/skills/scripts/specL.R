# Code example from 'specL' vignette. See references/ for full tutorial.

## ----echo=FALSE, eval = TRUE, fig = FALSE, echo=FALSE-----
options(prompt = "R> ",
        continue = "+  ",
        width = 60,
        useFancyQuotes = FALSE,
        warn = -1)

## ----load-------------------------------------------------
library(specL)
packageVersion('specL')

## ----summry-----------------------------------------------
summary(peptideStd)

## ----peptideStd-------------------------------------------
# plot(peptideStd)
plot(0,0, main='MISSING')

## ----pepttidePlot-----------------------------------------
demoIdx <- 40
# str(peptideStd[[demoIdx]])
#res <- plot(peptideStd[[demoIdx]], ion.axes=TRUE)
plot(0,0, main='MISSING')

## ----mascot2psmSet----------------------------------------
specL:::.mascot2psmSet

## ----irtFASTAseq------------------------------------------
irtFASTAseq <- paste(">zz|ZZ_FGCZCont0260|",
"iRT_Protein_with_AAAAK_spacers concatenated Biognosys\n",
"LGGNEQVTRAAAAKGAGSSEPVTGLDAKAAAAKVEATFGVDESNAKAAAAKYILAGVENS",
"KAAAAKTPVISGGPYEYRAAAAKTPVITGAPYEYRAAAAKDGLDAASYYAPVRAAAAKAD",
"VTPADFSEWSKAAAAKGTFIIDPGGVIRAAAAKGTFIIDPAAVIRAAAAKLFLQFGAQGS",
"PFLK\n")

Tfile <- file();  cat(irtFASTAseq, file = Tfile);
fasta.irtFASTAseq <- read.fasta(Tfile, as.string=TRUE, seqtype="AA")
close(Tfile)

## ---------------------------------------------------------
peptideStd[[demoIdx]]$proteinInformation

## ---------------------------------------------------------
peptideStd <- annotate.protein_id(peptideStd, 
    fasta=fasta.irtFASTAseq)

## ---------------------------------------------------------
(idx <- which(unlist(lapply(peptideStd, 
    function(x){nchar(x$proteinInformation)>0}))))

## ---------------------------------------------------------
peptideStd[[demoIdx]]$proteinInformation

## ---------------------------------------------------------
digestPattern = "(([RK])|(^)|(^M))"

## ---------------------------------------------------------
res.genSwathIonLib <- genSwathIonLib(data = peptideStd, 
   data.fit = peptideStd.redundant)

## ---------------------------------------------------------
summary(res.genSwathIonLib)

## ---------------------------------------------------------
res.genSwathIonLib@ionlibrary[[demoIdx]]

## ----fig.retina=3-----------------------------------------
plot(res.genSwathIonLib@ionlibrary[[demoIdx]])

## ----fig.retina=3-----------------------------------------
# define customized fragment ions
# for demonstration lets consider only the top five singly charged y ions.

r.genSwathIonLib.top5 <- genSwathIonLib(peptideStd,
    peptideStd.redundant, topN=5,
    fragmentIonFUN=function (b, y) {
      return( cbind(y1_=y) )
      }
    )

             
plot(r.genSwathIonLib.top5@ionlibrary[[demoIdx]])

## ---------------------------------------------------------
iRTpeptides

## ----fit, eval=FALSE--------------------------------------
# fit <- lm(formula = rt ~ aggregateInputRT * fileName, data = m)

## ----eval=FALSE-------------------------------------------
# data <- aggregate(df$rt, by = list(df$peptide, df$fileName),
#   FUN = mean)
# data.fit <- aggregate(df.fit$rt,
#   by = list(df.fit$peptide, df.fit$fileName),
#   FUN = mean)

## ----merge, eval=FALSE------------------------------------
# m <- merge(iRT, data.fit, by.x='peptide', by.y='peptide')

## ----fig.retina=3-----------------------------------------
# calls the plot method for a specLSet object
op <- par(mfrow=c(2,3)) 
plot(res.genSwathIonLib)
par(op)

## ----fig.retina=3-----------------------------------------
idx.iRT <- which(unlist(lapply(peptideStd,
  function(x){
    if(x$peptideSequence %in% iRTpeptides$peptide){0}
    else{1}
  })) == 0)

# remove all iRTs and compute ion library
res.genSwathIonLib.no_iRT <- genSwathIonLib(peptideStd[-idx.iRT])
summary(res.genSwathIonLib.no_iRT)
op <- par(mfrow = c(2, 3)) 
plot(res.genSwathIonLib.no_iRT)
par(op)

## ---------------------------------------------------------
write.spectronaut(res.genSwathIonLib,
  file="specL-Spectronaut.txt")

## ----eval=FALSE-------------------------------------------
# res <- genSwathIonLib(data, data.fit,
#   topN=10,
#   fragmentIonMzRange=c(200,2000),
#   fragmentIonRange=c(2,100))

## ----sessionInfo, echo=FALSE------------------------------
sessionInfo()

