Code

* Show All Code
* Hide All Code

# Generic Workflow Template

Author: FirstName LastName

#### Last update: 22 January, 2026

#### Package

systemPipeR 2.16.3

# 1 Workflow environment

This is a *Generic* workflow template for building new workflows. It is provided by
[systemPipeRdata](https://bioconductor.org/packages/devel/data/experiment/html/systemPipeRdata.html),
a companion package to [systemPipeR](https://www.bioconductor.org/packages/devel/bioc/html/systemPipeR.html) (H Backman and Girke [2016](#ref-H_Backman2016-bt)).
Similar to other `systemPipeR` workflow templates, a single command generates
the necessary working environment. This includes the expected [directory structure](https://www.bioconductor.org/packages/devel/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html#3_Directory_structure)
for executing `systemPipeR` workflows and parameter files for running
command-line (CL) software utilized in specific analysis steps.
In-depth information can be found in the main vignette of [systemPipeRdata](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeRdata.html).
The *Generic* template presented here is special that it provides a workflow
skelleton intended to be used as a starting point for building new workflows.
Basic workflow steps are included to illustrate how to design command-line (CL)
and R-based workflow steps, as well as R Markdown code chunks that are not part
of a workflow. For more comprehensive information on designing
and executing workflows, users want to refer to the main vignettes of
[systemPipeR](https://www.bioconductor.org/packages/devel/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html)
and
[systemPipeRdata](https://www.bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeRdata.html).
The details about contructing workflow steps are explained in the
[Detailed Tutorial](https://www.bioconductor.org/packages/devel/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html#5_Detailed_tutorial) section
of `systemPipeR's` main vignette that uses the same workflow steps as the *Generic* workflow template.

The `Rmd` file (`new.Rmd`) associated with this vignette serves a dual purpose.
It acts both as a template for executing the workflow and as a template for
generating a reproducible scientific analysis report. Thus, users want to
customize the text (and/or code) of this or other `systemPipeR` workflow vignettes to describe their
experimental design and analysis results. This typically involves deleting the
instructions how to work with this workflow, and customizing the text
describing experimental designs, other metadata and analysis results.

The `Generic` workflow template includes the following four data processing steps.

1. R step: export tabular data to files
2. CL step: compress files
3. CL step: uncompress files
4. R step: import files and plot summary statistics

The topology graph of this workflow template is shown in Figure 1.

![Topology graph of this workflow template.](data:image/png;base64...)

Figure 1: Topology graph of this workflow template

## 1.1 Create workflow environment

The environment of the chosen workflow is generated with the `genWorenvir`
function. After this, the user’s R session needs to be directed into the resulting directory
(here `new`).

```
systemPipeRdata::genWorkenvir(workflow = "new", mydirname = "new")
setwd("new")
```

The `SPRproject` function initializes a new workflow project instance. This function
call creates a an empty `SAL` workflow container and at the same time a
linked project log directory (default name `.SPRproject`) that acts as a flat-file
database of a workflow. For additional details, please visit this
[section](https://www.bioconductor.org/packages/devel/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html#5_Detailed_tutorial)
in `systemPipeR's` main vignette.

```
library(systemPipeR)
sal <- SPRproject()
sal
```

## 1.2 Construct workflow

This section illustrates how to load the following five workflow steps into a
`SAL` workflow container (`SYSargsList`) first one-by-one in interactive mode
(see [here](#stepwise)) or with the `importWF` command (see [here](#importwf)),
and then run the workflow with the `runWF` command.

### 1.2.1 Step 1: Load packages

Next, the `systemPipeR` package needs to be loaded in a workflow.

```
appendStep(sal) <- LineWise(code = {
    library(systemPipeR)
}, step_name = "load_library")
```

After adding the R code, sal contains now one workflow step.

```
sal
```

### 1.2.2 Step 2: Export tabular data to files

This is the first data processing step. In this case it is an R step that uses the `LineWise`
function to define the workflow step, and appends it to the `SAL` workflow container.

```
appendStep(sal) <- LineWise(code = {
    mapply(FUN = function(x, y) write.csv(x, y), x = split(iris,
        factor(iris$Species)), y = file.path("results", paste0(names(split(iris,
        factor(iris$Species))), ".csv")))
}, step_name = "export_iris", dependency = "load_library")
```

### 1.2.3 Step 3: Compress data

The following adds a CL step that uses the `gzip` software to compress the files that were
generated in the previous step.

```
targetspath <- system.file("extdata/cwl/gunzip", "targets_gunzip.txt",
    package = "systemPipeR")
appendStep(sal) <- SYSargsList(targets = targetspath, dir = TRUE,
    wf_file = "gunzip/workflow_gzip.cwl", input_file = "gunzip/gzip.yml",
    dir_path = "param/cwl", inputvars = c(FileName = "_FILE_PATH_",
        SampleName = "_SampleName_"), step_name = "gzip", dependency = "export_iris")
```

### 1.2.4 Step 4: Uncompress data

Next, the output files (here compressed `gz` files), that were generated by the
previous `gzip` step, will be uncompressed in the current step with the `gunzip`
software.

```
appendStep(sal) <- SYSargsList(targets = "gzip", dir = TRUE,
    wf_file = "gunzip/workflow_gunzip.cwl", input_file = "gunzip/gunzip.yml",
    dir_path = "param/cwl", inputvars = c(gzip_file = "_FILE_PATH_",
        SampleName = "_SampleName_"), rm_targets_col = "FileName",
    step_name = "gunzip", dependency = "gzip")
```

### 1.2.5 Step 5: Import tabular files and visualize data

Imports the tabular files from the previous step back into R, performs some summary
statistics and plots the results as bar diagrams.

```
appendStep(sal) <- LineWise(code = {
    # combine all files into one data frame
    df <- lapply(getColumn(sal, step = "gunzip", "outfiles"),
        function(x) read.delim(x, sep = ",")[-1])
    df <- do.call(rbind, df)
    # calculate mean and sd for each species
    stats <- data.frame(cbind(mean = apply(df[, 1:4], 2, mean),
        sd = apply(df[, 1:4], 2, sd)))
    stats$species <- rownames(stats)
    # plot
    plot <- ggplot2::ggplot(stats, ggplot2::aes(x = species,
        y = mean, fill = species)) + ggplot2::geom_bar(stat = "identity",
        color = "black", position = ggplot2::position_dodge()) +
        ggplot2::geom_errorbar(ggplot2::aes(ymin = mean - sd,
            ymax = mean + sd), width = 0.2, position = ggplot2::position_dodge(0.9))
    plot
}, step_name = "stats", dependency = "gunzip", run_step = "optional")
```

### 1.2.6 Version Information

```
appendStep(sal) <- LineWise(code = {
    sessionInfo()
}, step_name = "sessionInfo", dependency = "stats")
```

# 2 Automated routine

Once the above steps have been loaded into `sal`, the workflow can be executed from start to
finish (or partially) with the `runWF` command. Subsequently, scientific and technical workflow
reports can be generated with the `renderReport` and `renderLogs` functions, respectively.

The following code section also demonstrates how the above workflow steps can be imported with
the `importWF` function from the associated `Rmd` workflow script (here `new.Rmd`). Constructing
workflow instances with this automated approach is usually preferred since it is much more convenient
and reliable compared to the manual approach described earlier.

**Note:** To demonstrate the ‘systemPipeR’s’ automation routines without regenerating a new workflow
environment from scratch, the first line below uses the `overwrite=TRUE` option of the `SPRproject` function.
This option is generally discouraged as it erases the existing workflow project and `sal` container.
For information on resuming and restarting workflow runs, users want to consult the relevant section of
the main vignette (see [here](https://www.bioconductor.org/packages/devel/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html#10_Restarting_and_resetting_workflows).)

```
sal <- SPRproject(overwrite = TRUE)  # Avoid 'overwrite=TRUE' in real runs.
sal <- importWF(sal, file_path = "new.Rmd")  # Imports above steps from new.Rmd.
sal <- runWF(sal)  # Runs workflow.
plotWF(sal)  # Plots workflow topology graph
sal <- renderReport(sal)  # Renders scientific report.
sal <- renderLogs(sal)  # Renders technical report from log files.
```

## 2.1 CL tools used

The `listCmdTools` (and `listCmdModules`) return the CL tools that
are used by a workflow. To include a CL tool list in a workflow report,
one can use the following code. Additional details on this topic
can be found in the main vignette [here](https://www.bioconductor.org/packages/devel/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html#111_Accessor_methods).

```
if (file.exists(file.path(".SPRproject", "SYSargsList.yml"))) {
    local({
        sal <- systemPipeR::SPRproject(resume = TRUE)
        systemPipeR::listCmdTools(sal)
        systemPipeR::listCmdModules(sal)
    })
} else {
    cat(crayon::blue$bold("Tools and modules required by this workflow are:\n"))
    cat(c("gzip", "gunzip"), sep = "\n")
}
```

```
## Tools and modules required by this workflow are:
## gzip
## gunzip
```

## 2.2 Session Info

This is the session information that will be included when rendering this report.

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets
## [6] methods   base
##
## other attached packages:
## [1] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.39       R6_2.6.1
##  [3] codetools_0.2-20    bookdown_0.46
##  [5] fastmap_1.2.0       xfun_0.56
##  [7] cachem_1.1.0        knitr_1.51
##  [9] htmltools_0.5.9     rmarkdown_2.30
## [11] lifecycle_1.0.5     cli_3.6.5
## [13] sass_0.4.10         jquerylib_0.1.4
## [15] compiler_4.5.2      tools_4.5.2
## [17] evaluate_1.0.5      bslib_0.9.0
## [19] yaml_2.3.12         formatR_1.14
## [21] otel_0.2.0          BiocManager_1.30.27
## [23] crayon_1.5.3        jsonlite_2.0.0
## [25] rlang_1.1.7
```

# References

H Backman, Tyler W, and Thomas Girke. 2016. “systemPipeR: NGS workflow and report generation environment.” *BMC Bioinformatics* 17 (1): 388. <https://doi.org/10.1186/s12859-016-1241-0>.