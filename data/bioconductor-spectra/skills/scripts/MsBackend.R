# Code example from 'MsBackend' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis', message=FALSE---------------------
BiocStyle::markdown()

## ----echo = FALSE, message = FALSE--------------------------------------------
library(Spectra)
library(BiocStyle)

## ----message = FALSE----------------------------------------------------------
library(Spectra)
library(IRanges)

setClass("MsBackendTest",
         contains = "MsBackend",
         slots = c(
             spectraVars = "data.frame",
             mz = "NumericList",
             intensity = "NumericList"
         ),
         prototype = prototype(
             spectraVars = data.frame(),
             mz = NumericList(compress = FALSE),
             intensity = NumericList(compress = FALSE)
         ))

MsBackendTest <- function() {
    new("MsBackendTest")
}

## ----message = FALSE----------------------------------------------------------
setValidity("MsBackendTest", function(object) {
    if (length(object@mz) != length(object@intensity) ||
        length(object@mz) != nrow(object@spectraVars))
        return("length of 'mz' and 'intensity' has to match the number of ",
               "rows of 'spectraVars'")
    NULL
})

## -----------------------------------------------------------------------------
MsBackendTest()

## -----------------------------------------------------------------------------
setMethod(
    "spectraData", "MsBackendTest",
    function(object, columns = spectraVariables(object)) {
        if (!all(columns %in% spectraVariables(object)))
            stop("Some of the requested spectra variables are not available")
        res <- fillCoreSpectraVariables(
            object@spectraVars,
            columns = columns[!columns %in% c("mz", "intensity")])
        ## Add m/z and intensity values to the result
        res$mz <- object@mz
        res$intensity <- object@intensity
        as(res[, columns, drop = FALSE], "DataFrame")
})

## -----------------------------------------------------------------------------
coreSpectraVariables()

## -----------------------------------------------------------------------------
setMethod("spectraVariables", "MsBackendTest", function(object) {
    union(names(coreSpectraVariables()), colnames(object@spectraVars))
})

## -----------------------------------------------------------------------------
setMethod(
    "backendInitialize", "MsBackendTest",
    function(object, svars, mz, intensity) {
        if (!is.data.frame(svars))
            stop("'svars' needs to be a 'data.frame' with spectra variables")
        if (is.null(svars$dataStorage))
            svars$dataStorage <- "<memory>"
        if (is.null(svars$dataOrigin))
            svars$dataOrigin <- "<user provided>"
        object@spectraVars <- svars
        object@mz <- NumericList(mz, compress = FALSE)
        object@intensity <- NumericList(intensity, compress = FALSE)
        validObject(object)
        object
    })

## -----------------------------------------------------------------------------
## A data.frame with spectra variables.
svars <- data.frame(msLevel = c(1L, 2L, 2L),
                    rtime = c(1.2, 1.3, 1.4))
## m/z values for each spectrum.
mzs <- list(c(12.3, 13.5, 16.5, 17.5),
            c(45.1, 45.2),
            c(64.4, 123.1, 124.1))
## intensity values for each spectrum.
ints <- list(c(123.3, 153.6, 2354.3, 243.4),
             c(100, 80.1),
             c(12.3, 35.2, 100))

## Create and initialize the backend
be <- backendInitialize(MsBackendTest(),
                        svars = svars, mz = mzs, intensity = ints)
be

## -----------------------------------------------------------------------------
#' Helper function to check if core spectra variables have the correct
#' data type.
#'
#' @param x `data.frame` with the data for spectra variables.
#'
#' @param name `character` defining the column names (spectra variables) of `x`
#'     for which the correct data type should be evaluated.
.sv_valid_data_type <- function(x, name = colnames(x)) {
    sv <- coreSpectraVariables()[names(coreSpectraVariables()) %in% name]
    for (i in seq_along(sv)) {
        if (!is(x[, names(sv[i])], sv[i]))
            stop("Spectra variabe \"", names(sv[i]), "\" is not of type ",
                 sv[i], call. = FALSE)
    }
    TRUE
}

## -----------------------------------------------------------------------------
setMethod(
    "backendInitialize", "MsBackendTest",
    function(object, svars, mz, intensity, data) {
        if (!missing(data)) {
            svars <- as.data.frame(
                data[, !colnames(data) %in% c("mz", "intensity")])
            if (any(colnames(data) == "mz"))
                mz <- data$mz
            if (any(colnames(data) == "intensity"))
                intensity <- data$intensity
        }
        if (!is.data.frame(svars))
            stop("'svars' needs to be a 'data.frame' with spectra variables")
        if (is.null(svars$dataStorage))
            svars$dataStorage <- "<memory>"
        if (is.null(svars$dataOrigin))
            svars$dataOrigin <- "<user provided>"
        .sv_valid_data_type(svars)
        object@spectraVars <- svars
        object@mz <- NumericList(mz, compress = FALSE)
        object@intensity <- NumericList(intensity, compress = FALSE)
        validObject(object)
        object
    })

