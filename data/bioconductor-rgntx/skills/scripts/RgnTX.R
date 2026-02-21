# Code example from 'RgnTX' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
library(knitr)
opts_chunk$set(concordance=FALSE)
set.seed(12345677)

## ----echo=FALSE, warning=FALSE, message=FALSE---------------------------------
library(RgnTX)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)

## ----Fig1, fig.cap = "The genome space is linear. The figure shows four genomic features in the genome.", echo=FALSE, out.width='.60\\linewidth'----
knitr::include_graphics("figures/section2.1.png")

## ----Fig2, fig.cap = "The transcriptome space is heterogeneous. It is usually unclear which specific isoform transcript is associated with the transcriptome element because it overlaps with multiple isoforms when mapped to the genome, which is often the real scenario in biological research.", echo=FALSE, out.width='.60\\linewidth'----
knitr::include_graphics("figures/section2.2.png")

## ----Fig3, fig.cap = "Permutation space for each feature is distinct. Each feature will be permutated only within the set of isoform transcripts it is associated with.", echo=FALSE, out.width='.60\\linewidth'----
knitr::include_graphics("figures/section2.3.png")

## ----Fig4, fig.cap = "Overlapping counts between random region sets in different permutation spaces. Box boundaries represent the 25th and 75th percentiles; center line represents the median.", echo=FALSE, out.width='.80\\linewidth'----
knitr::include_graphics("figures/section2.4.png")

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("devtools", quietly = TRUE))
#     install.packages("devtools")
# 
# devtools::install_github("yue-wang-biomath/RgnTX", build_vignettes = TRUE)

## ----eval = FALSE-------------------------------------------------------------
# if (!require("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("RgnTX")

## ----message=FALSE, warning=FALSE---------------------------------------------
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

set.seed(12345677)
example.list <- randomizeTx(txdb, random_num = 10, random_length = 200)
example.list

## ----message=FALSE, warning=FALSE---------------------------------------------
example.gr <- GRangesList2GRanges(example.list)
example.gr
example.list <- GRanges2GRangesList(example.gr)

## ----warning=FALSE, message=FALSE---------------------------------------------
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene 
type <- "mature"
trans.ids <- c("170", "782", "974", "1364", "1387")

## ----warning=FALSE, message=FALSE---------------------------------------------
set.seed(12345677)
randomResults <- randomizeTx(txdb, trans_ids = trans.ids, random_num = 10,
                             random_length = 100)

## ----warning=FALSE, message=FALSE---------------------------------------------
randomResults 

## ----warning=FALSE, message=FALSE---------------------------------------------
width(randomResults)

## ----warning=FALSE, message=FALSE---------------------------------------------
trans.ids <- c("170", "782", "974", "1364", "1387")
exons.tx0 <- exonsBy(txdb)
regions.A <- exons.tx0[trans.ids]
regions.A

## ----warning=FALSE, message=FALSE---------------------------------------------
set.seed(12345677)
random.regions.A <- randomizeTransByOrder(regions_A = regions.A, 
random_length = 100)
width(regions.A)
width(random.regions.A)

## ----Fig5, fig.cap = "Features without isoform ambiguity.", echo=FALSE, out.width='.80\\linewidth'----
knitr::include_graphics("figures/section4.1.png")

## ----Fig6, fig.cap = "Features with isoform ambiguity.", echo=FALSE, out.width='.80\\linewidth'----
knitr::include_graphics("figures/section4.2.png")

## ----message=FALSE, warning=FALSE---------------------------------------------
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
trans.ids<- c("170", "782", "974", "1364", "1387")
RS1 <-  randomizeTx(txdb, trans.ids, random_num = 100, random_length = 100)

## ----warning=FALSE, message=FALSE---------------------------------------------
randomResults <- randomizeFeaturesTx(RS1, txdb, type = "mature")

## ----warning=FALSE, message=FALSE---------------------------------------------
randomResults <- randomizeFeaturesTx(RS1, txdb, type = "CDS")

## ----warning=FALSE, message=FALSE---------------------------------------------
randomResults <- randomizeFeaturesTx(RS1, txdb, N = 5)

## ----message=FALSE, warning=FALSE---------------------------------------------
file <- system.file(package="RgnTX", "extdata", "m6A_sites_data.rds")
m6A_sites_data <- readRDS(file)
m6A_sites_data[1:5]

