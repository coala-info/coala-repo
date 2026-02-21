# Code example from 'overview' vignette. See references/ for full tutorial.

## ----init, results='hide', echo=FALSE, warning=FALSE, message=FALSE-----------
library(knitr)
opts_chunk$set(warning=FALSE, message=FALSE)
BiocStyle::markdown()

## ----install_bioc, eval=FALSE-------------------------------------------------
# if (!require("BiocManager"))
#     install.packages("BiocManager")
# BiocManager::install('GenomicDataCommons')

## ----libraries, message=FALSE-------------------------------------------------
library(GenomicDataCommons)

## ----statusQS-----------------------------------------------------------------
GenomicDataCommons::status()

## ----statusCheck--------------------------------------------------------------
stopifnot(GenomicDataCommons::status()$status=="OK")

## ----manifest-----------------------------------------------------------------
ge_manifest <- files() |>
    filter( cases.project.project_id == 'TCGA-OV') |> 
    filter( type == 'gene_expression' ) |>
    filter( analysis.workflow_type == 'STAR - Counts')  |>
    manifest()
head(ge_manifest)

## ----downloadQS, eval=FALSE---------------------------------------------------
# fnames <- lapply(ge_manifest$id[1:20], gdcdata)

## ----gdc_clinical-------------------------------------------------------------
case_ids = cases() |> results(size=10) |> ids()
clindat = gdc_clinical(case_ids)
names(clindat)

## ----clinData-----------------------------------------------------------------
head(clindat[["main"]])
head(clindat[["diagnoses"]])

## ----metadataQS---------------------------------------------------------------
expands = c("diagnoses","annotations",
             "demographic","exposures")
clinResults = cases() |>
    GenomicDataCommons::select(NULL) |>
    GenomicDataCommons::expand(expands) |>
    results(size=50)
str(clinResults[[1]],list.len=6)
# or listviewer::jsonedit(clinResults)

## ----projectquery-------------------------------------------------------------
pquery = projects()

## ----pquery-------------------------------------------------------------------
str(pquery)

## ----pquerycount--------------------------------------------------------------
pcount = count(pquery)
# or
pcount = pquery |> count()
pcount

## ----pqueryresults------------------------------------------------------------
presults = pquery |> results()

## ----presultsstr--------------------------------------------------------------
str(presults)

## ----presultsall--------------------------------------------------------------
length(ids(presults))
presults = pquery |> results_all()
length(ids(presults))
# includes all records
length(ids(presults)) == count(pquery)

## ----defaultfields------------------------------------------------------------
default_fields('files')
# The number of fields available for files endpoint
length(available_fields('files'))
# The first few fields available for files endpoint
head(available_fields('files'))

## ----selectexample------------------------------------------------------------
# Default fields here
qcases = cases()
qcases$fields
# set up query to use ALL available fields
# Note that checking of fields is done by select()
qcases = cases() |> GenomicDataCommons::select(available_fields('cases'))
head(qcases$fields)

## ----aggexample---------------------------------------------------------------
# total number of files of a specific type
res = files() |> facet(c('type','data_type')) |> aggregations()
res$type

## ----allfilesunfiltered-------------------------------------------------------
qfiles = files()
qfiles |> count() # all files

## ----onlyGeneExpression-------------------------------------------------------
qfiles = files() |> filter( type == 'gene_expression')
# here is what the filter looks like after translation
str(get_filter(qfiles))

## ----filtAvailFields----------------------------------------------------------
grep('pro',available_fields('files'),value=TRUE) |> 
    head()

## ----filtProgramID------------------------------------------------------------
files() |> 
    facet('cases.project.project_id') |> 
    aggregations() |> 
    head()

## ----filtfinal----------------------------------------------------------------
qfiles = files() |>
    filter( cases.project.project_id == 'TCGA-OV' & type == 'gene_expression')
str(get_filter(qfiles))
qfiles |> count()

## ----filtChain----------------------------------------------------------------
qfiles2 = files() |>
    filter( cases.project.project_id == 'TCGA-OV') |> 
    filter( type == 'gene_expression') 
qfiles2 |> count()
(qfiles |> count()) == (qfiles2 |> count()) #TRUE

## ----filtAndManifest----------------------------------------------------------
manifest_df = qfiles |> manifest()
head(manifest_df)

## ----filterForSTARCounts------------------------------------------------------
qfiles = files() |> filter( ~ cases.project.project_id == 'TCGA-OV' &
                            type == 'gene_expression' &
                            access == "open" &
                            analysis.workflow_type == 'STAR - Counts')
manifest_df = qfiles |> manifest()
nrow(manifest_df)

