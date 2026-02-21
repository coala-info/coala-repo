---
name: pysam
description: pysam is a lightweight Python wrapper around the HTSlib C-API, providing a native interface to the same core functionality that powers samtools, bcftools, and tabix.
homepage: https://github.com/pysam-developers/pysam
---

# pysam

## Overview
pysam is a lightweight Python wrapper around the HTSlib C-API, providing a native interface to the same core functionality that powers samtools, bcftools, and tabix. It allows for efficient, low-level manipulation of high-throughput sequencing data. Use this skill to perform tasks such as extracting specific genomic regions, calculating coverage via pileups, filtering variants, or converting between alignment formats.

## Core Usage Patterns

### Working with Alignments (SAM/BAM/CRAM)
Use `AlignmentFile` for reading and writing alignment data.

*   **Reading and Iterating**: Always use a context manager to handle file closures.
    ```python
    import pysam
    with pysam.AlignmentFile("input.bam", "rb") as samfile:
        for read in samfile.fetch("chr1", 100, 200):
            print(read.query_name, read.reference_start)
    ```
*   **Coordinate Systems**: Remember that pysam uses **0-based coordinates** for genomic positions, following Python conventions, whereas the SAM format and IGV typically use 1-based coordinates.
*   **Writing Files**: Provide a header from an existing file when creating a new one.
    ```python
    with pysam.AlignmentFile("input.bam", "rb") as infile:
        with pysam.AlignmentFile("output.bam", "wb", template=infile) as outfile:
            for read in infile:
                if not read.is_unmapped:
                    outfile.write(read)
    ```

### Variant Manipulation (VCF/BCF)
Use `VariantFile` for processing VCF or BCF files.

*   **Accessing Records**:
    ```python
    with pysam.VariantFile("input.vcf.gz") as vcf:
        for record in vcf.fetch("chr1", 1000, 2000):
            print(record.id, record.alleles)
            for sample in record.samples:
                print(record.samples[sample]['GT'])
    ```

### Fastx Processing (FASTA/FASTQ)
Use `FastaFile` for random access to reference sequences or `FastxFile` for streaming reads.

*   **Reference Fetching**:
    ```python
    fasta = pysam.FastaFile("ref.fasta")
    seq = fasta.fetch("chr1", 0, 100)
    ```

## Expert Tips and Best Practices

*   **Indexing Requirement**: Methods like `.fetch()` require the input file to be indexed (e.g., `.bai` for BAM, `.tbi` or `.csi` for VCF). If no index is available, use `until_eof=True` to iterate through the entire file.
*   **Performance**: For high-performance loops, access attributes directly (e.g., `read.pos`) rather than calling methods. If processing millions of reads, consider using `pysam.AlignmentFile.fetch(multiple_iterators=True)` if you need to maintain multiple independent iterators on the same file.
*   **Memory Management**: When working with large pileups, be aware that `pileup()` generates an iterator of `PileupColumn` objects, each containing `PileupRead` objects. This can be memory-intensive; use the `truncate=True` and `stepper='samtools'` arguments to limit the scope.
*   **Tag Handling**: Use `get_tag()` and `set_tag()` for auxiliary data. Note that `set_tag` requires the specific type code (e.g., 'i' for integer, 'Z' for string) if it cannot be automatically inferred.
*   **Error Handling**: Wrap pysam operations in `try...except` blocks catching `ValueError` (common for header/index issues) or `IOError`.

## Common CLI-Equivalent Tasks
While pysam is a library, it can execute samtools/bcftools commands directly via the `pysam.samtools` and `pysam.bcftools` modules:

```python
# Equivalent to: samtools index input.bam
pysam.samtools.index("input.bam")

# Equivalent to: samtools sort -o sorted.bam input.bam
pysam.samtools.sort("-o", "sorted.bam", "input.bam")
```

## Reference documentation
- [pysam Overview](./references/anaconda_org_channels_bioconda_packages_pysam_overview.md)
- [pysam GitHub Repository](./references/github_com_pysam-developers_pysam.md)