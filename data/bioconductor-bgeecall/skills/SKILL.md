---
name: bioconductor-bgeecall
description: BgeeCall generates statistically grounded present or absent gene expression calls from RNA-Seq data using reference intergenic regions to define background noise. Use when user asks to generate reliable expression calls, calculate null distributions from intergenic regions, or merge calls from multiple RNA-Seq libraries.
homepage: https://bioconductor.org/packages/release/bioc/html/BgeeCall.html
---


# bioconductor-bgeecall

## Overview

`BgeeCall` is a Bioconductor package designed to generate reliable present/absent gene expression calls from RNA-Seq data. Unlike standard methods that use arbitrary thresholds (e.g., TPM > 1), `BgeeCall` uses reference intergenic regions—areas of the genome known to be non-expressed—to calculate a library-specific null distribution. This allows for a statistically grounded determination of whether a gene's expression is significantly higher than the background noise.

## Core Workflow

The standard workflow involves defining metadata for your samples, the species, and the quantification tool (kallisto), then running the automated pipeline.

### 1. Setup Metadata Objects
`BgeeCall` uses S4 classes to manage configuration:

```r
library(BgeeCall)

# 1. UserMetadata: Species and local file paths
user_bgee <- new("UserMetadata", species_id = "6239") # e.g., C. elegans
user_bgee <- setAnnotationFromObject(user_bgee, annotation_granges, "unique_annot_name")
user_bgee <- setTranscriptomeFromObject(user_bgee, transcriptome_dna_string_set, "unique_trans_name")
user_bgee <- setRNASeqLibPath(user_bgee, "path/to/fastq_directory")

# 2. KallistoMetadata: Quantification settings
# Set download_kallisto = TRUE if not installed on system
kallisto <- new("KallistoMetadata", download_kallisto = FALSE)

# 3. BgeeMetadata: Reference intergenic data version
bgee <- new("BgeeMetadata", intergenic_release = "1.0")
```

### 2. Generate Calls
The `generate_calls_workflow` function executes the full pipeline: indexing, quantification, and call generation.

```r
# Run the full workflow
calls_output <- generate_calls_workflow(
  userMetadata = user_bgee,
  abundanceMetadata = kallisto,
  bgeeMetadata = bgee
)
```

### 3. Interpreting Results
The workflow returns a list of file paths. The primary output is the `calls_tsv_path`:

```r
results <- read.table(calls_output$calls_tsv_path, header = TRUE)
# Columns include: id, abundance (TPM), counts, pValue, and 'call' (present/absent)
head(results)
```

## Advanced Usage

### Merging Multiple Libraries
To combine calls from multiple libraries (e.g., biological replicates) into a single condition call:

```r
# Requires a TSV file mapping libraries to conditions
merged <- merging_libraries(
  userFile = "metadata_mapping.tsv",
  approach = "BH", # Benjamini-Hochberg for p-values
  condition = c("species_id", "anatEntity"),
  cutoff = 0.05
)
```

### Customizing Thresholds
You can switch between different statistical approaches for defining "presence":

*   **pValue (Default):** Based on Z-score relative to intergenic TPMs.
*   **Intergenic Ratio:** Ratio of proportion of intergenic present vs protein-coding present.
*   **qValue:** Uses linear interpolation and numerical integration.

```r
# Example: Using intergenic ratio approach
kallisto_custom <- new("KallistoMetadata", cutoff_type = "intergenic", cutoff = 0.05)
```

### Working with Clusters (Slurm)
For large-scale processing, `BgeeCall` integrates with `rslurm`:

```r
# Step 1: Generate indexes on cluster
generate_slurm_indexes(userFile = "all_samples.tsv", nodes = 10)

# Step 2: Generate calls on cluster
generate_slurm_calls(userFile = "all_samples.tsv", nodes = 10)
```

## Tips and Best Practices
*   **Species Support:** Use `list_bgee_ref_intergenic_species()` to check if Bgee provides curated intergenic regions for your organism.
*   **Transcript Versions:** If you encounter errors during `tximport` (summarizing transcripts to genes), set `ignoreTxVersion = TRUE` in the `KallistoMetadata` object.
*   **Kmer Size:** `BgeeCall` automatically adjusts kallisto kmer size (31 for reads ≥ 50bp, 15 for shorter reads).
*   **Beta Feature:** To generate calls at the transcript level instead of the gene level, set `txOut = TRUE` in `KallistoMetadata`.

## Reference documentation
- [automatic RNA-Seq present/absent gene expression calls generation](./references/bgeecall-manual.md)
- [BgeeCall Manual (Rmd Source)](./references/bgeecall-manual.Rmd)