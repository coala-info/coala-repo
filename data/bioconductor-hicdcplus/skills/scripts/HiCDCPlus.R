# Code example from 'HiCDCPlus' vignette. See references/ for full tutorial.

## ----setup, echo=FALSE, results="hide"----------------------------------------
knitr::opts_chunk$set(tidy = FALSE,
                      cache = FALSE,
                      dev = "png",
                      message = FALSE, error = FALSE, warning = FALSE)
library(HiCDCPlus)

## ----quickStart_sig, eval=FALSE-----------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("HiCDCPlus")

## ----quickStart_sig_2, eval=FALSE---------------------------------------------
# cache <- rappdirs::user_cache_dir(appname="HiCDCPlus")
# print(cache)

## ----quickStart_sig1----------------------------------------------------------
hicfile_path<-system.file("extdata", "GSE63525_HMEC_combined_example.hic", package = "HiCDCPlus")
outdir<-tempdir(check=TRUE)
#generate features
construct_features(output_path=paste0(outdir,"/hg19_50kb_GATC"),
                   gen="Hsapiens",gen_ver="hg19",
                   sig="GATC",
                   bin_type="Bins-uniform",
                   binsize=50000,
                   chrs=c("chr21","chr22"))

## ----quickStart_sig2----------------------------------------------------------
#generate gi_list instance
gi_list<-generate_bintolen_gi_list(
  bintolen_path=paste0(outdir,"/hg19_50kb_GATC_bintolen.txt.gz"))
#add .hic counts
gi_list<-add_hic_counts(gi_list,hic_path = hicfile_path)

## ----quickStart_sig3----------------------------------------------------------
#expand features for modeling
gi_list<-expand_1D_features(gi_list)
#run HiC-DC+ 
set.seed(1010) #HiC-DC downsamples rows for modeling
gi_list<-HiCDCPlus(gi_list) #HiCDCPlus_parallel runs in parallel across ncores
head(gi_list)
#write normalized counts (observed/expected) to a .hic file
hicdc2hic(gi_list,hicfile=paste0(outdir,'/GSE63525_HMEC_combined_result.hic'),
          mode='normcounts',gen_ver='hg19')
#write results to a text file
gi_list_write(gi_list,fname=paste0(outdir,'/GSE63525_HMEC_combined_result.txt.gz'))

## ----quickStart_diff1---------------------------------------------------------
#generate features
construct_features(output_path=paste0(outdir,"/hg38_50kb_GATC"),
                   gen="Hsapiens",gen_ver="hg38",
                   sig="GATC",bin_type="Bins-uniform",
                   binsize=50000,
                   chrs=c("chr22"))
#add .hic counts
hicfile_paths<-c(
system.file("extdata", "GSE131651_NSD2_LOW_arima_example.hic", package = "HiCDCPlus"),
system.file("extdata", "GSE131651_NSD2_HIGH_arima_example.hic", package = "HiCDCPlus"),
system.file("extdata", "GSE131651_TKOCTCF_new_example.hic", package = "HiCDCPlus"),
system.file("extdata", "GSE131651_NTKOCTCF_new_example.hic", package = "HiCDCPlus"))
indexfile<-data.frame()
for(hicfile_path in hicfile_paths){
output_path<-paste0(outdir,'/',
                    gsub("^(.*[\\/])", "",gsub('.hic','.txt.gz',hicfile_path)))
#generate gi_list instance
gi_list<-generate_bintolen_gi_list(
  bintolen_path=paste0(outdir,"/hg38_50kb_GATC_bintolen.txt.gz"),
  gen="Hsapiens",gen_ver="hg38")
gi_list<-add_hic_counts(gi_list,hic_path = hicfile_path)
#expand features for modeling
gi_list<-expand_1D_features(gi_list)
#run HiC-DC+ on 2 cores
set.seed(1010) #HiC-DC downsamples rows for modeling
gi_list<-HiCDCPlus(gi_list,ssize=0.1)
for (i in seq(length(gi_list))){
indexfile<-unique(rbind(indexfile,
  as.data.frame(gi_list[[i]][gi_list[[i]]$qvalue<=0.05])[c('seqnames1',
                                                           'start1','start2')]))
}
#write results to a text file
gi_list_write(gi_list,fname=output_path)
}
#save index file---union of significants at 50kb
colnames(indexfile)<-c('chr','startI','startJ')
data.table::fwrite(indexfile,
            paste0(outdir,'/GSE131651_analysis_indices.txt.gz'),
            sep='\t',row.names=FALSE,quote=FALSE)

## ----quickStart_diff2---------------------------------------------------------

