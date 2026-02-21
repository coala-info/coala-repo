# Code example from 'mina' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----importData, eval = TRUE--------------------------------------------------
    library(mina)
    # maize_asv2 and maize_des2 are subset of maize_asv and maize_des
    maize <- new("mina", tab = maize_asv2, des = maize_des2)

## ----showData, eval = TRUE----------------------------------------------------
    head(maize_des)

## ----showData_2, eval = TRUE--------------------------------------------------
    maize_asv[1:6, 1:6]

## ----fitTabs, eval = TRUE-----------------------------------------------------
    maize <- fit_tabs(maize)

## ----rarefData, eval = TRUE---------------------------------------------------
    # check available normalization methods
    ? norm_tab_method_list
    # normalized by total sum
    maize <- norm_tab(maize, method = "total")
    # normalized by rarefaction
    maize <- norm_tab(maize, method = "raref", depth = 5000)
    # normalized by rarefaction and bootstrap 9 times
    maize <- norm_tab(maize, method = "raref", depth = 5000, multi = 9)

## ----rarefData_2, eval = TRUE-------------------------------------------------
    # normalized by total sum
    maize_asv_norm <- norm_tab(maize_asv2, method = "total")
    # normalized by rarefaction
    maize_asv_norm <- norm_tab(maize_asv2, method = "raref", depth = 5000)
    # normalized by rarefaction and bootstrap 99 times
    maize_asv_norm <- norm_tab(maize_asv2, method = "raref", depth = 5000,
                               multi = 9)

## ----comDis, eval = TRUE------------------------------------------------------
    # check available dissimilarity parameters
    ? com_dis_list
    # tidy the norm tab, intial tab and des tab
    maize <- fit_tabs(maize)
    # community dissimilarity calculation, Bray-Curtis used in example
    maize <- com_dis(maize, method = "bray")
    # TINA dissimilarity in Schmidt_et_al_2016
    # maize <- com_dis(maize, method = "tina")

## ----tina, eval = FALSE-------------------------------------------------------
#     # get the TINA dissimilarity of normalized quantitative table
#     maize_tina <- tina(maize_asv_norm, cor_method = "spearman", sim_method =
#                        "w_ja", threads = 80, nblocks = 400)

## ----getR2, eval = TRUE-------------------------------------------------------
    # get the unexplained variance ratio of quantitative table according to the
    # group information indicated in descriptive table.
    com_r2(maize, group = c("Compartment", "Soil", "Host_genotype"))
    # use tables as input
    maize_dis <- dis(maize)
    get_r2(maize_dis, maize_des, group = c("Compartment", "Soil", "Host_genotype"))

## ----pcoa, eval = TRUE--------------------------------------------------------
    # dimensionality reduction
    maize <- dmr(maize)
    # plot the community beta-diversity
    # separate samples from different conditions by color, plot PCo1 and PCo2
    p1 <- com_plot(maize, match = "Sample_ID", color = "Compartment")
    # plot PCo3 and PCo4
    p2 <- com_plot(maize, match = "Sample_ID", d1 = 3, d2 = 4, color =
                    "Compartment")
    # in addition, separate samples from different soil type by shape
    p3 <- com_plot(maize, match = "Sample_ID", color = "Compartment", shape =
                    "Soil")
    # plot PCo1 and PCo4
    p4 <- com_plot(maize, match = "Sample_ID", d1 = 1, d2 = 4, color =
                    "Compartment", shape = "Soil")

## ----pcoa_2, eval = TRUE------------------------------------------------------
    maize_dmr <- dmr(maize_dis, k = 4)
    maize_des <- maize_des[maize_des$Sample_ID %in% rownames(maize_dis), ]
    p <- pcoa_plot(maize_dmr, maize_des, match = "Sample_ID", d1 = 3, d2 = 4,
                   color = "Host_genotype")

## ----adj, eval = TRUE---------------------------------------------------------
    # check available adjacency matrix
    ? adj_method_list
    # Pearson and Spearman correlation
    maize <- adj(maize, method = "pearson")
    # Pearson and Spearman correlation with significance test
    maize <- adj(maize, method = "spearman", sig = TRUE)

## ----adj_2, eval = TRUE-------------------------------------------------------
    # Pearson and Spearman correlation
    asv_adj <- adj(maize_asv_norm, method = "pearson")

## ----cls, eval = TRUE---------------------------------------------------------
    # check available network clustering methods
    ? net_cls_list
    # network clustering by MCL
    maize <- net_cls(maize, method = "mcl", cutoff = 0.6)
    # network clustering by AP
    maize <- net_cls(maize, method = "ap", cutoff = 0.6, neg = FALSE)

## ----cls_2, eval = TRUE-------------------------------------------------------
    # filter the weak correlation by cutoff and cluster by MCL
    asv_cls <- net_cls(asv_adj, method = "mcl", cutoff = 0.6)

## ----cls_tab, eval = TRUE-----------------------------------------------------
    # get the cluster table by summing up compositions of the same cluster
    maize <- net_cls_tab(maize)

## ----cls_diversity, eval = TRUE-----------------------------------------------
    # dissimilarity between samples based on cluster table
    maize_cls_tab <- cls_tab(maize)
    maize_cls_dis <- com_dis(maize_cls_tab, method = "bray")
    get_r2(maize_cls_dis, maize_des, group = c("Compartment", "Soil",
                                               "Host_genotype"))

## ----bs_pm, eval = FALSE------------------------------------------------------
#     # compare the networks from different compartments
#     maize <- fit_tabs(maize)
#     maize <- bs_pm(maize, group = "Compartment")
#     # only get the distance, no significance test
#     maize <- bs_pm(maize, group = "Compartment", sig = FALSE)

## ----bs_pm2, eval = FALSE-----------------------------------------------------
#     # set the size of group to remove consitions with less sample
#     # also larger s_size will lead to more stable results but will consume more
#     # computation and time resource
#     maize <- bs_pm(maize, group = "Compartment", g_size = 200, s_size = 80)
#     # remove the compositions appear in less than 20% of samples
#     maize <- bs_pm(maize, group = "Compartment", per = 0.2)
# 
#     # set the bootstrap and permutation times. Again the more times bootstrap
#     # and permutation, the more reliable the significance, with increased
#     # computation and time resource.
#     maize <- bs_pm(maize, group = "Compartment", bs = 11, pm = 11)
# 
#     # output the comparison separately to the defined directory
#     bs_pm(maize, group = "Compartment", bs = 6, pm = 6,
#     individual = TRUE, out_dir = out_dir)

## ----sig, eval = FALSE--------------------------------------------------------
#     # check the available methods
#     ? net_dis_method_list
#     # calculate the distances between matrices
#     maize <- net_dis(maize, method = "spectra")
#     maize <- net_dis(maize, method = "Jaccard")
#     # check the ditance results and significance (if applicable)
#     dis_stat(maize)
#     # the comparison stored separately in previous step
#     ja <- net_dis_indi(out_dir, method = "Jaccard")
#     dis_stat(ja)
#     spectra <- net_dis_indi(out_dir, method = "spectra")
#     dis_stat(spectra)

