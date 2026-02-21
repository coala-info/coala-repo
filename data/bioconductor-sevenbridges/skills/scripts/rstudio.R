# Code example from 'rstudio' vignette. See references/ for full tutorial.

## ----comment = ''-------------------------------------------------------------
fl <- system.file("docker/sevenbridges/", "Dockerfile", package = "sevenbridges")
cat(readLines(fl), sep = "\n")

