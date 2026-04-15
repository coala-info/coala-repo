---
name: repeatmasker-recon
description: RepeatMasker screens DNA sequences against libraries of transposable elements to annotate and mask genomic repeats. Use when user asks to mask a genome, identify transposable elements, or search for repeats using species-specific or custom libraries.
homepage: https://www.repeatmasker.org/RepeatMasker
metadata:
  docker_image: "biocontainers/repeatmasker-recon:v1.08-4-deb_cv1"
---

# repeatmasker-recon

## Overview
RepeatMasker is the standard tool for genomic repeat annotation. It screens DNA sequences against curated libraries of transposable elements and conserved repeats. This skill provides the procedural knowledge to execute searches using various engines (RMBlast, HMMER, Cross_Match), manage the FamDB/Dfam database partitions, and interpret the resulting alignment and summary files. It is essential for genome masking prior to gene prediction or comparative genomics.

## Configuration and Database Setup
Before running searches, ensure the environment and libraries are correctly initialized.

- **Library Installation**: RepeatMasker requires a TE database. Download FamDB H5 partitions from Dfam and place them in `Libraries/famdb/`.
- **Configuration**: Run the configuration script after any library update or initial installation:
  ```bash
  perl ./configure
  ```
- **Engine Selection**: Specify the search engine with `-e`. RMBlast (`rmblast`) is generally recommended for speed and sensitivity, while HMMER (`hmmer`) is used for profile HMM searches.

## Common CLI Patterns

### Standard Genomic Masking
Mask a genome using the default species-specific library (requires Dfam/RepBase configured):
```bash
RepeatMasker -species human -xsmall genome.fasta
```
*Note: `-xsmall` performs soft-masking (converts repeats to lowercase) instead of hard-masking (N's).*

### Using Custom Libraries
If you have a specific set of consensus sequences in FASTA format:
```bash
RepeatMasker -lib custom_repeats.fa -pa 8 input_sequence.fasta
```
*Note: `-pa` (parallel) specifies the number of processors to use.*

### High-Sensitivity Search
For divergent repeats or older TE insertions:
```bash
RepeatMasker -s -cutoff 250 -species "Drosophila melanogaster" assembly.fna
```

### Quick Screening
For a fast, less sensitive pass (useful for large assemblies):
```bash
RepeatMasker -q -species mammals genome.fasta
```

## Expert Tips and Best Practices
- **Memory Management**: For large chromosomal assemblies, RepeatMasker (via `ProcessRepeats`) streams annotations sequence-by-sequence to reduce memory footprint. Ensure your input FASTA headers are concise.
- **Species Naming**: Use quoted strings for species with spaces (e.g., `-species "rattus norvegicus"`). The tool uses the NCBI taxonomy tree via FamDB to pull ancestral repeats.
- **Handling Compressed Inputs**: Modern versions (4.2.3+) support BGZIP files and do not require manual decompression of input files.
- **Output Files**:
  - `.mask`: The masked sequence file.
  - `.out`: A table listing all repeats found.
  - `.tbl`: A summary report of the repeat content.
  - `.cat.gz`: Compressed alignment files (generated if `-a` is used).

## Reference documentation
- [RepeatMasker Home and Documentation](./references/www_repeatmasker_org_RepeatMasker.md)
- [Bioconda RepeatMasker Package Overview](./references/anaconda_org_channels_bioconda_packages_repeatmasker_overview.md)