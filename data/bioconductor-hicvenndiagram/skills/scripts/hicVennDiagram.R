# Code example from 'hicVennDiagram' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", warning=FALSE--------------------------------
suppressPackageStartupMessages({
    library(hicVennDiagram)
    library(GenomicRanges)
    library(TxDb.Hsapiens.UCSC.hg38.knownGene)
})
knitr::opts_chunk$set(warning=FALSE, message=FALSE)

## ----installation, eval=FALSE-------------------------------------------------
# library(BiocManager)
# BiocManager::install("hicVennDiagram")

## ----load_library-------------------------------------------------------------
library(hicVennDiagram)
library(ggplot2)

## ----quick_start--------------------------------------------------------------
# list the BEDPE files
file_folder <- system.file("extdata",
                           package = "hicVennDiagram",
                           mustWork = TRUE)
file_list <- dir(file_folder, pattern = ".bedpe", full.names = TRUE)
names(file_list) <- sub(".bedpe", "", basename(file_list))
basename(file_list)
venn <- vennCount(file_list)
## upset plot
## temp fix for https://github.com/krassowski/complex-upset/pull/212
upset_themes_fix <- list(
    intersections_matrix=list(
      ggplot2::theme_minimal(),
      ggplot2::theme(
        # hide intersections
        axis.text.x=ggplot2::element_blank(),
        axis.ticks.x=ggplot2::element_blank(),
        # hide group title
        axis.title.y=ggplot2::element_blank()
      )
    ),
    'Intersection size'=list(
      ggplot2::theme_minimal(),
      ggplot2::theme(
        axis.text.x=ggplot2::element_blank(),
        axis.title.x=ggplot2::element_blank()
      )
    ),
    overall_sizes=list(
      ggplot2::theme_minimal(),
      ggplot2::theme(
        # hide groups
        axis.title.y=ggplot2::element_blank(),
        axis.text.y=ggplot2::element_blank(),
        axis.ticks.y=ggplot2::element_blank()
      )
    ),
    default=list(
      ggplot2::theme_minimal(),
      ggplot2::theme(
        axis.text.x=ggplot2::element_blank(),
        axis.title.x=ggplot2::element_blank()
      )
    )
  )
upsetPlot(venn, themes = upset_themes_fix)
## venn plot
vennPlot(venn)
## use browser to adjust the text position, and shape colors.
browseVenn(vennPlot(venn))

## ----vennCount----------------------------------------------------------------
venn <- vennCount(file_list, maxgap=50000, FUN = max) # by default FUN = min
upsetPlot(venn, label_all=list(
                          na.rm = TRUE,
                          color = 'black',
                          alpha = .9,
                          label.padding = unit(0.1, "lines")
                      ),
          themes = upset_themes_fix)