## -----------------------------------------------------------------------------
## Create and initialize the backend
be <- backendInitialize(MsBackendTest(),
                        svars = svars, mz = mzs, intensity = ints)
be

## -----------------------------------------------------------------------------
## Full data
spectraData(be)

## Selected variables
spectraData(be, c("rtime", "mz", "centroided"))

## Only missing core spectra variables
spectraData(be, c("centroided", "polarity"))

## -----------------------------------------------------------------------------
spectraVariables(be)

## -----------------------------------------------------------------------------
setMethod(
    "peaksData", "MsBackendTest",
    function(object, columns = c("mz", "intensity")) {
        if (length(columns) != 2 && columns != c("mz", "intensity"))
            stop("'columns' supports only \"mz\" and \"intensity\"")
        mapply(mz = object@mz, intensity = object@intensity,
               FUN = cbind, SIMPLIFY = FALSE, USE.NAMES = FALSE)
    })

## -----------------------------------------------------------------------------
peaksData(be)

## -----------------------------------------------------------------------------
setMethod("extractByIndex", c("MsBackendTest", "ANY"), function(object, i) {
    object@spectraVars <- object@spectraVars[i, ]
    object@mz <- object@mz[i]
    object@intensity <- object@intensity[i]
    object
})

## -----------------------------------------------------------------------------
a <- extractByIndex(be, 2:3)
spectraData(a)

## -----------------------------------------------------------------------------
a <- be[c(2, 2, 2)]
spectraData(a)

## -----------------------------------------------------------------------------
setMethod("backendMerge", "MsBackendTest", function(object, ...) {
    res <- object
    object <- unname(c(object, ...))
    res@mz <- do.call(c, lapply(object, function(z) z@mz))
    res@intensity <- do.call(c, lapply(object, function(z) z@intensity))
    res@spectraVars <- do.call(MsCoreUtils::rbindFill,
                               lapply(object, function(z) z@spectraVars))
    validObject(res)
    res
})

## -----------------------------------------------------------------------------
a <- backendMerge(be, be[2], be)
a

## -----------------------------------------------------------------------------
setMethod("intensity", "MsBackendTest", function(object) {
    object@intensity
})
intensity(be)

## -----------------------------------------------------------------------------
setMethod("mz", "MsBackendTest", function(object) {
    object@mz
})
mz(be)

## -----------------------------------------------------------------------------
setMethod("spectraNames", "MsBackendTest", function(object) {
    rownames(object@spectraVars)
})
spectraNames(be)

## -----------------------------------------------------------------------------
.match_length <- function(x, y) {
    if (length(x) != length(y))
        stop("Length of 'value' has to match the length of 'object'")
}

setReplaceMethod("$", "MsBackendTest", function(x, name, value) {
    .match_length(x, value)
    if (name == "mz") {
        mz(x) <- value
    } else if (name == "intensity") {
       intensity(x) <- value
    } else {
        x@spectraVars[[name]] <- value
    }
    .sv_valid_data_type(x@spectraVars, name)
    x
})

## -----------------------------------------------------------------------------
msLevel(be)
be$msLevel <- c(2L, 1L, 2L)
msLevel(be)

## -----------------------------------------------------------------------------
be$new_var <- c("a", "b", "c")
be$new_var

## -----------------------------------------------------------------------------
setReplaceMethod("spectraData", "MsBackendTest", function(object, value) {
    if (!inherits(value, "DataFrame"))
        stop("'value' is expected to be a 'DataFrame'")
    if (length(object) && length(object) != nrow(value))
        stop("'value' has to be a 'DataFrame' with ", length(object), " rows")
    object <- backendInitialize(MsBackendTest(), data = value)
    object
})

## -----------------------------------------------------------------------------
d <- spectraData(be)
d$new_col <- c("a", "b", "c")

spectraData(be) <- d
be$new_col

