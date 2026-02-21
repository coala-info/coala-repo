# Code example from 'Rbowtie-Overview' vignette. See references/ for full tutorial.

## ----cite, eval=TRUE----------------------------------------------------------
citation("Rbowtie")

## ----install, eval=FALSE------------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("Rbowtie")

## ----loadLibraries, eval=TRUE-------------------------------------------------
library(Rbowtie)

## ----bowtieBuildUsage, eval=TRUE----------------------------------------------
bowtie_build_usage()

## ----bowtieBuild, eval=TRUE---------------------------------------------------
refFiles <- dir(system.file(package="Rbowtie", "samples", "refs"), full=TRUE)
indexDir <- file.path(tempdir(), "refsIndex")

tmp <- bowtie_build(references=refFiles, outdir=indexDir, prefix="index", force=TRUE)
head(tmp)

## ----bowtieUsage, eval=TRUE---------------------------------------------------
bowtie_usage()

## ----bowtie, eval=TRUE--------------------------------------------------------
readsFiles <- system.file(package="Rbowtie", "samples", "reads", "reads.fastq")
samFiles <- file.path(tempdir(), "alignments.sam")

bowtie(sequences=readsFiles, 
       index=file.path(indexDir, "index"), 
       outfile=samFiles, sam=TRUE,
       best=TRUE, force=TRUE)
strtrim(readLines(samFiles), 65)

## ----SpliceMap, eval=TRUE-----------------------------------------------------
readsFiles <- system.file(package="Rbowtie", "samples", "reads", "reads.fastq")
refDir <- system.file(package="Rbowtie", "samples", "refs", "chr1.fa")
indexDir <- file.path(tempdir(), "refsIndex")
samFiles <- file.path(tempdir(), "splicedAlignments.sam")

cfg <- list(genome_dir=refDir,
            reads_list1=readsFiles,
            read_format="FASTQ",
            quality_format="phred-33",
            outfile=samFiles,
            temp_path=tempdir(),
            max_intron=400000,
            min_intron=20000,
            max_multi_hit=10,
            seed_mismatch=1,
            read_mismatch=2,
            num_chromosome_together=2,
            bowtie_base_dir=file.path(indexDir, "index"),
            num_threads=4,
            try_hard="yes",
            selectSingleHit=TRUE)
res <- SpliceMap(cfg)
res
strtrim(readLines(samFiles), 65)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

