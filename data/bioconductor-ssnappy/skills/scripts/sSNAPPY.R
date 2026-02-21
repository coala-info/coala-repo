# Code example from 'sSNAPPY' vignette. See references/ for full tutorial.

## ----echo=FALSE---------------------------------------------------------------
knitr::opts_chunk$set(message = FALSE, warning = FALSE, crop = NULL)

## ----install, eval = FALSE----------------------------------------------------
# if (!"BiocManager" %in% rownames(installed.packages()))
#   install.packages("BiocManager")
# # Other packages required in this vignette
# pkg <- c("tidyverse", "magrittr", "ggplot2", "cowplot", "DT")
# BiocManager::install(pkg)
# BiocManager::install("sSNAPPY")
# install.packages("htmltools")

## ----setup,  results="hide", warning=FALSE------------------------------------
library(sSNAPPY)
library(tidyverse)
library(magrittr)
library(ggplot2)
library(cowplot)
library(DT)
library(htmltools)
library(patchwork)

## ----data---------------------------------------------------------------------
data(logCPM_example)
data(metadata_example)
# check if samples included in the logCPM matrix and metadata dataframe are identical
setequal(colnames(logCPM_example), metadata_example$sample)
# View sample metadata
datatable(metadata_example,  filter = "top")

## ----logCPM_example, eval=FALSE-----------------------------------------------
# head(logCPM_example)

## ----ssFC---------------------------------------------------------------------
# Check that the baseline level of the treatment column is the control
levels(metadata_example$treatment)[1]
#compute weighted single sample logFCs
weightedFC <- weight_ss_fc(logCPM_example, metadata = metadata_example,
                           groupBy  = "patient", sampleColumn = "sample", 
                           treatColumn = "treatment")

## ----lowess, fig.width=6,fig.height=5, fig.cap="*Gene-wise standard deviations are plotted against the mean logCPM values with mean-variance trend modelled by a loess fit. Genes with low expression values tend to have a larger variance.*"----
logCPM_example %>%
    as.data.frame() %>%
    mutate(
        sd = apply(., 1, sd),
        mean = apply(., 1, mean)
        ) %>%
    ggplot(
        aes(mean, sd)
    ) +
    geom_point() +
    geom_smooth(
        method = "loess") +
    labs(
        x = expression(Gene-wise~average~expression~(bar(mu[g]))),
        y = expression(Gene-wise~standard~deviation~(sigma[g]))
    ) +
    theme_bw() +
    theme(
        panel.grid = element_blank(),
        axis.title = element_text(size = 14)
    )

## ----retrieve_topology--------------------------------------------------------
gsTopology <- retrieve_topology(database = "kegg", species = "hsapiens")
head(names(gsTopology))

## ----gsTopology_sub-----------------------------------------------------------
gsTopology_sub <- retrieve_topology(
  database = "kegg",
  species = "hsapiens", 
  keyword = "metabolism")
head(names(gsTopology_sub))

## ----gsTopology_mult, echo=FALSE----------------------------------------------
gsTopology_mult <- retrieve_topology(
  database = c("kegg", "reactome"),
  species = "hsapiens", 
  keyword = c("metabolism", "estrogen"))
names(gsTopology_mult) 

## -----------------------------------------------------------------------------
genePertScore <- raw_gene_pert(weightedFC$weighted_logFC, gsTopology)

## -----------------------------------------------------------------------------
pathwayPertScore <- pathway_pert(genePertScore, weightedFC$weighted_logFC)
head(pathwayPertScore)

## ----permutedScore------------------------------------------------------------
set.seed(123)
permutedScore <- generate_permuted_scores(
  expreMatrix  = logCPM_example, 
  gsTopology = gsTopology, 
  weight = weightedFC$weight
)

## ----normalisedScores---------------------------------------------------------
normalisedScores <- normalise_by_permu(permutedScore, pathwayPertScore, sortBy = "pvalue")


## ----DT_indi------------------------------------------------------------------
normalisedScores %>%
    dplyr::filter(adjPvalue < 0.05) 

## ----fit----------------------------------------------------------------------
fit <- normalisedScores %>%
    left_join(metadata_example) %>%
    split(f = .$gs_name) %>%
    lapply(function(x)lm(robustZ ~ 0 + treatment, data = x)) %>%
    lapply(summary)
