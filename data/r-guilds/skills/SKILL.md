---
name: r-guilds
description: R package guilds (documentation from project home).
homepage: https://cran.r-project.org/web/packages/guilds/index.html
---

# r-guilds

name: r-guilds
description: Specialized R package for the Unified Neutral Theory of Biodiversity and Biogeography. Use this skill to apply sampling formulas (Etienne Sampling Formula and Guilds models), perform maximum likelihood optimization for biodiversity parameters (theta, m, alpha), generate artificial species abundance distributions (SAD), and calculate expected SADs for communities with multiple dispersal syndromes.

## Overview

The `guilds` package provides tools for analyzing community biodiversity data using neutral models. It extends the standard Etienne Sampling Formula (ESF) to include "guilds"—groups of species that may differ in dispersal ability. This is particularly useful for testing whether observed species abundance distributions are better explained by multiple dispersal syndromes rather than a single community-wide migration rate.

## Installation

Install the package from CRAN:

```R
install.packages("guilds")
library(guilds)
```

## Core Workflows

### 1. Standard Neutral Model (ESF)
Use these functions when treating the community as a single unit without guild structure.

*   **Generate Data**: `generate.ESF(theta, I, J)`
*   **Parameter Estimation**: `maxLikelihood.ESF(init_vals, abund)`
*   **Expected SAD**: `expected.SAD(theta, m, J)`

```R
# Example: Estimate parameters for a single community
theta_true <- 100
m_true <- 0.1
J <- 10000
I <- m_true * (J - 1) / (1 - m_true)

abund <- generate.ESF(theta_true, I, J)
fit <- maxLikelihood.ESF(init_vals = c(50, 0.05), abund = abund)
```

### 2. Guilds Model (Conditional on Guild Size)
Use these functions when you have data partitioned into two guilds (e.g., different dispersal syndromes) and know the total number of individuals in each guild ($J_x$ and $J_y$).

*   **Generate Data**: `generate.Guilds.Cond(theta, alpha_x, alpha_y, J_x, J_y)`
*   **Parameter Estimation**: `maxLikelihood.Guilds.Conditional(init_vals, model, sadx, sady)`
    *   `model = "D0"`: Assumes equal dispersal ($\alpha_x = \alpha_y$).
    *   `model = "D1"`: Assumes different dispersal ($\alpha_x \neq \alpha_y$).
*   **Expected SAD**: `expected.SAD.Guilds.Conditional(theta, alpha_x, alpha_y, J_x, J_y)`

```R
# Example: Compare D0 vs D1 models
# abund_x and abund_y are vectors of species abundances for each guild
fit_d0 <- maxLikelihood.Guilds.Conditional(init_vals = c(100, 0.1), 
                                           model = "D0", 
                                           sadx = abund_x, sady = abund_y)

fit_d1 <- maxLikelihood.Guilds.Conditional(init_vals = c(100, 0.1, 0.1), 
                                           model = "D1", 
                                           sadx = abund_x, sady = abund_y)

# Compare using AIC
aic_d0 <- 2 * 2 - 2 * fit_d0$fvalues
aic_d1 <- 2 * 3 - 2 * fit_d1$fvalues
```

### 3. Visualization
The package includes a specialized plotting function for Preston-style (octave-based) species abundance distributions.

```R
# Plot observed vs expected
preston_plot(abund_observed, abund_expected)
```

## Key Parameters
*   **theta ($\theta$)**: Fundamental biodiversity number.
*   **m**: Migration rate (probability that a replacement individual is an immigrant).
*   **I**: Fundamental dispersal number ($I = \frac{m(J-1)}{1-m}$).
*   **alpha ($\alpha$)**: Dispersal parameter used in guild models, related to the probability of immigration for a specific guild.

## Tips
*   **Starting Values**: Maximum likelihood optimization can be sensitive to initial values. It is recommended to try multiple starting points to ensure convergence to a global maximum.
*   **Conditioning**: Always prefer the "Conditional" functions (`.Cond` or `.Conditional`) when guild sizes are known, as they provide more reliable parameter estimates.
*   **Computational Cost**: Calculating expected SADs for guild models uses simulation; increase `n_replicates` for higher accuracy at the cost of time.

## Reference documentation
- [NEWS.md](./references/NEWS.md)
- [README.md](./references/README.md)
- [articles.md](./references/articles.md)
- [home_page.md](./references/home_page.md)
- [wiki.md](./references/wiki.md)