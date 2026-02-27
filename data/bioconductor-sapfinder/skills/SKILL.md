---
name: bioconductor-sapfinder
description: This tool automates the discovery of single amino acid polymorphisms and variant peptides by integrating genomic variation data with MS/MS proteomics data. Use when user asks to construct variation-associated databases from VCF files, perform MS/MS database searching, post-process identification results, or generate HTML reports for proteogenomics analysis.
homepage: https://bioconductor.org/packages/3.8/bioc/html/sapFinder.html
---


# bioconductor-sapfinder

name: bioconductor-sapfinder
description: Automate the discovery of Single Amino Acid Polymorphisms (SAPs) and variant peptides from MS/MS proteomics data. Use this skill when needing to construct variation-associated databases from VCF files (sample-specific or public like dbSNP/COSMIC), perform database searching using X!Tandem, post-process identification results, and generate HTML reports for proteogenomics analysis.

## Overview
The `sapFinder` package is a proteogenomics tool designed to identify variant peptides by integrating genomic variation data with tandem mass spectrometry (MS/MS) data. It streamlines the workflow from raw variant calls (VCF) to annotated spectra and interactive reports, allowing researchers to validate genomic mutations at the protein level.

## Core Workflow

### 1. Database Construction
The `dbCreator` function builds a FASTA database containing both wild-type and mutated peptide sequences.

```r
library(sapFinder)

# Required inputs
vcf <- "path/to/variants.vcf"
annotation <- "path/to/ucsc_annotation.txt" # e.g., refGene or ensGene
refseq <- "path/to/mrna_sequences.fa"

# Optional: Cross-reference file from BioMart
xref <- "path/to/BioMart_Xref.txt"

db.files <- dbCreator(
  vcf = vcf, 
  annotation = annotation, 
  refseq = refseq, 
  outdir = "db_output", 
  prefix = "my_project",
  xref = xref
)
# Returns a vector: [1] FASTA database path, [2] Variant information file path
```

### 2. MS/MS Database Searching
`sapFinder` uses the `rTANDEM` package (X!Tandem algorithm) to search spectra against the generated database.

```r
protein.db <- db.files[1]
mgf.path <- "path/to/spectra.mgf"

xml.path <- runTandem(
  spectra = mgf.path, 
  fasta = protein.db, 
  outdir = "search_results",
  tol = 10, tolu = "ppm",      # Parent ion tolerance
  itol = 0.1, itolu = "Daltons" # Fragment ion tolerance
)
```

### 3. Post-processing
The `parserGear` function parses search engine results (X!Tandem XML or Mascot .dat), calculates q-values, and applies protein grouping (Occam's razor).

```r
parserGear(
  file = xml.path, 
  db = protein.db, 
  outdir = "parser_results", 
  prefix = "my_project"
)
```

### 4. Report Generation
Create an interactive HTML report to visualize identified variant peptides and their associated spectra.

```r
reportCreator(
  indir = "parser_results", 
  db = protein.db, 
  varInfor = db.files[2], 
  prefix = "my_project"
)
# Open 'index.html' in the output directory to view results.
```

## Integrated Execution
For a streamlined analysis, use `easyRun` to perform all stages in a single function call.

```r
easyRun(
  vcf = vcf, 
  annotation = annotation, 
  refseq = refseq, 
  spectra = mgf.path,
  xref = xref,
  outdir = "integrated_results",
  prefix = "easy_run_test",
  tol = 10, tolu = "ppm",
  itol = 0.1, itolu = "Daltons",
  cpu = 0 # Uses all available cores
)
```

## Data Preparation Tips
- **Annotation Files**: Download `refGene` or `ensGene` tables and corresponding mRNA FASTA files from the UCSC Table Browser. Ensure the assembly (e.g., hg19, hg38) matches your VCF file.
- **VCF Sources**: You can use sample-specific VCFs from GATK/SAMtools or public VCFs from dbSNP and COSMIC.
- **Mascot Support**: While `runTandem` is the default search wrapper, `parserGear` can process existing Mascot `.dat` files if the search was performed against the `sapFinder` generated database.

## Reference documentation
- [sapFinder User Guide](./references/sapFinder.md)