# Creating RDA objects

Sara Stankiewicz, Sara.Stankiewicz@channing.harvard.edu

#### October 19, 2022

Below are the instruction on how all the ontologies were transformed into RDA’s. If the ontology is in owl format it will need to be converted into an obo file. To do this download robot. Below is the link to the github repo that contains the robot tool. It is a tool for terminal so the following code must be run on the terminal.
<https://github.com/ontodev/robot>

Below is the link to the documentation for how to run robot.

<http://robot.obolibrary.org/convert>

```
robot reason --input [filename].owl convert --check false --output [filename].obo
```

For ontologies already in the obo format skip the first step and start here. Fill in all the [] with the appropriate directories / file names. For RDA the variable the [rdaName] is the nave of the file when loading into R .

```
directory = [directoryOfOboFiles]
rdaDirectory = [directoryForRDAFiles]
datafileName = [fileName].obo
rdaName = [rdaName].rda
datafile = paste0(directory,datafileName)
savefile = paste0(rdaDirectory, rdaName)
[rdaName] = get_OBO(datafile,  extract_tags = "everything")

save([rdaName], file = savefile, compress = "xz")
```

Session info

```
sessionInfo()
```

```
## R version 4.2.1 (2022-06-23)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 20.04.5 LTS
##
## Matrix products: default
## BLAS:   /home/biocbuild/bbs-3.16-bioc/R/lib/libRblas.so
## LAPACK: /home/biocbuild/bbs-3.16-bioc/R/lib/libRlapack.so
##
## locale:
##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C
##  [3] LC_TIME=en_GB              LC_COLLATE=C
##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8
##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C
##  [9] LC_ADDRESS=C               LC_TELEPHONE=C
## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C
##
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base
##
## other attached packages:
## [1] BiocStyle_2.25.0
##
## loaded via a namespace (and not attached):
##  [1] bookdown_0.29       digest_0.6.30       R6_2.5.1
##  [4] jsonlite_1.8.2      magrittr_2.0.3      evaluate_0.17
##  [7] stringi_1.7.8       cachem_1.0.6        rlang_1.0.6
## [10] cli_3.4.1           jquerylib_0.1.4     bslib_0.4.0
## [13] rmarkdown_2.17      tools_4.2.1         stringr_1.4.1
## [16] xfun_0.33           yaml_2.3.6          fastmap_1.1.0
## [19] compiler_4.2.1      BiocManager_1.30.18 htmltools_0.5.3
## [22] knitr_1.40          sass_0.4.2
```