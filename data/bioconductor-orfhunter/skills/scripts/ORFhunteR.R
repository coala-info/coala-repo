# Code example from 'ORFhunteR' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
trans  <- system.file("extdata", "Set.trans_sequences.fasta",
                      package = "ORFhunteR")

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# BiocManager::install("ORFhunteR")

## ----echo=T, results = 'hide'-------------------------------------------------
library('ORFhunteR')

## -----------------------------------------------------------------------------
seq.set <- loadTrExper(tr = trans)

## -----------------------------------------------------------------------------
x <- "AAAATGGCTGCGTAATGCAAAATGGCTGCGAATGCAAAATGGCTGCGAATGCCGGCACGTTGCTACGT"
orf <- findORFs(x, codStart="ATG")

## ----echo=FALSE, out.width='75%', fig.align="center"--------------------------
knitr::include_graphics('./Figure_1.jpg')

## -----------------------------------------------------------------------------
feats <- vectorizeORFs(x=DNAStringSet(x="ATGGGCCTCA"))

## ----eval = FALSE-------------------------------------------------------------
# ## The files with sequences can be downloaded from SST Center server at www.sstcenter.com/download/ORFhunteR
# 
# fileORFLncRNAs <- "http://www.sstcenter.com/download/ORFhunteR/NCBI_RefSeq_release_109_GRCh38.p12_ORF_candidates_sequences_lncRNAs.fasta.gz"
# ORFLncRNAs <- loadTrExper(tr = fileORFLncRNAs)
# fileORFmRNAs <- "http://www.sstcenter.com/download/ORFhunteR/NCBI_RefSeq_release_109_GRCh38.p12_ORFs_true_sequences_mRNAs.fasta.gz"
# ORFmRNAs <- loadTrExper(tr = fileORFmRNAs)
# ## Make the train dataset from N pseudo- and N real ORFs.
# N <- 1000
# ORFLncRNAs <- ORFLncRNAs[1:N]
# ORFmRNAs <- ORFmRNAs[1:N]
# ## Calculate the classification model for the open reading frame.
# clt <- classifyORFsCandidates(ORFLncRNAs = ORFLncRNAs,
#                               ORFmRNAs = ORFmRNAs,
#                               pLearn = 0.75,
#                               nTrees = 500,
#                               modelRF = NULL,
#                               workDir = NULL,
#                               showAccuracy = TRUE)

## -----------------------------------------------------------------------------
model <- "http://www.sstcenter.com/download/ORFhunteR/classRFmodel_1.rds"
ORFs <- predictORF(tr = trans,
                   model= model,
                   prThr = 0)

## -----------------------------------------------------------------------------
head(ORFs)

## ----echo=FALSE, out.width='75%', fig.align="center"--------------------------
knitr::include_graphics('./Figure_2.jpg')

## ----echo=FALSE, out.width='75%', fig.align="center"--------------------------
knitr::include_graphics('./Figure_3.jpg')

## -----------------------------------------------------------------------------
orfs_path <- system.file("extdata",
                         "Set.trans_ORFs.coordinates.txt",
                         package="ORFhunteR")
tr_path <- system.file("extdata",
                       "Set.trans_sequences.fasta",
                       package="ORFhunteR")
seq_orfs <- getSeqORFs(orfs = orfs_path,
                       tr = tr_path,
                      genome="BSgenome.Hsapiens.UCSC.hg38",
                       workDir=NULL)

## -----------------------------------------------------------------------------
head(seq_orfs)

## -----------------------------------------------------------------------------
orfs_path <- system.file("extdata",
                         "Set.trans_ORFs.coordinates.txt",
                         package="ORFhunteR")
gtf_path <- system.file("extdata",
                        "Set.trans_sequences.gtf",
                        package="ORFhunteR")
ptcs <- findPTCs(orfs = orfs_path,
                 gtf = gtf_path, 
                 workDir = NULL)

## -----------------------------------------------------------------------------
head(ptcs)

## -----------------------------------------------------------------------------
seq_orf_path <- system.file("extdata",
                            "Set.trans_ORFs.sequences.fasta",
                            package="ORFhunteR")
prot_seqs <- translateORFs(seqORFs=seq_orf_path)

## -----------------------------------------------------------------------------
head(prot_seqs)

## -----------------------------------------------------------------------------
orfs_path <- system.file("extdata",
                         "Set.trans_ORFs.coordinates.txt",
                         package="ORFhunteR")
tr_path <- system.file("extdata",
                       "Set.trans_sequences.fasta",
                       package="ORFhunteR")
gtf_path <- system.file("extdata",
                        "Set.trans_sequences.gtf",
                        package="ORFhunteR")
prts_path <- system.file("extdata",
                         "Set.trans_proteins.sequences.fasta",
                         package="ORFhunteR")
anno_orfs <- annotateORFs(orfs = orfs_path,
                          tr = tr_path,
                          gtf = gtf_path,
                          prts = prts_path,
                          workDir = NULL)

## -----------------------------------------------------------------------------
head(anno_orfs)

