# Code example from 'Example_Data_for_RNAseqCovarImpute' vignette. See references/ for full tutorial.

## ----message=FALSE, warning=FALSE, eval = requireNamespace(c("stringr", "tidyr"))----
library(dplyr)
library(stringr)
library(tidyr)
library(edgeR)
library(mice)
# Generate random covariate data
set.seed(2023)
x1 <- rnorm(n = 500)
y1 <- rnorm(n = 500)
z1 <- rnorm(n = 500)
a1 <- rbinom(n = 500, prob = .25, size = 1)
b1 <- rbinom(n = 500, prob = .5, size = 1)
data <- data.frame(x = x1, y = y1, z = z1, a = a1, b = b1)

# Generate random count data from Poisson distribution
nsamp <- nrow(data)
ngene <- 500
mat <- matrix(stats::rpois(n = nsamp * ngene, lambda = sample(1:500, ngene, replace = TRUE)),
    nrow = ngene,
    ncol = nsamp
)

# Make fake ENSEMBL gene numbers
annot <- tibble(number = seq_len(ngene), name1 = "ENS") %>%
    mutate(ENSEMBL = str_c(name1, number)) %>%
    dplyr::select(ENSEMBL)
rownames(mat) <- annot$ENSEMBL

# Make DGE list and set rownames to ENSEMBL gene numbers above
example_DGE <- DGEList(mat, genes = annot)
rownames(example_DGE) <- annot$ENSEMBL

## ----message=FALSE, warning=FALSE---------------------------------------------
# First get all combos of 0 or 1 for the 4 other variables (y, z, a, and b)
pattern_vars <- expand.grid(c(0, 1), c(0, 1), c(0, 1), c(0, 1))
# Then add back a column for the predictor of interest, which is never amputed, so the first col =1 the whole way down
pattern2 <- matrix(1, nrow = nrow(pattern_vars), ncol = 1)
pattern1 <- cbind(pattern2, pattern_vars)
# Remove last row which is all 1s (all 1s means no missingness induced)
pattern <- pattern1[seq_len(15), ]

# Specify proportion of missing data and missingness mechanism for the ampute function
prop_miss <- 25
miss_mech <- "MAR"
result <- ampute(data = data, prop = prop_miss, mech = miss_mech, patterns = pattern)

# Extract the missing data
example_data <- result$amp
# Ampute function turns factors to numeric, so convert back to factors
example_data <- example_data %>% mutate(
    a = as.factor(a),
    b = as.factor(b)
)

# Calculate the new sample size if NAs are dropped as in a complete case analysis
sample_size <- example_data %>%
    drop_na() %>%
    nrow()

# As shown below, we have 24.2% missingness.
100 * (nsamp - sample_size) / nsamp

## ----message=FALSE, warning=FALSE, echo=FALSE---------------------------------
example_data %>%
    head(10) %>%
    knitr::kable(digits = 3, caption = "The first 10 rows of simulated covariate data with missingness")

## ----sessionInfo, echo=FALSE--------------------------------------------------
sessionInfo()

