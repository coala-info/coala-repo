# Code example from 'AnVILPublishIntro' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
if (!"AnVILPublish" %in% rownames(installed.packages()))
    BiocManager::install("AnVILPublish")

## ----eval = FALSE-------------------------------------------------------------
# GCPtools::gcloud_exists()

## ----eval = FALSE-------------------------------------------------------------
# GCPtools::gcloud_account()
# GCPtools::gcloud_project()

## ----eval = FALSE-------------------------------------------------------------
# system2("quarto", "--version")

## ----eval = FALSE-------------------------------------------------------------
# AnVILPublish::as_workspace(
#     "path/to/package",
#     "bioconductor-rpci-anvil",     # i.e., billing account
#     create = TRUE                  # use update = TRUE for an existing workspace
# )

## ----eval = FALSE-------------------------------------------------------------
# AnVILPublish::as_workspace(
#     "path/to/directory",      # directory containing DESCRIPTION file
#     "bioconductor-rpci-anvil",
#     create = TRUE
# )

## ----eval = FALSE-------------------------------------------------------------
# AnVILPublish::as_notebook(
#     "paths/to/files.Rmd",
#     "bioconductor-rpci-anvil",     # i.e., billing account
#     "Bioconductor-Package-Foo",    # Workspace name
#     update = FALSE                 # make notebooks, but do not update workspace
# )

## ----eval = FALSE-------------------------------------------------------------
# AnVILPublish::add_access(
#     "bioconductor-rpci-anvil",
#     "Bioconductor-Package-Foo"
# )

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

