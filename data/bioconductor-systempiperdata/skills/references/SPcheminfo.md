Code

* Show All Code
* Hide All Code

# Cheminformatics Drug Similarity Template

Author: FirstName LastName

#### Last update: 22 January, 2026

#### Package

systemPipeR 2.16.3

# 1 About the template

This is a cheminformatics workflow template of the [systemPipeRdata](https://bioconductor.org/packages/devel/data/experiment/html/systemPipeRdata.html)
package, a companion
package to [systemPipeR](https://www.bioconductor.org/packages/devel/bioc/html/systemPipeR.html) (H Backman and Girke [2016](#ref-H_Backman2016-bt)). Like other workflow
templates, it can be loaded with a single command. Users have the
flexibility to utilize the template as is or modify it as needed. More in-depth
information on designing workflows can be found in the main vignette of [systemPipeRdata](https://bioconductor.org/packages/devel/data/experiment/vignettes/systemPipeRdata/inst/doc/systemPipeRdata.html).
This template serves as a starting point for conducting structure similarity
searching and clustering of small molecules. Most of its steps use functions
of the [ChemmineR](https://www.bioconductor.org/packages/release/bioc/vignettes/ChemmineR/inst/doc/ChemmineR.html)
package from [Bioconductor](https://www.bioconductor.org/packages/release/bioc/html/ChemmineR.html).
There are no command-line (CL) software tools required for running this
workflow in its current form as all steps are based on R functions.

The `Rmd` file (`SPcheminfo.Rmd`) associated with this vignette serves a dual purpose. It acts
both as a template for executing the workflow and as a template for generating
a reproducible scientific analysis report. Thus, users want to customize the text
(and/or code) of this vignette to describe their experimental design and
analysis results. This typically involves deleting the instructions how to work
with this workflow, and customizing the text describing experimental designs,
other metadata and analysis results.

The following data analysis routines are included in this workflow template:

* Import of small molecules from a structure definition file (SDF)
* Plotting of small molecule structures
* Computation of atom pairs and finger prints for structure searching
* All-against-all structure comparisons of small molecules
* Heatmap plot of resulting distance matrix

![](data:image/jpeg;base64...)

# 2 Workflow environment

The environment of the chosen workflow is generated with the `genWorenvir`
function. After this, the user’s R session needs to be directed into the
resulting directory (here `SPcheminfo`).

```
systemPipeRdata::genWorkenvir(workflow = "SPcheminfo", mydirname = "SPcheminfo")
setwd("SPcheminfo")
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
sal <- importWF(sal, "SPcheminfo.Rmd")
sal <- runWF(sal)
```

## 2.1 Step 1: Load packages

The first step loads the `systemPipeR` and `ChemmineR` packages.

```
appendStep(sal) <- LineWise(code = {
    library(systemPipeR)
    library(ChemmineR)
}, step_name = "load_packages")
```

## 2.2 Step 2: Import molecule structures

This step imports 100 small molecule structures from an SDF file with the `read.SDFset` function. The structures
are stored in an `SDFset` object, a class defined by the `ChemmineR` package.

```
appendStep(sal) <- LineWise(code = {
    sdfset <- read.SDFset("https://cluster.hpcc.ucr.edu/~tgirke/Documents/R_BioCond/Samples/sdfsample.sdf")
}, step_name = "load_data", dependency = "load_packages")
```

## 2.3 Step 3: Visualize molecule structures

The structures of selected molecules (here first four) are be visualized with the `plot` function.

```
appendStep(sal) <- LineWise(code = {
    png("results/mols_plot.png", 700, 600)
    # Here only first 4 are plotted. Please choose the ones
    # you want to plot.
    ChemmineR::plot(sdfset[1:4])
    dev.off()
}, step_name = "vis_mol", dependency = "load_data", run_step = "optional")
```

![](data:image/png;base64...)

## 2.4 Step 4: Physicochemical properties

Basic physicochemical properties are computed for the small molecules stored in `sdfset`.
For this example atom frequencies, molecular weight and formula are computed. For more options
users want to consult the vignette of the [ChemmineR](https://www.bioconductor.org/packages/release/bioc/html/ChemmineR.html)
package.

```
appendStep(sal) <- LineWise(code = {
    propma <- data.frame(MF = MF(sdfset), MW = MW(sdfset), atomcountMA(sdfset))
    readr::write_csv(propma, "results/basic_mol_info.csv")
}, step_name = "basic_mol_info", dependency = "load_data", run_step = "optional")
```

## 2.5 Step 5: Box plots of properties

In this example, the extracted property data is visualized using a box plot.

```
appendStep(sal) <- LineWise(code = {
    png("results/atom_req.png", 700, 700)
    boxplot(propma[, 3:ncol(propma)], col = "#6cabfa", main = "Atom Frequency")
    dev.off()
}, step_name = "mol_info_plot", dependency = "basic_mol_info",
    run_step = "optional")
```

![](data:image/png;base64...)

## 2.6 Step 6: Structural descriptors

For structural comparisons and searching, atom pairs and fingerprints are computed for
the imported small molecules.

```
appendStep(sal) <- LineWise(code = {
    apset <- sdf2ap(sdfset)
    fpset <- desc2fp(apset, descnames = 1024, type = "FPset")
    # The atom pairs and fingerprints can be saved to
    # files.
    readr::write_rds(apset, "results/apset.rds")
    readr::write_rds(fpset, "results/fpset.rds")
}, step_name = "apfp_convert", dependency = "load_data")
```

## 2.7 Step 7: Removal of identical fingerprint sets

Small molecules yielding identical fingerprints are removed in this step.

```
appendStep(sal) <- LineWise(code = {
    fpset <- fpset[which(!cmp.duplicated(apset))]
}, step_name = "fp_dedup", dependency = "apfp_convert")
```

## 2.8 Step 8: Similarity compute

All-against-all similarity scores (here Tanimoto coefficients) are computed and stored in a similarity matrix.

```
appendStep(sal) <- LineWise(code = {
    simMAfp <- sapply(cid(fpset), function(x) fpSim(x = fpset[x],
        fpset, sorted = FALSE))
}, step_name = "fp_similarity", dependency = "fp_dedup")
```

## 2.9 Step 9: Hierarchical clustering

The similarity matrix from the previous step can be used for clustering the
small molecules by structural similarities. In the given example, hierarchical
cluster is performed with the `hclust` function. Since this functions expects
a distance matrix, the similarity matrix needs to be converted to a distance matrix
using `1-simMAfp`.

```
appendStep(sal) <- LineWise(code = {
    hc <- hclust(as.dist(1 - simMAfp))
    png("results/hclust.png", 1000, 700)
    plot(as.dendrogram(hc), edgePar = list(col = 4, lwd = 2),
        horiz = TRUE)
    dev.off()
    # to see the tree groupings, one need to cut the tree,
    # for example, by height of 0.9
    tree_cut <- cutree(hc, h = 0.9)
    grouping <- tibble::tibble(cid = names(tree_cut), group_id = tree_cut)
    readr::write_csv(grouping, "results/hclust_grouping.csv")
}, step_name = "hclust", dependency = "fp_similarity", run_step = "optional")
```

![](data:image/png;base64...)

## 2.10 Step 10: PCA

Alternatively, PCA can be used to visualize the structural similarities among molecules.

```
appendStep(sal) <- LineWise(code = {
    library(magrittr)
    library(ggplot2)
    mol_pca <- princomp(simMAfp)
    # find the variance
    mol_pca_var <- mol_pca$sdev[1:2]^2/sum(mol_pca$sdev^2)
    # plot
    png("results/mol_pca.png", 650, 700)
    tibble::tibble(PC1 = mol_pca$loadings[, 1], PC2 = mol_pca$loadings[,
        2], group_id = as.factor(grouping$group_id)) %>%
        # The following colors the by group labels.
    ggplot(aes(x = PC1, y = PC2, color = group_id)) + geom_point(size = 2) +
        stat_ellipse() + labs(x = paste0("PC1 ", round(mol_pca_var[1],
        3) * 100, "%"), y = paste0("PC1 ", round(mol_pca_var[2],
        3) * 100, "%")) + ggpubr::theme_pubr(base_size = 16) +
        scale_color_brewer(palette = "Set2")
    dev.off()
}, step_name = "PCA", dependency = "hclust", run_step = "optional")
```

![](data:image/png;base64...)

## 2.11 Step 11: Include heatmap

This step adds a heatmap to the above hierarchical clustering analysis. Heatmaps
facilitate the identification of patterns in data, here similarity scores.

```
appendStep(sal) <- LineWise(code = {
    library(gplots)
    png("results/mol_heatmap.png", 700, 700)
    heatmap.2(simMAfp, Rowv = as.dendrogram(hc), Colv = as.dendrogram(hc),
        col = colorpanel(40, "darkblue", "yellow", "white"),
        density.info = "none", trace = "none")
    dev.off()
}, step_name = "heatmap", dependency = "fp_similarity", run_step = "optional")
```

![](data:image/png;base64...)

## 2.12 Version information

```
appendStep(sal) <- LineWise(code = {
    sessionInfo()
}, step_name = "wf_session", dependency = "heatmap")
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
sal <- importWF(sal, file_path = "SPcheminfo.Rmd")  # Imports above steps from new.Rmd.
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
    cat(c("There are no CL steps in this workflow."), sep = "\n")
}
```

```
## Tools and modules required by this workflow are:
## There are no CL steps in this workflow.
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
## [17] evaluate_1.0.5      bslib_0.9.0
## [19] yaml_2.3.12         formatR_1.14
## [21] otel_0.2.0          BiocManager_1.30.27
## [23] crayon_1.5.3        jsonlite_2.0.0
## [25] rlang_1.1.7
```

H Backman, Tyler W, and Thomas Girke. 2016. “systemPipeR: NGS workflow and report generation environment.” *BMC Bioinformatics* 17 (1): 388. <https://doi.org/10.1186/s12859-016-1241-0>.