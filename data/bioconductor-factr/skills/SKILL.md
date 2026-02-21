---
name: bioconductor-factr
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/factR.html
---

# bioconductor-factr

name: bioconductor-factr
description: Functional Annotation of Custom Transcriptomes using the factR Bioconductor package. Use this skill to process custom-assembled GTF files, construct CDS information, predict functional outputs (NMD sensitivity and protein domains), and visualize transcript structures.

## Overview
The `factR` package provides a suite of tools for the functional annotation of custom transcriptomes. It is particularly useful for researchers working with de novo assembled transcripts or long-read sequencing data who need to predict the protein-coding potential and functional consequences of novel isoforms. Key capabilities include matching custom transcripts to reference annotations, building CDS information based on reference start sites, predicting Nonsense-Mediated Decay (NMD) sensitivity, and identifying protein domains.

## Core Workflow

### 1. Data Import and Preparation
Start by importing your custom GTF and a reference GTF. Ensure chromosome naming styles (seqlevels) are consistent.

```r
library(factR)
library(BSgenome.Mmusculus.UCSC.mm10)

# Import GTF files
query_gtf <- importGTF("custom_assembly.gtf")
ref_gtf <- importGTF("reference_annotation.gtf")

# Check and match chromosome naming styles
if(!has_consistentSeqlevels(query_gtf, ref_gtf)){
  query_gtf <- matchChromosomes(query_gtf, to = ref_gtf)
}

# Match gene information (IDs and names) from reference
query_gtf <- matchGeneInfo(query_gtf, ref_gtf)
```

### 2. Constructing CDS Information
For custom transcripts, `factR` can predict the most likely CDS by searching for start codons (ATGs) found in the reference or identifying known mRNAs.

```r
# Requires a genome sequence object (BSgenome)
query_gtf_cds <- buildCDS(query_gtf, ref_gtf, Mmusculus)
```

### 3. Functional Prediction
Once CDS information is added, you can predict the functional impact of the transcripts.

**Predict NMD Sensitivity:**
Determines if a transcript is likely to undergo NMD based on the distance of the stop codon to the last exon-junction.
```r
nmd_results <- predictNMD(query_gtf_cds)
# Returns a dataframe with 'is_NMD' and distance metrics
```

**Predict Protein Domains:**
Identifies known protein domain families within the predicted CDS.
```r
domain_results <- predictDomains(query_gtf_cds, Mmusculus, plot = FALSE)
```

### 4. Filtering and Shortlisting
Identify transcripts that are truly novel compared to the reference.

```r
# Find transcripts with unique exon/intron structures
new_transcripts <- subsetNewTranscripts(query_gtf, ref_gtf, refine.by = "intron")
```

### 5. Visualization
Visualize the structure of custom transcripts compared to reference genes.

```r
# Plot all transcripts for a specific gene
viewTranscripts(query_gtf, "Ptbp1")

# Plot specific transcripts by ID
viewTranscripts(query_gtf, "transcript1", "transcript2")
```

## Utility Functions for GRangesLists
`factR` provides `dplyr`-like verbs to manipulate `GenomicRangesList` objects (e.g., exons grouped by transcript):
- `filtereach(x, ...)`: Filter elements within each list item.
- `mutateeach(x, ...)`: Add or modify metadata columns within list items.
- `sorteach(x, ...)`: Sort elements within each list item (e.g., by `exonorder`).

## Tips and Best Practices
- **Genome Matching:** Always ensure the `BSgenome` object matches the assembly version used to generate the GTF.
- **Memory Management:** For large transcriptomes, use the `...` argument in `predictNMD` or `predictDomains` to filter for specific genes of interest to save time and memory.
- **Sequence Names:** Use `importFASTA` to automatically shorten long Ensembl-style chromosome headers to simple identifiers (e.g., "1" instead of the full description string).

## Reference documentation
- [factR Reference Manual](./references/reference_manual.md)