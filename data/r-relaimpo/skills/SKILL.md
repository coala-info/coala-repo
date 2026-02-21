---
name: r-relaimpo
description: Provides several metrics for assessing relative importance in linear models. These can be printed, plotted and bootstrapped. The recommended metric is lmg, which provides a decomposition of the model explained variance into non-negative contributions. There is a version of this package available that additionally provides a new and also recommended metric called pmvd. If you are a non-US user, you can download this extended version from Ulrike Groempings web site.</p>
homepage: https://cloud.r-project.org/web/packages/relaimpo/index.html
---

# r-relaimpo

name: r-relaimpo
description: Assessing relative importance of regressors in linear models using the relaimpo R package. Use this skill when you need to decompose R-squared into contributions from individual predictors, calculate metrics like LMG (Lindeman, Merenda, and Gold), perform bootstrapping for confidence intervals, or handle relative importance in complex survey designs and multiply imputed datasets.

# r-relaimpo

## Overview
The `relaimpo` package provides several metrics for assessing the relative importance of regressors in linear models. It allows for the decomposition of the model's explained variance ($R^2$) into non-negative contributions. The recommended metric is `lmg`, which averages sequential sums of squares over all possible orderings of regressors.

## Installation
```R
install.packages("relaimpo")
library(relaimpo)
```

## Core Workflow: Calculating Relative Importance
Use `calc.relimp()` to calculate importance metrics for a linear model.

### Basic Usage
```R
# Using a data frame (first column is response)
data(swiss)
calc.relimp(swiss, type = "lmg")

# Using a formula
calc.relimp(Fertility ~ Agriculture + Education + Catholic, data = swiss, type = "lmg")

# Using an existing lm object
fit <- lm(Fertility ~ ., data = swiss)
calc.relimp(fit, type = c("lmg", "last", "first"))
```

### Available Metrics
- `lmg`: $R^2$ partitioned by averaging over all orders (Recommended).
- `pmvd`: Proportional marginal variance decomposition (Non-US version only).
- `last`: Contribution of variable when included last (usefulness).
- `first`: Contribution of variable when included first (squared correlation).
- `betasq`: Squared standardized coefficients.
- `pratt`: Product of standardized coefficient and correlation.

### Key Parameters
- `type`: Character vector of metrics to calculate.
- `rela`: Logical. If `TRUE`, metrics are normalized to sum to 100%.
- `always`: Vector of variables to be forced into the model (adjusted for). Importance is only assessed for remaining variables.
- `groups`: List of variables to be treated as a single unit.

## Bootstrapping for Confidence Intervals
To obtain uncertainty estimates, use `boot.relimp` followed by `booteval.relimp`.

```R
# 1. Run bootstrap (b = 1000 recommended for final analysis)
boot_results <- boot.relimp(swiss, b = 100, type = "lmg", rank = TRUE, diff = TRUE)

# 2. Evaluate results
eval_results <- booteval.relimp(boot_results, bty = "perc")

# 3. Print and Plot
print(eval_results)
plot(eval_results)
```

## Advanced Features

### Complex Survey Designs
`relaimpo` integrates with the `survey` package.
```R
library(survey)
des <- svydesign(id = ~1, weights = ~some_weights, data = my_data)
calc.relimp(my_data, design = des, type = "lmg")
```

### Multiply Imputed Data
Use `mianalyze.relimp` to combine results from multiple imputations using Rubin's rules.
```R
# implist is a list of imputed data frames
mianalyze.relimp(implist, formula = y ~ x1 + x2, type = "lmg")
```

### Interactions
- Only the `lmg` metric supports models with interactions (up to 2-way).
- Interactions are treated hierarchically (main effects must be present).
- Use the formula interface: `calc.relimp(y ~ x1 * x2, data = df, type = "lmg")`.

## Tips and Constraints
- **Computational Intensity**: `lmg` and `pmvd` are computer-intensive, especially with many regressors (> 10-12) or during bootstrapping.
- **Missing Values**: The package uses complete-case analysis by default. Use `mianalyze.relimp` for missing data workflows.
- **Model Type**: Only supports univariate linear models (`lm`). Does not support `mlm` (multivariate) or `glm` with non-identity links.

## Reference documentation
- [Package ‘relaimpo’](./references/reference_manual.md)