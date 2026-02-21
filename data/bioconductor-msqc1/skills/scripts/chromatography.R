# Code example from 'chromatography' vignette. See references/ for full tutorial.

## ----echo = FALSE, message = FALSE--------------------------------------------
if (!require(msqc1)){
  ## try http:// if https:// URLs are not supported
  if (!requireNamespace("BiocManager", quietly=TRUE))
      install.packages("BiocManager")
  BiocManager::install("msqc1")
}

## -----------------------------------------------------------------------------
msqc1:::.normalize_rt

## -----------------------------------------------------------------------------
msqc1:::.reshape_rt

## -----------------------------------------------------------------------------
msqc1:::.plot_rt_8rep

msqc1:::.plot_rt_dil

## ----echo=TRUE, fig.width=8, fig.height=8, fig.retina=3, warning=FALSE, cache=FALSE, fig.asp=1, fig.cap=''----
S.training.8rep <- msqc1:::.reshape_rt(msqc1_8rep, peptides=peptides, cex=2)

## ----echo=TRUE, fig.width=15, fig.height=9, fig.retina=3, warning=FALSE, fig.cap='', cache=FALSE----
msqc1:::.plot_rt_8rep(msqc1_8rep, peptides=peptides, xlab='Replicate Id')

## ----echo=TRUE, fig.width=15, fig.height=9, fig.retina=3, warning=FALSE, cache=FALSE----
msqc1_8rep.norm <- msqc1:::.normalize_rt(msqc1_8rep, S.training.8rep, 
                                reference_instrument = 'Retention.Time.QTRAP')

msqc1:::.plot_rt_8rep(msqc1_8rep.norm,
             peptides=peptides,
             xlab='Replicate Id',
             ylab='Normalized Retention Time')

## ----echo=TRUE, fig.width=8, fig.height=8, fig.retina=3, warning=FALSE, cache=FALSE, fig.asp=1, fig.cap=''----
S.training.dil <- msqc1:::.reshape_rt(msqc1_dil, peptides=peptides, cex=2)

## ----echo=TRUE, fig.width=15, fig.height=9, fig.retina=3, warning=FALSE, cache=FALSE----
msqc1:::.plot_rt_dil(msqc1_dil, peptides, xlab='Replicate Id', ylab='Raw Retention Time')
msqc1_dil.norm <- msqc1:::.normalize_rt(msqc1_dil, 
                                        S.training.dil, 
                                        reference_instrument = 'Retention.Time.QTRAP')

msqc1:::.plot_rt_dil(msqc1_dil.norm, peptides=peptides, ylab="Normalized Retention Time")

## ----echo=FALSE, fig.width=10, fig.height=5, fig.retina=3, warning=FALSE, cache=FALSE----
op <- par(mfrow=c(1,2), mar=c(4,4,1,1))


plot(msqc1_8rep.norm$Retention.Time ~ msqc1_8rep$Retention.Time, 
     pch=as.integer(msqc1_8rep.norm$Peptide.Sequence),
     col=msqc1_8rep.norm$instrument,
     xlim=c(0,100))

legend("bottomright", 
       as.character(unique(msqc1_8rep.norm$instrument)),
       col= unique(msqc1_8rep.norm$instrument), 
       pch=as.integer(unique(msqc1_8rep.norm$instrument)))

plot(msqc1_dil.norm$Retention.Time ~ msqc1_dil$Retention.Time, 
     pch=as.integer(msqc1_dil.norm$Peptide.Sequence),
     col=msqc1_dil.norm$instrument,
     xlim=c(0,100))

legend("bottomright", 
       as.character(unique(msqc1_dil.norm$instrument)),
       col= unique(msqc1_dil.norm$instrument), 
       pch=as.integer(unique(msqc1_dil.norm$instrument)))


## ----cache=FALSE--------------------------------------------------------------
sessionInfo()

