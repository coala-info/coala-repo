# Detecting Drug Synergy and Antagonism with PharmacoGx 3.0+

Christopher Eeles1\*, Feifei Li2, Petr Smirnov1,3\*\* and Benjamin Haibe-Kains1,3\*\*\*

1Princess Margaret Cancer Centre, University Health Network, Toronto Canada
2Department of Cell & System Biology, University of Toronto, Toronto Canada
3Department of Medical Biophysics, University of Toronto, Toronto Canada

\*christopher.eeles@uhnresearch.ca
\*\*psmirnov@utoronto.ca
\*\*\*benjamin.haibe.kains@utoronto.ca

#### 30 October 2025

#### Abstract

Drug combinations are an effective strategy to overcome incomplete response
or acquired resistance to monotherapies in clinical oncology and beyond. As
such, detecting molecular signatures of drug synergy or antagonism in
pre-clinical model systems is a major priority to accelerate the adoption of
novel treatment strategies in the clinic. The release of PharmacoGx 3.0
introduces support for storing, analyzing and visualizing the results of drug
combination experiments using the PharmacoSet class, and will enable
reseachers across a range of disciplines to more easily mine t he published
drug combination literature for promising molecular signatures of synergy or
antagonism which can be validated in retrospective patient data and prioritized
for prospective clinical trails.

# Contents