## ----chippeakanno_findOverlapsOfPeaks, warning=FALSE--------------------------
library(ChIPpeakAnno)
bed <- system.file("extdata", "MACS_output.bed", package="ChIPpeakAnno")
gr1 <- toGRanges(bed, format="BED", header=FALSE)
gff <- system.file("extdata", "GFF_peaks.gff", package="ChIPpeakAnno")
gr2 <- toGRanges(gff, format="GFF", header=FALSE, skip=3)
ol <- findOverlapsOfPeaks(gr1, gr2)
overlappingPeaksToVennTable <- function(.ele){
    .venn <- .ele$venn_cnt
    k <- which(colnames(.venn)=="Counts")
    rownames(.venn) <- apply(.venn[, seq.int(k-1)], 1, paste, collapse="")
    colnames(.venn) <- sub("count.", "", colnames(.venn))
    vennTable(combinations=.venn[, seq.int(k-1)],
              counts=.venn[, k],
              vennCounts=.venn[, seq.int(ncol(.venn))[-seq.int(k)]])
}
venn <- overlappingPeaksToVennTable(ol)
vennPlot(venn)
## or you can simply try vennPlot(vennCount(c(bed, gff)))
upsetPlot(venn, themes = upset_themes_fix)
## change the font size of labels and numbers
updated_theme <- list(
    intersections_matrix=list(
      ggplot2::theme_minimal(),
      ggplot2::theme(
        # hide intersections
        axis.text.x=ggplot2::element_blank(),
        axis.ticks.x=ggplot2::element_blank(),
        # hide group title
        axis.title.y=ggplot2::element_blank(),
        ## font size of label: gr1/gr2
        axis.text.y=ggplot2::element_text(size=24),
        ## font size of label `group`
        axis.title.x=ggplot2::element_text(size=24)
      )
    ),
    'Intersection size'=list(
      ggplot2::theme_minimal(),
      ggplot2::theme(
          ## font size of y-axis 0-150
          axis.text=ggplot2::element_text(size=20),
          ## font size of y-label `Intersection size`
          axis.title=ggplot2::element_text(size=16),
          axis.text.x=ggplot2::element_blank(),
          axis.title.x=ggplot2::element_blank()
      )
    ),
    overall_sizes=list(
      ggplot2::theme_minimal(),
      ggplot2::theme(
        ## font size of x-axis 0-200
        axis.text=ggplot2::element_text(size=12),
        ## font size of x-label `Set size`
        axis.title=ggplot2::element_text(size=18),
        # hide groups
        axis.title.y=ggplot2::element_blank(),
        axis.text.y=ggplot2::element_blank(),
        axis.ticks.y=ggplot2::element_blank()
      )
    ),
    default=list(
      ggplot2::theme_minimal(),
      ggplot2::theme(
        axis.text.x=ggplot2::element_blank(),
        axis.title.x=ggplot2::element_blank()
      )
    )
  )

# The following code will work after the merging of https://github.com/krassowski/complex-upset/pull/212
# updated_theme <- ComplexUpset::upset_modify_themes(
#               ## get help by vignette('Examples_R', package = 'ComplexUpset')
#               list('intersections_matrix'=
#                        ggplot2::theme(
#                            ## font size of label: gr1/gr2
#                            axis.text.y=ggplot2::element_text(size=24),
#                            ## font size of label `group`
#                            axis.title.x=ggplot2::element_text(size=24)),
#                    'overall_sizes'=
#                        ggplot2::theme(
#                            ## font size of x-axis 0-200
#                            axis.text=ggplot2::element_text(size=12),
#                            ## font size of x-label `Set size`
#                            axis.title=ggplot2::element_text(size=18)),
#                    'Intersection size'=
#                        ggplot2::theme(
#                            ## font size of y-axis 0-150
#                            axis.text=ggplot2::element_text(size=20),
#                            ## font size of y-label `Intersection size`
#                            axis.title=ggplot2::element_text(size=16)
#                        ),
#                    'default'=ggplot2::theme_minimal())
#               )
# updated_theme <- lapply(updated_theme, function(.ele){
#     lapply(.ele, function(.e){
#         do.call(theme, .e[names(.e) %in% names(formals(theme))])
#     })
# })
upsetPlot(venn,
          label_all=list(na.rm = TRUE, color = 'gray30', alpha = .7,
                         label.padding = unit(0.1, "lines"),
                         size = 8 #control the font size of the individual num
                         ),
          base_annotations=list('Intersection size'=
                                    ComplexUpset::intersection_size(
                                        ## font size of counts in the bar-plot
                                        text = list(size=6)
                                        )),
          themes = updated_theme
          )

## -----------------------------------------------------------------------------
pd <- system.file("extdata", package = "hicVennDiagram", mustWork = TRUE)
fs <- dir(pd, pattern = ".bedpe", full.names = TRUE)
fs <- fs[!grepl('group1', fs)] # make the test data smaller
set.seed(123)
background <- createGIbackground(fs)
gleamTest(fs, background = background, method = 'binom')

## ----sessionInfo, results='asis'----------------------------------------------
sessionInfo()

