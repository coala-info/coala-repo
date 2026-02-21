# Introduction to ExperimentHubData

Valerie Obenchain

#### Modified: November 2017. Compiled: 29 Oct 2025

# Contents

* [1 Overview](#overview)
* [2 Creating an ExperimentHub Package or Converting to an ExperimentHub Package](#creating-an-experimenthub-package-or-converting-to-an-experimenthub-package)
* [3 `ExperimentHub_docker`](#experimenthub_docker)

# 1 Overview

`ExperimentHubData` provides tools to add or modify resources in
Bioconductor’s `ExperimentHub`. This ‘hub’ houses curated data from courses,
publications or experiments. The resources are generally not files of raw data
(as can be the case in `AnnotationHub`) but instead are `R` / `Bioconductor`
objects such as GRanges, SummarizedExperiment, data.frame etc. Each resource
has associated metadata that can be searched through the `ExperimentHub` client interface.

# 2 Creating an ExperimentHub Package or Converting to an ExperimentHub Package

Please see HubPub Vignette “CreateAHubPackage”.

```
vignette("CreateAHubPackage", package="HubPub")
```

# 3 `ExperimentHub_docker`

The [ExperimentHub\_docker](https://github.com/Bioconductor/ExperimentHub_docker)
offers an isolated test environment for inserting / extracting metadata records
in the `ExperimentHub` database. The README in the package explains how to
set up the Docker and inserting records is done with
`ExperimentHub::addResources()`.

In general this level of testing should not be necessary when submitting
a package with new resources. The best way to validate record metadata is to
read inst/extdata/metadata.csv with `ExperimentHubData::makeExperimentHubMetadata()`.
If that is successful the metadata are ready to go.