# Code example from 'borealis' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
options(digits=3)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("borealis")

## ----message=FALSE, warning=FALSE---------------------------------------------
library("borealis")

# Set data locations
outdir <- tempdir()
extdata <- system.file("extdata","bismark", package="borealis")

# Run borealis
results <- runBorealis(extdata,nThreads=2, chrs="chr14", suffix=".gz",
                        outprefix=file.path(outdir,"vignette_borealis_"), 
                        modelOutPrefix=file.path(outdir,"vignette_CpG_model"))

## -----------------------------------------------------------------------------
# Read in the name of all files for analysis
borealis_in <- dir(outdir,pattern="*DMLs.tsv")
length(borealis_in)

## ----message=FALSE, warning=FALSE---------------------------------------------
# Read in list of Borealis output files and create a dataframe for each
for (file in borealis_in) {
    name <- sub("_DMLs.tsv", "", file)
    assign(name,GenomicRanges::makeGRangesFromDataFrame(
                read.table(file.path(outdir,file), header=TRUE,
                stringsAsFactors=FALSE), start.field="pos", end.field="pos.1", 
                seqnames.field="chr", keep.extra.columns=TRUE))
}

# Create a list of the newly created dataframes
list_object_names <- ls(pattern="borealis_patient")
listGRanges <- lapply(list_object_names, get)

## -----------------------------------------------------------------------------
length(list_object_names)
list_object_names[1]

## -----------------------------------------------------------------------------
listGRanges[[1]][1,]

## -----------------------------------------------------------------------------
# Add sample ID and a corrected p-value to each and output as new files (.padj)
for (i in seq_along(listGRanges)) {
    sample=sub("_chr.*", "", list_object_names[i])
    listGRanges[[i]]$sampleID <- sample
    listGRanges[[i]]$pAdj <- p.adjust( listGRanges[[i]]$pVal, method="BH")
}

## -----------------------------------------------------------------------------
listGRanges[[1]][1,]

## -----------------------------------------------------------------------------
# Create a single GRanges obect with data for all samples and a dataframe for summaries
combined_files <- Reduce(c,listGRanges)
combined_files_df<-data.frame(combined_files)

## -----------------------------------------------------------------------------
# How many rows of data in combined GRange object?
length(combined_files)

## -----------------------------------------------------------------------------
# Create table of unique positions and mu/theta values
mu_theta <- unique(subset(combined_files_df, 
                    select=-c(x,n,pVal, isHypo, pAdj, effSize, sampleID)))

## -----------------------------------------------------------------------------
#Number of unique samples
length(unique(combined_files_df$sampleID))

#Number of unique CpG sites
nrow(unique(mu_theta))

## -----------------------------------------------------------------------------
#generate summaries for mu and theta
summary(mu_theta$mu)
summary(mu_theta$theta)

## -----------------------------------------------------------------------------
# Create table of unique positions and depth/p-val/padj for each position in 
# each case
depth_pvals_eff <- unique(combined_files_df)

## -----------------------------------------------------------------------------
#Summarize read depths
summary(depth_pvals_eff$n)

## -----------------------------------------------------------------------------
#Summarize pvals
summary(depth_pvals_eff$pVal)

## -----------------------------------------------------------------------------
#Summarize corrected pvals
summary(depth_pvals_eff$pAdj)

## -----------------------------------------------------------------------------
#Summarize fraction of methylation
summary(depth_pvals_eff$x/depth_pvals_eff$n)

## -----------------------------------------------------------------------------
#Summarize effect size
summary(depth_pvals_eff$effSize)

## -----------------------------------------------------------------------------
# Detection of outliers based on number of significant sites
# Count significant CpG sites per patient
signif_only <- subset(combined_files_df, pVal <= 0.05)
signif_counts <- dplyr::count(as.data.frame(signif_only),sampleID)

# Calculate the percentiles of the number of significant sites
sig_quantiles <- quantile(signif_counts$n,
                            probs=c(0.025, 0.05, 0.95, 0.975, 0.999))

# Check if nay patients are above the 99.9th percentile
subset(signif_counts, n >= sig_quantiles["99.9%"])

