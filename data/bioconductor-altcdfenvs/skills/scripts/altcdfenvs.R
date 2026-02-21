# Code example from 'altcdfenvs' vignette. See references/ for full tutorial.

### R code from vignette source 'altcdfenvs.Rnw'

###################################################
### code chunk number 1: altcdfenvs.Rnw:71-72
###################################################
library(altcdfenvs)


###################################################
### code chunk number 2: altcdfenvs.Rnw:91-94
###################################################
fasta.filename <- system.file("exampleData", "sample.fasta",
                              package="altcdfenvs")
con <- file(fasta.filename, open="r")


###################################################
### code chunk number 3: altcdfenvs.Rnw:99-105
###################################################
fasta.seq <- read.FASTA.entry(con)
while(! is.null(fasta.seq$header)) {
  print(fasta.seq)
  fasta.seq <- read.FASTA.entry(con)
}
close(con)


###################################################
### code chunk number 4: altcdfenvs.Rnw:127-136
###################################################
## first, count the number of FASTA entries in our file
con <- file(fasta.filename, open="r")
n <- countskip.FASTA.entries(con)
close(con)

## read all the entries
con <- file(fasta.filename, open="r")
my.entries <- read.n.FASTA.entries.split(con, n)
close(con)


###################################################
### code chunk number 5: altcdfenvs.Rnw:149-151
###################################################
library(hgu133aprobe)



###################################################
### code chunk number 6: altcdfenvs.Rnw:156-164
###################################################

targets <- my.entries$sequences
names(targets) <-  sub(">.+\\|(Hs\\#|NM_)([^[:blank:]\\|]+).+", 
                       "\\1\\2", my.entries$headers)

m <- matchAffyProbes(hgu133aprobe, targets, "HG-U133A")




###################################################
### code chunk number 7: altcdfenvs.Rnw:175-176
###################################################
hg <- toHypergraph(m)


###################################################
### code chunk number 8: altcdfenvs.Rnw:182-183
###################################################
gn <- toGraphNEL(hg)


###################################################
### code chunk number 9: altcdfenvs.Rnw:190-194
###################################################
targetNodes <- new.env(hash=TRUE, parent=emptyenv())
for (i in seq(along=targets)) {
  targetNodes[[names(targets)[i]]] <- i
}


###################################################
### code chunk number 10: plotGraph
###################################################
library(Rgraphviz)
tShapes <- rep("ellipse", length=length(targets))
names(tShapes) <- names(targets)
tColors <- rep("ivory", length=length(targets))
names(tColors) <- names(targets)

nAttrs <- list(shape = tShapes, fillcolor = tColors)
gAttrs <- list(node = list(shape = "rectangle", fixedsize = FALSE))

plot(gn, "neato",
     nodeAttrs = nAttrs,
     attrs = gAttrs)



###################################################
### code chunk number 11: buildCdfEnv
###################################################
alt.cdf <- 
  buildCdfEnv.biostrings(m, nrow.chip = 712, ncol.chip = 712)



###################################################
### code chunk number 12: geneSymbolsSLAMF
###################################################
geneSymbols <- c("SLAMF1", "SLAMF3", "SLAMF6", "SLAMF7", "SLAMF8", "SLAMF9")


###################################################
### code chunk number 13: getSeq
###################################################
getSeq <- function(name) {
  seq <- getSequence(id=name, type="hgnc_symbol", 
                     seqType="cdna", mart = mart)

  targets <- seq$cdna
  if (is.null(targets))
    return(character(0))
  names(targets) <- paste(seq$hgnc_symbol, 1:nrow(seq), sep="-")
  return(targets)
}


###################################################
### code chunk number 14: loadTargetsSLAMF
###################################################
load(system.file("exampleData", "slamf_targets.RData",
                  package="altcdfenvs"))


###################################################
### code chunk number 15: altcdfenvs.Rnw:322-323
###################################################
m <- matchAffyProbes(hgu133aprobe, targets, "HG-U133A")


###################################################
### code chunk number 16: SLAMF
###################################################

hg <- toHypergraph(m)


gn <- toGraphNEL(hg)

library(RColorBrewer)
col <- brewer.pal(length(geneSymbols)+1, "Set1")
tColors <- rep(col[length(col)], length=numNodes(gn))
names(tColors) <- nodes(gn)
for (col_i in 1:(length(col)-1)) {
  node_i <- grep(paste("^", geneSymbols[col_i], 
                       "-", sep=""),
                       names(tColors)) 
  tColors[node_i] <- col[col_i]
}


nAttrs <- list(fillcolor = tColors)

plot(gn, "twopi", nodeAttrs=nAttrs)


###################################################
### code chunk number 17: altcdfenvs.Rnw:362-371
###################################################
library("hgu133a.db")
affyTab <- toTable(hgu133aSYMBOL)
slamf_i <- grep("^SLAMF", affyTab$symbol)
pset_id <- affyTab$probe_id[slamf_i]

library("hgu133acdf")
countProbes <- lapply(pset_id, function(x) nrow(hgu133acdf[[x]]))
names(countProbes) <- affyTab$symbol[slamf_i]
countProbes


