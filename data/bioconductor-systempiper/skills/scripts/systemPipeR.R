# Code example from 'systemPipeR' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'--------------------------------------------------------
BiocStyle::markdown()
options(width = 100, max.print = 1000)
knitr::opts_chunk$set(
    eval = as.logical(Sys.getenv("KNITR_EVAL", "TRUE")),
    cache = as.logical(Sys.getenv("KNITR_CACHE", "TRUE")), 
    tidy.opts = list(width.cutoff = 100), tidy = FALSE)

## ----setting, eval=TRUE, echo=FALSE---------------------------------------------------------------
if (file.exists("spr_project")) unlink("spr_project", recursive = TRUE)
is_win <- Sys.info()[['sysname']] != "Windows"

## ----load_library, eval=TRUE, include=FALSE-------------------------------------------------------
suppressPackageStartupMessages({
    library(systemPipeR)
})

## ----utilities, eval=TRUE, warning= FALSE, echo=FALSE, out.width="100%", fig.align = "center", fig.cap= "Important functionalities of systemPipeR. (A) Illustration of workflow design concepts, and (B) examples of visualization functionalities for NGS data.", warning=FALSE----
knitr::include_graphics("images/utilities.png")

## ----sysargslistImage, warning= FALSE, eval=TRUE, echo=FALSE, out.width="100%", fig.align = "center", fig.cap= "Workflow management class. Workflows are defined and managed by the `SYSargsList` (`SAL`) control class. Components of `SAL` include `SYSargs2` and/or `LineWise` for defining CL- and R-based workflow steps, respectively. The former are constructed from a `targets` and two CWL *param* files, and the latter comprises mainly R code.", warning=FALSE----

knitr::include_graphics("images/SYSargsList.png")

## ----sprandCWL, warning=FALSE, eval=TRUE, echo=FALSE, out.width="100%", fig.align = "center", fig.cap= "Parameter files. Illustration how the different fields in cwl, yml and targets files are connected to assemble command-line calls, here for 'Hello World' example.", warning=FALSE----

knitr::include_graphics("images/SPR_CWL_hello.png")

## ----general, warning= FALSE, eval=TRUE, echo=FALSE, out.width="100%", fig.align = "center", fig.cap= "Overview of `systemPipeR` workflows management instances. (A) A typical analysis workflow requires multiple software tools (red), metadata for describing the input (green) and output data, and analysis reports for interpreting the results (purple). B) The environment provides utilities for designing and building workflows containing R and/or command-line steps, for managing the workflow runs. C) Options are provided to execute single or multiple workflow steps. This includes a high level of scalability, functionalities for checkpointing, and generating of technical and scientific reports.", warning=FALSE----

knitr::include_graphics("images/general.png")

## ----install, eval=FALSE--------------------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE)) install.packages("BiocManager")
# BiocManager::install("systemPipeR")
# BiocManager::install("systemPipeRdata")

## ----eval=FALSE-----------------------------------------------------------------------------------
# systemPipeRdata::genWorkenvir(workflow = "rnaseq")
# setwd("rnaseq")

## ----eval=FALSE-----------------------------------------------------------------------------------
# library(systemPipeR)
# # Initialize workflow project
# sal <- SPRproject()
# ## Creating directory '/home/myuser/systemPipeR/rnaseq/.SPRproject'
# ## Creating file '/home/myuser/systemPipeR/rnaseq/.SPRproject/SYSargsList.yml'
# sal <- importWF(sal, file_path = "systemPipeRNAseq.Rmd") # import into sal the WF steps defined by chosen Rmd file
# 
# ## The following print statements, issued during the import, are shortened for brevity
# ## Import messages for first 3 of 20 steps total
# ## Parse chunk code
# ## Now importing step 'load_SPR'
# ## Now importing step 'preprocessing'
# ## Now importing step 'trimming'
# ## Now importing step '...'
# ## ...
# 
# ## Now check if required CL tools are installed
# ## Messages for 4 of 7 CL tools total
# ##        step_name         tool in_path
# ## 1       trimming  trimmomatic    TRUE
# ## 2   hisat2_index hisat2-build    TRUE
# ## 3 hisat2_mapping       hisat2    TRUE
# ## 4 hisat2_mapping     samtools    TRUE
# ## ...

## ----eval=FALSE-----------------------------------------------------------------------------------
# sal
# ## Instance of 'SYSargsList':
# ##     WF Steps:
# ##        1. load_SPR --> Status: Pending
# ##        2. preprocessing --> Status: Pending
# ##            Total Files: 36 | Existing: 0 | Missing: 36
# ##          2.1. preprocessReads-pe
# ##              cmdlist: 18 | Pending: 18
# ##        3. trimming --> Status: Pending
# ##            Total Files: 72 | Existing: 0 | Missing: 72
# ##        4. - 20. not shown here for brevity

## ----eval=FALSE-----------------------------------------------------------------------------------
# sal <- runWF(sal)

## ----eval=FALSE-----------------------------------------------------------------------------------
# sal

## ----wf-status-image, warning=FALSE, eval=TRUE, echo=FALSE, out.width="100%", fig.align = "center", fig.cap= "Status check of workflow. The run status flags of each workflow step are given in its summary view.", warning=FALSE----

knitr::include_graphics("images/runwf.png")

## ----eval=FALSE-----------------------------------------------------------------------------------
# plotWF(sal)

## ----rnaseq-toplogy, eval=TRUE, warning= FALSE, echo=FALSE, out.width="100%", fig.align = "center", fig.cap= "Toplogy graph of RNA-Seq workflow.", warning=FALSE----
knitr::include_graphics("images/plotWF.png")

## ----eval=FALSE-----------------------------------------------------------------------------------
# # Scietific report
# sal <- renderReport(sal)
# rmarkdown::render("systemPipeRNAseq.Rmd", clean = TRUE, output_format = "BiocStyle::html_document")
# 
# # Technical (log) report
# sal <- renderLogs(sal)

## ----dir, eval=TRUE, echo=FALSE, warning= FALSE, out.width="100%", fig.align = "center", fig.cap= "Directory structure of workflows.", warning=FALSE----
knitr::include_graphics("images/spr_project.png")  

## ----targetsSE, eval=TRUE-------------------------------------------------------------------------
targetspath <- system.file("extdata", "targets.txt", package = "systemPipeR") 
showDF(read.delim(targetspath, comment.char = "#"))

## ----targetsPE, eval=TRUE-------------------------------------------------------------------------
targetspath <- system.file("extdata", "targetsPE.txt", package = "systemPipeR")
showDF(read.delim(targetspath, comment.char = "#"))

## ----comment_lines, echo=TRUE---------------------------------------------------------------------
readLines(targetspath)[1:4]

## ----targetscomp, eval=TRUE-----------------------------------------------------------------------
readComp(file = targetspath, format = "vector", delim = "-")

