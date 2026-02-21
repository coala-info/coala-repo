# Code example from 'Intro' vignette. See references/ for full tutorial.

## ----kable 1, echo=FALSE, error=TRUE------------------------------------------
try({
library(knitr)
MGI <- c("nonsense", "frame_shift_del",
         "frame_shift_ins", "splice_site_del",
         "splice_site_ins", "splice_site",
         "nonstop", "in_frame_del", "in_frame_ins",
         "missense", "splice_region_del",
         "splice_region_ins", "splice_region",
         "5_prime_flanking_region",
         "3_prime_flanking_region",
         "3_prime_untranslated_region",
         "5_prime_untranslated_region", "rna",
         "intronic", "silent")
MAF <- c("Nonsense_Mutation", "Frame_Shift_Ins",
         "Frame_Shift_Del", "Translation_Start_Site",
         "Splice_Site", "Nonstop_Mutation",
         "In_Frame_Ins", "In_Frame_Del",
         "Missense_Mutation", "5\'Flank",
         "3\'Flank", "5\'UTR", "3\'UTR", "RNA", "Intron",
         "IGR", "Silent", "Targeted_Region", "", "")

kable(as.data.frame(cbind(MAF, MGI)))
})

## ----eval=FALSE, error=TRUE---------------------------------------------------
try({
# # Plot the mutation landscape
# waterfall(brcaMAF, fileType="MAF")
})

## ----fig.keep='last', fig.width=10, fig.height=7, message=FALSE, warning=FALSE, results='hide', tidy=TRUE, error=TRUE----
try({
# Load GenVisR and set seed
library(GenVisR)
set.seed(383)

# Plot only genes with mutations in 6% or more of samples
waterfall(brcaMAF, mainRecurCutoff=.06)
})

## ----fig.keep='last', fig.width=10, fig.height=7, message=FALSE, warning=FALSE, results='hide', tidy=TRUE, error=TRUE----
try({
# Plot only the specified genes
waterfall(brcaMAF, plotGenes=c("PIK3CA", "TP53", "USH2A", "MLL3", "BRCA1"))
})

## ----kable, echo=FALSE, tidy=TRUE, error=TRUE---------------------------------
try({
kable(as.data.frame(cbind(sample=as.character(brcaMAF[1:10,16]),
                          mut_burden=as.numeric(rnorm(10, mean=2, sd=.5)))))
})

## ----fig.keep='last', fig.width=12, fig.height=8.5, message=FALSE, warning=FALSE, results='hide', tidy=TRUE, error=TRUE----
try({
# Create clinical data
subtype <- c('lumA', 'lumB', 'her2', 'basal', 'normal')
subtype <- sample(subtype, 50, replace=TRUE)
age <- c('20-30', '31-50', '51-60', '61+')
age <- sample(age, 50, replace=TRUE)
sample <- as.character(unique(brcaMAF$Tumor_Sample_Barcode))
clinical <- as.data.frame(cbind(sample, subtype, age))

# Melt the clinical data into "long" format.
library(reshape2)
clinical <- melt(clinical, id.vars=c('sample'))

# Run waterfall
waterfall(brcaMAF, clinDat=clinical,
          clinVarCol=c('lumA'='blue4', 'lumB'='deepskyblue', 
                            'her2'='hotpink2', 'basal'='firebrick2',
                            'normal'='green4', '20-30'='#ddd1e7',
                            '31-50'='#bba3d0', '51-60'='#9975b9',
                            '61+'='#7647a2'), 
          plotGenes=c("PIK3CA", "TP53", "USH2A", "MLL3", "BRCA1"),
          clinLegCol=2,
          clinVarOrder=c('lumA', 'lumB', 'her2', 'basal', 'normal',
                         '20-30', '31-50', '51-60', '61+'))
})

