---
name: bioconductor-fletcher2013b
description: This package provides tools and datasets to reproduce transcriptional network inferences and master regulator analysis of FGFR2 signaling in breast cancer. Use when user asks to perform master regulator analysis, reproduce transcriptional network inferences, generate gene expression signatures, or visualize enrichment maps for METABRIC and T-ALL datasets.
homepage: https://bioconductor.org/packages/release/data/experiment/html/Fletcher2013b.html
---


# bioconductor-fletcher2013b

name: bioconductor-fletcher2013b
description: Analysis of master regulators of FGFR2 signaling and breast cancer risk using the Fletcher2013b package. Use this skill to reproduce transcriptional network inferences, perform Master Regulator Analysis (MRA), and generate enrichment maps based on METABRIC and T-ALL datasets.

## Overview

The `Fletcher2013b` package provides pre-processed transcriptional networks and a pipeline to reproduce the bioinformatics analysis of FGFR2 signaling in breast cancer. It integrates with the `RTN` package for network inference and `RedeR` for network visualization. The package contains four primary networks derived from the METABRIC discovery set, validation set, normal breast tissue, and a T-cell acute lymphoblastic leukemia (T-ALL) control.

## Data Resources

The package includes four pre-processed `RTN` objects representing transcriptional networks:
- `rtni1st`: METABRIC discovery set (n=997)
- `rtni2nd`: METABRIC validation set (n=995)
- `rtniNormals`: METABRIC normal breast tissue (n=144)
- `rtniTALL`: T-cell ALL cancer control (n=57)

Load these datasets using:
```R
library(Fletcher2013b)
data(rtni1st)
data(rtni2nd)
data(rtniNormals)
data(rtniTALL)
```

## Master Regulator Analysis (MRA) Workflow

MRA identifies transcription factors (TFs) whose regulons are significantly enriched with a specific gene expression signature.

1. **Generate a Signature**: Retrieve differentially expressed genes (e.g., from the FGFR2 experiment).
   ```R
   # Get FGFR2 signature (Exp1) using Entrez IDs
   sigt <- Fletcher2013pipeline.deg(what="Exp1", idtype="entrez")
   ```

2. **Run MRA Pipelines**: Use the wrapper functions to test the signature against the pre-processed networks.
   ```R
   # MRA on METABRIC discovery set
   MRA1 <- Fletcher2013pipeline.mra1st(hits=sigt$E2FGF10, verbose=FALSE)

   # MRA on other datasets
   MRA2 <- Fletcher2013pipeline.mra2nd(hits=sigt$E2FGF10)
   MRA3 <- Fletcher2013pipeline.mraNormals(hits=sigt$E2FGF10)
   MRA4 <- Fletcher2013pipeline.mraTALL(hits=sigt$E2FGF10)
   ```

## Visualization

The package provides functions to visualize the results using the `RedeR` interface.

1. **Consensus Network**: Plot a graph of regulons identified in the consensus MRA.
   ```R
   Fletcher2013pipeline.consensusnet()
   ```
   *Tip: In the RedeR interface, use the 'relax' algorithm and anchor master regulators for better layout control.*

2. **Enrichment Maps**: Generate an association map showing similarity (Jaccard coefficient) between regulons.
   ```R
   Fletcher2013pipeline.enrichmap()
   ```
   *Note: This displays regulons with a Jaccard coefficient ≥ 0.4.*

## Key Functions

- `Fletcher2013pipeline.deg()`: Retrieves gene expression signatures.
- `Fletcher2013pipeline.mra1st()` / `mra2nd()` / `mraNormals()` / `mraTALL()`: Wrappers for MRA on specific cohorts.
- `Fletcher2013pipeline.consensusnet()`: Visualizes the transcriptional network of consensus master regulators.
- `Fletcher2013pipeline.enrichmap()`: Visualizes regulon similarity and enrichment.

## Reference documentation

- [Fletcher2013b](./references/Fletcher2013b.md)