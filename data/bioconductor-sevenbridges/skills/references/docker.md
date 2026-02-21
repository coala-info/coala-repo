# Creating Your Docker Container and Command Line Interface (with docopt)

#### 2025-10-30

# 1 Introduction

**In progress**

In this tutorial, we will go through ways to

* Make native command line interface in R

There are many fun ways to do it, here I am more focused for R developers.

## 1.1 Existing Docker repos

Before you create any, make sure you don’t re-invent the wheel and use the best base image for your container as your tool chain may save your lots of time later on.

### 1.1.1 Rocker Project

Official R Docker images is called “Rocker”" project and is on [GitHub](https://github.com/rocker-org/rocker), please visit the page to find more details and Dockerfile.

| Image | Description |
| --- | --- |
| `rocker/r-base` | base package to build from |
| `rocker/r-devel` | base + R-devel from SVN |
| `rocker/rstudio` | base + RStudio Server |
| `rocker/hadleyverse` | rstudio + Hadley’s packages, LaTeX |
| `rocker/ropensci` | hadleyverse + rOpenSci packages |
| `rocker/r-devel-san` | base, SVN’s R-devel and SAN |

### 1.1.2 Bioconductor Images

Bioconductor have a nice [page](https://bioconductor.org/help/docker/) about the official Docker images, please read for more details.

| Image (release branch) | Image (development branch) |
| --- | --- |
| `bioconductor/release_base` | `bioconductor/devel_base` |
| `bioconductor/release_core` | `bioconductor/devel_core` |
| `bioconductor/release_flow` | `bioconductor/devel_flow` |
| `bioconductor/release_microarray` | `bioconductor/devel_microarray` |
| `bioconductor/release_proteomics` | `bioconductor/devel_proteomics` |
| `bioconductor/release_sequencing` | `bioconductor/devel_sequencing` |
| `bioconductor/release_metabolomics` | `bioconductor/devel_metabolomics` |

To understand the image quickly here is the short instruction for the image name:

* **release** images are based on `rocker/rstudio`
* **devel** images are based on `rocker/rstudio-daily`
* **base**: Contains R, RStudio, and system dependencies.
* **core**: base + a selection of core packages.
* **flow**: core + all packages tagged with the *FlowCytometry* biocView.
* **microarray**: core + all packages tagged with the *Microarray* biocView.
* **proteomics**: core + all packages tagged with the *Proteomics* biocView.
* **sequencing**: core + all packages tagged with the *Sequencing* biocView.
* **metabolomics**: core + all packages tagged with the *Metabolomics* biocView.

### 1.1.3 Docker Hub

[Docker Hub](https://hub.docker.com) also provide public/private repos, you can search existing tools without building yourself, it’s very likely some popular tool already have Docker container well maintained there.

### 1.1.4 Seven Bridges Docker Registry

Tutorial coming soon.

Example Seven Bridges registry:

* **SevenBridges** : `images.sbgenomics.com/<repository>[:<tag>]`
* **Cancer Genomics Cloud**: `cgc-images.sbgenomics.com/<repository>[:<tag>]`

# 2 Tutorial: Random Number Generator

Our goal here is to making a CWL app to generate uniform random numbers, yes, the core function is `runif()`, it’s a native function in R.

```
dput(runif)
```

```
## function (n, min = 0, max = 1)
## .Call(C_runif, n, min, max)
```

```
set.seed(1001)
runif(10)
```

```
##  [1] 0.985688783 0.412628483 0.429539246 0.419172236 0.426506559 0.887797565
##  [7] 0.006096034 0.081215761 0.288657362 0.765342145
```

## 2.1 Using `docopt` Package

In R, we also have a nice implementation in a package called `docopt`, developed by *Edwin de Jonge*. Check out its [tutorial](https://github.com/docopt/docopt.R) on GitHub.

So let’s quickly create a command line interface for our R scripts with a dummy example. Let’s turn the uniform distribution function `runif` into a command line tool.

when you check out the help page for `runif`, here is the key information you want to markdown.

```
Usage

runif(n, min = 0, max = 1)

Arguments

n
number of observations. If length(n) > 1, the length is taken to be the number required.

min, max
lower and upper limits of the distribution. Must be finite.
```

I will add one more parameter to set seed, here is the R script file called `runif.R`.

At the beginning of the command line script, I use the docopt standard to write my tool help.

```
"usage: runif.R [--n=<int> --min=<float> --max=<float> --seed=<float>]\n\noptions:\n --n=<int>        number of observations. If length(n) > 1, the length is taken to be the number required [default: 1].\n --min=<float>   lower limits of the distribution. Must be finite [default: 0].\n --max=<float>   upper limits of the distribution. Must be finite [default: 1].\n --seed=<float>  seed for set.seed() function [default: 1]" -> doc

library("docopt")
```

Let’s first do some testing in your R session before you make it a full functional command line tool.

```
docopt(doc) # with no argumetns provided
```

```
## List of 8
##  $ --n   : chr "1"
##  $ --min : chr "0"
##  $ --max : chr "1"
##  $ --seed: chr "1"
##  $ n     : chr "1"
##  $ min   : chr "0"
##  $ max   : chr "1"
##  $ seed  : chr "1"
## NULL
```

```
docopt(doc, "--n 10 --min=3 --max=5")
```

```
## List of 8
##  $ --n   : chr "10"
##  $ --min : chr "3"
##  $ --max : chr "5"
##  $ --seed: chr "1"
##  $ n     : chr "10"
##  $ min   : chr "3"
##  $ max   : chr "5"
##  $ seed  : chr "1"
## NULL
```

Looks like it works, now let’s add main function script for this command line tool.

```
opts <- docopt(doc)
set.seed(opts$seed)
runif(
  n = as.integer(opts$n),
  min = as.numeric(opts$min),
  max = as.numeric(opts$max)
)
```

```
## [1] 0.2655087
```

Add Shebang at the top of the file, this is a complete example for `runif.R` command line will be like this

```
#!/usr/bin/Rscript
"usage: runif.R [--n=<int> --min=<float> --max=<float> --seed=<float>]\n\noptions:\n --n=<int>        number of observations. If length(n) > 1, the length is taken to be the number required [default: 1].\n --min=<float>   lower limits of the distribution. Must be finite [default: 0].\n --max=<float>   upper limits of the distribution. Must be finite [default: 1].\n --seed=<float>  seed for set.seed() function [default: 1]" -> doc

library("docopt")
opts <- docopt(doc)
set.seed(opts$seed)
runif(
  n = as.integer(opts$n),
  min = as.numeric(opts$min),
  max = as.numeric(opts$max)
)
```

Let’s test this command line.

```
$ runif.R --help
Loading required package: methods
usage: runif.R [--n=<int> --min=<float> --max=<float> --seed=<float>]

options:
 --n=<int>        number of observations. If length(n) > 1, the length is taken to be the number required [default: 1].
 --min=<float>   lower limits of the distribution. Must be finite [default: 0].
 --max=<float>   upper limits of the distribution. Must be finite [default: 1].
 --seed=<float>  seed for set.seed() function [default: 1]
$ runif.R
Loading required package: methods
[1] 0.2655087
$ runif.R
Loading required package: methods
[1] 0.2655087
$ runif.R --seed=123 --n 10 --min=1 --max=100
Loading required package: methods
 [1] 29.470174 79.042208 41.488715 88.418723 94.106261  5.510093 53.282443
 [8] 89.349485 55.592066 46.204859
```

For full example you can check my GitHub [example](https://github.com/tengfei/docker/tree/master/runif).

## 2.2 Quick Command Line Interface with `commandArgs` (Position and Named Args)

For advanced users, please read another tutorial “Creating Your Docker Container and Command Line Interface (with docopt)”, “docopt” is more formal way to construct your command line interface, but there is a quick way to make command line interface here using just `commandArgs`.

Suppose I already have a R script like this using position mapping the arguments

1. `numbers`
2. `min`
3. `max`

```
fl <- system.file("docker/sevenbridges/src", "runif2spin.R", package = "sevenbridges")
cat(readLines(fl), sep = "\n")
```

```
#' ---
#' title: "Uniform random number generator example"
#' output:
#'     html_document:
#'     toc: true
#' number_sections: true
#' ---

#' # summary report
#'
#' This is a random number generator

#+
args = commandArgs(TRUE)

r = runif(n   = as.integer(args[1]),
          min = as.numeric(args[2]),
          max = as.numeric(args[3]))
head(r)
summary(r)
hist(r)
```

Ignore the comment part, I will introduce spin/stich later. My base command will be something like

```
Rscript runif2spin.R 10 30 50
```

I just describe my tool in this way

```
library("sevenbridges")

fd <- fileDef(
  name = "runif.R",
  content = readr::read_file(fl)
)

rbx <- Tool(
  id = "runif",
  label = "runif",
  hints = requirements(docker(pull = "rocker/r-base"), cpu(1), mem(2000)),
  requirements = requirements(fd),
  baseCommand = "Rscript runif.R",
  stdout = "output.txt",
  inputs = list(
    input(
      id = "number",
      type = "integer",
      position = 1
    ),
    input(
      id = "min",
      type = "float",
      position = 2
    ),
    input(
      id = "max",
      type = "float",
      position = 3
    )
  ),
  outputs = output(id = "random", glob = "output.txt")
)
```

Now copy-paste the JSON into your project app and run it in the cloud to test it

How about named arguments? I will still recommend use “docopt” package, but for simple way.

```
fl <- system.file("docker/sevenbridges/src", "runif_args.R", package = "sevenbridges")
cat(readLines(fl), sep = "\n")
```

```
#' ---
#' title: "Uniform random number generator example"
#' output:
#'     html_document:
#'     toc: true
#' number_sections: true
#' ---

#' # summary report
#'
#' This is a random number generator

#+
args <- commandArgs(TRUE)

## quick hack to split named arguments
splitArgs <- function(x) {
    res <- do.call(rbind, lapply(x, function(i){
        res <- strsplit(i, "=")[[1]]
        nm <- gsub("-+", "",res[1])
        c(nm, res[2])
    }))
    .r <- res[,2]
    names(.r) <- res[,1]
    .r
}
args <- splitArgs(args)

#+
r <- runif(n   = as.integer(args["n"]),
           min = as.numeric(args["min"]),
           max = as.numeric(args["max"]))
summary(r)
hist(r)
write.csv(r, file = "out.csv")
```

```
Rscript runif_args.R --n=10 --min=30 --max=50
```

I just describe my tool in this way, note, I use `separate=FALSE` and add `=` to my prefix as a hack.

```
fd <- fileDef(
  name = "runif.R",
  content = readr::read_file(fl)
)

rbx <- Tool(
  id = "runif",
  label = "runif",
  hints = requirements(docker(pull = "rocker/r-base"), cpu(1), mem(2000)),
  requirements = requirements(fd),
  baseCommand = "Rscript runif.R",
  stdout = "output.txt",
  inputs = list(
    input(
      id = "number",
      type = "integer",
      separate = FALSE,
      prefix = "--n="
    ),
    input(
      id = "min",
      type = "float",
      separate = FALSE,
      prefix = "--min="
    ),
    input(
      id = "max",
      type = "float",
      separate = FALSE,
      prefix = "--max="
    )
  ),
  outputs = output(id = "random", glob = "output.txt")
)
```

## 2.3 Quick Report: Spin and Stich

Alternative, you can use spin/stich from knitr to generate report directly from an R script with special format. For example, let’s use the above example

```
fl <- system.file("docker/sevenbridges/src", "runif_args.R", package = "sevenbridges")
cat(readLines(fl), sep = "\n")
```

```
#' ---
#' title: "Uniform random number generator example"
#' output:
#'     html_document:
#'     toc: true
#' number_sections: true
#' ---

#' # summary report
#'
#' This is a random number generator

#+
args <- commandArgs(TRUE)

## quick hack to split named arguments
splitArgs <- function(x) {
    res <- do.call(rbind, lapply(x, function(i){
        res <- strsplit(i, "=")[[1]]
        nm <- gsub("-+", "",res[1])
        c(nm, res[2])
    }))
    .r <- res[,2]
    names(.r) <- res[,1]
    .r
}
args <- splitArgs(args)

#+
r <- runif(n   = as.integer(args["n"]),
           min = as.numeric(args["min"]),
           max = as.numeric(args["max"]))
summary(r)
hist(r)
write.csv(r, file = "out.csv")
```

You command is something like this

```
Rscript -e "rmarkdown::render(knitr::spin('runif_args.R', FALSE))" --args --n=100 --min=30 --max=50
```

And so I describe my tool like this with Docker image `rocker/hadleyverse` this contains knitr and rmarkdown package.

```
fd <- fileDef(
  name = "runif.R",
  content = readr::read_file(fl)
)

rbx <- Tool(
  id = "runif",
  label = "runif",
  hints = requirements(docker(pull = "rocker/hadleyverse"), cpu(1), mem(2000)),
  requirements = requirements(fd),
  baseCommand = "Rscript -e \"rmarkdown::render(knitr::spin('runif.R', FALSE))\" --args",
  stdout = "output.txt",
  inputs = list(
    input(
      id = "number",
      type = "integer",
      separate = FALSE,
      prefix = "--n="
    ),
    input(
      id = "min",
      type = "float",
      separate = FALSE,
      prefix = "--min="
    ),
    input(
      id = "max",
      type = "float",
      separate = FALSE,
      prefix = "--max="
    )
  ),
  outputs = list(
    output(id = "stdout", type = "file", glob = "output.txt"),
    output(id = "random", type = "file", glob = "*.csv"),
    output(id = "report", type = "file", glob = "*.html")
  )
)
```

You will get a report in the end.

## 2.4 Executable Report with R Markdown (Advanced)

We cannot really make a R Markdown file executable in it by simply put

```
#!/bin/bash/Rscript
```

In your markdown document.

Of course, we can figure out a way to do it in `liftr` or `knitr`. But R Markdown allow you to pass parameters to your R Markdown template, please read this tutorial [Parameterized Reports](http://rmarkdown.rstudio.com/developer_parameterized_reports.html). This doesn’t solve my problem that I want to directly describe command line interface in the markdown template. However, here is alternative method:

Create an command line interface to pass `params` from docopt into `rmarkdown::render()` function. In this way, we can pass as many as possible parameters from command line interface into our R Markdown template.

So here we go, here is updated methods and it’s also what I use for another tutorial about RNA-seq workflow.

```
fl <- system.file("docker/sevenbridges/src/", "runif.R", package = "sevenbridges")
```

Here is the current content of command line interface

```
#!/usr/local/bin/Rscript
'usage: runif.R [--n=<int> --min=<float> --max=<float> --seed=<float>]

options:
--n=<int>        number of observations. If length(n) > 1, the length is taken to be the number required [default: 1].
--min=<float>   lower limits of the distribution. Must be finite [default: 0].
--max=<float>   upper limits of the distribution. Must be finite [default: 1].
--seed=<float>  seed for set.seed() function [default: 1]'  -> doc

library("docopt")
opts <- docopt(doc)

# create param list
lst <- list(
  n = as.integer(opts$n),
  min = as.numeric(opts$min),
  max = as.numeric(opts$max),
  seed = as.numeric(opts$seed)
)

# execute your Rmarkdown with these parameters
rmarkdown::render("/report/report.Rmd", rmarkdown::html_document(toc = TRUE), output_dir = ".", params = lst)
```

And here is the report template

```
---
title: "Uniform random number generator example"
output:
  rmarkdown::html_document:
    toc: true
    number_sections: true
    css: style.css
params:
  seed: 1
  n: 1
  min: 0
  max: 1
---

## Summary
```{r}
set.seed(params$seed)
r <- runif(
  n = as.integer(params$n),
  min = as.numeric(params$min),
  max = as.numeric(params$max)
)
summary(r)
hist(r)
```
```

# 3 Setup Docker Hub Automated Build

To make things more reproducible and explicit and automatic, you can do a autohook to automatically build your container/image on Docker Hub. Here is what I do

1. I created some project called ‘docker’ on my GitHub and it has all container that crated from a Dockerfile, for example, tengfei/docker/runif, please go [here](https://github.com/tengfei/docker/tree/master/runif) to check it out
2. This folder root has a Dockerfile and subfolders for extra materials I added at build time, like script or report template.
3. Log into your Docker Hub account, following this [tutorial](https://docs.docker.com/docker-hub/builds/) to make “automated build” from your GitHub account. Make sure you input the right location for your Dockerfile, by customizing it.
4. Then you will have auto-build every time you push a new update in GitHub.
5. Start using your Docker image like `tengfei/runif`.
6. Feel free to push it onto your Seven Bridges platform registry as well.

# 4 More Examples

There are more examples under `inst/docker` folder, you can check out how to describe command line and build Docker, how to make report template. You may read the online GitHub [code](https://github.com/sbg/sevenbridges-r/tree/master/inst/docker). Or you could read another [tutorial](https://sbg.github.io/sevenbridges-r/articles/bioc-workflow.html) about how we wrap RNA-seq workflow from Bioconductor.