# Code example from 'Pviz' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(tidy=FALSE)

## ----loading-package, message=FALSE-------------------------------------------
library(Pviz)

## ----ATrack-example, fig.height=1.5-------------------------------------------
at<-ATrack(start = c(250, 480), end = c(320, 520), id = c("Anno1", "Anno2"),
           showFeatureId = TRUE, fontcolor = "black", name = "Annotations")
plotTracks(at, from = 1, to = 600)

## ----DTrack-example, fig.height=4---------------------------------------------
library(pepDat)
data(restab_aggregate)
dt <- DTrack(data = restab_aggregate$group2, start = restab_aggregate$start,
             width=15, name="Freq", type = "l")
plotTracks(dt, from = 1, to = 850, type = "l")

## ----ProteinAxisTrack-basic, fig.height=1.1-----------------------------------
pat<-ProteinAxisTrack()
plotTracks(pat, from = 1, to = 850)

## ----ProteinAxisTrack-options, fig.height=1.1---------------------------------
pat<-ProteinAxisTrack(addNC = TRUE, littleTicks = TRUE)
plotTracks(pat, from = 1, to = 850)

## ----ProteinSequenceTrack-basic, fig.height=1.5-------------------------------
data(pep_hxb2)
hxb2_seq <- metadata(pep_hxb2)$sequence
st <- ProteinSequenceTrack(sequence = hxb2_seq, name = "env")
plotTracks(trackList = c(pat, st), from = 1, to = 40)

## ----ProteinSequenceTrack-unreadable, fig.height=1.5--------------------------
st <- ProteinSequenceTrack(sequence = hxb2_seq, name = "env", cex = 0.5)
plotTracks(trackList = c(pat, st), from = 1, to = 850)

## ----ProbeTrack-basic, fig.width=9, fig.height=4.5----------------------------
data(restab)
pt<-ProbeTrack(sequence = restab$peptide, intensity = restab$group2,
               probeStart = restab$start)
plotTracks(pt, from = 460, to = 560)

## ----ProbeTrack-wide-ranges, fig.width=9, fig.height=4.5----------------------
plotTracks(pt, legend = TRUE)

## ----CladeTrack, fig.width=9, fig.height=4------------------------------------
ctA <- CladeTrack(restab, clade = "A", type = "l")
ctM <- CladeTrack(restab, clade = "M", type = "l", legend = TRUE)
plotTracks(c(ctA, ctM), main = "Clades comparison", cex.main = 1.5)

## ----complex-plot, fig.width=9, fig.height=6----------------------------------
pt <- ProbeTrack(sequence = restab$peptide, intensity = restab$group2,
               probeStart = restab$start, cex=0, legend=TRUE)
plotTracks(trackList=c(pat, st, at, pt, ctM), from=460, to=560,
           type="l")

## ----plot-inter, fig.width=9, fig.height=4------------------------------------
plot_inter(restab_aggregate)

## ----plot-clade, fig.width=9, fig.height=4------------------------------------
plot_clade(restab, clade = c("A", "B", "C"), sequence = hxb2_seq,
           from = 100, to = 600)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

