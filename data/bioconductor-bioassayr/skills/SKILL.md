---
name: bioconductor-bioassayr
description: This tool analyzes and manages small molecule bioactivity data from high-throughput biological screenings. Use when user asks to store screening results in a SQL database, identify target-selective compounds, or analyze multi-target activity profiles.
homepage: https://bioconductor.org/packages/release/bioc/html/bioassayR.html
---

# bioconductor-bioassayr

name: bioconductor-bioassayr
description: Analysis of biological screening data (bioassays) using the bioassayR package. Use this skill to store, organize, and analyze small molecule bioactivity data, identify target-selective compounds, and cluster molecules by activity profiles. It supports importing PubChem BioAssay data and managing local SQL databases of screening results.

## Overview
The `bioassayR` package provides a framework for cross-target analysis of high-throughput screening (HTS) data. It uses a SQLite backend to manage large volumes of data efficiently. The workflow typically involves creating a `BioassayDB`, loading assay results (compounds, targets, and activity scores), and performing queries to identify active compounds against specific targets or to compare bioactivity fingerprints across multiple assays.

## Core Objects
- **bioassay**: Data for a single assay (metadata, targets, and scores).
- **BioassayDB**: A persistent SQL database containing multiple assays.
- **bioassaySet**: A compound-vs-assay matrix extracted from the database.
- **perTargetMatrix**: A sparse matrix of compounds vs. targets, summarizing replicates.

## Typical Workflows

### 1. Database Management
Create or connect to a bioactivity database to store your data.
```r
library(bioassayR)

# Create a new database
db_file <- tempfile()
mydb <- newBioassayDB(db_file, indexed=FALSE)

# Add data source metadata (required before loading assays)
addDataSource(mydb, description="My Lab Data", version="1.0")

# Connect to an existing database
# mydb <- connectBioassayDB("path/to/database.sqlite")

# Disconnect when finished
# disconnectBioassayDB(mydb)
```

### 2. Loading Assay Data
Assays can be created manually or parsed from PubChem files.
```r
# Manual creation
data(samplebioassay) # Example data frame with cid, activity, score
myAssay <- new("bioassay", 
               aid="101", 
               source_id="My Lab Data",
               assay_type="screening", 
               targets="GI_NUMBER", 
               target_types="protein", 
               scores=samplebioassay)

loadBioassay(mydb, myAssay)

# Parsing PubChem BioAssay files (XML and CSV)
# myAssay <- parsePubChemBioassay("AID_NUMBER", "scores.csv", "description.xml")

# Indexing (Run after loading all data to speed up queries)
addBioassayIndex(mydb)
```

### 3. Querying Bioactivity
Identify targets for a compound or compounds for a target.
```r
# Find targets active for a specific compound (CID)
active_targets <- activeTargets(mydb, cid=16749979)

# Find compounds active against a specific target (GI)
active_compounds <- activeAgainst(mydb, target="116516899")

# Find target-selective compounds
# Returns compounds active against the target but inactive elsewhere
selective <- selectiveAgainst(mydb, target="166897622", maxCompounds=10, minimumTargets=1)
```

### 4. Activity Matrices and Clustering
Compare compounds based on their multi-target activity profiles.
```r
# Extract data for specific compounds into a bioassaySet
compounds <- c("2244", "2662", "3715")
bset <- getBioassaySetByCids(mydb, compounds)

# Create a compound-vs-target matrix
# 2 = active, 1 = inactive, 0 = untested
mat <- perTargetMatrix(bset, inactives=TRUE, summarizeReplicates="mode")

# Convert to bioactivity fingerprints (requires ChemmineR)
library(ChemmineR)
fpset <- bioactivityFingerprint(bset)
sim_matrix <- fpSim(fpset[1], fpset, method="Tanimoto")
```

## Tips and Best Practices
- **GI Numbers**: Use NCBI GI numbers for protein targets to maintain compatibility with pre-built databases and identifier mapping functions.
- **ID Mapping**: Use `loadIdMapping` to store translations between GI numbers and other IDs like UniProt or Gene Symbols.
- **Memory Efficiency**: Use `perTargetMatrix` which returns a sparse `dgCMatrix` to handle large datasets without exhausting RAM.
- **Replicate Summary**: When creating matrices, use `summarizeReplicates="activesFirst"` if you want to prioritize any positive hit over inactives for the same target.

## Reference documentation
- [bioassayR Introduction and Examples](./references/bioassayR.md)