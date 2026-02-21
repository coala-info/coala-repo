# Introduction to the microbiome R package

Leo Lahti, Sudarshan Shetty, et al.

#### 2025-10-30

# Contents

* [1 Introduction](#introduction)
* [2 Installation](#installation)
* [3 Further reading](#further-reading)
* [4 Acknowledgements](#acknowledgements)

# 1 Introduction

The [microbiome R package](http://microbiome.github.io/microbiome)
facilitates phyloseq-based exploration and analysis of taxonomic
profiling data. This vignette provides a brief overview with example
data sets from published microbiome profiling studies. A more
comprehensive tutorial is available
[on-line](http://microbiome.github.io/tutorials).

While we continue to maintain this R package, the development has been
discontinued as we have shifted to supporting methods development
based on the new TreeSummarizedExperiment data container, which
provides added capabilities for multi-omics data analysis. Check the
[miaverse project](https://microbiome.github.io/) for details.

In the microbiome R package, tools are provided for the manipulation,
statistical analysis, and visualization of taxonomic profiling
data. In addition to targeted case-control studies, the package
facilitates scalable exploration of population cohorts. Whereas sample
collections are rapidly accumulating for the human body and other
environments, few general-purpose tools for targeted microbiome
analysis are available in R. This package supports the independent
[phyloseq](http://joey711.github.io/phyloseq) data format and expands
the available toolkit in order to facilitate the standardization of
the analyses and the development of best practices.

We welcome bug reports from the user community via the [issue
tracker](https://github.com/microbiome/microbiome/issues) and [pull
requests](http://microbiome.github.io/microbiome/Contributing.html). See
the [Github site](https://github.com/microbiome/microbiome) for source
code and other details. These R tools are released under the
[Two-clause FreeBSD
license](http://en.wikipedia.org/wiki/BSD_licenses).

Kindly cite the work as follows: "Leo Lahti [et
al.](https://github.com/microbiome/microbiome/graphs/contributors)
(Bioconductor, 2017-2020). Tools for microbiome analysis in R. Microbiome
package version . URL:
(<http://microbiome.github.io/microbiome>)

# 2 Installation

Loading the package in R (after installation from Bioconductor):

```
library(microbiome)
```

# 3 Further reading

The [on-line tutorial](http://microbiome.github.io/microbiome)
provides many additional tools and examples, with more thorough
descriptions. This package and tutorials are work in progress. We
welcome feedback, for instance via [issue
Tracker](https://github.com/microbiome/microbiome/issues), [pull
requests](https://github.com/microbiome/microbiome/), or via
[Gitter](https://gitter.im/microbiome).

# 4 Acknowledgements

Thanks to all
[contributors](https://github.com/microbiome/microbiome/graphs/contributors).
Financial support has been provided by Academy of Finland (grants
256950 and 295741), [University of
Turku](http://www.utu.fi/en/Pages/home.aspx).

This work relies heavily on the independent
[phyloseq](https://github.com/joey711/phyloseq) package and data
structures for R-based microbiome analysis developed by Paul McMurdie
and Susan Holmes.