## ----fig.keep='last', fig.width=10, fig.height=6.5, message=FALSE, warning=FALSE, results='hide', tidy=TRUE, error=TRUE----
try({
# Load transcript meta data
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

# Load BSgenome
library(BSgenome.Hsapiens.UCSC.hg19)
genome <- BSgenome.Hsapiens.UCSC.hg19

# Define a region of interest 
gr <- GRanges(seqnames=c("chr10"), ranges=IRanges(start=c(89622195), 
end=c(89729532)), strand=strand(c("+")))

# Create Data for input
start <- c(89622194:89729524)
end <- c(89622195:89729525)
chr <- 10
cov <- c(rnorm(100000, mean=40), rnorm(7331, mean=10))
cov_input_A <- as.data.frame(cbind(chr, start, end, cov))

start <- c(89622194:89729524)
end <- c(89622195:89729525)
chr <- 10
cov <- c(rnorm(50000, mean=40), rnorm(7331, mean=10), rnorm(50000, mean=40))
cov_input_B <- as.data.frame(cbind(chr, start, end, cov))

# Define the data as a list
data <- list("Sample A"=cov_input_A, "Sample B"=cov_input_B)

# Call genCov
genCov(data, txdb, gr, genome, gene_labelTranscriptSize=2, transform=NULL, base=NULL)
})

## ----fig.keep='last', fig.width=10, fig.height=6.5, message=FALSE, warning=FALSE, results='hide', tidy=TRUE, error=TRUE----
try({
# Turn off feature compression and reduce gene transcripts
genCov(data, txdb, gr, genome, transform=c("Intron", "CDS", "UTR"), base=c(10, 2, 2), reduce=TRUE)
})

## ----fig.keep='last', fig.width=11, fig.height=5.5, message=FALSE, warning=FALSE, results='hide', error=TRUE----
try({
# Call TvTi
TvTi(brcaMAF, lab_txtAngle=75, fileType="MAF")
})

## ----fig.keep='last', fig.width=11, fig.height=5.5, message=FALSE, warning=FALSE, results='hide', tidy=TRUE, error=TRUE----
try({
# Plot the frequency with a different color pallete
TvTi(brcaMAF, type='Frequency', 
palette=c("#77C55D", "#A461B4", "#C1524B", "#93B5BB", "#4F433F", "#BFA753"), 
lab_txtAngle=75, fileType="MAF")
})

## ----fig.keep='last', fig.width=11, fig.height=5.5, message=FALSE, warning=FALSE, results='hide', tidy=TRUE, error=TRUE----
try({
# Create a named vector of apriori expectations
expec <- c("A->C or T->G (TV)"=.066, "A->G or T->C (TI)"=.217,
           "A->T or T->A (TV)"=.065, "G->A or C->T (TI)"=.4945,
           "G->C or C->G (TV)"=.0645, "G->T or C->A (TV)"=.093)

# Call TvTi with the additional data
TvTi(brcaMAF, y=expec, lab_txtAngle=45, fileType="MAF")
})

## ----fig.keep='last', fig.width=10, fig.height=4.5, message=TRUE, warning=FALSE, results='asis', tidy=TRUE, error=TRUE----
try({
# Call cnSpec with minimum required inputs
cnSpec(LucCNseg, genome="hg19")
})

## ----eval=FALSE, tidy=TRUE, error=TRUE----------------------------------------
try({
# # Call cnSpec with the y parameter
# cnSpec(LucCNseg, y=hg19chr)
})

## ----fig.keep='last', fig.width=10, fig.height=6.5, message=FALSE, warning=FALSE, results='asis', tidy=TRUE, error=TRUE----
try({
# Create data
chromosome <- 'chr14'
coordinate <- sort(sample(0:106455000, size=2000, replace=FALSE))
cn <- c(rnorm(300, mean=3, sd=.2), rnorm(700, mean=2, sd=.2), rnorm(1000, mean=3, sd=.2))
data <- as.data.frame(cbind(chromosome, coordinate, cn))

# Call cnView with basic input
cnView(data, chr='chr14', genome='hg19', ideogram_txtSize=4)
})

