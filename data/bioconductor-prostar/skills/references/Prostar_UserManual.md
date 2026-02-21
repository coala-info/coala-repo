# Prostar user manual

Samuel Wieczorek and Thomas Burger

#### 2025-10-30

#### Abstract

The package Prostar (Proteomics statistical analysis with R) is a Bioconductor distributed R package which provides all the necessary functions to analyze quantitative data from label-free proteomics experiments. Contrarily to most other similar R packages, it is endowed with rich and user-friendly graphical interfaces, so that no programming skill is required. This document covers the functionalities available in Prostar 1.42.0, DAPAR 1.42.0, DAPARdata 1.39.0.

#### Package

DAPAR 1.42.0

# Contents

* [1 Introduction](#introduction)

```
## <script type="text/javascript">
## document.addEventListener("DOMContentLoaded", function() {
##   document.querySelector("h1").className = "title";
## });
## </script>
## <script type="text/javascript">
## document.addEventListener("DOMContentLoaded", function() {
##   var links = document.links;
##   for (var i = 0, linksLength = links.length; i < linksLength; i++)
##     if (links[i].hostname != window.location.hostname)
##       links[i].target = '_blank';
## });
## </script>
```

# 1 Introduction

The `DAPAR` and `Prostar` packages are a series of software dedicated to
the processing of proteomics data. More precisely, they are devoted to the
analysis of quantitative datasets produced by bottom-up discovery proteomics
experiments with a LC-MS/MS pipeline (Liquid Chromatography and Tandem Mass
spectrometry).
`DAPAR` (Differential Analysis of Protein Abundance with R) is an R
package that contains all the necessary functions to process the data in
command lines. It can be used on its own; or as a complement to the numerous
Bioconductor packages () it is compliant
with; or through the `Prostar` interface.
`Prostar` (Proteomics statistical analysis with R) is a
web interface based on Shiny technology () that
provides GUI (Graphical User Interfaces) to all the `DAPAR` functionalities,
so as to guide any practitioner that is not comfortable with R programming
through the complete quantitative analysis process.
The experiment package `DAPARdata` contains many datasets that can be used as
examples.
`Prostar` functionalities make it possible to easily:

* **Manage quantitative datasets**: This includes import/export, conversion and report generation
  functionalities.
* **Perform a complete data processing chain**: (*i*) filtering
  and data cleaning; (*ii*) cross-replicate normalization; (*iii*)
  missing value imputation; (*iv*) aggregation of peptide intensities into
  protein intensities (optional); (*v*) null hypothesis significance testing.
* **Mine the dataset** at any step of the processing chain with
  various tools such as: (*i*) descriptive statistics; (*ii*)
  differential analysis; (*iii*) Gene Ontology (GO) analysis.

There are many ways to install , as well as its dependencies
:

In addition, it is also possible to only install or
, so as to work in command lines (for expert users only).

For all the desktop installs, we advise to use a machine with a minimum of 8GB
of RAM (although there are no strict constraints).

This method works for any desktop machine with Microsoft Windows. It is not
necessary to have R already installed.
Go to and click on Zero-install
download (Prostar menu). Download the zip file and unzip it.
The unzipped folder contains an executable file which directly launches
. Notice that at the first launch, an internet connection is
necessary, so as to finish the install.

For this type of install, the operating system of the desktop machine can be of
any type (Unix/Linux, Mac OS X or Windows).
However, it is necessary to have the latest version of R
(see Section~) installed in a directory where the user
has read/write permissions.
Optionally, an IDE (integrated development environment) such as R Studio
() may be useful to conveniently deal with
the various R package installs.

To install , enter in the R console the following instructions:

For a better experience, it is advised (but not mandatory) to install the
development version of the following packages: DT and highcharter. To do so,
install the devtools package and execute the following commands:

Once the package is installed, to launch , then enter:

A new window of the default web browser opens.

In the case of several users that are not
confortable with R (programming or installing), it is best to have a single
version of running on a Shiny server
installed on a Unix/Linux server. The users will use through
a web browser, exactly if it were locally installed, yet, a single install has
to be administrated. In that case, has to be classically
installed (see Section~), while on the other hand, the
installation of is slightly different.

Shiny Server () is a server
program that makes Shiny applications available over the web. If Shiny Server
is not installed yet, follow Shiny installation instructions.

Once a Shiny server is available, first install as described
in Section~, so as to have the dependencies
installed.

Then, execute the following line to get the install directory of Prostar:

The result of this command is now referred as .

Change the owner of the Shiny Server directory and log as shiny

Create a directory named in the Shiny Server directory with
the user shiny as owner and then copy the Prostar files.

Create the directory for the shiny application

Copy the ProstarApp directory within the shiny-server directory

Change the owner of the Shiny Server directory

Give the following permissions to the www directory

Check if the configuration file of Shiny Server is correct.
For more details, please visit
.

Now, the application should be available via a web browser at
[http://\*servername](http://*servername)*:*port\*/Prostar.

This type of install should only be performed by advanced R users/programmers,
or by the admin of a server version of .

To install the package from the source file with administrator
rights, start R and enter:

This step will automatically install the following packages:

is automatically installed with or
. However, it is possible to install it alone. Then, it follows
the classical way for Bioconductor packages. In a R console, enter:

%

Right after being launched, the web page depicted in
Figure~ shows up in the default browser (stand-alone install) or
in a portable one (zero install).
So far, the navbar only contains 3 menus: Prostar, Data manager and Help.
However, as soon as data are loaded in the software, new menus contextualy
appear (see Section~).

The is detailed in a dedicated section
(Section~).

In the menu, one has access to:
In the menu, one has access to:

is under active
development, so that despite the developers’ attention, bugs may remain.
To signal any, as well as typos, suggestions, etc. or even to ask a question,
please contact the developers.

When data are loaded for analysis, mor options are available in the navbar,
as illustrated on Figure~. In addition to the navbar, the screen
is composed of a large working panel (below the navbar) and a drop-down menu
on the upper right corner (which purpose is detailed in
Section~).

Table~ summarizes the content of the navbar. Let us note that
depending on the dataset content (either proteins or peptides), the menu can
slightly change: Notably, if protein-level dataset is loaded, then
(which purpose is to roll up from peptides to proteins)
is not proposed in the menu.

%
The menu gathers all the functionalities that relates to
data import, export or conversion:

As soon as one of the three first options of the menu has been used to load a
dataset, the and menus appear in
the navbar.

Conducting a rigorous differential analysis requires a well-defined pipeline
made of several tightly connected steps. In , this pipeline
has been designed to be as general as possible. Thus, the
menu contains numerous steps which, for a given
dataset may not all be necessary, so that some can be occasionally skipped.
However, the pipeline has been assembled and organized so as to propose
coherent processing, so that the respective order of the different steps
should be respected. These steps are the following:

It should be carefully noted that each of these steps modifies the dataset: In
other words, the menu offers a succession of data
transformations which should be performed by the user in an educated way.

As opposed to the menu, the menu
offers a series of tools to analyze and visualize the dataset without
transforming it. Thus, there is far less restriction on how and when applying
them:

As explained above, each functionality in the menu
transforms the current dataset.
To authorize some flexibility and to avoid unwanted data corruption, it is
possible to save in the original dataset, as well as each
intermediate dataset along the processing chain. Concretely, it is possible to
store one *original dataset*, one *filtered dataset*, one `normalized dataset'', one`imputed dataset’’ and so on.
Moreover, at any moment, it is possible to go back to a previous state of the
dataset, either to restart a step that went wrong, or just to compare with the
tools how the dataset was changed (rapid switching makes
it easier to visualize it).

To create a new item in the dataset history, one simply has to click on the
save button at the end of each processing step. Each time a new dataset is
created, it is by default the one on which the processing goes on.

To navigate through the dataset history, one simply uses the drop-down menu of
the upper right corner. Notice that if the user saves the current step (e.g.
imputation), then goes back to a previous step (e.g. normalization ) and start
working on this older dataset (to perform another imputation) and then saves
it, the new version of the processing overwrites the previous version (the
older imputation is lost and only the newest one is stored in memory): in
fact, only a single version of the dataset can be saved for a given processing
step. As a side effect, if any processing further than imputation was already
done (e.g. aggregation), then, the aggregated dataset is not coherent anymore
with the imputed one (as the new imputation cannot be automatically
transmitted to update the previously tuned aggregation).

Finally, let us note that the name of each dataset version (normalized,
imputed, etc.) also indicates if the dataset is a protein-level or a
peptide-level one (as for instance the aggregation step transforms a
peptide-level dataset into a protein-level one).

The quantitative data should fit into a matrix-like representation where each
line corresponds to an analyte and each column to a sample. Within the (\(i\)-th, \(j\)-th) cell of the
matrix, one reads the abundance of analyte \(i\) in sample \(j\).

Although strictly speaking, there is no lower or upper bound to the number of
lines, it should be recalled that the statistical tools implemented in
have been chosen and tuned to fit a discovery experiment
dataset with large amount of analytes, so that the result may lack of
reliability on too small datasets. Conversely, very large datasets are not
inherently a problem, as R algorithms are well scalable, but one should keep
in mind the hardware limitations of the machine on which
runs to avoid overloading.

As for the number of samples (the columns of the dataset), it is necessary to
have at least 2 conditions (or groups of samples) as it is not possible to
perform relative comparison otherwise. Moreover, it is necessary to have at
least 2 samples per condition, as otherwise, it is not possible to compute an intra-condition
variance, which is a prerequisite to numerous processing.

The data table should be formatted in a tabulated file where the first line of
the text file contains the column names. It is recommended to avoid special
characters such as “]”, “@”, “$”, “%”, etc. that are automatically removed.
Similarly, spaces in column names are replaced by dots (“.”). Dot must be used
as decimal separator for quantitative values. In addition to the columns
containing quantitative values, the file may contain additional columns for
metadata. Alternatively, if the data have already been processed by
and saved as an MSnset file (see ), it is
possible to directly reload them (see Section~).

The allows it to open, import or export quantitative
datasets. relies on the MSnSet format which is part of the
package :

It is either possible to load existing MSnSet files (see
Section~), or to import text (-tabulated) and Excel files (see
Section~). The menu allows it to load
the datasets of the package as examples to discover
functionalities (see Section~).

To reload a dataset that was already formated into an MSnSet file, click on
. This opens a pop-up window, so as to let the user
choose the appropriate file. Once the file is uploaded, a short summary of the
dataset is shown (see Figure~):
It includes the number of samples, the number of proteins (or peptides) in the
dataset, the percentage of missing values and the number of lines which only
contain missing values. Once done, the menu displaying the version of the
dataset appears and display “Original - peptide” or “Original - protein”,
depending on whether the file contains peptide-level or protein-level
quantitative information (see Section~). Similarly,
the Data processing and Data mining menus become available.

To upload data from tabular file (i.e. stored in a file with one of the
following extensions: .txt, .csv, .tsv, .xls, or .xlsx) click on the upper
menu then chose .

, go to the tab (see Figure~):
Click on the button and select the tabular file of
interest
(If an Excel file is chosen, a drop-down menu appears to select the spreadsheet
containing the data).
Once the upload is complete, indicate whether it is a protein level dataset
(i.e., each line of the data table should correspond to a single protein) or a
peptide-level one. Indicate if the data are already log-transformed or not.
If not they will be automatically log-transformed.
If the quantification software uses *0* in places of missing values, tick
the last option ``Replace all 0 and NaN by NA’’ (as in , 0 is
considered a value, not a missing value).

, move on to the tab (see Figure~)
:   If the dataset already contains an ID column (a column where each cell has a
    unique content, which can serve as an ID for the peptides/proteins), select
    its name in the drop-down menu. Otherwise, it is possible to use the first
    option of the drop-down menu, that is the ,
    which creates an artificial index. Finally, if the dataset is a peptide-level
    one, it is in addition important to indicate the column containing the IDs of
    the parent proteins, so as to prepare for future peptide to protein aggregation.

(see Figure~), referred to as
, select the columns which contain the protein
abundances (one column for each sample of each condition). To select several
column names in a row, click-on on the first one, and click-off on the last
one. Alternatively, to select several names which are not continuously
displayed, use the key to maintain the selection.
If, for each sample, a column of the dataset provides information on the
identification method (e.g. by direct MS/MS evidence, or by mapping) check
the corresponding tick box. Then, for each sample, select the corresponding
column. If none of these pieces of information is given, or, on the contrary,
if all of them are specified with a different column name, a green logo
appears, indicating it is possible to proceed (however, the content of the
specified columns are not checked, so that it is the user’s responsibility to
select the correct ones). Otherwise (i.e. the identification method is given
only for a subset of samples, or a same identification method is referenced
for two different samples), then a red mark appears, indicating some
corrections are mandatory.

, (see
Figure~). This tab guides the user through the definition of the
experimental design.
Fill the empty columns with as different names as biological conditions to
compare (minimum 2 conditions and 2 samples per condition) and click on
. If necessary, correct until the conditions are
valid. When achieved,
a green logo appears and the sample are reordered according to the conditions.
Choose the number of levels in the experimental design (either 1, 2 or 3), and
fill the additional column(s) of the table.
Once the design is valid (a green check logo appears), move on to the last tab.

, move on to the tab (see
Figure~).
Provide a name to the dataset to be created and click on the
button.
As a result, a new MSnset structure is created and automatically loaded.
This can be checked with the name of the file appearing in the upper right
hand side of the screen, as a title to a new drop-down menu. So far, it only
contains `Original - protein'' or`Original - peptide’’, but other versions
of the dataset will be added along the course of the processing. Pay attention
to any red message appears below the button, which
indicates a mistake or an incomplete parameter tuning that must be sorted out
before converting the data.

To ease discovery, a “demo mode” is proposed. In this mode,
the datasets contained in the package can be directly
uploaded to test
functionalities. To do so,
simply click on in the
(Figure~).
Note that it possible to display the PDF vignette of the dataset directly
from screen (``Dataset documentation (pdf)’’ link).

The menu from the gathers all the
functionality to save a dataset in various formats, or to compile the results
in a scientific report.

As importing a new dataset from a tabular file is a tedious procedure, we
advise to save the dataset as an MSnset binary file right after the conversion
(The, it becomes easy to reload it, as detailed in Section~).
This makes it possible to restart the statistical analysis from scratch if a
problem occurs without having to convert the data another time. Moreover, it
is also possible to export the dataset as an Excel spreadsheet (in xlsx
format) or as a series of tabulated files grouped in a zipped folder. Any any
case, the procedure is similar: First, choose the version of the dataset to be
saved. Then, choose the desired file format and provide a file
name. Then, click on
(Figure~). Once the downloading is over, store the file in the
appropriate directory.

The automatic reporting functionalities are under active development. However,
they are still in Beta version and amenable to numerous modifications.
This vignette will be completed with an exhaustive description of
reporting functionality in a near future.

The menu contains the 5 predefined steps of a
quantitative analysis. They are designed to be used in a specific order:

For each step, several algorithms or parameters are available, all of them
being thoroughly detailed in the sequel of this section.

During each of these steps, it is possible to test several options, and to
observe the influence of the processing in the descriptive statistics menu
(see Section~), which is dynamically updated.

Finally, once the ultimate tuning is chosen for a given step, it is advised
to save the processing. By doing so, another dataset appears in the Dataset
versions list (see Section~). Thus, it is possible
to go back to any previous step of the analysis if necessary, without starting
back the analysis from scratch.

In this step, the user may decide to delete several peptides or proteins
according to two criteria: First is the amount of missing values (if it is
too important to expect confident processing, see tab 1);
Second is string-based filtering (some analyte can be deleted after having been
tagged, such as for instance reverse sequences in target-decoy approaches, or
known contaminants, see tab 2).

To filter the missing values (first tab called ), the
choice of the lines to be deleted is made by different options (see
Figure~):

To visualize the effect of the filtering options (without saving the changes or
impacting the current dataset), just click on .
If the filtering does not
produce the expected effect, it is possible to test another one. To do so, one
simply has to choose another method in the list and click again on
. The plots are automatically updated. This action
does not modify the dataset but offers a preview of the filtered data. The
user can visualize as many times he/she wants several filtering options.

Afterward, proceed to the ,
where it is possible to filter out proteins according to information stored in
the metadata.
To do so: Among the columns constituting the protein metadata listed in the
drop-down menu, select the one containing the information
of interest (for instance, *Contaminant* or *Reverse*).
Then, specify in each case the prefix chain of characters that identifies the
proteins to filter.
Click on to remove the corresponding proteins.
A new line appears in the table listing all the filters that have been applied.
If other string-based filters must be applied, iterate the same process as
many times as necessary.

Once the filtering is appropriately tuned,go to the last tab
(called ) (see
Figure~), to visualize the set of analytes that have been
filtered. Finally, click on .
A new dataset is created; it becomes the new current dataset and its name
appears in the dropdown menu upper right corner of the screen. All plots and
tables available in are automatically updated.

The next processing step proposed by Prostar is data normalization.
Its objective is to reduce the biases introduced at any preliminary
stage (such as for instance batch effects).
offers a number of different normalization
routines that are described below.

To visualize the influence of the normalization, three plots are displayed
(see Figure~):
The first two plots are those of the tab of the
(see Section~).
The last one depicts the distortion induced by the chosen normalization
method on each sample.

Choose the normalization method among the following ones:

Then, for each normalization method, the interface is automatically updated to
display the method parameters that must be tuned. Notably, for most of the
methods, it is necessary to indicate whether the method should apply to the
entire dataset at once (the tuning), or whether each
condition should be normalized independently of the others (the
tuning).

Other parameters are method specific:

Once the method is correctly parametrized, click on
.
Observe the influence of the normalization method on the graphs.
%Optionally, click on “Show plot options”, so as to tune the graphics for a
%better visualization.
If the result of the normalization does not correspond to the expectations,
change the normalization method or change its tuning.
Once the normalization is effective, click on .
Check that a new version appears in the dataset version drop-down menu,
referred to as or .

Classically, missing values are categorized according to their underlying
missingness mechanism:
However, it also makes sense to classify the missing value according to the
analyte they impact, regardless of the underlying mechanism. This is why, in
, it has been decided to separate:

All the missing values for a given protein in a given condition are considered
POVs . Alternatively, , the missing values are
considered MECs.
As a result, each missing values is either POV or MEC. Moreover, for a given
protein across several conditions, the missing values can split into POVs and
MECs, even though within a same condition they are all of the same type.

With the default color setting, POVs are depicted in light blue and MECs in
light orange.

In , the following assumptions are made:

As a whole, it is advised to work at peptide-level rather than protein-level,
and to use the refined imputation mechanism of .

:

As a consequence of the previous paragraph, in protein-level datasets,
proposes to use an MCAR-devoted imputation algorithm for
POVs, and an MNAR-devoted one for MECs.

On the first tab (see Figure~), select the algorithm to
impute POV values, among the following ones, and tune its parameter
accordingly:

According to our expertise, we advise to select the algorithm
from but the other methods can also be of interest in specific
situations.

The first distribution plot depicts the mean intensity of each condition
conditionally to the number of missing values it contains.
It is useful to check that more values are missing in the lower intensity
range (due to left censorship).

The heatmap on the right hand side clusters the proteins according to their
distribution of missing values across the conditions. Each line of the map
depicts a protein. On the contrary, the columns do not depicts the replicates
anymore, as the abundance values have been reordered so as to cluster the
missing values together. Similarly, the proteins have been reordered, so as
to cluster the proteins that have a similar amount of missing values
distributed in the same way over the conditions. Each line is colored so as
to depicts the mean abundance value within each condition. This heatmap is
also helpful to decide what is the main origin of missing values (MCAR or
MNAR).

Click on . A short text shows up to summarize the
result of the imputation, but the graphics are not updated.
However, the next tab is enabled, on which the plots are updated with the
imputation results.

After POVs, it is possible to deal with MECs. As a matter of fact, it is always
dangerous to impute them, as in absence of any value to rely on, the imputation
is arbitrary and risks to spoil the dataset with maladjusted values. As an
alternative, it is possible to (1) keep the MEC as is in the dataset, yet, it
may possibly impede further processing, (2) discard them at the filter step
(see Section~) so as to process them separately. However,
this will make it impossible to include these proteins (and their processing)
in the final statistics, such as for instance FDR.

For MEC imputation, several methods are available (see
Figure~):

Based on our experience, we advise to use algorithm.

Click on . A short text shows up to summarize the
result of the imputation, but the graphics are not updated.
As the imputation is finished, the updated plots would not be informative, so
they are not displayed on the final tab (referred to as ).
Note that when displaying or exporting the data, the color code used with
missing values is still used for the imputed values, so that at any moment,
it is possible to trace which proteins were imputed.

Notice that at peptide level, many lines of the dataset may corresponds to
identified peptides with no quantification values.
In order to avoid spoiling the dataset with their meaningless imputed values,
it is demanded to filter them before proceeding (see
Section~).

Two plots are available in order to facilitate the understanding of the
missing value distribution.
These plots are the same as for protein-level imputation:

The distribution plot on the left depicts the mean intensity of each condition
conditionally to the number of missing values it contains.
It is useful to check that more values are missing in the lower intensity
range (due to left censorship).

The heatmap on the right hand side clusters the proteins according to their
distribution of missing values across the conditions. Each line of the map
depicts a protein. On the contrary, the columns do not depicts the replicates
anymore, as the abundance values have been reordered so as to cluster the
missing values together. Similarly, the proteins have been reordered, so as
to cluster the proteins that have a similar amount of missing values
distributed in the same way over the conditions. Each line is colored so as
to depicts the mean abundance value within each condition. This heatmap is
also helpful to decide what is the main origin of missing values (MCAR or
MNAR).

To impute the missing peptide intensity values, it is either possible to rely on
classical methods of the state of the art, or to use . The former
ones are available by choosing in the
drop-down menu (see Figure~). Another drop-down menu
appears proposing one of the following methods:
All these methods are applied on all missing values, without diagnosing their
nature, as explained in Section~.
Alternatively, it is possible to rely on (see
Figure~). It works as follows:

It is possible to directly visualize the effect of an imputation method on
the updated plots. If the imputation does not produce the expected effect,
it is possible to test another one. To do so, one chooses another
method in the list and click on .
This action does not modify the dataset but offers a
preview of the imputed quantitative data.
It is possible to visualize as many imputation methods/tuning as desired.
Once the correct one is found, one validates the choice by clicking on
. Then, a new “imputed” dataset is created and loaded
in memory. This new dataset becomes the new current dataset and the “Imputed”
version appears in the upper right drop-down menu. All plots and tables in
other menus are automatically updated.

This steps only hold for peptide-level dataset. Its purpose is to build a
protein-level dataset on the basis of the peptide intensities that have been
processed in .

If this step has not been fulfilled at the initial data conversion (see
Section~), it is first necessary to specify which column
metadata of the peptide-level dataset contains the parent protein IDs
(which will be used to index the protein-level dataset that is going to be
created).

Once the parent protein IDs are specified, two barplots are displayed
(see Figure~). They provide the distribution
of proteins according to their number of peptides (either all of them, or
only those which are specific to a single protein). These statistics are
helpful to understand the distribution of shared peptides, as well as the
peptide/protein relationships.

Aggregation requires to tune the following parameters:

Once the aggregation is appropriately tuned, click on
.

On the second tab, one selects the columns of the peptide dataset that
should be kept in the metadata of the protein dataset (e.g. the sequence of the
peptides). For any given parent-protein, the corresponding information of all
of its child-peptides will be grouped and stored in the protein dataset
metadata. Once done, one clicks on . This creates a
new “aggregated” dataset that is directly loaded in memory.

As the new dataset is a protein one, the menu has been
disabled. Thus, the interface automatically switches to the homepage. However,
the aggregated dataset is accessible and can be analyzed (in the
menu) and processed (in the menu).

The aggregation being more computationaly demanding than other processing
steps, the current version of does not provide the same
flexibility regarding the parameter tuning. Here, it is necessary to save the
aggregation result first, then, check the results in the
,
and possibly to go back to the imputed dataset with the dataset
versions dropdown menu to test another aggregation tuning. Contrarily to
other processing steps, it is not possible to visualize on-the-fly the
consequences of the parameter tuning, and to save it afterward.

Naturally, the output of this step is not a peptide dataset anymore, but a
protein dataset. As a result, all the plots available in
are deeply modified. Notably, all those which are meaningless at a protein-level
are not displayed anymore.

For datasets that do not contain any missing values,
or for those where these missing values have been imputed,
it is possible to test whether each protein is significantly
differentially abundant between the conditions.
To do so, click on in the
menu (see Figure~).

First, choose the test contrasts. In case of 2 conditions to compare, there is
only one possible contrast.
However, in case of \(N \geq 3\) conditions, several pairwise contrasts are
possible.
Notably, it is possible to perform \(N\) tests of the type, or
\(N(N-1)/2\) tests of the type.
Then, choose the type of statistical test, between limma (see the
package) or t-test (either Welch or Student, up to the user’s
choice). This makes appear a density plot representing the log fold-change
(logFC) (as many density curves on the plot as contrasts). Thanks to the FC
density plot, tune the .
We advise to tune the logFC threshold conservatively by avoiding discarding to
many proteins with it. Moreover, it is important tune the logFC to a small
enough value, so as to avoid discarding too many proteins. In fact, it is
important to keep enough remaining proteins for the next coming FDR
computation step (see Section~), as FDR
estimation is more reliable with many proteins, FDR, which relates
to a percentage, does not make sense on too few proteins.
Finally, run the tests and save the dataset to preserve the results (i.e. all
the computed p-values). Then, a new dataset containing the p-values and logFC
cut-off for the desired contrasts, can be explored in the tab available in the menu.

Several plots are proposed to help the user have a
quick and as complete as possible overview of the dataset. This menu is
an essential element for to check that each processing step
gives the expected result.

This panel simply displays a table summarizing various quantitative elements
on the datasets (see Figure~).
It roughly amounts to the data summary that is displayed along with each demo
dataset (see Section~).

On the second tab, barplots depicts the distribution of missing values: the
left hand side barplot represents the number of missing values in each sample.
The different colors correspond to the different conditions (or groups, or
labels). The second barplot (in the middle) displays the distribution of
missing values; the red bar represents the empty protein count (i.e. the
number of lines in the quantitative data that are only made of missing values).
The last barplot represents the same information as the previous one, yet,
condition-wise. Let us note that protein with no missing values are
represented in the last barplot while not on the second one (to avoid a too
large Y-scale).

The third tab %is the data explorer (see Figure 4): it
makes it possible to view the content of the MSnset structure. It is made of
three tables, which can be displayed one at a time thanks to the radio button
menu. The first one, named contains the intensity
values (see Figure~).

The missing values are represented by colored empty cells. The second one is
referred to . It contains all the column dataset that
are not the quantitative data (see Figure~).

The third tab, , summarizes the experimental
design, as defined when converting the data (see Section~).

In this tab, it is possible to visualize the extent to which the replicates
correlate or not (see Figure~). The contrast of the correlation
matrix can be tuned thanks to the color scale on the left hand side menu.

A heatmap as well as the associated dendrogram is depicted on the fifth tab
(see Figure~). The colors represent the intensities: red for
high intensities and green for low intensities. White color corresponds to
missing values. The dendrogram shows a hierarchical classification of the
samples, so as to check that samples are related according to the experimental
design. It is possible to tune the clustering algorithm that produces the dendrogram by adjusting the two parameters of
the function:

A Principal Component Analysis visualization is provided by wrapping the
package (see Figure~). To better interpret
the PCA displays, the reader is referred to the
documentation.

These plots shows the distribution of the log-intensity of proteins for each
condition (see Figure~).

The left hand plot represents a smoothed histogram of each sample intensity.
The right hand side plot display the same information under the form of a
boxplot or a violin plot, depending on the user’s choice. In both cases, it is
possible to ajust the plot legends, as well as to specify the color code
(one color per condition or per sample).

Finally, the last tabs display a density plot of the variance (within each
condition) conditionally to the log-intensities (see
Figure~).
As is, the plot is often difficult to read, as the high variances are
concentrated on the lower intensity values.
However, it is possible to interactively zoom in on any part of the plot by
clicking and dragging (see Figure~).

If one clicks on in the
menu, it is possible to analyze the protein-level outputs of all statistical
tests (see Section~).
Such analysis follows 5 steps, each corresponding to a separate tab in the
menu.

On the first tab, select a pairwise comparison of interest.
The corresponding volcano plot is displayed. By clicking on a protein in the
volcano plot, one or several tables appears below the plot. In any case, a
table containing the intensity values of the protein across the samples is
displayed, with the same color code as in the Data explorer (for missing
values for instance). In addition, if peptide-level information has been
uploaded in the session, then, the intensity values of the
protein can be linked to the original peptides of the dataset. Thus, the
peptides intensities (for both protein-specific and shared peptides) are
displayed in the 2 other tables.

Possibly, swap the FC axis with the corresponding tick-box, depending on
layout preferences. Possibly, push some p-values to 1, as detailed in
Section~ (see Figure~).

Then move on to the next tab, referred to as
(see Figure~).
Possibly, tune the calibration method, as as detailed in
Section~.

Move on to the next tab and adjust the FDR threshold (see
Figure~), which corresponds to the horizontal dashed line
on the volcano plot. The checkbox `Show p-value table'' displays a table below the volcano plot, where each line represents a protein along with its p-value and logFC. Moreover, it is indicated by a binary variable if, according to the FDR threshold, the protein is deemed differentially abundant or not. For better visualization, this binary variable also encodes the color code applied to each line. The`Tooltip’’ parameter amounts to the list of
the avialable meta-data. It is possible to select several of them. The
selected one will (1) appear beside the mouse pointer when flying over each
protein point in the volcano plot; (2) add the corresponding column in the
table below the volcano plot. This table can be easily exported: The user only
has to choose whether all the proteins should appear in the exported table, or
only the differentially abundant ones. The volcano plot can be saved thanks to
the menu available in the upper right corner of the plot.

Move on to the last tab (referred to as ) to have a
comprehensive overview of the differential analysis parameters (see
Figure~). If necessary copy/paste this table for later use.

Possibly, go back to the first tab, so as to select another pairwise
comparison and process it. Alternatively, it is possible to continue with the
current protein list so as to explore the functional profiles of the proteins
found statistically differentially abundant between the compared conditions
(see Section~).

When working on more than two conditions to compare, the missing value
filtering options may be difficult to tune, as a given protein can be
well-observed in a group of conditions (with no or few missing values) and
largely missing in the remaining conditions. To avoid missing relevant
proteins with such a behavior, it is advised to be rather loose at the
filtering step (for instance by filtering only proteins that are never seen in
the majority of the samples of each condition).

However, with loose filters, proteins with many missing values are kept in the
dataset and are then imputed, so as to present a complete intensity
distribution for the differential analysis.
Therefore, when focusing on a specific comparison among the multiple possible
ones, it is thus possible to face proteins which have largely been imputed in
the two conditions, so that in practice, one analyses the differential
abundance of a protein that is probabibly missing in the two conditions. From
an analytical viewpoint, such protein must not appears as differentially
abundant, even if its p-value is exceptional, for it is too largely based on
imputed values that are not trustworthy.

This is why, the push p-value option is proposed: it makes it possible to
force the p-values of these proteins to 1, and prevent them to become false
discoveries. Concretely, one simply has to tune
parameters of the menu, which are similar to those of the missing value
filtering (Section~). However, instead of producing
discarding some proteins, it keeps them with a p-value forced to 1 (i.e. a
log(p-value) to 0).

As an illustration, Figure~ displays a case were all the
proteins with less than 2 observed (i.e. not imputed) values within each
condition have their p-values pushed to 1. These proteins appear as points on
the horizontal axis of the graph. Notably, the snapshot was made when the
mouse pointer had clicked on one of these proteins which p-value was pushed
(the one with an intensity value between 5.5 and 6). Its intensity values
across the samples appears in the table below, where one observes that 5 out
of 6 values are colored as POV or MEC (see Section~).
Clearly, such a protein as very poor mass spectrometry evidence, so that even
if the imputed values are of different magnitude (leading to a theoretically
appealing p-value), it makes sense to discard it.

The primary goal of a calibration plot is to check that the p-values have a
distribution that is compliant with FDR computation theory.
Given a supposedly known proportion of non-diffentially abundant proteins
(generally noted \(\pi\_0\)), a good calibration plot is supposed to depict a
curve that follows a straight line of slope \(\pi\_0\) except for a sharp
increase on the right hand side, as depicted on Figure~.
The sharp increase, which is the sign of a good discrimination between
proteins which are differentially abundant and those which are not, is
depicted in green. On the contrary, any bulb of the curve above the \(\pi\_0\)
line (in blue), anywhere in the middle of the graph is depicted in red, for
it is the sign of an insufficient calibration. On Figure~,
the calibration deviation is almost immaterial and the sharpness of the right
hand side increase is real: both can be noticed thanks to colored caption
(*Uniformity underestimation* relates to possible red bulps and
*DA protein concentration* relates to the sharpness of the green region; the
last caption, in blue, being \(\pi\_0\)).

However, it is possible to face situations where the right hand side is not
sharp enough (see Figure~), or where the entire distribution
is ill-calibrated (see Figure~).
In such a cases, FDR computation would lead to spurious values and to
biologically irrelevant conclusions. However, if the calibration is not too
bad, it is possible to compensate it, by overestimating \(\pi\_0\). This what the
first calibration is made for (see Figure~): several
different estimates are depicted by lines of various slope, so as to help the
practitioner to choose the most adapted one to the p-value distribution at
hand. In the worst case, it is always possible to chose the Benjamini-Hochberg
options (corresponding to the safer case of \(\pi\_0=1\)), which is not
represented on the graph for it always corresponds to a diagonal line.

For more details, the interested reader is referred to the
package and the companion publication available in the ``Useful links’’ page
of (as well as our tutorial on FDR published by JPR in 2017,
also referenced on the same page).

The Gene Ontology (GO, ) is a controlled
vocabulary for
annotating three biological aspects of gene products. This ontology is made of
three
parts : Molecular Function (MF), Biological Process (BP) and Cellular Component
(CC).

is proposed in the menu. It aims to provide the user with a global view of what is
impacted (in a biological point of view) in the experiment, by showing which
GO terms are represented (GO classification tab), or over-represented compared
to a reference (GO enrichment tab).

relies on the package to perform
both GO Classification and GO Enrichment. We propose a GO analysis interface
with four separated tabs (see Figure~):
The left-hand side of the tab allows it to set the input
parameters, namely:

Once these parameters filled, clicking on launches
the mapping
of the IDs onto the GO categories of the annotation package.
Then, on the right-hand side of the panel,
the proportion of proteins that cannot be mapped onto the annotation package
is indicated (this informative ouput does not interrupt the process, unless no
protein maps). Next step is to perform either GO Classification or GO
Enrichment (or both).

In the tab (see Figure~), one has
to indicate which level(s) of the ontology to consider.
Then clicking on the “Perform GO grouping” button launches the analysis
(function of the package).
The graphics shows the most represented GO categories for a user-defined
ontology at (a) user-defined level(s).

The tab (see Figure~) allows it to
know which
GO categories are significantly enriched in the users list, compared
to a chosen reference (‘background’ or ‘universe’).
This background can either be :

The enrichment tab calls the function of the
package. This function performs a significance test
for each category, followed by a multiple test correction at a user-defined
level.
Concretely, this level is tuned thanks to
the “FDR (BH Adjusted \(P\)-value cutoff)” field.
Analysis is launched by clicking the
button.

Once the analysis has been performed, the result is displayed via two graphics
on the right-hand side of the panel (see Figure~).
The first one (top) is a barplot showing the five most significant categories.
The length of each bar represents the number of proteins within the
corresponding category.
The second one (bottom) is a dotplot ranked by decreasing ,
which reads:
\[
{\textit{GeneRatio}}
=
\frac{\#(\mbox{Genes of the input list in this category})}
{\#(\mbox{Total number of Genes in the category})}.
\]

The last tab is the one. It allows saving the results:
GO classification, GO enrichment, or both (see Figure~).
Then, a new GOAnalysis dataset is created and loaded in memory.

As usual in Prostar, it is possible to export this new dataset via the
menu, either in MSnSet or in Excel format.

%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%
%

%

```
sessionInfo()
```

```
## R version 4.5.1 Patched (2025-08-23 r88802)
## Platform: x86_64-pc-linux-gnu
## Running under: Ubuntu 24.04.3 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.22-bioc/R/lib/libRblas.so
## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## time zone: America/New_York
## tzcode source: system (glibc)
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.30
## [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
## [13] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
## [16] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
## [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```