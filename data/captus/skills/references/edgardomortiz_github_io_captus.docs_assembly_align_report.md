1. [Captus](/captus.docs/) >
2. [Assembly](/captus.docs/assembly/) >
3. [Align](/captus.docs/assembly/align/) >
4. HTML Report

* [Concept](#concept)
* [Contents](#contents)
  + [1. Stats Comparison at Each Processing Step](#1-stats-comparison-at-each-processing-step)
  + [2. Bivariate Relationships and Distributions](#2-bivariate-relationships-and-distributions)
  + [3. Stats Per Sample](#3-stats-per-sample)

# HTML Report

## Concept

---

This `align` module generates several sets of alignments that are ready-to-use in popular phylogenetic tree inference programs (e.g., [`IQ-TREE`](http://www.iqtree.org), [`RAxML`](https://cme.h-its.org/exelixis/web/software/raxml), [`ASTRAL`](https://github.com/smirarab/ASTRAL)).
Each alignment set differs from one another in the following four respects: 1) whether they are trimmed, 2) which [paralog filter](/captus.docs/assembly/align/options/#paralog-filtering)  is applied, 3) whether they contain reference sequences, and 4) in which [formats](/captus.docs/assembly/align/options/#-f---formats) .
Thus, **it is important to understand the differences between each alignment set and carefully evaluate their quality in order to decide which alignment set to use for subsequent analyses**.

Open the report `captus-align_report.html` with your browser (internet connection required) to explore and compare general alignment statistics for each locus and each sample!

Tips

* The entire report is based on data stored in the following two files:

  + [`captus-align.alignments.tsv`](/captus.docs/assembly/align/output/#17-captus-align_alignmentstsv)
  + [`captus-align.samples.tsv`](/captus.docs/assembly/align/output/#18-captus-align_samplestsv)
* All tables and plots in the report are interactive powered by [`Plotly`](https://plotly.com/python).
  Visit the following sites once to take full advantage of its interactivity:

  + <https://plotly.com/chart-studio-help/getting-to-know-the-plotly-modebar>
  + <https://plotly.com/chart-studio-help/zoom-pan-hover-controls>

## Contents

---

### 1. Stats Comparison at Each Processing Step

This plot shows distributions of general alignment statistics at each processing step.

Features:

* Switch the `Marker Type` dropdown to change the marker type
  (appeared only when you have more than one marker type).
* Switch the dropdown on the *x*-axis to change the variable to show.
* Click on the legend to toggle hide/show of each format.

Description of each processing step

Depending on [`--filter_method`](/captus.docs/assembly/align/options/#--filter_method) argument, you will have up to 12 processing steps as follows:

| Processing step (Path to alignments) | Trimmed | Paralog filter | With references |
| --- | --- | --- | --- |
| **02\_untrimmed/01\_unfiltered\_w\_refs** | No | None | **Yes** |
| **02\_untrimmed/02\_naive\_w\_refs** | No | **Naive** | **Yes** |
| **02\_untrimmed/03\_informed\_w\_refs** | No | **Informed** | **Yes** |
| **02\_untrimmed/01\_unfiltered** | No | None | No |
| **02\_untrimmed/02\_naive** | No | **Naive** | No |
| **02\_untrimmed/03\_informed** | No | **Informed** | No |
| **03\_trimmed/01\_unfiltered\_w\_refs** | **Yes** | None | **Yes** |
| **03\_trimmed/02\_naive\_w\_refs** | **Yes** | **Naive** | **Yes** |
| **03\_trimmed/03\_informed\_w\_refs** | **Yes** | **Informed** | **Yes** |
| **03\_trimmed/01\_unfiltered** | **Yes** | None | No |
| **03\_trimmed/02\_naive** | **Yes** | **Naive** | No |
| **03\_trimmed/03\_informed** | **Yes** | **Informed** | No |

For more explanations, read  [Output Files](/captus.docs/assembly/align/output/).

Description of each variable

| Variable | Description | Unit |
| --- | --- | --- |
| **Sequences** | Number of sequences in the alignment | - |
| **Samples** | Number of samples in the alignment | - |
| **Sequences Per Sample** | = `Sequences` / `Samples` | - |
| **Alignment Length** | Length of the alignment | aa/bp |
| **Informative Sites** | Number of parsimony-informative sites that have at least two different characters and at least two of which appear in at least two sequences | - |
| **Informativeness** | = (`Informative Sites` / `Alignment Length`) \* 100 | % |
| **Uninformative Sites** | = `Alignment Length` - `Informative Sites` = `Constant Sites` + `Singleton Sites` | - |
| **Constant Sites** | Number of invariant sites in the alignment | - |
| **Singleton Sites** | Number of variable sites where one character appears in multiple sequences while other characters appear in only one sequence | - |
| **Patterns** | Number of unique sites that have different character configurations | - |
| **Mean Pairwise Identity** | Mean pairwise sequence identity in the alignment | % |
| **Missingness** | Proportion of `-`, `N`, `X`, `?`, `.`, and `~` in the alignment | % |
| **GC Content** | GC content of the alignment (inapplicable to `AA` format) | % |
| **GC Content at 1st Codon Position** | GC content at 1st codon position in the alignment (only applicable to `NT` format) | % |
| **GC Content at 2nd Codon Position** | GC content at 2nd codon position in the alignment (only applicable to `NT` format) | % |
| **GC Content at 3rd Codon Position** | GC content at 3rd codon position in the alignment (only applicable to `NT` format) | % |

For more explanation about sites and patterns, see IQ-TREE’s FAQ:  [What are the differences between alignment columns/sites and patterns?](http://www.iqtree.org/doc/Frequently-Asked-Questions#how-does-iq-tree-treat-identical-sequences)

---

### 2. Bivariate Relationships and Distributions

This plot shows general alignment statistics for each alignment (locus).
When your result contains more than one marker type, the report will include separate plots for each marker type.

Features:

* Switch the `Processing Step` dropdown to change the processing step to show the statistics.
* Switch the dropdowns on the *x*- and *y*- axes to change variables to plot on each axis.
* Click on the legend to toggle hide/show of each format.

Description of each processing step

Depending on [`--filter_method`](/captus.docs/assembly/align/options/#--filter_method) argument, you will have up to 12 processing steps as follows:

| Processing step (Path to alignments) | Trimmed | Paralog filter | With references |
| --- | --- | --- | --- |
| **02\_untrimmed/01\_unfiltered\_w\_refs** | No | None | **Yes** |
| **02\_untrimmed/02\_naive\_w\_refs** | No | **Naive** | **Yes** |
| **02\_untrimmed/03\_informed\_w\_refs** | No | **Informed** | **Yes** |
| **02\_untrimmed/01\_unfiltered** | No | None | No |
| **02\_untrimmed/02\_naive** | No | **Naive** | No |
| **02\_untrimmed/03\_informed** | No | **Informed** | No |
| **03\_trimmed/01\_unfiltered\_w\_refs** | **Yes** | None | **Yes** |
| **03\_trimmed/02\_naive\_w\_refs** | **Yes** | **Naive** | **Yes** |
| **03\_trimmed/03\_informed\_w\_refs** | **Yes** | **Informed** | **Yes** |
| **03\_trimmed/01\_unfiltered** | **Yes** | None | No |
| **03\_trimmed/02\_naive** | **Yes** | **Naive** | No |
| **03\_trimmed/03\_informed** | **Yes** | **Informed** | No |

For more explanations, read  [Output Files](/captus.docs/assembly/align/output/).

Description of each variable

| Variable | Description | Unit |
| --- | --- | --- |
| **Sequences** | Number of sequences in the alignment | - |
| **Samples** | Number of samples in the alignment | - |
| **Sequences Per Sample** | = `Sequences` / `Samples` | - |
| **Alignment Length** | Length of the alignment | aa/bp |
| **Informative Sites** | Number of parsimony-informative sites that have at least two different characters and at least two of which appear in at least two sequences | - |
| **Informativeness** | = (`Informative Sites` / `Alignment Length`) \* 100 | % |
| **Uninformative Sites** | = `Alignment Length` - `Informative Sites` = `Constant Sites` + `Singleton Sites` | - |
| **Constant Sites** | Number of invariant sites in the alignment | - |
| **Singleton Sites** | Number of variable sites where one character appears in multiple sequences while other characters appear in only one sequence | - |
| **Patterns** | Number of unique sites that have different character configurations | - |
| **Mean Pairwise Identity** | Mean pairwise sequence identity in the alignment | % |
| **Missingness** | Proportion of `-`, `N`, `X`, `?`, `.`, and `~` in the alignment | % |
| **GC Content** | GC content of the alignment (inapplicable to `AA` format) | % |
| **GC Content at 1st Codon Position** | GC content at 1st codon position in the alignment (only applicable to `NT` format) | % |
| **GC Content at 2nd Codon Position** | GC content at 2nd codon position in the alignment (only applicable to `NT` format) | % |
| **GC Content at 3rd Codon Position** | GC content at 3rd codon position in the alignment (only applicable to `NT` format) | % |

For more explanation about sites and patterns, see IQ-TREE’s FAQ:  [What are the differences between alignment columns/sites and patterns?](http://www.iqtree.org/doc/Frequently-Asked-Questions#how-does-iq-tree-treat-identical-sequences)

---

### 3. Stats Per Sample

This plot shows general alignment statistics for each sample.
When your result contains more than one marker type, the report will include separate plots for each marker type.

Features:

* Switch the `Sort Samples by` dropdown to re-sort the *x*-axis by sample name or mean of the variable.
* Switch the dropdown on the *y*-axis to change the variable to show.
* Click on the legend to toggle hide/show of each data series.

Description of each variable

| Variable | Description | Unit |
| --- | --- | --- |
| **Number of Loci** | Number of alignments (loci) containing the sample | - |
| **Mean Ungapped Length** | Mean sequence length of the sample excluding gaps (`-`) | aa/bp |
| **Total Ungapped Length** | Cumulative sequence length of the sample excluding gaps (`-`) | aa/bp |
| **Mean Gaps** | Mean length of internal gaps (`-`) | - |
| **Total Gaps** | Cumulative length of internal gaps (`-`) | - |
| **Mean Ambiguities** | Mean count of ambiguous characters of the sample | - |
| **Mean GC Content** | Mean GC content of the sample (inapplicable to `AA` format) | % |
| **Mean GC Content at 1st Codon Position** | Mean GC content at 1st codon position of the sample (only applicable to `NT` format) | % |
| **Mean GC Content at 2nd Codon Position** | Mean GC content at 2nd codon position of the sample (only applicable to `NT` format) | % |
| **Mean GC Content at 3rd Codon Position** | Mean GC content at 3rd codon position of the sample (only applicable to `NT` format) | % |
| **Mean Copies** | Mean number of sequences per alignment (always `1` for alignments with paralog filter applied) | % |

---

Created by [Gentaro Shigita](https://edgardomortiz.github.io/captus.docs/more/credits/#gentaro-shigita) (11.08.2021)
Last modified by [Gentaro Shigita](https://edgardomortiz.github.io/captus.docs/more/credits/#gentaro-shigita) (17.10.2022)

[![](/captus.docs/images/logo.svg)](/)

Search

* [Home](/captus.docs/)

* [ ] Submenu Basics[Basics](/captus.docs/basics/)
  + [Overview](/captus.docs/basics/overview/)
  + [Installation](/captus.docs/basics/installation/)
  + [Parallelization](/captus.docs/basics/parallelization/)
* [x] Submenu Assembly[Assembly](/captus.docs/assembly/)
  + [x] Submenu Clean[**1.** Clean](/captus.docs/assembly/clean/)
    - [Input Preparation](/captus.docs/assembly/clean/preparation/)
    - [Options](/captus.docs/assembly/clean/options/)
    - [Output Files](/captus.docs/assembly/clean/output/)
    - [HTML Report](/captus.docs/assembly/clean/report/)
  + [x] Submenu Assemble[**2.** Assemble](/captus.docs/assembly/assemble/)
    - [Input Preparation](/captus.docs/assembly/assemble/preparation/)
    - [Options](/captus.docs/assembly/assemble/options/)
    - [Output Files](/captus.docs/assembly/assemble/output/)
    - [HTML Report](/captus.docs/assembly/assemble/report/)
  + [x] Submenu Extract[**3.** Extract](/captus.docs/assembly/extract/)
    - [Input Preparation](/captus.docs/assembly/extract/preparation/)
    - [Options](/captus.docs/assembly/extract/options/)
    - [Output Files](/captus.docs/assembly/extract/output/)
    - [HTML Report](/captus.docs/assembly/extract/report/)
  + [x] Submenu Align[**4.** Align](/captus.docs/assembly/align/)
    - [Options](/captus.docs/assembly/align/options/)
    - [Output Files](/captus.docs/assembly/align/output/)
    - [HTML Report](/captus.docs/assembly/align/report/)
* [Design](/captus.docs/design/)
* [ ] Submenu Tutorials[Tutorials](/captus.docs/tutorials/)
  + [Basic](/captus.docs/tutorials/basic/)
  + [Advanced](/captus.docs/tutorials/advanced/)

More

* [GitHub repo](https://github.com/edgardomortiz/Captus)
* [Credits](/captus.docs/more/credits)

---

* Language
* Theme

  Green
* Clear History

[Download](https://github.com/edgardomortiz/Captus/archive/master.zip)
[Star](https://github.com/edgardomortiz/Captus)
[Fork](https://github.com/edgardomortiz/Captus/fork)

Built with  by [Hugo](https://gohugo.io/)