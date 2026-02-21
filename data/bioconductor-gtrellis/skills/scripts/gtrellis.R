# Code example from 'gtrellis' vignette. See references/ for full tutorial.

## ----echo = FALSE, message = FALSE----------------------------------------------------------------
library(markdown)
options(markdown.HTML.options = c(options('markdown.HTML.options')[[1]], "toc"))

library(knitr)
knitr::opts_chunk$set(
    error = FALSE,
    tidy  = FALSE,
    message = FALSE,
    fig.align = "center")
options(markdown.HTML.stylesheet = "custom.css")

options(width = 100)
library(ComplexHeatmap)

## ----fig.width = 10, fig.height = 6---------------------------------------------------------------
library(gtrellis)
gtrellis_layout()

## ----fig.width = 6, fig.height = 6----------------------------------------------------------------
gtrellis_layout(category = c("chr3", "chr1"))
gtrellis_show_index()

## ----fig.width = 10, fig.height = 6---------------------------------------------------------------
gtrellis_layout(species = "mm10")
gtrellis_show_index()

## ----fig.width = 8, fig.height = 8----------------------------------------------------------------
gtrellis_layout(nrow = 3)
gtrellis_show_index()
gtrellis_layout(ncol = 5)
gtrellis_show_index()

## ----fig.width = 8, fig.height = 8----------------------------------------------------------------
gtrellis_layout(ncol = 5, byrow = FALSE)
gtrellis_show_index()

## ----fig.width = 10, fig.height = 6---------------------------------------------------------------
gtrellis_layout(equal_width = TRUE)
gtrellis_show_index()

## ----fig.width = 8, fig.height = 8----------------------------------------------------------------
gtrellis_layout(ncol = 5, byrow = FALSE, equal_width = TRUE)
gtrellis_show_index()

## ----fig.width = 10, fig.height = 8---------------------------------------------------------------
gtrellis_layout(nrow = 3, compact = TRUE)
gtrellis_show_index()

## ----fig.width = 10, fig.height = 6---------------------------------------------------------------
gtrellis_layout(gap = 0)

## ----fig.width = 10, fig.height = 6---------------------------------------------------------------
gtrellis_layout(gap = unit(5, "mm"))

## ----fig.width = 8, fig.height = 8----------------------------------------------------------------
gtrellis_layout(ncol = 5, gap = unit(c(5, 2), "mm"))

## ----fig.width = 10, fig.height = 6---------------------------------------------------------------
gtrellis_layout(n_track = 3)
gtrellis_show_index()

## ----fig.width = 10, fig.height = 6---------------------------------------------------------------
gtrellis_layout(n_track = 3, track_height = c(1, 2, 3))

## ----fig.width = 10, fig.height = 6---------------------------------------------------------------
gtrellis_layout(n_track = 3, 
    track_height = unit.c(unit(1, "cm"), unit(1, "null"), grobHeight(textGrob("chr1"))))

## ----fig.width = 10, fig.height = 6---------------------------------------------------------------
gtrellis_layout(n_track = 3, track_axis = c(FALSE, TRUE, FALSE), xaxis = FALSE, xlab = "")

## ----fig.width = 10, fig.height = 6---------------------------------------------------------------
gtrellis_layout(n_track = 3, track_ylim = c(0, 3, -4, 4, 0, 1000000))

## ----fig.width = 10, fig.height = 6---------------------------------------------------------------
gtrellis_layout(n_track = 3, track_ylim = c(0, 3, -4, 4, 0, 1000000), asist_ticks = FALSE)

## ----fig.width = 10, fig.height = 6---------------------------------------------------------------
gtrellis_layout(n_track = 3, title = "title", track_ylab = c("", "bbbbbb", "ccccccc"), xlab = "xlab")

## ----fig.width = 8, fig.height = 10---------------------------------------------------------------
gtrellis_layout(n_track = 3, ncol = 4)
gtrellis_show_index()

## ----fig.width = 8, fig.height = 10---------------------------------------------------------------
gtrellis_layout(n_track = 3, ncol = 4, border = FALSE, xaxis = FALSE, track_axis = FALSE, xlab = "")
gtrellis_show_index()

