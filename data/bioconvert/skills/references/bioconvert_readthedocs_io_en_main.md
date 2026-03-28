bioconvert
![Logo](_static/logo.png)

* [1. Installation](installation.html)
* [2. User Guide](user_guide.html)
* [3. Tutorial](tutorial.html)
* [4. Developer guide](developer_guide.html)
* [5. Benchmarking](benchmarking.html)
* [6. Gallery](auto_examples/index.html)
* [7. References](references.html)
* [8. Formats](formats.html)
* [9. Glossary](glossary.html)
* [10. Faqs](faqs.html)
* [11. Bibliography](bibliography.html)

bioconvert

* Bioconvert
* [View page source](_sources/index.rst.txt)

---

1.1.1, Mar 09, 2026

# Bioconvert[](#bioconvert "Link to this heading")

**Bioconvert** is a collaborative project to facilitate the interconversion of life science data from one format to another.

[![https://badge.fury.io/py/bioconvert.svg](https://badge.fury.io/py/bioconvert.svg)](https://pypi.python.org/pypi/bioconvert)
[![https://github.com/bioconvert/bioconvert/actions/workflows/main.yml/badge.svg?branch=main](https://github.com/bioconvert/bioconvert/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/bioconvert/bioconvert/actions/workflows/main.yml)
[![https://coveralls.io/repos/github/bioconvert/bioconvert/badge.svg?branch=main](https://coveralls.io/repos/github/bioconvert/bioconvert/badge.svg?branch=main)](https://coveralls.io/github/bioconvert/bioconvert?branch=main)
[![Documentation Status](http://readthedocs.org/projects/bioconvert/badge/?version=main)](http://bioconvert.readthedocs.org/en/main/?badge=main)
[![https://img.shields.io/github/issues/bioconvert/bioconvert.svg](https://img.shields.io/github/issues/bioconvert/bioconvert.svg)](https://github.com/bioconvert/bioconvert/issues)
[![https://anaconda.org/bioconda/bioconvert/badges/platforms.svg](https://anaconda.org/bioconda/bioconvert/badges/platforms.svg)](https://anaconda.org/bioconda/bioconvert/badges/platforms.svg)
[![https://anaconda.org/bioconda/bioconvert/badges/version.svg](https://anaconda.org/bioconda/bioconvert/badges/version.svg)](https://anaconda.org/bioconda/bioconvert)
[![https://anaconda.org/bioconda/bioconvert/badges/downloads.svg](https://anaconda.org/bioconda/bioconvert/badges/downloads.svg)](https://github.com/bioconvert/bioconvert/releases)
[![https://zenodo.org/badge/106598809.svg](https://zenodo.org/badge/106598809.svg)](https://zenodo.org/badge/latestdoi/106598809)
[![https://static.pepy.tech/personalized-badge/bioconvert?period=month&units=international_system&left_color=black&right_color=blue&left_text=Downloads/months](https://static.pepy.tech/personalized-badge/bioconvert?period=month&units=international_system&left_color=black&right_color=blue&left_text=Downloads/months)](https://pepy.tech/project/bioconvert)
[![https://raw.githubusercontent.com/bioconvert/bioconvert/main/doc/_static/logo_300x200.png](https://raw.githubusercontent.com/bioconvert/bioconvert/main/doc/_static/logo_300x200.png)](https://raw.githubusercontent.com/bioconvert/bioconvert/main/doc/_static/logo_300x200.png)

contributions:
:   Want to add a convertor ? Please join <https://github.com/bioconvert/bioconvert/issues/1>

How to cite:
:   Caro et al, BioConvert: a comprehensive format converter for life sciences (2023) NAR Genomics and Bioinformatics (5),3. <https://doi.org/10.1093/nargab/lqad074>

On line website:
:   <https://bioconvert.pasteur.cloud/>

# Overview[](#overview "Link to this heading")

Life science uses many different formats. They may be old, or with complex syntax and converting those formats may be a challenge. Bioconvert aims at providing a common tool / interface to convert life science data formats from one to another.

Many conversion tools already exist but they may be dispersed, focused on few specific formats, difficult to install, or not optimised. With Bioconvert, we plan to cover a wide spectrum of format conversions; we will re-use existing tools when possible and provide facilities to compare different conversion tools or methods via benchmarking. New implementations are provided when considered better than existing ones.

In Jan 2023, we had 50 formats, 100 direct conversions available.

[![https://raw.githubusercontent.com/bioconvert/bioconvert/main/doc/conversion.png](https://raw.githubusercontent.com/bioconvert/bioconvert/main/doc/conversion.png)](https://raw.githubusercontent.com/bioconvert/bioconvert/main/doc/conversion.png)

# Installation[](#installation "Link to this heading")

**BioConvert** is developped in Python. Please use conda or any Python environment manager to install **BioConvert** using the **pip** command:

```
pip install bioconvert
```

50% of the conversions should work out of the box. However, many conversions require external tools. This is why we
recommend to use a **conda** environment. In particular, most external tools are available on the **bioconda** channel.
For instance if you want to convert a SAM file to a BAM file you would need to install **samtools** as follow:

```
conda install -c bioconda samtools
```

Since **bioconvert** is available on [bioconda](https://bioconda.github.io) on solution that installs **BioConvert** and all its dependencies is to use conda/mamba:

```
conda create --name bioconvert mamba
conda activate bioconvert
mamba install bioconvert
bioconvert --help
```

See the Installation section for more details and alternative solutions (docker, singularity).

# Quick Start[](#quick-start "Link to this heading")

There are many conversions available. Type:

```
bioconvert --help
```

to get a list of valid method of conversions. Taking the example of a conversion from a FastQ file into
a FastA file, you could do the conversion as follows:

```
bioconvert fastq2fasta input.fastq output.fasta
bioconvert fastq2fasta input.fq    output.fasta
bioconvert fastq2fasta input.fq.gz output.fasta.gz
bioconvert fastq2fasta input.fq.gz output.fasta.bz2
```

When there is no ambiguity, you can be implicit:

```
bioconvert input.fastq output.fasta
```

The default method of conversion is used but you may use another one. Checkout the available methods with:

```
bioconvert fastq2fasta --show-methods
```

For more help about a conversion, just type:

```
bioconvert fastq2fasta --help
```

and more generally:

```
bioconvert --help
```

You may also call **BioConvert** from a Python shell:

```
# import a converter
from bioconvert.fastq2fasta import FASTQ2FASTA

# Instanciate with infile/outfile names
convert = FASTQ2FASTA(infile, outfile)

# the conversion itself:
convert()
```

# Available Converters[](#available-converters "Link to this heading")

Conversion table[](#id74 "Link to this table")

| Converters | CI testing | Default method |
| --- | --- | --- |
| [abi2fasta](https://bioconvert.readthedocs.io/en/main/ref_converters.html#module-bioconvert.abi2fasta) | [![https://github.com/bioconvert/bioconvert/actions/workflows/abi2fasta.yml/badge.svg](https://github.com/bioconvert/bioconvert/actions/workflows/abi2fasta.yml/badge.svg)](https://github.com/bioconvert/bioconvert/actions/workflows/abi2fasta.yml) | [BIOPYTHON](https://bioconvert.readthedocs.io/en/main/bibliography.html) |
| [abi2fastq](https://bioconvert.readthedocs.io/en/main/ref_converters.html#module-bioconvert.abi2fastq) | [![https://github.com/bioconvert/bioconvert/actions/workflows/abi2fastq.yml/badge.svg](https://github.com/bioconvert/bioconvert/actions/workflows/abi2fastq.yml/badge.svg)](https://github.com/bioconvert/bioconvert/actions/workflows/abi2fastq.yml) | [BIOPYTHON](https://bioconvert.readthedocs.io/en/main/bibliography.html) |
| [abi2qual](https://bioconvert.readthedocs.io/en/main/ref_converters.html#module-bioconvert.abi2qual) | [![https://github.com/bioconvert/bioconvert/actions/workflows/abi2qual.yml/badge.svg](https://github.com/bioconvert/bioconvert/actions/workflows/abi2qual.yml/badge.svg)](https://github.com/bioconvert/bioconvert/actions/workflows/abi2qual.yml) | [BIOPYTHON](https://bioconvert.readthedocs.io/en/main/bibliography.html) |
| [bam2bedgraph](https://bioconvert.readthedocs.io/en/main/ref_converters.html#module-bioconvert.bam2bedgraph) | [![https://github.com/bioconvert/bioconvert/actions/workflows/bam2bedgraph.yml/badge.svg](https://github.com/bioconvert/bioconvert/actions/workflows/bam2bedgraph.yml/badge.svg)](https://github.com/bioconvert/bioconvert/actions/workflows/bam2bedgraph.yml) | [BEDTOOLS](https://bioconvert.readthedocs.io/en/main/bibliography.html) |
| [bam2bigwig](https://bioconvert.readthedocs.io/en/main/ref_converters.html#module-bioconvert.bam2bigwig) | [![https://github.com/bioconvert/bioconvert/actions/workflows/bam2bigwig.yml/badge.svg](https://github.com/bioconvert/bioconvert/actions/workflows/bam2bigwig.yml/badge.svg)](https://github.com/bioconvert/bioconvert/actions/workflows/bam2bigwig.yml) | [DEEPTOOLS](https://bioconvert.readthedocs.io/en/main/bibliography.html) |
| [bam2cov](https://bioconvert.readthedocs.io/en/main/ref_converters.html#module-bioconvert.bam2cov) | [![https://github.com/bioconvert/bioconvert/actions/workflows/bam2cov.yml/badge.svg](https://github.com/bioconvert/bioconvert/actions/workflows/bam2cov.yml/badge.svg)](https://github.com/bioconvert/bioconvert/actions/workflows/bam2cov.yml) | [BEDTOOLS](https://bioconvert.readthedocs.io/en/main/bibliography.html) |
| [bam2cram](https://bioconvert.readthedocs.io/en/main/ref_converters.html#module-bioconvert.bam2cram) | [![https://github.com/bioconvert/bioconvert/actions/workflows/bam2cram.yml/badge.svg](https://github.com/bioconvert/bioconvert/actions/workflows/bam2cram.yml/badge.svg)](https://github.com/bioconvert/bioconvert/actions/workflows/bam2cram.yml) | [SAMTOOLS](https://bioconvert.readthedocs.io/en/main/bibliography.html) |
| [bam2fasta](https://bioconvert.readthedocs.io/en/main/ref_converters.html#module-bioconvert.bam2fasta) | [![https://github.com/bioconvert/bioconvert/actions/workflows/bam2fasta.yml/badge.svg](https://github.com/bioconvert/bioconvert/actions/workflows/bam2fasta.yml/badge.svg)](https://github.com/bioconvert/bioconvert/actions/workflows/bam2fasta.yml) | [SAMTOOLS](https://bioconvert.readthedocs.io/en/main/bibliography.html) |
| [bam2fastq](https://bioconvert.readthedocs.io/en/main/ref_converters.html#module-bioconvert.bam2fastq) | [![https://github.com/bioconvert/bioconvert/actions/workflows/bam2fastq.yml/badge.svg](https://github.com/bioconvert/bioconvert/actions/workflows/bam2fastq.yml/badge.svg)](https://github.com/bioconvert/bioconvert/actions/workflows/bam2fastq.yml) | [SAMTOOLS](https://bioconvert.readthedocs.io/en/main/bibliography.html) |
| [bam2json](https://bioconvert.readthedocs.io/en/main/ref_converters.html#module-bioconvert.bam2json) | [![https://github.com/bioconvert/bioconvert/actions/workflows/bam2json.yml/badge.svg](https://github.com/bioconvert/bioconvert/actions/workflows/bam2json.yml/badge.svg)](https://github.com/bioconvert/bioconvert/actions/workflows/bam2json.yml) | [BAMTOOLS](https://bioconvert.readthedocs.io/en/main/bibliography.html) |
| [bam2sam](https://bioconvert.readthedocs.io/en/main/ref_converters.html#module-bioconvert.bam2sam) | [![https://github.com/bioconvert/bioconvert/actions/workflows/bam2sam.yml/badge.svg](https://github.com/bioconvert/bioconvert/actions/workflows/bam2sam.yml/badge.svg)](https://github.com/bioconvert/bioconvert/actions/workflows/bam2sam.yml) | [SAMBAMBA](https://bioconvert.readthedocs.io/en/main/bibliography.html) |
| [bam2tsv](https://bioconvert.readthedocs.io/en/main/ref_converters.html#module-bioconvert.bam2tsv) | [![https://github.com/bioconvert/bioconvert/actions/workflows/bam2tsv.yml/badge.svg](https://github.com/bioconvert/bioconvert/actions/workflows/bam2tsv.yml/badge.svg)](https://github.com/bioconvert/bioconvert/actions/workflows/bam2tsv.yml) | [SAMTOOLS](https://bioconvert.readthedocs.io/en/main/bibliography.html) |
| [bam2wiggle](https://bioconvert.readthedocs.io/en/main/ref_converters.html#module-bioconvert.bam2wiggle) | [![https://github.com/bioconvert/bioconvert/actions/workflows/bam2wiggle.yml/badge.svg](https://github.com/bioconvert/bioconvert/actions/workflows/bam2wiggle.yml/badge.svg)](https://github.com/bioconvert/bioconvert/actions/workflows/bam2wiggle.yml) | [WIGGLETOOLS](https://bioconvert.readthedocs.io/en/main/bibliography.html) |
| [bcf2vcf](https://bioconvert.readthedocs.io/en/main/ref_converters.html#module-bioconvert.bcf2vcf) | [![https://github.com/bioconvert/bioconvert/actions/workflows/bcf2vcf.yml/badge.svg](https://github.com/bioconvert/bioconvert/actions/workflows/bcf2vcf.yml/badge.svg)](https://github.com/bioconvert/bioconvert/actions/workflows/bcf2vcf.yml) | [BCFTOOLS](https://bioconvert.readthedocs.io/en/main/bibliography.html) |
| [bcf2wiggle](https://bioconvert.readthedocs.io/en/main/ref_converters.html#module-bioconvert.bcf2wiggle) | [![https://github.com/bioconvert/bioconvert/actions/workflows/bcf2wiggle.yml/badge.svg](https://github.com/bioconvert/bioconvert/actions/workflows/bcf2wiggle.yml/badge.svg)](https://github.com/bioconvert/bioconvert/actions/workflows/bcf2wiggle.yml) | [WIGGLETOOLS](https://bioconvert.readthedocs.io/en/main/bibliography.html) |
| [bed2wiggle](https://bioconvert.readthedocs.io/en/main/ref_converters.html#module-bioconvert.bed2wiggle) | [![https://github.com/bioconvert/bioconvert/actions/workflows/bed2wiggle.yml/badge.svg](https://github.com/bioconvert/bioconvert/actions/workflows/bed2wiggle.yml/badge.svg)](https://github.com/bioconvert/bioconvert/actions/workflows/bed2wiggle.yml) | [WIGGLETOOLS](https://bioconvert.readthedocs.io/en/main/bibliography.html) |
| [bedgraph2bigwig](https://bioconvert.readthedocs.io/en/main/ref_converters.html#module-bioconvert.bedgraph2bigwig) | [![https://github.com/bioconvert/bioconvert/actions/workflows/bedgraph2bigwig.yml/badge.svg](https://github.com/bioconvert/bioconvert/actions/workflows/bedgraph2bigwig.yml/badge.svg)](https://github.com/bioconvert/bioconvert/actions/workflows/bedgraph2bigwig.yml) | [UCSC](https://bioconvert.readthedocs.io/en/main/bibliography.html) |
| [bedgraph2cov](https://bioconvert.readthedocs.io/en/main/ref_converters.html#module-bioconvert.bedgraph2cov) | [![https://github.com/bioconvert/bioconvert/actions/workflows/bedgraph2cov.yml/badge.svg](https://github.com/bioconvert/bioconvert/actions/workflows/bedgraph2cov.yml/badge.svg)](https://github.com/bioconvert/bioconvert/actions/workflows/bedgraph2cov.yml) | [BIOCONVERT](https://bioconvert.readthedocs.io/en/main/bibliography.html) |
| [bedgraph2wiggle](https://bioconvert.readthedocs.io/en/main/ref_converters.html#module-bioconvert.bedgraph2wiggle) | [![https://github.com/bioconvert/bioconvert/actions/workflows/bedgraph2wiggle.yml/badge.svg](https://github.com/bioconvert/bioconvert/actions/workflows/bedgraph2wiggle.yml/badge.svg)](https://github.com/bioconvert/bioconvert/actions/workflows/bedgraph2wiggle.yml) | [WIGGLETOOLS](https://bioconvert.readthedocs.io/en/main/bibliography.html) |
| [bigbed2bed](https://bioconvert.readthedocs.io/en/main/ref_converters.html#module-bioconvert.bigbed2bed) | [![https://github.com/bioconvert/bio