# Code example from 'excluderanges' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    fig.path = "../man/figures/README-",
    out.width = "100%",
    warning = FALSE,
    dpi=300
)
library(BiocStyle)

## ----'install1', eval = FALSE, message=FALSE, warning=FALSE-------------------
# # if (!require("BiocManager", quietly = TRUE))
# #     install.packages("BiocManager")
# # BiocManager::install(version = "3.16")

## ----'install2', eval = FALSE, message=FALSE, warning=FALSE-------------------
# # BiocManager::install("AnnotationHub", update = FALSE)
# # BiocManager::install("GenomicRanges", update = FALSE)
# # BiocManager::install("plyranges", update = FALSE)

## ----AnnotationHub------------------------------------------------------------
suppressMessages(library(GenomicRanges))
suppressMessages(library(AnnotationHub))
ah <- AnnotationHub()
query_data <- subset(ah, preparerclass == "excluderanges")
# You can search for multiple terms
# query_data <- query(ah, c("excluderanges", "Kundaje", "hg38"))
query_data

## ----hg38excluderanges--------------------------------------------------------
library(GenomeInfoDb)  # for keepStandardChromosomes()
excludeGR.hg38.Kundaje.1 <- query_data[["AH107305"]]
# Always a good idea to sort GRanges and keep standard chromosomes
excludeGR.hg38.Kundaje.1 <- excludeGR.hg38.Kundaje.1 %>% 
  sort() %>% keepStandardChromosomes(pruning.mode = "tidy")
excludeGR.hg38.Kundaje.1

## ----eval=FALSE---------------------------------------------------------------
# # Note that rtracklayer::import and rtracklayer::export perform unexplained
# # start coordinate conversion, likely related to 0- and 1-based coordinate
# # system. We recommend converting GRanges to a data frame and save tab-separated
# write.table(as.data.frame(excludeGR.hg38.Kundaje.1),
#             file = "hg38.Kundaje.GRCh38_unified_Excludable.bed",
#             sep = "\t", row.names = FALSE, col.names = FALSE, quote = FALSE)

## ----allhg38excluderanges-----------------------------------------------------
query_data <- query(ah, c("excluderanges", "hg38"))
query_data
excludeGR.hg38.Bernstein <- query_data[["AH107306"]]
excludeGR.hg38.Boyle     <- query_data[["AH107307"]]
excludeGR.hg38.Kundaje.2 <- query_data[["AH107308"]]
excludeGR.hg38.Lareau    <- query_data[["AH107309"]]
excludeGR.hg38.Reddy     <- query_data[["AH107310"]]
excludeGR.hg38.Wimberley <- query_data[["AH107311"]]
excludeGR.hg38.Wold      <- query_data[["AH107312"]]
excludeGR.hg38.Yeo       <- query_data[["AH107313"]]

## ----excluderanges_hg38_count, fig.width=6.5, fig.height=2--------------------
library(ggplot2)
mtx_to_plot <- data.frame(Count = c(length(excludeGR.hg38.Bernstein), 
                                    length(excludeGR.hg38.Boyle),
                                    length(excludeGR.hg38.Kundaje.1), 
                                    length(excludeGR.hg38.Kundaje.2), 
                                    length(excludeGR.hg38.Lareau),
                                    length(excludeGR.hg38.Reddy), 
                                    length(excludeGR.hg38.Wimberley),
                                    length(excludeGR.hg38.Wold), 
                                    length(excludeGR.hg38.Yeo)),
                          Source = c("Bernstein.Mint_Excludable_GRCh38", 
                                     "Boyle.hg38-Excludable.v2",
                                     "Kundaje.GRCh38_unified_Excludable", 
                                     "Kundaje.GRCh38.Excludable", 
                                     "Lareau.hg38.full.Excludable",
                                     "Reddy.wgEncodeDacMapabilityConsensusExcludable", 
                                     "Wimberley.peakPass60Perc_sorted",
                                     "Wold.hg38mitoExcludable", 
                                     "Yeo.eCLIP_Excludableregions.hg38liftover.bed"))
# Order Source by the number of regions
mtx_to_plot$Source <- factor(mtx_to_plot$Source, levels = mtx_to_plot$Source[order(mtx_to_plot$Count)])