## ----fig.width = 10, fig.height = 6---------------------------------------------------------------
library(circlize)
bed = generateRandomBed()
gtrellis_layout(track_ylim = range(bed[[4]]), nrow = 3, byrow = FALSE)
add_points_track(bed, bed[[4]], gp = gpar(col = ifelse(bed[[4]] > 0, "red", "green")))

## ----fig.width = 10, fig.height = 6---------------------------------------------------------------
bed = generateRandomBed(nr = 100)
gtrellis_layout(track_ylim = range(bed[[4]]), nrow = 3, byrow = FALSE)
add_segments_track(bed, bed[[4]], gp = gpar(col = ifelse(bed[[4]] > 0, "red", "green"), lwd = 4))

## ----fig.width = 10, fig.height = 6---------------------------------------------------------------
bed = generateRandomBed(200)
gtrellis_layout(n_track = 2, track_ylim = rep(range(bed[[4]]), 2), nrow = 3, byrow = FALSE)
add_lines_track(bed, bed[[4]])
add_lines_track(bed, bed[[4]], area = TRUE, gp = gpar(fill = "grey", col = NA))

## ----fig.width = 10, fig.height = 6---------------------------------------------------------------
col_fun = colorRamp2(c(-1, 0, 1), c("green", "black", "red"))
gtrellis_layout(track_ylim = range(bed[[4]]), nrow = 3, byrow = FALSE)
add_rect_track(bed, h1 = bed[[4]], h2 = 0, 
    gp = gpar(col = NA, fill = col_fun(bed[[4]])))

## ----fig.width = 10, fig.height = 6---------------------------------------------------------------
gtrellis_layout(nrow = 3, byrow = FALSE, track_axis = FALSE)
mat = matrix(rnorm(nrow(bed)*4), ncol = 4)
add_heatmap_track(bed, mat, fill = col_fun)

## ----fig.width = 10, fig.height = 6---------------------------------------------------------------
col_fun = colorRamp2(c(-1, 0, 1), c("green", "black", "red"))
gtrellis_layout(track_ylim = range(bed[[4]]), nrow = 3, byrow = FALSE)
add_rect_track(bed, h1 = bed[[4]], h2 = 0, gp = gpar(col = NA, fill = col_fun(bed[[4]])))
add_lines_track(bed, bed[[4]], track = current_track())
add_points_track(bed, bed[[4]], track = current_track(), size = unit(abs(bed[[4]])*5, "mm"))

## ----fig.width = 10, fig.height = 6---------------------------------------------------------------
bed = generateRandomBed()
gtrellis_layout(track_ylim = range(bed[[4]]))
add_track(bed, panel_fun = function(bed) {
    # `bed` inside `panel_fun` is a subset of the main `bed`
    x = (bed[[2]] + bed[[3]]) / 2
    y = bed[[4]]
    grid.points(x, y, pch = 16, size = unit(1, "mm"))
})

## ----fig.width = 10, fig.height = 6, message = FALSE----------------------------------------------
gr = GRanges(seqnames = bed[[1]],
             ranges = IRanges(start = bed[[2]],
                               end = bed[[3]]),
             score = bed[[4]])
gtrellis_layout(track_ylim = range(gr$score))
add_track(gr, panel_fun = function(gr) {
    x = (start(gr) + end(gr)) / 2
    y = gr$score
    grid.points(x, y, pch = 16, size = unit(1, "mm"))
})

## ----fig.width = 8, fig.height = 8----------------------------------------------------------------
gtrellis_layout(nrow = 5, byrow = FALSE, track_ylim = range(bed[[4]]))
add_track(bed, panel_fun = function(bed) {
    x = (bed[[2]] + bed[[3]]) / 2
    y = bed[[4]]
    grid.points(x, y, pch = 16, size = unit(1, "mm"))
})

## ----fig.width = 8, fig.height = 12---------------------------------------------------------------
load(system.file("extdata", "DMR.RData", package = "circlize"))
DMR_hyper_density = circlize::genomicDensity(DMR_hyper, window.size = 1e7)
head(DMR_hyper_density)

