# Code example from 'QuantificationBenchmark' vignette. See references/ for full tutorial.

## ----experimentPrep, eval=FALSE--------------------------------------------
#  
#  library(BiocParallel)
#  dir.create("fastq", showWarnings=FALSE)
#  
#  extractSRA <- function( sra_accession, exe_path = 'fastq-dump',
#                          args = '--split-3 --gzip', outdir = 'fastq',
#                          dry_run = FALSE)
#  {
#      cmdline = sprintf('%s %s --outdir %s %s',
#                        exe_path, args, outdir, sra_accession)
#      if(dry_run) {
#        message("will run with this command line:\n",cmdline)
#      } else {
#        return( system( cmdline ) )
#      }
#  }
#  
#  samples <- c( "SRR5273705", "SRR5273689", "SRR5273699", "SRR5273683" )
#  
#  bplapply( samples, extractSRA, BPPARAM=MulticoreParam(4) )
#  
#  annotation <-
#      data.frame(
#          samples,
#          tissue=c("brain", "brain", "heart", "heart" ) )
#  

## ----downloadReference, eval=FALSE-----------------------------------------
#  dir.create("reference/raw", recursive=TRUE, showWarnings=FALSE)
#  download.file("ftp://ftp.sanger.ac.uk/pub/gencode/Gencode_mouse/release_M16/gencode.vM16.transcripts.fa.gz",
#                destfile="reference/raw/transcriptome.fa.gz")

## ----indexBuild, eval=FALSE------------------------------------------------
#  
#  dir.create("reference/index", showWarnings=FALSE)
#  
#  system("kallisto index -i reference/index/kallistoIdx.idx reference/raw/transcriptome.fa.gz")
#  system("salmon index -t reference/raw/transcriptome.fa.gz -i reference/index/salmon_index")
#  system("gunzip -c reference/raw/transcriptome.fa.gz > reference/raw/transcriptome.fa && sailfish index -t reference/raw/transcriptome.fa -o reference/index/sailfish_index")
#  
#  library(Biostrings)
#  dnSt <- names( readDNAStringSet("reference/raw/transcriptome.fa.gz") )
#  dnSt <- sapply( strsplit( dnSt, "\\||\\." ), "[[", 1 )
#  

## ----versions, eval=FALSE--------------------------------------------------
#  
#  library(SummarizedBenchmark)
#  
#  getKallistoVersion <- function(){
#      vers <-
#        suppressWarnings( system( "kallisto", intern=TRUE )[1] )
#      strsplit( vers, " " )[[1]][2]
#  }
#  
#  getSalmonVersion <- function(){
#      vers <-
#        suppressWarnings( system( "salmon --version 2>&1", intern=TRUE)[1] )
#      strsplit( vers, " " )[[1]][2]
#  }
#  
#  getSailfishVersion <- function(){
#      vers <-
#        suppressWarnings( system( "sailfish --version 2>&1", intern=TRUE)[1] )
#      strsplit( vers, " " )[[1]][3]
#  }
#  

