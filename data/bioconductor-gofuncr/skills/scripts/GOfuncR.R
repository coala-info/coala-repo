# Code example from 'GOfuncR' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----global_options, include=FALSE--------------------------------------------------------------------------
knitr::opts_chunk$set(fig.width=10, fig.height=7, warning=FALSE, message=FALSE)
options(width=110)
set.seed(123)

## ----eval=FALSE---------------------------------------------------------------------------------------------
# ## install annotation package 'Homo.sapiens' from bioconductor
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install('Homo.sapiens')

## -----------------------------------------------------------------------------------------------------------
## load GOfuncR package
library(GOfuncR)
## create input dataframe with candidate genes
gene_ids = c('NCAPG', 'APOL4', 'NGFR', 'NXPH4', 'C21orf59', 'CACNG2', 'AGTR1',
    'ANO1', 'BTBD3', 'MTUS1', 'CALB1', 'GYG1', 'PAX2')
input_hyper = data.frame(gene_ids, is_candidate=1)
input_hyper

## ----results='hide'-----------------------------------------------------------------------------------------
## run enrichment analysis (n_randets=100 lowers compuation time
## compared to default 1000)
res_hyper = go_enrich(input_hyper, n_randset=100)

## -----------------------------------------------------------------------------------------------------------
## first element of go_enrich result has the stats
stats = res_hyper[[1]]
## top-GO categories
head(stats)
## top GO-categories per domain
by(stats, stats$ontology, head, n=3)

## -----------------------------------------------------------------------------------------------------------
## all valid input genes
head(res_hyper[[2]])

## -----------------------------------------------------------------------------------------------------------
## annotation package used (default='Homo.sapiens') and GO-graph version
res_hyper[[3]]

## -----------------------------------------------------------------------------------------------------------
## minimum p-values from randomsets
head(res_hyper[[4]])

## -----------------------------------------------------------------------------------------------------------
## create input dataframe with candidate and background genes
candi_gene_ids = c('NCAPG', 'APOL4', 'NGFR', 'NXPH4', 'C21orf59', 'CACNG2', 
    'AGTR1', 'ANO1', 'BTBD3', 'MTUS1', 'CALB1', 'GYG1', 'PAX2')
bg_gene_ids = c('FGR', 'NPHP1', 'DRD2', 'ABCC10', 'PTBP2', 'JPH4', 'SMARCC2',
    'FN1', 'NODAL', 'CYP1A2', 'ACSS1', 'CDHR1', 'SLC25A36', 'LEPR', 'PRPS2',
    'TNFAIP3', 'NKX3-1', 'LPAR2', 'PGAM2')
is_candidate = c(rep(1,length(candi_gene_ids)), rep(0,length(bg_gene_ids)))
input_hyper_bg = data.frame(gene_ids = c(candi_gene_ids, bg_gene_ids),
    is_candidate)
head(input_hyper_bg)
tail(input_hyper_bg)

## ----results='hide'-----------------------------------------------------------------------------------------
res_hyper_bg = go_enrich(input_hyper_bg, n_randsets=100)


## -----------------------------------------------------------------------------------------------------------
head(res_hyper_bg[[1]])

## ----eval=FALSE---------------------------------------------------------------------------------------------
# ## test input genes again with correction for gene length
# res_hyper_len = go_enrich(input_hyper, gene_len=TRUE)

## -----------------------------------------------------------------------------------------------------------
## create input vector with a candidate region on chromosome 8
## and background regions on chromosome 7, 8 and 9
regions = c('8:81000000-83000000', '7:1300000-56800000', '7:74900000-148700000',
    '8:7400000-44300000', '8:47600000-146300000', '9:0-39200000',
    '9:69700000-140200000')
is_candidate = c(1, rep(0,6))
input_regions = data.frame(regions, is_candidate)
input_regions

## ----results='hide'-----------------------------------------------------------------------------------------
## run GO-enrichment analysis for genes in the candidate region
res_region = go_enrich(input_regions, n_randsets=100, regions=TRUE)

