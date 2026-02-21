# Code example from 'GeuvadisTranscriptExpr' vignette. See references/ for full tutorial.

## ----style-knitr, eval=TRUE, echo=FALSE, results="asis"--------------------
BiocStyle::latex(use.unsrturl=FALSE)

## ----setup_knitr, include=FALSE, cache=FALSE-------------------------------
library(knitr)
opts_chunk$set(cache = TRUE, tidy = FALSE, tidy.opts = list(blank = FALSE, 
  width.cutoff=70), highlight = FALSE, out.width = "7cm", out.height = "7cm", 
  fig.align = "center")

## ----eval = TRUE, message = FALSE------------------------------------------
library(GenomicRanges)
library(rtracklayer)

## ----annotation, eval=FALSE------------------------------------------------
# gtf_dir <- "gencode.v12.annotation.gtf"
# 
# gtf <- import(gtf_dir)
# 
# ### Keep protein coding genes
# keep_index <- mcols(gtf)$gene_type == "protein_coding" &
#   mcols(gtf)$type == "gene"
# gtf <- gtf[keep_index]
# ### Remove 'chr' from chromosome names
# seqlevels(gtf) <- gsub(pattern = "chr", replacement = "", x = seqlevels(gtf))
# 
# genes_bed <- data.frame(chr = seqnames(gtf), start =  start(gtf),
#   end = end(gtf), geneId = mcols(gtf)$gene_id,
#   stringsAsFactors = FALSE)
# 
# for(i in as.character(1:22)){
#   genes_bed_sub <- genes_bed[genes_bed$chr == i, ]
#   write.table(genes_bed_sub, "genes_chr", i ,".bed", quote = FALSE,
#     sep = "\t", row.names = FALSE, col.names = FALSE)
# }
# 

## ----eval = TRUE, message = FALSE------------------------------------------
library(limma)

## ----eval=FALSE------------------------------------------------------------
# metadata_dir <- "E-GEUV-1.sdrf.txt"
# 
# samples <- read.table(metadata_dir, header = TRUE, sep = "\t", as.is = TRUE)
# 
# samples <- unique(samples[c("Assay.Name", "Characteristics.population.")])
# colnames(samples) <- c("sample_id", "population")
# 
# samples$sample_id_short <- strsplit2(samples$sample_id, "\\.")[,1]
# 

## ----eval = FALSE----------------------------------------------------------
# expr_dir <- "GD660.TrQuantCount.txt"
# 
# expr_all <- read.table(expr_dir, header = TRUE, sep="\t", as.is = TRUE)
# 
# expr_all <- expr_all[, c("TargetID", "Gene_Symbol", "Chr",
#   samples$sample_id)]
# colnames(expr_all) <- c("TargetID", "Gene_Symbol", "Chr",
#   samples$sample_id_short)
# 
# for(j in "CEU"){
#   for(i in 1:22){
#     expr <- expr_all[expr_all$Chr == i, c("TargetID", "Gene_Symbol",
#       samples$sample_id_short[samples$population == j])]
#     write.table(expr, paste0("TrQuantCount_", j, "_chr", i, ".tsv"),
#       quote = FALSE, sep = "\t", row.names = FALSE, col.names = TRUE)
#   }
# }

## ----eval = TRUE, message = FALSE------------------------------------------
library(Rsamtools)

## ----eval = FALSE----------------------------------------------------------
# files <- list.files(path = ".", pattern = "genotypes.vcf.gz",
#   full.names = TRUE, include.dirs = FALSE)
# 
# ### bgzip and index the vcf files
# for(i in 1:length(files)){
#   zipped <- bgzip(files[i])
#   idx <- indexTabix(zipped, format = "vcf")
# }

## ----eval = TRUE, message = FALSE------------------------------------------
library(VariantAnnotation)
library(tools)

## ----eval = FALSE----------------------------------------------------------
# ### Extended gene ranges
# window <- 5000
# gene_ranges <- resize(gtf, GenomicRanges::width(gtf) + 2 * window,
#   fix = "center")
# 
# chr <- gsub("chr", "", strsplit2(files, split = "\\.")[, 2])
# 
# for(j in "CEU"){
#   for(i in 1:length(files)){
#     cat(j, chr[i], fill = TRUE)
# 
#     zipped <- paste0(file_path_sans_ext(files[i]), ".bgz")
#     idx <- paste0(file_path_sans_ext(files[i]), ".bgz.tbi")
#     tab <- TabixFile(zipped, idx)
# 
#     ### Explore the file header with scanVcfHeader
#     hdr <- scanVcfHeader(tab)
#     print(all(samples$sample_id_short %in% samples(hdr)))
# 
#     ### Read a subset of VCF file
#     gene_ranges_tmp <- gene_ranges[seqnames(gene_ranges) == chr[i]]
#     param <- ScanVcfParam(which = gene_ranges_tmp, samples =
#         samples$sample_id_short[samples$population == j])
#     vcf <- readVcf(tab, "hg19", param)
# 
#     ### Keep only the bi-allelic SNPs
#     # width of ref seq
#     rw <- width(ref(vcf))
#     # width of first alt seq
#     aw <- unlist(lapply(alt(vcf), function(x) {width(x[1])}))
#     # number of alternate genotypes
#     nalt <- elementLengths(alt(vcf))
#     # select only bi-allelic SNPs (monomorphic OK, so aw can be 0 or 1)
#     snp <- rw == 1 & aw <= 1 & nalt == 1
#     # subset vcf
#     vcfbi <- vcf[snp,]
# 
#     rowdata <- rowData(vcfbi)
# 
#     ### Convert genotype into number of alleles different from reference
#     geno <- geno(vcfbi)$GT
#     geno01 <- geno
#     geno01[,] <- -1
#     geno01[geno %in% c("0/0", "0|0")] <- 0 # REF/REF
#     geno01[geno %in% c("0/1", "0|1", "1/0", "1|0")] <- 1 # REF/ALT
#     geno01[geno %in% c("1/1", "1|1")] <- 2 # ALT/ALT
#     mode(geno01) <- "integer"
# 
#     genotypes <- unique(data.frame(chr = seqnames(rowdata),
#       start = start(rowdata), end = end(rowdata), snpId = rownames(geno01),
#       geno01, stringsAsFactors = FALSE))
# 
#     ### Sort SNPs by position
#     genotypes <- genotypes[order(genotypes[ ,2]), ]
# 
#     write.table(genotypes, file = paste0("genotypes_", j, "_chr",
#       chr[i], ".tsv"), quote = FALSE, sep = "\t", row.names = FALSE,
#       col.names = TRUE)
# 
#   }
# }
# 

## ----sessionInfo-----------------------------------------------------------
sessionInfo()

