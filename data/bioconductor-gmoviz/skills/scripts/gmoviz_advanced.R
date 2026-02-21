# Code example from 'gmoviz_advanced' vignette. See references/ for full tutorial.

## ----setup, include = FALSE---------------------------------------------------
library(gmoviz)
library(BiocStyle)
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)
library(knitr)
knitr::opts_chunk$set(fig.width=8, fig.height=5.33, fig.keep='last',
                      message = FALSE, warning = FALSE, dev='jpeg', dpi=150)
opts_knit$set(global.par = TRUE)

## ----set_par, include=FALSE---------------------------------------------------
par(xpd=NA, mar=c(3.1, 2.1, 3.1, 2.1))

## ----get-pasilla-bams---------------------------------------------------------
if (!require("pasillaBamSubset")) {
    if (!require("BiocManager"))
        install.packages("BiocManager")
    BiocManager::install("GenomicAlignments")
}
library(pasillaBamSubset)

## ----two-types-of-ideo--------------------------------------------------------
ideogram_1 <- GRanges(seqnames = c("chrA", "chrB", "chrC"),
                 ranges = IRanges(start = rep(0, 3), end = rep(1000, 3)))
ideogram_2 <- data.frame(chr = c("chrA", "chrB", "chrC"), 
                    start = rep(0, 3),
                    end = rep(1000, 3))
print(ideogram_1)
print(ideogram_2)

## ----getIdeogramData----------------------------------------------------------
## from a .bam file
fly_ideogram <- getIdeogramData(bam_file = pasillaBamSubset::untreated3_chr4())

## from a single .fasta file
fly_ideogram_chr4_only <- getIdeogramData(
  fasta_file = pasillaBamSubset::dm3_chr4())

## ----getIdeogramData_wanted_chr-----------------------------------------------
getIdeogramData(bam_file = pasillaBamSubset::untreated3_chr4(),
                wanted_chr = "chr4")

## ----getIdeogramData_unwanted_chr---------------------------------------------
getIdeogramData(bam_file = pasillaBamSubset::untreated3_chr4(),
                unwanted_chr = "chrM")

## ----getIdeogramData_just_pattern---------------------------------------------
getIdeogramData(bam_file = pasillaBamSubset::untreated3_chr4(),
                just_pattern = "R$")

## ----gmovizInitialise, fig.width=6, fig.height=4------------------------------
gmovizInitialise(fly_ideogram_chr4_only, track_height = 0.15)

## ----gmovizInitialise-pretty, fig.width=6, fig.height=4-----------------------
gmovizInitialise(fly_ideogram_chr4_only, 
                 space_between_sectors = 25, # bigger space between start & end 
                 start_degree = 78, # rotate the circle
                 sector_label_size = 1, # bigger label
                 track_height = 0.15, # thicker rectangle
                 xaxis_spacing = 30) # label every 30 degrees on the x axis

## ----getCoverage--------------------------------------------------------------
chr4_coverage <- getCoverage(
  regions_of_interest = "chr4", 
  bam_file = pasillaBamSubset::untreated3_chr4(),
  window_size = 350, smoothing_window_size = 400)

## ----gmovizInitialise-covRect-------------------------------------------------
gmovizInitialise(ideogram_data = fly_ideogram_chr4_only, 
                 coverage_rectangle = "chr4", 
                 coverage_data = chr4_coverage,
                 xaxis_spacing = 30) 

## ----getCoverage-window_size, eval = FALSE------------------------------------
# # default window size (per base coverage)
# system.time({getCoverage(regions_of_interest = "chr4",
#                          bam_file = pasillaBamSubset::untreated3_chr4())})
# 
# # window size 100
# system.time({getCoverage(regions_of_interest = "chr4",
#                          bam_file = pasillaBamSubset::untreated3_chr4(),
#                          window_size = 100)})
# 
# # window size 500
# system.time({getCoverage(regions_of_interest = "chr4",
#                          bam_file = pasillaBamSubset::untreated3_chr4(),
#                          window_size = 500)})
# 
# 

## ----smoothing-windowing------------------------------------------------------
# without smoothing
chr4_region <- GRanges("chr4", IRanges(70000, 72000))
chr4_region_coverage <- getCoverage(regions_of_interest = chr4_region,
                          bam_file = pasillaBamSubset::untreated3_chr4())
gmovizInitialise(ideogram_data = chr4_region, coverage_rectangle = "chr4", 
                 coverage_data = chr4_region_coverage, custom_ylim = c(0,4))

# with moderate smoothing 
chr4_region_coverage <- getCoverage(regions_of_interest = chr4_region,
                          bam_file = pasillaBamSubset::untreated3_chr4(),
                          smoothing_window_size = 10)
gmovizInitialise(ideogram_data = chr4_region, coverage_rectangle = "chr4", 
                 coverage_data = chr4_region_coverage, custom_ylim = c(0,4))

# with strong smoothing
chr4_region_coverage <- getCoverage(regions_of_interest = chr4_region,
                          bam_file = pasillaBamSubset::untreated3_chr4(),
                          smoothing_window_size = 75)
gmovizInitialise(ideogram_data = chr4_region, coverage_rectangle = "chr4", 
                 coverage_data = chr4_region_coverage, custom_ylim = c(0,4))

## ----gmovizInitialise-labels--------------------------------------------------
label <- GRanges(seqnames = "chr4", 
                 ranges = IRanges(start = 240000, end = 280000),
                 label = "region A")