## -----------------------------------------------------------------------------------------------------------
stats_region = res_region[[1]]
head(stats_region)
## see which genes are located in the candidate region
input_genes = res_region[[2]]
candidate_genes = input_genes[input_genes[,2]==1, 1]
candidate_genes

## -----------------------------------------------------------------------------------------------------------
## create input dataframe with scores in second column
high_score_genes = c('GCK', 'CALB1', 'PAX2', 'GYS1','SLC2A8', 'UGP2', 'BTBD3',
    'MTUS1', 'SYP', 'PSEN1')
low_score_genes = c('CACNG2', 'ANO1', 'ZWINT', 'ENGASE', 'HK2', 'PYGL', 'GYG1')
gene_scores = c(runif(length(high_score_genes), 0.5, 1),
    runif(length(low_score_genes), 0, 0.5))
input_willi = data.frame(gene_ids = c(high_score_genes, low_score_genes),
    gene_scores)
head(input_willi)

## ----results='hide'-----------------------------------------------------------------------------------------
res_willi = go_enrich(input_willi, test='wilcoxon', n_randsets=100)

## -----------------------------------------------------------------------------------------------------------
head(res_willi[[1]])

## -----------------------------------------------------------------------------------------------------------
## create a toy example dataset with two counts per gene
high_A_genes = c('G6PD', 'GCK', 'GYS1', 'HK2', 'PYGL', 'SLC2A8', 'UGP2',
    'ZWINT', 'ENGASE')
low_A_genes = c('CACNG2', 'AGTR1', 'ANO1', 'BTBD3', 'MTUS1', 'CALB1', 'GYG1',
    'PAX2')
A_counts = c(sample(20:30, length(high_A_genes)),
    sample(5:15, length(low_A_genes)))
B_counts = c(sample(5:15, length(high_A_genes)),
    sample(20:30, length(low_A_genes)))
input_binom = data.frame(gene_ids=c(high_A_genes, low_A_genes), A_counts,
    B_counts)
head(input_binom)

## -----------------------------------------------------------------------------------------------------------
## run binomial test, excluding the 'biological_process' domain,
## suppress output to screen
res_binom = go_enrich(input_binom, test='binomial', n_randsets=100,
    silent=TRUE, domains=c('molecular_function', 'cellular_component'))
head(res_binom[[1]])

## -----------------------------------------------------------------------------------------------------------
## create a toy example with four counts per gene
high_substi_genes = c('G6PD', 'GCK', 'GYS1', 'HK2', 'PYGL', 'SLC2A8', 'UGP2',
    'ZWINT', 'ENGASE')
low_substi_genes = c('CACNG2', 'AGTR1', 'ANO1', 'BTBD3', 'MTUS1', 'CALB1',
    'GYG1', 'PAX2', 'C21orf59')
subs_non_syn = c(sample(5:15, length(high_substi_genes), replace=TRUE),
    sample(0:5, length(low_substi_genes), replace=TRUE))
subs_syn = sample(5:15, length(c(high_substi_genes, low_substi_genes)),
    replace=TRUE)
vari_non_syn = c(sample(0:5, length(high_substi_genes), replace=TRUE),
    sample(0:10, length(low_substi_genes), replace=TRUE))
vari_syn = sample(5:15, length(c(high_substi_genes, low_substi_genes)),
    replace=TRUE)
input_conti = data.frame(gene_ids=c(high_substi_genes, low_substi_genes),
    subs_non_syn, subs_syn, vari_non_syn, vari_syn)
head(input_conti)

## the corresponding contingency table for the first gene would be:
matrix(input_conti[1, 2:5], ncol=2,
    dimnames=list(c('non-synonymous', 'synonymous'),
    c('substitution','variable')))

## ----results='hide'-----------------------------------------------------------------------------------------
res_conti = go_enrich(input_conti, test='contingency', n_randset=100)

## -----------------------------------------------------------------------------------------------------------
head(res_conti[[1]])

## ----eval=FALSE---------------------------------------------------------------------------------------------
# ## perform enrichment analysis for mouse genes
# ## ('Mus.musculus' has to be installed)
# mouse_gene_ids = c('Gck', 'Gys1', 'Hk2', 'Pygl', 'Slc2a8', 'Ugp2', 'Zwint',
#     'Engase')
# input_hyper_mouse = data.frame(mouse_gene_ids, is_candidate=1)
# res_hyper_mouse = go_enrich(input_hyper_mouse, organismDb='Mus.musculus')
# 