## ----targetsFig, eval=TRUE, echo=FALSE, out.width="100%", fig.align = "center", fig.cap= "_`systemPipeR`_ automatically creates the downstream `targets` files based on the previous steps outfiles. A) Usually, users provide the initial `targets` files, and this step will generate some outfiles, as demonstrated on B. Then, those files are used to build the new `targets` files as inputs in the next step. _`systemPipeR`_ (C) manages this connectivity among the steps automatically for the users.", warning=FALSE----
knitr::include_graphics("images/targets_con.png")  

## ----cleaning1, eval=TRUE, include=FALSE----------------------------------------------------------
if (file.exists(".SPRproject")) unlink(".SPRproject", recursive = TRUE)
## NOTE: Removes previous project created in the quick-start section

## ----SPRproject1a, eval=FALSE---------------------------------------------------------------------
# sal <- SPRproject()

## ----SPRproject1, eval=TRUE-----------------------------------------------------------------------
sal <- SPRproject(projPath = getwd(), overwrite = TRUE) 

## ----SPRproject_dir, eval=FALSE-------------------------------------------------------------------
# sal <- SPRproject(data = "data", param = "param", results = "results")

## ----SPRproject_logs, eval=FALSE------------------------------------------------------------------
# sal <- SPRproject(logs.dir= ".SPRproject", sys.file=".SPRproject/SYSargsList.yml")

## ----SPRproject_env, eval=FALSE-------------------------------------------------------------------
# sal <- SPRproject(envir = new.env())

## ----projectInfo, eval=TRUE-----------------------------------------------------------------------
sal
projectInfo(sal)

## ----length, eval=TRUE----------------------------------------------------------------------------
length(sal)

## ----sal_check, eval=TRUE-------------------------------------------------------------------------
sal

## ----firstStep_R, eval=TRUE-----------------------------------------------------------------------
appendStep(sal) <- LineWise(code = {
                              mapply(function(x, y) write.csv(x, y),
                                     split(iris, factor(iris$Species)),
                                     file.path("results", paste0(names(split(iris, factor(iris$Species))), ".csv"))
                                     ) 
                            },
                            step_name = "export_iris")

## ----show, eval=TRUE------------------------------------------------------------------------------
sal

## ----codeLine, eval=TRUE--------------------------------------------------------------------------
codeLine(sal)

## ----gzip_secondStep, eval=TRUE-------------------------------------------------------------------
targetspath <- system.file("extdata/cwl/gunzip", "targets_gunzip.txt", package = "systemPipeR")
appendStep(sal) <- SYSargsList(step_name = "gzip", 
                      targets = targetspath, dir = TRUE,
                      wf_file = "gunzip/workflow_gzip.cwl", input_file = "gunzip/gzip.yml",
                      dir_path = system.file("extdata/cwl", package = "systemPipeR"),
                      inputvars = c(FileName = "_FILE_PATH_", SampleName = "_SampleName_"), 
                      dependency = "export_iris")

## -------------------------------------------------------------------------------------------------
sal

## -------------------------------------------------------------------------------------------------
cmdlist(sal, step = "gzip")
# cmdlist(sal, step = "gzip", targets=c("SE"))

## -------------------------------------------------------------------------------------------------
# outfiles(sal) # output files of all steps in sal
outfiles(sal)['gzip'] # output files of 'gzip' step
# colnames(outfiles(sal)$gzip) # returns column name passed on to `inputvars`

## ----gunzip, eval=TRUE----------------------------------------------------------------------------
appendStep(sal) <- SYSargsList(step_name = "gunzip", 
                      targets = "gzip", dir = TRUE,
                      wf_file = "gunzip/workflow_gunzip.cwl", input_file = "gunzip/gunzip.yml",
                      dir_path = system.file("extdata/cwl", package = "systemPipeR"),
                      inputvars = c(gzip_file = "_FILE_PATH_", SampleName = "_SampleName_"), 
                      rm_targets_col = "FileName", 
                      dependency = "gzip")

## -------------------------------------------------------------------------------------------------
sal

## ----targetsWF_3, eval=TRUE-----------------------------------------------------------------------
targetsWF(sal['gunzip'])

## ----outfiles_2, eval=TRUE------------------------------------------------------------------------
outfiles(sal['gunzip'])

## ----eval=TRUE------------------------------------------------------------------------------------
cmdlist(sal["gunzip"], targets = 1)

## ----getColumn, eval=TRUE-------------------------------------------------------------------------
getColumn(sal, step = "gunzip", 'outfiles')

## ----iris_stats, eval=TRUE------------------------------------------------------------------------
appendStep(sal) <- LineWise(code = {
                    df <- lapply(getColumn(sal, step = "gunzip", 'outfiles'), function(x) read.delim(x, sep = ",")[-1])
                    df <- do.call(rbind, df)
                    stats <- data.frame(cbind(mean = apply(df[,1:4], 2, mean), sd = apply(df[,1:4], 2, sd)))
                    stats$size <- rownames(stats)
                    
                    plot <- ggplot2::ggplot(stats, ggplot2::aes(x = size, y = mean, fill = size)) + 
                      ggplot2::geom_bar(stat = "identity", color = "black", position = ggplot2::position_dodge()) +
                      ggplot2::geom_errorbar(ggplot2::aes(ymin = mean-sd, ymax = mean+sd), width = .2, position = ggplot2::position_dodge(.9)) 
                    },
                    step_name = "iris_stats", 
                    dependency = "gzip")

## -------------------------------------------------------------------------------------------------
sal

## ----importWF_rmd, eval=TRUE----------------------------------------------------------------------
sal_rmd <- SPRproject(logs.dir = ".SPRproject_rmd") 

sal_rmd <- importWF(sal_rmd, 
                file_path = system.file("extdata", "spr_simple_wf.Rmd", package = "systemPipeR"))

## ----importWF_details, eval=FALSE-----------------------------------------------------------------
# sal_rmd
# stepsWF(sal_rmd)
# dependency(sal_rmd)
# cmdlist(sal_rmd)
# codeLine(sal_rmd)
# targetsWF(sal_rmd)
# statusWF(sal_rmd)

## ----fromFile_example_rules_cmd, eval=FALSE-------------------------------------------------------
# targetspath <- system.file("extdata/cwl/example/targets_example.txt", package = "systemPipeR")
# appendStep(sal) <- SYSargsList(step_name = "Example",
#                       targets = targetspath,
#                       wf_file = "example/example.cwl", input_file = "example/example.yml",
#                       dir_path = system.file("extdata/cwl", package = "systemPipeR"),
#                       inputvars = c(Message = "_STRING_", SampleName = "_SAMPLE_"))

## ----fromFile_example_rules_r, eval=FALSE---------------------------------------------------------
# appendStep(sal) <- LineWise(code = {
#                               library(systemPipeR)
#                             },
#                             step_name = "load_lib")

