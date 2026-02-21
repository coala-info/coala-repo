# Converting Rmarkdown to F1000Research LaTeX Format

Mike L. Smith

#### 29 October 2025

# Contents

* [1 Introduction](#introduction)
* [2 Citing this work](#citing-this-work)
* [3 Package installation](#package-installation)
* [4 Creating a new workflow document](#creating-a-new-workflow-document)
  + [4.1 Using RStudio and our template](#using-rstudio-and-our-template)
  + [4.2 Working outside RStudio](#working-outside-rstudio)
* [5 Converting to LaTeX and PDF](#converting-to-latex-and-pdf)
* [6 Article upload](#article-upload)
* [7 R session information](#r-session-information)
* [8 Acknowledgements and funding](#acknowledgements-and-funding)

# 1 Introduction

The intention of this package is to provide tools to assist in converting between Rmarkdown and LaTeX documents, specifically in the case where one is writing a workflow to be submitted to F1000Research, while hopefully also hosting a runable example on Bioconductor. Reaching these two endpoints while maintaining a single working document can be challenging. Submission to the journal requires a LaTeX file, which is best achieved by writing an Rnw workflow based on **Sweave** or **knitr**, while producing the html based versions hosted by Bioconductor is most easily achieved from an Rmarkdown document. Tools such as **pandoc** will allow conversion between many formats, but there is still a high degree of manual intervention required when aiming to meet the specific formatting requirements of a journal publication.

The current functionality assumes you have developed, or a planning to develop, a workflow in Rmarkdown, and aims to make the creation of a LaTeX document suitable for submission to F1000Research as straightforward as possible.

# 2 Citing this work

If you make use of **BiocWorkflowTools** please consider citing its accompanying publication in your acknowledgements:

Smith ML, Oleś AK, Huber W (2018).
“Authoring Bioconductor workflows with BiocWorkflowTools [version 1; referees: 2 approved with reservations].”
*F1000Research*, 431.
[doi:10.12688/f1000research.14399.1](https://doi.org/10.12688/f1000research.14399.1).

# 3 Package installation

Before we can begin you need to install the library.

```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install('BiocWorkflowTools')
```

# 4 Creating a new workflow document

## 4.1 Using RStudio and our template

The BiocWorkflowTools package comes with an example Rmd file based upon the LaTeX article template supplied by F1000Research. This defines the document structure for an F1000Research software article, and gives examples of how you can incorporate tables, figures and evaluated code in your Rmarkdown document. These examples have all been tested to ensure they can be converted to LaTeX using this package. If you are just starting out developing your workflow, this template is a good place to start.

The simplest way to access this is by working in the RStudio environment. From here you can select *File*, *New File*, *R Markdown* from the menu at the top of the screen. This will open a new window (seen in Figure [1](#fig:RStudioNew))

![Creation of a new article is integrated into RStudio.  The F1000Research template can be accessed via the 'new R Markdown document' menu option.](data:image/png;base64...)

Figure 1: Creation of a new article is integrated into RStudio
The F1000Research template can be accessed via the ‘new R Markdown document’ menu option.

From here you can select ‘*F1000Research Article*’ and specify both the name for your new document and the location it should be created in. Pressing *OK* will create a new sub-folder in this directory, which contains several files. The most important of these is the **.Rmd** file, which now contains the template document structure for you to begin working with. This file will have opened automatically in your RStudio session.

You will also find four other files in this folder. Two of these: **frog.jpg** and **sample.bib** are example files and are used to demonstrate how to include images and references in your document. It is safe to remove or edit them if you are comfortable with how this works. The remaining two files: **f1000\_styles.sty** and **F1000header.png** are required for the formatting of the final article PDF we will generate and should not be changed.

## 4.2 Working outside RStudio

If you don’t want to work in the RStudio environment, you can still use the included template to create a new file. The command below will create a folder named *MyArticle* within the current working directory, and this in turn will contain the template **MyArticle.Rmd** plus the four files mentioned in the previous section.

*In the code below the first two lines generate a temporary location we will use in this example. For your own workflow you will likely want to specify a location directly. If you do not provide an option here, the default is to use your current working directory*

```
tmp_dir <- tempdir()
setwd(tmp_dir)

rmarkdown::draft(file = "MyArticle.Rmd",
                 template = "f1000_article",
                 package = "BiocWorkflowTools",
                 edit = FALSE)
```

# 5 Converting to LaTeX and PDF

While you are writing your Rmarkdown document (and indeed once it is complete), you will probably want to view the journal formatted PDF version or obtain a LaTeX source for submission to the journal.

If you’re working in RStudio you can simply press the ‘Knit’ button at the top of the document pane. This will execute the code chunks, convert the document to LaTeX and then compile this into a PDF. All of these files are retained, and you will be able to find both the **.tex** and **.pdf** files in the same folder as the original **.Rmd**.

![The complete set of files.  After 'knitting' both the LaTeX source file and PDF documents can be found alongside your Rmarkdown file.](data:image/png;base64...)

Figure 2: The complete set of files
After ‘knitting’ both the LaTeX source file and PDF documents can be found alongside your Rmarkdown file.

Working outside RStudio, you can achieve the same result by using the command `render()` from the `rmarkdown` package e.g.

```
rmd_file <- file.path(tmp_dir, 'MyArticle', 'MyArticle.Rmd')
rmarkdown::render(input = rmd_file)
```

# 6 Article upload

Finally, we provide the function `uploadToOverleaf()` to upload the project directly to Overleaf (<http://www.overleaf.com>), the LaTeX authoring system F1000Research use for their submission process. This step is entirely optional, and the output created by the previous steps can be uploaded manually if you wish.

The only argument here is `files` to which you give the location of the directory containing your **.Rmd**, **.tex**, etc. files you have written. `uploadToOverleaf()` will compress the containing folder into a zip file, and submit this to Overleaf, opening a browser window pointing to the newly created project.

```
library(BiocWorkflowTools)
workflow_dir <- file.path(tmp_dir, 'MyArticle')
uploadToOverleaf(files = workflow_dir)
```

*From here you should find both the  and R Markdown versions of the article are present in the Overleaf project, with the first of these being rendered into the document preview one sees on the site. In the Overleaf environment, only changes to the  version will be reflected in the preview pane, rather than the R Markdown you have been working with now. It is entirely possible to edit the R Markdown here too, but within the Overleaf enviroment there is no way to regenerate the  version, and thus also the PDF. For these reasons we don’t recommend using Overleaf as an editor in this scenario, and rather only as the submission conduit.*

# 7 R session information

```
sessionInfo()
```

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
##  [4] fastmap_1.2.0       xfun_0.53           cachem_1.1.0
##  [7] knitr_1.50          htmltools_0.5.8.1   rmarkdown_2.30
## [10] lifecycle_1.0.4     cli_3.6.5           sass_0.4.10
## [13] jquerylib_0.1.4     compiler_4.5.1      tools_4.5.1
## [16] evaluate_1.0.5      bslib_0.9.0         yaml_2.3.10
## [19] BiocManager_1.30.26 jsonlite_2.0.0      rlang_1.1.6
```

# 8 Acknowledgements and funding

Funding for continued development and maintenance of this package is currently provided by the German Network for Bioinformatics Infrastructure (de.NBI) Förderkennzeichen Nr. 031A537 B.

![](data:image/jpeg;base64...)