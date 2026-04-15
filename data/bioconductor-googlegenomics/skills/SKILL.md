---
name: bioconductor-googlegenomics
description: This tool provides an R interface to the Google Genomics API for retrieving and processing genomic data using the GA4GH standard. Use when user asks to fetch genomic variants, retrieve sequence reads from Google Cloud, or convert GA4GH API data into Bioconductor objects like GRanges and GAlignments.
homepage: https://bioconductor.org/packages/3.8/bioc/html/GoogleGenomics.html
---

# bioconductor-googlegenomics

name: bioconductor-googlegenomics
description: Interface with the Google Genomics API to retrieve, process, and analyze genomic variants and sequence reads. Use this skill when you need to fetch data from Google Cloud Genomics (GA4GH API) and convert it into Bioconductor-standard objects like GRanges, VRanges, or GAlignments for downstream analysis, annotation, or visualization.

# bioconductor-googlegenomics

## Overview
The `GoogleGenomics` package provides an R interface to the Google Genomics API, which implements the Global Alliance for Genomics and Health (GA4GH) standard. It allows researchers to query large-scale genomic datasets (like 1,000 Genomes or Illumina Platinum Genomes) hosted on Google Cloud without downloading full VCF or BAM files. The package is designed to seamlessly convert API JSON responses into standard Bioconductor data structures.

## Core Workflows

### Authentication
Before querying private or specific public datasets, you must authenticate.
```R
library(GoogleGenomics)
# Use a Google API Key or OAuth2 flow
# authenticate(apiKey = "YOUR_API_KEY") 
```

### Working with Variants
Retrieve variants for specific genomic regions and convert them to Bioconductor objects. Note that the API uses 0-based coordinates, but converters typically default to 1-based R coordinates.

```R
# Fetch variants as a list
variants <- getVariants(datasetId = "...", chromosome = "22", start = 16051452, end = 16051500)

# Fetch and convert directly to VRanges (VariantAnnotation)
v_ranges <- getVariants(variantSetId = "10473108253681171589",
                        chromosome = "22",
                        start = 50300077,
                        end = 50303000,
                        converter = variantsToVRanges)

# Fetch and convert to GRanges
g_ranges <- getVariants(variantSetId = "10473108253681171589",
                        chromosome = "22",
                        start = 50300077,
                        end = 50303000,
                        converter = variantsToGRanges)
```

### Working with Reads (Alignments)
Retrieve sequence reads and convert them to `GAlignments` for coverage analysis or plotting.

```R
# Fetch reads for a specific region
reads <- getReads(readGroupSetId = "CMvnhpKTFhD3he72j4KZuyc",
                  chromosome = "chr13",
                  start = 33628130,
                  end = 33628145,
                  converter = readsToGAlignments)
```

### Annotation and Visualization
Once converted to Bioconductor objects, use standard packages like `VariantAnnotation` or `ggbio`.

```R
# Predict coding effects
library(VariantAnnotation)
library(TxDb.Hsapiens.UCSC.hg19.knownGene)
txdb <- TxDb.Hsapiens.UCSC.hg19.knownGene
coding_effects <- predictCoding(g_ranges, txdb, seqSource = Hsapiens)

# Plot coverage
library(ggbio)
autoplot(reads, aes(color = strand, fill = strand))
```

## Key Functions
- `getVariants()`: Queries the API for variant data.
- `getReads()`: Queries the API for read alignment data.
- `variantsToGRanges()` / `variantsToVRanges()`: Converters for variant data.
- `readsToGAlignments()`: Converter for read data.

## Tips and Best Practices
- **Coordinate Systems**: Always remember that the `start` and `end` parameters in `getVariants` and `getReads` are **0-based** per GA4GH spec. The Bioconductor converters automatically shift these to **1-based** for the resulting R objects.
- **Pagination**: The package handles `nextPageToken` automatically to fetch all results in a requested range.
- **Data Comparison**: Data retrieved via `GoogleGenomics` is compatible with data parsed from VCF files using `readVcf`, allowing for easy validation of cloud-based results against local files.

## Reference documentation
- [Annotating Variants](./references/AnnotatingVariants.md)
- [Plotting Alignments](./references/PlottingAlignments.md)
- [Reproducing Variant Annotation Results](./references/VariantAnnotation-comparison-test.md)