[Manual](manual.pdf)
[Publication](https://doi.org/10.1093/bioinformatics/bty283)
[View on GitHub](https://github.com/Cibiv/trumicount)

[![](https://anaconda.org/bioconda/trumicount/badges/installer/conda.svg)](https://anaconda.org/bioconda/trumicount)
[![](https://anaconda.org/bioconda/trumicount/badges/platforms.svg)](https://anaconda.org/bioconda/trumicount)
[![](https://anaconda.org/bioconda/trumicount/badges/version.svg)](https://anaconda.org/bioconda/trumicount)
[![](https://anaconda.org/bioconda/trumicount/badges/license.svg)](#license)

# TRUmiCount

## Correctly counting molecules using unique molecular identifiers

## Description

**Motivation:**
Counting molecules using *next-generation sequencing* (NGS) suffers from
PCR amplification bias, which reduces the accuracy of many quantitative
NGS-based experimental methods such as RNA-Seq. This is true even if molecules
are made distinguishable using *unique molecular identifiers* (UMIs) before
PCR amplification, and distinct UMIs are counted instead of reads: Molecules
that are lost entirely during the sequencing process will still cause
under-estimation of the molecule count, and amplification artifacts like PCR
chimeras create phantom UMIs and thus cause over-estimation.

**Results:**
TRUmiCount uses a mechanistic model of PCR amplification to correct for both
types of errors. In our [paper](https://doi.org/10.1093/bioinformatics/bty283) we demonstrate that the phantom-filtered and loss-corrected molecule counts
computed by TRUmiCount measure the true number of molecules with considerably
higher accuracy than the raw number of distinct UMIs.

## Publication

TRUmiCount is described in detail in our paper:

Florian G. Pflug, Arndt von Haeseler. (2018). TRUmiCount: Correctly counting
absolute numbers of molecules using unique molecular identifiers.
*Bioinformatics*, DOI: [10.1093/bioinformatics/bty283](https://doi.org/10.1093/bioinformatics/bty283).

If you use TRUmiCount, please cite this publication!

## Availability

### Install from [![](bioconda.png)](https://bioconda.github.io/)

If you're already using [Conda](https://bioconda.github.io), you can
install TRUmiCount from the [Bioconda](https://conda.io)
channel by doing

```
conda install -c bioconda trumicount samtools
```

TRUmiCount relies on [UMI-Tools](http://github.com/CGATOxford/UMI-tools)
to extract the UMIs associated with a gene. We provide a modified version that is
more seamlessly integrated with TRUmiCount which you can install with

```
conda install -c cibiv umi_tools_tuc
```

(You can also use the umodified UMI-Tools with TRUmiCount, but for single-cell
data in particular you might encounter some issues)

For more detailed instructions and other installation options see the
[manual](manual.pdf).

### Sourecode on ![](images/github.png)

The sourcecode of TRUmiCount is avaiable on <https://github.com/Cibiv/trumicount.git>. Our modified version of UMI-Tools is available at
<https://github.com/Cibiv/UMI-Tools/tree/tuc-patches>

## Usage Examples

### Datasets

[**kv\_1000g.bam**](kv_1000g.bam):
Mapped single-end reads for first 1000 genes from replicate 1 of the D.
melanogaster data by Kivioja *et al.* (Counting absolute numbers of
molecules using unique molecular identifiers. *Nature Methods* **9**,
72-74, 2011)

[**sh\_100g.bam**](sg_100g.bam):
Mapped reads for first 100 genes from replicate 1 of the E. coli data by
Shiroguchi *et al.* (Shiroguchi *et al.* Digital RNA sequencing
minimizes sequence-dependent bias and amplification noise with optimized
single-molecule barcodes. *PNAS* **109**, 1347-1352, 2012)

[**10xn9k\_10c.bam**](10xn9k_10c.bam):
Mapped reads from 10 single mouse brain cells extracted from the
[neuron\_9k](https://support.10xgenomics.com/single-cell-gene-expression/datasets/2.1.0/neuron_9k) single-cell RNA-seq example dataset provided by
[10x Genomics](https://www.10xgenomics.com/). The full dataset contains
about 300,000,000 reads from 9,000 individual E18 mouse brain cells.

### Running TRUmiCount

To run TRUmiCount on the example data file kv\_1000g.bam, the
firs must first be downloaded, and index with samtools by doing:

```
curl -O https://cibiv.github.io/trumicount/kv_1000g.bam
samtools index kv_1000g.bam
```

This indexed BAM-File can then be processed with trumicount to produce a
table containing bias-corrected numbers of transcript molecules for each
gene (kv\_1000g.tab)

```
trumicount --input-bam kv_1000g.bam --umi-sep ':' --molecules 2 --threshold 2 --genewise-min-umis 3 --output-counts kv_1000g.tab
```

For a brief list of command-line options of TRUmiCount see `trumicount
--help`, for an in-depth description of the possible operating modes,
input and output formats and command-line options see the [manual](manual.pdf)

## License

TRUmiCount is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option) any
later version.

TRUmiCount is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
details.

TRUmiCount maintained by the [Center for Integrative Bioinformatics Vienna](http://www.cibiv.at)

Published with [GitHub Pages](http://pages.github.com)