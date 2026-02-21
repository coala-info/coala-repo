# Code example from 'updateObject' vignette. See references/ for full tutorial.

## ----message=FALSE------------------------------------------------------------
library(updateObject)

## ----echo=FALSE, results="hide"-----------------------------------------------
## Set fake git user to make git_commit() happy:
set_git_user_name("titi")
set_git_user_email("titi@gmail.com")

## -----------------------------------------------------------------------------
repopath <- file.path(tempdir(), "BiSeq")
updateBiocPackageRepoObjects(repopath, branch="RELEASE_3_14", use.https=TRUE)

## -----------------------------------------------------------------------------
sessionInfo()

