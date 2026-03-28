[seq2science](../../index.html)

* [Getting started](../gettingstarted.html)
* [Workflows](../workflows.html)
  + Downloading fastqs
    - [Workflow overview (simplified)](#workflow-overview-simplified)
      * [Download SRA file](#download-sra-file)
    - [Filling out the samples.tsv](#filling-out-the-samples-tsv)
      * [Sample column](#sample-column)
      * [Final notes](#final-notes)
    - [Filling out the config.yaml](#filling-out-the-config-yaml)
    - [Best practices](#best-practices)
      * [Downloading with ascp](#downloading-with-ascp)
      * [Filetype extensions and paired-end suffix](#filetype-extensions-and-paired-end-suffix)
  + [Alignment](alignment.html)
  + [ATAC-seq](atac_seq.html)
  + [ChIP-seq](chip_seq.html)
  + [RNA-seq](rna_seq.html)
  + [scATAC-seq](scatac_seq.html)
  + [scRNA-seq](scrna_seq.html)
* [Using the results](../results.html)
* [Extensive docs](../extensive_docs.html)
* [Extra resources](../extracontent.html)
* [Frequently Asked Questions (FAQ)](../faq.html)
* [Contributing to seq2science](../../CONTRIBUTING.html)

[seq2science](../../index.html)

* [Workflows](../workflows.html)
* Downloading fastqs
* [Edit on GitHub](https://github.com/vanheeringen-lab/seq2science/blob/master/docs/content/workflows/download_fastq.md)

---

# Downloading fastqs[](#downloading-fastqs "Link to this heading")

Downloading public data in bulk from the NCBI, ENA, and DDBJ databases has never been easier!

## Workflow overview (simplified)[](#workflow-overview-simplified "Link to this heading")

![](../../_static/download_fastq.png)

### Download SRA file[](#download-sra-file "Link to this heading")

The five most popular databases that store sequencing data are National Center for Biotechnology Information (NCBI), the European Nucleotide Archive (ENA), the DNA Data Bank of Japan (DDBJ), the Genome Sequence Archive (GSA) (GSA is currently not supported anymore), and the Encode project (ENCODE).
ENA, ENCODE, and GSA store the actual fastq files, and DDBJ and NCBI store the raw data (as a sra file) from which a fastq can be derived.
For this reason for each sample on DDBJ and NCBI seq2science will first check if it can be downloaded from ENA as a fastq directly.
Otherwise we will download the samples in its raw format. To convert this data to a fastq it has to be “*dumped*“.

## Filling out the samples.tsv[](#filling-out-the-samples-tsv "Link to this heading")

Before running a workflow you will have to specify which samples you want to run the workflow on.
Each workflow starts with a `samples.tsv` as an example, and you should adapt it to your specific needs.
As an example, the `samples.tsv` could look something like this:

```
sample
DRX890    <-- DDBJ experiment
DRR098    <-- DDBJ run
ENCSR765  <-- ENCODE assay
ENCFF432  <-- ENCODE fastq file
ERX123    <-- EBI ENA experiment
ERR321    <-- EBI ENA run
GSMabc    <-- GEO sample
SRX456    <-- SRA experiment
SRRxzy    <-- SRA run
```

### Sample column[](#sample-column "Link to this heading")

When downloading fastq files there is only one column in the samples.txt.
This is the sample column, where each sample is specified.
Samples are specified with their name of the accession (e.g. GSM2837484).
(Accepted formats start with “CRX”, “DRR”, “DRX”, “ENCFF” “ENCSR”, “ERR”, “ERX”, “GSM”, “SRR”, or “SRX”)

When specifying an ENCODE fastq file, and it belongs to a paired sequencing run, both fastq files will be downloaded. They will have the file name of the sample, and R1 and R2 will correspond to ENCODE.

### Final notes[](#final-notes "Link to this heading")

* Feel free to add columns to your liking (these will be ignored).

## Filling out the config.yaml[](#filling-out-the-config-yaml "Link to this heading")

Every workflow has many configurable options, and can be set in the `config.yaml` file.
In each `config.yaml` we highlighted a couple options that we think are relevant for that specific workflow, and set (we think) **reasonable default** values.

When a workflow starts it prints the configuration variables influencing the workflow, and (almost) all these values can be added in the `config.yaml` and changed to your liking.
You can see the complete set of configurable options in the [extensive docs](../schemas.html).

## Best practices[](#best-practices "Link to this heading")

### Downloading with ascp[](#downloading-with-ascp "Link to this heading")

ascp is a downloading protocol that allows for (sometimes much) faster speeds. If you have ascp installed you can make the workflow download through this protocol. You can specify the path to the binary in the config.yaml by key `ascp_path` and the ascp key in the config by key `ascp_key`:

See this [gist](https://gist.github.com/mfansler/71f09c8b6c9a95ec4e759a8ffc488be3) for an easy installation of ascp.

### Filetype extensions and paired-end suffix[](#filetype-extensions-and-paired-end-suffix "Link to this heading")

The pipeline will save fastq files in the *fastq\_dir* directory, which is located in the *result\_dir* directory by default.

People and tools have different preferences for storing their data. One of these differences is how to name the fastq.gz files. Some people/tools prefer `fastq.gz`, while others prefer `fq.gz`. By default the pipeline names files with the fastq.gz extension. However if you prefer to change this you can set the variable *fqsuffix* accordingly.
The same goes for paired-end suffix conventions, most people prefer `sample_R1` which is our default. However you can use your preferred suffix by setting variables *fqext1* and *fqext2*.

In the`config.yaml:

```
fastq_dir: ./my_first_fastq_dir

fqsuffix: fastq
fqext1: R1
fqext2: R2
```

[Previous](../workflows.html "Workflows")
[Next](alignment.html "Alignment")

---

© Copyright Maarten van der Sande, Siebren Frölich, Jos Smits, Rebecca Snabel, Tilman Schäfers, & Simon van Heeringen..

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).