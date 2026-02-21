# Code example from 'SPblast' vignette. See references/ for full tutorial.

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

## ----spblast-toplogy, eval=TRUE, warning= FALSE, echo=FALSE, out.width="100%", fig.align = "center", fig.cap= "Topology graph of BLAST workflow.", warning=FALSE----
knitr::include_graphics("results/plotwf_spblast.jpg")

## ----gen_spblast_wf, eval=FALSE---------------------------
# systemPipeRdata::genWorkenvir(workflow = "SPblast", mydirname = "SPblast")
# setwd("SPblast")

## ----create_workflow, message=FALSE, eval=FALSE-----------
# library(systemPipeR)
# sal <- SPRproject()
# sal

## ----load_workflow_default, eval=FALSE--------------------
# sal <- importWF(sal, "SPblast.Rmd")
# sal <- runWF(sal)

## ----load_packages, eval=FALSE, spr=TRUE------------------
# appendStep(sal) <- LineWise(
#     code = {
#         library(systemPipeR)
#     },
#     step_name = "load_packages"
# )

## ----test_blast, eval=FALSE, spr=TRUE---------------------
# appendStep(sal) <- LineWise(
#     code = {
#         # If you have a modular system, then enable the following line
#         # moduleload("ncbi-blast")
#         blast_check <- tryCMD("blastn", silent = TRUE)
#         if(blast_check  == "error") stop("Check your BLAST installation path.")
#     },
#     step_name = "test_blast",
#     dependency = "load_packages"
# )

## ----build_genome_db, eval=FALSE, spr=TRUE----------------
# appendStep(sal) <- SYSargsList(
#     step_name = "build_genome_db",
#     dir = FALSE,
#     targets=NULL,
#     wf_file = "blast/makeblastdb.cwl",
#     input_file="blast/makeblastdb.yml",
#     dir_path="param/cwl",
#     dependency = "test_blast"
# )

## ----blast_genome, eval=FALSE, spr=TRUE-------------------
# appendStep(sal) <- SYSargsList(
#     step_name = "blast_genome",
#     dir = FALSE,
#     targets="targets_blast.txt",
#     wf_file = "blast/blastn.cwl",
#     input_file="blast/blastn.yml",
#     inputvars = c(
#         FileName = "_query_file_",
#         SampleName = "_SampleName_"
#     ),
#     dir_path="param/cwl",
#     dependency = "build_genome_db"
# )

## ----display_hits, eval=FALSE, spr=TRUE-------------------
# appendStep(sal) <- LineWise(
#     code = {
#         # get the output file path from a Sysargs step using `getColumn`
#         tbl_tair10 <- read.delim(getColumn(sal, step = "blast_genome")[1], header = FALSE, stringsAsFactors = FALSE)
#         names(tbl_tair10) <- c(
#           "query", "subject", "identity", "alignment_length", "mismatches",
#           "gap_openings", "q_start", "q_end", "s_start", "s_end",
#           "e_value", "bit_score"
#         )
#         print(head(tbl_tair10, n = 20))
#     },
#     step_name = "display_hits",
#     dependency = "blast_genome"
# )

## ----wf_session, eval=FALSE, spr=TRUE---------------------
# appendStep(sal) <- LineWise(
#     code = {
#         sessionInfo()
#     },
#     step_name = "wf_session",
#     dependency = "display_hits")

## ----import_run_routine, eval=FALSE-----------------------
# sal <- SPRproject(overwrite = TRUE) # Avoid 'overwrite=TRUE' in real runs.
# sal <- importWF(sal, file_path = "SPblast.Rmd") # Imports above steps from new.Rmd.
# sal <- runWF(sal) # Runs ggworkflow.
# plotWF(sal) # Plot toplogy graph of workflow
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
    cat(c("BLAST 2.16.0+"), sep = "\n")
}

## ----report_session_info, eval=TRUE-----------------------
sessionInfo()

