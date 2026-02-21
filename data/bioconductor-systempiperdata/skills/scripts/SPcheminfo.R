# Code example from 'SPcheminfo' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'----------------
BiocStyle::markdown()
options(width=60, max.print=1000)
knitr::opts_chunk$set(
    eval=as.logical(Sys.getenv("KNITR_EVAL", "TRUE")),
    cache=as.logical(Sys.getenv("KNITR_CACHE", "TRUE")), 
    tidy.opts=list(width.cutoff=60), tidy=TRUE)

## ----setup, echo=FALSE, message=FALSE, warning=FALSE, eval=FALSE----
# suppressPackageStartupMessages({
#     library(systemPipeR)
# })

## ----gen_spblast_wf, eval=FALSE---------------------------
# systemPipeRdata::genWorkenvir(workflow = "SPcheminfo", mydirname = "SPcheminfo")
# setwd("SPcheminfo")

## ----create_workflow, message=FALSE, eval=FALSE-----------
# library(systemPipeR)
# sal <- SPRproject()
# sal

## ----load_workflow_default, eval=FALSE--------------------
# sal <- importWF(sal, "SPcheminfo.Rmd")
# sal <- runWF(sal)

## ----load_packages, eval=FALSE, spr=TRUE------------------
# appendStep(sal) <- LineWise(
#     code = {
#         library(systemPipeR)
#         library(ChemmineR)
#     },
#     step_name = "load_packages"
# )

## ----load_data, eval=FALSE, spr=TRUE----------------------
# appendStep(sal) <- LineWise(
#     code = {
#         sdfset <- read.SDFset("https://cluster.hpcc.ucr.edu/~tgirke/Documents/R_BioCond/Samples/sdfsample.sdf")
#     },
#     step_name = "load_data",
#     dependency = "load_packages"
# )

## ----vis_mol, eval=FALSE, spr=TRUE------------------------
# appendStep(sal) <- LineWise(
#     code = {
#         png("results/mols_plot.png", 700, 600)
#         # Here only first 4 are plotted. Please choose the ones you want to plot.
#         ChemmineR::plot(sdfset[1:4])
#         dev.off()
#     },
#     step_name = "vis_mol",
#     dependency = "load_data",
#     run_step = "optional"
# )

## ----basic_mol_info, eval=FALSE, spr=TRUE-----------------
# appendStep(sal) <- LineWise(
#     code = {
#         propma <- data.frame(MF=MF(sdfset), MW=MW(sdfset), atomcountMA(sdfset))
#         readr::write_csv(propma, "results/basic_mol_info.csv")
#     },
#     step_name = "basic_mol_info",
#     dependency = "load_data",
#     run_step = "optional"
# )

## ----mol_info_plot, eval=FALSE, spr=TRUE------------------
# appendStep(sal) <- LineWise(
#     code = {
#         png("results/atom_req.png", 700, 700)
#         boxplot(propma[, 3:ncol(propma)], col="#6cabfa", main="Atom Frequency")
#         dev.off()
#     },
#     step_name = "mol_info_plot",
#     dependency = "basic_mol_info",
#     run_step = "optional"
# )

## ----apfp_convert, eval=FALSE, spr=TRUE-------------------
# appendStep(sal) <- LineWise(
#     code = {
#          apset <- sdf2ap(sdfset)
#          fpset <- desc2fp(apset, descnames=1024, type="FPset")
#          # The atom pairs and fingerprints can be saved to files.
#          readr::write_rds(apset, "results/apset.rds")
#          readr::write_rds(fpset, "results/fpset.rds")
#     },
#     step_name = "apfp_convert",
#     dependency = "load_data"
# )

## ----fp_dedup, eval=FALSE, spr=TRUE-----------------------
# appendStep(sal) <- LineWise(
#     code = {
#          fpset <- fpset[which(!cmp.duplicated(apset))]
#     },
#     step_name = "fp_dedup",
#     dependency = "apfp_convert"
# )

## ----fp_similarity, eval=FALSE, spr=TRUE------------------
# appendStep(sal) <- LineWise(
#     code = {
#           simMAfp <- sapply(cid(fpset), function(x) fpSim(x=fpset[x], fpset, sorted=FALSE))
#     },
#     step_name = "fp_similarity",
#     dependency = "fp_dedup"
# )