## ----runWF, eval=is_win---------------------------------------------------------------------------
sal <- runWF(sal)

## ----runWF_error, eval=FALSE----------------------------------------------------------------------
# sal <- runWF(sal, steps = c(1,3))

## ----runWF_force, eval=FALSE----------------------------------------------------------------------
# sal <- runWF(sal, force = TRUE, warning.stop = FALSE, error.stop = TRUE)

## ----runWF_env, eval=FALSE------------------------------------------------------------------------
# viewEnvir(sal)

## ----runWF_saveenv, eval=FALSE--------------------------------------------------------------------
# sal <- runWF(sal, saveEnv = TRUE)

## ----show_statusWF_details1, eval=TRUE------------------------------------------------------------
sal

## ----show_statusWF_details2, eval=FALSE-----------------------------------------------------------
# stepsWF(sal)
# dependency(sal)
# cmdlist(sal)
# codeLine(sal)
# targetsWF(sal)
# statusWF(sal)
# projectInfo(sal)

## ----save_sal, eval=FALSE-------------------------------------------------------------------------
# sal <- write_SYSargsList(sal)

## ----module_cmds, eval=FALSE----------------------------------------------------------------------
# module(action_type="load", module_name="hisat2")
# moduleload("hisat2") # alternative command
# moduleunload("hisat2")
# modulelist() # list software loaded into current session
# moduleAvail() # list all software available in module system

## ----list_module, eval=FALSE----------------------------------------------------------------------
# listCmdModules(sal)
# listCmdTools(sal)

## ----runWF_cluster, eval=FALSE--------------------------------------------------------------------
# resources <- list(conffile=".batchtools.conf.R",
#                   template="batchtools.slurm.tmpl",
#                   Njobs=18,
#                   walltime=120, ## in minutes
#                   ntasks=1,
#                   ncpus=4,
#                   memory=1024, ## in Mb
#                   partition = "short"
#                   )
# sal <- addResources(sal, step=c("hisat2_mapping"), resources = resources)
# sal <- runWF(sal)

## ----eval=TRUE------------------------------------------------------------------------------------
plotWF(sal, show_legend = TRUE, width = "80%", rstudio = TRUE)

## ----eval=FALSE-----------------------------------------------------------------------------------
# sal <- renderReport(sal)
# 
# rmarkdown::render("my.Rmd", clean = TRUE, output_format = "BiocStyle::html_document")

## ----eval=FALSE-----------------------------------------------------------------------------------
# sal <- renderLogs(sal)

## ----eval=FALSE-----------------------------------------------------------------------------------
# sal2rmd(sal)

## ----eval=FALSE-----------------------------------------------------------------------------------
# sal2bash(sal)

## ----SPR_resume, eval=FALSE-----------------------------------------------------------------------
# sal <- SPRproject(resume = TRUE)

## ----resume_load, eval=FALSE----------------------------------------------------------------------
# sal <- SPRproject(resume = TRUE, load.envir = TRUE)

## ----envir, eval=FALSE----------------------------------------------------------------------------
# viewEnvir(sal)
# copyEnvir(sal, list="plot", new.env = globalenv())

## ----restart_load, eval=FALSE---------------------------------------------------------------------
# sal <- SPRproject(restart = TRUE)

## ----SPR_overwrite, eval=FALSE--------------------------------------------------------------------
# sal <- SPRproject(overwrite = TRUE)

## -------------------------------------------------------------------------------------------------
length(sal)

## -------------------------------------------------------------------------------------------------
stepName(sal)

## -------------------------------------------------------------------------------------------------
listCmdTools(sal)

## -------------------------------------------------------------------------------------------------
listCmdModules(sal)
modules(stepsWF(sal)$gzip)

## -------------------------------------------------------------------------------------------------
names(sal)

## -------------------------------------------------------------------------------------------------
stepsWF(sal)

## -------------------------------------------------------------------------------------------------
names(stepsWF(sal)$gzip)

## -------------------------------------------------------------------------------------------------
statusWF(sal)

## -------------------------------------------------------------------------------------------------
targetsWF(sal[2])

## ----eval=FALSE-----------------------------------------------------------------------------------
# targetsheader(sal, step = "Quality")

## -------------------------------------------------------------------------------------------------
outfiles(sal[2])

## -------------------------------------------------------------------------------------------------
dependency(sal)

## -------------------------------------------------------------------------------------------------
SampleName(sal, step = "gzip")

## -------------------------------------------------------------------------------------------------
getColumn(sal, "outfiles", step = "gzip", column = "gzip_file")
getColumn(sal, "targetsWF", step = "gzip", column = "FileName")

## -------------------------------------------------------------------------------------------------
yamlinput(sal, step = "gzip")

## -------------------------------------------------------------------------------------------------
cmdlist(sal, step = c(2,3), targets = 1)

## -------------------------------------------------------------------------------------------------
codeLine(sal, step = "export_iris")

## -------------------------------------------------------------------------------------------------
viewEnvir(sal)

## -------------------------------------------------------------------------------------------------
copyEnvir(sal, list = c("plot"), new.env = globalenv(), silent = FALSE)

## -------------------------------------------------------------------------------------------------
length(sal)
sal[1:2]

## ----eval=FALSE-----------------------------------------------------------------------------------
# sal_sub <- subset(sal, subset_steps = c(2,3), input_targets = c("SE", "VE"), keep_steps = TRUE)
# stepsWF(sal_sub)
# targetsWF(sal_sub)
# outfiles(sal_sub)

## ----eval=FALSE-----------------------------------------------------------------------------------
# sal[1] + sal[2] + sal[3]

## ----eval=TRUE------------------------------------------------------------------------------------
## create a copy of sal for testing
sal_c <- sal
## view original value, here restricted to 'ext' slot
yamlinput(sal_c, step = "gzip")$ext
## Replace value under 'ext' 
yamlinput(sal_c, step = "gzip", paramName = "ext") <- "txt.gz"
## view modified value, here restricted to 'ext' slot
yamlinput(sal_c, step = "gzip")$ext
## Evaluate resulting CL call
cmdlist(sal_c, step = "gzip", targets = 1)

## ----sal_lw_rep, eval=TRUE------------------------------------------------------------------------
appendCodeLine(sal_c, step = "export_iris", after = 1) <- "log_cal_100 <- log(100)"
codeLine(sal_c, step = "export_iris")

## ----sal_lw_rep2, eval=TRUE-----------------------------------------------------------------------
replaceCodeLine(sal_c, step="export_iris", line = 2) <- LineWise(code={
                    log_cal_100 <- log(50)
                    })
codeLine(sal_c, step = "export_iris")

## -------------------------------------------------------------------------------------------------
renameStep(sal_c, c(1, 2)) <- c("newStep2", "newIndex")
sal_c
names(outfiles(sal_c))
names(targetsWF(sal_c))
dependency(sal_c)

