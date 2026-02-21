# Code example from 'vignette' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
devtools::load_all(".")

## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(echo = TRUE,
                      message = TRUE,
                      warning = TRUE)

## ----echo = FALSE, message = FALSE--------------------------------------------
require(rifi)
suppressPackageStartupMessages(library(SummarizedExperiment))

## ----eval = FALSE-------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly = TRUE))
#   install.packages("BiocManager")
# 
# BiocManager::install("rifi")

## ----models, echo = FALSE, fig.cap = "**Fit models**. Fits from both models. Left: the two-phase standard fit. Right the TI model fits the increase in intensity. Black dotes represent the average intensity for each timepoint, colored circles indicate the respective replicate.", out.width = '100%'----
knitr::include_graphics("fit_models.png")

## ----hirarchy, echo = FALSE, fig.cap = "**Fragmentation hirarchy**. The hierarchy of the workflow is separated into five steps. At first segments are formed based on the distance to the next data point. The threshold is 200 nucleotides. Next, segments are parted into delay fragments. The delay fragments are parted by the half-life and likewise the half-life fragments are parted by intensity. Groups of TUs are formed based on the distance between the starts and ends of the delay fragments. Finally, within TUs, TI fragments are formed.", out.width = '100%'----
knitr::include_graphics("hirarchy3.png")

## ----rifi_wrapper, eval = FALSE-----------------------------------------------
# library(rifi)
# data(example_input_e_coli)
# Path = gzfile(system.file("extdata", "gff_e_coli.gff3.gz", package = "rifi"))
# wrapper_minimal <-
#   rifi_wrapper(
#     inp = example_input_e_coli,
#     cores = 2,
#     path = Path,
#     bg = 0,
#     restr = 0.01
#   )
# }

## ----eval = TRUE--------------------------------------------------------------
data(wrapper_minimal)

# list of 6 SummarizedExperiment objects
length(wrapper_minimal)

#the first intermediate result
wrapper_minimal[[1]]

## ----eval = TRUE--------------------------------------------------------------
data(summary_minimal)

# the main results
names(metadata(summary_minimal))   

## ----eval = TRUE--------------------------------------------------------------
# bin/probe probe based results
head(metadata(summary_minimal)$dataframe_summary_1)

## ----eval = FALSE-------------------------------------------------------------
# #export to csv
# write.csv(metadata(summary_minimal)$dataframe_summary_1, file="filename.csv")

## ----eval = TRUE--------------------------------------------------------------
# all estimated fragments
metadata(summary_minimal)$dataframe_summary_2

## ----eval = FALSE-------------------------------------------------------------
# #export to csv
# write.csv(metadata(summary_minimal)$dataframe_summary_2, file="filename.csv")

## ----eval = TRUE--------------------------------------------------------------
# all estimated events
metadata(summary_minimal)$dataframe_summary_events

## ----eval = FALSE-------------------------------------------------------------
# #export to csv
# write.csv(metadata(summary_minimal)$dataframe_summary_events, file="filename.csv")

## ----events1, echo = FALSE, fig.cap = "Transcriptional events", out.width = '100%'----
knitr::include_graphics("events.png")

## ----eval = TRUE--------------------------------------------------------------
# 
metadata(summary_minimal)$dataframe_summary_TI

## ----eval = FALSE-------------------------------------------------------------
# #export to csv
# write.csv(metadata(summary_minimal)$dataframe_summary_TI, file="filename.csv")

## ----eval = TRUE--------------------------------------------------------------

#the first 5 rows and 10/45 colums of the final rowRanges
rowRanges(summary_minimal)[1:5,1:10]


## ----eval = FALSE-------------------------------------------------------------
# #export to csv
# write.csv(rowRanges(summary_minimal), file="filename.csv")
# 

## ----visua, echo = FALSE, fig.cap = "Whole genome visualization", fig.align = "left", out.height = "200%"----
knitr::include_graphics("genome_fragments_plot.png")

## ----longSegments, echo = FALSE, fig.cap = "**Long segments**", out.width="200%", out.height = "100%"----
knitr::include_graphics("longSegments.png")

## ----miniSegments, echo=FALSE, fig.cap="**Mini segments**", out.width = '250%'----
knitr::include_graphics("miniSegments.png")

## ----highValues, echo=FALSE, fig.cap="**High values**", out.width = '250%'----
knitr::include_graphics("highValues.png")

## ----echo = FALSE-------------------------------------------------------------
citation("rifi")

