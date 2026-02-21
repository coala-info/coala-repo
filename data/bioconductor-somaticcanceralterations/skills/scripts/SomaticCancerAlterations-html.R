# Code example from 'SomaticCancerAlterations-html' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
library(SomaticCancerAlterations)
library(GenomicRanges)
library(ggbio)

## ----list_datasets------------------------------------------------------------
all_datasets = scaListDatasets()
print(all_datasets)
meta_data = scaMetadata()
print(meta_data)

## ----load_dataset-------------------------------------------------------------
ov = scaLoadDatasets("ov_tcga", merge = TRUE)

## ----print--------------------------------------------------------------------
head(ov, 3)

## ----summary------------------------------------------------------------------
with(mcols(ov), table(Variant_Classification, Variant_Type))

## -----------------------------------------------------------------------------
head(sort(table(ov$Sample_ID), decreasing = TRUE))
head(sort(table(ov$Hugo_Symbol), decreasing = TRUE), 10)

## ----multiple_studies---------------------------------------------------------
three_studies = scaLoadDatasets(all_datasets[1:3])

print(elementNROWS(three_studies))

class(three_studies)

## ----merge_studies------------------------------------------------------------
merged_studies = scaLoadDatasets(all_datasets[1:3], merge = TRUE)

class(merged_studies)

## ----mutated_genes_study------------------------------------------------------
gene_study_count = with(mcols(merged_studies), table(Hugo_Symbol, Dataset))

gene_study_count = gene_study_count[order(apply(gene_study_count, 1, sum), decreasing = TRUE), ]

gene_study_count = addmargins(gene_study_count)

head(gene_study_count)

## ----subset_studies-----------------------------------------------------------
tp53_region = GRanges("17", IRanges(7571720, 7590863))

tp53_studies = subsetByOverlaps(merged_studies, tp53_region)

## ----variant_study_table------------------------------------------------------
addmargins(table(tp53_studies$Variant_Classification, tp53_studies$Dataset))

## ----mutateted_genes----------------------------------------------------------
fraction_mutated_region = function(y, region) {
    s = subsetByOverlaps(y, region)
    m = length(unique(s$Patient_ID)) / metadata(s)$Number_Patients
    return(m)
}

mutated_fraction = sapply(three_studies, fraction_mutated_region, tp53_region)

mutated_fraction = data.frame(name = names(three_studies), fraction =
mutated_fraction)

## ----plot_mutated_genes-------------------------------------------------------
library(ggplot2)

p = ggplot(mutated_fraction) + ggplot2::geom_bar(aes(x = name, y = fraction,
fill = name), stat = "identity") + ylim(0, 1) + xlab("Study") + ylab("Ratio") +
theme_bw()

print(p)

## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

