# Code example from 'segmenter' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  message = FALSE
)

## ----install, eval=FALSE------------------------------------------------------
# # install from bioconductor
# BiocManager::install('segmenter')
# 
# # install from github
# remotes::install_github('MahShaaban/segmenter@devel')

## ----load_library-------------------------------------------------------------
# load library
library(segmenter)

## ----prepare_directories, message = FALSE-------------------------------------
# locate input and annotation files
inputdir <- system.file('extdata/SAMPLEDATA_HG18',
                        package = 'segmenter')
coordsdir <- system.file('extdata/COORDS',
                         package = 'chromhmmData')
anchorsdir <- system.file('extdata/ANCHORFILES',
                          package = 'chromhmmData')
chromsizefile <- system.file('extdata/CHROMSIZES',
                             'hg18.txt',
                             package = 'chromhmmData')

## ----getting_stated-----------------------------------------------------------
# run command
obj <- learn_model(inputdir = inputdir,
                   coordsdir = coordsdir,
                   anchorsdir = anchorsdir,
                   chromsizefile = chromsizefile,
                   numstates = 3,
                   assembly = 'hg18',
                   cells = c('K562', 'GM12878'),
                   annotation = 'RefSeq',
                   binsize = 200)

## ----show---------------------------------------------------------------------
# show the object
show(obj)

## ----setup--------------------------------------------------------------------
# load required libraries
library(segmenter)
library(Gviz)
library(ComplexHeatmap)
library(TxDb.Hsapiens.UCSC.hg18.knownGene)

## ----genomic_annotations------------------------------------------------------
# coordinates
coordsdir <- system.file('extdata/COORDS',
                         package = 'chromhmmData')

list.files(file.path(coordsdir, 'hg18'))

# anchors
anchorsdir <- system.file('extdata/ANCHORFILES',
                          package = 'chromhmmData')

list.files(file.path(anchorsdir, 'hg18'))

# chromosomes' sizes
chromsizefile <- system.file('extdata/CHROMSIZES',
                             'hg18.txt',
                              package = 'chromhmmData')

readLines(chromsizefile, n = 3)

## ----cellmarkfiletable--------------------------------------------------------
# a table to assign marker and cell names to the bam files
cellmarkfiletable <- system.file('extdata',
                                 'cell_mark_table.tsv',
                                 package = 'segmenter')

readLines(cellmarkfiletable, n = 3)

## ----binary_inputs------------------------------------------------------------
# locate input and output
inputdir <- system.file("extdata", package = "bamsignals")
outputdir <- tempdir()

## ----binarize-----------------------------------------------------------------
# run command
binarize_bam(inputdir,
             chromsizefile = chromsizefile,
             cellmarkfiletable = cellmarkfiletable,
             outputdir = outputdir)

# show output files
example_binaries <- list.files(outputdir, pattern = '*_binary.txt')
example_binaries

# show the format of the binary file
readLines(file.path(outputdir, example_binaries[1]), n = 3)

## ----input_bins---------------------------------------------------------------
# locate input and output files
inputdir <- system.file('extdata/SAMPLEDATA_HG18',
                        package = 'segmenter')

list.files(inputdir)

## ----run_command--------------------------------------------------------------
# run command
obj <- learn_model(inputdir = inputdir,
                   coordsdir = coordsdir,
                   anchorsdir = anchorsdir,
                   outputdir = outputdir,
                   chromsizefile = chromsizefile,
                   numstates = 3,
                   assembly = 'hg18',
                   cells = c('K562', 'GM12878'),
                   annotation = 'RefSeq',
                   binsize = 200)

## ----methods------------------------------------------------------------------
# show the object
show(obj)

## ----accessors----------------------------------------------------------------
# access object slots
emission(obj)

## ----subset-------------------------------------------------------------------
# subset the segment slot
segment(obj, cell = 'K562')

## ----multiple_numstates-------------------------------------------------------
# relearn the models with 3 to 8 states
objs <- lapply(3:8,
    function(x) {
      learn_model(inputdir = inputdir,
                   coordsdir = coordsdir,
                   anchorsdir = anchorsdir,
                   chromsizefile = chromsizefile,
                   numstates = x,
                   assembly = 'hg18',
                   cells = c('K562', 'GM12878'),
                   annotation = 'RefSeq',
                   binsize = 200)
    })

