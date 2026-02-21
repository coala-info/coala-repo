# Code example from 'methylPipe' vignette. See references/ for full tutorial.

## ----options,echo=FALSE-----------------------------------------------
options(width=72)

## ----mpload,message=FALSE,cache=TRUE----------------------------------
library(methylPipe)
library(BSgenome.Hsapiens.UCSC.hg18)

## ----methcall,message=FALSE,cache=TRUE--------------------------------
file_loc <- system.file('extdata', 'test_methcall', package='methylPipe')
meth.call(files_location=file_loc, output_folder=tempdir(), no_overlap=TRUE, 
          read.context="CpG", Nproc=1)

## ----bsprepare,message=FALSE,cache=TRUE-------------------------------
file_loc <- system.file('extdata', 'H1_chr20_CG_10k.txt', package='methylPipe')
#BSprepare(files_location=file_loc,output_folder=file_loc, tabix="/path-to-tabix/")
uncov_GR <- GRanges(Rle('chr20'), IRanges(c(14350,69251,84185), c(18349,73250,88184)))
H1data <- system.file('extdata', 'H1_chr20_CG_10k_tabix_out.txt.gz', 
                      package='methylPipe')
H1.db <- BSdata(file=H1data, uncov=uncov_GR, org=Hsapiens)
H1.db

## ----bsdataset,message=TRUE,cache=TRUE--------------------------------
IMR90data <- system.file('extdata', 'IMR90_chr20_CG_10k_tabix_out.txt.gz', 
                         package='methylPipe')
IMR90.db <- BSdata(file=IMR90data, uncov=uncov_GR, org=Hsapiens)
H1.IMR90.set <- BSdataSet(org=Hsapiens, group=c("C","E"), IMR90=IMR90.db, H1=H1.db)
H1.IMR90.set

## ----met1,fig.width=6,fig.height=5,out.width='.85\\textwidth',message=FALSE,cache=TRUE----
gr <- GRanges("chr20",IRanges(1,5e5))
sres <- mCsmoothing(H1.db, gr, Scorefun='sum', Nbins=50, plot=TRUE)

## ----desstats,fig.width=6,fig.height=5,out.width='.85\\textwidth',message=FALSE, fig.keep="all",fig.show="asis",cache=TRUE----
stats.set <- BSdataSet(org=Hsapiens, group=c("C","C","E","E"), IMR_1=IMR90.db, 
IMR_2=IMR90.db, H1_1=H1.db,H1_2=H1.db)
stats_res <- methstats(stats.set,chrom="chr20",mcClass='mCG', Nproc=1)
stats_res

## ----met2,message=FALSE,cache=TRUE------------------------------------
gr_file <- system.file('extdata', 'GR_chr20.Rdata', package='methylPipe')
load(gr_file)
resmC <- mapBSdata2GRanges(GenoRanges=GR_chr20, Sample=H1.db, context='CG')
head(resmC[[4]])

## ----met3,message=FALSE,cache=TRUE------------------------------------
gec.H1 <- profileDNAmetBin(GenoRanges=GR_chr20, Sample=H1.db, mcCLASS='mCG', nbins=3)
binmC(gec.H1)[4:5,]
binC(gec.H1)[4:5,]
binrC(gec.H1)[4:5,]

## ----subset,message=FALSE,cache=TRUE----------------------------------
gec1 <- gec.H1[start(gec.H1) < 153924]
gec2 <- gec.H1[start(gec.H1) > 153924]

## ----gecset,message=FALSE,cache=TRUE----------------------------------
gecIMR_file <- system.file('extdata', 'gec.IMR90.Rdata', package='methylPipe')
load(gecIMR_file)
gel <- GElist(gecIMR90=gec.IMR90, gecH1=gec.H1)
print(names(gel))

## ----pmeth,fig.width=5,fig.height=5,out.width='.85\\textwidth',message=FALSE,cache=TRUE----
library(TxDb.Hsapiens.UCSC.hg18.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg18.knownGene
gel <- GElist(gecIMR90=gec.IMR90[1:10], gecH1=gec.H1[1:10])
plotMeth(gel, colors=c("red","blue"), datatype=c("mC","mC"), yLim=c(.025, .025), brmeth=list(IMR90=IMR90.db, H1=H1.db),
         mcContext="CG", transcriptDB=txdb, chr="chr20", start=14350, end=277370, org=Hsapiens)

## ----dmr1,message=FALSE,cache=TRUE------------------------------------
DMRs <- findDMR(object= H1.IMR90.set, Nproc=1, ROI=GR_chr20, MCClass='mCG',
     dmrSize=6, dmrBp=800)
head(DMRs)

## ----dmr2,message=FALSE,cache=TRUE------------------------------------
hyper.DMRs.conso <- consolidateDMRs(DmrGR=DMRs, pvThr=0.05, GAP=100, type="hyper")
hyper.DMRs.conso[1:4]

## ----info,echo=TRUE---------------------------------------------------
sessionInfo()

