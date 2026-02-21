# Code example from 'Rbwa' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide"-----------------------------------------------
options("knitr.graphics.auto_pdf"=TRUE, eval=TRUE)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#     install.packages("BiocManager")
# 
# BiocManager::install("Rbwa")

## ----loading, eval=TRUE-------------------------------------------------------
library(Rbwa)

## ----build_index, eval=TRUE---------------------------------------------------
dir <- tempdir()
fasta <- system.file(package="Rbwa",
                     "fasta/chr12.fa")
index_prefix <- file.path(dir, "chr12")
bwa_build_index(fasta,
                index_prefix=index_prefix)
list.files(dir)

## ----bwa_aln, eval=TRUE-------------------------------------------------------
fastq <- system.file(package="Rbwa",
                     "fastq/sequences.fastq")
bwa_aln(index_prefix=index_prefix,
        fastq_files=fastq,
        sai_files=file.path(dir, "output.sai"))

## ----bwa_aln2, eval=TRUE------------------------------------------------------
bwa_aln(index_prefix=index_prefix,
        fastq_files=fastq,
        sai_files=file.path(dir, "output.sai"),
        n=3, k=3, l=13)

## ----bwa_sam, eval=TRUE-------------------------------------------------------
bwa_sam(index_prefix=index_prefix,
        fastq_files=fastq,
        sai_files=file.path(dir, "output.sai"),
        sam_file=file.path(dir, "output.sam"))

## ----reading1, eval=TRUE------------------------------------------------------
strtrim(readLines(file.path(dir, "output.sam")), 65)

## ----bwa_sam_multi, eval=TRUE-------------------------------------------------
xa2multi(file.path(dir, "output.sam"),
         file.path(dir, "output.multi.sam"))
strtrim(readLines(file.path(dir, "output.multi.sam")), 65)

## ----bwa_mem, eval=TRUE-------------------------------------------------------
fastq <- system.file(package="Rbwa",
                     "fastq/sequences.fastq")
bwa_mem(index_prefix=index_prefix,
        fastq_files=fastq,
        sam_file=file.path(dir, "output.sam"))

## ----reading2, eval=TRUE------------------------------------------------------
strtrim(readLines(file.path(dir, "output.sam")), 65)

## -----------------------------------------------------------------------------
sessionInfo()

