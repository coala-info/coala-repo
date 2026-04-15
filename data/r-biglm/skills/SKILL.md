---
name: r-biglm
description: The r-biglm package fits linear and generalized linear models to large datasets by processing data in chunks or through database connections. Use when user asks to perform regression on datasets that exceed available memory, fit models using incremental QR decomposition, or run GLMs directly on database tables.
homepage: https://cloud.r-project.org/web/packages/biglm/index.html
---

# r-biglm

## Overview
The `biglm` package provides functions for fitting linear models (`biglm`) and generalized linear models (`bigglm`) using incremental QR decomposition. This allows for regression analysis on datasets that exceed available RAM by processing data in chunks or directly from a database connection (DBI).

## Installation
```R
install.packages("biglm")
```

## Core Functions

### biglm (Linear Models)
Used for standard linear regression.
```R
# Initial fit
model <- biglm(formula, data = first_chunk)

# Update with more data
model <- update(model, more_data)
```

### bigglm (Generalized Linear Models)
Used for logistic, Poisson, or other GLMs.
```R
# Fit using a data provider function or database
model <- bigglm(formula, data = data_source, family = binomial())
```

## Common Workflows

### 1. Processing Data in Chunks
When data is in a large file, read and update the model iteratively:
```R
library(biglm)

# Initialize with the first chunk
con <- file("large_data.csv", "r")
chunk <- read.csv(con, nrows = 1000)
model <- biglm(y ~ x1 + x2, data = chunk)

# Iteratively update
while(nrow(chunk <- read.csv(con, nrows = 1000)) > 0) {
  model <- update(model, chunk)
}
close(con)

summary(model)
```

### 2. Database Integration
`bigglm` can interface directly with database tables via `DBI`.
```R
library(DBI)
library(RSQLite)

con <- dbConnect(SQLite(), "my_data.sqlite")
# bigglm handles the chunking automatically via the database connection
model <- bigglm(y ~ x1 + x2, data = con, tablename = "large_table", family = gaussian())

summary(model)
dbDisconnect(con)
```

### 3. Using a Data Provider Function
For custom streaming, pass a function that returns a data frame (and `NULL` when finished).
```R
make_data <- function(reset = FALSE) {
   if(reset) {
     # code to reset data pointer
     return(NULL)
   }
   # code to return next data frame chunk
}

model <- bigglm(y ~ x1, data = make_data, family = Poisson())
```

## Tips and Limitations
- **Memory Efficiency**: The memory usage is $O(p^2)$, where $p$ is the number of predictors, regardless of the number of observations ($n$).
- **Sandwich Estimators**: `biglm` supports robust "sandwich" variance estimators which are calculated in the same single pass.
- **Factors**: Ensure that all levels of a factor are present in the first chunk, or provide the `levels` argument to prevent errors during updates.
- **Methods**: Standard methods like `summary()`, `predict()`, `coef()`, and `AIC()` are supported.

## Reference documentation
- [README](./references/README.md)
- [Home Page](./references/home_page.md)