## ----fig.width = 10, fig.height = 12--------------------------------------------------------------
gtrellis_layout(n_track = 4, ncol = 4, byrow = FALSE,
    track_axis = c(FALSE, TRUE, TRUE, FALSE), 
    track_height = unit.c(2*grobHeight(textGrob("chr1")), 
                          unit(1, "null"), 
                          unit(0.5, "null"), 
                          unit(3, "mm")), 
    track_ylim = c(0, 1, 0, 8, c(0, max(DMR_hyper_density[[4]])), 0, 1),
    track_ylab = c("", "log10(inter_dist)", "density", ""))

# track for chromosome names
add_track(panel_fun = function(gr) {
    # the use of `get_cell_meta_data()` will be introduced later
    chr = get_cell_meta_data("name")  
    grid.rect(gp = gpar(fill = "#EEEEEE"))
    grid.text(chr)
})

# track for rainfall plots
DMR_hyper_rainfall = circlize::rainfallTransform(DMR_hyper)
add_points_track(DMR_hyper_rainfall, log10(DMR_hyper_rainfall[[4]]),
  pch = 16, size = unit(1, "mm"), gp = gpar(col = "red"))

# track for genomic density
add_lines_track(DMR_hyper_density, DMR_hyper_density[[4]], area = TRUE, 
  gp = gpar(fill = "pink"))

# track for ideogram
cytoband_df = circlize::read.cytoband(species = "hg19")$df
add_track(cytoband_df, panel_fun = function(gr) {
    cytoband_chr = gr
    grid.rect(cytoband_chr[[2]], unit(0, "npc"),
              width = cytoband_chr[[3]] - cytoband_chr[[2]], height = unit(1, "npc"),
              default.units = "native", hjust = 0, vjust = 0,
              gp = gpar(fill = circlize::cytoband.col(cytoband_chr[[5]])))
    grid.rect(min(cytoband_chr[[2]]), unit(0, "npc"),
              width = max(cytoband_chr[[3]]) - min(cytoband_chr[[2]]), height = unit(1, "npc"),
              default.units = "native", hjust = 0, vjust = 0,
              gp = gpar(fill = "transparent"))
})

## ----fig.width = 10, fig.height = 12--------------------------------------------------------------
DMR_hypo_density = circlize::genomicDensity(DMR_hypo, window.size = 1e7)
DMR_hypo_rainfall = circlize::rainfallTransform(DMR_hypo)

gtrellis_layout(n_track = 2, ncol = 4, byrow = FALSE,
    track_axis = TRUE, 
    track_height = unit.c(unit(1, "null"), 
                          unit(0.5, "null")), 
    track_ylim = c(0, 8, c(0, max(c(DMR_hyper_density[[4]], DMR_hypo_density[[4]])))),
    track_ylab = c("log10(inter_dist)", "density"),
    add_name_track = TRUE, add_ideogram_track = TRUE)

# put into a function and we will use it later
add_graphics = function() {
    add_points_track(DMR_hyper_rainfall, log10(DMR_hyper_rainfall[[4]]),
        pch = 16, size = unit(1, "mm"), gp = gpar(col = "#FF000080"))
    add_points_track(DMR_hypo_rainfall, log10(DMR_hypo_rainfall[[4]]), track = current_track(),
        pch = 16, size = unit(1, "mm"), gp = gpar(col = "#0000FF80"))

    # track for genomic density
    add_lines_track(DMR_hyper_density, DMR_hyper_density[[4]], area = TRUE, 
        gp = gpar(fill = "#FF000080"))
    add_lines_track(DMR_hypo_density, DMR_hypo_density[[4]], area = TRUE, track = current_track(),
        gp = gpar(fill = "#0000FF80"))
}

add_graphics()

## ----fig.width = 14, fig.height = 10--------------------------------------------------------------
gtrellis_layout(n_track = 2, nrow = 4, compact = TRUE,
    track_axis = TRUE, 
    track_height = unit.c(unit(1, "null"), 
                          unit(0.5, "null")), 
    track_ylim = c(0, 8, c(0, max(c(DMR_hyper_density[[4]], DMR_hypo_density[[4]])))),
    track_ylab = c("log10(inter_dist)", "density"),
    add_name_track = TRUE, add_ideogram_track = TRUE)
add_graphics()

