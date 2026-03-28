# Frequently asked questions (FAQ)[¶](#frequently-asked-questions-faq "Link to this heading")

## Who should use zAMP?[¶](#who-should-use-zamp "Link to this heading")

Researchers working on microbiota profiling using 16S or ITS amplicon sequencing can use zAMP to process, analyze, and visualize their data efficiently.

## Why does zAMP fail to read my metadata file?[¶](#why-does-zamp-fail-to-read-my-metadata-file "Link to this heading")

Ensure the metadata file adheres to the required format:

* **File format**: TSV (tab-separated values).
* **Mandatory columns**: Make sure to have mandatory columns like run, sample and sample\_group in your sample sheet (see [Running zAMP](execution.html#execution))
* **Avoid space or special characters**: Space or any special character in sample names cause errors.

## How do I check the available commands and options in zAMP?[¶](#how-do-i-check-the-available-commands-and-options-in-zamp "Link to this heading")

You can use the zamp -h command to see the general options and a list of available commands:

## What parameters must I modify in the command line before running zAMP?[¶](#what-parameters-must-i-modify-in-the-command-line-before-running-zamp "Link to this heading")

Required parameters:

* -i: can be either a sample sheet or the path to your reads
* -m: Path to your metadata if your input is a reads directory
* –fw-primer and –rv-primer: for forward and reverse primer sequences.
* -db: Path to your database files

## What happens if I set incorrect primer sequences?[¶](#what-happens-if-i-set-incorrect-primer-sequences "Link to this heading")

Incorrect primers may cause failure during the trimming step or incorrect merging of paired-end reads. Double-check primer sequences for accuracy.

## What should I do if zAMP crashes midway?[¶](#what-should-i-do-if-zamp-crashes-midway "Link to this heading")

* Identify the error message in the log files.
* Check file paths and parameter settings.

## What reference databases are supported by zAMP?[¶](#what-reference-databases-are-supported-by-zamp "Link to this heading")

zAMP supports multiple databases, including:

* SILVA
* Greengenes2
* EzBioCloud

# [zAMP](../index.html)

### Navigation

* [Installation and resource requirements](setup.html)
* [Taxonomic reference databases](ref_DB_preprocessing.html)
* [Running zAMP](execution.html)
* [Under the hood](under_the_hood.html)
* [Downstream Analysis](downstream_analysis.html)
* Frequently asked questions (FAQ)
  + [Who should use zAMP?](#who-should-use-zamp)
  + [Why does zAMP fail to read my metadata file?](#why-does-zamp-fail-to-read-my-metadata-file)
  + [How do I check the available commands and options in zAMP?](#how-do-i-check-the-available-commands-and-options-in-zamp)
  + [What parameters must I modify in the command line before running zAMP?](#what-parameters-must-i-modify-in-the-command-line-before-running-zamp)
  + [What happens if I set incorrect primer sequences?](#what-happens-if-i-set-incorrect-primer-sequences)
  + [What should I do if zAMP crashes midway?](#what-should-i-do-if-zamp-crashes-midway)
  + [What reference databases are supported by zAMP?](#what-reference-databases-are-supported-by-zamp)
* [*In silico* validation tool](insilico_validation.html)

### Related Topics

* [Documentation overview](../index.html)
  + Previous: [Downstream Analysis](downstream_analysis.html "previous chapter")
  + Next: [*In silico* validation tool](insilico_validation.html "next chapter")

©2020, MetaGenLab.
|
Powered by [Sphinx 8.2.3](https://www.sphinx-doc.org/)
& [Alabaster 1.0.0](https://alabaster.readthedocs.io)
|
[Page source](../_sources/pages/FAQ.rst.txt)