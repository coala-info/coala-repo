# Code example from 'LINCS-analysis' vignette. See references/ for full tutorial.

## ---- echo=FALSE---------------------------------------------------------
library(knitr)
opts_chunk$set(tidy.opts=list(width.cutoff=60),tidy=TRUE)

## ----eval=FALSE----------------------------------------------------------
#  # bash
#  aria2c -x 8 -s 8 https://goo.gl/3TigFI
#  gzip -d *.gz

## ---- echo=TRUE, message=F, warning=F, eval=FALSE------------------------
#  sl <- new("Slinky")
#  download(sl, type = "expression", level="3")

## ---- echo=TRUE, message=F, warning=F, eval=FALSE------------------------
#  download(sl, type = "info")

## ---- echo=TRUE, message=F, warning=F, eval=FALSE------------------------
#  library(slinky)
#  
#  #update following lines with your details:
#  key <- "YOUR_API_KEY"
#  gctx <- "/path/to/GSE92742_Broad_LINCS_Level3_INF_mlr12k_n1319138x12328.gctx"
#  info <- "/path/to/GSE92742_Broad_LINCS_inst_info.txt.gz"
#  sl <- Slinky(key, gctx, info)
#  

## ---- echo=TRUE, message=F, warning=F, eval=TRUE-------------------------
library(slinky)
user_key <- httr::content(httr::GET("https://api.clue.io/temp_api_key"),
                          as = "parsed")$user_key

sl <- Slinky(user_key, 
                system.file("extdata", "demo.gctx", package = "slinky"),
                system.file("extdata", "demo_inst_info.txt",
                                package = "slinky"))

## ---- echo=TRUE, message=F, warning=F, eval=TRUE-------------------------
col.ix <- which(metadata(sl)$pert_iname == "amoxicillin" & 
                metadata(sl)$cell_id == "MCF7")

data <- readGCTX(sl[,col.ix])

## This would be slower:
#data <- readGCTX(sl)[,col.ix]


## ---- echo=TRUE, eval=TRUE-----------------------------------------------
amox_gold <- clueInstances(sl, where_clause = list("pert_type" = "trt_cp",
                                                "pert_iname" = "amoxicillin",
                                                "cell_id" = "MCF7",
                                                "is_gold" = TRUE), 
                              poscon = "omit")


## ---- echo=TRUE, message=F, warning=F, eval=TRUE-------------------------
ix <- which(colnames(sl) %in% amox_gold)
amox_gold_data <- readGCTX(sl[ ,ix])

## ---- echo=TRUE, message=F, warning=F, eval=TRUE-------------------------

amox_gold_sumex <- as(sl[ ,ix], "SummarizedExperiment")



## ---- echo=TRUE, message=F, warning=T, eval=TRUE-------------------------

amox_gold_sumex <- loadL1K(sl,
                      where_clause = list("pert_type" = "trt_cp",
                        "pert_iname" = "amoxicillin",
                        "cell_id" = "MCF7",
                        "is_gold" = TRUE))


## ---- echo=TRUE, message=F, warning=T, eval=TRUE-------------------------
amox_gold_sumex <- loadL1K(sl,
                      where_clause = list("pert_type" = "trt_cp",
                        "pert_iname" = "amoxicillin",
                        "cell_id" = "MCF7",
                        "is_gold" = TRUE),
                      inferred = FALSE)

# equivalent to

amox_gold_sumex <- loadL1K(sl[1:978, ],
                      where_clause = list("pert_type" = "trt_cp",
                        "pert_iname" = "amoxicillin",
                        "cell_id" = "MCF7",
                        "is_gold" = TRUE),
                      inferred = FALSE)

# equivalent to

amox_gold_sumex <- loadL1K(sl[1:978, ],
                      where_clause = list("pert_type" = "trt_cp",
                        "pert_iname" = "amoxicillin",
                        "cell_id" = "MCF7",
                        "is_gold" = TRUE),
                      inferred = FALSE)

amox_gold_sumex <- amox_gold_sumex[1:978, ]


## ---- echo=TRUE, message=F, warning=T, eval=TRUE-------------------------
rownames(sl)[1:5]
colnames(sl)[1:5]

# note subsetting first will be faster as it avoids loading in the entire 
# set of names from the gctx file:

rownames(sl[1:5, ])
colnames(sl[, 1:5])

# sanity check
all.equal(as.character(colnames(sl)),
          as.character(metadata(sl)$distil_id))


