# Code example from 'vignettes' vignette. See references/ for full tutorial.

## ----echo = FALSE,hide=TRUE, message=FALSE,warning=FALSE----------------------
library(ELMER.data)
library(DT)
library(dplyr)

## ----eval = FALSE-------------------------------------------------------------
# devtools::install_github(repo = "tiagochst/ELMER.data")
# library("ELMER.data")
# library("GenomicRanges")

## ----eval=FALSE, include=TRUE-------------------------------------------------
# 
# getTranscripts <- function(genome = "hg38"){
# 
#   tries <- 0L
#   msg <- character()
#   while (tries < 3L) {
#     tss <- tryCatch({
#       host <- ifelse(genome == "hg19",  "grch37.ensembl.org","www.ensembl.org")
#       message("Accessing ", host, " to get TSS information")
# 
#       ensembl <- tryCatch({
#         useEnsembl("ensembl", dataset = "hsapiens_gene_ensembl", host =  host)
#       },  error = function(e) {
#         message(e)
#         for(mirror in c("asia","useast","uswest")){
#           x <- useEnsembl("ensembl",
#                           dataset = "hsapiens_gene_ensembl",
#                           mirror = mirror,
#                           host =  host)
#           if(class(x) == "Mart") {
#             return(x)
#           }
#         }
#         return(NULL)
#       })
# 
#       if(is.null(host)) {
#         message("Problems accessing ensembl database")
#         return(NULL)
#       }
#       attributes <- c("chromosome_name",
#                       "start_position",
#                       "end_position", "strand",
#                       "ensembl_gene_id",
#                       "transcription_start_site",
#                       "transcript_start",
#                       "ensembl_transcript_id",
#                       "transcript_end",
#                       "external_gene_name")
#       chrom <- c(1:22, "X", "Y","M","*")
#       db.datasets <- listDatasets(ensembl)
#       description <- db.datasets[db.datasets$dataset=="hsapiens_gene_ensembl",]$description
#       message(paste0("Downloading transcripts information from ", ensembl@host, ". Using: ", description))
# 
#       filename <-  paste0(gsub("[[:punct:]]| ", "_",description),"_tss.rda")
#       tss <- getBM(attributes = attributes, filters = c("chromosome_name"), values = list(chrom), mart = ensembl)
#       tss <- tss[!duplicated(tss$ensembl_transcript_id),]
#       save(tss, file = filename, compress = "xz")
#     })
#   }
#   return(tss)
# }
# 
# getGenes <- function (genome = "hg19"){
#   tries <- 0L
#   msg <- character()
#   while (tries < 3L) {
#     gene.location <- tryCatch({
#       host <- ifelse(genome == "hg19", "grch37.ensembl.org",
#                      "www.ensembl.org")
#       message("Accessing ", host, " to get gene information")
#       ensembl <- tryCatch({
#         useEnsembl("ensembl", dataset = "hsapiens_gene_ensembl",
#                    host = host)
#       }, error = function(e) {
#         message(e)
#         for (mirror in c("asia", "useast", "uswest")) {
#           x <- useEnsembl("ensembl", dataset = "hsapiens_gene_ensembl",
#                           mirror = mirror, host = host)
#           if (class(x) == "Mart") {
#             return(x)
#           }
#         }
#         return(NULL)
#       })
#       if (is.null(host)) {
#         message("Problems accessing ensembl database")
#         return(NULL)
#       }
#       attributes <- c("chromosome_name", "start_position",
#                       "end_position", "strand", "ensembl_gene_id",
#                       "entrezgene", "external_gene_name")
#       db.datasets <- listDatasets(ensembl)
#       description <- db.datasets[db.datasets$dataset ==
#                                    "hsapiens_gene_ensembl", ]$description
#       message(paste0("Downloading genome information (try:",
#                      tries, ") Using: ", description))
#       filename <- paste0(gsub("[[:punct:]]| ", "_", description),
#                          ".rda")
#       if (!file.exists(filename)) {
#         chrom <- c(1:22, "X", "Y")
#         gene.location <- getBM(attributes = attributes,
#                                filters = c("chromosome_name"), values = list(chrom),
#                                mart = ensembl)
#       }
#       gene.location
#     }, error = function(e) {
#       msg <<- conditionMessage(e)
#       tries <<- tries + 1L
#     })
#     if (!is.null(gene.location)) break
#   }
#   if (tries == 3L)
#     stop("failed to get URL after 3 tries:", "\n  error: ", msg)
# 
#   return(gene.location)
# }
# 
# Human_genes__GRCh37_p13__tss <- getTranscripts(genome = "hg19")
# Human_genes__GRCh38_p12__tss <- getTranscripts(genome = "hg38")
# Human_genes__GRCh37_p13 <- getGenes("hg19")
# Human_genes__GRCh38_p12 <- getGenes("hg38")
# save(Human_genes__GRCh37_p13__tss,
#      file = "Human_genes__GRCh37_p13__tss.rda",
#      compress = "xz")
# 
# save(Human_genes__GRCh38_p12,
#      file = "Human_genes__GRCh38_p12.rda",
#      compress = "xz")
# 
# save(Human_genes__GRCh38_p12__tss,
#      file = "Human_genes__GRCh38_p12__tss.rda",
#      compress = "xz")
# 
# save(Human_genes__GRCh37_p13,
#      file = "Human_genes__GRCh37_p13.rda",
#      compress = "xz")

