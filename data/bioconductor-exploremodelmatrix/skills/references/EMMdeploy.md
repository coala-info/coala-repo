# Deploying ExploreModelMatrix on a Shiny Server

#### Charlotte Soneson, Federico Marini, Michael I Love, Florian Geier and Michael B Stadler

#### 2025-10-29

# Why deploying `ExploreModelMatrix` on a Shiny server?

While the installation of `ExploreModelMatrix` locally is a relatively straightforward operation, sometimes you might require an instance of it running on a server, e.g. for teaching purposes, or to provide a working version of it because you or your collaborators are lacking admin rights.

One possible solution would be to access the instance running at <http://shiny.imbei.uni-mainz.de:3838/ExploreModelMatrix>, which we provide also for demonstration purposes. Alternatively, you might need to deploy `ExploreModelMatrix` for internal use, or with a different set of examples/functionality. This vignette details the steps to do so - it might still require the intervention of your local IT service, and some degree of tech savvyness.

# How to deploy `ExploreModelMatrix`

## Step 1: Setting up the Shiny Server

You should mainly refer to this excellent reference: <http://docs.rstudio.com/shiny-server/>, the Administrator’s Guide beautifully written and maintained by the RStudio team.

In the case of the instance linked above (<http://shiny.imbei.uni-mainz.de:3838/ExploreModelMatrix>), the deployment is on a Ubuntu-based server. If this is your case too, please go to <https://docs.rstudio.com/shiny-server/#ubuntu-14.04>

If you are already familiar with Shiny Server, you can consider going directly here: <http://docs.rstudio.com/shiny-server/#quick-start>

Follow the indications in the main reference guide to see whether you have all packages installed, and visit the address which will refer to the address of your server (<http://your.server.address:3838/sample-apps/hello/>).

## Step 2: setup `ExploreModelMatrix`

You need to:

* install `ExploreModelMatrix`
* setup `ExploreModelMatrix` on the server

### Installing `ExploreModelMatrix`

You need first to install Bioconductor

```
sudo su - -c "R -e \"install.packages('BiocManager')\""
```

Once that is done, you can install `ExploreModelMatrix` with

```
sudo su - -c "R -e \"BiocManager::install('ExploreModelMatrix')\""
```

You can also install the development version of `ExploreModelMatrix` from GitHub with

```
# install remotes first
sudo su - -c "R -e \"BiocManager::install('remotes')\""
# and then ExploreModelMatrix
sudo su - -c "R -e \"BiocManager::install('csoneson/ExploreModelMatrix')\""
```

Keep in mind that if you are running the server as root, you could simply open R in the terminal and install the required packages with

```
## To be done once
install.packages("BiocManager")
BiocManager::install("ExploreModelMatrix")
## For the devel version on GitHub
BiocManager::install("csoneson/ExploreModelMatrix")
```

### Setup `ExploreModelMatrix` on the server

You essentially need to do two things:

* in `/srv/shiny-server`, create a folder (e.g. via `mkdir`) named `ExploreModelMatrix`, and create a file in there called `app.R`. Edit its content (e.g. with `vi`, `nano`, or any other editor), copy-pasting the following lines:

```
library("ExploreModelMatrix")
ExploreModelMatrix()
```

* you need to edit `/etc/shiny-server/shiny-server.conf`. To do this, again use any text editor (e.g. `vi`), and add the following lines

```
server {
  listen 3838;

  #...

  ### FROM HERE
  location /ExploreModelMatrix {
    # Run this location in 'app_dir' mode, which will host a single Shiny
    # Application available at '/srv/shiny-server/myApp'
    app_dir /srv/shiny-server/ExploreModelMatrix;

    # Log all Shiny output to files in this directory
    log_dir /var/log/shiny-server/ExploreModelMatrix;

    # When a user visits the base URL rather than a particular application,
    # an index of the applications available in this directory will be shown.
    directory_index off;

    # recommended, to wait for the application to start
    app_init_timeout 250;
  }
  ### TO HERE

  # ...
}
```

You might need to restart the Shiny Server (`systemctl restart shiny-server` on Ubuntu). Then you should be good to go!

Visit <http://your.server.address:3838/ExploreModelMatrix> for your personal running instance.

## `ExploreModelMatrix` at the IMBEI

<http://shiny.imbei.uni-mainz.de:3838/ExploreModelMatrix> is the address for the public instance of `ExploreModelMatrix` on the Shiny Server I manage at the Institute of Medical Biostatistics, Epidemiology and Informatics.

The relevant setup of that machine is the following (in case you are asking what specs you need):

* 4 cores
* 8 GB RAM

```
lsb_release -a

  No LSB modules are available.
  Distributor ID: Ubuntu
  Description: Ubuntu 16.04.2 LTS
  Release: 16.04
  Codename: xenial
```

# Session info

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
#> [1] ExploreModelMatrix_1.22.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyr_1.3.1          sass_0.4.10          generics_0.1.4
#>  [4] digest_0.6.37        magrittr_2.0.4       evaluate_1.0.5
#>  [7] grid_4.5.1           RColorBrewer_1.1-3   fastmap_1.2.0
#> [10] jsonlite_2.0.0       limma_3.66.0         promises_1.4.0
#> [13] purrr_1.1.0          scales_1.4.0         jquerylib_0.1.4
#> [16] shinydashboard_0.7.3 cli_3.6.5            shiny_1.11.1
#> [19] rlang_1.1.6          cowplot_1.2.0        cachem_1.1.0
#> [22] yaml_2.3.10          otel_0.2.0           tools_4.5.1
#> [25] rintrojs_0.3.4       dplyr_1.1.4          ggplot2_4.0.0
#> [28] httpuv_1.6.16        DT_0.34.0            BiocGenerics_0.56.0
#> [31] vctrs_0.6.5          R6_2.6.1             mime_0.13
#> [34] stats4_4.5.1         lifecycle_1.0.4      S4Vectors_0.48.0
#> [37] htmlwidgets_1.6.4    MASS_7.3-65          shinyjs_2.1.0
#> [40] pkgconfig_2.0.3      pillar_1.11.1        bslib_0.9.0
#> [43] later_1.4.4          gtable_0.3.6         glue_1.8.0
#> [46] Rcpp_1.1.0           statmod_1.5.1        xfun_0.53
#> [49] tibble_3.3.0         tidyselect_1.2.1     knitr_1.50
#> [52] dichromat_2.0-0.1    farver_2.1.2         xtable_1.8-4
#> [55] htmltools_0.5.8.1    rmarkdown_2.30       compiler_4.5.1
#> [58] S7_0.2.0
```