---
name: bioconductor-genelendatabase
description: This package provides mRNA transcript lengths for various genomes and gene identifier formats sourced from the UCSC table browser. Use when user asks to retrieve gene or transcript length data, normalize RNA-seq data for selection bias, or map gene identifiers to sequence lengths for functional enrichment analysis.
homepage: https://bioconductor.org/packages/release/data/experiment/html/geneLenDataBase.html
---


# bioconductor-genelendatabase

name: bioconductor-genelendatabase
description: Access and retrieve mRNA transcript lengths for various genomes and gene ID formats. Use this skill when you need to obtain gene or transcript length data for normalization in RNA-seq analysis (like GOseq), or when you need to map transcripts to lengths using UCSC-based data for specific organisms.

## Overview
The `geneLenDataBase` package is a data-experiment package providing lengths of mRNA transcripts for a wide range of genomes and gene identifier formats (e.g., Ensembl, Entrez, RefSeq). The data is primarily sourced from the UCSC table browser. It is designed to be used in conjunction with packages like `goseq` to account for selection bias in functional enrichment analysis.

## Loading Data
The package provides pre-computed data objects. You can load specific length data using the `data()` function. The naming convention for these objects is `[genome].[id_type].LENGTH`.

```R
library(geneLenDataBase)

# Load Ensembl gene lengths for Anolis carolinensis (anoCar1)
data(anoCar1.ensGene.LENGTH)

# View the first few rows
head(anoCar1.ensGene.LENGTH)
```

## Supported Genomes and IDs
To find out which organisms and identifier types are available, use the built-in helper functions:

```R
# List all supported genomes (e.g., hg19, mm9, danRer6)
supportedGenomes()

# List all supported gene identifier formats (e.g., ensGene, refGene, knownGene)
supportedGeneIDs()
```

## Downloading New Data
If a specific combination of genome and ID is not pre-loaded but is supported by UCSC, you can attempt to fetch it directly:

```R
# Attempt to download transcript lengths for a specific genome and ID type
# Returns a data.frame with columns: gene name, transcript ID, and length
new_data <- downloadLengthFromUCSC(genome = "hg19", id = "ensGene")
```

## Typical Workflow
1. **Identify Genome/ID**: Determine the genome build (e.g., "mm9") and the gene ID type (e.g., "geneSymbol") used in your experiment.
2. **Check Availability**: Run `supportedGenomes()` and `supportedGeneIDs()` to ensure the combination exists.
3. **Load Data**: Use `data(genome.id.LENGTH)` to bring the mapping into the environment.
4. **Process**: The resulting object is a `data.frame`. Use it to map your experimental gene list to their respective mRNA lengths.

## Tips
- **Gene vs. Transcript**: The data objects typically map transcripts to lengths. If you need a single length per gene, you may need to aggregate (e.g., taking the median or maximum transcript length per gene).
- **NA Gene IDs**: For some UCSC tables, a transcript might not have an associated Gene ID. In these cases, the gene name column will be `NA`, but the transcript ID will remain populated.
- **Factors**: If the data contains factors that interfere with merging, use the internal `unfactor()` utility if needed, though standard R methods are preferred.

## Reference documentation
- [geneLenDataBase Reference Manual](./references/reference_manual.md)