## ----message=FALSE, warning=FALSE---------------------------------------------
randomResults <- randomizeFeaturesTxIA(RS = m6A_sites_data[1:5], 
                                       txdb, type = "mature", N = 1)
length(randomResults)

## ----eval = FALSE-------------------------------------------------------------
# set.seed(12345677)
# library(TxDb.Hsapiens.UCSC.hg19.knownGene)
# txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
# exons.tx0 <- exonsBy(txdb)
# trans.ids <- sample(names(exons.tx0), 50)
# 
# A <- randomizeTx(txdb, trans.ids, random_num = 100, random_length = 100)
# B <- c(randomizeTx(txdb, trans.ids, random_num = 50, random_length = 100),
#        A[1:50])
# 
# permTestTx_results <- permTestTx(RS1 = A,
#                                  RS2 = B,
#                                  txdb = txdb,
#                                  type = "mature",
#                                  ntimes = 50,
#                                  ev_function_1 = overlapCountsTx,
#                                  ev_function_2 = overlapCountsTx)

## ----echo = FALSE-------------------------------------------------------------
file <- system.file(package="RgnTX", "extdata", "permTestTx_results2.rds")
permTestTx_results <- readRDS(file)

## ----warning=FALSE, message=FALSE---------------------------------------------
names(permTestTx_results)

## ----Fig7, fig.cap = "Association between two region sets.", warning=FALSE, message=FALSE----
p1 <- plotPermResults(permTestTx_results, binwidth = 1)
p1

## ----Fig8, fig.cap = "Overlap counting ways of two kinds of features with the customPick regions.", echo=FALSE----
knitr::include_graphics("figures/section5.2.png")

## ----warning=FALSE, message=FALSE---------------------------------------------
getCDS = function(trans_ids, txdb,...){
  cds.tx0 <- cdsBy(txdb, use.names=FALSE)
  cds.names <- as.character(intersect(names(cds.tx0), trans_ids))
  cds = cds.tx0[cds.names]
  return(cds)
}

## ----eval = FALSE-------------------------------------------------------------
# set.seed(12345677)
# txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
# RS1 <- randomizeTx(txdb, "all", random_num = 100, random_length = 200,
#                    type = "CDS")
# 
# permTestTx_results <- permTestTx_customPick(RS1 = RS1,
#                                             txdb = txdb,
#                                             customPick_function = getCDS,
#                                             ntimes = 50,
#                                             ev_function_1 = overlapCountsTx,
#                                             ev_function_2 = overlapCountsTx)
# p1 <- plotPermResults(permTestTx_results, binwidth = 1)
# p1

## ----Fig9, echo = FALSE, fig.cap = " Association between some features with CDS regions.", warning=FALSE, message=FALSE----
file <- system.file(package="RgnTX", "extdata", "permTestTx_results3.rds")
permTestTx_results <- readRDS(file)
p1 <- plotPermResults(permTestTx_results, binwidth = 1)
p1

## ----eval = FALSE-------------------------------------------------------------
# set.seed(12345677)
# txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
# file <- system.file(package="RgnTX", "extdata", "m6A_sites_data.rds")
# m6A_sites_data <- readRDS(file)
# RS1 <- m6A_sites_data[1:500]
# 
# permTestTx_results <- permTestTxIA_customPick(RS1 = RS1,
#                                        txdb = txdb,
#                                        customPick_function = getStopCodon,
#                                        ntimes = 50,
#                                        ev_function_1 = overlapCountsTxIA,
#                                        ev_function_2 = overlapCountsTx)
# p_a <- plotPermResults(permTestTx_results, binwidth = 1)
# p_a

## ----Fig10, echo = FALSE, fig.cap = " Association between N6-Methyladenosine (500 sites) and stop codon regions.", warning=FALSE, message=FALSE----
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
file <- system.file(package="RgnTX", "extdata", "permTestTx_results.rds")
permTestTx_results <- readRDS(file)
p_a <- plotPermResults(permTestTx_results, binwidth = 1)
p_a

## ----eval = FALSE-------------------------------------------------------------
# set.seed(12345677)
# permTestTx_results <- permTestTxIA_customPick(RS1 = m6A_sites_data,
#                                        txdb = txdb,
#                                        customPick_function = getStopCodon,
#                                        ntimes = 50)
# p_b <- plotPermResults(permTestTx_results)
# p_b

