# Toggle navigation ![](data:image/png;base64... "MultiQC") v0.9.dev0 (3f5c6b4)

# Slamdunk timeseries example QA

* [General Stats](#general_stats)
* [Slamdunk](#slamdunk)
  + [Filter statistics](#slamdunk_filtering)
  + [PCA (T>C based)](#slamdunk_PCA)
  + [Conversion rates per UTR](#slamdunk_utr_rates)
  + [Conversion rates per read](#slamdunk_overall_rates)
  + [Non T>C mutations over read positions](#slamdunk_nontcperreadpos)
  + [T>C conversions over read positions](#slamdunk_tcperreadpos)
  + [Non T>C mutations over UTR positions](#slamdunk_nontcperutrpos)
  + [T>C conversions over UTR positions](#tcperutrpos)

[Toolbox](#mqc_cols "Open Toolbox")

### MultiQC Toolbox

#### Apply Highlight Samples

+

Regex mode off
help
 Clear

#### Apply Rename Samples

+

[Click here for bulk input.](#mqc_renamesamples_bulk_collapse)

Paste two columns of a tab-delimited table here (eg. from Excel).

First column should be the old name, second column the new name.

Add

Regex mode off
help
 Clear

#### Apply Show / Hide Samples

Hide matching samples

Show only matching samples

+

Regex mode off
help
 Clear

#### Export Plots

* [Images](#mqc_image_download)
* [Data](#mqc_data_download)

px

px

[x]  Aspect ratio

PNG
JPEG
SVG

Plot scaling

X

Download the raw data used to create the plots in this report below:

Format:

Tab-separated
Comma-separated
JSON

Note that additional data was saved in `multiqc_data` when this report was generated.

---

##### Choose Plots

 All
 None

---

   Download Plot Images

If you use plots from MultiQC in a publication or presentation, please cite:

> **MultiQC: Summarize analysis results for multiple tools and samples in a single report**
> *Philip Ewels, Måns Magnusson, Sverker Lundin and Max Käller*
> Bioinformatics (2016)
> doi: [10.1093/bioinformatics/btw354](http://dx.doi.org/10.1093/bioinformatics/btw354)
> PMID: [27312411](http://www.ncbi.nlm.nih.gov/pubmed/27312411)

#### Save Settings

You can save the toolbox settings for this report to the browser.

 Save

---

#### Load Settings

Choose a saved report profile from the dropdown box below:

[ select ]

Load
 Delete

#### About MultiQC

This report was generated using MultiQC, version 0.9.dev0 (3f5c6b4)

You can see a YouTube video describing how to use MultiQC reports here:
[https://youtu.be/qPbIlO\_KWN0](https://youtu.be/qPbIlO_KWN0?list=PLIA2-lqNuhvFGAsB92N0v7Qi5xCxCNsYM)

For more information about MultiQC, including other videos and
extensive documentation, please visit [http://multiqc.info](http://multiqc.info/?ref=mqc_report)

You can report bugs, suggest improvements and find the source code for MultiQC on GitHub:
<https://github.com/ewels/MultiQC>

MultiQC is published in Bioinformatics:

> **MultiQC: Summarize analysis results for multiple tools and samples in a single report**
> *Philip Ewels, Måns Magnusson, Sverker Lundin and Max Käller*
> Bioinformatics (2016)
> doi: [10.1093/bioinformatics/btw354](http://dx.doi.org/10.1093/bioinformatics/btw354)
> PMID: [27312411](http://www.ncbi.nlm.nih.gov/pubmed/27312411)

# [![](data:image/png;base64... "MultiQC")](http://multiqc.info)

# Slamdunk timeseries example QA

A modular tool to aggregate results from bioinformatics analyses across many samples into a single report.

Report generated on 2016-12-29, 18:12 based on data in:
`/clustertmp/slamdunk/timeseries_example_v0.2.2-dev`

---

×
don't show again

**Welcome!** Not sure where to start?
[Watch a tutorial video](https://www.youtube.com/watch?v=qPbIlO_KWN0)
  *(6:06)*

## General Statistics

 Copy table

 Configure Columns

 Sort by highlight
Showing 6/6 rows and 4/4 columns.

| Sample Name | Counted | Retained | Mapped | Sequenced |
| --- | --- | --- | --- | --- |
| day1\_timepoint\_rep1 | 17.69 M | 12.28 M | 18.53 M | 20.70 M |
| day1\_timepoint\_rep2 | 19.68 M | 11.44 M | 17.75 M | 20.36 M |
| day1\_timepoint\_rep3 | 25.15 M | 14.41 M | 21.12 M | 23.77 M |
| zero\_timepoint\_rep1 | 24.41 M | 13.00 M | 18.69 M | 21.00 M |
| zero\_timepoint\_rep2 | 20.60 M | 11.66 M | 17.54 M | 19.61 M |
| zero\_timepoint\_rep3 | 26.93 M | 14.46 M | 21.77 M | 27.57 M |

×

#### General Statistics: Columns

Uncheck the tick box to hide columns. Click and drag the handle on the left to change order.

Show All
Show None

| Sort | Visible | Group | Column | Description | ID | Scale |
| --- | --- | --- | --- | --- | --- | --- |
| || | [x] | Slamdunk | Counted | # reads counted within 3'UTRs | `counted` | read\_count |
| || | [x] | Slamdunk | Retained | # retained reads after filtering | `retained` | read\_count |
| || | [x] | Slamdunk | Mapped | # mapped reads | `mapped` | read\_count |
| || | [x] | Slamdunk | Sequenced | # sequenced reads | `sequenced` | read\_count |

Close

## Slamdunk

[Slamdunk](http://t-neumann.github.io/slamdunk/) is a tool to analyze SLAMSeq data.

### Filter statistics

This table shows the number of reads filtered with each filter criterion during filtering phase of slamdunk.

 Copy table

 Configure Columns

 Sort by highlight
Showing 6/6 rows and 5/5 columns.

| Sample Name | Mapped | Multimap-Filtered | NM-Filtered | Identity-Filtered | MQ-Filtered |
| --- | --- | --- | --- | --- | --- |
| day1\_timepoint\_rep1 | 18.53 M | 2.20 M | 0.00 M | 4.05 M | 0.00 M |
| day1\_timepoint\_rep2 | 17.75 M | 2.58 M | 0.00 M | 3.73 M | 0.00 M |
| day1\_timepoint\_rep3 | 21.12 M | 3.08 M | 0.00 M | 3.63 M | 0.00 M |
| zero\_timepoint\_rep1 | 18.69 M | 2.96 M | 0.00 M | 2.73 M | 0.00 M |
| zero\_timepoint\_rep2 | 17.54 M | 2.95 M | 0.00 M | 2.93 M | 0.00 M |
| zero\_timepoint\_rep3 | 21.77 M | 3.70 M | 0.00 M | 3.62 M | 0.00 M |

×

#### slamdunk\_filtering\_table: Columns

Uncheck the tick box to hide columns. Click and drag the handle on the left to change order.

Show All
Show None

| Sort | Visible | Group | Column | Description | ID | Scale |
| --- | --- | --- | --- | --- | --- | --- |
| || | [x] | Slamdunk | Mapped | # mapped reads | `mapped` | read\_count |
| || | [x] | Slamdunk | Multimap-Filtered | # multimap-filtered reads | `multimapper` | read\_count |
| || | [x] | Slamdunk | NM-Filtered | # NM-filtered reads | `nmfiltered` | read\_count |
| || | [x] | Slamdunk | Identity-Filtered | # identity-filtered reads | `idfiltered` | read\_count |
| || | [x] | Slamdunk | MQ-Filtered | # MQ-filtered reads | `mqfiltered` | read\_count |

Close

---

### PCA (T>C based)

This plot shows the principal components of samples based
on the distribution of reads with T>C conversions within UTRs
(see the [slamdunk docs](http://slamdunk.readthedocs.io/en/latest/Alleyoop.html#summary)).

loading..

---

### Conversion rates per UTR

This plot shows the individual conversion rates for all UTRs
(see the [slamdunk docs](http://slamdunk.readthedocs.io/en/latest/Alleyoop.html#utrrates)).

loading..

---

### Conversion rates per read

This plot shows the individual conversion rates over all reads.
It shows these conversion rates strand-specific: This means for a properly labelled
sample you would see a T>C excess on the plus-strand and an A>G excess on the minus strand
(see the [slamdunk docs](http://slamdunk.readthedocs.io/en/latest/Alleyoop.html#rates)).

Plus Strand +
Minus Strand -

loading..

---

### Non T>C mutations over read positions

This plot shows the distribution of non T>C mutations across read positions
(see the [slamdunk docs](http://slamdunk.readthedocs.io/en/latest/Alleyoop.html#tcperreadpos)).

Forward reads +
Reverse reads -

loading..

---

### T>C conversions over read positions

This plot shows the distribution of T>C conversions across read positions
(see the [slamdunk docs](http://slamdunk.readthedocs.io/en/latest/Alleyoop.html#tcperreadpos)).

Forward reads +
Reverse reads -

loading..

---

### Non T>C mutations over UTR positions

This plot shows the distribution of non T>C mutations across UTR positions for the last 200 bp from the 3' UTR end
(see the [slamdunk docs](http://slamdunk.readthedocs.io/en/latest/Alleyoop.html#tcperutrpos)).

UTRs on plus strand
UTRs on minus strand

loading..

---

### T>C conversions over UTR positions

This plot shows the distribution of T>C conversions across UTR positions for the last 200 bp from the 3' UTR end
(see the [slamdunk docs](http://slamdunk.readthedocs.io/en/latest/Alleyoop.html#tcperutrpos)).

UTRs on plus strand
UTRs on minus strand

loading..

[![](data:image/png;base64...)](http://www.scilifelab.se/)
**[MultiQC v0.9.dev0 (3f5c6b4)](http://multiqc.info)**
- Written by [Phil Ewels](http://phil.ewels.co.uk),
available on [GitHub](https://github.com/ewels/MultiQC).

This report uses [HighCharts](http://www.highcharts.com/),
[jQuery](https://jquery.com/),
[jQuery UI](https://jqueryui.com/),
[Bootstrap](http://getbootstrap.com/),
[chroma.js](https://github.com/gka/chroma.js),
[FileSaver.js](https://github.com/eligrey/FileSaver.js) and
[clipboard.js](https://clipboardjs.com/).

×

### Regex Help

Toolbox search strings can behave as regular expressions (regexes). Click a button below to see an example of it in action. Try modifying them yourself in the text box.

`^` (start of string)
`$` (end of string)
`[]` (character choice)
`\d` (shorthand for `[0-9]`)
`\w` (shorthand for `[0-9a-zA-Z_]`)
`.` (any character)
`\.` (literal full stop)
`()` `|` (group / separator)
`*` (prev char 0 or more)
`+` (prev char 1 or more)
`?` (prev char 0 or 1)
`{}` (char num times)
`{,}` (count range)

Close