---
name: bioconductor-splicewiz
description: "SpliceWiz is an R package for analyzing alternative splicing and intron retention in large-scale RNA-seq datasets. Use when user asks to build splicing references, align reads using STAR, process BAM files for splicing counts, or create NxtSE objects for differential splicing analysis."
homepage: https://bioconductor.org/packages/release/bioc/html/SpliceWiz.html
---


# bioconductor-splicewiz

name: bioconductor-splicewiz
description: Expert guidance for using the SpliceWiz R package for alternative splicing analysis, including reference generation, STAR alignment wrappers, BAM processing, and NxtSE object creation. Use this skill when performing transcriptomics workflows involving intron retention (IR) and differential splicing analysis in R.

# bioconductor-splicewiz

## Overview
SpliceWiz is a comprehensive R package for the analysis of alternative splicing, with a particular focus on Intron Retention (IR). It provides a streamlined workflow from raw FASTQ files to differential splicing analysis, utilizing OpenMP-accelerated BAM processing. It is the successor to NxtIRF and is designed to handle large-scale RNA-seq datasets efficiently.

## Reference Generation
Before processing samples, a SpliceWiz reference must be built from a genome FASTA and a gene annotation GTF.

```r
library(SpliceWiz)

# Define reference directory
ref_path <- "./Reference"

# Build reference for human hg38 (uses default mappability/non-polyA exclusions)
buildRef(
    reference_path = ref_path,
    fasta = "genome.fa", 
    gtf = "transcripts.gtf",
    genome_type = "hg38"
)

# For non-human/mouse species, set genome_type = ""
# Use ontologySpecies for Gene Ontology support
buildRef(
    reference_path = ref_path,
    fasta = "genome.fa", 
    gtf = "transcripts.gtf",
    genome_type = "",
    ontologySpecies = "Arabidopsis thaliana"
)
```

## Alignment and BAM Processing
SpliceWiz provides wrappers for the STAR aligner (Linux/MacOS only) and functions to process BAM files into SpliceWiz-compatible formats.

### STAR Alignment
```r
# Check STAR availability
STAR_version()

# Align multiple samples
fastq_files <- findFASTQ(sample_path = "./raw_data", paired = TRUE)
STAR_alignExperiment(
    Experiment = fastq_files,
    STAR_ref_path = file.path(ref_path, "STAR"),
    BAM_output_path = "./bams",
    n_threads = 8
)
```

### Processing BAMs
`processBAM` extracts splicing and IR counts. It is highly memory-efficient due to OpenMP multi-threading.

```r
bams <- findBAMS("./bams", level = 1)

processBAM(
    bamfiles = bams$path,
    sample_names = bams$sample,
    reference_path = ref_path,
    output_path = "./pb_output",
    n_threads = 4,
    useOpenMP = TRUE
)
```

## Experiment Collation
Once BAMs are processed, collate the data into a `NxtSE` object (which inherits from `SummarizedExperiment`).

```r
# Find processBAM outputs
expr <- findSpliceWizOutput("./pb_output")

# Collate data
collateData(
    Experiment = expr,
    reference_path = ref_path,
    output_path = "./NxtSE_output"
)

# Load the NxtSE object
se <- makeSE("./NxtSE_output")
```

## Downstream Analysis Tips
- **NxtSE Object**: Access counts using `assay(se, "counts")`. Splicing-specific assays include `Included`, `Excluded`, and `MaxOver-approximation`.
- **Coverage**: Use `BAM2COV()` to generate COV files for visualization without running the full pipeline.
- **BigWig Export**: Convert COV files to BigWig for IGV using `rtracklayer::export(getCoverage(cov_file), "output.bw")`.
- **Novel Splicing**: Enable novel junction detection by setting `novelSplicing = TRUE` in `collateData()`.

## Reference documentation
- [SpliceWiz: the cookbook](./references/SW_Cookbook.md)
- [SpliceWiz: Quick-Start](./references/SW_QuickStart.md)