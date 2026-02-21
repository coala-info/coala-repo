# Code example from 'simulate-flycodes' vignette. See references/ for full tutorial.

## ----message=FALSE, warning=FALSE---------------------------------------------
library(NestLink)
stopifnot(require(specL))

## -----------------------------------------------------------------------------
aa_pool_x8 <- c(rep('A', 12), rep('S', 0), rep('T', 12), rep('N', 12),
    rep('Q', 12), rep('D', 8),  rep('E', 0), rep('V', 12), rep('L', 0),
    rep('F', 0), rep('Y', 8), rep('W', 0), rep('G', 12), rep('P', 12))

aa_pool_1_2_9_10 <- c(rep('A', 8), rep('S', 7), rep('T', 7), rep('N', 6),
    rep('Q', 6), rep('D', 8), rep('E', 8), rep('V', 9), rep('L', 6),
    rep('F', 5), rep('Y', 9), rep('W', 6),  rep('G', 15), rep('P', 0))

aa_pool_3_8 <- c(rep('A', 5), rep('S', 4), rep('T', 5), rep('N', 2),
    rep('Q', 2), rep('D', 8), rep('E', 8), rep('V', 7), rep('L', 5),
    rep('F', 4), rep('Y', 6), rep('W', 4),  rep('G', 12), rep('P', 28))


## -----------------------------------------------------------------------------
table(aa_pool_x8)
length(aa_pool_x8)
table(aa_pool_1_2_9_10)
length(aa_pool_1_2_9_10)
table(aa_pool_3_8)
length(aa_pool_3_8)

## -----------------------------------------------------------------------------
replicate(10, compose_GPGx8cTerm(pool=aa_pool_x8))

## -----------------------------------------------------------------------------
compose_GPx10R(aa_pool_1_2_9_10, aa_pool_3_8)

## -----------------------------------------------------------------------------
set.seed(2)
(sample.size <- 3E+04)
peptides.GPGx8cTerm <- replicate(sample.size, compose_GPGx8cTerm(pool=aa_pool_x8))
peptides.GPx10R <- replicate(sample.size, compose_GPx10R(aa_pool_1_2_9_10, aa_pool_3_8))
# write.table(peptides.GPGx8cTerm, file='/tmp/pp.txt')

## -----------------------------------------------------------------------------
library(protViz)
(smp.peptide <- compose_GPGx8cTerm(aa_pool_x8))
parentIonMass(smp.peptide)

pim.GPGx8cTerm <- unlist(lapply(peptides.GPGx8cTerm, function(x){parentIonMass(x)}))
pim.GPx10R <- unlist(lapply(peptides.GPx10R, function(x){parentIonMass(x)}))
pim.iRT <-  unlist(lapply(as.character(iRTpeptides$peptide), function(x){parentIonMass(x)}))


## -----------------------------------------------------------------------------
(pim.min <- min(pim.GPGx8cTerm, pim.GPx10R))
(pim.max <- max(pim.GPGx8cTerm, pim.GPx10R))

(pim.breaks <- seq(round(pim.min - 1) , round(pim.max + 1) , length=75))

hist(pim.GPGx8cTerm, breaks=pim.breaks, probability = TRUE, 
     col='#1111AAAA', xlab='peptide mass [Dalton]', ylim=c(0, 0.006))
hist(pim.GPx10R, breaks=pim.breaks,
     probability = TRUE, add=TRUE, col='#11AA1188')
abline(v=pim.iRT, col='grey')
legend("topleft", c('GPGx8cTerm', 'GPx10R', 'iRT'), 
     fill=c('#1111AAAA', '#11AA1133', 'grey'))

## ----fig.retina=1-------------------------------------------------------------
library(specL)
ssrc <- sapply(peptideStd, function(x){ssrc(x$peptideSequence)})
rt <- unlist(lapply(peptideStd, function(x){x$rt}))
plot(ssrc, rt); abline(ssrc.lm <- lm(rt ~ ssrc), col='red'); 
legend("topleft", paste("spearman", round(cor(ssrc, rt, method='spearman'),2)))

## ----fig.width=5, fig.height=5------------------------------------------------
hyd.GPGx8cTerm <- ssrc(peptides.GPGx8cTerm)
hyd.GPx10R <- ssrc(peptides.GPx10R)
hyd.iRT <- ssrc(as.character(iRTpeptides$peptide))

(hyd.min <- min(hyd.GPGx8cTerm, hyd.GPx10R))
(hyd.max <- max(hyd.GPGx8cTerm, hyd.GPx10R))
hyd.breaks <- seq(round(hyd.min - 1) , round(hyd.max + 1) , length=75)

## ----fig.retina=1-------------------------------------------------------------
hist(hyd.GPGx8cTerm, breaks = hyd.breaks, probability = TRUE, 
     col='#1111AAAA', xlab='hydrophobicity', 
     ylim=c(0, 0.06),
     main='Histogram')
hist(hyd.GPx10R, breaks = hyd.breaks, probability = TRUE, add=TRUE, col='#11AA1188')
  abline(v=hyd.iRT, col='grey')
legend("topleft", c('GPGx8cTerm', 'GPx10R', 'iRT'),  fill=c('#1111AAAA', '#11AA1133', 'grey'))

## -----------------------------------------------------------------------------
round(table(aa_pool_x8)/length(aa_pool_x8), 2)

## -----------------------------------------------------------------------------
peptide2aa <- function(seq, from=4, to=4+8){
  unlist(lapply(seq, function(x){strsplit(substr(x, from, to), '')}))
}
peptides.GPGx8cTerm.aa <- peptide2aa(peptides.GPGx8cTerm)
round(table(peptides.GPGx8cTerm.aa)/length(peptides.GPGx8cTerm.aa), 2)

## -----------------------------------------------------------------------------
peptides.GPx10R.aa <- peptide2aa(peptides.GPx10R, from=3, to=12)
round(table(peptides.GPx10R.aa)/length(peptides.GPx10R.aa), 2)

## -----------------------------------------------------------------------------
sample.size 

length(grep('^GP(.*)GP(.*)R$', peptides.GPGx8cTerm))

length(grep('^GP(.*)GP(.*)R$', peptides.GPx10R))

## -----------------------------------------------------------------------------
sample.size 

table(table(tt<-unlist(lapply(peptides.GPGx8cTerm, 
  function(x){paste(sort(unlist(strsplit(x, ''))), collapse='')}))))
# write.table(tt, file='GPGx8cTerm.txt')
table(table(unlist(lapply(peptides.GPx10R, 
  function(x){paste(sort(unlist(strsplit(x, ''))), collapse='')}))))

## ----fig.width=10, fig.height=10, fig.retina=1, echo=TRUE---------------------
par(mfrow=c(2, 2))
h <- NestLink:::.plot_in_silico_LCMS_map(peptides.GPGx8cTerm, main='GPGx8cTerm')
h <- NestLink:::.plot_in_silico_LCMS_map(peptides.GPx10R, main='GPx10R')

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

