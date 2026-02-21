# Code example from 'AnVILAzWorkspaces' vignette. See references/ for full tutorial.

## ----setup, include = FALSE----------------------------------------------
az_ok <- AnVILAz::has_avworkspace(strict = TRUE, platform = AnVILAz::azure())
knitr::opts_chunk$set(
    collapse = TRUE,
## Related to https://stat.ethz.ch/pipermail/bioc-devel/2020-April/016656.html
    crop = NULL,
    eval = az_ok
)
options(width = 75)

## ----library, message = FALSE, eval = TRUE, cache = FALSE----------------
library(AnVILAz)

## ----avworkspaces, eval=az_ok--------------------------------------------
# avworkspaces()

## ----avworkspace, eval=az_ok---------------------------------------------
# avworkspace()

## ----avworkspace_set, eval=az_ok-----------------------------------------
# avworkspace("my-namespace/my-workspace")
# avworkspace()

## ----avworkspace_namespace, eval=az_ok-----------------------------------
# avworkspace_namespace()

## ----avworkspace_name, eval=az_ok----------------------------------------
# avworkspace_name()

## ----avworkspace_clone, eval=FALSE---------------------------------------
# avworkspace_clone(
#     namespace = "my-namespace",
#     name = "my-workspace",
#     to_namespace = "my-new-namespace",
#     to_name = "my-workspace-clone"
# )
# avworkspaces()

## ----avnotebooks, eval=az_ok---------------------------------------------
# avnotebooks()

## ----avnotebooks_localize, eval=FALSE------------------------------------
# avnotebooks_localize(destination = "./analyses")

## ----avnotebooks_delocalize, eval=FALSE----------------------------------
# avnotebooks_delocalize(source = "./")

## ----avworkflows_jobs, eval=az_ok----------------------------------------
# avworkflows_jobs()

## ----avworkflows_jobs_inputs, eval=az_ok---------------------------------
# avworkflows_jobs_inputs()

## ----sessionInfo, eval=TRUE----------------------------------------------
sessionInfo()

