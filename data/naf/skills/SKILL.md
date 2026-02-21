---
name: naf
description: The Nucleotide Archival Format (NAF) is a specialized binary format designed for the efficient storage of biological sequences.
homepage: https://github.com/KirillKryukov/naf
---

# naf

## Overview
The Nucleotide Archival Format (NAF) is a specialized binary format designed for the efficient storage of biological sequences. Built on the Zstandard (zstd) compression algorithm, it provides a superior alternative to standard gzip for genomic data by offering higher compression ratios and significantly faster decompression. This skill enables the use of the `ennaf` (encoder) and `unnaf` (decoder) command-line tools to manage sequence archives, handle multi-file datasets, and integrate NAF into bioinformatics pipelines via Unix pipes.

## Installation
The recommended method for installing NAF is via Bioconda:
```bash
conda install bioconda::naf
```

## Core CLI Usage

### Compression (ennaf)
To compress a FASTA or FASTQ file into NAF format:
```bash
ennaf input.fa -o output.naf
```

**Expert Tips for ennaf:**
- **Compression Level**: Use `-1` to `-22` to adjust the compression intensity (default is usually sufficient, but `-22` provides maximum space savings).
- **Long Distance Matching**: Use the `--long` option for very large files or datasets with long-range repetitions to improve compression ratios.
- **Text Mode**: Use `--text` if you are compressing non-sequence text data or want to treat the input as a generic stream.
- **Piping**: `ennaf` can read from stdin, allowing integration with other tools:
  ```bash
  cat sequence.fa | ennaf -o sequence.naf
  ```

### Decompression (unnaf)
To decompress a NAF file back to its original format:
```bash
unnaf input.naf -o output.fa
```

**Expert Tips for unnaf:**
- **Streaming to Tools**: Decompress directly to stdout to pipe into aligners or other analysis tools without writing large intermediate files to disk:
  ```bash
  unnaf sequence.naf | bwa mem index -
  ```
- **Sequence Selection**: Use `--sequences` to extract specific sequences if the archive supports indexed access.

## Working with Multiple Files
NAF natively handles single files. To archive multiple files (e.g., a directory of genomes), use the `mumu.pl` script (Multi-Multi-FASTA) as an intermediate step.

**Compressing a directory:**
```bash
mumu.pl --dir 'my_genomes/' '*' | ennaf --text -o genomes.nafnaf
```

**Decompressing and unpacking:**
```bash
unnaf genomes.nafnaf | mumu.pl --unpack --dir 'extracted_genomes/'
```
*Note: Use the `.nafnaf` extension for multi-file archives to distinguish them from single-file `.naf` archives.*

## Best Practices
- **Lossless Compression**: NAF is lossless for sequence data and qualities. However, ensure you check if specific non-standard headers in your FASTA/FASTQ files need to be preserved, as NAF focuses on the biological data.
- **Pipe Integration**: Always prefer piping `unnaf` output to the next tool in your pipeline rather than decompressing to disk, as NAF's primary advantage is its high-speed decompression which often exceeds disk I/O speeds.
- **Memory Management**: For extremely large files, monitor memory usage when using high compression levels (e.g., `-22`) or the `--long` window.

## Reference documentation
- [NAF GitHub Repository](./references/github_com_KirillKryukov_naf.md)
- [Bioconda NAF Package Overview](./references/anaconda_org_channels_bioconda_packages_naf_overview.md)