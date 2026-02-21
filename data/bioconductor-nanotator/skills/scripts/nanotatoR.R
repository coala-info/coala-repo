# Code example from 'nanotatoR' vignette. See references/ for full tutorial.

## ----eval=FALSE----------------------------------------------------------
#  if (!requireNamespace("BiocManager", quietly = TRUE))
#      install.packages("BiocManager")
#  BiocManager::install("nanotatoR", version = "3.8")

## ----eval=TRUE-----------------------------------------------------------
library("nanotatoR")

## ----eval=TRUE-----------------------------------------------------------
decipherpath <- system.file("extdata", "population_cnv.txt", package = "nanotatoR")
smapName <- "F1.1_TestSample1_solo_hg19.smap"
smappath <- system.file("extdata", package = "nanotatoR")
win_indel=10000;win_inv_trans=50000;perc_similarity=0.5
decipherext<-Decipher_extraction(decipherpath, input_fmt = "Text", smappath, 
smap= smapName,
win_indel = 10000, perc_similarity = 0.5, returnMethod="dataFrame")

## ----eval=TRUE-----------------------------------------------------------
mergedFiles <- system.file("extdata", "BNSOLO2_merged.txt", package = "nanotatoR")
smapName <- "F1.1_TestSample1_solo_hg19.smap"
smappath <- system.file("extdata",  package = "nanotatoR")
win_indel = 10000; win_inv_trans = 50000; perc_similarity = 0.5;
indelconf = 0.5; invconf = 0.01;transconf = 0.1
cohortFreq<-cohortFrequency(internalBNDB = mergedFiles , smappath , 
smap=smapName, input_fmt ="Text", buildBNInternalDB=FALSE, win_indel, win_inv_trans, 
perc_similarity , indelconf, invconf, transconf,returnMethod="dataFrame")

## ----eval=TRUE-----------------------------------------------------------
mergedFiles <- system.file("extdata", "nanotatoR_merged.txt", package = "nanotatoR")
smapName <- "F1.1_TestSample1_solo_hg19.smap"
smappath <- system.file("extdata",  package = "nanotatoR")
intFreq <- internalFrequency(mergedFiles = mergedFiles, smappath = smappath ,
smap = smapName, buildSVInternalDB=FALSE, win_indel=10000, 
win_inv_trans=50000, 
perc_similarity=0.5, indelconf=0.5, invconf=0.01, 
transconf=0.1, limsize=1000, win_indel_parents=5000,input_fmt="Text",
win_inv_trans_parents=40000,
returnMethod="dataFrame")
intFreq [1,]

## ----eval=TRUE-----------------------------------------------------------
smapName="F1.1_TestSample1_solo_hg19.smap"
smap = system.file("extdata", smapName, package="nanotatoR")
bedFile <- system.file("extdata", "Homo_sapiens.Hg19_BN_bed.txt", package="nanotatoR")
outpath <- system.file("extdata",  package="nanotatoR")
datcomp <- compSmapbed(smap, bed=bedFile, inputfmtBed =  "BNBED", n = 3, returnMethod_bedcomp = c("dataFrame"))
datcomp[1,]

## ----eval=TRUE-----------------------------------------------------------
 terms="Muscle Weakness"
 gene <- gene_list_generation(method="Single", term=terms, returnMethod="dataFrame")
 gene[1:10,]

## ----eval=FALSE----------------------------------------------------------
#  terms <- "Muscle Weakness"
#  gene <- gene_list_generation(
#  method = "Single", term = terms,
#  returnMethod_GeneList = "dataFrame"
#  )
#  RzipFile = "zip.exe"
#  RZIPpath <- system.file("extdata", RzipFile, package = "nanotatoR")
#  smapName <- "F1.1_TestSample1_solo_hg19.smap"
#  smappath <- system.file("extdata", smapName, package = "nanotatoR")
#  smappath1 <- system.file("extdata", package = "nanotatoR")
#  run_bionano_filter(input_fmt_geneList = c("dataframe"),
#  input_fmt_svMap = c("Text"),
#  SVFile = smappath, dat_geneList = gene,
#  outpath = smappath1, outputFilename = "test",
#  RZIPpath = RZIPpath)

## ----eval=FALSE----------------------------------------------------------
#  terms <- "Muscle Weakness"
#  gene <- gene_list_generation(
#  method = "Single", term = terms,
#  returnMethod = "dataFrame"
#  )
#  mergedFiles <- system.file ("extdata", "BNSOLO2_merged.txt",
#  package = "nanotatoR")
#  RzipFile = "zip.exe"
#  RZIPpath <- system.file("extdata", RzipFile, package = "nanotatoR")
#  smapName <- "F1.1_TestSample1_solo_hg19.smap"
#  smappath <- system.file("extdata", smapName, package = "nanotatoR")
#  path <- system.file("extdata", "SoloFile/", package = "nanotatoR")
#  hgpath <- system.file ("extdata", "GRCh37_hg19_variants_2016-05-15.txt", package = "nanotatoR")
#  decipherpath <- system.file("extdata", "population_cnv.txt", package = "nanotatoR")
#  bedFile <- system.file("extdata", "Homo_sapiens.Hg19.bed", package="nanotatoR")
#  pattern <- "_hg19.smap"
#  nanotatoR_main(smap = smappath, bed = bedFile,
#  inputfmtBed = c("BNBED"),
#  n = 3,  buildSVInternalDB = TRUE, soloPath = path, solopattern = pattern,
#  input_fmt_INF = c("dataFrame"), buildBNInternalDB = FALSE,
#  returnMethod_bedcomp = c("dataFrame"), returnMethod_DGV = c("dataFrame"),
#  returnMethod_Internal = c("dataFrame"), input_fmt_DGV = c("dataFrame"),
#  hgpath = hgpath, smapName = smapName, limsize=1000, win_indel_parents=5000,
#  decipherpath = decipherpath, dbOutput_Int = "dataframe",
#  win_inv_trans_parents=40000, win_indel_DGV = 10000,
#  input_fmt_geneList = c("dataFrame"), input_fmt_svMap = c("dataFrame"),
#  input_fmt_decipher = "dataFrame",input_fmt_BN = "dataFrame",
#  returnMethod_GeneList = c("dataFrame"),returnMethod_BNCohort =  c("dataFrame"),
#  returnMethod_decipher = c("dataFrame"), mergedFiles_BN = mergedFiles,
#  dat_geneList = gene , method_entrez = "",
#  outpath = smappath, outputFilename = "test",
#  RZIPpath = RZIPpath)

