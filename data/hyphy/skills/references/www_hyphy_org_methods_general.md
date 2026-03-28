[ ]
[ ]

![HyPhy Logo](../../images/header-logo.svg)
HyPhy
Hypothesis Testing using Phylogenies

![HyPhy Logo](../../images/header-logo.svg)
HyPhy

[![](../../images/logo.svg)](../..)

* [Home](../.. "Home")
* [News and Releases](../../news/ "News and Releases")
* [About](../../about/ "About")
* [Installation](../../installation/ "Installation")
* [Getting Started](../../getting-started/ "Getting Started")
* [Methods](./ "Methods")

  + [Overview](#overview "Overview")
  + [MG94xREV Framework](#mg94xrev-framework "MG94xREV Framework")
  + [Synonymous Rate Variation](#synonymous-rate-variation "Synonymous Rate Variation")
* [Selection](../selection-methods/ "Selection")
* Tutorials

  + [CLI Tutorial](../../tutorials/CLI-tutorial/ "CLI Tutorial")
  + [CL Prompt Tutorial](../../tutorials/CL-prompt-tutorial/ "CL Prompt Tutorial")
* Batch Language

  + [Reference](../../hbl-reference/ "Reference")
  + [Library](../../hbl-reference/libv3/ "Library")
* [Resources](../../resources/ "Resources")

## Overview[#](#overview "Permanent link")

HyPhy provides a suite of tools for analyzing phylogenetic sequence data, in particular for inferring the strength of selection from sequence data. In addition, HyPhy features a flexible batch language for implementing and customizing discrete state Markov models in a phylogenetic framework.

## MG94xREV Framework[#](#mg94xrev-framework "Permanent link")

All methods used to infer selection from coding-sequence data rely, to some extent, on the MG94xREV codon model, a generalized extension of the [MG94 model](https://www.ncbi.nlm.nih.gov/pubmed/7968485/) that allows for a full GTR mutation rate matrix. The MG94xREV *transition matrix* **Q** (also known as the *instantaneous rate matrix*), for the substitution from codon  to codon  is given by:

Parameters in this matrix include the following:

* The function  is an indicator function that equals the number of nucleotide differences between codons  and ; for example,  and . Like most other codon models, the MG94xREV model considers only single-nucleotide codon substitutions to be instantaneous.
* refers to the amino-acid encoded by codon .
* represents the *synonymous substitution rate* dS, and  represents the *nonsynonymous substitution rate* dN. Hence, . We refer to the  ratio as simply .
* Together, the mutation model ("REV" component of MG94xREV model) is described by two parameter sets: , comprised of values , and , comprised of values .  values are the *nucleotide mutational biases*, and  are the *equilibrium nucleotide frequencies*.
* Not explicitly seen in this model are the *equilibrium codon frequencies*, denoted . These frequencies are estimated using nine positional nucleotide frequencies for the target nucleotides in each codon substitution. Specifically, HyPhy employs the [CF3x4](http://dx.doi.org/10.1371/journal.pone.0011230) frequency estimator, a corrected version of the common F3x4 estimator (introduced in [Goldman and Yang 1994](https://www.ncbi.nlm.nih.gov/pubmed/7968486)) which accounts for biases in nucleotide composition induced by stop codons.

Most methods  will perform a global MG94xREV fit to optimize branch length and nucleotide substitution parameters before proceeding to hypothesis testing. Several methods ([FEL](./selection-methods/#fel), [FUBAR](./selection-methods/#fubar), and [MEME](./selection-methods/#meme)) additionally pre-fit a GTR nucleotide model to the data, using the estimated parameters as starting values for the global MG94xREV fit, as a computational speed-up. Resulting branch length and nucleotide substitution parameters are subsequently used as initial parameter values during model fitting for hypothesis testing.

## Synonymous Rate Variation[#](#synonymous-rate-variation "Permanent link")

A key component of HyPhy methods is the inclusion of *synonymous rate variation*. In other words, dS is allowed to vary across sites and/or branches, depending on the specific method. [This paper](https://doi.org/10.1093/molbev/msi232) provides a detailed analysis demonstrating why incorporating synonymous rate variation into positive selection inference is likely beneficial. Importantly, this consideration of synonymous rate variation stands in contrast to methods implemented in, for example, [PAML](https://doi.org/10.1093/molbev/msm088) where dS is constrained to equal 1.

HyPhy development has received support from the NIH ([R01GM151683](https://projectreporter.nih.gov/project_info_details.cfm?aid=10729148),
[U01GM110749](https://projectreporter.nih.gov/project_info_details.cfm?aid=9102131),
[U24AI183870](https://reporter.nih.gov/project-details/10914501),
[R01GM093939](https://reporter.nih.gov/project-details/10914501)), and the NSF ([2027196](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2027196),
[2419522](https://www.nsf.gov/awardsearch/showAward?AWD_ID=2419522)).