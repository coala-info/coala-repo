# Code example from 'chiapet_vignette' vignette. See references/ for full tutorial.

## ----global_chunk_opts, echo=F, include=F, eval=FALSE-------------------------
# library(knitr)
# opts_chunk$set(fig.width=12, fig.height=8)

## ----imports, warning=F, results="hide"---------------------------------------
library(GenomicInteractions)
library(InteractionSet)
library(GenomicRanges)

## ----load_data----------------------------------------------------------------
chiapet.data = system.file("extdata/k562.rep1.cluster.pet3+.txt", 
                           package="GenomicInteractions")

k562.rep1 = makeGenomicInteractionsFromFile(chiapet.data, 
                                type="chiapet.tool", 
                                experiment_name="k562", 
                                description="k562 pol2 8wg16")

## ----metadata-----------------------------------------------------------------
name(k562.rep1)
description(k562.rep1) = "PolII-8wg16 Chia-PET for K562"

## ----gi_data_access-----------------------------------------------------------
head(interactionCounts(k562.rep1))
head((k562.rep1)$fdr)
hist(-log10(k562.rep1$p.value))

## ----anchor_access------------------------------------------------------------
anchorOne(k562.rep1)
anchorTwo(k562.rep1)

## ----trans--------------------------------------------------------------------
sprintf("Percentage of trans-chromosomal interactions %.2f", 
        100*sum(is.trans(k562.rep1))/length(k562.rep1))

## ----short_range_interactions-------------------------------------------------
head(calculateDistances(k562.rep1, method="midpoint"))

## ----subsetting---------------------------------------------------------------
k562.rep1[1:10] # first interactions in the dataset
k562.rep1[sample(length(k562.rep1), 100)] # 100 interactions subsample
k562.cis = k562.rep1[is.cis(k562.rep1)]

## ----susbet_distance----------------------------------------------------------
head(calculateDistances(k562.cis, method="midpoint"))
k562.short = k562.cis[calculateDistances(k562.cis) < 1e6] # subset shorter interactions
hist(calculateDistances(k562.short)) 

## ----subset_chr---------------------------------------------------------------
chrom = c("chr17", "chr18")
sub = as.vector(seqnames(anchorOne(k562.rep1)) %in% chrom & seqnames(anchorTwo(k562.rep1)) %in% chrom)
k562.rep1 = k562.rep1[sub]

## ----annotation_features, eval=F----------------------------------------------
# library(GenomicFeatures)
# 
# hg19.refseq.db <- makeTxDbFromUCSC(genome="hg19", table="refGene")
# refseq.genes = genes(hg19.refseq.db)
# refseq.transcripts = transcriptsBy(hg19.refseq.db, by="gene")
# non_pseudogene = names(refseq.transcripts) %in% unlist(refseq.genes$gene_id)
# refseq.transcripts = refseq.transcripts[non_pseudogene]

## ----load_trascripts----------------------------------------------------------
data("hg19.refseq.transcripts")
refseq.transcripts = hg19.refseq.transcripts

## ----magic--------------------------------------------------------------------
refseq.promoters = promoters(refseq.transcripts, upstream=2500, downstream=2500)
# unlist object so "strand" is one vector
refseq.transcripts.ul = unlist(refseq.transcripts) 
# terminators can be called as promoters with the strand reversed
strand(refseq.transcripts.ul) = ifelse(strand(refseq.transcripts.ul) == "+", "-", "+") 
refseq.terminators.ul = promoters(refseq.transcripts.ul, upstream=1000, downstream=1000) 
# change back to original strand
strand(refseq.terminators.ul) = ifelse(strand(refseq.terminators.ul) == "+", "-", "+") 
# `relist' maintains the original names and structure of the list
refseq.terminators = relist(refseq.terminators.ul, refseq.transcripts)

## ----overlaps_methods---------------------------------------------------------
subsetByFeatures(k562.rep1, unlist(refseq.promoters))

## ----annotation---------------------------------------------------------------
annotation.features = list(promoter=refseq.promoters, 
                           terminator=refseq.terminators, 
                           gene.body=refseq.transcripts)
annotateInteractions(k562.rep1, annotation.features)
annotationFeatures(k562.rep1)

## ----node.class---------------------------------------------------------------
p.one = anchorOne(k562.rep1)$node.class == "promoter"
p.two = anchorTwo(k562.rep1)$node.class == "promoter"
k562.rep1[p.one|p.two]

## ----categorise_interactions--------------------------------------------------
categoriseInteractions(k562.rep1)

## ----is_interaction_type------------------------------------------------------
k562.rep1[isInteractionType(k562.rep1, "terminator", "gene.body")]

## ----short_types, eval=F------------------------------------------------------
# k562.rep1[is.pp(k562.rep1)] # promoter-promoter interactions
# k562.rep1[is.dd(k562.rep1)] # distal-distal interactions
# k562.rep1[is.pt(k562.rep1)] # promoter-terminator interactions

## ----interaction_classes------------------------------------------------------
plotInteractionAnnotations(k562.rep1, other=5)

## ----promoter_classes, warning=F----------------------------------------------
plotInteractionAnnotations(k562.rep1, other=5, viewpoints="promoter")

## ----summarise, warning=F-----------------------------------------------------
k562.rep1.promoter.annotation = summariseByFeatures(k562.rep1, refseq.promoters, 
                                                    "promoter", distance.method="midpoint", 
                                                    annotate.self=TRUE)
colnames(k562.rep1.promoter.annotation)

## ----p.p.interactions---------------------------------------------------------
i = order(k562.rep1.promoter.annotation$numberOfPromoterPromoterInteractions, 
          decreasing=TRUE)[1:10]
k562.rep1.promoter.annotation[i,"Promoter.id"]

## ----enhancers----------------------------------------------------------------
i = order(k562.rep1.promoter.annotation$numberOfUniquePromoterDistalInteractions, 
          decreasing=TRUE)[1:10]
k562.rep1.promoter.annotation[i,"Promoter.id"]

## ----terminators--------------------------------------------------------------
total = sum(k562.rep1.promoter.annotation$numberOfPromoterTerminatorInteractions > 0)
sprintf("%.2f%% of promoters have P-T interactions", 100*total/nrow(k562.rep1.promoter.annotation))