## -----------------------------------------------------------------------------
setReplaceMethod("intensity", "MsBackendTest", function(object, value) {
    .match_length(object, value)
    if (!(is.list(value) || inherits(value, "NumericList")))
        stop("'value' has to be a list or NumericList")
    if (!all(lengths(value) == lengths(mz(object))))
        stop("lengths of 'value' has to match the number of peaks per spectrum")
    if (!inherits(value, "NumericList"))
        value <- NumericList(value, compress = FALSE)
    object@intensity <- value
    object
})

## -----------------------------------------------------------------------------
intensity(be)
intensity(be) <- intensity(be) - 10
intensity(be)

## -----------------------------------------------------------------------------
setReplaceMethod("mz", "MsBackendTest", function(object, value) {
    .match_length(object, value)
    if (!(is.list(value) || inherits(value, "NumericList")))
        stop("'value' has to be a list or NumericList")
    if (!all(lengths(value) == lengths(mz(object))))
        stop("lengths of 'value' has to match the number of peaks per spectrum")
    if (!inherits(value, "NumericList"))
        value <- NumericList(value, compress = FALSE)
    if (any(is.unsorted(value)))
        stop("m/z values need to be increasingly sorted within each spectrum")
    object@mz <- value
    object
})

## -----------------------------------------------------------------------------
setReplaceMethod("peaksData", "MsBackendTest", function(object, value) {
    if (!(is.list(value) || inherits(value, "SimpleList")))
        stop("'value' has to be a list-like object")
    .match_length(object, value)
    object@mz <- NumericList(lapply(value, "[", , "mz"), compress = FALSE)
    object@intensity <- NumericList(lapply(value, "[", , "intensity"),
                                    compress = FALSE)
    validObject(object)
    object
})

## -----------------------------------------------------------------------------
pd <- peaksData(be)
## Remove the first peak from the first spectrum
pd[[1L]] <- pd[[1L]][-1L, ]

lengths(be)
peaksData(be) <- pd
lengths(be)

## -----------------------------------------------------------------------------
setMethod(
    "selectSpectraVariables", "MsBackendTest",
    function(object, spectraVariables = spectraVariables(object)) {
        keep <- colnames(object@spectraVars) %in% spectraVariables
        object@spectraVars <- object@spectraVars[, keep, drop = FALSE]
        if (!any(spectraVariables == "mz"))
            object@mz <- NumericList(vector("list", length(object)),
                                     compress = FALSE)
        if (!any(spectraVariables == "intensity"))
            object@intensity <- NumericList(vector("list", length(object)),
                                            compress = FALSE)
        validObject(object)
        object
    })

## -----------------------------------------------------------------------------
be2 <- be
be2 <- selectSpectraVariables(be2, c("msLevel", "rtime", "mz",
                                     "intensity", "dataStorage"))
spectraVariables(be2)

## -----------------------------------------------------------------------------
dataOrigin(be)
dataOrigin(be2)

## -----------------------------------------------------------------------------
be2 <- selectSpectraVariables(be2, c("msLevel", "rtime", "dataStorage"))
mz(be2)
intensity(be2)

## -----------------------------------------------------------------------------
setReplaceMethod("dataStorage", "MsBackendTest", function(object, value) {
    object$dataStorage <- value
    object
})

## -----------------------------------------------------------------------------
dataStorage(be)
dataStorage(be) <- c("", "", "")
dataStorage(be)

## -----------------------------------------------------------------------------
setReplaceMethod("spectraNames", "MsBackendTest", function(object, value) {
    rownames(object@spectraVars) <- value
    object
})

## -----------------------------------------------------------------------------
spectraNames(be) <- c("a", "b", "c")
spectraNames(be)

## -----------------------------------------------------------------------------
setMethod("$", "MsBackend", function(x, name) {
    spectraData(x, columns = name)[, 1L]
})

## -----------------------------------------------------------------------------
setMethod("acquisitionNum", "MsBackend", function(object) {
    spectraData(object, "acquisitionNum")[, 1L]
})

## -----------------------------------------------------------------------------
setMethod("backendBpparam", signature = "MsBackend",
          function(object, BPPARAM = bpparam()) {
              ## Return SerialParam() instead to disable parallel processing
              BPPARAM
          })


## -----------------------------------------------------------------------------
setMethod("backendParallelFactor", "MsBackend", function(object, ...) {
    factor()
})


## -----------------------------------------------------------------------------
setMethod("backendRequiredSpectraVariables", "MsBackend",
          function(object, ...) {
              character()
          })

## -----------------------------------------------------------------------------
setMethod("centroided", "MsBackend", function(object) {
    spectraData(object, "centroided")[, 1L]
})

