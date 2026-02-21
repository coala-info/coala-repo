Code

* Show All Code
* Hide All Code

# Introduction to biocthis

Leonardo Collado-Torres1,2\*

1Lieber Institute for Brain Development, Johns Hopkins Medical Campus
2Center for Computational Biology, Johns Hopkins University

\*lcolladotor@gmail.com

#### 29 October 2025

#### Package

biocthis 1.20.0

Note that *[biocthis](https://bioconductor.org/packages/3.22/biocthis)* is not a Bioconductor-core package and as such it is not a Bioconductor official package. It was made by and for Leonardo Collado-Torres so he could more easily maintain and create Bioconductor packages as listed at [lcolladotor.github.io/pkgs/](https://lcolladotor.github.io/pkgs/). Hopefully *[biocthis](https://bioconductor.org/packages/3.22/biocthis)* will be helpful for you too.

# 1 Basics

## 1.1 Install `biocthis`

`R` is an open-source statistical environment which can be easily modified to enhance its functionality via packages. *[biocthis](https://bioconductor.org/packages/3.22/biocthis)* is a `R` package available via the [Bioconductor](http://bioconductor.org) repository for packages. `R` can be installed on any operating system from [CRAN](https://cran.r-project.org/) after which you can install *[biocthis](https://bioconductor.org/packages/3.22/biocthis)* by using the following commands in your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("biocthis")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

You can install the development version from [GitHub](https://github.com/) with:

```
BiocManager::install("lcolladotor/biocthis")
```

## 1.2 Required knowledge

*[biocthis](https://bioconductor.org/packages/3.22/biocthis)* is based on many other packages and in particular in those that have implemented the infrastructure needed for creating tidyverse-style R packages. That is *[usethis](https://CRAN.R-project.org/package%3Dusethis)* (Wickham, Bryan, Barrett, and Teucher, 2025), *[devtools](https://CRAN.R-project.org/package%3Ddevtools)* (Wickham, Hester, Chang, and Bryan, 2025), and *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011). It will also be helpful if you are familiar with *[styler](https://CRAN.R-project.org/package%3Dstyler)* (Müller, Walthert, and Patil, 2025). Finally, we highly recommend that you run *[biocthis](https://bioconductor.org/packages/3.22/biocthis)* within [RStudio Desktop](https://www.rstudio.com/products/rstudio/download).

If you are asking yourself the question “Where do I start using Bioconductor?” you might be interested in [this blog post](http://lcolladotor.github.io/2014/10/16/startbioc/#.VkOKbq6rRuU).

## 1.3 Asking for help

As package developers, we try to explain clearly how to use our packages and in which order to use the functions. But `R` and `Bioconductor` have a steep learning curve so it is critical to learn where to ask for help. The blog post quoted above mentions some but we would like to highlight the [Bioconductor support site](https://support.bioconductor.org/) as the main resource for getting help: remember to use the `biocthis` tag and check [the older posts](https://support.bioconductor.org/tag/biocthis/). Other alternatives are available such as creating GitHub issues and tweeting. However, please note that if you want to receive help you should adhere to the [posting guidelines](http://www.bioconductor.org/help/support/posting-guide/). It is particularly critical that you provide a small reproducible example and your session information so package developers can track down the source of the error.

## 1.4 Citing `biocthis`

We hope that *[biocthis](https://bioconductor.org/packages/3.22/biocthis)* will be useful for your work. Please use the following information to cite the package and the overall approach. Thank you!

```
## Citation info
citation("biocthis")
#> To cite package 'biocthis' in publications use:
#>
#>   Collado-Torres L (2025). _Automate package and project setup for
#>   Bioconductor packages_. doi:10.18129/B9.bioc.biocthis
#>   <https://doi.org/10.18129/B9.bioc.biocthis>,
#>   https://github.com/lcolladotor/biocthisbiocthis - R package version
#>   1.20.0, <http://www.bioconductor.org/packages/biocthis>.
#>
#>   Collado-Torres L (2025). "Automate package and project setup for
#>   Bioconductor packages." _bioRxiv_. doi:10.1101/TODO
#>   <https://doi.org/10.1101/TODO>,
#>   <https://www.biorxiv.org/content/10.1101/TODO>.
#>
#> To see these entries in BibTeX format, use 'print(<citation>,
#> bibtex=TRUE)', 'toBibtex(.)', or set
#> 'options(citation.bibtex.max=999)'.
```

# 2 Quick start to using to `biocthis`

*[biocthis](https://bioconductor.org/packages/3.22/biocthis)* is an R package that expands *[usethis](https://CRAN.R-project.org/package%3Dusethis)* with Bioconductor-friendly templates. These templates will help you quickly create an R package that either has Bioconductor dependencies or that you are thinking of submitting to Bioconductor one day. *[biocthis](https://bioconductor.org/packages/3.22/biocthis)* has functions that can also enhance your current R packages that either are already distributed by Bioconductor or have Bioconductor dependencies. *[biocthis](https://bioconductor.org/packages/3.22/biocthis)* also includes a Bioconductor-friendly [GitHub Actions](https://github.com/features/actions) workflow for your R package(s). To use the functions in this package, you need to load it as shown below.

```
library("biocthis")

## Load other R packages used in this vignette
library("usethis")
library("styler")
```

## 2.1 Using `biocthis` in your R package

If you haven’t made an R package yet, you can do so using *[usethis](https://CRAN.R-project.org/package%3Dusethis)*. That is, utilize `usethis::create_package()` with the package name of your choice. If you are using [RStudio Desktop](https://www.rstudio.com/products/rstudio/download) this function will open a new RStudio window and open R in the correct location. Otherwise, you might need to use `setwd()` to change directories.

In this vignette we will create an example package called `biocthispkg` on a temporary directory and work in this directory in order to illustrate how the functions work. In a real world scenario, you would be working inside your R package and would not run `biocthis_example_pkg()`.

```
## Create an example package for illustrative purposes.
## Note: you do not need to run this for your own package!
pkgdir <- biocthis_example_pkg("biocthispkg", use_git = TRUE)
#> ✔ Creating '/tmp/RtmpInwReq/biocthispkg/'.
#> ✔ Setting active project to "/tmp/RtmpInwReq/biocthispkg".
#> ✔ Creating 'R/'.
#> ✔ Writing 'DESCRIPTION'.
#> Package: biocthispkg
#> Title: What the Package Does (One Line, Title Case)
#> Version: 0.0.0.9000
#> Authors@R (parsed):
#>     * First Last <first.last@example.com> [aut, cre]
#> Description: What the package does (one paragraph).
#> License: `use_mit_license()`, `use_gpl3_license()` or friends to pick a
#>     license
#> Encoding: UTF-8
#> Roxygen: list(markdown = TRUE)
#> RoxygenNote: 7.3.3
#> ✔ Writing 'NAMESPACE'.
#> ✔ Setting active project to "<no active project>".
#> ✔ Setting active project to "/tmp/RtmpInwReq/biocthispkg".
#> ✔ Initialising Git repo.
#> ✔ Adding ".Rproj.user", ".Rhistory", ".RData", ".httr-oauth", ".DS_Store", and
#>   ".quarto" to '.gitignore'.
```

Once you have created a package, you can use `use_bioc_pkg_templates()` to create a set of scripts in the `dev` (developer) directory.

```
## Create the bioc templates
biocthis::use_bioc_pkg_templates()
#> ✔ Creating 'dev/'.
#> ✔ Adding "^dev$" to '.Rbuildignore'.
#> ✔ Adding "dev" to '.gitignore'.
#> ✔ Writing 'dev/01_create_pkg.R'.
#> ✔ Writing 'dev/02_git_github_setup.R'.
#> ✔ Writing 'dev/03_core_files.R'.
#> ✔ Writing 'dev/04_update.R'.
```

If you run `use_bioc_pkg_templates()` inside RStudio Desktop, then all the scripts will open on your RStudio window. Each script contains comments that will guide you on the steps you need to do to create your Bioconductor-friendly R package. These scripts are:

* `01_create_pkg.R`
  + Helps you install R packages needed for developing R packages with these template scripts.
  + Helps you check if the R package name you chose is available.
  + Includes the steps up to running `use_bioc_pkg_templates()`.
* `02_git_github_setup.R`
  + Ignores the `*.Rproj` files to comply with Bioconductor’s requirements
  + Initializes a git repository
  + Creates the corresponding GitHub repository
* `03_core_files.R`
  + Creates Bioconductor-friendly `README.Rmd` and `NEWS.md` files
  + Creates Bioconductor-friendly GitHub templates for issues, feature requests, and support requests
  + Uses the tidyverse-style GitHub contributing and code of conduct files
  + Creates a template Bioconductor-friendly `CITATION` file
  + Adds several badges to the `README.Rmd` file 111 You might want to use *[badger](https://CRAN.R-project.org/package%3Dbadger)* too, which has badges for Bioconductor download statistics. Some of the badges are only tailored for Bioconductor *software* packages, so you’ll have to edit them for annotation, experiment and workflow packages.
  + Sets up unit tests using *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)
  + Adds a Bioconductor-friendly GitHub Actions workflow
  + Adds a `pkgdown/extra.css` file for configuring *[pkgdown](https://CRAN.R-project.org/package%3Dpkgdown)* (Wickham, Hesselberth, Salmon, Roy, and Brüggemann, 2025) documentation websites with Bioconductor’s official colors
  + Deploys an initial documentation website using *[pkgdown](https://CRAN.R-project.org/package%3Dpkgdown)* (Wickham, Hesselberth, Salmon et al., 2025)
* `04_update.R`
  + Automatically styles the R code in your package using *[styler](https://CRAN.R-project.org/package%3Dstyler)* (Müller, Walthert, and Patil, 2025)
  + Update the documentation file using *[devtools](https://CRAN.R-project.org/package%3Ddevtools)* (Wickham, Hester, Chang et al., 2025)

Many of these steps are powered by *[usethis](https://CRAN.R-project.org/package%3Dusethis)* (Wickham, Bryan, Barrett et al., 2025) with some of them utilizing *[biocthis](https://bioconductor.org/packages/3.22/biocthis)* (Collado-Torres, 2025).

# 3 `biocthis` functions overview

The `dev` scripts use the different functions provided by *[biocthis](https://bioconductor.org/packages/3.22/biocthis)* in the suggested order. However, below we give a brief overview of what they do.

## 3.1 `use_bioc_badges()`

Creates several Bioconductor badges for software packages (you will need to edit them for *experiment data*, *annotation*, *workflow*, or *book* packages) on your `README` files.

```
## Create some Bioconductor software package badges on your README files
biocthis::use_bioc_badges()
#> ! Can't find a README for the current project.
#> ℹ See `usethis::use_readme_rmd()` for help creating this file.
#> ℹ Badge link will only be printed to screen.
#> ☐ Copy and paste the following lines into 'README':
#>   <!-- badges: start -->
#>   [![Bioc release status](http://www.bioconductor.org/shields/build/release/bioc/biocthispkg.svg)](https://bioconductor.org/checkResults/release/bioc-LATEST/biocthispkg)
#>   <!-- badges: end -->
#> ! Can't find a README for the current project.
#> ℹ See `usethis::use_readme_rmd()` for help creating this file.
#> ℹ Badge link will only be printed to screen.
#> ☐ Copy and paste the following lines into 'README':
#>   <!-- badges: start -->
#>   [![Bioc devel status](http://www.bioconductor.org/shields/build/devel/bioc/biocthispkg.svg)](https://bioconductor.org/checkResults/devel/bioc-LATEST/biocthispkg)
#>   <!-- badges: end -->
#> ! Can't find a README for the current project.
#> ℹ See `usethis::use_readme_rmd()` for help creating this file.
#> ℹ Badge link will only be printed to screen.
#> ☐ Copy and paste the following lines into 'README':
#>   <!-- badges: start -->
#>   [![Bioc downloads rank](https://bioconductor.org/shields/downloads/release/biocthispkg.svg)](http://bioconductor.org/packages/stats/bioc/biocthispkg/)
#>   <!-- badges: end -->
#> ! Can't find a README for the current project.
#> ℹ See `usethis::use_readme_rmd()` for help creating this file.
#> ℹ Badge link will only be printed to screen.
#> ☐ Copy and paste the following lines into 'README':
#>   <!-- badges: start -->
#>   [![Bioc support](https://bioconductor.org/shields/posts/biocthispkg.svg)](https://support.bioconductor.org/tag/biocthispkg)
#>   <!-- badges: end -->
#> ! Can't find a README for the current project.
#> ℹ See `usethis::use_readme_rmd()` for help creating this file.
#> ℹ Badge link will only be printed to screen.
#> ☐ Copy and paste the following lines into 'README':
#>   <!-- badges: start -->
#>   [![Bioc history](https://bioconductor.org/shields/years-in-bioc/biocthispkg.svg)](https://bioconductor.org/packages/release/bioc/html/biocthispkg.html#since)
#>   <!-- badges: end -->
#> ! Can't find a README for the current project.
#> ℹ See `usethis::use_readme_rmd()` for help creating this file.
#> ℹ Badge link will only be printed to screen.
#> ☐ Copy and paste the following lines into 'README':
#>   <!-- badges: start -->
#>   [![Bioc last commit](https://bioconductor.org/shields/lastcommit/devel/bioc/biocthispkg.svg)](http://bioconductor.org/checkResults/devel/bioc-LATEST/biocthispkg/)
#>   <!-- badges: end -->
#> ! Can't find a README for the current project.
#> ℹ See `usethis::use_readme_rmd()` for help creating this file.
#> ℹ Badge link will only be printed to screen.
#> ☐ Copy and paste the following lines into 'README':
#>   <!-- badges: start -->
#>   [![Bioc dependencies](https://bioconductor.org/shields/dependencies/release/biocthispkg.svg)](https://bioconductor.org/packages/release/bioc/html/biocthispkg.html#since)
#>   <!-- badges: end -->
```

This function was contributed by [Milan Malfait (`@milanmlft`)](https://github.com/milanmlft) at [pull request 35](https://github.com/lcolladotor/biocthis/pull/35).

## 3.2 `bioc_style()`

`bioc_style()` helps you automatically apply a coding style to your R package files using *[styler](https://CRAN.R-project.org/package%3Dstyler)* (Müller, Walthert, and Patil, 2025) that is based on the [tidyverse coding style guide](https://style.tidyverse.org/) but modified to make it more similar to the [Bioconductor coding style guide](http://bioconductor.org/developers/how-to/coding-style/).

```
## Automatically style the example package
styler::style_pkg(pkgdir, transformers = biocthis::bioc_style())
#> ────────────────────────────────────────
#> Status   Count   Legend
#> ✔    0   File unchanged.
#> ℹ    0   File changed.
#> ✖    0   Styling threw an error.
#> ────────────────────────────────────────
```

## 3.3 `use_bioc_citation()`

`use_bioc_citation()` creates an R package `CITATION` file at `inst/CITATION` that is pre-populated with information you might want to use for your (future) Bioconductor package such as the Bioconductor DOIs and reference a journal article describing your package (that you might consider submitting to [bioRxiv](https://www.biorxiv.org/) as a pre-print first). Alternatively, use `usethis::use_citation()`.

```
## Create a template CITATION file that is Bioconductor-friendly
biocthis::use_bioc_citation()
#> ✔ Creating 'inst/'.
#> ✔ Writing 'inst/CITATION'.
#> ☐ Edit 'inst/CITATION'.
```

## 3.4 `use_bioc_description()`

`use_bioc_description()` creates an R package `DESCRIPTION` file that is pre-populated with information you might want to use for your (future) Bioconductor package such as links to the Bioconductor Support Website and `biocViews`. You will still need to manually edit the file. Alternatively, use `usethis::use_description()`.

```
## Create a template DESCRIPTION file that is Bioconductor-friendly
biocthis::use_bioc_description()
#> ℹ Leaving 'DESCRIPTION' unchanged.
#> Package: biocthispkg
#> Title: What the Package Does (One Line, Title Case)
#> Version: 0.99.0
#> Date: 2025-10-29
#> Authors@R (parsed):
#>     * First Last <first.last@example.com> [aut, cre]
#> Description: What the package does (one paragraph).
#> License: Artistic-2.0
#> URL:
#> BugReports:
#> Encoding: UTF-8
#> Roxygen: list(markdown = TRUE)
#> RoxygenNote: 7.3.3
#> biocViews: Software
```

## 3.5 `use_bioc_feature_request_template()`

This function is related to `use_bioc_issue_template()`, as it creates a GitHub issue template file specifically tailored for feature requests. It is pre-populated with information you might want to users to provide when giving this type of feedback.

```
## Create a GitHub template for feature requests that is Bioconductor-friendly
biocthis::use_bioc_feature_request_template()
#> ✔ Creating '.github/'.
#> ✔ Adding "^\\.github$" to '.Rbuildignore'.
#> ✔ Adding "*.html" to '.github/.gitignore'.
#> ✔ Creating '.github/ISSUE_TEMPLATE/'.
#> ✔ Writing '.github/ISSUE_TEMPLATE/feature_request_template.md'.
```

This function was added after a related contribution by [Marcel Ramos (`@LiNk-NY`)](https://github.com/LiNk-NY) at [pull request 33](https://github.com/lcolladotor/biocthis/pull/33).

## 3.6 `use_bioc_github_action()`

### 3.6.1 Getting started

`use_bioc_github_action()` creates a GitHub Actions (GHA) workflow file that is configured to be Bioconductor-friendly. Alternatively, use `usethis::use_github_action()` for the general GitHub Actions workflow maintained by `r-lib/actions`. If this is your first time seeing the words *GitHub Actions*, we highly recommend that you watch [Jim Hester’s `rstudio::conf(2020)` talk on this subject](https://www.jimhester.com/talk/2020-rsc-github-actions/). Here is how you can add this GHA workflow to your R package:

```
## Create a GitHub Actions workflow that is Bioconductor-friendly
biocthis::use_bioc_github_action()
#> ✔ Creating '.github/workflows/'.
#> ✔ Writing '.github/workflows/check-bioc.yml'.
```

### 3.6.2 Main GHA workflow features

This [GitHub Actions](https://github.com/features/actions) (GHA) workflow is based on [r-lib/actions//examples/check-standard.yaml](https://github.com/r-lib/actions/blob/master/examples/check-standard.yaml) and others. The goal is to provide on demand `R CMD check`s on Linux, macOS and Windows using a similar setup to Bioconductor-devel and release branches. Some key features that make this GHA workflow Bioconductor-friendly are:

* It runs `R CMD check` on the same platforms (Linux, macOS and Windows) that Bioconductor supports.
* It runs `BiocCheck::BiocCheck()` on all these platforms, unlike the Bioconductor nightly builds. *[BiocCheck](https://bioconductor.org/packages/3.22/BiocCheck)* is complementary to `R CMD check` and can help you improve your R package.
* It uses the [Bioconductor devel and release dockers](https://www.bioconductor.org/help/docker/) to test your package on Linux. Since all system dependencies required by Bioconductor packages are already included in these docker images, it’s unlikely that you’ll need to fiddle with Linux system dependencies. The information on the docker image is then used for configuring the macOS and Windows tests.

### 3.6.3 Additional features

Furthermore, the `use_bioc_github_action()` GHA workflow provides the following features:

* It runs *[covr](https://CRAN.R-project.org/package%3Dcovr)* (Hester, 2023) unless disabled by the environment variable **`run_covr`** (see the first few lines of the workflow).
* It automatically deploys a documentation website using *[pkgdown](https://CRAN.R-project.org/package%3Dpkgdown)* (Wickham, Hesselberth, Salmon et al., 2025) unless disabled by the environment variable **`run_pkgdown`** (see the first few lines of the workflow). With `use_bioc_pkgdown_css()` you can also create the `pkgdown/extra.css` file that will configure your *[pkgdown](https://CRAN.R-project.org/package%3Dpkgdown)* (Wickham, Hesselberth, Salmon et al., 2025) documentation website with Bioconductor’s official colors.
* It displays the information from *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011) unless disabled by the environment variable **`has_testthat`** (see the first few lines of the workflow). Similarly, **`has_RUnit`** controls whether you want to run the `RUnit` tests described in the [Bioconductor unit testing guidelines](http://bioconductor.org/developers/how-to/unitTesting-guidelines/).
* It caches the R packages and re-uses them for future tests except if you use the keyword `/nocache` in your commit message. Using **`/nocache`** can be helpful for debugging purposes. The caches are specific to the platform, the R version, and the Bioconductor version 222 In some situations, you might want to change the **`cache_version`** environment variable to force GHA to use new caches.. These caches help you speed up your checks and are updated after a successful build.
* The machines provided by GitHub have 7GB of RAM, 2 cores and 14 GB of disk as noted in their [help pages](https://help.github.com/en/actions/reference/virtual-environments-for-github-hosted-runners). It’s free for open source projects, but you can also pay to use it on private repositories as explained [in their features website](https://github.com/features/actions).

### 3.6.4 Configure options

To help you set some of these configuration environment variables in the GHA workflow, `use_bioc_github_action()` has a few arguments that are used to update a template and customize it for your particular repository. Several of the arguments in `use_bioc_github_action()` use `base::getOption()`, which enables you to edit your R profile file with `usethis::edit_r_profile()` and add lines such as the ones mentioned in the code below.

```
## Open your .Rprofile file with usethis::edit_r_profile()

## For biocthis
options("biocthis.pkgdown" = TRUE)
options("biocthis.testthat" = TRUE)
```

### 3.6.5 Automatically scheduled tests

You could also edit the resulting GHA workflow to run automatically every few days (for example, every Monday) by adding a `cron` line as described in the [official GHA documentation](https://docs.github.com/en/free-pro-team%40latest/actions/reference/workflow-syntax-for-github-actions#onschedule). This could of interest to you in some situations, though you should also be aware that it will use your GHA compute time that can have limits depending on your GitHub account and repository settings. If you are setting up a `cron` scheduled job, you might find [crontab.guru](https://crontab.guru/) useful.

Ultimately, there are many things you can do with GHA and you might want to use workflow as the basis for building *[bookdown](https://CRAN.R-project.org/package%3Dbookdown)* or *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* websites, or even `docker` images. Some examples are:

* [lcolladotor/bioc\_team\_ds](https://github.com/lcolladotor/bioc_team_ds/blob/master/.github/workflows/build_book_bioc_docker.yml) for *[bookdown](https://CRAN.R-project.org/package%3Dbookdown)*.
* [LieberInstitute/recountWorkshop2020](https://github.com/LieberInstitute/recountWorkshop2020/blob/master/.github/workflows/check-bioc.yml) for creating a `docker` image at the end.

### 3.6.6 Notes about GHA workflows

Using a GitHub Actions workflow with Bioconductor-devel (R-devel six months in the year), regardless of which GHA workflow you use specifically, will expose you to issues with installing R packages in the latest versions of Bioconductor, CRAN, GitHub and elsewhere. At [r-lib/actions#where-to-find-help](https://github.com/r-lib/actions#where-to-find-help) you can find a list of steps you can take to get help for R GHA workflows. In the end, you might have to ask for help in:

* developer-oriented mailing lists,
* GitHub repositories for the packages you have issues installing them with,
* GitHub Actions repositories, and elsewhere.

That is, the GHA workflow provided by *[biocthis](https://bioconductor.org/packages/3.22/biocthis)* can break depending on changes upstream of it. In particular, it can stop working:

* just prior to a new R release (unless `r-lib/actions` supports R `alpha` releases),
* if the required Bioconductor docker image is not available (for example, due to issues building these images based on dependencies on `rocker` and other upstream tools) 333 See for example [rocker-versioned2 issue 50](https://github.com/rocker-org/rocker-versioned2/issues/50). .

We highly recommend watching any developments as they happen at *[actions](https://github.com/r-lib/actions)* since the `r-lib` team does an excellent job keeping their GHA workflows updated. You can do so by subscribing to the [RSS atom feed](https://github.com/r-lib/actions/commits/v2.atom) for commits in their repository processed through [RSS FeedBurner](https://feeds.feedburner.com/recentcommitstoactionsv2) that you can [subscribe to by email](https://feedburner.google.com/fb/a/mailverify?uri=RecentCommitsToActionsv2).

If you are interested in learning more details about how this GHA workflow came to be, check the [`biocthis developer notes` vignette](https://lcolladotor.github.io/biocthis/articles/biocthis_dev_notes.html).

## 3.7 `use_bioc_issue_template()`

`use_bioc_issue_template()` creates a GitHub issue template file that is pre-populated with information you might want to use for your (future) Bioconductor package such as links to the Bioconductor Support Website and examples of the information you can ask users to provide that will make it easier for you to help your users. Alternatively, use `usethis::use_tidy_issue_template()`.

```
## Create a GitHub issue template file that is Bioconductor-friendly
biocthis::use_bioc_issue_template()
#> ✔ Writing '.github/ISSUE_TEMPLATE/issue_template.md'.
```

This function was greatly modified in a contribution by [Marcel Ramos (`@LiNk-NY`)](https://github.com/LiNk-NY) at [pull request 33](https://github.com/lcolladotor/biocthis/pull/33)

## 3.8 `use_bioc_news_md()`

`use_bioc_news_md()` creates a `NEWS.md` template file that is pre-populated with information you might want to use for your (future) Bioconductor package. Alternatively, use `usethis::use_news_md()`.

```
## Create a template NEWS.md file that is Bioconductor-friendly
biocthis::use_bioc_news_md()
#> ✔ Writing 'NEWS.md'.
```

## 3.9 `use_bioc_pkg_templates()`

This function was already described in detail in the previous main section.

## 3.10 `use_bioc_pkgdown_css()`

`use_bioc_pkgdown_css()` creates the `pkgdown/extra.css` file that configures your *[pkgdown](https://CRAN.R-project.org/package%3Dpkgdown)* (Wickham, Hesselberth, Salmon et al., 2025) documentation website with Bioconductor’s official colors.

```
## Create the pkgdown/extra.css file to configure pkgdown with
## Bioconductor's official colors
biocthis::use_bioc_pkgdown_css()
#> ✔ Creating 'pkgdown/'.
#> ✔ Writing 'pkgdown/extra.css'.
```

This function was created after [issue 34](https://github.com/lcolladotor/biocthis/issues/34) contributed by [Kevin Rue-Albrecht `@kevinrue`](https://github.com/kevinrue).

## 3.11 `use_bioc_readme_rmd()`

`use_bioc_readme_rmd()` creates a `README.Rmd` template file that is pre-populated with information you might want to use for your (future) Bioconductor package such as Bioconductor’s installation instructions, how to cite your package and links to the development tools you used. Alternatively, use `usethis::use_readme_rmd()`.

```
## Create a template README.Rmd file that is Bioconductor-friendly
biocthis::use_bioc_readme_rmd()
#> ✔ Writing 'README.Rmd'.
#> ✔ Adding "^README\\.Rmd$" to '.Rbuildignore'.
#> ✔ Writing '.git/hooks/pre-commit'.
```

## 3.12 `use_bioc_support()`

`use_bioc_support()` creates a template GitHub support template file that is pre-populated with information you might want to use for your (future) Bioconductor package such where to ask for help including the Bioconductor Support website. Alternatively, use `usethis::use_tidy_support()`.

```
## Create a template GitHub support file that is Bioconductor-friendly
biocthis::use_bioc_support()
#> ✔ Writing '.github/SUPPORT.md'.
```

## 3.13 `use_bioc_vignette()`

`use_bioc_vignette()` creates a template vignette file that is pre-populated with information you might want to use for your (future) Bioconductor package. This template includes information on how to cite other packages using *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)*, styling your vignette with *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)*, instructions on how to install your package from Bioconductor, where to ask for help, information a user might need to know before they use your package, as well as the reproducibility information on how the vignette was made powered by *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)*. You will need to spend a significant amount of time editing this vignette as you develop your R package. Alternatively, use `usethis::use_vignette()`.

```
## Create a template vignette file that is Bioconductor-friendly
biocthis::use_bioc_vignette("biocthispkg", "Introduction to biocthispkg")
#> ✔ Adding knitr to 'Suggests' field in DESCRIPTION.
#> ☐ Use `requireNamespace("knitr", quietly = TRUE)` to test if knitr is
#>   installed.
#> ☐ Then directly refer to functions with `knitr::fun()`.
#> ✔ Adding BiocStyle to 'Suggests' field in DESCRIPTION.
#> ☐ Use `requireNamespace("BiocStyle", quietly = TRUE)` to test if BiocStyle is
#>   installed.
#> ☐ Then directly refer to functions with `BiocStyle::fun()`.
#> ✔ Adding RefManageR to 'Suggests' field in DESCRIPTION.
#> ☐ Use `requireNamespace("RefManageR", quietly = TRUE)` to test if RefManageR is
#>   installed.
#> ☐ Then directly refer to functions with `RefManageR::fun()`.
#> ✔ Adding sessioninfo to 'Suggests' field in DESCRIPTION.
#> ☐ Use `requireNamespace("sessioninfo", quietly = TRUE)` to test if sessioninfo
#>   is installed.
#> ☐ Then directly refer to functions with `sessioninfo::fun()`.
#> ✔ Adding testthat to 'Suggests' field in DESCRIPTION.
#> ☐ Use `requireNamespace("testthat", quietly = TRUE)` to test if testthat is
#>   installed.
#> ☐ Then directly refer to functions with `testthat::fun()`.
#> ✔ Adding "knitr" to 'VignetteBuilder'.
#> ✔ Adding "inst/doc" to '.gitignore'.
#> ✔ Creating 'vignettes/'.
#> ✔ Adding "vignettes/*.html" and "vignettes/*.R" to '.gitignore'.
#> ✔ Adding rmarkdown to 'Suggests' field in DESCRIPTION.
#> ☐ Use `requireNamespace("rmarkdown", quietly = TRUE)` to test if rmarkdown is
#>   installed.
#> ☐ Then directly refer to functions with `rmarkdown::fun()`.
#> ✔ Writing 'vignettes/biocthispkg.Rmd'.
#> ☐ Edit 'vignettes/biocthispkg.Rmd'.
```

# 4 Acknowledgments

*[biocthis](https://bioconductor.org/packages/3.22/biocthis)* wouldn’t have been possible without the help of many other R package developers. Please read the full story at the [`biocthis developer notes` vignette](https://lcolladotor.github.io/biocthis/articles/biocthis_dev_notes.html).

Thank you very much! 🙌🏽😊

# 5 Reproducibility

The *[biocthis](https://bioconductor.org/packages/3.22/biocthis)* package (Collado-Torres, 2025) was made possible thanks to:

* R (R Core Team, 2025)
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
* *[covr](https://CRAN.R-project.org/package%3Dcovr)* (Hester, 2023)
* *[devtools](https://CRAN.R-project.org/package%3Ddevtools)* (Wickham, Hester, Chang et al., 2025)
* *[fs](https://CRAN.R-project.org/package%3Dfs)* (Hester, Wickham, and Csárdi, 2025)
* *[glue](https://CRAN.R-project.org/package%3Dglue)* (Hester and Bryan, 2024)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025)
* *[pkgdown](https://CRAN.R-project.org/package%3Dpkgdown)* (Wickham, Hesselberth, Salmon et al., 2025)
* *[rlang](https://CRAN.R-project.org/package%3Drlang)* (Henry and Wickham, 2025)
* *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng, Chang, and Iannone, 2025)
* *[sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo)* (Wickham, Chang, Flight, Müller, and Hester, 2025)
* *[styler](https://CRAN.R-project.org/package%3Dstyler)* (Müller, Walthert, and Patil, 2025)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)
* *[usethis](https://CRAN.R-project.org/package%3Dusethis)* (Wickham, Bryan, Barrett et al., 2025)

This package was developed using *[biocthis](https://bioconductor.org/packages/3.22/biocthis)*.

Code for creating the vignette

```
## Create the vignette
library("rmarkdown")
system.time(render("biocthis.Rmd", "BiocStyle::html_document"))

## Extract the R code
library("knitr")
knit("biocthis.Rmd", tangle = TRUE)
```

Date the vignette was generated.

```
#> [1] "2025-10-29 22:48:04 EDT"
```

Wallclock time spent generating the vignette.

```
#> Time difference of 4.845 secs
```

`R` session information.

```
#> ─ Session info ───────────────────────────────────────────────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.5.1 Patched (2025-08-23 r88802)
#>  os       Ubuntu 24.04.3 LTS
#>  system   x86_64, linux-gnu
#>  ui       X11
#>  language (EN)
#>  collate  C
#>  ctype    en_US.UTF-8
#>  tz       America/New_York
#>  date     2025-10-29
#>  pandoc   2.7.3 @ /usr/bin/ (via rmarkdown)
#>  quarto   1.7.32 @ /usr/local/bin/quarto
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────────────────────────────────────────────
#>  package     * version date (UTC) lib source
#>  askpass       1.2.1   2024-10-04 [2] CRAN (R 4.5.1)
#>  backports     1.5.0   2024-05-23 [2] CRAN (R 4.5.1)
#>  bibtex        0.5.1   2023-01-26 [2] CRAN (R 4.5.1)
#>  BiocManager   1.30.26 2025-06-05 [2] CRAN (R 4.5.1)
#>  BiocStyle   * 2.38.0  2025-10-29 [2] Bioconductor 3.22 (R 4.5.1)
#>  biocthis    * 1.20.0  2025-10-29 [1] Bioconductor 3.22 (R 4.5.1)
#>  bookdown      0.45    2025-10-03 [2] CRAN (R 4.5.1)
#>  brio          1.1.5   2024-04-24 [2] CRAN (R 4.5.1)
#>  bslib         0.9.0   2025-01-30 [2] CRAN (R 4.5.1)
#>  cachem        1.1.0   2024-05-16 [2] CRAN (R 4.5.1)
#>  cli           3.6.5   2025-04-23 [2] CRAN (R 4.5.1)
#>  credentials   2.0.3   2025-09-12 [2] CRAN (R 4.5.1)
#>  desc          1.4.3   2023-12-10 [2] CRAN (R 4.5.1)
#>  digest        0.6.37  2024-08-19 [2] CRAN (R 4.5.1)
#>  evaluate      1.0.5   2025-08-27 [2] CRAN (R 4.5.1)
#>  fastmap       1.2.0   2024-05-15 [2] CRAN (R 4.5.1)
#>  fs            1.6.6   2025-04-12 [2] CRAN (R 4.5.1)
#>  generics      0.1.4   2025-05-09 [2] CRAN (R 4.5.1)
#>  gert          2.1.5   2025-03-25 [2] CRAN (R 4.5.1)
#>  glue          1.8.0   2024-09-30 [2] CRAN (R 4.5.1)
#>  htmltools     0.5.8.1 2024-04-04 [2] CRAN (R 4.5.1)
#>  httr          1.4.7   2023-08-15 [2] CRAN (R 4.5.1)
#>  jquerylib     0.1.4   2021-04-26 [2] CRAN (R 4.5.1)
#>  jsonlite      2.0.0   2025-03-27 [2] CRAN (R 4.5.1)
#>  knitr         1.50    2025-03-16 [2] CRAN (R 4.5.1)
#>  lifecycle     1.0.4   2023-11-07 [2] CRAN (R 4.5.1)
#>  lubridate     1.9.4   2024-12-08 [2] CRAN (R 4.5.1)
#>  magrittr      2.0.4   2025-09-12 [2] CRAN (R 4.5.1)
#>  openssl       2.3.4   2025-09-30 [2] CRAN (R 4.5.1)
#>  pillar        1.11.1  2025-09-17 [2] CRAN (R 4.5.1)
#>  pkgconfig     2.0.3   2019-09-22 [2] CRAN (R 4.5.1)
#>  plyr          1.8.9   2023-10-02 [2] CRAN (R 4.5.1)
#>  purrr         1.1.0   2025-07-10 [2] CRAN (R 4.5.1)
#>  R.cache       0.17.0  2025-05-02 [2] CRAN (R 4.5.1)
#>  R.methodsS3   1.8.2   2022-06-13 [2] CRAN (R 4.5.1)
#>  R.oo          1.27.1  2025-05-02 [2] CRAN (R 4.5.1)
#>  R.utils       2.13.0  2025-02-24 [2] CRAN (R 4.5.1)
#>  R6            2.6.1   2025-02-15 [2] CRAN (R 4.5.1)
#>  Rcpp          1.1.0   2025-07-02 [2] CRAN (R 4.5.1)
#>  RefManageR  * 1.4.0   2022-09-30 [2] CRAN (R 4.5.1)
#>  rlang         1.1.6   2025-04-11 [2] CRAN (R 4.5.1)
#>  rmarkdown     2.30    2025-09-28 [2] CRAN (R 4.5.1)
#>  roxygen2      7.3.3   2025-09-03 [2] CRAN (R 4.5.1)
#>  rprojroot     2.1.1   2025-08-26 [2] CRAN (R 4.5.1)
#>  rstudioapi    0.17.1  2024-10-22 [2] CRAN (R 4.5.1)
#>  sass          0.4.10  2025-04-11 [2] CRAN (R 4.5.1)
#>  sessioninfo * 1.2.3   2025-02-05 [2] CRAN (R 4.5.1)
#>  stringi       1.8.7   2025-03-27 [2] CRAN (R 4.5.1)
#>  stringr       1.5.2   2025-09-08 [2] CRAN (R 4.5.1)
#>  styler      * 1.11.0  2025-10-13 [2] CRAN (R 4.5.1)
#>  sys           3.4.3   2024-10-04 [2] CRAN (R 4.5.1)
#>  testthat      3.2.3   2025-01-13 [2] CRAN (R 4.5.1)
#>  tibble        3.3.0   2025-06-08 [2] CRAN (R 4.5.1)
#>  timechange    0.3.0   2024-01-18 [2] CRAN (R 4.5.1)
#>  usethis     * 3.2.1   2025-09-06 [2] CRAN (R 4.5.1)
#>  vctrs         0.6.5   2023-12-01 [2] CRAN (R 4.5.1)
#>  whisker       0.4.1   2022-12-05 [2] CRAN (R 4.5.1)
#>  withr         3.0.2   2024-10-28 [2] CRAN (R 4.5.1)
#>  xfun          0.53    2025-08-19 [2] CRAN (R 4.5.1)
#>  xml2          1.4.1   2025-10-27 [2] CRAN (R 4.5.1)
#>  yaml          2.3.10  2024-07-26 [2] CRAN (R 4.5.1)
#>
#>  [1] /tmp/RtmpI5UmgA/Rinst36efef448a18c0
#>  [2] /home/biocbuild/bbs-3.22-bioc/R/site-library
#>  [3] /home/biocbuild/bbs-3.22-bioc/R/library
#>  * ── Packages attached to the search path.
#>
#> ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────
```

# 6 Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
with *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2025) and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025) running behind the scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2025rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.30.
2025.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-colladotorres2025automate)
L. Collado-Torres.
*Automate package and project setup for Bioconductor packages*.
<https://github.com/lcolladotor/biocthisbiocthis> - R package version 1.20.0.
2025.
DOI: [10.18129/B9.bioc.biocthis](https://doi.org/10.18129/B9.bioc.biocthis).
URL: <http://www.bioconductor.org/packages/biocthis>.

[[3]](#cite-henry2025rlang)
L. Henry and H. Wickham.
*rlang: Functions for Base Types and Core R and ‘Tidyverse’ Features*.
R package version 1.1.6.
2025.
DOI: [10.32614/CRAN.package.rlang](https://doi.org/10.32614/CRAN.package.rlang).
URL: [https://CRAN.R-project.org/package=rlang](https://CRAN.R-project.org/package%3Drlang).

[[4]](#cite-hester2023covr)
J. Hester.
*covr: Test Coverage for Packages*.
R package version 3.6.4.
2023.
DOI: [10.32614/CRAN.package.covr](https://doi.org/10.32614/CRAN.package.covr).
URL: [https://CRAN.R-project.org/package=covr](https://CRAN.R-project.org/package%3Dcovr).

[[5]](#cite-hester2024glue)
J. Hester and J. Bryan.
*glue: Interpreted String Literals*.
R package version 1.8.0.
2024.
DOI: [10.32614/CRAN.package.glue](https://doi.org/10.32614/CRAN.package.glue).
URL: [https://CRAN.R-project.org/package=glue](https://CRAN.R-project.org/package%3Dglue).

[[6]](#cite-hester2025cross)
J. Hester, H. Wickham, and G. Csárdi.
*fs: Cross-Platform File System Operations Based on ‘libuv’*.
R package version 1.6.6.
2025.
DOI: [10.32614/CRAN.package.fs](https://doi.org/10.32614/CRAN.package.fs).
URL: [https://CRAN.R-project.org/package=fs](https://CRAN.R-project.org/package%3Dfs).

[[7]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[8]](#cite-mller2025styler)
K. Müller, L. Walthert, and I. Patil.
*styler: Non-Invasive Pretty Printing of R Code*.
R package version 1.11.0.
2025.
DOI: [10.32614/CRAN.package.styler](https://doi.org/10.32614/CRAN.package.styler).
URL: [https://CRAN.R-project.org/package=styler](https://CRAN.R-project.org/package%3Dstyler).

[[9]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.38.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[10]](#cite-2025language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2025.
URL: <https://www.R-project.org/>.

[[11]](#cite-wickham2011testthat)
H. Wickham.
“testthat: Get Started with Testing”.
In: *The R Journal* 3 (2011), pp. 5–10.
URL: <https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

[[12]](#cite-wickham2025usethis)
H. Wickham, J. Bryan, M. Barrett, et al.
*usethis: Automate Package and Project Setup*.
R package version 3.2.1.
2025.
DOI: [10.32614/CRAN.package.usethis](https://doi.org/10.32614/CRAN.package.usethis).
URL: [https://CRAN.R-project.org/package=usethis](https://CRAN.R-project.org/package%3Dusethis).

[[13]](#cite-wickham2025sessioninfo)
H. Wickham, W. Chang, R. Flight, et al.
*sessioninfo: R Session Information*.
R package version 1.2.3.
2025.
DOI: [10.32614/CRAN.package.sessioninfo](https://doi.org/10.32614/CRAN.package.sessioninfo).
URL: [https://CRAN.R-project.org/package=sessioninfo](https://CRAN.R-project.org/package%3Dsessioninfo).

[[14]](#cite-wickham2025pkgdown)
H. Wickham, J. Hesselberth, M. Salmon, et al.
*pkgdown: Make Static HTML Documentation for a Package*.
R package version 2.1.3.
2025.
DOI: [10.32614/CRAN.package.pkgdown](https://doi.org/10.32614/CRAN.package.pkgdown).
URL: [https://CRAN.R-project.org/package=pkgdown](https://CRAN.R-project.org/package%3Dpkgdown).

[[15]](#cite-wickham2025devtools)
H. Wickham, J. Hester, W. Chang, et al.
*devtools: Tools to Make Developing R Packages Easier*.
R package version 2.4.6.
2025.
DOI: [10.32614/CRAN.package.devtools](https://doi.org/10.32614/CRAN.package.devtools).
URL: [https://CRAN.R-project.org/package=devtools](https://CRAN.R-project.org/package%3Ddevtools).

[[16]](#cite-xie2025knitr)
Y. Xie.
*knitr: A General-Purpose Package for Dynamic Report Generation in R*.
R package version 1.50.
2025.
URL: <https://yihui.org/knitr/>.