## ----authenNoRun, eval=FALSE--------------------------------------------------
# token = gdc_token()
# transfer(...,token=token)
# # or
# transfer(...,token=get_token())

## ----singlefileDL-------------------------------------------------------------
fnames = gdcdata(manifest_df$id[1:2],progress=FALSE)


## ----bulkDL, eval=FALSE-------------------------------------------------------
# # Requires gcd_client command-line utility to be isntalled
# # separately.
# fnames = gdcdata(manifest_df$id[3:10], access_method = 'client')

## ----casesPerProject----------------------------------------------------------
res = cases() |> facet("project.project_id") |> aggregations()
head(res)
library(ggplot2)
ggplot(res$project.project_id,aes(x = key, y = doc_count)) +
    geom_bar(stat='identity') +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))

## ----casesInTCGA--------------------------------------------------------------
cases() |> filter(~ project.program.name=='TARGET') |> count()

## ----casesInTARGET------------------------------------------------------------
cases() |> filter(~ project.program.name=='TCGA') |> count()

## ----casesTCGABRCASampleTypes-------------------------------------------------
# The need to do the "&" here is a requirement of the
# current version of the GDC API. I have filed a feature
# request to remove this requirement.
resp = cases() |> filter(~ project.project_id=='TCGA-BRCA' &
                              project.project_id=='TCGA-BRCA' ) |>
    facet('samples.sample_type') |> aggregations()
resp$samples.sample_type

## ----casesTCGABRCASolidNormal-------------------------------------------------
# The need to do the "&" here is a requirement of the
# current version of the GDC API. I have filed a feature
# request to remove this requirement.
resp = cases() |> filter(~ project.project_id=='TCGA-BRCA' &
                              samples.sample_type=='Solid Tissue Normal') |>
    GenomicDataCommons::select(c(default_fields(cases()),'samples.sample_type')) |>
    response_all()
count(resp)
res = resp |> results()
str(res[1],list.len=6)
head(ids(resp))

## ----casesFemaleTCGA----------------------------------------------------------
cases() |>
  GenomicDataCommons::filter(~ project.program.name == 'TCGA' &
    "cases.demographic.gender" %in% "female") |>
      GenomicDataCommons::results(size = 4) |>
        ids()

## ----notFemaleTCGACOAD--------------------------------------------------------
cases() |>
  GenomicDataCommons::filter(~ project.project_id == 'TCGA-COAD' &
    "cases.demographic.gender" %exclude% "female") |>
      GenomicDataCommons::results(size = 4) |>
        ids()

## ----missingGenderTCGA--------------------------------------------------------
cases() |>
  GenomicDataCommons::filter(~ project.program.name == 'TCGA' &
    missing("cases.demographic.gender")) |>
      GenomicDataCommons::results(size = 4) |>
        ids()

## ----notMissingGenderTCGA-----------------------------------------------------
cases() |>
  GenomicDataCommons::filter(~ project.program.name == 'TCGA' &
    !missing("cases.demographic.gender")) |>
      GenomicDataCommons::results(size = 4) |>
        ids()

## ----filesVCFCount------------------------------------------------------------
res = files() |> facet('type') |> aggregations()
res$type
ggplot(res$type,aes(x = key,y = doc_count)) + geom_bar(stat='identity') +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))

## ----filesRNAseqGeneGBM-------------------------------------------------------
q = files() |>
    GenomicDataCommons::select(available_fields('files')) |>
    filter(~ cases.project.project_id=='TCGA-GBM' &
               data_type=='Gene Expression Quantification')
q |> facet('analysis.workflow_type') |> aggregations()
# so need to add another filter
file_ids = q |> filter(~ cases.project.project_id=='TCGA-GBM' &
                            data_type=='Gene Expression Quantification' &
                            analysis.workflow_type == 'STAR - Counts') |>
    GenomicDataCommons::select('file_id') |>
    response_all() |>
    ids()

## ----filesRNAseqGeneGBMforBAM-------------------------------------------------
q = files() |>
    GenomicDataCommons::select(available_fields('files')) |>
    filter(~ cases.project.project_id == 'TCGA-GBM' &
               data_type == 'Aligned Reads' &
               experimental_strategy == 'RNA-Seq' &
               data_format == 'BAM')
file_ids = q |> response_all() |> ids()

## ----slicing10, eval=FALSE----------------------------------------------------
# bamfile = slicing(file_ids[1],regions="chr12:6534405-6538375",token=gdc_token())
# library(GenomicAlignments)
# aligns = readGAlignments(bamfile)

## ----sessionInfo--------------------------------------------------------------
sessionInfo()

