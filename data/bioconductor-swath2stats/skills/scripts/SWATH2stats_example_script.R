# Code example from 'SWATH2stats_example_script' vignette. See references/ for full tutorial.

## ----eval=FALSE---------------------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install("SWATH2stats")

## -----------------------------------------------------------------------------
library(SWATH2stats)
library(data.table)
data('Spyogenes', package = 'SWATH2stats')

## ----eval=FALSE---------------------------------------------------------------
# data <- data.frame(fread('rawOpenSwathResults_1pcnt_only.tsv', sep='\t', header=TRUE))

## ----tidy=TRUE----------------------------------------------------------------
Study_design <- data.frame(Filename = unique(data$align_origfilename))
Study_design$Filename <- gsub('.*strep_align/(.*)_all_peakgroups.*', '\\1', Study_design$Filename)
Study_design$Condition <- gsub('(Strep.*)_Repl.*', '\\1', Study_design$Filename)
Study_design$BioReplicate <- gsub('.*Repl([[:digit:]])_.*', '\\1', Study_design$Filename)
Study_design$Run <- seq_len(nrow(Study_design))
head(Study_design)

## -----------------------------------------------------------------------------
data.annotated <- sample_annotation(data, Study_design, column_file = "align_origfilename")

## -----------------------------------------------------------------------------
data.annotated.nodecoy <- subset(data.annotated, decoy==FALSE)

## -----------------------------------------------------------------------------
count_analytes(data.annotated.nodecoy)

## ----fig.height=2.5, fig.width = 6--------------------------------------------
correlation <- plot_correlation_between_samples(data.annotated.nodecoy, column.values = 'Intensity')

## ----fig.height=2.5, fig.width = 6--------------------------------------------
correlation <- plot_correlation_between_samples(data.annotated.nodecoy, column.values = 'delta_rt')

## ----fig.height=2.5, fig.width = 5.5------------------------------------------
variation <- plot_variation(data.annotated.nodecoy)
variation[[2]]

## ----fig.height=2.5, fig.width = 5.5------------------------------------------
variation_total <- plot_variation_vs_total(data.annotated.nodecoy)
variation_total[[2]]

## -----------------------------------------------------------------------------
peptide_signal <- write_matrix_peptides(data.annotated.nodecoy)
protein_signal <- write_matrix_proteins(data.annotated.nodecoy)
head(protein_signal)

## ----fig.height = 3.5---------------------------------------------------------
par(mfrow = c(1, 3))
fdr_target_decoy <- assess_fdr_overall(data.annotated, n_range = 10, 
                                       FFT = 0.25, output = 'Rconsole')


## -----------------------------------------------------------------------------
mscore4protfdr(data, FFT = 0.25, fdr_target = 0.05)

## -----------------------------------------------------------------------------
data.filtered <- filter_mscore_condition(data.annotated, 0.001, n_replica = 2)

## -----------------------------------------------------------------------------
data.filtered2 <- filter_on_max_peptides(data.filtered, n_peptides = 10)

## -----------------------------------------------------------------------------
data.filtered3 <- filter_on_min_peptides(data.filtered2, n_peptides = 2)

## -----------------------------------------------------------------------------
data.transition <- disaggregate(data.filtered3)

## -----------------------------------------------------------------------------
MSstats.input <- convert4MSstats(data.transition)
head(MSstats.input)

## -----------------------------------------------------------------------------
mapDIA.input <- convert4mapDIA(data.transition)
head(mapDIA.input)

## -----------------------------------------------------------------------------
aLFQ.input <- convert4aLFQ(data.transition)
head(aLFQ.input)

## -----------------------------------------------------------------------------
sessionInfo()