## ----fig.width = 8, fig.height = 8----------------------------------------------------------------
all_chr = paste0("chr", 1:22)
letter = strsplit("MERRY CHRISTMAS!", "")[[1]]
gtrellis_layout(nrow = 5)
for(i in seq_along(letter)) {
    add_track(category = all_chr[i], track = 1, panel_fun = function(gr) {
        grid.text(letter[i], gp = gpar(fontsize = 30))
    })
}

## -------------------------------------------------------------------------------------------------
tumor_df = readRDS(system.file("extdata", "df_tumor.rds", package = "gtrellis"))
control_df = readRDS(system.file("extdata", "df_control.rds", package = "gtrellis"))

# remove regions that have zero coverage
ind = which(tumor_df$cov > 0 & control_df$cov > 0)
tumor_df = tumor_df[ind, , drop = FALSE]
control_df = control_df[ind, , drop = FALSE]
ratio_df = tumor_df

# get rid of small value dividing small value resulting large value
q01 = quantile(c(tumor_df$cov, control_df$cov), 0.01)
ratio_df[[4]] = log2( (tumor_df$cov+q01) / (control_df$cov+q01) * 
                       sum(control_df$cov) / sum(tumor_df$cov) )
names(ratio_df) = c("chr", "start", "end", "ratio")
tumor_df[[4]] = log10(tumor_df[[4]])
control_df[[4]] = log10(control_df[[4]])

## ----fig.width = 10, fig.height = 8---------------------------------------------------------------
cov_range = range(c(tumor_df[[4]], control_df[[4]]))
ratio_range = range(ratio_df[[4]])
ratio_range = c(-max(abs(ratio_range)), max(abs(ratio_range)))

gtrellis_layout(n_track = 3, nrow = 3, byrow = FALSE, gap = unit(c(4, 1), "mm"),
    track_ylim = c(cov_range, cov_range, ratio_range),
    track_ylab = c("tumor, log10(cov)", "control, log10(cov)", "ratio, log2(ratio)"), 
    add_name_track = TRUE, add_ideogram_track = TRUE)

# track for coverage in tumor
add_points_track(tumor_df, tumor_df[[4]], pch = 16, size = unit(2, "bigpts"), 
    gp = gpar(col = "#00000020"))
add_points_track(control_df, tumor_df[[4]], pch = 16, size = unit(2, "bigpts"), 
    gp = gpar(col = "#00000020"))

# track for ratio between tumor and control
library(RColorBrewer)
col_fun = circlize::colorRamp2(seq(-0.5, 0.5, length = 11), rev(brewer.pal(11, "RdYlBu")),
    transparency = 0.5)
add_track(ratio_df, panel_fun = function(gr) {
    x = (gr[[2]] + gr[[3]])/2
    y = gr[[4]]
    grid.lines(unit(c(0, 1), "npc"), unit(c(0, 0), "native"), gp = gpar(col = "#0000FF80", lty = 2))
    grid.points(x, y, pch = 16, size = unit(2, "bigpts"), gp = gpar(col = col_fun(y)))
})

## ----fig.width = 10, fig.height = 8---------------------------------------------------------------
gene = readRDS(system.file("extdata", "gencode_v19_protein_coding_genes.rds", package = "gtrellis"))
gene_density = genomicDensity(gene)

gtrellis_layout(byrow = FALSE, n_track = 2, ncol = 4, 
    add_ideogram_track = TRUE, add_name_track = TRUE,
    track_ylim = c(0, max(gene_density[[4]]), 0, 1), track_axis = c(TRUE, FALSE),
    track_height = unit.c(unit(1, "null"), unit(4, "mm")),
    track_ylab = c("density", ""))

add_lines_track(gene_density, gene_density[[4]])

col_fun = circlize::colorRamp2(seq(0, max(gene_density[[4]]), length = 11), 
                               rev(brewer.pal(11, "RdYlBu")))
add_heatmap_track(gene_density, gene_density[[4]], fill = col_fun)

## -------------------------------------------------------------------------------------------------
load(system.file("extdata", "gwasCatalog.RData", package = "gtrellis"))
head(gwas)
v = -log10(gwas[, "p-value"])
# remove outliers
q95 = quantile(v, 0.95)
v[v > q95] = q95

