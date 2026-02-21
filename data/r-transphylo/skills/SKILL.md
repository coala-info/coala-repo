---
name: r-transphylo
description: R package transphylo (documentation from project home).
homepage: https://cran.r-project.org/web/packages/transphylo/index.html
---

# r-transphylo

## Overview
`transphylo` is an R package designed for genomic epidemiology. It uses a Bayesian approach to color the branches of a dated phylogeny, where each color represents a distinct host. This allows for the inference of transmission events (color changes), including the identification of missing links (unsampled hosts).

## Installation
Install the package from CRAN or GitHub:
```R
install.packages("TransPhylo")
# Or for the development version:
# devtools::install_github('xavierdidelot/TransPhylo')
library(TransPhylo)
```

## Core Workflow: Inference from Phylogeny
The primary use case is inferring a transmission tree from a dated phylogenetic tree (e.g., from BEAST).

1.  **Prepare the Tree**: Convert an `ape` phylo object to a `ptree` object.
    ```R
    # dateLastSample is the absolute time (e.g., 2023.5) of the most recent leaf
    ptree <- ptreeFromPhylo(phy, dateLastSample = 2023.96)
    ```
2.  **Define Parameters**: Set Gamma distribution parameters for the generation time (`w`) and sampling time (`ws`).
    ```R
    w.shape <- 10
    w.scale <- 0.1
    dateT <- 2024 # Time when observation stopped
    ```
3.  **Run MCMC**: Infer the transmission tree.
    ```R
    res <- inferTTree(ptree, mcmcIterations = 10000, w.shape = w.shape, w.scale = w.scale, dateT = dateT)
    ```
4.  **Analyze Results**:
    *   **Convergence**: `plot(res)` and check ESS using `coda::effectiveSize(convertToCoda(res))`.
    *   **Medoid Tree**: Find the most representative tree: `med <- medTTree(res)`.
    *   **Transmission Matrix**: Probability of direct transmission: `mat <- computeMatWIW(res)`.

## Simulation of Outbreaks
Useful for power calculations or testing:
```R
simu <- simulateOutbreak(neg = 100/365, pi = 0.25, off.r = 5, w.shape = 10, w.scale = 0.1, dateStartOutbreak = 2020, dateT = 2023)
plot(simu) # Visualizes phylogeny colored by host
ttree <- extractTTree(simu)
ptree <- extractPTree(simu)
```

## Simultaneous Inference (Multiple Trees)
If you have multiple clusters or a posterior sample of trees (e.g., from BEAST), use `infer_multittree_share_param` to share epidemiological parameters across trees:
```R
# ptrees is a list of ptree objects
record_multi <- infer_multittree_share_param(ptrees, w.shape, w.scale, ws.shape, ws.scale, 
                                             mcmcIterations = 5000, 
                                             share = c("neg", "off.r", "off.p", "pi"))
```

## Key Parameters
*   `neg`: Product of effective within-host population size and generation time ($N_e \times g$).
*   `pi`: Sampling density (proportion of cases sampled).
*   `off.r`: Basic reproduction number ($R_0$).
*   `w.shape` / `w.scale`: Generation time distribution.
*   `ws.shape` / `ws.scale`: Sampling time distribution (time from infection to observation).

## Reference documentation
- [Introducing the R package TransPhylo](./references/TransPhylo.html.md)
- [TransPhylo Home Page](./references/home_page.md)
- [Inference of transmission tree from a dated phylogeny](./references/infer.html.md)
- [Simultaneous Inference of Multiple Transmission Trees](./references/multitree.html.md)
- [Simulation of outbreak data](./references/simulate.html.md)