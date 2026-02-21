# Authoring R Markdown vignettes

Andrzej Oleś1, Wolfgang Huber1 and Martin Morgan2

1European Molecular Biology Laboratory, Heidelberg, Germany
2Roswell Park Cancer Institute, Buffalo, NY

#### 29 October 2025

#### Abstract

Instructions on enabling *Bioconductor* style in R Markdown vignettes.

#### Package

BiocStyle 2.38.0

# 1 Prerequisites

*Bioconductor* R Markdown format is build on top of *R* package
*[bookdown](https://CRAN.R-project.org/package%3Dbookdown)* (Xie, Allaire, and Grolemund [2018](#ref-Xie2018)), which in turn relies on *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* and
[pandoc](http://johnmacfarlane.net/pandoc/) to compile the final output
document. Therefore, unless you are using RStudio, you will need a recent
version of [pandoc](http://johnmacfarlane.net/pandoc/) (>= 1.17.2). See the
[pandoc installation
instructions](https://github.com/rstudio/rmarkdown/blob/master/PANDOC.md) for
details on installing pandoc for your platform.

# 2 Getting started

To enable the *Bioconductor* style in your R Markdown vignette you need to:

* Edit the `DESCRIPTION` file by adding

  ```
    VignetteBuilder: knitr
    Suggests: BiocStyle, knitr, rmarkdown
  ```
* Specify `BiocStyle::html_document` or `BiocStyle::pdf_document` as output
  format and add vignette metadata in the document header:

  ```
    ---
    title: "Vignette Title"
    author: "Vignette Author"
    package: PackageName
    output:
      BiocStyle::html_document
    vignette: >
      %\VignetteIndexEntry{Vignette Title}
      %\VignetteEngine{knitr::rmarkdown}
      %\VignetteEncoding{UTF-8}
    ---
  ```

The `vignette` section is required in order to instruct *R* how to build the
vignette.111 `\VignetteIndexEntry` should match the `title` of your vignette The
`package` field which should contain the package name is used to print the
package version in the output document header. It is not necessary to specify
`date` as by default the document compilation date will be automatically
included. See the following section for details on specifying author
affiliations and abstract.

BiocStyle’s `html_document` and `pdf_document` format functions extend the
corresponding original *rmarkdown* formats, so they accept the same arguments as
`html_document` and `pdf_document`, respectively. For example, use `toc_float: true` to obtain a floating TOC as in this vignette.

## 2.1 Use with R markdown v1

Apart from the default markdown engine implemented in the
*[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)* package, it is also possible to compile *Bioconductor*
documents with the older markdown v1 engine from the package
*[markdown](https://CRAN.R-project.org/package%3Dmarkdown)*. There are some differences in setup and the resulting
output between these two engines.

To use the *[markdown](https://CRAN.R-project.org/package%3Dmarkdown)* vignette builder engine:

* Edit the `DESCRIPTION` file to include

  ```
    VignetteBuilder: knitr
    Suggests: BiocStyle, knitr
  ```
* Specify the vignette engine in the `.Rmd` files (inside HTML comments)

  ```
    <!--
    %% \VignetteEngine{knitr::knitr}
    -->
  ```
* Add the following code chunk at the beginning of your `.Rmd` vignettes

  ```
    ```{r style, echo = FALSE, results = 'asis'}
    BiocStyle::markdown()
    ```
  ```

The way of attaching CSS files when using *[markdown](https://CRAN.R-project.org/package%3Dmarkdown)* differs from
how this is done with *[rmarkdown](https://CRAN.R-project.org/package%3Drmarkdown)*. In the former case additional
style sheets can be used by providing them to the `BiocStyle::markdown`
function. To include `custom.css` file use

```
```{r style, echo = FALSE, results = 'asis'}
BiocStyle::markdown(css.files = c('custom.css'))
```
```

# 3 Document header

## 3.1 Author affiliations

The `author` field allows for specifying author names along with affiliation and
email information.

In the basic case, when no additional information apart from author names is
provided, these can be entered as a single character string

```
author: "Single Author"
```

or a list

```
author:
- First Author
- Second Author
- Last Author
```

which will print as “First Author, Second Author and Last Author”.

Author affiliations and emails can be entered in named sublists of the author
list. Multiple affiliations per author can be specified this way.

```
author:
- name: First Author
  affiliation:
  - Shared affiliation
  - Additional affiliation
- name: Second Author
  affiliation: Shared affiliation
  email: corresponding@author.com
```

A list of unique affiliations will be displayed below the authors, similar as in
this document.

For clarity, compactness, and to avoid errors, repeated nodes in YAML header can
be initially denoted by an anchor entered with an ampersand &, and later
referenced with an asterisk \*. For example, the above affiliation metadata is
equivalent to the shorthand notation

```
author:
- name: First Author
  affiliation:
  - &id Shared affiliation
  - Additional affiliation
- name: Second Author
  affiliation: *id
  email: corresponding@author.com
```

## 3.2 Abstract and running headers

Abstract can be entered in the corresponding field of the document front matter,
as in the example below.

```
---
title: "Full title for title page"
shorttitle: "Short title for headers"
author: "Vignette Author"
package: PackageName
abstract: >
  Document summary
output:
  BiocStyle::pdf_document
---
```

The `shorttitle` option specifies the title used in running headers instead of
the document title.222 only relevant to PDF output

# 4 Style macros

*[BiocStyle](https://bioconductor.org/packages/3.22/BiocStyle)* introduces the following macros useful when referring
to *R* packages:

* `Biocpkg("IRanges")` for *Bioconductor* software, annotation and
  experiment data packages, including a link to the release landing page or if the
  package is only in devel, to the devel landing page, *[IRanges](https://bioconductor.org/packages/3.22/IRanges)*.
* `CRANpkg("data.table")` for *R* packages available on CRAN,
  including a link to the FHCRC CRAN mirror landing page, *[data.table](https://CRAN.R-project.org/package%3Ddata.table)*.
* `Githubpkg("rstudio/rmarkdown")` for *R* packages available on
  GitHub, including a link to the package repository, *[rmarkdown](https://github.com/rstudio/rmarkdown)*.
* `Rpackage("MyPkg")` for *R* packages that are *not* available on
  *Bioconductor*, CRAN or GitHub; *MyPkg*.

These are meant to be called inline, e.g., `` `r Biocpkg("IRanges")` ``.

# 5 Code chunks

The line length of output code chunks is set to the optimal width of typically
80 characters, so it is not neccessary to adjust it manually through
`options("width")`.

# 6 Figures

## 6.1 Simple figures

*BiocStyle* comes with three predefined figure sizes. Regular figures not
otherwise specified appear indented with respect to the paragraph text, as in
the example below.

```
plot(cars)
```

![A default sized example figure without a caption.](data:image/png;base64...)

## 6.2 Figure captions

Figures which have no captions, like the one above, are just placed wherever they were generated in
the *R* code. If you assign a caption to a figure via the code chunk option
`fig.cap`, the plot will be automatically labeled and numbered333 for PDF output
it will be placed in a floating figure environment, and it will be also
possible to reference it. These features are provided by *[bookdown](https://CRAN.R-project.org/package%3Dbookdown)*,
which defines a format-independent syntax for specifying
cross-references, see Section [9](#cross-references). The figure label is
generated from the code chunk label444 for cross-references to work the chunk
label may only contain alphanumeric characters (a-z, A-Z, 0-9), slashes (/), or
dashes (-) by prefixing it with `fig:`, e.g., the label of a figure originating
from the chunk `foo` will be `fig:foo`. To reference a figure, use the syntax
`\@ref(label)`555 do not forget the leading backslash!, where `label` is the
figure label, e.g., `fig:foo`. For example, the following code chunk was used to
produce Figure [1](#fig:plot).

```
```{r plot, fig.cap = "Regular figure. The first sentence...", echo = FALSE}
plot(cars)
```
```

![Regular figure. The first sentence of the figure caption is automatically emphasized to serve as figure title.](data:image/png;base64...)

Figure 1: Regular figure
The first sentence of the figure caption is automatically emphasized to serve as figure title.

## 6.3 Alternative figure sizes

In addition to regular figures, *BiocStyle* provides small and wide figures
which can be specified by `fig.small` and `fig.wide` code chunk options. Wide
figures are left-aligned with the paragraph and extend on the right margin, as
Figure [2](#fig:wide). Small figures are meant for possibly rectangular plots
which are centered with respect to the text column, see Figure [3](#fig:small).

![Wide figure. A plot produced by a code chunk with option `fig.wide = TRUE`.](data:image/png;base64...)

Figure 2: Wide figure
A plot produced by a code chunk with option `fig.wide = TRUE`.

![Small figure. A plot produced by a code chunk with option `fig.small = TRUE`.](data:image/png;base64...)

Figure 3: Small figure
A plot produced by a code chunk with option `fig.small = TRUE`.

## 6.4 Accessibility considerations

Alt (alternative) text is used by screen readers to provide a description of an
image to visually impaired readers. If you provide a figure caption with
`fig.cap` the same text will automatically be used as the alt text for the
image. However, if you want to include an image without a caption, or you wish
to provide different information in the alt text to the caption, this can be
done via the `fig.alt` code chunk option. As an example, the code chunk below
was used to include the first image shown in this section, so that its intention
could be conveyed to someone using a screen reader.

```
```{r no-cap, fig.alt="A default sized example figure without a caption."}
plot(cars)
```
```

You may also want to consider the color palette used in your figures, to ensure
they are accessible to color impaired readers. *BiocStyle* doesn’t provide a
specific color palette, but many options are available in packages from CRAN.
There have also been [significant
efforts](https://developer.r-project.org/Blog/public/2019/11/21/a-new-palette-for-r/)
made to improve the default colors provided by `palette()` in R-4.0.0.
Bioconductor contains some domain specific packages that focus on color blind
friendly visualizations e.g. *[dittoSeq](https://bioconductor.org/packages/3.22/dittoSeq)* for single-cell and bulk
RNA-sequencing data.

# 7 Tables

Like figures, tables with captions will also be numbered and can be referenced.
The caption is entered as a paragraph starting with `Table:`666 or just `:`,
which may appear either before or after the table. When adding labels, make sure
that the label appears at the beginning of the table caption in the form
`(\#tab:label)`, and use `\@ref(tab:label)` to refer to it. For example, Table
[1](#tab:table) has been produced with the following code.

```
Fruit   | Price
------- | -----
bananas | 1.2
apples  | 1.0
oranges | 2.5

: (\#tab:table) A simple table. With caption.
```

Table 1: A simple table
With caption.

| Fruit | Price |
| --- | --- |
| bananas | 1.2 |
| apples | 1.0 |
| oranges | 2.5 |

The function `knitr::kable()` will automatically generate a label for a table
environment, which is the chunk label prefixed by `tab:`, see Table
[2](#tab:mtcars).

```
knitr::kable(
  head(mtcars[, 1:8], 10), caption = 'A table of the first 10 rows of `mtcars`.'
)
```

Table 2: A table of the first 10 rows of `mtcars`.

|  | mpg | cyl | disp | hp | drat | wt | qsec | vs |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| Mazda RX4 | 21.0 | 6 | 160.0 | 110 | 3.90 | 2.620 | 16.46 | 0 |
| Mazda RX4 Wag | 21.0 | 6 | 160.0 | 110 | 3.90 | 2.875 | 17.02 | 0 |
| Datsun 710 | 22.8 | 4 | 108.0 | 93 | 3.85 | 2.320 | 18.61 | 1 |
| Hornet 4 Drive | 21.4 | 6 | 258.0 | 110 | 3.08 | 3.215 | 19.44 | 1 |
| Hornet Sportabout | 18.7 | 8 | 360.0 | 175 | 3.15 | 3.440 | 17.02 | 0 |
| Valiant | 18.1 | 6 | 225.0 | 105 | 2.76 | 3.460 | 20.22 | 1 |
| Duster 360 | 14.3 | 8 | 360.0 | 245 | 3.21 | 3.570 | 15.84 | 0 |
| Merc 240D | 24.4 | 4 | 146.7 | 62 | 3.69 | 3.190 | 20.00 | 1 |
| Merc 230 | 22.8 | 4 | 140.8 | 95 | 3.92 | 3.150 | 22.90 | 1 |
| Merc 280 | 19.2 | 6 | 167.6 | 123 | 3.92 | 3.440 | 18.30 | 1 |

# 8 Equations

To number and reference equations, put them in equation environments and append
labels to them following the syntax `(\#eq:label)`777 due to technical constraints
equation labels must start with `eq:`, e.g.,

```
\begin{equation}
  f\left(k\right) = \binom{n}{k} p^k\left(1-p\right)^{n-k}
  (\#eq:binom)
\end{equation}
```

renders the equation below.

\[\begin{equation}
f\left(k\right) = \binom{n}{k} p^k\left(1-p\right)^{n-k}
\tag{1}
\end{equation}\]

You may then refer to Equation [(1)](#eq:binom) by `\@ref(eq:binom)`. Note that
in HTML output only labeled equations will appear numbered.

# 9 Cross-references

Apart from referencing figures (Section [6](#figures)), tables (Section
[7](#tables)), and equations (Section [8](#equations)), you can also use the
same syntax `\@ref(label)` to reference sections, where `label` is the section
ID. By default, Pandoc will generate IDs for all section headers, e.g., `# Hello World` will have an ID `hello-world`. In order to avoid forgetting to update the
reference label after you change the section header, you may also manually
assign an ID to a section header by appending `{#id}` to it.

When a referenced label cannot be found, you will see two question marks like
[**??**](#non-existing-label), as well as a warning message in the *R* console when
rendering the document.

# 10 Margin notes

Footnotes are displayed as side notes on the right margin888 this is a side note
entered as a footnote, which has the advantage that they appear close to the
place where they are defined.

# 11 Bibliography

If you wish to include a list of references you can use the special section title
`# References`999 it must be exactly this!, and provide a bibtex file in the vignette header.
A list of all references used in the text will be automatically
inserted after this heading. By default the references section will continue the
section level numbering used throughout the document. To suppress the numbering,
as seen in this vignette, you can use the Bookdown syntax for
[unnumbered sections](https://bookdown.org/yihui/rmarkdown-cookbook/unnumbered-sections.html)
e.g. `{-}` or `{.unnumbered}`.

Everything after the list of references will be considered as
appendices. See below for an example of the formatting change.

# References

Xie, Yihui, J. J. Allaire, and Garrett Grolemund. 2018. *R Markdown: The Definitive Guide*. Boca Raton, Florida: Chapman; Hall/CRC. <https://bookdown.org/yihui/rmarkdown>.

# Appendix

# A Session info

Here is the output of `sessionInfo()` on the system on which this document was
compiled running pandoc 2.7.3:

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
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] BiocStyle_2.38.0
##
## loaded via a namespace (and not attached):
##  [1] digest_0.6.37       R6_2.6.1            bookdown_0.45
##  [4] fastmap_1.2.0       xfun_0.53           magrittr_2.0.4
##  [7] cachem_1.1.0        knitr_1.50          htmltools_0.5.8.1
## [10] rmarkdown_2.30      tinytex_0.57        lifecycle_1.0.4
## [13] cli_3.6.5           sass_0.4.10         jquerylib_0.1.4
## [16] compiler_4.5.1      tools_4.5.1         evaluate_1.0.5
## [19] bslib_0.9.0         Rcpp_1.1.0          magick_2.9.0
## [22] yaml_2.3.10         BiocManager_1.30.26 jsonlite_2.0.0
## [25] rlang_1.1.6
```