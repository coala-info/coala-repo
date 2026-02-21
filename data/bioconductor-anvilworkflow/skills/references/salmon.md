# AnVILWorkflow: Run batch analysis workflows including non-R tools leveraing Cloud resources

Sehyun Oh

#### October 29, 2025

# Contents

* [1 Overview](#overview)
  + [1.1 Citing *AnVILWorkflow*](#citing-anvilworkflow)
  + [1.2 Install and load package](#install-and-load-package)
  + [1.3 Google Cloud SDK](#google-cloud-sdk)
  + [1.4 Create Terra account](#create-terra-account)
  + [1.5 Major steps](#major-steps)
  + [1.6 Example in this vignette: bulk RNAseq analysis](#example-in-this-vignette-bulk-rnaseq-analysis)
* [2 Browse AnVIL resources](#browse-anvil-resources)
* [3 Setup](#setup)
  + [3.1 Clone workspace](#clone-workspace)
    - [3.1.1 Curated by this package](#curated-by-this-package)
    - [3.1.2 Any workspace you have access to](#any-workspace-you-have-access-to)
  + [3.2 Prepare input](#prepare-input)
    - [3.2.1 Current input](#current-input)
    - [3.2.2 Update input](#update-input)
* [4 Run workflow](#run-workflow)
  + [4.1 Monitor progress](#monitor-progress)
  + [4.2 Abort submission](#abort-submission)
* [5 Result](#result)
* [6 Session Info](#session-info)

# 1 Overview

The [AnVIL project](https://anvilproject.org/) is an analysis, visualization, and informatics
cloud-based space for data access, sharing and computing across large
genomic-related data sets.

For R users with the limited computing resources, we introduce the
AnVILWorkflow package. This package allows users to run workflows
implemented in [Terra](https://anvil.terra.bio/) without installing software, writing any
workflow, or managing cloud resources. Terra is a cloud-based genomics
platform and its computing resources rely on Google Cloud Platform (GCP).

Use of this package requires AnVIL and Google cloud computing billing
accounts. Consult [AnVIL training guides](https://anvilproject.org/learn) for details on
establishing these accounts.

## 1.1 Citing *AnVILWorkflow*

Your citations are crucial in keeping our software free and open source. To
cite our package, please use this publication at the link [here][1].
[1]: <https://f1000research.com/articles/13-1257>

## 1.2 Install and load package

```
if (!require("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("AnVILWorkflow")
```

```
library(AnVIL)
library(AnVILGCP)
library(AnVILWorkflow)
```

## 1.3 Google Cloud SDK

If you use AnVILWorkflow within Terra’s RStudio, you don’t need extra
authentication and gcloud SDK. If you use this package locally, it
requires gcloud SDK and the billing account used in Terra.
You can [install][] the gcloud sdk.

Check whether your system has the installation with `AnVILGCP::gcloud_exists()`.
It should return `TRUE` to use AnVILWorkflow package.

```
AnVILGCP::gcloud_exists()
```

If it returns `FALSE`, install the gcloud SDK following this script:

```
devtools::install_github("rstudio/cloudml")
cloudml::gcloud_install()
```

```
## shell
$ gcloud auth login
```

## 1.4 Create Terra account

You need [Terra account
setup](https://support.terra.bio/hc/en-us/articles/360034677651-Account-setup-and-exploring-Terra).
Once you have your own Terra account, you need two pieces of information
to use AnVILWorkflow package:

1. The email address linked to your Terra account
2. Your billing project name

You can setup your working environment using `setCloudEnv()` function like
below. **Provide the input values with YOUR account information!**

```
accountEmail <- "YOUR_EMAIL@gmail.com"
billingProjectName <- "YOUR_BILLING_ACCOUNT"

setCloudEnv(accountEmail = accountEmail,
            billingProjectName = billingProjectName)
```

The remainder of this vignette assumes that an Terra account has been
established and successfully linked to a Google cloud computing
billing account.

## 1.5 Major steps

Here is the table of major functions for three workflow steps - prepare,
run, and check result.

| Steps | Functions | Description |
| --- | --- | --- |
| Prepare | `cloneWorkspace` | Copy the template workspace |
|  | `updateInput` | Take user’s inputs |
| Run | `runWorkflow` | Launch the workflow in Terra |
|  | `stopWorkflow` | Abort the submission |
|  | `monitorWorkflow` | Monitor the status of your workflow run |
| Result | `getOutput` | List or download your workflow outputs |

## 1.6 Example in this vignette: bulk RNAseq analysis

You can find all the available workspaces you have access to using
`AnVIL::avworkspaces()` function. Workspaces manually curated by
this package are separately checked using `availableAnalysis()` function.
The values under `analysis` column can be used for the analysis
argument, simplifying the cloning process. For this vignette,
we use `"salmon"`.

```
> availableAnalysis()
   analysis       workspaceNamespace                            workspaceName         configuration_namespace              configuration_name
1 bioBakery waldronlab-terra-rstudio mtx_workflow_biobakery_version3_template mtx_workflow_biobakery_version3 mtx_workflow_biobakery_version3
2    salmon  bioconductor-rpci-anvil             Bioconductor-Workflow-DESeq2         bioconductor-rpci-anvil                 AnVILBulkRNASeq
3    pathml waldronlab-terra-rstudio      pathml_stain_normalization_template                          PathML                   Preprocessing
                                                                                             description
1                                                                    Microbiome analysis using bioBakery
2 Trascript quantification from RNAseq using Salmon | Differential gene expression analysis using DESeq2
3                                                            Stain normalization step of PathML pipeline
```

```
analysis <- "salmon"
```

# 2 Browse AnVIL resources

```
AnVILBrowse("malaria")
AnVILBrowse("resistance")
AnVILBrowse("resistance", searchFrom = "workflow")
```

# 3 Setup

## 3.1 Clone workspace

### 3.1.1 Curated by this package

We will refer the existing workspaces, that you have access to and want
to use for your analysis, as ‘template’ workspaces. The first step of
using this package is cloning the template workspace using `cloneWorkspace`
function. Note that you need to provide a **unique** name for the cloned
workspace through `workspaceName` argument. Once you successfully clone
the workspace, the function will return the name of the cloned workspace.
For example, the successfully execution of the below script will
return `{YOUR_BILLING_ACCOUNT}/salmon_test`.

```
salmonWorkspaceName <- basename(tempfile("salmon_")) # unique workspace name
salmonWorkspaceName
cloneWorkspace(workspaceName = salmonWorkspaceName, analysis = analysis)
```

### 3.1.2 Any workspace you have access to

If you want to clone any other workspace that you have access to but
is not curated by this pacakge, you can directly enter the name of
the target workspace as a `templateName`. For example, to clone the
[Tumor\_Only\_CNV](https://anvil.terra.bio/#workspaces/waldronlab-terra/Tumor_Only_CNV) workspace:

```
cnvWorkspaceName <- basename(tempfile("cnv_")) # unique workspace name
cnvWorkspaceName
cloneWorkspace(workspaceName = cnvWorkspaceName,
               templateName = "Tumor_Only_CNV")
```

## 3.2 Prepare input

### 3.2.1 Current input

You can review the current inputs using `currentInput` function. Below
shows all the required and optional inputs for the workflow.

```
config <- getWorkflowConfig(workspaceName = salmonWorkspaceName)
current_input <- currentInput(salmonWorkspaceName, config = config)
current_input
```

### 3.2.2 Update input

You can modify/update inputs of your workflow using `updateInput` function. To
minimize the formatting issues, we recommend to make any change in the current
input table returned from the `currentInput` function. Under the default
(`dry=TRUE`), the updated input table will be returned without actually
updating Terra/AnVIL. Set `dry=FALSE`, to make a change in Terra/AnVIL.

```
new_input <- current_input
new_input[4,4] <- "athal_index"
new_input

updateInput(salmonWorkspaceName, inputs = new_input, config = config)
```

# 4 Run workflow

You can launch the workflow using `runWorkflow()` function. You need to
specify the `inputName` of your workflow. If you don’t provide it, this
function will return the list of input names you can use for your workflow.

Example error outputs:

```
runWorkflow(slamonWorkspaceName, config = config)
# You should provide the inputName from the followings:
# [1] "AnVILBulkRNASeq_set"
#> Error in runWorkflow(salmonWorkspaceName):
```

```
runWorkflow(salmonWorkspaceName,
            inputName = "AnVILBulkRNASeq_set",
            config = config)
```

## 4.1 Monitor progress

The last three columns (`status`, `succeeded`, and `failed`) show the
submission and the result status.

```
submissions <- monitorWorkflow(workspaceName = salmonWorkspaceName)
submissions
```

## 4.2 Abort submission

You can abort the most recently submitted job using the `stopWorkflow`
function. You can abort any workflow that is not the most recently
submitted by providing a specific `submissionId`.

```
stopWorkflow(salmonWorkspaceName)
```

# 5 Result

The workspace `Bioconductor-Workflow-DESeq2` is the template workspace
you cloned at the beginning using the `analysis = "salmon"` argument
in `cloneWorkspace()` function. This template workspace has already a
history of the previous submissions, so we will check the output examples
in this workspace.

```
submissions <- monitorWorkflow(workspaceName = "Bioconductor-Workflow-DESeq2")
submissions
```

You can check all the output files from the most recently succeeded
submission using `getOutput` function. If you specify the `submissionId`
argument, you can get the output files of that specific submission.

```
## Output from the successfully-done submission
successful_submissions <- submissions$submissionId[submissions$succeeded == 1]
out <- getOutput(workspaceName = "Bioconductor-Workflow-DESeq2",
                 submissionId = successful_submissions[1])
```

```
head(out)
```

# 6 Session Info

```
sessionInfo()
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] vctrs_0.6.5          httr_1.4.7           cli_3.6.5
#>  [4] knitr_1.50           rlang_1.1.6          xfun_0.53
#>  [7] purrr_1.1.0          generics_0.1.4       jsonlite_2.0.0
#> [10] glue_1.8.0           htmltools_0.5.8.1    BiocBaseUtils_1.12.0
#> [13] sass_0.4.10          rmarkdown_2.30       rappdirs_0.3.3
#> [16] GCPtools_1.0.0       evaluate_1.0.5       jquerylib_0.1.4
#> [19] tibble_3.3.0         fastmap_1.2.0        yaml_2.3.10
#> [22] lifecycle_1.0.4      httr2_1.2.1          bookdown_0.45
#> [25] BiocManager_1.30.26  compiler_4.5.1       dplyr_1.1.4
#> [28] pkgconfig_2.0.3      tidyr_1.3.1          digest_0.6.37
#> [31] R6_2.6.1             tidyselect_1.2.1     pillar_1.11.1
#> [34] magrittr_2.0.4       bslib_0.9.0          tools_4.5.1
#> [37] AnVILBase_1.4.0      AnVILGCP_1.4.0       cachem_1.1.0
```