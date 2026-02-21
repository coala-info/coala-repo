# Code example from 'cageminer' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL
)

## ----cit, eval = requireNamespace('cageminer')--------------------------------
print(citation('cageminer'), bibtex = TRUE)

## ----installation, eval=FALSE-------------------------------------------------
# if(!requireNamespace('BiocManager', quietly = TRUE))
#   install.packages('BiocManager')
# BiocManager::install("cageminer")

## ----load_package, message=FALSE----------------------------------------------
# Load package after installation
library(cageminer)
set.seed(123) # for reproducibility

## ----data_description---------------------------------------------------------
# GRanges of SNP positions
data(snp_pos)
snp_pos

# GRanges of chromosome lengths
data(chr_length) 
chr_length

# GRanges of gene coordinates
data(gene_ranges) 
gene_ranges

# SummarizedExperiment of pepper response to Phytophthora root rot (RNA-seq)
data(pepper_se)
pepper_se

## ----snp_dist-----------------------------------------------------------------
plot_snp_distribution(snp_pos)

## ----snp_circos, fig.height=6-------------------------------------------------
plot_snp_circos(chr_length, gene_ranges, snp_pos)

## ----multiple_traits----------------------------------------------------------
# Simulate multiple traits by sampling 20 SNPs 4 times
snp_list <- GenomicRanges::GRangesList(
  Trait1 = sample(snp_pos, 20),
  Trait2 = sample(snp_pos, 20),
  Trait3 = sample(snp_pos, 20),
  Trait4 = sample(snp_pos, 20)
)

# Visualize SNP distribution across chromosomes
plot_snp_distribution(snp_list)

## ----snp_circos_multiple, fig.height=6----------------------------------------
# Visualize SNP positions in the genome as a circos plot
plot_snp_circos(chr_length, gene_ranges, snp_list)

## ----step_by_step-------------------------------------------------------------
candidates1 <- mine_step1(gene_ranges, snp_pos)
candidates1
length(candidates1)

## ----simulate_windows---------------------------------------------------------
# Single trait
simulate_windows(gene_ranges, snp_pos)

# Multiple traits
simulate_windows(gene_ranges, snp_list)

## ----step2--------------------------------------------------------------------
# Load guide genes
data(guides)
head(guides)

# Infer GCN
sft <- BioNERO::SFT_fit(pepper_se, net_type = "signed", cor_method = "pearson")
gcn <- BioNERO::exp2gcn(pepper_se, net_type = "signed", cor_method = "pearson",
                        module_merging_threshold = 0.8, SFTpower = sft$power)

# Apply step 2
candidates2 <- mine_step2(pepper_se, gcn = gcn, guides = guides$Gene,
                          candidates = candidates1$ID)
candidates2$candidates
candidates2$enrichment

## ----step3--------------------------------------------------------------------
# See the levels from the sample metadata
unique(pepper_se$Condition)

# Apply step 3 using "PRR_stress" as the condition of interest
candidates3 <- mine_step3(pepper_se, candidates = candidates2$candidates,
                          sample_group = "PRR_stress")
candidates3

## ----mine_candidates----------------------------------------------------------
candidates <- mine_candidates(gene_ranges = gene_ranges, 
                              marker_ranges = snp_pos, 
                              exp = pepper_se,
                              gcn = gcn, guides = guides$Gene,
                              sample_group = "PRR_stress")
candidates

## ----score_candidates---------------------------------------------------------
# Load TFs
data(tfs)
head(tfs)

# Get GCN hubs
hubs <- BioNERO::get_hubs_gcn(pepper_se, gcn)
head(hubs)

# Score candidates
scored <- score_genes(candidates, hubs$Gene, tfs$Gene_ID)
scored

## ----session_info-------------------------------------------------------------
sessioninfo::session_info()