## ----echo = FALSE-------------------------------------------------------------
#example of E.coli data from RNAseq
paste("<font color='","red","'>","example of E.coli data from RNA-seq","</font>",sep="")
#print("example of E.coli data from RNA-seq")
data(example_input_minimal)
data(example_input_e_coli)
#require("SummarizedExperiment")
#columns with intensities measurements from all time point and replicates
print("assay e.coli")
assay(head(example_input_e_coli))
#rowRanges of the data
print("rowRanges e.coli")
rowRanges(head(example_input_e_coli))
# time points and replicates name
print("colData e.coli")
colData(example_input_e_coli)

## ----echo = FALSE-------------------------------------------------------------
#example of Synechocystis data from microarrays
print("example of Synechocystis data from microarrays")
data(example_input_synechocystis_6803)
#columns with intensities measurements from all time point
print("assay synechocystis") 
assay(head(example_input_synechocystis_6803))
#rowRanges of the data
print("rowRanges synechocystis")
rowRanges(head(example_input_synechocystis_6803))
#time points
print("colData synechocystis")
colData(example_input_synechocystis_6803)

## ----check_input, echo = FALSE------------------------------------------------
probe <- check_input(inp = example_input_minimal, thrsh = 0)

## ----make_df, echo = TRUE-----------------------------------------------------
probe <-
  make_df(
    inp = probe,
    cores = 2,
    bg = 0,
    rm_FLT = TRUE
  )
head(rowRanges(probe))

## ----segment_pos, echo = TRUE-------------------------------------------------
probe <- segment_pos(inp = probe, dista = 300)
head(rowRanges(probe))

## ----finding_PDD, eval = TRUE-------------------------------------------------
#Due to increased run time, this example is not evaluated in the vignette
probe <-
  finding_PDD(
    inp = probe,
    cores = 2,
    pen = 2,
    pen_out = 2,
    thrsh = 0.001
  )
head(rowRanges(probe))

## ----finding_TI, eval = TRUE--------------------------------------------------
#Due to increased run time, this example is not evaluated in the vignette
probe <-
  finding_TI(
    inp = probe,
    cores = 2,
    pen = 10,
    thrsh = 0.001
  )
head(rowRanges(probe))

## ----rifi_preprocess, echo = TRUE---------------------------------------------
#From here on the examples are shown on minimal examples.
#Two bigger data sets can be used to run the example as well.
preprocess_minimal <-
  rifi_preprocess(
    inp = probe,
    cores = 2,
    bg = 0,
    rm_FLT = TRUE,
    thrsh_check = 10,
    dista = 300,
    run_PDD = TRUE
  )
head(rowRanges(preprocess_minimal))

## ----rifi_fit, echo = FALSE---------------------------------------------------
#Two bigger data sets can be used to run the example as well.
data(preprocess_minimal)
suppressWarnings(fit_minimal <- rifi_fit(
  inp = preprocess_minimal,
  cores = 2,
  viz = FALSE,
  restr = 0.2,
  decay = seq(.08, 0.11, by = .02),
  delay = seq(0, 10, by = .1),
  k = seq(0.1, 1, 0.2),
  bg = 0.2,
  TI_k = seq(0, 1, by = 0.5),
  TI_decay = c(0.05, 0.1, 0.2, 0.5, 0.6),
  TI = seq(0, 1, by = 0.5),
  TI_delay = seq(0, 2, by = 0.5),
  TI_rest_delay = seq(0, 2, by = 0.5),
  TI_bg = 0
))

## ----output_fit---------------------------------------------------------------
#Output
data(fit_e_coli)
head(rowRanges(fit_e_coli))

## ----echo = TRUE,  eval = FALSE-----------------------------------------------
# nls2_fit(inp = preprocess_minimal,
#          cores = 1,
#          decay = seq(.08, 0.11, by = .02),
#          delay = seq(0, 10, by = .1),
#          k = seq(0.1, 1, 0.2),
#          bg = 0.2
# )

## ----echo = TRUE--------------------------------------------------------------
Table_2 <- rowRanges(preprocess_minimal)
head(Table_2)

## ----echo = TRUE--------------------------------------------------------------
probe <- metadata(fit_minimal)[[3]]
head(probe)

## ----TI_fit, eval = FALSE-----------------------------------------------------
# TI_fit(inp = preprocess_minimal,
#        cores = 1,
#        restr = 0.2,
#        k = seq(0, 1, by = 0.5),
#        decay = c(0.05, 0.1, 0.2, 0.5, 0.6),
#        ti = seq(0, 1, by = 0.5),
#        ti_delay = seq(0, 2, by = 0.5),
#        rest_delay = seq(0, 2, by = 0.5),
#        bg = 0
# )

