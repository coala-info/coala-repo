# Code example from 'hic_vignette' vignette. See references/ for full tutorial.

## ----options, echo=FALSE------------------------------------------------------
options("scipen"=10, "digits"=5)

## ----imports, warning=F, results="hide", message=FALSE------------------------
library(Gviz)
library(GenomicInteractions)
library(GenomicRanges)
library(InteractionSet)


## -----------------------------------------------------------------------------
hic_file <- system.file("extdata", "Seitan2013_WT_100kb_interactions.txt", 
                        package="GenomicInteractions")

hic_data <- makeGenomicInteractionsFromFile(hic_file, 
                    type="homer", 
                    experiment_name = "HiC 100kb", 
                    description = "HiC 100kb resolution")
seqlengths(hic_data) <- c(chr15 = 103494974, chr14 = 125194864)

## -----------------------------------------------------------------------------
hic_data
mcols(hic_data)
head(hic_data$LogP)
hic_data$p.value <- exp(hic_data$LogP)

## -----------------------------------------------------------------------------
regions(hic_data)
anchors(hic_data, type = "first")
head(anchors(hic_data, type = "first", id = TRUE))
anchorOne(hic_data)

## -----------------------------------------------------------------------------
summary(width(regions(hic_data)))

## -----------------------------------------------------------------------------
head(interactionCounts(hic_data))
mean(interactionCounts(hic_data))

## -----------------------------------------------------------------------------
plot(density(hic_data$p.value))

hic_data$fdr <- hic_data$FDR.Benjamini..based.on.3.68e.08.total.tests.
plot(density(hic_data$fdr))

## -----------------------------------------------------------------------------
sum(hic_data$fdr < 0.1)
hic_data_subset <- hic_data[hic_data$fdr < 0.1]

## -----------------------------------------------------------------------------
plotCisTrans(hic_data)
plotCisTrans(hic_data_subset)

plotCounts(hic_data, cut=30)
plotCounts(hic_data_subset, cut=30)

## ----eval=FALSE---------------------------------------------------------------
# ## Not run
# library(GenomicFeatures)
# mm9.refseq.db <- makeTxDbFromUCSC(genome="mm9", table="refGene")
# refseq.genes = genes(mm9.refseq.db)
# refseq.transcripts = transcriptsBy(mm9.refseq.db, by="gene")
# refseq.transcripts = refseq.transcripts[ names(refseq.transcripts) %in% unlist(refseq.genes$gene_id) ]
# mm9_refseq_promoters <- promoters(refseq.transcripts, 2500,2500)
# mm9_refseq_promoters <- unlist(mm9_refseq_promoters[seqnames(mm9_refseq_promoters) %in% c("chr14", "chr15")])
# mm9_refseq_promoters <- unique(mm9_refseq_promoters) # some duplicate promoters from different transcript isoforms
# 
# #get gene symbols
# mart = useMart("ensembl", dataset="mmusculus_gene_ensembl")
# genes <- getBM(attributes = c("mgi_symbol", "refseq_mrna"), filter = "refseq_mrna",
#                values = mm9_refseq_promoters$tx_name, mart = mart)
# mm9_refseq_promoters$geneSymbol <- genes$mgi_symbol[match(mm9_refseq_promoters$tx_name, genes$refseq_mrna)]
# 
# names(mm9_refseq_promoters) <- mm9_refseq_promoters$geneSymbol
# na.symbol <- is.na(names(mm9_refseq_promoters))
# names(mm9_refseq_promoters)[na.symbol] <- mm9_refseq_promoters$tx_name[na.symbol]

