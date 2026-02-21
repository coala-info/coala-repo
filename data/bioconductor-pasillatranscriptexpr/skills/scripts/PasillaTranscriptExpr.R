# Code example from 'PasillaTranscriptExpr' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex(use.unsrturl=FALSE)

## ----setup_knitr, include=FALSE, cache=FALSE-------------------------------
library(knitr)
opts_chunk$set(cache = TRUE, tidy = FALSE, 
  tidy.opts = list(blank = FALSE, width.cutoff=70), highlight = FALSE, 
  out.width = "7cm", out.height = "7cm", fig.align = "center")

## ----sri_file, eval = TRUE-------------------------------------------------
library(PasillaTranscriptExpr)

data_dir <- system.file("extdata", package = "PasillaTranscriptExpr")

sri <- read.table(paste0(data_dir, "/SraRunInfo.csv"), stringsAsFactors = FALSE,
  sep = ",", header = TRUE)
keep <- grep("CG8144|Untreated-", sri$LibraryName)
sri <- sri[keep, ]

## ----download, eval = FALSE------------------------------------------------
# sra_files <- basename(sri$download_path)
# 
# for(i in 1:nrow(sri))
#   download.file(sri$download_path[i], sra_files[i])
# 

## ----fastqdump, eval = FALSE-----------------------------------------------
# cmd <- paste0("fastq-dump -O ./ --split-3 ", sra_files)
# 
# for(i in 1:length(cmd))
#   system(cmd[i])
# 
# system("gzip *.fastq")

## ----download_fasta, eval = FALSE------------------------------------------
# system("wget ftp://ftp.ensembl.org/pub/release-70/fasta/drosophila_melanogaster/cdna/Drosophila_melanogaster.BDGP5.70.cdna.all.fa.gz")
# system("gunzip Drosophila_melanogaster.BDGP5.70.cdna.all.fa.gz")

## ----download_gtf, eval = FALSE--------------------------------------------
# system("wget ftp://ftp.ensembl.org/pub/release-70/gtf/drosophila_melanogaster/Drosophila_melanogaster.BDGP5.70.gtf.gz")
# system("gunzip Drosophila_melanogaster.BDGP5.70.gtf.gz")

## ----kallisto_metadata, eval = TRUE----------------------------------------
sri$LibraryName <- gsub("S2_DRSC_","",sri$LibraryName)
metadata <- unique(sri[,c("LibraryName", "LibraryLayout", "SampleName",
  "avgLength")])

for(i in seq_len(nrow(metadata))){
  indx <- sri$LibraryName == metadata$LibraryName[i]
  
  if(metadata$LibraryLayout[i] == "PAIRED"){
    metadata$fastq[i] <- paste0(sri$Run[indx], "_1.fastq.gz ",
      sri$Run[indx], "_2.fastq.gz", collapse = " ")
  }else{
    metadata$fastq[i] <- paste0(sri$Run[indx], ".fastq.gz", collapse = " ")
  }
}

metadata$condition <- ifelse(grepl("CG8144_RNAi", metadata$LibraryName),
  "KD", "CTL")
metadata$UniqueName <- paste0(1:nrow(metadata), "_", metadata$SampleName)

## ----kallisto_index, eval = TRUE-------------------------------------------
cDNA_fasta <- "Drosophila_melanogaster.BDGP5.70.cdna.all.fa"
index <- "Drosophila_melanogaster.BDGP5.70.cdna.all.idx"

cmd <- paste("kallisto index -i", index, cDNA_fasta, sep = " ")
cmd

## ----kallisto_index_cmd, eval = FALSE--------------------------------------
# system(cmd)

## ----kallisto_quantification, eval = TRUE----------------------------------
out_dir <- metadata$UniqueName

cmd <- paste("kallisto quant -i", index, "-o", out_dir, "-b 0 -t 5",
  ifelse(metadata$LibraryLayout == "SINGLE",
    paste("--single -l", metadata$avgLength), ""), metadata$fastq)
cmd

## ----kallisto_quantification_cmd, eval = FALSE-----------------------------
# for(i in 1:length(cmd))
#   system(cmd[i])

## ----library_rtracklayer, eval = TRUE, message = FALSE---------------------
library(rtracklayer)

## ----gtf, eval = FALSE-----------------------------------------------------
# gtf_dir <- "Drosophila_melanogaster.BDGP5.70.gtf"
# 
# gtf <- import(gtf_dir)
# 
# gt <- unique(mcols(gtf)[, c("gene_id", "transcript_id")])
# rownames(gt) <- gt$transcript_id
# 

## ----merge_counts, eval = FALSE--------------------------------------------
# samples <- unique(metadata$SampleName)
# 
# counts_list <- lapply(1:length(samples), function(i){
#   indx <- which(metadata$SampleName == samples[i])
# 
#   if(length(indx) == 1){
#     abundance <- read.table(file.path(metadata$UniqueName[indx],
#       "abundance.txt"), header = TRUE, sep = "\t", as.is = TRUE)
#   }else{
#     abundance <- lapply(indx, function(j){
#       abundance_tmp <- read.table(file.path(metadata$UniqueName[j],
#         "abundance.txt"), header = TRUE, sep = "\t", as.is = TRUE)
#       abundance_tmp <- abundance_tmp[, c("target_id", "est_counts")]
#       abundance_tmp
#     })
#     abundance <- Reduce(function(...) merge(..., by = "target_id", all = TRUE,
#       sort = FALSE), abundance)
#     est_counts <- rowSums(abundance[, -1])
#     abundance <- data.frame(target_id = abundance$target_id,
#       est_counts = est_counts, stringsAsFactors = FALSE)
#   }
# 
#   counts <- data.frame(abundance$target_id, abundance$est_counts,
#     stringsAsFactors = FALSE)
#   colnames(counts) <- c("feature_id", samples[i])
#   return(counts)
# })
# 
# counts <- Reduce(function(...) merge(..., by = "feature_id", all = TRUE,
#   sort = FALSE), counts_list)
# 
# ### Add gene IDs
# counts$gene_id <- gt[counts$feature_id, "gene_id"]
# 

## ----metadata, eval = TRUE-------------------------------------------------
metadata <- unique(metadata[, c("LibraryName", "LibraryLayout", "SampleName",
  "condition")])
metadata

## ----metadata_save, eval = FALSE-------------------------------------------
# write.table(metadata, "metadata.txt", quote = FALSE, sep = "\t",
#   row.names = FALSE)

## ----counts_save, eval = FALSE---------------------------------------------
# ### Final counts with columns sorted as in metadata
# counts <- counts[, c("feature_id", "gene_id", metadata$SampleName)]
# write.table(counts, "counts.txt", quote = FALSE, sep = "\t", row.names = FALSE)

## ----sessionInfo-----------------------------------------------------------
sessionInfo()