## -----------------------------------------------------------------------------
setReplaceMethod("centroided", "MsBackend", function(object, value) {
    object$centroided <- value
    object
})

## -----------------------------------------------------------------------------
centroided(be) <- c(TRUE, FALSE, TRUE)
centroided(be)

## -----------------------------------------------------------------------------
setMethod("collisionEnergy", "MsBackend", function(object) {
    spectraData(object, "collisionEnergy")[, 1L]
})

## -----------------------------------------------------------------------------
setReplaceMethod("collisionEnergy", "MsBackend", function(object, value) {
    object$collisionEnergy <- value
    object
})

## -----------------------------------------------------------------------------
setMethod("dataOrigin", "MsBackend", function(object) {
    spectraData(object, "dataOrigin")[, 1L]
})

## -----------------------------------------------------------------------------
setReplaceMethod("dataOrigin", "MsBackend", function(object, value) {
    object$dataOrigin <- value
    object
})

## -----------------------------------------------------------------------------
dataOrigin(be)
dataOrigin(be) <- c("unknown", "file a", "file b")
dataOrigin(be)

## -----------------------------------------------------------------------------
setMethod("dataOrigin", "MsBackend", function(object) {
    spectraData(object, "dataStorage")[, 1L]
})

## -----------------------------------------------------------------------------
setMethod("dropNaSpectraVariables", "MsBackend", function(object) {
    svs <- spectraVariables(object)
    svs <- svs[!(svs %in% c("mz", "intensity"))]
    spd <- spectraData(object, columns = svs)
    keep <- !vapply1l(spd, function(z) all(is.na(z)))
    selectSpectraVariables(object, c(svs[keep], "mz", "intensity"))
})

## -----------------------------------------------------------------------------
setMethod("isEmpty", "MsBackend", function(x) {
    lengths(x) == 0L
})

## -----------------------------------------------------------------------------
setMethod("isolationWindowLowerMz", "MsBackend", function(object) {
    spectraData(object, "isolationWindowLowerMz")[, 1L]
})

## -----------------------------------------------------------------------------
setReplaceMethod(
    "isolationWindowLowerMz", "MsBackend", function(object, value) {
        object$isolationWindowLowerMz <- value
        object
    })

## -----------------------------------------------------------------------------
isolationWindowLowerMz(be) <- c(NA_real_, 245.3, NA_real_)
isolationWindowLowerMz(be)

## -----------------------------------------------------------------------------
setMethod("isolationWindowTargetMz", "MsBackend", function(object) {
    spectraData(object, "isolationWindowTargetMz")[, 1L]
})

## -----------------------------------------------------------------------------
setReplaceMethod(
    "isolationWindowTargetMz", "MsBackend", function(object, value) {
        object$isolationWindowTargetMz <- value
        object
    })

## -----------------------------------------------------------------------------
isolationWindowTargetMz(be) <- c(NA_real_, 245.4, NA_real_)
isolationWindowTargetMz(be)

## -----------------------------------------------------------------------------
setMethod("isolationWindowUpperMz", "MsBackend", function(object) {
    spectraData(object, "isolationWindowUpperMz")[, 1L]
})

## -----------------------------------------------------------------------------
setReplaceMethod(
    "isolationWindowUpperMz", "MsBackend", function(object, value) {
        object$isolationWindowUpperMz <- value
        object
    })

## -----------------------------------------------------------------------------
isolationWindowUpperMz(be) <- c(NA_real_, 245.5, NA_real_)
isolationWindowUpperMz(be)

## -----------------------------------------------------------------------------
setMethod("isReadOnly", "MsBackend", function(object) {
    object@readonly
})

## -----------------------------------------------------------------------------
setMethod("length", "MsBackend", function(x) {
    nrow(spectraData(x))
})

## -----------------------------------------------------------------------------
setMethod("lengths", "MsBackend", function(x, use.names = FALSE) {
    vapply(peaksData(x), nrow, NA_integer_)
})


## -----------------------------------------------------------------------------
setMethod("lengths", "MsBackendTest", function(x, use.names = FALSE) {
    lengths(x@mz, use.names = use.names)
})

## -----------------------------------------------------------------------------
lengths(be)

## -----------------------------------------------------------------------------
setMethod("msLevel", "MsBackend", function(object) {
    spectraData(object, "msLevel")[, 1L]
})

## -----------------------------------------------------------------------------
setReplaceMethod("msLevel", "MsBackend", function(object, value) {
    object$msLevel <- value
    object
})

