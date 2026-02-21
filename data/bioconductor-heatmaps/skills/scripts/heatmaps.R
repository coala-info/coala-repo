# Code example from 'heatmaps' vignette. See references/ for full tutorial.

## ----load_heatmaps, message=FALSE, warning=FALSE------------------------------
library(heatmaps)

## ----data_1, message=FALSE, warning=FALSE-------------------------------------
library(rtracklayer)
library(GenomicRanges)
library(BSgenome.Drerio.UCSC.danRer7)

heatmaps_file = function(fn) system.file("extdata", fn, package="heatmaps")

zf_30p_promoters = import(heatmaps_file("30pEpi_proms.bed"), genome=seqinfo(Drerio))

h3k4me3_30p_pos = readRDS(heatmaps_file("H3K4me3_30p_pos.rds"))
h3k4me3_30p_neg = readRDS(heatmaps_file("H3K4me3_30p_neg.rds"))
h3k4me3_30p = h3k4me3_30p_pos + h3k4me3_30p_neg

## ----coverage_heatmap---------------------------------------------------------
coords=c(-500, 500)

windows_30p = promoters(zf_30p_promoters, -coords[1], coords[2])
windows_30p = windows_30p[width(trim(windows_30p)) == 1000]
h3k4me3_30p_heatmap = CoverageHeatmap(
    windows_30p,
    h3k4me3_30p,
    coords=coords,
    label="H3K4me3 30p")


## ----plot_coverage_heatmap, fig.height=6, fig.width=3-------------------------
plotHeatmapList(h3k4me3_30p_heatmap, cex.label=1, color="Greens")

## ----plot_meta, fig.height=8, fig.width=8-------------------------------------
plotHeatmapMeta(h3k4me3_30p_heatmap)

## ----subtracted, fig.height=6, fig.width=4------------------------------------
h3k4me3_30p_subtracted = h3k4me3_30p_pos - h3k4me3_30p_neg

h3k4me3_30p_subtracted_hm = CoverageHeatmap(
    windows_30p,
    h3k4me3_30p_subtracted,
    coords=coords,
    label="Phase")

scale(h3k4me3_30p_subtracted_hm) = c(-150, 150)

plotHeatmapList(h3k4me3_30p_subtracted_hm, cex.label=1.5, color=c("red", "white", "blue"), legend=TRUE, legend.width=0.3)

## ----clustering, fig.height=6, fig.width=5------------------------------------
raw_matrix = image(h3k4me3_30p_subtracted_hm)
clusters = kmeans(raw_matrix, 2)$cluster

mat = raw_matrix[order(clusters),]

h3k4me3_30p_subtracted_kmeans = Heatmap(
  mat,
  coords=coords,
  label="kmeans",
  scale=c(-150, 150))

plotHeatmapList(h3k4me3_30p_subtracted_kmeans,
                cex.label=1.5,
                color=c("red", "white", "blue"),
                partition=c(sum(clusters==1), sum(clusters==2)),
                partition.legend=TRUE,
                partition.lines=TRUE,
                legend=TRUE,
                legend.pos="r",
                legend.width=0.3)


## ----get_seq------------------------------------------------------------------
seq_30p = getSeq(Drerio, windows_30p)

## ----pattern_heatmap, fig.height=6, fig.width=3-------------------------------
ta_30p = PatternHeatmap(seq_30p, "TA", coords=coords)
plotHeatmapList(ta_30p)

## ----smoothing, fig.height=6, fig.width=3-------------------------------------
ta_30p_smoothed = smoothHeatmap(ta_30p, output.size=c(250, 500), algorithm="kernel")
plotHeatmapList(ta_30p_smoothed)

## ----pwm_pattern_hm, warning=FALSE, fig.height=6, fig.width=3-----------------
example_data = new.env()
data(HeatmapExamples, envir=example_data)
tata_pwm = get("tata_pwm", example_data)

tata_pwm_30p = PatternHeatmap(seq_30p, tata_pwm, coords=coords, label="TATA", min.score="60%")
plotHeatmapList(smoothHeatmap(tata_pwm_30p, output.size=c(250, 500)))

## ----pwm_scan_hm, warning=FALSE, fig.height=6, fig.width=4--------------------
tata_pwm_scan_30p = PWMScanHeatmap(seq_30p, tata_pwm, coords=coords, label="TATA")
tata_pwm_scan_30p_smoothed = smoothHeatmap(tata_pwm_scan_30p, algorithm="blur", output.size=c(250, 500))
scale(tata_pwm_scan_30p_smoothed) = c(40, 60)
plotHeatmapList(tata_pwm_scan_30p_smoothed, color="Spectral", legend=TRUE, legend.width=0.3)

