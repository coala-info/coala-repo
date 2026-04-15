---
name: bioconductor-cnorfeeder
description: CNORfeeder integrates literature-based prior knowledge networks with data-driven inference to identify missing signaling links from experimental data. Use when user asks to extend signaling networks with data-driven links, prioritize integrated interactions using protein-protein interaction networks, or prepare models for training with CellNOptR.
homepage: https://bioconductor.org/packages/release/bioc/html/CNORfeeder.html
---

# bioconductor-cnorfeeder

name: bioconductor-cnorfeeder
description: Integrate literature-constrained prior knowledge networks (PKN) with data-driven inference (DDN) using CNORfeeder. Use this skill to extend signaling networks with links derived from perturbation data, prioritize integrated links using protein-protein interaction (PPI) networks, and train logic-based or ODE-based models using CellNOptR.

## Overview

CNORfeeder is an R package designed to bridge the gap between incomplete literature-based signaling networks and experimental data. It "feeds" the CellNOptR (CNOR) pipeline by inferring missing links directly from data using various reverse-engineering methods (FEED, ARACNe, CLR, Bayesian networks) and integrating them into a Prior Knowledge Network (PKN). It also supports "Dynamic Feeder" workflows for logic-based Ordinary Differential Equations (ODEs) using time-series data.

## Typical Workflow

### 1. Data Preparation
Load the required libraries and data (typically formatted as a `CNOlist`).

```R
library(CellNOptR)
library(CNORfeeder)

# Load example data
data(CNOlistDREAM, package="CellNOptR")
data(DreamModel, package="CellNOptR")
```

### 2. Data-Driven Network (DDN) Inference
Infer a network strictly from data. The native `FEED` method is specifically designed for perturbation experiments.

```R
# Infer Boolean tables using FEED method
# k: threshold of significance; measErr: measurement error
BTable <- makeBTables(CNOlist=CNOlistDREAM, k=2, measErr=c(0.1, 0))

# Alternative: Rank links by significance
Lrank <- linksRanking(CNOlist=CNOlistDREAM, measErr=c(0.1, 0))
```

Other inference methods available:
- `MIinference()`: Uses `minet` for ARACNE or CLR.
- `Binference()`: Uses `catnet` for Bayesian networks.

### 3. Integration with PKN
Map the inferred links (DDN) onto the compressed Prior Knowledge Network.

```R
# Preprocess PKN (compression)
model <- preprocessing(data=CNOlistDREAM, model=DreamModel)

# Integrate DDN into the model
modelIntegr <- mapBTables2model(BTable=BTable, model=model, allInter=TRUE)

# Visualize integrated links (highlighted in purple)
plotModel(model=modelIntegr, CNOlist=CNOlistDREAM, indexIntegr=modelIntegr$indexIntegr)
```

### 4. Weighting and Prioritization
Assign weights to integrated links. You can use a global factor or prioritize based on Protein-Protein Interaction (PPI) networks (shorter paths in PPI = higher reliability).

```R
# Weighting with a global factor (integrFac=10 prioritizes PKN over DDN)
modelIntegrWeight <- weighting(modelIntegr=modelIntegr, 
                               PKNmodel=DreamModel, 
                               CNOlist=CNOlistDREAM, 
                               integrFac=10)

# Optional: Weighting using PPI (requires Uniprot IDs)
data(PPINigraph, package="CNORfeeder")
data(UniprotIDdream, package="CNORfeeder")
modelIntegrWeight <- weighting(modelIntegr=modelIntegr, 
                               PKNmodel=DreamModel, 
                               CNOlist=CNOlistDREAM, 
                               integrFac=10,
                               UniprotID=UniprotIDdream, 
                               PPI=PPINigraph)
```

### 5. Model Training
Train the integrated network using a weighted genetic algorithm.

```R
# Optimization using weighted binary GA
DreamT1opt <- gaBinaryT1W(CNOlist=CNOlistDREAM, 
                          model=modelIntegrWeight, 
                          maxGens=10, popSize=10)

# Plot results
cutAndPlotResultsT1(model=modelIntegrWeight, 
                    CNOlist=CNOlistDREAM, 
                    bString=DreamT1opt$bString)
```

## Dynamic Feeder Workflow (ODE-based)

For time-series data and ODE models, use the Dynamic Feeder pipeline:

1.  **Identify Misfits**: Find measurements where the initial ODE model fails to fit the data.
    ```R
    indices <- identifyMisfitIndices(cnolist=cnolist, model=model, simData=simData, mseThresh=0.05)
    ```
2.  **Build Feeder Object**: Search for missing links in databases (e.g., OmniPath) or via FEED.
    ```R
    feederObject <- buildFeederObjectDynamic(model=model, cnolist=cnolist, indices=indices, database=database, DDN=TRUE)
    ```
3.  **Integrate and Fit**:
    ```R
    integratedModel <- integrateLinks(feederObject=feederObject, cnolist=cnolist, database=database)
    # Run final optimization with runDynamicFeeder()
    ```

## Reference documentation

- [Integrating literature-constrained and data-driven inference of signalling networks with CNORfeeder](./references/CNORfeeder-vignette.md)