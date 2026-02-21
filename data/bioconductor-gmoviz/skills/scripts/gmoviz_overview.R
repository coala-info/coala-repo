# Code example from 'gmoviz_overview' vignette. See references/ for full tutorial.

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

## ----sectors-tracks-figure, echo=FALSE, fig.keep='high'-----------------------
example_insertion <- GRanges(seqnames = "chr12",
                      ranges = IRanges(start = 70905597, end = 70917885),
                      name = "plasmid", colour = "#7270ea", length = 12000,
                      in_tandem = 11, shape = "forward_arrow")
layout(matrix(c(1,2), nrow=1, ncol=2))
insertionDiagram(insertion_data = example_insertion, 
                 either_side = c(70855503, 71398284),
                 start_degree = 45, space_between_sectors = 20,
                 xaxis_spacing = 45)
highlight.sector("chr12", col = NA, border = "red", lwd = 1.5)
highlight.sector("plasmid", col = NA, border = "red", lwd = 1.5)

insertionDiagram(insertion_data = example_insertion, 
                 either_side = c(70855503, 71398284),
                 start_degree = 45, space_between_sectors = 20,
                 xaxis_spacing = 45)
draw.sector(start.degree = 0, end.degree = 360,
            0.99, 0.84, border = "blue", lwd = 1.5)
draw.sector(start.degree = 0, end.degree = 360,
            0.84, 0.69, border = "blue", lwd = 1.5)

## ----cnd-style1---------------------------------------------------------------
example_insertion <- GRanges(seqnames = "chr12",
                      ranges = IRanges(start = 70905597, end = 70917885),
                      name = "plasmid", colour = "#7270ea", length = 12000,
                      in_tandem = 11, shape = "forward_arrow")
insertionDiagram(insertion_data = example_insertion, 
                 space_between_sectors = 20, xaxis_spacing = 45)

## ----cnd-style2---------------------------------------------------------------
insertionDiagram(example_insertion, space_between_sectors = 20, style = 2)

## ----cnd-singleins-style34, fig.keep='high'-----------------------------------
single_copy_insertion <- GRanges(seqnames = "chr12",
                       ranges = IRanges(start = 70905597, end = 70917885),
                       name = "plasmid", length = 12000)
insertionDiagram(single_copy_insertion, space_between_sectors = 20, style = 3)
insertionDiagram(single_copy_insertion, space_between_sectors = 20, style = 4)

## ----cnd-multiple-------------------------------------------------------------
multi_insertions <- GRanges(seqnames = "chr12",
                       ranges = IRanges(start = 70910000, end = 70920000),
                       name = "plasmid2", length = 10000)
multiple_insertions <- c(single_copy_insertion, multi_insertions)

## plot it
insertionDiagram(multiple_insertions)

## ----cnd-labels, fig.height=8, fig.width=12-----------------------------------
nearby_genes <- GRanges(seqnames = c("chr12", "chr12"),
                        ranges = IRanges(start = c(70901000, 70911741),
                                         end = c(70910000, 70919000)),
                        label = c("Gene A", "Gene B"))
insertionDiagram(insertion_data = example_insertion, 
                 label_data = nearby_genes,
                 either_side = nearby_genes, 
                 space_between_sectors = 20,
                 xaxis_spacing = 75, # one x axis label per 75 degrees
                 label_size = 0.8, # smaller labels so they fit
                 track_height = 0.1) # smaller shapes so the labels fit

## ----cnd-coverage-------------------------------------------------------------
## simulated coverage
coverage <- GRanges(seqnames = rep("chr12", 400),
                    ranges = IRanges(start = seq(from = 70901000, 
                                                 to = 70918955, by = 45),
                                     end = seq(from = 70901045, 
                                               to = 70919000, by = 45)),
                    coverage = c(runif(210, 10, 15), rep(0, 190)))

## plot with coverage
insertionDiagram(insertion_data = example_insertion, 
                 coverage_data = coverage,
                 coverage_rectangle = "chr12",
                 either_side = nearby_genes, 
                 space_between_sectors = 20,
                 xaxis_spacing = 75) # one x axis label per 75 degrees

## ----either_side, fig.keep='high'---------------------------------------------
## default
insertionDiagram(example_insertion, start_degree = 45, 
                 space_between_sectors = 20)
## single number
insertionDiagram(example_insertion, either_side = 10000, start_degree = 45,
                 space_between_sectors = 20)
## vector length 2
insertionDiagram(example_insertion, either_side = c(70855503, 71398284),
start_degree = 45, space_between_sectors = 20)

## ----aobf_example, echo=FALSE-------------------------------------------------
ideogram_data <- GRanges(
  seqnames = paste0("chr", 1:6), 
  ranges = IRanges(start = rep(0, 6), end = rep(12000, 6)))
insertion_data <- GRanges(
  seqnames = c("chr1", "chr5"),
  ranges = IRanges(start = c(4000, 2000), end = c(4100, 2200)),
  name = c("ins1", "ins5"), length = c(100, 200))
multipleInsertionDiagram(insertion_data = insertion_data,
                         genome_ideogram_data = ideogram_data,
                         colour_set = rich_colours)

## ----aobf_basic---------------------------------------------------------------
ideogram_data <- GRanges(
  seqnames = paste0("chr", 1:6), 
  ranges = IRanges(start = rep(0, 6), end = rep(12000, 6)))
