# Code example from 'HPiP_tutorial' vignette. See references/ for full tutorial.

## ----echo=FALSE,message=FALSE, warning=FALSE----------------------------------
library("knitr")

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ----echo=FALSE,message=FALSE, warning=FALSE----------------------------------
suppressPackageStartupMessages({
  library("readr")
  library("dplyr")
  library("Biostrings")
  library("SummarizedExperiment")
  library("stringr")
})

## -----------------------------------------------------------------------------
# Loading packages required for data handling & data manipulation
library(dplyr)
library(tibble)
library(stringr)
# Loading HPiP package
library(HPiP)
# Loading data 
data(Gold_ReferenceSet)
dim(Gold_ReferenceSet)

## ----eval=FALSE---------------------------------------------------------------
# local = tempdir()
# #Get positive interactions from BioGrid
# TP <- get_positivePPI(organism.taxID = 2697049,
#                       access.key = 'XXXX',
#                             filename = "PositiveInt.RData",
#                             path = local)

## ----echo=FALSE, warning=FALSE, message=FALSE, results='hide'-----------------
TP <- read_csv(
          system.file("extdata/TP_set.csv", package = "HPiP"),
          show_col_types = FALSE
        )

## -----------------------------------------------------------------------------
#pathogen proteins
prot1 <- unique(TP$`Official Symbol Interactor A`)
#host proteins
prot2 <- unique(TP$`Official Symbol Interactor B`)
#true positive PPIs 
TPset <- TP$PPI
TN <- get_negativePPI(prot1 , prot2, TPset)
dim(TN)

## -----------------------------------------------------------------------------
local = tempdir()
#retrieve FASTA sequences of SARS-CoV-2 virus 
id = unique(Gold_ReferenceSet$Pathogen_Protein)
fasta_list <- getFASTA(id, filename = 'FASTA.RData', path = local)

## ----results='hide'-----------------------------------------------------------
# Convert the list of sequences obtained in the previous section to data.frame 
fasta_df <- do.call(rbind, fasta_list) 
fasta_df <- data.frame(UniprotID = row.names(fasta_df), 
                       sequence = as.character(fasta_df))

#calculate AAC
acc_df <- calculateAAC(fasta_df)
#only print out the result for the first row 
acc_df[1,-1] 

## ----echo= FALSE--------------------------------------------------------------
ex <- acc_df[1,-1] 
ex <- structure(as.numeric(ex), names = colnames(ex)) 
ex

## ----results='hide'-----------------------------------------------------------
# using data.frame provided by getFASTA function as data input
dc_df <- calculateDC(fasta_df)
#only print out the first 30 elements for the first row 
dc_df[1, c(2:31)] 

## ----echo= FALSE--------------------------------------------------------------
ex <- dc_df[1, c(2:31)] 
ex <- structure(as.numeric(ex), names = colnames(ex)) 
ex

## ----results='hide'-----------------------------------------------------------
# using data.frame provided by getFASTA function as data input
tc_df <- calculateTC(fasta_df)
#only print out the first 30 elements for the first row 
tc_df[1, c(2:31)] 

## ----echo= FALSE--------------------------------------------------------------
ex <-tc_df[1, c(2:31)] 
ex <- structure(as.numeric(ex), names = colnames(ex)) 
ex

## ----results='hide'-----------------------------------------------------------
# using data.frame provided by getFASTA function as data input
TC_Sm_df <- calculateTC_Sm(fasta_df)
#only print out the first 30 elements for the first row 
TC_Sm_df[1, c(2:31)] 


## ----echo= FALSE--------------------------------------------------------------
ex <- TC_Sm_df[1, c(2:31)] 
#convert df to character vector 
ex <- structure(as.numeric(ex), names = colnames(ex)) 
ex

## ----results='hide'-----------------------------------------------------------
# using data.frame provided by getFASTA function as data input
QD_df <- calculateQD_Sm(fasta_df)
#only print out the first 30 elements for the first row 
QD_df[1, c(2:31)] 

## ----echo= FALSE--------------------------------------------------------------
ex <- QD_df[1, c(2:31)]
ex <- structure(as.numeric(ex), names = colnames(ex)) 
ex

