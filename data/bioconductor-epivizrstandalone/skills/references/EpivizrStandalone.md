# Introduction to epivizrStandalone

Héctor Corrada Bravo

#### 2025-10-29

# Contents

* [0.1 Launch Epiviz Desktop App](#launch-epiviz-desktop-app)

[`Epiviz`](http://epiviz.cbcb.umd.edu) is an interactive visualization tool for functional genomics data. It supports genome navigation like other genome browsers, but allows multiple visualizations of data within genomic regions using scatterplots, heatmaps and other user-supplied visualizations. You can find more information about Epiviz at <http://epiviz.cbcb.umd.edu/help> and see a video tour [here](http://youtu.be/099c4wUxozA).

This package, `epivizrStandalone`, makes it possible to run the web app UI locally completely within R. The `epivizr` package implements two-way communication between the `R/Bioconductor` computational genomics environment and `Epiviz`. Objects in an `R` session can be displayed as tracks or plots on Epiviz. Epivizr uses Websockets for communication between the browser Javascript client and the R environmen, the same technology underlying the popular [Shiny](http://www.rstudio.com/shiny/) system for authoring interactive web-based reports in R. See the `epivizr` package
vignette for more information on how to interact with the epiviz JS app.

Running the epiviz visualization app as a standalone allows it
to browse any genome of interest using Bioconductor infrastructure.
For example, to browse the mouse genome we would do the following.

```
library(epivizrStandalone)
library(Mus.musculus)

app <- startStandalone(Mus.musculus, keep_seqlevels=paste0("chr",c(1:19,"X","Y")), verbose=TRUE, use_viewer_option = TRUE)
```

## 0.1 Launch Epiviz Desktop App

There is also an epiviz desktop application based on the electron platform: <http://epiviz.org>. This package allows `epivizr` sessions to connect to the desktop app trough the
`startStandaloneApp` function. For example, we can start a
genome browser using the epiviz desktop app:

```
library(epivizrStandalone)
library(Mus.musculus)

app <- startStandaloneApp(Mus.musculus, keep_seqlevels=paste0("chr",c(1:19,"X","Y")), verbose=TRUE)
```

```
app$stop_app()
```