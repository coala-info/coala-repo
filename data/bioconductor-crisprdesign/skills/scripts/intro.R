# Code example from 'intro' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install(version="devel")
# BiocManager::install("crisprDesign")

## ----message=FALSE, warning=FALSE,results='hide'------------------------------
library(crisprDesign)

## -----------------------------------------------------------------------------
library(crisprBase)
data(SpCas9, package="crisprBase")
SpCas9

## -----------------------------------------------------------------------------
prototypeSequence(SpCas9)

## -----------------------------------------------------------------------------
data(grListExample, package="crisprDesign")

## ----echo=TRUE, results='hide', warning=FALSE, message=FALSE------------------
gr <- queryTxObject(txObject=grListExample,
                    featureType="cds",
                    queryColumn="gene_symbol",
                    queryValue="IQSEC3")

## -----------------------------------------------------------------------------
gr <- gr[1]

## ----warning=FALSE, message=FALSE---------------------------------------------
library(BSgenome.Hsapiens.UCSC.hg38)
bsgenome <- BSgenome.Hsapiens.UCSC.hg38
guideSet <- findSpacers(gr,
                        bsgenome=bsgenome,
                        crisprNuclease=SpCas9)
guideSet

## -----------------------------------------------------------------------------
set.seed(10)
guideSet <- guideSet[sample(seq_along((guideSet)),20)]

## -----------------------------------------------------------------------------
spacers(guideSet)
protospacers(guideSet)
pams(guideSet)
head(pamSites(guideSet))
head(cutSites(guideSet))

## ----eval=TRUE, warning=FALSE, message=FALSE----------------------------------
guideSet <- addSequenceFeatures(guideSet)
head(guideSet)

## -----------------------------------------------------------------------------
library(Rbowtie)
fasta <- system.file(package="crisprDesign", "fasta/chr12.fa")
outdir <- tempdir()
Rbowtie::bowtie_build(fasta,
                      outdir=outdir,
                      force=TRUE,
                      prefix="chr12")
bowtie_index <- file.path(outdir, "chr12")

## ----results='hide', warning=FALSE--------------------------------------------
library(BSgenome.Hsapiens.UCSC.hg38)
bsgenome <- BSgenome.Hsapiens.UCSC.hg38

## ----results='hide', warning=FALSE--------------------------------------------
guideSet <- addSpacerAlignments(guideSet,
                                txObject=grListExample,
                                aligner_index=bowtie_index,
                                bsgenome=bsgenome,
                                n_mismatches=2)

## -----------------------------------------------------------------------------
guideSet

## -----------------------------------------------------------------------------
alignments(guideSet)

## ----eval=FALSE---------------------------------------------------------------
# onTargets(guideSet)
# offTargets(guideSet)

## ----eval=TRUE----------------------------------------------------------------
data(grRepeatsExample, package="crisprDesign")
guideSet <- removeRepeats(guideSet,
                          gr.repeats=grRepeatsExample)

## ----eval=TRUE, warning=FALSE, message=FALSE----------------------------------
guideSet <- addOffTargetScores(guideSet)
guideSet

## -----------------------------------------------------------------------------
head(alignments(guideSet))

## ----eval=TRUE, warning=FALSE, message=FALSE----------------------------------
guideSet <- addOnTargetScores(guideSet, methods="crisprater")
head(guideSet)

## ----eval=TRUE, warning=FALSE, message=FALSE, results='hide'------------------
guideSet <- addRestrictionEnzymes(guideSet)

## -----------------------------------------------------------------------------
head(enzymeAnnotation(guideSet))

## ----eval=TRUE,warning=FALSE, message=FALSE, results='hide'-------------------
guideSet <- addGeneAnnotation(guideSet,
                              txObject=grListExample)

## -----------------------------------------------------------------------------
geneAnnotation(guideSet)

## -----------------------------------------------------------------------------
data(tssObjectExample, package="crisprDesign")
guideSet <- addTssAnnotation(guideSet,
                             tssObject=tssObjectExample)
tssAnnotation(guideSet)

## ----eval=TRUE,warning=FALSE, message=FALSE-----------------------------------
vcf <- system.file("extdata",
                   file="common_snps_dbsnp151_example.vcf.gz",
                   package="crisprDesign")
guideSet <- addSNPAnnotation(guideSet, vcf=vcf)
snps(guideSet)

## ----eval=FALSE---------------------------------------------------------------
# guideSet <- guideSet[guideSet$percentGC>=20]
# guideSet <- guideSet[guideSet$percentGC<=80]
# guideSet <- guideSet[!guideSet$polyT]

## ----eval=TRUE----------------------------------------------------------------
# Creating an ordering index based on the CRISPRater score:
# Using the negative values to make sure higher scores are ranked first:
o <- order(-guideSet$score_crisprater) 
# Ordering the GuideSet:
guideSet <- guideSet[o]
head(guideSet)

## ----eval=TRUE----------------------------------------------------------------
o <- order(guideSet$n1, -guideSet$score_crisprater) 
# Ordering the GuideSet:
guideSet <- guideSet[o]
head(guideSet)

