---
name: bioconductor-randpack
description: This tool manages clinical trial randomization and patient treatment assignments using various algorithmic methods in R. Use when user asks to design clinical experiments, define strata, implement randomization algorithms like Permuted Block or Minimization, and manage patient enrollment.
homepage: https://bioconductor.org/packages/release/bioc/html/randPack.html
---


# bioconductor-randpack

name: bioconductor-randpack
description: Clinical trial randomization and management using the randPack package. Use this skill to design clinical experiments, define strata, implement various randomization algorithms (Permuted Block, Efron Biased Coin, Wei's Urn, Minimization), and manage patient enrollment and treatment assignment in R.

## Overview

The `randPack` package provides a structured framework for implementing and analyzing clinical trials. It uses a class-based system to separate the description of a randomization method from its actual implementation (realization). This is particularly useful for re-randomization tests and maintaining trial integrity across different strata.

## Key Workflows

### 1. Define Patient IDs and Strata
Before creating an experiment, define how patients are identified within specific strata (e.g., different medical centers).

```r
library(randPack)

pIDs <- new("PatientID",
            strata = c("Center1", "Center2"),
            start = c(1000L, 2000L),
            stop = c(1150L, 2150L))
```

### 2. Configure Randomization Descriptions
Choose a randomization strategy. Common types include:

*   **Permuted Block:** `new("PermutedBlockDesc", treatments = c(A=3L, B=4L), type="PermutedBlock", numBlocks=4L)`
*   **Efron's Biased Coin:** `new("EfronBiasedCoinDesc", treatments = c(A=1L, B=1L), type="EfronBiasedCoin", numPatients=1000L, p=2/3)`
*   **Wei's Urn:** `new("UrnDesc", treatments = c(A=1L, B=1L), type="Urn", numPatients=1000L, alpha=1, beta=3)`
*   **Minimization:** `new("MinimizationDesc", treatments=c(A=1L, B=1L), method=minimizePocSim, type="Minimization", featuresInUse="sex")`

### 3. Create a Clinical Experiment
The `ClinicalExperiment` object binds treatments, factors, and randomization methods together.

```r
trts <- c(A = 1L, B = 1L)
ce <- new("ClinicalExperiment",
          name = "My Trial",
          treatments = trts,
          factors = list(F1 = c("A", "B")),
          strataFun = function(pDesc) pDesc@strata,
          randomization = list(Center1 = list(pbdesc), Center2 = list(pbdesc)),
          patientIDs = pIDs)
```

### 4. Initialize and Manage the Trial
Create the `ClinicalTrial` object and assign treatments to incoming patients.

```r
# Initialize trial with seeds for each stratum
ct <- createTrial(ce, seed = c(301, 401))

# Create patient data
pData <- new("PatientData", name="John Doe", date=Sys.Date(),
             covariates=list(sex="M", age=45), strata="Center1")

# Get treatment assignment
assignment <- getTreatment(ct, pData)

# View enrollment status
getEnrolleeInfo(ct)
```

## Tips and Best Practices
*   **Seeds:** Always provide a vector of seeds to `createTrial` corresponding to the number of strata defined in the experiment.
*   **PatientData Environment:** The `ClinicalTrial` object stores patient data in an environment slot, allowing it to be updated in-place when `getTreatment` is called.
*   **Re-randomization:** To perform inference via re-randomization, reuse the `RandomizerDesc` objects to generate new realizations of the trial.
*   **Internal Functions:** Functions starting with `.` (e.g., `randPack:::.newPBlock`) are internal helpers for generating allocation vectors but are usually wrapped by `getTreatment`.

## Reference documentation
- [randPack overview](./references/randPack.md)