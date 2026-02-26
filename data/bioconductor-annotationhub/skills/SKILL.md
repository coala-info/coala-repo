---
name: bioconductor-annotationhub
description: This tool provides a client interface to discover and retrieve a vast collection of genomic resources from Bioconductor's AnnotationHub web service. Use when user asks to retrieve genomic annotations, search for OrgDb objects, download Ensembl GTF or FASTA files, or obtain chain files for liftOver.
homepage: https://bioconductor.org/packages/release/bioc/html/AnnotationHub.html
---


# bioconductor-annotationhub

name: bioconductor-annotationhub
description: Access and manage large collections of publicly available whole genome resources from Bioconductor's AnnotationHub. Use this skill when you need to retrieve genomic annotations, including OrgDb objects for non-model organisms, Roadmap Epigenomics data, Ensembl GTF and FASTA files, UCSC chain files for liftOver, and dbSNP variants.

# bioconductor-annotationhub

## Overview

AnnotationHub is a Bioconductor package that provides a client interface to a web service containing a vast collection of genomic resources. It allows users to discover and retrieve data as standard Bioconductor objects (e.g., GRanges, OrgDb, TxDb, BigWigFile) without manually downloading and formatting files. It features a local caching system to speed up repeated access.

## Core Workflow

### 1. Initialize the Hub
Create an AnnotationHub object to connect to the service.
```r
library(AnnotationHub)
ah <- AnnotationHub()
```

### 2. Search for Resources
Use the `query()` function to search for data using keywords. The search is case-insensitive and looks across all metadata columns (species, dataprovider, rdataclass, etc.).
```r
# Search for OrgDb objects for a specific species
orgs <- query(ah, c("OrgDb", "Mus musculus"))

# Search for Ensembl GTF files for a specific release
gtf_files <- query(ah, c("Ensembl", "gtf", "release-104"))

# Search for liftOver chain files
chains <- query(ah, c("hg19", "hg38", "chainfile"))
```

### 3. Inspect Metadata
Explore the results of a query using standard R operations.
```r
# View summary
orgs

# View specific metadata columns
unique(orgs$species)
unique(orgs$dataprovider)

# Get all metadata as a DataFrame
metadata_df <- mcols(orgs)
```

### 4. Retrieve Data
Use the double-bracket operator `[[` with the unique "AH" identifier to download and load the resource into your R session.
```r
# Retrieve by ID
my_data <- ah[["AH12345"]]
```

## Common Use Cases

### Non-Model Organism Annotations
Retrieve `OrgDb` objects for organisms that do not have a dedicated Bioconductor annotation package.
```r
ah <- AnnotationHub()
orgdb <- query(ah, c("OrgDb", "Arabidopsis thaliana"))[[1]]
# Use with AnnotationDbi
library(AnnotationDbi)
keytypes(orgdb)
select(orgdb, keys=head(keys(orgdb)), columns=c("SYMBOL", "GENENAME"))
```

### Genomic Features and Sequences
Retrieve Ensembl GTF files for gene models and 2bit files for genomic sequences.
```r
# Get GTF
gtf <- query(ah, c("Takifugu", "GTF", "release-94"))[[1]]
# Get DNA sequence
dna <- query(ah, c("Takifugu", "2bit"))[[1]]

# Create a TxDb from the retrieved GRanges
library(txdbmaker)
txdb <- makeTxDbFromGRanges(gtf)
```

### Genome Build LiftOver
Retrieve chain files to map coordinates between different genome assemblies.
```r
chain <- query(ah, c("hg19", "To", "hg38", "chainfile"))[[1]]
library(rtracklayer)
# Assuming 'my_granges' is in hg19
gr38 <- liftOver(my_granges, chain)
```

## Tips and Troubleshooting

### Managing the Cache
AnnotationHub stores files locally. If you encounter "Corrupt Cache" errors, you may need to use the `BiocFileCache` package to inspect or remove entries.
```r
# Check where the cache is located
getAnnotationHubOption("CACHE")
```

### Snapshot Dates
To ensure reproducibility, you can set the hub to a specific snapshot date.
```r
pd <- possibleDates(ah)
snapshotDate(ah) <- pd[length(pd)] # Set to a specific date
```

### Proxy Settings
If working behind a firewall, set the proxy option.
```r
AnnotationHub::setAnnotationHubOption("PROXY", "http://user:pass@myproxy:8080")
```

### Cluster Environments
On a cluster, it is often better to download a resource once and save it as a local file (e.g., `.sqlite` for TxDb) that can be loaded by other nodes using `loadDb()`, rather than having every node attempt to access the hub cache simultaneously.

## Reference documentation
- [AnnotationHub How-To's](./references/AnnotationHub-HOWTO.md)
- [AnnotationHub: Access the AnnotationHub Web Service](./references/AnnotationHub.md)
- [Troubleshoot The Hubs](./references/TroubleshootingTheHubs.md)