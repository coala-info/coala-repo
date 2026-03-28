[QAX](/qax/ "Qiime Artifacts eXtractor Documentation")

v0.9.8 - migrate to Nim 2 and NimYaml 2

* [1. Installation](/qax/installation)
* [2. General usage](/qax/usage)
* [3. Usage examples](/qax/examples)

 [Commands](/qax/commands/)

* [1. List](/qax/commands/list.html)
* [2. View](/qax/commands/view.html)
* [3. Provenance](/qax/commands/provenance.html)
* [4. Make](/qax/commands/make.html)
* [5. List](/qax/commands/extract.html)
* [6. Citations](/qax/commands/citations.html)

 [Releases](/qax/releases/)

* [v0.9.5](/qax/releases/v0.9.5.html)
* [v0.9.6](/qax/releases/v0.9.6.html)
* [v0.9.6](/qax/releases/v0.9.7.html)

[QAX](/qax/)

* readme.md

---

# QAX: the Qiime2 Artifacts eXtractor

[![Repository Size](https://img.shields.io/github/languages/code-size/telatin/qax)](https://github.com/telatin/qax) [![Latest release](https://img.shields.io/github/v/release/telatin/qax)](https://github.com/telatin/qax/releases) [![Available via BioConda](https://img.shields.io/conda/vn/bioconda/qax)](https://bioconda.github.io/recipes/qax/README.html) [![BioConda Downloads](https://img.shields.io/conda/dn/bioconda/qax)](https://bioconda.github.io/recipes/qax/README.html)

* Website: <https://telatin.github.io/qax/>
* Github: <https://github.com/telatin/qax>
* Paper: <https://doi.org/10.3390/biotech10010005>

## Introduction

Qiime2 is one of the most popular software used to analyze the output of metabarcoding experiment, and it introduced a unique data format in the bioinformatics scenario: the "*Qiime2 artifact*".

Qiime2 artifacts are structured compressed archives containing a dataset (*e.g.*, FASTQ reads, representative sequences in FASTA format, a phylogenetic tree in Newick format, etc.) and an exhaustive set of metadata (including the command that generated it, information on the execution environment, citations on the used software, and all the metadata of the artifacts used to produce it).

While artifacts can improve the shareability and reproducibility of Qiime workflows, they are less easily integrated with general bioinformatics pipelines, and even accessing metadata in the artifacts requires the full Qiime2 installation (not to mention that every release of Qiime2 will produce incompatible artifacts). Qiime Artifact Extractor (qxa) allows to easily interface with Qiime2 artifacts from the command line, without needing the full Qiime2 environment installed.

## Functions

`qax` has different subprograms (and the general syntax is `qax [program] [program-arguments]`):

* **list** (default): list artifact(s) properties
* **citations**: extract citations in BibTeX format
* **extract**: extract artifact *data* files
* **provenance**: describe artifact provenance, or generate its graph
* **view**: print the content of an artifact (eg. dna-sequences.fasta) to the terminal
* **make**: create a visualization artifact from HTML

## Citation

Telatin, A. **Qiime Artifact eXtractor (qax): A Fast and Versatile Tool to Interact with Qiime2 Archives.** BioTech [doi.org/10.3390/biotech10010005](https://doi.org/10.3390/biotech10010005)

[Next](/qax/installation "Installation")

---

2020-2026, [Andrea Telatin](https://github.com/telatin) Revision [7b2b202](https://github.com/telatin/qax/commit/7b2b2026bd53c876dc2703245deae696dc9a0b12 "7b2b2026bd53c876dc2703245deae696dc9a0b12")

Built with [GitHub Pages](https://pages.github.com "github-pages v232") using a theme provided by RunDocs.

QAX

main

GitHub
:   [Homepage](https://github.com/telatin/qax "Stars: 5")
:   [Issues](https://github.com/telatin/qax/issues "Open issues: 0")
:   [Download](https://github.com/telatin/qax/zipball/main "Size: 16022 Kb")

---

This [Software](/qax/ "QAX") is under the terms of [GNU General Public License v3.0](https://github.com/telatin/qax).