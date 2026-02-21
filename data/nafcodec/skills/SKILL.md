---
name: nafcodec
description: `nafcodec` provides Python and Rust interfaces for the Nucleotide Archive Format (NAF), a specialized format for compressed DNA and protein sequences.
homepage: https://github.com/althonos/nafcodec
---

# nafcodec

## Overview
`nafcodec` provides Python and Rust interfaces for the Nucleotide Archive Format (NAF), a specialized format for compressed DNA and protein sequences. It combines 4-bit encoding with Zstandard compression to achieve high ratios while maintaining fast access. This skill focuses on using the Python interface to efficiently decode genomic records, manage memory through streaming, and configure decoders for specific performance needs.

## Installation
Install the package via Bioconda or PyPI:

```bash
conda install bioconda::nafcodec
# OR
pip install nafcodec
```

## Python Usage Patterns

### Basic Decoding
The most straightforward way to iterate over a NAF archive is using the high-level `open` function.

```python
import nafcodec

with nafcodec.open("sequences.naf") as decoder:
    for record in decoder:
        # record contains id, sequence, quality, and comment
        print(f">{record.id}")
        print(record.sequence)
```

### Performance Optimization: Selective Decoding
If specific fields like quality scores or comments are not required for your analysis, you can disable them during decompression to increase speed and reduce memory overhead.

```python
import nafcodec

# Use DecoderBuilder to configure the decoder
decoder = (
    nafcodec.DecoderBuilder()
    .quality(False)   # Do not decode quality strings
    .comments(False)  # Do not decode comments
    .with_path("large_dataset.naf")
)

for record in decoder:
    # record.quality and record.comment will be None
    process(record.sequence)
```

### Streaming and Memory Management
`nafcodec` implements a streaming decoder. It accesses specific regions of the compressed file rather than decoding full blocks into memory. This allows for processing files that are significantly larger than available RAM.

## Expert Tips
- **Field Availability**: All fields in a `Record` are optional. Their presence depends on how the original data was compressed. Always verify if `record.quality` or `record.comment` is `None` before processing if you are not using a `DecoderBuilder` to explicitly include/exclude them.
- **Encoder Flexibility**: The encoder supports an abstract storage interface, allowing you to keep sequences in memory or offload them to temporary folders during the compression process.
- **Rust Integration**: If building high-performance standalone bioinformatics tools, the underlying Rust crate provides a `nom`-based parser for zero-copy decoding.

## Reference documentation
- [GitHub Repository](./references/github_com_althonos_nafcodec.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_nafcodec_overview.md)