## -----------------------------------------------------------------------------
msLevel(be)
msLevel(be) <- c(1L, 1L, 2L)
msLevel(be)

## -----------------------------------------------------------------------------
setMethod("peaksVariables", "MsBackend", function(object) {
    c("mz", "intensity")
})

## -----------------------------------------------------------------------------
setMethod("polarity", "MsBackend", function(object) {
    spectraData(object, "polarity")[, 1L]
})

## -----------------------------------------------------------------------------
setReplaceMethod("polarity", "MsBackend", function(object, value) {
    object$polarity <- value
    object
})

## -----------------------------------------------------------------------------
polarity(be) <- c(0L, 0L, 0L)
polarity(be)

## -----------------------------------------------------------------------------
setMethod("precScanNum", "MsBackend", function(object) {
    spectraData(object, "precScanNum")[, 1L]
})

## -----------------------------------------------------------------------------
setMethod("precursorCharge", "MsBackend", function(object) {
    spectraData(object, "precursorCharge")[, 1L]
})

## -----------------------------------------------------------------------------
setMethod("precursorIntensity", "MsBackend", function(object) {
    spectraData(object, "precursorIntensity")[, 1L]
})

## -----------------------------------------------------------------------------
setMethod("precursorMz", "MsBackend", function(object) {
    spectraData(object, "precursorMz")[, 1L]
})

## -----------------------------------------------------------------------------
setReplaceMethod("precursorMz", "MsBackend", function(object, ..., value) {
    object$precursorMz <- value
    object
})

## -----------------------------------------------------------------------------
setMethod("ionCount", "MsBackend", function(object) {
    vapply1d(intensity(object), sum, na.rm = TRUE)
})

## -----------------------------------------------------------------------------
setMethod("isCentroided", "MsBackend", function(object, ...) {
    vapply1l(peaksData(object), .peaks_is_centroided)
})

## -----------------------------------------------------------------------------
setMethod("reset", "MsBackend", function(object) {
    object
})

## ----eval = FALSE-------------------------------------------------------------
# setMethod("export", "MsBackendMzR", function(object, x, file = tempfile(),
#                                              format = c("mzML", "mzXML"),
#                                              copy = FALSE,
#                                              BPPARAM = bpparam()) {
#     l <- length(x)
#     file <- sanitize_file_name(file)
#     if (length(file) == 1)
#         file <- rep_len(file, l)
#     if (length(file) != l)
#         stop("Parameter 'file' has to be either of length 1 or ",
#              length(x), ", i.e. 'length(x)'.", call. = FALSE)
#     f <- factor(file, levels = unique(file))
#     tmp <- bpmapply(.write_ms_data_mzR, split(x, f), levels(f),
#                     MoreArgs = list(format = format, copy = copy),
#                     BPPARAM = BPPARAM)
# })

## -----------------------------------------------------------------------------
setMethod("rtime", "MsBackend", function(object) {
    spectraData(object, "rtime")[, 1L]
})

## -----------------------------------------------------------------------------
setReplaceMethod("rtime", "MsBackend", function(object, value) {
    object$rtime <- value
    object
})

## -----------------------------------------------------------------------------
rtime(be)
rtime(be) <- rtime(be) + 2
rtime(be)

## -----------------------------------------------------------------------------
setMethod("scanIndex", "MsBackend", function(object) {
    spectraData(object, "scanIndex")[, 1L]
})

## -----------------------------------------------------------------------------
setMethod("smoothed", "MsBackend", function(object) {
    spectraData(object, "smoothed")[, 1L]
})

## -----------------------------------------------------------------------------
setReplaceMethod("smoothed", "MsBackend", function(object, value) {
    object$smoothed <- value
    object
})

## -----------------------------------------------------------------------------
smoothed(be) <- rep(TRUE, 3)
smoothed(be)

## -----------------------------------------------------------------------------
setMethod("split", "MsBackend", function(x, f, drop = FALSE, ...) {
    split.default(x, f, drop = drop, ...)
})

## -----------------------------------------------------------------------------
setMethod("supportsSetBackend", "MsBackend", function(object, ...) {
    !isReadOnly(object)
})

## -----------------------------------------------------------------------------
setMethod("tic", "MsBackend", function(object, initial = TRUE) {
    if (initial) {
        if (any(spectraVariables(object) == "totIonCurrent"))
            spectraData(object, "totIonCurrent")[, 1L]
        else rep(NA_real_, length(object))
    } else vapply(intensity(object), sum, numeric(1), na.rm = TRUE)
})