## ----eval=FALSE-----------------------------------------------------------------------------------
# sal_test <- sal[c(1,2)]
# replaceStep(sal_test, step = 1, step_name = "gunzip" ) <- sal[3]
# sal_test

## -------------------------------------------------------------------------------------------------
sal_test <- sal[-2]
sal_test

## -------------------------------------------------------------------------------------------------
dir_path <- system.file("extdata/cwl", package = "systemPipeR")
cwl <- yaml::read_yaml(file.path(dir_path, "example/example.cwl"))

## -------------------------------------------------------------------------------------------------
cwl[1:2]

## -------------------------------------------------------------------------------------------------
cwl[3]

## -------------------------------------------------------------------------------------------------
cwl[4]

## -------------------------------------------------------------------------------------------------
cwl[5]

## -------------------------------------------------------------------------------------------------
cwl[6]

## -------------------------------------------------------------------------------------------------
cwl.wf <- yaml::read_yaml(file.path(dir_path, "example/workflow_example.cwl"))

## -------------------------------------------------------------------------------------------------
cwl.wf[1:2]

## -------------------------------------------------------------------------------------------------
cwl.wf[3]

## -------------------------------------------------------------------------------------------------
cwl.wf[4]

## -------------------------------------------------------------------------------------------------
cwl.wf[5]

## -------------------------------------------------------------------------------------------------
yaml::read_yaml(file.path(dir_path, "example/example_single.yml"))

## ----fromFile, eval=TRUE--------------------------------------------------------------------------
HW <- SYSargsList(wf_file = "example/workflow_example.cwl", 
                  input_file = "example/example_single.yml", 
                  dir_path = system.file("extdata/cwl", package = "systemPipeR"))
HW
cmdlist(HW)

## -------------------------------------------------------------------------------------------------
yml <- yaml::read_yaml(file.path(dir_path, "example/example.yml"))
yml

## -------------------------------------------------------------------------------------------------
targetspath <- system.file("extdata/cwl/example/targets_example.txt", package = "systemPipeR")
read.delim(targetspath, comment.char = "#")

## ----fromFile_example, eval=TRUE------------------------------------------------------------------
HW_mul <- SYSargsList(step_name = "echo", 
                      targets=targetspath, 
                      wf_file="example/workflow_example.cwl", input_file="example/example.yml", 
                      dir_path = dir_path, 
                      inputvars = c(Message = "_STRING_", SampleName = "_SAMPLE_"))
HW_mul

## ----fromFile_example2, eval=TRUE-----------------------------------------------------------------
cmdlist(HW_mul)

## ----cmd_orig, eval=FALSE-------------------------------------------------------------------------
# hisat2 -S ./results/M1A.sam -x ./data/tair10.fasta -k 1 -min-intronlen 30 -max-intronlen 3000 -threads 4 -U ./data/SRR446027_1.fastq.gz

## ----cmd, eval=TRUE-------------------------------------------------------------------------------
command <- "
    hisat2 \
    -S <F, out: ./results/M1A.sam> \
    -x <F: ./data/tair10.fasta> \
    -k <int: 1> \
    -min-intronlen <int: 30> \
    -max-intronlen <int: 3000> \
    -threads <int: 4> \
    -U <F: ./data/SRR446027_1.fastq.gz>
"

## -------------------------------------------------------------------------------------------------
cmd <- createParam(command, writeParamFiles = TRUE, overwrite=TRUE, confirm=TRUE) 

## -------------------------------------------------------------------------------------------------
cmdlist(cmd)

## ----saving, eval=FALSE---------------------------------------------------------------------------
# writeParamFiles(cmd, overwrite = TRUE)

## ----sysargs2, eval=TRUE, results="hide"----------------------------------------------------------
command2 <- "
    hisat2 \
    -S <F, out: _SampleName_.sam> \
    -x <F: ./data/tair10.fasta> \
    -k <int: 1> \
    -min-intronlen <int: 30> \
    -max-intronlen <int: 3000> \
    -threads <int: 4> \
    -U <F: _FASTQ_PATH1_>
"
WF <- createParam(command2, overwrite = TRUE, writeParamFiles = TRUE, confirm = TRUE) 
targetspath <- system.file("extdata", "targets.txt", package = "systemPipeR")
WF_test <- loadWorkflow(targets = targetspath, wf_file="hisat2.cwl",
                   input_file="hisat2.yml", dir_path = "param/cwl/hisat2/")
WF_test <- renderWF(WF_test, inputvars = c(FileName = "_FASTQ_PATH1_", SampleName= "_SampleName_"))

## ----sysargs2b, eval=TRUE-------------------------------------------------------------------------
WF_test
cmdlist(WF_test)[1:2]

## ----eval=FALSE-----------------------------------------------------------------------------------
# printParam(cmd, position = "baseCommand") ## Return baseCommand
# printParam(cmd, position = "outputs") ## Return outputs
# printParam(cmd, position = "inputs", index = 1:2) ## Return components by index
# printParam(cmd, position = "inputs", index = -1:-2) ## Negative index subsetting

## ----eval=FALSE-----------------------------------------------------------------------------------
# cmd2 <- subsetParam(cmd, position = "inputs", index = 1:2, trim = TRUE)
# cmdlist(cmd2)
# 
# cmd2 <- subsetParam(cmd, position = "inputs", index = c("S", "x"), trim = TRUE)
# cmdlist(cmd2)

## ----eval=FALSE-----------------------------------------------------------------------------------
# cmd3 <- replaceParam(cmd, "base", index = 1, replace = list(baseCommand = "bwa"))
# cmdlist(cmd3) ## Replacement changed baseCommand

## ----eval=FALSE-----------------------------------------------------------------------------------
# new_inputs <- new_inputs <- list(
#     "new_input1" = list(type = "File", preF="-b", yml ="myfile"),
#     "new_input2" = "-L <int: 4>"
# )
# cmd4 <- replaceParam(cmd, "inputs", index = 1:2, replace = new_inputs)
# cmdlist(cmd4)

## ----eval=FALSE-----------------------------------------------------------------------------------
# newIn <- new_inputs <- list(
#     "new_input1" = list(type = "File", preF="-b1", yml ="myfile1"),
#     "new_input2" = list(type = "File", preF="-b2", yml ="myfile2"),
#     "new_input3" = "-b3 <F: myfile3>"
# )
# cmd5 <- appendParam(cmd, "inputs", index = 1:2, append = new_inputs)
# cmdlist(cmd5)
# 
# cmd6 <- appendParam(cmd, "inputs", index = 1:2, after=0, append = new_inputs)
# cmdlist(cmd6)