## ----fig.width = 14, fig.height = 6---------------------------------------------------------------
library(gtrellis)
gtrellis_layout(category = paste0("chr", 1:22), track_ylim = range(v), track_ylab = "-log10(p)")
add_points_track(gwas, v, gp = gpar(col = "#00000080"))

## ----fig.width = 14, fig.height = 10--------------------------------------------------------------
library(circlize)
# how many SNPs in every 5MB window
d = genomicDensity(gwas, 5e6)
d[, 4] = d[, 4] * 5e6

gtrellis_layout(nrow = 4, byrow = FALSE, n_track = 2, category = paste0("chr", 1:22),
  add_ideogram_track = TRUE, add_name_track=TRUE, track_ylim = c(range(v), range(d[, 4])),
  track_height = c(2, 1), track_ylab = c("-log10(p)", "#SNP"))
add_points_track(gwas, v, gp = gpar(col = "#00000080"))
add_lines_track(d, d[, 4], area = TRUE, gp = gpar(fill = "#999999", col = NA))

## ----fig.width = 8, fig.height = 8----------------------------------------------------------------
bed = generateRandomBed(nr = 10000)
bed = bed[sample(10000, 100), ]
col_fun = colorRamp2(c(-1, 0, 1), c("green", "yellow", "red"))

gtrellis_layout(n_track = 1, ncol = 1, track_axis = FALSE, xpadding = c(0.1, 0),
    gap = unit(4, "mm"), border = FALSE, asist_ticks = FALSE, add_ideogram_track = TRUE, 
    ideogram_track_height = unit(2, "mm"))
add_track(bed, panel_fun = function(gr) {
    grid.rect((gr[[2]] + gr[[3]])/2, unit(0.2, "npc"), unit(1, "mm"), unit(0.8, "npc"), 
        hjust = 0, vjust = 0, default.units = "native", 
        gp = gpar(fill = col_fun(gr[[4]]), col = NA))    
})
add_track(track = 2, clip = FALSE, panel_fun = function(gr) {
    chr = get_cell_meta_data("name")
    if(chr == "chrY") {
        grid.lines(get_cell_meta_data("xlim"), unit(c(0, 0), "npc"), 
            default.units = "native")
    }
    grid.text(chr, x = 0, y = 0, just = c("left", "bottom"))
})

## ----eval = FALSE---------------------------------------------------------------------------------
# gtrellis_layout()
# add_track(panel_fun = function(gr) {
#     # get xlim of current cell
#     xlim = get_cell_meta_data("xlim")
# })
# 
# # get xlim of the specified cell
# xlim = get_cell_meta_data("xlim", category = "chr2", track = 1)

## ----echo = FALSE, fig.width = 8, fig.height = 8--------------------------------------------------
library(GetoptLong)
gtrellis_layout(category = c("chr1", "chr2", "chr21", "chr22"), equal_width = TRUE, add_name_track = TRUE, add_ideogram_track = TRUE, nrow = 2,
  xpadding = c(0.1, 0.1), ypadding = c(0.1, 0.1))

add_track(panel_fun = function(gr) {
    xlim = get_cell_meta_data("xlim")
    ylim = get_cell_meta_data("ylim")
    extended_xlim = get_cell_meta_data("extended_xlim")
    extended_ylim = get_cell_meta_data("extended_ylim")
    original_xlim = get_cell_meta_data("original_xlim")
    original_ylim = get_cell_meta_data("original_ylim")

    grid.rect(xlim[1], ylim[1], width = xlim[2] - xlim[1], height = ylim[2] - ylim[1], default.unit = "native", just = c(0, 0), gp = gpar(col = "#FF000080", fill = "transparent", lwd = 3))
    grid.rect(extended_xlim[1], extended_ylim[1], width = extended_xlim[2] - extended_xlim[1], height = extended_ylim[2] - extended_ylim[1], default.unit = "native", just = c(0, 0), gp = gpar(col = "#00FF0080", fill = "transparent", lwd = 3))
    grid.rect(original_xlim[1], original_ylim[1], width = original_xlim[2] - original_xlim[1], height = original_ylim[2] - original_ylim[1], default.unit = "native", just = c(0, 0), gp = gpar(col = "#0000FF80", fill = "transparent", lwd = 3))

    grid.text("xlim, ylim", xlim[2], ylim[1], default.unit = "native", just = c(1, 0), gp = gpar(col = "red"))
    grid.text("extended_xlim, extended_ylim", extended_xlim[1], extended_ylim[2], default.unit = "native", just = c(0, 1), gp = gpar(col = "green"))
    grid.text("original_xlim, original_ylim", original_xlim[1], original_ylim[2], default.unit = "native", just = c(0, 1), gp = gpar(col = "blue"))


    name = get_cell_meta_data("name")
    column = get_cell_meta_data("column")
    row = get_cell_meta_data("row")
    track = get_cell_meta_data("track")
    grid.text(qq("name = '@{name}'\ncolumn = @{column}\nrow = @{row}\ntrack = @{track}"), 0.5, 0.5)
})