## ----eval=FALSE, include=TRUE-------------------------------------------------
# for(plat in c("450K","EPIC")) {
#   for(genome in c("hg38","hg19")) {
#     base <- "http://zwdzwd.io/InfiniumAnnotation/current/"
#     path <- file.path(base,plat,paste(plat,"hg19.manifest.rds", sep ="."))
#     if (grepl("hg38", genome)) path <- gsub("hg19","hg38",path)
#     if(plat == "EPIC") {
#       annotation <- paste0(base,"EPIC/EPIC.hg19.manifest.rds")
#     } else {
#       annotation <- paste0(base,"hm450/hm450.hg19.manifest.rds")
#     }
#     if(grepl("hg38", genome)) annotation <- gsub("hg19","hg38",annotation)
#     if(!file.exists(basename(annotation))) {
#       if(Sys.info()["sysname"] == "Windows") mode <- "wb" else  mode <- "w"
#       downloader::download(annotation, basename(annotation), mode = mode)
#     }
#   }
# }
# 
# devtools::use_data(EPIC.hg19.manifest,overwrite = T,compress = "xz")
# devtools::use_data(EPIC.hg38.manifest,overwrite = T,compress = "xz")
# devtools::use_data(hm450.hg19.manifest,overwrite = T,compress = "xz")
# devtools::use_data(hm450.hg38.manifest,overwrite = T,compress = "xz")

## ----message=FALSE------------------------------------------------------------
data("EPIC.hg19.manifest")
as.data.frame(EPIC.hg19.manifest)[1:5,] %>% datatable(options = list(scrollX = TRUE,pageLength = 5)) 
data("EPIC.hg38.manifest")
as.data.frame(EPIC.hg38.manifest)[1:5,] %>% datatable(options = list(scrollX = TRUE,pageLength = 5)) 
data("hm450.hg19.manifest")
as.data.frame(hm450.hg19.manifest)[1:5,] %>% datatable(options = list(scrollX = TRUE,pageLength = 5)) 
data("hm450.hg38.manifest")
as.data.frame(hm450.hg38.manifest)[1:5,] %>% datatable(options = list(scrollX = TRUE,pageLength = 5)) 