## ----eval=FALSE---------------------------------------------------------------
# tx_id <- "ENST00000538872"
# guideSet <- rankSpacers(guideSet,
#                         tx_id=tx_id)

## -----------------------------------------------------------------------------
data(BE4max, package="crisprBase")
BE4max

## -----------------------------------------------------------------------------
crisprBase::editingWeights(BE4max)["C2T",]

## -----------------------------------------------------------------------------
gr <- queryTxObject(txObject=grListExample,
                    featureType="cds",
                    queryColumn="gene_symbol",
                    queryValue="IQSEC3")
gs <- findSpacers(gr[1],
                  bsgenome=bsgenome,
                  crisprNuclease=BE4max)
gs <- gs[1:2]

## -----------------------------------------------------------------------------
txid <- "ENST00000538872"
txTable <- getTxInfoDataFrame(tx_id=txid,
                              txObject=grListExample,
                              bsgenome=bsgenome)
head(txTable)

## -----------------------------------------------------------------------------
editingWindow <- c(-20,-8)
gs <- addEditedAlleles(gs,
                       baseEditor=BE4max,
                       txTable=txTable,
                       editingWindow=editingWindow)

## -----------------------------------------------------------------------------
alleles <- editedAlleles(gs)[[1]]

## -----------------------------------------------------------------------------
metadata(alleles)

## -----------------------------------------------------------------------------
head(alleles)

## -----------------------------------------------------------------------------
head(gs)

## -----------------------------------------------------------------------------
data(CasRx, package="crisprBase")
CasRx

## -----------------------------------------------------------------------------
txid <- c("ENST00000538872","ENST00000382841")
mrnas <- getMrnaSequences(txid=txid,
                          bsgenome=bsgenome,
                          txObject=grListExample)
mrnas

## -----------------------------------------------------------------------------
gs <- findSpacers(mrnas[["ENST00000538872"]],
                  crisprNuclease=CasRx)
gs <- gs[1000:1100]
head(gs)

## -----------------------------------------------------------------------------
head(spacers(gs))
head(protospacers(gs))

## -----------------------------------------------------------------------------
gs <- addSpacerAlignments(gs,
                          aligner="biostrings",
                          txObject=grListExample,
                          n_mismatches=1,
                          custom_seq=mrnas)
tail(gs)

## -----------------------------------------------------------------------------
onTargets(gs["spacer_1095"])

## -----------------------------------------------------------------------------
n_cycles=8

## -----------------------------------------------------------------------------
data(guideSetExample, package="crisprDesign")
guideSetExample <- addOpsBarcodes(guideSetExample,
                                  n_cycles=n_cycles)
head(guideSetExample$opsBarcode)

## -----------------------------------------------------------------------------
barcodes <- guideSetExample$opsBarcode
dist <- getBarcodeDistanceMatrix(barcodes[1:5],
                                 barcodes[6:10],
                                 binnarize=FALSE)
print(dist)

## -----------------------------------------------------------------------------
dist <- getBarcodeDistanceMatrix(barcodes[1:5],
                                 barcodes[6:10],
                                 binnarize=TRUE,
                                 min_dist_edit=4)
print(dist)

## -----------------------------------------------------------------------------
library(GenomicRanges)
library(BSgenome.Hsapiens.UCSC.hg38)
library(crisprBase)
bsgenome <- BSgenome.Hsapiens.UCSC.hg38

## -----------------------------------------------------------------------------
gr <- GRanges(c("chr12"),
              IRanges(start=22224014, end=22225007))

## -----------------------------------------------------------------------------
pairs <- findSpacerPairs(gr, gr, bsgenome=bsgenome)

## -----------------------------------------------------------------------------
pairs

## -----------------------------------------------------------------------------
grnas1 <- first(pairs)
grnas2 <- second(pairs)
grnas1
grnas2

## -----------------------------------------------------------------------------
head(pamOrientation(pairs))

## -----------------------------------------------------------------------------
seqs <- c(seq1="AGGCGGAGGCCCGACCCGGGCGCGGGGCGGCGC",
          seq2="AGGCGGAGGCCCGACCCGGGCGCGGGAAAAAAAGGC")
gs <- findSpacers(seqs)
head(gs)

## -----------------------------------------------------------------------------
ontarget  <- "AAGACCCGGGCGCGGGGCGGGGG"
offtarget <- "TTGACCCGGGCGCGGGGCGGGGG"
gs <- findSpacers(ontarget)
gs <- addSpacerAlignments(gs,
                          aligner="biostrings",
                          n_mismatches=2,
                          custom_seq=offtarget)
head(alignments(gs))

## -----------------------------------------------------------------------------
gs <- guideSetExample
ntcs <- c(ntc_1="AGTGCTGTGTGTGTGATGCT", 
          ntc_2="GGGTGCCTTTTTACTCGATG")
gs <- addNtcs(gs, ntcs)
print(gs)

## -----------------------------------------------------------------------------
gs <- addSequenceFeatures(gs)
print(gs)

## -----------------------------------------------------------------------------
sessionInfo()

