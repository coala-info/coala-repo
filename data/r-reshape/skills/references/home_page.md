[→home](../index.html)

## Related:

* [ggplot](../ggplot.html)

# Reshape

Reshape is an[R](http://www.r-project.org) package for flexibly restructuring and aggregating data. It is available on all platforms supported by R (Linux, OS X, Windows, ...). The current version is **0.8**.

Reshape (hopefully) makes it easy to do what you have been struggling to do with `tapply`, `by`, `aggregate`, `xtabs`, `apply` and `summarise`. It is also useful for getting your data into the correct structure for lattice or ggplot plots.

Along with [ggplot](../ggplot.html), reshape won the 2006 John Chambers Award for Statistical Computing. [ggplot](../ggplot.html) provides a new way of making plots in R, based on the grammar of graphics.

## How to install

Reshape is available from [CRAN](http://cran.r-project.org/) so you can install it using the following R command:

`install.packages("reshape")`

## Documentation

The best place to start is “[Reshaping data with the reshape package](http://www.jstatsoft.org/v21/i12)”, published in the journal of statistical software.

You might also be interested in the [slides](presentation-dsc2005.pdf) (pdf, 140k) and [paper](paper-dsc2005.pdf) (pdf, 260k) I presented at [Directions in Statistical Computing 2005](http://depts.washington.edu/dsc2005/). Please note that after the publication of this paper I changed `reshape` to `cast`, and `deshape` to `melt` to avoid a name conflict with base R. An updated version of this paper appeared in the [ASA Statistical Computing and Graphics Newsletter](http://stat-computing.org/newsletter/issues/scgn-16-2.pdf) (PDF).

In June 2006, I presented [Data checking with reshape and ggplot](../ggplot/2006-reisensburg.pdf.html) (PDF, 1.1 meg) and Reisensburg, Germany. You can also see the example code I used in the presentation: [R code](../ggplot/2006-reisensburg.r.html).

## Mailing list

You are welcome to ask reshape questions on R-help, but if you'd like to participate in a more focussed mailing list, please sign up for the manipulatr mailing list:

Your email address:

You must be a member to post messages, but anyone can [read the archived discussions](http://groups.google.com/group/manipulatr).

## Demos

Require [quicktime](http://apple.com/quicktime) to view.

* [Quick demo with french fries data](french-fries-demo.html)

## What's new in this version?

* `preserve.na` renamed to `na.rm` to be consistent with other R functions
* Column names are no longer automatically converted to valid R names. You may need to use `` to access these names.
* Margins now displayed with (all) instead of NA
* melt.array can now deal with cases where there are partial dimnames - Thanks to Roberto Ugoccioni
* Added the Smiths dataset to the package
* Fixed a bug when displaying margins with multiple result variables

See [the change log](changelog.html) for changes in previous versions

## What reshape doesn't do

Reshape is not a fully fledged [OLAP](http://en.wikipedia.org/wiki/OLAP) solution. If you need to deal with very large datasets, or want to do complex aggregations or use functions that process data from multiple levels, you should probably use a full OLAP product.

## Get involved

If you've discovered any bugs in the reshape package, or you have thought of a killer new feature, please email me: h.wickham@gmail.com. I'm also always on the look out for interesting data sets that reshape works well (or not so well) on.

© [Hadley Wickham](../index.html) 2015