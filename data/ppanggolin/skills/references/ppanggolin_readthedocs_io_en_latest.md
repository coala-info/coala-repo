PPanGGOLiN

User Guide:

* [Installation](user/install.html)
* [Quick usage](user/QuickUsage/quickAnalyses.html)
* [Practical information](user/practicalInformation.html)
* [Pangenome analyses](user/PangenomeAnalyses/pangenomeAnalyses.html)
* [Regions of genome plasticity analyses](user/RGP/rgpAnalyses.html)
* [Conserved module prediction](user/Modules/moduleAnalyses.html)
* [Write genomes](user/writeGenomes.html)
* [Write pangenome sequences](user/writeFasta.html)
* [Align external genes to a pangenome](user/align.html)
* [Projection](user/projection.html)
* [Prediction of Genomic Context](user/genomicContext.html)
* [Multiple Sequence Alignment](user/MSA.html)
* [Metadata and Pangenome](user/metadata.html)

Developper Guide:

* [How to Contribute ✨](dev/contribute.html)
* [Building the Documentation](dev/buildDoc.html)
* [API Reference](api/api_ref.html)

PPanGGOLiN

* PPanGGOLiN: Depicting microbial species diversity via a Partitioned PanGenome Graph Of Linked Neighbors
* [View page source](_sources/index.md.txt)

---

# PPanGGOLiN: Depicting microbial species diversity via a Partitioned PanGenome Graph Of Linked Neighbors[](#ppanggolin-depicting-microbial-species-diversity-via-a-partitioned-pangenome-graph-of-linked-neighbors "Permalink to this heading")

