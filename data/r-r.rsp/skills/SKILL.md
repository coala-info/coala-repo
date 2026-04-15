---
name: r-r.rsp
description: The R.rsp package implements the R Server Pages markup language to dynamically generate documents by embedding R code into any text-based format. Use when user asks to create dynamic reports, process RSP strings or files, set up R package vignettes, use preprocessing directives for conditional content, or loop over mixtures of R code and text blocks.
homepage: https://cloud.r-project.org/web/packages/R.rsp/index.html
---

# r-r.rsp

name: r-r.rsp
description: Expert guidance for the R.rsp package to dynamically generate scientific reports, vignettes, and documents using the RSP markup language. Use this skill when you need to: (1) Create dynamic reports in LaTeX, Markdown, or HTML, (2) Process RSP strings or files into final documents, (3) Set up R package vignettes (RSP, LaTeX, or static PDF/HTML), (4) Use RSP preprocessing directives for conditional inclusion or metadata management, or (5) Loop over mixtures of R code and text blocks.

# r-r.rsp

## Overview
The `R.rsp` package implements the RSP (R Server Pages) markup language, allowing R code to be embedded in any text-based document. Unlike other literate programming tools, RSP is content-independent and excels at complex workflows like looping over mixtures of code and text sections or using preprocessing directives to include external files and conditional content.

## Installation
Install the package from CRAN:
```r
install.packages("R.rsp")
```

## Core Functions
*   `rcat(text, ...)`: Processes an RSP string and outputs the result directly (like `cat()`).
*   `rstring(text, ...)`: Processes an RSP string and returns it as a character string.
*   `rsource(file, ...)`: Sources an RSP file as if it were an R script.
*   `rfile(file, ...)`: The primary high-level function. It parses, evaluates, and post-processes an RSP file into its final format (e.g., `.tex.rsp` to `.pdf`, `.md.rsp` to `.html`).

## RSP Markup Syntax
### Code Expressions
*   `<% ⟨code⟩ %>`: Evaluates R code without inserting output into the document. Useful for loops, logic, and variable assignments.
*   `<%= ⟨expression⟩ %>`: Evaluates an R expression and inlines the result as text.

### Preprocessing Directives
Directives start with `@` and are processed before R code evaluation.
*   `<%@include file="path/to/file"%>`: Includes the content of another file (local or URL).
*   `<%@meta name="key" content="value"%>`: Defines document metadata.
*   `<%@string name="var" content="val"%>`: Defines a preprocessing variable.
*   `<%@ifeq var="val"%> ... <%@else%> ... <%@endif%>`: Conditional inclusion of text/code.

### Comments and Trimming
*   `<%-- ⟨comment⟩ --%>`: RSP comments are dropped entirely from the output.
*   `<%-%>` or `<% ... -%>`: Trims the following whitespace and the first line break.

## Common Workflows
### Generating a PDF from LaTeX
```r
library(R.rsp)
# Processes report.tex.rsp -> report.tex -> report.pdf
rfile("report.tex.rsp")
```

### Looping Over Text Blocks
RSP allows you to wrap text in R loops easily:
```
<% for (i in 1:3) { %>
Iteration <%= i %>: The square root is <%= sqrt(i) %>.
<% } %>
```

### Creating Figures (with R.devices)
Use `toPDF()` or `toPNG()` from the `R.devices` package within RSP to automate figure generation and inclusion:
```latex
\includegraphics{<%= toPDF("my_plot", { plot(1:10) }) %>}
```

## R Package Vignettes
To use RSP for package vignettes, add the following to your `DESCRIPTION` file:
```
Suggests: R.rsp
VignetteBuilder: R.rsp
```

### RSP Vignette (.md.rsp or .tex.rsp)
Include these directives in your vignette source:
```
<%@meta language="R-vignette" content="
  %\VignetteIndexEntry{Vignette Title}
  %\VignetteEngine{R.rsp::rsp}
"%>
```

### Static PDF/HTML Vignette
Create a `.pdf.asis` (or `.html.asis`) file alongside your static file:
```
%\VignetteIndexEntry{Static Document Title}
%\VignetteEngine{R.rsp::asis}
```

## Reference documentation
- [Dynamic document creation using RSP](./references/Dynamic_document_creation_using_RSP.md)
- [RSP Introduction](./references/RSP_intro.md)
- [RSP Reference Card](./references/RSP_refcard.md)
- [R Packages: LaTeX Vignettes](./references/R_packages-LaTeX_vignettes.md)
- [R Packages: RSP Vignettes](./references/R_packages-RSP_vignettes.md)
- [R Packages: Static PDF and HTML Vignettes](./references/R_packages-Static_PDF_and_HTML_vignettes.md)