# Code example from 'MSA2dist' vignette. See references/ for full tutorial.

## ----echo=FALSE, results='hide', warning=FALSE, message=FALSE-----------------
suppressPackageStartupMessages({
    library(MSA2dist)
    library(Biostrings)
    library(ape)
    library(dplyr)
    library(tidyr)
    library(ggplot2)
    })

## -----------------------------------------------------------------------------
# load MSA2dist
library(MSA2dist)
# load example data
data(hiv, package="MSA2dist")
data(AAMatrix, package="MSA2dist")
data(woodmouse, package="ape")

## -----------------------------------------------------------------------------
## define two cds sequences
cds1 <- Biostrings::DNAString("ATGCAACATTGC")
cds2 <- Biostrings::DNAString("ATG---CATTGC")
cds1.cds2.aln <- c(Biostrings::DNAStringSet(cds1),
    Biostrings::DNAStringSet(cds2))
## define names
names(cds1.cds2.aln) <- c("seq1", "seq2")
## convert into alignment
cds1.cds2.aln |> dnastring2aln()

## -----------------------------------------------------------------------------
## convert back into DNAStringSet
cds1.cds2.aln |> dnastring2aln() |> aln2dnastring()

## -----------------------------------------------------------------------------
## convert into alignment
cds1.cds2.aln |> dnastring2dnabin()

## -----------------------------------------------------------------------------
## convert back into DNAStringSet
cds1.cds2.aln |> dnastring2dnabin() |> dnabin2dnastring()
## use woodmouse data
woodmouse |> dnabin2dnastring()

## -----------------------------------------------------------------------------
## translate cds into aa
aa1.aa2.aln <- cds1.cds2.aln |> cds2aa()
## convert into alignment
aa1.aa2.aln |> aastring2aln()

## -----------------------------------------------------------------------------
## convert back into AAStringSet
aa1.aa2.aln |> aastring2aln() |> aln2aastring()

## -----------------------------------------------------------------------------
## convert into AAbin
aa1.aa2.aln |> aastring2aabin()

## -----------------------------------------------------------------------------
## convert back into AAStringSet
aa1.aa2.aln |> aastring2aabin() |> aabin2aastring()

## -----------------------------------------------------------------------------
## define two cds sequences
cds1 <- Biostrings::DNAString("ATGCAACATTGC")
cds2 <- Biostrings::DNAString("ATG---CATTGC")
cds1.cds2.aln <- c(Biostrings::DNAStringSet(cds1),
    Biostrings::DNAStringSet(cds2))
## define names
names(cds1.cds2.aln) <- c("seq1", "seq2")
## translate cds into aa
cds1.cds2.aln |> cds2aa()
aa1.aa2.aln <- cds1.cds2.aln |> cds2aa()

## -----------------------------------------------------------------------------
## translate cds into aa using frame = 2
## result is empty due to not multiple of three
cds1.cds2.aln |> cds2aa(frame=2)
## translate cds into aa using frame = 2 and shorten = TRUE
cds1.cds2.aln |> cds2aa(frame=2, shorten=TRUE)
## translate cds into aa using frame = 3 and shorten = TRUE
cds1.cds2.aln |> cds2aa(frame=3, shorten=TRUE)
## use woodmouse data
woodmouse |> dnabin2dnastring() |> cds2aa(shorten=TRUE)

## -----------------------------------------------------------------------------
## alternative genetic code
## use woodmouse data
woodmouse |> dnabin2dnastring() |> cds2aa(shorten=TRUE,
    genetic.code=Biostrings::getGeneticCode("2"))

## -----------------------------------------------------------------------------
## calculate pairwise AA distances based on Grantham's distance
aa.dist <- hiv |> cds2aa() |> aastring2dist(score=granthamMatrix())
## obtain distances
head(aa.dist$distSTRING)
## obtain pairwise sites used
head(aa.dist$sitesUsed)

## -----------------------------------------------------------------------------
## create and plot bionj tree
aa.dist.bionj <- ape::bionj(as.dist(aa.dist$distSTRING))
plot(aa.dist.bionj)

