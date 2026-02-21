# Code example from 'oncocytomas' vignette. See references/ for full tutorial.

## ----loadLibrary-----------------------------------------------------------
library(MTseeker)

## ----loadBams, eval=FALSE--------------------------------------------------
#  if (FALSE) {
#    # we use SamBlaster... a lot... in my lab.
#    # however, this example takes a while even with SamBlaster.
#    # it is recorded here for posterity and also "how did you get that result".
#    BAMfiles <- grep("(split|disc)", value=T, invert=T, list.files(patt=".bam$"))
#    names(BAMfiles) <- sapply(strsplit(BAMfiles, "\\."), `[`, 1)
#    BAMs <- data.frame(BAM=BAMfiles,
#                       Sample_Group=ifelse(grepl("NKS", BAMfiles),
#                                           "normal","tumor"))
#    rownames(BAMs) <- sub("NKS", "normal", sub("RO","oncocytoma", rownames(BAMs)))
#    BAMs$subject <- as.integer(sapply(strsplit(BAMs$BAM, "(_|\\.)"), `[`, 2))
#  
#    # we merged all the BAMs after-the-fact, so...
#    BAMs <- subset(BAMs, grepl("merged", BAMs$BAM))
#    BAMs <- BAMs[order(BAMs$subject), ]
#  
#    library(parallel)
#    options("mc.cores"=detectCores())
#    MTreads <- getMT(BAMs, filter=FALSE)
#    names(MTreads) <- sapply(strsplit(fileName(MTreads), "\\."), `[`, 1)
#    saveRDS(MTreads, file="oncocytoma_and_matched_normal_MTreads.rds")
#  }

## ----loadDataLibrary-------------------------------------------------------
library(MTseekerData)

## ----computeCN-------------------------------------------------------------
data(RONKSreads, package="MTseekerData")
mVn <- Summary(RONKSreads)$mitoVsNuclear
names(mVn) <- names(RONKSreads) 
CN <- mVn[seq(2,22,2)]/mVn[seq(1,21,2)] 
mtCN <- data.frame(subject=names(CN), CN=CN)

library(ggplot2) 
library(ggthemes)
p <- ggplot(head(mtCN), aes(x=subject, y=CN, fill=subject)) + 
       geom_col() + theme_tufte(base_size=24) + ylim(0,4) + 
       ylab("Tumor/normal mitochondrial ratio") + 
       ggtitle("Mitochondrial retention in oncocytomas")
print(p)

## ----callVariants, eval=FALSE----------------------------------------------
#  if (FALSE) {
#    # doing this requires the BAM files
#    RONKSvariants <- callMT(RONKSreads)
#    # which is why we skip it in the vignette
#    save(RONKSvariants, file="RONKSvariants.rda")
#    # see ?callMT for a much simpler runnable example
#  }

## ----loadVariants----------------------------------------------------------
library(MTseekerData)
data(RONKSvariants, package="MTseekerData")

## ----filterRoVariants------------------------------------------------------
RO <- grep("RO_", names(RONKSvariants))
filtered_RO <- filterMT(RONKSvariants[RO], fpFilter=TRUE, NuMT=TRUE)
RO_recurrent <- subset(granges(filtered_RO), 
                       region == "coding" & rowSums(overlaps) > 1)

## ----filterNksVariants-----------------------------------------------------
NKS <- grep("NKS_", names(RONKSvariants))
filtered_NKS <- filterMT(RONKSvariants[NKS], fpFilter=TRUE, NuMT=TRUE)
NKS_recurrent <- subset(granges(filtered_NKS), 
                        region == "coding" & rowSums(overlaps) > 1)
NKS_gaps <- subset(gaps(NKS_recurrent), strand == "*")

## ----pruneVariants---------------------------------------------------------
RONKSfiltered <- endoapply(filterMT(RONKSvariants), subsetByOverlaps, NKS_gaps)
RONKScoding <- encoding(RONKSfiltered)

## ----plotVariants, eval=FALSE----------------------------------------------
#  plot(RONKScoding)

## ----makeSVG---------------------------------------------------------------
data(RONKSvariants, package="MTseekerData")
SVG <- MTseeker::MTcomplex(RONKSvariants[[2]]) 

## ----makePDF, eval=FALSE---------------------------------------------------
#  library(rsvg)
#  tmppdf <- paste(tempdir(), "RO_1.functionalAnnot.pdf", sep="/")
#  rsvg_pdf(tmppdf)

