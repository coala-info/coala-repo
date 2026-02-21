# RSP: A Brief Introduction
by Henrik Bengtsson, NA
Available on [CRAN](https://cran.r-project.org/package%3DR.rsp) since 2005 (first version ~2002):
```r
install.packages("R.rsp")
```
```r
> library("R.rsp")
> rcat("A random number: <%= sample(1:10, size = 1) %>")
A random number: 7
```
---
# Objectives
\* Dynamically generate documents and reports (and web/help pages).
\* Quickly turn your favorite static report template into a dynamic one.
\* Support \_all\_ formats, e.g. LaTeX, Markdown, HTML, ...
\* Supplement and/or complement Sweave, knitr, ...
\* Mix and match code and text however you want.
\* Simplify sharing of template and output documents.
\* Use for R package vignettes.
## Some usage
\* PSCBS: PDF reports of copy-number segmentation results
\* aroma-project.org: Interactive [Chromosome Explorer](http://aroma-project.org/data/reports/GSE8605/ACC,-XY,BPN,-XY,AVG,FLN,-XY,paired/ChromosomeExplorer.html) and [Array Explorer](http://www.aroma-project.org/data/reports/GSE8605/raw/ArrayExplorer.html)
---
# Compiling RSP document into PDF, HTML, ...
```r
> rfile("http://example.org/vignette.tex.rsp")
RspFileProduct:
Pathname: vignette.pdf
File size: 258.71 kB (264925 bytes)
Content type: application/pdf
Metadata 'title': 'Dynamic document creation using RSP'
Metadata 'keywords': 'Literate programming, HTML, PDF'
Metadata 'author': 'Henrik Bengtsson'
```
---
# Very simple idea: Translate RSP to R and evaluate
## 1. RSP document
```
Title: Example
Counting:<% for (i in 1:3) { %>
<%= i %>
<% } %>
```
## 2. R script
```r
cat("Title: Example\nCounting:")
for (i in 1:3) {
cat(" ")
cat(i)
}
```
## 3. RSP output
```
Title: Example
Counting: 1 2 3
```
---
# RSP Markup Language
## 1. RSP comments (`<%-- ... --%>`)
## 2. RSP preprocessing directives (`<%@ ... %>`)
## 3. RSP code expressions (`<% ... %>`)
---
# RSP Markup Language
## 1. RSP comments (`<%-- ... --%>`)
```
<%-----------------------------
Compile to PDF:
R.rsp::rfile("report.tex.rsp")
------------------------------%>
\documentclass{report}
...
```
RSP comments drop anything within, e.g. private notes, other RSP constructor (nested comments too) and will never be part of the output.
---
# RSP Markup Language
## 2. RSP preprocessing directives (`<%@ ... %>`)
### Including local and online files
```
<%@include file="http://example.org/QC.tex.rsp"%>
```
### Conditional inclusion
```
<%@ifeq version="devel"%>
<%@include file="templates/QA-devel.tex.rsp"%>
<%@else%>
Quality assessment is still under development.
<%@endif%>
```
### Meta data
```
<%@meta title="Example"%>
\hypersetup{pdftitle=<%@meta name="title"%>}
\title{<%@meta name="title"%>}
```
RSP preprocessing directives are independent of R, i.e. they would look the same with RSP for Python.
---
# RSP Markup Language
## 3. RSP code expressions (`<% ... %>`)
### Insert value of evaluated R expressions
```
<%= sample(1:100, size = 1) %>
```

### Code snippets - mixture of RSP and text
```
<% for (i in 1:3) { %>
Step <%= i %>.
<% } %>
```
---
# Looping over mixtures of code and text
```
<% fit <- segmentByPairedPSCBS(data) %>
\section{Segmentation results}
<% for (chr in 1:23) { %>
\subsection{Chromosome <%= chr %>}
<% fitT <- extractChromosome(fit, chr) %>
PSCBS identified <%= nbrOfSegments(fitT) %> segments
on Chr. <%= chr %>.
...
<% } # for (chr ...) %>
```

To achieve the same using noweb-style markup (e.g. Sweave and knitr) is tedious.
---
# RSP template functions
```
<%-- RSP TEMPLATES --%>
<% chromosomeSummary <- function(chr) { %>
<% fitT <- extractChromosome(fit, chr) %>
PSCBS identified <%= nbrOfSegments(fitT) %> segments
on Chr. <%= chr %>.
...
<% } %>
<%-- DOCUMENT --%>
...
<% for (chr in 1:23) { %>
\subsection{Chromosome <%= chr %>}
<% chromosomeSummary(chr) %>
<% } # for (chr ...) %>
```
---
# R.rsp package - RSP engine for R
## rcat() - RSP version of cat()
```r
> rcat("A random integer in [1,100]:
<%=sample(1:100, size = 1)%>\n")
A random integer in [1,100]: 77
```

## rsource() - RSP version of source()
Consider RSP file 'count.rsp' (think 'count.R'):
```
Counting:<% for (i in 1:10) { %>
<% Sys.sleep(0.3) %><%= i %>
<% } %>.
```
Running this RSP script gives:
```r
> rsource("count.rsp")
Counting: 1 2 3 4 5 6 7 8 9 10.
```
---
# rfile() - end-to-end compilation
```r
> rfile("report.md.rsp", args = list(n = 50, model = "L1"))
RspFileProduct:
Pathname: report.html
File size: 42.54 kB (43564 bytes)
Content type: text/html
```

```r
> rfile("http://example.org/vignette.tex.rsp")
RspFileProduct:
Pathname: vignette.pdf
File size: 258.71 kB (264925 bytes)
Content type: application/pdf
Metadata 'title': 'Dynamic document creation using RSP'
Metadata 'keywords': 'Literate programming, HTML, PDF'
Metadata 'author': 'Henrik Bengtsson'
```
---
# Including graphics (R.devices package)
RSP-embedded LaTeX
```
\includegraphics{<%= toPDF("MyFigure,yeah,cool", {
curve(dnorm, from = -5, to = +5)
}) %>}
```
generates the image file and outputs
```
\includegraphics{MyFigure,yeah,cool}
```
which appears as
![](data:image/png;base64...)
---
# Appendix
Session info:
```
R version 4.3.2 (2023-10-31)
Platform: x86\_64-pc-linux-gnu (64-bit)
Running under: Ubuntu 22.04.3 LTS
Matrix products: default
BLAS: /home/henrik/shared/software/CBI/\_ubuntu22\_04/R-4.3.2-gcc11/lib/R/lib/libRblas.so
LAPACK: /usr/lib/x86\_64-linux-gnu/lapack/liblapack.so.3.10.0
locale:
[1] LC\_CTYPE=en\_US.UTF-8 LC\_NUMERIC=C
[3] LC\_TIME=en\_US.UTF-8 LC\_COLLATE=C
[5] LC\_MONETARY=en\_US.UTF-8 LC\_MESSAGES=en\_US.UTF-8
[7] LC\_PAPER=en\_US.UTF-8 LC\_NAME=C
[9] LC\_ADDRESS=C LC\_TELEPHONE=C
[11] LC\_MEASUREMENT=en\_US.UTF-8 LC\_IDENTIFICATION=C
time zone: America/Los\_Angeles
tzcode source: system (glibc)
attached base packages:
[1] stats graphics grDevices utils datasets methods base
other attached packages:
[1] R.devices\_2.17.2 R.rsp\_0.46.0 R.oo\_1.26.0 R.methodsS3\_1.8.2
loaded via a namespace (and not attached):
[1] compiler\_4.3.2 tools\_4.3.2 base64enc\_0.1-4
[4] digest\_0.6.34 R.cache\_0.16.0 Cairo\_1.6-2
[7] R.utils\_2.12.3-9002
```
These slides were generated using `R.rsp::rfile()` in 0.06 secs.