# Code example from 'questions-and-answers' vignette. See references/ for full tutorial.

## -----------------------------------------------------------------------------
library(GenomicDataCommons,quietly = TRUE)

## -----------------------------------------------------------------------------
q = files() |>
  GenomicDataCommons::filter(
    cases.project.project_id == 'TCGA-COAD' &
      data_type == 'Aligned Reads' &
      experimental_strategy == 'RNA-Seq' &
      data_format == 'BAM')

## -----------------------------------------------------------------------------
count(q)

## -----------------------------------------------------------------------------
manifest(q)

## -----------------------------------------------------------------------------
all_fields = available_fields(files())

## -----------------------------------------------------------------------------
grep('race|ethnic',all_fields,value=TRUE)

## -----------------------------------------------------------------------------
available_values('files',"cases.demographic.ethnicity")
available_values('files',"cases.demographic.race")

## -----------------------------------------------------------------------------
q_white_only = q |>
  GenomicDataCommons::filter(cases.demographic.race=='white')
count(q_white_only)
manifest(q_white_only)

## -----------------------------------------------------------------------------
library(tibble)
library(dplyr)
library(GenomicDataCommons)

cases() |> 
  GenomicDataCommons::filter(
    ~ project.program.name=='TCGA' & files.experimental_strategy=='RNA-Seq'
  ) |> 
  facet(c("files.created_datetime")) |> 
  aggregations() |> 
  unname() |>
  unlist(recursive = FALSE) |> 
  as_tibble() |>
  dplyr::arrange(dplyr::desc(key))

