1. [Captus](/captus.docs/) >
2. [Assembly](/captus.docs/assembly/) >
3. [Clean](/captus.docs/assembly/clean/) >
4. HTML Report

* [Concept](#concept)
* [Contents](#contents)
  + [1. Summary Table](#1-summary-table)
  + [2. Stats on Reads/Bases](#2-stats-on-readsbases)
  + [3. Per Base Quality](#3-per-base-quality)
  + [4. Per Read Quality](#4-per-read-quality)
  + [5. Read Length Distribution](#5-read-length-distribution)
  + [6. Per Base Nucleotide Content](#6-per-base-nucleotide-content)
  + [7. Per Read GC Content](#7-per-read-gc-content)
  + [8. Sequence Duplication Level](#8-sequence-duplication-level)
  + [9. Adaptor Content](#9-adaptor-content)

# HTML Report

## Concept

---

**Proper cleaning is the first step to perform proper analyses** on high-throughput sequencing data.
To assess the quality of raw reads and how it is improved by the cleaning, the `clean` module internally runs the famous quality check program, [`FastQC`](https://www.bioinformatics.babraham.ac.uk/projects/fastqc), or its faster emulator, [`Falco`](https://github.com/smithlabcode/falco), on the reads before and after cleaning.
Although both programs generate informative reports, they are in separate files for each sample, each read direction (for paired-end), and before and after cleaning.
This makes it tedious to review every report, and can lead to overlook some serious problems, such as residual low-quality bases or adaptor sequences, contamination of different samples, and improper setting of cleaning parameters.

`Captus` summarizes the information in those disparate reports into a single HTML file. All you need to do is open `captus-clean_report.html` with your browser (internet connection required) to get a quick overview on all your samples, both reads (for paired-end), and before and after cleaning!

Tip

* The entire report is based on tables stored in the [`03_qc_extras`](/captus.docs/assembly/clean/output/#6-03_qc_extras) directory.
* All tables and plots in the report are interactive powered by [`Plotly`](https://plotly.com/python).
  Visit the following sites once to take full advantage of its interactivity:

  + <https://plotly.com/chart-studio-help/getting-to-know-the-plotly-modebar>
  + <https://plotly.com/chart-studio-help/zoom-pan-hover-controls>

## Contents

---

The report comprises the following nine sections:

* [Concept](#concept)
* [Contents](#contents)
  + [1. Summary Table](#1-summary-table)
  + [2. Stats on Reads/Bases](#2-stats-on-readsbases)
  + [3. Per Base Quality](#3-per-base-quality)
  + [4. Per Read Quality](#4-per-read-quality)
  + [5. Read Length Distribution](#5-read-length-distribution)
  + [6. Per Base Nucleotide Content](#6-per-base-nucleotide-content)
  + [7. Per Read GC Content](#7-per-read-gc-content)
  + [8. Sequence Duplication Level](#8-sequence-duplication-level)
  + [9. Adaptor Content](#9-adaptor-content)

A brief description and interactive example of each section is given below.
By switching the tabs at the top of each plot, you can compare the plot produced by `Captus` with the corresponding plot from [`FastQC`](https://www.bioinformatics.babraham.ac.uk/projects/fastqc).

---

### 1. Summary Table

This table shows general cleaning statistics for each sample.

Features:

* Switch the `Sort by` dropdown to re-sort the table by any column value.
* Cells are color-coded according to value (high = green; low = pink).

Captus
FastQC

![fastqc_basic_statistics](/captus.docs/images/fastqc_basic_statistics.png?height=200px)

Description of each column

| Column | Description | Unit |
| --- | --- | --- |
| **Sample** | Sample name | - |
| **Input Reads** | Number of reads before cleaning | - |
| **Input Bases** | Number of bases before cleaning | bp |
| **Output Reads** | Number of reads passed cleaning | - |
| **Output Reads%** | = (`Output Reads` / `Input Reads`) \* 100 | % |
| **Output Bases** | Number of bases passed cleaning | bp |
| **Output Bases%** | = (`Output Bases` / `Input Bases`) \* 100 | % |
| **Mean Read Length%** | = (Mean read length after cleaning / Mean read length before cleaning) \* 100 | % |
| **≥Q20 Reads%** | Percentage of reads with mean Phred quality score over 20 after cleaning | % |
| **≥Q30 Reads%** | Percentage of reads with mean Phred quality score over 30 after cleaning | % |
| **GC%** | Mean GC content in the reads after cleaning | % |
| **Adapter%** | Percentage of reads containing adaptor sequences before cleaning | % |

---

### 2. Stats on Reads/Bases

`Captus` cleans reads through two consecutive rounds of adaptor trimming (`Round1`, `Round2`) followed by quality trimming and filtering.
This plot shows changes in the number of reads (left panel) and bases (right panel) at each step of the cleaning process.

Features:

* Switch the buttons at the top to choose whether to show counts or percentages.
* Samples are sorted by the number or percentage of bases passed cleaning.
* Click on the legend to toggle hide/show of each data series.

Captus
FastQC

There is no corresponding plot.

---

### 3. Per Base Quality

This plot shows the range of Phred quality score at each position in the reads before and after cleaning.
For more details, read  [FastQC documentation](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/2%20Per%20Base%20Sequence%20Quality.html).

Feature:

* Switch the dropdown at the top to change the variable to show, these variables represent the elements of the boxplots in the `FastQC` report.

Captus
FastQC

![fastqc_per_base_quality](/captus.docs/images/fastqc_per_base_quality.png?height=300px)

---

### 4. Per Read Quality

This plot shows the distribution of mean Phred quality score for each read before and after cleaning.
For more details, read  [FastQC documentation](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/3%20Per%20Sequence%20Quality%20Scores.html).

Captus
FastQC

![fastqc_per_sequence_quality](/captus.docs/images/fastqc_per_sequence_quality.png?height=300px)

---

### 5. Read Length Distribution

This plot shows the distribution of read lengths before and after cleaning.
For more details, read  [FastQC documentation](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/7%20Sequence%20Length%20Distribution.html).

Captus
FastQC

![fastqc_sequence_length_distribution](/captus.docs/images/fastqc_sequence_length_distribution.png?height=300px)

---

### 6. Per Base Nucleotide Content

This plot shows the composition of each nucleotide (A, T, G, C) at each position in the reads before and after cleaning.
If a particular nucleotide is overrepresented at a certain position in the reads, you will see the color corresponding to that nucleotide; otherwise, the plot will be a uniform grayish color.
For more details, read  [FastQC documentation](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/4%20Per%20Base%20Sequence%20Content.html).

Captus
FastQC

![fastqc_per_base_sequence_content](/captus.docs/images/fastqc_per_base_sequence_content.png?height=300px)

---

### 7. Per Read GC Content

This plot shows the frequency of GC content in the reads before and after cleaning.
Broader or bimodal peaks may indicate contamination with DNA from different organisms.
For more details, read  [FastQC documentation](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/5%20Per%20Sequence%20GC%20Content.html).

Captus
FastQC

![fastqc_per_sequence_gc_content](/captus.docs/images/fastqc_per_sequence_gc_content.png?height=300px)

---

### 8. Sequence Duplication Level

This plot shows the percentage of sequences with different degrees of duplication before and after cleaning.
For more details, read  [FastQC documentation](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/8%20Duplicate%20Sequences.html).

Feature:

* Click on the legend to toggle hide/show of each data series.

Captus
FastQC

![fastqc_duplication_levels](/captus.docs/images/fastqc_duplication_levels.png?height=300px)

---

### 9. Adaptor Content

This plot shows the cumulative adaptor content at each position in the reads before and after cleaning.
For more details, read  [FastQC documentation](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/Help/3%20Analysis%20Modules/10%20Adapter%20Content.html).

Captus
FastQC

![fastqc_adaptor_content](/captus.docs/images/fastqc_adaptor_content.png?height=300px)

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