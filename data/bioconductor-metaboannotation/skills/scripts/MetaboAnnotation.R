# Code example from 'MetaboAnnotation' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
library(BiocStyle)
BiocStyle::markdown()

## ----message = FALSE, warning = FALSE, echo = FALSE---------------------------
library(AnnotationHub)
library(MetaboAnnotation)
library(Spectra)

## ----message = FALSE----------------------------------------------------------
library(MetaboAnnotation)

## ----message = FALSE----------------------------------------------------------
ms1_features <- read.table(system.file("extdata", "MS1_example.txt",
                                       package = "MetaboAnnotation"),
                           header = TRUE, sep = "\t")
head(ms1_features)
target_df <- read.table(system.file("extdata", "LipidMaps_CompDB.txt",
                                    package = "MetaboAnnotation"),
                        header = TRUE, sep = "\t")
head(target_df)

## -----------------------------------------------------------------------------
parm <- Mass2MzParam(adducts = c("[M+H]+", "[M+Na]+"),
                           tolerance = 0.005, ppm = 0)

matched_features <- matchValues(ms1_features[1:100, ], target_df, parm)
matched_features

## -----------------------------------------------------------------------------
head(query(matched_features))
head(target(matched_features))

## -----------------------------------------------------------------------------
whichQuery(matched_features)
whichTarget(matched_features)

## -----------------------------------------------------------------------------
colnames(matched_features)

## -----------------------------------------------------------------------------
matchedData(matched_features)

## -----------------------------------------------------------------------------
matched_features$target_name

## -----------------------------------------------------------------------------
ms1_subset <- ms1_features[1:100, ]
head(ms1_subset)

## -----------------------------------------------------------------------------
set.seed(123)
target_df$rtime <- sample(ms1_subset$rtime,
                          nrow(target_df), replace = TRUE) + 2

## -----------------------------------------------------------------------------
parm <- Mass2MzRtParam(adducts = c("[M+H]+", "[M+Na]+"),
                       tolerance = 0.005, ppm = 0,
                       toleranceRt = 10)
matched_features <- matchValues(ms1_subset, target_df, param = parm,
                                rtColname = "rtime")
matched_features

## -----------------------------------------------------------------------------
matchedData(matched_features)[whichQuery(matched_features), ]

## -----------------------------------------------------------------------------
library(SummarizedExperiment)

se <- SummarizedExperiment(
    assays = matrix(rnorm(nrow(ms1_features) * 4), ncol = 4,
                    dimnames = list(NULL, c("A", "B", "C", "D"))),
    rowData = ms1_features)

## -----------------------------------------------------------------------------
parm <- Mass2MzParam(adducts = c("[M+H]+", "[M+Na]+"),
                     tolerance = 0.005, ppm = 0)
matched_features <- matchValues(se, target_df, param = parm)
matched_features

## -----------------------------------------------------------------------------
colnames(matched_features)
matchedData(matched_features)

## -----------------------------------------------------------------------------
matched_sub <- matched_features[whichQuery(matched_features)]
MetaboAnnotation::query(matched_sub)

## ----warning = FALSE----------------------------------------------------------
library(QFeatures)
qf <- QFeatures(list(features = se))
qf

## -----------------------------------------------------------------------------
matched_qf <- matchValues(qf, target_df, param = parm, queryAssay = "features")
matched_qf

## -----------------------------------------------------------------------------
colnames(matched_qf)
matchedData(matched_qf)

## ----message = FALSE----------------------------------------------------------
library(Spectra)
library(msdata)
fl <- system.file("TripleTOF-SWATH", "PestMix1_DDA.mzML", package = "msdata")
pest_ms2 <- filterMsLevel(Spectra(fl), 2L)
## subset to selected spectra.
pest_ms2 <- pest_ms2[c(808, 809, 945:955)]
## assign arbitrary *feature IDs* to each spectrum.
pest_ms2$feature_id <- c("FT001", "FT001", "FT002", "FT003", "FT003", "FT003",
                         "FT004", "FT004", "FT004", "FT005", "FT005", "FT006",
                         "FT006")
