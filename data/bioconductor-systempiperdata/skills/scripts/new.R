# Code example from 'new' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'----------------
BiocStyle::markdown()
options(width=60, max.print=1000)
knitr::opts_chunk$set(
    eval=as.logical(Sys.getenv("KNITR_EVAL", "TRUE")),
    cache=as.logical(Sys.getenv("KNITR_CACHE", "TRUE")), 
    tidy.opts=list(width.cutoff=60), tidy=TRUE)

## ----setup, echo=FALSE, message=FALSE, warning=FALSE, eval=FALSE----
# suppressPackageStartupMessages({
#     library(systemPipeR)
# })

## ----spblast-toplogy, eval=TRUE, warning= FALSE, echo=FALSE, out.width="100%", fig.align = "center", fig.cap= "Topology graph of this workflow template.", warning=FALSE----
knitr::include_graphics("results/plotwf_new.png")

## ----genNew_wf, eval=FALSE--------------------------------
# systemPipeRdata::genWorkenvir(workflow = "new", mydirname = "new")
# setwd("new")

## ----create_workflow, message=FALSE, eval=FALSE-----------
# library(systemPipeR)
# sal <- SPRproject()
# sal

## ----load_library, eval=FALSE, spr=TRUE-------------------
# appendStep(sal) <- LineWise(
#     code = {
#     library(systemPipeR)
#     },
#     step_name = "load_library"
# )

## ----view_sal, message=FALSE, eval=FALSE------------------
# sal

## ----export_iris, eval=FALSE, spr=TRUE--------------------
# appendStep(sal) <- LineWise(code={
#     mapply(
#       FUN = function(x, y) write.csv(x, y),
#       x = split(iris, factor(iris$Species)),
#       y = file.path("results", paste0(names(split(iris, factor(iris$Species))), ".csv"))
#     )
#     },
#   step_name = "export_iris",
#   dependency = "load_library"
# )

## ----gzip, eval=FALSE, spr=TRUE, spr.dep=TRUE-------------
# targetspath <- system.file("extdata/cwl/gunzip", "targets_gunzip.txt", package = "systemPipeR")
# appendStep(sal) <- SYSargsList(
#     targets = targetspath, dir = TRUE,
#     wf_file = "gunzip/workflow_gzip.cwl", input_file = "gunzip/gzip.yml",
#     dir_path = "param/cwl",
#     inputvars = c(FileName = "_FILE_PATH_", SampleName = "_SampleName_"),
#     step_name = "gzip",
#     dependency = "export_iris"
# )

## ----gunzip, eval=FALSE, spr=TRUE-------------------------
# appendStep(sal) <- SYSargsList(
#     targets = "gzip", dir = TRUE,
#     wf_file = "gunzip/workflow_gunzip.cwl", input_file = "gunzip/gunzip.yml",
#     dir_path = "param/cwl",
#     inputvars = c(gzip_file = "_FILE_PATH_", SampleName = "_SampleName_"),
#     rm_targets_col = "FileName",
#     step_name = "gunzip",
#     dependency = "gzip"
# )

## ----stats, eval=FALSE, spr=TRUE--------------------------
# appendStep(sal) <- LineWise(code={
#     # combine all files into one data frame
#     df <- lapply(getColumn(sal, step="gunzip", 'outfiles'), function(x) read.delim(x, sep=",")[-1])
#     df <- do.call(rbind, df)
#     # calculate mean and sd for each species
#     stats <- data.frame(cbind(mean=apply(df[,1:4], 2, mean), sd=apply(df[,1:4], 2, sd)))
#     stats$species <- rownames(stats)
#     # plot
#     plot <- ggplot2::ggplot(stats, ggplot2::aes(x=species, y=mean, fill=species)) +
#         ggplot2::geom_bar(stat = "identity", color="black", position=ggplot2::position_dodge()) +
#         ggplot2::geom_errorbar(
#             ggplot2::aes(ymin=mean-sd, ymax=mean+sd),
#             width=.2,
#             position=ggplot2::position_dodge(.9)
#         )
#     plot
#     },
#     step_name = "stats",
#     dependency = "gunzip",
#     run_step = "optional"
# )

## ----sessionInfo, eval=FALSE, spr=TRUE--------------------
# appendStep(sal) <- LineWise(
#     code = {
#     sessionInfo()
#     },
#     step_name = "sessionInfo",
#     dependency = "stats")

## ----import_run_routine, eval=FALSE-----------------------
# sal <- SPRproject(overwrite = TRUE) # Avoid 'overwrite=TRUE' in real runs.
# sal <- importWF(sal, file_path = "new.Rmd") # Imports above steps from new.Rmd.
# sal <- runWF(sal) # Runs workflow.
# plotWF(sal) # Plots workflow topology graph
# sal <- renderReport(sal) # Renders scientific report.
# sal <- renderLogs(sal) # Renders technical report from log files.

## ----list_tools-------------------------------------------
if(file.exists(file.path(".SPRproject", "SYSargsList.yml"))) {
    local({
        sal <- systemPipeR::SPRproject(resume = TRUE)
        systemPipeR::listCmdTools(sal)
        systemPipeR::listCmdModules(sal)
    })
} else {
    cat(crayon::blue$bold("Tools and modules required by this workflow are:\n"))
    cat(c("gzip", "gunzip"), sep = "\n")
}

## ----report_session_info, eval=TRUE-----------------------
sessionInfo()