## ----fig.width = 8, fig.height = 8----------------------------------------------------------------
library(ComplexHeatmap)
bed = generateRandomBed()
lgd = Legend(at = c("class1", "class2"), title = "Class", type = "points", legend_gp = gpar(col = 2:3))
gtrellis_layout(nrow = 5, byrow = FALSE, track_ylim = range(bed[[4]]), legend = lgd)
add_points_track(bed, bed[[4]], gp = gpar(col = sample(2:3, nrow(bed), replace = TRUE)))

## ----fig.width = 8, fig.height = 8----------------------------------------------------------------
library(ComplexHeatmap)

bed = generateRandomBed(nr = 10000)
bed = bed[sample(10000, 100), ]
col_fun = colorRamp2(c(-1, 0, 1), c("green", "yellow", "red"))
cm = ColorMapping(col_fun = col_fun)
lgd = color_mapping_legend(cm, plot = FALSE, title = "Value")

gtrellis_layout(n_track = 1, ncol = 1, track_axis = FALSE, xpadding = c(0.1, 0),
    gap = unit(4, "mm"), border = FALSE, asist_ticks = FALSE, add_ideogram_track = TRUE, 
    ideogram_track_height = unit(2, "mm"), legend = lgd)
add_track(bed, panel_fun = function(gr) {
    grid.rect((gr[[2]] + gr[[3]])/2, unit(0.2, "npc"), unit(1, "mm"), unit(0.8, "npc"), 
        hjust = 0, vjust = 0, default.units = "native", 
        gp = gpar(fill = col_fun(gr[[4]]), col = NA))    
})
add_track(track = 2, clip = FALSE, panel_fun = function(gr) {
    chr = get_cell_meta_data("name")
    if(chr == "chrY") {
        grid.lines(get_cell_meta_data("xlim"), unit(c(0, 0), "npc"), 
            default.units = "native")
    }
    grid.text(chr, x = 0, y = 0, just = c("left", "bottom"))
})

## ----fig.width = 10, fig.height = 5---------------------------------------------------------------
load(paste0(system.file(package = "circlize"), "/extdata/tp_family.RData"))
df = data.frame(gene = names(tp_family),
    start = sapply(tp_family, function(x) min(unlist(x))),
    end = sapply(tp_family, function(x) max(unlist(x))))
df
# maximum number of transcripts
n = max(sapply(tp_family, length))

gtrellis_layout(data = df, n_track = 1, track_ylim = c(0.5, n+0.5), 
    track_axis = FALSE, add_name_track = TRUE, xpadding = c(0.05, 0.05), ypadding = c(0.05, 0.05))

# put into a function so that we can use it repeatedly
add_tx = function() {
  add_track(panel_fun = function(gr) {
      gn = get_cell_meta_data("name")
      tr = tp_family[[gn]] # all transcripts for this gene
      for(i in seq_along(tr)) {
          # for each transcript
          current_tr_start = min(tr[[i]]$start)
          current_tr_end = max(tr[[i]]$end)
          grid.lines(c(current_tr_start, current_tr_end), c(n - i + 1, n - i + 1), 
              default.units = "native", gp = gpar(col = "#CCCCCC"))
          grid.rect(tr[[i]][[1]], n - i + 1, tr[[i]][[2]] - tr[[i]][[1]], 0.8,
              default.units = "native", just = "left", 
              gp = gpar(fill = "orange", col = "orange"))
      }
  })
}

