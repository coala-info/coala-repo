---
name: r-pinfsc50
description: The r-pinfsc50 package provides a subset of genomic data from Phytophthora infestans to serve as an example dataset for bioinformatics R packages. Use when user asks to access sample VCF, FASTA, or GFF files for demonstration purposes or to test workflows with the vcfR package.
homepage: https://cloud.r-project.org/web/packages/pinfsc50/index.html
---

# r-pinfsc50

## Overview
The `pinfsc50` package provides a subset of genomic data from the plant pathogen *Phytophthora infestans*. It is specifically designed to serve as a lightweight, reliable example dataset for bioinformatics R packages (such as `vcfR`). The data focuses on "supercontig_1.50" and includes 17 samples of *P. infestans* and 1 sample of *P. mirabilis*.

## Installation
To install the package from CRAN:
```r
install.packages("pinfsc50")
```

## Usage
The package does not contain complex functions; instead, it provides paths to raw genomic files stored within the package installation directory. You use `system.file()` to locate these files for use with other analysis packages.

### Locating Data Files
Use the following commands to retrieve the full file paths for the included datasets:

```r
library(pinfsc50)

# Get path to the VCF file (Variants)
vcf_path <- system.file("extdata", "pinf_sc50.vcf.gz", package = "pinfsc50")

# Get path to the FASTA file (Sequence)
dna_path <- system.file("extdata", "pinf_sc50.fasta", package = "pinfsc50")

# Get path to the GFF file (Annotations)
gff_path <- system.file("extdata", "pinf_sc50.gff", package = "pinfsc50")
```

### Common Workflow: Integration with vcfR
This package is most commonly used to demonstrate the functionality of the `vcfR` package:

```r
# Example: Loading the data into vcfR
if (require(vcfR)) {
  vcf <- read.vcfR(vcf_path)
  dna <- ape::read.dna(dna_path, format = "fasta")
  gff <- read.table(gff_path, sep="\t", quote="")
  
  # Create a chromR object for visualization/analysis
  chrom <- create.chromR(name='Supercontig_1.50', vcf=vcf, seq=dna, ann=gff)
  plot(chrom)
}
```

## Tips
- **File Compression**: The VCF file is gzipped (`.vcf.gz`). Most modern R bioinformatics loaders (like `vcfR` or `WhamR`) handle this automatically.
- **Data Scope**: Remember this is only a small portion of the genome (supercontig 1.50). It is intended for demonstration, not for biological inference about the species as a whole.
- **Quick Help**: Use `?pinfsc50` to see the package documentation and a list of available data files.

## Reference documentation
- [README](./references/README.html.md)
- [Home Page](./references/home_page.md)