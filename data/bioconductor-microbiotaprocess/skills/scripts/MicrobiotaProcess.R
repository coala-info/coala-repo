# Code example from 'MicrobiotaProcess' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="asis", message=FALSE, KnitrSetUp--------------------
library(knitr)
knit_hooks$set(crop = hook_pdfcrop)
knitr::opts_chunk$set(crop = TRUE, tidy=FALSE, warning=FALSE,message=FALSE, fig.align="center")
Biocpkg <- function (pkg){
    sprintf("[%s](http://bioconductor.org/packages/%s)", pkg, pkg)
}

CRANpkg <- function(pkg){
    cran <- "https://CRAN.R-project.org/package" 
    fmt <- "[%s](%s=%s)"
    sprintf(fmt, pkg, cran, pkg) 
}

## ----echo=FALSE, results="hide", message=FALSE, Loadpackages------------------
library(ggplot2)
library(phyloseq)
library(shadowtext)
library(ggtree)
library(ggtreeExtra)
library(treeio)
library(tidytree)
library(MicrobiotaProcess)

## ----echo=FALSE, fig.width = 12, dpi=400, fig.align="center", fig.cap= "The structure of the MPSE class."----
knitr::include_graphics("./mpse.png")

## ----echo=FALSE, fig.width = 12, dpi=400, fig.align="center", fig.cap="The Overview of the design of MicrobiotaProcess package"----
knitr::include_graphics("./mp-design.png")

## ----warning=FALSE, message=FALSE---------------------------------------------
library(MicrobiotaProcess)
#parsing the output of dada2
seqtabfile <- system.file("extdata", "seqtab.nochim.rds", package="MicrobiotaProcess")
seqtab <- readRDS(seqtabfile)
taxafile <- system.file("extdata", "taxa_tab.rds", package="MicrobiotaProcess")
taxa <- readRDS(taxafile)
# the seqtab and taxa are output of dada2
sampleda <- system.file("extdata", "mouse.time.dada2.txt", package="MicrobiotaProcess")
mpse1 <- mp_import_dada2(seqtab=seqtab, taxatab=taxa, sampleda=sampleda)
mpse1

# parsing the output of qiime2
otuqzafile <- system.file("extdata", "table.qza", package="MicrobiotaProcess")
taxaqzafile <- system.file("extdata", "taxa.qza", package="MicrobiotaProcess")
mapfile <- system.file("extdata", "metadata_qza.txt", package="MicrobiotaProcess")
mpse2 <- mp_import_qiime2(otuqza=otuqzafile, taxaqza=taxaqzafile, mapfilename=mapfile)
mpse2

# parsing the output of MetaPhlAn
file1 <- system.file("extdata/MetaPhlAn", "metaphlan_test.txt", package="MicrobiotaProcess")
sample.file <- system.file("extdata/MetaPhlAn", "sample_test.txt", package="MicrobiotaProcess")
mpse3 <- mp_import_metaphlan(profile=file1, mapfilename=sample.file)
mpse3
# convert phyloseq object to mpse
#library(phyloseq)
#data(esophagus)
#esophagus
#mpse4 <- esophagus %>% as.MPSE() 
#mpse4
# convert TreeSummarizedExperiment object to mpse
# library(curatedMetagenomicData)
# tse <- curatedMetagenomicData::curatedMetagenomicData("ZhuF_2020.relative_abundance", dryrun=F)
# tse[[1]] %>% as.MPSE() -> mpse5
# mpse5

## ----fig.align="center", fig.width=12, fig.height=4, fig.cap="The rarefaction of samples or groups"----
library(ggplot2)
library(MicrobiotaProcess)
data(mouse.time.mpse)
mouse.time.mpse
# Rarefied species richness
mouse.time.mpse %<>% mp_rrarefy()
# 'chunks' represent the split number of each sample to calculate alpha
# diversity, default is 400. e.g. If a sample has total 40000
# reads, if chunks is 400, it will be split to 100 sub-samples
# (100, 200, 300,..., 40000), then alpha diversity index was
# calculated based on the sub-samples. 
# '.abundance' the column name of abundance, if the '.abundance' is not be 
# rarefied calculate rarecurve, user can specific 'force=TRUE'.
mouse.time.mpse %<>% 
    mp_cal_rarecurve(
        .abundance = RareAbundance,
        chunks = 400
    )
# The RareAbundanceRarecurve column will be added the colData slot 
# automatically (default action="add")
mouse.time.mpse %>% print(width=180)
# default will display the confidence interval around smooth.
# se=TRUE
p1 <- mouse.time.mpse %>% 
      mp_plot_rarecurve(
         .rare = RareAbundanceRarecurve, 
         .alpha = Observe,
      )

