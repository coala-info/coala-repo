# tripr User Guide

Maria Th. Kotouza1, Katerina Gemenetzi2, Chrysi Galigalidou2, Elisavet Vlachonikola2, Nikolaos Pechlivanis2, Andreas Agathangelidis2, Raphael Sandaltzopoulos3, Pericles A. Mitkas1, Kostas Stamatopoulos2, Anastasia Chatzidimitriou2 and Fotis E. Psomopoulos2\*

1Department of Electrical and Computer Engineering, Aristotle University of Thessaloniki, Thessaloniki, GR
2Institute of Applied Biosciences, Centre for Research and Technology Hellas, Thessaloniki, GR
3Department of Molecular Biology and Genetics, Democritus University of Thrace, Alexandroupolis, GR

\*fpsom@certh.gr

#### 30 October 2025

#### Package

tripr 1.16.0

![](data:image/png;base64...)

# 1 Introduction

`tripr` is a [Bioconductor](http://bioconductor.org) package,
written in [shiny](https://shiny.rstudio.com/) that provides
analytics services on
antigen receptor (B cell receptor immunoglobulin, BcR IG | T cell receptor,
TR) gene sequence data. Every step of the analysis can be
performed interactively, thus not requiring any programming skills. It takes
as input the output files of the
[IMGT/HighV-Quest tool](http://www.imgt.org/HighV-QUEST/home.action).
Users can select to analyze the data from each of the input samples separately,
or the combined data files from all samples and visualize the results
accordingly. Functions for an `R` command-line use are also available.

## 1.1 Installation

`tripr` is distributed as a [Bioconductor](https://www.bioconductor.org/)
package and requires `R` (version “4.2”), which can be installed on any
operating system from [CRAN](https://cran.r-project.org/), and
Bioconductor (version “3.15”).

To install `tripr` package enter the following commands in your `R` session:

```
if (!requireNamespace("BiocManager", quietly = TRUE)) {
    install.packages("BiocManager")
}

BiocManager::install("tripr")

## Check that you have a valid Bioconductor installation
BiocManager::valid()
```

## 1.2 Launching the app

Once `tripr` is successfully installed, it can be loaded as follow:

```
library(tripr)
```

# 2 Running `tripr` as a `shiny` application

In order to start the `shiny` app, please run the following command:

```
tripr::run_app()
```

`tripr` should be opening in a browser (ideally Chrome, Firefox or Opera).
If this does not happen automatically,
please open a browser and navigate to the address shown on the `R` console
(for example, `Listening on http://127.0.0.1:6134`).

## 2.1 Home

In this tab users can import their data by selecting the directory
where the data is stored, by pressing the **Choose directory** button.
The tool takes as input
the 10 output files of the
[IMGT/HighV-Quest tool](http://www.imgt.org/HighV-QUEST/home.action) in text
format (.txt). Users can also
choose only some of the files depending on the type of the downstream analysis.

Note that every sample of the dataset must have its own individual folder and
every sample folder must be in one root folder (See example below). For the
dataset to be selected for upload, this root folder must be selected and
then the button **Load Data** has to be pressed.

![](data:image/png;base64...)

Previous sessions can also be loaded with the **Restore Previous Sessions**
button.

There are 2 options regarding the cell type (**T cell** and **B cell**) as
well as 2
options based on the amount of available data
(**High-** or **Low-Throughput**).
Concerning the latter, the main difference is the application of the
preselection and selection steps. In the case of High-Throughput data, all
filters are applied consequentially (i.e. if a sequence fails >1 selection
criteria, only the first unsatisfied criterion will be reported), whereas
for Low-Throughput data all criteria are applied at the same time.

## 2.2 Preprocessing

`tripr` offers 2 steps of preprocessing:

* **Preselection**: Refers to the cleaning process of the input dataset.
* **Selection**: Refers to the filtering process of the resulting data from
  Preselection process.

### 2.2.1 Preselection

The Preselection process comprises 4 different criteria:

* **Only take into account Functional V-Gene**:
* **Only take into account CDR3 with no Special Characters (X,\*,#,.)**:
* **Only take into account Productive Sequences**:
  Only productive sequences
  (without stop codons and frameshifts) are included in the analysis.
* **Only take into account CDR3 with valid start/end landmarks**:
  Start/End CDR3
  landmarks (anchors) can be customized by the user based on the type of data
  (BcR/TR, heavy/light chain). More than one valid landmark can be used.
  The different letters should be separated with a vertical bar (e.g. F|D).
  Sequences with landmarks other than the chosen ones are excluded from the
  analysis.

![](data:image/png;base64...)

The execution starts when the **Apply** button is pressed.

Users can visualize the results of the preselection (first cleaning) process in
the **Preselection** tab. In the case of multi-sample datasets, results are
provided for each individual sample separately, or for the combined dataset
by scrolling through the **Select Dataset** option.

The output consists of 4 table files:

1. **Summary**: a summary table with both the
   included and excluded sequences for each different criterion
2. **All Data table**: the entire set of data
3. **Clean table**: the sequences that
   meet the preselection criteria and are included in the analysis and
4. **Clean out table**: the excluded sequences.
   The last column of the “Clean out table” refers to the unsatisfied criteria.

The figure below shows an example Clean table from this Tab.
![](data:image/png;base64...)

All 4 tables can be downloaded as text files.

### 2.2.2 Selection

The sequences that passed through the Preselection process (“Clean table”) are
used as input for the data Selection (filtering) process.

This step comprises 6 different filters:

* **V-REGION identity %**:
  Sequences with identity percent to germline that do
  not fall in the range set by the user are excluded from the analysis.
* **Select Specific V Gene**
* **Select Specific J Gene**
* **Select Specific D Gene**

Using the above 3 filters the user can select for sequences that carry one or
more particular V, J and D genes or gene alleles, respectively. Different
genes/gene alleles should be separated with a vertical line (|), e.g.
TRBV11-2|TRBV29-1\*03.

* **Select CDR3 length range**:
  Only sequences with the
  selected CDR3 lengths are included in the analysis.
* **Only select CDR3 containing specific amino-acid sequence**:
  Sequences with the specific CDR3
  amino acid motif provided by the user are included in the analysis.

The execution starts when the **Execute** button is pressed.

![](data:image/png;base64...)

The results of the Selection (filtering) process are presented in the
**Selection** tab.

This process provides 4 output files:

1. **Summary**: a summary table with both the
   included and excluded sequences for each filter
2. **All Data table**: the data
   used as input after the Preselection process
3. **Filter in table**: the
   sequences that passed through the selection filters and
4. **Filter out table**: the excluded sequences. The last column of the
   “Filter out table” refers to the filters that were not passed by each
   individual sequence.

![](data:image/png;base64...)

All the tables can be downloaded as text files.

## 2.3 Pipelines & Step dependencies

Users can select the workflow that they want to apply to their dataset(s).

There are 11 different tools in the pipeline tab. 7 of them can be applied for
both T- and B-cells, while the remaining 4 can be applied *only* for B-cells.

---

**Step Dependencies in Pipeline**

1. In order to apply *Highly Similar Clonotypes computation*,
   *Clonotypes computation* should have been selected previously.
2. In order to apply *Repertoires Extraction*, *Clonotypes computation*
   should have run previously. If *Highly Similar Clonotypes computation* has
   been selected, repertoires will be extracted for both total clonotypes and
   highly similar clonotypes.
3. The *Somatic hypermutation status* is applied using the groups that have
   been selected at *Insert Identity groups*.
4. If both *Alignment* and *Clonotypes computation* have been selected, the
   cluster ID in the alignment table corresponds to the cluster ID in the
   clonotype table. Otherwise, all elements in the “cluster\_ID” column of the
   alignment table are assigned to zero.
5. In order to apply *Alignment* using the *Select top N clonotypes* option,
   *Clonotypes computation* should have run previously.
6. In order to apply *Mutations*, *Alignment* should have run previously,
   using the corresponding “AA or Nt” option. The Mutation table is computed
   based on the grouped alignment table.
7. In order to apply *Mutations* using the *Select top N clonotypes* or the
   *Select clonotypes separately* option, *Clonotypes computation* should have
   previously run.
8. In order to apply *Logo* using the *Select top N clonotypes* option,
   *Clonotypes computation* should have run previously.
9. Ιn order to run the *Shared Clonotype computation* and the *Repertoire
   comparison* steps, the user must have loaded more than one datasets.

![](data:image/png;base64...)

---

For **both** T- and B-cells:

### 2.3.1 Clonotype computation

The frequencies for all unique clonotypes of each
sample are computed. There are 10 different options for clonotype
definition.

![](data:image/png;base64...)

The results are presented in the **Clonotypes** tab in the
form of a table, where the clonotype, the count, the frequency and the
convergent evolution (if feasible) are given. Each clonotype is also a
link that provides a table with all relevant immunogenetic data for that
particular clonotype, based on the uploaded files. This table consists
of all reads/sequences assigned to that clonotype and all relevant
information. Each clonotype is given a unique cluster
identifier (cluster ID).

![](data:image/png;base64...)

### 2.3.2 Highly similar clonotypes computation

Frequencies for all highly
similar clonotypes are computed. The user can set the number of
mismatches allowed for each CDR3 length found in the dataset and a
clonotype frequency threshold (range: 0-1). Only clonotypes with a
frequency above the applied threshold will be used in the subsequent
grouping. The whole process can be performed with or without taking
into account the rearranged V-gene.

![](data:image/png;base64...)

The results are presented in
the **Highly Similar Clonotypes** tab as a table. A second table is
also provided containing information regarding the clonotype grouping.

![](data:image/png;base64...)

### 2.3.3 Repertoires extraction

The number of clonotypes using each V, J or D
gene/allele is computed over the total number of clonotypes based on
the clonotype definition given in the previous *Clonotype computation*
step. If multiple samples are analyzed together the tool provides a
total repertoire as well as the repertoire for each individual sample.

![](data:image/png;base64...)

Results are provided in the **Repertoires** tab as tables. Each table
includes the gene/allele and information concerning the absolute count
and frequency of sequences expressing that particular gene/allele.

![](data:image/png;base64...)

### 2.3.4 Highly Similar Repertoires extraction

Same as above except for the fact
that the tool uses as input the clonotypes as computed in the
*Highly Similar Clonotypes computation*.

### 2.3.5 Multiple value comparison

The tool performs cross-tabulation analysis
between 2 selected variables. Many different variables can be selected
by the user for this type of analysis depending on the selected input
files from the **Home** tab.

![](data:image/png;base64...)

The results are presented at the
**Multiple value comparison** tab as tables. Each table contains the
values that were found to be associated and the relevant frequency.

![](data:image/png;base64...)

### 2.3.6 CDR3 with 1 amino acid length difference

This tool can be applied for
datasets that consist of sequences with highly similar CDR3. The tool
is able to align and create sequence logos for sequences with the same
length as well as for sequences that differ by a single amino acid in
terms of length.

### 2.3.7 Logo

This tool creates an amino acid frequency table for the selected
sequence region (CDR3, VDJ REGION, VJ REGION) of a given length. The
frequency table is computed by counting the frequency of appearance of
each of the 20 different amino acids at any given position of the sequence.
The users have the option to select over the total frequency table or the
table of the top clusters according to the clonotype frequencies.

A logo is
created using the above frequency table. The color code of the amino acids
is created based on the 11
[IMGT amino acid physicochemical classes](http://www.imgt.org/IMGTeducation/Aide-memoire/_UK/aminoacids/IMGTclasses.html).

---

**Only** for B cells:

### 2.3.8 Insert identity groups

Input sequences are grouped into different categories based on the V-region
identity percent. The user can determine the number and the identity percent
range of mutational groups. (high limit: <, low limit: ≥)

![](data:image/png;base64...)

### 2.3.9 Somatic hypermutation status

The relative frequency of each germline identity group is computed. If the
user has not defined any groups based on the somatic hypermutation (SHM)
status using the *Insert identity groups* tool, the tool will group together
only sequences that display the exact SHM status (e.g. sequences with an
identity percent of 98.6% will be grouped together whereas sequences with
98.7% identity will form a distinct group). Relative frequencies for each
SHM group will be computed based on the total number of sequences.

### 2.3.10 Alignment

An alignment table is created for the user-selected region (VDJ REGION,
VJ REGION). Sequences that are identical in terms of amino acid or nucleotide
sequence level are grouped together in order to create the grouped alignment
table. Alignments for the selected region can be provided at the nucleotide
or amino acid level or both. Default reference sequences are extracted from
the [IMGT reference directory](http://www.imgt.org/vquest/refseqh.html).
Reference sequences can be used either at the gene or gene allele level. At
the gene level, allele \*01 is considered as reference. Users can also submit
their own reference sequence. There is also the possibility to align only a
number of selected clonotypes through the *Select topN clonotype* option or
select those clonotypes that have an individual frequency above a given
percent cutoff.

![](data:image/png;base64...)

Results are presented in the **Alignment** tab as tables.

![](data:image/png;base64...)

Each table can be downloaded in txt format.

### 2.3.11 Somatic hypermutations

A table with all somatic hypermutations for all samples together as well as
for each individual sample is computed based on the alignment table provided
by the previous tool.

The output table includes:

1. the mutation type,
2. the position of the change,
3. the region where the change occurs,
4. the number of sequences carrying each change and
5. the frequency of the change for every gene or allele based on
   the grouped alignment table regardless
   the clonotype.

There is the possibility to analyze only a number of clonotypes
by choosing the *Select topN clonotypes* or
the *Select threshold for clonotypes* option or even
some clonotypes separately by choosing the
*Select clonotypes separately* option. Different clonotype/cluster
identifiers (cluster IDs) should be separated by comma (e.g. 1,3,7).

Results are given in the **Mutations** tab as tables. When different clonotypes
are selected separately, different tables are created for each given clonotype.

Each table can be downloaded in text format.

## 2.4 Visualization

In the **Visualization** tab different types of charts
(scatter, plots, bars etc.)
are available for the visualization of the analysis results. Clonotypes are
presented as bars and the user can select the frequency above which the
clonotypes will be presented.

![](data:image/png;base64...)

The convergent evolution is also available
for visualization with more than one chart type options.

The computed
repertoires are presented as pie-charts and the user can again select
the minimum frequency of the gene/allele that will be presented.

Regarding the *Multiple value comparison* tool, a plot of the 2
selected variables is presented.

![](data:image/png;base64...)

All the tables that are presented
to the user can be downloaded in text format, whereas the plots and the
graphics can be downloaded in .png format.

## 2.5 Overview

This section provides an overview of the user’s total options for the analysis.
![](data:image/png;base64...)

# 3 Running `tripr` via `R` command line

As mentioned before, `tripr` can also be used via `R` command line with
the `run_TRIP()` function.

## 3.1 Usage

`run_TRIP()` works as a wrapper function for the analysis that `tripr`
provides. To see its detailed documentation write:

```
    ?tripr::run_TRIP
```

Some of its most important arguments:

* `datapath` : The path to the directory where data is located.
  Note that every sample of the dataset must have its
  **own individual folder**
  and every sample folder must be in **one root folder**.
  Note that **every** file in the root folder will be used in
  the analysis.

  Supposedly the dataset is in user’s *Documents* folder, one
  could use: `fs::path_home("Documents", "dataset")`, with the help of
  [fs](https://www.rdocumentation.org/packages/fs) package.

  The default value is

  ```
      fs::path_package("extdata", "dataset", package = "tripr")
  ```

  which uses the example dataset of 2 B-cell samples.
* `output_path` : The directory where the output data will
  be stored. Please provide a valid path, ideally the same way as `datapath`
  by using the [fs](https://www.rdocumentation.org/packages/fs) package.

  The default value points to *Documents/tripr\_output* directory.
* `filelist` : The character vector of files of the
  [IMGT/HighV-Quest tool](http://www.imgt.org/HighV-QUEST/home.action)
  output that will be used through the analysis.

  The default value is

  ```
      c("1_Summary.txt", "2_IMGT-gapped-nt-sequences.txt",
          "4_IMGT-gapped-AA-sequences.txt", "6_Junction.txt")
  ```

  which uses only 4 of the 10 .txt files that the
  [IMGT/HighV-Quest tool](http://www.imgt.org/HighV-QUEST/home.action)
  tool provides as output.
* `preselection` : Preselection Options (1:4). See [Preselection](#preselection)
* `selection` : Selection Options (5:10). See [Selection](#selection)
* `pipeline` : Pipeline Options (1:19). The user can select multiple pipelines
  by seperating them with comma ‘,’.

  See [Pipelines](#pipelines) and run `?tripr::run_TRIP` for more details.

## 3.2 Output of Command Line tool

Every output of `tripr` analysis with `run_TRIP()` function will be stored in
the `output_path` directory as mentioned before. Therefore, no table or plot
will be presented through `RStudio` or any other graphics device when the
analysis is run, on contrary with the `shiny` app, where the user has access
to output tables and plots via the User Interface.

Output Directory contains two folders:

1. **output** : Where data tables are stored.
2. **Analysis** : Where plots are stored.

The output directory has a unique name for every analysis, that points
to the system time that it was run.

## 3.3 Example with `run_TRIP()`

An example of `run_TRIP()` analysis, using the example dataset of 2 B-cells
that is provided, is presented below.

```
    datapath <- fs::path_package("extdata", "dataset", package="tripr")
    output_path <- tools::R_user_dir("tripr", which="cache")
    cell <- "Bcell"
    preselection <- "1,2,3,4C:W"
    selection <- "5"
    filelist <- c("1_Summary.txt",
                  "2_IMGT-gapped-nt-sequences.txt",
                  "4_IMGT-gapped-AA-sequences.txt",
                  "6_Junction.txt")
    throughput <- "High Throughput"
    preselection <- "1,2,3,4C:W"
    selection <- "5"
    identity_range <- "88:100"
    pipeline <- "1"
    select_clonotype <- "V Gene + CDR3 Amino Acids"

    run_TRIP(
        datapath=datapath,
        output_path=output_path,
        filelist=filelist,
        cell=cell,
        throughput=throughput,
        preselection=preselection,
        selection=selection,
        identity_range=identity_range,
        pipeline=pipeline,
        select_clonotype=select_clonotype)
```

# 4 Tool dependencies

The *[tripr](https://bioconductor.org/packages/3.22/tripr)* package was
made possible thanks to:

* R (R Core Team, 2025)
* *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* (Oleś, 2025)
* *[DT](https://CRAN.R-project.org/package%3DDT)* (Xie, Cheng, Tan, and Aden-Buie, 2025)
* *[ggplot2](https://CRAN.R-project.org/package%3Dggplot2)* (Wickham, 2016)
* *[golem](https://CRAN.R-project.org/package%3Dgolem)* (Fay, Guyader, Rochette, and Girard, 2024)
* *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2014)
* *[plotly](https://CRAN.R-project.org/package%3Dplotly)* (Sievert, 2020)
* *[RColorBrewer](https://CRAN.R-project.org/package%3DRColorBrewer)* (Neuwirth, 2022)
* *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux, McPherson, Luraschi, Ushey, Atkins, Wickham, Cheng, Chang, and Iannone, 2025)
* *[shiny](https://CRAN.R-project.org/package%3Dshiny)* (Chang, Cheng, Allaire, Sievert, Schloerke, Xie, Allen, McPherson, Dipert, and Borges, 2025)
* *[shinyBS](https://CRAN.R-project.org/package%3DshinyBS)* (Bailey, 2022)
* *[testthat](https://CRAN.R-project.org/package%3Dtestthat)* (Wickham, 2011)
* *[shinyjs](https://CRAN.R-project.org/package%3Dshinyjs)* (Attali, 2021)
* *[shinyFiles](https://CRAN.R-project.org/package%3DshinyFiles)* (Pedersen, Nijs, Schaffner, and Nantz, 2022)
* *[plyr](https://CRAN.R-project.org/package%3Dplyr)* (Wickham, 2011)
* *[data.table](https://CRAN.R-project.org/package%3Ddata.table)* (Barrett, Dowle, Srinivasan, Gorecki, Chirico, Hocking, Schwendinger, and Krylov, 2025)
* *[stringr](https://CRAN.R-project.org/package%3Dstringr)* (Wickham, 2025)
* *[stringdist](https://CRAN.R-project.org/package%3Dstringdist)* (van der Loo, 2014)
* *[plot3D](https://CRAN.R-project.org/package%3Dplot3D)* (Soetaert, 2025)
* *[gridExtra](https://CRAN.R-project.org/package%3DgridExtra)* (Auguie, 2017)
* *[dplyr](https://CRAN.R-project.org/package%3Ddplyr)* (Wickham, François, Henry, Müller, and Vaughan, 2023)
* *[pryr](https://CRAN.R-project.org/package%3Dpryr)* (Wickham, 2023)
* *[fs](https://CRAN.R-project.org/package%3Dfs)* (Hester, Wickham, and Csárdi, 2025)
* *[biocthis](https://bioconductor.org/packages/3.22/biocthis)* (Collado-Torres, 2025)

# 5 Citation

We hope that *[tripr](https://bioconductor.org/packages/3.22/tripr)* will be useful for your research.
Please use the following information to cite the package and the research
article. Thank you!

```
## Citation info
citation("tripr")
#> To cite tripr in publications use:
#>
#>   Kotouza, M.T., Gemenetzi, K., Galigalidou, C. et al. TRIP - T cell
#>   receptor/immunoglobulin profiler. BMC Bioinformatics 21, 422 (2020).
#>   https://doi.org/10.1186/s12859-020-03669-1
#>
#> A BibTeX entry for LaTeX users is
#>
#>   @Article{,
#>     title = {T-cell Receptor/Immunoglobulin Profiler (TRIP)},
#>     author = {Maria Th. Kotouza and Katerina Gemenetzi and Chrysi Galigalidou and Elisavet Vlachonikola and Nikolaos Pechlivanis and Andreas Agathangelidis and Raphael Sandaltzopoulos and Pericles A. Mitkas and Kostas Stamatopoulos and Anastasia Chatzidimitriou and Fotis E. Psomopoulos},
#>     journal = {BMC Bioinformatics},
#>     year = {2020},
#>     volume = {21},
#>     number = {422},
#>     pages = {-},
#>     url = {https://doi.org/10.1186/s12859-020-03669-1},
#>   }
```

# Session info

Here is the output of `sessionInfo()` on the system on which this document was
compiled running pandoc `2.7.3`:

```
#> R version 4.5.1 Patched (2025-08-23 r88802)
#> Platform: x86_64-pc-linux-gnu
#> Running under: Ubuntu 24.04.3 LTS
#>
#> Matrix products: default
#> BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
#>
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
#>  [3] LC_TIME=en_GB              LC_COLLATE=C
#>  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
#>  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C
#> [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
#>
#> time zone: America/New_York
#> tzcode source: system (glibc)
#>
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base
#>
#> other attached packages:
#> [1] tripr_1.16.0     shinyBS_0.61.1   shiny_1.11.1     RefManageR_1.4.0
#> [5] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] gtable_0.3.6        xfun_0.53           bslib_0.9.0
#>  [4] ggplot2_4.0.0       shinyjs_2.1.0       htmlwidgets_1.6.4
#>  [7] lattice_0.22-7      vctrs_0.6.5         tools_4.5.1
#> [10] generics_0.1.4      parallel_4.5.1      tibble_3.3.0
#> [13] cluster_2.1.8.1     pkgconfig_2.0.3     Matrix_1.7-4
#> [16] data.table_1.17.8   RColorBrewer_1.1-3  S7_0.2.0
#> [19] lifecycle_1.0.4     compiler_4.5.1      farver_2.1.2
#> [22] stringr_1.5.2       misc3d_0.9-1        permute_0.9-8
#> [25] golem_0.5.1         httpuv_1.6.16       htmltools_0.5.8.1
#> [28] sass_0.4.10         yaml_2.3.10         lazyeval_0.2.2
#> [31] plotly_4.11.0       later_1.4.4         pillar_1.11.1
#> [34] jquerylib_0.1.4     tidyr_1.3.1         MASS_7.3-65
#> [37] cachem_1.1.0        vegan_2.7-2         nlme_3.1-168
#> [40] mime_0.13           tidyselect_1.2.1    digest_0.6.37
#> [43] stringi_1.8.7       dplyr_1.1.4         purrr_1.1.0
#> [46] bookdown_0.45       splines_4.5.1       bibtex_0.5.1
#> [49] fastmap_1.2.0       grid_4.5.1          cli_3.6.5
#> [52] magrittr_2.0.4      dichromat_2.0-0.1   scales_1.4.0
#> [55] promises_1.4.0      backports_1.5.0     plot3D_1.4.2
#> [58] lubridate_1.9.4     timechange_0.3.0    rmarkdown_2.30
#> [61] httr_1.4.7          config_0.3.2        otel_0.2.0
#> [64] gridExtra_2.3       evaluate_1.0.5      knitr_1.50
#> [67] tcltk_4.5.1         viridisLite_0.4.2   mgcv_1.9-3
#> [70] rlang_1.1.6         Rcpp_1.1.0          xtable_1.8-4
#> [73] glue_1.8.0          BiocManager_1.30.26 xml2_1.4.1
#> [76] attempt_0.3.1       jsonlite_2.0.0      R6_2.6.1
#> [79] plyr_1.8.9          shinyFiles_0.9.3    fs_1.6.6
```

# Bibliography

This vignette was generated using *[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)*
(Oleś, 2025), *[knitr](https://CRAN.R-project.org/package%3Dknitr)* (Xie, 2014)
and *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* (Allaire, Xie, Dervieux et al., 2025) running
behind the scenes.

Citations made with *[RefManageR](https://CRAN.R-project.org/package%3DRefManageR)* (McLean, 2017).

[[1]](#cite-allaire2025rmarkdown)
J. Allaire, Y. Xie, C. Dervieux, et al.
*rmarkdown: Dynamic Documents for R*.
R package version 2.30.
2025.
URL: <https://github.com/rstudio/rmarkdown>.

[[2]](#cite-attali2021shinyjs)
D. Attali.
*shinyjs: Easily Improve the User Experience of Your Shiny Apps in Seconds*.
R package version 2.1.0.
2021.
DOI: [10.32614/CRAN.package.shinyjs](https://doi.org/10.32614/CRAN.package.shinyjs).
URL: [https://CRAN.R-project.org/package=shinyjs](https://CRAN.R-project.org/package%3Dshinyjs).

[[3]](#cite-auguie2017gridextra)
B. Auguie.
*gridExtra: Miscellaneous Functions for “Grid” Graphics*.
R package version 2.3.
2017.
DOI: [10.32614/CRAN.package.gridExtra](https://doi.org/10.32614/CRAN.package.gridExtra).
URL: [https://CRAN.R-project.org/package=gridExtra](https://CRAN.R-project.org/package%3DgridExtra).

[[4]](#cite-bailey2022shinybs)
E. Bailey.
*shinyBS: Twitter Bootstrap Components for Shiny*.
R package version 0.61.1.
2022.
DOI: [10.32614/CRAN.package.shinyBS](https://doi.org/10.32614/CRAN.package.shinyBS).
URL: [https://CRAN.R-project.org/package=shinyBS](https://CRAN.R-project.org/package%3DshinyBS).

[[5]](#cite-barrett2025data)
T. Barrett, M. Dowle, A. Srinivasan, et al.
*data.table: Extension of ‘data.frame’*.
R package version 1.17.8.
2025.
DOI: [10.32614/CRAN.package.data.table](https://doi.org/10.32614/CRAN.package.data.table).
URL: [https://CRAN.R-project.org/package=data.table](https://CRAN.R-project.org/package%3Ddata.table).

[[6]](#cite-chang2025shiny)
W. Chang, J. Cheng, J. Allaire, et al.
*shiny: Web Application Framework for R*.
R package version 1.11.1.
2025.
DOI: [10.32614/CRAN.package.shiny](https://doi.org/10.32614/CRAN.package.shiny).
URL: [https://CRAN.R-project.org/package=shiny](https://CRAN.R-project.org/package%3Dshiny).

[[7]](#cite-colladotorres2025automate)
L. Collado-Torres.
*Automate package and project setup for Bioconductor packages*.
<https://github.com/lcolladotor/biocthisbiocthis> - R package version 1.20.0.
2025.
DOI: [10.18129/B9.bioc.biocthis](https://doi.org/10.18129/B9.bioc.biocthis).
URL: <http://www.bioconductor.org/packages/biocthis>.

[[8]](#cite-fay2024golem)
C. Fay, V. Guyader, S. Rochette, et al.
*golem: A Framework for Robust Shiny Applications*.
R package version 0.5.1.
2024.
DOI: [10.32614/CRAN.package.golem](https://doi.org/10.32614/CRAN.package.golem).
URL: [https://CRAN.R-project.org/package=golem](https://CRAN.R-project.org/package%3Dgolem).

[[9]](#cite-hester2025cross)
J. Hester, H. Wickham, and G. Csárdi.
*fs: Cross-Platform File System Operations Based on ‘libuv’*.
R package version 1.6.6.
2025.
DOI: [10.32614/CRAN.package.fs](https://doi.org/10.32614/CRAN.package.fs).
URL: [https://CRAN.R-project.org/package=fs](https://CRAN.R-project.org/package%3Dfs).

[[10]](#cite-mclean2017refmanager)
M. W. McLean.
“RefManageR: Import and Manage BibTeX and BibLaTeX References in R”.
In: *The Journal of Open Source Software* (2017).
DOI: [10.21105/joss.00338](https://doi.org/10.21105/joss.00338).

[[11]](#cite-neuwirth2022rcolorbrewer)
E. Neuwirth.
*RColorBrewer: ColorBrewer Palettes*.
R package version 1.1-3.
2022.
DOI: [10.32614/CRAN.package.RColorBrewer](https://doi.org/10.32614/CRAN.package.RColorBrewer).
URL: [https://CRAN.R-project.org/package=RColorBrewer](https://CRAN.R-project.org/package%3DRColorBrewer).

[[12]](#cite-ole2025biocstyle)
A. Oleś.
*BiocStyle: Standard styles for vignettes and other Bioconductor documents*.
R package version 2.38.0.
2025.
DOI: [10.18129/B9.bioc.BiocStyle](https://doi.org/10.18129/B9.bioc.BiocStyle).
URL: <https://bioconductor.org/packages/BiocStyle>.

[[13]](#cite-pedersen2022shinyfiles)
T. Pedersen, V. Nijs, T. Schaffner, et al.
*shinyFiles: A Server-Side File System Viewer for Shiny*.
R package version 0.9.3.
2022.
DOI: [10.32614/CRAN.package.shinyFiles](https://doi.org/10.32614/CRAN.package.shinyFiles).
URL: [https://CRAN.R-project.org/package=shinyFiles](https://CRAN.R-project.org/package%3DshinyFiles).

[[14]](#cite-2025language)
R Core Team.
*R: A Language and Environment for Statistical Computing*.
R Foundation for Statistical Computing.
Vienna, Austria, 2025.
URL: <https://www.R-project.org/>.

[[15]](#cite-sievert2020interactive)
C. Sievert.
*Interactive Web-Based Data Visualization with R, plotly, and shiny*.
Chapman and Hall/CRC, 2020.
ISBN: 9781138331457.
URL: <https://plotly-r.com>.

[[16]](#cite-soetaert2025plot3d)
K. Soetaert.
*plot3D: Plotting Multi-Dimensional Data*.
R package version 1.4.2.
2025.
DOI: [10.32614/CRAN.package.plot3D](https://doi.org/10.32614/CRAN.package.plot3D).
URL: [https://CRAN.R-project.org/package=plot3D](https://CRAN.R-project.org/package%3Dplot3D).

[[17]](#cite-wickham2011split)
H. Wickham.
“The Split-Apply-Combine Strategy for Data Analysis”.
In: *Journal of Statistical Software* 40.1 (2011), pp. 1–29.
URL: <https://www.jstatsoft.org/v40/i01/>.

[[18]](#cite-wickham2016ggplot2)
H. Wickham.
*ggplot2: Elegant Graphics for Data Analysis*.
Springer-Verlag New York, 2016.
ISBN: 978-3-319-24277-4.
URL: <https://ggplot2.tidyverse.org>.

[[19]](#cite-wickham2023pryr)
H. Wickham.
*pryr: Tools for Computing on the Language*.
R package version 0.1.6.
2023.
DOI: [10.32614/CRAN.package.pryr](https://doi.org/10.32614/CRAN.package.pryr).
URL: [https://CRAN.R-project.org/package=pryr](https://CRAN.R-project.org/package%3Dpryr).

[[20]](#cite-wickham2025stringr)
H. Wickham.
*stringr: Simple, Consistent Wrappers for Common String Operations*.
R package version 1.5.2.
2025.
DOI: [10.32614/CRAN.package.stringr](https://doi.org/10.32614/CRAN.package.stringr).
URL: [https://CRAN.R-project.org/package=stringr](https://CRAN.R-project.org/package%3Dstringr).

[[21]](#cite-wickham2011testthat)
H. Wickham.
“testthat: Get Started with Testing”.
In: *The R Journal* 3 (2011), pp. 5–10.
URL: <https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf>.

[[22]](#cite-wickham2023dplyr)
H. Wickham, R. François, L. Henry, et al.
*dplyr: A Grammar of Data Manipulation*.
R package version 1.1.4.
2023.
DOI: [10.32614/CRAN.package.dplyr](https://doi.org/10.32614/CRAN.package.dplyr).
URL: [https://CRAN.R-project.org/package=dplyr](https://CRAN.R-project.org/package%3Ddplyr).

[[23]](#cite-xie2014knitr)
Y. Xie.
“knitr: A Comprehensive Tool for Reproducible Research in R”.
In:
*Implementing Reproducible Computational Research*.
Ed. by V. Stodden, F. Leisch and R. D. Peng.
ISBN 978-1466561595.
Chapman and Hall/CRC, 2014.

[[24]](#cite-xie2025wrapper)
Y. Xie, J. Cheng, X. Tan, et al.
*DT: A Wrapper of the JavaScript Library ‘DataTables’*.
R package version 0.34.0.
2025.
DOI: [10.32614/CRAN.package.DT](https://doi.org/10.32614/CRAN.package.DT).
URL: [https://CRAN.R-project.org/package=DT](https://CRAN.R-project.org/package%3DDT).

[[25]](#cite-vanderloo2014stringdist)
M. van der Loo.
“The stringdist package for approximate string matching”.
In: *The R Journal* 6 (1 2014), pp. 111-122.
URL: [https://CRAN.R-project.org/package=stringdist](https://CRAN.R-project.org/package%3Dstringdist).