## -----------------------------------------------------------------------------
# What is the most significant CpG site between all samples?
subset(combined_files_df, pVal == min(combined_files$pVal))

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("annotatr")

## ----message=FALSE, results='hide', warning=FALSE-----------------------------
#Assign approproate genome version based on alignments
genome.version <- "hg19"

# Select annnotation classes we want from annotatr (can be user-customized)
myAnnots <- c('_genes_promoters', '_genes_5UTRs', '_genes_exons',
    '_genes_3UTRs','_cpg_islands')

## ----message=FALSE, results='hide', warning=FALSE-----------------------------
#Read in patient 72 Grange data for annotation
dmrs.gr<-subset(combined_files, 
    sampleID == "vignette_borealis_patient_72")


# Annotate using annotatr
myAnnots <- paste(genome.version,myAnnots,sep="")
annots.all.gr <- annotatr::build_annotations(genome = genome.version,
    annotations = myAnnots)
allAnnot <- annotatr::annotate_regions(regions=dmrs.gr,
    annotations=annots.all.gr, ignore.strand=TRUE, minoverlap=0)

## -----------------------------------------------------------------------------
# Extract the annotated site with the smallest p-value
subset(allAnnot, pVal == min(allAnnot$pVal))$annot

## ----sg, fig.wide=TRUE, fig.cap="plotCpGsite function demo"-------------------
# Use Borealis plotting function to investigate this site further
plotCpGsite("chr14:24780288", sampleOfInterest="patient_72",
            modelFile=file.path(outdir,"vignette_CpG_model_chr14.csv"),
            methCountFile=file.path(outdir,
                                "vignette_CpG_model_rawMethCount_chr14.tsv"),
            totalCountFile=file.path(outdir,
                                "vignette_CpG_model_rawTotalCount_chr14.tsv"))

## -----------------------------------------------------------------------------
padjThresh <- 0.05

## -----------------------------------------------------------------------------
# Calculate how may CpGs per annotatr feature and store in dataframe
allAnnot <- as.data.frame(allAnnot)
featureids <- allAnnot$annot.id
featurecnts <- as.data.frame(table(featureids))
colnames(featurecnts) <- c("annot.id", "NoSites")

## -----------------------------------------------------------------------------
head(featurecnts)

## -----------------------------------------------------------------------------
# Calculate how many sites per feature pass p-value threshold
# Add data to new summary dataframe
signifonly <- subset(allAnnot, pAdj<=padjThresh)
signifonly <- signifonly$annot.id
signifonlycnt <- as.data.frame(table(signifonly))
colnames(signifonlycnt) <- c("annot.id", "signifCount")
featurecnts <- merge(featurecnts, signifonlycnt, by.x="annot.id", 
                        by.y="annot.id", all.x=TRUE)

## -----------------------------------------------------------------------------
# What fraction of sites per feature pass p-value threshold?
featurecnts$fractionSignif <- featurecnts$signifCount/featurecnts$NoSites

## -----------------------------------------------------------------------------
# Let's combine the data for final output
locations <- subset(allAnnot, select=c("annot.id", "annot.seqnames",
                                        "annot.start", "annot.end"))
featurecnts <- merge(unique(locations), featurecnts, by="annot.id")
genemap <- unique(cbind(allAnnot$annot.symbol, allAnnot$annot.id, 
                        allAnnot$annot.tx_id,allAnnot$annot.width, 
                        allAnnot$sampleID))
colnames(genemap) <- c("annot.symbol", "annot.id", "annot.tx_id", "annot.width",
                        "SampleID")
    
summarized <- merge(featurecnts, genemap, by="annot.id")
summarized$signifCount[is.na(summarized$signifCount)] <- 0
summarized$fractionSignif[is.na(summarized$fractionSignif)] <- 0

## -----------------------------------------------------------------------------
# Select the LTB4R promoter region
subset(summarized, select=c(annot.symbol, NoSites, signifCount, fractionSignif),
        (annot.symbol=="LTB4R" & grepl("promoter", annot.id)))

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