## ----eval=FALSE-----------------------------------------------------------------------------------
# new_outs <- list(
#     "sam_out" = "<F: $(inputs.results_path)/test.sam>"
# )
# cmd7 <- replaceParam(cmd, "outputs", index = 1, replace = new_outs)
# output(cmd7)

## ----SYSargs2_structure, eval=TRUE----------------------------------------------------------------
library(systemPipeR)
targetspath <- system.file("extdata", "targets.txt", package = "systemPipeR")
dir_path <- system.file("extdata/cwl", package = "systemPipeR")
WF <- loadWF(targets = targetspath, wf_file = "hisat2/hisat2-mapping-se.cwl",
                   input_file = "hisat2/hisat2-mapping-se.yml",
                   dir_path = dir_path)

WF <- renderWF(WF, inputvars = c(FileName = "_FASTQ_PATH1_", 
                                 SampleName = "_SampleName_"))

## ----cmdlist, eval=TRUE---------------------------------------------------------------------------
cmdlist(WF)[1]

## ----names_WF, eval=TRUE--------------------------------------------------------------------------
names(WF)

## ----output_WF, eval=TRUE-------------------------------------------------------------------------
output(WF)[1]

## ----targets_WF, eval=TRUE------------------------------------------------------------------------
targets(WF)[1]
as(WF, "DataFrame")

## ----module_WF, eval=TRUE-------------------------------------------------------------------------
modules(WF)

## ----other_WF, eval=FALSE-------------------------------------------------------------------------
# files(WF)
# inputvars(WF)

## ----lw, eval=TRUE--------------------------------------------------------------------------------
rmd <- system.file("extdata", "spr_simple_lw.Rmd", package = "systemPipeR")
sal_lw <- SPRproject(overwrite = TRUE)
sal_lw <- importWF(sal_lw, rmd, verbose = FALSE)
codeLine(sal_lw)

## ----lw_coerce, eval=TRUE-------------------------------------------------------------------------
lw <- stepsWF(sal_lw)[[2]]
## Coerce
ll <- as(lw, "list")
class(ll)
lw <- as(ll, "LineWise")
lw

## ----lw_access, eval=TRUE-------------------------------------------------------------------------
length(lw)
names(lw)
codeLine(lw)
codeChunkStart(lw)
rmdPath(lw)

## ----lw_sub, eval=TRUE----------------------------------------------------------------------------
l <- lw[2]
codeLine(l)
l_sub <- lw[-2]
codeLine(l_sub)

## ----lw_rep, eval=TRUE----------------------------------------------------------------------------
replaceCodeLine(lw, line = 2) <- "5+5"
codeLine(lw)
appendCodeLine(lw, after = 0) <- "6+7"
codeLine(lw)

## ----sal_rep_append, eval=FALSE-------------------------------------------------------------------
# replaceCodeLine(sal_lw, step = 2, line = 2) <- LineWise(code={
#                                                              "5+5"
#                                                                 })
# codeLine(sal_lw, step = 2)
# 
# appendCodeLine(sal_lw, step = 2) <- "66+55"
# codeLine(sal_lw, step = 2)
# 
# appendCodeLine(sal_lw, step = 1, after = 1) <- "66+55"
# codeLine(sal_lw, step = 1)

## ----table_tools, echo=FALSE, message=FALSE-------------------------------------------------------
library(magrittr)
SPR_software <- system.file("extdata", "SPR_software.csv", package = "systemPipeR")
software <- read.delim(SPR_software, sep = ",", comment.char = "#")
colors <- colorRampPalette((c("darkseagreen", "indianred1")))(length(unique(software$Category)))
id <- as.numeric(c((unique(software$Category))))
software %>%
  dplyr::mutate(Step = kableExtra::cell_spec(Step, color = "white", bold = TRUE,
   background = factor(Category, id, colors))) %>%
   dplyr::select(Tool, Step, Description) %>%
   dplyr::arrange(Tool) %>% 
  kableExtra::kable("html", escape = FALSE, col.names = c("Tool Name", "Description", "Step")) %>%
    kableExtra::kable_material(c("striped", "hover", "condensed")) %>%
    kableExtra::scroll_box(width = "80%", height = "500px")

## ----cleaning3, eval=TRUE, include=FALSE----------------------------------------------------------
if (file.exists(".SPRproject")) unlink(".SPRproject", recursive = TRUE)
## NOTE: Removing previous project create in the quick starts section

## ----SPRproject2, eval=FALSE----------------------------------------------------------------------
# sal <- SPRproject(projPath = getwd(), overwrite = TRUE)

## ----load_SPR, message=FALSE, eval=FALSE, spr=TRUE------------------------------------------------
# appendStep(sal) <- LineWise({
#                             library(systemPipeR)
#                             },
#                             step_name = "load_SPR")

## ----preprocessing, message=FALSE, eval=FALSE, spr=TRUE-------------------------------------------
# targetspath <- system.file("extdata", "targetsPE.txt", package = "systemPipeR")
# appendStep(sal) <- SYSargsList(
#     step_name = "preprocessing",
#     targets = targetspath, dir = TRUE,
#     wf_file = "preprocessReads/preprocessReads-pe.cwl",
#     input_file = "preprocessReads/preprocessReads-pe.yml",
#     dir_path = system.file("extdata/cwl", package = "systemPipeR"),
#     inputvars = c(
#         FileName1 = "_FASTQ_PATH1_",
#         FileName2 = "_FASTQ_PATH2_",
#         SampleName = "_SampleName_"
#     ),
#     dependency = c("load_SPR"))

## ----custom_preprocessing_function, eval=FALSE----------------------------------------------------
# appendStep(sal) <- LineWise(
#     code = {
#         filterFct <- function(fq, cutoff = 20, Nexceptions = 0) {
#             qcount <- rowSums(as(quality(fq), "matrix") <= cutoff, na.rm = TRUE)
#             # Retains reads where Phred scores are >= cutoff with N exceptions
#             fq[qcount <= Nexceptions]
#         }
#         save(list = ls(), file = "param/customFCT.RData")
#     },
#     step_name = "custom_preprocessing_function",
#     dependency = "preprocessing"
# )

## ----editing_preprocessing, message=FALSE, eval=FALSE---------------------------------------------
# yamlinput(sal, "preprocessing")$Fct
# yamlinput(sal, "preprocessing", "Fct") <- "'filterFct(fq, cutoff=20, Nexceptions=0)'"
# yamlinput(sal, "preprocessing")$Fct ## check the new function
# cmdlist(sal, "preprocessing", targets = 1) ## check if the command line was updated with success

## ----trimGalore, eval=FALSE, spr=TRUE-------------------------------------------------------------
# targetspath <- system.file("extdata", "targets.txt", package = "systemPipeR")
# appendStep(sal) <- SYSargsList(step_name = "trimGalore",
#                                targets = targetspath, dir = TRUE,
#                                wf_file = "trim_galore/trim_galore-se.cwl",
#                                input_file = "trim_galore/trim_galore-se.yml",
#                                dir_path = system.file("extdata/cwl", package = "systemPipeR"),
#                                inputvars = c(FileName = "_FASTQ_PATH1_", SampleName = "_SampleName_"),
#                                dependency = "load_SPR",
#                                run_step = "optional")