* [1 Synergy/Antagonism Biomarker Discovery](#synergyantagonism-biomarker-discovery)
* [2 Mathews Griner](#mathews-griner)
  + [2.1 Reading in Raw Data](#reading-in-raw-data)
  + [2.2 Experimental Design Hypothesis](#experimental-design-hypothesis)
  + [2.3 Handling Undocumented Replicates](#handling-undocumented-replicates)
  + [2.4 Using the `TREDataMapper`](#using-the-tredatamapper)
  + [2.5 Creating a `TreatmentResponseExperiment`](#creating-a-treatmentresponseexperiment)
  + [2.6 Normalizing Treatment Response](#normalizing-treatment-response)
  + [2.7 Fitting Monotherapy Curves](#fitting-monotherapy-curves)
  + [2.8 Joining Monotherapy Curve Fits to Combinations](#joining-monotherapy-curve-fits-to-combinations)
  + [2.9 Compute Synergy Scores](#compute-synergy-scores)
  + [2.10 Visualizing Drug Synergy](#visualizing-drug-synergy)
* [Session Info](#session-info)
* [References](#references)

# 1 Synergy/Antagonism Biomarker Discovery

For a comprehensive introduction to detecting biomarkers of drug synergy or
antagonism with *[CoreGx](https://bioconductor.org/packages/3.22/CoreGx)* and *[PharmacoGx](https://bioconductor.org/packages/3.22/PharmacoGx)*, please see our
[workshop from BioC2022](http://bhklab.ca/bioc2022workshop/articles/PGxWorkshop.html).

# 2 Mathews Griner

The Mathews Griner dataset was generated in a high-throughput drug combination
screening study conducted to explore potential drug synergies and antagonisms
in a panel of 459 compounds combined with the Tyrosine Kinase inhibitor
ibrutinib in cancer cell lines from the activated B-cell like subtype of diffuse
large B-cell lymphoma (Mathews Griner et al. [2014](#ref-mathewsgrinerHighthroughputCombinatorialScreening2014)).
The study uses a 6 x 6 combination matrix design, where each respective drug in
a combination undergoes a 4-fold dilution series over 4 steps, with the last
well left untreated. This can be conceptualized as a drug combination matrix
where the last row and column represent monotherapy experiments for each
compound in the pair. A total of 36 viability measurements were taken via the
CellTitreGlo assay for each drug pair, being comprised of pair-wise
combinations of each dose level in the respective dilution series matrix.

We selected this dataset for our vignette to simplify comparison with the
`SynergyFinder` package, which was previously used to analyze this dataset
(Yadav et al. [2015](#ref-yadavSearchingDrugSynergy2015)).

```
library(PharmacoGx)
library(CoreGx)
library(data.table)
library(ggplot2)
```

## 2.1 Reading in Raw Data

We have included a compressed CSV version of the Mathews Griner dataset
which we curated to have informative compound names. You can read the file
in with your CSV reader of choice.

```
input_file <- system.file("extdata/mathews_griner.csv.tar.gz",
    package="PharmacoGx")
mathews_griner <- fread(input_file)
```

## 2.2 Experimental Design Hypothesis

Before modelling dose-response or treatment synergy/antagonism with *[PharmacoGx](https://bioconductor.org/packages/3.22/PharmacoGx)* we
must first build a `TreatmentResponseExperiment` from our high-throughput
drug combination data. This S4 class was designed to store and analyze high
dimensional treatment response data, such as the dose-response screens in cancer
cell lines which are the subject of this analysis. For a detailed explanation
of the class design, please refer to the
[TreatmentResponseExperiment vignette in CoreGx](http://bhklab.ca/CoreGx/articles/TreatmentResponseExperiment.html).

Due to the highly diverse set of experimental designs used in drug combination
studies, the first step in any drug combination analysis is to generate a
hypothesis about the study design. For the `TreatmentResponseExperiment`,
we must identify which columns in our raw data are required to uniquely
identify every treatment (our rows), sample (our columns) and observation
(our assays). As a starting point we recommend trying treatment identifiers and
their respective doses for rows, sample identifiers for columns, and the union
of these for observations.111 Giving names to columns in your group list will
automatically rename them when the `TreatmentResponseExperiment` gets created!

```
groups <- list(
    rowDataMap=c(
        treatment1id="RowName", treatment2id="ColName",
        treatment1dose="RowConcs", treatment2dose="ColConcs"
    ),
    colDataMap=c("sampleid")
)
groups[["assayMap"]] <- c(groups$rowDataMap, groups$colDataMap)
(groups)
```

```
## $rowDataMap
##   treatment1id   treatment2id treatment1dose treatment2dose
##      "RowName"      "ColName"     "RowConcs"     "ColConcs"
##
## $colDataMap
## [1] "sampleid"
##
## $assayMap
##   treatment1id   treatment2id treatment1dose treatment2dose
##      "RowName"      "ColName"     "RowConcs"     "ColConcs"     "sampleid"
```

## 2.3 Handling Undocumented Replicates

These initial guesses can be insufficient to uniquely identify our
treatments or samples if there are technical or biological replicates in the
data. While some publications are explicit about the presence of such
measurements, others are not and require us to explore the data to identify
them. In general, we recommend undocumented replicates be treated as technical
and used to quantify noise in the assay unless there is a good reason to believe
they are from distinct biological entities.

We can identify undocumented replicates using a “group by” operation. This
operation uses the split-apply-combine strategy (also called Map-Reduce) to
compute some aggregation over subsets of a `data.frame`. A grouping has
undocumented replicates if more than one row is assigned to any group which we
hypothesized to uniquely identify the observations in our data. We check this
below using the `.N` special variable from the *[data.table](https://CRAN.R-project.org/package%3Ddata.table)* package, which
counts the number of instances in each group defined by the columns in `by`.
This operation could also be accomplished with `dplyr` or even base R, though
they may be slower and have less concise syntax.

```
# The := operator modifies a data.table by reference (i.e., without making a copy)
mathews_griner[, tech_rep := seq_len(.N), by=c(groups[["assayMap"]])]
if (max(mathews_griner[["tech_rep"]]) > 1) {
    groups[["colDataMap"]] <- c(groups[["colDataMap"]], "tech_rep")
    groups[["assayMap"]] <- c(groups[["assayMap"]], "tech_rep")
} else {
    # delete the additional column if not needed
    message("No technical replicates in this dataset!")
    mathews_griner[["tech_reps"]] <- NULL
}
```

For the Mathews Griner dataset, we do indeed have undocumented replicates! These
will be treated a technical replicates.

## 2.4 Using the `TREDataMapper`

Once we are confident we know which columns are needed to uniquely
identify our treatments and samples, we can create a `TREDataMapper` using
our raw data and mapping hypothesis. The `TREDataMapper` is a helper class
designed to make creating a `TreatmentResponseExperiment` from diverse drug
combination experimental designs easier for users.222 See the
`TreatmentResponseExperiment` vignette in *[CoreGx](https://bioconductor.org/packages/3.22/CoreGx)* to learn more about the
`TREDataMapper` class.

The `guessMapping` method does the necessary internal work to map additional
columns in your dataset to the appopriate category—treatment metadata,
sample metadata or assay data—and returns the column names for each group
in the “mapped\_columns” list item.

```
(treMapper <- TREDataMapper(rawdata=mathews_griner))
```

```
## <TREDataMapper>
## rawdata: dim(16776, 21)
##      BlockId   Col   Row viability AssayId  Size          RowSid      RowName
##        <int> <int> <int>     <num>   <int> <int>          <char>       <char>
##   1:       1     1     1  14.47499     241     6 NCGC00181170-01 Bendamustine
##   2:       1     2     1  28.67605     241     6 NCGC00181170-01 Bendamustine
##   3:       1     3     1  48.73285     241     6 NCGC00181170-01 Bendamustine
##   13 variables not shown: [RowTarget <char>, ColSid <char>, ColName
##     <char>, ColTarget <char>, RowIC50 <int>, ColIC50 <int>, RowConcs
##     <num>, ColConcs <num>, RowConcUnit <char>, ColConcUnit <char>, ...]
##
rowDataMap:
##   rowIDs:
##   rowMeta:
## colDataMap:
##   colIDs:
##   colMeta:
## assayMap:
## metadataMap: NA
```

We will know we have successfully mapped all of our data if the “unmapped” list
item in our guess has no column names in it. If this is not the case, you
may have to refine your hypothesis to include additional information needed
to uniquely identify each observation in your dataset.333 The metadata item in
the list returned from `guessMapping` captures all columns in our dataset which
only have one unique value. These will be assigned to the `metadata` slot of
the `TreatmentResponseExperiment` to save memory.

```
(guess <- guessMapping(treMapper, groups, subset=TRUE))
```

```
## [CoreGx::guessMapping,LongTableDataMapper-method]
##  Mapping for group rowDataMap: RowName, ColName, RowConcs, ColConcs
```

```
## [CoreGx::guessMapping,LongTableDataMapper-method]
##  Mapping for group colDataMap: sampleid, tech_rep
```

```
## [CoreGx::guessMapping,LongTableDataMapper-method]
##  Mapping for group assayMap: RowName, ColName, RowConcs, ColConcs, sampleid, tech_rep
```

```
## $metadata
## $metadata$id_columns
## [1] NA
##
## $metadata$mapped_columns
## [1] "AssayId"     "Size"        "ColSid"      "ColTarget"   "RowIC50"
## [6] "ColIC50"     "RowConcUnit" "ColConcUnit" "tissueid"
##
##
## $rowDataMap
## $rowDataMap$id_columns
##   treatment1id   treatment2id treatment1dose treatment2dose
##      "RowName"      "ColName"     "RowConcs"     "ColConcs"
##
## $rowDataMap$mapped_columns
## [1] "Col"       "Row"       "RowTarget"
##
##
## $colDataMap
## $colDataMap$id_columns
## [1] "sampleid" "tech_rep"
##
## $colDataMap$mapped_columns
## character(0)
##
##
## $assayMap
## $assayMap$id_columns
##   treatment1id   treatment2id treatment1dose treatment2dose
##      "RowName"      "ColName"     "RowConcs"     "ColConcs"     "sampleid"
##
##     "tech_rep"
##
## $assayMap$mapped_columns
## [1] "BlockId"   "viability" "RowSid"
##
##
## $unmapped
## character(0)
```

Once we have mapped all our columns, we can assign their names to the
`TREDataMapper` object and use it to construct the `TreatmentResponseExperiment`
we will use in downstream dose-response and synergy-antagonism modelling.444 We
need to give names to the `metadataMap` and `assayMap` in the `TREDataMapper`,
since there can be more than one item in each of these slots of a
`TreatmentResponseExperiment`.

```
metadataMap(treMapper) <- list(experiment_metadata=guess$metadata$mapped_columns)
rowDataMap(treMapper) <- guess$rowDataMap
colDataMap(treMapper) <- guess$colDataMap
assayMap(treMapper) <- list(raw=guess$assayMap)
treMapper
```

```
## <TREDataMapper>
## rawdata: dim(16776, 21)
##      BlockId   Col   Row viability AssayId  Size          RowSid      RowName
##        <int> <int> <int>     <num>   <int> <int>          <char>       <char>
##   1:       1     1     1  14.47499     241     6 NCGC00181170-01 Bendamustine
##   2:       1     2     1  28.67605     241     6 NCGC00181170-01 Bendamustine
##   3:       1     3     1  48.73285     241     6 NCGC00181170-01 Bendamustine
##   13 variables not shown: [RowTarget <char>, ColSid <char>, ColName
##     <char>, ColTarget <char>, RowIC50 <int>, ColIC50 <int>, RowConcs
##     <num>, ColConcs <num>, RowConcUnit <char>, ColConcUnit <char>, ...]
##
rowDataMap:
##   rowIDs: RowName, ColName, RowConcs, ColConcs
##   rowMeta: Col, Row, RowTarget
## colDataMap:
##   colIDs: sampleid, tech_rep
##   colMeta:
## assayMap:
##   raw:
##     keys: RowName, ColName, RowConcs, ColConcs, sampleid, tech_rep
##     values: BlockId, viability, RowSid
## metadataMap:
##   experiment_metadata: AssayId, Size, ColSid, ColTarget, RowIC50, ColIC50, RowConcUnit, ColConcUnit, tissueid
```

## 2.5 Creating a `TreatmentResponseExperiment`

*[PharmacoGx](https://bioconductor.org/packages/3.22/PharmacoGx)* includes the `metaConstruct` method to simplify creation of a
`TreatmentResponseExperiment` object. Simply call it on the `TREDataMapper` you
created previously to instantiate the object.

```
(tre <- metaConstruct(treMapper))
```

```
## 2025-10-30 01:42:05 Building assay index...
## 2025-10-30 01:42:05 Joining rowData to assayIndex...
## 2025-10-30 01:42:06 Joining colData to assayIndex...
## 2025-10-30 01:42:06 Joining assays to assayIndex...
## 2025-10-30 01:42:08 Setting assayIndex key...
## 2025-10-30 01:42:09 Building LongTable...
```

```
## <TreatmentResponseExperiment>
##    dim:  16668 2
##    assays(1): raw
##    rownames(16668): (-)-Gossypol:Ibrutinib (PCI-32765):0:0 (-)-Gossypol:Ibrutinib (PCI-32765):0:0.1954 ... methyl jasmonate:Ibrutinib (PCI-32765):2500:12.5 methyl jasmonate:Ibrutinib (PCI-32765):2500:50
##    rowData(7): treatment1id treatment2id treatment1dose ... Col Row RowTarget
##    colnames(2): TMD8:1 TMD8:2
##    colData(2): sampleid tech_rep
##    metadata(1): experiment_metadata
```

## 2.6 Normalizing Treatment Response

The viability measurements in the Mathews Griner data have already been
normalized relative to the time zero control. However, *[PharmacoGx](https://bioconductor.org/packages/3.22/PharmacoGx)* recommends
further normalizing against the untreated control to limit the range
of your viability measurements to be close to [0, 1]. The untreated control
is the well which has only been treated with the drug delivery vehicle (usually
the solvent DMSO) and has thus been allowed to grow over the treatment exposure
time.

To accomplish this for our current dataset, we can use a sub-query where we
select the viability at index (6, 6) of our drug combination matrix. This
well has not been treated with either drug. Dividing by it normalizes the
observed viability in our treatment wells relative to any growth that may
have occured during treatment. We further truncate our viability values at zero,
since any values below this are likely a result of technical
noise in our assay.555 The `.SD` special variable, short for “subset data”, is a
*[data.table](https://CRAN.R-project.org/package%3Ddata.table)* feature that allows you to implement complex sub-queries. It
contains a reference to the table being queried.

```
raw <- tre[["raw"]]
raw[,
    viability := viability / .SD[treatment1dose == 0 & treatment2dose == 0, viability],
    by=c("treatment1id", "treatment2id", "sampleid", "tech_rep")
]
raw[, viability := pmax(0, viability)]  # truncate min viability at 0
tre[["raw"]] <- raw
```

As a sanity check that our normalization was effective, we will look at the
range of our viabiltiy values. In most cases, this should be very close to
[0, 1], since we do not expect treatment with one or more compound to increase
the growth of our cell lines relative to the untreated control.

```
tre[["raw"]][, range(viability)]
```

```
## [1]  0.00000 60.96139
```

Some of our treated viabilties are >60x higher than our control! This is very
unlikely to be a real signal and probably indicates there was an issue
with the viability measurement for our dose 0 x 0 well. To quality control
our results, we will find the treatment combination with this observation
and remove it from downstream analysis. It is essential to perform
regular sanity checks to ensure your data is plausible given the experimental
setup.

```
(bad_treatments <- tre[["raw"]][viability > 2, unique(treatment1id)])
```

```
## [1] "IKK-16"
```

Only a single treatment has a viability measurement higher than twice our
control. We will remove this and leave the remaining values in place, since
we can simply truncate them at viability of 1 to include as many combinations
in our analyses as possible.

```
(tre <- subset(tre, !(treatment1id %in% bad_treatments)))
```

```
## <TreatmentResponseExperiment>
##    dim:  16632 2
##    assays(1): raw
##    rownames(16632): (-)-Gossypol:Ibrutinib (PCI-32765):0:0 (-)-Gossypol:Ibrutinib (PCI-32765):0:0.1954 ... methyl jasmonate:Ibrutinib (PCI-32765):2500:12.5 methyl jasmonate:Ibrutinib (PCI-32765):2500:50
##    rowData(7): treatment1id treatment2id treatment1dose ... Col Row RowTarget
##    colnames(2): TMD8:1 TMD8:2
##    colData(2): sampleid tech_rep
##    metadata(1): experiment_metadata
```

We will inspect the viability range again to ensure the bad data has
been removed.

```
tre[["raw"]][, range(viability)]
```

```
## [1] 0.000000 1.858926
```

The range for viabilities is now much more reasonable, and we can move on
to fitting dose-response curves to our monotherapy measurements.

## 2.7 Fitting Monotherapy Curves

The `endoaggregate` method allows us to extract an assay from our
`TreatmentResponseExperiment`, compute a group by (aggregation) over it,
then assign it back to our `TreatmentResponseExperiment` via a join, all in a
single function call. Since we currently only want to fit curves to the
monotherapy experiments in our drug matrix we will use the `subset` argument to
filter the assay to only monotherapy rows before applying the aggregation.

This method is useful to update existing assays, or to create
new ones. The `assay` argument specifies the assay to aggregate over and the
`target` argument specifies the name of the assay to assign the results to.
If the `target` does not already exist, a new assay will be created otherwise
the specified `target` will be updated. If you exclude this argument, the
`assay` you select automatically becomes the `target`. The `endoaggregate`
method is endomorphic, a class of methods that always return
the same type they are called on. This means that `endoaggregate` always
returns a new `TreatmentResponseExperiment`.

While subsetting out our monotherapy viabilities, we can also summarize
viabilities over our techinical replicates by excluding that column from our
`by` argument. Any additional arguments to `endoaggregate` via `...` are
assumed to be aggregation calls and will be computed for each group
identified in `by` and assigned to `target`. The name given to any argument
in `...` will be the column name for that computation in the resulting
`TreatmentResponseExperiment`.

```
tre_qc <- tre |>
    endoaggregate(
        subset=treatment2dose == 0,  # filter to only monotherapy rows
        assay="raw",
        target="mono_viability",  # create a new assay named mono_viability
        mean_viability=pmin(1, mean(viability)),
        by=c("treatment1id", "treatment1dose", "sampleid")
    )
```

Once we have isolated our monotherapy viabilities, we can once again use
`endoaggregate` to fit our dose-response curves. This time we will use the
`enlist=FALSE` option which allows us to assign intermediate variables
during our aggregation. Pass in an entire code block to `endoggregate`
to use this feature and only the returned list will be assigned to the `target`
assay, with each list item as a column with the corresponding name. To prevent
repeating our curve fit parameters, we will create a new assay for them since
we are now summarizing over dose. This helps ensure we use only as much memory
as is necessary to store the analysis results in our
`TreatmentResponseExperiment`.

```
tre_fit <- tre_qc |>
    endoaggregate(
        {  # the entire code block is evaluated for each group in our group by
            # 1. fit a log logistic curve over the dose range
            fit <- PharmacoGx::logLogisticRegression(treatment1dose, mean_viability,
                viability_as_pct=FALSE)
            # 2. compute curve summary metrics
            ic50 <- PharmacoGx::computeIC50(treatment1dose, Hill_fit=fit)
            aac <- PharmacoGx::computeAUC(treatment1dose, Hill_fit=fit)
            # 3. assemble the results into a list, each item will become a
            #   column in the target assay.
            list(
                HS=fit[["HS"]],
                E_inf = fit[["E_inf"]],
                EC50 = fit[["EC50"]],
                Rsq=as.numeric(unlist(attributes(fit))),
                aac_recomputed=aac,
                ic50_recomputed=ic50
            )
        },
        assay="mono_viability",
        target="mono_profiles",
        enlist=FALSE,  # this option enables the use of a code block for aggregation
        by=c("treatment1id", "sampleid"),
        nthread=2  # parallelize over multiple cores to speed up the computation
    )
```

## 2.8 Joining Monotherapy Curve Fits to Combinations

Since we require the monotherapy curve parameters to calculate dose-response
curve dependent synergy metrics such as Loewe and ZIP, we will add these to a
new drug combination assay to make computing synergy metrics possible within
a single `endoaggregate` call.666 If we don’t name an aggregation in
`endoaggregate` a default name will be inferred from the function name and its
first argument. In this case, the column will be called “mean\_viability”.

```
tre_combo <- tre_fit |>
    endoaggregate(
        assay="raw",
        target="combo_viability",
        mean(viability),
        by=c("treatment1id", "treatment2id", "treatment1dose", "treatment2dose",
            "sampleid")
    )
```

The `mergeAssays` method is a convenient way to perform joins between the
assays of a `TreatmentResponseExperiment` endomorphically. It is equivalent
to extracting the assays from the object, performing a join using the `merge`
command, and assigning back to the assay specified as the `x` argument. This
method accepts all the same parameters as the `data.table::merge` function,
but requires the assays in `x` and `y` be specified as assay names instead of
actual assay tables.777 The endomorphic nature of this operation allows the
result to be piped into additional calls, as demonstrated below.

```
tre_combo <- tre_combo |>
    mergeAssays(
        x="combo_viability",
        y="mono_profiles",
        by=c("treatment1id", "sampleid")
    ) |>
    mergeAssays(
        x="combo_viability",
        y="mono_profiles",
        by.x=c("treatment2id", "sampleid"),
        by.y=c("treatment1id", "sampleid"),
        suffixes=c("_1", "_2")  # add sufixes to duplicate column names
    )
```

The `endoaggregate` method is compatible with standard `data.table` syntax,
since `assays` are implemented internally using this package. As such, we can
use a sub-query (via `.SD`) to pull out the viability measurements for each
individual drug in our combination. This value is needed to compute the
Highest Single Agent and Bliss synergy metrics. We will add these values to
our “combo\_viability” assay so all the synergy metrics can be calculated in
a single step.888 The `endoaggregate` method can also be
used to apply arbitrary functions to the data in an assay. Just specify the
entire assay key to the by argument to compute the function for every row
(*i.e.*, to perform no aggregation or summary of the data).

```
tre_combo <- tre_combo |>
    endoaggregate(
        viability_1=.SD[treatment2dose == 0, mean_viability],
        assay="combo_viability",
        by=c("treatment1id", "treatment1dose", "sampleid")
    ) |>
    endoaggregate(
        viability_2=.SD[treatment1dose == 0, mean_viability],
        assay="combo_viability",
        by=c("treatment1id", "treatment2dose", "sampleid")
    )
```

Now that we have assembled all the requisite information into the
“combo\_viability” assay, we are ready to compute our synergy scores!

## 2.9 Compute Synergy Scores

Drug synergy or antagonism is detected as the deviation in the observerd
treatment response above or below the expected response. Determining the
expected response, however, is non-trivial and several different reference
models have been proposed in the literature for the expected
response to a drug combination. *[PharmacoGx](https://bioconductor.org/packages/3.22/PharmacoGx)* has implemented functions to
calculate the expected response under the Highest Single Agent (HSA),
Loewe Additivity, Zero Interaction Potency (ZIP) and Bliss independence
null models of drug synergy.999 The formula for each of these models is different
when using proportion of response vs proportion of viability. In *[PharmacoGx](https://bioconductor.org/packages/3.22/PharmacoGx)* all
synergy computations assume we are working with proportion viability. If you
instead have response values you can convert them to viabilities by subtracting
the normalized responses from 1 (or 100 if using percentages).

These models are discussed in more detail in our workshop from the 2022
Bioconductor conference, linked at the top of this vignette. Addition resources
to learn about drug synergy models include (Yadav et al. [2015](#ref-yadavSearchingDrugSynergy2015)) for
mathematical definitions of each reference model and
(Vlot et al. [2019](#ref-vlotApplyingSynergyMetrics2019a)) for exploring the assumptions of each
model and how they can affect resulting drug synergy predicitons.

Below we use PharmacoGx to compute the expected response under all four
null reference models of drug synergy.

```
tre_synergy <- tre_combo |>
    endoaggregate(
        assay="combo_viability",
        HSA_ref=PharmacoGx::computeHSA(viability_1, viability_2),
        Bliss_ref=PharmacoGx::computeBliss(viability_1, viability_2),
        Loewe_ref=PharmacoGx::computeLoewe(
            treatment1dose, HS_1=HS_1, EC50_1=EC50_1, E_inf_1=E_inf_1,
            treatment2dose, HS_2=HS_2, EC50_2=EC50_2, E_inf_2=E_inf_2
        ),
        ZIP_ref=computeZIP(
            treatment1dose, HS_1=HS_1, EC50_1=EC50_1, E_inf_1=E_inf_1,
            treatment2dose, HS_2=HS_2, EC50_2=EC50_2, E_inf_2=E_inf_2
        ),
        by=assayKeys(tre_combo, "combo_viability"),
        nthread=2
    )
```

Once we have our null hypotheis for no drug synergy, computing a
synergy score is as simple as taking the difference or the ratio between
the observed drug combination viability and each of our reference models.
We prefer taking the difference, since the resulting value can be interpreted
as the proportion of cell death above or below the expected value for each
model.

```
tre_synergy <- tre_synergy |>
    endoaggregate(
        assay="combo_viability",
        HSA_score=HSA_ref - mean_viability,
        Bliss_score=Bliss_ref - mean_viability,
        Loewe_score=Loewe_ref - mean_viability,
        ZIP_score=ZIP_ref - mean_viability,
        by=assayKeys(tre_synergy, "combo_viability")
    )
```

In addition to standard synergy scores, the ZIP model also provides a more
subtle metric of drug synergy that attempts to quantify shifts in the
relative potency and efficacy of drugs in a combination. This metrics is
referred to as ZIP delta, and is computed from a two-way curve fit for
the expected effect of adding drug 1 to drug 2 and drug 2 to drug 1 for
a pair in combinaton. (Yadav et al. [2015](#ref-yadavSearchingDrugSynergy2015)).

Below we demonstrate how to compute ZIP delta using *[PharmacoGx](https://bioconductor.org/packages/3.22/PharmacoGx)*. We first use
the `estimateProjParams` method to compute the dose-response curve parameters
for the two-way curve fits.

```
tre_zip <- tre_synergy |>
    endoaggregate(
        assay="combo_viability",
        subset=treatment2dose != 0,
        {
            zip_fit <- estimateProjParams(
                dose_to=treatment1dose,
                combo_viability=mean_viability,
                dose_add=unique(treatment2dose),
                EC50_add=unique(EC50_2),
                HS_add=unique(HS_2),
                E_inf_add=unique(E_inf_2)
            )
            setNames(zip_fit, paste0(names(zip_fit), "_2_to_1"))
        },
        enlist=FALSE,
        by=c("treatment1id", "treatment2id", "treatment2dose", "sampleid"),
        nthread=2
    )
tre_zip <- tre_zip |>
    endoaggregate(
        assay="combo_viability",
        subset=treatment1dose != 0,
        {
            zip_fit <- estimateProjParams(
                dose_to=treatment2dose,
                combo_viability=mean_viability,
                dose_add=unique(treatment1dose),
                EC50_add=unique(EC50_1),
                HS_add=unique(HS_1),
                E_inf_add=unique(E_inf_1)
            )
            setNames(zip_fit, paste0(names(zip_fit), "_1_to_2"))
        },
        enlist=FALSE,
        by=c("treatment1id", "treatment2id", "treatment1dose", "sampleid"),
        nthread=2
    )
```

Then we use the `.deltaScore` function to compute the final delta score
using the two-way fit curve parameters from the previous step.

```
tre_zip <- tre_zip |>
    endoaggregate(
        assay="combo_viability",
        ZIP_delta=.deltaScore(
            EC50_1_to_2=EC50_proj_1_to_2, EC50_2_to_1=EC50_proj_2_to_1,
            EC50_1=EC50_1, EC50_2=EC50_2,
            HS_1_to_2=HS_proj_1_to_2, HS_2_to_1=HS_proj_2_to_1,
            HS_1=HS_1, HS_2=HS_2,
            E_inf_1_to_2=E_inf_proj_1_to_2, E_inf_2_to_1=E_inf_proj_2_to_1,
            E_inf_1=E_inf_1, E_inf_2=E_inf_2,
            treatment1dose=treatment1dose, treatment2dose=treatment2dose,
            ZIP=ZIP_ref
        ),
        by=assayKeys(tre_zip, "combo_viability")
    )
```

Now that we have computed synergy scores for all of our drug pairs, we can
visualize our results before moving on to downstream analyses looking for
biomarkers of synergy and antagonism.

## 2.10 Visualizing Drug Synergy

Since the Loewe and ZIP synergy metrics require fitting dose-response curves,
it is possible that bad fits could yield misleading synergy scores. Given
this fact, we recommend applying a curve fit quality filter before continuing
with downstream analysis. Below we require curves to obtain an R-squared greater
than 0.5 (that is, >50% variance of the data explained by the fit) before
ranking treatment pairs by their synergy score. If you are ranking using
HSA or Bliss, such a filter is not required, as these two metrics use
only the observed monotherapy viabilities to calculate the expected viability.

The following code filters to only high quality curve fits and then finds
the 15 most synergistic treatment pairs based on their ZIP delta score.

```
combo_viab <- tre_zip[["combo_viability"]]
(top_15_combo <- combo_viab[
    Rsq_1 > 0.5 & Rsqr_1_to_2 > 0.5 & Rsqr_2_to_1 > 0.5,
    .(
        max_delta=max(ZIP_delta, na.rm=TRUE),
        mean_delta=mean(ZIP_delta, na.rm=TRUE),
        max_bliss=max(Bliss_score, na.rm=TRUE),
        mean_bliss=mean(Bliss_score, na.rm=TRUE)
    ),
    by=.(treatment1id, treatment2id, sampleid)
][
    order(-max_delta),
    unique(.SD)
][1:15])
```

Before visualizing drug synergy, we recommend filling in any NA synergy scores
to avoid gaps in the produced plots. This can be easily accomplished using
the `data.table::setnafill` function with the last observation carried forward
strategy.

```
top_15_combo_df <- combo_viab[top_15_combo, on=c('treatment1id', 'treatment2id', 'sampleid')]
# Last observation carried forward for NA/NaN delta scores, to make plot look nicer
setnafill(top_15_combo_df, type="locf", cols="ZIP_delta")
```

The `ggplot2` package can be used to visualize the synergy scores for our
top 15 most synergistic treatment pairs. Below we provide example code to
produce both a contour plot (synergy surface) as well as a heat map to gain
a more inuitive understanding of how synergy or antagonism changes over the
full dose range of each drug combination matrix.

```
top_15_combo_df |>
    ggplot(aes(x=treatment1dose, y=treatment2dose, z=ZIP_delta * 100)) +
    scale_x_log10(oob=scales::squish_infinite) +
    scale_y_log10(oob=scales::squish_infinite) +
    geom_contour_filled(
        breaks=c(-100, -80, -40, -20, -10, -1, 1, 10, 20, 40, 80, 100)
    ) +
    facet_wrap(~ treatment1id, nrow=3, ncol=5) +
    scale_fill_brewer(palette="RdBu", direction=-1, drop=FALSE)
```

```
top_15_combo_df |>
    ggplot(aes(x=factor(treatment1dose), y=factor(treatment2dose))) +
    geom_tile(aes(fill=ZIP_delta * 100)) +
    facet_wrap(~treatment1id, nrow=3, ncol=5) +
    scale_fill_gradient2(low="blue", mid="white", high="red", midpoint=0)
```

To learn how to use synergy scores for biomarker discovery please review
our workshop from Bioconductor 2022, linked in the first section of this
document.

# Session Info

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
##  [1] ggplot2_4.0.0               data.table_1.17.8
##  [3] PharmacoGx_3.14.0           CoreGx_2.14.0
##  [5] SummarizedExperiment_1.40.0 Biobase_2.70.0
##  [7] GenomicRanges_1.62.0        Seqinfo_1.0.0
##  [9] IRanges_2.44.0              S4Vectors_0.48.0
## [11] MatrixGenerics_1.22.0       matrixStats_1.5.0
## [13] BiocGenerics_0.56.0         generics_0.1.4
## [15] knitcitations_1.0.12        knitr_1.50
## [17] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##   [1] bitops_1.0-9                rlang_1.1.6
##   [3] magrittr_2.0.4              shinydashboard_0.7.3
##   [5] otel_0.2.0                  compiler_4.5.1
##   [7] reshape2_1.4.4              vctrs_0.6.5
##   [9] relations_0.6-15            stringr_1.5.2
##  [11] pkgconfig_2.0.3             crayon_1.5.3
##  [13] fastmap_1.2.0               backports_1.5.0
##  [15] XVector_0.50.0              caTools_1.18.3
##  [17] promises_1.4.0              rmarkdown_2.30
##  [19] coop_0.6-3                  xfun_0.53
##  [21] MultiAssayExperiment_1.36.0 cachem_1.1.0
##  [23] jsonlite_2.0.0              RefManageR_1.4.0
##  [25] SnowballC_0.7.1             later_1.4.4
##  [27] DelayedArray_0.36.0         BiocParallel_1.44.0
##  [29] parallel_4.5.1              sets_1.0-25
##  [31] cluster_2.1.8.1             R6_2.6.1
##  [33] bslib_0.9.0                 stringi_1.8.7
##  [35] RColorBrewer_1.1-3          limma_3.66.0
##  [37] boot_1.3-32                 lubridate_1.9.4
##  [39] jquerylib_0.1.4             Rcpp_1.1.0
##  [41] bookdown_0.45               R.utils_2.13.0
##  [43] downloader_0.4.1            BiocBaseUtils_1.12.0
##  [45] httpuv_1.6.16               Matrix_1.7-4
##  [47] igraph_2.2.1                timechange_0.3.0
##  [49] tidyselect_1.2.1            dichromat_2.0-0.1
##  [51] abind_1.4-8                 yaml_2.3.10
##  [53] gplots_3.2.0                codetools_0.2-20
##  [55] lattice_0.22-7              tibble_3.3.0
##  [57] plyr_1.8.9                  withr_3.0.2
##  [59] shiny_1.11.1                BumpyMatrix_1.18.0
##  [61] S7_0.2.0                    evaluate_1.0.5
##  [63] bench_1.1.4                 xml2_1.4.1
##  [65] pillar_1.11.1               lsa_0.73.3
##  [67] BiocManager_1.30.26         KernSmooth_2.23-26
##  [69] checkmate_2.3.3             DT_0.34.0
##  [71] shinyjs_2.1.0               piano_2.26.0
##  [73] scales_1.4.0                gtools_3.9.5
##  [75] xtable_1.8-4                marray_1.88.0
##  [77] glue_1.8.0                  slam_0.1-55
##  [79] tools_4.5.1                 fgsea_1.36.0
##  [81] visNetwork_2.1.4            fastmatch_1.1-6
##  [83] cowplot_1.2.0               grid_4.5.1
##  [85] bibtex_0.5.1                cli_3.6.5
##  [87] S4Arrays_1.10.0             dplyr_1.1.4
##  [89] gtable_0.3.6                R.methodsS3_1.8.2
##  [91] sass_0.4.10                 digest_0.6.37
##  [93] SparseArray_1.10.0          htmlwidgets_1.6.4
##  [95] farver_2.1.2                R.oo_1.27.1
##  [97] htmltools_0.5.8.1           lifecycle_1.0.4
##  [99] httr_1.4.7                  statmod_1.5.1
## [101] mime_0.13
```

# References

Mathews Griner, Lesley A., Rajarshi Guha, Paul Shinn, Ryan M. Young, Jonathan M. Keller, Dongbo Liu, Ian S. Goldlust, et al. 2014. “High-Throughput Combinatorial Screening Identifies Drugs That Cooperate with Ibrutinib to Kill Activated B-celllike Diffuse Large B-cell Lymphoma Cells.” *Proceedings of the National Academy of Sciences* 111 (6): 2349–54. <https://doi.org/10.1073/pnas.1311846111>.

Vlot, Anna H. C., Natália Aniceto, Michael P. Menden, Gudrun Ulrich-Merzenich, and Andreas Bender. 2019. “Applying Synergy Metrics to Combination Screening Data: Agreements, Disagreements and Pitfalls.” *Drug Discovery Today* 24 (12): 2286–98. <https://doi.org/10.1016/j.drudis.2019.09.002>.

Yadav, Bhagwan, Krister Wennerberg, Tero Aittokallio, and Jing Tang. 2015. “Searching for Drug Synergy in Complex DoseResponse Landscapes Using an Interaction Potency Model.” *Computational and Structural Biotechnology Journal* 13 (January): 504–13. <https://doi.org/10.1016/j.csbj.2015.09.001>.