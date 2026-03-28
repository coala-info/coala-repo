[ ]
[ ]

[Skip to content](#wepp-wastewater-based-epidemiology-using-phylogenetic-placements)

[![logo](images/WEPP_icon.png)](index.html "WEPP")

WEPP

Home

Initializing search

[TurakhiaLab/WEPP](https://github.com/TurakhiaLab/WEPP "Go to repository")

* [Home](index.html)
* [Install](install.html)
* [Quick Start](quickstart.html)
* [User Guide](usage.html)
* [Contributions](contribution.html)
* [Cite WEPP](cite.html)

[![logo](images/WEPP_icon.png)](index.html "WEPP")
WEPP

[TurakhiaLab/WEPP](https://github.com/TurakhiaLab/WEPP "Go to repository")

* [ ]

  Home

  [Home](index.html)

  Table of contents
  + [WEPP Video Tutorial](#wepp-video-tutorial)
  + [Overview](#overview)
  + [Key Features](#key-features)

    - [Haplotype Proportions](#haplotype-proportions)
    - [Lineage Proportions](#lineage-proportions)
    - [Unaccounted Alleles](#unaccounted-alleles)
    - [Read-Level Analysis](#read-level-analysis)
* [Install](install.html)
* [Quick Start](quickstart.html)
* [User Guide](usage.html)
* [Contributions](contribution.html)
* [Cite WEPP](cite.html)

# **WEPP: Wastewater-Based Epidemiology using Phylogenetic Placements**

![](images/WEPP_logo.svg)

## **WEPP Video Tutorial**

## **Overview**

WEPP (**W**astewater-Based **E**pidemiology using **P**hylogenetic **P**lacements) is a pathogen-agnostic pipeline that significantly enhances the resolution and capabilities of wastewater surveillance. It analyzes the wastewater sequencing reads by considering the comprehensive phylogeny of the pathogen, specifically, mutation-annotated trees (MATs) that include all globally available clinical sequences and their inferred ancestral nodes, to identify a subset of haplotypes most likely present in the sample. In addition, WEPP reports the abundance of each haplotype and its corresponding lineage, provides parsimonious mappings of individual reads to haplotypes, and flags *Unaccounted Alleles* — those observed in the sample but unexplained by selected haplotypes, which may signal the presence of novel circulating variants (Figure 1A).

WEPP includes an interactive visualization dashboard that allows users to visualize detected haplotypes and haplotype clusters within the context of the global phylogenetic tree and investigate haplotype and lineage abundances (Figure 1B(i)). It also allows a detailed read-level analysis by selecting a haplotype to view its characteristic mutations alongside those observed in the mapped reads (Figure 1B(ii)). Additional information about individual reads or haplotypes can be accessed by clicking on their corresponding objects, as shown in Figures 1B(iii) and 1B(iv), respectively.

WEPP performs parsimonious placement of reads on the MAT and selects a subset of haplotypes along with their nearest neighbors to form a pool of candidate haplotypes. This pool is passed to a deconvolution algorithm to estimate their relative abundances. WEPP only retains haplotypes above an abundance threshold and iteratively refines this set by adding neighbors of the retained set, followed by deconvolution. This process continues until it reaches convergence or a maximum iteration count (Figure 1C). WEPP also uses an outlier detection algorithm on the deconvolution residue to generate a list of *Unaccounted Alleles*.

![](images/WEPP_Overview_Display.svg)

**Figure 1: Overview of the WEPP pipeline.** (A) WEPP input and output. (B) Features of the interactive Dashboard: (i) Phylogenetic view of WEPP-inferred haplotypes with their proportions, associated lineages, and uncertain haplotypes.Unaccounted Alleles and their possible haplotype sources are shown in a separate panel; (ii) Read analysis panel highlighting accounted and Unaccounted Alleles contained in reads mapped to a selected haplotype; (iii) Read information panel displaying all possible haplotypes and Unaccounted Alleles for a selected read; (iv) Haplotype information panel listing the possible Unaccounted Alleles associated with the selected haplotype. (C) Key stages of WEPP’s phylogenetic algorithm for haplotype detection and abundance estimation.

## **Key Features**

### **Haplotype Proportions**

WEPP's *Phylogenetic Placement* of reads enables accurate estimation of haplotype proportions from wastewater samples. These estimates can be interactively explored from the phylogenetic view of the dashboard (Figure 1B(i)), which displays each haplotype’s abundance, associated lineage, and phylogenetic uncertainty via *Uncertain Haplotypes* - neighboring haplotypes that cannot be confidently disambiguated.

### **Lineage Proportions**

WEPP infers lineage proportions by aggregating haplotype abundances within each lineage, accounting for intra-lineage diversity to produce more accurate and robust estimates.

### **Unaccounted Alleles**

WEPP reports a list of *Unaccounted Alleles* - alleles observed in wastewater that are not explained by the selected haplotypes, along with the inferred haplotype(s) they are most likely associated with (Figure 1B(i)). These *Unaccounted Alleles* can serve as early indicators of novel variants and often resemble the 'cryptic' mutations described in previous studies.

### **Read-Level Analysis**

WEPP supports detailed analysis of sequencing reads in the context of selected haplotypes (Figure 1B(ii)). It also facilitates interpretation of *Unaccounted Alleles* by examining their presence in reads relative to the haplotypes they are mapped to. Additional information about individual reads or haplotypes can be accessed by selecting them within the interactive panel (Figure 1B(iii) and Figure 1B(iv)).

[Next

Install](install.html)

© 2025 [Turakhia Lab](https://github.com/TurakhiaLab)

Made with
[Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)