## ---- eval=FALSE-----------------------------------------------------------
#  
#  dir.create("out/kallisto", showWarnings=FALSE)
#  dir.create("out/salmon", showWarnings=FALSE)
#  dir.create("out/sailfish", showWarnings=FALSE)
#  
#  runKallisto <- function( sample, args="" ){
#      fastqFile1 <- sprintf( "fastq/%s_1.fastq.gz", sample )
#      fastqFile2 <- gsub( "_1", "_2", fastqFile1 )
#      output <- sprintf("out/kallisto/%s.out", sample)
#      cmd <- sprintf( "kallisto quant -i reference/index/kallistoIdx.idx -o %s %s %s %s",
#                      output, args, fastqFile1, fastqFile2 )
#      system( cmd )
#      require(tximport)
#      ab <-
#        tximport( file.path(output, "abundance.h5"),
#                  type="kallisto", txOut=TRUE )
#      counts <- ab$counts[,1]
#      names(counts) <-
#        sapply( strsplit( names( counts ), "\\||\\." ), "[[", 1 )
#      counts
#  }
#  
#  runSalmon <- function( sample, args="-l A -p 4" ){
#      fastqFile1 <- sprintf( "fastq/%s_1.fastq.gz", sample )
#      fastqFile2 <- gsub( "_1", "_2", fastqFile1 )
#      output <- sprintf("out/salmon/%s.out", sample)
#      cmd <- sprintf("salmon quant -i reference/index/salmon_index %s -o %s -1 %s -2 %s",
#                     args, output, fastqFile1, fastqFile2)
#      system( cmd )
#      require(tximport)
#      counts <-
#        tximport( file.path( output, "quant.sf" ),
#                  type="salmon", txOut=TRUE )$counts[,1]
#      names( counts ) <-
#        sapply( strsplit( names( counts ), "\\||\\." ), "[[", 1 )
#      counts
#  }
#  
#  runSailfish <- function( sample, args="-l IU" ){
#      fastqFile1 <- sprintf( "fastq/%s_1.fastq.gz", sample )
#      fastqFile2 <- gsub( "_1", "_2", fastqFile1 )
#      output <- sprintf("out/sailfish/%s.out", sample)
#      cmd <- sprintf( "echo \"sailfish quant -i reference/index/sailfish_index %s -o %s -1 <(zcat %s) -2 <(zcat %s)\" | bash",
#                      args, output, fastqFile1, fastqFile2 )
#      cat(cmd)
#      system( cmd )
#      counts <-
#        tximport( file.path(output, "quant.sf"),
#                  type="sailfish", txOut=TRUE )$counts[,1]
#      names( counts ) <-
#        sapply( strsplit( names( counts ), "\\||\\." ), "[[", 1 )
#      counts
#  }
#  

## ---- eval=FALSE-----------------------------------------------------------
#  
#  library(SummarizedBenchmark)
#  library(tximport)
#  
#  b <- BenchDesign() %>%
#      addMethod(label = "kallisto-default",
#                func = runKallisto,
#                params = rlang::quos(sample = sample,
#                                     args = "-t 16"),
#                meta = list(version = rlang::quo(getKallistoVersion()))
#                ) %>%
#      addMethod(label = "kallisto-bias",
#               func = runKallisto,
#               params = rlang::quos(sample = sample,
#                                    args = "--bias -t 16"),
#               meta = list(version = rlang::quo(getKallistoVersion()))
#               ) %>%
#     addMethod(label = "salmon-default",
#               func = runSalmon,
#               params = rlang::quos(sample = sample,
#                                    args = "-l IU -p 16"),
#               meta = list(version = rlang::quo(getSalmonVersion()))
#               ) %>%
#     addMethod(label = "salmon-gcBias",
#               func = runSalmon,
#               params = rlang::quos(sample=sample,
#                                    args="-l IU --gcBias -p 16"),
#               meta = list(version = rlang::quo(getSalmonVersion()))
#               ) %>%
#     addMethod(label = "sailfish-default",
#               func = runSailfish,
#               params = rlang::quos(sample=sample,
#                                    args="-l IU -p 16"),
#               meta = list(version = rlang::quo(getSailfishVersion()))
#               )
#  
#  printMethods(b)

## ----runBenchmark, eval=FALSE----------------------------------------------
#  
#  dat <- list(txIDs=dnSt)
#  allSB <- lapply(samples, function(sample) {
#      dat[["sample"]] <- sample
#      sb <- buildBench( b, data=dat, sortIDs="txIDs",
#                       catchErrors=FALSE, parallel=TRUE,
#                       BPPARAM=SerialParam() )
#      colData( sb )$sample <- sample
#      colData( sb )$tissue <-
#                      as.character( annotation$tissue[annotation$sample == sample] )
#      sb
#  } )
#  
#  

