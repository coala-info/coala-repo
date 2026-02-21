# Code example from 'Pedixplorer' vignette. See references/ for full tutorial.

## ----width_control, echo = FALSE------------------------------------------------------------------
options(width = 100)

## ----BiocManager_install, eval = FALSE------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE)) {
#     install.packages("BiocManager")
# }
# BiocManager::install("Pedixplorer")

## ----library_charge-------------------------------------------------------------------------------
library(plotly)
library(dplyr)
library(Pedixplorer)

## ----Pedigree_creation----------------------------------------------------------------------------
data("sampleped")
print(sampleped[1:10, ])
pedi <- Pedigree(sampleped[c(3, 4, 10, 35, 36), ])
print(pedi)

## ----ped1, fig.alt = "Pedigree of family 1", fig.align = "center"---------------------------------
pedi <- Pedigree(sampleped)
print(famid(ped(pedi)))
ped1 <- pedi[famid(ped(pedi)) == "1"]
summary(ped1)
plot(ped1, cex = 0.7)

## ----ped1_title, fig.alt = "Pedigree of family 1 with legend"-------------------------------------
plot(
    ped1, title = "Pedigree 1",
    legend = TRUE, leg_loc = c(0.45, 0.9, 0.8, 1),
    cex = 0.7, leg_symbolsize = 0.04
)

## ----shiny_app, eval = FALSE----------------------------------------------------------------------
# ped_shiny()

## ----datped2--------------------------------------------------------------------------------------
datped2 <- sampleped[sampleped$famid == 2, ]
datped2[datped2$id %in% 203, "sex"] <- 2
datped2 <- datped2[-which(datped2$id %in% 209), ]

## ----fixped2, fig.alt = "Pedigree of family 2"----------------------------------------------------
tryout <- try({
    ped2 <- Pedigree(datped2)
})
fixped2 <- with(datped2, fix_parents(id, dadid, momid, sex))
fixped2
ped2 <- Pedigree(fixped2)
plot(ped2)

## ----calc_kinship---------------------------------------------------------------------------------
kin2 <- kinship(ped2)
kin2[1:9, 1:9]

## ----kin_all--------------------------------------------------------------------------------------
pedi <- Pedigree(sampleped)
adopted(ped(pedi)) <- FALSE # Remove adoption status
kin_all <- kinship(pedi)
kin_all[1:9, 1:9]
kin_all[40:43, 40:43]
kin_all[42:46, 42:46]

## ----kin_twins------------------------------------------------------------------------------------
data("relped")
relped
pedi <- Pedigree(sampleped, relped)
adopted(ped(pedi)) <- FALSE # Remove adoption status
kin_all <- kinship(pedi)
kin_all[24:27, 24:27]
kin_all[46:50, 46:50]

## ----deceased, fig.alt = "Pedigree of family 2 with different vital status"-----------------------
df2 <- sampleped[sampleped$famid == 2, ]
names(df2)
df2$deceased <- c(1, 1, rep(0, 12))
ped2 <- Pedigree(df2)
summary(deceased(ped(ped2)))
plot(ped2)

## ----labels, fig.alt = "Pedigree of family 2 with names label"------------------------------------
mcols(ped2)$Names <- c(
    "John\nDalton", "Linda", "Jack", "Rachel", "Joe", "Deb",
    "Lucy", "Ken", "Barb", "Mike", "Matt",
    "Mindy", "Mark", "Marie\nCurie"
)
plot(ped2, label = "Names", cex = 0.7)

## ----two_affection, fig.alt = "Family 2 pedigree with two affections"-----------------------------
mcols(ped2)$bald <- as.factor(c(0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1))
ped2 <- generate_colors(ped2, col_aff = "bald", add_to_scale = TRUE)
# Increase down margin for the legend
op <- par(mai = c(1.5, 0.2, 0.2, 0.2))
plot(
    ped2, legend = TRUE,
    leg_loc = c(0.5, 6, 3.5, 4)
)
# Reset graphical parameter
par(op)

## ----twins, fig.alt = "Family 2 pedigree with special relationships"------------------------------
## create twin relationships
data("relped")
rel(ped2) <- Rel(relped[relped$famid == 2, ])
plot(ped2)

## ----inbreeding, fig.alt = "Pedigree with inbreeding"---------------------------------------------
indid <- 195:202
dadid <- c(NA, NA, NA, 196, 196, NA, 197, 199)
momid <- c(NA, NA, NA, 195, 195, NA, 198, 200)
sex <- c(2, 1, 1, 2, 1, 2, 1, 2)
ped3 <- data.frame(
    id = indid, dadid = dadid,
    momid = momid, sex = sex
)

ped4df <- rbind.data.frame(df2[-c(1, 2), 2:5], ped3)
ped4 <- Pedigree(ped4df)
plot(ped4)

## ----spouse, fig.alt = "Pedigree with spouse with no children"------------------------------------
## create twin relationships
rel_df2 <- data.frame(
    id1 = "211",
    id2 = "212",
    code = 4,
    famid = "2"
)
new_rel <- c(rel(ped2), with(rel_df2, Rel(id1, id2, code, famid)))
rel(ped2) <- upd_famid(new_rel)
plot(ped2)

## ----plotped1, fig.alt = "Pedigree of family 1"---------------------------------------------------
df1 <- sampleped[sampleped$famid == 1, ]
relate1 <- data.frame(
    id1 = 113,
    id2 = 114,
    code = 4,
    famid = 1
)
ped1 <- Pedigree(df1, relate1)
plot(ped1, cex = 0.7)