## ----results='hide'-----------------------------------------------------------
# using data.frame provided by getFASTA function as data input
F1_df <- calculateF(fasta_df, type = "F1")
#only print out the result the first row 
F1_df[1,-1] 

## ----echo= FALSE--------------------------------------------------------------
ex <- F1_df[1,-1] 
#convert df to character vector 
x_df <- structure(as.numeric(ex), names = colnames(ex)) 
x_df

## ----results='hide'-----------------------------------------------------------
# using data.frame provided by getFASTA function as data input
F2_df <- calculateF(fasta_df, type = "F2")
#only print out the result the first row 
F2_df[1,-1] 

## ----echo= FALSE--------------------------------------------------------------
ex <- F2_df[1,-1] 
#convert df to character vector 
ex <- structure(as.numeric(ex), names = colnames(ex)) 
ex

## ----echo=FALSE---------------------------------------------------------------
df1 <- HPiP:::df1
df1[is.na(df1)] <- ""
knitr::kable(df1, align = "lccrr", caption = "Amino acid attributes and the division of amino acid into three-group.", longtable = TRUE)

## ----results='hide'-----------------------------------------------------------
# using data.frame provided by getFASTA function as data input
CTDC_df <- calculateCTDC(fasta_df)
CTDC_df[1, c(-1)] 


## ----echo= FALSE--------------------------------------------------------------
ex <- CTDC_df[1, c(-1)] 
ex <- structure(as.numeric(ex), names = colnames(ex)) 
ex

## ----results='hide'-----------------------------------------------------------
# using data.frame provided by getFASTA function as data input
CTDT_df <- calculateCTDT(fasta_df)
#only print out the result for the first row 
CTDT_df[1, -1] 


## ----echo= FALSE--------------------------------------------------------------
ex <- CTDT_df[1, -1] 
ex <- structure(as.numeric(ex), names = colnames(ex)) 
ex

## ----results='hide'-----------------------------------------------------------
# using data.frame provided by getFASTA function as data input
CTDD_df <- calculateCTDD(fasta_df)
#only print out the first 30 elements for the first row 
CTDD_df[1, c(2:31)] 

## ----echo= FALSE--------------------------------------------------------------
ex <- CTDD_df[1, c(2:31)] 
ex <- structure(as.numeric(ex), names = colnames(ex)) 
ex

## ----results='hide'-----------------------------------------------------------
# using data.frame provided by getFASTA function as data input
CTriad_df <- calculateCTriad(fasta_df)
#only print out the first 30 elements for the first row 
CTriad_df[1, c(2:31)] 


## ----echo= FALSE--------------------------------------------------------------
ex <- CTriad_df[1, c(2:31)] 
#convert df to character vector 
ex <- structure(as.numeric(ex), names = colnames(ex)) 
ex

## ----warning=FALSE, results='hide'--------------------------------------------
# using data.frame provided by getFASTA function as data input
moran_df <- calculateAutocor(fasta_df,type = "moran", nlag = 10)
#only print out the first 30 elements for the first row 
moran_df[1, c(2:31)] 

## ----echo= FALSE--------------------------------------------------------------
ex <- moran_df[1, c(2:31)] 
#convert df to character vector 
ex <- structure(as.numeric(ex), names = colnames(ex)) 
ex

## ----results='hide'-----------------------------------------------------------
# using data.frame provided by getFASTA function as data input
mb_df <- calculateAutocor(fasta_df,type = "moreaubroto", nlag = 10)
#only print out the first 30 elements for the first row 
mb_df[1, c(2:31)] 


## ----echo= FALSE--------------------------------------------------------------
ex <- mb_df[1, c(2:31)] 
#convert df to character vector 
ex <- structure(as.numeric(ex), names = colnames(ex)) 
ex

## ----results='hide'-----------------------------------------------------------
# using data.frame provided by getFASTA function as data input
geary_df <- calculateAutocor(fasta_df,type = "geary", nlag = 10)
#only print out the first 30 elements for the first row 
geary_df[1, c(2:31)] 

## ----echo= FALSE--------------------------------------------------------------
ex <- geary_df[1, c(2:31)] 
#convert df to character vector 
ex <- structure(as.numeric(ex), names = colnames(ex)) 
ex

