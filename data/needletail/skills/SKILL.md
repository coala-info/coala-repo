---
name: needletail
description: Needletail is a high-performance library for rapid FASTX parsing and k-mer processing in Python and Rust. Use when user asks to parse FASTA or FASTQ files, normalize sequences, generate k-mers, or calculate reverse complements.
homepage: https://github.com/onecodex/needletail
metadata:
  docker_image: "quay.io/biocontainers/needletail:0.7.1--py311hb6b3792_0"
---

# needletail

## Overview
Needletail is a specialized library designed for rapid FASTX (FASTA and FASTQ) parsing and k-mer processing. It is engineered for performance, utilizing minimal-copying techniques to achieve speeds significantly faster than standard Python implementations. This skill provides the procedural knowledge to integrate Needletail into bioinformatics scripts for efficient sequence iteration, sequence normalization, and k-mer analysis.

## Installation
Needletail can be installed via multiple package managers depending on the environment:

- **Conda**: `conda install bioconda::needletail`
- **Python/Pip**: `pip install needletail`
- **Rust/Cargo**: Add `needletail = "0.6.0"` to your `Cargo.toml`

## Python Usage Patterns

### Basic FASTX Parsing
Use `parse_fastx_file` to create an iterator over sequence records. This handles both FASTA and FASTQ formats automatically.

```python
from needletail import parse_fastx_file, NeedletailError

try:
    for record in parse_fastx_file("input.fastq"):
        header = record.id
        sequence = record.seq
        quality = record.qual  # None if FASTA
        
        if record.is_fastq():
            # Process quality scores
            pass
except NeedletailError as e:
    print(f"Parsing error: {e}")
```

### Sequence Manipulation
Needletail provides optimized functions for common sequence transformations:

- **Normalization**: Use `record.normalize(iupac=False)` to capitalize bases and remove newlines. Note that this mutates the record in place.
- **Reverse Complement**: Use `reverse_complement(seq_string)` for a standalone transformation.
- **Quality Scores**: Use `record.phred_quality_score()` to get numeric quality values from FASTQ records.

## Rust Usage Patterns

### Efficient Iteration and K-mers
In Rust, Needletail excels at low-level k-mer processing.

```rust
use needletail::{parse_fastx_file, Sequence};

let mut reader = parse_fastx_file(&filename).expect("Invalid file path");
while let Some(record) = reader.next() {
    let seqrec = record.expect("Invalid record");
    
    // Normalize sequence (removes newlines, capitalizes)
    let norm_seq = seqrec.normalize(false);
    
    // Generate canonical k-mers
    let rc = norm_seq.reverse_complement();
    for (_, kmer, _) in norm_seq.canonical_kmers(21, &rc) {
        // Process 21-mer
    }
}
```

## Expert Tips and Best Practices

1. **Memory Efficiency**: Needletail uses minimal-copying. When working in Python, avoid converting large numbers of records into a list; process them within the iterator to keep memory usage low.
2. **Error Handling**: Always wrap parsers in try/except blocks (Python) or Result handling (Rust). `NeedletailError` is the primary exception raised for malformed genomic files.
3. **IUPAC Support**: When normalizing, set `iupac=True` only if your downstream analysis specifically supports extended ambiguity codes; otherwise, stick to `False` to ensure standard ACTG output.
4. **Path Handling**: In recent versions, `parse_fastx_file` in Python accepts both strings and `pathlib.Path` objects.

## Reference documentation
- [Needletail GitHub README](./references/github_com_onecodex_needletail.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_needletail_overview.md)