## ----fig.keep='last', fig.width=10, fig.height=6.5, message=FALSE, warning=FALSE, results='asis', tidy=TRUE, error=TRUE----
try({
# create copy number data
chromosome <- 'chr14'
coordinate <- sort(sample(0:106455000, size=2000, replace=FALSE))
cn <- c(rnorm(300, mean=3, sd=.2), rnorm(700, mean=2, sd=.2), rnorm(1000, mean=3, sd=.2))
data <- as.data.frame(cbind(chromosome, coordinate, cn))

# create segment data
dataSeg <- data.frame(chromosome=c(14, 14, 14), start=coordinate[c(1, 301, 1001)], end=coordinate[c(300, 1000, 2000)], segmean=c(3, 2, 3))
# call cnView with included segment data
cnView(data, z=dataSeg, chr='chr14', genome='hg19', ideogram_txtSize=4)
})

## ----fig.keep='last', fig.width=10, fig.height=6.5, message=TRUE, warning=FALSE, results='asis', tidy=TRUE, error=TRUE----
try({
# Example input to x
x <- matrix(sample(100000,500), nrow=50, ncol=10, 
dimnames=list(0:49,paste0("Sample",1:10)))

covBars(x)
})

## ----fig.keep='last', fig.width=10, fig.height=6.5, message=FALSE, warning=FALSE, results='asis', tidy=TRUE, error=TRUE----
try({
covBars(x, colour=c("blue","grey","red"))
})

## ----eval=FALSE, tidy=TRUE----------------------------------------------------
# cnFreq(LucCNseg)

## ----fig.keep='last', fig.width=11, fig.height=3, message=FALSE, warning=FALSE, results='asis', tidy=TRUE, error=TRUE----
try({
# Obtain cytogenetic information for the genome of interest
data <- cytoGeno[cytoGeno$genome == 'hg38',]

# Call ideoView for chromosome 1
ideoView(data, chromosome='chr1', txtSize=4)
})

## ----fig.keep='last', fig.width=11, fig.height=3, message=FALSE, warning=FALSE, results='asis', tidy=TRUE, error=TRUE----
try({

# Call lohSpec with basic input 
lohSpec(x=HCC1395_Germline)
})

## ----fig.keep='last', fig.width=11, fig.height=5, message=FALSE, warning=FALSE, results='asis', tidy=TRUE, error=TRUE----
try({

# Call lohView with basic input, make sure input contains only Germline calls
lohView(HCC1395_Germline, chr='chr5', genome='hg19', ideogram_txtSize=4)
})

## ----fig.keep='last', fig.width=11, fig.height=8, message=FALSE, warning=FALSE, results='asis', tidy=TRUE, error=TRUE----
try({
# Read in BSgenome object (hg19)
library(BSgenome.Hsapiens.UCSC.hg19)
hg19 <- BSgenome.Hsapiens.UCSC.hg19

# Generate plot
compIdent(genome=hg19, debug=TRUE)
})

## ----fig.keep='last', fig.width=10, fig.height=5, message=FALSE, warning=FALSE, results='hide', tidy=TRUE, error=TRUE----
try({
# need transcript data for reference
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene

# need a biostrings object for reference
genome <- BSgenome.Hsapiens.UCSC.hg19

# need Granges object 
gr <- GRanges(seqnames=c("chr10"), ranges=IRanges(start=c(89622195), 
end=c(89729532)), strand=strand(c("+")))

# Plot and call the graphic
p1 <- geneViz(txdb, gr, genome)
p1[[1]]
})

## ----eval=FALSE, tidy=TRUE, error=TRUE----------------------------------------
try({
# pdf(file="plot.pdf", height=8, width=14)
# # Call a GenVisR function
# waterfall(brcaMAF)
# dev.off()
})

## ----eval=FALSE, tidy=TRUE, error=TRUE----------------------------------------
try({
# library(ggplot2)
# plot_theme <- theme(axis.text.x=element_blank(),
#                     axis.title.x=element_blank(),
#                     axis.ticks.x=element_blank())
# 
# cnFreq(LucCNseg, plotLayer=plot_theme)
})

## ----tidy=TRUE, error=TRUE----------------------------------------------------
try({
sessionInfo()
})

