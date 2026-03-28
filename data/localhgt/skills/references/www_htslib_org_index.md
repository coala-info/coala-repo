Toggle navigation

[Samtools](/)

* [Home](/)
* [Download](/download)
  + [Downloads](/download)
  + [Development](/develop)
* [Workflows](/workflow)
  + [FASTQ to BAM / CRAM](/workflow/fastq.html)
  + [WGS/WES Mapping to Variant Calls](/workflow/wgs-call.html)
  + [Filtering of VCF Files](/workflow/filter.html)
  + [Using CRAM within Samtools](/workflow/cram.html)
* [Documentation](/doc)
  + [Man Pages](/doc#manual-pages)
  + [HowTos](/doc#howtos)
  + [Specifications](/doc#file-formats)
  + [Duplicate Marking](/algorithms/duplicate.html)
  + [Zlib Benchmarks](/benchmarks/zlib.html)
  + [CRAM Benchmarks](/benchmarks/CRAM.html)
  + [Reference Sequences](/doc/reference_seqs.html)
  + [Publications](/doc#publications)
* [Support](/support)
  + [HTSlib issues](https://github.com/samtools/htslib/issues)
  + [BCFtools issues](https://github.com/samtools/bcftools/issues)
  + [Samtools issues](https://github.com/samtools/samtools/issues)
  + [General help](/support#general-help)

# Samtools

Samtools is a suite of programs for interacting with high-throughput sequencing data. It consists of three separate repositories:

Samtools
:   Reading/writing/editing/indexing/viewing SAM/BAM/CRAM format

BCFtools
:   Reading/writing BCF2/VCF/gVCF files and calling/filtering/summarising SNP and short indel sequence variants

HTSlib
:   A C library for reading/writing high-throughput sequencing data

Samtools and BCFtools both use HTSlib internally, but these source packages contain their own copies of htslib so they can be built independently.

### [Download](/download)

Source code releases can be downloaded from [GitHub](https://github.com/samtools/)
or [Sourceforge](http://sourceforge.net/projects/samtools/files/samtools/):

[Source release details](/download)

### [Workflows](/workflow)

We have described some standard workflows using Samtools:

* [FASTQ to BAM / CRAM](/workflow/fastq.html)
* [WGS/WES Mapping to Variant Calls](/workflow/wgs-call.html)
* [Filtering of VCF Files](/workflow/filter.html)
* [Using CRAM within Samtools](/workflow/cram.html)

### [Documentation](/doc)

* [Manuals](/doc#manual-pages)
* [HowTos](/doc#howtos)
* [Specifications](/doc#file-formats)
* [Duplicate Marking](/algorithms/duplicate.html)
* [Zlib Benchmarks](/benchmarks/zlib.html)
* [CRAM Benchmarks](/benchmarks/CRAM.html)
* [Reference Sequences](/doc/reference_seqs.html)
* [Publications](/doc#publications)

### [Support](/support)

* [HTSlib issues](https://github.com/samtools/htslib/issues)
* [BCFtools issues](https://github.com/samtools/bcftools/issues)
* [Samtools issues](https://github.com/samtools/samtools/issues)
* [General help](/support#general-help)

---

Copyright © 2025 Genome Research Limited (reg no. 2742969) is a charity registered in England with number 1021457. [Terms and conditions](/terms).