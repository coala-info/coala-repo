# BiocDockerManager

Nitesh Turaga

#### 13 May 2020

#### Package

BiocDockerManager 1.0.1

# Contents

* [1 Introduction](#introduction)
* [2 Preliminaries](#preliminaries)
  + [2.1 Installation](#installation)
  + [2.2 Loading packages](#loading-packages)
* [3 Usage](#usage)
  + [3.1 Availability of images](#availability-of-images)
  + [3.2 Help regarding Bioconductor images](#help-regarding-bioconductor-images)
  + [3.3 Install or “pull” a docker image](#install-or-pull-a-docker-image)
  + [3.4 Installed images on local machine](#installed-images-on-local-machine)
  + [3.5 Image details](#image-details)
  + [3.6 Check validity of images](#check-validity-of-images)
  + [3.7 Dockerfile template for Bioconductor images](#dockerfile-template-for-bioconductor-images)
* [4 Example Workflow](#example-workflow)
* [5 sessionInfo](#sessioninfo)

# 1 Introduction

The `BiocDockerManager` package was designed to work analogous to
BiocManager but for docker images. Use the BiocDockerManager package
manage docker images provided by the Bioconductor project. The package
provides convenient ways to install images, update images, confirm
validity and find which Bioconductor based docker images are
available.

# 2 Preliminaries

## 2.1 Installation

If you are reading this document and have not yet installed any
software on your computer, visit <http://bioconductor.org> and follow
the instructions for installing R and Bioconductor. Once you have
installed R and Bioconductor, you are ready to go with this document.
In the future, you might find that you need to install one or more
additional packages. The best way to do this is to start an R session
and evaluate commands.

```
if (!require("BiocManager"))
    install.packages("BiocManager")
BiocManager::install("BiocDockerManager")
```

We require the system to have the docker engine installed. It is
supported on all platforms. Please take a look at
<https://docs.docker.com/install/>.

NOTE: For certain functions, it might be the case that you need to
have signed into the Docker Desktop engine on your local machine as
well. Eg: <https://docs.docker.com/docker-for-mac/>

## 2.2 Loading packages

```
library(BiocDockerManager)
library(dplyr)
```

The following code is to run the vignette even if `docker` is not
available

```
.is_docker_installed <- function() {
    code <- suppressWarnings(
        system("docker --version", ignore.stderr = TRUE, ignore.stdout = TRUE)
    )
    code == 0
}

## execute code if the date is later than a specified day
do_it = BiocDockerManager:::.is_docker_installed()
```

# 3 Usage

The best way to describe the package and it’s contents are to showcase
some of the functions available in this package. A few functions use
the the REST API provided by <https://hub.docker.com/>, and a few of
them interact with the `docker` command line tool installed on your
local machine.

Please note that, unless `docker` is installed on the machine some of
the functions in this vignette will not run. The same goes for when
you are testing this package as well.

Some Linux machines require that `sudo` be passed in order to run
`docker` on the command line. But there is a post-installation step
which needs to be setup correctly so the user will not need `sudo`,
these steps are located at
[linux-postinstall](https://docs.docker.com/install/linux/linux-postinstall/).

## 3.1 Availability of images

First we can check what Bioconductor docker images are
“available”. This returns a tibble which we can manipulate with basic
`dplyr` functionality.

```
BiocDockerManager::available()
```

```
## # A tibble: 4 x 5
##   IMAGE       DESCRIPTION         TAGS              REPOSITORY         DOWNLOADS
##   <chr>       <chr>               <chr>             <chr>                  <dbl>
## 1 bioconduct… Bioconductor Docke… latest, devel, R… bioconductor/bioc…      4768
## 2 experiment… Experiment Hub      latest            bioconductor/expe…       440
## 3 annotation… Annotation Hub      latest            bioconductor/anno…        35
## 4 website     Bioconductor websi… latest            bioconductor/webs…        10
```

We can use the result of `available()` to extract what we need. In the
example below, simply finding the details related to the
`bioconductor_docker` image is shown.

```
res <- BiocDockerManager::available()

res %>%
    select(IMAGE, DESCRIPTION, TAGS) %>%
    filter(IMAGE == "bioconductor_docker")
```

```
## # A tibble: 1 x 3
##   IMAGE             DESCRIPTION              TAGS
##   <chr>             <chr>                    <chr>
## 1 bioconductor_doc… Bioconductor Docker Ima… latest, devel, RELEASE_3_11, RELEA…
```

There is a simpler way to extract the same information though, with
the help of the `pattern` argument.

```
res2 <- BiocDockerManager::available(pattern = "bioconductor_docker")

res2 %>% select(IMAGE, DESCRIPTION, TAGS)
```

```
## # A tibble: 1 x 3
##   IMAGE             DESCRIPTION              TAGS
##   <chr>             <chr>                    <chr>
## 1 bioconductor_doc… Bioconductor Docker Ima… latest, devel, RELEASE_3_11, RELEA…
```

We can see that for the `bioconductor/bioconductor_docker` image the
tags **latest, devel, RELEASE\_3\_11, RELEASE\_3\_10** are available.

Bioconductor also has a list of images which have been recently
deprecated. These images can be obtained in the following way.

```
BiocDockerManager::available(deprecated=TRUE) %>%
    select(IMAGE, DESCRIPTION)
```

```
## # A tibble: 34 x 2
##    IMAGE           DESCRIPTION
##    <chr>           <chr>
##  1 release_base    DEPRECATED - release base container
##  2 release_core    DEPRECATED - release core container
##  3 devel_base2     DEPRECATED - Automated Build Bioconductor Develement Base Do…
##  4 devel_core2     DEPRECATED - Automated Build Bioconductor Develement Core Do…
##  5 release_flow    DEPRECATED - release container for flow cytometry packages
##  6 devel_core      DEPRECATED - devel core container
##  7 devel_mscore2   DEPRECATED - Automated Build Bioconductor Develement mscore …
##  8 release_core2   DEPRECATED - Bioconductor Release Core Docker Container
##  9 release_sequen… DEPRECATED - release container for sequencing packages
## 10 release_microa… DEPRECATED - release container for microarray packages
## # … with 24 more rows
```

## 3.2 Help regarding Bioconductor images

The custom help function takes users to the Bioconductor Docker help
page. This provides easy access to the help page should they need
it. The help page contains all the information needed on how to start
up the `bioconductor/bioconductor_docker` image, and use it.

```
if(do_it) {
    BiocDockerManager::help()
}
```

## 3.3 Install or “pull” a docker image

The `install()` function lets users download or pull new images on to
their machine. This function comes in handy when users are trying to
get a new `bioconductor_docker` image on their machine.

The function pulls the image from **Dockerhub** which is always kept
up to date.

```
if (do_it) {
    BiocDockerManager::install(
        repository = "bioconductor/bioconductor_docker",
        tag = "latest"
    )
}
```

## 3.4 Installed images on local machine

The `installed()` function allows the users to check which images are
installed on their local machine. This is similar to checking with the
docker command line function `docker images`.

For this function to work you need to have the Docker engine running.

```
if (do_it)
    BiocDockerManager::installed()
```

You can also filter the list of installed images by providing the
`repository` argument

```
if (do_it)
    BiocDockerManager::installed(
        repository = "bioconductor/bioconductor_docker"
    )
```

## 3.5 Image details

Bioconductor developed and distributed images that have a required
standard. Each Dockerfile which is built into an image, has `LABEL`
fields which identify the maintainer, version, description, url and a
few other entities. These `LABEL` fields serve a similar purpose to
the DESCRIPTION file in a Bioconductor package.

The following functions allow to query the Docker image for these
`LABEL` identities.

Since these functions are specific to Bioconductor Docker images, they
will not work when given generic docker images.

NOTE: These images need to be present on your local machine before you
can query for the LABEL.

```
if (do_it) {
    ## Get version for the "latest" tag bioconductor image
    BiocDockerManager::maintainer(
        repository = "bioconductor/bioconductor_docker",
        tag = "latest"
    )

    ## The above functions works the same as
    BiocDockerManager::maintainer(tag = "latest")
}
```

The version number of the Docker image is very informative as it tells
us the Bioconductor version number in the `x.y` coordinates, and the `.z`
informs us the version of the Dockerfile which is used to build the
Docker image.

```
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
```

## 3.6 Check validity of images

It is always a good idea to check if the images you are running are
the latest ones produced by Bioconductor and if they are up to date.

The `valid()` function takes the **digest** of the docker image you
have locally and the docker image hosted on Dockerhub to check if the
digest SHA’s match.

If the docker image is not updated, you might want to `install()` the
latest version of the Docker image.

The function returns a tibble with the images that need to be updated.
The tibble contains repository name and tag.

```
if(do_it) {
    BiocDockerManager::valid(
        repository = "bioconductor/bioconductor_docker",
        tag = "latest"
    )
}
```

## 3.7 Dockerfile template for Bioconductor images

This `use_dockerfile()` functionality is for people who want to
contribute Docker images to the Bioconductor ecosystem. The function
has side-effects where it creates a directory and populates it with a
**Dockerfile** and **README.md**.

The Dockerfile has fields which are required for the submission process
of the Docker image.

There are best practices and standards on how to contribute new docker
images to Bioconductor. The following link has more information.
<http://bioconductor.org/help/docker/#contribute>

```
BiocDockerManager::use_dockerfile()
```

# 4 Example Workflow

We hope to provide functionality which is useful to R and Bioconductor
Docker users in the form of an R package.

The typical workflow would look like the following:

First, you check the `available()` images. Then you `install()` a
required image say **bioconductor/bioconductor\_docker:devel**.

```
if (do_it) {

    ## 1. Check available images
    BiocDockerManager::available()

    ## 2. Install a new image
    BiocDockerManager::install(
        repository = "bioconductor/bioconductor_docker",
        tag = "devel"
    )
}
```

Once some time has passed and if you are not sure if you image is up
to date, you have to check if the image is `valid()`.

Then, `install()` an update if the validity check returns that it is
out of date. Check the `version()` of the latest image to make sure
you understand the consequences of updating.

```
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
```

These are just general examples on how to use this package and it’s
functionality.

# 5 sessionInfo

```
sessionInfo()
```

```
## R version 4.0.0 (2020-04-24)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.4 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.11-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.11-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] dplyr_0.8.5             BiocDockerManager_1.0.1 BiocStyle_2.16.0
##
## loaded via a namespace (and not attached):
##  [1] Rcpp_1.0.4.6        whisker_0.4         knitr_1.28
##  [4] magrittr_1.5        hms_0.5.3           tidyselect_1.1.0
##  [7] R6_2.4.1            rlang_0.4.6         fansi_0.4.1
## [10] httr_1.4.1          stringr_1.4.0       tools_4.0.0
## [13] xfun_0.13           utf8_1.1.4          cli_2.0.2
## [16] htmltools_0.4.0     ellipsis_0.3.0      yaml_2.2.1
## [19] digest_0.6.25       assertthat_0.2.1    tibble_3.0.1
## [22] lifecycle_0.2.0     crayon_1.3.4        bookdown_0.18
## [25] readr_1.3.1         purrr_0.3.4         BiocManager_1.30.10
## [28] vctrs_0.3.0         curl_4.3            glue_1.4.0
## [31] evaluate_0.14       rmarkdown_2.1       stringi_1.4.6
## [34] compiler_4.0.0      pillar_1.4.4        jsonlite_1.6.1
## [37] pkgconfig_2.0.3
```