## ----hclust, eval=FALSE, spr=TRUE-------------------------
# appendStep(sal) <- LineWise(
#     code = {
#           hc <- hclust(as.dist(1-simMAfp))
#           png("results/hclust.png", 1000, 700)
#           plot(as.dendrogram(hc), edgePar=list(col=4, lwd=2), horiz=TRUE)
#           dev.off()
#           # to see the tree groupings, one need to cut the tree, for example, by height of 0.9
#           tree_cut <- cutree(hc, h = 0.9)
#           grouping <- tibble::tibble(
#               cid = names(tree_cut),
#               group_id = tree_cut
#           )
#           readr::write_csv(grouping, "results/hclust_grouping.csv")
#     },
#     step_name = "hclust",
#     dependency = "fp_similarity",
#     run_step = "optional"
# )

## ----PCA, eval=FALSE, spr=TRUE----------------------------
# appendStep(sal) <- LineWise(
#     code = {
#         library(magrittr)
#         library(ggplot2)
#         mol_pca <- princomp(simMAfp)
#         # find the variance
#         mol_pca_var <- mol_pca$sdev[1:2]^2 / sum(mol_pca$sdev^2)
#         # plot
#         png("results/mol_pca.png", 650, 700)
#         tibble::tibble(
#               PC1 = mol_pca$loadings[, 1],
#               PC2 = mol_pca$loadings[, 2],
#               group_id = as.factor(grouping$group_id)
#           ) %>%
#             # The following colors the by group labels.
#             ggplot(aes(x = PC1, y = PC2, color = group_id)) +
#             geom_point(size = 2) +
#             stat_ellipse() +
#             labs(
#                 x = paste0("PC1 ", round(mol_pca_var[1], 3)*100, "%"),
#                 y = paste0("PC1 ", round(mol_pca_var[2], 3)*100, "%")
#             ) +
#             ggpubr::theme_pubr(base_size = 16) +
#             scale_color_brewer(palette = "Set2")
#         dev.off()
#     },
#     step_name = "PCA",
#     dependency = "hclust",
#     run_step = "optional"
# )

## ----heatmap, eval=FALSE, spr=TRUE------------------------
# appendStep(sal) <- LineWise(
#     code = {
#         library(gplots)
#         png("results/mol_heatmap.png", 700, 700)
#         heatmap.2(simMAfp, Rowv=as.dendrogram(hc), Colv=as.dendrogram(hc),
#              col=colorpanel(40, "darkblue", "yellow", "white"),
#              density.info="none", trace="none")
#         dev.off()
#     },
#     step_name = "heatmap",
#     dependency = "fp_similarity",
#     run_step = "optional"
# )

## ----wf_session, eval=FALSE, spr=TRUE---------------------
# appendStep(sal) <- LineWise(
#     code = {
#         sessionInfo()
#     },
#     step_name = "wf_session",
#     dependency = "heatmap")

## ----import_run_routine, eval=FALSE-----------------------
# sal <- SPRproject(overwrite = TRUE) # Avoid 'overwrite=TRUE' in real runs.
# sal <- importWF(sal, file_path = "SPcheminfo.Rmd") # Imports above steps from new.Rmd.
# sal <- runWF(sal) # Runs ggworkflow.
# plotWF(sal) # Plot toplogy graph of workflow
# sal <- renderReport(sal) # Renders scientific report.
# sal <- renderLogs(sal) # Renders technical report from log files.

## ----list_tools-------------------------------------------
if(file.exists(file.path(".SPRproject", "SYSargsList.yml"))) {
    local({
        sal <- systemPipeR::SPRproject(resume = TRUE)
        systemPipeR::listCmdTools(sal)
        systemPipeR::listCmdModules(sal)
    })
} else {
    cat(crayon::blue$bold("Tools and modules required by this workflow are:\n"))
    cat(c("There are no CL steps in this workflow."), sep = "\n")
}

## ----report_session_info, eval=TRUE-----------------------
sessionInfo()

