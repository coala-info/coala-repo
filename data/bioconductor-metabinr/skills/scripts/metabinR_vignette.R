# Code example from 'metabinR_vignette' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----eval=FALSE---------------------------------------------------------------
# if (!requireNamespace("BiocManager", quietly=TRUE))
#     install.packages("BiocManager")
# BiocManager::install("metabinR")

## ----eval=TRUE, message=FALSE-------------------------------------------------
options(java.parameters="-Xmx1500M")
unloadNamespace("metabinR")
library(metabinR)
library(data.table)
library(dplyr)
library(ggplot2)
library(gridExtra)
library(cvms)
library(sabre)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
abundances <- read.table(
    system.file("extdata", "distribution_0.txt",package = "metabinR"),
    col.names = c("genome_id", "abundance" ,"AB_id"))

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
reads.mapping <- fread(system.file("extdata", "reads_mapping.tsv.gz",
                                   package = "metabinR")) %>%
    merge(abundances[, c("genome_id","AB_id")], by = "genome_id") %>%
    arrange(anonymous_read_id)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
assignments.AB <- abundance_based_binning(
        system.file("extdata","reads.metagenome.fasta.gz", package="metabinR"),
        numOfClustersAB = 2, 
        kMerSizeAB = 10, 
        dryRun = FALSE, 
        outputAB = "vignette") %>%
    arrange(read_id)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
histogram.AB <- read.table("vignette__AB.histogram.tsv", header = TRUE)
ggplot(histogram.AB, aes(x=counts, y=frequency)) + 
    geom_area() +
    labs(title = "kmer counts histogram") + 
    theme_bw()

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
eval.AB.cvms <- cvms::evaluate(data = data.frame(
                                    prediction=as.character(assignments.AB$AB),
                                    target=as.character(reads.mapping$AB_id),
                                    stringsAsFactors = FALSE),
                                target_col = "target",
                                prediction_cols = "prediction",
                                type = "binomial"
)
eval.AB.sabre <- sabre::vmeasure(as.character(assignments.AB$AB),
                                as.character(reads.mapping$AB_id))

p <- cvms::plot_confusion_matrix(eval.AB.cvms) +
        labs(title = "Confusion Matrix", 
                x = "Target Abundance Class", 
                y = "Predicted Abundance Class")
tab <- as.data.frame(
    c(
        Accuracy =  round(eval.AB.cvms$Accuracy,4),
        Specificity =  round(eval.AB.cvms$Specificity,4),
        Sensitivity =  round(eval.AB.cvms$Sensitivity,4),
        Fscore =  round(eval.AB.cvms$F1,4),
        Kappa =  round(eval.AB.cvms$Kappa,4),
        Vmeasure = round(eval.AB.sabre$v_measure,4)
    )
)
grid.arrange(p, ncol = 1)
knitr::kable(tab, caption = "AB binning evaluation", col.names = NULL)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
reads.mapping <- fread(
        system.file("extdata", "reads_mapping.tsv.gz",package = "metabinR")) %>%
    arrange(anonymous_read_id)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
assignments.CB <- composition_based_binning(
        system.file("extdata","reads.metagenome.fasta.gz",package ="metabinR"),
        numOfClustersCB = 10, 
        kMerSizeCB = 4, 
        dryRun = TRUE, 
        outputCB = "vignette") %>%
    arrange(read_id)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
eval.CB.sabre <- sabre::vmeasure(as.character(assignments.CB$CB),
                                as.character(reads.mapping$genome_id))
tab <- as.data.frame(
    c(
        Vmeasure = round(eval.AB.sabre$v_measure,4),
        Homogeneity = round(eval.AB.sabre$homogeneity,4),
        Completeness = round(eval.AB.sabre$completeness,4)
    )
)
knitr::kable(tab, caption = "CB binning evaluation", col.names = NULL)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
reads.mapping <- fread(
        system.file("extdata", "reads_mapping.tsv.gz",package = "metabinR")) %>%
    arrange(anonymous_read_id)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
assignments.ABxCB <- hierarchical_binning(
        system.file("extdata","reads.metagenome.fasta.gz",package ="metabinR"),
        numOfClustersAB = 2,
        kMerSizeAB = 10,
        kMerSizeCB = 4, 
        dryRun = TRUE, 
        outputC = "vignette") %>%
    arrange(read_id)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
eval.ABxCB.sabre <- sabre::vmeasure(as.character(assignments.ABxCB$ABxCB),
                                    as.character(reads.mapping$genome_id))
tab <- as.data.frame(
    c(
        Vmeasure = round(eval.ABxCB.sabre$v_measure,4),
        Homogeneity = round(eval.ABxCB.sabre$homogeneity,4),
        Completeness = round(eval.ABxCB.sabre$completeness,4)
    )
)
knitr::kable(tab, caption = "ABxCB binning evaluation", col.names = NULL)

## ----eval=TRUE, message=FALSE, warning=FALSE----------------------------------
unlink("vignette__*")

## ----setup--------------------------------------------------------------------
utils::sessionInfo()