## ----subsample, eval=FALSE-------------------------------------------------
#  
#  keepRows <- rowSums(
#      sapply( allSB,
#             function(x){
#                 rowSums( is.na( assay( x ) ) )
#             }) ) == 0
#  allSB <- lapply( allSB,
#                  function(x){
#                      x[keepRows,]
#                  } )
#  
#  set.seed(12)
#  keepRows <- sample(
#      seq_len(nrow(allSB[[1]])), 50000 )
#  
#  allSB <- lapply( allSB,
#                  function(x){
#                      x[keepRows,]
#                  } )
#  
#  #save(allSB, file="../data/quantSB.rda",
#  #     compress="xz", compression_level=9 )
#  

## ----loadSB, message=FALSE-------------------------------------------------
library(SummarizedBenchmark)
data("quantSB")

## ----metadata--------------------------------------------------------------
colData(allSB[[1]])[,c("param.args", "meta.version", "sample", "tissue")]

## ----pcaPlot---------------------------------------------------------------

keep <- !rowSums( is.na( assays( allSB[[1]] )[["default"]] ) ) > 0

pcaRes <- 
  prcomp(  log10( t( assays( allSB[[1]] )[["default"]][keep,] ) + 1 ) )
varExp <- round( 100*(pcaRes$sdev/sum( pcaRes$sdev )), 2)

tidyData <- data.frame( 
  PC1=pcaRes$x[,"PC1"], 
  PC2=pcaRes$x[,"PC2"], 
  sample=colData( allSB[[1]] )$sample, 
  label=gsub("\\d+$", "", rownames( colData(allSB[[1]]) ) ) )

tidyData <- tidyData %>%
  dplyr::mutate( 
             method=gsub( "-.*$", "", label) )


tidyData %>%
  ggplot( aes( PC1, PC2, colour=label ) ) +
  geom_point() + coord_fixed() +
  ylab(sprintf( "PC2 (%0.2f %%)", varExp[2]) ) +
  xlab(sprintf( "PC1 (%0.2f %%)", varExp[1]) ) +
  theme(legend.pos="top") +
  guides(col = guide_legend(nrow = 5), 
         shape = guide_legend(nrow = 4))


## ----rnaseqcomp, message=FALSE---------------------------------------------
library( rnaseqcomp )
library( biomaRt )
data( simdata )
houseHuman <- simdata$meta$gene[simdata$meta$house]
houseHuman <- gsub("\\.\\d+", "", houseHuman )

mart <- useMart( "ensembl", "mmusculus_gene_ensembl" )
geneMap <- getBM( c( "ensembl_transcript_id", 
                     "hsapiens_homolog_ensembl_gene", 
                     "hsapiens_homolog_orthology_type" ), 
                  mart=mart )
geneMap <- 
  geneMap[geneMap$`hsapiens_homolog_orthology_type` == "ortholog_one2one",]
houseMouse <- 
  geneMap$ensembl_transcript_id[geneMap$hsapiens_homolog_ensembl_gene %in% 
                                  houseHuman]

allSB <- do.call( cbind, allSB )
colData( allSB )$label <- gsub("\\d+$", "", rownames( colData( allSB ) ) )

condInfo <- 
    colData( allSB )[colData( allSB )$label == "kallisto-default","tissue"]


replicateInfo <- condInfo
evaluationFeature <- rep( TRUE, length.out = nrow( allSB ) )

calibrationFeature <- rownames(allSB) %in% houseMouse

unitReference <- 1
quantificationList <- lapply( 
  split( seq_along( colnames( allSB ) ), colData( allSB )$label ), 
  function(x){
    assay( allSB )[,x]
  } )

compObject <- signalCalibrate( 
  quantificationList, 
  factor(condInfo), factor(replicateInfo), 
  evaluationFeature, calibrationFeature, unitReference, 
  calibrationFeature2 = calibrationFeature)

compObject