## ----compare_numstats---------------------------------------------------------
# compare the models max correlation between the states
compare_models(objs)

## ----compare_likelihood-------------------------------------------------------
# compare the models likelihood
compare_models(objs, type = 'likelihood')

## ----plot_comparison,fig.align='center',fig.width=7,fig.height=4--------------
# compare models plots
par(mfrow = c(1, 2))
compare_models(objs,
               plot = TRUE,
               xlab = 'Model', ylab = 'State Correlation')
compare_models(objs, type = 'likelihood',
               plot = TRUE,
               xlab = 'Model', ylab = 'Likelihood')

## ----parameters---------------------------------------------------------------
# access object slots
emission(obj)
transition(obj)

## ----visulaize_matrices,fig.align='center',fig.height=3,fig.width=6-----------
# emission and transition plots
h1 <- plot_heatmap(obj,
                   row_labels = paste('S', 1:3),
                   name = 'Emission')

h2 <- plot_heatmap(obj,
                   type = 'transition',
                   row_labels = paste('S', 1:3),
                   column_labels = paste('S', 1:3),
                   name = 'Transition')
h1 + h2

## ----overlap------------------------------------------------------------------
# overlap enrichment
overlap(obj)

## ----visulaizing_overlap,fig.align='center',fig.height=3,fig.width=6----------
# overlap enrichment plots
plot_heatmap(obj,
             type = 'overlap',
             column_labels = c('Genome', 'CpG', 'Exon', 'Gene',
                               'TES', 'TSS', 'TSS2kb', 'laminB1lads'),
             show_heatmap_legend = FALSE)

## ----genomic_locations--------------------------------------------------------
# genomic locations enrichment
TSS(obj)
TES(obj)

## ----visualizing_genomic_locaitons,fig.align='center',fig.height=3,fig.width=7----
# genomic locations enrichment plots
h1 <- plot_heatmap(obj,
                   type = 'TSS',
                   show_heatmap_legend = FALSE)
h2 <- plot_heatmap(obj,
                   type = 'TES',
                   show_heatmap_legend = FALSE)

h1 + h2

## ----segments-----------------------------------------------------------------
# get segments
segment(obj)

## ----visulaize_segments,fig.align='center',fig.height=3,fig.width=3-----------
# gene gene coordinates
gen <- genes(TxDb.Hsapiens.UCSC.hg18.knownGene,
             filter = list(gene_id = 38))

# extend genomic region
prom <- promoters(gen,
                  upstream = 10000,
                  downstream = 10000)

# annotation track
segs1 <- segment(obj, 'K562')
atrack1 <- AnnotationTrack(segs1$K562,
                          group = segs1$K562$state,
                          name = 'K562')

segs2 <- segment(obj, 'GM12878')
atrack2 <- AnnotationTrack(segs2$GM12878,
                          group = segs2$GM12878$state,
                          name = 'GM12878')

# plot the track
plotTracks(atrack1, from = start(prom), to = end(prom))
plotTracks(atrack2, from = start(prom), to = end(prom))

## ----add_tracks,fig.align='center',fig.height=4,fig.width=4-------------------
# ideogram track
itrack <- IdeogramTrack(genome = 'hg18', chromosome = 11)

# genome axis track
gtrack <- GenomeAxisTrack()

# gene region track
data("geneModels")
grtrack <- GeneRegionTrack(geneModels,
                           genom = 'hg18',
                           chromosome = 11,
                           name = 'ACAT1')

# put all tracks together
plotTracks(list(itrack, gtrack, grtrack, atrack1, atrack2),
           from = min(start(prom)),
           to = max(end(gen)),
           groupAnnotation = 'group')

## ----segment_frequency--------------------------------------------------------
# get segment frequency
get_frequency(segment(obj), tidy = TRUE)

## ----plot_frequency,fig.align='center',fig.width=7,fig.height=4---------------
# frequency plots
par(mfrow=c(1, 2))
get_frequency(segment(obj),
              plot = TRUE,
              ylab = 'Segment Frequency')

get_frequency(segment(obj),
              normalize = TRUE,
              plot = TRUE,
              ylab = 'Segment Fraction')

## ----session------------------------------------------------------------------
sessionInfo()

