# Code example from 'msqc1' vignette. See references/ for full tutorial.

## ----echo = FALSE, message = FALSE--------------------------------------------
if (!require(msqc1)){
  ## try http:// if https:// URLs are not supported
  if (!requireNamespace("BiocManager", quietly=TRUE))
      install.packages("BiocManager")
}

## ----"Supplementary Figure1", echo=FALSE, fig.width=6, fig.height=6, fig.retina=3, warning=FALSE, message = FALSE----
plot(10 * msqc1::peptides$SIL.peptide.per.vial, msqc1::peptides$actual.LH.ratio,
     log='xy',
     ylab='reference L:H ratio',
     xlab='on column amount [fmol]',
     axes=FALSE,
     xlim=c(0.8, 2000));

axis(1, 10 * peptides$SIL.peptide.per.vial, 10 * peptides$SIL.peptide.per.vial )
axis(2, peptides$actual.LH.ratio, peptides$actual.LH.ratio)
text(10 * peptides$SIL.peptide.per.vial, peptides$actual.LH.ratio, peptides$Peptide.Sequence, cex=0.5 ,pos=4, srt=11)
box()

## -----------------------------------------------------------------------------
table(msqc1_dil$relative.amount)

## -----------------------------------------------------------------------------
table(msqc1_dil$Peptide.Sequence)

## -----------------------------------------------------------------------------
table(msqc1_dil$Fragment.Ion)

## -----------------------------------------------------------------------------
table(msqc1_dil$instrument)

## ----"Figure1", echo=FALSE, fig.width=14, fig.height=9, fig.retina=3, warning=FALSE, message = FALSE----
msqc1:::.figure1(data=msqc1_8rep, peptides=peptides)

## ----echo=FALSE---------------------------------------------------------------
# taken from WEW
.compute_volcano_tuple <- function(x, y, adjust=TRUE, alternative="two.sided"){
  stopifnot(nrow(x) == nrow(y))

  res <- lapply(1:nrow(x), function(i){
    r <- t.test(x[i,], y[i,], paired =FALSE, alternative=alternative)
    data.frame(FC=(r$estimate[1] - r$estimate[2]), p.value=r$p.value)
  })
  
  res <- do.call('rbind', res)
  
  if(adjust){
    res$pval <- p.adjust(res$p.value, method="BH")
  }
  return(res)
} 

.shape_for_volcano <- function(S, peptides){
  
  S <- S[grep("[by]", S$Fragment.Ion), ]
  S <- S[S$Peptide.Sequence %in% peptides$Peptide.Sequence, ]
  S <- aggregate(Area ~ Peptide.Sequence + Isotope.Label.Type + instrument + File.Name.Id,
                data=S, FUN=sum)
  
  
  S <- data.frame(
    Peptide.Sequence=paste(S$Peptide.Sequence, S$Isotope.Label.Type, sep=','),
    Area=S$Area,
    instrument=paste(S$instrument), rep=S$File.Name.Id)
  
  
  S <- reshape(S,
               v.name="Area",
               idvar=c("Peptide.Sequence", 'instrument'),
               timevar="rep",
               direction = "wide")
  
  p <- gsub(".light", "", gsub(".heavy", "", S$Peptide.Sequence))

  row.names(S) <- 1:nrow(S)
  S <- (droplevels(S[which(p %in% names(table(p)[table(p) == 10])), ]))
  S <- S[order(paste(S$instrument, S$Peptide.Sequence )), ]
  
  idx.l <- grep('light', S$Peptide.Sequence )
  idx.h <- grep('heavy', S$Peptide.Sequence )
  
  L<-S[idx.l, 3:10]
  H<-S[idx.h, 3:10]
  v <- .compute_volcano_tuple(log2(L), log2(H))
  
  Peptide.Sequence <- gsub(".light", "", S$Peptide.Sequence[idx.l])
  instrument <- S$instrument[idx.l]
  
  S <- data.frame(Peptide.Sequence, instrument, log2FC=v$FC, p.value=v$p.value)
}


## ----fig.width=5, fig.height=10, fig.retina=3, echo=TRUE----------------------
S <- .shape_for_volcano(S=msqc1_8rep, peptides)

msqc1:::.figure_setup()

xyplot(-log(p.value, 10) ~ log2FC | instrument, data=S, group=Peptide.Sequence,
       panel = function(...){
         panel.abline(v=c(-1,1), col='lightgray')
         panel.abline(h=-log(0.05,10), col='lightgray')
         panel.xyplot(...)
       },
       ylab='-log10 of p-value',
       xlab='log2 fold change',
       layout=c(1,5),
       auto.key = list(space = "right", points = TRUE, lines = FALSE, cex=1))


## ----"Figure3a", echo=FALSE, fig.width=14, fig.height=9, fig.retina=3, warning=FALSE, message = FALSE----
msqc1:::.figure4(data=msqc1_dil, peptides=peptides)

## ----"Figure3b", echo = FALSE, fig.width = 14, fig.height = 5, fig.retina = 3, warning = FALSE, message = FALSE----
msqc1:::.figure5(data=msqc1_dil, data_reference = msqc1_8rep)

## -----------------------------------------------------------------------------
sessionInfo()