## ----Fig11, fig.cap = " Association between N6-Methyladenosine and stop codon regions.", echo=FALSE----
knitr::include_graphics("figures/section5.5.png")

## ----warning=FALSE, message=FALSE---------------------------------------------
set.seed(12345677)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
trans.ids1<- c("170")
RS1 <- randomizeTx(txdb = txdb, trans_ids = trans.ids1,
                   random_num = 20, random_length = 100)
RS2 <- randomizeTx(txdb = txdb, trans_ids = trans.ids1,
                   random_num = 20, random_length = 100)
trans.ids2 <-  c("170", "782", "974", "1364", "1387")
RSL <- randomizeTx(txdb = txdb, trans_ids = trans.ids2,
                   random_num = 20, random_length = 100, N = 50)

## ----Fig12, fig.cap = "Association between two region sets picked from the same transcript .", warning=FALSE, message=FALSE----
permTestTx_results <- permTestTx_customAll(RSL = RSL, RS1 = RS1, RS2 = RS2)
p_3 <- plotPermResults(permTestTx_results)
p_3

## ----eval=FALSE---------------------------------------------------------------
# set.seed(12345677)
# txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
# exons.tx0 <- exonsBy(txdb)
# trans.ids <- sample(names(exons.tx0), 50)
# 
# A <- randomizeTx(txdb, trans.ids, random_num = 100, random_length = 100)
# B <- c(randomizeTx(txdb, trans.ids, random_num = 50, random_length = 100),
#        A[1:50])
# 
# permTestTx_results <- permTestTx(RS1 = A,
#                                  RS2 = B,
#                                  txdb = txdb,
#                                  type = "mature",
#                                  ntimes = 50,
#                                  ev_function_1 = overlapCountsTx,
#                                  ev_function_2 = overlapCountsTx)
# 
# p_a <- plotPermResults(permTestTx_results, binwidth = 1)
# 
# p_b <- plotPermResults(permTestTx_results, test_type = "two-sided")
# 
# p_c <- plotPermResults(permTestTx_results, alpha = 0.025)
# 
# p_d <- plotPermResults(permTestTx_results, alpha = 0.1)
# 
# set.seed(12345677)
# permTestTx_results_e <- permTestTx( RS1 = A,
#                                     RS2 = B,
#                                     txdb = txdb,
#                                     type = "mature",
#                                     ntimes = 50,
#                                     ev_function_1 = overlapWidthTx,
#                                     ev_function_2 = overlapWidthTx)
# p_e <- plotPermResults(permTestTx_results_e, binwidth = 150)
# p_e
# 
# set.seed(12345677)
# permTestTx_results_f <- permTestTx( RS1 = A,
#                                     RS2 = B,
#                                     txdb = txdb,
#                                     type = "mature",
#                                     ntimes = 50,
#                                     ev_function_1 = distanceTx,
#                                     ev_function_2 = distanceTx, beta = 0.3)
# p_f <- plotPermResults(permTestTx_results_f)
# p_f
# 
# set.seed(12345677)
# permTestTx_results_g <- permTestTx(RS1 = A,
#                                  RS2 = B,
#                                  txdb = txdb,
#                                  type = "mature",
#                                  ntimes = 500,
#                                  ev_function_1 = overlapCountsTx,
#                                  ev_function_2 = overlapCountsTx)
# 
# p_g <- plotPermResults(permTestTx_results_g, binwidth = 1)
# p_g
# 
# set.seed(12345677)
# permTestTx_results_h <- permTestTx(RS1 = A,
#                                  RS2 = B,
#                                  txdb = txdb,
#                                  type = "mature",
#                                  ntimes = 2000,
#                                  ev_function_1 = overlapCountsTx,
#                                  ev_function_2 = overlapCountsTx)
# 
# p_h <- plotPermResults(permTestTx_results_h, binwidth = 1)
# p_h

## ----Fig13, echo=FALSE, warning=FALSE,  comment=FALSE, message= FALSE, fig.cap = "Test results of an association with different argument settings."----
knitr::include_graphics("figures/section7.png")

