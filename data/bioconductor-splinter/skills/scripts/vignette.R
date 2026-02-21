# Code example from 'vignette' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(SPLINTER)

## ----message=FALSE------------------------------------------------------------
library(BSgenome.Mmusculus.UCSC.mm9)
library(GenomicFeatures)
bsgenome <- BSgenome.Mmusculus.UCSC.mm9

## ----message=FALSE------------------------------------------------------------
data_path<-system.file("extdata",package="SPLINTER")
gtf_file<-paste(data_path,"/Mus_musculus.Ensembl.NCBIM37.65.partial.gtf",sep="")

library(txdbmaker)
txdb <- makeTxDbFromGFF(file=gtf_file,chrominfo = Seqinfo(genome="mm9"))

# txdb generation can take quite long, you can save the object and load it the next time
# saveDb(txdb,file="txdb_hg19.sqlite")
# txdb<-loadDb(file="txdb_hg19.sqlite")

# extract CDS and exon information from TxDb object
thecds<-cdsBy(txdb,by="tx",use.names=TRUE)
theexons<-exonsBy(txdb,by="tx",use.names=TRUE)

## -----------------------------------------------------------------------------
typeofAS="SE"
mats_file<-paste(data_path,"/skipped_exons.txt",sep="")
splice_data <-extractSpliceEvents(data=mats_file, filetype='mats', splicetype=typeofAS)
splice_data$data[,c(1:10)]

## -----------------------------------------------------------------------------
splice_data<-addEnsemblAnnotation(data=splice_data,species="mmusculus")

# (Optional) Sorting the dataframe, if you have supporting statistical information
splice_data$data<-splice_data$data[with(splice_data$data,order(FDR,-IncLevelDifference)),]
head(splice_data$data[,c(1:10)])

## -----------------------------------------------------------------------------
single_id='Prmt5'
pp<-which(grepl(single_id,splice_data$data$Symbol)) # Prmt5 has 1 record

splice_data$data[pp,c(1:6)] # show all records

single_record<-splice_data$data[pp[1],]

## -----------------------------------------------------------------------------
valid_tx <- findTX(id=single_record$ID,tx=theexons,db=txdb)

valid_cds<- findTX(id=single_record$ID,tx=thecds,db=txdb)

## -----------------------------------------------------------------------------
roi <- makeROI(single_record,type="SE")
roi

## -----------------------------------------------------------------------------
compatible_tx<- findCompatibleEvents(valid_tx,roi=roi,verbose=TRUE)

compatible_cds<- findCompatibleEvents(valid_cds,valid_tx,roi=roi,verbose=TRUE)


## -----------------------------------------------------------------------------
region_minus_exon <-removeRegion(compatible_cds$hits[[1]],roi)

## -----------------------------------------------------------------------------
# Not relevant for this Prmt5 skipped exon example
region_plus_exon <-insertRegion(region_minus_exon,roi)

## -----------------------------------------------------------------------------
event<-eventOutcomeCompare(seq1=compatible_cds$hits[[1]],seq2=region_minus_exon,
                    genome=bsgenome,direction=TRUE,fullseq=FALSE)

event

## -----------------------------------------------------------------------------
aa<-getRegionDNA(roi,bsgenome) 
aa

## ----eval=FALSE---------------------------------------------------------------
# primers<-callPrimer3(seq=aa$seq,sequence_target = aa$jstart,size_range='100-500')

## -----------------------------------------------------------------------------
primers[,c(1:4)]

## -----------------------------------------------------------------------------
primers <- data.frame(PRIMER_LEFT_SEQUENCE="ACTTTCGGACTCTGTGTGACT",
                      PRIMER_RIGHT_SEQUENCE="TCATAGGCATTGGGTGGAGG",
                      stringsAsFactors=FALSE)

## -----------------------------------------------------------------------------
cp<-checkPrimer(primers[1,],bsgenome,roi)

cp

## -----------------------------------------------------------------------------
pcr_result1<-getPCRsizes(cp,theexons)
pcr_result1

tx_minus_exon <-removeRegion(compatible_tx$hits[[1]],roi)
pcr_result2<-getPCRsizes(cp,tx_minus_exon)
pcr_result2

## -----------------------------------------------------------------------------
relevant_pcr_bands<-splitPCRhit(pcr_result1,compatible_tx)

relevant_pcr_bands

## -----------------------------------------------------------------------------
# reading in BAM files
mt<-paste(data_path,"/mt_chr14.bam",sep="")
wt<-paste(data_path,"/wt_chr14.bam",sep="")

# Plotting genomic range, read density and splice changes
eventPlot(transcripts=theexons,roi_plot=roi,bams=c(wt,mt),names=c('wt','mt'),
          annoLabel=single_id,rspan=2000)

# Barplot of PSI values if provided
psiPlot(single_record)

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