## ----trimmomatic, eval=FALSE, spr=TRUE------------------------------------------------------------
# targetspath <- system.file("extdata", "targets.txt", package = "systemPipeR")
# appendStep(sal) <- SYSargsList(step_name = "trimmomatic",
#                                targets = targetspath, dir = TRUE,
#                                wf_file = "trimmomatic/trimmomatic-se.cwl",
#                                input_file = "trimmomatic/trimmomatic-se.yml",
#                                dir_path = system.file("extdata/cwl", package = "systemPipeR"),
#                                inputvars = c(FileName = "_FASTQ_PATH1_", SampleName = "_SampleName_"),
#                                dependency = "load_SPR",
#                                run_step = "optional")

## ----fastq_report, eval=FALSE, message=FALSE, spr=TRUE--------------------------------------------
# appendStep(sal) <- LineWise(code = {
#                 fastq <- getColumn(sal, step = "preprocessing", "targetsWF", column = 1)
#                 fqlist <- seeFastq(fastq = fastq, batchsize = 10000, klength = 8)
#                 pdf("./results/fastqReport.pdf", height = 18, width = 4*length(fqlist))
#                 seeFastqPlot(fqlist)
#                 dev.off()
#                 }, step_name = "fastq_report",
#                 dependency = "preprocessing")

## ----hisat_index, eval=FALSE, spr=TRUE------------------------------------------------------------
# appendStep(sal) <- SYSargsList(step_name = "hisat_index",
#                                targets = NULL, dir = FALSE,
#                                wf_file = "hisat2/hisat2-index.cwl",
#                                input_file = "hisat2/hisat2-index.yml",
#                                dir_path = system.file("extdata/cwl", package = "systemPipeR"),
#                                inputvars = NULL,
#                                dependency = "preprocessing")

## ----hisat_mapping_samtools, eval=FALSE, spr=TRUE-------------------------------------------------
# appendStep(sal) <- SYSargsList(step_name = "hisat_mapping",
#                                targets = "preprocessing", dir = TRUE,
#                                wf_file = "workflow-hisat2/workflow_hisat2-se.cwl",
#                                input_file = "workflow-hisat2/workflow_hisat2-se.yml",
#                                dir_path = system.file("extdata/cwl", package = "systemPipeR"),
#                                inputvars=c(FileName1="_FASTQ_PATH1_", SampleName="_SampleName_"),
#                                dependency = c("hisat_index"),
#                                run_session = "compute")

## ----bowtie_index, eval=FALSE, spr=TRUE-----------------------------------------------------------
# appendStep(sal) <- SYSargsList(step_name = "bowtie_index",
#                                targets = NULL, dir = FALSE,
#                                wf_file = "bowtie2/bowtie2-index.cwl",
#                                input_file = "bowtie2/bowtie2-index.yml",
#                                dir_path = system.file("extdata/cwl", package = "systemPipeR"),
#                                inputvars = NULL,
#                                dependency = "preprocessing",
#                                run_step = "optional")

## ----tophat2_mapping, eval=FALSE, spr=TRUE--------------------------------------------------------
# appendStep(sal) <- SYSargsList(step_name = "tophat2_mapping",
#                                targets = "preprocessing", dir = TRUE,
#                                wf_file = "tophat2/workflow_tophat2-mapping-se.cwl",
#                                input_file = "tophat2/tophat2-mapping-se.yml",
#                                dir_path = system.file("extdata/cwl", package = "systemPipeR"),
#                                inputvars=c(preprocessReads_se="_FASTQ_PATH1_", SampleName="_SampleName_"),
#                                dependency = c("bowtie_index"),
#                                run_session = "remote",
#                                run_step = "optional")

## ----bowtie2_mapping, eval=FALSE, spr=TRUE--------------------------------------------------------
# appendStep(sal) <- SYSargsList(step_name = "bowtie2_mapping",
#                                targets = "preprocessing", dir = TRUE,
#                                wf_file = "bowtie2/workflow_bowtie2-mapping-se.cwl",
#                                input_file = "bowtie2/bowtie2-mapping-se.yml",
#                                dir_path = system.file("extdata/cwl", package = "systemPipeR"),
#                                inputvars=c(preprocessReads_se="_FASTQ_PATH1_", SampleName="_SampleName_"),
#                                dependency = c("bowtie_index"),
#                                run_session = "remote",
#                                run_step = "optional")

## ----bwa_index, eval=FALSE, spr=TRUE--------------------------------------------------------------
# appendStep(sal) <- SYSargsList(step_name = "bwa_index",
#                                targets = NULL, dir = FALSE,
#                                wf_file = "bwa/bwa-index.cwl",
#                                input_file = "bwa/bwa-index.yml",
#                                dir_path = system.file("extdata/cwl", package = "systemPipeR"),
#                                inputvars = NULL,
#                                dependency = "preprocessing",
#                                run_step = "optional")

## ----bwa_mapping, eval=FALSE, spr=TRUE------------------------------------------------------------
# appendStep(sal) <- SYSargsList(step_name = "bwa_mapping",
#                                targets = "preprocessing", dir = TRUE,
#                                wf_file = "bwa/bwa-se.cwl",
#                                input_file = "bwa/bwa-se.yml",
#                                dir_path = system.file("extdata/cwl", package = "systemPipeR"),
#                                inputvars=c(preprocessReads_se="_FASTQ_PATH1_", SampleName="_SampleName_"),
#                                dependency = c("bwa_index"),
#                                run_session = "remote",
#                                run_step = "optional")

## ----rsubread_index, eval=FALSE, spr=TRUE---------------------------------------------------------
# appendStep(sal) <- SYSargsList(step_name = "rsubread_index",
#                                targets = NULL, dir = FALSE,
#                                wf_file = "rsubread/rsubread-index.cwl",
#                                input_file = "rsubread/rsubread-index.yml",
#                                dir_path = system.file("extdata/cwl", package = "systemPipeR"),
#                                inputvars = NULL,
#                                dependency = "preprocessing",
#                                run_step = "optional")

## ----rsubread_mapping, eval=FALSE, spr=TRUE-------------------------------------------------------
# appendStep(sal) <- SYSargsList(step_name = "rsubread",
#                                targets = "preprocessing", dir = TRUE,
#                                wf_file = "rsubread/rsubread-mapping-se.cwl",
#                                input_file = "rsubread/rsubread-mapping-se.yml",
#                                dir_path = system.file("extdata/cwl", package = "systemPipeR"),
#                                inputvars=c(FileName1="_FASTQ_PATH1_", SampleName="_SampleName_"),
#                                dependency = c("rsubread_index"),
#                                run_session = "compute",
#                                run_step = "optional")

