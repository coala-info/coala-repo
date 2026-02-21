# Code example from 'GSE62944' vignette. See references/ for full tutorial.

## ----get-tcga-----------------------------------------------------------------
library(ExperimentHub)
eh = ExperimentHub()
query(eh , "GSE62944")

## ----download-tcga------------------------------------------------------------
tcga_data <- eh[["EH1"]]

## ----cancer-types-------------------------------------------------------------
 head(phenoData(tcga_data)$CancerType)

## ----lgg----------------------------------------------------------------------
# subset the expression Set to contain only samples from LGG.
lgg_data <- tcga_data[, which(phenoData(tcga_data)$CancerType=="LGG")]

# extract the IDHI mutant samples
mut_idx <- which(phenoData(lgg_data)$idh1_mutation_found=="YES")
mut_data <- exprs(lgg_data)[, mut_idx]

# extract the IDH1 WT samples
wt_idx <- which(phenoData(lgg_data)$idh1_mutation_found=="NO")
wt_data <- exprs(lgg_data)[, wt_idx]

# make a countTable.
countData <- cbind(mut_data, wt_data)

# for DE analysis with DESeq2 we need a sampleTable
samples= c(colnames(mut_data), colnames(wt_data))
group =c(rep("mut",length(mut_idx)), rep("wt", length(wt_idx)))
coldata <- cbind(samples, group)
colnames(coldata) <- c("sampleName", "Group")
coldata[,"Group"] <- factor(coldata[,"Group"], c("wt","mut"))

# Now we can run DE analysis
library(DESeq2)
ddsMat <- DESeqDataSetFromMatrix(countData = countData,
                                 colData = DataFrame(coldata),
                                 design = ~ Group)

dds <- ddsMat
dds <- dds[ rowSums(counts(dds)) > 1, ]
dds <- DESeq(dds)
res <- results(dds) 
summary(res)


## ----sessionInfo--------------------------------------------------------------
sessionInfo()