## ----echo=FALSE---------------------------------------------------------------
df2 <- HPiP:::df2
df2[is.na(df2)] <- ""
knitr::kable(df2, caption = "Composition of k-spaced amino acid pairs. Given 400 (20 × 20) amino acid pairs and four values for k (k=1–4), there are 1600 attributes generated for the KSAAP feature.", 
col.names = c("","","","","","","",""),row.names = NA,
             longtable = TRUE, align = "lccrr")

## ----results='hide'-----------------------------------------------------------
# using data.frame provided by getFASTA function as data input
KSAAP_df <- calculateKSAAP(fasta_df)
#only print out the first 30 elements for the first row 
KSAAP_df[1, c(2:31)] 

## ----echo= FALSE--------------------------------------------------------------
ex <- KSAAP_df[1, c(2:31)] 
#convert df to character vector 
ex <- structure(as.numeric(ex), names = colnames(ex)) 
ex

## ----results='hide', warning=FALSE, eval = FALSE------------------------------
# # using data.frame provided by getFASTA function as data input
# BE_df <- calculateBE(fasta_df)
# #only print out the first 30 elements for the first row
# BE_df[1, c(2:31)]

## ----echo= FALSE, eval = FALSE------------------------------------------------
# ex <- BE_df[1, c(2:31)]
# #convert df to character vector
# ex <- structure(as.numeric(ex), names = colnames(ex))
# ex

## -----------------------------------------------------------------------------
#loading the package 
library(Biostrings)

#Read fasta sequences provided by HPiP package using Biostrings
fasta <- 
  readAAStringSet(system.file("extdata/UP000464024.fasta", package="HPiP"),
                  use.names=TRUE)
#Convert to df
fasta_bios = data.frame(ID=names(fasta),sequences=as.character(fasta))
#Extract the UniProt identifier
fasta_bios$ID <- sub(".*[|]([^.]+)[|].*", "\\1", fasta_bios$ID)
# for example, run ACC
acc_bios <- calculateAAC(fasta_bios)

## -----------------------------------------------------------------------------
#loading viral_se object
data(viral_se)
viral_se

## -----------------------------------------------------------------------------
#loading host_se object
data(host_se)
host_se

## -----------------------------------------------------------------------------
#generate descriptors
CTDC_df <- calculateCTDC(fasta_df)
CTDC_m <- as.matrix(CTDC_df[, -1])
row.names(CTDC_m) <- CTDC_df$identifier

CTDT_df <- calculateCTDT(fasta_df)
CTDT_m <- as.matrix(CTDT_df[, -1])
row.names(CTDT_m) <- CTDT_df$identifier

CTDD_df <- calculateCTDD(fasta_df)
CTDD_m <- as.matrix(CTDD_df[, -1])
row.names(CTDD_m) <- CTDD_df$identifier

## -----------------------------------------------------------------------------
#convert matrix to se object
ctdc_se <- SummarizedExperiment(assays = list(counts = CTDC_m),
                                colData = paste0(colnames(CTDC_df[,-1]),
                                                 "CTDC"))
ctdt_se <- SummarizedExperiment(assays = list(counts = CTDT_m),
                                colData = paste0(colnames(CTDT_df[,-1]),
                                                 "CTDT"))
ctdd_se <- SummarizedExperiment(assays = list(counts = CTDD_m),
                                colData = paste0(colnames(CTDD_df[,-1]),
                                                 "CTDD"))
#combine all se objects to one 
viral_se <- cbind(ctdc_se,ctdd_se,ctdt_se)

## ----echo=FALSE---------------------------------------------------------------
df3 <- HPiP:::df3
df3[is.na(df3)] <- ""
knitr::kable(df3, caption = "List of commonly used descriptors in HPiP.",
             align = "lccrr")


## -----------------------------------------------------------------------------
#extract features from viral_se
counts_v <- assays(viral_se)$counts
#extract row.names from viral_Se
rnames_v <- row.names(counts_v)

## -----------------------------------------------------------------------------
#extract features from host_se
counts_h <- assays(host_se)$counts
#extract row.names from viral_Se
rnames_h <- row.names(counts_h)

## -----------------------------------------------------------------------------
#Loading gold-standard data
gd <- Gold_ReferenceSet

