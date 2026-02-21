Code

* Show All Code
* Hide All Code

# BiocBook: write Quarto books with Bioconductor

#### 29 October 2025

#### Package

BiocBook 1.8.0

`BiocBook` is a package to facilitate the creation of
**package-based, versioned online books**. Such books can be used in a variety
of contexts, including **extended technical documentation** (e.g. of an ecosystem
based on multiple packages) or **online workshops**.

`BiocBook` assists authors in:

1. *Writing*: compile a **body of biological and/or bioinformatics knowledge**;
2. *Containerizing*: provide **Docker images** (through GitHub) to reproduce the examples illustrated in the compendium;
3. *Publishing*: let Bioconductor or Github deploy an **online book** to disseminate the compendium;
4. *Versioning*: **automatically** generate specific online book versions and Docker images for specific [Bioconductor releases](https://contributions.bioconductor.org/use-devel.html).

# 1 Main features of `BiocBook`s

`BiocBook`s created with the {`BiocBook`} package and **hosted on GitHub**
are deployed and served on the `gh-pages` branch and a Docker image is available
on [ghcr.io](https://ghcr.io/).

`BiocBook`s created with the {`BiocBook`} package and **submitted to Bioconductor**
are directly available for reading from the Bioconductor website.

Read the [`BiocBookDemo`](http://jserizay.com/BiocBookDemo/devel/#main-features-of-biocbooks)
example book to know more about `BiocBook`s features.

# 2 Creating a `BiocBook`

A new `BiocBook` should be created using the `init(new_package = "...")` function.

This function performs the following operations:

1. It checks that the provided package name is available;
2. It logs in the GitHub user accounts;
3. It creates a new **remote** Github repository using the `BiocBook.template` from `js2264/BiocBook`;
4. It sets up Github Pages to serve the future books from the `gh-pages` branch;
5. It clones the **remote** Github repository to a **local folder**;
6. It edits several placeholders from the template and commits the changes.

```
library(BiocBook)

## Note that `.local = TRUE` is only set here for demonstration.
init("myNewBook", .local = TRUE)
#> ══ Running preflight checklist ═════════════════════════════════════════════════
#> ⠙ Checking that no folder named `myNewBook` already exists
#> ⠙ Checking package name availability
#> ✔ Package name `myNewBook` is available
#> ⠙ Checking package name availability
! Dummy git configured
#> ⠙ Checking package name availability
• git user: `dummy`
#> ⠙ Checking package name availability
• git email: `dummy@dummy.com`
#> ⠙ Checking package name availability
! No GitHub configured
#> ⠙ Checking package name availability
• github user: NULL
#> ⠙ Checking package name availability
• PAT: NULL
#> ⠙ Checking package name availability
#> ══ Initiating a new `BiocBook` ═════════════════════════════════════════════════
#> ⠙ Creating new repository from template provided in BiocBook `inst/` directory`
#> ✔ New local book `myNewBook` successfully created
#> ⠙ Creating new repository from template provided in BiocBook `inst/` directory`
✔ Filled out `inst/assets/_book.yml` fields
#> ⠙ Creating new repository from template provided in BiocBook `inst/` directory`
✔ Filled out `README.md` fields
#> ⠙ Creating new repository from template provided in BiocBook `inst/` directory`
✔ Filled out `DESCRIPTION` fields
#> ⠙ Creating new repository from template provided in BiocBook `inst/` directory`
ℹ Please finish editing the `DESCRIPTION` fields, including:
#> ⠙ Creating new repository from template provided in BiocBook `inst/` directory`
  • Title
#> ⠙ Creating new repository from template provided in BiocBook `inst/` directory`
  • Description
#> ⠙ Creating new repository from template provided in BiocBook `inst/` directory`
  • Authors@R
#> ⠙ Creating new repository from template provided in BiocBook `inst/` directory`
✔ Filled out `inst/index.qmd` fields
#> ⠙ Creating new repository from template provided in BiocBook `inst/` directory`
ℹ Please finish editing the `inst/index.qmd` fields, including the `Welcome` section
#> ⠙ Creating new repository from template provided in BiocBook `inst/` directory`
ℹ The following files need to be committed:
#>   • .Rbuildignore
#>   • .github/
#>   • DESCRIPTION
#>   • Dockerfile
#>   • LICENSE
#>   • LICENSE.md
#>   • NAMESPACE
#>   • README.md
#>   • inst/
#>   • vignettes/
#> ✔ The new files have been commited to the `devel` branch.
#> ── NOTES ───────────────────────────────────────────────────────────────────────
#> ℹ If you wish to change the cover picture, please replace the following file:
#> • inst/assets/cover.png
#> ══ Results ═════════════════════════════════════════════════════════════════════
#> ✔ Local `BiocBook` directory successfully created  : myNewBook
#> ! This book will be only available in local until a Github remote is set.
#>
#> # You can connect to the local directory as follows:
#>   biocbook <- BiocBook('myNewBook')
```

# 3 The `BiocBook` class

A `BiocBook` object acts as a pointer to a local package directory, with
book chapters contained in a `pages/` folder as `.qmd` files.

```
bb <- BiocBook("myNewBook")
bb
#> BiocBook object
#> - local path: /tmp/RtmpoymkRm/Rbuild361acb40137ae6/BiocBook/vignettes/myNewBook
#> - remote url:
#> - Title: myNewBook
#> - Releases(0):
#> - Chapters(1):
#>   • Welcome [/inst/index.qmd]
```

# 4 Editing an existing `BiocBook`

`BiocBook` objects can be modified using the following helper functions:

* `add_preamble(biocbook)` to start writing a preamble;
* `add_chapter(biocbook, title = "...")` to start writing a new chapter;
* `edit_page(biocbook, page = "...")` to edit an existing chapter.

```
add_preamble(bb, open = FALSE)
#> ✔ File created @ `/tmp/RtmpoymkRm/Rbuild361acb40137ae6/BiocBook/vignettes/myNewBook/inst/pages/preamble.qmd`
add_chapter(bb, title = 'Chapter 1', open = FALSE)
#> ✔ File created @ `/tmp/RtmpoymkRm/Rbuild361acb40137ae6/BiocBook/vignettes/myNewBook/inst/pages/chapter-1.qmd`
bb
#> BiocBook object
#> - local path: /tmp/RtmpoymkRm/Rbuild361acb40137ae6/BiocBook/vignettes/myNewBook
#> - remote url:
#> - Title: myNewBook
#> - Releases(0):
#> - Chapters(3):
#>   • Welcome [/inst/index.qmd]
#>   • Preamble [/inst/pages/preamble.qmd]
#>   • Chapter 1 [/inst/pages/chapter-1.qmd]
```

* `preview(biocbook)` will compile (and cache) the book locally. Use it
  to verify that your book renders correctly.

# 5 Publishing an existing `BiocBook`

As long as the local `BiocBook` has been initiated with `init()`,
the writer simply has to commit changes and push them to the `origin` remote.

In `R`, this can be done as follows:

```
publish(bb)
```

The different available versions published in the `origin` `gh-pages` branch
can be listed using `status(biocbook)`.

# 6 Session info

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
#> [1] BiocBook_1.8.0   BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] jsonlite_2.0.0      renv_1.1.5          dplyr_1.1.4
#>  [4] compiler_4.5.1      BiocManager_1.30.26 gitcreds_0.1.2
#>  [7] tidyselect_1.2.1    stringr_1.5.2       callr_3.7.6
#> [10] jquerylib_0.1.4     credentials_2.0.3   yaml_2.3.10
#> [13] fastmap_1.2.0       R6_2.6.1            pak_0.9.0
#> [16] generics_0.1.4      knitr_1.50          BiocGenerics_0.56.0
#> [19] tibble_3.3.0        bookdown_0.45       rprojroot_2.1.1
#> [22] openssl_2.3.4       bslib_0.9.0         pillar_1.11.1
#> [25] rlang_1.1.6         stringi_1.8.7       cachem_1.1.0
#> [28] xfun_0.53           fs_1.6.6            sass_0.4.10
#> [31] sys_3.4.3           cli_3.6.5           withr_3.0.2
#> [34] magrittr_2.0.4      ps_1.9.1            processx_3.8.6
#> [37] digest_0.6.37       gh_1.5.0            askpass_1.2.1
#> [40] gert_2.1.5          lifecycle_1.0.4     vctrs_0.6.5
#> [43] evaluate_1.0.5      glue_1.8.0          rmarkdown_2.30
#> [46] purrr_1.1.0         httr_1.4.7          usethis_3.2.1
#> [49] tools_4.5.1         pkgconfig_2.0.3     htmltools_0.5.8.1
```