[hmnfusion](index.html)

* [Install](install.html)
* Usage
  + [Steps](#steps)
  + [How to start with HmnFusion](#how-to-start-with-hmnfusion)
  + [Create BAM files](#create-bam-files)
  + [Fusion callers](#fusion-callers)
  + [Fusion frequency](#fusion-frequency)
  + [MMEJ sequences](#mmej-sequences)
* [FAQ](faq.html)
* [Code of Conduct](conduct.html)
* [Contributing](contributing.html)
* [Changelog](change.html)

[hmnfusion](index.html)

* Usage
* [View page source](_sources/usage.rst.txt)

---

# Usage[¶](#usage "Link to this heading")

HmnFusion is designed to analyze some panel of genes sequenced with the aCAP-Seq library and performs with a high sensitivity and specificity [10.1016/j.jmoldx.2022.07.004](https://www.sciencedirect.com/science/article/pii/S1525157822002185?via%3Dihub)

## Steps[¶](#steps "Link to this heading")

1. BAM files are analyzed by [Lumpy](https://github.com/arq5x/lumpy-sv) and [Genefuse](https://github.com/OpenGene/GeneFuse)
2. The results are aggregated by HmnFusion
3. Now you can calculate the fusion frequency and you can define the MMEJ sequence

These steps involved one or more commands.
A workflow is available to grouped these commands into one command.

## How to start with HmnFusion[¶](#how-to-start-with-hmnfusion "Link to this heading")

It depends what you have:

* If you have FASTQ files, you need first to create BAM files, please go to [Create BAM files](#create-bam-files)
* If you have FASTQ, BAM files, please go to [Fusion callers](#fusion-callers)
* If you have FASTQ, BAM files, HTML of JSON from Genefuse and VCF from Lumpy, please go to [Fusion frequency](#fusion-frequency) or [MMEJ sequences](#mmej-sequences)

Questions about extra files: hg19 reference, BED files ? please read the [FAQ](faq.html).

## Create BAM files[¶](#create-bam-files "Link to this heading")

It’s only available through `docker`

```
$ docker run -it \
    --rm \
    hmnfusion-align:latest \
    workflow-align \
    --input-forward-fastq <FASTQ forward, file> \
    --input-reverse-fastq <FASTQ reverse, file> \
    --output-directory <Output directory> \
    --threads 4
```

## Fusion callers[¶](#fusion-callers "Link to this heading")

It will run Genefuse, Lumpy and HmnFusion, to detect and quantify fusions.

```
$ hmnfusion workflow-fusion \
    # Sample
    --name <Name of sample> \
    --input-forward-fastq <Fastq file forward> \
    --input-reverse-fastq <Fastq file reverse> \
    --input-sample-bam <Bam file> \
    # Bed
    --input-genefuse-bed <Genefuse bed file> \
    --input-lumpy-bed <Lumpy bed file> \
    --input-hmnfusion-bed <HmnFusion bed file> \
    # Reference
    --input-reference-fasta <Reference fasta file (hg19)> \
    # Output
    --output-hmnfusion-vcf <Vcf file output> \
    --output-genefuse-html <Genefuse html file output> \
    --output-lumpy-vcf <Lumpy vcf file output> \
    --threads [1-6]
```

## Fusion frequency[¶](#fusion-frequency "Link to this heading")

It will extract fusions from Genefuse and Lumpy to quantify them.

```
$ hmnfusion workflow-fusion \
    # Sample
    --input-lumpy-vcf <Lumpy Vcf file> \
    --input-genefuse-json <Genefuse, json file> OR --input-genefuse-html <Genefuse, html file> \
    --input-sample-bam <Bam file> \
    --name <Name of sample> \
    # Bed
    --input-hmnfusion-bed <HmnFusion bed file> \
    # Output
    --output-hmnfusion-vcf <Vcf file output>
```

## MMEJ sequences[¶](#mmej-sequences "Link to this heading")

Define fusions of interest.

```
$ hmnfusion extractfusion \
    # Sample
    --input-genefuse-json <Genefuse, json file> \
    --input-genefuse-html <Genefuse, html file> \
    --input-lumpy-vcf <Lumpy vcf file> \
    # Bed
    --input-hmnfusion-bed <Bed file> \
    # Output
    --output-hmnfusion-json <Json file output>
```

Extract MMEJ sequences.

```
$ hmnfusion mmej-fusion \
    # Sample
    --input-hmnfusion-json <HmnFusion, json file> \
    --input-sample-bam <Bam file> \
    --name <Name of sample> \
    # References
    --input-reference-fasta <Reference, fasta file> \
    # Output
    --output-hmnfusion-xlsx <Excel file output> \
    --output-hmnfusion-json <Json file output>
```

[Previous](install.html "Install")
[Next](faq.html "FAQ")

---

© Copyright 2021-2024.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).