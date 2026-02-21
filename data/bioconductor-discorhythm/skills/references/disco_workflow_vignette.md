# Introduction to *[DiscoRhythm](https://bioconductor.org/packages/3.22/DiscoRhythm)*

Matthew Carlucci1\*, Algimantas Kriščiūnas2, Haohan Li1, Povilas Gibas2, Karolis Koncevičius2, Art Petronis1,2 and Gabriel Oh1

1The Krembil Family Epigenetics Laboratory, The Campbell Family Mental Health Research Institute, Centre for Addiction and Mental Health
2Institute of Biotechnology, Life Sciences Center, Vilnius University, Vilnius, Lithuania

\*matthew.carlucci@camh.ca

#### 29 October 2025

#### Package

DiscoRhythm 1.26.0

# 1 Introduction

DiscoRhythm is a framework for analyzing periodicity of large scale temporal
biological datasets (e.g. circadian transcriptomic experiments).
The main goal of this package is to characterize the rhythmicity present in the
provided dataset by performing the following steps:

1. Import and clean-up
2. Outlier detection
3. Principal component analysis
4. Analysis of experimental replicates
5. Detection of dominant rhythmicities
6. Detection of feature-wise oscillation characteristics111 Estimating cyclical characteristics such as: period, phase,
   amplitude, and statistical significance using four methods
   (Cosinor, JTK Cycle, ARSER, and Lomb-Scargle).

The entire workflow can be run interactively in the web application or run
directly in R.

