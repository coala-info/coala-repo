# Code example from 'IntegrationWithIGVjs' vignette. See references/ for full tutorial.

## ----setup, eval=TRUE, include=FALSE------------------------------------------
library(epivizrChart)
library(Homo.sapiens)

## -----------------------------------------------------------------------------
data(tcga_colon_blocks)

## -----------------------------------------------------------------------------

epiviz_env <- epivizEnv(chr="chr11", start=118000000, end=121000000)
genes_track <- epiviz_env$plot(Homo.sapiens)
blocks_track <- epiviz_env$plot(tcga_colon_blocks, datasource_name="450kMeth")

## -----------------------------------------------------------------------------
file1 <- Rsamtools::BamFile("http://1000genomes.s3.amazonaws.com/phase3/data/HG01879/alignment/HG01879.mapped.ILLUMINA.bwa.ACB.low_coverage.20120522.bam")
file2 <- rtracklayer::BEDFile("https://s3.amazonaws.com/igv.broadinstitute.org/annotations/hg19/genes/refGene.hg19.bed.gz")

## -----------------------------------------------------------------------------

epiviz_igv <- epiviz_env$plot(
                  file1,
                  datasource_name = "genes2",
                  chr="chr11", start=118000000, end=121000000)

epiviz_env

