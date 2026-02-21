# Code example from 'somatic_mutations' vignette. See references/ for full tutorial.

## ----warning=FALSE,message=FALSE----------------------------------------------
library(GenomicDataCommons)
library(tibble)

## -----------------------------------------------------------------------------
grep_fields('genes', 'symbol')

## -----------------------------------------------------------------------------
head(available_values('genes','symbol'))

## -----------------------------------------------------------------------------
tp53 = genes() |> 
  GenomicDataCommons::filter(symbol=='TP53') |> 
  results(size=10000) |> 
  as_tibble()

## -----------------------------------------------------------------------------
ssms() |> 
    GenomicDataCommons::filter(
      chromosome==paste0('chr',tp53$gene_chromosome[1]) &
        start_position > tp53$gene_start[1] & 
        end_position < tp53$gene_end[1]) |> 
    GenomicDataCommons::count()

## -----------------------------------------------------------------------------
ssms() |> 
    GenomicDataCommons::filter(
      consequence.transcript.gene.symbol %in% c('TP53')) |> 
    GenomicDataCommons::count()

## ----warning=FALSE,message=FALSE----------------------------------------------
library(VariantAnnotation)
vars = ssms() |> 
    GenomicDataCommons::filter(
      consequence.transcript.gene.symbol %in% c('TP53')) |> 
    GenomicDataCommons::results_all() |>
    as_tibble()

## -----------------------------------------------------------------------------
vr = VRanges(seqnames = vars$chromosome,
             ranges = IRanges(start=vars$start_position, width=1),
             ref = vars$reference_allele,
             alt = vars$tumor_allele)

## -----------------------------------------------------------------------------
ssm_occurrences() |> 
    GenomicDataCommons::filter(
      ssm.consequence.transcript.gene.symbol %in% c('TP53')) |>
    GenomicDataCommons::count()

## -----------------------------------------------------------------------------
var_samples = ssm_occurrences() |> 
    GenomicDataCommons::filter(
      ssm.consequence.transcript.gene.symbol %in% c('TP53')) |> 
    GenomicDataCommons::expand(c('case', 'ssm', 'case.project')) |>
    GenomicDataCommons::results_all() |> 
    as_tibble()

## -----------------------------------------------------------------------------
table(var_samples$case$disease_type)

## -----------------------------------------------------------------------------
fnames <- files() |>
  GenomicDataCommons::filter(
    cases.project.project_id=='TCGA-SKCM' &
      data_format=='maf' &
      data_type=='Masked Somatic Mutation' &
      analysis.workflow_type ==
        'Aliquot Ensemble Somatic Variant Merging and Masking'
  ) |>
  results(size = 1) |>
    ids() |>
      gdcdata()

## ----cache=TRUE---------------------------------------------------------------
library(maftools)
melanoma = read.maf(maf = fnames)

## -----------------------------------------------------------------------------
maftools::oncoplot(melanoma)

