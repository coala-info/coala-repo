---
name: pysam
description: Pysam provides a Pythonic interface to the htslib C-API for reading, manipulating, and writing genomic data files in SAM, BAM, CRAM, and VCF formats. Use when user asks to perform complex genomic data processing, access individual alignment segments or variant records, generate pileups for site-specific analysis, or execute samtools and bcftools commands within Python.
homepage: https://github.com/pysam-developers/pysam
metadata:
  docker_image: "quay.io/biocontainers/pysam:0.23.3--py313hd07c5dd_2"
---

# pysam

## Overview
Pysam is a Python wrapper for the htslib C-API, providing a high-level, "Pythonic" interface to the same core libraries that power samtools and bcftools. You should use this skill when you need to perform complex genomic data processing that goes beyond simple command-line piping. It allows for fine-grained control over individual alignment segments, variant records, and reference sequences, supporting both high-performance random access via indexing and memory-efficient streaming.

## Core Functionality

### Working with Alignments (SAM/BAM/CRAM)
Use `pysam.AlignmentFile` to handle sequence alignments.
- **Reading**: Always specify the mode (`"rb"` for BAM, `"r"` for SAM, `"rc"` for CRAM).
- **Random Access**: Use `.fetch(contig, start, end)` to retrieve reads in a specific region. This requires a file index (.bai or .crai).
- **Writing**: When creating a new file, use the `template` argument to copy the header from an existing file: `pysam.AlignmentFile("out.bam", "wb", template=in_file)`.

### The Pileup Engine
For site-specific analysis (e.g., SNP calling or coverage calculation), use `.pileup()`.
- It iterates over columns (genomic positions) rather than rows (reads).
- Each iteration returns a `PileupColumn` containing `PileupRead` objects.
- **Tip**: To ignore deletions or reference skips in your analysis, check `if not pileupread.is_del and not pileupread.is_refskip`.

### Variant Processing (VCF/BCF)
Use `pysam.VariantFile` for variant data.
- It automatically handles the conversion between VCF (text) and BCF (binary).
- Access sample-specific information via `record.samples['SampleName']['GT']`.
- Use `header.new_record()` to create new variant entries programmatically.

### Integrated Samtools & Bcftools
Pysam exposes command-line tools as Python functions:
- `pysam.samtools.sort("-o", "output.bam", "input.bam")`
- `pysam.bcftools.view("-O", "z", "-o", "out.vcf.gz", "in.vcf")`
- **Note**: Standard output is captured by default. Use `catch_stdout=False` if you are redirecting to a file via arguments.

## Expert Tips & Best Practices

### Coordinate Systems
- **Pysam API**: Uses **0-based, half-open** coordinates (standard Python slicing).
- **Region Strings**: Strings like `"chr1:100-200"` passed to `fetch()` or `pileup()` are **1-based, closed** (standard samtools convention). Pysam translates these automatically.

### Performance & Memory
- **Closing Files**: Always use context managers (`with pysam.AlignmentFile(...) as f:`) to ensure file handles and C-structures are properly closed.
- **Multiple Iterators**: By default, a file object supports only one active iterator. If you need to nested-loop over the same file, use `multiple_iterators=True` in the `.fetch()` call.
- **Unindexed Files**: To iterate over a file without an index, use `.fetch(until_eof=True)`.

### In-place Editing Quirks
- If you modify `AlignedSegment.query_sequence`, the `query_qualities` are automatically invalidated/deleted because htslib manages them as a single block. Always store qualities in a temporary variable if you need to re-assign them after a sequence change.

### Thread Safety
- Pysam releases the Global Interpreter Lock (GIL) for I/O intensive tasks, but the underlying htslib objects are generally not thread-safe. Avoid sharing a single `AlignmentFile` or `VariantFile` object across multiple threads.

## Reference documentation
- [Working with BAM/CRAM/SAM-formatted files](./references/pysam_readthedocs_io_en_latest_usage.html.md)
- [Pysam API Reference](./references/pysam_readthedocs_io_en_latest_api.html.md)
- [Frequently Asked Questions](./references/pysam_readthedocs_io_en_latest_faq.html.md)