add_tx()

## -------------------------------------------------------------------------------------------------
tp_family$TP53 = lapply(tp_family$TP53, function(df) {
        data.frame(start = abs(df[[2]] - 7590856),
                   end = abs(df[[1]] - 7590856))
    })
tp_family$TP63 = lapply(tp_family$TP63, function(df) {
        data.frame(start = abs(df[[1]] - 189349205),
                   end = abs(df[[2]] - 189349205))
    })
tp_family$TP73 = lapply(tp_family$TP73, function(df) {
        data.frame(start = abs(df[[1]] - 3569084),
                   end = abs(df[[2]] - 3569084))
    })

## ----fig.width = 8, fig.height = 6----------------------------------------------------------------
df = data.frame(gene = names(tp_family),
    start = sapply(tp_family, function(x) min(unlist(x))),
    end = sapply(tp_family, function(x) max(unlist(x))))
df
n = max(sapply(tp_family, length))
gtrellis_layout(data = df, n_track = 1, ncol = 1, track_ylim = c(0.5, n+0.5), 
    track_axis = FALSE, add_name_track = TRUE, 
    xpadding = c(0.01, 0.01), ypadding = c(0.05, 0.05))
add_tx()

## ----fig.width = 10, fig.height = 8---------------------------------------------------------------
col_fun = circlize::colorRamp2(seq(-0.5, 0.5, length = 11), rev(brewer.pal(11, "RdYlBu")),
    transparency = 0.5)
zoom = function(df) {
    gtrellis_layout(data = df, n_track = 3, nrow = 2,
    track_ylim = c(cov_range, cov_range, ratio_range),
    track_ylab = c("tumor, log10(cov)", "control, log10(cov)", "ratio, log2(ratio)"), 
    add_name_track = TRUE, add_ideogram_track = TRUE)
    
    add_points_track(tumor_df, tumor_df[[4]], pch = 16, size = unit(2, "bigpts"), 
        gp = gpar(col = "#00000080"))
    add_points_track(control_df, control_df[[4]], pch = 16, size = unit(2, "bigpts"), 
        gp = gpar(col = "#00000080"))
    add_points_track(ratio_df, ratio_df[[4]], pch = 16, size = unit(2, "bigpts"), 
        gp = gpar(col = col_fun(ratio_df[[4]])))
}

df = data.frame(chr = c("chr1", "chr2"),
                start = c(1e8, 1e8),
                end = c(2e8, 2e8))
zoom(df)

df = data.frame(chr = c("chr11", "chr12"),
                start = c(4e7, 4e7),
                end = c(8e7, 8e7))
zoom(df)

## ----message = TRUE, error = TRUE-----------------------------------------------------------------
try({
df = data.frame(chr = c("chr1", "chr2"),
                start = c(1e8, 2e8),
                end = c(2e8, 3e8))
gtrellis_layout(df, ncol = 1)
})

## -------------------------------------------------------------------------------------------------
bed = generateRandomBed()
gtrellis_layout(category = "chr1", n_track = 4, track_ylim = range(bed[[4]]))
add_track(bed, panel_fun = function(bed) {
    grid.points((bed[[2]] + bed[[3]]) / 2, bed[[4]], pch = 16, size = unit(2, "mm"))
})
add_track(bed, panel_fun = function(bed) {
    grid.points((bed[[2]] + bed[[3]]) / 2, bed[[4]], pch = 16, size = unit(2, "mm"))
}, use_raster = TRUE)
add_track(bed, panel_fun = function(bed) {
    grid.points((bed[[2]] + bed[[3]]) / 2, bed[[4]], pch = 16, size = unit(2, "mm"))
}, use_raster = TRUE, raster_quality = 2)
add_track(bed, panel_fun = function(bed) {
    grid.points((bed[[2]] + bed[[3]]) / 2, bed[[4]], pch = 16, size = unit(4, "mm"))
}, use_raster = TRUE, raster_quality = 2)

## -------------------------------------------------------------------------------------------------
sessionInfo()