[![Actions](https://img.shields.io/github/actions/workflow/status/labgem/PPanGGOLiN/main.yml?branch=master&label=CI&logo=github)](https://github.com/labgem/PPanGGOLiN/actions/workflows/main.yml)
[![License](https://anaconda.org/bioconda/ppanggolin/badges/license.svg)](http://www.cecill.info/licences.fr.html)
[![Bioconda](https://img.shields.io/conda/vn/bioconda/ppanggolin?style=flat-square&maxAge=3600&logo=anaconda)](https://anaconda.org/bioconda/ppanggolin)
[![PyPI version](https://badge.fury.io/py/PPanGGOLiN.svg?cache-control=no-cache)](https://pypi.org/project/PPanGGOLiN/)
[![Source](https://img.shields.io/badge/source-GitHub-303030.svg?maxAge=2678400&style=flat-square)](https://github.com/labgem/ppanggolin/)
[![GitHub issues](https://img.shields.io/github/issues/labgem/ppanggolin.svg?style=flat-square&maxAge=600)](https://github.com/labgem/ppanggolin/issues)
[![Docs](https://img.shields.io/readthedocs/ppanggolin/latest?style=flat-square&maxAge=600)](https://ppanggolin.readthedocs.io)
[![Downloads](https://anaconda.org/bioconda/ppanggolin/badges/downloads.svg)](https://bioconda.github.io/recipes/ppanggolin/README.html#download-stats)

[![ppangolin logo](_images/logo.png)](_images/logo.png)

**PPanGGOLiN**
([Gautreau et al. 2020](https://doi.org/10.1371/journal.pcbi.1007732)) is a software suite used to create and manipulate prokaryotic pangenomes from a set of either assembled genomic DNA sequences or provided genome annotations.
It is designed to scale up to tens of thousands of genomes.
It has the specificity to partition the pangenome using a statistical approach rather than using fixed thresholds which gives it the ability to work with low-quality data such as *Metagenomic Assembled Genomes (MAGs)* or *Single-cell Amplified Genomes (SAGs)* thus taking advantage of large scale environmental studies and letting users study the pangenome of uncultivable species.

**PPanGGOLiN** builds pangenomes through a graphical model and a statistical method to partition gene families in persistent, shell and cloud genomes.
It integrates both information on protein-coding genes and their genomic neighborhood to build a graph of gene families where each node is a gene family, and each edge is a relation of genetic contiguity.
The partitioning method promotes that two gene families that are consistent neighbors in the graph are more likely to belong to the same partition.
It results in a Partitioned Pangenome Graph (PPG) made of persistent, shell and cloud nodes drawing genomes on rails like a subway map to help biologists navigate the great diversity of microbial life.

Moreover, the panRGP method ([Bazin et al. 2020](https://doi.org/10.1093/bioinformatics/btaa792)) included in **PPanGGOLiN** predicts, for each genome, Regions of Genome Plasticity (RGPs) that are clusters of genes made of shell and cloud genomes in the pangenome graph.
Most of them arise from Horizontal gene transfer (HGT) and correspond to Genomic Islands (GIs).
RGPs from different genomes are next grouped in spots of insertion based on their conserved flanking persistent genes.

Those RGPs can be further divided in conserved modules by panModule ([Bazin et al. 2021](https://doi.org/10.1101/2021.12.06.471380)). Those conserved modules correspond to groups of cooccurring and colocalized genes that are gained or lost together in the variable regions of the pangenome.

User Guide:

* [Installation](user/install.html)
  + [Installing PPanGGOLiN with Conda (Recommended)](user/install.html#installing-ppanggolin-with-conda-recommended)
  + [Installing PPanGGOLiN from PyPI](user/install.html#installing-ppanggolin-from-pypi)
  + [Installing from Source Code (GitHub)](user/install.html#installing-from-source-code-github)
  + [Development Version](user/install.html#development-version)
* [Quick usage](user/QuickUsage/quickAnalyses.html)
  + [PPanGGOLiN complete workflow analyses](user/QuickUsage/quickAnalyses.html#ppanggolin-complete-workflow-analyses)
  + [Usual pangenome outputs](user/QuickUsage/quickAnalyses.html#usual-pangenome-outputs)
* [Practical information](user/practicalInformation.html)
  + [Pangenome file](user/practicalInformation.html#pangenome-file)
  + [Required computing resources](user/practicalInformation.html#required-computing-resources)
  + [Usage and basic options](user/practicalInformation.html#usage-and-basic-options)
  + [Configuration file](user/practicalInformation.html#configuration-file)
  + [Issues, Questions, Remarks](user/practicalInformation.html#issues-questions-remarks)
  + [Citation](user/practicalInformation.html#citation)
* [Pangenome analyses](user/PangenomeAnalyses/pangenomeAnalyses.html)
  + [Workflow](user/PangenomeAnalyses/pangenomeAnalyses.html#workflow)
  + [Annotation](user/PangenomeAnalyses/pangenomeAnalyses.html#annotation)
  + [Compute pangenome gene families](user/PangenomeAnalyses/pangenomeAnalyses.html#compute-pangenome-gene-families)
  + [Graph](user/PangenomeAnalyses/pangenomeAnalyses.html#graph)
  + [Partition](user/PangenomeAnalyses/pangenomeAnalyses.html#partition)
  + [Pangenome outputs](user/PangenomeAnalyses/pangenomeAnalyses.html#pangenome-outputs)
  + [Pangenome metrics](user/PangenomeAnalyses/pangenomeAnalyses.html#pangenome-metrics)
  + [Pangenome info](user/PangenomeAnalyses/pangenomeAnalyses.html#pangenome-info)
* [Regions of genome plasticity analyses](user/RGP/rgpAnalyses.html)
  + [Purpose](user/RGP/rgpAnalyses.html#purpose)
  + [PanRGP](user/RGP/rgpAnalyses.html#panrgp)
  + [RGP detection](user/RGP/rgpAnalyses.html#rgp-detection)
  + [Spot prediction](user/RGP/rgpAnalyses.html#spot-prediction)
  + [RGP outputs](user/RGP/rgpAnalyses.html#rgp-outputs)
  + [RGP clustering](user/RGP/rgpAnalyses.html#rgp-clustering)
* [Conserved module prediction](user/Modules/moduleAnalyses.html)
  + [The panModule workflow](user/Modules/moduleAnalyses.html#the-panmodule-workflow)
  + [Predict conserved module](user/Modules/moduleAnalyses.html#predict-conserved-module)
  + [Module outputs](user/Modules/moduleAnalyses.html#module-outputs)
* [Write genomes](user/writeGenomes.html)
  + [Genes table with pangenome annotations](user/writeGenomes.html#genes-table-with-pangenome-annotations)
  + [GFF file](user/writeGenomes.html#gff-file)
  + [JSON Map for Proksee visualisation](user/writeGenomes.html#json-map-for-proksee-visualisation)
  + [Adding Fasta Sequences into GFF and proksee JSON map Files](user/writeGenomes.html#adding-fasta-sequences-into-gff-and-proksee-json-map-files)
  + [Incorporating Metadata into Tables, GFF, and Proksee Files](user/writeGenomes.html#incorporating-metadata-into-tables-gff-and-proksee-files)
* [Write pangenome sequences](user/writeFasta.html)
  + [Genes](user/writeFasta.html#genes)
  + [Gene families](user/writeFasta.html#gene-families)
  + [Modules](user/writeFasta.html#modules)
  + [Regions](user/writeFasta.html#regions)
* [Align external genes to a pangenome](user/align.html)
  + [Output files](user/align.html#output-files)
* [Projection](user/projection.html)
  + [Input files:](user/projection.html#input-files)
  + [Output Files](user/projection.html#output-files)
* [Prediction of Genomic Context](user/genomicContext.html)
  + [Search Genomic context with sequences](user/genomicContext.html#search-genomic-context-with-sequences)
  + [Search with gene family ID.](user/genomicContext.html#search-with-gene-family-id)
  + [Output format](user/genomicContext.html#output-format)
  + [Detailed options](user/genomicContext.html#detailed-options)
* [Multiple Sequence Alignment](user/MSA.html)
  + [Modify the partition with `--partition`](user/MSA.html#modify-the-partition-with-partition)
  + [Chose to align dna or protein sequences with `--source`](user/MSA.html#chose-to-align-dna-or-protein-sequences-with-source)
  + [Write a single whole MSA file with `--phylo`](user/MSA.html#write-a-single-whole-msa-file-with-phylo)
* [Metadata and Pangenome](user/metadata.html)
  + [Associating Metadata to Pangenome Elements](user/metadata.html#associating-metadata-to-pangenome-elements)
  + [Checking Metadata Associated with the Pangenome](user/metadata.html#checking-metadata-associated-with-the-pangenome)
  + [Exporting Metadata to TSV Files](user/metadata.html#exporting-metadata-to-tsv-files)

Developper Guide:

* [How to Contribute ✨](dev/contribute.html)
* [Building the Documentation](dev/buildDoc.html)
* [API Reference](api/api_ref.html)

[Next](user/install.html "Installation")

---

© Copyright 2023, LABGeM.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).