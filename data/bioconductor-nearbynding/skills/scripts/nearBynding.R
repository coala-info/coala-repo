# Code example from 'nearBynding' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)
library(nearBynding)
library(Rsamtools)

## ----echo=FALSE---------------------------------------------------------------
## test whether the local computer can run the required programs
bedtools<-suppressWarnings(system2("bedtools", "--version", 
                                    stdout = NULL, stderr = NULL)) == 0
CapR<-suppressWarnings(system2("CapR", stdout = NULL, stderr = NULL)) == 0
stereogene<-suppressWarnings(system2("Stereogene", "-h", 
                                    stdout = NULL, stderr = NULL)) == 0

## ----eval = FALSE-------------------------------------------------------------
# if(!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# BiocManager::install("nearBynding")

## ----eval=FALSE---------------------------------------------------------------
# cd CapR-master
# make
# ./CapR

## ----eval=FALSE---------------------------------------------------------------
# cd stereogene-master
# cd src
# make
# ./stereogene -h

## -----------------------------------------------------------------------------
# load transcript list
load(system.file("extdata/transcript_list.Rda", package="nearBynding"))
# get GTF file
gtf<-system.file("extdata/Homo_sapiens.GRCh38.chr4&5.gtf", 
                    package="nearBynding")

GenomeMappingToChainFile(genome_gtf = gtf,
                        out_chain_name = "test.chain",
                        RNA_fragment = "three_prime_utr",
                        transcript_list = transcript_list,
                        alignment = "hg38")

## -----------------------------------------------------------------------------
getChainChrSize(chain = "test.chain", 
                out_chr = "chr4and5_3UTR.size")

## ----eval = FALSE-------------------------------------------------------------
# ExtractTranscriptomeSequence(transcript_list = transcript_list,
#                     ref_genome = "Homo_sapiens.GRCh38.dna.primary_assembly.fa",
#                     genome_gtf = gtf,
#                     RNA_fragment = "three_prime_utr",
#                     exome_prefix = "chr4and5_3UTR")

## -----------------------------------------------------------------------------
chr4and5_3UTR.fa <- system.file("extdata/chr4and5_3UTR.fa", 
                                package="nearBynding")

## ----eval = CapR--------------------------------------------------------------
# runCapR(in_file = chr4and5_3UTR.fa)

## ----eval = bedtools----------------------------------------------------------
# bam <- system.file("extdata/chr4and5.bam", package="nearBynding")
# sorted_bam<-sortBam(bam, "chr4and5_sorted")
# 
# CleanBAMtoBG(in_bam = sorted_bam)

## -----------------------------------------------------------------------------
liftOverToExomicBG(input = "chr4and5_sorted.bedGraph",
                    chain = "test.chain",
                    chrom_size = "chr4and5_3UTR.size",
                    output_bg = "chr4and5_liftOver.bedGraph")

## -----------------------------------------------------------------------------
processCapRout(CapR_outfile = system.file("extdata/chr4and5_3UTR.out", 
                                            package="nearBynding"),
                chain = "test.chain",
                output_prefix = "chr4and5_3UTR",
                chrom_size = "chr4and5_3UTR.size",
                genome_gtf = gtf,
                RNA_fragment = "three_prime_utr")

## ----eval = stereogene--------------------------------------------------------
# runStereogeneOnCapR(protein_file = "chr4and5_liftOver.bedGraph",
#                     chrom_size = "chr4and5_3UTR.size",
#                     name_config = "chr4and5_3UTR.cfg",
#                     input_prefix = "chr4and5_3UTR")

## ----echo = FALSE, eval = !stereogene, results='hide'-------------------------
get_outfiles()

## ----eval = FALSE-------------------------------------------------------------
# runStereogene(track_files = c("chr4and5_3UTR_stem_liftOver.bedGraph",
#                                 "chr4and5_liftOver.bedGraph"),
#                 name_config = "chr4and5_3UTR.cfg")

## ----eval = stereogene--------------------------------------------------------
# visualizeCapRStereogene(CapR_prefix = "chr4and5_3UTR",
#                         protein_file = "chr4and5_liftOver",
#                         heatmap = TRUE,
#                         out_file = "all_contexts_heatmap",
#                         x_lim = c(-500, 500))
# visualizeCapRStereogene(CapR_prefix = "chr4and5_3UTR",
#                         protein_file = "chr4and5_liftOver",
#                         x_lim = c(-500, 500),
#                         out_file = "all_contexts_line",
#                         y_lim = c(-18, 22))

## ----fig.show='hold', echo = FALSE, out.width = '50%'-------------------------
knitr::include_graphics("all_contexts_heatmap.jpeg")
knitr::include_graphics("all_contexts_line.pdf")

## ----eval = stereogene--------------------------------------------------------
# visualizeStereogene(context_file = "chr4and5_3UTR_stem_liftOver",
#                     protein_file = "chr4and5_liftOver",
#                     out_file = "stem_line",
#                     x_lim = c(-500, 500))
# visualizeStereogene(context_file = "chr4and5_3UTR_stem_liftOver",
#                     protein_file = "chr4and5_liftOver",
#                     heatmap = TRUE,
#                     out_file = "stem_heatmap",
#                     x_lim = c(-500, 500))

## ----fig.show='hold', echo = FALSE, out.width = '50%'-------------------------
knitr::include_graphics("stem_heatmap.jpeg")
knitr::include_graphics("stem_line.pdf")

## -----------------------------------------------------------------------------
bindingContextDistance(RNA_context = "chr4and5_3UTR_stem_liftOver",
                        protein_file = "chr4and5_liftOver",
                        RNA_context_2 = "chr4and5_3UTR_hairpin_liftOver")

## -----------------------------------------------------------------------------
bindingContextDistance(RNA_context = "chr4and5_3UTR_internal_liftOver",
                        protein_file = "chr4and5_liftOver",
                        RNA_context_2 = "chr4and5_3UTR_hairpin_liftOver")

## -----------------------------------------------------------------------------
sessionInfo()

