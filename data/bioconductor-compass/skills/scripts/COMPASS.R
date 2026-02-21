# Code example from 'COMPASS' vignette. See references/ for full tutorial.

## ----sim-init-----------------------------------------------------------------
library(COMPASS)
set.seed(123)
n <- 100 ## number of samples
k <- 6 ## number of markers

sid_vec <- paste0("sid_", 1:n) ## sample ids; unique names used to denote samples
iid_vec <- rep_len( paste0("iid_", 1:(n/10) ), n ) ## individual ids

## ----sim-data-----------------------------------------------------------------
data <- replicate(n, {
  nrow <- round(runif(1) * 1E4 + 1000)
  ncol <- k
  vals <- rexp( nrow * ncol, runif(1, 1E-5, 1E-3) )
  vals[ vals < 2000 ] <- 0
  output <- matrix(vals, nrow, ncol)
  output <- output[ apply(output, 1, sum) > 0, ]
  colnames(output) <- paste0("M", 1:k)
  return(output)
})
names(data) <- sid_vec
head( data[[1]] )

## ----sim-counts---------------------------------------------------------------
counts <- sapply(data, nrow) + round( rnorm(n, 1E4, 1E3) )
counts <- setNames( as.integer(counts), names(counts) )
head(counts)

## ----sim-meta-----------------------------------------------------------------
meta <- data.frame(
  sid=sid_vec,
  iid=iid_vec,
  trt=sample( c("Control", "Treatment"), n, TRUE )
)
head(meta)

## ----sim-CC-------------------------------------------------------------------
CC <- COMPASSContainer(
  data=data,
  counts=counts,
  meta=meta,
  individual_id="iid",
  sample_id="sid"
)

## ----CC-basics----------------------------------------------------------------
CC
summary(CC)

## ----COMPASS-fit--------------------------------------------------------------
fit <- COMPASS( CC,
  treatment=trt == "Treatment",
  control=trt == "Control",
  iterations=100
)

## ----COMPASS-examine----------------------------------------------------------
## Extract the functionality, polyfunctionality scores as described
## within the COMPASS paper -- these are measures of the overall level
## of 'functionality' of a cell, which has shown to be correlated with
## a cell's affinity in immune response
FS <- FunctionalityScore(fit)
PFS <- PolyfunctionalityScore(fit)

## Obtain the posterior difference, posterior log ratio from a COMPASSResult
post <- Posterior(fit)

## Plot a heatmap of the mean probability of response, to visualize differences 
## in expression for each category
plot(fit)

## Visualize the posterior difference, log difference with a heatmap
plot(fit, measure=PosteriorDiff(fit), threshold=0)
plot(fit, measure=PosteriorLogDiff(fit), threshold=0)

## ----citation, echo=FALSE, results='asis'-------------------------------------
cite_package <- function(...) {
  tryCatch({
    args <- unlist( list(...) )
    cites <- lapply(args, citation)
    txt <- sapply(cites, function(x) {
      attr( unclass(x)[[1]], "textVersion" )
    })
    return(txt[order(txt)])
  }, error=function(e) NULL
  )
}
citations <- cite_package("COMPASS", "flowWorkspace", "openCyto", "base")
citations <- c("Lin, L. Finak, G. Ushey, K. Seshadri C. et al. COMPASS identifies T-cell subsets correlated with clinical outcomes. Nature biotechnology (2015). doi:10.1038/nbt.3187", citations[1:2],"Greg Finak, Andrew McDavid, Pratip Chattopadhyay, Maria Dominguez, Steve De Rosa, Mario Roederer, Raphael Gottardo. Mixture models for single-cell assays with applications to vaccine studies. Biostatistics 2014 Jan;15(1):87-101",citations[3:4])
invisible(lapply(citations, function(x) cat(x, "\n\n")))

