# Code example from 'MetaboCoreUtils' vignette. See references/ for full tutorial.

## ----style, echo = FALSE, results = 'asis'------------------------------------
BiocStyle::markdown()

## ----message = FALSE----------------------------------------------------------
library("MetaboCoreUtils")
ls(pos = "package:MetaboCoreUtils")

## -----------------------------------------------------------------------------
library(MetaboCoreUtils)

## -----------------------------------------------------------------------------
adductNames()

## -----------------------------------------------------------------------------
masses <- c(123, 842, 324)
mass2mz(masses, adduct = c("[M+H]+", "[M+Na]+"))

## -----------------------------------------------------------------------------
formula2mz(c("C6H12O6", "C8H10N4O2"), adduct = c("[M+H]+", "[M+Na]+"))

## -----------------------------------------------------------------------------
frml <- "Na3C4"
frml <- standardizeFormula(frml)
frml

## -----------------------------------------------------------------------------
frml <- addElements(frml, "H2O")
frml

## -----------------------------------------------------------------------------
frml <- subtractElements(frml, "H")
frml

## -----------------------------------------------------------------------------
countElements(frml)

## -----------------------------------------------------------------------------
adductFormula(c("C6H12O6", "C8H10N4O2"), adduct = c("[M+H]+", "[M+Na]+"))

## -----------------------------------------------------------------------------
calculateMass(c("C6H12O6", "[13C3]C3H12O6"))

## -----------------------------------------------------------------------------
lipid_masses <- c(760.5851, 762.6007, 762.5280)
calculateKmd(lipid_masses)

## -----------------------------------------------------------------------------
lipid_rkmd <- calculateRkmd(lipid_masses)
isRkmd(lipid_rkmd)

## -----------------------------------------------------------------------------
rti <- read.table(system.file("retentionIndex",
                              "rti.txt",
                              package = "MetaboCoreUtils"),
                  header = TRUE,
                  sep = "\t")

rtime <- read.table(system.file("retentionIndex",
                                "metabolites.txt",
                                package = "MetaboCoreUtils"),
                    header = TRUE,
                    sep = "\t")

## -----------------------------------------------------------------------------
head(rti)

## -----------------------------------------------------------------------------
rtime$rindex_r <- indexRtime(rtime$rtime, rti)

## -----------------------------------------------------------------------------
head(rtime)

## -----------------------------------------------------------------------------
ref <- data.frame(rindex = c(1709.8765, 553.7975),
                  refindex = c(1700, 550))

rtime$rindex_cor <- correctRindex(rtime$rindex_r, ref)

## -----------------------------------------------------------------------------
vals <- read.table(system.file("txt", "feature_values.txt",
                               package = "MetaboCoreUtils"), sep = "\t")
vals <- as.matrix(vals)
head(vals)

## -----------------------------------------------------------------------------
#' Define a data frame with the injection index
sdata <- data.frame(injection_index = seq_len(ncol(vals)))

#' Identify columns representing QC samples
qc_index <- grep("^POOL", colnames(vals))

length(qc_index)

## -----------------------------------------------------------------------------
#' Fit linear models explaining observed abundances by injection index.
#' Linear models are fitted row-wise to data of QC samples.
qc_lm <- fit_lm(y ~ injection_index,
                data = sdata[qc_index, , drop = FALSE],
                y = log2(vals[, qc_index]),
                minVals = 9)

## -----------------------------------------------------------------------------
qc_lm[[1]]

## -----------------------------------------------------------------------------
sum(is.na(qc_lm))

## ----fig.cap = "Abundance of an example feature along injection index. Open circles represent measurements in study samples, filled circles in QC samples. The black solid line represents the estimated signal drift."----
plot(x = sdata$injection_index, y = log2(vals[1, ]),
     xlab = "injection_index", ylab = expression(log[2]~abundance))
#' Indicate QC samples
points(x = sdata$injection_index[qc_index],
       y = log2(vals[1, qc_index]), pch = 16, col = "#00000080")
grid()
abline(qc_lm[[1]])

## ----fig.cap = "Abundance of an example feature along injection index. Open circles represent measurements in study samples, filled circles in QC samples. The black solid line represents the estimated signal drift."----
plot(x = sdata$injection_index, y = log2(vals[2, ]),
     xlab = "injection_index", ylab = expression(log[2]~abundance))
#' Indicate QC samples
points(x = sdata$injection_index[qc_index],
       y = log2(vals[2, qc_index]), pch = 16, col = "#00000080")
grid()
abline(qc_lm[[2]])

## -----------------------------------------------------------------------------
#' Extract slope, F-statistic and R squared from each model, skipping
#' features for which no model was fitted.
qc_lm_summary <- lapply(qc_lm, function(z) {
    if (length(z) > 1) {
        s <- summary(z)
        c(slope = coefficients(s)[2, "Estimate"],
          p.value = coefficients(s)[2, 4],
          adj.r.squared = s$adj.r.squared)
    } else c(slope = NA_real_, F = NA_real_,
             adj.r.squared = NA_real_) # returning NA for skipped models
}) |> do.call(what = rbind)

head(qc_lm_summary)

## -----------------------------------------------------------------------------
plot(qc_lm_summary[, "slope"], -log10(qc_lm_summary[, "p.value"]),
     xlab = "injection order dependency", ylab = expression(-log[10](p~value)),
     pch = 21, col = "#00000080", bg = "#00000040")
grid()
abline(h = -log10(0.05))

