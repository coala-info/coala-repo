# GladiaTOX: R Package for Processing High Content Screening data

Vincenzo Belcastro, Stephane Cano and Florian Martin

#### 30 October 2025

#### Package

GladiaTOX 1.26.0

# Contents

* [1 Introduction](#introduction)
  + [1.1 Installation and package load](#installation-and-package-load)
  + [1.2 Database configuration](#database-configuration)
  + [1.3 Deployed database](#deployed-database)
* [2 Data and metadata for vignette](#data-and-metadata-for-vignette)
  + [2.1 `plate`: plate metadata](#plate-plate-metadata)
  + [2.2 `chnmap`: assay metadata and channel mapping](#chnmap-assay-metadata-and-channel-mapping)
  + [2.3 `dat`: image quantification raw data](#dat-image-quantification-raw-data)
* [3 Database loading](#database-loading)
  + [3.1 Register study info in database](#register-study-info-in-database)
  + [3.2 Load raw data in database](#load-raw-data-in-database)
* [4 Quality control: data processing and reporting](#quality-control-data-processing-and-reporting)
  + [4.1 Compute the noise band](#compute-the-noise-band)
  + [4.2 Quality control report](#quality-control-report)
    - [4.2.1 Data masking](#data-masking)
* [5 Data processing and reporting](#data-processing-and-reporting)
  + [5.1 Process data](#process-data)
  + [5.2 Data reporting](#data-reporting)
* [6 Additional reporting plots](#additional-reporting-plots)
* [7 Session Info](#session-info)

# 1 Introduction

`GladiaTOX` is an open-source solution for HCS data processing and reporting
that expands the `tcpl` package (toxcast pipeline, *Filer et al., 2016*). In
addition to `tcpl`’s functionalities (multiple dose-response fitting and best
fit selection), `GladiaTOX`

* Fetches raw image quantifications via a webservice layer, also allowing
  multiple (proprietary) systems to be integrated easily
* Computes minimal effective concentrations based also on historical data
* Exports results formatted for ToxPI GUI
* Compute exposure severity scores
* Implements a suite of functionalities for quality control and processing
  reporting

## 1.1 Installation and package load

```
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("GladiaTOX")
```

```
#> Warning: Using `size` aesthetic for lines was deprecated in ggplot2 3.4.0.
#> ℹ Please use `linewidth` instead.
#> ℹ The deprecated feature was likely used in the GladiaTOX package.
#>   Please report the issue to the authors.
#> This warning is displayed once every 8 hours.
#> Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
#> generated.
```

![](data:image/png;base64...)

## 1.2 Database configuration

The `GladiaTOX` installation includes the deployment of a sqlite database
(`sql/gladiatoxdb.sqlite` folder). This file contains the database structure
already initialized with the necessary content needed for data processing (e.g.
processing methods entries).

The first step after database deployment is to configure access parameters.
The default configuration already points to the sqlite database at so no
additional configurations are needed to complete the example below.
Below the default database URL is assigned to the variable `sqlite_src`:

```
sqlite_src <- file.path(system.file(package="GladiaTOX"), "sql",
                        "gladiatoxdb.sqlite")
```

The `gtoxConf` configuration command below initializes all necessary variables.

```
# sqlite database location
gtoxConf(   drvr = "SQLite",
            host = NA,
            user = NA,
            pass = NULL,
            db = sqlite_src)
```

This database will be used in next sections to load and process a second study
phase. The sqlite database can be seen as a sample database used for the
following example.

In case users plan to use the package in production and for multiple studies,
it is recommended to install the MariaDB database
(`sql/gladiatoxdb_structure.mysql`). This file contains SQL instructions to
create and initialize an MariaDB database.

In case you install the database schema or change location of the sqlite
database, then you must run the configuration command below and point to the
new database location. For example, in case you deploy the database schema
provided in the sql folder, then change the driver (`drvr`) to `MariaDB`.
Eventually you may need to configure your user name and password.

Below is an example of configuration call pointing to an MariaDB database called
`my_gl_database` at `local.host`:

```
gtoxConf(   drvr = "MariaDB",
            host = "local.host",
            user = "username",
            pass = "********",
            db = "my_gl_database")
```

## 1.3 Deployed database

The deployed database already contains fully processed study, with

* `asid`: 1 (assay source id), the unique study identifier
* `asnm`: SampleStudy (assay source name), the names of the study
* `asph`: PhaseI (assay source phase), the study phase

The purpose of the call `gtoxLoadAsid()` is to list all studies available in the
database.

```
# List available studies
gtoxLoadAsid()
#>     asid        asnm   asph
#>    <int>      <char> <char>
#> 1:     1 SampleStudy PhaseI
```

# 2 Data and metadata for vignette

In this section we will explore one simple way for loading data in the
database. The following chunks prepare the metadata and data in R objects
(data.frame) prior database loading.

The following commands loads the data for vignette. The command loads three
objects in the environment. The content of each object is described in the
following sections. These objects are what users need to prepare before study
data can be loaded. In particular the `dat` object contains the raw data as
fetched from the instrument database. This database is only accessible
internally to the company, hence its content has been exported and saved in an
Rdat object . Some fields, not used by the code, are not reported.

```
load(system.file("extdata", "data_for_vignette.rda", package="GladiaTOX"))
```

## 2.1 `plate`: plate metadata

The `plate` object stores metadata with plate information.

Most of the columns have self-contained names and content; `plate` is the plate
number (usually an integer); `tube` is the well location (H1 is row 8 column 1);
`well_type` is the content type of the well (`c` positive control, `t`
treatment, `n` is the negative control); `endpoint` contains assay names with no
exposure duration info appended; `u_boxtrack` is a plate identifier used to join
the `plate` metadata table with the raw data table prior data is loaded in the
GladiaTOX database.

```
print(head(plate), row.names = FALSE)
#>     stimulus stimulus concentration exposure duration plate tube well_type
#>  o-anisidine               10000 uM               24h     1   A1         t
#>  o-anisidine                5000 uM               24h     1   B1         t
#>  o-anisidine                1000 uM               24h     1   C1         t
#>  o-anisidine                 200 uM               24h     1   D1         t
#>  o-anisidine             0.00007 uM               24h     1   E1         t
#>  o-anisidine           0.0000006 uM               24h     1   F1         t
#>  vehicle_name       study study.phase cell type    endpoint exposure date
#>          EtOH SampleStudy     PhaseII      NHBE GSH content    2014-06-17
#>          EtOH SampleStudy     PhaseII      NHBE GSH content    2014-06-17
#>          EtOH SampleStudy     PhaseII      NHBE GSH content    2014-06-17
#>          EtOH SampleStudy     PhaseII      NHBE GSH content    2014-06-17
#>          EtOH SampleStudy     PhaseII      NHBE GSH content    2014-06-17
#>          EtOH SampleStudy     PhaseII      NHBE GSH content    2014-06-17
#>  plate_set Biological Replicate smkid well format           assay       Date
#>          0                    1           96-well GSH content_24h 2014-03-17
#>          0                    1           96-well GSH content_24h 2014-03-17
#>          0                    1           96-well GSH content_24h 2014-03-17
#>          0                    1           96-well GSH content_24h 2014-03-17
#>          0                    1           96-well GSH content_24h 2014-03-17
#>          0                    1           96-well GSH content_24h 2014-03-17
#>   u_boxtrack
#>  S-000031334
#>  S-000031334
#>  S-000031334
#>  S-000031334
#>  S-000031334
#>  S-000031334
```

## 2.2 `chnmap`: assay metadata and channel mapping

The second metadata table contains assay mapping information. In the example
below two assays are shown: *Cytotoxicity (TIER1)* and *DNA damage (pH2AX)*.

Five endpoints are part of the cytotoxicity assay (e.g., *Cell count*,
*membranepermeability*). Two endpoints are shown to be part of the DNA damage
assay. Since multiple endpoints can be read from the same plate, each of them is
read on a separate channel. This column will also be used later on to join
meatadata and data tables.

```
print(head(chnmap, 7), row.names = FALSE)
#>                 Assay                         Endpoint
#>  Cytotoxicity (TIER1)                       Cell count
#>  Cytotoxicity (TIER1)       Cell membrane permeability
#>  Cytotoxicity (TIER1) Mitochondrial membrane potential
#>  Cytotoxicity (TIER1)               Mitochondrial mass
#>  Cytotoxicity (TIER1)             Cytochrome C release
#>    DNA damage (pH2AX)                       Cell count
#>    DNA damage (pH2AX)               DNA damage (pH2AX)
#>                           Channel
#>  SelectedObjectCountPerValidField
#>              MEAN_CircAvgIntenCh2
#>          MEAN_RingSpotAvgIntenCh3
#>         MEAN_RingSpotTotalAreaCh3
#>              MEAN_CircAvgIntenCh4
#>  SelectedObjectCountPerValidField
#>              MEAN_CircAvgIntenCh2
```

The content of `plate` and `chnmap` are then combined to generate the assay
table. In the assay table, assay and endpoint are concatenated to timepoints
to generate assays entries for the database.

```
assay <- buildAssayTab(plate, chnmap)
print(head(assay, 4), row.names = FALSE)
#>                assay timepoint                            component
#>   Ox stress (DHE)_4h        4h  Ox stress (DHE)_Oxidative stress_4h
#>   Ox stress (DHE)_4h        4h  Ox stress (DHE)_Oxidative stress_4h
#>  Ox stress (DHE)_24h       24h Ox stress (DHE)_Oxidative stress_24h
#>  Ox stress (DHE)_24h       24h Ox stress (DHE)_Oxidative stress_24h
#>                                 endpoint              channel
#>   Ox stress (DHE)_Oxidative stress_4h_up MEAN_CircAvgIntenCh2
#>   Ox stress (DHE)_Oxidative stress_4h_dn MEAN_CircAvgIntenCh2
#>  Ox stress (DHE)_Oxidative stress_24h_up MEAN_CircAvgIntenCh2
#>  Ox stress (DHE)_Oxidative stress_24h_dn MEAN_CircAvgIntenCh2
```

## 2.3 `dat`: image quantification raw data

The data table is an export from the image quantification instrument.

This table contains the raw fluorescence quantification values: `measure_val`;
`rowi` and `coli` are the row and column indexes; `machine_name` is the channel
name and is used to join this table with the assay table above; `u_boxtrack`
is the plate identified and is used to join the table with the plate table.

```
print(head(dat), row.names = FALSE)
#>  measure_val  rowi  coli                     machine_name  u_boxtrack
#>        <num> <num> <num>                           <fctr>      <char>
#>       134.15     1     1 SelectedObjectCountPerValidField S-000031358
#>       118.50     1     2 SelectedObjectCountPerValidField S-000031358
#>       139.05     1     3 SelectedObjectCountPerValidField S-000031358
#>       214.50     1     4 SelectedObjectCountPerValidField S-000031358
#>       226.55     1     5 SelectedObjectCountPerValidField S-000031358
#>       229.75     1     6 SelectedObjectCountPerValidField S-000031358
```

# 3 Database loading

In this sections data and metadata will be loaded in the GladiaTOX database.
Let’s set the study parameters, study name and phase of the new study phase to
be loaded in the database and processed.

```
## Set study parameters
std.nm <- "SampleStudy" # study name
phs.nm <- "PhaseII" # study phase
```

## 3.1 Register study info in database

The following code will register metadata file content in the database,
including: assays, endpoints, treatments and controls. The status of the assay
source table (study table) before and after new study creation is displayed
below calling `gtoxLoadAsid()`. The purpose of the call is to list all studies
available in the database before and after the new study is added with the
function `loadAnnot()`.

```
## List of studies before loading
gtoxLoadAsid()
#>     asid        asnm   asph
#>    <int>      <char> <char>
#> 1:     1 SampleStudy PhaseI

## Load annotation in gtoxDB
loadAnnot(plate, assay, NULL)
#> [1] TRUE

## List of studies after loading
gtoxLoadAsid()
#>     asid        asnm    asph
#>    <int>      <char>  <char>
#> 1:     1 SampleStudy  PhaseI
#> 2:     2 SampleStudy PhaseII
```

The `loadAnnot` function call registers multiple study parameters in the
database, including the creation of the new assay source id (asid). The asid
identifies the pair study name, study phase. The asid is what will be used to
load raw data of the study, process the study and generate reports.

## 3.2 Load raw data in database

The `asid` just created can be retrieved by querying the database and specify
the study name and phase.

```
# Get assay source ID
asid = gtoxLoadAsid(fld = c("asnm", "asph"), val = list(std.nm, phs.nm))$asid
asid
#> [1] 2
```

The `asid` and the `dat` objects are the inputs to the `prepareDatForDB`
function used to join metadata stored in database to the raw data stored in
the `dat` object.

Raw data is then loaded in the database with the `gtoxWriteData` function.
Study whose `asid` is `2` is now ready to be processed.

```
# Prepare and load data
dat <- prepareDatForDB(asid, dat)
gtoxWriteData(dat[ , list(acid, waid, wllq, rval)], lvl = 0, type = "mc")
#> Completed delete cascade for 34 ids (0.06 secs)
#> [1] TRUE
```

# 4 Quality control: data processing and reporting

Metadata and data are now registered in the database. Next step is to select
the processing methods we want to apply on the data. There are multiple levels
of processing (see `gtoxLoadMthd(lvl=3)` for details). The function
`assignDefaultMthds` is a shortcut to assign all levels methods at once. The
methods selected would probably fit well to most users.

```
assignDefaultMthds(asid = asid)
#> [1] TRUE
```

With the default selection, raw data is normalized by computing the log2 fold
change of values in each well against the median of the corresponding controls.

## 4.1 Compute the noise band

The package computes a noise band to discriminate concentration series that are
active versus those that are not. To compute the noise band we need to process
and normalize vehicle’s data running the following code:

```
# Run level 1 to level 3 functions
res <- gtoxRun(asid = asid, slvl = 1, elvl = 3, mc.cores = 2)
```

The default behaviour is to compute noise band margins separately for each
endpoint. Margins correspond to 3 times the baseline median absolute deviation
of vehicle responses. The following code computes the cutoffs and store them in
the database.

```
# Extract assay endpoints ids of the study
aeids <- gtoxLoadAeid(fld = "asid", val = asid)$aeid
# Compute Vehicle Median Absolute deviation
tmp <- mapply(function(xx){
    tryCatch(gtoxCalcVmad(inputs = xx, aeid = xx,
    notes = "computed within study"),
    error = function(e) NULL)},
    as.integer(aeids))
```

Once the database is populated with noise band margins, then all chemical’s data
can be processed.

```
# Apply all functions from level 1 to level 6
res <- gtoxRun(asid = asid, slvl = 1, elvl = 6, mc.cores = 2)
```

In the original work (*Filer et al., 2016*), the default behaviour is to compute
noise band margins based on the response of the lowest two concentrations of the
series. That assumes that no response is observed at those concentrations. The
current package overcome that assumption and extend the list of functionalities.
The database design was modified accordingly.

## 4.2 Quality control report

Quality control is the mean to check the quality of the data produced in the
lab. Each experimental plate is controlled. Plates not passing the control step
are filtered out. Quality control is commonly based on a visual inspection. The
package exposes functionalities to generate a self contained pdf file with plate
heatmaps and positive control plots.

```
## QC report
gtoxReport(type = "qc", asid = asid, report_author = "report author",
report_title = "Vignette QC report", odir = outdir)
```

An example of plate heatmap is shown below, and is what included in the quality
control pdf report. The following code is used to extract the plate id we want
to plot.

```
# Define assay component and extract assay component ID
acnm <- "DNA damage (pH2AX)_DNA damage (pH2AX)_4h"
acid <- gtoxLoadAcid(fld=c("asid", "acnm"), val=list(asid,acnm))[, acid]
# Extract assay plate ID corresponding to plate name S-000031351
apid <- gtoxLoadApid()[u_boxtrack == "S-000031351", apid]
# Load level 2 data (Raw data before normalization)
l2 <- gtoxLoadData(lvl = 2L, fld = "acid", val = acid)
```

The plate heatmap is performed with the folliwing code.

```
gtoxPlotPlate(dat = l2, apid = apid, id = acid)
```

![Example of heatmap of a plate raw values. Letters in well indicate the well type.](data:image/png;base64...)

Figure 1: Example of heatmap of a plate raw values
Letters in well indicate the well type.

The QC report includes also dose-responses for positive control chemicals as in
figure. For that we need to first extract level 4 data.

```
# Extract assay endpoint ID
aeid <- gtoxLoadAeid(fld = c("acid", "analysis_direction"),
                        val = list(acid, "up"))[, aeid]
# Extract sample ID
spid <- gtoxLoadWaid(fld = c("apid", "wllt"),
                        val = list(apid, "c"))[,unique(spid)]
# Collect level 4 data (normalized data)
m4id <- gtoxLoadData(lvl = 4L, fld = c("spid", "aeid"),
                        val = list(spid, aeid))[, m4id]
```

Then we can plot the normalized data corresponding to the selected sample ID.

```
gtoxPlotM4ID(m4id = m4id, lvl = 6, bline = "coff")
```

![Example of Positive control (chlorambucil chemical) plot with three concentrations, and three technical replicates per concentration.](data:image/png;base64...)

Figure 2: Example of Positive control (chlorambucil chemical) plot with three concentrations, and three technical replicates per concentration

The panel on the right side shows a set of information including goodness of
fit. In this particular example no info is available since the series has to few
concentration to fit a model (4 concentrations is the minimum number to perform
a fit).

### 4.2.1 Data masking

QC report is mainly used to check the quality of the plates. For example, in
case the response of a positive control of an assay stays within the noiseband,
then the user may decide to filter that plate out. Below is shown the code to
mask plate *S-000030318*.

```
apid <- gtoxLoadApid()[u_boxtrack%in%"S-000030318", apid] # plate id
waids <- gtoxLoadWaid(fld="apid", val=apid)$waid #well ids
m0ids <- gtoxLoadData(lvl = 0, fld = "waid", val = waids)$m0id # raw data ids
gtoxSetWllq(ids = m0ids, wllq = 0, type = "mc") # set well quality to zero
#> Completed delete cascade for 7 ids (0.13 secs)
#> [1] TRUE
```

The masked plate will not be processed and will not be included in the final
report.

# 5 Data processing and reporting

## 5.1 Process data

Now that the user has selected the processing methods, cutoffs computed, and bad
quality plates masked, all information is in place to start processing the data
with the following command.

```
res <- gtoxRun(asid = asid, slvl = 1, elvl = 6, mc.cores = 2)
```

The `gtoxRun` returns a list of vectors of logical values used to check
processing status. The resulting processed data is automatically stored in the
database along with the statistics computed. Statistics include activity
concentrations (AC10 and AC50) and minimal effective concentrations (MECs).

## 5.2 Data reporting

The `gtoxReport` function, with option `type = "all"`, triggers the generation
of the full processing report. The pdf file created includes summary tables,
dose-response curves (as seen later), and other plots for all chemicals tested
in the study.

```
## Processing report
gtoxReport(type = "all", asid = asid, report_author = "report author",
report_title = "Vignette Processing report", odir = outdir)
```

Models that best fit the data are also included in the final report. In order to
select the best fitting the package evaluate three models: constant, hill and
gain-loss. Below is shown an example where all models are fit to the data
(ochre, red and blue) from a single plate.

```
## Endpoint to plot
aeids <- gtoxLoadAeid(fld=c("asid", "aenm"),
val=list(asid, "DNA damage (pH2AX)_DNA damage (pH2AX)_24h_up"),
add.fld="asid")$aeid
## level 4 id to plot
m4id <- gtoxLoadData(lvl=4L)[(aeid==aeids & grepl("chromium", spid))]$m4id[1]
```

```
gtoxPlotM4ID(m4id = m4id, lvl = 6, bline = "coff")
```

![Best fit selection.](data:image/png;base64...)

Figure 3: Best fit selection

The HILL model (marked in red on the right panel) will be selected as best fit
since minimizing the Akaike information criteria (AIC).

All winning models are combined into a single plot that is included in the pdf
report. An example of winning model plot is shown in figure, for the very same
chemical and endpoint used above.

```
## Get chemical id to plot
chid <- gtoxLoadChem(field = "chnm", val = "chromium",
include.spid = FALSE)$chid
#> Warning in sprintf(qformat, val, val): one argument not used by format '
#>         SELECT * FROM
#>         (
#>         SELECT
#>             spid,
#>             chemical.*
#>         FROM chemical
#>         LEFT JOIN sample ON sample.chid = chemical.chid
#>         UNION ALL
#>         SELECT
#>             spid,
#>             chemical.*
#>         FROM sample
#>         LEFT JOIN chemical ON sample.chid = chemical.chid
#>         WHERE  chemical.chid IS NULL
#>         ) AS cs
#>          WHERE chnm IN (%s);'
## Plot dose-response curves
gtoxPlotWin(chid = chid, aeid = aeids, bline = "bmad", collapse = TRUE)
```

![Example of dose-response curves.](data:image/png;base64...)

Figure 4: Example of dose-response curves

The plot shows all replicated dose-response curves. Each curve represents the
fitting result on an experimental plate. Only best fits are reported.

# 6 Additional reporting plots

Additional reporting plots, not included in the full report, can be obtained as
described below. Boxplot of minimal effective concentrations can be obtained
running the following chunk. An example of boxplot is reported below. MEC values
are shown as dots. Low MECs correspond to high toxicity.

```
fname <- paste0(format(Sys.Date(), format="%y%m%d"), "_ASID", asid,"_MEC.pdf")
fname <- file.path(outdir, fname)
pdf(fname, width = 11, height = 7)
glPlotStat(asid)
dev.off()
```

![Example of MEC boxplot.](data:image/png;base64...)

Figure 5: Example of MEC boxplot

The MEC plot shows an example of MEC boxplot. In the example the GSH assay is
shown along with the two endpoints (GSH content and Cell count). Chemicals are
listed in the legend to the right. Each dot in the plot represents an MEC value.

MEC values can also be reported in a piechart. Below an example.

```
chnms <- c("mercury", "o-cresol", "p-cresol")
glPlotPie(asid, chnms = chnms)
```

![Example of pie plots. The figure shows three chemicals and all endpoints.](data:image/png;base64...)

Figure 6: Example of pie plots
The figure shows three chemicals and all endpoints.

The pie plot reports the mean MECs for all endpoints measured in the study. Time
points are reported to the right (4h, 24h). Each slice is associated to an
endpoint. Numbers on the slides indicate the corresponding MEC means.

Severity scores can also be computed and displayed. This score indicate the
average impact of chemicals across multiple endpoints.

```
glPlotToxInd(asid)
```

![Example of severity score plot.](data:image/png;base64...)

Figure 7: Example of severity score plot

Example of severity score plot reporting the full list of chemicals used in the
study; y-axis reports the severity score value (normalized between 0 and 1);
x-axis in just the index of the chemical.

# 7 Session Info

```
sessionInfo()
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
#> [1] RColorBrewer_1.1-3 xtable_1.8-4       GladiaTOX_1.26.0   data.table_1.17.8
#> [5] BiocStyle_2.38.0
#>
#> loaded via a namespace (and not attached):
#>  [1] tidyr_1.3.1         sass_0.4.10         generics_0.1.4
#>  [4] bitops_1.0-9        stringi_1.8.7       RSQLite_2.4.3
#>  [7] hms_1.1.4           digest_0.6.37       magrittr_2.0.4
#> [10] evaluate_1.0.5      grid_4.5.1          bookdown_0.45
#> [13] fastmap_1.2.0       blob_1.2.4          jsonlite_2.0.0
#> [16] ggrepel_0.9.6       DBI_1.2.3           tinytex_0.57
#> [19] BiocManager_1.30.26 purrr_1.1.0         scales_1.4.0
#> [22] brew_1.0-10         XML_3.99-0.19       numDeriv_2016.8-1.1
#> [25] jquerylib_0.1.4     cli_3.6.5           crayon_1.5.3
#> [28] rlang_1.1.6         bit64_4.6.0-1       withr_3.0.2
#> [31] cachem_1.1.0        yaml_2.3.10         parallel_4.5.1
#> [34] tools_4.5.1         RJSONIO_2.0.0       memoise_2.0.1
#> [37] dplyr_1.1.4         ggplot2_4.0.0       RMariaDB_1.3.4
#> [40] vctrs_0.6.5         R6_2.6.1            magick_2.9.0
#> [43] lifecycle_1.0.4     stringr_1.5.2       bit_4.6.0
#> [46] pkgconfig_2.0.3     pillar_1.11.1       bslib_0.9.0
#> [49] gtable_0.3.6        glue_1.8.0          Rcpp_1.1.0
#> [52] xfun_0.53           tibble_3.3.0        tidyselect_1.2.1
#> [55] knitr_1.50          dichromat_2.0-0.1   farver_2.1.2
#> [58] htmltools_0.5.8.1   labeling_0.4.3      rmarkdown_2.30
#> [61] compiler_4.5.1      S7_0.2.0            RCurl_1.98-1.17
```