p2 <- mouse.time.mpse %>% 
      mp_plot_rarecurve(
         .rare = RareAbundanceRarecurve, 
         .alpha = Observe, 
         .group = time
      ) +
      scale_color_manual(values=c("#00A087FF", "#3C5488FF")) +
      scale_fill_manual(values=c("#00A087FF", "#3C5488FF"), guide="none")

# combine the samples belong to the same groups if 
# plot.group=TRUE
p3 <- mouse.time.mpse %>% 
      mp_plot_rarecurve(
         .rare = RareAbundanceRarecurve, 
         .alpha = "Observe", 
         .group = time, 
         plot.group = TRUE
      ) +
       scale_color_manual(values=c("#00A087FF", "#3C5488FF")) +
       scale_fill_manual(values=c("#00A087FF", "#3C5488FF"),guide="none")  

p1 + p2 + p3
# Users can extract the result with mp_extract_rarecurve to extract the result of mp_cal_rarecurve 
# and visualized the result manually.

## ----fig.width=7, fig.height=7, fig.align="center", message=FALSE, fig.cap="The alpha diversity comparison"----
library(ggplot2)
library(MicrobiotaProcess)
mouse.time.mpse %<>% 
    mp_cal_alpha(.abundance=RareAbundance)
mouse.time.mpse
f1 <- mouse.time.mpse %>% 
      mp_plot_alpha(
        .group=time, 
        .alpha=c(Observe, Chao1, ACE, Shannon, Simpson, Pielou)
      ) +
      scale_fill_manual(values=c("#00A087FF", "#3C5488FF"), guide="none") +
      scale_color_manual(values=c("#00A087FF", "#3C5488FF"), guide="none")

f2 <- mouse.time.mpse %>%
      mp_plot_alpha(
        .alpha=c(Observe, Chao1, ACE, Shannon, Simpson, Pielou)
      )

f1 / f2

## ----fig.align="center", fig.width=8, fig.height=8, fig.cap="The relative abundance and abundance of phyla of all samples "----
mouse.time.mpse 
mouse.time.mpse %<>%
    mp_cal_abundance( # for each samples
      .abundance = RareAbundance
    ) %>%
    mp_cal_abundance( # for each groups 
      .abundance=RareAbundance,
      .group=time
    )
mouse.time.mpse

# visualize the relative abundance of top 20 phyla for each sample.
p1 <- mouse.time.mpse %>%
         mp_plot_abundance(
           .abundance=RareAbundance,
           .group=time, 
           taxa.class = Phylum, 
           topn = 20,
           relative = TRUE
         )
# visualize the abundance (rarefied) of top 20 phyla for each sample.
p2 <- mouse.time.mpse %>%
          mp_plot_abundance(
            .abundance=RareAbundance,
            .group=time,
            taxa.class = Phylum,
            topn = 20,
            relative = FALSE
          )
p1 / p2

## ----fig.align="center", fig.width=12, fig.height=4, fig.cap="The relative abundance and abundance of phyla of all samples "----
h1 <- mouse.time.mpse %>%
         mp_plot_abundance(
           .abundance = RareAbundance,
           .group = time,
           taxa.class = Phylum,
           relative = TRUE,
           topn = 20,
           geom = 'heatmap',
           features.dist = 'euclidean',
           features.hclust = 'average',
           sample.dist = 'bray',
           sample.hclust = 'average'
         )

h2 <- mouse.time.mpse %>%
          mp_plot_abundance(
            .abundance = RareAbundance,
            .group = time,
            taxa.class = Phylum,
            relative = FALSE,
            topn = 20,
            geom = 'heatmap',
            features.dist = 'euclidean',
            features.hclust = 'average',
            sample.dist = 'bray',
            sample.hclust = 'average'
          )
# the character (scale or theme) of figure can be adjusted by set_scale_theme
# refer to the mp_plot_dist
aplot::plot_list(gglist=list(h1, h2), tag_levels="A")

## ----fig.align="center", fig.width=8, fig.height=8, fig.cap="The relative abundance and abundance of phyla of groups "----
# visualize the relative abundance of top 20 phyla for each .group (time)
p3 <- mouse.time.mpse %>%
         mp_plot_abundance(
            .abundance=RareAbundance, 
            .group=time,
            taxa.class = Phylum,
            topn = 20,
            plot.group = TRUE
          )

