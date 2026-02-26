---
name: bioconductor-inspect
description: This tool infers RNA synthesis, processing, and degradation rates from transcriptomic data using ordinary differential equations. Use when user asks to analyze RNA dynamics in time-course or steady-state experiments, model RNA life-cycle kinetics from RNA-seq or 4sU-seq data, or quantify intronic and exonic expressions to estimate kinetic rates.
homepage: https://bioconductor.org/packages/release/bioc/html/INSPEcT.html
---


# bioconductor-inspect

name: bioconductor-inspect
description: Inference of RNA synthesis, processing, and degradation rates from transcriptomic data (RNA-seq). Use when analyzing RNA dynamics in time-course or steady-state experiments, with or without nascent RNA (4sU-seq) data. Supports quantification from BAM files, read counts, or transcript abundances.

## Overview

INSPEcT (INference of Synthesis, Processing and dEgradation rates from Transcriptomic data) is a Bioconductor package that uses systems of ordinary differential equations (ODEs) to model RNA life-cycle kinetics. It distinguishes between premature RNA (intronic signal) and mature RNA (exonic signal) to estimate three key rates:
1. **Synthesis ($k_1$)**: Production of premature RNA.
2. **Processing ($k_2$)**: Conversion of premature to mature RNA.
3. **Degradation ($k_3$)**: Decay of mature RNA.

The package supports two main modes: **INSPEcT+** (includes nascent RNA/4sU-seq) and **INSPEcT-** (total RNA-seq only).

## Typical Workflow

### 1. Data Quantification
Quantify exonic and intronic expressions from various sources.

```r
library(INSPEcT)

# From BAM files (requires a TxDb object)
# experimentalDesign: numeric vector of time points or conditions
exprs <- quantifyExpressionsFromBAMs(txdb=txdb, 
                                     BAMfiles=bamfiles, 
                                     experimentalDesign=c(0,0,1,1))

# From Read Counts
nasExp <- quantifyExpressionsFromTrCounts(allcounts=nascentCounts,
                                          libsize=nascentLS,
                                          exonsWidths=exWdths,
                                          intronsWidths=intWdths,
                                          experimentalDesign=expDes)
```

### 2. Creating an INSPEcT Object
Initialize the analysis based on the presence or absence of nascent RNA.

```r
# INSPEcT+ (with Nascent RNA)
# tL is the labeling time (e.g., 1/6 for 10 mins)
nascentObj <- newINSPEcT(tpts=tpts, 
                         labeling_time=tL, 
                         nascentExpressions=nasExp, 
                         matureExpressions=matExp)

# INSPEcT- (Total RNA only)
matureObj <- newINSPEcT(tpts=tpts, 
                        matureExpressions=matExp)
```

### 3. Modeling Rates
Refine "first guess" rates by fitting functional forms (sigmoid or impulse) to minimize noise.

```r
# Fit models to the first 100 genes
obj_modeled <- modelRates(nascentObj[1:100], seed=1)

# For oscillatory data or non-standard forms, use Non-Functional modeling
obj_nf <- modelRatesNF(nascentObj[1:100])
```

### 4. Evaluating Results
Extract rates, p-values, and visualize gene dynamics.

```r
# Get p-values for rate variability
pvals <- ratePvals(obj_modeled)

# Get the regulatory class (e.g., "s" for synthesis, "sd" for synthesis+degradation)
classes <- geneClass(obj_modeled)

# Visualize a specific gene
plotGene(obj_modeled, ix="GeneName")

# Heatmap of all modeled rates
inHeatmap(obj_modeled, type='model')
```

### 5. Steady-State Analysis
Compare two steady states to identify differential regulation.

```r
# Compare two conditions
diffrates <- compareSteady(nasSteadyObj[, c("cond1", "cond2")])

# View differential synthesis rates
head(synthesis(diffrates))

# MA plot of results
plotMA(diffrates, rate='synthesis')
```

## Wrap-up Pipelines
For a streamlined analysis, use the high-level wrapper functions:
- `inspectFromBAM()`: From BAM files to final object.
- `inspectFromPCR()`: From quantified abundances to final object.

## Tips for Success
- **Labeling Time**: For labeling times > 30 mins, set `degDuringPulse=TRUE` in `newINSPEcT` to account for nascent RNA degradation during the pulse.
- **Filtering**: Use `chisqmodel(obj)` to identify and discard genes with poor model fits (e.g., p-value > 0.05).
- **GUI**: Use `runINSPEcTGUI()` to launch an interactive Shiny application for exploring gene dynamics and manual parameter tuning.

## Reference documentation
- [INSPEcT - INference of Synthesis, Processing and dEgradation rates from Transcriptomic data](./references/INSPEcT.md)
- [INSPEcT-GUI](./references/INSPEcT_GUI.md)