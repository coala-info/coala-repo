---
name: bioconductor-illumina450probevariants.db
description: This package provides genetic variant data from the 1000 Genomes Project mapped to Illumina HumanMethylation450 Bead Chip probes to identify potential confounding variations. Use when user asks to identify probes affected by SNPs or indels, filter methylation data by population-specific minor allele frequency, or flag variants within probe sequences.
homepage: https://bioconductor.org/packages/release/data/experiment/html/Illumina450ProbeVariants.db.html
---


# bioconductor-illumina450probevariants.db

name: bioconductor-illumina450probevariants.db
description: Access and analyze genetic variant data (SNPs, INDELs, SVs) from the 1000 Genomes Project specifically mapped to Illumina HumanMethylation450 (450k) Bead Chip probes. Use this skill to identify probes potentially affected by underlying genetic variation across different populations (Asian, American, African, and European) which may confound DNA methylation measurements.

# bioconductor-illumina450probevariants.db

## Overview

The `Illumina450ProbeVariants.db` package is an annotation data package for R. It provides a comprehensive mapping of known genetic variants from the 1000 Genomes Project to the specific genomic coordinates of the Illumina HumanMethylation450 Bead Chip probes. 

Researchers use this package to "filter" or "flag" methylation data. Because a SNP or indel at a probe's target site or within the probe sequence can interfere with hybridization or the single-base extension, it can lead to false-positive differential methylation signals. This package allows for population-specific filtering based on Minor Allele Frequency (MAF).

## Loading the Data

The package primarily contains a single large data frame named `probe.450K.VCs.af`.

```r
# Load the library
library(Illumina450ProbeVariants.db)

# Load the dataset into the workspace
data(probe.450K.VCs.af)

# View the structure
str(probe.450K.VCs.af)
```

## Key Data Structure

The `probe.450K.VCs.af` data frame contains 485,512 observations (one for each 450k probe) and 30 variables. Key columns include:

- **Probe Metadata**: `STRAND`, `INFINIUM_DESIGN_TYPE`, `CHR`, `MAPINFO`.
- **Proximity Counts**: `probe10VC.[POP]` and `probe50VC.[POP]` indicate the number of variants within 10bp or 50bp of the target CG for a specific population (ASN, AMR, AFR, EUR).
- **Allele Frequencies**: `[pop].af.F` and `[pop].af.R` provide the minor allele frequency (0-1) for variants occurring exactly at the probed CG dinucleotide on the Forward or Reverse strand.
- **Global Variants**: `diVC.com1pop.F/R` identifies the type of variant (SNP, INDEL, SV) occurring at the CG site in at least one population.

## Typical Workflows

### 1. Filtering Probes by Population-Specific MAF
If your study population is European, you should filter out probes where a variant exists at the CG site with a MAF > 0.01.

```r
# Identify probes with a variant at the CG site in Europeans (MAF > 1%)
mask_eur <- probe.450K.VCs.af$eur.af.F > 0.01 | probe.450K.VCs.af$eur.af.R > 0.01

# Get the names of probes to exclude
probes_to_exclude <- rownames(probe.450K.VCs.af)[mask_eur]
```

### 2. Identifying Probes with Variants in the Probe Body
Variants within the 50bp probe sequence can affect binding affinity.

```r
# Find probes with at least one variant (MAF > 1%) within 10bp of the target site in any population
probes_near_variant <- rownames(probe.450K.VCs.af)[probe.450K.VCs.af$probe10VC.com1pop > 0]
```

### 3. General Quality Control
To be most conservative, many researchers remove any probe that has a variant at the CG site in *any* of the four 1000 Genomes populations.

```r
# Identify probes with any SNP/INDEL/SV at the CG site in any population
mask_any <- !is.na(probe.450K.VCs.af$diVC.com1pop.F) | !is.na(probe.450K.VCs.af$diVC.com1pop.R)
bad_probes <- rownames(probe.450K.VCs.af)[mask_any]
```

## Tips for Interpretation

- **MAF Thresholds**: A common threshold is 0.01 (1%), but for smaller studies or specific populations, you may wish to be more or less stringent.
- **Type I vs Type II**: The package includes `INFINIUM_DESIGN_TYPE`. Remember that Type I probes use two different probes for the same CpG, while Type II uses a single probe; variants may affect these designs differently.
- **Strand Specificity**: Pay attention to `asn.af.F` vs `asn.af.R`. The variant might only be present on the strand being interrogated by the specific Infinium chemistry for that probe.

## Reference documentation

- [Reference Manual](./references/reference_manual.md)