1. [Captus](/captus.docs/) >
2. [Assembly](/captus.docs/assembly/) >
3. [Assemble](/captus.docs/assembly/assemble/) >
4. HTML Report

* [Concept](#concept)
* [Contents](#contents)
  + [1. Summary Table](#1-summary-table)
  + [2. Visual Stats](#2-visual-stats)
  + [3. Length Distribution](#3-length-distribution)
  + [4. Depth Distribution](#4-depth-distribution)

# HTML Report

## Concept

---

**No successful marker extractions can be achieved without successful assemblies**. Even though this `assemble` module offers presets tuned for different data types, it is recommendable to repeat this step some times with different parameters to find optimal settings for your own data.

`Captus` assists you in this tedious process by automatically generating a useful report for assembly evaluation.
Just open `captus-assemble_report.html` with your browser (internet connection required) to get general assembly statistics across all your samples!

Tip

* The entire report is based on data stored in the following three files:

  + [`captus-assemble.assembly_stats.tsv`](/captus.docs/assembly/assemble/output/#14-captus-assemble_assembly_statstsv)
  + [`captus-assemble.depth_stats.tsv`](/captus.docs/assembly/assemble/output/#15-captus-assemble_depth_statstsv)
  + [`captus-assemble.length_stats.tsv`](/captus.docs/assembly/assemble/output/#16-captus-assemble_length_statstsv)
* All tables and plots in the report are interactive powered by [`Plotly`](https://plotly.com/python).
  Visit the following sites once to take full advantage of its interactivity:

  + <https://plotly.com/chart-studio-help/getting-to-know-the-plotly-modebar>
  + <https://plotly.com/chart-studio-help/zoom-pan-hover-controls>

## Contents

---

### 1. Summary Table

This table shows the general assembly statistics for each sample.
All values shown in this table are calculated **after** filtering by GC content ([–max\_contig\_gc](/captus.docs/assembly/assemble/options/#--max_contig_gc)) and/or depth ([–min\_contig\_depth](/captus.docs/assembly/assemble/options/#--min_contig_depth)).

Features:

* Switch the `Sort by` dropdown to re-sort the table by any column value.
* Cells are color-coded according to value (high = green; low = pink).

Description of each column

| Column | Description | Unit |
| --- | --- | --- |
| **Sample** | Sample name | - |
| **#Contigs** | Number of contigs | - |
| **Total Length** | Total length of all contigs | bp |
| **Shortest Contig** | Shortest contig length | bp |
| **Longest Contig** | Longest contig length | bp |
| **N50** | Weighted average of contig lengths that 50% of total assembly length consists of contigs over this length | bp |
| **L50** | Least number of contigs that contain 50% of total assembly length | - |
| **GC Content** | Overall GC content | % |
| **Mean Depth** | Mean contig depth | x |

---

### 2. Visual Stats

In addition to the general statistics shown in the `Summary Table`, this plot shows more detailed statistics before and after filtering for each sample as a bar graph.

Features:

* Switch the dropdown at the *x*-axis to change the variable to show.
* Click on the legend to toggle hide/show of each data series (only applicable to some variables).

Description of each variable

| Variablea | Description | Unit |
| --- | --- | --- |
| **#Contigs** | Number of contigs | - |
| **Total Length** | Total length of all contigs | bp |
| **Shortest Contig** | Shortest contig length | bp |
| **Longest Contig** | Longest contig length | bp |
| **N50** | Weighted average of contig lengths that 50% of total assembly length consists of contigs over this length | bp |
| **N75** | Weighted average of contig lengths that 75% of total assembly length consists of contigs over this length | bp |
| **L50** | Least number of contigs that contain 50% of total assembly length | - |
| **L75** | Least number of contigs that contain 75% of total assembly length | - |
| **Mean Length** | Mean contig length | bp |
| **Median Length** | Median contig length | bp |
| **Contig Breakdown by Length** | Percentage of contigs over 1, 2, 5, 10, 20, and 50 kbp in total number of contigs | % |
| **Length Breakdown by Contig Length** | Percentage of contigs over 1, 2, 5, 10, 20, and 50 kbp in total length of contigs | % |
| **GC Content** | Overall GC content | % |
| **Mean Depth** | Mean contig depth | x |
| **Median Depth** | Median contig depth | x |

---

### 3. Length Distribution

This plot shows the distribution of contig lengths before and after filtering for each sample as a heatmap.

Feature:

* Switch the `Variable` dropdown at the colorscale to change the variable to show.

Description of each variable

| Variable | Description | Unit |
| --- | --- | --- |
| **Length** | Total contig length in the bin | bp |
| **Fraction** | (Total contig length in the bin) / (Total assembly length) \* 100 | % |
| **#Contigs** | Number of contigs in the bin | - |

---

### 4. Depth Distribution

This plot shows the distribution of contig depths before and after filtering for each sample as a heatmap.

Feature:

* Switch the `Variable` dropdown at the colorscale to change the variable to show.

Description of each variable

| Variable | Description | Unit |
| --- | --- | --- |
| **Length** | Total contig length in the bin | bp |
| **Fraction** | (Total contig length in the bin) / (Total assembly length) \* 100 | % |
| **#Contigs** | Number of contigs in the bin | - |

---

Created by [Gentaro Shigita](https://edgardomortiz.github.io/captus.docs/more/credits/#gentaro-shigita) (11.08.2021)
Last modified by [Gentaro Shigita](https://edgardomortiz.github.io/captus.docs/more/credits/#gentaro-shigita) (23.12.2024)

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