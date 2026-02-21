# Code example from 'cobindR' vignette. See references/ for full tutorial.

### R code from vignette source 'cobindR.Rnw'

###################################################
### code chunk number 1: load.libraries
###################################################
library(cobindR)
library(Biostrings)


###################################################
### code chunk number 2: make.configuration.from.file
###################################################
#run cobindR
cfg <- cobindRConfiguration( fname = 
             system.file('extdata/config_default.yml',
             package='cobindR'))


###################################################
### code chunk number 3: make.configuration.from.script (eval = FALSE)
###################################################
## #run cobindR
## cfg <- cobindRConfiguration()


###################################################
### code chunk number 4: set.PFM.path
###################################################
pfm_path(cfg) <- 
  system.file('extdata/pfms',package='cobindR')


###################################################
### code chunk number 5: define.pairs
###################################################
pairs(cfg) <- c('ES_Sox2_1_c1058 ES_Oct4_1_c570')


###################################################
### code chunk number 6: set.PFM.path (eval = FALSE)
###################################################
## pfm_path(cfg) <- 'MotifDb'
## pairs(cfg) <- c('JASPAR_CORE:CREB1 JASPAR_CORE:KLF4',
## 		'JASPAR_CORE:CREB1 JASPAR_CORE:KLF4')


###################################################
### code chunk number 7: configure.sequence.input
###################################################
sequence_type(cfg) <- 'fasta'
sequence_source(cfg) <- system.file('extdata/sox_oct_example_vignette_seqs.fasta',
                                            package='cobindR')
sequence_origin(cfg) <- 'Mouse Embryonic Stem Cell Example ChIP-Seq Oct4 Peak Sequences'
species(cfg) <- 'Mus musculus'


###################################################
### code chunk number 8: configure.geneid.sequence.input (eval = FALSE)
###################################################
## tmp.geneid.file <- tempfile(pattern = "cobindR_sample_seq", 
##                      tmpdir = tempdir(), fileext = ".txt")
## write(c('#cobindR Example Mouse Genes','ENSMUSG00000038518',
## 		'ENSMUSG00000042596','ENSMUSG00000025927'),
## 		file = tmp.geneid.file)
## species(cfg) <- 'Mus musculus'
## sequence_type(cfg) <- 'geneid'
## sequence_source(cfg) <- tmp.geneid.file
## sequence_origin(cfg) <- 'ENSEMBL genes'
## upstream(cfg) <- downstream(cfg) <- 500


###################################################
### code chunk number 9: configure.chipseq.sequence.input (eval = FALSE)
###################################################
## sequence_type(cfg) <- 'chipseq'
## sequence_source(cfg) <- 
##   system.file('extdata/ucsc_example_ItemRGBDemo.bed',
## 				package='cobindR')
## sequence_origin(cfg) <- 'UCSC bedfile example'
## species(cfg) <- 'BSgenome.Mmusculus.UCSC.mm9'


###################################################
### code chunk number 10: define.background.model
###################################################
bg_sequence_type(cfg) <-  'markov.3.200'# or 'ushuffle.3.3000' or 'local.10.1000'


###################################################
### code chunk number 11: perform.search
###################################################
cobindR.bs <- cobindr( cfg, 
              name='cobind test using sampled sequences')
cobindR.bs <- search.pwm(cobindR.bs, min.score = '80')
cobindR.bs <- find.pairs(cobindR.bs, n.cpu = 3)


###################################################
### code chunk number 12: perform.rtfbssearch (eval = FALSE)
###################################################
## cobindR.bs = rtfbs(cobindR.bs)


###################################################
### code chunk number 13: perform.gadem (eval = FALSE)
###################################################
## cobindR.bs = search.gadem(cobindR.bs, deNovo=TRUE)


###################################################
### code chunk number 14: make.seq.background
###################################################
cobindR.bs <- generate.background(cobindR.bs)


###################################################
### code chunk number 15: perform.background.search
###################################################
cobindR.bs <- search.pwm(cobindR.bs, min.score='80', 
                        background_scan = TRUE)
cobindR.bs <- find.pairs(cobindR.bs, background_scan = TRUE, 
                        n.cpu = 3)


