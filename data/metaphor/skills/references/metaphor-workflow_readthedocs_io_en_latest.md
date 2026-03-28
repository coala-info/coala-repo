# Welcome to Metaphor’s documentation![¶](#welcome-to-metaphor-s-documentation "Link to this heading")

Metaphor – Metagenomic Pipeline for Short Reads – is a [Snakemake](https://snakemake.readthedocs.io/)-based workflow for
assembly and binning of metagenomes. It also performs quality control, and basic functional and taxonomic annotation of the
assembled contigs, using the [NCBI COG](https://www.ncbi.nlm.nih.gov/research/cog/) database.

Metaphor is designed to be lightweight, flexible, and sustainable. That means that it strives to produce the desired output
with the minimal amount of dependencies and overhead, it is suitable for a wide range of use cases, and it is easy to
maintain and modify. Metagenomic analyses are usually quite complex, with numerous steps and dependencies. Metaphor’s goal
is to simplify that, and to provide users with a final output that enables exploratory data analysis and that can be
“plugged” into other downstream pipelines, such as phylogenomics or advanced genome annotation pipelines.

Please refer to this website to learn how to use Metaphor. If you have any questions or comments, or would like to report a
problem, don’t hesitate to [open an issue in the GitHub repo](https://github.com/vinisalazar/metaphor/issues/new/choose).
Any and all feedback is appreciated!

If you use Metaphor, please cite the open source software it is based on. The bib files can be found
[here](https://github.com/vinisalazar/metaphor/tree/main/metaphor/workflow/bibs) for your convenience.

**Quickstart**

```
$ conda install metaphor -c bioconda -c conda-forge
$ metaphor execute -i path/to/fastq/
```

Please read through the [Tutorial](usage/tutorial.md) for an introduction on how to use Metaphor.

[![Graphical summary of Metaphor. Blue rectangles are each module (corresponding to an .smk file), and yellow ovals are data produced at each step.](_images/workflow.png)](_images/workflow.png)

This figure shows a graphical summary of how Metaphor works, where blue rectangles are each module (corresponding to an
.smk file), and yellow ovals are data produced at each step.

**Table of Contents**

* [Tutorial](main/tutorial.html)
  + [Installation](main/tutorial.html#installation)
  + [Running](main/tutorial.html#running)
  + [Next steps](main/tutorial.html#next-steps)
* [Output](main/output.html)
  + [QC](main/output.html#qc)
  + [Assembly](main/output.html#assembly)
  + [Annotation](main/output.html#annotation)
  + [Mapping](main/output.html#mapping)
  + [Binning](main/output.html#binning)
  + [Postprocessing](main/output.html#postprocessing)
* [Advanced](main/advanced.html)
  + [How Snakemake works](main/advanced.html#how-snakemake-works)
  + [Running manually](main/advanced.html#running-manually)
  + [Input and config files](main/advanced.html#input-and-config-files)
  + [Cores and memory](main/advanced.html#cores-and-memory)
  + [Assembly and binning](main/advanced.html#assembly-and-binning)
  + [Package structure](main/advanced.html#package-structure)
* [Configuration](main/configuration.html)
* [Troubleshooting](main/troubleshooting.html)
  + [Formatting input data](main/troubleshooting.html#formatting-input-data)
  + [Finding logs](main/troubleshooting.html#finding-logs)
  + [Conda environment problems](main/troubleshooting.html#conda-environment-problems)
  + [Adding additional flags to Snakemake](main/troubleshooting.html#adding-additional-flags-to-snakemake)
  + [Unlocking directories](main/troubleshooting.html#unlocking-directories)
  + [Misc problems](main/troubleshooting.html#misc-problems)
* [Contributing](main/contributing.html)
  + [Types of Contributions](main/contributing.html#types-of-contributions)
  + [Get Started!](main/contributing.html#get-started)
  + [Pull Request Guidelines](main/contributing.html#pull-request-guidelines)
* [Reference](main/reference.html)
  + [qc.smk](main/reference.html#qc-smk)
  + [assembly.smk](main/reference.html#assembly-smk)
  + [annotation.smk](main/reference.html#annotation-smk)
  + [mapping.smk](main/reference.html#mapping-smk)
  + [binning.smk](main/reference.html#binning-smk)

All code is licensed under MIT for The University of Melbourne. This documentatiom is licensed as Public Domain under [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

# Metaphor

### Navigation

* [Tutorial](main/tutorial.html)
* [Output](main/output.html)
* [Advanced](main/advanced.html)
* [Configuration](main/configuration.html)
* [Troubleshooting](main/troubleshooting.html)
* [Contributing](main/contributing.html)
* [Reference](main/reference.html)

### Related Topics

* Documentation overview
  + Next: [Tutorial](main/tutorial.html "next chapter")

### Quick search

© The University of Melbourne 2023 — This documentation is public domain under a CC0 license.
|
Powered by [Sphinx 7.4.7](https://www.sphinx-doc.org/)
& [Alabaster 0.7.16](https://alabaster.readthedocs.io)
|
[Page source](_sources/index.rst.txt)