x1_viral <- matrix(NA, nrow = nrow(gd), ncol = ncol(counts_v))
for (i in 1:nrow(gd)) 
  x1_viral[i, ] <- counts_v[which(gd$Pathogen_Protein[i] == rnames_v), ]

x1_host <- matrix(NA, nrow = nrow(gd), ncol = ncol(counts_h))
for (i in 1:nrow(gd)) 
  x1_host[i, ] <- counts_h[which(gd$Host_Protein[i] == rnames_h), ]

## -----------------------------------------------------------------------------
x <- getHPI(x1_viral,x1_host, type = "combine")
x <- as.data.frame(x)
x <- cbind(gd$PPI, gd$class, x)
colnames(x)[1:2] <- c("PPI", "class")

## ----message=FALSE------------------------------------------------------------
#to use correlation analysis, make sure to drop the columns with sd zero
xx <- Filter(function(x) sd(x) != 0, x[,-c(1,2)])
xx <- cbind(x$PPI, x$class, xx)
colnames(xx)[1:2] <- c("PPI", "class")

#perform feature selection using both correlation analysis and RFE approach
set.seed(101)
x_FS <- FSmethod(xx, type = c("both"),
                 cor.cutoff = 0.8,resampling.method = "cv",
                 iter = 2,repeats =NULL, metric = "Accuracy", 
                 verbose = FALSE)

## ----message=FALSE,fig.width = 8, fig.height = 8------------------------------
#cor plot
corr_plot(x_FS$cor.result$corProfile, method = 'square' , cex = 0.1)

## ----fig.width = 8, fig.height = 4--------------------------------------------
#var importance
var_imp(x_FS$rf.result$rfProfile, cex.x = 8, cex.y = 8)

## -----------------------------------------------------------------------------
#load the unlabeled HP-PPIs
data('unlabel_data')
#Constructed labeled HP-PPIs
labeled_dat <- x_FS$rf.result$rfdf
labeled_dat <- labeled_dat[,-1] 
#select important features
unlabel_data <- 
  unlabel_data[names(unlabel_data) %in% names(x_FS$rf.result$rfdf)]

#merge them 
ind_data <- rbind(unlabel_data,labeled_dat)

## -----------------------------------------------------------------------------
# Get class labels
gd <-  x_FS$rf.result$rfdf
gd <-  gd[, c(2,1)]

## ----warning=FALSE,results='hide', message=FALSE------------------------------
set.seed(102)
ppi <- pred_ensembel(ind_data,
                     gd,
                     classifier = c("svmRadial", "glm", "ranger"),
                     resampling.method = "cv",
                     ncross = 5,
                     verboseIter = TRUE,
                     plots = FALSE,
                     filename=file.path(tempdir(), "plots.pdf"))

## -----------------------------------------------------------------------------
pred_interactions <- ppi[["predicted_interactions"]]
head(pred_interactions)

## -----------------------------------------------------------------------------
pred_interactions <- filter(pred_interactions, ensemble >= 0.7)
dim(pred_interactions)

## ----message=FALSE, results='hide',fig.width = 6, fig.height = 6--------------
S_interc <- filter(pred_interactions, 
                           str_detect(Pathogen_protein, "^ORF8:"))
#drop the first column
ppi <- S_interc[,-1]

plotPPI(ppi, edge.name = "ensemble",
            node.color ="red",
            edge.color = "grey",
            cex.node = 10,
            node.label.dist= 2)

## ----fig.width = 10, fig.height = 5-------------------------------------------
ppi <- pred_interactions[,-1]
FreqInteractors(ppi,cex.size = 12)

## ----warning=FALSE, message=FALSE, results='hide', eval=FALSE-----------------
# enrich_result <-
#   enrichfindP(ppi,threshold = 0.05,
#             sources = "GO",
#             p.corrction.method = "bonferroni",
#             org = "hsapiens")

## ----message=FALSE------------------------------------------------------------
ppi <- pred_interactions[,-1]
set.seed(103)
predcpx <- run_clustering(ppi, method = "FC")

## ----message=FALSE------------------------------------------------------------
enrichcpx <- enrichfind_cpx(predcpx,
             threshold = 0.05,
             sources = "GO",
             p.corrction.method = "bonferroni",
             org = "hsapiens")

## -----------------------------------------------------------------------------
sessionInfo()

