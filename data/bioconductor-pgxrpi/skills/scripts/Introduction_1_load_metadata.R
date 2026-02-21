# Code example from 'Introduction_1_load_metadata' vignette. See references/ for full tutorial.

## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(pgxRpi)

## -----------------------------------------------------------------------------
all_filters <- pgxLoader(type="filtering_terms")
head(all_filters)

## -----------------------------------------------------------------------------
query_filter <- pgxLoader(type="filtering_terms",filter_pattern="retinoblastoma")
query_filter

## -----------------------------------------------------------------------------
biosamples <- pgxLoader(type="biosamples", filters = "NCIT:C7541")
# data looks like this
biosamples[1:5,]

## -----------------------------------------------------------------------------
biosamples_2 <- pgxLoader(type="biosamples", biosample_id = "pgxbs-kftvki7h",individual_id = "pgxind-kftx6ltu")

biosamples_2

## -----------------------------------------------------------------------------
biosamples_3 <- pgxLoader(type="biosamples", filters = "NCIT:C7541",skip=0, limit = 10)
# Dimension: Number of samples * features
print(dim(biosamples))
print(dim(biosamples_3))

## -----------------------------------------------------------------------------
unique(biosamples$histological_diagnosis_id)

## -----------------------------------------------------------------------------
biosamples_4 <- pgxLoader(type="biosamples", filters = "NCIT:C7541",codematches = TRUE)
unique(biosamples_4$histological_diagnosis_id)

## -----------------------------------------------------------------------------
individuals <- pgxLoader(type="individuals",individual_id = "pgxind-kftx26ml",filters="NCIT:C7541")
# data looks like this
tail(individuals,2)

## -----------------------------------------------------------------------------
analyses <- pgxLoader(type="analyses",biosample_id = c("pgxbs-kftvik5i","pgxbs-kftvik96"))

analyses

## -----------------------------------------------------------------------------
pgxLoader(type="counts",filters = "NCIT:C7541")

## -----------------------------------------------------------------------------
record_counts <- pgxLoader(type="counts",filters = "NCIT:C9245",domain=c("progenetix.org","cancercelllines.org"), entry_point=c("beacon","beacon"))

record_counts

## -----------------------------------------------------------------------------
# query metadata of individuals with lung adenocarcinoma
luad_inds <- pgxLoader(type="individuals",filters="NCIT:C3512")
# use 70 years old as the splitting condition
pgxMetaplot(data=luad_inds, group_id="age_iso", condition="P70Y", pval=TRUE)

## ----echo = FALSE-------------------------------------------------------------
sessionInfo()

