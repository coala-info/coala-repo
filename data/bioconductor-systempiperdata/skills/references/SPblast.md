Code

* Show All Code
* Hide All Code

# BLAST Workflow Template

Author: FirstName LastName

#### Last update: 24 February, 2026

#### Package

systemPipeR 2.16.3

# 1 About this template

This is the BLAST workflow template of the [systemPipeRdata](https://bioconductor.org/packages/devel/data/experiment/html/systemPipeRdata.html)
package, a companion
package to [systemPipeR](https://www.bioconductor.org/packages/devel/bioc/html/systemPipeR.html) (H Backman and Girke [2016](#ref-H_Backman2016-bt)). Like other workflow
templates, it can be loaded with a single command. Users have the
flexibility to utilize the template as is or modify it as needed. More in-depth
information can be found in the main vignette of [systemPipeRdata](https://bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeRdata.html). The BLAST
workflow template serves as a starting point for conducting sequence similarity
search routines. It employs [NCBI’s BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi) software as an illustrative example,
enabling users to search a sequence database for entries that share sequence
similarity to one or multiple query sequences. The search results can be
presented in a concise tabular summary format, or the corresponding pairwise
alignments can be included. To utilize this workflow, users must download and
install the BLAST software from NCBI’s website [here](https://ftp.ncbi.nlm.nih.gov/blast/executables/blast%2B/LATEST/) and ensure it is added to
their system’s PATH environment variable.

The `Rmd` file (`SPblast.Rmd`) associated with this vignette serves a dual purpose.
It acts both as a template for executing the workflow and as a template for
generating a reproducible scientific analysis report. Thus, users want to
customize the text (and/or code) of this or other `systemPipeR` workflow vignettes to describe their
experimental design and analysis results. This typically involves deleting the
instructions how to work with this workflow, and customizing the text
describing experimental designs, other metadata and analysis results.

The following data analysis steps are included in this workflow template:

1. Validation of the BLAST installation
2. Creation of an indexed sequence database that can be searched with BLAST
3. BLAST search of indexed database with query sequence

The topology graph of the BLAST workflow is shown in Figure 1.

![Topology graph of BLAST workflow.](data:image/jpeg;base64...)

Figure 1: Topology graph of BLAST workflow

# 2 Workflow environment

The environment of the chosen workflow is generated with the `genWorenvir`
function. After this, the user’s R session needs to be directed into the
resulting directory (here `SPblast`).

```
systemPipeRdata::genWorkenvir(workflow = "SPblast", mydirname = "SPblast")
setwd("SPblast")
```

The `SPRproject` function initializes a new workflow project instance. This
function call creates an empty `SAL` workflow container and at the same time a
linked project log directory (default name `.SPRproject`) that acts as a
flat-file database of a workflow. For additional details, please visit this
[section](https://www.bioconductor.org/packages/devel/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html#5_Detailed_tutorial)
in `systemPipeR's` main vignette.

```
library(systemPipeR)
sal <- SPRproject()
sal
```

The `importWF` function allows to import all the workflow steps outlined in
the source Rmd file of this vignette into a `SAL` (`SYSargsList`) workflow
container. Once imported, the entire workflow can be executed from start to
finish using the `runWF` function. More details regarding this process are
provided in the following section [here](#importwf).

```
sal <- importWF(sal, "SPblast.Rmd")
sal <- runWF(sal)
```

## 2.1 Step 1: Load packages

Next, the `systemPipeR` package needs to be loaded in a workflow.

```
appendStep(sal) <- LineWise(code = {
    library(systemPipeR)
}, step_name = "load_packages")
```

## 2.2 Step 2: Test BLAST install

The following step is optional. It tests the availability of the BLAST software on the user’s system.

```
appendStep(sal) <- LineWise(code = {
    # If you have a modular system, then enable the
    # following line moduleload('ncbi-blast')
    blast_check <- tryCMD("blastn", silent = TRUE)
    if (blast_check == "error")
        stop("Check your BLAST installation path.")
}, step_name = "test_blast", dependency = "load_packages")
```

## 2.3 Step 3: BLASTable database

This step creates an indexed sequence database that can be searched with BLAST.
The sample sequences used for creating the databases are stored in a file named
`tair10.fasta` under the `data` directory of the workflow environment. The exact command-line (CL)
call used for creating the indexed database can be returned with `cmdlist(sal, step=3)`.

```
appendStep(sal) <- SYSargsList(step_name = "build_genome_db",
    dir = FALSE, targets = NULL, wf_file = "blast/makeblastdb.cwl",
    input_file = "blast/makeblastdb.yml", dir_path = "param/cwl",
    dependency = "test_blast")
```

## 2.4 Step 4: BLAST search

Next, the BLASTable database is searched with a set of query sequences to find sequences in the
database that share sequence similarity with the queries. As above, the exact CL
call used in this step can be returned with `cmdlist(sal, step=4)`.

```
appendStep(sal) <- SYSargsList(step_name = "blast_genome", dir = FALSE,
    targets = "targets_blast.txt", wf_file = "blast/blastn.cwl",
    input_file = "blast/blastn.yml", inputvars = c(FileName = "_query_file_",
        SampleName = "_SampleName_"), dir_path = "param/cwl",
    dependency = "build_genome_db")
```

## 2.5 Step 5: View top hits

This step displays the top hits identified by the BLAST search in the previous step.
The `e_value` and `bit_score` columns allow to rank the BLAST results by sequence similarity.

```
appendStep(sal) <- LineWise(code = {
    # get the output file path from a Sysargs step using
    # `getColumn`
    tbl_tair10 <- read.delim(getColumn(sal, step = "blast_genome")[1],
        header = FALSE, stringsAsFactors = FALSE)
    names(tbl_tair10) <- c("query", "subject", "identity", "alignment_length",
        "mismatches", "gap_openings", "q_start", "q_end", "s_start",
        "s_end", "e_value", "bit_score")
    print(head(tbl_tair10, n = 20))
}, step_name = "display_hits", dependency = "blast_genome")
```

## 2.6 Version Information

```
appendStep(sal) <- LineWise(code = {
    sessionInfo()
}, step_name = "wf_session", dependency = "display_hits")
```

# 3 Automated routine

Once the above workflow steps have been loaded into `sal` from the source `Rmd`
file of this vignette, the workflow can be executed from start to finish (or
partially) with the `runWF` command. Subsequently, scientific and technical
workflow reports can be generated with the `renderReport` and `renderLogs`
functions, respectively.

**Note:** To demonstrate ‘systemPipeR’s’ automation routines without regenerating a new workflow
environment from scratch, the first line below uses the `overwrite=TRUE` option of the `SPRproject` function.
This option is generally discouraged as it erases the existing workflow project and `sal` container.
For information on resuming and restarting workflow runs, users want to consult the relevant section of
the main vignette (see [here](https://www.bioconductor.org/packages/devel/bioc/vignettes/systemPipeR/inst/doc/systemPipeR.html#10_Restarting_and_resetting_workflows).)

```
sal <- SPRproject(overwrite = TRUE)  # Avoid 'overwrite=TRUE' in real runs.
sal <- importWF(sal, file_path = "SPblast.Rmd")  # Imports above steps from new.Rmd.
sal <- runWF(sal)  # Runs ggworkflow.
plotWF(sal)  # Plot toplogy graph of workflow
sal <- renderReport(sal)  # Renders scientific report.
sal <- renderLogs(sal)  # Renders technical report from log files.
```

## 3.1 CL tools used

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
    cat(c("BLAST 2.16.0+"), sep = "\n")
}
```

```
## Tools and modules required by this workflow are:
## BLAST 2.16.0+
```

## 3.2 Session Info

This is the session information for rendering this R Markdown report. To access the
session information for the workflow run, generate the technical HTML report with `renderLogs`.

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
## [17] evaluate_1.0.5      bslib_0.10.0
## [19] yaml_2.3.12         formatR_1.14
## [21] otel_0.2.0          BiocManager_1.30.27
## [23] crayon_1.5.3        jsonlite_2.0.0
## [25] rlang_1.1.7
```

H Backman, Tyler W, and Thomas Girke. 2016. “systemPipeR: NGS workflow and report generation environment.” *BMC Bioinformatics* 17 (1): 388. <https://doi.org/10.1186/s12859-016-1241-0>.