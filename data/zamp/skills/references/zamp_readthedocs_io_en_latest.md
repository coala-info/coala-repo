# Reproducible Scalable Pipeline For Amplicon-based Metagenomics (zAMP)[¶](#reproducible-scalable-pipeline-for-amplicon-based-metagenomics-zamp "Link to this heading")

zAMP is a bioinformatic pipeline designed for convenient, reproducible and scalable amplicon-based metagenomics. zAMP is a compilation of command-line tools and R packages that processes next-generation sequencing (NGS) from amplicon-based metagenomics reads into taxonomic profiles. Scripts running these tools are embedded in a *Snakemake* pipeline for reproducible, scalable and easy “*one-command-line*” execution of all steps, from QC to basic plotting. Tools and packages are made available into *Singularity* containers and *Conda* environments for easy and reproducible management of dependencies. zAMP is capable of processing local sequencing reads or reads stored on the Sequence Reads Archive (SRA). Complementary workflows enables preprocessing of reference taxonomic databases as well as *in silico* prediction the taxonomic classification obtained from reference genomes.

Please note that zAMP is a compilation of a number of published tools. We would be very grateful that you acknowledge our work but also the contribution of the developers of these tools in your publications using zAMP.

* [Installation and resource requirements](pages/setup.html)
  + [Quick start](pages/setup.html#quick-start)
  + [Operating system](pages/setup.html#operating-system)
  + [Installation methods](pages/setup.html#installation-methods)
  + [Resource usage](pages/setup.html#resource-usage)
* [Taxonomic reference databases](pages/ref_DB_preprocessing.html)
  + [Database processing principle](pages/ref_DB_preprocessing.html#database-processing-principle)
  + [Custom database](pages/ref_DB_preprocessing.html#custom-database)
  + [Available databases](pages/ref_DB_preprocessing.html#available-databases)
  + [Parameters](pages/ref_DB_preprocessing.html#parameters)
  + [Examples](pages/ref_DB_preprocessing.html#examples)
  + [Output](pages/ref_DB_preprocessing.html#output)
  + [References](pages/ref_DB_preprocessing.html#references)
* [Running zAMP](pages/execution.html)
  + [Local reads](pages/execution.html#local-reads)
  + [SRA reads](pages/execution.html#sra-reads)
* [Under the hood](pages/under_the_hood.html)
  + [Snakemake, environments and containers](pages/under_the_hood.html#snakemake-environments-and-containers)
  + [Logging and traceability](pages/under_the_hood.html#logging-and-traceability)
  + [Sequencing reads QC](pages/under_the_hood.html#sequencing-reads-qc)
  + [Denoising](pages/under_the_hood.html#denoising)
  + [Taxonomic assignment](pages/under_the_hood.html#taxonomic-assignment)
  + [Post-processing](pages/under_the_hood.html#post-processing)
  + [Picrust2](pages/under_the_hood.html#picrust2)
  + [References](pages/under_the_hood.html#references)
* [Downstream Analysis](pages/downstream_analysis.html)
  + [Basic plots](pages/downstream_analysis.html#basic-plots)
  + [Advanced Downstream Analysis with zAMPExplorer](pages/downstream_analysis.html#advanced-downstream-analysis-with-zampexplorer)
* [Frequently asked questions (FAQ)](pages/FAQ.html)
  + [Who should use zAMP?](pages/FAQ.html#who-should-use-zamp)
  + [Why does zAMP fail to read my metadata file?](pages/FAQ.html#why-does-zamp-fail-to-read-my-metadata-file)
  + [How do I check the available commands and options in zAMP?](pages/FAQ.html#how-do-i-check-the-available-commands-and-options-in-zamp)
  + [What parameters must I modify in the command line before running zAMP?](pages/FAQ.html#what-parameters-must-i-modify-in-the-command-line-before-running-zamp)
  + [What happens if I set incorrect primer sequences?](pages/FAQ.html#what-happens-if-i-set-incorrect-primer-sequences)
  + [What should I do if zAMP crashes midway?](pages/FAQ.html#what-should-i-do-if-zamp-crashes-midway)
  + [What reference databases are supported by zAMP?](pages/FAQ.html#what-reference-databases-are-supported-by-zamp)
* [*In silico* validation tool](pages/insilico_validation.html)
  + [Aim](pages/insilico_validation.html#aim)
  + [Working principle](pages/insilico_validation.html#working-principle)
  + [Inputs](pages/insilico_validation.html#inputs)
  + [Execution](pages/insilico_validation.html#execution)
  + [Output](pages/insilico_validation.html#output)

# zAMP

### Navigation

* [Installation and resource requirements](pages/setup.html)
* [Taxonomic reference databases](pages/ref_DB_preprocessing.html)
* [Running zAMP](pages/execution.html)
* [Under the hood](pages/under_the_hood.html)
* [Downstream Analysis](pages/downstream_analysis.html)
* [Frequently asked questions (FAQ)](pages/FAQ.html)
* [*In silico* validation tool](pages/insilico_validation.html)

### Related Topics

* Documentation overview
  + Next: [Installation and resource requirements](pages/setup.html "next chapter")

©2020, MetaGenLab.
|
Powered by [Sphinx 8.2.3](https://www.sphinx-doc.org/)
& [Alabaster 1.0.0](https://alabaster.readthedocs.io)
|
[Page source](_sources/index.rst.txt)