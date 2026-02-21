# Code example from 'OpenGWAS' vignette. See references/ for full tutorial.

## ----style, echo=FALSE--------------------------------------------------------
knitr::opts_chunk$set(tidy = FALSE,
                      message = FALSE)

## -----------------------------------------------------------------------------
library(MungeSumstats)

## ----eval=FALSE---------------------------------------------------------------
# #### Search for datasets ####
# metagwas <- MungeSumstats::find_sumstats(traits = c("parkinson","alzheimer"),
#                                          min_sample_size = 1000)
# head(metagwas,3)
# ids <- (dplyr::arrange(metagwas, nsnp))$id

## ----echo=FALSE---------------------------------------------------------------
#### Search for datasets ####
#error_dwnld <-
#            tryCatch(
#              metagwas <- MungeSumstats::find_sumstats(traits = c("parkinson",
#                                                                  "alzheimer"), 
#                                         min_sample_size = 1000),
#            error = function(e) e,
#            warning = function(w) w
#            )
#if(exists("metagwas")&&is.data.frame(metagwas)){#if exists downloaded fine
#  head(metagwas,3)
#  ids <- (dplyr::arrange(metagwas, nsnp))$id  
#}

#to speed up build just create results
metagwas2 <- 
    data.frame(
        id=c("ieu-a-298","ieu-b-2","ieu-a-297"),
        trait = rep("Alzheimer's disease",3),
        group_name = rep("public",3),
        year=c(2013, 2019, 2013),
        author=c("Lambert","Kunkle BW","Lambert"),
        consortium=c("IGAP",
                     "Alzheimer Disease Genetics Consortium (ADGC), European Alzheimer's Disease Initiative (EADI), Cohorts for Heart and Aging Research in Genomic Epidemiology Consortium (CHARGE), Genetic and Environmental Risk in AD/Defining Genetic, Polygenic and Environmental Risk for Alzheimer's Disease Consortium (GERAD/PERADES),",
                     "IGAP" ),
        sex=rep("Males and Females",3),
        population=rep("European",3),
        unit=c("log odds","NA","log odds"),
        nsnp=c(11633,10528610,7055882),
        sample_size=c(74046,63926,54162),
        build=rep("HG19/GRCh37",3),
        category=c("Disease","Binary","Disease"),
        subcategory=rep("Psychiatric / neurological",3),
        ontology=rep("NA",3),
        mr=rep(1,3),
        priority=c(1,0,2),
        pmid=c(24162737,30820047,24162737),
        sd=rep(NA,3),
        note=c("Exposure only; Effect allele frequencies are missing; forward(+) strand",
               "NA","Effect allele frequencies are missing; forward(+) strand"),
        ncase=c(25580,21982,17008),
        ncontrol=c(48466,41944,37154),
        N=c(74046,63926,54162)
    )
print(head(metagwas2,3))

## ----eval=FALSE---------------------------------------------------------------
# ### By ID and sample size
# metagwas <- find_sumstats(
#   ids = c("ieu-b-4760", "prot-a-1725", "prot-a-664"),
#   min_sample_size = 5000
# )

## ----eval=FALSE---------------------------------------------------------------
# datasets <- MungeSumstats::import_sumstats(ids = "ieu-a-298",
#                                            ref_genome = "GRCH37")

## ----echo=FALSE---------------------------------------------------------------
#don't actually run as this takes some time, use stashed version
datasets <- list("ieu-a-298"=paste0(tempdir(),"/ieu-a-298.tsv.gz"))
#stashed value
datasets_data <- list("ieu-a-298"=system.file("extdata","ieu-a-298.tsv.gz",
                                                package="MungeSumstats"))


## -----------------------------------------------------------------------------
print(datasets)

## -----------------------------------------------------------------------------
results_df <- data.frame(id=names(datasets), 
                         path=unlist(datasets))
print(results_df)

## ----eval=FALSE---------------------------------------------------------------
# datasets <- MungeSumstats::import_sumstats(ids = ids,
#                                            vcf_download = TRUE,
#                                            download_method = "axel",
#                                            nThread = max(2,future::availableCores()-2))

## -----------------------------------------------------------------------------
utils::sessionInfo()

