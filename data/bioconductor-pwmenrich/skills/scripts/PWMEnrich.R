# Code example from 'PWMEnrich' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(
echo=TRUE,eval=TRUE,cache=FALSE,tidy=FALSE
)

## ----include=FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(
tidy=FALSE,dev='pdf',
message=FALSE, warning=FALSE
)

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex()

## ----simple,echo=TRUE------------------------------------------------------
library(PWMEnrich)
library(PWMEnrich.Dmelanogaster.background)

# load the pre-compiled lognormal background
data(PWMLogn.dm3.MotifDb.Dmel)

# load the stripe2 sequences from a FASTA file for motif enrichment
sequence = readDNAStringSet(system.file(package="PWMEnrich", 
  dir="extdata", file="stripe2.fa"))
sequence  

# perform motif enrichment!
res = motifEnrichment(sequence, PWMLogn.dm3.MotifDb.Dmel)

report = sequenceReport(res, 1)
report

# plot the motif with P-value < 0.05
plot(report[report$p.value < 0.05], fontsize=7, id.fontsize=6)

## ----stripe2visual,echo=TRUE,fig.width=4,fig.height=4,fig.align='center'----

# extract the 3 PWMs for the TFs we are interested in
ids = c("bcd_FlyReg_FBgn0000166", 
        "gt_FlyReg_FBgn0001150", 
        "Kr")
sel.pwms = PWMLogn.dm3.MotifDb.Dmel$pwms[ids]
names(sel.pwms) = c("bcd", "gt", "Kr")

# scan and get the raw scores
scores = motifScores(sequence, sel.pwms, raw.scores=TRUE)

# raw scores for the first (and only) input sequence
dim(scores[[1]])
head(scores[[1]])

# score starting at position 1 of forward strand
scores[[1]][1, "bcd"]
# score for the reverse complement of the motif, starting at the same position
scores[[1]][485, "bcd"]

# plot
plotMotifScores(scores, cols=c("green", "red", "blue"))

## ----motifEcdf,echo=TRUE,fig.width=4,fig.height=4,fig.align='center'-------
library(BSgenome.Dmelanogaster.UCSC.dm3)

# empirical distribution for the bcd motif
bcd.ecdf = motifEcdf(sel.pwms$bcd, Dmelanogaster, quick=TRUE)[[1]]

# find the score that is equivalent to the P-value of 1e-3
threshold.1e3 = log2(quantile(bcd.ecdf, 1 - 1e-3))
threshold.1e3 

# replot only the bcd motif hits with the P-value cutoff of 1e-3 (0.001)
plotMotifScores(scores, cols="green", sel.motifs="bcd", cutoff=threshold.1e3)

# Convert scores into P-values
pvals = 1 - bcd.ecdf(scores[[1]][,"bcd"])
head(pvals)

## ----tinman,echo=TRUE------------------------------------------------------
library(PWMEnrich.Dmelanogaster.background)

# load the pre-compiled lognormal background
data(PWMLogn.dm3.MotifDb.Dmel)

sequences = readDNAStringSet(system.file(package="PWMEnrich", 
  dir="extdata", file="tinman-early-top20.fa"))
 
res = motifEnrichment(sequences, PWMLogn.dm3.MotifDb.Dmel)

report = groupReport(res)
report

plot(report[1:10], fontsize=7, id.fontsize=5)

## ----tinman-alt,echo=TRUE--------------------------------------------------
report.top = groupReport(res, by.top.motifs=TRUE)

report.top

## ----tinman2,echo=TRUE-----------------------------------------------------
res

# raw scores
res$sequence.nobg[1:5, 1:2]

# P-values
res$sequence.bg[1:5, 1:2]

## ----parallel,echo=TRUE----------------------------------------------------
registerCoresPWMEnrich(4)

## ----parallel-stop,echo=TRUE-----------------------------------------------
registerCoresPWMEnrich(NULL)

## ----bigmem,echo=TRUE------------------------------------------------------
useBigMemoryPWMEnrich(TRUE)

## ----bigmemoff,echo=TRUE---------------------------------------------------
useBigMemoryPWMEnrich(FALSE)

## ----readmotifs,echo=TRUE--------------------------------------------------
library(PWMEnrich.Dmelanogaster.background)

motifs.denovo = readMotifs(system.file(package="PWMEnrich", 
  dir="extdata", file="example.transfac"), remove.acc=TRUE)
  
motifs.denovo  

# convert count matrices into PWMs
genomic.acgt = getBackgroundFrequencies("dm3")
pwms.denovo = toPWM(motifs.denovo, prior=genomic.acgt)

bg.denovo = makeBackground(pwms.denovo, organism="dm3", type="logn", quick=TRUE)

# use new motifs for motif enrichment
res.denovo = motifEnrichment(sequences[1:5], bg.denovo)
groupReport(res.denovo)

## ----bg-investigate,echo=TRUE----------------------------------------------
bg.denovo
bg.denovo$bg.mean

## ----custombg,echo=TRUE----------------------------------------------------
library(PWMEnrich.Dmelanogaster.background)
data(dm3.upstream2000)

# make a lognormal background for the two motifs using only first 20 promoters
bg.seq = dm3.upstream2000[1:20]

# the sequences are split into 100bp chunks and fitted
bg.custom = makeBackground(pwms.denovo, bg.seq=bg.seq, type="logn", bg.len=100,
	bg.source="20 promoters split into 100bp chunks")

bg.custom

## ----sessionInfo,echo=FALSE,results='asis'---------------------------------
toLatex(sessionInfo())