# visualize the abundance of top 20 phyla for each .group (time)
p4 <- mouse.time.mpse %>%
          mp_plot_abundance(
             .abundance=RareAbundance,
             .group= time,
             taxa.class = Phylum,
             topn = 20,
             relative = FALSE,
             plot.group = TRUE
           )
p3 / p4

## ----fig.align="center", fig.width=5, fig.height=4.6, fig.cap='the distance between samples'----
# standardization
# mp_decostand wraps the decostand of vegan, which provides
# many standardization methods for community ecology.
# default is hellinger, then the abundance processed will
# be stored to the assays slot. 
mouse.time.mpse %<>% 
    mp_decostand(.abundance=Abundance)
mouse.time.mpse
# calculate the distance between the samples.
# the distance will be generated a nested tibble and added to the
# colData slot.
mouse.time.mpse %<>% mp_cal_dist(.abundance=hellinger, distmethod="bray")
mouse.time.mpse
# mp_plot_dist provides there methods to visualize the distance between the samples or groups
# when .group is not provided, the dot heatmap plot will be return
p1 <- mouse.time.mpse %>% mp_plot_dist(.distmethod = bray)
p1

## ----fig.align="center", fig.width= 5, fig.height = 4.4, fig.cap = "The distance between samples with group information"----
# when .group is provided, the dot heatmap plot with group information will be return.
p2 <- mouse.time.mpse %>% mp_plot_dist(.distmethod = bray, .group = time)
# The scale or theme of dot heatmap plot can be adjusted using set_scale_theme function.
p2 %>% set_scale_theme(
          x = scale_fill_manual(
                 values=c("orange", "deepskyblue"), 
                 guide = guide_legend(
                             keywidth = 1, 
                             keyheight = 0.5, 
                             title.theme = element_text(size=8),
                             label.theme = element_text(size=6)
                 )
              ), 
          aes_var = time # specific the name of variable 
       ) %>%
       set_scale_theme(
          x = scale_color_gradient(
                 guide = guide_legend(keywidth = 0.5, keyheight = 0.5)
              ),
          aes_var = bray
       ) %>%
       set_scale_theme(
          x = scale_size_continuous(
                 range = c(0.1, 3),
                 guide = guide_legend(keywidth = 0.5, keyheight = 0.5)
              ),
          aes_var = bray
       )

## ----fig.align="center", fig.width=2, fig.height=4, fig.cap = "The comparison of distance among the groups"----
# when .group is provided and group.test is TRUE, the comparison of different groups will be returned
p3 <- mouse.time.mpse %>% mp_plot_dist(.distmethod = bray, .group = time, group.test=TRUE, textsize=2)
p3 

## ----fig.width=10, fig.height=4, fig.align="center", fig.cap="The PCoA result"----
mouse.time.mpse %<>% 
    mp_cal_pcoa(.abundance=hellinger, distmethod="bray")
# The dimensions of ordination analysis will be added the colData slot (default).
mouse.time.mpse
# We also can perform adonis or anosim to check whether it is significant to the dissimilarities of groups.
mouse.time.mpse %<>%
     mp_adonis(.abundance=hellinger, .formula=~time, distmethod="bray", permutations=9999, action="add")
mouse.time.mpse %>% mp_extract_internal_attr(name=adonis)

library(ggplot2)
p1 <- mouse.time.mpse %>%
        mp_plot_ord(
          .ord = pcoa, 
          .group = time, 
          .color = time, 
          .size = 1.2,
          .alpha = 1,
          ellipse = TRUE,
          show.legend = FALSE # don't display the legend of stat_ellipse
        ) +
        scale_fill_manual(values=c("#00A087FF", "#3C5488FF")) +
        scale_color_manual(values=c("#00A087FF", "#3C5488FF")) 

# The size of point also can be mapped to other variables such as Observe, or Shannon 
# Then the alpha diversity and beta diversity will be displayed simultaneously.
p2 <- mouse.time.mpse %>% 
        mp_plot_ord(
          .ord = pcoa, 
          .group = time, 
          .color = time, 
          .size = Observe, 
          .alpha = Shannon,
          ellipse = TRUE,
          show.legend = FALSE # don't display the legend of stat_ellipse 
        ) +
        scale_fill_manual(
          values = c("#00A087FF", "#3C5488FF"), 
          guide = guide_legend(keywidth=0.6, keyheight=0.6, label.theme=element_text(size=6.5))
        ) +
        scale_color_manual(
          values=c("#00A087FF", "#3C5488FF"),
          guide = guide_legend(keywidth=0.6, keyheight=0.6, label.theme=element_text(size=6.5))
        ) +
        scale_size_continuous(
          range=c(0.5, 3),
          guide = guide_legend(keywidth=0.6, keyheight=0.6, label.theme=element_text(size=6.5))
        )