## -----------------------------------------------------------------------------
idx <- which.max(qc_lm_summary[, "slope"])
plot(x = sdata$injection_index, y = log2(vals[idx, ]),
     xlab = "injection_index", ylab = expression(log[2]~abundance))
#' Indicate QC samples
points(x = sdata$injection_index[qc_index],
       y = log2(vals[idx, qc_index]), pch = 16, col = "#00000080")
grid()
abline(qc_lm[[idx]])

## -----------------------------------------------------------------------------
qc_lm_summary[idx, ]

## -----------------------------------------------------------------------------
idx2 <- which(qc_lm_summary[, "slope"] > 0.01 &
              qc_lm_summary[, "p.value"] > 0.05)
plot(x = sdata$injection_index, y = log2(vals[idx2, ]),
     xlab = "injection_index", ylab = expression(log[2]~abundance))
points(x = sdata$injection_index[qc_index],
       y = log2(vals[idx2, qc_index]), pch = 16, col = "#00000080")
grid()
abline(qc_lm[[idx2]])

## -----------------------------------------------------------------------------
qc_lm_summary[idx2, ]

## -----------------------------------------------------------------------------
qc_lm[qc_lm_summary[, "p.value"] > 0.05] <- NA

## -----------------------------------------------------------------------------
#' Adjust the data for the estimated signal drift
vals_adj <- adjust_lm(log2(vals), data = sdata, lm = qc_lm)

#' Transform data again into natural scale
vals_adj <- 2^vals_adj

## ----fig.cap = "Feature abundances before (open circles) and after adjustment (filled circles). The grey dashed line represents the injection index dependent signal drift estimated on the raw data and the solid grey line the same model estimated on the adjusted data."----
plot(x = sdata$injection_index, y = log2(vals[2, ]),
     xlab = "injection_index", ylab = expression(log[2]~abundance),
     col = "#00000080")
points(x = sdata$injection_index, y = log2(vals_adj[2, ]),
       pch = 16, col = "#00000080")
grid()
abline(qc_lm[[2]], col = "grey", lty = 2)

#' fit a model to the QC samples of the adjusted data
l <- lm(log2(vals_adj[2, qc_index]) ~ sdata$injection_index[qc_index])
abline(l, col = "grey")


## -----------------------------------------------------------------------------
#' Identify features for which the adjustment was performed
fts_adj <- which(!is.na(qc_lm))

#' Define a function to calculate the correlation
cor_fun <- function(i, y) {
    values <- y[i, qc_index]
    if (sum(!is.na(values)) >= 9)
        cor(values, sdata$injection_index[qc_index],
            method = "spearman", use = "pairwise.complete.obs")
    else NA_real_
}

#' Calculate correlations for raw data, skipping features
#' with less than 9 non-missing values
cor_raw <- vapply(seq_along(qc_lm), cor_fun, numeric(1), y = vals)

## -----------------------------------------------------------------------------
#' Calculate correlations for adjusted data
cor_adj <- vapply(seq_along(qc_lm), cor_fun, numeric(1), y = vals_adj)

## ----fig.cap = "Correlation between abundances and injection index for QC samples before (black) and after adjustment (red). Filled circles represent the features for which the drift was adjusted for. Correlation coefficients are sorted."----
plot(sort(cor_raw), col = "#00000080", main = "QC samples", ylab = "rho",
     xlab = "rank")
idx <- order(cor_adj)
bg <- rep(NA, length(cor_adj))
bg[fts_adj] <- "#ff000040"
points(cor_adj[idx], pch = 21, col = "#ff000080", bg = bg[idx])

## -----------------------------------------------------------------------------
?quality_assessment

## -----------------------------------------------------------------------------
# Define sample data for metabolomics analysis
set.seed(123)
metabolomics_data <- matrix(rnorm(100), nrow = 10)
colnames(metabolomics_data) <- paste0("Sample", 1:10)
rownames(metabolomics_data) <- paste0("Feature", 1:10)

## -----------------------------------------------------------------------------
# Calculate and display the coefficient of variation
cv_result <- rowRsd(metabolomics_data)
print(cv_result)

## -----------------------------------------------------------------------------
# Generate QC samples
qc_samples <- matrix(rnorm(40), nrow = 10)
colnames(qc_samples) <- paste0("QC", 1:4)

# Calculate D-ratio and display the result
dratio_result <- rowDratio(metabolomics_data, qc_samples)
print(dratio_result)

## -----------------------------------------------------------------------------
# Introduce missing values in the data
metabolomics_data[sample(1:100, 10)] <- NA

# Calculate and display the percentage of missing values
missing_result <- rowPercentMissing(metabolomics_data)
print(missing_result)

## -----------------------------------------------------------------------------
# Generate blank samples
blank_samples <- matrix(rnorm(30), nrow = 10)
colnames(blank_samples) <- paste0("Blank", 1:3)

# Detect rows where mean(test) > 2 * mean(blank)
blank_detection_result <- rowBlank(metabolomics_data, blank_samples)
print(blank_detection_result)

## -----------------------------------------------------------------------------
# Set filtering thresholds
cv_threshold <- 8
dratio_threshold <- 0.8

# Apply filters
filtered_data <- metabolomics_data[
  cv_result <= cv_threshold &
  dratio_result <= dratio_threshold &
  missing_result <= 10 &
  !blank_detection_result, , drop = FALSE]

# Display the filtered data
print(filtered_data)

## ----sessioninfo, echo=FALSE--------------------------------------------------
sessionInfo()

