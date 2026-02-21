# Preprocessing with `CATALYST`

Helena L Crowell1,2\*, Vito RT Zanotelli3, Stéphane Chevrier3, Bernd Bodenmiller3 and Mark D Robinson1,2

1Institute for Molecular Life Sciences, University of Zurich, Switzerland
2SIB Swiss Institute of Bioinformatics, University of Zurich, Switzerland
3Department of Quantitative Biomedicine, University of Zurich, Switzerland

\*helena.crowell@uzh.ch

#### 20 November 2025

#### Abstract

By addressing the limit of measurable fluorescent parameters due to instrumentation and spectral overlap, mass cytometry (CyTOF) combines heavy metal spectrometry to allow examination of up to (theoretically) 100 parameters at the single cell level. While spectral overlap is significantly less pronounced in CyTOF than flow cytometry, spillover due to detection sensitivity, isotopic impurities, and oxide formation can impede data interpretability. We designed *[CATALYST](https://bioconductor.org/packages/3.22/CATALYST)* (Cytometry dATa anALYSis Tools) to provide tools for (pre)processing and analysis of cytometry data, including compensation and in particular, an improved implementation of the single-cell deconvolution algorithm.

#### Package

CATALYST 1.34.1

# Contents

* [1 Data examples](#data-examples)
* [2 Data organization](#data-organization)
* [3 Normalization](#normalization)
  + [3.1 Normalization workflow](#normalization-workflow)
    - [3.1.1 `normCytof`: Normalization using bead standards](#normcytof-normalization-using-bead-standards)
* [4 Debarcoding](#debarcoding)
  + [4.1 Debarcoding workflow](#debarcoding-workflow)
    - [4.1.1 `assignPrelim`: Assignment of preliminary IDs](#assignprelim-assignment-of-preliminary-ids)
    - [4.1.2 `estCutoffs`: Estimation of separation cutoffs](#estcutoffs-estimation-of-separation-cutoffs)
    - [4.1.3 `plotYields`: Selecting barcode separation cutoffs](#plotyields-selecting-barcode-separation-cutoffs)
    - [4.1.4 `applyCutoffs`: Applying deconvolution parameters](#applycutoffs-applying-deconvolution-parameters)
    - [4.1.5 `plotEvents`: Normalized intensities](#plotevents-normalized-intensities)
    - [4.1.6 `plotMahal`: All barcode biaxial plot](#plotmahal-all-barcode-biaxial-plot)
* [5 Compensation](#compensation)
  + [5.1 Compensation workflow](#compensation-workflow)
    - [5.1.1 `computeSpillmat`: Estimation of the spillover matrix](#computespillmat-estimation-of-the-spillover-matrix)
    - [5.1.2 `plotSpillmat`: Spillover matrix heatmap](#plotspillmat-spillover-matrix-heatmap)
    - [5.1.3 `compCytof`: Compensation of mass cytometry data](#compcytof-compensation-of-mass-cytometry-data)
* [6 Scatter plot visualization](#scatter-plot-visualization)
  + [6.1 Example 1: Coloring by cell density](#example-1-coloring-by-cell-density)
  + [6.2 Example 2: Coloring by variables](#example-2-coloring-by-variables)
  + [6.3 Example 3: Facetting by variables](#example-3-facetting-by-variables)
* [7 Conversion to other data structures](#conversion-to-other-data-structures)
  + [7.1 Writing FCS files](#writing-fcs-files)
  + [7.2 Gating & visualization](#gating-visualization)
* [8 Session information](#session-information)
* [References](#references)

**Most of the pipeline and visualizations presented herein have been adapted from Chevrier et al. ([2018](#ref-Chevrier2018-CATALYST))’s *“Compensation of Signal Spillover in Suspension and Imaging Mass Cytometry”* available [here](https://doi.org/10.1016/j.cels.2018.02.010).**

```
# load required packages
library(CATALYST)
library(cowplot)
library(flowCore)
library(ggplot2)
library(SingleCellExperiment)
```

# 1 Data examples

* **Normalization:**
* **Debarocoding:**
* **Compensation:**
  Alongside the multiplexed-stained cell sample `mp_cells`, the package contains 36 single-antibody stained controls in `ss_exp` where beads were stained with antibodies captured by mass channels 139, 141 through 156, and 158 through 176, respectively, and pooled together. Note that, to decrease running time, we downsampled to a total of 10’000 events. Lastly, `isotope_list` contains a named list of isotopic compositions for all elements within 75 through 209 u corresponding to the CyTOF mass range at the time of writing (Coursey et al. [2015](#ref-Coursey2015)).

# 2 Data organization

Data used and returned throughout preprocessing are organized into an object of the *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* (SCE) class. A SCE can be constructed from a directory housing a single or set of FCS files, a character vector of the file(s), `flowFrame`(s) or a `flowSet` (from the *[flowCore](https://bioconductor.org/packages/3.22/flowCore)* package) using `CATALYST`’s `prepData` function.

`prepData` will automatically identify channels not corresponding to masses (e.g., event times), remove them from the output SCE’s assay data, and store them as internal event metadata (`int_colData`).

When multiple files or frames are supplied, `prepData` will concatenate the data into a single object, and argument `by_time` (default `TRUE`) specifies whether runs should be ordered by their acquisition time (`keyword(x, "$BTIM")`, where `x` is a `flowFrame` or `flowSet`). A `"sample_id"` column will be added to the output SCE’s `colData` to track which file/frame events originally source from.

Finally, when `transform` (default `TRUE`), an arcsinh-transformation with cofactor `cofactor` (defaults to 5) is applied to the input (count) data, and the resulting expression matrix is stored in the `"exprs"` assay slot of the output SCE.

```
data("raw_data")
(sce <- prepData(raw_data))
```

```
## class: SingleCellExperiment
## dim: 61 5000
## metadata(2): experiment_info chs_by_fcs
## assays(2): counts exprs
## rownames(61): BC1 Vol1 ... Pb208Di BC9
## rowData names(4): channel_name marker_name marker_class use_channel
## colnames: NULL
## colData names(1): sample_id
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

```
# view number of events per sample
table(sce$sample_id)
```

```
##
## raw_data_1.fcs raw_data_2.fcs
##           2500           2500
```

```
# view non-mass channels
names(int_colData(sce))
```

```
## [1] "reducedDims"  "altExps"      "colPairs"     "Time"         "Event_length"
## [6] "Center"       "Offset"       "Width"        "Residual"
```

# 3 Normalization

*[CATALYST](https://bioconductor.org/packages/3.22/CATALYST)* provides an implementation of bead-based normalization as described by Finck et al. (Finck et al. [2013](#ref-Finck2013-normalization)). Here, identification of bead-singlets (used for normalization), as well as of bead-bead and cell-bead doublets (to be removed) is automated as follows:

1. beads are identified as events with their top signals in the bead channels
2. cell-bead doublets are remove by applying a separation cutoff to the distance between the lowest bead and highest non-bead signal
3. events passing all vertical gates defined by the lower bounds of bead signals are removed (these include bead-bead and bead-cell doublets)
4. bead-bead doublets are removed by applying a default \(median\;\pm5\;mad\) rule to events identified in step 2. The remaining bead events are used for normalization.

## 3.1 Normalization workflow

### 3.1.1 `normCytof`: Normalization using bead standards

Since bead gating is automated here, normalization comes down to a single function that takes a `SingleCellExperiment` as input and only requires specification of the `beads` to be used for normalization. Valid options are:

* `"dvs"` for bead masses 140, 151, 153, 165, 175
* `"beta"` for bead masses 139, 141, 159, 169, 175
* or a custom numeric vector of bead masses

By default, we apply a \(median\;\pm5\;mad\) rule to remove low- and high-signal events from the bead population used for estimating normalization factors. The extent to which bead populations are trimmed can be adjusted via `trim`. The population will become increasingly narrow and bead-bead doublets will be exluded as the `trim` value decreases. Notably, slight *over-trimming* will **not** affect normalization. It is therefore recommended to choose a `trim` value that is small enough to assure removal of doublets at the cost of a small bead population to normalize to.

`normCytof` will return the following list of SCE(s)…

* `data`: Input dataset including normalized counts (and expressions, if `transform = TRUE`).
  + if `remove_beads = FALSE`, `colData` columns `"is_bead"` and `"remove"` indicate whether an event has been marker as a bead or for removal, respectively.
  + otherwise, bead and doublet events are excluded and the following additional data is returned:
    - `beads`: Subset of identified bead events.
    - `removed`: Subset of all cells that have been from the original dataset,
      including bead events as well as bead-bead and bead-cell doublets.

…and `ggplot`-objects:

* `scatter`: Scatter plot of bead vs. DNA intensities with indication of applied gates.
* `lines`: Running-median smoothed bead intensities vs. time before and after normalization.

Besides general normalized parameters (`beads` specifying the normalization beads, and running median windown width `k`), `normCytof` requires as input to `assays` corresponding to count- and expression-like data respectively. Here, correction factors are computed on the linear (count) scale, while automated bead-identification happens on the transformed (expression) scale.

By default, `normCytof` will overwrite the specified `assays` with the normalized data (`overwrite = TRUE`). In order to retain both unnormalized and normalized data, `overwrite` should be set to `FALSE`, in which case normalized counts (and expression, when `transform = TRUE`) will be written to separate assay `normcounts/exprs`, respectively.

```
# construct SCE
sce <- prepData(raw_data)
# apply normalization; keep raw data
res <- normCytof(sce, beads = "dvs", k = 50,
  assays = c("counts", "exprs"), overwrite = FALSE)
# check number & percentage of bead / removed events
n <- ncol(sce); ns <- c(ncol(res$beads), ncol(res$removed))
data.frame(
    check.names = FALSE,
    "#" = c(ns[1], ns[2]),
    "%" = 100*c(ns[1]/n, ns[2]/n),
    row.names = c("beads", "removed"))
```

```
##           #    %
## beads   141 2.82
## removed 153 3.06
```

```
# extract data excluding beads & doublets,
# and including normalized intensitied
sce <- res$data
assayNames(sce)
```

```
## [1] "counts"     "exprs"      "normcounts" "normexprs"
```

```
# plot bead vs. dna scatters
res$scatter
```

![](data:image/png;base64...)

```
# plot smoothed bead intensities
res$lines
```

![](data:image/png;base64...)

# 4 Debarcoding

*[CATALYST](https://bioconductor.org/packages/3.22/CATALYST)* provides an implementation of the single-cell deconvolution algorithm described by Zunder et al. (Zunder et al. [2015](#ref-Zunder2015-debarcoding)). The package contains three functions for debarcoding and three visualizations that guide selection of thresholds and give a sense of barcode assignment quality.

In summary, events are assigned to a sample when i) their positive and negative barcode populations are separated by a distance larger than a threshold value and ii) the combination of their positive barcode channels appears in the barcoding scheme. Depending on the supplied scheme, there are two possible ways of arriving at preliminary event assignments:

1. **Doublet-filtering**:
   Given a binary barcoding scheme with a coherent number \(k\) of positive channels for all IDs, the \(k\) highest channels are considered positive and \(n-k\) channels negative. Separation of positive and negative events equates to the difference between the \(k\)th highest and \((n-k)\)th lowest intensity value. If a numeric vector of masses is supplied, the barcoding scheme will be an identity matrix; the most intense channel is considered positive and its respective mass assigned as ID.
2. **Non-constant number of 1’s**:
   Given a non-uniform number of 1’s in the binary codes, the highest separation between consecutive barcodes is looked at. In both, the doublet-filtering and the latter case, each event is assigned a binary code that, if matched with a code in the barcoding scheme supplied, dictates which row name will be assigned as ID. Cells whose positive barcodes are still very low or whose binary pattern of positive and negative barcodes doesn’t occur in the barcoding scheme will be given ID 0 for *“unassigned”*.

All data required for debarcoding are held in objects of the *[SingleCellExperiment](https://bioconductor.org/packages/3.22/SingleCellExperiment)* (SCE) class, allowing for the following easy-to-use workflow:

1. as the initial step of single-cell deconcolution, `assignPrelim` will return a SCE containing the input measurement data, barcoding scheme, and preliminary event assignments.
2. assignments will be made final by `applyCutoffs`. It is recommended to estimate, and possibly adjust, population-specific separation cutoffs by running `estCutoffs` prior to this.
3. `plotYields`, `plotEvents` and `plotMahal` aim to guide selection of devoncolution parameters and to give a sense of the resulting barcode assignment quality.

## 4.1 Debarcoding workflow

### 4.1.1 `assignPrelim`: Assignment of preliminary IDs

The debarcoding process commences by assigning each event a preliminary barcode ID. `assignPrelim` thereby takes either a binary barcoding scheme or a vector of numeric masses as input, and accordingly assigns each event the appropirate row name or mass as ID. FCS files are read into R with `read.FCS` of the *[flowCore](https://bioconductor.org/packages/3.22/flowCore)* package, and are represented as an object of class `flowFrame`:

```
data(sample_ff)
sample_ff
```

```
## flowFrame object 'anonymous'
## with 20000 cells and 6 observables:
##        name   desc     range  minRange  maxRange
## 1 (Pd102)Di  BC102   9745.80 -0.999912   9745.80
## 2 (Pd104)Di  BC104   9687.52 -0.999470   9687.52
## 3 (Pd105)Di  BC105   8924.64 -0.998927   8924.64
## 4 (Pd106)Di  BC106   8016.67 -0.999782   8016.67
## 5 (Pd108)Di  BC108   9043.87 -0.999997   9043.87
## 6 (Pd110)Di  BC110   8204.46 -0.999937   8204.46
## 0 keywords are stored in the 'description' slot
```

The debarcoding scheme should be a binary table with sample IDs as row and numeric barcode masses as column names:

```
data(sample_key)
head(sample_key)
```

```
##    102 104 105 106 108 110
## A1   1   1   1   0   0   0
## A2   1   1   0   1   0   0
## A3   1   1   0   0   1   0
## A4   1   1   0   0   0   1
## A5   1   0   1   1   0   0
## B1   1   0   1   0   1   0
```

Provided with a `SingleCellExperiment` and a compatible barcoding scheme (barcode masses must occur as parameters in the supplied SCE), `assignPrelim` will add the following data to the input SCE:
- assay slot `"scaled"` containing normalized expression values where each population is scaled to the 95%-quantile of events assigend to the respective population.
- `colData` columns `"bc_id"` and `"delta"` containing barcode IDs and separations between lowest positive and highest negative intensity (on the normalized scale)
- `rowData` column `is_bc` specifying, for each channel, whether it has been specified as a barcode channel

```
sce <- prepData(sample_ff)
(sce <- assignPrelim(sce, sample_key))
```

```
## Debarcoding data...
```

```
##  o ordering
```

```
##  o classifying events
```

```
## Normalizing...
```

```
## Computing deltas...
```

```
## class: SingleCellExperiment
## dim: 6 20000
## metadata(3): experiment_info chs_by_fcs bc_key
## assays(3): counts exprs scaled
## rownames(6): BC102 BC104 ... BC108 BC110
## rowData names(5): channel_name marker_name marker_class use_channel
##   is_bc
## colnames: NULL
## colData names(3): sample_id bc_id delta
## reducedDimNames(0):
## mainExpName: NULL
## altExpNames(0):
```

```
# view barcode channels
rownames(sce)[rowData(sce)$is_bc]
```

```
## [1] "BC102" "BC104" "BC105" "BC106" "BC108" "BC110"
```

```
# view number of events assigned to each barcode population
table(sce$bc_id)
```

```
##
##   A1   A2   A3   A4   A5   B1   B2   B3   B4   B5   C1   C2   C3   C4   C5   D1
## 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000 1000
##   D2   D3   D4   D5
## 1000 1000 1000 1000
```

### 4.1.2 `estCutoffs`: Estimation of separation cutoffs

As opposed to a single global cutoff, `estCutoffs` will estimate a sample-specific cutoff to deal with barcode population cell yields that decline in an asynchronous fashion. Thus, the choice of thresholds for the distance between negative and positive barcode populations can be *i) automated* and *ii) independent for each barcode*. Nevertheless, reviewing the yield plots (see below), checking and possibly refining separation cutoffs is advisable.

For the estimation of cutoff parameters we consider yields upon debarcoding as a function of the applied cutoffs. Commonly, this function will be characterized by an initial weak decline, where doublets are excluded, and subsequent rapid decline in yields to zero. Inbetween, low numbers of counts with intermediate barcode separation give rise to a plateau. To facilitate robust estimation, we fit a linear and a three-parameter log-logistic function (Finney [1971](#ref-Finney1971)) to the yields function with the `LL.3` function of the *[drc](https://CRAN.R-project.org/package%3Ddrc)* R package (Ritz et al. [2015](#ref-Ritz2015)) (Figure [1](#fig:estCutoffs)). As an adequate cutoff estimate, we target a point that marks the end of the plateau regime and on-set of yield decline to appropriately balance confidence in barcode assignment and cell yield.

The goodness of the linear fit relative to the log-logistic fit is weighed as follow:
\[w = \frac{\text{RSS}\_{log-logistic}}{\text{RSS}\_{log-logistic}+\text{RSS}\_{linear}}\]

The cutoffs for both functions are defined as:

\[c\_{linear} = -\frac{\beta\_0}{2\beta\_1}\]
\[c\_{log-logistic}=\underset{x}{\arg\min}\:\frac{\vert\:f'(x)\:\vert}{f(x)} > 0.1\]

The final cutoff estimate \(c\) is defined as the weighted mean between these estimates:

\[c=(1-w)\cdot c\_{log-logistic}+w\cdot c\_{linear}\]

![](data:image/png;base64...)

Figure 1: Description of the automatic cutoff estimation for each individual population
The bar graphs indicate the distribution of cells relative to the barcode distance and the dotted line corresponds to the yield upon debarcoding as a function of the applied separation cutoff. This curve is fitted with a linear regression (blue line) and a three parameter log-logistic function (red line). The cutoff estimate is defined as the mean of estimates derived from both fits, weighted with the goodness of the respective fit.

```
# estimate separation cutoffs
sce <- estCutoffs(sce)
# view separation cutoff estimates
metadata(sce)$sep_cutoffs
```

```
##        A1        A2        A3        A4        A5        B1        B2        B3
## 0.3811379 0.3262184 0.3225851 0.2879897 0.3423528 0.3583485 0.3113566 0.3242730
##        B4        B5        C1        C2        C3        C4        C5        D1
## 0.3200084 0.2955329 0.3909571 0.3462298 0.3288156 0.2532980 0.2397771 0.2469145
##        D2        D3        D4        D5
## 0.3221655 0.3319978 0.2804174 0.3311446
```

### 4.1.3 `plotYields`: Selecting barcode separation cutoffs

For each barcode, `plotYields` will show the distribution of barcode separations and yields upon debarcoding as a function of separation cutoffs. If available, the currently used separation cutoff as well as its resulting yield within the population is indicated in the plot’s main title.

Option `which = 0` will render a summary plot of all barcodes. All yield functions should behave as described above: decline, stagnation, decline. Convergence to 0 yield at low cutoffs is a strong indicator that staining in this channel did not work, and excluding the channel entirely is sensible in this case. It is thus recommended to **always** view the all-barcodes yield plot to eliminate uninformative populations, since small populations may cause difficulties when computing spill estimates.

```
plotYields(sce, which = c(0, "C1"))
```

![](data:image/png;base64...)![](data:image/png;base64...)

### 4.1.4 `applyCutoffs`: Applying deconvolution parameters

Once preliminary assignments have been made, `applyCutoffs` will apply the deconvolution parameters: Outliers are filtered by a Mahalanobis distance threshold, which takes into account each population’s covariance, and doublets are removed by excluding events from a population if the separation between their positive and negative signals fall below a separation cutoff. Current thresholds are held in the `sep_cutoffs` and `mhl_cutoff` slots of the SCE’s `metadata`. By default, `applyCutoffs` will try to access the `metadata` `"sep_cutoffs"` slopt of the input SCE, requiring having run `estCutoffs` prior to this, or manually specifying a vector or separation cutoffs. Alternatively, a numeric vector of cutoff values or a single, global value may be supplied In either case, it is highly recommended to thoroughly review the yields plot (see above), as the choice of separation cutoffs will determine debarcoding quality and cell yield.

```
# use global / population-specific separation cutoff(s)
sce2 <- applyCutoffs(sce)
sce3 <- applyCutoffs(sce, sep_cutoffs = 0.35)

# compare yields before and after applying
# global / population-specific cutoffs
c(specific = mean(sce2$bc_id != 0),
    global = mean(sce3$bc_id != 0))
```

```
## specific   global
##  0.68035  0.66970
```

```
# proceed with population-specific filtering
sce <- sce2
```

### 4.1.5 `plotEvents`: Normalized intensities

Normalized intensities for a barcode can be viewed with `plotEvents`. Here, each event corresponds to the intensities plotted on a vertical line at a given point along the x-axis. Option `which = 0` will display unassigned events, and the number of events shown for a given sample may be varied via argument `n`. If `which = "all"`, the function will render an event plot for all IDs (including 0) with events assigned.

```
# event plots for unassigned events
# & barcode population D1
plotEvents(sce, which = c(0, "D1"), n = 25)
```

![](data:image/png;base64...)![](data:image/png;base64...)

### 4.1.6 `plotMahal`: All barcode biaxial plot

Function `plotMahal` will plot all inter-barcode interactions for the population specified with argument `which`. Events are colored by their Mahalanobis distance. *NOTE: For more than 7 barcodes (up to 128 samples) the function will render an error, as this visualization is infeasible and hardly informative. Using the default Mahalanobis cutoff value of 30 is recommended in such cases.*

```
plotMahal(sce, which = "B3")
```

![](data:image/png;base64...)

# 5 Compensation

*[CATALYST](https://bioconductor.org/packages/3.22/CATALYST)* performs compensation via a two-step approach comprising:

1. identification of single positive populations via single-cell debarcoding (SCD) of single-stained beads (or cells)
2. estimation of a spillover matrix (SM) from the populations identified, followed by compensation via multiplication of measurement intensities by its inverse, the compensation matrix (CM).

***Retrieval of real signal.*** As in conventional flow cytometry, we can model spillover linearly, with the channel stained for as predictor, and spill-effected channels as response. Thus, the intensity observed in a given channel \(j\) are a linear combination of its real signal and contributions of other channels that spill into it. Let \(s\_{ij}\) denote the proportion of channel \(j\) signal that is due to channel \(i\), and \(w\_j\) the set of channels that spill into channel \(j\). Then

\[I\_{j, observed}\; = I\_{j, real} + \sum\_{i\in w\_j}{s\_{ij}}\]

In matrix notation, measurement intensities may be viewed as the convolution of real intensities and a spillover matrix with dimensions number of events times number of measurement parameters:

\[I\_{observed}\; = I\_{real} \cdot SM\]

Therefore, we can estimate the real signal, \(I\_{real}\;\), as:

\[I\_{real} = I\_{observed}\; \cdot {SM}^{-1} = I\_{observed}\; \cdot CM\]
where \(\text{SM}^{-1}\) is termed compensation matrix (\(\text{CM}\)). This approach is implemented in `compCytof(..., method = "flow")` and makes use of *[flowCore](https://bioconductor.org/packages/3.22/flowCore)*’s `compensate` function.

While mathematically exact, the solution to this equation will yield negative values, and does not account for the fact that real signal would be strictly non-negative counts. A computationally efficient way to adress this is the use of non-negative linear least squares (NNLS):

\[\min \: \{ \: ( I\_{observed} - SM \cdot I\_{real} ) ^ T \cdot ( I\_{observed} - SM \cdot I\_{real} ) \: \} \quad \text{s.t.} \: I\_{real} ≥ 0\]

This approach will solve for \(I\_{real}\) such that the least squares criterion is optimized under the constraint of non-negativity. To arrive at such a solution we apply the Lawson-Hanson algorithm (Lawson and Hanson [1974](#ref-Lawson1974-NNLS1), [1995](#ref-Lawson1995-NNLS2)) for NNLS implemented in the *nnls* R package (`method="nnls"`).

***Estimation of SM.*** Because any signal not in a single stain experiment’s primary channel \(j\) results from channel crosstalk, each spill entry \(s\_{ij}\) can be approximated by the slope of a linear regression with channel \(j\) signal as the response, and channel \(i\) signals as the predictors, where \(i\in w\_j\). `computeSpillmat()` offers two alternative ways for spillover estimation, summarized in Figure [2](#fig:methods).

The `default` method approximates this slope with the following single-cell derived estimate: Let \(i^+\) denote the set of cells that are possitive in channel \(i\), and \(s\_{ij}^c\) be the channel \(i\) to \(j\) spill computed for a cell \(c\) that has been assigned to this population. We approximate \(s\_{ij}^c\) as the ratio between the signal in unstained spillover receiving and stained spillover emitting channel, \(I\_j\) and \(I\_i\), respectively. The expected background in these channels, \(m\_j^-\) and \(m\_i^-\), is computed as the median signal of events that are i) negative in the channels for which spill is estimated (\(i\) and \(j\)); ii) not assigned to potentionally interacting channels; and, iii) not unassigned, and subtracted from all measurements:

\[s\_{ij}^c = \frac{I\_j - m\_j^{i-}}{I\_i - m\_i^{i-}}\]

Each entry \(s\_{ij}\) in \(\text{SM}\) is then computed as the median spillover across all cells \(c\in i^+\):

\[s\_{ij} = \text{med}(s\_{ij}^c\:|\:c\in i^+)\]

In a population-based fashion, as done in conventional flow cytometry, `method = "classic"` calculates \(s\_{ij}\) as the slope of a line through the medians (or trimmed means) of stained and unstained populations, \(m\_j^+\) and \(m\_i^+\), respectively. Background signal is computed as above and substracted, according to:

\[s\_{ij} = \frac{m\_j^+-m\_j^-}{m\_i^+-m\_i^-}\]

![](data:image/png;base64...)

Figure 2: Population versus single-cell based spillover estimation.

On the basis of their additive nature, spill values are estimated independently for every pair of interacting channels. `interactions = "default"` thereby exclusively takes into account interactions that are sensible from a chemical and physical point of view:

* \(M\pm1\) channels (*abundance sensitivity*)
* the \(M+16\) channel (*oxide formation*)
* channels measuring isotopes (*isotopic impurities*)

See Table [1](#tab:isotopes) for the list of mass channels considered to potentionally contain isotopic contaminatons, along with a heatmap representation of all interactions considered by the `default` method in Figure [3](#fig:interactions).

Table 1: List of isotopes available for each metal used in CyTOF
In addition to \(M\pm1\) and \(M+16\) channels, these mass channels are considered during estimation of spill to capture channel crosstalk that is due to isotopic contanimations (Coursey et al. [2015](#ref-Coursey2015)).

| Metal | Isotope masses |
| --- | --- |
| La | 138, 139 |
| Pr | 141 |
| Nd | 142, 143, 144, 145, 146, 148, 150 |
| Sm | 144, 147, 148, 149, 150, 152, 154 |
| Eu | 151, 153 |
| Gd | 152, 154, 155, 156, 157, 158, 160 |
| Dy | 156, 158, 160, 161, 162, 163, 164 |
| Er | 162, 164, 166, 167, 168, 170 |
| Tb | 159 |
| Ho | 165 |
| Yb | 168, 170, 171, 172, 173, 174, 176 |
| Tm | 169 |
| Lu | 175, 176 |

![](data:image/png;base64...)

Figure 3: Heatmap of spill expected interactions
These are considered by the default method of *computeSpillmat*.

Alternatively, `interactions = "all"` will compute a spill estimate for all \(n\cdot(n-1)\) possible interactions, where \(n\) denotes the number of measurement parameters. Estimates falling below the threshold specified by `th` will be set to zero. Lastly, note that diagonal entries \(s\_{ii} = 1\) for all \(i\in 1, ..., n\), so that spill is relative to the total signal measured in a given channel.

## 5.1 Compensation workflow

### 5.1.1 `computeSpillmat`: Estimation of the spillover matrix

Given a SCE of single-stained beads (or cells) and a numeric vector specifying the masses stained for, `computeSpillmat` estimates the spillover matrix (SM) as described above; the estimated SM will be stored in the SCE’s `metadata` under `"spillover_matrix"`.

Spill values are affected my the `method` chosen for their estimation, that is `"median"` or `"mean"`, and, in the latter case, the specified `trim` percentage. The process of adjusting these options and reviewing the compensated data may iterative until compensation is satisfactory.

```
# get single-stained control samples
data(ss_exp)

# specify mass channels stained for & debarcode
bc_ms <- c(139, 141:156, 158:176)
sce <- prepData(ss_exp)
sce <- assignPrelim(sce, bc_ms, verbose = FALSE)
sce <- applyCutoffs(estCutoffs(sce))

# compute & extract spillover matrix
sce <- computeSpillmat(sce)
sm <- metadata(sce)$spillover_matrix

# do some sanity checks
chs <- channels(sce)
ss_chs <- chs[rowData(sce)$is_bc]
all(diag(sm[ss_chs, ss_chs]) == 1)
```

```
## [1] TRUE
```

```
all(sm >= 0 & sm <= 1)
```

```
## [1] TRUE
```

### 5.1.2 `plotSpillmat`: Spillover matrix heatmap

`plotSpillmat` provides a visualization of estimated spill percentages as a heatmap. Channels without a single-antibody stained control are annotated in grey, and colours are ramped to the highest spillover value present. Option `annotate = TRUE` (the default) will display spill values inside each bin, and the total amount of spill caused and received by each channel on the top and to the right, respectively.

`plotSpillmat` will try and access the SM stored in the input SCE’s `"spillover_matrix"` `metadata` slot, requiring having run `computeSpillmat` or manually specifying a matrix of appropriate format.

```
plotSpillmat(sce)
```

![](data:image/png;base64...)

### 5.1.3 `compCytof`: Compensation of mass cytometry data

Assuming a linear spillover, `compCytof` compensates mass cytometry based experiments using a provided spillover matrix. If the spillover matrix (SM) does not contain the same set of columns as the input experiment, it will be adapted according to the following rules:

1. columns present in the SM but not in the input data will be removed from it
2. non-metal columns present in the input but not in the SM will be added such that they do neither receive nor cause spill
3. metal columns that have the same mass as a channel present in the SM will receive (but not emit) spillover according to that channel
4. if an added channel could potentially receive spillover (as it has +/-1M or +16M of, or is of the same metal type as another channel measured), a warning will be issued as there could be spillover interactions that have been missed and may lead to faulty compensation

To omit the need to respecify the `cofactor`(s) for transformation, `transform = TRUE` will auto-transform the compensated data. `compCytof` will thereby try to reuse the `cofactor`(s) stored under `int_metadata(sce)$cofactor` from the previously applied transformation; otherwise, the `cofactor` argument should be specified.

If `overwrite = TRUE` (the default), `compCytof` will overwrite the specified counts `assay` (and `exprs`, when `transform = TRUE`) with the compensated data. Otherwise, compensated count (and expression) data will be stored in separate assays `compcounts/exprs`, respectively.

```
# construct SCE of multiplexed cells
data(mp_cells)
sce <- prepData(mp_cells)
# compensate using NNLS-method; keep uncompensated data
sce <- compCytof(sce, sm, method = "nnls", overwrite = FALSE)
# visualize data before & after compensation
chs <- c("Er167Di", "Er168Di")
as <- c("exprs", "compexprs")
ps <- lapply(as, function(a)
    plotScatter(sce, chs, assay = a))
plot_grid(plotlist = ps, nrow = 1)
```

![](data:image/png;base64...)

# 6 Scatter plot visualization

`plotScatter` provides a flexible way of visualizing expression data as biscatters, and supports automated facetting (should more than 2 channels be visualized). Cells may be colored by density (default `color_by = NULL`) or other (non-)continous variables. When coloring by density, `plotScatter` will use `geom_hex` to bin cells into the number of specified `bins`; otherwise cells will be plotted as points. The following code chunks shall illustrate these different functionalities:

## 6.1 Example 1: Coloring by cell density

```
# biscatter of DNA channels colored by cell density
sce <- prepData(raw_data)
chs <- c("DNA1", "DNA2")
plotScatter(sce, chs)
```

![](data:image/png;base64...)

```
# biscatters for selected CD-channels
sce <- prepData(mp_cells)
chs <- grep("^CD", rownames(sce), value = TRUE)
chs <- sample(chs, 7)
p <- plotScatter(sce, chs)
p$facet$params$ncol <- 3; p
```

![](data:image/png;base64...)

## 6.2 Example 2: Coloring by variables

```
sce <- prepData(sample_ff)
sce <- assignPrelim(sce, sample_key)
# downsample channels & barcode populations
chs <- sample(rownames(sce), 4)
ids <- sample(rownames(sample_key), 3)
sce <- sce[chs, sce$bc_id %in% ids]

# color by factor variable
plotScatter(sce, chs, color_by = "bc_id")
```

![](data:image/png;base64...)

```
# color by continuous variable
plotScatter(sce, chs, color_by = "delta")
```

![](data:image/png;base64...)

## 6.3 Example 3: Facetting by variables

```
# sample some random group labels
sce$group_id <- sample(c("groupA", "groupB"), ncol(sce), TRUE)

# selected pair of channels; split by barcode & group ID
plotScatter(sce, sample(chs, 2),
  color_by = "bc_id",
  facet_by = c("bc_id", "group_id"))
```

![](data:image/png;base64...)

```
# selected CD-channels; split by sample
plotScatter(sce, chs, bins = 50, facet_by = "bc_id")
```

![](data:image/png;base64...)

# 7 Conversion to other data structures

While the `SingleCellExperiment` class provides many advantages in terms of compactness, interactability and robustness, it can be desirous to write out intermediate files at each preprocessing stage, or to use other packages currently build around `flowCore` infrastructure (`flowFrame` and `flowSet` classes), or classes derived thereof (e.g., *[flowWorkspace](https://bioconductor.org/packages/3.22/flowWorkspace)*’s `GatingSet`). This section demonstrates how to safely convert between these data structures.

## 7.1 Writing FCS files

Conversion from SCE to `flowFrame`s/`flowSet`, which in turn can be written to FCS files using *[flowCore](https://bioconductor.org/packages/3.22/flowCore)*’s `write.FCS` function, is not straightforward. It is not recommended to directly write FCS via `write.FCS(flowFrame(t(assay(sce))))`, as this can lead to invalid FCS files or the data being shown on an inappropriate scale in e.g. Cytobank. Instead, `CATALYST` provides the `sce2fcs` function to facilitate correct back-conversion.

`sce2fcs` allows specification of a variable to split the SCE by (argument `split_by`), e.g., to split the data by sample after debarcoding; whether to keep or drop any cell metadata (argument `keep_cd`) and dimension reductions (argument `keep_dr`) available within the object; and which assay data to use (argument `assay`)111 Only count-like data should be written to FCS files and is guaranteed to show with appropriate scale in Cytobank!:

```
# run debarcoding
sce <- prepData(sample_ff)
sce <- assignPrelim(sce, sample_key)
sce <- applyCutoffs(estCutoffs(sce))
# exclude unassigned events
sce <- sce[, sce$bc_id != 0]
# convert to 'flowSet' with one frame per sample
(fs <- sce2fcs(sce, split_by = "bc_id"))
```

```
## A flowSet with 20 experiments.
##
## column names(6): (Pd102)Di (Pd104)Di ... (Pd108)Di (Pd110)Di
```

```
# split check: number of cells per barcode ID
# equals number of cells in each 'flowFrame'
all(c(fsApply(fs, nrow)) == table(sce$bc_id))
```

```
## [1] TRUE
```

Having converted out SCE to a `flowSet`, we can write out each of its `flowFrame`s to an FCS file with a meaningful filename that retains the sample of origin:

```
# get sample identifiers
ids <- fsApply(fs, identifier)
for (id in ids) {
    ff <- fs[[id]]                     # subset 'flowFrame'
    fn <- sprintf("sample_%s.fcs", id) # specify output name that includes ID
    fn <- file.path("...", fn)         # construct output path
    write.FCS(ff, fn)                  # write frame to FCS
}
```

## 7.2 Gating & visualization

Besides writing out FCS files, conversion to `flowFrame`s/`flowSet` also enables leveraging the existing infrastructure for these classes such as *[ggcyto](https://bioconductor.org/packages/3.22/ggcyto)* for visualization and *[openCyto](https://bioconductor.org/packages/3.22/openCyto)* for gating:

```
# load required packages
library(ggcyto)
library(openCyto)
library(flowWorkspace)

# construct 'GatingSet'
sce <- prepData(raw_data)
ff <- sce2fcs(sce, assay = "exprs")
gs <- GatingSet(flowSet(ff))

# specify DNA channels
dna_chs <- c("Ir191Di", "Ir193Di")

# apply elliptical gate
gs_add_gating_method(
    gs, alias = "cells",
    pop = "+", parent = "root",
    dims = paste(dna_chs, collapse = ","),
    gating_method = "flowClust.2d",
    gating_args = "K=1,q=0.9")

# plot scatter of DNA channels including elliptical gate
ggcyto(gs, aes(
    x=.data[[dna_chs[1]]],
    y=.data[[dna_chs[2]]])) +
    geom_hex(bins = 128) +
    geom_gate(data = "cells") +
    facet_null() + ggtitle(NULL) +
    theme(aspect.ratio = 1,
        panel.grid.minor = element_blank())
```

![](data:image/png;base64...)

# 8 Session information

```
sessionInfo()
```

```
## R version 4.5.2 (2025-10-31)
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
##  [1] openCyto_2.22.0             ggcyto_1.38.0
##  [3] flowWorkspace_4.22.0        ncdfFlow_2.56.0
##  [5] BH_1.87.0-1                 scater_1.38.0
##  [7] ggplot2_4.0.1               scuttle_1.20.0
##  [9] diffcyt_1.30.0              flowCore_2.22.0
## [11] cowplot_1.2.0               CATALYST_1.34.1
## [13] SingleCellExperiment_1.32.0 SummarizedExperiment_1.40.0
## [15] Biobase_2.70.0              GenomicRanges_1.62.0
## [17] Seqinfo_1.0.0               IRanges_2.44.0
## [19] S4Vectors_0.48.0            BiocGenerics_0.56.0
## [21] generics_0.1.4              MatrixGenerics_1.22.0
## [23] matrixStats_1.5.0           BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] splines_4.5.2               tibble_3.3.0
##   [3] polyclip_1.10-7             graph_1.88.0
##   [5] XML_3.99-0.20               lifecycle_1.0.4
##   [7] Rdpack_2.6.4                rstatix_0.7.3
##   [9] edgeR_4.8.0                 doParallel_1.0.17
##  [11] lattice_0.22-7              MASS_7.3-65
##  [13] backports_1.5.0             magrittr_2.0.4
##  [15] limma_3.66.0                sass_0.4.10
##  [17] rmarkdown_2.30              jquerylib_0.1.4
##  [19] yaml_2.3.10                 plotrix_3.8-13
##  [21] minqa_1.2.8                 RColorBrewer_1.1-3
##  [23] ConsensusClusterPlus_1.74.0 multcomp_1.4-29
##  [25] abind_1.4-8                 Rtsne_0.17
##  [27] purrr_1.2.0                 TH.data_1.1-5
##  [29] tweenr_2.0.3                sandwich_3.1-1
##  [31] circlize_0.4.16             ggrepel_0.9.6
##  [33] irlba_2.3.5.1               RSpectra_0.16-2
##  [35] codetools_0.2-20            DelayedArray_0.36.0
##  [37] ggforce_0.5.0               tidyselect_1.2.1
##  [39] shape_1.4.6.1               farver_2.1.2
##  [41] lme4_1.1-37                 ScaledMatrix_1.18.0
##  [43] viridis_0.6.5               jsonlite_2.0.0
##  [45] GetoptLong_1.0.5            BiocNeighbors_2.4.0
##  [47] Formula_1.2-5               ggridges_0.5.7
##  [49] survival_3.8-3              iterators_1.0.14
##  [51] foreach_1.5.2               tools_4.5.2
##  [53] ggnewscale_0.5.2            Rcpp_1.1.0
##  [55] glue_1.8.0                  gridExtra_2.3
##  [57] SparseArray_1.10.2          xfun_0.54
##  [59] dplyr_1.1.4                 withr_3.0.2
##  [61] BiocManager_1.30.27         fastmap_1.2.0
##  [63] boot_1.3-32                 digest_0.6.39
##  [65] rsvd_1.0.5                  R6_2.6.1
##  [67] colorspace_2.1-2            Cairo_1.7-0
##  [69] gtools_3.9.5                dichromat_2.0-0.1
##  [71] utf8_1.2.6                  tidyr_1.3.1
##  [73] hexbin_1.28.5               data.table_1.17.8
##  [75] FNN_1.1.4.1                 S4Arrays_1.10.0
##  [77] uwot_0.2.4                  pkgconfig_2.0.3
##  [79] gtable_0.3.6                ComplexHeatmap_2.26.0
##  [81] RProtoBufLib_2.22.0         S7_0.2.1
##  [83] XVector_0.50.0              htmltools_0.5.8.1
##  [85] carData_3.0-5               bookdown_0.45
##  [87] RBGL_1.86.0                 clue_0.3-66
##  [89] scales_1.4.0                png_0.1-8
##  [91] reformulas_0.4.2            colorRamps_2.3.4
##  [93] knitr_1.50                  reshape2_1.4.5
##  [95] rjson_0.2.23                nlme_3.1-168
##  [97] nloptr_2.2.1                cachem_1.1.0
##  [99] zoo_1.8-14                  GlobalOptions_0.1.2
## [101] stringr_1.6.0               parallel_4.5.2
## [103] vipor_0.4.7                 pillar_1.11.1
## [105] grid_4.5.2                  vctrs_0.6.5
## [107] ggpubr_0.6.2                car_3.1-3
## [109] BiocSingular_1.26.1         cytolib_2.22.0
## [111] beachmat_2.26.0             cluster_2.1.8.1
## [113] beeswarm_0.4.0              Rgraphviz_2.54.0
## [115] evaluate_1.0.5              tinytex_0.58
## [117] magick_2.9.0                mvtnorm_1.3-3
## [119] cli_3.6.5                   locfit_1.5-9.12
## [121] compiler_4.5.2              rlang_1.1.6
## [123] crayon_1.5.3                ggsignif_0.6.4
## [125] labeling_0.4.3              FlowSOM_2.18.0
## [127] plyr_1.8.9                  ggbeeswarm_0.7.2
## [129] stringi_1.8.7               viridisLite_0.4.2
## [131] BiocParallel_1.44.0         nnls_1.6
## [133] Matrix_1.7-4                statmod_1.5.1
## [135] rbibutils_2.4               drc_3.0-1
## [137] igraph_2.2.1                broom_1.0.10
## [139] bslib_0.9.0                 flowClust_3.48.0
```

# References

Chevrier, Stéphane, Helena L Crowell, Vito R T Zanotelli, Stefanie Engler, Mark D Robinson, and Bernd Bodenmiller. 2018. “Compensation of Signal Spillover in Suspension and Imaging Mass Cytometry.” *Cell Systems* 6 (5): 612–620.e5.

Coursey, J S, D J Schwab, J J Tsai, and R A Dragoset. 2015. “Atomic Weights and Isotopic Compositions with Relative Atomic Masses.” *NIST Physical Measurement Laboratory*.

Finck, Rachel, Erin F Simonds, Astraea Jager, Smita Krishnaswamy, Karen Sachs, Wendy Fantl, Dana Pe’er, Garry P Nolan, and Sean C Bendall. 2013. “Normalization of Mass Cytometry Data with Bead Standards.” *Cytometry A* 83 (5): 483–94.

Finney, D J. 1971. “Probit Analysis.” *Journal of Pharmaceutical Sciences* 60 (9): 1432.

Lawson, Charles L, and Richard J Hanson. 1995. *Solving Least Squares Problems*. Philadelphia, PA: SIAM.

Lawson, Charles L, and R J Hanson. 1974. *Solving Least Squares Problems Prentice-Hall*. Englewood Cliffs, NJ: Prentice Hall.

Ritz, Christian, Florent Baty, Jens C Streibig, and Daniel Gerhard. 2015. “Dose-Response Analysis Using R.” *PLoS One* 10 (12): e0146021.

Zunder, Eli R, Rachel Finck, Gregory K Behbehani, El-Ad D Amir, Smita Krishnaswamy, Veronica D Gonzalez, Cynthia G Lorang, et al. 2015. “Palladium-Based Mass Tag Cell Barcoding with a Doublet-Filtering Scheme and Single-Cell Deconvolution Algorithm.” *Nature Protocols* 10 (2): 316–33.