## ----eval=FALSE, include=TRUE-------------------------------------------------
# library(xml2)
# library(httr)
# library(dplyr)
# library(rvest)
# createMotifRelevantTfs <- function(classification = "family"){
# 
#   message("Accessing hocomoco to get last version of TFs ", classification)
#   file <- paste0(classification,".motif.relevant.TFs.rda")
# 
#   # Download from http://hocomoco.autosome.ru/human/mono
#   tf.family <- "http://hocomoco11.autosome.ru/human/mono?full=true" %>% read_html()  %>%  html_table()
#   tf.family <- tf.family[[1]]
#   # Split TF for each family, this will help us map for each motif which are the some ones in the family
#   # basicaly: for a TF get its family then get all TF in that family
#   col <- ifelse(classification == "family", "TF family","TF subfamily")
#   family <- split(tf.family,f = tf.family[[col]])
# 
#   motif.relevant.TFs <- plyr::alply(tf.family,1, function(x){
#     f <- x[[col]]
#     if(f == "") return(x$`Transcription factor`) # Case without family, we will get only the same object
#     return(unique(family[as.character(f)][[1]]$`Transcription factor`))
#   },.progress = "text")
#   #names(motif.relevant.TFs) <- tf.family$`Transcription factor`
#   names(motif.relevant.TFs) <- tf.family$Model
#   # Cleaning object
#   attr(motif.relevant.TFs,which="split_type") <- NULL
#   attr(motif.relevant.TFs,which="split_labels") <- NULL
# 
#   return(motif.relevant.TFs)
# }
# 
# updateTFClassList <- function(tf.list, classification = "family"){
#   col <- ifelse(classification == "family","family.name","subfamily.name")
#   TFclass <- getTFClass()
#   # Hocomoco
#   tf.family <- "http://hocomoco11.autosome.ru/human/mono?full=true" %>% read_html()  %>%  html_table()
#   tf.family <- tf.family[[1]]
# 
#   tf.members <- plyr::alply(unique(TFclass %>% pull(col)),1, function(x){
#     TFclass$Gene[which(x == TFclass[,col])]
#   },.progress = "text")
#   names(tf.members) <- unique(TFclass %>% pull(col))
#   attr(tf.members,which="split_type") <- NULL
#   attr(tf.members,which="split_labels") <- NULL
# 
#   for(i in names(tf.list)){
#     x <- tf.family[tf.family$Model == i,"Transcription factor"]
#     idx <- which(sapply(lapply(tf.members, function(ch) grep(paste0("^",x,"$"), ch)), function(x) length(x) > 0))
#     if(length(idx) == 0) next
#     members <- tf.members[[idx]]
#     tf.list[[i]] <- sort(unique(c(tf.list[[i]],members)))
#   }
#   return(tf.list)
# }
# 
# getTFClass <- function(){
#   # get TF classification
#   file <- "TFClass.rda"
#   if(file.exists(file)) {
#     return(get(load(file)))
#   }
#   file <- "http://tfclass.bioinf.med.uni-goettingen.de/suppl/tfclass.ttl.gz"
#   downloader::download(file,basename(file))
#   char_vector <- readLines(basename(file))
#   # Find TF idx
#   idx <- grep("genus",char_vector,ignore.case = T)
# 
#   # get TF names
#   TF <- char_vector[sort(c( idx +1, idx + 2, idx + 4))]
#   TF <- TF[-grep("LOGO_|rdf:type",TF)]
#   TF <- gsub("  rdfs:label | ;| rdfs:subClassOf <http://sybig.de/tfclass#|>","",TF)
#   TF <- stringr::str_trim(gsub('"', '', TF))
#   TF <- tibble::as.tibble(t(matrix(TF,nrow = 2)))
#   colnames(TF) <- c("Gene", "class")
# 
#   # Get family and subfamily classification
#   family.pattern <-  "^<http://sybig.de/tfclass#[0-9]+\\.[0-9]+\\.[0-9]+>"
# 
#   idx <- grep(family.pattern,char_vector)
#   family.names <- char_vector[ sort(c(idx,idx+ 2))]
#   family.names <- gsub("  rdfs:label | ;| rdfs:subClassOf <http://sybig.de/tfclass#|>|<http://sybig.de/tfclass#| rdf:type owl:Class","",family.names)
#   family.names <- stringr::str_trim(gsub('"', '', family.names))
#   family.names <- tibble::as.tibble(t(matrix(family.names,nrow = 2)))
#   colnames(family.names) <- c("family", "family.name")
# 
# 
#   subfamily.pattern <-  "^<http://sybig.de/tfclass#[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+>"
# 
#   idx <- grep(subfamily.pattern,char_vector)
#   subfamily.names <- char_vector[ sort(c(idx,idx+ 2))]
#   subfamily.names <- gsub("  rdfs:label | ;| rdfs:subClassOf <http://sybig.de/tfclass#|>|<http://sybig.de/tfclass#| rdf:type owl:Class","",subfamily.names)
#   subfamily.names <- stringr::str_trim(gsub('"', '', subfamily.names))
#   subfamily.names <- tibble::as.tibble(t(matrix(subfamily.names,nrow = 2)))
#   colnames(subfamily.names) <- c("subfamily", "subfamily.name")
#   subfamily.names$family <- stringr::str_sub(subfamily.names$subfamily,1,5)
# 
#   classification <- left_join(family.names,subfamily.names)
#   classification$class <- ifelse(is.na(classification$subfamily),classification$family,classification$subfamily)
# 
#   # Add classification to TF list
#   TFclass <- left_join(TF,classification)
# 
#   # Break ( into multiple cases)
#   m <- grep("\\(|/",TFclass$Gene)
#   df <- NULL
#   for(i in m){
#     gene <- sort(stringr::str_trim(unlist(stringr::str_split(TFclass$Gene[i],"\\(|,|\\)|/"))))
#     gene <- gene[stringr::str_length(gene) > 0]
#     aux <- TFclass[rep(i,length(gene)),]
#     aux$Gene <- gene
#     df <- rbind(df,aux)
#   }
#   TFclass <- rbind(TFclass,df)
#   TFclass <- TFclass[!duplicated(TFclass),]
# 
#   # Break ( into multiple cases)
#   m <- grep("-",TFclass$Gene)
#   df <- NULL
#   for(i in m){
#     gene <- gsub("-","",sort(stringr::str_trim(unlist(stringr::str_split(TFclass$Gene[i],"\\(|,|\\)|/")))))
#     gene <- gene[stringr::str_length(gene) > 0]
#     aux <- TFclass[rep(i,length(gene)),]
#     aux$Gene <- gene
#     df <- rbind(df,aux)
#   }
#   TFclass <- rbind(TFclass,df)
# 
#   df <- NULL
#   for(i in 1:length(TFclass$Gene)){
#     m <- TFclass$Gene[i]
#     gene <- unique(c(toupper(alias2Symbol(toupper(m))),toupper(m),toupper(alias2Symbol(m))))
#     if(all(gene %in% TFclass$Gene)) next
#     aux <- TFclass[rep(i,length(gene)),]
#     aux$Gene <- gene
#     df <- rbind(df,aux)
#   }
#   TFclass <- rbind(TFclass,df)
#   TFclass <- TFclass[!duplicated(TFclass),]
#   TFclass <- TFclass[TFclass$Gene %in% human.TF$external_gene_name,]
#   save(TFclass,file = "TFClass.rda")
#   return(TFclass)
# }
# TF.family <- createMotifRelevantTfs("family")
# TF.family <- updateTFClassList(TF.family,"family")
# TF.subfamily <- createMotifRelevantTfs("subfamily")
# TF.subfamily <- updateTFClassList(TF.subfamily,classification = "subfamily")
# save(TF.family,file = "~/ELMER.data/data/TF.family.rda", compress = "xz")
# save(TF.subfamily,file = "~/ELMER.data/data/TF.subfamily.rda", compress = "xz")