## ----echo = TRUE--------------------------------------------------------------
probe <- metadata(fit_minimal)[[4]]
head(probe)

## ----plot_nls2, eval=F--------------------------------------------------------
# plot_nls2_function(inp = probe_df)

## ----nls2Plot, echo=FALSE, fig.cap="**Standard fit with nls2**", out.width = '100%'----
knitr::include_graphics("nls2Plot.png")

## ----plot_nls2_function, eval=F-----------------------------------------------
# plot_nls2_function(inp = probe_df)

## ----TIPlot, echo = FALSE, fig.cap="**TI model fit**", out.width = '100%'-----
knitr::include_graphics("TIPlot.png")

## ----make_pen, eval = FALSE---------------------------------------------------
# data(fit_minimal)
# pen_delay <-
#   make_pen(
#     probe = fit_minimal,
#     FUN = rifi:::fragment_delay_pen,
#     cores = 2,
#     logs = logbook,
#     dpt = 1,
#     smpl_min = 0,
#     smpl_max = 18,
#     sta_pen = 0.5,
#     end_pen = 4.5,
#     rez_pen = 9,
#     sta_pen_out = 0.5,
#     end_pen_out = 3.5,
#     rez_pen_out = 7
#   )
# pen_HL <- make_pen(
#   probe = fit_minimal,
#   FUN = rifi:::fragment_HL_pen,
#   cores = 2,
#   logs = logbook,
#   dpt = 1,
#   smpl_min = 0,
#   smpl_max = 18,
#   sta_pen = 0.5,
#   end_pen = 4.5,
#   rez_pen = 9,
#   sta_pen_out = 0.5,
#   end_pen_out = 3.5,
#   rez_pen_out = 7
# )
# pen_inty <-
#   make_pen(
#     probe = fit_minimal,
#     FUN = rifi:::fragment_inty_pen,
#     cores = 2,
#     logs = logbook,
#     dpt = 1,
#     smpl_min = 0,
#     smpl_max = 18,
#     sta_pen = 0.5,
#     end_pen = 4.5,
#     rez_pen = 9,
#     sta_pen_out = 0.5,
#     end_pen_out = 3.5,
#     rez_pen_out = 7
#   )
# pen_TI <- make_pen(
#   probe = fit_minimal,
#   FUN = rifi:::fragment_TI_pen,
#   cores = 2,
#   logs = logbook,
#   dpt = 1,
#   smpl_min = 0,
#   smpl_max = 18,
#   sta_pen = 0.5,
#   end_pen = 4.5,
#   rez_pen = 9,
#   sta_pen_out = 0.5,
#   end_pen_out = 3.5,
#   rez_pen_out = 7
# )

## ----viz_pen_obj, eval = FALSE------------------------------------------------
# viz_pen_obj(obj = pen_delay, top_i = 10)

## ----penalty, echo = FALSE, fig.cap = "**penalty plot**: The graphic shows penalties ranked by the correct fits subtracted by the wrong fits. Each penalty corresponds to a color given in the legend. Red dots represent wrong splits, green dots represent correct splits. In the zoomed window (bottom) numbers above the dots represent the outlier-penalty.", out.width = '100%'----
knitr::include_graphics("penalty.png")

## ----rifi_fragmentation, echo=F-----------------------------------------------
data(penalties_minimal)
fragmentation_minimal <-
  rifi_fragmentation(
    inp = penalties_minimal,
    cores = 2
  )

## ----echo = TRUE--------------------------------------------------------------
data(fragmentation_e_coli)
head(rowRanges(fragmentation_e_coli))

## ----fragment_delay, eval = FALSE---------------------------------------------
# data(fragmentation_minimal)
# data(penalties_minimal)
# probe_df <- fragment_delay(
#   inp = fragmentation_minimal,
#   cores = 2,
#   pen = penalties_minimal["delay_penalty"],
#   pen_out = penalties_minimal["delay_outlier_penalty"]
# )
# head(rowRanges(probe_df))

## ----fragment_HL, eval = FALSE------------------------------------------------
# data(fragmentation_minimal)
# data(penalties_minimal)
# probe_df <- fragment_HL(
#   probe = fragmentation_minimal,
#   cores = 2,
#   pen = penalties_minimal["half_life_penalty"],
#   pen_out = penalties_minimal["half_life_outlier_penalty"]
# )
# head(rowRanges(probe_df))

