# Code example from 'userguide' vignette. See references/ for full tutorial.

## ----echo=FALSE, results="hide", message=FALSE--------------------------------
knitr::opts_chunk$set(error=FALSE, message=FALSE, warning=FALSE)
library(BiocStyle)

## -----------------------------------------------------------------------------
library(celldex)
surveyReferences()

## -----------------------------------------------------------------------------
searchReferences("B cell")
searchReferences(
    defineTextQuery("immun%", partial=TRUE) & 
    defineTextQuery("10090", field="taxonomy_id")
)

## -----------------------------------------------------------------------------
library(celldex)
ref <- fetchReference("hpca", "2024-02-26")

## ----tabulate, echo=FALSE-----------------------------------------------------
samples <- colData(ref)[,c("label.main", "label.fine","label.ont")]
samples <- as.data.frame(samples)
DT::datatable(unique(samples))

## -----------------------------------------------------------------------------
ref <- fetchReference("blueprint_encode", "2024-02-26")

## ----echo=FALSE, ref.label="tabulate"-----------------------------------------
samples <- colData(ref)[,c("label.main", "label.fine","label.ont")]
samples <- as.data.frame(samples)
DT::datatable(unique(samples))

## -----------------------------------------------------------------------------
ref <- fetchReference("mouse_rnaseq", "2024-02-26")

## ----echo=FALSE, ref.label="tabulate"-----------------------------------------
samples <- colData(ref)[,c("label.main", "label.fine","label.ont")]
samples <- as.data.frame(samples)
DT::datatable(unique(samples))

## -----------------------------------------------------------------------------
ref <- fetchReference("immgen", "2024-02-26")

## ----echo=FALSE, ref.label="tabulate"-----------------------------------------
samples <- colData(ref)[,c("label.main", "label.fine","label.ont")]
samples <- as.data.frame(samples)
DT::datatable(unique(samples))

## -----------------------------------------------------------------------------
ref <- fetchReference("dice", "2024-02-26")

## ----echo=FALSE, ref.label="tabulate"-----------------------------------------
samples <- colData(ref)[,c("label.main", "label.fine","label.ont")]
samples <- as.data.frame(samples)
DT::datatable(unique(samples))

## -----------------------------------------------------------------------------
ref <- fetchReference("novershtern_hematopoietic", "2024-02-26")

## ----echo=FALSE, ref.label="tabulate"-----------------------------------------
samples <- colData(ref)[,c("label.main", "label.fine","label.ont")]
samples <- as.data.frame(samples)
DT::datatable(unique(samples))

## -----------------------------------------------------------------------------
ref <- fetchReference("monaco_immune", "2024-02-26")

## ----echo=FALSE, ref.label="tabulate"-----------------------------------------
samples <- colData(ref)[,c("label.main", "label.fine","label.ont")]
samples <- as.data.frame(samples)
DT::datatable(unique(samples))

## -----------------------------------------------------------------------------
norm <- matrix(runif(1000), ncol=20)
rownames(norm) <- sprintf("GENE_%i", seq_len(nrow(norm)))

labels <- DataFrame(label.main=rep(LETTERS[1:5], each=4))
labels$label.fine <- sprintf("%s%i", labels$label.main, rep(c(1, 1, 2, 2), 5))
labels$label.ont <- sprintf("CL:000%i", rep(1:5, each=4))

## -----------------------------------------------------------------------------
meta <- list(
    title="My reference",
    description="This is my reference dataset",
    taxonomy_id="10090",
    genome="GRCh38",
    sources=list(
        list(provider="GEO", id="GSE12345"),
        list(provider="PubMed", id="1234567")
    ),
    maintainer_name="Chihaya Kisaragi",
    maintainer_email="kisaragi.chihaya@765pro.com"
)

## -----------------------------------------------------------------------------
# Simple case: you only have one dataset to upload.
staging <- tempfile()
saveReference(norm, labels, staging, meta)
list.files(staging, recursive=TRUE)

# Complex case: you have multiple subdatasets to upload.
staging <- tempfile()
dir.create(staging)
saveReference(norm, labels, file.path(staging, "foo"), meta)
saveReference(norm, labels, file.path(staging, "bar"), meta) # and so on.

## -----------------------------------------------------------------------------
alabaster.base::readObject(file.path(staging, "foo"))

## ----eval=FALSE---------------------------------------------------------------
# gypsum::uploadDirectory(staging, "celldex", "my_dataset_name", "my_version")

## ----eval=FALSE---------------------------------------------------------------
# fetchReference("my_dataset_name", "my_version")

## ----eval=FALSE---------------------------------------------------------------
# gypsum::rejectProbation("scRNAseq", "my_dataset_name", "my_version")

## -----------------------------------------------------------------------------
sessionInfo()