## ----ordering, fig.alt = "Pedigree of family 1 with reordering"-----------------------------------
df1reord <- df1[c(35:41, 1:34), ]
ped1reord <- Pedigree(df1reord, relate1)
plot(ped1reord, cex = 0.7)

## ----generate_colors, fig.alt = "Pedigree of family 1 with change in colors"----------------------
scales(ped1)
# Remove proband and asymptomatic status as they need to be
# affected and unaffected respectively for the new status
proband(ped(ped1)) <- FALSE
asymptomatic(ped(ped1)) <- FALSE
ped1 <- generate_colors(
    ped1, col_aff = "num",
    add_to_scale = TRUE, is_num = TRUE,
    keep_full_scale = TRUE, breaks = 2,
    colors_aff = c("blue", "green"),
    colors_unaff = c("yellow", "brown"),
    threshold = 3, sup_thres_aff = FALSE
)

plot(ped1, cex = 0.7)

# To modify a given scale you can do as follow
fill(ped1)
fill(ped1)$fill[4] <- "#970b6d"
fill(ped1)$density[5] <- 30
fill(ped1)$angle[5] <- 45
border(ped1)$border <- c("red", "black", "orange")
plot(
    ped1, cex = 0.7, legend = TRUE,
    leg_loc = c(6, 16, 1, 1.8), leg_cex = 0.5,
)

## ----label_size, fig.alt = "Pedigree with change in label size and distance"----------------------
# Reset the affection status
ped1 <- generate_colors(
    ped1, col_aff = "num",
    add_to_scale = FALSE, is_num = TRUE,
    keep_full_scale = FALSE,
    threshold = 3, sup_thres_aff = FALSE
)
plot(
    ped1, cex = 0.7, label = "num_mods",
    label_cex = c(0.8, 0.6, 2), # Change the text size
    label_dist = c(1, 5, 2.5) # Change the order and distance from the box
)

## ----legend_ggplot2, fig.alt = "Pedigree with legend"---------------------------------------------
library(cowplot)

plot_lst <- plot(
    ped1, ggplot_gen = TRUE, legend = TRUE,
    leg_cex = 0.8, leg_symbolsize = 0.1,
)
cowplot::plot_grid(
    plot_lst$ggplot,
    plot_lst$legend$ggplot +
        ggplot2::xlim(-2, 20),
    ncol = 1, nrow = 2, rel_heights = c(4, 1)
)

## ----prepare_interactive, fig.show='hide'---------------------------------------------------------
plot_list <- plot(
    ped1,
    symbolsize = 0.8, # Reduce the symbole size
    title = "My pedigree", # Add a title
    lwd = 0.5, # Set the line width
    cex = 0.8, # Set the text size
    ggplot_gen = TRUE, # Use ggplot2 to draw the Pedigree
    tips = c(
        "id", "avail",
        "affection",
        "num"
    ) # Add some information in the tooltip
)

## ----interactive, fig.alt = "Interactive Pedigree of family 1"------------------------------------
plotly::ggplotly(
    plot_list$ggplot,
    tooltip = "text"
) %>%
    plotly::layout(hoverlabel = list(bgcolor = "darkgrey"))

## ----ped2df, eval = FALSE-------------------------------------------------------------------------
# dfped2 <- as.data.frame(ped(ped2))
# dfped2

## ----useful_inds----------------------------------------------------------------------------------
data(sampleped)
ped1 <- Pedigree(sampleped)
ped1 <- is_informative(ped1, informative = c("1_110", "1_120"))
ped1 <- useful_inds(ped1, max_dist = 1)
print(useful(ped(ped1)))
ped_filtered <- ped1[useful(ped(ped1))]
plot(ped_filtered)

## ----subset---------------------------------------------------------------------------------------
ped2_rm210 <- ped2[-10]
rel(ped2_rm210)
rel(ped2)

## ----subset_more----------------------------------------------------------------------------------
ped2_trim210 <- subset(ped2, "2_210", keep = FALSE)
id(ped(ped2_trim210))
rel(ped2_trim210)
ped2_trim_more <- subset(ped2_trim210, c("2_212", "2_214"), keep = FALSE)
id(ped(ped2_trim_more))
rel(ped2_trim_more)

## ----shrink1, fig.alt = "Pedigree of family 1 shrinked to 30 bits"--------------------------------
set.seed(200)
shrink1_b30 <- shrink(ped1, max_bits = 30)
print(shrink1_b30[c(2:8)])
plot(shrink1_b30$pedObj)

## ----shrink2, fig.alt = "Pedigree of family 1 shrinked to 25 bits"--------------------------------
set.seed(10)
shrink1_b25 <- shrink(ped1, max_bits = 25)
print(shrink1_b25[c(2:8)])
plot(shrink1_b25$pedObj)

## ----unrelateds-----------------------------------------------------------------------------------
ped2 <- Pedigree(df2)
set.seed(10)
set1 <- unrelated(ped2)
set1
set2 <- unrelated(ped2)
set2

## ----unrelkin-------------------------------------------------------------------------------------
kin2 <- kinship(ped2)
is_avail <- id(ped(ped2))[avail(ped(ped2))]
kin2
kin2[is_avail, is_avail]

## -------------------------------------------------------------------------------------------------
sessionInfo()