## ----eval=FALSE---------------------------------------------------------------------------------------------
# ## perform enrichment analysis for chimp genes
# ## ('org.Pt.eg.db' has to be installed)
# chimp_gene_ids = c('SIAH1', 'MIIP', 'ELP3', 'CFB', 'ADARB1', 'TRNT1',
#     'DEFB124', 'OR1A1', 'TYR', 'HOXA7')
# input_hyper_chimp = data.frame(chimp_gene_ids, is_candidate=1)
# res_hyper_chimp = go_enrich(input_hyper_chimp, orgDb='org.Pt.eg.db')
# 

## ----eval=FALSE---------------------------------------------------------------------------------------------
# ## perform enrichment analysis for chimp genes
# ## and account for gene-length in FWER
# ## (needs 'org.Pt.eg.db' and 'TxDb.Ptroglodytes.UCSC.panTro4.refGene' installed)
# res_hyper_chimp_genelen = go_enrich(input_hyper_chimp, gene_len=TRUE,
#     orgDb='org.Pt.eg.db', txDb='TxDb.Ptroglodytes.UCSC.panTro4.refGene')
# 

## ----eval=FALSE---------------------------------------------------------------------------------------------
# ## run GO-enrichment analysis for genes in the candidate region
# ## using hg38 gene-coordinates
# ## (needs 'org.Hs.eg.db' and 'TxDb.Hsapiens.UCSC.hg38.knownGene' installed)
# res_region_hg38 = go_enrich(input_regions, regions=TRUE,
#     orgDb='org.Hs.eg.db', txDb='TxDb.Hsapiens.UCSC.hg38.knownGene')

## ----echo=FALSE---------------------------------------------------------------------------------------------
custom_anno = get_anno_categories(input_hyper_bg[,1])
# to have several genes in head
custom_anno = custom_anno[6:nrow(custom_anno),1:2]
rownames(custom_anno) = 1:nrow(custom_anno)

## -----------------------------------------------------------------------------------------------------------
## example for a dataframe with custom annotations
head(custom_anno)

## ----eval=FALSE---------------------------------------------------------------------------------------------
# ## run enrichment analysis with custom annotations
# res_hyper_anno = go_enrich(input_hyper, annotations=custom_anno)
# 

## ----echo=FALSE---------------------------------------------------------------------------------------------
gene = c('NCAPG','APOL4','NGFR','NXPH4','C21orf59','CACNG2')
chr = c('chr4', 'chr22', 'chr17', 'chr12', 'chr21', 'chr22')
start = c(17812436, 36585176, 47572655, 57610578, 33954510, 36956916)
end = c(17846487, 36600879, 47592382, 57620232, 33984918, 37098690)
custom_coords = data.frame(gene, chr, start, end, stringsAsFactors=FALSE)

## -----------------------------------------------------------------------------------------------------------
## example for a dataframe with custom gene-coordinates
head(custom_coords)

## ----eval=FALSE---------------------------------------------------------------------------------------------
# ## use correction for gene-length based on custom gene-coordinates
# res_hyper_cc = go_enrich(input_hyper, gene_len=TRUE, gene_coords=custom_coords)

## ----eval=FALSE---------------------------------------------------------------------------------------------
# ## run enrichment with custom GO-graph
# go_path = '/home/user/go_graphs/2018-11-24/'
# res_hyper = go_enrich(input_hyper, godir=go_path)
# 

## -----------------------------------------------------------------------------------------------------------
## hypergeometric test
top_gos_hyper = res_hyper[[1]][1:5, 'node_id']
# GO-categories with a high proportion of candidate genes
top_gos_hyper
plot_anno_scores(res_hyper, top_gos_hyper)

## -----------------------------------------------------------------------------------------------------------
## hypergeometric test with defined background
top_gos_hyper_bg = res_hyper_bg[[1]][1:5, 'node_id']
top_gos_hyper_bg
plot_stats = plot_anno_scores(res_hyper_bg, top_gos_hyper_bg)
plot_stats