treat_sig <- lapply(
  names(fit), 
  function(x){
    fit[[x]]$coefficients %>%
      as.data.frame() %>%
      .[seq_len(2),] %>%
      dplyr::select(Estimate, pvalue = `Pr(>|t|)` ) %>%
      rownames_to_column("Treatment") %>%
      mutate(
        gs_name = x, 
        FDR = p.adjust(pvalue, "fdr"), 
        Treatment = str_remove_all(Treatment, "treatment")
      ) 
  }) %>%
  bind_rows() 

## ----treat_sig_DT-------------------------------------------------------------
treat_sig %>% 
    dplyr::filter(FDR < 0.05) %>%
    mutate_at(vars(c("Treatment", "gs_name")), as.factor) %>%
    mutate_if(is.numeric, sprintf, fmt = '%#.4f') %>%
    mutate(Direction = ifelse(Estimate < 0, "Inhibited", "Activation")) %>%
    dplyr::select(
        Treatment, `Perturbation Score` = Estimate, Direction,
        `Gene-set name` = gs_name, 
        `P-value` = pvalue, 
        FDR
    ) %>%
    datatable(
        filter = "top", 
        options = list(
            columnDefs = list(list(targets = "Direction", visible = FALSE))
        ), 
        caption = htmltools::tags$caption(
                  htmltools::em(
                      "Pathways that were significant perturbed within each treatment group.")
              )
    ) %>% 
    formatStyle(
        'Perturbation Score', 'Direction',
        color = styleEqual(c("Inhibited", "Activation"), c("blue", "red"))
    )

## ----fig.height= 7, fig.width=8, fig.cap="*Gene-level perturbation scores of genes with top 10 highest absolute mean gene-wise perturbation scores in the kegg.Proteoglycans in cancer gene-set. Only samples treated with R52020 are included.*"----
plot_gene_contribution(
    genePertMatr  = genePertScore$`kegg.Proteoglycans in cancer` %>%
        .[, str_detect(colnames(.), "E2", negate = TRUE)],
    filterBy = "mean",
    topGene = 10,
    color = rev(colorspace::divergex_hcl(100, palette = "RdBu")),
    breaks = seq(-0.001, 0.001, length.out = 100)
)

## ----annotation_df------------------------------------------------------------
annotation_df <- normalisedScores %>%
    dplyr::filter(gs_name == "kegg.Proteoglycans in cancer") %>%
    mutate(
        `Z Range` = cut(
            robustZ, breaks = seq(-2, 2, length.out = 6), include.lowest = TRUE
        )
    ) %>%
    dplyr::select(sample, `Z Range`) %>%
    left_join(
        .,  metadata_example %>%
            dplyr::select(sample, `PR Status` = PR), 
        unmatched = "drop"
    )

## ----fig.height= 7, fig.width=10, fig.cap="*Gene-level perturbation scores of genes with top 10 absolute mean gene-wise perturbation scores in the Proteoglycans in cancer gene-set among R502-treated samples.*"----
load(system.file("extdata", "entrez2name.rda", package = "sSNAPPY"))
z_levels <- levels(annotation_df$`Z Range`)
sample_order <- metadata_example %>%
    dplyr::filter(treatment == "R5020") %>%
    .[order(.$treatment),] %>%
    pull(sample)
plot_gene_contribution(
    genePertMatr  = genePertScore$`kegg.Proteoglycans in cancer` %>%
        .[, match(sample_order, colnames(.))],
    annotation_df = annotation_df,
    filterBy = "mean", 
    topGene = 10,
    mapEntrezID = entrez2name,
    cluster_cols = FALSE,
    color = rev(colorspace::divergex_hcl(100, palette = "RdBu")),
    breaks = seq(-0.001, 0.001, length.out = 100),
    annotation_colors = list(
        `PR Status` = c(Positive = "darkgreen", Negative = "orange"),
        `Z Range` = setNames(
            colorRampPalette(c("navyblue", "white", "darkred"))(length(z_levels)),
            z_levels
        ))
    )

