phyluce

Contents:

* [Purpose](purpose.html)
* [Installation](installation.html)
* [Phyluce Tutorials](tutorials/index.html)
* [Phyluce in Daily Use](daily-use/index.html)

* [Citing](citing.html)
* [License](license.html)
* [Attributions](attributions.html)
* [Funding](funding.html)
* [Acknowledgements](ack.html)

phyluce

* phyluce: software for UCE (and general) phylogenomics
* [View page source](_sources/index.rst.txt)

---

# phyluce: software for UCE (and general) phylogenomics[](#phyluce-software-for-uce-and-general-phylogenomics "Link to this heading")

Release v1.7.3

Author:
:   Brant C. Faircloth

Date:
:   27 February 2026 13:36 UTC (+0000)

Copyright:
:   This documentation is available under a Creative Commons ([CC-BY](http://creativecommons.org/licenses/by/4.0/)) license.

[phyluce](https://github.com/faircloth-lab/phyluce) (phy-**loo**-chee) is a software package that was initially developed
for analyzing data collected from ultraconserved elements in organismal genomes
(see [References](citing.html#references) and <http://ultraconserved.org> for additional
information).

The package includes a number of tools spanning:

* the assembly of raw read data to contigs
* the separation of UCE loci from assembled contigs
* parallel alignment generation, alignment trimming, and alignment data summary
  methods in preparation for analysis
* SNP calling and contig correction using raw-read data

As it stands, the [phyluce](https://github.com/faircloth-lab/phyluce) package is useful for analyzing both data collected
from UCE loci and also data collection from other types of loci for phylogenomic
studies at the species, population, and individual levels.

## Contributions[](#contributions "Link to this heading")

[phyluce](https://github.com/faircloth-lab/phyluce) is open-source (see [License](license.html#license)) and we welcome contributions from
anyone who is interested. Please make a pull request on [github](https://github.com/faircloth-lab/phyluce).

## Issues[](#issues "Link to this heading")

The issue tracker for [phyluce](https://github.com/faircloth-lab/phyluce) is [available on github](https://github.com/faircloth-lab/phyluce/issues).
If you have an issue, please ensure that you are experiencing this issue on a
supported OS (see [Installation](installation.html#installation)) using the [conda](http://docs.continuum.io/conda/) installation of
[phyluce](https://github.com/faircloth-lab/phyluce). When submitting issues, please include a test case demonstrating
the issue and indicate which operating system and phyluce version
you are using.

# Guide[](#guide "Link to this heading")

Contents:

* [Purpose](purpose.html)
  + [Longer-term goals (v2.0.0+ and beyond)](purpose.html#longer-term-goals-v2-0-0-and-beyond)
  + [Who wrote this?](purpose.html#who-wrote-this)
  + [How do I report bugs?](purpose.html#how-do-i-report-bugs)
* [Installation](installation.html)
  + [Install Process](installation.html#install-process)
    - [Using Conda](installation.html#using-conda)
    - [Using Docker](installation.html#using-docker)
    - [Using Singularity](installation.html#using-singularity)
  + [phyluce configuration](installation.html#phyluce-configuration)
  + [Other useful tools](installation.html#other-useful-tools)
* [Phyluce Tutorials](tutorials/index.html)
  + [Tutorial I: UCE Phylogenomics](tutorials/tutorial-1.html)
    - [Download the data](tutorials/tutorial-1.html#download-the-data)
    - [Count the read data](tutorials/tutorial-1.html#count-the-read-data)
    - [Clean the read data](tutorials/tutorial-1.html#clean-the-read-data)
    - [Assemble the data](tutorials/tutorial-1.html#assemble-the-data)
    - [Finding UCE loci](tutorials/tutorial-1.html#finding-uce-loci)
    - [Extracting UCE loci](tutorials/tutorial-1.html#extracting-uce-loci)
    - [Aligning UCE loci](tutorials/tutorial-1.html#aligning-uce-loci)
    - [Alignment cleaning](tutorials/tutorial-1.html#alignment-cleaning)
    - [Final data matrices](tutorials/tutorial-1.html#final-data-matrices)
    - [Preparing data for downstream analysis](tutorials/tutorial-1.html#preparing-data-for-downstream-analysis)
    - [Next Steps](tutorials/tutorial-1.html#next-steps)
  + [Tutorial II: Phasing UCE data](tutorials/tutorial-2.html)
    - [Exploding aligned and trimmed UCE sequences](tutorials/tutorial-2.html#exploding-aligned-and-trimmed-uce-sequences)
    - [Creating a re-alignment configuration file](tutorials/tutorial-2.html#creating-a-re-alignment-configuration-file)
    - [Mapping reads against contigs](tutorials/tutorial-2.html#mapping-reads-against-contigs)
    - [Phasing mapped reads](tutorials/tutorial-2.html#phasing-mapped-reads)
  + [Tutorial III: Harvesting UCE Loci From Genomes](tutorials/tutorial-3.html)
    - [Starting directory structure](tutorials/tutorial-3.html#starting-directory-structure)
    - [Download the data](tutorials/tutorial-3.html#download-the-data)
    - [Finding UCE loci](tutorials/tutorial-3.html#finding-uce-loci)
  + [Tutorial IV: Identifying UCE Loci and Designing Baits To Target Them](tutorials/tutorial-4.html)
    - [Starting directory structure](tutorials/tutorial-4.html#starting-directory-structure)
    - [Data download and preparation](tutorials/tutorial-4.html#data-download-and-preparation)
    - [Read alignment to the base genome](tutorials/tutorial-4.html#read-alignment-to-the-base-genome)
    - [Conserved locus identification](tutorials/tutorial-4.html#conserved-locus-identification)
    - [Conserved locus validation](tutorials/tutorial-4.html#conserved-locus-validation)
    - [Final bait set design](tutorials/tutorial-4.html#final-bait-set-design)
    - [The master bait list](tutorials/tutorial-4.html#the-master-bait-list)
    - [In-silico test of the bait design](tutorials/tutorial-4.html#in-silico-test-of-the-bait-design)
* [Phyluce in Daily Use](daily-use/index.html)
  + [Quality Control](daily-use/daily-use-1-quality-control.html)
    - [Read Counts](daily-use/daily-use-1-quality-control.html#read-counts)
    - [Adapter- and quality-trimming](daily-use/daily-use-1-quality-control.html#adapter-and-quality-trimming)
  + [Assembly](daily-use/daily-use-2-assembly.html)
    - [Setup](daily-use/daily-use-2-assembly.html#setup)
    - [Running the assembly](daily-use/daily-use-2-assembly.html#running-the-assembly)
  + [UCE Processing for Phylogenomics](daily-use/daily-use-3-uce-processing.html)
    - [Identifying UCE loci](daily-use/daily-use-3-uce-processing.html#identifying-uce-loci)
    - [Creating a data matrix configuration file](daily-use/daily-use-3-uce-processing.html#creating-a-data-matrix-configuration-file)
    - [Extracting FASTA data using the data matrix configuration file](daily-use/daily-use-3-uce-processing.html#extracting-fasta-data-using-the-data-matrix-configuration-file)
    - [Aligning and trimming FASTA data](daily-use/daily-use-3-uce-processing.html#aligning-and-trimming-fasta-data)
    - [Operations on alignments](daily-use/daily-use-3-uce-processing.html#operations-on-alignments)
    - [Preparing concatenated alignment data for analysis](daily-use/daily-use-3-uce-processing.html#preparing-concatenated-alignment-data-for-analysis)
  + [Workflows](daily-use/daily-use-4-workflows.html)
    - [What’s Different](daily-use/daily-use-4-workflows.html#what-s-different)
    - [Workflow Location](daily-use/daily-use-4-workflows.html#workflow-location)
    - [Workflow Configuration](daily-use/daily-use-4-workflows.html#workflow-configuration)
    - [Different Workflows](daily-use/daily-use-4-workflows.html#different-workflows)
  + [List of Phyluce Programs](daily-use/list-of-programs.html)
    - [Assembly](daily-use/list-of-programs.html#assembly)
    - [Alignment](daily-use/list-of-programs.html#alignment)
    - [Genetrees](daily-use/list-of-programs.html#genetrees)
    - [NCBI](daily-use/list-of-programs.html#id1)
    - [Probes](daily-use/list-of-programs.html#probes)
    - [Utilities](daily-use/list-of-programs.html#utilities)
    - [Workflow](daily-use/list-of-programs.html#workflow)

# Project info[](#project-info "Link to this heading")

* [Citing](citing.html)
* [License](license.html)
* [Attributions](attributions.html)
* [Funding](funding.html)
* [Acknowledgements](ack.html)

[Next](purpose.html "Purpose")

---

© Copyright 2012-2024, Brant C. Faircloth.

Built with [Sphinx](https://www.sphinx-doc.org/) using a
[theme](https://github.com/readthedocs/sphinx_rtd_theme)
provided by [Read the Docs](https://readthedocs.org).