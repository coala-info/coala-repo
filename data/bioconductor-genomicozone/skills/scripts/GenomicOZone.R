# Code example from 'GenomicOZone' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message=F, warning=F, results = "hide"----------------------------
require(GenomicOZone)
# require(GEOquery)
require(readxl)

## ----message=F, warning=F, results = "hide"-----------------------------------
# Obtain data matrix from GSE76167 supplementary file
# invisible(getGEOSuppFiles("GSE76167"))
# data <- read_excel(".//GSE76167_GeneFPKM_AllSamples.xlsx")
file <- system.file("extdata", "GSE76167_GeneFPKM_AllSamples.xlsx", package = "GenomicOZone", mustWork = TRUE)
data <- read_excel(file)

# Adjust the input data
data.info <- data[,1:5]
data <- data[,-c(1:5)]
data <- data[,substr(colnames(data), 1, 4) == "FPKM"]
data <- data.matrix(data[,c(1,5,6,3,4,2)])
colnames(data) <- c(paste(rep("WT",3), "_", c(1,2,3), sep=""), 
                    paste(rep("Ni",3), "_", c(1,2,3), sep=""))
rownames(data) <- data.info$tracking_id


# Obtain genes
data.genes <- data.info$gene_short_name
data.genes[data.genes == "-"] <- data.info$tracking_id[data.genes == "-"]


# Create colData
colData <- data.frame(Sample_name = colnames(data),
                      Condition = factor(rep(c("WT", "Ni"), each = 3), 
                                         levels = c("WT", "Ni")))


# Create design
design <- ~ Condition


# Create rowData.GRanges
pattern <- "(.[^\\:]*)\\:([0-9]+)\\-([0-9]+)"
matched <- regexec(pattern, as.character(data.info$locus))
values <- regmatches(as.character(data.info$locus), matched)
data.gene.coor <-  data.frame(chr = as.character(sapply(values, function(x){x[[2]]})),
                              start = as.numeric(sapply(values, function(x){x[[3]]})),
                              end = as.numeric(sapply(values, function(x){x[[4]]})))
rownames(data.gene.coor) <- as.character(data.info$tracking_id)
rowData.GRanges <- GRanges(seqnames = data.gene.coor$chr,
                           IRanges(start = data.gene.coor$start, 
                                   end = data.gene.coor$end),
                           Gene.name = data.genes)
names(rowData.GRanges) <- data.info$tracking_id

chr.size <- 4646332
names(chr.size) <- "NC_007779"
seqlevels(rowData.GRanges) <- names(chr.size)
seqlengths(rowData.GRanges) <- chr.size

## -----------------------------------------------------------------------------
# Create an input object also checking for data format, consistency, and completeness
GOZ.ds <- GOZDataSet(data = data,
                     colData = colData,
                     design = design,
                     rowData.GRanges = rowData.GRanges)


# Run the outstanding zone analysis
GOZ.ds <- GenomicOZone(GOZ.ds)

## -----------------------------------------------------------------------------
# Extract gene/zone GRanges object
Gene.GRanges <- extract_genes(GOZ.ds)
head(Gene.GRanges)

Zone.GRanges <- extract_zones(GOZ.ds)
head(Zone.GRanges)

# min.effect.size = 0.36 is chosen from the 
#     minumum of top 5% effect size values
OZone.GRanges <- extract_outstanding_zones(
                              GOZ.ds,
                              alpha = 0.05, 
                              min.effect.size = 0.36)
head(OZone.GRanges)


Zone.exp.mat <- extract_zone_expression(GOZ.ds)
head(Zone.exp.mat)

## ----out.width = "100%", out.height = "100%", fig.align="center"--------------
# Genome-wide overview
plot_genome(GOZ.ds, plot.file = "E_coli_genome.pdf",
            plot.width = 15, plot.height = 4,
            alpha = 0.05, min.effect.size = 0.36)
knitr::include_graphics("E_coli_genome.pdf")

## ----out.width = "100%", out.height = "100%", fig.align="center"--------------
# Within-chromosome heatmap
plot_chromosomes(GOZ.ds, plot.file = "E_coli_chromosome.pdf",
                 plot.width = 20, plot.height = 4,
                 alpha = 0.05, min.effect.size = 0.36)
knitr::include_graphics("E_coli_chromosome.pdf")

## ----out.width = "50%", out.height = "100%", fig.align="center"---------------
# Within-zone expression
plot_zones(GOZ.ds, plot.file = "E_coli_zone.pdf", 
           plot.all.zones = FALSE,
           alpha = 0.05, min.effect.size = 0.36)
knitr::include_graphics("E_coli_zone.pdf")

