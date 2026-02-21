---
name: sift4g
description: SIFT 4G (SIFT For Genomes) is an optimized, high-speed version of the SIFT algorithm designed for large-scale genomic annotation.
homepage: http://sift.bii.a-star.edu.sg/sift4g/
---

# sift4g

## Overview
SIFT 4G (SIFT For Genomes) is an optimized, high-speed version of the SIFT algorithm designed for large-scale genomic annotation. It determines if an amino acid change is likely to affect protein function based on sequence homology and the physical properties of amino acids. This skill provides the necessary patterns to run predictions against pre-computed SIFT databases or to generate custom databases for non-standard organisms.

## Common CLI Patterns

### Basic Variant Annotation
To annotate a VCF file using a pre-existing SIFT 4G database:
```bash
sift4g -v <input.vcf> -d <path_to_sift_database> -o <output_directory>
```

### Database Requirements
SIFT 4G requires a specific database directory for the organism being studied. 
- Ensure the database version matches your genome assembly (e.g., GRCh37 vs GRCh38 for Human).
- The tool expects the database to contain pre-computed scores for all possible substitutions in the proteome.

### Interpreting Results
The primary output is a SIFT score ranging from 0 to 1:
- **Deleterious**: Score ≤ 0.05
- **Tolerated**: Score > 0.05
- **Low Confidence**: Results marked with a "*" indicate high false-positive error rates due to closely related sequences in the alignment.

## Expert Tips
- **Performance**: SIFT 4G is significantly faster than the original SIFT; however, performance is I/O bound. Running from an SSD or high-speed local storage is recommended when processing whole-genome VCFs.
- **Organism Support**: If a pre-computed database is not available for your specific organism, you must first use the SIFT 4G database creation tool (often a separate utility or script) to generate the required `.sift` files from a FASTA protein database and NCBI BLAST+.
- **Memory Management**: For very large VCF files, consider splitting the VCF by chromosome to parallelize the annotation process across multiple CPU cores.

## Reference documentation
- [SIFT4G - SIFT For Genomes](./references/sift_bii_a-star_edu_sg_sift4g.md)
- [sift4g - bioconda](./references/anaconda_org_channels_bioconda_packages_sift4g_overview.md)