## -----------------------------------------------------------------------------
## use AAMatrix data
head(AAMatrix)
aa.dist.AAMatrix <- hiv |> cds2aa() |> aastring2dist(score=AAMatrix)
head(aa.dist.AAMatrix$distSTRING)

## -----------------------------------------------------------------------------
## use hiv data
dna.dist <- hiv |> dnastring2dist(model="K80")
## obtain distances
head(dna.dist$distSTRING)
## obtain pairwise sites used
head(dna.dist$sitesUsed)

## -----------------------------------------------------------------------------
## create and plot bionj tree
dna.dist.bionj <- ape::bionj(as.dist(dna.dist$distSTRING))

## -----------------------------------------------------------------------------
## creation of the association matrix:
association <- cbind(aa.dist.bionj$tip.label, aa.dist.bionj$tip.label)
## cophyloplot
ape::cophyloplot(aa.dist.bionj,
    dna.dist.bionj,
    assoc=association,
    length.line=4,
    space=28,
    gap=3,
    rotate=FALSE)

## -----------------------------------------------------------------------------
## use hiv data
hiv.dist.iupac <- head(hiv |> dnastring2dist(model="IUPAC"))
head(hiv.dist.iupac$distSTRING)
## run multi-threaded
system.time(hiv |> dnastring2dist(model="IUPAC", threads=1))
system.time(hiv |> dnastring2dist(model="IUPAC", threads=2))

## -----------------------------------------------------------------------------
## use woodmouse data
woodmouse.dist <- woodmouse |> dnabin2dnastring() |> dnastring2dist()
head(woodmouse.dist$distSTRING)

## -----------------------------------------------------------------------------
## use hiv data
## model Li
head(hiv |> dnastring2kaks(model="Li"))
## model NG86
head(hiv |> dnastring2kaks(model="NG86", threads=1))

## -----------------------------------------------------------------------------
## use hiv data
## model MYN
head(hiv |> dnastring2kaks(model="MYN"))
## model YN
head(hiv |> dnastring2kaks(model="YN", threads=1))

## -----------------------------------------------------------------------------
## use hiv data
idx <- list(c(2, 3), c(5,7,9))
## model MYN
head(hiv |> indices2kaks(idx, model="MYN"))
## model YN
head(hiv |> indices2kaks(idx, model="YN", threads=1))

## -----------------------------------------------------------------------------
## define two cds sequences
cds1 <- Biostrings::DNAString("ATGCAACATTGC")
cds2 <- Biostrings::DNAString("ATG---CATTGC")
cds1.cds2.aln <- c(Biostrings::DNAStringSet(cds1),
    Biostrings::DNAStringSet(cds2))
## convert into alignment
cds1.cds2.aln |> dnastring2codonmat()

## -----------------------------------------------------------------------------
## use frame 2 and shorten to circumvent multiple of three error
cds1 <- Biostrings::DNAString("-ATGCAACATTGC-")
cds2 <- Biostrings::DNAString("-ATG---CATTGC-")
cds1.cds2.aln <- c(Biostrings::DNAStringSet(cds1),
    Biostrings::DNAStringSet(cds2))
cds1.cds2.aln |> dnastring2codonmat(frame=2, shorten=TRUE)

## -----------------------------------------------------------------------------
## use hiv data
## calculate average behavior
hiv.xy <- hiv |> dnastring2codonmat() |> codonmat2xy()

## -----------------------------------------------------------------------------
print(hiv.xy |> dplyr::select(Codon,SynMean,NonSynMean,IndelMean) |>
    tidyr::gather(variable, values, -Codon) |>
    ggplot2::ggplot(aes(x=Codon, y=values)) + 
    ggplot2::geom_line(aes(colour=factor(variable))) + 
    ggplot2::geom_point(aes(colour=factor(variable))) + 
    ggplot2::ggtitle("HIV-1 sample 136 patient 1 from
        Sweden envelope glycoprotein (env) gene"))

## ----sessionInfo, echo=TRUE---------------------------------------------------
sessionInfo()