## ----lists, fig.height=6, fig.width=12----------------------------------------
cg_30p = PatternHeatmap(seq_30p, "CG", coords=coords)
cg_30p_smoothed = smoothHeatmap(cg_30p, output.size=c(250, 500))

hm_list = list(
    ta_30p_smoothed,
    cg_30p_smoothed,
    tata_pwm_scan_30p_smoothed,
    smoothHeatmap(h3k4me3_30p_heatmap, output.size=c(250, 500))
)

plotHeatmapList(hm_list,
                groups=c(1, 1, 2, 3),
                color=list("Blues", "Spectral", "Greens"),
                cex.label=list(2, 2, 1.25))

## ----plot_to_file, eval=FALSE-------------------------------------------------
# png("heatmap_list.png", height=20, width=40, units="cm", res="150")
# 
# plotHeatmapList(list(ta_30p_smoothed, cg_30p_smoothed, smoothHeatmap(h3k4me3_30p_heatmap), tata_pwm_scan_30p_smoothed),
#                 groups=c(1, 1, 2, 3),
#                 color=list("Blues", "Spectral", "Greens"),
#                 cex.label=list(1.25, 2, 2))
# 
# dev.off()

## ----complex_data-------------------------------------------------------------
zf_24h_promoters = import(heatmaps_file("24h_proms.bed"), genome=seqinfo(Drerio))
windows_24h = promoters(zf_24h_promoters, 500, 500)
windows_24h = windows_24h[width(trim(windows_24h)) == 1000]
seq_24h = getSeq(Drerio, windows_24h)
seq_30p = rev(seq_30p)
seq_24h = rev(seq_24h)

## ----complex_heatmaps, width=9, height=8, warning=FALSE-----------------------
SmoothPatternHM = function(seq, pattern, ...) {
    hm = PatternHeatmap(seq, pattern, ...)
    smoothHeatmap(hm, output.size=c(200, 200))
}

hm_list = list(
    ta_30p=SmoothPatternHM(seq_30p, "TA", coords=coords),
    cg_30p=SmoothPatternHM(seq_30p, "CG", coords=coords),
    ta_24h=SmoothPatternHM(seq_24h, "TA", coords=coords),
    cg_24h=SmoothPatternHM(seq_24h, "CG", coords=coords)
)


## ----complex_scale------------------------------------------------------------
scale = c(0, max(sapply(hm_list, scale)))
for(n in names(hm_list)) {
    scale(hm_list[[n]]) = scale
}


## ----complex_opts-------------------------------------------------------------
upperOpts = heatmapOptions(
    label.col="white",
    x.ticks=FALSE
)

lowerOpts = heatmapOptions(
    cex.axis=1.5
)


## ----complex margins----------------------------------------------------------
margins = list(
    topleft = c(0.1, 0.3, 1, 0.2),
    topright = c(0.1, 0.2, 1, 0.3),
    bottomleft = c(1, 0.3, 0.1, 0.2),
    bottomright = c(1, 0.2, 0.1, 0.3)
)


## ----complex_plot, fig.height=8, fig.width=9, fig.keep="last"-----------------
layout(matrix(c(1:3, 1, 4, 5), nrow=2, byrow=TRUE), width=c(0.25, 1, 1))

par(mai=c(3, 0.7, 3, 0.05))
plot_legend(scale, options=upperOpts)

par(mai=margins$topleft)
plotHeatmap(hm_list$ta_30p, options=upperOpts)
par(xpd=TRUE); points(470, 8480, pch=25, cex=2.5, lwd=2, bg="blue"); par(xpd=FALSE)

par(mai=margins$topright)
plotHeatmap(hm_list$ta_24h, options=upperOpts)
par(xpd=TRUE); points(550, 8480, pch=25, cex=2.5, lwd=2, bg="red"); par(xpd=FALSE)

par(mai=margins$bottomleft)
plotHeatmap(hm_list$cg_30p, options=lowerOpts)
mtext("Distance to maternal CTSS (bp)", side=1, line=3, cex=1.2)

par(mai=margins$bottomright)
plotHeatmap(hm_list$cg_24h, options=lowerOpts)
mtext("Distance to maternal CTSS (bp)", side=1, line=3, cex=1.2)
points(c(680, 860), c(7000, 7000), pch=8, lwd=3, cex=2.5)


