# Under the hood[¶](#under-the-hood "Link to this heading")

## Snakemake, environments and containers[¶](#snakemake-environments-and-containers "Link to this heading")

[Snakemake](https://snakemake.readthedocs.io/en/stable/tutorial/tutorial.html) is the center-piece of this pipeline.
Snakemake is a Python-based workflow-manager that enables the processing of a large set of amplicon-based metagenomics sequencing reads into actionable outputs.
Each step is defined as a rule in which input/output files, software dependencies (Conda or containers), scripts and command-lines are specified (See [snakemake’s docs](https://snakemake.readthedocs.io/en/stable/snakefiles/rules.html) for more details).

[Conda environments](https://docs.conda.io/projects/conda/en/latest/user-guide/getting-started.html)

Conda is a language-independent package and environment management tool. A Conda environment is a collection of installed Conda packages. For example, a research project might require VSEARCH 2.20.0 and its dependencies, whereas another environment associated with a completed project might necessitate the use of VSEARCH 2.15. Changing the environment, has no effect on the others.
Switching between environments is simple because they can be easily activated or deactivated.

[Apptainer containers](https://apptainer.org/docs/user/latest/)

The concept of reproducible analysis in bioinformatics extends beyond good documentation and code sharing. Analyses typically depend on an entire environment with numerous tools, libraries, and settings.
Storage, reuse, and sharing environments via container software such as Docker and Singularity could improve reproducibility and productivity.
By using containers (apptainer, docker, podman …), users can create a single executable file that contains all aspects of their environment and allows to safely run environments from a variety of resources without requiring privileged access.

## Logging and traceability[¶](#logging-and-traceability "Link to this heading")

### logs[¶](#logs "Link to this heading")

Upon each execution, *zAMP* automatically creates a log file where all the standard output is recorded:

```
zamp_out/zamp.log
```

### config file[¶](#config-file "Link to this heading")

In addition to logs, *zAMP* copies a config file listing all the parameters used in the run unde

```
zamp_out/config.yaml
```

## Sequencing reads QC[¶](#sequencing-reads-qc "Link to this heading")

QC rules assess the sequencing quality of all each sample with FastQC [[1]](#id4). Then, a MultiQC [[2]](#id5) report generates a report for each sequencing run (based on “run” column indicated in *sample sheet* ).
A global MultiQC report is generated as well, but without interactive features to deal with the high number of samples

## Denoising[¶](#denoising "Link to this heading")

### Vsearch (OTU clustering)[¶](#vsearch-otu-clustering "Link to this heading")

#### PANDAseq[¶](#pandaseq "Link to this heading")

#### Vsearch[¶](#vsearch "Link to this heading")

### DADA2 (ASV denoising)[¶](#dada2-asv-denoising "Link to this heading")

#### cutadapt[¶](#cutadapt "Link to this heading")

#### DADA2[¶](#dada2 "Link to this heading")

## Taxonomic assignment[¶](#taxonomic-assignment "Link to this heading")

### reference database[¶](#reference-database "Link to this heading")

### classifiers[¶](#classifiers "Link to this heading")

## Post-processing[¶](#post-processing "Link to this heading")

### Taxonomic filtering[¶](#taxonomic-filtering "Link to this heading")

### Rarefaction[¶](#rarefaction "Link to this heading")

### Phylogenetic tree generation[¶](#phylogenetic-tree-generation "Link to this heading")

### Taxonomic collapsing[¶](#taxonomic-collapsing "Link to this heading")

### Normalization and abundance-based filtering[¶](#normalization-and-abundance-based-filtering "Link to this heading")

### Exports[¶](#exports "Link to this heading")

### Fromatting[¶](#fromatting "Link to this heading")

#### Wide to long melting[¶](#wide-to-long-melting "Link to this heading")

#### transpose\_and\_meta\_count\_table[¶](#transpose-and-meta-count-table "Link to this heading")

#### Qiime2 formats[¶](#qiime2-formats "Link to this heading")

## Picrust2[¶](#picrust2 "Link to this heading")

## References[¶](#references "Link to this heading")

[[1](#id2)]

Andrews S, Krueger F, Seconds-Pichon A, Biggins F, Wingett S. FastQC. A quality control tool for high throughput sequence data. Babraham Bioinformatics. Babraham Institute. 2015.

[[2](#id3)]

Ewels P, Magnusson M, Lundin S, Käller M. MultiQC: Summarize analysis results for multiple tools and samples in a single report. Bioinformatics. 2016;

# [zAMP](../index.html)

### Navigation

* [Installation and resource requirements](setup.html)
* [Taxonomic reference databases](ref_DB_preprocessing.html)
* [Running zAMP](execution.html)
* Under the hood
  + [Snakemake, environments and containers](#snakemake-environments-and-containers)
  + [Logging and traceability](#logging-and-traceability)
  + [Sequencing reads QC](#sequencing-reads-qc)
  + [Denoising](#denoising)
  + [Taxonomic assignment](#taxonomic-assignment)
  + [Post-processing](#post-processing)
  + [Picrust2](#picrust2)
  + [References](#references)
* [Downstream Analysis](downstream_analysis.html)
* [Frequently asked questions (FAQ)](FAQ.html)
* [*In silico* validation tool](insilico_validation.html)

### Related Topics

* [Documentation overview](../index.html)
  + Previous: [Running zAMP](execution.html "previous chapter")
  + Next: [Downstream Analysis](downstream_analysis.html "next chapter")

©2020, MetaGenLab.
|
Powered by [Sphinx 8.2.3](https://www.sphinx-doc.org/)
& [Alabaster 1.0.0](https://alabaster.readthedocs.io)
|
[Page source](../_sources/pages/under_the_hood.rst.txt)