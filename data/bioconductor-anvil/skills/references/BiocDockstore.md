# *Dockstore* and *Bioconductor* for AnVIL

BJ Stubbs, S Gopaulakrishnan, Nitesh Truaga, Martin Morgan and Vincent Carey\*

\*stvjc@channing.harvard.edu

#### 5 February 2026

#### Package

AnVIL 1.22.5

# Contents

* [1 Introduction: Basic concepts of *Dockstore* and *Bioconductor*](#introduction-basic-concepts-of-dockstore-and-bioconductor)
* [2 Working with the *Dockstore* API in *Bioconductor*](#working-with-the-dockstore-api-in-bioconductor)
* [3 Appendix](#appendix)
  + [Acknowledgments](#acknowledgments)
  + [Session info](#session-info)

# 1 Introduction: Basic concepts of *Dockstore* and *Bioconductor*

*Dockstore* is the “VM/Docker sharing infrastructure and management
component” of the Global Alliance for Genomics and Health (GA4GH).
Dockstore.org implements the infrastructure by defining APIs for
coupling Docker images with formalized workflow specifications. The
application of this concept to the PanCancer Analysis of Whole Genomes
(PCAWG) is described in a [2017 paper](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5333608/) by O’Connor and
colleagues.

[Bioconductor](https://bioconductor.org) is a software ecosystem based in the R language for
the analysis and comprehension of genome-scale experiments. [An
overview][] was published in 2015.

*Bioconductor* implemented a [“common workflow”](https://www.bioconductor.org/packages/release/BiocViews.html#___Workflow) concept a
number of years ago. (The term “common” is used on the *Bioconductor*
landing page, to indicate that many bioinformaticians would be
expected to engage with tasks reviewed in these workflows. The
“common workflow” phrase is not intended to indicate a relationship to
CWL, the “common workflow language” standard.)

In *Bioconductor* parlance, a “common workflow” is an R package
accompanied by a markdown or Sweave vignette that narrates and
executes the workflow tasks using R. Any sufficiently endowed
deployment of R on a sufficient computing platform will run the
workflow tasks to completion; this assertion is checked on a regular
basis through *Bioconductor*’s continuous integration system. When the
assertion fails, the workflow maintainer is alerted and corrections
are made.

Advantages to marrying the *Bioconductor* workflow concept with
*Dockstore* VM/Docker/workflow infrastructure include

* Reduction in user burden of configuring and maintaining the
  execution platform
* Utilization of parameterized formal workflow specification in CWL,
  WDL, or Nextflow
* General advantages to users of fostering participation in GA4GH best
  practices related to reproducibility and transparency

Open questions concern the balance between specification of workflow
steps in R and in the formal workflow language. *Bioconductor*
workflows can be written to take advantage of R’s capabilities to
drive computations on potentially heterogeneous clusters with
programmable fault tolerance and job control. The particular
advantages of CWL/WDL/Nextflow and other aspects of the *Dockstore*
ecosystem need to be experienced, measured, and documented to help
developers establish the appropriate balance between programming R and
programming an exogenous workflow environment.

# 2 Working with the *Dockstore* API in *Bioconductor*

The [AnVIL](https://github.com/Bioconductor/AnVIL) package handles basic aspects of authentication and API
element cataloguing for the AnVIL project.

```
library(AnVIL)
library(dplyr)
```

Create an object ‘dockstore’ representing the service and to be
used to process API requests.

```
dockstore <- Dockstore()
```

Groups of API components are obtained via `tags()`.

```
knitr::kable(tags(dockstore) %>% count(tag))
```

We’re interested in the ‘users’ component. Higher level methods will
be introduced to help here, but for now we stick to base R methods.

```
tags(dockstore, "users") %>% print(n = Inf)
```

We can use the following to determine our user identifier.

```
myuid <- dockstore$getUser() %>%
    as.list() %>%
    pull("id")
```

# 3 Appendix

## Acknowledgments

Research reported in this software package was supported by the US
National Human Genomics Research Institute of the National Institutes
of Health under award number [U24HG010263](https://projectreporter.nih.gov/project_info_description.cfm?aid=9789931&icde=49694078). The content is solely
the responsibility of the authors and does not necessarily represent
the official views of the National Institutes of Health.

## Session info