## -----------------------------------------------------------------------------
setMethod("uniqueMsLevels", "MsBackend", function(object, ...) {
    unique(msLevel(object))
})

## -----------------------------------------------------------------------------
setMethod("filterDataOrigin", "MsBackend",
          function(object, dataOrigin = character()) {
              if (length(dataOrigin)) {
                  object <- object[dataOrigin(object) %in% dataOrigin]
                  if (is.unsorted(dataOrigin))
                      object[order(match(dataOrigin(object), dataOrigin))]
                  else object
              } else object
          })


## -----------------------------------------------------------------------------
setMethod("filterDataStorage", "MsBackend",
          function(object, dataStorage = character()) {
              if (length(dataStorage)) {
                  object <- object[dataStorage(object) %in% dataStorage]
                  if (is.unsorted(dataStorage))
                      object[order(match(dataStorage(object), dataStorage))]
                  else object
              } else object
          })

## -----------------------------------------------------------------------------
setMethod("filterEmptySpectra", "MsBackend", function(object, ...) {
    if (!length(object)) return(object)
    object[as.logical(lengths(object))]
})

## -----------------------------------------------------------------------------
setMethod("filterIsolationWindow", "MsBackend",
          function(object, mz = numeric(), ...) {
              if (length(mz)) {
                  if (length(mz) > 1)
                      stop("'mz' is expected to be a single m/z value")
                  keep <- which(isolationWindowLowerMz(object) <= mz &
                                isolationWindowUpperMz(object) >= mz)
                  object[keep]
              } else object
          })

## -----------------------------------------------------------------------------
setMethod("filterMsLevel", "MsBackend",
          function(object, msLevel = integer()) {
              if (length(msLevel)) {
                  object[msLevel(object) %in% msLevel]
              } else object
          })

## -----------------------------------------------------------------------------
setMethod("filterPolarity", "MsBackend",
          function(object, polarity = integer()) {
              if (length(polarity))
                  object[polarity(object) %in% polarity]
              else object
          })

## -----------------------------------------------------------------------------
library(MsCoreUtils)
setMethod("filterPrecursorMzRange", "MsBackend",
          function(object, mz = numeric()) {
              if (length(mz)) {
                  mz <- range(mz)
                  keep <- which(between(precursorMz(object), mz))
                  object[keep]
              } else object
          })

## -----------------------------------------------------------------------------
setMethod("filterPrecursorMzValues", "MsBackend",
          function(object, mz = numeric(), ppm = 20, tolerance = 0) {
              if (length(mz)) {
                  object[.values_match_mz(precursorMz(object), mz = mz,
                                          ppm = ppm, tolerance = tolerance)]
              } else object
          })

## -----------------------------------------------------------------------------
.values_match_mz <- function(x, mz, ppm = 20, tolerance = 0) {
    o <- order(x, na.last = NA)
    cmn <- common(x[o], sort(mz), tolerance = tolerance, ppm = ppm,
                  duplicates = "keep", .check = FALSE)
    sort(o[cmn])
}

## -----------------------------------------------------------------------------
setMethod("filterPrecursorCharge", "MsBackend",
          function(object, z = integer()) {
              if (length(z)) {
                  keep <- which(precursorCharge(object) %in% z)
                  object[keep]
              } else object
          })

## -----------------------------------------------------------------------------
setMethod("filterPrecursorScan", "MsBackend",
          function(object, acquisitionNum = integer(), f = dataOrigin(object)) {
              if (length(acquisitionNum) && length(f)) {
                  if (!is.factor(f))
                      f <- factor(f, exclude = character())
                  keep <- unsplit(lapply(split(object, f = f), function(z, an) {
                      .filterSpectraHierarchy(acquisitionNum(z),
                                              precScanNum(z),
                                              an)
                  }, an = acquisitionNum), f = f)
                  object[keep]
              } else object
          })

## -----------------------------------------------------------------------------
setMethod("filterRt", "MsBackend",
          function(object, rt = numeric(), msLevel. = integer()) {
              if (length(rt)) {
                  rt <- range(rt)
                  sel_ms <- msLevel(object) %in% msLevel.
                  sel_rt <- between(rtime(object), rt) & sel_ms
                  object[sel_rt | !sel_ms]
              } else object
          })

## ----eval = FALSE-------------------------------------------------------------
# library(testthat)
# test_suite <- system.file("test_backends", "test_MsBackend",
#                           package = "Spectra")
# test_dir(test_suite, stop_on_failure = TRUE)

## ----si-----------------------------------------------------------------------
sessionInfo()