p1 + p2

## ----fig.width=5, fig.height=5, fig.align="center", fig.cap="The hierarchical cluster result of samples"----
mouse.time.mpse %<>%
       mp_cal_clust(
         .abundance = hellinger, 
         distmethod = "bray",
         hclustmethod = "average", # (UPGAE)
         action = "add" # action is used to control which result will be returned
       )
mouse.time.mpse
# if action = 'add', the result of hierarchical cluster will be added to the MPSE object
# mp_extract_internal_attr can extract it. It is a treedata object, so it can be visualized
# by ggtree.
sample.clust <- mouse.time.mpse %>% mp_extract_internal_attr(name='SampleClust')
sample.clust
library(ggtree)
p <- ggtree(sample.clust) + 
       geom_tippoint(aes(color=time)) +
       geom_tiplab(as_ylab = TRUE) +
       ggplot2::scale_x_continuous(expand=c(0, 0.01))
p

## ----fig.width=10, fig.height=6, fig.align="center", fig.cap = "The hierarchical cluster result of samples and the abundance of Phylum"----
library(ggtreeExtra)
library(ggplot2)
phyla.tb <- mouse.time.mpse %>% 
            mp_extract_abundance(taxa.class=Phylum, topn=30)
# The abundance of each samples is nested, it can be flatted using the unnest of tidyr.
phyla.tb %<>% tidyr::unnest(cols=RareAbundanceBySample) %>% dplyr::rename(Phyla="label")
phyla.tb
p1 <- p + 
      geom_fruit(
         data=phyla.tb,
         geom=geom_col,
         mapping = aes(x = RelRareAbundanceBySample, 
                       y = Sample, 
                       fill = Phyla
                 ),
         orientation = "y",
         #offset = 0.4,
         pwidth = 3, 
         axis.params = list(axis = "x", 
                            title = "The relative abundance of phyla (%)",
                            title.size = 4,
                            text.size = 2, 
                            vjust = 1),
         grid.params = list()
      )
p1

## ----fig.width=10, fig.height=10, fig.align="center", fig.cap="The different species and the abundance of sample"----
library(ggtree)
library(ggtreeExtra)
library(ggplot2)
library(MicrobiotaProcess)
library(tidytree)
library(ggstar)
library(forcats)
mouse.time.mpse %>% print(width=150)
mouse.time.mpse %<>%
    mp_diff_analysis(
       .abundance = RelRareAbundanceBySample,
       .group = time,
       first.test.alpha = 0.01
    )
# The result is stored to the taxatree or otutree slot, you can use mp_extract_tree to extract the specific slot.
taxa.tree <- mouse.time.mpse %>% 
               mp_extract_tree(type="taxatree")
taxa.tree
# And the result tibble of different analysis can also be extracted 
# with tidytree (>=0.3.5)
taxa.tree %>% select(label, nodeClass, LDAupper, LDAmean, LDAlower, Sign_time, pvalue, fdr) %>% dplyr::filter(!is.na(fdr))

# Since taxa.tree is treedata object, it can be visualized by ggtree and ggtreeExtra
p1 <- ggtree(
        taxa.tree,
        layout="radial",
        size = 0.3
      ) +
      geom_point(
        data = td_filter(!isTip),
        fill="white",
        size=1,
        shape=21
      )
# display the high light of phylum clade.
p2 <- p1 +
      geom_hilight(
        data = td_filter(nodeClass == "Phylum"),
        mapping = aes(node = node, fill = label)
      )
# display the relative abundance of features(OTU)
p3 <- p2 +
      ggnewscale::new_scale("fill") +
      geom_fruit(
         data = td_unnest(RareAbundanceBySample),
         geom = geom_star,
         mapping = aes(
                       x = fct_reorder(Sample, time, .fun=min),
                       size = RelRareAbundanceBySample,
                       fill = time,
                       subset = RelRareAbundanceBySample > 0
                   ),
         starshape = 13,
         starstroke = 0.25,
         offset = 0.04,
         pwidth = 0.8,
         grid.params = list(linetype=2)
      ) +
      scale_size_continuous(
         name="Relative Abundance (%)",
         range = c(.5, 3)
      ) +
      scale_fill_manual(values=c("#1B9E77", "#D95F02"))
