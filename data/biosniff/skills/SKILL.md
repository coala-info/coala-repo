---
name: biosniff
description: biosniff detects the underlying format and compression type of biological files by inspecting their content. Use when user asks to identify a file format, detect compression types, or distinguish between different versions of genomic annotation files.
homepage: http://github.com/cokelaer/biosniff/
metadata:
  docker_image: "quay.io/biocontainers/biosniff:1.0.0--pyh7cba7a3_0"
---

# biosniff

## Overview

`biosniff` is a specialized utility designed to "sniff" or detect the underlying format of biological files and common compression types. In bioinformatics, file extensions are often misleading or generic; this tool inspects the file content to provide an accurate identification. It supports approximately 50 different formats, ranging from sequence data (FASTA, GenBank) to genomic intervals (BED, GFF) and alignment formats (BAM, SAM, CRAM).

## Installation

The tool can be installed via Bioconda or PyPI:

```bash
# Via Conda
conda install bioconda::biosniff

# Via Pip
pip install biosniff
```

## Usage Patterns

The primary interface is a simple command-line execution followed by the path to the file(s) you wish to identify.

### Basic Identification
To identify a single file:
```bash
biosniff sequence_data.txt
```

### Batch Identification
You can pass multiple files to the sniffer to check them in sequence:
```bash
biosniff sample1.vcf sample2.fasta archive.tar.gz
```

## Supported Formats

`biosniff` recognizes a wide array of formats, including:

- **Sequence/Annotation**: fasta, fastq, genbank, embl, ena, gff2, gff3, gfa, stockholm, xmfa.
- **Alignments/Variants**: sam, bam, bai, cram, vcf, bcf, maf, paf.
- **Genomic Intervals/Scores**: bed, binary_bed, bedgraph, bigwig, bigbed, wiggle, wig.
- **Phylogeny**: newick, nexus, phylip, phyloxml.
- **Compression/Archives**: gz, bz2, zip, 7zip, rar, xz, dsrc.
- **Data/Tables**: tsv, json, yaml, xls, xlsx, ods.
- **Specialized**: abi, scf, plink, bplink, twobit, qual, clustal.

## Expert Tips

- **Pre-pipeline Validation**: Use `biosniff` in shell scripts as a guard clause to ensure that input files match the expected format before launching computationally expensive tools.
- **Compression Handling**: The tool can identify the compression format itself (e.g., identifying a file as `gz` or `bz2`), which is useful for determining which decompression utility to use programmatically.
- **Version Distinction**: It is particularly useful for distinguishing between GFF versions (GFF2 vs GFF3), which often require different parsing logic in downstream applications.

## Reference documentation
- [biosniff - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_biosniff_overview.md)
- [cokelaer/biosniff: A Sniffer for Biological formats](./references/github_com_cokelaer_biosniff.md)