## ----eval=FALSE---------------------------------------------------------------
# set.seed(12345677)
# file <- system.file(package="RgnTX", "extdata", "m6A_sites_data.rds")
# m6A_sites_data <- readRDS(file)
# RS1 <- m6A_sites_data[1:500]
# txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
# 
# permTestTx_results <- permTestTxIA_customPick(RS1 = RS1,
#                                           txdb = txdb,
#                                           type = "mature",
#                                           customPick_function = getStopCodon,
#                                           ntimes = 50)
# shiftedZScoreTx_results <- shiftedZScoreTx(permTestTx_results, txdb = txdb,
#                                            window = 2000,
#                                            step = 200,
#                                            ev_function_1 = overlapCountsTxIA)
# p1 <- plotShiftedZScoreTx(shiftedZScoreTx_results)
# p1

## ----Fig14, echo = FALSE, warning=FALSE, comment=FALSE, message= FALSE, fig.cap = "Shifted z-scores. Analysis of the association of m$^6$A and stop codon regions with window 2000 and step 200."----
file <- system.file(package="RgnTX", "extdata", "shiftedZScoreTx_results1.rds")
shiftedZScoreTx_results <- readRDS(file)
p1 <- plotShiftedZScoreTx(shiftedZScoreTx_results)
p1

## ----eval=FALSE---------------------------------------------------------------
# set.seed(12345677)
# shiftedZScoreTx_results <- shiftedZScoreTx(permTestTx_results,
#                                            window = 300,
#                                            step = 10, txdb = txdb,
#                                            ev_function_1 = overlapCountsTxIA)
# p2 <- plotShiftedZScoreTx(shiftedZScoreTx_results)
# p2

## ----Fig15, echo = FALSE, warning=FALSE, comment=FALSE, message= FALSE, fig.cap = "Shifted z-scores. Analysis of the association of m$^6$A and stop codon regions with window 300 and step 10."----
file <- system.file(package="RgnTX", "extdata", "shiftedZScoreTx_results2.rds")
shiftedZScoreTx_results <- readRDS(file)
p2 <- plotShiftedZScoreTx(shiftedZScoreTx_results)
p2

## ----message=FALSE, warning=FALSE---------------------------------------------
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
# Five transcripts with positive strand.
trans.ids <- c("170", "782", "974", "1364", "1387")

# Take the CDS part of them.
cds.tx0 <- cdsBy(txdb, use.names = FALSE)
cds.p <- cds.tx0[trans.ids]

# The width of the region from each transcript to be picked is 200.
width <- 200

# The start vector 
start = as.numeric(max(end(cds.p)))

R.cds.last200 <- shiftTx(regions = cds.p, start = start, width = width, 
                         direction = "left", strand = "+")
R.cds.last200

## ----message=FALSE, warning=FALSE---------------------------------------------
R.cds.last200.list <- GRanges2GRangesList(R.cds.last200)
R.cds.last200.list

## ----message=FALSE, warning=FALSE---------------------------------------------
width(R.cds.last200.list)

## ----results = "asis", echo=FALSE---------------------------------------------
table1 <- matrix(c(100, 500, 1000, 2000, 5000, 10000,
         1.783995, 2.027494, 2.341810, 3.081001, 5.097162, 8.434085,
         1.786938, 2.024690, 2.367650, 3.006552, 5.028154, 8.959244,
         1.794495, 2.075795, 2.390498, 3.020262, 5.107760, 9.162599,
         1.761639, 2.046817, 2.585473, 3.302140, 5.187891, 9.148554), nrow = 6, ncol = 5)
table1 = data.frame(table1)
names(table1) <- c('Num/Length', 10,50, 100, 200)
knitr::kable(table1, "simple", caption = 'Randomization time of randomizeTx.')

## ----results = "asis", echo=FALSE---------------------------------------------
table2 <- matrix(c(100, 500, 1000, 2000, 5000, 10000,
         1.770159, 2.004670, 2.335991, 3.034632, 5.039495, 8.644615,
         1.801999, 2.024997, 2.322497, 3.042497, 5.194495, 8.500142,
         1.755498, 2.096545, 2.377498, 3.277249, 5.190499, 8.819886,
         1.771499, 2.026999, 2.359494, 3.291889, 5.235691, 9.216726), nrow = 6, ncol = 5)
table2 = data.frame(table2)
names(table2) <- c('Num/Length', 10,50, 100, 200)
knitr::kable(table2, "simple", caption = 'Randomization time of randomizeFeaturesTx.')

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