## ----eval=FALSE---------------------------------------------------------------
# #Not run
# 
# ## get enhancers from http://chromosome.sdsc.edu/mouse/download.html
# download.file("http://chromosome.sdsc.edu/mouse/download/thymus.zip", "thymus.zip")
# unzip("thymus.zip")
# thymus_enh <- read.table("thymus/thymus.enhancer.txt", sep="\t", stringsAsFactors = FALSE)
# thymus_enh <- GRanges(seqnames=thymus_enh$V1, ranges=IRanges(thymus_enh$V2, width=1))
# thymus_enh <- resize(thymus_enh, fix="center", width=500)
# thymus_enh <- thymus_enh[seqnames(thymus_enh) %in% c("chr14", "chr15")]
# names(thymus_enh) <- paste("ENH", as.character(thymus_enh), sep = "_")

## -----------------------------------------------------------------------------
data("mm9_refseq_promoters")
data("thymus_enhancers")
annotation.features <- list(promoter = mm9_refseq_promoters, enhancer = thymus_enh)
annotateInteractions(hic_data_subset, annotation.features)

## -----------------------------------------------------------------------------
head(regions(hic_data_subset))
head(regions(hic_data_subset)$promoter.id)

## -----------------------------------------------------------------------------
table(regions(hic_data_subset)$node.class)

## -----------------------------------------------------------------------------
plotInteractionAnnotations(hic_data_subset, legend = TRUE)

## -----------------------------------------------------------------------------
length(hic_data_subset[isInteractionType(hic_data_subset, "promoter", "distal")])

## -----------------------------------------------------------------------------
length(hic_data_subset[is.pd(hic_data_subset)])
sum(is.trans(hic_data_subset))

## -----------------------------------------------------------------------------
hic_data_ep <- hic_data_subset[isInteractionType(hic_data_subset, "promoter", "enhancer")]

max(interactionCounts(hic_data_ep))
most_counts <- hic_data_ep[which.max(interactionCounts(hic_data_ep))]
most_counts

## -----------------------------------------------------------------------------
min(hic_data_ep$p.value)
min_pval <- hic_data_ep[which.min(hic_data_ep$p.value)]
min_pval

## -----------------------------------------------------------------------------
calculateDistances(most_counts, method="midpoint")
calculateDistances(min_pval,method="midpoint")
summary(calculateDistances(hic_data_subset,method="midpoint"))

## -----------------------------------------------------------------------------
anchorOne(most_counts)$promoter.id
anchorTwo(most_counts)$enhancer.id

## -----------------------------------------------------------------------------
Trib1_region <- resize(mm9_refseq_promoters["Trib1"], fix = "center", width = 1000000)
interaction_track <- InteractionTrack(hic_data_subset, name = "HiC", chromosome = "chr15")
plotTracks(interaction_track, chromosome="chr15", 
           from=start(Trib1_region), to=end(Trib1_region))

## -----------------------------------------------------------------------------
promoterTrack <- AnnotationTrack(mm9_refseq_promoters, genome="mm9", name="Promoters",
                             id=names(mm9_refseq_promoters),  featureAnnotation="id")
enhTrack <- AnnotationTrack(thymus_enh, genome="mm9", name="Enhancers", stacking = "dense")

displayPars(promoterTrack) <- list(fill = "deepskyblue", col = NA, 
                                   fontcolor.feature = "black", fontsize=8,
                                   just.group="below")
displayPars(enhTrack) <- list(fill = "black", col = NA)
displayPars(interaction_track) = list(col.interactions="red", 
                                      col.anchors.fill ="blue",
                                      col.anchors.line = "black",
                                      interaction.dimension="height", 
                                      interaction.measure ="counts",
                                      plot.trans=FALSE,
                                      plot.outside = TRUE, 
                                      col.outside="lightblue", 
                                      anchor.height = 0.1)

plotTracks(list(interaction_track, promoterTrack, enhTrack),
           chromosome="chr15", from=start(Trib1_region), to=end(Trib1_region), 
           sizes=c(0.6, 0.2, 0.2))

## ----eval=FALSE---------------------------------------------------------------
# ## Not run
# export.bed12(hic_data_subset, fn="hic_data_FDR0.1.bed", drop.trans = TRUE)

