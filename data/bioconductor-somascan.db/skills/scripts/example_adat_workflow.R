# Code example from 'example_adat_workflow' vignette. See references/ for full tutorial.

## ----setup, include=FALSE-----------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, crop = NULL)
library(BiocStyle)
library(dplyr)
library(GO.db)
library(SomaDataIO)
library(SomaScan.db)

## ----load-pkgs----------------------------------------------------------------
library(dplyr)
library(GO.db)
library(SomaDataIO)
library(SomaScan.db)

## ----read-adat----------------------------------------------------------------
# Retrieve the example ADAT file from the SomaDataIO package
file <- system.file("extdata", "example_data10.adat",
                    package = "SomaDataIO", mustWork = TRUE
)
# Read in the file
adat <- SomaDataIO::read_adat(file)

adat

## ----age-summary--------------------------------------------------------------
summary(adat$Age)

## ----age-hist, fig.height=3.5, fig.width=5------------------------------------
hist(adat$Age,
     xlab = "Age (years)",
     main = "Age Distribution"
)

## ----rm-na--------------------------------------------------------------------
dplyr::filter(adat, is.na(Sex)) %>%
    dplyr::select(SlideId, Age)

## -----------------------------------------------------------------------------
adat <- dplyr::filter(adat, !is.na(Age))

## ----n-analytes---------------------------------------------------------------
analytes <- SomaDataIO::getAnalytes(adat)

head(analytes)

## -----------------------------------------------------------------------------
length(analytes)

## ----log-trans----------------------------------------------------------------
log10_adat <- log10(adat)

## ----cor-test-----------------------------------------------------------------
# Calculate correlations for each analyte
cors_df <- lapply(analytes, function(x) {
    results <- stats::cor.test(log10_adat$Age, log10_adat[[x]],
                               method = "spearman", exact = FALSE)
    results <- results[c("estimate", "p.value")]
    unlist(results)
}) %>% setNames(analytes)

# Bind results together into a single dataframe
cors_df <- dplyr::bind_rows(cors_df, .id = "analytes")

# Isolate top positive correlations
top_posCor <- cors_df %>%
    dplyr::filter(p.value < 0.05) %>% # Retain significant cors only
    dplyr::filter(estimate.rho >= 0.75) %>% # Retain strong correlations
    arrange(desc(estimate.rho))

nrow(top_posCor)
head(top_posCor, 20L)

## ----columns------------------------------------------------------------------
columns(SomaScan.db)

## ----GO-columns---------------------------------------------------------------
grep("GO|ONTOLOGY", columns(SomaScan.db), value = TRUE)

## ----top-10-------------------------------------------------------------------
top10_analytes <- head(top_posCor$analytes, 10L)

anno <- SomaScan.db::select(SomaScan.db, 
                            keys = top10_analytes,
                            columns = c("SYMBOL", "GENENAME", "GENETYPE"))

anno

## -----------------------------------------------------------------------------
go_anno <- SomaScan.db::select(SomaScan.db, 
                               keys = anno$PROBEID[1:3L],
                               columns = c("SYMBOL", "GENENAME", "GENETYPE", 
                                           "GO", "ONTOLOGY")) %>%
    dplyr::filter(ONTOLOGY == "BP")

go_anno

## -----------------------------------------------------------------------------
go_terms <- AnnotationDbi::select(GO.db, 
                                  keys = go_anno$GO, 
                                  columns = c("GOID", "TERM", "DEFINITION"))

go_terms

## ----join-go------------------------------------------------------------------
final_df <- left_join(go_anno, go_terms, by = c("GO" = "GOID"))

final_df

## ----session-info-------------------------------------------------------------
sessionInfo()