insertion_data <- GRanges(
  seqnames = c("chr1", "chr5"),
  ranges = IRanges(start = c(4000, 2000), end = c(4100, 2200)),
  name = c("ins1", "ins5"), length = c(100, 200))
multipleInsertionDiagram(insertion_data = insertion_data,
                         genome_ideogram_data = ideogram_data,
                         colour_set = rich_colours)

## ----aobf_coverage_labels-----------------------------------------------------
## example coverage and labels
example_coverage <- GRanges(
seqnames = c(rep("chr1", 100), rep("chr5", 100)),
ranges = IRanges(start = c(seq(3985, 4114, length.out = 100),
                           seq(1970, 2229, length.out = 100)),
                 end = c(seq(3986, 4115, length.out = 100),
                         seq(1971, 2230, length.out = 100))),
                 coverage = c(runif(100, 0, 25), runif(100, 0, 15)))

 example_labels <- GRanges(seqnames = c("chr1", "chr5"),
                           ranges = IRanges(start = c(4000, 2000),
                           end = c(4120, 2200)),
                           label = c("Gene A", "Gene B"),
                           colour = c("red", "blue"))

## plot with coverage and labels
multipleInsertionDiagram(insertion_data = insertion_data,
                         genome_ideogram_data = ideogram_data,
                         coverage_rectangle = c("chr1", "chr5"),
                         coverage_data = example_coverage,
                         label_data = example_labels, 
                         label_colour = example_labels$colour)

## ----aobf_single_val----------------------------------------------------------
multipleInsertionDiagram(insertion_data = insertion_data,
                         genome_ideogram_data = ideogram_data,
                         either_side = 1000, style = 2)

## ----aobf_es_GRanges----------------------------------------------------------
## it's even possible to use GRanges in this way
either_side_GRange <- GRanges("chr5", IRanges(1000, 3200))
multipleInsertionDiagram(insertion_data = insertion_data,
                         genome_ideogram_data = ideogram_data,
                         either_side = list("ins1" = 1000, 
                                            "ins5" = either_side_GRange),
                         style = c("ins1" = 2, "ins5" = 4))

## ----fdd-plasmid--------------------------------------------------------------
## the data
plasmid_ideogram <- GRanges("plasmid", IRanges(start = 0, end = 3000))
plasmid_features <- getFeatures(
  gff_file = system.file("extdata", "plasmid.gff3", package="gmoviz"),
  colour_by_type = FALSE, # colour by name rather than type of feature
  colours = rich_colours) # choose colours from rich_colours (see ?colourSets)

## the plot
## plot plasmid map with coverage
featureDiagram(plasmid_ideogram, plasmid_features, track_height = 0.17,
               label_track_height = 0.11, 
               space_between_sectors = 0, # continuous circle
               xaxis_spacing = 30, # x axis label every 30 degrees
               start_degree = 90) # start from 90 degrees (12 o'clock)

## ----plasmid-map-coverage-----------------------------------------------------
## make some simulated coverage data
coverage <- GRanges(seqnames = rep("plasmid", 200),
                    ranges = IRanges(start = seq(from = 0, to = 2985, by = 15),
                                     end = seq(from = 15, to = 3000, by = 15)),
                    coverage = c(runif(110, 10, 15), rep(0, 90)))
## plot plasmid map with coverage
featureDiagram(plasmid_ideogram, plasmid_features, track_height = 0.17,
               coverage_rectangle = "plasmid", # don't forget this!
               coverage_data = coverage, 
               label_track_height = 0.11, space_between_sectors = 0, 
               xaxis_spacing = 30, start_degree = 90)

## ----fdd-complex-construct-data-----------------------------------------------
## the data
complex_ideogram <- GRanges(seqnames = c("Gene X", "Template"),
                            ranges = IRanges(start = c(5000, 0), 
                                             end = c(6305, 3788)))
## exon label
exon_label <- GRanges("Gene X", IRanges(5500, 5960), label = "Exon 2")
  
## features
complex_features <- getFeatures(
  gff_file = system.file("extdata", "complex_insertion.gff3", 
                         package="gmoviz"),
  colours = rich_colours)

## ----fdd-complex-construct-plot, fig.height=8, fig.width=12-------------------
## make a few edits to the feature_data: 
complex_features$track[c(3,4)] <- 2 # cut sites on the next track in
complex_features$shape[c(3,4)] <- "upwards_triangle" # triangles 

## plot the diagram
featureDiagram(ideogram_data = complex_ideogram, 
               feature_data = complex_features, 
               label_data = exon_label, custom_sector_width = c(0.6, 0.4),
               sector_colours = c("#6fc194", "#84c6d6"),
               sector_border_colours = c("#599c77", "#84c6d6"),
               space_between_sectors = 25, start_degree = 184, 
               label_size = 1.1)

## ----fdd-link, fig.height=8, fig.width=12-------------------------------------
# link data
link <- data.frame(chr = c("Gene X", "Template"),
                   start = c(5600, 0),
                   end = c(5706, 3788))
featureDiagram(ideogram_data = complex_ideogram, 
               feature_data = complex_features, label_data = exon_label, 
               custom_sector_width = c(0.6, 0.4),
               sector_colours = c("#6fc194", "#84c6d6"),
               sector_border_colours = c("#599c77", "#84c6d6"),
               space_between_sectors = 25, start_degree = 184, 
               label_size = 1.1, link_data = link)

## ----gmoviz_session_info, echo = FALSE----------------------------------------
sessionInfo()

