# Code example from 'BiocDockstore' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
has_gcloud <- AnVILBase::has_avworkspace(
    platform = AnVILGCP::gcp()
)
knitr::opts_chunk$set(
    eval = has_gcloud, collapse = TRUE, cache = TRUE
)

## ----lka, message = FALSE-----------------------------------------------------
# library(AnVIL)
# library(dplyr)

## ----dockstore----------------------------------------------------------------
# dockstore <- Dockstore()

## ----getmeths-----------------------------------------------------------------
# knitr::kable(tags(dockstore) %>% count(tag))

## ----lku----------------------------------------------------------------------
# tags(dockstore, "users") %>% print(n = Inf)

## ----lklk, eval = FALSE-------------------------------------------------------
# myuid <- dockstore$getUser() %>%
#     as.list() %>%
#     pull("id")

## ----sessionInfo, echo=FALSE--------------------------------------------------
# sessionInfo()