ggplot(mtx_to_plot, aes(x = Source, y = Count, fill = Source)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  theme_bw() + theme(legend.position = "none")
# ggsave("../man/figures/excluderanges_hg38_count.png", width = 5.5, height = 2)

## ----echo=FALSE, eval=FALSE---------------------------------------------------
# knitr::include_graphics('../man/figures/excluderanges_hg38_count.png')

## ----excluderanges_hg38_width, fig.width=6.5, fig.height=2, message=FALSE-----
library(ggridges)
library(dplyr)
mtx_to_plot <- data.frame(Width = c(width(excludeGR.hg38.Bernstein), 
                                    width(excludeGR.hg38.Boyle),
                                    width(excludeGR.hg38.Kundaje.1), 
                                    width(excludeGR.hg38.Kundaje.2), 
                                    width(excludeGR.hg38.Lareau),
                                    width(excludeGR.hg38.Reddy), 
                                    width(excludeGR.hg38.Wimberley),
                                    width(excludeGR.hg38.Wold), 
                                    width(excludeGR.hg38.Yeo)),
                          Source = c(rep("Bernstein.Mint_Excludable_GRCh38", length(excludeGR.hg38.Bernstein)),
                                     rep("Boyle.hg38-Excludable.v2", length(excludeGR.hg38.Boyle)),
                                     rep("Kundaje.GRCh38_unified_Excludable", length(excludeGR.hg38.Kundaje.1)),
                                     rep("Kundaje.GRCh38.Excludable", length(excludeGR.hg38.Kundaje.2)),
                                     rep("Lareau.hg38.full.Excludable", length(excludeGR.hg38.Lareau)),
                                     rep("Reddy.wgEncodeDacMapabilityConsensusExcludable", length(excludeGR.hg38.Reddy)),
                                     rep("Wimberley.peakPass60Perc_sorted", length(excludeGR.hg38.Wimberley)),
                                     rep("Wold.hg38mitoExcludable", length(excludeGR.hg38.Wold)),
                                     rep("Yeo.eCLIP_Excludableregions.hg38liftover.bed", length(excludeGR.hg38.Yeo))))

# Order objects by decreasing width
mtx_to_plot$Source <- factor(mtx_to_plot$Source, levels = mtx_to_plot %>% 
                               group_by(Source) %>% summarise(Mean = mean(Width)) %>% 
                               arrange(Mean) %>% pull(Source))
ggplot(mtx_to_plot, aes(x = log2(Width), y = Source, fill = Source)) +
  geom_density_ridges() +
  theme_bw() + theme(legend.position = "none")
# ggsave("../man/figures/excluderanges_hg38_width.png", width = 5.5, height = 2)

## ----echo=FALSE, eval=FALSE---------------------------------------------------
# knitr::include_graphics('../man/figures/excluderanges_hg38_width.png')

## ----excluderanges_hg38_sumwidth, fig.width=6.5, fig.height=3-----------------
mtx_to_plot <- data.frame(TotalWidth = c(sum(width(excludeGR.hg38.Bernstein)), 
                                         sum(width(excludeGR.hg38.Boyle)),
                                         sum(width(excludeGR.hg38.Kundaje.1)), 
                                         sum(width(excludeGR.hg38.Kundaje.2)), 
                                         sum(width(excludeGR.hg38.Lareau)),
                                         sum(width(excludeGR.hg38.Reddy)), 
                                         sum(width(excludeGR.hg38.Wimberley)),
                                         sum(width(excludeGR.hg38.Wold)), 
                                         sum(width(excludeGR.hg38.Yeo))), 
                          Source = c("Bernstein.Mint_Excludable_GRCh38", 
                                     "Boyle.hg38-Excludable.v2",
                                     "Kundaje.GRCh38_unified_Excludable", 
                                     "Kundaje.GRCh38.Excludable", 
                                     "Lareau.hg38.full.Excludable",
                                     "Reddy.wgEncodeDacMapabilityConsensusExcludable", 
                                     "Wimberley.peakPass60Perc_sorted",
                                     "Wold.hg38mitoExcludable", 
                                     "Yeo.eCLIP_Excludableregions.hg38liftover.bed"))
# Order objects by decreasing width
mtx_to_plot$Source <- factor(mtx_to_plot$Source, levels = mtx_to_plot %>% 
                               group_by(Source) %>% arrange(TotalWidth) %>% pull(Source))

ggplot(mtx_to_plot, aes(x = TotalWidth, y = Source, fill = Source)) + 
  geom_bar(stat="identity") + scale_x_log10() + scale_y_discrete(label=abbreviate, limits=rev) +
  xlab("log10 total width")
# ggsave("../man/figures/excluderanges_hg38_sumwidth.png", width = 6.5, height = 2)

## ----echo=FALSE, eval=FALSE---------------------------------------------------
# knitr::include_graphics('../man/figures/excluderanges_hg38_sumwidth.png')

## ----excluderanges_hg38_overlap_coefficient, warning=FALSE, fig.width=6.5, fig.height=6----
library(pheatmap)
library(stringr)
# Overlap coefficient calculations
overlap_coefficient <- function(gr_a, gr_b) {
  intersects <- GenomicRanges::intersect(gr_a, gr_b, ignore.strand = TRUE)
  intersection_width <- sum(width(intersects))
  min_width <- min(sum(width(gr_a)), sum(width(gr_b)))
  DataFrame(intersection_width, min_width, 
            overlap_coefficient = intersection_width/min_width,
             n_intersections = length(intersects))
}
# List and names of all excludable regions
all_excludeGR_list <- list(excludeGR.hg38.Bernstein, 
                            excludeGR.hg38.Boyle,
                            excludeGR.hg38.Kundaje.1, 
                            excludeGR.hg38.Kundaje.2,
                            excludeGR.hg38.Lareau,
                            excludeGR.hg38.Reddy,
                            excludeGR.hg38.Wimberley,
                            excludeGR.hg38.Wold,
                            excludeGR.hg38.Yeo)
all_excludeGR_name <- c("Bernstein.Mint_Excludable_GRCh38", 
                         "Boyle.hg38-Excludable.v2",
                         "Kundaje.GRCh38_unified_Excludable", 
                         "Kundaje.GRCh38.Excludable", 
                         "Lareau.hg38.full.Excludable",
                         "Reddy.wgEncodeDacMapabilityConsensusExcludable", 
                         "Wimberley.peakPass60Perc_sorted",
                         "Wold.hg38mitoExcludable", 
                         "Yeo.eCLIP_Excludableregions.hg38liftover.bed")
# Correlation matrix, empty
mtx_to_plot <- matrix(data = 0, nrow = length(all_excludeGR_list), ncol = length(all_excludeGR_list))
# Fill it in
for (i in 1:length(all_excludeGR_list)) {
  for (j in 1:length(all_excludeGR_list)) {
    # If diagonal, set to zero
    if (i == j) mtx_to_plot[i, j] <- 0
    # Process only one half, the other is symmetric
    if (i > j) {
      mtx_to_plot[i, j] <- mtx_to_plot[j, i] <- overlap_coefficient(all_excludeGR_list[[i]], all_excludeGR_list[[j]])[["overlap_coefficient"]]
    }
  }
}
# Trim row/colnames
rownames(mtx_to_plot) <- colnames(mtx_to_plot) <- str_trunc(all_excludeGR_name, width = 25) 
# Save the plot
# png("../man/figures/excluderanges_hg38_jaccard.png", width = 1000, height = 900, res = 200)
pheatmap(data.matrix(mtx_to_plot), clustering_method = "ward.D")
# dev.off()

## ----echo=FALSE, eval=FALSE---------------------------------------------------
# knitr::include_graphics('../man/figures/excluderanges_hg38_jaccard.png')

## ----excluderanges_hg38_Reddy_metadata, fig.width=6.5, fig.height=3-----------
mcols(excludeGR.hg38.Reddy)
mtx_to_plot <- table(mcols(excludeGR.hg38.Reddy)[["name"]]) %>%
  as.data.frame()
colnames(mtx_to_plot) <- c("Type", "Number")
mtx_to_plot <- mtx_to_plot[order(mtx_to_plot$Number), ]
mtx_to_plot$Type <- factor(mtx_to_plot$Type, 
                           levels = mtx_to_plot$Type)
ggplot(mtx_to_plot, aes(x = Number, y = Type, fill = Type)) +
  geom_bar(stat="identity") +
  theme_bw() + theme(legend.position = "none")
# ggsave("../man/figures/excluderanges_hg38_Reddy_metadata.png", width = 5, height = 2.5)

## ----echo=FALSE, eval=FALSE---------------------------------------------------
# knitr::include_graphics('../man/figures/excluderanges_hg38_Reddy_metadata.png')

## ----combinedexcluderanges, warning=FALSE-------------------------------------
excludeGR.hg38.all <- reduce(c(excludeGR.hg38.Bernstein, 
                               excludeGR.hg38.Boyle,
                               excludeGR.hg38.Kundaje.1, 
                               excludeGR.hg38.Kundaje.2, 
                               excludeGR.hg38.Lareau,
                               excludeGR.hg38.Reddy, 
                               excludeGR.hg38.Wimberley,
                               excludeGR.hg38.Wold, 
                               excludeGR.hg38.Yeo))
# Sort and Keep only standard chromosomes
excludeGR.hg38.all <- excludeGR.hg38.all %>% sort %>% 
  keepStandardChromosomes(pruning.mode = "tidy")
print(length(excludeGR.hg38.all))
summary(width(excludeGR.hg38.all))

## -----------------------------------------------------------------------------
query_data[grepl("mito", query_data$description, ignore.case = TRUE), ]
hg38.Lareau.hg38_peaks <- query_data[["AH107343"]]

## ----eval=FALSE, echo=FALSE---------------------------------------------------
# suppressMessages(library(httr))
# # Get hg38.Lareau.hg38_peaks BEDbase ID
# bedbase_id <- "9fa55701a3bd3e7a598d1d2815e3390f"
# # Construct output file name
# fileNameOut <- "hg38.Lareau.hg38_peak.bed.gz"
# # API token for BED data
# token2 <- paste0("http://bedbase.org/api/bed/", bedbase_id, "/file/bed")
# # Download file
# GET(url = token2, write_disk(fileNameOut, overwrite = TRUE)) # , verbose()
# # Read the data in
# hg38.Lareau.hg38_peaks <- read.table(fileNameOut, sep = "\t", header = FALSE)
# # Assign column names depending on the number of columns
# all_columns <- c("chr", "start", "stop", "name", "score", "strand",
#                  "signalValue", "pValue", "qValue", "peak")
# colnames(hg38.Lareau.hg38_peaks) <- all_columns[1:ncol(hg38.Lareau.hg38_peaks)]
# # Convert to GRanges object
# hg38.Lareau.hg38_peaks <- makeGRangesFromDataFrame(hg38.Lareau.hg38_peaks,
#                                                    keep.extra.columns = TRUE)
# hg38.Lareau.hg38_peaks

## ----eval=FALSE---------------------------------------------------------------
# # Search for the gap track
# # ahData <- query(ah, c("gap", "Homo sapiens", "hg19"))
# # ahData[ahData$title == "Gap"]
# gaps <- ahData[["AH6444"]]

## ----gapcounts, echo=FALSE, out.height="70%", out.width="70%"-----------------
suppressMessages(library(rtracklayer))
# knitr::include_graphics('../man/figures/excluderanges_hg19_gaps_number.png')
# Get genome-specific gaps table
mySession <- browserSession()
genome(mySession) <- "hg19"
query <- ucscTableQuery(mySession, table = "gap")
gaps <- getTable(query)
# Number of regions per gap type
mtx_to_plot <- as.data.frame(table(gaps$type))
colnames(mtx_to_plot) <- c("Type", "Number")
mtx_to_plot <- mtx_to_plot[order(mtx_to_plot$Number), ]
mtx_to_plot$Type <- factor(mtx_to_plot$Type, levels = mtx_to_plot$Type)
ggplot(mtx_to_plot, aes(x = Number, y = Type, fill = Type)) +
  geom_bar(stat="identity") +
  theme_bw() + theme(legend.position = "none")
# ggsave("../man/figures/excluderanges_hg19_gaps_number.png", width = 5, height = 2.5)

## ----gapshg38-----------------------------------------------------------------
query_data <- query(ah, c("excluderanges", "UCSC", "Homo Sapiens", "hg38"))
query_data

gapsGR_hg38_centromere <- query_data[["AH107354"]]
gapsGR_hg38_centromere

## ----eval=FALSE---------------------------------------------------------------
# # hg38 CUT&RUN exclusion set, BED
# download.file("https://drive.google.com/uc?export=download&id=1rKIu7kdiEySTi-cq3nYxXJP4VQX1IPcS",
#               destfile = "hg38.Nordin.CandRblacklist_hg38.bed")
# # hg38 CUT&RUN exclusion set, RDS
# download.file("https://drive.google.com/uc?export=download&id=1JuB1h-QQUw1mddBavI7CIuH7R-lwwczU",
#               destfile = "hg38.Nordin.CandRblacklist_hg38.rds")
# # And then load the GRanges object
# mtx <- readRDS("hg38.Nordin.CandRblacklist_hg38.rds")

## ----eval=FALSE---------------------------------------------------------------
# # mm10 CUT&RUN exclusion set, BED
# download.file("https://drive.google.com/uc?export=download&id=1CRAojdphMbAzd3MnW_UmO1WtsDrHsrU1",
#               destfile = "mm10.Nordin.CandRblacklist_mm10.bed")
# # mm10 CUT&RUN exclusion set, RDS
# download.file("https://drive.google.com/uc?export=download&id=1orPXLWUZ4-C4n_Jt2gH-WERLpY9Kn0t_",
#               destfile = "mm10.Nordin.CandRblacklist_mm10.rds")

## ----echo=FALSE---------------------------------------------------------------
mtx <- read.csv("../man/figures/Table_S1.csv")
# mtx$BEDbase.URL <- ifelse(!is.na(mtx$BEDbase.ID), paste0("[link](http://bedbase.org/#/bedsplash/", mtx$BEDbase.ID, ")"), "NA")
knitr::kable(mtx[, c("Name", "Ahub.IDs.BioC.3.16.and.above", "Description", "Filtered.Region.count")]) # "BEDbase.URL", 

## ----'citation', eval = requireNamespace('excluderanges')---------------------
print(citation("excluderanges"), bibtex = TRUE)

## -----------------------------------------------------------------------------
sessionInfo()

