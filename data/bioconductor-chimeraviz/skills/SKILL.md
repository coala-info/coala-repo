---
name: bioconductor-chimeraviz
description: the package is available on all platforms; click for details.
homepage: https://bioconductor.org/packages/release/bioc/html/chimeraviz.html
---

# bioconductor-chimeraviz

## Overview
The `chimeraviz` package is designed to visualize gene fusions. It provides a unified interface to import results from various fusion-discovery tools and generates high-quality plots ranging from genome-wide circular overviews to detailed transcript-level and protein-domain visualizations.

## Core Workflow

### 1. Importing Fusion Data
Import functions are specific to the fusion-finder tool used. All import functions return a list of `Fusion` objects.

```r
library(chimeraviz)

# Example: Import deFuse results
# Arguments: (file_path, genome_version, limit)
fusions <- import_defuse("results.tsv", "hg19")

# Other importers:
# import_ericscript(), import_fusioncatcher(), import_fusionmap(),
# import_infusion(), import_jaffa(), import_prada(), 
# import_soapfuse(), import_starfusion()
```

### 2. Managing Fusion Objects
Once imported, you can filter and inspect the fusion list.

```r
# Get a specific fusion by ID
fusion <- get_fusion_by_id(fusions, 5267)

# Filter by gene name or chromosome
rcc1_fusions <- get_fusion_by_gene_name(fusions, "RCC1")
chr1_fusions <- get_fusion_by_chromosome(fusions, "chr1")

# Inspect partner genes
upstream_gene <- upstream_partner_gene(fusion)
downstream_gene <- downstream_partner_gene(fusion)
```

### 3. Visualization Types

#### Circular Overview
Visualizes all fusions in a sample across the genome.
```r
plot_circle(fusions)
```

#### Detailed Fusion Plot
The primary visualization showing ideograms, transcripts, breakpoints, and coverage. Requires an `EnsDb` object for annotations.
```r
# Load annotation database
library(ensembldb)
edb <- EnsDb("Homo_sapiens.GRCh37.74.sqlite")

plot_fusion(
  fusion = fusion,
  bamfile = "alignment.bam", # Optional: for coverage
  edb = edb,
  non_ucsc = TRUE # Set TRUE if chromosomes are "1" instead of "chr1"
)
```

#### Transcript-Level Plots
Focuses on the impact of the fusion on specific transcripts.
```r
# Plot all transcripts for both partner genes
plot_transcripts(fusion, edb)

# Plot the putative fused transcript
plot_fusion_transcript(fusion, edb)

# Plot with protein domain annotations (requires a BED file of domains)
plot_fusion_transcript_with_protein_domain(
  fusion = fusion,
  edb = edb,
  bedfile = "domains.bed"
)
```

#### Fusion Reads Plot
Visualizes individual sequencing reads mapped specifically to the fusion junction sequence.
```r
# Requires adding alignment data to the fusion object first
fusion <- add_fusion_reads_alignment(fusion, "junction_alignment.bam")
plot_fusion_reads(fusion)
```

### 4. Reporting
Generate an interactive HTML report containing a circular plot and a searchable table of all fusions.
```r
create_fusion_report(fusions, "my_report.html")
```

## Tips and Best Practices
- **Genome Versions**: Ensure the genome version passed to the import function (e.g., "hg19", "hg38") matches the data and the annotation database.
- **Transcript Reduction**: Use `reduce_transcripts = TRUE` in plotting functions to collapse multiple isoforms into a single representative track for cleaner visuals.
- **Non-UCSC Chromosomes**: If your BAM file uses "1" instead of "chr1", always set `non_ucsc = TRUE` in plotting functions to avoid coordinate mismatches.
- **Alignment**: For `plot_fusion_reads()`, you must align reads to the fusion junction sequence (created via `write_fusion_reference()`) rather than the whole genome.

## Reference documentation
- [chimeraviz Vignette (Rmd)](./references/chimeraviz-vignette.Rmd)
- [chimeraviz Vignette (Markdown)](./references/chimeraviz-vignette.md)