## ----gsnap_index, eval=FALSE, spr=TRUE------------------------------------------------------------
# appendStep(sal) <- SYSargsList(step_name = "gsnap_index",
#                                targets = NULL, dir = FALSE,
#                                wf_file = "gsnap/gsnap-index.cwl",
#                                input_file = "gsnap/gsnap-index.yml",
#                                dir_path = system.file("extdata/cwl", package = "systemPipeR"),
#                                inputvars = NULL,
#                                dependency = "preprocessing",
#                                run_step = "optional")

## ----gsnap_mapping, eval=FALSE, spr=TRUE----------------------------------------------------------
# appendStep(sal) <- SYSargsList(step_name = "gsnap",
#                                targets = "targetsPE.txt", dir = TRUE,
#                                wf_file = "gsnap/gsnap-mapping-pe.cwl",
#                                input_file = "gsnap/gsnap-mapping-pe.yml",
#                                dir_path = system.file("extdata/cwl", package = "systemPipeR"),
#                                 inputvars = c(FileName1 = "_FASTQ_PATH1_",
#                                               FileName2 = "_FASTQ_PATH2_", SampleName = "_SampleName_"),
#                                dependency = c("gsnap_index"),
#                                run_session = "remote",
#                                run_step = "optional")

## ----bam_IGV, eval=FALSE, spr=TRUE----------------------------------------------------------------
# appendStep(sal) <- LineWise(
#     code = {
#         bampaths <- getColumn(sal, step = "hisat2_mapping", "outfiles",
#                   column = "samtools_sort_bam")
#         symLink2bam(
#             sysargs = bampaths, htmldir = c("~/.html/", "somedir/"),
#             urlbase = "https://cluster.hpcc.ucr.edu/<username>/",
#             urlfile = "./results/IGVurl.txt")
#     },
#     step_name = "bam_IGV",
#     dependency = "hisat_mapping",
#     run_step = "optional"
# )

## ----create_txdb, message=FALSE, eval=FALSE, spr=TRUE---------------------------------------------
# appendStep(sal) <- LineWise(code = {
#                             library(txdbmaker)
#                             txdb <- makeTxDbFromGFF(file="data/tair10.gff", format="gff",
#                                                     dataSource="TAIR", organism="Arabidopsis thaliana")
#                             saveDb(txdb, file="./data/tair10.sqlite")
#                             },
#                             step_name = "create_txdb",
#                             dependency = "hisat_mapping")

## ----read_counting, message=FALSE, eval=FALSE, spr=TRUE-------------------------------------------
# appendStep(sal) <- LineWise({
#                             library(BiocParallel)
#                             txdb <- loadDb("./data/tair10.sqlite")
#                             eByg <- exonsBy(txdb, by="gene")
#                             outpaths <- getColumn(sal, step = "hisat_mapping", 'outfiles', column = 2)
#                             bfl <- BamFileList(outpaths, yieldSize=50000, index=character())
#                             multicoreParam <- MulticoreParam(workers=4); register(multicoreParam); registered()
#                             counteByg <- bplapply(bfl, function(x) summarizeOverlaps(eByg, x, mode="Union",
#                                                                                      ignore.strand=TRUE,
#                                                                                      inter.feature=TRUE,
#                                                                                      singleEnd=TRUE))
#                             # Note: for strand-specific RNA-Seq set 'ignore.strand=FALSE' and for PE data set 'singleEnd=FALSE'
#                             countDFeByg <- sapply(seq(along=counteByg),
#                                                   function(x) assays(counteByg[[x]])$counts)
#                             rownames(countDFeByg) <- names(rowRanges(counteByg[[1]]))
#                             colnames(countDFeByg) <- names(bfl)
#                             rpkmDFeByg <- apply(countDFeByg, 2, function(x) returnRPKM(counts=x, ranges=eByg))
#                             write.table(countDFeByg, "results/countDFeByg.xls",
#                                         col.names=NA, quote=FALSE, sep="\t")
#                             write.table(rpkmDFeByg, "results/rpkmDFeByg.xls",
#                                         col.names=NA, quote=FALSE, sep="\t")
#                             },
#                             step_name = "read_counting",
#                             dependency = "create_txdb")

## ----align_stats, message=FALSE, eval=FALSE, spr=TRUE---------------------------------------------
# appendStep(sal) <- LineWise({
#                             read_statsDF <- alignStats(args)
#                             write.table(read_statsDF, "results/alignStats.xls",
#                                         row.names = FALSE, quote = FALSE, sep = "\t")
#                             },
#                             step_name = "align_stats",
#                             dependency = "hisat_mapping")

## ----align_stats2, eval=TRUE----------------------------------------------------------------------
read.table(system.file("extdata", "alignStats.xls", package = "systemPipeR"), header = TRUE)[1:4,]

## ----read_counting_mirna, message=FALSE, eval=FALSE, spr=TRUE-------------------------------------
# appendStep(sal) <- LineWise({
#                             system("wget https://www.mirbase.org/download/ath.gff3 -P ./data/")
#                             gff <- rtracklayer::import.gff("./data/ath.gff3")
#                             gff <- split(gff, elementMetadata(gff)$ID)
#                             bams <- getColumn(sal, step = "bowtie2_mapping", 'outfiles', column = 2)
#                             bfl <- BamFileList(bams, yieldSize=50000, index=character())
#                             countDFmiR <- summarizeOverlaps(gff, bfl, mode="Union",
#                                                             ignore.strand = FALSE, inter.feature = FALSE)
#                             countDFmiR <- assays(countDFmiR)$counts
#                             # Note: inter.feature=FALSE important since pre and mature miRNA ranges overlap
#                             rpkmDFmiR <- apply(countDFmiR, 2, function(x) returnRPKM(counts = x, ranges = gff))
#                             write.table(assays(countDFmiR)$counts, "results/countDFmiR.xls",
#                                         col.names=NA, quote=FALSE, sep="\t")
#                             write.table(rpkmDFmiR, "results/rpkmDFmiR.xls", col.names=NA, quote=FALSE, sep="\t")
#                             },
#                             step_name = "read_counting_mirna",
#                             dependency = "bowtie2_mapping")

## ----sample_tree_rlog, message=FALSE, eval=FALSE, spr=TRUE----------------------------------------
# appendStep(sal) <- LineWise({
#                             library(DESeq2, warn.conflicts=FALSE, quietly=TRUE)
#                             library(ape, warn.conflicts=FALSE)
#                             countDFpath <- system.file("extdata", "countDFeByg.xls", package="systemPipeR")
#                             countDF <- as.matrix(read.table(countDFpath))
#                             colData <- data.frame(row.names = targetsWF(sal)[[2]]$SampleName,
#                                                   condition=targetsWF(sal)[[2]]$Factor)
#                             dds <- DESeqDataSetFromMatrix(countData = countDF, colData = colData,
#                                                           design = ~ condition)
#                             d <- cor(assay(rlog(dds)), method = "spearman")
#                             hc <- hclust(dist(1-d))
#                             plot.phylo(as.phylo(hc), type = "p", edge.col = 4, edge.width = 3,
#                                        show.node.label = TRUE, no.margin = TRUE)
#                             },
#                             step_name = "sample_tree_rlog",
#                             dependency = "read_counting")

