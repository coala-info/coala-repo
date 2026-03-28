Theme:

🌗 Match OS
🌑 Dark
🌕 Light

# ABIF Parser for Nim

[[![CI status](https://github.com/quadram-institute-bioscience/nim-abif/actions/workflows/test.yaml/badge.svg)](https://github.com/quadram-institute-bioscience/nim-abif/actions)
[![Conda Version](https://img.shields.io/conda/v/bioconda/nim-abif)](https://bioconda.github.io/recipes/nim-abif/README.html)
[![Conda Platform](https://img.shields.io/conda/p/bioconda/nim-abif)](https://bioconda.github.io/recipes/nim-abif/README.html)](https://github.com/quadram-institute-bioscience/nim-abif/actions/workflows/test.yaml)

A Nim library to parse ABIF (Applied Biosystems Information Format) files from DNA sequencing machines,
commonly used in Sanger capillary sequencing.

[Library API](theindex.html) |  [Github repository](https://github.com/quadram-institute-bioscience/nim-abif?tab=readme-ov-file)

## Features

* Parse `.ab1` and `.fsa` trace files
* Extract sequence data, quality values, and sample names
* Supports all standard ABIF data types
* Export to FASTA and FASTQ formats
* Correctly handles big-endian binary data

## Tools

[abi2fq](abi2fq.html)

Advanced FASTQ converter with quality trimming capabilities.

This tool allows you to:

* Convert ABIF trace files to FASTQ format
* Trim low-quality bases from sequence ends
* Configure sliding window size and quality threshold
* Output to STDOUT or to a file

#### Usage Examples:

# Basic conversion
abi2fq trace.ab1 output.fq

# With quality trimming (window size 15, quality threshold 25)
abi2fq --window=15 --quality=25 trace.ab1 output.fq

# Skip quality trimming
abi2fq --no-trim trace.ab1 output.fq

[abimerge](abimerge.html)

Merge overlapping traces using Smith-Waterman alignment.

abimerge trace\_F.ab1t race\_R.ab1

abichromatogram

Render chromatogram in SVG format

![](chromas.png)

abichromatogram file.ab1 -o image.svg -s 500 -e 1000 --width 1600

[abimetadata](abimetadata.html)

Print tags from traces

abimetadata trace\_F.ab1

## Installation

nimble install abif

To install the tool:

conda install -c bioconda nim-abif

[Library Documentation](abif.html) | © 2023 Quadram Institute Bioscience (Andrea Telatin)