## assign also *spectra IDs* to each
pest_ms2$spectrum_id <- paste0("sp_", seq_along(pest_ms2))
pest_ms2

## -----------------------------------------------------------------------------
load(system.file("extdata", "minimb.RData", package = "MetaboAnnotation"))
minimb

## -----------------------------------------------------------------------------
csp <- CompareSpectraParam(requirePrecursor = TRUE, ppm = 10,
                           matchedPeaksCount = TRUE)
mtches <- matchSpectra(pest_ms2, minimb, param = csp)
mtches

## -----------------------------------------------------------------------------
length(pest_ms2)
length(mtches)

## -----------------------------------------------------------------------------
mtches[1]

## -----------------------------------------------------------------------------
mtches[2]

## -----------------------------------------------------------------------------
spectraVariables(mtches)

## -----------------------------------------------------------------------------
mtches[2]$target_compound_name

## -----------------------------------------------------------------------------
mtches$spectrum_id

## -----------------------------------------------------------------------------
mtches$.original_query_index

## -----------------------------------------------------------------------------
query(mtches)$.original_query_index

## -----------------------------------------------------------------------------
mtches_df <- spectraData(mtches, columns = c("spectrum_id", "feature_id",
                                             "score", "target_spectrum_id",
                                             "target_compound_name"))
as.data.frame(mtches_df)

## -----------------------------------------------------------------------------
plotSpectraMirror(mtches[2])

## -----------------------------------------------------------------------------
scale_int <- function(x, ...) {
    x[, "intensity"] <- x[, "intensity"] / max(x[, "intensity"], na.rm = TRUE)
    x
}
mtches <- addProcessing(mtches, scale_int)
plotSpectraMirror(mtches[2])

## -----------------------------------------------------------------------------
mtches[2]$target_compound_name

## -----------------------------------------------------------------------------
mp <- MatchForwardReverseParam(requirePrecursor = TRUE, ppm = 10)
mtches <- matchSpectra(pest_ms2, minimb, param = mp)
mtches

## -----------------------------------------------------------------------------
as.data.frame(
    spectraData(mtches, c("spectrum_id", "target_spectrum_id",
                          "target_compound_name", "score", "reverse_score",
                          "presence_ratio")))

## -----------------------------------------------------------------------------
select_top_match <- function(x) {
    which.max(x)
}
csp2 <- CompareSpectraParam(ppm = 10, requirePrecursor = FALSE,
                            THRESHFUN = select_top_match)
mtches <- matchSpectra(pest_ms2, minimb, param = csp2)
res <- spectraData(mtches, columns = c("spectrum_id", "target_spectrum_id",
                                       "target_compound_name", "score"))
as.data.frame(res)

## ----warning = FALSE----------------------------------------------------------
library(msentropy)
csp <- CompareSpectraParam(requirePrecursor = TRUE, ppm = 10,
                           matchedPeaksCount = TRUE,
                           MAPFUN = joinPeaksNone,
                           FUN = msentropy_similarity,
                           ms2_tolerance_in_ppm = 10,
                           ms2_tolerance_in_da = -1)
mtches <- matchSpectra(pest_ms2, minimb, param = csp)
mtches

## ----message = FALSE----------------------------------------------------------
mbank <- MassBankSource("2022.06")
mbank

## -----------------------------------------------------------------------------
res <- matchSpectra(
    pest_ms2, mbank,
    param = CompareSpectraParam(requirePrecursor = TRUE, ppm = 10))
res

## -----------------------------------------------------------------------------
target(res)

## -----------------------------------------------------------------------------
matchedData(res)$target_name