## ----eval=FALSE, include=TRUE-------------------------------------------------
# hocomoco.table <- "http://hocomoco11.autosome.ru/human/mono?full=true" %>% read_html()  %>%  html_table()
# hocomoco.table <- hocomoco.table[[1]]
# save(hocomoco.table,file = "data/hocomoco.table.rda", compress = "xz")

## -----------------------------------------------------------------------------
data("Probes.motif.hg19.450K")
dim(Probes.motif.hg19.450K)
str(Probes.motif.hg19.450K)

## -----------------------------------------------------------------------------
data("Probes.motif.hg38.450K")
dim(Probes.motif.hg38.450K)
str(Probes.motif.hg38.450K)

## -----------------------------------------------------------------------------
data("Probes.motif.hg19.EPIC")
dim(Probes.motif.hg19.EPIC)
str(Probes.motif.hg19.EPIC)

## -----------------------------------------------------------------------------
data("Probes.motif.hg38.EPIC")
dim(Probes.motif.hg38.EPIC)
str(Probes.motif.hg38.EPIC)

## ----eval=FALSE, include=TRUE-------------------------------------------------
# getInfiniumAnnotation <- function(plat = "450K", genome = "hg38"){
#   message("Loading object: ",file)
#   newenv <- new.env()
#   if(plat == "EPIC" & genome == "hg19") data("EPIC.hg19.manifest", package = "ELMER.data",envir=newenv)
#   if(plat == "EPIC" & genome == "hg38") data("EPIC.hg38.manifest", package = "ELMER.data",envir=newenv)
#   if(plat == "450K" & genome == "hg19") data("hm450.hg19.manifest", package = "ELMER.data",envir=newenv)
#   if(plat == "450K" & genome == "hg38") data("hm450.hg38.manifest", package = "ELMER.data",envir=newenv)
#   annotation <- get(ls(newenv)[1],envir=newenv)
#   return(annotation)
# }
# # To find for each probe the know motif we will use HOMER software (http://homer.salk.edu/homer/)
# # Step:
# # 1 - get DNA methylation probes annotation with the regions
# # 2 - Make a bed file from it
# # 3 - Execute section: Finding Instance of Specific Motifs from http://homer.salk.edu/homer/ngs/peakMotifs.html to the HOCOMOCO TF motifs
# # Also, As HOMER is using more RAM than the available we will split the files in to 100k probes.
# # Obs: for each probe we create a winddow of 500 bp (-size 500) around it. This might lead to false positives, but will not have false negatives.
# # The false posives will be removed latter with some statistical tests.
# TFBS.motif <- "http://hocomoco11.autosome.ru/final_bundle/hocomoco11/full/HUMAN/mono/HOCOMOCOv11_full_HUMAN_mono_homer_format_0.0001.motif"
# if(!file.exists(basename(TFBS.motif))) downloader::download(TFBS.motif,basename(TFBS.motif))
# for(plat in c("EPIC","450K")){
#   for(gen in c("hg38","hg19")){
# 
#     file <- paste0(plat,gen,".txt")
#     print(file)
#     if(!file.exists(file)){
#       # STEP 1
#       gr <- getInfiniumAnnotation(plat = plat,genome =  gen)
# 
#       # This will remove masked probes. They have poor quality and might be arbitrarily positioned (Wanding Zhou)
#       gr <- gr[!gr$MASK_general]
# 
#       df <- data.frame(seqnames=seqnames(gr),
#                        starts=as.integer(start(gr)),
#                        ends=end(gr),
#                        names=names(gr),
#                        scores=c(rep(".", length(gr))),
#                        strands=strand(gr))
#       step <- 10000 # nb of lines in each file. 10K was selected to not explode RAM
#       n <- nrow(df)
#       pb <- txtProgressBar(max = floor(n/step), style = 3)
# 
#       for(j in 0:floor(n/step)){
#         setTxtProgressBar(pb, j)
#         # STEP 2
#         file.aux <- paste0(plat,gen,"_",j,".bed")
#         if(!file.exists(gsub(".bed",".txt",file.aux))){
#           end <- ifelse(((j + 1) * step) > n, n,((j + 1) * step))
#           write.table(df[((j * step) + 1):end,], file = file.aux, col.names = F, quote = F,row.names = F,sep = "\t")
# 
#           # STEP 3 use -mscore to get scores
#           cmd <- paste("source ~/.bash_rc; annotatePeaks.pl" ,file.aux, gen, "-m", basename(TFBS.motif), "-size 500 -cpu 12 >", gsub(".bed",".txt",file.aux))
#           system(cmd)
#         }
#       }
#     }
#     close(pb)
#     # We will merge the results from each file into one
#     peaks <- NULL
#     pb <- txtProgressBar(max = floor(n/step), style = 3)
#     for(j in 0:floor(n/step)){
#       setTxtProgressBar(pb, j)
#       aux <-  readr::read_tsv(paste0(plat,gen,"_",j,".txt"))
#       colnames(aux)[1] <- "PeakID"
#       if(is.null(peaks)) {
#         peaks <- aux
#       } else {
#         peaks <- rbind(peaks, aux)
#       }
#     }
#     close(pb)
#     print("Writing file...")
#     readr::write_tsv(peaks,path=file,col_names = TRUE)
#     print("DONE!")
#     gc()
#   }
# }
# 
# getMatrix <- function(filename) {
#   motifs <- readr::read_tsv(file)
#   # From 1 to 21 we have annotations
#   matrix <- Matrix::Matrix(0, nrow = nrow(motifs), ncol = ncol(motifs) - 21 ,sparse = TRUE)
#   colnames(matrix) <- gsub(" Distance From Peak\\(sequence,strand,conservation\\)","",colnames(motifs)[-c(1:21)])
#   rownames(matrix) <- motifs$PeakID
#   matrix[!is.na(motifs[,-c(1:21)])] <- 1
#   matrix <- as(matrix, "nsparseMatrix")
#   return(matrix)
# }
# 
# for(plat in c("EPIC","450K")){
#   for(gen in c("hg19","hg38")){
#     file <- paste0(plat,gen,".txt")
# 
#     if(file == "450Khg19.txt"){
#       if(file.exists("Probes.motif.hg19.450K.rda")) next
#       Probes.motif.hg19.450K <- getMatrix(file)
#       save(Probes.motif.hg19.450K, file = "Probes.motif.hg19.450K.rda", compress = "xz")
#       rm(Probes.motif.hg19.450K)
#     }
#     if(file == "450Khg38.txt"){
#       if(file.exists("Probes.motif.hg38.450K.rda")) next
#       Probes.motif.hg38.450K <- getMatrix(file)
#       save(Probes.motif.hg38.450K, file = "Probes.motif.hg38.450K.rda", compress = "xz")
#       rm(Probes.motif.hg38.450K)
#     }
# 
#     if(file == "EPIChg19.txt"){
#       if(file.exists("Probes.motif.hg19.EPIC.rda")) next
#       Probes.motif.hg19.EPIC <- getMatrix(file)
#       save(Probes.motif.hg19.EPIC, file = "Probes.motif.hg19.EPIC.rda", compress = "xz")
#       rm(Probes.motif.hg19.EPIC)
#     }
# 
#     if(file == "EPIChg38.txt"){
#       if(file.exists("Probes.motif.hg38.EPIC.rda")) next
# 
#       Probes.motif.hg38.EPIC <- getMatrix(file)
#       save(Probes.motif.hg38.EPIC, file = "Probes.motif.hg38.EPIC.rda", compress = "xz")
#       rm(Probes.motif.hg38.EPIC)
#     }
#   }
# }

## -----------------------------------------------------------------------------
data("Probes.motif.hg19.450K")
as.data.frame(as.matrix(Probes.motif.hg19.450K[1:20,1:20])) %>% 
  datatable(options = list(scrollX = TRUE,pageLength = 5)) 

## ----eval=FALSE, include=TRUE-------------------------------------------------
# human.TF <- readr::read_csv("http://humantfs.ccbr.utoronto.ca/download/v_1.01/DatabaseExtract_v_1.01.csv")
# human.TF <- human.TF[human.TF$`Is TF?` == "Yes",]
# colnames(human.TF)[1:2] <- c("ensembl_gene_id","external_gene_name")
# save(human.TF,file = "~/ELMER.data/data/human.TF.rda",compress = "xz")

## -----------------------------------------------------------------------------
data("human.TF")
as.data.frame(human.TF) %>% 
  datatable(options = list(scrollX = TRUE,pageLength = 5)) 

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

