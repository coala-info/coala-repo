1. [Captus](/captus.docs/) >
2. [Assembly](/captus.docs/assembly/) >
3. [Extract](/captus.docs/assembly/extract/) >
4. HTML Report

* [Concept](#concept)
* [Example](#example)
* [Features](#features)
  + [1. Hover information](#1-hover-information)
  + [2. `Variable` dropdown](#2-variable-dropdown)
  + [3. `Sort by Value` dropdown](#3-sort-by-value-dropdown)

# HTML Report

## Concept

---

The output from this `extract` module, such as **how many loci are recovered, in how many samples, and to what extent, would be the most direct indication of whether your analysis is successful or not**, and thus would be of most interest to many users.
However, collecting, summarizing, and visualizing such important information can be backbreaking, especially in a phylo"genomic" project which typically employs hundreds or even thousands of samples and loci.

Don’t worry, `Captus` automatically generates an informative report!
Open `captus-extract_report.html` with your browser (internet connection required) to explore your extraction result at various scales, from the global level to the single sample or single locus level.

Tip

* The entire report is based on data stored in [`captus-extract_stats.tsv`](/captus.docs/assembly/extract/output/#26-captus-extract_statstsv).
* All tables and plots in the report are interactive powered by [`Plotly`](https://plotly.com/python).
  Visit the following sites once to take full advantage of its interactivity:

  + <https://plotly.com/chart-studio-help/getting-to-know-the-plotly-modebar>
  + <https://plotly.com/chart-studio-help/zoom-pan-hover-controls>

## Example

---

Here is a small example of the report you can play with!
The heatmap shows a extraction result of the `Angiosperms353` ([Johnson *et al*., 2019](https://doi.org/10.1093/sysbio/syy086)) loci from targeted-capture data of four plant species.
The blue bars along with *x*- and *y*-axes indicate how many loci are recovered in each sample and how many samples each locus is recovered in, respectively.

Note

* When your result contains more than one marker type, the report will include separate plots for each marker type.
* For loci with more than one copy found in a sample, information on best hit (hit with the highest `weighted score`) will be shown.
* Information on loci with no samples recovered and samples with no loci recovered will not be shown.

## Features

---

### 1. Hover information

Hover mouse cursor over the heatmap to see detailed information about each single data point.

List of the information to be shown

| Field | Description | Unit |
| --- | --- | --- |
| **Sample** | Sample name | - |
| **Marker type** | Marker type (`NUC` = Nuclear proteins; `PTD` = Plastidial proteins; `MIT` = Mitochondrial proteins; `DNA` = Miscellaneous DNA markers; `CLR` = Cluster-derived DNA markers) | - |
| **Locus** | Locus name | - |
| **Ref name** | Reference sequence name selected | - |
| **Ref coords** | Matched coordinates with respect to the reference sequence (Consecutive coordinates separated by `,` indicate partial hits on the same contig; coordinates separated by `;` indicate hits on different contigs) | - |
| **Ref type** | Reference sequence format (`nucl` = nucleotides; `prot` = amino acids) | - |
| **Ref len matched** | Total length of `Ref coords` | aa/bp |
| **Total hits (copies)** | Number of hits found (Values greater than 1 imply the presence of paralogs) | - |
| **Recovered length** | Percentage of reference sequence length recovered, calcurated as (`Ref len matched` / Reference sequence length) \* 100 | % |
| **Identity** | Sequence identity of the recovered sequence to the reference sequence | % |
| **Score** | Score inspired by [`Scipio`](https://www.webscipio.org/help/webscipio#setting), calculated as (matches - mismatches) / reference sequence length | - |
| **Weighted score** | Weighted `score` to address multiple reference sequences per locus (for details, read  [Information included in the table](/captus.docs/assembly/extract/output/#26-captus-extract_statstsv)) | - |
| **Hit length** | Length of sequence recovered | bp |
| **CDS length** | Total length of coding sequences (CDS) recovered (always `NA` when the `ref_type` is `nucl`) | bp |
| **Intron length** | Total length of introns recovered (always `NA` when the `ref_type` is `nucl`) | bp |
| **Flanking length** | Total length of flanking sequences recovered | bp |
| **Number of frameshifts** | Number of corrected frameshifts in the extracted sequence (always `0` when `ref_type` is `nucl`) | - |
| **Position of frameshifts** | Positions of corrected frameshifts in the extracted sequence (`NA` when no frameshift is detected or `ref_type` is `nucl`) | - |
| **Contigs in best hit** | Number of contigs used to assemble the best hit | - |
| **Best hit L50** | Least number of contigs in best hit that contain 50% of the best hit’s recovered length | - |
| **Best hit L90** | Least number of contigs in best hit that contain 90% of the best hit’s recovered length | - |
| **Best hit LG50** | Least number of contigs in best hit that contain 50% of the reference locus length | - |
| **Best hit LG90** | Least number of contigs in best hit that contain 90% of the reference locus length | - |

\* When your data is huge (number of samples \* number of loci > 500k), only `Sample`, `Locus`, and the variable selected in the `Variable` dropdown will be shown.

---

### 2. `Variable` dropdown

Switch this dropdown to change the variable to be shown as a heatmap among the following options:

| Variable | Description | Unit |
| --- | --- | --- |
| **Recovered Length** | Percentage of reference sequence length recovered | % |
| **Identity** | Sequence identity of the recovered sequence to the reference sequence | % |
| **Total Hits (Copies)** | Number of hits found (Values greater than 1 imply the presence of paralogs) | - |
| **Score** | Score inspired by [`Scipio`](https://www.webscipio.org/help/webscipio#setting), calculated as (matches - mismatches) / reference sequence length | - |
| **Weighted Score** | Weighted `score` to address multiple reference sequences per locus (for details, read  [Information included in the table](/captus.docs/assembly/extract/output/#26-captus-extract_statstsv)) | - |
| **Number of Frameshifts** | Number of corrected frameshifts in the extracted sequence (always `0` if the reference sequence is in nucleotide) | - |
| **Contigs in Best Hit** | Number of contigs used to assemble the best hit | - |
| **Best Hit L50** | Least number of contigs in best hit that contain 50% of the best hit’s recovered length | - |
| **Best Hit L90** | Least number of contigs in best hit that contain 90% of the best hit’s recovered length | - |
| **Best Hit LG50** | Least number of contigs in best hit that contain 50% of the reference locus length | - |
| **Best Hit LG90** | Least number of contigs in best hit that contain 90% of the reference locus length | - |

---

### 3. `Sort by Value` dropdown

Switch this dropdown to change the sorting manner of each axis as follow:

| Label | Locus (*x*-axis) | Sample (*y*-axis) |
| --- | --- | --- |
| **None** | Sort by name | Sort by name |
| **Mean X** | Sort by **mean** value | Sort by name |
| **Mean Y** | Sort by name | Sort by **mean** value |
| **Mean Both** | Sort by **mean** value | Sort by **mean** value |
| **Total X** | Sort by **total** value | Sort by name |
| **Total Y** | Sort by name | Sort by **total** value |
| **Total Both** | Sort by **total** value | Sort by **total** value |

---

Created by [Gentaro Shigita](https://edgardomortiz.github.io/captus.docs/more/credits/#gentaro-shigita) (11.08.2021)
Last modified by [Gentaro Shigita](https://edgardomortiz.github.io/captus.docs/more/credits/#gentaro-shigita) (16.09.2022)

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