## ---- echo=TRUE, message=T, warning=F, eval=FALSE------------------------
#  
#  fda <- clue(sl, "rep_drugs",
#              where_clause = list("status_source" = list(like = "FDA Orange"),
#                  "final_status" = "Launched",
#                  "animal_only" = "0",
#                  "in_cmap" = TRUE),
#              verbose = FALSE)
#  
#  fda_pert <- clueInstances(sl, poscon = "omit",
#                  where_clause = list("pert_type" = "trt_cp",
#                                      "is_gold" = TRUE,
#                                      "pert_iname" =
#                                                list("inq" = fda$pert_iname)),
#                  verbose = FALSE)
#  
#  

## ---- eval=FALSE---------------------------------------------------------
#  fda_gold_sumex <- loadL1K(sl, ids = fda_pert))

## ----eval=TRUE-----------------------------------------------------------

veh <- clueVehicle(sl, amox_gold, verbose=FALSE)


## ----eval=FALSE----------------------------------------------------------
#  ix <- which(metadata(sl)$pert_iname %in% veh$pert_vehicle)
#  amox_and_control <- loadL1K(sl,
#                              ids = c(amox_gold, metadata(sl[, ix])$inst_id))

## ----eval=TRUE-----------------------------------------------------------
ids.ctrl <- controls(sl, ids = amox_gold)$distil_id
amox_and_control <- loadL1K(sl, ids = c(amox_gold, 
                                        ids.ctrl))

## ----eval=TRUE-----------------------------------------------------------
amox_and_control <- loadL1K(sl, ids = amox_gold, 
                               controls = TRUE)

## ----eval=TRUE, message = FALSE------------------------------------------
cd_vector <- diffexp(sl, 
                    treat = "amoxicillin", 
                    split_by_plate = FALSE, 
                    verbose = FALSE)
head(cd_vector)

## ------------------------------------------------------------------------
cd_vecs <- diffexp(sl, treat = "E2F3",
                 where_clause = list("pert_type" = "trt_sh",
                                     "cell_id" = "MCF7"),
                 split_by_plate = TRUE, 
                 verbose = FALSE)
cd_vecs[1:5,1:3]

## ------------------------------------------------------------------------
# negate the values so 1 = the most up regulated gene
# (rank sorts in ASCENDING order, which is not what we want)
ranks <- apply(-cd_vecs, 2, rank)

n <- nrow(ranks)
rp <- apply(ranks, 1, function(x) { (prod(x/n))})


## ---- eval=FALSE, message=FALSE------------------------------------------
#  suppressMessages(library(org.Hs.eg.db))
#  entrez_ids <- names(sort(rp, decreasing=FALSE))[1:5]
#  entrez_ids <- entrez_ids[which(entrez_ids %in% ls(org.Hs.egSYMBOL))]
#  as.vector(unlist(mget(entrez_ids, org.Hs.egSYMBOL)))

## ---- fig.width=6--------------------------------------------------------
suppressMessages(library(ggplot2))
suppressMessages(library(Rtsne))

sumex <- loadL1K(sl[seq_len(978), seq_len(131)])

set.seed(100)
ts <- Rtsne(t(SummarizedExperiment::assays(sumex)[[1]]), perplexity = 10)
tsne_plot <- data.frame(x = ts$Y[,1], 
                        y = ts$Y[,2], 
                        treatment = sumex$pert_iname,
                        plate = sumex$rna_plate)

ggplot(tsne_plot) + 
    geom_point(aes(x = x, y = y, color = plate)) + 
    labs(x = "TSNE X", y = "TSNE Y") + 
    theme(axis.title = element_text(face = "bold", color = "gray"))


## ---- fig.width=6--------------------------------------------------------
ggplot(tsne_plot) + 
    geom_point(aes(x = x, y = y, color = treatment)) + 
    labs(x = "TSNE X", y = "TSNE Y") + 
    theme(axis.title = element_text(face = "bold", color = "gray"))

## ---- eval=FALSE---------------------------------------------------------
#  sl1 <- Slinky(key, gctx1, info1)
#  sl2 <- Slinky(key, gctx2, info2)
#  ix <- which(match(rownames(sl1), rownames(sl2)))
#  ix.na <- which(is.na(ix))
#  sl1 <- sl1[-ix.na, ]
#  ix <- ix[-ix.na]
#  sl2 <- sl2[ix,]
#  sl <- cbind(sl1, sl2)
#  