gmovizInitialise(fly_ideogram_chr4_only, label_data = label, 
                 space_between_sectors = 25, start_degree = 78, 
                 sector_label_size = 1, xaxis_spacing = 30)

## ----labels_from_gff----------------------------------------------------------
labels_from_file <- getLabels(
  gff_file = system.file("extdata", "example.gff3", package = "gmoviz"),
  colour_code = TRUE)
gmovizInitialise(fly_ideogram_chr4_only, 
                 label_data = labels_from_file, 
                 label_colour = labels_from_file$colour,
                 space_between_sectors = 25, start_degree = 78, 
                 sector_label_size = 1, xaxis_spacing = 30)  

## ----zooming_ideo-------------------------------------------------------------
fly_ideogram <- getIdeogramData(bam_file = pasillaBamSubset::untreated3_chr4(),
                                unwanted_chr = "chrM")
gmovizInitialise(fly_ideogram)

## ----gmovizInitialise-custom_sector_width-------------------------------------
gmovizInitialise(fly_ideogram, 
                 custom_sector_width = c(0.2, 0.2, 0.2, 0.2, 0.2, 0.1, 0.1))

## ----gmovizInitialise-zooming-after-------------------------------------------
gmovizInitialise(fly_ideogram, zoom_sectors = c("chr4", "chrYHet"),
                 zoom_prefix = "z_")

## ----getFeatures--------------------------------------------------------------
features <- getFeatures(
  gff_file = system.file("extdata", "example.gff3", package = "gmoviz"), 
  colours = gmoviz::rich_colours)

## ----drawFeatureTrack---------------------------------------------------------
## remember to initialise first
gmovizInitialise(fly_ideogram_chr4_only, space_between_sectors = 25, 
                 start_degree = 78, xaxis_spacing = 30, sector_label_size = 1)
drawFeatureTrack(features, feature_label_cutoff = 80000, track_height = 0.18)

## ----feature_label_cutoff-----------------------------------------------------
## the data
plasmid_ideogram <- GRanges("plasmid", IRanges(start = 0, end = 3000))
plasmid_features <- getFeatures(
  gff_file = system.file("extdata", "plasmid.gff3", package="gmoviz"),
  colour_by_type = FALSE, # colour by name rather than type of feature
  colours = gmoviz::rich_colours) # choose colours from rich_colours (see ?colourSets)

## the plot
featureDiagram(plasmid_ideogram, plasmid_features, track_height = 0.17)

## ----change_label_cutoff------------------------------------------------------
## smallest label cutoff
featureDiagram(plasmid_ideogram, plasmid_features, track_height = 0.17,
               feature_label_cutoff = 1)

## ----numeric_data-------------------------------------------------------------
numeric_data <- GRanges(seqnames = rep("chr4", 50),
                       ranges = IRanges(start = sample(0:1320000, 50),
                                        width = 1),
                       value = runif(50, 0, 25))

## ----numeric_data_plots-------------------------------------------------------
## remember to initialise first
gmovizInitialise(fly_ideogram_chr4_only, 
                 space_between_sectors = 25, start_degree = 78, 
                 sector_label_size = 1, xaxis_spacing = 30)
## scatterplot
drawScatterplotTrack(numeric_data)

## line graph
drawLinegraphTrack(sort(numeric_data), gridline_colour = NULL)

## ----numeric_data_with_features, fig.height=8, fig.width=12-------------------
gmovizInitialise(fly_ideogram_chr4_only, space_between_sectors = 25, 
                 start_degree = 78, xaxis_spacing = 30, sector_label_size = 1)
drawScatterplotTrack(numeric_data, track_height = 0.14, yaxis_increment = 12)
drawFeatureTrack(features, feature_label_cutoff = 80000, track_height = 0.15)

## ----makeLegends--------------------------------------------------------------
legend <- makeLegends(
    feature_legend = TRUE, feature_data = features, 
    feature_legend_title = "Regions of interest", scatterplot_legend = TRUE,
    scatterplot_legend_title = "Numeric data", 
    scatterplot_legend_labels = "value")

## ----gmovizPlot---------------------------------------------------------------
gmovizPlot(file_name = "example.svg", file_type = "svg", 
           plotting_functions = {
    gmovizInitialise(
        fly_ideogram_chr4_only, space_between_sectors = 25, start_degree = 78,
        xaxis_spacing = 30, sector_label_size = 1)
    drawScatterplotTrack(
        numeric_data, track_height = 0.14, yaxis_increment = 12)
    drawFeatureTrack(
        features, feature_label_cutoff = 80000, track_height = 0.15)
}, legends = legend, title = "Chromosome 4", background_colour = "white",
width = 8, height = 5.33, units = "in")

## ----circlize_annotation------------------------------------------------------
## the data
example_insertion <- GRanges(seqnames = "chr12",
                      ranges = IRanges(start = 70905597, end = 70917885),
                      name = "plasmid", colour = "#7270ea", length = 12000,
                      in_tandem = 11, shape = "forward_arrow")

## the original plot
insertionDiagram(example_insertion, either_side = c(70855503, 71398284),
                 start_degree = 45, space_between_sectors = 20)

## annotate with text
circos.text(x = 81000, y = 0.25, sector.index = "plasmid", track.index = 1, 
            facing = "bending.inside", labels = "(blah)", cex = 0.75)

## annotate with a box
circos.rect(xleft = 0, xright = 12000, ytop = 1, ybottom = 0, 
            track.index = 2, sector.index = "plasmid", border = "red")

## ----gmoviz_session_info, echo = FALSE----------------------------------------
sessionInfo()