#Differential analysis using modified DESeq2 (see ?hicdcdiff)
hicdcdiff(input_paths=list(NSD2=c(paste0(outdir,'/GSE131651_NSD2_LOW_arima_example.txt.gz'),
                 paste0(outdir,'/GSE131651_NSD2_HIGH_arima_example.txt.gz')),
TKO=c(paste0(outdir,'/GSE131651_TKOCTCF_new_example.txt.gz'),
paste0(outdir,'/GSE131651_NTKOCTCF_new_example.txt.gz'))),
filter_file=paste0(outdir,'/GSE131651_analysis_indices.txt.gz'),
output_path=paste0(outdir,'/diff_analysis_example/'),
fitType = 'mean',
chrs = 'chr22',
binsize=50000,
diagnostics=TRUE)
#Check the generated plots as well as DESeq2 results

## ----quickStart_ice1, eval=FALSE----------------------------------------------
# gi_list<-generate_binned_gi_list(50000,chrs=c("chr21","chr22"))
# gi_list<-add_hicpro_matrix_counts(gi_list,absfile_path,matrixfile_path,chrs=c("chr21","chr22")) #add paths to iced absfile and matrix files here

## ----quickStart_ice2----------------------------------------------------------
hic_path<-system.file("extdata", "GSE63525_HMEC_combined_example.hic", package = "HiCDCPlus")
gi_list=hic2icenorm_gi_list(hic_path,binsize=50e3,chrs=c('chr22'),Dthreshold=400e3)

## ----quickStart_ice3----------------------------------------------------------
tads<-gi_list_topdom(gi_list,chrs=c("chr22"),window.size = 10)

## ----quickStart_comp1, eval=FALSE---------------------------------------------
# extract_hic_eigenvectors(
#   hicfile=system.file("extdata", "eigenvector_example.hic", package = "HiCDCPlus"),
#   mode = "KR",
#   binsize = 50e3,
#   chrs = "chr22",
#   gen = "Hsapiens",
#   gen_ver = "hg19",
#   mode = "NONE"
# )

## ----generate_bintolen--------------------------------------------------------
#generate features
construct_features(output_path=paste0(outdir,"/hg19_50kb_GATC"),
                   gen="Hsapiens",gen_ver="hg19",
                   sig=c("GATC","GANTC"),bin_type="Bins-uniform",
                   binsize=50000,
                   wg_file=NULL, #e.g., 'hg19_wgEncodeCrgMapabilityAlign50mer.bigWig',
                   chrs=c("chr22"))
#read and print
bintolen<-data.table::fread(paste0(outdir,"/hg19_50kb_GATC_bintolen.txt.gz"))
tail(bintolen,20)

## ----gi_list_uniform----------------------------------------------------------
gi_list<-generate_binned_gi_list(binsize=50000,chrs=c('chr22'),
                                 gen="Hsapiens",gen_ver="hg19")
head(gi_list)

## ----gi_list_rebinned---------------------------------------------------------
df<-data.frame(chr='chr9',start=c(1,300,7867,103938))
gi_list<-generate_df_gi_list(df)
gi_list

## ----gi_list_bintolen---------------------------------------------------------
#generate features
construct_features(output_path=paste0(outdir,"/hg19_50kb_GATC"),
                   gen="Hsapiens",gen_ver="hg19",
                   sig="GATC",bin_type="Bins-uniform",
                   binsize=50000,
            wg_file=NULL, #e.g., 'hg19_wgEncodeCrgMapabilityAlign50mer.bigWig',
                   chrs=c("chr22"))
#generate gi_list instance
gi_list<-generate_bintolen_gi_list(
  bintolen_path=paste0(outdir,"/hg19_50kb_GATC_bintolen.txt.gz"))
head(gi_list)

## ----custom_features_2D-------------------------------------------------------
df<-data.frame(chr='chr9',start=seq(1e6,10e6,1e6))
gi_list<-generate_df_gi_list(df,Dthreshold=500e3,chrs="chr9")
feats<-data.frame(chr='chr9',
startI=seq(1e6,10e6,1e6),
startJ=seq(1e6,10e6,1e6),
counts=rpois(20,lambda=5))
gi_list[['chr9']]<-add_2D_features(gi_list[['chr9']],feats)
gi_list

## ----custom_features_1D-------------------------------------------------------
df<-data.frame(chr='chr9',start=seq(1e6,10e6,1e6),end=seq(2e6,11e6,1e6))
gi_list<-generate_df_gi_list(df)
feats<-data.frame(chr='chr9',start=seq(1e6,10e6,1e6),gc=runif(10))
gi_list<-add_1D_features(gi_list,feats)
gi_list

## ----custom_features_1D_2-----------------------------------------------------
mcols(InteractionSet::regions(gi_list[['chr9']]))

## ----custom_features_1D_expand------------------------------------------------
gi_list<-expand_1D_features(gi_list)
gi_list

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

