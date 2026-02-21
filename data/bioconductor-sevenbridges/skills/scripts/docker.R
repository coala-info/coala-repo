# Code example from 'docker' vignette. See references/ for full tutorial.

## ----include=FALSE------------------------------------------------------------
knitr::opts_chunk$set(eval = TRUE)

## -----------------------------------------------------------------------------
dput(runif)
set.seed(1001)
runif(10)

## -----------------------------------------------------------------------------
"usage: runif.R [--n=<int> --min=<float> --max=<float> --seed=<float>]\n\noptions:\n --n=<int>        number of observations. If length(n) > 1, the length is taken to be the number required [default: 1].\n --min=<float>   lower limits of the distribution. Must be finite [default: 0].\n --max=<float>   upper limits of the distribution. Must be finite [default: 1].\n --seed=<float>  seed for set.seed() function [default: 1]" -> doc

library("docopt")

## -----------------------------------------------------------------------------
docopt(doc) # with no argumetns provided
docopt(doc, "--n 10 --min=3 --max=5")

## -----------------------------------------------------------------------------
opts <- docopt(doc)
set.seed(opts$seed)
runif(
  n = as.integer(opts$n),
  min = as.numeric(opts$min),
  max = as.numeric(opts$max)
)

## ----eval=FALSE---------------------------------------------------------------
# #!/usr/bin/Rscript
# "usage: runif.R [--n=<int> --min=<float> --max=<float> --seed=<float>]\n\noptions:\n --n=<int>        number of observations. If length(n) > 1, the length is taken to be the number required [default: 1].\n --min=<float>   lower limits of the distribution. Must be finite [default: 0].\n --max=<float>   upper limits of the distribution. Must be finite [default: 1].\n --seed=<float>  seed for set.seed() function [default: 1]" -> doc
# 
# library("docopt")
# opts <- docopt(doc)
# set.seed(opts$seed)
# runif(
#   n = as.integer(opts$n),
#   min = as.numeric(opts$min),
#   max = as.numeric(opts$max)
# )

## ----eval = TRUE, comment=''--------------------------------------------------
fl <- system.file("docker/sevenbridges/src", "runif2spin.R", package = "sevenbridges")
cat(readLines(fl), sep = "\n")

## -----------------------------------------------------------------------------
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

## ----eval = TRUE, comment=''--------------------------------------------------
fl <- system.file("docker/sevenbridges/src", "runif_args.R", package = "sevenbridges")
cat(readLines(fl), sep = "\n")

## -----------------------------------------------------------------------------
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

## ----eval = TRUE, comment = ""------------------------------------------------
fl <- system.file("docker/sevenbridges/src", "runif_args.R", package = "sevenbridges")
cat(readLines(fl), sep = "\n")

## -----------------------------------------------------------------------------
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

## ----eval = TRUE--------------------------------------------------------------
fl <- system.file("docker/sevenbridges/src/", "runif.R", package = "sevenbridges")

## ----comment='', eval = TRUE, echo = FALSE------------------------------------
cat(readLines(fl), sep = "\n")

## ----comment='', eval = TRUE, echo = FALSE------------------------------------
fl <- system.file("docker/sevenbridges/report/", "report.Rmd", package = "sevenbridges")
cat(readLines(fl), sep = "\n")