Section [4](#input-format) specifies the data input format expected by the
DiscoRhythm app.

Next, section [5](#discorhythm-interface-walkthrough) will describe all the
analysis steps and their purpose.
Section
[6](#discorhythm-r-usage) will then demonstrate how to generate the same
results using the DiscoRhythm R package directly from the R command line.

# 2 Getting Started

## 2.1 Accessing the Graphical User Interface

The public server for DiscoRhythm is available
[here](https://disco.camh.ca)222 Users will be timed out of this server
after a session is idle for 30 minutes
after the last computation has completed..

The web application currently has no auto-save functionality, **results will be
lost upon session termination.** It may be helpful to use the report
feature (see [5.6.2.2](#report)) which automatically downloads results
upon completion.

To start using DiscoRhythm directly from the web application proceed to
[5](#discorhythm-interface-walkthrough).

## 2.2 Local Installation

To run the application locally or use DiscoRhythm with R, the DiscoRhythm R
package and its dependencies333 Installation of [pandoc](https://pandoc.org/installing.html)
is required in order to use the report
generation features of DiscoRhythm. must be installed by executing the
following
commands in R:

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("DiscoRhythm")
```

The following commands then can be used in order to launch the
DiscoRhythm application:

```
library(DiscoRhythm)
discoApp()
```

For improved performance DiscoRhythm can be parallelized using multiple cores:

```
discoApp(ncores=number_of_available_cores)
```

### 2.2.1 Run the Web Application with Docker (Optional)

Alternatively, if [docker](https://docs.docker.com/install/) is installed, the
[DiscoRhythm container on Docker Hub](https://hub.docker.com/r/mcarlucci/discorhythm)
can be pulled and used to run the web application locally444 See instructions on Docker Hub.
avoiding the need to install DiscoRhythm and its dependencies

## 2.3 Using DiscoRhythm from R

The same computations performed in the web application can be executed directly
in R. This may help with:

* Analyzing large datasets
* Executing the workflow conveniently on multiple datasets
* Including additional R code to customize the workflow

Section [6](#discorhythm-r-usage) describes using DiscoRhythm from R in more
detail.

# 3 Background

## 3.1 Key Definitions for Rhythm Detection in Biological Time Series

**Sinusoid** - A mathematical curve that describes periodic oscillations
following a sine function.

**Period** - Parameter describing the duration after which a temporal pattern
repeats itself.

**Acrophase** - The time in a periodic cycle where a temporal pattern is at its
maximum value, typically referring to the peak of a sinusoid curve.

**Amplitude** - The amount of change in signal seen during the course of an
oscillation.

**P-value** - Described simply, it is the probability that a finding could have
occurred under the null hypothesis. For rhythm detection, this would be the
probability that the “goodness of fit” of a rhythmic model would occur at a
value greater than or equal to the observed value when applied to a non-rhythmic
signal.

**Biological replicates** - Independent random samples from the population of
interest with the same time of collection.

**Technical replicates** - A single biological sample split into multiple
samples which are processed independently are typically labelled as “technical
replicates”. They are useful for determining the variance
introduced simply by the process of sample preprocessing.

## 3.2 Real-world Example Datasets

DiscoRhythm was designed for large scale “-omic” data matrices such as those
found in the following studies:

Krishnaiah et al. ([2017](#ref-Krishnaiah2017-lm)) - circadian metabolomics study, where data matrices from
supplemental table 2 may be used as input to DiscoRhythm after removing the
first row from each sheet and saving as CSV. The “Liver\_data” sheet may be used
after the following modifications:

1. Remove row 2 (non-essential metadata)
2. Remove ‘Set[1-2]-’ from all column names (DiscoRhythm column name format)
3. Save as CSV

Hurley et al. ([2018](#ref-Hurley2018-hg)) - A circadian proteomic study, where supplemental dataset 2 may
be
used as input to DiscoRhythm after saving sheet “2B” or “2H” as CSV.

Wu et al. ([2016](#ref-Wu2016-rd)) - This software package contains truncated transcriptomic datasets
that can be exported from R for use with DiscoRhythm, including a simulated
dataset (object name cycSimu4h2d) containing various waveforms to test the
performance of the rhythm detection algorithms.

Singer, Fu, and Hughey ([2019](#ref-Singer2019-lq)) - The *[simphony](https://github.com/hugheylab/simphony)* R package
can be used to generate complex simulated “-omic” datasets, which can easily be
formatted for input to DiscoRhythm.

See section [4](#input-format) for full details on input data format.

## 3.3 Further Background References

For a more detailed background on statistical methods, experiment design, and
method selection see the following references:

Cornelissen ([2014](#ref-Cornelissen2014-sa)) - A detailed review of Cosinor based techniques for rhythm
analysis. The cosinor test as presented in Cornelissen et. al. (2014) is a
common hypothesis test, which may appear in the literature as “Cosinor”,
“harmonic regression”, “sinusoid regression”, and other similar names.

Hughes et al. ([2017](#ref-Hughes2017-ik)) - Experiment design for circadian sequencing experiments.
Provides additional comments on p-values obtained from rhythm detection methods.

Deckard et al. ([2013](#ref-Deckard2013-pm)) - Evaluates 4 methods (de Lichtenberg, Lomb-scargle, JTK Cycle,
and persistent homology) and Fig. 6 provides a clear decision tree to aid with
the selection of the most suitable method for practical data analysis.
This publication references additional method evaluation articles.

Wu et al. ([2014](#ref-Wu2014-mo)) provides an empirical evaluation of 5 methods (ARSER, JTK Cycle,
COSOPT,
Fisher’s G test, and HAYSTACK).

These references also provide some valuable insights about the experiment design
stage of rhythm detection.
(see section [5.6.1.1](#algorithm-restrictions) for a few additional comments).

## 3.4 Available Methods

The four currently implemented methods in DiscoRhythm are well established and
have sound statistical methodology. These methods were easily accessed or
implemented in R and fit well into the workflow for rhythmicity analysis.
Additional algorithms fitting this criteria may be added to DiscoRhythm in the
future. Below are some quotes taken directly from publications of these methods,
briefly describing the rationale for each:

### 3.4.1 Cosinor

Cornelissen ([2014](#ref-Cornelissen2014-sa))

> “Conceived as a regression problem, the
> method is applicable to non-equidistant data, a major advantage.”

and referring to least squares techniques more generally:

> “useful in curve-fitting problems,
> where it is desirable to obtain a functional form that best fits a given set of
> measurements.”

### 3.4.2 JTK Cycle

Hughes, Hogenesch, and Kornacker ([2010](#ref-Hughes2010-st))

> “JTK\_CYCLE’s increased resistance to outliers
> results in considerably greater sensitivity and specificity”

### 3.4.3 Lomb-Scargle

Glynn, Chen, and Mushegian ([2006](#ref-Glynn2006-rv))

> “Our approach should be applicable for
> detection and quantification of periodic patterns in any unevenly spaced gene
> expression time-series data.”

### 3.4.4 ARSER

Yang and Su ([2010](#ref-Yang2010-os))

> “ARSER was superior to two existing and widely-used
> methods, COSOPT and Fisher’s G-test, during identification of sinusoidal and
> non-sinusoidal periodic patterns in short, noisy and non-stationary time-series”

# 4 Input Format

Description of the input format expected by DiscoRhythm.

## 4.1 Example Dataset

Below is a small simulated circadian transcriptomic dataset generated using
*[simphony](https://github.com/hugheylab/simphony)*, which follows the expected input
format for DiscoRhythm. The dataset was generated to contain ~50% rhythmic
transcripts with many different phases of oscillation.

| IDs | CT0\_1\_A | CT0\_2\_B | CT0\_3\_C | CT4\_4\_D | CT4\_5\_E |
| --- | --- | --- | --- | --- | --- |
| nonRhythmGene\_Id1 | 6.3717658 | 4.0909466 | 8.3010577 | 7.0240708 | -4.6510406 |
| nonRhythmGene\_Id2 | -2.4340798 | -5.6695362 | -3.0800470 | -0.1800393 | 3.1282445 |
| nonRhythmGene\_Id3 | -9.8373929 | -5.8738313 | -0.7793628 | -2.7236067 | 2.6574806 |
| nonRhythmGene\_Id4 | 4.5951368 | 0.2952068 | 3.5660223 | -1.2458999 | 6.1385621 |
| nonRhythmGene\_Id5 | 0.3980836 | 3.9928686 | 1.5626314 | 0.0613089 | 0.7013376 |
| nonRhythmGene\_Id6 | -0.2139567 | -2.4819291 | -6.5602675 | -1.9901769 | -7.5526251 |

## 4.2 Row Names

The first column should contain unique feature IDs (e.g. gene names in this
case).

| IDs | CT0\_1\_A | CT0\_2\_B | CT0\_3\_C | CT4\_4\_D | CT4\_5\_E |
| --- | --- | --- | --- | --- | --- |
| nonRhythmGene\_Id1 | 6.3717658 | 4.0909466 | 8.3010577 | 7.0240708 | -4.6510406 |
| nonRhythmGene\_Id2 | -2.4340798 | -5.6695362 | -3.0800470 | -0.1800393 | 3.1282445 |
| nonRhythmGene\_Id3 | -9.8373929 | -5.8738313 | -0.7793628 | -2.7236067 | 2.6574806 |
| nonRhythmGene\_Id4 | 4.5951368 | 0.2952068 | 3.5660223 | -1.2458999 | 6.1385621 |
| nonRhythmGene\_Id5 | 0.3980836 | 3.9928686 | 1.5626314 | 0.0613089 | 0.7013376 |
| nonRhythmGene\_Id6 | -0.2139567 | -2.4819291 | -6.5602675 | -1.9901769 | -7.5526251 |

All subsequent columns contain experimental sample data.

| IDs | CT0\_1\_A | CT0\_2\_B | CT0\_3\_C | CT4\_4\_D | CT4\_5\_E |
| --- | --- | --- | --- | --- | --- |
| nonRhythmGene\_Id1 | 6.3717658 | 4.0909466 | 8.3010577 | 7.0240708 | -4.6510406 |
| nonRhythmGene\_Id2 | -2.4340798 | -5.6695362 | -3.0800470 | -0.1800393 | 3.1282445 |
| nonRhythmGene\_Id3 | -9.8373929 | -5.8738313 | -0.7793628 | -2.7236067 | 2.6574806 |
| nonRhythmGene\_Id4 | 4.5951368 | 0.2952068 | 3.5660223 | -1.2458999 | 6.1385621 |
| nonRhythmGene\_Id5 | 0.3980836 | 3.9928686 | 1.5626314 | 0.0613089 | 0.7013376 |
| nonRhythmGene\_Id6 | -0.2139567 | -2.4819291 | -6.5602675 | -1.9901769 | -7.5526251 |

## 4.3 Column Names

Sample metadata is extracted from the column names of the matrix.

| IDs | CT0\_1\_A | CT0\_2\_B | CT0\_3\_C | CT4\_4\_D | CT4\_5\_E |
| --- | --- | --- | --- | --- | --- |
| nonRhythmGene\_Id1 | 6.3717658 | 4.0909466 | 8.3010577 | 7.0240708 | -4.6510406 |
| nonRhythmGene\_Id2 | -2.4340798 | -5.6695362 | -3.0800470 | -0.1800393 | 3.1282445 |
| nonRhythmGene\_Id3 | -9.8373929 | -5.8738313 | -0.7793628 | -2.7236067 | 2.6574806 |
| nonRhythmGene\_Id4 | 4.5951368 | 0.2952068 | 3.5660223 | -1.2458999 | 6.1385621 |
| nonRhythmGene\_Id5 | 0.3980836 | 3.9928686 | 1.5626314 | 0.0613089 | 0.7013376 |
| nonRhythmGene\_Id6 | -0.2139567 | -2.4819291 | -6.5602675 | -1.9901769 | -7.5526251 |

Names555 All fields should contain only alphanumeric values (with the
exception
of ‘.’ in the `Time` field which is allowed for decimal values. are expected to follow the pattern:

`Prefix` `Time`\*\_`Unique Id`\_`Replicate Id`

Descriptions of the naming convention used by DiscoRhythm.
\* *Mandatory field*

| Field | Description | Examples |
| --- | --- | --- |
| `Prefix` | A unit of time that will be used by the web application. | `hr`, `ZT`, `CT` |
| `Time`\* | Indicates the time of collection for the respective sample. Can only be positive. | `20`, `2.1`, `0.3` |
| `Unique Id` | Used to uniquely identify samples in visualizations and summaries. | `GSM3186429`, `sample1`, `subjectA`, `AX` |
| `Replicate Id` | Used to identify each biological sample uniquely when combined with `Time`. | `1`, `A`, `rep1` |

**Sample Time -** `Time`666 `32`, `CT32`, `CT32_AS_1`, `32_AS_1` are all valid naming styles. is the only mandatory field and the other
fields
are used to
specify the additional information about samples when necessary.

**Biological vs Technical Replicates -** `Time` + `Replicate Id`777 If no `Replicate Id` is provided, all samples are assumed to be
independent biological replicates. are used
to identify independent samples collected at the same timepoint (biological
replicates). Samples with the same `Time` and `Replicate Id`
are assumed to be technical replicates originating from a single biological
sample.

**Unique Sample Identity -** Each column name should be unique such that all
samples can be uniquely identified to the user. The `Unique Id` field is
intended for this purpose. If column
names are not unique, the `Unique Id` field will be generated to provide
unique sample names during usage of DiscoRhythm.

### 4.3.1 Processed Metadata Table

The `Time` and `Replicate Id` data extracted from the column names
will be seen throughout the DiscoRhythm application888 This table is the `colData(se)` data stored in R. as:

|  | ID | Time | ReplicateID |
| --- | --- | --- | --- |
| CT0\_1\_A | CT0\_1\_A | 0 | A |
| CT0\_2\_B | CT0\_2\_B | 0 | B |
| CT0\_3\_C | CT0\_3\_C | 0 | C |
| CT4\_4\_D | CT4\_4\_D | 4 | D |
| CT4\_5\_E | CT4\_5\_E | 4 | E |
| CT4\_6\_F | CT4\_6\_F | 4 | F |

---

*Note: If there is more relevant metadata in the experiment that does not fit
into the design specified in this section, it may
be appropriate to split the
dataset into several parts and use each subgroup as a separate input for
DiscoRhythm. Example: If the experiment includes multiple conditions, each
condition may be an independent input dataset for DiscoRhythm.*

## 4.4 Circular and Linear Time

DiscoRhythm defines time within a dataset in one of two ways:

1. Linear time
2. Circular time

Linear time exists in systems where an experiment start time is meaningful
(often setting t=0 to some specific event). Circular time exists in experiments
where the start of experiment is not meaningful or left unobserved
(e.g. time-of-day in a cross-sectional study). For a specific dataset, one of
these
two types has to be selected and it will have an influence on how the
DiscoRhythm analysis will be performed.

Example of linear time in hours: `1,2,3 ... 24,25,26`

For example, circadian studies with mice often entrain to a 24hr light/dark
schedule and then release mice into total darkness in order to remove external
cues. The presence of a specific event
(release into total darkness) would make the dataset suitable for the “Linear
time” setting of DiscoRhythm.

On the other hand, if samples were collected during the entrainment to the
light/dark base-cycle, “Circular time” would be appropriate as mice sampled at
the
same point in the cycle on different days may be treated as biological
replicates (Hughes et al. [2017](#ref-Hughes2017-ik)).

# 5 DiscoRhythm Interface Walkthrough

This section will walk the user through each section of the DiscoRhythm web
application. It is recommended to keep this documentation open during
the first use of the application in order to track what the application is doing
in each section.

## 5.1 The Interface

The DiscoRhythm web interface is a dashboard where the sections of the
analysis progress in a sequential fashion with data from the previous step
being carried over to the next.
Each section can be accessed using the sidebar on the left.

Interactive controls allow users to set parameters specific to each section’s
analysis.
When parameters relevant to a figure change, the corresponding figure will
dynamically update to reflect the newly calculated results. The exception
to this is the oscillation detection section which requires user input to
re-compute results.

Various download buttons are available throughout
the application for extracting plot outputs and numerical results.

![Screenshot of the initial DiscoRhythm landing page.](data:image/jpeg;base64...)

Figure 1: Screenshot of the initial DiscoRhythm landing page

## 5.2 Select Data

**Purpose:** To upload, clean, and summarize the experimental design of the
provided dataset.

![Screenshot of the 'Select Data' section of the DiscoRhythm interface.](data:image/jpeg;base64...)

Figure 2: Screenshot of the ‘Select Data’ section of the DiscoRhythm interface

An input dataset is expected to be in comma separated value (CSV) format as
specified in section [4](#input-format). Upload the dataset using the
“upload CSV” input method.

The simulated dataset (from section [4.1](#example-dataset)) is available to
test the features of DiscoRhythm.

Messages or warnings may be seen at this point as DiscoRhythm imports
the dataset and performs a few clean-up tasks:

1. Rows with constant values will be removed
2. Rows with any number of missing values will be removed
3. Validity of column name formatting will be checked999 Duplicate column names will be deduplicated by replacing all
   `Unique Id` with unique sample keys.
4. Duplicate row names will be made unique

Some oscillation detection algorithms are capable of handling rows with
missing values, however, this currently may only be performed via R
(using the `discoODAs` function).

### 5.2.1 Specify Dataset Parameters

**Time Type -** See [4.4](#circular-and-linear-time).

**Period of Interest -** The main hypothesized period should be specified in
order to set appropriate defaults throughout the application. If unknown, set it
to the range of the sample collection times.

**Time Unit/Observation Unit -** Units to display in the axis labels throughout
the application.

If the “Sampling Summary” table does not seem to accurately reflect the data,
please refer back to section [4.3](#column-names). It is also a good idea
to expand the “Inspect Input Data Matrix” and “Inspect Parsed Metadata” boxes
to ensure the data has been read correctly.

In “Inspect Parsed Metadata” it is possible to override the
metadata extracted from the column names with an independent CSV table which
matches the metadata table format outlined in [4.3.1](#processed-metadata-table),
however, this is not recommended for regular use.

## 5.3 Outlier Removal

Experimental artifacts commonly result in data not accurately reflecting the
true biological phenomenon. This can often be observed through systematic
signals from a single sample that do not have biological plausibility.
DiscoRhythm attempts to detect such systematic
outliers with the use of two separate methods:

* Intersample-correlations
* Principal component analysis

Each method is applied independently to the dataset in order to detect outliers.
The filtering summary section is then used to decide which detected outliers to
remove. A reasonable standard deviation threshold for both methods would be
around 2 to 3.

**By default, no outliers will be flagged for removal.** The DiscoRhythm web
application will set the default threshold such that no outliers are flagged.

### 5.3.1 Inter-sample Correlation

**Purpose:** In order to detect outliers, samples are pairwise correlated using
either the Pearson or Spearman method.

**Heatmap:** The values of these pairwise correlations can be visualized in this
tab, where samples with similar correlation values are grouped
together using clustering.

**Outlier Detection:** The average correlation value for each sample is used as
a metric of its overall similarity to all other samples and is summarized in
this figure.

Samples with average correlations significantly below the mean will be flagged
as outliers and the user may specify a number of standard deviations below the
mean to use as a threshold.

![Screenshot of the 'Inter-sample Correlation' section of the DiscoRhythm interface.](data:image/jpeg;base64...)

Figure 3: Screenshot of the ‘Inter-sample Correlation’ section of the DiscoRhythm interface

### 5.3.2 Principal Component Analysis

**Purpose:** Utilize principal component analysis (PCA) to detect outliers.

PCA is used to extract the strongest recurring patterns in the dataset.
Outliers detected in these patterns (PC scores)
are flagged by their deviation from the mean where again the user may specify a
threshold in units of standard deviations.

**Scale Before PCA:** Whether to scale rows to a standard deviation of 1 prior
to PCA, such that all rows are on an equal scale.

**PCs to Use For Outlier Detection:** Click to change the list of PCs to use for
outlier removal in the
case the scores of a PC seem inappropriate for use in outlier detection. You can
remove unwanted PCs by pressing “delete” and add extra ones by typing
their number.

**Before CSV/After CSV:** Downloadable summaries of the PCA before and after the
detected outliers are removed.

Figures:

**Distributions:** The distributions of PC scores
used to detect outliers. Only the PCs colored darkly are used for
outlier detection. Outliers will be shown with an ‘x’.

**Scree:** PCs are numbered, where the amount of variance explained by each PC
(their ‘importance’) decreases with increasing PC number.
This can be seen in the “Scree” figure. Users should choose an
appropriate number of PCs to use for outlier detection by the
shape of this scree plot.

**One Pair and All Pairs:** Plotting the PC scores of the components versus one
another may reveal grouping that cannot be determined from simple analysis of
individual PCs.

![Screenshot of the 'PCA' section of the DiscoRhythm interface.](data:image/jpeg;base64...)

Figure 4: Screenshot of the ‘PCA’ section of the DiscoRhythm interface

### 5.3.3 Filtering Summary

**Purpose:** Determine how to proceed with outlier removal.

The user may, at this point, choose to remove the flagged outliers or may
disregard these flags if it is suspected the dissimilarity of these samples may
be biologically relevant. The user may also manually remove samples they deem
unreliable for further analysis.

**Raw Distributions:** A boxplot for the values of each individual sample that
can be used to further evaluate sample selection.

**Input and Final:** Shows summary tables for data before and after outlier
removal.

![Screenshot of the 'Filtering Summary' section of the DiscoRhythm interface.](data:image/jpeg;base64...)

Figure 5: Screenshot of the ‘Filtering Summary’ section of the DiscoRhythm interface

## 5.4 Row Selection

**Purpose:** Utilize any technical replicates present in the dataset to quantify
the signal-to-noise ratio for each row. Then combine technical replicates for
downstream analysis.

Technical replicates are not useful for the statistical
tests used by DiscoRhythm for oscillation detection, as they are not
representative of the populational variance of the data (*i.e.* do not satisfy
the independence assumptions). They will instead be used to identify rows of
the dataset where the biological variation is greater than the technical
variation. ANOVA procedures are used to determine whether a row has detectable
biological signal.

**ANOVA Method:** 3 options are available for ANOVA:

1. Equal Variance - all sets of technical replicates are assumed to have the
   same variance. Recommended in most cases.
2. Welch - sets of technical replicates may have different variance.
3. None - do not test rows using ANOVA.

**F-statistic Cutoff:** The user may choose to filter rows by the magnitude
of the signal-to-noise ratio rather than by statistical significance.

Replicates should be combined for downstream rhythmicity analysis. DiscoRhythm
provides three methods for combining technical replicates:

* Mean - Take the mean of each set of technical replicates
* Median - Take the median of each set of technical replicates
* Random Selection - Take one of the technical replicates for each sample at
  random

*Note: Users may also choose not to combine technical replicates. This is only
advisable if the technical replicates do in fact represent independent samples
of the population/dataset (i.e. if they were erroneously labelled in section
[4](#input-format)).*

![Screenshot of the 'Row Selection' section of the DiscoRhythm interface.](data:image/jpeg;base64...)

Figure 6: Screenshot of the ‘Row Selection’ section of the DiscoRhythm interface

## 5.5 Period Detection

**Purpose:** Summarize the strength of multiple periodicities across
the entire dataset. This section may be used for broad characterization
of the dataset, or as an exploratory analysis tool for determining the
main periodicities of the dataset to use for oscillation detection.

### 5.5.1 Period Detection

Available periods will be limited101010 For circular time, only harmonics of the
base-cycle will be available for testing (*e.g.* for 24hr base-cycle: 12hr,
8hr *etc.*). starting from a smallest period of
3 times the sampling-interval up to the sampling duration.
12 periods, evenly spaced across this range, will be used for period detection.

![Screenshot of the 'Period Detection' section of the DiscoRhythm interface.](data:image/jpeg;base64...)

Figure 7: Screenshot of the ‘Period Detection’ section of the DiscoRhythm interface

#### 5.5.1.1 Methods

The aim of this section is to evaluate various periodicities across all
features, such that a fixed period may be chosen for oscillation detection.
While methods for determining period
strength for individual time series have been established, methods for
determining a common period across multiple parallel time series are less
clear. The period detection section attempts to determine this optimal period
by obtaining a “goodness of fit” across all features and allows for inspection
for
the period with the highest median fit.
Cosinor’s R2 was chosen over other methods of estimating model fit
quality due
to: the maturity of the method, its execution speed, and its ability to be
executed under most experiment design conditions (see
[5.6.1.1](#algorithm-restrictions)).

### 5.5.2 PC Fits

To obtain an abstract representation of the rhythmic patterns seen across the
dataset, PCA is performed to reduce dimensionality and test the summarized
temporal signal for rhythmicity (using the Cosinor method). Using an *a priori*
hypothesized period, a significant fit on **a single** PC indicates the
presence of
few phases111111 *e.g.* an oscillating principal component with an 18hr acrophase
indicates many features oscillate near 18hr and, due to negative
loadings, there may also be many features oscillating near a 6hr acrophase. in the dataset, while strong fits **to multiple** PCs
suggests that
there exist multiple phases of oscillation. Oscillations detected among the
first principal
components would be more meaningful than oscillations in the last components.
When a period is selected based on period detection results, more caution should
be taken as the reliability of the findings might suffer due to selection bias
and overfitting.

![Screenshot of the 'PC Cosinor Fits' section of the DiscoRhythm interface.](data:image/jpeg;base64...)

Figure 8: Screenshot of the ‘PC Cosinor Fits’ section of the DiscoRhythm interface

Inspection of the patterns seen in the principal
component scores may hint at other effects in the data that one should be aware
of (e.g. batch effects or unobserved confounders).

### 5.5.3 Using Results to Proceed

The two statistical summaries of the periodicity provided in the period
detection section may be used to proceed with the analysis in
“Oscillation Detection” in multiple ways. Three scenarios are provided below
to aid in illustrating some approaches for utilizing the results. The aim often
should be to proceed with a hypothesis driven analysis; however, data driven
exploratory approaches may also be used.

1. **An exact periodicity is hypothesized.** The goal is to determine which
   features fit this hypothesis.

   * Use period detection for data summary purposes only.
   * Use PC fits to summarize dominant rhythms and inspect for any odd
     patterns.
   * Proceed to oscillation detection using the hypothesized periodicity to
     detect rhythmic features.
2. **An approximate periodicity is hypothesized**, such as when subjects are
   in free running conditions. The goal is to determine which features fit this
   approximate hypothesis.

   * Use period detection to find an accurate estimate of the period.
   * Use the dominant period in oscillation detection to detect feature-wise
     rhythms.
   * Proceed to oscillation detection with the strongest period seen in period
     detection. Some caution should be taken for an increased false positive rate
     due to the period tuning procedure.
3. **The period is entirely unknown.** The goal may be to find a dominant
   periodicity with a secondary goal of identifying which features follow this
   period.

   * Use period detection to find a dominant period (period with highest median
     r-squared).
   * Use PC fits to test for a dominant periodic pattern and inspect for other
     patterns.
   * Proceed to oscillation detection with the dominant period to determine
     presence
     of feature-wise rhythms. Caution should be taken in these findings as the
     selection of period using the data will not be taken into account during
     feature-wise oscillation detection and inferences will have an increased false
     positive rate. Validation datasets are recommended to confirm feature-wise
     rhythms.

## 5.6 Oscillation Detection

**Purpose:** Individually quantify rhythmicity of remaining rows in the dataset
where each row will be tested for rhythmicity using methods suitable for the
sample collections present.

### 5.6.1 Rhythmicity Calculation Configuration

The user must choose a single period121212 If it is unknown which periodicity to test start with the dominant
period
seen in section [5.5](#period-detection). of oscillation to test across all
rows
of the dataset. The application may show warnings/messages regarding the choice
of period. By default, the period specified in the ‘Select Data’ section will be
chosen.

JTK Cycle, Lomb-Scargle, and ARSER results are all obtained through the
MetaCycle R package (meta2d function using minper=maxper). Cosinor is
provided by DiscoRhythm. A brief summary of each method:

**Cosinor** - a.k.a “Harmonic Regression” Fits a sinusoid
with a free phase parameter.

**Exclusion Criteria Matrix:** A table is presented describing the
criteria that exclude a method from being used. All exclusion criteria which are
true for the loaded dataset are shown.131313 If no criteria are present, this table will be absent. The reasons for exclusion may be
due to either computational
(causes errors under given conditions) or statistical restrictions
(requirements of study design) of the method.

| Criteria | Description |
| --- | --- |
| missing\_value | Rows contain missing values. |
| with\_bio\_replicate | Biological replicates are present. |
| non\_integer\_interval | The spacing between samples is not an integer value. |
| uneven\_interval | Time between collections is not uniform. |
| circular\_t | Time is circular (see [4.4](#circular-and-linear-time)). |
| invalidPeriod | Chosen period to test is not valid. |
| invalidJTKperiod | Chosen period to test is not valid for JTK Cycle. |

![Screenshot of the 'Oscillation Detection (Preview)' section of the DiscoRhythm interface.](data:image/jpeg;base64...)

Figure 9: Screenshot of the ‘Oscillation Detection (Preview)’ section of the DiscoRhythm interface

#### 5.6.1.1 Algorithm Restrictions

In the below matrix,141414 This matrix is from the object: `discoODAexclusionMatrix` `FALSE` indicates that the method is unable to
handle this condition:

|  | CS | JTK | LS | ARS |
| --- | --- | --- | --- | --- |
| missing\_value | TRUE | TRUE | TRUE | FALSE |
| with\_bio\_replicate | TRUE | TRUE | TRUE | FALSE |
| non\_integer\_interval | TRUE | FALSE | TRUE | FALSE |
| uneven\_interval | TRUE | FALSE | TRUE | FALSE |
| circular\_t | TRUE | TRUE | TRUE | FALSE |
| invalidPeriod | FALSE | FALSE | FALSE | FALSE |
| invalidJTKperiod | TRUE | FALSE | TRUE | TRUE |

This criteria should be considered during the design phase of an experiment
when
possible to ensure the most appropriate method will be available for use.
It may not
always be ideal to utilize multiple methods for rhythm detection as the process
of integrating the results is not well defined and may interfere with drawing
clear conclusions. Discussions regarding methods for integrating rhythm
detection results may be found in the literature:

Wu et al. ([2016](#ref-Wu2016-rd)) - Proposes Fisher’s method for integrating p-values

Users preferring to decide on
a single method are encouraged to consult the literature on which methods
are suitable under given conditions (see [3.3](#further-background-references)).

### 5.6.2 Job Submission Modes

Two modes of execution are available for oscillation detection:

1. Interactive
2. Report

On the public server only, email features are available for receiving
notifications and results.

#### 5.6.2.1 Interactive

When computations are finished, results can be visualized in the application
as seen in section [5.6.3](#visualizing-results). If an email address is provided,
an email will be sent to indicate that the computations are complete.

#### 5.6.2.2 Report

A report of the results and the rest of the DiscoRhythm session can be
generated by selecting the report method. This mode executes the entire
DiscoRhythm workflow from scratch with the current
parameter settings of the session to generate a zip
file containing:

1. An HTML report (produced by `discoBatch()`)
2. A CSV file for each rhythm detection algorithm’s results
   (produced by `discoODAs()`)
3. R data of inputs

If the input dataset is large, this may be a preffered mode
of execution over the interactive mode which
could time out before results are viewed and/or exported.
Results from the report mode will
be automatically downloaded/saved upon completion.

This is the recommended method for archiving results as
the inputs, outputs, all software versions, and the precise code used to
produce the results will be archived in one location.

If an email address is provided,
an email will be sent with the results attached upon completion.

Section [6.6.2](#importing-archived-sessions) describes how to use the Rdata
archive file to recompute results and continue an analysis in R.

### 5.6.3 Visualizing Results

Once rhythmicity computation is completed, 3 sections become available for
inspecting the results:

**Individual Models:** Allows inspection of individual rows from the raw
dataset.
User may click a row on the table in order to display the raw data values along
with a fitted periodic curve. If the Cosinor method is being viewed, the line
will be the Cosinor fit, all other methods utilize a loess fit. If the error bar
option is selected, a 95% confidence interval on the mean will be displayed for
each timepoint.

**Summary:** Summarizes calculated rhythm parameters across all tested rows
by all executed methods.

**Method Comparison:** Offers pairwise comparison of rhythmic parameters
calculated by each method to determine the degree of agreement between them.

![Screenshot of the 'Oscillation Detection' section of the DiscoRhythm interface.](data:image/jpeg;base64...)

Figure 10: Screenshot of the ‘Oscillation Detection’ section of the DiscoRhythm interface

*Note on method comparison: This section should not be used as evidence of
rhythmicity, and rather should
be used for testing purposes with simulated datasets to determine the degree of
agreement of the detection methods under various conditions. For real datasets,
this section could be used to compare the results of each method to
determine which features are sensitive to method choice.*

# 6 DiscoRhythm R Usage

The remainder of this vignette will focus on programmatic usage of DiscoRhythm
functions using R.

This section will demonstrate usage of the R functions used to perform the
analysis in section [5](#discorhythm-interface-walkthrough). For each of
the sections below, refer to the DiscoRhythm R package manual for
specific technical details on usage, arguments and methods or use `?` to
access individual manual pages. For instance,
get more
help for the function `discoBatch()` with command `?discoBatch`.

## 6.1 Data Import

*[SummarizedExperiment](https://bioconductor.org/packages/3.22/SummarizedExperiment)* objects such as those generated
by other Bioconductor packages
should be suitable inputs to DiscoRhythm functions
once modified to contain the required metadata.
For a “Summarized experiment” object named `se` the following fields are assumed
to be present:

1. `rownames(se)` - The feature IDs.
2. `assay(se)`151515 At present DiscoRhythm will use only the
   first assay (`assays(se)[[1]]`) of the SummarizedExperiment
   and all others will be ignored. - A matrix containing experimental data.
3. `colData(se)` - Stores sample metadata (See [4.3.1](#processed-metadata-table)).
   3 columns are required:

   * ID
   * Time
   * ReplicateID

Objects with this structure will be used throughout the package.

### 6.1.1 discoDFtoSE

The CSV inputs to the DiscoRhythm web interface described in section
[4](#input-format) can be read into R as a `data.frame`.
To allow the users of the web application to use the same input for their
analysis in R, the function `discoDFtoSE()` can convert the tabular
input into an apporpriate format described in
[6.1](#data-import) above.

The sample metadata will be
extracted from the column
names by matching the format161616 See `?discoParseMeta` for regular expression specifications. described in section
[4.3](#column-names).
The checks for validity and uniqueness mentioned in section [5.2](#select-data)
will also be performed. Alternatively, this metadata may be provided directly
to `discoDFtoSE` as a `data.frame`.

Loading in the example dataset described in section [4](#input-format) using
`discoGetSimu()` to get the demo dataset as a `data.frame`:

```
library(DiscoRhythm)
indata <- discoGetSimu()
knitr::kable(head(indata[,1:6]), format = "markdown") # Inspect the data
```

| IDs | CT0\_1\_A | CT0\_2\_B | CT0\_3\_C | CT4\_4\_D | CT4\_5\_E |
| --- | --- | --- | --- | --- | --- |
| nonRhythmGene\_Id1 | 6.3717658 | 4.0909466 | 8.3010577 | 7.0240708 | -4.6510406 |
| nonRhythmGene\_Id2 | -2.4340798 | -5.6695362 | -3.0800470 | -0.1800393 | 3.1282445 |
| nonRhythmGene\_Id3 | -9.8373929 | -5.8738313 | -0.7793628 | -2.7236067 | 2.6574806 |
| nonRhythmGene\_Id4 | 4.5951368 | 0.2952068 | 3.5660223 | -1.2458999 | 6.1385621 |
| nonRhythmGene\_Id5 | 0.3980836 | 3.9928686 | 1.5626314 | 0.0613089 | 0.7013376 |
| nonRhythmGene\_Id6 | -0.2139567 | -2.4819291 | -6.5602675 | -1.9901769 | -7.5526251 |

And importing as a `SummarizedExperiment`.

```
se <- discoDFtoSE(indata)
```

### 6.1.2 discoSEtoDF

The reverse operation, `discoSEtoDF`, is also available and is mainly intended
for exporting the data to a “csv” format to be used as an input to the web
application.

```
write.csv(discoSEtoDF(se),file = "DiscoRhythmInputFile.csv",row.names = FALSE)
```

### 6.1.3 discoCheckInput

This function performs the row-wise checks for missing values and constant
values as mentioned in section [5.2](#select-data).

```
selectDataSE <- discoCheckInput(se)
```

### 6.1.4 discoDesignSummary

The sample collection information present in `colData(selectDataSE)` can be
summarized by the `discoDesignSummary()` function to detail the number of
biological and technical replicates available at each collection time. Number of
technical replicates is shown in brackets.

```
library(SummarizedExperiment)
Metadata <- colData(selectDataSE)
knitr::kable(discoDesignSummary(Metadata),format = "markdown")
```

|  | 0 | 4 | 8 | 12 | 16 | 20 |
| --- | --- | --- | --- | --- | --- | --- |
| Total | 9 | 9 | 9 | 9 | 9 | 9 |
|  | Biological Sample A (3) | Biological Sample D (3) | Biological Sample G (3) | Biological Sample J (3) | Biological Sample M (3) | Biological Sample P (3) |
|  | Biological Sample B (3) | Biological Sample E (3) | Biological Sample H (3) | Biological Sample K (3) | Biological Sample N (3) | Biological Sample Q (3) |
|  | Biological Sample C (3) | Biological Sample F (3) | Biological Sample I (3) | Biological Sample L (3) | Biological Sample O (3) | Biological Sample R (3) |

## 6.2 Outlier Detection

### 6.2.1 discoInterCorOutliers

Performs the analysis described in [5.3.1](#inter-sample-correlation) to
return some intermediate results and a vector indicating which samples
were flagged as outliers using the inter-sample correlation method.

```
CorRes <- discoInterCorOutliers(selectDataSE,
                                cor_method="pearson",
                                threshold=3,
                                thresh_type="sd")
```

### 6.2.2 discoPCAoutliers

Performs the analysis described in [5.3.2](#principal-component-analysis) to
return some intermediate results and a vector indicating which samples
were flagged as outliers using the PCA method.

```
PCAres <- discoPCAoutliers(selectDataSE,
                           threshold=3,
                           scale=TRUE,
                           pcToCut = c("PC1","PC2","PC3","PC4"))
```

### 6.2.3 discoPCA

A simple wrapper was written for the `stats::prcomp` function for better use
with
the web application and it can be utilized as:

```
discoPCAres <- discoPCA(selectDataSE)
```

This returns the same output as prcomp with the addition of a reformatted
summary table (available as `PCAresAfter$table`).

### 6.2.4 Filtering Summary

The results of the outlier detection analysis (`CorRes` and `PCAres`)
are used to remove outliers by subsetting the data.

```
FilteredSE <- selectDataSE[,!PCAres$outliers & !CorRes$outliers]

DT::datatable(as.data.frame(
  colData(selectDataSE)[PCAres$outliers | CorRes$outliers,]
))
```

```
knitr::kable(discoDesignSummary(colData(FilteredSE)),format = "markdown")
```

|  | 0 | 4 | 8 | 12 | 16 | 20 |
| --- | --- | --- | --- | --- | --- | --- |
| Total | 9 | 8 | 9 | 8 | 9 | 9 |
|  | Biological Sample A (3) | Biological Sample D (3) | Biological Sample G (3) | Biological Sample J (3) | Biological Sample M (3) | Biological Sample P (3) |
|  | Biological Sample B (3) | Biological Sample E (3) | Biological Sample H (3) | Biological Sample K (3) | Biological Sample N (3) | Biological Sample Q (3) |
|  | Biological Sample C (3) | Biological Sample F (2) | Biological Sample I (3) | Biological Sample L (2) | Biological Sample O (3) | Biological Sample R (3) |

## 6.3 Row Selection

### 6.3.1 discoRepAnalysis

Performs the analysis described in [5.4](#row-selection) returning the results
of the ANOVA test and the `se` data object where technical replicates
are combined.

```
ANOVAres <- discoRepAnalysis(FilteredSE,
                             aov_method="Equal Variance",
                             aov_pcut=0.05,
                             aov_Fcut=1,
                             avg_method="Median")

FinalSE <- ANOVAres$se
```

## 6.4 Dominant Rhythmicities

### 6.4.1 discoPeriodDetection

Performs the analysis described in [5.5](#period-detection) to return a
`data.frame` of Cosinor results across a range of periods.

```
PeriodRes <- discoPeriodDetection(FinalSE,
                                  timeType="linear",
                                  main_per=24)
```

The main period of interest is fit using a Cosinor model to principal component
scores as described in [5.5](#period-detection).

```
OVpca <- discoPCA(FinalSE)
OVpcaSE <- discoDFtoSE(data.frame("PC"=1:ncol(OVpca$x),t(OVpca$x)),
                                  colData(FinalSE))
knitr::kable(discoODAs(OVpcaSE,period = 24,method = "CS")$CS,
             format = "markdown")
```

| acrophase | amplitude | pvalue | qvalue | Rsq | mesor | sincoef | coscoef |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 17.712807 | 8.8193393 | 0.0000000 | 0.0000000 | 0.9855849 | 0 | -8.7944228 | -0.6624756 |
| 23.688091 | 5.4627944 | 0.0000000 | 0.0000000 | 0.9182224 | 0 | -0.4455825 | 5.4445918 |
| 14.950576 | 0.2226963 | 0.9816116 | 0.9973953 | 0.0024716 | 0 | -0.1554194 | -0.1594943 |
| 10.367958 | 0.1284881 | 0.9936085 | 0.9973953 | 0.0008546 | 0 | 0.0532436 | -0.1169372 |
| 12.875265 | 0.3915672 | 0.9364723 | 0.9973953 | 0.0087132 | 0 | -0.0889421 | -0.3813321 |
| 15.091166 | 0.2544040 | 0.9696152 | 0.9973953 | 0.0041057 | 0 | -0.1841327 | -0.1755465 |
| 11.569215 | 0.4873137 | 0.8860104 | 0.9973953 | 0.0160074 | 0 | 0.0548425 | -0.4842179 |
| 23.145543 | 0.2364532 | 0.9697559 | 0.9973953 | 0.0040864 | 0 | -0.0524537 | 0.2305618 |
| 2.219717 | 0.3157691 | 0.9426803 | 0.9973953 | 0.0078395 | 0 | 0.1733449 | 0.2639350 |
| 20.716605 | 0.0657149 | 0.9973953 | 0.9973953 | 0.0003477 | 0 | -0.0497840 | 0.0428952 |

## 6.5 Oscillation Detection

### 6.5.1 discoODAs

Performs the analysis described in [5.6.1](#rhythmicity-calculation-configuration)
using just the Cosinor method.
`discoODAs()` will automatically run all appropraite methods
if none are provided.

```
discoODAres <- discoODAs(FinalSE,
                         period=24,
                         method="CS",
                         ncores=1,
                         circular_t=FALSE)
```

## 6.6 Batch Execution

### 6.6.1 discoBatch

The entire analysis performed in section [6](#discorhythm-r-usage) may be
run through a single call to `discoBatch()` to obtain the final `discoODAres`
results.

```
discoBatch(indata=indata,
  report="discoBatch_example.html",
  ncores=1,
  main_per=24,
  timeType="linear",
  cor_threshold=3,
  cor_method="pearson",
  cor_threshType="sd",
  pca_threshold=3,
  pca_scale=TRUE,
  pca_pcToCut=paste0("PC",seq_len(4)),
  aov_method="None",
  aov_pcut=0.05,
  aov_Fcut=0,
  avg_method="Median",
  osc_method="CS",
  osc_period=24)
```

This command will generate an html report called “discoBatch\_example.html”
, which includes the
visualizations seen in the DiscoRhythm application. `indata` may be in either
of the two input formats described in [6.1](#data-import) (`data.frame` or
`SummarizedExperiment`).

### 6.6.2 Importing Archived Sessions

Section [5.6.2.2](#report) describes how to archive
results in a DiscoRhythm web session. The RDS file produced by
this feature contains the parameters used in the
session which can be used by one of the methods below to continue an
analysis in R.

First the CSV input dataset can be read into R. This may be done as:

```
indata <- read.csv(path_to_csv_file)
```

And the R data file can be read into R with:

```
discorhythm_inputs <- readRDS('discorhythm_inputs.RDS')
```

#### 6.6.2.1 Method 1

The batch analysis can then be computed to create a report and obtain a
list of the oscillation detection results.

```
discoODAres <- do.call(discoBatch, c(list(indata=indata,
                                          report='discorhythm_report.html'),
                                          discorhythm_inputs))
```

The above code is simply a call to `discoBatch` using a list of arguments
as input.

#### 6.6.2.2 Method 2

Alternatively, a customized DiscoRhythm workflow may be built on the code
template below which computes the major results. First, to get all necessary
objects into the workspace, the list will be converted into individual objects
using the code below.

```
list2env(discorhythm_inputs,envir=.GlobalEnv)
```

The code from this template can then be used directly and modified for
further analysis. This code and visualization code can be found in the discorhythm\_report.html file.

```
######################################################################
# Intended for use by discoBatch or through the DiscoRhythm_report.Rmd
# Includes all R code for the DiscoRhythm data processing
# Expects all arguments to discoBatch in the environment
#####################################################################

library(DiscoRhythm)

# Preprocess inputs
selectDataSE <- discoCheckInput(discoDFtoSE(indata))

# Intersample correlations
CorRes <- discoInterCorOutliers(selectDataSE,cor_method,
                                cor_threshold,cor_threshType)

# PCA for outlier detection
PCAres <- discoPCAoutliers(selectDataSE,pca_threshold,pca_scale,pca_pcToCut)
PCAresAfter <- discoPCA(selectDataSE[,!PCAres$outliers])

# Removing the outliers from the main data.frame and metadata data.frame
FilteredSE <- selectDataSE[,!PCAres$outliers & !CorRes$outliers]

# Running ANOVA and merging replicates
ANOVAres <- discoRepAnalysis(FilteredSE, aov_method,
                             aov_pcut, aov_Fcut, avg_method)

# Data to be used for Period Detection and Oscillation Detection
FinalSE <- ANOVAres$se

# Perform PCA on the final dataset
OVpca <- discoPCA(FinalSE)

# Period Detection
PeriodRes <- discoPeriodDetection(FinalSE,
                     timeType,
                     main_per)

# Oscillation Detection
discoODAres <- discoODAs(FinalSE,
                        circular_t = timeType=="circular",
                        period=osc_period,
                        osc_method,ncores)
```

#### 6.6.2.3 Reproducing Rhythm Detection Tables

Usage in R provides additional columns from `discoODAs` which are excluded from
web application outputs. Additionally, the web application provides row means
which may be easily calculated in R with `rowMeans`.

# 7 Session Info

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
## [1] stats4    stats     graphics  grDevices utils     datasets  methods
## [8] base
##
## other attached packages:
##  [1] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [3] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [5] IRanges_2.44.0              S4Vectors_0.48.0
##  [7] BiocGenerics_0.56.0         generics_0.1.4
##  [9] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [11] DiscoRhythm_1.26.0          BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] gridExtra_2.3         formatR_1.14          rlang_1.1.6
##   [4] magrittr_2.0.4        shinydashboard_0.7.3  otel_0.2.0
##   [7] compiler_4.5.1        reshape2_1.4.4        systemfonts_1.3.1
##  [10] vctrs_0.6.5           stringr_1.5.2         pkgconfig_2.0.3
##  [13] fastmap_1.2.0         backports_1.5.0       magick_2.9.0
##  [16] XVector_0.50.0        ca_0.71.1             promises_1.4.0
##  [19] rmarkdown_2.30        UpSetR_1.4.0          purrr_1.1.0
##  [22] xfun_0.53             cachem_1.1.0          jsonlite_2.0.0
##  [25] matrixTests_0.2.3.1   later_1.4.4           DelayedArray_0.36.0
##  [28] broom_1.0.10          R6_2.6.1              stringi_1.8.7
##  [31] bslib_0.9.0           RColorBrewer_1.1-3    jquerylib_0.1.4
##  [34] Rcpp_1.1.0            bookdown_0.45         assertthat_0.2.1
##  [37] iterators_1.0.14      knitr_1.50            VennDiagram_1.7.3
##  [40] httpuv_1.6.16         Matrix_1.7-4          tidyselect_1.2.1
##  [43] rstudioapi_0.17.1     dichromat_2.0-0.1     abind_1.4-8
##  [46] yaml_2.3.10           viridis_0.6.5         TSP_1.2-5
##  [49] codetools_0.2-20      miniUI_0.1.2          lattice_0.22-7
##  [52] tibble_3.3.0          plyr_1.8.9            shiny_1.11.1
##  [55] S7_0.2.0              evaluate_1.0.5        lambda.r_1.2.4
##  [58] futile.logger_1.4.3   heatmaply_1.6.0       xml2_1.4.1
##  [61] zip_2.3.3             pillar_1.11.1         shinycssloaders_1.1.0
##  [64] BiocManager_1.30.26   DT_0.34.0             foreach_1.5.2
##  [67] shinyjs_2.1.0         plotly_4.11.0         ggplot2_4.0.0
##  [70] scales_1.4.0          xtable_1.8-4          glue_1.8.0
##  [73] lazyeval_0.2.2        tools_4.5.1           dendextend_1.19.1
##  [76] data.table_1.17.8     webshot_0.5.5         registry_0.5-1
##  [79] grid_4.5.1            tidyr_1.3.1           crosstalk_1.2.2
##  [82] seriation_1.5.8       shinyBS_0.61.1        cli_3.6.5
##  [85] textshaping_1.0.4     kableExtra_1.4.0      futile.options_1.0.1
##  [88] S4Arrays_1.10.0       viridisLite_0.4.2     svglite_2.2.2
##  [91] dplyr_1.1.4           gtable_0.3.6          sass_0.4.10
##  [94] digest_0.6.37         SparseArray_1.10.0    htmlwidgets_1.6.4
##  [97] farver_2.1.2          htmltools_0.5.8.1     lifecycle_1.0.4
## [100] httr_1.4.7            mime_0.13             ggExtra_0.11.0
```

# References

Cornelissen, Germaine. 2014. “Cosinor-Based Rhythmometry.” *Theor. Biol. Med. Model.* 11 (April): 16.

Deckard, Anastasia, Ron C Anafi, John B Hogenesch, Steven B Haase, and John Harer. 2013. “Design and Analysis of Large-Scale Biological Rhythm Studies: A Comparison of Algorithms for Detecting Periodic Signals in Biological Data.” *Bioinformatics* 29 (24): 3174–80.

Glynn, Earl F, Jie Chen, and Arcady R Mushegian. 2006. “Detecting Periodic Patterns in Unevenly Spaced Gene Expression Time Series Using Lomb-Scargle Periodograms.” *Bioinformatics* 22 (3): 310–16.

Hughes, Michael E, Katherine C Abruzzi, Ravi Allada, Ron Anafi, Alaaddin Bulak Arpat, Gad Asher, Pierre Baldi, et al. 2017. “Guidelines for Genome-Scale Analysis of Biological Rhythms.” *J. Biol. Rhythms* 32 (5): 380–93.

Hughes, Michael E, John B Hogenesch, and Karl Kornacker. 2010. “JTK\_CYCLE: An Efficient Nonparametric Algorithm for Detecting Rhythmic Components in Genome-Scale Data Sets.” *J. Biol. Rhythms* 25 (5): 372–80.

Hurley, Jennifer M, Meaghan S Jankowski, Hannah De Los Santos, Alexander M Crowell, Samuel B Fordyce, Jeremy D Zucker, Neeraj Kumar, et al. 2018. “Circadian Proteomic Analysis Uncovers Mechanisms of Post-Transcriptional Regulation in Metabolic Pathways.” *Cell Syst* 7 (6): 613–626.e5.

Hutchison, Alan L., and Aaron R. Dinner. 2017. “Correcting for Dependent P-Values in Rhythm Detection.” *bioRxiv*. <https://doi.org/10.1101/118547>.

Krishnaiah, Saikumari Y, Gang Wu, Brian J Altman, Jacqueline Growe, Seth D Rhoades, Faith Coldren, Anand Venkataraman, et al. 2017. “Clock Regulation of Metabolites Reveals Coupling Between Transcription and Metabolism.” *Cell Metab.* 25 (4): 961–974.e4.

Singer, Jordan M, Darwin Y Fu, and Jacob J Hughey. 2019. “Simphony: Simulating Large-Scale, Rhythmic Data.” *PeerJ* 7 (May): e6985.

Wu, Gang, Ron C Anafi, Michael E Hughes, Karl Kornacker, and John B Hogenesch. 2016. “MetaCycle: An Integrated R Package to Evaluate Periodicity in Large Scale Data.” *Bioinformatics* 32 (21): 3351–3.

Wu, Gang, Jiang Zhu, Jun Yu, Lan Zhou, Jianhua Z Huang, and Zhang Zhang. 2014. “Evaluation of Five Methods for Genome-Wide Circadian Gene Identification.” *J. Biol. Rhythms* 29 (4): 231–42.

Yang, Rendong, and Zhen Su. 2010. “Analyzing Circadian Expression Data by Harmonic Regression Based on Autoregressive Spectral Estimation.” *Bioinformatics* 26 (12): i168–74.