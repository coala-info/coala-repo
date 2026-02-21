# Code example from 'RiboCrypt_overview' vignette. See references/ for full tutorial.

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
library(RiboCrypt) # This package
library(ORFik)     # The backend package for RiboCrypt

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
 df <- ORFik.template.experiment()
 cds <- loadRegion(df, "cds")
 cds # gene annotation
 df # let's look at libraries the experiment contains


## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
df[4:6,]
df[which(df$libtype == "CAGE"),]
df[which(df$condition == "Mutant"),]


## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
  dir <- system.file("extdata/Homo_sapiens_sample", "", package = "ORFik")
  # 2. Pick an experiment name
  exper <- "ORFik_tutorial_data"
  # 3. Pick .gff/.gtf location
  txdb <- system.file("extdata/Homo_sapiens_sample", "Homo_sapiens_dummy.gtf.db", package = "ORFik")
  fa <- system.file("extdata/Homo_sapiens_sample", "Homo_sapiens_dummy.fasta", package = "ORFik")
  all_experiments_dir <- ORFik::config()["exp"] # <- Here they are 
  template <- create.experiment(dir = dir, saveDir = all_experiments_dir,
                                exper, txdb = txdb, fa = fa,
                                organism = "Homo sapiens simulated",
                                author = "Simulated by ORFik", types = "ofst")


## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------
convert_to_bigWig(df)

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
# # Just set some settings for this tutorial to look cool, usually you can ignore these
# browser_options <- c(default_frame_type = "columns", default_experiment = "ORFik_tutorial_data", default_libs = paste0(c("CAGE_WT_r1", "PAS_WT_r1", "RFP_WT_r1", "RNA_WT_r1"), collapse = "|"), plot_on_start = TRUE)
# 
# RiboCrypt_app(browser_options = browser_options)

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------

  multiOmicsPlot_ORFikExp(extendLeaders(extendTrailers(cds[3], 30), 30), annotation = cds,df = df[c(1,5,9,13),],
                        frames_type = "columns", custom_motif = "CTG")
 

## ----eval = FALSE, echo = TRUE, message = FALSE-------------------------------
# 
#   multiOmicsPlot_ORFikExp(extendLeaders(extendTrailers(cds[3], 30), 30), annotation = cds,df = df[which(df$libtype == "RFP")[1],], frames_type = "lines")
# 

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------

  multiOmicsPlot_ORFikExp(extendLeaders(extendTrailers(cds[3], 30), 30), annotation = cds,df = df[which(df$libtype == "RFP")[1],],
                        frames_type = "lines", kmers = 6)
 

## ----eval = TRUE, echo = TRUE, message = FALSE--------------------------------

  multiOmicsPlot_ORFikExp(extendLeaders(extendTrailers(cds[3], 30), 30), annotation = cds,df = df[which(df$libtype == "RFP")[1],],
                        frames_type = "stacks", kmers = 6)
 

