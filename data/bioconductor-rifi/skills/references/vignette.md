# rifi

Walja Wanney, Loubna Youssar and Jens Georg

#### 2025-10-30

## 0. Installation

Please note that **‘rifi’** is only available for Unix based systems.
To install this package, start R (>= version “4.2”) and enter:

```
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("rifi")
```

## I. Introduction

The stability or halflife of bacterial transcripts is often estimated using
Rifampicin timeseries data. Rifampicin has the special feature that it prevents the
initiation of transcprition, but RNA polymerases which are already elongating are unaffected (Campbell et al. [2001](#ref-campbell_structural_2001)).
This has the implication that the RNA concentrations of positions downstream of the transcriptional start site
appear unchanged until the last polymerase has passed this point. The result is a delayed exponential decay (Chen et al. [2015](#ref-chen_genome-wide_2015)),
which can be fitted by the following model:

\(c(t,n) = \begin{cases} \frac{\alpha}{\lambda} & \quad \text{if } t < \frac{n}{v}\\ \frac{\alpha}{\lambda} \times e^{-\lambda t} & \quad \text{if } t \geq \frac{n}{v} \end{cases}\)

The model (Chen et al. [2015](#ref-chen_genome-wide_2015)) consists of
two phases; the firts phase describes the delay where the transcript concentration is in its
steady state defined by the ratio of the synthesis rate *\(\alpha\)* and the decay constant *\(\lambda\)* (\(steadystate = \frac{\alpha}{\lambda}\)). The
delay is dependent on the distance from the transcriptional start site ***\(n\)*** and the transcription
velocity ***\(v\)***. If the time after the Rifampicin additon is greater than the delay (\(delay = \frac{n}{v}\))
the exponential decay phase starts.

In addition to the standard model, we are using a second model which describes the behaviour at positions were the concentration ***increases*** after Rifampicin addition (Figure 1, right panel). This phenomenon can be explained by Rifampicin relievable transcription termination, e.g. through the transcriptional interference (TI) collision mechanism (Shearwin, Callen, and Egan [2005](#ref-shearwin_transcriptional_2005)) or termination by short-lived factors such as sRNAs (Wang et al. [2015](#ref-wang_two-level_2015)). In the following we will call this model the ‘TI model’ which consists of three phases:

\(c(t,n) = \begin{cases} \frac{\alpha - \alpha \times \beta}{\lambda} & \quad \text{if } t < \frac{n - n\_{term}}{v}\\ \frac{\alpha}{\lambda} - \frac{\alpha \times \beta}{\lambda} \times e ^{-\lambda (t -\frac{n - n\_{term}}{v})} & \quad \text{if } \frac{n - n\_{term}}{v} < t < \frac{n}{v}\\ (\frac{\alpha}{\lambda} - \frac{\alpha \times \beta}{\lambda} \times e ^{-\lambda (t -\frac{n\_{term}}{v})}) \times e^{-\lambda (t-\frac{n}{v})} & \quad \text{if } \frac{n}{v} \leq t \end{cases}\)

The first phase describes again the steady state concentration at a given transcript position, but here the synthesis rate *\(\alpha\)* is reduced by the **TI-termination-factor \(\beta\)**.
We assume a short lived factor responsible for the termination whose synthesis is stopped
after rifampicin addition. Thus after the relieve of termination all polymerases that start at the transcriptional start site can reach positions downstream of the former termination site (\(n\_{term}\)), the time polymerases need from the position of termination to the position \(n\) is delay for the increase (\(delay\_{increase}= \frac{n - n\_{term}}{v}\)).
After the last polymerase has passed the respective position, the exponential decay phase starts.

**‘rifi’** is a tool to do a stability analysis on high-throughput rifampicin data. RNA sequencing and microarray data derived from rifampicin treated bacteria with sufficiently high time resolution can reveal many insights into the mechanics of transcription, RNAP velocity and RNA stability. **‘rifi’** is a tool for the holistic identification of these transcription processes.
The core part of the data analysis by rifi is the utilization of one of the two
non linear regression models applied on the time series data of each *probe* (or *bin*), giving the *probe/bin* specific delay, decay constant *\(\lambda\)* and half-life
(\(t\_\frac{1}{2} = \frac{\ln(2)}{\lambda}\)) (Figure 1, left panel).

![**Fit models**. Fits from both models. Left: the two-phase standard fit. Right the TI model fits the increase in intensity. Black dotes represent the average intensity for each timepoint, colored circles indicate the respective replicate.](data:image/png;base64...)

Figure 1: **Fit models**
Fits from both models. Left: the two-phase standard fit. Right the TI model fits the increase in intensity. Black dotes represent the average intensity for each timepoint, colored circles indicate the respective replicate.

After the fit of the individual *probes/bins*, common worklfows usually combine the
individual **half-life** values based on the given genome annotation to get an
average for the gene based stability. This procedure can not deal with differences
within a given gene, e.g. due to processing sites. ‘rifi’ uses an annotation agnostic approach to get an unbiased estimate of individual transcripts as they actually appear *in vivo*. *probes/bins* with equal properties in the extracted values **delay**, **half-life**, **TI\_termination\_factor** and the given **intensity** values
are combined into segments by dynamic programming (called fragmentation in ‘rifi’),
independent of an existing genome annotation (Figure 2). The fragmentation is performed hierarchically.
Initially segments of bins are grouped by regions without significant sequencing
depth into **position\_segments**. Those are grouped into **delay\_fragments**
by common velocity. Subsequently, each delay-fragment is grouped by similar
half-life into **half\_life\_fragments**, on which the bins finally are grouped
into **intensity\_fragments** by similar intensity. From the fragmentation, many
**events** can be extracted; **iTSS** (internal transcription start sites), transcription **pausing\_sites**, **velocity\_changes**,**processing\_sites**, partial **terminations**,
as well as instances of Rifampicin relievable transcription termination, e.g.
by **TI** (transcription interference).
All data are integrated to give an estimate of continuous transcriptional units,
i.e. operons. Comprehensive output tables and visualizations of the full genome
result and the individual fits for all *probes/bins* are produced.

![**Fragmentation hirarchy**. The hierarchy of the workflow is separated into five steps. At first segments are formed based on the distance to the next data point. The threshold is 200 nucleotides. Next, segments are parted into delay fragments. The delay fragments are parted by the half-life and likewise the half-life fragments are parted by intensity. Groups of TUs are formed based on the distance between the starts and ends of the delay fragments. Finally, within TUs, TI fragments are formed.](data:image/png;base64...)

Figure 2: **Fragmentation hirarchy**
The hierarchy of the workflow is separated into five steps. At first segments are formed based on the distance to the next data point. The threshold is 200 nucleotides. Next, segments are parted into delay fragments. The delay fragments are parted by the half-life and likewise the half-life fragments are parted by intensity. Groups of TUs are formed based on the distance between the starts and ends of the delay fragments. Finally, within TUs, TI fragments are formed.

### 1. Quickstart

If you have your data prepared as described in [The Input Data Frame]
(#the-input-data-frame) you can use the `rifi_wrapper` to run ’rifi" with
default options. `rifi_wrapper` conveniently wraps all functions included in rifi.
That allows the user to run the whole workflow with one function. If the data
contain a background component, e.g. in case of microarray data, take to define
a meaningful background intensity.

The functions used are:

[`check_input`](#check_input)
[`rifi_preprocess`](#rifi_preprocess)
[`rifi_fit`](#rifi_fit)
[`rifi_penalties`](#rifi_penalties)
[`rifi_fragmentation`](#rifi_fragmentation)
[`rifi_stats`](#rifi_stats)
[`rifi_summary`](#rifi_summary)
[`rifi_visualization`](#rifi_visualization)

For `rifi_wrapper` you only need to provide the path to a **.gff** file of the
respective genome and the input **SummarizedExperiment** object. The genome
annotation is needed for the visualization and to map fragmented segments to
annotated genes for an easier interpretation.

```
library(rifi)
data(example_input_e_coli)
Path = gzfile(system.file("extdata", "gff_e_coli.gff3.gz", package = "rifi"))
wrapper_minimal <-
  rifi_wrapper(
    inp = example_input_e_coli,
    cores = 2,
    path = Path,
    bg = 0,
    restr = 0.01
  )
}
```

The wrapper saves the output of each sub-function in a list. Thus each intermediate
result can be re-run with custom settings. the object ‘wrapper\_minimal’ contains
only minimal artificial data to reduce the runtime of the test run.

```
data(wrapper_minimal)

# list of 6 SummarizedExperiment objects
length(wrapper_minimal)
```

```
## [1] 6
```

```
#the first intermediate result
wrapper_minimal[[1]]
```

```
## class: RangedSummarizedExperiment
## dim: 4 33
## metadata(2): replicates timepoints
## assays(1): ''
## rownames: NULL
## rowData names(7): position ID ... flag position_segment
## colnames: NULL
## colData names(2): timepoint replicate
```

### 2. The output

A small example output can be loaded with `data(summary_minimal)`. The final
output is a **SummarizedExperiment** object.

All main results are stored as metadata in the **SummarizedExperiment** object.
The first five entries are not of immediate importance.

```
data(summary_minimal)

# the main results
names(metadata(summary_minimal))
```

```
##  [1] "timepoints"                        "replicates"
##  [3] "logbook"                           "logbook_details"
##  [5] "annot"                             "dataframe_summary_1"
##  [7] "dataframe_summary_2"               "dataframe_summary_events"
##  [9] "dataframe_summary_events_HL_int"   "dataframe_summary_events_ps_itss"
## [11] "dataframe_summary_events_velocity" "dataframe_summary_TI"
```

#### 1. *bin/probe* based results

Entry 6, **dataframe\_summary\_1**, contains all fit results for each individual
*bin/probe* and a mapping to the genome annotation. They can be exported to
an **.csv** file using `write.csv()`.

```
# bin/probe probe based results
head(metadata(summary_minimal)$dataframe_summary_1)
```

```
##   ID feature_type gene       locus_tag position strand segment   TU
## 1  1         <NA> <NA>            <NA>       50      +     S_1 TU_1
## 2  2         <NA> <NA>            <NA>      100      +     S_1 TU_1
## 3  3         <NA> <NA>            <NA>      150      +     S_1 TU_1
## 4  4          CDS thrL BW25113_RS00005      200      +     S_1 TU_1
## 5  5          CDS thrL BW25113_RS00005      250      +     S_1 TU_1
## 6  6         <NA> <NA>            <NA>      300      +     S_1 TU_1
##   delay_fragment delay HL_fragment half_life intensity_fragment intensity  flag
## 1            D_1  0.08        Dc_1      1.57                I_1    138.55 _ABG_
## 2            D_1  0.17        Dc_1      1.54                I_1    146.89 _ABG_
## 3            D_1  0.50        Dc_1      1.52                I_1    152.35 _ABG_
## 4            D_1  0.76        Dc_1      1.54                I_1    163.39 _ABG_
## 5            D_1  1.00        Dc_1      1.50                I_1    149.01 _ABG_
## 6            D_1  1.21        Dc_1      1.58                I_1    160.37 _ABG_
##   TI_termination_factor
## 1                    NA
## 2                    NA
## 3                    NA
## 4                    NA
## 5                    NA
## 6                    NA
```

```
#export to csv
write.csv(metadata(summary_minimal)$dataframe_summary_1, file="filename.csv")
```

#### 2. **fragment** based results

Entry 7, **dataframe\_summary\_2**, contains all fit results for each
**intensity\_fragment**. Due to the hierachic fragmentation strategy [Figure 2]
several **intensity\_fragment** (I\_x) can belong to one **decay\_fragment** (Dc\_x),
one **delay\_fragment** (D\_x) and one transcriptional unit (TU\_x). The fragment
IDs can be used to locate the fragment in the output PDF file. The fragments are
mapped to the genome annotation and the mean halflife given in minutes and the
mean intensity is given with their standard deviations.
Also the estimated velocity in nt/min is given. The table can be exported as
an **.csv** file using `write.csv()`.

```
# all estimated fragments
metadata(summary_minimal)$dataframe_summary_2
```

```
##   feature_type    gene          locus_tag first_position_frg last_position_frg
## 1       NA|CDS NA|thrL NA|BW25113_RS00005                 50               300
## 2          CDS    thrA    BW25113_RS00010                350               600
## 3          CDS    thrA    BW25113_RS00010                650               900
## 4           NA      NA                 NA               1151              1051
## 5           NA      NA                 NA               1001               901
##   strand   TU segment delay_fragment HL_fragment half_life HL_SD HL_SE
## 1      + TU_1     S_1            D_1        Dc_1      1.54  0.03  0.01
## 2      + TU_1     S_1            D_1        Dc_2      3.04  0.04  0.02
## 3      + TU_1     S_1            D_2        Dc_3      3.00  0.05  0.02
## 4      - TU_2     S_2            D_3        Dc_4      2.00  0.02  0.01
## 5      - TU_2     S_2            D_3        Dc_4      2.00  0.02  0.01
##   intensity_fragment intensity intensity_SD intensity_SE velocity
## 1                I_1    151.53         9.12         3.72   143.86
## 2                I_2    300.24         5.75         2.35   143.86
## 3                I_3    446.67         7.36         3.00   417.25
## 4                I_4    205.03         1.78         1.03   201.10
## 5                I_5    102.47         3.88         2.24   201.10
```

```
#export to csv
write.csv(metadata(summary_minimal)$dataframe_summary_2, file="filename.csv")
```

#### 3. Transcription **events**

Entry 8, **dataframe\_summary\_events**, contains all estimated transcriptional
***events***. Events always appear between two transcript fragments.

```
# all estimated events
metadata(summary_minimal)$dataframe_summary_events
```

```
##          event  p_value p_adjusted FC_HL FC_intensity FC_HL_adapted
## 1       iTSS_I       NA         NA    NA           NA            NA
## 2  Termination       NA         NA    NA           NA          0.99
## 3      iTSS_II       NA         NA    NA           NA          1.97
## 4      iTSS_II       NA         NA    NA           NA          0.99
## 5    Int_event       NA         NA    NA         0.98          1.97
## 6    Int_event       NA         NA    NA         0.57          0.99
## 7    Int_event       NA         NA    NA        -1.00          0.99
## 8     HL_event 2.68e-10   4.02e-10  0.98           NA            NA
## 9     HL_event 1.07e-11   3.21e-11 -0.02           NA            NA
## 10    velocity 1.91e-04   1.91e-04    NA           NA            NA
##    FC_HL_FC_intensity event_position velocity_ratio feature_type gene
## 1                  NA            625             NA          CDS thrA
## 2                0.50           1026             NA
## 3                1.00            325             NA
## 4                1.51            625             NA          CDS thrA
## 5                  NA            325             NA
## 6                  NA            625             NA          CDS thrA
## 7                  NA           1026             NA
## 8                  NA            325             NA
## 9                  NA            625             NA          CDS thrA
## 10                 NA            625            2.9          CDS thrA
##          locus_tag strand   TU             segment_1             segment_2
## 1  BW25113_RS00010      + TU_1          S_1|TU_1|D_1          S_1|TU_1|D_2
## 2                       - TU_2 S_2|TU_2|D_3|Dc_4|I_4 S_2|TU_2|D_3|Dc_4|I_5
## 3                       + TU_1 S_1|TU_1|D_1|Dc_1|I_1 S_1|TU_1|D_1|Dc_2|I_2
## 4  BW25113_RS00010      + TU_1 S_1|TU_1|D_1|Dc_2|I_2 S_1|TU_1|D_1|Dc_3|I_3
## 5                       + TU_1 S_1|TU_1|D_1|Dc_1|I_1 S_1|TU_1|D_1|Dc_1|I_2
## 6  BW25113_RS00010      + TU_1 S_1|TU_1|D_1|Dc_2|I_2 S_1|TU_1|D_1|Dc_2|I_3
## 7                       - TU_2 S_2|TU_2|D_3|Dc_4|I_4 S_2|TU_2|D_3|Dc_4|I_5
## 8                       + TU_1     S_1|TU_1|D_1|Dc_1     S_1|TU_1|D_1|Dc_2
## 9  BW25113_RS00010      + TU_1     S_1|TU_1|D_1|Dc_2     S_1|TU_1|D_1|Dc_3
## 10 BW25113_RS00010      + TU_1          S_1|TU_1|D_1          S_1|TU_1|D_2
##    event_duration gap_fragments features
## 1           -1.27            50        2
## 2              NA            50        3
## 3              NA            50        4
## 4              NA            50        4
## 5              NA            50        2
## 6              NA            50        2
## 7              NA            50        2
## 8              NA            50        2
## 9              NA            50        2
## 10             NA            50        2
```

```
#export to csv
write.csv(metadata(summary_minimal)$dataframe_summary_events, file="filename.csv")
```

Changes in the linear increase of the delay indicate a potential **pausing site**
if there is a sudden delay increase (Figure 3A), a potential internal starting
site **iTSS\_I** if there is a sudden decrease in the delay (Figure 3B) and
a **velocity** change of the RNA polymerase if there is a slope change (Figure 3C).
The events are statistically evaluated by Ancova ([apply\_ancova](#apply_ancova))
or a t-test ([apply\_Ttest\_delay](#apply_Ttest_delay)).

A fragment border between halflife segments (**HL\_event**) which belong to the
same transcriptional unit might indicate a processing site (Figure 3D) and a
fragment border between intensity fragments (**Int\_event**) (Figure 3E) can
indicate a processing site (Figure 3F), a new transcriptional start site
(**iTSS\_II**) (Figure 3G) or an partial **termination** (Figure 3H), depending
on the respective intensity foldchanges and the halflife foldchanges.

Each **event** is described by is type, its p-Value and adjusted p-Value,
the foldchange or event duration, the estimated event position, a mapping to
existing annotations and the IDs of the two bordering fragments.

![Transcriptional events](data:image/png;base64...)

Figure 3: Transcriptional events

The entries 9 to 11 contain specific subsets of events, i.e they are subsets of **dataframe\_summary\_events**.

#### 4. Rifampicin relievable termination - TI instances

Entry 12, **dataframe\_summary\_TI**, contains the identified instances of Rifampicin relievable termination, with termination factor, position and mapped annotation. **TI\_fragments** are investigated independent of the delay/decay/intensity fragment hierarchy. A clear TI event should consist of two segments; a pre termination
segment with a termination factor of ~0 and a post termination segment with a
termination factor of >0.

```
#
metadata(summary_minimal)$dataframe_summary_TI
```

```
##   event TI_fragment TI_termination_factor  p_value p_adjusted feature_type
## 1    TI   TI_1:TI_2                0|0.51 2.05e-05   2.05e-05        NA|NA
##    gene locus_tag strand   TU features event_position position_1 position_2
## 1 NA|NA     NA|NA      - TU_2        2           1026       1151        901
```

```
#export to csv
write.csv(metadata(summary_minimal)$dataframe_summary_TI, file="filename.csv")
```

#### 5. rowRanges

All fits and results for the individual *probes* or *bins* are also added as
additional columns to the rowRanges of the object. The data can be exported to
an **.csv** file.

```
#the first 5 rows and 10/45 colums of the final rowRanges
rowRanges(summary_minimal)[1:5,1:10]
```

```
## GRanges object with 5 ranges and 10 metadata columns:
##       seqnames    ranges strand |  position        ID       FLT intensity
##          <Rle> <IRanges>  <Rle> | <numeric> <integer> <numeric> <numeric>
##   [1]      chr      1-50      + |        50         1         0   138.552
##   [2]      chr    51-100      + |       100         2         0   146.886
##   [3]      chr   101-150      + |       150         3         0   152.349
##   [4]      chr   151-200      + |       200         4         0   163.387
##   [5]      chr   201-250      + |       250         5         0   149.006
##        probe_TI        flag position_segment     delay half_life
##       <numeric> <character>      <character> <numeric> <numeric>
##   [1]        -1       _ABG_              S_1 0.0833902   1.56869
##   [2]        -1       _ABG_              S_1 0.1737020   1.54311
##   [3]        -1       _ABG_              S_1 0.5035339   1.52367
##   [4]        -1       _ABG_              S_1 0.7566749   1.53506
##   [5]        -1       _ABG_              S_1 0.9972509   1.49575
##       TI_termination_factor
##                   <numeric>
##   [1]                    NA
##   [2]                    NA
##   [3]                    NA
##   [4]                    NA
##   [5]                    NA
##   -------
##   seqinfo: 1 sequence (1 circular) from BW25113 genome
```

```
#export to csv
write.csv(rowRanges(summary_minimal), file="filename.csv")
```

### 3. The whole genome visualization

![Whole genome visualization](data:image/png;base64...)

Figure 4: Whole genome visualization

### 4. Troubleshooting

#### 1. Fit

It is recommended to check the fit after running `rifi_fit`. If more than 30 % of the fits show a misfit, you may consider to check:

* Raw data
* Background

#### 2. Penalties

You may need to check your penalties if the last visualization shows:

##### 1. A high frequency of considerable long segments

![**Long segments**](data:image/png;base64...)

Figure 5: **Long segments**

##### 2. A high frequency of mini segments

In this case you may need to double check your data either the mini-segments are
artifact of rifi or the data. The example below shows rather an artifact of
the data since the segmentation is hierarchical. The half-life and intensity
segments are rather short because of the delay segmentation.

![**Mini segments**](data:image/png;base64...)

Figure 6: **Mini segments**

##### 3. A high frequency of extreme high values

![**High values**](data:image/png;base64...)

Figure 7: **High values**

* Absence of events in case you run big data.
* Absence of outliers.

### 5. Citing `rifi`

We hope you enjoy using `rifi`. Please cite the package in case of usage.

```
## To cite package 'rifi' in publications use:
##
##   Youssar L, Wanney W, Georg J (2025). _rifi: 'rifi' analyses data from
##   rifampicin time series created by microarray or RNAseq_.
##   doi:10.18129/B9.bioc.rifi <https://doi.org/10.18129/B9.bioc.rifi>, R
##   package version 1.14.0, <https://bioconductor.org/packages/rifi>.
##
## A BibTeX entry for LaTeX users is
##
##   @Manual{,
##     title = {rifi: 'rifi' analyses data from rifampicin time series created by microarray or RNAseq},
##     author = {Loubna Youssar and Walja Wanney and Jens Georg},
##     year = {2025},
##     note = {R package version 1.14.0},
##     url = {https://bioconductor.org/packages/rifi},
##     doi = {10.18129/B9.bioc.rifi},
##   }
```

## II. rifi\_preprocess

The first step in the analysis of rifampicin time series data with rifi is
preprocessing. The three major steps are filtration (to get rid of artifacts or background datapoints), fitting the data to the
correct model (standard model or TI model) and merge the coefficients and the input data frame into one structure for the downstream process. The steps can be performed with five low level functions or the wrapper function `rifi_preprocess` (see section [`rifi_preprocess`] (#rifi\_preprocess)).
The following paragraphs describe the sub-steps of `rifi_preprocess`. To
directly read about the application or `rifi_preprocess` jump to section [`rifi_preprocess`] (#rifi\_preprocess).

### 1. The Input Data Frame

The Input Data Frame is a SummarizedExperiment (SE) input format. SE structure
as known includes the colData (description of each sample), assays (probes/bins intensity measurements), rowRanges(coordinates of probes/bin including probe
identifier and positions).
Rifi package includes two example SE: **E.coli** data from
RNAseq (data with replicates, input\_df) (Dar and Sorek [2018](#ref-dar_extensive_2018)) and **Synechocystis PCC 6803**
data from microarrays (data with averaged replicates, see. “input\_df”).
**E.coli** is the input for this tutorial. In case of the **E.coli**
RNAseq dataset the intensities are binned for every 50 nt. We recommend to use a similar
strategy if working with RNAseq data. The binning is not performed by ‘rifi’ and needs to be
done beforehand.
Data from microarrays need to be checked carefully for background. We recommend
to run the workflow with low background e.g ~ 30 till `rifi_fit` and check the
probes fit to get an idea about the background level. The value estimated is
used to rerun rifi workflow.

```
## [1] "<font color='red'>example of E.coli data from RNA-seq</font>"
```

```
## [1] "assay e.coli"
```

```
##       0 1 10 15 2 20 3 4  5 6 8 0 1 10 15 2 20 3 4 5 6 8 0 1 10 15 2 20 3 4 5 6
## 17920 0 0  0  0 0 NA 0 0 NA 0 0 0 0  0  0 0  0 0 0 0 0 0 0 0  0  0 0  0 0 0 0 0
## 17921 0 0  0  0 0 NA 0 0 NA 0 0 0 0  0  0 0  0 0 0 0 0 0 0 0  0  0 0  0 0 0 0 0
## 17922 0 0  0  0 0 NA 0 0 NA 0 0 0 0  0  0 0  0 0 0 0 0 0 0 0  0  0 0  0 0 0 0 0
## 17923 0 0  0  0 0 NA 0 0 NA 0 0 0 0  0  0 0  0 0 0 0 0 0 0 0  0  0 0  0 0 0 0 0
## 17924 0 0  0  0 0 NA 0 0 NA 0 0 0 0  0  0 0  0 0 0 0 0 0 0 0  0  0 0  0 0 0 0 0
## 17925 0 0  0  0 0 NA 0 0 NA 0 0 0 0  0  0 0  0 0 0 0 0 0 0 0  0  0 0  0 0 0 0 0
##       8
## 17920 0
## 17921 0
## 17922 0
## 17923 0
## 17924 0
## 17925 0
```

```
## [1] "rowRanges e.coli"
```

```
## GRanges object with 6 ranges and 0 metadata columns:
##         seqnames        ranges strand
##            <Rle>     <IRanges>  <Rle>
##   17920      chr 895951-896000      +
##   17921      chr 896001-896050      +
##   17922      chr 896051-896100      +
##   17923      chr 896101-896150      +
##   17924      chr 896151-896200      +
##   17925      chr 896201-896250      +
##   -------
##   seqinfo: 1 sequence (1 circular) from BW25113 genome
```

```
## [1] "colData e.coli"
```

```
## DataFrame with 33 rows and 2 columns
##     timepoint replicate
##     <numeric> <numeric>
## 0           0         1
## 1           1         1
## 10         10         1
## 15         15         1
## 2           2         1
## ...       ...       ...
## 3           3         3
## 4           4         3
## 5           5         3
## 6           6         3
## 8           8         3
```

```
## [1] "example of Synechocystis data from microarrays"
```

```
## [1] "assay synechocystis"
```

```
##             0        2         4         8        16        32        64
## [1,] 1367.080 1116.401  864.0274  843.1331  829.7530  845.8492  811.0059
## [2,] 3316.336 2868.275 2324.4041 2524.7296 2273.0208 2346.8724 2411.1342
## [3,] 1112.101  939.558  834.7110  799.2554  800.8527  768.8366  788.5206
## [4,] 2012.294 1643.996 1023.7357  922.3281 1086.0212 1790.5634 3612.8782
## [5,] 1627.467 1392.391  997.9808 1007.3211 1071.9016 1016.9927  997.1751
## [6,] 1890.722 1830.202  902.2958  868.9673  840.6043  849.9464  887.8550
```

```
## [1] "rowRanges synechocystis"
```

```
## GRanges object with 6 ranges and 0 metadata columns:
##       seqnames    ranges strand
##          <Rle> <IRanges>  <Rle>
##   [1]      chr     22-67      +
##   [2]      chr   107-153      +
##   [3]      chr   145-199      +
##   [4]      chr   207-259      +
##   [5]      chr   260-320      +
##   [6]      chr   353-400      +
##   -------
##   seqinfo: 1 sequence from an unspecified genome; no seqlengths
```

```
## [1] "colData synechocystis"
```

```
## DataFrame with 7 rows and 2 columns
##    timepoint replicate
##    <numeric> <numeric>
## 0          0         1
## 2          2         1
## 4          4         1
## 8          8         1
## 16        16         1
## 32        32         1
## 64        64         1
```

The SE needs to comply to the following rules:

1. assays need to contains the intensities for the respective *probe* or *bin* need to be numeric. The first column
   is called “0” and refers to the first time point (before rifampicin addition).
   The intensities could contain 0 or NA except the column “0”.
2. rowRanges includes two columns, “ID” and “position”. Each ID in the column
   “ID” refers to the same, unique strand/position combination. Thus, each
   replicate has to share the same ID. IDs could be either numeric (advised) or
   character strings that do not contains “|”,"\_" or “,”.
3. colData contains 2 columns, timepoint and replicates.
4. metadata is optional.

### 2. `check_input`

Not complying to any of the rules will result in errors
and/or warnings by running “check\_input”:

As our standard input contains probes that are not expressed and thus have a
relative intensity of 0 at time point 0, in our example check\_input gives a
warning on which IDs have been removed, but the output can be safely used.

```
## Number of replicates: 3
```

```
## Timepoints: 0 1 2 3 4 5 6 8 10 15 20
```

```
## No IDs were given in the input. Default IDs were assigned.
```

### 3. `Filtration_Below_Background`

At this point, a custom filtration function can be applied to remove replicates
that are below the background.

This is especially useful for microarrays data. We supply a function **filtration\_below\_backg**
that filters for background but retains replicates that show a promising pattern
even when they are below background. When a different custom function is applied
within `rifi_preprocess` the input variable x must refer to the intensity vector
over all timepoints. The output must be a character string containing **FLT**
for all replicates that should be filtered. Additional arguments must be hard
coded or given as default value, as additional arguments can not be passed into
`rifi_preprocess`.

Application outside of `rifi_preprocess` can modify the ‘filtration’ column in
the input dataframe in any way, as that rows with replicates that should be
filtered contain the character string **FLT**.
The filtrated column would contain either(“FLT”, “*FLT*”, “*FLT\_your\_text",
NA, "*”, “*passed*”)

### 4. `make_df`

`make_df` calculates the means of all replicates, excluding the filtered
replicates. Optionally, probes or bins, where all replicates are filtered can
be removed, when rm\_FLT is set to TRUE (default is FALSE).
The column **probe\_TI** is added to rowRanges for a later step, in which it is
decided which probes are fitted with the TI model (see [finding\_TI](#finding_TI)).
For microarray data, the probes with intensity of the latest time point does not
fall below the background are considered stables mRNA. Those probes are marked
in the **flag** column with the tag ‘*ABG*’(“above background”). ‘bg’ is the
relative intensity threshold of the background. For RNAseq data the ‘ABG’
sub-model is used and bg is set to 0, so that all probes are flagged as
‘*ABG*’. The flag column is used to distribute different probes to the
different fitting models (see 7. finding\_TI) The output of ‘make\_df’ is the
probe based SE **probe\_df**. At this stage, The rowRanges contain the columns
**ID**, **position**, and **intensity** (of time point 0) as mean of
all replicates from assay and the columns **probe\_TI** and **flag**.
For our tutorial bg is set to 0, because its RNAseq data, and rm\_FLT
is TRUE to remove ID 18558 that we tagged with “FLT”,"\_" and "\_FLT\_your\_text".

```
probe <-
  make_df(
    inp = probe,
    cores = 2,
    bg = 0,
    rm_FLT = TRUE
  )
head(rowRanges(probe))
```

```
## GRanges object with 4 ranges and 6 metadata columns:
##       seqnames    ranges strand |  position          ID       FLT intensity
##          <Rle> <IRanges>  <Rle> | <integer> <character> <numeric> <numeric>
##   [1]      chr  951-1000      + |      1000           1         0   296.671
##   [2]      chr 1951-2000      + |      2000           2         0   297.339
##   [3]      chr 2951-3000      + |      3000           3         0   308.067
##   [4]      chr 3951-4000      + |      4000           4         0   303.609
##        probe_TI        flag
##       <numeric> <character>
##   [1]         1       _ABG_
##   [2]        -1       _ABG_
##   [3]         1       _ABG_
##   [4]        -1       _ABG_
##   -------
##   seqinfo: 1 sequence (1 circular) from BW25113 genome
```

### 5. `segment_pos`

For the segmentation into **position-segments** by regions without significant
sequencing depth, `segment_pos` is called. This step is needed to enhance
performance of the program, since large position segments increase the
runtime.
The size of the regions without significant sequencing depth (aka positions not
present in the rowRanges) or absence of probes is determined by the argument
**dist** (default is 300). Lower numbers create more, but smaller position
segments. Position segments are strand specific.

```
probe <- segment_pos(inp = probe, dista = 300)
head(rowRanges(probe))
```

```
## GRanges object with 4 ranges and 7 metadata columns:
##       seqnames    ranges strand |  position          ID       FLT intensity
##          <Rle> <IRanges>  <Rle> | <integer> <character> <numeric> <numeric>
##   [1]      chr  951-1000      + |      1000           1         0   296.671
##   [2]      chr 1951-2000      + |      2000           2         0   297.339
##   [3]      chr 2951-3000      + |      3000           3         0   308.067
##   [4]      chr 3951-4000      + |      4000           4         0   303.609
##        probe_TI        flag position_segment
##       <numeric> <character>      <character>
##   [1]         1       _ABG_              S_1
##   [2]        -1       _ABG_              S_2
##   [3]         1       _ABG_              S_3
##   [4]        -1       _ABG_              S_4
##   -------
##   seqinfo: 1 sequence (1 circular) from BW25113 genome
```

### 6. `finding_PDD`

Under the assumption of the standard model the RNA concentration should be
the same over the whole length of the transcript, if the decay constant is unchanged
and no partial premature termination appears. A linear or exponential intensity
decline indicates regions were something interesting happens. This could be in theory a decay by the
post transcription decay model (PDD) (Chen et al. [2015](#ref-chen_genome-wide_2015)), which is characterized by a linear decrease of
intensity by position. More likely is a fixed termination probability after each elongation step (exponential decrease),
e.g. resulting from the collision mode of transcriptional interference.
`finding_PDD` flags potential candidates for post
transcription decay with “*PDD*”. `finding_PDD` uses ‘score\_fun\_linear’
function to make groups by the difference to the slope. The rowRanges contains
**ID**, **intensity**, **position** and **position\_segment** columns.
`finding_PDD` needs additional parameters as **pen**, **pen\_out** and **thrsh**

```
#Due to increased run time, this example is not evaluated in the vignette
probe <-
  finding_PDD(
    inp = probe,
    cores = 2,
    pen = 2,
    pen_out = 2,
    thrsh = 0.001
  )
head(rowRanges(probe))
```

```
## GRanges object with 4 ranges and 7 metadata columns:
##       seqnames    ranges strand |  position          ID       FLT intensity
##          <Rle> <IRanges>  <Rle> | <integer> <character> <numeric> <numeric>
##   [1]      chr  951-1000      + |      1000           1         0   296.671
##   [2]      chr 1951-2000      + |      2000           2         0   297.339
##   [3]      chr 2951-3000      + |      3000           3         0   308.067
##   [4]      chr 3951-4000      + |      4000           4         0   303.609
##        probe_TI        flag position_segment
##       <numeric> <character>      <character>
##   [1]         1       _ABG_              S_1
##   [2]        -1       _ABG_              S_2
##   [3]         1       _ABG_              S_3
##   [4]        -1       _ABG_              S_4
##   -------
##   seqinfo: 1 sequence (1 circular) from BW25113 genome
```

### 7. `finding_TI`

As described in the [introduction](#i.-introduction) we want to indentify regions
with a rifampicin relieved termination. Transcription interference (TI) is one
explanation of the rifampicin relieved termination. Here TI is used as a synonym for
rifampicin relieved termination. `finding_TI` identifies regions of potential transcription interference (TI).
`finding_TI` uses `score_fun_ave` to make groups by the mean of “probe\_TI”. The
identified regions and a defined number of probes before the potential TI event
are flagged with ‘*TI*’. The identification is based on the probe\_TI column,
which is a report for each probe, whether a later time point is higher in
relative intensity than the first time point. The rowRanges needs the columns
**ID**, **intensity**, **position** and **position\_segment**.
`finding_TI` needs additional parameters as **pen**, **thrsh** and **add**.

```
#Due to increased run time, this example is not evaluated in the vignette
probe <-
  finding_TI(
    inp = probe,
    cores = 2,
    pen = 10,
    thrsh = 0.001
  )
head(rowRanges(probe))
```

```
## GRanges object with 4 ranges and 7 metadata columns:
##       seqnames    ranges strand |  position          ID       FLT intensity
##          <Rle> <IRanges>  <Rle> | <integer> <character> <numeric> <numeric>
##   [1]      chr  951-1000      + |      1000           1         0   296.671
##   [2]      chr 1951-2000      + |      2000           2         0   297.339
##   [3]      chr 2951-3000      + |      3000           3         0   308.067
##   [4]      chr 3951-4000      + |      4000           4         0   303.609
##        probe_TI        flag position_segment
##       <numeric> <character>      <character>
##   [1]         1    _ABG_TI_              S_1
##   [2]        -1       _ABG_              S_2
##   [3]         1    _ABG_TI_              S_3
##   [4]        -1       _ABG_              S_4
##   -------
##   seqinfo: 1 sequence (1 circular) from BW25113 genome
```

### 8. `rifi_preprocess`

All preprocessing steps can be run with `rifi_preprocess` at once. This section
will focus on all possible arguments that can be passed to the function.

```
#From here on the examples are shown on minimal examples.
#Two bigger data sets can be used to run the example as well.
preprocess_minimal <-
  rifi_preprocess(
    inp = probe,
    cores = 2,
    bg = 0,
    rm_FLT = TRUE,
    thrsh_check = 10,
    dista = 300,
    run_PDD = TRUE
  )
```

```
## running check_input...
```

```
## Number of replicates: 3
```

```
## Timepoints: 0 1 2 3 4 5 6 8 10 15 20
```

```
## running make_df...
```

```
## running segment_pos...
```

```
## running finding_PDD...
```

```
## running finding_TI...
```

```
head(rowRanges(preprocess_minimal))
```

```
## GRanges object with 4 ranges and 7 metadata columns:
##       seqnames    ranges strand |  position          ID       FLT intensity
##          <Rle> <IRanges>  <Rle> | <integer> <character> <numeric> <numeric>
##   [1]      chr  951-1000      + |      1000           1         0   296.671
##   [2]      chr 1951-2000      + |      2000           2         0   297.339
##   [3]      chr 2951-3000      + |      3000           3         0   308.067
##   [4]      chr 3951-4000      + |      4000           4         0   303.609
##        probe_TI        flag position_segment
##       <numeric> <character>      <character>
##   [1]         1    _ABG_TI_              S_1
##   [2]        -1       _ABG_              S_2
##   [3]         1    _ABG_TI_              S_3
##   [4]        -1       _ABG_              S_4
##   -------
##   seqinfo: 1 sequence (1 circular) from BW25113 genome
```

## III. rifi\_fit

`rifi_fit` wraps all fitting steps. The fitting functions fit the intensities
against the time series data. The first uses `nls2_fit` function to estimate
**delay**, **half-life**, **first time point intensity** and **background
intensity**.
The second uses `TI_fit` function to estimate **delay** and **half-life** additionally to the **TI-termination-factor**.

The function used are:

1. `nls2_fit`
2. `TI_fit`
3. `plot_nls2`
4. `plot_singleProbe_function`

```
## running nls2_fit...
```

```
## running TI_fit...
```

```
#Output
data(fit_e_coli)
head(rowRanges(fit_e_coli))
```

```
## GRanges object with 6 ranges and 10 metadata columns:
##         seqnames        ranges strand |  position          ID       FLT
##            <Rle>     <IRanges>  <Rle> | <integer> <character> <numeric>
##   18558      chr 927851-927900      + |    927900          82         0
##   18559      chr 927901-927950      + |    927950          83         0
##   18560      chr 927951-928000      + |    928000          84         0
##   18561      chr 928001-928050      + |    928050          85         0
##   18562      chr 928051-928100      + |    928100          86         0
##   18563      chr 928101-928150      + |    928150          87         0
##         intensity  probe_TI        flag position_segment     delay half_life
##         <numeric> <numeric> <character>      <character> <numeric> <numeric>
##   18558   42.4409        -1       _ABG_              S_1     0.001   2.25009
##   18559  140.3354        -1       _ABG_              S_1     0.001   2.06593
##   18560  103.5798        -1       _ABG_              S_1     0.001   2.11729
##   18561  175.4605        -1       _ABG_              S_1     0.001   2.32701
##   18562  143.4705        -1       _ABG_              S_1     0.001   2.93859
##   18563  109.2939        -1       _ABG_              S_1     0.001   3.16701
##         TI_termination_factor
##                     <numeric>
##   18558                    NA
##   18559                    NA
##   18560                    NA
##   18561                    NA
##   18562                    NA
##   18563                    NA
##   -------
##   seqinfo: 1 sequence (1 circular) from BW25113 genome
```

### 1. `nls2_fit`

`nls2_fit` function uses **nls2** function to fit a probe or bin using
intensities from different time point. **nls2** is able to use different
starting values using expand grid and select the best fit. The SE assays containing **intensity** of all timeserie and **ID** **intensity**, **position**, **probe\_TI**, **flag** and **position\_segment** columns from rowRanges are used as inputs (see below Table\_2). `nls2_fit` function has two different models, one includes the background as parameter and estimates decay subtracting it. The other excludes the background coefficient and is applied for probes flagged with
***ABG***. All probes flagged with ***FLT*** are not fitted as they are below
background. Finally probes flagged with ***TI*** are fitted with TI model. The
output data is an extension of SE metaData, **delay** and **half-life**
coefficients are added (see below “head(probe)”).

```
nls2_fit(inp = preprocess_minimal,
         cores = 1,
         decay = seq(.08, 0.11, by = .02),
         delay = seq(0, 10, by = .1),
         k = seq(0.1, 1, 0.2),
         bg = 0.2
)
```

```
Table_2 <- rowRanges(preprocess_minimal)
head(Table_2)
```

```
## GRanges object with 4 ranges and 7 metadata columns:
##       seqnames    ranges strand |  position          ID       FLT intensity
##          <Rle> <IRanges>  <Rle> | <integer> <character> <numeric> <numeric>
##   [1]      chr  951-1000      + |      1000           1         0   296.671
##   [2]      chr 1951-2000      + |      2000           2         0   297.339
##   [3]      chr 2951-3000      + |      3000           3         0   308.067
##   [4]      chr 3951-4000      + |      4000           4         0   303.609
##        probe_TI        flag position_segment
##       <numeric> <character>      <character>
##   [1]         1        _TI_              S_1
##   [2]        -1           _              S_2
##   [3]         1    _ABG_TI_              S_3
##   [4]        -1       _ABG_              S_4
##   -------
##   seqinfo: 1 sequence (1 circular) from BW25113 genome
```

```
probe <- metadata(fit_minimal)[[3]]
head(probe)
```

```
##        ID position    delay      decay          k        bg
## delay   2     2000 3.982766 0.65368274 0.42096687 0.3241019
## delay1  4     4000 2.628328 0.04253037 0.04041971 0.0000000
```

### 2. `TI_fit`

`TI_fit` estimates transcription interference and termination factor using nls
function for probe or bin flagged as **TI**. It estimates the transcription
interference level (referred later to TI) as well as the transcription factor
fitting the probes/bins with nls function looping into several starting values.
To determine **TI** and **termination factor**, `TI_fit` function is applied to
the flagged probes and to the probes localized 200 nucleotides upstream. Before
applying `TI_fit` function, some probes/bins are filtered out if they are below
the background using `generic_filter_BG`. The model loops into a dataframe
containing sequences of starting values and the coefficients are extracted from
the fit with the lowest residuals. When many residuals are equal to 0, the
lowest residual can not be determined and the coefficients extracted could be
wrong. Therefore, a second filter was developed. First a loop is applied into
all starting values, nls objects are collected in tmp\_v vector and the
corresponding residuals in tmp\_r vector. The residuals are sorted and those non
equal to 0 are collected into a vector. If the first values are not equal to 0,
the best 20% of the list are collected in tmp\_r\_min vector and the minimum
termination factor is selected. On the other hand residuals between 0 to 20% of
the values collected in tmp\_r\_min vector are gathered. The minimum termination
factor coefficient is determined and stored. The coefficients are gathered in
res vector and saved as an object. The output data are additional columns in
SE rowRanges named **delay**, **half-life** and **TI\_termination\_factor**
(see. “head(probe)”).

```
TI_fit(inp = preprocess_minimal,
       cores = 1,
       restr = 0.2,
       k = seq(0, 1, by = 0.5),
       decay = c(0.05, 0.1, 0.2, 0.5, 0.6),
       ti = seq(0, 1, by = 0.5),
       ti_delay = seq(0, 2, by = 0.5),
       rest_delay = seq(0, 2, by = 0.5),
       bg = 0
)
```

```
probe <- metadata(fit_minimal)[[4]]
head(probe)
```

```
##           ID position  ti_delay rest_delay      decay         k         ti
## ti_delay   1     1000 0.9257506   2.465721 0.71438975 0.5894164 0.24540387
## ti_delay1  3     3000 0.6660732   1.432176 0.05845456 0.1271130 0.08344505
##                  bg
## ti_delay  0.2370688
## ti_delay1 0.0000000
```

### 3. `plot_nls2`

`plot_nls2` plots the fit from nls2 with the corresponding coefficients,
**delay** and **decay**. **delay** is indicated on the x-axis and **half\_life**
is calculated from ln2/decay. The output is shown on nls2Plot figure.

```
plot_nls2_function(inp = probe_df)
```

![**Standard fit with nls2**](data:image/png;base64...)

Figure 8: **Standard fit with nls2**

`plot_nls2` also plots the fit from TI with the corresponding coefficients,
**delay**, **ti\_delay**, **half\_life**, **TI\_termination\_factor** and
**TI**. Additional parameters are included on the legend a, the output is shown
on TIPlot figure.

```
plot_nls2_function(inp = probe_df)
```

![**TI model fit**](data:image/png;base64...)

Figure 9: **TI model fit**

## IV. rifi penalties

‘rifi’ uses dynamic programming to combine *probes/bins* with equal properties
in the extracted values into segments (called fragmentation in ‘rifi’). The penalties define the specificity and sensitivity of the fragmentation. Higher penalties will result in less segments, i.e. a lower sensitivity but a higher specificity and vice versa. For convenience ‘rifi’ provides an automatic method which tries to maximize the correct segment splits and to minimize the wrong splits using statistics. The result can be best investigated in the final visualization. If needed the penalties can be manually adapted.

`rifi_penalties` wraps all penalty steps, wraps the functions: `make_pen` and
`viz_pen_obj.` For use of this wrapper jump to [`rifi_penalties`](#rifi_penalties)

### 1. `make_pen`

`make_pen` calls one of four available penalty functions to automatically assign
penalties for the dynamic programming. Four functions are called:

1. `fragment_delay_pen`
2. `fragment_HL_pen`
3. `fragment_inty_pen`
4. `fragment_TI_pen`

These functions return the amount of statistically correct and statistically
wrong splits at a specific pair of penalties. ‘make\_pen’ iterates over many
penalty pairs and picks the most suitable pair based on the difference between
wrong and correct splits. The sample size, penalty range and resolution as well
as the number of cycles can be customized. The primary start parameters create a
matrix with n = rez\_pen rows and n = rez\_pen\_out columns with values between
sta\_pen/sta\_pen\_out and end\_pen/end\_pen\_out. The best penalty pair is
picked. If dept is bigger than 1 the same process is repeated with a new matrix
of the same size based on the result of the previous cycle. Only position
segments with length within the sample size range are considered for the
penalties to increase run time. ALso, outlier penalties cannot be smaller
than 40% of the respective penalty. `make_pen` returns a penalty object (list
of 4 objects) the first being the logbook.

```
data(fit_minimal)
pen_delay <-
  make_pen(
    probe = fit_minimal,
    FUN = rifi:::fragment_delay_pen,
    cores = 2,
    logs = logbook,
    dpt = 1,
    smpl_min = 0,
    smpl_max = 18,
    sta_pen = 0.5,
    end_pen = 4.5,
    rez_pen = 9,
    sta_pen_out = 0.5,
    end_pen_out = 3.5,
    rez_pen_out = 7
  )
pen_HL <- make_pen(
  probe = fit_minimal,
  FUN = rifi:::fragment_HL_pen,
  cores = 2,
  logs = logbook,
  dpt = 1,
  smpl_min = 0,
  smpl_max = 18,
  sta_pen = 0.5,
  end_pen = 4.5,
  rez_pen = 9,
  sta_pen_out = 0.5,
  end_pen_out = 3.5,
  rez_pen_out = 7
)
pen_inty <-
  make_pen(
    probe = fit_minimal,
    FUN = rifi:::fragment_inty_pen,
    cores = 2,
    logs = logbook,
    dpt = 1,
    smpl_min = 0,
    smpl_max = 18,
    sta_pen = 0.5,
    end_pen = 4.5,
    rez_pen = 9,
    sta_pen_out = 0.5,
    end_pen_out = 3.5,
    rez_pen_out = 7
  )
pen_TI <- make_pen(
  probe = fit_minimal,
  FUN = rifi:::fragment_TI_pen,
  cores = 2,
  logs = logbook,
  dpt = 1,
  smpl_min = 0,
  smpl_max = 18,
  sta_pen = 0.5,
  end_pen = 4.5,
  rez_pen = 9,
  sta_pen_out = 0.5,
  end_pen_out = 3.5,
  rez_pen_out = 7
)
```

#### 1. `fragment_delay_pen`

`fragment_delay_pen` is called by `make_pen` function to automatically assign
penalties for the dynamic programming of delay fragment. The function used for
`fragment_delay_pen` is `score_fun_linear`. `score_fun_linear` scores the values
of y on how close they are to a linear fit, for more details check
`functions_scoring.r`.

#### 2. `fragment_HL_pen`

`fragment_HL_pen` is called by `make_pen` function to automatically assign
penalties for the dynamic programming of half-life fragments. The function used for
`fragment_HL_pen` is `score_fun_ave`. `score_fun_ave` scores the values of y on
how close they are to the mean, for more details check ‘functions\_scoring.r’.

#### 3. `fragment_inty_pen`

`fragment_inty_pen` is called by `make_pen` function to automatically assign
penalties for the dynamic programming of intensity fragments. The function used for
`fragment_inty_pen` is `score_fun_ave`. `score_fun_ave` scores the values of y
on how close they are to the mean, for more details check
‘functions\_scoring.r’.

#### 4. `fragment_TI_pen`

`fragment_TI_pen` is called by `make_pen` function to automatically assign
penalties for the dynamic programming of TI fragments. The function used for
`fragment_TI_pen` is `score_fun_ave`. `score_fun_ave` scores the values of y on
how close they are to the mean, for more details check ‘functions\_scoring.r’.

### 2. `viz_pen_obj`

`viz_pen_obj` an optional visualization of any penalty object created by
make\_pen and can be customized to show only the n = top\_i top results. Results
are ranked from worst to best for correct-wrong ratio, and color coded by
penalty, while the outlier-penalty is given as a number for each point. Red and
green dots represent the wrong and correct splits respectively.

```
viz_pen_obj(obj = pen_delay, top_i = 10)
```

![**penalty plot**: The graphic shows penalties ranked by the correct fits subtracted by the wrong fits. Each penalty corresponds to a color given in the legend. Red dots represent wrong splits, green dots represent correct splits. In the zoomed window (bottom) numbers above the dots represent the outlier-penalty.](data:image/png;base64...)

Figure 10: **penalty plot**: The graphic shows penalties ranked by the correct fits subtracted by the wrong fits
Each penalty corresponds to a color given in the legend. Red dots represent wrong splits, green dots represent correct splits. In the zoomed window (bottom) numbers above the dots represent the outlier-penalty.

## V. rifi fragmentation

`rifi_fragmentation` conveniently wraps all fragmentation steps, wraps the
functions: `fragment_delay`, `fragment_HL`, `fragment_inty`, `TUgether` and
`fragment_TI`.

The functions called are:

1. `fragment_delay`
2. `fragment_HL`
3. `fragment_inty`
4. `fragment_TI`
5. `TUgether`

```
## running fragment_delay...
```

```
## running fragment_HL...
```

```
## running fragment_inty...
```

```
## running TUgether...
```

```
## running fragment_TI...
```

```
data(fragmentation_e_coli)
head(rowRanges(fragmentation_e_coli))
```

```
## GRanges object with 6 ranges and 22 metadata columns:
##         seqnames        ranges strand |  position          ID       FLT
##            <Rle>     <IRanges>  <Rle> | <integer> <character> <numeric>
##   18558      chr 927851-927900      + |    927900          82         0
##   18559      chr 927901-927950      + |    927950          83         0
##   18560      chr 927951-928000      + |    928000          84         0
##   18561      chr 928001-928050      + |    928050          85         0
##   18562      chr 928051-928100      + |    928100          86         0
##   18563      chr 928101-928150      + |    928150          87         0
##         intensity  probe_TI        flag position_segment     delay half_life
##         <numeric> <numeric> <character>      <character> <numeric> <numeric>
##   18558   42.4409        -1       _ABG_              S_1     0.001   2.25009
##   18559  140.3354        -1       _ABG_              S_1     0.001   2.06593
##   18560  103.5798        -1       _ABG_              S_1     0.001   2.11729
##   18561  175.4605        -1       _ABG_              S_1     0.001   2.32701
##   18562  143.4705        -1       _ABG_              S_1     0.001   2.93859
##   18563  109.2939        -1       _ABG_              S_1     0.001   3.16701
##         TI_termination_factor delay_fragment velocity_fragment intercept
##                     <numeric>    <character>         <numeric> <numeric>
##   18558                    NA            D_1           20699.5  -44.8333
##   18559                    NA            D_1           20699.5  -44.8333
##   18560                    NA            D_1           20699.5  -44.8333
##   18561                    NA            D_1           20699.5  -44.8333
##   18562                    NA            D_1           20699.5  -44.8333
##   18563                    NA            D_1           20699.5  -44.8333
##               slope HL_fragment HL_mean_fragment intensity_fragment
##           <numeric> <character>        <numeric>        <character>
##   18558 4.83103e-05        Dc_1          2.19008                I_1
##   18559 4.83103e-05        Dc_1          2.19008                I_1
##   18560 4.83103e-05        Dc_1          2.19008                I_1
##   18561 4.83103e-05        Dc_1          2.19008                I_1
##   18562 4.83103e-05        Dc_2          3.01682                I_2
##   18563 4.83103e-05        Dc_2          3.01682                I_2
##         intensity_mean_fragment          TU TI_termination_fragment
##                       <numeric> <character>             <character>
##   18558                 102.000        TU_1                    <NA>
##   18559                 102.000        TU_1                    <NA>
##   18560                 102.000        TU_1                    <NA>
##   18561                 102.000        TU_1                    <NA>
##   18562                  77.528        TU_1                    <NA>
##   18563                  77.528        TU_1                    <NA>
##         TI_mean_termination_factor                seg_ID
##                          <numeric>           <character>
##   18558                         NA S_1|TU_1|D_1|Dc_1|I_1
##   18559                         NA S_1|TU_1|D_1|Dc_1|I_1
##   18560                         NA S_1|TU_1|D_1|Dc_1|I_1
##   18561                         NA S_1|TU_1|D_1|Dc_1|I_1
##   18562                         NA S_1|TU_1|D_1|Dc_2|I_2
##   18563                         NA S_1|TU_1|D_1|Dc_2|I_2
##   -------
##   seqinfo: 1 sequence (1 circular) from BW25113 genome
```

### 1. `fragment_delay`

`fragment_delay` makes delay\_fragments based on position\_segments and assigns
all gathered information to the probe based data frame. The columns
“delay\_fragment”, “velocity\_fragment”, “intercept” and “slope” are added.
`fragment_delay` makes delay\_fragments, assigns slopes, velocity (1/slope) and
intercepts for the TU calculation.

The function used are:

`score_fun_linear`

`score_fun_linear` is the score function used by dynamic programming for delay
fragmentation, for more details, see below.

```
data(fragmentation_minimal)
data(penalties_minimal)
probe_df <- fragment_delay(
  inp = fragmentation_minimal,
  cores = 2,
  pen = penalties_minimal["delay_penalty"],
  pen_out = penalties_minimal["delay_outlier_penalty"]
)
head(rowRanges(probe_df))
```

### 2. `fragment_HL`

`fragment_HL` performs the half\_life fragmentation based on delay\_fragments
and assigns all gathered information to the probe based data frame. The columns
“HL\_fragment” and “HL\_mean\_fragment” are added to rowRanges(SE). `fragment_HL`
makes half-life\_fragments and assigns the mean of each fragment.

The function used is:

`score_fun_ave`

`score_fun_ave` is the score function used by dynamic programming for half-life
fragmentation, for more details, see below.

```
data(fragmentation_minimal)
data(penalties_minimal)
probe_df <- fragment_HL(
  probe = fragmentation_minimal,
  cores = 2,
  pen = penalties_minimal["half_life_penalty"],
  pen_out = penalties_minimal["half_life_outlier_penalty"]
)
head(rowRanges(probe_df))
```

### 3. `fragment_inty`

`fragment_inty` performs the intensity fragmentation based on HL\_fragments and
assigns all gathered information to the probe based data frame. The columns
“intensity\_fragment” and “intensity\_mean\_fragment” are added rowRanges(SE).
`fragment_inty` makes intensity\_fragments and assigns the mean of each fragment.

The function used is:

`score_fun_ave`

`score_fun_ave` is the score function used by dynamic programming for intensity
fragmentation, for more details, see below.

```
data(fragmentation_minimal)
data(penalties_minimal)
probe_df <- fragment_inty(
  inp = fragmentation_minimal,
  cores = 2,
  pen = penalties_minimal["intensity_penalty"],
  pen_out = penalties_minimal["intensity_outlier_penalty"]
)
head(rowRanges(probe_df))
```

### 4. `TUgether`

`TUgether` combines delay fragments into TUs and adds a new column “TU” to
rowRanges(SE).

The function used is:

`score_fun_increasing`

`score_fun_increasing` is the score function used by dynamic programming for
`TUgether`, for more details, see below.

```
data(fragmentation_minimal)
probe_df <- TUgether(inp = fragmentation_minimal, cores = 2, pen = -0.75)
head(rowRanges(probe_df))
```

### 5. `fragment_TI`

`fragment_TI` performs the TI fragmentation based on TUs and assigns all
gathered information to the probe based SE. The columns
“TI\_termination\_fragment” and “TI\_mean\_termination\_factor” are added to
rowRanges(SE). `fragment_TI` makes TI\_fragments and assigns the mean of each
fragment.

The function used are:

`score_fun_ave`

`score_fun_ave` is the score function used by dynamic programming for TI
fragmentation, for more details, see below.

```
data(fragmentation_minimal)
data(penalties_minimal)
probe_df <- fragment_TI(
  inp = fragmentation_minimal,
  cores = 2,
  pen = penalties_minimal["TI_penalty"],
  pen_out = penalties_minimal["TI_outlier_penalty"]
)
head(rowRanges(probe_df))
```

## VI. rifi\_stats

`rifi_stats` wraps all statistical prediction steps.

The function wrapped are:

1. `predict_ps_itss`
2. `apply_Ttest_delay`
3. `apply_ancova`
4. `apply_event_position`
5. `apply_t_test`
6. `fold_change`
7. `apply_manova`
8. `apply_t_test_ti`
9. `gff3_preprocess`

```
data(fragmentation_minimal)
Path = gzfile(system.file("extdata", "gff_e_coli.gff3.gz", package = "rifi"))
stats_minimal <- rifi_stats(inp = fragmentation_minimal, dista = 300,
                            path = Path)
```

```
## running predict_ps_itss...
```

```
## running apply_Ttest_delay...
```

```
## running apply_ancova...
```

```
## running apply_event_position...
```

```
## running apply_t_test...
```

```
## running fold_change...
```

```
## running apply_manova...
```

```
## running apply_t_test_ti...
```

```
## Warning in `[<-.factor`(structure(c(3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, 3L, :
## invalid factor level, NA generated
```

```
head(rowRanges(stats_minimal))
```

```
## GRanges object with 6 ranges and 45 metadata columns:
##       seqnames    ranges strand |  position        ID       FLT intensity
##          <Rle> <IRanges>  <Rle> | <numeric> <integer> <numeric> <numeric>
##   [1]      chr      1-50      + |        50         1         0   138.552
##   [2]      chr    51-100      + |       100         2         0   146.886
##   [3]      chr   101-150      + |       150         3         0   152.349
##   [4]      chr   151-200      + |       200         4         0   163.387
##   [5]      chr   201-250      + |       250         5         0   149.006
##   [6]      chr   251-300      + |       300         6         0   160.369
##        probe_TI        flag position_segment     delay half_life
##       <numeric> <character>      <character> <numeric> <numeric>
##   [1]        -1       _ABG_              S_1 0.0833902   1.56869
##   [2]        -1       _ABG_              S_1 0.1737020   1.54311
##   [3]        -1       _ABG_              S_1 0.5035339   1.52367
##   [4]        -1       _ABG_              S_1 0.7566749   1.53506
##   [5]        -1       _ABG_              S_1 0.9972509   1.49575
##   [6]        -1       _ABG_              S_1 1.2143562   1.57844
##       TI_termination_factor delay_fragment velocity_fragment intercept
##                   <numeric>    <character>         <numeric> <numeric>
##   [1]                    NA            D_1           143.864 -0.504141
##   [2]                    NA            D_1           143.864 -0.504141
##   [3]                    NA            D_1           143.864 -0.504141
##   [4]                    NA            D_1           143.864 -0.504141
##   [5]                    NA            D_1           143.864 -0.504141
##   [6]                    NA            D_1           143.864 -0.504141
##           slope HL_fragment HL_mean_fragment intensity_fragment
##       <numeric> <character>        <numeric>        <character>
##   [1]  0.006951        Dc_1          1.54079                I_1
##   [2]  0.006951        Dc_1          1.54079                I_1
##   [3]  0.006951        Dc_1          1.54079                I_1
##   [4]  0.006951        Dc_1          1.54079                I_1
##   [5]  0.006951        Dc_1          1.54079                I_1
##   [6]  0.006951        Dc_1          1.54079                I_1
##       intensity_mean_fragment          TU TI_termination_fragment
##                     <numeric> <character>             <character>
##   [1]                 151.529        TU_1                    <NA>
##   [2]                 151.529        TU_1                    <NA>
##   [3]                 151.529        TU_1                    <NA>
##   [4]                 151.529        TU_1                    <NA>
##   [5]                 151.529        TU_1                    <NA>
##   [6]                 151.529        TU_1                    <NA>
##       TI_mean_termination_factor                seg_ID pausing_site      iTSS_I
##                        <numeric>           <character>  <character> <character>
##   [1]                         NA S_1|TU_1|D_1|Dc_1|I_1            -           -
##   [2]                         NA S_1|TU_1|D_1|Dc_1|I_1            -           -
##   [3]                         NA S_1|TU_1|D_1|Dc_1|I_1            -           -
##   [4]                         NA S_1|TU_1|D_1|Dc_1|I_1            -           -
##   [5]                         NA S_1|TU_1|D_1|Dc_1|I_1            -           -
##   [6]                         NA S_1|TU_1|D_1|Dc_1|I_1            -           -
##       ps_ts_fragment event_duration event_ps_itss_p_value_Ttest p_value_slope
##          <character>      <numeric>                   <numeric>     <numeric>
##   [1]           <NA>             NA                          NA   0.000191393
##   [2]           <NA>             NA                          NA   0.000191393
##   [3]           <NA>             NA                          NA   0.000191393
##   [4]           <NA>             NA                          NA   0.000191393
##   [5]           <NA>             NA                          NA   0.000191393
##   [6]           <NA>             NA                          NA   0.000191393
##       delay_frg_slope velocity_ratio event_position FC_fragment_HL     FC_HL
##           <character>      <numeric>      <numeric>    <character> <numeric>
##   [1]         D_1:D_2        2.90033             NA           <NA>  0.980823
##   [2]         D_1:D_2        2.90033             NA           <NA>  0.980823
##   [3]         D_1:D_2        2.90033             NA           <NA>  0.980823
##   [4]         D_1:D_2        2.90033             NA           <NA>  0.980823
##   [5]         D_1:D_2        2.90033             NA           <NA>  0.980823
##   [6]         D_1:D_2        2.90033             NA           <NA>  0.980823
##        p_value_HL FC_fragment_intensity FC_intensity p_value_intensity
##         <numeric>           <character>    <numeric>         <numeric>
##   [1] 5.19732e-14                  <NA>     0.984576       2.68496e-10
##   [2] 5.19732e-14                  <NA>     0.984576       2.68496e-10
##   [3] 5.19732e-14                  <NA>     0.984576       2.68496e-10
##   [4] 5.19732e-14                  <NA>     0.984576       2.68496e-10
##   [5] 5.19732e-14                  <NA>     0.984576       2.68496e-10
##   [6] 5.19732e-14                  <NA>     0.984576       2.68496e-10
##       FC_HL_intensity FC_HL_intensity_fragment FC_HL_adapted synthesis_ratio
##             <numeric>                <logical>     <logical>       <logical>
##   [1]      0.00375293                     <NA>          <NA>            <NA>
##   [2]      0.00375293                     <NA>          <NA>            <NA>
##   [3]      0.00375293                     <NA>          <NA>            <NA>
##   [4]      0.00375293                     <NA>          <NA>            <NA>
##   [5]      0.00375293                     <NA>          <NA>            <NA>
##   [6]      0.00375293                     <NA>          <NA>            <NA>
##       synthesis_ratio_event p_value_Manova p_value_TI TI_fragments_p_value
##                   <logical>      <logical>  <numeric>          <character>
##   [1]                  <NA>           <NA>         NA                 <NA>
##   [2]                  <NA>           <NA>         NA                 <NA>
##   [3]                  <NA>           <NA>         NA                 <NA>
##   [4]                  <NA>           <NA>         NA                 <NA>
##   [5]                  <NA>           <NA>         NA                 <NA>
##   [6]                  <NA>           <NA>         NA                 <NA>
##   -------
##   seqinfo: 1 sequence (1 circular) from BW25113 genome
```

### 1. `predict_ps_itss`

`predict_ps_itss` predicts pausing sites **ps** and internal starting sites
**iTSS\_I** between delay fragments within the same TU. `predict_ps_itss`
compares the neighboring delay segments to each other by positioning the
intercept of the second segment into the first segment using slope and intercept
coefficients.
`predict_ps_itss` selects unique TUs, delay fragments, slope, velocity fragment
and intercept. It loops into all delay segments and estimate the coordinates of
the last point of the first segment using the coefficients of the second segment
and vice versa. The difference between the predicted positions is compared to
the threshold. In case the strand is “-”, the positions of both segments are
ordered from the last position to the first one. All positions are merged into
one column and subtracted from the maximum position. The column is split in 2,
the first and second correspond to the positions of the first and second
segments respectively. Both segments are subsequently subjected to lm fit and
the positions predicted are used on the same way as on the opposite strand. The
difference between the predicted positions is compared to the negative
threshold, **ps** is assigned otherwise, and if the difference is higher than
the positive threshold, **iTSS\_I** is assigned. The event duration is
additionally added.

```
data(fragmentation_minimal)
probe <- predict_ps_itss(inp = fragmentation_minimal, maxDis = 300)
head(rowRanges(probe))
```

### 2. `apply_Ttest_delay`

`apply_Ttest_delay` uses `t-test` to check the significance of the points
between 2 segments showing pausing site **ps** and internal starting site
**iTSS\_I** independently.
`apply_Ttest_delay` selects the last point from the first segment and the first
point from the second segment and added them to the residuals of each model,
the sum is subjected to `t-test`.

```
probe <- apply_Ttest_delay(inp = probe)
head(rowRanges(probe))
```

### 3. `apply_ancova`

`apply_ancova` uses `ancova` to check the slope significance between two delay
fragments showing either pausing site (ps) or internal starting site (ITSS\_I).
`apply_ancova` brings both fragments to the same position and apply `ancova`
test.

```
probe <- apply_ancova(inp = probe)
head(rowRanges(probe))
```

### 4. `apply_event_position`

`apply_event_position` extract the position between 2 segments with pausing site
or iTSS\_I event.

```
probe <- apply_event_position(inp = probe)
head(rowRanges(probe))
```

### 5. `apply_t_test`

`apply_t_test` uses the statistical `t_test` to check if the fold-change of
half-life (HL) fragments and the fold-change intensity fragments respectively is
significant. `apply_t_test` compares the mean of two neighboring fragments
within the same TU to check if the fold-change is significant. Fragments with
distance above threshold are not subjected to t-test.

The functions used are:

1. `fragment_function`
2. `t_test_function`

#### 1. `fragment_function`

`fragment_function` checks number of fragments inside TU, only fragments above 2
are gathered for analysis.

#### 2. `t_test_function`

`t_test_function` makes fold-change and apply t-test, assign fragments names and
ratio, add columns with the corresponding p\_values.

```
probe <- apply_t_test(inp = probe, threshold = 300)
head(rowRanges(probe))
```

### 6. `fold_change`

`fold_change` sets a fold-change ratio between the neighboring fragments of
Half\_life (HL) and intensity of two successive fragments. Two intensity
fragments could belong to one HL fragment therefore the function sets first the
borders using the position and applies the fold-change ratio between the
neighboring fragments of HL and those from intensity ((half-life frgB /
half-life frgA) / (intensity frgB/intensity frgA)). All grepped fragments are
from the same TU excluding outliers.

The function used is:

`synthesis_r_Function`

`synthesis_r_Function` assigns events depending on the ratio between HL and
intensity of two consecutive fragments. Intensity (int) in steady state is
equivalent to synthesis rate(k)/decay(deg).

1. int = k/deg
2. int1/int2 = k1/deg1 \* deg2/k2
3. The synthesis ratio is equivalent to: int1 \* (deg1/int2) \* deg2 = k1/k2

Comparing the synthesis ratio to threshold, an event is assigned:

1. synthesis ratio > 1 -> New start
2. synthesis ratio < 1 -> Termination
3. synthesis ratio = 1 -> No change in synthesis rate

```
probe <- fold_change(inp = probe)
head(rowRanges(probe))
```

### 7. `apply_manova`

`apply_manova` checks if the ratio of HL ratio and intensity ratio is
statistically significant. `apply_manova` compares the variance between two
fold-changes, Half-life and intensity within the same TU ((half-life frgB /
half-life frgA) / (intensity frgB/intensity frgA)). One half-life fragment could cover two intensity fragments therefore the fragments borders should be set first.

the function used is:

`manova_function`

`manova_function` checks the variance between 2 segments (independent variables)
and two dependents variables (HL and intensity). The dataframe template is
depicted below. The lm fit is applied and p\_value is extracted.

```
apply_manova(inp = probe)
head(rowRanges(probe))
```

### 8. `apply_t_test_ti`

`apply_t_test_ti` compares the mean of two neighboring TI fragments within the
same TU using the statistical t\_test to check if two neighboring TI fragments
are significant. `apply_t_test_ti` selects TI fragments within the same TU
excluding the outliers. Two new columns are added, “ti\_fragments” and
“p\_value\_tiTest” referring to TI fragments subjected to t-test and their
p\_value.

### 9. `gff3_preprocess`

`gff3_preprocess` processes gff3 file from database, extracting gene names and
locus\_tag from all coding regions (CDS). Other features like UTRs, ncRNA, asRNA
ect.. are extracted if available on one hand and the genome length on other
hand. The output is a list of 2 elements and added to the input as metadata.

The output data frame from `gff3_preprocess` function contains the following
columns:

1. *region*: CDS or any other available like UTRs, ncRNA, asRNA
2. *start*: start position of the gene
3. *end*: end position of the gene
4. *strand*: +/-
5. *gene*: gene annotation if available otherwise locus\_tag annotation replaces
   it
6. *locus\_tag*: locus\_tag annotation

```
Path = gzfile(system.file("extdata", "gff_e_coli.gff3.gz", package = "rifi"))
  metadata(stats_minimal)$annot <- gff3_preprocess(path = Path)
```

**path** path: path to the directory containing the gff3 file

```
probe <- apply_t_test_ti(inp = probe)
head(rowRanges(probe))
```

## VII. rifi\_summary

`rifi_summary` wraps and summarizes all rifi outputs into different tables in a
compact form. The tables connect rifi output and genes annotation. Four tables
are generated and gathered as metadata into SE.

The functions used are:

1. `event_dataframe`
2. `dataframe_summary`
3. `dataframe_summary_events`
4. `dataframe_summary_events_HL_int`
5. `dataframe_summary_events_ps_itss`
6. `dataframe_summary_events_velocity`
7. `dataframe_summary_TI`

```
data(stats_minimal)
summary_minimal <- rifi_summary(stats_minimal)
```

```
data(summary_minimal)
head(metadata(summary_minimal))
```

### 1. `event_dataframe`

`event_dataframe` creates a data frame only with events for segments and genes.
`event_dataframe` selects columns with statistical features in addition to “ID”,
“position” and “TU” columns. The data frame combines fragments, events and statistical test and the corresponding genes. The column are:

**region**: feature of the genome e.g. CD, ncRNA, 5’UTR ect….

**gene**: gene annotation

**locus\_tag**: locus tag annotation

**strand**: strand if data is stranded

**TU**: TU annotation

**position**: position on the genome

**FC\_fragment\_intensity**: The intensity fragments subjected to fold change

**FC\_intensity**: fold change of two intensity fragments

**p\_value\_intensity**: p\_value of the fold change of two intensity fragments

**FC\_fragment\_HL**: The halflife fragments subjected to fold change

**FC\_HL**: fold change of two HL fragments

**p\_value\_HL**: p\_value of the fold change of two HL fragments

**FC\_HL\_intensity\_fragment**: The fragments subjected to ratio of
fold-change of two intensity fragments and the two half-life fragments

**FC\_HL\_intensity**: ratio of fold-change of two intensity fragments and
the two half-life fragments

**FC\_int\_adapted**: fold change of two intensity fragments

**FC\_HL\_adapted**: fold change of two HL fragments adapted to the
intensity fragments

**p\_value\_Manova**: p\_value of the statistical test Manova applied to
FC\_HL\_intensity

**synthesis\_ratio**: ratio of FC\_HL\_intensity

**synthesis\_ratio\_event**: event related to ratio

**pausing\_site**: presence or absence of ps is indicated by +/-

**ITSS\_I**: presence or absence of ITSS\_I is indicated by +/-

**event\_ps\_itss\_p\_value\_Ttest**: p\_value of the t-test applied to ps and
iTSS\_I.

**ps\_ts\_fragment**: The fragments subjected to ps and iTSS\_I

**event\_position**: event position

**delay**: delay coefficient extracted from the fit

**half\_life**: half-life coefficient extracted from the fit

**intensity**: intensity coefficient extracted from the fit

```
data(stats_minimal)
event_dataframe(data = stats_minimal, data_annotation = metadata(stats_minimal)$annot[[1]])
```

**probe** data frame: the probe based data frame

**data\_annotation** data frame: the coordinates extracted from gff3 file

The function used are:

1. `position_function`
2. `annotation_function_event`
3. `strand_function`

#### 1. `position_function`

`position_function` adds the specific position of pausing sites and iTSS\_I
events.

#### 2. `annotation_function_event`

`annotation_function_event` adds the events to the annotated genes.

#### 3. `strand_function`

`strand_function` used by `annotation_function_event` function in case of
stranded data.

### 2. `dataframe_summary`

`dataframe_summary` creates two tables summary of segments relating gene
annotation to fragments. `dataframe_summary` creates two tables summary of
segments and their half-lives. The first output is bin/probe features and the
second one is intensity fragment based. Both tables are added as metaData.

### 3. `dataframe_summary_events`

`dataframe_summary_events` creates one table relating gene annotation to all
events. The events are assigned on the first column. The table is added as
metaData.

### 4. `dataframe_summary_events_HL_int`

`dataframe_summary_events_HL_int` creates one table relating gene annotation to
all termination and new starting sites detected from half\_life and intensity
ratios. The events are assigned on the first column. The table is added as
metaData.

### 5. `dataframe_summary_events_ps_itss`

`dataframe_summary_events_ps_itss` creates one table relating gene annotation
with pausing sites and internal starting sites events detected from delay
fragments. The events are assigned on the first column. The table is added as
metaData.

### 6. `dataframe_summary_events_velocity`

`dataframe_summary_events_velocity` creates one table relating gene annotation
with velocity ration detected from delay fragments. The events are assigned
on the first column. The table is added as metaData.

### 7. `dataframe_summary_TI`

`dataframe_summary_TI` creates one table relating gene annotation to
transcription interference. The table is added as metaData.

## VIII. rifi\_visualization

`rifi_visualization` plots the whole genome with genes, transcription units
(TUs), delay, half-life (HL), intensity fragments features, events, velocity,
annotation, coverage if available. The function plots all annotation features
including genes, as-RNA, ncRNA, 5/3’UTR if available and TUs as segments.
`rifi_visualization` plots delay, HL and intensity fragments with statistical
t-test between the neighboring fragment, significant t-tests are assigned with
’\*’. The events are also indicated with asterisks if p\_value is significant.

The functions used are:

`gff3_preprocess`: see `rifi_stats` section

`strand_selection`: check if data is stranded and arrange by position

`splitGenome_function`: splits the genome into fragments

`indice_function`: assign a new column to the data to distinguish between
fragments, outliers and terminals from delay, HL and intensity

`TU_annotation`: designs the segments border for the genes and TUs
annotation

`gene_annot_function`: requires gff3 file, returns a dataframe adjusting
each fragment according to the annotation. It allows the plot of genes and
TUs shared in two pages

`label_log2_function`: adds log scale to intensity values

`label_square_function`: adds square scale to coverage values

`coverage_function`: the function is used only in case of coverage is
available

`secondaryAxis`: adjusts the halflife or delay to 20 in case of the
dataframe row numbers is equal to 1 and the halflife or delay exceed the
limit, they are plotted with different shape and color

`outlier_plot`: plot the outliers with half-life between 10 and 30 on the
maximum of the yaxis

`add_genomeBorders`: resolves the issue when the annotated genes are on the
borders and can not be plotted. The function splits the region in 2 adding
the row corresponding to the split part to the next page except for the
first page

`my_arrow`: creates an arrow for the annotation

`arrange_byGroup`: selects the last row for each segment and add 40
nucleotides in case of negative strand for a nice plot

`regr`: plots the predicted delay from linear regression. If data is
stranded (strand==1) and if the data is on negative strand

`meanPosition`: assign a mean position for the plot

`delay_mean`: adds a column in case of velocity is NA or equal to 60. The
mean of the delay is calculated excluding terminals and outliers

`my_segment_T`: plots terminals and pausing sites labels

`my_segment_NS`: plots internal starting sites ‘iTSS’

`min_value`: returns minimum value for event plots in intensity plot

`velocity_fun`: function to plot velocity

`limit_function`: for values above 10 or 20 in delay and hl, Limit of the
axis is set differently. yaxis limit is applied only if 3 values above 10
and lower or equal to 20 are present. An exception is added in case a
dataframe has less than 3 rows and 1 or more values are above 10, the rest
of the values above 20 are adjusted to 20 on `secondaryAxis` function

`empty_boxes`: used only in case the dataframe from the positive strand is
not empty, the TU are annotated

`function_TU_arrow`: avoids plotting arrows when a TU is split into two
pages

`terminal_plot_lm`: draws a linear regression line when terminal outliers
have an intensity above a certain threshold and are consecutive. Usually are
smallRNA (ncRNA, asRNA)

`slope_function`: replaces slope lower than 0.0009 to 0

`velo_function`: replaces infinite velocity with NA

`TI_frag_threshold`: splits the TI fragments on the same TI event

```
stats_minimal
rifi_visualization(
  data = stats_minimal
  )
```

![**Fragments Plot Forward Strand**](data:image/png;base64...)

Figure 11: **Fragments Plot Forward Strand**

![**Fragments Plot Reverse Strand**](data:image/png;base64...)

Figure 12: **Fragments Plot Reverse Strand**

### 1. Annotation

**TU**: Transcription unit annotation from Rifi workflow

**Locus tag**: Locus\_tag annotation from genome annotation

**gene**: gene annotation from genome annotation. If gene annotation is not
available, locus\_tag is given instead

### 2. Delay

**Delay**: Delay fragments, fragments annotation, “+/++/+++” indicates
velocity degree, events are indicated by “PS” or “iTSS”, "\*" indicates
significant statistical test

### 3. Half-life

**Half-life**: HL fragments, fragments annotation, events like termination
and iTTS\_II are indicated by “Ter” or “NS”; "\*" indicates significant
statistical test for HL fold change

### 4. Intensity/coverage

**Intensity**: Intensity fragments, fragments annotation, “*" indicates
significant statistical test for intensity fold change. An additional black
line above the fragments indicate the mean of TI factor for each fragment
and dots indicate TI factor for each bin. Dot vertical green lines shows TI
fragments, "Tinterf(*)” indicate significant statistical test between
fragments

**Coverage**: In case of available coverage, it could be plotted on the same
section as intensity

### 5. Additional features

**outliers**: are indicated by square shape an grey color

**high values**: are indicated by square shape an cyan color

## IX. Additional functions

1. `score_fun_linear`
2. `score_fun_ave`
3. `score_fun_increasing`

All these 3 functions are using the dynamic programming approach to part a
sequence of continuous points into fragments. It uses three principles steps:

1. iteration through values applying a function.
2. storing the values and their IDs.
3. selecting for the minimum or the maximum score according to the objective.
4. in case of the first 2 functions, the outliers are extracted.

### 1. `score_fun_linear`

`score_fun_linear` scores the residuals from a linear fit. `score_fun_linear`
fits a regression line from a vector of minimum 3 values **y**, a vector of
positions **x**. The IDs **z** and the sum of residuals are stored. A new value
y and x is added, the fit is performed and the new IDs and sum of residuals are
stored. After several fits, the minimum score and the corresponding IDs is
selected and stored as the best fragment. In case of the slope is bigger
as 1/60, the residuals are calculated as if the slope was 1/60. In case of the
stranded option is inactive and the slope is smaller as -1/60 the residuals are
calculated as if the slope was -1/60. In both cases, the velocity is limited
to 1 nucleotide per second. `score_fun_linear` selects simultaneously for
outliers, the maximum number is fixed previously. Outliers are those values with
high residuals, they are stored but excluded from the next fit. The output of
the function is a vector of IDs separated by “,”, a vector of velocity (1/slope)
separated by “*", a vector of intercept separated by "*” and a vector of
outliers.

```
score_fun_linear(y, x, z = x, pen, stran, n_out = min(10,
                                                      max(1, 0.4 * length(x))))
```

### 2. `score_fun_ave`

`score_fun_ave` scores the difference of the values from their mean.
`score_fun_ave` calculates the mean of a minimum 2 values **y** and substrates
the difference from their mean. The IDs **z** and the sum of differences from
the mean are stored. A new value y is added, the mean is calculated and the new
IDs and sum of differences are stored. After several rounds, the minimum score
and the corresponding IDs is selected and stored as the best fragment.
`score_fun_ave` selects simultaneously for outliers, the maximum number is fixed
previously. Outliers are those values with high difference from the mean, they
are stored but excluded from the next calculation. The output of the function is
a vector of IDs separated by “,”, a vector of mean separated by "\_" and a
vector of outliers separated by “,”.

```
score_fun_ave(y, z, pen, n_out = min(10, max(1, 0.4*length(z))))
```

### 3. `score_fun_increasing`

`score_fun_increasing` scores the difference between 2 values.
`score_fun_increasing` calculates the difference between 2 values **y**
comparing to their position, **x**. The sum of differences is stored and a new
value **y** is added. The difference is newly calculated and the sum is stored.
After several rounds, the maximum score is selected and TU is assigned.

```
score_fun_increasing(x, y)
```

## X. References

Campbell, E. A., N. Korzheva, A. Mustaev, K. Murakami, S. Nair, A. Goldfarb, and S. A. Darst. 2001. “Structural Mechanism for Rifampicin Inhibition of Bacterial Rna Polymerase.” *Cell* 104 (6): 901–12. [https://doi.org/10.1016/s0092-8674(01)00286-0](https://doi.org/10.1016/s0092-8674%2801%2900286-0).

Chen, Huiyi, Katsuyuki Shiroguchi, Hao Ge, and Xiaoliang Sunney Xie. 2015. “Genome-Wide Study of mRNA Degradation and Transcript Elongation in Escherichia Coli.” *Molecular Systems Biology* 11 (1): 781. <https://doi.org/10.15252/msb.20145794>.

Dar, Daniel, and Rotem Sorek. 2018. “Extensive Reshaping of Bacterial Operons by Programmed mRNA Decay.” *PLOS Genetics* 14 (4): e1007354. <https://doi.org/10.1371/journal.pgen.1007354>.

Shearwin, Keith E., Benjamin P. Callen, and J. Barry Egan. 2005. “Transcriptional Interference – a Crash Course.” *Trends in Genetics* 21 (6): 339–45. <https://doi.org/10.1016/j.tig.2005.04.009>.

Wang, Xun, Sang Chun Ji, Heung Jin Jeon, Yonho Lee, and Heon M. Lim. 2015. “Two-Level Inhibition of galK Expression by Spot 42: Degradation of mRNA mK2 and Enhanced Transcription Termination Before the galK Gene.” *Proceedings of the National Academy of Sciences* 112 (24): 7581–6. <https://doi.org/10.1073/pnas.1424683112>.

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
## [11] rifi_1.14.0                 BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.2.1         dplyr_1.1.4              farver_2.1.2
##  [4] Biostrings_2.78.0        bitops_1.0-9             S7_0.2.0
##  [7] RCurl_1.98-1.17          fastmap_1.2.0            GenomicAlignments_1.46.0
## [10] egg_0.4.5                XML_3.99-0.19            digest_0.6.37
## [13] lifecycle_1.0.4          ellipsis_0.3.2           magrittr_2.0.4
## [16] compiler_4.5.1           rlang_1.1.6              doMC_1.3.8
## [19] sass_0.4.10              tools_4.5.1              yaml_2.3.10
## [22] rtracklayer_1.70.0       knitr_1.50               S4Arrays_1.10.0
## [25] pkgbuild_1.4.8           curl_7.0.0               DelayedArray_0.36.0
## [28] plyr_1.8.9               RColorBrewer_1.1-3       BiocParallel_1.44.0
## [31] pkgload_1.4.1            abind_1.4-8              purrr_1.1.0
## [34] desc_1.4.3               nnet_7.3-20              grid_4.5.1
## [37] ggplot2_4.0.0            scales_1.4.0             iterators_1.0.14
## [40] dichromat_2.0-0.1        cli_3.6.5                crayon_1.5.3
## [43] rmarkdown_2.30           remotes_2.5.0            rstudioapi_0.17.1
## [46] reshape2_1.4.4           rjson_0.2.23             httr_1.4.7
## [49] nls2_0.3-4               sessioninfo_1.2.3        cachem_1.1.0
## [52] stringr_1.5.2            parallel_4.5.1           BiocManager_1.30.26
## [55] XVector_0.50.0           restfulr_0.0.16          vctrs_0.6.5
## [58] devtools_2.4.6           Matrix_1.7-4             jsonlite_2.0.0
## [61] carData_3.0-5            bookdown_0.45            car_3.1-3
## [64] Formula_1.2-5            foreach_1.5.2            jquerylib_0.1.4
## [67] proto_1.0.0              glue_1.8.0               codetools_0.2-20
## [70] cowplot_1.2.0            stringi_1.8.7            gtable_0.3.6
## [73] BiocIO_1.20.0            tibble_3.3.0             pillar_1.11.1
## [76] htmltools_0.5.8.1        R6_2.6.1                 rprojroot_2.1.1
## [79] evaluate_1.0.5           lattice_0.22-7           cigarillo_1.0.0
## [82] Rsamtools_2.26.0         memoise_2.0.1            bslib_0.9.0
## [85] Rcpp_1.1.0               gridExtra_2.3            SparseArray_1.10.0
## [88] xfun_0.53                fs_1.6.6                 usethis_3.2.1
## [91] pkgconfig_2.0.3
```