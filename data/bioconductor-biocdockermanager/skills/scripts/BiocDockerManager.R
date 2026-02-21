# Code example from 'BiocDockerManager' vignette. See references/ for full tutorial.

## ----install, eval = FALSE----------------------------------------------------
#  if (!require("BiocManager"))
#      install.packages("BiocManager")
#  BiocManager::install("BiocDockerManager")

## ----load, echo = TRUE, message=FALSE-----------------------------------------
library(BiocDockerManager)
library(dplyr)

## ----do_it--------------------------------------------------------------------
.is_docker_installed <- function() {
    code <- suppressWarnings(
        system("docker --version", ignore.stderr = TRUE, ignore.stdout = TRUE)
    )
    code == 0
}

## execute code if the date is later than a specified day
do_it = BiocDockerManager:::.is_docker_installed()

## ----available1, eval=TRUE----------------------------------------------------
BiocDockerManager::available()

## -----------------------------------------------------------------------------
res <- BiocDockerManager::available()

res %>%
    select(IMAGE, DESCRIPTION, TAGS) %>%
    filter(IMAGE == "bioconductor_docker")

## ----available2---------------------------------------------------------------
res2 <- BiocDockerManager::available(pattern = "bioconductor_docker")

res2 %>% select(IMAGE, DESCRIPTION, TAGS)

## ----deprecated, eval = TRUE--------------------------------------------------
BiocDockerManager::available(deprecated=TRUE) %>%
    select(IMAGE, DESCRIPTION)

## ----help, eval = TRUE--------------------------------------------------------
if(do_it) {
    BiocDockerManager::help()
}

## ----pull, eval = TRUE--------------------------------------------------------
if (do_it) {
    BiocDockerManager::install(
        repository = "bioconductor/bioconductor_docker",
        tag = "latest"
    )
}

## ----installed, eval = TRUE---------------------------------------------------
if (do_it)
    BiocDockerManager::installed()

## ----filter-installed, eval = TRUE--------------------------------------------
if (do_it)
    BiocDockerManager::installed(
        repository = "bioconductor/bioconductor_docker"
    )

## ----label-maintainer, eval = TRUE--------------------------------------------

if (do_it) {
    ## Get version for the "latest" tag bioconductor image
    BiocDockerManager::maintainer(
        repository = "bioconductor/bioconductor_docker",
        tag = "latest"
    )

    ## The above functions works the same as
    BiocDockerManager::maintainer(tag = "latest")
}

## ----label-version, eval = TRUE-----------------------------------------------
if(do_it) {
    BiocDockerManager::version(
        repository = "bioconductor/bioconductor_docker",
        tag = "latest"
    )

    ## Get image version
    BiocDockerManager::version(tag = "latest")

    BiocDockerManager::version(tag = "devel")

    BiocDockerManager::version(tag = "RELEASE_3_10")
}

## ----valid, eval = TRUE-------------------------------------------------------
if(do_it) {
    BiocDockerManager::valid(
        repository = "bioconductor/bioconductor_docker",
        tag = "latest"
    )
}

## ----template, eval = FALSE---------------------------------------------------
#  BiocDockerManager::use_dockerfile()

## ----workflow-1, eval = TRUE--------------------------------------------------

if (do_it) {

    ## 1. Check available images
    BiocDockerManager::available()

    ## 2. Install a new image
    BiocDockerManager::install(
        repository = "bioconductor/bioconductor_docker",
        tag = "devel"
    )
}

## ----workflow-2, eval = TRUE--------------------------------------------------
if (do_it) {

    ## 3. Check if image is valid
    BiocDockerManager::valid(
        "bioconductor/bioconductor_docker",
        tag = "devel"
    )

    ## 4. Download update to image
    BiocDockerManager::install(
        "bioconductor/bioconductor_docker",
        tag = "devel"
    )

    ## 5. Check version
    BiocDockerManager::version(
        "bioconductor/bioconductor_docker",
        tag = "devel"
    )
}

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