# display the tip labels of taxa tree
p4 <- p3 + geom_tiplab(size=2, offset=7.2)
# display the LDA of significant OTU.
p5 <- p4 +
      ggnewscale::new_scale("fill") +
      geom_fruit(
         geom = geom_col,
         mapping = aes(
                       x = LDAmean,
                       fill = Sign_time,
                       subset = !is.na(LDAmean)
                       ),
         orientation = "y",
         offset = 0.3,
         pwidth = 0.5,
         axis.params = list(axis = "x",
                            title = "Log10(LDA)",
                            title.height = 0.01,
                            title.size = 2,
                            text.size = 1.8,
                            vjust = 1),
         grid.params = list(linetype = 2)
      )

# display the significant (FDR) taxonomy after kruskal.test (default)
p6 <- p5 +
      ggnewscale::new_scale("size") +
      geom_point(
         data=td_filter(!is.na(Sign_time)),
         mapping = aes(size = -log10(fdr),
                       fill = Sign_time,
                       ),
         shape = 21,
      ) +
      scale_size_continuous(range=c(1, 3)) +
      scale_fill_manual(values=c("#1B9E77", "#D95F02"))

p6 + theme(
           legend.key.height = unit(0.3, "cm"),
           legend.key.width = unit(0.3, "cm"),
           legend.spacing.y = unit(0.02, "cm"),
           legend.text = element_text(size = 7),
           legend.title = element_text(size = 9),
          )

## ----fig.width=9, fig.height=9, fig.align="center", fig.cap="The different species and the abundance of group"----
# this object has contained the result of mp_diff_analysis
mouse.time.mpse
# Because the released `ggnewscale` modified the internal new aesthetics name,
# The following code is to obtain the new aesthetics name according to version of
# `ggnewscale`
flag <- packageVersion("ggnewscale") >= "0.5.0"
new.fill <- ifelse(flag, "fill_ggnewscale_1", "fill_new_new")
new.fill2 <- ifelse(flag , "fill_ggnewscale_2", "fill_new")

p <- mouse.time.mpse %>%
       mp_plot_diff_res(
         group.abun = TRUE,
         pwidth.abun=0.1
       ) 
# if version of `ggnewscale` is >= 0.5.0, you can also use p$ggnewscale to view the renamed scales.
p <- p  +
       scale_fill_manual(values=c("deepskyblue", "orange")) +
       scale_fill_manual(
         aesthetics = new.fill2, # The fill aes was renamed to `new.fill` for the abundance dotplot layer
         values = c("deepskyblue", "orange")
       ) +
       scale_fill_manual(
         aesthetics = new.fill, # The fill aes for hight light layer of tree was renamed to `new.fill2`
         values = c("#E41A1C", "#377EB8", "#4DAF4A",
                    "#984EA3", "#FF7F00", "#FFFF33",
                     "#A65628", "#F781BF", "#999999"
                   )
       )
p

## ----fig.width = 9, fig.height=9, fig.align="center", fig.cap="The cladogram of differential species "----
f <- mouse.time.mpse %>%
     mp_plot_diff_cladogram(
       label.size = 2.5,
       hilight.alpha = .3,
       bg.tree.size = .5,
       bg.point.size = 2,
       bg.point.stroke = .25
     ) +
     scale_fill_diff_cladogram( # set the color of different group.
       values = c('deepskyblue', 'orange')
     ) +
     scale_size_continuous(range = c(1, 4))
f

## ----fig.width = 12, fig.height = 5, fig.align = 'center', fig.cap = 'The abundance and LDA effect size of differential taxa'----
f.box <- mouse.time.mpse %>%
         mp_plot_diff_boxplot(
           .group = time,
         ) %>%
         set_diff_boxplot_color(
           values = c("deepskyblue", "orange"),
           guide = guide_legend(title=NULL)
         )

f.bar <- mouse.time.mpse %>%
         mp_plot_diff_boxplot(
           taxa.class = c(Genus, OTU), # select the taxonomy level to display
           group.abun = TRUE, # display the mean abundance of each group
           removeUnknown = TRUE, # whether mask the unknown taxa.
         ) %>%
         set_diff_boxplot_color(
           values = c("deepskyblue", "orange"),
           guide = guide_legend(title=NULL)
         )

aplot::plot_list(f.box, f.bar)

## ----fig.width = 10, fig.height = 4.5, fig.align = 'center', fig.cap = 'The mahattan plot of differential taxa'----
f.mahattan <- mouse.time.mpse %>%
    mp_plot_diff_manhattan(
       .group = Sign_time,
       .y = fdr,
       .size = 2.4,
       taxa.class = c('OTU', 'Genus'),
       anno.taxa.class = Phylum
    )
f.mahattan

## ----echo=FALSE---------------------------------------------------------------
sessionInfo()