## -----------------------------------------------------------------------------
fts <- data.frame(
    feature_id = c("FT001", "FT002", "FT003", "FT004", "FT005"),
    mzmed = c(313.43, 256.11, 224.08, 159.22, 224.08),
    rtmed = c(38.5, 379.1, 168.2, 48.2, 381.1))

## -----------------------------------------------------------------------------
fts_mtch <- matchValues(fts, pest_ms2, MzRtParam(ppm = 50, toleranceRt = 3),
                        mzColname = c("mzmed", "precursorMz"),
                        rtColname = c("rtmed", "rtime"))
fts_mtch
whichQuery(fts_mtch)

## -----------------------------------------------------------------------------
fts_mtched <- fts_mtch[whichQuery(fts_mtch)]
fts_mtched

## -----------------------------------------------------------------------------
fts_mtched$feature_id

## -----------------------------------------------------------------------------
targetIndex(fts_mtched)

## -----------------------------------------------------------------------------
fts_ms2 <- target(fts_mtched)[targetIndex(fts_mtched)]
fts_ms2

## -----------------------------------------------------------------------------
fts_ms2$feature_id <- fts_mtched$feature_id

## -----------------------------------------------------------------------------
fts_mtch$feature_id

## -----------------------------------------------------------------------------
fts_ms2 <- target(fts_mtch)[targetIndex(fts_mtch)]
fts_ms2$feature_id <- query(fts_mtch)$feature_id[queryIndex(fts_mtch)]
fts_ms2$feature_id

## -----------------------------------------------------------------------------
pest_ms2_mem <- setBackend(pest_ms2, MsBackendMemory())
minimb_mem <- setBackend(minimb, MsBackendMemory())
csp <- CompareSpectraParam(requirePrecursor = TRUE, ppm = 10,
                           matchedPeaksCount = TRUE)

library(microbenchmark)
microbenchmark(compareSpectra(pest_ms2, minimb, param = csp),
               compareSpectra(pest_ms2_mem, minimb_mem, param = csp),
               times = 5)

## -----------------------------------------------------------------------------
library(MetaboCoreUtils)

## -----------------------------------------------------------------------------
standard <- read.table(system.file("extdata", "Standard_list_example.txt",
                               package = "MetaboAnnotation"),
                   header = TRUE, sep = "\t", quote = "")

## -----------------------------------------------------------------------------
#' Calculate mass based on formula of compounds
standard$mass <- calculateMass(standard$formula)

#' Create input for function
#' Calculate charge for 2 adducts
standard_charged <- mass2mz(standard$mass, adduct = c("[M+H]+", "[M+Na]+"))

#' have compounds names as rownames
rownames(standard_charged) <- standard[ , 1]

#' ensure the input `x` is a matrix
if (!is.matrix(standard_charged))
    standard_charged <- as.matrix(standard_charged, drop = FALSE)

## -----------------------------------------------------------------------------
standard_charged

## -----------------------------------------------------------------------------
group_no_randomization <- createStandardMixes(standard_charged[1:20,])
group_no_randomization

## -----------------------------------------------------------------------------
table(group_no_randomization$group)

## -----------------------------------------------------------------------------
group_no_randomization <- createStandardMixes(standard_charged)
table(group_no_randomization$group)

## -----------------------------------------------------------------------------
group_with_ramdomization <- createStandardMixes(standard_charged,
                                                iterativeRandomization = TRUE)

table(group_with_ramdomization$group)

## -----------------------------------------------------------------------------
set.seed(123)
group_with_ramdomization <- createStandardMixes(standard_charged,
                                                max_nstd = 15,
                                                min_nstd = 10,
                                                min_diff = 2,
                                                iterativeRandomization = TRUE)

table(group_with_ramdomization$group)

## ----eval=FALSE---------------------------------------------------------------
# write.table(group_with_ramdomization,
#            file = "standard_mixes.txt", sep = "\t", quote = FALSE)

## ----sessioninfo, echo=FALSE--------------------------------------------------
sessionInfo()

