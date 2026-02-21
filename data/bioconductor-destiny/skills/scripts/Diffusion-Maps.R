# Code example from 'Diffusion-Maps' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(base64enc)
library(ggplot2)  # would shadow Biobase::exprs

suppressPackageStartupMessages({
    library(readxl)
    library(destiny)
    library(Biobase)
})

## -----------------------------------------------------------------------------
library(readxl)
raw_ct <- read_xls('mmc4.xls', 'Sheet1')

raw_ct[1:9, 1:9]  #preview of a few rows and columns

## -----------------------------------------------------------------------------
library(destiny)
library(Biobase)

# as.data.frame because ExpressionSets
# do not support readxl’s “tibbles”
ct <- as.ExpressionSet(as.data.frame(raw_ct))
ct

## -----------------------------------------------------------------------------
num_cells <- gsub('^(\\d+)C.*$', '\\1', ct$Cell)
ct$num_cells <- as.integer(num_cells)

## -----------------------------------------------------------------------------
# cells from 2+ cell embryos
have_duplications <- ct$num_cells > 1
# cells with values <= 28
normal_vals <- apply(exprs(ct), 2, function(smp) all(smp <= 28))

## -----------------------------------------------------------------------------
cleaned_ct <- ct[, have_duplications & normal_vals]

## -----------------------------------------------------------------------------
housekeepers <- c('Actb', 'Gapdh')  # houskeeper gene names

normalizations <- colMeans(exprs(cleaned_ct)[housekeepers, ])

guo_norm <- cleaned_ct
exprs(guo_norm) <- exprs(guo_norm) - normalizations

## -----------------------------------------------------------------------------
library(destiny)
#If you start here, run: data(guo_norm)
dm <- DiffusionMap(guo_norm)

## -----------------------------------------------------------------------------
plot(dm)

## -----------------------------------------------------------------------------
palette(cube_helix(6)) # configure color palette

plot(dm,
    pch = 20,             # pch for prettier points
    col_by = 'num_cells', # or “col” with a vector or one color
    legend_main = 'Cell stage')

## -----------------------------------------------------------------------------
plot(dm, 1:2,
    col_by = 'num_cells',
    legend_main = 'Cell stage')

## -----------------------------------------------------------------------------
if (require(rgl)) {
	plot3d(
	    eigenvectors(dm)[, 1:3],
	    col = log2(guo_norm$num_cells),
	    type = 's', radius = .01)
	view3d(theta = 10, phi = 30, zoom = .8)
	# now use your mouse to rotate the plot in the window
	close3d()
}

## -----------------------------------------------------------------------------
library(ggplot2)
ggplot(dm, aes(DC1, DC2, colour = factor(num_cells))) +
    geom_point() + scale_color_cube_helix()

## -----------------------------------------------------------------------------
ggplot(NULL, aes(x = seq_along(eigenvalues(dm)), y = eigenvalues(dm))) + theme_minimal() +
    geom_point() + labs(x = 'Diffusion component (DC)', y = 'Eigenvalue')

## -----------------------------------------------------------------------------
plot(dm, 3:4,   col_by = 'num_cells', draw_legend = FALSE)
plot(dm, 19:20, col_by = 'num_cells', draw_legend = FALSE)

## -----------------------------------------------------------------------------
hist(exprs(cleaned_ct)['Aqp3', ], breaks = 20,
     xlab = 'Ct of Aqp3', main = 'Histogram of Aqp3 Ct',
     col = palette()[[4]], border = 'white')

## -----------------------------------------------------------------------------
dilutions <- read_xls('mmc6.xls', 1L)
dilutions$Cell <- NULL  # remove annotation column

get_lod <- function(gene) gene[[max(which(gene != 28))]]

lods <- apply(dilutions, 2, get_lod)
lod <- ceiling(median(lods))
lod

## -----------------------------------------------------------------------------
lod_norm <- ceiling(median(lods) - mean(normalizations))
max_cycles_norm <- ceiling(40 - mean(normalizations))

list(lod_norm = lod_norm, max_cycles_norm = max_cycles_norm)

## -----------------------------------------------------------------------------
guo <- guo_norm
exprs(guo)[exprs(cleaned_ct) >= 28] <- lod_norm

## -----------------------------------------------------------------------------
thresh_dm <- DiffusionMap(guo,
    censor_val = lod_norm,
    censor_range = c(lod_norm, max_cycles_norm),
    verbose = FALSE)

plot(thresh_dm, 1:2, col_by = 'num_cells',
     legend_main = 'Cell stage')

## -----------------------------------------------------------------------------
# remove rows with divisionless cells
ct_w_missing <- ct[, ct$num_cells > 1L]
# and replace values larger than the baseline
exprs(ct_w_missing)[exprs(ct_w_missing) > 28] <- NA

## -----------------------------------------------------------------------------
housekeep <- colMeans(
    exprs(ct_w_missing)[housekeepers, ],
    na.rm = TRUE)

w_missing <- ct_w_missing
exprs(w_missing) <- exprs(w_missing) - housekeep

exprs(w_missing)[is.na(exprs(ct_w_missing))] <- lod_norm

## -----------------------------------------------------------------------------
dif_w_missing <- DiffusionMap(w_missing,
    censor_val = lod_norm,
    censor_range = c(lod_norm, max_cycles_norm),
    missing_range = c(1, 40),
    verbose = FALSE)

plot(dif_w_missing, 1:2, col_by = 'num_cells',
     legend_main = 'Cell stage')

## -----------------------------------------------------------------------------
ct64 <- guo[, guo$num_cells == 64]
dm64 <- DiffusionMap(ct64)

## -----------------------------------------------------------------------------
ct32 <- guo[, guo$num_cells == 32]
pred32 <- dm_predict(dm64, ct32)

## -----------------------------------------------------------------------------
plot(dm64,    1:2,     col     = palette()[[6]],
     new_dcs = pred32, col_new = palette()[[4]])

