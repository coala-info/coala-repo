---
name: bioconvert
description: Bioconvert is a specialized tool designed to handle the complex landscape of bioinformatics file formats.
homepage: http://bioconvert.readthedocs.io/
---

# bioconvert

## Overview
Bioconvert is a specialized tool designed to handle the complex landscape of bioinformatics file formats. It acts as a wrapper and optimizer for numerous underlying conversion utilities, ensuring that data is transformed correctly while handling compression (gzip, bz2) and parallelization automatically. Use this skill to identify the correct conversion command, select specific methods (e.g., using `sambamba` instead of `samtools` for BAM to SAM), and execute high-performance data transformations.

## Command Line Usage

### Basic Conversion
The standard syntax follows a `format2format` pattern. Bioconvert can often infer the conversion if the file extensions are standard.

```bash
# Explicit conversion
bioconvert fastq2fasta input.fastq output.fasta

# Implicit conversion (based on extensions)
bioconvert input.bam output.sam
```

### Managing Methods
Many conversions support multiple underlying tools (methods). You can list and select them to optimize for speed or specific tool requirements.

```bash
# List available methods for a specific conversion
bioconvert fastq2fasta --show-methods

# Force a specific method
bioconvert bam2sam input.bam output.sam --method sambamba
```

### Handling Compression
Bioconvert handles compressed inputs and outputs transparently. It can also convert between compression formats directly.

```bash
# Convert and compress on the fly
bioconvert input.fastq output.fasta.gz

# Convert between compression formats
bioconvert input.fastq.gz output.fastq.bz2
```

### Performance Optimization
For large datasets, use the `--threads` flag to enable parallel processing where supported by the underlying method.

```bash
bioconvert fastq2fasta input.fastq output.fasta --threads 4
```

## Common Conversion Patterns

| Task | Command | Primary Method |
| :--- | :--- | :--- |
| **Alignment** | `bioconvert bam2sam` | SAMBAMBA / SAMTOOLS |
| **Sequencing** | `bioconvert fastq2fasta` | BIOCONVERT / SEQKIT |
| **Genotyping** | `bioconvert vcf2bed` | BIOCONVERT |
| **Annotation** | `bioconvert gff32gtf` | BIOCONVERT |
| **Phylogeny** | `bioconvert nexus2fasta` | BIOPYTHON |
| **Coverage** | `bioconvert bam2bigwig` | DEEPTOOLS |

## Expert Tips
- **Check Dependencies**: While `bioconvert` is the interface, many conversions require external tools (like `samtools` or `bedtools`). If a conversion fails, verify the underlying tool is installed in the environment.
- **In-place Compression**: You can use `bioconvert` simply to change compression formats (e.g., `gz2bz2`) without changing the underlying data format.
- **Python API**: For complex workflows, `bioconvert` can be imported as a Python module:
  ```python
  from bioconvert.fastq2fasta import FASTQ2FASTA
  convert = FASTQ2FASTA("input.fastq", "output.fasta")
  convert()
  ```

## Reference documentation
- [Bioconvert User Guide](./references/bioconvert_readthedocs_io_en_dev.md)