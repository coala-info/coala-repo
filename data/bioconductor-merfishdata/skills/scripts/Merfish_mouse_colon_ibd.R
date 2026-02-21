# Code example from 'Merfish_mouse_colon_ibd' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>",
    crop = NULL 
)

## ----lib, message = FALSE-----------------------------------------------------
library(MerfishData)
library(ExperimentHub)
library(ggplot2)
library(scater)
library(terra)

## ----eh-----------------------------------------------------------------------
eh <- ExperimentHub()
AnnotationHub::query(eh, c("MerfishData", "Cadinu2024"))

## ----data, message = FALSE----------------------------------------------------
spe <- MouseColonIbdCadinu2024()
spe

## ----datacomp-----------------------------------------------------------------
counts(spe)[1:5,1:5]
logcounts(spe)[1:5,1:5]
colData(spe)
head(spatialCoords(spe))

## ----tiers--------------------------------------------------------------------
table(spe$tier1)
table(spe$tier2)
table(spe$tier3)

## ----stype--------------------------------------------------------------------
table(spe$sample_type)

## ----fig1c, message=FALSE-----------------------------------------------------
plotReducedDim(spe, "UMAP", colour_by = "tier1", 
               scattermore = TRUE, rasterise = TRUE) +
    scale_color_manual(values = metadata(spe)$colors_tier1) + 
    labs(color = "cell type") 

## ----fig1d--------------------------------------------------------------------
# Filter spatial coordinates for the selected slice ID
slice_coords <- spatialCoords(spe)[spe$mouse_id == "082421_D0_m6" &
                                   spe$sample_type == "Healthy" &
                                   spe$technical_repeat_number == "1" &
                                   spe$slice_id == "2", ]
# Rotate coordinates to have them match the rotation in the paper
slice_coords_vec <- vect(slice_coords, type = "points")
slice_coords_r <- spin(slice_coords_vec, 180)
slice_c <- as.data.frame(slice_coords_r, geom = "XY")
slice_df <- data.frame(x = slice_c[,1],
                       y = slice_c[,2],
                       tier1 = spe$tier1[spe$mouse_id == "082421_D0_m6" &
                                         spe$sample_type == "Healthy" &
                                         spe$technical_repeat_number == "1" &
                                         spe$slice_id == "2"])
# Plot
ggplot(data = slice_df, aes(x = x, y = y, color = tier1)) +
    geom_point(shape = 19, size = 0.5) +
    scale_color_manual(values = metadata(spe)$colors_tier1) +
    guides(colour = guide_legend(override.aes = list(size = 2))) + 
    labs(color = "cell type") +
    theme_bw(10)

## ----fig.height = 8, fig.width = 10-------------------------------------------
# Filter spatial coordinates for the selected slice ID
slice_coords <- spatialCoords(spe)[(spe$mouse_id == "062921_D0_m3a" &
                                     spe$slice_id=="2") |
                                     (spe$mouse_id == "092421_D3_m1" &
                                     spe$slice_id=="2")|
                                     (spe$mouse_id == "062221_D9_m3" &
                                     spe$slice_id=="2") |
                                     (spe$mouse_id == "082421_D21_m1" &
                                     spe$slice_id=="2"), ]


slice_df <- data.frame(x = scale(slice_coords[, 1], scale = FALSE),
                       y = scale(slice_coords[, 2], scale = FALSE),
                       tier1 = spe$tier1[(spe$mouse_id == "062921_D0_m3a" &
                                     spe$slice_id=="2") |
                                     (spe$mouse_id == "092421_D3_m1" &
                                     spe$slice_id=="2")|
                                     (spe$mouse_id == "062221_D9_m3" &
                                     spe$slice_id=="2") |
                                     (spe$mouse_id == "082421_D21_m1" &
                                     spe$slice_id=="2")],
                       day = spe$sample_type[(spe$mouse_id == "062921_D0_m3a" &
                                     spe$slice_id=="2") |
                                    (spe$mouse_id == "092421_D3_m1" &
                                     spe$slice_id=="2")|
                                     (spe$mouse_id == "062221_D9_m3" &
                                     spe$slice_id=="2") |
                                     (spe$mouse_id == "082421_D21_m1" &
                                     spe$slice_id=="2")])

slice_df$day <- factor(slice_df$day, levels = c("Healthy", "DSS3", "DSS9", "DSS21"))

ggplot(data = slice_df, aes(x = x, y = y, color = tier1)) +
    geom_point(shape = 19, size = 0.5) +
    scale_color_manual(values = metadata(spe)$colors_tier1) +
    theme_bw(10) + guides(colour = guide_legend(override.aes = list(size=2)))+ 
    labs(color = "cell type") +
    facet_wrap( ~ day, ncol = 2, nrow = 2, scales = "free")

## ----fig.height = 8, fig.width = 10-------------------------------------------
slice_df$tier2 <- spe$tier2[(spe$mouse_id == "062921_D0_m3a" &
                                     spe$slice_id=="2") |
                                     (spe$mouse_id == "092421_D3_m1" &
                                     spe$slice_id=="2")|
                                     (spe$mouse_id == "062221_D9_m3" &
                                     spe$slice_id=="2") |
                                     (spe$mouse_id == "082421_D21_m1" &
                                     spe$slice_id=="2")]
slice_df$color <- ifelse(slice_df$tier1 == "Epithelial", 
                         as.character(slice_df$tier2), "grey")

slice_df$color <- factor(slice_df$color)

colored_df <- slice_df[slice_df$tier1 == "Epithelial", ]

ggplot() +
  geom_point(data = slice_df, aes(x = x, y = y), color = "grey", 
             shape = 19, size = 0.1) +
  geom_point(data = colored_df, aes(x = x, y = y, color = tier2), 
             shape = 19, size = 0.1) +
  scale_color_manual(values = metadata(spe)$colors_tier2) +
  theme_bw(10) +
  guides(colour = guide_legend(override.aes = list(size = 2))) +
  labs(color = 'cell type') +
  facet_wrap(~ day, ncol = 2, scales = "free")

## ----fig.height = 8, fig.width = 10-------------------------------------------
slice_df$color <- ifelse(slice_df$tier1 == "Immune", 
                         as.character(slice_df$tier2),
                         "grey")
slice_df$color <- factor(slice_df$color)
colored_df <- subset(slice_df, tier1 == "Immune")

p <- ggplot() +
  geom_point(data = slice_df, aes(x = x, y = y), color = "grey", 
             shape = 19, size = 0.1) +
  geom_point(data = colored_df, aes(x = x, y = y, color = tier2), 
             shape = 19, size = 0.1) +
  scale_color_manual(values = metadata(spe)$colors_tier2) +
  theme_bw(10) +
  guides(colour = guide_legend(override.aes = list(size = 2))) +
  labs(color = 'cell type') +
  facet_wrap(~ day, ncol = 2, scales = "free")

p

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