## -----------------------------------------------------------------------------------------------------------
## scores used for wilcoxon rank-sum test
top_gos_willi = res_willi[[1]][1:5, 'node_id']
# GO-categories with high scores
top_gos_willi
plot_anno_scores(res_willi, top_gos_willi)

## -----------------------------------------------------------------------------------------------------------
## counts used for the binomial test
top_gos_binom = res_binom[[1]][1:5, 'node_id']
# GO-categories with high proportion of A
top_gos_binom
plot_anno_scores(res_binom, top_gos_binom)

## -----------------------------------------------------------------------------------------------------------
## counts used for the 2x2 contingency table test
top_gos_conti = res_conti[[1]][1:5, 'node_id']
# GO-categories with high A/B compared to C/D
top_gos_conti
plot_anno_scores(res_conti, top_gos_conti)

## -----------------------------------------------------------------------------------------------------------
## get the parent nodes (higher level GO-categories) of two GO-IDs
get_parent_nodes(c('GO:0051082', 'GO:0042254'))

## get the child nodes (sub-categories) of two GO-IDs
get_child_nodes(c('GO:0090070', 'GO:0000112'))

## -----------------------------------------------------------------------------------------------------------
## get the full names and domains of two GO-IDs
get_names(c('GO:0090070', 'GO:0000112'))

## -----------------------------------------------------------------------------------------------------------
## get GO-IDs of categories that contain 'blood-brain barrier' in their names
bbb = get_ids('blood-brain barrier')
head(bbb)

## -----------------------------------------------------------------------------------------------------------
## find all genes that are annotated to GO:0000109 
## using default database 'Homo.sapiens'
head(get_anno_genes(go_ids='GO:0000109'))

## find out wich genes from a set of genes
## are annotated to some GO-categories
genes = c('AGTR1', 'ANO1', 'CALB1', 'GYG1', 'PAX2')
gos = c('GO:0001558', 'GO:0005536', 'GO:0072205', 'GO:0006821')
anno_genes = get_anno_genes(go_ids=gos, genes=genes)
# add the names and domains of the GO-categories
cbind(anno_genes, get_names(anno_genes$go_id)[,2:3])

## ----eval=FALSE---------------------------------------------------------------------------------------------
# ## find all mouse-gene annotations to two GO-categories
# ## ('Mus.musculus' has to be installed)
# gos = c('GO:0072205', 'GO:0000109')
# get_anno_genes(go_ids=gos, database='Mus.musculus')

## -----------------------------------------------------------------------------------------------------------
## get the GO-annotations for two random genes
anno = get_anno_categories(c('BTC', 'SPAG5'))
head(anno)

## ----eval=FALSE---------------------------------------------------------------------------------------------
# ## get the GO-annotations for two mouse genes
# ## ('Mus.musculus' has to be installed)
# anno_mus = get_anno_categories(c('Mus81', 'Papola'), database='Mus.musculus')

## -----------------------------------------------------------------------------------------------------------
# get all direct annotations of NXPH4
direct_anno = get_anno_categories('NXPH4')
direct_anno
# get parent nodes of directly annotated GO-categories
parent_ids = unique(get_parent_nodes(direct_anno$go_id)[,2])
# add GO-domain
full_anno = get_names(parent_ids)
head(full_anno)

## ----results='hide'-----------------------------------------------------------------------------------------
## perform enrichment analysis for some genes
gene_ids = c('NCAPG', 'APOL4', 'NGFR', 'NXPH4', 'C21orf59', 'CACNG2', 'AGTR1',
    'ANO1', 'BTBD3', 'MTUS1', 'CALB1', 'GYG1', 'PAX2')
input_hyper = data.frame(gene_ids, is_candidate=1)
res_hyper = go_enrich(input_hyper, n_randset=100)

## perform refinement for categories with FWER < 0.1
refined = refine(res_hyper, fwer=0.1)

## -----------------------------------------------------------------------------------------------------------
## the result shows p-values and significance before and after refinement
refined

## -----------------------------------------------------------------------------------------------------------
sessionInfo()