###################################################
### code chunk number 16: plot_gc_test (eval = FALSE)
###################################################
## tmp <- testCpG(cobindR.bs, do.plot=T)


###################################################
### code chunk number 17: plot_gc_profile (eval = FALSE)
###################################################
## plot.gc(cobindR.bs, wind.size=200, frac = 2) 


###################################################
### code chunk number 18: plot_predicted_logos (eval = FALSE)
###################################################
## pred.motifs <- predicted2pwm(cobindR.bs, as.pfm=TRUE)
## # normalized column sums as required by seqLogo
## pred.norm.motifs <- lapply(pred.motifs, function(x) x / colSums(x)[1]) 
## 
## # load sequence logo plot function
## plot.tfbslogo(x=cobindR.bs,c('ES_Sox2_1_c1058','ES_Oct4_1_c570'))


###################################################
### code chunk number 19: plot_positions_profile (eval = FALSE)
###################################################
## plot.positionprofile(cobindR.bs)


###################################################
### code chunk number 20: plot_positions_simple (eval = FALSE)
###################################################
## plot.positions.simple(cobindR.bs)


###################################################
### code chunk number 21: plot_heatmap (eval = FALSE)
###################################################
## plot.tfbs.heatmap(cobindR.bs, include.empty.seqs=FALSE)


###################################################
### code chunk number 22: plot_venn (eval = FALSE)
###################################################
## plot.tfbs.venndiagram(cobindR.bs, pwms = c('ES_Sox2_1_c1058', 'ES_Oct4_1_c570'), include.empty.seqs=FALSE)


###################################################
### code chunk number 23: plot_pairdistance (eval = FALSE)
###################################################
## plot.pairdistance(cobindR.bs, pwm1='ES_Sox2_1_c1058',
##                   pwm2='ES_Oct4_1_c570')


###################################################
### code chunk number 24: plot_pairdistribution (eval = FALSE)
###################################################
## plot.pairdistribution(cobindR.bs, pwm1='ES_Sox2_1_c1058',
##                       pwm2='ES_Oct4_1_c570')


###################################################
### code chunk number 25: plot_detrending (eval = FALSE)
###################################################
## plot.detrending(cobindR.bs, pwm1='ES_Sox2_1_c1058',
## 				pwm2='ES_Oct4_1_c570', bin_length=10, abs.distance=FALSE, overlap=4)


###################################################
### code chunk number 26: write.detrending
###################################################
tmp.sig.pairs = get.significant.pairs(x = cobindR.bs, pwm1='ES_Sox2_1_c1058',pwm2='ES_Oct4_1_c570', bin_length=10, abs.distance=FALSE,overlap=4)

tmp.resultbs.file <- tempfile(pattern = "cobindR_detrening_result_bindingsites", tmpdir = tempdir(), fileext = ".tsv")
write.table(tmp.sig.pairs[[1]], file=tmp.resultbs.file, sep="\t", quote=F)
system(paste('head',tmp.resultbs.file))

tmp.resultcp.file = gsub("bindingsites","candidates_pairs", tmp.resultbs.file)
write.table(tmp.sig.pairs[[2]], file=tmp.resultcp.file, sep="\t", quote=F)
system(paste('head',tmp.resultcp.file))


###################################################
### code chunk number 27: write.bindingsites
###################################################
tmp.result.bs.file <- tempfile(pattern = "cobindR_bindingsite_pred", 
                     tmpdir = tempdir(), fileext = ".txt")
write.bindingsites(cobindR.bs, file=tmp.result.bs.file, background=FALSE)
system(paste('head',tmp.result.bs.file))


###################################################
### code chunk number 28: write.bindingsites
###################################################
tmp.inseq.file <- tempfile(pattern = "cobindR_input_sequences", 
                     tmpdir = tempdir(), fileext = ".fasta")
# slotname = 'bg_sequences' to obtain the background sequences
write.sequences(cobindR.bs, file=tmp.inseq.file,
				slotname= "sequences")
#system(paste('head',tmp.inseq.file,'n=10'))


###################################################
### code chunk number 29: cleanup
###################################################
try(unlink(tmp.result.file))
try(unlink(tmp.result.bs.file))
try(unlink(tmp.inseq.file))