## -----------------------------------------------------------------------------
pathway2plot <- treat_sig %>% 
    dplyr::filter(Treatment == "R5020") %>%
    arrange(FDR) %>%
    .[1:20,] %>%
    mutate(
        status = ifelse(Estimate > 0, "Activated", "Inhibited"), 
        status = ifelse(FDR < 0.05, status, "Unchanged"))

## ----fig.width=12, fig.height=5, fig.cap="*Networks of pathways that were perturbed by the R5020 treatment, where colors of nodes reflect (A) pathways' predicted directions of changes. and (B) -log10(p-values). In panel A, pathways that were significantly perturbed were predicted to be either inhibited or activated while pathways that did not pass the significance threshold were deemed unchanged.*"----
set.seed(123)
p1 <- pathway2plot %>%
    plot_gs_network(
        gsTopology = gsTopology, 
        colorBy = "status"
    ) +
    scale_color_manual(
        values = c(
            "Activated" = "red", 
            "Unchanged" = "gray"
        )
    ) +
    theme(
        panel.grid = element_blank(), 
        panel.background = element_blank()
    ) 
set.seed(123)
p2 <- pathway2plot %>%
    mutate(`-log10(p)` = -log10(pvalue)) %>%
    plot_gs_network(
        gsTopology = gsTopology, 
        colorBy = "-log10(p)"
    ) +
    theme(
        panel.grid = element_blank(), 
        panel.background = element_blank()
    )
(p1 | p2) +
    plot_annotation(tag_levels = "A")

## ----fig.height=9, fig.width=12, fig.cap="*The top 20 ranked pathways in the R5020 treatment group, annotated by the main biological processes each pathways belong to and coloured by pathways' predicted change in direction. The status of pathways that did not pass the significance threshold to be considered as significantly perturbed were deemed as unchanged.*"----
set.seed(123)
pathway2plot %>%
    plot_community(
        gsTopology = gsTopology, 
        colorBy = "status", 
        color_lg_title = "Community"
    ) +
    scale_color_manual(
        values = c(
            "Activated" = "red", 
            "Unchanged" = "gray"
        )
    ) +
    theme(panel.background = element_blank())

## ----eval=TRUE----------------------------------------------------------------
load(system.file("extdata", "gsAnnotation_df_reactome.rda", package = "sSNAPPY"))

## ----fig.height=7, fig.width=12, fig.cap="*Pathways significantly perturbed by the R5020 treatment and genes implicated in at least 3 of those pathways.*"----
treat_sig %>% 
    dplyr::filter(FDR < 0.05,) %>%
    plot_gs2gene(
        gsTopology = gsTopology, 
        colorGsBy = "Estimate", 
        labelGene = FALSE,
        geneNodeSize  = 1, 
        edgeAlpha = 0.1, 
        gsNameSize = 2,
        filterGeneBy = 3
    ) + 
    scale_fill_gradient2() +
    theme(panel.background = element_blank()) 

## ----top500_FC----------------------------------------------------------------
meanFC <- weightedFC$weighted_logFC %>%
    .[, str_detect(colnames(.), "E2", negate = TRUE)] %>%
    apply(1, mean )
top500_gene <- meanFC %>%
    abs() %>%
    sort(decreasing = TRUE, ) %>%
    .[1:500] %>%
    names()
top500_FC <- meanFC %>%
    .[names(.) %in% top500_gene]
top500_FC  <- ifelse(top500_FC > 0, "Up-Regulated", "Down-Regulated")

## ----fig.height=8, fig.width=10, fig.cap="*Pathways significantly perturbed by the R5020 treatment, and pathway genes with top 500 magnitudes of changes among all R5020-treated samples. Both pathways and genes were colored by their predicted directions of changes.*"----
treat_sig %>% 
    dplyr::filter(FDR < 0.05, Treatment == "R5020") %>%
    mutate(status = ifelse(Estimate > 0, "Activated", "Inhibited")) %>%
    plot_gs2gene(
        gsTopology = gsTopology, 
        colorGsBy = "status", 
        geneFC = top500_FC, 
        mapEntrezID = entrez2name, 
        gsNameSize = 3, 
        filterGeneBy = 0
    ) +
    scale_fill_manual(values = c("darkred", "lightskyblue")) +
    scale_colour_manual(values = c("red", "blue")) +
    theme(panel.background = element_blank())

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

