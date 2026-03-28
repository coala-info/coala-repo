[ ]
[ ]

[Skip to content](#_1)

[![logo](img/little_logo.svg)](. "Nomadic")

Nomadic

Overview

Initializing search

[GitHub](https://github.com/JasonAHendry/nomadic.git "Go to repository")

[![logo](img/little_logo.svg)](. "Nomadic")
Nomadic

[GitHub](https://github.com/JasonAHendry/nomadic.git "Go to repository")

* [ ]

  Overview

  [Overview](.)

  Table of contents
  + [Overview](#overview)
  + [Features](#features)
  + [Resources](#resources)
  + [Acknowledgements](#acknowledgements)
* [Installation](installation/)
* [ ]

  Usage

  Usage
  + [Quick Start](quick_start/)
  + [Basic Usage](basic/)
  + [Sharing and Backing up](share_backup/)
  + [Advanced Usage](advanced/)
* [Understanding the Dashboard](understand/)
* [Output Files](output_files/)
* [FAQ](faq/)

Table of contents

* [Overview](#overview)
* [Features](#features)
* [Resources](#resources)
* [Acknowledgements](#acknowledgements)

#

![nomadic](img/home/nomadic_logo.png)

---

## Overview

*Nomadic* is a real-time bioinformatics pipeline and dashboard for nanopore sequencing data. While sequencing is still ongoing, it performs read mapping and sample quality control, as well as variant calling and annotation. This information is displayed in real-time to a graphical dashboard that has interactive features.

![dashboard](img/home/dashboard-workflow.png)

It was designed to work with amplicon sequencing data from the NOMADS-MVP protocol, which targets a panel of genes important for the control of *Plasmodium falciparum* malaria (see [Basic Usage](basic/)). However, it was coded flexibly and works with other organisms or amplicon panels (see [Advanced Usage](advanced/)).

![example](img/home/nomadic_in_kenya.jpg)

## Features

* [x]  Real-time read mapping with [*Minimap2*](https://github.com/lh3/minimap2).
* [x]  Real-time sample quality control and amplicon coverage evaluation.
* [x]  Real-time variant calling with [*delve*](https://github.com/berndbohmeier/delve) or [*bcftools*](https://github.com/samtools/bcftools).
* [x]  Support for different reference genomes or amplicons panels.

## Resources

* The NOMADS-MVP protocol is available in [English](https://www.protocols.io/view/nomads-mvp-rapid-genomic-surveillance-of-malaria-w-kxygxy284l8j/v1) and [French](https://www.protocols.io/view/surveillance-g-nomique-du-paludisme-par-la-m-thod-q26g75b5qlwz/v1).
* Read our preprint [here](https://www.biorxiv.org/content/10.1101/2025.07.23.666274v1).

## Acknowledgements

This work was funded by the Bill and Melinda Gates Foundation (INV-003660, INV-048316).

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)