## ----edger, message=FALSE, eval=FALSE, spr=TRUE---------------------------------------------------
# appendStep(sal) <- LineWise({
#                             targetspath <- system.file("extdata", "targets.txt", package = "systemPipeR")
#                             targets <- read.delim(targetspath, comment = "#")
#                             cmp <- readComp(file = targetspath, format = "matrix", delim = "-")
#                             countDFeBygpath <- system.file("extdata", "countDFeByg.xls", package = "systemPipeR")
#                             countDFeByg <- read.delim(countDFeBygpath, row.names = 1)
#                             edgeDF <- run_edgeR(countDF = countDFeByg, targets = targets, cmp = cmp[[1]],
#                                                 independent = FALSE, mdsplot = "")
#                             DEG_list <- filterDEGs(degDF = edgeDF, filter = c(Fold = 2, FDR = 10))
#                             },
#                             step_name = "edger",
#                             dependency = "read_counting")

## ----deseq2, message=FALSE, eval=FALSE, spr=TRUE--------------------------------------------------
# appendStep(sal) <- LineWise({
#                             degseqDF <- run_DESeq2(countDF=countDFeByg, targets=targets, cmp=cmp[[1]],
#                                                    independent=FALSE)
#                             DEG_list2 <- filterDEGs(degDF=degseqDF, filter=c(Fold=2, FDR=10))
#                             },
#                             step_name = "deseq2",
#                             dependency = "read_counting")

## ----vennplot, message=FALSE, eval=FALSE, spr=TRUE------------------------------------------------
# appendStep(sal) <- LineWise({
#                             vennsetup <- overLapper(DEG_list$Up[6:9], type="vennsets")
#                             vennsetdown <- overLapper(DEG_list$Down[6:9], type="vennsets")
#                             vennPlot(list(vennsetup, vennsetdown), mymain="", mysub="",
#                                      colmode=2, ccol=c("blue", "red"))
#                             },
#                             step_name = "vennplot",
#                             dependency = "edger")

## ----get_go_biomart, message=FALSE, eval=FALSE, spr=TRUE------------------------------------------
# appendStep(sal) <- LineWise({
#                             library("biomaRt")
#                             listMarts() # To choose BioMart database
#                             listMarts(host="plants.ensembl.org")
#                             m <- useMart("plants_mart", host="https://plants.ensembl.org")
#                             listDatasets(m)
#                             m <- useMart("plants_mart", dataset="athaliana_eg_gene", host="https://plants.ensembl.org")
#                             listAttributes(m) # Choose data types you want to download
#                             go <- getBM(attributes=c("go_id", "tair_locus", "namespace_1003"), mart=m)
#                             go <- go[go[,3]!="",]; go[,3] <- as.character(go[,3])
#                             go[go[,3]=="molecular_function", 3] <- "F"
#                             go[go[,3]=="biological_process", 3] <- "P"
#                             go[go[,3]=="cellular_component", 3] <- "C"
#                             go[1:4,]
#                             dir.create("./data/GO")
#                             write.table(go, "data/GO/GOannotationsBiomart_mod.txt",
#                                         quote=FALSE, row.names=FALSE, col.names=FALSE, sep="\t")
#                             catdb <- makeCATdb(myfile="data/GO/GOannotationsBiomart_mod.txt",
#                                                lib=NULL, org="", colno=c(1,2,3), idconv=NULL)
#                             save(catdb, file="data/GO/catdb.RData")
#                             },
#                             step_name = "get_go_biomart",
#                             dependency = "edger")

## ----go_enrichment, message=FALSE, eval=FALSE, spr=TRUE-------------------------------------------
# appendStep(sal) <- LineWise({
#                             load("data/GO/catdb.RData")
#                             DEG_list <- filterDEGs(degDF=edgeDF, filter=c(Fold=2, FDR=50), plot=FALSE)
#                             up_down <- DEG_list$UporDown; names(up_down) <- paste(names(up_down), "_up_down", sep="")
#                             up <- DEG_list$Up; names(up) <- paste(names(up), "_up", sep="")
#                             down <- DEG_list$Down; names(down) <- paste(names(down), "_down", sep="")
#                             DEGlist <- c(up_down, up, down)
#                             DEGlist <- DEGlist[sapply(DEGlist, length) > 0]
#                             BatchResult <- GOCluster_Report(catdb=catdb, setlist=DEGlist, method="all",
#                                                             id_type="gene", CLSZ=2, cutoff=0.9,
#                                                             gocats=c("MF", "BP", "CC"), recordSpecGO=NULL)
#                             library("biomaRt")
#                             m <- useMart("plants_mart", dataset="athaliana_eg_gene", host="https://plants.ensembl.org")
#                             goslimvec <- as.character(getBM(attributes=c("goslim_goa_accession"), mart=m)[,1])
#                             BatchResultslim <- GOCluster_Report(catdb=catdb, setlist=DEGlist, method="slim",
#                                                                 id_type="gene", myslimv=goslimvec, CLSZ=10,
#                                                                 cutoff=0.01, gocats=c("MF", "BP", "CC"),
#                                                                 recordSpecGO=NULL)
#                             gos <- BatchResultslim[grep("M6-V6_up_down", BatchResultslim$CLID), ]
#                             gos <- BatchResultslim
#                             pdf("GOslimbarplotMF.pdf", height=8, width=10); goBarplot(gos, gocat="MF"); dev.off()
#                             goBarplot(gos, gocat="BP")
#                             goBarplot(gos, gocat="CC")
#                             },
#                             step_name = "go_enrichment",
#                             dependency = "get_go_biomart")

## ----hierarchical_clustering, message=FALSE, eval=FALSE, spr=TRUE---------------------------------
# appendStep(sal) <- LineWise({
#                             library(pheatmap)
#                             geneids <- unique(as.character(unlist(DEG_list[[1]])))
#                             y <- assay(rlog(dds))[geneids, ]
#                             pdf("heatmap1.pdf")
#                             pheatmap(y, scale="row", clustering_distance_rows="correlation",
#                                      clustering_distance_cols="correlation")
#                             dev.off()
#                             },
#                             step_name = "hierarchical_clustering",
#                             dependency = c("sample_tree_rlog", "edger"))

## ----sessionInfo----------------------------------------------------------------------------------
sessionInfo()