## ----fragment_inty, eval = FALSE----------------------------------------------
# data(fragmentation_minimal)
# data(penalties_minimal)
# probe_df <- fragment_inty(
#   inp = fragmentation_minimal,
#   cores = 2,
#   pen = penalties_minimal["intensity_penalty"],
#   pen_out = penalties_minimal["intensity_outlier_penalty"]
# )
# head(rowRanges(probe_df))

## ----TUgether, eval = FALSE---------------------------------------------------
# data(fragmentation_minimal)
# probe_df <- TUgether(inp = fragmentation_minimal, cores = 2, pen = -0.75)
# head(rowRanges(probe_df))

## ----fragment_TI, eval = FALSE------------------------------------------------
# data(fragmentation_minimal)
# data(penalties_minimal)
# probe_df <- fragment_TI(
#   inp = fragmentation_minimal,
#   cores = 2,
#   pen = penalties_minimal["TI_penalty"],
#   pen_out = penalties_minimal["TI_outlier_penalty"]
# )
# head(rowRanges(probe_df))

## ----rifi_stats---------------------------------------------------------------
data(fragmentation_minimal)
Path = gzfile(system.file("extdata", "gff_e_coli.gff3.gz", package = "rifi"))
stats_minimal <- rifi_stats(inp = fragmentation_minimal, dista = 300, 
                            path = Path)
head(rowRanges(stats_minimal))

## ----predict_ps_itss, eval=FALSE----------------------------------------------
# data(fragmentation_minimal)
# probe <- predict_ps_itss(inp = fragmentation_minimal, maxDis = 300)
# head(rowRanges(probe))

## ----apply_Ttest_delay, eval = FALSE------------------------------------------
# probe <- apply_Ttest_delay(inp = probe)
# head(rowRanges(probe))

## ----apply_ancova, eval=F-----------------------------------------------------
# probe <- apply_ancova(inp = probe)
# head(rowRanges(probe))

## ----apply_event_position, eval=F---------------------------------------------
# probe <- apply_event_position(inp = probe)
# head(rowRanges(probe))

## ----apply_t_test, eval=F-----------------------------------------------------
# probe <- apply_t_test(inp = probe, threshold = 300)
# head(rowRanges(probe))

## ----fold_change, eval=F------------------------------------------------------
# probe <- fold_change(inp = probe)
# head(rowRanges(probe))

## ----apply_manova, eval=F-----------------------------------------------------
# apply_manova(inp = probe)
# head(rowRanges(probe))

## ----gff3_preprocess, eval = FALSE--------------------------------------------
# Path = gzfile(system.file("extdata", "gff_e_coli.gff3.gz", package = "rifi"))
#   metadata(stats_minimal)$annot <- gff3_preprocess(path = Path)

## ----apply_t_test_ti, eval=F--------------------------------------------------
# probe <- apply_t_test_ti(inp = probe)
# head(rowRanges(probe))

## ----rifi_summary, eval=F-----------------------------------------------------
# data(stats_minimal)
# summary_minimal <- rifi_summary(stats_minimal)

## ----eval = FALSE-------------------------------------------------------------
# data(summary_minimal)
# head(metadata(summary_minimal))

## ----event_dataframe, eval=F--------------------------------------------------
# data(stats_minimal)
# event_dataframe(data = stats_minimal, data_annotation = metadata(stats_minimal)$annot[[1]])

## ----rifi_visualization, eval = FALSE-----------------------------------------
# stats_minimal
# rifi_visualization(
#   data = stats_minimal
#   )

## ----genomeplot1, echo=F, fig.cap="**Fragments Plot Forward Strand**", out.width = '100%'----
	knitr::include_graphics("genome_plot_1.png")

## ----genomeplot2, echo=F, fig.cap="**Fragments Plot Reverse Strand**", out.width = '100%'----
	knitr::include_graphics("genome_plot_2.png")

## ----score_fun_linear, eval = FALSE-------------------------------------------
# score_fun_linear(y, x, z = x, pen, stran, n_out = min(10,
#                                                       max(1, 0.4 * length(x))))

## ----score_fun_ave, eval = FALSE----------------------------------------------
# score_fun_ave(y, z, pen, n_out = min(10, max(1, 0.4*length(z))))

## ----score_fun_increasing, eval=F---------------------------------------------
# score_fun_increasing(x, y)

## -----------------------------------------------------------------------------
sessionInfo()

